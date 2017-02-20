local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local LuaList = require "LuaList"
local netModel = require "netModel"
local EventCenter = require "EventCenter"
local gameFunc = require "AppData"
local UnlockManager = require 'UnlockManager'
local HuntHelper = require "HuntHelper"

local userFunc = gameFunc.getUserInfo()
local petFunc = gameFunc.getPetInfo()
local teamFunc = gameFunc.getTeamInfo()
local GuildCopyFunc = gameFunc.getGuildCopyInfo()

local tabList = {
	["TabHunting"] = 1,
	["TabCamp"] = 2, 
	["TabTreasure"] = 3,
	["TabCount"] = 3,
}

local DHunt = class(LuaDialog)

function DHunt:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DHunt.cocos.zip")
    return self._factory:createDocument("DHunt.cocos")
end

--@@@@[[[[
function DHunt:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_page = set:getElfNode("commonDialog_cnt_page")
    self._bg1 = set:getElfNode("bg1")
    self._bg1_layoutChallenge_v = set:getLabelNode("bg1_layoutChallenge_v")
    self._bg1_btnPro1 = set:getClickNode("bg1_btnPro1")
    self._bg1_btnPro1_normal_title = set:getLabelNode("bg1_btnPro1_normal_title")
    self._bg1_btnPro1_pressed_title = set:getLabelNode("bg1_btnPro1_pressed_title")
    self._bg1_btnPro2 = set:getClickNode("bg1_btnPro2")
    self._bg1_btnPro2_normal_title = set:getLabelNode("bg1_btnPro2_normal_title")
    self._bg1_btnPro2_pressed_title = set:getLabelNode("bg1_btnPro2_pressed_title")
    self._bg1_btnPro3 = set:getClickNode("bg1_btnPro3")
    self._bg1_btnPro3_normal_title = set:getLabelNode("bg1_btnPro3_normal_title")
    self._bg1_btnPro3_pressed_title = set:getLabelNode("bg1_btnPro3_pressed_title")
    self._bg1_btnPro4 = set:getClickNode("bg1_btnPro4")
    self._bg1_btnPro4_normal_title = set:getLabelNode("bg1_btnPro4_normal_title")
    self._bg1_btnPro4_pressed_title = set:getLabelNode("bg1_btnPro4_pressed_title")
    self._bg1_btnPro5 = set:getClickNode("bg1_btnPro5")
    self._bg1_btnPro5_normal_title = set:getLabelNode("bg1_btnPro5_normal_title")
    self._bg1_btnPro5_pressed_title = set:getLabelNode("bg1_btnPro5_pressed_title")
    self._bg1_layoutBox = set:getLayoutNode("bg1_layoutBox")
    self._bg1_layoutBox_box1 = set:getElfNode("bg1_layoutBox_box1")
    self._bg1_layoutBox_box1_icon = set:getElfNode("bg1_layoutBox_box1_icon")
    self._bg1_layoutBox_box1_btn = set:getButtonNode("bg1_layoutBox_box1_btn")
    self._bg1_layoutBox_box1_base = set:getElfNode("bg1_layoutBox_box1_base")
    self._bg_bg0 = set:getElfNode("bg_bg0")
    self._pro = set:getLinearLayoutNode("pro")
    self._pro_l = set:getElfNode("pro_l")
    self._pro_pro0 = set:getElfNode("pro_pro0")
    self._pro_r = set:getElfNode("pro_r")
    self._percent = set:getLabelNode("percent")
    self._bg1_layoutBox_box2 = set:getElfNode("bg1_layoutBox_box2")
    self._bg1_layoutBox_box2_icon = set:getElfNode("bg1_layoutBox_box2_icon")
    self._bg1_layoutBox_box2_btn = set:getButtonNode("bg1_layoutBox_box2_btn")
    self._bg1_layoutBox_box2_base = set:getElfNode("bg1_layoutBox_box2_base")
    self._bg1_layoutBox_box3 = set:getElfNode("bg1_layoutBox_box3")
    self._bg1_layoutBox_box3_icon = set:getElfNode("bg1_layoutBox_box3_icon")
    self._bg1_layoutBox_box3_btn = set:getButtonNode("bg1_layoutBox_box3_btn")
    self._bg1_layoutBox_box3_base = set:getElfNode("bg1_layoutBox_box3_base")
    self._bg1_layoutKey = set:getLayoutNode("bg1_layoutKey")
    self._bg1_layoutKey_key1 = set:getElfNode("bg1_layoutKey_key1")
    self._bg1_layoutKey_key1_icon = set:getElfNode("bg1_layoutKey_key1_icon")
    self._bg1_layoutKey_key1_count = set:getLabelNode("bg1_layoutKey_key1_count")
    self._bg1_layoutKey_key2 = set:getElfNode("bg1_layoutKey_key2")
    self._bg1_layoutKey_key2_icon = set:getElfNode("bg1_layoutKey_key2_icon")
    self._bg1_layoutKey_key2_count = set:getLabelNode("bg1_layoutKey_key2_count")
    self._bg1_layoutKey_key3 = set:getElfNode("bg1_layoutKey_key3")
    self._bg1_layoutKey_key3_icon = set:getElfNode("bg1_layoutKey_key3_icon")
    self._bg1_layoutKey_key3_count = set:getLabelNode("bg1_layoutKey_key3_count")
    self._bg1_layoutKey_key4 = set:getElfNode("bg1_layoutKey_key4")
    self._bg1_layoutKey_key4_icon = set:getElfNode("bg1_layoutKey_key4_icon")
    self._bg1_layoutKey_key4_count = set:getLabelNode("bg1_layoutKey_key4_count")
    self._bg1_layoutKey_key5 = set:getElfNode("bg1_layoutKey_key5")
    self._bg1_layoutKey_key5_icon = set:getElfNode("bg1_layoutKey_key5_icon")
    self._bg1_layoutKey_key5_count = set:getLabelNode("bg1_layoutKey_key5_count")
    self._bg2 = set:getElfNode("bg2")
    self._bg2_layoutTitle = set:getLinearLayoutNode("bg2_layoutTitle")
    self._bg2_layoutTitle_icon = set:getElfNode("bg2_layoutTitle_icon")
    self._bg2_layoutTitle_v1 = set:getLabelNode("bg2_layoutTitle_v1")
    self._bg2_layoutTitle_v2 = set:getLabelNode("bg2_layoutTitle_v2")
    self._bg2_layoutTitle_btnReturn = set:getButtonNode("bg2_layoutTitle_btnReturn")
    self._bg2_list = set:getListNode("bg2_list")
    self._icon = set:getElfNode("icon")
    self._bg = set:getElfNode("bg")
    self._name = set:getLabelNode("name")
    self._clear = set:getElfNode("clear")
    self._index = set:getLabelNode("index")
    self._base = set:getElfNode("base")
    self._bg_bg0 = set:getElfNode("bg_bg0")
    self._pro = set:getLinearLayoutNode("pro")
    self._pro_l = set:getElfNode("pro_l")
    self._pro_pro0 = set:getElfNode("pro_pro0")
    self._pro_r = set:getElfNode("pro_r")
    self._percent = set:getLabelNode("percent")
    self._btn = set:getButtonNode("btn")
    self._bg3 = set:getElfNode("bg3")
    self._bg3_layoutTitle = set:getLinearLayoutNode("bg3_layoutTitle")
    self._bg3_layoutTitle_icon = set:getElfNode("bg3_layoutTitle_icon")
    self._bg3_layoutTitle_v1 = set:getLabelNode("bg3_layoutTitle_v1")
    self._bg3_layoutTitle_v2 = set:getLabelNode("bg3_layoutTitle_v2")
    self._bg3_layoutTitle_btnReturn = set:getButtonNode("bg3_layoutTitle_btnReturn")
    self._bg3_processTitle = set:getLabelNode("bg3_processTitle")
    self._bg3_rewardTitle = set:getLabelNode("bg3_rewardTitle")
    self._bg3_base = set:getElfNode("bg3_base")
    self._bg_bg0 = set:getElfNode("bg_bg0")
    self._pro = set:getLinearLayoutNode("pro")
    self._pro_l = set:getElfNode("pro_l")
    self._pro_pro0 = set:getElfNode("pro_pro0")
    self._pro_r = set:getElfNode("pro_r")
    self._percent = set:getLabelNode("percent")
    self._bg3_layoutReward = set:getLayoutNode("bg3_layoutReward")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._iconFrame = set:getElfNode("iconFrame")
    self._piece = set:getElfNode("piece")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._iconFrame = set:getElfNode("iconFrame")
    self._piece = set:getElfNode("piece")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._iconFrame = set:getElfNode("iconFrame")
    self._piece = set:getElfNode("piece")
    self._bg3_btnGetReward = set:getClickNode("bg3_btnGetReward")
    self._bg3_btnGetReward_text = set:getLabelNode("bg3_btnGetReward_text")
    self._bg3_list = set:getListNode("bg3_list")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._name = set:getLabelNode("name")
    self._clear = set:getElfNode("clear")
    self._btnName = set:getLabelNode("btnName")
    self._base = set:getElfNode("base")
    self._bg_bg0 = set:getElfNode("bg_bg0")
    self._pro = set:getLinearLayoutNode("pro")
    self._pro_l = set:getElfNode("pro_l")
    self._pro_pro0 = set:getElfNode("pro_pro0")
    self._pro_r = set:getElfNode("pro_r")
    self._percent = set:getLabelNode("percent")
    self._layoutReward = set:getLayoutNode("layoutReward")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._iconFrame = set:getElfNode("iconFrame")
    self._piece = set:getElfNode("piece")
    self._btn = set:getButtonNode("btn")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._name = set:getLabelNode("name")
    self._clear = set:getElfNode("clear")
    self._btnName = set:getLabelNode("btnName")
    self._base = set:getElfNode("base")
    self._bg_bg0 = set:getElfNode("bg_bg0")
    self._pro = set:getLinearLayoutNode("pro")
    self._pro_l = set:getElfNode("pro_l")
    self._pro_pro0 = set:getElfNode("pro_pro0")
    self._pro_r = set:getElfNode("pro_r")
    self._percent = set:getLabelNode("percent")
    self._layoutReward = set:getLayoutNode("layoutReward")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._iconFrame = set:getElfNode("iconFrame")
    self._piece = set:getElfNode("piece")
    self._btn = set:getButtonNode("btn")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._name = set:getLabelNode("name")
    self._clear = set:getElfNode("clear")
    self._btnName = set:getLabelNode("btnName")
    self._base = set:getElfNode("base")
    self._bg_bg0 = set:getElfNode("bg_bg0")
    self._pro = set:getLinearLayoutNode("pro")
    self._pro_l = set:getElfNode("pro_l")
    self._pro_pro0 = set:getElfNode("pro_pro0")
    self._pro_r = set:getElfNode("pro_r")
    self._percent = set:getLabelNode("percent")
    self._layoutReward = set:getLayoutNode("layoutReward")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._iconFrame = set:getElfNode("iconFrame")
    self._piece = set:getElfNode("piece")
    self._btn = set:getButtonNode("btn")
    self._list = set:getListNode("list")
    self._layout = set:getLayoutNode("layout")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._lv = set:getLabelNode("lv")
    self._career = set:getElfNode("career")
    self._starLayout = set:getLayoutNode("starLayout")
    self._name = set:getLabelNode("name")
    self._layoutT1_v = set:getLabelNode("layoutT1_v")
    self._layoutT2_v = set:getLabelNode("layoutT2_v")
    self._layoutT3_v = set:getLabelNode("layoutT3_v")
    self._bg = set:getElfNode("bg")
    self._btn = set:getButtonNode("btn")
    self._btnName = set:getLabelNode("btnName")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._lv = set:getLabelNode("lv")
    self._career = set:getElfNode("career")
    self._starLayout = set:getLayoutNode("starLayout")
    self._name = set:getLabelNode("name")
    self._layoutT_v = set:getLabelNode("layoutT_v")
    self._layoutT3_v = set:getLabelNode("layoutT3_v")
    self._tip = set:getLabelNode("tip")
    self._bg = set:getElfNode("bg")
    self._bg_box1 = set:getElfNode("bg_box1")
    self._bg_box1_btn = set:getButtonNode("bg_box1_btn")
    self._bg_box1_btnOk = set:getClickNode("bg_box1_btnOk")
    self._bg_box1_btnOk_text = set:getLabelNode("bg_box1_btnOk_text")
    self._bg_box1_btnOk_point = set:getElfNode("bg_box1_btnOk_point")
    self._bg_box1_base = set:getElfNode("bg_box1_base")
    self._bg_bg0 = set:getElfNode("bg_bg0")
    self._pro = set:getLinearLayoutNode("pro")
    self._pro_l = set:getElfNode("pro_l")
    self._pro_pro0 = set:getElfNode("pro_pro0")
    self._pro_r = set:getElfNode("pro_r")
    self._percent = set:getLabelNode("percent")
    self._bg_box2 = set:getElfNode("bg_box2")
    self._bg_box2_btn = set:getButtonNode("bg_box2_btn")
    self._bg_box2_btnOk = set:getClickNode("bg_box2_btnOk")
    self._bg_box2_btnOk_text = set:getLabelNode("bg_box2_btnOk_text")
    self._bg_box2_btnOk_point = set:getElfNode("bg_box2_btnOk_point")
    self._bg_box2_base = set:getElfNode("bg_box2_base")
    self._bg_box3 = set:getElfNode("bg_box3")
    self._bg_box3_btn = set:getButtonNode("bg_box3_btn")
    self._bg_box3_btnOk = set:getClickNode("bg_box3_btnOk")
    self._bg_box3_btnOk_text = set:getLabelNode("bg_box3_btnOk_text")
    self._bg_box3_btnOk_point = set:getElfNode("bg_box3_btnOk_point")
    self._bg_box3_base = set:getElfNode("bg_box3_base")
    self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
    self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
    self._commonDialog_tab = set:getLayoutNode("commonDialog_tab")
    self._commonDialog_tab_tab1 = set:getTabNode("commonDialog_tab_tab1")
    self._commonDialog_tab_tab1_title = set:getLabelNode("commonDialog_tab_tab1_title")
    self._commonDialog_tab_tab1_point = set:getElfNode("commonDialog_tab_tab1_point")
    self._commonDialog_tab_tab2 = set:getTabNode("commonDialog_tab_tab2")
    self._commonDialog_tab_tab2_title = set:getLabelNode("commonDialog_tab_tab2_title")
    self._commonDialog_tab_tab2_point = set:getElfNode("commonDialog_tab_tab2_point")
    self._commonDialog_tab_tab3 = set:getTabNode("commonDialog_tab_tab3")
    self._commonDialog_tab_tab3_title = set:getLabelNode("commonDialog_tab_tab3_title")
    self._commonDialog_tab_tab3_point = set:getElfNode("commonDialog_tab_tab3_point")
    self._commonDialog_btnHelp = set:getButtonNode("commonDialog_btnHelp")
--    self._@pageHunt = set:getElfNode("@pageHunt")
--    self._@process = set:getElfNode("@process")
--    self._@itemZhangjie = set:getElfNode("@itemZhangjie")
--    self._@process = set:getElfNode("@process")
--    self._@process = set:getElfNode("@process")
--    self._@itemKillReward = set:getElfNode("@itemKillReward")
--    self._@itemKillReward = set:getElfNode("@itemKillReward")
--    self._@itemKillReward = set:getElfNode("@itemKillReward")
--    self._@itemStage = set:getElfNode("@itemStage")
--    self._@process = set:getElfNode("@process")
--    self._@itemKillReward = set:getElfNode("@itemKillReward")
--    self._@itemStage = set:getElfNode("@itemStage")
--    self._@process = set:getElfNode("@process")
--    self._@itemKillReward = set:getElfNode("@itemKillReward")
--    self._@itemStage = set:getElfNode("@itemStage")
--    self._@process = set:getElfNode("@process")
--    self._@itemKillReward = set:getElfNode("@itemKillReward")
--    self._@pageCamp = set:getElfNode("@pageCamp")
--    self._@sizeCamp = set:getElfNode("@sizeCamp")
--    self._@itemCampMine = set:getElfNode("@itemCampMine")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@itemCampEmpty = set:getElfNode("@itemCampEmpty")
--    self._@itemCampGuild = set:getElfNode("@itemCampGuild")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@pageTreasure = set:getElfNode("@pageTreasure")
--    self._@process = set:getElfNode("@process")
end
--@@@@]]]]

