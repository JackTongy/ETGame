local AppData = require 'AppData'
local EventCenter = require 'EventCenter'
local GuideHelper = require 'GuideHelper'
local DBManager = require 'DBManager'
local Config = require 'Config'
--[[
	模块名及对应解锁信息见 UnlockConfig 
]]

local UnlockManager = {}

function UnlockManager:init( ... )

	self._guideCfgs 	= {}
	self._LvConfig		= {}
	self._IstepConfig 	= {}
	self._TownIdConfig	= {}
	self._Moudles		= {} --value 0:没有解锁 1:已解锁 2:在解锁动画中
	self._UnlockConditionMsg = {}
	self._StageIdConfig = {}

	local unlockcfg = require 'UnlockConfig'
	for i,v in ipairs(unlockcfg) do
		self._Moudles[v.name]=0
		if v.enable and v.enable > 0 and v.guidecfg then
			self._guideCfgs[v.name]=v.guidecfg
		end
		if v.unlocklv then
			self._LvConfig[v.name]=v.unlocklv
		end
		if v.msg then
			self._UnlockConditionMsg[v.name]=v.msg
		end
		if v.istep then
			self._IstepConfig[v.name]=v.istep
		end
		if v.townid then
			local towntype = 1
			local townid
			if type(v.townid) == 'string' then
				local args = string.split(v.townid,'|')
				towntype,townid = unpack(args)
				towntype = tonumber(towntype)
				townid 	 = tonumber(townid)
			else
				townid = v
			end
			self._TownIdConfig[v.name]={townid=townid,towntype=towntype}
		end
		if v.stageid then
			self._StageIdConfig[v.name]={stageid=v.stageid}
		end
	end

	-- print('guidecfg:')
	-- print(self._guideCfgs)
	-- print(self._LvConfig)
	-- print(self._IstepConfig)
	-- print(self._TownIdConfig)
	-- print(self._Moudles)
	-- print(self._UnlockConditionMsg)
	
	--等级解锁
	local lv = AppData.getUserInfo().getLevel()
	for k,v in pairs(self._Moudles) do
		if self._LvConfig[k] ~= nil then
			local unlock = self._LvConfig[k] <= lv
			self._Moudles[k]= (unlock and 1) or 0
		else
			print(string.format('%s has no UnlockLv Config',tostring(k)))
		end

	end

	--城镇解锁
	for k,v in pairs(self._TownIdConfig) do
		local nTownInfo = AppData.getTownInfo().getTownById(v.townid)

		if v.towntype == 2 then
			if nTownInfo and nTownInfo.SeniorClear then
				self._Moudles[k] = 1
			end
		elseif v.towntype == 1 then
			if nTownInfo and nTownInfo.Clear then
				self._Moudles[k] = 1
			end
		elseif v.towntype == 3 then
			if nTownInfo and nTownInfo.HeroClear then
				self._Moudles[k] = 1
			end
		end

	end

	--战斗关卡解锁

	--引导解锁
	local iStep = AppData.getUserInfo().getiStep()
	for k,v in pairs(self._IstepConfig) do
		if iStep >= v then
			self._Moudles[k] = 1
		end	
	end

	if require 'AccountHelper'.isItemOFF('PetName') then
		self._LvConfig.BossBattle = 100
	end
	self:initEventListener()
end

function UnlockManager:userLv( oldlv,newlv,checkmsg )
	local step = AppData.getUserInfo().getStep()
	local enable = step > 0 and step < newlv
	if oldlv < newlv or enable then
		for k,v in pairs(self._LvConfig) do
			if v == newlv and not self:isUnlock(k) then
				self:unlock(k)
				self:unlockGuide(newlv,k,checkmsg)
			end
		end
	end
end

