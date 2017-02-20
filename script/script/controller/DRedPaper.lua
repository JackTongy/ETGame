local Config = require "Config"
local netModel = require "netModel"
local res = require "Res"
local dbManager = require "DBManager"
local gameFunc = require "AppData"
local redPaper = gameFunc.getRedPaperInfo()
local LuaList = require "LuaList"
local tabList = {["TabMain"] = 1, ["TabExchange"] = 2, ["TabRank"] = 3}

local DRedPaper = class(LuaDialog)

function DRedPaper:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DRedPaper.cocos.zip")
    return self._factory:createDocument("DRedPaper.cocos")
end

--@@@@[[[[
function DRedPaper:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_page = set:getElfNode("commonDialog_cnt_page")
    self._bg1_layoutScore_v = set:getLabelNode("bg1_layoutScore_v")
    self._bg1_layoutPaper1_v = set:getLabelNode("bg1_layoutPaper1_v")
    self._bg1_layoutPaper2_v = set:getLabelNode("bg1_layoutPaper2_v")
    self._bg1_layoutPaper3_v = set:getLabelNode("bg1_layoutPaper3_v")
    self._bg1_btnSend = set:getClickNode("bg1_btnSend")
    self._list = set:getListNode("list")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._title = set:getLabelNode("title")
    self._layout1_v = set:getLabelNode("layout1_v")
    self._layout2_v = set:getLabelNode("layout2_v")
    self._layout3_k = set:getLabelNode("layout3_k")
    self._layout3_v = set:getLabelNode("layout3_v")
    self._icon2 = set:getElfNode("icon2")
    self._iconFrame = set:getElfNode("iconFrame")
    self._count = set:getLabelNode("count")
    self._piece = set:getElfNode("piece")
    self._r_layout_time = set:getLabelNode("r_layout_time")
    self._list = set:getListNode("list")
    self._layout = set:getLayoutNode("layout")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._iconFrame = set:getElfNode("iconFrame")
    self._piece = set:getElfNode("piece")
    self._name = set:getLabelNode("name")
    self._count = set:getLabelNode("count")
    self._layoutPrice = set:getLinearLayoutNode("layoutPrice")
    self._layoutPrice_icon = set:getElfNode("layoutPrice_icon")
    self._layoutPrice_v2 = set:getLabelNode("layoutPrice_v2")
    self._btnBuy = set:getClickNode("btnBuy")
    self._btnDetail = set:getButtonNode("btnDetail")
    self._layoutSocre_v1 = set:getLabelNode("layoutSocre_v1")
    self._list = set:getListNode("list")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._rank = set:getLabelNode("rank")
    self._name2 = set:getLabelNode("name2")
    self._name1 = set:getLabelNode("name1")
    self._paper = set:getLabelNode("paper")
    self._btn = set:getButtonNode("btn")
    self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
    self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
    self._commonDialog_tab = set:getElfNode("commonDialog_tab")
    self._commonDialog_tab_tabMain = set:getTabNode("commonDialog_tab_tabMain")
    self._commonDialog_tab_tabMain_title = set:getLabelNode("commonDialog_tab_tabMain_title")
    self._commonDialog_tab_tabMain_point = set:getElfNode("commonDialog_tab_tabMain_point")
    self._commonDialog_tab_tabExchange = set:getTabNode("commonDialog_tab_tabExchange")
    self._commonDialog_tab_tabExchange_title = set:getLabelNode("commonDialog_tab_tabExchange_title")
    self._commonDialog_tab_tabExchange_point = set:getElfNode("commonDialog_tab_tabExchange_point")
    self._commonDialog_tab_tabRank = set:getTabNode("commonDialog_tab_tabRank")
    self._commonDialog_tab_tabRank_title = set:getLabelNode("commonDialog_tab_tabRank_title")
    self._commonDialog_tab_tabRank_point = set:getElfNode("commonDialog_tab_tabRank_point")
--    self._@main = set:getElfNode("@main")
--    self._@itemGet = set:getElfNode("@itemGet")
--    self._@shop = set:getElfNode("@shop")
--    self._@sizeShop = set:getElfNode("@sizeShop")
--    self._@itemGood = set:getElfNode("@itemGood")
--    self._@rank = set:getElfNode("@rank")
--    self._@itemRank = set:getElfNode("@itemRank")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DRedPaper", function ( userData )
	-- if redPaper.getMySummary() ~= nil then
	-- 	Launcher.Launching()
	-- else
	   	Launcher.callNet(netModel.getModelHongbaoSummaryGet(),function ( data )
	   		print("HongbaoSummaryGet")
	   		print(data)
	   		if data and data.D then
	   			redPaper.setMySummary(data.D.Summary)
	   			redPaper.setRecords(data.D.Records)
	   			redPaper.setEndAt(data.D.EndAt)
	   		end
	     		Launcher.Launching()   
	   	end)
	-- end
end)

function DRedPaper:onInit( userData, netData )
	self:setListenerEvent()
	self:initPageArray()
	self.tabIndexSelected = tabList.TabMain
	self:updateLayer()
	res.doActionDialogShow(self._commonDialog)
end

function DRedPaper:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DRedPaper:setListenerEvent( ... )
	require 'LangAdapter'.fontSize(self._commonDialog_tab_tabMain_title,nil,nil,nil,nil,17)
	require 'LangAdapter'.fontSize(self._commonDialog_tab_tabExchange_title,nil,nil,nil,nil,18)
	require 'LangAdapter'.fontSize(self._commonDialog_tab_tabRank_title,nil,nil,nil,nil,18)

	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._commonDialog_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._commonDialog_tab_tabMain:trigger(nil)
	self._commonDialog_tab_tabMain:setListener(function ( ... )
		if self.tabIndexSelected ~= tabList.TabMain then
			self.tabIndexSelected = tabList.TabMain
			self:updateLayer()
		end
	end)
	self._commonDialog_tab_tabMain_point:setVisible(false)

	self._commonDialog_tab_tabExchange:setListener(function ( ... )
		if self.tabIndexSelected ~= tabList.TabExchange then
			self.tabIndexSelected = tabList.TabExchange
			self:updateLayer()
		end
	end)
	self._commonDialog_tab_tabExchange_point:setVisible(false)

	self._commonDialog_tab_tabRank:setListener(function ( ... )
		if self.tabIndexSelected ~= tabList.TabRank then
			self.tabIndexSelected = tabList.TabRank
			self:updateLayer()
		end
	end)
	self._commonDialog_tab_tabRank_point:setVisible(false)
end

function DRedPaper:initPageArray( ... )
	self.pageList = {}
	local mainSet = self:createLuaSet("@main")
	self._commonDialog_cnt_page:addChild(mainSet[1])
	table.insert(self.pageList, mainSet)

	local shopSet = self:createLuaSet("@shop")
	self._commonDialog_cnt_page:addChild(shopSet[1])
	table.insert(self.pageList, shopSet)

	local rankSet = self:createLuaSet("@rank")
	self._commonDialog_cnt_page:addChild(rankSet[1])
	table.insert(self.pageList, rankSet)
end

function DRedPaper:updateLayer( ... )
	for i,v in ipairs(self.pageList) do
		v[1]:setVisible(i == self.tabIndexSelected)
	end

	if self.tabIndexSelected == tabList.TabMain then
		self._commonDialog_title_text:setString(res.locString("RedPaper$IntrTitle"))
		self:updateLayerMain()
	elseif self.tabIndexSelected == tabList.TabExchange then
		self._commonDialog_title_text:setString(res.locString("RedPaper$ExchangeTitle"))
		self:updateLayerShop()
	elseif self.tabIndexSelected == tabList.TabRank then
		self._commonDialog_title_text:setString(res.locString("RedPaper$RankTitle"))
		self:updateLayerRank()
	end
	self:updateTabNameColor()
end

function DRedPaper:updateTabNameColor( ... )
	local tabNameList = {
		self._commonDialog_tab_tabMain_title,
		self._commonDialog_tab_tabExchange_title,
		self._commonDialog_tab_tabRank_title,
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

function DRedPaper:updateLayerMain( ... )
	local set = self.pageList[tabList.TabMain]
	local summary = redPaper.getMySummary()
	set["bg1_layoutScore_v"]:setString(summary.Score)

	set["bg1_layoutPaper1_v"]:setString( tostring(summary.NormalLimit - summary.NormalCnt) .. res.locString("Global$Ge") )
	set["bg1_layoutPaper2_v"]:setString( tostring(summary.BigLimit - summary.BigCnt) .. res.locString("Global$Ge") )
	set["bg1_layoutPaper3_v"]:setString( tostring(summary.SuperLimit - summary.SuperCnt) .. res.locString("Global$Ge") )
	set["bg1_btnSend"]:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
		GleeCore:showLayer("DRecharge")
	end)

	if not self.listGet then
		self.listGet = LuaList.new(self.pageList[tabList.TabMain]["list"], function ( ... )
			return self:createLuaSet("@itemGet")
		end, function ( nodeLuaSet, data )
			local name = res.locString(string.format("RedPaper$paper%d", data.Type))
			nodeLuaSet["title"]:setString(name)
			require 'LangAdapter'.fontSize(nodeLuaSet["title"],nil,nil,nil,nil,14)

			nodeLuaSet["layout1_v"]:setString(name)
			nodeLuaSet["layout2_v"]:setString(data.FromName)
			local theDate = os.date("*t", require "TimeManager".getTimestamp(data.GotAt) )
			nodeLuaSet["layout3_k"]:setString(string.format(res.locString("Global$Date"), theDate.month, theDate.day))
			nodeLuaSet["layout3_v"]:setString(string.format(" %02d:%02d", theDate.hour, theDate.min))

			local rewardList = res.getRewardResList(data.Reward)
			local v = rewardList[1]
			local scaleOrigal = 85 / 155
			nodeLuaSet["icon2"]:setResid(v.icon)
			if v.type == "Pet" or v.type == "PetPiece" then
				nodeLuaSet["icon2"]:setScale(scaleOrigal * 140 / 95)
			else
				nodeLuaSet["icon2"]:setScale(scaleOrigal)
			end
			nodeLuaSet["count"]:setString(v.count)

			nodeLuaSet["iconFrame"]:setResid(v.frame)
			nodeLuaSet["iconFrame"]:setScale(scaleOrigal)
			nodeLuaSet["piece"]:setVisible(v.isPiece)

			res.addRuneStars( nodeLuaSet["iconFrame"], v )
		end)
	end
	local recordsList = redPaper.getRecords()
	table.sort(recordsList, function ( v1, v2 )
		local t1 = require "TimeManager".getTimestamp(v1.GotAt)
		local t2 = require "TimeManager".getTimestamp(v2.GotAt)
		if t1 and t2 then
			return t1 > t2
		end
	end)
	self.listGet:update(recordsList)

	local timerListManager = require "TimeListManager"
	local seconds = -timerListManager.getTimeUpToNow(redPaper.getEndAt())
	local minute = math.floor(seconds / 60)
	set["r_layout_time"]:setString(string.format(res.locString("RedPaper$ActivityTime2"), minute/60, minute%60))
end

function DRedPaper:updateLayerShop( ... )
	self.pageList[tabList.TabExchange]["layoutSocre_v1"]:setString(redPaper.getMySummary().Score)
	if not self.listShop then
		self.listShop = LuaList.new(self.pageList[tabList.TabExchange]["list"], function (  )
			local sizeSet = self:createLuaSet("@sizeShop")
			sizeSet["setList"] = {}
			for i=1,4 do
				local itemSet = self:createLuaSet("@itemGood")
				sizeSet["layout"]:addChild(itemSet[1])
				table.insert(sizeSet["setList"], itemSet)
			end
			return sizeSet
		end, function ( nodeLuaSet, dataList )
			local itemSetList = nodeLuaSet["setList"]
			for i,item in ipairs(itemSetList) do
				item[1]:setVisible(i <= #dataList)
				if i <= #dataList then
					local data = dataList[i]
					local info = data.info
					local rewardList = res.getRewardResList(info.Reward)
					local v = rewardList[1]
					local scaleOrigal = 124 / 155
					item["icon"]:setResid(v.icon)
					if v.type == "Pet" or v.type == "PetPiece" then
						item["icon"]:setScale(scaleOrigal * 140 / 95)
					else
						item["icon"]:setScale(scaleOrigal)
					end

					item["iconFrame"]:setResid(v.frame)
					item["iconFrame"]:setScale(scaleOrigal)
					if v.type == "Gem" then
						item["name"]:setString(v.name .. " Lv." .. v.lv)
					else
						item["name"]:setString(v.name)
					end
					local lastCount = redPaper.getExRecordWithId(info.Id)
					item["count"]:setString( string.format(res.locString("Global$Last"), lastCount) )
					if lastCount == 0 then
						item["count"]:setFontFillColor(res.color4F.red, true)
					else
						item["count"]:setFontFillColor(res.color4F.white, true)
					end	

					item["piece"]:setVisible(v.isPiece)
					item["layoutPrice_v2"]:setString(info.Score)
					item["btnDetail"]:setListener(function ( ... )
						if v.eventData then
							GleeCore:showLayer(v.eventData.dialog, v.eventData.data)
						end
					end)
					item["btnBuy"]:setEnabled(redPaper.getMySummary().Score >= info.Score and lastCount > 0)
					item["btnBuy"]:setListener(function ( ... )
						if redPaper.getMySummary().Score >= info.Score then
							local function HBExchange( amt, closeBuyLayer )
								self:send(netModel.getModelHongbaoExchange(info.Id, amt), function ( data )
									if data and data.D then
			   							if closeBuyLayer then
			   								closeBuyLayer()
			   							end

										redPaper.setMySummary(data.D.Summary)
			   							redPaper.setRecordsEx(data.D.Records)
			   							gameFunc.updateResource(data.D.Resource)
			   							self:updateLayerShop()
			   							res.doActionGetReward(data.D.Reward)
									end
								end)
							end

							if lastCount == 1 or redPaper.getMySummary().Score < info.Score * 2 then
								HBExchange(1)
							else
								local param = {}
								param.itemType = "RewardType"
								param.costIcon = "N_HB_jifen.png"
								param.hbReward = v
								param.hbPrice = info.Score
								param.hbAmtLimit = math.min( math.floor(redPaper.getMySummary().Score / info.Score), lastCount )
								param.callback = function ( data )
									HBExchange(data.amt, data.closeBuyLayer)
								end
								GleeCore:showLayer("DMallItemBuy", param)	
							end
						else
							self:toast(res.locString("RedPaper$ScoreNotEnough"))
						end
					end)

					res.addRuneStars( item["iconFrame"], v )
				end
			end
		end)
	end

	if redPaper.getItems() ~= nil then
		self.listShop:update(self:getExchangeDataList())
	else
		self:send(netModel.getModelHongbaoExInfo(), function ( data )
			print("HongbaoExInfo")
			print(data)
			if data and data.D then
	   			redPaper.setMySummary(data.D.Summary)
	   			redPaper.setRecordsEx(data.D.Records)
	   			redPaper.setItems(data.D.Items)
	   			self.listShop:update(self:getExchangeDataList())
			end
		end)
	end
end

function DRedPaper:updateLayerRank( ... )
	if not self.listRank then
		self.listRank = LuaList.new(self.pageList[tabList.TabRank]["list"], function ( ... )
			return self:createLuaSet("@itemRank")
		end, function ( nodeLuaSet, data )
			nodeLuaSet["icon"]:setResid(string.format('paiming_tubiao%d.png', data.Rank))
			nodeLuaSet["icon"]:setVisible(data.Rank >= 1 and data.Rank <= 3)
			nodeLuaSet["rank"]:setString(string.format("No.%d", data.Rank))
			nodeLuaSet["name2"]:setString(dbManager.getHongbaoTitleWithRank(data.Rank))
			nodeLuaSet["name1"]:setString(data.Name)
			nodeLuaSet["paper"]:setString(data.RankScore)
			nodeLuaSet["btn"]:setListener(function ( ... )
				if data.Rid ~= gameFunc.getUserInfo().getId() then
					self:send(netModel.getModelFriendSearch(data.Name), function ( data )
						print(data)
						if data.D and data.D.Friend then
							return GleeCore:showLayer("DFriendInfo", data.D.Friend)
						else
							return self:toast(res.locString("Friend$findNone"))
						end
					end)
				end
			end)
		end)
	end

	-- if redPaper.getRankList() ~= nil then
	-- 	self.listRank:update(redPaper.getRankList())
	-- else
		self:send(netModel.getModelHongbaoRankGet(), function ( data )
			print("HongbaoRankGet")
			print(data)
			if data and data.D then
				redPaper.setRankList(data.D.Ranks)
				self.listRank:update(redPaper.getRankList())
			end
		end)
	-- end
end

function DRedPaper:getExchangeDataList( ... )
	local list = {}
	local items = redPaper.getItems()
	local records = redPaper.getRecordsEx()
	if items ~= nil and records ~= nil and #items >= #records then
		for i=1,#items do
			table.insert(list, {info = items[i], record = records[i]})
		end
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

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DRedPaper, "DRedPaper")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DRedPaper", DRedPaper)