--------------------------------override functions----------------------

local Launcher = require 'Launcher'
Launcher.register("DHunt", function ( userData )
	if UnlockManager:isUnlock("GuildCopyLv") then
		if require "GuildInfo".isInGuild() then
			GuildCopyFunc.cleanStagesData()
			Launcher.callNet(netModel.getModelGuildCopyGet(), function ( data )
		   		print("GuildCopyGet")
		   		print(data)
		   		if data and data.D then
		   			GuildCopyFunc.setGuildCopy(data.D.GuildCopy)
		   			GuildCopyFunc.setGuildCopyRecord(data.D.Record)
		   			Launcher.callNet(netModel.getModelGuildCopyPetsGet(), function ( data )
		   				print("GuildCopyPetsGet")
		   				print(data)
		   				if data and data.D then
		   					GuildCopyFunc.setGuildCopyPetsMine(data.D.Mine)
		   					GuildCopyFunc.setGuildCopyPetsOthers(data.D.Others)
		   					Launcher.Launching(data)
		   				end
		   			end)
		   		end
		 	end)
		else
			GleeCore:toast(res.locString("Hunt$lockTip"))
		end	   
	else
		GleeCore:toast(UnlockManager:getUnlockConditionMsg("GuildCopyLv"))
	end
end)

function DHunt:onInit( userData, netData )
	self.tabIndexSelected = tabList.TabHunting
	self.areaId = userData and userData.AreaId or 0
	self.townId = userData and userData.TownId or 0
	self:broadcastEvent()
	self:setListenerEvent()
	self:initPageArray()
	self:updatePages()
	res.doActionDialogShow(self._commonDialog)
