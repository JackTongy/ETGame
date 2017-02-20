local Config = require "Config"
local res = require "Res"

local DSoulPot = class(LuaDialog)

function DSoulPot:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DSoulPot.cocos.zip")
    return self._factory:createDocument("DSoulPot.cocos")
end

--@@@@[[[[
function DSoulPot:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_title = set:getLabelNode("bg_title")
    self._bg_content = set:getRichLabelNode("bg_content")
    self._bg_layout1_step = set:getLabelNode("bg_layout1_step")
    self._bg_layout2_soul = set:getLabelNode("bg_layout2_soul")
    self._bg_btnOk = set:getClickNode("bg_btnOk")
    self._bg_btnOk_title = set:getLabelNode("bg_btnOk_title")
    self._bg_btnCanel = set:getClickNode("bg_btnCanel")
    self._bg_btnCanel_title = set:getLabelNode("bg_btnCanel_title")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DSoulPot:onInit( userData, netData )
	res.doActionDialogShow(self._bg)

	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)
	
	if userData.PotType == 1 or userData.PotType == 2 then
		self._bg_content:setString(res.locString(string.format("Dungeon$SoulPotTip%d", userData.PotType)))
	end
	self._bg_layout1_step:setString(userData.PotLeft)
	self._bg_layout2_soul:setString(userData.soul)
	self._bg_btnOk:setEnabled(userData.soul > 0)
	self._bg_btnOk:setTriggleSound(res.Sound.yes)
	self._bg_btnOk:setListener(function ( ... )
		if userData.callback then
			userData.callback()
			res.doActionDialogHide(self._bg, self)
		end
	end)
	self._bg_btnCancel:setTriggleSound(res.Sound.back)
	self._bg_btnCancel:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)
end

function DSoulPot:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DSoulPot, "DSoulPot")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DSoulPot", DSoulPot)
