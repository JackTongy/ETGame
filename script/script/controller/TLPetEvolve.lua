local Config = require "Config"
local DBManager = require "DBManager"
local TimeManager = require "TimeManager"
local NetModel = require 'netModel'
local Res = require 'Res'
local AppData = require 'AppData'
local GuideHelper = require 'GuideHelper'
local SwfActionFactory  = require 'framework.swf.SwfActionFactory'
local evolveSwf = require 'Swf_JinHua'

local TLPetEvolve = class(TabLayer)

function TLPetEvolve:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLPetEvolve.cocos.zip")
    return self._factory:createDocument("TLPetEvolve.cocos")
end

--@@@@[[[[
function TLPetEvolve:onInitXML()
	local set = self._set
    self._origin = set:getJoint9Node("origin")
    self._origin_name = set:getLabelNode("origin_name")
    self._origin_quality = set:getLabelNode("origin_quality")
    self._origin_starLayout = set:getLayoutNode("origin_starLayout")
    self._origin_starLayout_star6 = set:getElfNode("origin_starLayout_star6")
    self._origin_starLayout_star5 = set:getElfNode("origin_starLayout_star5")
    self._origin_starLayout_star4 = set:getElfNode("origin_starLayout_star4")
    self._origin_starLayout_star3 = set:getElfNode("origin_starLayout_star3")
    self._origin_starLayout_star2 = set:getElfNode("origin_starLayout_star2")
    self._origin_starLayout_star1 = set:getElfNode("origin_starLayout_star1")
    self._origin_pet = set:getColorClickNode("origin_pet")
    self._origin_pet_normal_elf_frame = set:getElfNode("origin_pet_normal_elf_frame")
    self._origin_pet_normal_elf_icon = set:getElfNode("origin_pet_normal_elf_icon")
    self._origin_pet_normal_property = set:getElfNode("origin_pet_normal_property")
    self._origin_pet_normal_career = set:getElfNode("origin_pet_normal_career")
    self._origin_skillLayout = set:getLinearLayoutNode("origin_skillLayout")
    self._origin_skillLayout_skill1 = set:getColorClickNode("origin_skillLayout_skill1")
    self._origin_skillLayout_skill1_normal_bg = set:getElfNode("origin_skillLayout_skill1_normal_bg")
    self._origin_skillLayout_skill1_normal_name = set:getLabelNode("origin_skillLayout_skill1_normal_name")
    self._origin_skillLayout_skill1_normal_level = set:getLabelNode("origin_skillLayout_skill1_normal_level")
    self._origin_skillLayout_skill2 = set:getColorClickNode("origin_skillLayout_skill2")
    self._origin_skillLayout_skill2_normal_bg = set:getElfNode("origin_skillLayout_skill2_normal_bg")
    self._origin_skillLayout_skill2_normal_name = set:getLabelNode("origin_skillLayout_skill2_normal_name")
    self._origin_skillLayout_skill2_normal_level = set:getLabelNode("origin_skillLayout_skill2_normal_level")
    self._origin_skillLayout_skill3 = set:getColorClickNode("origin_skillLayout_skill3")
    self._origin_skillLayout_skill3_normal_bg = set:getElfNode("origin_skillLayout_skill3_normal_bg")
    self._origin_skillLayout_skill3_normal_name = set:getLabelNode("origin_skillLayout_skill3_normal_name")
    self._origin_skillLayout_skill3_normal_level = set:getLabelNode("origin_skillLayout_skill3_normal_level")
    self._origin_skillLayout_skill4 = set:getColorClickNode("origin_skillLayout_skill4")
    self._origin_skillLayout_skill4_normal_bg = set:getElfNode("origin_skillLayout_skill4_normal_bg")
    self._origin_skillLayout_skill4_normal_name = set:getLabelNode("origin_skillLayout_skill4_normal_name")
    self._origin_skillLayout_skill4_normal_level = set:getLabelNode("origin_skillLayout_skill4_normal_level")
    self._origin_starLayout2 = set:getLinearLayoutNode("origin_starLayout2")
    self._result = set:getJoint9Node("result")
    self._result_name = set:getLabelNode("result_name")
    self._result_quality = set:getLabelNode("result_quality")
    self._result_starLayout = set:getLayoutNode("result_starLayout")
    self._result_starLayout_star6 = set:getElfNode("result_starLayout_star6")
    self._result_starLayout_star5 = set:getElfNode("result_starLayout_star5")
    self._result_starLayout_star4 = set:getElfNode("result_starLayout_star4")
    self._result_starLayout_star3 = set:getElfNode("result_starLayout_star3")
    self._result_starLayout_star2 = set:getElfNode("result_starLayout_star2")
    self._result_starLayout_star1 = set:getElfNode("result_starLayout_star1")
    self._result_pet = set:getColorClickNode("result_pet")
    self._result_pet_normal_elf_frame = set:getElfNode("result_pet_normal_elf_frame")
    self._result_pet_normal_elf_icon = set:getElfNode("result_pet_normal_elf_icon")
    self._result_pet_normal_property = set:getElfNode("result_pet_normal_property")
    self._result_pet_normal_career = set:getElfNode("result_pet_normal_career")
    self._result_skillLayout = set:getLinearLayoutNode("result_skillLayout")
    self._result_skillLayout_skill1 = set:getColorClickNode("result_skillLayout_skill1")
    self._result_skillLayout_skill1_normal_bg = set:getElfNode("result_skillLayout_skill1_normal_bg")
    self._result_skillLayout_skill1_normal_name = set:getLabelNode("result_skillLayout_skill1_normal_name")
    self._result_skillLayout_skill1_normal_level = set:getLabelNode("result_skillLayout_skill1_normal_level")
    self._result_skillLayout_skill2 = set:getColorClickNode("result_skillLayout_skill2")
    self._result_skillLayout_skill2_normal_bg = set:getElfNode("result_skillLayout_skill2_normal_bg")
    self._result_skillLayout_skill2_normal_name = set:getLabelNode("result_skillLayout_skill2_normal_name")
    self._result_skillLayout_skill2_normal_level = set:getLabelNode("result_skillLayout_skill2_normal_level")
    self._result_skillLayout_skill3 = set:getColorClickNode("result_skillLayout_skill3")
    self._result_skillLayout_skill3_normal_bg = set:getElfNode("result_skillLayout_skill3_normal_bg")
    self._result_skillLayout_skill3_normal_name = set:getLabelNode("result_skillLayout_skill3_normal_name")
    self._result_skillLayout_skill3_normal_level = set:getLabelNode("result_skillLayout_skill3_normal_level")
    self._result_skillLayout_skill4 = set:getColorClickNode("result_skillLayout_skill4")
    self._result_skillLayout_skill4_normal_bg = set:getElfNode("result_skillLayout_skill4_normal_bg")
    self._result_skillLayout_skill4_normal_name = set:getLabelNode("result_skillLayout_skill4_normal_name")
    self._result_skillLayout_skill4_normal_level = set:getLabelNode("result_skillLayout_skill4_normal_level")
    self._result_starLayout2 = set:getLinearLayoutNode("result_starLayout2")
    self._bottom = set:getElfNode("bottom")
    self._bottom_conditionNone = set:getLabelNode("bottom_conditionNone")
    self._bottom_condition = set:getLabelNode("bottom_condition")
    self._bottom_consume = set:getLabelNode("bottom_consume")
    self._bottom_material = set:getColorClickNode("bottom_material")
    self._bottom_material_normal_bg = set:getElfNode("bottom_material_normal_bg")
    self._bottom_material_normal_icon = set:getElfNode("bottom_material_normal_icon")
    self._bottom_material_normal_frame = set:getElfNode("bottom_material_normal_frame")
    self._bottom_material_normal_ibg1 = set:getJoint9Node("bottom_material_normal_ibg1")
    self._bottom_material_normal_name = set:getLabelNode("bottom_material_normal_name")
    self._bottom_material_normal_anim = set:getSimpleAnimateNode("bottom_material_normal_anim")
    self._bottom_material_normal_amount = set:getLabelNode("bottom_material_normal_amount")
    self._bottom_list = set:getListNode("bottom_list")
    self._normal_content_bg = set:getElfNode("normal_content_bg")
    self._normal_content_icon = set:getElfNode("normal_content_icon")
    self._normal_content_pet = set:getElfNode("normal_content_pet")
    self._normal_content_frame = set:getElfNode("normal_content_frame")
    self._normal_ibg1 = set:getJoint9Node("normal_ibg1")
    self._normal_name = set:getLabelNode("normal_name")
    self._normal_anim = set:getSimpleAnimateNode("normal_anim")
    self._normal_amount = set:getLabelNode("normal_amount")
    self._bottom_condition1 = set:getLinearLayoutNode("bottom_condition1")
    self._bottom_condition1_stateIcon = set:getElfNode("bottom_condition1_stateIcon")
    self._bottom_condition1_des = set:getLabelNode("bottom_condition1_des")
    self._bottom_condition2 = set:getLinearLayoutNode("bottom_condition2")
    self._bottom_condition2_stateIcon = set:getElfNode("bottom_condition2_stateIcon")
    self._bottom_condition2_des = set:getLabelNode("bottom_condition2_des")
    self._bottom_materialNone = set:getLabelNode("bottom_materialNone")
    self._bottom_evolveNone = set:getLabelNode("bottom_evolveNone")
    self._bottom_condition3 = set:getElfNode("bottom_condition3")
    self._bottom_condition3_stateIcon = set:getElfNode("bottom_condition3_stateIcon")
    self._bottom_condition3_des = set:getLabelNode("bottom_condition3_des")
    self._btnEvolution = set:getClickNode("btnEvolution")
    self._btnEvolution_title = set:getLabelNode("btnEvolution_title")
    self._btnOtherForm = set:getClickNode("btnOtherForm")
    self._btnOtherForm_title = set:getLabelNode("btnOtherForm_title")
--    self._@view = set:getElfNode("@view")
--    self._@simpleAnimate = set:getSimpleAnimateNode("@simpleAnimate")
--    self._@simpleAnimate = set:getSimpleAnimateNode("@simpleAnimate")
--    self._@material = set:getColorClickNode("@material")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLPetEvolve:onInit( userData, netData )
	self._viewSet['bottom_material_normal_anim']:setVisible(false)
    require 'LangAdapter'.fontSize(self._viewSet['btnOtherForm_title'],nil,nil,24)
end

function TLPetEvolve:onEnter( ... )
    if self._Pet ~= nil and self._parent:getUserData().pet.Id ~= self._Pet.Id then
        self.megaMIDs = nil
    end

	self._Pet = (self._parent:getUserData() and self._parent:getUserData().pet)
	self:updateLayer()
	--self._parent:setVisible(false)
    local dbpet = DBManager.getCharactor(self._Pet.PetId)

    if dbpet.ev_pet then
        GuideHelper:registerPoint('进化石',self._viewSet['bottom_material'])
    else
        GuideHelper:unregisterPoint('进化石')
    end

    local db1   = DBManager.getInfoDefaultConfig('EvolvePet')
    local petid = (db1 and db1.Value) or 290 
    if petid == self._Pet.PetId and AppData.getPetInfo().satisfyAllEvolveCondition(self._Pet) then
        GuideHelper:registerPoint('进化',self._viewSet['btnEvolution'])
    else
        GuideHelper:unregisterPoint('进化') 
    end

    GuideHelper:check('TLPetEvolve')

end

function TLPetEvolve:onLeave( )
	--self._parent:setVisible(true)
end

function TLPetEvolve:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function TLPetEvolve:updatePetView(headStr, NPet, DBPet)
    --local charactor = DBManager.getCharactor(pet.PetId)

    self._viewSet[string.format('%s_pet_normal_elf_icon', headStr)]:setResid(Res.getPetIcon(DBPet.id))
    self._viewSet[string.format('%s_pet_normal_elf_frame', headStr)]:setResid(Res.getPetIconFrame(NPet))
    self._viewSet[string.format('%s_name', headStr)]:setString(DBPet.name)
    self._viewSet[string.format('%s_quality', headStr)]:setString(string.format('%s %d', Res.locString("Evolution$_Quality"), DBPet.quality))

    self._viewSet[string.format('%s_pet_normal_career', headStr)]:setResid(Res.getPetCareerIconEvolve(DBPet.atk_method_system))
    self._viewSet[string.format('%s_pet_normal_property', headStr)]:setResid(Res.getPetPropertyIconEvolve(DBPet.prop_1, true))

    if DBPet.star_level < 5 or DBPet.quality < 15 then
        self._viewSet[string.format('%s_starLayout', headStr)]:setVisible(true)
        self._viewSet[string.format('%s_starLayout2', headStr)]:setVisible(false)
        for i = 1, 6 do
            if i <= DBPet.star_level then
                self._viewSet[string.format('%s_starLayout_star%d', headStr, i)]:setVisible(true)
            else
                self._viewSet[string.format('%s_starLayout_star%d', headStr, i)]:setVisible(false)
            end
        end
    else
        self._viewSet[string.format('%s_starLayout', headStr)]:setVisible(false)
        self._viewSet[string.format('%s_starLayout2', headStr)]:setVisible(true)
        require 'PetNodeHelper'.updateStarLayoutX(self._viewSet[string.format('%s_starLayout2', headStr)], DBPet)
    end

    --local dbPet = DBManager.getCharactor(pet.PetId)
    local unlockcount = Res.getAbilityUnlockCount(NPet.AwakeIndex, DBPet.star_level)

    for i = 2, 4 do
        self._viewSet[string.format('%s_skillLayout_skill%d', headStr, i)]:setVisible(false)
    end

    self._viewSet[string.format('%s_skillLayout_skill1_normal_bg', headStr)]:setResid("JLXQ_jineng1.png")
    local skillitem = DBManager.getInfoSkill(DBPet.skill_id)

    require 'LangAdapter'.labelDimensions(self._viewSet[string.format('%s_skillLayout_skill1_normal_name', headStr)], CCSizeMake(0,0),nil,nil,nil,CCSizeMake(0,0))

    require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet[string.format('%s_skillLayout_skill1_normal_name', headStr)],45)
    self._viewSet[string.format('%s_skillLayout_skill1_normal_name', headStr)]:setString(skillitem.name)

    Res.petSkillFormatScale(self._viewSet[string.format('%s_skillLayout_skill1_normal_name', headStr)])
    self._viewSet[string.format('%s_skillLayout_skill1_normal_name', headStr)]:setString(Res.petSkillFormat(skillitem.name))
    Res.LabelNodeAutoShrinkIfArabic(self._viewSet[string.format('%s_skillLayout_skill1_normal_name', headStr)], 56)


    -- local skillName = skillitem.name
    -- if string.len(skillName) == 9 then
    --   self._viewSet[string.format('%s_skillLayout_skill1_normal_name', headStr)]:setDimensions(CCSize(55, 0))
    -- else--if string.len(skillName) < 15 then
    --   self._viewSet[string.format('%s_skillLayout_skill1_normal_name', headStr)]:setDimensions(CCSize(36, 0))
    -- end
    self._viewSet[string.format('%s_skillLayout_skill1', headStr)]:setListener(function ()
        --self:showSkillDetail(self._viewSet[string.format('%s_skillLayout_skill1', headStr)], skillitem, true)
        local node = self._viewSet[string.format('%s_skillLayout_skill1', headStr)]
        local nodePos = NodeHelper:getPositionInScreen(node)
        GleeCore:showLayer('DSkillInfo',{skillitem=skillitem,cost=cost,point=nodePos,offset=50})
    end)

    for i = 2, 4 do --#dbPet.abilityarrays
        local ability = DBPet.abilityarray[i - 1]
        if ability == 0 then
            self._viewSet[string.format('%s_skillLayout_skill%d', headStr, i)]:setVisible(false)
        else
            self._viewSet[string.format('%s_skillLayout_skill%d', headStr, i)]:setVisible(true)
        end

        if unlockcount >= i - 1 then --已解锁
            self._viewSet[string.format('%s_skillLayout_skill%d_normal_bg', headStr, i)]:setResid("JLXQ_jineng2.png")
            local skillitem = DBManager.getInfoSkill(ability)
            require 'LangAdapter'.labelDimensions(self._viewSet[string.format('%s_skillLayout_skill%d_normal_name', headStr, i)], CCSizeMake(0,0),nil,nil,nil,CCSizeMake(0,0))

            require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet[string.format('%s_skillLayout_skill%d_normal_name', headStr, i)],45)
            Res.petSkillFormatScale(self._viewSet[string.format('%s_skillLayout_skill%d_normal_name', headStr, i)])
            self._viewSet[string.format('%s_skillLayout_skill%d_normal_name', headStr, i)]:setString(Res.petSkillFormat(skillitem.name))
            Res.LabelNodeAutoShrinkIfArabic(self._viewSet[string.format('%s_skillLayout_skill%d_normal_name', headStr, i)], 56)
            -- local skillName = skillitem.name
            -- if string.len(skillName) == 9 then
            --     self._viewSet[string.format('%s_skillLayout_skill%d_normal_name', headStr, i)]:setDimensions(CCSize(55, 0))
            -- else
            --     self._viewSet[string.format('%s_skillLayout_skill%d_normal_name', headStr, i)]:setDimensions(CCSize(36, 0))
            -- end
            
            self._viewSet[string.format('%s_skillLayout_skill%d', headStr, i)]:setListener(function ()
                local node = self._viewSet[string.format('%s_skillLayout_skill%d', headStr, i)]
                local nodePos = NodeHelper:getPositionInScreen(node)
                GleeCore:showLayer('DSkillInfo',{skillitem=skillitem,cost=cost,point=nodePos,offset=50})
            end)
        else --没有解锁
            self._viewSet[string.format('%s_skillLayout_skill%d_normal_name', headStr, i)]:setString('')
            self._viewSet[string.format('%s_skillLayout_skill%d_normal_bg', headStr, i)]:setResid("JLXQ_jineng3.png")

            local skillitem = DBManager.getInfoSkill(ability)
            --print(skillitem)
            if skillitem then
                skillitem.abilityIndex = i - 1
                self._viewSet[string.format('%s_skillLayout_skill%d', headStr, i)]:setListener(function ( ... )
                    local node = self._viewSet[string.format('%s_skillLayout_skill%d', headStr, i)]
                    local nodePos = NodeHelper:getPositionInScreen(node)
                    GleeCore:showLayer('DSkillInfo',{skillitem=skillitem,cost=cost,point=nodePos,offset=50})
                end)
            end
        end   
    end
    self._viewSet[string.format('%s_pet', headStr)]:setEnabled(false)
    
    -- self._viewSet[string.format('%s_pet', headStr)]:setListener(function()
    --     local param = {}
    --     if not NPet.Id then
    --         param.nPet = AppData.getPetInfo().getPetInfoByPetId(DBPet.id, NPet.AwakeIndex)
    --     else 
    --         param.nPet = NPet
    --     end
    --     GleeCore:showLayer("DPetDetailV", param)

    --     --GleeCore:showLayer('DEvolveSucceed', {pet = self._Pet, titleResid = 'N_JH_jhcg.png'})
    -- end)
end

function TLPetEvolve:updateLayer( ... )
	--self._parent:updatePet(data.D.Pet) 会自动调用 onenter
    require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['bottom_condition1_des'],220)
    require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['bottom_condition2_des'],220)
    
    self._viewSet['bottom_condition1_des']:setString(Res.locString('Evolution$_Condition1'))
    self._viewSet['bottom_condition1_stateIcon']:setResid('N_JH_dg.png')
    local charactor = DBManager.getCharactor(self._Pet.PetId)
    if not require 'UnlockManager':isOpen('Mega') then
        charactor.ev_pet_mega = nil
    end
    
    if charactor.ev_pet ~= nil or charactor.ev_pet_mega ~= nil then
        if charactor.ev_pet ~= nil then
            self._viewSet['bottom_list']:setVisible(false)
            self._viewSet['bottom_material']:setVisible(true)
        else
            self._viewSet['bottom_list']:setVisible(true)
            self._viewSet['bottom_material']:setVisible(false)
        end
        self._viewSet['bottom_conditionNone']:setVisible(false)
        self._viewSet['bottom_materialNone']:setVisible(false)
        self._viewSet['bottom_evolveNone']:setVisible(false)
        self._viewSet['result_name']:setVisible(true)
        self._viewSet['result_quality']:setVisible(true)
        self._viewSet['result_starLayout']:setVisible(true)
        self._viewSet['result_pet']:setVisible(true)
        self._viewSet['result_skillLayout']:setVisible(true)
        --self._viewSet['bottom_material']:setVisible(true)
        self._viewSet['bottom_condition1']:setVisible(true)
        self._viewSet['bottom_condition2']:setVisible(true)
        self._viewSet['bottom_condition3']:setVisible(true)
    else
        self._viewSet['bottom_conditionNone']:setVisible(true)
        self._viewSet['bottom_materialNone']:setVisible(true)
        self._viewSet['bottom_evolveNone']:setVisible(true)

        self._viewSet['result_name']:setVisible(false)
        self._viewSet['result_quality']:setVisible(false)
        self._viewSet['result_starLayout']:setVisible(false)
        self._viewSet['result_starLayout2']:setVisible(false)
        self._viewSet['result_pet']:setVisible(false)
        self._viewSet['result_skillLayout']:setVisible(false)
        self._viewSet['bottom_material']:setVisible(false)
        self._viewSet['bottom_condition1']:setVisible(false)
        self._viewSet['bottom_condition2']:setVisible(false)
        self._viewSet['bottom_condition3']:setVisible(false)
        self._viewSet['btnEvolution']:setEnabled(false)

        self._viewSet['bottom_list']:setVisible(false)

        self._viewSet['bottom_condition']:setString(Res.locString('Evolution$_Condition'))
        self._viewSet['bottom_consume']:setString(Res.locString('Evolution$_Consume'))
    end

    if (charactor.ev_pet and #charactor.ev_pet > 1) or (charactor.ev_pet_mega and #charactor.ev_pet_mega > 1) then
        self._viewSet['btnEvolution']:setPosition(ccp(260, self._viewSet['btnEvolution']:getPositionY()))
        self._viewSet['btnOtherForm']:setVisible(true)-- setEnabled(false)
        self._viewSet['btnOtherForm']:setListener(function()
            GleeCore:showLayer('DEvolveInfo', self._Pet)
        end)
    else
        self._viewSet['btnEvolution']:setPosition(ccp(133, self._viewSet['btnEvolution']:getPositionY()))
        self._viewSet['btnOtherForm']:setVisible(false)-- setEnabled(false)
    end

    ------------------------------------------------------------
    self:updatePetView('origin', self._Pet, charactor)
    self._viewSet['btnEvolution_title']:setString(Res.locString('Evolution$_BTN_Evolution'))
    if charactor.ev_pet then
        local resuletCharactor = self:getAppropriateEvPet(charactor.ev_pet)
        self:updatePetView('result', {AwakeIndex = self._Pet.AwakeIndex}, resuletCharactor)
        -- set evolution conditions
        local evolveEnable = true
        local totalCount;
        local satisfyCount = 1;
        self._viewSet['bottom_condition2_des']:setString(string.format(Res.locString('Evolution$_Condition2'), resuletCharactor.ev_lv))
        if self._Pet.Lv < resuletCharactor.ev_lv then
            self._viewSet['bottom_condition2_stateIcon']:setResid('N_JH_x.png')
            evolveEnable = false
        else
            self._viewSet['bottom_condition2_stateIcon']:setResid('N_JH_dg.png')
            satisfyCount = satisfyCount + 1
        end

        if not resuletCharactor.ev_condition then
            self._viewSet['bottom_condition3']:setVisible(false)
            totalCount = 2
        else
            totalCount = 3
            self._viewSet['bottom_condition3']:setVisible(true)
            self._viewSet['bottom_condition3_des']:setString(resuletCharactor.ev_condition_des)
            if self:satisfySpecialCondition(resuletCharactor.id) then
                self._viewSet['bottom_condition3_stateIcon']:setResid('N_JH_dg.png')
                satisfyCount = satisfyCount + 1
            else
                self._viewSet['bottom_condition3_stateIcon']:setResid('N_JH_x.png')
                evolveEnable = false
            end
        end
        self._viewSet['bottom_condition']:setString(string.format('%s %d/%d', Res.locString('Evolution$_Condition'), satisfyCount, totalCount))
        -- set evolution consume
        local propID = self:getPropID(resuletCharactor.prop_1)
        local prop = AppData.getBagInfo().getItemWithItemId(propID)
        local DBProp = DBManager.getInfoMaterial(propID)
        self._viewSet['bottom_material_normal_icon']:setResid(Res.getMaterialIcon(DBProp.materialid))
        self._viewSet['bottom_material_normal_frame']:setResid(Res.getMaterialIconFrame(DBProp.color))
        self._viewSet['bottom_material_normal_name']:setString(DBProp.name)
        require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['bottom_material_normal_name'],85)
        local amount = 0
        if prop and prop.Amount then 
            amount = prop.Amount
        end
        self._viewSet['bottom_material_normal_amount']:setString(string.format('%d/%d', amount, resuletCharactor.ev_num))

        local materialEnough = 0
        if prop and prop.Amount >= resuletCharactor.ev_num then
            self._viewSet['bottom_material_normal_name']:setFontFillColor(ccc4f(1, 1, 1, 1.0), true)
            self._viewSet['bottom_material_normal_amount']:setFontFillColor(ccc4f(1, 1, 1, 1.0), true)
            materialEnough = 1
        else
            --self._viewSet['bottom_material_normal_name']:setFontFillColor(ccc4f(0.54, 0.11, 0, 1.0), true)
            self._viewSet['bottom_material_normal_name']:setFontFillColor(Res.color4F.red, true)
            self._viewSet['bottom_material_normal_amount']:setFontFillColor(Res.color4F.red, true)
            evolveEnable = false
        end

        self._viewSet['bottom_consume']:setString(string.format('%s %d/1', Res.locString('Evolution$_Consume'), materialEnough))

        self._viewSet['bottom_material']:setListener(function()
            -- GleeCore:showLayer('DPetEvolveAnimate', {ID1 = self._Pet.PetId, pet = self._Pet, callback = function()
            -- end})
            GleeCore:showLayer("DMaterialDetail", {materialId = DBProp.materialid, needAmount = resuletCharactor.ev_num})
        end)
        
        -- set btn state
        self._viewSet['btnEvolution']:setEnabled(evolveEnable)
        
        self._viewSet['btnEvolution']:setListener(function()
            if not self:satisfySpecialCondition(resuletCharactor.id) then
                self:toast(Res.locString('Evolution$_Not_Satisfy'))
                self:updateLayer()
                return
            end
            self._viewSet['btnEvolution']:setEnabled(false)
            self:send(NetModel.getModelPetEvolution(self._Pet.Id, resuletCharactor.id), function (data)
                GuideHelper:check('EvolveDone')
                AppData.updateResource(data.D.Resource)
                local rpet = data.D.Resource.Pets[1]
                self:playEvolveAnimate(rpet)
                AppData.getPetInfo().addPets(data.D.Pets)
                AppData.getBagInfo().useItemByID(prop.Id, resuletCharactor.ev_num)
            end,
            function()
                self:updateLayer()
            end)
        end)
    elseif charactor.ev_pet_mega and next(charactor.ev_pet_mega) then
        -- print('msg:------------------charactor.ev_pet_mega')
        --print(charactor.ev_pet_mega)
        local resuletCharactor = self:getAppropriateEvPet(charactor.ev_pet_mega)
        local index = 1
        for i,v in ipairs(charactor.ev_pet_mega) do
            if v == resuletCharactor.id then
                index = i
                break
            end
        end
        
        print('resuletCharactor:'..index)
        --print('msg:-------------------------------------------resuletCharactor')
        -- mega进化后6星精灵的觉醒阶数变化 修改 16资质：变18 ；17资质：变17 ；18资质变19； 5星精灵的觉醒阶数变化 15资质:变 19
        --print(resuletCharactor)
        local resultAwakeIndex = self._Pet.AwakeIndex
        local charc = DBManager.getCharactor(self._Pet.PetId)
        if self._Pet.Star == 5 then
            if charc.quality == 15 then
                resultAwakeIndex = 19
            end
        elseif self._Pet.Star == 6 then
            if charc.quality == 16 then
                resultAwakeIndex = 18
            elseif charc.quality == 17 then
                resultAwakeIndex = 17
            elseif charc.quality == 18 then
                resultAwakeIndex = 19
            end
        end

        self:updatePetView('result', {AwakeIndex = resultAwakeIndex}, resuletCharactor)
        -- set evolution conditions
        local evolveEnable = true

        self._viewSet['bottom_condition1']:setVisible(true)
        self._viewSet['bottom_condition2']:setVisible(true)
        self._viewSet['bottom_condition3']:setVisible(true)

        local totalCount = 3
        local satisfyCount = 0
        if self._Pet.Star == 5 then
            self._viewSet['bottom_condition1_des']:setString(string.format(Res.locString('Evolution$_Condition2'), DBManager.getInfoDefaultConfig('Mega5StarLevelLimit').Value))
            if DBManager.getInfoDefaultConfig('Mega5StarLevelLimit').Value > self._Pet.Lv then
                self._viewSet['bottom_condition1_stateIcon']:setResid('N_JH_x.png')
                --self._viewSet['bottom_condition1']:setFontFillColor(ccc4f(1, 0, 0, 1.0), true)
                evolveEnable = false
            else
                self._viewSet['bottom_condition1_stateIcon']:setResid('N_JH_dg.png')
                satisfyCount = satisfyCount + 1
                --self._viewSet['bottom_condition1']:setFontFillColor(ccc4f(1, 1, 1, 1.0), true)
            end
            local limitAwake = DBManager.getInfoDefaultConfig('Mega5StarAwakeLimit').Value
            local strColor = AppData.getPetInfo().getPetAwakeColor(limitAwake)
            self._viewSet['bottom_condition2_des']:setString(string.format(Res.locString('Evolution$_condition_color'), strColor))

            if self._Pet.AwakeIndex < limitAwake then
                self._viewSet['bottom_condition2_stateIcon']:setResid('N_JH_x.png')
                --self._viewSet['bottom_condition2']:setFontFillColor(ccc4f(1, 0, 0, 1.0), true)
                evolveEnable = false
            else
                self._viewSet['bottom_condition2_stateIcon']:setResid('N_JH_dg.png')
                satisfyCount = satisfyCount + 1
                --self._viewSet['bottom_condition2']:setFontFillColor(ccc4f(1, 1, 1, 1.0), true)
            end

        elseif self._Pet.Star == 6 then
            self._viewSet['bottom_condition1_des']:setString(string.format(Res.locString('Evolution$_Condition2'), DBManager.getInfoDefaultConfig('Mega6StarLevelLimit').Value))
            if DBManager.getInfoDefaultConfig('Mega6StarLevelLimit').Value > self._Pet.Lv then
                self._viewSet['bottom_condition1_stateIcon']:setResid('N_JH_x.png')
                evolveEnable = false
            else
                self._viewSet['bottom_condition1_stateIcon']:setResid('N_JH_dg.png')
                satisfyCount = satisfyCount + 1
            end

            local limitAwake = DBManager.getInfoDefaultConfig('Mega6StarAwakeLimit').Value
            local strColor = AppData.getPetInfo().getPetAwakeColor(limitAwake)
            self._viewSet['bottom_condition2_des']:setString(string.format(Res.locString('Evolution$_condition_color'), strColor))

            if self._Pet.AwakeIndex < limitAwake then
                self._viewSet['bottom_condition2_stateIcon']:setResid('N_JH_x.png')
                --self._viewSet['bottom_condition2']:setFontFillColor(ccc4f(1, 0, 0, 1.0), true)
                evolveEnable = false
            else
                self._viewSet['bottom_condition2_stateIcon']:setResid('N_JH_dg.png')
                satisfyCount = satisfyCount + 1
                --self._viewSet['bottom_condition2']:setFontFillColor(ccc4f(1, 1, 1, 1.0), true)
            end
        end

        if not resuletCharactor.ev_condition then
            self._viewSet['bottom_condition3']:setVisible(false)
            totalCount = 2
            --print('msg:--------------------totalCount = 2')
        else
            --print('msg:--------------------totalCount = 3')
            totalCount = 3
            self._viewSet['bottom_condition3']:setVisible(true)
            self._viewSet['bottom_condition3_des']:setString(resuletCharactor.ev_condition_des)
            --print('msg:----------------bottom_condition3_des')
            if self:satisfySpecialCondition(resuletCharactor.id) then
                self._viewSet['bottom_condition3_stateIcon']:setResid('N_JH_dg.png')
                satisfyCount = satisfyCount + 1
            else
                self._viewSet['bottom_condition3_stateIcon']:setResid('N_JH_x.png')
                evolveEnable = false
            end
        end

        self._viewSet['bottom_condition']:setString(string.format('%s %d/%d', Res.locString('Evolution$_Condition'), satisfyCount, totalCount))
        self._viewSet['btnEvolution']:setEnabled(evolveEnable)
        self:refreshMaterialList(charactor.ev_pet_mega[index])

        self._viewSet['btnEvolution_title']:setString(string.format('Mega%s', Res.locString('Evolution$_BTN_Evolution')))
        require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['btnEvolution_title'],136)
        --self._viewSet['btnEvolution']:setEnabled(true)
        self._viewSet['btnEvolution']:setListener(function()    
            -- self:playMegaEvolveAnimate(self._Pet)
            -- return
            if not self:satisfySpecialCondition(resuletCharactor.id) then
                self:toast(Res.locString('Evolution$_Not_Satisfy'))
                self:updateLayer()
                return
            end

            for i = 1, #self.megaMIDs do
                local DBPet = DBManager.getCharactor(self.megaMIDs[i].PetId)
                if AppData.getPetInfo().isPetInTeam(self.megaMIDs[i].Id) then
                    self:toast(string.format('%s%s', DBPet.name, Res.locString('Evolution$_IN_TEAM')))
                    return
                -- elseif AppData.getPetInfo().petInStorage(self.megaMIDs[i].Id) then
                --     self:toast(string.format('%s%s', DBPet.name, Res.locString('PetSynthesis$_In_Storage')))
                --     return false
                elseif AppData.getExploreInfo().petInExploration(self.megaMIDs[i].Id) then
                    self:toast(string.format('%s%s', DBPet.name, Res.locString('Evolution$_IN_EXPLORE')))
                    return
                end
            end

            local mids = {}
            for k, v in pairs(self.megaMIDs) do
                table.insert(mids, v.Id)
            end
            local callNetEvolve = function()
                self._viewSet['btnEvolution']:setEnabled(false)
                self:send(NetModel.getModelPetMegaEvolution(self._Pet.Id, resuletCharactor.id, mids), function (data)
                    AppData.updateResource(data.D.Resource)
                    local rpet = data.D.Pet
                    self:playMegaEvolveAnimate(rpet)
                    AppData.getPetInfo().addPets({rpet})
                    AppData.getPetInfo().removePetByIds(mids)
                    self.megaMIDs = {}
                    -- AppData.getUserInfo().setGold(AppData.getUserInfo().getGold() - DBManager.getMegaConfig(resuletCharactor.id).Gold)
                    require 'EventCenter'.eventInput("UpdateGoldCoin")
                    end,
                    function()
                        self:updateLayer()
                    end)
                --end)
            end
            local hasAwakeMaterial = false
            for k, v in pairs(self.megaMIDs) do
                if self:noticeRebirth(callNetEvolve, v) then
                    hasAwakeMaterial = true
                    break
                end
            end

            if not hasAwakeMaterial then
                callNetEvolve()
            end
            -- self:send(NetModel.getModelPetMegaEvolution(self._Pet.Id, resuletCharactor.id, mids), function (data)
            --     AppData.updateResource(data.D.Resource)
            --     local rpet = data.D.Pet
            --     self:playMegaEvolveAnimate(rpet)
            --     AppData.getPetInfo().addPets({rpet})
            --     AppData.getPetInfo().removePetByIds(mids)
            --     self.megaMIDs = {}
            --     AppData.getUserInfo().setGold(AppData.getUserInfo().getGold() - DBManager.getMegaConfig(resuletCharactor.id).Gold)
            --     require 'EventCenter'.eventInput("UpdateGoldCoin")
            -- end,
            -- function()
            --     self:updateLayer()
            -- end)
        end)
    end