end

function DHunt:onBack( userData, netData )
	
end

function DHunt:close(  )
	EventCenter.resetGroup("DHunt")
end

--------------------------------custom code-----------------------------

function DHunt:broadcastEvent( ... )
	EventCenter.addEventFunc("OnAppStatChange", function ( state )
		if state == 2 then
			self:updatePages()
		end
	end, "DHunt")

	EventCenter.addEventFunc("GoToHunt", function ( data )
		self.tabIndexSelected = tabList.TabHunting
		self.areaId = data and data.AreaId or 0
		self.townId = 0
		self:updatePages()
	end, "DHunt")

	EventCenter.addEventFunc("UpdateHunt", function ( data )
		self:updatePages()
	end, "DHunt")
end

function DHunt:setListenerEvent( ... )
	for i=1,tabList.TabCount do
		require 'LangAdapter'.fontSize(self[string.format("_commonDialog_tab_tab%d_title", i)], nil, nil, 20, nil, 22)
		self[string.format("_commonDialog_tab_tab%d_title", i)]:setString(res.locString(string.format("Hunt$tabTitle%d", i)))
		self[string.format("_commonDialog_tab_tab%d_point", i)]:setVisible(false)
		self[string.format("_commonDialog_tab_tab%d", i)]:setListener(function ( ... )
			if self.tabIndexSelected ~= i then
				self.tabIndexSelected = i
				self:updatePages()
			end
		end)
	end

	self._commonDialog_btnHelp:setListener(function ( ... )
		GleeCore:showLayer("DHelp", {type = "狩猎场"})
	end)

	self._commonDialog_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)
