local Config = require "Config"
local eventCenter = require 'EventCenter'
local netModel = require "netModel"
local res = require "Res"
local dbManager = require "DBManager"
local gameFunc = require "AppData"
local GuideHelper = require 'GuideHelper'
local unLockManager = require "UnlockManager"
local userFunc = gameFunc.getUserInfo()
local broadCastFunc = gameFunc.getBroadCastInfo()

local CHome = class(LuaController)

function CHome:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."CHome.cocos.zip")
    return self._factory:createDocument("CHome.cocos")
end

--@@@@[[[[
function CHome:onInitXML()
	local set = self._set
    self._btnHideMenu = set:getButtonNode("btnHideMenu")
    self._FarBg = set:getElfNode("FarBg")
    self._FarBg_shandianBg = set:getElfNode("FarBg_shandianBg")
    self._FarBg_shandianBg_center = set:getElfNode("FarBg_shandianBg_center")
    self._FarBg_shandianBg_shandian = set:getSimpleAnimateNode("FarBg_shandianBg_shandian")
    self._FarBg_shandianBg_nameBg_name = set:getLabelNode("FarBg_shandianBg_nameBg_name")
    self._FarBg_btnBestBoss = set:getClickNode("FarBg_btnBestBoss")
    self._FarBg_btnChampionRoad = set:getButtonNode("FarBg_btnChampionRoad")
    self._FarBg_btnChampionRoad_nameBg_name = set:getLabelNode("FarBg_btnChampionRoad_nameBg_name")
    self._FarBg_btnChampionRoad_nameBg_lock = set:getElfNode("FarBg_btnChampionRoad_nameBg_lock")
    self._map = set:getMapNode("map")
    self._map_container_bg = set:getElfNode("map_container_bg")
    self._map_container_bg_btnGoodFind = set:getClickNode("map_container_bg_btnGoodFind")
    self._map_container_bg_btnGoodFind_feiting = set:getFlashMainNode("map_container_bg_btnGoodFind_feiting")
    self._map_container_bg_btnGoodFind_feiting_root = set:getElfNode("map_container_bg_btnGoodFind_feiting_root")
    self._map_container_bg_feitingName = set:getElfNode("map_container_bg_feitingName")
    self._map_container_bg_feitingName_nameBg_name = set:getLabelNode("map_container_bg_feitingName_nameBg_name")
    self._map_container_bg_feitingName_nameBg_lock = set:getElfNode("map_container_bg_feitingName_nameBg_lock")
    self._map_container_bg_feitingName_nameBg_point = set:getElfNode("map_container_bg_feitingName_nameBg_point")
    self._map_container_bg_btnGuild = set:getClickNode("map_container_bg_btnGuild")
    self._map_container_bg_btnGuild_nameBg_name = set:getLabelNode("map_container_bg_btnGuild_nameBg_name")
    self._map_container_bg_btnGuild_nameBg_lock = set:getElfNode("map_container_bg_btnGuild_nameBg_lock")
    self._map_container_bg_btnGuild_nameBg_point = set:getElfNode("map_container_bg_btnGuild_nameBg_point")
    self._map_container_bg_btnGuild_huaban = set:getFlashMainNode("map_container_bg_btnGuild_huaban")
    self._map_container_bg_btnGuild_huaban_root = set:getElfNode("map_container_bg_btnGuild_huaban_root")
    self._map_container_bg_btnBossBattle = set:getClickNode("map_container_bg_btnBossBattle")
    self._map_container_bg_btnBossBattle_nameBg_name = set:getLabelNode("map_container_bg_btnBossBattle_nameBg_name")
    self._map_container_bg_btnBossBattle_nameBg_lock = set:getElfNode("map_container_bg_btnBossBattle_nameBg_lock")
    self._map_container_bg_btnBossBattle_shandianniao = set:getFlashMainNode("map_container_bg_btnBossBattle_shandianniao")
    self._map_container_bg_btnBossBattle_shandianniao_root = set:getElfNode("map_container_bg_btnBossBattle_shandianniao_root")
    self._map_container_bg_btnBossBattle_chaomeng = set:getFlashMainNode("map_container_bg_btnBossBattle_chaomeng")
    self._map_container_bg_btnBossBattle_chaomeng_root = set:getElfNode("map_container_bg_btnBossBattle_chaomeng_root")
    self._map_container_bg_btnDarkMall = set:getClickNode("map_container_bg_btnDarkMall")
    self._map_container_bg_btnDarkMall_nameBg_name = set:getLabelNode("map_container_bg_btnDarkMall_nameBg_name")
    self._map_container_bg_btnDarkMall_nameBg_lock = set:getElfNode("map_container_bg_btnDarkMall_nameBg_lock")
    self._map_container_bg_btnArena = set:getClickNode("map_container_bg_btnArena")
    self._map_container_bg_btnArena_nameBg_name = set:getLabelNode("map_container_bg_btnArena_nameBg_name")
    self._map_container_bg_btnArena_nameBg_lock = set:getElfNode("map_container_bg_btnArena_nameBg_lock")
    self._map_container_bg_btnArena_nameBg_point = set:getElfNode("map_container_bg_btnArena_nameBg_point")
    self._map_container_bg_btnArena_laba = set:getFlashMainNode("map_container_bg_btnArena_laba")
    self._map_container_bg_btnArena_laba_root = set:getElfNode("map_container_bg_btnArena_laba_root")
    self._map_container_bg_btnEquip = set:getClickNode("map_container_bg_btnEquip")
    self._map_container_bg_btnEquip_nameBg_name = set:getLabelNode("map_container_bg_btnEquip_nameBg_name")
    self._map_container_bg_btnEquip_nameBg_lock = set:getElfNode("map_container_bg_btnEquip_nameBg_lock")
    self._map_container_bg_btnEquip_nameBg_point = set:getElfNode("map_container_bg_btnEquip_nameBg_point")
    self._map_container_bg_btnShop = set:getClickNode("map_container_bg_btnShop")
    self._map_container_bg_btnShop_nameBg_name = set:getLabelNode("map_container_bg_btnShop_nameBg_name")
    self._map_container_bg_btnShop_shangcheng_KeyStorage = set:getElfNode("map_container_bg_btnShop_shangcheng_KeyStorage")
    self._map_container_bg_btnShop_shangcheng_KeyStorage_point1_Visible = set:getElfNode("map_container_bg_btnShop_shangcheng_KeyStorage_point1_Visible")
    self._map_container_bg_btnShop_shangcheng_KeyStorage_point2_Visible = set:getElfNode("map_container_bg_btnShop_shangcheng_KeyStorage_point2_Visible")
    self._map_container_bg_btnShop_shangcheng_KeyStorage_bottom_Position = set:getElfNode("map_container_bg_btnShop_shangcheng_KeyStorage_bottom_Position")
    self._map_container_bg_btnShop_shangcheng_KeyStorage_light_Position = set:getElfNode("map_container_bg_btnShop_shangcheng_KeyStorage_light_Position")
    self._map_container_bg_btnShop_shangcheng_icon = set:getElfNode("map_container_bg_btnShop_shangcheng_icon")
    self._map_container_bg_btnShop_shangcheng_point1 = set:getElfNode("map_container_bg_btnShop_shangcheng_point1")
    self._map_container_bg_btnShop_shangcheng_point2 = set:getElfNode("map_container_bg_btnShop_shangcheng_point2")
    self._map_container_bg_btnShop_shangcheng_light = set:getElfNode("map_container_bg_btnShop_shangcheng_light")
    self._map_container_bg_btnShop_shangcheng_bottom = set:getElfNode("map_container_bg_btnShop_shangcheng_bottom")
    self._map_container_bg_btnCallPet = set:getClickNode("map_container_bg_btnCallPet")
    self._map_container_bg_btnCallPet_nameBg_name = set:getLabelNode("map_container_bg_btnCallPet_nameBg_name")
    self._map_container_bg_btnCallPet_nameBg_point = set:getElfNode("map_container_bg_btnCallPet_nameBg_point")
    self._map_container_bg_btnActTask = set:getClickNode("map_container_bg_btnActTask")
    self._map_container_bg_btnActTask_nameBg_name = set:getLabelNode("map_container_bg_btnActTask_nameBg_name")
    self._map_container_bg_btnActTask_nameBg_lock = set:getElfNode("map_container_bg_btnActTask_nameBg_lock")
    self._map_container_bg_btnActTask_nameBg_point = set:getElfNode("map_container_bg_btnActTask_nameBg_point")
    self._map_container_bg_btnActTask_club = set:getFlashMainNode("map_container_bg_btnActTask_club")
    self._map_container_bg_btnActTask_club_root = set:getElfNode("map_container_bg_btnActTask_club_root")
    self._map_container_bg_btnRank = set:getClickNode("map_container_bg_btnRank")
    self._map_container_bg_btnRank_nameBg_name = set:getLabelNode("map_container_bg_btnRank_nameBg_name")
    self._map_container_bg_btnRank_nameBg_lock = set:getElfNode("map_container_bg_btnRank_nameBg_lock")
    self._map_container_bg_btnRank_nameBg_point = set:getElfNode("map_container_bg_btnRank_nameBg_point")
    self._map_container_bg_btnRank_rankswf = set:getFlashMainNode("map_container_bg_btnRank_rankswf")
    self._mainLayer = set:getElfNode("mainLayer")
    self._mainLayer_userInfo_head = set:getElfNode("mainLayer_userInfo_head")
    self._mainLayer_userInfo_btn = set:getClickNode("mainLayer_userInfo_btn")
    self._mainLayer_userInfo_lvValue = set:getLabelNode("mainLayer_userInfo_lvValue")
    self._mainLayer_userInfo_name = set:getLabelNode("mainLayer_userInfo_name")
    self._mainLayer_userInfo_vip = set:getElfNode("mainLayer_userInfo_vip")
    self._mainLayer_userInfo_vip_vipBtn = set:getClickNode("mainLayer_userInfo_vip_vipBtn")
    self._mainLayer_userInfo_ap1_ap2 = set:getProgressNode("mainLayer_userInfo_ap1_ap2")
    self._mainLayer_userInfo_apValue = set:getLabelNode("mainLayer_userInfo_apValue")
    self._mainLayer_userInfo_power = set:getLabelNode("mainLayer_userInfo_power")
    self._mainLayer_userInfo_coinValue = set:getLabelNode("mainLayer_userInfo_coinValue")
    self._mainLayer_userInfo_goldValue = set:getLabelNode("mainLayer_userInfo_goldValue")
    self._mainLayer_userInfo_christmas = set:getElfNode("mainLayer_userInfo_christmas")
    self._mainLayer_btnPVP = set:getClickNode("mainLayer_btnPVP")
    self._mainLayer_btnPVE = set:getClickNode("mainLayer_btnPVE")
    self._mainLayer_btnRoleSwitch = set:getClickNode("mainLayer_btnRoleSwitch")
    self._moveIn = set:getElfAction("moveIn")
    self._moveOut = set:getElfAction("moveOut")
end
--@@@@]]]]

