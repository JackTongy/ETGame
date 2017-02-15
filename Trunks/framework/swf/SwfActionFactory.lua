local ActionFactory = {}
local Utils = require 'framework.helper.Utils'

ActionFactory._cache = {}

local InstanceTime = 0.001

local ValidPropertyMap = {

	['p'] = true,
	['s'] = true,
	['a'] = true,
	['c'] = true,
	['r'] = true,
	['v'] = true,
	['i'] = true,
	['ar'] = true,
	['call'] = true,

	['c2'] = true,

	['bl'] = true,

	['nil'] = true,
}

local PropertyFuncMap = { 
	['bl'] = function ( blendData, fps )
		-- body
		assert(blendData)

		-- assert(false)

		local a1 = CCCallFuncN:create(function ( node )
			-- body
			tolua.cast(node, 'ElfNode')
			assert(node)

			if node then
				node:setBlendMode(blendData[1], blendData[2])
				-- node:setBlendMode(1, 771)
			end
		end)

		local a2 = CCDelayTime:create(1/fps)
		local array = CCArray:create()
		array:addObject(a1)
		array:addObject(a2)

		return CCSequence:create(array)
	end,

	['ar'] = function ( anchor, fps )
		-- body
		local a1 = ActionPlaceAnchor:create(ccp(anchor[1], anchor[2]))
		local a2 = CCDelayTime:create(1/fps)
		local array = CCArray:create()
		array:addObject(a1)
		array:addObject(a2)

		return CCSequence:create(array)
	end,

	['p'] = function ( pos, fps )
		-- body
		local a1 = CCPlace:create(ccp(pos[1],  pos[2]))
		local a2 = CCDelayTime:create(1/fps)
		local array = CCArray:create()
		array:addObject(a1)
		array:addObject(a2)

		return CCSequence:create(array)
	end, 

	-- ['p'] = ['']

	['s'] = function ( scale, fps )
		-- body
		local a1 = CCScaleTo:create(InstanceTime, scale[1], scale[2])
		local a2 = CCDelayTime:create(1/fps-InstanceTime)
		local array = CCArray:create()
		array:addObject(a1)
		array:addObject(a2)
		
		return CCSequence:create(array)
	end, 

	['a'] = function ( alpha, fps )
		-- body
		local a1 = CCFadeTo:create(InstanceTime, alpha)
		local a2 = CCDelayTime:create(1/fps-InstanceTime)
		local array = CCArray:create()
		array:addObject(a1)
		array:addObject(a2)
		
		return CCSequence:create(array)
	end, 

	['c'] = function ( color, fps )
		-- body
		local a1 = CCTintTo:create(InstanceTime, color[1] , color[2] , color[3] )
		local a2 = CCDelayTime:create(1/fps-InstanceTime)
		local array = CCArray:create()
		array:addObject(a1)
		array:addObject(a2)
		
		return CCSequence:create(array)
	end, 

	['r'] = function ( rotation, fps )
		-- body
		local a1 = CCRotateTo:create(InstanceTime, rotation)
		local a2 = CCDelayTime:create(1/fps-InstanceTime)
		local array = CCArray:create()
		array:addObject(a1)
		array:addObject(a2)
		
		return CCSequence:create(array)
	end,

	['v'] = function ( visible, fps )
		-- body
		-- local a0 = CCCallFuncN:create(function ( node )
		-- 	-- body
		-- 	tolua.cast(node, 'ElfNode')
		-- 	assert(node)

		-- 	if node then
		-- 		node:setBlendMode(770,1)
		-- 	end
		-- end)

		local a1 = (visible and CCShow:create()) or (CCHide:create())
		local a2 = CCDelayTime:create(1/fps)

		local array = CCArray:create()
		-- array:addObject(a0)
		array:addObject(a1)
		array:addObject(a2)
		
		return CCSequence:create(array)
	end,

	['i'] = function ( resid, fps, shapeMap )
		-- body
		if shapeMap then
			local newResid = shapeMap[ resid ]
			if newResid then
				resid = newResid
			else
				print('SWF:not found resid:'..resid)
			end
		end

		-- print('new resid = '..resid)

		local a1 = ActionResid:create(resid)
		local a2 = CCDelayTime:create(1/fps)

		local array = CCArray:create()
		array:addObject(a1)
		array:addObject(a2)
		
		return CCSequence:create(array)
	end,

	['call'] = function ( func, fps )
		-- body
		assert(func)

		local a1 = CCCallFunc:create(func)
		local a2 = CCDelayTime:create(1/fps)

		local array = CCArray:create()
		array:addObject(a1)
		array:addObject(a2)
		
		return CCSequence:create(array)
	end,

	['nil'] = function ( fps )
		-- body
		return CCDelayTime:create(1/fps)
	end,

	['c2'] = function ( c2, fps)
		-- body
		local a1 = AddColorAction:create(c2[1], c2[2], c2[3], c2[4])
		local a2 = CCDelayTime:create(1/fps)

		local array = CCArray:create()
		array:addObject(a1)
		array:addObject(a2)
		
		return CCSequence:create(array)
	end

}

