local Config = require "Config"
local appData = require 'AppData'
local eventCenter = require 'EventCenter'
local ActivityType = require "ActivityType"
local res = require "Res"
local netModel = require 'netModel'

local ActivityConfig = {
	-- [ActivityType.Practice]			= {img = "HD_banner1.png",xml = "ActivityTrain",lua = "TrainView",actType = 1},
	-- [ActivityType.MagicBox] 		= {img = "HD_banner3.png",xml = "MagicBox",lua = "MagicBoxView",actType = 1},
	-- [ActivityType.MagicShop]   		= {img = "HD_banner2.png",xml = "MagicShop",lua = "MagicShopView",actType = 1},
	[ActivityType.RoastDuck]   		= {img = "N_HD_banner4.png",xml = "RoastDuck",lua = "RoastDuckView",actType = 2},
	[ActivityType.CaptureCompe]		= {img = "N_HD_banner5.png",xml = "CaptureCompe",lua = "CaptureCompe",actType = 2},
	[ActivityType.TimeLimitPet] 		= {img = "N_HD_banner6.png",xml = "TimeLimitPet",lua = "TimeLimitPetView",actType = 2},
	[ActivityType.RoleUpgradeAct] 	= {img = "N_HD_banner7.png",xml = "RoleUpgradeAct",lua = "RoleUpgradeActView",actType = 2},
	[ActivityType.RoleUpgradeRewardAct] 	= {img = "N_HD_banner7.png",xml = "RoleUpgradeRewardAct",lua = "RoleUpgradeRewardAct",actType = 2},
	[ActivityType.RoleUpgradeRankAct] 	= {img = "N_HD_banner31.png",xml = "RoleUpgradeRankAct",lua = "RoleUpgradeRankAct",actType = 2},
	-- [ActivityType.ActRaid] 			= {img = "HD_banner8.png",xml = "ActRaid",lua = "ActRaidView",actType = 1},
	-- [ActivityType.PetKill]			= {img = "HD_banner10.png",xml = "PetKill",lua = "PetKill",actType = 1},
	-- [ActivityType.RoadOfChampion]	= {img = "HD_banner9.png",xml = "RoadOfChampion",lua = "RoadOfChampionView",actType = 1},
	[ActivityType.LuckyCat] = {img = "N_HD_banner11.png",xml = "LuckyCat",lua = "LuckyCatView",actType = 2},
	-- [ActivityType.BossBattle1] = {img = "HD_banner18.png",xml = "BossBattle",lua = "BossBattle",actType = 1},
	-- [ActivityType.BossBattle2] = {img = "HD_banner12.png",xml = "BossBattle",lua = "BossBattle",actType = 1},
	[ActivityType.ChargeDay] = {img = "N_HD_banner13.png",xml = "ChargeDay",lua = "ChargeDay",actType = 2},
	[ActivityType.ChargeCost] = {img = "N_HD_banner14.png",xml = "ChargeCost",lua = "ChargeCost",actType = 2},
	[ActivityType.ChargeGift] = {img = "N_HD_banner15.png",xml = "ChargeGift",lua = "ChargeGift",actType = 2},
	[ActivityType.ChargeACC] = {img = "N_HD_banner16.png",xml = "ChargeACC",lua = "ChargeACC",actType = 2},
	[ActivityType.ExChage] = {img = "N_HD_banner17.png",xml = "ExChage",lua = "ExChage",actType = 2},
	[ActivityType.Wish] = {img = "N_HD_banner18.png", xml = "Wish", lua = "WishView", actType = 2},
	[ActivityType.Charge7Day] = {img = "N_HD_banner19.png", xml = "Charge7Day", lua = "Charge7DayView", actType = 2},
	[ActivityType.loginGift] = {img = "N_HD_banner21.png", xml = "loginGift", lua = "loginGift", actType = 2},

	[ActivityType.fund] = {img = "N_HD_banner29.png", xml = "fund", lua = "fund", actType = 2},

	[ActivityType.MonDayGift] = {img = "N_HD_banner20.png", xml = "MonDayGift", lua = "MonDayGift", actType = 2},
	[ActivityType.TownRewardDouble] = {img = "N_HD_banner24.png", xml = "TownRewardDouble", lua = "TownRewardDoubleView", actType = 2},
	[ActivityType.LuckyMagicBox] = {img = "N_HD_banner22.png", xml = "LuckyMagicBox", lua = "LuckyMagicBox", actType = 2},
	[ActivityType.EquipBuyDiscount] = {img = "N_HD_banner23.png", xml = "EquipBuyDiscount", lua = "EquipBuyDiscount", actType = 2},
	[ActivityType.V6Notice] = {img = "N_HD_banner25.png", xml = "V6Notice", lua = "V6Notice", actType = 2},
	[ActivityType.TrialBox] = {img = "N_HD_banner27.png", xml = "TrialBox", lua = "TrialBoxView", actType = 2},
	[ActivityType.LuckWheel] = {img = "N_HD_banner26.png", xml = "LuckyWheel", lua = "LuckWheelView",  actType = 2},
	[ActivityType.MCardGift] = {img = "N_HD_yk_kk.png", xml = "MCardGift", lua = "MCardGiftView", actType = 2},
	[ActivityType.WellPet] = {img = "N_HD_banner30.png", xml = "WellPet", lua = "WellPetView", actType = 2},
	[ActivityType.DoctorTask] = {img = "N_HD_banner34.png", xml = "DoctorTask", lua = "DoctorTask", actType = 2},
	[ActivityType.LuckyLottery] = {img = "N_HD_banner32.png", xml = "LuckyLottery", lua = "LuckyLottery", actType = 2},
	[ActivityType.Tuangou] = {img = "N_HD_banner33.png", xml = "Tuangou", lua = "Tuangou", actType = 2},
	[ActivityType.Card21] = {img = "N_HD_banner35.png", xml = "Card21", lua = "Card21View", actType = 2},
	[ActivityType.ChargeFeedback] = {img = "N_HD_banner36.png", xml = "ChargeFeedback", lua = "ChargeFeedback", actType = 2},
	[ActivityType.ChargeSevenDayGifts] = {img = "N_HD_banner37.png", xml = "ChargeSevenDayGifts", lua = "ChargeSevenDayGifts", actType = 2},
	[ActivityType.TimeLimitExplore] = {img = "N_HD_banner38.png", xml = "TimeLimitExplore", lua = "TimeLimitExploreView", actType = 2},
	[ActivityType.DestinyWheel] = {img = "N_HD_banner39.png", xml = "DestinyWheel", lua = "DestinyWheelView", actType = 2},
	[ActivityType.ExploreRwdDouble] = {img = "N_HD_banner41.png", xml = "ExploreRwdDouble", lua = "ExploreRwdDoubleView", actType = 2},
	[ActivityType.ExploreRobRwdDouble] = {img = "N_HD_banner40.png", xml = "ExploreRobRwdDouble", lua = "ExploreRobRwdDoubleView", actType = 2},
	[ActivityType.HatchEgg] = {img = "N_HD_banner42.png", xml = "HatchEgg", lua = "HatchEggView", actType = 2},
	[ActivityType.SilverCoinShop] = {img = "N_HD_banner43.png", xml = "SilverCoinShop", lua = "SilverCoinShopView", actType = 2},
	[ActivityType.LoveOfWater] = {img = "N_HD_banner44.png", xml = "LoveOfWater", lua = "LoveOfWaterView", actType = 2},
	[ActivityType.SeniorGift] = {img = "N_HD_banner_old.png", xml = "SeniorGift", lua = "SeniorGiftView", actType = 2},
	[ActivityType.Playground] = {img = "JLYLY_banner.png", xml = "Playground", lua = "Playground", actType = 2},
}

