local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local netModel = require "netModel"
local EventCenter = require "EventCenter"
local UnlockManager = require 'UnlockManager'
local gameFunc = require "AppData"
local PerlBookInfo = gameFunc.getPerlBookInfo()

local tabList = {
	["TabMain"] = 1,
	["TabMerge"] = 2,
	["TabBall"] = 3,
	["TabBook"] = 4,
	["TabRank"] = 5,
	["TabCount"] = 5,
}

local DRemains = class(LuaDialog)

function DRemains:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DRemains.cocos.zip")
    return self._factory:createDocument("DRemains.cocos")
end

--@@@@[[[[
function DRemains:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_page = set:getElfNode("commonDialog_cnt_page")
    self._bg = set:getElfNode("bg")
    self._layoutAmt = set:getLinearLayoutNode("layoutAmt")
    self._layoutAmt_v = set:getLabelNode("layoutAmt_v")
    self._btnGo = set:getClickNode("btnGo")
    self._tip = set:getLabelNode("tip")
    self._bg = set:getElfNode("bg")
    self._tip2 = set:getRichLabelNode("tip2")
    self._hale = set:getElfNode("hale")
    self._animAnswer = set:getSimpleAnimateNode("animAnswer")
    self._animParticle = set:getSimpleAnimateNode("animParticle")
    self._layoutGird = set:getLayoutNode("layoutGird")
    self._icon = set:getElfNode("icon")
    self._btn = set:getButtonNode("btn")
    self._icon = set:getElfNode("icon")
    self._btn = set:getButtonNode("btn")
    self._icon = set:getElfNode("icon")
    self._btn = set:getButtonNode("btn")
    self._icon = set:getElfNode("icon")
    self._btn = set:getButtonNode("btn")
    self._btnAddOneKey = set:getClickNode("btnAddOneKey")
    self._btnMerge = set:getClickNode("btnMerge")
    self._btnMergeScreen = set:getButtonNode("btnMergeScreen")
    self._bg = set:getJoint9Node("bg")
    self._listBalls = set:getListNode("listBalls")
    self._bg = set:getElfNode("bg")
    self._career = set:getLabelNode("career")
    self._layoutCount = set:getLinearLayoutNode("layoutCount")
    self._layoutCount_v = set:getLabelNode("layoutCount_v")
    self._layout = set:getLayoutNode("layout")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._count = set:getLabelNode("count")
    self._name = set:getLabelNode("name")
    self._btn = set:getButtonNode("btn")
    self._bg = set:getJoint9Node("bg")
    self._listBooks = set:getListNode("listBooks")
    self._bg = set:getElfNode("bg")
    self._career = set:getLabelNode("career")
    self._layoutCount = set:getLinearLayoutNode("layoutCount")
    self._layoutCount_v = set:getLabelNode("layoutCount_v")
    self._layout = set:getLayoutNode("layout")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._piece = set:getElfNode("piece")
    self._count = set:getLabelNode("count")
    self._name = set:getLabelNode("name")
    self._btn = set:getButtonNode("btn")
    self._bg = set:getJoint9Node("bg")
    self._bg_top = set:getElfNode("bg_top")
    self._bg_top_rank = set:getLabelNode("bg_top_rank")
    self._bg_top_name = set:getLabelNode("bg_top_name")
    self._bg_top_today = set:getLabelNode("bg_top_today")
    self._bg_top_history = set:getLabelNode("bg_top_history")
    self._bg_none = set:getLabelNode("bg_none")
    self._listRank = set:getListNode("listRank")
    self._bg = set:getElfNode("bg")
    self._rankIcon = set:getElfNode("rankIcon")
    self._rankLabel = set:getLabelNode("rankLabel")
    self._name = set:getLabelNode("name")
    self._today = set:getLabelNode("today")
    self._history = set:getLabelNode("history")
    self._isMe = set:getElfNode("isMe")
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
--    self._@pageMerge = set:getElfNode("@pageMerge")
--    self._@item = set:getElfNode("@item")
--    self._@item = set:getElfNode("@item")
--    self._@item = set:getElfNode("@item")
--    self._@item = set:getElfNode("@item")
--    self._@pageBalls = set:getElfNode("@pageBalls")
--    self._@title = set:getElfNode("@title")
--    self._@size = set:getElfNode("@size")
--    self._@itemBall = set:getElfNode("@itemBall")
--    self._@pageBooks = set:getElfNode("@pageBooks")
--    self._@title = set:getElfNode("@title")
--    self._@size = set:getElfNode("@size")
--    self._@itemBook = set:getElfNode("@itemBook")
--    self._@pageRank = set:getElfNode("@pageRank")
--    self._@itemRank = set:getElfNode("@itemRank")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register('DRemains',function ( userData )
	if UnlockManager:isUnlock("Remain") then
	   Launcher.callNet(netModel.getModelRemainTimesGet(), function ( data )
	   	print("RemainTimesGet")
	   	print(data)
	   	Launcher.Launching(data)   
	 	end)
	else
		return GleeCore:toast(UnlockManager:getUnlockConditionMsg("Remain"))
	end
end)

function DRemains:onInit( userData, netData )
	if netData and netData.D then
		self.Times = netData.D.Times
		self.TimesBuy = netData.D.TimesBuy
	end
	self.tabIndexSelected = tabList.TabMain

	self:setListenerEvent()
	self:initPageArray()
	self:updatePages()
	res.doActionDialogShow(self._commonDialog)

	EventCenter.addEventFunc("UpdateSkillBook", function ( ... )
		self:updatePages()
	end, "DRemains")
end

function DRemains:onBack( userData, netData )
	
end

function DRemains:close( ... )
	EventCenter.resetGroup("DRemains")
end

--------------------------------custom code-----------------------------

function DRemains:setListenerEvent( ... )
	for i=1,tabList.TabCount do		
		self[string.format("_commonDialog_tab_tab%d_point", i)]:setVisible(false)
		require 'LangAdapter'.fontSize(self[string.format("_commonDialog_tab_tab%d_title", i)], nil, nil, nil, nil, 20)
		self[string.format("_commonDialog_tab_tab%d", i)]:setListener(function ( ... )
			if self.tabIndexSelected ~= i then
				self.tabIndexSelected = i
				self:updatePages(true)
			end
		end)

		require "LangAdapter".fontSize(self[string.format("_commonDialog_tab_tab%d_title", i)], nil,nil,nil,nil,nil,nil,nil,16)
	end

	self._commonDialog_btnHelp:setListener(function ( ... )
		GleeCore:showLayer("DHelp", {type = "古代遗迹"})
	end)

	self._commonDialog_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)
end

function DRemains:initPageArray( ... )
	local dyList = {
		[tabList.TabMain] = "@pageMain", 
		[tabList.TabMerge] = "@pageMerge", 
		[tabList.TabBall] = "@pageBalls", 
		[tabList.TabBook] = "@pageBooks",
		[tabList.TabRank] = "@pageRank",
	}
	self.pageList = {}
	for i,v in ipairs(dyList) do
		local set = self:createLuaSet(v)
		self._commonDialog_cnt_page:addChild(set[1])
		set[1]:setVisible(false)
		table.insert(self.pageList, set)
	end
end

function DRemains:updatePages( ... )
	for i,v in ipairs(self.pageList) do
		v[1]:setVisible(i == self.tabIndexSelected)
	end

	self[string.format("_commonDialog_tab_tab%d", self.tabIndexSelected)]:trigger(nil)
	self:updateTabNameColor()
	
	if self.tabIndexSelected == tabList.TabMain then
		self:updateRemainsMain()
	elseif self.tabIndexSelected == tabList.TabMerge then
		self:updateRemainsMerge()
	elseif self.tabIndexSelected == tabList.TabBall then
		self:updateBalls()
	elseif self.tabIndexSelected == tabList.TabBook then
		self:updateBooks()
	elseif self.tabIndexSelected == tabList.TabRank then
		self:updateRemainsRank()
	end
end

function DRemains:updateTabNameColor( ... )
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

function DRemains:updateRemainsMain( ... )
	local setMain = self.pageList[tabList.TabMain]
	setMain["layoutAmt_v"]:setString(self.Times)
	setMain["btnGo"]:setListener(function ( ... )
		GleeCore:closeAllLayers()
		GleeCore:pushController("CDungeonRemains", param, nil, res.getTransitionFade())
	end)
end

function DRemains:updateRemainsMerge( ... )
	local setMerge = self.pageList[tabList.TabMerge]
	setMerge["tip2"]:setString(res.locString("Remains$MergeTip2"))
	setMerge["tip2"]:setFontFillColor(ccc4f(0, 0, 1, 0), true)
	require "LangAdapter".LabelNodeAutoShrink(setMerge["tip2"], 730)

	setMerge["layoutGird"]:removeAllChildrenWithCleanup(true)
	self.BallSelectList = self.BallSelectList or {}
	for i=1,4 do
		local item = self:createLuaSet("@item")
		setMerge["layoutGird"]:addChild(item[1])
		if i <= #self.BallSelectList then
			local dbPerl = dbManager.getInfoPerlConfig(self.BallSelectList[i].Pid)
			res.setNodeWithBall(item["icon"], dbPerl)
			item["icon"]:setScale(94/150)
		end
		item["btn"]:setListener(function ( ... )
			local param = {}
			param.SelectedList = self.BallSelectList
			param.OnCompleted = function (data)
				print(data)
				self.BallSelectList = data
				self:updatePages()
			end
			print(param)
			GleeCore:showLayer("DCareerBall", param)	
		end)
	end

	setMerge["btnAddOneKey"]:setEnabled(#self.BallSelectList < 4)
	setMerge["btnAddOneKey"]:setListener(function ( ... )
		local list = PerlBookInfo.getPerlsWithSingle()
		for i,v in ipairs(list) do
			if #self.BallSelectList >= 4 then 
				break
			end
			local canFind = false
			for k,g in pairs(self.BallSelectList) do
				if v.Id == g.Id and v._index == g._index then
					canFind = true
					break
				end
			end
			if not canFind then
				table.insert(self.BallSelectList, v)
			end
		end
		self:updatePages()
	end)
	setMerge["btnMerge"]:setEnabled(#self.BallSelectList == 4)
	
	setMerge["animAnswer"]:setListener(function ( ... )
		local list = {}
		for i,v in ipairs(self.BallSelectList) do
			table.insert(list, v.Id)
		end
		self:send(netModel.getModelRemainPerlSyn(list), function ( data )
			if data and data.D then
				PerlBookInfo.removePerls(self.BallSelectList)
				
				if data.D.Resource then
					gameFunc.updateResource(data.D.Resource)
				end

				if data.D.Reward then
					data.D.Reward.callback = function ( ... )
						if not self:isDisposed() then
							self.BallSelectList = {}
							self:updatePages()
						end
					end
					GleeCore:showLayer("DGetReward", data.D.Reward)
				end
			end
		end)

		setMerge["animAnswer"]:reset()
		setMerge["animAnswer"]:setPaused(true)
		setMerge["animAnswer"]:setVisible(true)
		setMerge["btnMergeScreen"]:setVisible(false)
	end)

	setMerge["btnMerge"]:setListener(function ( ... )
		setMerge["btnMergeScreen"]:setVisible(true)
		setMerge["animParticle"]:setLoops(1)
		setMerge["animParticle"]:start()
		setMerge["animAnswer"]:setLoops(2)
		setMerge["animAnswer"]:start()
	end)

	setMerge["btnMergeScreen"]:setListener(function ( ... )
		setMerge["animAnswer"]:stop()
		setMerge["animParticle"]:stop()
	end)

	setMerge["btnMergeScreen"]:setVisible(false)
	setMerge["animParticle"]:stop()
	setMerge["animAnswer"]:reset()
	setMerge["animAnswer"]:setPaused(true)
	setMerge["animAnswer"]:setVisible(true)
end

function DRemains:updateBalls( ... )
	local setBall = self.pageList[tabList.TabBall]
	setBall["listBalls"]:getContainer():removeAllChildrenWithCleanup(true)
	local oneLineCount = 5
	for careerIndex=1,4 do
		local balls = self:getBallsWithType(careerIndex)
		if balls and #balls > 0 then
			local title = self:createLuaSet("@title")
			setBall["listBalls"]:getContainer():addChild(title[1])
			title["career"]:setString(res.locString(string.format("Bag$Treasure%d", careerIndex)))
			local sum = 0
			for k,v in pairs(balls) do
				sum = sum + v.Amount
			end
			title["layoutCount_v"]:setString(sum)

			local sizeSet
			for i,v in ipairs(balls) do
				if i % oneLineCount == 1 then
					sizeSet = self:createLuaSet("@size")
					setBall["listBalls"]:getContainer():addChild(sizeSet[1])
				end
				local itemBall = self:createLuaSet("@itemBall")
				sizeSet["layout"]:addChild(itemBall[1])

				local dbPerl = dbManager.getInfoPerlConfig(v.Pid)
				res.setNodeWithBall(itemBall["icon"], dbPerl)
				itemBall["count"]:setString(v.Amount)
				itemBall["name"]:setString(dbPerl.name)
				itemBall["btn"]:setEnabled(false)
			end
		end
	end
end

function DRemains:updateBooks( ... )
	local setBook = self.pageList[tabList.TabBook]
	setBook["listBooks"]:getContainer():removeAllChildrenWithCleanup(true)
	local oneLineCount = 5
	local colorList = {[1] = 0, [2] = 5, [3] = 25, [4] = 50}
	for careerIndex=0,4 do
		local books = self:getBooksWithType(careerIndex)
		if books and #books > 0 then
			local title = self:createLuaSet("@title")
			setBook["listBooks"]:getContainer():addChild(title[1])
			title["career"]:setString(res.locString(string.format("Bag$Treasure%d", careerIndex)))
			local sum = 0
			for k,v in pairs(books) do
				sum = sum + v.Amount
			end
			title["layoutCount_v"]:setString(sum)

			local sizeSet
			for i,v in ipairs(books) do
				if i % oneLineCount == 1 then
					sizeSet = self:createLuaSet("@size")
					setBook["listBooks"]:getContainer():addChild(sizeSet[1])
				end
				local itemBook = self:createLuaSet("@itemBook")
				sizeSet["layout"]:addChild(itemBook[1])

				local dbBook = dbManager.getInfoBookConfig(v.Bid)
				local dbSkill = dbManager.getInfoSkill(v.Bid)
				res.setNodeWithBook(itemBook["icon"], dbBook)
				itemBook["piece"]:setVisible(v.isPiece)
				if v.isPiece then
					itemBook["count"]:setString(string.format("%d/%d", v.Amount, colorList[dbBook.Color]))
					if v.Amount < colorList[dbBook.Color] then
						itemBook["count"]:setFontFillColor(res.color4F.red, true)
					else
						itemBook["count"]:setFontFillColor(res.color4F.green, true)
					end
				else
					itemBook["count"]:setString(v.Amount)
				end

				itemBook["name"]:setString(dbSkill.name)
				require "LangAdapter".fontSize(itemBook["name"], nil, nil, 18, nil, 18)
				itemBook["btn"]:setListener(function ( ... )
					GleeCore:showLayer("DSkillBookDetail", v)
				end)
			end
		end
	end
end

function DRemains:updateRemainsRank( ... )
	if self.remainRanks then
		self:updateRemainsRankReal()
	else
		self:send(netModel.getModelRemainRanksGet(), function ( data )
			print("RemainRanksGet")
			print(data)
			if data and data.D then
				self.remainRanks = data.D.Ranks or {}
				table.sort(self.remainRanks, function ( v1, v2 )
					return v1.Rank < v2.Rank
				end)
				self:updateRemainsRankReal()
			end
		end)
	end
end

function DRemains:updateRemainsRankReal( ... )
	local setRank = self.pageList[tabList.TabRank]
	local rankList = self.remainRanks
	setRank["bg_none"]:setVisible(#rankList == 0)
	setRank["listRank"]:getContainer():removeAllChildrenWithCleanup(true)
	for i,v in ipairs(rankList) do
		local itemRank = self:createLuaSet("@itemRank")
		setRank["listRank"]:getContainer():addChild(itemRank[1])
		itemRank["bg"]:setVisible(i % 2 == 0)
		itemRank["rankIcon"]:setVisible(i <= 3)
		itemRank["rankLabel"]:setVisible(i > 3)
		if i <= 3 then
			itemRank["rankIcon"]:setResid(string.format('PHB_PM%d.png', i))
		else
			itemRank["rankLabel"]:setString(tostring(i))
		end
		itemRank["name"]:setString(v.Name .. " Lv." .. v.Lv)
		itemRank["today"]:setString(v.TodayTopLv)
		itemRank["history"]:setString(v.HiTopLv)
		itemRank["isMe"]:setVisible(gameFunc.getUserInfo().getId() == v.Rid)
	end

	require "LangAdapter".fontSize(setRank["bg_top_rank"], nil, nil, nil, nil, nil,22)
	require "LangAdapter".fontSize(setRank["bg_top_name"], nil, nil, nil, nil, nil,22)
	require "LangAdapter".fontSize(setRank["bg_top_today"], nil, nil, nil, nil, nil,22)
	require "LangAdapter".fontSize(setRank["bg_top_history"], nil, nil, nil, nil, nil,22)
end

function DRemains:getBallsWithType( careerIndex )
	local list = {}
	for i,v in ipairs(PerlBookInfo.getPerls()) do
		local dbPerl = dbManager.getInfoPerlConfig(v.Pid)
		if dbPerl and dbPerl.classid == careerIndex then
			table.insert(list, v)
		end
	end
	return list
end

function DRemains:getBooksWithType( careerIndex )
	local list = {}
	local pieces = table.clone(PerlBookInfo.getBookPieces())
	for i,v in ipairs(pieces) do
		local dbBook = dbManager.getInfoBookConfig(v.Bid)
		if dbBook and dbBook.ClassId == careerIndex then
			pieces[i].isPiece = true
			table.insert(list, pieces[i])
		end
	end

	for i,v in ipairs(PerlBookInfo.getBooks()) do
		local dbBook = dbManager.getInfoBookConfig(v.Bid)
		if dbBook and dbBook.ClassId == careerIndex then
			table.insert(list, v)
		end
	end
	return list
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DRemains, "DRemains")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DRemains", DRemains)
