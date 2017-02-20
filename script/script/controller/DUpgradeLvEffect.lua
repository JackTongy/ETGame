local Config = require "Config"
local Res = require 'Res'
local DBManager = require 'DBManager'
--local dbManager = require 'DBManager'

local DUpgradeLvEffect = class(LuaDialog)

function DUpgradeLvEffect:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DUpgradeLvEffect.cocos.zip")
    return self._factory:createDocument("DUpgradeLvEffect.cocos")
end

--@@@@[[[[
function DUpgradeLvEffect:onInitXML()
    local set = self._set
   self._rect = set:getRectangleNode("rect")
   self._root = set:getElfNode("root")
   self._root_bgclick = set:getClickNode("root_bgclick")
   self._root_light = set:getElfNode("root_light")
   self._root_line = set:getElfNode("root_line")
   self._root_title = set:getElfNode("root_title")
   self._root_lvup = set:getJoint9Node("root_lvup")
   self._root_lvup_oldpet = set:getElfNode("root_lvup_oldpet")
   self._root_lvup_oldpet_pzbg = set:getElfNode("root_lvup_oldpet_pzbg")
   self._root_lvup_oldpet_frame = set:getElfNode("root_lvup_oldpet_frame")
   self._root_lvup_oldpet_pz = set:getElfNode("root_lvup_oldpet_pz")
   self._root_lvup_name = set:getLabelNode("root_lvup_name")
   self._root_lvup_starLayout = set:getLayoutNode("root_lvup_starLayout")
   self._root_lvup_lv = set:getElfNode("root_lvup_lv")
   self._root_lvup_lv_oldv = set:getLabelNode("root_lvup_lv_oldv")
   self._root_lvup_lv_newv = set:getLabelNode("root_lvup_lv_newv")
   self._root_lvup_atk = set:getElfNode("root_lvup_atk")
   self._root_lvup_atk_oldv = set:getLabelNode("root_lvup_atk_oldv")
   self._root_lvup_atk_newv = set:getLabelNode("root_lvup_atk_newv")
   self._root_lvup_hp = set:getElfNode("root_lvup_hp")
   self._root_lvup_hp_oldv = set:getLabelNode("root_lvup_hp_oldv")
   self._root_lvup_hp_newv = set:getLabelNode("root_lvup_hp_newv")
   self._root_upgrade = set:getJoint9Node("root_upgrade")
   self._root_upgrade_oldpet = set:getElfNode("root_upgrade_oldpet")
   self._root_upgrade_oldpet_pzbg = set:getElfNode("root_upgrade_oldpet_pzbg")
   self._root_upgrade_oldpet_frame = set:getElfNode("root_upgrade_oldpet_frame")
   self._root_upgrade_oldpet_pz = set:getElfNode("root_upgrade_oldpet_pz")
   self._root_upgrade_name = set:getLabelNode("root_upgrade_name")
   self._root_upgrade_starLayout = set:getLayoutNode("root_upgrade_starLayout")
   self._root_upgrade_grade = set:getElfNode("root_upgrade_grade")
   self._root_upgrade_grade_oldv = set:getLabelNode("root_upgrade_grade_oldv")
   self._root_upgrade_grade_newv = set:getLabelNode("root_upgrade_grade_newv")
   self._root_upgrade_grade_oldi = set:getElfNode("root_upgrade_grade_oldi")
   self._root_upgrade_grade_newi = set:getElfNode("root_upgrade_grade_newi")
   self._root_upgrade_lvcap = set:getElfNode("root_upgrade_lvcap")
   self._root_upgrade_lvcap_oldv = set:getLabelNode("root_upgrade_lvcap_oldv")
   self._root_upgrade_lvcap_newv = set:getLabelNode("root_upgrade_lvcap_newv")
   self._rightIn = set:getElfAction("rightIn")
   self._scaleout = set:getElfAction("scaleout")
   self._rotate = set:getElfAction("rotate")
   self._leftIn = set:getElfAction("leftIn")
--   self._@star = set:getElfNode("@star")
--   self._@star = set:getElfNode("@star")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DUpgradeLvEffect:onInit( userData, netData )
	--[[
        userData:{lv=true,grade=true,oldpet,newpet}
    ]]

    self._root_lvup:setVisible(userData.lv)
    self._root_upgrade:setVisible(userData.grade)
    if userData.lv then
        self:LvUp(userData.oldpet,userData.newpet)
    elseif userData.grade then
        self:Upgrade(userData.oldpet,userData.newpet)
    end

    self._root_bgclick:setListener(function ( ... )
        self:close()
    end)
    self._root_bgclick:setVisible(false)
end

function DUpgradeLvEffect:onBack( userData, netData )
	
end

function DUpgradeLvEffect:close( ... )
    local userData = self:getUserData()
    return userData and userData.callback and userData.callback()
end

--------------------------------custom code-----------------------------

function DUpgradeLvEffect:LvUp( oldpet,newpet )

    local dbPet = DBManager.getCharactor(oldpet.PetId)
    self._root_lvup_name:setString(tostring(dbPet.name))
  
    require 'PetNodeHelper'.updateStarLayout(self._root_lvup_starLayout,dbPet,nil,true)

    self._root_lvup_lv_oldv:setString(tostring(oldpet.Lv))
    self._root_lvup_atk_oldv:setString(tostring(oldpet.Atk))
    self._root_lvup_hp_oldv:setString(tostring(oldpet.Hp))
    self._root_lvup_lv_newv:setString(tostring(newpet.Lv))
    self._root_lvup_atk_newv:setString(tostring(newpet.Atk))
    self._root_lvup_hp_newv:setString(tostring(newpet.Hp))
    self._root_lvup_oldpet_frame:setResid(Res.getPetIcon(newpet.PetId))
    self._root_lvup_oldpet_pz:setResid(Res.getPetPZ(newpet.AwakeIndex))
    
    self:runAction('SJ_wenzi1.png',self._root_lvup)
    require 'LangAdapter'.LabelNodeAutoShrink(self._root_lvup_lv_oldv,100)
    require 'LangAdapter'.LabelNodeAutoShrink(self._root_lvup_atk_oldv,100)
    require 'LangAdapter'.LabelNodeAutoShrink(self._root_lvup_hp_oldv,100)
    require 'LangAdapter'.LabelNodeAutoShrink(self._root_lvup_lv_newv,100)
    require 'LangAdapter'.LabelNodeAutoShrink(self._root_lvup_atk_newv,100)
    require 'LangAdapter'.LabelNodeAutoShrink(self._root_lvup_hp_newv,100)

end

function DUpgradeLvEffect:Upgrade( oldpet,newpet )
    local dbPet = DBManager.getCharactor(oldpet.PetId)
    self._root_upgrade_name:setString(tostring(dbPet.name))
    self._root_upgrade_oldpet_frame:setResid(Res.getPetIcon(newpet.PetId))
    self._root_upgrade_oldpet_pz:setResid(Res.getPetPZ(newpet.AwakeIndex))
    for i=1, dbPet.star_level do
      local star = self:createLuaSet("@star")
      self._root_upgrade_starLayout:addChild(star[1])
    end    

    local grade = oldpet.Grade
    grade = ((grade == nil or grade == 0) and 1) or grade
    local gradecfg = DBManager.getPetGradeConfig(grade)

    self._root_upgrade_grade_oldi:setResid(Res.getGradeIcon(grade))
    self._root_upgrade_grade_oldv:setString(tostring(gradecfg.Name))
    self._root_upgrade_lvcap_oldv:setString(tostring(gradecfg.PetLvCap))

    grade = newpet.Grade
    grade = ((grade == nil or grade == 0) and 1) or grade
    gradecfg = DBManager.getPetGradeConfig(grade)

    self._root_upgrade_grade_newi:setResid(Res.getGradeIcon(grade))
    self._root_upgrade_grade_newv:setString(tostring(gradecfg.Name))
    self._root_upgrade_lvcap_newv:setString(tostring(gradecfg.PetLvCap))

    require 'LangAdapter'.LabelNodeAutoShrink(self._root_upgrade_grade_oldv,50)
    require 'LangAdapter'.LabelNodeAutoShrink(self._root_upgrade_grade_newv,100)

    self:runAction('SJ_wenzi2.png',self._root_upgrade)
end

function DUpgradeLvEffect:runAction( resid,bgnode )
    self._root_title:setResid(resid)
    self._root_line:setPosition(ccp(-980.0,128.0))
    self._root_title:setPosition(ccp(1466.0,128.0))
    self._root_light:setScale(0)
    self._root_line:runElfAction(self._leftIn:clone())
    self._root_title:runElfAction(self._rightIn:clone())
    bgnode:setScale(0)
    bgnode:runElfAction(self._scaleout:clone())

    local lightaction = self._scaleout:clone()
    lightaction:setListener(function ( ... )
        self._root_light:runElfAction(self._rotate:clone()) 
        self._root_bgclick:setVisible(true)
    end)
    self._root_light:runElfAction(lightaction)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DUpgradeLvEffect, "DUpgradeLvEffect")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DUpgradeLvEffect", DUpgradeLvEffect)

