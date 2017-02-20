--[[
	low = 排名上限
top = 排名下限
reward = 奖励（对应reward.xslx）

--]]
local _table = {
	[1] = {	low = 1,	top = 1,	reward = {40001,40002},},
	[2] = {	low = 2,	top = 2,	reward = {40011,40012},},
	[3] = {	low = 3,	top = 3,	reward = {40021,40022},},
	[4] = {	low = 4,	top = 10,	reward = {40031,40032},},
	[5] = {	low = 11,	top = 20,	reward = {40041,40042},},
	[6] = {	low = 21,	top = 50,	reward = {40051,40052},},
	[7] = {	low = 51,	top = 100,	reward = {40061},},
}

return _table