--------------------------------override functions----------------------
function CHome:onInit( userData, netData )
	self._mainLayer_userInfo_christmas:setPosition(ccp(0,0))
	
	require 'MusicSettings'.apply()
	
	self._map:setContentSize(CCDirector:sharedDirector():getWinSize())

	self:roleLoginEvent()
	self:updateMapNodeName()
	require 'UnlockManager':init()
	self:updateLockStatus()
	self:updateBossDown()
	self:updateRedPoint()
	self:adjustNodeAtScreenMiddle("shop")
	self:playSwfAll()
	self:playAnimation()
	self:setListenerEvent()
	self:broadcastEvent()
	
	if not gameFunc.getTempInfo().getHomeToolBarVisible() then
		GleeCore:showLayer("DHomeToolBar", {isAtHome = true})
	end
	
	GuideHelper:startGuide()
	-- require 'UnlockManager':userLv(0,18)
	-- GuideHelper:startGuide('GCfg17')
	self.firstLoad = true

	if Config.AutoArenaTest then
		GleeCore:showLayer("DArena")
	end

	require "NotificationManager".scheduleSysNotifyList()

	self._mainLayer_userInfo_christmas:setVisible(not require 'AccountHelper'.isItemOFF('Spring'))



	if userFunc.getData().SeniorReturn then
		GleeCore:showLayer("DExchangeKey", {mode = "SeniorGift"})
	end

	require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
		local fontSize = 30
		self._map_container_bg_btnArena_nameBg_name:setFontSize(fontSize)
		self._FarBg_shandianBg_nameBg_name:setFontSize(fontSize)
		self._map_container_bg_btnDarkMall_nameBg_name:setFontSize(fontSize)
		self._map_container_bg_btnGuild_nameBg_name:setFontSize(fontSize)
		self._map_container_bg_btnShop_nameBg_name:setFontSize(fontSize)
		self._map_container_bg_btnEquip_nameBg_name:setFontSize(fontSize)
		self._map_container_bg_btnCallPet_nameBg_name:setFontSize(fontSize)
		self._FarBg_btnChampionRoad_nameBg_name:setFontSize(fontSize)
		self._map_container_bg_btnActTask_nameBg_name:setFontSize(fontSize)
		self._map_container_bg_feitingName_nameBg_name:setFontSize(fontSize)
		self._map_container_bg_btnRank_nameBg_name:setFontSize(fontSize)
		self._map_container_bg_btnBossBattle_nameBg_name:setFontSize(fontSize)
	end)