--需要活动开启时有tab闪烁效果的活动，添加到ActivityState表里
local ActivityState = {
	[ActivityType.RoastDuck] = "roast_duck",
	[ActivityType.ChargeDay] = "daily_charge",
	[ActivityType.ChargeGift] = "onece_charge",
	[ActivityType.ChargeACC] = "total_charge",
	[ActivityType.ChargeCost] = "total_consume",
	[ActivityType.RoleUpgradeAct] = "lv_top",
	[ActivityType.RoleUpgradeRewardAct] = "lv_top",
	[ActivityType.TimeLimitPet] = "time_pet",
	[ActivityType.Wish] = "pray",
	[ActivityType.MonDayGift] = "monday_gift",
	[ActivityType.loginGift] = "login_gift",
	[ActivityType.TrialBox] = "adv_box_buy",
	[ActivityType.MCardGift] = "mcard_gift",
	[ActivityType.WellPet] = "coin_well",
	[ActivityType.fund] = "fund",
	[ActivityType.Tuangou] = "tuangou",
	[ActivityType.LuckyLottery] = "lucky_lottery",
	[ActivityType.ChargeSevenDayGifts] = "seven_day_reward",
}

local DActivity = class(LuaDialog)

function DActivity:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DActivity.cocos.zip")
    return self._factory:createDocument("DActivity.cocos")
