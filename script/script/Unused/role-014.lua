local config = require "Config"

local role-014 = class(LuaController)

function role-014:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."role-014.cocos.zip")
    return self._factory:createDocument("role-014.cocos")
end

--@@@@[[[[  created at Thu May 29 15:11:17 CST 2014 By null
function role-014:onInitXML()
    local set = self._set
   self._hero = set:getFlashMainNode("hero")
   self._hero_root = set:getElfNode("hero_root")
   self._hero_root_ShouZuo = set:getElfNode("hero_root_ShouZuo")
   self._hero_root_ShouZuo_DanShouFu = set:getElfNode("hero_root_ShouZuo_DanShouFu")
   self._hero_root_TuiYou = set:getElfNode("hero_root_TuiYou")
   self._hero_root_TuiZuo = set:getElfNode("hero_root_TuiZuo")
   self._hero_root_ShenQian = set:getElfNode("hero_root_ShenQian")
   self._hero_root_ShouYou = set:getElfNode("hero_root_ShouYou")
   self._hero_root_Tou = set:getElfNode("hero_root_Tou")
end
--@@@@]]]]

--------------------------------override functions----------------------
function role-014:onInit( userData, netData )
	
end

function role-014:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(role-014, "role-014")


--------------------------------register--------------------------------
GleeCore:registerLuaController("role-014", role-014)


