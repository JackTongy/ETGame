local config = require "Config"

local BloodBarSet = class(LuaController)

function BloodBarSet:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."BloodBarSet.cocos.zip")
    return self._factory:createDocument("BloodBarSet.cocos")
end

--@@@@[[[[
function BloodBarSet:onInitXML()
	local set = self._set
    self._bg = set:getElfNode("bg")
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
    self._se_colorRect = set:getElfNode("se_colorRect")
    self._upContainer = set:getElfNode("upContainer")
    self._name = set:getLabelNode("name")
    self._checkCircle = set:getElfNode("checkCircle")
    self._attackCircle = set:getElfNode("attackCircle")
    self._point = set:getRectangleNode("point")
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
    self._se_colorRect = set:getElfNode("se_colorRect")
    self._upContainer = set:getElfNode("upContainer")
    self._name = set:getLabelNode("name")
    self._checkCircle = set:getElfNode("checkCircle")
    self._attackCircle = set:getElfNode("attackCircle")
    self._point = set:getRectangleNode("point")
    self._label = set:getElfNode("label")
    self._clip_green = set:getElfNode("clip_green")
    self._clip_greenAnimate = set:getSimpleAnimateNode("clip_greenAnimate")
    self._clip_red = set:getElfNode("clip_red")
    self._clip_black = set:getElfNode("clip_black")
    self._star = set:getElfNode("star")
    self._star_normal = set:getElfNode("star_normal")
    self._star_twinkle = set:getSimpleAnimateNode("star_twinkle")
    self._clip_green = set:getElfNode("clip_green")
    self._clip_red = set:getElfNode("clip_red")
    self._clip_black = set:getElfNode("clip_black")
    self._clip_green = set:getElfNode("clip_green")
    self._clip_greenAnimate = set:getSimpleAnimateNode("clip_greenAnimate")
    self._clip_red = set:getElfNode("clip_red")
    self._clip_black = set:getElfNode("clip_black")
    self._star = set:getElfNode("star")
    self._star_normal = set:getElfNode("star_normal")
    self._star_twinkle = set:getSimpleAnimateNode("star_twinkle")
    self._fri = set:getElfNode("fri")
    self._clip_green = set:getElfNode("clip_green")
    self._clip_red = set:getElfNode("clip_red")
    self._clip_black = set:getElfNode("clip_black")
    self._clip_green = set:getElfNode("clip_green")
    self._clip_greenAnimate = set:getSimpleAnimateNode("clip_greenAnimate")
    self._clip_red = set:getElfNode("clip_red")
    self._clip_black = set:getElfNode("clip_black")
    self._star = set:getElfNode("star")
    self._star_normal = set:getElfNode("star_normal")
    self._star_twinkle = set:getSimpleAnimateNode("star_twinkle")
    self._progress = set:getProgressNode("progress")
    self._label = set:getLabelNode("label")
    self._bg = set:getElfNode("bg")
    self._career = set:getElfNode("career")
    self._hp = set:getProgressNode("hp")
    self._mana = set:getProgressNode("mana")
    self._point = set:getElfNode("point")
    self._fri = set:getElfNode("fri")
    self._label = set:getLabelNode("label")
    self._bg = set:getElfNode("bg")
    self._career = set:getElfNode("career")
    self._hp = set:getProgressNode("hp")
    self._mana = set:getProgressNode("mana")
    self._point = set:getElfNode("point")
    self._label = set:getLabelNode("label")
    self._bg = set:getElfNode("bg")
    self._career = set:getElfNode("career")
    self._hp = set:getProgressNode("hp")
    self._mana = set:getProgressNode("mana")
    self._point = set:getElfNode("point")
--    self._@hero = set:getElfNode("@hero")
--    self._@simple-hero = set:getFlashMainNode("@simple-hero")
--    self._@boss = set:getElfNode("@boss")
--    self._@simple-hero = set:getFlashMainNode("@simple-hero")
--    self._@BBNotFriend = set:getElfNode("@BBNotFriend")
--    self._@bbMonster = set:getElfNode("@bbMonster")
--    self._@BBFriend = set:getElfNode("@BBFriend")
--    self._@bbBoss = set:getElfNode("@bbBoss")
--    self._@BBHero = set:getElfNode("@BBHero")
--    self._@bbExp = set:getElfNode("@bbExp")
--    self._@bbHero = set:getElfNode("@bbHero")
--    self._@bbFriend = set:getElfNode("@bbFriend")
--    self._@bbNotFriend = set:getElfNode("@bbNotFriend")
end
--@@@@]]]]

--------------------------------override functions----------------------
function BloodBarSet:getNetModel()
	
end

function BloodBarSet:onInit( userData, netData )
	
end

function BloodBarSet:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(BloodBarSet, "BloodBarSet")


--------------------------------register--------------------------------
GleeCore:registerLuaController("BloodBarSet", BloodBarSet)


