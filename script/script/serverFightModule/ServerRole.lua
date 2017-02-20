--[[
平砍伤害=(角色攻击+被动技能加成)/10 *Ran.next（95,105）/100* (1-0.01*敌人防御/(5+0.01*敌人防御)*0.7)*属性相克系数*（1-属性免疫比例*(针对特定属性类型怪物伤害)

暴击伤害=平砍伤害*（暴击系数%+某些被动技能对暴击的影响%）

技能伤害=平砍伤害*（主动技能系数%+某些被动技能对技能伤害的影响%+连锁系数%）*（1+角色觉醒阶数对主动伤害的加成百分比）

远程平砍=平砍伤害 *双方影响远程伤害的被动技能%*远程守护系数
远程暴击=暴击伤害 *双方影响远程伤害的被动技能%*远程守护系数

远程近战平砍=平砍伤害*自身近战惩罚%*影响远程近战伤害的被动技能%*远程守护系数 --抵挡
远程近战暴击=暴击伤害*自身近战惩罚%*影响远程近战伤害的被动技能%*远程守护系数
--]]


local BuffArrayClass 	= require 'ServerBuffArray'
local SkillArrayClass 	= require 'ServerSkillArray'

local Random 			= require 'Random'
local IDCreator 		= require 'IDCreator'
local FightEvent 		= require 'FightEvent'
local EventCenter 		= require 'EventCenter'
local GHType 			= require 'GHType'
local ManaManager 		= require 'ManaManager'
local CfgHelper 		= require 'CfgHelper'
local SkillUtil  		= require 'SkillUtil'

local Default 			= require 'Default'
local AlwaysSkill 		= Default.Debug and Default.Debug.release

local ReleaseTimeStep   = (CfgHelper.getCache('BattleSetConfig', 'Key', 'arenaskilltime', 	'Value') or 2) * 1000 
local ArenaEnergyRate 	= (CfgHelper.getCache('BattleSetConfig', 'Key', 'arenaenergy', 		'Value') or 1) 

local CSValueConverter 	= require 'CSValueConverter'


require 'TimeOut'

local ArenaHp = CfgHelper.getCache('BattleSetConfig', 'Key', 'arenahp', 'Value') or 2.5

local function getBigSkillId( basicId )
	-- body
	local charVo = CfgHelper.getCache('charactorConfig', 'id', basicId)
	if charVo then
		return charVo.skill_id
	end
	return nil
end

local function getSkillPoint( basicId )
	-- body
	local skillid = getBigSkillId(basicId)
	if skillid then
		return CfgHelper.getCache('skill', 'id', skillid, 'point')
	end

	return 1
end


local HeroClass = class()

function HeroClass:ctor( args )

	print('--------HeroClass:ctor---------')
	print(args)

