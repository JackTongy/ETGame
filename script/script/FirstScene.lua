------------------------------------define local class------------------------------------
local _class = {}
local function class(super)
    local class_type = {}

    local vtbl={}
    _class[class_type]=vtbl
    
    local mymetatable = { __index = vtbl }
    
    class_type.ctor = false
    class_type.super = super
    class_type.new = function(...)
        local obj={}
        
        setmetatable(obj, mymetatable )
        
        do
            local create
            create = function(c,...)
                if c.super then
                    create(c.super,...)
                end
                
                if c.ctor then
                    c.ctor(obj,...)
                end
            end

            create(class_type,...)
        end

        return obj
    end
    
    setmetatable(class_type,{ __newindex=
        function(t,k,v)
            vtbl[k]=v
        end
    })
    
    if super then
        setmetatable(vtbl,{__index=
            function(t,k)
                local ret=_class[super][k]
                vtbl[k]=ret
                return ret
            end
        })
    end

    return class_type
end

------------------------------------define local SimpleLuaInterface------------------------------------
local SimpleLuaInterface = class()

function SimpleLuaInterface:assignXML()
    -- body
    local factory = XMLFactory:getInstance()
    self._factory = factory
    
    self._document = self:createDocument()
    self._set = factory:createWithElement(factory:getRootElement(self._document))

    self:setLayer(self._set:getRootElfLayer())

    self:onInitXML()

    self:retainMembers()
end

function SimpleLuaInterface:getLayer()
    -- body
    return self._layer
end

function SimpleLuaInterface:loadXML()
    -- body
    self:assignXML()
end

------------------------------------define local SimpleLuaController------------------------------------
local SimpleLuaController = class(SimpleLuaInterface)

function SimpleLuaController:setLayer( layer )
    self._layer = layer
    local target = self:getTarget()
    if target then
        target:setLayer(layer)
    else
        target = self:createTarget()
        target:setLayer(layer)
    end
end

function SimpleLuaController:createTarget()
    assert(self:getTarget() == nil , 'LuaController already has a target!')

    local target = GleeController:create()
    target:setControllerName('GVCUpdate')
    self:setTarget(target)

    target:registerScriptHandler(function( state, enable )
        self:onState(state, enable)
    end)

    return target
end

function SimpleLuaController:retainMembers()
    -- body
    self._document:retain()
    self._set:retain()
    self._controller:retain()
end

function SimpleLuaController:releaseMembers()
    -- body
    if self._document then
        self._document:release()
        self._document = nil
    end

    if self._set then
        self._set:release()
        self._set = nil
    end

    if self._controller then
        self._controller:release()
        self._controller = nil
    end
end

function SimpleLuaController:setTarget(target)
    -- body
    self._controller = target
end

function SimpleLuaController:getTarget()
    -- body
    return self._controller
end

--[[
notice:　it will be error if isKeepAlive return false
         the reason is that controllermanager will release the layer of this controller when it onLeave
--]]
function SimpleLuaController:onState(state, enable)
    if state == tOnInit then
        self:onInit( self:getUserData(), nil )
    elseif state == tOnRelease then
        self:releaseMembers()
    end
    return true
end 


function SimpleLuaController:registerEventLC(event,func)
    -- body
    assert(event and func and type(event) == 'number' and type(func) == 'function','registerEvent arg invalid!')
    
    local target = self:getTarget()
    assert(target, 'SimpleLuaController Must Have A Target!')

    target:registerEvent(event,func)
end

function SimpleLuaController:setName(name )
    -- body
end

function SimpleLuaController:setUserData( userData )
    -- body
    self._userData = userData
end

function SimpleLuaController:getUserData()
    -- body
    return self._userData
end

------------------------------------define local GVCUpdate Controller------------------------------------
local function __G__TRACKBACK__(msg)  
    print('----------------------------------------')  
    print('LUA ERROR: ' .. tostring(msg) .. '\n')  
    print(debug.traceback())  
    print('----------------------------------------')  
