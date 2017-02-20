local Config = require "Config"
local Res = require 'Res'
local DBManager = require "DBManager"
local SwfActionFactory  = require 'framework.swf.SwfActionFactory'
local evolveSwf = require 'Swf_JinHua'

local DPetEvolveAnimate = class(LuaDialog)

function DPetEvolveAnimate:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPetEvolveAnimate.cocos.zip")
    return self._factory:createDocument("DPetEvolveAnimate.cocos")
end

--@@@@[[[[
function DPetEvolveAnimate:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._rect = set:getRectangleNode("rect")
   self._BG = set:getElfNode("BG")
   self._animate = set:getElfNode("animate")
   self._animate_BG = set:getSimpleAnimateNode("animate_BG")
   self._animate_originPet = set:getAddColorNode("animate_originPet")
   self._animate_originPet_img = set:getElfNode("animate_originPet_img")
   self._animate_evolvePet = set:getAddColorNode("animate_evolvePet")
   self._animate_evolvePet_img = set:getElfNode("animate_evolvePet_img")
   self._animate_FG = set:getSimpleAnimateNode("animate_FG")
   self._PetInfo = set:getJoint9Node("PetInfo")
   self._PetInfo_name = set:getLabelNode("PetInfo_name")
   self._PetInfo_quality = set:getLinearLayoutNode("PetInfo_quality")
   self._PetInfo_quality_title = set:getLabelNode("PetInfo_quality_title")
   self._PetInfo_quality_value = set:getLabelNode("PetInfo_quality_value")
   self._PetInfo_starLayout = set:getLayoutNode("PetInfo_starLayout")
   self._PetInfo_starLayout_star1 = set:getElfNode("PetInfo_starLayout_star1")
   self._PetInfo_starLayout_star2 = set:getElfNode("PetInfo_starLayout_star2")
   self._PetInfo_starLayout_star3 = set:getElfNode("PetInfo_starLayout_star3")
   self._PetInfo_starLayout_star4 = set:getElfNode("PetInfo_starLayout_star4")
   self._PetInfo_starLayout_star5 = set:getElfNode("PetInfo_starLayout_star5")
   self._PetInfo_starLayout_star6 = set:getElfNode("PetInfo_starLayout_star6")
   self._PetInfo_starLayout2 = set:getLinearLayoutNode("PetInfo_starLayout2")
   self._PetInfo_property = set:getElfNode("PetInfo_property")
   self._PetInfo_career = set:getElfNode("PetInfo_career")
   self._PetInfo_atk = set:getLinearLayoutNode("PetInfo_atk")
   self._PetInfo_atk_value = set:getLabelNode("PetInfo_atk_value")
   self._PetInfo_defense = set:getLinearLayoutNode("PetInfo_defense")
   self._PetInfo_defense_value = set:getLabelNode("PetInfo_defense_value")
   self._PetInfo_hp = set:getLinearLayoutNode("PetInfo_hp")
   self._PetInfo_hp_value = set:getLabelNode("PetInfo_hp_value")
   self._PetInfo_skillLayout = set:getLinearLayoutNode("PetInfo_skillLayout")
   self._PetInfo_skillLayout_skill1 = set:getColorClickNode("PetInfo_skillLayout_skill1")
   self._PetInfo_skillLayout_skill1_normal_bg = set:getElfNode("PetInfo_skillLayout_skill1_normal_bg")
   self._PetInfo_skillLayout_skill1_normal_name = set:getLabelNode("PetInfo_skillLayout_skill1_normal_name")
   self._PetInfo_skillLayout_skill1_normal_level = set:getLabelNode("PetInfo_skillLayout_skill1_normal_level")
   self._PetInfo_skillLayout_skill2 = set:getColorClickNode("PetInfo_skillLayout_skill2")
   self._PetInfo_skillLayout_skill2_normal_bg = set:getElfNode("PetInfo_skillLayout_skill2_normal_bg")
   self._PetInfo_skillLayout_skill2_normal_name = set:getLabelNode("PetInfo_skillLayout_skill2_normal_name")
   self._PetInfo_skillLayout_skill2_normal_level = set:getLabelNode("PetInfo_skillLayout_skill2_normal_level")
   self._PetInfo_skillLayout_skill3 = set:getColorClickNode("PetInfo_skillLayout_skill3")
   self._PetInfo_skillLayout_skill3_normal_bg = set:getElfNode("PetInfo_skillLayout_skill3_normal_bg")
   self._PetInfo_skillLayout_skill3_normal_name = set:getLabelNode("PetInfo_skillLayout_skill3_normal_name")
   self._PetInfo_skillLayout_skill3_normal_level = set:getLabelNode("PetInfo_skillLayout_skill3_normal_level")
   self._PetInfo_skillLayout_skill4 = set:getColorClickNode("PetInfo_skillLayout_skill4")
   self._PetInfo_skillLayout_skill4_normal_bg = set:getElfNode("PetInfo_skillLayout_skill4_normal_bg")
   self._PetInfo_skillLayout_skill4_normal_name = set:getLabelNode("PetInfo_skillLayout_skill4_normal_name")
   self._PetInfo_skillLayout_skill4_normal_level = set:getLabelNode("PetInfo_skillLayout_skill4_normal_level")
   self._FadeIn = set:getElfAction("FadeIn")
   self._MoveBy = set:getElfAction("MoveBy")
   self._ScaleTo = set:getElfAction("ScaleTo")
   self._BGFadeIn = set:getElfAction("BGFadeIn")
--   self._@simpleAnimate = set:getSimpleAnimateNode("@simpleAnimate")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DPetEvolveAnimate:onInit( userData, netData )

    require 'LangAdapter'.LabelNodeAutoShrink(self._PetInfo_quality_title,80)
	self._PetInfo:setVisible(false)
    self:playAnimate(userData.ID1, userData.pet, userData.callback)
    self._animate_FG:setETCAlphaEnable(true)
    self._clickBg:setListener(function()
        userData.callback()
        self:close()
    end)

    self._clickBg:setEnabled(false)
end

function DPetEvolveAnimate:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

-- self._FadeIn = set:getElfAction("FadeIn")
-- self._MoveBy = set:getElfAction("MoveBy")
-- self._ScaleTo = set:getElfAction("ScaleTo")
-- self._BGFadeIn = set:getElfAction("BGFadeIn")


function DPetEvolveAnimate:playAnimate(originPetID, evolvePet, callback)
    self._animate_BG:setVisible(false)
    self._animate_FG:setVisible(false)

    require 'framework.helper.MusicHelper'.playEffect("raw/ui_evolution.mp3")
    require 'LangAdapter'.LabelNodeAutoShrink(self._PetInfo_name,200)
    self._rect:runAction(self._FadeIn:clone())

    self._animate_originPet_img:setResid(Res.getPetWithPetId(originPetID))
    self._animate_evolvePet_img:setResid(Res.getPetWithPetId(evolvePet.PetId))
    local profile1 = require 'CfgHelper'.getCache('BattleCharactor', 'id', originPetID)
    local profile2 = require 'CfgHelper'.getCache('BattleCharactor', 'id', evolvePet.PetId)
    self._animate_originPet_img:setScale(profile1.troop_scale)
    self._animate_evolvePet_img:setScale(profile2.troop_scale)
    --self._animate_evolvePet:setVisible(false)
    --local action = ActionFactory.createAction(evolveSwf.array[1])--, nil , 20 * (rate or 1))
    self._animate_originPet:runAction(SwfActionFactory.createAction(evolveSwf.array[1]))

    local endAction = SwfActionFactory.createAction(evolveSwf.array[2])
    endAction:setListener(function()
        local actionMove = self._MoveBy:clone()

        actionMove:setListener(function()
            self._animate_evolvePet:setScale(1)
            local DBPet = DBManager.getCharactor(evolvePet.PetId)
            local suffix = evolvePet.AwakeIndex % 4
            if suffix == 0 then
                self._PetInfo_name:setString(string.format('%s Lv%d', DBPet.name, evolvePet.Lv))
            else
                self._PetInfo_name:setString(string.format('%s+%d Lv%d', DBPet.name, suffix, evolvePet.Lv))
            end
            self._PetInfo_quality_value:setString(DBPet.quality)

            if DBPet.star_level < 5 or DBPet.quality < 15 then
                self._PetInfo_starLayout:setVisible(true)
                self._PetInfo_starLayout2:setVisible(false)
                for i = 1, 6 do
                    if i <= DBPet.star_level then
                        self[string.format('_PetInfo_starLayout_star%d', i)]:setVisible(true)
                    else
                        self[string.format('_PetInfo_starLayout_star%d', i)]:setVisible(false)
                    end
                end
            else
                self._PetInfo_starLayout:setVisible(false)
                self._PetInfo_starLayout2:setVisible(true)
                require 'PetNodeHelper'.updateStarLayoutX(self._PetInfo_starLayout2, DBPet, 1.2)
            end
            
            self._PetInfo_career:setResid(Res.getPetCareerIcon(DBPet.atk_method_system))
            self._PetInfo_property:setResid(Res.getPetPropertyIcon(DBPet.prop_1, true))
            self._PetInfo_atk_value:setString(tostring(evolvePet.Atk))
            self._PetInfo_defense_value:setString(tostring(evolvePet.Def))
            self._PetInfo_hp_value:setString(tostring(evolvePet.Hp))

            --------------------------skill-----------------------------------
            local unlockcount = Res.getAbilityUnlockCount(evolvePet.AwakeIndex, DBPet.star_level)

            for i = 2, 4 do
                self[string.format('_PetInfo_skillLayout_skill%d', i)]:setVisible(false)
            end

            self['_PetInfo_skillLayout_skill1_normal_bg']:setResid("JLXQ_jineng1.png")
            local skillitem = DBManager.getInfoSkill(DBPet.skill_id)

            require 'LangAdapter'.labelDimensions(self['_PetInfo_skillLayout_skill1_normal_name'], CCSizeMake(0,0),nil,nil,nil,CCSizeMake(0,0))
       		Res.petSkillFormatScale(self['_PetInfo_skillLayout_skill1_normal_name'])
            self['_PetInfo_skillLayout_skill1_normal_name']:setString(Res.petSkillFormat(skillitem.name))
            Res.LabelNodeAutoShrinkIfArabic(self['_PetInfo_skillLayout_skill1_normal_name'], 56)

            self['_PetInfo_skillLayout_skill1']:setListener(function ()
                local node = self._PetInfo_skillLayout_skill1
                local nodePos = NodeHelper:getPositionInScreen(node)
                GleeCore:showLayer('DSkillInfo',{skillitem=skillitem,cost=cost,point=nodePos,offset=50})
            end)

            for i = 2, 4 do --#dbPet.abilityarrays
                local ability = DBPet.abilityarray[i - 1]
                if ability == 0 then
                    self[string.format('_PetInfo_skillLayout_skill%d', i)]:setVisible(false)
                else
                    self[string.format('_PetInfo_skillLayout_skill%d', i)]:setVisible(true)
                end

                if unlockcount >= i - 1 then --已解锁
                    self[string.format('_PetInfo_skillLayout_skill%d_normal_bg', i)]:setResid("JLXQ_jineng2.png")
                    local skillitem = DBManager.getInfoSkill(ability)

                    require 'LangAdapter'.labelDimensions(self[string.format('_PetInfo_skillLayout_skill%d_normal_name', i)], CCSizeMake(0,0),nil,nil,nil,CCSizeMake(0,0))
                    Res.petSkillFormatScale(self[string.format('_PetInfo_skillLayout_skill%d_normal_name', i)])
                    self[string.format('_PetInfo_skillLayout_skill%d_normal_name', i)]:setString(Res.petSkillFormat(skillitem.name))
                    Res.LabelNodeAutoShrinkIfArabic(self[string.format('_PetInfo_skillLayout_skill%d_normal_name', i)], 56)

                    self[string.format('_PetInfo_skillLayout_skill%d', i)]:setListener(function ()
                        local node = self[string.format('_PetInfo_skillLayout_skill%d', i)]
                        local nodePos = NodeHelper:getPositionInScreen(node)
                        GleeCore:showLayer('DSkillInfo',{skillitem=skillitem,cost=cost,point=nodePos,offset=50})
                    end)
                else --没有解锁
                    self[string.format('_PetInfo_skillLayout_skill%d_normal_name', i)]:setString('')
                    self[string.format('_PetInfo_skillLayout_skill%d_normal_bg', i)]:setResid("JLXQ_jineng3.png")

                    local skillitem = DBManager.getInfoSkill(ability)
                    --print(skillitem)
                    if skillitem then
                        skillitem.abilityIndex = i - 1
                        self[string.format('_PetInfo_skillLayout_skill%d', i)]:setListener(function ( ... )
                            local node = self[string.format('_PetInfo_skillLayout_skill%d', i)]
                            local nodePos = NodeHelper:getPositionInScreen(node)
                            GleeCore:showLayer('DSkillInfo',{skillitem=skillitem,cost=cost,point=nodePos,offset=50})
                        end)
                    end
                end   
            end
    --------------------------skill-----------------------------------
            
            require 'framework.helper.MusicHelper'.playEffect("raw/ui_taxt.mp3")
            self._PetInfo:setVisible(true)
            local scaleTo = self._ScaleTo:clone()
            scaleTo:setListener(function()
                self._clickBg:setEnabled(true)
            end)
            self._PetInfo:runAction(scaleTo)
        end)

        self._animate_evolvePet:runAction(actionMove)


        self._BG:runAction(self._BGFadeIn:clone())
    end)
    self._animate_evolvePet:runAction(endAction)

    self:runWithDelay(function ()
        self._animate_FG:setLoops(1)
        self._animate_FG:reset()
        self._animate_FG:start()
        self._animate_FG:setListener(function()
            self._animate_FG:setVisible(false)
        end)

        self._animate_BG:setLoops(1)
        self._animate_BG:reset()
        self._animate_BG:start()
        self._animate_BG:setListener(function()
            self._animate_BG:setVisible(false)
        end)

    end, 0.3)

    -- self:runWithDelay(function ()
    --     self._rect:setColorf(1, 1, 1, 0.5)
    -- end, 1.8)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPetEvolveAnimate, "DPetEvolveAnimate")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPetEvolveAnimate", DPetEvolveAnimate)


