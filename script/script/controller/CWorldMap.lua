local config = require "Config"
local gameFunc = require "AppData"
local res = require "Res"
local dbManager = require "DBManager"
local netModel = require "netModel"
local Broadcast = require 'framework.net.Broadcast'
local eventCenter = require 'EventCenter'
local GuideHelper = require 'GuideHelper'

local userFunc = gameFunc.getUserInfo()
local townFunc = gameFunc.getTownInfo()

local CWorldMap = class(LuaController)

 function CWorldMap:createDocument()
      return gameFunc.getTempInfo().getValueForKey("WorldMapDocument")
 end

--@@@@[[[[
function CWorldMap:onInitXML()
	local set = self._set
    self._btnHideMenu = set:getButtonNode("btnHideMenu")
    self._map = set:getMapNode("map")
    self._mapBg = set:getLinearLayoutNode("mapBg")
    self._effectLayer = set:getElfNode("effectLayer")
    self._effectLayer_mogu = set:getElfNode("effectLayer_mogu")
    self._effectLayer_dy = set:getElfNode("effectLayer_dy")
    self._detail = set:getElfNode("detail")
    self._name = set:getLabelNode("name")
    self._point = set:getElfNode("point")
    self._detail_btnTown5001 = set:getClickNode("detail_btnTown5001")
    self._detail_btnTown5002 = set:getClickNode("detail_btnTown5002")
    self._detail_btnTown5003 = set:getClickNode("detail_btnTown5003")
    self._detail_btnTown5004 = set:getClickNode("detail_btnTown5004")
    self._detail_btnTown5005 = set:getClickNode("detail_btnTown5005")
    self._detail_btnTown5006 = set:getClickNode("detail_btnTown5006")
    self._detail_btnTown5007 = set:getClickNode("detail_btnTown5007")
    self._detail_btnTown5008 = set:getClickNode("detail_btnTown5008")
    self._detail_btnTown5009 = set:getClickNode("detail_btnTown5009")
    self._detail_btnTown5010 = set:getClickNode("detail_btnTown5010")
    self._detail_btnTown5011 = set:getClickNode("detail_btnTown5011")
    self._detail_btnTown5012 = set:getClickNode("detail_btnTown5012")
    self._detail_btnTown5013 = set:getClickNode("detail_btnTown5013")
    self._detail_btnTown5014 = set:getClickNode("detail_btnTown5014")
    self._detail_btnTown5015 = set:getClickNode("detail_btnTown5015")
    self._detail_btnTown5101 = set:getClickNode("detail_btnTown5101")
    self._detail_btnTown5102 = set:getClickNode("detail_btnTown5102")
    self._next = set:getElfNode("next")
    self._role = set:getElfNode("role")
    self._effectLayer2 = set:getElfNode("effectLayer2")
    self._effectLayer2_snowBase1 = set:getElfNode("effectLayer2_snowBase1")
    self._effectLayer2_snowBase2 = set:getElfNode("effectLayer2_snowBase2")
    self._effectLayer2_snowBase3 = set:getElfNode("effectLayer2_snowBase3")
    self._mapBg = set:getLinearLayoutNode("mapBg")
    self._effectLayer = set:getElfNode("effectLayer")
    self._effectLayer_dy = set:getElfNode("effectLayer_dy")
    self._effectLayer_mogu = set:getElfNode("effectLayer_mogu")
    self._detail = set:getElfNode("detail")
    self._name = set:getLabelNode("name")
    self._point = set:getElfNode("point")
    self._detail_btnTown2001 = set:getClickNode("detail_btnTown2001")
    self._detail_btnTown2002 = set:getClickNode("detail_btnTown2002")
    self._detail_btnTown2003 = set:getClickNode("detail_btnTown2003")
    self._detail_btnTown2004 = set:getClickNode("detail_btnTown2004")
    self._detail_btnTown2005 = set:getClickNode("detail_btnTown2005")
    self._detail_btnTown2006 = set:getClickNode("detail_btnTown2006")
    self._detail_btnTown2007 = set:getClickNode("detail_btnTown2007")
    self._detail_btnTown2008 = set:getClickNode("detail_btnTown2008")
    self._detail_btnTown2009 = set:getClickNode("detail_btnTown2009")
    self._detail_btnTown2010 = set:getClickNode("detail_btnTown2010")
    self._detail_btnTown2011 = set:getClickNode("detail_btnTown2011")
    self._detail_btnTown2012 = set:getClickNode("detail_btnTown2012")
    self._detail_btnTown2013 = set:getClickNode("detail_btnTown2013")
    self._detail_btnTown2014 = set:getClickNode("detail_btnTown2014")
    self._detail_btnTown2015 = set:getClickNode("detail_btnTown2015")
    self._detail_btnTown2101 = set:getClickNode("detail_btnTown2101")
    self._detail_btnTown2102 = set:getClickNode("detail_btnTown2102")
    self._next = set:getElfNode("next")
    self._role = set:getElfNode("role")
    self._effectLayer2 = set:getElfNode("effectLayer2")
    self._effectLayer2_snowBase1 = set:getElfNode("effectLayer2_snowBase1")
    self._mapBg = set:getLinearLayoutNode("mapBg")
    self._effectLayer = set:getElfNode("effectLayer")
    self._effectLayer_animHualan = set:getElfNode("effectLayer_animHualan")
    self._effectLayer_dy = set:getElfNode("effectLayer_dy")
    self._detail = set:getElfNode("detail")
    self._name = set:getLabelNode("name")
    self._point = set:getElfNode("point")
    self._detail_btnTown1 = set:getClickNode("detail_btnTown1")
    self._detail_btnTown2 = set:getClickNode("detail_btnTown2")
    self._detail_btnTown3 = set:getClickNode("detail_btnTown3")
    self._detail_btnTown4 = set:getClickNode("detail_btnTown4")
    self._detail_btnTown5 = set:getClickNode("detail_btnTown5")
    self._detail_btnTown6 = set:getClickNode("detail_btnTown6")
    self._detail_btnTown7 = set:getClickNode("detail_btnTown7")
    self._detail_btnTown8 = set:getClickNode("detail_btnTown8")
    self._detail_btnTown9 = set:getClickNode("detail_btnTown9")
    self._detail_btnTown10 = set:getClickNode("detail_btnTown10")
    self._detail_btnTown11 = set:getClickNode("detail_btnTown11")
    self._detail_btnTown12 = set:getClickNode("detail_btnTown12")
    self._detail_btnTown1102 = set:getClickNode("detail_btnTown1102")
    self._next = set:getElfNode("next")
    self._role = set:getElfNode("role")
    self._effectLayer2 = set:getElfNode("effectLayer2")
    self._effectLayer2_snowBase1 = set:getElfNode("effectLayer2_snowBase1")
    self._effectLayer2_sandBase1 = set:getElfNode("effectLayer2_sandBase1")
    self._clouds1 = set:getElfNode("clouds1")
    self._clouds1_cloud1 = set:getElfNode("clouds1_cloud1")
    self._clouds1_cloud2 = set:getElfNode("clouds1_cloud2")
    self._clouds1_cloud3 = set:getElfNode("clouds1_cloud3")
    self._clouds1_cloud4 = set:getElfNode("clouds1_cloud4")
    self._clouds1_cloud5 = set:getElfNode("clouds1_cloud5")
    self._clouds1_cloud6 = set:getElfNode("clouds1_cloud6")
    self._clouds2 = set:getElfNode("clouds2")
    self._clouds2_cloud1 = set:getElfNode("clouds2_cloud1")
    self._clouds2_cloud2 = set:getElfNode("clouds2_cloud2")
    self._clouds2_cloud3 = set:getElfNode("clouds2_cloud3")
    self._clouds3 = set:getElfNode("clouds3")
    self._clouds3_cloud1 = set:getElfNode("clouds3_cloud1")
    self._clouds3_cloud2 = set:getElfNode("clouds3_cloud2")
    self._mapBg = set:getLinearLayoutNode("mapBg")
    self._effectLayer = set:getElfNode("effectLayer")
    self._effectLayer_dy = set:getElfNode("effectLayer_dy")
    self._detail = set:getElfNode("detail")
    self._name = set:getLabelNode("name")
    self._point = set:getElfNode("point")
    self._detail_btnTown4001 = set:getClickNode("detail_btnTown4001")
    self._detail_btnTown4002 = set:getClickNode("detail_btnTown4002")
    self._detail_btnTown4003 = set:getClickNode("detail_btnTown4003")
    self._detail_btnTown4004 = set:getClickNode("detail_btnTown4004")
    self._detail_btnTown4005 = set:getClickNode("detail_btnTown4005")
    self._detail_btnTown4006 = set:getClickNode("detail_btnTown4006")
    self._detail_btnTown4007 = set:getClickNode("detail_btnTown4007")
    self._detail_btnTown4008 = set:getClickNode("detail_btnTown4008")
    self._detail_btnTown4009 = set:getClickNode("detail_btnTown4009")
    self._detail_btnTown4010 = set:getClickNode("detail_btnTown4010")
    self._detail_btnTown4011 = set:getClickNode("detail_btnTown4011")
    self._detail_btnTown4012 = set:getClickNode("detail_btnTown4012")
    self._detail_btnTown4013 = set:getClickNode("detail_btnTown4013")
    self._detail_btnTown4101 = set:getClickNode("detail_btnTown4101")
    self._detail_btnTown4102 = set:getClickNode("detail_btnTown4102")
    self._next = set:getElfNode("next")
    self._role = set:getElfNode("role")
    self._effectLayer2 = set:getElfNode("effectLayer2")
    self._effectLayer2_sandBase1 = set:getElfNode("effectLayer2_sandBase1")
    self._effectLayer2_sandBase2 = set:getElfNode("effectLayer2_sandBase2")
    self._effectLayer2_sandBase3 = set:getElfNode("effectLayer2_sandBase3")
    self._mapBg = set:getLinearLayoutNode("mapBg")
    self._effectLayer = set:getElfNode("effectLayer")
    self._effectLayer_dy = set:getElfNode("effectLayer_dy")
    self._detail = set:getElfNode("detail")
    self._name = set:getLabelNode("name")
    self._point = set:getElfNode("point")
    self._detail_btnTown3001 = set:getClickNode("detail_btnTown3001")
    self._detail_btnTown3002 = set:getClickNode("detail_btnTown3002")
    self._detail_btnTown3003 = set:getClickNode("detail_btnTown3003")
    self._detail_btnTown3004 = set:getClickNode("detail_btnTown3004")
    self._detail_btnTown3005 = set:getClickNode("detail_btnTown3005")
    self._detail_btnTown3006 = set:getClickNode("detail_btnTown3006")
    self._detail_btnTown3007 = set:getClickNode("detail_btnTown3007")
    self._detail_btnTown3008 = set:getClickNode("detail_btnTown3008")
    self._detail_btnTown3009 = set:getClickNode("detail_btnTown3009")
    self._detail_btnTown3010 = set:getClickNode("detail_btnTown3010")
    self._detail_btnTown3011 = set:getClickNode("detail_btnTown3011")
    self._detail_btnTown3012 = set:getClickNode("detail_btnTown3012")
    self._detail_btnTown3102 = set:getClickNode("detail_btnTown3102")
    self._detail_btnTown3103 = set:getClickNode("detail_btnTown3103")
    self._star1 = set:getElfNode("star1")
    self._star3 = set:getElfNode("star3")
    self._star2 = set:getElfNode("star2")
    self._next = set:getElfNode("next")
    self._role = set:getElfNode("role")
    self._effectLayer2 = set:getElfNode("effectLayer2")
    self._effectLayer2_sandBase1 = set:getElfNode("effectLayer2_sandBase1")
    self._effectLayer2_snowBase1 = set:getElfNode("effectLayer2_snowBase1")
    self._effectLayer2_snowBase2 = set:getElfNode("effectLayer2_snowBase2")
    self._mapBg = set:getLinearLayoutNode("mapBg")
    self._mapBg_linearlayout_KLS_ditu1 = set:getElfNode("mapBg_linearlayout_KLS_ditu1")
    self._mapBg_linearlayout_KLS_ditu2 = set:getElfNode("mapBg_linearlayout_KLS_ditu2")
    self._mapBg_linearlayout_linearlayout_KLS_ditu4 = set:getElfNode("mapBg_linearlayout_linearlayout_KLS_ditu4")
    self._mapBg_linearlayout_linearlayout_KLS_ditu5 = set:getElfNode("mapBg_linearlayout_linearlayout_KLS_ditu5")
    self._mapBg_linearlayout_KLS_ditu6 = set:getElfNode("mapBg_linearlayout_KLS_ditu6")
    self._mapBg_linearlayout_KLS_ditu7 = set:getElfNode("mapBg_linearlayout_KLS_ditu7")
    self._mapBg_linearlayout_KLS_ditu8 = set:getElfNode("mapBg_linearlayout_KLS_ditu8")
    self._mapBg_linearlayout_KLS_ditu9 = set:getElfNode("mapBg_linearlayout_KLS_ditu9")
    self._mapBg_linearlayout_KLS_ditu3 = set:getElfNode("mapBg_linearlayout_KLS_ditu3")
    self._detail = set:getElfNode("detail")
    self._detail_btnTown6001 = set:getClickNode("detail_btnTown6001")
    self._detail_btnTown6002 = set:getClickNode("detail_btnTown6002")
    self._detail_btnTown6003 = set:getClickNode("detail_btnTown6003")
    self._detail_btnTown6004 = set:getClickNode("detail_btnTown6004")
    self._detail_btnTown6005 = set:getClickNode("detail_btnTown6005")
    self._detail_btnTown6006 = set:getClickNode("detail_btnTown6006")
    self._detail_btnTown6007 = set:getClickNode("detail_btnTown6007")
    self._detail_btnTown6008 = set:getClickNode("detail_btnTown6008")
    self._detail_btnTown6009 = set:getClickNode("detail_btnTown6009")
    self._detail_btnTown6010 = set:getClickNode("detail_btnTown6010")
    self._detail_btnTown6011 = set:getClickNode("detail_btnTown6011")
    self._detail_btnTown6012 = set:getClickNode("detail_btnTown6012")
    self._detail_btnTown6013 = set:getClickNode("detail_btnTown6013")
    self._detail_btnTown6014 = set:getClickNode("detail_btnTown6014")
    self._detail_btnTown6015 = set:getClickNode("detail_btnTown6015")
    self._detail_btnTown6016 = set:getClickNode("detail_btnTown6016")
    self._detail_btnTown6017 = set:getClickNode("detail_btnTown6017")
    self._detail_btnTown6018 = set:getClickNode("detail_btnTown6018")
    self._detail_btnTown6019 = set:getClickNode("detail_btnTown6019")
    self._detail_btnTown6020 = set:getClickNode("detail_btnTown6020")
    self._next = set:getElfNode("next")
    self._role = set:getElfNode("role")
    self._dy = set:getElfNode("dy")
    self._effectLayer = set:getElfNode("effectLayer")
    self._effectLayer2 = set:getElfNode("effectLayer2")
    self._root = set:getElfNode("root")
    self._map_other = set:getElfNode("map_other")
    self._topLeft_bg0 = set:getJoint9Node("topLeft_bg0")
    self._topLeft_layout = set:getLinearLayoutNode("topLeft_layout")
    self._topLeft_layout_text = set:getLabelNode("topLeft_layout_text")
--    self._@hezhong = set:getElfNode("@hezhong")
--    self._@mg5_1 = set:getSimpleAnimateNode("@mg5_1")
--    self._@mg5_2 = set:getSimpleAnimateNode("@mg5_2")
--    self._@haidaochuan = set:getJointAnimateNode("@haidaochuan")
--    self._@jingyu = set:getJointAnimateNode("@jingyu")
--    self._@townNameBg = set:getElfNode("@townNameBg")
--    self._@youling = set:getFlashMainNode("@youling")
--    self._@shenao = set:getElfNode("@shenao")
--    self._@chuan = set:getSimpleAnimateNode("@chuan")
--    self._@hailang2_1 = set:getFlashMainNode("@hailang2_1")
--    self._@hailang2_2 = set:getFlashMainNode("@hailang2_2")
--    self._@hailang2_3 = set:getFlashMainNode("@hailang2_3")
--    self._@hailang2_4 = set:getFlashMainNode("@hailang2_4")
--    self._@hailang2_5 = set:getFlashMainNode("@hailang2_5")
--    self._@hailang2_6 = set:getFlashMainNode("@hailang2_6")
--    self._@hailang2_7 = set:getFlashMainNode("@hailang2_7")
--    self._@hailang2_8 = set:getFlashMainNode("@hailang2_8")
--    self._@hailang2_9 = set:getFlashMainNode("@hailang2_9")
--    self._@mg2_1 = set:getSimpleAnimateNode("@mg2_1")
--    self._@mg2_2 = set:getSimpleAnimateNode("@mg2_2")
--    self._@mg2_3 = set:getSimpleAnimateNode("@mg2_3")
--    self._@mg2_4 = set:getSimpleAnimateNode("@mg2_4")
--    self._@mg2_5 = set:getSimpleAnimateNode("@mg2_5")
--    self._@mg2_6 = set:getSimpleAnimateNode("@mg2_6")
--    self._@mg2_7 = set:getSimpleAnimateNode("@mg2_7")
--    self._@townNameBg = set:getElfNode("@townNameBg")
--    self._@guandu = set:getElfNode("@guandu")
--    self._@chuan = set:getSimpleAnimateNode("@chuan")
--    self._@jingyu = set:getJointAnimateNode("@jingyu")
--    self._@hailang1_1 = set:getFlashMainNode("@hailang1_1")
--    self._@hailang1_2 = set:getFlashMainNode("@hailang1_2")
--    self._@hailang1_3 = set:getFlashMainNode("@hailang1_3")
--    self._@hailang1_4 = set:getFlashMainNode("@hailang1_4")
--    self._@hailang1_5 = set:getFlashMainNode("@hailang1_5")
--    self._@hailang1_6 = set:getFlashMainNode("@hailang1_6")
--    self._@hailang1_7 = set:getFlashMainNode("@hailang1_7")
--    self._@townNameBg = set:getElfNode("@townNameBg")
--    self._@townUnLock = set:getSimpleAnimateNode("@townUnLock")
--    self._@cloudLayer = set:getElfNode("@cloudLayer")
--    self._@fengyuan = set:getElfNode("@fengyuan")
--    self._@jingyu = set:getJointAnimateNode("@jingyu")
--    self._@haidaochuan = set:getJointAnimateNode("@haidaochuan")
--    self._@hailang4_1 = set:getFlashMainNode("@hailang4_1")
--    self._@hailang4_2 = set:getFlashMainNode("@hailang4_2")
--    self._@hailang4_3 = set:getFlashMainNode("@hailang4_3")
--    self._@hailang4_4 = set:getFlashMainNode("@hailang4_4")
--    self._@hailang4_5 = set:getFlashMainNode("@hailang4_5")
--    self._@hailang4_6 = set:getFlashMainNode("@hailang4_6")
--    self._@hailang4_7 = set:getFlashMainNode("@hailang4_7")
--    self._@hailang4_8 = set:getFlashMainNode("@hailang4_8")
--    self._@townNameBg = set:getElfNode("@townNameBg")
--    self._@chengdu = set:getElfNode("@chengdu")
--    self._@zhangyu = set:getJointAnimateNode("@zhangyu")
--    self._@haidaochuan = set:getJointAnimateNode("@haidaochuan")
--    self._@hailang3_1 = set:getFlashMainNode("@hailang3_1")
--    self._@hailang3_2 = set:getFlashMainNode("@hailang3_2")
--    self._@hailang3_3 = set:getFlashMainNode("@hailang3_3")
--    self._@hailang3_4 = set:getFlashMainNode("@hailang3_4")
--    self._@hailang3_5 = set:getFlashMainNode("@hailang3_5")
--    self._@hailang3_6 = set:getFlashMainNode("@hailang3_6")
--    self._@hailang3_7 = set:getFlashMainNode("@hailang3_7")
--    self._@hailang3_8 = set:getFlashMainNode("@hailang3_8")
--    self._@townNameBg = set:getElfNode("@townNameBg")
--    self._@townStar = set:getElfNode("@townStar")
--    self._@kaluosi = set:getElfNode("@kaluosi")
--    self._@areaName = set:getElfNode("@areaName")
--    self._@mapChange = set:getFlashMainNode("@mapChange")
end
--@@@@]]]]

