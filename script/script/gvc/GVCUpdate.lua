local SyncEventCenter   = require 'framework.sync.SyncEventCenter'
local SyncResHelper     = require 'framework.sync.SyncResHelper'
local SyncHelper        = require 'framework.sync.SyncHelper'
local TimerHelper       = require 'framework.sync.TimerHelper'

local GVCRecord = require 'script.gvc.GVCRecord'


local sync_helper = SyncResHelper

local function locString( key )
    return LanguageManager:getInstance():getValue(key)
end

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
    assert(self:getTarget() == nil , "LuaController already has a target!")

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

function SimpleLuaController:onRelease()

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
        self:onInit( nil, nil )
    elseif state == tOnRelease then
        self:releaseMembers()
        self:onRelease()
    end
    return true
end 


function SimpleLuaController:registerEventLC(event,func)
    -- body
    assert(event and func and type(event) == "number" and type(func) == "function","registerEvent arg invalid!")
    
    local target = self:getTarget()
    assert(target, "SimpleLuaController Must Have A Target!")

    target:registerEvent(event,func)
end

function SimpleLuaController:setName(name )
    -- body
end

function SimpleLuaController:setUserData( userData )
    -- body
end
------------------------------------define local GVCUpdate Controller------------------------------------
local function __G__TRACKBACK__(msg)  
    print("----------------------------------------")  
    print("LUA ERROR: " .. tostring(msg) .. "\n")  
    print(debug.traceback())  
    print("----------------------------------------")  
end  

local syncResHelper = require 'framework.sync.SyncResHelper'

local GVCUpdate = class(SimpleLuaController)

local GVC_FinnalFunc = nil
local GVC_ServerArray = nil

function GVCUpdate:createDocument()
    self._factory:setZipFilePath("zip/GVCUpdate.cocos.zip")
    return self._factory:createDocument("GVCUpdate.cocos")
end

--@@@@[[[[
function GVCUpdate:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg = set:getElfNode("root_bg")
   self._root_info = set:getLabelNode("root_info")
   self._root_tiplayout = set:getLinearLayoutNode("root_tiplayout")
   self._root_tiplayout_text = set:getLabelNode("root_tiplayout_text")
   self._root_tiplayout_point = set:getLinearLayoutNode("root_tiplayout_point")
   self._root_tiplayout_point_1 = set:getLabelNode("root_tiplayout_point_1")
   self._root_tiplayout_point_2 = set:getLabelNode("root_tiplayout_point_2")
   self._root_tiplayout_point_3 = set:getLabelNode("root_tiplayout_point_3")
   self._root_bar = set:getElfNode("root_bar")
   self._root_bar_pika = set:getSimpleAnimateNode("root_bar_pika")
   self._root_bar_progress = set:getBarNode("root_bar_progress")
   self._root_tipTitle = set:getLabelNode("root_tipTitle")
   self._root_tipContent = set:getLabelNode("root_tipContent")
   self._root_logo = set:getElfNode("root_logo")
   self._root_tip = set:getLabelNode("root_tip")
   self._root_fitpos_vinfo = set:getLabelNode("root_fitpos_vinfo")
end
--@@@@]]]]

--------------------------------override functions----------------------

function GVCUpdate:onInit( userData, netData )
    require 'framework.helper.MusicHelper'.playBackgroundMusic('raw/ui_music_nexus.mp3', true)
    require 'script/particle/ParticleHelper'.addLoginParticles( self._root_bg )

    local WinSize = CCDirector:sharedDirector():getWinSize()
    -- if WinSize.width ~= 1136 then
    --     local scale = WinSize.width/1136
    --     self._root:setScale(scale)
    -- end

    self._root_bar_progress:setVisible(false)
    
    self:registerNetWorkChange()

    self._root_tipTitle:setString(locString('Login$downloading'))
    
    local tip = locString('Login$downloadingWaitTip')
    if tip == 'Login$downloadingWaitTip' then
        tip = ''
    end
    self._root_tip:setString(tip)
    
    --update setting and start
    self._root_bar_progress:setLength(0, false)
    self:initPikaAnimate()

    self._syncEnable = true
    -- 0 ：未启动 1：runing 2：pause 3: done
    self._SyncState = 0

    self._root_info:setVisible(false)

    self:handleSyncWithNetStatus(true)

    self._finnalFunc = GVC_FinnalFunc

    self:startSync()
    
    self:refreshLogo()
