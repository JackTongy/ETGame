local Config = require "Config"
local DBManager = require "DBManager"
local Res = require 'Res'
local AppData = require 'AppData'

local DExploreChosPet = class(LuaDialog)

function DExploreChosPet:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DExploreChosPet.cocos.zip")
    return self._factory:createDocument("DExploreChosPet.cocos")
end

--@@@@[[[[
function DExploreChosPet:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg = set:getElfNode("root_bg")
   self._root_topBar_ftpos_tabs = set:getLinearLayoutNode("root_topBar_ftpos_tabs")
   self._root_topBar_ftpos_tabs_tab = set:getTabNode("root_topBar_ftpos_tabs_tab")
   self._root_topBar_ftpos_tabs_tab_normal_des = set:getLabelNode("root_topBar_ftpos_tabs_tab_normal_des")
   self._root_topBar_ftpos_tabs_tab_pressed_des = set:getLabelNode("root_topBar_ftpos_tabs_tab_pressed_des")
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
   self._Power = set:getLabelNode("Power")
   self._btnSelect = set:getClickNode("btnSelect")
   self._btnSelect_title = set:getLabelNode("btnSelect_title")
   self._flagIcon = set:getElfNode("flagIcon")
   self._select = set:getElfNode("select")
--   self._@cell = set:getElfNode("@cell")
--   self._@star = set:getElfNode("@star")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DExploreChosPet:onInit( userData, netData )
    Res.doActionDialogShow(self._root)
    self._root_topBar_ftpos2_close:setListener(function (  )
        Res.doActionDialogHide(self._root, self)
    end)

    local size = CCDirector:sharedDirector():getWinSize()
    self._root_list:setContentSize(CCSize(size.width, self._root_list:getHeight()))
    self._root_bg:setScaleX(size.width / self._root_bg:getWidth())

    self:updatePetList()
    self._root_topBar_ftpos_tabs_tab:trigger(nil)

    require 'LangAdapter'.fontSize(self._root_topBar_ftpos_tabs_tab_normal_des,nil,nil,24,nil,24,nil,nil,nil,nil,20)
    require 'LangAdapter'.fontSize(self._root_topBar_ftpos_tabs_tab_pressed_des,nil,nil,24,nil,24,nil,nil,nil,nil,20)

end

function DExploreChosPet:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function DExploreChosPet:updatePetList()
    local allPets = AppData.getPetInfo().getPetList()
    local pets = {}
    for k, v in pairs(allPets) do
        if not AppData.getExploreInfo().petInExploration(v.Id) then
            table.insert(pets, v)
        end
    end
    table.sort(pets, function(pet1, pet2)
        return pet1.Power > pet2.Power
    end)

    for i = 1, #pets do        
        if i <= 7 then
            local itemSet = self:createLuaSet("@cell")
            self:refReshCell(itemSet, pets[i])
            self._root_list:getContainer():addChild(itemSet[1])
        else
            self:runWithDelay(function ( ... )
            local itemSet = self:createLuaSet("@cell")
            self:refReshCell(itemSet, pets[i])
            self._root_list:getContainer():addChild(itemSet[1])
            end,0.1 * (i-7), self._root_list)
        end
    end
    self._root_list:layout()
end

function DExploreChosPet:refReshCell(itemSet, nPet)
  local dbPet = DBManager.getCharactor(nPet.PetId)
  if dbPet then
    
    itemSet['nameBg_name']:setString(Res.getPetNameWithSuffix(nPet))
    itemSet['pet_frame']:setResid(Res.getPetIconFrame(nPet))
    itemSet['pet_icon']:setResid(Res.getPetIcon(nPet.PetId))
    itemSet["pet_property"]:setResid(Res.getPetPropertyIcon(dbPet.prop_1p,true))
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
    --elseif --探宝中 N_JLLB_wenzi2.png
    else
      itemSet['flagIcon']:setVisible(false)
    end

    itemSet["Quality"]:setString(dbPet.quality)
    
    --local userInfo = gameFunc.getUserInfo()
    -- local levelCapTable = DBManager.getInfoRoleLevelCap(userInfo.getLevel())
    itemSet["Lv"]:setString(string.format("%d/%d", nPet.Lv, DBManager.getPetLvCap(nPet)))
    itemSet["Power"]:setString(nPet.Power)
    --itemSet["Hp"]:setString(nPet.Hp)

    itemSet["btnSelect"]:setListener(function ()
        local param = {}
        param.callBack = function(hours)
            if self:getUserData().callBack then
                self:getUserData().callBack(nPet, hours)
            end
            self:close()
        end

        param.price1 = math.floor((nPet.Power / 10)^0.4 * 800)
        param.price2 = math.floor((nPet.Power / 10)^0.4 * 1600)
        param.price3 = math.floor((nPet.Power / 10)^0.4 * 3200)
        GleeCore:showLayer('DExploreChosTime', param)
    end)


    require 'LangAdapter'.LabelNodeAutoShrink(itemSet['btnSelect_title'],110)
  end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DExploreChosPet, "DExploreChosPet")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DExploreChosPet", DExploreChosPet)


