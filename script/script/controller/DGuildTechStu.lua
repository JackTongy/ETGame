local Config = require "Config"
local Res = require 'Res'
local AppData = require 'AppData'
local DBManager = require 'DBManager'
local netModel = require 'netModel'

local DGuildTechStu = class(LuaDialog)

function DGuildTechStu:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGuildTechStu.cocos.zip")
    return self._factory:createDocument("DGuildTechStu.cocos")
end

--@@@@[[[[
function DGuildTechStu:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_close = set:getButtonNode("root_close")
   self._root_bg = set:getJoint9Node("root_bg")
   self._root_tbg = set:getElfNode("root_tbg")
   self._root_tip = set:getLabelNode("root_tip")
   self._root_btnLeft = set:getButtonNode("root_btnLeft")
   self._root_btnRight = set:getButtonNode("root_btnRight")
   self._root_new = set:getElfNode("root_new")
   self._root_new_pzbg = set:getElfNode("root_new_pzbg")
   self._root_new_frame = set:getElfNode("root_new_frame")
   self._root_new_pz = set:getElfNode("root_new_pz")
   self._root_new_name = set:getLabelNode("root_new_name")
   self._root_new_effect = set:getLabelNode("root_new_effect")
   self._root_old = set:getElfNode("root_old")
   self._root_old_pzbg = set:getElfNode("root_old_pzbg")
   self._root_old_frame = set:getElfNode("root_old_frame")
   self._root_old_pz = set:getElfNode("root_old_pz")
   self._root_old_name = set:getLabelNode("root_old_name")
   self._root_old_effect = set:getLabelNode("root_old_effect")
   self._root_btnActive = set:getClickNode("root_btnActive")
   self._root_btnActive_title = set:getLabelNode("root_btnActive_title")
   self._root_title = set:getLabelNode("root_title")
   self._root_cost = set:getLinearLayoutNode("root_cost")
   self._root_cost_title = set:getLabelNode("root_cost_title")
   self._root_cost_v = set:getLabelNode("root_cost_v")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DGuildTechStu:onInit( userData, netData )
	self._root_close:setListener(function ( ... )
    Res.doActionDialogHide(self._root, self)
  end)
  Res.doActionDialogShow(self._root)

  self._root_btnLeft:setListener(function ( ... )
    self:updateResearch()
  end)
  self._root_btnRight:setListener(function ( ... )
    self:updateStu()
  end)

  self:updateLayer()
end

function DGuildTechStu:onBack( userData, netData )
	
end

function DGuildTechStu:close( ... )
  local userData = self:getUserData()
  return userData and userData.callback and userData.callback()
end

--------------------------------custom code-----------------------------
function DGuildTechStu:updateLayer( ... )

  local guildinfo = AppData.getGuildInfo()
  self._research = guildinfo.selfPresident()
  self._maxGuildLv = #(require 'guildlv')
  local cfg = DBManager.getGuildlv(self._maxGuildLv)
  self._maxResearchLv = cfg.tclv

  self._guildId = guildinfo.getData().Id
  --tech:{type=0,unlock=1,tcname='公会等级'}
  if self._research then
    self:updateResearch()
  else
    self:updateStu()
  end

end

function DGuildTechStu:updateStu( ... )
  self._root_btnLeft:setVisible(self._research)
  self._root_btnRight:setVisible(false)
  self._root_title:setString(Res.locString('Guild$TechStu'))
  self._root_btnActive_title:setString(Res.locString('Guild$btnStu'))

  local tech = self:getUserData().tech
  local meminfo = AppData.getGuildInfo().getGuildMember()
  local guildinfo = AppData.getGuildInfo().getData()
  local gTclvs = guildinfo.TcLvs
  local Tclvs = meminfo.TcLvs

  local curlv = Tclvs[tostring(tech.type)]
  local max = curlv == self._maxResearchLv
  local needrech = gTclvs[tostring(tech.type)] <= curlv
  local nextlv = (max and self._maxResearchLv) or (curlv + 1)
  
  self._root_old_name:setString(string.format('%s Lv.%d',tostring(tech.tcname),curlv))
  self._root_new_name:setString(string.format('%s Lv.%d',tostring(tech.tcname),nextlv))
  self._root_old_effect:setString(string.format('%s+%s',tostring(tech.efname),tostring(DBManager.getGuildtclveffectDes(curlv,tech.type))))
  self._root_new_effect:setString(string.format('%s+%s',tostring(tech.efname),tostring(DBManager.getGuildtclveffectDes(nextlv,tech.type))))
  if needrech then
    self._root_tip:setString(string.format(Res.locString('Guild$TechLvLimit'),nextlv))
  end
  if max then
    self._root_tip:setString(Res.locString('Global$LevelCap'))
  end

  local cfg = DBManager.getGuildtclv(curlv)

  self._root_btnActive:setEnabled(not max and not needrech)
  self._root_tip:setVisible(needrech or max)
  self._root_cost:setVisible(not max and not needrech)
  self._root_cost_title:setString(Res.locString('Guild$costDonate'))
  self._root_cost_v:setString(tostring(cfg.learns[tech.type]))

  self:refreshIcons(tech.type,curlv,nextlv)
  self._root_btnActive:setListener(function ( ... )
    self:stuTech(tech.type)
  end)

end

function DGuildTechStu:updateResearch( ... )
  self._root_btnLeft:setVisible(false)
  self._root_btnRight:setVisible(self._research)
  self._root_title:setString(Res.locString('Guild$TechRereach'))
  self._root_btnActive_title:setString(Res.locString('Guild$btnTechResearch'))

  local tech = self:getUserData().tech
  local guildinfo = AppData.getGuildInfo().getData()
  local gTclvs = guildinfo.TcLvs
  local guildlvcfg = DBManager.getGuildlv(guildinfo.Lv)
  
  if tech.type == 0 then
    local curlv = guildinfo.Lv
    local max = curlv == self._maxGuildLv
    local nextlv = (max and curlv) or (curlv+1)
    if not max then
      self._root_cost_title:setString(Res.locString('Guild$costCa'))
      self._root_cost_v:setString(tostring(guildlvcfg.consume))
    else
      self._root_tip:setString(Res.locString('Global$LevelCap'))
    end
    self._root_tip:setVisible(max)
    self._root_cost:setVisible(not max)
    self._root_btnActive:setEnabled(not max)
    self._root_old_name:setString(string.format('%s Lv.%d',tostring(tech.tcname),curlv))
    self._root_new_name:setString(string.format('%s Lv.%d',tostring(tech.tcname),nextlv))
    self._root_old_effect:setString(string.format(Res.locString('Guild$members'),tostring(guildlvcfg.number)))
    local nextlvcfg = DBManager.getGuildlv(nextlv)
    self._root_new_effect:setString(string.format(Res.locString('Guild$members'),tostring(nextlvcfg.number)))
    self._root_btnRight:setVisible(false)
    self:refreshIcons(tech.type,curlv,nextlv)
    self._root_btnActive:setListener(function ( ... )
      self:guildUpgradeLv()
    end)
  else
    local curlv = gTclvs[tostring(tech.type)]
    local max = curlv == self._maxResearchLv
    local needrech = guildlvcfg.tclv == curlv
    local nextlv = (max and self._maxResearchLv) or (curlv + 1)
    self._root_old_name:setString(string.format('%s Lv.%d',tostring(tech.tcname),curlv))
    self._root_new_name:setString(string.format('%s Lv.%d',tostring(tech.tcname),nextlv))
    self._root_old_effect:setString(string.format('%s+%s',tostring(tech.efname),tostring(DBManager.getGuildtclveffectDes(curlv,tech.type))))
    self._root_new_effect:setString(string.format('%s+%s',tostring(tech.efname),tostring(DBManager.getGuildtclveffectDes(nextlv,tech.type))))
    self._root_btnActive:setEnabled(not max and not needrech)
    self._root_btnActive:setListener(function ( ... )
      self:researchTech(tech.type)
    end)
    if max then
      self._root_tip:setString(Res.locString('Global$LevelCap'))
    elseif needrech then
      local cfg = self:getMinGuildLvByTclv(nextlv)
      self._root_tip:setString(string.format(Res.locString('Guild$guildLvLimit'),tostring(cfg.lv)))
    else
      self._root_cost_title:setString(Res.locString('Guild$costCa'))
      local tclvcfg = DBManager.getGuildtclv(curlv)
      self._root_cost_v:setString(tostring(tclvcfg.develops[tech.type]))
    end
    
    self._root_cost:setVisible(not max and not needrech)
    self._root_tip:setVisible(max or needrech)
    self:refreshIcons(tech.type,curlv,nextlv)
    self._root_btnActive:setListener(function ( ... )
      self:researchTech(tech.type)
    end)
  end

end

function DGuildTechStu:getMinGuildLvByTclv( lv )
  local _table = require 'guildlv'
  if _table then
    for i,v in ipairs(_table) do
      if v.tclv == lv then
        return v
      end
    end
  end
  return nil
end

function DGuildTechStu:refreshIcons( Type,curlv,nextlv )
  local oldframe,oldpz,oldbg = Res.getGuildTechIcon(Type,curlv)
  local newframe,newpz,newbg = Res.getGuildTechIcon(Type,nextlv)
  self._root_new_pzbg:setResid(newbg)
  self._root_new_frame:setResid(newframe)
  self._root_new_pz:setResid(newpz)
  self._root_old_pzbg:setResid(oldbg)
  self._root_old_frame:setResid(oldframe)
  self._root_old_pz:setResid(oldpz)
end

--net
function DGuildTechStu:stuTech( Type )
  self:send(netModel.getModelGuildMemberUpgradeTcLv(Type),function ( data )
    if data.D.Member then
      AppData.getGuildInfo().setGuildMember(data.D.Member)
    end
    self:updateStu()
    self:toast(Res.locString('Guild$Toast1'))
  end)
end

function DGuildTechStu:researchTech( Type )
  self:send(netModel.getModelGuildUpgradeTcLv(self._guildId,Type),function ( data )
    if data.D.Guild then
      AppData.getGuildInfo().setData(data.D.Guild)
    end
    self:updateLayer()
    self:toast(Res.locString('Guild$Toast2'))
  end)
end

function DGuildTechStu:guildUpgradeLv( ... )
  self:send(netModel.getModelGuildUpgradeLv(self._guildId),function ( data )
    if data.D.Guild then
      AppData.getGuildInfo().setData(data.D.Guild)
    end
    self:updateLayer()
    self:toast(Res.locString('Guild$Toast3'))
  end)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGuildTechStu, "DGuildTechStu")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGuildTechStu", DGuildTechStu)
