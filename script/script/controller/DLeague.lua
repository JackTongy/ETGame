local Config = require "Config"
local Res = require "Res"
local res = Res
local dbManager = require "DBManager"
local DBManager = dbManager
local LuaList = require "LuaList"
local netModel = require "netModel"
local NetModel = netModel
local EventCenter = require "EventCenter"
local gameFunc = require "AppData"
local UnlockManager = require 'UnlockManager'

local userFunc = gameFunc.getUserInfo()
local petFunc = gameFunc.getPetInfo()
local teamFunc = gameFunc.getTeamInfo()
local leagueData = {}

local tabList = {
	["TabMain"] = 1,
	["TabLeague"] = 2, 
	["TabRankTopServer"] = 3,
	["TabRankCurServer"] = 4, 
	["TabShop"] = 5,
	["TabCount"] = 5,
}

local DLeague = class(LuaDialog)

function DLeague:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DLeague.cocos.zip")
    return self._factory:createDocument("DLeague.cocos")
end

--@@@@[[[[
function DLeague:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_page = set:getElfNode("commonDialog_cnt_page")
    self._root = set:getElfNode("root")
    self._root_bg = set:getElfNode("root_bg")
    self._root_layout = set:getLayoutNode("root_layout")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._btnDetail = set:getButtonNode("btnDetail")
    self._name = set:getLabelNode("name")
    self._layoutFrom = set:getLinearLayoutNode("layoutFrom")
    self._layoutFrom_k = set:getLabelNode("layoutFrom_k")
    self._layoutFrom_v = set:getLabelNode("layoutFrom_v")
    self._layoutBattle = set:getLinearLayoutNode("layoutBattle")
    self._layoutBattle_k = set:getLabelNode("layoutBattle_k")
    self._layoutBattle_v = set:getLabelNode("layoutBattle_v")
    self._btnChallenge = set:getClickNode("btnChallenge")
    self._btnChallenge_text = set:getLabelNode("btnChallenge_text")
    self._tip = set:getLabelNode("tip")
    self._root_layoutTime = set:getLinearLayoutNode("root_layoutTime")
    self._root_layoutTime_k = set:getLabelNode("root_layoutTime_k")
    self._root_layoutTime_v = set:getTimeNode("root_layoutTime_v")
    self._root_layoutLastCount = set:getLinearLayoutNode("root_layoutLastCount")
    self._root_layoutLastCount_k = set:getLabelNode("root_layoutLastCount_k")
    self._root_layoutLastCount_v = set:getLabelNode("root_layoutLastCount_v")
    self._root_layoutBV = set:getLinearLayoutNode("root_layoutBV")
    self._root_layoutBV_k = set:getLabelNode("root_layoutBV_k")
    self._root_layoutBV_v = set:getLabelNode("root_layoutBV_v")
    self._root_btnRecover = set:getClickNode("root_btnRecover")
    self._root_btnRecover_text = set:getLabelNode("root_btnRecover_text")
    self._root_btnSwitchTeam = set:getClickNode("root_btnSwitchTeam")
    self._root_btnSwitchTeam_text = set:getLabelNode("root_btnSwitchTeam_text")
    self._root_btnChangeOpponent = set:getClickNode("root_btnChangeOpponent")
    self._root_btnChangeOpponent_text = set:getLabelNode("root_btnChangeOpponent_text")
    self._root_cost = set:getLabelNode("root_cost")
    self._over = set:getElfNode("over")
    self._over_time = set:getLabelNode("over_time")
    self._BG_layout = set:getListContainerNode("BG_layout")
    self._BG_layout_level7 = set:getColorClickNode("BG_layout_level7")
    self._BG_layout_level7_icon = set:getElfNode("BG_layout_level7_icon")
    self._BG_layout_level7_title = set:getElfNode("BG_layout_level7_title")
    self._BG_layout_level6 = set:getColorClickNode("BG_layout_level6")
    self._BG_layout_level6_icon = set:getElfNode("BG_layout_level6_icon")
    self._BG_layout_level6_title = set:getElfNode("BG_layout_level6_title")
    self._BG_layout_level6_arrow = set:getElfNode("BG_layout_level6_arrow")
    self._BG_layout_level5 = set:getColorClickNode("BG_layout_level5")
    self._BG_layout_level5_icon = set:getElfNode("BG_layout_level5_icon")
    self._BG_layout_level5_title = set:getElfNode("BG_layout_level5_title")
    self._BG_layout_level5_arrow = set:getElfNode("BG_layout_level5_arrow")
    self._BG_layout_level4 = set:getColorClickNode("BG_layout_level4")
    self._BG_layout_level4_icon = set:getElfNode("BG_layout_level4_icon")
    self._BG_layout_level4_title = set:getElfNode("BG_layout_level4_title")
    self._BG_layout_level4_arrow = set:getElfNode("BG_layout_level4_arrow")
    self._BG_layout_level3 = set:getColorClickNode("BG_layout_level3")
    self._BG_layout_level3_icon = set:getElfNode("BG_layout_level3_icon")
    self._BG_layout_level3_title = set:getElfNode("BG_layout_level3_title")
    self._BG_layout_level3_arrow = set:getElfNode("BG_layout_level3_arrow")
    self._BG_layout_level2 = set:getColorClickNode("BG_layout_level2")
    self._BG_layout_level2_icon = set:getElfNode("BG_layout_level2_icon")
    self._BG_layout_level2_title = set:getElfNode("BG_layout_level2_title")
    self._BG_layout_level2_arrow = set:getElfNode("BG_layout_level2_arrow")
    self._BG_layout_level1 = set:getColorClickNode("BG_layout_level1")
    self._BG_layout_level1_icon = set:getElfNode("BG_layout_level1_icon")
    self._BG_layout_level1_title = set:getElfNode("BG_layout_level1_title")
    self._BG_layout_level1_arrow = set:getElfNode("BG_layout_level1_arrow")
    self._BG_list = set:getListNode("BG_list")
    self._normal_bg = set:getElfNode("normal_bg")
    self._pressed_bg = set:getElfNode("pressed_bg")
    self._rankIcon = set:getElfNode("rankIcon")
    self._rankLabel = set:getLabelNode("rankLabel")
    self._from = set:getLabelNode("from")
    self._score = set:getLabelNode("score")
    self._name = set:getLabelNode("name")
    self._state = set:getLabelNode("state")
    self._BG_top = set:getElfNode("BG_top")
    self._BG_bottom = set:getColorClickNode("BG_bottom")
    self._BG_bottom_normal_none = set:getLabelNode("BG_bottom_normal_none")
    self._BG_bottom_normal_rankLabel = set:getLabelNode("BG_bottom_normal_rankLabel")
    self._BG_bottom_normal_from = set:getLabelNode("BG_bottom_normal_from")
    self._BG_bottom_normal_score = set:getLabelNode("BG_bottom_normal_score")
    self._BG_bottom_normal_illustrate = set:getLabelNode("BG_bottom_normal_illustrate")
    self._BG_bottom_normal_name = set:getLabelNode("BG_bottom_normal_name")
    self._BG_bottom_normal_state = set:getLabelNode("BG_bottom_normal_state")
    self._BG_none = set:getLabelNode("BG_none")
    self._top = set:getElfNode("top")
    self._top_cur = set:getElfNode("top_cur")
    self._top_cur_icon = set:getElfNode("top_cur_icon")
    self._top_cur_reward = set:getLinearLayoutNode("top_cur_reward")
    self._top_cur_reward_reputation = set:getLabelNode("top_cur_reward_reputation")
    self._top_next = set:getElfNode("top_next")
    self._top_next_icon = set:getElfNode("top_next_icon")
    self._top_next_reward = set:getLinearLayoutNode("top_next_reward")
    self._top_next_reward_reputation = set:getLabelNode("top_next_reward_reputation")
    self._top_tips = set:getLabelNode("top_tips")
    self._top_arrow = set:getElfNode("top_arrow")
    self._BG_layout_pet1 = set:getColorClickNode("BG_layout_pet1")
    self._BG_layout_pet1_normal_elf_frame = set:getElfNode("BG_layout_pet1_normal_elf_frame")
    self._BG_layout_pet1_normal_elf_icon = set:getElfNode("BG_layout_pet1_normal_elf_icon")
    self._BG_layout_pet1_normal_starLayout = set:getLayoutNode("BG_layout_pet1_normal_starLayout")
    self._BG_layout_pet2 = set:getColorClickNode("BG_layout_pet2")
    self._BG_layout_pet2_normal_elf_frame = set:getElfNode("BG_layout_pet2_normal_elf_frame")
    self._BG_layout_pet2_normal_elf_icon = set:getElfNode("BG_layout_pet2_normal_elf_icon")
    self._BG_layout_pet2_normal_starLayout = set:getLayoutNode("BG_layout_pet2_normal_starLayout")
    self._BG_layout_pet3 = set:getColorClickNode("BG_layout_pet3")
    self._BG_layout_pet3_normal_elf_frame = set:getElfNode("BG_layout_pet3_normal_elf_frame")
    self._BG_layout_pet3_normal_elf_icon = set:getElfNode("BG_layout_pet3_normal_elf_icon")
    self._BG_layout_pet3_normal_starLayout = set:getLayoutNode("BG_layout_pet3_normal_starLayout")
    self._BG_layout_pet4 = set:getColorClickNode("BG_layout_pet4")
    self._BG_layout_pet4_normal_elf_frame = set:getElfNode("BG_layout_pet4_normal_elf_frame")
    self._BG_layout_pet4_normal_elf_icon = set:getElfNode("BG_layout_pet4_normal_elf_icon")
    self._BG_layout_pet4_normal_starLayout = set:getLayoutNode("BG_layout_pet4_normal_starLayout")
    self._BG_layout_pet5 = set:getColorClickNode("BG_layout_pet5")
    self._BG_layout_pet5_normal_elf_frame = set:getElfNode("BG_layout_pet5_normal_elf_frame")
    self._BG_layout_pet5_normal_elf_icon = set:getElfNode("BG_layout_pet5_normal_elf_icon")
    self._BG_layout_pet5_normal_starLayout = set:getLayoutNode("BG_layout_pet5_normal_starLayout")
    self._BG_describe = set:getLabelNode("BG_describe")
    self._BG_list = set:getListNode("BG_list")
    self._normal_bg = set:getElfNode("normal_bg")
    self._pressed_bg = set:getElfNode("pressed_bg")
    self._rankIcon = set:getElfNode("rankIcon")
    self._rankLabel = set:getLabelNode("rankLabel")
    self._name = set:getLabelNode("name")
    self._from = set:getLabelNode("from")
    self._classification = set:getLabelNode("classification")
    self._score = set:getLabelNode("score")
    self._BG_top = set:getElfNode("BG_top")
    self._BG_none = set:getLabelNode("BG_none")
    self._top = set:getElfNode("top")
    self._top_pet2 = set:getColorClickNode("top_pet2")
    self._top_pet2_normal_icon = set:getElfNode("top_pet2_normal_icon")
    self._top_pet2_normal_name = set:getLabelNode("top_pet2_normal_name")
    self._top_pet3 = set:getColorClickNode("top_pet3")
    self._top_pet3_normal_icon = set:getElfNode("top_pet3_normal_icon")
    self._top_pet3_normal_name = set:getLabelNode("top_pet3_normal_name")
    self._top_pet1 = set:getColorClickNode("top_pet1")
    self._top_pet1_normal_icon = set:getElfNode("top_pet1_normal_icon")
    self._top_pet1_normal_name = set:getLabelNode("top_pet1_normal_name")
    self._BG_layout_pet1 = set:getColorClickNode("BG_layout_pet1")
    self._BG_layout_pet1_normal_elf_frame = set:getElfNode("BG_layout_pet1_normal_elf_frame")
    self._BG_layout_pet1_normal_elf_icon = set:getElfNode("BG_layout_pet1_normal_elf_icon")
    self._BG_layout_pet1_normal_starLayout = set:getLayoutNode("BG_layout_pet1_normal_starLayout")
    self._BG_layout_pet2 = set:getColorClickNode("BG_layout_pet2")
    self._BG_layout_pet2_normal_elf_frame = set:getElfNode("BG_layout_pet2_normal_elf_frame")
    self._BG_layout_pet2_normal_elf_icon = set:getElfNode("BG_layout_pet2_normal_elf_icon")
    self._BG_layout_pet2_normal_starLayout = set:getLayoutNode("BG_layout_pet2_normal_starLayout")
    self._BG_layout_pet3 = set:getColorClickNode("BG_layout_pet3")
    self._BG_layout_pet3_normal_elf_frame = set:getElfNode("BG_layout_pet3_normal_elf_frame")
    self._BG_layout_pet3_normal_elf_icon = set:getElfNode("BG_layout_pet3_normal_elf_icon")
    self._BG_layout_pet3_normal_starLayout = set:getLayoutNode("BG_layout_pet3_normal_starLayout")
    self._BG_layout_pet4 = set:getColorClickNode("BG_layout_pet4")
    self._BG_layout_pet4_normal_elf_frame = set:getElfNode("BG_layout_pet4_normal_elf_frame")
    self._BG_layout_pet4_normal_elf_icon = set:getElfNode("BG_layout_pet4_normal_elf_icon")
    self._BG_layout_pet4_normal_starLayout = set:getLayoutNode("BG_layout_pet4_normal_starLayout")
    self._BG_layout_pet5 = set:getColorClickNode("BG_layout_pet5")
    self._BG_layout_pet5_normal_elf_frame = set:getElfNode("BG_layout_pet5_normal_elf_frame")
    self._BG_layout_pet5_normal_elf_icon = set:getElfNode("BG_layout_pet5_normal_elf_icon")
    self._BG_layout_pet5_normal_starLayout = set:getLayoutNode("BG_layout_pet5_normal_starLayout")
    self._BG_describe = set:getLabelNode("BG_describe")
    self._BG_list = set:getListNode("BG_list")
    self._normal_bg = set:getElfNode("normal_bg")
    self._pressed_bg = set:getElfNode("pressed_bg")
    self._rankIcon = set:getElfNode("rankIcon")
    self._rankLabel = set:getLabelNode("rankLabel")
    self._name = set:getLabelNode("name")
    self._classification = set:getLabelNode("classification")
    self._score = set:getLabelNode("score")
    self._BG_top = set:getElfNode("BG_top")
    self._BG_top_power = set:getLabelNode("BG_top_power")
    self._BG_top_level = set:getLabelNode("BG_top_level")
    self._BG_none = set:getLabelNode("BG_none")
    self._top = set:getElfNode("top")
    self._top_pet2 = set:getColorClickNode("top_pet2")
    self._top_pet2_normal_icon = set:getElfNode("top_pet2_normal_icon")
    self._top_pet2_normal_name = set:getLabelNode("top_pet2_normal_name")
    self._top_pet3 = set:getColorClickNode("top_pet3")
    self._top_pet3_normal_icon = set:getElfNode("top_pet3_normal_icon")
    self._top_pet3_normal_name = set:getLabelNode("top_pet3_normal_name")
    self._top_pet1 = set:getColorClickNode("top_pet1")
    self._top_pet1_normal_icon = set:getElfNode("top_pet1_normal_icon")
    self._top_pet1_normal_name = set:getLabelNode("top_pet1_normal_name")
    self._bg = set:getJoint9Node("bg")
    self._bg_list = set:getListNode("bg_list")
    self._layout = set:getLayoutNode("layout")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._iconFrame = set:getElfNode("iconFrame")
    self._piece = set:getElfNode("piece")
    self._layoutStar = set:getLayoutNode("layoutStar")
    self._name = set:getLabelNode("name")
    self._count = set:getLabelNode("count")
    self._layoutPrice = set:getLinearLayoutNode("layoutPrice")
    self._layoutPrice_k = set:getElfNode("layoutPrice_k")
    self._layoutPrice_v = set:getLabelNode("layoutPrice_v")
    self._btnOk = set:getClickNode("btnOk")
    self._btnOk_text = set:getLabelNode("btnOk_text")
    self._btnDetail = set:getButtonNode("btnDetail")
    self._layoutRefresh_v = set:getTimeNode("layoutRefresh_v")
    self._layoutPrestige_v1 = set:getLabelNode("layoutPrestige_v1")
    self._layoutPrestige_v2 = set:getLabelNode("layoutPrestige_v2")
    self._layoutRefresh2_v3 = set:getLabelNode("layoutRefresh2_v3")
    self._btnRefresh = set:getClickNode("btnRefresh")
    self._btnRefresh_text = set:getLabelNode("btnRefresh_text")
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
    self._commonDialog_tab_tab5 = set:getTabNode("commonDialog_tab_tab5")
    self._commonDialog_tab_tab5_title = set:getLabelNode("commonDialog_tab_tab5_title")
    self._commonDialog_tab_tab5_point = set:getElfNode("commonDialog_tab_tab5_point")
    self._commonDialog_btnHelp = set:getButtonNode("commonDialog_btnHelp")
--    self._@pageMain = set:getElfNode("@pageMain")
--    self._@itemOpponent = set:getElfNode("@itemOpponent")
--    self._@pageLeague = set:getElfNode("@pageLeague")
--    self._@cellClick = set:getTabNode("@cellClick")
--    self._@pageRankTopServer = set:getElfNode("@pageRankTopServer")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@cellClick1 = set:getTabNode("@cellClick1")
--    self._@pageRankCurServer = set:getElfNode("@pageRankCurServer")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@cellClick2 = set:getTabNode("@cellClick2")
--    self._@pageShop = set:getElfNode("@pageShop")
--    self._@shopItemSize = set:getElfNode("@shopItemSize")
--    self._@shopItem = set:getElfNode("@shopItem")
end
--@@@@]]]]

