-- AbsView
local XmlCache = require 'XmlCache'
local Utils = require 'framework.helper.Utils'
local TimeOutManager = require "TimeOut"
local AbsView = class()

function AbsView:ctor()
	-- body

	-- self._state = 'running'
end

-- function AbsView:setLuaset( luaset )
-- 	-- body
-- 	assert( (not self._luaset) and luaset )
-- 	self._luaset = luaset
-- end

-- function AbsView:getLuaset(  )
-- 	-- body
-- 	return self._luaset
-- end

function AbsView:getRootNode( )
	-- body
	if self._luaset and not tolua.isnull(self._luaset[1]) then

		return self._luaset[1]
	else
		-- error('')
	end
end

function AbsView:getLuaset( )
	-- body
	return self._luaset
end

function AbsView:dispose()
	-- body
	local root = self:getRootNode()
	if root then
		if not tolua.isnull(root) then
			root:removeFromParentAndCleanup(true)
			-- self._luaset = nil
			-- return
		end
	end

	if root == nil or tolua.isnull(root) then
		self._luaset = nil
	end
end

function AbsView:setDisposed()
	-- body
	self:dispose()
end

function AbsView:runWithDelay(func, delay)
	-- body

	assert(self._luaset)

	local timeOut = TimeOutManager.getTimeOut(delay,func)
	timeOut:start()
end

function AbsView:delay(func, delay)
	-- body
	-- assert(self._luaset)
	
	self:runWithDelay(func, delay)
end

function AbsView:isDisposed()
	-- body
	if self._luaset then
		if not tolua.isnull(self._luaset[1]) then
			return false
		end
	end

	return true
end

function AbsView:setXmlName( name )
	-- body
	self._xmlName = name
end

function AbsView:getXmlName(  )
	-- body
	return self._xmlName
end

function AbsView:getXmlGroup(  )
	-- body
	return self._xmlGroup
end

function AbsView:setXmlGroup( xmlgroup )
	-- body
	self._xmlGroup = xmlgroup
end

function AbsView:createDyLuaset( elementname )
	-- body
	return XmlCache.createDyLuaset( elementname, self:getXmlName(), self:getXmlGroup() )
end

function AbsView:getActionCloneByName( name )
	-- body
	local luaset = self:createDyLuaset(name)
	return luaset[1]:clone()
end

function AbsView:retain()
	-- body
	-- assert(false)

	local node = self:getRootNode()
	if node then
		node:retain()
	end
end

function AbsView:release()
	-- body
	local node = self:getRootNode()
	if node then
		node:release()
	end
end

return AbsView