end  

------------------------------------------------------------------------------

local FirstScene = class(SimpleLuaController)

function FirstScene:createDocument()
    self._factory:setZipFilePath('zip/FirstScene.cocos.zip')
    return self._factory:createDocument('FirstScene.cocos')
end

--@@@@[[[[
function FirstScene:onInitXML()
	local set = self._set
    self._bg = set:getElfNode("bg")
    self._btnUpdate = set:getClickNode("btnUpdate")
    self._btnRun = set:getClickNode("btnRun")
    self._btnClean = set:getClickNode("btnClean")
    self._btnTestUpdate0 = set:getClickNode("btnTestUpdate0")
    self._btnTestUpdate1 = set:getClickNode("btnTestUpdate1")
    self._btnTestUpdate2 = set:getClickNode("btnTestUpdate2")
    self._btnTestUpdate3 = set:getClickNode("btnTestUpdate3")
    self._btnTestUpdate4 = set:getClickNode("btnTestUpdate4")
    self._btnTestUpdate5 = set:getClickNode("btnTestUpdate5")
    self._ActionHideWait = set:getElfAction("ActionHideWait")
    self._ActionShowWait = set:getElfAction("ActionShowWait")
    self._ActionBarTest = set:getElfAction("ActionBarTest")
end
--@@@@]]]]

--[[

main

test0
test1
test2

clean-all

--]]

--------------------------------override functions----------------------
function FirstScene:runUpdate(basicVersion)
    -- body
    local GVCMainServer         = require 'script.gvc.GVCMainServer'
    local GVCTestServer         = require 'script.gvc.GVCTestServer'

    local mainModule = GVCMainServer.createSyncServerModule('basic', basicVersion)
    
    local test1Module = GVCTestServer.createSyncServerModule(1, 'basic')
    local test2Module = GVCTestServer.createSyncServerModule(2, 'basic')
    local test3Module = GVCTestServer.createSyncServerModule(3, 'basic')

    local testModuleArray = {}
    table.insert(testModuleArray, test1Module)
    table.insert(testModuleArray, test2Module)
    table.insert(testModuleArray, test3Module)

    local function GVCUpdate( moduleArray )
        -- body
        local gvc = require 'script.gvc.GVCUpdate'
        gvc.update(moduleArray, function ()
            require 'script.SetPath'.init(moduleArray) 
            require 'Delegate'
        end)
    end

    local function updateMain()
        -- body
        require 'script.main'.run()
        
        local usedModuleArray = {}
        table.insert(usedModuleArray, mainModule)
        GVCUpdate(usedModuleArray)
    end

    updateMain()
end

function FirstScene:runAdvanced(basicVersion)
    -- body
    local GVCMainServer         = require 'script.gvc.GVCMainServer'
    local GVCTestServer         = require 'script.gvc.GVCTestServer'

    local mainModule = GVCMainServer.createSyncServerModule('basic', basicVersion)
    
    local test1Module = GVCTestServer.createSyncServerModule(1, 'basic')
    local test2Module = GVCTestServer.createSyncServerModule(2, 'basic')
    local test3Module = GVCTestServer.createSyncServerModule(3, 'basic')

    local testModuleArray = {}
    table.insert(testModuleArray, test1Module)
    table.insert(testModuleArray, test2Module)
    table.insert(testModuleArray, test3Module)

    local function GVCUpdate( moduleArray )
        -- body
        local gvc = require 'script.gvc.GVCUpdate'
        gvc.update(moduleArray, function ()
            require 'script.SetPath'.init(moduleArray) 
            require 'Delegate'
        end)
    end

    local function updateMain()
        -- body
        require 'script.main'.run()
        
        local usedModuleArray = {}
        table.insert(usedModuleArray, mainModule)
        GVCUpdate(usedModuleArray)
    end

    updateMain()
