local config = require "Config"

local ShuangChiBiShou = class(LuaController)

function ShuangChiBiShou:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."ShuangChiBiShou.cocos.zip")
    return self._factory:createDocument("ShuangChiBiShou.cocos")
end

--@@@@[[[[  created at Wed May 14 10:35:40 CST 2014 By null
function ShuangChiBiShou:onInitXML()
    local set = self._set
   self._hero = set:getFlashMainNode("hero")
   self._hero_root = set:getElfNode("hero_root")
   self._hero_root_ShouZuo = set:getElfNode("hero_root_ShouZuo")
   self._hero_root_ShouZuo_BiShou = set:getElfNode("hero_root_ShouZuo_BiShou")
   self._hero_root_TuiYou = set:getElfNode("hero_root_TuiYou")
   self._hero_root_TuiZuo = set:getElfNode("hero_root_TuiZuo")
   self._hero_root_ShenQian = set:getElfNode("hero_root_ShenQian")
   self._hero_root_Tou = set:getElfNode("hero_root_Tou")
   self._hero_root_ShouYou = set:getElfNode("hero_root_ShouYou")
   self._hero_root_ShouYou_BiShou2 = set:getElfNode("hero_root_ShouYou_BiShou2")
end
--@@@@]]]]

--------------------------------override functions----------------------
function ShuangChiBiShou:onInit( userData, netData )
	
end

function ShuangChiBiShou:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(ShuangChiBiShou, "ShuangChiBiShou")


--------------------------------register--------------------------------
GleeCore:registerLuaController("ShuangChiBiShou", ShuangChiBiShou)


