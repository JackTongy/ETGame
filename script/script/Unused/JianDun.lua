﻿local config = require "Config"

local JianDun = class(LuaController)

function JianDun:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."JianDun.cocos.zip")
    return self._factory:createDocument("JianDun.cocos")
end

--@@@@[[[[  created at Wed May 14 10:34:44 CST 2014 By null
function JianDun:onInitXML()
    local set = self._set
   self._hero = set:getFlashMainNode("hero")
   self._hero_root = set:getElfNode("hero_root")
   self._hero_root_ShouZuo = set:getElfNode("hero_root_ShouZuo")
   self._hero_root_ShouZuo_WuQiYou = set:getElfNode("hero_root_ShouZuo_WuQiYou")
   self._hero_root_TuiYou = set:getElfNode("hero_root_TuiYou")
   self._hero_root_TuiZuo = set:getElfNode("hero_root_TuiZuo")
   self._hero_root_ShenQian = set:getElfNode("hero_root_ShenQian")
   self._hero_root_Tou = set:getElfNode("hero_root_Tou")
   self._hero_root_ShouYou = set:getElfNode("hero_root_ShouYou")
   self._hero_root_ShouYou_Dun = set:getElfNode("hero_root_ShouYou_Dun")
end
--@@@@]]]]

--------------------------------override functions----------------------
function JianDun:onInit( userData, netData )
	
end

function JianDun:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(JianDun, "JianDun")


--------------------------------register--------------------------------
GleeCore:registerLuaController("JianDun", JianDun)


