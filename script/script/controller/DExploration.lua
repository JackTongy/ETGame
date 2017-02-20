local Config = require "Config"
local DBManager = require "DBManager"
local NetModel = require 'netModel'
local Res = require 'Res'
local res = Res
local netModel = NetModel
local dbManager = DBManager
local AppData = require 'AppData'
local TimeManager = require 'TimeManager'
local UnlockManager = require 'UnlockManager'
local EventCenter = require "EventCenter"
local exploreFunc = AppData.getExploreInfo()
local LuaList = require "LuaList"

local tabList = {
	["TabMain"] = 1,
	["TabCamp"] = 2, 
	["TabReport"] = 3,
	["TabCount"] = 3,
}

local DExploration = class(LuaDialog)

function DExploration:createDocument()
		self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DExploration.cocos.zip")
		return self._factory:createDocument("DExploration.cocos")
end

--@@@@[[[[
function DExploration:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_page = set:getElfNode("commonDialog_cnt_page")
    self._bg = set:getElfNode("bg")
    self._btn = set:getButtonNode("btn")
    self._clickSite1 = set:getColorClickNode("clickSite1")
    self._clickSite1_normal_BG_pet = set:getElfNode("clickSite1_normal_BG_pet")
    self._clickSite1_normal_BG_pet_name = set:getLabelNode("clickSite1_normal_BG_pet_name")
    self._clickSite1_normal_BG_pet_bg = set:getElfNode("clickSite1_normal_BG_pet_bg")
    self._clickSite1_normal_BG_pet_icon = set:getElfNode("clickSite1_normal_BG_pet_icon")
    self._clickSite1_normal_BG_pet_frame = set:getElfNode("clickSite1_normal_BG_pet_frame")
    self._clickSite1_normal_BG_pet_property = set:getElfNode("clickSite1_normal_BG_pet_property")
    self._clickSite1_normal_BG_pet_career = set:getElfNode("clickSite1_normal_BG_pet_career")
    self._clickSite1_normal_BG_pet_starLayout = set:getLayoutNode("clickSite1_normal_BG_pet_starLayout")
    self._clickSite1_normal_BG_pet_flagIcon = set:getElfNode("clickSite1_normal_BG_pet_flagIcon")
    self._clickSite1_normal_BG_pet_countDown = set:getTimeNode("clickSite1_normal_BG_pet_countDown")
    self._clickSite1_normal_BG_pet_finish = set:getLabelNode("clickSite1_normal_BG_pet_finish")
    self._clickSite1_normal_BG_none = set:getElfNode("clickSite1_normal_BG_none")
    self._clickSite1_normal_BG_none_flag = set:getElfNode("clickSite1_normal_BG_none_flag")
    self._clickSite1_normal_BG_none_des = set:getLabelNode("clickSite1_normal_BG_none_des")
    self._clickSite2 = set:getColorClickNode("clickSite2")
    self._clickSite2_normal_BG_pet = set:getElfNode("clickSite2_normal_BG_pet")
    self._clickSite2_normal_BG_pet_name = set:getLabelNode("clickSite2_normal_BG_pet_name")
    self._clickSite2_normal_BG_pet_bg = set:getElfNode("clickSite2_normal_BG_pet_bg")
    self._clickSite2_normal_BG_pet_icon = set:getElfNode("clickSite2_normal_BG_pet_icon")
    self._clickSite2_normal_BG_pet_frame = set:getElfNode("clickSite2_normal_BG_pet_frame")
    self._clickSite2_normal_BG_pet_property = set:getElfNode("clickSite2_normal_BG_pet_property")
    self._clickSite2_normal_BG_pet_career = set:getElfNode("clickSite2_normal_BG_pet_career")
    self._clickSite2_normal_BG_pet_starLayout = set:getLayoutNode("clickSite2_normal_BG_pet_starLayout")
    self._clickSite2_normal_BG_pet_flagIcon = set:getElfNode("clickSite2_normal_BG_pet_flagIcon")
    self._clickSite2_normal_BG_pet_countDown = set:getTimeNode("clickSite2_normal_BG_pet_countDown")
    self._clickSite2_normal_BG_pet_finish = set:getLabelNode("clickSite2_normal_BG_pet_finish")
    self._clickSite2_normal_BG_none = set:getElfNode("clickSite2_normal_BG_none")
    self._clickSite2_normal_BG_none_flag = set:getElfNode("clickSite2_normal_BG_none_flag")
    self._clickSite2_normal_BG_none_des = set:getLabelNode("clickSite2_normal_BG_none_des")
    self._clickSite3 = set:getColorClickNode("clickSite3")
    self._clickSite3_normal_BG_pet = set:getElfNode("clickSite3_normal_BG_pet")
    self._clickSite3_normal_BG_pet_name = set:getLabelNode("clickSite3_normal_BG_pet_name")
    self._clickSite3_normal_BG_pet_bg = set:getElfNode("clickSite3_normal_BG_pet_bg")
    self._clickSite3_normal_BG_pet_icon = set:getElfNode("clickSite3_normal_BG_pet_icon")
    self._clickSite3_normal_BG_pet_frame = set:getElfNode("clickSite3_normal_BG_pet_frame")
    self._clickSite3_normal_BG_pet_property = set:getElfNode("clickSite3_normal_BG_pet_property")
    self._clickSite3_normal_BG_pet_career = set:getElfNode("clickSite3_normal_BG_pet_career")
    self._clickSite3_normal_BG_pet_starLayout = set:getLayoutNode("clickSite3_normal_BG_pet_starLayout")
    self._clickSite3_normal_BG_pet_flagIcon = set:getElfNode("clickSite3_normal_BG_pet_flagIcon")
    self._clickSite3_normal_BG_pet_countDown = set:getTimeNode("clickSite3_normal_BG_pet_countDown")
    self._clickSite3_normal_BG_pet_finish = set:getLabelNode("clickSite3_normal_BG_pet_finish")
    self._clickSite3_normal_BG_none = set:getElfNode("clickSite3_normal_BG_none")
    self._clickSite3_normal_BG_none_flag = set:getElfNode("clickSite3_normal_BG_none_flag")
    self._clickSite3_normal_BG_none_des = set:getLabelNode("clickSite3_normal_BG_none_des")
    self._clickSite4 = set:getColorClickNode("clickSite4")
    self._clickSite4_normal_BG_pet = set:getElfNode("clickSite4_normal_BG_pet")
    self._clickSite4_normal_BG_pet_name = set:getLabelNode("clickSite4_normal_BG_pet_name")
    self._clickSite4_normal_BG_pet_bg = set:getElfNode("clickSite4_normal_BG_pet_bg")
    self._clickSite4_normal_BG_pet_icon = set:getElfNode("clickSite4_normal_BG_pet_icon")
    self._clickSite4_normal_BG_pet_frame = set:getElfNode("clickSite4_normal_BG_pet_frame")
    self._clickSite4_normal_BG_pet_property = set:getElfNode("clickSite4_normal_BG_pet_property")
    self._clickSite4_normal_BG_pet_career = set:getElfNode("clickSite4_normal_BG_pet_career")
    self._clickSite4_normal_BG_pet_starLayout = set:getLayoutNode("clickSite4_normal_BG_pet_starLayout")
    self._clickSite4_normal_BG_pet_flagIcon = set:getElfNode("clickSite4_normal_BG_pet_flagIcon")
    self._clickSite4_normal_BG_pet_countDown = set:getTimeNode("clickSite4_normal_BG_pet_countDown")
    self._clickSite4_normal_BG_pet_finish = set:getLabelNode("clickSite4_normal_BG_pet_finish")
    self._clickSite4_normal_BG_none = set:getElfNode("clickSite4_normal_BG_none")
    self._clickSite4_normal_BG_none_flag = set:getElfNode("clickSite4_normal_BG_none_flag")
    self._clickSite4_normal_BG_none_des = set:getLabelNode("clickSite4_normal_BG_none_des")
    self._bg = set:getJoint9Node("bg")
    self._bg1_layoutBattleValue_v = set:getLabelNode("bg1_layoutBattleValue_v")
    self._bg1_btnChange = set:getClickNode("bg1_btnChange")
    self._bg1_layoutPet = set:getLayoutNode("bg1_layoutPet")
    self._icon = set:getElfNode("icon")
    self._starLayout = set:getLayoutNode("starLayout")
    self._tag = set:getElfNode("tag")
    self._bg2_layoutBattleValue_v = set:getLabelNode("bg2_layoutBattleValue_v")
    self._bg2_layoutBattleValue_v2 = set:getRichLabelNode("bg2_layoutBattleValue_v2")
    self._bg2_btnInvite = set:getClickNode("bg2_btnInvite")
    self._bg2_layoutPet = set:getLayoutNode("bg2_layoutPet")
    self._icon = set:getElfNode("icon")
    self._starLayout = set:getLayoutNode("starLayout")
    self._bg = set:getJoint9Node("bg")
    self._list = set:getListNode("list")
    self._bg_icon = set:getElfNode("bg_icon")
    self._bg_content = set:getRichLabelNode("bg_content")
    self._bg_timeLabel = set:getLabelNode("bg_timeLabel")
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
--    self._@pageMain = set:getElfNode("@pageMain")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@pageCamp = set:getElfNode("@pageCamp")
--    self._@petDef = set:getElfNode("@petDef")
--    self._@star = set:getElfNode("@star")
--    self._@petFriend = set:getElfNode("@petFriend")
--    self._@star = set:getElfNode("@star")
--    self._@pageReport = set:getElfNode("@pageReport")
--    self._@reportItem = set:getElfNode("@reportItem")
end
--@@@@]]]]


