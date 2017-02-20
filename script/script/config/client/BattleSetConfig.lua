--[[
	name = 名称
Key = 键
Value = 值
Des = 描述

--]]
local _table = {
	[1] = {	name = [[神兽降临技能释放CD]],	Key = [[SpecialBossSkillCD]],	Value = {99,5},	Des = [[神兽降临BOSS技能释放CD]],},
	[2] = {	name = [[BOSS战技能释放CD]],	Key = [[BossActiveSkillCD]],	Value = {28,5},	Des = [[BOSS战技能释放CD]],},
	[3] = {	name = [[神兽降临战斗限时]],	Key = [[SpecialBossTimeLimit]],	Value = 30,	Des = [[神兽降临战斗限时]],},
	[4] = {	name = [[BOSS战战斗限时]],	Key = [[BossActiveTimeLimit]],	Value = 40,	Des = [[BOSS战战斗限时]],},
	[5] = {	name = [[乱入怪掉落位置中心点]],	Key = [[appearposition]],	Value = {0.5,0},	Des = [[乱入怪掉落位置中心点]],},
	[6] = {	name = [[乱入怪掉落位置区域]],	Key = [[appearsize]],	Value = {2,3},	Des = [[乱入怪掉落位置区域]],},
	[7] = {	name = [[成长怪成长时间间隔]],	Key = [[growtime]],	Value = 3,	Des = [[成长怪成长时间间隔]],},
	[8] = {	name = [[成长怪体积成长比例]],	Key = [[sizegrow]],	Value = 0.1000,	Des = [[成长怪体积成长比例]],},
	[9] = {	name = [[成长怪攻击成长比例]],	Key = [[atkgrow]],	Value = 0.2000,	Des = [[成长怪攻击成长比例]],},
	[10] = {	name = [[成长怪初始体积]],	Key = [[basesize]],	Value = 0.7000,	Des = [[成长怪初始体积]],},
	[11] = {	name = [[成长怪初始攻击]],	Key = [[baseatk]],	Value = 1,	Des = [[成长怪初始攻击]],},
	[12] = {	name = [[竞技场战斗时间]],	Key = [[arenatime]],	Value = 150,	Des = [[竞技场战斗时间]],},
	[13] = {	name = [[喵喵战斗时间]],	Key = [[cattime]],	Value = 30,	Des = [[喵喵战斗时间]],},
	[14] = {	name = [[竞技场技能间隔时间]],	Key = [[arenaskilltime]],	Value = 2,	Des = [[arenaskilltime]],},
	[15] = {	name = [[战斗出场无敌时间]],	Key = [[battleunatktime]],	Value = 2.8000,	Des = [[战斗出场无敌时间]],},
	[16] = {	name = [[竞技场血量倍数]],	Key = [[arenahp]],	Value = 1.3000,	Des = [[竞技场血量倍数]],},
	[17] = {	name = [[骑士远程伤害下降百分比]],	Key = [[knightdefend]],	Value = 0.2500,	Des = [[骑士远程伤害下降百分比]],},
	[18] = {	name = [[自动回复战斗公式计算系数]],	Key = [[curepercent]],	Value = 0.0500,	Des = [[自动回复战斗公式计算系数]],},
	[19] = {	name = [[战斗加速解锁等级]],	Key = [[battlespeedupunlock]],	Value = 5,	Des = [[战斗加速解锁等级]],},
	[20] = {	name = [[战斗加速是否显示]],	Key = [[battlespeedupvisible]],	Value = 1,	Des = [[1为显示 0为不显示]],},
	[21] = {	name = [[竞技场怒气回复倍数]],	Key = [[arenaenergy]],	Value = 1.5000,	Des = [[竞技场怒气回复倍数]],},
	[22] = {	name = [[冲锋怪释放技能前攻击次数]],	Key = [[rushatktimes]],	Value = 3,	Des = [[冲锋怪释放技能前攻击次数]],},
	[23] = {	name = [[自动战斗解锁等级]],	Key = [[autofightunlocklv]],	Value = 1,	Des = [[自动战斗解锁等级]],},
	[24] = {	name = [[开场战斗提示]],	Key = [[FirstBattleTips]],	Value = [[开启声音，有惊喜哟！]],	Des = [[开启声音，有惊喜哟！]],},
	[25] = {	name = [[远程切换AI所需攻击次数]],	Key = [[hittimes]],	Value = 8,	Des = [[远程切换AI所需攻击次数]],},
	[26] = {	name = [[无尽试炼战斗限时]],	Key = [[AdvBattleTimeLimit]],	Value = 150,	Des = [[无尽试炼战斗限时]],},
	[27] = {	name = [[据点战战斗限时]],	Key = [[GuildFightTimeLimit]],	Value = 150,	Des = [[据点战战斗限时]],},
	[28] = {	name = [[公会战治疗系数]],	Key = [[GuildFightCure]],	Value = 0.6000,	Des = [[公会战治疗系数]],},
	[29] = {	name = [[公会副本战斗限时]],	Key = [[GuildBattleTimeLimit]],	Value = 120,	Des = [[公会副本战斗限时]],},
	[30] = {	name = [[限时探险战斗限时]],	Key = [[TLAdvBattleTimeLimit]],	Value = 120,	Des = [[限时探险战斗限时]],},
	[31] = {	name = [[抢夺战斗限时]],	Key = [[RobBattleTime]],	Value = 150,	Des = [[抢夺战斗限时]],},
}

return _table