--------------------------------override functions----------------------

local Launcher = require 'Launcher'
Launcher.register("CWorldMap", function ( userData )
	local function doLaunch( ... )
		local unLockManager = require "UnlockManager"
		if userData and userData.PlayBranch ~= nil then
			townFunc.PlayBranchEvent(function ( ... )
				Launcher.Launching()
			end, function ( ... )
				if unLockManager:isUnlock("Elite") then
					Launcher.Launching()
				else
					require 'UIHelper'.toast2(string.format(res.locString("Home$LevelUnLockTip"), unLockManager:getUnlockLv("Elite")))
				end
			end, function ( ... )
				if unLockManager:isUnlock("HeroElite") then
					Launcher.Launching()
				else
					require 'UIHelper'.toast2(string.format(res.locString("Home$LevelUnLockTip"), unLockManager:getUnlockLv("HeroElite")))
				end
			end, userData.PlayBranch)
		else
			Launcher.Launching()
		end
	end
	local document = gameFunc.getTempInfo().getValueForKey("WorldMapDocument")
	if not document then
		local Indicator = require 'DIndicator'
		Indicator.show(0)
		local delayLaunch
		delayLaunch = function ( ... )
			require 'framework.helper.Utils'.delay(function (  )
				if gameFunc.getTempInfo().getValueForKey("WorldMapDocument") then
				 	Indicator.hide()
					doLaunch()
				else
					delayLaunch()
				end
			end, 0.5)
		end
		delayLaunch()

	--	local a = SystemHelper:currentTimeMillis()
		local factory = XMLFactory:getInstance()
		factory:setZipFilePath(config.COCOS_ZIP_DIR.."CWorldMap.cocos.zip")
		document = factory:createDocument("CWorldMap.cocos")
	--	local b = SystemHelper:currentTimeMillis()
	--	print("CWorldMap:createDocument_TIME = " .. tostring(b-a))
		gameFunc.getTempInfo().setValueForKey("WorldMapDocument", document)
		document:retain()
	else
		doLaunch()
	end
end)

