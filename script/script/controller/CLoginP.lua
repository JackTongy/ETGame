local Config = require "Config"
local Utils = require 'framework.helper.Utils'
local AccountHelper = require 'AccountHelper'
local Json = require "framework.basic.Json"
local AccountInfo = require 'AccountInfo'
local Res = require 'Res'
local TimerHelper = require 'framework.sync.TimerHelper'
local HideLoginTipT = 
{
  ES=true,
  Arabic=true,
  english=true,
  PT=true,
}


local CLoginP = class(LuaController)

function CLoginP:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."CLoginP.cocos.zip")
    return self._factory:createDocument("CLoginP.cocos")
end

--@@@@[[[[
function CLoginP:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg = set:getElfNode("root_bg")
   self._root_tip = set:getLabelNode("root_tip")
   self._root_logo = set:getElfNode("root_logo")
   self._root_btnrelogin = set:getButtonNode("root_btnrelogin")
   self._root_serverentry = set:getElfNode("root_serverentry")
   self._root_serverentry_btnlogin = set:getClickNode("root_serverentry_btnlogin")
   self._root_serverentry_btnlogin_title = set:getLabelNode("root_serverentry_btnlogin_title")
   self._root_serverentry_server = set:getLinearLayoutNode("root_serverentry_server")
   self._root_serverentry_server_name = set:getLabelNode("root_serverentry_server_name")
   self._root_serverentry_btnswtich = set:getButtonNode("root_serverentry_btnswtich")
   self._root_serverentry_tip = set:getLabelNode("root_serverentry_tip")
   self._root_slayout = set:getLinearLayoutNode("root_slayout")
   self._root_slayout_close = set:getButtonNode("root_slayout_close")
   self._root_slayout_filter = set:getElfNode("root_slayout_filter")
   self._root_slayout_filter_bg = set:getJoint9Node("root_slayout_filter_bg")
   self._root_slayout_filter_linear_title = set:getElfNode("root_slayout_filter_linear_title")
   self._root_slayout_filter_linear_title_v = set:getLabelNode("root_slayout_filter_linear_title_v")
   self._root_slayout_filter_linear_list = set:getListNode("root_slayout_filter_linear_list")
   self._title = set:getLabelNode("title")
   self._line = set:getElfNode("line")
   self._root_slayout_serverlist = set:getLinearLayoutNode("root_slayout_serverlist")
   self._title = set:getLabelNode("title")
   self._layout = set:getLinearLayoutNode("layout")
   self._btn = set:getButtonNode("btn")
   self._linear_name = set:getLabelNode("linear_name")
   self._linear_state = set:getLabelNode("linear_state")
   self._btn = set:getButtonNode("btn")
   self._linear = set:getLinearLayoutNode("linear")
   self._linear_I = set:getLabelNode("linear_I")
   self._linear_name = set:getLabelNode("linear_name")
   self._linear_state = set:getLabelNode("linear_state")
   self._title = set:getLabelNode("title")
   self._layout = set:getLinearLayoutNode("layout")
   self._title = set:getLabelNode("title")
   self._list = set:getListNode("list")
   self._list_container_c = set:getElfNode("list_container_c")
   self._list_container_c_layout = set:getLayout2DNode("list_container_c_layout")
   self._title = set:getLabelNode("title")
   self._list = set:getListNode("list")
   self._list_container_c = set:getElfNode("list_container_c")
   self._list_container_c_layout = set:getLayout2DNode("list_container_c_layout")
   self._root_invitecode = set:getElfNode("root_invitecode")
   self._root_invitecode_title = set:getLabelNode("root_invitecode_title")
   self._root_invitecode_btnconfirm = set:getButtonNode("root_invitecode_btnconfirm")
   self._root_invitecode_tip = set:getLabelNode("root_invitecode_tip")
   self._root_invitecode_input = set:getInputTextNode("root_invitecode_input")
   self._root_invitecode_item1 = set:getRichLabelNode("root_invitecode_item1")
   self._root_invitecode_item1_btn = set:getButtonNode("root_invitecode_item1_btn")
   self._root_invitecode_item2 = set:getRichLabelNode("root_invitecode_item2")
   self._root_invitecode_item2_btn = set:getButtonNode("root_invitecode_item2_btn")
   self._root_invitecode_btnback = set:getButtonNode("root_invitecode_btnback")
   self._root_acpw = set:getElfNode("root_acpw")
   self._root_acpw_account = set:getInputTextNode("root_acpw_account")
   self._root_acpw_psw = set:getInputTextNode("root_acpw_psw")
   self._root_acpw_btnlogin = set:getClickNode("root_acpw_btnlogin")
   self._root_acpw_btnlogin_title = set:getLabelNode("root_acpw_btnlogin_title")
   self._root_acpw_btnReg = set:getClickNode("root_acpw_btnReg")
   self._root_acpw_btnReg_title = set:getLabelNode("root_acpw_btnReg_title")
   self._root_loadBar = set:getElfNode("root_loadBar")
   self._root_loadBar_bg = set:getElfNode("root_loadBar_bg")
   self._root_loadBar_progress = set:getBarNode("root_loadBar_progress")
   self._root_loadBar_tip = set:getLabelNode("root_loadBar_tip")
   self._root_loadBar_pika = set:getSimpleAnimateNode("root_loadBar_pika")
   self._root_update = set:getElfNode("root_update")
   self._root_update_title = set:getLabelNode("root_update_title")
   self._root_update_btnconfirm = set:getButtonNode("root_update_btnconfirm")
   self._root_update_content = set:getRichLabelNode("root_update_content")
   self._root_MI = set:getElfNode("root_MI")
   self._root_MI_title = set:getLabelNode("root_MI_title")
   self._root_MI_btnconfirm = set:getButtonNode("root_MI_btnconfirm")
   self._root_MI_content = set:getRichLabelNode("root_MI_content")
   self._root_fitpos_version = set:getLabelNode("root_fitpos_version")
   self._root_tiplayout = set:getLinearLayoutNode("root_tiplayout")
   self._root_tiplayout_text = set:getLabelNode("root_tiplayout_text")
   self._root_tiplayout_point = set:getLinearLayoutNode("root_tiplayout_point")
   self._root_tiplayout_point_1 = set:getLabelNode("root_tiplayout_point_1")
   self._root_tiplayout_point_2 = set:getLabelNode("root_tiplayout_point_2")
   self._root_tiplayout_point_3 = set:getLabelNode("root_tiplayout_point_3")
   self._root_switchAccount = set:getClickNode("root_switchAccount")
   self._root_switchAccount_title = set:getLabelNode("root_switchAccount_title")
   self._root_kor = set:getElfNode("root_kor")
--   self._@fitem = set:getTabNode("@fitem")
--   self._@btn = set:getElfNode("@btn")
--   self._@history = set:getJoint9Node("@history")
--   self._@select = set:getElfNode("@select")
--   self._@selectI = set:getElfNode("@selectI")
--   self._@tests = set:getJoint9Node("@tests")
--   self._@news = set:getJoint9Node("@news")
--   self._@others = set:getJoint9Node("@others")
end
--@@@@]]]]

