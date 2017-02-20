local FightGuiderConfig = require 'FightGuiderConfig'

local ManaManager 	= {}
local ManaStep 		= 400
--[[
X 普通攻击, 自动治疗
Y 被攻击(普通攻击,技能攻击)
Z 每经过5秒, 获得怒气
--]]
local ManaTable = {
	[1] = { X = 80, Y = 20, Z = 5 },
	[2] = { X = 15, Y = 50, Z = 5 },
	[3] = { X = 20, Y = 0, 	Z = 25 },
	[4] = { X = 60, Y = 0, 	Z = 0 },
}

ManaTable[1].X = FightGuiderConfig[1].zs_mana[1]
ManaTable[1].Y = FightGuiderConfig[1].zs_mana[2]
ManaTable[1].Z = FightGuiderConfig[1].zs_mana[3]

ManaTable[2].X = FightGuiderConfig[1].qs_mana[1]
ManaTable[2].Y = FightGuiderConfig[1].qs_mana[2]
ManaTable[2].Z = FightGuiderConfig[1].qs_mana[3]

ManaTable[3].X = FightGuiderConfig[1].yc_mana[1]
ManaTable[3].Y = FightGuiderConfig[1].yc_mana[2]
ManaTable[3].Z = FightGuiderConfig[1].yc_mana[3]

ManaTable[4].X = FightGuiderConfig[1].zl_mana[1]
ManaTable[4].Y = FightGuiderConfig[1].zl_mana[2]
ManaTable[4].Z = FightGuiderConfig[1].zl_mana[3]

ManaManager.ManaTable 	= ManaTable
ManaManager.ManaStep 	= ManaStep

local ManaRateTable = {
	-- []
	[30] = 0,
	[31] = 0.2,
	[32] = 0.55,
	[33] = 1,

	[20] = 0,
	[21] = 0.4,
	[22] = 1,

	[10] = 0,
	[11] = 1,
}

function ManaManager.getManaRate( point, maxPoint )
	-- body
	local index = maxPoint*10 + point
	local rate = ManaRateTable[index]
	assert(rate, ''..point..'-'..maxPoint)
	return rate
end

return ManaManager