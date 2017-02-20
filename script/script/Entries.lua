local function __G__TRACKBACK__(msg)  
    print("----------------------------------------")  
    print("LUA ERROR: " .. tostring(msg) .. "\n")  
    print(debug.traceback())  
    print("----------------------------------------")  
end  

local function Entry()
    -- add
    CCDirector:sharedDirector():setDisplayStats(false)
    GleeControllerManager:getInstance():lowMemoryDevice(true)

    require 'script.adapter.Adapter'.adapt()

    CCFileUtils:sharedFileUtils():purgeCachedEntries()
    FileHelper:clearSearchPath()
    FileHelper:setWritableRelativePath(NULL)

    local mainWritablePath = FileHelper:getWritablePath()
    print(mainWritablePath)
    local writablePath = mainWritablePath
    local bundlePath = FileHelper:getBundlePath()

    package.path = ''
    if writablePath ~= bundlePath and bundlePath ~= '' and bundlePath ~= nil then
        -- package.path = string.format('%s;%s/?.lua', package.path, bundlePath)
    else
        FileHelper:addSearchPath( writablePath )
        -- package.path = string.format('%s;%s/?.lua', package.path, writablePath)
    end
    
    package.loaded['script.FirstScene'] = nil

    require 'script.T'
    -- print('------------load--------')
    -- for i,v in pairs(package.loaded) do
    --     print(i)
    -- end

    package.loaded['script.T'] = nil

    --[[
    update
    login
    develop
    --]]
    local data = require 'script.info.Info'
    local runMode = data.MODE
    local basicVersion = data.UPDATE_VERSION
    if data.LANG_NAME == 'Arabic' then
        XMLFactory:setReverseChildrenEnable(true)
        -- if LabelNode.setFontSizeScale then
        --     LabelNode:setFontSizeScale(0.8)
        -- end
    end
    --localize
    FileHelper:addSearchPath(require 'script.info.Info'.RESPATH..'/')
    LanguageManager:getInstance():setLanguageMap("language/Localizable_cn.plist")
    ------

    require 'script.FirstScene'.run(runMode, basicVersion)
end

xpcall(Entry, __G__TRACKBACK__) 
