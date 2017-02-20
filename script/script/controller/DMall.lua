local Config = require "Config"
local gameFunc = require "AppData"
local itemMallFunc = gameFunc.getItemMallInfo()
local netModel = require "netModel"
local bagFunc = gameFunc.getBagInfo()
local dbManager = require "DBManager"
local res = require "Res"
local LuaList = require "LuaList"
local eventCenter = require "EventCenter"
local TimeListManager = require "TimeListManager"
local eventCenter = require 'EventCenter'
local userFunc = gameFunc.getUserInfo()

local DMall = class(LuaDialog)

function DMall:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DMall.cocos.zip")
    return self._factory:createDocument("DMall.cocos")
end

--@@@@[[[[
function DMall:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_bg = set:getJoint9Node("commonDialog_cnt_bg")
    self._commonDialog_cnt_bg_list = set:getListNode("commonDialog_cnt_bg_list")
    self._layout = set:getLayoutNode("layout")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._iconFrame = set:getElfNode("iconFrame")
    self._state = set:getElfNode("state")
    self._name = set:getLabelNode("name")
    self._timer = set:getTimeNode("timer")
    self._count = set:getLabelNode("count")
    self._layoutPrice = set:getLinearLayoutNode("layoutPrice")
    self._layoutPrice_icon = set:getElfNode("layoutPrice_icon")
    self._layoutPrice_v1 = set:getLabelNode("layoutPrice_v1")
    self._layoutPrice_v1_line = set:getElfNode("layoutPrice_v1_line")
    self._layoutPrice_v2 = set:getLabelNode("layoutPrice_v2")
    self._btnBuy = set:getClickNode("btnBuy")
    self._btnDetail = set:getButtonNode("btnDetail")
    self._commonDialog_cnt_layoutMoney = set:getLinearLayoutNode("commonDialog_cnt_layoutMoney")
    self._commonDialog_cnt_layoutMoney_v0 = set:getLabelNode("commonDialog_cnt_layoutMoney_v0")
    self._commonDialog_cnt_layoutMoney_v1 = set:getLabelNode("commonDialog_cnt_layoutMoney_v1")
    self._commonDialog_cnt_layoutMoney_v2 = set:getLabelNode("commonDialog_cnt_layoutMoney_v2")
    self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
    self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
--    self._@size = set:getElfNode("@size")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

local Launcher = require 'Launcher'
Launcher.register("DMall", function ( userData )
	if userData and userData.dungeonRewardList then
		Launcher.Launching()
	else
		-- if not itemMallFunc.getGoods() then
		--    	Launcher.callNet(netModel.getModelShopGet(),function ( data )
		--      		Launcher.Launching(data)   
		--    	end)
		-- else
			Launcher.Launching()
		-- end	
	end
end)

--------------------------------override functions----------------------
-- userData数据：
-- dungeonRewardList 副本神秘商人的商品列表
-- callback 副本神秘商人的回调函数

function DMall:onInit( userData, netData )
	if netData and netData.D then
		itemMallFunc.setGoods(netData.D.Goods)
	end

	if userData then
		if userData.dungeonRewardList then
			self.dungeonRewardList = userData.dungeonRewardList
			self._commonDialog_title_text:setString(res.locString("Dungeon$SecretBusinesser"))
			require 'LangAdapter'.fontSize(self._commonDialog_title_text,nil,nil,nil,nil,nil,nil,nil,26)
		end
		if userData.callback then
			self.dungeonCallback = userData.callback
		end
	end

	res.doActionDialogShow(self._commonDialog)
	self:setListenerEvent()
	self:broadcastEvent()
	self:updateList(true)
	self:updateMoney()
	require 'GuideHelper':check('DMall')
end

function DMall:onBack( userData, netData )
	
end

function DMall:close(  )
	eventCenter.resetGroup("DMall")
end

--------------------------------custom code-----------------------------

function DMall:setListenerEvent(  )
	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._commonDialog_btnClose:setListener(function (  )
		res.doActionDialogHide(self._commonDialog, self)
	end)
end

function DMall:updateList( refresh )
	if not self.itemList then
		self.itemList = LuaList.new(self._commonDialog_cnt_bg_list, function (  )
			local sizeSet = self:createLuaSet("@size")
			sizeSet["setList"] = {}
			for i=1,4 do
				local itemSet = self:createLuaSet("@item")
				sizeSet["layout"]:addChild(itemSet[1])
				table.insert(sizeSet["setList"], itemSet)
			end
			return sizeSet
		end, function ( nodeLuaSet, dataList )
			local itemSetList = nodeLuaSet["setList"]
			for i,set in ipairs(itemSetList) do
				set[1]:setVisible(i <= #dataList)
				if i <= #dataList then
					local nItem = dataList[i]
					if nItem.itemType == "Material" then
						local dbMaterial = nItem.itemData
						set["icon"]:setResid(res.getMaterialIcon(dbMaterial.materialid))
						set["iconFrame"]:setResid(res.getMaterialIconFrame(dbMaterial.color))
						set["name"]:setString(dbMaterial.name)
						set["state"]:setResid("")

						local price = dbMaterial.price
						if dbMaterial.upable > 0 then
							price = dbMaterial.upprice[ itemMallFunc.getBuyRecordDm(dbMaterial.materialid) + 1 ]
						end
						local isDiscounting = itemMallFunc.isDiscounting()
						local discountPercent = itemMallFunc.getMaterialDiscount(dbMaterial.materialid)
						if isDiscounting and discountPercent then
							set["layoutPrice_v1"]:setString(price)
							set["layoutPrice_v1"]:setFontFillColor(ccc4f(0.396, 0.286, 0.247, 1.0), true)
							set["layoutPrice_v2"]:setString(price * discountPercent)
							set["layoutPrice_v2"]:setFontFillColor(ccc4f(0.89, 0.576, 0.196, 1.0), true)
							set["layoutPrice_v1_line"]:setVisible(true)
							set["layoutPrice_v1_line"]:setScale(set["layoutPrice_v1"]:getContentSize().width / set["layoutPrice_v1_line"]:getContentSize().width)
							set["state"]:setResid("N_SC_zhekou.png")
						else
							set["layoutPrice_v1"]:setString(price)
							set["layoutPrice_v1"]:setFontFillColor(ccc4f(0.89, 0.576, 0.196, 1.0), true)
							set["layoutPrice_v2"]:setString("")
							set["layoutPrice_v1_line"]:setVisible(false)
						end

						set["timer"]:setVisible(false)

						-- vip限购
						set["count"]:setVisible(false)

						local function getLimitCount( ... )
							local limitCount
							if dbMaterial.islimit > 0 then
								local mlimitsText = dbManager.getVipInfo(userFunc.getVipLevel()).MLimits
								local limitList = string.split(mlimitsText, "|")
								for k,v in pairs(limitList) do
	  								local key, value = string.match(v, "(%d+)-(%d+)")
									if tonumber(key) == dbMaterial.materialid then
										limitCount = tonumber(value)
										break
									end
								end
								if limitCount then
									limitCount = math.max(limitCount - itemMallFunc.getBuyRecordDm(dbMaterial.materialid), 0)
								end
							end
							return limitCount
						end

						local limitCount = getLimitCount()
						if limitCount then
							set["count"]:setVisible(dbMaterial.islimit > 0)
							set["count"]:setString(string.format(res.locString("Global$Last"), limitCount))
							if limitCount == 0 then
								set["count"]:setFontFillColor(res.color4F.red, true)
							else
								set["count"]:setFontFillColor(res.color4F.white, true)
							end	
						end

						local function buyMaterial(  )
							local limitCount = getLimitCount()
							if limitCount == 0 then
								self:doVipTip()
							elseif limitCount == 1 or dbMaterial.upable > 0 then
								local price = dbMaterial.price
								if dbMaterial.upable > 0 then
									price = dbMaterial.upprice[ itemMallFunc.getBuyRecordDm(dbMaterial.materialid) + 1 ]
								end

								if isDiscounting and discountPercent then
									price = dbMaterial.price * discountPercent
								end
								if gameFunc.getUserInfo().getCoin() >= price then
									local param = {}
									param.content = string.format(res.locString("Activity$MagicShopBuyConfirm"), "TY_jinglingshi_xiao.png", price, dbMaterial.name)
									param.callback = function ( ... )
										self:send(netModel.getModelShopBuyMaterial(dbMaterial.materialid, 1, false), function ( data )
											print("ShopBuyMaterial data:")
											print(data)
											if data and data.D then
												gameFunc.updateResource(data.D.Resource)
												itemMallFunc.setBuyRecordDm(dbMaterial.materialid, 1)
												res.toastReward(data.D.Reward)
												self:updateList()
												self:updateMoney()
											end
										end)
									end
									GleeCore:showLayer("DConfirmNT", param)
								else
									require "Toolkit".showDialogOnCoinNotEnough()
								end
							else
								local param = {}
								param.itemType = nItem.itemType
								param.itemId = dbMaterial.materialid
								param.callback = function (  )
									self:updateList()
									self:updateMoney()
								end
								GleeCore:showLayer("DMallItemBuy", param)	
							end				
						end

						set["btnDetail"]:setEnabled(true)
						set["btnDetail"]:setListener(function (  )
							local param = {}
							param.materialId = dbMaterial.materialid
							param.isBuy = true
							param.Callback = function (  )
								buyMaterial()								
							end
							GleeCore:showLayer("DMaterialDetail", param)	
						end)
						set["btnBuy"]:setEnabled(true)
						set["btnBuy"]:setListener(function (  )
							buyMaterial()
						end)
					elseif nItem.itemType == "Good" then
						local nGood = nItem.itemData
						set["icon"]:setResid(res.getActiveItemIcon())
						set["iconFrame"]:setResid(res.getActiveItemIconFrame())
						set["name"]:setString(nGood.Name)

						if nGood.State == 4 then
							set["state"]:setResid("N_SC_zhekou.png")
						elseif nGood.State == 5 then
							set["state"]:setResid("N_SC_xiangou.png")
						elseif nGood.State == 6 then
							set["state"]:setResid("N_SC_xianshi.png")
						else
							set["state"]:setResid("")
						end

						-- 折扣
						set["layoutPrice_v1"]:setString(nGood.Op)
						set["layoutPrice_v1"]:setFontFillColor(ccc4f(0.396, 0.286, 0.247, 1.0), true)
						set["layoutPrice_v2"]:setString(nGood.Np)
						set["layoutPrice_v2"]:setFontFillColor(ccc4f(0.89, 0.576, 0.196, 1.0), true)
						set["layoutPrice_v1_line"]:setVisible(true)
						set["layoutPrice_v1_line"]:setScale(set["layoutPrice_v1"]:getContentSize().width / set["layoutPrice_v1_line"]:getContentSize().width)

						-- 限时
						local seconds = -TimeListManager.getTimeUpToNow(nGood.CloseAt)
						seconds = math.max(seconds, 0)
						if seconds <= 7 * 24 * 3600 and seconds > 0 then
							print("seconds = " .. seconds)
							set["timer"]:setVisible(true)
							local date = set["timer"]:getElfDate()
							date:setHourMinuteSecond(0, 0, seconds)
							if seconds == 0 then
								set["timer"]:setUpdateRate(0)
							else
								set["timer"]:setUpdateRate(-1)
								set["timer"]:addListener(function ( ... )
									set["timer"]:setUpdateRate(0)
									self:updateList()
								end)
							end
						else
							set["timer"]:setVisible(false)
						end
						
						--限购
						set["count"]:setVisible(nGood.Lm > 1)
						local limitCount = 0
						if nGood.Lm > 1 then
							if nGood.Lm == 2 then
								limitCount = math.max(nGood.Total - itemMallFunc.getBuyRecordDg(nGood.Gid), 0)
							elseif nGood.Lm == 3 then
								limitCount = math.max(nGood.Total - itemMallFunc.getBuyRecordTg(nGood.Gid), 0)
							end
							set["count"]:setString(string.format(res.locString("Global$Last"), limitCount))
							if limitCount == 0 then
								set["count"]:setFontFillColor(res.color4F.red, true)
							else
								set["count"]:setFontFillColor(res.color4F.white, true)
							end	
						end

						set["btnDetail"]:setEnabled(false)
						set["btnBuy"]:setEnabled(nGood.Lm == 1 or limitCount > 0)
						set["btnBuy"]:setListener(function (  )
							if limitCount == 1 then
								if gameFunc.getUserInfo().getCoin() >= nGood.Np then
									local param = {}
									param.content = string.format(res.locString("Activity$MagicShopBuyConfirm"), "TY_jinglingshi_xiao.png", nGood.Np, nGood.Name)
									param.callback = function ( ... )
										self:send(netModel.getModelShopBuy(nGood.Gid, limitCount), function ( netData )
											print("ShopBuy data:")
											print(netData)
											if netData and netData.D then
												gameFunc.updateResource(netData.D.Resource)
												itemMallFunc.updateBuyRecord(nGood, 1)

												res.toastReward(data.D.Reward)
												self:updateList()
												self:updateMoney()
											end
										end)
									end
									GleeCore:showLayer("DConfirmNT",param)
								else
									require "Toolkit".showDialogOnCoinNotEnough()
								end
							else
								local param = {}
								param.itemType = nItem.itemType
								param.nGood = nGood
								param.callback = function ( netData )
									self:updateList()
									self:updateMoney()
								end
								GleeCore:showLayer("DMallItemBuy", param)				
							end
						end)
					elseif nItem.itemType == "DungeonReward" then
						local nReward = nItem.itemData
						set["state"]:setResid("N_SC_zhekou.png")
						set["timer"]:setVisible(false)
						set["count"]:setVisible(false)

						local rGold = math.abs(nReward.Gold) 
						local rCoin = math.abs(nReward.Coin)
						if rGold > 0 then
							set["layoutPrice_icon"]:setResid("N_TY_jinbi1.png")
							set["layoutPrice_v1"]:setString(rGold)
						elseif rCoin > 0 then
							set["layoutPrice_icon"]:setResid("N_TY_baoshi1.png")
							set["layoutPrice_v1"]:setString(rCoin)
						end
						set["layoutPrice_v1"]:setFontFillColor(ccc4f(0.89, 0.576, 0.196, 1.0), true)
						set["layoutPrice_v2"]:setString("")
						set["layoutPrice_v1_line"]:setVisible(false)

						local function buyDungeonGood( ... )
							local canBuy = false
							if rGold > 0 then
								if userFunc.getGold() < rGold then
									self:toast(res.locString("Dungeon$GoldIsNotEnough"))
								else
									canBuy = true
								end
							elseif rCoin > 0 then
								if userFunc.getCoin() < rCoin then
									require "Toolkit".showDialogOnCoinNotEnough()
								else
									canBuy = true
								end
							end
							if canBuy and self.dungeonCallback then
								res.doActionDialogHide(self._commonDialog, self)
								self.dungeonCallback(i - 1)
							end
						end

						set["btnBuy"]:setEnabled(true)
						set["btnBuy"]:setListener(function ( ... )
							buyDungeonGood()
						end)
						set["btnDetail"]:setEnabled(true)
						if nReward.Equipments and #nReward.Equipments > 0 and nReward.Equipments[1].EquipmentId then
							local dbEquip = dbManager.getInfoEquipment(nReward.Equipments[1].EquipmentId)
							set["icon"]:setResid(res.getEquipIconWithId(dbEquip.equipmentid))
							set["iconFrame"]:setResid(res.getEquipIconFrame(dbEquip))
							set["name"]:setString(dbEquip.name)
							set["btnDetail"]:setListener(function ( ... )
								GleeCore:showLayer("DEquipDetail",{nEquip = gameFunc.getEquipInfo().getEquipInfoByEquipmentID( dbEquip.equipmentid )})
							end)
						end
						if nReward.Materials and #nReward.Materials > 0 and nReward.Materials[1].MaterialId then
							local dbMaterial = dbManager.getInfoMaterial(nReward.Materials[1].MaterialId)
							res.setNodeWithMaterial(set["icon"], dbMaterial)
							set["iconFrame"]:setVisible(false)
							set["name"]:setString(dbMaterial.name)
							set["btnDetail"]:setListener(function ( ... )
								local param = {}
								param.materialId = dbMaterial.materialid
								param.isBuy = true
								param.closeDialog = true
								param.Callback = buyDungeonGood
								GleeCore:showLayer("DMaterialDetail", param)	
							end)
						end
					end

					local w = set["name"]:getWidth()
					if w > 160 then
						set["name"]:setScale(160/w)
					end
				end
			end
		end)
	end

	self.itemList:update(self:getListData(), refresh)
end

function DMall:getListData(  )
	local list = {}
	if self.dungeonRewardList then
		for i,v in ipairs(self.dungeonRewardList) do
			table.insert(list, {itemType = "DungeonReward", itemData = v})
		end
	else
		-- for i,v in ipairs(itemMallFunc.getGoods()) do
		-- 	table.insert(list, {itemType = "Good", itemData = v})
		-- end
		for i,v in ipairs(itemMallFunc.getItemsSaleInShop()) do
			table.insert(list, {itemType = "Material", itemData = v})
		end

		table.sort(list, function ( a, b )
			if a.itemType == b.itemType then
				if a.itemType == "Good" then
					if a.itemData.Sort == b.itemData.Sort then
						return a.itemData.Id < b.itemData.Id
					else
						return a.itemData.Sort < b.itemData.Sort
					end
				elseif a.itemType == "Material" then
					if a.itemData.sort == b.itemData.sort then
						return a.itemData.materialid < b.itemData.materialid
					else
						return a.itemData.sort < b.itemData.sort
					end
				end
			else
				return a.itemType == "Good"
			end
		end)		
	end
	local result = {}
	for i,v in ipairs(list) do
		local a = math.floor((i - 1) / 4 + 1)
		local b = math.floor((i - 1) % 4 + 1)
		result[a] = result[a] or {}
		result[a][b] = v
	end
	return result
end

function DMall:updateMoney(  )
	self._commonDialog_cnt_layoutMoney_v1:setString(userFunc.getGold())
	self._commonDialog_cnt_layoutMoney_v2:setString(userFunc.getCoin())
end

function DMall:broadcastEvent(  )
	eventCenter.addEventFunc("OnAppStatChange", function ( state )
		if state == 2 then
			self:updateList()
			self:updateMoney()
		end
	end, "DMall")
end

function DMall:doVipTip(  )
	if userFunc.isMaxVip() then
		local param = {}
		param.content = res.locString("itemMall$BuyCountCapLimit")
		param.hideCancel = true
		GleeCore:showLayer("DConfirmNT", param)		
	else
		local param = {}
		param.content = res.locString("ItemMall$BuyLimit")
		param.tip = res.locString("VIP$BetterVip")
		param.RightBtnText = res.locString("Global$BtnRecharge")
		param.callback = function ( ... )
			GleeCore:showLayer("DRecharge")
		end
		GleeCore:showLayer("DResetNotice", param)								
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DMall, "DMall")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DMall", DMall)


