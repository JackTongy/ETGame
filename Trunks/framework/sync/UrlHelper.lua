local timer = require 'framework.sync.TimerHelper'

local tick = timer.tick

local MAX_REQUEST = 32
local MIN_MAX_REQUEST = 32

local m = curl.multi_init()
local callback_table = {}
local callback_count = 0

local queued_request_count = 0
local queued_request = {}

local tick_clean_flag = false

local url_get

local tick_handle


local function start_tick()
	if not tick_handle then
		tick_handle = tick(function(dt)

			if tick_clean_flag then
				for e,v in pairs(callback_table) do
					m:remove_handle(e)
					--local callback = callback_table[e]
					--callback(nil)
				end

				callback_table = {}
 				callback_count = 0

 				-- for u,v in pairs(queued_request) do
 				-- 	local callback = queued_request[u]
					-- callback(nil)
 				-- end

 				queued_request_count = 0
 				queued_request = {}

 				tick_clean_flag = false

 				return
			end

			local to_be_remove = {}
			for url, data in pairs(queued_request) do
				if callback_count < MAX_REQUEST then
					-- local callback = 
					queued_request_count = queued_request_count - 1
					if url_get(url, data.callback, data.count, data.size, data.newUrl ) then
						table.insert(to_be_remove, url)
					end
				else
					break
				end
			end

			for i, url in pairs(to_be_remove) do
				queued_request[url] = nil
			end
			
			if callback_count > 0 then
				local t, running = m:perform()
				if t then
					local e, err, code = m:info_read()
					while e do
						local callback = callback_table[e]

						callback_table[e] = nil
						callback_count = callback_count - 1
						m:remove_handle(e)

						if code == 0 then
							local rescode = e:getinfo(curl.INFO_RESPONSE_CODE)
							if rescode == 200 then
								callback(true)
							else
								callback(nil, rescode)
							end
						else
							callback(nil, nil, err, code)
						end
						
						e, err, code = m:info_read()
					end
				end
			end
		end)
	end
end

url_getcookie = function(url, callback,cookie)
	print("url_get "..":"..url)
	--callcount = callcount or 0

	local e = curl.easy_init()
	e:setopt(curl.OPT_URL, url)
	e:setopt(curl.OPT_FOLLOWLOCATION,true)
	e:setopt(curl.OPT_COOKIE,cookie)

	local buf = {}
	e:setopt(curl.OPT_WRITEFUNCTION, function(var, data)
		table.insert(buf, data)
		return #data
	end)
	
	m:add_handle(e)
	callback_table[e] = function(suc, rescode, err, code)
		if suc then
			local content = table.concat(buf)
			print("succeed:"..url)
			callback(content)
		else
			print("failed:"..url)
			callback(nil, rescode, err, code)
		end
	end
	
	start_tick()
	
	return true
end

url_get = function(url0, callback,callcount, size, url1)
	callcount = callcount or 0

	local url = ( math.fmod(callcount,2) == 0 and url0) or (url1 or url0)

	-- print("url0 "..url0)
	-- print("url1 "..tostring(url1))
	-- print("size "..tostring(size))
	print("url_get "..callcount..":"..url)

	local timeout = 5 
	if size then
		local speed = 0.5 * 1024 / 8

		-- for i=1, math.floor(callcount/2) do
		-- 	speed = speed / 2
		-- end

		timeout = math.floor( math.max(0.5+size / speed, 5.5) ) --(0.5kB/s)
	end
	--callcount = callcount or 0

	if callback_count >= MAX_REQUEST then
		queued_request_count = queued_request_count + 1
		queued_request[url] = { callback = callback, count = callcount, size = size, newUrl = url1   }
		return false
	end

	local e = curl.easy_init()
	e:setopt(curl.OPT_URL, url)
	e:setopt(curl.OPT_TIMEOUT, timeout)

	local buf = {}
	e:setopt(curl.OPT_WRITEFUNCTION, function(var, data)
		table.insert(buf, data)
		return #data
	end)
	
	m:add_handle(e)
	callback_table[e] = function(suc, rescode, err, code)
		if suc then
			local content = table.concat(buf)
			print("succeed:"..url)
			callback(content)
		elseif tonumber(code) == 7 then
			MAX_REQUEST = MAX_REQUEST / 2
			if MAX_REQUEST < MIN_MAX_REQUEST then
				MAX_REQUEST = MIN_MAX_REQUEST
			end
			url_get(url0, callback, callcount, size, url1)
		elseif callcount < 16 then
			url_get(url0, callback, callcount+1, size, url1)
		else
			print("failed:"..url)
			callback(nil, rescode, err, code)
		end
	end
	callback_count = callback_count + 1
	
	start_tick()
	
	return true
end

local tick_clean
tick_clean = function ()
	-- body
	tick_clean_flag = true
	start_tick()

	-- for e,v in pairs(callback_table) do
	-- 	m:remove_handle(e)

	-- 	local callback = callback_table[e]
	-- 	callback(nil)
	-- end

	-- callback_table = {}
 	-- 	callback_count = 0

 -- 	for u,v in pairs(queued_request) do
 -- 		local callback = queued_request[u]
	-- 	callback(nil)
 -- 	end

 -- 	queued_request_count = 0
 -- 	queued_request = {}
end

local ret = {url_get = url_get, url_clean = tick_clean, tick_clean = tick_clean,url_getcookie=url_getcookie}

setmetatable(ret, { __gc = function ( tdata )
	-- body
	print('gc...')
	if tick_handle then
		for e,v in pairs(callback_table) do
			m:remove_handle(e)
		end

		callback_table = nil
 		callback_count = nil

 		queued_request_count = nil
 		queued_request = nil

 		timer.cancel(tick_handle)
 		tick_handle = nil

 		m = nil
 		print('url helper has been gc!')
 	else
 		print('no need to gc url helper!')
	end
	
end})

return ret