end

--@@@@[[[[
function DActivity:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_activityView = set:getElfNode("bg_activityView")
    self._bg_backBtn = set:getButtonNode("bg_backBtn")
    self._bg_activityList = set:getListNode("bg_activityList")
    self._activityImg = set:getAddColorNode("activityImg")
    self._activityBtn = set:getTabNode("activityBtn")
    self._forAnimBg = set:getRectangleNode("forAnimBg")
    self._forAnim = set:getElfNode("forAnim")
    self._screenBtn = set:getButtonNode("screenBtn")
--    self._@activityItem = set:getElfNode("@activityItem")
end
--@@@@]]]]

local ActivityStatus

local getShowActivity = function ( userData )
	local showActivityType
	for i=1,table.maxn(ActivityConfig) do
		if not ActivityStatus[i]  and ActivityConfig[i] then
			showActivityType = i
			break
		end
	end

	if userData and userData.ShowActivity and not ActivityStatus[userData.ShowActivity] then
		showActivityType = userData.ShowActivity
	end
	return showActivityType
end

local initActivityStatus = function ( ... )
	ActivityStatus = appData.getActivityInfo().getActivityStatus()
	if not appData.getActivityInfo().getOther("Compe") then
		ActivityStatus[ActivityType.CaptureCompe] = true
	end
	if not appData.getActivityInfo().getDataByType(3) then
		ActivityStatus[ActivityType.TimeLimitPet] = true
	end
	if not appData.getActivityInfo().getOther("UpgradeAct") then
		ActivityStatus[ActivityType.RoleUpgradeAct] = true
		ActivityState[ActivityType.RoleUpgradeAct] = nil
	end
	if not appData.getActivityInfo().getOther("UpgradeRankAct") then
		ActivityStatus[ActivityType.RoleUpgradeRankAct] = true
	end
	if not appData.getActivityInfo().getOther("UpgradeRewardAct") then
		ActivityStatus[ActivityType.RoleUpgradeRewardAct] = true
		ActivityState[ActivityType.RoleUpgradeRewardAct] = nil
	end
	if not appData.getActivityInfo().getDataByType(4) then
		ActivityStatus[ActivityType.ChargeDay] = true
	end
	if not appData.getActivityInfo().getDataByType(6) then
		ActivityStatus[ActivityType.ChargeCost] = true
	end
	if not appData.getActivityInfo().getDataByType(8) then
		ActivityStatus[ActivityType.ChargeGift] = true
	end
	if not appData.getActivityInfo().getDataByType(5) then
		ActivityStatus[ActivityType.ChargeACC] = true
	end
	if not appData.getActivityInfo().getDataByType(7) then
		ActivityStatus[ActivityType.ExChage] = true
	end
	if not appData.getActivityInfo().getDataByType(19) then
		ActivityStatus[ActivityType.Charge7Day] = true
	end
	if not appData.getActivityInfo().getDataByType(21) then
		ActivityStatus[ActivityType.MonDayGift] = true
	end
	if not appData.getActivityInfo().getDataByType(12) then
		ActivityStatus[ActivityType.TownRewardDouble] = true
	end
	if not appData.getActivityInfo().getDataByType(22) then
		ActivityStatus[ActivityType.loginGift] = true
	end
	if not appData.getActivityInfo().getDataByType(23) then
		ActivityStatus[ActivityType.LuckyMagicBox] = true
	end
	if not appData.getActivityInfo().getDataByType(24) then
		ActivityStatus[ActivityType.EquipBuyDiscount] = true
	end
	if not appData.getActivityInfo().getOther("V6Notice") or require "PetInfo".isPetInMyPetList(145) then
		ActivityStatus[ActivityType.V6Notice] = true
	end
	if not appData.getActivityInfo().getDataByType(29) then
		ActivityStatus[ActivityType.TrialBox] = true
	end
	if not appData.getActivityInfo().getDataByType(30) then
		ActivityStatus[ActivityType.LuckWheel] = true
	end
	if not appData.getActivityInfo().getDataByType(31) then
		ActivityStatus[ActivityType.MCardGift] = true
	end
	if not appData.getActivityInfo().getDataByType(33) then
		ActivityStatus[ActivityType.DoctorTask] = true
	end
	if not appData.getActivityInfo().getDataByType(34) then
		ActivityStatus[ActivityType.LuckyLottery] = true
	end
	if not appData.getActivityInfo().getDataByType(35) then
		ActivityStatus[ActivityType.Tuangou] = true
	end
	if not appData.getActivityInfo().getDataByType(37) then
		ActivityStatus[ActivityType.Card21] = true
	end
	if not appData.getActivityInfo().getDataByType(40) then
		ActivityStatus[ActivityType.ChargeFeedback] = true
	end
	if not appData.getActivityInfo().getDataByType(41) then
		ActivityStatus[ActivityType.ChargeSevenDayGifts] = true
	end
	if not appData.getActivityInfo().getDataByType(42) then
		ActivityStatus[ActivityType.TimeLimitExplore] = true
	end
	if not appData.getActivityInfo().getDataByType(43) then
		ActivityStatus[ActivityType.DestinyWheel] = true
	end
	if not appData.getActivityInfo().getDataByType(44) then
		ActivityStatus[ActivityType.ExploreRwdDouble] = true
	end
	if not appData.getActivityInfo().getDataByType(45) then
		ActivityStatus[ActivityType.ExploreRobRwdDouble] = true
	end
	if not appData.getActivityInfo().getDataByType(46) then
		ActivityStatus[ActivityType.HatchEgg] = true
	end

	local silverCoinData = appData.getActivityInfo().getDataByType(48)
	if not silverCoinData then
		ActivityStatus[ActivityType.SilverCoinShop] = true
		ActivityStatus[ActivityType.LoveOfWater] = true
	else
		if -math.floor(require "TimeListManager".getTimeUpToNow(silverCoinData.CloseAt)) - 3600 * 24 <= 0 then
			ActivityStatus[ActivityType.SilverCoinShop] = true
		end
	end

	if not appData.getActivityInfo().getDataByType(49) then
		ActivityStatus[ActivityType.SeniorGift] = true
	end

	ActivityStatus[ActivityType.WellPet] = not require "UserInfo".isCoinWellExit()

	if not appData.getActivityInfo().getDataByType(60) then
		ActivityStatus[ActivityType.Playground] = true
	end	
