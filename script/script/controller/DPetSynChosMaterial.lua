local Config = require "Config"
local Res = require "Res"
local DPetSynChosMaterial = class(LuaDialog)
local dbManager = require "DBManager"
local AppData = require 'AppData'

function DPetSynChosMaterial:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPetSynChosMaterial.cocos.zip")
    return self._factory:createDocument("DPetSynChosMaterial.cocos")
end

--@@@@[[[[
function DPetSynChosMaterial:onInitXML()
	local set = self._set
    self._root = set:getElfNode("root")
    self._root_bg = set:getElfNode("root_bg")
    self._root_topBar_ftpos_tabs = set:getLinearLayoutNode("root_topBar_ftpos_tabs")
    self._root_topBar_ftpos_tabs_tab = set:getTabNode("root_topBar_ftpos_tabs_tab")
    self._root_topBar_ftpos2_close = set:getButtonNode("root_topBar_ftpos2_close")
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
    self._flagIcon = set:getElfNode("flagIcon")
    self._select = set:getElfNode("select")
--    self._@cell = set:getElfNode("@cell")
--    self._@star = set:getElfNode("@star")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DPetSynChosMaterial:onInit( userData, netData )
  -- couldCancel  是否能点击取消
  -- selectPets  已经选中的精灵
  -- petList 精灵列表
  -- 
  Res.doActionDialogShow(self._root)
  self._root_topBar_ftpos2_close:setListener(function (  )
      Res.doActionDialogHide(self._root, self)
  end)

  local size = CCDirector:sharedDirector():getWinSize()
  self._root_list:setContentSize(CCSize(size.width, self._root_list:getHeight()))
  self._root_bg:setScaleX(size.width / self._root_bg:getWidth())

  self:updatePetList()
  self._root_topBar_ftpos_tabs_tab:trigger(nil)
end

function DPetSynChosMaterial:onBack( userData, netData )
    
end

function DPetSynChosMaterial:close()
  
end

--------------------------------custom code-----------------------------

function DPetSynChosMaterial:updatePetList()

  for i, v in pairs(self:getUserData().petList) do
    if i <= 7 then
      local itemSet = self:createLuaSet("@cell")
      self:refReshCell(itemSet,v)
      self._root_list:getContainer():addChild(itemSet[1])
      -- if i == 1 then
      --   firstset = itemSet
      -- end
      if i == 1 then
        itemSet['select']:setVisible(true)
      end
    else
      self:runWithDelay(function ( ... )
        local itemSet = self:createLuaSet("@cell")
        self:refReshCell(itemSet, v)
        self._root_list:getContainer():addChild(itemSet[1])
      end,0.1 * (i-7), self._root_list)
    end
  end
  self._root_list:layout()
end

function DPetSynChosMaterial:refReshCell(itemSet,nPet)
  local dbPet = dbManager.getCharactor(nPet.PetId)
  if dbPet then
    
    itemSet['nameBg_name']:setString(Res.getPetNameWithSuffix(nPet))
    itemSet['pet_frame']:setResid(Res.getPetIconFrame(nPet))
    itemSet['pet_icon']:setResid(Res.getPetIcon(nPet.PetId))
    itemSet["pet_property"]:setResid(Res.getPetPropertyIcon(dbPet.prop_1,true))
    itemSet["pet_career"]:setResid(Res.getPetCareerIcon(dbPet.atk_method_system))

    require 'PetNodeHelper'.updateStarLayout(itemSet["starLayout"], dbPet)
    
    -- for i=1, dbPet.star_level do
    --   local star = self:createLuaSet("@star")
    --   itemSet["starLayout"]:addChild(star[1])
    -- end

    -- if AppData.getPetInfo().petInStorage(nPet.Id) then
    --   itemSet['flagIcon']:setResid('N_JLLB_wenzi3.png')
    -- else
    if AppData.getPetInfo().inTeamOrPartner(nPet.Id) then
      itemSet['flagIcon']:setResid('N_JLLB_wenzi.png')
    --elseif --探宝中 
    elseif AppData.getExploreInfo().petInExploration(nPet.Id) then
      itemSet['flagIcon']:setResid('N_JLLB_wenzi2.png')
    else
      itemSet['flagIcon']:setVisible(false)
    end

    itemSet["Quality"]:setString(dbPet.quality)
    
    --local userInfo = gameFunc.getUserInfo()
    -- local levelCapTable = dbManager.getInfoRoleLevelCap(userInfo.getLevel())
    itemSet["Lv"]:setString(string.format("%d/%d", nPet.Lv, dbManager.getPetLvCap(nPet)))
    itemSet["Atk"]:setString(nPet.Atk)
    itemSet["Hp"]:setString(nPet.Hp)

    itemSet["btnSelect"]:setListener(function (  )
      if self:getUserData().selectCallback then
        self:getUserData().selectCallback(nPet)
      end
      self:close()
    end)
  end
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPetSynChosMaterial, "DPetSynChosMaterial")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPetSynChosMaterial", DPetSynChosMaterial)


