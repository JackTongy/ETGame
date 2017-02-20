local Utils = require 'framework.helper.Utils'

local FightTimer = {}

local minStep = 1/60

local self = {}

self._updateList = {}

self._addList = {}

self._removeList = {}

self._speedRate = 1
self._reset = false

self._remain = 0

self._currentMills = 0

self._addressMap = {}

function FightTimer.isLocked()
	-- body
	return self._locked
end

function FightTimer.setLocked()
	-- body
	self._locked = true
end


function FightTimer.unLock()
	-- body
	self._locked = nil
end


function FightTimer.getFrameInterval()
	-- body
	return 1/30
end

function FightTimer.pause()
	-- body
	self._paused = true
end

function FightTimer.resume()
	-- body
	self._paused = nil
end

function FightTimer.setSpeedRate( speedRate )
	-- body
	self._speedRate = speedRate
end

function FightTimer.getSpeedRate(  )
	-- body
	return self._speedRate
end

function FightTimer.updatePreInterval(interval)
	-- body
	--暂停,忽略刷新

	if not self._paused then
		--check add
		self._currentMills = (self._currentMills + interval * 1000)

		if #self._addList > 0 then
			for i,v in ipairs(self._addList) do
				if not FightTimer.isInUpdateList(v) then
					table.insert(self._updateList, v)
				end
			end
			self._addList = {}
		end
		
		--check remove
		if #self._removeList > 0 then
			for i,v in ipairs(self._removeList) do
				for ii, vv in ipairs(self._updateList) do
					if v == vv then
						table.remove(self._updateList, ii)
						break
					end
				end
			end
			self._removeList = {}
		end

		FightTimer.setLocked()

		local timeMap = {}

		local tickoutList
		for i,v in ipairs(self._updateList) do

			local t1 = SystemHelper:currentTimeMillis()

			local ret = v( interval )

			local t2 = SystemHelper:currentTimeMillis()

			local t3 = (t2-t1)

			table.insert(timeMap, t3)

			if ret then
				tickoutList = tickoutList or {}
				table.insert(tickoutList, i)
			end
		end

		--static
		local allt = 0
		for i,v in ipairs(timeMap) do
			allt = allt + v
		end

		if allt > 100 then
			for i,v in ipairs(timeMap) do
				print('use mills = '..v)

				local funcKey = self._updateList[i]
				print(self._addressMap[funcKey])

				print('-------------------')
			end
		end

		if tickoutList then
			local tickoutSize = #tickoutList
			for i=tickoutSize,1,-1 do
				local index = tickoutList[i]

				self._addressMap[self._updateList[index]] = nil

				table.remove(self._updateList, index)

			end
		end

		-- print('Update Size = '..#self._updateList)

		FightTimer.unLock()
	end

end


function FightTimer.update( dt )
	-- body
	-- local prev = SystemHelper:currentTimeMillis()
	
	if self._reset then
		self._reset = false

		self._updateList = {}
		self._addList = {}
		self._removeList = {}
		-- self._delayList = {}

		return
	end

	-- local now = SystemHelper:currentTimeMillis()

	-- self._lastTimeMillis = self._lastTimeMillis or now

	-- self._remainTimeMillis = self._remainTimeMillis or 0

	--补上上一帧的残余
	-- local constDt = ((now - self._lastTimeMillis) * self._speedRate) + self._remainTimeMillis

	-- local dt = constDt / 1000

	-- local constDt = dt

	-- local interval = FightTimer.getFrameInterval() 

	--太长的帧的
	-- if dt > 100 then
	-- 	dt = math.fmod(dt, interval)
	-- end

	-- local time = 0

	-- while dt > interval/2 do
	-- 	dt = dt - interval
	-- 	FightTimer.updatePreInterval(interval)
	-- 	-- time = time + 1
	-- end

	-- while dt > 0.05 do
	-- 	FightTimer.updatePreInterval( 0.05 )
	-- 	dt = dt - 0.05
	-- end

	-- print('----------------------per frame----------------------')
	
	if dt > 0.2 then
		dt = minStep
	end
	self._remain = self._remain + dt

	-- if self._remain > 0.15 then
	-- 	print('remain = '..self._remain)
	-- 	SystemHelper:getPlatFormID()
	-- end

	while self._remain > minStep/2 do
		FightTimer.updatePreInterval( minStep )
		self._remain = self._remain - minStep
	end

	-- if self._remain > 0 then
	-- 	FightTimer.updatePreInterval( self._remain )
	-- 	self._remain = 0
	-- end
end

function FightTimer.isInUpdateList( func )
	-- body
	if func then
		for i,v in ipairs(self._updateList) do
			if v == func then
				return true
			end
		end

		-- for i,v in ipairs(self._addList) do
		-- 	if v == func then
		-- 		return true
		-- 	end
		-- end
	end

	return false
end

function FightTimer.addFunc( func )
	-- body

	if func then
		if FightTimer.isLocked() then
			-- assert(not FightTimer.isInUpdateList(func))
			table.insert(self._addList, func)
		else
			assert(not FightTimer.isInUpdateList(func))
			table.insert(self._updateList, func)
		end

		self._addressMap[func] = debug.traceback()
	end

	return func
end


function FightTimer.removeFunc( func )
	-- body
	if func then
		self._addressMap[func] = nil

		if FightTimer.isLocked() then
			table.insert(self._removeList, func)
			return 'delay remove'
		else
			for i,v in ipairs(self._updateList) do
				if v == func then
					table.remove(self._updateList, i)
					return 'remove'
				end
			end
		end
	end

	return 'not found'
end

function FightTimer.cancel( handle )
	-- body
	return FightTimer.removeFunc( handle )
end

function FightTimer.tick( func )
	-- body
	return FightTimer.addFunc(func)
end

function FightTimer.reset()
	-- body
	-- self._reset = true
	self._currentMills = 0
	self._updateList = {}
	self._addressMap = {}
	self._removeList = {}

	self._addressMap = {}
end

function FightTimer.currentFightTimeMillis()
	-- body
	return self._currentMills
end


function FightTimer.doUntilFinished( isFinished )
	-- body
	assert(isFinished)
	
	while not isFinished() do
		FightTimer.update( minStep )
	end
end


--FightTimer.currentFightTimeMillis

local TimerHelper = require 'framework.sync.TimerHelper'
self._mainHandle = TimerHelper.tick(FightTimer.update, 0)

return FightTimer
