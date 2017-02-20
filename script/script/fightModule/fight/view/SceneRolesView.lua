
local RoleSelfManager = require 'RoleSelfManager'

local meta = { __index = function ( t, i )
	-- body
	local t
	if RoleSelfManager.isPvp then
		t = require 'PvpSceneRolesView'
	else
		t = require 'PveSceneRolesView'
	end
	return t[i]
end}

local delegate = {}
setmetatable(delegate, meta)
return delegate

