--[[
	Type = 训练模式
name = 模式名称
Exp = 经验
RefreshRate = 刷新成功概率
Cost = 刷新所需精灵石
nil = nil

--]]
local _table = {
	[1] = {	Type = 1,	name = [[新手训练]],	Exp = 1000,	RefreshRate = 1,	Cost = 2,},
	[2] = {	Type = 2,	name = [[基础训练]],	Exp = 2000,	RefreshRate = 0.6000,	Cost = 5,},
	[3] = {	Type = 3,	name = [[进阶训练]],	Exp = 4000,	RefreshRate = 0.3000,	Cost = 10,},
	[4] = {	Type = 4,	name = [[秘密特训]],	Exp = 8000,	RefreshRate = 0.2000,	Cost = 15,},
	[5] = {	Type = 5,	name = [[地狱特训]],	Exp = 12000,	RefreshRate = 0,	Cost = 0,},
}

return _table
