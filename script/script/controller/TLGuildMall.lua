local Config = require "Config"
local guildstore = require 'guildstore'
local AppData = require 'AppData'
local Res = require 'Res'
local DBManager = require 'DBManager'
local netModel = require 'netModel'

local TLGuildMall = class(TabLayer)

function TLGuildMall:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLGuildMall.cocos.zip")
    return self._factory:createDocument("TLGuildMall.cocos")
end

--@@@@[[[[
function TLGuildMall:onInitXML()
    local set = self._set
   self._bg = set:getJoint9Node("bg")
   self._list = set:getListNode("list")
   self._layout = set:getLayoutNode("layout")
   self._bg = set:getElfNode("bg")
   self._icon = set:getElfNode("icon")
   self._pieces = set:getElfNode("pieces")
   self._iconFrame = set:getElfNode("iconFrame")
   self._name = set:getLabelNode("name")
   self._count = set:getLabelNode("count")
   self._layoutPrice = set:getLinearLayoutNode("layoutPrice")
   self._layoutPrice_v1 = set:getLabelNode("layoutPrice_v1")
   self._layoutPrice_v2 = set:getLabelNode("layoutPrice_v2")
   self._btnBuy = set:getClickNode("btnBuy")
   self._btnDetail = set:getButtonNode("btnDetail")
   self._lock = set:getElfNode("lock")
   self._tip = set:getLabelNode("tip")
   self._mydona = set:getLinearLayoutNode("mydona")
   self._mydona_V = set:getLabelNode("mydona_V")
--   self._@unused = set:getElfNode("@unused")
--   self._@view = set:getElfNode("@view")
--   self._@size = set:getElfNode("@size")
--   self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLGuildMall:onInit( userData, netData )
  local selflv = AppData.getUserInfo().getLevel()
	self._storelist = {}
  for i,v in ipairs(guildstore) do
    local ret = true
    if v.type == 9 then
      local dbm = DBManager.getInfoMaterial(v.itemid)
      ret = (dbm.unlocklv <= selflv)
    end
    if ret then
      table.insert(self._storelist,v)
    end
  end
end

function TLGuildMall:onBack( userData, netData )
	
end

function TLGuildMall:onEnter( ... )
  self:updateLayer()
end

function TLGuildMall:onRelease( ... )
  self:clearSetMap()
end

--------------------------------custom code-----------------------------

function TLGuildMall:updateLayer( )
  local guildinfo = AppData.getGuildInfo()
  if AppData.getGuildInfo().getData() == nil then
    return
  end
  local mem = guildinfo.getGuildMember()
  self._viewSet['mydona_V']:setString(tostring(mem.Point))
  self:updateList(guildinfo.getData().Lv,mem)
end

function TLGuildMall:updateList( guildlv,mem)
  local Point = mem.Point

  local list = self._viewSet['list']
  list:stopAllActions()

  local sizeset
  for i,v in ipairs(self._storelist) do
    if (i-1)%4 == 0 then
      sizeset = self:setBy('line'..i,'@size',function ( newset )
        list:getContainer():addChild(newset[1])
      end)
      
    end
    local itemset = self:setBy(v.id,'@item',function ( newset )
      sizeset['layout']:addChild(newset[1])  
    end)
    
    if i <= 8 or self._nodelay then
      self:refreshSet(itemset,v,guildlv,Point,mem.BuyRecords)
    else
      self:runWithDelay(function ( ... )
        self:refreshSet(itemset,v,guildlv,Point,mem.BuyRecords)
      end,(i-8)*0.1,list)
    end
  end
  
  self._nodelay = true
end

function TLGuildMall:refreshSet( set,v,guildlv,Point,BuyRecords )

  local name,resid = Res.getRewardStrAndResId(v.type,v.itemid)
  local buycnt = (BuyRecords and BuyRecords[tostring(v.id)]) or 0
  local lastAmount = v.amount - buycnt
  lastAmount = (lastAmount < 0 and 0) or lastAmount

  set['icon']:setResid(resid[2])
  set['iconFrame']:setResid(resid[3])
  require 'LangAdapter'.LabelNodeAutoShrink(set['count'],100)
  require 'LangAdapter'.LabelNodeAutoShrink(set['name'],160)
  require 'LangAdapter'.LabelNodeAutoShrink(set['tip'],160)
  require 'LangAdapter'.LabelNodeAutoShrink(set['layoutPrice_v1'],100)
  set['name']:setString(name)

  set['count']:setString(string.format(Res.locString('Guild$MallLimit'),tostring(lastAmount)))
  set['count']:setFontFillColor((lastAmount>0 and ccc4f(1.0,1.0,1.0,1.0)) or Res.color4F.red,true )
  set['layoutPrice_v2']:setString(tostring(v.price))
  local penable = v.price <= Point
  set['layoutPrice_v2']:setFontFillColor((penable and ccc4f(0.603922,0.419608,0.231373,1.0)) or Res.color4F.red,true)
  set['btnBuy']:setListener(function ( ... )
    self:storeBuy(v.id,v.price,name)
  end)
  
  if v.type == 10 then
    set['icon']:setScale(1.2)
  else
    set['icon']:setScale(0.8)
  end
  set['pieces']:setVisible(v.type == 10)

  set['layoutPrice']:setVisible(guildlv >= v.lv)
  set['btnBuy']:setEnabled(guildlv >= v.lv and penable)
  set['btnBuy']:setTouchGiveUpOnMoveOrOutOfRange(true)
  set['lock']:setVisible(guildlv < v.lv)
  set['tip']:setVisible(guildlv < v.lv)
  if guildlv < v.lv then
    set['tip']:setString(string.format(Res.locString('Guild$Tipunlock'),v.lv))
  end

  local func = nil
  if v.type == 6 or v.type == 10 then
    func = function ( ... )
      GleeCore:showLayer("DPetDetailV", {PetInfo = AppData.getPetInfo().getPetInfoByPetId(v.itemid)})
    end
  elseif v.type == 7 then
    func = function ( ... )
      local EquipInfo = AppData.getEquipInfo().getEquipInfoByEquipmentID(v.itemid)
      EquipInfo.Rank = AppData.getEquipInfo().getRank(EquipInfo)
      GleeCore:showLayer("DEquipDetail",{nEquip = EquipInfo})
    end
  elseif v.type == 9 then
    func = function ( ... )
      GleeCore:showLayer("DMaterialDetail", {materialId = v.itemid})
    end
  end
  
  set['btnDetail']:setListener(function ( ... )
    print(v)
    return func and func()
  end)
  set['btnDetail']:setTouchGiveUpOnMoveOrOutOfRange(true)
end

--data
function TLGuildMall:setBy( id,name ,func)
  if self._setmap == nil then
    self._setmap = {}
  end
  local set = self._setmap[id]
  if not set then
    set = self:createLuaSet(name)
    self._setmap[id]=set
    set[1]:retain()
    func(set)
  end
  return set
end


function TLGuildMall:clearSetMap( ... )
  if self._setmap then
    for k,v in pairs(self._setmap) do
      v[1]:release()
    end
  end
  self._setmap = nil
end

--net
function TLGuildMall:storeBuy( Id,price,name )

  local callback = function ( ... )
    self:send(netModel.getModelGuildStoreBuy(Id),function ( data )
      if data.D.Reward then
        GleeCore:showLayer('DGetReward',data.D.Reward)
      end
      AppData.updateResource(data.D.Resource)
      if data.D.Member then
        AppData.getGuildInfo().setGuildMember(data.D.Member)
      end
      self:updateLayer()
    end)
  end
  local cionstr = string.format(string.format('[color=63ff39ff]%s[/color]%s',tostring(price),Res.locString('Guild$dona')))
  local content = string.format(Res.locString('Global$BuyConfirmTip'),cionstr,tostring(name))

  GleeCore:showLayer('DConfirmNT',{content=content,callback=callback})
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLGuildMall, "TLGuildMall")


--------------------------------register--------------------------------
return TLGuildMall