end

function GVCUpdate:refreshLogo(  )
    require 'script.adapter.ResAdapter'.setLogoWithBundleId(self._root_logo)
 --   	local labelnode = self._root_tipTitle
 --    	local maxwidth = 200
	-- if labelnode:getString() then
	-- 	local size = labelnode:getContentSize()
	-- 	if size.width > maxwidth then
	-- 		labelnode:setScale(labelnode:getScale()*maxwidth/size.width)

	-- 	end
	-- end
    labelnode:setFontSize(20)
    self._root_tipContent:setFontSize(20)
    -- require 'script.adapter.LangAdapter'.LabelNodeAutoShrink(self._root_tipTitle,200)
end

function GVCUpdate:handleSyncWithNetStatus(gprsEnable)
    local NetStatus = self:getNetStatus()

    if NetStatus == 0 then
        self:showGVCUpdateNotice(1)
        self:schemeSync(2)
    elseif NetStatus == 1 and gprsEnable then
        self:schemeSync(1)
    elseif NetStatus == 1 then
        self:showGVCUpdateNotice(2)
        self:schemeSync(2)
    elseif NetStatus == 2 then
        self:schemeSync(1)
    end
end

--state 1：runing 2：pause 
function GVCUpdate:schemeSync(state)
    
end

function GVCUpdate:getNetStatus( )
    return 2 or AppData:shared():getNetStatus()
end

function GVCUpdate:enterGame( )
    self._root_bar_progress:setLength(1136)
    self._SyncState = 3
    
    if self._finnalFunc then
        self._finnalFunc()
    end
end

function GVCUpdate:onRelease( )
    if self._pikahandle then
        CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(self._pikahandle)
    end
end

function GVCUpdate:isLocked()
    -- body
    return self._isLocked
end

function GVCUpdate:setLocked(  )
    -- body
    self._isLocked = true
end

function GVCUpdate:unLock(  )
    -- body
    self._isLocked = false
end

function GVCUpdate:redirect( path )
    -- body
    CCFileUtils:sharedFileUtils():purgeCachedEntries()
    FileHelper:clearSearchPath()
    
    if path then
        FileHelper:setWritableRelativePath( path )
        FileHelper:addSearchPath( FileHelper:getWritablePath() )
    end
end

