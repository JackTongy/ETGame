local GHType = require 'GHType'

local Random = require 'Random'

local CfgHelper = require 'CfgHelper'

local TypeRole = require 'TypeRole'

local SkillUtil = require 'SkillUtil'

local Property = require 'property'

local SkillChainManager = require 'SkillChainManager'

local function getCof( atr1, atr2 )
	-- body
	for i,v in ipairs(Property) do
		if v.atr == atr1 and v.atr2 == atr2 then
			return v.coefficient
		end
	end
	print('warning:getCof('..tostring(atr1)..','..tostring(atr2)..')') 
	return 1
end

local Formula = {}

--[[
平砍伤害=(角色攻击+被动技能加成)/10 *Ran.next（95,105）/100* (1-0.01*敌人防御/(5+0.01*敌人防御)*0.7)*属性相克系数*（1-属性免疫比例）*()
暴击伤害=平砍伤害*（暴击系数%+某些被动技能对暴击的影响%）
技能伤害=平砍伤害*（主动技能系数%+某些被动技能对技能伤害的影响%+连锁系数%）*（1+角色觉醒阶数对主动伤害的加成百分比）
远程平砍=平砍伤害 *双方影响远程伤害的被动技能%*远程守护系数
远程暴击=暴击伤害 *双方影响远程伤害的被动技能%*远程守护系数
远程近战平砍=平砍伤害*自身近战惩罚%*影响远程近战伤害的被动技能%*远程守护系数 --抵挡
远程近战暴击=暴击伤害*自身近战惩罚%*影响远程近战伤害的被动技能%*远程守护系数

	self.sv 	= args.sv or 0 		--最终伤害
	self.fv 	= args.fv or 0 		--最终免伤
	self.cv 	= args.cv or 0 		--暴击倍数
	self.bd 	= args.bd or 0 		--破防, 来自装备
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

	k.属性增强比例
	-- l.属性抗性比例
	l.属性抗性比例 草
	m.属性抗性比例 电
	n.属性抗性比例 水
	o.属性抗性比例 岩
	p.属性抗性比例 火

--]]

--[[
属性相克系数
--]]
-- local 

--[[
计算公式:
1. 近战攻击 计算公式
2. 远程攻击 计算公式
3. 治疗攻击 计算公式

4. 大招攻击
5. 大招治疗

SkillUtil.SkillType_Passive=-1

SkillUtil.SkillType_JinZhan=1


SkillUtil.SkillType_YuanCheng=2

SkillUtil.SkillType_ZiLiao=3

SkillUtil.SkillType_DaZhaoAttack=11

SkillUtil.SkillType_DaZhaoZhiLiao=12

SkillUtil.SkillType_DaZhaoSpecial=13
--]]

local function funcAndPrint( func, message )
	-- body
	print(string.format('------%s------', message))
	local ret = func()
	print(string.format('最终结果=%s', tostring(ret)))
	print('------------------------')
	return ret
end

local Awaken_Effect_Rate = {
	[0] = 0,
	[1] = 0,
	[2] = 0,
	[3] = 0,
	[4] = 0,
	[5] = 0,
	[6] = 0,
	[7] = 0,
	[8] = 0.08,
	[9] = 0.08,
	[10] = 0.08,
	[11] = 0.08,
	[12] = 0.08,
	[13] = 0.08,
	[14] = 0.08,
	[15] = 0.08,
	[16] = 0.08,
	[17] = 0.08,
	[18] = 0.08,
	[19] = 0.08,
	[20] = 0.2,
	[21] = 0.2,
	[22] = 0.2,
	[23] = 0.2,
	[24] = 0.5,
}

local function awakenFunc( one )
	-- body
	if one:isMonster() then
		return 0
	end
	local awaken = one.awaken
	return Awaken_Effect_Rate[awaken] or 0
end


