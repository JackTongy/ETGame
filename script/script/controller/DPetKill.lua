local Config = require "Config"
local Res = require 'Res'
local netModel = require 'netModel'
local Launcher = require 'Launcher'
local GuideHelper = require 'GuideHelper'

Launcher.register('DPetKill',function ( data )
  Launcher.callNet(netModel.getModelBossGet(),function ( netdata )
    if netdata and netdata.D and netdata.D.Bosses and #netdata.D.Bosses > 0 then
      Launcher.Launching(netdata)
    else
      GleeCore:toast(Res.locString('PetKill$Toast2'))
    end
  end)
end)

local DPetKill = class(TabDialog)

function DPetKill:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPetKill.cocos.zip")
    return self._factory:createDocument("DPetKill.cocos")
end

--@@@@[[[[
function DPetKill:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg = set:getElfNode("root_bg")
   self._root_tabs = set:getLinearLayoutNode("root_tabs")
   self._normal_v = set:getLabelNode("normal_v")
   self._pressed_v = set:getLabelNode("pressed_v")
   self._point = set:getElfNode("point")
   self._root_content = set:getElfNode("root_content")
   self._root_title = set:getElfNode("root_title")
   self._root_title_content = set:getLabelNode("root_title_content")
   self._root_close = set:getButtonNode("root_close")
   self._root_help = set:getButtonNode("root_help")
--   self._@tab = set:getTabNode("@tab")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DPetKill:onInit( userData, netData )
	self:registerTabs()
  Res.doActionDialogShow(self._root,function ( ... )
    GuideHelper:check('DPetKill')
  end)
  self._root_close:setListener(function ( ... )
    Res.doActionDialogHide(self._root, self)
    require 'EventCenter'.resetGroup('PetKillObs')
  end)
  	self._root_help:setVisible(false)
	self._root_help:setListener(function (  )
		GleeCore:showLayer("DHelp", {type = "神兽降临"})
	end)
end

function DPetKill:onBack( userData, netData )
	
  if self:getTabList()[self._currentTab] ~= nil then
    local tabList = self:getTabList()
    local obj = tabList[self._currentTab].obj
    if obj and obj.parentnotify then
      obj:parentnotify('back')
    end
  end

end

function DPetKill:close( ... )
  self:releaseTabs()
end

function DPetKill:registerTabs( ... )
  self:setTabRootNode(self._root_content)

  local tab1,set1 = self:createTabSetWith('@tab',Res.locString('DPetKill$tab1'))
  local tab2,set2 = self:createTabSetWith('@tab',Res.locString('DBossBattle$Rank'))
  local tab3,set3 = self:createTabSetWith('@tab',Res.locString('DBossBattle$Reward'))
  self:registerTab('TLPetKill',require 'TLPetKill',tab1)
  self:registerTab('TLPetKillRank',require 'TLPetKillRank',tab2)
  self:registerTab('TLPetKillReward',require 'TLPetKillReward',tab3)

  tab1:trigger(nil)
end

function DPetKill:createTabSetWith( nodename,tabname )
  local tab = self:createLuaSet(nodename)
  tab['normal_v']:setString(tabname)
  tab['pressed_v']:setString(tabname)
  require 'LangAdapter'.fontSize(tab['pressed_v'],nil,nil,24,nil,17)
  require 'LangAdapter'.fontSize(tab['normal_v'],nil,nil,24,nil,17)
  self._root_tabs:addChild(tab[1])
  return tab[1],tab
end
--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPetKill, "DPetKill")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPetKill", DPetKill)
