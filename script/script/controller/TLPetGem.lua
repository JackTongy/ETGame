local Config = require "Config"
local DBManager = require "DBManager"
local NetModel = require 'netModel'
local Res = require 'Res'
local AppData = require 'AppData'
local TimeManager = require 'TimeManager'
local UnlockManager = require 'UnlockManager'
local eventcenter = require "EventCenter"
local GuideHelper = require 'GuideHelper'

local TLPetGem = class(TabLayer)

function TLPetGem:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLPetGem.cocos.zip")
    return self._factory:createDocument("TLPetGem.cocos")
end

--@@@@[[[[
function TLPetGem:onInitXML()
    local set = self._set
   self._right = set:getJoint9Node("right")
   self._right_BG_gemList = set:getListNode("right_BG_gemList")
   self._label = set:getLabelNode("label")
   self._layout = set:getLinearLayoutNode("layout")
   self._normal_icon = set:getElfNode("normal_icon")
   self._normal_frame = set:getElfNode("normal_frame")
   self._normal_title = set:getLabelNode("normal_title")
   self._right_BG_none = set:getLabelNode("right_BG_none")
   self._right_originLayout = set:getLinearLayoutNode("right_originLayout")
   self._right_originLayout_l1 = set:getLabelNode("right_originLayout_l1")
   self._right_originLayout_l2 = set:getLabelNode("right_originLayout_l2")
   self._right_originLayout_l3 = set:getLabelNode("right_originLayout_l3")
   self._left = set:getJoint9Node("left")
   self._left_tips = set:getLabelNode("left_tips")
   self._left_slot1 = set:getElfNode("left_slot1")
   self._left_slot1_gem = set:getColorClickNode("left_slot1_gem")
   self._left_slot1_gem_normal_icon = set:getElfNode("left_slot1_gem_normal_icon")
   self._left_slot1_gem_normal_frame = set:getElfNode("left_slot1_gem_normal_frame")
   self._left_slot1_gem_normal_title = set:getLabelNode("left_slot1_gem_normal_title")
   self._left_slot1_none = set:getColorClickNode("left_slot1_none")
   self._left_slot1_none_normal_flag = set:getElfNode("left_slot1_none_normal_flag")
   self._left_slot1_none_normal_des = set:getLabelNode("left_slot1_none_normal_des")
   self._left_slot2 = set:getElfNode("left_slot2")
   self._left_slot2_gem = set:getColorClickNode("left_slot2_gem")
   self._left_slot2_gem_normal_icon = set:getElfNode("left_slot2_gem_normal_icon")
   self._left_slot2_gem_normal_frame = set:getElfNode("left_slot2_gem_normal_frame")
   self._left_slot2_gem_normal_title = set:getLabelNode("left_slot2_gem_normal_title")
   self._left_slot2_none = set:getColorClickNode("left_slot2_none")
   self._left_slot2_none_normal_flag = set:getElfNode("left_slot2_none_normal_flag")
   self._left_slot2_none_normal_des = set:getLabelNode("left_slot2_none_normal_des")
   self._left_slot3 = set:getElfNode("left_slot3")
   self._left_slot3_gem = set:getColorClickNode("left_slot3_gem")
   self._left_slot3_gem_normal_icon = set:getElfNode("left_slot3_gem_normal_icon")
   self._left_slot3_gem_normal_frame = set:getElfNode("left_slot3_gem_normal_frame")
   self._left_slot3_gem_normal_title = set:getLabelNode("left_slot3_gem_normal_title")
   self._left_slot3_none = set:getColorClickNode("left_slot3_none")
   self._left_slot3_none_normal_flag = set:getElfNode("left_slot3_none_normal_flag")
   self._left_slot3_none_normal_des = set:getLabelNode("left_slot3_none_normal_des")
   self._left_slot4 = set:getElfNode("left_slot4")
   self._left_slot4_gem = set:getColorClickNode("left_slot4_gem")
   self._left_slot4_gem_normal_icon = set:getElfNode("left_slot4_gem_normal_icon")
   self._left_slot4_gem_normal_frame = set:getElfNode("left_slot4_gem_normal_frame")
   self._left_slot4_gem_normal_title = set:getLabelNode("left_slot4_gem_normal_title")
   self._left_slot4_none = set:getColorClickNode("left_slot4_none")
   self._left_slot4_none_normal_flag = set:getElfNode("left_slot4_none_normal_flag")
   self._left_slot4_none_normal_des = set:getLabelNode("left_slot4_none_normal_des")
--   self._@view = set:getElfNode("@view")
--   self._@title = set:getElfNode("@title")
--   self._@gemLine = set:getElfNode("@gemLine")
--   self._@gem = set:getColorClickNode("@gem")
end
--@@@@]]]]

--------------------------------override functions----------------------
function TLPetGem:onInit( userData, netData )
    self._maxGemAmount = 4
end

function TLPetGem:onEnter( ... )
    self._firstGemNode = nil

    self._Pet = (self._parent:getUserData() and self._parent:getUserData().pet)
    self:updateView()
    --self._parent:setVisible(false)
    GuideHelper:registerPoint('firstGem',self._firstGemNode)
    GuideHelper:check('TLPetGem')