-- +cri [0.4]
-- +atk [2100]
-- +def [250]
-- +skillidarray+1 [101]
-- |            +2 [0]
-- |            +3 [101019]
-- |            +4 [1036]
-- |            +5 [7006]
-- |            +6 [5004]
-- +charactorId [66]
-- +hp [1800]
-- +spd [1.5]

	self.ismonster = (args.ismonster and true) or false

	if CSValueConverter.shouldConvert( self.ismonster ) then
		args.hp = CSValueConverter.toSHp(args.hp)
		args.hpMax = CSValueConverter.toSHp(args.hpMax)
	end

	self.dyId = args.dyId or ( IDCreator.getID() )

	self.hp = args.hp --血量
	self.basichp = args.hpMax

	if (not self.basichp) or self.basichp == 0 then
		self.basichp = self.hp
	end

	-- local mode = require 'ServerRecord'.getMode()
	if require 'ServerRecord'.isArenaMode() and require 'ServerRecord'.getMode() ~= 'guildmatch' then
		self.hp = self.hp * ArenaHp
		self.basichp = self.basichp * ArenaHp
	end

	self.hp = math.floor(self.hp) --血量
	self.basichp = math.floor(self.basichp)

	-- if self.dyId == 12 then
	-- 	self.hp = self.hp * 100
	-- 	self.basichp = self.basichp * 100
	-- end

	-- assert(self.hp > 0) 
	-- assert(self.basichp > 0) 
	self.hp = math.max(self.hp, 1)
	self.basichp = math.max(self.basichp, 1)

	self.initHpRate = self.hp/self.basichp

	self.spd = args.spd

	-- self.spd = self.spd

	-- print('角色生成速度1:'..args.spd)
	-- print('角色生成速度2:'..self.spd)
	-- print('ismonster:'..tostring(args.ismonster or false))

	self.basicAtk = args.atk
	self.atk = args.atk --攻击力
	self.def = args.def --防御力

	self.cri = args.cri or args.crit --暴击率

	-- print('暴击概率:'..self.cri)

	self.atktime = args.atktime--

	-- 

	self.charactorId = args.charactorId 	--???????????

	assert(self.charactorId)

	local charVo = CfgHelper.getCache('charactorConfig', 'id', self.charactorId)
	assert(charVo or self.charactorId == 0)-- ==0 npc

	self.atr = charVo and charVo.prop_1 --属性

	self.career = (charVo and charVo.atk_method_system) or 1
	
	self.point = args.point or getSkillPoint( self.charactorId )

	assert(self.point, 'no point:'..self.charactorId)
	assert(self.point >=1, 'p:'..self.point)
	assert(self.point <=3, 'p:'..self.point)

	--[[
	新增6项
	--]]
	if CSValueConverter.shouldConvert( self.ismonster ) then
		self.sv 	= args.sv or CSValueConverter.toCDefault( args.sv , 0) 		--最终伤害
		self.fv 	= args.fv or CSValueConverter.toCDefault( args.fv , 0) 		--最终免伤
		self.cv 	= args.cv or CSValueConverter.toCDefault( args.cv , 1.5) 	--暴击倍数
		self.bd 	= args.bd or CSValueConverter.toCDefault( args.bd , 0) 		--破防, 来自装备
	else
		self.sv 	= args.sv or 0 		--最终伤害
		self.fv 	= args.fv or 0 		--最终免伤
		self.cv 	= args.cv or 1.5 	--暴击倍数
		self.bd 	= args.bd or 0 		--破防, 来自装备
	end

	self.hpR 	= args.hpR or 0		--回复加成, 来自装备	
	self.gb 	= args.gb or {}		--宝石对宠物Buff效果的影响,   光环的map????
	
	--[[
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

	-- k.属性增强比例
	-- l.属性抗性比例

	k.属性增强比例 ----- 增加怒气回复
	l.属性抗性比例 ----- 减少技能伤害
	
	m. 增加技能伤害
	--]]

	--装备buff
	self.eb 	= args.eb or {}  	--EquipBuff <Prop,v>详见EqPropConfig
	self.gb['k'] = (self.gb['k'] or 0) + (self.eb['10'] or 0)

	self.awaken = args.awaken or 24

	self.state = 'running'

	self.hpState = 'no-change'

	-- print('----------新角色-----------')
	-- print(self)
	-- print('--------------------------')

	self.pos = { x = 0, y = 0}

	self._protectTime = 0

	-----魔法值
	self._manaProgress = 0
	self.mana = args.mana or 0
	
	-- self.
	self.buffarray = BuffArrayClass.new(self)
	self.skillarray = SkillArrayClass.new(self)

	if args.skillidarray then
		for i,v in ipairs(args.skillidarray) do
			if v ~= 0 then
				self.skillarray:addSkillByBasicId( v )
			end
		end
	end
	
	-- event ?
	TimeOut.new(0, function ()
		-- body
		-- self:addMana(0)
		EventCenter.eventInput(FightEvent.Pve_SetMana, { playerId = self:getDyId(), mana = self.mana, maxPoint = self.point } )
	end):start()

	self.atktime = self.atktime or 0

	local basicatktime = self:getAtkCD()

	print('basicatktime:'..basicatktime)

	if self.atktime <= basicatktime/2 or self.atktime > basicatktime then
		print('异常的攻击间隔:'..self.atktime)
		self.atktime = basicatktime
	end
	
	basicatktime = basicatktime*(1 + (self.eb['6'] or 0))
	self.basicAtkSpd = basicatktime/self.atktime
	self.basicAtkSpd = math.max(self.basicAtkSpd, 1)
	self.basicAtkSpd = math.min(self.basicAtkSpd, 2)

	print('basicAtkSpd:'..self.basicAtkSpd)

	if require 'ServerRecord'.getMode() == 'guildmatch' then
		self.atk = args.atk*(self:getHpP()/100)
	end

	print('----------新角色-----------')
	print(self)
