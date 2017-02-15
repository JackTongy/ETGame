local handleManager = require 'framework.net.SocketHandleManager' 

local map = {}

handleManager.setResponseHandler(function (data)
	-- body
	if data and data.B then
		local func = map[data.B]
		if func then
			func(data)
		else
			print('----broadcast warning----')
			print('no function to deal with this broadcast')
			print(data)
			print('-------------------------')
		end

		return true
	end
end)

local function check(name, func)
	map[name] = func
end

return { check = check }