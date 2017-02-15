local utils = require "framework.helper.Utils"
local handleManager = require 'framework.net.SocketHandleManager'

local new
new = function ( addr, port )
	-- body
	-- local wsRet = {}

	local socketfd = addr..":"..port

	print("connecting..."..socketfd)

	local socket = WebSocket:create(socketfd)

	local list_creator = require "framework.basic.List"

	local callback_list = list_creator('new')

	local pre_todo_lsit = {}

	--unused self
	local function send(self, content, callback)
		-- print('sending...')
		if socket:getReadyState() == kStateOpen then
			if callback then
				callback_list('add', callback)
			end
       	
       		-- socket:sendTextMsg( cjson.encode(content) )
       		--Login {"Id":2,"Timestamp":1395290866}
       		local str = cjson.encode(content)
       		-- str = 'hello'
       		-- print(str)
       		socket:sendTextMsg( str )
    	else
    		-- callback({ "Socket Is Not Ready!" })
    		-- table.insert(pre_content_lsit, content)
    		-- table.insert(pre_callback_list, callback)
    		-- print('warnings...') 

    		table.insert(pre_todo_lsit, function (  )
    			-- body
    			send(content, callback)
    		end)
    	end
	end

	local function onOpen(event)
		print("WebSocket onOpen Called!")

		for i,v in ipairs(pre_todo_lsit) do 
			v()
		end
		pre_todo_lsit = nil
	end

	local function onMessage(event)
		local content = cjson.decode(event)

		-- print('--------')
		-- print(event)

		if not content then
			error('not json received!')
			handleManager.catchErr(event)

		elseif content.C then
			handleManager.catchResponse(content)

		else
			if handleManager.catchResponse(content) then
				return
			end

			local callback = callback_list('pop_front')
			if callback then
				local content = cjson.decode(event)
		
				if content then
					callback(content)
				else
					print("onMessage Not A Json:"..utils.dump(event))
				end
			else
				print("WebSocket OnMessage: Has No Callback Error!"..utils.dump(event))
			end
		-- else
		-- 	error('')
		end
	end

	local function onClose(event)
		print("WebSocket onClose Called!")
	end

	local function onError(event)
		print("WebSocket onError :"..type(event)..":"..event)
	end

	socket:registerScriptHandler(onOpen, kWebSocketScriptHandlerOpen)
	socket:registerScriptHandler(onMessage, kWebSocketScriptHandlerMessage)
	socket:registerScriptHandler(onClose, kWebSocketScriptHandlerClose)
	socket:registerScriptHandler(onError, kWebSocketScriptHandlerError)

	-- webSocket.send = send
	
	return { send = send }
end

return { new = new }
