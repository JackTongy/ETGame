--[[
平砍伤害=(角色攻击+被动技能加成)/10 *Ran.next（95,105）/100* (1-0.01*敌人防御/(5+0.01*敌人防御)*0.7)*属性相克系数*（1-属性免疫比例*(针对特定属性类型怪物伤害)

暴击伤害=平砍伤害*（暴击系数%+某些被动技能对暴击的影响%）

技能伤害=平砍伤害*（主动技能系数%+某些被动技能对技能伤害的影响%+连锁系数%）*（1+角色觉醒阶数对主动伤害的加成百分比）

远程平砍=平砍伤害 *双方影响远程伤害的被动技能%*远程守护系数
远程暴击=暴击伤害 *双方影响远程伤害的被动技能%*远程守护系数

远程近战平砍=平砍伤害*自身近战惩罚%*影响远程近战伤害的被动技能%*远程守护系数 --抵挡
远程近战暴击=暴击伤害*自身近战惩罚%*影响远程近战伤害的被动技能%*远程守护系数
--]]


--[[
--]]
local BuffFactory = require 'ServerBuff'
local Random = require 'Random'
local SkillUtil = require 'SkillUtil'
local EventCenter = require 'EventCenter'
local FightEvent = require 'FightEvent'
local CfgHelper = require 'CfgHelper'
local Utils = require 'framework.helper.Utils'

local SkillClass = class()

function SkillClass:ctor( args )
	-- body
	-- 
	-- print('SkillClass')
	-- print(args)

-- Cocos2d: [LUA-print] SkillClass
-- Cocos2d: [LUA-print] 
-- +revproarray+1 [0]
-- +point [1]
-- +range+1 [1]
-- |     +2 [1]
-- +shapes [5]
-- +buffidarray+1 [0]
-- +recover [0]
-- +skillatkadd [9]
-- +addtimes [1]
-- +beatgrid [3]
-- +uAtk_effectId [0]
-- +atk_effectId [0]
-- +id [1052]
-- +buffproarray+1 [0]
-- +conditionvalue [0]
-- +skillatkatr [0]
-- +skilltype [1]
-- +maxnum [1]
-- +name [圣枪]
-- +target [5]
-- +skillcondition [1]
-- +dam_mul [10]
-- +revabnarray+1 [0]
-- +skilldes [攻击前方一名敌人,造成10倍伤害,并弹飞3格。]


	self.skillid = args.id
	self.skilldes = args.skilldes
	self.skilltype = args.skilltype
	self.duration = args.duration -- 持续时间

	self.skillcondition = args.skillcondition
	self.conditionvalue = args.conditionvalue

	self.buffproarray = args.buffproarray
	self.buffidarray = args.buffidarray

	self.revproarray = args.revproarray
	self.revabnarray = args.revabnarray

	self.beatgrid = args.beatgrid

	self.target = args.target

	self.allbuffs = {}
	
	--...
	-- self.

	self.triggercount = 0

	-- addtimes = 1,	recover = 0

	self.recycleCount = args.recover

	--0,表示可以叠加
	--1,表示只能叠加一次
	self.addtimes = args.addtimes
	if self.addtimes <= 0 then
		self.addtimes = 100000
	end

	--触发概率
	self.skillrate = args.skillrate or 1
	if type(self.skillrate) == 'table' then
		self.skillrate = #self.skillrate > 1 and self.skillrate[1] or 1
	end
end

function SkillClass:setOwner( owner )
	-- body
	self.owner = owner
end

function SkillClass:getOwner()
	-- body
	return self.owner
end

function SkillClass:getBasicId()
	-- body
	return self.skillid
end

--主动技能1， 被动技能2
function SkillClass:isActiveSkill()
	-- body
	-- return self.skilltype == 1 or self.skilltype == 3
	return self.skilltype > 0
end

--近战攻击, 远程攻击
function SkillClass:isNormalAttack()
	-- body
	return self.skilltype == 1 or self.skilltype == 2 or self.skilltype == 4
end