end



function HeroClass:setManaCheckPoint()
	-- body
	self._manaCheck = self.mana * (-2) + 5
end

function HeroClass:checkManaPoint()
	-- body
	if self._manaCheck and self.mana then
		local min = math.abs( self._manaCheck - ( self.mana * (-2) + 5 )  )
		if min <= 1 then
			return true
		end

		-- assert(false)
		os.exit(0)
	end
end


function HeroClass:getAtkCD()
	-- body
	-- if self:isMonster() then
	if require 'ServerRecord'.isArenaMode() then
		local cd = CfgHelper.getCache('charactorConfig', 'id', self.charactorId, 'Atktime')
		-- or 2
		-- assert(cd)
		if not cd then
			cd = 2
			print('getAtkCD not found id'..tostring(self.charactorId))
		end

		return cd
	elseif self.ismonster then
		local cd = CfgHelper.getCache('MonsterConfig', 'heroid', self.charactorId, 'atktime')
		-- or 2
		-- assert(cd)
		if not cd then
			cd = 2
			print('getAtkCD not found heroid'..tostring(self.charactorId))
		end

		return cd
	else
		-- Atktime
		local cd = CfgHelper.getCache('charactorConfig', 'id', self.charactorId, 'Atktime')
		-- or 2
		-- assert(cd)
		if not cd then
			cd = 2
			print('getAtkCD not found id'..tostring(self.charactorId))
		end

		return cd
	end
end

function HeroClass:getManaSpd()
	-- body
	return (self.gb['k'] or 0) + 1
end

--[[
--]]
function HeroClass:isGodMode()
	-- body
	if self._protectTime > 0 then
		return true
	end

	return false
	-- return true
end

function HeroClass:setManaLocked( lock )
	-- body
	self._lockMana = lock
end

function HeroClass:getManaLocked( ... )
	return self._lockMana
end

function HeroClass:addMana( add )
	-- body
	self:checkManaPoint()

	add = add or 0
	
	if self._lockMana and add > 0 then
		return
	end

	if add > 0 then
		local nuqiRate = self:getBuffArray():getValueByKey(GHType.GH_MoreNuqi) or 0
		nuqiRate = nuqiRate + (self:getBuffArray():getValueByKey(GHType.GH_AwakeMana_RevertSpeed) or 0)
		nuqiRate = nuqiRate + (self:getBuffArray():getValueByKey(GHType.GH_240) or 0)
		
		local arenaRate = 1
		if require 'ServerRecord'.isArenaMode() then
			arenaRate = ArenaEnergyRate
		end

		add = add * (1 + (self.gb['k'] or 0) + ( nuqiRate ) ) * arenaRate
	elseif add < 0 then
		add = add * (1 - (self.eb['17'] or 0))
	end
	
	local oldMana = self.mana
	self.mana = self.mana + add
	self.mana = math.max(0, self.mana)
	self.mana = math.min( require 'ManaManager'.ManaStep * self.point, self.mana ) 

	self:setManaCheckPoint()

	print(string.format('Id=%d, Old_Mana=%d, Add_Mana=%d, New_Mana=%d', self.dyId, oldMana, add, self.mana))

	EventCenter.eventInput(FightEvent.Pve_SetMana, { playerId = self:getDyId(), mana = self.mana, maxPoint = self.point } )
