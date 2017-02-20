local Config = require "Config"
local Res = require 'Res'
local AppData = require 'AppData'
local Launcher = require 'Launcher'
local netModel = require 'netModel'
local GuideHelper = require 'GuideHelper'
local eventCenter = require 'EventCenter'

local DPetList = class(TabDialog)

Launcher.register('DPetList',function ( data )
  Launcher.callNet(netModel.getModelPetGetPieces(),function ( data )
    AppData.getPetInfo().setPetPieces(data.D.Pieces)   
    Launcher.Launching()
  end)
end)

function DPetList:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPetList.cocos.zip")
    return self._factory:createDocument("DPetList.cocos")
end

--@@@@[[[[
function DPetList:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg = set:getElfNode("root_bg")
   self._root_topBar_ftpos_tabs = set:getLinearLayoutNode("root_topBar_ftpos_tabs")
   self._normal_v = set:getLabelNode("normal_v")
   self._pressed_v = set:getLabelNode("pressed_v")
   self._point = set:getElfNode("point")
   self._normal_v = set:getLabelNode("normal_v")
   self._pressed_v = set:getLabelNode("pressed_v")
   self._root_topBar_ftpos2_close = set:getButtonNode("root_topBar_ftpos2_close")
   self._root_content = set:getElfNode("root_content")
--   self._@tab = set:getTabNode("@tab")
--   self._@tabdis = set:getClickNode("@tabdis")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DPetList:onInit( userData, netData )
	
  self:registerTabs()
  Res.doActionDialogShow(self._root,function ( ... )
    GuideHelper:registerPoint('关闭',self._root_topBar_ftpos2_close)
    GuideHelper:check(self._currentTab)
  end)

  self._root_topBar_ftpos2_close:setListener(function ( ... )
    Res.doActionDialogHide(self._root, self)
  end)

  local size = CCDirector:sharedDirector():getWinSize()
  self._root_bg:setScaleX(size.width / self._root_bg:getWidth())

end

function DPetList:onBack( userData, netData )
	self:refreshTab('back')
end

function DPetList:registerTabs( ... )
    
  local enable = AppData.getPetInfo().hasPieces()
  
  self:setTabRootNode(self._root_content)

  local tab1,set1 = self:createTabSetWith('@tab',Res.locString('Pet$TLTab1'))
  self:registerTab('TLPetList',require 'TLPetList',tab1)

  local tab2,set2
  if not enable then
    tab2,set2 = self:createTabSetWith('@tabdis',Res.locString('Pet$TLTab2'))
    tab2:setListener(function ( ... )
      self:toast(Res.locString('Pet$EmptyPiceces'))
    end)
  else
    tab2,set2 = self:createTabSetWith('@tab',Res.locString('Pet$TLTab2'))
    self:registerTab('TLPetPieces',require 'TLPetPieces',tab2)
  end
  local tab3,set3 = self:createTabSetWith('@tab',Res.locString('Pet$TLTab3'))
  self:registerTab('TLPetMix',require 'TLPetMix',tab3)

  self._tabs = {
    [1] = tab1,
    [2] = tab2,
    [3] = tab3,
  }
  self._tabsets = {
    [1] = set1,
    [2] = set2,
    [3] = set3,
  }
  local firsttab = tab1
  local firsttabname
  local userData = self:getUserData()
  if userData and userData.tab then
    local tabs = self._tabs
    firsttab = tabs[userData.tab]
  end
  firsttab:trigger(nil)

  eventCenter.addEventFunc('EventTabSelect',function ( data )
    if data and data.layer == 'DPetList' and data.tab then
      local tab = self._tabs[data.tab]
      tab:trigger(nil)
    end
  end,'DPetList')

  self:refreshPointState()
end

function DPetList:createTabSetWith( nodename,tabname )
  local tab = self:createLuaSet(nodename)
  tab['normal_v']:setString(tabname)
  tab['pressed_v']:setString(tabname)
  require 'LangAdapter'.fontSize(tab['pressed_v'],nil,nil,24,nil,24,nil,nil,nil,20,20)
  require 'LangAdapter'.fontSize(tab['normal_v'],nil,nil,24,nil,24,nil,nil,nil,20,20)
  self._root_topBar_ftpos_tabs:addChild(tab[1])
  return tab[1],tab
end

function DPetList:close( ... )
  eventCenter.resetGroup('DPetList')
  GuideHelper:check('CloseDialog')
  local userData = self:getUserData()
  if userData and userData.callback then
    userData.callback()
  end
  self:releaseTabs()
end
--------------------------------custom code-----------------------------

function DPetList:tabReInit( ... )
  self:releaseTabs()
  self._root_topBar_ftpos_tabs:removeAllChildrenWithCleanup(true)
  self:registerTabs()
end


function DPetList:refreshPointState( ... )
  local v = require 'BroadCastInfo'.get('pet_piece')
  if self._tabsets[2]['point'] then
    self._tabsets[2]['point']:setVisible(v)
  end
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPetList, "DPetList")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPetList", DPetList)
