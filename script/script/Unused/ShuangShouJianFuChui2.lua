local config = require "Config"

local ShuangShouJianFuChui2 = class(LuaController)

function ShuangShouJianFuChui2:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."ShuangShouJianFuChui2.cocos.zip")
    return self._factory:createDocument("ShuangShouJianFuChui2.cocos")
end

--@@@@[[[[  created at Thu May 15 14:13:50 CST 2014 By null
function ShuangShouJianFuChui2:onInitXML()
    local set = self._set
   self._hero = set:getFlashMainNode("hero")
   self._hero_root = set:getElfNode("hero_root")
   self._hero_root_TuiYou = set:getElfNode("hero_root_TuiYou")
   self._hero_root_TuiZuo = set:getElfNode("hero_root_TuiZuo")
   self._hero_root_ShenQian = set:getElfNode("hero_root_ShenQian")
   self._hero_root_ShouZuo = set:getElfNode("hero_root_ShouZuo")
   self._hero_root_ShouZuo_DanShouFu = set:getElfNode("hero_root_ShouZuo_DanShouFu")
   self._hero_root_Tou = set:getElfNode("hero_root_Tou")
   self._hero_root_ShouYou = set:getElfNode("hero_root_ShouYou")
   self._hero_WuQiShanGuang = set:getElfNode("hero_WuQiShanGuang")
   self._hero_Dao1 = set:getElfNode("hero_Dao1")
   self._hero_DaoPi = set:getElfNode("hero_DaoPi")
   self._hero_JiNeng = set:getElfNode("hero_JiNeng")
end
--@@@@]]]]

--------------------------------override functions----------------------
function ShuangShouJianFuChui2:onInit( userData, netData )
	
end

function ShuangShouJianFuChui2:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(ShuangShouJianFuChui2, "ShuangShouJianFuChui2")


--------------------------------register--------------------------------
GleeCore:registerLuaController("ShuangShouJianFuChui2", ShuangShouJianFuChui2)