end

function CHome:onBack( userData, netData )
	if not gameFunc.getTempInfo().getHomeToolBarVisible() then
		GleeCore:showLayer("DHomeToolBar", {isAtHome = true,delay=res.getTransitionFadeDelta()/2})	
	end

	local adjustName = gameFunc.getTempInfo().getHomeAdjustName()
	if adjustName then
		gameFunc.getTempInfo().setHomeAdjustName(nil)
		self:adjustNodeAtScreenMiddle(adjustName)
	end

	self:updateLockStatus()
	self:updateBossDown()
	self:updateRedPoint()
end

function CHome:onEnter(  )
		-- body
	require 'framework.helper.MusicHelper'.playBackgroundMusic(res.Music.home, true)

	self:updateUserInfoLayer()
	self:updateBossBattleAnim()
--	self:runWithDelay(function (  )
		eventCenter.eventInput("UpdatePoint")
		eventCenter.eventInput("SwitchHomeWorld", {isAtHome = true})
--	end, res.getTransitionFadeDelta() / 2)
	
	self:checkLoginDate()
	self:checkGuideOverReward()

	GuideHelper:check('CHome')

	if GuideHelper:isGuideDone() and self.firstLoad then
		--如果有公告才弹出
		local announce = gameFunc.getInitAnnoucne()
		if announce and next(announce) ~= nil then
			GleeCore:showLayer("DNotice", announce)
		end
	end

	self.firstLoad = false
end

function CHome:onLeave(  )
	
end

function CHome:onRelease(  )
	print("CHome:onRelease")
	eventCenter.resetGroup("CHome")
	CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(self.tickMap)
	self.tickMap = nil
end

--------------------------------custom code-----------------------------

