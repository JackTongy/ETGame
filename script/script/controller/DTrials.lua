local Config = require "Config"
local Res = require "Res"
local res = Res
local dbManager = require "DBManager"
local DBManager = dbManager
local netModel = require "netModel"
local NetModel = netModel
local EventCenter = require "EventCenter"
local UnlockManager = require 'UnlockManager'
local LuaList = require "LuaList"
local gameFunc = require "AppData"
local userFunc = gameFunc.getUserInfo()
local petFunc = gameFunc.getPetInfo()
local teamFunc = gameFunc.getTeamInfo()

local tabList = {
	["TabTrial"] = 1,
	["TabRank"] = 2, 
	["TabReward"] = 3,
	["TabShop"] = 4,
	["TabCount"] = 4,
}

local DTrials = class(LuaDialog)

function DTrials:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DTrials.cocos.zip")
    return self._factory:createDocument("DTrials.cocos")
end

--@@@@[[[[
function DTrials:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_page = set:getElfNode("commonDialog_cnt_page")
    self._modeChose = set:getElfNode("modeChose")
    self._modeChose_bg = set:getJoint9Node("modeChose_bg")
    self._modeChose_bg_btn1 = set:getClickNode("modeChose_bg_btn1")
    self._modeChose_bg_btn1_normal_locked = set:getElfNode("modeChose_bg_btn1_normal_locked")
    self._modeChose_bg_btn1_normal_fighting = set:getLabelNode("modeChose_bg_btn1_normal_fighting")
    self._modeChose_bg_btn1_normal_condition = set:getElfNode("modeChose_bg_btn1_normal_condition")
    self._modeChose_bg_btn1_normal_Lv = set:getLabelNode("modeChose_bg_btn1_normal_Lv")
    self._modeChose_bg_btn1_pressed_locked = set:getElfNode("modeChose_bg_btn1_pressed_locked")
    self._modeChose_bg_btn1_pressed_fighting = set:getLabelNode("modeChose_bg_btn1_pressed_fighting")
    self._modeChose_bg_btn1_pressed_condition = set:getElfNode("modeChose_bg_btn1_pressed_condition")
    self._modeChose_bg_btn1_pressed_Lv = set:getLabelNode("modeChose_bg_btn1_pressed_Lv")
    self._modeChose_bg_btn2 = set:getClickNode("modeChose_bg_btn2")
    self._modeChose_bg_btn2_normal_locked = set:getElfNode("modeChose_bg_btn2_normal_locked")
    self._modeChose_bg_btn2_normal_fighting = set:getLabelNode("modeChose_bg_btn2_normal_fighting")
    self._modeChose_bg_btn2_normal_condition = set:getElfNode("modeChose_bg_btn2_normal_condition")
    self._modeChose_bg_btn2_normal_Lv = set:getLabelNode("modeChose_bg_btn2_normal_Lv")
    self._modeChose_bg_btn2_pressed_locked = set:getElfNode("modeChose_bg_btn2_pressed_locked")
    self._modeChose_bg_btn2_pressed_fighting = set:getLabelNode("modeChose_bg_btn2_pressed_fighting")
    self._modeChose_bg_btn2_pressed_condition = set:getElfNode("modeChose_bg_btn2_pressed_condition")
    self._modeChose_bg_btn2_pressed_Lv = set:getLabelNode("modeChose_bg_btn2_pressed_Lv")
    self._modeChose_bg_btn3 = set:getClickNode("modeChose_bg_btn3")
    self._modeChose_bg_btn3_normal_locked = set:getElfNode("modeChose_bg_btn3_normal_locked")
    self._modeChose_bg_btn3_normal_fighting = set:getLabelNode("modeChose_bg_btn3_normal_fighting")
    self._modeChose_bg_btn3_normal_condition = set:getElfNode("modeChose_bg_btn3_normal_condition")
    self._modeChose_bg_btn3_normal_Lv = set:getLabelNode("modeChose_bg_btn3_normal_Lv")
    self._modeChose_bg_btn3_pressed_locked = set:getElfNode("modeChose_bg_btn3_pressed_locked")
    self._modeChose_bg_btn3_pressed_fighting = set:getLabelNode("modeChose_bg_btn3_pressed_fighting")
    self._modeChose_bg_btn3_pressed_condition = set:getElfNode("modeChose_bg_btn3_pressed_condition")
    self._modeChose_bg_btn3_pressed_Lv = set:getLabelNode("modeChose_bg_btn3_pressed_Lv")
    self._modeChose_bg_btn4 = set:getClickNode("modeChose_bg_btn4")
    self._modeChose_bg_btn4_normal_locked = set:getElfNode("modeChose_bg_btn4_normal_locked")
    self._modeChose_bg_btn4_normal_fighting = set:getLabelNode("modeChose_bg_btn4_normal_fighting")
    self._modeChose_bg_btn4_normal_condition = set:getElfNode("modeChose_bg_btn4_normal_condition")
    self._modeChose_bg_btn4_normal_Lv = set:getLabelNode("modeChose_bg_btn4_normal_Lv")
    self._modeChose_bg_btn4_pressed_locked = set:getElfNode("modeChose_bg_btn4_pressed_locked")
    self._modeChose_bg_btn4_pressed_fighting = set:getLabelNode("modeChose_bg_btn4_pressed_fighting")
    self._modeChose_bg_btn4_pressed_condition = set:getElfNode("modeChose_bg_btn4_pressed_condition")
    self._modeChose_bg_btn4_pressed_Lv = set:getLabelNode("modeChose_bg_btn4_pressed_Lv")
    self._modeDetail = set:getElfNode("modeDetail")
    self._modeDetail_bg = set:getElfNode("modeDetail_bg")
    self._modeDetail_bg_curStage = set:getLabelNode("modeDetail_bg_curStage")
    self._modeDetail_bg_layoutMode = set:getLayoutNode("modeDetail_bg_layoutMode")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._tip = set:getElfNode("tip")
    self._name = set:getLabelNode("name")
    self._layoutStar = set:getLayoutNode("layoutStar")
    self._btnOK = set:getClickNode("btnOK")
    self._btnOK_text = set:getLabelNode("btnOK_text")
    self._modeDetail_bg_bossStage = set:getElfNode("modeDetail_bg_bossStage")
    self._modeDetail_bg_bossStage_btnChallenge = set:getClickNode("modeDetail_bg_bossStage_btnChallenge")
    self._modeDetail_bg_bossStage_btnChallenge_text = set:getLabelNode("modeDetail_bg_bossStage_btnChallenge_text")
    self._modeDetail_bg_bossStage_pet = set:getElfNode("modeDetail_bg_bossStage_pet")
    self._modeDetail_bg_bossStage_pet_icon = set:getElfNode("modeDetail_bg_bossStage_pet_icon")
    self._modeDetail_bg_bossStage_pet_boss = set:getElfNode("modeDetail_bg_bossStage_pet_boss")
    self._modeDetail_bg_bossStage_pet_name = set:getLabelNode("modeDetail_bg_bossStage_pet_name")
    self._modeDetail_bg_bossStage_pet_starLayout = set:getLayoutNode("modeDetail_bg_bossStage_pet_starLayout")
    self._modeDetail_layoutStar_v = set:getLabelNode("modeDetail_layoutStar_v")
    self._modeDetail_rewardIndex = set:getLabelNode("modeDetail_rewardIndex")
    self._modeDetail_btnReward = set:getButtonNode("modeDetail_btnReward")
    self._modeDetail_btnReward_icon = set:getElfNode("modeDetail_btnReward_icon")
    self._modeDetail_btnReward_animation = set:getSimpleAnimateNode("modeDetail_btnReward_animation")
    self._modeDetail_prop1 = set:getLabelNode("modeDetail_prop1")
    self._modeDetail_prop2 = set:getLabelNode("modeDetail_prop2")
    self._modeDetail_prop3 = set:getLabelNode("modeDetail_prop3")
    self._modeDetail_prop4 = set:getLabelNode("modeDetail_prop4")
    self._modeDetail_layoutReset = set:getLinearLayoutNode("modeDetail_layoutReset")
    self._modeDetail_layoutReset_k = set:getLabelNode("modeDetail_layoutReset_k")
    self._modeDetail_layoutReset_v = set:getLabelNode("modeDetail_layoutReset_v")
    self._modeDetail_btnReset = set:getClickNode("modeDetail_btnReset")
    self._modeDetail_btnReset_text = set:getLabelNode("modeDetail_btnReset_text")
    self._BG_top = set:getElfNode("BG_top")
    self._BG_top_rank = set:getLabelNode("BG_top_rank")
    self._BG_top_user = set:getLabelNode("BG_top_user")
    self._BG_top_passed = set:getLabelNode("BG_top_passed")
    self._BG_top_star = set:getLabelNode("BG_top_star")
    self._BG_top_rewards = set:getLabelNode("BG_top_rewards")
    self._BG_list = set:getListNode("BG_list")
    self._normal_bg = set:getElfNode("normal_bg")
    self._pressed_bg = set:getElfNode("pressed_bg")
    self._rankIcon = set:getElfNode("rankIcon")
    self._rankLabel = set:getLabelNode("rankLabel")
    self._name = set:getLabelNode("name")
    self._passed = set:getLabelNode("passed")
    self._star_amount = set:getLabelNode("star_amount")
    self._rewards_amount = set:getLabelNode("rewards_amount")
    self._BG_none = set:getLabelNode("BG_none")
    self._linearlayout_rankTab1 = set:getTabNode("linearlayout_rankTab1")
    self._linearlayout_rankTab2 = set:getTabNode("linearlayout_rankTab2")
    self._linearlayout_rankTab3 = set:getTabNode("linearlayout_rankTab3")
    self._linearlayout_rankTab4 = set:getTabNode("linearlayout_rankTab4")
    self._layoutAmount = set:getLinearLayoutNode("layoutAmount")
    self._layoutAmount_v = set:getLabelNode("layoutAmount_v")
    self._list = set:getListNode("list")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._count = set:getLabelNode("count")
    self._title = set:getLabelNode("title")
    self._layoutCount = set:getLinearLayoutNode("layoutCount")
    self._layoutCount_value = set:getLabelNode("layoutCount_value")
    self._btnOk = set:getClickNode("btnOk")
    self._btnOk_text = set:getLabelNode("btnOk_text")
    self._layoutTrialCoin = set:getLinearLayoutNode("layoutTrialCoin")
    self._layoutTrialCoin_v = set:getLabelNode("layoutTrialCoin_v")
    self._list = set:getListNode("list")
    self._bg0 = set:getElfNode("bg0")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._btn = set:getButtonNode("btn")
    self._count = set:getLabelNode("count")
    self._piece = set:getElfNode("piece")
    self._name = set:getLabelNode("name")
    self._layoutAmount = set:getLinearLayoutNode("layoutAmount")
    self._layoutAmount_title = set:getLabelNode("layoutAmount_title")
    self._layoutAmount_value = set:getLabelNode("layoutAmount_value")
    self._layoutCoin = set:getLinearLayoutNode("layoutCoin")
    self._layoutCoin_title = set:getLabelNode("layoutCoin_title")
    self._layoutCoin_value = set:getLabelNode("layoutCoin_value")
    self._btnOk = set:getClickNode("btnOk")
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
    self._commonDialog_tab_tab4 = set:getTabNode("commonDialog_tab_tab4")
    self._commonDialog_tab_tab4_title = set:getLabelNode("commonDialog_tab_tab4_title")
    self._commonDialog_tab_tab4_point = set:getElfNode("commonDialog_tab_tab4_point")
    self._commonDialog_btnHelp = set:getButtonNode("commonDialog_btnHelp")
--    self._@pageSurvival = set:getElfNode("@pageSurvival")
--    self._@itemModePick = set:getElfNode("@itemModePick")
--    self._@pickSatr = set:getElfNode("@pickSatr")
--    self._@star = set:getElfNode("@star")
--    self._@pageRank = set:getElfNode("@pageRank")
--    self._@cellClick = set:getTabNode("@cellClick")
--    self._@pageReward = set:getElfNode("@pageReward")
--    self._@rewardItem = set:getElfNode("@rewardItem")
--    self._@pageShop = set:getElfNode("@pageShop")
--    self._@shopItem = set:getElfNode("@shopItem")
end
--@@@@]]]]