end

local Launcher = require 'Launcher'

Launcher.register('DActivity',function ( userData )
	initActivityStatus()

	local func
	func = function ( ... )
		local showActivityType = getShowActivity(userData)
		print(showActivityType)
		local logic = require (ActivityConfig[showActivityType].lua)
		if logic.getNetModel then
	   		Launcher.callNet(logic.getNetModel(showActivityType),function ( data )
	     			Launcher.Launching(data)   
	   		end,function ( data )
	   			ActivityStatus[showActivityType] = true
	   			return func()
	   		end)
	   	else
	   		Launcher.Launching()
	   	end
	end

	func()
end)

--------------------------------override functions----------------------
function DActivity:onInit( userData, netData )
	res.doActionDialogShow(self._bg)

	self.tickHandle = {}
	self.animFinishFuncs = {}

	self.mNetData = netData

	eventCenter.addEventFunc("OnAppStatChange", function ( state )
		if state == 2 then
			return self:updateView()
		end
	end, "DActivity")

	-- eventCenter.addEventFunc("BattleStart", function ( state )
	-- 	self.isToBattle = true
	-- end, "DActivity")

	eventCenter.addEventFunc('EventActivity',function ( data )
		self:refreshItemsState()
	end, "DActivity")

	eventCenter.addEventFunc("UpdateCard21Chip", function ( ... )
		return self:updateView()
	end, "DActivity")

	eventCenter.addEventFunc("UpdateTimeLimitExplore", function ( ... )
		return self:updateView()
	end, "DActivity")

	eventCenter.addEventFunc("UpdateActivity", function ( ... )
		return self:updateView()
	end, "DActivity")

	eventCenter.addEventFunc("UpdateGoldCoin", function ( ... )
		if self.curShowActivity == ActivityType.SilverCoinShop then
			require "SilverCoinShopView".refreshLayer(self, self.curView)
		end
	end, "DActivity")

	self:checkActivity()
	self:setBtnListener()

	self:createActivityList(getShowActivity(userData))

	self:onEnter()

	appData.getTempInfo().setValueForKey("RedPointActivity", false)
	eventCenter.eventInput("UpdatePoint")
end

