local timerHelper = require "framework.sync.TimerHelper"

local timeManager = {}
local timeList = {}
local timeHandle = nil

local lastMs
local function getDeltaTime()
	local dt = 0
	if lastMs then
		local now = SystemHelper:currentTimeMillis()
		dt = (now - lastMs) / 1000
		lastMs = now
	else
		lastMs = SystemHelper:currentTimeMillis()
	end
	return dt
end

function timeManager.isRunning(  )
	return timeHandle
end

function timeManager.start(  )
	if not timeManager.isRunning() then
		lastMs = nil
		timeHandle = timerHelper.tick(function ( dt )
			dt = getDeltaTime()
			for i=#timeList,1, -1 do
				timeList[i].var = timeList[i].var - dt
				if timeList[i].callback then
					timeList[i].callback(timeList[i].var, timeList[i].data)
				end

				if timeList[i].var <= 0 then				
					table.remove(timeList, i)
				end
			end
		end)	
	end
	return timeHandle
end

function timeManager.stop(  )
	if timeManager.isRunning() then
		timeList = {}
		CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(timeHandle)
		timeHandle = nil
		lastMs = nil
	end
end

function timeManager.packageTimeStruct( id, var, callback, data )
	return {id = id, var = var, callback = callback, data = data}
end

function timeManager.addToTimeList( timeStruct )
	assert( timeStruct.id ~= nil )
	if timeStruct.var > 0 then
		timeManager.removeFromTimeList( timeStruct.id )
		table.insert(timeList, timeStruct)
		if not timeManager.isRunning() then
			timeManager.start()
		end
	end
	return timeStruct.var > 0
end

function timeManager.removeFromTimeList( id )
	for i,v in ipairs(timeList) do
		if v.id == id then
			table.remove(timeList, i)
			break
		end
	end
end

function timeManager.clear(  )
	timeList = {}
end

function timeManager.getTimeList( ... )
	return timeList
end

function timeManager.getTimestamp( timeString )
	-- Assuming timeString pattern like: yyyy-mm-dd hh:mm:ss
	return require 'TimeManager'.getTimestamp(timeString)
end

function timeManager.getTimeUpToNow( timeString )
	local curTimer = require "TimeManager".getCurrentSeverTime()  -- SystemHelper:currentTimeMillis() + adjust
	local timer = timeManager.getTimestamp(timeString)
	-- print("curTimer = " .. tostring(curTimer))
	-- print("time = " .. tostring(timer))
	-- print("timeString = " .. timeString)
	-- print("second = " .. tostring(curTimer / 1000 - timer))
	return curTimer / 1000 - timer
end

function timeManager.getTimeInfoBySeconds( seconds )
      local h = math.floor(seconds/3600)
      local m = math.floor(seconds%3600/60)
      local s = seconds - h*3600 - m*60
      return h,m,s
end

function timeManager.getOffsetTimeToNow( time )
	local curTimer = require "TimeManager".getCurrentSeverTime()
	-- time = time + os.time() - os.time(os.date("!*t"))
	return curTimer/1000 - time
end

return timeManager