local Launcher = require 'Launcher'

Launcher.register('DExploration',function ( userData )
	if UnlockManager:isUnlock("Exploration") then
		Launcher.callNet(NetModel.getModelExploreGet(),function (data)
			if data and data.D then
				exploreFunc.setExploreData(data.D.List)
				Launcher.callNet(NetModel.getModelExploreDataGet(), function ( data )
					if data and data.D then
						exploreFunc.setExploreRob(data.D.Data)
						Launcher.Launching()
					end
				end)
			end
		end)
	else
		return GleeCore:toast(UnlockManager:getUnlockConditionMsg("Exploration"))
	end
end)

-- Explore 探宝数据
-- 字段 类型 说明
-- Sid Int 槽位 id
-- Hours Int 时长（小时）
-- Pid Long 精灵唯一 id
-- Finish Bool 已完成
-- EndAt DateTime 完成时间点

--------------------------------override functions----------------------
function DExploration:onInit( userData, netData )
	self.tabIndexSelected = tabList.TabMain
	self:broadcastEvent()
	self:setListenerEvent()
	self:initPageArray()
	self:updatePages()
	res.doActionDialogShow(self._commonDialog)
	--[[
	require 'LangAdapter'.selectLang(nil, nil, function ( ... )
		for i=1,4 do
			self[string.format("clickSite%d_normal_BG_pet_finish", i)]:setFontSize(18)
		end
	end)

    for i=1,4 do
        require 'LangAdapter'.LabelNodeAutoShrink(self[string.format("clickSite%d_normal_BG_none_des", i)],90)    
    end
    ]]