function DActivity:onBack( userData, netData )
	print("------onBack-------")
	if self.onBackHandler then
		self.onBackHandler()
		self.onBackHandler = nil
	end
end

-- function DActivity:revertLayer( ... )
-- 	print("------revertLayer-------")
-- 	self:loadXML()
-- 	self:setBtnListener()
-- 	local showActivityType = self.curShowActivity
-- 	self.curShowActivity = 0
-- 	self:createActivityList(showActivityType)
-- end

function DActivity:onRelease(  )
	print("------onRelease-------")
	self:reset()
	eventCenter.resetGroup("DActivity")
	self:clearItemSets()
end

-- function DActivity:isKeepAlive()
-- 	print("------isKeepAlive-------")
--     	return not self.isToBattle
-- end

function DActivity:onEnter( ... )
	print("------onEnter-------")
	self.isToBattle = false
	require 'GuideHelper':check('DActivity')
end

function DActivity:onLeave( ... )
	print("------onLeave-------")
	for _,v in ipairs(self.tickHandle) do
		require "framework.sync.TimerHelper".cancel(v)
	end
	self.tickHandle = {}
end

--------------------------------custom code-----------------------------
function DActivity:finishAnims( ... )
	for _,v in ipairs(self.animFinishFuncs) do
		v()
	end
	self.animFinishFuncs = {}

	if self.cachedUpdateFunc then
		self.cachedUpdateFunc()
		self.cachedUpdateFunc = nil
	end
	for _,v in ipairs(self.tickHandle) do
		require "framework.sync.TimerHelper".cancel(v)
	end
	self.tickHandle = {}
end

function DActivity:checkActivity( ... )
	for k,_ in pairs(ActivityState) do
		if ActivityStatus[k] then
			self:roleNewsUpdate(k)
		end
	end

	local t = require "TimeManager".getCurrentSeverDate()
	local enable = (t.hour<13 and t.hour>=11) or (t.hour<19 and t.hour>=17)
	local broadCastFunc = appData.getBroadCastInfo()
	if not enable and broadCastFunc.get('roast_duck') then
		self:roleNewsUpdate(ActivityType.RoastDuck)
	end
end

function DActivity:createActivityList( showActivity )
	showActivity = showActivity or getShowActivity()

	self.mTabBtns = {}
	self._bg_activityList:getContainer():removeAllChildrenWithCleanup(true)
	self:clearItemSets()

	local actType = ActivityConfig[showActivity].actType
	for i=1,table.maxn(ActivityConfig) do
		if not ActivityStatus[i] then
			local v = ActivityConfig[i]
			if v and v.actType == actType then
				local set = self:createLuaSet("@activityItem")
				self:addItemSet(set,i)
				set["activityImg"]:setResid(v.img)
				set["activityBtn"]:setListener(function ( ... )
					if self.curShowActivity == i then
						return
					end
					self:updateView(i)
				end)
				if i == showActivity then
					set["activityBtn"]:trigger(nil)
				end
				self.mTabBtns[i] = set["activityBtn"]
				self._bg_activityList:addListItem(set[1])
			end
		end
	end
	-- self.mTabBtns[showActivity]:trigger(nil)
	self:refreshItemsState()
end

function DActivity:reset( ... )
	for _,v in ipairs(self.tickHandle) do
		require "framework.sync.TimerHelper".cancel(v)
	end
	self.tickHandle = {}
	if self.curView then
		self.curView.document:release()
		self.curView = nil
		SystemHelper:cleanUnusedTexture()
	end
	if self.activityRemoveHandler then
		self.activityRemoveHandler()
		self.activityRemoveHandler = nil
	end
end

function DActivity:updateView( showActivityType )
	showActivityType = showActivityType or self.curShowActivity

	local logic = require (ActivityConfig[showActivityType].lua)
	local function onInitSuccess( )
		local view
		local oldshowActivityType = self.curShowActivity
		if self.curShowActivity ~= showActivityType then
			self:reset()
			self.curShowActivity = showActivityType
			view = self:createView(showActivityType)
			self._bg_activityView:removeAllChildrenWithCleanup(true)
			self._bg_activityView:addChild(view[1])
			self.curView = view
			self:roleNewsUpdate(nil,true)
		else
			view = self.curView
		end
		logic.update(self,view,self.mNetData,showActivityType,oldshowActivityType)
		self.mNetData = nil
	end
	local function onInitFail( ... )
		return self:onActivityFinish(showActivityType)
	end

	if logic.getNetModel and not self.mNetData then
		self:send(logic.getNetModel(showActivityType),function ( data )
			print(data)
			self.mNetData = data
			return onInitSuccess()
		end,function ( data )
			onInitFail()
		end)
	else
		onInitSuccess()
	end
