local Config = require "Config"
local Res    = require 'Res'
local DBManager = require 'DBManager'

local DPetExInfo = class(LuaDialog)

function DPetExInfo:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPetExInfo.cocos.zip")
    return self._factory:createDocument("DPetExInfo.cocos")
end

--@@@@[[[[
function DPetExInfo:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_btnbg = set:getButtonNode("root_btnbg")
   self._root_bg = set:getJoint9Node("root_bg")
   self._root_tbg = set:getElfNode("root_tbg")
   self._root_title = set:getLabelNode("root_title")
   self._root_base = set:getElfNode("root_base")
   self._root_base_p4Value = set:getLabelNode("root_base_p4Value")
   self._root_base_btitle = set:getLabelNode("root_base_btitle")
   self._root_base_linearlayout_p3Value = set:getLabelNode("root_base_linearlayout_p3Value")
   self._root_base_linear_p1Value = set:getLabelNode("root_base_linear_p1Value")
   self._root_base_linear_p2Value = set:getLabelNode("root_base_linear_p2Value")
   self._root_equip = set:getElfNode("root_equip")
   self._root_equip_linear_p1Value = set:getLabelNode("root_equip_linear_p1Value")
   self._root_equip_p4Value = set:getLabelNode("root_equip_p4Value")
   self._root_equip_extitle = set:getLabelNode("root_equip_extitle")
   self._root_equip_linear_p7Value = set:getLabelNode("root_equip_linear_p7Value")
   self._root_equip_linear_p10 = set:getLabelNode("root_equip_linear_p10")
   self._root_equip_linear_p10Value = set:getLabelNode("root_equip_linear_p10Value")
   self._root_equip_linear_p5Value = set:getLabelNode("root_equip_linear_p5Value")
   self._root_equip_linear_p2Value = set:getLabelNode("root_equip_linear_p2Value")
   self._root_equip_linear_p3Value = set:getLabelNode("root_equip_linear_p3Value")
   self._root_equip_linear_p6 = set:getLabelNode("root_equip_linear_p6")
   self._root_equip_linear_p6Value = set:getLabelNode("root_equip_linear_p6Value")
   self._root_equip_linear_p8Value = set:getLabelNode("root_equip_linear_p8Value")
   self._root_equip_linear_p9Value = set:getLabelNode("root_equip_linear_p9Value")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DPetExInfo:onInit( userData, netData )
	Res.doActionDialogShow(self._root)
  self.nPet   = userData and userData.nPet
  self.equipments = userData and userData.equipments
  self.team   = userData and userData.team
  self.dbPet  = DBManager.getCharactor(self.nPet.PetId)
  
  self._root_btnbg:setListener(function ( ... )
    Res.doActionDialogHide(self._root,self)
  end)

  self:updateLayer()
end

function DPetExInfo:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DPetExInfo:updateLayer( ... )


  local ex_a = 0
  local ex_d = 0
  local ex_f = 0
  local ex_h = 0
  local ex_s = 0
  local ex_crit   = 0
  local ex_broken = 0
  local ex_cure   = 0
  local ex_speed  = 0
  local ex_m = 0

  if not self.nPet.fromdb then
    local extInfo = require 'AppData'.getEquipInfo().getEquipEffectsWithPetId(self.nPet.Id,self.team,self.equipments)
    ex_a = extInfo['a'] or ex_a
    ex_d = extInfo['d'] or ex_d
    ex_f = extInfo['f'] or ex_f
    ex_h = extInfo['h'] or ex_h
    ex_s = extInfo['s'] or ex_s
    ex_m = extInfo['m'] or ex_m
    ex_crit = extInfo['crit'] or ex_crit
    ex_broken = extInfo['broken'] or ex_broken
    ex_cure   = extInfo['cure'] or ex_cure
    ex_speed  = extInfo['speed'] or ex_speed
  end
  
  local getstr = function ( v )
    return string.format('%d%%',((v and tonumber(v)) or 0)*100)
  end
  local getstr2 = function ( v )
    return tostring(math.floor((v and tonumber(v)) or 0 ))
  end
  self._root_equip_linear_p1Value:setString(getstr2(ex_a))
  self._root_equip_linear_p2Value:setString(getstr2(ex_d))
  self._root_equip_linear_p3Value:setString(getstr2(ex_s))
  self._root_equip_p4Value:setString(getstr2(ex_h))
  self._root_equip_linear_p5Value:setString(getstr2(ex_f))
  self._root_equip_linear_p6Value:setString(getstr(ex_crit))
  self._root_equip_linear_p7Value:setString(getstr2(ex_broken))
  self._root_equip_linear_p8Value:setString(getstr(ex_cure))
  self._root_equip_linear_p9Value:setString(getstr(ex_speed))
  self._root_equip_linear_p10Value:setString(getstr(ex_m))

  self._root_base_linear_p1Value:setString(getstr2(self.nPet.Atk-ex_a))
  self._root_base_p4Value:setString(getstr2(self.nPet.Hp-ex_h))
  self._root_base_linear_p2Value:setString(getstr2(self.nPet.Def-ex_d))
  self._root_base_linearlayout_p3Value:setString(string.format('%d%%',tonumber(self.nPet.Crit)*100))

  require 'LangAdapter'.LabelNodeAutoShrink(self._root_equip_linear_p10,88)
  require 'LangAdapter'.LabelNodeAutoShrink(self._root_equip_linear_p6,88)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPetExInfo, "DPetExInfo")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPetExInfo", DPetExInfo)
