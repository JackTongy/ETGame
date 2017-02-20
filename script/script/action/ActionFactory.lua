local ActionFactory = {}
local Utils = require 'framework.helper.Utils'

ActionFactory._cache = {}

local InstanceTime = 0.001

local ValidPropertyMap = { 
	['position'] = function ( pos, fps )
		-- body
		local a1 = CCMoveTo:create(InstanceTime, ccp(pos[1], pos[2]))
		local a2 = CCDelayTime:create(1/fps - InstanceTime)
		local array = CCArray:create()
		array:addObject(a1)
		array:addObject(a2)
		return CCSequence:create(array)
	end, 

	['scale'] = function ( scale, fps )
		-- body
		local a1 = CCScaleTo:create(InstanceTime, scale[1], scale[2])
		local a2 = CCDelayTime:create(1/fps-InstanceTime)
		local array = CCArray:create()
		array:addObject(a1)
		array:addObject(a2)
		
		return CCSequence:create(array)
	end, 

	['alpha'] = function ( alpha, fps )
		-- body
		local a1 = CCFadeTo:create(InstanceTime, alpha * 255)
		local a2 = CCDelayTime:create(1/fps-InstanceTime)
		local array = CCArray:create()
		array:addObject(a1)
		array:addObject(a2)
		
		return CCSequence:create(array)
	end, 

	['color'] = function ( color, fps )
		-- body
		local a1 = CCTintTo:create(InstanceTime, color[1] * 255, color[2] * 255, color[3] * 255)
		local a2 = CCDelayTime:create(1/fps-InstanceTime)
		local array = CCArray:create()
		array:addObject(a1)
		array:addObject(a2)
		
		return CCSequence:create(array)
	end, 

	['rotation'] = function ( rotation, fps )
		-- body
		local a1 = CCRotateTo:create(InstanceTime, rotation)
		local a2 = CCDelayTime:create(1/fps-InstanceTime)
		local array = CCArray:create()
		array:addObject(a1)
		array:addObject(a2)
		
		return CCSequence:create(array)
	end,

	-- ['image'] = function ( image, fps )
	-- 	-- body
	-- end,

	-- ['visible'] = function ( visible, fps )
	-- 	-- body
	-- 	visible = ()
	-- end,
}

ActionFactory.createInterRate = function ( frame1, frame2, frameInter, ease )
	-- body
	ease = ease or 0

	--[[   
		0->1
	--]]
	
	-- local mulRate = ease/100
	-- local basicRate = (frameInter-frame1) / (frame2-frame1)
	return (frameInter-frame1) / (frame2-frame1)
end

ActionFactory.createFrameVo = function ( prevVo, nextVo, newFrame, propertyMap )
	-- body
	assert(prevVo.frame < newFrame, 'prevVo.frame < newFrame')
	assert(nextVo.frame > newFrame, 'nextVo.frame > newFrame')

	local currVo = {}
	currVo.frame = newFrame

	local rate = ActionFactory.createInterRate(prevVo.frame, nextVo.frame, currVo.frame, prevVo.ease)

	for i, pro in ipairs(propertyMap) do
		local prevProperty = prevVo[pro]
		local nextProperty = nextVo[pro]

		local propertyType = type(prevProperty)
		if propertyType == 'table' then
			local currProperty = {}

			for ii, vv in ipairs(prevProperty) do
				currProperty[ii] = prevProperty[ii] + rate * (nextProperty[ii]-prevProperty[ii])
			end

			currVo[pro] = currProperty

		elseif propertyType == 'number' then
			currVo[pro] = prevProperty + rate * (nextProperty-prevProperty)

		else
			currVo[pro] = prevProperty
		end
	end


	return currVo
end


ActionFactory.makeSureTableFull = function ( _table )
	-- body
	local cached = ActionFactory._cache[ _table ]
	if not cached then

		local currentPropertyMap = {}

		for i,v in pairs(ValidPropertyMap) do
			if _table[1][i] then
				table.insert(currentPropertyMap, i)
			end
		end

		assert(#currentPropertyMap > 0)

		local maxF = _table[#_table].frame

		local newTable = {}

		for i=2, #_table do
			local prevVo = _table[i-1]
			local nextVo = _table[i]

			assert(prevVo.frame < nextVo.frame)

			if prevVo.frame+1 == nextVo.frame then
				table.insert(newTable, Utils.copyTable( prevVo ))
				table.insert(newTable, Utils.copyTable( nextVo ))
			else
				table.insert(newTable, Utils.copyTable( prevVo ))

				for newFrame=prevVo.frame+1, nextVo.frame-1 do
					local insertVo = ActionFactory.createFrameVo( prevVo, nextVo, newFrame, currentPropertyMap )
					table.insert(newTable, insertVo)
				end

				table.insert(newTable, Utils.copyTable( nextVo ))
			end
		end

		cached = {}
		cached.table 		= newTable
		cached.propertyMap 	= currentPropertyMap

		-- print('Action Cache')
		-- print(cached)

		ActionFactory._cache[ _table ] = cached
	end

	return cached.table, cached.propertyMap
end

ActionFactory.createAction = function ( _table, offset, fps )
	-- body
	assert(type(_table) == 'table', type(_table))
	assert(#_table > 1)

	assert(offset == nil)

	fps = fps or 20

	local fullTable, propertyMap = ActionFactory.makeSureTableFull( _table )

	if offset then
		-- assert(propertyMap['position'])
		for i,frameVo in ipairs(fullTable) do
			frameVo.position[1] = frameVo.position[1] + offset.x
			frameVo.position[2] = frameVo.position[2] + offset.y
		end
	end

	local ccaray_seq = CCArray:create()

	if (#propertyMap) > 1 then
		for i,frameVo in ipairs(fullTable) do
			local ccaray_spawn = CCArray:create()

			for ii, property in ipairs(propertyMap) do
				-- print(string.format('生成Action %d:%s ', i, property))
				local action = ValidPropertyMap[property]( frameVo[property], fps )
				ccaray_spawn:addObject(action)
			end

			ccaray_seq:addObject( CCSpawn:create(ccaray_spawn) )
		end
	else
		for i,frameVo in ipairs(fullTable) do
			local property = propertyMap[1]
			local action = ValidPropertyMap[property]( frameVo[property], fps )
			ccaray_seq:addObject( action )
		end
	end

	if offset then
		-- print('fullTable')
		-- print(fullTable)

		for i,frameVo in ipairs(fullTable) do
			frameVo.position[1] = frameVo.position[1] - offset.x
			frameVo.position[2] = frameVo.position[2] - offset.y
		end
	end

	return ElfAction:create( CCSequence:create( ccaray_seq ) )
end


return ActionFactory