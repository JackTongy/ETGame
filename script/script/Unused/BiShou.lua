local config = require "Config"

local BiShou = class(LuaController)

function BiShou:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."BiShou.cocos.zip")
    return self._factory:createDocument("BiShou.cocos")
end

--@@@@[[[[  created at Wed May 14 10:34:53 CST 2014 By null
function BiShou:onInitXML()
    local set = self._set
   self._hero = set:getFlashMainNode("hero")
   self._hero_root = set:getElfNode("hero_root")
   self._hero_root_ShouZuo = set:getElfNode("hero_root_ShouZuo")
   self._hero_root_ShouZuo_BiShou = set:getElfNode("hero_root_ShouZuo_BiShou")
   self._hero_root_ShenQian = set:getElfNode("hero_root_ShenQian")
   self._hero_root_TuiYou = set:getElfNode("hero_root_TuiYou")
   self._hero_root_TuiZuo = set:getElfNode("hero_root_TuiZuo")
   self._hero_root_Tou = set:getElfNode("hero_root_Tou")
   self._hero_root_ShouYou = set:getElfNode("hero_root_ShouYou")
end
--@@@@]]]]

--------------------------------override functions----------------------
function BiShou:onInit( userData, netData )
	
end

function BiShou:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(BiShou, "BiShou")


--------------------------------register--------------------------------
GleeCore:registerLuaController("BiShou", BiShou)