end


function TLPetEvolve:noticeRebirth( confirmFunc,nPet )
    -- print('msg:----------------------------self.megaMIDs')
    -- print(self.megaMIDs)
    --print(nPet)
    --nPet.Lv ~= 1 or nPet.Exp > 0 or 
    local rebirthEnable = nPet.AwakeIndex ~= 0-- or ((nPet.Lv-nPet.Potential) > 0 and nPet.Star > 2)
    if rebirthEnable then
        --self.norefresh = true --不重生
        GleeCore:showLayer('DConfirmNT',{clickClose=true,content = Res.locString('PetFoster$rebirthNotice1'), callback=function ( )
            confirmFunc()
        end,LeftBtnText=Res.locString('PetFoster$rebirthTitle'),cancelCallback=function ( ... )
            GleeCore:showLayer('DPetFoster',{pet=nPet,tab='TLRebirth'},'Rebirth')
            --self.megaMIDs = {}
        end})
        return true
    end
    return false
end

function TLPetEvolve:satisfyMegaCondition(petID)
     local megaInfo = DBManager.getMegaConfig(petID)
    -- print('msg:----------------------megaInfo')
    -- print(megaInfo)

    if AppData.getBagInfo().getItemCount(megaInfo.MegaStoneId) < megaInfo.MegaStoneAmt then
        return false
    end

    if AppData.getBagInfo().getItemCount(megaInfo.StoneId) < megaInfo.StoneAmt then
        return false
    end

    for word in string.gmatch(megaInfo.Pets, '([^,]+)') do
        local info = {}
        for temp in string.gmatch(word, '([^:]+)') do
            table.insert(info, temp)
        end
        local pet = AppData.getPetInfo().isPetInMyPetList(tonumber(info[1]))
        if pet == nil or pet.Lv < tonumber(info[2]) then
            return false
        end
    end
        
    if AppData.getUserInfo().getGold() < megaInfo.Gold then
        return false
    end

    return true
