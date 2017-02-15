local SwfActionFactory = require 'framework.swf.SwfActionFactory'

local Utils = require 'framework.helper.Utils'

local CCActionManager = CCDirector:sharedDirector():getActionManager()

local Swf = class()
--[[
arg 为 swf的data或者文件名称
nodemap 为 tag 映射的节点图, 如果为nil 则全部重新生成
offsetmap 为对应节点相比swf原始的偏移
--]]
function Swf:ctor( arg, nodemap, offsetmap )
	-- body
	self._luaset = {}
	
	if type(arg) == 'string' then
		self._swfData = require(arg)
		self:makeSureSorted(self._swfData)
	elseif type(arg) == 'table' then
		self._swfData = arg
		self:makeSureSorted(self._swfData)
	else
		error('Swf ctor: error arg!')
	end

	self._offsetMap = offsetmap

	local root = self:makeSureNodes(self._swfData, nodemap) 
	if root then
		self._luaset[1] = root

		self._hasRootNode = true
	else
		--代替的做法
		-- self._luaset[1] = self._tagMap[1]
		self._hasRootNode = false
	end
end

function Swf:makeSureNodes( swfData, nodeMap )
	-- body
	--should call once
	assert(self._tagMap == nil)
	self._tagMap = {}

	local root

	for i,v in ipairs(swfData.array) do

		local node = nodeMap and nodeMap[i]
		if node then
			self._tagMap[i] = node
		else
			print('create tag = '..i)
			local node = AddColorNode:create()
			node:setVisible(false) --
			-- node:setAnchorPoint(ccp(0.5,0.5))
			-- i -> order

			if not root then
				root = ElfNode:create()
			end
			root:addChild(node, i,  i)

			self._tagMap[i] = node
		end
	end

	return root
end

