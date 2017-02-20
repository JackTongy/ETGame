local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local netModel = require "netModel"
local eventCenter = require 'EventCenter'
local userFunc = require "UserInfo"

local plat = require 'framework.basic.Device'.platform
local RechargeConfig
if plat == "android" then
	RechargeConfig = require "ChargeConfig_and"
elseif plat == "ios" then
	RechargeConfig = require "ChargeConfig"
end
local petFunc = require "PetInfo"
local equipFunc = require "EquipInfo"
local gemFunc = require "GemInfo"
local bagFunc = require "BagInfo"
local TimerHelper = require 'framework.sync.TimerHelper'
local GuideHelper = require 'GuideHelper'

local t = require "vip"
local VipMax = #t - 1

local DRecharge = class(LuaDialog)

function DRecharge:createDocument()
	 self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DRecharge.cocos.zip")
	 return self._factory:createDocument("DRecharge.cocos")
end

--@@@@[[[[
function DRecharge:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_content = set:getElfNode("bg_content")
    self._titleBg = set:getElfNode("titleBg")
    self._titleBg_vipIcon = set:getElfNode("titleBg_vipIcon")
    self._titleBg_progressBg = set:getElfNode("titleBg_progressBg")
    self._titleBg_progressBg_progress = set:getProgressNode("titleBg_progressBg_progress")
    self._titleBg_progressBg_proLabel = set:getLabelNode("titleBg_progressBg_proLabel")
    self._titleBg_tip = set:getRichLabelNode("titleBg_tip")
    self._list = set:getListNode("list")
    self._layout = set:getLinearLayoutNode("layout")
    self._icon = set:getElfNode("icon")
    self._recommend = set:getElfNode("recommend")
    self._name = set:getLabelNode("name")
    self._des = set:getLabelNode("des")
    self._price = set:getElfNode("price")
    self._btn = set:getButtonNode("btn")
    self._bg = set:getElfNode("bg")
    self._titleBg = set:getElfNode("titleBg")
    self._titleBg_vipIcon = set:getElfNode("titleBg_vipIcon")
    self._titleBg_progressBg = set:getElfNode("titleBg_progressBg")
    self._titleBg_progressBg_progress = set:getProgressNode("titleBg_progressBg_progress")
    self._titleBg_progressBg_proLabel = set:getLabelNode("titleBg_progressBg_proLabel")
    self._titleBg_tip = set:getRichLabelNode("titleBg_tip")
    self._btnRecharge = set:getClickNode("btnRecharge")
    self._title_vipIcon = set:getElfNode("title_vipIcon")
    self._title_tip = set:getRichLabelNode("title_tip")
    self._bg_leftBtn = set:getButtonNode("bg_leftBtn")
    self._bg_rightBtn = set:getButtonNode("bg_rightBtn")
    self._bg_moveTipRight = set:getLinearLayoutNode("bg_moveTipRight")
    self._bg_moveTipRight_nextVip = set:getElfNode("bg_moveTipRight_nextVip")
    self._bg_clipSwip_pageSwip = set:getSwipNode("bg_clipSwip_pageSwip")
    self._bg_clipSwip_pageSwip_linearlayout = set:getLinearLayoutNode("bg_clipSwip_pageSwip_linearlayout")
    self._list = set:getListNode("list")
    self._point = set:getLabelNode("point")
    self._des = set:getRichLabelNode("des")
    self._bg_moveTipLeft = set:getLinearLayoutNode("bg_moveTipLeft")
    self._bg_moveTipLeft_nextVip = set:getElfNode("bg_moveTipLeft_nextVip")
    self._touchLayer = set:getLuaTouchNode("touchLayer")
    self._giftlayout = set:getLinearLayoutNode("giftlayout")
    self._icon = set:getElfNode("icon")
    self._count = set:getLabelNode("count")
    self._name = set:getLabelNode("name")
    self._btn = set:getButtonNode("btn")
    self._list = set:getListNode("list")
    self._tab = set:getTabNode("tab")
    self._name = set:getRichLabelNode("name")
    self._red = set:getElfNode("red")
    self._content = set:getElfNode("content")
    self._content_titleBg_layout_vip = set:getElfNode("content_titleBg_layout_vip")
    self._content_layout_price = set:getLabelNode("content_layout_price")
    self._content_btnGet = set:getClickNode("content_btnGet")
    self._content_btnGet_label = set:getLabelNode("content_btnGet_label")
    self._content_giftlayout = set:getLinearLayoutNode("content_giftlayout")
    self._icon = set:getElfNode("icon")
    self._count = set:getLabelNode("count")
    self._name = set:getLabelNode("name")
    self._btn = set:getButtonNode("btn")
    self._content_des = set:getElfNode("content_des")
    self._light = set:getElfNode("light")
    self._icon = set:getElfNode("icon")
    self._name = set:getLabelNode("name")
    self._count = set:getLabelNode("count")
    self._btn = set:getButtonNode("btn")
    self._starLayout = set:getLayoutNode("starLayout")
    self._bg_topBar_bg_label = set:getLabelNode("bg_topBar_bg_label")
    self._bg_topBar_btnReturn = set:getButtonNode("bg_topBar_btnReturn")
    self._bg_topBar_tabRecharge = set:getTabNode("bg_topBar_tabRecharge")
    self._bg_topBar_tabPrivilege = set:getTabNode("bg_topBar_tabPrivilege")
    self._bg_topBar_tabGift = set:getTabNode("bg_topBar_tabGift")
    self._bg_topBar_tabGift_red = set:getElfNode("bg_topBar_tabGift_red")
    self._rotate = set:getElfAction("rotate")
--    self._@recharge = set:getElfNode("@recharge")
--    self._@line = set:getElfNode("@line")
--    self._@item = set:getElfNode("@item")
--    self._@rechargeThai = set:getElfNode("@rechargeThai")
--    self._@privilege = set:getElfNode("@privilege")
--    self._@vipPrivilege = set:getElfNode("@vipPrivilege")
--    self._@perPrivilege = set:getElfNode("@perPrivilege")
--    self._@reward = set:getElfNode("@reward")
--    self._@gift = set:getElfNode("@gift")
--    self._@vipGiftCell = set:getElfNode("@vipGiftCell")
--    self._@reward1 = set:getElfNode("@reward1")
--    self._@itemT = set:getElfNode("@itemT")
--    self._@star = set:getElfNode("@star")
end
--@@@@]]]]