--------------------------------override functions----------------------

local Launcher = require 'Launcher'
Launcher.register("DLeague", function ( userData )
	if UnlockManager:isUnlock("ChampionshipLv") then
		leagueData = {}
		Launcher.callNet(netModel.getModelCsInfo(), function ( data )
			leagueData.csInfo = data.D
			Launcher.callNet(netModel.getModelCsInfoUpdate(), function ( data )
				leagueData.csInfo.Targets = data.D.Targets
				Launcher.Launching()   
			end)
		end, function ( data )
			if data and data.Code >= 21000 and data.Code <= 21002 then
				leagueData.state = data.Code
				leagueData.matchDate = data.Msg
				Launcher.Launching()
			end
		end)
	else
		return GleeCore:toast(UnlockManager:getUnlockConditionMsg("ChampionshipLv"))
	end

	-- leagueData.state = 21000
	-- leagueData.matchDate = "2015-12-14 12:00:00"
	-- Launcher.Launching()
end)

function DLeague:onInit( userData, netData )
	self.tabIndexSelected = tabList.TabMain
	self:broadcastEvent()
	self:setListenerEvent()
	self:initPageArray()
	self:initRankData(userData and userData.historyData)
	self:updatePages()
	Res.doActionDialogShow(self._commonDialog)

	if (not leagueData.state) and userData and userData.isWin == false then	
		self:runWithDelay(function ( ... )
			self:showRecoverLayer()
		end, 0.5)
	end
