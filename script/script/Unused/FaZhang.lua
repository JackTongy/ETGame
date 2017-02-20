local config = require "Config"

local FaZhang = class(LuaController)

function FaZhang:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."FaZhang.cocos.zip")
    return self._factory:createDocument("FaZhang.cocos")
end

--@@@@[[[[  created at Wed May 14 10:36:14 CST 2014 By null
function FaZhang:onInitXML()
    local set = self._set
   self._hero = set:getFlashMainNode("hero")
   self._hero_root = set:getElfNode("hero_root")
   self._hero_root_ShouZuo = set:getElfNode("hero_root_ShouZuo")
   self._hero_root_ShouZuo_MoZhang = set:getElfNode("hero_root_ShouZuo_MoZhang")
   self._hero_root_TuiYou = set:getElfNode("hero_root_TuiYou")
   self._hero_root_TuiZuo = set:getElfNode("hero_root_TuiZuo")
   self._hero_root_ShenQian = set:getElfNode("hero_root_ShenQian")
   self._hero_root_Tou = set:getElfNode("hero_root_Tou")
   self._hero_root_ShouYou = set:getElfNode("hero_root_ShouYou")
end
--@@@@]]]]

--------------------------------override functions----------------------
function FaZhang:onInit( userData, netData )
	
end

function FaZhang:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(FaZhang, "FaZhang")


--------------------------------register--------------------------------
GleeCore:registerLuaController("FaZhang", FaZhang)


