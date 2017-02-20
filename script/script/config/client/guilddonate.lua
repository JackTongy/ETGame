--[[
	id = 编号
type = 类别(1:金币 2：钻石)
amount = 数量
mpoint = 个人贡献
gpoint = 公会基金

--]]
local _table = {
	[1] = {	id = 1,	type = 1,	amount = 10000,	mpoint = 40,	gpoint = 40,},
	[2] = {	id = 2,	type = 1,	amount = 100000,	mpoint = 60,	gpoint = 60,},
	[3] = {	id = 3,	type = 2,	amount = 20,	mpoint = 110,	gpoint = 110,},
	[4] = {	id = 4,	type = 2,	amount = 50,	mpoint = 220,	gpoint = 220,},
	[5] = {	id = 5,	type = 2,	amount = 300,	mpoint = 800,	gpoint = 800,},
}

return _table
