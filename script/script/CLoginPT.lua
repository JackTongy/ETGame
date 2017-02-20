local Config = require "Config"
local Utils = require 'framework.helper.Utils'

local CLoginPT = class(LuaController)

function CLoginPT:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."CLoginPT.cocos.zip")
    return self._factory:createDocument("CLoginPT.cocos")
end

--@@@@[[[[
function CLoginPT:onInitXML()
	local set = self._set
    self._root = set:getElfNode("root")
    self._root_bg = set:getElfNode("root_bg")
    self._root_bg1 = set:getElfNode("root_bg1")
    self._root_bg1_btnLogin = set:getClickNode("root_bg1_btnLogin")
    self._root_bg1_account = set:getInputTextNode("root_bg1_account")
    self._root_bg1_psw = set:getInputTextNode("root_bg1_psw")
    self._root_fitpos_version = set:getLabelNode("root_fitpos_version")
    self._root_loadBar = set:getElfNode("root_loadBar")
    self._root_loadBar_bg = set:getElfNode("root_loadBar_bg")
    self._root_loadBar_progress = set:getBarNode("root_loadBar_progress")
end
--@@@@]]]]

--------------------------------override functions----------------------
function CLoginPT:onInit( userData, netData )
    require 'ParticleHelper'.addLoginParticles( self._root_bg )

    self._default = Utils.readTableFromFile('CLoginPT') or {}

    if self._default.RoleID then
        self._root_bg1_account:setText(tostring(self._default.RoleID))
    else
        self._root_bg1_account:setPlaceHolder('请输入帐号')
    end
    if self._default.Psw then
        self._root_bg1_psw:setText(tostring(self._default.Psw))
    else
        self._root_bg1_psw:setPlaceHolder('请输入密码')
    end

    self._root_bg1_btnLogin:setListener(function ( ... )
        local roleid = self._root_bg1_account:getText()
        local psw = self._root_bg1_psw:getText()
        local rph = self._root_bg1_account:getPlaceHolder()
        local pph = self._root_bg1_psw:getPlaceHolder()

        if string.len(roleid) == 0 or roleid == rph then
            self:toast(rph)
            return
        end
        if string.len(psw) == 0 or psw == pph then
            self:toast(pph)
            return
        end
        self:roleLoginEvent()
    end)
end

function CLoginPT:onBack( userData, netData )
  
end

--------------------------------custom code-----------------------------
function CLoginPT:initInputView( ... )
    -- body
end

function CLoginPT:login( ... )
    -- body
end

function CLoginPT:roleLoginEvent(  )

    Config.RoleID = self._root_bg1_account:getText()
    Config.Psw = self._root_bg1_psw:getText()

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
  self._root_bg1:setVisible(false)
  
    local socketC = require "SocketClient"
    Config.SocketAddr = '121.199.40.60'
    Config.SocketPort = 3001
    Config.loginc = 'CLoginPT'
    socketC:connect(Config.SocketAddr, Config.SocketPort, function ( suc )
        if suc then
          netIndex = 1
          setLoadProgress(netIndex, netSize, resIndex, resSize, true)

          require 'LoadBeforeEnterGame'

            require "RoleLogin".roleLoginV2(Config.RoleID, Config.ServerID, function ( )
              netIndex = 2
              setLoadProgress(netIndex, netSize, resIndex, resSize, true)

              local AppData = require 'AppData'
              local istep = AppData.getUserInfo().getiStep()
              if istep == 0 then
                  GleeCore:replaceController("CDialogBeforeBattle")
              else
                  GleeCore:replaceController("CHome") 
              end

              self:saveLoginInfo()
            end, function ( errMsg )
              setLoadProgress(netIndex, netSize, resIndex, resSize, false)
              self:toast("登录失败T_T" .. errMsg)
              self._root_bg1:setVisible(true)
            end,Config.Psw)

            for i, resid in ipairs(CHomeResArray) do
              ElfResMap:getCCSpriteFrameByResid(resid)

              resIndex = i
              setLoadProgress(netIndex, netSize, resIndex, resSize, true)
            end

        else
          self._root_bg1:setVisible(true)
          GleeCore:showLayer('DDisconnectNotice')
        end
    end)
end

function CLoginPT:saveLoginInfo( ... )
    self._default.RoleID = Config.RoleID
    self._default.Psw = Config.Psw
    Utils.writeTableToFile(self._default, 'CLoginPT')
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(CLoginPT, "CLoginPT")


--------------------------------register--------------------------------
GleeCore:registerLuaController("CLoginPT", CLoginPT)


