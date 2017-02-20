local Config = require "Config"

local Wish = class(LuaDialog)

function Wish:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."Wish.cocos.zip")
    return self._factory:createDocument("Wish.cocos")
end

--@@@@[[[[
function Wish:onInitXML()
    local set = self._set
   self._bg1_countLayout = set:getLinearLayoutNode("bg1_countLayout")
   self._bg1_pointBase = set:getElfNode("bg1_pointBase")
   self._sel = set:getElfNode("sel")
   self._day = set:getElfNode("day")
   self._bg1_layoutTitle_pre = set:getLabelNode("bg1_layoutTitle_pre")
   self._bg1_layoutTitle_title = set:getLabelNode("bg1_layoutTitle_title")
   self._bg1_rewardLayout = set:getLayoutNode("bg1_rewardLayout")
   self._icon = set:getElfNode("icon")
   self._name = set:getLabelNode("name")
   self._bg1_btnOk = set:getClickNode("bg1_btnOk")
   self._bg1_btnOk_text = set:getLabelNode("bg1_btnOk_text")
--   self._@view = set:getElfNode("@view")
--   self._@line = set:getElfNode("@line")
--   self._@line = set:getElfNode("@line")
--   self._@line = set:getElfNode("@line")
--   self._@line = set:getElfNode("@line")
--   self._@point = set:getElfNode("@point")
--   self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------

function Wish:onInit( userData, netData )
	
end

function Wish:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(Wish, "Wish")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("Wish", Wish)
