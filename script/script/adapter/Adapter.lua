
local Adapter = {}
setmetatable(Adapter, { __index = function ( t, i )
	-- body
	local Device = require 'framework.basic.Device'

	local proxy
	if Device.model == 'ipad' then
		proxy = require 'script.adapter.IpadAdapter'
	else
		proxy = require 'script.adapter.DefaultAdapter'
	end
	
	return proxy[i]
end})

return Adapter