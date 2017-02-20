-- local handleManager = require 'framework.net.SocketHandleManager' 
local socket_creator = require 'framework.net.Socket' 
local Utils = require 'framework.helper.Utils'
local DlogEnable = false

local LastCore = nil

local client = {}

function client:connect(addr, port, callback)
	-- body

	-- self:closed()
	if LastCore then
		LastCore:close()
		LastCore = nil
	end
	
	local core = socket_creator.new(addr, port, callback)
	if core then

		LastCore = core 

		local meta = getmetatable(self)
		meta = meta or {}
		meta.__index = core
		
		setmetatable(self, meta)
	else
		print('Net Error: connecting to '..addr..':'..port..' failded!')
	end
end


local Indicator = require 'DIndicator'
local handlerManager = require 'framework.net.SocketHandleManager'
local ArgQueue = require 'ArgQueue'
local Launcher = require 'Launcher'

local errorHandle = function ( msg )
	local msgs = {}
	table.insert(msgs,"----------------------------------------")
    table.insert(msgs,"LUA ERROR: " .. tostring(msg))  
    table.insert(msgs,debug.traceback())  
    table.insert(msgs,"----------------------------------------")      
	require 'DLuaLogView'
    GleeCore:showLayer('DLuaLogView',msgs)
end

local recordTime = function ( arg,isrecv)
	if DlogEnable then
		require 'LogHelper'.recordTime(arg,isrecv)
	end
end

local send 
send = function(retry)

	local arg = ArgQueue.getHead()
	if arg ~= nil then
		local data = arg[1]
		local callback = arg[2]
		local errcallback = arg[3]
		local delay = arg[4]
		local timeout = arg[5]
		local ptype = arg[6]
		local flag = arg[7]

		timeout = timeout or 5 --默认超时5秒钟
		
		local shell_callback
		shell_callback = function ( data, errMsg )
			-- body
			recordTime(arg,true)

			local dataType = type(data)
			local closed = false
			if dataType == 'table' and callback then
				if DlogEnable then
					xpcall(function ( ... )
						callback(data)
					end,errorHandle)
				else
					callback(data)
				end
			elseif dataType == 'string' and data == 'error' then
				if type(errMsg)=="string" and (string.find(errMsg,'closed') or string.find(errMsg,'timeout')) then
					closed = true
				end
				
				if not closed and errcallback then
					errcallback(errMsg)
				else
					require 'Launcher'.netError(data,errMsg)
				end
			end
			--NetView
			if flag == nil or flag then
				Indicator.hide()
			end

			if not closed then
				ArgQueue.dequeue()
				send()
			end

		end
		
		--NetView
		if (flag == nil or flag) and retry then
			Indicator.show(delay)
		end

		recordTime(arg,false)

		-- 增加标记
		if retry then
			data.R = true
		end

		return client:send(data, shell_callback, timeout, ptype)
	end

end

local insertIStep =  function ( data )
	local netcheck = require 'GuideHelper':getNetCheck()
	if not netcheck or netcheck == data.C then
		local iStep,Des = require 'GuideHelper':getIStep()
		if iStep and not data.Ex then
			data.Ex = data.Ex or {}
			data.Ex.iStep = tostring(iStep)
			data.Ex.Des = Des
		end	
	end
end

function client.send0( data, callback, errcallback,delay,timeout, ptype,flag)
	
	insertIStep(data)

	local runing = ArgQueue.getHead()
	ArgQueue.enqueue({data,callback,errcallback,delay,timeout,ptype,flag})

	if flag == nil or flag then
		Indicator.show(delay)
	end
	
	if not runing then
		send()
	end

end

function client.sendRetry( )
	send(true)
end

function client.enableLogView( enable )
	DlogEnable = enable
end

return client