end

function DLeague:onBack( userData, netData )
	self:updatePages()
end

--------------------------------custom code-----------------------------

function DLeague:broadcastEvent( ... )
	EventCenter.addEventFunc("OnAppStatChange", function ( state )
		if state == 2 then
			self:updatePages()
		end
	end, "DLeague")
end

function DLeague:close(  )
	EventCenter.resetGroup("DLeague")
end

function DLeague:setListenerEvent( ... )
	for i=1,tabList.TabCount do
		self[string.format("_commonDialog_tab_tab%d_title", i)]:setString(Res.locString(string.format("League$tabTitle%d", i)))
		require 'LangAdapter'.fontSize(self[string.format("_commonDialog_tab_tab%d_title", i)], nil, nil, nil, 22, 15, nil, nil, 24, nil, 20)

		self[string.format("_commonDialog_tab_tab%d_point", i)]:setVisible(false)
		self[string.format("_commonDialog_tab_tab%d", i)]:setListener(function ( ... )
			if self.tabIndexSelected ~= i then
				self.tabIndexSelected = i
				self:updatePages(true)
			end
		end)
	end
	require 'LangAdapter'.fontSize(self[string.format("_commonDialog_tab_tab%d_title", 4)], nil, nil, nil, nil, nil, 20)
	require 'LangAdapter'.fontSize(self[string.format("_commonDialog_tab_tab%d_title", 5)], nil, nil, nil, nil, nil, 18)

	self._commonDialog_btnHelp:setListener(function ( ... )
		GleeCore:showLayer("DHelp", {type = "冠军联赛"})
	end)

	self._commonDialog_btnClose:setListener(function ( ... )
		Res.doActionDialogHide(self._commonDialog, self)
	end)

	self._clickBg:setListener(function ( ... )
		Res.doActionDialogHide(self._commonDialog, self)
	end)
end

function DLeague:initPageArray( ... )
	local dyList = {
		[tabList.TabMain] = "@pageMain", 
		[tabList.TabLeague] = "@pageLeague", 
		[tabList.TabRankTopServer] = "@pageRankTopServer",
		[tabList.TabRankCurServer] = "@pageRankCurServer", 
		[tabList.TabShop] = "@pageShop",
	}
	self.pageList = {}
	for i,v in ipairs(dyList) do
		local set = self:createLuaSet(v)
		self._commonDialog_cnt_page:addChild(set[1])
		set[1]:setVisible(false)
		table.insert(self.pageList, set)
	end

	
	require 'LangAdapter'.selectLang(nil, nil, nil, nil, function ( ... )
		local set = self.pageList[tabList.TabRankCurServer]
    	set["BG_describe"]:setAnchorPoint(ccp(0.5,0.5))
		set["BG_describe"]:setRotation(90)
		set["BG_describe"]:setPosition(ccp(-50.0,155.7143))

		set = self.pageList[tabList.TabRankTopServer]
    	set["BG_describe"]:setAnchorPoint(ccp(0.5,0.5))
		set["BG_describe"]:setRotation(90)
		set["BG_describe"]:setPosition(ccp(-50.0,155.7143))

		-- local setMain = self.pageList[tabList.TabMain]
		-- setMain["over_time"]:setPosition(ccp(-292.0714,-165.71428))
	end, function ( ... )
		local set = self.pageList[tabList.TabRankCurServer]
    	set["BG_describe"]:setAnchorPoint(ccp(0.5,0.5))
		set["BG_describe"]:setRotation(90)
		set["BG_describe"]:setPosition(ccp(-50.0,155.7143))

		set = self.pageList[tabList.TabRankTopServer]
    	set["BG_describe"]:setAnchorPoint(ccp(0.5,0.5))
		set["BG_describe"]:setRotation(90)
		set["BG_describe"]:setPosition(ccp(-50.0,155.7143))
	end)
end

function DLeague:updatePages( refresh )
	self._commonDialog_title_text:setString(Res.locString(string.format("League$homeTitle%d", self.tabIndexSelected)))
	require 'LangAdapter'.fontSize(self._commonDialog_title_text, nil, nil, 36)

	for i,v in ipairs(self.pageList) do
		v[1]:setVisible(i == self.tabIndexSelected)
	end

	local waitFirstMatch = (leagueData and leagueData.state == 21000)
	self._commonDialog_tab:setVisible(not waitFirstMatch)
	if waitFirstMatch then
		self:updateMain()
	else
		self[string.format("_commonDialog_tab_tab%d", self.tabIndexSelected)]:trigger(nil)
		self:updateTabNameColor()
		
		if self.tabIndexSelected == tabList.TabMain then
			self:updateMain(refresh)
		elseif self.tabIndexSelected == tabList.TabLeague then
			self:updateLeagueInternal(refresh)
		elseif self.tabIndexSelected == tabList.TabRankTopServer then
			self:updateRankTopServerInternal(refresh)
		elseif self.tabIndexSelected == tabList.TabRankCurServer then
			self:updateRankCurServerInternal(refresh)
		elseif self.tabIndexSelected == tabList.TabShop then
			self:updateShop(refresh)
		end
	end
end

function DLeague:updateLeagueInternal( refresh )
	--if not self.netDataOfLeague then
	self:send(NetModel.getModelCsRankGroup(), function (netData)
		--self.netDataOfLeague = netData.D
		return self:updateLeague(netData.D)
	end)
	--else
	--	self:updateLeague(self.netDataOfLeague)
	--end
end

function DLeague:updateRankTopServerInternal( refresh )
	if not self.netDataOfTop then
		self:send(NetModel.getModelCsRankTotal(), function (netData)
			self.netDataOfTop = netData.D
			return self:updateRankTopServer(self.netDataOfTop, self.selRankIndex)
		end)
	else
		self:updateRankTopServer(self.netDataOfTop, self.selRankIndex)
	end
end

function DLeague:updateRankCurServerInternal( refresh )
	if not self.netDataOfLocal then
		self:send(NetModel.getModelCsRankServer(), function (netData)
			self.netDataOfLocal = netData.D
			return self:updateRankCurServer(self.netDataOfLocal, self.selRankIndex)
		end)
    else
	   self:updateRankCurServer(self.netDataOfLocal, self.selRankIndex)
    end
end

function DLeague:updateTabNameColor( ... )
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

