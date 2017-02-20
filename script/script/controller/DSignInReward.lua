local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local gameFunc = require "AppData"
local netModel = require "netModel"
local taskLoginFunc = gameFunc.getTaskLoginInfo()
local broadCastFunc = require "BroadCastInfo"
local tabList = {["TabEveryday"] = 1, ["TabBetter"] = 2, ["TabCount"] = 2}

local DSignInReward = class(LuaDialog)

function DSignInReward:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DSignInReward.cocos.zip")
    return self._factory:createDocument("DSignInReward.cocos")
end

--@@@@[[[[
function DSignInReward:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_bg = set:getJoint9Node("commonDialog_cnt_bg")
    self._commonDialog_cnt_bg_layoutDes_des = set:getLabelNode("commonDialog_cnt_bg_layoutDes_des")
    self._commonDialog_cnt_bg_bg1 = set:getJoint9Node("commonDialog_cnt_bg_bg1")
    self._commonDialog_cnt_bg_list = set:getListNode("commonDialog_cnt_bg_list")
    self._layout = set:getLayoutNode("layout")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._count = set:getLabelNode("count")
    self._vip = set:getElfNode("vip")
    self._isGet = set:getElfNode("isGet")
    self._btn = set:getButtonNode("btn")
    self._isTodayReward = set:getElfNode("isTodayReward")
    self._commonDialog_cnt_better = set:getElfNode("commonDialog_cnt_better")
    self._commonDialog_cnt_better_tip = set:getRichLabelNode("commonDialog_cnt_better_tip")
    self._commonDialog_cnt_better_layout = set:getLayoutNode("commonDialog_cnt_better_layout")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._count = set:getLabelNode("count")
    self._piece = set:getElfNode("piece")
    self._btn = set:getButtonNode("btn")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._count = set:getLabelNode("count")
    self._piece = set:getElfNode("piece")
    self._btn = set:getButtonNode("btn")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._count = set:getLabelNode("count")
    self._piece = set:getElfNode("piece")
    self._btn = set:getButtonNode("btn")
    self._commonDialog_cnt_better_btnGet = set:getClickNode("commonDialog_cnt_better_btnGet")
    self._commonDialog_cnt_better_btnGet_title = set:getLabelNode("commonDialog_cnt_better_btnGet_title")
    self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
    self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
    self._commonDialog_tab = set:getLayoutNode("commonDialog_tab")
    self._commonDialog_tab_tab1 = set:getTabNode("commonDialog_tab_tab1")
    self._commonDialog_tab_tab1_title = set:getLabelNode("commonDialog_tab_tab1_title")
    self._commonDialog_tab_tab1_point = set:getElfNode("commonDialog_tab_tab1_point")
    self._commonDialog_tab_tab2 = set:getTabNode("commonDialog_tab_tab2")
    self._commonDialog_tab_tab2_title = set:getLabelNode("commonDialog_tab_tab2_title")
    self._commonDialog_tab_tab2_point = set:getElfNode("commonDialog_tab_tab2_point")
--    self._@size = set:getElfNode("@size")
--    self._@item = set:getElfNode("@item")
--    self._@itemBetter = set:getElfNode("@itemBetter")
--    self._@itemBetter = set:getElfNode("@itemBetter")
--    self._@itemBetter = set:getElfNode("@itemBetter")
end
--@@@@]]]]

--------------------------------override functions----------------------

local Launcher = require 'Launcher'
Launcher.register("DSignInReward", function ( userData )
 	Launcher.callNet(netModel.getModelLuxurySignGet(),function ( data )
 		if data and data.D then
 			Launcher.Launching(data)
 		end
 	end)
end)

function DSignInReward:onInit( userData, netData )
	if netData and netData.D then
		taskLoginFunc.setLuxurySign(netData.D.Sign)
	end

	self.tabIndexSelected = tabList.TabEveryday

	res.doActionDialogShow(self._commonDialog)
	self:setListenerEvent()
	self:updateLayer()

	-- 通知服务器去除签到红点，不用等待返回
	if broadCastFunc.get("sign_verify") and taskLoginFunc.getData().IsGot then
		self:sendBackground(netModel.getModelRoleNewsUpdate("sign_verify"))
	end

	gameFunc.getBroadCastInfo().set('sign_verify',false)
	require 'EventCenter'.eventInput('EventSignVerify')
end

function DSignInReward:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DSignInReward:setListenerEvent( ... )
	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._commonDialog, self)
	end)
	self._commonDialog_btnClose:setListener(function (  )
		res.doActionDialogHide(self._commonDialog, self)
	end)
	for i=1,tabList.TabCount do
		self[string.format("_commonDialog_tab_tab%d", i)]:setListener(function ( ... )
			if self.tabIndexSelected ~= i then
				self.tabIndexSelected = i
				self:updateLayer()
			end
		end)
	end
end