--近战攻击, 远程攻击
function SkillClass:isNormalCure()
	-- body
	return self.skilltype == 3
end

function SkillClass:isBigSkill()
	-- body
	return self.skilltype > 10
end

function SkillClass:isMatched( openorclose ,defenders)
	-- body
	--血量条件触发
	--百分比

	if openorclose then
		if self.skillcondition == 2 then
			local hpP = self.owner:getHpP() / 100
			local off = math.abs(hpP - self.conditionvalue)
			return off < 0.000001
		elseif self.skillcondition == 3 then
			local hpP = self.owner:getHpP() / 100
			return hpP <= self.conditionvalue
		elseif self.skillcondition == 4 then
			local hpP = self.owner:getHpP() / 100
			return hpP >= self.conditionvalue
		elseif defenders and #defenders >= 1 and self.skillcondition == SkillUtil.Condition_31 then
			local ret = false
			for k,v in pairs(defenders) do
				local hpP = v:getHpP() / 100
				if hpP <= self.conditionvalue then
					return true
				end
			end
			return false
		end

		if self.skillcondition == SkillUtil.Condition_BattleFieldType then
			local bgType = require 'ServerRecord'.getBattleBgType()
			if self.conditionvalue == bgType then
				-- assert(false, tostring(bgType)..','..tostring(self.conditionvalue))
				return true
			else
				-- assert(false, tostring(bgType)..','..tostring(self.conditionvalue))
				return false
			end
		end
	end

	return openorclose
end

--[[
args.attacker
args.defenders
--]]
function SkillClass:trigger(args, carryData)
	-- assert(false, 'should be override')
	--保存所有生成的buff列表
	-- self.allbuffs = self.allbuffs or {}

	local ret = self:calc(args.attacker, args.defenders, false, carryData)

	for i,v in ipairs(ret.buffadd) do 
		-- v:setDisposed()
		-- if v.setDisposed then

		for ii,vv in ipairs(v) do
			-- vv:setCarryData( carryData )
			table.insert(self.allbuffs, vv)
		end

		-- table.insert(self.allbuffs, v)
		-- else
		-- 	print('unexcepted buff')
		-- 	print(type(v))
		-- 	print(v)
		-- end

	end

	return ret
end

function SkillClass:invalid()
	-- body
	for i, v in pairs(self.allbuffs) do 
		-- if v.setDisposed then
			v:setDisposed()
		-- else
		-- 	-- v:setDisposed()
		-- 	print('unexcepted buff')
		-- 	print(v)
		-- end
	end
	self.allbuffs = {}
end

function SkillClass:recycle()
	-- body
	if self.recycleCount > 0 then
		print('回收技能'..self:getBasicId())
		self:invalid()
	end
end

function SkillClass:isOnCondition( conditiontype )
	-- body
	if conditiontype == self.skillcondition then
		return true
	end

	return false
end

--[[
args.attacker
args.defenders
--]]
function SkillClass:onCondition(conditiontype, args, openorclose, carryData)
	-- print(string.format('condition=%d,skillcondition=%d', conditiontype, self.skillcondition))
	-- print(args)

	if conditiontype == self.skillcondition then
		
		openorclose = self:isMatched( openorclose,args.defenders )

		local skillid = self:getBasicId()
		local attackerid = args.attacker:getDyId()

		local defenderids = {}
		if args.defenders then
			for i,v in ipairs(args.defenders) do
				table.insert(defenderids, v:getDyId())
			end
		end
		
		local ret 
		if openorclose then

			if self.addtimes > self.triggercount then
				self.triggercount = self.triggercount + 1
				ret = self:trigger(args, carryData)
			end
			
		elseif not openorclose and self.triggercount >= 1 then
			self.triggercount = 0
			ret = self:invalid(args, carryData)
		end

		print('-----------------------------------')
		print(string.format('触发被动技能:skill=%s,attack=%s,defenders=%s,openorclose=%s', tostring(skillid), tostring(attackerid), table.concat(defenderids, ','), tostring(openorclose)))
		print('addtimes = '..self.addtimes..', triggercount = '..self.triggercount)
		-- print('技能结果:')
		-- print(ret)
		print('-----------------------------------')


		--检查是否有异常文字需要显示
		-- fightEvent.Pve_showAbnormalLabel ="Pvp_showAbnormalLabel"

		return ret
	end

	-- return 
