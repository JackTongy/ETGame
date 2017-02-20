local Config = require "Config"
local eventCenter = require 'EventCenter'
local netModel = require "netModel"
local res = require "Res"
local dbManager = require "DBManager"
local gameFunc = require "AppData"
local GuideHelper = require 'GuideHelper'
local unLockManager = require "UnlockManager"
local AccountHelper = require 'AccountHelper'
local townFunc = gameFunc.getTownInfo()

local userFunc = gameFunc.getUserInfo()
local broadCastFunc = gameFunc.getBroadCastInfo()

local DHomeToolBar = class(LuaMenu)

function DHomeToolBar:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DHomeToolBar.cocos.zip")
    return self._factory:createDocument("DHomeToolBar.cocos")
end

--@@@@[[[[
function DHomeToolBar:onInitXML()
    local set = self._set
   self._mainLayer = set:getElfNode("mainLayer")
   self._mainLayer_btnPlayBranch = set:getClickNode("mainLayer_btnPlayBranch")
   self._mainLayer_btnPlayBranch_normal_text = set:getLabelNode("mainLayer_btnPlayBranch_normal_text")
   self._mainLayer_btnPlayBranch_pressed_text = set:getLabelNode("mainLayer_btnPlayBranch_pressed_text")
   self._mainLayer_btnPlayBranch_invalid_text = set:getLabelNode("mainLayer_btnPlayBranch_invalid_text")
   self._mainLayer_btnRechargeFirst = set:getClickNode("mainLayer_btnRechargeFirst")
   self._mainLayer_btnRechargeFirst_point = set:getElfNode("mainLayer_btnRechargeFirst_point")
   self._mainLayer_btnReward = set:getClickNode("mainLayer_btnReward")
   self._mainLayer_btnReward_point = set:getElfNode("mainLayer_btnReward_point")
   self._mainLayer_btnSignIn = set:getClickNode("mainLayer_btnSignIn")
   self._mainLayer_btnSignIn_point = set:getElfNode("mainLayer_btnSignIn_point")
   self._mainLayer_btnActivity = set:getClickNode("mainLayer_btnActivity")
   self._mainLayer_btnActivity_point = set:getElfNode("mainLayer_btnActivity_point")
   self._mainLayer_btnRecharge = set:getClickNode("mainLayer_btnRecharge")
   self._mainLayer_btnRecharge_point = set:getElfNode("mainLayer_btnRecharge_point")
   self._mainLayer_btnTask = set:getClickNode("mainLayer_btnTask")
   self._mainLayer_btnTask_point = set:getElfNode("mainLayer_btnTask_point")
   self._mainLayer_btnNotice = set:getClickNode("mainLayer_btnNotice")
   self._mainLayer_btnNotice_point = set:getElfNode("mainLayer_btnNotice_point")
   self._mainLayer_btnLayout = set:getLinearLayoutNode("mainLayer_btnLayout")
   self._point = set:getElfNode("point")
   self._point = set:getElfNode("point")
   self._point = set:getElfNode("point")
   self._point = set:getElfNode("point")
   self._point = set:getElfNode("point")
   self._timer = set:getTimeNode("timer")
   self._name = set:getLabelNode("name")
   self._hatchTip = set:getLabelNode("hatchTip")
   self._mainLayer_btnBestBoss = set:getClickNode("mainLayer_btnBestBoss")
   self._mainLayer_btnBar = set:getElfNode("mainLayer_btnBar")
   self._mainLayer_btnBar_christmas1 = set:getElfNode("mainLayer_btnBar_christmas1")
   self._mainLayer_btnBar_layout = set:getLayoutNode("mainLayer_btnBar_layout")
   self._mainLayer_btnBar_layout_btnTeam = set:getClickNode("mainLayer_btnBar_layout_btnTeam")
   self._mainLayer_btnBar_layout_btnTeam_point = set:getElfNode("mainLayer_btnBar_layout_btnTeam_point")
   self._mainLayer_btnBar_layout_btnPet = set:getClickNode("mainLayer_btnBar_layout_btnPet")
   self._mainLayer_btnBar_layout_btnPet_point = set:getElfNode("mainLayer_btnBar_layout_btnPet_point")
   self._mainLayer_btnBar_layout_btnBag = set:getClickNode("mainLayer_btnBar_layout_btnBag")
   self._mainLayer_btnBar_layout_btnBag_point = set:getElfNode("mainLayer_btnBar_layout_btnBag_point")
   self._mainLayer_btnBar_layout_btnMail = set:getClickNode("mainLayer_btnBar_layout_btnMail")
   self._mainLayer_btnBar_layout_btnMail_point = set:getElfNode("mainLayer_btnBar_layout_btnMail_point")
   self._mainLayer_btnBar_layout_btnFriend = set:getClickNode("mainLayer_btnBar_layout_btnFriend")
   self._mainLayer_btnBar_layout_btnFriend_point = set:getElfNode("mainLayer_btnBar_layout_btnFriend_point")
   self._mainLayer_btnBar_layout_btnHandBook = set:getClickNode("mainLayer_btnBar_layout_btnHandBook")
   self._mainLayer_christmas2 = set:getElfNode("mainLayer_christmas2")
   self._mainLayer_btnSwitchMenu = set:getClickNode("mainLayer_btnSwitchMenu")
   self._mainLayer_btnSwitchMenu_point = set:getElfNode("mainLayer_btnSwitchMenu_point")
   self._mainLayer_christmas0 = set:getElfNode("mainLayer_christmas0")
   self._mainLayer_btnPetTicket = set:getClickNode("mainLayer_btnPetTicket")
   self._mainLayer_btnPetTicket_count = set:getLabelNode("mainLayer_btnPetTicket_count")
   self._mainLayer_btnAreaReward = set:getButtonNode("mainLayer_btnAreaReward")
   self._mainLayer_btnAreaReward_icon = set:getElfNode("mainLayer_btnAreaReward_icon")
   self._mainLayer_btnAreaReward_animation = set:getSimpleAnimateNode("mainLayer_btnAreaReward_animation")
   self._mainLayer_btnSwitchArea = set:getClickNode("mainLayer_btnSwitchArea")
   self._mainLayer_btnSwitchArea_normal_text = set:getLabelNode("mainLayer_btnSwitchArea_normal_text")
   self._mainLayer_btnSwitchArea_pressed_text = set:getLabelNode("mainLayer_btnSwitchArea_pressed_text")
   self._mainLayer_btnSwitchArea_invalid_text = set:getLabelNode("mainLayer_btnSwitchArea_invalid_text")
   self._mainLayer_btnFacebook = set:getClickNode("mainLayer_btnFacebook")
   self._mainLayer_ServerTime = set:getLabelNode("mainLayer_ServerTime")
   self._mainLayer_btnWorld = set:getClickNode("mainLayer_btnWorld")
   self._mainLayer_christmas1 = set:getElfNode("mainLayer_christmas1")
   self._mainLayer_btnHome = set:getClickNode("mainLayer_btnHome")
   self._mainLayer_btnHome_normal_layout = set:getLinearLayoutNode("mainLayer_btnHome_normal_layout")
   self._mainLayer_btnHome_pressed_layout = set:getLinearLayoutNode("mainLayer_btnHome_pressed_layout")
   self._mainLayer_btnHome_invalid_layout = set:getLinearLayoutNode("mainLayer_btnHome_invalid_layout")
   self._mainLayer_btnAd = set:getClickNode("mainLayer_btnAd")
   self._mainLayer_btnAd_normal_addcolor = set:getAddColorNode("mainLayer_btnAd_normal_addcolor")
   self._mainLayer_btnAd_pressed_elf = set:getElfNode("mainLayer_btnAd_pressed_elf")
   self._mainLayer_btnChat = set:getClickNode("mainLayer_btnChat")
   self._mainLayer_btnChat_normal_christmas = set:getElfNode("mainLayer_btnChat_normal_christmas")
   self._mainLayer_btnChat_pressed_christmas = set:getElfNode("mainLayer_btnChat_pressed_christmas")
   self._mainLayer_btnChat_point = set:getElfNode("mainLayer_btnChat_point")
   self._shield = set:getShieldNode("shield")
--   self._<FULL_NAME1> = set:getClickNode("@btnRedPaper")
--   self._<FULL_NAME1> = set:getClickNode("@btnGoodback")
--   self._<FULL_NAME1> = set:getClickNode("@btnRebate")
--   self._<FULL_NAME1> = set:getClickNode("@btnSeniorSevenDay")
--   self._<FULL_NAME1> = set:getClickNode("@btnEgg")
--   self._<FULL_NAME1> = set:getClickNode("@btnBind")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DHomeToolBar:onInit( userData, netData )
	self._mainLayer_btnChat_normal_christmas:setPosition(ccp(0,0))
	self._mainLayer_btnChat_pressed_christmas:setPosition(ccp(0,0))

	self._shield:setVisible(false)
	gameFunc.getTempInfo().setHomeToolBarVisible(true)
	gameFunc.getTempInfo().setValueForKey("IsAtHome", userData.isAtHome)
	self:setListenerEvent()
	self:broadcastEvent()
	self:updateMenuBarState(gameFunc.getTempInfo().getHomeMenuStatus())
	self:updateLayerState()
	self:updatePoint()

	GuideHelper:registerPoint('世界地图',self._mainLayer_btnWorld)
	GuideHelper:registerPoint('主城',self._mainLayer_btnHome)
	
	local delay = userData.delay
	if delay then
		self._mainLayer:setVisible(false)
		self:runWithDelay(function ( ... )
			self._mainLayer:setVisible(true)
		end,delay)
	end

	if not require 'AccountHelper'.isItemOFF('Spring') then
		require 'ParticleHelper'.addFlowerParticles( self._mainLayer )
	end
end

function DHomeToolBar:onBack( userData, netData )
	print("DHomeToolBar:onBack")
	self:updateMenuBarState(gameFunc.getTempInfo().getHomeMenuStatus())
	self:updateLayerState()
	self:updatePoint()
end

function DHomeToolBar:close(  )
	gameFunc.getTempInfo().setHomeToolBarVisible(false)
	eventCenter.resetGroup("DHomeToolBar")
	CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(self.tickMap)
	self.tickMap = nil
end

--------------------------------custom code-----------------------------

function DHomeToolBar:setListenerEvent(  )
	local ActivityType = require "ActivityType"
	local btnTable = {
		{ ["node"] = self._mainLayer_btnChat, ["nextController"] = "DChat" },
		{ ["node"] = self._mainLayer_btnRechargeFirst, ["nextController"] = "DRechargeFT" },
		{ ["node"] = self._mainLayer_btnReward, ["nextController"] = "DSevenDayReward" },
		{ ["node"] = self._mainLayer_btnSignIn, ["nextController"] = "DSignInReward" },
		{ ["node"] = self._mainLayer_btnActivity, ["nextController"] = "DActivity"},
		{ ["node"] = self._mainLayer_btnRecharge, ["nextController"] = "DRecharge" },
		{ ["node"] = self._mainLayer_btnBar_layout_btnTeam, ["nextController"] = "CTeam" },
		{ ["node"] = self._mainLayer_btnBar_layout_btnPet, ["nextController"] = "DPetList" },
		{ ["node"] = self._mainLayer_btnBar_layout_btnBag, ["nextController"] = "DBagWithList" },
		{ ["node"] = self._mainLayer_btnTask, ["nextController"] = "DTask" },
		{ ["node"] = self._mainLayer_btnBar_layout_btnMail, ["nextController"] = "DMail"},
		{ ["node"] = self._mainLayer_btnBar_layout_btnFriend, ["nextController"] = "DFriend"},
		{ ["node"] = self._mainLayer_btnBar_layout_btnHandBook, ["nextController"] = "DHandBook" },
		{ ["node"] = self._mainLayer_btnNotice, ["nextController"] = "DNotice" },
	}
	
	local BIRecrods = {DBag=true,DActivity=true,CTeam=true} --add by te
	for k,v in pairs(btnTable) do
		v.node:setListener(function ( ... )
			if v.nextController ~= "" then
				if string.find(v.nextController,"^C") then
					eventCenter.eventInput("HomeToolBarHide")
					GleeCore:pushController(v.nextController, v.data, nil, res.getTransitionFade())
				elseif string.find(v.nextController,"^D") then
					GleeCore:showLayer(v.nextController,v.data)
				end

				if BIRecrods[v.nextController] then
					require 'BIHelper'.record('HomeToolBar',v.nextController)
				end
				if v.nextController == "DRechargeFT" then
					gameFunc.getTempInfo().setValueForKey("RedPointRewardFirst", false)
					self:updatePoint()
				end
			else
				self:toast(res.locString("Home$NotOpenTip"))
			end
		end)
	end

	self._mainLayer_btnSwitchMenu:setListener(function (  )
		self:runMenuBarState(true)
	end)

	self._mainLayer_btnWorld:setListener(function (  )
		GleeCore:pushController("CWorldMap")
		self._shield:setVisible(false)
	end)

	self._mainLayer_btnHome_normal_layout:layout()
	self._mainLayer_btnHome:setContentSize(self._mainLayer_btnHome_normal_layout:getContentSize())
	self._mainLayer_btnHome:setListener(function (  )
		gameFunc.getTownInfo().setLastTownId(nil)
		GleeCore:popController()
		self._shield:setVisible(false)
	end)

	self._mainLayer_btnSwitchArea:setListener(function (  )
		eventCenter.eventInput("HomeToolBarHide")
		GleeCore:pushController("CSwitchArea", {areaId = gameFunc.getTempInfo().getLastAreaId()}, nil, res.getTransitionFade())
	end)

	-- self._mainLayer_btnDifficult1:setListener(function ( ... )
	-- 	gameFunc.getTempInfo().setValueForKey("isSenior", false)
	-- 	self._mainLayer_btnDifficult1:setVisible(false)
	-- 	self._mainLayer_btnDifficult2:setVisible(true)
	-- 	require "EventCenter".eventInput("SwitchPlayBranch")
	-- end)

	-- self._mainLayer_btnDifficult2:setListener(function ( ... )
	-- 	if unLockManager:isUnlock("Elite") then
	-- 		gameFunc.getTempInfo().setValueForKey("isSenior", true)
	-- 		self._mainLayer_btnDifficult1:setVisible(true)
	-- 		self._mainLayer_btnDifficult2:setVisible(false)
	-- 		require "EventCenter".eventInput("SwitchPlayBranch")
	-- 		GuideHelper:check('EliteMode')
	-- 	else
	-- 		self:toast(string.format(res.locString("Home$LevelUnLockTip"), unLockManager:getUnlockLv("Elite")))
	-- 	end
	-- end)

	self._mainLayer_btnPlayBranch:setListener(function ( ... )
		GleeCore:showLayer("DPlayBranch")
	end)

	self._mainLayer_btnBestBoss:setListener(function ( ... )
		GleeCore:showLayer("DPetKill")
	end)

	self._mainLayer_btnPetTicket:setListener(function ( ... )
		if unLockManager:isUnlock("BattleSpeed") then
			GleeCore:showLayer("DPetTicket")
		else
			self:toast(string.format(res.locString("Dungeon$PetTicketUnLockTip"), unLockManager:getUnlockLv("BattleSpeed")))
		end
	end)

	self._mainLayer_btnAreaReward:setListener(function ( ... )
		GleeCore:showLayer("DAreaReward", {areaId = gameFunc.getTempInfo().getLastAreaId()})
	end)

	self._mainLayer_btnFacebook:setListener(function ( ... )
		self:toast("点击了FACEBOOK")
	end)

	local timerHelper = require "framework.sync.TimerHelper"
	self.tickMap = timerHelper.tick(function ( dt )
		local timeZone = userFunc.getTimeZone()
		if timeZone then
			local date = require "TimeManager".getCurrentSeverDate()
			local strTime = ""
			if timeZone.state == "+" then
				strTime = string.format("(UTC+%02d:%02d) %02d-%02d %02d:%02d", timeZone.hour, timeZone.min, date.month, date.day, date.hour, date.min)
			elseif timeZone.state == "" then
				strTime = string.format("(UTC) %02d-%02d %02d:%02d", date.month, date.day, date.hour, date.min)
			elseif timeZone.state == "-" then
				strTime = string.format("(UTC-%02d:%02d) %02d-%02d %02d:%02d", timeZone.hour, timeZone.min, date.month, date.day, date.hour, date.min)
			end
			self._mainLayer_ServerTime:setString(strTime)
		end
	end)
end

function DHomeToolBar:broadcastEvent(  )
	local pointList = {
		"EventFriendInvite",
		"EventFriendReceiveAP",
		"EventFriendVerify",
		"EventLetterSystem",
		"EventLetterFriend",
		"EventTaskReward",
		"EventDailyTask",
		"EventSignVerify",
		"SevenDayReward",
		"EventSevenDays",
		"EventActivity",
		"EventFirstRecharge",
		"UpdatePoint",
		"EventBossDown",
		"EventBossDownPlay",
		"EventTaskMain",
		"EventPetPiece",
		"EventLuxurySign",
	}
	for k,v in pairs(pointList) do
		eventCenter.addEventFunc(v, function ( data )
			print(v)
			print(data)
			if v == "EventBossDown" then
				userFunc.setBossDownPlay(true)
			elseif v == "EventBossDownPlay" then
				userFunc.setBossDownPlay(false)
			end
			self:updatePoint()
		end, "DHomeToolBar")
	end

	eventCenter.addEventFunc("RoleGetFcReward", function ( ... )
		self:updateLayerState()
	end, "DHomeToolBar")

	eventCenter.addEventFunc("EventOpenStageS", function ( ... )
		self:updateLayerState()
	end, "DHomeToolBar")

	eventCenter.addEventFunc("MenuBarStateHide", function ( ... )
		self:runMenuBarState(false)
	end, "DHomeToolBar")

	eventCenter.addEventFunc("MenuBarStateShow", function ( ... )
		print('MenuBarStateShow hanle')
		self:runMenuBarState(true)
	end, "DHomeToolBar")

	eventCenter.addEventFunc("HomeToolBarHide", function ( ... )
		self:runWithDelay(function (  )
			self:close()
		end, res.getTransitionFadeDelta() / 10)
	end, "DHomeToolBar")

	eventCenter.addEventFunc("SwitchHomeWorld", function ( data )
		gameFunc.getTempInfo().setValueForKey("IsAtHome", data.isAtHome)
		self:updateLayerState()
	end, "DHomeToolBar")

	eventCenter.addEventFunc("SwitchArea", function ( data )
		self:updateLayerState()
	end, "DHomeToolBar")

	eventCenter.addEventFunc("WorldEnable", function ( data )
		self._shield:setVisible(not data.enable)
	end, "DHomeToolBar")

	eventCenter.addEventFunc('EventQs',function ( data )
		self:updateLayerState()
	end,'DHomeToolBar')

	eventCenter.addEventFunc("UpdateVipLevel", function (  )
		self:updatePoint()
		self:updatePetTicket()
	end, "DHomeToolBar")

	eventCenter.addEventFunc("UpdateVipBuyRecord", function (  )
		self:updatePoint()
	end, "DHomeToolBar")

	eventCenter.addEventFunc("UpdatePetEgg",function ( data )
		self:updateLayerState()
	end,'DHomeToolBar')

	eventCenter.addEventFunc("AreaBoxListUpdate", function ( data )
		self:updatePoint()
		self:updateLayerState()
	end,'DHomeToolBar')

	eventCenter.addEventFunc("UpdatePetTicket",function ( data )
		self:updatePetTicket()
	end,'DHomeToolBar')

	eventCenter.addEventFunc("UpdateSevenDayReward",function ( data )
		self:updateLayerState()
	end,'DHomeToolBar')

	eventCenter.addEventFunc("UpdateSeniorSevenDay",function ( data )
		self:updateLayerState()
	end,'DHomeToolBar')

	eventCenter.addEventFunc("EventCZ",function ( data )
		self:updateLayerState()
	end,'DHomeToolBar')

	eventCenter.addEventFunc("EventHK",function ( data )
		self:updateLayerState()
	end,'DHomeToolBar')

	eventCenter.addEventFunc("UpdateMaterial",function ( data )
		self:updatePoint()
	end,'DHomeToolBar')

	eventCenter.addEventFunc("NewBroadcastChatGet", function ( data )
		print("NewBroadcastChatGet----")
		print(data)
		if data and data.ShareType == 4 then
			local redPaperData = gameFunc.getActivityInfo().getDataByType(16)
			if redPaperData and math.floor(require "TimeListManager".getTimeUpToNow(redPaperData.CloseAt)) < 0 then

			else
				self:send(netModel.getModelActivityGetList(), function ( data )
					print("ActivityGetList")
					print(data)
					if data and data.D then
						gameFunc.getActivityInfo().setData(data.D.Acs)
						self:updateLayerState()
					end
				end)		
			end
		end
	end, "DHomeToolBar")
end

function DHomeToolBar:updateMenuBarState( visible )
	self._mainLayer_btnSwitchMenu:setVisible(not visible)
	if visible then
		self._mainLayer_btnBar:setPosition(ccp(0, -26))
	else
		self._mainLayer_btnBar:setPosition(ccp(0, -self._mainLayer_btnBar:getContentSize().height - 50))
	end
	gameFunc.getTempInfo().setHomeMenuStatus(visible)
end

function DHomeToolBar:runMenuBarState( visible )
	if self.isRunning then
		self:guideNotify()
		do return end
	end
	self.isRunning = true

	gameFunc.getTempInfo().setHomeMenuStatus(visible)
	self._mainLayer_btnBar:stopAllActions()
	if visible then
		self._mainLayer_btnSwitchMenu:setVisible(false)

		local actions = CCArray:create()
		local moveIn = ElfInterAction:create(CCMoveTo:create(0.5, ccp(0, -26)), InterHelper.EaseBackOut)
		local cb = CCCallFunc:create(function ( ... )
			self:guideNotify()
			self.isRunning = false
		end)
		actions:addObject(moveIn)
		actions:addObject(cb)
		self._mainLayer_btnBar:runAction(CCSequence:create(actions))
	else
		local moveOut = CCArray:create()
		moveOut:addObject(ElfInterAction:create(CCMoveTo:create(0.5, ccp(0, -self._mainLayer_btnBar:getContentSize().height - 50)), InterHelper.EaseBackIn))
		moveOut:addObject(CCCallFunc:create(function (  )
			self._mainLayer_btnSwitchMenu:setVisible(true)
			self.isRunning = false
		end))
		self._mainLayer_btnBar:runAction(CCSequence:create(moveOut))
	end
end

function DHomeToolBar:guideNotify( ... )
	GuideHelper:registerPoint('世界地图',self._mainLayer_btnWorld)
	GuideHelper:registerPoint('主城',self._mainLayer_btnHome)
	GuideHelper:registerPoint('队伍',self._mainLayer_btnBar_layout_btnTeam)
	GuideHelper:registerPoint('任务',self._mainLayer_btnTask)
	GuideHelper:registerPoint('好友',self._mainLayer_btnBar_layout_btnFriend)
	GuideHelper:registerPoint('背包',self._mainLayer_btnBar_layout_btnBag)
	GuideHelper:registerPoint('聊天',self._mainLayer_btnChat)
	GuideHelper:registerPoint('副本选择',self._mainLayer_btnPlayBranch)
	GuideHelper:registerPoint('充值',self._mainLayer_btnRecharge)
	GuideHelper:check('DHomeToolBar')
end

function DHomeToolBar:updatePoint(  )
	if userFunc and userFunc.isValid() then
		local levelCapTable = dbManager.getInfoRoleLevelCap(userFunc.getLevel())
		local friendsFunc = gameFunc.getFriendsInfo()
		self._mainLayer_btnBar_layout_btnFriend_point:setVisible(broadCastFunc.get("friend_invite") or broadCastFunc.get("friend_receiveAP") or (broadCastFunc.get("friend_verify") and (#friendsFunc.getFriendList() < levelCapTable.friendcap)))
	end
	self._mainLayer_btnRechargeFirst_point:setVisible(self:isRedPointRewardFirst())
	self._mainLayer_btnBar_layout_btnTeam_point:setVisible(self:isTeamRedPoint())
	self._mainLayer_btnBar_layout_btnMail_point:setVisible(broadCastFunc.get("letter_sys") or broadCastFunc.get("letter_friend"))
	self._mainLayer_btnTask_point:setVisible(broadCastFunc.get("task_reward") or broadCastFunc.get('daily_task') or broadCastFunc.get('task_main'))
	self._mainLayer_btnSignIn_point:setVisible(broadCastFunc.get("sign_verify") or broadCastFunc.get("luxury_sign"))
	self._mainLayer_btnReward_point:setVisible(broadCastFunc.get("seven_days"))
	self._mainLayer_btnActivity_point:setVisible(broadCastFunc.getActivity() or self:isRedPointActivity())
	self._mainLayer_btnBar_layout_btnPet_point:setVisible(broadCastFunc.get("pet_piece"))
	self._mainLayer_btnBar_layout_btnBag_point:setVisible(self:isRedPointBag())
	self._mainLayer_btnNotice_point:setVisible(false)

	local record = require "ItemMallInfo".getBuyRecord()
	local hasBuyCount = record and record.Vips and #record.Vips or 0
	self._mainLayer_btnRecharge_point:setVisible(userFunc.getVipLevel() >= hasBuyCount)

	self._mainLayer_btnBestBoss:setVisible(userFunc.getBossDownPlay())

	self:updateRechargeFirstPosition()

	if self:isAreaRewardRedPoint() then
		self._mainLayer_btnAreaReward_icon:setVisible(false)
		self._mainLayer_btnAreaReward_animation:setVisible(true)
	else
		self._mainLayer_btnAreaReward_icon:setVisible(true)
		self._mainLayer_btnAreaReward_animation:setVisible(false)
	end

	self._mainLayer_btnSwitchMenu_point:setVisible(self:isSwitchMenuRedPoint())
end

function DHomeToolBar:updateLayerState(  )
	local isAtHome = gameFunc.getTempInfo().getValueForKey("IsAtHome")
	self._mainLayer_btnRechargeFirst:setVisible(((not require 'AccountHelper'.isItemOFF('Recharge') ) and require 'RechargeInfo'.isFcRewardEnable()) and isAtHome and not require 'AccountHelper'.isItemOFF('Vip'))
	local taskLoginFunc = gameFunc.getTaskLoginInfo()
	local day = taskLoginFunc.getSevenDiscountDay()
	self._mainLayer_btnReward:setVisible( (not gameFunc.getTaskLoginInfo().isSevenDayRewardDone() or (day > 0 and day < 8)) and isAtHome and not require 'AccountHelper'.isItemOFF('PetName'))
	self._mainLayer_btnSignIn:setVisible(isAtHome and not require 'AccountHelper'.isItemOFF('Vip'))	
	self._mainLayer_btnActivity:setVisible(isAtHome and not require 'AccountHelper'.isItemOFF('Vip'))

	
	self._mainLayer_btnRecharge:setVisible(isAtHome)
	self._mainLayer_btnTask:setVisible(isAtHome and not require 'AccountHelper'.isItemOFF('Vip'))
	self._mainLayer_btnNotice:setVisible(isAtHome)
	self._mainLayer_btnFacebook:setVisible(isAtHome and self:isThai())

	self._mainLayer_btnSwitchArea:setVisible(not isAtHome)
	local areaId = gameFunc.getTempInfo().getLastAreaId()
	local dbArea = dbManager.getArea(areaId)
	if dbArea then
		self._mainLayer_btnSwitchArea_normal_text:setString(dbArea.Name)
		self._mainLayer_btnSwitchArea_pressed_text:setString(dbArea.Name)
		self._mainLayer_btnSwitchArea_invalid_text:setString(dbArea.Name)
	end

	self._mainLayer_btnWorld:setVisible(isAtHome)
	self._mainLayer_btnHome:setVisible(not isAtHome)
	
	--add by te
	self._mainLayer_btnAd:setVisible(false)
	local showAdFunc = function ( ... )
		self._mainLayer_btnAd_normal_addcolor:setResid('ad_icon_btn.png')
		self._mainLayer_btnAd_pressed_elf:setResid('ad_icon_btn_sel.png')
		self._mainLayer_btnAd:setVisible(not isAtHome)
		self._mainLayer_btnAd:setListener(function ( ... )

			--after ad show finish
			self:send(netModel.getModelAdGiftGet(),function ( data )
				if data and data.D then
					if data.D.Resource then
						require "AppData".updateResource(data.D.Resource)
					end
					if data.D.Reward then
						GleeCore:showLayer('DGetReward',data.D.Reward)
					end
					
					require 'Toolkit'.reduceEveryDaysLastCount('AdGift',1)
					if require 'Toolkit'.getEveryDaysLastCount('AdGift',5) <= 0 then
						self._mainLayer_btnAd_normal_addcolor:stopAllActions()
						self._mainLayer_btnAd_normal_addcolor:setAddColor(0,0,0,0)
						self._mainLayer_btnAd_normal_addcolor:setColorf(1,1,1,1)	
					end	
				end
			end)
		end)
	end
	require 'LangAdapter'.selectLangkv({ES=showAdFunc,PT=showAdFunc})
	if self._mainLayer_btnAd:isVisible() then
		local count = require 'Toolkit'.getEveryDaysLastCount('AdGift',5)
		if count > 0 then
			local SwfActionFactory = require 'framework.swf.SwfActionFactory'
			local tableData = require 'ActionBiSha'
			local a1 = SwfActionFactory.createPureAction(tableData.array[1],nil,nil,10)
			local action1 = CCRepeatForever:create(a1)
			self._mainLayer_btnAd_normal_addcolor:runElfAction(action1)	
		else
			self._mainLayer_btnAd_normal_addcolor:stopAllActions()
			self._mainLayer_btnAd_normal_addcolor:setAddColor(0,0,0,0)
			self._mainLayer_btnAd_normal_addcolor:setColorf(1,1,1,1)	
		end
	end


	self._mainLayer_btnPlayBranch:setVisible(not isAtHome)
	if not isAtHome then
		local text
		townFunc.PlayBranchEvent(function ( ... )
			text = res.locString("Town$Fuben1")
		end, function ( ... )
			text = res.locString("Town$Fuben2")
		end, function ( ... )
			text = res.locString("Town$Fuben3")
		end)
		self._mainLayer_btnPlayBranch_normal_text:setString(text)
		self._mainLayer_btnPlayBranch_pressed_text:setString(text)
		self._mainLayer_btnPlayBranch_invalid_text:setString(text)
	end

	self:updateRechargeFirstPosition()
	self._mainLayer_btnPetTicket:setVisible( not isAtHome and townFunc.getPlayBranch() == townFunc.getPlayBranchList().PlayBranchSenior )
	self:updatePetTicket()

	local areaRewardRedPointVisible = false
	if not isAtHome then
		if townFunc.isPlayBranchNormal() and not gameFunc.getTownInfo().checkAreaBoxGetAllRewards( areaId ) then
			areaRewardRedPointVisible = true
		end
	end
	self._mainLayer_btnAreaReward:setVisible( areaRewardRedPointVisible )

	self._mainLayer_btnLayout:removeAllChildrenWithCleanup(true)
	-- 红包
	local redPaperData = gameFunc.getActivityInfo().getDataByType(16)
	if isAtHome and redPaperData then
		if math.floor(require "TimeListManager".getTimeUpToNow(redPaperData.CloseAt)) < 0 then
			local btnRedPaper = self:createLuaSet("@btnRedPaper")
			self._mainLayer_btnLayout:addChild(btnRedPaper[1])
			btnRedPaper["point"]:setVisible(false)
			btnRedPaper[1]:setListener(function ( ... )
				if math.floor(require "TimeListManager".getTimeUpToNow(redPaperData.CloseAt)) < 0 then
					GleeCore:showLayer("DRedPaper")
				else
					self:toast(res.locString("SuperPrice$OutOfTime"))
					btnRedPaper[1]:setVisible(false)
				end
			end)
		end
	end

	-- 7日回归奖励
	if isAtHome and userFunc.getData().Senior7D then
		local allGet = true
		for k,v in pairs(userFunc.getData().Senior7D) do
			if v ~= 1 then
				allGet = false
				break
			end
		end
		if not allGet then
			local btnSeniorSevenDay = self:createLuaSet("@btnSeniorSevenDay")
			self._mainLayer_btnLayout:addChild(btnSeniorSevenDay[1])
			btnSeniorSevenDay["point"]:setVisible(table.find(userFunc.getData().Senior7D, 0))
			btnSeniorSevenDay[1]:setListener(function ( ... )
				GleeCore:showLayer("DSeniorSevenDay")
			end)
		end
	end

	-- 回馈
	if isAtHome and AccountHelper.isHKEnable() then
		local btnGoodback = self:createLuaSet("@btnGoodback")
		self._mainLayer_btnLayout:addChild(btnGoodback[1])
		btnGoodback["point"]:setVisible(false)
		btnGoodback[1]:setListener(function ( ... )
			GleeCore:showLayer('DQuestion',{hk=true})
		end)
	end

	-- 返利
	if isAtHome and AccountHelper.isCZEnable() then
		local btnRebate = self:createLuaSet("@btnRebate")
		self._mainLayer_btnLayout:addChild(btnRebate[1])
		btnRebate["point"]:setVisible(false)
		btnRebate[1]:setListener(function ( ... )
			GleeCore:showLayer('DQuestion',{cz=true})
		end)
	end

	-- 精灵蛋
	local nEgg = gameFunc.getBagInfo().getEgg()
	if isAtHome and nEgg and nEgg.Cnt == 0 then
		local btnEgg = self:createLuaSet("@btnEgg")
		self._mainLayer_btnLayout:addChild(btnEgg[1])
		if nEgg then
			print(nEgg)
			local lastTime = - math.floor(require "TimeListManager".getTimeUpToNow(nEgg.EndAt))
			print("lastTime = " .. lastTime)
			if lastTime > 0 then
				btnEgg["timer"]:getElfDate():setHourMinuteSecond(require "TimeListManager".getTimeInfoBySeconds(lastTime))
				btnEgg["timer"]:setUpdateRate(-1)
				btnEgg["timer"]:addListener(function (  )
					btnEgg["timer"]:setUpdateRate(0)
					btnEgg["timer"]:setVisible(false)
					self:updateLayerState()
				end)
				btnEgg["timer"]:setVisible(true)
				btnEgg["hatchTip"]:setVisible(false)
				btnEgg["point"]:setVisible(false)
			else
				btnEgg["timer"]:setUpdateRate(0)
				btnEgg["timer"]:setVisible(false)
				btnEgg["hatchTip"]:setVisible(true)
				btnEgg["point"]:setVisible(true)
			end

			btnEgg[1]:setListener(function ( ... )
				if nEgg and nEgg.EndAt then
					local lastTime = - math.floor(require "TimeListManager".getTimeUpToNow(nEgg.EndAt))
					if lastTime > 0 then
						self:toast(res.locString("Egg$HatchSucTip"))
					else
						self:send(netModel.getModelPackHatch(), function ( data )
							if data and data.D then
								gameFunc.updateResource(data.D.Resource)
								gameFunc.getPetInfo().addPets(data.D.Pets)
								gameFunc.getBagInfo().useEgg()

								self:updateLayerState()
							--	res.doActionGetReward(data.D.Reward)
								GleeCore:showLayer('DPetAcademyEffectV2',{pets={data.D.Resource.Pets[1]}})
								eventCenter.eventInput("UpdatePetEgg")
							end
						end)
					end
				end
			end)
		end
	end	

	-- 账号绑定
	if isAtHome and self:isThai() then
		local btnBind = self:createLuaSet("@btnBind")
		self._mainLayer_btnLayout:addChild(btnBind[1])
		btnBind[1]:setListener(function ( ... )
			self:toast("点击了账号绑定")
		end)
	elseif isAtHome and require 'AccountInfo'.isGuest() then
		local btnBind = self:createLuaSet("@btnBind")
		self._mainLayer_btnLayout:addChild(btnBind[1])
		self._btnBind = btnBind[1]
		btnBind[1]:setListener(function ( ... )
			require 'AccountInfo'.setBindAction(true)
			GleeCore:showLayer('DKorLogin',{bind=true,callback=function ( authdata )
				require 'AccountHelper'.ACSUpdateAuthData(authdata)
				self:toast(res.locString('Bind$SUC'))
				self._btnBind:setVisible(false)
			end})
		end)
	elseif self._btnBind and not tolua.isnull(self._btnBind) then
		self._btnBind:setVisible(require 'AccountInfo'.isGuest())
	end

	self._mainLayer_ServerTime:setVisible(isAtHome)

	local isChristmas = not require 'AccountHelper'.isItemOFF('Spring')
	self._mainLayer_christmas2:setVisible(isChristmas)
	self._mainLayer_btnBar_christmas1:setVisible(isChristmas)
	self._mainLayer_christmas0:setVisible(isChristmas and isAtHome)
	self._mainLayer_christmas1:setVisible(isChristmas and isAtHome)
	self._mainLayer_btnChat_normal_christmas:setVisible(isChristmas)
	self._mainLayer_btnChat_pressed_christmas:setVisible(isChristmas)
end

function DHomeToolBar:isThai( ... )
	local t = require 'script.info.Info'.ACCONFIG
	return t and t.AUTHURL == "http://lopthapi.gamedreamer.co.th"
end

function DHomeToolBar:isSinMa( ... )
	-- local t = require 'script.info.Info'.ACCONFIG
	-- return t and t.AUTHURL == "http://lopthapi.gamedreamer.co.th" 
	return Config.InfoName == 'IOS_Phone_Singapore' or Config.InfoName == 'IOS_Phone_SingaporeEN'
end

function DHomeToolBar:updatePetTicket( ... )
	self._mainLayer_btnPetTicket_count:setString(string.format("%d/%d", userFunc.getData().FastTicket, dbManager.getVipInfo(userFunc.getVipLevel()).PetSweepTicket))
end

function DHomeToolBar:updateRechargeFirstPosition(  )
	local x, y = self._mainLayer_btnReward:getPosition()
	if self._mainLayer_btnReward:isVisible() then
		self._mainLayer_btnRechargeFirst:setPosition(ccp(x - 88, y))
	else
		self._mainLayer_btnRechargeFirst:setPosition(ccp(x, y))
	end
end

function DHomeToolBar:isRedPointBag( ... )
	local bagFunc = gameFunc.getBagInfo()
	local items = bagFunc.getItems()
	for i,v in ipairs(items) do
		local dbMaterial = dbManager.getInfoMaterial(v.MaterialId)
		if dbMaterial and dbMaterial.red_point > 0 then
			if bagFunc.isItemCanUse(v.Id) then
				return true
			end
		end
	end
	return false
end

function DHomeToolBar:isRedPointActivity( ... )
	if gameFunc.getTempInfo().getValueForKey("RedPointActivity") == nil then
		local flag = true
		local activityFunc = gameFunc.getActivityInfo()
		while true do
			if activityFunc.getOther("Compe") then
				break
			end
			if activityFunc.getDataByType(3) then
				break
			end
			if activityFunc.getOther("UpgradeAct") then
				break
			end
			if activityFunc.getDataByType(4) then
				break
			end
			if activityFunc.getDataByType(6) then
				break
			end
			if activityFunc.getDataByType(8) then
				break
			end
			if activityFunc.getDataByType(5) then
				break
			end
			if activityFunc.getDataByType(7) then
				break
			end
			flag = false
			break
		end
		gameFunc.getTempInfo().setValueForKey("RedPointActivity", flag)
	end
	return gameFunc.getTempInfo().getValueForKey("RedPointActivity")
end

function DHomeToolBar:isRedPointRewardFirst( ... )
	if gameFunc.getTempInfo().getValueForKey("RedPointRewardFirst") == nil then
		gameFunc.getTempInfo().setValueForKey("RedPointRewardFirst", true)
	end
	local canGetFirstReward = require 'RechargeInfo'.FcRewardGotEnable() and (not require 'RechargeInfo'.isFcRewardGot())
	return canGetFirstReward or gameFunc.getTempInfo().getValueForKey("RedPointRewardFirst")
end

function DHomeToolBar:isAreaRewardRedPoint( ... )
	return townFunc.isPlayBranchNormal() and gameFunc.getTownInfo().checkAreaBoxCanGetReward( gameFunc.getTempInfo().getLastAreaId() )
end

function DHomeToolBar:petCanImprove( nPetId )
	local petFunc = gameFunc.getPetInfo()
	local nPet = petFunc.getPetWithId(nPetId)
	return petFunc.satisfyAllEvolveCondition(nPet) or petFunc.getPetUpgradeEnable(nPet)
end

function DHomeToolBar:isTeamRedPoint( ... )
	local team = gameFunc.getTeamInfo().getTeamActive()
	if team then
		if team.BenchPetId > 0 and self:petCanImprove(team.BenchPetId) then
			return true
		end
		for i,v in ipairs(team.PetIdList) do
			if self:petCanImprove(v) then
				return true
			end
		end
	end

	return gameFunc.getTempInfo().getValueForKey("TeamPoint") or false
end

function DHomeToolBar:isSwitchMenuRedPoint( ... )
	return self._mainLayer_btnBar_layout_btnTeam_point:isVisible() 
	or self._mainLayer_btnBar_layout_btnFriend_point:isVisible()
	or self._mainLayer_btnBar_layout_btnMail_point:isVisible()
	or self._mainLayer_btnBar_layout_btnPet_point:isVisible()
	or self._mainLayer_btnBar_layout_btnBag_point:isVisible()
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DHomeToolBar, "DHomeToolBar")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DHomeToolBar", DHomeToolBar)