function DLeague:updateMain( refresh )
	local setMain = self.pageList[tabList.TabMain]
	setMain["root"]:setVisible(not leagueData.state)
	setMain["over"]:setVisible(leagueData.state and leagueData.state > 0)
	if leagueData.state then
		local function getOpenTimeString( ... )
			local openTime = os.date("*t", require "TimeListManager".getTimestamp( leagueData.matchDate ))
		--	local todayTime = os.date("*t", math.floor(require "TimeManager".getCurrentSeverTime() / 1000))
			print("--------AAAAA-------")
			print(openTime)
		--	print(todayTime)
			openTime.wday = openTime.wday - 1
			if openTime.wday == 0 then
				openTime.wday = 7
			end
			-- todayTime.wday = todayTime.wday - 1
			-- if todayTime.wday == 0 then
			-- 	todayTime.wday = 7
			-- end
			local openTimeString = res.locString(string.format("League$Weekday%d", openTime.wday))
			-- if openTime.wday <= todayTime.wday then
			-- 	openTimeString = res.locString("League$WeekdayNext") .. openTimeString
			-- end
			return openTimeString
		end

		if leagueData.state == 21002 then -- 下轮开赛时间
			setMain["over"]:setResid("GJLS_tz_bg5.png")
			setMain["over_time"]:setString(getOpenTimeString())
		elseif leagueData.state == 21001 then -- 结算中
			setMain["over"]:setResid("GJLS_tz_bg6.png")
			setMain["over_time"]:setString("23" .. res.locString("League$WhatTime"))
		elseif leagueData.state == 21000 then -- 首轮开赛时间
			setMain["over"]:setResid("GJLS_tz_bg4.png")
			setMain["over_time"]:setString(getOpenTimeString())
		end
	else
		setMain["root_layout"]:removeAllChildrenWithCleanup(true)
		local opponentList = leagueData.csInfo.Targets or {}
		print("-------opponentList-------")
		print(opponentList)
		for i,v in ipairs(opponentList) do
			local itemOpponent = self:createLuaSet("@itemOpponent")
			setMain["root_layout"]:addChild(itemOpponent[1])
			itemOpponent["bg"]:setResid(string.format("GJLS_tz_bg%d.png", 4 - i))

			print("leagueData.csInfo.Score = " .. leagueData.csInfo.Score)
			print("v.Score = " .. v.Score)
		--	local score = dbManager.getCsScoreWithRate( leagueData.csInfo.Score, v.Score ) or 25
			local score = v.ScoreGet
			itemOpponent["tip"]:setString(string.format(res.locString("League$score"), score))
			require 'LangAdapter'.fontSize(itemOpponent["tip"],nil,nil,32,nil,nil,nil,nil,nil,nil,28)
			local nPet = petFunc.getPetInfoByPetId(v.PetId, v.AwakeIndex)
			Res.setNodeWithPet( itemOpponent["icon"], nPet )
			itemOpponent["btnDetail"]:setListener(function ( ... )
				self:send(netModel.getModelCsDefPetList(v.Id), function ( data )
					if data and data.D and data.D.Team then
						local param = {}
						param.type = "OtherLeague"
						param.team = data.D.Team.Team
						param.nPetList = data.D.Team.Pets
						GleeCore:showLayer("DArenaBattleArray", param)
					end
				end)
			end)
			itemOpponent["name"]:setString(v.Name)
			itemOpponent["layoutFrom_v"]:setString(v.ServerName)

			require 'LangAdapter'.fontSize(itemOpponent["layoutFrom_k"], nil, nil, nil, nil, 18)
			require 'LangAdapter'.fontSize(itemOpponent["layoutFrom_v"], nil, nil, nil, nil, 18)

			itemOpponent["layoutBattle_v"]:setString(v.Pwr)
			require 'LangAdapter'.fontSize(itemOpponent["btnChallenge_text"], nil, nil, 22)
			itemOpponent["btnChallenge"]:setListener(function ( ... )
				if leagueData.csInfo.TimesLeft <= 0 then
					self:toast(res.locString("League$noCountChallenge"))
				elseif leagueData.csInfo.Locked then
					self:toast(res.locString("League$cding"))
				else
					self:send(netModel.getModelCsChallenge(v.Id), function ( data )
						if data and data.D then
							leagueData.csInfo.TimesLeft = data.D.TimesLeft
							self:updatePages()

							local iTeam = teamFunc.getTeamCsTypeAtk()
							local gameData = {}
							gameData.type = 'league'
							gameData.data = {}
							gameData.data.petList = {}
							for i,v in ipairs(iTeam.PetIdList) do
								table.insert(gameData.data.petList, petFunc.convertToDungeonData(petFunc.getPetWithId(v)))
							end
							if iTeam.BenchPetId > 0 then
								table.insert(gameData.data.petList, petFunc.convertToDungeonData(petFunc.getPetWithId(iTeam.BenchPetId)))
							end

							local function getPetWithIdInPets( id )
								for k,v in pairs(data.D.Pets) do
									if v.Id == id then
										return v
									end
								end
							end
							gameData.data.enemyList = {}
							for i,v in ipairs(data.D.Team.PetIdList) do
								table.insert(gameData.data.enemyList, petFunc.convertToDungeonData( getPetWithIdInPets(v) ))
							end
							if data.D.Team.BenchPetId > 0 then
								table.insert(gameData.data.enemyList, petFunc.convertToDungeonData( getPetWithIdInPets(data.D.Team.BenchPetId) ))
							end

							gameData.data.enemyName = v.Name
							gameData.data.petBornIJList = teamFunc.getPosListCsTypeAtk(iTeam)
							gameData.data.enemyBornIJList = teamFunc.getPosListCsTypeDef(data.D.Team)
							gameData.data.enemyId = v.Id
							EventCenter.eventInput("BattleStart", gameData)
						end
					end, function ( data )
						if data and data.Code >= 21000 and data.Code <= 21002 then
							leagueData.state = data.Code
							leagueData.matchDate = data.Msg
							self:updatePages()
						end
					end)
				end
			end)
		end

		local lastTime = 0
		if leagueData.csInfo.Cd > 0 then
			lastTime = leagueData.csInfo.Cd - require 'TimeManager'.getCurrentSeverTime() / 1000
		end
		print("lastTime = " .. lastTime)
		local date = setMain["root_layoutTime_v"]:getElfDate()
		date:setHourMinuteSecond(0, 0, math.max(lastTime, 0))
		if lastTime > 0 then
			setMain["root_layoutTime_v"]:setUpdateRate(-1)
			setMain["root_layoutTime_v"]:addListener(function (  )
				date:setHourMinuteSecond(0, 0, 0)
				setMain["root_layoutTime_v"]:setUpdateRate(0)
				leagueData.csInfo.Locked = false
				leagueData.csInfo.Cd = 0
			end)
		else
			setMain["root_layoutTime_v"]:setUpdateRate(0)
		end
		
		if leagueData.csInfo.Locked then
			setMain["root_layoutTime_v"]:setFontFillColor(ccc4f(1, 0, 0, 1), true)
		else
			setMain["root_layoutTime_v"]:setFontFillColor(ccc4f(0.8,0.4235,0.13,1.0), true)
		end

		setMain["root_layoutLastCount_v"]:setString(tostring(leagueData.csInfo.TimesLeft) .. res.locString("Global$Count"))
		setMain["root_layoutBV_v"]:setString(teamFunc.getTeamCsTypeAtk().CombatPower)
		setMain["root_btnRecover"]:setListener(function ( ... )
			if leagueData.csInfo.LooseTimes > 0 then
				self:showRecoverLayer()
			else
				self:toast(res.locString("League$noNeedRecoverTip"))
			end
		end)

		require 'LangAdapter'.selectLang(nil, nil, function ( ... )
			setMain["root_layoutTime"]:setPosition(ccp(-360,-191.4286))
			setMain["root_layoutLastCount"]:setPosition(ccp(-360,-217.14288))
		end, nil, nil, nil, nil, nil, function ( ... )
			setMain["root_btnRecover"]:setPosition(ccp(-50,-204.28568))
		end)

		require 'LangAdapter'.fontSize(setMain["root_layoutTime_k"], nil, nil, 18)
		require 'LangAdapter'.fontSize(setMain["root_layoutTime_v"], nil, nil, 18)
		require 'LangAdapter'.fontSize(setMain["root_layoutLastCount_k"], nil, nil, 18)
		require 'LangAdapter'.fontSize(setMain["root_layoutLastCount_v"], nil, nil, 18)
		require 'LangAdapter'.fontSize(setMain["root_btnRecover_text"], nil, nil, 20, 20, nil, nil, nil, 22)
		require 'LangAdapter'.fontSize(setMain["root_btnSwitchTeam_text"], nil, nil, 20, 20, nil, 24, nil, nil, nil, 20)
		require 'LangAdapter'.fontSize(setMain["root_btnChangeOpponent_text"], nil, nil, 20, 20, nil, 18)
		setMain["root_btnSwitchTeam"]:setListener(function ( ... )
			GleeCore:showLayer("DArenaBattleArray", {type = "SelfLeague"})
		end)
		local playerRefreshCost = dbManager.getInfoDefaultConfig("CsPlayerRefreshCost").Value
		setMain["root_btnChangeOpponent"]:setListener(function ( ... )
			if leagueData.csInfo.TimesLeft <= 0 then
				self:toast(res.locString("League$noCountChallenge"))
			else
				if userFunc.getCoin() >= playerRefreshCost then
					self:send(netModel.getModelCsPlayerRefresh(), function ( data )
						if data and data.D then
							leagueData.csInfo.Targets = data.D.Targets
							userFunc.setCoin(data.D.Coin)
							self:updatePages()
						end
					end, function ( data )
						if data and data.Code >= 21000 and data.Code <= 21002 then
							leagueData.state = data.Code
							leagueData.matchDate = data.Msg
							self:updatePages()
						end
					end)
				else
					require "Toolkit".showDialogOnCoinNotEnough()
				end			
			end
		end)
		setMain["root_cost"]:setString(playerRefreshCost)

		local function adjustBtn( ... )
			self:runWithDelay(function ( ... )  -- TimeNode在下一帧确定大小
				setMain["root_layoutTime"]:layout()
				setMain["root_layoutTime"]:setPosition(ccp(-362.85733,-191.4286))
				res.adjustNodeWidth(setMain["root_layoutTime"], 200)
			end)

			setMain["root_layoutLastCount"]:layout()
			setMain["root_layoutLastCount"]:setPosition(ccp(-362.85733,-217.14288))
			res.adjustNodeWidth(setMain["root_layoutLastCount"], 200)
		end
		require 'LangAdapter'.selectLang(nil,nil,nil,nil,nil,adjustBtn,adjustBtn,nil,nil,adjustBtn)
	end
