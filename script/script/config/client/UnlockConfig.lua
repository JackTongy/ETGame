--[[
	Id = Id
name = 模块名
name1 = 模块名1
unlocklv = 解锁等级
townid = 解锁城镇通关(1普通副本,2精英副本)
stageid = 通关关卡
istep = 引导记录点
guidecfg = 引导文件名
enable = 引导开关
msg = 解锁提示语

--]]
local _table = {
	[1] = {	Id = 1,	name = [[EquipFuben]],	name1 = [[装备活动副本]],	unlocklv = 12,	guidecfg = [[GCfgUnlockLv3]],	enable = 1,},
	[2] = {	Id = 2,	name = [[MagicBox]],	name1 = [[神秘盒子]],	unlocklv = 21,	guidecfg = [[GCfgUnlockLv4]],	enable = 1,},
	[3] = {	Id = 3,	name = [[MagicShop]],	name1 = [[神秘商店]],	unlocklv = 9,	guidecfg = [[GCfgUnlockLv5]],	enable = 1,},
	[4] = {	Id = 4,	name = [[Arena]],	name1 = [[竞技场]],	unlocklv = 15,	guidecfg = [[GCfgUnlockLv7]],	enable = 1,},
	[5] = {	Id = 5,	name = [[Team2]],	name1 = [[队伍2]],	unlocklv = 10,	guidecfg = [[GCfgUnlockLv8]],},
	[6] = {	Id = 6,	name = [[EquipTP]],	name1 = [[装备突破 ]],	unlocklv = 32,	guidecfg = [[GCfgUnlockLv11]],	enable = 1,},
	[7] = {	Id = 7,	name = [[BossBattle]],	name1 = [[BOSS战]],	unlocklv = 20,	guidecfg = [[GCfgUnlockLv12]],	enable = 1,},
	[8] = {	Id = 8,	name = [[Guild]],	name1 = [[公会]],	unlocklv = 15,},
	[9] = {	Id = 9,	name = [[RoadOfChampion]],	name1 = [[冠军之塔]],	unlocklv = 28,	guidecfg = [[GCfgUnlockLv14]],	enable = 1,},
	[10] = {	Id = 10,	name = [[Chat]],	name1 = [[聊天]],	unlocklv = 10,},
	[11] = {	Id = 11,	name = [[PetKill]],	name1 = [[神兽降临]],},
	[12] = {	Id = 12,	name = [[PActive]],	name1 = [[潜力激发]],	unlocklv = 34,	guidecfg = [[GCfgUnlockLv18]],	enable = 1,	msg = [[当前尚未触发神兽降临]],},
	[13] = {	Id = 13,	name = [[GoldFuben]],	name1 = [[金币副本]],	unlocklv = 26,	guidecfg = [[GCfgUnlockLv20]],},
	[14] = {	Id = 14,	name = [[PRebirth]],	name1 = [[精灵重生]],	unlocklv = 20,	guidecfg = [[GCfgUnlockLv22]],},
	[15] = {	Id = 15,	name = [[EquipReset]],	name1 = [[装备重铸]],	unlocklv = 36,	guidecfg = [[GCfgUnlockLv24]],	enable = 1,},
	[16] = {	Id = 16,	name = [[EquipRebirth]],	name1 = [[装备回炉]],	unlocklv = 18,	guidecfg = [[GCfgUnlockLv26]],},
	[17] = {	Id = 17,	name = [[Team3]],	name1 = [[队伍3]],	unlocklv = 30,},
	[18] = {	Id = 18,	name = [[GemFuben]],	name1 = [[宝石 ]],	unlocklv = 37,	guidecfg = [[GCfgUnlockLv38]],	enable = 1,},
	[19] = {	Id = 19,	name = [[PetForster]],	name1 = [[精灵觉醒]],	townid = [[2|1]],	guidecfg = [[GCfg01]],	enable = 1,	msg = [[第二个城镇通关后解锁]],},
	[20] = {	Id = 20,	name = [[PetAcademy]],	name1 = [[精灵召唤]],	unlocklv = 1,},
	[21] = {	Id = 21,	name = [[Elite]],	name1 = [[精英副本]],	unlocklv = 11,	guidecfg = [[GCfgUnlockLv6]],	enable = 1,},
	[22] = {	Id = 22,	name = [[EquipOn]],	name1 = [[穿装]],	istep = 1720,},
	[23] = {	Id = 23,	name = [[EvolveFuben]],	name1 = [[进化石副本]],	unlocklv = 27,},
	[24] = {	Id = 24,	name = [[EvolvePet]],	name1 = [[进化]],	unlocklv = 1,	guidecfg = [[GCfgUnlockLv9]],	enable = 1,},
	[25] = {	Id = 25,	name = [[Exploration]],	name1 = [[探宝]],	unlocklv = 22,},
	[26] = {	Id = 26,	name = [[GemFubenNo3]],	name1 = [[宝石位置3]],	unlocklv = 55,},
	[27] = {	Id = 27,	name = [[GemFubenNo4]],	name1 = [[宝石位置4]],	unlocklv = 65,},
	[28] = {	Id = 28,	name = [[GCfgUnlockLv2]],	name1 = [[2级给装备]],	unlocklv = 2,	guidecfg = [[GCfgUnlockLv2]],	enable = 1,},
	[29] = {	Id = 29,	name = [[EquipNiudan]],	name1 = [[装备扭蛋]],	unlocklv = 14,	guidecfg = [[GCfg11]],	enable = 1,},
	[30] = {	Id = 30,	name = [[BattleSpeed]],	name1 = [[扫荡]],	unlocklv = 16,	guidecfg = [[GCfg12]],	enable = 1,},
	[31] = {	Id = 31,	name = [[Charge]],	name1 = [[充值引导]],	unlocklv = 3,	guidecfg = [[GCfg13]],	enable = 1,},
	[32] = {	Id = 32,	name = [[lvup]],	name1 = [[升级]],	townid = [[1|2]],	guidecfg = [[GCfg06]],	enable = 1,	msg = [[通关月见山后解锁]],},
	[33] = {	Id = 33,	name = [[ranklist]],	name1 = [[排行榜]],	unlocklv = 28,},
	[34] = {	Id = 34,	name = [[MagicBoxUnlock]],	name1 = [[神秘盒子解锁等级]],	unlocklv = 14,},
	[35] = {	Id = 35,	name = [[TownClearReward]],	name1 = [[通关奖励引导]],	townid = [[1|7]],	guidecfg = [[GCfg16]],	enable = 1,	msg = [[第二个城镇通关后解锁]],},
	[36] = {	Id = 36,	name = [[PetEvolve]],	name1 = [[精灵进化]],	stageid = 10402,	guidecfg = [[GCfg17]],	enable = 1,},
	[37] = {	Id = 37,	name = [[ChampionshipLv]],	name1 = [[冠军联赛解锁]],	unlocklv = 37,},
	[38] = {	Id = 38,	name = [[AdventureLv]],	name1 = [[无尽试炼解锁]],	unlocklv = 23,	guidecfg = [[GCfg18]],	enable = 1,},
	[39] = {	Id = 39,	name = [[Adventure1Lv]],	name1 = [[无尽试炼难度2解锁]],	unlocklv = 35,},
	[40] = {	Id = 40,	name = [[Adventure2Lv]],	name1 = [[无尽试炼难度3解锁]],	unlocklv = 47,},
	[41] = {	Id = 41,	name = [[Adventure3Lv]],	name1 = [[无尽试炼难度4解锁]],	unlocklv = 65,},
	[42] = {	Id = 42,	name = [[OneKeyEquipUp]],	name1 = [[装备一键强化解锁等级]],	unlocklv = 20,},
	[43] = {	Id = 43,	name = [[Mibao]],	name1 = [[秘宝解锁等级]],	unlocklv = 45,},
	[44] = {	Id = 44,	name = [[GuildCopyLv]],	name1 = [[狩猎场解锁等级]],	unlocklv = 40,},
	[45] = {	Id = 45,	name = [[FetterAdd]],	name1 = [[羁绊共鸣解锁等级]],	unlocklv = 50,},
	[46] = {	Id = 46,	name = [[Remain]],	name1 = [[古代遗迹解锁等级]],	unlocklv = 55,},
	[47] = {	Id = 47,	name = [[watergift]],	name1 = [[心之水滴解锁等级]],	unlocklv = 45,},
	[48] = {	Id = 48,	name = [[StoneFuben]],	name1 = [[传奇工匠解锁等级]],	unlocklv = 60,},
	[49] = {	Id = 49,	name = [[HeroElite]],	name1 = [[英雄副本]],	unlocklv = 80,	guidecfg = [[GCfg20]],	enable = 1,},
}

return _table