end

function DActivity:createView( showActivityType )
	local factory = XMLFactory:getInstance()
	local xml = ActivityConfig[showActivityType].xml
	factory:setZipFilePath(Config.COCOS_ZIP_DIR..xml..".cocos.zip")
	local document = factory:createDocument(xml..".cocos")
	local function createLuaSet( name )
		local e = factory:findElementByName(document,name)
		local cset = factory:createWithElement(e)
		return require 'framework.helper.Utils'.toluaSet(cset)
	end
	local view = createLuaSet("@view")
	view.createLuaSet = createLuaSet
	view.document = document
	view.document:retain()
	return view
end

function DActivity:onActivityFinish( activityType )
	self.mNetData = nil
	ActivityStatus[activityType] = true
	self:toast(res.locString("Activity$ActFinishTip"))
	self:createActivityList()
end

function DActivity:setBtnListener( ... )
	-- self._bg_fpRM_rtBtns_helpBtn:setListener(function ( ... )
	-- 	self:toast("帮助功能暂未开放，敬请期待")
	-- end)
	self.close = function ( ... )
		self:onLeave()
		self:onRelease()
	end

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_backBtn:setTriggleSound(res.Sound.back)
	self._bg_backBtn:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._screenBtn:setPenetrate(true)
	self._screenBtn:setTriggleSound("")
	self._screenBtn:setListener(function ( ... )
		if #self.animFinishFuncs>0 then
			self:finishAnims()
			if self.cachedViewUpdateFunc then
				self.cachedViewUpdateFunc()
				self.cachedViewUpdateFunc = nil
			else
				return self:updateView()
			end
		end
	end)
end

function DActivity:actionEnable( enable,addcolornode )
	if addcolornode and enable then
		local SwfActionFactory = require 'framework.swf.SwfActionFactory'
		local tableData = require 'ActionBiSha'
		local a1 = SwfActionFactory.createPureAction(tableData.array[1],nil,nil,10)
		local action1 = CCRepeatForever:create(a1)
		addcolornode:runElfAction(action1)
	elseif addcolornode then
		addcolornode:stopAllActions()
		addcolornode:setAddColor(0,0,0,0)
		addcolornode:setColorf(1,1,1,1)
	end
end

function DActivity:addItemSet( set,AType )
	if self._itemsets == nil then
		self._itemsets = {}
	end

	self._itemsets[AType] = set
end

function DActivity:getItemSet( AType )
	return self._itemsets and self._itemsets[AType]
end

function DActivity:clearItemSets( ... )
	self._itemsets = nil
end

function DActivity:refreshState( AType,enable )
	local set = self:getItemSet(AType)
	if set then
		self:actionEnable(enable,set['activityImg'])
	end
end

function DActivity:refreshItemsState( actType )
	if actType then
		self:refreshState(actType,appData.getBroadCastInfo().get(ActivityState[actType]))
	else
		for k,v in pairs(ActivityState) do
			local broadCastFunc = appData.getBroadCastInfo()
			local enable = broadCastFunc.get(v)
			self:refreshState(k,enable)
		end
	end
end

--
function DActivity:roleNewsUpdate( AType,localonly)
	local broadCastFunc = appData.getBroadCastInfo()
	local AType = AType or self.curShowActivity
	local notifyKey = ActivityState[AType]
	if notifyKey  then
		local preStat = broadCastFunc.get(notifyKey)
		broadCastFunc.set(notifyKey,false)
		self:refreshItemsState(AType)
		if not localonly and preStat then
			self:sendBackground(netModel.getModelRoleNewsUpdate(notifyKey,false),function ( ... )
	   			print('DActivity Role newsUpdate done')
			end)
		end
	end
end

function DActivity:refreshActivityInfo(view,Type,callback)
  self:send(netModel.getModelActivityGet(Type),function ( data )
    if data and data.D then
      appData.getActivityInfo().updateActivityInfo(data.D.Activity)
      if not data.D.Activity then
        appData.getActivityInfo().activityEnd(Type)
      end
    end
    return callback and callback(data.D.Activity)
  end)
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DActivity, "DActivity")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DActivity", DActivity)


