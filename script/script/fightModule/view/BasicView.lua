local Utils = require 'framework.helper.Utils'

require "TimeOut"
local BasicView = class()

local Factory = XMLFactory:getInstance()

function BasicView:createLuaSet(document, name)

	local element = Factory:findElementByName(document, name)
	assert(element) 

	local cset = Factory:createWithElement(element)
	local luaset = Utils.toluaSet(cset)
	
	return luaset
end

function BasicView:runWithDelay( func, tv, node )
	-- body
	local timeOut = TimeOut.new(tv or 0,func)
	timeOut:start()   --- 修复 界面卡死问题
end

function BasicView:getRootNode( )
	-- body
	if self._luaset then
		return self._luaset[1]
	else
		-- error('')
	end
end

function BasicView:getLuaset( )
	-- body
	return self._luaset
end

function BasicView:isDisposed()
	-- body
	if self._luaset then
		if not tolua.isnull(self._luaset[1]) then
			return false
		end
	end

	return true
end

function BasicView:dispose()
	-- body
	local root = self:getRootNode()
	if root then
		if not tolua.isnull(root) then
			root:removeFromParentAndCleanup(true)
			self._luaset = nil
		end
	end
end

function BasicView:setDisposed()
	-- body
	self:dispose()
end



return BasicView