function Formula.calcCore(one, another, skillid, crit, index)
	-- body
	assert(index)

	local printHP = function ()
		-- body
		print(string.format('攻击者=%d, 最大血量=%f, 当前血量=%f', one:getDyId(), one:getBasicHpD(), one:getHpD()))
		print(string.format('受击者=%d, 最大血量=%f, 当前血量=%f', another:getDyId(), another:getBasicHpD(), another:getHpD()))
	end

	if one:isDisposed() or another:isDisposed() then
		return 0
	end

	local skillVo = CfgHelper.getCache('skill', 'id', skillid)
	skilltype = skillVo.skilltype or 1

	if skilltype == SkillUtil.SkillType_JinZhan then
		--近战

		if crit then
			return funcAndPrint( function() 
				printHP()
				return Formula.calcShortCrit(one, another, skillVo, index)
			end, '计算近战暴击')
		else
			return funcAndPrint( function() 
				printHP()
				return Formula.calcShortNormal(one, another, skillVo, index)
			end, '计算近战普通')
		end
	elseif skilltype == SkillUtil.SkillType_YuanCheng then
		--远程
		if crit then
			return funcAndPrint( function() 
				printHP()
				return Formula.calcRemoteCrit(one, another, skillVo, index)
			end, '计算远程暴击')
			-- return Formula.calcRemoteCritAttack(one, another, skillVo)
		else
			return funcAndPrint( function() 
				printHP()
				return Formula.calcRemoteNormal(one, another, skillVo, index)
			end, '计算远程普通')
			-- return Formula.calcRemoteAttack(one, another, skillVo)
		end
	elseif skilltype == SkillUtil.SkillType_YuanChengJinZhan then

		if crit then
			return funcAndPrint( function() 
				printHP()
				return Formula.calcRemoteShortCrit(one, another, skillVo, index)
			end, '计算远程近战暴击')
			-- return Formula.calcRemoteCritShortAttack(one, another, skillVo)
		else
			return funcAndPrint( function() 
				printHP()
				return Formula.calcRemoteShortNormal(one, another, skillVo, index)
			end, '计算远程近战普通')
			-- return Formula.calcRemoteShortAttack(one, another, skillVo)
		end

	elseif skilltype == SkillUtil.SkillType_ZiLiao then
		--治疗
		return funcAndPrint( function() 
			printHP()
			return Formula.calcBasicCure(one, another, skillVo, index)
		end, '计算基础治疗')
		-- return Formula.calcCureAction(one, another, skillVo)

	elseif skilltype == SkillUtil.SkillType_DaZhaoAttack then
		--大招攻击

		return funcAndPrint( function() 
			printHP()
			return Formula.calcSkillAttack(one, another, skillVo, index)
		end, '计算大招攻击')
		-- return Formula.calcSkillAttack(one, another, skillVo)
	elseif skilltype == SkillUtil.SkillType_DaZhaoZhiLiao then
		--大招治疗

		return funcAndPrint( function() 
			printHP()
			return Formula.calcSkillCure(one, another, skillVo, index)
		end, '计算大招治疗')
		-- return Formula.calcCureAction(one, another, skillVo)
	elseif skilltype == SkillUtil.SkillType_DaZhaoSpecial then
		--特殊大招
		--102029	熔岩风暴	攻击自身周围2格范围内的所有敌人也包括自己,对敌人造成自己生命值上限130%的伤害,对自己造成生命值上限50%的伤害。

		return funcAndPrint( function() 
			printHP()
			return Formula.calcSkillSpecial(one, another, skillVo, index)
		end, '计算特殊大招-熔岩风暴')
	elseif skilltype == SkillUtil.SkillType_Dance then
		--歌舞类,没有伤害
		return 0
	else
		print('error:skilltype='..skilltype..' 没有对应计算公式!')
		return 0
	end
end

function Formula.calcFinalDef( one, another )
	-- body
	return math.max(another.def - one.bd, 0)
end

