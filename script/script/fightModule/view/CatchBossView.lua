local EventCenter 			= require 'EventCenter'
local FightEvent 			= require 'FightEvent'
local Res 					= require 'Res'
local FightTimer 			= require 'FightTimer'
local FightConfig			= require 'FightConfig'
local FightSettings 		= require 'FightSettings'
local UIHelper 				= require 'UIHelper'

local CatchBossView = class(require 'BasicView')

function CatchBossView:ctor(luaset, document)
	-- body
	self._luaset 	= luaset
	self._document 	= document

	self._catchBossplayed = false

	self:initEvents()
end

function CatchBossView:initEvents()
	-- body
	EventCenter.addEventFunc(FightEvent.Pve_ShowCatchBoss, function ( data )
		-- body
		if require 'ServerRecord'.getBossCatchFlag() then
			if not self._catchBossPlayed then
				self._catchBossPlayed = true

				local pos = data.pos
				self:showCatchBoss(pos)
			end
		end

	end, 'Fight')
end


function CatchBossView:showCatchBoss( pos )
	-- body

	assert(pos)

	local catchBossLuaset = self:createLuaSet(self._document, '@CatchBoss')
	pos.x = math.min(pos.x, 1136/2-200 )
	pos.x = math.max(pos.x, -(1136/2-200))

	catchBossLuaset[1]:setPosition( ccp(pos.x, pos.y) )

	catchBossLuaset[1]:getModifierControllerByName('swf'):setLoops(1)
	catchBossLuaset[1]:getModifierControllerByName('swf'):setLoopMode(STAY)
	catchBossLuaset[1]:play('swf')

	--49/17 == 2.8
	catchBossLuaset[1]:setScaleX( require 'RoleSelfManager'.getFlipX() )
	
	require 'LayerManager'.roleLayer:addChild( catchBossLuaset[1] )
end



return CatchBossView