--------------------------------override functions----------------------

local Launcher = require 'Launcher'
Launcher.register("DTrials", function ( userData )
	if UnlockManager:isUnlock("AdventureLv") then
	 	Launcher.callNet(netModel.getModelAdvGet(),function ( data )
	 		if data and data.D then
	 			Launcher.Launching(data)
	 		end
	 	end)
	else
		return GleeCore:toast(UnlockManager:getUnlockConditionMsg("AdventureLv"))
	end
end)

function DTrials:onInit( userData, netData )
	if netData and netData.D then
		self:updateAdventureData( netData.D.Adventure )
	end 

	self.tabIndexSelected = tabList.TabTrial
	if userData and userData.isBattleReturnBack then
		if self.Adventure.CurrentType == 0 then
			self.isChoseMode = true
			userData.isBattleReturnBack = false
		else
			self.isChoseMode = not userData.isBattleReturnBack
		end
	else
		self.isChoseMode = true
	end

	self:broadcastEvent()
	self:setListenerEvent()
	self:initPageArray()
	self:updatePages()
	Res.doActionDialogShow(self._commonDialog, function ( ... )
		if userData and userData.isBattleReturnBack == false then
			self:toast(res.locString("Trials$challengeResetedTip"))
		end
		require 'GuideHelper':check('DTrials')
	end)
