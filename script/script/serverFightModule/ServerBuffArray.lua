local CfgHelper = require 'CfgHelper'
local GHType = require 'GHType'
local EventCenter = require 'EventCenter'
local FightEvent = require 'FightEvent'

local BuffArrayClass = class()

function BuffArrayClass:ctor( owner )
	-- body
	self.buffarray = {}
	self.owner = owner
end

function BuffArrayClass:isAbnormalBuff( newbuff )
	-- body
	if newbuff then
		if newbuff:isPoison() then
			return true
		end
		if newbuff:isSlow() then
			return true
		end
		if newbuff:isFrozon() then
			return true
		end
		if newbuff:isBlind() then
			return true
		end
		if newbuff:isSleep() then
			return true
		end
	end
end

function BuffArrayClass:couldImmAbnormal()
	-- body
	if self.owner and self.owner.gb then
		local rate = self.owner.gb['n'] or 0
		return require 'Random'.ranF() < rate
	end
end


--[[
'imm', 'merge', 'add'
--]]
function BuffArrayClass:addBuff( newbuff )
	assert(newbuff)

	local buff = CfgHelper.getCache('buff','buffid',newbuff:getBasicId())
	local delay = false
	if #(buff.ghtypearray) > 0 and (table.find(buff.ghtypearray,GHType.GH_MaxHp) or table.find(buff.ghtypearray,GHType.GH_236)) then
		local index = 1
		for i,v in ipairs(buff.ghtypearray) do
			if v == GHType.GH_MaxHp  or v == GHType.GH_236 then
				index = i
			end
		end

		if buff.ghvaluearray[index] and buff.ghvaluearray[index] < 0 then
			local timeOut = TimeOut.new(0, function ()
				self:addBuff0(newbuff,nil,nil,buff)
			end)
			timeOut:start()
			delay = true
		end
	end

	return self:addBuff0(newbuff,nil,delay,buff)
end

function BuffArrayClass:addBuff0( newbuff,buff ,pre,dbbuff)
	-- body
	assert(newbuff)
	
	local buffid = newbuff:getBasicId()

	--是否免疫
	local isImmuned = false
	local array = CfgHelper.getCacheArray('immune_buff', 'immuned_buffid', buffid)
	
	if array then
		for i,immId in ipairs(array) do
			-- print('immId = '..immId)
			if self:findBuffByBasicId( immId.immune_buffid ) then
				isImmuned = true
				break
			end
		end
	end

	if not isImmuned then
		if self:isAbnormalBuff(newbuff) then
			if self:couldImmAbnormal() then
				isImmuned = true
			end
		end
	end

	if not isImmuned then
		local DisableBuffType = self:getDisableBuffType()
		isImmuned = DisableBuffType[dbbuff.BuffType]
	end
	
	if isImmuned then
		print('免疫生效!!')
		return 'imm'
	end

	local buff = buff or self:findBuffByBasicId(buffid)
	if buff then
		if not pre then
			self:checkToMakeBalls(newbuff)

			buff:merge(newbuff)
		end
		self:buffnotice(dbbuff,'merge')

		return 'merge'
	else
		if not pre then
			self:checkToMakeBalls(newbuff)

			newbuff:setOwner(self.owner)
			table.insert(self.buffarray, newbuff)

			self:newbuffAddNotice(newbuff,dbbuff)
			self:buffnotice(dbbuff,'add')
		end
		return 'add'
	end
end

function BuffArrayClass:checkToMakeBalls(newbuff)
	-- body
	local get1ball = newbuff:getValueByKey(GHType.GH_Get1Ball)
	if get1ball then
		--增加能量球
		local data = {}
		data.Hid = newbuff:getCarryData()

		debug.catch(data.Hid==nil, 'checkToMakeBalls')

		print('Make Kill Ball playerId = '..tostring(data.Hid))

		EventCenter.eventInput(FightEvent.Pve_MakeASkillBall, data)
	end

	--GHType.GH_MoreInitBalls = 46 --初始化对应能量球增加
	local getInitBalls = newbuff:getValueByKey(GHType.GH_MoreInitBalls)
	if getInitBalls then
		--增加能量球
		EventCenter.eventInput(FightEvent.Pve_MakeInitBalls, getInitBalls)
	end
end

--[[
如果存在 删除
--]]
function BuffArrayClass:remBuffById( buffid )
	-- body
	local buff = self:findBuffByBasicId(buffid)
	if buff then
		buff:setDisposed()
		return true
	end
	return false
end

function BuffArrayClass:findBuffByBasicId(buffid)
	-- body
	for i,v in ipairs(self.buffarray) do 
		if v:getBasicId() == buffid and not v:isDisposed() then
			return v
		end
	end
end

function BuffArrayClass:update( ticktime, owner  )
	-- body
	local size = #(self.buffarray)
	for i=size,1,-1 do
		local buff = self.buffarray[i]
		if buff:isDisposed() then
			table.remove(self.buffarray, i)
		else
			buff:tick( ticktime, owner )
		end
	end

	-- for i, v in ipairs(self.buffarray) do 
	-- 	if not v:isDisposed() then
	-- 		v:tick( ticktime, owner )
	-- 	end
	-- end
end

function BuffArrayClass:getValueByKey( key )
	-- body
	local min = nil
	local max = nil

	local DisableBuffType = self:getDisableBuffType()

	for i, v in ipairs(self.buffarray) do 
		if not v:isDisposed() then
			local l = v:getValueByKey(key) 
			if l and not DisableBuffType[v.BuffType] then
				-----------------------
				if not min then
					if l <= 0 then
						min = l
					end
				elseif min > l then
					min = l
				end

				if not max then
					if l >= 0 then
						max = l
					end
				elseif max < l then
					max = l
				end

			end
		end
	end

	if min and max then
		return (min + max)
	elseif min then
		return min
	elseif max then
		return max
	end
end

function BuffArrayClass:check()
	-- body
	local size = #(self.buffarray)
	for i=size,1,-1 do
		local buff = self.buffarray[i]
		if buff:isDisposed() then
			table.remove(self.buffarray, i)
		end
	end
end

--监听光环生效事件
function BuffArrayClass:newbuffAddNotice( newbuff,dbbuff )
	local kvmap = {
		{gh=GHType.GH_AwakeAtk_Add,cond=require 'SkillUtil'.Condition_GH28_Active},
		{gh=GHType.GH_203,cond=require 'SkillUtil'.Condition_32},
	}
	for i,v in ipairs(kvmap) do
		local value = newbuff:getValueByKey(v.gh)
		if value and value > 0 then
			local mydata = {
				conditiontype = true,
				openorclose = true,
				attacker = true,
				defenders = true,
				crit = true,
			}
			mydata.conditiontype = v.cond
			mydata.openorclose = true
			mydata.attacker = self.owner
			mydata.defenders = false
			mydata.crit = false

			EventCenter.eventInput(FightEvent.TriggerAbility, mydata)
		end
	end

end

function BuffArrayClass:buffnotice( dbbuff,type )
	EventCenter.eventInput('buffnotice',{buff=dbbuff,owner=self.owner,type=type})
end

function BuffArrayClass:getDisableBuffType( ... )
	local DisableBuffType = {[0]=false,[1]=false} 
	for i,v in ipairs(self.buffarray) do
		if not v:isDisposed() then
			local value = v:getValueByKey(GHType.GH_DisableUpBuff)
			if value and value > 0 then
				DisableBuffType[1] = true
			end
			value = v:getValueByKey(GHType.GH_201)
			if value and value > 0 then
				DisableBuffType[0] = true
			end
		end
	end
	return DisableBuffType
end

return BuffArrayClass