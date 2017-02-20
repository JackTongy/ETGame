local function __G__TRACKBACK__(msg)  
    print("----------------------------------------")  
    print("LUA ERROR: " .. tostring(msg) .. "\n")  
    print(debug.traceback())  
    print("----------------------------------------")  
end  

local function setPath()
    -- body
    local writablePath = FileHelper:getWritablePath()
    local bundlePath = FileHelper:getBundlePath()

    local function add_path(p)
        if writablePath ~= bundlePath and bundlePath ~= '' and bundlePath ~= nil then
            package.path = string.format('%s;%s/?.lua', package.path, bundlePath .. '/' .. p)
        else
             package.path = string.format('%s;%s/?.lua', package.path, writablePath .. '/' .. p)
        end
    end
    
    add_path('')
end

local function entry(pName)
    print(pName);
    return 0
end

local caller = LuaCaller:getInstance()
caller:checkIn("Entries", entry)
---------------------------

local function clean()
    print('*---------------------*')
    print('before clean, memory size = '..collectgarbage('count'))

    if not Original_G then
        Original_G = {}
        for i, v in pairs(_G) do
            Original_G[i] = v
        end
    else
        for i, v in pairs(_G) do
            if not Original_G[i] then
                _G[i] = nil
            else
                _G[i] = Original_G[i]
            end
        end
    end

    --script.config
    local ignoreMap = {
        ['script.Config']               = true,
        ['script.gvc.GVCMainServer']    = true,
        ['script.gvc.GVCTestServer']    = true,
        ['script.gvc.GVCUpdate']        = true,
        ['script.gvc.GVCHelper']        = true,
        ['script.info.Info']            = true,
        ['framework.basic.GleeCore']    = true,
    }

    for i,v in pairs(package.loaded) do
        -- script. framework.
        if string.sub(i,1,7) == 'script.' or string.sub(i,1,10) == 'framework.' then
            if not ignoreMap[i] then
                package.loaded[i] = nil
            end
        end
    end
    
    package.path = ''

    collectgarbage('collect')
    collectgarbage('collect')

    print('after clean, memory size = '..collectgarbage('count'))
    print('*---------------------*')
end


local function myInit(useUpdate)

    -- local netPackage = {}
    -- netPackage.C = 'TopBattle'
    -- netPackage.D = {}
    -- netPackage.D.Hurts = {}

    -- local id_array = { 2987, 34569, 99999, 10000, 777777, 88888, 22222,}
    
    -- local all = true
    -- for i=1, 7  do

    --     netPackage.D.Hurts[ id_array[i] ] = i*4

    -- end

    -- netPackage.D.Win = true
    -- netPackage.D.Skill = true
    -- netPackage.D.All = true

    -- local json_string = require 'framework.basic.Json'.encode(netPackage)
    -- print('---------json_string------')
    -- print(json_string)

    -- clean()
    -- FileHelper:setWritableRelativePath(NULL)
    -- local writablePath = FileHelper:getWritablePath()
    setPath()
    -- FileHelper:clearSearchPath()
    
    if useUpdate then
        local path = FileHelper:getWritablePath()
        require 'framework.sync.FileHelper'.ensureDir(path)
        FileHelper:addSearchPath(path)
    end
    
    -- require 'script.config.UpdateConfig'.GVC_Enable = useUpdate
    -- require 'framework.basic.Debug'
end

local function run( useUpdate )
    -- body
    xpcall(function ( ... )
        -- body
        myInit(useUpdate)
    end, __G__TRACKBACK__) 
end

return { run = run }
