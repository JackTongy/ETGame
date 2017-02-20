
--- 技能表参数枚举

local SkillUtil={}

SkillUtil.Type_Circle = 2
SkillUtil.Type_Line = 1
SkillUtil.Type_Line2 = 3 --没有方向性


-- buff 特效放的层级的位置 
--人物上层
SkillUtil.Layer_Role_Up = 1
--人物下层
SkillUtil.Layer_Role_Down = 2 
--天空层
SkillUtil.Layer_Sky = 3
--地面层
SkillUtil.Layer_Floor = 4
--飞行道具
SkillUtil.Layer_FlyTool = 5
--角色层次
SkillUtil.Layer_Role = 6

SkillUtil.Layer_Role_Y = 7

SkillUtil.Layer_Role_Sky = 8

--被攻击者上层
SkillUtil.Layer_Target_Up = 9

--攻击者动机特效, Y跟随攻击者, X水平居中
SkillUtil.Layer_Role_Y_Stay = 10

--地震
SkillUtil.Layer_Earth_Quake = 100

--音效
SkillUtil.Layer_Sound = 200


--- buff 类型

--盲目buff
-- SkillUtil.BuffType_ManMu=1

-- --	缓速	buff
-- SkillUtil.BuffType_HuanSu=2

-- --中毒buff
-- SkillUtil.BuffType_ZhongDu=4

-- --昏迷buff
-- SkillUtil.BuffType_HunMi=5

-- --冻结buff
-- SkillUtil.BuffType_DongJie=6
-- --护盾
-- SkillUtil.BuffType_HuDun=7
-- --持续伤害buff
-- SkillUtil.BuffType_ChiXunShangHai=8
-- --持续防御
-- SkillUtil.BuffType_ChiXuFangYu=9
-- --回血
-- SkillUtil.BuffType_HuiXue=10
-- --全部驱散
-- SkillUtil.BuffType_QuanBuQuSan=11
-- --免疫冻结
-- SkillUtil.BuffType_MianYiDongJie=12
-- --全部免疫
-- SkillUtil.BuffType_QuanBuMianYi=13
-- SkillUtil.BuffType_HuoShuXingShangHaiJianMian=14

--- buff类型

-- GHType.GH_Poison = 1 --中毒异常
-- GHType.GH_Blind = 2 --致盲异常
-- GHType.GH_Frozen = 3 --冻结异常
-- GHType.GH_Sleep = 4 --昏睡异常
-- GHType.GH_Slow = 5 --缓速异常

--冻结
SkillUtil.BuffType_Freeze=3
--昏迷
SkillUtil.BuffType_Coma=4
--致盲
SkillUtil.BuffType_Blind=2

--中毒
SkillUtil.BuffType_Poison=1

--缓速
SkillUtil.BuffType_Slow=5

-- 弓箭贯通敌人
SkillUtil.BuffType_GuangChuang=93

--
SkillUtil.BuffType_HealLarger=91
SkillUtil.BUffType_HealLarger1 = 95

--歌舞类buff
SkillUtil.BuffType_GeWu= 110








--持续性buff  特效只播放一次后就remove掉
SkillUtil.BuffState_Continue=1
--状态性的buff  特效一直在不断播放
SkillUtil.BuffState_State=2



--buff 特效不具备方向性
SkillUtil.BuffDirection_NotHas=0
-- buff特效具备方向性
SkillUtil.BuffDirection_Has=1






-- SkillUtil.SkillTarget_

SkillUtil.SkillTarget_Self=1  --自身


SkillUtil.SkillTarget_FriendExceptSelf=3  --友军 不包含自己

SkillUtil.SkillTarget_Friend=4  --友军 包含自己

SkillUtil.SkillTarget_FirstEnemy=5  --第一名敌军


-- SkillUtil.SkillTarget_Self=4  --

SkillUtil.SkillTarget_Enemy=7  --所有敌军

SkillUtil.SkillTarget_System=8 --添加给系统的


SkillUtil.SkillTarget_RandomEnemy=9 --随机敌军

--正前方最后一名敌军
SkillUtil.SkillTarget_LastEnemy=11

--当前目标
SkillUtil.SkillTarget_CurrentTarget=12

--除自身外的我方战士
SkillUtil.SkillTarget_ZhanshiExceptSelf=13

SkillUtil.SkillTarget_YuanChengExceptSelf=14

