local Config = require "Config"
local Res = require 'Res'

local DAServerNotice = class(LuaDialog)

function DAServerNotice:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DAServerNotice.cocos.zip")
    return self._factory:createDocument("DAServerNotice.cocos")
end

--@@@@[[[[
function DAServerNotice:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg = set:getElfNode("root_bg")
   self._root_btnOne = set:getClickNode("root_btnOne")
   self._root_tbg = set:getElfNode("root_tbg")
   self._root_title = set:getLabelNode("root_title")
   self._root_webrect = set:getElfNode("root_webrect")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DAServerNotice:onInit( userData, netData )

  self._root_title:setString(userData and userData.title or '全服公告')
  print(userData)
  Res.doActionDialogShow(self._root,function ( ... )
    self:updateURL( (userData and userData.Url ) or 'https://www.baidu.com/s?wd=%E5%8F%A3%E8%A2%8B%E8%81%94%E7%9B%9F')
  end)
  self._root_btnOne:setListener(function ( ... )
    self:closeWebView()
    Res.doActionDialogHide(self._root, self)
  end)


end

function DAServerNotice:onBack( userData, netData )
	
end

function DAServerNotice:close( ... )
  self:closeWebView()
end

--------------------------------custom code-----------------------------

function DAServerNotice:updateURL( url )
  local vsize = CCDirector:sharedDirector():getVisibleSize()  
  local size = self._root_webrect:getContentSize()
  size.height = size.height
  local pos = NodeHelper:getPositionInScreen(self._root_webrect)

  local x = pos.x - (size.width/2)
  local y = vsize.height-(pos.y + (size.height /2))

  if self._webview == nil then
    self._webview = WebView:getInstance()
    self._webview:addWebViewLogic(x,y,size.width,size.height)
  end

  self._webview:updateURL(url)
end


function DAServerNotice:closeWebView( ... )
  if self._webview then
      self._webview:removeWebView()
    end
  self._webview = nil
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DAServerNotice, "DAServerNotice")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DAServerNotice", DAServerNotice)
