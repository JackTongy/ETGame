local Config = require "Config"
local res = require "Res"
local ActivityType = require "ActivityType"
local dbManager = require "DBManager"
local gameFunc = require "AppData"
local netModel = require "netModel"
local EventCenter = require "EventCenter"
local userFunc = gameFunc.getUserInfo()
local Card21Info = gameFunc.getCard21Info()

local CCard21 = class(LuaController)

function CCard21:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."CCard21.cocos.zip")
    return self._factory:createDocument("CCard21.cocos")
end

--@@@@[[[[
function CCard21:onInitXML()
	local set = self._set
    self._bg = set:getElfNode("bg")
    self._bg_system = set:getLabelNode("bg_system")
    self._bg_player = set:getLabelNode("bg_player")
    self._bg_myChip = set:getLabelNode("bg_myChip")
    self._bg_btnAdd = set:getButtonNode("bg_btnAdd")
    self._bg_pool = set:getLabelNode("bg_pool")
    self._bg_layoutSystemCard = set:getLayoutNode("bg_layoutSystemCard")
    self._bg = set:getElfNode("bg")
    self._clip_icon = set:getElfNode("clip_icon")
    self._frame = set:getElfNode("frame")
    self._dx1 = set:getElfNode("dx1")
    self._hs1 = set:getElfNode("hs1")
    self._dx2 = set:getElfNode("dx2")
    self._hs2 = set:getElfNode("hs2")
    self._bg_layoutMyCard = set:getLayoutNode("bg_layoutMyCard")
    self._bg = set:getElfNode("bg")
    self._clip_icon = set:getElfNode("clip_icon")
    self._frame = set:getElfNode("frame")
    self._dx1 = set:getElfNode("dx1")
    self._hs1 = set:getElfNode("hs1")
    self._dx2 = set:getElfNode("dx2")
    self._hs2 = set:getElfNode("hs2")
    self._bg_pointBaseSys = set:getElfNode("bg_pointBaseSys")
    self._layoutPointBg = set:getLinearLayoutNode("layoutPointBg")
    self._layoutPointBg_s = set:getElfNode("layoutPointBg_s")
    self._num = set:getLabelNode("num")
    self._layoutPointBg = set:getLinearLayoutNode("layoutPointBg")
    self._layoutPointBg_s = set:getElfNode("layoutPointBg_s")
    self._num = set:getLabelNode("num")
    self._bg_pointBasePlayer = set:getElfNode("bg_pointBasePlayer")
    self._bg_cardsPlace = set:getElfNode("bg_cardsPlace")
    self._bg_gameOverBase = set:getElfNode("bg_gameOverBase")
    self._bg_btnHit = set:getClickNode("bg_btnHit")
    self._bg_btnStand = set:getClickNode("bg_btnStand")
    self._bg_btnBet = set:getClickNode("bg_btnBet")
    self._bg_btnClose = set:getButtonNode("bg_btnClose")
    self._title = set:getLabelNode("title")
--    self._@cardBack = set:getElfNode("@cardBack")
--    self._@card = set:getElfNode("@card")
--    self._@card = set:getElfNode("@card")
--    self._@Point1 = set:getElfNode("@Point1")
--    self._@Point2 = set:getElfNode("@Point2")
--    self._@cardBack = set:getElfNode("@cardBack")
--    self._@win = set:getElfNode("@win")
--    self._@lose = set:getElfNode("@lose")
--    self._@btnSheildBg = set:getButtonNode("@btnSheildBg")
--    self._@btnBetAgain = set:getClickNode("@btnBetAgain")
--    self._@btnAgain = set:getClickNode("@btnAgain")
--    self._@finishTip = set:getRichLabelNode("@finishTip")
--    self._@winChipText = set:getLabelNode("@winChipText")
--    self._@btnGameOver = set:getButtonNode("@btnGameOver")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("CCard21", function ( userData )
	if Card21Info.getCard21().Bet > 0 or Card21Info.getCard21().Score >= dbManager.getInfoDefaultConfig("21pointCost1").Value then
		GleeCore:closeAllLayers()
		Launcher.Launching()
	else
		GleeCore:toast(res.locString("Card21$chipNotEnough"))
	end
end)

function CCard21:onInit( userData, netData )
	self:setListenerEvent()
	self:broadcastEvent()
	self:updateLayer()

	if Card21Info.getCard21().Bet == 0 then
		self:runWithDelay(function ( ... )
			GleeCore:showLayer("DCard21Bet")
		end, 0.5)
	end
end

function CCard21:onBack( userData, netData )
	
end

function CCard21:onRelease( ... )
	EventCenter.resetGroup("CCard21")
end

--------------------------------custom code-----------------------------

function CCard21:setListenerEvent( ... )
	self._bg_btnClose:setListener(function (  )
		GleeCore:popController(nil, res.getTransitionFade())
		GleeCore:showLayer("DActivity", {ShowActivity = ActivityType.Card21})
	end)

	self._bg_btnHit:setListener(function ( ... )
		self:send(netModel.getModelCard21Hit(), function ( data )
			if data and data.D then
				local theScore = 0
				if data.D.State > 0 then
					theScore = data.D.Score
				elseif data.D.State < 0 then
					theScore = Card21Info.getCard21().Bet
				end

				local newCardInfo = self:getSignleCardId(data.D.Card21.MyCards)
				Card21Info.setCard21(data.D.Card21)
				self:runCardMove(newCardInfo, function ( ... )
					self:updateLayer()
					if data.D.State ~= 0 then
						self:gameOverEvent(data.D.State > 0, theScore)
					end
				end)
			end
		end)
	end)

	self._bg_btnStand:setListener(function ( ... )
		self:send(netModel.getModelCard21Stand(), function ( data )
			if data and data.D then
				local oldSystemCards, newSystemCards = self:getCardsSystemMoveCards(data.D.Card21.SystemCards)
				local theScore = data.D.Win and data.D.Score or Card21Info.getCard21().Bet

				local oldScore = Card21Info.getCard21().Score
				Card21Info.setCard21(data.D.Card21)
				self.newScore = Card21Info.getCard21().Score
				Card21Info.getCard21().Score = oldScore

				local function gameOver( ... )
					self:updateLayer()
					self:gameOverEvent(data.D.Win, theScore)
				end 
				if #newSystemCards == 0 then
					gameOver()
				else
					self:runCardsSystem(oldSystemCards, newSystemCards, gameOver)			
				end
			end
		end)
	end)

	self._bg_btnBet:setListener(function ( ... )
		GleeCore:showLayer("DCard21Bet")
	end)

	self._bg_btnAdd:setListener(function ( ... )
		GleeCore:showLayer("DCard21ExchangeChip")
	end)
end

function CCard21:broadcastEvent( ... )
	EventCenter.addEventFunc("UpdateCard21CardPlay", function ( ... )
		self:runCardsPlay()
	end, "CCard21")


	EventCenter.addEventFunc("UpdateCard21Chip", function ( ... )
		self._bg_myChip:setString(Card21Info.getCard21().Score)
	end, "CCard21")
end

function CCard21:resetCardsAndBet( ... )
	local card21 = Card21Info.getCard21()
	card21.Bet = 0
	card21.SystemCards = {}
	card21.MyCards = {}
end

function CCard21:updateLayer( ... )
	local card21 = Card21Info.getCard21()
	self._bg_system:setString(res.locString("Card21$Master"))
	self._bg_player:setString(userFunc.getName())
	self._bg_myChip:setString(card21.Score)
	self._bg_pool:setVisible(card21.Bet > 0)
	self._bg_pool:setString(tostring(card21.Bet) .. res.locString("Global$Chip"))

	self._bg_btnHit:setVisible(card21.Bet > 0 and #card21.SystemCards <= 1)
	self._bg_btnStand:setVisible(card21.Bet > 0 and #card21.SystemCards <= 1)
	self._bg_btnBet:setVisible(card21.Bet == 0 and #card21.SystemCards <= 1)

	self:updateTable()
end

function CCard21:updateTable( ... )
	self._bg_layoutMyCard:removeAllChildrenWithCleanup(true)
	for i,v in ipairs(Card21Info.getCard21().MyCards) do
		local cardInfo = dbManager.getCardConfigWithId(v)
		if cardInfo then
			local cardSet = self:createLuaSet("@card")
			self._bg_layoutMyCard:addChild(cardSet[1])
			self:updateCard(cardSet, cardInfo)
		end
	end

	self._bg_layoutSystemCard:removeAllChildrenWithCleanup(true)
	for i,v in ipairs(Card21Info.getCard21().SystemCards) do
		if i == 2 and self.isCardsSystemPlaying then
			local cardBackSet = self:createLuaSet("@cardBack")
			self._bg_layoutSystemCard:addChild(cardBackSet[1])
		else
			local cardInfo = dbManager.getCardConfigWithId(v)
			if cardInfo then
				local cardSet = self:createLuaSet("@card")
				self._bg_layoutSystemCard:addChild(cardSet[1])
				self:updateCard(cardSet, cardInfo)
			end	
		end
	end
	if #Card21Info.getCard21().SystemCards == 1 and not self.isCardsPlaying then
		local cardBackSet = self:createLuaSet("@cardBack")
		self._bg_layoutSystemCard:addChild(cardBackSet[1])
	end

	-- 点数
	self._bg_pointBasePlayer:removeAllChildrenWithCleanup(true)
	local pointList = self:getCardsPointList( Card21Info.getCard21().MyCards )
	if pointList then
		if #pointList == 1 then
			local pointSet = self:createLuaSet("@Point1")
			pointSet["num"]:setString(pointList[1])
			self._bg_pointBasePlayer:addChild(pointSet[1])
		elseif #pointList == 2 then
			local pointSet = self:createLuaSet("@Point2")
			pointSet["num"]:setString(string.format("%d/%d", pointList[1], pointList[2]))
			self._bg_pointBasePlayer:addChild(pointSet[1])
		end
		self._bg_pointBasePlayer:setPosition(ccp(100 + (#Card21Info.getCard21().MyCards - 2) * 12.5, -200))

		self._bg_btnHit:setEnabled( not table.find(pointList, 21) )
	end

	self._bg_pointBaseSys:removeAllChildrenWithCleanup(true)
	pointList = self:getCardsPointList( Card21Info.getCard21().SystemCards, self.isCardsSystemPlaying )
	if pointList then
		if #pointList == 1 then
			local pointSet = self:createLuaSet("@Point1")
			pointSet["num"]:setString(pointList[1])
			self._bg_pointBaseSys:addChild(pointSet[1])
		elseif #pointList == 2 then
			local pointSet = self:createLuaSet("@Point2")
			pointSet["num"]:setString(string.format("%d/%d", pointList[1], pointList[2]))
			self._bg_pointBaseSys:addChild(pointSet[1])
		end
		self._bg_pointBaseSys:setPosition(ccp(100 + (math.max(#Card21Info.getCard21().SystemCards, 2) - 2) * 12.5, 150))
	end
end

function CCard21:updateCard( set, cardInfo )
	set["clip_icon"]:setResid(string.format("role_%03d.png", cardInfo.petid))
	res.adjustPetIconPositionInParentLT(set["bg"], set["clip_icon"], cardInfo.petid,'puke')
	
	set["hs1"]:setResid(string.format("huase%d.png", cardInfo.Class))
	set["hs2"]:setResid(string.format("huase%d.png", cardInfo.Class))
	if math.fmod(cardInfo.Class, 2) == 1 then
		set["dx1"]:setResid(string.format("hei_%d.png", cardInfo.Face))
		set["dx2"]:setResid(string.format("hei_%d.png", cardInfo.Face))
	else
		set["dx1"]:setResid(string.format("hong_%d.png", cardInfo.Face))
		set["dx2"]:setResid(string.format("hong_%d.png", cardInfo.Face))
	end
end

function CCard21:getCardsPointList( cards, isSystemCardPlaying )
	local count = 0
	local countA = 0
	for i,v in ipairs(cards) do
		if not (isSystemCardPlaying and i == 2) then
			local cardInfo = dbManager.getCardConfigWithId(v)
			if cardInfo then
				count = count + cardInfo.Value
				if cardInfo.Value == 1 then
					countA = countA + 1
				end
			end
		end
	end
	if count > 0 then
		local result = {count}
		if countA > 0 then
			for i=1,countA do
				count = count + 10 * i
				if count <= 21 then
					table.insert(result, count)
				else
					break
				end
			end
		end
		return result
	end
end

function CCard21:gameOverEvent( isWin, Score )
	local function restart( ... )
		self:resetCardsAndBet()
		self:updateLayer()
	end

	self:runGameOver(isWin, function ( ... )
		restart()
		if isWin then
			Card21Info.getCard21().Score = self.newScore
			self:updateLayer()
			self:runWin(Score, function ( ... )	
				self:send(netModel.getModelCard21Bet(Score), function ( data )
					if data and data.D then
						Card21Info.setCard21(data.D.Card21)
						require "EventCenter".eventInput("UpdateCard21CardPlay")
					end
				end)
			end, function ( ... )
				restart()
				GleeCore:showLayer("DCard21Bet")
			end)
		else
			self:runLose(Score, function ( ... )
				GleeCore:showLayer("DCard21Bet")
			end)
		end
	end)
end

--------------------------------
function CCard21:getSignleCardId( newCards )
	local oldCards = Card21Info.getCard21().MyCards
	for i,v in ipairs(newCards) do
		if not table.find(oldCards, v) then
			return dbManager.getCardConfigWithId(v)
		end
	end
end

function CCard21:runCardMove( cardInfo, callback )
	self._bg_cardsPlace:removeAllChildrenWithCleanup(true)
	local card = self:createLuaSet("@cardBack")
	self._bg_cardsPlace:addChild(card[1])

	local cardSet = self:createLuaSet("@card")
	card[1]:addChild(cardSet[1])
	self:updateCard(cardSet, cardInfo)
	cardSet[1]:setVisible(false)

	local actions = CCArray:create()
	actions:addObject(CCMoveTo:create(0.3, ccp(291.42862, 0)))
	actions:addObject(CCDelayTime:create(0.2))
	actions:addObject(CCScaleTo:create(0.1, 0, 1))
	actions:addObject(CCCallFunc:create(function ( ... )
		card[1]:setResid("")
		cardSet[1]:setVisible(true)
	end))
	actions:addObject(CCScaleTo:create(0.1, 1, 1))
	actions:addObject(CCDelayTime:create(0.2))
	actions:addObject(CCMoveTo:create(0.3, ccp(291.42862, -200)))
	actions:addObject(CCCallFunc:create(function ( ... )
		self:playCardEnabled(true)
		card[1]:removeFromParentAndCleanup(true)
		if callback then
			callback()
		end
	end))
	card[1]:runAction(CCSequence:create(actions))
	self:playCardEnabled(false)
end

function CCard21:runGameOver( isWin, callback )
	self._bg_gameOverBase:removeAllChildrenWithCleanup(true)
	local set = self:createLuaSet(isWin and "@win" or "@lose")
	self._bg_gameOverBase:addChild(set[1])
	set[1]:setOpacity(0)
	local actions = CCArray:create()
	local spawnArray = CCArray:create()
	spawnArray:addObject(CCFadeIn:create(0.5))
	spawnArray:addObject(CCMoveBy:create(0.5, ccp(0, 80)))
	actions:addObject(CCSpawn:create(spawnArray))
	actions:addObject(CCDelayTime:create(0.5))
	actions:addObject(CCCallFunc:create(function ( ... )
		self:playCardEnabled(true)
		set[1]:removeFromParentAndCleanup(true)

		if #Card21Info.getCard21().SystemCards == 1 then
			if callback then
				callback()
			end
		else
			local btnGameOverExit = true
			local btnGameOver = self:createLuaSet("@btnGameOver")
			self:getLayer():addChild(btnGameOver[1])
			btnGameOver[1]:setListener(function ( ... )
				if btnGameOverExit then
					btnGameOverExit = false
					btnGameOver[1]:removeFromParentAndCleanup(true)
					if callback then
						callback()
					end
				end
			end)
			self:runWithDelay(function ( ... )
				if btnGameOverExit then
					btnGameOver[1]:trigger(nil)
				end
			end, 0.8)
		end
	end))
	set[1]:runAction(CCSequence:create(actions))
	self:playCardEnabled(false)
end

function CCard21:runWin( winChip, callback1, callback2 )
	local btnSheildBg = self:createLuaSet("@btnSheildBg")
	self:getLayer():addChild(btnSheildBg[1])
	btnSheildBg[1]:setEnabled(false)

	local Swf = require 'framework.swf.Swf'
	local myswf = Swf.new('Swf_21DianYingLe')
	self:getLayer():addChild( myswf:getRootNode() )
	local shapeMap = {
		['shape-4'] = 'HD2_21_win.png',
		['shape-6'] = 'HD2_21_jiesuan_chibang.png',
		['shape-8'] = 'Swf_21DianYingLe-8.png',
		['shape-10'] = 'Swf_21DianYingLe-10.png',
		['shape-12'] = 'HD2_21_jiesuan_bg0.png',
		['shape-14'] = '',
		['shape-16'] = '',
		['shape-18'] = '',
		['shape-20'] = 'Swf_21DianYingLe-20.png',
	}

	local function cleanup( ... )
		self:playCardEnabled(true)
		myswf:getRootNode():removeFromParentAndCleanup(true)
		btnSheildBg[1]:removeFromParentAndCleanup(true)
	end

	btnSheildBg[1]:setListener(function ( ... )
		cleanup()
	end)

	local sucTip = self:createLuaSet("@finishTip")
	myswf:getNodeByTag(6):addChild(sucTip[1])
	sucTip[1]:setString(string.format(res.locString("Card21$sucTip"), winChip))
	sucTip[1]:setFontFillColor(ccc4f(0, 0, 1, 1), true)
	
	local winChipText = self:createLuaSet("@winChipText")
	myswf:getNodeByTag(8):addChild(winChipText[1])
	winChipText[1]:setString(string.format("+%d", winChip))

	local btnBetAgain = self:createLuaSet("@btnBetAgain")
	myswf:getNodeByTag(9):addChild(btnBetAgain[1])
	btnBetAgain["title"]:setString(res.locString("Card21$Bet") .. winChip)
	btnBetAgain[1]:setListener(function ( ... )
		cleanup()
		if callback1 then
			callback1()
		end
	end)

	local btnAgain = self:createLuaSet("@btnAgain")
	myswf:getNodeByTag(10):addChild(btnAgain[1])
	btnAgain[1]:setListener(function ( ... )
		cleanup()
		if callback2 then
			callback2()
		end
	end)

	self:playCardEnabled(false)
	myswf:play(shapeMap, nil, function ( ... )
		btnSheildBg[1]:setEnabled(true)
		myswf:getNodeByTag(5):runAction( CCRepeatForever:create(CCRotateBy:create(40/24, 90)) )
		self:playCardEnabled(true)
	end)
end

function CCard21:runLose( loseChip, callback )
	local btnSheildBg = self:createLuaSet("@btnSheildBg")
	btnSheildBg[1]:setEnabled(false)
	self:getLayer():addChild(btnSheildBg[1])

	local Swf = require 'framework.swf.Swf'
	local myswf = Swf.new('Swf_21DianShuLe')
	self:getLayer():addChild( myswf:getRootNode() )
	local shapeMap = {
		['shape-4'] = 'HD2_21_lose.png',
		['shape-6'] = 'HD2_21_jiesuan_chibang.png',
		['shape-8'] = '',
		['shape-10'] = '',
	}

	local function cleanup( ... )
		self:playCardEnabled(true)
		myswf:getRootNode():removeFromParentAndCleanup(true)
		btnSheildBg[1]:removeFromParentAndCleanup(true)
	end

	btnSheildBg[1]:setListener(function ( ... )
		cleanup()
	end)

	local failTip = self:createLuaSet("@finishTip")
	myswf:getNodeByTag(5):addChild(failTip[1])
	failTip[1]:setString(string.format(res.locString("Card21$failTip"), loseChip))
	failTip[1]:setFontFillColor(ccc4f(0, 0, 1, 0), true)
	
	local btnAgain = self:createLuaSet("@btnAgain")
	myswf:getNodeByTag(6):addChild(btnAgain[1])
	btnAgain[1]:setListener(function ( ... )
		cleanup()
		if callback then
			callback()
		end
	end)

	self:playCardEnabled(false)
	myswf:play(shapeMap, nil, function ( ... )
		btnSheildBg[1]:setEnabled(true)
		self:playCardEnabled(true)
	end)
end

function CCard21:playCardEnabled( enabled )
	self._bg_btnHit:setEnabled(enabled)
	self._bg_btnStand:setEnabled(enabled)
	self._bg_btnBet:setEnabled(enabled)
end

function CCard21:runCardsPlay( ... )
	local card21 = Card21Info.getCard21()
	local cloneCard21 = table.clone(card21)
	card21.MyCards = {}
	card21.SystemCards = {}
	self.isCardsPlaying = true
	self:updateLayer()
	self:runCardMove(dbManager.getCardConfigWithId(cloneCard21.MyCards[1]), function ( ... )
		table.insert(card21.MyCards, cloneCard21.MyCards[1])
		self:updateLayer()
		self:runCardSystem(dbManager.getCardConfigWithId(cloneCard21.SystemCards[1]), function ( ... )
			table.insert(card21.SystemCards, cloneCard21.SystemCards[1])
			self:updateLayer()
			self:runCardMove(dbManager.getCardConfigWithId(cloneCard21.MyCards[2]), function ( ... )
				table.insert(card21.MyCards, cloneCard21.MyCards[2])
				self:updateLayer()
				self:runCardSystem(nil, function ( ... )
					self.isCardsPlaying = false
					card21 = cloneCard21
					self:updateLayer()
				end)
			end)
		end)
	end)
end

function CCard21:runCardSystem( cardInfo, callback )
	self._bg_cardsPlace:removeAllChildrenWithCleanup(true)
	local card = self:createLuaSet("@cardBack")
	self._bg_cardsPlace:addChild(card[1])

	local cardSet
	if cardInfo then
		cardSet = self:createLuaSet("@card")
		card[1]:addChild(cardSet[1])
		self:updateCard(cardSet, cardInfo)
		cardSet[1]:setVisible(false)
	end

	local actions = CCArray:create()
	actions:addObject(CCMoveTo:create(0.3, ccp(291.42862, 0)))
	actions:addObject(CCDelayTime:create(0.2))
	if cardInfo then
		actions:addObject(CCScaleTo:create(0.1, 0, 1))
		actions:addObject(CCCallFunc:create(function ( ... )
			card[1]:setResid("")
			cardSet[1]:setVisible(true)
		end))
		actions:addObject(CCScaleTo:create(0.1, 1, 1))
		actions:addObject(CCDelayTime:create(0.2))
	end
	actions:addObject(CCMoveTo:create(0.3, ccp(291.42862, 150)))
	actions:addObject(CCCallFunc:create(function ( ... )
		self:playCardEnabled(true)
		card[1]:removeFromParentAndCleanup(true)
		if callback then
			callback()
		end
	end))
	card[1]:runAction(CCSequence:create(actions))
	self:playCardEnabled(false)
end

function CCard21:getCardsSystemMoveCards( cards )
	local oldCards = table.clone(Card21Info.getCard21().SystemCards)
	local isHideCard = true
	local list = {}
	for i,v in ipairs(cards) do
		if not table.find(oldCards, v) then
			if isHideCard then
				table.insert(oldCards, v)
				isHideCard = false
			else
				table.insert(list, v)
			end
		end
	end
	return oldCards, list
end

function CCard21:runCardsSystem( oldSystemCards, newSystemCards, callback )
	local card21 = Card21Info.getCard21()
	local cloneCard21 = table.clone(card21)
	card21.SystemCards = oldSystemCards
	self.isCardsSystemPlaying = false
	self:updateLayer()

	local runCard
	runCard = function ( index )
		if index <= #newSystemCards then
			self:runCardSystem(dbManager.getCardConfigWithId(newSystemCards[index]), function ( ... )
				table.insert(card21.SystemCards, newSystemCards[index])
				self:updateLayer()
				if index < #newSystemCards then
					self:updateLayer()
					runCard(index + 1)
				else
					self:runWithDelay(function ( ... )
						self.isCardsSystemPlaying = false
						card21 = cloneCard21
						self:updateLayer()
						if callback then
							callback()
						end
					end, 1)
				end
			end)
		end
	end
	runCard(1)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(CCard21, "CCard21")


--------------------------------register--------------------------------
GleeCore:registerLuaController("CCard21", CCard21)