function GVCUpdate:resetEvents( callback )
    -- body
    SyncEventCenter.resetGroup('GVCUpdate')

    assert(callback)

    SyncEventCenter.addEventFunc('Sync_Finish', function ()
        -- body
        -- SyncEventCenter.resetGroup('GVCUpdate')

        -- self:redirect( nil )

        print('Sync Completed!')
        if callback then
            xpcall(callback, __G__TRACKBACK__)
        end
        
    end, 'GVCUpdate')

    local errorOccured = false
    local progresslength = 502

    self._root_bar_progress:setVisible(false)
    self._root_fitpos_vinfo:setString( string.format('%s.%s',tostring(require 'script.info.Info'.PUBLISH_VERSION),tostring(localVersion or 0) ))

    SyncEventCenter.addEventFunc('Sync_Update', function (suc, progress, state, errinfo)
        -- body
        local info = string.format('suc=%s\nprogress=%f\nstate=%s\ninfo=%s', tostring(suc), progress, tostring(state), tostring(errinfo))
        print(info)
        if errorOccured or tolua.isnull(self._root_bar_progress) then
            return 
        end

        if state == 'execute' then
            -- 资源解压中

            self._root_tipContent:setString(locString('Login$decompression'))

            return 
        end

        if suc == nil then
            self._root_bar_progress:setLength(progresslength*progress/100)
            self._root_info:setString(info)
        elseif suc == false then
            errorOccured = true

            self._root_bar_progress:setLength(progresslength*progress/100)
            self._root_info:setString(info)
        elseif suc == true then
            self._root_bar_progress:setLength(progresslength*progress/100)
            self._root_info:setString(info)
            return
        end

        if self.downLoadSize then
            self._root_bar_progress:setVisible(true)

            local totalMB = self.downLoadSize
            self._root_tipContent:setString(string.format('%.2fMB/%.2fMB',totalMB*progress/100,totalMB))
        end
    end, 'GVCUpdate')

    SyncEventCenter.addEventFunc('Sync_MakeSure', function (localVersion, localNextVersion, serverVersion, needDownLoadedSize)
        -- body
        print(localVersion)
        print(localNextVersion)
        print(serverVersion)
        print(needDownLoadedSize)

        if errorOccured or tolua.isnull(self._root_bar_progress) then
            return 
        end

        if needDownLoadedSize and needDownLoadedSize > 0 then
            self._root_bar:setVisible(true)
            self._root_tipTitle:setVisible(true)
            self._root_tipContent:setVisible(true)
        else
            self._root_bar_progress:setVisible(false)
            self._root_tipTitle:setVisible(false)
            self._root_tipContent:setVisible(false)
        end

        local name = self.serverModule.getName()
        print('ServerModule='..name)
        print('localVersion='..localVersion..',serverVersion='..serverVersion..',needDownLoadedSize='..needDownLoadedSize)

        self.downLoadSize = needDownLoadedSize/(1024*1024)

        require 'script.gvc.GVCHelper'.setLocalVersion( localVersion )
        require 'script.gvc.GVCHelper'.setServerVersion( serverVersion )

        -- if localVersion then
        --     local text = string.format('版本号 %s', tostring(localVersion))
        --     self._root_fitpos_vinfo:setString(text)
        -- end

        self._root_fitpos_vinfo:setString( string.format('%s.%s',tostring(require 'script.info.Info'.PUBLISH_VERSION),tostring(localVersion or 0) ))

        require 'script.gvc.GVCRecord'.setServerVersion(name, serverVersion)
        require 'script.gvc.GVCRecord'.setLocalVersion(name, localVersion)

        -- if localVersion and serverVersion then

        --     GVCRecord.setServerVersion(name, serverVersion)
        --     GVCRecord.setLocalVersion(name, localVersion)

        --     self._root_vinfo:setString(string.format('%s-资源 当前版本号:%d 最新版本号:%d',name, localVersion,serverVersion))
        -- elseif localNextVersion then
        --     self._root_vinfo:setString(string.format('%s-执行 版本号为%d未完成的资源更新任务',name, localVersion))
        -- end

        if needDownLoadedSize ~= 0 then
            self:handleSyncWithNetStatus() 
        end
    end, 'GVCUpdate')

end

function GVCUpdate:coreUpdate( serverModule, basicModule, callback )
    -- body
    self.serverModule = serverModule

    self:resetEvents( callback )
    self:redirect( serverModule.getLocalDir() )

    SyncHelper.sync( serverModule, basicModule  )
end