function CHome:setListenerEvent(  )
	local w1 = self._FarBg:getContentSize().width
	local w2 = self._map:getMoveNode():getContentSize().width
	local winWidth = CCDirector:sharedDirector():getWinSize().width
	local rate = (w1 - winWidth) / (w2 - winWidth)
	local timerHelper = require "framework.sync.TimerHelper"
	self.tickMap = timerHelper.tick(function ( dt )
		local mapX, mapY = self._map:getMoveNode():getPosition()
		self._FarBg:setPosition(ccp(mapX * rate, mapY))
	end)

	local btnTable = {
		{ ["node"] = self._map_container_bg_btnGuild, ["nextDialog"] = "DGuild", ["unLockMoudle"] = "Guild"},
		{ ["node"] = self._map_container_bg_btnBossBattle, ["nextDialog"] = "DBossBattle", ["unLockMoudle"] = "BossBattle" },
		{ ["node"] = self._map_container_bg_btnDarkMall, ["nextDialog"] = "DMagicShop", ["unLockMoudle"] = "MagicShop" },
		{ ["node"] = self._map_container_bg_btnArena, ["nextDialog"] = "DArena", ["unLockMoudle"] = "Arena" },
		{ ["node"] = self._map_container_bg_btnEquip, ["nextDialog"] = "DMagicBox", ["unLockMoudle"] = "MagicBoxUnlock" },
		{ ["node"] = self._map_container_bg_btnShop, ["nextDialog"] = "DMall", ["unLockMoudle"] = nil },
		{ ["node"] = self._map_container_bg_btnCallPet, ["nextDialog"] = "DPetAcademyV2", ["unLockMoudle"] = nil},
		{ ["node"] = self._map_container_bg_btnActTask, ["nextDialog"] = "DActRaid", ["unLockMoudle"] = "EquipFuben" },
		{ ["node"] = self._FarBg_btnBestBoss, ["nextDialog"] = "DPetKill", ["unLockMoudle"] = nil },
		{ ["node"] = self._FarBg_btnChampionRoad, ["nextDialog"] = "DRoadOfChampion", ["unLockMoudle"] = "RoadOfChampion"},
		{ ["node"] = self._map_container_bg_btnGoodFind, ["nextDialog"] = "CExploreScene", ["unLockMoudle"] = "Exploration"},
		{ ["node"] = self._map_container_bg_btnRank, ["nextDialog"] = "DRank", ["unLockMoudle"] = "ranklist"},
	}

	for k,v in pairs(btnTable) do
		v.node:setListener(function ( ... )
			if self:isMoudleUnLock(v.unLockMoudle) then
				-- if v.nextDialog == "DArena" then
				-- 	broadCastFunc.set("arena", false)
				-- 	self:updateRedPointArena()
				-- else
				if v.nextDialog == "DActRaid" then
					broadCastFunc.set("res_copy", false)
					self:updateRedPointActTask()
				elseif v.nextDialog == "DMagicBox" then
					gameFunc.getTempInfo().setValueForKey("EquipFree", true)
					self:updateRedPointEquipCenter()
				elseif v.nextDialog == "CExploreScene" then
              		      GleeCore:closeAllLayers()
					GleeCore:pushController(v.nextDialog, nil, nil, res.getTransitionFade())
					return
				end
				GleeCore:showLayer(v.nextDialog)
			end
		end)
	end
	if require 'AccountHelper'.isItemOFF('PetName') then
		self._map_container_bg_btnBossBattle:setVisible(false)
	end

	-- local ss1
	-- self._map_container_bg_btnEquip:setListener(function ( ... )
	-- 	-- body
	-- 	ss1 = require 'framework.helper.Utils'.dumpSnapShot()
	-- end)

	-- self._map_container_bg_btnShop:setListener(function ( ... )
	-- 	-- body
	-- 	if ss1 then
	-- 		local ss2 = require 'framework.helper.Utils'.dumpSnapShot()
	-- 		require 'framework.helper.Utils'.printSnapShot(ss1, ss2)
	-- 	else
	-- 		print('SS1 Not Ready!')
	-- 	end
	-- end)

	-- self._map_container_bg_btnArena:setListener(function ( ... )
	-- 	-- body
	-- 	eventCenter.printSnapShot()
	-- end)
	

	local showTestBtn = require 'Default'.Debug.EnterFight
	self._mainLayer_btnPVP:setVisible(showTestBtn)
	self._mainLayer_btnPVE:setVisible(showTestBtn)
	self._mainLayer_btnRoleSwitch:setVisible(showTestBtn)

	self._mainLayer_btnRoleSwitch:setListener(function (  )
		gameFunc.cleanLocalData()
		GleeCore:closeAllLayers()
		GleeCore:reSet()
		GleeCore:replaceController("CTestLogin")
		--gameFunc.getTempInfo().resetData()
	end)

	self._mainLayer_userInfo_btn:setListener(function (  )
		GleeCore:showLayer("DUserInfo")
	end)

	self._mainLayer_userInfo_vip_vipBtn:setListener(function (  )
		GleeCore:showLayer("DRecharge", {ShowIndex = 2})
		--GleeCore:showLayer("DTrialReward")
	end)

	self._btnHideMenu:setTriggleSound("")
	self._btnHideMenu:setListener(function (  )
		eventCenter.eventInput("MenuBarStateHide")
	end)
end

