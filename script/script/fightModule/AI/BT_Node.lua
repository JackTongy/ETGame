local BT_Node = class()

local BT_Node = class()

function BT_Node:ctor(ptype, func)
	-- body
	if ptype then
		self:setTypeFunc(ptype, func)
	end
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
	-- assert(self._type ~= 'Action')

	self._children = self._children or {}
	table.insert(self._children, child)
end

function BT_Node:executeSelf( target )
	-- body
	if self._type == 'Action' then
		assert(self._func, 'BT_Node:Action Must Have A Valid Func!')
		return self._func(target)
	elseif self._type == 'Select' then
		return true
	elseif self._type == 'Condition' then
		assert(self._func, 'BT_Node:Condition Must Have A Valid Func!')
		return self._func(target)
	elseif self._type == 'Sequence' then
		return true
	else
		assert(false, 'BT_Node:executeSelf, Error Type'..tostring(self._type))
	end
end

function BT_Node:executeChildren(target)
	-- body
	if self._type == 'Action' then
		return true
	elseif self._type == 'Select' then
		assert(self._children, 'BT_Node:Select Must Have Some Valid Children!')
		for i, v in ipairs(self._children) do
			if v:execute(target) then
				return true
			end
		end
		return false
	elseif self._type == 'Condition' then
		if self._children then
			for i, v in ipairs(self._children) do
				if v:execute(target) then
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
			if not v:execute(target) then
				return false
			end
		end
		return true
	else
		assert(false, 'BT_Node:executeChildren, Error Type'..tostring(self._type))
	end 
end

function BT_Node:execute(target)
	-- body
	return self:executeSelf(target) and self:executeChildren(target)
end

return BT_Node