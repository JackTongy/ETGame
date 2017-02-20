local Config = require "Config"
local Utils = require 'framework.helper.Utils'

local DLoginEnWechat = class(LuaDialog)

function DLoginEnWechat:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DLoginEnWechat.cocos.zip")
    return self._factory:createDocument("DLoginEnWechat.cocos")
end

--@@@@[[[[
function DLoginEnWechat:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_btnfb = set:getClickNode("root_btnfb")
   self._root_btnwechat = set:getClickNode("root_btnwechat")
   self._root_guest = set:getClickNode("root_guest")
   self._root_bg1 = set:getElfNode("root_bg1")
   self._root_bg1_checkbox = set:getCheckBoxNode("root_bg1_checkbox")
   self._root_bg1_tip = set:getRichLabelNode("root_bg1_tip")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DLoginEnWechat:onInit( userData, netData )
  self._root_btnfb:setListener(function ( ... )
    self:clickFB()
  end)	
  self._root_btnwechat:setListener(function ( ... )
    self:clickWeChat()
  end)
  self._root_guest:setListener(function ( ... )
    self:clickPlayNow()
  end)

  self._root_bg1_tip:setString('[color=0x000000ff]I have read and agree to the [color=0x5e9e3fff][link bg=00000000 bg_click=000000][u]Service[/u][/link][/color] and [color=0x5e9e3fff][link bg=00000000 bg_click=000000][u]Privacy Policy[/u][/link][/color][/color]')
  self._root_bg1_tip:setLinkTarget(0,CCCallFunc:create(function ( ... )
    WebView:getInstance():gotoURL('http://www.tencent.com/en-us/zc/termsofservice.shtml')
  end))  
  self._root_bg1_tip:setLinkTarget(1,CCCallFunc:create(function ( ... )
    WebView:getInstance():gotoURL('http://www.tencent.com/en-us/zc/privacypolicy.shtml')
  end))


  local idf = 'DLoginEnWechat'
  local record = Utils.readTableFromFile('DLoginEnWechat') or {}
  local used = record[idf]

  self._root_bg1_checkbox:setListener(function ( ... )
      self._root_btnfb:setEnabled(self._root_bg1_checkbox:getStateSelected())
      self._root_btnwechat:setEnabled(self._root_bg1_checkbox:getStateSelected())
      self._root_guest:setEnabled(self._root_bg1_checkbox:getStateSelected())
      
      record[idf] = self._root_bg1_checkbox:getStateSelected()
      Utils.writeTableToFile(record,recordfile)
  end)

  self._root_bg1_checkbox:setStateSelected(used)
  
end

function DLoginEnWechat:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DLoginEnWechat:clickFB( ... )
  -- body
end

function DLoginEnWechat:clickWeChat( ... )
  -- body
end

function DLoginEnWechat:clickPlayNow( ... )
  -- body
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DLoginEnWechat, "DLoginEnWechat")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DLoginEnWechat", DLoginEnWechat)
