local config = require "Config"

local ZhangQiang = class(LuaController)

function ZhangQiang:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."ZhangQiang.cocos.zip")
    return self._factory:createDocument("ZhangQiang.cocos")
end

--@@@@[[[[  created at Wed May 14 10:36:22 CST 2014 By null
function ZhangQiang:onInitXML()
    local set = self._set
   self._hero = set:getFlashMainNode("hero")
   self._hero_root = set:getElfNode("hero_root")
   self._hero_root_ShouZuo = set:getElfNode("hero_root_ShouZuo")
   self._hero_root_ShenQian = set:getElfNode("hero_root_ShenQian")
   self._hero_root_TuiYou = set:getElfNode("hero_root_TuiYou")
   self._hero_root_TuiZuo = set:getElfNode("hero_root_TuiZuo")
   self._hero_root_Tou = set:getElfNode("hero_root_Tou")
   self._hero_root_ShouYou = set:getElfNode("hero_root_ShouYou")
   self._hero_root_ShouYou_BuQiang = set:getElfNode("hero_root_ShouYou_BuQiang")
end
--@@@@]]]]

--------------------------------override functions----------------------
function ZhangQiang:onInit( userData, netData )
	
end

function ZhangQiang:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(ZhangQiang, "ZhangQiang")


--------------------------------register--------------------------------
GleeCore:registerLuaController("ZhangQiang", ZhangQiang)


