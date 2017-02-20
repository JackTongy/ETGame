local Config = require "Config"
local res = require "Res"
local TimerHelper = require "framework.sync.TimerHelper"
local dbManager = require "DBManager"
local netModel = require "netModel"
local gameFunc = require "AppData"
local PetInfo = require "PetInfo"
local BagInfo = require "BagInfo"
local PlaygroundInfo = require "PlaygroundInfo"
local TimeManager = require "TimeManager"
local EventCenter = require "EventCenter"

local playgroundMid = 126
local TotalTime = 50
local ActionTime = 0.2
local StartCount = 5
local GameStatus ={
	Ready = 1,
	Play = 2,
	GameOver = 3,
}

local CPlayground = class(LuaController)

function CPlayground:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."CPlayground.cocos.zip")
    return self._factory:createDocument("CPlayground.cocos")
end

--@@@@[[[[
function CPlayground:onInitXML()
    local set = self._set
   self._bg = set:getElfNode("bg")
   self._bg_layoutX = set:getLayoutNode("bg_layoutX")
   self._icon = set:getElfNode("icon")
   self._btn = set:getButtonNode("btn")
   self._bg_layoutTime = set:getLinearLayoutNode("bg_layoutTime")
   self._bg_StartLayer = set:getButtonNode("bg_StartLayer")
   self._bg_StartLayer_countDown = set:getElfNode("bg_StartLayer_countDown")
   self._bg_resultLayer = set:getButtonNode("bg_resultLayer")
   self._bg_resultLayer_rect = set:getRectangleNode("bg_resultLayer_rect")
   self._bg_resultLayer_title = set:getElfNode("bg_resultLayer_title")
   self._bg_resultLayer_text = set:getLabelNode("bg_resultLayer_text")
   self._bg_resultLayer_btnAgain = set:getClickNode("bg_resultLayer_btnAgain")
   self._bg_resultLayer_btnClose = set:getClickNode("bg_resultLayer_btnClose")
--   self._<FULL_NAME1> = set:getLayoutNode("@layoutY")
--   self._<FULL_NAME1> = set:getElfNode("@itemGrid")
--   self._<FULL_NAME1> = set:getElfNode("@num")
--   self._<FULL_NAME1> = set:getElfNode("@second")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("CPlayground", function ( userData )
	local ticketCount = gameFunc.getBagInfo().getItemCount(playgroundMid)
	if ticketCount > 0 then
		GleeCore:closeAllLayers()
		Launcher.Launching()
	else
		GleeCore:toast(res.locString("Activity$PlaygroundTicketNotEnough"))
	end
end)

function CPlayground:onInit( userData, netData )
	self._bg_resultLayer_btnAgain:setListener(function ( ... )
		local ticketCount = gameFunc.getBagInfo().getItemCount(playgroundMid)
		if ticketCount > 0 then
			self:init()
			self:updateLayer()
		else
			GleeCore:toast(res.locString("Activity$PlaygroundTicketNotEnough"))
			GleeCore:popController(nil, res.getTransitionFade())
			GleeCore:showLayer("DActivity", {ShowActivity = require 'ActivityType'.Playground})
		end
	end)

	self._bg_resultLayer_btnClose:setListener(function ( ... )
		GleeCore:popController(nil, res.getTransitionFade())
		GleeCore:showLayer("DActivity", {ShowActivity = require 'ActivityType'.Playground})
	end)

	self:init()
	self:updateLayer()

	EventCenter.addEventFunc("OnAppStatChange", function ( state )
		if state == 2 then
			if self.GameStatus == GameStatus.Play then
				local theTime = (TimeManager.getCurrentSeverTime() - self.LastPlayTime) / 1000
				self.nowTime = TotalTime - theTime 
				self.nowTime = math.max(self.nowTime, 0)
			end
		end
	end, "CPlayground")
end

function CPlayground:onBack( userData, netData )
	
end

function CPlayground:onRelease( ... )
	EventCenter.resetGroup("CPlayground")
end

--------------------------------custom code-----------------------------

function CPlayground:init( ... )
	self.LastIdx = nil
	self.GameStatus = GameStatus.Ready
	self.nowTime = TotalTime
	self:initTime()
	self:updateTime()
	self:initGrids()
end

function CPlayground:initTime( ... )
	self._bg_layoutTime:removeAllChildrenWithCleanup(true)
	self.TimeNodeList = {}

	local num = self:createLuaSet("@num")
	self._bg_layoutTime:addChild(num[1])
	self.TimeNodeList[1] = num

	num = self:createLuaSet("@num")
	self._bg_layoutTime:addChild(num[1])
	self.TimeNodeList[2] = num

	local second = self:createLuaSet("@second")
	self._bg_layoutTime:addChild(second[1])
	self.TimeNodeList[3] = second
end

function CPlayground:initGrids( ... )
	local RealData = self:getRealData()
	self.GridList = {}
	self._bg_layoutX:removeAllChildrenWithCleanup(true)
	for i=1,4 do
		local layoutY = self:createLuaSet("@layoutY")
		self._bg_layoutX:addChild(layoutY[1])
		for j=1,4 do
			local itemGrid = self:createLuaSet("@itemGrid")
			layoutY[1]:addChild(itemGrid[1])
			table.insert(self.GridList, itemGrid)

			local idx = (i - 1) * 4 + j
			itemGrid["Data"] = RealData[idx]
			self:updateCell(idx)
			itemGrid["btn"]:setListener(function ( ... )
				-- print("self.LastIdx = ")
				-- print(self.LastIdx)
				-- print("idx = " .. idx)
				-- print("RealData[idx].isFront = " .. tostring(RealData[idx].isFront))
				if self.LastIdx then
					if self.LastIdx ~= idx then
						if self:isEquipGrids(self.LastIdx, idx) then
							self.LastIdx = nil
							self:runActionReverseCell(idx)
						else
							if not RealData[idx].isFront then
								self:runActionReverseCell(idx, function ( ... )
									self:runActionReverseCell(self.LastIdx)
									self.LastIdx = nil
									self:runActionReverseCell(idx)
								end)
							end
						end
					else
						self.LastIdx = nil
						self:runActionReverseCell(idx)
					end
				else
					if not RealData[idx].isFront then
						self.LastIdx = idx
						self:runActionReverseCell(idx)
					end
				end
			end)
		end
	end
end

function CPlayground:updateLayer( ... )
	self._bg_StartLayer:setVisible(self.GameStatus == GameStatus.Ready)
	self._bg_resultLayer:setVisible(false)
	if self.GameStatus == GameStatus.Ready then
		self:reStart()
	elseif self.GameStatus == GameStatus.Play then
		self:startGameNow()
	elseif self.GameStatus == GameStatus.GameOver then
		self:updateResultLayer()
	end
end

function CPlayground:reStart( ... )
	print("Playground Game Start")
	local countDowm = StartCount
	self._bg_StartLayer_countDown:setResid(string.format("JLYLY_shuzi2_%d.png", countDowm))
	TimerHelper.tick(function ( dt )
		countDowm = countDowm - 1
		if countDowm > 0 then
			self._bg_StartLayer_countDown:setResid(string.format("JLYLY_shuzi2_%d.png", countDowm))
			return false
		else
			print("Playground Game Play")
			self.GameStatus = GameStatus.Play
			self:updateLayer()
			return true
		end
	end, 1)
end

function CPlayground:startGameNow( ... )
	local function start( ... )
		self.LastPlayTime = TimeManager.getCurrentSeverTime()
		self.GameTimeHandle = TimerHelper.tick(function ( dt )
			self.nowTime = self.nowTime - math.floor(dt)
			self.nowTime = math.max(self.nowTime, 0)
			if self.nowTime > 0 then
				self:updateTime()
				return false
			else
				self:updateTime()
				self.GameStatus = GameStatus.GameOver
				self:updateLayer()
				return true
			end
		end, 1)
	end

	self:send(netModel.getModelPlaygroundStart(), function ( data )
		if data and data.D then
	 		BagInfo.useItemByID(BagInfo.getItemWithMaterial(playgroundMid).Id, 1)
			start()
	 	end
	end, function ( data )
		if data.Code == 605 then
			self:toast(res.locString("Activity$ActFinishTip"))
			GleeCore:popController(nil, res.getTransitionFade())
			GleeCore:showLayer("DActivity")
		end
	end)
end

function CPlayground:updateTime( ... )
	if self.nowTime > 9 then
		self.TimeNodeList[1][1]:setResid(string.format("JLYLY_shuzi1_%d.png", self.nowTime / 10))
		self.TimeNodeList[2][1]:setResid(string.format("JLYLY_shuzi1_%d.png", self.nowTime % 10))
	elseif self.nowTime >= 0 then
		self.TimeNodeList[1][1]:setResid(nil)
		self.TimeNodeList[2][1]:setResid(string.format("JLYLY_shuzi1_%d.png", self.nowTime))
	end
	self._bg_layoutTime:layout()
end

function CPlayground:updateResultLayer( ... )
	if self.GameTimeHandle then
		TimerHelper.cancel(self.GameTimeHandle)
	end

	local useTime = self:getUseTime()
	self:send(netModel.getModelPlaygroundGo(useTime), function ( data )
		if data and data.D then
			PlaygroundInfo.setPlayground(data.D.Playground)
			self._bg_resultLayer_title:setResid(self.nowTime > 0 and "JLYLY_win.png" or "JLYLY_lose.png")

			if self.nowTime > 0 then
				self._bg_resultLayer_text:setString(string.format(res.locString("Activity$PlaygroundUseTime"), useTime) .. string.format(res.locString("Activity$PlaygroundScoreAdd"), self:getScore()))
			else
				self._bg_resultLayer_text:setString(string.format(res.locString("Activity$PlaygroundScoreAdd"), self:getScore()))
			end

			self._bg_resultLayer:setVisible(true)
		end
	end, function ( data )
		if data.Code == 605 then
			self:toast(res.locString("Activity$ActFinishTip"))
			GleeCore:popController(nil, res.getTransitionFade())
			GleeCore:showLayer("DActivity")
		end
	end)
end

function CPlayground:getOrigalData( ... )
	local result = {}
	local list = dbManager.getChristmasgameConfig()
	for i,v in ipairs(list) do
		result[v.type] = result[v.type] or {}
		table.insert(result[v.type], v)
	end
	return result
end

function CPlayground:getRealData( ... )
	local result = {}
	local OrigalLsit = self:getOrigalData()
	local random = math.random(100)
	if random <= 30 then
		result = self:getAnyDataWithType(OrigalLsit[3], 8)
	elseif random <= 55 then
		local rand2 = math.random(100)
		if rand2 <= 70 then
			result = self:getAnyDataWithType(OrigalLsit[2], 1)
			table.insertTo(result, self:getAnyDataWithType(OrigalLsit[3], 7))
		else
			result = self:getAnyDataWithType(OrigalLsit[2], 2)
			table.insertTo(result, self:getAnyDataWithType(OrigalLsit[3], 6))
		end
	elseif random <= 85 then
		result = self:getAnyDataWithType(OrigalLsit[1], 1)
		for i,v in ipairs(OrigalLsit[1]) do
			if v.StarID == result[1].StarID and v.pet_id1 ~= result[1].pet_id1 then
				table.insert(result, v)
				break
			end
		end
		table.insertTo(result, self:getAnyDataWithType(OrigalLsit[3], 6))
	else
		result = self:getAnyDataWithType(OrigalLsit[1], 1)
		for i,v in ipairs(OrigalLsit[1]) do
			if v.StarID == result[1].StarID and v.pet_id1 ~= result[1].pet_id1 then
				table.insert(result, v)
				break
			end
		end
		table.insertTo(result, self:getAnyDataWithType(OrigalLsit[2], 1))
		table.insertTo(result, self:getAnyDataWithType(OrigalLsit[3], 5))
	end
	local randList = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}
	local temp = {}
	for i,v in ipairs(result) do
		local Pos = math.random(#randList)
		table.insert(temp, {PetId = v.pet_id1, Name = v.name1, Idx = i, isFront = false, Pos = randList[Pos]})
		table.remove(randList, Pos)
		Pos = math.random(#randList)
		table.insert(temp, {PetId = v.pet_id2, Name = v.name2, Idx = i, isFront = false, Pos = randList[Pos]})
		table.remove(randList, Pos)
	end
	table.sort(temp, function ( v1, v2 )
		return v1.Pos < v2.Pos
	end)
	print("CPlayground:getRealData ====== ")
	print(temp)
	return temp
end

function CPlayground:getAnyDataWithType( List, Count )
	if List and Count > 0 and Count <= #List then
		local copyList = table.clone(List)
		local result = {}
		while true do
			if #result < Count then
				local idx = math.random(#copyList)
				table.insert(result, copyList[idx])
				table.remove(copyList, idx)
			else
				break
			end
		end
		return result
	end
end

function CPlayground:getUseTime( ... )
	local useTime = math.max(TotalTime - self.nowTime, 0)
	if useTime == TotalTime then
		useTime = TotalTime + 1
	end
	return useTime
end

function CPlayground:getScore( ... )
	local useTime = self:getUseTime()
	local PlaygroundConfig = require "PlaygroundConfig"
	table.sort(PlaygroundConfig, function ( v1,v2 )
		return v1.Sec1 > v2.Sec1
	end)
	for i,v in ipairs(PlaygroundConfig) do
		if useTime >= v.Sec1 then
			return v.Score
		end
	end
	return 0
end

function CPlayground:runActionReverseCell( idx, callback )
	local actArray = CCArray:create()

	actArray:addObject(CCCallFunc:create(function (  )
		res.setTouchDispatchEvents(false)
	end))

	actArray:addObject(CCScaleTo:create(ActionTime * 0.5, 0, 1))
	actArray:addObject(CCCallFunc:create(function (  )
		local set = self.GridList[idx]
		set["Data"].isFront = not set["Data"].isFront
		self:updateCell(idx)
	end))
	actArray:addObject(CCScaleTo:create(ActionTime * 0.5, 1, 1))

	if callback then
		actArray:addObject(CCDelayTime:create(0.5))
		actArray:addObject(CCCallFunc:create(function (  )
			if callback then
				callback()
			end
		end))
	end
	
	actArray:addObject(CCCallFunc:create(function (  )
		res.setTouchDispatchEvents(true)
		if self:isAllGridsFront() then
			self.GameStatus = GameStatus.GameOver
			self:updateLayer()
		end
	end))

	local set = self.GridList[idx]
	set[1]:runAction(CCSequence:create(actArray))
end

function CPlayground:updateCell( idx )
	local set = self.GridList[idx]
	set["icon"]:removeAllChildrenWithCleanup(true)
	if set["Data"].isFront then
		local nPet = PetInfo.getPetInfoByPetId(set["Data"].PetId)

		local icon = ElfNode:create()
		icon:setResid(res.getPetIcon(nPet.PetId))
		icon:setScale(85 / 95)
		set["icon"]:addChild(icon)

		local frame = ElfNode:create()
		frame:setResid("JLYLY_kp2.png")
		set["icon"]:addChild(frame)
	else
		set["icon"]:setResid("JLYLY_kp1.png")
	end
end

function CPlayground:isEquipGrids( leftIdx, rightIdx )
	return self.GridList[leftIdx]["Data"].Idx == self.GridList[rightIdx]["Data"].Idx
end

function CPlayground:isAllGridsFront( ... )
	for i,v in ipairs(self.GridList) do
		if not v["Data"].isFront then
			return false
		end
	end
	return true
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(CPlayground, "CPlayground")


--------------------------------register--------------------------------
GleeCore:registerLuaController("CPlayground", CPlayground)
