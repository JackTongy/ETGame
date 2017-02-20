local config = require "Config"

local HeroSet = class(LuaController)

function HeroSet:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."HeroSet.cocos.zip")
    return self._factory:createDocument("HeroSet.cocos")
end

--@@@@[[[[
function HeroSet:onInitXML()
	local set = self._set
    self._bg = set:getElfNode("bg")
    self._rect = set:getRectangleNode("rect")
    self._shape = set:getElfNode("shape")
    self._selectBox = set:getElfNode("selectBox")
    self._shader = set:getElfNode("shader")
    self._downContainer = set:getElfNode("downContainer")
    self._sb_hero = set:getElfNode("sb_hero")
    self._root = set:getElfNode("root")
    self._root_ShouZuo = set:getElfNode("root_ShouZuo")
    self._root_ShouZuo_skin_10wqy = set:getElfNode("root_ShouZuo_skin_10wqy")
    self._root_TuiYou = set:getElfNode("root_TuiYou")
    self._root_TuiZuo = set:getElfNode("root_TuiZuo")
    self._root_ShenQian = set:getElfNode("root_ShenQian")
    self._root_Tou = set:getElfNode("root_Tou")
    self._root_ShouYou = set:getElfNode("root_ShouYou")
    self._upContainer = set:getElfNode("upContainer")
    self._name = set:getLabelNode("name")
    self._label = set:getElfNode("label")
    self._shape = set:getElfNode("shape")
    self._selectBox = set:getElfNode("selectBox")
    self._shader = set:getElfNode("shader")
    self._downContainer = set:getElfNode("downContainer")
    self._sb_hero = set:getElfNode("sb_hero")
    self._root = set:getElfNode("root")
    self._root_ShouZuo = set:getElfNode("root_ShouZuo")
    self._root_ShouZuo_skin_10wqy = set:getElfNode("root_ShouZuo_skin_10wqy")
    self._root_TuiYou = set:getElfNode("root_TuiYou")
    self._root_TuiZuo = set:getElfNode("root_TuiZuo")
    self._root_ShenQian = set:getElfNode("root_ShenQian")
    self._root_Tou = set:getElfNode("root_Tou")
    self._root_ShouYou = set:getElfNode("root_ShouYou")
    self._upContainer = set:getElfNode("upContainer")
    self._name = set:getLabelNode("name")
    self._label = set:getElfNode("label")
    self._ActionTwinkle = set:getElfAction("ActionTwinkle")
    self._ActionSelectRectShow = set:getElfAction("ActionSelectRectShow")
    self._ActionLockTarget = set:getElfAction("ActionLockTarget")
    self._ActionSelectRectHide = set:getElfAction("ActionSelectRectHide")
    self._ActionHurtValue = set:getElfAction("ActionHurtValue")
    self._ActionCureValue = set:getElfAction("ActionCureValue")
    self._ActionBloodBarShow = set:getElfAction("ActionBloodBarShow")
    self._ActionBloodBarHide = set:getElfAction("ActionBloodBarHide")
    self._ActionHurtRed = set:getElfAction("ActionHurtRed")
    self._ActionShake = set:getElfAction("ActionShake")
    self._ActionDeadHide = set:getElfAction("ActionDeadHide")
    self._Blink2Visible = set:getElfAction("Blink2Visible")
    self._Blink2Invisible = set:getElfAction("Blink2Invisible")
--    self._@hero = set:getElfNode("@hero")
--    self._@simple-hero = set:getFlashMainNode("@simple-hero")
--    self._@boss = set:getElfNode("@boss")
--    self._@simple-hero = set:getFlashMainNode("@simple-hero")
--    self._@showName = set:getLabelNode("@showName")
end
--@@@@]]]]

--------------------------------override functions----------------------
function HeroSet:getNetModel()
	
end

function HeroSet:onInit( userData, netData )
	
end

function HeroSet:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(HeroSet, "HeroSet")


--------------------------------register--------------------------------
GleeCore:registerLuaController("HeroSet", HeroSet)