end

function TLPetGem:onBack( userData, netData )

end

--------------------------------custom code-----------------------------

function TLPetGem:updateView()
    -- update left
    --local pet = self._Pet
    local gems = AppData.getGemInfo().getGemWithPetId(self._Pet.Id) or {}
    for i = 1, self._maxGemAmount do
        if i > #gems then
            self:refreshGemWear(i)
        else
            self:refreshGemWear(i, gems[i])
        end
    end

    -- updateg gem list
    self._viewSet['right_BG_gemList']:getContainer():removeAllChildrenWithCleanup(true)
    if AppData.getGemInfo().getGemAmountX() > 0 then
        self._viewSet['right_BG_none']:setVisible(false)
    else
        self._viewSet['right_BG_none']:setVisible(true)
    end

    for i = 1, 6 do
        local gems = AppData.getGemInfo().getGemAvailableByType(i)
        if gems and next(gems) then
            table.sort(gems, function(gem1, gem2)
                local couldW1 = self:couldWear(gem1)
                local couldW2 = self:couldWear(gem2)

                if couldW1 ~= couldW2 then
                    return couldW1
                elseif gem1.Lv ~= gem2.Lv then
                    return gem1.Lv > gem2.Lv
                else
                    return gem1.GemId < gem2.GemId
                end
            end)
            self:refreshGemsByType(i, gems)
        end
    end

    require 'LangAdapter'.fontSize(self._viewSet['left_tips'],nil,nil,nil,nil,nil,nil,nil,nil,nil,19)
end

function TLPetGem:couldWear(gem)
    local DBGemLv = DBManager.getInfoGemLevelUp(gem.Lv)
    if DBGemLv.awake > self._Pet.AwakeIndex then
        return false
    else
        return true
    end
end

function TLPetGem:refreshGemsByType(index, gems)
    local topSet = self:createLuaSet('@title')
    topSet['label']:setString(Res.locString(string.format('PetGem$_Type%d', index)))
    self._viewSet['right_BG_gemList']:getContainer():addChild(topSet[1])

    local lineAmount = #gems / 4
    if #gems % 4 > 0 then
        lineAmount = lineAmount + 1
    end

    for i = 1, lineAmount do
        local lineSet = self:createLuaSet('@gemLine')
        self._viewSet['right_BG_gemList']:getContainer():addChild(lineSet[1])
        for j = 1, 4 do
            local gIndex = (i - 1) * 4 + j
            if gIndex > #gems then break end
            local set = self:createLuaSet('@gem')
            lineSet['layout']:addChild(set[1])
            self:refreshGem(gems[gIndex], set)
        end
        lineSet['layout']:layout()
    end
end

function TLPetGem:refreshGem(gem, set)
    local DBGem = DBManager.getInfoGem(gem.GemId)
    set['normal_icon']:setResid(Res.getGemIcon(gem.GemId))
    set['normal_frame']:setResid(Res.getGemIconFrame(gem.Lv))
    set['normal_title']:setString(DBGem.name)

    self._firstGemNode = self._firstGemNode or set[1]
    -- show gem detail dialog
    set[1]:setListener(function()
        local param = {}
        param.GemInfo = gem
        param.BtnExText = Res.locString("PetGem$_Wear")
        param.BtnExFunc = function ()
            local gems = AppData.getGemInfo().getGemWithPetId(self._Pet.Id)
            local curSolt = #gems + 1
            if #gems >= self._maxGemAmount then
                return self:toast(Res.locString('PetGem$_AmountLimit'))
            end
            if curSolt > 2 then--if DBManager.getInfoEquipTp(self.equipInfo.Tp).gemlv < gem.Lv then
                local solt = DBManager.getInfoDefaultConfig(string.format('GemPlace%dUnlocklv', curSolt))
                if solt.Value > AppData.getUserInfo().getLevel() then
                    return self:toast(Res.locString('PetGem$_AmountLimit'))
                end
            end
            local DBGem = DBManager.getInfoGem(gem.GemId)
            if self:hasSameTypeGem(DBGem.type, gems) then
                return self:toast(Res.locString('PetGem$_HasSameGem'))
            end

            -- check awake lv
            local DBGemLv = DBManager.getInfoGemLevelUp(gem.Lv)
            if DBGemLv.awake > self._Pet.AwakeIndex then
                local awakeColor = nil
                if DBGemLv.awake == 4 then --绿色
                    awakeColor = Res.locString("Global$ColorGreen")
                elseif DBGemLv.awake == 8 then -- 蓝色
                    awakeColor = Res.locString("Global$ColorBlue")
                elseif DBGemLv.awake == 12 then -- 紫色
                    awakeColor = Res.locString("Global$ColorPurple")
                elseif DBGemLv.awake == 16 then -- 橙色
                    awakeColor = Res.locString("Global$ColorOrange")
                elseif DBGemLv.awake == 20 then -- 金色
                    awakeColor = Res.locString("Global$ColorGolden")
                elseif DBGemLv.awake == 24 then -- 红色
                    awakeColor = Res.locString("Global$ColorRed")
                end

                if awakeColor then
                    return self:toast(string.format(Res.locString('PetGem$_AwakeLimit'), awakeColor))
                end
            end

            self:send(NetModel.getmodeMosaicGem(self._Pet.Id, gem.Id),function(data)
                if data.D.Pet then
                    AppData.getPetInfo().setPet(data.D.Pet)
                    --require "PetInfo".setPet(data.D.Pet)
                end
                -- print('msg:--------------------------------')
                -- print(data.D.Pet)
                require 'framework.helper.MusicHelper'.playEffect("raw/ui_sfx_inlay.mp3")
                self:toast(Res.locString('PetGem$_Wear_Succeed'))
                gem.SetIn = self._Pet.Id
                
                AppData.getGemInfo().updateGem(gem)
                
                eventcenter.eventInput("OnEquipmentUpdate")
                eventcenter.eventInput("OnGemUpdate")
                self._parent:updatePet(data.D.Pet)
                --self:updateView()
            end)
            
        end
        GleeCore:showLayer("DGemDetail",param)
    end)
