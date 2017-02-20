local RoleSelfManager = require 'RoleSelfManager'

-- if RoleSelfManager.isPvp then
-- return require 'PvpFightView'
-- else
-- 	return require 'PveFightView'
-- end

-- return require 'PveFightView'

local meta = { __index = function ( t,i )
	-- body
	local t
	if RoleSelfManager.isPvp then
		t = require 'PvpFightView'
	else
		t = require 'PveFightView'
	end

	return t[i]
end}

local delegate = {}
setmetatable(delegate, meta)
return delegate