end


-- function SkillClass:calcWithCrit( args, crit )
-- 	-- body
-- 	self.allbuffs = self.allbuffs or {}

-- 	local ret = self:calc(args.attacker, args.defenders, crit)

-- 	for i,v in ipairs(ret.buffadd) do 
-- 		-- v:setDisposed()
-- 		table.insert(self.allbuffs, v)
-- 	end

-- 	return ret
-- end


function SkillClass:onFightCondition( conditiontype, args, crit, manaRate )
	-- body
	assert(crit ~= nil)

	assert(conditiontype == self.skillcondition and self:isMatched(true,args.defenders))

	self:checkDanceSkill()

	--for print
	local skillid = self:getBasicId()
	local attackerid = args.attacker:getDyId()

	--for print
	local defenderids = {}
	if args.defenders then
		for i,v in ipairs(args.defenders) do
			table.insert(defenderids, v:getDyId())
		end
	end
	
	require 'DamageFormula'.setManaRate(manaRate)
	local ret = self:calc(args.attacker, args.defenders, crit)
	require 'DamageFormula'.setManaRate(nil)

	for i,v in ipairs(ret.buffadd) do 
		-- v:setDisposed()
		-- if v.setDisposed then
		-- end
		for ii,vv in ipairs(v) do
			table.insert(self.allbuffs, vv)
		end
	end

	-- return ret

	if self:isBigSkill() then
		print('-----------------------------------')
		print(string.format('触发大招技能:skill=%s,attack=%s,defenders=%s,openorclose=%s', tostring(skillid), tostring(attackerid), table.concat(defenderids, ','), tostring(openorclose)))
		-- print('技能结果:')
		-- print(ret)
		print('-----------------------------------')
		local owner = self:getOwner()
		assert(owner)
		
		-- local manaStep = require 'ManaManager'.ManaStep
		-- local point  = math.floor(owner.mana/manaStep)
		-- owner:addMana( -point*manaStep )
	else
		print('-----------------------------------')
		print(string.format('触发普通技能:skill=%s,attack=%s,defenders=%s,openorclose=%s', tostring(skillid), tostring(attackerid), table.concat(defenderids, ','), tostring(openorclose)))
		-- print('技能结果:')
		-- print(ret)
		print('-----------------------------------')
	end

	
	return ret
end

function SkillClass:checkAbnormalLabel()
	-- body
end

function SkillClass:checkDanceSkill()
	-- body
	--如果是歌舞类的技能,直接推送一个Buff

	if self.skilltype == SkillUtil.SkillType_Dance then

		-- self:invalid() -- 不需要invalid
		local manaRate = require 'DamageFormula'.getCurrentManaRate(self:getOwner())

		local danceBuffId = 1000
		local vv = BuffFactory.createBuff( danceBuffId, self, self:getOwner(), self:getOwner(), manaRate)

		--修改buff持续时间
		assert(self.duration > 0)
		assert(self.owner)


		vv.bufflife = self.duration * self.owner:getManaRate()

		print('歌舞初始时间:'..self.duration)
		print('歌舞加成比例:'..self.owner:getManaRate())

		local role = self:getOwner()
		local d = self:getOwner()
		
		local addRet = d:getBuffArray():addBuff( vv )
		-- assert(addRet == 'add')

		--增加到自身
		table.insert(self.allbuffs, vv)

		local data = {}
		data.Id = vv:getBasicId()
		data.Hid = d:getDyId()
		data.Speed = d:getSpeed()

		--增加Buff HpD 为 0
		data.HpD = nil
		data.HpP = d:getHpP()

		-- if addRet == 'imm' then
		-- elseif addRet == 'add' then
		-- elseif addRet == 'merge' then
		-- end

		data.State = addRet

		data.Sid = self:getBasicId()
		data.IsCrit = false
		
		local Vs = {}
		table.insert(Vs, data)

		local bb = { D = { Vs = Vs } }
		print('PVE-Server歌舞:AddBuff '..role:getDyId()..'->'..d:getDyId()..','..vv:getBasicId())
		print('歌舞持续='..vv.bufflife)
		print(bb)

		EventCenter.eventInput( FightEvent.Pve_Buff, bb )
		-----------------------------------------------------------
	else
		--self.skilltype == SkillUtil.SkillType_Dance
		-- print('Skill Id = '..self.skillid)
		-- print('Skill Type = '..self.skilltype)
	end
