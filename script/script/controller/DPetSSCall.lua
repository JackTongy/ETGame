local Config = require "Config"
local dbManager = require 'DBManager'
local netModel  = require 'netModel'
local Res       = require 'Res'

local DPetSSCall = class(LuaDialog)

function DPetSSCall:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPetSSCall.cocos.zip")
    return self._factory:createDocument("DPetSSCall.cocos")
end

--@@@@[[[[
function DPetSSCall:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_btnbg = set:getButtonNode("root_btnbg")
   self._root_bg = set:getJoint9Node("root_bg")
   self._root_tbg = set:getElfNode("root_tbg")
   self._root_title = set:getLabelNode("root_title")
   self._root_tip = set:getLabelNode("root_tip")
   self._root_layout = set:getLayout2DNode("root_layout")
   self._pet = set:getElfNode("pet")
   self._pet_pzbg = set:getElfNode("pet_pzbg")
   self._pet_icon = set:getElfNode("pet_icon")
   self._pet_pz = set:getElfNode("pet_pz")
   self._pet_property = set:getElfNode("pet_property")
   self._pet_career = set:getElfNode("pet_career")
   self._starLayout = set:getLayoutNode("starLayout")
   self._root_btnOne = set:getClickNode("root_btnOne")
   self._root_btnOne_linear_icon = set:getElfNode("root_btnOne_linear_icon")
   self._root_btnOne_linear_price = set:getLabelNode("root_btnOne_linear_price")
   self._root_btnTen = set:getClickNode("root_btnTen")
   self._root_btnTen_linear_icon = set:getElfNode("root_btnTen_linear_icon")
   self._root_btnTen_linear_price = set:getLabelNode("root_btnTen_linear_price")
--   self._@item = set:getElfNode("@item")
--   self._@star = set:getElfNode("@star")
--   self._@star = set:getElfNode("@star")
--   self._@star = set:getElfNode("@star")
--   self._@star = set:getElfNode("@star")
--   self._@star = set:getElfNode("@star")
--   self._@star = set:getElfNode("@star")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DPetSSCall:onInit( userData, netData )
  self._PetId = (userData and userData.PetId) or 243
  self._cfg = dbManager.getZhaoHuanCfg(self._PetId)
  self._vipLv = (userData and userData.vipLv) or 9
  require 'LangAdapter'.LabelNodeAutoShrink(self._root_tip,430)
  self._root_tip:setString(string.format(Res.locString('PetAcademy$SSCALL'),tostring(self._cfg.Name)))

	self._root_btnbg:setListener(function ( ... )
    Res.doActionDialogHide(self._root,self)
  end)

  self:updateLayer()

  Res.doActionDialogShow(self._root)

end

function DPetSSCall:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function DPetSSCall:updateLayer( ... )
  
  local cfg = self._cfg
  self._root_btnOne_linear_price:setString(tostring(cfg.Cost))
  self._root_btnTen_linear_price:setString(tostring(cfg.Cost10))
  self:updatePetList(self._PetId,cfg.PetIdList)

  local viplv = require 'AppData'.getUserInfo().getVipLevel()
  if viplv < self._vipLv then
    local unlocktoast = function ( ... )
       self:toast(string.format(Res.locString('PetAcademy$VIPLvlLimit'),self._vipLv))
    end
    self._root_btnOne:setListener(unlocktoast)
    self._root_btnTen:setListener(unlocktoast)
  else
    self._root_btnOne:setListener(function ( ... )
      self:buyOne()
    end)
    self._root_btnTen:setListener(function ( ... )
      self:buyTen()
    end)
  end
  
end

function DPetSSCall:updatePetList( PetId,PetIdList )
  local helper = require 'PetNodeHelper'
  
  self._root_layout:removeAllChildrenWithCleanup(true)
  
  local cond = #PetIdList == 3
  if cond then
    local set = self:createLuaSet('@item')
    self._root_layout:addChild(set[1])
    set[1]:setVisible(false)
  end

  local set = self:createLuaSet('@item')
  helper.updatePetItem(self, set,PetId)
  self._root_layout:addChild(set[1])

  if cond then
    local set = self:createLuaSet('@item')
    self._root_layout:addChild(set[1])
    set[1]:setVisible(false)
  end

  for i,v in ipairs(PetIdList) do
    local set = self:createLuaSet('@item')
    helper.updatePetItem(self,set,v)
    self._root_layout:addChild(set[1])
  end
end

function DPetSSCall:buyOne( ... )
  local again = function ( ... )
    self:buyOne()
  end

  require 'Toolkit'.useCoinConfirm(function ( ... )
    self:send(netModel.getPetZhaohuan(self._PetId,false),  function ( data )
      self:recv(data,again,self._cfg.Cost)
    end)
  end)
end

function DPetSSCall:buyTen( ... )
  local again = function ( ... )
    self:buyTen()
  end
  require 'Toolkit'.useCoinConfirm(function ( ... )
    self:send(netModel.getPetZhaohuan(self._PetId,true),  function ( data )
      self:recv(data,again,self._cfg.Cost10)
    end)
  end)
end

function DPetSSCall:recv( data,again,coinNum )

  require 'AppData'.updateResource(data.D.Resource)

  if data.D.Reward.PetPieces then
    local PetPieces = data.D.Reward.PetPieces
    local pets = {}
    for i,v in ipairs(PetPieces) do
      local nPet = require 'AppData'.getPetInfo().getPetInfoByPetId(v.PetId)
      nPet.isPieces = true
      table.insert(pets,nPet)
    end
    GleeCore:showLayer('DPetAcademyEffectV2',{pets=pets,again=again,useCoin=true,coinNum=coinNum})
  end

end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPetSSCall, "DPetSSCall")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPetSSCall", DPetSSCall)
