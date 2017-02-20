local Config = require "Config"
local netModel = require "netModel"
local res = require "Res"
local eventCenter = require 'EventCenter'
local dbManager = require "DBManager"

local CurIndex = 0

local DRoadOfChampion = class(LuaDialog)

function DRoadOfChampion:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DRoadOfChampion.cocos.zip")
    return self._factory:createDocument("DRoadOfChampion.cocos")
end

--@@@@[[[[
function DRoadOfChampion:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_content = set:getElfNode("bg_content")
    self._medalLayout_medalCount = set:getLabelNode("medalLayout_medalCount")
    self._bottom_buffAdd = set:getLabelNode("bottom_buffAdd")
    self._bottom_lastCount = set:getLabelNode("bottom_lastCount")
    self._mode_modeIndex = set:getLabelNode("mode_modeIndex")
    self._points_p1 = set:getElfNode("points_p1")
    self._points_p2 = set:getElfNode("points_p2")
    self._points_p3 = set:getElfNode("points_p3")
    self._points_p4 = set:getElfNode("points_p4")
    self._points_p5 = set:getElfNode("points_p5")
    self._points_p6 = set:getElfNode("points_p6")
    self._points_p7 = set:getElfNode("points_p7")
    self._points_p8 = set:getElfNode("points_p8")
    self._points_p9 = set:getElfNode("points_p9")
    self._points_p10 = set:getElfNode("points_p10")
    self._points_p11 = set:getElfNode("points_p11")
    self._points_p12 = set:getElfNode("points_p12")
    self._nodes_n1 = set:getElfNode("nodes_n1")
    self._nodes_n2 = set:getElfNode("nodes_n2")
    self._nodes_n3 = set:getElfNode("nodes_n3")
    self._nodes_n4 = set:getElfNode("nodes_n4")
    self._nodes_n5 = set:getElfNode("nodes_n5")
    self._nodes_n6 = set:getElfNode("nodes_n6")
    self._nodes_n7 = set:getElfNode("nodes_n7")
    self._nodes_n8 = set:getElfNode("nodes_n8")
    self._nodes_n9 = set:getElfNode("nodes_n9")
    self._nodes_n10 = set:getElfNode("nodes_n10")
    self._nodes_n11 = set:getElfNode("nodes_n11")
    self._nodes_n12 = set:getElfNode("nodes_n12")
    self._nodes_n13 = set:getElfNode("nodes_n13")
    self._currentIcon = set:getElfNode("currentIcon")
    self._light = set:getElfNode("light")
    self._icon = set:getElfNode("icon")
    self._buff = set:getElfNode("buff")
    self._btn = set:getButtonNode("btn")
    self._text = set:getLabelNode("text")
    self._rankBoardBtn = set:getClickNode("rankBoardBtn")
    self._resetBtn = set:getClickNode("resetBtn")
    self._fastBtn = set:getClickNode("fastBtn")
    self._fastBtn_cost = set:getLabelNode("fastBtn_cost")
    self._list = set:getListNode("list")
    self._itemBg = set:getElfNode("itemBg")
    self._rank = set:getLabelNode("rank")
    self._name = set:getLabelNode("name")
    self._level = set:getLabelNode("level")
    self._title = set:getLabelNode("title")
    self._count = set:getLabelNode("count")
    self._curHasLayout_count1 = set:getLabelNode("curHasLayout_count1")
    self._curHasLayout_count2 = set:getLabelNode("curHasLayout_count2")
    self._listbg_list = set:getListNode("listbg_list")
    self._layout = set:getLinearLayoutNode("layout")
    self._bg_icon = set:getElfNode("bg_icon")
    self._bg_iconBtn = set:getButtonNode("bg_iconBtn")
    self._bg_count = set:getLabelNode("bg_count")
    self._bg_name = set:getLabelNode("bg_name")
    self._bg_linearlayout_icon = set:getElfNode("bg_linearlayout_icon")
    self._bg_linearlayout_price = set:getLabelNode("bg_linearlayout_price")
    self._bg_buyBtn = set:getClickNode("bg_buyBtn")
    self._bg_buyBtn_label = set:getLabelNode("bg_buyBtn_label")
    self._layout1_time = set:getTimeNode("layout1_time")
    self._layout2_count = set:getLabelNode("layout2_count")
    self._updateBtn = set:getClickNode("updateBtn")
    self._bg_topBar_bg_label = set:getLabelNode("bg_topBar_bg_label")
    self._bg_topBar_btnHelp = set:getButtonNode("bg_topBar_btnHelp")
    self._bg_topBar_btnReturn = set:getButtonNode("bg_topBar_btnReturn")
    self._bg_topBar_tabChampion = set:getTabNode("bg_topBar_tabChampion")
    self._bg_topBar_tabRank = set:getTabNode("bg_topBar_tabRank")
    self._bg_topBar_tabShop = set:getTabNode("bg_topBar_tabShop")
--    self._@champion = set:getElfNode("@champion")
--    self._@node = set:getElfNode("@node")
--    self._@rank = set:getJoint9Node("@rank")
--    self._@item = set:getElfNode("@item")
--    self._@shop = set:getElfNode("@shop")
--    self._@line = set:getElfNode("@line")
--    self._@shopItem = set:getElfNode("@shopItem")
--    self._@starLayout = set:getLayoutNode("@starLayout")
--    self._@star = set:getElfNode("@star")
end
--@@@@]]]]

