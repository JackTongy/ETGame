local Config = require "Config"
require 'framework.net.Net'
local Indicator = require 'DIndicator'
local Res = require 'Res'
local Launcher = require 'Launcher'
local accounthelper = require 'AccountHelper'

local AutoSevenDay = false
local DNotice = class(LuaDialog)

Launcher.register('DNotice',function ( userData )
  if userData then
    AutoSevenDay = true
    Launcher.Launching(userData)
  else
    AutoSevenDay = false
    accounthelper.ACSMsgList(function ( datatable,tag,code,errorBuf )
        Launcher.Launching(datatable)
    end)
  end
end)

function DNotice:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DNotice.cocos.zip")
    return self._factory:createDocument("DNotice.cocos")
end

--@@@@[[[[
function DNotice:onInitXML()
	local set = self._set
    self._root = set:getElfNode("root")
    self._root_bg = set:getElfNode("root_bg")
    self._root_bg_bg2 = set:getJoint9Node("root_bg_bg2")
    self._root_bg_title = set:getElfNode("root_bg_title")
    self._root_bg_title_content = set:getLabelNode("root_bg_title_content")
    self._root_bg_list = set:getListNode("root_bg_list")
    self._tab = set:getTabNode("tab")
    self._tab_normal_name = set:getLabelNode("tab_normal_name")
    self._tab_pressed_name = set:getLabelNode("tab_pressed_name")
    self._state = set:getElfNode("state")
    self._root_bg_name = set:getLabelNode("root_bg_name")
    self._root_bg_dateTime = set:getLabelNode("root_bg_dateTime")
    self._root_bg_btnClose = set:getButtonNode("root_bg_btnClose")
--    self._@cell = set:getElfNode("@cell")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DNotice:onInit( userData, netData )
  Res.doActionDialogShow(self._root_bg, function()
    if netData then
      self._Msgs = netData
      self:updateLayer()
    else
      self:runWithDelay(function ( ... )
        self:getNoticeList()
      end,0.2)  
    end
  end)
  self._root_bg_btnClose:setListener(function ( ... )
    if self._webview then
      self._webview:removeWebView()
    end
    self._webview = nil
    Res.doActionDialogHide(self._root_bg, self)
    self:showSevenDay()
  end)
end

function DNotice:onBack( userData, netData )
	
end

function DNotice:close( ... )
  if self._webview then
    self._webview:removeWebView()
  end
  self._webview = nil
end

function DNotice:getNoticeList(  )
  --Indicator.show()
  accounthelper.ACSMsgList(function ( datatable,tag,code,errorBuf )
      --Indicator.hide()
      self._Msgs = datatable
      self:updateLayer()
  end)
end

function DNotice:showSevenDay( ... )
  if AutoSevenDay and require 'AppData'.getTaskLoginInfo().isSevenDayRewardActive() then
    GleeCore:showLayer('DSevenDayReward')
  end
  AutoSevenDay = false
end
--------------------------------custom code-----------------------------

function DNotice:updateLayer()
  if self._Msgs then
    self._root_bg_list:getContainer():removeAllChildrenWithCleanup(true)
    --sort announce
    table.sort(self._Msgs, function(msg1, msg2)
      if msg1.C ~= msg2.C then
        return msg1.C < msg2.C
      elseif msg1.State ~= msg2.State then
        return msg1.State < msg2.State
      elseif msg1.No ~= msg2.No then
        return msg1.No > msg2.No
      else
        return msg1.CreateAt > msg2.CreateAt
      end
    end)

    for i,v in ipairs(self._Msgs) do
      local luaset = self:createLuaSet('@cell')
      self._root_bg_list:getContainer():addChild(luaset[1])
      luaset['tab_normal_name']:setString(v.Title)
      luaset['tab_pressed_name']:setString(v.Title)

      if v.State == 0 then
        luaset['state']:setResid('N_GG_new.png')
      elseif v.State == 1 then
        luaset['state']:setResid('N_GG_hot.png')
      end
      --luaset['icon']:setResid(string.format('N_GG_juese%d.png', i % 5 + 1))
      luaset['tab']:setListener(function (  )
        self:selectNoticeItem(v)
      end)

      if i == 1 then
        luaset['tab']:trigger(nil)
        self._first = luaset[1]
      end

      if i == #self._Msgs then
        self._last = luaset[1]
      end

    end

    self._root_bg_list:layout()
  end
end

function DNotice:selectNoticeItem( msg )
  self:updateURL(accounthelper.getMsgUrl(msg.Id))--(string.format('http://dev.account.mosoga.net/Message/ListForClient/Detail/%d',msg.Id))
  self._root_bg_name:setString(msg.Title)

  local item0 = Res.Split(msg.CreateAt,' ')
  local item1 = Res.Split(item0[1],'-')
  local item2 = Res.Split(item0[2],':')
  self._root_bg_dateTime:setString(string.format('%s.%s %s:%s',item1[2],item1[3],item2[1],item2[2]))

  -- string.gsub(msg.CreateAt,'(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)',function ( YY,MM,DD,H,M,S )
  --   self._root_bg_dateTime:setString(string.format('%d.%d %d:%d',MM,DD,H,M))
  -- end)

end

function DNotice:updateURL( url )
  local vsize = CCDirector:sharedDirector():getVisibleSize()  
  local size = self._root_bg_bg2:getContentSize()
  size.height = size.height - 80
  local pos = NodeHelper:getPositionInScreen(self._root_bg_bg2)

  local x = pos.x - (size.width/2)
  local y = vsize.height-(pos.y + ((size.height - 48) /2))

  if self._webview == nil then
    self._webview = WebView:getInstance()
    self._webview:addWebViewLogic(x,y,size.width,size.height)
    if WebView:getInstance().clearHTTPHeaderField then
      WebView:getInstance():clearHTTPHeaderField();
      WebView:getInstance():setKeyValueforHTTPHeaderField("Accept-Language",string.lower(require 'script.info.Info'.LANG_NAME));
    end
  end

  self._webview:updateURL(url)
end

--[[
function DNotice:setTick( ... )
  -- body

  local listsize = self._root_bg_list:getContentSize()

  local  fUpdateTime = function ( ... )
    local  fisrt = self._first
    local last = self._last
    
    local firstPos = NodeHelper:getPositionInScreen(fisrt)
    local lastPos = NodeHelper:getPositionInScreen(last)
    local listPos = NodeHelper:getPositionInScreen(self._root_bg_list)

    local bShow = false
    local tShow = false
    if firstPos.y - listPos.y > listsize.height/2 then
      tShow = true
    end
  
    if lastPos.y - listPos.y < -listsize.height/2 then
      bShow = true
    end

    self._root_bg_arrow_bottom:setVisible(bShow)
    self._root_bg_arrow_top:setVisible(tShow)
  end

  if self.tick == nil and self.handle == nil then
    local tick = require 'framework.sync.TimerHelper'
      self.tick = tick
      self.handle = tick.tick(fUpdateTime,0.4)
  end

  fUpdateTime()

end

function DNotice:releaseTick(  )
   if self.handle and self.tick then
      self.tick.cancel(self.handle)
      self.tick = nil
      self.handle = nil
   end
end
]]

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DNotice, "DNotice")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DNotice", DNotice)
