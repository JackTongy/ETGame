local MusicHelper = {}
local self = {}

self._musicFilter = {}
self._soundFilter = {}

--setEffectsVolume
--setBackgroundMusicVolume

 --    static void preloadBackgroundMusic(const char* pszFilePath);
 --    static void playBackgroundMusic(const char* pszFilePath, bool bLoop = false);
 --    static void stopBackgroundMusic(bool bReleaseData = false);
 --    static void pauseBackgroundMusic();
 --    static void resumeBackgroundMusic();
 --    static void rewindBackgroundMusic();
 --    static bool willPlayBackgroundMusic();
 --    static bool isBackgroundMusicPlaying();
 --    static float getBackgroundMusicVolume();
 --    static void setBackgroundMusicVolume(float volume);
 --    static float getEffectsVolume();
 --    static void setEffectsVolume(float volume);
 --    static unsigned int playEffect(const char* pszFilePath, bool bLoop = false);
 --    static void pauseEffect(unsigned int nSoundId);
 --    static void pauseAllEffects();
 --    static void resumeEffect(unsigned int nSoundId);
 --    static void resumeAllEffects();
 --    static void stopEffect(unsigned int nSoundId);
 --    static void stopAllEffects();
 --    static void preloadEffect(const char* pszFilePath);
 --    static void unloadEffect(const char* pszFilePath);
 --	   static const char * getBackgroundMusic();

local funcs = {
	'preloadBackgroundMusic',
	-- 'playBackgroundMusic',
	'stopBackgroundMusic',
	'pauseBackgroundMusic',
	'resumeBackgroundMusic',
	'rewindBackgroundMusic',
	'willPlayBackgroundMusic',
	'isBackgroundMusicPlaying',
	'getBackgroundMusicVolume',
	'setBackgroundMusicVolume',
	'getEffectsVolume',
	'setEffectsVolume',
	-- 'playEffect',
	'pauseEffect',
	'pauseAllEffects',
	'resumeEffect',
	'resumeAllEffects',
	'stopEffect',
	'stopAllEffects',
	'preloadEffect',
	'unloadEffect',
	'getBackgroundMusic',
}

local Raw_Funcs_Map = {}
for i, func in ipairs(funcs) do
	Raw_Funcs_Map[func] = MusicFactory[func]
end

for i,func in ipairs(funcs) do
	MusicHelper[func] = function ( ... )
		-- body
		return Raw_Funcs_Map[func](MusicFactory, ...)
	end
end

-- 拦截的map
-- string -> { step1, step2, step3 }
local MultiStepSoundMap = {}
local WillPlayHandleArr = {}

local function getFullName( pszFilePath, index )
	-- body
	assert(pszFilePath, pszFilePath)
	assert(index, index)

	local len = #pszFilePath
	local fullname = string.sub(pszFilePath, 1, len-4)..'_0'..(index-1)..string.sub(pszFilePath, len-3, len)
	print('FullName:'..fullname)
	return fullname
end

-- table
MusicHelper.setMultiStepSoundMap = function ( map )
	-- body
	assert(map)

	-- MultiStepSoundMap = {}
	-- for i,v in ipairs(map) do
	-- 	assert(v.sound)
	-- 	assert(v.time)
	-- 	MultiStepSoundMap['raw/guide/'..v.sound] = v.time
	-- end

	MultiStepSoundMap = map 
end

MusicHelper.playEffect = function(pszFilePath, loop)
	if not MusicHelper.isSoundFilter(pszFilePath) then

		-- ru
		local stepArr = MultiStepSoundMap and MultiStepSoundMap[pszFilePath]
		if stepArr then
			local TimerHelper = require 'framework.sync.TimerHelper'

			local delay = 0
			for i=2, #stepArr do
				delay = delay + stepArr[i-1]
				local index = i
				local id 
				id = TimerHelper.tick(function ()
					-- body
					MusicFactory:playEffect(getFullName(pszFilePath, index), false)
					WillPlayHandleArr[index] = nil
					return true
				end, delay)

				WillPlayHandleArr[index] = id
			end

			return MusicFactory:playEffect(getFullName(pszFilePath, 1), false)
		end

		return MusicFactory:playEffect(pszFilePath, loop)
	end
