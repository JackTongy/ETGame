local Config = require "Config"
local Res = require 'Res'
local netModel = require 'netModel'
local AppData = require 'AppData'

local DGuildDonate = class(LuaDialog)

function DGuildDonate:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGuildDonate.cocos.zip")
    return self._factory:createDocument("DGuildDonate.cocos")
end

--@@@@[[[[
function DGuildDonate:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg = set:getJoint9Node("root_bg")
   self._root_close = set:getButtonNode("root_close")
   self._root_tbg = set:getElfNode("root_tbg")
   self._root_title = set:getLabelNode("root_title")
   self._root_layout = set:getLayoutNode("root_layout")
   self._bg = set:getElfNode("bg")
   self._icon = set:getElfNode("icon")
   self._des1 = set:getLabelNode("des1")
   self._des2 = set:getLabelNode("des2")
   self._layoutPrice = set:getLinearLayoutNode("layoutPrice")
   self._layoutPrice_icon = set:getElfNode("layoutPrice_icon")
   self._layoutPrice_v2 = set:getLabelNode("layoutPrice_v2")
   self._btnBuy = set:getClickNode("btnBuy")
   self._root_tip = set:getLabelNode("root_tip")
--   self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DGuildDonate:onInit( userData, netData )

	self._root_close:setListener(function ( ... )
    Res.doActionDialogHide(self._root, self)
  end)
  Res.doActionDialogShow(self._root)

  self:updateLayer()
  
end

function DGuildDonate:onBack( userData, netData )
	
end

function DGuildDonate:close( ... )
  local userData = self:getUserData()
  return userData and userData.callback and userData.callback()
end

--------------------------------custom code-----------------------------
function DGuildDonate:updateLayer( ... )
  local t = require 'guilddonate'

  for i,v in ipairs(t) do
    local itemset = self:createLuaSet('@item')
    self._root_layout:addChild(itemset[1])
    self:refreshItemSet(itemset,v,i)  
  end
  
end

function DGuildDonate:refreshItemSet(itemset,v,i)
  if v.type == 1 then
    itemset['icon']:setResid('TY_jinbi_da.png')
    itemset['layoutPrice_icon']:setResid('N_TY_jinbi1.png')
  elseif v.type == 2 then
    itemset['icon']:setResid('TY_jinglingshi_da.png')
    itemset['layoutPrice_icon']:setResid('N_TY_baoshi1.png')
  end
  itemset['layoutPrice_v2']:setString(tostring(v.amount))
  itemset['des1']:setString(string.format(Res.locString('Guild$pDonate'),v.mpoint))
  itemset['des2']:setString(string.format(Res.locString('Guild$Econ'),v.gpoint))
  itemset['btnBuy']:setListener(function ( ... )
    self:send(netModel.getModelGuildMemberDonate(i),function ( data )
      local meminfo = AppData.getGuildInfo().getGuildMember()
      local guid = AppData.getGuildInfo().getData()

      meminfo.Donate = true
      AppData.getGuildInfo().addMPoint(data.D.MPoint)
      AppData.getGuildInfo().addGPoint(data.D.GPoint)
      self:refreshGoldCoin(v)
      self:toast(string.format(Res.locString('Guild$DonateSuc'),tostring(data.D.MPoint),tostring(data.D.GPoint)))
      self:close()
    end)  
  end)
  require 'LangAdapter'.LabelNodeAutoShrink(itemset['des1'],150)
end

function DGuildDonate:refreshGoldCoin( v )
  local userInfo = AppData.getUserInfo()
  if v.type == 1 then
    userInfo.setGold(userInfo.getGold()-v.amount)
  elseif v.type == 2 then
    userInfo.setCoin(userInfo.getCoin()-v.amount)
  end
  require 'EventCenter'.eventInput("UpdateGoldCoin")
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGuildDonate, "DGuildDonate")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGuildDonate", DGuildDonate)
