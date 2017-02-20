-- local handleManager = require 'framework.net.SocketHandleManager' 
local client = {}

function client:connect(addr, port, callback)
	-- body
	local socket_creator = require 'framework.net.Socket'

	local core = socket_creator.new(addr, port, callback)
	if core then
		local meta = getmetatable(self)
		meta = meta or {}
		meta.__index = core
		
		setmetatable(self, meta)
	else
		print('Net Error: connecting to '..addr..':'..port..' failded!')
	end
end

return client