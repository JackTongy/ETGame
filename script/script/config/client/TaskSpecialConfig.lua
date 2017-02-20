--[[
	Id = Id
Name = 名称
Score = 难度
Ap = 消耗体力
Interval = 进入间隔
DailyTimes = 每日可挑战次数
PetId = 可捕捉的角色id
TownId = 城镇id
ElementIds = 元素id列表

--]]
local _table = {
	[1] = {	Id = 1,	Name = [[追捕火烈鸟]],	Score = 88,	Ap = 5,	Interval = 240,	DailyTimes = 2,	PetId = 8,	TownId = 1101,	ElementIds = {32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60},},
	[2] = {	Id = 2,	Name = [[龙骑士]],	Score = 99,	Ap = 5,	Interval = 720,	DailyTimes = 2,	PetId = 9,	TownId = 1102,	ElementIds = {32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60},},
}

return _table
