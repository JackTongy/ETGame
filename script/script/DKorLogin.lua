local Config = require "Config"
local Res = require 'Res'

local DKorLogin = class(LuaDialog)

function DKorLogin:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DKorLogin.cocos.zip")
    return self._factory:createDocument("DKorLogin.cocos")
end

--@@@@[[[[
function DKorLogin:onInitXML()
    local set = self._set
   self._bgclick = set:getClickNode("bgclick")
   self._root = set:getElfNode("root")
   self._root_korAccount = set:getElfNode("root_korAccount")
   self._root_korAccount_title = set:getLabelNode("root_korAccount_title")
   self._root_korAccount_google = set:getClickNode("root_korAccount_google")
   self._root_korAccount_facebook = set:getClickNode("root_korAccount_facebook")
   self._root_korAccount_BindTip = set:getLabelNode("root_korAccount_BindTip")
   self._root_korAccount_guest = set:getClickNode("root_korAccount_guest")
   self._root_korAccount_titlebind = set:getLabelNode("root_korAccount_titlebind")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DKorLogin:onInit( userData, netData )
  Res.doActionDialogShow(self._root,function ( ... )
  
  end)

  self._bgclick:setListener(function ( ... )
     Res.doActionDialogHide(self._root, self)
  end)
  self._bgclick:setVisible(userData and userData.bind)
  
end

function DKorLogin:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DKorLogin, "DKorLogin")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DKorLogin", DKorLogin)