end

local function stopWillEffect()
	-- body
	for i=1, 10 do
		local id = WillPlayHandleArr[i]
		if id then
			local TimerHelper = require 'framework.sync.TimerHelper'
			TimerHelper.cancel(id)

			WillPlayHandleArr[i] = nil
		end
	end
end

MusicHelper.stopAllEffects = function ()
	-- body
	stopWillEffect()

	MusicFactory:stopAllEffects()
end

MusicHelper.stopEffect = function ( ... )
	-- body
	stopWillEffect()

	MusicFactory:stopEffect(...)
end

MusicHelper.setSoundPrefixFilter = function ( prefix, enable )
	-- body
	assert(type(prefix) == 'string')
	self._soundFilter[prefix] = enable
end

MusicHelper.setMusicPrefixFilter = function ( prefix, enable )
	-- body
	assert(type(prefix) == 'string')
	self._musicFilter[prefix] = enable
end

MusicHelper.isSoundFilter = function ( sound )
	-- body
	for prefix, enable in pairs(self._soundFilter) do
		if enable then
			local sub = string.sub(sound, 1, #prefix)
			if sub == prefix then
				return true
			end
		end
	end
end

MusicHelper.isMusicFilter = function ( music )
	-- body
	for prefix, enable in pairs(self._musicFilter) do
		if enable then
			local sub = string.sub(music, 1, #prefix)
			if sub == prefix then
				return true
			end
		end
	end
end

local _currentMusic = nil
MusicHelper.playBackgroundMusic = function ( music, loop, rest )
	if rest then
		_currentMusic = music
		MusicFactory:playBackgroundMusic( music, loop )
	else
		if music ~= _currentMusic then
			_currentMusic = music
			MusicFactory:playBackgroundMusic( music, loop )
		end
	end
end



-- MusicHelper.playBackgroundMusic = function ( music, loop )
-- 	-- body
-- 	-- print('playBackgroundMusicXXXX '..music)
-- 	if not MusicHelper.isMusicFilter(music) then
-- 		print(string.format('music %s could play!', music))
-- 
-- 		if MusicFactory:isBackgroundMusicPlaying() then
-- 			if self._currentMusic ~= music then
-- 				self._currentMusic = music
-- 				MusicFactory:playBackgroundMusic( music, loop )
-- 				-- print('playBackgroundMusic1 '..music)
-- 			else
-- 				-- print('playBackgroundMusic0 '..music)
-- 			end
-- 		else
-- 			if self._currentMusic ~= music then
-- 				self._currentMusic = music
-- 				MusicFactory:playBackgroundMusic( music, loop )
-- 				-- print('playBackgroundMusic2 '..music)
-- 			else
-- 				MusicFactory:resumeBackgroundMusic()
-- 				-- print('playBackgroundMusic13 '..music)
-- 			end 
-- 		end
-- 	else
-- 		print(string.format('music %s could not play!', music))
-- 		-- self._currentMusic = music
-- 		-- MusicFactory:pauseBackgroundMusic()
-- 		if MusicFactory:isBackgroundMusicPlaying() then
-- 			MusicFactory:stopBackgroundMusic()
-- 		end
-- 		-- print('playBackgroundMusic4 '..music)
-- 	end
-- end
-- 
-- MusicHelper.stopBackgroundMusic = function ()
-- 	-- body
-- 	self._currentMusic = nil
-- 	MusicFactory:stopBackgroundMusic()
-- end
-- 
-- MusicHelper.playEffect = function ( effect, loop )
-- 	-- body
-- 	if not MusicHelper.isSoundFilter(effect) then
-- 		print(string.format('effect %s could play!', effect))
-- 		return MusicFactory:playEffect(effect, loop)
-- 	else
-- 		print(string.format('effect %s could not play!', effect))
-- 		print(self._soundFilter)
-- 	end
-- end
-- 
-- MusicFactory.playBackgroundMusic = function ( self, music, loop)
-- 	-- body
-- 	return MusicHelper.playBackgroundMusic(music, loop)
-- end
-- 
-- MusicFactory.playEffect = function ( self, effect, loop )
-- 	-- body
-- 	return MusicHelper.playEffect(effect, loop)
-- end

return MusicHelper