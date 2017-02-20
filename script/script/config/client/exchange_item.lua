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
	[1] = {	type = 6,	itemid = 0,	quality = 4,	rate = 0.2000,	amount = 1,	consume = 80,	args = {},	refresh = 0,},
	[2] = {	type = 10,	itemid = 0,	quality = 5,	rate = 0.0200,	amount = 10,	consume = 200,	args = {15},	refresh = 10,},
	[3] = {	type = 10,	itemid = 0,	quality = 5,	rate = 0.0300,	amount = 5,	consume = 100,	args = {15},	refresh = 8,},
	[4] = {	type = 10,	itemid = 0,	quality = 5,	rate = 0.0900,	amount = 1,	consume = 20,	args = {15},	refresh = 4,},
	[5] = {	type = 10,	itemid = 0,	quality = 5,	rate = 0.0300,	amount = 10,	consume = 120,	args = {14},	refresh = 6,},
	[6] = {	type = 10,	itemid = 0,	quality = 5,	rate = 0.0400,	amount = 5,	consume = 60,	args = {14},	refresh = 4,},
	[7] = {	type = 10,	itemid = 0,	quality = 5,	rate = 0.1200,	amount = 1,	consume = 12,	args = {14},	refresh = 2,},
	[8] = {	type = 7,	itemid = 0,	quality = 4,	rate = 0.0300,	amount = 1,	consume = 2400,	args = {1},	refresh = 6,},
	[9] = {	type = 7,	itemid = 0,	quality = 4,	rate = 0.0500,	amount = 1,	consume = 1900,	args = {2},	refresh = 4,},
	[10] = {	type = 7,	itemid = 0,	quality = 3,	rate = 0.0800,	amount = 1,	consume = 430,	args = {1},	refresh = 0,},
	[11] = {	type = 7,	itemid = 0,	quality = 3,	rate = 0.1000,	amount = 1,	consume = 410,	args = {2},	refresh = 0,},
	[12] = {	type = 9,	itemid = 42,	quality = 0,	rate = 0.1000,	amount = 10,	consume = 10,	args = {},	refresh = 5,},
	[13] = {	type = 9,	itemid = 42,	quality = 0,	rate = 0.0400,	amount = 50,	consume = 50,	args = {},	refresh = 10,},
	[14] = {	type = 9,	itemid = 42,	quality = 0,	rate = 0.0100,	amount = 100,	consume = 100,	args = {},	refresh = 10,},
	[15] = {	type = 9,	itemid = 69,	quality = 0,	rate = 0.0600,	amount = 5,	consume = 50,	args = {},	refresh = 3,},
}

return _table
