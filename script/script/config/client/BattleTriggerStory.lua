--[[
	BattleId = 战斗id
BattleStory = 剧情名称
BossId = 助战id
captain = 是否触发队长免伤（1触发 0不触发）
onlycaptain = 是否只出现队长（1是 0否）

--]]
local _table = {
	[1] = {	BattleId = 10002,	BattleStory = 1,	BossId = {1},	captain = 1,	onlycaptain = 1,},
	[2] = {	BattleId = 502,	BattleStory = 2,	BossId = {3},	captain = 1,	onlycaptain = 1,},
	[3] = {	BattleId = 503,	BattleStory = 3,	BossId = {5},	captain = 1,	onlycaptain = 1,},
}

return _table