--我方血量最低的角色
SkillUtil.SkillTarget_MinHp = 15

--自己和区域内所有敌军
SkillUtil.SkillTarget_AllEnemyAndSelf = 16

--战士,骑士
SkillUtil.SkillTarget_All_Friend_Physics = 17  

--法师,牧师
SkillUtil.SkillTarget_All_Friend_Magic = 18

SkillUtil.SkillTarget_All_Enemy_Physics = 19
--敌方所有远程和治疗
SkillUtil.SkillTarget_All_Enemy_CureRemote = 20
--资质比自己高或相等
SkillUtil.SkillTarget_All_Enemy_HighterQual = 21
--资质比自己低或相等
SkillUtil.SkillTarget_All_Enemy_LowerQual = 22

---战斗类型判断   fightEffect type
--近战
SkillUtil.fightType_1 = 1

--远程 飞行道具战斗模式
SkillUtil.fightType_2 = 2

SkillUtil.fightType_3 = 3

SkillUtil.fightType_4 = 4




---技能类型   skilltype

SkillUtil.SkillType_Passive=-1

SkillUtil.SkillType_JinZhan=1


SkillUtil.SkillType_YuanCheng=2

SkillUtil.SkillType_ZiLiao=3

SkillUtil.SkillType_YuanChengJinZhan = 4

SkillUtil.SkillType_DaZhaoAttack=11

SkillUtil.SkillType_DaZhaoZhiLiao=12

SkillUtil.SkillType_DaZhaoSpecial=13

SkillUtil.SkillType_Dance = 14


SkillUtil.Condition_Calc = 1

SkillUtil.Condition_HpEqual = 2
SkillUtil.Condition_HpLittle = 3
SkillUtil.Condition_HpGreater = 4

SkillUtil.Condition_FightRound = 5
SkillUtil.Condition_FightBossRound = 6

SkillUtil.Condition_OnBattleField = 7
SkillUtil.Condition_OnBenchFiled = 9

SkillUtil.Condition_BattleFieldType = 8

SkillUtil.Condition_KillAnEnemyForAll = 21
SkillUtil.Condition_KillAnEnemy = 10
SkillUtil.Condition_LoseAFriend = 11

SkillUtil.Condition_WhatEver = 12

SkillUtil.Condition_OnFightCrit = 13
SkillUtil.Condition_OnFightNormal = 14
SkillUtil.Condition_OnFightNormalAndKill = 15
SkillUtil.Condition_Win = 16

SkillUtil.Condition_OnFightSkill = 17

SkillUtil.Condition_BeforeFightCrit = 18
SkillUtil.Condition_BeforeFightNormal = 19
SkillUtil.Condition_BeforeFightSkill = 20

SkillUtil.Condition_BeforeFightCure = 22
SkillUtil.Condition_BeforeFightNormalGK = 23

SkillUtil.Condition_BeNormalAttacked = 24 --受到普通攻击时

SkillUtil.Condition_PreSecond5 = 25
SkillUtil.Condition_PreSecond10 = 26
SkillUtil.Condition_RoleTypeYuanChengZiLiao = 27 --敌方是治疗或远程

SkillUtil.Condition_GH28_Active = 28 --当28号光环生效
SkillUtil.Condition_EnemyProDiffSelf = 29 --战斗计算前且敌方与自身属性不同时
SkillUtil.Condition_EnemyCareerDiffSelf = 30--战斗计算前且敌方与自身职业不同时

SkillUtil.Condition_31 = 31 --战斗计算时，敌方的血量低于XXX （XXX填在条件参数里） 
SkillUtil.Condition_32 = 32 --普通攻击时，当对方有203号光环时
SkillUtil.Condition_33 = 33 --战斗计算时，对方为守护型

SkillUtil.LabelMap = {
	[1] = '在战斗计算中',
	[2] = 'hp 等于',
	[3] = 'hp 小于',
	[4] = 'hp 大于',

	[5] = '战斗回合',
	[6] = 'Boss波回合',

	[7] = '位于战场',
	[8] = '战场地形',
	[9] = '位于替补',

	[10] = '击退一位敌人',
	[11] = '败退一位友军',
	[12] = '无条件',

	[13] = '战斗暴击时',
	[14] = '战斗普通攻击时',
	[15] = '普通攻击打败敌人',

	[16] = '战斗胜利',
}




return SkillUtil