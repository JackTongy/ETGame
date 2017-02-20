local Config = require "Config"
local netModel = require "netModel"
local res = require "Res"
local dbManager = require "DBManager"
local gameFunc = require "AppData"
local teamFunc = gameFunc.getTeamInfo()
local petFunc = gameFunc.getPetInfo()
local unLockManager = require "UnlockManager"
local GBHelper = require "GBHelper"
local EventCenter = require "EventCenter"

local DArenaBattleArray = class(LuaDialog)

function DArenaBattleArray:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DArenaBattleArray.cocos.zip")
    return self._factory:createDocument("DArenaBattleArray.cocos")
end

--@@@@[[[[
function DArenaBattleArray:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_title = set:getLabelNode("commonDialog_cnt_title")
    self._commonDialog_cnt_team = set:getLabelNode("commonDialog_cnt_team")
    self._commonDialog_cnt_layoutBattleValue_v = set:getLabelNode("commonDialog_cnt_layoutBattleValue_v")
    self._commonDialog_cnt_btnTurnLeft = set:getButtonNode("commonDialog_cnt_btnTurnLeft")
    self._commonDialog_cnt_btnTurnLeft_title = set:getLabelNode("commonDialog_cnt_btnTurnLeft_title")
    self._commonDialog_cnt_btnTurnRight = set:getButtonNode("commonDialog_cnt_btnTurnRight")
    self._commonDialog_cnt_btnTurnRight_title = set:getLabelNode("commonDialog_cnt_btnTurnRight_title")
    self._commonDialog_cnt_bgBase = set:getElfNode("commonDialog_cnt_bgBase")
    self._commonDialog_cnt_bgBase_b1 = set:getElfNode("commonDialog_cnt_bgBase_b1")
    self._commonDialog_cnt_bgBase_btn1 = set:getButtonNode("commonDialog_cnt_bgBase_btn1")
    self._commonDialog_cnt_bgBase_b2 = set:getElfNode("commonDialog_cnt_bgBase_b2")
    self._commonDialog_cnt_bgBase_btn2 = set:getButtonNode("commonDialog_cnt_bgBase_btn2")
    self._commonDialog_cnt_bgBase_b3 = set:getElfNode("commonDialog_cnt_bgBase_b3")
    self._commonDialog_cnt_bgBase_btn3 = set:getButtonNode("commonDialog_cnt_bgBase_btn3")
    self._commonDialog_cnt_bgBase_b4 = set:getElfNode("commonDialog_cnt_bgBase_b4")
    self._commonDialog_cnt_bgBase_btn4 = set:getButtonNode("commonDialog_cnt_bgBase_btn4")
    self._commonDialog_cnt_bgBase_b5 = set:getElfNode("commonDialog_cnt_bgBase_b5")
    self._commonDialog_cnt_bgBase_btn5 = set:getButtonNode("commonDialog_cnt_bgBase_btn5")
    self._commonDialog_cnt_bgBase_b6 = set:getElfNode("commonDialog_cnt_bgBase_b6")
    self._commonDialog_cnt_bgBase_btn6 = set:getButtonNode("commonDialog_cnt_bgBase_btn6")
    self._commonDialog_cnt_bgBase_b7 = set:getElfNode("commonDialog_cnt_bgBase_b7")
    self._commonDialog_cnt_bgBase_btn7 = set:getButtonNode("commonDialog_cnt_bgBase_btn7")
    self._commonDialog_cnt_bgBase_b8 = set:getElfNode("commonDialog_cnt_bgBase_b8")
    self._commonDialog_cnt_bgBase_btn8 = set:getButtonNode("commonDialog_cnt_bgBase_btn8")
    self._commonDialog_cnt_bgBase_b9 = set:getElfNode("commonDialog_cnt_bgBase_b9")
    self._commonDialog_cnt_bgBase_btn9 = set:getButtonNode("commonDialog_cnt_bgBase_btn9")
    self._commonDialog_cnt_battleRoot = set:getElfNode("commonDialog_cnt_battleRoot")
    self._careerBg = set:getElfNode("careerBg")
    self._main = set:getElfNode("main")
    self._layout_career = set:getElfNode("layout_career")
    self._layout_name = set:getLabelNode("layout_name")
    self._commonDialog_cnt_btnSave = set:getClickNode("commonDialog_cnt_btnSave")
    self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
    self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
    self._commonDialog_tab = set:getElfNode("commonDialog_tab")
    self._commonDialog_tab_tabAtk = set:getTabNode("commonDialog_tab_tabAtk")
    self._commonDialog_tab_tabAtk_title = set:getLabelNode("commonDialog_tab_tabAtk_title")
    self._commonDialog_tab_tabAtk_point = set:getElfNode("commonDialog_tab_tabAtk_point")
    self._commonDialog_tab_tabDef = set:getTabNode("commonDialog_tab_tabDef")
    self._commonDialog_tab_tabDef_title = set:getLabelNode("commonDialog_tab_tabDef_title")
    self._commonDialog_tab_tabDef_point = set:getElfNode("commonDialog_tab_tabDef_point")
--    self._@pet = set:getElfNode("@pet")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DArenaBattleArray", function ( userData )
	if userData.type == "GuildBattle" then
		if GBHelper.canBattleArraySetting() then
			Launcher.Launching(data)
		end
	else
		Launcher.Launching(data)
	end
end)

function DArenaBattleArray:onInit( userData, netData )
	self.arrayType = userData.type		-- SelfLeague	OtherLeague  GuildBattle  ExploreRob  or nil(竞技场)

	self.posIdList = {}
	self.posIdList[1] = {}
	self.posIdList[2] = {}
	if self.arrayType == nil then
		self.onAtkTeamChange = userData.OnAtkTeamChange
		self.teamIdAtk = teamFunc.getTeamIdAtkType()
		self.teamIdDef = teamFunc.getTeamIdDefType()
	elseif self.arrayType == "SelfLeague" then
		self.teamIdLeagueAtk = teamFunc.getTeamIdCsTypeAtk() or 1
		self.teamIdLeagueDef = teamFunc.getTeamIdCsTypeDef() or 1
	elseif self.arrayType == "OtherLeague" then
		self._commonDialog_title_text:setString(res.locString("GuildBattle$troop"))
		self.team = userData.team
		self.nPetList = userData.nPetList
		self.isExploreRevenge = userData.isExploreRevenge
	elseif self.arrayType == "GuildBattle" then
	--	self._commonDialog_title_text:setString(res.locString("GuildBattle$troop"))
		local player = GBHelper.getGuildMatchPlayer()
		print("playerInfo_guild")
		print(player)
		self.teamIdGBAtk = player and player.AtkTeamId or 1
		self.teamIdGBDef = player and player.DefTeamId or 1
	elseif self.arrayType == "ExploreRob" then
		self._commonDialog_tab_tabAtk_title:setString(res.locString("Global$Def"))
		self._commonDialog_tab_tabDef_title:setString(res.locString("Global$Atk"))
		self.teamIdExploreDef = teamFunc.getTeamIdExploreDefType()
		self.teamIdExploreAtk = teamFunc.getTeamIdExploreAtkType()
	end
	require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
		if self.arrayType == "ExploreRob" then
			self._commonDialog_tab_tabAtk_title:setString("Kampf")
			self._commonDialog_tab_tabDef_title:setString("Wache")
		else
			self._commonDialog_tab_tabAtk_title:setString("Wache")
			self._commonDialog_tab_tabDef_title:setString("Kampf")			
		end
	end)

	self.tabIndexSelected = 1
	if unLockManager:isUnlock("Team3") then
		self.maxTeamCount = 3
	elseif unLockManager:isUnlock("Team2") then
		self.maxTeamCount = 2
	else
		self.maxTeamCount = 1
	end

	self:initPositionList()
	self:setListenerEvent()
	self:updateLayer()

	res.doActionDialogShow(self._commonDialog)
end

function DArenaBattleArray:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DArenaBattleArray:setListenerEvent( ... )
	self._commonDialog_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._commonDialog_tab_tabAtk:trigger(nil)
	self._commonDialog_tab_tabAtk_point:setVisible(false)
	self._commonDialog_tab_tabAtk:setListener(function ( ... )
		if self.arrayType ~= "OtherLeague" then
			if self.tabIndexSelected ~= 1 then
				self.tabIndexSelected = 1
				self.petIndex = nil
				self:updateLayer()
			end
		end
	end)

	self._commonDialog_tab_tabDef_point:setVisible(false)
	self._commonDialog_tab_tabDef:setListener(function ( ... )
		if self.arrayType ~= "OtherLeague" then
			if self.tabIndexSelected ~= 2 then
				self.tabIndexSelected = 2
				self.petIndex = nil
				self:updateLayer()
			end
		end
	end)

	self._commonDialog_tab_tabAtk:setVisible( self.arrayType ~= "OtherLeague" )
	self._commonDialog_tab_tabDef:setVisible( self.arrayType ~= "OtherLeague" )

	self._commonDialog_cnt_btnTurnLeft:setListener(function ( ... )
		if self.arrayType == "SelfLeague" then
			if self.tabIndexSelected == 1 then
				self.teamIdLeagueAtk = math.max(self.teamIdLeagueAtk - 1, 1)
			elseif self.tabIndexSelected == 2 then
				self.teamIdLeagueDef = math.max(self.teamIdLeagueDef - 1, 1)
			end
		elseif self.arrayType == "GuildBattle" then
			if self.tabIndexSelected == 1 then
				self.teamIdGBAtk = math.max(self.teamIdGBAtk - 1, 1)
			elseif self.tabIndexSelected == 2 then
				self.teamIdGBDef = math.max(self.teamIdGBDef - 1, 1)
			end
		elseif self.arrayType == "ExploreRob" then
			if self.tabIndexSelected == 1 then
				self.teamIdExploreDef = math.max(self.teamIdExploreDef - 1, 1)
			elseif self.tabIndexSelected == 2 then
				self.teamIdExploreAtk = math.max(self.teamIdExploreAtk - 1, 1)
			end			
		elseif self.arrayType == nil then
			if self.tabIndexSelected == 1 then
				self.teamIdAtk = math.max(self.teamIdAtk - 1, 1)
			elseif self.tabIndexSelected == 2 then
				self.teamIdDef = math.max(self.teamIdDef - 1, 1)
			end
		end
		self.petIndex = nil
		self:updateLayer()
	end)

	require 'LangAdapter'.selectLang(nil, nil, function ( ... )
		self._commonDialog_cnt_btnTurnLeft_title:setDimensions(CCSize(30, 0))
		self._commonDialog_cnt_btnTurnRight_title:setDimensions(CCSize(30, 0))
	end, nil, function ( ... )
		self._commonDialog_cnt_btnTurnLeft_title:setDimensions(CCSize(0, 0))
		self._commonDialog_cnt_btnTurnRight_title:setDimensions(CCSize(0, 0))
		self._commonDialog_cnt_btnTurnLeft_title:setRotation(90)
		self._commonDialog_cnt_btnTurnRight_title:setRotation(90)
	end, function ( ... )
		self._commonDialog_cnt_btnTurnLeft_title:setDimensions(CCSize(0, 0))
		self._commonDialog_cnt_btnTurnRight_title:setDimensions(CCSize(0, 0))
		self._commonDialog_cnt_btnTurnLeft_title:setRotation(90)
		self._commonDialog_cnt_btnTurnRight_title:setRotation(90)
	end, function ( ... )
		self._commonDialog_cnt_btnTurnLeft_title:setDimensions(CCSize(0, 0))
		self._commonDialog_cnt_btnTurnRight_title:setDimensions(CCSize(0, 0))
		self._commonDialog_cnt_btnTurnLeft_title:setRotation(90)
		self._commonDialog_cnt_btnTurnRight_title:setRotation(90)
	end)

	self._commonDialog_cnt_btnTurnRight:setListener(function ( ... )
		if self.arrayType == "SelfLeague" then
			if self.tabIndexSelected == 1 then
				self.teamIdLeagueAtk = math.min(self.teamIdLeagueAtk + 1, self.maxTeamCount)
			elseif self.tabIndexSelected == 2 then
				self.teamIdLeagueDef = math.min(self.teamIdLeagueDef + 1, self.maxTeamCount)
			end
		elseif self.arrayType == "GuildBattle" then
			if self.tabIndexSelected == 1 then
				self.teamIdGBAtk = math.min(self.teamIdGBAtk + 1, self.maxTeamCount)
			elseif self.tabIndexSelected == 2 then
				self.teamIdGBDef = math.min(self.teamIdGBDef + 1, self.maxTeamCount)
			end
		elseif self.arrayType == "ExploreRob" then
			if self.tabIndexSelected == 1 then
				self.teamIdExploreDef = math.min(self.teamIdExploreDef + 1, self.maxTeamCount)
			elseif self.tabIndexSelected == 2 then
				self.teamIdExploreAtk = math.min(self.teamIdExploreAtk + 1, self.maxTeamCount)
			end
		elseif self.arrayType == nil then
			if self.tabIndexSelected == 1 then
				self.teamIdAtk = math.min(self.teamIdAtk + 1, self.maxTeamCount)
			elseif self.tabIndexSelected == 2 then
				self.teamIdDef = math.min(self.teamIdDef + 1, self.maxTeamCount)
			end
		end
		self.petIndex = nil
		self:updateLayer()
	end)

	for i=1,9 do
		self[string.format("_commonDialog_cnt_bgBase_btn%d", i)]:setVisible(self.team == nil)
		self[string.format("_commonDialog_cnt_bgBase_btn%d", i)]:setListener(function ( ... )
			local posIdList = self.posIdList[self.tabIndexSelected][self:getTeamId()]
			if self.petIndex == nil then
				if table.find(posIdList, i) then
					self.petIndex = i
				end
			else
				if self.petIndex ~= i then
					local now = table.keyOfItem(posIdList, i)
					local last = table.keyOfItem(posIdList, self.petIndex)

					posIdList[last] = i
					if now then
						posIdList[now] = self.petIndex
					end
					self.petIndex = nil
				else
					self.petIndex = nil
				end
			end
			self:updateBattleCenter()
		end)
	end

	self._commonDialog_cnt_btnSave:setVisible(self.team == nil)
	self._commonDialog_cnt_btnSave:setListener(function ( ... )
		if self.arrayType == nil then
			local atkType, defType
			local teamId = self:getTeamId()
			if self.tabIndexSelected == 1 then
				atkType = self.posIdList[self.tabIndexSelected][teamId]
			elseif self.tabIndexSelected == 2 then
				defType = self.posIdList[self.tabIndexSelected][teamId]
			end
			self:send(netModel.getModelTeamTypeUpdate(teamId, atkType, defType), function ( data )
				if data and data.D then
					teamFunc.setTeamList(data.D.Teams)
					self:toast(res.locString("ArenaBattleArray$saveTip"))

					if atkType and self.onAtkTeamChange then
						local team = self:getTeamSelected()
						local pets = {}
						for _,v in ipairs(team.PetIdList) do
							table.insert(pets,petFunc.getPetWithId(v))
						end
						local benchPet =petFunc.getPetWithId(team.BenchPetId)
						if benchPet then
							pets[6] = benchPet
						end
						self.onAtkTeamChange(pets, team.CombatPower)
					end
				end
			end)
		elseif self.arrayType == "SelfLeague" then
			local teamId = self:getTeamId()
			self:send(netModel.getModelTeamSetCsType( teamId, self.posIdList[self.tabIndexSelected][teamId], self.tabIndexSelected == 1 ), function ( data )
				if data and data.D then
					teamFunc.setTeamList(data.D.Teams)
					self:toast(res.locString("ArenaBattleArray$saveTip"))
				end
			end)
		elseif self.arrayType == "GuildBattle" then
			local teamId = self:getTeamId()
			local modelSave
			if self.tabIndexSelected == 1 then
				modelSave = netModel.getModelGuildMatchSetAtkTeam
			elseif self.tabIndexSelected == 2 then
				modelSave = netModel.getModelGuildMatchSetDefTeam
			end
			self:send(modelSave(teamId, self.posIdList[self.tabIndexSelected][teamId]), function ( data )
				if data and data.D then
					GBHelper.setGuildMatchPlayer( data.D.Player )
					self:toast(res.locString("ArenaBattleArray$saveTip"))
				end
			end)
		elseif self.arrayType == "ExploreRob" then
			local teamId = self:getTeamId()
			local modelSave
			if self.tabIndexSelected == 1 then
				modelSave = netModel.getModelExploreDefSet
			elseif self.tabIndexSelected == 2 then
				modelSave = netModel.getModelExploreAtkSet
			end
			self:send(modelSave(teamId, self.posIdList[self.tabIndexSelected][teamId]), function ( data )
				if data and data.D then
					teamFunc.setTeamList(data.D.Teams)
					self:toast(res.locString("ArenaBattleArray$saveTip"))
					EventCenter.eventInput("UpdateExploreBattleArray")
				end
			end)
		end
	end)
end

function DArenaBattleArray:updateLayer( ... )
	print("self.tabIndexSelected = " .. self.tabIndexSelected )
	self._commonDialog_cnt_title:setVisible(self.arrayType ~= "OtherLeague")
	if self.arrayType ~= "ExploreRob" then
		self._commonDialog_cnt_title:setString( res.locString(string.format("ArenaBattleArray$title%d", self.tabIndexSelected)) )
	else
		self._commonDialog_cnt_title:setString( res.locString(string.format("ArenaBattleArray$title%d", self.tabIndexSelected == 1 and 2 or 1)) )
	end

	self._commonDialog_cnt_team:setString( res.locString(string.format("Team$TeamIndex%d", self:getTeamId())) )
	self:updateTeamBattleValue()
	self:updateTeamBtn()
	self:updateBattleCenter()
	self:updateTabNameColor()
	print("self.tabIndexSelected2 = " .. self.tabIndexSelected )
end

function DArenaBattleArray:updateTabNameColor( ... )
	local tabNameList = {
		self._commonDialog_tab_tabAtk_title,
		self._commonDialog_tab_tabDef_title,
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

function DArenaBattleArray:updateTeamBattleValue(  )
	local team = self:getTeamSelected()
	local power = team.CombatPower

	if not self.team and team.Active then
		power = teamFunc.getTeamCombatPower()
	end

	self._commonDialog_cnt_layoutBattleValue_v:setString( power )
end

function DArenaBattleArray:updateTeamBtn( ... )
	self._commonDialog_cnt_btnTurnLeft:setVisible(self.arrayType ~= "OtherLeague" and self:getTeamId() > 1)
	self._commonDialog_cnt_btnTurnRight:setVisible(self.arrayType ~= "OtherLeague" and self:getTeamId() < self.maxTeamCount)
end

function DArenaBattleArray:getTeamId( ... )
	if self.arrayType == nil then
		if self.tabIndexSelected == 1 then
			return self.teamIdAtk
		elseif self.tabIndexSelected == 2 then
			return self.teamIdDef
		end
	elseif self.arrayType == "SelfLeague" then
		if self.tabIndexSelected == 1 then
			return self.teamIdLeagueAtk
		elseif self.tabIndexSelected == 2 then
			return self.teamIdLeagueDef
		end
	elseif self.arrayType == "OtherLeague" then
		return self.team.TeamId
	elseif self.arrayType == "GuildBattle" then
		if self.tabIndexSelected == 1 then
			return self.teamIdGBAtk
		elseif self.tabIndexSelected == 2 then
			return self.teamIdGBDef
		end
	elseif self.arrayType == "ExploreRob" then
		if self.tabIndexSelected == 1 then
			return self.teamIdExploreDef
		elseif self.tabIndexSelected == 2 then
			return self.teamIdExploreAtk
		end
	end
end

function DArenaBattleArray:getTeamSelected( ... )
	if self.team then
		return self.team
	else
		local teamList = teamFunc.getTeamList()
		return teamList[self:getTeamId()]	
	end
end

function DArenaBattleArray:getNetPetWithPetId( nPetId )
	if self.nPetList then
		for k,v in pairs(self.nPetList) do
			if v.Pid == nPetId then
				return v
			end
		end
	else
		return petFunc.getPetWithId(nPetId)
	end
end

function DArenaBattleArray:updateBattleCenter( ... )
	self._commonDialog_cnt_battleRoot:removeAllChildrenWithCleanup(true)
	local team = self:getTeamSelected()
	local petList = self:getPetListCanChange()
	local posIdList = self:getMapWithPetIdAndPosId()
	for i,v in ipairs(petList) do
		local nPet = self:getNetPetWithPetId(v)
		local node = self:getNpcUIModel(nPet)
		local posId = self:getPosIdWithPetId(posIdList, v)
		self._commonDialog_cnt_battleRoot:addChild(node, posId)
		node:setPosition(self.posList[posId])
	end

	print("posIdList-----")
	print(posIdList)
	if team and team.BenchPetId > 0 and (not self:getPosIdWithPetId(posIdList, team.BenchPetId)) then
		local nPet = self:getNetPetWithPetId(team.BenchPetId)
		local node = self:getNpcUIModel(nPet)
		self._commonDialog_cnt_battleRoot:addChild(node)
		node:setPosition(ccp(202.85715,-54.285713))
	end

	for i=1,9 do
		local visible = self.petIndex ~= nil and self.petIndex ~= i
		self[string.format("_commonDialog_cnt_bgBase_b%d", i)]:setVisible(visible)
	end	
end

 function DArenaBattleArray:getNpcUIModel( nPet )
	local iconView = require 'ActionView'.createActionViewById(nPet.PetId)
	if iconView then
		local monsterNode = iconView:getRootNode()
		monsterNode:setVisible(true)
		monsterNode:setScale(0.4)
		monsterNode:setPosition(ccp(0, -15))
		monsterNode:setTransitionMills(0)
		monsterNode:setBatchDraw(true)
		iconView:play("待机",-1)

		local petSet = self:createLuaSet("@pet")
		petSet["main"]:addChild(monsterNode)

		local dbPet = dbManager.getCharactor(nPet.PetId)
		petSet["layout_career"]:setResid(res.getPetCareerIcon(dbPet.atk_method_system))
		petSet["layout_name"]:setString(dbPet.name)

		petSet["careerBg"]:setResid(string.format("XT_zhiye_%d.png", dbPet.atk_method_system))
		petSet["careerBg"]:setScaleY(0.75)
		return petSet[1]
	end
 end

function DArenaBattleArray:initPositionList( ... )
	self.posList = {}
	for i=1,9 do
		local x, y = self[string.format("_commonDialog_cnt_bgBase_b%d", i)]:getPosition()
		table.insert(self.posList, ccp(x, y))
	end
end

function DArenaBattleArray:getMapWithPetIdAndPosId( )
	local teamId = self:getTeamId()
	local posIdList = self.posIdList[self.tabIndexSelected][teamId]
	local changeList = self:getPetListCanChange()
	if not posIdList then
		local team = self:getTeamSelected()
		if self.arrayType == nil then
			if self.tabIndexSelected == 1 then
				posIdList = team.AtkType
			elseif self.tabIndexSelected == 2 then
				posIdList = team.DefType
			end
		elseif self.arrayType == "SelfLeague" then
			if self.tabIndexSelected == 1 then
				posIdList = team.CsType
			elseif self.tabIndexSelected == 2 then
				posIdList = team.CsDefType
			end
		elseif self.arrayType == "OtherLeague" then
			if self.isExploreRevenge then
				posIdList = team.ExploreDefType
			else
				posIdList = team.CsDefType
			end
		elseif self.arrayType == "GuildBattle" then
			local player = GBHelper.getGuildMatchPlayer()
			if self.tabIndexSelected == 1 then
				posIdList = player.AtkType
			elseif self.tabIndexSelected == 2 then
				posIdList = player.DefType
			end
		elseif self.arrayType == "ExploreRob" then
			if self.tabIndexSelected == 1 then
				posIdList = team.ExploreDefType
			elseif self.tabIndexSelected == 2 then
				posIdList = team.ExploreAtkType
			end			
		end

		if not posIdList or #changeList > #posIdList then
			local temp = require "GridManager".getBornGridArray( self:getCareerListWithIdList( changeList ) )
			posIdList = {}
			for i,v in ipairs(temp) do
				table.insert(posIdList, (1 - v.j) * 3 + v.i )
			end
		end
		self.posIdList[self.tabIndexSelected][teamId] = posIdList
	end

	local result = {}
	for i,v in ipairs( changeList ) do
		result[v] = posIdList[i]
	end
	return result
end

function DArenaBattleArray:getPosIdWithPetId( posIdList, petId )
	if posIdList then
		for k,v in pairs(posIdList) do
			if k == petId then
				return v
			end
		end
	end
end

function DArenaBattleArray:getCareerListWithIdList( idList )
	local list = {}
	if idList then
		for i,v in ipairs(idList) do
			local nPet = self:getNetPetWithPetId(v)
			local dbPet = dbManager.getCharactor(nPet.PetId)
			table.insert(list, dbPet.atk_method_system)
		end
	end
	return list
end

function DArenaBattleArray:getPetListCanChange( ... )
	local team = self:getTeamSelected()
	local list = table.clone(team.PetIdList)
	if #team.PetIdList < 5 and team.BenchPetId > 0 then
		table.insert(list, team.BenchPetId)
	end
	return list
end

function DArenaBattleArray:getPetListWithTeamId( teamId )
	local teamList = teamFunc.getTeamList()
	local team = teamList[teamId]
	local list = table.clone(team.PetIdList)
	if team.BenchPetId > 0 then
		table.insert(list, team.BenchPetId)
	end
	return list
end

function DArenaBattleArray:isCareerEqual( index1, index2 )
	local posIdList = self.posIdList[self.tabIndexSelected][self:getTeamId()]
	local k1 = table.keyOfItem(posIdList, index1)
	local k2 = table.keyOfItem(posIdList, index2)
	if k1 and k2 then
		local petIdList = self:getPetListCanChange()
		local nPet1 = self:getNetPetWithPetId(petIdList[k1])
		local nPet2 = self:getNetPetWithPetId(petIdList[k2])
		local dbPet1 = dbManager.getCharactor(nPet1.PetId)
		local dbPet2 = dbManager.getCharactor(nPet2.PetId)
		return dbPet1.atk_method_system == dbPet2.atk_method_system
	else
		return true
	end
end

function DArenaBattleArray:getPetCareerSelected( ... )
	if self.petIndex then
		local posIdList = self.posIdList[self.tabIndexSelected][self:getTeamId()]
		local k1 = table.keyOfItem(posIdList, self.petIndex)
		if k1 then
			local petIdList = self:getPetListCanChange()
			local nPet = self:getNetPetWithPetId(petIdList[k1])
			local dbPet1 = dbManager.getCharactor(nPet.PetId)
			return dbPet1.atk_method_system
		end
	end
end

function DArenaBattleArray:getPetIdListWithPets( nPetList )
	local result = {}
	if nPetList then
		for i,v in ipairs(nPetList) do
			table.insert(result, v.Id)
		end
	end
	return result
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DArenaBattleArray, "DArenaBattleArray")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DArenaBattleArray", DArenaBattleArray)
