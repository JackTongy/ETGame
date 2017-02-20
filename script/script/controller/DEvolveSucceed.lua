local Config = require "Config"
local Res = require 'Res'
local DBManager = require "DBManager"

local DEvolveSucceed = class(LuaDialog)

function DEvolveSucceed:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DEvolveSucceed.cocos.zip")
    return self._factory:createDocument("DEvolveSucceed.cocos")
end

--@@@@[[[[
function DEvolveSucceed:onInitXML()
    local set = self._set
   self._rect = set:getRectangleNode("rect")
   self._root = set:getElfNode("root")
   self._root_bgclick = set:getClickNode("root_bgclick")
   self._root_light = set:getElfNode("root_light")
   self._root_line = set:getElfNode("root_line")
   self._root_title = set:getElfNode("root_title")
   self._root_evolve = set:getJoint9Node("root_evolve")
   self._root_evolve_pet = set:getElfNode("root_evolve_pet")
   self._root_evolve_pet_bg = set:getElfNode("root_evolve_pet_bg")
   self._root_evolve_pet_icon = set:getElfNode("root_evolve_pet_icon")
   self._root_evolve_pet_frame = set:getElfNode("root_evolve_pet_frame")
   self._root_evolve_name = set:getLabelNode("root_evolve_name")
   self._root_evolve_quality = set:getLabelNode("root_evolve_quality")
   self._root_evolve_starLayout = set:getLayoutNode("root_evolve_starLayout")
   self._root_evolve_starLayout_star1 = set:getElfNode("root_evolve_starLayout_star1")
   self._root_evolve_starLayout_star2 = set:getElfNode("root_evolve_starLayout_star2")
   self._root_evolve_starLayout_star3 = set:getElfNode("root_evolve_starLayout_star3")
   self._root_evolve_starLayout_star4 = set:getElfNode("root_evolve_starLayout_star4")
   self._root_evolve_starLayout_star5 = set:getElfNode("root_evolve_starLayout_star5")
   self._root_evolve_starLayout_star6 = set:getElfNode("root_evolve_starLayout_star6")
   self._root_evolve_HP_value = set:getLabelNode("root_evolve_HP_value")
   self._root_evolve_ATK_value = set:getLabelNode("root_evolve_ATK_value")
   self._root_evolve_Defense_value = set:getLabelNode("root_evolve_Defense_value")
   self._root_evolve_HPGrowth_value = set:getLabelNode("root_evolve_HPGrowth_value")
   self._root_evolve_ATKGrowth_value = set:getLabelNode("root_evolve_ATKGrowth_value")
   self._root_evolve_skillLayout = set:getLinearLayoutNode("root_evolve_skillLayout")
   self._root_evolve_skillLayout_skill1 = set:getColorClickNode("root_evolve_skillLayout_skill1")
   self._root_evolve_skillLayout_skill1_normal_bg = set:getElfNode("root_evolve_skillLayout_skill1_normal_bg")
   self._root_evolve_skillLayout_skill1_normal_name = set:getLabelNode("root_evolve_skillLayout_skill1_normal_name")
   self._root_evolve_skillLayout_skill1_normal_level = set:getLabelNode("root_evolve_skillLayout_skill1_normal_level")
   self._root_evolve_skillLayout_skill2 = set:getColorClickNode("root_evolve_skillLayout_skill2")
   self._root_evolve_skillLayout_skill2_normal_bg = set:getElfNode("root_evolve_skillLayout_skill2_normal_bg")
   self._root_evolve_skillLayout_skill2_normal_name = set:getLabelNode("root_evolve_skillLayout_skill2_normal_name")
   self._root_evolve_skillLayout_skill2_normal_level = set:getLabelNode("root_evolve_skillLayout_skill2_normal_level")
   self._root_evolve_skillLayout_skill3 = set:getColorClickNode("root_evolve_skillLayout_skill3")
   self._root_evolve_skillLayout_skill3_normal_bg = set:getElfNode("root_evolve_skillLayout_skill3_normal_bg")
   self._root_evolve_skillLayout_skill3_normal_name = set:getLabelNode("root_evolve_skillLayout_skill3_normal_name")
   self._root_evolve_skillLayout_skill3_normal_level = set:getLabelNode("root_evolve_skillLayout_skill3_normal_level")
   self._root_evolve_skillLayout_skill4 = set:getColorClickNode("root_evolve_skillLayout_skill4")
   self._root_evolve_skillLayout_skill4_normal_bg = set:getElfNode("root_evolve_skillLayout_skill4_normal_bg")
   self._root_evolve_skillLayout_skill4_normal_name = set:getLabelNode("root_evolve_skillLayout_skill4_normal_name")
   self._root_evolve_skillLayout_skill4_normal_level = set:getLabelNode("root_evolve_skillLayout_skill4_normal_level")
   self._rightIn = set:getElfAction("rightIn")
   self._scaleout = set:getElfAction("scaleout")
   self._rotate = set:getElfAction("rotate")
   self._leftIn = set:getElfAction("leftIn")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DEvolveSucceed:onInit( userData, netData )
	self._root_bgclick:setListener(function ( ... )
        self:close()
    end)

  self:updateView(userData.pet)
end

function DEvolveSucceed:onBack( userData, netData )
	
end

function DEvolveSucceed:updateView(pet)
    local charactor = DBManager.getCharactor(pet.PetId)

    self._root_evolve_pet_icon:setResid(Res.getPetIcon(charactor.id))
    self._root_evolve_pet_frame:setResid(Res.getPetIconFrame(pet))
    self._root_evolve_name:setString(charactor.name)
    self._root_evolve_quality:setString(string.format('%s %d', Res.locString("Evolution$_Quality"), charactor.quality))

    for i = 1, 6 do
        if i <= charactor.star_level then
            self[string.format('_root_evolve_starLayout_star%d', i)]:setVisible(true)
        else
            self[string.format('_root_evolve_starLayout_star%d', i)]:setVisible(false)
        end
    end

    self._root_evolve_HP_value:setString(tostring(pet.Hp))
    self._root_evolve_ATK_value:setString(tostring(pet.Atk))
    self._root_evolve_Defense_value:setString(tostring(pet.Def))
    self._root_evolve_HPGrowth_value:setString(tostring(pet.HpP))
    self._root_evolve_ATKGrowth_value:setString(tostring(pet.AtkP))

    local dbPet = DBManager.getCharactor(pet.PetId)
    local unlockcount = Res.getAbilityUnlockCount(pet.AwakeIndex, pet.Star)

    for i = 2, 4 do
        self[string.format('_root_evolve_skillLayout_skill%d', i)]:setVisible(false)
    end

    self['_root_evolve_skillLayout_skill1_normal_bg']:setResid("JLXQ_jineng1.png")
    local skillitem = DBManager.getInfoSkill(dbPet.skill_id)
    Res.petSkillFormatScale(self['_root_evolve_skillLayout_skill1_normal_name'])
    self['_root_evolve_skillLayout_skill1_normal_name']:setString(Res.petSkillFormat(skillitem.name))
    Res.LabelNodeAutoShrinkIfArabic(self['_root_evolve_skillLayout_skill1_normal_name'], 56)

    local skillName = skillitem.name
    if string.len(skillName) == 9 then
      self['_root_evolve_skillLayout_skill1_normal_name']:setDimensions(CCSize(60, 0))
    else--if string.len(skillName) < 15 then
      self['_root_evolve_skillLayout_skill1_normal_name']:setDimensions(CCSize(40, 0))
    -- else
    --   self['_root_evolve_skillLayout_skill1_normal_name']:setDimensions(CCSize(70, 0))
    end

    require 'LangAdapter'.labelDimensions(self['_root_evolve_skillLayout_skill1_normal_name'],CCSizeMake(0,0),nil,CCSizeMake(80,0),nil,CCSizeMake(80,0))
    
    self['_root_evolve_skillLayout_skill1']:setListener(function ()
        --self:showSkillDetail(self._viewSet[string.format('%s_skillLayout_skill1', headStr)], skillitem, true)
        local node = self['_root_evolve_skillLayout_skill1']
        local nodePos = NodeHelper:getPositionInScreen(node)
        GleeCore:showLayer('DSkillInfo',{skillitem=skillitem,cost=cost,point=nodePos,offset=50})
    end)

    for i = 2, 4 do
        --if i - 1 > #dbPet.abilityarray then break end
        local ability = dbPet.abilityarray[i - 1]
        if ability == 0 then
            self[string.format('_root_evolve_skillLayout_skill%d', i)]:setVisible(false)
        else
            self[string.format('_root_evolve_skillLayout_skill%d', i)]:setVisible(true)
        end

        if unlockcount >= i - 1 then --已解锁
            self[string.format('_root_evolve_skillLayout_skill%d_normal_bg', i)]:setResid("JLXQ_jineng2.png")
            local skillitem = DBManager.getInfoSkill(ability)
            Res.petSkillFormatScale(self[string.format('_root_evolve_skillLayout_skill%d_normal_name', i)])
            self[string.format('_root_evolve_skillLayout_skill%d_normal_name', i)]:setString(Res.petSkillFormat(skillitem.name))
            Res.LabelNodeAutoShrinkIfArabic(self[string.format('_root_evolve_skillLayout_skill%d_normal_name', i)], 56)

            local skillName = skillitem.name
            if string.len(skillName) == 9 then
                self[string.format('_root_evolve_skillLayout_skill%d_normal_name', i)]:setDimensions(CCSize(60, 0))
            else
                self[string.format('_root_evolve_skillLayout_skill%d_normal_name', i)]:setDimensions(CCSize(40, 0))
            end
            
            require 'LangAdapter'.labelDimensions(self[string.format('_root_evolve_skillLayout_skill%d_normal_name', i)],CCSizeMake(0,0),nil,CCSizeMake(80,0),nil,CCSizeMake(80,0))
            -- setListener(function ()
            --     local node = self._viewSet[string.format('origin_skillLayout_skill%d', i)]
            --     local nodePos = NodeHelper:getPositionInScreen(node)
            --     GleeCore:showLayer('DSkillInfo',{skillitem=skillitem,cost=cost,point=nodePos,offset=50})
            -- end)
        else --没有解锁
            self[string.format('_root_evolve_skillLayout_skill%d_normal_bg', i)]:setResid("JLXQ_jineng3.png")
            --local skillitem = DBManager.getInfoSkill(dbPet.abilityarray[i])
            -- skillitem.abilityIndex = i
            -- self._viewSet[string.format('origin_skillLayout_skill%d', i)]:setListener(function ( ... )
            --     local node = self._viewSet[string.format('origin_skillLayout_skill%d', i)]
            --     local nodePos = NodeHelper:getPositionInScreen(node)
            --     GleeCore:showLayer('DSkillInfo',{skillitem=skillitem,cost=cost,point=nodePos,offset=50})
            -- end)
        end   
    end
    self:runAction(self:getUserData().titleResid)
end

function DEvolveSucceed:runAction(resid)
    if resid then
        self._root_title:setResid(resid)
    end
    self._root_line:setPosition(ccp(-980.0,128.0))
    self._root_title:setPosition(ccp(1466.0,128.0))
    self._root_light:setScale(0)
    self._root_line:runElfAction(self._leftIn:clone())
    self._root_title:runElfAction(self._rightIn:clone())
    self._root_evolve:setScale(0)
    self._root_evolve:runElfAction(self._scaleout:clone())

    local lightaction = self._scaleout:clone()
    lightaction:setListener(function ( ... )
        self._root_light:runElfAction(self._rotate:clone()) 
        self._root_bgclick:setVisible(true)
    end)
    self._root_light:runElfAction(lightaction)
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DEvolveSucceed, "DEvolveSucceed")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DEvolveSucceed", DEvolveSucceed)


