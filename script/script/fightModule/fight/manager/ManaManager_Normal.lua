local ManaManager 	= {}
local ManaStep 		= 400
--[[
X 普通攻击, 自动治疗
Y 被攻击(普通攻击,技能攻击)
Z 每经过5秒, 获得怒气
--]]
-- local RATE = 1
-- local ManaTable = {
-- 	[1] = { X = 30*RATE, Y = 15*RATE, Z = 5*RATE },
-- 	[2] = { X = 50*RATE, Y = 10*RATE, Z = 5*RATE },
-- 	[3] = { X = 20*RATE, Y = 20*RATE, Z = 10*RATE },
-- 	[4] = { X = 30*RATE, Y = 30*RATE, Z = 10*RATE },
-- }

local ManaTable = require 'EnergyConfig'

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