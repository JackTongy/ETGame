local Config = require "Config"
local LuaList = require "LuaList"
local dbManager = require "DBManager"
local res = require "Res"
local gameFunc = require "AppData"
local petFunc = gameFunc.getPetInfo()
local TownHelper = require 'TownHelper'
local netModel = require "netModel"

local DPetTicket = class(LuaDialog)

function DPetTicket:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPetTicket.cocos.zip")
    return self._factory:createDocument("DPetTicket.cocos")
end

--@@@@[[[[
function DPetTicket:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_baseLeft = set:getElfNode("bg_baseLeft")
    self._bg_baseLeft_list = set:getListNode("bg_baseLeft_list")
    self._layout = set:getLayoutNode("layout")
    self._icon = set:getElfNode("icon")
    self._starLayout = set:getLayoutNode("starLayout")
    self._highLight = set:getElfNode("highLight")
    self._btn = set:getButtonNode("btn")
    self._bg_baseRight = set:getElfNode("bg_baseRight")
    self._bg_baseRight_icon = set:getElfNode("bg_baseRight_icon")
    self._bg_baseRight_starLayout = set:getLayoutNode("bg_baseRight_starLayout")
    self._bg_baseRight_career = set:getElfNode("bg_baseRight_career")
    self._bg_baseRight_name = set:getLabelNode("bg_baseRight_name")
    self._bg_baseRight_layoutPiece_count = set:getLabelNode("bg_baseRight_layoutPiece_count")
    self._bg_baseRight_layoutTicket_count = set:getLabelNode("bg_baseRight_layoutTicket_count")
    self._bg_baseRight_layoutTicket_tip = set:getLabelNode("bg_baseRight_layoutTicket_tip")
    self._bg_baseRight_list = set:getListNode("bg_baseRight_list")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._name = set:getLabelNode("name")
    self._tip = set:getLabelNode("tip")
    self._btn = set:getButtonNode("btn")
    self._lock = set:getElfNode("lock")
    self._btnBattleSpeed = set:getClickNode("btnBattleSpeed")
    self._btnReset = set:getClickNode("btnReset")
    self._btnGoto = set:getClickNode("btnGoto")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._name = set:getLabelNode("name")
    self._tip = set:getLabelNode("tip")
    self._btn = set:getButtonNode("btn")
    self._lock = set:getElfNode("lock")
--    self._@sizePet = set:getElfNode("@sizePet")
--    self._@itemPet = set:getElfNode("@itemPet")
--    self._@star5 = set:getSimpleAnimateNode("@star5")
--    self._@itemget = set:getElfNode("@itemget")
--    self._@itemm = set:getElfNode("@itemm")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DPetTicket", function ( userData )
	-- if petFunc.hasPieces() then
	-- 	Launcher.Launching()
	-- else
	   	Launcher.callNet(netModel.getModelPetGetPieces(),function ( data )
	     		Launcher.Launching(data)   
	   	end)
	-- end
end)

function DPetTicket:onInit( userData, netData )
	if netData then
		petFunc.setPetPieces(netData.D.Pieces)   
	end
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)
	self:updateLayer()
	res.doActionDialogShow(self._bg)
end

function DPetTicket:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DPetTicket:updateLayer( ... )
	self:updateList()
	self:updatePetDetail()
end

function DPetTicket:updateList( ... )
	if not self.petList then
		self.petList = LuaList.new(self._bg_baseLeft_list, function ( ... )
			local sizeSet = self:createLuaSet("@sizePet")
			sizeSet["setList"] = {}
			for i=1,3 do
				local itemSet = self:createLuaSet("@itemPet")
				sizeSet["layout"]:addChild(itemSet[1])
				table.insert(sizeSet["setList"], itemSet)
			end
			return sizeSet
		end, function ( nodeLuaSet, dataList )
			local itemSetList = nodeLuaSet["setList"]
			for i,set in ipairs(itemSetList) do
				set[1]:setVisible(i <= #dataList)
				if i <= #dataList then
					local dbPet = dataList[i]
					res.setNodeWithPet(set["icon"], petFunc.getPetInfoByPetId(dbPet.id))
					require 'PetNodeHelper'.updateStarLayout(set["starLayout"], dbPet)
					set["highLight"]:setVisible(self.petIdSelected == dbPet.id)
					set["btn"]:setListener(function ( ... )
						self.petIdSelected = dbPet.id
						self:updateLayer()
					end)
				end
			end
		end)
	end

	local listData = self:getListData()
	local needLayout = self.petIdSelected == nil
	self.petIdSelected = self.petIdSelected or listData[1][1].id
	self.petList:update(listData, needLayout, 10)
end

function DPetTicket:getListData( ... )
	local list0 = {}
	local list = require "charactorConfig"
	for i,dbPet in ipairs(list) do
		if dbPet.capture_city and tonumber(dbPet.capture_city) == nil then
			table.insert(list0, dbPet)
		end
	end

	table.sort(list0, function ( dbPet1, dbPet2 )
		local ways1 = self:getWayData(dbPet1)
		local ways2 = self:getWayData(dbPet2)
		if ways1 and #ways1 > 0 and ways2 and #ways2 > 0 then
			local dbStage1 = dbManager.getInfoStage(ways1[1])
			local dbStage2 = dbManager.getInfoStage(ways2[1])
			if dbStage1 and dbStage2 then
				local dbTown1 = dbManager.getInfoTownConfig(dbStage1.TownId)
				local dbTown2 = dbManager.getInfoTownConfig(dbStage2.TownId)
				if dbTown1 and dbTown2 then
					return dbTown1.townorder < dbTown2.townorder
				end
			end
		end
	end)

	local result = {}
	for i,v in ipairs(list0) do
		local a = math.floor((i - 1) / 3 + 1)
		local b = math.floor((i - 1) % 3 + 1)
		result[a] = result[a] or {}
		result[a][b] = v
	end

	return result
end

function DPetTicket:updatePetDetail( ... )
	local dbPet = dbManager.getCharactor(self.petIdSelected)
	res.setNodeWithPet(self._bg_baseRight_icon, petFunc.getPetInfoByPetId(dbPet.id))
	require 'PetNodeHelper'.updateStarLayout(self._bg_baseRight_starLayout, dbPet)
	self._bg_baseRight_career:setResid(res.getPetCareerIcon(dbPet.atk_method_system))
	self._bg_baseRight_name:setString(dbPet.name)
	self._bg_baseRight_layoutPiece_count:setString(petFunc.getPetPieceAmount( dbPet.id ) .. "/" .. dbManager.getMixConfig(dbPet.star_level,dbPet.quality).Compose)
	local userFunc = gameFunc.getUserInfo()
	local vipLevel = userFunc.getVipLevel()
	self._bg_baseRight_layoutTicket_count:setString(userFunc.getData().FastTicket)
	
	local tipvisble = vipLevel < 2
	self._bg_baseRight_layoutTicket_tip:setVisible(tipvisble)
	if tipvisble then
		self._bg_baseRight_layoutTicket_tip:setString(string.format(res.locString("Dungeon$PetTicketCountTip"), math.min(vipLevel + 1, 2), dbManager.getVipInfo(vipLevel + 1).PetSweepTicket))
	end
	self:updateStageListData(self:getWayData(dbPet), function ( ... )
		self:updateGetWayList(dbPet)
	end)
end

function DPetTicket:updateGetWayList( dbPet )
	if not self.getWayList then
		self.getWayList = LuaList.new(self._bg_baseRight_list, function ( ... )
			return self:createLuaSet("@itemget")
		end, function ( set, data )
			local stageId = data
			local updateStagesFunc = function ( data )
				self.nStageList[data.D.Stage.StageId] = data.D.Stage
				self:updatePetDetail()
				require "EventCenter".eventInput("UpdatePetTicket")
			end
			TownHelper.updateSet(self,set,stageId,self.nStageList,updateStagesFunc,updateStagesFunc, true)
		end)
	end
	self.getWayList:update(self:getWayData(dbPet), true)
end

function DPetTicket:getWayData( dbPet )
	local towntype, stageids = unpack(string.split(dbPet.capture_city,'|'))
	local list = {}
	for i,v in ipairs(string.split(stageids,',')) do
		table.insert(list, tonumber(v))
	end
	return list
end

function DPetTicket:updateStageListData( stageIdList, refreshLayer )
	self.nStageList = self.nStageList or {}

	local list = {}
	for k,stageId in pairs(stageIdList) do
		if self.nStageList[stageId] == nil then -- 未解锁数据为unLock，不是nil
			table.insert(list, stageId)
		end
	end
	if list and #list > 0 then
		self:send(netModel.getModelGetStages(list), function ( data )
			if data.D.Stages then
				for k,v in pairs(list) do
					local canFind = false
					for _,nStage in pairs(data.D.Stages) do
						if v == nStage.StageId then
							self.nStageList[v] = nStage
							canFind = true
							 break
						end
					end
					if not canFind then
						self.nStageList[v] = "unLock"
					end
				end
			else
				for k,v in pairs(list) do
					self.nStageList[v] = "unLock"
				end
			end
			
			refreshLayer()
		end)
	else
		refreshLayer()
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPetTicket, "DPetTicket")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPetTicket", DPetTicket)


