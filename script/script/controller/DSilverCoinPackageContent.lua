local Config = require "Config"
local dbManager = require "DBManager"
local res = require "Res"
local netModel = require "netModel"
local gameFunc = require "AppData"
local userFunc = gameFunc.getUserInfo()
local SilverCoinInfo = gameFunc.getSilverCoinInfo()

local DSilverCoinPackageContent = class(LuaDialog)

function DSilverCoinPackageContent:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DSilverCoinPackageContent.cocos.zip")
    return self._factory:createDocument("DSilverCoinPackageContent.cocos")
end

--@@@@[[[[
function DSilverCoinPackageContent:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getJoint9Node("bg")
    self._bg_layoutCoin = set:getLinearLayoutNode("bg_layoutCoin")
    self._bg_layoutCoin_count = set:getLabelNode("bg_layoutCoin_count")
    self._bg_btnClose = set:getClickNode("bg_btnClose")
    self._bg_btnClose_title = set:getLabelNode("bg_btnClose_title")
    self._bg_btnBuy = set:getClickNode("bg_btnBuy")
    self._bg_btnBuy_title = set:getLabelNode("bg_btnBuy_title")
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
function DSilverCoinPackageContent:onInit( userData, netData )
	self.RwdIndex = userData and userData.RwdIndex
	self.isLocked = userData and userData.isLocked
	self.callback = userData and userData.callback
	self:setListenerEvent()
	self:updateLayer()
	res.doActionDialogShow(self._bg)	
end

function DSilverCoinPackageContent:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DSilverCoinPackageContent:setListenerEvent( ... )
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_btnBuy:setListener(function ( ... )
		local rpList = dbManager.getInfoDefaultConfig("MysteryShopGiftConditions").Value
		local costList = dbManager.getInfoDefaultConfig("MysteryShopCoins").Value
		if SilverCoinInfo.getRecord().RpValue >= rpList[self.RwdIndex] then
			if userFunc.getCoin() >= costList[self.RwdIndex] then
				self:send(netModel.getModelMysteryShopBuyGift(self.RwdIndex), function ( data )
					if data and data.D then
						SilverCoinInfo.setRecord(data.D.Record)
						gameFunc.updateResource(data.D.Resource)
						res.doActionGetReward(data.D.Reward)
						self:updateLayer()
						res.doActionDialogHide(self._bg, function ( ... )
							if self.callback then
								self.callback()
							end
							self:close()
						end)
					end
				end)
			else
				require "Toolkit".showDialogOnCoinNotEnough()
			end
		else
			self:toast(string.format(res.locString("SilverCoinShop$RpNotEnough"), rpList[self.RwdIndex]))
		end
	end)
end

function DSilverCoinPackageContent:updateLayer( ... )
	local costList = dbManager.getInfoDefaultConfig("MysteryShopCoins").Value
	self._bg_layoutCoin_count:setString(costList[self.RwdIndex])
	self._bg_btnBuy:setEnabled(not self.isLocked)

	local rewardList = {}
	local rwdIdList = dbManager.getInfoDefaultConfig(string.format("MysteryShopGiftReward%d", self.RwdIndex)).Value
	if rwdIdList then
		for i,v in ipairs(rwdIdList) do
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

function DSilverCoinPackageContent:updateCell( item, v )
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
require 'framework.basic.MetaHelper'.classDefinitionEnd(DSilverCoinPackageContent, "DSilverCoinPackageContent")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DSilverCoinPackageContent", DSilverCoinPackageContent)