function CHome:broadcastEvent(  )
	eventCenter.addEventFunc("UpdateAp", function (  )
		self:updateUserInfoLayer()
	end, "CHome")

	eventCenter.addEventFunc("UpdateBattleValue", function (  )
		self:updateUserInfoLayer()
	end, "CHome")

	eventCenter.addEventFunc("UpdateGoldCoin", function (  )
		self:updateUserInfoLayer()
	end, "CHome")

	eventCenter.addEventFunc("UpdateVipLevel", function (  )
		self:updateUserInfoLayer()
	end, "CHome")
	
	eventCenter.addEventFunc("ReloginDone", function ( ... )
		self:updateUserInfoLayer()
		eventCenter.eventInput("UpdatePoint")
	end, "CHome")

	eventCenter.addEventFunc("HomeAdjustNodeName", function ( data )
		self:adjustNodeAtScreenMiddle(data.name)
	end, "CHome")

	eventCenter.addEventFunc("UnlockEvent", function ( data )
		self:updateLockStatus()
		self:updateRedPoint()
	end, "CHome")

	eventCenter.addEventFunc("EventBossDown", function ( data )
		self:updateBossDown()
		userFunc.setBossDownPlay(true)
		if data.D.Data then
			self:toast(string.format(res.locString("DPetKill$BossBattleInvite"), tostring(data.D.Data)))
		end
	end, "CHome")

	eventCenter.addEventFunc("UpdateUserName", function ( data )
		self:updateUserInfoLayer()
	end, "CHome")

	eventCenter.addEventFunc("OnBattleCompleted", function ( data )
		print("OnBattleCompleted")
		print(data)
		if gameFunc.getTempInfo().getValueForKey("ReopenTown") then
			gameFunc.getTempInfo().setValueForKey("ReopenTown", nil)
			GleeCore:showLayer("DTown", gameFunc.getTempInfo().getValueForKey("LastDTownData") )
		end
		if data and data.mode == 'guildfuben' then
			require "AppData".updateResource(data.userData.D.Resource)
			require "GuildCopyInfo".setGuildCopyRecord(data.userData.D.Record)
			GleeCore:showLayer("DHunt", {AreaId = require "TempInfo".getValueForKey("GuildCopyAreaId"),
				TownId = require "TempInfo".getValueForKey("GuildCopyTownId")})
		end
		if data and data.mode == "limit_fuben" then
			if data.isWin then
				require "AppData".updateResource(data.userData.D.Resource)
				require "TimeLimitExploreInfo".setExplore(data.userData.D.TimeCopy)
				require "TimeLimitExploreInfo".setTimeCopyStageList(data.userData.D.Stages)
			end
			GleeCore:showLayer("DActivity", {ShowActivity = require "ActivityType".TimeLimitExplore})
			self:runWithDelay(function ( ... )
				GleeCore:showLayer("DTimeLimitExploreMain")
			end, 0.5)
		end

		if data and data.mode == "guildfuben_rob" then
			require "AppData".updateResource(data.userData.D.Resource)
		--	require "ExploreInfo".setExploreRob(data.userData.D.Data)
			GleeCore:showLayer("DExploration")
		end
		if data and data.mode == "guildfuben_revenge" then
			GleeCore:showLayer("DExploration")
		end
		if data and data.mode == "friend" then
			GleeCore:showLayer("DFriend", {tabIndexSelected = 2})
		end
	end, "CHome")

	eventCenter.addEventFunc(require 'FightEvent'.Pve_FightResult, function ( data )
		print("home_fightresult")
		print(data)
		if data and data.D then
			if data.D.Result then
				if data.D.Result.Resource then
					local oldlv = gameFunc.getUserInfo().getLevel()
					gameFunc.updateResource(data.D.Result.Resource)
					local newlv = gameFunc.getUserInfo().getLevel()
					require 'UnlockManager':userLv(oldlv,newlv)
				end
			end
			if data.D.Pets then
				gameFunc.getPetInfo().addPets(data.D.Pets)
			end
			if data.D.Towns then
				local townFunc = gameFunc.getTownInfo()
				for k,v in pairs(data.D.Towns) do
					townFunc.setTown(v)
				end
				
				if not(townFunc.isPlayBranchNormal()) and #data.D.Towns > 0 and data.D.Towns[1].Clear then
					gameFunc.getTempInfo().setTownIsClear(true)

					if townFunc.getPlayBranch() == townFunc.getPlayBranchList().PlayBranchHero then
						if gameFunc.getUserInfo().getNextTownId() == data.D.Towns[1].Id then
							self:toast(res.locString("Town$HeroStagesFinishTip"))
						end
					end
				end
			end
			if data.D.AreaId and data.D.AreaId > 0 then
				gameFunc.getTempInfo().setAreaId(data.D.AreaId)
			end
		end
	end, "CHome")

	eventCenter.addEventFunc("TownOpenActionDelay", function ( data )
		gameFunc.getTempInfo().setValueForKey("TownOpenActionDelay", true)
	end, "CHome")

	eventCenter.addEventFunc("GoToTown", function ( data )
		print("GoToTown_addEventFunc")
		-- if data.townId then
		-- 	GleeCore:showLayer("DTown", data )
		-- else
			local curCtrl = GleeCore:getRunningController()
			local curCtrlName = curCtrl:getControllerName()
			print(curCtrlName)
			data.type = "GoToTown"
			if curCtrlName == "CHome" then
				GleeCore:pushController("CWorldMap", data)
			elseif curCtrlName == "CWorldMap" then
				eventCenter.eventInput("TownArrive", data)
			elseif curCtrlName == "CTeam" then
				GleeCore:popControllerTo('CHome')
				GleeCore:pushController("CWorldMap", data)
			end
		-- end
	end, "CHome")

	eventCenter.addEventFunc("OnAppStatChange", function ( state )
		if state == 2 then
			self:updateUserInfoLayer()
		end
	end, "CHome")

	eventCenter.addEventFunc("UpdateBossBattleAnimation", function ( data )
		self:updateBossBattleAnim()
	end, "CHome")

	eventCenter.addEventFunc("EventBossDownPlay", function ( data )
		userFunc.setBossDownPlay(false)
	end, "CHome")

	eventCenter.addEventFunc("explore", function ( data )
		self:updateRedPointExplore()
	end, "CHome")

	eventCenter.addEventFunc("PetInfoModify", function (  )
		self:updateUserInfoLayer()
	end, "CHome")

	eventCenter.addEventFunc("RedPointGuild", function (  )
		self:updateRedPointGuild()
	end, "CHome")

	eventCenter.addEventFunc("RedPointCallPet", function (  )
		self:updateRedPointCallPet()
	end, "CHome")

	eventCenter.addEventFunc("RedPointEquipCenter", function (  )
		self:updateRedPointEquipCenter()
	end, "CHome")
	
	eventCenter.addEventFunc("EventResCopy", function (  )
		self:updateRedPointActTask()
	end, "CHome")

	eventCenter.addEventFunc("EventArena", function (  )
		self:updateRedPointArena()
	end, "CHome")

	eventCenter.addEventFunc("RedPointHome", function (  )
		self:updateRedPoint()
	end, "CHome")

	eventCenter.addEventFunc("UpdatePoint", function (  )
		self:updateRedPoint()
	end, "CHome")

	eventCenter.addEventFunc("EventCoinWell", function ( data )
		print("EventCoinWell__")
		userFunc.setCoinWellFlag(true)
	end, "CHome")

	eventCenter.addEventFunc("OnRuneUpdate", function (  )
		self:updateUserInfoLayer()
	end, "CHome")
end

function CHome:updateBossBattleAnim(  )
	local bossId = userFunc.getBossAtkBossId()
	print("updateBossBattleAnim_" .. bossId)
	self._map_container_bg_btnBossBattle_shandianniao:setVisible(bossId == 1)
	self._map_container_bg_btnBossBattle_chaomeng:setVisible(bossId == 2)
	if bossId == 1 or bossId == 2 then
		self._map_container_bg_btnBossBattle_nameBg_name:setString(res.locString(string.format("Home$BossBattle%d", bossId)))
	end
end