end

function TLPetGem:hasSameTypeGem(_type, gems)
    if not gems then
        gems = AppData.getGemInfo().getGemWithPetId(self._Pet.Id)
    end

    for k, v in pairs(gems) do
        local DBGem = DBManager.getInfoGem(v.GemId)
        if DBGem.type == _type then
            return true
        end
    end
    return false
end

function TLPetGem:refreshGemWear(index, gem)
    self._viewSet[string.format('left_slot%d_none', index)]:setEnabled(false)

    if gem then
        local DBGem = DBManager.getInfoGem(gem.GemId)
        self._viewSet[string.format('left_slot%d_gem', index)]:setVisible(true)
        self._viewSet[string.format('left_slot%d_none', index)]:setVisible(false)
        self._viewSet[string.format('left_slot%d_gem_normal_icon', index)]:setResid(Res.getGemIcon(gem.GemId))
        self._viewSet[string.format('left_slot%d_gem_normal_frame', index)]:setResid(Res.getGemIconFrame(gem.Lv))
        self._viewSet[string.format('left_slot%d_gem_normal_title', index)]:setString(DBGem.name)

        self._viewSet[string.format('left_slot%d_gem', index)]:setListener(function()
            local param = {}
            param.GemInfo = gem
            param.BtnExText = Res.locString("PetGem$_GetOff")
            param.BtnExFunc = function ()
                self:send(NetModel.getmodeDisbandGem(gem.Id),function ( data )
                    if data.D.Pet then
                        AppData.getPetInfo().setPet(data.D.Pet)
                    end
                    self:toast(Res.locString('PetGem$_GetOff_Toast'))
                    gem.SetIn = 0
                    AppData.getGemInfo().updateGem(gem)

                    eventcenter.eventInput("OnEquipmentUpdate")
                    eventcenter.eventInput("OnGemUpdate")
                    -- local container = set["reformDetailBg_reformInfoBg_gemList"]:getContainer()
                    self._parent:updatePet(data.D.Pet)
                    --self:updateView()
                end)
            end
            GleeCore:showLayer("DGemDetail", param)
        end)
    else
        self._viewSet[string.format('left_slot%d_gem', index)]:setVisible(false)
        self._viewSet[string.format('left_slot%d_none', index)]:setVisible(true)
        self._viewSet[string.format('left_slot%d_none_normal_flag', index)]:setResid('N_PD_j.png')
        self._viewSet[string.format('left_slot%d_none_normal_des', index)]:setString('')

        if index > 2 then
            local solt = DBManager.getInfoDefaultConfig(string.format('GemPlace%dUnlocklv', index))
            --运营关闭的情况
            if solt.Value >= 999 then
                --local solt = DBManager.getInfoDefaultConfig(string.format('GemPlace%dUnlocklv', index))
                self._viewSet[string.format('left_slot%d_none_normal_flag', index)]:setResid('N_PD_s.png')
                self._viewSet[string.format('left_slot%d_none', index)]:setEnabled(true)
                self._viewSet[string.format('left_slot%d_none', index)]:setListener(function()
                    self:toast(solt.Des)
                end)
                --正常未解锁的情况
            elseif solt.Value > AppData.getUserInfo().getLevel() then
                self._viewSet[string.format('left_slot%d_none_normal_flag', index)]:setResid('N_PD_s.png')
                self._viewSet[string.format('left_slot%d_none_normal_des', index)]:setString(string.format(Res.locString('PetGem$_X_Levle'), solt.Value))
                self._viewSet[string.format('left_slot%d_none', index)]:setEnabled(true)
                self._viewSet[string.format('left_slot%d_none', index)]:setListener(function()
                    self:toast(solt.Des)
                end)
            end
        end
    end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLPetGem, "TLPetGem")


--------------------------------register--------------------------------
return TLPetGem
