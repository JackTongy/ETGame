require 'framework.interface.LuaLayer'

local constants = require 'framework.basic.Constants'

LuaNetView = class(LuaLayer)

function LuaNetView:ctor()
	-- body
end

function LuaNetView:getIndex()
	-- body
	return self._index or constants.NET_VIEW_INDEX
end

require 'framework.basic.MetaHelper'.classDefinitionEnd(LuaNetView, 'LuaNetView')