local Launcher = require 'Launcher'

Launcher.register('DRoadOfChampion',function ( userData )
	Launcher.callNet(netModel.getModelRoadOfChampionGetInfo(),function ( data )
		print(data)
		Launcher.Launching(data)   
	end)
end)

--------------------------------override functions----------------------
function DRoadOfChampion:onInit( userData, netData )
	local tabSize = 20
	if Config.LangName == "english" or Config.LangName == "Indonesia" then
		local maxW = 72
		self._set:getLabelNode("bg_topBar_tabChampion_normal_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_topBar_tabChampion_pressed_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_topBar_tabChampion_invalid_#title"):setDimensions(CCSize(0,0))

		self._set:getLabelNode("bg_topBar_tabRank_normal_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_topBar_tabRank_pressed_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_topBar_tabRank_invalid_#title"):setDimensions(CCSize(0,0))
		
		self._set:getLabelNode("bg_topBar_tabShop_normal_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_topBar_tabShop_pressed_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_topBar_tabShop_invalid_#title"):setDimensions(CCSize(0,0))

		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabChampion_normal_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabChampion_pressed_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabChampion_invalid_#title"),maxW)

		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabRank_normal_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabRank_pressed_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabRank_invalid_#title"),maxW)

		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabShop_normal_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabShop_pressed_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabShop_invalid_#title"),maxW)
	else
		require 'LangAdapter'.fontSize(self._set:getLabelNode("bg_topBar_tabChampion_normal_#title"),nil,nil,tabSize)
		require 'LangAdapter'.fontSize(self._set:getLabelNode("bg_topBar_tabChampion_pressed_#title"),nil,nil,tabSize)
		require 'LangAdapter'.fontSize(self._set:getLabelNode("bg_topBar_tabChampion_invalid_#title"),nil,nil,tabSize)

		require 'LangAdapter'.fontSize(self._set:getLabelNode("bg_topBar_tabRank_normal_#title"),nil,nil,tabSize)
		require 'LangAdapter'.fontSize(self._set:getLabelNode("bg_topBar_tabRank_pressed_#title"),nil,nil,tabSize)
		require 'LangAdapter'.fontSize(self._set:getLabelNode("bg_topBar_tabRank_invalid_#title"),nil,nil,tabSize)

		require 'LangAdapter'.fontSize(self._set:getLabelNode("bg_topBar_tabShop_normal_#title"),nil,nil,tabSize)
		require 'LangAdapter'.fontSize(self._set:getLabelNode("bg_topBar_tabShop_pressed_#title"),nil,nil,tabSize)
		require 'LangAdapter'.fontSize(self._set:getLabelNode("bg_topBar_tabShop_invalid_#title"),nil,nil,tabSize)
	end

	res.doActionDialogShow(self._bg)

	eventCenter.addEventFunc("OnAppStatChange", function ( state )
		if state == 2 then
			if self.showIndex == 3 then
				self:updateTimer()
			end
		end
	end, "DRoadOfChampion")

	self.mData = netData.D.Tower
	self:addBtnListener()
	self.showIndex = userData and userData.tabIndexSelected or 1
	if self.showIndex == 3 then
		self._bg_topBar_tabShop:trigger(nil)
	elseif self.showIndex == 1 then
		self._bg_topBar_tabChampion:trigger(nil)
	end
	require 'GuideHelper':check('DRoadOfChampion')

	self._bg_topBar_tabRank:setVisible(false)
	self._bg_topBar_tabShop:setPosition(self._bg_topBar_tabRank:getPosition())
