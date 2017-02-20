local meta = { __index = function ( t,i )
	-- body
	local t
	if require 'ServerRecord'.getMode() == 'guider' then
		t = require 'ManaManager_Guider'
	else
		t = require 'ManaManager_Normal'
	end

	return t[i]
end}

local delegate = {}
setmetatable(delegate, meta)

return delegate
