--[[
	type = 科技类型
unlock = 解锁等级
tcname = 科技名称
efname = 效果名称

--]]
local _table = {
	[1] = {	type = 1,	unlock = 1,	tcname = [[强攻]],	efname = [[攻击]],},
	[2] = {	type = 2,	unlock = 1,	tcname = [[祝福]],	efname = [[生命]],},
	[3] = {	type = 3,	unlock = 2,	tcname = [[护佑]],	efname = [[防御]],},
	[4] = {	type = 4,	unlock = 3,	tcname = [[格挡]],	efname = [[免伤]],},
	[5] = {	type = 5,	unlock = 4,	tcname = [[惩戒]],	efname = [[伤害]],},
	[6] = {	type = 6,	unlock = 5,	tcname = [[激怒]],	efname = [[怒气回复]],},
	[7] = {	type = 7,	unlock = 6,	tcname = [[主宰]],	efname = [[技能伤害]],},
}

return _table
