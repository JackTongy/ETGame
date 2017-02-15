
local function createShell(ptable)
	local shell = {}
	setmetatable(shell, {__index = ptable, __newindex = function(t,k,v)
		error('Attempt to new index '..tostring(k)..' error!')
	end})
	
	return shell
end

local __metatable__restore = {}

local function classDefinitionEnd(class, name)
	if not __metatable__restore[class] then
		local oldmetatable = getmetatable(class)
		__metatable__restore[class] = oldmetatable

		local newmetatable = { __newindex = function (t,k,v)
    		return error(tostring(name).." Should Not Be Called New Index Any More!")
		end}
		setmetatable(class, newmetatable)
	end
end

local function classDefinitionEndRemoval( class )
	-- body
	local oldmetatable = __metatable__restore[class]

	if oldmetatable then
		__metatable__restore[class] = nil
		setmetatable(class, oldmetatable)
	end
end

local helper = {createShell = createShell, classDefinitionEnd = classDefinitionEnd, classDefinitionEndRemoval = classDefinitionEndRemoval}

return createShell(helper)