function Formula.calcFinalCof( one, another )
	-- body
	local cof = getCof(one, another) + (one.gb['k'] or 0) - (another.gb['?'] or 0)
	return cof 
end

function Formula.calcBasicValue( one, another )
	-- body
	local finalDef = Formula.calcFinalDef(one, another)

	local onebuffarray = one:getBuffArray()
	local passitiveAdd = onebuffarray:getValueByKey( GHType.GH_Atk ) or 0

	local basicValue = (one.atk/10)*(1+passitiveAdd)*(1-0.0006*finalDef)/(7+0.0006*finalDef)

	local info = string.format('最终防御=%.2f, 被动攻击加成=%.2f, 基础伤害=%.2f.', finalDef, passitiveAdd, basicValue)
	print(info)

	return basicValue
end


--计算近战普通
function Formula.calcShortNormal( one, another, skillVo, index)
	-- body
	local onebuffarray = one:getBuffArray()
	local anotherbuffarray = another:getBuffArray()

	--攻方被动技能加成 
	local abilityAdd = onebuffarray:getValueByKey( GHType.GH_Atk ) or 0

	--受方技能对伤害的减免 或 增加 ?
	local moreHurtBeAttacker = anotherbuffarray:getValueByKey( GHType.GH_MoreHurt_BeAttacker ) or 0

	--破冰伤害加成
	local frozenStateAdd = (anotherbuffarray:getValueByKey( GHType.GH_Frozen ) and 0.3) or 0

	--异常的额外加成
	local abnormalAdd = 0
	do 
		local poisonAdd = (anotherbuffarray:getValueByKey(GHType.GH_Poison) and onebuffarray:getValueByKey(GHType.GH_PoisonHurtMore)) or 0
		local blindAdd = (anotherbuffarray:getValueByKey(GHType.GH_Blind) and onebuffarray:getValueByKey(GHType.GH_BlindHurtMore)) or 0
		local frozenAdd = (anotherbuffarray:getValueByKey(GHType.GH_Frozen) and onebuffarray:getValueByKey(GHType.GH_FrozenHurtMore)) or 0
		local sleepAdd = (anotherbuffarray:getValueByKey(GHType.GH_Sleep) and onebuffarray:getValueByKey(GHType.GH_SleepHurtMore)) or 0
		local slowAdd = (anotherbuffarray:getValueByKey(GHType.GH_Slow) and onebuffarray:getValueByKey(GHType.GH_SlowHurtMore)) or 0

		abnormalAdd = math.max(abnormalAdd, poisonAdd) 
		abnormalAdd = math.max(abnormalAdd, blindAdd) 
		abnormalAdd = math.max(abnormalAdd, frozenAdd) 
		abnormalAdd = math.max(abnormalAdd, sleepAdd) 
		abnormalAdd = math.max(abnormalAdd, slowAdd) 
	end

	--属性相克系数
	local cof = getCof(one.atr, another.atr)
	local cofImm = 1
	local rand = 1 or (0.95+0.1*Random.ranF())

	local defcof = (1-0.7*0.01*another.def/(5+0.01*another.def))

	local atk = one.atk*0.1*(1 + abilityAdd) * (1+moreHurtBeAttacker) * (1 + frozenStateAdd + abnormalAdd)

	local ret = -atk * rand * defcof * cof * cofImm

	local attackerInfo = string.format('攻击者 职业=%s,Id=%s,atk=%s,atr=%s', one:getCareer(), one:getDyId(), one.atk, one.atr)
	local defenderInfo = string.format('防御者 职业=%s,Id=%s,def=%s,atr=%s', another:getCareer(), another:getDyId(), another.def, another.atr)
	local calcInfo = string.format('结果=%s,rand=%s,被动攻击力加成=%s,受方伤害光环增加(减免)=%s,破冰加成=%s,其他异常加成=%s,属性相克=%s,属性免疫=%s',
		tostring(ret), tostring(rand), tostring(abilityAdd), tostring(moreHurtBeAttacker), tostring(frozenStateAdd), tostring(abnormalAdd), tostring(cof),
		tostring(cofImm))
	
	print(attackerInfo)
	print(defenderInfo)
	print(calcInfo)

	return ret
