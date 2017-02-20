--[[
	ID = ID
mode = 模式
difficulty = 难度
petnum = 精灵编号
petstar = 精灵星级
atk = 初始攻击
hp = 初始生命
growrate = 属性成长比例
awake = 初始觉醒等级
awake_grow = 觉醒等级成长比例
awake_max = 觉醒等级成长上限

--]]
local _table = {
	[1] = {	ID = 1,	mode = 1,	difficulty = 1,	petnum = 1,	petstar = 4,	atk = 1312,	hp = 1575,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.3000,	awake_max = 12,},
	[2] = {	ID = 2,	mode = 1,	difficulty = 1,	petnum = 2,	petstar = 4,	atk = 1312,	hp = 1575,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.3000,	awake_max = 12,},
	[3] = {	ID = 3,	mode = 1,	difficulty = 1,	petnum = 3,	petstar = 4,	atk = 1312,	hp = 1575,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.3000,	awake_max = 12,},
	[4] = {	ID = 4,	mode = 1,	difficulty = 1,	petnum = 4,	petstar = 4,	atk = 1312,	hp = 1575,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.3000,	awake_max = 12,},
	[5] = {	ID = 5,	mode = 1,	difficulty = 1,	petnum = 5,	petstar = 4,	atk = 1312,	hp = 1575,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.3000,	awake_max = 12,},
	[6] = {	ID = 6,	mode = 1,	difficulty = 2,	petnum = 1,	petstar = 4,	atk = 1575,	hp = 1890,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.3000,	awake_max = 12,},
	[7] = {	ID = 7,	mode = 1,	difficulty = 2,	petnum = 2,	petstar = 4,	atk = 1575,	hp = 1890,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.3000,	awake_max = 12,},
	[8] = {	ID = 8,	mode = 1,	difficulty = 2,	petnum = 3,	petstar = 4,	atk = 1575,	hp = 1890,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.3000,	awake_max = 12,},
	[9] = {	ID = 9,	mode = 1,	difficulty = 2,	petnum = 4,	petstar = 4,	atk = 1575,	hp = 1890,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.3000,	awake_max = 12,},
	[10] = {	ID = 10,	mode = 1,	difficulty = 2,	petnum = 5,	petstar = 4,	atk = 1575,	hp = 1890,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.3000,	awake_max = 12,},
	[11] = {	ID = 11,	mode = 1,	difficulty = 3,	petnum = 1,	petstar = 4,	atk = 1875,	hp = 2250,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.3000,	awake_max = 12,},
	[12] = {	ID = 12,	mode = 1,	difficulty = 3,	petnum = 2,	petstar = 4,	atk = 1875,	hp = 2250,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.3000,	awake_max = 12,},
	[13] = {	ID = 13,	mode = 1,	difficulty = 3,	petnum = 3,	petstar = 4,	atk = 1875,	hp = 2250,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.3000,	awake_max = 12,},
	[14] = {	ID = 14,	mode = 1,	difficulty = 3,	petnum = 4,	petstar = 4,	atk = 1875,	hp = 2250,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.3000,	awake_max = 12,},
	[15] = {	ID = 15,	mode = 1,	difficulty = 3,	petnum = 5,	petstar = 4,	atk = 1875,	hp = 2250,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.3000,	awake_max = 12,},
	[16] = {	ID = 16,	mode = 2,	difficulty = 1,	petnum = 1,	petstar = 5,	atk = 5250,	hp = 6300,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.5000,	awake_max = 16,},
	[17] = {	ID = 17,	mode = 2,	difficulty = 1,	petnum = 2,	petstar = 5,	atk = 5250,	hp = 6300,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.5000,	awake_max = 16,},
	[18] = {	ID = 18,	mode = 2,	difficulty = 1,	petnum = 3,	petstar = 5,	atk = 5250,	hp = 6300,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.5000,	awake_max = 16,},
	[19] = {	ID = 19,	mode = 2,	difficulty = 1,	petnum = 4,	petstar = 5,	atk = 5250,	hp = 6300,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.5000,	awake_max = 16,},
	[20] = {	ID = 20,	mode = 2,	difficulty = 1,	petnum = 5,	petstar = 5,	atk = 5250,	hp = 6300,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.5000,	awake_max = 16,},
	[21] = {	ID = 21,	mode = 2,	difficulty = 2,	petnum = 1,	petstar = 5,	atk = 6300,	hp = 7560,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.5000,	awake_max = 16,},
	[22] = {	ID = 22,	mode = 2,	difficulty = 2,	petnum = 2,	petstar = 5,	atk = 6300,	hp = 7560,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.5000,	awake_max = 16,},
	[23] = {	ID = 23,	mode = 2,	difficulty = 2,	petnum = 3,	petstar = 5,	atk = 6300,	hp = 7560,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.5000,	awake_max = 16,},
	[24] = {	ID = 24,	mode = 2,	difficulty = 2,	petnum = 4,	petstar = 5,	atk = 6300,	hp = 7560,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.5000,	awake_max = 16,},
	[25] = {	ID = 25,	mode = 2,	difficulty = 2,	petnum = 5,	petstar = 5,	atk = 6300,	hp = 7560,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.5000,	awake_max = 16,},
	[26] = {	ID = 26,	mode = 2,	difficulty = 3,	petnum = 1,	petstar = 5,	atk = 7500,	hp = 9000,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.5000,	awake_max = 16,},
	[27] = {	ID = 27,	mode = 2,	difficulty = 3,	petnum = 2,	petstar = 5,	atk = 7500,	hp = 9000,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.5000,	awake_max = 16,},
	[28] = {	ID = 28,	mode = 2,	difficulty = 3,	petnum = 3,	petstar = 5,	atk = 7500,	hp = 9000,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.5000,	awake_max = 16,},
	[29] = {	ID = 29,	mode = 2,	difficulty = 3,	petnum = 4,	petstar = 5,	atk = 7500,	hp = 9000,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.5000,	awake_max = 16,},
	[30] = {	ID = 30,	mode = 2,	difficulty = 3,	petnum = 5,	petstar = 5,	atk = 7500,	hp = 9000,	growrate = [[0.1,0.17]],	awake = 1,	awake_grow = 0.5000,	awake_max = 16,},
	[31] = {	ID = 31,	mode = 3,	difficulty = 1,	petnum = 1,	petstar = 5,	atk = 10500,	hp = 12600,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.6000,	awake_max = 19,},
	[32] = {	ID = 32,	mode = 3,	difficulty = 1,	petnum = 2,	petstar = 5,	atk = 10500,	hp = 12600,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.6000,	awake_max = 19,},
	[33] = {	ID = 33,	mode = 3,	difficulty = 1,	petnum = 3,	petstar = 5,	atk = 10500,	hp = 12600,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.6000,	awake_max = 19,},
	[34] = {	ID = 34,	mode = 3,	difficulty = 1,	petnum = 4,	petstar = 5,	atk = 10500,	hp = 12600,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.6000,	awake_max = 19,},
	[35] = {	ID = 35,	mode = 3,	difficulty = 1,	petnum = 5,	petstar = 5,	atk = 10500,	hp = 12600,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.6000,	awake_max = 19,},
	[36] = {	ID = 36,	mode = 3,	difficulty = 2,	petnum = 1,	petstar = 5,	atk = 12600,	hp = 15120,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.6000,	awake_max = 19,},
	[37] = {	ID = 37,	mode = 3,	difficulty = 2,	petnum = 2,	petstar = 5,	atk = 12600,	hp = 15120,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.6000,	awake_max = 19,},
	[38] = {	ID = 38,	mode = 3,	difficulty = 2,	petnum = 3,	petstar = 5,	atk = 12600,	hp = 15120,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.6000,	awake_max = 19,},
	[39] = {	ID = 39,	mode = 3,	difficulty = 2,	petnum = 4,	petstar = 5,	atk = 12600,	hp = 15120,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.6000,	awake_max = 19,},
	[40] = {	ID = 40,	mode = 3,	difficulty = 2,	petnum = 5,	petstar = 5,	atk = 12600,	hp = 15120,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.6000,	awake_max = 19,},
	[41] = {	ID = 41,	mode = 3,	difficulty = 3,	petnum = 1,	petstar = 5,	atk = 15000,	hp = 18000,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.6000,	awake_max = 19,},
	[42] = {	ID = 42,	mode = 3,	difficulty = 3,	petnum = 2,	petstar = 5,	atk = 15000,	hp = 18000,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.6000,	awake_max = 19,},
	[43] = {	ID = 43,	mode = 3,	difficulty = 3,	petnum = 3,	petstar = 5,	atk = 15000,	hp = 18000,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.6000,	awake_max = 19,},
	[44] = {	ID = 44,	mode = 3,	difficulty = 3,	petnum = 4,	petstar = 5,	atk = 15000,	hp = 18000,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.6000,	awake_max = 19,},
	[45] = {	ID = 45,	mode = 3,	difficulty = 3,	petnum = 5,	petstar = 5,	atk = 15000,	hp = 18000,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.6000,	awake_max = 19,},
	[46] = {	ID = 46,	mode = 4,	difficulty = 1,	petnum = 1,	petstar = 5,	atk = 17500,	hp = 21000,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.7000,	awake_max = 24,},
	[47] = {	ID = 47,	mode = 4,	difficulty = 1,	petnum = 2,	petstar = 5,	atk = 17500,	hp = 21000,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.7000,	awake_max = 24,},
	[48] = {	ID = 48,	mode = 4,	difficulty = 1,	petnum = 3,	petstar = 5,	atk = 17500,	hp = 21000,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.7000,	awake_max = 24,},
	[49] = {	ID = 49,	mode = 4,	difficulty = 1,	petnum = 4,	petstar = 5,	atk = 17500,	hp = 21000,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.7000,	awake_max = 24,},
	[50] = {	ID = 50,	mode = 4,	difficulty = 1,	petnum = 5,	petstar = 5,	atk = 17500,	hp = 21000,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.7000,	awake_max = 24,},
	[51] = {	ID = 51,	mode = 4,	difficulty = 2,	petnum = 1,	petstar = 5,	atk = 21000,	hp = 25200,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.7000,	awake_max = 24,},
	[52] = {	ID = 52,	mode = 4,	difficulty = 2,	petnum = 2,	petstar = 5,	atk = 21000,	hp = 25200,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.7000,	awake_max = 24,},
	[53] = {	ID = 53,	mode = 4,	difficulty = 2,	petnum = 3,	petstar = 5,	atk = 21000,	hp = 25200,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.7000,	awake_max = 24,},
	[54] = {	ID = 54,	mode = 4,	difficulty = 2,	petnum = 4,	petstar = 5,	atk = 21000,	hp = 25200,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.7000,	awake_max = 24,},
	[55] = {	ID = 55,	mode = 4,	difficulty = 2,	petnum = 5,	petstar = 5,	atk = 21000,	hp = 25200,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.7000,	awake_max = 24,},
	[56] = {	ID = 56,	mode = 4,	difficulty = 3,	petnum = 1,	petstar = 5,	atk = 25000,	hp = 30000,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.7000,	awake_max = 24,},
	[57] = {	ID = 57,	mode = 4,	difficulty = 3,	petnum = 2,	petstar = 5,	atk = 25000,	hp = 30000,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.7000,	awake_max = 24,},
	[58] = {	ID = 58,	mode = 4,	difficulty = 3,	petnum = 3,	petstar = 5,	atk = 25000,	hp = 30000,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.7000,	awake_max = 24,},
	[59] = {	ID = 59,	mode = 4,	difficulty = 3,	petnum = 4,	petstar = 5,	atk = 25000,	hp = 30000,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.7000,	awake_max = 24,},
	[60] = {	ID = 60,	mode = 4,	difficulty = 3,	petnum = 5,	petstar = 5,	atk = 25000,	hp = 30000,	growrate = [[0.1,0.122]],	awake = 1,	awake_grow = 0.7000,	awake_max = 24,},
}

return _table
