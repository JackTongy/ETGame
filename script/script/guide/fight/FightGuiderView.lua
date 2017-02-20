local EventCenter 			= require 'EventCenter'
local FightEvent 			= require 'FightEvent'
local Res 					= require 'Res'
local FightTimer 			= require 'FightTimer'
local FightConfig			= require 'FightConfig'
local FightSettings 		= require 'FightSettings'
local UIHelper 				= require 'UIHelper'

local FightGuiderView = class(require 'BasicView')

function FightGuiderView:ctor(luaset, document)
	-- body
	self._luaset 	= luaset
	self._document 	= document

	self:initEvents()
end

function FightGuiderView:initEvents()
	-- body
	EventCenter.addEventFunc(FightEvent.Pve_FightGuiderEnable, function ( data )
		-- body
		if data then
			self._luaset['topLayer']:setVisible(true)
			self._luaset['layer_touchLayer']:setTouchEnable(false)
		else
			self._luaset['topLayer']:setVisible(false)
			self._luaset['layer_touchLayer']:setTouchEnable(true)
		end
		
	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Guider_TouchAnyWay, function ( data )
		-- body
		if data then
			self._luaset['topLayer_shield']:setVisible(false)
			self._luaset['layer_touchLayer']:setTouchEnable(true)
		else
			self._luaset['topLayer_shield']:setVisible(true)
			self._luaset['layer_touchLayer']:setTouchEnable(false)
		end
	end, 'Fight')
end

return FightGuiderView