--------------------------------override functions----------------------
function CLoginP:onInit( userData, netData )
  self._root_tip:setVisible(not HideLoginTipT[Config.LangName])
  require 'DIndicator'.setDealy(10)
  require 'ParticleHelper'.addLoginParticles( self._root_bg )
	require 'MusicSettings'
	require 'framework.helper.MusicHelper'.playBackgroundMusic('raw/ui_music_nexus.mp3', true)

  self._talkingDataEnable = false

  self:TalkingDataGAStart()
  self:viewVisible()
  -- self:showTipLayout(Res.locString('Login$checkversion'),true,true)
  if AccountHelper.getSdkUid() and AccountHelper.getSdkToken() then
    self:getServerList(AccountHelper.getSdkUid(),AccountHelper.getSdkToken())
  else
    local initsdk = function ( ... )
      local data = {}
      data.uid = 0
      data.sessionid = 0
      self:getServerList(data.uid,data.sessionid)
    end

    self:checkInviteCodeBeforeSdk(0,initsdk)

  end
  
  -- require 'SocketClient'.enableLogView(true)
  self._root_fitpos_version:setString(string.format('版本号 %s',tostring(AccountHelper.getClientVersion())))
  
end

function CLoginP:onBack( userData, netData )
  
end

function CLoginP:onRelease( ... )
  self:releasePikaAnimate()  