--[[
_table: 输入的关键帧数据
offset: 相对偏移量
-- auto:	是否自动补帧率, not used
fps:	帧率
shapeMap:  image redirect
--]]
ActionFactory.createAction = function ( _table, shapeMap, offset, fps, startFrame, endFrame, log )
	-- body
	local action = ActionFactory.createPureAction( _table, shapeMap, offset, fps, startFrame, endFrame, log )
	return ElfAction:create( action )
end

ActionFactory.createPureAction = function ( _table, shapeMap, offset, fps, startFrame, endFrame, log )
	assert(type(_table) == 'table', type(_table))
	assert(#_table >= 1, _table)

	--swf 不需要自动补帧
	-- assert(not auto)
	assert(offset == nil)

	fps = fps or 20

	local fullTable = _table
	startFrame = startFrame or 1
	endFrame = endFrame or fullTable[#fullTable].f
	assert(endFrame>=startFrame, fullTable)

	if offset then
		for i=startFrame, endFrame do
			local frameVo = fullTable[i]
			if frameVo and frameVo.p then
				frameVo.p[1] = frameVo.p[1] + (offset[1] or offset.x)
				frameVo.p[2] = frameVo.p[2] + (offset[2] or offset.y)
			end
		end
	end

	local ccaray_seq = CCArray:create()

	local nextIndex = 1
	--fix nextIndex bug
	for i,v in ipairs(fullTable) do
		if v.f >= startFrame then
			nextIndex = i
			break
		end
	end

	local nextVo = fullTable[nextIndex]
	local nextI = nextVo.f
	
	for i=startFrame, endFrame do

		if i == nextI then
			local frameVo = nextVo

			if log then
				print(frameVo)
			end
			
			local spawnActionTable = {}

			for property, v in pairs(frameVo) do
				if ValidPropertyMap[property] then
					local action = PropertyFuncMap[property]( v, fps, shapeMap )
					table.insert(spawnActionTable, action)
				end
			end

			local spawnLen = #spawnActionTable
			if spawnLen == 0 then
				--just do delay
				local action = PropertyFuncMap['nil']( fps )
				ccaray_seq:addObject( action )
			elseif spawnLen == 1 then
				local action = spawnActionTable[1]
				ccaray_seq:addObject( action )
			else
				local ccaray_spawn = CCArray:create()
				for ii, action in ipairs(spawnActionTable) do
					ccaray_spawn:addObject(action)
				end
				ccaray_seq:addObject( CCSpawn:create(ccaray_spawn) )
			end
			
			nextIndex = nextIndex + 1
			nextVo = fullTable[nextIndex]
			nextI = nextVo and nextVo.f
		else
			local action = PropertyFuncMap['nil']( fps )
			ccaray_seq:addObject( action )
		end		
	end


	if offset then
		for i=startFrame, endFrame do
			local frameVo = fullTable[i]
			if frameVo and frameVo.p then
				frameVo.p[1] = frameVo.p[1] - (offset[1] or offset.x)
				frameVo.p[2] = frameVo.p[2] - (offset[2] or offset.y)
			end
		end
	end

	return CCSequence:create( ccaray_seq )
end


return ActionFactory