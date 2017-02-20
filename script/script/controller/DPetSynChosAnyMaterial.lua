local Config = require "Config"
local Res = require "Res"
local dbManager = require "DBManager"
local AppData = require 'AppData'

local DPetSynChosAnyMaterial = class(LuaDialog)

function DPetSynChosAnyMaterial:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPetSynChosAnyMaterial.cocos.zip")
    return self._factory:createDocument("DPetSynChosAnyMaterial.cocos")
end

--@@@@[[[[
function DPetSynChosAnyMaterial:onInitXML()
	local set = self._set
    self._root = set:getElfNode("root")
    self._root_bg = set:getElfNode("root_bg")
    self._root_topBar_ftpos_tabs = set:getLinearLayoutNode("root_topBar_ftpos_tabs")
    self._root_topBar_ftpos_tabs_tab = set:getTabNode("root_topBar_ftpos_tabs_tab")
    self._root_topBar_ftpos2_close = set:getButtonNode("root_topBar_ftpos2_close")
    self._root_list = set:getListNode("root_list")
    self._normal_pet = set:getElfNode("normal_pet")
    self._normal_pet_bg = set:getElfNode("normal_pet_bg")
    self._normal_pet_icon = set:getElfNode("normal_pet_icon")
    self._normal_pet_frame = set:getElfNode("normal_pet_frame")
    self._normal_pet_property = set:getElfNode("normal_pet_property")
    self._normal_pet_career = set:getElfNode("normal_pet_career")
    self._normal_pet_flagIcon = set:getElfNode("normal_pet_flagIcon")
    self._normal_nameBg = set:getElfNode("normal_nameBg")
    self._normal_nameBg_name = set:getLabelNode("normal_nameBg_name")
    self._normal_starLayout = set:getLayoutNode("normal_starLayout")
    self._normal_lv_value = set:getLabelNode("normal_lv_value")
    self._normal_quality_value = set:getLabelNode("normal_quality_value")
    self._normal_select = set:getElfNode("normal_select")
    self._root_value = set:getLabelNode("root_value")
    self._root_btnSign = set:getClickNode("root_btnSign")
    self._root_btnSign_des = set:getLabelNode("root_btnSign_des")
--    self._@cellClick = set:getColorClickNode("@cellClick")
--    self._@star = set:getElfNode("@star")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DPetSynChosAnyMaterial:onInit( userData, netData )
  -- selectPets  已经选中的精灵
  -- petList 精灵列表
  -- 
  self._backup = table.clone(userData.selectPets)

  Res.doActionDialogShow(self._root)
  self._root_topBar_ftpos2_close:setListener(function (  )
    self:getUserData().selectCallback(self._backup)
      Res.doActionDialogHide(self._root, self)
  end)

  local size = CCDirector:sharedDirector():getWinSize()
  self._root_list:setContentSize(CCSize(size.width, self._root_list:getHeight()))
  self._root_bg:setScaleX(size.width / self._root_bg:getWidth())

  self:updateDialog()
  self._root_topBar_ftpos_tabs_tab:trigger(nil)
end

function DPetSynChosAnyMaterial:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DPetSynChosAnyMaterial:updateDialog()
    self:refreshSelAmount()
    self._root_btnSign:setListener(function()
        if self:getUserData().selectCallback then
            self:getUserData().selectCallback(self:getUserData().selectPets)
        end
        self:close()
    end)
    self:updatePetList()
end

function DPetSynChosAnyMaterial:refreshSelAmount()
    local amount = 0
    if self:getUserData().selectPets then
        amount = #self:getUserData().selectPets
    end

    self._root_value:setString(string.format('%s%d', Res.locString('PetSynthesis$_Select_Pet'), amount))
end

function DPetSynChosAnyMaterial:updatePetList()

  for i, v in pairs(self:getUserData().petList) do
    if i <= 7 then
      local itemSet = self:createLuaSet("@cellClick")
      self:refReshCell(itemSet,v)
      self._root_list:getContainer():addChild(itemSet[1])
      -- if i == 1 then
      --   firstset = itemSet
      -- end
    else
      self:runWithDelay(function ( ... )
        local itemSet = self:createLuaSet("@cellClick")
        self:refReshCell(itemSet, v)
        self._root_list:getContainer():addChild(itemSet[1])
      end,0.1 * (i-7), self._root_list)
    end
  end
  self._root_list:layout()
end

function DPetSynChosAnyMaterial:refReshCell(itemSet,nPet)

    -- self._normal_pet = set:getElfNode("normal_pet")
    -- self._normal_pet_bg = set:getElfNode("normal_pet_bg")
    -- self._normal_pet_icon = set:getElfNode("")
    -- self._normal_pet_frame = set:getElfNode("")
    -- self._normal_pet_property = set:getElfNode("")
    -- self._normal_pet_career = set:getElfNode("")
    -- self._normal_pet_flagIcon = set:getElfNode("")
    -- self._normal_nameBg = set:getElfNode("normal_nameBg")
    -- self._normal_nameBg_name = set:getLabelNode("")
    -- self._normal_starLayout = set:getLayoutNode("")
    -- self._normal_lv_value = set:getLabelNode("normal_lv_value")
    -- self._normal_quality_value = set:getLabelNode("normal_quality_value")
    -- self._normal_select = set:getElfNode("")

    local dbPet = dbManager.getCharactor(nPet.PetId)
    itemSet['normal_nameBg_name']:setString(Res.getPetNameWithSuffix(nPet))
    itemSet['normal_pet_frame']:setResid(Res.getPetIconFrame(nPet))
    itemSet['normal_pet_icon']:setResid(Res.getPetIcon(nPet.PetId))
    itemSet["normal_pet_property"]:setResid(Res.getPetPropertyIcon(dbPet.prop_1,true))
    itemSet["normal_pet_career"]:setResid(Res.getPetCareerIcon(dbPet.atk_method_system))

    require 'PetNodeHelper'.updateStarLayout(itemSet["starLayout"], dbPet)

    -- for i=1, dbPet.star_level do
    --   local star = self:createLuaSet("@star")
    --   itemSet["normal_starLayout"]:addChild(star[1])
    -- end

    -- if AppData.getPetInfo().petInStorage(nPet.Id) then
    --   itemSet['normal_pet_flagIcon']:setResid('N_JLLB_wenzi3.png')
    -- else
    if AppData.getPetInfo().inTeamOrPartner(nPet.Id) then
      itemSet['normal_pet_flagIcon']:setResid('N_JLLB_wenzi.png')
    elseif AppData.getExploreInfo().petInExploration(nPet.Id) then
      itemSet['normal_pet_flagIcon']:setResid('N_JLLB_wenzi2.png')
    else
      itemSet['normal_pet_flagIcon']:setVisible(false)
    end

    itemSet["normal_quality_value"]:setString(dbPet.quality)

    --local userInfo = gameFunc.getUserInfo()
    -- local levelCapTable = dbManager.getInfoRoleLevelCap(userInfo.getLevel())
    itemSet["normal_lv_value"]:setString(string.format("%d/%d", nPet.Lv, dbManager.getPetLvCap(nPet)))
    -- itemSet["Atk"]:setString(nPet.Atk)
    -- itemSet["Hp"]:setString(nPet.Hp)

    if self:petSelected(nPet.Id) then
        itemSet['normal_select']:setVisible(true)
    else
        itemSet['normal_select']:setVisible(false)
    end

    itemSet[1]:setListener(function (  )
        -- if self:getUserData().selectCallback then
        --   self:getUserData().selectCallback(nPet)
        -- end
        -- self:close()
        

        for k, v in pairs(self:getUserData().selectPets) do
            if v.Id == nPet.Id then
                table.remove(self:getUserData().selectPets, k)
                itemSet['normal_select']:setVisible(false)
                self:refreshSelAmount()
                return
            end
        end

        if #self:getUserData().selectPets == 2  then
            --if not self:getUserData().selectPets[1].missing and not self:getUserData().selectPets[2].missing then
              return self:toast(Res.locString('PetSynthesis$_Select_Limit'))
            -- end
            -- for
            -- return
        end

        --if not inTable then
            table.insert(self:getUserData().selectPets, nPet)
            self:refreshSelAmount()
            itemSet['normal_select']:setVisible(true)
        --end

    end)
end

function DPetSynChosAnyMaterial:petSelected(ID)
    for k, v in pairs(self:getUserData().selectPets) do
        if v.Id == ID then
            return true
        end
    end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPetSynChosAnyMaterial, "DPetSynChosAnyMaterial")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPetSynChosAnyMaterial", DPetSynChosAnyMaterial)


