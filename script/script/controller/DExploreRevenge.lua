local Config = require "Config"
local netModel = require "netModel"
local res = require "Res"
local EventCenter = require "EventCenter"

local DExploreRevenge = class(LuaDialog)

function DExploreRevenge:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DExploreRevenge.cocos.zip")
    return self._factory:createDocument("DExploreRevenge.cocos")
end

--@@@@[[[[
function DExploreRevenge:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._root = set:getElfNode("root")
    self._root_title2 = set:getRichLabelNode("root_title2")
    self._root_petIcon = set:getElfNode("root_petIcon")
    self._root_petLv = set:getLabelNode("root_petLv")
    self._root_petName = set:getLabelNode("root_petName")
    self._root_btn = set:getButtonNode("root_btn")
    self._root_serverName = set:getLabelNode("root_serverName")
    self._root_layoutTeamBattle_v = set:getLabelNode("root_layoutTeamBattle_v")
    self._root_tip = set:getLabelNode("root_tip")
    self._root_btnCancel = set:getClickNode("root_btnCancel")
    self._root_btnCancel_text = set:getLabelNode("root_btnCancel_text")
    self._root_btnRevenge = set:getClickNode("root_btnRevenge")
    self._root_btnRevenge_text = set:getLabelNode("root_btnRevenge_text")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register('DExploreRevenge',function ( userData )
	Launcher.callNet(netModel.getModelExploreRevengeGet(userData.SlotId),function (data)
		if data and data.D then
			Launcher.Launching(data)
		end
	end)
end)

function DExploreRevenge:onInit( userData, netData )
	local nRevenge = netData.D
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._root, self)
	end)

	local rob = require 'AppData'.getExploreInfo().getExploreRob()
	local battleValue = 0
	for k,v in pairs(rob.FPets) do
		battleValue = battleValue + v.Power
	end
	local value = (1 - math.floor( battleValue > 0 and (battleValue / 5000000 + 0.01) * 100 or 0 ) / 100) * 25
	self._root_title2:setString(string.format(res.locString("Explore$RevengeTitle2"), value))
	self._root_title2:setFontFillColor(ccc4f(0.1137,0.153,1.0,0.8706), true)
	for k,v in pairs(nRevenge.Pets) do
		if v.Id == nRevenge.Team.CaptainPetId then
			res.setNodeWithPet(self._root_petIcon, v)
			break
		end
	end
	
	self._root_petLv:setString(nRevenge.Lv)
	self._root_petName:setString(nRevenge.Name)
	self._root_btn:setListener(function ( ... )
		local param = {}
		param.type = "OtherLeague"
		param.team = nRevenge.Team
		param.nPetList = nRevenge.Pets
		for i,v in ipairs(param.nPetList) do
			param.nPetList[i].Pid = v.Id
		end
		param.isExploreRevenge = true
		GleeCore:showLayer("DArenaBattleArray", param)
	end)
	self._root_serverName:setString(nRevenge.ServerName)
	self._root_layoutTeamBattle_v:setString(nRevenge.Power)

	self._root_btnCancel:setListener(function ( ... )
		if userData.cancelCallback then
			userData.cancelCallback()
		end
		res.doActionDialogHide(self._root, self)
	end)

	self._root_btnRevenge:setListener(function ( ... )
		local startGameData = {}
		startGameData.type = "guildfuben_revenge"
		startGameData.data = {}
		local teamFunc = require "AppData".getTeamInfo()
		local petFunc = require "AppData".getPetInfo()
		local teamList = teamFunc.getTeamList()
		local teamId = teamFunc.getTeamIdExploreAtkType()
		local atkPets = petFunc.getPetInfoWithTeamPets(teamList[teamId], petFunc.getPetList())
		startGameData.data.petList = petFunc.convertToBattlePetList( atkPets )
		startGameData.data.petBornIJList = teamFunc.getPosListExploreAtkType( teamList[teamId] )
		startGameData.data.enemyList = petFunc.convertToBattlePetList( nRevenge.Pets )
		startGameData.data.enemyBornIJList = teamFunc.getPosListExploreDefType( nRevenge.Team )
		startGameData.data.SlotId = userData.SlotId
		startGameData.data.enemyName = nRevenge.Name

		print("battle start____" .. startGameData.type)
		print(startGameData)
		EventCenter.eventInput("BattleStart", startGameData)
	end)
	res.doActionDialogShow(self._root)

	res.adjustNodeWidth( self._set:getLabelNode("root_#title"), 300)
	self._set:getLinearLayoutNode("root_#layoutTeamBattle"):layout()
	res.adjustNodeWidth( self._set:getLinearLayoutNode("root_#layoutTeamBattle"), 300)

	require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,nil,function ( ... )
		self._set:getLabelNode("root_tip"):setAnchorPoint(ccp(0.5, 0))
	end)
end

function DExploreRevenge:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DExploreRevenge, "DExploreRevenge")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DExploreRevenge", DExploreRevenge)