end

------------------------------------------------------Rank---------------------------------------------------------------------------------------------------------------------------------------

function DLeague:initRankData( historyData )
    -- if not self.number2title then
   	--   self.number2title = {}
    --     table.insert(self.number2title, '青铜级')
    --     table.insert(self.number2title, '白银级')
    --     table.insert(self.number2title, '黄金级')
    --     table.insert(self.number2title, '白金级')
    --     table.insert(self.number2title, '钻石级')
    --     table.insert(self.number2title, '无双级')
    --     table.insert(self.number2title, '冠军级')
    -- end

    if not historyData or not next(historyData) then return end
    --self.netDataOfLeague = historyData.netDataOfLeague
    self.netDataOfTop = historyData.netDataOfTop
    self.netDataOfLocal = historyData.netDataOfLocal

    self.tabIndexSelected = historyData.tabIndex
    self.selRankIndex = historyData.selRankIndex
end

function DLeague:getCellSet(container, tableName, cellName, index)
    if self[tableName] == nil then
        self[tableName] = {}
    end

    if self[tableName][index] == nil then
        local set = self:createLuaSet(cellName)
        table.insert(self[tableName], set)
        container:addChild(set[1])
    end

    return self[tableName][index]
end

-- getModelCsRankGroup
-- getModelCsRankTotal
-- getModelCsRankServer

function DLeague:getState(players, mine)
    --if not mine then print('msg:------------mine nil') return end
    local state = 0
    if mine.rank < 11 then
        state = 0
        -- 如果是冠军则是持平
        if mine.Clv == 7 then
            state = 1
        end
    elseif mine.rank < 21 then
        state = 1
        if mine.Clv < 7 and mine.Score == players[10].Score then
            state = 0
        end
    else
        state = 2
        
        if mine.Score == players[20].Score then
            state = self:getState(players, players[20])
        elseif mine.Score == players[10].Score then
            state = self:getState(players, players[10])
        end

        if mine.Clv == 1 and state == 2 then
            state = 1
        end
    end
    if state == 0 and mine.Score == 500 then
        state = 1
    end
    
    return state
end

function DLeague:updateLeague(data)
    if not data or not data.Players then print('msg:------------updateLeague') print(data) return end
    local myUserID = gameFunc.getUserInfo().getId()
    for i = 1, #data.Players do
        data.Players[i].rank = i
        if myUserID == data.Players[i].Id then
            data.My = data.Players[i]
        end
    end
    --local data = netdata.Players --My
    local set = self.pageList[tabList.TabLeague]

    if not data or not data.Players or not next(data.Players) then
        set['BG_none']:setVisible(true)
        set['BG_layout']:setVisible(false)
        return
    else
        set['BG_layout']:setVisible(true)
        set['BG_none']:setVisible(false)
    end

    set['top_cur_icon']:setResid(string.format('GJLS_ls_wenzi%ds.png', data.My.Clv))
    local DBCurConfig = DBManager.getGroupRank(data.My.Clv)
    set['top_cur_reward_reputation']:setString(DBCurConfig.Honor)

    if data.My.Clv < 7 then
        set['top_arrow']:setVisible(true)
        set['top_next']:setVisible(true)
        set['top_cur']:setPosition(ccp(-110, 2.85))
        local DBNextConfig = DBManager.getGroupRank(data.My.Clv + 1)
        set['top_next_icon']:setResid(string.format('GJLS_ls_wenzi%d.png', data.My.Clv + 1))
        set['top_next_reward_reputation']:setString(DBNextConfig.Honor)
    else
        set['top_arrow']:setVisible(false)
        set['top_next']:setVisible(false)
        set['top_cur']:setPosition(ccp(0, 2.85))
    end

    if self['cellSets1'] and next(self['cellSets1']) then
        for i = #data.Players + 1, #self['cellSets1'] do
            local cellSet = self:getCellSet(set['BG_list']:getContainer(), 'cellSets1', '@cellClick', i)
            cellSet[1]:setScale(0)
        end
    end

    for k, v in pairs(data.Players) do
        local cellSet = self:getCellSet(set['BG_list']:getContainer(), 'cellSets1', '@cellClick', k)
        cellSet[1]:setScale(1)
        --self:createLuaSet('@cellClick')
        if k % 2 == 0 then
            cellSet['normal_bg']:setVisible(false)
            cellSet['pressed_bg']:setVisible(false)
        else
            cellSet['normal_bg']:setVisible(true)
            cellSet['pressed_bg']:setVisible(true)
        end

        if v.rank < 4 then
            cellSet['rankLabel']:setVisible(false)
            cellSet['rankIcon']:setVisible(true)

            cellSet['rankIcon']:setResid(string.format('PHB_PM%d.png', v.rank))
        else
            cellSet['rankLabel']:setVisible(true)
            cellSet['rankIcon']:setVisible(false)
            cellSet['rankLabel']:setString(tostring(v.rank))
        end

        cellSet['name']:setString(v.Name)
        local state = self:getState(data.Players, v)
        cellSet['state']:setString(Res.locString(string.format('Global$RankState%d', state)))
        if state == 0 then
            --cellSet['state']:setString('(晋级)')
            cellSet['state']:setFontFillColor(ccc4f(0.04, 0.25, 0.015, 1.0), true)
        elseif state == 1 then
            --cellSet['state']:setString('(持平)')
            cellSet['state']:setFontFillColor(ccc4f(0.964706, 0.905882, 0.772549, 1.0), true)
        elseif state == 2 then
            --cellSet['state']:setString('(降级)')
            cellSet['state']:setFontFillColor(ccc4f(0.466667, 0.019608, 0.019608, 1.0), true)
        end

        cellSet['from']:setString(v.ServerName)
        cellSet['score']:setString(v.Score)

        require 'LangAdapter'.fontSize(cellSet['name'], nil, nil, nil, nil, 22)
        require 'LangAdapter'.fontSize(cellSet['state'], nil, nil, nil, nil, 22)
        require 'LangAdapter'.fontSize(cellSet['from'], nil, nil, nil, nil, 22)
        require 'LangAdapter'.fontSize(cellSet['score'], nil, nil, nil, nil, 22)
        require 'LangAdapter'.fontSize(cellSet['rankLabel'], nil, nil, nil, nil, 22)

        if k == 1 then
            local delay = 0.5
            if self.cellSets1 and #self.cellSets1 == #data.Players then
                delay = 0
            end
            --print('msg:==============delay: '..tostring(delay))
            self:runWithDelay(function()
                set['BG_list']:alignTo(k - 1)
            end, delay)
            cellSet[1]:trigger(nil)
        end
        --:addChild(cellSet[1])
    end

    set['BG_bottom_normal_rankLabel']:setString(data.My.rank)
    set['BG_bottom_normal_name']:setString(data.My.Name)
    set['BG_bottom_normal_from']:setString(data.My.ServerName)
    set['BG_bottom_normal_score']:setString(data.My.Score)

    local state = self:getState(data.Players, data.My)
    set['BG_bottom_normal_state']:setString(Res.locString(string.format('Global$RankState%d', state)))
    if state == 0 then
        --set['BG_bottom_normal_state']:setString('(晋级)')
        set['BG_bottom_normal_state']:setFontFillColor(ccc4f(0.04, 0.25, 0.015, 1.0), true)
    elseif state == 1 then
        --set['BG_bottom_normal_state']:setString('(持平)')
        set['BG_bottom_normal_state']:setFontFillColor(ccc4f(0.7, 0.47, 0.2, 1.0), true)
    elseif state == 2 then
        --set['BG_bottom_normal_state']:setString('(降级)')
        set['BG_bottom_normal_state']:setFontFillColor(ccc4f(0.466667, 0.019608, 0.019608, 1.0), true)
    end

	  require 'LangAdapter'.fontSize(set['BG_bottom_normal_name'], nil, nil, nil, nil, 22)
	  require 'LangAdapter'.fontSize(set['BG_bottom_normal_state'], nil, nil, nil, nil, 22)
	  require 'LangAdapter'.fontSize(set['BG_bottom_normal_from'], nil, nil, nil, nil, 22)
	  require 'LangAdapter'.fontSize(set['BG_bottom_normal_score'], nil, nil, nil, nil, 22)
	  require 'LangAdapter'.fontSize(set['BG_bottom_normal_rankLabel'], nil, nil, nil, nil, 22)

    -- math.randomseed(tostring(os.time()):reverse():sub(1, 6))  
    -- local randNum1 = tonumber(math.random(1000) % 7) + 1

