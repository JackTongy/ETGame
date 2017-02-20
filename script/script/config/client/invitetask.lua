--[[
	taskid = 任务id
type = 类型（1邀请数量，2等级，3充值数）
amount = 任务所需完成进度
rewards = 奖励（对应reward配置表内容）
name = 名称
condition = 条件说明
describe = 描述说明

--]]
local _table = {
	[1] = {	taskid = 1,	type = 2,	amount = 20,	rewards = {30001},	name = [[邀请礼包1]],	condition = [[被邀请的好友等级升到20级]],	describe = [[该奖励最多可领取5次]],},
	[2] = {	taskid = 2,	type = 2,	amount = 30,	rewards = {30002},	name = [[邀请礼包2]],	condition = [[被邀请的好友等级升到30级]],	describe = [[该奖励最多可领取5次]],},
	[3] = {	taskid = 3,	type = 2,	amount = 40,	rewards = {30003},	name = [[邀请礼包3]],	condition = [[被邀请的好友等级升到40级]],	describe = [[该奖励最多可领取5次]],},
	[4] = {	taskid = 4,	type = 2,	amount = 50,	rewards = {30004},	name = [[邀请礼包4]],	condition = [[被邀请的好友等级升到50级]],	describe = [[该奖励最多可领取5次]],},
}

return _table
