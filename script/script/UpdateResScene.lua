-- local Config 		= require "Config"

local SyncEventCenter   = require 'framework.sync.SyncEventCenter'
local SyncResHelper     = require 'framework.sync.SyncResHelper'
local SyncHelper        = require 'framework.sync.SyncHelper'
local TimerHelper       = require 'framework.sync.TimerHelper'
local GVCRecord 		= require 'script.gvc.GVCRecord'

local UpdateResScene = class(LuaController)

function UpdateResScene:createDocument()
    self._factory:setZipFilePath("zip/GVCUpdate.cocos.zip")
    return self._factory:createDocument("GVCUpdate.cocos")
end

--@@@@[[[[
function UpdateResScene:onInitXML()
	local set = self._set
    self._root = set:getElfNode("root")
    self._root_bg = set:getElfNode("root_bg")
    self._root_info = set:getLabelNode("root_info")
    self._root_bar = set:getElfNode("root_bar")
    self._root_bar_progress = set:getBarNode("root_bar_progress")
    self._root_tipTitle = set:getLabelNode("root_tipTitle")
    self._root_tipContent = set:getLabelNode("root_tipContent")
    self._root_logo = set:getElfNode("root_logo")
    self._root_fitpos_vinfo = set:getLabelNode("root_fitpos_vinfo")
end
--@@@@]]]]

--------------------------------override functions----------------------
function UpdateResScene:runAdvanced(basicVersion)
    -- body
    local GVCMainServer         = require 'script.gvc.GVCMainServer'
    local mainModule = GVCMainServer.createSyncServerModule('basic', basicVersion)
    require 'script.adapter.ResAdapter'.setLogoWithBundleId(self._root_logo)
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

function UpdateResScene:initViews()
	-- body
	local WinSize = CCDirector:sharedDirector():getWinSize()
    if WinSize.width ~= 1136 then
        local scale = WinSize.width/1136
        self._root:setScale(scale)
    end
    
    -- self:registerNetWorkChange()
    self._root_tipTitle:setString('正在下载更新资源')
    --update setting and start
    self._root_bar_progress:setLength(0, false)
    
    self._syncEnable = true
    -- 0 ：未启动 1：runing 2：pause 3: done
    self._SyncState = 0

    self._root_info:setVisible(false)

    -- self:handleSyncWithNetStatus(true)

    -- self._finnalFunc = GVC_FinnalFunc

    -- self:startSync()
end

function UpdateResScene:redirect( path )
    -- body
    CCFileUtils:sharedFileUtils():purgeCachedEntries()
    FileHelper:clearSearchPath()

    if path then
        FileHelper:setWritableRelativePath( path )
        FileHelper:addSearchPath( FileHelper:getWritablePath() )
    end
end

function UpdateResScene:resetEvents( callback )
    -- body
    SyncEventCenter.resetGroup('UpdateResScene')

    assert(callback)

    SyncEventCenter.addEventFunc('Sync_Finish', function ()
        -- body
        if callback then
            xpcall(callback, __G__TRACKBACK__)
        end
    end, 'UpdateResScene')

    local errorOccured = false
    local progresslength = 502

    SyncEventCenter.addEventFunc('Sync_Update', function (suc, progress, state, errinfo)
        -- body
        local info = string.format('suc=%s\nprogress=%f\nstate=%s\ninfo=%s', tostring(suc), progress, tostring(state), tostring(errinfo))
        print(info)
        if errorOccured or tolua.isnull(self._root_bar_progress) then
            return 
        end

        if state == 'execute' then
            -- 资源解压中
            self._root_tipContent:setString('资源解压中')

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
            local totalMB = self.downLoadSize
            self._root_tipContent:setString(string.format('%.2fMB/%.2fMB',totalMB*progress/100,totalMB))
        end
    end, 'UpdateResScene')

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

        -- local name = self.serverModule.getName()
        -- print('ServerModule='..name)
        -- print('localVersion='..localVersion..',serverVersion='..serverVersion..',needDownLoadedSize='..needDownLoadedSize)

        self.downLoadSize = needDownLoadedSize/(1024*1024)

        -- require 'script.gvc.GVCHelper'.setLocalVersion( localVersion )
        -- require 'script.gvc.GVCHelper'.setServerVersion( serverVersion )

        if localVersion then
            -- local text = string.format('版本号 1.0.%s', tostring(localVersion))
            -- self._root_fitpos_vinfo:setString(text)
        end

        -- require 'script.gvc.GVCRecord'.setServerVersion(name, serverVersion)
        -- require 'script.gvc.GVCRecord'.setLocalVersion(name, localVersion)

        -- if localVersion and serverVersion then
        --     GVCRecord.setServerVersion(name, serverVersion)
        --     GVCRecord.setLocalVersion(name, localVersion)
        --     self._root_vinfo:setString(string.format('%s-资源 当前版本号:%d 最新版本号:%d',name, localVersion,serverVersion))
        -- elseif localNextVersion then
        --     self._root_vinfo:setString(string.format('%s-执行 版本号为%d未完成的资源更新任务',name, localVersion))
        -- end

        if needDownLoadedSize ~= 0 then
            -- self:handleSyncWithNetStatus() 
        end
    end, 'UpdateResScene')

end

function UpdateResScene:coreUpdate( serverModule, basicModule, callback )
    -- body


    self:resetEvents( callback )
    self:redirect( serverModule.getLocalDir() )

    SyncHelper.sync( serverModule, basicModule )
end



function UpdateResScene:onInit( userData, netData )
	-- advanced 
	print('UpdateResScene:onInit')

    local mode = 'advanced'
    local basicVersion = require 'script.gvc.GVCHelper'.getServerVersion()
    local callback = userData.callback

    assert( callback )

    print(mode)
    print(basicVersion)

    local GVCMainServer         = require 'script.gvc.GVCMainServer'
    local moduleBasic 			= GVCMainServer.createSyncServerModule('basic', 	basicVersion)
    local moduleAdvanced 		= GVCMainServer.createSyncServerModule('advanced', 	basicVersion)

    self:initViews()

    if mode == 'advanced' then
        self:coreUpdate(moduleAdvanced, moduleBasic, callback)
    elseif mode == 'advanced-test' then
        -- self:runLogin()
    else
        assert(false)
    end

end

function UpdateResScene:onBack( userData, netData )
	
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(UpdateResScene, "UpdateResScene")


--------------------------------register--------------------------------
GleeCore:registerLuaController("UpdateResScene", UpdateResScene)