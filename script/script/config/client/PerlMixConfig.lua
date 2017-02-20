--[[
	Id = ID
ScoreFloor = 积分下限
ScoreUp = 积分上限
PerlRate = 获得职业珠概率
GreenRate = 绿技能书概率
BlueRate = 蓝技能书概率
PurpleRate = 紫技能书概率
OrangeRate = 橙技能书概率

--]]
local _table = {
	[1] = {	Id = 1,	ScoreFloor = 4,	ScoreUp = 5,	PerlRate = 0.2500,	GreenRate = 0.9500,	BlueRate = 1,	PurpleRate = 1,	OrangeRate = 1,},
	[2] = {	Id = 2,	ScoreFloor = 5,	ScoreUp = 13,	PerlRate = 0.1000,	GreenRate = 0.8000,	BlueRate = 1,	PurpleRate = 1,	OrangeRate = 1,},
	[3] = {	Id = 3,	ScoreFloor = 13,	ScoreUp = 21,	PerlRate = 0.2500,	GreenRate = 0.7500,	BlueRate = 0.9800,	PurpleRate = 1,	OrangeRate = 1,},
	[4] = {	Id = 4,	ScoreFloor = 21,	ScoreUp = 61,	PerlRate = 0.1000,	GreenRate = 0.5000,	BlueRate = 0.9000,	PurpleRate = 1,	OrangeRate = 1,},
	[5] = {	Id = 5,	ScoreFloor = 61,	ScoreUp = 101,	PerlRate = 0.2500,	GreenRate = 0.5000,	BlueRate = 0.8500,	PurpleRate = 1,	OrangeRate = 1,},
	[6] = {	Id = 6,	ScoreFloor = 101,	ScoreUp = 301,	PerlRate = 0,	GreenRate = 0,	BlueRate = 0.5500,	PurpleRate = 0.9800,	OrangeRate = 1,},
	[7] = {	Id = 7,	ScoreFloor = 301,	ScoreUp = 501,	PerlRate = 0,	GreenRate = 0,	BlueRate = 0.5000,	PurpleRate = 0.9000,	OrangeRate = 1,},
}

return _table
