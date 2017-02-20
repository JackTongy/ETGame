local config = require "Config"

local ZhangBing = class(LuaController)

function ZhangBing:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."ZhangBing.cocos.zip")
    return self._factory:createDocument("ZhangBing.cocos")
end

--@@@@[[[[  created at Wed May 14 10:36:31 CST 2014 By null
function ZhangBing:onInitXML()
    local set = self._set
   self._hero = set:getFlashMainNode("hero")
   self._hero_root = set:getElfNode("hero_root")
   self._hero_root_ShouZuo = set:getElfNode("hero_root_ShouZuo")
   self._hero_root_ShouZuo_Qiang = set:getElfNode("hero_root_ShouZuo_Qiang")
   self._hero_root_TuiYou = set:getElfNode("hero_root_TuiYou")
   self._hero_root_TuiZuo = set:getElfNode("hero_root_TuiZuo")
   self._hero_root_ShenQian = set:getElfNode("hero_root_ShenQian")
   self._hero_root_Tou = set:getElfNode("hero_root_Tou")
   self._hero_root_ShouYou = set:getElfNode("hero_root_ShouYou")
end
--@@@@]]]]

--------------------------------override functions----------------------
function ZhangBing:onInit( userData, netData )
	
end

function ZhangBing:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(ZhangBing, "ZhangBing")


--------------------------------register--------------------------------
GleeCore:registerLuaController("ZhangBing", ZhangBing)


