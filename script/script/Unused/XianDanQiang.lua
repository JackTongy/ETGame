local config = require "Config"

local XianDanQiang = class(LuaController)

function XianDanQiang:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."XianDanQiang.cocos.zip")
    return self._factory:createDocument("XianDanQiang.cocos")
end

--@@@@[[[[  created at Wed May 14 10:36:42 CST 2014 By null
function XianDanQiang:onInitXML()
    local set = self._set
   self._hero = set:getFlashMainNode("hero")
   self._hero_root = set:getElfNode("hero_root")
   self._hero_root_ShouZuo = set:getElfNode("hero_root_ShouZuo")
   self._hero_root_ShouZuo_XianDanQiang = set:getElfNode("hero_root_ShouZuo_XianDanQiang")
   self._hero_root_ShenQian = set:getElfNode("hero_root_ShenQian")
   self._hero_root_TuiYou = set:getElfNode("hero_root_TuiYou")
   self._hero_root_TuiZuo = set:getElfNode("hero_root_TuiZuo")
   self._hero_root_Tou = set:getElfNode("hero_root_Tou")
   self._hero_root_ShouYou = set:getElfNode("hero_root_ShouYou")
end
--@@@@]]]]

--------------------------------override functions----------------------
function XianDanQiang:onInit( userData, netData )
	
end

function XianDanQiang:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(XianDanQiang, "XianDanQiang")


--------------------------------register--------------------------------
GleeCore:registerLuaController("XianDanQiang", XianDanQiang)


