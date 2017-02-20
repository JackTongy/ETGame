--[[
	Id = 任务编号
StoryId = 剧情编号
TownId = 所在城镇
Ap = 体力需求
CapturePetIds = 可捕捉精灵id列表
CaptureRewardId = 全部捕捉奖励id
Rewards = 掉落信息
SeniorCondition = 精英BOSS条件

--]]
local _table = {
	[1] = {	Id = 1,	StoryId = 1,	TownId = 1,	Ap = 5,	CapturePetIds = {69,20},	CaptureRewardId = 10001,	Rewards = {{1001, 0.5},{2002,0.3}},	SeniorCondition = {1,3,2,4},},
	[2] = {	Id = 2,	StoryId = 2,	TownId = 2,	Ap = 5,	CapturePetIds = {7,8},	CaptureRewardId = 10002,	Rewards = {{1001, 0.5},{2002,0.3}},	SeniorCondition = {4},},
	[3] = {	Id = 3,	StoryId = 3,	TownId = 3,	Ap = 5,	CapturePetIds = {9,10},	CaptureRewardId = 10003,	Rewards = {{1001, 0.5},{2002,0.3}},	SeniorCondition = {1,3,4},},
	[4] = {	Id = 4,	StoryId = 4,	TownId = 4,	Ap = 5,	CapturePetIds = {11,12},	CaptureRewardId = 10004,	Rewards = {{1001, 0.5},{2002,0.3}},	SeniorCondition = {2,4},},
}

return _table