function CHome:updateUserInfoLayer(  )
	if userFunc and userFunc.isValid() then
		local teamFunc = gameFunc.getTeamInfo()
		if teamFunc and teamFunc.getTeamActive() then
			local nPetId = teamFunc.getTeamActive().CaptainPetId
			if nPetId > 0 then
				local nPet = gameFunc.getPetInfo().getPetWithId(nPetId)
				if nPet then
					self._mainLayer_userInfo_head:setResid(res.getPetIcon(nPet.PetId))
				end
			end
		end

		self._mainLayer_userInfo_name:setString(userFunc.getName())
		self._mainLayer_userInfo_coinValue:setString(userFunc.getCoin())
		self._mainLayer_userInfo_goldValue:setString(res.getGoldFormat(userFunc.getGold()))
		self._mainLayer_userInfo_lvValue:setString(userFunc.getLevel())
		local levelTable = dbManager.getInfoRoleLevelCap(userFunc.getLevel())
		self._mainLayer_userInfo_apValue:setString(string.format("%d/%d", userFunc.getAp(), levelTable.apcap))
		self._mainLayer_userInfo_ap1_ap2:setPercentage(userFunc.getAp() * 100 / levelTable.apcap)
		self._mainLayer_userInfo_vip:setResid(res.getVipIcon(userFunc.getVipLevel()))
		self._mainLayer_userInfo_power:setString(teamFunc.getTeamCombatPower())
	end
end

function CHome:roleLoginEvent(  )
	-- local socketC = require "SocketClient"
	-- print('connect:')
	-- print(Config)
	-- socketC:connect(Config.SocketAddr, Config.SocketPort, function ( suc )
	-- 	if suc then
	-- 		require "RoleLogin".roleLoginV2(Config.RoleID, Config.ServerID, function ( )
	-- 			self:updateUserInfoLayer()
	-- 			eventCenter.eventInput("UpdatePoint")
	-- 			require 'UnlockManager':init()
	-- 			require 'GuideHelper':startGuide()
	-- 		end, function ( ... )
	-- 			self:toast("登录失败T_T")
	-- 		end)
	-- 	else
	-- 		GleeCore:showLayer('DDisconnectNotice')
	-- 	end
	-- end)

	----------------------------------PVP,PVE-------------------------------

	local function innerInit( )
		-- body
		self._mainLayer_btnPVE:setListener(function ( ... )
			GleeCore:pushController('SelectScene')
		end)

		self._mainLayer_btnPVP:setListener(function ( ... )
			GleeCore:pushController('Login')
		end)
	end
	innerInit()
end

function CHome:updateMapNodeName(  )
	self._map_container_bg_btnArena_nameBg_name:setString(res.locString("Home$Arena"))
	self._FarBg_shandianBg_nameBg_name:setString(res.locString("Home$BestBoss"))
	self._map_container_bg_btnDarkMall_nameBg_name:setString(res.locString("Home$DarkMall"))
	self._map_container_bg_btnGuild_nameBg_name:setString(res.locString("Home$Guild"))
	self._map_container_bg_btnShop_nameBg_name:setString(res.locString("Home$Shop"))
	self._map_container_bg_btnEquip_nameBg_name:setString(res.locString("Home$Equip"))
	self._map_container_bg_btnCallPet_nameBg_name:setString(res.locString("Home$CallPet"))
	self._FarBg_btnChampionRoad_nameBg_name:setString(res.locString("Home$ChampionRoad"))
	self._map_container_bg_btnActTask_nameBg_name:setString(res.locString("Home$ActTask"))
	self._map_container_bg_feitingName_nameBg_name:setString(res.locString("Home$GoodFind"))
	self._map_container_bg_btnRank_nameBg_name:setString(res.locString("Home$Rank"))
end

function CHome:adjustNodeAtScreenMiddle( name )
	local list = {
		["arena"] = self._map_container_bg_btnArena,
		["bestBoss"] = self._map_container_bg_btnDarkMall, -- 神兽和黑市适配的坐标基本一样
		["darkMall"] = self._map_container_bg_btnDarkMall,
		["guild"] = self._map_container_bg_btnGuild,
		["shop"] = self._map_container_bg_btnShop,
		["equip"] = self._map_container_bg_btnEquip,
		["callPet"] = self._map_container_bg_btnCallPet,
		["championRoad"] = self._map_container_bg_btnShop, -- 冠军之塔和商店坐标基本一样
		["actTask"] = self._map_container_bg_btnActTask,
		["bossBattle"] = self._map_container_bg_btnBossBattle,
		["Explore"] = self._map_container_bg_btnGoodFind,
	}
	local node = list[name] or self._map_container_bg_btnShop
	self._map:getMoveNode():setPosition(ccp(-node:getPosition(), 0))
	self._map:onRestrict(nil)

	self:runWithDelay(function ( ... )
		GuideHelper:registerPoint('精灵召唤',self._map_container_bg_btnCallPet)
		GuideHelper:registerPoint('活动副本',self._map_container_bg_btnActTask)
		GuideHelper:registerPoint('竞技场',self._map_container_bg_btnArena)
		GuideHelper:registerPoint('公会入口',self._map_container_bg_btnGuild)
		GuideHelper:registerPoint('boss战',self._map_container_bg_btnBossBattle)
		GuideHelper:registerPoint('冠军之塔',self._FarBg_btnChampionRoad)
		GuideHelper:registerPoint('神兽降临',self._FarBg_btnBestBoss)
		GuideHelper:registerPoint('神秘盒子',self._map_container_bg_btnEquip)
		GuideHelper:registerPoint('神秘商店',self._map_container_bg_btnDarkMall)
		GuideHelper:registerPoint('飞艇',self._map_container_bg_btnGoodFind)
		GuideHelper:check('AnimtionEnd')
	end)
end

function CHome:checkLoginDate(  )
	if GuideHelper:isGuideDone() then
		local datetime = gameFunc.getUserInfo().getRoleCreateDateTime()
		local stimes = require 'TimeManager'.getCurrentSeverTime()/1000
		local ret = require 'Toolkit'.isTheSecondDay(datetime,stimes)	
		if ret then
			GuideHelper:startGuide('GCfg03')
		end
	end
end

function CHome:playswf( name,shapeMap,node, scale)
	local Swf = require 'framework.swf.Swf'
	print("swfName = " .. name)
	local myswf = Swf.new(name)
	myswf:getRootNode():setPosition(ccp(0,0))
	node:addChild( myswf:getRootNode() )
	myswf:getRootNode():setScale(scale or 1.0)
	myswf:playLoop(shapeMap)