function CWorldMap:onInit( userData, netData )
	if userData then
		if userData.PlayBranch ~= nil then
			townFunc.setPlayBranch(userData.PlayBranch)
		end
		if userData and userData.type == "GoToTown" then
			GleeCore:closeAllLayers()
			GleeCore:showLayer("DHomeToolBar", {isAtHome = gameFunc.getTempInfo().getValueForKey("IsAtHome")})

			if userData.townId then
				local townId = userData.townId
				local petId = userData.petId
				local dbTownInfo = dbManager.getInfoTownConfig(townId)
				townFunc.setLastTownId(townId)

				self.areaId = dbTownInfo.AreaId
				self:setWorldEnabled(false)
				self:runWithDelay(function ( ... )
					self:setWorldEnabled(true)
					GleeCore:showLayer("DTown", {townId = townId, PlayBranch = userData.PlayBranch, petId = petId, stageId = userData.stageId})
				end, 0.1)
			end
		end
	end

	self._map:setContentSize(CCDirector:sharedDirector():getWinSize())
	self:updateAp()
	self.areaId = self.areaId or gameFunc.getTempInfo().getAreaId()
	self:switchArea(self.areaId)
end

function CWorldMap:onBack( userData, netData )
	self:updateAp()

	local switchAreaId = gameFunc.getTempInfo().getValueForKey("SwitchAreaId")
	if switchAreaId then
		self:runWithDelay(function (  )
			gameFunc.getTempInfo().setValueForKey("SwitchAreaId", nil)
			self:switchArea(switchAreaId)
		end, res.getTransitionFadeDelta() / 2)	
	else
		self:switchArea(gameFunc.getTempInfo().getLastAreaId(), true)
	end

	if gameFunc.getTempInfo().getValueForKey("TownOpenActionDelay") then
		self.mapNodeSet[string.format("detail_btnTown%d", userFunc.getNextTownId())]:setEnabled(false)
		self.mapNodeSet["next"]:setVisible(false)
	end