end

--计算近战暴击
function Formula.calcShortCrit( one, another, skillVo, index)
	-- body
	-- print('calcBasicCriAttack')
	local ret = Formula.calcShortNormal(one, another, skillVo, index)

	local abilityAdd = one:getBuffArray():getValueByKey(GHType.GH_CritRate) or 0
	print(string.format('暴击系数加成=%s', tostring(abilityAdd)))

	return ret * ( 1.5 + abilityAdd )
end

--计算远程普通
function Formula.calcRemoteNormal( one, another, skillVo, index )
	-- body
	local ret = Formula.calcShortNormal(one, another, skillVo, index)

	local remoteGuard = 0
	local career = another:getCareer()
	if career == TypeRole.Career_QiShi then
		remoteGuard = 0.5
	end

	local attackerAbility = one:getBuffArray():getValueByKey(GHType.GH_RemoteAttack) or 0
	local defenderAbility = another:getBuffArray():getValueByKey(GHType.GH_RemoteGuard) or 0

	local through_gh = one:getBuffArray():getValueByKey(GHType.GH_FlyThrough) or 0
	local throughRate = 1

	if type(index) ~= 'number' then
		assert(false)
	end

	for i=2,index do
		throughRate = throughRate * through_gh
	end

	print(string.format('远程攻击加成=%s,远程守护(职业)=%s,远程守护加成(被动)=%s, 穿透率=%s', tostring(attackerAbility), tostring(remoteGuard), tostring(defenderAbility), tostring(throughRate)))

	return ret * math.max(0, (1-remoteGuard-defenderAbility)) * (1 + attackerAbility) * throughRate
end

--计算远程暴击
function Formula.calcRemoteCrit( one, another, skillVo, index)
	-- body
	local ret = Formula.calcRemoteNormal(one, another, skillVo, index)

	local abilityAdd = one:getBuffArray():getValueByKey(GHType.GH_CritRate) or 0
	print(string.format('暴击系数加成=%s', tostring(abilityAdd)))

	return ret * ( 1.5 + abilityAdd )
end

--计算远程近战普通
function Formula.calcRemoteShortNormal(one, another, skillVo, index)
	-- body
	local ret = Formula.calcRemoteNormal(one, another, skillVo, index)

	--远程近战惩罚
	-- GH_RemoteShortPunish
	-- local punish = 0.5 + (one:getBuffArray():getValueByKey(GHType.GH_RemoteShortPunish) or 0)

	local rate = math.max(0.5, one:getBuffArray():getValueByKey(GHType.GH_RemoteShortAttack) or 0 )
	print(string.format('远程近战攻击系数=%s', tostring(rate)))

	return ret * rate
end

--计算远程近战暴击
function Formula.calcRemoteShortCrit(one, another, skillVo, index)
	-- body
	local ret = Formula.calcRemoteShortNormal(one, another, skillVo, index)

	local abilityAdd = one:getBuffArray():getValueByKey(GHType.GH_CritRate) or 0
	print(string.format('暴击系数加成=%s', tostring(abilityAdd)))

	return ret * ( 1.5 + abilityAdd )
end