-- BG_layout_level4_icon
-- BG_layout_level4_title
-- BG_layout_level4_arrow
    for i = 1, 7 do
        set[string.format('BG_layout_level%d_icon', i)]:setResid(string.format('GJLS_ls_tubiao%d.png', i))
        set[string.format('BG_layout_level%d_title', i)]:setResid(string.format('GJLS_ls_wenzi%d.png', i))
        if i < 7 then
            set[string.format('BG_layout_level%d_arrow', i)]:setResid(string.format('GJLS_ls_bg1.png'))
            set[string.format('BG_layout_level%d_arrow', i)]:setPosition(ccp(-44.3, 31.5))
        end
    end
    set[string.format('BG_layout_level%d_icon', data.My.Clv)]:setResid(string.format('GJLS_ls_tubiao%ds.png', data.My.Clv))
    set[string.format('BG_layout_level%d_title', data.My.Clv)]:setResid(string.format('GJLS_ls_wenzi%ds.png', data.My.Clv))

    if data.My.Clv < 7 then
        set[string.format('BG_layout_level%d_arrow', data.My.Clv)]:setResid(string.format('GJLS_ls_bg2.png'))
        set[string.format('BG_layout_level%d_arrow', data.My.Clv)]:setPosition(ccp(-44.3, 35))
    end

    if data.My.Clv == 1 then
        set['top_tips']:setString(Res.locString('League$tips1'))
    elseif data.My.Clv == 7 then
        set['top_tips']:setString(Res.locString('League$tips2'))
    else
        local advance = Res.locString(string.format('League$rankTitle%d', data.My.Clv + 1))
        local retreat = Res.locString(string.format('League$rankTitle%d', data.My.Clv - 1))
        set['top_tips']:setString(string.format(Res.locString('League$tips3'), advance, retreat)) 
    end

 	require 'LangAdapter'.selectLang(nil,nil,nil,nil,nil,function ( ... )
 		set['top_tips']:setPosition(ccp(0.7142868,-57.142876))
	end, function ( ... )
		set['top_tips']:setPosition(ccp(0.7142868,-57.142876))
	end,nil,nil,function ( ... )
		set["top_cur_reward"]:layout()
		res.adjustNodeWidth(set["top_cur_reward"], 220)
		set["top_cur_reward"]:layout()
		res.adjustNodeWidth(set["top_next_reward"], 220)
		set['top_tips']:setPosition(ccp(0.7142868,-57.142876))
	end)
end

function DLeague:cellClicked(set, userID, index, setsName, tableName)
    if self.rankTempTeams then
        for k, v in pairs(self.rankTempTeams) do
            if userID == v.Rid then

                if index < 4  then
                    --最新
                    self[tableName].Players[index].PetId = v.Pets[1].PetId
                    self:refreshHeadIcon(set, setsName, self[tableName].Players[index], index)
                end

                return self:refreshArmy(set, userID, v, index)
            end
        end
    end
    
    -- get data by call net
    self:send(NetModel.getTempTeamInfo(userID), function (netData)
    --Launcher.callNet(NetModel.getTempTeamInfo(userID),function (netdata)
        if not netData or not netData.D or not netData.D.TempTeam then
            self:toast(string.format('userid: %d do not have correct data.', userID))
            return
        end
        if not self.rankTempTeams then self.rankTempTeams = {} end
        table.insert(self.rankTempTeams, netData.D.TempTeam)
        --return data.D.TempTeam
        --print('msg:-------------------------------')
        --print(netData.D.TempTeam)
        if index < 4 and netData.D.TempTeam.Pets and netData.D.TempTeam.Pets[1] then
            --最新
            -- print('msg:=====--------------------------index: '..tostring(index))
            -- print('msg:----self.tablename:  '..tableName)
            -- print(self[tableName])
            -- print('msg:-------------others')
            -- print('self[tableName].Players[index].PetId:  '..tostring(self[tableName].Players[index].PetId))
            -- print('netData.D.TempTeam.Pets[1].PetId:   '..tostring(netData.D.TempTeam.Pets[1].PetId))
            self[tableName].Players[index].PetId = netData.D.TempTeam.Pets[1].PetId
            self:refreshHeadIcon(set, setsName, self[tableName].Players[index], index)
        end

        return self:refreshArmy(set, userID, netData.D.TempTeam, index)
    end)
end

function DLeague:refreshArmy(set, userID, data, index)
    --local data = self:getArmyData(userID)
    -- self._BG_layout_pet1 = set:getColorClickNode("BG_layout_pet1")
    -- self._BG_layout_pet1_normal_elf_frame = set:getElfNode("BG_layout_pet1_normal_elf_frame")
    -- self._BG_layout_pet1_normal_elf_icon = set:getElfNode("BG_layout_pet1_normal_elf_icon")
    -- self._BG_layout_pet1_normal_starLayout = set:getLayoutNode("BG_layout_pet1_normal_starLayout")
    if not data then return end
    --self._root_page1_BG_describe:setString(string.format(Res.locString('DRank$_X_ARMY'), name))
    for i = 1, 5 do
        if i > #data.Pets then
            set[string.format('BG_layout_pet%d', i)]:setVisible(false)
        else
            set[string.format('BG_layout_pet%d', i)]:setVisible(true)
            set[string.format('BG_layout_pet%d', i)]:setListener(function()
                -- jump to team view  getTeamDetailsInfo
                self:send(NetModel.getTeamDetailsInfo(userID), function (netdata)
                    local param = {}
                    param.Team = netdata.D.Team
                    param.Pets = netdata.D.Pets--{unpack(pets)}
                    param.Equips = netdata.D.Equipments
                    param.Mibaos = netdata.D.Mibaos
                    param.Gems = netdata.D.Gems
                    param.Partners = netdata.D.Partners
                    param.Lv = netdata.D.Lv
                    param.Runes = netdata.D.Runes
                    for k, v in ipairs(netdata.D.PartnerPets) do
                        table.insert(param.Pets, v)
                    end
                    param.CloseFunc = function ( ... )
                        require "framework.sync.TimerHelper".tick(function ( ... )
                            --historyData = self.ranks
                            local historyData = {}
                            --historyData.netDataOfLeague = self.netDataOfLeague
                            historyData.netDataOfTop = self.netDataOfTop
                            historyData.netDataOfLocal = self.netDataOfLocal

                            historyData.tabIndex = self.tabIndexSelected
                            historyData.selRankIndex = index
                            GleeCore:showLayer("DLeague", {historyData = historyData})--{tabIndex = self.tabIndex, preCellUserID = userID})
                            return true
                        end)
                    end
                    GleeCore:closeAllLayers()
                    GleeCore:pushController("CTeam",param, nil, Res.getTransitionFade())
                end)
            end)
            local pet = gameFunc.getPetInfo().getPetInfoByPetId(data.Pets[i].PetId , data.Pets[i].Awake)
            set[string.format('BG_layout_pet%d_normal_elf_frame', i)]:setResid(Res.getPetIconFrame(pet))
            set[string.format('BG_layout_pet%d_normal_elf_icon', i)]:setResid(Res.getPetIcon(data.Pets[i].PetId))
            require 'PetNodeHelper'.updateStarLayout(set[string.format('BG_layout_pet%d_normal_starLayout', i)], DBManager.getCharactor(data.Pets[i].PetId))
        end
    end