end

function CWorldMap:onEnter(  )
--	self:runWithDelay(function (  )
		eventCenter.eventInput("UpdatePoint")
		eventCenter.eventInput("SwitchHomeWorld", {isAtHome = false})
--	end, res.getTransitionFadeDelta() / 2)

	if not gameFunc.getTempInfo().getHomeToolBarVisible() then
		GleeCore:showLayer("DHomeToolBar", {isAtHome = false,delay=res.getTransitionFadeDelta()/2})
	end

	self:broadcastEvent()
	self:setListenerEvent()

	require 'framework.helper.MusicHelper'.playBackgroundMusic(res.Music.world, true)
	self:guideNotify()
end

function CWorldMap:onLeave(  )
	eventCenter.resetGroup("CWorldMap")
	self._map_other:stopAllActions()
end

function CWorldMap:isKeepAlive( ... )
	return false
end

--------------------------------custom code-----------------------------

function CWorldMap:setListenerEvent(  )
	self._btnHideMenu:setTriggleSound("")
	self._btnHideMenu:setListener(function (  )
		eventCenter.eventInput("MenuBarStateHide")
	end)
end

function CWorldMap:broadcastEvent(  )
	eventCenter.addEventFunc("EventLastTownIdUpdate", function (  )
		print("EventLastTownIdUpdate:")
		self:updateRolePosition()
	end, "CWorldMap")

	eventCenter.addEventFunc("MainTaskIdUpdate", function (  )
		print("MainTaskIdUpdate")
		if gameFunc.getTempInfo().getLastAreaId() == gameFunc.getTempInfo().getAreaId() then
			self:runActionTownUnLock(userFunc.getNextTownId())
		else
			-- 开启新区域
			self:showAnimationOpenNewArea(gameFunc.getTempInfo().getAreaId())
		end
		eventCenter.eventInput('UpdateTownsRedPoint')
	end, "CWorldMap")

	eventCenter.addEventFunc("UpdateAp", function ( data )
		print("UpdateAp")
		self:updateAp()
	end, "CWorldMap")

	eventCenter.addEventFunc("TownArrive", function ( data )
		self:TownArriveEvent(data)
	end, "CWorldMap")

	eventCenter.addEventFunc("SwitchPlayBranch", function ( ... )
		print("SwitchPlayBranch")
		local townId = userFunc.getNextTownId()
		local dbTownInfo = dbManager.getInfoTownConfig(townId)
		local changeArea = self.areaId ~= dbTownInfo.AreaId
		self.areaId = dbTownInfo.AreaId
		townFunc.setLastTownId(townId)

		print("self.areaId = " .. self.areaId)
		self:updateAp()
		self:switchArea(self.areaId, changeArea)
		if changeArea then
			eventCenter.eventInput("SwitchArea")
		end
		self:guideNotify()
	end, "CWorldMap")

	eventCenter.addEventFunc("OnAppStatChange", function ( state )
		if state == 2 then
			self:updateAp()
		end
	end, "CWorldMap")

	eventCenter.addEventFunc("UpdateTownsRedPoint", function ( state )
		self:updateTownsRedPoint()
	end, "CWorldMap")
end

function CWorldMap:TownArriveEvent( data )
	print("TownArriveEvent")
	print(data)

	GleeCore:closeAllLayers()
	GleeCore:showLayer("DHomeToolBar", {isAtHome = gameFunc.getTempInfo().getValueForKey("IsAtHome")})


	local PlayBranchChange = false
	if townFunc.getPlayBranch() ~= data.PlayBranch then
		townFunc.setPlayBranch(data.PlayBranch)
		gameFunc.getTownInfo().setLastTownId(nil)
		PlayBranchChange = true
	end

	if data.townId then
		local townId = data.townId
		local petId = data.petId
		local dbTownInfo = dbManager.getInfoTownConfig(townId)
		townFunc.setLastTownId(townId)

		if self.areaId ~= dbTownInfo.AreaId or PlayBranchChange then
			self:switchArea(dbTownInfo.AreaId)
		else
			local x, y = self.mapNodeSet[string.format("detail_btnTown%d", townId)]:getPosition()
			local x1, y1 = self:getAdjustMapPosition(- x, -y)
			self._map:getMoveNode():setPosition(ccp(x1, y1))	
		end
		GleeCore:showLayer("DTown", {townId = townId, PlayBranch = data.PlayBranch, petId = petId, stageId = data.stageId})
	else
		self:switchArea(gameFunc.getTempInfo().getAreaId())
	end
end

function CWorldMap:updateTownsOpenClose( ... )
	local list = dbManager.getInfoTownList( self.areaId )
	local temp = {}
	townFunc.PlayBranchEvent(function ( ... )
		temp = townFunc.getTowns()
	end, function ( ... )
		for i,value in ipairs(townFunc.getTowns()) do
			if value.TownId == userFunc.getData().NextTownIdSenior then
				table.insert(temp, value)
				break
			end
			table.insert(temp, value)
		end
	end, function ( ... )
		for i,value in ipairs(townFunc.getTowns()) do
			if value.TownId == userFunc.getData().NextTownIdHero then
				table.insert(temp, value)
				break
			end
			table.insert(temp, value)
		end
	end)

	for i,v in ipairs(list) do
		local isOpen = false
		for k,value in pairs(temp) do
			if value.TownId == v.Id then
				isOpen = true
				break
			end
		end
		self.mapNodeSet[string.format("detail_btnTown%d", v.Id)]:setEnabled(isOpen)
	end	

	self:updateNextIcon()
	self:updateRolePosition()