--计算大招攻击
function Formula.calcSkillAttack( one, another, skillVo, index)
	-- body
	local ret = Formula.calcShortNormal(one, another, skillVo, index)
	
	--主动技能系数
	--被动技能系数
	--攻方连锁系数
	--攻方角色觉醒阶数对主动伤害的加成百分比
	-- local skillVo = CfgHelper.getCache('skill', 'id', skillid)

	local activeAdd = skillVo.skillatkadd

	local abilityAdd = one:getBuffArray():getValueByKey( GHType.GH_MoreHurt_Attacker ) or 0

	local chainEffectRate = SkillChainManager.getChainEffectRate( one:getDyId() )

	local awakenEffectRate = awakenFunc(one)

	print(string.format('主动技能系数=%s, 技能伤害系数加成=%s, 连锁系数=%s, 觉醒阶数系数=%s', tostring(activeAdd), tostring(abilityAdd), tostring(chainEffectRate), tostring(awakenEffectRate)))

	return ret * ( 1 + activeAdd + abilityAdd + chainEffectRate ) * (1 + awakenEffectRate)
end

--计算基础治愈
function Formula.calcBasicCure( one, another, skillVo, index )
	-- body
	-- assert( one:isMonster() == another:isMonster() )
	if another:getHpP() >= 100 then
		--不应该发生
		return 0
	end

	local healAdd = (one:getBuffArray():getValueByKey(GHType.GH_MoreHeal) or 0) 
	local abilityAdd = one:getBuffArray():getValueByKey( GHType.GH_Atk ) or 0
	local ret = one.atk*(1 + abilityAdd + healAdd) * 0.04

	print(string.format('基础治愈, 技能被动加成=%s, 治愈加成系数=%s', tostring(abilityAdd), tostring(healAdd)))

	return ret
end

--计算大招治愈
function Formula.calcSkillCure( one, another, skillVo , index)
	-- body
	if another:getHpP() >= 100 then
		--不应该发生
		return 0
	end

	local basicRet = Formula.calcBasicCure( one, another, skillVo )

	--基础回复*(1+主动技能系数 + 被动技能对技能伤害的影响 + 连锁系数)

	local activeAdd = skillVo.skillatkadd
	local abilityAdd = one:getBuffArray():getValueByKey( GHType.GH_MoreHurt_Attacker ) or 0

	local chainEffectRate = SkillChainManager.getChainEffectRate( one:getDyId() )
	local awakenEffectRate = awakenFunc(one)

	local ret = basicRet * ( 1 + activeAdd + abilityAdd + chainEffectRate) * (1 + awakenEffectRate) 

	print(string.format('治愈, 技能主动加成=%s, 技能被动加成=%s, 觉醒系数=%s', tostring(activeAdd), tostring(abilityAdd), tostring(awakenEffectRate)))

	return ret
end

--计算特殊大招-熔岩风暴
function Formula.calcSkillSpecial( one, another, skillVo , index)
	-- body
	--102029	熔岩风暴	攻击自身周围2格范围内的所有敌人也包括自己,对敌人造成自己生命值上限130%的伤害,对自己造成生命值上限50%的伤害。
	local max = one:getBasicHpD()
	if one == another then
		return -one:getHpD() * 0.5
	else
		
		local abilityAdd = one:getBuffArray():getValueByKey( GHType.GH_MoreHurt_Attacker ) or 0
		-- local abilityAdd2 = another:getBuffArray():getValueByKey( GHType.GH_MoreHurt_BeAttacker ) or 0

		local chainEffectRate = SkillChainManager.getChainEffectRate( one:getDyId() )
		local awakenEffectRate = awakenFunc(one)

		-- print(string.format('治愈, 技能主动加成=%s, 技能被动加成=%s, 觉醒系数=%s', tostring(activeAdd), tostring(abilityAdd), tostring(awakenEffectRate)))

		return -max * 1.3 * ( 1 + abilityAdd + chainEffectRate ) * ( 1 + awakenEffectRate )
	end
end

--[[
one 攻击者
another 被攻击者
skillid 技能id
crit 是否暴击
index 被攻击者是第几位
--]]
function Formula.calc( one, another, skillid, crit, index )
	-- body
	-- print('Formula.calc')
	-- print(type(index))
	return Formula.calcCore( one, another, skillid, crit, index) 
end

return Formula