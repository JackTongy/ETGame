local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local netModel = require "netModel"
local gameFunc = require "AppData"
local townFunc = gameFunc.getTownInfo()

local DAreaReward = class(LuaDialog)

function DAreaReward:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DAreaReward.cocos.zip")
    return self._factory:createDocument("DAreaReward.cocos")
end

--@@@@[[[[
function DAreaReward:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._root = set:getElfNode("root")
    self._root_title = set:getLabelNode("root_title")
    self._root_layoutStar = set:getLinearLayoutNode("root_layoutStar")
    self._root_layoutStar_count1 = set:getLabelNode("root_layoutStar_count1")
    self._root_layoutStar_count2 = set:getLabelNode("root_layoutStar_count2")
    self._root_layoutReward = set:getLayoutNode("root_layoutReward")
    self._icon = set:getElfNode("icon")
    self._name = set:getLabelNode("name")
    self._root_btnLeft = set:getButtonNode("root_btnLeft")
    self._root_btnRight = set:getButtonNode("root_btnRight")
    self._root_btnGet = set:getClickNode("root_btnGet")
--    self._@reward = set:getElfNode("@reward")
end
--@@@@]]]]

--------------------------------override functions----------------------

local Launcher = require 'Launcher'
Launcher.register("DAreaReward", function ( userData )
	local nAreaBoxList = townFunc.getAreaBoxList(userData.areaId)
	if nAreaBoxList and #nAreaBoxList > 0 then
		Launcher.Launching() 
	else
	   	Launcher.callNet(netModel.getModelAreaGetBox(userData.areaId), function ( data )
	   		print("AreaGetBox")
	   		print(data)
	   		Launcher.Launching(data)   
	 	end)
	end
end)

function DAreaReward:onInit( userData, netData )
	self.areaId = userData.areaId
	if netData and netData.D then
		townFunc.setAreaBoxList(netData.D.Boxes, self.areaId)
	end
	
	self:updateAreaBoxList()
	print("self.nAreaBoxList")
	print(self.nAreaBoxList)
	self.pageIndex = self:getFirstRewardPageId()

	self:updateLayer()
	self:setListenerEvent()
	res.doActionDialogShow(self._root)
end

function DAreaReward:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DAreaReward:getFirstRewardPageId( ... )
	local result = 1
	for i,nAreaBox in ipairs(self.nAreaBoxList) do
		if not nAreaBox.RewardGot then
			result = i
			break
		end
	end
	return result
end

function DAreaReward:updateAreaBoxList( ... )
	self.nAreaBoxList = table.clone(townFunc.getAreaBoxList(self.areaId))
	for i=#self.nAreaBoxList,1, -1 do
		if self.nAreaBoxList[i].RewardGot then
			table.remove(self.nAreaBoxList, i)
		end
	end
end

function DAreaReward:getRewardConfigId( ... )
	return self.nAreaBoxList[self.pageIndex].ConfigId
end

function DAreaReward:getDBAreaRewardWithId( configId )
	local dbAreaRewardList = dbManager.getAreaRewardConfig(self.areaId)
	for k,v in pairs(dbAreaRewardList) do
		if v.Id == configId then
			return v
		end
	end
	return nil
end

