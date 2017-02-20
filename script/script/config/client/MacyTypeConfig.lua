--[[
	Id = nil
Name = nil
MacyFloor = 亲密度下限
MacyCeiling = 亲密度上限
SpdRate = 移动速度加成比例
Grow = 攻击、生命加成比例
Memo = 描述字段

--]]
local _table = {
	[1] = {	Id = 3,	Name = [[友好]],	MacyFloor = 0,	MacyCeiling = 10,	SpdRate = 0,	Grow = 0,	Memo = [[无]],},
	[2] = {	Id = 4,	Name = [[信任]],	MacyFloor = 10,	MacyCeiling = 100,	SpdRate = 0,	Grow = 0.0500,	Memo = [[攻击+5%,生命+5%]],},
	[3] = {	Id = 5,	Name = [[亲昵]],	MacyFloor = 100,	MacyCeiling = 500,	SpdRate = 0,	Grow = 0.1000,	Memo = [[攻击+10%,生命+10%]],},
	[4] = {	Id = 6,	Name = [[依赖]],	MacyFloor = 500,	MacyCeiling = 1000,	SpdRate = 0,	Grow = 0.1500,	Memo = [[攻击+15%,生命+15%]],},
	[5] = {	Id = 7,	Name = [[崇拜]],	MacyFloor = 1000,	MacyCeiling = 1000,	SpdRate = 0,	Grow = 0.2000,	Memo = [[攻击+20%,生命+20%]],},
}

return _table