end

function DTrials:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DTrials:updateAdventureData( data )
	if data then
		local oldAdventure = self.Adventure
		self.Adventure = data
		if data.CurrentType == 0 then
			if oldAdventure then
				self.isChoseMode = true
				self:updatePages()
				if oldAdventure.CurrentType > 0 then
					self:toast(res.locString("Trials$challengeResetedTip"))
				end
			end
		end
	end
end

function DTrials:broadcastEvent( ... )
	-- body
end

function DTrials:setListenerEvent( ... )
	for i=1,tabList.TabCount do
		if i == tabList.TabTrial then
			self[string.format("_commonDialog_tab_tab%d_title", i)]:setString(Res.locString("Trials$tabTitleTrials"))
		elseif i == tabList.TabRank then
			self[string.format("_commonDialog_tab_tab%d_title", i)]:setString(Res.locString("Trials$tabTitleRank"))
		elseif i == tabList.TabReward then
			self[string.format("_commonDialog_tab_tab%d_title", i)]:setString(Res.locString("Trials$tabTitleReward"))
		elseif i == tabList.TabShop then
			self[string.format("_commonDialog_tab_tab%d_title", i)]:setString(Res.locString("Trials$tabTitleShop"))
		end
		require 'LangAdapter'.fontSize(self[string.format("_commonDialog_tab_tab%d_title", i)], nil, nil, 22, nil, 22, nil, nil, nil, nil, 18)

		self[string.format("_commonDialog_tab_tab%d_point", i)]:setVisible(false)
		self[string.format("_commonDialog_tab_tab%d", i)]:setListener(function ( ... )
			if self.tabIndexSelected ~= i then
				self.tabIndexSelected = i
				self:updatePages(true)
			end
		end)
	end

	self._commonDialog_btnHelp:setListener(function ( ... )
		GleeCore:showLayer("DHelp", {type = "无尽试炼"})
	end)

	self._commonDialog_btnClose:setListener(function ( ... )
		Res.doActionDialogHide(self._commonDialog, self)
	end)

	self._clickBg:setListener(function ( ... )
		Res.doActionDialogHide(self._commonDialog, self)
	end)
end

