local config = require "Config"

local role-010 = class(LuaController)

function role-010:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."role-010.cocos.zip")
    return self._factory:createDocument("role-010.cocos")
end

--@@@@[[[[  created at Thu May 29 15:10:58 CST 2014 By null
function role-010:onInitXML()
    local set = self._set
   self._hero = set:getFlashMainNode("hero")
   self._hero_root = set:getElfNode("hero_root")
   self._hero_root_ShouZuo = set:getElfNode("hero_root_ShouZuo")
   self._hero_root_ShouZuo_skin_10wqy = set:getElfNode("hero_root_ShouZuo_skin_10wqy")
   self._hero_root_TuiYou = set:getElfNode("hero_root_TuiYou")
   self._hero_root_TuiZuo = set:getElfNode("hero_root_TuiZuo")
   self._hero_root_ShenQian = set:getElfNode("hero_root_ShenQian")
   self._hero_root_Tou = set:getElfNode("hero_root_Tou")
   self._hero_root_ShouYou = set:getElfNode("hero_root_ShouYou")
end
--@@@@]]]]

--------------------------------override functions----------------------
function role-010:onInit( userData, netData )
	
end

function role-010:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(role-010, "role-010")


--------------------------------register--------------------------------
GleeCore:registerLuaController("role-010", role-010)