end


--[[
平砍伤害=(角色攻击+被动技能加成)/10 *Ran.next（95,105）/100* (1-0.01*敌人防御/(5+0.01*敌人防御)*0.7)*属性相克系数*（1-属性免疫比例）
暴击伤害=平砍伤害*（暴击系数%+某些被动技能对暴击的影响%）
技能伤害=平砍伤害*（主动技能系数%+某些被动技能对技能伤害的影响%+连锁系数%）*（1+角色觉醒阶数对主动伤害的加成百分比）
远程平砍=平砍伤害 *双方影响远程伤害的被动技能%*远程守护系数
远程暴击=暴击伤害 *双方影响远程伤害的被动技能%*远程守护系数
远程近战平砍=平砍伤害*自身近战惩罚%*影响远程近战伤害的被动技能%*远程守护系数 --抵挡
远程近战暴击=暴击伤害*自身近战惩罚%*影响远程近战伤害的被动技能%*远程守护系数
--]]
function SkillClass:hurtFormula(one, another, cri, index)
	-- return number or false
	-- 补充完整
	-- 近战技能
	-- 远程近战技能
	-- 远程技能

	--无敌状态下, 地方无法给己方添加任何伤害
	if another:isGodMode() then

		if one:isMonster() ~= another:isMonster() then
			-- assert(false)
			EventCenter.eventInput(FightEvent.Pve_ShowWuDi, { playerId = another:getDyId() } )
			return 0
		end
	end

	if one:isDisposed() or another:isDisposed() then
		return 0
	end

	local skillid = self:getBasicId()
	assert(skillid)

	-- local df = require 'DamageFormula2'   --old version
	local df = require 'DamageFormula'    --new version
	local hurt = df.calc( one, another, skillid, cri, index)
	
	--增加光环逻辑
	local gh237 = another:getBuffArray():getValueByKey(require 'GHType'.GH_237) or 0
	if gh237 > 0 then
		local maxhurt = (gh237*another:getBasicHpD())/100
		hurt = math.min(maxhurt,hurt)
		print(string.format('受到伤害不能超过自身上限的%f,最终伤害:%f',gh237,hurt))
	end

	return hurt
end


function SkillClass:buffAddFormula(one, another, carryData) 
	--return buff or false
	-- if one:isDisposed() or another:isDisposed() then
	-- 	return
	-- end

	--无敌状态下, 敌方无法给己方添加任何Buff
	if another:isGodMode() then
		if one:isMonster() ~= another:isMonster() then
			return nil
		end
	end

	local manaRate = 1
	if self:isBigSkill() then
		manaRate = require 'DamageFormula'.getCurrentManaRate(self:getOwner())
	end

	local buffarray
	for i,v in ipairs(self.buffproarray) do
		--xxxxx
		local buffid = self.buffidarray[i]
		if buffid <= 0 then
			break
		end

		if Random.ranF() <= v or ( require 'Default'.Debug.trigger ) then
			
			local buff = BuffFactory.createBuff( buffid, self, one, another, manaRate)
			buff:setCarryData(carryData)

			if self.skilltype == SkillUtil.SkillType_Dance then
				buff.bufflife = self.duration
			end
			
			-- print('buffAddFormula')
			-- print(buff)
			buffarray = buffarray or {}
			table.insert(buffarray, buff)
		end
	end

	return buffarray
end