function UnlockManager:TownPass( TownID ,isSenior,isHero)
	for k,v in pairs(self._TownIdConfig) do
		if v.townid == TownID and ((v.towntype == 2 and isSenior) or (v.towntype == 1 and not isSenior and not isHero)) then
			local nTownInfo = AppData.getTownInfo().getTownById(TownID)
			local dbTownInfo = DBManager.getInfoTownConfig(TownID)
			local guidename = self._guideCfgs[k]
			if v.towntype == 1 then
				if guidename and nTownInfo and nTownInfo.Clear and not nTownInfo.RewardGot and dbTownInfo.ClearReward ~= 0 then
					self:unlock(k)
					GuideHelper:startGuideIfIdle(guidename)
					GuideHelper:RecordGuide(guidename)
				end
			elseif v.towntype == 2 then
				if guidename and nTownInfo and nTownInfo.SeniorClear and not nTownInfo.RewardSeniorGot and dbTownInfo.ClearRewardSenior ~= 0 then
					self:unlock(k)
					GuideHelper:startGuideIfIdle(guidename)
					GuideHelper:RecordGuide(guidename)
				end
			end
		end
	end
end

function UnlockManager:stagePass( stageid )
	for k,v in pairs(self._StageIdConfig) do
		if v.stageid == stageid then
			self:unlock(k)
			local guidename = self._guideCfgs[k]
			if guidename then
				GuideHelper:startGuideIfIdle(guidename)	
				GuideHelper:RecordGuide(guidename)
			end
		end
	end
end

function UnlockManager:unlock( moudleName )
	if self._Moudles[moudleName] then
		self._Moudles[moudleName] = 2
		self:notifyUnlock(moudleName)	
	else
		print('can not found the moudle:'..tostring(moudleName))
	end
end

function UnlockManager:isUnlock( moudleName )

	if moudleName == 'PetKill' then
		return AppData.getBroadCastInfo().get("boss_down")
	end

	local v = (self._Moudles and self._Moudles[moudleName]) or 0
	return ( v and v >= 1 ) or false
end

function UnlockManager:needAnimtion( moudleName )
	local v = self._Moudles[moudleName]
	return (v and v == 2) or false
end

function UnlockManager:cancelAnimtion( moudleName )
	local v = self._Moudles[moudleName]
	if v and v == 2 then
		self._Moudles[moudleName] = 1
	end
end

--获取指定模块解锁条件的描述
function UnlockManager:getUnlockConditionMsg( moudleName )
	local v = self._LvConfig[moudleName]
	if v then
		return string.format(require "Res".locString("Activity$ActRaidToast"),v)
	elseif self._UnlockConditionMsg[moudleName] then
		return tostring(self._UnlockConditionMsg[moudleName])
	end
end

function UnlockManager:notifyUnlock( moudleName )
	EventCenter.eventInput('UnlockEvent',moudleName)
end

function UnlockManager:getUnlockLv( moudleName )
	return self._LvConfig[moudleName]
end

function UnlockManager:unlockGuide( newlv,moudleName,checkmsg )
	local guidecfg = self._guideCfgs[moudleName]
	if guidecfg then
		require 'GuideHelper':startUnlockGuideWithName(newlv,guidecfg,checkmsg)
	end
end

function UnlockManager:initEventListener( ... )
	EventCenter.resetGroup('UnlockManager')
	EventCenter.addEventFunc("OnBattleCompleted", function ( data )
		if data and data.isWin then
			local laststageid = require 'AppData'.getTownInfo().getLastBattleStageId()
			return laststageid and UnlockManager:stagePass(laststageid)
		end
	end, "UnlockManager")
end

--对应UnlockChannel.lua中的模块 是否开放  没有配置时默认为开放
function UnlockManager:isOpen( Name )
	local UnlockChannel = require 'UnlockChannel'

	local infoname = string.lower(Config.InfoName)
	for i,v in ipairs(UnlockChannel) do
		local tmp = {}
		for k1,v1 in pairs(v) do
			tmp[string.lower(k1)] = v1
		end
		print('tmp:')
		print(tmp)
		if v and v.name == Name and tmp[infoname] then
			return tmp[infoname] == 1
		end
	end

	return true
end

return UnlockManager