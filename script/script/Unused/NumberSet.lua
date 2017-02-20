local config = require "Config"

local NumberSet = class(LuaController)

function NumberSet:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."NumberSet.cocos.zip")
    return self._factory:createDocument("NumberSet.cocos")
end

--@@@@[[[[  created at Wed May 14 17:19:47 CST 2014 By null
function NumberSet:onInitXML()
    local set = self._set
   self._ActionHurtValue = set:getElfAction("ActionHurtValue")
   self._ActionCureValue = set:getElfAction("ActionCureValue")
end
--@@@@]]]]

--------------------------------override functions----------------------
function NumberSet:onInit( userData, netData )
	
end

function NumberSet:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(NumberSet, "NumberSet")


--------------------------------register--------------------------------
GleeCore:registerLuaController("NumberSet", NumberSet)


