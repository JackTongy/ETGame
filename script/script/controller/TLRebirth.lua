local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local AppData = require "AppData"
local netModel = require "netModel"
local GuideHelper = require 'GuideHelper'

local TLRebirth = class(TabLayer)

function TLRebirth:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLRebirth.cocos.zip")
    return self._factory:createDocument("TLRebirth.cocos")
end

--@@@@[[[[
function TLRebirth:onInitXML()
    local set = self._set
   self._bg1_btnRebirth = set:getClickNode("bg1_btnRebirth")
   self._bg1_btnRebirth_title = set:getLabelNode("bg1_btnRebirth_title")
   self._bg1_tip = set:getLabelNode("bg1_tip")
   self._bg1_items_item1 = set:getElfNode("bg1_items_item1")
   self._bg1_items_item1_pzbg = set:getElfNode("bg1_items_item1_pzbg")
   self._bg1_items_item1_iconPet = set:getElfNode("bg1_items_item1_iconPet")
   self._bg1_items_item1_pz = set:getElfNode("bg1_items_item1_pz")
   self._bg1_items_item1_name = set:getLabelNode("bg1_items_item1_name")
   self._bg1_items_item1_lv = set:getLabelNode("bg1_items_item1_lv")
   self._bg1_items_item2 = set:getElfNode("bg1_items_item2")
   self._bg1_items_item2_pzbg = set:getElfNode("bg1_items_item2_pzbg")
   self._bg1_items_item2_iconPet = set:getElfNode("bg1_items_item2_iconPet")
   self._bg1_items_item2_pz = set:getElfNode("bg1_items_item2_pz")
   self._bg1_items_item2_name = set:getLabelNode("bg1_items_item2_name")
   self._bg1_items_item2_lv = set:getLabelNode("bg1_items_item2_lv")
   self._bg1_title_linearlayout_C2 = set:getJoint9Node("bg1_title_linearlayout_C2")
   self._bg1_title_linearlayout_C2_V = set:getLabelNode("bg1_title_linearlayout_C2_V")
   self._bg1_title_linearlayout_C3 = set:getJoint9Node("bg1_title_linearlayout_C3")
   self._bg1_title_linearlayout_C3_V = set:getLabelNode("bg1_title_linearlayout_C3_V")
   self._bg1_cost_value = set:getLabelNode("bg1_cost_value")
   self._tip = set:getRichLabelNode("tip")
--   self._@unsed = set:getElfNode("@unsed")
--   self._@view = set:getElfNode("@view")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLRebirth:onInit( userData, netData )
	
end

function TLRebirth:onEnter( userData )
  --从非选中状态变为选中状态
  --self._parent
  require 'LangAdapter'.fontSize(self._viewSet['tip'],nil,nil,20,nil,20,20,20)
  require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['bg1_btnRebirth_title'],120)
  require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['bg1_tip'],300)
  require 'LangAdapter'.fontSize(self._viewSet['tip'],nil,nil,nil,nil,nil,nil,nil,nil,nil,20)
  require 'LangAdapter'.fontSize(self._viewSet['bg1_btnRebirth_title'],nil,nil,nil,nil,nil,nil,nil,nil,nil,20)
  self._Pet = (self._parent:getUserData() and self._parent:getUserData().pet)

  self._viewSet['tip']:setString(res.locString('PetFoster$TIP8'))
  self:updateLayer(self._Pet)

  GuideHelper:startGuide('GCfg10')
  GuideHelper:registerPoint('重生',self._viewSet['bg1_btnRebirth'])
  GuideHelper:check('TabRebirth')
end

function TLRebirth:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function TLRebirth:updateLayer( nPet )

  local userInfo = AppData.getUserInfo()
  local stoneCnt = AppData.getBagInfo().getItemCount(42)

  self._viewSet['bg1_title_linearlayout_C2_V']:setString(stoneCnt)
  self._viewSet['bg1_title_linearlayout_C3_V']:setString(userInfo.getCoin())
  self._viewSet['bg1_title_linearlayout_C3']:setContentSize(self._viewSet['bg1_title_linearlayout_C3_V']:getContentSize())
  self._viewSet['bg1_title_linearlayout_C2']:setContentSize(self._viewSet['bg1_title_linearlayout_C2_V']:getContentSize())

  self._viewSet['bg1_items_item1_iconPet']:setResid(res.getPetIcon(nPet.PetId))
  self._viewSet['bg1_items_item1_pz']:setResid(res.getPetPZ(nPet.AwakeIndex))
  self._viewSet['bg1_items_item1_pzbg']:setResid(res.getPetIconBg(nPet))
  self._viewSet['bg1_items_item1_name']:setString(res.getPetNameWithSuffix(nPet))
  -- self._viewSet['bg1_items_item1_name']:setFontFillColor(res.getRankColorByAwake(nPet.AwakeIndex), true)
  self._viewSet['bg1_items_item1_lv']:setString(string.format('Lv.%d',nPet.Lv))

  self._viewSet['bg1_items_item2_iconPet']:setResid(res.getPetIcon(nPet.PetId))
  self._viewSet['bg1_items_item2_pz']:setResid(res.getPetPZ(0))
  self._viewSet['bg1_items_item2_pzbg']:setResid(res.getPetIconBg())
  self._viewSet['bg1_items_item2_name']:setString(nPet.Name)
  self._viewSet['bg1_items_item2_lv']:setString(string.format('Lv.%d',1))

  local dbpet     = dbManager.getCharactor(nPet.PetId)
  local mixconfig = dbManager.getMixConfig(nPet.Star,dbpet and dbpet.quality)
  --有觉醒 有等级 有经验 有激发
  local rebirthEnable = nPet.AwakeIndex ~= 0 or nPet.Lv ~= 1 or nPet.Exp > 0 -- or ((nPet.Lv-nPet.Potential) > 0 and nPet.Star > 2)
  self._viewSet['bg1_btnRebirth']:setEnabled(rebirthEnable)
  self._viewSet['bg1_cost_value']:setString(tostring(mixconfig.RebornCost))
  self._viewSet['bg1_btnRebirth']:setListener(function ( ... )
    self:clickRebirth(nPet) 
  end)

end

--helper
function TLRebirth:notice( Reward )

  if Reward then
    GleeCore:showLayer('DGetReward',Reward)
    return
  end

end

--net
function TLRebirth:clickRebirth( nPet )

  local callback = function (  )
    self:send(netModel.getModelPetReborn(nPet.Id),function ( data )
      
      self:notice(data.D.Reward)

      AppData.updateResource(data.D.Resource)
      AppData.getGemInfo().getOffGem(data.D.Pet.Id)
      self._parent:updatePet(data.D.Pet)
      
    end)    
  end

  GleeCore:showLayer('DConfirmNT',{content=res.locString('PetFoster$TIP9'),callback=callback})
  
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLRebirth, "TLRebirth")


--------------------------------register--------------------------------
return TLRebirth
