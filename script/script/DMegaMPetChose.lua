local Config = require "Config"

local DMegaMPetChose = class(LuaDialog)
local Res = require 'Res'
local DBManager = require 'DBManager'
local AppData = require 'AppData'
function DMegaMPetChose:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DMegaMPetChose.cocos.zip")
    return self._factory:createDocument("DMegaMPetChose.cocos")
end

--@@@@[[[[
function DMegaMPetChose:onInitXML()
	local set = self._set
    self._root = set:getElfNode("root")
    self._root_bg = set:getElfNode("root_bg")
    self._root_topBar_ftpos_tabs = set:getLinearLayoutNode("root_topBar_ftpos_tabs")
    self._root_topBar_ftpos_tabs_tab = set:getTabNode("root_topBar_ftpos_tabs_tab")
    self._root_topBar_ftpos_tabs_tab_normal_v = set:getLabelNode("root_topBar_ftpos_tabs_tab_normal_v")
    self._root_topBar_ftpos_tabs_tab_pRessed_v = set:getLabelNode("root_topBar_ftpos_tabs_tab_pRessed_v")
    self._root_topBar_ftpos2_close = set:getButtonNode("root_topBar_ftpos2_close")
    self._root_content = set:getElfNode("root_content")
    self._root_list = set:getListNode("root_list")
    self._pet = set:getElfNode("pet")
    self._pet_bg = set:getElfNode("pet_bg")
    self._pet_icon = set:getElfNode("pet_icon")
    self._pet_frame = set:getElfNode("pet_frame")
    self._pet_property = set:getElfNode("pet_property")
    self._pet_career = set:getElfNode("pet_career")
    self._starLayout = set:getLayoutNode("starLayout")
    self._nameBg = set:getElfNode("nameBg")
    self._nameBg_name = set:getLabelNode("nameBg_name")
    self._Quality = set:getLabelNode("Quality")
    self._Lv = set:getLabelNode("Lv")
    self._Atk = set:getLabelNode("Atk")
    self._Hp = set:getLabelNode("Hp")
    self._btnSelect = set:getClickNode("btnSelect")
    self._btnSelect_title = set:getLabelNode("btnSelect_title")
    self._onTeam = set:getElfNode("onTeam")
    self._select = set:getElfNode("select")
--    self._@size = set:getElfNode("@size")
--    self._@star = set:getElfNode("@star")
end
--@@@@]]]]

-- {pets = mpets, selectPet = self.megaMIDs[i], callBack = function(backPet)
--------------------------------override functions----------------------
function DMegaMPetChose:onInit( userData, netData )
    Res.doActionDialogShow(self._root)
	local size = CCDirector:sharedDirector():getWinSize()
    self._root_list:setContentSize(CCSize(size.width, self._root_list:getHeight()))
    self._root_bg:setScaleX(size.width / self._root_bg:getWidth())
    --self:setListenerEvent()
    self._root_topBar_ftpos2_close:setTriggleSound(Res.Sound.back)
    self._root_topBar_ftpos2_close:setListener(function (  )
        Res.doActionDialogHide(self._root, self)
    end)

    self:updatePetList(userData.pets)
    self._root_topBar_ftpos_tabs_tab:trigger(nil)
end

function DMegaMPetChose:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DMegaMPetChose:updatePetList(itemListData)
    --self._root_list:stopAllActions()
    --self._root_list:getContainer():removeAllChildrenWithCleanup(true)
    if not itemListData then return end

    if self:getUserData().selectPet ~=nil then
        local itemSet = self:createLuaSet("@size")
        self:refReshCell(itemSet, self:getUserData().selectPet)
        self._root_list:getContainer():addChild(itemSet[1])
    end

    for i, v in ipairs(itemListData) do
        if v.Id ~= self:getUserData().selectPet.Id then
            local itemSet = self:createLuaSet("@size")
            self:refReshCell(itemSet, v)
            self._root_list:getContainer():addChild(itemSet[1])
        end
    end

    self._root_list:layout()
end

function DMegaMPetChose:refReshCell(itemSet, nPet)
    local dbPet = DBManager.getCharactor(nPet.PetId)
    if dbPet then
        itemSet['nameBg_name']:setString(Res.getPetNameWithSuffix(nPet))
        itemSet['pet_frame']:setResid(Res.getPetPZ(nPet.AwakeIndex))
        itemSet['pet_icon']:setResid(Res.getPetIcon(nPet.PetId))
        itemSet["pet_property"]:setResid(Res.getPetPropertyIcon(dbPet.prop_1,true))
        itemSet["pet_career"]:setResid(Res.getPetCareerIcon(dbPet.atk_method_system))
        require 'PetNodeHelper'.updateStarLayout(itemSet['starLayout'],dbPet)
        
        local petFunc = AppData.getPetInfo()

        if AppData.getPetInfo().inTeamOrPartner(nPet.Id) then
            itemSet['onTeam']:setResid('N_JLLB_wenzi.png')
        elseif AppData.getExploreInfo().petInExploration(nPet.Id) then
            itemSet['onTeam']:setResid('N_JLLB_wenzi2.png')
        else
            itemSet['onTeam']:setVisible(false)
        end
        --itemSet['onTeam']:setVisible(petFunc.isPetInActiveTeam(nPet.Id))
        itemSet["Quality"]:setString(dbPet.quality)
        
        local userInfo = AppData.getUserInfo()
        -- local levelCapTable = DBManager.getInfoRoleLevelCap(userInfo.getLevel())
        itemSet["Lv"]:setString(string.format("%d/%d", nPet.Lv, DBManager.getPetLvCap(nPet)))
        itemSet["Atk"]:setString(nPet.Atk)
        itemSet["Hp"]:setString(nPet.Hp)

        itemSet["btnSelect"]:setListener(function (  )
            if self:getUserData().callBack then
                self:getUserData().callBack(nPet)
                -- print('msg:-----------before sel')
                -- print(nPet)
                self:close()
                -- if self.updatePetEvent(nPet.Id) then
                --     self:close()
                -- end
            end
        end)
        --itemSet["btnSelect"]:setTouchGiveUpOnMoveOrOutOfRange(true)
        -- itemSet["offloadBg"]:setVisible(self.offloadPetId and self.offloadPetId == nPet.Id)
        -- if self.offloadPetId and self.offloadPetId == nPet.Id then
        --     itemSet["btnSelect_title"]:setString(Res.locString("Pet$TeamOffload"))
        -- else
        --     itemSet["btnSelect_title"]:setString(Res.locString("Pet$TouchSelect"))
        -- end

        if self:getUserData().selectPet.Id == nPet.Id then
            --local found = table.find(self.selected, nPet.Id)
            itemSet['select']:setVisible(true)
            itemSet['btnSelect']:setEnabled(false)
        end
    end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DMegaMPetChose, "DMegaMPetChose")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DMegaMPetChose", DMegaMPetChose)


