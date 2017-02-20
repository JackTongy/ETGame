--[[
	Id = Id
Type = 奖励类型
Lv = 等级要求
Cnt = 数量要求
RewardId = 奖励ID
Desc = 描述
Name = 奖励名称

--]]
local _table = {
	[1] = {	Id = 1,	Type = 1,	Lv = 40,	Cnt = 1,	RewardId = 19001,	Desc = [[邀请的新玩家最高等级达到40级]],	Name = [[邀请礼包1]],},
	[2] = {	Id = 2,	Type = 1,	Lv = 50,	Cnt = 1,	RewardId = 19002,	Desc = [[邀请的新玩家最高等级达到50级]],	Name = [[邀请礼包2]],},
	[3] = {	Id = 3,	Type = 1,	Lv = 60,	Cnt = 1,	RewardId = 19003,	Desc = [[邀请的新玩家最高等级达到60级]],	Name = [[邀请礼包3]],},
	[4] = {	Id = 4,	Type = 2,	Lv = 30,	Cnt = 5,	RewardId = 19004,	Desc = [[邀请5个新玩家等级达到30级]],	Name = [[邀请礼包4]],},
	[5] = {	Id = 5,	Type = 2,	Lv = 40,	Cnt = 10,	RewardId = 19005,	Desc = [[邀请10个新玩家等级达到40级]],	Name = [[邀请礼包5]],},
	[6] = {	Id = 6,	Type = 2,	Lv = 60,	Cnt = 10,	RewardId = 19006,	Desc = [[邀请10个新玩家等级达到60级]],	Name = [[邀请礼包6]],},
	[7] = {	Id = 7,	Type = 3,	Lv = 50,	Cnt = 1,	RewardId = 19007,	Desc = [[邀请1个50级以上老玩家回归]],	Name = [[回归礼包1]],},
	[8] = {	Id = 8,	Type = 3,	Lv = 50,	Cnt = 5,	RewardId = 19008,	Desc = [[邀请5个50级以上老玩家回归]],	Name = [[回归礼包2]],},
	[9] = {	Id = 9,	Type = 3,	Lv = 50,	Cnt = 10,	RewardId = 19009,	Desc = [[邀请10个50级以上老玩家回归]],	Name = [[回归礼包3]],},
}

return _table