end

--------------------------------custom code-----------------------------
function CLoginP:checkInviteCodeBeforeSdk( DeviceId,callback )

  local showInviteView 
  local fetchInviteInfo

  showInviteView = function ( data )
    self._root_btnrelogin:setListener(function ( ... )
      -- do nothing
    end)

    self:viewVisible(false,false,false,false,true,false,false)

    self._root_invitecode_tip:setString(tostring(data.InviteCodeInfo))
    self._root_invitecode_btnconfirm:setListener(function ( ... )
      local Code = self._root_invitecode_input:getText()
      if Code == nil or string.len(Code) == 0 then
        self:toast(require 'Res'.locString('Global$noEmpty'))
        return
      end

      --绑定
      AccountHelper.ACSBindDevInviteCode(Code,DeviceId,function ( data )
        if data and data.R then
        	self:viewVisible(false,false,false,false,false,false,false)
          return callback and callback(data)
        end
      end)
    end)
    self._root_invitecode_btnconfirm:setPosition(ccp(0,-108))
    self._root_invitecode_btnback:setVisible(false)

  end

  --获取
  fetchInviteInfo = function ( ... )
  	local func = function ( ... )
 		AccountHelper.ACSDevInviteCode(DeviceId,function ( data )
		      	if data and data.R then
		          	return callback and callback(data)
		      	elseif data and not data.R then
		        		showInviteView(data)
		      	end
	    	end)
	end
	if require 'framework.basic.Device'.platform == 'android' then
  		if  require 'script.info.Info'.ACCONFIG.Rk_Channel ~= 45 then--非UC
  			return func()
  		else
  			return callback()
  		end
  	else
    		return func()
    	end
  end

  self._root_btnrelogin:setListener(function ( ... )
    fetchInviteInfo()
  end)

  self:runWithDelay(function ( ... )
	return fetchInviteInfo()
  end)

end

--data
function CLoginP:getServerList( uid,token ,withoutauth)
  
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
        AccountInfo.setAuthData(datatable)
      end
    end,function ( ... )
      self:showTipLayout(Res.locString('Login$ClickRetry'),true,false) 
    end)
    self:showTipLayout(Res.locString('Login$acauth'),true,true)
  end
  
  getservers = function ( authdata )
    self._root_btnrelogin:setListener(function ( ... )
      getservers(authdata)
    end)

    AccountHelper.ACSGetServer(authdata.SessionId,authdata.UserId,function ( datatable )
      if datatable then
        showservers(datatable)
      end
    end,function ( ... )
      self:showTipLayout(Res.locString('Login$ClickRetry'),true,false)  
    end)
    self:showTipLayout(Res.locString('Login$getserverlist'),true,true)
  end

  showservers = function ( datatable )
    self:showServerList(datatable,true)
    self._root_btnrelogin:setEnabled(false)
  end

  self:runWithDelay(function ( ... )
    if withoutauth and AccountInfo.getAuthData() then
      getservers(AccountInfo.getAuthData())
    else
      auth()
    end
  end)

  require 'BIHelper'.scribeLog('登录sdk帐号')
end