end


function CHome:playflash( flashNode )
	-- body
	assert(flashNode.getModifierControllerByName)
	local c = flashNode:getModifierControllerByName('swf')
	c:setLoopMode(LOOP)
	c:setLoops(999999999)
	flashNode:play("swf")
end

function CHome:playSwfAll(  )
	self:playflash(self._map_container_bg_btnGoodFind_feiting)
	self:playflash(self._map_container_bg_btnBossBattle_chaomeng)
	self:playflash(self._map_container_bg_btnBossBattle_shandianniao)
--	self:playflash(self._map_container_bg_btnRank_rankswf)

	local HeiShi = {
		['shape-2'] = 'ZC_heishi_01.png',
		['shape-4'] = 'ZC_heishi_02.png',
		['shape-6'] = 'ZC_heishi_03.png',
		['shape-8'] = 'ZC_heishi_04.png',
		['shape-10'] = 'ZC_heishi_05.png',
		['shape-12'] = 'ZC_heishi_06.png',
		['shape-14'] = 'ZC_heishi_07.png',
		['shape-16'] = 'ZC_heishi_08.png',
		['shape-18'] = 'ZC_heishi_09.png',
		['shape-20'] = 'ZC_heishi_10.png',
		['shape-22'] = 'ZC_heishi_11.png',
		['shape-24'] = 'ZC_heishi_12.png',
		['shape-26'] = 'ZC_heishi_13.png',
	}
	self:playswf('Swf_HeiShi',HeiShi,self._map_container_bg_btnDarkMall, 0.86)
	
	-- Swf_HuaBan.lua
	local HuaBan = {
		['shape-2'] = 'Swf_HuaBan-2.png',
		['shape-4'] = 'Swf_HuaBan-4.png',
		['shape-6'] = 'Swf_HuaBan-6.png',
		['shape-9'] = 'Swf_HuaBan-9.png',
		['shape-11'] = 'Swf_HuaBan-11.png',
		['shape-14'] = 'Swf_HuaBan-14.png',
		['shape-16'] = 'Swf_HuaBan-16.png',
		['shape-18'] = 'Swf_HuaBan-18.png',
		['shape-20'] = 'Swf_HuaBan-20.png',
		['shape-21'] = 'Swf_HuaBan-21.png',
		['shape-22'] = 'Swf_HuaBan-22.png',
		['shape-25'] = 'Swf_HuaBan-25.png',
		['shape-28'] = 'Swf_HuaBan-28.png',
		['shape-30'] = 'Swf_HuaBan-30.png',
	}
--	self:playswf('Swf_HuaBan',HuaBan,self._map_container_bg_btnGuild, 0.75)
	self:playflash(self._map_container_bg_btnGuild_huaban)

	-- Swf_LaBa.lua
	local LaBa = {
		['shape-2'] = 'ZC_jinjichang_01.png',
		['shape-4'] = 'ZC_jinjichang_02.png',
		['shape-6'] = 'ZC_jinjichang_03.png',
		['shape-8'] = 'ZC_jinjichang_04.png',
		['shape-10'] = 'ZC_jinjichang_05.png',
		['shape-12'] = 'ZC_jinjichang_06.png',
		['shape-14'] = 'ZC_jinjichang_07.png',
		['shape-16'] = 'ZC_jinjichang_08.png',
		['shape-18'] = 'ZC_jinjichang_09.png',
		['shape-20'] = 'ZC_jinjichang_10.png',
		['shape-22'] = 'ZC_jinjichang_11.png',
		['shape-23'] = 'ZC_jinjichang_12.png',
		['shape-24'] = 'ZC_jinjichang_13.png',
		['shape-25'] = 'ZC_jinjichang_14.png',
	}
--	self:playswf('Swf_LaBa',LaBa,self._map_container_bg_btnArena, 0.6)
	self:playflash(self._map_container_bg_btnArena_laba)

	-- Swf_Qiu.lua
	local Qiu = {
		['shape-2'] = 'ZC_jinglinzhaohuan_01.png',
		['shape-4'] = 'ZC_jinglinzhaohuan_02.png',
		['shape-6'] = 'ZC_jinglinzhaohuan_03.png',
		['shape-8'] = 'ZC_jinglinzhaohuan_04.png',
		['shape-11'] = 'ZC_jinglinzhaohuan_05.png',
		['shape-13'] = 'ZC_jinglinzhaohuan_06.png',
		['shape-15'] = 'ZC_jinglinzhaohuan_07.png',
		['shape-18'] = 'ZC_jinglinzhaohuan_08.png',
		['shape-20'] = 'ZC_jinglinzhaohuan_09.png',
	}
	self:playswf('Swf_Qiu',Qiu,self._map_container_bg_btnCallPet, 0.81)

	-- Swf_club1
	local club1 = {
		['shape-3'] = 'ZC_huodongfuben_01.png',
		['shape-5'] = 'ZC_huodongfuben_02.png',
		['shape-8'] = 'ZC_huodongfuben_03.png',
		['shape-10'] = 'ZC_huodongfuben_04.png',
		['shape-12'] = 'ZC_huodongfuben_05.png',
		['shape-14'] = 'ZC_huodongfuben_06.png',
		['shape-16'] = 'ZC_huodongfuben_07.png',
		['shape-17'] = 'ZC_huodongfuben_07.png',
		['shape-19'] = 'ZC_huodongfuben_08.png',
	}
--	self:playswf('Swf_club1',club1,self._map_container_bg_btnActTask, 0.7)
	self:playflash(self._map_container_bg_btnActTask_club)
end