end

-- self._normal_content_bg = set:getElfNode("normal_content_bg")
-- self._normal_content_icon = set:getElfNode("normal_content_icon")
-- self._normal_content_pet = set:getElfNode("normal_content_pet")
-- self._normal_content_frame = set:getElfNode("normal_content_frame")
-- self._normal_ibg1 = set:getJoint9Node("normal_ibg1")
-- self._normal_name = set:getLabelNode("normal_name")
-- self._normal_anim = set:getSimpleAnimateNode("normal_anim")
-- self._normal_amount = set:getLabelNode("normal_amount")

function TLPetEvolve:getMaterialSet(index)
    if self.megaMSets == nil then
        self.megaMSets = {}
    end
    --local set = self.megaMSets[i]
    if self.megaMSets[index] == nil then
        local set = self:createLuaSet('@material')
        self._viewSet['bottom_list']:getContainer():addChild(set[1])
        table.insert(self.megaMSets, set)
    end

    return self.megaMSets[index]
end

function TLPetEvolve:updateMaterial(set, materialID, needAmount, hasAmount)
    set['normal_content_icon']:setResid(Res.getMaterialIcon(materialID))--'material_48.png')
    local material = DBManager.getInfoMaterial(materialID)
    set['normal_name']:setString(material.name)
    require 'LangAdapter'.LabelNodeAutoShrink(set['normal_name'],85)
    set['normal_amount']:setString(string.format('%d/%d', hasAmount, needAmount))--AppData.getBagInfo().getItemCount(megaInfo.MegaStoneId), megaInfo.MegaStoneAmt))
    set['normal_content_frame']:setResid(string.format('N_ZB_biankuang%d.png', material.color))
    if needAmount > hasAmount then--AppData.getBagInfo().getItemCount(megaInfo.MegaStoneId) < megaInfo.MegaStoneAmt then
        set['normal_amount']:setFontFillColor(ccc4f(1, 0, 0, 1.0), true)
    else
        --satisfyCount = satisfyCount + 1
        set['normal_amount']:setFontFillColor(ccc4f(1, 1, 1, 1.0), true)
    end
    set[1]:setListener(function()
        GleeCore:showLayer('DMaterialDetail',{materialId = materialID})
    end)
