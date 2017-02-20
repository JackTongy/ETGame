--[[
	type = 物品类型
itemid = 具体物品ID
quality = 品质
rate = 概率
amount = 数量
consume = 消耗
args = 其他参数
refresh = 次数

--]]
local _table = {
	[1] = {	type = 10,	itemid = 2005,	quality = 5,	rate = 0.0300,	amount = 1,	consume = 200,	args = {},	refresh = 10,},
	[2] = {	type = 10,	itemid = 2001,	quality = 5,	rate = 0.0300,	amount = 1,	consume = 400,	args = {},	refresh = 10,},
	[3] = {	type = 8,	itemid = 1,	quality = 1,	rate = 0.0720,	amount = 1,	consume = 100,	args = {},	refresh = 0,},
	[4] = {	type = 8,	itemid = 2,	quality = 1,	rate = 0.0720,	amount = 1,	consume = 100,	args = {},	refresh = 0,},
	[5] = {	type = 8,	itemid = 3,	quality = 1,	rate = 0.0720,	amount = 1,	consume = 100,	args = {},	refresh = 0,},
	[6] = {	type = 8,	itemid = 4,	quality = 1,	rate = 0.0720,	amount = 1,	consume = 100,	args = {},	refresh = 0,},
	[7] = {	type = 8,	itemid = 9,	quality = 1,	rate = 0.0570,	amount = 1,	consume = 100,	args = {},	refresh = 20,},
	[8] = {	type = 8,	itemid = 10,	quality = 1,	rate = 0.0630,	amount = 1,	consume = 100,	args = {},	refresh = 0,},
	[9] = {	type = 8,	itemid = 11,	quality = 1,	rate = 0.0570,	amount = 1,	consume = 100,	args = {},	refresh = 20,},
	[10] = {	type = 10,	itemid = 2005,	quality = 5,	rate = 0.0150,	amount = 5,	consume = 1000,	args = {},	refresh = 20,},
	[11] = {	type = 10,	itemid = 2001,	quality = 5,	rate = 0.0150,	amount = 5,	consume = 2000,	args = {},	refresh = 20,},
	[12] = {	type = 10,	itemid = 382,	quality = 6,	rate = 0.0100,	amount = 1,	consume = 1500,	args = {},	refresh = 15,},
	[13] = {	type = 10,	itemid = 492,	quality = 6,	rate = 0.0100,	amount = 1,	consume = 1500,	args = {},	refresh = 15,},
	[14] = {	type = 10,	itemid = 79,	quality = 5,	rate = 0,	amount = 1,	consume = 200,	args = {},	refresh = 0,},
	[15] = {	type = 10,	itemid = 79,	quality = 5,	rate = 0,	amount = 5,	consume = 1000,	args = {},	refresh = 0,},
	[16] = {	type = 15,	itemid = 1003,	quality = 0,	rate = 0.0030,	amount = 1,	consume = 500,	args = {},	refresh = 20,},
	[17] = {	type = 15,	itemid = 1004,	quality = 0,	rate = 0.0030,	amount = 1,	consume = 500,	args = {},	refresh = 20,},
	[18] = {	type = 15,	itemid = 1005,	quality = 0,	rate = 0.0030,	amount = 1,	consume = 500,	args = {},	refresh = 20,},
	[19] = {	type = 15,	itemid = 1006,	quality = 0,	rate = 0.0010,	amount = 1,	consume = 1500,	args = {},	refresh = 0,},
	[20] = {	type = 15,	itemid = 1007,	quality = 0,	rate = 0.0010,	amount = 1,	consume = 1500,	args = {},	refresh = 0,},
	[21] = {	type = 15,	itemid = 1008,	quality = 0,	rate = 0.0010,	amount = 1,	consume = 1500,	args = {},	refresh = 0,},
	[22] = {	type = 15,	itemid = 1009,	quality = 0,	rate = 0.0010,	amount = 1,	consume = 1500,	args = {},	refresh = 0,},
	[23] = {	type = 15,	itemid = 1010,	quality = 0,	rate = 0.0010,	amount = 1,	consume = 1500,	args = {},	refresh = 0,},
	[24] = {	type = 15,	itemid = 2003,	quality = 0,	rate = 0.0040,	amount = 1,	consume = 500,	args = {},	refresh = 20,},
	[25] = {	type = 15,	itemid = 2004,	quality = 0,	rate = 0.0030,	amount = 1,	consume = 500,	args = {},	refresh = 20,},
	[26] = {	type = 15,	itemid = 2005,	quality = 0,	rate = 0.0010,	amount = 1,	consume = 1500,	args = {},	refresh = 0,},
	[27] = {	type = 15,	itemid = 2006,	quality = 0,	rate = 0.0010,	amount = 1,	consume = 1500,	args = {},	refresh = 0,},
	[28] = {	type = 15,	itemid = 2007,	quality = 0,	rate = 0.0010,	amount = 1,	consume = 1500,	args = {},	refresh = 0,},
	[29] = {	type = 15,	itemid = 2008,	quality = 0,	rate = 0.0010,	amount = 1,	consume = 1500,	args = {},	refresh = 0,},
	[30] = {	type = 14,	itemid = 3001,	quality = 0,	rate = 0.1000,	amount = 1,	consume = 30,	args = {},	refresh = 0,},
	[31] = {	type = 14,	itemid = 3002,	quality = 0,	rate = 0.0700,	amount = 1,	consume = 90,	args = {},	refresh = 10,},
	[32] = {	type = 14,	itemid = 3003,	quality = 0,	rate = 0.0300,	amount = 1,	consume = 300,	args = {},	refresh = 10,},
	[33] = {	type = 14,	itemid = 3004,	quality = 0,	rate = 0.1000,	amount = 1,	consume = 30,	args = {},	refresh = 0,},
	[34] = {	type = 14,	itemid = 3005,	quality = 0,	rate = 0.0600,	amount = 1,	consume = 90,	args = {},	refresh = 10,},
	[35] = {	type = 14,	itemid = 3006,	quality = 0,	rate = 0.0300,	amount = 1,	consume = 300,	args = {},	refresh = 10,},
	[36] = {	type = 10,	itemid = 1492,	quality = 6,	rate = 0.0100,	amount = 1,	consume = 1500,	args = {},	refresh = 15,},
}

return _table
