local Config = require "Config"
local dbManager = require "DBManager"
local res = require "Res"
local netModel = require "netModel"
local gameFunc = require "AppData"
local itemMallFunc = gameFunc.getItemMallInfo()

local DMallItemBuy = class(LuaDialog)

function DMallItemBuy:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DMallItemBuy.cocos.zip")
    return self._factory:createDocument("DMallItemBuy.cocos")
end

--@@@@[[[[
function DMallItemBuy:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_bg = set:getJoint9Node("bg_bg")
    self._bg_titleBg_title = set:getLabelNode("bg_titleBg_title")
    self._bg_icon = set:getElfNode("bg_icon")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._piece = set:getElfNode("piece")
    self._icon = set:getElfNode("icon")
    self._star1 = set:getElfNode("star1")
    self._star2 = set:getElfNode("star2")
    self._star3 = set:getElfNode("star3")
    self._name = set:getLabelNode("name")
    self._index = set:getElfNode("index")
    self._index_num = set:getLabelNode("index_num")
    self._clear = set:getElfNode("clear")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._piece = set:getElfNode("piece")
    self._count = set:getLabelNode("count")
    self._title = set:getLabelNode("title")
    self._bg_btnPlus = set:getClickNode("bg_btnPlus")
    self._bg_btnSub = set:getClickNode("bg_btnSub")
    self._bg_btnPlusTen = set:getClickNode("bg_btnPlusTen")
    self._bg_btnSubTen = set:getClickNode("bg_btnSubTen")
    self._bg_btnOk = set:getClickNode("bg_btnOk")
    self._bg_btnOk_text = set:getLabelNode("bg_btnOk_text")
    self._bg_priceIcon = set:getElfNode("bg_priceIcon")
    self._bg_price = set:getLabelNode("bg_price")
    self._bg_input = set:getLabelNode("bg_input")
    self._bg_priceIcon2 = set:getElfNode("bg_priceIcon2")
    self._bg_money = set:getLabelNode("bg_money")
    self._bg_btnClose = set:getButtonNode("bg_btnClose")
--    self._@item = set:getElfNode("@item")
--    self._@timeLimitStage = set:getElfNode("@timeLimitStage")
--    self._@itemSilverCoin = set:getElfNode("@itemSilverCoin")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DMallItemBuy:onInit( userData, netData )
	res.doActionDialogShow(self._bg)
	
	--[[
		userData参数：
		itemType 		类型{"Material", "Good", ...}
		callback 		回调函数
		nGood			商品信息
		itemId 			道具配置ID
		count  			默认购买数，默认1
		isUse 			是否购买后立刻使用，默认false
		hbReward		红包/21点/(限时探险)数据//命运轮盘
	]]
	self.itemType = userData.itemType or "Material"
	if self.itemType == "Material" then
		local itemId = userData.itemId
		self.itemId = itemId
		local dbMaterial = dbManager.getInfoMaterial(itemId)
		local isDiscounting = itemMallFunc.isDiscounting()
		local discountPercent = itemMallFunc.getMaterialDiscount(itemId)
		if isDiscounting and discountPercent then
			self.price = dbMaterial.price * discountPercent
		else
			self.price = dbMaterial.price
		end
		self.countMax = 999					
		if dbMaterial.islimit > 0 then
			local userFunc = gameFunc.getUserInfo()
			local mlimitsText = dbManager.getVipInfo(userFunc.getVipLevel()).MLimits
			local limitList = string.split(mlimitsText, "|")
			for k,v in pairs(limitList) do
				local key, value = string.match(v, "(%d+)-(%d+)")
				if tonumber(key) == dbMaterial.materialid then
					self.countMax = math.max(tonumber(value) - itemMallFunc.getBuyRecordDm(dbMaterial.materialid), 0)
					break
				end
			end
		end
		self.count = math.min(self.countMax, userData.count or 1)
		self.isUse = userData.isUse or false
		self:updateMaterial(itemId)
		self.callback = userData.callback			-- 道具
	elseif self.itemType == "Good" then
		local nGood = userData.nGood
		self.itemId = nGood.Gid
		self.nGood = nGood
		self.countMax = 999
		if nGood.Lm > 1 then
			if nGood.Lm == 2 then
				self.countMax = math.max(nGood.Total - itemMallFunc.getBuyRecordDg(nGood.Gid), 0)
			elseif nGood.Lm == 3 then
				self.countMax = math.max(nGood.Total - itemMallFunc.getBuyRecordTg(nGood.Gid), 0)
			end
		end
		self.count = 1
		self.isUse = false
		self.price = nGood.Np
		self:updatePack(nGood)
		self.callback = userData.callback			-- 商品
	elseif self.itemType == "MaterialSale" then
		local itemId = userData.itemId
		self.itemId = itemId
		local dbMaterial = dbManager.getInfoMaterial(itemId)
		self.price = dbMaterial.Gold
		self.countMax = gameFunc.getBagInfo().getItemWithItemId(itemId).Amount
		self.count = self.countMax
		self:updateMaterialSale(itemId)
		self.callback = userData.callback	-- 出售道具
	elseif self.itemType == "RewardType" then		-- Reward解析的物品
		self.hbReward = userData.hbReward
		self.price = userData.hbPrice
		self.count = 1
		self.countMax = userData.hbAmtLimit
		self.callback = userData.callback
		self.costIcon = userData.costIcon or "N_TY_baoshi1.png"
		self.costIconScale = userData.costIconScale or 1
		self:updateRewardView()	
	elseif self.itemType == "TimeLimitExploreTicket" then	-- 限时探险门票
		self.price = userData.hbPrice
		self.count = 1
		self.countMax = userData.hbAmtLimit
		self:updateTimeLimitExploreTicket()
		self.callback = userData.callback	
	elseif self.itemType == "DestinyWheel" then		-- 命运轮盘钥匙
		self.price = userData.hbPrice
		self.count = 1
		self.countMax = userData.hbAmtLimit
		self:updateDestinyWheel()
		self.callback = userData.callback
	elseif self.itemType == "TimeLimitExploreStageBattleSpeed" then		-- 限时探险一键扫荡，显示关卡内容
		self.price = userData.hbPrice
		self.count = 1
		self.countMax = userData.hbAmtLimit
		self.callback = userData.callback
		self.nStage = userData.nStage
		self:updateTimeLimitExploreStageBattleSpeed()
	elseif self.itemType == "SilverCoinShop" then	-- 神秘商店出售得银币
		self.hbReward = userData.hbReward
		self.price = userData.hbPrice
		self.count = 1
		self.countMax = userData.hbAmtLimit
		self.callback = userData.callback
		self.showLimit = userData.showLimit
		self:updateSilverCoinShop()
	end
	self:setListenerEvent()

	require "LangAdapter".LabelNodeAutoShrink(self._bg_btnOk_text, 104)
end

function DMallItemBuy:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DMallItemBuy:updateMaterial( materialId )
	local dbMaterial = dbManager.getInfoMaterial(materialId)
	if dbMaterial then
		self._bg_titleBg_title:setString(dbMaterial.name)
		res.setNodeWithMaterial(self._bg_icon, dbMaterial)
		self._bg_price:setString(tostring(self.price))
		self:updateCount()
		self._bg_priceIcon:setResid("N_TY_baoshi1.png")
		self._bg_priceIcon2:setResid("N_TY_baoshi1.png")
	end
end

function DMallItemBuy:updatePack( nGood )
	self._bg_titleBg_title:setString(nGood.Name)
	res.setNodeWithPack(self._bg_icon)
	self._bg_price:setString(self.price)
	self:updateCount()
	self._bg_priceIcon:setResid("N_TY_baoshi1.png")
	self._bg_priceIcon2:setResid("N_TY_baoshi1.png")
end

function DMallItemBuy:updateMaterialSale( materialId )
	local dbMaterial = dbManager.getInfoMaterial(materialId)
	if dbMaterial then
		self._bg_titleBg_title:setString(res.locString("Global$Sale"))
		res.setNodeWithMaterial(self._bg_icon, dbMaterial)
		self._bg_price:setString(tostring(self.price))
		self:updateCount()
		self._bg_priceIcon:setResid("N_TY_jinbi1.png")
		self._bg_priceIcon2:setResid("N_TY_jinbi1.png")
	end
end

function DMallItemBuy:updateRewardView( ... )
	self._bg_price:setString(tostring(self.price))
	self:updateCount()
	self._bg_priceIcon:setResid(self.costIcon)
	self._bg_priceIcon2:setResid(self.costIcon)
	self._bg_priceIcon:setScale(self.costIconScale)
	self._bg_priceIcon2:setScale(self.costIconScale)

	local item = self:createLuaSet("@item")
	item[1]:setVisible(true)
	self._bg_icon:setResid("")
	self._bg_icon:removeAllChildrenWithCleanup(true)
	self._bg_icon:addChild(item[1])

	local v = self.hbReward
	local scaleOrigal = 110 / 155
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
	item["piece"]:setVisible(v.isPiece)
	self._bg_titleBg_title:setString(v.name)
end

function DMallItemBuy:updateTimeLimitExploreTicket( ... )
	self._bg_price:setString(tostring(self.price))
	self:updateCount()

	local item = self:createLuaSet("@item")
	item[1]:setVisible(true)
	self._bg_icon:setResid("")
	self._bg_icon:removeAllChildrenWithCleanup(true)
	self._bg_icon:addChild(item[1])

	local scaleOrigal = 110 / 155
	item["bg"]:setVisible(false)
	item["icon"]:setResid("material_62.png")
	item["icon"]:setScale(scaleOrigal)
	item["frame"]:setResid("N_ZB_biankuang3.png")
	item["frame"]:setScale(scaleOrigal)
	item["piece"]:setVisible(false)
	self._bg_titleBg_title:setString(res.locString("Activity$TimeLimitExploreTicketTitle"))
end

function DMallItemBuy:updateDestinyWheel( ... )
	self._bg_price:setString(tostring(self.price))
	self:updateCount()

	local item = self:createLuaSet("@item")
	item[1]:setVisible(true)
	self._bg_icon:setResid("")
	self._bg_icon:removeAllChildrenWithCleanup(true)
	self._bg_icon:addChild(item[1])

	local scaleOrigal = 110 / 155
	item["bg"]:setVisible(false)
	item["icon"]:setResid("material_63.png")
	item["icon"]:setScale(scaleOrigal)
	item["frame"]:setResid("N_ZB_biankuang5.png")
	item["frame"]:setScale(scaleOrigal)
	item["piece"]:setVisible(false)
	self._bg_titleBg_title:setString(res.locString("Activity$DestinyWheelKeyName"))
end

function DMallItemBuy:updateTimeLimitExploreStageBattleSpeed( ... )
	self._bg_price:setString(tostring(self.price))
	self:updateCount()
	
	self._bg_priceIcon:setResid("TX_ziyuan1.png")
	self._bg_priceIcon2:setResid("TX_ziyuan1.png")
	self._bg_priceIcon:setScale(0.9)
	self._bg_priceIcon2:setScale(0.9)

	local timeLimitStage = self:createLuaSet("@timeLimitStage")
	timeLimitStage[1]:setVisible(true)
	self._bg_icon:setResid("")
	self._bg_icon:removeAllChildrenWithCleanup(true)
	self._bg_icon:addChild(timeLimitStage[1])
	
	res.setNodeWithPet(timeLimitStage["icon"], gameFunc.getPetInfo().getPetInfoByPetId(self.nStage.petId))
	timeLimitStage["name"]:setString(self.nStage.name)
	timeLimitStage["index_num"]:setString(self.nStage.stageId)

	self._bg_titleBg_title:setString(res.locString("Town$BattleSpeed"))
end

function DMallItemBuy:updateSilverCoinShop( ... )
	self._bg_price:setString(tostring(self.price))
	self:updateCount()
	self._bg_priceIcon:setResid("SMSD_tubiao1.png")
	self._bg_priceIcon2:setResid("SMSD_tubiao1.png")
	self._bg_priceIcon:setScale(1)
	self._bg_priceIcon2:setScale(1)

	local item = self:createLuaSet("@itemSilverCoin")
	item[1]:setVisible(true)
	self._bg_icon:setResid("")
	self._bg_icon:removeAllChildrenWithCleanup(true)
	self._bg_icon:addChild(item[1])

	local v = self.hbReward
	local scaleOrigal = 110 / 155
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
	item["piece"]:setVisible(v.isPiece)
	item["count"]:setString(v.count)
	item["title"]:setString(res.locString("SilverCoinShop$CanBuyCount") .. self.showLimit )
	self._bg_titleBg_title:setString(v.name)
end

function DMallItemBuy:updateCount(  )
	self._bg_input:setString(tostring(self.count))
	self._bg_money:setString(tostring(self.count * self.price))

	self._bg_btnPlus:setEnabled(self.count < self.countMax)
	self._bg_btnSub:setEnabled(self.count > 1)
	self._bg_btnPlusTen:setEnabled(self.count < self.countMax)
	self._bg_btnSubTen:setEnabled(self.count > 1)
end

function DMallItemBuy:setListenerEvent(  )
	self._bg_btnPlus:setListener(function (  )
		self.count = self.count + 1
		self.count = math.min(self.count, self.countMax)
		self:updateCount()
	end)

	self._bg_btnSub:setListener(function (  )
		self.count = self.count - 1
		self.count = math.max(self.count, 1)
		self:updateCount()
	end)
	
	self._bg_btnPlusTen:setListener(function (  )
		self.count = self.count + 10
		self.count = math.min(self.count, self.countMax)
		self:updateCount()
	end)
	
	self._bg_btnSubTen:setListener(function (  )
		self.count = self.count - 10
		self.count = math.max(self.count, 1)
		self:updateCount()
	end)

	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)
	
	self._bg_btnClose:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_btnOk:setTriggleSound(res.Sound.yes)
	self._bg_btnOk:setListener(function (  )
		local callbackTypeList = {
			"RewardType",
			"TimeLimitExploreTicket",
			"DestinyWheel",
			"TimeLimitExploreStageBattleSpeed",
			"SilverCoinShop",
		}
		if self.itemType == "MaterialSale" then
			self:send(netModel.getModelMaterialSell(self.itemId, self.count), function ( data )
				print("MaterialSell data:")
				print(data)
				if data and data.D then
					if data.D.Role then
						gameFunc.getUserInfo().setData(data.D.Role)
					end
					if data.D.Material then
						gameFunc.getBagInfo().exchangeItem({data.D.Material})
					end

					res.doActionDialogHide(self._bg, self)
					
					self:toast(string.format(res.locString("Bag$SellEquipGetGold"), self.price * self.count))
					if self.callback then
						self.callback(data)
					end
				end
			end)
		elseif table.find(callbackTypeList, self.itemType) then
			if self.callback then
				self.callback({amt = self.count, closeBuyLayer = function ( ... )
					res.doActionDialogHide(self._bg, self)
				end})
			end
		else
			if gameFunc.getUserInfo().getCoin() >= self.count * self.price then
				if self.itemType == "Material" then
					self:send(netModel.getModelShopBuyMaterial(self.itemId, self.count, self.isUse), function ( data )
						print("ShopBuyMaterial data:")
						print(data)
						if data and data.D then
							gameFunc.updateResource(data.D.Resource)
							itemMallFunc.setBuyRecordDm(self.itemId, self.count)
							res.doActionDialogHide(self._bg, self)
							res.toastReward(data.D.Reward)
							if self.callback then
								self.callback(data)
							end						
						end
					end)
				elseif self.itemType == "Good" then
					self:send(netModel.getModelShopBuy(self.itemId, self.count), function ( data )
						print("ShopBuy data:")
						print(data)
						if data and data.D then
							gameFunc.updateResource(data.D.Resource)
							itemMallFunc.updateBuyRecord(self.nGood, self.count)

							res.doActionDialogHide(self._bg, self)
							res.toastReward(data.D.Reward)
							if self.callback then
								self.callback(data)
							end
						end
					end)
				end
			else
				require "Toolkit".showDialogOnCoinNotEnough()
			end
		end
	end)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DMallItemBuy, "DMallItemBuy")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DMallItemBuy", DMallItemBuy)