end

function DLeague:refreshHeadIcon(set, setsName, player, index)
    set[string.format('top_pet%d_normal_icon', index)] :setResid(Res.getPetIcon(player.PetId))
    set[string.format('top_pet%d_normal_name', index)] :setString(player.Name)
    set[string.format('top_pet%d', index)] :setListener(function()
        --self:toast('更新右侧队伍信息')
        --self._root_page1_BG_list:alignTo(i - 1)
        set['BG_list']:alignTo(index - 1)
        self[setsName][index][1]:trigger(nil)
        --self.sets[i][1]:trigger(nil)
    end)
end

function DLeague:updateRankTopServer(data, selRankIndex)
    self.selRankIndex = nil
    local set = self.pageList[tabList.TabRankTopServer]

    if not data or not data.Players or not next(data.Players) then
        set['BG_none']:setVisible(true)
        return
    else
        set['BG_none']:setVisible(false)
    end

    if self['cellSets2'] and next(self['cellSets2']) then
        for i = #data.Players + 1, #self['cellSets2'] do
            local cellSet = self:getCellSet(set['BG_list']:getContainer(), 'cellSets2', '@cellClick1', i)
            cellSet[1]:setScale(0)
        end
    end

    for i = 1, 3 do
        if i <= #data.Players then
            self:refreshHeadIcon(set, 'cellSets2', data.Players[i], i)
            -- set[string.format('top_pet%d_normal_icon', i)] :setResid(Res.getPetIcon(data.Players[i].PetId))
            -- set[string.format('top_pet%d_normal_name', i)] :setString(data.Players[i].Name)
            -- set[string.format('top_pet%d', i)] :setListener(function()
            --     --self:toast('更新右侧队伍信息')
            --     --self._root_page1_BG_list:alignTo(i - 1)
            --     set['BG_list']:alignTo(i - 1)
            --     self.cellSets2[i][1]:trigger(nil)
            --     --self.sets[i][1]:trigger(nil)
            -- end)
        end
    end

    for k, v in pairs(data.Players) do
        local cellSet = self:getCellSet(set['BG_list']:getContainer(), 'cellSets2', '@cellClick1', k)
        cellSet[1]:setScale(1)

        cellSet[1]:setListener(function()
            -- body
            self:cellClicked(set, v.Id, k, 'cellSets2', 'netDataOfTop')
        end)
        
        if (not selRankIndex and k == 1) or selRankIndex == k then
            local delay = 0.5
            if self.cellSets2 and #self.cellSets2 == #data.Players then
                delay = 0
            end
            self:runWithDelay(function()
                set['BG_list']:alignTo(k - 1)
            end, delay)
            cellSet[1]:trigger(nil)
        end
        
        if k % 2 == 0 then
            cellSet['normal_bg']:setVisible(false)
            cellSet['pressed_bg']:setVisible(false)
        else
            cellSet['normal_bg']:setVisible(true)
            cellSet['pressed_bg']:setVisible(true)
        end

        if k < 4 then
            cellSet['rankLabel']:setVisible(false)
            cellSet['rankIcon']:setVisible(true)

            cellSet['rankIcon']:setResid(string.format('PHB_PM%d.png', k))
        else
            cellSet['rankLabel']:setVisible(true)
            cellSet['rankIcon']:setVisible(false)
            cellSet['rankLabel']:setString(tostring(k))
        end

        cellSet['name']:setString(v.Name)
        cellSet['from']:setString(v.ServerName)
        local groupRankConfig = require "CsGroupRankConfig"
        cellSet['classification']:setString(groupRankConfig[v.Clv].ClvName)
        cellSet['score']:setString(v.Score)

        require 'LangAdapter'.fontSize(cellSet['name'], nil, nil, nil, nil, 20, 20)
        require 'LangAdapter'.fontSize(cellSet['classification'], nil, nil, nil, nil, 20, 20)
   --     require 'LangAdapter'.fontSize(cellSet['from'], nil, nil, nil, nil, 20, 20)
        require 'LangAdapter'.selectLang(nil,nil,nil,nil,function ( ... )
        		res.adjustNodeWidth( cellSet['from'], 100 )
        end,function ( ... )
        		cellSet['from']:setFontSize(20)
        end)
        require 'LangAdapter'.fontSize(cellSet['score'], nil, nil, nil, nil, 20, 20)
        require 'LangAdapter'.fontSize(cellSet['rankLabel'], nil, nil, nil, nil, 20, 20)
        require 'LangAdapter'.fontSize(set['BG_top_#rank'], nil, nil, nil, nil, 18, 18)
    end
end

function DLeague:updateRankCurServer(data, selRankIndex)
    self.selRankIndex = nil
	local set = self.pageList[tabList.TabRankCurServer]
    if not data or not data.Players or not next(data.Players) then
        set['BG_none']:setVisible(true)
        return
    else
        set['BG_none']:setVisible(false)
    end
    
    for i = 1, 3 do
        if i <= #data.Players then
            self:refreshHeadIcon(set, 'cellSets3', data.Players[i], i)
            -- set[string.format('top_pet%d_normal_icon', i)] :setResid(Res.getPetIcon(data.Players[i].PetId))
            -- set[string.format('top_pet%d_normal_name', i)] :setString(data.Players[i].Name)
            -- set[string.format('top_pet%d', i)] :setListener(function()
            --     --self:toast('更新右侧队伍信息')
            --     set.BG_list:alignTo(i - 1)
            --     self.cellSets3[i][1]:trigger(nil)
            -- end)
        end
    end

    if self['cellSets3'] and next(self['cellSets3']) then
        for i = #data.Players + 1, #self['cellSets3'] do
            local cellSet = self:getCellSet(set['BG_list']:getContainer(), 'cellSets3', '@cellClick2', i)
            cellSet[1]:setScale(0)
        end
    end

    for k, v in pairs(data.Players) do
        local cellSet = self:getCellSet(set['BG_list']:getContainer(), 'cellSets3', '@cellClick2', k)
        cellSet[1]:setScale(1)
        cellSet[1]:setListener(function()
            -- body
            self:cellClicked(set, v.Id, k, 'cellSets3', 'netDataOfLocal')
        end)
        
        if (not selRankIndex and k == 1) or selRankIndex == k then
            local delay = 0.5
            if self.cellSets3 and #self.cellSets3 == #data.Players then
                delay = 0
            end
            self:runWithDelay(function()
                set['BG_list']:alignTo(k - 1)
            end, delay)
            cellSet[1]:trigger(nil)
        end
        
        if k % 2 == 0 then
            cellSet['normal_bg']:setVisible(false)
            cellSet['pressed_bg']:setVisible(false)
        else
            cellSet['normal_bg']:setVisible(true)
            cellSet['pressed_bg']:setVisible(true)
        end

        if k < 4 then
            cellSet['rankLabel']:setVisible(false)
            cellSet['rankIcon']:setVisible(true)

            cellSet['rankIcon']:setResid(string.format('PHB_PM%d.png', k))
        else
            cellSet['rankLabel']:setVisible(true)
            cellSet['rankIcon']:setVisible(false)
            cellSet['rankLabel']:setString(tostring(k))
        end
        cellSet['name']:setString(v.Name)

        local groupRankConfig = require "CsGroupRankConfig"
        cellSet['classification']:setString(groupRankConfig[v.Clv].ClvName)
        cellSet['score']:setString(v.Score)
    end
end

------------------------------------------------------Rank---------------------------------------------------------------------------------------------------------------------------------------