function DTrials:initPageArray( ... )
	local dyList = {
		[tabList.TabTrial] = "@pageSurvival", 
		[tabList.TabRank] = "@pageRank", 
		[tabList.TabReward] = "@pageReward",
		[tabList.TabShop] = "@pageShop"
	}
	self.pageList = {}
	for i,v in ipairs(dyList) do
		local set = self:createLuaSet(v)
		self._commonDialog_cnt_page:addChild(set[1])
		set[1]:setVisible(false)
		table.insert(self.pageList, set)
	end
end

function DTrials:updatePages( ... )
	for i,v in ipairs(self.pageList) do
		v[1]:setVisible(i == self.tabIndexSelected)
	end

	self[string.format("_commonDialog_tab_tab%d", self.tabIndexSelected)]:trigger(nil)
	self:updateTabNameColor()
	
	if self.tabIndexSelected == tabList.TabTrial then
		self:updateTrial()
	elseif self.tabIndexSelected == tabList.TabRank then
		self:updateRank()
	elseif self.tabIndexSelected == tabList.TabReward then
		self:updateReward()
	elseif self.tabIndexSelected == tabList.TabShop then
		self:updateShop()
	end
end

function DTrials:updateTabNameColor( ... )
	for i=1,tabList.TabCount do
		local titleNode = self[string.format("_commonDialog_tab_tab%d_title", i)]
		if self.tabIndexSelected == i then
			titleNode:setFontFillColor(Res.tabColor2.selectedTextColor, true)
			titleNode:enableStroke(Res.tabColor2.selectedStrokeColor, 2, true)
		else
			titleNode:setFontFillColor(Res.tabColor2.unselectTextColor, true)
			titleNode:enableStroke(Res.tabColor2.unselectStrokeColor, 2, true)
		end
	end
end

function DTrials:updateTrial( ... )
	local setTrail = self.pageList[tabList.TabTrial]
	setTrail["modeChose"]:setVisible(self.isChoseMode)
	setTrail["modeDetail"]:setVisible(not self.isChoseMode)
	if self.isChoseMode then
		self:updateChoseMode()
	else
		self:updateTrailMain()
	end
end

function DTrials:updateChoseMode( ... )
	local dataAdventure = self.Adventure
	local setTrail = self.pageList[tabList.TabTrial]
	local unlockLvList = {"AdventureLv", "Adventure1Lv", "Adventure2Lv", "Adventure3Lv"}
	for i=1,4 do
		local unlockLv = UnlockManager:getUnlockLv(unlockLvList[i])
		local petLvLimit = dbManager.getInfoAdvConfigWithType(i).PetLv
		setTrail[string.format("modeChose_bg_btn%d_normal_locked", i)]:setVisible(userFunc.getLevel() < unlockLv)
		setTrail[string.format("modeChose_bg_btn%d_pressed_locked", i)]:setVisible(userFunc.getLevel() < unlockLv)
		setTrail[string.format("modeChose_bg_btn%d_normal_Lv", i)]:setString( string.format(res.locString("Trials$whichLevel"), petLvLimit) )
		setTrail[string.format("modeChose_bg_btn%d_pressed_Lv", i)]:setString( string.format(res.locString("Trials$whichLevel"), petLvLimit) )
		setTrail[string.format("modeChose_bg_btn%d_normal_fighting", i)]:setVisible(dataAdventure.CurrentType == i)
		setTrail[string.format("modeChose_bg_btn%d_pressed_fighting", i)]:setVisible(dataAdventure.CurrentType == i)
		if dataAdventure.CurrentType == i then
			setTrail[string.format("modeChose_bg_btn%d_normal_fighting", i)]:stopAllActions()
			setTrail[string.format("modeChose_bg_btn%d_normal_fighting", i)]:runAction(res.getFadeAction(1))
			setTrail[string.format("modeChose_bg_btn%d_pressed_fighting", i)]:stopAllActions()
			setTrail[string.format("modeChose_bg_btn%d_pressed_fighting", i)]:runAction(res.getFadeAction(1))
		end

		setTrail[string.format("modeChose_bg_btn%d", i)]:setListener(function ( ... )
			if userFunc.getLevel() >= unlockLv then
				if dataAdventure.CurrentType == 0 or dataAdventure.CurrentType == i then
					if self:checkModeLv( petLvLimit ) then
						self:send(netModel.getModelAdvChooseType(i), function ( data )
							if data and data.D then
								if dataAdventure.PopUp == true then
									data.D.Adventure.PopUp = true
								end
								self:updateAdventureData( data.D.Adventure )
								self.isChoseMode = false
								self:updatePages()
							end
						end)
					else
						self:toast(res.locString("Trails$lvError"))
					end
				else
					self:toast(res.locString(string.format("Trials$modeError%d", dataAdventure.CurrentType)))
				end
			else
				self:toast(string.format(res.locString("Trials$unLockedTip"), unlockLv))
			end
		end)
	end
end

function DTrials:checkModeLv( unlockLv )
	local result = true
	local petIdList = teamFunc.getPetIdListWithBench()
	for i,v in ipairs(petIdList) do
		local nPet = petFunc.getPetWithId(v)
		if nPet and nPet.Lv > unlockLv then
			result = false
			break
		end
	end
	if result then
		local equipFunc = gameFunc.getEquipInfo()
		for i,v in ipairs(petIdList) do
			local equipList = equipFunc.getEquipListWithPetId( v )
			if equipList then
				for i2,v2 in ipairs(equipList) do
					if v2.Lv > unlockLv then
						result = false
						break
					end
				end
			end
			if not result then
				break
			end
		end
	end
	return result
end

