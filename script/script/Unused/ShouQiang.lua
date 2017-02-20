local config = require "Config"

local ShouQiang = class(LuaController)

function ShouQiang:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."ShouQiang.cocos.zip")
    return self._factory:createDocument("ShouQiang.cocos")
end

--@@@@[[[[  created at Wed May 14 10:35:57 CST 2014 By null
function ShouQiang:onInitXML()
    local set = self._set
   self._hero = set:getFlashMainNode("hero")
   self._hero_root = set:getElfNode("hero_root")
   self._hero_root_ShouZuo = set:getElfNode("hero_root_ShouZuo")
   self._hero_root_ShouZuo_ShouQiang = set:getElfNode("hero_root_ShouZuo_ShouQiang")
   self._hero_root_TuiYou = set:getElfNode("hero_root_TuiYou")
   self._hero_root_TuiZuo = set:getElfNode("hero_root_TuiZuo")
   self._hero_root_ShenQian = set:getElfNode("hero_root_ShenQian")
   self._hero_root_Tou = set:getElfNode("hero_root_Tou")
   self._hero_root_ShouYou = set:getElfNode("hero_root_ShouYou")
end
--@@@@]]]]

--------------------------------override functions----------------------
function ShouQiang:onInit( userData, netData )
	
end

function ShouQiang:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(ShouQiang, "ShouQiang")


--------------------------------register--------------------------------
GleeCore:registerLuaController("ShouQiang", ShouQiang)


