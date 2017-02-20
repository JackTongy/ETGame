local Config = require "Config"
local Utils = require 'framework.helper.Utils'

local CTestLogin = class(LuaController)

function CTestLogin:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."CTestLogin.cocos.zip")
    return self._factory:createDocument("CTestLogin.cocos")
end

--@@@@[[[[
function CTestLogin:onInitXML()
    local set = self._set
   self._bg = set:getElfNode("bg")
   self._bg1 = set:getElfNode("bg1")
   self._ll1_roleID = set:getInputTextNode("ll1_roleID")
   self._ll2_serverID = set:getInputTextNode("ll2_serverID")
   self._btnSwith = set:getClickNode("btnSwith")
   self._btnSet = set:getClickNode("btnSet")
   self._btnLogin = set:getClickNode("btnLogin")
   self._btnAdvanced = set:getClickNode("btnAdvanced")
   self._btnTest = set:getClickNode("btnTest")
   self._loadBar = set:getElfNode("loadBar")
   self._loadBar_bg = set:getElfNode("loadBar_bg")
   self._loadBar_progress = set:getBarNode("loadBar_progress")
   self._loadBar_pika = set:getSimpleAnimateNode("loadBar_pika")
end
--@@@@]]]]

--------------------------------override functions----------------------

function CTestLogin:onInit( userData, netData )
	--[[
	music init
	--]]
	require 'MusicSettings'
	require 'framework.helper.MusicHelper'.playBackgroundMusic('raw/ui_music_nexus.mp3', true)

	require 'ParticleHelper'.addLoginParticles( self._bg )
	

	local default = Utils.readTableFromFile('CTestLogin') or {RoleID = 1, ServerID = 1}

	if default.IP and default.PORT then
		Config.SocketAddr = default.IP
		Config.SocketPort = default.PORT
	end

	-- if default ~= nil and default.FIT == 'iphone4' then
	-- 	CCEGLView:sharedOpenGLView():setDesignResolutionSize(960,640,2)
	-- end

	self._ll1_roleID:setText(tostring(default.RoleID))
	self._ll2_serverID:setText(tostring(default.ServerID))

	self._btnLogin:setListener(function (  )
		self:roleLoginEvent()
	end)

	self._btnSet:setListener(function ( )
		require 'CTestSetting'
		GleeCore:pushController('CTestSetting',{ callback = function ()
			default = Utils.readTableFromFile('CTestLogin') or {RoleID = 1, ServerID = 1}
		end})
	end)

	self._btnSwith:setListener(function ()
		require 'CLoginP'
		GleeCore:replaceController('CLoginP')
	end)

	self._btnAdvanced:setListener(function ()
		-- body
		-- local GVCUpdateHelper = require 'script.gvc.GVCUpdateHelper'
		-- assert(GVCUpdateHelper)

		-- GVCUpdateHelper.update( nil , 'advanced', function ()
		-- 	-- body
		-- 	self:roleLoginEvent()
		-- end, 'replace')
		-- 

		self:runAdvancedUpdate()

	end)

	if Config.AutoCHomeTest then
		self:runWithDelay(function ()
			-- body
			self:roleLoginEvent()
		end,0.1)
	end

	require 'SocketClient'.enableLogView(true)
	require 'MATHelper':Enable(true)
end

function CTestLogin:runAdvancedUpdate()
    -- body
    local GVCRecord 			= require 'script.gvc.GVCRecord'
    local GVCMainServer         = require 'script.gvc.GVCMainServer'
    local GVCTestServer         = require 'script.gvc.GVCTestServer'

    local basicVersion 			= GVCRecord.getServerVersion('basic')  or 0

    local basicModule 			= GVCMainServer.createSyncServerModule('basic', 0)
    local advancedModule 		= GVCMainServer.createSyncServerModule('advanced', basicVersion)

    local updateArray 			= { advancedModule } 
    local initArray 			= { basicModule, advancedModule }

    Config.RoleID = tonumber(self._ll1_roleID:getText())
	Config.ServerID = tonumber(self._ll2_serverID:getText())

    require 'script.main'.run() 
    local gvc = require 'script.gvc.GVCUpdate'
    gvc.update(updateArray, function ()
        require 'script.SetPath'.init(initArray) 
        -- require 'Delegate'
        -- GleeCore:replaceController("CHome")

        self:roleLoginEvent( true )
    end)
end

function CTestLogin:onBack( userData, netData )
	
end

function CTestLogin:onRelease( ... )
	self:releasePikaAnimate()
end

--------------------------------custom code-----------------------------