end

function DExploration:onBack( userData, netData )
	
end

function DExploration:close(  )
	EventCenter.resetGroup("DExploration")
end

--------------------------------custom code-----------------------------

function DExploration:broadcastEvent( ... )
	EventCenter.addEventFunc("OnAppStatChange", function ( state )
		if state == 2 then
			self:updatePages()
		end
	end, "DExploration")

	EventCenter.addEventFunc("UpdateExploreBattleArray", function ( state )
		self:updatePages()
	end, "DExploration")
end

function DExploration:setListenerEvent( ... )
	for i=1,tabList.TabCount do
		require 'LangAdapter'.fontSize(self[string.format("_commonDialog_tab_tab%d_title", i)], nil, nil, nil, nil, 20)
		self[string.format("_commonDialog_tab_tab%d_title", i)]:setString(res.locString(string.format("Explore$tabTitle%d", i)))
		self[string.format("_commonDialog_tab_tab%d_point", i)]:setVisible(false)
		self[string.format("_commonDialog_tab_tab%d", i)]:setListener(function ( ... )
			if self.tabIndexSelected ~= i then
				self.tabIndexSelected = i
				self:updatePages()
			end
		end)
	end

	self._commonDialog_btnHelp:setListener(function ( ... )
		GleeCore:showLayer("DHelp", {type = "探宝"})
	end)

	self._commonDialog_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)
