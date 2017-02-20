--  
local FightTimer = require "FightTimer"
-- local TimeOutManager = require "TimeOutManager"

local TimeOutManager = {}   ---有的timeout
TimeOutManager._arr={}

TimeOut = class()

--- delayTime  秒
function TimeOut:ctor(delayTime,func)
	if delayTime ==nil  then
		delayTime=0 
	end

	self._delayTime = delayTime
	self._func = func 
end

-- delay   单位为秒
function TimeOut:addDelay( delay )
	self._delayTime  = self._delayTime +  delay
end

function TimeOut:updateIt( dt )
	self._delayTime = self._delayTime - dt

	if self._delayTime <= 0  then
		if self._func then
			self._func()
			self._func = nil
		end

		-- if self._updateFunc then
		-- 	FightTimer.removeFunc(self._updateFunc)
		-- 	self._updateFunc = nil
		-- end

		self._updateFunc = nil

		TimeOutManager.removeTimeOut(self)

		return true
	end
end


function TimeOut:start(  )
	self._updateFunc = FightTimer.addFunc(function ( dt )
		return self:updateIt( dt )
	end)
end

function TimeOut:dispose(  )
	if self._updateFunc then
		FightTimer.removeFunc(self._updateFunc)
		self._updateFunc = nil
	end
	TimeOutManager.removeTimeOut(self)
end



--单位为秒


-- 用来作统一的延时 处理  delayTime  秒
TimeOutManager.getTimeOut= function ( delayTime,func )
	assert(func)
	local timeOut = TimeOut.new(delayTime,func)
	TimeOutManager._arr[timeOut] = timeOut
	return timeOut
end

TimeOutManager.removeTimeOut =  function (timeOut )
	TimeOutManager._arr[timeOut] = nil
end

 --单位为秒
TimeOutManager.addDelay = function ( delay )
	for k,timeOut in pairs(TimeOutManager._arr) do
		timeOut:addDelay(delay)
	end
end

return  TimeOutManager



