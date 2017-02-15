require "framework.interface.LuaLayer"

local constants = require 'framework.basic.Constants'

LuaMenu = class(LuaLayer)

function LuaMenu:ctor()
	-- body
end

function LuaMenu:getType()
	-- body
	return 'Menu'
end

function LuaMenu:getIndex()
	-- body
	return self._index or constants.MENU_INDEX
end

function LuaMenu:getShieldBelow()
	return false
end

require 'framework.basic.MetaHelper'.classDefinitionEnd(LuaMenu, 'LuaMenu')

