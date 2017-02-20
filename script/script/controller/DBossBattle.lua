local Config = require "Config"
local Res = require "Res"
local dbManager = require "DBManager"
local appData = require "AppData"
local netModel = require "netModel"
local eventCenter = require 'EventCenter'
local Launcher = require 'Launcher'

Launcher.register('DBossBattle',function ( data )

  Launcher.callNet(netModel.getBossAtkGet(),function ( data )
    local bossId = data.D.BossAtk.BossId
    Launcher.callNet(netModel.getBossAtkRank(bossId),function ( data1 )
      data.rankData = data1.D
      Launcher.Launching(data)  
    end)
  end)

end)

local DBossBattle = class(TabDialog)

function DBossBattle:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DBossBattle.cocos.zip")
    return self._factory:createDocument("DBossBattle.cocos")
end

--@@@@[[[[
function DBossBattle:onInitXML()
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

function DBossBattle:onInit( userData, netData )
  self._netData = netData
  self._curdbBoss = dbManager.getBossAtk(self._netData.D.BossAtk.BossId)
  self:refreshBossTitle()
	self:registerTabs()
  Res.doActionDialogShow(self._root,function ( ... )
    require 'GuideHelper':check('DBossBattle')
  end)
  self._root_close:setListener(function ( ... )
    Res.doActionDialogHide(self._root, self)
    eventCenter.resetGroup('BossBattleObs')
  end)
  self._root_help:setListener(function ( ... )
    GleeCore:showLayer("DHelp", {type = "Boss战"})
  end)
end

function DBossBattle:onBack( userData, netData )
	
end

function DBossBattle:registerTabs( ... )
  self:setTabRootNode(self._root_content)
  local tab1,set1 = self:createTabSetWith('@tab',Res.locString('DBossBattle$Boss'))
  local tab2,set2 = self:createTabSetWith('@tab',Res.locString('DBossBattle$Rank'))
  local tab3,set3 = self:createTabSetWith('@tab',Res.locString('DBossBattle$Reward'))
  self:registerTab('TLBoss',require 'TLBoss',tab1)
  self:registerTab('TLBossRank',require 'TLBossRank',tab2)
  self:registerTab('TLBossReward',require 'TLBossReward',tab3)

  tab1:trigger(nil)
end

function DBossBattle:close( ... )
  self:releaseTabs()
end

function DBossBattle:createTabSetWith( nodename,tabname )
  local tab = self:createLuaSet(nodename)
  tab['normal_v']:setString(tabname)
  tab['pressed_v']:setString(tabname)
  require 'LangAdapter'.fontSize(tab['pressed_v'],nil,nil,24,nil,20)
  require 'LangAdapter'.fontSize(tab['normal_v'],nil,nil,24,nil,20)
  self._root_tabs:addChild(tab[1])
  return tab[1],tab
end

function DBossBattle:refreshBossTitle( rank )
  if rank then
    local BossId = self._netData.rankData.BossId
    local curdbBoss = dbManager.getBossAtk(BossId)
    self._root_title_content:setString(string.format(Res.locString('DBossBattle$BossTitle'),curdbBoss.Name))
  else
    self._root_title_content:setString(string.format(Res.locString('DBossBattle$BossTitle'),self._curdbBoss.Name))  
  end
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DBossBattle, "DBossBattle")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DBossBattle", DBossBattle)
