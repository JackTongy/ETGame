
local function init()
	-- body
	
	print('SetPath init')
	--localize
	local respath = require 'script.info.Info'.RESPATH
	FileHelper:addSearchPath(respath and (respath..'/') or 'Local/thai/');
	local path = FileHelper:getWritablePath()
    if path then
    	if (string.sub(path,-string.len('advanced/')) == 'advanced/') then
    		path = string.gsub(path,'advanced','main')
    	end

    	if not (string.sub(path,-string.len('main/')) == 'main/') then
    		path = path..'main/'
    	end
    	path = path..(respath or 'Local/thai')
    	require 'framework.sync.FileHelper'.ensureDir(path)
    	FileHelper:addSearchPath(path)
    end
    ------

	print('SetPath init from:')
	print(debug.traceback())

	package.loaded['script.Config'] = nil
	-- package.loaded['script.info.Info'] = nil

	--fix bug
	local FileHelper = require 'framework.sync.FileHelper'
	if not FileHelper.HasFixed then
		local removeFunc = FileHelper.remove

		FileHelper.remove = function ( filepath )
			-- body
			if filepath == nil or filepath == '' then
				return nil
			end

			return removeFunc(filepath)
		end

		FileHelper.HasFixed = true
	end

	SystemHelper:initRandom(SystemHelper:currentTimeMillis())
	CCTextureCache:purgeSharedTextureCache()
	CCSpriteFrameCache:purgeSharedSpriteFrameCache()
	CCFileUtils:sharedFileUtils():purgeCachedEntries()
	FontManager:getInstance():setFontMap("config/FontMap.plist");
	LanguageManager:getInstance():setLanguageMap("language/Localizable_cn.plist");
	

	package.loaded['script.RequireMap'] = nil
	local RequireMap = require 'script.RequireMap'
	local Debug = require 'framework.basic.Debug'
	Debug.setRequireMap(RequireMap)
	--RequireMap
	require 'Default'
	---------------------------load things-----------------
	require 'LoadThings'
end

return { init = init }