function GVCUpdate:updateMain(  )
    -- body
    assert( GVC_ServerArray )

    local length = #GVC_ServerArray

    local callbackArray = {}

    for i=1,length-1 do
        callbackArray[i] = function (  )
            TimerHelper.tick(function (  )
                -- body
                self:coreUpdate(GVC_ServerArray[i+1], GVC_ServerArray[1], callbackArray[i+1])
                return true
            end)
        end
    end

    callbackArray[ #GVC_ServerArray ] = GVC_FinnalFunc

    self:coreUpdate(GVC_ServerArray[1], GVC_ServerArray[1], callbackArray[1])
    
end

function GVCUpdate:startSync( )

    self:updateMain()
    
end

function GVCUpdate:runWithDelay( func, delay )
    -- body
    local action = ElfDelay:create(delay)
    action:setListener(func)
    
    local node = self:getLayer()
    node:runAction(action)
end

function GVCUpdate:go()
    self:loadXML()
    GleeControllerManager:getInstance():cleanupControllers()
    GleeCore:pushController('GVCUpdate', nil, self:getTarget())
end

function GVCUpdate:registerNetWorkChange()

    self:registerEventLC(0,function ( ... )
        if not self._noticedialog and self._SyncState ~= 3 then
            self:handleSyncWithNetStatus()
        end
    end)

    self:registerEventLC(-1,function ( ... )
        self._sync_helper = nil
        self._SyncState = 0
        self:handleSyncWithNetStatus()
        print('recv -1')
    end)
end
--------------------notice 2G/3G ------------------
local GVCUpdateNotice = class(SimpleLuaInterface)
function GVCUpdateNotice:createDocument()
    self._factory:setZipFilePath("zip/DVipNotice.cocos.zip")
    return self._factory:createDocument("DVipNotice.cocos")
end

function GVCUpdateNotice:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_elf = set:getElfNode("root_elf")
   self._root_elf_confirm = set:getButtonNode("root_elf_confirm")
   self._root_elf_confirm_des = set:getLabelNode("root_elf_confirm_des")
   self._root_elf_cancel = set:getButtonNode("root_elf_cancel")
   self._root_elf_cancel_des = set:getLabelNode("root_elf_cancel_des")
   self._root_elf_title = set:getLabelNode("root_elf_title")
   self._root_elf_cotent = set:getLabelNode("root_elf_cotent")
   self._root_elf_green = set:getLabelNode("root_elf_green")
   self._root_elf_layout_content0 = set:getRichLabelNode("root_elf_layout_content0")

end

function GVCUpdateNotice:retainMembers()
    -- body
    self._document:retain()
    self._set:retain()
end

function GVCUpdateNotice:releaseMembers()
    -- body
    if self._document then
        self._document:release()
        self._document = nil
    end

    if self._set then
        self._set:release()
        self._set = nil
    end

    self._confirmFunc = nil
    self._cancelFunc = nil
end

--------------------------------override functions----------------------

function GVCUpdateNotice:onInit( userData, netData )
    self._root_elf_title:setString('提示');
end

function GVCUpdateNotice:updateLayer( userData )
  
  if userData then
    self._root_elf_layout_content0:setString(userData.Content or '')
    self._root_elf_green:setString(userData.Green or '')
    
    local x,y = self._root_elf_confirm:getPosition()

    if userData.confirm then
      self._root_elf_confirm:setVisible(true)
    else
      self._root_elf_confirm:setVisible(false)
      self._root_elf_cancel:setPosition(ccp(0,y))
    end

    if userData.cancel then
      self._root_elf_cancel:setVisible(true)
    else
      self._root_elf_cancel:setVisible(false)
      self._root_elf_confirm:setPosition(ccp(0,y))
    end

    self._root_elf_confirm_des:setString(userData.confirm or '')
    self._root_elf_cancel_des:setString(userData.cancel or '')

    self._root_elf_confirm:setListener(function ( )
      if self._confirmFunc then
        self._confirmFunc()
      end
    end)

    self._root_elf_cancel:setListener(function ()
      if self._cancelFunc then
        self._cancelFunc()
      end
    end)

  end

end

function GVCUpdateNotice:getLayer()
    if self._layer == nil then
        self:loadXML()
    end

    return self._set:getRootElfLayer()
end

function GVCUpdateNotice:setLayer( layer )
    self._layer = layer    
end

function GVCUpdateNotice:setBtnListener( confirmFunc,cancelFunc )
    self._confirmFunc = confirmFunc
    self._cancelFunc = cancelFunc
end

--显示网络类型提示框 dtype 1: 无网络 2:2G/3G 网络 3.重新启动sync_helper
function GVCUpdate:showGVCUpdateNotice(dtype)

    print(string.format('showGVCUpdateNotice:%d',dtype))

    if self._noticedialog == nil then
        self._noticedialog = GVCUpdateNotice.new()
        local layer = self._noticedialog:getLayer()
        if layer then
            self._noticedialog:onInit()
            self:getLayer():addChild(layer)
        end
    end

    local param = {}

    if dtype == 1 then
       param.Content = "网络异常,请检查网络连接..."
       param.confirm = "重试"
       self._noticedialog:setBtnListener(function ( )
            self:closeGvcUpdateNotice()
            self:handleSyncWithNetStatus()
       end,nil)

    elseif dtype == 2 then
       param.Content = "您当前处于移动网络中，建议在wifi环境中进行更新，节约流量。是否立即更新?"
       param.confirm = "确定"

       self._noticedialog:setBtnListener(function ( )
            self:closeGvcUpdateNotice()
            self:handleSyncWithNetStatus(true)
       end,nil)

    elseif dtype == 3 then

        param.Content = "下载任务异常中断，点击重试"
        param.confirm = "确定"

        self._noticedialog:setBtnListener(function ( )
            self:closeGvcUpdateNotice()
            self._sync_helper = nil
            self._SyncState = 0
            self:handleSyncWithNetStatus()
        end,nil)
    end

    self._noticedialog:updateLayer(param)
    self._root_bar:setVisible(false)
    self._root_tipTitle:setVisible(false)
    self._root_tipContent:setVisible(false)
    self._root_fitpos_vinfo:setVisible(false)
end

function GVCUpdate:closeGvcUpdateNotice()
    if self._noticedialog then
        self._noticedialog:getLayer():removeFromParent()
        self._noticedialog:releaseMembers()
        self._noticedialog = nil
    end
    self._root_bar:setVisible(true)
    self._root_tipTitle:setVisible(true)
    self._root_tipContent:setVisible(true)
    self._root_fitpos_vinfo:setVisible(true)
end

function GVCUpdate:updatePiKaPos( length )
    self._root_bar_pika:stopAllActions()
    local origpos = {-239.0,-7.0}
    local dstpos  = ccp(origpos[1]+length,origpos[2])
    if self.lastdstpos then
        self._root_bar_pika:setPosition(self.lastdstpos)
    end
    local action = ElfInterAction:create(CCMoveTo:create(0.5,dstpos), InterHelper.AcceDece)
    self._root_bar_pika:runElfAction(action)
    self.lastdstpos = dstpos
end

function GVCUpdate:initPikaAnimate( ... )
    local function tick(func, tv)
        tv = tv or 0
        local handle
        handle = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(function(dt)
            local ret = func(dt)
            if ret then
                CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(handle)
            end
        end, tv, false)
        return handle
    end

    self._pikahandle = self._pikahandle or tick(function ( ... )
        local barlen  = self._root_bar_progress:getLength()
        self._root_bar_pika:setPosition(ccp(barlen-239.0,-7.0))
    end,0.01)
end


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

        --bind C++ <-> Lua
        obj:setTarget(target) 
        target:registerScriptHandler(function(state, enable) 
            return obj:onState(state, enable) 
        end)

        obj:loadXML()
    end)
end 

-- My_GleeCore_registerLuaController = RAW_GleeCore_registerLuaController

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

My_GleeCore_registerLuaController(GleeCore, "GVCUpdate", GVCUpdate)

--[[

--]]
local function replaceUpdate( serverArray, func )
    -- body
    assert(serverArray)
    assert(func)

    GVC_ServerArray = serverArray
    GVC_FinnalFunc  = func

    My_GleeCore_replaceController(GleeCore, "GVCUpdate")
    print("GVCUpdate......")
end

local function pushUpdate( serverArray, func )
    -- body
    assert(serverArray)
    assert(func)

    GVC_ServerArray = serverArray
    GVC_FinnalFunc  = func
    
    My_GleeCore_pushController(GleeCore, "GVCUpdate")
    print("GVCUpdate......")
end

return { update = replaceUpdate, replaceUpdate = replaceUpdate, pushUpdate = pushUpdate }

