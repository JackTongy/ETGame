local Config = require "Config"
local res = require "Res"
local netModel = require "netModel"
local gameFunc = require "AppData"
local petFunc = gameFunc.getPetInfo()
local lvLimit = 10

local DPrepareForChampionBattle = class(LuaDialog)

function DPrepareForChampionBattle:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPrepareForChampionBattle.cocos.zip")
    return self._factory:createDocument("DPrepareForChampionBattle.cocos")
end

--@@@@[[[[
function DPrepareForChampionBattle:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._bg = set:getElfNode("bg")
   self._bg_tip = set:getLabelNode("bg_tip")
   self._bg_teamBg = set:getElfNode("bg_teamBg")
   self._icon = set:getElfNode("icon")
   self._hpBg = set:getElfNode("hpBg")
   self._hpBg_hpPro = set:getProgressNode("hpBg_hpPro")
   self._career = set:getElfNode("career")
   self._property = set:getElfNode("property")
   self._lv = set:getLabelNode("lv")
   self._starLayout = set:getLayoutNode("starLayout")
   self._btn = set:getClickNode("btn")
   self._icon = set:getElfNode("icon")
   self._hpBg = set:getElfNode("hpBg")
   self._hpBg_hpPro = set:getProgressNode("hpBg_hpPro")
   self._career = set:getElfNode("career")
   self._property = set:getElfNode("property")
   self._lv = set:getLabelNode("lv")
   self._starLayout = set:getLayoutNode("starLayout")
   self._btn = set:getClickNode("btn")
   self._icon = set:getElfNode("icon")
   self._hpBg = set:getElfNode("hpBg")
   self._hpBg_hpPro = set:getProgressNode("hpBg_hpPro")
   self._career = set:getElfNode("career")
   self._property = set:getElfNode("property")
   self._lv = set:getLabelNode("lv")
   self._starLayout = set:getLayoutNode("starLayout")
   self._btn = set:getClickNode("btn")
   self._icon = set:getElfNode("icon")
   self._hpBg = set:getElfNode("hpBg")
   self._hpBg_hpPro = set:getProgressNode("hpBg_hpPro")
   self._career = set:getElfNode("career")
   self._property = set:getElfNode("property")
   self._lv = set:getLabelNode("lv")
   self._starLayout = set:getLayoutNode("starLayout")
   self._btn = set:getClickNode("btn")
   self._icon = set:getElfNode("icon")
   self._hpBg = set:getElfNode("hpBg")
   self._hpBg_hpPro = set:getProgressNode("hpBg_hpPro")
   self._career = set:getElfNode("career")
   self._property = set:getElfNode("property")
   self._lv = set:getLabelNode("lv")
   self._starLayout = set:getLayoutNode("starLayout")
   self._btn = set:getClickNode("btn")
   self._icon = set:getElfNode("icon")
   self._hpBg = set:getElfNode("hpBg")
   self._hpBg_hpPro = set:getProgressNode("hpBg_hpPro")
   self._career = set:getElfNode("career")
   self._property = set:getElfNode("property")
   self._lv = set:getLabelNode("lv")
   self._starLayout = set:getLayoutNode("starLayout")
   self._btn = set:getClickNode("btn")
   self._bg_petListTitle = set:getLabelNode("bg_petListTitle")
   self._bg_petListBg_list = set:getListNode("bg_petListBg_list")
   self._layout = set:getLayoutNode("layout")
   self._icon = set:getElfNode("icon")
   self._hpBg = set:getElfNode("hpBg")
   self._hpBg_hpPro = set:getProgressNode("hpBg_hpPro")
   self._career = set:getElfNode("career")
   self._property = set:getElfNode("property")
   self._lv = set:getLabelNode("lv")
   self._starLayout = set:getLayoutNode("starLayout")
   self._choseOrDead = set:getElfNode("choseOrDead")
   self._btn = set:getClickNode("btn")
   self._bg_btnBattle = set:getClickNode("bg_btnBattle")
   self._bg_btnCancel = set:getClickNode("bg_btnCancel")
--   self._@pet1 = set:getElfNode("@pet1")
--   self._@star = set:getElfNode("@star")
--   self._@pet2 = set:getElfNode("@pet2")
--   self._@star = set:getElfNode("@star")
--   self._@pet3 = set:getElfNode("@pet3")
--   self._@star = set:getElfNode("@star")
--   self._@pet4 = set:getElfNode("@pet4")
--   self._@star = set:getElfNode("@star")
--   self._@pet5 = set:getElfNode("@pet5")
--   self._@star = set:getElfNode("@star")
--   self._@pet6 = set:getElfNode("@pet6")
--   self._@star = set:getElfNode("@star")
--   self._@size = set:getElfNode("@size")
--   self._@pet = set:getElfNode("@pet")
--   self._@star = set:getElfNode("@star")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DPrepareForChampionBattle:onInit( userData, netData )
	require 'LangAdapter'.selectLang(nil, nil, function ( ... )
		self._bg_petListTitle:setFontSize(17)
	end, nil, function ( ... )
		self._bg_petListTitle:setRotation(90)
	end)

	self.clonePetList = table.clone(petFunc.getPetList())
	local topTower = userData
	self.bufferList = topTower.Buffs
	self.energyList = topTower.Energys
	if topTower.Hurts then -- 修改克隆后的己方精灵数据
		for k,v in pairs(topTower.Hurts) do
			local nPet = self:getClonePetWithPetId(tonumber(k))
			if nPet then
				-- nPet.HpMax = nPet.Hp
				-- nPet.Hp = v * nPet.HpMax
				local CSValueConverter = require "CSValueConverter"
				nPet.HpMax = CSValueConverter.toSHp(nPet._Hp)
				nPet.Hp = v * nPet.HpMax
				nPet._HpMax = CSValueConverter.toCHp(nPet.HpMax)
				nPet._Hp = CSValueConverter.toCHp(nPet.Hp)
			end
		end
	end

	self.npcTeam = topTower.Stages[topTower.N + 1].Pets
	self.aiTypes = topTower.Stages[topTower.N + 1].AiTypes
	self.petIsInTeamList = {}
	if topTower.Team then
		self.petIsInTeamList = table.clone(topTower.Team)		
	end

	if #self.petIsInTeamList == 0 then	-- 无精灵上阵时自动上阵激活队伍中的精灵
		local teamFunc = gameFunc.getTeamInfo()
		local teamActive = teamFunc.getTeamActive()
		self.petIsInTeamList = table.clone(teamActive.PetIdList)
		if teamActive.BenchPetId > 0 then
			table.insert(self.petIsInTeamList, teamActive.BenchPetId)
		end
	end

	self:checkTeamPetList()

	self:setListenerEvent()
	self:updateLayer()
end

function DPrepareForChampionBattle:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function DPrepareForChampionBattle:setListenerEvent(  )
	res.doActionDialogShow(self._bg)
	
	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)
	self._bg_btnCancel:setTriggleSound(res.Sound.back)
	self._bg_btnCancel:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)
	self._bg_btnBattle:setTriggleSound(res.Sound.yes)
	self._bg_btnBattle:setListener(function (  )
		local function startBattle( ... )
			local startGameData = {}
			startGameData.type = 'champion'
			startGameData.data = {}
			startGameData.data.myTeam = {}
			startGameData.data.npcTeam = {}
			for i,v in ipairs(self.petIsInTeamList) do
				if v > 0 then
					local nPet = self:getClonePetWithPetId(v)
					self:getPetWithBufferList(nPet, self.bufferList)
					self:getPetWithEnergy(nPet, self.energyList)
					dungeonData = petFunc.convertToDungeonDataEncode(nPet, false)
					table.insert(startGameData.data.myTeam, dungeonData)			
				end
			end

			self:updateNpcTeamWithAiTypes(self.aiTypes)
			for i,nPet in ipairs(self.npcTeam) do
				if nPet.Hp > 0 then
					dungeonData = petFunc.convertToDungeonData(nPet, false)
					table.insert(startGameData.data.npcTeam, dungeonData)
				end
			end
			print("startGameData:")
			print(startGameData)
			local EventCenter = require "EventCenter"
			EventCenter.eventInput("BattleStart", startGameData)	
		end

		self:send(netModel.getModelTopBattleStart(self.petIsInTeamList), function ( data )
			if data and data.D then
				self:updateClonePetList(data.D.Pets)
				startBattle()
			end
		end)
	end)
end

function DPrepareForChampionBattle:updateLayer( ... )
	self._bg_tip:setString(string.format(res.locString("Activity$ChampionLvLimitText"), lvLimit))
	local petList = {}
	self.nodeSetList = {}
	for i,v in ipairs(self.clonePetList) do
		if v.Lv >= lvLimit then
			table.insert(petList, v)
		end
	end
	table.sort(petList, function ( pet1, pet2 )
		local pet1IsInTeam = self:canFindPetInBattleTeam(pet1.Id)
		local pet2IsINTeam = self:canFindPetInBattleTeam(pet2.Id)
		if pet1IsInTeam and not pet2IsINTeam then
			return true
		elseif pet1IsInTeam == pet2IsINTeam then
			if pet1.Hp > 0 and pet2.Hp <= 0 then
				return true
			elseif pet2.Hp > 0 and pet1.Hp <= 0 then
				return false
			else
				if pet1.Lv == pet2.Lv then
					if pet1.AwakeIndex == pet2.AwakeIndex then
						if pet1.Star == pet2.Star then
							return pet1.Id < pet2.Id
						else
							return pet1.Star > pet2.Star
						end
					else
						return pet1.AwakeIndex > pet2.AwakeIndex
					end
				else
					return pet1.Lv > pet2.Lv
				end
			end
		end
	end)
	if petList and #petList > 0 then
		local container = self._bg_petListBg_list:getContainer()
		container:removeAllChildrenWithCleanup(true)
		local countOneLine = 6
		local sizePet
		for i,v in ipairs(petList) do
			if i % countOneLine == 1 then
				sizePet = self:createLuaSet("@size")
				container:addChild(sizePet[1])
			end
			local petSet = self:createLuaSet("@pet")
			table.insert(self.nodeSetList, v.Id, petSet)
			sizePet["layout"]:addChild(petSet[1])
			res.setNodeWithPetAuto(petSet, v, self)

			petSet["choseOrDead"]:setVisible(false)

			if v.Hp <= 0 then
				petSet["choseOrDead"]:setResid("N_ZJZT_yizhengwan.png")
				petSet["choseOrDead"]:setVisible(true)
			end
			petSet["hpBg_hpPro"]:setPercentage(v.Hp / v.HpMax * 100)

			if self:canFindPetInBattleTeam(v.Id) then
				petSet["choseOrDead"]:setResid("N_ZJZT_yixuanze .png")
				petSet["choseOrDead"]:setVisible(true)
			end
			petSet["btn"]:setEnabled( v.Hp > 0 )
			petSet["btn"]:setListener(function (  )
				if self:canFindPetInBattleTeam(v.Id) then
					for i,petId in ipairs(self.petIsInTeamList) do
						if petId == v.Id then
							self.petIsInTeamList[i] = 0
							self:checkTeamPetList()
						end
					end
					petSet["choseOrDead"]:setVisible(false)
				else
					local list = self:getPosListCanInsert()
					if list and #list > 0 then
						self.petIsInTeamList[list[1]] = v.Id 
						petSet["choseOrDead"]:setVisible(true)
						petSet["choseOrDead"]:setResid("N_ZJZT_yixuanze .png")
					end
				end
				self:updateBattleTeam()
			end)
		end
	end
	self:updateBattleTeam()

	require 'LangAdapter'.selectLang(nil,nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
		self._bg_petListTitle:setRotation(90)
		res.adjustNodeWidth( self._set:getLabelNode("bg_#title"), 120 )
		res.adjustNodeWidth( self._set:getLabelNode("bg_btnCancel_#text"), 96 )
	end)
end

function DPrepareForChampionBattle:updateBattleTeam( ... )
	self._bg_teamBg:removeAllChildrenWithCleanup(true)
	local power = 0
	if self.petIsInTeamList then
		for i=1,6 do
			local petSet = self:createLuaSet(string.format("@pet%d", i))
			self._bg_teamBg:addChild(petSet[1])
			if i <= #self.petIsInTeamList and self.petIsInTeamList[i] > 0 then
				local petId = self.petIsInTeamList[i]
				local nPet = self:getClonePetWithPetId(petId)
				res.setNodeWithPetAuto(petSet, nPet, self)
				petSet["hpBg_hpPro"]:setPercentage(nPet.Hp / nPet.HpMax * 100)
				petSet["btn"]:setListener(function (  )
					self.petIsInTeamList[i] = 0
					self:checkTeamPetList()

					self:updateBattleTeam()
					self.nodeSetList[petId]["choseOrDead"]:setVisible(false)
				end)
				power = power + nPet.Power
			else
				res.setNodeWithPetAuto(petSet, nil)
				petSet["hpBg"]:setVisible(false)
				petSet["btn"]:setVisible(false)
			end
		end
	end

	self._bg_btnBattle:setEnabled(self.petIsInTeamList and #self.petIsInTeamList > 0)
end

function DPrepareForChampionBattle:checkTeamPetList( ... )
	if self.petIsInTeamList then	-- 消除献祭等消失的精灵和不达到10级的精灵
		local canRemove = true
		for i=#self.petIsInTeamList,1,-1 do
			local nPet = self:getClonePetWithPetId(self.petIsInTeamList[i])
			if not (nPet and nPet.Lv >= lvLimit and nPet.Hp > 0) then
				if canRemove then
					table.remove(self.petIsInTeamList, i)
				else
					self.petIsInTeamList[i] = 0
				end
			else
				canRemove = false
			end
		end
	end
end

function DPrepareForChampionBattle:canFindPetInBattleTeam( petId )
	return petId > 0 and self.petIsInTeamList and table.find(self.petIsInTeamList, petId)
end

function DPrepareForChampionBattle:getClonePetWithPetId( id )
	if self.clonePetList then
		for k,v in pairs(self.clonePetList) do
			if v.Id == id then
				return v
			end
		end
	end
	return nil
end

function DPrepareForChampionBattle:getPetWithEnergy( nPet, energyList )
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

function DPrepareForChampionBattle:getPetWithBufferList( nPet, bufferList )
	local CSValueConverter = require 'CSValueConverter'
	for k,v in pairs(bufferList) do
		if v.Type == 1 then
			nPet._Atk = CSValueConverter.toC( CSValueConverter.toS(nPet._Atk) * (1 + v.Rate) )
		elseif v.Type == 2 then
			nPet._Def = CSValueConverter.toC( CSValueConverter.toS(nPet._Def) * (1 + v.Rate) )
		end
	end
	return nPet
end

function DPrepareForChampionBattle:updateNpcTeamWithAiTypes( aiTypes )
	if aiTypes then
		for i,v in ipairs(self.npcTeam) do
			if i <= #aiTypes then
				self.npcTeam[i].aiType = aiTypes[i]
			end
		end
	end
end

function DPrepareForChampionBattle:updateClonePetList( petList )
	if petList and self.clonePetList then
		for k,v in pairs(petList) do
			petFunc.convertToC(v)
			for i,clonePet in ipairs(self.clonePetList) do
				if v.Id == clonePet.Id then
					self.clonePetList[i] = v 
					break
				end
			end
		end
	end
end

function DPrepareForChampionBattle:getPosListCanInsert( ... )
	local list = {}
	if self.petIsInTeamList then
		for i=1,6 do
			if i <= #self.petIsInTeamList then
				if self.petIsInTeamList[i] == 0 then
					table.insert(list, i)
				end
			else
				table.insert(list, i)
			end
		end
	end
	return list
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPrepareForChampionBattle, "DPrepareForChampionBattle")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPrepareForChampionBattle", DPrepareForChampionBattle)