end

function DHunt:initPageArray( ... )
	local dyList = {
		[tabList.TabHunting] = "@pageHunt", 
		[tabList.TabCamp] = "@pageCamp", 
		[tabList.TabTreasure] = "@pageTreasure",
	}
	self.pageList = {}
	for i,v in ipairs(dyList) do
		local set = self:createLuaSet(v)
		self._commonDialog_cnt_page:addChild(set[1])
		set[1]:setVisible(false)
		table.insert(self.pageList, set)
	end

	require 'LangAdapter'.selectLang(nil, nil, nil, nil, function ( ... )
		local setHunt = self.pageList[tabList.TabHunting]
    		setHunt["bg3_processTitle"]:setFontSize(18)
    		setHunt["bg3_rewardTitle"]:setFontSize(18)
	end)
end

function DHunt:updatePages( refresh )
	for i,v in ipairs(self.pageList) do
		v[1]:setVisible(i == self.tabIndexSelected)
	end

	self[string.format("_commonDialog_tab_tab%d", self.tabIndexSelected)]:trigger(nil)
	self:updateTabNameColor()
	
	if self.tabIndexSelected == tabList.TabHunting then
		self:updateHunt(refresh)
	elseif self.tabIndexSelected == tabList.TabCamp then
		self:updateCamp()
	elseif self.tabIndexSelected == tabList.TabTreasure then
		self:updateTreasure()
	end
end

function DHunt:updateTabNameColor( ... )
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

function DHunt:updateHunt( refresh )
	local step = 0
	if self.areaId == 0 then
		self:updateHuntStep1()
		step = 1
	else
		if self.townId == 0 then
			step = 2
		else
			step = 3
		end

		local list = GuildCopyFunc.getStagesWithAreaId( self.areaId )
		if list and #list > 0 then
			if self.townId == 0 then
				self:updateHuntStep2(refresh)
			else
				self:updateHuntStep3(refresh)
			end
		else
			self:send(netModel.getModelGuildCopyStagesGet(self.areaId), function ( data )
				if data and data.D then
					GuildCopyFunc.setAreaStages(self.areaId, data.D.Stages)
					if self.townId == 0 then
						self:updateHuntStep2(refresh)
					else
						self:updateHuntStep3(refresh)
					end
				end
			end)
		end
	end
	local setHunt = self.pageList[tabList.TabHunting]
	for i=1,3 do
		setHunt[string.format("bg%d", i)]:setVisible(step == i)
	end
