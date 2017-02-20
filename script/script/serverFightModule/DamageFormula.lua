local GHType 			= require 'GHType'
local Random 			= require 'Random'
local CfgHelper 		= require 'CfgHelper'
local TypeRole 			= require 'TypeRole'
local SkillUtil 		= require 'SkillUtil'
local Property 			= require 'property'
local SkillChainManager = require 'SkillChainManager'
local Default 			= require 'Default'
local CSValueConverter  = require 'CSValueConverter'

local CurePercent 	= CfgHelper.getCache('BattleSetConfig', 'Key', 'curepercent', 'Value') or 0.07
local KnightDefend 	= CfgHelper.getCache('BattleSetConfig', 'Key', 'knightdefend', 'Value') or 0.25
local GuildFightCure = CfgHelper.getCache('BattleSetConfig', 'Key','GuildFightCure','Value') or 0.7

local function getCof( one, another )
	-- body
	local atr1 = one.atr
	local atr2 = another.atr

	if require 'ServerRecord'.getMode() == 'guildfuben' then
		Property = require 'PropertyGuild' --公会副本属性规则
	else
		Property = require 'property'
	end

	for i,v in ipairs(Property) do
		if v.atr == atr1 and v.atr2 == atr2 then
			return v.coefficient
		end
	end
	error('warning:getCof('..tostring(atr1)..','..tostring(atr2)..')') 
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
	if require 'ServerRecord'.isArenaMode() then
		local awaken = one.awaken
		return Awaken_Effect_Rate[awaken] or 0
	end

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
				return math.min(Formula.calcShortCrit(one, another, skillVo, index), -1)
			end, '计算近战暴击')
		else
			return funcAndPrint( function() 
				printHP()
				return math.min(Formula.calcShortNormal(one, another, skillVo, index), -1)
			end, '计算近战普通')
		end
	elseif skilltype == SkillUtil.SkillType_YuanCheng then
		--远程
		if crit then
			return funcAndPrint( function() 
				printHP()
				return math.min(Formula.calcRemoteCrit(one, another, skillVo, index), -1)
			end, '计算远程暴击')
			-- return Formula.calcRemoteCritAttack(one, another, skillVo)
		else
			return funcAndPrint( function() 
				printHP()
				return math.min(Formula.calcRemoteNormal(one, another, skillVo, index), -1)
			end, '计算远程普通')
			-- return Formula.calcRemoteAttack(one, another, skillVo)
		end
	elseif skilltype == SkillUtil.SkillType_YuanChengJinZhan then

		if crit then
			return funcAndPrint( function() 
				printHP()
				return math.min(Formula.calcRemoteShortCrit(one, another, skillVo, index), -1)
			end, '计算远程近战暴击')
			-- return Formula.calcRemoteCritShortAttack(one, another, skillVo)
		else
			return funcAndPrint( function() 
				printHP()
				return math.min(Formula.calcRemoteShortNormal(one, another, skillVo, index), -1)
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
			return math.min(Formula.calcSkillAttack(one, another, skillVo, index), -1)
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
		-- return 0
		return funcAndPrint( function() 
			printHP()
			return Formula.calcSkillCure(one, another, skillVo, index)
		end, '计算歌舞治疗')
	else
		print('error:skilltype='..skilltype..' 没有对应计算公式!')
		return 0
	end
end

function Formula.calcFinalDef( one, another )
	-- body
	local onebuffarray = one:getBuffArray()
	local anotherbuffarray = another:getBuffArray()
	local ov = (one.gb['o'] or 0) - (another.eb['9'] or 0)
	ov = math.max(0,ov)

	print(string.format('calcFinalDef:%f*(1+%f+%f-%f)',another.def,(anotherbuffarray:getValueByKey(GHType.GH_Def) or 0),(anotherbuffarray:getValueByKey(GHType.GH_233) or 0),ov))
	local def = another.def*(1 + (anotherbuffarray:getValueByKey(GHType.GH_Def) or 0) + (anotherbuffarray:getValueByKey(GHType.GH_233) or 0) - ov )
	return math.max(def - one.bd, 0)
end

function Formula.calcMaxAbnormalAdd( one, another )
	-- body
	local onebuffarray = one:getBuffArray()
	local anotherbuffarray = another:getBuffArray()
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

	return abnormalAdd
end

function Formula.calcBasicValue( one, another )
	-- body
	local finalDef = Formula.calcFinalDef(one, another)

	local onebuffarray = one:getBuffArray()
	local passitiveAdd = onebuffarray:getValueByKey( GHType.GH_Atk ) or 0

	passitiveAdd = passitiveAdd + (onebuffarray:getValueByKey( GHType.GH_AwakeAtk_Add ) or 0)
	passitiveAdd = passitiveAdd + (onebuffarray:getValueByKey( GHType.GH_232 ) or 0)
	-- local mode = require 'ServerRecord'.getMode()
	-- if mode == 'test' or mode == 'guider' then
	-- end
	local rand = Random.ranI(95,105)/100
	
	local basicValue = -( one.atk/10)*rand*(1+passitiveAdd)*(1-0.0006*finalDef/(7+0.0006*finalDef))

	local info = string.format('计算基础伤害: 最终防御=%.2f, 被动攻击加成=%.2f, 随机=%.2f, 结果=%.2f.', finalDef, passitiveAdd, rand, basicValue)
	print(info)
	
	return basicValue
end


--计算近战普通
function Formula.calcShortNormal( one, another, skillVo, index)
	-- body
	local onebuffarray = one:getBuffArray()
	local anotherbuffarray = another:getBuffArray()

	local basicValue = Formula.calcBasicValue(one, another)

	local cof = getCof(one, another) --攻守相克系数
	local cofAdd = 0
	local cofSub = 0

	--守方技能对伤害的减少或者增加
	local moreHurtBeAttacker = anotherbuffarray:getValueByKey( GHType.GH_MoreHurt_BeAttacker ) or 0 
	moreHurtBeAttacker = moreHurtBeAttacker + (anotherbuffarray:getValueByKey( GHType.GH_AwakeDamage ) or 0)
	moreHurtBeAttacker = moreHurtBeAttacker + (anotherbuffarray:getValueByKey( GHType.GH_238) or 0)

	--基础破冰伤害加成
	local basicFrozenStateAdd = (anotherbuffarray:getValueByKey( GHType.GH_Frozen ) and 0.1) or 0
	local attackerFrozenStateAdd = 0
	local defenderFrozenStateSub = 0
	if basicFrozenStateAdd > 0 then
		attackerFrozenStateAdd = one.gb['h'] or 0
		defenderFrozenStateSub = another.gb['j'] or 0
	end
	local frozenAdd = (basicFrozenStateAdd+attackerFrozenStateAdd-defenderFrozenStateSub)
	-- h.提高冰冻伤害
	-- j.减少冰冻伤害
	frozenAdd = math.max(frozenAdd, 0)

	local maxAbnormalAdd = Formula.calcMaxAbnormalAdd(one, another)

	local finalAdd = one.sv
	local finalSub = another.fv

	local value = basicValue*(1+(cof-1)*(1+cofAdd)*(1-cofSub))*(1+moreHurtBeAttacker)*
	(1+frozenAdd+maxAbnormalAdd) 
	- (finalAdd - finalSub)

	value = math.min(value, 0)

	local info = string.format([[计算平砍伤害: 攻守相克=%.2f, 攻方相克加成=%.2f, 守方相克加成=%.2f, 守方对伤害的增加减少=%.2f, 破冰加成=%.2f, 异常加成=%.2f, 最终加伤=%.2f, 最终减伤=%.2f, 结果=%.2f]], cof,cofAdd,cofSub,moreHurtBeAttacker,frozenAdd,maxAbnormalAdd,finalAdd,finalSub,value)
	print(info)
	
	return value
end

--计算近战暴击
function Formula.calcShortCrit( one, another, skillVo, index)
	-- body
	local shortValue = Formula.calcShortNormal(one, another, skillVo, index)

	local critAdd = one.cv
	local abilityAdd = one:getBuffArray():getValueByKey(GHType.GH_CritRate) or 0
	local anotherReduce = another:getBuffArray():getValueByKey(GHType.GH_CritRate_Reduce) or 0
	anotherReduce = anotherReduce + (another:getBuffArray():getValueByKey(GHType.GH_234) or 0)

	local value = shortValue * (critAdd + abilityAdd - anotherReduce)

	local info = string.format('计算近战暴击: 暴击倍数=%.2f, 暴击被动加成=%.2f, GH27=%.2f, 结果=%.2f', critAdd, abilityAdd,anotherReduce,value)
	print(info)

	return value
end


--计算远程普通
function Formula.calcRemoteNormal( one, another, skillVo, index )
	-- body
	local shortValue = Formula.calcShortNormal(one, another, skillVo, index)

	local remoteGuard = 0
	local career = another:getCareer()
	if career == TypeRole.Career_QiShi then
		remoteGuard = KnightDefend
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

	local value = shortValue * math.max(0, (1-remoteGuard-defenderAbility)) * (1 + attackerAbility) * throughRate

	local info = string.format('计算远程攻击: 远程攻击加成=%.2f,远程守护(职业)=%.2f,远程守护加成(被动)=%.2f, 穿透率=%.2f, 结果=%.2f', attackerAbility, remoteGuard, defenderAbility, throughRate, value)
	print(info)

	return value
end


--计算远程暴击
function Formula.calcRemoteCrit( one, another, skillVo, index)
	-- body
	local remoteValue = Formula.calcRemoteNormal(one, another, skillVo, index)

	local critAdd = one.cv
	local abilityAdd = one:getBuffArray():getValueByKey(GHType.GH_CritRate) or 0
	local anotherReduce = another:getBuffArray():getValueByKey(GHType.GH_CritRate_Reduce) or 0
	anotherReduce = anotherReduce + (another:getBuffArray():getValueByKey(GHType.GH_234) or 0)

	local value = remoteValue * (critAdd + abilityAdd - anotherReduce)

	local info = string.format('计算远程暴击: 暴击倍数=%.2f, 暴击被动加成=%.2f, 结果=%.2f', critAdd, abilityAdd,value)
	print(info)

	return value
end


--计算远程近战普通
function Formula.calcRemoteShortNormal(one, another, skillVo, index)
	-- body
	local remoteNormal = Formula.calcRemoteNormal(one, another, skillVo, index)
	local rate = math.max(0.5, one:getBuffArray():getValueByKey(GHType.GH_RemoteShortAttack) or 0 )

	local value = remoteNormal * rate
	local info = string.format('计算远程近战: 远程近战惩罚系数=%.2f, 结果=%.2f', rate, value)

	print(info)

	return value
end


--计算远程近战暴击
function Formula.calcRemoteShortCrit(one, another, skillVo, index)
	-- body
	local remoteShortValue = Formula.calcRemoteShortNormal(one, another, skillVo, index)

	local critAdd = one.cv
	local abilityAdd = (one:getBuffArray():getValueByKey(GHType.GH_CritRate) or 0)

	local value = remoteShortValue * (critAdd + abilityAdd)

	local info = string.format('计算远程近战暴击: 暴击倍数=%.2f, 暴击被动加成=%.2f, 结果=%.2f', critAdd, abilityAdd,value)
	print(info)

	return value
end

--计算大招攻击
function Formula.calcSkillAttack( one, another, skillVo, index)
	-- body
	local shortNormal = Formula.calcShortNormal(one, another, skillVo, index)
	
	--主动技能系数
	--被动技能系数
	--攻方连锁系数
	--攻方角色觉醒阶数对主动伤害的加成百分比
	-- local skillVo = CfgHelper.getCache('skill', 'id', skillid)
	local manaRate = Formula.getCurrentManaRate( one )

	local activeAdd = skillVo.skillatkadd 

	local abilityAdd = one:getBuffArray():getValueByKey( GHType.GH_MoreHurt_Attacker ) or 0
	abilityAdd = abilityAdd + (one:getBuffArray():getValueByKey( GHType.GH_235 ) or 0)

	local chainEffectRate = SkillChainManager.getChainEffectRate( one:getDyId() )

	local awakenEffectRate = awakenFunc(one) 

	local ghRate = (one.gb['m'] or 0)

	local skillSub = (another.gb['l'] or 0)
	skillSub = skillSub + (another:getBuffArray():getValueByKey( GHType.GH_241 ) or 0) + (another.eb['11'] or 0)

	local skilldamageAdd = one:getBuffArray():getValueByKey(GHType.GH_AwakeSkillDamage) or 0
	skilldamageAdd = skilldamageAdd + (one.eb['12'] or 0) --装备技能伤害叠加

	print(string.format('gb %.2f, %.2f', ghRate, skillSub))
	print(string.format('eb %.2f',(one.eb['12'] or 0)))

	local value = manaRate * shortNormal * ( 1 + activeAdd + abilityAdd + chainEffectRate ) * (1 + awakenEffectRate + ghRate + skilldamageAdd) * (1-skillSub)

	local info = string.format('计算大招攻击: 怒气系数=%.2f, 主动技能系数=%.2f, 技能伤害加成=%.2f, 连锁系数=%.2f, 觉醒系数=%.2f, 宝石技能减伤系数=%.2f, 结果=%.2f', 
		manaRate, activeAdd, abilityAdd, chainEffectRate, awakenEffectRate, skillSub, value)
	print(info)

	return value
end


--计算基础治愈
function Formula.calcBasicCure( one, another, skillVo, index )
	-- body
	-- assert( one:isMonster() == another:isMonster() )
	if another:getHpPCure() >= 100 then
		--不应该发生
		return 0
	end

	local healAdd = (one:getBuffArray():getValueByKey(GHType.GH_MoreHeal) or 0) 
	healAdd = healAdd + (one:getBuffArray():getValueByKey(GHType.GH_96) or 0)
	
	local abilityAdd = one:getBuffArray():getValueByKey( GHType.GH_Atk ) or 0
	local zhuangbeiAdd = one.hpR
	
	abilityAdd = abilityAdd + (one:getBuffArray():getValueByKey( GHType.GH_AwakeAtk_Add ) or 0)
	abilityAdd = abilityAdd + (one:getBuffArray():getValueByKey( GHType.GH_232 ) or 0)
	local gh243 = (another:getBuffArray():getValueByKey( GHType.GH_243 ) or 0)

	local poisonRate = 1
	if require 'ServerRecord'.isArenaMode() then
		poisonRate	=  (another:getBuffArray():getValueByKey(GHType.GH_Poison) and 0.5) or 1
	end

	local guildFightCure = 1
	if require 'ServerRecord'.getMode() == 'guildmatch' then
		guildFightCure = GuildFightCure
	end

	local value = one.atk*(1 + abilityAdd + healAdd + zhuangbeiAdd) * CurePercent * poisonRate * guildFightCure*(1-gh243)

	local info = string.format('计算基础治愈: 技能被动加成=%.2f, 治愈加成系数=%.2f, 装备加成=%.2f, 中毒系数=%.2f, 结果=%.2f', abilityAdd, healAdd, zhuangbeiAdd, poisonRate, value)
	print(info)

	value = math.min(value, (another:getBasicHpD() - another:getHpD()))
	value = math.max(value, 0)
	print('最终治疗值:'..value)

	return value
end

--计算大招治愈
function Formula.calcSkillCure( one, another, skillVo , index)
	-- body
	if another:getHpPCure() >= 100 then
		--不应该发生
		return 0
	end

	local manaRate = Formula.getCurrentManaRate( one )

	local basicRet = Formula.calcBasicCure( one, another, skillVo )

	local activeAdd = skillVo.skillatkadd
	local abilityAdd = one:getBuffArray():getValueByKey( GHType.GH_MoreHurt_Attacker ) or 0
	abilityAdd = abilityAdd + (one:getBuffArray():getValueByKey( GHType.GH_235 ) or 0)

	local chainEffectRate = SkillChainManager.getChainEffectRate( one:getDyId() )
	local awakenEffectRate = awakenFunc(one)

	local ghRate = (one.gb['m'] or 0)
	
	local guildFightCure = 1
	if require 'ServerRecord'.getMode() == 'guildmatch' then
		guildFightCure = GuildFightCure
	end

	local value = manaRate * basicRet * ( 1 + activeAdd + abilityAdd + chainEffectRate) * (1 + awakenEffectRate + ghRate) * guildFightCure

	local info = string.format('计算大招治疗: 怒气系数=%.2f, 技能主动加成=%.2f, 技能被动加成=%.2f, 连锁系数=%.2f, 觉醒系数=%.2f, 结果=%.2f', manaRate, activeAdd,abilityAdd,chainEffectRate,awakenEffectRate,value)
	print(info)

	value = math.min(value, (another:getBasicHpD() - another:getHpD()))
	value = math.max(value, 0)
	print('最终治疗值:'..value)

	return value
end

--计算特殊大招-熔岩风暴
function Formula.calcSkillSpecial( one, another, skillVo , index)
	-- body
	--102029	熔岩风暴	攻击自身周围2格范围内的所有敌人也包括自己,对敌人造成自己生命值上限130%的伤害,对自己造成生命值上限50%的伤害。
	
	if one == another then
		local hpD = one:getHpD()
		local value = -hpD * 0.3

		local info = string.format('计算熔岩风暴: 当前血量=%.2f, 结果=%.2f', hpD, value)
		print(info)

		return value
	else
		local manaRate = Formula.getCurrentManaRate( one )

		local max = one:getBasicHpD()
		local abilityAdd = one:getBuffArray():getValueByKey( GHType.GH_MoreHurt_Attacker ) or 0
		abilityAdd = abilityAdd + (one:getBuffArray():getValueByKey( GHType.GH_235 ) or 0)
		local chainEffectRate = SkillChainManager.getChainEffectRate( one:getDyId() )
		local awakenEffectRate = awakenFunc(one)

		local ghRate = (one.gb['m'] or 0)

		local skillSub = (another.gb['l'] or 0)
		
		skillSub = skillSub + (another.eb['11'] or 0) --装备技能抗性

		local value = -max * manaRate * 1.0 * ( 1 + abilityAdd + chainEffectRate ) * ( 1 + awakenEffectRate + ghRate) * (1 - skillSub)
		local info = string.format('计算熔岩风暴: 怒气系数=%.2f, 最大血量=%.2f, 被动加成=%.2f, 连锁系数=%.2f, 觉醒系数=%.2f, 宝石技能减伤=%.2f, 结果=%.2f', manaRate, max, abilityAdd, chainEffectRate, awakenEffectRate, skillSub, value)
		print(info)

		return value
	end
end

local function heroValueCToS( one )
	-- body
	if one and CSValueConverter.shouldConvert( one:isMonster() ) then
		one.atk = CSValueConverter.toS( one.atk ) --攻击
		one.def = CSValueConverter.toS( one.def ) --防御
		one.bd = CSValueConverter.toS( one.bd ) --防御减免
		one.sv = CSValueConverter.toS( one.sv ) --最终减伤
		one.fv = CSValueConverter.toS( one.fv ) --最终加伤
		one.cv = CSValueConverter.toS( one.cv ) --暴击增加
	end
end

local function heroValueSToC( one )
	-- body
	if one and CSValueConverter.shouldConvert( one:isMonster() )  then
		one.atk = CSValueConverter.toC( one.atk ) --攻击
		one.def = CSValueConverter.toC( one.def ) --防御
		one.bd = CSValueConverter.toC( one.bd ) --防御减免
		one.sv = CSValueConverter.toC( one.sv ) --最终减伤
		one.fv = CSValueConverter.toC( one.fv ) --最终加伤
		one.cv = CSValueConverter.toC( one.cv ) --暴击增加
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

	-- 1.push
	-- 2.pop

	if one == another then
		heroValueCToS(one)

		local ret = Formula.calcCore( one, another, skillid, crit, index) 

		heroValueSToC(one)

		return ret
	else
		heroValueCToS(one)
		heroValueCToS(another)

		local ret = Formula.calcCore( one, another, skillid, crit, index) 

		heroValueSToC(one)
		heroValueSToC(another)

		return ret
	end
end

function Formula.setManaRate( manaRate )
	-- body
	Formula._manaRate = manaRate
end

function Formula.reset()
	-- body
	local AlwaysSkill 		= Default.Debug and Default.Debug.release
	Formula._defaultManaRate = (AlwaysSkill and 1 ) or (require 'ServerRecord'.getMode() == 'guider' and 1)
end

function Formula.getCurrentManaRate( one )
	-- body
	if require 'ServerRecord'.isArenaMode() then
		return Formula._defaultManaRate or Formula._manaRate or (one and one:getManaRate()) or 0
	end

	if one:isMonster() then
		return 1
	end

	return Formula._defaultManaRate or Formula._manaRate or (one and one:getManaRate()) or 0
end

return Formula