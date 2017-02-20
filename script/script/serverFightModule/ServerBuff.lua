local Random 		= require 'Random'
local EventCenter 	= require 'EventCenter'
local FightEvent 	= require 'FightEvent'
local CfgHelper 	= require 'CfgHelper'
local GHType 		= require 'GHType'

-- GHType.GH_Poison = 1 --中毒异常
-- GHType.GH_Blind = 2 --致盲异常
-- GHType.GH_Frozen = 3 --冻结异常
-- GHType.GH_Sleep = 4 --昏睡异常
-- GHType.GH_Slow = 5 --缓速异常

local BuffClass = class()

-- [1] = {	buffid = 1,	buffdes = "攻击力增加2%",	ghtypearray = {11},	ghvaluearray = {0.02},	duration = 0,	interval = 0,	triggertimes = 0,	triggertype = 0,	triggervalue = 0,	model_id = 0,	layer = 0,},

function BuffClass:ctor( args, skill, one, another, manaRate )
	-- body
	assert(args)

	self.serverskill 		= skill
	self.buffid 			= args.buffid
	self.triggertype 		= args.triggertype
	self.triggervalue 		= args.triggervalue
	self.buffstate 			= 'running'

	if self.triggertype == 3 then
		self.bufflife 			= args.duration
	else
		self.bufflife 			= args.duration * manaRate
	end
	
	self.buffinterval 		= args.interval or 0
	self.buffhastriggered 	= 0
	self.buffprogress 		= 0
	self.owner 				= nil

	self.datamap = {}

	-- 0 治疗是否要显示
	self.curezero 			= args.curezero

	for i,v in ipairs( args.ghtypearray or {} ) do
		self.datamap[v] = args.ghvaluearray[i]
	end

	self.mergeCount 		= 1
	self.additivity 		= (args.Additivity == 1)
	self.bufftype 			= args.BuffType
-- GHType.GH_Poison 	= 1 --中毒异常
-- GHType.GH_Blind 		= 2 --致盲异常
-- GHType.GH_Frozen 	= 3 --冻结异常
-- GHType.GH_Sleep 		= 4 --昏睡异常
-- GHType.GH_Slow 		= 5 --缓速异常

	if self.datamap[GHType.GH_Poison] then
		self.poisonAdd = (one.gb['a'] or 0) - (another.gb['b'] or 0)
		self.bufflife  = self.bufflife * (1 - (another.eb['14'] or 0))
		self.bufflife  = math.max(0,self.bufflife)
	end

	if self.datamap[GHType.GH_Blind] then
		self.bufflife = self.bufflife + ((one.gb['e'] or 0) - (another.gb['f'] or 0))
		self.bufflife = self.bufflife * (1 - (another.eb['16'] or 0))
		self.bufflife = math.max(0, self.bufflife)
	end

	if self.datamap[GHType.GH_Frozen] then
		self.bufflife = self.bufflife + ((one.gb['g'] or 0) - (another.gb['i'] or 0))
		self.bufflife = self.bufflife * (1 - (another.eb['13'] or 0))
		self.bufflife = math.max(0, self.bufflife)
	end

	if self.datamap[GHType.GH_Slow] then
		self.datamap[GHType.GH_Slow] = self.datamap[GHType.GH_Slow] * (1 + (one.gb['c'] or 0) - (another.gb['d'] or 0))
		
		if self.datamap[GHType.GH_Spd] then
			self.datamap[GHType.GH_Spd] =  math.min(self.datamap[GHType.GH_Spd] - (one.gb['c'] or 0) + (another.gb['d'] or 0), 0)
		end
		self.bufflife = self.bufflife * (1 - (another.eb['15'] or 0))
		self.bufflife  = math.max(0,self.bufflife)
	end

	if self.buffinterval > 0 then
		self.bufftriggertimes = math.floor(self.bufflife / self.buffinterval)
	else
		self.bufftriggertimes = 0
	end

	if self.buffinterval <= 0 then
		-- 100000秒的间隔时间
		self.buffinterval = 100000
	end

	self.one 				= one
	self.another 			= another

	-- self.owner 				= one

	-- 
	if self.triggertype == 1 then
		local moreHeal = (another and another:getBuffArray():getValueByKey(GHType.GH_MoreHeal) or 0)
		moreHeal = moreHeal + (another and another:getBuffArray():getValueByKey(GHType.GH_96) or 0)
		--回复量增大
		self.triggervalue = self.triggervalue * (1 + moreHeal)
	end

	if self.triggertype == 3 then
		self:printBuff()
	end
	
