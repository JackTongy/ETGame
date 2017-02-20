local EventCenter 			= require 'EventCenter'
local FightEvent 			= require 'FightEvent'
local FightTimer 			= require 'FightTimer'
local Default 				= require 'Default'

local TimerView = class( require 'BasicView' )

function TimerView:ctor( luaset, document )
	-- body
	self._luaset = luaset
	EventCenter.addEventFunc(FightEvent.StartTimer, function ( seconds )
		if seconds <= 0 then
			return false
		end

		self:startHandler( seconds )
	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.StopTimer, function ()
		-- body
		self:stopHandler()
	end, 'Fight')
	
	EventCenter.addEventFunc(FightEvent.StartGuiderTimer, function ()
		-- body
		if Default.Debug.state then
			self:startGuiderHandler()
		end
	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_FirstFight, function ()
		-- body
		if Default.Debug.state then
			self:startGuiderHandler()
		end
	end, 'Fight')
	
end

function TimerView:startGuiderHandler()
	-- body
	-- assert(not self._handler)
	if self._handler then
		FightTimer.cancel(self._handler)
		self._handler = nil
	end 

	if tolua.isnull(self._luaset['layer_timer']) then
		return false
	end
	
	self._luaset['layer_timer']:setVisible(true)
	
	self._countTime = 0
	self._handler = FightTimer.addFunc(function ( dt )
		-- body
		if tolua.isnull(self._luaset['layer_timer']) then
			return true
		end
		
		self._countTime = self._countTime + dt
		
		
		local time = string.format('%.2f', self._countTime)
		self._luaset['layer_timer']:setString(''..time..'s')
	end)
end

function TimerView:startHandler( seconds )
	-- body
	-- assert(not self._handler)
	if self._handler then
		FightTimer.cancel(self._handler)
		self._handler = nil
	end 

	if tolua.isnull(self._luaset['layer_timer']) then
		return false
	end
	
	self._luaset['layer_timer']:setVisible(true)
	
	self._countTime = 0
	self._handler = FightTimer.addFunc(function ( dt )
		-- body
		if tolua.isnull(self._luaset['layer_timer']) then
			return true
		end
		
		self._countTime = self._countTime + dt
		
		local time = math.floor(math.max(seconds - self._countTime + 0.5, 0))
		-- self._luaset['layer_timer']:setString(''..time..'s')

		local min = math.floor(1/120 + time/60)
		local sed = time - min * 60

		local min0 = math.floor(min/10)
		local min1 = min - min0*10

		local sed0 = math.floor(sed/10)
		local sed1 = sed - sed0*10

		self._luaset['uiLayer_lt_clock_llayout_n1']:setResid( string.format('ZD_ZSJ_%d.png', min0) )
		self._luaset['uiLayer_lt_clock_llayout_n2']:setResid( string.format('ZD_ZSJ_%d.png', min1) )
		self._luaset['uiLayer_lt_clock_llayout_n3']:setResid( 'ZD_ZSJ_MH.png' )
		self._luaset['uiLayer_lt_clock_llayout_n4']:setResid( string.format('ZD_ZSJ_%d.png', sed0) )
		self._luaset['uiLayer_lt_clock_llayout_n5']:setResid( string.format('ZD_ZSJ_%d.png', sed1) )
		
	end)
end

function TimerView:stopHandler()
	-- body
	if self._handler then
		FightTimer.removeFunc(self._handler)
		self._handler = nil
	end
end

return TimerView