function DSignInReward:updateLayer( ... )
	self[string.format("_commonDialog_tab_tab%d", self.tabIndexSelected)]:trigger(nil)
	if self.tabIndexSelected == tabList.TabEveryday then
		self:updateEveryReward()
	elseif self.tabIndexSelected == tabList.TabBetter then
		self:updateBetterReward()
	end
	self:updateTabNameColor()

	self._commonDialog_cnt_bg:setVisible(self.tabIndexSelected == tabList.TabEveryday)
	self._commonDialog_cnt_better:setVisible(self.tabIndexSelected == tabList.TabBetter)

	local luxurySign = taskLoginFunc.getLuxurySign()
	self._commonDialog_tab_tab2_point:setVisible(luxurySign and luxurySign.State == 2)
end

function DSignInReward:updateTabNameColor(  )
	for i=1,tabList.TabCount do
		local titleNode = self[string.format("_commonDialog_tab_tab%d_title", i)]
		if self.tabIndexSelected == i then
			titleNode:setFontFillColor(res.tabColor2.selectedTextColor, true)
			titleNode:enableStroke(res.tabColor2.selectedStrokeColor, 2, true)
		else
			titleNode:setFontFillColor(res.tabColor2.unselectTextColor, true)
			titleNode:enableStroke(res.tabColor2.unselectStrokeColor, 2, true)
		end
	end
end

function DSignInReward:updateEveryReward( ... )
	-- 服务器当地时间凌晨5点刷新
	local month = os.date("*t", os.time(require "TimeManager".getCurrentSeverDate()) - 3600 * 5).month

	local dbSignInRewardList = dbManager.getSignConfig(month)
	if dbSignInRewardList then
		table.sort(dbSignInRewardList, function ( a, b )
			return a.day < b.day
		end)
		local taskLoginInfo = taskLoginFunc.getData()
		self._commonDialog_cnt_bg_layoutDes_des:setString(taskLoginInfo.SignTimes)
		
		self._commonDialog_cnt_bg_list:getContainer():removeAllChildrenWithCleanup(true)
		local countOneLine = 5
		local sizeSet
		for i,v in ipairs(dbSignInRewardList) do
			if i % countOneLine == 1 then
				sizeSet = self:createLuaSet("@size")
				self._commonDialog_cnt_bg_list:getContainer():addChild(sizeSet[1])
			end 
			local item = self:createLuaSet("@item")
			sizeSet["layout"]:addChild(item[1])
			self:updateCell(v, i, item)
		end
		self._commonDialog_cnt_bg_list:layout()
		self._commonDialog_cnt_bg_list:alignTo(math.floor(taskLoginInfo.SignTimes / countOneLine))
	end
end

function DSignInReward:updateBetterReward( ... )
	local cost = 60
	self._commonDialog_cnt_better_tip:setString( string.format(res.locString("SignInReward$BetterRewardDes"), cost) )
	self._commonDialog_cnt_better_tip:setFontFillColor(ccc4f(0, 0, 1, 0), true)
	self._commonDialog_cnt_better_layout:removeAllChildrenWithCleanup(true)
	local luxurySign = taskLoginFunc.getLuxurySign()
	if luxurySign then
		local list = res.getRewardResList(luxurySign.Reward)
		for i,v in ipairs(list) do
			local item = self:createLuaSet("@itemBetter")
			self._commonDialog_cnt_better_layout:addChild( item[1] )

			local scaleOrigal = 110 / 155
			item["bg"]:setResid(v.bg)
			item["bg"]:setScale(scaleOrigal)
			item["icon"]:setResid(v.icon)
			if v.type == "Pet" or v.type == "PetPiece" then
				item["icon"]:setScale(scaleOrigal * 140 / 95)
			else
				item["icon"]:setScale(scaleOrigal)
			end
			item["frame"]:setResid(v.frame)
			item["frame"]:setScale(scaleOrigal)
			item["count"]:setString(v.count)
			item["piece"]:setVisible(v.isPiece)
			item["btn"]:setListener(function ( ... )
				if v.eventData then
					GleeCore:showLayer(v.eventData.dialog, v.eventData.data)
				end
			end)
		end
	end

	self._commonDialog_tab_tab2_point:setVisible(luxurySign and luxurySign.State == 2)
	self._commonDialog_cnt_better_btnGet:setEnabled(luxurySign and luxurySign.State == 2)
	self._commonDialog_cnt_better_btnGet:setListener(function ( ... )
		self:send(netModel.getModelLuxurySignReceive(), function ( data )
			gameFunc.updateResource(data.D.Resource)
			res.doActionGetReward(data.D.Reward)

			self._commonDialog_tab_tab2_point:setVisible(false)
			self._commonDialog_cnt_better_btnGet:setEnabled(false)
			self:sendBackground(netModel.getModelRoleNewsUpdate("luxury_sign"))
			gameFunc.getBroadCastInfo().set('luxury_sign',false)
			require 'EventCenter'.eventInput("UpdatePoint")
		end)
	end)
