local ActionFactory = require 'ActionFactory'

local ActionCameraFactory = {}

local function getCameraTable( dx, dy )
	-- body
	local _table = {
		{ frame = 1, 	position ={0,0}, 						scale={1,1} },
		{ frame = 14, 	position ={dx*6/7, dy*6/7}, 			scale={1.6,1.6} },
		{ frame = 30, 	position ={dx, dy}, 					scale={1.7,1.7} },
		{ frame = 34, 	position ={dx*0.27/0.7,dy*0.27/0.7}, 	scale={1.27,1.27} },
		{ frame = 40, 	position ={0,0}, 						scale={1,1} },
	}

	return _table
end

ActionCameraFactory.createAction = function ( dx, dy , rate)
	-- body
	assert(rate)
	local _table = getCameraTable( dx, dy)
	return ActionFactory.createAction(_table, nil , 20 * (rate or 1) )
end

return ActionCameraFactory
