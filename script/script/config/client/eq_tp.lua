--[[
	tp = 阶数
color = 装备颜色要求（下限）
lvup = 提高装备等级上限
gemlv = 装备宝石等级上限
RoleLv = 角色等级要求

--]]
local _table = {
	[1] = {	tp = 0,	color = 1,	lvup = 0,	gemlv = 0,	RoleLv = 30,},
	[2] = {	tp = 1,	color = 1,	lvup = 10,	gemlv = 2,	RoleLv = 35,},
	[3] = {	tp = 2,	color = 1,	lvup = 20,	gemlv = 3,	RoleLv = 40,},
	[4] = {	tp = 3,	color = 1,	lvup = 35,	gemlv = 4,	RoleLv = 45,},
	[5] = {	tp = 4,	color = 1,	lvup = 50,	gemlv = 5,	RoleLv = 55,},
	[6] = {	tp = 5,	color = 1,	lvup = 65,	gemlv = 6,	RoleLv = 65,},
	[7] = {	tp = 6,	color = 1,	lvup = 85,	gemlv = 7,	RoleLv = 75,},
	[8] = {	tp = 7,	color = 1,	lvup = 110,	gemlv = 7,	RoleLv = 85,},
	[9] = {	tp = 8,	color = 1,	lvup = 130,	gemlv = 8,	RoleLv = 95,},
}

return _table