local Launcher = require 'Launcher'

Launcher.register('DRecharge',function ( userData )
	Launcher.callNet(netModel.getModelRechargeInfo(),function ( data )
		Launcher.Launching(data)   
	end)
end)

--------------------------------override functions----------------------
function DRecharge:onInit( userData, netData )
	selectLang(nil,nil,nil,nil,function (  )
		local maxW = 72

		self._set:getLabelNode("bg_topBar_tabRecharge_normal_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_topBar_tabRecharge_pressed_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_topBar_tabRecharge_invalid_#title"):setDimensions(CCSize(0,0))

		self._set:getLabelNode("bg_topBar_tabPrivilege_normal_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_topBar_tabPrivilege_pressed_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_topBar_tabPrivilege_invalid_#title"):setDimensions(CCSize(0,0))
		
		self._set:getLabelNode("bg_topBar_tabGift_normal_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_topBar_tabGift_pressed_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_topBar_tabGift_invalid_#title"):setDimensions(CCSize(0,0))
		
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabRecharge_normal_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabRecharge_pressed_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabRecharge_invalid_#title"),maxW)

		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabPrivilege_normal_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabPrivilege_pressed_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabPrivilege_invalid_#title"),maxW)

		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabGift_normal_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabGift_pressed_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabGift_invalid_#title"),maxW)
	end,nil,nil,nil,function (  )
		self._set:getLabelNode("bg_topBar_tabPrivilege_normal_#title"):setString("بلاتين")
		self._set:getLabelNode("bg_topBar_tabPrivilege_pressed_#title"):setString("بلاتين")
		self._set:getLabelNode("bg_topBar_tabPrivilege_invalid_#title"):setString("بلاتين")
	end)

	res.doActionDialogShow(self._bg,function ( ... )
		GuideHelper:registerPoint('特权',self._bg_topBar_tabPrivilege)
		GuideHelper:registerPoint('礼包',self._bg_topBar_tabGift)
		GuideHelper:check('DRecharge')
	end)

	eventCenter.addEventFunc("OnAppStatChange", function ( state )
		if state == 2 then
			self:refresh()
			self:send(netModel.getModelRoleCoin(),function ( data )
				print("CurrentCoin----->:"..data.D.Coin)
				userFunc.setCoin(data.D.Coin)
				eventCenter.eventInput("UpdateVipLevel")
			end)
		end
	end, "DRecharge")

	eventCenter.addEventFunc('UpdateRechargeInfo',function ( data )
		self:refresh()
		self:send(netModel.getModelRoleCoin(),function ( data )
			print("CurrentCoin----->:"..data.D.Coin)
			userFunc.setCoin(data.D.Coin)
			eventCenter.eventInput("UpdateVipLevel")
		end)
	end,'DRecharge')

	self:addBtnListener()

	self.showIndex = 0
	if require 'AccountHelper'.isItemOFF('Vip') then
		self._bg_topBar_tabPrivilege:setVisible(false)
		if userData and userData.ShowIndex == 2 then
			userData.ShowIndex = 1
		end
	end

	if require 'AccountHelper'.isItemOFF('VipPack') then
		self._bg_topBar_tabGift:setVisible(false)
		if userData and userData.ShowIndex == 3 then
			userData.ShowIndex = 1
		end
	end
	
	self:handler(netData,userData and userData.ShowIndex or 1)
end

function DRecharge:onBack( userData, netData )
	
end

function DRecharge:onRelease( ... )
	eventCenter.resetGroup("DRecharge")
end

--------------------------------custom code-----------------------------
function DRecharge:addBtnListener( ... )
	self.close = function ( ... )
		self:onRelease()
	end

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_topBar_btnReturn:setTriggleSound(res.Sound.back)
	self._bg_topBar_btnReturn:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_topBar_tabRecharge:setListener(function ( ... )
		self.showIndex = 1
		return self:updateView()
	end)

	self._bg_topBar_tabPrivilege:setListener(function ( ... )
		self.showIndex = 2
		GuideHelper:check('tabPrivilege')
		return self:updateView()
	end)

	self._bg_topBar_tabGift:setListener(function ( ... )
		self.showIndex = 3
		GuideHelper:check('tabGift')
		return self:updateView()
	end)

	if require 'AccountHelper'.isItemOFF('Recharge') then

		--to get back
		local lock = ElfNode:create()
		lock:setResid('QY_tubiao_suoding.png')
		lock:setScale(0.7)
		lock:setPosition(ccp(-31.0, 22.0))
		self._bg_topBar_tabRecharge:addChild(lock)

		local  btn = ButtonNode:create(nil, nil, nil)
		btn:setContentSize(CCSize(120, 70))
		--btn:setDebug(true)
		btn:setPosition(ccp(-425, -163))
		self._bg_topBar_tabRecharge:getParent():addChild(btn)
		self._bg_topBar_tabRecharge:setEnabled(false)

		btn:setListener(function ( ... )
			self:toast(res.locString("Recharge$RechargeClosed"))
		end)
	end
