--[[
	Id = Id
BossId = BOSS配置ID
harm = 造成伤害
RewardIds = RewardId列表
evaluate = 评价

--]]
local _table = {
	[1] = {	Id = 1,	BossId = 1,	harm = 0,	RewardIds = {75001,75002},	evaluate = 1,},
	[2] = {	Id = 2,	BossId = 1,	harm = 100000,	RewardIds = {75003,75004},	evaluate = 2,},
	[3] = {	Id = 3,	BossId = 1,	harm = 300000,	RewardIds = {75005,75006},	evaluate = 3,},
	[4] = {	Id = 4,	BossId = 1,	harm = 600000,	RewardIds = {75007,75008},	evaluate = 4,},
	[5] = {	Id = 5,	BossId = 1,	harm = 1000000,	RewardIds = {75009,75010},	evaluate = 5,},
	[6] = {	Id = 6,	BossId = 1,	harm = 5000000,	RewardIds = {75011,75012},	evaluate = 6,},
	[7] = {	Id = 7,	BossId = 1,	harm = 10000000,	RewardIds = {75013,75014},	evaluate = 7,},
	[8] = {	Id = 8,	BossId = 1,	harm = 30000000,	RewardIds = {75015,75016},	evaluate = 8,},
	[9] = {	Id = 9,	BossId = 1,	harm = 80000000,	RewardIds = {75017,75018},	evaluate = 9,},
	[10] = {	Id = 10,	BossId = 1,	harm = 150000000,	RewardIds = {75019,75020},	evaluate = 10,},
	[11] = {	Id = 11,	BossId = 2,	harm = 0,	RewardIds = {75101,75102},	evaluate = 1,},
	[12] = {	Id = 12,	BossId = 2,	harm = 100000,	RewardIds = {75103,75104},	evaluate = 2,},
	[13] = {	Id = 13,	BossId = 2,	harm = 300000,	RewardIds = {75105,75106},	evaluate = 3,},
	[14] = {	Id = 14,	BossId = 2,	harm = 600000,	RewardIds = {75107,75108},	evaluate = 4,},
	[15] = {	Id = 15,	BossId = 2,	harm = 1000000,	RewardIds = {75109,75110},	evaluate = 5,},
	[16] = {	Id = 16,	BossId = 2,	harm = 5000000,	RewardIds = {75111,75112},	evaluate = 6,},
	[17] = {	Id = 17,	BossId = 2,	harm = 10000000,	RewardIds = {75113,75114},	evaluate = 7,},
	[18] = {	Id = 18,	BossId = 2,	harm = 30000000,	RewardIds = {75115,75116},	evaluate = 8,},
	[19] = {	Id = 19,	BossId = 2,	harm = 80000000,	RewardIds = {75117,75118},	evaluate = 9,},
	[20] = {	Id = 20,	BossId = 2,	harm = 150000000,	RewardIds = {75119,75120},	evaluate = 10,},
	[21] = {	Id = 21,	BossId = 3,	harm = 0,	RewardIds = {75201,75202},	evaluate = 1,},
	[22] = {	Id = 22,	BossId = 3,	harm = 100000,	RewardIds = {75203,75204},	evaluate = 2,},
	[23] = {	Id = 23,	BossId = 3,	harm = 300000,	RewardIds = {75205,75206},	evaluate = 3,},
	[24] = {	Id = 24,	BossId = 3,	harm = 600000,	RewardIds = {75207,75208},	evaluate = 4,},
	[25] = {	Id = 25,	BossId = 3,	harm = 1000000,	RewardIds = {75209,75210},	evaluate = 5,},
	[26] = {	Id = 26,	BossId = 3,	harm = 5000000,	RewardIds = {75211,75212},	evaluate = 6,},
	[27] = {	Id = 27,	BossId = 3,	harm = 10000000,	RewardIds = {75213,75214},	evaluate = 7,},
	[28] = {	Id = 28,	BossId = 3,	harm = 30000000,	RewardIds = {75215,75216},	evaluate = 8,},
	[29] = {	Id = 29,	BossId = 3,	harm = 80000000,	RewardIds = {75217,75218},	evaluate = 9,},
	[30] = {	Id = 30,	BossId = 3,	harm = 150000000,	RewardIds = {75219,75220},	evaluate = 10,},
	[31] = {	Id = 31,	BossId = 4,	harm = 0,	RewardIds = {75301,75302},	evaluate = 1,},
	[32] = {	Id = 32,	BossId = 4,	harm = 100000,	RewardIds = {75303,75304},	evaluate = 2,},
	[33] = {	Id = 33,	BossId = 4,	harm = 300000,	RewardIds = {75305,75306},	evaluate = 3,},
	[34] = {	Id = 34,	BossId = 4,	harm = 600000,	RewardIds = {75307,75308},	evaluate = 4,},
	[35] = {	Id = 35,	BossId = 4,	harm = 1000000,	RewardIds = {75309,75310},	evaluate = 5,},
	[36] = {	Id = 36,	BossId = 4,	harm = 5000000,	RewardIds = {75311,75312},	evaluate = 6,},
	[37] = {	Id = 37,	BossId = 4,	harm = 10000000,	RewardIds = {75313,75314},	evaluate = 7,},
	[38] = {	Id = 38,	BossId = 4,	harm = 30000000,	RewardIds = {75315,75316},	evaluate = 8,},
	[39] = {	Id = 39,	BossId = 4,	harm = 80000000,	RewardIds = {75317,75318},	evaluate = 9,},
	[40] = {	Id = 40,	BossId = 4,	harm = 150000000,	RewardIds = {75319,75320},	evaluate = 10,},
	[41] = {	Id = 41,	BossId = 5,	harm = 0,	RewardIds = {75401,75402},	evaluate = 1,},
	[42] = {	Id = 42,	BossId = 5,	harm = 100000,	RewardIds = {75403,75404},	evaluate = 2,},
	[43] = {	Id = 43,	BossId = 5,	harm = 300000,	RewardIds = {75405,75406},	evaluate = 3,},
	[44] = {	Id = 44,	BossId = 5,	harm = 600000,	RewardIds = {75407,75408},	evaluate = 4,},
	[45] = {	Id = 45,	BossId = 5,	harm = 1000000,	RewardIds = {75409,75410},	evaluate = 5,},
	[46] = {	Id = 46,	BossId = 5,	harm = 5000000,	RewardIds = {75411,75412},	evaluate = 6,},
	[47] = {	Id = 47,	BossId = 5,	harm = 10000000,	RewardIds = {75413,75414},	evaluate = 7,},
	[48] = {	Id = 48,	BossId = 5,	harm = 30000000,	RewardIds = {75415,75416},	evaluate = 8,},
	[49] = {	Id = 49,	BossId = 5,	harm = 80000000,	RewardIds = {75417,75418},	evaluate = 9,},
	[50] = {	Id = 50,	BossId = 5,	harm = 150000000,	RewardIds = {75419,75420},	evaluate = 10,},
}

return _table
