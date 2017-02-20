local client = require 'SocketClientPvp'
local utils = require 'framework.helper.Utils'

local RAW_SystemHelper_currentTimeMillis = SystemHelper.currentTimeMillis

local Current = function ()
	-- body
	return RAW_SystemHelper_currentTimeMillis(SystemHelper)
end

-- SystemHelper.currentTimeMillis = function ( self,... )
-- 	-- body
-- 	print(debug.traceback())
-- 	return Current()
-- end

local timeManager = {}

-- SystemHelper.currentTimeMillis = function ( self )
-- 	-- body
-- 	-- local t = os.clock()
-- 	-- print('t='..t)
-- 	-- return t * 1000
-- 	return timeManager.getCurrentSeverTime()
-- end

function timeManager.setLoginSeverTime( serveLoginTime )
	-- timeManager._serveLoginTime=serveLoginTime
	-- timeManager._clientLoginTime=SystemHelper:currentTimeMillis()
	-- timeManager._adjust2ServerTime = serveLoginTime - SystemHelper:currentTimeMillis()
	timeManager._adjust2ServerTime = math.floor( serveLoginTime - Current() )
end


function timeManager.setAdjust2ServerTime( adjust2ServerTime )
	-- body
	timeManager._adjust2ServerTime = math.floor( adjust2ServerTime )
end

--获取服务端的时间
function timeManager.getCurrentSeverTime(  )
	-- print("timeManager._adjust2ServerTime="..timeManager._adjust2ServerTime)
	--return (SystemHelper:currentTimeMillis() + timeManager._adjust2ServerTime)
	return Current() + (timeManager._adjust2ServerTime or 0)
end

function timeManager.getCurrentSeverTimeByOs(  )
	-- assert(timeManager._adjust2ServerTime)
	-- print("timeManager._adjust2ServerTime="..timeManager._adjust2ServerTime)
	--return (SystemHelper:currentTimeMillis()+ timeManager._adjust2ServerTime)
	return Current() + (timeManager._adjust2ServerTime or 0)
end

function timeManager.serverTimeAdjust( socket )
	-- body
	local timeout = 1000*3600

	local last = Current() --SystemHelper:currentTimeMillis() 
	print("serverTimeAdjust")
	-- debug.catch(true)
	local now = Current() --SystemHelper:currentTimeMillis()

	socket.send0({ C='Ping', M = 1 }, function ( netdata )
		-- print(netdata)
		-- body
		local lasttimeout = timeout
		local currtimeout = (now - last)/2

		if currtimeout < lasttimeout then
			timeout = currtimeout

			local adjust = netdata.D.T+timeout - now

			print('last='..last)
			print('serv='..netdata.D.T)
			print('now ='..now)
			print('timeout='..timeout)
			print('adjust='..adjust)
			
			-- print('set timeout:'..timeout)
			-- print("netdata.D.T="..netdata.D.T)
			-- print("last="..last)
			timeManager.setAdjust2ServerTime( adjust )

			print('-----------Adjust 2 Server Time---------')
			print('min timeout:'..timeout)
			print('----------------------------------------')
		end
		
	end)
end

--获取0时区 timeString对应的时间值
function timeManager.getTimestamp( timeString )
	local convertedTimestamp = timeManager.getTimestampLocal(timeString)
	-- print(timeString .. "[timestamp] is " .. tostring(convertedTimestamp))	
	local offset = (os.time() - os.time(os.date("!*t")))
	return convertedTimestamp + offset
end

--获取当前时区 timeString对应的时间值
function timeManager.getTimestampLocal( timeString )
	-- Assuming timeString pattern like: yyyy-mm-dd hh:mm:ss
	local pattern = "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)"
	local runyear, runmonth, runday, runhour, runminute, runseconds = string.match(timeString, pattern)
	local timeTable = {year = runyear, month = runmonth, day = runday, hour = runhour, min = runminute, sec = runseconds,isdst=false}
	local convertedTimestamp = os.time(timeTable)
	return convertedTimestamp
end

--判断当前时间是否处于 0时区时间点from to之间
function timeManager.currtimeIn(from,to)

  local servertime = timeManager.getCurrentSeverTime()/1000
  local fromtime = timeManager.getTimestamp(from)
  local endtime = timeManager.getTimestamp(to)

  return(fromtime <= servertime and endtime >= servertime)

end

--计算当前0时区时间 与 指定0时区时间点(from) 之间的差值
function timeManager.timeOffset(from)

	local servertime = timeManager.getCurrentSeverTime()/1000
	local fromtime = timeManager.getTimestamp(from)
	
	return (servertime - fromtime)

end

--将服务器给的0时区时间 转换为本地显示时间
function timeManager.getDateTimeLocal( serverdatetime,stimestamp )
	local timestamp = (stimestamp and stimestamp) or timeManager.getTimestamp(serverdatetime)
	return os.date('%Y-%m-%d %X',timestamp)
end

function timeManager.getCurrentSeverDate( ... )
	local stamp = math.floor(timeManager.getCurrentSeverTime() / 1000 - (os.time() - os.time(os.date("!*t"))) )
	stamp = stamp + require 'AccountInfo'.getCurrentServerUTCOffset()
	local date = os.date("*t", stamp)
	if date.isdst then
		date = os.date("*t", math.max(stamp - 3600, 0))
		date.isdst = false
	end
	return date
end

function timeManager.getCurrentSeverDateWithDst( ... )
	local stamp = math.floor(timeManager.getCurrentSeverTime() / 1000 - (os.time() - os.time(os.date("!*t"))) )
	stamp = stamp + require 'AccountInfo'.getCurrentServerUTCOffset()
	local date = os.date("*t", stamp)
	return date
end

return timeManager