end

function DExploration:initPageArray( ... )
	local dyList = {
		[tabList.TabMain] = "@pageMain", 
		[tabList.TabCamp] = "@pageCamp", 
		[tabList.TabReport] = "@pageReport",
	}
	self.pageList = {}
	for i,v in ipairs(dyList) do
		local set = self:createLuaSet(v)
		self._commonDialog_cnt_page:addChild(set[1])
		set[1]:setVisible(false)
		table.insert(self.pageList, set)
	end
end

function DExploration:updatePages(  )
	for i,v in ipairs(self.pageList) do
		v[1]:setVisible(i == self.tabIndexSelected)
	end

	self[string.format("_commonDialog_tab_tab%d", self.tabIndexSelected)]:trigger(nil)
	self:updateTabNameColor()
	
	if self.tabIndexSelected == tabList.TabMain then
		self:updateMain()
	elseif self.tabIndexSelected == tabList.TabCamp then
		self:updateCamp()
	elseif self.tabIndexSelected == tabList.TabReport then
		self:updateReport()
	end
end

function DExploration:updateMain( ... )
	local setMain = self.pageList[tabList.TabMain]
	local data = AppData.getExploreInfo().getExploreData()
	for i = 1, 4 do
		if 0 == data[i].Pid then
			local config = DBManager.getExploreConfig(i)
			--[1] = {   Id = 1, SlotId = 1, UnlockLv = 0,   UnlockVip = 0,},
			if config.UnlockLv <= AppData.getUserInfo().getLevel() or (config.UnlockVip > 0 and config.UnlockVip <= AppData.getUserInfo().getVipLevel()) then
				setMain[string.format('clickSite%d_normal_BG_none_flag', i)]:setResid('N_TB_tianjia.png')
				setMain[string.format('clickSite%d_normal_BG_none_des', i)]:setString(Res.locString('Explore$_Chos_Tips'))
				setMain[string.format('clickSite%d', i)]:setListener(function()
					local param = {}
					param.callBack = function(selPet, hours)
						--self:toast(string.format('选择的精灵: %d  选择的时常: %d ', selPet.Id, hours))
						self:send(NetModel.getModelExploreSend(i, hours, selPet.Id), function (ndata)
							AppData.getExploreInfo().setExploreData(ndata.D.List)
							self:updatePages()
							require 'EventCenter'.eventInput("explore")
						end)
					end
					GleeCore:showLayer('DExploreChosPet', param)
				end)
			else
				local LVTips = ''
				local VIPTips = ''
				if config.UnlockLv > 0 then
					LVTips = string.format(Res.locString('Explore$_Lv_Limit'), config.UnlockLv)
				end
				if config.UnlockVip > 0 then
					VIPTips = string.format(Res.locString('Explore$_VIP_Limit'), config.UnlockVip)
				end

				setMain[string.format('clickSite%d_normal_BG_none_flag', i)]:setResid('N_TB_suoding.png')
				setMain[string.format('clickSite%d_normal_BG_none_des', i)]:setString(LVTips..VIPTips)
				
				setMain[string.format('clickSite%d', i)]:setListener(function()
					self:toast(config.des)
				end)
			end
			
			setMain[string.format('clickSite%d_normal_BG_none', i)]:setVisible(true)
			setMain[string.format('clickSite%d_normal_BG_pet', i)]:setVisible(false)
		else
			self:updatePetInLocation(i, AppData.getPetInfo().getPetWithId(data[i].Pid), data[i])
		end
	end

	setMain["btn"]:setListener(function ( ... )
		GleeCore:showLayer("DExploreRob")
	end)
end

function DExploration:updateCamp( ... )
	local list = AppData.getFriendsInfo().getFriendList()
	if list and #list > 0 then
		self:updateCampInner()
	else
		self:send(netModel.getModelFriendGetFriend(), function ( data )
			if data and data.D then
				AppData.getFriendsInfo().setFriendList(data.D.Friends)
				self:updateCampInner()
			end
		end)
	end
