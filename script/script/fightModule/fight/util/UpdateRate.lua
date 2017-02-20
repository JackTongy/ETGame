--  必须保证 rate 和 FightTimer里面的rate 一致
local FightTimer = require "FightTimer"


local  UpdateRate = {}

local ConstRate = 1/FightTimer.getFrameInterval()

UpdateRate.rate = ConstRate

UpdateRate.IntervalRate=1000/UpdateRate.rate

UpdateRate.speedScale = 1

-- local FrameInterval = FightTimer.getFrameInterval()
-- local 

function UpdateRate.setUpdateRateScale( scale )
	-- body
	-- UpdateRate.rate = 60 * scale
end

function UpdateRate.getOriginRate()
--	return 60
	return ConstRate
end

-- function UpdateRate.getSpeedScale()
-- 	-- body
-- 	return UpdateRate.speedScale 
-- end

-- function UpdateRate.setSpeedScale( speedScale )
-- 	-- body
-- 	UpdateRate.speedScale = speedScale
-- end

return UpdateRate