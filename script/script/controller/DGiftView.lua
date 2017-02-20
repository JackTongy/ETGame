local Config = require "Config"
local dbManager = require 'DBManager'
local Res = require 'Res'

local DGiftView = class(LuaDialog)

function DGiftView:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGiftView.cocos.zip")
    return self._factory:createDocument("DGiftView.cocos")
end

--@@@@[[[[
function DGiftView:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._bg = set:getJoint9Node("bg")
   self._bg_title = set:getLabelNode("bg_title")
   self._bg_list = set:getListNode("bg_list")
   self._item_title = set:getLabelNode("item_title")
   self._item_icon = set:getElfNode("item_icon")
   self._item_linearlayout_count = set:getLabelNode("item_linearlayout_count")
   self._item_des = set:getLabelNode("item_des")
   self._des = set:getLabelNode("des")
   self._linearlayout_quality = set:getLabelNode("linearlayout_quality")
--   self._@size = set:getElfNode("@size")
--   self._@petLayer = set:getElfNode("@petLayer")
end
--@@@@]]]]

--------------------------------override functions----------------------
--[[
  title = 
  list={
    [1]={Gold} 
    --Coin,Soul,MaterialId,MCount}
    ...
  }
]]
function DGiftView:onInit( userData, netData )
	Res.doActionDialogShow(self._bg)
  self._bg_title:setString(tostring(userData.title))
	self:updateGiftList(userData.list)
  self._clickBg:setListener(function ( ... )
    Res.doActionDialogHide(self._bg, self)
  end)

end

function DGiftView:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DGiftView:updateGiftList( list )

  if list and type(list) == 'table' then
    self._bg_list:getContainer():removeAllChildrenWithCleanup(true)
    for i,v in ipairs(list) do
      local luaset = self:createLuaSet('@size')
      self:refreshCell(luaset,v)
      self._bg_list:getContainer():addChild(luaset[1])
    end
  end

end

function DGiftView:refreshCell( set, pack)
  
  local name 
  local icon 
  local count 
  local des 

  if pack.Gold then
    name = Res.locString('Global$Gold')
    count = pack.Gold
    des = '一堆闪亮的金币。作为游戏世界中的货币，没有金币是万万不行的。'
    icon = 'TY_jinbi.png'
  end

  if pack.Coin then
    name = Res.locString('Global$SpriteStone')
    count = pack.Coin
    des = '特殊而神奇的一种宝石。世间流传着一句话，有精灵石能使磨推鬼。'
    icon = 'TY_jinglingshi.png'
  end

  if pack.Soul then
    local dbsoul = dbManager.getDeaultConfig('Soul')
    name = Res.locString('PetFoster$SOUL')
    count = pack.Soul
    des = dbsoul.Des
    icon = Res.getSoulImageName()
  end

  if pack.MaterialId then

    local dbm = dbManager.getInfoMaterial(pack.MaterialId)
    name = dbm.name
    count = pack.MCount
    des = dbm.describe
    icon = Res.getMaterialIcon(pack.MaterialId)

  end

  set['item_title']:setString(name)
  set['item_icon']:setResid(icon)
  set['item_linearlayout_count']:setString(tostring(count))
  set['item_des']:setString(des)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGiftView, "DGiftView")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGiftView", DGiftView)
