local Utils 		= require 'framework.helper.Utils'
local MusicHelper 	= require 'framework.helper.MusicHelper'

local MusicSettings = {}
local self = Utils.readTableFromFile('MusicSettings') or { ['UISound'] = true,  ['Music'] = true, ['BattleVoice'] = true }

MusicSettings.setUISoundEnabled = function (enabled)
	-- body
	self['UISound'] = enabled
	MusicSettings.apply()
end

MusicSettings.getUISoundEnabled = function ()
	-- body
	return self['UISound']
end

MusicSettings.setMusicEnabled = function (enabled)
	-- body
	self['Music'] = enabled
	MusicSettings.flush()
end

MusicSettings.getMusicEnabled = function ()
	-- body
	return self['Music']
end

MusicSettings.setBattleVoiceEnabled = function (enabled)
	-- body
	self['BattleVoice'] = enabled
	MusicSettings.flush()
end

MusicSettings.getBattleVoiceEnabled = function ()
	-- body
	return self['BattleVoice']
end

MusicSettings.apply = function ( ... )
	-- body
	-- MusicHelper.setSoundPrefixFilter( 'raw/ui_', 		MusicSettings['ui_sound'] )
	-- MusicHelper.setMusicPrefixFilter( 'raw/ui_music_', 	MusicSettings['ui_music'] )
	-- MusicHelper.setSoundPrefixFilter( 'raw/dg_', 		MusicSettings['fb_sound'] )
	-- MusicHelper.setMusicPrefixFilter( 'raw/dg_music_', 	MusicSettings['fb_music'] )
	-- MusicHelper.setSoundPrefixFilter( 'raw/bt_', 		MusicSettings['bt_sound'] )
	-- MusicHelper.setMusicPrefixFilter( 'raw/bt_music_', 	MusicSettings['bt_music'] )

	-- if MusicSettings['ui_sound'] then
	-- 	ButtonNode:setDeaultSound(require 'Res'.Sound.pick)
	-- else
	-- 	ButtonNode:setDeaultSound( '' )
	-- end

	if self['Music'] then
		MusicFactory:setBackgroundMusicVolume(1)
	else
		MusicFactory:setBackgroundMusicVolume(0)
	end

	if self['UISound'] then
		MusicFactory:setEffectsVolume(1)
	else
		MusicFactory:setEffectsVolume(0)
	end
	
	ButtonNode:setDeaultSound(require 'Res'.Sound.pick)
end

MusicSettings.flush = function ()
	-- body
	MusicSettings.apply()

	Utils.writeTableToFile(self, 'MusicSettings')
end

MusicSettings.apply()

for i,effect in pairs(require 'Res'.Sound) do
	-- if effect
	-- require 'framework.helper.MusicHelper'.preloadEffect( effect )
end

for i,music in pairs(require 'Res'.Music) do
	-- if effect
	-- require 'framework.helper.MusicHelper'.preloadBackgroundMusic( music )
end
-- require 'framework.helper.MusicHelper'.preloadBackgroundMusic( 'raw/bt_music_battle.mp3' )

if require 'framework.basic.Device'.platform == "android" then
	local effectTable = require 'Dialogue_tomp3'
	local multiStepSoundMap = {}
	for i,v in ipairs(effectTable) do
		assert(v.sound)
		assert(v.time)
		multiStepSoundMap['raw/guide/'..v.sound] = v.time
	end
	MusicHelper.setMultiStepSoundMap(multiStepSoundMap)
end

return MusicSettings