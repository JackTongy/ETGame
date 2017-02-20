
---------------------------- BT_Node ----------------------------
--[[
BT_Type: Select, Condition, Sequence, Action
--]]

local BT_Node = class()

function BT_Node:ctor(args)
	-- body
end

function BT_Node:setTypeFunc( ptype, func )
	-- body
	assert(ptype)
	if ptype == 'Action' or ptype == 'Condition' then
		assert(func)
	end
	self._type = ptype
	self._func = func
end

function BT_Node:addChild( child )
	-- body
	assert(child)
	assert(self._type ~= 'Action')
	self._children = self._children or {}
	table.insert(self._children, child)
end

function BT_Node:executeSelf()
	-- body
	if self._type == 'Action' then
		assert(self._func, 'BT_Node:Action Must Have A Valid Func!')
		return self._func()
	elseif self._type == 'Select' then
		return true
	elseif self._type == 'Condition' then
		assert(self._func, 'BT_Node:Condition Must Have A Valid Func!')
		return self._func()
	elseif self._type == 'Sequence' then
		return true
	else
		assert(false, 'BT_Node:executeSelf, Error Type'..tostring(self._type))
	end
end

function BT_Node:executeChildren()
	-- body
	if self._type == 'Action' then
		return true
	elseif self._type == 'Select' then
		assert(self._children, 'BT_Node:Select Must Have Some Valid Children!')
		for i, v in ipairs(self._children) do
			if v:execute() then
				return true
			end
		end
		return false
	elseif self._type == 'Condition' then
		if self._children then
			for i, v in ipairs(self._children) do
				if v:execute() then
					return true
				end
			end
			return false
		else
			return true
		end
	elseif self._type == 'Sequence' then
		assert(self._children, 'BT_Node:Sequence Must Have Some Valid Children!')
		for i, v in ipairs(self._children) do
			if not v:execute() then
				return false
			end
		end
		return true
	else
		assert(false, 'BT_Node:executeChildren, Error Type'..tostring(self._type))
	end 
end

function BT_Node:execute()
	-- body
	return self:executeSelf() and self:executeChildren()
end

---------------------------- BT_Tree ----------------------------
local BT_Tree = class(BT_Node)

function BT_Tree:ctor()
	-- body
	self:setTypeFunc('Select', nil)
end

function BT_Tree:initNode(btData, funcMap, node )
	assert(btData)
	assert(funcMap)
	assert(node)
	-- type, key
	local selfData = btData.data
	assert(selfData.type, 'BT_Tree:Data Must Have A Type!')
	assert(selfData.key, 'BT_Tree:Data Must Have A Key!')

	local key = selfData.key
	local func = funcMap[key]
	assert(func, string.format('Not Found Key=%s In FuncMap!', tostring(key)))

	self:setTypeFunc(selfData.type, func)

	local array = btData.children
	if array then
		for i,v in ipairs(array) do
			local childNode = BT_Node.new()
			node:addChild(childNode)

			self:initNode(v, funcMap, childNode)
		end
	end
end

function BT_Tree:init( btData, funcMap, node )
	-- body
	return self:initNode(btData, funcMap, self)
end

local AIMaster = class()

function AIMaster:ctor()
 	-- body
 	self._btTree = BT_Tree.new()
 	-- self._blackboard = {}
end 

function AIMaster:setFuncMap( funcMap )
	-- body
	assert(funcMap)
	self._funcMap = funcMap
end

function AIMaster:setPlayer( player )
	-- body
	assert(player)
	self._player = player
end

function AIMaster:writeBlackboard( key, value )
	-- body
	assert(false)
	-- self._blackboard[key] = value
end

function AIMaster:readBlackboard( key )
	-- body
	assert(false)
	-- return self._blackboard[key]
end

function AIMaster:getPlayer()
	-- assert(self._player)
	return self._player
end

function AIMaster:initBtTree( btData )
	-- body
	assert(self._funcMap)
	return self._btTree:init(btData, self._funcMap)
end

function AIMaster:handleAI()
	-- body
	return self._btTree:execute()
end

return AIMaster