function DTrials:updateTrailMain( ... )
	local dataAdventure = self.Adventure
	assert(dataAdventure.CurrentType > 0)
	local setTrail = self.pageList[tabList.TabTrial]
	setTrail["modeDetail_bg"]:setResid( string.format("WJSL_SL_ms%d.png", dataAdventure.CurrentType) )
	setTrail["modeDetail_bg_curStage"]:setString(string.format(res.locString("Trials$stageIndex"), dataAdventure.CurrentStage))
	local colorList = {ccc4f(0, 0.2157, 0.02, 1.0), ccc4f(0.0235, 0.216, 0.3, 1.0),
					ccc4f(0.247, 0.03, 0.27, 1.0), ccc4f(0.345, 0.047, 0, 1.0)}
	setTrail["modeDetail_bg_curStage"]:setFontFillColor(colorList[dataAdventure.CurrentType], true)
	require 'LangAdapter'.selectLang(nil, nil, nil, function ( ... )
		setTrail["modeDetail_bg_curStage"]:setPosition(ccp(-25.857143,114.28572))
	end, function ( ... )
		setTrail["modeDetail_bg_curStage"]:setPosition(ccp(40,114.28572))
	end, nil, function ( ... )
		setTrail["modeDetail_bg_curStage"]:setPosition(ccp(-42.857143,114.28572))
	end, nil, function ( ... )
		setTrail["modeDetail_bg_curStage"]:setPosition(ccp(34.285717,122.85715))
	end)

	setTrail["modeDetail_bg_layoutMode"]:removeAllChildrenWithCleanup(true)
	local function challengeEvent( stageType )
		stageType = stageType or 2
		self:send(netModel.getModelAdvChooseStageType(stageType), function ( data )
			if data and data.D then
				self:updateAdventureData(data.D.Adventure)
				self:updatePages()

				local function startBattle( ... )
					if data.D.NpcPets then
						local startGameData = {}
						startGameData.type = 'train'
						startGameData.data = {}
						startGameData.data.myTeam = {}
						startGameData.data.npcTeam = {}

						local petIdList = teamFunc.getPetIdListWithBench()
						for i,v in ipairs(petIdList) do
							local nPet = table.clone( petFunc.getPetWithId(v) )
							self:getPetWithBufferList(nPet, data.D.Adventure.Buffs)
							table.insert(startGameData.data.myTeam, petFunc.convertToDungeonDataEncode(nPet, false) )	
						end

						for i,nPet in ipairs( data.D.NpcPets ) do
							table.insert(startGameData.data.npcTeam, petFunc.convertToDungeonData(nPet, false) )
						end
						print("startGameData:")
						print(startGameData)
						EventCenter.eventInput("BattleStart", startGameData)	
					end
				end
				startBattle()
			end
		end)
	end
	local function challengeFastEvent( ... )
		self:send(netModel.getModelAdvFast(), function ( data )
			if data and data.D then
				if data.D.Star and data.D.Star > 0 then
					local nReward = {}
					nReward.TrialStar = data.D.Star
					if data.D.Coin > 0 then
						nReward.AdvCoin = data.D.Coin
					end
					GleeCore:showLayer("DGetReward", {rewardType = "TrialFast", reward = nReward, callback = function ( ... )
						self:updateAdventureData(data.D.Adventure)
						self:updatePages()
					end})
				else -- 关卡已重置
					self:updateAdventureData(data.D.Adventure)
					self:updatePages()
				end
			end
		end)
	end

	if math.fmod(dataAdventure.CurrentStage, 10) == 0 then
		setTrail["modeDetail_bg_layoutMode"]:setVisible(false)
		setTrail["modeDetail_bg_bossStage"]:setVisible(true)
		setTrail["modeDetail_bg_bossStage_btnChallenge_text"]:setString(dataAdventure.Fast and res.locString("Town$BattleSpeed") or res.locString("Global$Challenge"))
		setTrail["modeDetail_bg_bossStage_btnChallenge"]:setListener(function ( ... )
			if dataAdventure.Fast then
				challengeFastEvent()
			else
				challengeEvent()
			end
		end)
		res.setNodeWithPet( setTrail["modeDetail_bg_bossStage_pet_icon"], dataAdventure.BossPet )
		setTrail["modeDetail_bg_bossStage_pet_name"]:setString( dataAdventure.BossPet.Name )
		local dbPet = dbManager.getCharactor(dataAdventure.BossPet.PetId)
		require 'PetNodeHelper'.updateStarLayout(setTrail["modeDetail_bg_bossStage_pet_starLayout"], dbPet)
	else
		setTrail["modeDetail_bg_layoutMode"]:setVisible(true)
		setTrail["modeDetail_bg_bossStage"]:setVisible(false)
		local tipList = {"WJSL_SL_putong.png", "WJSL_SL_jingying.png", "WJSL_SL_yingxiong.png"}
		for i=1,3 do
			local nPet = dataAdventure[string.format("NpcPet%d", i)]
			local dbPet = nPet and dbManager.getCharactor(nPet.PetId) or nil

			local itemModePickSet = self:createLuaSet("@itemModePick")
			setTrail["modeDetail_bg_layoutMode"]:addChild(itemModePickSet[1])
			itemModePickSet["bg"]:setResid(string.format("WJSL_SL_touxiang%d.png", i))
			res.setNodeWithPet(itemModePickSet["icon"], nPet)
			itemModePickSet["tip"]:setResid(tipList[i])
			itemModePickSet["name"]:setString(dbPet.name)
			if i == 3 then
				itemModePickSet["name"]:setFontFillColor( colorList[4], true )
			else
				itemModePickSet["name"]:setFontFillColor( colorList[i], true )
			end
			
			itemModePickSet["layoutStar"]:removeAllChildrenWithCleanup(true)
			for j=1,i do
				local starSet = self:createLuaSet("@pickSatr")
				itemModePickSet["layoutStar"]:addChild(starSet[1])
			end

			itemModePickSet["btnOK_text"]:setString(dataAdventure.Fast and res.locString("Town$BattleSpeed") or res.locString("Global$Challenge"))
			itemModePickSet["btnOK"]:setEnabled(dataAdventure.Fast or dataAdventure.CurrentStageType == 0 or dataAdventure.CurrentStageType == i)
			itemModePickSet["btnOK"]:setListener(function ( ... )
				if dataAdventure.Fast then
					challengeFastEvent()
				else
					challengeEvent(i)
				end
			end)
		end	
	end

	setTrail["modeDetail_layoutStar_v"]:setString( dataAdventure.Stars )
	setTrail["modeDetail_rewardIndex"]:setString(string.format(res.locString("Trials$rewardIndex"), dataAdventure.BoxOfStage))
	require 'LangAdapter'.fontSize(setTrail["modeDetail_rewardIndex"], nil, nil, nil, 20)
	require 'LangAdapter'.fontSize(setTrail["modeDetail_layoutStar_#k"], nil, nil, nil, 20)
	require 'LangAdapter'.fontSize(setTrail["modeDetail_layoutStar_v"], nil, nil, nil, 20)

	setTrail["modeDetail_btnReward_icon"]:setVisible( dataAdventure.CurrentStage <= dataAdventure.BoxOfStage )
	setTrail["modeDetail_btnReward_animation"]:setVisible( dataAdventure.CurrentStage > dataAdventure.BoxOfStage )
	setTrail["modeDetail_btnReward"]:setEnabled( dataAdventure.CurrentStage > dataAdventure.BoxOfStage )
	setTrail["modeDetail_btnReward"]:setListener(function ( ... )
		GleeCore:showLayer("DTrialReward", {seniorReward = dataAdventure.CurrentType > 2, callBack = function ( data )
			self:updateAdventureData(data)
			self:updatePages()
		end})
	end)

	for i=1,4 do
		local rate = self:getBufferWithType(i)
		setTrail[string.format("modeDetail_prop%d", i)]:setString( string.format(res.locString(string.format("Trials$Buff%d", i)), math.floor(rate * 100)) )
		require 'LangAdapter'.fontSize(setTrail[string.format("modeDetail_prop%d", i)], nil, nil, 20, 20)
	end
	require 'LangAdapter'.fontSize(setTrail["modeDetail_layoutReset_k"], nil, nil, 20, 20)
	require 'LangAdapter'.fontSize(setTrail["modeDetail_layoutReset_v"], nil, nil, 20, 20)

	setTrail["modeDetail_layoutReset_v"]:setString(string.format(res.locString("Trials$resetCount"), dataAdventure.ResetCntLeft))
	setTrail["modeDetail_btnReset"]:setEnabled(dataAdventure.ResetCntLeft > 0)
	require 'LangAdapter'.fontSize(setTrail["modeDetail_btnReset_text"], nil, nil, 20,nil,nil,nil,nil,nil,nil,20)

	local function showBuffer( ... )
		if dataAdventure.Rs and #dataAdventure.Rs == 3 then
			GleeCore:showLayer("DTrialBuffer", {data = dataAdventure, callback = function ( data )
				if not self:isDisposed() then
					self:updateAdventureData( data )
					self:updatePages()
				end
			end})
		end
	end

	local function showBattleFast( ... )
		if userFunc.getVipLevel() >= 1 and dataAdventure.CurrentStage == 1 and dataAdventure.Fast then
			local param = {}
			param.content = string.format(res.locString("Trials$BattleSpeedStageIndex"), dataAdventure.FastBy + 1)
			param.callback = function ( ... )
				self:send(netModel.getModelAdvFastAll(), function ( data )
					if data and data.D then
						self:updateAdventureData( data.D.Adventure )
						self:updatePages()
						showBuffer()
					end
				end)
			end
			GleeCore:showLayer("DConfirmNT", param)
		else
			showBuffer()
		end
	end

	setTrail["modeDetail_btnReset"]:setListener(function ( ... )
		local param = {}
		param.title = res.locString("Trials$resetTitle")
		param.content = res.locString("Trials$resetDes")
		param.callback = function ( ... )
			self:send(netModel.getModelAdvReset(), function ( data )
				if data and data.D then
					self:updateAdventureData( data.D.Adventure )
					self:updatePages()
				end
			end)
		end
		GleeCore:showLayer("DConfirmNT", param)
	end)

	self:runWithDelay(function ( ... )
		self:showStarLayer(showBattleFast)
	end, 0.5)
