local Config = require "Config"
local dbManager = require "DBManager"
local res = require "Res"
local gameFunc = require "AppData"
local LuaList = require "LuaList"
local netModel = require "netModel"
local userFunc = gameFunc.getUserInfo()
local timeLimitExploreFunc = gameFunc.getTimeLimitExploreInfo()
local petFunc = gameFunc.getPetInfo()
local EventCenter = require "EventCenter"

local DTimeLimitExploreMain = class(LuaDialog)

function DTimeLimitExploreMain:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DTimeLimitExploreMain.cocos.zip")
    return self._factory:createDocument("DTimeLimitExploreMain.cocos")
end

--@@@@[[[[
function DTimeLimitExploreMain:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_bg_ticket = set:getLabelNode("commonDialog_cnt_bg_ticket")
    self._commonDialog_cnt_bg_stone = set:getLabelNode("commonDialog_cnt_bg_stone")
    self._commonDialog_cnt_bg_timer = set:getTimeNode("commonDialog_cnt_bg_timer")
    self._commonDialog_cnt_bg_stageList = set:getListNode("commonDialog_cnt_bg_stageList")
    self._icon = set:getElfNode("icon")
    self._star1 = set:getElfNode("star1")
    self._star2 = set:getElfNode("star2")
    self._star3 = set:getElfNode("star3")
    self._name = set:getLabelNode("name")
    self._index = set:getElfNode("index")
    self._index_num = set:getLabelNode("index_num")
    self._clear = set:getElfNode("clear")
    self._btn = set:getButtonNode("btn")
    self._bg = set:getElfNode("bg")
    self._commonDialog_cnt_bg_clip_layoutItems = set:getLayoutNode("commonDialog_cnt_bg_clip_layoutItems")
    self._bg = set:getElfNode("bg")
    self._piece = set:getElfNode("piece")
    self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
    self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
--    self._@stage = set:getElfNode("@stage")
--    self._@arrow = set:getElfNode("@arrow")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DTimeLimitExploreMain:onInit( userData, netData )
	self:broadcastEvent()
	self:setListenerEvent()
	self:updateLayer()
	res.doActionDialogShow(self._commonDialog)

	require "LangAdapter".LabelNodeAutoShrink(self._set:getLabelNode("commonDialog_cnt_bg_#des"), 538)
end

function DTimeLimitExploreMain:onBack( userData, netData )
	
end

function DTimeLimitExploreMain:close(  )
	EventCenter.resetGroup("DTimeLimitExploreMain")
end

--------------------------------custom code-----------------------------

function DTimeLimitExploreMain:broadcastEvent( ... )
	EventCenter.addEventFunc("UpdateTimeLimitExploreCountDown", function ( ... )
		self:updateLayer()
	end, "DTimeLimitExploreMain")
end

function DTimeLimitExploreMain:setListenerEvent( ... )
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)
	
	self._commonDialog_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)
end

function DTimeLimitExploreMain:updateLayer( ... )
	local exploreInfo = timeLimitExploreFunc.getExplore()
	local maxTicketNum = dbManager.getInfoDefaultConfig("TicketNum").Value
	self._commonDialog_cnt_bg_ticket:setString(string.format("%d/%d", exploreInfo.Tickets, maxTicketNum))
	self._commonDialog_cnt_bg_stone:setString(exploreInfo.Score)
	local seconds = -math.floor(require "TimeListManager".getTimeUpToNow(exploreInfo.RecoverTime))
	seconds = math.max(seconds, 0)
	seconds = math.min(seconds, 3600)
	if exploreInfo.Tickets < maxTicketNum and seconds > 0 then
		seconds = seconds + 1
		local date = self._commonDialog_cnt_bg_timer:getElfDate()
		date:setHourMinuteSecond(0, 0, seconds)
		self._commonDialog_cnt_bg_timer:setVisible(true)
		self._commonDialog_cnt_bg_timer:setUpdateRate(-1)
		self._commonDialog_cnt_bg_timer:addListener(function (  )
			if exploreInfo.Tickets == maxTicketNum then
				self._commonDialog_cnt_bg_timer:setUpdateRate(0)
				self._commonDialog_cnt_bg_timer:setVisible(false)
			else
				date:setHourMinuteSecond(0, 0, 3600)
			end
		end)
	else
		self._commonDialog_cnt_bg_timer:setUpdateRate(0)
		self._commonDialog_cnt_bg_timer:setVisible(false)
	end	

	self:updateStageList()
	self:updateDrop()
end

function DTimeLimitExploreMain:updateStageList( ... )
	local list = self:getStageListData()
	local container = self._commonDialog_cnt_bg_stageList:getContainer()
	container:removeAllChildrenWithCleanup(true)
	for i,v in ipairs(list) do
		local stage = self:createLuaSet("@stage")
		container:addChild(stage[1])
		if not v.isLast then
			local arrow = self:createLuaSet("@arrow")
			container:addChild(arrow[1])
		end

		stage["icon"]:setVisible(v.petId > 0)
		if v.petId > 0 then
			res.setNodeWithPet(stage["icon"], petFunc.getPetInfoByPetId(v.petId))
		end
		for i=1,3 do
			stage[string.format("star%d", i)]:setResid(i <= v.stars and "TX_xing1.png" or "TX_xing2.png")
		end
		stage["clear"]:setVisible(v.clear)
		stage["index_num"]:setString(v.stageId)
		stage["name"]:setString(v.name)
		if not v.isLock then
			stage["name"]:setFontFillColor(ccc4f(0,0,0,1), true)
		else
			stage["name"]:setFontFillColor(ccc4f(0.976,0.18,0.1255,1.0), true)
		end
		stage["btn"]:setEnabled(not v.isLock)
		stage["btn"]:setListener(function ( ... )
			local exploreInfo = timeLimitExploreFunc.getExplore()
			if exploreInfo.Tickets > 0 then
				if v.clear then
					local function battleSpeedSingle( amt, closeBuyLayer )
						self:send(netModel.getModelTimeCopySettle(v.stageId, 3, amt), function ( data )
							if data and data.D then
	   							if closeBuyLayer then
	   								closeBuyLayer()
	   							end

								timeLimitExploreFunc.setTimeCopyStageList(data.D.Stages)
								timeLimitExploreFunc.setExplore(data.D.TimeCopy)
								gameFunc.updateResource(data.D.Resource)
								self:updateLayer()
								data.D.Reward.ExploreStone = data.D.Score
								res.doActionGetReward(data.D.Reward)
								EventCenter.eventInput("UpdateTimeLimitExplore")
								self:toast(res.locString("Activity$TimeLimitExploreBattleSpeedSuc"))
							end
						end)
					end

					if exploreInfo.Tickets == 1 then
						battleSpeedSingle(1)
					else
						local param = {}
						param.itemType = "TimeLimitExploreStageBattleSpeed"
						param.nStage = v
						param.hbPrice = 1
						param.hbAmtLimit = exploreInfo.Tickets
						param.callback = function ( data )
							battleSpeedSingle(data.amt, data.closeBuyLayer)
						end
						GleeCore:showLayer("DMallItemBuy", param)
					end
				else
					local param = {}
					param.type = "limit_fuben"
					param.stageId = v.stageId
					GleeCore:showLayer("DPrepareForStageBattle", param)			
				end
			else
				local cost = dbManager.getInfoDefaultConfig("TLAdvBuyCost").Value
				local param = {}
				param.content = string.format(res.locString("Activity$TimeLimitExploreBuyTicket"), cost)
				param.callback = function ( ... )
					if gameFunc.getUserInfo().getCoin() >= cost then
						self:send(netModel.getModelTimeCopyTicketBuy(), function ( data )
							if data and data.D then
								timeLimitExploreFunc.setExplore(data.D.TimeCopy)
								gameFunc.getUserInfo().setData(data.D.Role)
								self:updateLayer()
								EventCenter.eventInput("UpdateTimeLimitExplore")
							end
						end)
					else
						require "Toolkit".showDialogOnCoinNotEnough()
					end
				end
				GleeCore:showLayer("DConfirmNT", param)
			end
		end)

		require "LangAdapter".LabelNodeAutoShrink(stage["name"], 191)
	end
end

function DTimeLimitExploreMain:getStageListData( ... )
	local result = {}
	local exploreData = gameFunc.getActivityInfo().getDataByType(42)
	if exploreData and exploreData.Data.StageCfgs then
		local curStageIndex
		for i,v in ipairs(exploreData.Data.StageCfgs) do
			local temp = {}
			temp.stageId = v.StageId
			temp.name = v.StageName
			temp.isLast = i == #exploreData.Data.StageCfgs
			local nStage = timeLimitExploreFunc.getNetStageWithStageId(v.StageId)
			if nStage then
				temp.stars = nStage.Stars
				temp.clear = nStage.Stars >= 3
				if temp.stars > 0 then
					temp.isLock = false
				else
					if not curStageIndex then
						temp.isLock = false
						curStageIndex = i
					else
						temp.isLock = true
					end
				end
				temp.petId = v.PetIdList and #v.PetIdList > 0 and v.PetIdList[1] or 0
				temp.petId = temp.isLock and 0 or temp.petId
			end
			table.insert(result, temp)
		end
	end
	return result
end

function DTimeLimitExploreMain:updateDrop( ... )
	self._commonDialog_cnt_bg_clip_layoutItems:removeAllChildrenWithCleanup(true)

	local item = self:createLuaSet("@item")
	self._commonDialog_cnt_bg_clip_layoutItems:addChild(item[1])
	res.setNodeWithCoin( item["bg"] )
	item["piece"]:setVisible(false)

	item = self:createLuaSet("@item")
	self._commonDialog_cnt_bg_clip_layoutItems:addChild(item[1])
	res.setNodeWithExploreStone( item["bg"] )
	item["piece"]:setVisible(false)

	local exploreData = gameFunc.getActivityInfo().getDataByType(42)

	item = self:createLuaSet("@item")
	self._commonDialog_cnt_bg_clip_layoutItems:addChild(item[1])
	res.setNodeWithPet(item["bg"], petFunc.getPetInfoByPetId(exploreData.Data.PetId1))

	item = self:createLuaSet("@item")
	self._commonDialog_cnt_bg_clip_layoutItems:addChild(item[1])
	res.setNodeWithPet(item["bg"], petFunc.getPetInfoByPetId(exploreData.Data.PetId2))

	for i=1,3 do
		item = self:createLuaSet("@item")
		self._commonDialog_cnt_bg_clip_layoutItems:addChild(item[1])
		item["bg"]:setResid("TX_diaoluo.png")
		item["piece"]:setVisible(false)
		item[1]:setScale(155/91)
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DTimeLimitExploreMain, "DTimeLimitExploreMain")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DTimeLimitExploreMain", DTimeLimitExploreMain)


