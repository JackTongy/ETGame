local Config = require "Config"
local Indicator = require 'DIndicator'
local res = require 'Res'
local TransitionCtrl = require 'DCTransitionFade'

local DDisconnectNotice = class(LuaDialog)

function DDisconnectNotice:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DDisconnectNotice.cocos.zip")
    return self._factory:createDocument("DDisconnectNotice.cocos")
end

--@@@@[[[[
function DDisconnectNotice:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg1 = set:getElfNode("root_bg1")
   self._root_bg1_btnRetry = set:getClickNode("root_bg1_btnRetry")
   self._root_bg1_btnRetry_title = set:getLabelNode("root_bg1_btnRetry_title")
   self._root_bg1_btnRelogin = set:getClickNode("root_bg1_btnRelogin")
   self._root_bg1_btnRelogin_title = set:getLabelNode("root_bg1_btnRelogin_title")
   self._root_bg1_content = set:getLabelNode("root_bg1_content")
   self._root_bg1_title = set:getLabelNode("root_bg1_title")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DDisconnectNotice:onInit( userData, netData )
  local constants = require 'framework.basic.Constants'
  self._index = constants.GUIDE_INDEX+1

  local broadCastFunc = require 'AppData'.getBroadCastInfo()
  self._sync = broadCastFunc.get('ReloginSyncData')

  GleeCore:reSet()

  self._root_bg1_btnRetry:setListener(function ( ... )
    self:reConnect()
  end)

  self._root_bg1_btnRelogin:setListener(function ( ... )
      self:close()
      GleeCore:reLogin()
  end)

  self._root:setVisible(false)
  self:reConnect()
  require 'LangAdapter'.LabelNodeAutoShrink(self._root_bg1_btnRelogin_title,120)
  require 'LangAdapter'.LabelNodeAutoShrink(self._root_bg1_btnRetry_title,120)
end

function DDisconnectNotice:onBack( userData, netData )
	
end

function DDisconnectNotice:close( ... )
  TransitionCtrl.reset()
end
--------------------------------custom code-----------------------------

function DDisconnectNotice:reConnect( ... )
  
  local socketC = require "SocketClient"
  
  Indicator.show(0)

  self:runWithDelay(function ( ... )
    socketC:connect(Config.SocketAddr, Config.SocketPort, function ( suc )
      if suc then
        self:relogin()
      else
        self._root:setVisible(true)
        res.doActionDialogShow(self._root_bg1)
        Indicator.hide()
        TransitionCtrl.reset()
      end
    end)
  end,0.5)

end

function DDisconnectNotice:relogin( ... )
  --[[
    程序如果是因为退出到后台 导致的socket连接异常 则需要对userData进入一次同步
    程序中运行时的连接异常 则只进行重连
  ]]
  if self._sync then
    self:reloginSyncData()
  else
    self:reloginOnly()  
  end  
end

function DDisconnectNotice:reloginOnly( )
  self:saveRetryData()
  require 'RoleLogin'.roleLoginV2_1(Config.RoleID,Config.ServerID,function ( )
    require 'EventCenter'.eventInput('ReloginOnlyDone',data)
    self:retrySend()
    self:close()
    Indicator.hide()
  end,function ( ... )
    self:runWithDelay(function (  )
      self._root:setVisible(true)
      TransitionCtrl.reset()
    end)
    Indicator.hide()
  end,Config.Psw)
end

function DDisconnectNotice:reloginSyncData()
  self:saveRetryData()

  require "RoleLogin".roleLoginV2(Config.RoleID, Config.ServerID, function ( )
      require 'EventCenter'.eventInput('ReloginDone',data)
      -- 重新尝试断线时的网络数据发送
      self:retrySend()
      self:close()

      Indicator.hide()
  end, function ( ... )
      self:runWithDelay(function (  )
        self._root:setVisible(true)
        TransitionCtrl.reset()
      end)
      Indicator.hide()
  end,Config.Psw)
end

function DDisconnectNotice:saveRetryData( ... )
  local ArgQueue = require 'ArgQueue'
  self._retrydata = self._retrydata or ArgQueue.getData()
  if self._retrydata then
    --过滤指定的请求类型
    local ignores = {
      Ping=true,
      -- PetNiudanTen=true,
      -- LuckyDrawDraw=true,
    }

    local tmps = {}
    for i,v in ipairs(self._retrydata) do
      if v and v[1] and v[1].C and not ignores[v[1].C] then
        table.insert(tmps,v)
      end
    end

    self._retrydata = tmps
  end

  ArgQueue.clear()

  print('DDisconnectNotice:saveRetryData')
  print(self._retrydata)
  print(debug.traceback())
end

function DDisconnectNotice:retrySend( ... )
  if self._retrydata and #self._retrydata > 0 then
    for i,v in ipairs(self._retrydata) do
      require 'ArgQueue'.enqueue(v)
    end
    self._retrydata = nil
    GleeCore.retrySend()
  end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DDisconnectNotice, "DDisconnectNotice")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DDisconnectNotice", DDisconnectNotice)
