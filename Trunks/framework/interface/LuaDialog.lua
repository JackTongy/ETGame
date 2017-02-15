require 'framework.interface.LuaLayer'

local constants = require 'framework.basic.Constants'

LuaDialog = class(LuaLayer)

function LuaDialog:ctor()
	
end

function LuaDialog:getType()
	-- body
	return 'Dialog'
end

function LuaDialog:getIndex()
	-- body
	return self._index or constants.DIALOG_INDEX
end

require 'framework.basic.MetaHelper'.classDefinitionEnd(LuaDialog, 'LuaDialog')