end

function HeroClass:subMana()
	-- body
	local point = math.floor(self.mana/ManaManager.ManaStep)

	self._manaRate =  ManaManager.getManaRate(point, self.point)
	self._manaPoint = point

	self:addMana(-point*ManaManager.ManaStep)
end

function HeroClass:getManaPoint()
	-- body
	assert(self._manaPoint)

	return self._manaPoint or 0
end

function HeroClass:getManaRate()
	-- body
	if require 'ServerRecord'.isArenaMode() then
		return self._manaRate or 1
	end
	
	if AlwaysSkill or self:isMonster() then
		return 1
	end

	return self._manaRate or 1
end

function HeroClass:getMana()
	-- body
	return self.mana
end

function HeroClass:setProtectTime( time )
	-- body
	if not self._protectTime or self._protectTime < time then
		self._protectTime = time
	end
end

function HeroClass:isManaFull()
	-- body
	local manaStep = require 'ManaManager'.ManaStep
	if self.mana >= manaStep*self.point then
		return true
	end
end

function HeroClass:update( dt )
	-- body
	self._protectTime = self._protectTime - dt

	----竞技场才有
	if require 'ServerRecord'.isArenaMode() then
		--dt s
		--mana 自动增加
		if (not self:isDisposed()) then
			self._manaProgress = self._manaProgress + dt
			if self._manaProgress >= 5 then
				self._manaProgress = self._manaProgress - 5
				local career = self:getCareer()
				self:addMana( require 'ManaManager'.ManaTable[career].Z )
			end
		end
	else
		--dt s
		--mana 自动增加
		-- if (not self:isDisposed()) and (not self:isMonster()) then
		if (not self:isDisposed()) and (not self:isMonster() or require 'ServerRecord'.isEnemyManaAutoEnabled()) then
			self._manaProgress = self._manaProgress + dt
			if self._manaProgress >= 5 then
				self._manaProgress = self._manaProgress - 5
				local career = self:getCareer()
				self:addMana( require 'ManaManager'.ManaTable[career].Z )
			end
		end
	end

	-- self:refreshAtkSpd()

	-- 触发在战场的被动技能

	if not self._onBattleFieldTime then
		self._onBattleFieldTime = 0
	end

	self._onBattleFieldTime = self._onBattleFieldTime + dt

	if self._onBattleFieldTime >= 2 then
		self._onBattleFieldTime = 0

		self:triggerOnBattleField()
	end
end

function HeroClass:triggerOnBattleField()
	-- body
	local data = {
		attacker = true,
		conditiontype = true,
		openorclose = true,
	}
	data.attacker = self
	data.conditiontype = SkillUtil.Condition_OnBattleField --位于战场
	data.openorclose = true
	EventCenter.eventInput(FightEvent.TriggerAbility, data)
end


function HeroClass:getAtr(  )
	-- body
	return self.atr
end

function HeroClass:getDyId()
	-- body
	return self.dyId
end

function HeroClass:getBasicId()
	-- body
	return self.charactorId
end

function HeroClass:getCareer(  )
	-- body
	return self.career
end

function HeroClass:getBuffArray()
	-- body
	return self.buffarray
end

function HeroClass:getSkillArray()
	-- body
	return self.skillarray
end


function HeroClass:stopDanceSkill( skillId )
	-- body
	-- print('')

	local serverSkill = self.skillarray:findSkillByBasicId( skillId )
	assert(serverSkill)
	
	serverSkill:invalid()

end

