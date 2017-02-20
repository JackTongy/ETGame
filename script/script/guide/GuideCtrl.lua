local DBManager = require 'DBManager'
local Res = require 'Res'
local AppData = require 'AppData'
local EventCenter = require 'EventCenter'
local UnlockManager = require 'UnlockManager'
local netModel = require 'netModel'
local Utils = require 'framework.helper.Utils'

--[[
引导开发要点：
1.GuideCtrl 引导控制器
2.GuideConfig 引导配置表
	a.界面点击引导相关的所有坐标点
	b.引导场景的分类：(输入名字，普通剧情对话，引导点击区域(圆形)
	c.网络记录点 sp,恢复点设置 cp
3.DGuide 引导界面相关展示

]]

local GuideEnable = true
local DefaultGuideName = 'GCfg'
local DefaultGuideStep = 1
local DefaultGuideJoint = 1
local RecordFile = 'GuideRecord'
--[[
	GCfg 初始引导
	GCfg01 精灵觉醒引导
	GCfgUnlockLv%d 等级解锁引导
]]

local GuideCtrl = {}
--[[
	self._guideName 当前的引导名
	self._guideData 当前引导配置数据
	self._nowStep  当前所在步
	self._nowJoint 所在点
	self._isGuideDone 是否已完成
	self._dialog 
]]

function GuideCtrl:isGuideEnable( guidename )
	local cfg

	if guidename then
		cfg = DBManager.getGuideTrigger(guidename)
	end

	if not self:guideCondition(guidename) then
		return false
	end

	return cfg == nil or cfg.enable
end

function GuideCtrl:guideCondition( guidename )
	if guidename then
		if guidename == 'GCfg11' then --装备扭蛋 但有免费次数
			local NeData = require "LoginInfo".getData().Ne
			return NeData and NeData.Free
		elseif guidename == 'GCfg13' then --付费
			local vipitemon = not require 'AccountHelper'.isItemOFF('Vip')
			local viplv 	= require 'AppData'.getUserInfo().getVipLevel()
			local record 	= require "ItemMallInfo".getBuyRecord()  
			local buyvip0 	= record.Vips and table.find(record.Vips,0)
			return viplv == 0 and not buyvip0 and vipitemon
		end
	end

	return true
end

--开启指定的引导
function GuideCtrl:startGuide(guidename,step,joint,ServerStep,priority)
	local default = Utils.readTableFromFile('CTestLogin')
	if default then
		GuideEnable = default.Guide
	end

	if not GuideEnable then
		return
	end
	
	local requireMap = require 'RequireMap'
	if guidename ~= nil and not requireMap[guidename] then
		print('can not found the guideCfg:'..guidename)
		return
	end

	if not self:isGuideEnable(guidename) then
		print('guide is disable:'..tostring(guidename))
		return
	end

	guidename = guidename or DefaultGuideName
	step = step or DefaultGuideStep
	joint = joint or DefaultGuideJoint 

	if guidename == 'GCfg05' and not self:isRecorded('GCfg05') and self._guideName and self._guideName == 'GCfg' and self._guideData then
		local ret = self:insertING(guidename,self._guideData,self._nowStep,self._nowJoint+1)
		
		if ret then
			self:RecordGuide('GCfg05')
			-- print('!!!----------------')
			-- print(self._guideData)
			return false	
		end
	end

	if not self._isGuideDone and self._guideName and self._guideName ~= guidename then
		if priority then
			--插入一个运行优先级高的引导 将原先正在执行的引导压入下一个
			local ret = self:enQueue( self._guideName,self._nowStep,self._nowJoint,self._ServerStep,self._guideData)
			self._isGuideDone = true
		else
			--添加
			self:enQueue(guidename,step,joint,ServerStep,nil,true)
			return
		end
	end

	self:enQueue(guidename,step,joint,ServerStep)
	self:startNextGuide()
end

function GuideCtrl:startUnlockGuide( lv )
	local requireMap = require 'RequireMap'
	local guidename = string.format('GCfgUnlockLv%d',lv)
	if not requireMap[guidename] then
		return
	end

	self:startUnlockGuideWithName(lv,guidename)
end

function GuideCtrl:startUnlockGuideWithName(lv, guidename,checkmsg )
	print('startUnlockGuide:'..guidename)
	if lv then
		self:send(netModel.getRolePreStep(lv),function ( data )
			if data and data.D then
				AppData.updateResource(data.D.Resource)
			end
			self:startGuide(guidename,1,1,lv)		
			print('getRolePreStep:ok')
			if checkmsg then
				self:check(checkmsg)
			end
		end)	
	else
		self:startGuide(guidename,1,1)
	end
end

--根据当前的guidename,sp初始化
function GuideCtrl:init()

	self:visitGuideData(self._guideData, function (step,joint,v,v1 )
		if v1.CID then
			v1.Dialogue = DBManager.getDialogue(v1.CID)
		end
	end)				
end

function GuideCtrl:visitGuideData(guideData, callback )
	if guideData then
		for step,v in ipairs(guideData) do
			for joint,v1 in ipairs(v) do
				callback(step,joint,v,v1)
			end
		end
	end	
end
--检查并恢复当前引导的进度
function GuideCtrl:checkProgress()
	local SP = self:getLastSavePoint()
	print('SP:'..SP)
	if self._guideData and self._guideData.maxSP and self._guideData.maxSP <= SP then
		self:guideDone()
		return
	end

	if self._guideName ~= nil and self:isRecorded(self._guideName) then
		self:guideDone()
		return
	end

	self:visitGuideData(self._guideData, function (step,joint,v,v1 )
		if v1 and v1.CP and v1.CP == SP then
			self._nowStep = step
			self._nowJoint = joint
		end
	end)
	self:doRevert()
	self:doStep()
end

--恢复当前引导的进度
function GuideCtrl:doRevert()
	local stepData = self:getStepData()

	if stepData.Insert and self._guideData[stepData.Insert] then
      local insertT = self._guideData[stepData.Insert]
      insertT = table.clone(insertT)
      for i=#insertT,1,-1 do
        table.insert(self._guideData[self._nowStep],self._nowJoint,insertT[i])
      end
	elseif stepData.Replace and self._guideData[stepData.Replace] then
		table.remove(self._guideData[self._nowStep],self._nowJoint)
		local replaceT = self._guideData[joint.Replace]
		replaceT = table.clone(replaceT)
		for i=#replaceT,1,-1 do
			table.insert(step,self._nowJoint,replaceT[i])
		end
	end
end

--根据配置点插入引导步骤
function GuideCtrl:doLocCheck( ... )
	
	local stepData = self:getStepData()
	if stepData and stepData.adjust then
		local GetCurLoc = function ( ... )
			local curc = GleeControllerManager:getInstance():getRunningController()
			local name = curc:getControllerName()
			local before = GleeControllerManager:getInstance():getHistoryBefore(name)
			return name,before
		end

		local getAdjust = function ( before,adjusts )
			if before then
				for k,v in pairs(adjusts) do
					if before == v then
						return before
					end
				end
			end
			return adjusts[1]
		end

		local GCfgAdjust = require 'GCfgAdjust'
		local AdjustFunc = function ( guideData,step,joint,adjust)
			local curloc,before = GetCurLoc()
			if curloc and GCfgAdjust[curloc] then
				if type(adjust) == 'table' then
					for k,v in pairs(adjust) do
						if v == curloc then
							adjust = curloc
							break
						end
					end

					if type(adjust) == 'table' then

						adjust = getAdjust(before, adjust)
					end
				else
					if curloc == 'CTeam' and curloc ~= adjust and before and before ~= adjust then
						adjust = string.format('%s%s',before,adjust)
						print(string.format('cur:%s adjust:%s',curloc,adjust))
					end
				end

				local replaceT = GCfgAdjust[curloc][adjust]
				replaceT = table.clone(replaceT)
				if replaceT then
					table.remove(guideData[step],joint)
					for i=#replaceT,1,-1 do
						table.insert(guideData[step],joint,replaceT[i])
					end
				end
			else
				print('LocCheck controller name:'..name)	
			end
		end

		AdjustFunc(self._guideData,self._nowStep,self._nowJoint,stepData.adjust)
		-- print('doLocCheck:')
		-- print(self._guideData)
	end

end


--return true skip
function GuideCtrl:doCheckLayer( ... )
	local stepData = self:getStepData()
	if stepData and stepData.checkLayer then
		local layerManager = require "framework.interface.LuaLayerManager"
		if not layerManager.isRunning(tostring(stepData.checkLayer)) then
			return true
		end
	end
	return false
end

--数据指针 指向下一步引导
function GuideCtrl:getReadyForNextStep()
	local goToNextStep
	goToNextStep = function (  )
		self._nowStep = self._nowStep + 1
		self._nowJoint = 1
		if self._nowStep > #self._guideData then
			self:guideDone()
		elseif self._guideData[self._nowStep][self._nowJoint] == nil then
			goToNextStep()
		end
	end

	if self._guideData and not self._isGuideDone then
		local stepData = self._guideData[self._nowStep]
		if self._nowJoint == #stepData then
			goToNextStep()
		else
			self._nowJoint = self._nowJoint + 1
		end
	end
end
--取得当前数据指针 指向的引导数据
function GuideCtrl:getStepData()
	local stepData = nil
	if not self._isGuideDone and self._guideData then
		stepData = self._guideData[self._nowStep][self._nowJoint]

		if stepData then
			stepData.callback = function ( arg )
				self:dialogCallback(stepData,arg)
			end
		end
	end

	return stepData
end

--执行当前引导
function GuideCtrl:doStep()
	if not self._isGuideDone then
		local skip = false
		self:doLocCheck()
		skip = self:doCheckLayer()
		local stepData = self:getStepData()
		print('doStep:')
		print(stepData)
		if stepData.Dtype then
			self:showDialog(stepData)
		else
			self:CloseDialog()
		end
		self:doAction(stepData)
		skip = self:doEvent(stepData) or skip
		self:doUnlock(stepData)
		self:doRecord(stepData)
		self:showToast(stepData)
		if skip then
			self:doNextStep()
		end
	else
		print(string.format('Guide %s was Done!',self._guideName))
	end
end

--引导界面的回调：如剧情对话的下一步
function GuideCtrl:dialogCallback(stepData,arg)
	-- print('dialogCallback:')
	-- print(stepData)
	-- print(tostring(arg))
	if arg and arg == 'error' then
		self:guideDone()
		return
	end
	
	self:doNextStep()
end

--进行下一步
function GuideCtrl:doNextStep()
	print('doNextStep')
	local stepData = self:getStepData()
	if stepData and stepData._Done then
		print('doNextStep:重复')
		print(stepData)
		return
	else
		stepData._Done = true
		self:doRecordDes(stepData)
	end

	self:getReadyForNextStep()
	self:doStep()
end

--一些引导步骤需要相关确认如 进入到了指定的场景，完成了指定的网络请求
function GuideCtrl:check(action,arg,...)
	print('GuideCtrl:check:'..action)

	if not self._isGuideDone then
		local stepData = self:getStepData()

		-------
		if stepData and action and action == 'BattleEndLost' then
			if stepData.Action == 'BattleEnd' and stepData.SP == 1610 then
				local curjoint = self._nowJoint
				self._nowJoint = self._nowJoint - 3
				for i=self._nowJoint,curjoint do
					self._guideData[self._nowStep][i]._Done = false
				end
				self:doNextStep()
			end
		end

		if stepData and stepData.Action and stepData.Action == action then
			self:doNextStep()
		end			
	end
end
--当前引导完成
function GuideCtrl:guideDone(guidename)
	if guidename and guidename ~= self._guideName then
		return
	end

	self._isGuideDone = true
	self:CloseDialog()
	print(string.format('Guide %s is Done',tostring(self._guideName)))

	if self._ServerStep then
		self:sendBackGround(netModel.getRoleNewStepUpdate(self._ServerStep),function ( data )
			-- body
		end)
	end

	self:startNextGuide()

end

--当前是否在指定引导中
function GuideCtrl:inGuide(guidename)
	if guidename and self._guideName == guidename then
		return not self._isGuideDone
	end
	return false
end

function GuideCtrl:isGuideDone( ... )
	return self._isGuideDone
end

--有一些步骤是以action的形式存在，不依赖于外部模块
-- return true 处理完毕
function GuideCtrl:doAction(stepData)
	local Action = (stepData and stepData.Action) or nil
	local func = self._actionTable[tostring(Action)]
	if func then
		return func(self,stepData)
	end
	return false
end

function GuideCtrl:doEvent( stepData )
	local Event = (stepData and stepData.Event) or nil
	if Event then
		local eventfunc = self._eventTable[tostring(Event)]
		if eventfunc then
			eventfunc(self,stepData)
		else
			local errorcallback = function ( msg )
				print('GuideCtrl:doEvent')
				print('error:'..tostring(msg))
			end
			local func = function ( ... )
				EventCenter.eventInput(Event,stepData.EArg)
			end
			xpcall(func,errorcallback)
		end
	end
	return stepData.eventOnly
end

function GuideCtrl:doUnlock( stepData )
	local Unlock = (stepData and stepData.Unlock) or nil
	if Unlock then
		require 'UnlockManager':unlock(Unlock)
	end
end

function GuideCtrl:showToast( stepData )
	if stepData and stepData.toast then
		GleeCore:toast(tostring(stepData.toast))
	end	
end

--当前引导所设置的记录点
function GuideCtrl:getGuideCheckPoint()
	local stepData = self:getStepData()
	if stepData and stepData.SP then
		return tonumber(stepData.SP),stepData.Des
	end

	return nil
end

function GuideCtrl:getGuideNetCheck( ... )
	local stepData = self:getStepData()
	return stepData and stepData.netcheck
end

--取得上一次的引导记录点，所有的引导记录点都是在同一条线上的
function GuideCtrl:getLastSavePoint()
	local userinfo = AppData.getUserInfo()
	return userinfo.getiStep()
end

--显示引导界面
function GuideCtrl:showDialog(stepData)
  if self._dialog == nil then
    GleeCore:showLayer('DGuide')
    local layerManager = require "framework.interface.LuaLayerManager"
    self._dialog = layerManager.getRunningLayer('DGuide')
  end

  self._dialog:updateLayer(stepData)  
end

--关闭引导界面
function GuideCtrl:CloseDialog()
  if self._dialog then
  	self._dialog:close()
  	self._dialog = nil
  end
end

function GuideCtrl:send( data, callback, errcallback,delay,timeout, ptype,flag )
	local client = client or require 'SocketClient'
	client.send0( data, callback, errcallback,delay,timeout, ptype,flag)
end

function GuideCtrl:sendBackGround(data, callback, errcallback,delay,timeout, ptype,flag )
	self:send( data, callback, errcallback,delay,timeout, ptype,false)
end

--Action table
function GuideCtrl:initActionTable( ... )
	if self._actionTable == nil then
		self._actionTable = {
			['selectRole'] = self.actionSelectRole,
			['BossBattleStart'] =  self.BossBattleAuto
		}
	end
end

function GuideCtrl:initEventTable( ... )
	self._eventTable = {
		['closeAllLayer'] = self.closeAllLayer
	}
end

function GuideCtrl:registerActionFuc( Action,func )
	if self._actionTable then
		self._actionTable[Action] = func
	end
end

function GuideCtrl:actionSelectRole( ... )
	-- GleeCore:showLayer('DRoleSelect')
	GleeCore:showLayer('DGuidePetSelect')
	return true
end

function GuideCtrl:BossBattleAuto( stepData )
	--[[
	if require 'FightConfig'.Auto_AI then
		--已开启自动战斗时，省去中间引导自动的step
		if stepData and stepData.CP == 1610 then
			self._nowJoint = self._nowJoint + 4
			if self._guideData[self._nowStep][self._nowJoint+1] then
				stepData.CP = nil
				self._guideData[self._nowStep][self._nowJoint+1] = stepData
			end
			self:doNextStep()
		end
	end
	]]
end

function GuideCtrl:closeAllLayer( stepData )
	GleeCore:closeAllLayers({Menu=true,guideLayer=true})
	return true
end

--各个引导的队列控制
function GuideCtrl:startNextGuide( )
	local guide = self:deQueue()
	print('startNextGuide:')
	print(guide)
	if (self._isGuideDone == nil or self._isGuideDone) and guide then
		self._guideName = guide.guidename
		self._nowStep = guide.step
		self._nowJoint = guide.joint
		self._ServerStep = guide.serverstep
		self._isGuideDone = false
		self:CloseDialog()
		if guide.guideData == nil then
			self:initActionTable()
			self:initEventTable()
			self._guideData = require (self._guideName)
			self._guideData = table.clone(self._guideData)
			self:init()
			self:checkProgress()
		else
			self._guideData = guide.guideData
		end
	elseif self._isGuideDone and guide == nil then
		self:reset()
	end
end

function GuideCtrl:reset( ... )
	-- self._guideName = nil
	self._guideData = nil
	self._nowStep = nil
	self._nowJoint = nil
	self._isGuideDone = true
	self._Queue = nil
	self:CloseDialog()
end

function GuideCtrl:insertING( guidename,guideData,step,joint )
	local guidedata = require(guidename)
	local insertT = guidedata[1]
	self:visitGuideData(guidedata, function (step,joint,v,v1 )
		if v1.CID then
			v1.Dialogue = DBManager.getDialogue(v1.CID)
		end
	end)
	insertT = table.clone(insertT)
	for i=step,#guideData do
		for j=joint,#guideData[i] do
			local v = guideData[i][j]
			if v.Ing then
				for x=#insertT,1,-1 do
					if insertT[x].Record then
						insertT[x].Record = false
					end
					table.insert(guideData[i],j,insertT[x])
				end
				return true
			end
		end
	end
	return false
end

--返回true 插入成功
function GuideCtrl:enQueue( guidename,step,joint,ServerStep,guideData,inserthead)
	
	if self._Queue == nil then
		self._Queue = {}
	end
	for k,v in pairs(self._Queue) do
		if v.guidename == guidename then
			print('already in Guide Queue!')
			return
		end
	end
	if inserthead then
		table.insert(self._Queue,1,{guidename=guidename,step=step,joint=joint,serverstep=ServerStep,guideData=guideData})
	else
		table.insert(self._Queue,{guidename=guidename,step=step,joint=joint,serverstep=ServerStep,guideData=guideData})
	end
	
	return true
end

function GuideCtrl:deQueue( ... )
	local guide = self._Queue[#self._Queue]
	if guide then
		table.remove(self._Queue,#self._Queue)
	end
	return guide
end

--本地只引导一次的记录
function GuideCtrl:isRecorded( guidename )
	if guidename then
		local records = Utils.readTableFromFile(RecordFile) or {}
		local key = self:getRecordKey(guidename)
		return records[key]
	end
end

function GuideCtrl:doRecord( stepData )
	if stepData and stepData.Record then
		local records = Utils.readTableFromFile(RecordFile) or {}
		local key = self:getRecordKey(self._guideName)
		records[key] = true
		Utils.writeTableToFile(records,RecordFile)
	end
end

function GuideCtrl:RecordGuide( guidename )
	local records = Utils.readTableFromFile(RecordFile) or {}
	local key = self:getRecordKey(guidename)
	records[key] = true
	Utils.writeTableToFile(records,RecordFile)
end

function GuideCtrl:getRecordKey( guidename )
	local userid = AppData.getUserInfo().getId()
	return string.format('%s:%s',tostring(guidename),tostring(userid))
end

--记录玩家具体引导名
function GuideCtrl:doRecordDes( stepData )
	if stepData and stepData.Des and not stepData.SP then
		self:recordGuideStepDes(stepData.Des)
	end
end

function GuideCtrl:recordGuideStepDes( Des )
	local m = netModel.getRoleNewStepUpdate()
	m.Ex = {Des=Des}
	m.D={u=1}
	self:sendBackGround(m,function ( data )
		--print(Des)
	end)
end

return GuideCtrl