function CTestLogin:roleLoginEvent( ignore )

	if not ignore then
		Config.RoleID = ((not tolua.isnull(self._ll1_roleID)) and tonumber(self._ll1_roleID:getText())) or Config.RoleID
		Config.ServerID = ((not tolua.isnull(self._ll2_serverID)) and tonumber(self._ll2_serverID:getText())) or Config.ServerID
	end

	local default = Utils.readTableFromFile('CTestLogin') or {RoleID = 1, ServerID = 1}

	default.RoleID = Config.RoleID
	default.ServerID = Config.ServerID
	Utils.writeTableToFile(default, 'CTestLogin')

	if default.LogView then
		require 'SocketClient'.enableLogView(true)
		require 'LogHelper'.enableSaveLog(true)
		require 'LogHelper'.showLogViewIfNeed()
	end
	
	local socketC = require "SocketClient"
	print('connect:')
	print(Config)
	Config.loginc = 'CTestLogin'
	Config.Psw = nil

	local CHomeResArray = require 'CHomeResArray'
	local resLen = #CHomeResArray

	local function setLoadProgress( netIndex, netSize, resIndex, resSize, visible )
		-- body
		assert(netIndex)
		assert(netSize)
		assert(resIndex)
		assert(resSize)

		if tolua.isnull(self._loadBar_progress) then
			return
		end

		local resScale = 1
		local netScale = 5

		local totalSize = netSize * netScale + resSize * resScale
		local currentIndex = netIndex * netScale + resIndex * resScale

		local maxLength = 467
		if currentIndex >= totalSize then
			self._loadBar_progress:setLength(maxLength, false)
		else
			self._loadBar_progress:setLength(maxLength * currentIndex / totalSize, true)
		end

		if not self._loadBar:isVisible() and visible then
			require 'ParticleHelper'.moveParticlesBetween2Nodes(self._bg, self._loadBar_bg)
		end
		
		self._loadBar:setVisible(visible)
	end

	local resIndex = 0
	local resSize = resLen
	local netIndex = 0
	local netSize = 12

	setLoadProgress(netIndex, netSize, resIndex, resSize, true)
	self:initPikaAnimate()
	if Config.AutoCHomeTest then
		Config.SocketAddr = "101.251.106.84"
		Config.SocketPort = 3001
		Config.RoleID = 2815
		Config.ServerID = 1
	end

	socketC:connect(Config.SocketAddr, Config.SocketPort, function ( suc )
		if suc then
			-- 1
			netIndex = netIndex + 1
			setLoadProgress(netIndex, netSize, resIndex, resSize, true)
			
			require 'LoadBeforeEnterGame'
			require "RoleLogin".roleLoginV2(Config.RoleID, Config.ServerID, function ( )
				-- 3
				netIndex = netSize
				setLoadProgress(netIndex, netSize, resIndex, resSize, true)

				self:runWithDelay(function ()
					-- body
					local AppData = require 'AppData'
					local istep = AppData.getUserInfo().getiStep()
					if istep == 0 then
						GleeCore:replaceController("CDialogBeforeBattle")
					else
						print('CHome 1')
						require 'framework.sync.TimerHelper'.tick(function ()
							-- body
							print('CHome 2')
							GleeCore:replaceController("CHome")	
							return true
						end, 0)
					end
				end, 0.5)

			end, function ( errMsg )
				setLoadProgress(netIndex, netSize, resIndex, resSize, false)
				self:toast("登录失败T_T" .. errMsg) 
			end, nil, function ( validflags, allflags )
				-- body
				netIndex = 1 + 10*validflags/allflags
				setLoadProgress(netIndex, netSize, resIndex, resSize, true)
			end)

			-- 3
			for i, resid in ipairs(CHomeResArray) do
				ElfResMap:getCCSpriteFrameByResid(resid)

				resIndex = i
				setLoadProgress(netIndex, netSize, resIndex, resSize, true)
			end

		else
			setLoadProgress(netIndex, netSize, resIndex, resSize, false)
			GleeCore:showLayer('DDisconnectNotice')
		end
	end)

	
end

function CTestLogin:initPikaAnimate( ... )
    self._pikahandle = self._pikahandle or require 'framework.sync.TimerHelper'.tick(function ( ... )
        local barlen = self._loadBar_progress:getLength()
        self._loadBar_pika:setPosition(ccp(barlen-217.0,-153.0))
    end,0.01)
end

function CTestLogin:releasePikaAnimate( ... )
	if self._pikahandle then
		require 'framework.sync.TimerHelper'.cancel(self._pikahandle)
		self._pikahandle = nil
	end
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(CTestLogin, "CTestLogin")


--------------------------------register--------------------------------
GleeCore:registerLuaController("CTestLogin", CTestLogin)