function CHome:playAnimation(  )
	self._FarBg_shandianBg_shandian:setVisible(false)
	local actArray = CCArray:create()
	actArray:addObject(CCShow:create())
	actArray:addObject(CCDelayTime:create(0.5))
	actArray:addObject(CCHide:create())
	actArray:addObject(CCDelayTime:create(0.5))
	actArray:addObject(CCShow:create())
	actArray:addObject(CCDelayTime:create(0.5))
	actArray:addObject(CCHide:create())
	actArray:addObject(CCCallFunc:create(function (  )
		self._FarBg_shandianBg_shandian:setVisible(true)
	end))
	actArray:addObject(CCDelayTime:create(2.0))
	actArray:addObject(CCCallFunc:create(function (  )
		self._FarBg_shandianBg_shandian:setVisible(false)
	end))
	self._FarBg_shandianBg_center:runAction(CCRepeatForever:create(CCSequence:create(actArray)))
end

function CHome:isMoudleUnLock( moudleName )
	if (not moudleName) or unLockManager:isUnlock(moudleName) then
		return true
	else
		self:toast(string.format(res.locString("Home$LevelUnLockTip"), unLockManager:getUnlockLv(moudleName)))
		return false
	end
end

function CHome:updateLockStatus(  )
	local unLockList = {
		_FarBg_btnChampionRoad = "RoadOfChampion",
		_map_container_bg_btnGuild = "Guild",
		_map_container_bg_btnBossBattle = "BossBattle",
		_map_container_bg_btnDarkMall = "MagicShop",
		_map_container_bg_btnArena = "Arena",
		_map_container_bg_btnEquip = "MagicBoxUnlock",
		_map_container_bg_btnActTask = "EquipFuben",
		_map_container_bg_feitingName = "Exploration",
		_map_container_bg_btnRank = "ranklist",
	}
	for k,v in pairs(unLockList) do
		local isUnLock = unLockManager:isUnlock(v)
		self[string.format("%s_nameBg_lock", k)]:setVisible(not isUnLock)
		if isUnLock then
			self[string.format("%s_nameBg_name", k)]:setFontFillColor(ccc4f(1.0, 1.0, 1.0, 1.0), true)
		else
			self[string.format("%s_nameBg_name", k)]:setFontFillColor(ccc4f(0.66, 0.66, 0.66, 1.0), true)
		end
	end
end

function CHome:updateBossDown(  )
	local isVisible = broadCastFunc.get("boss_down")
	self._FarBg_shandianBg:setVisible(isVisible)
	self._FarBg_btnBestBoss:setVisible(isVisible)
end

--
function CHome:checkGuideOverReward( ... )
	local key 	= 'StepOv'
	local used 	= gameFunc.getNapkinInfo().isUsed(key)
	if not used then
		local guidedone = GuideHelper:isGuideDone()
		local getRewardcallback = function ( ... )
			local curc = GleeControllerManager:getInstance():getRunningController()
			local name = curc:getControllerName()
			local activeTeam = gameFunc.getTeamInfo().getTeamActive()
			local v = activeTeam.PetIdList[3]
			v = (v and tonumber(v)) or 0
			if name == 'CTeam' and v <= 0 then
				GleeCore:closeAllLayers()
				GuideHelper:startGuide('GCfg08',1,1,nil,1)
			end
		end
		local getreward = function ( ... )
			self:send(netModel.getModelRoleUseNapkin(key),function ( data )
				if data.D then
					gameFunc.updateResource(data.D.Rs)
					data.D.Reward.callback=getRewardcallback
					GleeCore:showLayer('DGetReward',data.D.Reward)
				end
				gameFunc.getNapkinInfo().setValue(key,true)
			end)
		end

		if guidedone then
			getreward()
		else
			eventCenter.resetGroup('CHomeGuideOverL')
			eventCenter.addEventFunc('GuideOver',function ( data )
				if data and data == 'GCfg' then
					getreward()
				end
			end,'CHomeGuideOverL')
		end
	end
end

function CHome:updateRedPoint( ... )
	self:updateRedPointCallPet()
	self:updateRedPointEquipCenter()
	self:updateRedPointActTask()
	self:updateRedPointArena()
	self:updateRedPointExplore()
	self:updateRedPointGuild()
end

function CHome:updateRedPointCallPet( ... )
	local itemcount = gameFunc.getBagInfo().getItemCount(22)
	local NDInfo = gameFunc.getLoginInfo().getData().Nd
	local flag = itemcount >= 10 or (NDInfo and NDInfo.Free)
	self._map_container_bg_btnCallPet_nameBg_point:setVisible(flag)
end

function CHome:updateRedPointEquipCenter( ... )
	local itemcount = gameFunc.getBagInfo().getItemCount(23)
	local NEInfo = gameFunc.getLoginInfo().getData().Ne
	local flag = itemcount >= dbManager.getDeaultConfig("eqcardnum").Value or (NEInfo and (NEInfo.Free or NEInfo.TodayFirst) and not gameFunc.getTempInfo().getValueForKey("EquipFree"))
	self._map_container_bg_btnEquip_nameBg_point:setVisible(unLockManager:isUnlock("MagicBoxUnlock") and flag)
end

function CHome:updateRedPointActTask( ... )
	self._map_container_bg_btnActTask_nameBg_point:setVisible(unLockManager:isUnlock("EquipFuben") and broadCastFunc.get("res_copy"))
end

function CHome:updateRedPointArena( ... )
	self._map_container_bg_btnArena_nameBg_point:setVisible(unLockManager:isUnlock("Arena") and broadCastFunc.get("arena"))
end

function CHome:updateRedPointExplore( ... )
	local flag = unLockManager:isUnlock("Exploration") and (gameFunc.getExploreInfo().hasCompleteExplore() or gameFunc.getExploreInfo().hasEmptySlot())
	self._map_container_bg_feitingName_nameBg_point:setVisible(flag)
end

function CHome:updateRedPointGuild( ... )
	local flag = unLockManager:isUnlock("Guild") and not gameFunc.getGuildInfo().Signed()
	self._map_container_bg_btnGuild_nameBg_point:setVisible(flag)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(CHome, "CHome")


--------------------------------register--------------------------------
GleeCore:registerLuaController("CHome", CHome)