--[[
	self.hpR 	= args.hpR or 0		--回复加成, 来自装备	
	self.gb 	= args.gb or {}		--宝石对宠物Buff效果的影响,   光环的map????
	
	a.中毒附加伤害
	b.减少中毒伤害

	c.提高缓速效果
	d.减少缓速效果

	e.提高致盲时间
	f.减少致盲时间

	g.提高冰冻时间
	h.提高冰冻伤害

	i.减少冰冻时间
	j.减少冰冻伤害
	
	k.属性增强比例 ----- 增加怒气回复
	l.属性抗性比例 ----- 减少技能伤害
	


	l.属性抗性比例 草
	m.属性抗性比例 电
	n.属性抗性比例 水
	o.属性抗性比例 岩
	p.属性抗性比例 火
--]]

end

function BuffClass:setCarryData( carryData )
	-- body
	self._carryData = carryData
end

function BuffClass:getCarryData()
	-- body
	return self._carryData
end

function BuffClass:getBasicId()
	-- body
	return self.buffid
end

function BuffClass:copy( newBuff )
	-- body
	assert(newBuff)

	self.triggertype 				= newBuff.triggertype
	self.triggervalue 				= newBuff.triggervalue
	self.buffstate 					= 'running'
	self.bufflife 					= newBuff.bufflife
	self.buffinterval 				= newBuff.buffinterval
	self.buffhastriggered 			= 0
	self.buffprogress 				= 0

	self.poisonAdd 					= newBuff.poisonAdd
	self.datamap[GHType.GH_Slow] 	= newBuff.datamap[GHType.GH_Slow]
end

function BuffClass:printBuff()
	-- body
	local str = string.format([[
		owner=%s,another=%s,buffid=%s,
		life=%s,progress=%s,
		hastriggered=%s,interval=%s,triggertimes=%s
		]],  
		tostring(self.owner and self.owner:getDyId()), tostring(self.another and self.another:getDyId()), tostring(self.buffid),
		tostring(self.bufflife), tostring(self.buffprogress),
		tostring(self.buffhastriggered), tostring(self.buffinterval), tostring(self.bufftriggertimes)
		 )

	print(str)
end

function BuffClass:merge( newBuff )
	assert(newBuff)

	assert(not self:isDisposed() and not newBuff:isDisposed())
	-- body
	-- 时间延长

	------中毒, 效果 覆盖
	------缓速, 效果 覆盖
	------回血, 效果 覆盖
	------致盲, 时间 覆盖
	------冻结, 时间 覆盖
	------其他, 时间 覆盖

	if self:isPoison() then
		if self.poisonAdd <= newBuff.poisonAdd then
			self:copy(newBuff)
		end
	elseif self:isSlow() then
		if self.datamap[GHType.GH_Slow] <= newBuff.datamap[GHType.GH_Slow] then
			self:copy(newBuff)
		end
	elseif self:isHeal() then
		if self.triggervalue <= newBuff.triggervalue then
			self:copy(newBuff)
		end
	else
		-- 时间覆盖
		if self.bufflife - self.buffprogress < newBuff.bufflife then
			self:copy(newBuff)
		end
	end

	if self.additivity then
		self.mergeCount = self.mergeCount + 1
	end
end

--[[
GHType.GH_Poison 	= 1 --中毒异常
GHType.GH_Blind 	= 2 --致盲异常
GHType.GH_Frozen 	= 3 --冻结异常
GHType.GH_Sleep 	= 4 --昏睡异常
GHType.GH_Slow 		= 5 --缓速异常
--]]


function BuffClass:isPoison()
	-- body
	return self.triggertype == 2
end

function BuffClass:isSlow()
	-- body
	return self:getBasicValueByKey(GHType.GH_Slow)
end

function BuffClass:isFrozon()
	-- body
	return self:getBasicValueByKey(GHType.GH_Frozen)
end

function BuffClass:isBlind()
	-- body
	return self:getBasicValueByKey(GHType.GH_Blind)
end

function BuffClass:isSleep()
	-- body
	return self:getBasicValueByKey(GHType.GH_Sleep)
end

function BuffClass:isHeal()
	-- body
	return self.triggertype == 1 or self.triggertype == 3
end


function BuffClass:getBasicId()
	-- body
	return self.buffid
end

function BuffClass:setOwner( hero )
	-- body
	assert(self.owner == nil)
	self.owner = hero
end

function BuffClass:isDisposed()
	-- body
	return self.buffstate == 'dead'
end

-- setDisposed
function BuffClass:setDisposed()
	-- body
	if self.owner and not self:isDisposed() then
		self.buffstate = 'dead'
--推送
-- 		Rbuff
-- 数据
-- 参数 类型 说明
-- Id Int BuffId
-- Hid Int 英雄 Id

		local id = self.buffid
		local hid = self.owner:getDyId()
		local data = { D = { Id = id, Hid = hid, Speed = self.owner:getSpeed() } }

		-- print(debug.traceback())
		-- print('self.bufflife = '..self.bufflife)

		print('PVE-Server Buff: Disposed')
		print( string.format('Role=%d, Buff=%d removed!', self.owner:getDyId(), self.buffid) )
		print(data)
		
		EventCenter.eventInput(FightEvent.Pve_RemoveBuff, data )
		
		self.owner = nil
		self.datamap = nil
		
		if self.buffid == 1000 then
			self.serverskill:invalid()
		end
	end
