local Config = require "Config"
local Res = require 'Res'
local Indicator = require 'DIndicator'
require 'framework.net.Net'
local AccountInfo = require 'AccountInfo'
local AccountHelper = require 'AccountHelper'
local BIHelper = require 'BIHelper'
local androidUtil = require "AndroidUtil"

local CLoginRekoo = class(LuaController)

function CLoginRekoo:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."CLoginRekoo.cocos.zip")
    return self._factory:createDocument("CLoginRekoo.cocos")
end

--@@@@[[[[
function CLoginRekoo:onInitXML()
	local set = self._set
    self._root = set:getElfNode("root")
    self._root_bg = set:getElfNode("root_bg")
    self._root_btnrelogin = set:getButtonNode("root_btnrelogin")
    self._root_serverentry = set:getElfNode("root_serverentry")
    self._root_serverentry_btnlogin = set:getClickNode("root_serverentry_btnlogin")
    self._root_serverentry_btnlogin_title = set:getLabelNode("root_serverentry_btnlogin_title")
    self._root_serverentry_server = set:getLinearLayoutNode("root_serverentry_server")
    self._root_serverentry_server_name = set:getLabelNode("root_serverentry_server_name")
    self._root_serverentry_btnswtich = set:getButtonNode("root_serverentry_btnswtich")
    self._root_serverentry_tip = set:getLabelNode("root_serverentry_tip")
    self._root_serverlist = set:getElfNode("root_serverlist")
    self._root_serverlist_bg1 = set:getJoint9Node("root_serverlist_bg1")
    self._root_serverlist_bg1_title = set:getLabelNode("root_serverlist_bg1_title")
    self._server = set:getLinearLayoutNode("server")
    self._server_name = set:getLabelNode("server_name")
    self._state = set:getLabelNode("state")
    self._btn = set:getButtonNode("btn")
    self._empty = set:getLabelNode("empty")
    self._root_serverlist_bg2 = set:getJoint9Node("root_serverlist_bg2")
    self._root_serverlist_bg2_title = set:getLabelNode("root_serverlist_bg2_title")
    self._root_serverlist_bg2_list = set:getListNode("root_serverlist_bg2_list")
    self._server = set:getLinearLayoutNode("server")
    self._server_name = set:getLabelNode("server_name")
    self._state = set:getLabelNode("state")
    self._btn = set:getButtonNode("btn")
    self._root_invitecode = set:getElfNode("root_invitecode")
    self._root_invitecode_title = set:getLabelNode("root_invitecode_title")
    self._root_invitecode_btnconfirm = set:getButtonNode("root_invitecode_btnconfirm")
    self._root_invitecode_tip = set:getLabelNode("root_invitecode_tip")
    self._root_invitecode_input = set:getInputTextNode("root_invitecode_input")
    self._root_invitecode_item1 = set:getRichLabelNode("root_invitecode_item1")
    self._root_invitecode_item1_btn = set:getButtonNode("root_invitecode_item1_btn")
    self._root_invitecode_item2 = set:getRichLabelNode("root_invitecode_item2")
    self._root_invitecode_item2_btn = set:getButtonNode("root_invitecode_item2_btn")
    self._root_acpw = set:getElfNode("root_acpw")
    self._root_acpw_account = set:getInputTextNode("root_acpw_account")
    self._root_acpw_psw = set:getInputTextNode("root_acpw_psw")
    self._root_acpw_btnlogin = set:getClickNode("root_acpw_btnlogin")
    self._root_acpw_btnlogin_title = set:getLabelNode("root_acpw_btnlogin_title")
    self._root_acpw_btnReg = set:getClickNode("root_acpw_btnReg")
    self._root_acpw_btnReg_title = set:getLabelNode("root_acpw_btnReg_title")
    self._root_version = set:getLabelNode("root_version")
    self._root_loadBar = set:getElfNode("root_loadBar")
    self._root_loadBar_bg = set:getElfNode("root_loadBar_bg")
    self._root_loadBar_progress = set:getBarNode("root_loadBar_progress")
    self._Ad = set:getFitPositionNode("Ad")
    self._Ad_click = set:getButtonNode("Ad_click")
    self._Ad_fitposition_close = set:getButtonNode("Ad_fitposition_close")
--    self._@select = set:getElfNode("@select")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------
function CLoginRekoo:onInit( userData, netData )

  require 'ParticleHelper'.addLoginParticles( self._root_bg )
  
  self:adjustView()
  self:viewVisible(false,false,false,false)
  -- TalkingDataAppCpaCpp:init('22877f8140f74e8f85add0e086288e4b','')
  -- TalkingDataGA:onStart('F600F94AB1B03C1D61C748108B2D8606','website')

  -- local Json = require "framework.basic.Json"
  -- rekooSdk:getInstance():initsdk()
  -- rekooSdk:getInstance():registerScriptHandler(function ( methodname,jsonString )
  --   --[[
  --   getInitCallBack
  --   getLoginCallBack {"uid":"8499611","sessionid":"8c0d8434da073e5fc0870514378e5e25","Ret":"SUCCESS"}
  --   ]]
  --   if methodname and methodname == 'getLoginCallBack' and jsonString then
  --     data = Json.decode(jsonString)
  --     if data.Ret == 'SUCCESS' then
  --       self:getServerList(data.uid,data.sessionid)
  --     else
  --       self:toast('登录失败!')      
  --     end
  --   elseif methodname and methodname == 'leaveSDK' then
  --     self._root_btnrelogin:setListener(function ( ... )
  --       rekooSdk:getInstance():login()      
  --     end)
  --   end
  -- end)
	if not self.hasLoaded then
		require "EventCenter".addEventFunc("OnSdkLoginSuccess", function ( info )
			self._root_btnrelogin:setEnabled(true)
			local uid,token = unpack(string.split(info,"&"))
			self:getServerList(uid,token)
		end, "CLoginRekoo")

		require "EventCenter".addEventFunc("OnSdkLogout", function (  )
			return self:onInit()
		end, "CLoginRekoo")

		require "EventCenter".addEventFunc("OnSdkLoginFailed", function (  )
			self._root_btnrelogin:setEnabled(true)
		end, "CLoginRekoo")

		require "EventCenter".addEventFunc("OnSdkLoginCancel", function (  )
			self._root_btnrelogin:setEnabled(true)
		end, "CLoginRekoo")
		
		self.hasLoaded = true
	end

  if AccountHelper.getSdkUid() and AccountHelper.getSdkToken() then
    self:getServerList(AccountHelper.getSdkUid(),AccountHelper.getSdkToken())
  else
  	require "framework.sync.TimerHelper".tick(function ( ... )
		androidUtil.sdkLogin()
		self._root_btnrelogin:setEnabled(false)
		return true
	end)
	 self._root_btnrelogin:setEnabled(true)
    	self._root_btnrelogin:setListener(function ( ... )
       		androidUtil.sdkLogin()   
      	end)
  end
  
  -- BIHelper.setEnable(true)
  -- BIHelper.initBI('rekoo','1.0.0','com.glee.petinhouse')
  require 'SocketClient'.enableLogView(true)
  self._root_version:setString(string.format('版本号 %s',tostring(AccountHelper.getClientVersion())))
  
end

function CLoginRekoo:onBack( userData, netData )
	
end

function CLoginRekoo:onRelease( ... )
	require "EventCenter".resetGroup("CLoginRekoo")
end
--------------------------------custom code-----------------------------

--data
function CLoginRekoo:getServerList( uid,token )
  
  local auth
  local getservers
  local showservers 

  auth = function ()
    self._root_btnrelogin:setListener(function ( ... )
      auth()
    end)

    AccountHelper.ACSAuth(uid,token,function ( datatable )
      if datatable then
        getservers(datatable)
      end
    end)
  end
  
  getservers = function ( authdata )
    self._root_btnrelogin:setListener(function ( ... )
      getservers(authdata)
    end)

    AccountHelper.ACSGetServer(authdata.SessionId,authdata.UserId,function ( datatable )
      if datatable then
        showservers(datatable)
      end
    end)
  end

  showservers = function ( datatable )
    self:showServerList(datatable,true)
    self._root_btnrelogin:setEnabled(false)
  end

  auth()

end

--
function CLoginRekoo:showServerList( data,flag )
   -- Res.ServerColor
   --[[
      data.Questionnaire
      data.Servers
      data.MyServers
      data.Version   
   ]]
   if self:checkInviteCode(data,flag) then
    return
   end

   if data and data.Servers then
      self:viewVisible(true,false,false,false)

      local function refreshSet(set,v)
        local state,color = AccountHelper.getState(v)
        set['server_name']:setString(tostring(v.N))
        set['state']:setString(tostring(state))
        set['state']:setFontFillColor(color,true)
        set['server_name']:setFontFillColor(color,true)
        set['btn']:setListener(function ( ... )
          self:showGameEntry(v)
        end)
      end

      self._root_serverlist_bg2_list:getContainer():removeAllChildrenWithCleanup(true)
      for i,v in ipairs(data.Servers) do
         local set = self:createLuaSet('@item')
         refreshSet(set,v)
         self._root_serverlist_bg2_list:getContainer():addChild(set[1])
      end
      self._root_serverlist_bg2_list:layout()

      local selectset = self:createLuaSet('@select')
      self._root_serverlist_bg1:addChild(selectset[1])
      if data.MyServers and #data.MyServers > 0 then
        local v = data.MyServers[1]
        selectset['empty']:setVisible(false)
        refreshSet(selectset,v)
        if flag then
          self:showGameEntry(v)
        end
      end
   end
   
end

function CLoginRekoo:showGameEntry( server )
   self:viewVisible(false,true,false,false)
   
   local state,color = AccountHelper.getState(server)
   self._root_serverentry_server_name:setString(tostring(server.N))
   self._root_serverentry_server_name:setFontFillColor(color,true)
   self._root_serverentry_tip:setFontFillColor(color,true)
   self._root_serverentry_btnswtich:setListener(function ( ... )
     self:showServerList(AccountInfo.getServerInfo())
   end)
   self._root_serverentry_btnlogin:setListener(function ( ... )
     AccountHelper.ACSGetRoleInfo(server,function ( datatable )
      AccountHelper.ACSQS()
      self:showLoadingData(datatable)
     end)
   end)

end

function CLoginRekoo:showACPW( ... )
   self:viewVisible(false,false,true,false)
end

function CLoginRekoo:showLoadingData( datatable )
   self:viewVisible(false,false,false,true)
   self:roleLogin(datatable)
end

function CLoginRekoo:viewVisible( serverlist,gameentry,acpw,loading,invitecode )
   self._root_serverlist:setVisible(serverlist)
   self._root_serverentry:setVisible(gameentry)
   self._root_acpw:setVisible(acpw)
   self._root_loadBar:setVisible(loading)
   self._root_invitecode:setVisible(invitecode)
end


--login game server

function CLoginRekoo:roleLogin( datatable )
  --[[
    +Host ['192.168.1.213'']
    +ServerId [1]
    +Protocol ['ps'']
    +Id [1]
    +Port [3001]
  ]]

    Config.RoleID = tonumber(datatable.Id)
    Config.ServerID = tonumber(datatable.ServerId)
    Config.Psw = nil

    local CHomeResArray = require 'CHomeResArray'
    local resLen = #CHomeResArray


    local function setLoadProgress( netIndex, netSize, resIndex, resSize, visible )
        -- body
        assert(netIndex)
        assert(netSize)
        assert(resIndex)
        assert(resSize)

        local resScale = 1
        local netScale = 5

        local totalSize = netSize * netScale + resSize * resScale
        local currentIndex = netIndex * netScale + resIndex * resScale

        local maxLength = 467
        if currentIndex >= totalSize then
            self._root_loadBar_progress:setLength(maxLength, false)
        else
            self._root_loadBar_progress:setLength(maxLength * currentIndex / totalSize, true)
        end

        if not self._root_loadBar:isVisible() and visible then
            require 'ParticleHelper'.moveParticlesBetween2Nodes(self._root_bg, self._root_loadBar_bg)
        end

        self._root_loadBar:setVisible(visible)
    end

  -- local resIndex = 0
  -- local resSize = resLen
  -- local netIndex = 0
  -- local netSize = 2

  -- setLoadProgress(netIndex, netSize, resIndex, resSize, true)

  -- local socketC = require "SocketClient"
  -- Config.SocketAddr = datatable.Host
  -- Config.SocketPort = tonumber(datatable.Port)
  -- Config.loginc = 'CLoginRekoo'
  -- socketC:connect(Config.SocketAddr, Config.SocketPort, function ( suc )
  --     if suc then
  --         netIndex = 1
  --         setLoadProgress(netIndex, netSize, resIndex, resSize, true)

  --         require 'LoadBeforeEnterGame'
  --         require "RoleLogin".roleLoginV2(Config.RoleID, Config.ServerID, function ( )
  --           netIndex = 2
  --           setLoadProgress(netIndex, netSize, resIndex, resSize, true)
  --             local AppData = require 'AppData'
  --             local istep = AppData.getUserInfo().getiStep()
  --             if istep == 0 then
  --                 GleeCore:replaceController("CDialogBeforeBattle")
  --             else
  --                 GleeCore:replaceController("CHome") 
  --             end
  --             self:TalkingDataGA()
  --             BIHelper.record("login","RoleLogin",'0')
  --         end, function ( errMsg )
  --             setLoadProgress(netIndex, netSize, resIndex, resSize, false)
  --             self:toast("游戏服登录失败" .. errMsg)
  --             self:showGameEntry(AccountInfo.getCurrentServer())
  --         end,Config.Psw)

  --         -- 3
  --         for i, resid in ipairs(CHomeResArray) do
  --           ElfResMap:getCCSpriteFrameByResid(resid)

  --           resIndex = i
  --           setLoadProgress(netIndex, netSize, resIndex, resSize, true)
  --         end

  --     else
  --         setLoadProgress(netIndex, netSize, resIndex, resSize, false)
  --         GleeCore:showLayer('DDisconnectNotice')
  --     end
  -- end)
    local resIndex = 0
    local resSize = resLen
    local netIndex = 0
    local netSize = 12

    setLoadProgress(netIndex, netSize, resIndex, resSize, true)

    local socketC = require "SocketClient"
    Config.SocketAddr = datatable.Host
    Config.SocketPort = tonumber(datatable.Port)
    Config.loginc = 'CLoginRekoo'

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
                        require 'framework.sync.TimerHelper'.tick(function ()
                            -- body
                            GleeCore:replaceController("CHome") 
                            return true
                        end, 0)
                    end

                    self:TalkingDataGA()
                    BIHelper.record("login","RoleLogin",'0')

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

function CLoginRekoo:TalkingDataGA( ... )
  local curserver = AccountInfo.getCurrentServer()
  local userinfo = require 'AppData'.getUserInfo()
  
  if curserver and userinfo and userinfo.isValid() then
  	androidUtil.submitRoleInfo(userinfo.getId(),userinfo.getName(),userinfo.getLevel(),userinfo.getCoin(),userinfo.getVipLevel(),"",curserver.N,curserver.Id)

    local account = TDGAAccount:setAccount(userinfo.getId())
    TDGAAccount:setAccountName(userinfo.getName())
    TDGAAccount:setLevel(userinfo.getLevel())
    TDGAAccount:setGameServer(string.format('%s-%s',curserver.N,tostring(curserver.Id)))
  end

  -- TalkingDataAppCpaCpp:onLogin(tostring(AccountHelper.getSdkUid()))
end


--
function CLoginRekoo:adjustView( ... )
  -- local size = CCEGLView:sharedOpenGLView():getFrameSize()
  -- if size and size.width ~= 1136 then
  --   self._root:setScale(size.width/1136)
  -- end
end


function CLoginRekoo:checkInviteCode( data,flag )
  if flag and data and data.InviteCode then
    self:viewVisible(false,false,false,false,true)

    local channel = androidUtil.getRkChannelID()
    if channel == 45 then --uc
      self:initwith('温馨提示：主人可在九游发号中心或《口袋精灵OL》九游玩家群282229760领取激活码。'
      ,'九游发号中心'
      ,'http://u.9game.cn/uMYB2FnF'
      ,'九游玩家QQ群'
      ,'http://jq.qq.com/?_wv=1027&k=bBqQFz')      
    elseif channel == 1 then  --360
      self:initwith('主人可在360礼包中心或《口袋精灵OL》360玩家群212498679领取激活码。'
      ,'360礼包中心'
      ,'http://ka.u.360.cn/id-4814'
      ,'360玩家QQ群'
      ,'http://jq.qq.com/?_wv=1027&k=a1C4aR')   
    end
    
    self._root_invitecode_btnconfirm:setListener(function ( ... )
      local Code = self._root_invitecode_input:getText()
      if Code == nil or string.len(Code) == 0 then
        self:toast('激活码不能为空')
        return
      end

      AccountHelper:ACInviteCode(Code,function ( datatable )
        if datatable and datatable.R then
          data.InviteCode = false
          self:showServerList(data,flag)  
        end
      end)
      
    end)
    return true
  end
  return false
end

function CLoginRekoo:initwith( tip,str,url1,str2,url2 )
  self._root_invitecode_tip:setString(tip)
  self._root_invitecode_item1:setString(string.format('[color=0x2e72caff][u]%s[/u][/color]',str))
  self._root_invitecode_item2:setString(string.format('[color=0x2e72caff][u]%s[/u][/color]',str2))
  self._root_invitecode_item1_btn:setListener(function ( ... )
    if url1 then
      WebView:getInstance():gotoURL(url1)
    end
  end)
  self._root_invitecode_item2_btn:setListener(function ( ... )
    if url2 then
      WebView:getInstance():gotoURL(url2)
    end
  end)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(CLoginRekoo, "CLoginRekoo")


--------------------------------register--------------------------------
GleeCore:registerLuaController("CLoginRekoo", CLoginRekoo)