end

function CWorldMap:updateTownsRedPoint( ... )
	local list = dbManager.getInfoTownList( self.areaId )
	for i,dbTown in ipairs(list) do
		local redPointVisible = false
		for i2,nTown in ipairs(townFunc.getTowns()) do
			if nTown.TownId == dbTown.Id then
				townFunc.PlayBranchEvent(function ( ... )
					redPointVisible = dbTown.ClearReward > 0 and nTown.Clear and not nTown.RewardGot
				end, function ( ... )
					redPointVisible = dbTown.ClearRewardSenior > 0 and nTown.SeniorClear and not nTown.RewardSeniorGot
				end, function ( ... )
					redPointVisible = dbTown.ClearRewardHero > 0 and nTown.HeroClear and not nTown.RewardHeroGot
				end)
				break
			end
		end
		self.mapNodeSet[string.format("detail_btnTown%d_redPoint", dbTown.Id)]:setVisible(redPointVisible)
	end
end

function CWorldMap:updateArea(  )
	gameFunc.getTempInfo().setLastAreaId(self.areaId)

	local mapNameList = {"@guandu", "@shenao", "@chengdu", "@fengyuan", "@hezhong", "@kaluosi"}
	self.mapNodeSet = self:createLuaSet(mapNameList[self.areaId])
	self._map:getMoveNode():removeAllChildrenWithCleanup(true)
	self._map:getMoveNode():addChild(self.mapNodeSet[1])
	self.mapNodeSet[1]:setVisible(true)
	local mapBgSize = self.mapNodeSet["mapBg"]:getContentSize()
	local mapBgScale = self.mapNodeSet["mapBg"]:getScale()
	self._map:getMoveNode():setContentSize(CCSize(mapBgSize.width * mapBgScale, mapBgSize.height * mapBgScale))
	self._map:onRestrict(nil)

	local townList = dbManager.getInfoTownList( self.areaId )
	for i,v in ipairs(townList) do
		local townId = v.Id
		self.mapNodeSet[string.format("detail_btnTown%d", townId)]:setListener(function (  )
			local cannotGotoTown = false
			townFunc.PlayBranchEvent(nil, function ( ... )
				if userFunc.getNextTownId() == townId and not townFunc.getTownById(townId).SeniorClear then
					if userFunc.getData().NextTownIdSenior == userFunc.getData().NextTownId then
						self:toast(res.locString("Town$SeniorLimitTip"))
						cannotGotoTown = true
					end
				end
			end, function ( ... )
				if userFunc.getNextTownId() == townId and not townFunc.getTownById(townId).HeroClear then
					if userFunc.getData().NextTownIdSenior == userFunc.getData().NextTownIdHero then
						self:toast(res.locString("Town$HeroLimitTip"))
						cannotGotoTown = true
					end
				end
			end)
			if cannotGotoTown then
				return
			end
			local x, y = self.mapNodeSet[string.format("detail_btnTown%d", townId)]:getPosition()
			local x1, y1 = self:getAdjustMapPosition(- x, -y)
			self._map:getMoveNode():runAction(CCMoveTo:create(0.5, ccp(x1, y1)))

			GleeCore:showLayer("DTown", {townId = townId})
		end)

		local townNameBgSet = self:createLuaSet("@townNameBg")

		townFunc.PlayBranchEvent(function ( ... )
			townNameBgSet[1]:setResid("ZY_mingzikuang.png")
		end, function ( ... )
			townNameBgSet[1]:setResid("N_ZC_JY_xk.png")
		end, function ( ... )
			townNameBgSet[1]:setResid("N_hero_FB_kuang_name.png")
		end)

		self.mapNodeSet["detail"]:addChild(townNameBgSet[1])
		townNameBgSet["name"]:setString(v.Name)
		require 'LangAdapter'.fontSize(townNameBgSet["name"], nil, nil, nil, nil, 18)

		townNameBgSet["point"]:setVisible(false)
		self.mapNodeSet[string.format("detail_btnTown%d_redPoint", townId)] = townNameBgSet["point"]
		local ptx, pty = self.mapNodeSet[string.format("detail_btnTown%d", townId)]:getPosition()
		townNameBgSet[1]:setPosition(ccp(ptx, pty - 38 - 14))

		-- star
		local starExist = false
		if townFunc.isPlayBranchNormal() then
			local nTown = townFunc.getTownById(townId)
			if nTown and nTown.Clear and nTown.Stars > 0 then
				local townStarSet = self:createLuaSet("@townStar")
				self.mapNodeSet["detail"]:addChild(townStarSet[1])
				townStarSet[1]:setPosition(ccp(ptx, pty - 3 - 14))
				for i=1,3 do
					townStarSet[string.format("star%d", i)]:setResid(i <= nTown.Stars and "N_XX_07.png" or "N_XX_07_1.png")
				end

				self.townStarList = self.townStarList or {}
				self.townStarList[townId] = townStarSet[1]
				starExist = true
			end
		end
		if starExist == false then
			townNameBgSet[1]:setPosition(ccp(ptx, pty - 38))
		end
	end

	eventCenter.eventInput("SwitchArea")

	self:playAnimationClouds()
	self._map_other:stopAllActions()
	self:runWithDelay(function ( ... )
		self:playAnimations()
	end, 3.0, self._map_other)
end