function DAreaReward:updateLayer(  )
	if self.nAreaBoxList and #self.nAreaBoxList > 0 then
		local areaId = self.areaId
		self._root_title:setString(dbManager.getArea(areaId).Name)
		self.pageIndex = math.min(math.max(self.pageIndex, 1), #self.nAreaBoxList)
		local configId = self:getRewardConfigId()
		print("self.pageIndex = " .. self.pageIndex)
		print("configId = " .. configId)
		local dbAreaRewardList = dbManager.getAreaRewardConfig(areaId)
		local dbAreaReward = self:getDBAreaRewardWithId(configId)
		self:updateReward(dbAreaReward.RewardIds)
		self._root_btnLeft:setVisible(self.pageIndex > 1)
		self._root_btnRight:setVisible(self.pageIndex < #self.nAreaBoxList)
		self._root_layoutStar_count1:setString(dbAreaReward.Stars)
		self._root_layoutStar_count2:setString(townFunc.getStarAmount(areaId))
		
		local nAreaBox = townFunc.getAreaBoxWithId(configId)
		self._root_btnGet:setEnabled(nAreaBox.Done)
	else
		res.doActionDialogHide(self._root, self)
	end
end

function DAreaReward:setListenerEvent( ... )
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._root, self)
	end)

	self._root_btnLeft:setListener(function ( ... )
		self.pageIndex = self.pageIndex - 1
		self:updateLayer()
	end)

	self._root_btnRight:setListener(function ( ... )
		self.pageIndex = self.pageIndex + 1
		self:updateLayer()
	end)

	self._root_btnGet:setListener(function ( ... )
		local configId = self:getRewardConfigId()
		local nAreaBox = townFunc.getAreaBoxWithId(configId)
		if nAreaBox.Done then
			self:send(netModel.getModelAreaGetReward(nAreaBox.Id), function ( data )
				print("AreaGetReward")
				print(data)
				if data and data.D then
					if data.D.Resource then
						gameFunc.updateResource(data.D.Resource)
					end
					if data.D.Box then
						townFunc.setAreaBox(data.D.Box)
						self:updateAreaBoxList()
					end
					self:updateLayer()
					res.doActionGetReward(data.D.Reward)

					require 'EventCenter'.eventInput("AreaBoxListUpdate")
				end
			end )
		else
			self:toast(res.locString("AreaReward$NotEnoughTip"))
		end
	end)
end

function DAreaReward:updateReward( rewardIdList )
	self._root_layoutReward:removeAllChildrenWithCleanup(true)
	for i,rewardId in ipairs(rewardIdList) do
		local set = self:createLuaSet("@reward")
		self._root_layoutReward:addChild(set[1])
		self:updateCell(set, rewardId)
	end
end

function DAreaReward:updateCell( item, rewardId )
	local dbReward = dbManager.getRewardItem(rewardId)
	if dbReward then
		if dbReward.itemtype == 6 then -- 精灵
			res.setNodeWithPet(item["icon"], gameFunc.getPetInfo().getPetInfoByPetId( dbReward.itemid ), dbReward.amount)
			local dbPet = dbManager.getCharactor(dbReward.itemid)
			item["name"]:setString(dbPet.name)
		elseif dbReward.itemtype == 7 then -- 装备
			local dbEquip = dbManager.getInfoEquipment(dbReward.itemid)
			res.setNodeWithEquip(item["icon"], dbEquip, dbReward.amount)
			item["name"]:setString(dbEquip.name)
		elseif dbReward.itemtype == 8 then -- 宝石
			local dbGem = dbManager.getInfoGem(dbReward.itemid)
			res.setNodeWithGem(item["icon"], dbGem.gemid, dbReward.args[1], dbReward.amount)
			item["name"]:setString(dbGem.name .. " Lv." .. dbReward.args[1])
		elseif dbReward.itemtype == 9 then -- 道具
			local dbMaterial = dbManager.getInfoMaterial(dbReward.itemid)
			res.setNodeWithMaterial(item["icon"], dbMaterial, dbReward.amount)
			item["name"]:setString(dbMaterial.name)
		elseif dbReward.itemtype == 1 then -- 金币
			res.setNodeWithGold(item["icon"], dbReward.amount)
			item["name"]:setString(res.locString("Global$Gold"))
		elseif dbReward.itemtype == 2 then -- 精灵石
			res.setNodeWithCoin(item["icon"], dbReward.amount)
			item["name"]:setString(res.locString("Global$Coin"))
		elseif dbReward.itemtype == 10 then -- 精灵碎片
			res.setNodeWithPetPiece(item["icon"], gameFunc.getPetInfo().getPetInfoByPetId( dbReward.itemid ), dbReward.amount)
			local dbPet = dbManager.getCharactor(dbReward.itemid)
			item["name"]:setString(dbPet.name)
		elseif dbReward.itemtype == 3 then -- 精灵之魂
			res.setNodeWithSoul(item["icon"], dbReward.amount)
			item["name"]:setString(res.locString("Global$Soul"))
		end

		require 'LangAdapter'.selectLang(nil, nil, function ( ... )
			item["name"]:setVisible(false)
		end, nil, function ( ... )
			item["name"]:setFontSize(20)
		end)
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DAreaReward, "DAreaReward")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DAreaReward", DAreaReward)