end

function DRecharge:handler( data,showIndex )
	print(data)
	self.info = data.D
	if not showIndex or showIndex == 1 then
		if require 'AccountHelper'.isItemOFF('Recharge') then
			self._bg_topBar_tabPrivilege:trigger(nil)
		else
			self._bg_topBar_tabRecharge:trigger(nil)	
		end
	elseif showIndex == 2 then
		self._bg_topBar_tabPrivilege:trigger(nil)
	elseif showIndex == 3 then
		self._bg_topBar_tabGift:trigger(nil)
	end
	self:updateRedTip()
end

function DRecharge:refresh( showIndex)
	self:send(netModel.getModelRechargeInfo(),function ( data )
		print("----------GetRechargeInfo-----------")
		print(data)
		local preRecharge = require "RechargeInfo".getData().ChargeTotal
		local rechargeInfo = {}
		rechargeInfo.ChargeTotal = data.D.ChargeTotal
		if preRecharge<data.D.ChargeTotal then
			self:toast(res.locString("Recharge$RechargeSuccuess"))
		end
		rechargeInfo.Vip = data.D.Vip
		rechargeInfo.Charges = data.D.Charges
		rechargeInfo.MCard = data.D.MCard
		rechargeInfo.MCardLux = data.D.MCardLux
		rechargeInfo.FcRewardGot = data.D.FcRewardGot
		require "RechargeInfo".setData(rechargeInfo)
		userFunc.setVipLevel(data.D.Vip)
		self:handler(data,showIndex)
	end)
end

function DRecharge:updateView( ... )
	if self.showIndex == 1 then
		if self.privilegeView then
			self.privilegeView[1]:setVisible(false)
		end
		if self.giftView then
			self.giftView[1]:setVisible(false)
		end
		if self.rechargeViewThai then
			self.rechargeViewThai[1]:setVisible(false)
		end
		if Config.InfoName == 'IOS_Phone_thai_in' or Config.LangName == "vn" then
			self:showRechargeViewThai()
		else
			self:showRechargeView()
		end
	elseif self.showIndex == 2 then
		if self.rechargeView then
			self.rechargeView[1]:setVisible(false)
		end
		if self.giftView then
			self.giftView[1]:setVisible(false)
		end
		if self.rechargeViewThai then
			self.rechargeViewThai[1]:setVisible(false)
		end
		self:showPrivilegeView()
	elseif self.showIndex == 3 then
		if self.rechargeView then
			self.rechargeView[1]:setVisible(false)
		end
		if self.privilegeView then
			self.privilegeView[1]:setVisible(false)
		end
		if self.rechargeViewThai then
			self.rechargeViewThai[1]:setVisible(false)
		end
		self:showGiftView()
	end
end

