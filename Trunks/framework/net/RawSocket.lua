--libs
local Socket_creator = require "socket"
local Json = require "framework.basic.Json"
local Timer = require "framework.sync.TimerHelper"
local HandlerManager = require 'framework.net.SocketHandleManager'

local SocketIdMaker = 0
local default_timeout = 20

local new
new = function (addr, port, callback)
	
	local ipv6support = false
	if string.find(addr,'.net') or string.find(addr,'.com') then
		local addrinfo = socket.dns.getaddrinfo(addr)
		print('addrinfo:')
		print(addrinfo)
		for k,v in pairs(addrinfo) do
			addr = v.addr
			if v.family == 'inet6' then
				ipv6support = true
				break
			end
		end
	end

	if require "framework.basic.Device".platform == "ios" then	
		local ret,ip= CCLuaObjcBridge.callStaticMethod('UIDeviceUtil','deviceIPAdress',nil)
		print(ret)
		print(ip)
		if ret and ip then
			if string.find(ip,':') then
				print('ipv6 netwrok!')
				-- if not ipv6support and string.find(addr,'.') then
				-- 	addr = string.format('64:ff9b::%s',addr)
				-- end
			else
				print('ipv4')
			end
		end
	end

	-- body
	--funcs
	local connect
	local send
	local close
	local getstatus
	local update
	local heartbeat
	local ignore
	local handler
	local socket

	SocketIdMaker = SocketIdMaker + 1
	local myId = SocketIdMaker

	--members

	local order_seed = 0
	local order_generator = function ()
		-- body
		order_seed = order_seed + 1
		return order_seed
	end

	local __callback_order_map = {}

	local __timeout_handle_list = {}

	-- local __total_timeout_count = 0

	--[[
	error:
		'timeout'
		'err'	
		-- ''
	--]]

	local socket_callback
	socket_callback = function ()
		-- body
		-- print('before attampt')

		local recvt, sendt, status = Socket_creator.select({socket}, nil, 0)

		if #recvt <= 0 then
			return 
		end

		local response, err, code = socket:recv_block()

		while response or err or code do
			if response then
				print('Socket Id '..myId)
				print('------from server response-----')
				print(response)
				print('time = '..SystemHelper:currentTimeMillis())
				print('----------------------')


				local data = Json.decode(response)

				if HandlerManager.catchResponse(data) then
					--dealwith broadcast

				else
					local order = data.O or -1

					local callback = __callback_order_map[order]
					__callback_order_map[order] = nil

					--不会调用到超时
					if __timeout_handle_list[order] then
						Timer.cancel( __timeout_handle_list[order] )
						__timeout_handle_list[order] = nil
					end

					if not callback then
						--do nothing, 可能已经超时处理过了
						print('Socket Id '..myId)

						local msg = string.format('response=%s, err=%s,code=%s', tostring(response), tostring(err), tostring(code))
						print('recv unexcept (no callback is waiting for this data) !')
						print(msg)
						print('-------------------')
						-- error()

					elseif HandlerManager.catchErr(data) then
						--Err
						-- local msg = string.format('err=%s,code=%s', tostring(err), tostring(code))
						callback( 'error', data )

					elseif data then

						if data.C then

							callback( data )
							
						else
							-- local msg = string.format('response=%s, err=%s,code=%s', tostring(response), tostring(err), tostring(code))
							callback( 'error', data )

							print('Socket Id '..myId)
							print('recv unexcept (no callback is matched with this data) !')
							print(data)
							print('-------------------')
							-- error()
						end
					end
				end
			
			elseif err or code then

				local msg = string.format('err=%s,code=%s', tostring(err), tostring(code))

				local myData = {}
				myData.err = err;
				myData.code = code;

				print('Socket Id '..myId)
				print('-----err or code-----')
				print(myData)
				
				-- callback( 'error', myData )
				-- break
			else
				--wait for data's comming
				
			end 
			
			response, err, code  = socket:recv_block_next()
		end
	end

	local last_time
	local heartbeatbag_interval = 1000*60*3
	-- local heartbeatbag_interval = 1000*15

	heartbeat = function ()
		-- body
		local now = SystemHelper:currentTimeMillis()
		last_time = last_time or now

		if now - last_time >= heartbeatbag_interval then
			last_time = now

			local heartbeatbag = { C = 'Pulse' }
			send(heartbeatbag)
		end
	end

	update = function ()
		-- body
		-- local status = socket:getstats()
		-- -- print('*--status--*')
		-- -- print(status)
		
		-- --to be added
		-- if status == '' then
		-- 	--close...
		-- else
			--1 recv
			socket_callback()

			--2 hearbeat
			heartbeat()
		-- end
	end

	ignore = function ( index )
		-- body
		assert(false)
	end

	connect = function (addr, port, callback)
		-- body
		local beforeConnectTime = SystemHelper:currentTimeMillis()

		socket = Socket_creator.connect(addr, port)

		local afterConnectTime = SystemHelper:currentTimeMillis()

		-- assert(socket)
		if not socket then
			print('Socket Id '..myId)
			print('connect to '..addr..':'..port..' failed!!'..(afterConnectTime-beforeConnectTime))
			callback(false)
			return 
		end

		print('Socket Id '..myId)
		print('connect to '..addr..':'..port..' suc!!'..(afterConnectTime-beforeConnectTime))

		-- * Sets timeout values for IO operations
		-- * Lua Input: base, time [, mode]
		-- *   time: time out value in seconds
		-- *   mode: "b" for block timeout, "t" for total timeout. (default: b)

		socket:settimeout(0,'t') -- r
		socket:settimeout(0,'b')

		-- settimeout(1)
		--send seed
		--recv seed
		local seed = os.time()
		local params = { C ='NewSeed', D = { Seed = seed } }

		-- connect_state = enum_connect
		send(params, function(response, err, code)
			--callback
			if response and response.D then
				print('Socket Id '..myId)
				print('recv seed')
				print(response) 

				if not params.D.Seed then
					print('Socket Id '..myId)
					print('-----error params.D.Seed-----')
					print(params)
				end

				if not response.D.Seed then
					print('Socket Id '..myId)
					print('-----error response.D.Seed-----')
					print(response)
				end

				socket:set_send_seed( params.D.Seed )
				socket:set_recv_seed( response.D.Seed )

				if callback then
					callback(true)
				end

			else
				print('Socket Id '..myId)
				print('recv error')
				print(response) 

				close()
				local connectErr = string.format('Error on recv server seed [err=%s, code=%s]', tostring(err), tostring(code))
				print('Socket Id '..myId)
				print(connectErr)
				HandlerManager.catchErr(connectErr)

				if callback then
					callback(false)
				end

			end
		end, 1000, 0x8000)

		--tick
		handler = Timer.tick(update)
	end

	close = function ()
		-- body
		print('Socket Id '..myId)
		print('socket close 1')
		print(debug.traceback())
		if handler then
			print('socket close 2')
			assert(socket)
			Timer.cancel(handler)
			handler = nil

			return socket:close()
		elseif socket then
			print('socket close 3')
			-- return socket:close()
		else
			print('socket close 4')
		end

		for i,v in pairs( __timeout_handle_list ) do
			Timer.cancel(v)
		end

		__timeout_handle_list = {}

	end

	getstatus = function ()
		-- body
		assert(socket)
		return socket:getstatus()
	end

	send = function ( ptable, callback, timeout, ptype )
		-- body
		assert(type(ptable) == 'table')
		-- callback = callback or function ()end

		if callback then
			ptable.NR = nil
		else
			ptable.NR = 0 -- no nned for reply
		end

		ptype = ptype or 0x8080 -- default should be 8080

		-- assert(not ptable.O)
		if not ptable.O then
			ptable.O = order_generator()
		end

		assert(ptable.O)

		ptable.Time = SystemHelper:currentTimeMillis()
		
		local data = Json.encode(ptable)

		print('Socket Id '..myId)
		print('Cline Send:')
		print(data)
		print('ptype'..ptype)
		print('time = '..SystemHelper:currentTimeMillis())

		local number, err, count = socket:send_block(data, ptype)

		if not number and (err or count) then
			-- do nothing
			local closeErr = 'Socket error2:'..tostring(err)
			print('Socket Id '..myId)
			print(closeErr)
			HandlerManager.catchErr(closeErr)
			close()

			return nil
		end

		if callback then

			__callback_order_map[ ptable.O ] = callback

			timeout = timeout or default_timeout --内部默认时间
			timeout = math.max(timeout, default_timeout)
			print('timeout:'..timeout)
			-- timeout = 5

			Timer.cancel( __timeout_handle_list[ ptable.O ] )
			__timeout_handle_list[ ptable.O ] = nil

			local pointTimeStep = SystemHelper:currentTimeMillis() + 1000 * timeout

			__timeout_handle_list[ ptable.O ] = Timer.tick(function ()
				-- body
				if SystemHelper:currentTimeMillis() < pointTimeStep then
					return false
				end

				__callback_order_map[ ptable.O ] = nil
				__timeout_handle_list[ ptable.O ] = nil
				
				callback('error', 'timeout')
				
				local timeoutErr = 'Socket error:timeout'	
				print('Socket Id '..myId)		
				print(timeoutErr)
				print(data)
				print('time '..SystemHelper:currentTimeMillis())

				HandlerManager.catchErr(timeoutErr)
				
				return true
			end, 0)
		end

		--return final send data
		return data
	end

	local client = {}

	connect(addr, port, callback)
	-- socket:settimeout(0.1,'r')
	-- socket:settimeout(0.1,'b')
	
	client.send = function( self, ptable, callback, timeout, ptype )
		-- body
		return send(ptable, callback, timeout, ptype)
	end

	client.close = function ( self )
		-- body
		close()
	end

	client.getstatus = function ( self )
		-- body
		return getstatus()
	end

	client.ignore = function ( self, index )
		-- body
		return ignore(index)
	end

	client.setDefaultTimeout = function (seconds)
		default_timeout = seconds or default_timeout or 20
	end

	-- client.
	setmetatable(client, {
		__gc = function ( ptable )
			-- body
			ptable:close()
		end
	})

	return client
end

return { new = new }