end

function FirstScene:runDevelop(basicVersion)
    -- body
    self._btnClean:setVisible(true)
    self._btnRun:setVisible(true)
    self._btnUpdate:setVisible(true)
    self._btnTestUpdate0:setVisible(true)
    self._btnTestUpdate1:setVisible(true)
    self._btnTestUpdate2:setVisible(true)
    self._btnTestUpdate3:setVisible(true)
    self._btnTestUpdate4:setVisible(true)
    self._btnTestUpdate5:setVisible(true)

    local GVCMainServer         = require 'script.gvc.GVCMainServer'
    local GVCTestServer         = require 'script.gvc.GVCTestServer'

    local mainModule = GVCMainServer.createSyncServerModule('basic', basicVersion)
    
    local test1Module = GVCTestServer.createSyncServerModule(1, 'basic')
    local test2Module = GVCTestServer.createSyncServerModule(2, 'basic')
    local test3Module = GVCTestServer.createSyncServerModule(3, 'basic')

    local testModuleArray = {}
    table.insert(testModuleArray, test1Module)
    table.insert(testModuleArray, test2Module)
    table.insert(testModuleArray, test3Module)

    local function GVCUpdate( moduleArray )
        -- body
        local gvc = require 'script.gvc.GVCUpdate'
        gvc.update(moduleArray, function ()
            require 'script.SetPath'.init(moduleArray) 
            require 'Delegate'
        end) 
    end 

    local function updateMain()
        -- body
        require 'script.main'.run()
        
        local usedModuleArray = {}
        table.insert(usedModuleArray, mainModule)
        GVCUpdate(usedModuleArray)
    end

    local function updateTest( num )
        -- body
        require 'script.main'.run()

        local usedModuleArray = {}
        table.insert(usedModuleArray, mainModule)
        table.insert(usedModuleArray, testModuleArray[num])
        GVCUpdate(usedModuleArray)
    end

    local function updateOnlyTest( num )
        -- body
        require 'script.main'.run()

        local usedModuleArray = {}
        table.insert(usedModuleArray, testModuleArray[num])
        GVCUpdate(usedModuleArray)
    end

    self._btnUpdate:setListener(function ( ... )
        -- body
        updateMain()
    end)

    self._btnRun:setListener(function ( ... )
        -- body
        require 'script.main'.run(false)
        require 'script.SetPath'.init()
        require 'Delegate'
    end)

    if require 'script.Config'.AutoCHomeTest or require 'script.Config'.AutoArenaTest then
        require 'script.main'.run(false)
        require 'script.SetPath'.init()
        require 'Delegate'
    end

    local effectTestArray = {
        'raw/guide/htp_begin08.mp3',
        'raw/guide/htp_begin_97.mp3',
    }
    local effect_index = 1

    self._btnClean:setListener(function ( ... )
        -- body
        require 'framework.helper.MusicHelper'.playEffect(effectTestArray[effect_index])
        effect_index = effect_index + 1
        if effect_index > #effectTestArray then
            effect_index = 1
        end

        local myFileHelper = require 'framework.sync.FileHelper'

        FileHelper:setWritableRelativePath('main/')
        myFileHelper.remove('')

        FileHelper:setWritableRelativePath('test1_main')
        myFileHelper.remove('')

        FileHelper:setWritableRelativePath('test2_main')
        myFileHelper.remove('')

        FileHelper:setWritableRelativePath('test3_main')
        myFileHelper.remove('')
        
        FileHelper:setWritableRelativePath(NULL)
    end)

    for i=0,2 do
     --   self['_btnTestUpdate'..i..'_label']:setString('测试'..(i)..'更新')
        self['_btnTestUpdate'..i]:setListener(function ()
            updateTest(i+1)
        end)
    end

    for i=0,2 do
     --   self['_btnTestUpdate'..i..'_label']:setString('测试'..(i)..'更新')
        self['_btnTestUpdate'..(3+i)]:setListener(function ()
            updateOnlyTest(i+1)
        end)
    end
