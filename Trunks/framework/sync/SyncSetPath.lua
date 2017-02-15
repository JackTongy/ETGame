local function clean()
    print('*---------------------*')
    print('before clean, memory size = '..collectgarbage('count'))

    -- if not Original_G then
    --     Original_G = {}
    --     for i, v in pairs(_G) do
    --         Original_G[i] = v
    --     end
    -- else
    --     for i, v in pairs(_G) do
    --         if not Original_G[i] then
    --             _G[i] = nil
    --         else
    --             _G[i] = Original_G[i]
    --         end
    --     end
    -- end

    --script.config
    local ignoreMap = {
        ['script.Config']               = true,
        ['script.gvc.GVCMainServer']    = true,
        ['script.gvc.GVCTestServer']    = true,
        ['script.gvc.GVCPublish']       = true,
        ['script.gvc.GVCUpdate']        = true,
        ['script.gvc.GVCHelper']        = true,
        ['framework.basic.GleeCore']    = true,
    }

    for i,v in pairs(package.loaded) do
        -- script. framework.
        if string.sub(i,1,7) == 'script.' or string.sub(i,1,10) == 'framework.' then
            if not ignoreMap[i] then
                -- package.loaded[i] = nil
            end
        end
    end
    
    package.path = ''

    collectgarbage('collect')
    collectgarbage('collect')

    -- 检测全局 ???
    print('after clean, memory size = '..collectgarbage('count'))
    print('*---------------------*')
end

local function init( moduleArray )
	-- body
    clean()
    
	SystemHelper:initRandom(SystemHelper:currentTimeMillis())

	moduleArray = moduleArray or {}

	package.path = ''

	local function addLuaSearchPath( path )
		-- if package.path == '' then
		-- 	package.path = string.format('%s/?.lua', path)
		-- else 
		-- 	package.path = string.format('%s/?.lua;%s', path, package.path)
		-- end
	end

	local bundlePath = FileHelper:getBundlePath()
	if bundlePath and bundlePath ~= '' then
		addLuaSearchPath(bundlePath)
	else
		FileHelper:clearSearchPath()
    	FileHelper:setWritableRelativePath(NULL)
    	
    	local mainWritablePath = FileHelper:getWritablePath()
    	print('mainWritablePath = '..mainWritablePath )
		FileHelper:addSearchPath( mainWritablePath )
		addLuaSearchPath( mainWritablePath )
	end

	for i, smodule in ipairs(moduleArray) do
		local dirPath = smodule.getLocalDir()
		
		FileHelper:setWritableRelativePath( dirPath )
		local myWritablePath = FileHelper:getWritablePath()
		FileHelper:addSearchPath( myWritablePath )
		addLuaSearchPath(myWritablePath)
        
		print(string.format('Path-%d:%s', i, myWritablePath))
	end

	CCFileUtils:sharedFileUtils():purgeCachedEntries()
	CCTextureCache:purgeSharedTextureCache()
	CCSpriteFrameCache:purgeSharedSpriteFrameCache()
	
end

return { init = init }
