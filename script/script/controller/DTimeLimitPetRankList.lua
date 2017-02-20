local Config = require "Config"
local res = require "Res"
local LuaList = require "LuaList"
local gameFunc = require "AppData"
local dbManager = require "DBManager"
local DTimeLimitPetRankList = class(LuaDialog)

function DTimeLimitPetRankList:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DTimeLimitPetRankList.cocos.zip")
    return self._factory:createDocument("DTimeLimitPetRankList.cocos")
end

--@@@@[[[[
function DTimeLimitPetRankList:onInitXML()
	local set = self._set
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_clickBg = set:getClickNode("commonDialog_clickBg")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_bg = set:getJoint9Node("commonDialog_cnt_bg")
    self._commonDialog_cnt_page = set:getElfNode("commonDialog_cnt_page")
    self._list = set:getListNode("list")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._rank = set:getLabelNode("rank")
    self._name = set:getLabelNode("name")
    self._score = set:getLabelNode("score")
    self._list = set:getListNode("list")
    self._icon = set:getElfNode("icon")
    self._score = set:getLabelNode("score")
    self._rewardLayout = set:getLayoutNode("rewardLayout")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._count = set:getLabelNode("count")
    self._name = set:getLabelNode("name")
    self._piece = set:getElfNode("piece")
    self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
    self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
    self._commonDialog_tab = set:getElfNode("commonDialog_tab")
    self._commonDialog_tab_tabRank = set:getTabNode("commonDialog_tab_tabRank")
    self._commonDialog_tab_tabRank_title = set:getLabelNode("commonDialog_tab_tabRank_title")
    self._commonDialog_tab_tabReward = set:getTabNode("commonDialog_tab_tabReward")
    self._commonDialog_tab_tabReward_title = set:getLabelNode("commonDialog_tab_tabReward_title")
--    self._@pageRankList = set:getElfNode("@pageRankList")
--    self._@itemRank = set:getElfNode("@itemRank")
--    self._@pageRankReward = set:getElfNode("@pageRankReward")
--    self._@itemReward = set:getElfNode("@itemReward")
--    self._@reward = set:getElfNode("@reward")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DTimeLimitPetRankList:onInit( userData, netData )
	res.doActionDialogShow(self._commonDialog)
	
	self:setListenerEvent()
	self:initPagesRankList(userData)
	self:initPagesRankReward()
	self.tabIndexSelected = 1
	self:updatePages()

	require 'LangAdapter'.selectLang(nil, nil, nil, nil, function ( ... )
		self._commonDialog_tab_tabRank_title:setFontSize(22)
		self._commonDialog_tab_tabReward_title:setFontSize(22)
	end)
end

function DTimeLimitPetRankList:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DTimeLimitPetRankList:setListenerEvent(  )
	self._commonDialog_clickBg:setListener(function (  )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._commonDialog_btnClose:setListener(function (  )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._commonDialog_tab_tabRank:trigger(nil)
	self._commonDialog_tab_tabRank:setListener(function (  )
		if self.tabIndexSelected ~= 1 then
			self.tabIndexSelected = 1
			self:updatePages()
		end
	end)

	self._commonDialog_tab_tabReward:setListener(function (  )
		if self.tabIndexSelected ~= 2 then
			self.tabIndexSelected = 2
			self:updatePages()
		end	
	end)
end

function DTimeLimitPetRankList:initPagesRankList( dataList )
	local pageRankList = self:createLuaSet("@pageRankList")
	self._commonDialog_cnt_page:addChild(pageRankList[1])
	self.page1 = pageRankList[1]

	local rankList = LuaList.new(pageRankList["list"], function ( ... )
		return self:createLuaSet("@itemRank")
	end, function ( nodeLuaSet, data, index )
		nodeLuaSet["bg"]:setVisible(index % 2 == 1)
		nodeLuaSet["rank"]:setString("NO." .. data.Id)
		nodeLuaSet["name"]:setString(data.Name)
		nodeLuaSet["score"]:setString(data.Score)
		if index >= 1 and index <= 3 then
			nodeLuaSet["icon"]:setResid(string.format("paiming_tubiao%d.png", index))
			nodeLuaSet["icon"]:setVisible(true)
		else
			nodeLuaSet["icon"]:setVisible(false)
		end
	end)
	rankList:update(dataList, true)
end

function DTimeLimitPetRankList:initPagesRankReward(  )
	local activeData = gameFunc.getActivityInfo().getDataByType(3)
	if activeData and activeData.Data then
		print("initPagesRankReward")
		print(activeData.Data)
		local listData = {}
		if activeData.Data.Ranks then
			for i,v in ipairs(activeData.Data.Ranks) do
				table.insert(listData, {nReward = v})
			end
		end
		if activeData.Data.Scores then
			for i,v in ipairs(activeData.Data.Scores) do
				table.insert(listData, {nReward = v, score = i == 1 and 100 or 200})
			end
		end
		if activeData.Data.ScoresRewards then
			local temp = {}
			for k,v in pairs(activeData.Data.ScoresRewards) do
				table.insert(temp, {nReward = v, score = tonumber(k)})
			end
			table.sort(temp, function ( v1, v2 )
				return v1.score < v2.score
			end)
			for i,v in ipairs(temp) do
				table.insert(listData, v)
			end
		end

		local pageRankReward = self:createLuaSet("@pageRankReward")
		self._commonDialog_cnt_page:addChild(pageRankReward[1])
		self.page2 = pageRankReward[1]

		local rewardList = LuaList.new(pageRankReward["list"], function ( ... )
			return self:createLuaSet("@itemReward")
		end, function ( nodeLuaSet, data, index )
			local rewardData = data.nReward
			if data.score then
				nodeLuaSet["icon"]:setResid("XS_paiming6.png")
				nodeLuaSet["score"]:setString(data.score)
			else
				nodeLuaSet["icon"]:setResid(string.format("XS_paiming%d.png", index))
				nodeLuaSet["score"]:setString("")
			end
			
			nodeLuaSet["rewardLayout"]:removeAllChildrenWithCleanup(true)
			if rewardData then
				local scaleOrigal = 85 / 155
				local list = res.getRewardResList(rewardData)
				if list then
					for i,v in ipairs(list) do
						local item = self:createLuaSet("@reward")
						nodeLuaSet["rewardLayout"]:addChild(item[1])
						item["name"]:setString(v.name)
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
					end
				end
			end
		end)
		rewardList:update(listData)
	end
end

function DTimeLimitPetRankList:updatePages(  )
	self.page1:setVisible(self.tabIndexSelected == 1)
	self.page2:setVisible(self.tabIndexSelected == 2)
	self:updateTabNameColor()
end

function DTimeLimitPetRankList:updateTabNameColor( ... )
	local tabNameList = {
		self._commonDialog_tab_tabRank_title,
		self._commonDialog_tab_tabReward_title,
	}
	for i,v in ipairs(tabNameList) do
		if self.tabIndexSelected == i then
			v:setFontFillColor(res.tabColor2.selectedTextColor, true)
			v:enableStroke(res.tabColor2.selectedStrokeColor, 2, true)
		else
			v:setFontFillColor(res.tabColor2.unselectTextColor, true)
			v:enableStroke(res.tabColor2.unselectStrokeColor, 2, true)
		end
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DTimeLimitPetRankList, "DTimeLimitPetRankList")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DTimeLimitPetRankList", DTimeLimitPetRankList)