end

function DRoadOfChampion:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function DRoadOfChampion:showRankView( ... )
	if not self.rankView then
		self:send(netModel.getModelRoadOfChampionGetRank(),function ( data )
			print(data)
			self.mainView[1]:setVisible(false)
			if self.shopView then
				self.shopView[1]:setVisible(false)
			end
			self.rankView = self:createLuaSet("@rank")
			self._bg_content:addChild(self.rankView[1])

			local rankList = data.D.Ranks
			-- table.sort(rankList,function ( a,b )
			-- 	return a.Top>b.Top
			-- end)
			self.rankView["list"]:getContainer():removeAllChildrenWithCleanup(true)
			for i=1,#rankList do
				local v = rankList[i]
				if v.Top>0 then
					local set = self:createLuaSet("@item")
					set["itemBg"]:setVisible(i%2==0)
					set["rank"]:setString(string.format("NO.%d",i))
					set["name"]:setString(v.Name)
					set["level"]:setString(v.Lv)
					set["title"]:setString(dbManager.getInfoTitleConfig(v.TitleId).Name)
					local mode,layer =0,0
					if v.Top>0 then
						mode,layer = (v.Top-1)/10+1,(v.Top-1)%10+1
					end
					set["count"]:setString(string.format("%d-%d",mode,layer))
					self.rankView["list"]:addListItem(set[1])
				end
			end
			self.rankView[1]:setVisible(true)
		end)
	else
		self.mainView[1]:setVisible(false)
		if self.shopView then
			self.shopView[1]:setVisible(false)
		end
		self.rankView[1]:setVisible(true)
	end
	self.showIndex = 2
end