function HeroClass:setServerRoleArray( serverRoleArray )
	-- body
	self.serverRoleArray = serverRoleArray
end



function HeroClass:isDisposed()
	-- body
	return self.state == 'dead' 
	-- or self.hp <= 0 
end

function HeroClass:setDisposed( skill )
	-- body
	if self.state ~= 'dead' then
		self.state = 'dead'
		self._deadTime = require 'FightTimer'.currentFightTimeMillis()
		--回收所有buff
		self.skillarray:onDisposed()


		self.mana = 0
		self:setManaCheckPoint()
		
		EventCenter.eventInput(FightEvent.Pve_SetMana, { playerId = self:getDyId(), mana = self.mana, maxPoint = self.point } )

		if self:isMonster() then
			EventCenter.eventInput(FightEvent.Pve_ComeOffBench , { isHero = false } )
			EventCenter.eventInput(FightEvent.Pve_S_DeleteMonster , self:getDyId())
		else
			EventCenter.eventInput(FightEvent.Pve_ComeOffBench , { isHero = true } )

			-- self.
			if not self.serverRoleArray:hasHeroExisted() then
				EventCenter.eventInput(FightEvent.Pve_PreGameOverData, require 'ServerRecord'.createGameOverData(false))
			end
		end

		--FightEvent.Pve_RoleDie
		EventCenter.eventInput(FightEvent.Pve_RoleDie , { 
			role = self, 
			isMonster = self:isMonster(),
			skill = skill,
			career = self:getCareer()
		})	

		if self:isMonster() then
			if skill then
				if skill:isNormalAttack() then
					require 'ServerRecord'.addNormalKill()
					require 'ServerRecord'.setLastKillWithSkill(false)
				else
					require 'ServerRecord'.addSkillKill()
					require 'ServerRecord'.setLastKillWithSkill(true)
				end
			else
				require 'ServerRecord'.setLastKillWithSkill(false)
			end
		end
		
		require 'ServerRecord'.pushDeadRole( self )
		-- self.skillarray = nil
		-- self.buffarray = nil
		-- self.serverRoleArray = nil
	end
end

function HeroClass:onBorn()
	-- body
	self._borned = true
end

function HeroClass:isBorned()
	-- body
	return self._borned
end

function HeroClass:couldRemove()
	-- body
	if self:isDisposed() then
		local now = require 'FightTimer'.currentFightTimeMillis()

		return (now - self._deadTime) >= 5000
	end
end

function HeroClass:setBigSkillId( skillid )
	-- body
	self._bigSkillId = skillid
end

function HeroClass:getBigSkillId()
	-- body
	return self._bigSkillId
end

function HeroClass:isMonster()
	-- body
	return self.ismonster
end

function HeroClass:onHpChange( dhp, skill )
	-- body
	if self:isDisposed() then
		return
	end

	-- remain un do
	-- if CSValueConverter.shouldConvert( self:isMonster() ) then
	-- 	dhp = CSValueConverter.toCHp( dhp )
	-- end

	if dhp == 0 then
		return
	end

	self.hpState = 'has-change'
	
	local oldhp = self.hp
	local newhp = self.hp + dhp

	if newhp > self:getBasicHpD() then
		self.hp = self:getBasicHpD()
	else
		self.hp = newhp
	end 

	if oldhp > 0 and newhp <= 0 then
		if self:getBuffArray():getValueByKey(GHType.GH_203) then
			self.hp = 1
		else
			self:setDisposed( skill )
		end
	else
		--触发被动???
	end
end

function HeroClass:getBasicHpD()
	-- body
	-- if self.hpState == 'no-change' then
	-- 	self.hp = self:getBasicHpD()
	-- end
	local basicRet = math.floor( self.basichp * (1 + (self:getBuffArray():getValueByKey(GHType.GH_MaxHp) or 0) + (self:getBuffArray():getValueByKey(GHType.GH_236) or 0)) )
	return basicRet
	-- if CSValueConverter.shouldConvert( self:isMonster() ) then
	-- 	return CSValueConverter.toSHp( basicRet )
	-- else
	-- 	return basicRet
	-- end