function DRecharge:showRechargeView( ... )
	if not self.rechargeView then
		self.rechargeView = self:createLuaSet("@recharge")
		self._bg_content:addChild(self.rechargeView[1])
	end

	self._bg_topBar_bg_label:setString(res.locString("Global$BtnRecharge"))

	local vip = self.info.Vip
	self.rechargeView["titleBg_vipIcon"]:setResid(string.format("N_CZ_vip%d.png",vip))
	local now = self.info.ChargeTotal
	local need = dbManager.getVipInfo(math.min(vip+1,VipMax)).Charge
	self.rechargeView["titleBg_progressBg_progress"]:setPercentage(now/need*100)
	self.rechargeView["titleBg_progressBg_proLabel"]:setString(string.format("%d/%d",now,need))
	self.rechargeView["titleBg_tip"]:setVisible(vip<VipMax)
	if vip<VipMax then
		self.rechargeView["titleBg_tip"]:setString(string.format(res.locString("Recharge$RechargeTip"),need-now,vip+1))
		require "LangAdapter".fontSize(self.rechargeView["titleBg_tip"],nil,nil,nil,nil,20)
		require 'LangAdapter'.LabelNodeAutoShrink(self.rechargeView["titleBg_tip"],368)
	end

	if require 'AccountHelper'.isItemOFF('Vip') then
		self.rechargeView["titleBg_vipIcon"]:setVisible(false)
		self.rechargeView["titleBg_progressBg"]:setVisible(false)
		self.rechargeView["titleBg_tip"]:setVisible(false)
	end

	self.rechargeView["list"]:getContainer():removeAllChildrenWithCleanup(true)
	local recommendPrio = 0
	self.itemIndex = 0

	if not require 'AccountHelper'.isItemOFF('MCardLux') and not self.info.MCardLux then
		local title = nil
		local coinresid = nil
		local des = ''
		if require 'AccountHelper'.isItemOFF('MCardName') then
			coinresid='N_CZ_tubiao6.png'
			title = string.format('600%s',res.locString('Global$Coin'))
		else
			des = res.locString("Recharge$MonthCardLuxDes")
			title = res.locString("Recharge$MonthCardLuxName")
		end

		recommendPrio = 1
		local conf = RechargeConfig[#RechargeConfig]
		self:addRechargeItem(conf.Id,title,des,conf.Money,"recharge_new_53.png",coinresid)
	end

	if not self.info.MCard then
		local title = nil
		local coinresid = nil
		local des = ''
		if require 'AccountHelper'.isItemOFF('MCardName') then
			coinresid='N_CZ_tubiao6.png'
			title = string.format('300%s',res.locString('Global$Coin'))
		else
			des = res.locString("Recharge$MonthCardDes")
			title = res.locString("Recharge$MonthCardName")
		end

		recommendPrio = 1
		local conf = RechargeConfig[#RechargeConfig-1]
		self:addRechargeItem(conf.Id,title,des,conf.Money,"recharge_new_53.png",coinresid)
	end

	recommendPrio = self:hasFc() and 2 or 3

	if Config.LangName == "Arabic" then
		for i=#RechargeConfig-2,1,-1 do
			local conf = RechargeConfig[i]
			if conf.Id ~= 7 then
				local name = conf.Amt .." " .. res.locString("Global$SpriteStone")
				require 'LangAdapter'.selectLangkv({German=function ( ... )
			        name = conf.Amt .." " .. "Juwelen"
			    end})
				local hasFc = self:hasFcByConf(conf)
				local des
				if hasFc then
					des = string.format(res.locString("Recharge$RechargeItemDes"),conf.Fc)..res.locString("Recharge$RechargeItemDesSuffix")
				else
					des = conf.Lc>0 and string.format(res.locString("Recharge$RechargeItemDes"),conf.Lc)
				end
				local isRecommend = recommendPrio>1 and (hasFc or (recommendPrio == 3 and conf.Money<conf.Lc))
				self:addRechargeItem(conf.Id,name,des,conf.Money,isRecommend and (hasFc and "recharge_new_51.png" or "recharge_new_53.png") or "")
			end
		end
	else
		for i=#RechargeConfig-2,1,-1 do
			local conf = RechargeConfig[i]
			local name = conf.Amt .." " .. res.locString("Global$SpriteStone")
			require 'LangAdapter'.selectLangkv({German=function ( ... )
		        name = conf.Amt .." " .. "Juwelen"
		    end})
			local hasFc = self:hasFcByConf(conf)
			local des
			if hasFc then
				des = string.format(res.locString("Recharge$RechargeItemDes"),conf.Fc)..res.locString("Recharge$RechargeItemDesSuffix")
			else
				des = conf.Lc>0 and string.format(res.locString("Recharge$RechargeItemDes"),conf.Lc)
			end
			local isRecommend = recommendPrio>1 and (hasFc or (recommendPrio == 3 and conf.Money<conf.Lc))
			self:addRechargeItem(conf.Id,name,des,conf.Money,isRecommend and (hasFc and "recharge_new_51.png" or "recharge_new_53.png") or "")
		end
	end
	self.rechargeView[1]:setVisible(true)
end

function DRecharge:showPrivilegeView( ... )
	if not self.privilegeView then
		self.privilegeView = self:createLuaSet("@privilege")
		
		require "LangAdapter".LabelNodeAutoShrink(self.privilegeView["title_#label"],115)
		require "LangAdapter".LabelNodeAutoShrink(self.privilegeView["title_tip"],500)

		self:addVipPrivileges()
		self._bg_content:addChild(self.privilegeView[1])
	end

	self._bg_topBar_bg_label:setString(res.locString("Recharge$VipPrivilege"))
	
	self.privilegeView[1]:setVisible(true)
end

function DRecharge:showGiftView( ... )
	if not self.giftView then
		self.giftView = self:createLuaSet("@gift")

		require "LangAdapter".LabelNodeAutoShrink(self.giftView["content_btnGet_label"],110)

		self.giftViewSets = {}
		local t = self:getVipGiftStatus()
		table.sort(t,function ( a,b )
			if a.Status == b.Status then
				return a.Vip<b.Vip
			else
				return a.Status<b.Status
			end
		end)
		for i,v in ipairs(t) do
			self:createGiftCell(v.Vip,v.Status)
			if i == 1 then
				self.giftViewSets[v.Vip]["tab"]:trigger(nil)
			end
		end
		self._bg_content:addChild(self.giftView[1])
	else
		local t = self:getVipGiftStatus()
		for _,v in ipairs(t) do
			self:updateGiftStatus(v.Vip,v.Status)
		end
	end

	self._bg_topBar_bg_label:setString(res.locString("Recharge$VipGift"))

	self.giftView[1]:setVisible(true)
end


--status:3-got 1-enable 2-unable
function DRecharge:getVipGiftStatus( ... )
	local t = {}
	local record = require "ItemMallInfo".getBuyRecord()
	for i=0,self.info.Vip do
		t[#t+1] = {Vip = i,Status = (record.Vips and table.find(record.Vips,i)) and 3 or 1}
	end
	for i=self.info.Vip+1,math.min(VipMax,self.info.Vip+6) do
		t[#t+1] = {Vip = i,Status = 2}
	end
	return t
end

function DRecharge:createGiftCell( vip,status )
	local set = self:createLuaSet("@vipGiftCell")
	require 'LangAdapter'.LabelNodeAutoShrink(set["name"],180)
	set["tab"]:setListener(function ( ... )
		self:updateGiftContentInfo(vip,status)
	end)
	self.giftViewSets[vip] = set
	self:updateGiftStatus(vip,status)
	self.giftView["list"]:addListItem(set[1])
end

function DRecharge:updateGiftContentInfo( vip,status )
	self.giftView["content_titleBg_layout_vip"]:setResid(string.format("N_VIP_tq_%d.png",vip))
	self.giftView["content_des"]:setResid(string.format("N_VIPLB_%d.png",vip))

	local rewardList = self:getVipRewards(vip)

	if not self.mGiftItemT then
		self.mGiftItemT = self:createLuaSet("@itemT")
		self.giftView["content"]:addChild(self.mGiftItemT[1])
	end
	self.mGiftItemT["light"]:runElfAction(self._rotate:clone()) 
	local rewardT = rewardList[1]
	self:createRewardItem(self.mGiftItemT,rewardT)
	if rewardT.itemtype == 6 or rewardT.itemtype == 10 then
		require "PetNodeHelper".updateStarLayout(self.mGiftItemT["starLayout"],nil,rewardT.itemid)
		self.mGiftItemT["starLayout"]:setVisible(true)
	else
		self.mGiftItemT["starLayout"]:setVisible(false)
	end

	self.giftView["content_giftlayout"]:removeAllChildrenWithCleanup(true)
	for i = 2,#rewardList do
		local gift = self:createLuaSet("@reward1")
		local v = rewardList[i]
		if v then
			gift["icon"]:setScale(0.55)
			gift["count"]:setVisible(true)
			gift["name"]:setVisible(true)
			gift["btn"]:setVisible(true)
			self:createRewardItem(gift,v)
			require "LangAdapter".LabelNodeAutoShrink(gift["name"],95)
		end
		require "LangAdapter".setVisible(gift["name"],nil,nil,false)
		require "LangAdapter".LabelNodeAutoShrink(gift["name"],90)
		self.giftView["content_giftlayout"]:addChild(gift[1])
	end

	local dbInfo = dbManager.getVipInfo(vip)
	local price = dbInfo.PackCost
	self.giftView["content_layout_price"]:setString(price)
	self.giftView["content_btnGet"]:setListener(function ( ... )
		if self.info.Vip<dbInfo.vip then
			return self:toast(string.format(res.locString("Recharge$GiftBuyLimit"),dbInfo.vip))
		elseif userFunc.getCoin() >= price then
			require "Toolkit".useCoinConfirm(function (  )
				self:send(netModel.getModelShopBuyVipGift(dbInfo.vip), function ( data )
					print("ShopBuy data:")
					print(data)
					if data and data.D then
						require "AppData".updateResource(data.D.Resource)
						local record = require "ItemMallInfo".getBuyRecord()
						record.Vips = record.Vips or {}
						table.insert(record.Vips,dbInfo.vip)
						local reward = data.D.Reward
						reward.callback = function ( ... )
							self:updateRedTip()
							self:updateGiftStatus(dbInfo.vip,3)
							self:updateGiftBuyBtnStatus(3)
						end
						GleeCore:showLayer("DGetReward", reward)
						eventCenter.eventInput("UpdateVipBuyRecord")
					end
				end)
			end)
		else
			return self:toast(res.locString("Recharge$CoinNotEnough"))
		end
	end)
	self:updateGiftBuyBtnStatus(status)
end

function DRecharge:updateGiftBuyBtnStatus( status )
	if status~=3 then
		self.giftView["content_btnGet"]:setEnabled(true)
		self.giftView["content_btnGet_label"]:setString(res.locString("Activity$MagicShopBuy"))
	else
		self.giftView["content_btnGet"]:setEnabled(false)
		self.giftView["content_btnGet_label"]:setString(res.locString("Activity$MagicShopHasBuy"))
	end
end

function DRecharge:updateGiftStatus( vip,status )
	if not self.giftViewSets[vip] then
		self:createGiftCell(vip,status)
	end
	local set = self.giftViewSets[vip]
	set["red"]:setVisible(status == 1)
	local s = res.locString("Recharge$GiftStatus"..status)
	if status ~= 2 then
		set["name"]:setString(s)
	else
		local now = self.info.ChargeTotal
		local need = dbManager.getVipInfo(vip).Charge
		set["name"]:setString(string.format(s,need-now))
	end
	set["tab"]:setListener(function ( ... )
		self:updateGiftContentInfo(vip,status)
	end)
end

function DRecharge:updateRedTip( ... )
	local record = require "ItemMallInfo".getBuyRecord()
	local hasBuyCount = record.Vips and #record.Vips or 0
	self._bg_topBar_tabGift_red:setVisible(self.info.Vip>=hasBuyCount)
end

function DRecharge:getVipRewards( vip )
	local rewardList = {}
	local dbInfo = dbManager.getVipInfo(vip)
	local r = dbInfo.PackRewards
	table.foreach(r,function ( _,id )
		local rewards = dbManager.getReward(id)
		table.foreach(rewards,function ( _,v )
			table.insert(rewardList,v)
		end)
	end)
	return rewardList
end

function DRecharge:needAnim( itemConfig )
	if itemConfig.itemtype == 7 then
		return true
	elseif itemConfig.itemtype == 6 or itemConfig.itemtype == 10 then
		if dbManager.getCharactor(itemConfig.itemid).star_level>5 then
			return true
		end
	else
		return false
	end
end

function DRecharge:createRewardItem( item,v )

	item["count"]:setString(string.format("x%d",v.amount))
	if self:needAnim(v) and item["isSuit"] then
		item["isSuit"]:setVisible(true)
	end
	if v.itemtype == 1 then
		item["icon"]:setResid("TY_jinbi_da.png")
		if v.amount>=10000 then
			if Config.LangName == "english" or Config.LangName == "German" then
				item["count"]:setString(string.format("x%dK",v.amount/1000))
			else
				item["count"]:setString(string.format("x%dw",v.amount/10000))
				local func = function ( ... )
					item["count"]:setString(string.format("x%dk",v.amount/1000))
				end

				require 'LangAdapter'.selectLangkv({Arabic=func,ES=func,PT=func})
			end
		end
		item["name"]:setString(res.locString("Global$Gold"))
	elseif v.itemtype == 2 then
		item["icon"]:setResid("TY_jinglingshi_da.png")
		item["name"]:setString(res.locString("Global$SpriteStone"))
	elseif v.itemtype == 6 or v.itemtype == 10 then
		local pet = petFunc.getPetInfoByPetId(v.itemid)
		res.setPetDetail(item["icon"],pet,v.itemtype == 10)
		if v.itemtype == 6 then
			item["name"]:setString(pet.Name)
		else
			item["name"]:setString(pet.Name..res.locString("Global$Fragment"))
		end
		item["btn"]:setListener(function ( ... )
			GleeCore:showLayer("DPetDetailV",{PetInfo = pet})
		end)
	elseif v.itemtype == 7 then
		local equip = equipFunc.getEquipInfoByEquipmentID(v.itemid)
		-- item["icon"]:setScale(0.5)
		res.setEquipDetail(item["icon"],equip)
		item["name"]:setString(equip.Name)
		item["btn"]:setListener(function ( ... )
			-- GleeCore:showLayer("DEquipInfoWithNoGem",{EquipInfo = equip})
			GleeCore:showLayer("DEquipDetail",{nEquip =equip})
		end)
	elseif v.itemtype == 8 then
		local gem = gemFunc.getGemByGemID(v.itemid)
		res.setGemDetail(item["icon"],gem)
		item["name"]:setString(gem.Name)
		item["btn"]:setListener(function ( ... )
			GleeCore:showLayer("DGemDetail",{GemInfo = gem,ShowOnly = true})
		end)
	elseif v.itemtype == 9 then
		local material = bagFunc.getItemByMID(v.itemid)
		res.setItemDetail(item["icon"],material)
		item["name"]:setString(dbManager.getInfoMaterial(v.itemid).name)
		item["btn"]:setListener(function ( ... )
			GleeCore:showLayer("DMaterialDetail",{materialId = v.itemid})
		end)
	end

	-- local vipoff = require 'AccountHelper'.isItemOFF('Vip')
	-- item['recommend']:setVisible(not vipoff)
	-- item['des']:setVisible(not vipoff)
end

function DRecharge:showVipGift( vip )
	local dbInfo = dbManager.getVipInfo(vip)	
	-- local dbInfo = dbManager.getInfoMaterial(mid)
	-- local price = dbInfo.PackCost
	-- local record = require "ItemMallInfo".getBuyRecord()
	-- local hasBuy = record.Vips and table.find(record.Vips,vip)

	-- self.privilegeView["rewardBg_layout_price"]:setString(price)
	-- if not hasBuy or self.info.Vip<dbInfo.vip then
	-- 	self.privilegeView["rewardBg_buyBtn"]:setEnabled(true)
	-- 	self.privilegeView["rewardBg_buyBtn_label"]:setString(res.locString("Activity$MagicShopBuy"))
	-- 	self.privilegeView["rewardBg_buyBtn"]:setListener(function ( ... )
	-- 		if self.info.Vip<dbInfo.vip then
	-- 			return self:toast(string.format("VIP%d可购买",dbInfo.vip))
	-- 		elseif userFunc.getCoin() >= price then
	-- 			self:send(netModel.getModelShopBuyVipGift(dbInfo.vip), function ( data )
	-- 				print("ShopBuy data:")
	-- 				print(data)
	-- 				if data and data.D then
	-- 					require "AppData".updateResource(data.D.Resource)
	-- 					record.Vips = record.Vips or {}
	-- 					table.insert(record.Vips,dbInfo.vip)
	-- 					GleeCore:showLayer("DGetReward", data.D.Reward)
	-- 					self.privilegeView["rewardBg_buyBtn"]:setEnabled(false)
	-- 					self.privilegeView["rewardBg_buyBtn_label"]:setString(res.locString("Activity$MagicShopHasBuy"))
	-- 				end
	-- 			end)
	-- 		else
	-- 			return self:toast("精灵石不足")
	-- 		end
	-- 	end)
	-- else
	-- 	self.privilegeView["rewardBg_buyBtn"]:setEnabled(false)
	-- 	self.privilegeView["rewardBg_buyBtn_label"]:setString(res.locString("Activity$MagicShopHasBuy"))
	-- end

	self.privilegeView["giftlayout"]:removeAllChildrenWithCleanup(true)
	--1：金币 2：钻石 3：精灵之魂 4：体力 5：经验 6：精灵 7：装备 8：宝石 9：道具
	table.foreach(self:getVipRewards(vip),function ( _,v )
		local item = self:createLuaSet("@reward")
		require "LangAdapter".setVisible(item["name"],nil,nil,false)
		self:createRewardItem(item,v)
		require "LangAdapter".LabelNodeAutoShrink(item["name"],100)
		self.privilegeView["giftlayout"]:addChild(item[1])
	end)
end

function DRecharge:updateSwipInfo( ... )
	if not self.privilegesSets[self.swipIndex].Load then
		self:addPrivilegeByVipLevel(self.swipIndex)
	end

	local vip = self.info.Vip
	self.privilegeView["title_vipIcon"]:setResid(string.format("N_CZ_vip%d.png",self.swipIndex))
	if vip<self.swipIndex then
		if vip < self.swipIndex-6 then
			self.privilegeView["title_tip"]:setVisible(false)
		else
			local now = self.info.ChargeTotal
			local need = dbManager.getVipInfo(self.swipIndex).Charge
			self.privilegeView["title_tip"]:setString(string.format(res.locString("Recharge$rpivilegeTip"),vip,need - now,self.swipIndex))
			self.privilegeView["title_tip"]:setVisible(true)
		end
	else
		self.privilegeView["title_tip"]:setString(string.format(res.locString("Recharge$rpivilegeTip1"),vip))
		self.privilegeView["title_tip"]:setVisible(true)
	end

	self:showVipGift(self.swipIndex)

	self.privilegeView["bg_leftBtn"]:setVisible(self.swipIndex>0)
	self.privilegeView["bg_rightBtn"]:setVisible(self.swipIndex<VipMax)

	if self.swipIndex<VipMax then
		self.privilegeView["bg_moveTipRight_nextVip"]:setResid(string.format("N_CZ_vip%d.png",self.swipIndex+1))
	end
	if self.swipIndex>0 then
		self.privilegeView["bg_moveTipLeft_nextVip"]:setResid(string.format("N_CZ_vip%d.png",self.swipIndex-1))
	end

	self.privilegeView["bg_moveTipRight"]:setVisible(self.swipIndex<VipMax)
	self.privilegeView["bg_moveTipLeft"]:setVisible(self.swipIndex>0)

	self.privilegeView["bg_clipSwip_pageSwip"]:setStayIndex(self.swipIndex)
end

function DRecharge:addVipPrivileges(  )
	local vip = math.min(VipMax,self.info.Vip)

	self.privilegesSets = {}

	for i=0,VipMax do
		local set = self:createLuaSet("@vipPrivilege")
		self.privilegeView["bg_clipSwip_pageSwip_linearlayout"]:addChild(set[1],0,i)
		set[1]:setVisible(true)
		local w = set[1]:getContentSize().width
		self.privilegeView["bg_clipSwip_pageSwip"]:addStayPoint(-w*i,0)
		self.privilegesSets[i] = {Set = set,Load = false}
		if i == vip then
			self:addPrivilegeByVipLevel(i)
		-- else
		-- 	self:runWithDelay(function ( ... )
		-- 		self:addPrivilegeByVipLevel(set,i)
		-- 	end,0.1*math.abs(vip-i)+1.5)
		end
	end
	self.swipIndex = vip
	self:updateSwipInfo()

	self.privilegeView["bg_leftBtn"]:setListener(function ( ... )
		self.swipIndex = self.swipIndex - 1
		self:updateSwipInfo()
	end)
	self.privilegeView["bg_rightBtn"]:setListener(function ( ... )
		self.swipIndex = self.swipIndex + 1
		self:updateSwipInfo()
	end)

	local mX,mY

	self.privilegeView["bg_clipSwip_pageSwip"]:setTouchEnable(false)
	self.privilegeView["touchLayer"]:setListener(function ( status, x, y )
		if status == 0 then -- touchDown
			mX = x
			mY = y
		elseif status == 2 then -- touchUp
			if mX and mY and self.privilegeView["touchLayer"]:isTouchInSize(x,y) then
				local dx,dy = x-mX,y-mY
				if math.abs(dx)>math.abs(dy) then
					if dx>100 then
						self.swipIndex = math.max(self.swipIndex - 1, 0)
						self:updateSwipInfo()
					elseif dx < -100 then
						self.swipIndex = math.min(self.swipIndex + 1, VipMax)
						self:updateSwipInfo()
					end
				end
			end
		end
	end)
end

function DRecharge:addPrivilegeByVipLevel( lv )
	local set = self.privilegesSets[lv].Set

	local vipInfo = dbManager.getVipInfo(lv)
	local privileges = vipInfo.Privilege
	table.foreach(string.split(privileges,"|"),function ( _,des )
		local item = self:createLuaSet("@perPrivilege")
		des = string.gsub(des,"%$(.-)%$",function ( x )
			return string.format(" [color=ffffffff]%s[/color] ",x)
		end)
		item["des"]:setString(des)
		local h = item["des"]:getContentSize().height+6
		item[1]:setContentSize(CCSize(460,h))
		item["point"]:setPosition(-224,h/2-8)
		set["list"]:addListItem(item[1])
	end)
	self.privilegesSets[lv].Load = true
end

local priceMap = {
	[1] = 0,[2] = 1,[3] = 2,[4] = 3,[5] = 4,[6] = 5,[7] = 6,[8] = 7
}

local iconMap = {
	[1] = 7,[2] = 6,[3] = 5,[4] = 4,[5] = 3,[6] = 2,[7] = 1,[8] = 8
}

local _LastPayTime

function DRecharge:addRechargeItem( proId,name,des,price,recomRes,iconresid )
	local item = self:createLuaSet("@item")
	item["icon"]:setResid(iconresid or string.format("N_CZ_tubiao%d.png",iconMap[proId]))

	-- selectLang(nil,nil,nil,function (  )
	-- 	if plat == "android" then
	-- 		name = string.format("%s(%s원)",name,string.formatNumberThousands(price))
	-- 	end
	-- end)
	item["name"]:setString(name)
	if not des then
		local x = item["name"]:getPosition()
		item["name"]:setPosition(x,select(2,item["btn"]:getPosition()))
	else
		item["des"]:setString(des)
	end
	require "LangAdapter".fontSize(item["des"],nil,nil,nil,nil,17)
	require "LangAdapter".nodePos(item["des"],nil,nil,nil,nil,nil,ccp(-64,-13))
	item["price"]:setResid(string.format("N_CZ_jiage%d.png",priceMap[proId]))
	item["recommend"]:setResid(recomRes)
	item["btn"]:setListener(function ( ... )
		if not _LastPayTime or os.time() -  _LastPayTime >3 then
			_LastPayTime = os.time()
			--serverid-roleid-proId-time
			local s = string.format("%d-%d-%d-%s",require "AccountInfo".getCurrentServerID(),userFunc.getId(),proId,os.time())
			local order = GleeUtils:MD5Lua(s,false)
			print(order)

			require "AndroidUtil".pay(des or name,order,1,proId,name,price,string.format("%d-%s",userFunc.getId(),"coin"..proId))
		end
	end)
	if self.itemIndex%2==0 then
		self.itemLine = self:createLuaSet("@line")
		self.rechargeView["list"]:addListItem(self.itemLine[1])
	end
	self.itemLine["layout"]:addChild(item[1])
	self.itemIndex = self.itemIndex + 1

	local vipoff = require 'AccountHelper'.isItemOFF('Vip')
	item['recommend']:setVisible(not vipoff)
	item['des']:setVisible(not vipoff)
end

function DRecharge:hasFcByConf( conf )
	return conf.Fc>conf.Lc and not(self.info.Charges and table.find(self.info.Charges,conf.Id))
end

function DRecharge:hasFc( ... )
	for _,v in pairs(RechargeConfig) do
		if self:hasFcByConf(v) then
			return true
		end
	end
	return false
end

-----------------------------------------------thai ver--------------------------------start
    -- self._titleBg = set:getElfNode("titleBg")
    -- self._titleBg_vipIcon = set:getElfNode("titleBg_vipIcon")
    -- self._titleBg_progressBg = set:getElfNode("titleBg_progressBg")
    -- self._titleBg_progressBg_progress = set:getProgressNode("titleBg_progressBg_progress")
    -- self._titleBg_progressBg_proLabel = set:getLabelNode("titleBg_progressBg_proLabel")
    -- self._titleBg_tip = set:getRichLabelNode("titleBg_tip")

function DRecharge:showRechargeViewThai( ... )
	if not self.rechargeViewThai then
		self.rechargeViewThai = self:createLuaSet("@rechargeThai")
		self._bg_content:addChild(self.rechargeViewThai[1])
	end

	self._bg_topBar_bg_label:setString(res.locString("Global$BtnRecharge"))

	local vip = self.info.Vip
	self.rechargeViewThai["titleBg_vipIcon"]:setResid(string.format("N_CZ_vip%d.png",vip))
	local now = self.info.ChargeTotal
	local need = dbManager.getVipInfo(math.min(vip+1,VipMax)).Charge
	self.rechargeViewThai["titleBg_progressBg_progress"]:setPercentage(now/need*100)
	self.rechargeViewThai["titleBg_progressBg_proLabel"]:setString(string.format("%d/%d",now,need))
	self.rechargeViewThai["titleBg_tip"]:setFontFillColor(ccc4f(0,0,1,0),true)
	self.rechargeViewThai["titleBg_tip"]:setVisible(vip<VipMax)
	if vip<VipMax then
		self.rechargeViewThai["titleBg_tip"]:setString(string.format(res.locString("Recharge$RechargeTip"),need-now,vip+1))
		require 'LangAdapter'.LabelNodeAutoShrink(self.rechargeViewThai["titleBg_tip"],340)
	end

	-- self.rechargeView["list"]:getContainer():removeAllChildrenWithCleanup(true)
	-- local recommendPrio = 0
	-- self.itemIndex = 0

	-- local canBuyMonthCard = not self.info.MCard
	-- if canBuyMonthCard then
	-- 	recommendPrio = 1
	-- 	local conf = RechargeConfig[#RechargeConfig]
	-- 	self:addRechargeItem(conf.Id,res.locString("Recharge$MonthCardName"),res.locString("Recharge$MonthCardDes"),conf.Money,"N_CZ_wenzi1.png",true)
	-- end

	-- recommendPrio = self:hasFc() and 2 or 3

	-- for i=#RechargeConfig-1,1,-1 do
	-- 	local conf = RechargeConfig[i]
	-- 	local name = conf.Amt .. res.locString("Global$SpriteStone")
	-- 	local hasFc = self:hasFcByConf(conf)
	-- 	local des
	-- 	if hasFc then
	-- 		des = string.format(res.locString("Recharge$RechargeItemDes"),conf.Fc)..res.locString("Recharge$RechargeItemDesSuffix")
	-- 	else
	-- 		des = conf.Lc>0 and string.format(res.locString("Recharge$RechargeItemDes"),conf.Lc)
	-- 	end
	-- 	local isRecommend = recommendPrio>1 and (hasFc or (recommendPrio == 3 and conf.Money<conf.Lc))
	-- 	self:addRechargeItem(conf.Id,name,des,conf.Money,isRecommend and (hasFc and "N_CZ_wenzi2.png" or "N_CZ_wenzi1.png") or "")
	-- end
	self.rechargeViewThai[1]:setVisible(true)
	self.rechargeViewThai['btnRecharge']:setListener(function()
		-- body
	end)
end

-----------------------------------------------thai ver--------------------------------end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DRecharge, "DRecharge")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DRecharge", DRecharge)