end

function FirstScene:runLogin()
    -- body
    require 'script.main'.run(false)
    require 'script.SetPath'.init( {} ) 
    require 'Delegate'
end

function FirstScene:onInit( userData, netData )
    print('FirstScene:onInit')

    local mode = userData.mode
    local basicVersion = userData.basicVersion

    print('FirstScene init!')
    print(mode)
    print(basicVersion)

    if mode == 'update' then
        self:runUpdate(basicVersion)
    elseif mode == 'login' then
        self:runLogin()
    elseif mode == 'advanced' then

    elseif mode == 'test' then

    else
        self:runDevelop(basicVersion)
    end
    
end

function FirstScene:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
local controller_map = {}

--------------------------------Glee Core Redirect--------------------------------
local top_user_data

----------------------------------controller----------------------------------------
local RAW_GleeCore_registerLuaController = GleeCore.registerLuaController
local My_GleeCore_registerLuaController = function (self, name, class )
    
    -- assert(controller_map[name] == nil, string.format('controller %s has already checked in !', name))
    
    controller_map[name] = class

    --called from C++
    RAW_GleeCore_registerLuaController(self, name, function ( target )
        
        local obj = class.new() 
        obj:setName(name)
        obj:setUserData(top_user_data)
        assert(top_user_data)

        --bind C++ <-> Lua
        obj:setTarget(target) 
        target:registerScriptHandler(function(state, enable) 
            return obj:onState(state, enable) 
        end)

        obj:loadXML()
    end)
end 

local RAW_GleeCore_pushController = GleeCore.pushController
local My_GleeCore_pushController = function (self, name, data, controller, transition)
    
    top_user_data = data
    
    if type(data) ~= 'userdata' then
        RAW_GleeCore_pushController(self, name, nil, controller, transition)
    else
        RAW_GleeCore_pushController(self, name, data, controller, transition)
    end

    top_user_data = nil
end

local RAW_GleeCore_replaceController = GleeCore.replaceController
local My_GleeCore_replaceController = function (self, name, data, controller, transition)
    
    top_user_data = data
    
    if type(data) ~= 'userdata' then
        RAW_GleeCore_replaceController(self, name, nil, controller, transition)
    else 
        RAW_GleeCore_replaceController(self, name, data, controller, transition)
    end

    top_user_data = nil
end

My_GleeCore_registerLuaController(GleeCore, 'FirstScene', FirstScene)

--[[
mode
0.develop
1.direct
2.update
--]]
local function run( mode, basicVersion )

    local data = {
        mode = mode,
        basicVersion = basicVersion,
    }

    print('FirstScene Data')
    print(data)

    local ignoreMap = {
        ['script.Config']                   = true,
        ['script.gvc.GVCMainServer']        = true,
        ['script.gvc.GVCTestServer']        = true,
        ['script.gvc.GVCUpdate']            = true,
        ['script.gvc.GVCHelper']            = true,
        ['script.info.Info']                = true,
        -- ['framework.basic.GleeCore']        = true,
        -- ['script.environment.Inject']       = true,
    }

    for i,v in pairs(ignoreMap) do
        require(i)
    end

    --My_GleeCore_pushController(GleeCore, 'FirstScene', data )


    -- if mode == 'update' then
    --     My_GleeCore_pushController(GleeCore, 'FirstScene', mode )
    -- elseif mode == 'login' then
    --     require 'script.main'.run(false)
    --     require 'script.SetPath'.init()
    --     GleeCore:pushController('CLoginP')
    -- else
    --     My_GleeCore_pushController(GleeCore, 'FirstScene')
    -- end
    require 'script.main'.run(false)
    require 'script.SetPath'.init()
    GleeCore:pushController("CHomeMain")
end

return { run = run }