end

function DTrials:getPetWithBufferList( nPet, bufferList )
	if bufferList then
		local CSValueConverter = require 'CSValueConverter'
		for k,v in pairs(bufferList) do
			if v.Type == 1 then
				nPet._Atk = CSValueConverter.toC( CSValueConverter.toS(nPet._Atk) * (1 + v.Rate) )
			elseif v.Type == 2 then
				nPet._Def = CSValueConverter.toC( CSValueConverter.toS(nPet._Def) * (1 + v.Rate) )
			elseif v.Type == 3 then
				nPet._Hp = CSValueConverter.toCHp( CSValueConverter.toSHp(nPet._Hp) * (1 + v.Rate) )
			elseif v.Type == 4 then
				nPet.Gb = nPet.Gb or {}
				nPet.Gb.m = nPet.Gb.m or 0
				nPet.Gb.m = nPet.Gb.m + v.Rate
			end
		end
	end
	return nPet
end

function DTrials:showStarLayer( callback )
	if self.Adventure and self.Adventure.PopUp then
		self.Adventure.PopUp = false
		local param = {}
		param.title = res.locString("Trials$starRewardTitle")
		param.content = string.format(res.locString("Trials$starRewardDes"), self.Adventure.Stars)
		param.hideCancel = true
		param.callback = callback
		GleeCore:showLayer("DConfirmNT", param, 2)
	else
		if callback then
			callback()
		end
	end
