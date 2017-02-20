local Config = require 'Config'

local GridView = class()

local GridManager = require 'GridManager'

function GridView:ctor( luaset )
	-- body
	self._luaset = luaset
end


return GridView