local Config = require "Config"

local MyFirstMap = class(LuaDialog)

function MyFirstMap:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."MyFirstMap.cocos.zip")
    return self._factory:createDocument("MyFirstMap.cocos")
end

--@@@@[[[[
function MyFirstMap:onInitXML()
    local set = self._set
   self._map_container_bg_linearlayout_bg_maincity_q_5 = set:getElfNode("map_container_bg_linearlayout_bg_maincity_q_5")
   self._map_container_bg_linearlayout_linearlayout_bg_maincity_q_6 = set:getElfNode("map_container_bg_linearlayout_linearlayout_bg_maincity_q_6")
   self._map_container_bg_linearlayout_linearlayout_bg_maincity_q_7 = set:getElfNode("map_container_bg_linearlayout_linearlayout_bg_maincity_q_7")
   self._map_container_bg_linearlayout_linearlayout_bg_maincity_q_8 = set:getElfNode("map_container_bg_linearlayout_linearlayout_bg_maincity_q_8")
   self._map_container_bg_linearlayout_linearlayout_bg_maincity_q_9 = set:getElfNode("map_container_bg_linearlayout_linearlayout_bg_maincity_q_9")
   self._map_container_bg_linearlayout_linearlayout_bg_maincity_q_10 = set:getElfNode("map_container_bg_linearlayout_linearlayout_bg_maincity_q_10")
   self._map_container_bg_btnArean = set:getClickNode("map_container_bg_btnArean")
   self._map_container_bg_btnArean_arean = set:getFlashMainNode("map_container_bg_btnArean_arean")
end
--@@@@]]]]

--------------------------------override functions----------------------

function MyFirstMap:onInit( userData, netData )
	
end

function MyFirstMap:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(MyFirstMap, "MyFirstMap")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("MyFirstMap", MyFirstMap)