end

function DTrials:getBufferWithType( type )
	local result = 0
	if self.Adventure.Buffs then
		for k,v in pairs(self.Adventure.Buffs) do
			if v.Type == type then
				result = v.Rate
				break
			end
		end
	end
	return result
end

function DTrials:updateReward( ... )
	local setReward = self.pageList[tabList.TabReward]
	setReward["layoutAmount_v"]:setString( self.Adventure.TodayBoxGot )

	if not self.rewardList then
		self.rewardList = LuaList.new(setReward["list"], function ( ... )
			return self:createLuaSet("@rewardItem")
		end, function ( nodeLuaSet, data )
			nodeLuaSet["count"]:setString("x" .. data.count)
			nodeLuaSet["layoutCount_value"]:setString(data.Cnt)
			local isDone = self.Adventure.TodayBoxGot >= data.Cnt
			if isDone then
				nodeLuaSet["layoutCount_value"]:setFontFillColor(ccc4f(0.149, 0.635, 0.19, 1), true)
				if table.find(self.Adventure.BoxRwdGots, data.ID) then
					nodeLuaSet["btnOk_text"]:setString(res.locString("Global$ReceiveFinish"))
				else
					nodeLuaSet["btnOk_text"]:setString(res.locString("Global$Receive"))
				end
			else
				nodeLuaSet["layoutCount_value"]:setFontFillColor(ccc4f(0.8588, 0.094, 0.106, 1), true)
				nodeLuaSet["btnOk_text"]:setString(res.locString("Trials$notDone"))
			end
			nodeLuaSet["btnOk"]:setEnabled(isDone and not table.find(self.Adventure.BoxRwdGots, data.ID))
			nodeLuaSet["btnOk"]:setListener(function ( ... )
				self:send(netModel.getModelAdvBoxRwdGet(data.ID), function ( data )
					if data and data.D then
						gameFunc.updateResource(data.D.Resource)
						res.doActionGetReward(data.D.Reward)

						self:updateAdventureData( data.D.Adventure )
						self:updatePages()
					end
				end)
			end)
		end)
	end
	self.rewardList:update( self:getTrialsRewardList() )
end

function DTrials:getTrialsRewardList( ... )
	local result = {}
	local rwdList = require "AdvBoxRwdConfig"
	for i,v in ipairs(rwdList) do
		local dbReward = dbManager.getRewardItem(v.RewardId)
		if dbReward then
			local item = res.getDetailByDBReward(dbReward)
			item.ID = v.ID
			item.Cnt = v.Cnt
			table.insert(result, item)
		end
	end
	return result
end

function DTrials:updateShop( ... )
	local setShop = self.pageList[tabList.TabShop]
	setShop["layoutTrialCoin_v"]:setString(self.Adventure.Coin)
	if not self.shopList then
		self.shopList = LuaList.new(setShop["list"], function ( ... )
			return self:createLuaSet("@shopItem")
		end, function ( item, v )
			local scaleOrigal = 102 / 155
			if v.type == "Gem" then
				item["name"]:setString(v.name .. " Lv." .. v.lv)
			else
				item["name"]:setString(v.name)
			end
			
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
			item["count"]:setString("x" .. v.count)
			item["count"]:setVisible(v.count > 1)
			item["piece"]:setVisible(v.isPiece)
			item["btn"]:setListener(function ( ... )
				if v.eventData then
					GleeCore:showLayer(v.eventData.dialog, v.eventData.data)
				end
			end)

			if v.isGlobal then
				item["layoutAmount_title"]:setString(res.locString("Trials$shopExchangeCount1"))
			else
				item["layoutAmount_title"]:setString(res.locString("Trials$shopExchangeCount2"))
			end
			item["layoutAmount_value"]:setString(v.TodayLast)
			item["layoutAmount_value"]:setFontFillColor(v.TodayLast > 0 and ccc4f(0.149, 0.635, 0.19, 1) or ccc4f(0.8588, 0.094, 0.106, 1), true)

			if self.Adventure.Coin >= v.Coin then
				item["layoutCoin_title"]:setFontFillColor(ccc4f(0.78,0.42,0.06,1.0), true)
				item["layoutCoin_value"]:setFontFillColor(ccc4f(0.78,0.42,0.06,1.0), true)
			else
				item["layoutCoin_title"]:setFontFillColor(ccc4f(0.8588, 0.094, 0.106, 1), true)
				item["layoutCoin_value"]:setFontFillColor(ccc4f(0.8588, 0.094, 0.106, 1), true)
			end
			item["layoutCoin_value"]:setString(v.Coin)
			item["btnOk"]:setEnabled(self.Adventure.Coin >= v.Coin and v.TodayLast > 0)
			item["btnOk"]:setListener(function ( ... )
				local function advExchange ( ... )
					self:send(netModel.getModelAdvExchange(v.ID), function ( data )
						gameFunc.updateResource(data.D.Resource)
						res.doActionGetReward(data.D.Reward)

						self:updateAdventureData( data.D.Adventure )
						self:updatePages()
					end)
				end
				local LangName = require 'Config'.LangName or ''
				if LangName ~= "kor" then
					advExchange()
				else
					local param = {}
					param.content = "구매하시겠습니까?"
					param.callback = advExchange
					GleeCore:showLayer("DConfirmNT", param)
				end
			end)
		end)
	end
	self.shopList:update(self:getTrialShopItemList())
