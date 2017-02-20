local BattleBgConfig 	= require 'BattleBgConfig'
local CfgHelper 		= require 'CfgHelper'

local BattleBgManager = {}
local self = {}

function BattleBgManager.getBgResidByType()
	-- body
	local bgType = require 'ServerRecord'.getBattleBgType()
	if not bgType then
		local index = math.random(1, #BattleBgConfig)
		bgType = BattleBgConfig[index].bgtype
	end

	assert(bgType)
	local item = CfgHelper.getCache('BattleBgConfig', 'bgtype', bgType)
	assert(item, 'no bgtype '..tostring(bgType))

	assert(item.description)
	assert(item.num)

	-- 	[1] = {	bgtype = 1,	description = [[lawn]],	num = 4,},
	local index = math.random(1, item.num)

	self._lastBgResid1 = item.description..'_'..index..'_01.jpg'
	self._lastBgResid2 = item.description..'_'..index..'_02.jpg'

	if require 'ServerRecord'.getMode() == 'guider' then
		self._lastBgResid1 = 'volcanic_1_01.jpg'
		self._lastBgResid2 = 'volcanic_1_02.jpg'
	end

	print('BattleBgManager:'..self._lastBgResid1..','..self._lastBgResid2)

	return self._lastBgResid1, self._lastBgResid2
end

function BattleBgManager.getLastBgResid()
	-- body
	return self._lastBgResid1, self._lastBgResid2
end

return BattleBgManager