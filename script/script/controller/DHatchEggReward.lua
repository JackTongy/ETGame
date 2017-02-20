local Config = require "Config"
local dbManager = require "DBManager"
local res = require "Res"
local netModel = require "netModel"
local HatchEggInfo = require "HatchEggInfo"

local DHatchEggReward = class(LuaDialog)

function DHatchEggReward:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DHatchEggReward.cocos.zip")
    return self._factory:createDocument("DHatchEggReward.cocos")
end

--@@@@[[[[
function DHatchEggReward:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getJoint9Node("bg")
    self._bg_layoutIntimate = set:getLinearLayoutNode("bg_layoutIntimate")
    self._bg_layoutIntimate_v = set:getLabelNode("bg_layoutIntimate_v")
    self._bg_btnOk = set:getClickNode("bg_btnOk")
    self._bg_btnOk_title = set:getLabelNode("bg_btnOk_title")
    self._bg_firstReward = set:getElfNode("bg_firstReward")
    self._hale = set:getElfNode("hale")
    self._hale2 = set:getElfNode("hale2")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._name = set:getLabelNode("name")
    self._count = set:getLabelNode("count")
    self._piece = set:getElfNode("piece")
    self._btn = set:getButtonNode("btn")
    self._bg_layoutReward = set:getLayoutNode("bg_layoutReward")
    self._bg_title = set:getLabelNode("bg_title")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DHatchEggReward", function ( userData )
	Launcher.callNet(netModel.getModelEggHatchGet(), function ( data )
		if data and data.D then
			HatchEggInfo.setMyData(data.D.MyData)
			HatchEggInfo.setTotal(data.D.Total)
			HatchEggInfo.setMyRank(data.D.MyRank)
			HatchEggInfo.setRanks(data.D.Ranks)
			Launcher.Launching()   
		end
	end)
end)

function DHatchEggReward:onInit( userData, netData )
	self.eggIndex = userData and userData.eggIndex or 1
	self:setListenerEvent()
	self:updateLayer()
	res.doActionDialogShow(self._bg)
end

function DHatchEggReward:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DHatchEggReward:setListenerEvent( ... )
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_btnOk:setListener(function ( ... )
		local intimateNeed = 1000
		if HatchEggInfo.getMyData().Energy >= intimateNeed then
			self:send(netModel.getModelEggHatchRwdGet(self.eggIndex), function ( data )
				if data and data.D then
					require "AppData".updateResource(data.D.Resource)
					HatchEggInfo.setMyData(data.D.MyData)
					res.doActionDialogHide(self._bg, self)
					res.doActionGetReward(data.D.Reward)
					require "EventCenter".eventInput("UpdateActivity")
				end
			end)
		else
			self:toast(string.format(res.locString("Activity$HatchEggGetRewardCondition"), intimateNeed))
		end
	end)
end

function DHatchEggReward:updateLayer( ... )
	local HatchEggConfig = require "AppData".getActivityInfo().getDataByType(46)
	local energyList = HatchEggInfo.getEnergyList()
	local energy = math.min(HatchEggInfo.getIntimateWithStep(self.eggIndex), energyList[self.eggIndex])
	self._bg_layoutIntimate_v:setString(string.format("%d/%d", energy, energyList[self.eggIndex]))
	self._bg_btnOk:setEnabled(not HatchEggInfo.isHatched(self.eggIndex) and energy >= energyList[self.eggIndex])
	self._bg_title:setString(self.eggIndex ~= 8 and res.locString("Activity$HatchEggTitle") or res.locString("Activity$HatchEggTitle2"))

	local rewardList = {}
	local eggReward = dbManager.getInfoEggReward(self.eggIndex)
	if eggReward and eggReward.RewardID then
		for i,v in ipairs(eggReward.RewardID) do
			local dbReward = dbManager.getRewardItem(v)
			table.insert(rewardList, res.getDetailByDBReward(dbReward))
		end
	end

	self._bg_firstReward:removeAllChildrenWithCleanup(true)
	self._bg_layoutReward:removeAllChildrenWithCleanup(true)
	for i,v in ipairs(rewardList) do
		local set = self:createLuaSet("@item")
		if i == 1 then
			self._bg_firstReward:addChild(set[1])
			self:updateCell(set, v)
			set["name"]:setVisible(true)
			set["hale"]:setVisible(true)
			set["hale"]:runAction(CCRepeatForever:create(CCRotateBy:create(1, 120)))
			set["hale2"]:setVisible(true)
			set["hale2"]:runAction(CCRepeatForever:create(CCRotateBy:create(1, 120)))
		else
			self._bg_layoutReward:addChild(set[1])
			self:updateCell(set, v)
		end
	end
end

function DHatchEggReward:updateCell( item, v )
	local scaleOrigal = 77.5 / 155
	if v.type == "Gem" then
		item["name"]:setString(v.name .. " Lv." .. v.lv)
	else
		item["name"]:setString(v.name)
	end

	item["bg"]:setResid(v.bg)
	item["bg"]:setScale(scaleOrigal)
	item["icon"]:setResid(v.icon)
	if v.type == "Pet" or v.type == "PetPiece" then
		item["icon"]:setScale(scaleOrigal * 140 / 95)
	else
		item["icon"]:setScale(scaleOrigal)
	end
	item["frame"]:setResid(v.frame)
	item["frame"]:setScale(scaleOrigal)
	item["count"]:setString(v.count)
	item["piece"]:setVisible(v.isPiece)

	res.addRuneStars( item["frame"], v )

	item["name"]:setVisible(false)
	item["hale"]:setVisible(false)
	item["hale2"]:setVisible(false)
	item["btn"]:setListener(function ( ... )
		if v.eventData then
			GleeCore:showLayer(v.eventData.dialog, v.eventData.data)
		end
	end)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DHatchEggReward, "DHatchEggReward")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DHatchEggReward", DHatchEggReward)
