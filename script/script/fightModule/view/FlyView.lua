local FlyView = class( require 'AbsView' )
local Utils = require "framework.helper.Utils"
local FightEffectView = require 'FightEffectView'

local function createFlyViewById( moduleid )
	-- body
	-- assert(false)
	
	return Utils.calcDeltaTime( function ()
		-- body
		return FightEffectView.create(moduleid)
		-- return FightEffectView.new(moduleid)
		-- return FlyView.new( moduleid )
	end, '生成FlyView时间')
end

return { createFlyViewById = createFlyViewById } 








