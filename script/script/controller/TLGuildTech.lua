local Config = require "Config"
local guildeffects = require 'guildeffects'
local AppData = require 'AppData'
local DBManager = require 'DBManager'
local Res = require 'Res'

local TLGuildTech = class(TabLayer)

function TLGuildTech:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLGuildTech.cocos.zip")
    return self._factory:createDocument("TLGuildTech.cocos")
end

--@@@@[[[[
function TLGuildTech:onInitXML()
    local set = self._set
   self._bg = set:getJoint9Node("bg")
   self._list = set:getListNode("list")
   self._layout = set:getLinearLayoutNode("layout")
   self._namelv = set:getLabelNode("namelv")
   self._effect = set:getLabelNode("effect")
   self._maxlv = set:getLabelNode("maxlv")
   self._btn = set:getButtonNode("btn")
   self._icon = set:getElfNode("icon")
   self._icon_pzbg = set:getElfNode("icon_pzbg")
   self._icon_frame = set:getElfNode("icon_frame")
   self._icon_pz = set:getElfNode("icon_pz")
   self._icon_lock = set:getElfNode("icon_lock")
   self._mydona = set:getLinearLayoutNode("mydona")
   self._mydona_V = set:getLabelNode("mydona_V")
   self._gold = set:getLinearLayoutNode("gold")
   self._gold_V = set:getLabelNode("gold_V")
--   self._@view = set:getElfNode("@view")
--   self._@line = set:getElfNode("@line")
--   self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLGuildTech:onInit( userData, netData )
  
end

function TLGuildTech:onEnter( ... )
  self:updateLayer()
end

function TLGuildTech:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function TLGuildTech:updateLayer( ... )
  self:updateList()
end

function TLGuildTech:updateList( ... )
  local guildinfo = AppData.getGuildInfo().getData()
  local meminfo = AppData.getGuildInfo().getGuildMember()
  local Tclvs = meminfo.TcLvs
  local gTclvs = guildinfo.TcLvs
  
  self._viewSet['gold_V']:setString(tostring(guildinfo.Point))
  self._viewSet['mydona_V']:setString(tostring(meminfo.Point))

  local list = self._viewSet['list']
  list:getContainer():removeAllChildrenWithCleanup(true)

  local techs
  if AppData.getGuildInfo().selfPresident() then
    techs = table.clone(guildeffects)
    table.insert(techs,1,{type=0,unlock=1,tcname=Res.locString('Guild$Lv')})
  else
    techs = guildeffects
  end

  local lineset
  for i,v in ipairs(techs) do
    if (i-1)%2 == 0 then
      lineset = self:createLuaSet('@line')
      list:getContainer():addChild(lineset[1])
    end
    
    local itemset = self:createLuaSet('@item')
    lineset['layout']:addChild(itemset[1])

    self:refreshSet(itemset,v,Tclvs[tostring(v.type)],gTclvs[tostring(v.type)],v.unlock <= guildinfo.Lv)
  end

end

function TLGuildTech:refreshSet( set,v,selflv,maxlv ,unlock)

  set['namelv']:setString(string.format('%s Lv.%d',v.tcname,selflv or 1))
  if v.type == 0 then
    local guildinfo = AppData.getGuildInfo().getData()
    local lvcfg = DBManager.getGuildlv(guildinfo.Lv)
    set['namelv']:setString(string.format('%s Lv.%d',v.tcname,guildinfo.Lv))
    set['effect']:setString(string.format(Res.locString('Guild$members'),tostring(lvcfg.number)))
    set['maxlv']:setString('')
  elseif unlock then
    set['effect']:setString(string.format(Res.locString('Guild$Techeffect'),tostring(DBManager.getGuildtclveffectDes(selflv,v.type)),tostring(v.efname)))
    set['maxlv']:setString(string.format(Res.locString('Guild$TechLv'),tostring(maxlv or 1))) --公会等级 解锁  
    require 'LangAdapter'.selectLang(nil,nil,nil,function ( ... )
      set['effect']:setString(string.format(Res.locString('Guild$Techeffect'),tostring(v.efname),tostring(DBManager.getGuildtclveffectDes(selflv,v.type))))      
    end)
  else
    set['effect']:setString(string.format(Res.locString('Guild$TechLvUnlock'),tostring(v.unlock)))
    set['effect']:setFontFillColor(ccc4f(0.623529,0.235294,0.184314,1.0),true)
    set['maxlv']:setVisible(false)
  end
  require 'LangAdapter'.LabelNodeAutoShrink(set['effect'],230)
  set['btn']:setListener(function ( ... )
    self:stuTech(v,selflv,maxlv)
  end)

  local frame,pz,bg = Res.getGuildTechIcon(v.type,selflv)
  set['icon_pzbg']:setResid(bg)
  set['icon_pz']:setResid(pz)
  set['icon_frame']:setResid(frame)
  set['icon_lock']:setVisible(not unlock)
  set['btn']:setVisible(unlock)
  
end

function TLGuildTech:stuTech( v )
  GleeCore:showLayer('DGuildTechStu',{tech=v})
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLGuildTech, "TLGuildTech")


--------------------------------register--------------------------------
return TLGuildTech