end

function DHunt:updateCamp( ... )
	local petsMine = GuildCopyFunc.getGuildCopyPetsMine() or {}
	local petsOthers = GuildCopyFunc.getGuildCopyPetsOthers() or {}

	local setCamp = self.pageList[tabList.TabCamp]
	local container = setCamp["list"]:getContainer()
	container:removeAllChildrenWithCleanup(true)

	local sizeSet = self:createLuaSet("@sizeCamp")
	container:addChild(sizeSet[1])
	
	for i,v in ipairs(petsMine) do
		local itemCampMine = self:createLuaSet("@itemCampMine")
		sizeSet["layout"]:addChild(itemCampMine[1])
		res.setNodeWithPetWithLv( itemCampMine["icon"], v.Pet, count )
		itemCampMine["lv"]:setString(v.Pet.Lv)
		local dbPet = dbManager.getCharactor(v.Pet.PetId)
		itemCampMine["career"]:setResid(res.getPetCareerIcon(dbPet.atk_method_system))
		itemCampMine["name"]:setString(v.RoleName)
		require 'PetNodeHelper'.updateStarLayout(itemCampMine["starLayout"], dbPet)

		local strTime
		local TimeListManager = require "TimeListManager"
		local minutes = TimeListManager.getTimeUpToNow(v.StartTime) / 60
		minutes = math.max(minutes, 0)
		if minutes < 60 then
			strTime = tostring(math.floor(minutes)) .. res.locString("Hunt$CampInTimeFormat3")
		elseif minutes < 60 * 24 then
			strTime = tostring(math.floor(minutes / 60)) .. res.locString("Hunt$CampInTimeFormat2")
		else
			strTime = tostring(math.floor(minutes / 60 / 24)) .. res.locString("Hunt$CampInTimeFormat1")
		end
		itemCampMine["layoutT1_v"]:setString(strTime)
		itemCampMine["layoutT2_v"]:setString(v.Point)
		itemCampMine["layoutT3_v"]:setString(string.format("%d/%d", #v.Guests, dbManager.getInfoDefaultConfig("HelpTimes").Value))

		require 'LangAdapter'.selectLang(nil, nil, function ( ... )
			itemCampMine["layoutT1_#k"]:setFontSize(14)
			itemCampMine["layoutT1_v"]:setFontSize(14)
			itemCampMine["layoutT2_#k"]:setFontSize(14)
			itemCampMine["layoutT2_v"]:setFontSize(14)
			itemCampMine["layoutT3_#k"]:setFontSize(14)
			itemCampMine["layoutT3_v"]:setFontSize(14)
		end, nil, function ( ... )
			itemCampMine["layoutT1_#k"]:setFontSize(16)
			itemCampMine["layoutT1_v"]:setFontSize(16)
			itemCampMine["layoutT2_#k"]:setFontSize(16)
			itemCampMine["layoutT2_v"]:setFontSize(16)
			itemCampMine["layoutT3_#k"]:setFontSize(16)
			itemCampMine["layoutT3_v"]:setFontSize(16)
		end)
	end

	if #petsMine < 2 then
		for i=1,2 - #petsMine do
			local itemCampEmpty = self:createLuaSet("@itemCampEmpty")
			sizeSet["layout"]:addChild(itemCampEmpty[1])
			itemCampEmpty["btn"]:setListener(function ( ... )
				local templist = teamFunc.getPetListWithTeam( teamFunc.getTeamActive() )
				local kpList = {}
				for i,v in ipairs(templist) do
					local canFind = false
					for _,vv in pairs(petsMine) do
						if vv.Pet.Id == v.Id then
							canFind = true 
							break
						end
					end
					if not canFind then
						table.insert(kpList, v)
					end
				end
				if kpList and #kpList > 0 then
					local param = {}
					param.petlist = kpList
					param.funcChosePet = function ( nPetId )
						local param = {}
						local dbPet = dbManager.getCharactor(gameFunc.getPetInfo().getPetWithId(nPetId).PetId)
						param.content = string.format(res.locString("Hunt$chosePetTip"), dbPet.name)	
						param.callback = function ( ... )
							self:send(netModel.getModelGuildCopyPetSend(nPetId), function ( data )
								if data and data.D then
									GuildCopyFunc.setGuildCopyPetsMine(data.D.Mine)
									self:updateCamp()
									EventCenter.eventInput("PetChoseClose")
								end
							end)
						end
						GleeCore:showLayer("DConfirmNT", param)
					end
					GleeCore:showLayer("DPetChose", param)
				else
					self:toast(res.locString("Hunt$noPetCanChoseTip"))
				end
			end)
		end
	end

	table.sort(petsOthers, function ( v1, v2 )
		return v1.Pet.Power > v2.Pet.Power
	end)

	for i,v in ipairs(petsOthers) do
		if math.fmod(i, 4) == 3 then
			sizeSet = self:createLuaSet("@sizeCamp")
			container:addChild(sizeSet[1])
		end

		local itemCampGuild = self:createLuaSet("@itemCampGuild")
		sizeSet["layout"]:addChild(itemCampGuild[1])
		res.setNodeWithPetWithLv( itemCampGuild["icon"], v.Pet, count )
		itemCampGuild["lv"]:setString(v.Pet.Lv)
		local dbPet = dbManager.getCharactor(v.Pet.PetId)
		itemCampGuild["career"]:setResid(res.getPetCareerIcon(dbPet.atk_method_system))
		itemCampGuild["name"]:setString(v.RoleName)
		require 'PetNodeHelper'.updateStarLayout(itemCampGuild["starLayout"], dbPet)
		itemCampGuild["layoutT_v"]:setString(v.Pet.Power)
		itemCampGuild["layoutT3_v"]:setString(string.format("%d/%d", #v.Guests, dbManager.getInfoDefaultConfig("HelpTimes").Value))

		require 'LangAdapter'.selectLang(nil, nil, function ( ... )
			itemCampGuild["layoutT3_#k"]:setFontSize(14)
			itemCampGuild["layoutT3_v"]:setFontSize(14)
		end, nil, function ( ... )
			itemCampGuild["layoutT3_#k"]:setFontSize(16)
			itemCampGuild["layoutT3_v"]:setFontSize(16)
		end)
	end
end

function DHunt:updateTreasure( set )
	HuntHelper.updateTreasure( self.pageList[tabList.TabTreasure] )
end

function DHunt:updateHuntStep1( ... )
	local setHunt = self.pageList[tabList.TabHunting]
	local allCount = dbManager.getInfoDefaultConfig("HuntTimes").Value + GuildCopyFunc.getGuildCopyRecord().TimesBuy or 0
	local record = GuildCopyFunc.getGuildCopyRecord()
	setHunt["bg1_layoutChallenge_v"]:setString(string.format("%d/%d", record.TimesLeft, allCount))
	for i=1,5 do
		setHunt[string.format("bg1_btnPro%d", i)]:setListener(function ( ... )
			self.areaId = i
			self.townId = 0
			self:updatePages(true)
		end)
		local name = dbManager.getGuildCopyAreaConfig(i).Name
		setHunt[string.format("bg1_btnPro%d_normal_title", i)]:setString(name)
		setHunt[string.format("bg1_btnPro%d_pressed_title", i)]:setString(name)
	end

	for i=1,3 do
		setHunt[string.format("bg1_layoutBox_box%d_btn", i)]:setListener(function ( ... )
			GleeCore:showLayer("DHuntBoxKey", {boxIndex = i})
		end)

		setHunt[string.format("bg1_layoutBox_box%d_base", i)]:removeAllChildrenWithCleanup(true)
		local process = self:createLuaSet("@process")
		setHunt[string.format("bg1_layoutBox_box%d_base", i)]:addChild(process[1])
		HuntHelper.updateProcess(process, 120, GuildCopyFunc.getBoxProcess(i), 0.5)
	end

	for i,v in ipairs(GuildCopyFunc.getGuildCopyRecord().KeysGot) do
		res.setNodeWithKey(setHunt[string.format("bg1_layoutKey_key%d_icon", i)], v.PropId)
		setHunt[string.format("bg1_layoutKey_key%d_count", i)]:setString(string.format("x%d", v.Amount))
	end
end

function DHunt:updateHuntStep2( refresh )
	local setHunt = self.pageList[tabList.TabHunting]
	local indexList = {5, 4, 2, 3, 1}
	setHunt["bg2"]:setResid(string.format("N_SLC_bg%d.png", indexList[self.areaId]))
	setHunt["bg2_layoutTitle_icon"]:setResid(string.format("N_SLC_shuxing%d.png", indexList[self.areaId]))
	setHunt["bg2_layoutTitle_v1"]:setString(dbManager.getGuildCopyAreaConfig(self.areaId).Name)
	setHunt["bg2_layoutTitle_v2"]:setString("")
	setHunt["bg2_layoutTitle_btnReturn"]:setListener(function ( ... )
		self.areaId = 0
		self:updatePages()
	end)

	self.groundList = LuaList.new(setHunt["bg2_list"], function ( ... )
		return self:createLuaSet("@itemZhangjie")
	end, function ( nodeLuaSet, townInfo, listIndex )
		nodeLuaSet["icon"]:setResid(string.format("N_SLC_bg%d_%d.png", indexList[self.areaId], listIndex))
		nodeLuaSet["name"]:setString(townInfo.TownName)
		require "LangAdapter".LabelNodeAutoShrink( nodeLuaSet["name"], 190)
		nodeLuaSet["clear"]:setVisible(townInfo.Clear)
		nodeLuaSet["index"]:setString(townInfo.Detail)

		nodeLuaSet["base"]:removeAllChildrenWithCleanup(true)
		local process = self:createLuaSet("@process")
		nodeLuaSet["base"]:addChild(process[1])
		HuntHelper.updateProcess(process, 132, townInfo.Percent, 0.9)

		nodeLuaSet["btn"]:setListener(function ( ... )
			if townInfo.Enable then
				self.townId = townInfo.TownId
				self:updatePages()
			else
				self:toast(res.locString("Hunt$UnopenTip"))
			end
		end)
	end)
	self.groundList:update( self:getTownInfoListWithAreaId(self.areaId) )
	if refresh then
		setHunt["bg2_list"]:layout()
		setHunt["bg2_list"]:alignTo(0)
	end
end

function DHunt:updateHuntStep3( refresh, noRefreshStep3 )
	local setHunt = self.pageList[tabList.TabHunting]
	local indexList = {5, 4, 2, 3, 1}
	setHunt["bg3"]:setResid(string.format("N_SLC_bg%d.png", indexList[self.areaId]))
	setHunt["bg3_layoutTitle_icon"]:setResid(string.format("N_SLC_shuxing%d.png", indexList[self.areaId]))
	setHunt["bg3_layoutTitle_v1"]:setString(dbManager.getGuildCopyAreaConfig(self.areaId).Name)
	setHunt["bg3_layoutTitle_v2"]:setString("-" .. dbManager.getGuildCopyTownConfig(self.townId).Name)
	
	require "LangAdapter".selectLang(nil,nil,nil,nil,nil,function ( ... )
		setHunt["bg3_layoutTitle_v1"]:setFontSize(36)
		setHunt["bg3_layoutTitle_v2"]:setFontSize(28)
	end, function ( ... )
		setHunt["bg3_layoutTitle_v1"]:setFontSize(36)
		setHunt["bg3_layoutTitle_v2"]:setFontSize(28)
	end)

	setHunt["bg3_layoutTitle_btnReturn"]:setListener(function ( ... )
		self.townId = 0
		self:updatePages()
	end)
	
	local percent = GuildCopyFunc.getTownPercent( self.areaId, self.townId )
	setHunt["bg3_base"]:removeAllChildrenWithCleanup(true)
	local process = self:createLuaSet("@process")
	setHunt["bg3_base"]:addChild(process[1])
	HuntHelper.updateProcess(process, 266, percent, 0.9)

	setHunt["bg3_layoutReward"]:removeAllChildrenWithCleanup(true)	
	for _,rewardId in ipairs(dbManager.getGuildCopyTownConfig(self.townId).RewardIds) do
		local dbReward = dbManager.getRewardItem(rewardId)
		if dbReward then
			local itemKillReward = self:createLuaSet("@itemKillReward")
			setHunt["bg3_layoutReward"]:addChild(itemKillReward[1])
			self:updateKillReward(itemKillReward, res.getDetailByDBReward(dbReward))
		end
	end
	
	local isGot = table.find(GuildCopyFunc.getGuildCopyRecord().TownRewardGot or {}, self.townId)
	setHunt["bg3_btnGetReward"]:setEnabled(percent >= 1 and not isGot)
	if isGot then
		setHunt["bg3_btnGetReward_text"]:setString(res.locString("Global$ReceiveFinish"))
	else
		setHunt["bg3_btnGetReward_text"]:setString(res.locString("Global$Receive"))
	end

	setHunt["bg3_btnGetReward"]:setListener(function ( ... )
		self:send(netModel.getModelGuildCopyTownReward( self.townId ), function ( data )
			if data and data.D then
				gameFunc.updateResource(data.D.Resource)
				res.doActionGetReward(data.D.Reward)
				GuildCopyFunc.setGuildCopyRecord(data.D.Record)
				self:updatePages()
			end
		end)
	end)

	self.stageList = LuaList.new(setHunt["bg3_list"], function ( ... )
		return self:createLuaSet("@itemStage")
	end, function ( nodeLuaSet, stageInfo )
		res.setNodeWithPet( nodeLuaSet["icon"], stageInfo.nPet)
		nodeLuaSet["name"]:setString(stageInfo.StageName)
		nodeLuaSet["clear"]:setVisible(stageInfo.Clear)

		if stageInfo.StageStatus == "Battle" then
			nodeLuaSet["btnName"]:setFontFillColor(ccc4f(0.796,0.415,0.11,1.0), true)
			nodeLuaSet["btnName"]:setString(res.locString("Hunt$stageStatus2"))
		elseif stageInfo.StageStatus == "Speed" then
			nodeLuaSet["btnName"]:setFontFillColor(ccc4f(0.796,0.415,0.11,1.0), true)
			nodeLuaSet["btnName"]:setString(res.locString("Hunt$stageStatus1"))
		else
			nodeLuaSet["btnName"]:setFontFillColor(ccc4f(0.91,0.27,0.153,1.0), true)
			nodeLuaSet["btnName"]:setString(res.locString("Hunt$stageStatus3"))
		end
		nodeLuaSet["layoutReward"]:removeAllChildrenWithCleanup(true)
		for i,v in ipairs(stageInfo.Rewards) do
			local itemKillReward = self:createLuaSet("@itemKillReward")
			nodeLuaSet["layoutReward"]:addChild(itemKillReward[1])
			self:updateKillReward(itemKillReward, v)
		end

		nodeLuaSet["base"]:removeAllChildrenWithCleanup(true)
		local process = self:createLuaSet("@process")
		nodeLuaSet["base"]:addChild(process[1])
		HuntHelper.updateProcess(process, 132, stageInfo.Percent, 0.9)

		nodeLuaSet["btn"]:setEnabled(stageInfo.StageStatus == "Battle" or stageInfo.StageStatus == "Speed")
		nodeLuaSet["btn"]:setListener(function ( ... )
			if GuildCopyFunc.getGuildCopyRecord().TimesLeft > 0 then
				local runeList = require "RuneInfo".getRuneList()
				if runeList and #runeList >= 200 then
					local param = {}
					param.content = res.locString("Rune$runeCountLimit")
					param.callback = function ( ... )
						GleeCore:showLayer("DRuneOp", {RuneData = runeList[1], ViewType = 3})
					end
					GleeCore:showLayer("DConfirmNT", param)
				else
					if stageInfo.StageStatus == "Battle" then
						gameFunc.getTempInfo().setValueForKey("GuildCopyAreaId", self.areaId)
						gameFunc.getTempInfo().setValueForKey("GuildCopyTownId", self.townId)

						local param = {}
						param.type = "guildfuben"
						param.stageId = stageInfo.StageId
						GleeCore:showLayer("DPrepareForStageBattle", param)
					elseif stageInfo.StageStatus == "Speed" then
						local param = {}
						param.content = string.format(res.locString("Hunt$BattleSpeedConfirmTip"), stageInfo.StageName)
						param.callback = function ( ... )
							self:send(netModel.getModelGuildCopyStageFast(stageInfo.StageId), function ( data )
								if data and data.D then
									gameFunc.updateResource(data.D.Resource)
									res.doActionGetReward(data.D.Reward)
									GuildCopyFunc.setGuildCopy(data.D.GuildCopy)
									GuildCopyFunc.setGuildCopyRecord(data.D.Record)
							--		self:updatePages()
									self:updateHuntStep3(nil, true)
								end
							end)							
						end
						GleeCore:showLayer("DConfirmNT", param)
					end
				end
			else
				local limit = dbManager.getVipInfo(gameFunc.getUserInfo().getVipLevel()).GuildCopyBuyTimes
				if GuildCopyFunc.getGuildCopyRecord().TimesBuy < limit then
					local param = {}
					local costList = dbManager.getInfoDefaultConfig("HuntTimePrices").Value
					local cost = (GuildCopyFunc.getGuildCopyRecord().TimesBuy + 1 <= #costList) and costList[GuildCopyFunc.getGuildCopyRecord().TimesBuy + 1] or costList[#costList]
					param.content = string.format(res.locString("Hunt$challengeTimesBuy"), cost)	
					param.callback = function ( ... )
						if userFunc.getCoin() >= cost then
							self:send(netModel.getModelGuildCopyTimesBuy(), function ( data )
								if data and data.D then
									userFunc.setCoin( userFunc.getCoin() - cost )
									EventCenter.eventInput("UpdateGoldCoin")
									GuildCopyFunc.setGuildCopyRecord(data.D.Record)
									self:toast(res.locString("Hunt$ChallengeCountBuysSuc"))
								end
							end)
						else
							require "Toolkit".showDialogOnCoinNotEnough()
						end
					end						
					GleeCore:showLayer("DConfirmNT", param)
				else
					self:toast(res.locString("Hunt$challengeTimesLimit"))
				end
			end
		end)
	end)

	local tlist, curStageIndex = self:getStageInfoListWithAreaTownId(self.areaId, self.townId)
	self.stageList:update(tlist)

	if not noRefreshStep3 then
		setHunt["bg3_list"]:layout()
		setHunt["bg3_list"]:alignTo(math.max(curStageIndex - 2, 0))
	end
end

function DHunt:updateKillReward( itemKillReward, v )
	local scaleOrigal = 1
	itemKillReward["bg"]:setResid(v.bg)
	itemKillReward["bg"]:setScale(scaleOrigal)
	itemKillReward["icon"]:setResid(v.icon)
	if v.type == "Pet" or v.type == "PetPiece" then
		itemKillReward["icon"]:setScale(scaleOrigal * 140 / 95)
	else
		itemKillReward["icon"]:setScale(scaleOrigal)
	end
	itemKillReward["iconFrame"]:setResid(v.frame)
	itemKillReward["iconFrame"]:setScale(scaleOrigal)
	itemKillReward["piece"]:setVisible(v.isPiece)

	res.addRuneStars( itemKillReward["iconFrame"], v )
end

function DHunt:getTownInfoListWithAreaId( areaId )
	local townList = dbManager.getGuildCopyTownsWithAreaId( areaId )
	local result = {}
	local curTownId = nil
	for i,v in ipairs(townList) do
		local temp = {}
		temp.TownId = v.Id
		temp.TownName = v.Name
		temp.Detail = v.Detail

		temp.Percent = GuildCopyFunc.getTownPercent( areaId, v.Id )
		temp.Clear = temp.Percent >= 1

		if temp.Clear then
			temp.Enable = true
		else
			if curTownId == nil then
				curTownId = v.Id
				temp.Enable = true
			else
				temp.Enable = false
			end
		end

		table.insert(result, temp)
	end
	return result
end

function DHunt:getStageInfoListWithAreaTownId( areaId, townId )
	local stageList = dbManager.getGuildCopyStagesWithTownId(townId)
	local result = {}
	local curStageIndex = #stageList + 1
	for i,v in ipairs(stageList) do
		local stageInfo = GuildCopyFunc.getStageInfo( areaId, townId, v.Id )
		if not stageInfo.Clear then
			curStageIndex = i
			break
		end
	end

	for i,v in ipairs(stageList) do
		local temp = {}
		temp.StageId = v.Id
		temp.StageName = dbManager.getCharactor(v.PetId).name

		local stageInfo = GuildCopyFunc.getStageInfo( areaId, townId, v.Id )
		if stageInfo then
			temp.Clear = stageInfo.Clear
			temp.nPet = petFunc.getPetInfoByPetId(stageInfo.Leader.PetId, stageInfo.Leader.AwakeIndex, stageInfo.Leader.Power)
			temp.Percent = stageInfo.Percent
		end

		if i == curStageIndex then
			temp.StageStatus = "Battle"
		elseif i <= curStageIndex - 1 then
			temp.StageStatus = "Speed"
		else
			temp.StageStatus = "Unopen"
		end

		temp.Rewards = {}
		if v.RewardIds then
			for _,rewardId in ipairs(v.RewardIds) do
				local dbReward = dbManager.getRewardItem(rewardId)
				if dbReward then
					table.insert(temp.Rewards, res.getDetailByDBReward(dbReward))
				end
			end
		end
		table.insert(result, temp)
	end
	return result, curStageIndex
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DHunt, "DHunt")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DHunt", DHunt)
