local Config = require "Config"

local Notification = class(LuaController)

function Notification:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."Notification.cocos.zip")
    return self._factory:createDocument("Notification.cocos")
end

--@@@@[[[[
function Notification:onInitXML()
	local set = self._set
    self._bg = set:getElfNode("bg")
    self._clip = set:getClipNode("clip")
    self._btn = set:getClickNode("btn")
--    self._@notification = set:getElfNode("@notification")
--    self._@label = set:getRichLabelNode("@label")
end
--@@@@]]]]

--------------------------------override functions----------------------
function Notification:onInit( userData, netData )
	
end

function Notification:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(Notification, "Notification")


--------------------------------register--------------------------------
GleeCore:registerLuaController("Notification", Notification)