end

function DExploration:updateCampInner( ... )
	local rob = exploreFunc.getExploreRob()
	local teamFunc = AppData.getTeamInfo()
	local teamList = teamFunc.getTeamList()
	local team = teamList[teamFunc.getTeamIdExploreDefType()]
	local setCamp = self.pageList[tabList.TabCamp]
	setCamp["bg1_layoutBattleValue_v"]:setString(team.CombatPower)
	setCamp["bg1_layoutPet"]:removeAllChildrenWithCleanup(true)
	local nPetList = teamFunc.getPetListWithTeam(team)
	for i,nPet in ipairs(nPetList) do
		local petDef = self:createLuaSet("@petDef")
		setCamp["bg1_layoutPet"]:addChild(petDef[1])

		res.setNodeWithPet(petDef["icon"], nPet)
		local dbPet = dbManager.getCharactor(nPet.PetId)
		require 'PetNodeHelper'.updateStarLayout(petDef["starLayout"], dbPet)
		if i == 1 then
			petDef["tag"]:setResid("TY_duiwu_1.png")
		elseif i == 6 then
			petDef["tag"]:setResid("TY_tibu_1.png")
		else
			petDef["tag"]:setResid("")
		end
	end

	setCamp["bg1_btnChange"]:setListener(function ( ... )
		GleeCore:showLayer("DArenaBattleArray", {type = "ExploreRob"})
	end)

	setCamp["bg2_layoutPet"]:removeAllChildrenWithCleanup(true)
	local battleValue = 0
	for k,v in pairs(rob.FPets) do
		local petFriend = self:createLuaSet("@petFriend")
		setCamp["bg2_layoutPet"]:addChild(petFriend[1])
		local nPet = AppData.getPetInfo().getPetInfoByPetId(v.PetId, v.AwakeIndex, v.Power)
		res.setNodeWithPet(petFriend["icon"], nPet)
		local dbPet = dbManager.getCharactor(v.PetId)
		require 'PetNodeHelper'.updateStarLayout(petFriend["starLayout"], dbPet)
		battleValue = battleValue + v.Power
	end
	setCamp["bg2_layoutBattleValue_v"]:setString(battleValue)
	setCamp["bg2_layoutBattleValue_v2"]:setString(string.format(res.locString("Explore$InduceBeenRob"), battleValue > 0 and (battleValue / 5000000 + 0.01) * 100 or 0))

	setCamp["bg2_btnInvite"]:setListener(function ( ... )
		GleeCore:showLayer("DExploreInviteFriend", {callback = function ( nPetId )
			self:send(netModel.getModelExploreInvite(nPetId), function ( data )
				if data and data.D then
					exploreFunc.setExploreRob(data.D.Data)
					self:updateCampInner()
				end
			end)
		end})
	end)

	require 'LangAdapter'.fontSize(setCamp["bg2_btnInvite_#text"],nil,nil,nil,nil,nil,nil,nil,22)
	require "LangAdapter".LabelNodeAutoShrink(setCamp["bg1_btnChange_#text"], 82)
	require "LangAdapter".LabelNodeAutoShrink(setCamp["bg2_btnInvite_#text"], 82)
end

function DExploration:updateReport( ... )
	if self.ReportDataList then
		self:updateReportInner()
	else
		self:send(netModel.getModelExploreReportGet(), function ( data )
			if data and data.D then
				self.ReportDataList = data.D.Records or {}
				table.sort(self.ReportDataList,function ( a,b )
					return a.T > b.T
				end)
				self:updateReportInner()
			end
		end)
	end
end