function SkillClass:buffRemFormula(one, another) 
	--return buff or false
	-- if one:isDisposed() or another:isDisposed() then
	-- 	return
	-- end
	local buffarray

	for i,v in ipairs(self.revproarray) do
		-- if Random.ranF() <= v then
			local buffid = self.revabnarray[i]
			if buffid <= 0 then
				break
			end

			if another:getBuffArray():findBuffByBasicId(buffid) then
			-- local buff = BuffFactory.createBuff(buffid)
				buffarray = buffarray or {}
				table.insert(buffarray, buffid)
			end
		-- end
	end

	return buffarray
end

function SkillClass:beatbackFormula( one, another )
	-- body
	return self.beatgrid
end

--[[
extra = crit
--]]
function SkillClass:calcTemplate( one, heroarray, funcname, extra )
	local retarray = {}
	for i, v in ipairs(heroarray) do 
		local ret = self[funcname](self, one, v, extra, i) or {}
		table.insert(retarray,  ret)
	end
	return retarray
end

function SkillClass:calcHurt( owner, heroarray, cri )
	return self:calcTemplate(owner, heroarray, 'hurtFormula', cri)
end

function SkillClass:calcBeatback( owner, heroarray, crit, carryData)
	-- body
	return self:calcTemplate(owner, heroarray, 'beatbackFormula')
end

function SkillClass:calcBuffAdd(owner, heroarray,crit,carryData )
	return self:calcTemplate(owner, heroarray, 'buffAddFormula', carryData)
end

function SkillClass:calcBuffRem(owner, heroarray, crit, carryData )
	return self:calcTemplate(owner, heroarray, 'buffRemFormula')
end

function SkillClass:calc( owner, heroarray, crit, carryData)

	-- assert(heroarray)
	heroarray = heroarray or {}

	local ret = {}
	ret.buffadd = self:calcBuffAdd(owner, heroarray, crit, carryData)

	ret.buffrem = self:calcBuffRem(owner, heroarray, crit, carryData)

	--主动技能 战斗伤害计算才会触发
	if self:isActiveSkill() then
		--加入锁链效果
		---- ????
		-- require 'SkillChainManager'.actionSkill(self) 

		----预先计算????

		--近战攻击
		--远程攻击
		--远程近战攻击

		-- SkillUtil.SkillType_JinZhan=1
		-- SkillUtil.SkillType_YuanCheng=2
		-- SkillUtil.SkillType_ZiLiao=3
		-- SkillUtil.SkillType_YuanChengJinZhan = 4
		
		-- if self.skilltype == SkillUtil.SkillType_JinZhan or self.skilltype == SkillUtil.SkillType_YuanCheng or self.skilltype == SkillUtil.SkillType_YuanChengJinZhan then
		-- 	if crit == nil then
		-- 		ret.cri = ( Random.ranF() < (owner.cri or 0) ) 
		-- 	end
		-- end

		ret.cri = crit

		ret.hurt = self:calcHurt(owner, heroarray, ret.cri)


		if not owner:isDisposed() then
			--大招怒气不增加??
			if self:isBigSkill() then
				
			else
				owner:addMana(require 'ManaManager'.ManaTable[owner.career].X)
			end
		end
		
		for i,v in ipairs(heroarray) do

			if self.skilltype == SkillUtil.SkillType_YuanCheng and i >= 2 then
				--贯穿后命中的敌人不会增加怒气
				break
			end

			if not v:isDisposed() and v:isMonster() ~= owner:isMonster() then
				v:addMana(require 'ManaManager'.ManaTable[v.career].Y)
			end
		end
		
		ret.beatback = self:calcBeatback(owner, heroarray)
	end
	
	return ret
end

function SkillClass:onRate( ... )
	return self.skillrate == 1 or self.skillrate >= require 'Random'.ranF()
end

local factory = {}
local cfgHelper = require 'CfgHelper'

function factory.createSkill( skillid )
	-- body
	local args = cfgHelper.getCache('skill', 'id', skillid)
	if args then
		return SkillClass.new(args)
	else 
		print("skill table has no such skillid "..tostring(skillid))
	end
end

return factory