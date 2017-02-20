local Config = require "Config"

local role-160 = class(LuaController)

function role-160:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."role-160.cocos.zip")
    return self._factory:createDocument("role-160.cocos")
end

--@@@@[[[[
function role-160:onInitXML()
    local set = self._set
   self._hero = set:getFlashMainNode("hero")
   self._hero_root = set:getElfNode("hero_root")
   self._hero_root_ShouZuo = set:getElfNode("hero_root_ShouZuo")
   self._hero_root_TuiYou = set:getElfNode("hero_root_TuiYou")
   self._hero_root_TuiZuo = set:getElfNode("hero_root_TuiZuo")
   self._hero_root_ShenQian = set:getElfNode("hero_root_ShenQian")
   self._hero_root_Tou = set:getElfNode("hero_root_Tou")
   self._hero_root_ShouYou = set:getElfNode("hero_root_ShouYou")
end
--@@@@]]]]

--------------------------------override functions----------------------
function role-160:onInit( userData, netData )
	
end

function role-160:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(role-160, "role-160")


--------------------------------register--------------------------------
GleeCore:registerLuaController("role-160", role-160)


