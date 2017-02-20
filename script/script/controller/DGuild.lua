local Config = require "Config"
local res = require "Res"
local Res = require 'Res'
local dbManager = require "DBManager"
local AppData = require "AppData"
local netModel = require "netModel"
local GuideHelper = require 'GuideHelper'
local UnlockManager = require 'UnlockManager'
local Launcher = require 'Launcher'
local EventCenter = require 'EventCenter'
local layerManager = require "framework.interface.LuaLayerManager"

Launcher.register('DGuild',function ( userdata )

  local guildinfo = AppData.getGuildInfo()
  local meminfo = guildinfo.getGuildMember()

  local checkGuildInfo = function ( ... )
	 -- if not guildinfo.getData() then --每次都更新公会信息
		Launcher.callNet(netModel.getModelGuildGet(meminfo.Gid),function ( data )
		  AppData.getGuildInfo().setData(data.D.Guild)
		  AppData.getGuildInfo().setPresidentLastLoginAt(data.D.PresidentLastLoginAt)
		  AppData.getGuildInfo().setElectionState(data.D.ElectionState)
		  print('refresh guildinfo')
		  Launcher.Launching()
	  	end)
	 -- else
		-- Launcher.Launching()
	 -- end
  end

  if guildinfo.isInGuild() then
	 Launcher.callNet(netModel.getModelGuildGetRanks(),function ( data )
		guildinfo.setRanks(data.D)
		Launcher.callNet(netModel.getModelGuildMyPointGet(),function ( data )
			guildinfo.setMPoint(data.D.MyPoint)
			checkGuildInfo()
		end)
	 end)
  else
	 GleeCore:showLayer('DClub')
  end

  EventCenter.resetGroup('DGuildLisener')
  EventCenter.addEventFunc('GuildMember',function ( mem )
	 local guildinfo = AppData.getGuildInfo()
	 if mem then
		local oldstate = guildinfo.isInGuild()
		guildinfo.setGuildMember(mem)
		local newstate = guildinfo.isInGuild()
		print(tostring(oldstate))
		print(tostring(newstate))
		if oldstate and not newstate then
		  --DGuild
		  guildinfo.setData(nil)
		  if layerManager.isRunning('DGuild') then
			 GleeCore:closeAllLayers({Menu=true,guideLayer=true})
			 GleeCore:showLayer('DClub')
		  end
		elseif not oldstate and newstate then
		  --DClub
		  if layerManager.isRunning('DClub') then
			 GleeCore:closeAllLayers({Menu=true,guideLayer=true})
			 GleeCore:showLayer('DGuild')
		  end
		end
	 end
  end,'DGuildLisener')

  EventCenter.addEventFunc('SERVERERRORCODE',function ( data )
	 if data and (data.Code == 16013  or data.Code == 16017) then --公会已解散
		local guildinfo = AppData.getGuildInfo()
		guildinfo.setData(nil)
		guildinfo.getGuildMember().Gid = 0
		if layerManager.isRunning('DGuild') then
		  GleeCore:closeAllLayers({Menu=true,guideLayer=true})
		  GleeCore:showLayer('DClub')
		else
		  GleeCore:showLayer('DClub')
		end
	 end
  end,'DGuildLisener')

end)

local DGuild = class(TabDialog)

function DGuild:createDocument()
	 self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGuild.cocos.zip")
	 return self._factory:createDocument("DGuild.cocos")
end

--@@@@[[[[
function DGuild:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg = set:getElfNode("root_bg")
   self._root_tabs = set:getLinearLayoutNode("root_tabs")
   self._normal_v = set:getLabelNode("normal_v")
   self._pressed_v = set:getLabelNode("pressed_v")
   self._point = set:getElfNode("point")
   self._normal_v = set:getLabelNode("normal_v")
   self._pressed_v = set:getLabelNode("pressed_v")
   self._point = set:getElfNode("point")
   self._root_content = set:getElfNode("root_content")
   self._root_title = set:getElfNode("root_title")
   self._root_title_content = set:getLabelNode("root_title_content")
   self._root_close = set:getButtonNode("root_close")
--   self._@tab = set:getTabNode("@tab")
--   self._@lock = set:getClickNode("@lock")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DGuild:onInit( userData, netData )

  self._root_close:setListener(function ( ... )
	 Res.doActionDialogHide(self._root, self)
	 AppData.getGuildInfo().setData(nil) 
  end)
  self:registerTabs()

  Res.doActionDialogShow(self._root)

  EventCenter.addEventFunc("GoToHunt", function ( data )
  	if not GleeCore:isRunningLayer("DHunt") then
  		self:close()
		GleeCore:showLayer("DHunt", {AreaId = data and data.AreaId})
	end
  end, "DGuild")

end

function DGuild:onBack( userData, netData )
	self:refreshTab()
end

function DGuild:close( ... )
  EventCenter.resetGroup('DGuild')
end

function DGuild:registerTabs( ... )
  --TLGuildM
  self:setTabRootNode(self._root_content)

  local tab1,set1
  local tab2,set2
  local tab3,set3
  local tab4,set4

  tab1,set1 = self:createTabSetWith('@tab',Res.locString('Guild$title'))
  self:registerTab('TLGuildM',require 'TLGuildM',tab1)

  tab2,set2 = self:createTabSetWith('@tab',Res.locString('Guild$Mall'))
  self:registerTab('TLGuildMall',require 'TLGuildMall',tab2)

  tab3,set3 = self:createTabSetWith('@tab',Res.locString('Guild$tabTech'))
  self:registerTab('TLGuildTech',require 'TLGuildTech',tab3)
  -- tab3,set3= self:createTabSetWith('@lock',Res.locString('Guild$tabTech'))
  -- tab3:setListener(function ( ... )
  --   self:toast('功能暂未开放，敬请期待')
  -- end)

  tab4,set4 = self:createTabSetWith('@tab',Res.locString('Guild$Tabrank'))
  self:registerTab('TLGuildRank',require 'TLGuildRank',tab4)

  if require 'UnlockManager':isOpen('Hunt') and UnlockManager:isUnlock('GuildCopyLv') then
 	tab5,set5 = self:createTabSetWith('@tab',Res.locString('Hunt$tabTitle3'))
	self:registerTab('TLGuildTreasure',require 'TLGuildTreasure',tab5)
  end
  tab1:trigger(nil)
end
--------------------------------custom code-----------------------------


function DGuild:createTabSetWith( nodename,tabname )
  local tab = self:createLuaSet(nodename)
  tab['normal_v']:setString(tabname)
  tab['pressed_v']:setString(tabname)
  require 'LangAdapter'.fontSize(tab['normal_v'],nil,nil,nil,nil,19)
  require 'LangAdapter'.fontSize(tab['pressed_v'],nil,nil,nil,nil,19)
  self._root_tabs:addChild(tab[1])
  return tab[1],tab
end


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGuild, "DGuild")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGuild", DGuild)
