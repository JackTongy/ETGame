local config = require "Config"

local BuffSet = class(LuaController)

function BuffSet:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."BuffSet.cocos.zip")
    return self._factory:createDocument("BuffSet.cocos")
end

--@@@@[[[[  created at Tue May 20 17:32:11 CST 2014 By null
function BuffSet:onInitXML()
    local set = self._set
   self._effect = set:getSimpleAnimateNode("effect")
   self._name = set:getElfNode("name")
   self._effect = set:getSimpleAnimateNode("effect")
   self._name = set:getElfNode("name")
   self._effect = set:getSimpleAnimateNode("effect")
   self._name = set:getElfNode("name")
   self._effect = set:getSimpleAnimateNode("effect")
   self._name = set:getElfNode("name")
   self._effect = set:getSimpleAnimateNode("effect")
   self._name = set:getElfNode("name")
   self._effect = set:getSimpleAnimateNode("effect")
   self._name = set:getElfNode("name")
--   self._@buff38 = set:getElfNode("@buff38")
--   self._@buff40 = set:getElfNode("@buff40")
--   self._@buff41 = set:getElfNode("@buff41")
--   self._@buff42 = set:getElfNode("@buff42")
--   self._@buff43 = set:getElfNode("@buff43")
--   self._@buff44 = set:getElfNode("@buff44")
end
--@@@@]]]]

--------------------------------override functions----------------------
function BuffSet:onInit( userData, netData )
	
end

function BuffSet:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(BuffSet, "BuffSet")


--------------------------------register--------------------------------
GleeCore:registerLuaController("BuffSet", BuffSet)


