local Config = require "Config"
local res = require "Res"
local DTipNpc = class(LuaDialog)

function DTipNpc:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DTipNpc.cocos.zip")
    return self._factory:createDocument("DTipNpc.cocos")
end

--@@@@[[[[
function DTipNpc:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._bg1 = set:getJoint9Node("bg1")
   self._bg1_des = set:getLabelNode("bg1_des")
   self._bg1_btnClose = set:getClickNode("bg1_btnClose")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DTipNpc:onInit( userData, netData )
	res.doActionDialogShow(self._bg1)
	
	self._bg1_des:setString(userData.text)
	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._bg1, self)
	end)
	self._bg1_btnClose:setTriggleSound(res.Sound.back)
	self._bg1_btnClose:setListener(function (  )
		res.doActionDialogHide(self._bg1, self)
	end)
end

function DTipNpc:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DTipNpc, "DTipNpc")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DTipNpc", DTipNpc)
