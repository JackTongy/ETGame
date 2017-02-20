local Config = require "Config"
local Res = require 'Res'
local AccountHelper = require 'AccountHelper'
local EventCenter = require 'EventCenter'

local DQuestion = class(LuaDialog)

function DQuestion:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DQuestion.cocos.zip")
    return self._factory:createDocument("DQuestion.cocos")
end

--@@@@[[[[
function DQuestion:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg = set:getJoint9Node("root_bg")
   self._root_close = set:getButtonNode("root_close")
   self._root_c = set:getElfNode("root_c")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DQuestion:onInit( userData, netData )
	Res.doActionDialogShow(self._root,function ( ... )
    local url = self:getUrl(userData)
		self:updateURL(url)
	end)
  	self._root_close:setListener(function ( ... )
	    if self._webview then
	      self._webview:removeWebView()
	    end
	    Res.doActionDialogHide(self._root, self)
	end)

  if not userData or userData.qs then
    AccountHelper.ACSQS()
  end
end

function DQuestion:onBack( userData, netData )
	
end

function DQuestion:close( ... )
  local userData = self:getUserData()
  if not userData or userData.qs then
    AccountHelper.ACSQS()
  end
end

--------------------------------custom code-----------------------------

function DQuestion:getUrl( userData )
  if userData and userData.cz then
    return AccountHelper.ACSGetCZRewardUrl()
  elseif userData and userData.hk then
    return AccountHelper.ACSGetHKRewardUrl()
  else
    return AccountHelper.getQsUrl()
  end
end

function DQuestion:updateURL( url )

  local vsize = CCDirector:sharedDirector():getVisibleSize()  
  local size = self._root_c:getContentSize()
  local pos = NodeHelper:getPositionInScreen(self._root_c)

  local x = pos.x - (size.width/2)
  local y = vsize.height-(pos.y + (size.height/2))

  if self._webview == nil then
    self._webview = WebView:getInstance()
    self._webview:addWebViewLogic(x,y,size.width,size.height)
  end

  self._webview:updateURL(url)
  
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DQuestion, "DQuestion")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DQuestion", DQuestion)