end

function HeroClass:getHpD()
	-- body
	if self:isDisposed() then
		return 0
	end

	if self.hpState == 'no-change' then
		self.hp = self:getBasicHpD() * self.initHpRate
	end

	if self.hp <= 0 then
		assert( self:isDisposed() )
		-- self:setDisposed()
		return 0
	end
	return self.hp
	-- if CSValueConverter.shouldConvert( self:isMonster() ) then
	-- 	return CSValueConverter.toSHp( self.hp )
	-- else
	-- 	return self.hp
	-- end
end

function HeroClass:getHpP()
	-- body
	if self:isDisposed() then
		return 0
	end

	if self.hpState == 'no-change' then
		self.hp = self:getBasicHpD() * self.initHpRate
		-- return 100
	end

	if self.hp <= 0 then
		return 0
	end
	
	local ret = 100 * self.hp / self.basichp
	ret = math.min(ret, 100)
	ret = math.max(ret, 0)

	return ret
end


function HeroClass:getHpPCure()
	-- body
	if self:isDisposed() then
		return 0
	end

	if self.hpState == 'no-change' then
		self.hp = self:getBasicHpD() * self.initHpRate
		-- return 100
	end

	if self.hp <= 0 then
		return 0
	end
	
	local ret = 100 * self.hp / self:getBasicHpD()
	ret = math.min(ret, 100)
	ret = math.max(ret, 0)

	return ret
end

function HeroClass:getSpeed()
	-- body
	local rate = self:getSlowRate()
	if self._slowRate ~= rate then

		EventCenter.eventInput(FightEvent.Pve_setSlowRate, { playerId = self:getDyId(), slowRate = rate} )

		self._slowRate = rate
	end

	return self.spd * rate
end

function HeroClass:refreshAtkSpd()
	-- body
	local rate = self:getAtkSlowRate()
	if self._atkSlowRate ~= rate then
		self:forceRefreshAtkSpd()
	end
	-- return self.spd * rate
end

function HeroClass:forceRefreshAtkSpd()
	-- body
	local rate = self:getAtkSlowRate()
	EventCenter.eventInput( FightEvent.Pve_setAtkSlowRate, { playerId = self:getDyId(), atkSlowRate = rate} )
	self._atkSlowRate = rate
end


function HeroClass:getAtkSlowRate()
	-- body
	local cof = self.buffarray:getValueByKey( GHType.GH_AtkSpd ) or 0
	cof = cof + (self.buffarray:getValueByKey( GHType.GH_239 ) or 0)
	cof = math.max(cof, -0.999999999999)
	cof = math.min(cof,  1)

	return ((self.basicAtkSpd or 1) + cof )
end

function HeroClass:getSlowRate()
	-- body
	local cof = self.buffarray:getValueByKey( GHType.GH_Spd ) or 0

	cof = math.max(cof, -0.99)
	cof = math.min(cof,  0.5)

	return (1 + cof)
end

function HeroClass:getCrit( )
	local v = self.buffarray:getValueByKey(GHType.GH_Crit) or 0

	return self.cri + v
end

--[[
存储Id, PetId, Hp, Lv 等信息
--]]
function HeroClass:setIdentifyId( identifyId )
	-- body
	self._identifyId = identifyId
end

function HeroClass:getIdentifyId()
	-- body
	return self._identifyId
end

function HeroClass:setLevel( level )
	-- body
	self._level = level
end

function HeroClass:getLevel()
	-- body
	return self._level or 0
end

local factory = {}

function factory.createHeroByArgs( args )
	-- body
	local hero = HeroClass.new(args)
	return hero
end

function factory.getHeroClass()
	-- body
	return HeroClass
end

return factory