function DRoadOfChampion:showShopView( ... )
	if not self.shopView then
		self:send(netModel.getmodelChampionShopGet(),function ( data )
			if self.mainView then
				self.mainView[1]:setVisible(false)
			end
			if self.rankView then
				self.rankView[1]:setVisible(false)
			end
			self.shopView = self:createLuaSet("@shop")
			require "LangAdapter".nodePos(self.shopView["#layout2"],nil,nil,ccp(221,-218),ccp(160,-189),ccp(120,-189),ccp(221,-218),ccp(221,-218))

			require "LangAdapter".LabelNodeAutoShrink(self.shopView["updateBtn_#label"],108)
			require "LangAdapter".nodePos(self.shopView["#curHasLayout"],nil,nil,nil,nil,nil,nil,nil,nil,nil,ccp(-369,-229))
			require "LangAdapter".nodePos(self.shopView["#layout1"],nil,nil,nil,nil,nil,nil,nil,nil,nil,ccp(-369,-175))
			require "LangAdapter".nodePos(self.shopView["#layout2"],nil,nil,nil,nil,nil,nil,nil,nil,nil,ccp(0,-199))

			self._bg_content:addChild(self.shopView[1])

			-- self.mData.Point = data.D.TopStore.Point
			self.mChampionShopItems = data.D.TopGoods
			self.mChampionShopRefreshCount = data.D.TopStore.Times
			self.shopView["curHasLayout_count1"]:setString(self.mData.Point)
			self.shopView["curHasLayout_count2"]:setString(require "UserInfo".getCoin())
			local config = dbManager.getDeaultConfig("TopStoreRefreshCosts")
			self.mShopRefreshPrice = config.Value[math.min(#config.Value,self.mChampionShopRefreshCount+1)]
			self.shopView["layout2_count"]:setString(self.mShopRefreshPrice)
			self:updateTimer()
			self:updateList()

			self.shopView["updateBtn"]:setListener(function ( ... )
				local user = require "UserInfo"
				if user.getCoin()<self.mShopRefreshPrice then
					require "Toolkit".showDialogOnCoinNotEnough()
				else
					local func = function (  )
						self:send(netModel.getmodelChampionShopRefresh(false),function ( data )
							print(data)
			                                  local coin = user.getCoin()
			                                  coin = coin - self.mShopRefreshPrice
			                                  user.setCoin(coin)
			                                  eventCenter.eventInput("UpdateGoldCoin")
			                               	self.mChampionShopItems = data.D.TopGoods
			                                  self:updateList()
			                                  self.mChampionShopRefreshCount = self.mChampionShopRefreshCount+1
							local config = dbManager.getDeaultConfig("TopStoreRefreshCosts")
							self.mShopRefreshPrice = config.Value[math.min(#config.Value,self.mChampionShopRefreshCount+1)]
							self.shopView["curHasLayout_count2"]:setString(require "UserInfo".getCoin())
							self.shopView["layout2_count"]:setString(self.mShopRefreshPrice)
						end)
					end
					if require 'Config'.LangName == 'kor' then
						GleeCore:showLayer('DConfirmNT',{content="진행하시겠습니까?",callback=func})
					else
						return func()
					end
				end
			end)

			self.shopView[1]:setVisible(true)
		end)
	else
		self.shopView["curHasLayout_count1"]:setString(self.mData.Point)
		self:updateList()
		if self.mainView then
			self.mainView[1]:setVisible(false)
		end
		if self.rankView then
			self.rankView[1]:setVisible(false)
		end
		self.shopView[1]:setVisible(true)
	end
	self.showIndex = 3
end

function DRoadOfChampion:showMainView( ... )
	if self.rankView then
		self.rankView[1]:setVisible(false)
	end
	if self.shopView then
		self.shopView[1]:setVisible(false)
	end
	if not self.mainView then
		self.mainView = self:createLuaSet("@champion")
		self._bg_content:addChild(self.mainView[1])
		require 'LangAdapter'.LabelNodeAutoShrink(self.mainView["mode_modeIndex"],88)
		require 'LangAdapter'.LabelNodeAutoShrink(self.mainView["resetBtn_#label"],88)
		require 'LangAdapter'.LabelNodeAutoShrink(self.mainView["fastBtn_#label"],88)
		require 'LangAdapter'.fontSize(self.mainView["medalLayout_#medalLabel"],nil,nil,16,16,18)
		require 'LangAdapter'.fontSize(self.mainView["medalLayout_medalCount"],nil,nil,16,16,18)
	end
	self.mainView[1]:setVisible(true)

	self.mainView["medalLayout_medalCount"]:setString(self.mData.Point)

	self.mainView["mode_modeIndex"]:setString(string.format(res.locString("Activity$RoadOfChampionCurF"),self.mData.M))

	if self.mData.N == 10 then
		self.mCurIndex = 13
	else
		self.mCurIndex = self.mData.N+1+(self.mData.Boxs and #self.mData.Boxs or 0)
	end
	
	for i=1,13 do
		self:updateNode(i)
	end
	self:updateRoad()
	self:updateCurIndexArrows()
	self:updateBuffAdd()

	local lastCount = dbManager.getVipInfo(require "UserInfo".getVipLevel()).TopTowerRefreshTimes - self.mData.Rc
	self.mainView["bottom_lastCount"]:setString(string.format(res.locString("Activity$RoadOfChampionLastCount"),lastCount))
	self.mainView["resetBtn"]:setEnabled(lastCount>0)

	self.mainView["resetBtn"]:setListener(function ( ... )
		local func = function ( go2Next )
			self:send(netModel.getModelRoadOfChampionReset(go2Next),function ( data )
				print(data)
				self.mData = data.D.Tower
				self:showMainView()
			end)
		end
		GleeCore:showLayer('DChampionReset', {callBack = func, showNext = (self.mCurIndex >= 13)})
		-- if self.mCurIndex <13 then
		-- 	local param = {}
		-- 	param.content = res.locString("Activity$RoadOfChampionResetTip")
		-- 	param.callback = function ( ... )
		-- 		return func()
		-- 	end
		-- 	GleeCore:showLayer("DConfirmNT",param)
		-- else
		-- 	return func()
		-- end
	end)

	self.mainView["fastBtn"]:setVisible(self.mData.Top == self.mData.M * 10 and self.mData.IsRefreshThisFloor == true)
	self.mainView["fastBtn"]:setEnabled(self.mData.N ~= 10)

	local rechargeInfo = require "RechargeInfo".getData()
	local isFree = rechargeInfo.MCard and rechargeInfo.MCardLux
	local fastCost = dbManager.getInfoDefaultConfig( "TopTowerClearCost" ).Value
	self.mainView["fastBtn_cost"]:setString(isFree and res.locString("UserInfo$CostFree") or tostring(fastCost))
	self.mainView["fastBtn"]:setListener(function ( ... )
		local appFunc = require "AppData"

		local function topPass( ... )
			self:send(netModel.getModelTopPass(), function ( data )
				print(data)
				if data and data.D then
					appFunc.updateResource(data.D.Resource)
					res.doActionGetReward(data.D.Reward)

					self.mData = data.D.Tower
					self:showMainView()
				end
			end)
		end

		local vipUnLockLevel = dbManager.getTopTowerClearUnLockLv()
		if appFunc.getUserInfo().getVipLevel() >= vipUnLockLevel then
			if isFree then
				topPass()
			else
				if appFunc.getUserInfo().getCoin() >= fastCost then
					local param = {}
					param.content = string.format(res.locString("Activity$RoadOfChampion_fastOverTip"), fastCost)
					param.callback = function ( ... )
						topPass()
					end
					GleeCore:showLayer("DConfirmNT", param)
				else
					require "Toolkit".showDialogOnCoinNotEnough()
				end
			end
		else
			self:toast( string.format(res.locString("Activity$RoadOfChampion_clearUnLockTip"), vipUnLockLevel) )
		end
	end)

	if self.mData.N%3 == 0 and #self.mData.Buffs<self.mData.N/3 then--and self.mData.Play%3 == 0
		require "framework.sync.TimerHelper".tick(function ( ... )
			self:showBuffExchangeDialog()
			return true
		end)
	end

	CurIndex = self.mData.N+1

	self.showIndex = 1
end

function DRoadOfChampion:updateTimer( )
	local t = require "TimeManager".getCurrentSeverDate()
	-- local nextH = t.hour%2==0 and t.hour+2 or t.hour+1
	-- local lasttime = (nextH - t.hour)*3600 - t.min*60 - t.sec
	local lasttime
	if t.hour<21 then
		lasttime = (21 - t.hour)*3600 - t.min*60 - t.sec
	else
		lasttime = 21*3600 + (24 - t.hour)*3600 - t.min*60 - t.sec
	end
	self.shopView["layout1_time"]:setHourMinuteSecond(require "TimeListManager".getTimeInfoBySeconds(lasttime))
	self.shopView["layout1_time"]:setUpdateRate(-1)
	if not self.mTimeListener then
		self.mTimeListener = ElfDateListener:create(function ( ... )
			self.mTimeListener = nil
			self.shopView["layout1_time"]:setUpdateRate(0)
			self:send(netModel.getmodelChampionShopRefresh(true),function ( data )
				print(data)
				self.mChampionShopItems = data.D.TopGoods
				self:updateList()
				self:updateTimer()
			end)
		end)
		self.mTimeListener:setHourMinuteSecond(0,0,0)
		self.shopView["layout1_time"]:addListener(self.mTimeListener)
	end
end

function DRoadOfChampion:updateList( x,y )
	self.shopView["listbg_list"]:getContainer():removeAllChildrenWithCleanup(true)
	local index = 0
	local line
	table.foreach(self.mChampionShopItems,function ( _,v )
		local set = self:createLuaSet("@shopItem")
		if index%4 == 0 then
			line = self:createLuaSet("@line")
			self.shopView["listbg_list"]:addListItem(line[1])
		end
		line["layout"]:addChild(set[1])
		index = index + 1

		local buyFunc

		-- local count = v.IsEx and 0 or 1
		-- set["bg_count"]:setString(string.format(res.locString("Global$BuyLimitTip"),count))
		-- if count<=0 then
		-- 	set["bg_count"]:setFontFillColor(res.color4F.red,true)
		-- end
		set["bg_count"]:setVisible(false)

		set["bg_linearlayout_icon"]:setResid("N_GJ_tubiao_huizhang.png")
		set["bg_linearlayout_price"]:setString(v.Price)
		local enable = true
		local enough = self.mData.Point>=v.Price
		if not enough then
			set["bg_linearlayout_price"]:setFontFillColor(res.color4F.red,true)
			enable = false
		end
		if v.IsEx then
			-- set["layout_buyCount"]:setFontFillColor(res.color4F.red,true)
			set["bg_buyBtn_label"]:setString(res.locString("Activity$MagicShopHasBuy"))
			enable = false
		end
		local name
		if enable then
			buyFunc = function ( ... )
				local param = {}
				param.content = string.format(res.locString("Activity$MagicShopBuyConfirm"),"GJ_tubiao_huizhang.png",v.Price,name)
				print(param.content)
				param.callback = function ( ... )
					self:send(netModel.getmodelChampionShopBuy(v.Id),function ( data )
						print(data)
						local appFunc = require "AppData"
						appFunc.updateResource(data.D.Resource)
						v.IsEx = true
						self.mData.Point = self.mData.Point - v.Price
						self.shopView["curHasLayout_count1"]:setString(self.mData.Point)
						self.shopView["curHasLayout_count2"]:setString(require "UserInfo".getCoin())
						self:updateList(self.shopView["listbg_list"]:getContainer():getPosition())
						GleeCore:showLayer("DGetReward", data.D.Reward)
					end)
				end
				GleeCore:showLayer("DConfirmNT",param)
			end
			set["bg_buyBtn"]:setListener(function ( ... )
				buyFunc()
			end)
		else
			set["bg_buyBtn"]:setEnabled(false)
		end
		-- if index == 1 then
		-- 	self._firstBtn = set['bg_buyBtn']
		-- end
		if v.Type == 6 or v.Type == 10 then--pet
			local pet = require "PetInfo".getPetInfoByPetId(v.ItemId)
			res.setPetDetail(set["bg_icon"],pet,v.Type == 10)
			name = pet.Name
			if v.Type == 10 then
				name = name..res.locString("Global$Fragment")
			end
			set["bg_name"]:setString(name)
			local starLayout = self:createLuaSet("@starLayout")[1]
			require "PetNodeHelper".updateStarLayout(starLayout,nil,v.ItemId)
			-- for j=1,pet.Star do
			-- 	local star = self:createLuaSet("@star")[1]
			-- 	star:setResid(res.getStarResid(0))
			-- 	starLayout:addChild(star)
			-- end
			set["#bg"]:addChild(starLayout)
			set["bg_iconBtn"]:setListener(function ( ... )
				GleeCore:showLayer("DPetDetailV",{PetInfo = pet})
			end)
		elseif v.Type == 7 then--equip
			local equip = require "EquipInfo".getEquipInfoByEquipmentID(v.ItemId)
			res.setEquipDetail(set["bg_icon"],equip)
			name = equip.Name
			set["bg_name"]:setString(name)
			set["bg_name"]:setFontFillColor(res.getEquipColor(equip.Color),true)
			set["bg_iconBtn"]:setListener(function ( ... )
				GleeCore:showLayer("DEquipDetail",{nEquip = equip})
				-- GleeCore:showLayer("DEquipInfoWithNoGem",{EquipInfo = equip,FromShop = true,Callback = buyFunc,BtnText = set["bg_buyBtn_label"]:getString()})
			end)
		elseif v.Type == 8 then--gem
			local gem = require "GemInfo".getGemByGemID(v.ItemId,v.Lv)
			res.setGemDetail(set["bg_icon"],gem)
			name = string.format("%sLv%d",gem.Name,gem.Lv)
			set["bg_name"]:setString(name)
			set["bg_iconBtn"]:setListener(function ( ... )
				GleeCore:showLayer("DGemDetail",{GemInfo = gem,ShowOnly = true})
			end)
		elseif v.Type == 9 then--materials
			local material = require "BagInfo".getItemByMID(v.ItemId)
			res.setItemDetail(set["bg_icon"],material)
			local info = dbManager.getInfoMaterial(v.ItemId)
			name = info.name
			-- set["bg_name"]:setFontFillColor(ccc4f(0.97,0.66,0.07,1),true)
			set["bg_iconBtn"]:setListener(function ( ... )
				GleeCore:showLayer("DMaterialDetail",{materialId = v.ItemId})
			end)
		end
		name = string.format("%s x%d",name,v.Amount)
		set["bg_name"]:setString(name)

		require 'LangAdapter'.LabelNodeAutoShrink(set["bg_name"],165)

	end)
  	self.shopView["listbg_list"]:layout()
  	if x then
  		self.shopView["listbg_list"]:getContainer():setPosition(x,y)
  	end

  	-- require 'GuideHelper':registerPoint('兑换',self._firstBtn)
end

function DRoadOfChampion:addBtnListener( ... )
	self.close = function ( ... )
		eventCenter.resetGroup("DRoadOfChampion")
	end

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_topBar_btnHelp:setListener(function (  )
		GleeCore:showLayer("DHelp", {type = "冠军之塔"})
	end)
	self._bg_topBar_btnReturn:setTriggleSound(res.Sound.back)
	self._bg_topBar_btnReturn:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_topBar_tabRank:setListener(function ( ... )
		self:showRankView()
	end)

	self._bg_topBar_tabChampion:setListener(function ( ... )
		self:showMainView()
	end)

	self._bg_topBar_tabShop:setListener(function ( ... )
		self:showShopView()
	end)
end

function DRoadOfChampion:updateNode( index )
	local curIndex = self.mCurIndex
	local root = self.mainView[string.format("nodes_n%d",index)]
	if not root then
		return 
	end
	local tlist = {[5] = 1,[9] = 2,[13] = 3}
	local node,nodeType--宝箱1，正常2，带buff3，boss4
	if root:getChildrenCount()==0 then
		node = self:createLuaSet("@node")[1]
		root:addChild(node)
	else
		node = root:getChildren():objectAtIndex(0)
	end
	tolua.cast(node, 'ElfNode')
	if index == 5 or index == 9 or index == 13 then
		nodeType = 1
	elseif index == 3 or index == 7 or index == 11 then
		nodeType = 3
	elseif index == 12 then
		nodeType = 4
	else
		nodeType = 2
	end

	local light,bg,buff,btn,text = node:findNodeByName("light"),node:findNodeByName("icon"),node:findNodeByName("buff"),node:findNodeByName("btn"),node:findNodeByName("text")
	tolua.cast(btn, 'ButtonNode')
	tolua.cast(text, 'LabelNode')

	if self.mData.N == 10 then
		light:setVisible(nodeType == 1 and not table.find(self.mData.Boxs, tlist[index]))
	else
		light:setVisible(nodeType == 1 and index>=curIndex)
	end
	
	if nodeType == 1 then
		bg:setResid(table.find(self.mData.Boxs, tlist[index]) and "N_GJ_baoxiang2.png" or "N_GJ_baoxiang1.png")
	elseif nodeType == 4 then
		bg:removeAllChildrenWithCleanup(true)
		bg:setResid(nil)
		if index>=curIndex then
			bg:setResid("N_GJ_didian_boss.png")
		else
			local temp = ElfGrayNode:create()
			temp:setResid("N_GJ_didian_boss.png")
			bg:addChild(temp)
		end
	else
		bg:setResid(index>curIndex and "N_GJ_didian1.png" or (index == curIndex and "N_GJ_didian2.png" or "N_GJ_didian0.png"))
	end

	buff:setVisible(nodeType == 3)
	if nodeType == 3 then
		buff:setResid(index>=curIndex and "N_GJ_buff1.png" or "N_GJ_buff0.png")
	end

	local enable = index == curIndex or (index<curIndex and nodeType ~=1 )
	if self.mData.Top == self.mData.M * 10 and self.mData.N == 10 then
		enable = not table.find(self.mData.Boxs, tlist[index])
	end
	btn:setTouchEnable(enable)
	if enable then
		if nodeType == 1 then
			btn:setListener(function ( ... )
				self:send(netModel.getModelRoadOfChampionGetBoxReward(tlist[index]),function ( data )
					print(data)
					local appFunc = require "AppData"
					appFunc.updateResource(data.D.Resource)
					if data.D.Point then
						self.mData.Point = self.mData.Point + data.D.Point
						self.mainView["medalLayout_medalCount"]:setString(self.mData.Point)
					end
					self.mData.Boxs = self.mData.Boxs or {}
					table.insert(self.mData.Boxs, tlist[index])
					if self.mData.N ~= 10 then
						self.mCurIndex = self.mCurIndex + 1
					end
					self:updateNode(index)

					local reward = data.D.Reward
					if #self.mData.Boxs < 3 then
						if index < 13 then
							self:updateNode(index+1)
							self:updateRoad(index)
						end
					else
						reward.callback = function ( ... )
							local animBg = RectangleNode:create()
							animBg:setContentSize(CCSize(1136*2,640*2))
							animBg:setColorf(0, 0, 0, 0.6)
							self._bg:addChild(animBg)

							local Swf = require 'framework.swf.Swf'
							local myswf = Swf.new('Swf_TongGuan')
							self._bg:addChild( myswf:getRootNode() )
							local shapeMap = {
								['shape-4'] = 'FB_clear_di.png',
								['shape-6'] = 'FB_clear_1.png',
								['shape-8'] = 'FB_clear_2.png',
								['shape-10'] = 'FB_clear_3.png',
								['shape-12'] = 'FB_clear_4.png',
								['shape-14'] = 'FB_clear_5.png',
								['shape-16'] = 'FB_clear_6.png',
							}
							myswf:play(shapeMap, nil, function ( ... )
								myswf:getRootNode():removeFromParentAndCleanup(true)
								animBg:removeFromParentAndCleanup(true)
								if dbManager.getVipInfo(require "UserInfo".getVipLevel()).TopTowerRefreshTimes - self.mData.Rc>0 then
									self:toast(string.format(res.locString("Activity$RoadOfChampion_clearTip1"),self.mData.M))
								else
									self:toast(string.format(res.locString("Activity$RoadOfChampion_clearTip2"),self.mData.M))
								end
							end)
						end
					end
					GleeCore:showLayer("DGetReward", reward)
					
					self:updateCurIndexArrows()
				end)
			end)
		else
			btn:setListener(function ( ... )
				--show NPC info
				local function getStageIndex( index )
					if index >9 then
						return index - 2
					elseif index>5 then
						return index - 1
					else
						return index
					end
				end
				GleeCore:showLayer("DActivityChampionNpcDetail", {Data = self.mData,Index = getStageIndex(index)})
			end)
		end
	end

	local textVisible = index<=curIndex and (nodeType == 2 or nodeType == 3)
	text:setVisible(textVisible)
	if textVisible then
		text:setString(index<6 and index or (index<10 and index - 1 or index - 2))
	end
end

function DRoadOfChampion:updateRoad( start )
	local start = start or 1
	for i=start,12 do
		local points = self.mainView[string.format("points_p%d",i)]:getChildren()
		for j=0,points:count()-1 do
			local node = points:objectAtIndex(j)
			tolua.cast(node,"ElfNode")
			node:setResid(i < math.min(13,self.mCurIndex) and "N_GJ_lujing2.png" or "N_GJ_lujing1.png")
		end
	end
end

function DRoadOfChampion:updateCurIndexArrows( ... )
	self.mainView["currentIcon"]:setVisible(self.mCurIndex<=13)
	if self.mCurIndex<=13 then
		local root = self.mainView[string.format("nodes_n%d",self.mCurIndex)]
		local curNode = root:getChildren():objectAtIndex(0)
		tolua.cast(curNode,"ElfNode")
		local x,y =  root:getPosition()
		local temp = curNode:findNodeByName("icon")
		y = y + temp:getContentSize().height/2
		self.mainView["currentIcon"]:setPosition(x+3,y+2)
	end
end

function DRoadOfChampion:updateBuffAdd( ... )
	local atkAdd,defAdd = 0,0
	for _,v in ipairs(self.mData.Buffs) do
		if v.Type == 1 then
			atkAdd = atkAdd + v.Rate*100
		elseif v.Type == 2 then
			defAdd = defAdd + v.Rate*100
		end
	end
	self.mainView["bottom_buffAdd"]:setString(string.format(res.locString("Activity$RoadOfChampionBuffAdd"),atkAdd,defAdd))
end

function DRoadOfChampion:showBuffExchangeDialog( )
	local param = {}
	param.BuffList = self.mData.Rs
	param.OnBuffExchange = function ( data )
		self.mData = data
		self:updateBuffAdd()
	end
	GleeCore:showLayer("DBuffExchangeForRoadOfChampion",param)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DRoadOfChampion, "DRoadOfChampion")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DRoadOfChampion", DRoadOfChampion)

eventCenter.addEventFunc(require 'FightEvent'.Pve_ChampionResult, function ( data )
	print("---------OnPveChampionResultGet----------")
	local userFunc = require "UserInfo"
	local gold = userFunc.getGold()
	userFunc.setGold(gold + data.D.Gold)
	eventCenter.eventInput("UpdateGoldCoin")
end)

eventCenter.addEventFunc(require 'FightEvent'.GameOver, function ( isWin )
	if not isWin then
		local mode,layer = (CurIndex-1)/10+1,(CurIndex-1)%10+1
		require 'BIHelper'.record('RoadOfChampion',string.format('%d,%d,Failed',mode,layer))
	end
end)
