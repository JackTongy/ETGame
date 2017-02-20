local Config = require 'Config'
local Global = require 'Global'
local EventCenter = require 'EventCenter'
local FightEvent = require 'FightEvent'
local Swf = require 'framework.swf.Swf'



local TipView = class(require 'BasicView')

function TipView:ctor( luaset, document )
	-- body
	self._luaset = luaset
	self._document = document

	-- print('TipView!!!!!')

	self._luaset['layer_bossWarning']:setVisible(false)

	EventCenter.addEventFunc(FightEvent.Pve_MonsterWarning, function ( data )
		-- body
		-- print('Pve_MonsterWarning')
		-- print(data)
		self:showMonsterWarning( data.enterposition )
		
	end , 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_BossWarning, function ( data )
		-- body
		-- require 'framework.helper.MusicHelper'.playBackgroundMusic('raw/bt_music_boss.mp3', true)
		require 'framework.helper.MusicHelper'.playBackgroundMusic(require 'Res'.Music.boss, true)

		if require 'ServerRecord'.getMode() ~= 'guider' then
			local myswf = Swf.new('Swf_boss')
			local myswfNode = myswf:getRootNode()
			myswf:play(nil,nil,function ()
				-- body
				myswfNode:removeFromParent()
			end)
			self._luaset['layer']:addChild(myswfNode)

			self:showMonsterWarning( data.enterposition )
			
			if not tolua.isnull(self._luaset['layer_bossWarning']) then
				self._luaset['layer_bossWarning']:runElfAction( self._luaset['ActionBossWarning']:clone() )
				self._luaset['layer_bossWarning_bg']:runElfAction( self._luaset['ActionBossWarning']:clone() )
				self._luaset['layer_bossWarning_bg0']:runElfAction( self._luaset['ActionBossWarning']:clone() )
				self._luaset['layer_bossWarning_bg1']:runElfAction( self._luaset['ActionBossWarning']:clone() )
				self._luaset['layer_bossWarning_bg2']:runElfAction( self._luaset['ActionBossWarning']:clone() )
			end
		end

	end , 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_AirLandWarning, function ( targetPos )
		-- body
		self:showAirLandWarning( targetPos )
	end , 'Fight')

end

function TipView:showAirLandWarning( targetPos )
	-- body
	-- assert(false)

	local warning_luaset = self:createLuaSet(self._document, '@warning')
	local action = self._luaset['ActionShowWarning']:clone()

	self._luaset['layer_specialLayer']:addChild(warning_luaset[1])
	warning_luaset[1]:setPosition(ccp(targetPos.x, targetPos.y+100))
	-- warning_luaset[1]:setScale(2)

	action:setListener(function ()
		-- body
		warning_luaset[1]:removeFromParent()
	end)

	warning_luaset[1]:runElfAction(action)
end

function TipView:showMonsterWarning(enterposition)
	-- body
	local index = 2 - (enterposition - 1)

	if index >=0 and index <= 2 then
		-- assert(index >= 0 and index <= 2)
		if not tolua.isnull(self._luaset['layer_bgLayer_warning'..index]) then
			local action = self._luaset['ActionShowWarning']:clone()
			self._luaset['layer_bgLayer_warning'..index]:runElfAction(action)
		end

	end
end

return TipView