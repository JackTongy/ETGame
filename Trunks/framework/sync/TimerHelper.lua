--print("time_helper!!!!!")

local function tick(func, tv)
	tv = tv or 0
	local handle
	handle = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(function(dt)
		local ret = func(dt)
		if ret then
			CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(handle)
		end
	end, tv, false)
	return handle
end

local function timeout(func, tv)
	tv = tv or 0
	local handle
	handle = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(function(dt)
		func(dt)
		CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(handle)
	end, tv, false)
	return handle
end

local function cancel(handle)
	if handle then
		CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(handle)
	end
end

local function countTick(func, times)
	-- body
	times = times or 1
	local handle
	handle = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(function(dt)
		times = times - 1
		if times<=0 then
			func()
			CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(handle)
		end
	end, 0, false)
	return handle
end

return {tick = tick, timeout = timeout, cancel = cancel, countTick = countTick}

