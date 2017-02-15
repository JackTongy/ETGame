
local Scheduler = {}

local sharedScheduler = CCDirector:sharedDirector():getScheduler()

function Scheduler.scheduleUpdateGlobal(listener)
    return sharedScheduler:scheduleScriptFunc(listener, 0, false)
end

function Scheduler.scheduleGlobal(listener, interval)
    return sharedScheduler:scheduleScriptFunc(listener, interval, false)
end

function Scheduler.unscheduleGlobal(handle)
    sharedScheduler:unscheduleScriptEntry(handle)
end

function Scheduler.performWithDelayGlobal(listener, time)
    local handle
    handle = sharedScheduler:scheduleScriptFunc(function()
        Scheduler.unscheduleGlobal(handle)
        listener()
    end, time, false)
    return handle
end

return require 'framework.basic.MetaHelper'.createShell(Scheduler)