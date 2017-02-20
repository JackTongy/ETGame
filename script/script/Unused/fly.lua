local config = require "Config"

local fly = class(LuaController)

function fly:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."fly.cocos.zip")
    return self._factory:createDocument("fly.cocos")
end

--@@@@[[[[  created at Wed May 28 14:11:25 CST 2014 By null
function fly:onInitXML()
    local set = self._set
   self._fly-010 = set:getElfNode("fly-010")
   self._fly-010_animate = set:getSimpleAnimateNode("fly-010_animate")
end
--@@@@]]]]

--------------------------------override functions----------------------
function fly:onInit( userData, netData )
	
end

function fly:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(fly, "fly")


--------------------------------register--------------------------------
GleeCore:registerLuaController("fly", fly)


