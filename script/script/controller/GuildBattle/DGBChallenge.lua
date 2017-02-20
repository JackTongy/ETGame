local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local GBHelper = require "GBHelper"
local netModel = require "netModel"

local DGBChallenge = class(LuaDialog)

function DGBChallenge:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGBChallenge.cocos.zip")
    return self._factory:createDocument("DGBChallenge.cocos")
end

--@@@@[[[[
function DGBChallenge:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._root = set:getElfNode("root")
    self._root_clipSwip_swip = set:getSwipNode("root_clipSwip_swip")
    self._root_clipSwip_swip_linearlayout = set:getLinearLayoutNode("root_clipSwip_swip_linearlayout")
    self._img = set:getElfNode("img")
    self._root_btnChallenge = set:getClickNode("root_btnChallenge")
    self._root_layoutTime1 = set:getLinearLayoutNode("root_layoutTime1")
    self._root_layoutTime1_k = set:getLabelNode("root_layoutTime1_k")
    self._root_layoutTime1_v = set:getTimeNode("root_layoutTime1_v")
    self._root_layoutTime1_cost = set:getRichLabelNode("root_layoutTime1_cost")
    self._root_layoutTime2 = set:getLinearLayoutNode("root_layoutTime2")
    self._root_layoutTime2_v = set:getTimeNode("root_layoutTime2_v")
    self._root_gameover = set:getLabelNode("root_gameover")
    self._root_btnDetail = set:getClickNode("root_btnDetail")
    self._root_btnDetail_text = set:getLabelNode("root_btnDetail_text")
--    self._@page = set:getElfNode("@page")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DGBChallenge", function ( userData )
	Launcher.callNet(netModel.getModelGuildMatchBossGet(),function ( data )
		if data and data.D then
			Launcher.Launching(data)   
		end
	end)
end)

function DGBChallenge:onInit( userData, netData )
	if netData and netData.D then
		self.challengeData = netData.D
	end

	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._root, self)
	end)

	local imgList = {"N_GHZ_xzd.png", "N_GHZ_xmd.png", "N_GHZ_xxd.png"}
	self._root_clipSwip_swip_linearlayout:removeAllChildrenWithCleanup(true)
	for i=1,3 do
		local pageSet = self:createLuaSet("@page")
		self._root_clipSwip_swip_linearlayout:addChild(pageSet[1])
		pageSet["img"]:setResid(imgList[i])
	end
	self.tabIndex = self.challengeData.Challenge.BossId - 1
	self._root_clipSwip_swip:setStayIndex(self.tabIndex)
	self._root_clipSwip_swip:setAnimateTime(0.3)
	self._root_clipSwip_swip:registerSwipeListenerScriptHandler(function(state, oldIndex, newIndex)
		if state ~= 0 and oldIndex ~= newIndex then	-- animation just finished
			print("oldIndex = " .. tostring(oldIndex))
			print("newIndex = " .. tostring(newIndex))
			-- newIndex从0计数
			self.tabIndex = newIndex
			self:updateLayer()
		end
	end)

	self._root_btnDetail:setListener(function ( ... )
		GleeCore:showLayer("DGBChallengeRewardIntr", {coin = self.challengeData.Challenge.TotalHarm})
	end)

	self:updateLayer()
	res.doActionDialogShow(self._root)

	require 'LangAdapter'.selectLang(nil, nil, function ( ... )
		self["_root_btnDetail_text"]:setPosition(ccp(22.0,-21.428574))
		self._root_layoutTime1_k:setFontSize(21)
		self._root_layoutTime1_v:setFontSize(21)
		self._root_layoutTime1_cost:setFontSize(21)
	end)
end

function DGBChallenge:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DGBChallenge:updateLayer( ... )
	local iChallenge = self.challengeData.Challenge.BossId - 1 == self.tabIndex
	local status, lastTime = GBHelper.getChallengeStatusWithSeconds()	
	self._root_btnChallenge:setEnabled(iChallenge and status == GBHelper.ChallengeStatus.Challenging and self:canChallenge())

	self._root_layoutTime1:setVisible(status == GBHelper.ChallengeStatus.Challenging)
	self._root_layoutTime2:setVisible(status == GBHelper.ChallengeStatus.Waiting)
	self._root_gameover:setVisible(status == GBHelper.ChallengeStatus.GameOver)
	if status == GBHelper.ChallengeStatus.Challenging then
		self._root_layoutTime1_v:getElfDate():setHourMinuteSecond(0, 0, lastTime)
		self._root_layoutTime1_v:getElfDate():setTimeFormat(DayHourMinuteSecond)
		self._root_layoutTime1_v:setUpdateRate(-1)
		self._root_layoutTime1_v:addListener(function (  )
			self:updateLayer()
		end)
	
		local userFunc = require "AppData".getUserInfo()
		local player = GBHelper.getGuildMatchPlayer()
		local cost = 0
		
		if player.ChallengeTimesLeft > 0 then
			self._root_layoutTime1_cost:setString(res.locString("GuildBattle$thisChallengeFree"))
		else
			local vipInfo = dbManager.getVipInfo( userFunc.getVipLevel() )
			if player.ChallengeTimesBuy >= vipInfo.GuildFightBuyTimes then
				self._root_layoutTime1_cost:setString( res.locString("GuildBattle$thisChallengeOver") )
			else
				local costList = dbManager.getInfoDefaultConfig("GuildFightBossCost").Value
				if player.ChallengeTimesBuy < #costList then
					cost = costList[player.ChallengeTimesBuy + 1]
				else
					cost = costList[#costList]
				end
				self._root_layoutTime1_cost:setString(string.format(res.locString("GuildBattle$thisChallenge"), cost))
			end
		end
		self._root_layoutTime1_cost:setFontFillColor(ccc4f(0.71,0.49,1.0,0.93), true)

		self._root_btnChallenge:setListener(function ( ... )
			local function startBattle( ... )
				local gameData = {}
				gameData.type = 'guildboss'
				gameData.data = {}
				gameData.data.battleId = self.tabIndex + 601
				local teamFunc = require "AppData".getTeamInfo()
				local petFunc = require "AppData".getPetInfo()
				gameData.data.petList = petFunc.convertToBattlePetList( petFunc.getPetInfoWithTeamPets(self.challengeData.AtkTeam, self.challengeData.AtkPets) )
				gameData.data.petBornIJList = teamFunc.getTeamGBType( player.AtkType )
				print("battle start____" .. gameData.type)
				print(gameData)
				require "EventCenter".eventInput("BattleStart", gameData)
			end

			if userFunc.getCoin() >= cost then
				if cost == 0 then
					startBattle()
				else
					local function startBattleWithCoin( ... )
						self:send(netModel.getModelGuildMatchBossBuy(), function ( data )
							if data and data.D then
								userFunc.setCoin( userFunc.getCoin() - cost )
								GBHelper.setGuildMatchPlayer(data.D.Player)
								startBattle()
							end
						end)
					end

					local LangName = require 'Config'.LangName or ''
					if LangName == "kor" then
						local param = {}
						param.content = "정령석이 소비됩니다.\r\n진행하시겠습니까?"
						param.callback = function (  )
							startBattleWithCoin()
						end
						GleeCore:showLayer("DConfirmNT", param)
					else
						startBattleWithCoin()
					end
				end
			else
				require "Toolkit".showDialogOnCoinNotEnough()
			end
		end)
	elseif status == GBHelper.ChallengeStatus.Waiting then
		self._root_layoutTime2_v:getElfDate():setHourMinuteSecond(0, 0, lastTime)
		self._root_layoutTime2_v:getElfDate():setTimeFormat(DayHourMinuteSecond)
		self._root_layoutTime2_v:setUpdateRate(-1)
		self._root_layoutTime2_v:addListener(function (  )
			self:updateLayer()
		end)		
	end
end

function DGBChallenge:canChallenge( ... )
	local result = true
	local player = GBHelper.getGuildMatchPlayer()
	if player and player.ChallengeTimesLeft <= 0 then
		local vipInfo = dbManager.getVipInfo( require "AppData".getUserInfo().getVipLevel() )
		if player.ChallengeTimesBuy >= vipInfo.GuildFightBuyTimes then
			result = false
		end
	end
	return result
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGBChallenge, "DGBChallenge")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGBChallenge", DGBChallenge)


