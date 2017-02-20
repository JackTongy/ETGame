local config = require "Config"
local dbManager = require "DBManager"
local netModel = require "netModel"
local gameFunc = require "AppData"
local res = require "Res"
local friendsFunc = gameFunc.getFriendsInfo()
local teamFunc = gameFunc.getTeamInfo()
local petFunc = gameFunc.getPetInfo()
local EventCenter = require 'EventCenter'
local GuideHelper = require 'GuideHelper'
local LuaList = require "LuaList"
local GuildCopyFunc = require "GuildCopyInfo"

local DPrepareForStageBattle = class(LuaDialog)

function DPrepareForStageBattle:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."DPrepareForStageBattle.cocos.zip")
    return self._factory:createDocument("DPrepareForStageBattle.cocos")
end

--@@@@[[[[
function DPrepareForStageBattle:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_team = set:getLabelNode("bg_team")
    self._bg_layout1_value = set:getLabelNode("bg_layout1_value")
    self._bg_teamBg_clipSwip_teamSwip = set:getSwipNode("bg_teamBg_clipSwip_teamSwip")
    self._bg_teamBg_clipSwip_teamSwip_linearlayout = set:getLinearLayoutNode("bg_teamBg_clipSwip_teamSwip_linearlayout")
    self._icon = set:getElfNode("icon")
    self._career = set:getElfNode("career")
    self._property = set:getElfNode("property")
    self._lv = set:getLabelNode("lv")
    self._starLayout = set:getLayoutNode("starLayout")
    self._bench = set:getElfNode("bench")
    self._isFriend = set:getElfNode("isFriend")
    self._bg_teamBg_turnLeft = set:getElfNode("bg_teamBg_turnLeft")
    self._bg_teamBg_turnRight = set:getElfNode("bg_teamBg_turnRight")
    self._bg_teamBg_btnTurnLeft = set:getClickNode("bg_teamBg_btnTurnLeft")
    self._bg_teamBg_btnTurnRight = set:getClickNode("bg_teamBg_btnTurnRight")
    self._bg_friendHelpTitle = set:getLabelNode("bg_friendHelpTitle")
    self._bg_friendBg_noFriends = set:getLabelNode("bg_friendBg_noFriends")
    self._bg_friendBg_noInvite = set:getLabelNode("bg_friendBg_noInvite")
    self._bg_friendBg_list = set:getListNode("bg_friendBg_list")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._career = set:getElfNode("career")
    self._property = set:getElfNode("property")
    self._starLayout = set:getLayoutNode("starLayout")
    self._name = set:getLabelNode("name")
    self._lvTitle = set:getLabelNode("lvTitle")
    self._lv = set:getLabelNode("lv")
    self._AtkTitle = set:getLabelNode("AtkTitle")
    self._atk = set:getLabelNode("atk")
    self._HpTitle = set:getLabelNode("HpTitle")
    self._hp = set:getLabelNode("hp")
    self._clickTip = set:getLabelNode("clickTip")
    self._btn = set:getClickNode("btn")
    self._frame = set:getElfNode("frame")
    self._chosen = set:getElfNode("chosen")
    self._bg_btnCancel = set:getClickNode("bg_btnCancel")
    self._bg_btnBattle = set:getClickNode("bg_btnBattle")
    self._bg_shield = set:getShieldNode("bg_shield")
    self._bg_btnMask = set:getColorClickNode("bg_btnMask")
    self._bg_layOnMask = set:getElfNode("bg_layOnMask")
    self._icon = set:getElfNode("icon")
    self._career = set:getElfNode("career")
    self._property = set:getElfNode("property")
    self._lv = set:getLabelNode("lv")
    self._starLayout = set:getLayoutNode("starLayout")
    self._btnChange = set:getButtonNode("btnChange")
    self._btnInTeam = set:getButtonNode("btnInTeam")
    self._icon = set:getElfNode("icon")
    self._career = set:getElfNode("career")
    self._property = set:getElfNode("property")
    self._lv = set:getLabelNode("lv")
    self._starLayout = set:getLayoutNode("starLayout")
    self._btnChange = set:getButtonNode("btnChange")
    self._btnInTeam = set:getButtonNode("btnInTeam")
    self._icon = set:getElfNode("icon")
    self._career = set:getElfNode("career")
    self._property = set:getElfNode("property")
    self._lv = set:getLabelNode("lv")
    self._starLayout = set:getLayoutNode("starLayout")
    self._btnChange = set:getButtonNode("btnChange")
    self._btnInTeam = set:getButtonNode("btnInTeam")
    self._icon = set:getElfNode("icon")
    self._career = set:getElfNode("career")
    self._property = set:getElfNode("property")
    self._lv = set:getLabelNode("lv")
    self._starLayout = set:getLayoutNode("starLayout")
    self._btnChange = set:getButtonNode("btnChange")
    self._btnInTeam = set:getButtonNode("btnInTeam")
--    self._@page = set:getLayoutNode("@page")
--    self._@pet = set:getElfNode("@pet")
--    self._@star = set:getElfNode("@star")
--    self._@friend = set:getElfNode("@friend")
--    self._@star = set:getElfNode("@star")
--    self._@mask_pet2 = set:getElfNode("@mask_pet2")
--    self._@star = set:getElfNode("@star")
--    self._@mask_pet3 = set:getElfNode("@mask_pet3")
--    self._@star = set:getElfNode("@star")
--    self._@mask_pet4 = set:getElfNode("@mask_pet4")
--    self._@star = set:getElfNode("@star")
--    self._@mask_pet5 = set:getElfNode("@mask_pet5")
--    self._@star = set:getElfNode("@star")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DPrepareForStageBattle", function ( userData )
	local canInvite = false
	if userData and userData.type then
		local cannotInviteList = {"bossBattle", "CMBossBattle", "SDNBossBattle", "ActRaid", "fuben_thief", "fuben_cat", "limit_fuben", "FriendChallenge"}
		if not table.find(cannotInviteList, userData.type) then
			canInvite = true
		end
	end
	if canInvite then
		if userData and userData.type == "guildfuben" then
	   	Launcher.callNet(netModel.getModelGuildCopyPetsGet(),function ( data )
			if data and data.D then
				GuildCopyFunc.setGuildCopyPetsMine(data.D.Mine)
				GuildCopyFunc.setGuildCopyPetsOthers(data.D.Others)
				Launcher.Launching(data) 
			end
   		end)	
		else
	   	Launcher.callNet(netModel.getModelFriendGetFriend(),function ( data )
			if data and data.D then
				friendsFunc.setFriendList(data.D.Friends)
				Launcher.Launching(data) 
			end
   		end)	
		end
	else
		Launcher.Launching() 
	end
end)

function DPrepareForStageBattle:onInit( userData, data )
	res.doActionDialogShow(self._bg)
	
	local unLockManager = require "UnlockManager"
	if unLockManager:isUnlock("Team3") then
		self.maxTeamCount = 3
	elseif unLockManager:isUnlock("Team2") then
		self.maxTeamCount = 2
	else
		self.maxTeamCount = 1
	end

	self.battleType = userData.type
	self.battleId = userData.battleId
	self.Boss = userData.Boss
	self.bossId = userData.bossId
	self.ChallengeId = userData.ChallengeId
	self.OrderNo = userData.OrderNo
	self.battleBuffer = userData.battleBuffer
	self.terrian = userData.terrian
	self.stageId = userData.stageId
	self.preAp = userData.preAp
	self.isStarBoss = userData.isStarBoss
	self.emenyPetList = userData.emenyPetList
	self.RemainsFubenData = userData.RemainsFubenData
	self.FriendData = userData.FriendData
	self:setListenerEvent()

	self:updateFriendList(true)

	self.swipIndex = teamFunc.getTeamActiveId()
	self.oldTeamActiveId = self.swipIndex
	self:updateTeamSwip()
	self:updateSwipIndex()			
	self._bg_teamBg_clipSwip_teamSwip:setStayIndex(self.swipIndex - 1)

	GuideHelper:registerPoint('开始战斗',self._bg_btnBattle)
	GuideHelper:check('DPrepareForStageBattle')

	require 'LangAdapter'.selectLang(nil, nil, nil, nil, function ( ... )
		self._bg_friendHelpTitle:setRotation(90)
		self._bg_friendHelpTitle:setPosition(ccp(-360.0,0))
	end, nil, nil, function ( ... )
		self._bg_friendHelpTitle:setRotation(90)
		self._bg_friendHelpTitle:setPosition(ccp(-360.0,0))
	end)
end

function DPrepareForStageBattle:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DPrepareForStageBattle:setListenerEvent(  )
	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
		EventCenter.eventInput("UpdateDungeonCell")
	end)
	
	require "LangAdapter".LabelNodeAutoShrink(self._set:getLabelNode("bg_btnCancel_#text"), 104)
	self._bg_btnCancel:setTriggleSound(res.Sound.back)
	self._bg_btnCancel:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
		EventCenter.eventInput("UpdateDungeonCell")
	end)

	self._bg_btnBattle:setTriggleSound(res.Sound.yes)
	self._bg_btnBattle:setListener(function (  )
		local function doBattle( ... )
			local team = teamFunc.getTeamActive()
			local petList = team.PetIdList
			local battlePetIdList = {}
			local canFind = false
			for i,petId in ipairs(petList) do
				if self.switchId == petId then
					petId = self.friendSelectedPetId
					canFind = true
				end
				table.insert(battlePetIdList, petId)
			end
			if canFind == false and self.friendSelectedPetId then
				table.insert(battlePetIdList, self.friendSelectedPetId)
			end
			if team.BenchPetId > 0 then
				table.insert(battlePetIdList, team.BenchPetId)
			end

			local param = {}
			for i,nPetId in ipairs(battlePetIdList) do
				local nPet
				if nPetId == self.friendSelectedPetId then
					nPet = self:getPetWithId(nPetId)
					if self.battleType == "guildfuben" then
						table.insert(param, petFunc.convertToDungeonDataEncode(nPet, false, true))
					else
						table.insert(param, petFunc.convertToDungeonDataEncode(nPet, true, false))
					end
				else
					nPet = petFunc.getPetWithId(nPetId)
					table.insert(param, petFunc.convertToDungeonDataEncode(nPet, false, false))
				end
			end

			local function startBattleWithId( battleId, capture, dropNum )
				if self.friendSelectedFid and self.friendSelectedFid > 0 and self.battleType ~= "guildfuben" then
					friendsFunc.setFriendCannotInvite(self.friendSelectedFid)
				end

				local startGameData = {}
				startGameData.type = self.battleType

				local dataList = {}
				dataList.petList = param
				dataList.battleId = battleId
				dataList.battleBuffer = self.battleBuffer
				dataList.bossId = self.bossId
				dataList.bgType = self.terrian
				dataList.catchBossFlag = capture
				dataList.dropNum = dropNum
				dataList.preAp = self.preAp
				startGameData.data = dataList
				print("battle start____" .. self.battleType)
				print(startGameData)
				EventCenter.eventInput("BattleStart", startGameData)
			end

			if self:isBossBattle() then
				local function bossBattle( ... )
					local startGameData = {}
					startGameData.type = self.battleType
					local bossconv = petFunc.convertToDungeonData(self.Boss.Pet,false)
					startGameData.data = {petList = param, boss = bossconv,Bid = self.Boss.Bid,battleBuffer = self.battleBuffer}
					if self.Boss.Callback then
						self.Boss.Callback(startGameData)
					else
						EventCenter.eventInput("BattleStart", startGameData)
					end
				end
				if self.battleType == "bossBattle" then
					self:send(netModel.getModelBossBattleStart(self.Boss.Bid), function ( data )
						bossBattle()
					end)
				else
					bossBattle()
				end
			elseif self.battleType == "ActRaid" then
				startBattleWithId(self.battleId)
			elseif self.battleType == "fuben_cat" or self.battleType == "fuben_thief" then
				startBattleWithId(self.battleId)
			elseif self.battleType == "fuben" then
				if self.battleId then
					startBattleWithId(self.battleId)
				else
					self:send(netModel.getModelChallengeOperate(self.ChallengeId, self.OrderNo, teamFunc.getTeamActiveId(), self.friendSelectedPetId), function ( data )
						print("ChallengeOperate_battle")
						print(data)
						if data and data.D then
							if data.D.Resource then
								gameFunc.updateResource(data.D.Resource)
							end
							if data.D.Challenge then
								EventCenter.eventInput("UpdateDungeonChallenge", data.D.Challenge)
							end
							if data.D.Battle then
								local dropNum
								if data.D.Battle.Reward then
									if data.D.Battle.Reward.Materials then
										dropNum = #data.D.Battle.Reward.Materials
									end
									if data.D.Battle.Reward.Equipments then
										if dropNum then
											dropNum = dropNum + #data.D.Battle.Reward.Equipments
										else
											dropNum = #data.D.Battle.Reward.Equipments
										end
									end
								end
								if self.isStarBoss then
									self.battleType = "fuben_boss"
								end
								startBattleWithId(data.D.Battle.BattleId, data.D.Battle.Capture, dropNum)
							end
						end
					end)
				end
			elseif self.battleType == "battleFuben" then
				self:send(netModel.getModelStageCombat(self.stageId, self.friendSelectedPetId), function ( data )
					print("StageCombat")
					print(data)
					if data.D.Role then
						local userFunc = gameFunc.getUserInfo()
						local isUpdateAp = data.D.Role.Ap ~= userFunc.getAp()
						userFunc.setData(data.D.Role)
						if isUpdateAp then
							require 'EventCenter'.eventInput("UpdateAp")
						end
					end
					if data.D.Battle then
						gameFunc.getTempInfo().setValueForKey("ReopenTown", true)

						self.battleType = "fuben"
						local dropNum
						if data.D.Battle.Reward then
							if data.D.Battle.Reward.Materials then
								dropNum = #data.D.Battle.Reward.Materials
							end
							if data.D.Battle.Reward.Equipments then
								if dropNum then
									dropNum = dropNum + #data.D.Battle.Reward.Equipments
								else
									dropNum = #data.D.Battle.Reward.Equipments
								end
							end
						end
						
						if self.stageId == 10701 then
							GuideHelper:startGuide('GCfg15',1,1,nil,1)
						end
						
						gameFunc.getTownInfo().setLastBattleStageId(self.stageId)
						startBattleWithId(data.D.Battle.BattleId, data.D.Battle.Capture, dropNum)
					end
				end)
			elseif self.battleType == "guildfuben" then
				self:send(netModel.getModelGuildCopyChallenge(self.stageId, self.friendSelectedFid), function ( data )
					if data and data.D then
						if data.D.Stage then
							GuildCopyFunc.setStage(data.D.Stage)
							EventCenter.eventInput("UpdateHunt")
							res.doActionDialogHide(self._bg, self)
							self:toast(res.locString("Hunt$stageIsClean"))
						else
							local gameData = {}
							gameData.type = self.battleType
							gameData.data = {}
							gameData.data.petList = param

							local function getPetWithEnergy( nPet, energyList )
								nPet.energy = 0
								if energyList then
									for k,v in pairs(energyList) do
										if tonumber(k) == nPet.Id then
											nPet.energy = v
											break
										end
									end
								end
							end
							for _,nPet in pairs(data.D.NpcPets) do
								getPetWithEnergy(nPet, data.D.Energy)
							end
							
							gameData.data.enemyList = petFunc.convertToBattlePetList( data.D.NpcPets )
							print("battle start____" .. gameData.type)
							print(gameData)
							require "EventCenter".eventInput("BattleStart", gameData)							
						end
					end
				end)
			elseif self.battleType == "limit_fuben" then
				local gameData = {}
				gameData.type = self.battleType
				gameData.data = {}
				if not gameFunc.getTempInfo().getValueForKey("TimeLimitExploreTeamNormal") then
					local CSValueConverter = require 'CSValueConverter'
					local ConType = gameFunc.getTempInfo().getValueForKey("TimeLimitExploreTeamConType")
					local ConValue = gameFunc.getTempInfo().getValueForKey("TimeLimitExploreTeamConValue")
					if ConType == 1 then
						for i,v in ipairs(param) do
							local dbPet = dbManager.getCharactor(v.PetId)
							if dbPet.prop_1 ~= ConValue then
								param[i].atk = CSValueConverter.toC( CSValueConverter.toS(param[i].atk) * 0.3 )
								param[i].hp = CSValueConverter.toCHp( CSValueConverter.toSHp(param[i].hp) * 0.3 )
								param[i].HpMax = CSValueConverter.toCHp( CSValueConverter.toSHp(param[i].HpMax) * 0.3 )
							end
						end
					elseif ConType == 2 then
						for i,v in ipairs(param) do
							local dbPet = dbManager.getCharactor(v.PetId)
							if dbPet.atk_method_system ~= ConValue then
								param[i].atk = CSValueConverter.toC( CSValueConverter.toS(param[i].atk) * 0.3 )
								param[i].hp = CSValueConverter.toCHp( CSValueConverter.toSHp(param[i].hp) * 0.3 )
								param[i].HpMax = CSValueConverter.toCHp( CSValueConverter.toSHp(param[i].HpMax) * 0.3 )
							end
						end
					end
				end
				gameData.data.petList = param
				gameData.data.stageId = self.stageId
				local exploreData = gameFunc.getActivityInfo().getDataByType(42)
				local TimeCopyStageCfg = exploreData.Data.StageCfgs[self.stageId]
				local emenys = {}
				for i,v in ipairs(TimeCopyStageCfg.PetIdList) do
					local nPet = petFunc.getPetInfoByPetId(v)
					nPet.Atk = TimeCopyStageCfg.Atk
					nPet.Hp = TimeCopyStageCfg.Hp
					table.insert(emenys, nPet)
				end
				gameData.data.enemyList = petFunc.convertToBattlePetList( emenys )
				print("battle start____" .. gameData.type)
				print(gameData)
				require "EventCenter".eventInput("BattleStart", gameData)
			elseif self.battleType == "RemainsFuben" then
				local CSValueConverter = require 'CSValueConverter'
				local gameData = {}
				gameData.type = self.battleType
				gameData.data = {}
				for i,v in ipairs(param) do
					local dbPet = dbManager.getCharactor(v.PetId)
					param[i].atk = CSValueConverter.toC( CSValueConverter.toS(param[i].atk) * (1 + self.RemainsFubenData.Atks) )
					param[i].hp = CSValueConverter.toCHp( CSValueConverter.toSHp(param[i].hp) * (1 + self.RemainsFubenData.Hps) )
					param[i].HpMax = CSValueConverter.toCHp( CSValueConverter.toSHp(param[i].HpMax) * (1 + self.RemainsFubenData.Hps) )
					local leftRate = self.RemainsFubenData.HpLefts[i] and self.RemainsFubenData.HpLefts[i] or 1
					param[i].hp = CSValueConverter.toCHp( CSValueConverter.toSHp(param[i].hp) * leftRate)
				end
				gameData.data.petList = param
				local emenys = {}
				table.sort(self.emenyPetList, function ( v1, v2 )
					if v1.leader == v2.leader then
						return v1.leader > v2.leader
					else
						return v1.petid < v2.petid
					end
				end)
				local bossId
				for i,v in ipairs(self.emenyPetList) do
					local nPet = petFunc.getPetInfoByPetId(v.petid)
					nPet.Atk = v.atk
					nPet.Hp = v.hp
					table.insert(emenys, nPet)
					if v.Boss then
						bossId = v.petid
					end
				end
				gameData.data.enemyList = petFunc.convertToBattlePetList( emenys )
				gameData.data.bgType = self.terrian
				gameData.data.bossId = bossId
				gameData.data.Id = self.RemainsFubenData.index
				print("battle start____" .. gameData.type)
				print(gameData)
				require "EventCenter".eventInput("BattleStart", gameData)
			elseif self.battleType == "FriendChallenge" then
				self:send(netModel.getModelTeamGetDetails(self.FriendData.Rid), function ( data )
					if data and data.D then
						local iTeam = teamFunc.getTeamActive()
						local jTeam = data.D.Team
						local param = {}
						param.type = "friend"
						param.data = {}
						param.data.petList = teamFunc.getConvertPetListWithTeam(iTeam)
						param.data.enemyList = {}

						local function getNetPetHere( nPetId )
							for i,v in ipairs(data.D.Pets) do
								if v.Id == nPetId then
									return v
								end
							end
						end
						for i,v in ipairs(jTeam.PetIdList) do
							table.insert(param.data.enemyList, petFunc.convertToDungeonData(getNetPetHere(v)))
						end
						if jTeam.BenchPetId > 0 then
							table.insert(param.data.enemyList, petFunc.convertToDungeonData(getNetPetHere(jTeam.BenchPetId)))
						end

						param.data.petBornIJList = teamFunc.getPosListAtkType(iTeam)
						param.data.enemyBornIJList = teamFunc.getPosListDefType(jTeam)
						param.data.enemyName = self.FriendData.Name
						EventCenter.eventInput("BattleStart", param)
					end
				end)
			end
		end
		if self.oldTeamActiveId == self.swipIndex then
			doBattle()
		else
			self:send(netModel.getModelTeamSetActive(self.swipIndex), function ( data )
				print("TeamSetActive:")
				print(data)
				if data and data.D then
					if data.D.Teams then
						teamFunc.setTeamList(data.D.Teams)
					end
					if data.D.Pets then
						petFunc.addPets(data.D.Pets)
					end
					doBattle()
				end
			end)		
		end
	end)

	self._bg_btnMask:setListener(function (  )
		self.friendSelectedPetId = nil
		self.friendSelectedFid = nil
		self._bg_btnMask:setVisible(false)
		self._bg_shield:setVisible(false)
		self._bg_layOnMask:setVisible(false)
	end)

	self._bg_teamBg_clipSwip_teamSwip:registerSwipeListenerScriptHandler(function(state, oldIndex, newIndex)
		if state ~= 0 and oldIndex ~= newIndex then	-- animation just finished
			print("oldIndex = " .. tostring(oldIndex))
			print("newIndex = " .. tostring(newIndex))
			self.swipIndex = newIndex + 1
			self:updateSwipIndex()
		end
	end)

	self._bg_teamBg_btnTurnLeft:setListener(function (  )
		self.swipIndex = math.max(self.swipIndex - 1, 1)
		self:updateSwipIndex()
		self._bg_teamBg_clipSwip_teamSwip:setStayIndex(self.swipIndex - 1)
	end)

	self._bg_teamBg_btnTurnRight:setListener(function (  )
		self.swipIndex = math.min(self.swipIndex + 1, self.maxTeamCount)
		self:updateSwipIndex()
		self._bg_teamBg_clipSwip_teamSwip:setStayIndex(self.swipIndex - 1)
	end)
end

function DPrepareForStageBattle:canInvite( ... )
	local cannotInviteList = {"bossBattle", "CMBossBattle", "SDNBossBattle", "ActRaid", "fuben_thief", "fuben_cat", "limit_fuben", "FriendChallenge"}
	return not table.find(cannotInviteList, self.battleType)
end

function DPrepareForStageBattle:isBossBattle( )
	return self.battleType == "bossBattle" or self.battleType == 'CMBossBattle' or self.battleType == 'SDNBossBattle'
end

function DPrepareForStageBattle:updateFriendList( refresh )
	local canInvite = self:canInvite()
	local list = {}
	if canInvite then
		if self.battleType == "guildfuben" then
			self._bg_friendBg_noFriends:setString(res.locString("Stage$NoGuildFriend"))
			self._bg_friendHelpTitle:setString(res.locString("Stage$GuildHelp"))
			list = GuildCopyFunc.getGuildCopyPetsOthers()
		else
			list = friendsFunc.getFriendList()
		end
	end

	self._bg_friendBg_list:setVisible(canInvite)
	self._bg_friendBg_noInvite:setVisible(not canInvite)
	self._bg_friendBg_noFriends:setVisible( canInvite and not (list and #list > 0) )

	if canInvite and list and #list > 0 then
		if not self.friendList then
			self.friendList = LuaList.new(self._bg_friendBg_list, function (  )
				return self:createLuaSet("@friend")
			end, function ( nodeLuaSet, data )
				local nData = {}
				if self.battleType == "guildfuben" then
					nData.Name = data.RoleName
					nData.Invite = data.CanInvite
					nData.Pid = data.Pet.Id
				else
					nData.Name = data.Name
					nData.Invite = data.Invite
					nData.Pid = data.Fid
				end

				local nPet = data.Pet
				local dbPet = dbManager.getCharactor(nPet.PetId)
				res.setNodeWithPet(nodeLuaSet["icon"], nPet)
				nodeLuaSet["career"]:setResid(res.getPetCareerIcon(dbPet.atk_method_system))
				require 'PetNodeHelper'.updateStarLayout(nodeLuaSet["starLayout"], dbPet)

				nodeLuaSet["name"]:setString(nData.Name)
				nodeLuaSet["lv"]:setString(nPet.Lv)
				nodeLuaSet["atk"]:setString(nPet.Atk)
				nodeLuaSet["hp"]:setString(nPet.Hp)

				if not nData.Invite then
					nodeLuaSet["frame"]:setVisible(true)
					nodeLuaSet["chosen"]:setVisible(false)
					nodeLuaSet["clickTip"]:setString(res.locString("Friend$cannotInvite"))
				elseif (self.friendSelectedPetId and self.friendSelectedPetId == nPet.Id) then
					nodeLuaSet["frame"]:setVisible(true)
					nodeLuaSet["chosen"]:setVisible(true)
					nodeLuaSet["clickTip"]:setString(res.locString("Stage$TouchCancel"))
				else
					nodeLuaSet["frame"]:setVisible(false)
					nodeLuaSet["chosen"]:setVisible(false)
					nodeLuaSet["clickTip"]:setString(res.locString("Stage$TouchChose"))
				end
				require 'LangAdapter'.fontSize(nodeLuaSet["clickTip"],nil,nil,nil,nil,nil,nil,nil,16)

				nodeLuaSet["btn"]:setListener(function (  )
					if not nData.Invite then
						if self.battleType == "guildfuben" then
							self:toast(res.locString("Friend$cannotInviteGuildTip"))
						else
							self:toast(res.locString("Friend$cannotInviteTip"))
						end
					elseif self.friendSelectedPetId and self.friendSelectedPetId == nPet.Id then
						self:friendEventCancel()
					else
						self:friendEventSelect(nPet.Id)
						if self.battleType == "guildfuben" then
							self.friendSelectedFid = data.Id
						else
							self.friendSelectedFid = nData.Pid
						end
					end
				end)
			end)
		end

		if self.battleType ~= "guildfuben" then
			friendsFunc.sortWithPet(list, self.friendSelectedPetId)
		else
			table.sort(list, function ( a, b )
				if a.CanInvite == b.CanInvite then
					pet1 = a.Pet
					pet2 = b.Pet
					if self.friendSelectedPetId and pet1.Id == self.friendSelectedPetId then
						return true
					end
					if self.friendSelectedPetId ~= pet2.Id then
						if pet1.Power == pet2.Power then
							if pet1.Lv == pet2.Lv then
								return pet1.Id < pet2.Id
							else
								return pet1.Lv > pet2.Lv
							end	
						else
							return  pet1.Power > pet2.Power
						end
					end
				else
					return a.CanInvite
				end
			end)
		end
		self.friendList:update(list, refresh)
	end
end

function DPrepareForStageBattle:friendEventSelect( selectPetId )
	if not self.friendSelectedPetId then
		self.pageSelected = self.swipIndex
		self.friendSelectedPetId = selectPetId
		self._bg_btnMask:setVisible(true)
		self._bg_shield:setVisible(true)
		self._bg_layOnMask:setVisible(true)
		self:updateLayonMask()
	end
end

function DPrepareForStageBattle:friendEventCancel(  )
	if self.friendSelectedPetId and self.pageSelected then
		for k,v in pairs(self.petSet) do
			if v.page == self.pageSelected and v.positionId == self.switchPositionId then
				if self.switchId then
					res.setNodeWithPetAuto(v.set, petFunc.getPetWithId(self.switchId), self)
				else
					res.setNodeWithPetAuto(v.set, nil)
				end
				v.set["isFriend"]:setVisible(false)
				break
			end
		end

		self.pageSelected = nil
		self.friendSelectedPetId = nil
		self.friendSelectedFid = nil
		self.switchId = nil
		self.switchPositionId = 0
		self:updateFriendList(false)

		self:updateTeamBattleValue()
	end
end

function DPrepareForStageBattle:updateLayonMask(  )
	self._bg_layOnMask:removeAllChildrenWithCleanup(true)
	local teamList = teamFunc.getTeamList()
	if self.swipIndex <= #teamList then
		local team = teamList[self.swipIndex]
		for i=2,5 do
			local petSet = self:createLuaSet(string.format("@mask_pet%d", i))
			self._bg_layOnMask:addChild(petSet[1])

			local nPet
			if i <= #team.PetIdList then
				nPet = petFunc.getPetWithId(team.PetIdList[i])
			end
			
			res.setNodeWithPetAuto(petSet, nPet, self)
			petSet["btnChange"]:setVisible(nPet ~= nil)
			petSet["btnInTeam"]:setVisible(nPet == nil)
			petSet["btnChange"]:setListener(function (  )
				self.switchId = team.PetIdList[i]
				self.switchPositionId = i
				print("self.switchId = " .. tostring(self.switchId))
				self._bg_btnMask:setVisible(false)
				self._bg_shield:setVisible(false)
				self._bg_layOnMask:setVisible(false)
				self:updateFriendList(false)
				self:updateTeamBattleValue()
				for k,v in pairs(self.petSet) do
					if v.page == self.swipIndex and v.positionId == self.switchPositionId then
						local nPet = self:getPetWithId(self.friendSelectedPetId)
						res.setNodeWithPetAuto(v.set, nPet, self)
						v.set["isFriend"]:setVisible(true)
						break
					end
				end
			end)
			petSet["btnInTeam"]:setListener(function (  )
				self.switchId = nil
				self.switchPositionId = i
				self._bg_btnMask:setVisible(false)
				self._bg_shield:setVisible(false)
				self._bg_layOnMask:setVisible(false)
				self:updateFriendList(false)
				self:updateTeamBattleValue()
				for k,v in pairs(self.petSet) do
					if v.page == self.swipIndex and v.positionId == self.switchPositionId then
						local nPet = self:getPetWithId(self.friendSelectedPetId)
						res.setNodeWithPetAuto(v.set, nPet, self)
						v.set["isFriend"]:setVisible(true)
						break
					end
				end
			end)
		end
	end
end

function DPrepareForStageBattle:updateTeamSwip(  )
	local maxCount = 6
	local teamList = teamFunc.getTeamList()
	self._bg_teamBg_clipSwip_teamSwip_linearlayout:removeAllChildrenWithCleanup(true)
	self._bg_teamBg_clipSwip_teamSwip:clearStayPoints()
	self.petSet = {}
	self._bg_teamBg_clipSwip_teamSwip:setTouchEnable(self.maxTeamCount > 1 and self.battleType ~= "limit_fuben")
	for teamId,team in ipairs(teamList) do
		if teamId > self.maxTeamCount then
			break
		end

		local teamSet = self:createLuaSet("@page")
		self._bg_teamBg_clipSwip_teamSwip_linearlayout:addChild(teamSet[1])
		local pageWidth = self._bg_teamBg_clipSwip_teamSwip_linearlayout:getContentSize().width
		self._bg_teamBg_clipSwip_teamSwip:addStayPoint(-pageWidth * (teamId - 1), 0)

		for i=1,maxCount do
			local petSet = self:createLuaSet("@pet")
			teamSet[1]:addChild(petSet[1])

			local nPet
			if i == maxCount then
				if team.BenchPetId > 0 then
					nPet = petFunc.getPetWithId(team.BenchPetId)
				end
			else
				if i <= #team.PetIdList then
					nPet = petFunc.getPetWithId(team.PetIdList[i])
				end
			end
			res.setNodeWithPetAuto(petSet, nPet, self)
			petSet["bench"]:setVisible(i == maxCount)
			petSet["isFriend"]:setVisible(false)
			table.insert(self.petSet, {page = teamId, positionId = i, set = petSet})
		end
	end
end

function DPrepareForStageBattle:updateSwipIndex(  )
	local teamList = teamFunc.getTeamList()
	self._bg_team:setString(res.getTeamIndexText(self.swipIndex))
	self._bg_teamBg_turnLeft:setVisible(self.swipIndex > 1 and self.battleType ~= "limit_fuben")
	self._bg_teamBg_btnTurnLeft:setVisible(self.swipIndex > 1 and self.battleType ~= "limit_fuben")
	self._bg_teamBg_turnRight:setVisible(self.swipIndex < self.maxTeamCount and self.battleType ~= "limit_fuben")
	self._bg_teamBg_btnTurnRight:setVisible(self.swipIndex < self.maxTeamCount and self.battleType ~= "limit_fuben")
	self:updateTeamBattleValue()
end

function DPrepareForStageBattle:updateTeamBattleValue(  )
	local teamList = teamFunc.getTeamList()
	local team = teamList[self.swipIndex]
	local power = team.CombatPower
	if teamFunc.getTeamActiveId() == self.swipIndex then
		power = teamFunc.getTeamCombatPower()
	end
	if self.friendSelectedPetId then
		local nPet = self:getPetWithId(self.friendSelectedPetId)
		power = power + nPet.Power	
	end
	if self.switchId then
		local nPet = petFunc.getPetWithId(self.switchId)
		power = power - nPet.Power
	end
	self._bg_layout1_value:setString(tostring(power))
end

function DPrepareForStageBattle:getPetWithId( nPetId )
	if self.battleType == "guildfuben" then
		return GuildCopyFunc.getGuildCopyPetWithId(nPetId)
	else
		return friendsFunc.getPetWithId(nPetId)
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPrepareForStageBattle, "DPrepareForStageBattle")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPrepareForStageBattle", DPrepareForStageBattle)
