--[[
	Id = ID
Name = 宝箱名称
RewardIds = 奖励
KeysFloor = 开启需要钥匙上下限
KeysCeiling = nil
RewardKey = 奖励系数

--]]
local _table = {
	[1] = {	Id = 1,	Name = [[木质宝箱]],	RewardIds = {63000,63001,63002},	KeysFloor = 4,	KeysCeiling = 6,	RewardKey = 5,},
	[2] = {	Id = 2,	Name = [[黑铁宝箱]],	RewardIds = {63003,63004,63005},	KeysFloor = 12,	KeysCeiling = 15,	RewardKey = 10,},
	[3] = {	Id = 3,	Name = [[水晶宝箱]],	RewardIds = {63006,63007,63008},	KeysFloor = 19,	KeysCeiling = 25,	RewardKey = 10,},
}

return _table