function DLeague:updateShop( refresh )
	local setShop = self.pageList[tabList.TabShop]
	if not self.shopItemList then
		self.shopItemList = LuaList.new(setShop["bg_list"], function ( ... )
			local sizeSet = self:createLuaSet("@shopItemSize")
			sizeSet["setList"] = {}
			for i=1,4 do
				local itemSet = self:createLuaSet("@shopItem")
				sizeSet["layout"]:addChild(itemSet[1])
				table.insert(sizeSet["setList"], itemSet)
			end
			return sizeSet
		end, function ( nodeLuaSet, dataList, listIndex )
			local itemSetList = nodeLuaSet["setList"]
			for i,set in ipairs(itemSetList) do
				set[1]:setVisible(i <= #dataList)
				if i <= #dataList then
					local good = dataList[i].good
					set["icon"]:setResid(good.icon)
					if good.type == "Pet" or good.type == "PetPiece" then
						set["icon"]:setScale(0.8 * 140 / 95)
					else
						set["icon"]:setScale(0.8)
					end
					set["iconFrame"]:setResid(good.frame)
					set["piece"]:setVisible(good.isPiece)
					set["layoutStar"]:removeAllChildrenWithCleanup(true)
					if good.type == "Pet" or good.type == "PetPiece" then
						local dbPet = dbManager.getCharactor(good.eventData.data.PetInfo.PetId)
						require 'PetNodeHelper'.updateStarLayout(set["layoutStar"], dbPet)
						set["name"]:setScale(0.75)
						set["name"]:setString(good.name .. string.format(res.locString("League$pieceown"), leagueData.csShop.PieceAmt or 0))
					else
						set["name"]:setScale(1)
						if good.type == "Gem" then
							set["name"]:setString(good.name .. " Lv." .. good.lv)
						else
							set["name"]:setString(good.name)
						end
					end
					require "LangAdapter".LabelNodeAutoShrink(set["name"], 158)
					set["count"]:setVisible(good.count > 1)
					set["count"]:setString(string.format("x%d", good.count))

					local usePrestige = good.costPrestige and good.costPrestige > 0
					if usePrestige then
						set["layoutPrice_k"]:setResid("GJLS_sd_tubiao1.png")
						set["layoutPrice_v"]:setString(good.costPrestige)
					else
						set["layoutPrice_k"]:setResid("N_TY_baoshi1.png")
						set["layoutPrice_v"]:setString(good.costCoin)
					end
					if usePrestige and leagueData.csShop.Honor < good.costPrestige then
						set["layoutPrice_v"]:setFontFillColor(ccc4f(1, 0, 0, 1), true)
					else
						set["layoutPrice_v"]:setFontFillColor(ccc4f(0.8,0.4235,0.13,1.0), true)
					end

					set["btnOk"]:setEnabled(dataList[i].state == 0 and (not usePrestige or leagueData.csShop.Honor >= good.costPrestige))
					set["btnOk"]:setListener(function ( ... )
						if good.type == "PetPiece" and leagueData.csShop.Shop.ClvLimit > 0 then
							local temp = res.locString(string.format("League$rankTitle%d", leagueData.csShop.Shop.ClvLimit))
							self:toast(string.format(res.locString("League$buyCondition"), temp))
						else
							local buyIndex
							if usePrestige then
								if leagueData.csShop.Honor >= good.costPrestige then
									buyIndex = (listIndex - 1) * 4 + i
								else
									self:toast( res.locString("League$PrestigeNotEnough") )
								end
							else
								if userFunc.getCoin() >= good.costCoin then
									buyIndex = (listIndex - 1) * 4 + i
								else
									require "Toolkit".showDialogOnCoinNotEnough()
								end
							end
							if buyIndex and buyIndex > 0 then
								local param = {}
								local goodName = good.name
								if good.count > 1 then
									goodName = goodName .. " x" .. good.count
								end
								if usePrestige then
									param.content = string.format(res.locString("League$shopText4"), "", tostring(good.costPrestige) .. res.locString("Global$Prestige"), goodName)
								else
									param.content = string.format(res.locString("League$shopText4"), "TY_jinglingshi_xiao.png", tostring(good.costCoin), goodName)
								end
								print(param.content)
								param.callback = function ( ... )
									if self.goodIsRefreshed then
										self:toast(res.locString("League$buyFail"))
									else
										self:send(netModel.getModelCsShopBuy(buyIndex), function ( data )
											if data and data.D then
												leagueData.csShop.PieceAmt = data.D.PieceAmt
												leagueData.csShop.Shop = data.D.Shop
												res.doActionGetReward(data.D.Reward)
												if data.D.Resource then
													gameFunc.updateResource(data.D.Resource)
												end

												if good.costPrestige and good.costPrestige > 0 then
													leagueData.csShop.Honor = leagueData.csShop.Honor - good.costPrestige
												end
												self:updatePages()
											end
										end)
									end
								end
								GleeCore:showLayer("DConfirmNT",param)
								self.goodIsRefreshed = false
							end
						end
					end)
					
					set["btnOk_text"]:setString(dataList[i].state == 0 and res.locString("ItemMall$Buy") or res.locString("ItemMall$BuyDone"))

					set["btnDetail"]:setListener(function ( ... )
						GleeCore:showLayer(good.eventData.dialog, good.eventData.data)
					end)
				end
			end
		end)
	end

	local function getShopItemListData( ... )
		local shopData = leagueData.csShop.Shop
		if #shopData.Goods > 0 and #shopData.Goods == #shopData.BuyState then
			local list = {}
			for i=1,#shopData.Goods do
				local temp = {}
				local count = shopData.BuyCnt + (shopData.BuyState[i] == 0 and 1 or 0)
				temp.good = res.getRewardResWithDB(dbManager.getCsStoreConfig(shopData.Goods[i]), count)
				temp.state = shopData.BuyState[i]
				table.insert(list, temp)
			end

			local result = {}
			for i,v in ipairs(list) do
				local a = math.floor((i - 1) / 4 + 1)
				local b = math.floor((i - 1) % 4 + 1)
				result[a] = result[a] or {}
				result[a][b] = v
			end
			return result
		end
	end

	local function updateShopNewest( ... )
		self:send(netModel.getModelCsShopGet(), function ( data )
			if data and data.D then
				leagueData.csShop = data.D
				self:updatePages()
				self.goodIsRefreshed = true
			end
		end)
	end

	if leagueData.csShop then
		self.shopItemList:update(getShopItemListData(), refresh)
		local coinNeed = dbManager.getInfoDefaultConfig("CsShopRefreshCost").Value

		local lastTime = - math.floor(require "TimeListManager".getTimeUpToNow(leagueData.csShop.RefreshAt))
		lastTime = math.max(lastTime, 0)
		local date = setShop["layoutRefresh_v"]:getElfDate()
		date:setHourMinuteSecond(0, 0, lastTime)

		if lastTime > 0 then
			setShop["layoutRefresh_v"]:setUpdateRate(-1)
			setShop["layoutRefresh_v"]:addListener(function (  )
				updateShopNewest()
			end)
		else
			updateShopNewest()
		end

		setShop["layoutRefresh2_v3"]:setString( tostring(coinNeed) )
		setShop["layoutPrestige_v1"]:setString(leagueData.csShop.Honor)
		setShop["layoutPrestige_v2"]:setString(userFunc.getCoin())
	--	setShop["btnRefresh"]:setEnabled(userFunc.getCoin() >= coinNeed)
		setShop["btnRefresh"]:setListener(function ( ... )
			if userFunc.getCoin() >= coinNeed then
				self:send(netModel.getModelCsShopRefresh(), function ( data )
					if data and data.D then
						userFunc.setCoin( userFunc.getCoin() - coinNeed)
						leagueData.csShop.PieceAmt = data.D.PieceAmt
						leagueData.csShop.Shop = data.D.Shop
						self:updatePages()
					end
				end)
			else
				require "Toolkit".showDialogOnCoinNotEnough()
			end
		end)

		require "LangAdapter".fontSize(setShop["#tip"], nil, nil, nil, nil, nil, nil, nil, 18)
		require "LangAdapter".LabelNodeAutoShrink(setShop["btnRefresh_text"], 110)

	else
		updateShopNewest()
	end
end

function DLeague:showRecoverLayer( ... )
	local cost = dbManager.getInfoDefaultConfig("CsRecoverCost").Value
	local param = {}
	param.content = string.format(res.locString("League$recoverTip"), cost)
	param.RightBtnText = res.locString("League$recover")
	param.callback = function ( ... )
		if userFunc.getCoin() >= cost then
			self:send(netModel.getModelCsRecover(), function ( data )
				if data and data.D then
					leagueData.csInfo.TimesLeft = data.D.TimesLeft
					leagueData.csInfo.LooseTimes = data.D.LooseTimes
					userFunc.setCoin( userFunc.getCoin() - cost )
					EventCenter.eventInput("UpdateGoldCoin")
					self:updatePages()
				end
			end)
		else
			require "Toolkit".showDialogOnCoinNotEnough()
		end
	end
	GleeCore:showLayer("DConfirmNT", param)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DLeague, "DLeague")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DLeague", DLeague)
