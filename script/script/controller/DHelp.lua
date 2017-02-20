local Config = require "Config"
local dbManager = require "DBManager"
local res = require "Res"
local gameFunc = require "AppData"

local DHelp = class(LuaDialog)

function DHelp:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DHelp.cocos.zip")
    return self._factory:createDocument("DHelp.cocos")
end

--@@@@[[[[
function DHelp:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getJoint9Node("bg")
    self._bg_list = set:getListNode("bg_list")
    self._text = set:getLabelNode("text")
    self._text = set:getLabelNode("text")
    self._layoutReward = set:getLinearLayoutNode("layoutReward")
    self._icon = set:getElfNode("icon")
    self._count = set:getLabelNode("count")
    self._btn = set:getClickNode("btn")
    self._bg_btnClose = set:getButtonNode("bg_btnClose")
--    self._@title = set:getElfNode("@title")
--    self._@sep = set:getElfNode("@sep")
--    self._@title1 = set:getElfNode("@title1")
--    self._@content = set:getRichLabelNode("@content")
--    self._@layoutSize = set:getElfNode("@layoutSize")
--    self._@text = set:getLabelNode("@text")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------

local Launcher = require 'Launcher'
Launcher.register("DHelp", function ( userData )
	if userData and userData.type then
		local dbHelpList = dbManager.getHelpConfig(userData.type)
		if dbHelpList and #dbHelpList > 0 then
			Launcher.Launching(data)
		end
	end
end)

function DHelp:onInit( userData, netData )
	res.doActionDialogShow(self._bg)
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self.arenaRank = userData.arenaRank
	self:updateLayer(userData.type)
end

function DHelp:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DHelp:updateLayer( helpType )
	local dbHelpList = dbManager.getHelpConfig(helpType)
	if dbHelpList and #dbHelpList > 0 then
		self._bg_list:getContainer():removeAllChildrenWithCleanup(true)
	--	print(dbHelpList)
		for i, dbHelp in ipairs(dbHelpList) do
			if i == 1 then
				local titleSet = self:createLuaSet("@title")
				self._bg_list:getContainer():addChild(titleSet[1])
				titleSet["text"]:setString(dbHelp.title)

				self._bg_list:getContainer():addChild(self:createLuaSet("@sep")[1])
			end

			if dbHelp.subtitle then
				local title1Set = self:createLuaSet("@title1")
				self._bg_list:getContainer():addChild(title1Set[1])
				title1Set["text"]:setString(dbHelp.subtitle)
			end

			if dbHelp.details then
				local contentSet = self:createLuaSet("@content")
				self._bg_list:getContainer():addChild(contentSet[1])
				contentSet[1]:setFontFillColor(ccc4f(0.345, 0.18, 1.0, 0.53), true)		-- (g, b, a, r)
				 if helpType == "竞技场" and i == 1 and self.arenaRank and self.arenaRank > 0 then
				 	local honor, coin = self:getHonorCoinWithRank(self.arenaRank)
				 	contentSet[1]:setString(string.format(dbHelp.details, self.arenaRank, honor, coin))
				else
					contentSet[1]:setString(dbHelp.details)
				end
			end

			if dbHelp.reward then
				if #dbHelp.reward > 0 then
					self._bg_list:getContainer():addChild(self:createLuaSet("@sep")[1])
				end

				for i,rewardList in ipairs(dbHelp.reward) do
					local layoutSizeSet = self:createLuaSet("@layoutSize")
					self._bg_list:getContainer():addChild(layoutSizeSet[1])

					for i,rewardDes in ipairs(rewardList) do
						local rewardType = rewardDes[1]
						if rewardType == -1 then
							local textSet = self:createLuaSet("@text")
							layoutSizeSet["layoutReward"]:addChild(textSet[1])
							textSet[1]:setString(rewardDes[2])
						else
							local itemSet = self:createLuaSet("@item")
							layoutSizeSet["layoutReward"]:addChild(itemSet[1])
							itemSet["count"]:setString(rewardDes[3])

							local rewardId = rewardDes[2]
							if rewardType == 6 then -- 精灵
								res.setNodeWithPet(itemSet["icon"], gameFunc.getPetInfo().getPetInfoByPetId( rewardId ))
							elseif rewardType == 7 then -- 装备
								local dbEquip = dbManager.getInfoEquipment(rewardId)
								res.setNodeWithEquip(itemSet["icon"], dbEquip)
							elseif rewardType == 9 then -- 道具
								local dbMaterial = dbManager.getInfoMaterial(rewardId)
								res.setNodeWithMaterial(itemSet["icon"], dbMaterial)
							elseif rewardType == 1 then -- 金币
								res.setNodeWithGold(itemSet["icon"])
							elseif rewardType == 2 then -- 精灵石
								res.setNodeWithCoin(itemSet["icon"])
							elseif rewardType == 10 then -- 精灵碎片
								res.setNodeWithPetPiece(itemSet["icon"], gameFunc.getPetInfo().getPetInfoByPetId( rewardId ))
							elseif rewardType == 12 then -- 荣誉
								res.setNodeWithHonor(itemSet["icon"])
							end

							itemSet["btn"]:setListener(function ( ... )
								if rewardType == 6 then -- 精灵
									GleeCore:showLayer("DPetDetailV", {PetInfo = gameFunc.getPetInfo().getPetInfoByPetId(rewardId)})
								elseif rewardType == 7 then -- 装备
									GleeCore:showLayer("DEquipDetail",{nEquip = gameFunc.getEquipInfo().getEquipInfoByEquipmentID(rewardId)})
									-- GleeCore:showLayer("DEquipInfoWithNoGem", {EquipInfo = gameFunc.getEquipInfo().getEquipInfoByEquipmentID(rewardId)})
								elseif rewardType == 9 then -- 道具
									GleeCore:showLayer("DMaterialDetail", {materialId = rewardId})
								elseif rewardType == 10 then -- 精灵碎片
									GleeCore:showLayer("DPetDetailV", {PetInfo = gameFunc.getPetInfo().getPetInfoByPetId(rewardId)})
								end
							end)
						end					   
					end
				end
			end
		end
	end
end

function DHelp:getHonorCoinWithRank( rank )
	local honor = 0
	local coin = 0
	if rank and rank > 0 then
		if rank <= 5 then
			local temp = {3000, 2500, 2300, 2100, 2000}
			honor = temp[rank]
			local temp2 = {350, 300, 250, 210, 170}
			coin = temp2[rank]
		elseif rank <= 10 then
			honor = 2000 - (rank - 5) * 10
			coin = 140 - (rank - 6) * 10
		elseif rank <= 50 then
			honor = 1950 - (rank - 10) * 5
			coin = 90 - math.floor((rank - 10) / 10) * 5
		elseif rank <= 150 then
			honor = 1750 - (rank - 50) * 4
			coin = 65
		elseif rank <= 200 then
			honor = 1350 - (rank - 150) * 3
			coin = 60
		elseif rank <= 300 then
			honor = 1200 - (rank - 200) * 2
			coin = 55
		elseif rank <= 500 then
			honor = 1000 - (rank - 300) * 1
			coin = 50
		elseif rank <= 600 then
			honor = 800 - (rank - 500) * 0.5
			coin = 45
		elseif rank <= 700 then
			honor = 750 - (rank - 600) * 0.3
			coin = 40
		elseif rank <= 800 then
			honor = 720 - (rank - 700) * 0.2
			coin = 35
		elseif rank <= 5000 then
			honor = 700 - (rank - 800) * 0.1
			coin = 30
		elseif rank <= 6000 then
			honor = 280 - (rank - 5000) * 0.05
			coin = 25
		elseif rank <= 7000 then
			honor = 230 - (rank - 6000) * 0.03
			coin = 20
		elseif rank <= 16000 then
			honor = 200 - (rank - 7000) * 0.02
			coin = 15
		else
			honor = 20
			coin = 10
		end
	end
	return honor, coin
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DHelp, "DHelp")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DHelp", DHelp)
