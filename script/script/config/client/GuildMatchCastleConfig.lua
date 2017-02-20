--[[
	Id = 据点ID
Nexts = 相邻据点ID
Home = 大本营
prop = 据点属性
Tips = 据点描述
AddValue = 加成比例

--]]
local _table = {
	[1] = {	Id = 1,	Nexts = {13,16,35,36,27,26},},
	[2] = {	Id = 10,	Nexts = {11,15},	Home = 1,},
	[3] = {	Id = 11,	Nexts = {10,12,14},	prop = 6,	Tips = {'水属性精灵攻击+20%','水属性精灵生命+20%'},	AddValue = 20,},
	[4] = {	Id = 12,	Nexts = {11,13,25},	prop = 6,	Tips = {'水属性精灵攻击+20%','水属性精灵生命+20%'},	AddValue = 20,},
	[5] = {	Id = 13,	Nexts = {12,14,1,26},	prop = 2,	Tips = {'草属性精灵攻击+20%','草属性精灵生命+20%'},	AddValue = 20,},
	[6] = {	Id = 14,	Nexts = {11,15,13,16},	prop = 2,	Tips = {'草属性精灵攻击+20%','草属性精灵生命+20%'},	AddValue = 20,},
	[7] = {	Id = 15,	Nexts = {10,14,17},	prop = 7,	Tips = {'岩属性精灵攻击+20%','岩属性精灵生命+20%'},	AddValue = 20,},
	[8] = {	Id = 16,	Nexts = {14,17,35,1},	prop = 3,	Tips = {'电属性精灵攻击+20%','电属性精灵生命+20%'},	AddValue = 20,},
	[9] = {	Id = 17,	Nexts = {15,16,34},},
	[10] = {	Id = 20,	Nexts = {21,23},	Home = 1,},
	[11] = {	Id = 21,	Nexts = {25,22,20},	prop = 8,	Tips = {'火属性精灵攻击+20%','火属性精灵生命+20%'},	AddValue = 20,},
	[12] = {	Id = 22,	Nexts = {21,26,27,23},	prop = 6,	Tips = {'水属性精灵攻击+20%','水属性精灵生命+20%'},	AddValue = 20,},
	[13] = {	Id = 23,	Nexts = {22,20,24},},
	[14] = {	Id = 24,	Nexts = {23,27,37},	prop = 2,	Tips = {'草属性精灵攻击+20%','草属性精灵生命+20%'},	AddValue = 20,},
	[15] = {	Id = 25,	Nexts = {21,26,12},	prop = 8,	Tips = {'火属性精灵攻击+20%','火属性精灵生命+20%'},	AddValue = 20,},
	[16] = {	Id = 26,	Nexts = {25,22,1,13},	prop = 3,	Tips = {'电属性精灵攻击+20%','电属性精灵生命+20%'},	AddValue = 20,},
	[17] = {	Id = 27,	Nexts = {22,24,36,1},	prop = 6,	Tips = {'水属性精灵攻击+20%','水属性精灵生命+20%'},	AddValue = 20,},
	[18] = {	Id = 30,	Nexts = {31,33},	Home = 1,},
	[19] = {	Id = 31,	Nexts = {32,30,37},	prop = 6,	Tips = {'水属性精灵攻击+20%','水属性精灵生命+20%'},	AddValue = 20,},
	[20] = {	Id = 32,	Nexts = {31,33,35,36},	prop = 7,	Tips = {'岩属性精灵攻击+20%','岩属性精灵生命+20%'},	AddValue = 20,},
	[21] = {	Id = 33,	Nexts = {32,30,34},},
	[22] = {	Id = 34,	Nexts = {35,33,17},	prop = 8,	Tips = {'火属性精灵攻击+20%','火属性精灵生命+20%'},	AddValue = 20,},
	[23] = {	Id = 35,	Nexts = {16,1,32,34},	prop = 7,	Tips = {'岩属性精灵攻击+20%','岩属性精灵生命+20%'},	AddValue = 20,},
	[24] = {	Id = 36,	Nexts = {1,27,37,32},	prop = 3,	Tips = {'电属性精灵攻击+20%','电属性精灵生命+20%'},	AddValue = 20,},
	[25] = {	Id = 37,	Nexts = {24,36,31},	prop = 2,	Tips = {'草属性精灵攻击+20%','草属性精灵生命+20%'},	AddValue = 20,},
}

return _table