--
function CLoginP:showServerList( data,flag,hideMI )
   -- Res.ServerColor
   --[[
      data.Questionnaire
      data.Servers
      data.MyServers
      data.Version   
   ]]
   if data.Version and data.Version.Enforce then
    self:showUpdateView(data.Version)
    return
   end
   if data.MI and not hideMI then
    self:showMIView(data.MI)
    return
   end

   if data.MsgTitle and not hideMI then
    self:showNotice(data)
   end

   if data and data.Servers then
      self:viewVisible(true,false,false,false)

      local function refreshSet(set,v,recent)
        local state,color = AccountHelper.getState(v)
        color = (recent and ccc4f(1.000000,0.874510,0.192157,1.0)) or color
        set['linear_state']:setString(tostring(state))
        set['linear_state']:setFontFillColor(color,true)
        set['btn']:setListener(function ( ... )
          self:showGameEntry(v)
        end)
        if set['linear_I'] then
          set['linear_I']:setString(string.format('%s.',tostring(v.I)))
          set['linear_I']:setFontFillColor(color,true)
        --   set['linear_name']:setString(tostring(v.N))
        --   set['linear_name']:setFontFillColor(color,true)
        -- else
          
        end
        set['linear_name']:setString(tostring(v.N))
        set['linear_name']:setFontFillColor(color,true)
      end

      self._root_slayout_serverlist:removeAllChildrenWithCleanup(true)
      self._root_serverlist_btn     = self:createLuaSet('@btn')
      self._root_serverlist_history = self:createLuaSet('@history')
      self._root_serverlist_tests   = self:createLuaSet('@tests')
      self._root_serverlist_news    = self:createLuaSet('@news')
      self._root_serverlist_others  = self:createLuaSet('@others')

      --空白区返回
      self._root_slayout_serverlist:addChild(self._root_serverlist_btn[1])
      self._root_slayout_close:setListener(function ( ... )
        self:showGameEntry(AccountInfo.getCurrentServer())
      end)

      --最近登录
      local defaultServer
      if (not data.MyServers or #(data.MyServers) == 0) and (data.NewServers and #(data.NewServers)) > 0 then
        defaultServer = data.NewServers[1]
      end

      if data.MyServers and #(data.MyServers) > 0 then
        self._root_slayout_serverlist:addChild(self._root_serverlist_history[1])
        local historylayout = self._root_serverlist_history['layout']

        historylayout:removeAllChildrenWithCleanup(true)
        for i,v in ipairs(data.MyServers) do
          if i > 3 then break end
          local set = self:createLuaSet('@selectI')
          refreshSet(set,v,true)
          historylayout:addChild(set[1])
          if i == 1 then
            defaultServer = v
          end
        end
      end
      
      if defaultServer and flag then
        self:showGameEntry(defaultServer)
      end

      --抢先服
      if data.TServers and #(data.TServers) > 0 then
        self._root_slayout_serverlist:addChild(self._root_serverlist_tests[1])
        local testslayout = self._root_serverlist_tests['layout']

        testslayout:removeAllChildrenWithCleanup(true)
        for i,v in ipairs(data.TServers) do
          if i > 3 then break end
          local set = self:createLuaSet('@select')
          refreshSet(set,v)
          testslayout:addChild(set[1])
        end
      end

      local adjustSize = function ( layout,c,cnt)

        if cnt < 3 then
          for i=1,3-cnt do
            local set = self:createLuaSet('@select')
            set[1]:setVisible(false)
            layout:addChild(set[1])
          end
        end
        layout:layout()

        local csize = c:getContentSize()
        local lsize = layout:getContentSize()
        -- print(string.format('size:(%d,%d)',csize.width,lsize.height))
        c:setContentSize(CCSizeMake(csize.width,lsize.height))
      end

      --推荐服务器
      local newslayout = self._root_serverlist_news['list_container_c_layout']
      self._root_slayout_serverlist:addChild(self._root_serverlist_news[1])
      newslayout:removeAllChildrenWithCleanup(true)
      self._root_serverlist_news['list']:setTouchEnable(false)
      for i,v in ipairs(data.NewServers) do
         local set = self:createLuaSet('@select')
         refreshSet(set,v)
         newslayout:addChild(set[1])
      end
      adjustSize(newslayout,self._root_serverlist_news['list_container_c'],#data.NewServers)
      
      --其它服务器
      self:sortServerList(data)
      local otherlayout = self._root_serverlist_others['list_container_c_layout']
      self._root_slayout_serverlist:addChild(self._root_serverlist_others[1])

      local showOthers = function ( servers,title )
        otherlayout:removeAllChildrenWithCleanup(true)
        for i,v in ipairs(servers) do
          local set = self:createLuaSet('@selectI')
          refreshSet(set,v)
          otherlayout:addChild(set[1])
        end
        adjustSize(otherlayout,self._root_serverlist_others['list_container_c'],#servers)
        self._root_serverlist_others['list']:layout()
        title = title or Res.locString('Login$oldserver')
        self._root_serverlist_others['title']:setString(title)
      end

      self:setServerFilter(data,showOthers)      
   end

   require 'BIHelper'.scribeLog('选服')
end

function CLoginP:showGameEntry( server )
   self:viewVisible(false,true,false,false)
   
   if not server then
    return
   end
   
   -- local state,color = AccountHelper.getState(server)
   local color = ccc4f(0.458824,1.000000,0.462745,1.0)
   self._root_serverentry_server_name:setString(tostring(server.N))
   self._root_serverentry_server_name:setFontFillColor(color,true)
   self._root_serverentry_tip:setFontFillColor(color,true)
   self._root_serverentry_btnswtich:setListener(function ( ... )
     self:showServerList(AccountInfo.getServerInfo(),nil,true)
   end)
   self._root_serverentry_btnlogin:setListener(function ( ... )
    if server.Cr and server.C then
      self:showMIView(server.Cr,server.Lks,server.Ct)
      return
    end

    if not server.A then
      self:showInviteView(AccountInfo.getServerInfo().InviteCodeInfo,server)
      return
    end

      AccountHelper.ACSGetRoleInfo(server,function ( datatable )

     	if server.S == 4 then
     		GleeCore:pushController('UpdateResScene', { callback = function ()
     			-- body
     			GleeCore:popController()
     			AccountHelper.ACSQS()
      			self:showLoadingData(datatable)
     		end } )
     	else
     		AccountHelper.ACSQS()
      		self:showLoadingData(datatable)
     	end
     end)
      require 'BIHelper'.scribeLog('点击进入游戏按钮')
   end)

end

function CLoginP:showACPW( ... )
   self:viewVisible(false,false,true,false)
end

function CLoginP:showLoadingData( datatable )
   self:viewVisible(false,false,false,true)
   self:roleLogin(datatable)
end

function CLoginP:showUpdateView( Version )
  self:viewVisible(false,false,false,false,false,true,false)
  self._root_update_content:setString(tostring(Version.Message))
  self._root_update_btnconfirm:setListener(function ( ... )
    os.exit(0)
  end)
end

function CLoginP:showMIView( Cr,Lks,Ct )

  local replace = function (str,tar,rep)
    return string.gsub(str,tar,rep)
  end

  if Cr then
    Cr = replace(Cr,'<link>','[u][link bg=00000000 bg_click=000000]')
    Cr = replace(Cr,'</link>','[/link][/u]')
  end

  --维护提示 确定时返回选服列表
  self:viewVisible(false,false,false,false,false,false,true)
  self._root_MI_content:setString(tostring(Cr))
  self._root_MI_btnconfirm:setListener(function ( ... )
    -- self:showServerList(AccountInfo.getServerInfo(),nil,true)
    self:showGameEntry(AccountInfo.getCurrentServer())
  end)

  if Lks and type(Lks) == 'table' then
    for i,v in ipairs(Lks) do
      self._root_MI_content:setLinkTarget(i-1,CCCallFunc:create(function ( ... )
        WebView:getInstance():gotoURL(tostring(v))
      end))  
    end
  end
  self._root_MI_title:setString(tostring(Ct))
end

function CLoginP:showInviteView( InviteCodeInfo ,server)
  self:viewVisible(false,false,false,false,true,false,false)

  self._root_invitecode_tip:setString(tostring(InviteCodeInfo))
  self._root_invitecode_btnconfirm:setListener(function ( ... )
    local Code = self._root_invitecode_input:getText()
    if Code == nil or string.len(Code) == 0 then
      self:toast(require 'Res'.locString('Global$noEmpty'))
      return
    end

    AccountHelper:ACInviteCode(Code,function ( datatable )
      if datatable and datatable.R then
        server.A = true
        self:showGameEntry(server)
      end
    end)
  end)

  self._root_invitecode_btnback:setListener(function ( ... )
    self:showGameEntry(AccountInfo.getCurrentServer())
  end)
  self._root_invitecode_btnconfirm:setPosition(ccp(136.0,-108.0))
  self._root_invitecode_btnback:setVisible(true)
end

function CLoginP:viewVisible( serverlist,gameentry,acpw,loading,invitecode,update,MI,Tip )
   self._root_slayout:setVisible(serverlist)
   self._root_serverentry:setVisible(gameentry)
   self._root_acpw:setVisible(acpw)
   self._root_loadBar:setVisible(loading)
   self._root_invitecode:setVisible(invitecode)
   self._root_update:setVisible(update)
   self._root_MI:setVisible(MI)
   self._root_tiplayout:setVisible(Tip)
end


--login game server

function CLoginP:roleLogin( datatable )
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

  local resIndex = 0
  local resSize = resLen
  local netIndex = 0
  local netSize = 2

  setLoadProgress(netIndex, netSize, resIndex, resSize, true)
  self:initPikaAnimate()
  self:showTip()

  local socketC = require "SocketClient"
  Config.SocketAddr = datatable.Host
  Config.SocketPort = tonumber(datatable.Port)
  Config.loginc = 'CLoginP'
  socketC:connect(Config.SocketAddr, Config.SocketPort, function ( suc )
      if suc then
          netIndex = 1
          setLoadProgress(netIndex, netSize, resIndex, resSize, true)

          require 'LoadBeforeEnterGame'
          require "RoleLogin".roleLoginV2(Config.RoleID, Config.ServerID, function ( )
            netIndex = 2
            setLoadProgress(netIndex, netSize, resIndex, resSize, true)
              require 'DIndicator'.setDealy(nil)
              local AppData = require 'AppData'
              local istep = AppData.getUserInfo().getiStep()
              if istep == 0 then
                  GleeCore:replaceController("CDialogBeforeBattle")
              else
                  GleeCore:replaceController("CHome") 
              end
              self:TalkingDataGA()
              require 'BIHelper'.record("login","RoleLogin",'0')
              -- require 'IapHelper'.init()
          end, function ( errMsg )
              setLoadProgress(netIndex, netSize, resIndex, resSize, false)
              self:toast(tostring(require 'Res'.locString('Toast$LoginFailed')) .. errMsg)
              self:showGameEntry(AccountInfo.getCurrentServer())
          end,Config.Psw)

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

function CLoginP:TalkingDataGAStart( ... )
  if self._talkingDataEnable then
    TalkingDataAppCpaCpp:init('22877f8140f74e8f85add0e086288e4b','')
    TalkingDataGA:onStart('F600F94AB1B03C1D61C748108B2D8606','appstore')
  end
end

function CLoginP:TalkingDataGA( ... )
  if self._talkingDataEnable then
    local curserver = AccountInfo.getCurrentServer()
    local userinfo = require 'AppData'.getUserInfo()
    
    if curserver and userinfo and userinfo.isValid() then
      local account = TDGAAccount:setAccount(userinfo.getId())
      TDGAAccount:setAccountName(userinfo.getName())
      TDGAAccount:setLevel(userinfo.getLevel())
      TDGAAccount:setGameServer(string.format('%s-%s',curserver.N,tostring(curserver.Id)))
    end

    TalkingDataAppCpaCpp:onLogin(tostring(AccountHelper.getSdkUid()))
  end
end

function CLoginP:showNotice( data )
  GleeCore:showLayer('DAServerNotice',{title=data.MsgTitle,Url=AccountHelper.getAServersNoticeUrl()})
end

function CLoginP:sortServerList( data )
  local servers = data.Servers
  if servers and #servers > 1 then
    table.sort(servers,function ( v1,v2 )
      return v1.I > v2.I
    end)
  end
end

function CLoginP:showTipLayout( str,visible,pv)
  self._root_tiplayout:setVisible(visible)
  self._root_tiplayout_text:setString(tostring(str))
  self._root_tiplayout_point:setVisible(pv)
  if visible then
    local cnt = 0
    local update = function ( ... )
      for i=1,3 do
        self[string.format('_root_tiplayout_point_%d',i)]:setVisible(cnt >= i)
      end
      cnt = cnt == 3 and 0 or cnt + 1
    end
    self._tippointhandle = self._tippointhandle or  TimerHelper.tick(update,0.5)
  end
end

function CLoginP:showTip( v )
  local changetip = function ( ... )
    local tipData = require 'Loading_tips'
    require 'Random'.randomseed(os.time())
    local index = require 'Random'.ranI(1, #tipData)
    local tip = tipData[index].Tips
    self._root_loadBar_tip:setString( tostring(tip)) 
  end

  local update = function ( ... )
    local array = CCArray:create()
    array:addObject(CCFadeOut:create(0.5))
    array:addObject(CCCallFunc:create(function ( ... )
      changetip()  
    end))
    array:addObject(CCFadeIn:create(0.5))

    self._root_loadBar_tip:runAction(CCSequence:create(array))
  end

  self._tiphandle = self._tiphandle or TimerHelper.tick(update,3)
  update()
end

function CLoginP:initPikaAnimate( ... )
  local update = function ( ... )
    local barlen = self._root_loadBar_progress:getLength()
    self._root_loadBar_pika:setPosition(ccp(barlen-217.0,-153.0))
  end
  self._pikahandle = self._pikahandle or TimerHelper.tick(update,0.01)
  update()
end

function CLoginP:releasePikaAnimate( ... )
  if self._pikahandle then
    TimerHelper.cancel(self._pikahandle)
    self._pikahandle = nil
  end

  if self._tippointhandle then
    TimerHelper.cancel(self._tippointhandle)
    self._tippointhandle = nil
  end
  
  if self._tiphandle then
    TimerHelper.cancel(self._tiphandle)
    self._tiphandle = nil
  end
end

function CLoginP:setServerFilter( data,showfunc )

  if #data.Servers > 10 then
    local Theight = (data.TServers and #data.TServers > 0) and 0 or 107
    local Mheight = (data.MyServers and #data.MyServers > 0) and 0 or 107
    self._root_slayout_filter:setContentSize(CCSizeMake(210,574-Theight - Mheight))
    self._root_slayout_filter_bg:setContentSize(CCSizeMake(210,574-Theight - Mheight))
    self._root_slayout_filter_linear_list:setContentSize(CCSizeMake(200,528-Theight - Mheight))
    self._root_slayout_filter:setVisible(true)
    self:updateServerFilter(data.Servers,showfunc)
  else
    self._root_slayout_filter:setContentSize(CCSizeMake(0,0))
    self._root_slayout_filter:setVisible(false)
    showfunc(data.Servers)
  end
  
end

function CLoginP:updateServerFilter( servers,showfunc )
  
  local servers = table.clone(servers)
  table.sort(servers,function ( v1,v2 )
    return v1.I < v2.I
  end)

  self._root_slayout_filter_linear_list:getContainer():removeAllChildrenWithCleanup(true)
  local total = #servers
  local defaultselect = nil
  local itemsets = {}

  for i=1,total,10 do
    local last = i + 9 
    last = last > total and total or last
    local itemset = self:createLuaSet('@fitem')
    local titlestr = string.format('%d-%d%s',i,last,Res.locString('Login$server'))
    itemset['title']:setString(titlestr)
    itemset[1]:setListener(function ( ... )
      local tmp = {}
      for j=i,i+9 do
        tmp[#tmp+1]=servers[j]
      end
      table.sort(tmp,function ( v1,v2 )
        return v1.I > v2.I
      end)
      showfunc(tmp,titlestr)
    end)
    table.insert(itemsets,itemset)
  end

  defaultselect = itemsets[#itemsets]
  for i=#itemsets,1,-1 do
    self._root_slayout_filter_linear_list:getContainer():addChild(itemsets[i][1])  
  end

  if defaultselect then
    defaultselect[1]:trigger(nil)
  end

end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(CLoginP, "CLoginP")


--------------------------------register--------------------------------
GleeCore:registerLuaController("CLoginP", CLoginP)


