--[[
	gemid = 宝石id
type = 类型
name = 名称
location = 装备部位
effect1 = 效果1
effect2 = 效果2
description = 说明

--]]
local _table = {
	[1] = {	gemid = 1,	type = 1,	name = [[中毒强化]],	location = {4,5,6},	effect1 = {200,430,875,1750,3500,5300,8000},	effect2 = {},	description = [[中毒伤害|+{$}]],},
	[2] = {	gemid = 2,	type = 1,	name = [[缓速强化]],	location = {4,5,6},	effect1 = {0.02,0.04,0.07,0.14,0.27,0.4,0.6},	effect2 = {},	description = [[缓速效果|+{$}%]],},
	[3] = {	gemid = 3,	type = 1,	name = [[致盲强化]],	location = {4,5,6},	effect1 = {0.2,0.4,0.6,0.9,1.8,2.7,4},	effect2 = {},	description = [[致盲时间|+{$}s]],},
	[4] = {	gemid = 4,	type = 1,	name = [[冻结强化]],	location = {4,5,6},	effect1 = {0.13,0.27,0.55,1.1,2.2,3.3,5},	effect2 = {0.008,0.016,0.032,0.065,0.13,0.2,0.3},	description = [[冻结时间|+{$}s,破冰伤害|+{$}%]],},
	[5] = {	gemid = 5,	type = 2,	name = [[中毒抵抗]],	location = {1,2,3},	effect1 = {160,344,700,1400,2800,4240,6400},	effect2 = {},	description = [[中毒伤害|-{$}]],},
	[6] = {	gemid = 6,	type = 2,	name = [[缓速抵抗]],	location = {1,2,3},	effect1 = {0.016,0.032,0.056,0.112,0.216,0.32,0.48},	effect2 = {},	description = [[缓速效果|-{$}%]],},
	[7] = {	gemid = 7,	type = 2,	name = [[致盲抵抗]],	location = {1,2,3},	effect1 = {0.16,0.32,0.24,0.72,1.44,2.16,3.2},	effect2 = {},	description = [[致盲时间|-{$}s]],},
	[8] = {	gemid = 8,	type = 2,	name = [[冻结抵抗]],	location = {1,2,3},	effect1 = {0.1,0.21,0.44,0.88,1.76,2.64,4},	effect2 = {0.0064,0.0128,0.0256,0.052,0.104,0.16,0.24},	description = [[冻结时间|-{$}s,破冰伤害|-{$}%]],},
	[9] = {	gemid = 9,	type = 3,	name = [[怒气回复]],	location = {1,2,3,4,5,6},	effect1 = {0.02,0.04,0.07,0.14,0.27,0.4,0.6},	effect2 = {},	description = [[怒气回复|+{$}%]],},
	[10] = {	gemid = 10,	type = 4,	name = [[技能抗性]],	location = {1,2,3,4,5,6},	effect1 = {0.02,0.04,0.07,0.13,0.25,0.33,0.5},	effect2 = {},	description = [[技能伤害|-{$}%]],},
	[11] = {	gemid = 11,	type = 5,	name = [[聚合之力]],	location = {1,2,3,4,5,6},	effect1 = {800,1625,3250,6500,13000,20000,30000},	effect2 = {800,1625,3250,6500,13000,20000,30000},	description = [[攻击|+{$},生命|+{$}]],},
	[12] = {	gemid = 12,	type = 6,	name = [[冠军之辉]],	location = {1,2,3,4,5,6},	effect1 = {0.06,0.09,0.14,0.21,0.28,0.36,0.41},	effect2 = {},	description = [[免疫异常概率|+{$}%]],},
}

return _table
