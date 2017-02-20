local emptyTable = {}

local function emptyFunc( ... )
	-- body
	return emptyTable
end

setmetatable(emptyTable, {__index = function(t,k)
	return emptyFunc
end})



local function cleanTable(t)
	assert(t)
	local keySet = {}
	for i,v in pairs(t) do
		keySet[i] = true
	end

	for i,v in pairs(keySet) do
		t[i] = nil
	end
end

local function setEmptyFunc(t)
	assert(t)
	setmetatable(t, {__index = function(t,k)
		return emptyFunc
	end})
end

local function injectTable(t)
	cleanTable(t)
	setEmptyFunc(t)
end

local SwfActionFactory 		= require 'framework.swf.SwfActionFactory'
injectTable(SwfActionFactory)

CCArray = {}
injectTable(CCArray)
