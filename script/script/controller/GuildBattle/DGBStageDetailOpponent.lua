local Config = require "Config"
local res = require "Res"
local GBHelper = require "GBHelper"
local EventCenter = require "EventCenter"
local netModel = require "netModel"
local dbManager = require "DBManager"

local DGBStageDetailOpponent = class(LuaDialog)

function DGBStageDetailOpponent:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGBStageDetailOpponent.cocos.zip")
    return self._factory:createDocument("DGBStageDetailOpponent.cocos")
end

--@@@@[[[[
function DGBStageDetailOpponent:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._root = set:getElfNode("root")
   self._root_icon = set:getElfNode("root_icon")
   self._root_name = set:getLabelNode("root_name")
   self._root_layoutGuildBelong_v = set:getLabelNode("root_layoutGuildBelong_v")
   self._root_layouty = set:getLayoutNode("root_layouty")
   self._v = set:getLabelNode("v")
   self._v = set:getLabelNode("v")
   self._layoutAddPro = set:getLayoutNode("layoutAddPro")
   self._root_btnAtk = set:getClickNode("root_btnAtk")
   self._root_layoutCanAtkTime = set:getLinearLayoutNode("root_layoutCanAtkTime")
   self._root_layoutCanAtkTime_k = set:getTimeNode("root_layoutCanAtkTime_k")
   self._root_layoutCanAtkTime_v = set:getLabelNode("root_layoutCanAtkTime_v")
--   self._@layoutDefTeam = set:getLinearLayoutNode("@layoutDefTeam")
--   self._@layoutHpLast = set:getLinearLayoutNode("@layoutHpLast")
--   self._@stageAddPro = set:getLabelNode("@stageAddPro")
--   self._@pro = set:getLabelNode("@pro")
--   self._@pro = set:getLabelNode("@pro")
--   self._@pro = set:getLabelNode("@pro")
--   self._@pro = set:getLabelNode("@pro")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DGBStageDetailOpponent", function ( userData )
	Launcher.callNet(netModel.getModelGuildMatchCastleDetails(userData.castle.CastleId, userData.castle.ServerId, userData.castle.GuildId),function ( data )
		if data and data.D then
			Launcher.Launching(data) 
		end
	end)
end)

function DGBStageDetailOpponent:onInit( userData, netData )
	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._root, self)
	end)

	self._root_icon:setResid( GBHelper.getGuildColorIcon(userData.castle.ServerId, userData.castle.GuildId, userData.castle.CastleId) )
	local CastleDetail = netData.D.Detail
	if userData.castle.CastleId == GBHelper.MidCastle then
		self._root_icon:setScale(self._root_icon:getScale() * 0.6)
		if userData.castle.GuildId == 0 then
			CastleDetail.GuildName = res.locString("GuildBattle$zhongli")
		end
	end
	self._root_name:setString(string.format(res.locString("GuildBattle$castleIndex"), userData.castle.CastleId))
	
	print("CastleDetail---------")
	print(CastleDetail)
	self._root_layoutGuildBelong_v:setString( CastleDetail.GuildName )
	self._root_layouty:removeAllChildrenWithCleanup(true)
	local status = GBHelper.getMatchStatusWithSeconds()
	if (userData.castle.CastleId == GBHelper.MidCastle and userData.castle.GuildId == 0) or (status == GBHelper.MatchStatus.FightPrepare or status == GBHelper.MatchStatus.Fighting) then
		local layoutDefTeam = self:createLuaSet("@layoutDefTeam")
		self._root_layouty:addChild(layoutDefTeam[1])
		layoutDefTeam["v"]:setString( string.format(res.locString("GuildBattle$teamCount"), CastleDetail.DefTeamCnt) )

		local layoutHpLast = self:createLuaSet("@layoutHpLast")
		self._root_layouty:addChild(layoutHpLast[1])
		layoutHpLast["v"]:setString( string.format("%d/%d", CastleDetail.HpLeft, CastleDetail.HpMax))
	end

	local stageAddPro = self:createLuaSet("@stageAddPro")
	self._root_layouty:addChild(stageAddPro[1])
	stageAddPro["layoutAddPro"]:removeAllChildrenWithCleanup(true)
	local sizeStageAddPro = stageAddPro[1]:getContentSize()
	stageAddPro["layoutAddPro"]:setPosition(ccp(sizeStageAddPro.width * -0.5, -sizeStageAddPro.height))

	local tips = dbManager.getGuildMatchCastleConfig( userData.castle.CastleId ).Tips or {}
	local addition = 0
	if CastleDetail.CastleCmd == 2 then
		addition = addition + dbManager.getInfoDefaultConfig("GuildDefBuff").Value
	end
	if GBHelper.isCastleLineToCamp( userData.castle.CastleId, userData.castle.ServerId, userData.castle.GuildId ) then
		addition = addition + dbManager.getInfoDefaultConfig("GuildBaseBuff").Value
	end
	if addition > 0 then
		table.insert(tips, string.format(res.locString("GuildBattle$allPetsAtk"), addition))
		table.insert(tips, string.format(res.locString("GuildBattle$allPetsHp"), addition))
	end

	for i,v in ipairs(tips) do
		local proSet = self:createLuaSet("@pro")
		stageAddPro["layoutAddPro"]:addChild(proSet[1])
		proSet[1]:setString(v)

		require 'LangAdapter'.selectLang(nil, nil, function ( ... )
			proSet[1]:setFontSize(18)
		end)
	end
	stageAddPro[1]:setVisible(tips and #tips > 0)

	--[[
	self._root_cannotAtk:setDimensions(CCSizeMake(300, 0))
	self._root_cannotAtk:setVisible(userData.castle.Occupied)
	]]
	self._root_layoutCanAtkTime:setVisible(status == GBHelper.MatchStatus.Fighting and userData.castle.Occupied)
	if status == GBHelper.MatchStatus.Fighting and userData.castle.Occupied then
		local seconds = -math.floor(require "TimeListManager".getTimeUpToNow(CastleDetail.LockedToTime))
		seconds = math.max(seconds, 0)
		local date = self._root_layoutCanAtkTime_k:getElfDate()
		date:setHourMinuteSecond(0, 0, seconds)
		if seconds > 0 then
			self._root_layoutCanAtkTime_k:setUpdateRate(-1)
			self._root_layoutCanAtkTime_k:addListener(function (  )
				userData.castle.Occupied = false
				self._root_layoutCanAtkTime:setVisible(false)
				self._root_btnAtk:setVisible(true)
				self._root_btnAtk:setEnabled( GBHelper.isStatusFighting() and GBHelper.getOpponentCastleCanAtk( userData.castle ) )
			end)
		else
			userData.castle.Occupied = false
			self._root_layoutCanAtkTime:setVisible(false)
		end
	end

	self._root_btnAtk:setVisible(not userData.castle.Occupied)
	self._root_btnAtk:setEnabled( GBHelper.isStatusFighting() and GBHelper.getOpponentCastleCanAtk( userData.castle ) )
	self._root_btnAtk:setListener(function ( ... )
		local playerInfo = GBHelper.getGuildMatchPlayer()
		if playerInfo then
			if playerInfo.ActionPoint <= 0 then
				self:toast(res.locString("GuildBattle$atkfailTip1"))
			elseif playerInfo.Cd > 0 then
				self:toast(res.locString("GuildBattle$atkfailTip2"))
			else
				self:send(netModel.getModelGuildMatchAttack(userData.castle.CastleId, userData.castle.ServerId, userData.castle.GuildId), function ( data )
					print("GuildMatchAttack")
					print(data)
					if data and data.D then
						local oldActionPoint = GBHelper.getGuildMatchPlayer().ActionPoint
						if data.D.Player then
							GBHelper.setGuildMatchPlayer(data.D.Player)
						end

						if data.D.Castles and #data.D.Castles > 0 then
							GBHelper.setMatches(data.D.Matches)
							GBHelper.updateCastles(data.D.Castles)

							EventCenter.eventInput("GuildFightCastleUpdate")
							res.doActionDialogHide(self._root, self)

							if oldActionPoint == GBHelper.getGuildMatchPlayer().ActionPoint then
								self:toast(res.locString("GuildBattle$castleIsDown2"))
							else
								self:toast(res.locString("GuildBattle$castleIsDown"))
							end
						else
							local startGameData = {}
							startGameData.type = "guildmatch"
							startGameData.data = {}
							local teamFunc = require "AppData".getTeamInfo()
							local petFunc = require "AppData".getPetInfo()
							local player = GBHelper.getGuildMatchPlayer()
							local atkPets = petFunc.getPetInfoWithTeamPets(data.D.AtkTeam, data.D.AtkPets)
							local castleConfig = dbManager.getGuildMatchCastleConfig( userData.castle.CastleId )
							if castleConfig then
								local thisAddition = data.D.Backup and 0 or addition
								petFunc.updatePetsAddition( atkPets, castleConfig.prop, castleConfig.AddValue )
								petFunc.updatePetsAddition( data.D.Pets, castleConfig.prop, castleConfig.AddValue, thisAddition )
								startGameData.data.additionTable = {}
								startGameData.data.additionTable.prop = castleConfig.prop
								startGameData.data.additionTable.rate = castleConfig.AddValue
								startGameData.data.additionTable.noPropRate = thisAddition
							end

							local boxCount1 = GBHelper.getGuildMatchBoxCount(playerInfo.ServerId, playerInfo.Gid)
							local boxCount2 = GBHelper.getGuildMatchBoxCount(userData.castle.ServerId, userData.castle.GuildId)
							petFunc.updatePetsAdditionWithBox(atkPets, boxCount1)
							petFunc.updatePetsAdditionWithBox(data.D.Pets, boxCount2)

							startGameData.data.petList = petFunc.convertToBattlePetList( atkPets )
							startGameData.data.petBornIJList = teamFunc.getTeamGBType( player.AtkType )
							startGameData.data.enemyList = petFunc.convertToBattlePetList( data.D.Pets )
							startGameData.data.enemyBornIJList = teamFunc.getTeamGBType( data.D.DefType )
							startGameData.data.enemyName = CastleDetail.GuildName
							if userData.castle.CastleId == GBHelper.MidCastle then
								if userData.castle.GuildId == 0 then
									startGameData.data.enemyName = res.locString("GuildBattle$zhongli2")
								end
							end

							print("battle start____" .. startGameData.type)
							print(startGameData)
							EventCenter.eventInput("BattleStart", startGameData)
						end
					end
				end, function ( data )
					if data then 
						if data.Code == 17013 then	-- 战斗中，请等待
							self:toast(res.locString("GuildBattle$castleIsFighting"))
						elseif data.Code == 17020 then	-- 前方战况有变!已刷新数据
							res.doActionDialogHide(self._root, self)
							EventCenter.eventInput("UpdateGuildMatchMap")
						end
					end
				end)
			end
		end
	end)

	res.doActionDialogShow(self._root)
end

function DGBStageDetailOpponent:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGBStageDetailOpponent, "DGBStageDetailOpponent")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGBStageDetailOpponent", DGBStageDetailOpponent)


