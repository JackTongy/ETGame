local Config = require "Config"
local netModel = require "netModel"
local res = require "Res"
local equipFunc = require "EquipInfo"
local gemFunc = require "GemInfo"
local userFunc = require "UserInfo"
local eventCenter = require 'EventCenter'
local UnlockManager = require "UnlockManager"
local GuideHelper = require 'GuideHelper'
local dbManager = require "DBManager"

local DActRaid = class(LuaDialog)

function DActRaid:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DActRaid.cocos.zip")
    return self._factory:createDocument("DActRaid.cocos")
end

--@@@@[[[[
function DActRaid:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_bg_list = set:getListNode("bg_bg_list")
    self._bg = set:getElfNode("bg")
    self._countLayout = set:getLinearLayoutNode("countLayout")
    self._countLayout_l1 = set:getLabelNode("countLayout_l1")
    self._countLayout_count = set:getLabelNode("countLayout_count")
    self._btn = set:getButtonNode("btn")
    self._name = set:getLabelNode("name")
    self._lootIcon = set:getElfNode("lootIcon")
    self._vipMoreTip = set:getLabelNode("vipMoreTip")
    self._shadow = set:getRectangleNode("shadow")
    self._lockView = set:getElfNode("lockView")
    self._lockView_linearlayout_tip = set:getLabelNode("lockView_linearlayout_tip")
    self._bg_topBar_btnHelp = set:getButtonNode("bg_topBar_btnHelp")
    self._bg_topBar_btnReturn = set:getButtonNode("bg_topBar_btnReturn")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

local Launcher = require 'Launcher'

Launcher.register('DActRaid',function ( userData )
	Launcher.callNet(netModel.getModelActRaidInfoGet(),function ( data )
		Launcher.Launching(data)   
	end)
end)

--------------------------------override functions----------------------
function DActRaid:onInit( userData, netData )
	res.doActionDialogShow(self._bg,function ( ... )
		require 'GuideHelper':registerPoint('关闭传送工厂',self._bg_topBar_btnReturn)
		require 'GuideHelper':check('DActRaid')
	end)

	self.mData = netData.D
	-- for k,v in pairs(self.mData.Copies) do
	-- 	v.TimesLeft = 0
	-- end
	self:addBtnListener()
	self:updateView()
end

function DActRaid:onBack( userData, netData )
	self:updateView()
end

local preListPosX

--------------------------------custom code-----------------------------
function DActRaid:addBtnListener( ... )
	self.close = function ( ... )
		preListPosX = self._bg_bg_list:getContainer():getPosition()
		require 'GuideHelper':check('DActRaidClose')
	end

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_topBar_btnHelp:setVisible(false)
	self._bg_topBar_btnHelp:setListener(function (  )
		GleeCore:showLayer("DHelp", {type = "活动副本"})
	end)
	self._bg_topBar_btnReturn:setTriggleSound(res.Sound.back)
	self._bg_topBar_btnReturn:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)
end

function DActRaid:getOrderedRaidConfig( ... )
	local roleLvMax = dbManager.getDeaultConfig("rolelvlimit").Value
	local t = {
		{Id = 1,Name = "GoldFuben",ResId = 1,OpenStatus = 0},
		{Id = 2,Name = "EquipFuben",ResId = 2,OpenStatus = 0,VipMore = {4,5,6}},
		{Id = 3,Name = "StoneFuben",ResId = 9,OpenStatus = 0,VipMore = {3,5,8},Price = 100},
		{Id = 4,Name = "EvolveFuben",ResId = 4,OpenStatus = 1},
		{Id = 5,Name = "EvolveFuben",ResId = 6,OpenStatus = 1},
		{Id = 6,Name = "EvolveFuben",ResId = 8,OpenStatus = 1},
		{Id = 7,Name = "EvolveFuben",ResId = 7,OpenStatus = 2},
		{Id = 8,Name = "EvolveFuben",ResId = 5,OpenStatus = 2},
	}

   if not require "UnlockManager":isOpen( "gongjiangzhixue" ) then
   	table.remove(t, 3)	-- 移除工匠之穴
   end

	table.sort(t,function ( a,b )
		local unlockLvA = UnlockManager:getUnlockLv(a.Name)
		local unlockLvB = UnlockManager:getUnlockLv(b.Name)
		if unlockLvA == unlockLvB then
			return a.Id<b.Id
		else
			return unlockLvA<unlockLvB
		end
	end)
	return t
end

function DActRaid:updateView( ... )
	table.sort(self.mData.Copies,function ( a,b )
		return a.Type<b.Type
	end)
	self._bg_bg_list:getContainer():removeAllChildrenWithCleanup(true)
	-- local lockName = {"GoldFuben","EquipFuben","GemFuben","EvolveFuben"}
	local points = {}
	-- local order = {2,1,4,5,6,7,8,3}
	-- local order = {2,4,5,6,7,8,1}
	-- local resMap = {1,2,3,4,6,8,7,5}
	-- local openStatus = {0,0,0,1,1,1,2,2}

	local hasCount = false

	for _,config in ipairs(self:getOrderedRaidConfig()) do
		local v = self.mData.Copies[config.Id]
		local set = self:createLuaSet("@item") 

		require 'LangAdapter'.LabelNodeAutoShrink(set["name"],150)
		require 'LangAdapter'.LabelNodeAutoShrink(set["vipMoreTip"],180)
		require 'LangAdapter'.LabelNodeAutoShrink(set["lockView_linearlayout_tip"],150)
		require 'LangAdapter'.fontSize(set["countLayout_l1"],nil,nil,20)
		require 'LangAdapter'.fontSize(set["countLayout_count"],nil,nil,20)
		require 'LangAdapter'.LayoutChildrenReverseifArabic(set["countLayout"])

		set["bg"]:setResid(string.format("N_HDFB_%d.png",config.ResId))
		set["name"]:setString(res.locString(string.format("Activity$ActRaid%d",config.Id)))
		set["lootIcon"]:setResid(string.format("N_HDFB_wenzi%d.png",config.ResId))
		local canBuyCount = 0	
		local hasMore
		local isUnlock = UnlockManager:isUnlock(config.Name)
		if isUnlock then
			set["lockView"]:setVisible(false)
			set["countLayout"]:setVisible(true)
			if v.TimesLeft>0 then
				set["countLayout_l1"]:setString(res.locString("Activity$ActRaidLastCount"))
				set["countLayout_count"]:setString(string.format(res.locString("Activity$ActRaidLastCountValue"),v.TimesLeft))
				set["countLayout_count"]:setFontFillColor(res.color4F.green,true)
				set["vipMoreTip"]:setVisible(false)
				hasCount = true
			else
				if config.VipMore and #config.VipMore>0 then
					local vip = userFunc.getVipLevel()
					for ii=1,#config.VipMore do
						local level = config.VipMore[ii]
						if level>vip then
							hasMore = level
							break
						else
							canBuyCount = canBuyCount + 1
						end
					end
				end
				if canBuyCount>v.BuyTimes then
					set["countLayout_l1"]:setString(res.locString("Activity$ActRaidLastBuyCount"))
					set["countLayout_count"]:setFontFillColor(res.color4F.green,true)
					set["countLayout_count"]:setString(string.format(res.locString("Activity$ActRaidLastCountValue"),canBuyCount-v.BuyTimes))
					-- set["countLayout_count"]:setString(canBuyCount-v.BuyTimes)
				elseif hasMore then
					set["countLayout_l1"]:setString(res.locString("Activity$ActRaidLastBuyCount"))
					set["countLayout_count"]:setString(string.format(res.locString("Activity$ActRaidLastCountValue"),canBuyCount-v.BuyTimes))
					-- set["countLayout_count"]:setString(canBuyCount-v.BuyTimes)
					set["countLayout_count"]:setFontFillColor(res.color4F.red,true)
					set["vipMoreTip"]:setString(string.format(res.locString("Activity$ActRaidVipMoreTip"),hasMore))
					set["vipMoreTip"]:setVisible(true)
				else
					set["countLayout_l1"]:setString(res.locString("Activity$ActRaidLastCount"))
					set["countLayout_count"]:setString(string.format(res.locString("Activity$ActRaidLastCountValue"),0))
					set["countLayout_count"]:setFontFillColor(res.color4F.red,true)

					set["vipMoreTip"]:setVisible(false)
				end
			end
			if config.OpenStatus ~= 0 then
				set["vipMoreTip"]:setVisible(true)
				set["vipMoreTip"]:setString(res.locString(string.format("Activity$ActRaidOpenTip%d",config.OpenStatus)))
				if not v.IsOpen then
					set["countLayout_l1"]:setString(res.locString("Activity$ActRaidNoOpenTip"))
					set["countLayout_count"]:setString("")
				end
			end
			set["shadow"]:setVisible(not v.IsOpen)
		else
			set["countLayout"]:setVisible(false)
			set["vipMoreTip"]:setVisible(false)
			set["lockView"]:setVisible(true)
			set["lockView_linearlayout_tip"]:setString( string.format(res.locString("Activity$ActRaidLockTip1"),UnlockManager:getUnlockLv(config.Name)))
		end
		points[config.Name]=set['btn']
		set["btn"]:setListener(function ( ... )
			if isUnlock then
				if v.IsOpen then
					preListPosX = self._bg_bg_list:getContainer():getPosition()
					if v.TimesLeft<=0 then
						if canBuyCount>v.BuyTimes then
							local param = {}
							local cost = config.Name == "StoneFuben" and config.Price or self:getBuyCountPrice()
							param.content = string.format(res.locString("Activity$ActRaidBuyContent"),cost,canBuyCount-v.BuyTimes)
							param.callback = function ( ... )
								self:send(netModel.getModelBuyResCopy(config.Id),function ( data )
							     		self.mData.Copies[config.Id] = data.D.Copy
							     		userFunc.setData(data.D.Role)
							     		return self:updateView()
								end)
							end
							GleeCore:showLayer("DConfirmNT",param)
						else
							if hasMore then
								local param = {}
								param.content = string.format(res.locString("Activity$ActRaidRechargeTip"),hasMore)
								param.RightBtnText = res.locString("Global$BtnRecharge")
								param.callback = function ( ... )
									GleeCore:showLayer("DRecharge")
								--	GleeCore:closeAllLayers()
								--	GleeCore:pushController("CRecharge", nil, nil, res.getTransitionFade())
								end
								GleeCore:showLayer("DConfirmNT",param)
							else
								return self:toast(res.locString("Activity$ActRaidNoCountTip"))
							end
						end
					else
						GuideHelper:check('showLayer')
						return GleeCore:showLayer("DActRaidLvSelect",{RaidInfo = v,RaidType = config.Id,Config = config})
					end
				else
					return self:toast(res.locString("Activity$ActRaidNoOpenTip"))
				end
			else
				return self:toast(UnlockManager:getUnlockConditionMsg(config.Name))
			end
		end)

		require "LangAdapter".fontSize(set["countLayout_l1"],nil,nil,nil,nil,20)
		require "LangAdapter".fontSize(set["countLayout_count"],nil,nil,nil,nil,20)

		self._bg_bg_list:addListItem(set[1])
	end

	if preListPosX then
		self._bg_bg_list:getContainer():setPosition(preListPosX,0)
	end

	for k,v in pairs(points) do
		GuideHelper:registerPoint(k,v)
	end
	
	if not hasCount then
		self:sendBackground(netModel.getModelRoleNewsUpdate("res_copy"))
	end
end

function DActRaid:getBuyCountPrice( ... )
	local power = require "UserInfo".getData().HiPwr
	if power<25000 then
		return 16
	elseif power<55000 then
		return 32
	else
		return 50
	end
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DActRaid, "DActRaid")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DActRaid", DActRaid)

eventCenter.addEventFunc(require 'FightEvent'.Pve_RewardFubenResult, function ( data )
		print("---------OnActRaidSuccess----------")
		print(data)
		require "AppData".updateResource(data.D.Resource)
		-- self.onBackHandler = function ( ... )
		-- 	view.mData.Copies[view.mSelectRaidType] = data.D.Copy
		-- 	return update1(self,view,view.mData)
		-- end
	end)
