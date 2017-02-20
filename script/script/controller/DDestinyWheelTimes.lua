local Config = require "Config"
local res = require "Res"


local DDestinyWheelTimes = class(LuaDialog)

function DDestinyWheelTimes:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DDestinyWheelTimes.cocos.zip")
    return self._factory:createDocument("DDestinyWheelTimes.cocos")
end

--@@@@[[[[
function DDestinyWheelTimes:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_layoutWheel = set:getLayoutNode("bg_layoutWheel")
    self._bg = set:getElfNode("bg")
    self._amt = set:getLabelNode("amt")
    self._keyAmt = set:getLabelNode("keyAmt")
    self._btnGo = set:getClickNode("btnGo")
--    self._@wheel = set:getElfNode("@wheel")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DDestinyWheelTimes:onInit( userData, netData )
	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_layoutWheel:removeAllChildrenWithCleanup(true)
	local timesList = {1, 10}
	for i=1,2 do
		local wheel = self:createLuaSet("@wheel")
		self._bg_layoutWheel:addChild(wheel[1])
		wheel["amt"]:setString(string.format(res.locString("Activity$DestinyWheelGoTimes"), timesList[i]))
		wheel["keyAmt"]:setString(timesList[i])
		wheel["btnGo"]:setEnabled(userData and userData.keyCount >= timesList[i] or false)
		wheel["btnGo"]:setListener(function ( ... )
			if userData and userData.callback then
				userData.callback(timesList[i])
				res.doActionDialogHide(self._bg, self)
			end
		end)
	end

	res.doActionDialogShow(self._bg)
end

function DDestinyWheelTimes:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DDestinyWheelTimes, "DDestinyWheelTimes")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DDestinyWheelTimes", DDestinyWheelTimes)


