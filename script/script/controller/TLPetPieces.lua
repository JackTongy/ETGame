local Config = require "Config"
local config = require "Config"
local gameFunc = require "AppData"
local res = require "Res"
local dbManager = require "DBManager"
local eventCenter = require 'EventCenter'
local netModel = require 'netModel'

local TLPetPieces = class(TabLayer)

function TLPetPieces:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLPetPieces.cocos.zip")
    return self._factory:createDocument("TLPetPieces.cocos")
end

--@@@@[[[[
function TLPetPieces:onInitXML()
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
   self._QualityTitle = set:getLabelNode("QualityTitle")
   self._Quality = set:getLabelNode("Quality")
   self._Atk = set:getLabelNode("Atk")
   self._Hp = set:getLabelNode("Hp")
   self._btnBringUp = set:getClickNode("btnBringUp")
   self._btnBringUp_title = set:getLabelNode("btnBringUp_title")
   self._AmountTitle = set:getLabelNode("AmountTitle")
   self._Amount = set:getLabelNode("Amount")
--   self._@view = set:getElfNode("@view")
--   self._@size = set:getElfNode("@size")
--   self._@star = set:getElfNode("@star")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLPetPieces:onInit( userData, netData )
	local size = CCDirector:sharedDirector():getWinSize()
  self._viewSet['list']:setContentSize(CCSize(size.width, self._viewSet['list']:getHeight()))

  self:updatePiecesList()
  self:getPiecesInfo()

  eventCenter.addEventFunc('petPiecesModify',function ( ... )
    self._refreshlist = true
  end,'TLPetPieces')
end

function TLPetPieces:onEnter( ... )
  if self._refreshlist then
    self:updatePiecesList()
    self._refreshlist = false
  end
end

function TLPetPieces:onBack( userData, netData )
	
end

function TLPetPieces:onRelease( ... )
  eventCenter.resetGroup('TLPetPieces')
end
--------------------------------custom code-----------------------------

function TLPetPieces:updatePiecesList( )

  local Pieces = gameFunc.getPetInfo().getPetPieces()
  
  self._viewSet['list']:stopAllActions()
  self._viewSet['list']:getContainer():removeAllChildrenWithCleanup(true)
  for i,v in ipairs(Pieces) do
    if v.Amount > 0 then
      if i < 7 then
        local itemSet = self:createLuaSet('@size')
        self:refreshPicesCell(itemSet,v)
      else
        self:runWithDelay(function ( ... )
          local itemSet = self:createLuaSet('@size')
          self:refreshPicesCell(itemSet,v)
        end, 0.1*(i-7),self._viewSet['list'])
      end
    end
  end
  self._viewSet['list']:layout()

  self:refreshPointState()

  if not gameFunc.getPetInfo().hasPieces() then
    self._parent:tabReInit()
  end

end

function TLPetPieces:refreshPicesCell( itemSet,Piece )
  local nPet = gameFunc.getPetInfo().getPetInfoByPetId(Piece.PetId)
  self:refreshPetInfo(itemSet,nPet)
  self._viewSet['list']:getContainer():addChild(itemSet[1])
  require 'LangAdapter'.LabelNodeAutoShrink(itemSet['QualityTitle'],65)
  require 'LangAdapter'.LabelNodeAutoShrink(itemSet['AmountTitle'],65)
  require 'LangAdapter'.LabelNodeAutoShrink(itemSet['btnBringUp_title'],110)
  require 'LangAdapter'.NodesPosReverse(itemSet['AmountTitle'],itemSet["Amount"])
  require 'LangAdapter'.NodesPosReverse(itemSet['#AtkTitle'],itemSet["Atk"])
  require 'LangAdapter'.NodesPosReverse(itemSet['#HpTitle'],itemSet["Hp"])
  require 'LangAdapter'.NodesPosReverse(itemSet['QualityTitle'],itemSet["Quality"])

  local dbpet = dbManager.getCharactor(nPet.PetId)
  local mixc = dbManager.getMixConfig(nPet.Star,dbpet and dbpet.quality)
  itemSet['Amount']:setString(string.format('%d/%d',Piece.Amount,mixc.Compose))
  -- itemSet['topBg_title']:enableStroke(ccc4f(0,0,0,0.5),2,true)
  if Piece.Amount >= mixc.Compose then
    itemSet['Amount']:setFontFillColor(res.rankColor4F[2],true)

  else
    itemSet['Amount']:setFontFillColor(ccc4f(0.682353,0.164706,0.176471,1.0),true)
  end

  itemSet['btnBringUp']:setEnabled(Piece.Amount >= mixc.Compose)
  itemSet['btnBringUp']:setListener(function ( ... )
    self:petCompose(Piece.PetId)
  end)
  itemSet['btnDetail']:setListener(function ( ... )
    local param = {}
    param.nPet = nPet
    -- param.isPetFromDbPet = true
    param.isNotMine = true
    param.petindex = gameFunc.getPetInfo().getPetPieceIndex(nPet)
    param.petSelectFunc = function (offsetIndex)
      local npi = gameFunc.getPetInfo().getPetPieceByIndex(param.petindex+offsetIndex)
      if not npi then
        return nil
      end
      local newpet = gameFunc.getPetInfo().getPetInfoByPetId(npi.PetId)
      param.nPet = newpet
      param.petindex = param.petindex + offsetIndex
      return param
    end

    GleeCore:showLayer("DPetDetailV", param)
  end)
end

function TLPetPieces:refreshPetInfo( itemSet,nPet )
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
    local levelCapTable = dbManager.getInfoRoleLevelCap(userInfo.getLevel())
    itemSet["Atk"]:setString(nPet.Atk)
    itemSet["Hp"]:setString(nPet.Hp)
  end 
end

--net
function TLPetPieces:getPiecesInfo( ... )
  self:send(netModel.getModelPetGetPieces(),function ( data )
    gameFunc.getPetInfo().setPetPieces(data.D.Pieces)   
    self:updatePiecesList()
  end)  
end

function TLPetPieces:petCompose( PetId )
  self:send(netModel.getModelPetCompose(PetId),function ( data )
    if data.D.Resource then
      gameFunc.updateResource(data.D.Resource)
      gameFunc.getPetInfo().sortPetList()
    end

    if data.D.Piece then
      gameFunc.getPetInfo().updatePetPiece(data.D.Piece)
    end

    local callback = function ( ... )
      self:updatePiecesList()
      eventCenter.eventInput('PetInfoModify')
    end

    if data.D.Resource and data.D.Resource.Pets then
      for k,v in pairs(data.D.Resource.Pets) do
        v.Amount = v.Amount or 1
      end
      data.D.Resource.callback = callback
      GleeCore:showLayer('DGetReward',data.D.Resource)
    else
      callback()
    end
  end)  
end

function TLPetPieces:refreshPointState( ... )
  local Pieces = gameFunc.getPetInfo().getPetPieces()
  if Pieces then
    for k,v in pairs(Pieces) do
      local nPet = gameFunc.getPetInfo().getPetInfoByPetId(v.PetId)
      local dbpet     = dbManager.getCharactor(nPet.PetId)
      local mixc = dbManager.getMixConfig(nPet.Star,dbpet and dbpet.quality)
      if v.Amount >= mixc.Compose then
        return
      end
    end

    require 'BroadCastInfo'.set('pet_piece',false)
    self._parent:refreshPointState()
    self:sendBackground(netModel.getModelRoleNewsUpdate('pet_piece',false),function ( ... )
        
    end)  
  end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLPetPieces, "TLPetPieces")


--------------------------------register--------------------------------
return TLPetPieces