end

function DTrials:getTrialShopItemList( ... )
	local result = {}
	local itemList = require "AdvExchangeConfig"
	for i,v in ipairs(itemList) do
		local dbReward = dbManager.getRewardItem(v.RewardId)
		if dbReward then
			local item = res.getDetailByDBReward(dbReward)
			item.ID = v.ID
			item.isGlobal = v.Global > 0
			item.Coin = v.Coin
			if v.Global > 0 then
				item.TodayLast = math.max(v.Global - (self.Adventure.GlobalExchange[tostring(v.ID)] or 0), 0)
				if item.TodayLast > 0 then
					table.insert(result, item)
				end
			else
				item.TodayLast = math.max(v.Total - (self.Adventure.TodayExchange[tostring(v.ID)] or 0), 0)
				table.insert(result, item)
			end
		end
	end
	return result
end

------------------------------------------------Rank------------------------------------------------------------------------

function DTrials:callNetRankDataAndRefresh(model)
	-- body
	-- local data = {}
	-- for i = 1, 30 do
	-- 	local cell = {rank = i, name = 'name'..tostring(i), passed = i * 10, star = i * 30 + 10, rewards = i * 6 }
	-- 	table.insert(data, cell)
	-- end

    self:send(netModel.getModelAdvRanks(model),function ( data )
    	--print('msg:----------------call net model:  '..tostring(model))
    	--print(data.D)
        if data and data.D then
            self:refreshRankList(data.D.Ranks)
        end
    end)
end

-- Rank Int 排名
-- Name String 玩家昵称
-- Stage Int 关卡数
-- Stars Int 星星数
-- Coin Int 可获得的钻石数

function DTrials:refreshRankList(data)
	local pageSet = self.pageList[tabList.TabRank]
	if not data or not next(data) then
		pageSet['BG_none']:setVisible(true)
		return
	else
		pageSet['BG_none']:setVisible(false)
	end

	for k, v in pairs(data) do
		local set = self:getRankCellSet(pageSet['BG_list']:getContainer(), k)
		set[1]:setScale(1)
		if k < 4 then
			set['rankIcon']:setVisible(true)
			set['rankLabel']:setVisible(false)
			set['rankIcon']:setResid(string.format('PHB_PM%d.png', k))
		else
			set['rankIcon']:setVisible(false)
			set['rankLabel']:setVisible(true)
			set['rankLabel']:setString(k)
		end

		if k % 2 == 1 then
			set['normal_bg']:setVisible(true)
            set['pressed_bg']:setVisible(true)
		else
			set['normal_bg']:setVisible(false)
            set['pressed_bg']:setVisible(false)
		end

		set['name']:setString(v.Name)
		set['passed']:setString(v.Stage)
		set['star_amount']:setString(v.Stars)
		set['rewards_amount']:setString(v.Coin)
	end
end

function DTrials:getRankCellSet(container, index)
	if not self.rankSets then
		self.rankSets = {}
	end

	if not self.rankSets[index] then
		local set = self:createLuaSet('@cellClick')
		table.insert(self.rankSets, set)
		container:addChild(set[1])
	end
	return self.rankSets[index]
end

function DTrials:updateRank( ... )
	-- body
	local set = self.pageList[tabList.TabRank]
	local netFunc = {1, 2, 3, 4}
	for i = 1, 4 do
		set[string.format('linearlayout_rankTab%d', i)]:setListener(function()
			--print('msg:--------btn clicked')
			self:hideListCell()
			self:callNetRankDataAndRefresh(i)
		end)
	end

	if self.Adventure and self.Adventure.CurrentType and (self.Adventure.CurrentType > 0 and self.Adventure.CurrentType < 5 )then
		--print('msg:---------------------self.Adventure.CurrentType: '..tostring(self.Adventure.CurrentType))
		set[string.format('linearlayout_rankTab%d', self.Adventure.CurrentType)]:trigger(nil)
	else
		set['linearlayout_rankTab1']:trigger(nil)
	end
end

function DTrials:hideListCell()
	if not self.rankSets then
		return
	end

	for k, v in pairs(self.rankSets) do
		--print('msg:------------cellhide:  '..tostring(k))
		local set = self:getRankCellSet(nil, k)
		--set[1]:setVisible(false)
		set[1]:setScale(0)
	end
end

------------------------------------------------Rank------------------------------------------------------------------------

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DTrials, "DTrials")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DTrials", DTrials)


