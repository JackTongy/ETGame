local Config = require "Config"
local res = require "Res"

local DWell = class(LuaDialog)

function DWell:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DWell.cocos.zip")
    return self._factory:createDocument("DWell.cocos")
end

--@@@@[[[[
function DWell:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_title = set:getLabelNode("bg_title")
    self._bg_content = set:getRichLabelNode("bg_content")
    self._bg_btnOk = set:getClickNode("bg_btnOk")
    self._bg_btnOk_title = set:getLabelNode("bg_btnOk_title")
    self._bg_btnCancel = set:getClickNode("bg_btnCancel")
    self._bg_btnCancel_title = set:getLabelNode("bg_btnCancel_title")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DWell:onInit( userData, netData )
	res.doActionDialogShow(self._bg)

	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)
	self._bg_content:setString(userData.content)
	self._bg_btnOk:setTriggleSound(res.Sound.yes)
	self._bg_btnOk:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
		if userData.callback then
			userData.callback()
		end
	end)
	self._bg_btnCancel:setTriggleSound(res.Sound.back)
	self._bg_btnCancel:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)
end

function DWell:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DWell, "DWell")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DWell", DWell)
