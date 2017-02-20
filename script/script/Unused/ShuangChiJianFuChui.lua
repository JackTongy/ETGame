local config = require "Config"

local ShuangChiJianFuChui = class(LuaController)

function ShuangChiJianFuChui:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."ShuangChiJianFuChui.cocos.zip")
    return self._factory:createDocument("ShuangChiJianFuChui.cocos")
end

--@@@@[[[[  created at Wed May 14 10:35:32 CST 2014 By null
function ShuangChiJianFuChui:onInitXML()
    local set = self._set
   self._hero = set:getFlashMainNode("hero")
   self._hero_root = set:getElfNode("hero_root")
   self._hero_root_ShouZuo = set:getElfNode("hero_root_ShouZuo")
   self._hero_root_ShouZuo_WuQiZuo = set:getElfNode("hero_root_ShouZuo_WuQiZuo")
   self._hero_root_ShenQian = set:getElfNode("hero_root_ShenQian")
   self._hero_root_TuiYou = set:getElfNode("hero_root_TuiYou")
   self._hero_root_TuiZuo = set:getElfNode("hero_root_TuiZuo")
   self._hero_root_Tou = set:getElfNode("hero_root_Tou")
   self._hero_root_ShouYou = set:getElfNode("hero_root_ShouYou")
   self._hero_root_ShouYou_WuQiYou = set:getElfNode("hero_root_ShouYou_WuQiYou")
end
--@@@@]]]]

--------------------------------override functions----------------------
function ShuangChiJianFuChui:onInit( userData, netData )
	
end

function ShuangChiJianFuChui:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(ShuangChiJianFuChui, "ShuangChiJianFuChui")


--------------------------------register--------------------------------
GleeCore:registerLuaController("ShuangChiJianFuChui", ShuangChiJianFuChui)