end

function BuffClass:getTriggerTimesByProgress( progress )
	progress = math.min(progress, self.bufflife) 
	local times = math.floor(progress / self.buffinterval) + 1
	return times
end

--[[
args = owner
--]]

function BuffClass:tick( ticktime, args )
	-- body
	if self:isDisposed() then
		return
	end

	assert(ticktime)

	local life = self.bufflife
	local progress = self.buffprogress + ticktime
	local count = self:getTriggerTimesByProgress(progress)

	--缓速缩短时间,如果存在缓速光环
	if self:getValueByKey(GHType.GH_Slow) then
		-- GH_SlowLastLess
		local slowLastLess = (self.owner:getBuffArray():getValueByKey(GHType.GH_SlowLastLess) or 0)
		life = life * (1 - slowLastLess)
	end

	if count > self.buffhastriggered then
		for i=self.buffhastriggered,count-1 do
			self:trigger(args)
		end

		self.buffhastriggered = count
	end

	self.buffprogress = progress

	if progress >= life then
		-- self:onExit(args)
		self:setDisposed()
	end

end

function BuffClass:trigger()
	-- body
	local hpD

	-- assert(self.buffid ~= 507)

	if self.triggertype == 1 then
		--加血
		local basichpD = self.owner:getBasicHpD()
		local currentHpD = self.owner:getHpD()

		--回复量增大
		local gh243 = (self.owner:getBuffArray():getValueByKey( GHType.GH_243 ) or 0)
		hpD = basichpD * self.triggervalue*(1-gh243)

		hpD = math.min(hpD, (basichpD-currentHpD))
		hpD = math.max(hpD, 0)
		
		----buff 死亡的不统计
		self.owner:onHpChange( hpD, nil )
		print('最大血量='..basichpD)
		print('回复比例='..self.triggervalue)
		print('最终回复比例='..self.triggervalue*(1-gh243))
		-- print('光环增益='..moreHeal)
		print('回复血量='..hpD)

		if hpD == 0 and self.curezero == 0 then
			hpD = nil
			print('不显示+0')
		end

	elseif self.triggertype == 2 then
		-- 扣血
		-- 考虑 中毒免疫
		hpD = -(300 + self.poisonAdd)
		hpD = math.min(hpD, -1)

		self.owner:onHpChange(hpD, nil)

		print('中毒扣血='..(hpD))

	elseif self.triggertype == 3 then
		-- 大招持续性回血
		local basichpD = self.owner:getBasicHpD()
		local currentHpD = self.owner:getHpD()
		hpD = require 'DamageFormula'.calc(self.one, self.another, self.serverskill:getBasicId(), false, 1)
		hpD = math.min(hpD, (basichpD-currentHpD))
		hpD = math.max(hpD, 0)

		self.owner:onHpChange(hpD,nil)
		print('大招持续加血='..(hpD))

		self:printBuff()
	elseif self.triggertype == 4 then
		-- printlua('触发时增加或减少目标的怒气值')
		-- printlua(tostring(self.triggervalue))
		--触发时增加或减少目标的怒气值 （绝对数值，非百分比）
		local oldlock = self.owner:getManaLocked()
		self.owner:setManaLocked(false)
		self.owner:addMana(self.triggervalue or 0)
		self.owner:setManaLocked(oldlock)
	elseif self.triggertype == 5 then
		hpD = -(self.triggervalue)
		hpD = math.min(hpD,-1)
		self.owner:onHpChange(hpD,nil)
		print('triggertype 5 扣血='..(hpD))
	end

	if ( self.triggertype == 1 or self.triggertype == 2 or self.triggertype == 3 ) then

		local data = {
			Id = true,
			Hid = true,
			Speed = true,
			HpD = true,
			HpP = true,
			TriggerFlag = true,
		} 

		data.Id 			= self:getBasicId()
		data.Hid 			= self.owner:getDyId()
		data.Speed 			= self.owner:getSpeed()
		data.HpD 			= hpD
		data.HpP 			= self.owner:getHpP()
		data.TriggerFlag 	= true
		
		local bb = { D = { Vs = {data} } }
		-- 推送
		EventCenter.eventInput( FightEvent.Pve_Buff, bb )

	end
end

function BuffClass:getValueByKey( key )
	-- body
	assert(key)

	local v = self:getBasicValueByKey( key )
	if v then
		return v * self.mergeCount
	end
end

function BuffClass:getBasicValueByKey( key )
	-- body
	assert(key)

	local v = self.datamap[key]
	return v
end

--[[
--]]
local factory = {}

function factory.createBuff( buffid , skill, one, another, manaRate)
	-- body
	local args = CfgHelper.get('buff', 'buffid', buffid)
	return BuffClass.new(args, skill, one, another, manaRate)
end

return factory