function Swf:makeSureSorted( swfData )
	-- body
	if not swfData.sorted then
		do
			local max = -99999
			local min =  99999
			local len = 0

			for i,v in pairs(swfData.array) do
				if i > max then max = i end
				if i < min then min = i end
				len = len + 1
			end

			if min ~= 1 or max ~= len then
				local tmp = {}
				for i=min, max do
					local layer = swfData.array[i] 
					if layer then
						table.insert(tmp, layer)
					end
				end
				swfData.array = tmp

				print('=======makeSureSorted======')
				print('min:'..min)
				print('max:'..max)
				print('len:'..len)

				print('tmp len:'..#tmp)
				-- print(swfData.array)
			end

		end
		swfData.sorted = true
	end
end

function Swf:playLoop( shapeMap, range )
	-- body
	local swfData = self._swfData

	local array = swfData.array

	assert(array)
	assert(#array > 0)

	local startFrame = (range and range[1]) or 1
	local endFrame = (range and range[2]) or swfData.stage.maxF

	for i, v in pairs(array) do
		
		local node = self:getNodeByTag(i)
		if node then
			-- ActionFactory.createAction = function ( _table, shapeMap, offset, fps, startFrame, endFrame )
			local offset = self._offsetMap and self._offsetMap[i]

			local action = SwfActionFactory.createPureAction( v, shapeMap, offset, swfData.stage.fps, startFrame, endFrame)
			local ccrepeat = CCRepeatForever:create(action)

			node:runElfAction(ccrepeat)
		else
			print('Swf tag = '..i..' has not existed!')
		end
	end

end

function Swf:play( shapeMap, range, func )
	-- body
	-- local root = self:getRootNode()
	-- assert(root and not tolua.isnull(root))

	-- assert(shapeMap)
	local swfData = self._swfData

	local array = swfData.array

	assert(array)
	assert(#array > 0)

	local startFrame = (range and range[1]) or 1
	local endFrame = (range and range[2]) or swfData.stage.maxF

	for i, v in pairs(array) do
		
		local node = self:getNodeByTag(i)
		if node then
			-- ActionFactory.createAction = function ( _table, shapeMap, offset, fps, startFrame, endFrame )
			local offset = self._offsetMap and self._offsetMap[i]
			local action = SwfActionFactory.createAction( v, shapeMap, offset, swfData.stage.fps, startFrame, endFrame)

			if func then
				local realFunc = func
				action:setListener( function (  )
					-- body
					require 'framework.helper.Utils'.delay(function ()
						realFunc()
					end, 0)
				end)
				
				func = nil
				
				print('func added')
			end

			node:runElfAction(action)
		else
			print('Swf tag = '..i..' has not existed!')
		end
	end
end

function Swf:makeTraceData()
	-- body
	local sequence = self._sequenceData

	local traceData = {}
	for i,v in ipairs(sequence) do
		local data = { loops = 0 }
		table.insert(traceData, data)
	end

	return traceData
end

--[[
--]]

function Swf:playCallback()
	-- body
	assert(self._sequenceData)
	assert(self._traceData)

	local sequenceData = self._sequenceData
	local traceData = self._traceData

	for i,sData in ipairs(sequenceData) do
		local tData = traceData[i]
		if tData.loops < sData.loops then

			tData.loops = tData.loops + 1

			if tData.loops == sData.loops then
				--next
				--trigger callback
				if sData.func then
					sData.func()
				end

				local nextSData = sequenceData[i+1]
				if nextSData then
					self:play(self._shapeMap, nextSData.range, function ()
						-- body
						self:playCallback()
					end)
				else
					--finnally end
					return
				end
			else
				self:play(self._shapeMap, sData.range, function ()
					-- body
					self:playCallback()
				end)
			end

			return
		end
	end

	--do nothing 
	assert(false, 'should not here')
end


--[[
swf  对外部的调用接口
shapeMap 资源映射图
sequence 执行的序列 或者 也可以是单纯的回掉函数(默认执行一次)

	sequence结构如下
	
	[1] -callback
		-range [ start, end ]
		-loops 

	[2]	-callback
		-range [ start, end ]
		-loops 
	
	[3]	-callback
		-range [ start, end ]
		-loops 

	...

--]]
function Swf:splay(shapeMap, sequence)
	-- body
	self._sequenceData = nil
	self._traceData = nil
	self._shapeMap = shapeMap

	if sequence then
		if type(sequence) == 'function' then
			self:play(shapeMap, nil, sequence)
		elseif type(sequence) == 'table' then
			self._sequenceData = Utils.copyTable(sequence)

			assert(#self._sequenceData>0)

			self._traceData = self:makeTraceData()

			local firstData = self._sequenceData[1]
			self:play(self._shapeMap, firstData.range, function ( )
				-- body
				self:playCallback()
			end)

		else
			print(sequence)
			error('Unexpected arg for Swf splay. ')
		end
	else
		self:play(shapeMap, nil, nil)
	end
end

function Swf:getRunningStep(  )
	-- body
	if self._sequenceData and self._traceData then
		for i,sData in ipairs(self._sequenceData) do
			local tData = self._traceData[i]
			if tData.loops < sData.loops then
				return i
			end
		end
	end

	return -1
end

function Swf:getRunLoopsByStep( step )
	-- body
	if self._sequenceData and self._traceData then
		local tData = self._traceData[step]
		if tData then
			return tData.loops
		end
	end

	return -1
end

function Swf:quickFinishStep( step )
	-- body
	if self._sequenceData and self._traceData then
		local sData = self._sequenceData[step]
		local tData = self._traceData[step]
		if tData.loops < sData.loops then
			tData.loops = sData.loops - 1
		end
	end
end

function Swf:pause()
	-- body
	local size = #self._tagMap
	for i=1, size do
		local node = self:getNodeByTag(i)
		if node then
			CCActionManager:pauseTarget( node )
		end
	end
end

function Swf:resume()
	-- body
	local size = #self._tagMap
	for i=1, size do
		local node = self:getNodeByTag(i)
		if node then
			CCActionManager:resumeTarget( node )
		end
	end
end

function Swf:getNodeByTag( tag )
	-- body
	if self._tagMap and self._tagMap[tag] and not tolua.isnull(self._tagMap[tag]) then
		return self._tagMap[tag]
	end
end

--[[]]
function Swf:setDisposed()
	-- body
	local root = self:getRootNode()
	if root then
		root:removeFromParent()
	end
end

function Swf:isDisposed()
	-- body
	if self._hasRootNode then
		if (not self._luaset) or (not self._luaset[1]) or (tolua.isnull(self._luaset[1])) then
			return true
		end
	else
		if (not self._tagMap) or (not self._tagMap[1]) or (not tolua.isnull(self._tagMap[1])) then
			return true
		end
	end
end


function Swf:getRootNode()
	-- body
	if self._hasRootNode then
		if not self:isDisposed() then
			return self._luaset[1]
		end
	else
		error('Swf Unexpected Call getRootNode!')
	end
end

function Swf:retain()
	-- body
	if self._hasRootNode then
		local  root = self:getRootNode()
		assert(root, 'Swf:retain NULL')

		root:retain()
	else
		error('Swf Unexpected Call retain!')
	end
end

function Swf:release()
	-- body
	if self._hasRootNode then
		local  root = self:getRootNode()
		assert(root, 'Swf:release NULL')

		root:release()
	else
		error('Swf Unexpected Call retain!')
	end
end

return Swf