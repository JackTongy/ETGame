local Config = require "Config"
local config = require "Config"
local gameFunc = require "AppData"
local res = require "Res"
local dbManager = require "DBManager"
local eventCenter = require 'EventCenter'
local netModel = require 'netModel'

local TLPetList = class(TabLayer)

function TLPetList:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLPetList.cocos.zip")
    return self._factory:createDocument("TLPetList.cocos")
end

--@@@@[[[[
function TLPetList:onInitXML()
    local set = self._set
   self._list = set:getListNode("list")
   self._btnDetail = set:getButtonNode("btnDetail")
   self._pet = set:getElfNode("pet")
   self._pet_pzbg = set:getElfNode("pet_pzbg")
   self._pet_icon = set:getElfNode("pet_icon")
   self._pet_pz = set:getElfNode("pet_pz")
   self._pet_property = set:getElfNode("pet_property")
   self._pet_career = set:getElfNode("pet_career")
   self._starLayout = set:getLayoutNode("starLayout")
   self._nameBg = set:getElfNode("nameBg")
   self._name = set:getLabelNode("name")
   self._Quality = set:getLabelNode("Quality")
   self._Lv = set:getLabelNode("Lv")
   self._Atk = set:getLabelNode("Atk")
   self._Hp = set:getLabelNode("Hp")
   self._btnBringUp = set:getClickNode("btnBringUp")
   self._onTeam = set:getElfNode("onTeam")
   self._topBar_ftpos2_linear_v2 = set:getLabelNode("topBar_ftpos2_linear_v2")
--   self._@unsed = set:getElfNode("@unsed")
--   self._@view = set:getElfNode("@view")
--   self._@size = set:getElfNode("@size")
--   self._@star = set:getElfNode("@star")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLPetList:onInit( userData, netData )
	local size = CCDirector:sharedDirector():getWinSize()
  self._viewSet['list']:setContentSize(CCSize(size.width, self._viewSet['list']:getHeight()))

  self._petListRefresh = true
  gameFunc.getPetInfo().sortPetList()

  eventCenter.addEventFunc('PetInfoModify',function ( data )
    self._petListRefresh = true
  end,'CPetList')

end

function TLPetList:onEnter( ... )
  if self._petListRefresh then
    self:updatePetList()
  end  
end

function TLPetList:onBack( userData, netData )
	
end

function TLPetList:onRelease( ... )
  eventCenter.resetGroup('CPetList')
end
--------------------------------custom code-----------------------------

function TLPetList:updatePetList(  )

  self._petListRefresh = false
  local petFunc = gameFunc.getPetInfo()
  local itemListData = petFunc.getPetList()
  self.pets = itemListData

  self._viewSet['list']:stopAllActions()
  self._viewSet['list']:getContainer():removeAllChildrenWithCleanup(true)
  for i,v in ipairs(itemListData) do
    if i < 7 then
      local itemSet = self:createLuaSet("@size")
      self:refreshCell(itemSet,v)
    else
      self:runWithDelay(function ( ... )
        self:refreshCell(self:createLuaSet('@size'),v)
      end, 0.1*(i-7),self._viewSet['list'])
    end
  end

  self._viewSet['list']:layout()

  self._viewSet['topBar_ftpos2_linear_v2']:setString(string.format('%s/100',tostring(#itemListData)))
end


function TLPetList:refreshCell( itemSet,nPet )
  self:refreshPetInfo(itemSet,nPet)
  self._viewSet['list']:getContainer():addChild(itemSet[1])

  local petFunc = gameFunc.getPetInfo()
  itemSet['onTeam']:setVisible(petFunc.inTeamOrPartner(nPet.Id))  

  itemSet["btnBringUp"]:setListener(function (  )
    -- GleeCore:pushController('CPetFoster',{pet = nPet}, nil, res.getTransitionFade())
    GleeCore:showLayer('DPetFoster',{pet=nPet,pets=self.pets})
    self._selectPet = nPet
  end)
  itemSet["btnDetail"]:setListener(function (  )
    local param = {}
    param.nPet = nPet
    param.petindex = petFunc.getPetIndex(nPet)
    param.fetterPetIdListWithPartners = require 'AppData'.getTeamInfo().getFetterPetIdList(nPet.Id)
    param.petSelectFunc = function (offsetIndex)
      local newpet = petFunc.getPetByIndex(param.petindex+offsetIndex)
      if not newpet then
        return nil
      end

      param.nPet = newpet
      param.petindex = param.petindex + offsetIndex
      self._selectPet = newpet
      return param
    end
    param.pets = self.pets
    GleeCore:showLayer("DPetDetailV", param)
    self._selectPet = nPet
  end)

  if self._selectPet and self._selectPet.Id == nPet.Id then
    self._selectIndex = i
  end

  require 'LangAdapter'.NodesPosReverse(itemSet['#LvTitle'],itemSet["Lv"])
  require 'LangAdapter'.NodesPosReverse(itemSet['#AtkTitle'],itemSet["Atk"])
  require 'LangAdapter'.NodesPosReverse(itemSet['#HpTitle'],itemSet["Hp"])
  require 'LangAdapter'.NodesPosReverse(itemSet['#QualityTitle'],itemSet["Quality"])
end

function TLPetList:refreshPetInfo( itemSet,nPet )
  local dbPet = dbManager.getCharactor(nPet.PetId)
  if dbPet then
    itemSet['pet_icon']:setResid(res.getPetIcon(nPet.PetId))
    itemSet["pet_pz"]:setResid(res.getPetPZ(nPet.AwakeIndex))
    itemSet["pet_property"]:setResid(res.getPetPropertyIcon(dbPet.prop_1,true))
    itemSet["pet_career"]:setResid(res.getPetCareerIcon(dbPet.atk_method_system))

    require 'PetNodeHelper'.updateStarLayout(itemSet['starLayout'],dbPet)
  
    itemSet["name"]:setString(res.getPetNameWithSuffix(nPet))
    itemSet["Quality"]:setString(dbPet.quality)
    local userInfo = gameFunc.getUserInfo()
    -- local levelCapTable = dbManager.getInfoRoleLevelCap(userInfo.getLevel())
    itemSet["Lv"]:setString(string.format("%d/%d", nPet.Lv, dbManager.getPetLvCap(nPet)))
    itemSet["Atk"]:setString(nPet.Atk)
    itemSet["Hp"]:setString(nPet.Hp)
  end 
end


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLPetList, "TLPetList")


--------------------------------register--------------------------------
return TLPetList
