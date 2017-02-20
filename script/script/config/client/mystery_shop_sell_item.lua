--[[
	type = 物品类型
itemid = 具体物品ID
quality = 品质
rate = 概率
amount = 数量
moneytype = 消耗类型(1:钻石，2：银色硬币)
money = 消耗
totaltimes = 总个数
args = 其他参数

--]]
local _table = {
	[1] = {	type = 9,	itemid = 1,	quality = 0,	rate = 0.0300,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 500,},
	[2] = {	type = 9,	itemid = 15,	quality = 0,	rate = 0.0300,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 1000,},
	[3] = {	type = 9,	itemid = 22,	quality = 0,	rate = 0.0300,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 100,},
	[4] = {	type = 9,	itemid = 23,	quality = 0,	rate = 0.0200,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 100,},
	[5] = {	type = 9,	itemid = 42,	quality = 0,	rate = 0.0200,	amount = 1,	moneytype = 2,	money = 2,	totaltimes = 1500,},
	[6] = {	type = 9,	itemid = 201,	quality = 0,	rate = 0.0300,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[7] = {	type = 9,	itemid = 202,	quality = 0,	rate = 0.0300,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[8] = {	type = 9,	itemid = 203,	quality = 0,	rate = 0.0300,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[9] = {	type = 9,	itemid = 204,	quality = 0,	rate = 0.0300,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[10] = {	type = 9,	itemid = 205,	quality = 0,	rate = 0.0300,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[11] = {	type = 9,	itemid = 206,	quality = 0,	rate = 0.0100,	amount = 1,	moneytype = 2,	money = 2,	totaltimes = 150,},
	[12] = {	type = 9,	itemid = 207,	quality = 0,	rate = 0.0100,	amount = 1,	moneytype = 2,	money = 2,	totaltimes = 150,},
	[13] = {	type = 9,	itemid = 208,	quality = 0,	rate = 0.0100,	amount = 1,	moneytype = 2,	money = 3,	totaltimes = 100,},
	[14] = {	type = 9,	itemid = 301,	quality = 0,	rate = 0.0200,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[15] = {	type = 9,	itemid = 302,	quality = 0,	rate = 0.0200,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[16] = {	type = 9,	itemid = 303,	quality = 0,	rate = 0.0300,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[17] = {	type = 9,	itemid = 304,	quality = 0,	rate = 0.0200,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[18] = {	type = 9,	itemid = 305,	quality = 0,	rate = 0.0100,	amount = 1,	moneytype = 2,	money = 2,	totaltimes = 150,},
	[19] = {	type = 9,	itemid = 306,	quality = 0,	rate = 0.0100,	amount = 1,	moneytype = 2,	money = 3,	totaltimes = 100,},
	[20] = {	type = 9,	itemid = 401,	quality = 0,	rate = 0.0300,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[21] = {	type = 9,	itemid = 402,	quality = 0,	rate = 0.0300,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[22] = {	type = 9,	itemid = 403,	quality = 0,	rate = 0.0300,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[23] = {	type = 9,	itemid = 404,	quality = 0,	rate = 0.0200,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[24] = {	type = 9,	itemid = 405,	quality = 0,	rate = 0.0100,	amount = 1,	moneytype = 2,	money = 2,	totaltimes = 150,},
	[25] = {	type = 9,	itemid = 406,	quality = 0,	rate = 0.0100,	amount = 1,	moneytype = 2,	money = 3,	totaltimes = 100,},
	[26] = {	type = 9,	itemid = 501,	quality = 0,	rate = 0.0200,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[27] = {	type = 9,	itemid = 502,	quality = 0,	rate = 0.0200,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[28] = {	type = 9,	itemid = 503,	quality = 0,	rate = 0.0200,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[29] = {	type = 9,	itemid = 504,	quality = 0,	rate = 0.0200,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[30] = {	type = 9,	itemid = 505,	quality = 0,	rate = 0.0100,	amount = 1,	moneytype = 2,	money = 2,	totaltimes = 150,},
	[31] = {	type = 9,	itemid = 506,	quality = 0,	rate = 0.0100,	amount = 1,	moneytype = 2,	money = 3,	totaltimes = 100,},
	[32] = {	type = 9,	itemid = 601,	quality = 0,	rate = 0.0300,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[33] = {	type = 9,	itemid = 602,	quality = 0,	rate = 0.0300,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[34] = {	type = 9,	itemid = 603,	quality = 0,	rate = 0.0300,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[35] = {	type = 9,	itemid = 604,	quality = 0,	rate = 0.0200,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 200,},
	[36] = {	type = 9,	itemid = 605,	quality = 0,	rate = 0.0100,	amount = 1,	moneytype = 2,	money = 2,	totaltimes = 150,},
	[37] = {	type = 9,	itemid = 606,	quality = 0,	rate = 0.0100,	amount = 1,	moneytype = 2,	money = 3,	totaltimes = 100,},
	[38] = {	type = 9,	itemid = 701,	quality = 0,	rate = 0.0200,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 100,},
	[39] = {	type = 9,	itemid = 702,	quality = 0,	rate = 0.0200,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 100,},
	[40] = {	type = 9,	itemid = 703,	quality = 0,	rate = 0.0200,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 100,},
	[41] = {	type = 9,	itemid = 704,	quality = 0,	rate = 0.0200,	amount = 1,	moneytype = 2,	money = 1,	totaltimes = 100,},
	[42] = {	type = 9,	itemid = 705,	quality = 0,	rate = 0.0100,	amount = 1,	moneytype = 2,	money = 2,	totaltimes = 150,},
	[43] = {	type = 9,	itemid = 706,	quality = 0,	rate = 0.0100,	amount = 1,	moneytype = 2,	money = 3,	totaltimes = 100,},
	[44] = {	type = 9,	itemid = 43,	quality = 0,	rate = 0.0200,	amount = 1,	moneytype = 2,	money = 2,	totaltimes = 100,},
	[45] = {	type = 9,	itemid = 44,	quality = 0,	rate = 0.0200,	amount = 1,	moneytype = 2,	money = 2,	totaltimes = 100,},
	[46] = {	type = 9,	itemid = 45,	quality = 0,	rate = 0.0200,	amount = 1,	moneytype = 2,	money = 2,	totaltimes = 100,},
	[47] = {	type = 9,	itemid = 46,	quality = 0,	rate = 0.0300,	amount = 1,	moneytype = 2,	money = 2,	totaltimes = 100,},
	[48] = {	type = 9,	itemid = 47,	quality = 0,	rate = 0.0300,	amount = 1,	moneytype = 2,	money = 2,	totaltimes = 100,},
}

return _table