function CWorldMap:switchArea( areaId, hideAreaName )
	self.areaId = areaId
	self:updateArea()
	self:updateTownsOpenClose()
	self:updateTownsRedPoint()

	local x, y = self.mapNodeSet[string.format("detail_btnTown%d", townFunc.getLastTownId(self.areaId) )]:getPosition()
	self._map:getMoveNode():setPosition(ccp(-x, -y))
	self._map:onRestrict(nil)

	-- 区域名字淡入淡出
	-- if not hideAreaName then
	-- 	local areaNameSet = self:createLuaSet("@areaName")
	-- 	self._map:addChild(areaNameSet[1])
	-- 	areaNameSet[1]:setResid(string.format("N_GK_quyu%d.png", self.areaId))
	-- 	areaNameSet[1]:setOpacity(0)
	-- 	local array = CCArray:create()
	-- 	array:addObject(CCDelayTime:create(1.0))
	-- 	array:addObject(CCFadeIn:create(1.5))
	-- 	array:addObject(CCFadeOut:create(1.5))
	-- 	array:addObject(CCCallFunc:create(function ( )
	-- 		areaNameSet[1]:removeFromParentAndCleanup(true)
	-- 	end))
	-- 	areaNameSet[1]:runAction(CCSequence:create(array))
	-- end

	local nAreaBoxList = townFunc.getAreaBoxList(self.areaId)
	if not(nAreaBoxList and #nAreaBoxList > 0) then
   	self:sendBackground(netModel.getModelAreaGetBox(self.areaId), function ( data )
   		print("AreaGetBox")
   		print(data)
   		townFunc.setAreaBoxList(data.D.Boxes, self.areaId)
   		eventCenter.eventInput("AreaBoxListUpdate")
	 	end)
	end
end

function CWorldMap:updateNextIcon( ... )
	local nextTownId = userFunc.getNextTownId()
	local theArea = gameFunc.getTempInfo().getAreaId()
	townFunc.PlayBranchEvent(function ( ... )
		self.mapNodeSet["next"]:setResid("ZY_next.png")
	end, function ( ... )
		self.mapNodeSet["next"]:setResid("N_ZC_JY_next.png")
	end, function ( ... )
		self.mapNodeSet["next"]:setResid("N_hero_FB_NEXT.png")
	end)

	if self.areaId == theArea then
		self.mapNodeSet["next"]:setVisible(true)
		local x, y = self.mapNodeSet[string.format("detail_btnTown%d", nextTownId)]:getPosition()
		self.mapNodeSet["next"]:setPosition(ccp(x, y + 120))
		self.mapNodeSet["next"]:stopAllActions()
		self.mapNodeSet["next"]:runAction(self:getNextMoveAction(1))

		self._map:getMoveNode():setPosition(ccp(-x, -y))
		self._map:onRestrict(nil)
	else
		self.mapNodeSet["next"]:setVisible(false)
	end
end

function CWorldMap:guideNotify( ... )
	if self.areaId == 1 then
		local townidlist = {1,7}
		for i,townId in ipairs(townidlist) do
			local node = self.mapNodeSet[string.format("detail_btnTown%d", townId)]
				if node then
					GuideHelper:registerPoint(string.format('TownID%d',townId),node)
				end   
		end
		GuideHelper:check(string.format('AreaID%d',self.areaId))
	end
    local nextTownId = userFunc.getNextTownId()
    local node = self.mapNodeSet[string.format("detail_btnTown%d", nextTownId)]
    if node then
        GuideHelper:registerPoint('NextTown',node)
    end
    GuideHelper:check('CWorldMap')
end

function CWorldMap:updateRolePosition( ... )
	local lastTownId = townFunc.getLastTownId(self.areaId)
	if lastTownId then
		local x, y = self.mapNodeSet[string.format("detail_btnTown%d", lastTownId)]:getPosition()
		self.mapNodeSet["role"]:setPosition(ccp(x - 80, y + 20))
		self.mapNodeSet["role"]:setVisible(true)
	else
		self.mapNodeSet["role"]:setVisible(false)
	end
end

function CWorldMap:getNextMoveAction( delta )
	local actArray = CCArray:create()
	actArray:addObject(CCMoveBy:create(delta, ccp(0, 20)))
	actArray:addObject(CCMoveBy:create(delta, ccp(0, -20)))
	return CCRepeatForever:create(CCSequence:create(actArray))
end

function CWorldMap:runActionTownUnLock( townId )
	local actionNode = self.mapNodeSet[string.format("detail_btnTown%d", townId)]
	actionNode:setEnabled(false)

	local x, y = actionNode:getPosition()
	local x1, y1 = self:getAdjustMapPosition(-x, -y)

	local townUnLock = self:createLuaSet("@townUnLock")
	actionNode:addChild(townUnLock[1])
	townUnLock[1]:setVisible(false)

	-- 动画1
	self.mapNodeSet["next"]:setVisible(false)
	self.mapNodeSet["role"]:setVisible(false)
	local array = CCArray:create()
	array:addObject(CCCallFunc:create(function (  )
		self:setWorldEnabled(false)
	end))
	array:addObject(CCMoveTo:create(0.5, ccp(x1, y1)))
	array:addObject(CCCallFunc:create(function ( ... )
		-- 动画2
		local duration = 0.07
		local deltaAngle = 30
		
		local actArray = CCArray:create()
		actArray:addObject(CCRotateBy:create(duration, deltaAngle))
		actArray:addObject(CCRotateBy:create(duration, -deltaAngle * 2))
		actArray:addObject(CCRotateBy:create(duration, deltaAngle))
		actArray:addObject(CCDelayTime:create(0.3))
		actArray:addObject(CCRotateBy:create(duration, deltaAngle))
		actArray:addObject(CCRotateBy:create(duration, -deltaAngle * 2))
		actArray:addObject(CCRotateBy:create(duration, deltaAngle))
		actArray:addObject(CCCallFunc:create(function (  )
			actionNode:setEnabled(true)
			
			townUnLock[1]:setLoops(1)
			townUnLock[1]:setListener(function (  )
				townUnLock[1]:removeFromParentAndCleanup(true)
				townFunc.setLastTownId(townId)
				self:updateTownsOpenClose()

				self.mapNodeSet["next"]:setOpacity(0)
				self.mapNodeSet["next"]:setVisible(true)
				self.mapNodeSet["next"]:runAction(CCFadeIn:create(1.0))
				self.mapNodeSet["role"]:setOpacity(0)
				self.mapNodeSet["role"]:setVisible(true)
				self.mapNodeSet["role"]:runAction(CCFadeIn:create(1.0))
				self:setWorldEnabled(true)
			end)
			townUnLock[1]:start()
		end))
		actionNode:runAction(CCSequence:create(actArray))

		require 'framework.helper.MusicHelper'.playEffect(res.Sound.ui_sfx_unlock)
	end))
	self._map:getMoveNode():runAction(CCSequence:create(array))
end

function CWorldMap:setWorldEnabled( enable )
	eventCenter.eventInput("WorldEnable", {enable = enable})
end

function CWorldMap:getAdjustMapPosition( x, y )
	local x0, y0 = self._map:getMoveNode():getPosition()
	self._map:getMoveNode():setPosition(ccp(x, y))
	self._map:onRestrict(nil)
	local x1, y1 = self._map:getMoveNode():getPosition()
	self._map:getMoveNode():setPosition(ccp(x0, y0))
	return x1, y1
end

function CWorldMap:updateAp(  )
	local levelTable = dbManager.getInfoRoleLevelCap(userFunc.getLevel())
	self._topLeft_layout_text:setString(string.format("%d/%d", userFunc.getAp(), levelTable.apcap))
	self._topLeft_layout:layout()
	self._topLeft_bg0:setContentSize(CCSize(self._topLeft_layout:getContentSize().width + 30, self._topLeft_bg0:getContentSize().height))
end

function CWorldMap:showAnimationOpenNewArea( areaId )
	require 'framework.helper.MusicHelper'.playEffect(res.Sound.ui_newworld)
	
	self:setWorldEnabled(false)
	local mapSwitchSet = self:createLuaSet("@mapChange")
	self:getLayer():addChild(mapSwitchSet[1], 999999)
	local ctrl = mapSwitchSet[1]:getCurrModifierController()
	local fv_role = ctrl:getFullPropertyModifierVectorByTarget(mapSwitchSet["root_#tag-6"])
	fv_role:setKeyResid(string.format("N_GK_quyu%d.png", areaId), 0, 46)
	ctrl:setLoopMode(STAY)
 	ctrl:setLoops(1)
	mapSwitchSet[1]:playWithCallback("swf", function ( ... )
		mapSwitchSet[1]:removeFromParentAndCleanup(true)
		gameFunc.getTownInfo().setLastTownId(userFunc.getNextTownId())
		self:switchArea( gameFunc.getTempInfo().getAreaId() )
		eventCenter.eventInput("SwitchArea")
		self:setWorldEnabled(true)
	end)
end

---------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------- Animations ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

local mapAnimConfig = {
	[1] = {
		{ key = "chuan", pointList = {{4.2856827,-310.0}, {151.42856,-269.99997}, {37.14284,-201.42857}}, pointList2 = {{-261.42853,-198.57141}, {-115.714294,-124.28572}, {-220.0,-148.57143}},},
		{ key = "jingyu", pointList = {{-837.1421,-451.42883}, {-811.4278,-190.00026}, {932.8588,-405.23834}, {936.15924,-15.660522}, {697.5878,350.05377}, {929.96875,274.81564} }},
		{ key = "yun", pointList = {{-1600,185}, {-1970, -350}, {-1470, -350}}, pointList2 = {{1640,218.57141}, {1560, -350}, {1560, -350} } }
	},
	
	[2] = {
		{ key = "chuan", pointList = {{674.2857,-280.0}, {975.71423,-428.57144}}, pointList2 = { {430.95233,-592.381}, {650.0,-598.0953} }},
		{ key = "yun", pointList = {{-1600,185}, {-1970, -350}, {-1470, -350}}, pointList2 = {{1640,218.57141}, {1560, -350}, {1560, -350} } }
	},

	[3] = {
		{ key = "zhangyu", pointList = { {1137.1439,-357.14313}, {352.85825,-328.57172}, {-308.57025,-151.42888} } },
		{ key = "haidaochuan", pointList = { {-86.91751,-434.2857}, {-816.6571,-73.333275}, {1025.2477,-456.19043} } },
		{ key = "yun", pointList = {{-1600,185}, {-1970, -350}, {-1470, -350}}, pointList2 = {{1640,218.57141}, {1560, -350}, {1560, -350} } }
	},

	[4] = {
		{ key = "jingyu", pointList = { {-122.85715,440.00034}, {121.42857,420.00034}, {327.14288,412.85745}, {538.5715,420.00034} } },
		{ key = "haidaochuan", pointList = { {608.1053,-193.33331}, {-78.3656,-370.47617}, {543.0629,265.23807}} },
		{ key = "yun", pointList = {{-1600,185}, {-1970, -350}, {-1470, -350}}, pointList2 = {{1640,218.57141}, {1560, -350}, {1560, -350} } }
	},

	[5] = {
		{ key = "jingyu", pointList = { {316.72946,-438.57156}, {971.4286,355.71417} } },
		{ key = "haidaochuan", pointList = { {-1005.9652,-93.33307}, {-186.89967,-388.59656}, {1073.1003,-58.596603} } },
		{ key = "yun", pointList = {{-1600,185}, {-1970, -350}, {-1470, -350}}, pointList2 = {{1640,218.57141}, {1560, -350}, {1560, -350} } }
	},

	[6] = {
		{ key = "yun", pointList = {{-1600,185}, {-1970, -350}, {-1470, -350}}, pointList2 = {{1640,218.57141}, {1560, -350}, {1560, -350} } }
	},
}

function CWorldMap:getAnimPoint( key )
	local pointList
	local pointList2
	for k,v in pairs(mapAnimConfig[self.areaId]) do
		if v.key == key then
			pointList = v.pointList
			if v.pointList2 then
				pointList2 = v.pointList2
			end
			break
		end
	end
	if key == "yun" then
		return pointList, pointList2
	else
		local temp = pointList[math.random(#pointList)]
		if pointList2 then
			local temp2 = pointList2[math.random(#pointList2)]
			return ccp(temp[1], temp[2]), ccp(temp2[1], temp2[2])
		else
			return ccp(temp[1], temp[2])
		end
	end
	return nil
end

function CWorldMap:playAnimations( ... )
	if self.areaId == 1 then
		self:playAnimationHuaLan()
		self:playAnimationChuan()
		self:playAnimationJingyu()
--		self:playAnimationLongjuanfeng()
		self:playAnimationHailang()
--		self:playAnimationXue()
--		self:playAnimationShazi()		
	elseif self.areaId == 2 then
		self:playAnimationChuan()
--		self:playAnimationYouLing()
		self:playAnimationMogu()
--		self:playAnimationXue()
		self:playAnimationHailang()
	elseif self.areaId == 3 then
		self:playAnimationZhangyu()
		self:playAnimationHaidaoChuan()
--		self:playAnimationYouLing()
		self:playAnimationHailang()
--		self:playAnimationXue()
--		self:playAnimationShazi()
	elseif self.areaId == 4 then
		self:playAnimationJingyu()
		self:playAnimationHaidaoChuan()
		self:playAnimationHailang()
--		self:playAnimationShazi()
	elseif self.areaId == 5 then	
		self:playAnimationMogu()
--		self:playAnimationYouLing()
		self:playAnimationHaidaoChuan()
		self:playAnimationJingyu()
--		self:playAnimationXue()
	end
end

--function CWorldMap:playAnimationYouLing( ... )
	-- local iList = {[2] = 1, [3] = 2, [5] = 3}
	-- local iPos = {[2] = ccp(-449.7974,-111.428635), [3] = ccp(298.7741,169.99991), [5] = ccp(-714.08307,327.1428)}
	-- if iList[self.areaId] then
	-- 	self:runWithDelay(function ( ... )
	-- 		local set = self:createLuaSet("@youling")
	-- 		self.mapNodeSet["effectLayer2"]:addChild(set[1])
	-- 		set[1]:setPosition(iPos[self.areaId])

	-- 		local ctrl = set[1]:getCurrModifierController()
	-- 		ctrl:setLoopMode(STAY)
	--  		ctrl:setLoops(1)
	 		
	-- 		set[1]:playWithCallback(string.format("swf%d", iList[self.areaId]), function ( ... )
	-- 			set[1]:removeFromParentAndCleanup(true)
	-- 			self:playAnimationYouLing()
	-- 		end)
	-- 	end, math.random(10), self._map_other)
	-- end
--end

function CWorldMap:playAnimationHuaLan(  )
	self.mapNodeSet["effectLayer_animHualan"]:stopAllActions()
	self.mapNodeSet["effectLayer_animHualan"]:runAction(res.getFadeAction(1))
end

function CWorldMap:playAnimationZhangyu( ... )
	self:runWithDelay(function ( ... )
		local set = self:createLuaSet("@zhangyu")
		self.mapNodeSet["effectLayer_dy"]:addChild(set[1])
		set[1]:setPosition(self:getAnimPoint("zhangyu"))
		set[1]:setStepLoops(1, 0)
		set[1]:setStepLoops(math.random(3) + 6, 1)
		set[1]:setStepLoops(1, 2)
		set[1]:start()
		set[1]:setLoops(1)
		set[1]:setListener(function ( ... )
			set[1]:removeFromParentAndCleanup(true)
			self:playAnimationZhangyu()
		end)
	end, math.random(5), self._map_other)
end

function CWorldMap:playAnimationHaidaoChuan( ... )
	self:runWithDelay(function ( ... )
		local set = self:createLuaSet("@haidaochuan")
		self.mapNodeSet["effectLayer_dy"]:addChild(set[1])
		set[1]:setPosition(self:getAnimPoint("haidaochuan"))
		set[1]:setStepLoops(1, 0)
		set[1]:setStepLoops(math.random(3) + 6, 1)
		set[1]:setStepLoops(1, 2)
		set[1]:start()
		set[1]:setLoops(1)
		set[1]:setListener(function ( ... )
			set[1]:removeFromParentAndCleanup(true)
			self:playAnimationHaidaoChuan()
		end)
	end, math.random(5), self._map_other)
end

function CWorldMap:playAnimationMogu( ... )
	local list = {}
	if self.areaId == 2 then
		while true do
			local index = math.random(7)
			if #list == 0 then
				table.insert(list, index)
			else
				if index ~= list[1] then
					table.insert(list, index)
				end 
			end
			if #list >= 2 then
				break
			end
		end
	elseif self.areaId == 5 then
		list = {1, 2}
	end
	for i,v in ipairs(list) do
		self:playAnimationMoguSingle(v)
	end
end

function CWorldMap:playAnimationMoguSingle( index )
	self:runWithDelay(function ( ... )
		local set = self:createLuaSet(string.format("@mg%d_%d", self.areaId, index))
		self.mapNodeSet["effectLayer_mogu"]:addChild(set[1])

		set[1]:setLoops(1)
		set[1]:setListener(function ( ... )
			set[1]:setVisible(true)
			set[1]:setResid(set[1]:getResidByIndex(set[1]:getResidArraySize() - 1))
		end)
		set[1]:start()
	end, math.random(10) + 10, self._map_other)
end

function CWorldMap:playAnimationJingyu( ... )
	self:runWithDelay(function ( ... )
		local set = self:createLuaSet("@jingyu")
		self.mapNodeSet["effectLayer_dy"]:addChild(set[1])
		set[1]:setPosition(self:getAnimPoint("jingyu"))
		set[1]:setStepLoops(1, 0)
		set[1]:setStepLoops(math.random(10) + 10, 1)
		set[1]:setStepLoops(1, 2)
		set[1]:start()
		set[1]:setLoops(1)
		set[1]:setListener(function ( ... )
			set[1]:removeFromParentAndCleanup(true)
			self:playAnimationJingyu()
		end)
	end, math.random(30) + 30, self._map_other)
end

function CWorldMap:playAnimationChuan( ... )
	self:runWithDelay(function ( ... )
		local set = self:createLuaSet("@chuan")
		self.mapNodeSet["effectLayer_dy"]:addChild(set[1])
		local pt1, pt2 = self:getAnimPoint("chuan")
		set[1]:setPosition(pt1)

		local getArray
		local count = 1
		getArray = function ( ... )
			local actArray = CCArray:create()
			actArray:addObject(CCDelayTime:create(math.random(10)))
			actArray:addObject(CCCallFunc:create(function ( ... )
				set[1]:setFlipX(count % 2 == 0)
			end))
			actArray:addObject(CCMoveTo:create(10.0, pt2))
			actArray:addObject(CCCallFunc:create(function ( ... )
				count = count + 1
				if count % 2 == 0 then
					pt2, pt1 = self:getAnimPoint("chuan")
				else
					pt1, pt2 = self:getAnimPoint("chuan")
				end
				set[1]:stopAllActions()
				set[1]:runAction(CCSequence:create(getArray()))
			end))
			return actArray
		end
		
		set[1]:runAction(CCSequence:create(getArray()))
	end, math.random(5), self._map_other)
end

--function CWorldMap:playAnimationLongjuanfeng( ... )
	-- self:runWithDelay(function ( ... )
	-- 	local set = self:createLuaSet("@longjuanfeng")
	-- 	self.mapNodeSet["effectLayer_dy"]:addChild(set[1])

	-- 	local ctrl = set[1]:getCurrModifierController()
	-- 	ctrl:setLoopMode(STAY)
 -- 		ctrl:setLoops(1)
 		
	-- 	set[1]:playWithCallback(string.format("swf%d", math.random(5)), function ( ... )
	-- 		set[1]:removeFromParentAndCleanup(true)
	-- 		self:playAnimationLongjuanfeng()
	-- 	end)
	-- end, math.random(10), self._map_other)
--end

function CWorldMap:playAnimationHailangSingle( index )
	self:runWithDelay(function ( ... )
		local set = self:createLuaSet(string.format("@hailang%d_%d", self.areaId, index))
		self.mapNodeSet["effectLayer_dy"]:addChild(set[1])

		local ctrl = set[1]:getCurrModifierController()
		ctrl:setLoopMode(STAY)
 		ctrl:setLoops(1)
 		set[1]:setTransitionMills(0)
 		
		set[1]:playWithCallback("swf", function ( ... )
			set[1]:removeFromParentAndCleanup(true)
			self:playAnimationHailangSingle(index)
		end)
	end, math.random(10), self._map_other)
end

function CWorldMap:playAnimationHailang( ... )
	local iList = {7, 9, 8, 8, 0}
	for i=1,iList[self.areaId] do
		self:playAnimationHailangSingle(i)
	end
end

--function CWorldMap:playAnimationXue( ... )
	-- local iList = {1, 1, 2, 0, 3}
	-- for i=1,iList[self.areaId] do
	-- 	local set = self:createLuaSet("@feixue")
	-- 	self.mapNodeSet[string.format("effectLayer2_snowBase%d", i)]:addChild(set[1])

	-- 	local ctrl = set[1]:getCurrModifierController()
	-- 	ctrl:setLoopMode(LOOP)
	-- 	ctrl:setLoops(9999999)
	-- 	set[1]:play("swf")
	-- end
--end

--function CWorldMap:playAnimationShazi( ... )
	-- local iList = {1, 0, 1, 3, 0}
	-- for i=1,iList[self.areaId] do
	-- 	local set = self:createLuaSet("@feisha")
	-- 	self.mapNodeSet[string.format("effectLayer2_sandBase%d", i)]:addChild(set[1])

	-- 	local ctrl = set[1]:getCurrModifierController()
	-- 	ctrl:setLoopMode(LOOP)
	-- 	ctrl:setLoops(9999999)
	-- 	set[1]:play("swf")
	-- end
--end

function CWorldMap:playAnimationClouds( ... )
	local set = self:createLuaSet("@cloudLayer")
	self.mapNodeSet[1]:addChild(set[1])

	local pointList, pointList2 = self:getAnimPoint("yun")

	local delay = 64 * 3
	set["clouds1"]:stopAllActions()
	set["clouds1"]:setVisible(false)
	local actArray1 = CCArray:create()
	actArray1:addObject(CCPlace:create(ccp(pointList[1][1], pointList[1][2])))
	actArray1:addObject(CCShow:create())
	actArray1:addObject(CCMoveTo:create(delay, ccp(pointList2[1][1], pointList2[1][2])))
	actArray1:addObject(CCHide:create())
	actArray1:addObject(CCDelayTime:create(delay / 4))
	set["clouds1"]:runAction(CCRepeatForever:create(CCSequence:create(actArray1)))

	delay = 50 * 3
	set["clouds2"]:stopAllActions()
	set["clouds2"]:setVisible(false)
	local actArray2 = CCArray:create()
	actArray2:addObject(CCPlace:create(ccp(pointList[2][1], pointList[2][2])))
	actArray2:addObject(CCShow:create())
	actArray2:addObject(CCMoveTo:create(delay, ccp(pointList2[2][1], pointList2[2][2])))
	actArray2:addObject(CCHide:create())
	actArray2:addObject(CCDelayTime:create(delay / 4))
	set["clouds2"]:runAction(CCRepeatForever:create(CCSequence:create(actArray2)))

	delay = 80 * 3
	set["clouds3"]:stopAllActions()
	set["clouds3"]:setVisible(false)
	local actArray3 = CCArray:create()
	actArray3:addObject(CCPlace:create(ccp(pointList[3][1], pointList[3][2])))
	actArray3:addObject(CCShow:create())
	actArray3:addObject(CCMoveTo:create(delay, ccp(pointList2[3][1], pointList2[3][2])))
	actArray3:addObject(CCHide:create())
	actArray3:addObject(CCDelayTime:create(delay / 4))
	set["clouds3"]:runAction(CCRepeatForever:create(CCSequence:create(actArray3)))
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(CWorldMap, "CWorldMap")


--------------------------------register--------------------------------
GleeCore:registerLuaController("CWorldMap", CWorldMap)