end

function TLPetEvolve:refreshMaterialList(petID)
    -- print('msg:--after--------------------------self.megaMIDs')
    -- print(self.megaMIDs)
    --self.megaMIDs = {}
    if not self.megaMIDs then
        self.megaMIDs = {}
    end

    if next(self.megaMIDs) ~= nil then
        for k, v in pairs(self.megaMIDs) do
            self.megaMIDs[k] = AppData.getPetInfo().getPetWithId(v.Id)
        end
        for i = 1, 2 do
            if self.megaMIDs[i] and self._Pet.Id == self.megaMIDs[i].Id then
                self.megaMIDs[i] = nil
            end
        end
    end
    local megaInfo = DBManager.getMegaConfig(petID)
    --print('msg:----------------------refreshMaterialList')
    -- print(megaInfo)
    local satisfyCount = 0
    --local totalCount = 5
    --print('msg:---------------------refreshMaterialList')
    for i = 1, 5 do-- + #megaInfo.Pets do
        --print('msg:---------------------for')
        local set = self:getMaterialSet(i)
        set['normal_anim']:setVisible(false)
        set['normal_content_icon']:setVisible(true)
        set['normal_content_pet']:setVisible(false)
    end
    self:updateMaterial(self.megaMSets[1], megaInfo.MegaStoneId, megaInfo.MegaStoneAmt, AppData.getBagInfo().getItemCount(megaInfo.MegaStoneId))
    if AppData.getBagInfo().getItemCount(megaInfo.MegaStoneId) >= megaInfo.MegaStoneAmt then
        satisfyCount = satisfyCount + 1
    end

    self:updateMaterial(self.megaMSets[2], megaInfo.StoneId, megaInfo.StoneAmt, AppData.getBagInfo().getItemCount(megaInfo.StoneId))
    if AppData.getBagInfo().getItemCount(megaInfo.StoneId) >= megaInfo.StoneAmt then
        satisfyCount = satisfyCount + 1
    end
    
    local words = {}
    for key in string.gmatch(megaInfo.Pets, '([^,]+)') do
        table.insert(words, key)
    end     
    
    for i = 1, #words do
        local info = {}
        for temp in string.gmatch(words[i], '([^:]+)') do
            table.insert(info, temp)
        end
        local mpets = self:getMegaMaterialList(i, tonumber(info[1])) --AppData.getPetInfo().getPetListByDBID(tonumber(info[1]))
        if mpets and next(mpets) then
            table.sort(mpets, function(pet1, pet2)                    
                return pet1.Lv > pet2.Lv
            end)
            if mpets[1].Lv >= tonumber(info[2]) then
                satisfyCount = satisfyCount + 1
            end
        end

        self:setMaterialPet(i, tonumber(info[1]), tonumber(info[2]), self.megaMIDs[i], self.megaMSets[2 + i])
    end
    
    for i = 1,2 do
        local set = self.megaMSets[2+i]
        set[1]:setScaleX(#words >= i and 1 or 0)
    end
    local totalCond = 3 + #words
    
    self:setMaterialGold(self.megaMSets[5], megaInfo.Gold)
    if AppData.getUserInfo().getGold() >= megaInfo.Gold then
        satisfyCount = satisfyCount + 1
    end

    if satisfyCount < totalCond then
        self._viewSet['btnEvolution']:setEnabled(false)
    end
    self._viewSet['bottom_consume']:setString(string.format('%s %d/%d', Res.locString('Evolution$_Consume'), satisfyCount,totalCond))
end

function TLPetEvolve:setMaterialGold(set, needAmount)
    set['normal_content_icon']:setResid('TY_jinbi_da.png')
    set['normal_name']:setString(Res.locString('Global$Gold'))
    --local userGold = AppData.getUserInfo().getGold()
    local limitV = 10000
    local flag = 'w'

    require 'LangAdapter'.selectLang(nil,nil,nil,nil,function ( ... )
        limitV = 1000
        flag = 'k'
    end)

    if needAmount > limitV then
        set['normal_amount']:setString(string.format('%d%s', needAmount / limitV,flag))
    else
        set['normal_amount']:setString(tostring(needAmount))
    end

    if AppData.getUserInfo().getGold() < needAmount then
        set['normal_amount']:setFontFillColor(ccc4f(1, 0, 0, 1.0), true)
    else
        
        set['normal_amount']:setFontFillColor(ccc4f(1, 1, 1, 1.0), true)
    end
end

function TLPetEvolve:getMegaMaterialList(index, petID)
    local preID = nil
    if index == 1 and self.megaMIDs[2] ~= nil then
        preID = self.megaMIDs[2].Id
    elseif index == 2 and self.megaMIDs[1] ~= nil then
        preID = self.megaMIDs[1].Id
    end
    --local mpets = AppData.getPetInfo().getPetListByDBIDEX(petID, preID)

    return AppData.getPetInfo().getPetListByDBIDEX(petID, {preID, self._Pet.Id})
end

function TLPetEvolve:setMaterialPet(index, petID, demiandLv, npet, set)
    --print('msg:-------------------TLPetEvolve:setMaterialPet')
    set['normal_content_icon']:setVisible(false) --setResid('material_48.png')
    set['normal_content_pet']:setVisible(true)

    set['normal_content_pet']:setResid(Res.getPetIcon(petID))
    local DBPet = DBManager.getCharactor(petID)
    set['normal_name']:setString(DBPet.name)
    -- local preID = nil
    -- if index == 1 and self.megaMIDs[2] ~= nil then
    --     preID == self.megaMIDs[2].Id
    -- elseif i(index == 2 and self.megaMIDs[1] ~= nil) then
    --     preID == self.megaMIDs[1].Id
    -- end
    local mpets = self:getMegaMaterialList(index, petID)
    --print('msg:---------------------------------mpets')
    --print(mpets[1])
    if mpets and next(mpets) then

        table.sort(mpets, function(pet1, pet2)
            if pet1.Lv >= demiandLv and pet2.Lv >= demiandLv then
                return pet1.Lv < pet2.Lv
            else
                return pet1.Lv > pet2.Lv
            end
        end)
        if npet == nil then
            npet = mpets[1]
            self.megaMIDs[index] = mpets[1]
        end
        if npet.Lv < demiandLv then
            set['normal_amount']:setFontFillColor(ccc4f(1, 0, 0, 1.0), true)
        else
            --atisfyCount = satisfyCount + 1
            set['normal_amount']:setFontFillColor(ccc4f(1, 1, 1, 1.0), true)
            
        end
    elseif npet == nil then
        set['normal_amount']:setFontFillColor(ccc4f(1, 0, 0, 1.0), true)
    end

    set['normal_amount']:setString(string.format('Lv.%d', demiandLv))
    if not npet then
        set['normal_content_frame']:setResid(Res.getPetPZ(0))
    else
        --set['normal_amount']:setString(string.format('Lv.%d', npet.Lv))
        set['normal_content_pet']:setResid(Res.getPetIcon(npet.PetId))
        set['normal_content_frame']:setResid(Res.getPetPZ(npet.AwakeIndex))
    end

    set[1]:setListener(function()
    -- body
        local materialpets = self:getMegaMaterialList(index, petID)
        if materialpets and next(materialpets) then
            table.sort(materialpets, function(pet1, pet2)
                if pet1.Lv >= demiandLv and pet2.Lv >= demiandLv then
                    return pet1.Lv < pet2.Lv
                else
                    return pet1.Lv > pet2.Lv
                end
            end)
            --print('msg:----------选择之前 index:  '..tostring(index))
            --print('msg:-------------'..tostring(self.megaMIDs[1].Id)..'   '..tostring(self.megaMIDs[2].Id))
            
            GleeCore:showLayer('DMegaMPetChose', {pets = materialpets, selectPet = self.megaMIDs[index], callBack = function(backPet)
                self.megaMIDs[index] = backPet

                -- print('msg:----------选择之后 index:  '..tostring(index))
                -- print('msg:-------------'..tostring(self.megaMIDs[1].Id)..'   '..tostring(self.megaMIDs[2].Id))
                --self:setMaterialPet(index, petID, demiandLv, backPet, set)
            end})
        else
            GleeCore:showLayer("DPetDetailV", {PetInfo = AppData.getPetInfo().getPetInfoByPetId(petID)})
        end
    end)
end

function TLPetEvolve:satisfySpecialCondition(petID)
    local charactor = DBManager.getCharactor(petID)
    if not charactor.ev_condition then
        return true
    end

    local conditions = {}
    for word in string.gmatch(charactor.ev_condition, '([^|]+)') do
        table.insert(conditions, word)
    end

    if conditions[1] == '1' then --在时间段内
        local curTimer = TimeManager.getCurrentSeverTime() / 1000-- / 3600
        local ldt = os.date('*t',curTimer)
        --print('msg:--------------- time:  '..string.format('%d-%d-%d %d:%d:%d',ldt.year,ldt.month,ldt.day,ldt.hour,ldt.min,ldt.sec))
        --self:toast(string.format('%d-%d-%d %d:%d:%d',ldt.year,ldt.month,ldt.day,ldt.hour,ldt.min,ldt.sec))
        --self:toast('fsdfdsafsadfsdfsadf')

        local hours = {}
        for hour in string.gmatch(conditions[2], '([^,]+)') do
            table.insert(hours, hour)
        end
        -- if ldt.hour >= tonumber(hours[1]) and ldt.hour < tonumber(hours[2]) then
        --     return true
        -- else
        --     if ldt.hour == tonumber(hours[2]) and ldt.min == 0 and ldt.sec == 0 then
        --         return true
        --     end

        --     return false
        -- end
        if require 'Toolkit'.isTimeBetween(tonumber(hours[1]), 0, tonumber(hours[2]), 0) then
            return true
        else
            return false
        end

    elseif conditions[1] == '2' then --拥有过某只精灵
        return AppData.getPetInfo().petCollected(tonumber(conditions[2]))
    elseif conditions[1] == '3' then --当前拥有金币XX
        if AppData.getUserInfo().getGold() < tonumber(conditions[2]) then
            return false
        else
            return true
        end
    elseif conditions[1] == '4' then --通过某个城镇 负的ID表示未通关
        local townID = tonumber(conditions[2])
        local negtive = false
        if townID < 0 then
            negtive = true
            townID = -townID
        end

        local town = AppData.getTownInfo().getTownById(townID)
        if not town then
            if negtive then
                return true
            else 
                return false
            end
        end

        if (not negtive and town.Clear) or (negtive and not town.Clear) then
            return true
        else
            return false
        end
    elseif conditions[1] == '5' then --当前激活队伍的队长是XX
        local team = AppData.getTeamInfo().getTeamActive() --teamFunc.getTeamActive()
        local CaptainPet = AppData.getPetInfo().getPetWithId(team.CaptainPetId)

        local charactor1 = DBManager.getCharactor(CaptainPet.PetId)
        local charactor2 = DBManager.getCharactor(tonumber(conditions[2]))
        --if CaptainPet.PetId == tonumber(conditions[2]) then
        if charactor1.skin_id == charactor2.skin_id then
            return true
        else
            return false
        end
    end
end

function TLPetEvolve:getPropID(property)
    local propID
    if property == 8 then
        propID = 43
    elseif property == 6 then
        propID = 44
    elseif property == 2 then
        propID = 45
    elseif property == 7 then
        propID = 46
    elseif property == 3 then
        propID = 47
    end

    return propID
end

function TLPetEvolve:playEvolveAnimate(rpet)
    self:setParentArrow(false)
    require 'framework.helper.MusicHelper'.playEffect("raw/ui_sfx_melt.mp3")
    self._viewSet['bottom_material_normal_anim']:setVisible(true)
    self._viewSet['bottom_material_normal_anim']:setLoops(1)
    self._viewSet['bottom_material_normal_anim']:reset()
    self._viewSet['bottom_material_normal_anim']:start()
    self._viewSet['bottom_material_normal_anim']:setListener(function()
        self._viewSet['bottom_material_normal_anim']:setVisible(false)
        GleeCore:showLayer('DPetEvolveAnimate', {ID1 = self._Pet.PetId, pet = rpet, callback = function()
            self:setParentArrow(true)
            self._parent:updatePet(rpet)
            require 'EventCenter'.eventInput("UpdatePetWithEvolve")
            --GleeCore:showLayer('DEvolveSucceed', {pet = rpet, titleResid = 'N_JH_jhcg.png'})
        end})
    end)
end

function TLPetEvolve:playMegaEvolveAnimate(rpet)
    self:setParentArrow(false)
    require 'framework.helper.MusicHelper'.playEffect("raw/ui_sfx_melt.mp3")

    --print('msg:---------before for coming???')
    for i = 1, 5 do
        --self:runWithDelay(function( ... )
            --print('msg:--------------------anima i :'..tostring(i))
            self.megaMSets[i]['normal_anim']:setVisible(true)
            self.megaMSets[i]['normal_anim']:setLoops(1)
            self.megaMSets[i]['normal_anim']:reset()
            self.megaMSets[i]['normal_anim']:start()
        --end, i * 0.2)
    end

    --print('msg:---------after for ')

    self.megaMSets[5]['normal_anim']:setListener(function()
        --print('msg:---------triggle ')
        for i = 1, 5 do
            self.megaMSets[i]['normal_anim']:setVisible(false)
        end
        GleeCore:showLayer('DPetEvolveAnimate', {ID1 = self._Pet.PetId, pet = rpet, callback = function()
            self:setParentArrow(true)
            self._parent:updatePet(rpet)
            require 'EventCenter'.eventInput("UpdatePetWithEvolve")
            --GleeCore:showLayer('DEvolveSucceed', {pet = rpet, titleResid = 'N_JH_jhcg.png'})
        end})
    end)
end

function TLPetEvolve:setParentArrow(enable)
    self._parent._root_btnLeft:setEnabled(enable)
    self._parent._root_btnRight:setEnabled(enable)
end

function TLPetEvolve:getAppropriateEvPet(ids)
    local speIds = {}
    for k, v in pairs(ids) do
        local resuletCharactor = DBManager.getCharactor(v)
        if self:satisfySpecialCondition(v) then
            table.insert(speIds, v)

            if resuletCharactor.ev_lv then
                if self._Pet.Lv >= resuletCharactor.ev_lv then
                    return resuletCharactor
                end
            else
-- [83] = {    name = [[mega进化5星等级]],  Key = [[Mega5StarLevelLimit]],  Value = 80, Des = [[mega进化5星等级]],},
-- [84] = {    name = [[mega进化5星觉醒等级]],    Key = [[Mega5StarAwakeLimit]],  Value = 24, Des = [[mega进化5星觉醒等级]],},
-- [85] = {    name = [[mega进化6星等级]],  Key = [[Mega6StarLevelLimit]],  Value = 80, Des = [[mega进化6星等级]],},
-- [86] = {    name = [[mega进化6星觉醒等级]],    Key = [[Mega6StarAwakeLimit]],  Value = 20, Des = [[mega进化6星觉醒等级]],},
                if (resuletCharactor.star_level == 5 and  self._Pet.Lv >= DBManager.getInfoDefaultConfig('Mega5StarLevelLimit').Value) or
                    (resuletCharactor.star_level == 6 and  self._Pet.Lv >= DBManager.getInfoDefaultConfig('Mega6StarLevelLimit').Value) then
                    return resuletCharactor
                end
            end
        end
    end

    if #speIds > 0 then 
        return DBManager.getCharactor(speIds[1])
    else
        return DBManager.getCharactor(ids[1])
    end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLPetEvolve, "TLPetEvolve")


return TLPetEvolve