function DExploration:updateReportInner( ... )
	local setReport = self.pageList[tabList.TabReport]
	if not self.reportList then
		self.reportList = LuaList.new(setReport["list"], function ( ... )
			return self:createLuaSet("@reportItem")
		end, function ( nodeLuaSet, v, listIndex )
			local state -- 1.攻击成功 2.攻击失败 3.防守成功 4.防守失败 5.复仇成功 6.复仇失败
			local opponentName
			local selfRid = AppData.getUserInfo().getId()
			if v.Revenge then
				state = v.WRid == selfRid and 5 or 6
				opponentName = v.DefServerName and ( string.format([[\[%s\]%s]], v.DefServerName, v.DefName) ) or v.DefName
			else
				if v.AtkRid == selfRid then
					state = v.WRid == v.AtkRid and 1 or 2
					opponentName = v.DefServerName and ( string.format([[\[%s\]%s]], v.DefServerName, v.DefName) ) or v.DefName
				elseif v.DefRid == selfRid then
					state = v.WRid == v.DefRid and 3 or 4
					opponentName = v.AtkServerName and ( string.format([[\[%s\]%s]], v.AtkServerName, v.AtkName) ) or v.AtkName
				end
			end

			local rewardList = res.getRewardResList(v.Reward)
			if state == 1 and rewardList and #rewardList > 0 then
				local rewardItem = rewardList[1]
				nodeLuaSet["bg_content"]:setString(string.format(res.locString("Explore$reportFormat5"), opponentName, rewardItem.name .. "x" .. tostring(rewardItem.count)))
			else
				nodeLuaSet["bg_content"]:setString(string.format(res.locString(string.format("Explore$reportFormat%d", (state-1)%4 + 1)), opponentName))
			end

			nodeLuaSet["bg_icon"]:setResid(string.format("N_TB_qiangduo_wenzi%d.png", state))
			
			local seconds = require "TimeListManager".getOffsetTimeToNow(math.floor(v.T/1000))
			nodeLuaSet["bg_timeLabel"]:setString(res.getTimeText(seconds / 60))
		end)
	end
	self.reportList:update(self.ReportDataList)
end

function DExploration:updateTabNameColor( ... )
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

