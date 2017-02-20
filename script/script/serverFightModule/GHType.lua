local GHType = {}

--[[
技能触发条件类型:

--]]

--[[
光环类型：
1   
--]]

--[[
属性：
1   冰  		atr_ice
2   草  		atr_grass
3   电  		atr_electricity
4   毒  		atr_poison
5   格斗 	atr_fight
6   水      	atr_water
7   岩石    	atr_stone
8   火      	atr_fire  
9   一般    	atr_normal
--]]

GHType.GH_Poison = 1 --中毒异常
GHType.GH_Blind = 2 --致盲异常
GHType.GH_Frozen = 3 --冻结异常
GHType.GH_Sleep = 4 --昏睡异常
GHType.GH_Slow = 5 	--缓速异常

--GHType.GH_Heal = 6 --回血光环,指代治疗范围

GHType.GH_AtkSpd = 22 	--攻击速度光环
GHType.GH_Spd = 10 		--速度加成
GHType.GH_Atk = 11 		--攻击力加成 
GHType.GH_Def = 12 		--防御加成

GHType.GH_RemoteGuard = 13 --远程守护加成, 用于计算--远程普通+暴击
GHType.GH_Guard = 14 --守护加成, 没有用到??
GHType.GH_CritRate = 15 --暴击系数加成, 用于计算暴击系数加成
GHType.GH_MoreHurt_Attacker = 16 --技能伤害系数加成, 用于计算伤害
GHType.GH_RemoteAttack = 17 --远程攻击加成, 用于计算--远程普通+暴击
GHType.GH_RemoteShortAttack = 18 --远程近战伤害加成, 用到
--GHType.GH_RemoteShortPunish = 19 --远程近战惩罚减少, 不需要用到
GHType.GH_MaxHp = 20 --生命上限加成或减少, 用于提高血量上限, 注意使用顺序??.
GHType.GH_MoreHurt_BeAttacker = 21 --收到的伤害增加, 用到
GHType.GH_MoreNuqi = 23 --收到的伤害增加, 用到
GHType.GH_Crit 	   = 25 --提升暴击率的光环
GHType.GH_DisableUpBuff = 26 --寂灭光环 生效的单位身上，移除所有 增益BUFF 当26号光环失效后，原本单位身上的增益buff重新生效
GHType.GH_CritRate_Reduce = 27 --暴击伤害减少百分比

GHType.GH_AwakeAtk_Add = 28 --觉醒力量攻击加成 
GHType.GH_AwakeDamage = 29 --觉醒力量受到的伤害增加（减少)
GHType.GH_AwakeSkillDamage = 30 --觉醒力量技能伤害系数加成
GHType.GH_AwakeMana_RevertSpeed = 231 --觉醒力量怒气回复速度加成

GHType.GH_PoisonHurtMore = 31 --中毒异常伤害加成
GHType.GH_BlindHurtMore = 32 --致盲异常伤害加成
GHType.GH_FrozenHurtMore = 33 --冻结异常伤害加成
GHType.GH_SleepHurtMore = 34 --昏迷异常伤害加成
GHType.GH_SlowHurtMore = 35 --缓速异常伤害加成

GHType.GH_GetMoreExp = 41 --获得的经验增加
GHType.GH_GetMoreGold = 42--获得的金钱增加
GHType.GH_GetAP = 43 --获得AP
GHType.GH_Get1Ball = 44 --获得一个能量球
GHType.GH_MoreBoxDrop = 45 --宝箱掉落概率增加
GHType.GH_MoreInitBalls = 46 --初始化对应能量球增加
GHType.GH_More2BallRate = 47 --增加获得2个能量球的概率
GHType.GH_More3BallRate = 48 --增加获得3个能量球的概率

--[[
免疫不再使用光环来表达,直接使用免疫表来表达
GHType.GH_IMM_Poison = 81 --中毒免疫
GHType.GH_IMM_Blind = 82 --致盲免疫
GHType.GH_IMM_Frozen = 83 --冻结免疫
GHType.GH_IMM_Sleep = 84 --昏迷免疫
GHType.GH_IMM_Slow = 85 --缓速免疫
--]]

GHType.GH_SlowLastLess = 86 --缓速时间减少

GHType.GH_HealLarger = 91 --回复范围变大, 没有用到???
GHType.GH_BeatMore = 92 --击飞范围增大
GHType.GH_FlyThrough = 93 --弓箭贯穿, 没有用到???
GHType.GH_MoreHeal = 94 --回复效果加强
GHType.GH_95 	= 95 --技能书回复范围变大 同 91 
GHType.GH_96	= 96 --技能书自动回复效果增强 同94

GHType.GH_MoreNuqi = 23
GHType.GH_MoreNuqi2 = 24 --触发时增加或减少目标的怒气值 （绝对数值，非百分比）

GHType.GH_201	= 201 --该光环生效时，生效的单位身上，移除所有减益BUFF（在buff表中 bufftype字段为0的buff）
GHType.GH_202	= 202 -- 当该光环生效时，生效的单位不会被主动技能击退
GHType.GH_203	= 203 --当该光环生效时，生效的单位在受到伤害时，血量最低为1点

GHType.GH_232   = 232  --技能书攻击加成
GHType.GH_233   = 233  --技能书防御加成
GHType.GH_234   = 234  --技能书受到暴击伤害减少
GHType.GH_235   = 235  --技能书技能伤害系数加成
GHType.GH_236   = 236  --技能书生命上限加成或减少 效果和之前的光环相同，只是独立出来，可以叠加
GHType.GH_237   = 237  --受到伤害不会超出血量上限的N%

GHType.GH_238 	= 238 --技能书受到伤害增加或减少 
GHType.GH_239	= 239 --技能书增加攻速或减少攻速 
GHType.GH_240 	= 240 --技能书怒气增加或减少 同24号光环 
GHType.GH_241 	= 241 --技能书收到技能伤害减少
GHType.GH_242 	= 242 --使对方的203光环移除，并对其造成的伤害固定为99999999
GHType.GH_243	= 243 --受到的治疗量降低
GHType.GH_244   = 244 --对单位造成不计算防御免伤的额外伤害 与中毒的伤害类似

--[[
职业：
1. 战士    zs
2. 骑士    qs
3. 远程    yc
4. 治疗    zl
--]]


-- body
--[[
--]]

local shell = {}

setmetatable(shell, { __index = function ( t,k )
	-- body
	local v = t[k]

	if v then
		return v
	else
		error('Attempt to index '..tostring(k)..' error!')
	end
end, __newindex = function(t,k,v)
	error('Attempt to new index '..tostring(k)..' error!')
end})

return GHType