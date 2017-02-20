local Config = require "Config"

local RoastDuck = class(LuaController)

function RoastDuck:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."RoastDuck.cocos.zip")
    return self._factory:createDocument("RoastDuck.cocos")
end

--@@@@[[[[
function RoastDuck:onInitXML()
	local set = self._set
    self._bg_duck = set:getElfNode("bg_duck")
    self._bg_eatBtn = set:getClickNode("bg_eatBtn")
    self._bg_eatBtn_label = set:getLabelNode("bg_eatBtn_label")
    self._bg_fire = set:getElfNode("bg_fire")
    self._bg_double = set:getElfNode("bg_double")
--    self._@view = set:getElfNode("@view")
end
--@@@@]]]]

--------------------------------override functions----------------------
function RoastDuck:onInit( userData, netData )
	
end

function RoastDuck:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(RoastDuck, "RoastDuck")


--------------------------------register--------------------------------
GleeCore:registerLuaController("RoastDuck", RoastDuck)