function DExploration:updatePetInLocation(index, NPet, explore)
	local setMain = self.pageList[tabList.TabMain]
	setMain[string.format('clickSite%d_normal_BG_none', index)]:setVisible(false)
	setMain[string.format('clickSite%d_normal_BG_pet', index)]:setVisible(true)
	if explore.RobedSucc > 0 then
		setMain[string.format('clickSite%d_normal_BG_pet_flagIcon', index)]:setResid("N_TB_wenzi3.png")
	else
		if explore.Finish then
			setMain[string.format('clickSite%d_normal_BG_pet_flagIcon', index)]:setResid("N_TB_wenzi2.png")
		else
			setMain[string.format('clickSite%d_normal_BG_pet_flagIcon', index)]:setResid("N_TB_wenzi1.png")
		end
	end
	
	local DBPet = DBManager.getCharactor(NPet.PetId)
	setMain[string.format('clickSite%d_normal_BG_pet_icon', index)]:setResid(Res.getPetIcon(DBPet.id))
	setMain[string.format('clickSite%d_normal_BG_pet_frame', index)]:setResid(Res.getPetIconFrame(NPet))
	setMain[string.format('clickSite%d_normal_BG_pet_name', index)]:setString(DBPet.name)
	setMain[string.format('clickSite%d_normal_BG_pet_career', index)]:setResid(Res.getPetCareerIcon(DBPet.atk_method_system, true))
	setMain[string.format('clickSite%d_normal_BG_pet_property', index)]:setResid(Res.getPetPropertyIcon(DBPet.prop_1, true))
	setMain[string.format('clickSite%d_normal_BG_pet_starLayout', index)]:removeAllChildrenWithCleanup(true)
	require 'PetNodeHelper'.updateStarLayout(setMain[string.format('clickSite%d_normal_BG_pet_starLayout', index)], DBPet)
	setMain[string.format('clickSite%d', index)]:setListener(function()
		if explore.CanRevenge then
			GleeCore:showLayer("DExploreRevenge", {SlotId = explore.Sid, cancelCallback = function ( ... )
				explore.CanRevenge = false
			end})		
		else
			if explore.Finish then
				self:send(NetModel.getModelExploreFinish(index), function (data)
					AppData.updateResource(data.D.Resource)
					AppData.getExploreInfo().setExploreData(data.D.List)
					self:updatePages()
					GleeCore:showLayer('DGetReward', data.D.Reward)
					--if not AppData.getExploreInfo().hasCompleteExplore() then
						require 'EventCenter'.eventInput("explore")
					--end
				end)
			else
				-- 1小时：  金币获得量=探宝时间（分钟，向下取整）*（精灵战力/10）^0.4*40/3
				-- 3小时：  金币获得量=探宝时间（分钟，向下取整）*（精灵战力/10）^0.4*80/9
				-- 8小时：金币获得量=探宝时间（分钟，向下取整）*（精灵战力/10）^0.4*20/3

				-- 1小时： 金币获得量=探宝时间（分钟，向下取整）*（精灵战力/10）^0.4*40/3 
				-- 3小时： 金币获得量=探宝时间（分钟，向下取整）*（精灵战力/10）^0.4*80/9 
				-- 8小时：金币获得量=探宝时间（分钟，向下取整）*（精灵战力/10）^0.4*20/3 

				-- 1小时：获得额外收益的次数= int(探宝时间（分钟，向下取整）/60） 
				-- 3小时：获得额外收益的次数= int(探宝时间（分钟，向下取整）/90） 
				-- 8小时：获得额外收益的次数= int(探宝时间（分钟，向下取整）/160） 
				-- 时间未定的时候点击头像弹框提示：“现在已探宝N分钟，是否要提前结束本次探宝?
				-- 可获得收益：金币1000”金币用图标，后面可获得收益换行显示。 确定 取消 点确定直接按上述收益公式结算
				local offSet = -TimeManager.timeOffset(explore.EndAt, require 'AccountInfo'.getCurrentServerUTCOffset())
				local minute = math.floor(explore.Hours * 60 - offSet / 60)
				
				local temp = 1
				if explore.Hours == 1 then
					temp = 40/3
				elseif explore.Hours == 3 then
					temp = 80/9
				elseif explore.Hours == 8 then
					temp = 20/3
				end

				local curEarnings =  math.floor(minute * ((NPet.Power / 10)^0.4) * temp)
				GleeCore:showLayer('DFinishExplore', {earnings = curEarnings, remanderMin = minute,callBack = function ( ... )
					self:send(NetModel.getModelExploreFinish(index), function (data)
						AppData.updateResource(data.D.Resource)
						AppData.getExploreInfo().setExploreData(data.D.List)
						self:updatePages()
						if data.D.Reward.Gold > 0 then
							GleeCore:showLayer('DGetReward', data.D.Reward)
						end
						require 'EventCenter'.eventInput("explore")
					end)
				end})
				--self:toast('现在已探宝N分钟，是否要提前结束本次探宝？可获得收益：金币1000')
			end
		end
	end)

	local offSet = -TimeManager.timeOffset(explore.EndAt, require 'AccountInfo'.getCurrentServerUTCOffset())
	if offSet <= 0 then
		explore.Finish = true 
	end
	if explore.Finish then
		setMain[string.format('clickSite%d_normal_BG_pet_countDown', index)]:setVisible(false)
		setMain[string.format('clickSite%d_normal_BG_pet_finish', index)]:setVisible(true)
	else
		setMain[string.format('clickSite%d_normal_BG_pet_countDown', index)]:setVisible(true)
		setMain[string.format('clickSite%d_normal_BG_pet_finish', index)]:setVisible(false)

		local hour = offSet / 3600
		offSet = offSet % 3600
		local minute = offSet / 60
		offSet = offSet % 60
		local second = offSet

		local date = setMain[string.format('clickSite%d_normal_BG_pet_countDown', index)]:getElfDate()
		date:setHourMinuteSecond(hour, minute, math.ceil(second))
		setMain[string.format('clickSite%d_normal_BG_pet_countDown', index)]:setUpdateRate(-1)
		setMain[string.format('clickSite%d_normal_BG_pet_countDown', index)]:addListener(function()
			setMain[string.format('clickSite%d_normal_BG_pet_countDown', index)]:setVisible(false)
			setMain[string.format('clickSite%d_normal_BG_pet_finish', index)]:setVisible(true)
			explore.Finish = true
			self:updatePetInLocation(index, NPet, explore)
		end)
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DExploration, "DExploration")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DExploration", DExploration)