end

function DSignInReward:updateCell( dbSignInReward, i, item)
	local taskLoginInfo = taskLoginFunc.getData()
	if i <= taskLoginInfo.SignTimes then
		item["bg"]:setResid("N_QD_bg2.png")
	else
		if (not taskLoginInfo.IsGot) and i == taskLoginInfo.SignTimes + 1 then
			item["bg"]:setResid("N_QD_bg0.png")
		else
			item["bg"]:setResid("N_QD_bg1.png")
		end
	end
	item["isGet"]:setVisible(i <= taskLoginInfo.SignTimes)
	item["count"]:setString(string.format("x%d", dbSignInReward.amount))
	item["vip"]:setVisible(dbSignInReward.vip > 0)
	if dbSignInReward.vip > 0 then
		item["vip"]:setResid(res.getTaskLoginVipIcon(dbSignInReward.vip))
	end
	item["isTodayReward"]:setVisible((not taskLoginInfo.IsGot) and i == taskLoginInfo.SignTimes + 1)
	item["btn"]:setListener(function (  )
		if (not taskLoginInfo.IsGot) and i == taskLoginInfo.SignTimes + 1 then
			self:send(netModel.getModelTLSign(), function ( data )
				if data and data.D then
					taskLoginInfo.IsGot = true
					gameFunc.updateResource(data.D.Resource)
					require 'EventCenter'.eventInput("UpdateGoldCoin")
					local dReward = data.D.Reward
					if dReward then
						taskLoginFunc.signInAddOne()
						self._commonDialog_cnt_bg_layoutDes_des:setString(taskLoginInfo.SignTimes)
						self:updateCell(dbSignInReward, i, item)
						GleeCore:showLayer("DGetReward", dReward)
					end
				end

				self:send(netModel.getModelRoleNewsUpdate("sign_verify"))
			end)
		else
			if dbSignInReward.type == 6 then -- 精灵
				GleeCore:showLayer("DPetDetailV", {PetInfo = gameFunc.getPetInfo().getPetInfoByPetId(dbSignInReward.item)})
			elseif dbSignInReward.type == 7 then -- 装备
				-- GleeCore:showLayer("DEquipInfoWithNoGem", {EquipInfo = gameFunc.getEquipInfo().getEquipInfoByEquipmentID(dbSignInReward.item)})
				GleeCore:showLayer("DEquipDetail",{nEquip = gameFunc.getEquipInfo().getEquipInfoByEquipmentID(dbSignInReward.item)})
			elseif dbSignInReward.type == 8 then -- 宝石
				GleeCore:showLayer("DGemDetail",{GemInfo = gameFunc.getGemInfo().getGemByGemID(dbSignInReward.item, dbSignInReward.lv, dbSignInReward.seconds), ShowOnly = true})
			elseif dbSignInReward.type == 9 then -- 道具
				if dbSignInReward.seconds > 0 then
					GleeCore:showLayer("DMaterialDetail", {materialId = dbSignInReward.item, Seconds = dbSignInReward.seconds, speed = 0})
				else
					GleeCore:showLayer("DMaterialDetail", {materialId = dbSignInReward.item})
				end
			elseif dbSignInReward.type == 10 then -- 精灵碎片
				GleeCore:showLayer("DPetDetailV", {PetInfo = gameFunc.getPetInfo().getPetInfoByPetId(dbSignInReward.item)})
			end
		end
	end)

	if dbSignInReward.type == 6 then -- 精灵
		res.setNodeWithPet(item["icon"], gameFunc.getPetInfo().getPetInfoByPetId( dbSignInReward.item ))
	elseif dbSignInReward.type == 7 then -- 装备
		local dbEquip = dbManager.getInfoEquipment(dbSignInReward.item)
		res.setNodeWithEquip(item["icon"], dbEquip)
	elseif dbSignInReward.type == 8 then -- 宝石
		local dbGem = dbManager.getInfoGem(dbSignInReward.item)
		res.setNodeWithGem(item["icon"], dbGem.gemid, dbSignInReward.lv)
	elseif dbSignInReward.type == 9 then -- 道具
		local dbMaterial = dbManager.getInfoMaterial(dbSignInReward.item)
		res.setNodeWithMaterial(item["icon"], dbMaterial)
	elseif dbSignInReward.type == 1 then -- 金币
		res.setNodeWithGold(item["icon"])
	elseif dbSignInReward.type == 2 then -- 精灵石
		res.setNodeWithCoin(item["icon"])
	elseif dbSignInReward.type == 10 then -- 精灵碎片
		res.setNodeWithPetPiece(item["icon"], gameFunc.getPetInfo().getPetInfoByPetId( dbSignInReward.item ))
	elseif dbSignInReward.type == 3 then -- 精灵之魂
		res.setNodeWithSoul(item["icon"])
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DSignInReward, "DSignInReward")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DSignInReward", DSignInReward)
