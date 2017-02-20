local Config = require "Config"
local res = require 'Res'
local dbManager = require "DBManager"
local netModel = require 'netModel'
local TimeManager = require 'TimeManager'
local EventCenter = require "EventCenter"
local gameFunc = require 'AppData'
local exploreFunc = gameFunc.getExploreInfo()

local DExploreRob = class(LuaDialog)

function DExploreRob:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DExploreRob.cocos.zip")
    return self._factory:createDocument("DExploreRob.cocos")
end

--@@@@[[[[
function DExploreRob:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._root = set:getElfNode("root")
    self._root_serverName = set:getLabelNode("root_serverName")
    self._root_petIcon = set:getElfNode("root_petIcon")
    self._root_petName = set:getLabelNode("root_petName")
    self._root_petLv = set:getLabelNode("root_petLv")
    self._root_layoutTeamBattle_v = set:getLabelNode("root_layoutTeamBattle_v")
    self._root_btnRefresh = set:getClickNode("root_btnRefresh")
    self._root_btnRob = set:getClickNode("root_btnRob")
    self._root_layoutEnergyPoint_v = set:getLabelNode("root_layoutEnergyPoint_v")
    self._root_energyBg_process = set:getProgressNode("root_energyBg_process")
    self._root_energyTimer = set:getTimeNode("root_energyTimer")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register('DExploreRob',function ( userData )
	local rob = exploreFunc.getExploreRob()
	if rob.TargetPetId > 0 then
		Launcher.Launching()
	else
		GleeCore:toast(res.locString("Explore$canFindOpponent"))
	end
end)

function DExploreRob:onInit( userData, netData )
	self:setListenerEvent()
	self:updateLayer()
	res.doActionDialogShow(self._root)
	require "LangAdapter".LabelNodeAutoShrink( self._set:getLabelNode("root_btnRefresh_normal_#text"), 104 )
end

function DExploreRob:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DExploreRob:setListenerEvent( ... )
	local rob = exploreFunc.getExploreRob()
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._root, self)
	end)

	self._root_btnRefresh:setListener(function ( ... )
		self:send(netModel.getModelExploreSearch(), function ( data )
			if data and data.D then
				exploreFunc.setExploreRob(data.D.Data)
				self:updateLayer()
			end
		end)
	end)

	self._root_btnRob:setListener(function ( ... )
		self:send(netModel.getModelExploreRobStart(), function ( data )
			if data and data.D then
				exploreFunc.setExploreRob(data.D.Data)
				self:updateLayer()

				local startGameData = {}
				startGameData.type = "guildfuben_rob"
				startGameData.data = {}
				local teamFunc = require "AppData".getTeamInfo()
				local petFunc = require "AppData".getPetInfo()
				local teamList = teamFunc.getTeamList()
				local teamId = teamFunc.getTeamIdExploreAtkType()
				local atkPets = petFunc.getPetInfoWithTeamPets(teamList[teamId], petFunc.getPetList())
				startGameData.data.petList = petFunc.convertToBattlePetList( atkPets )
				startGameData.data.petBornIJList = teamFunc.getPosListExploreAtkType( teamList[teamId] )
				startGameData.data.enemyList = petFunc.convertToBattlePetList( data.D.Pets )
				startGameData.data.enemyBornIJList = teamFunc.getPosListExploreDefType( data.D.Team )
				startGameData.data.enemyName = rob.TargetName

				print("battle start____" .. startGameData.type)
				print(startGameData)
				EventCenter.eventInput("BattleStart", startGameData)
			end
		end)
	end)
end

function DExploreRob:updateLayer( ... )
	local rob = exploreFunc.getExploreRob()
	self._root_serverName:setString(rob.TargetServerName)
	local nPet = gameFunc.getPetInfo().getPetInfoByPetId(rob.TargetPetId, rob.TargetPetAwakeIndex)
	res.setNodeWithPet(self._root_petIcon, nPet)
	self._root_petName:setString(rob.TargetName)
	self._root_petLv:setString(rob.TargetPetLv)
	self._root_layoutTeamBattle_v:setString(rob.TargetDefPwr)

	self._root_btnRefresh:setEnabled(rob.Energy >= 1)
	self._root_btnRob:setEnabled(rob.Energy >= 5)
	local energyLimit = dbManager.getInfoDefaultConfig("RobManaLimit").Value
	self._root_layoutEnergyPoint_v:setString(string.format("%d/%d", rob.Energy, energyLimit))
	self._root_energyBg_process:setPercentage(rob.Energy * 100 / energyLimit)

	local timeLimit = dbManager.getInfoDefaultConfig("ManaRecoverTime").Value * 60
	local seconds = -math.floor(require "TimeListManager".getTimeUpToNow(rob.RecoverTime))
	seconds = math.max(seconds, 0)
	seconds = math.min(seconds, timeLimit)
	if rob.Energy < energyLimit and seconds > 0 then
		seconds = seconds + 1
		local date = self._root_energyTimer:getElfDate()
		date:setHourMinuteSecond(0, 0, seconds)
		self._root_energyTimer:setVisible(true)
		self._root_energyTimer:setUpdateRate(-1)
		self._root_energyTimer:addListener(function (  )
			rob.Energy = math.min(rob.Energy + 1, timeLimit)
			if rob.Energy == energyLimit then
				self._root_energyTimer:setUpdateRate(0)
				self._root_energyTimer:setVisible(false)
			else
				date:setHourMinuteSecond(0, 0, timeLimit)
			end
			self._root_layoutEnergyPoint_v:setString(string.format("%d/%d", rob.Energy, energyLimit))

			self:send(netModel.getModelExploreDataGet(), function ( data )
				if data and data.D then
					exploreFunc.setExploreRob(data.D.Data)
					self:updateLayer()
				end
			end)
		end)
	else
		self._root_energyTimer:setUpdateRate(0)
		self._root_energyTimer:setVisible(false)
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DExploreRob, "DExploreRob")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DExploreRob", DExploreRob)
