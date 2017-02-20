local res = require "Res"
local dbManager = require "DBManager"
local LuaList = require "LuaList"
local gameFunc = require "AppData"
local netModel = require "netModel"
local userFunc = gameFunc.getUserInfo()
local SilverCoinInfo = gameFunc.getSilverCoinInfo()

local function getBuyData( ... )
	local list = {}
	for i,v in ipairs(SilverCoinInfo.getBuys()) do
		local dbReward = res.packageReward(v.Type, v.ItemId, v.Amount, v.Lv > 0 and {v.Lv} or nil)
		local item = res.getDetailByDBReward(dbReward)
		item.MoneyType = v.MoneyType
		item.Money = v.Money
		item.Vip = v.Vip
		item.Used = v.Used
		item.Id = v.Id
		table.insert(list, item)
	end

	print("春节神秘商店物品列表-出售")
	print(list)

	local result = {}
	for i,v in ipairs(list) do
		local a = math.floor((i - 1) / 4 + 1)
		local b = math.floor((i - 1) % 4 + 1)
		result[a] = result[a] or {}
		result[a][b] = v
	end
	return result
end

local function getSellData( ... )
	local list = {}
	for i,v in ipairs(SilverCoinInfo.getSells()) do
		local dbReward = res.packageReward(v.Type, v.ItemId, v.Amount, v.Lv > 0 and {v.Lv} or nil)
		local item = res.getDetailByDBReward(dbReward)
		item.MoneyType = v.MoneyType
		item.Money = v.Money
		item.TotalTimes = v.TotalTimes
		item.AlreadyBuyTimes = v.AlreadyBuyTimes
		item.Id = v.Id
		item.ItemId = v.ItemId
		table.insert(list, item)
	end

	print("春节神秘商店物品列表-收购")
	print(list)
	local result = {}
	for i,v in ipairs(list) do
		local a = math.floor((i - 1) / 4 + 1)
		local b = math.floor((i - 1) % 4 + 1)
		result[a] = result[a] or {}
		result[a][b] = v
	end
	return result
end

local refreshLayer

local function updateTabLayers( self, view )
	view["pageBuy"]:setVisible(view.tabIndex == 1)
	view["pageSell"]:setVisible(view.tabIndex == 2)
	if view.tabIndex == 1 then
		local totalRefreshTimes = 5
		view["pageBuy_count"]:setString(string.format("(%d/%d)", SilverCoinInfo.getRecord().RefreshTimes, totalRefreshTimes))
		view["pageBuy_layoutRefresh"]:setVisible(SilverCoinInfo.getRecord().RefreshTimes < totalRefreshTimes)
		if SilverCoinInfo.getRecord().RefreshTimes < totalRefreshTimes then
			local seconds = -math.floor(require "TimeListManager".getTimeUpToNow(SilverCoinInfo.getRecord().RefreshAt)) + 3600 * 2 + 2
			seconds = math.max(seconds, 0)
			seconds = math.min(seconds, 3600 * 2)
			local date = view["pageBuy_layoutRefresh_time"]:getElfDate()
			date:setHourMinuteSecond(0, 0, seconds)
			date:setTimeFormat(HourMinuteSecond)
			if seconds > 0 then
				view["pageBuy_layoutRefresh_time"]:setUpdateRate(-1)
				view["pageBuy_layoutRefresh_time"]:addListener(function (  )
					SilverCoinInfo.getRecord().RefreshTimes = math.max(SilverCoinInfo.getRecord().RefreshTimes + 1, totalRefreshTimes)
					if SilverCoinInfo.getRecord().RefreshTimes == totalRefreshTimes then
						view["pageBuy_layoutRefresh_time"]:setUpdateRate(0)
						view["pageBuy_layoutRefresh"]:setVisible(false)
					else
						date:setHourMinuteSecond(0, 0, 3600 * 2)
					end
					view["pageBuy_count"]:setString(string.format("%d/%d", SilverCoinInfo.getRecord().RefreshTimes, totalRefreshTimes))

					self:send(netModel.getModelMysteryShopGet(), function ( data )
						if data and data.D then
							SilverCoinInfo.setRecord(data.D.Record)
							SilverCoinInfo.setBuys(data.D.Buys)
							SilverCoinInfo.setSells(data.D.Sells)
							SilverCoinInfo.setStarAmount(data.D.StarAmount)
							refreshLayer(self, view)
						end
					end)
				end)
			else
				view["pageBuy_layoutRefresh_time"]:setUpdateRate(0)
				view["pageBuy_layoutRefresh"]:setVisible(false)
			end
		end
		view["pageBuy_btnRefresh"]:setListener(function ( ... )
			local function refreshEvent( cost )
				self:send(netModel.getModelMysteryShopRefresh(), function ( data )
					if data and data.D then
						userFunc.setCoin( userFunc.getCoin() - cost )
						require "EventCenter".eventInput("UpdateGoldCoin")
						SilverCoinInfo.setRecord(data.D.Record)
						SilverCoinInfo.setBuys(data.D.Buys)
						refreshLayer(self, view)
					end
				end)
			end
			if SilverCoinInfo.getRecord().RefreshTimes == 0 then
				local cost = dbManager.getInfoDefaultConfig("MysteryShopRefreshCoin").Value
				if userFunc.getCoin() >= cost then
					local param = {}
					param.content = string.format(res.locString("SilverCoinShop$RefreshNotice"), cost)
					param.callback = function ( ... )
						refreshEvent(cost)
					end
					GleeCore:showLayer("DConfirmNT", param)
				else
					require "Toolkit".showDialogOnCoinNotEnough()
				end
			else
				refreshEvent(0)
			end
		end)

		require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
			local size = CCSize(160,46)
			view["pageBuy_btnRefresh"]:setContentSize(size)
			view["pageBuy_btnRefresh_normal_#joint9"]:setContentSize(size)
			view["pageBuy_btnRefresh_pressed_#joint9"]:setContentSize(size)
			view["pageBuy_btnRefresh_invalid_#joint9"]:setContentSize(size)
		end)
		
		if not view.buyList then
			view.buyList = LuaList.new(view["pageBuy_bg3_list"], function ( ... )
				local sizeSet = view.createLuaSet("@size")
				sizeSet["setList"] = {}
				for i=1,4 do
					local itemSet = view.createLuaSet("@shopItem")
					sizeSet["layout"]:addChild(itemSet[1])
					table.insert(sizeSet["setList"], itemSet)
				end
				return sizeSet
			end, function ( nodeLuaSet, dataList, nodeIndex )
				local itemSetList = nodeLuaSet["setList"]
				for i,set in ipairs(itemSetList) do
					set[1]:setVisible(i <= #dataList)
					if i <= #dataList then
						local nItem = dataList[i]
						set["icon_bg"]:setResid( nItem.bg )
						set["icon"]:setResid( nItem.icon )
						set["iconFrame"]:setResid( nItem.frame )
						set["piece"]:setVisible( nItem.isPiece )
						if nItem.type == "Pet" or nItem.type == "PetPiece" then
							set["icon"]:setScale(0.8 * 140 / 95)
							local dbPet = dbManager.getCharactor(nItem.eventData.data.PetInfo.PetId)
						else
							set["icon"]:setScale(0.8)
						end
						if nItem.type == "Gem" then
							set["name"]:setString(nItem.name .. " Lv." .. nItem.lv)
						else
							set["name"]:setString(nItem.name)
						end
						require 'LangAdapter'.fontSize(set["name"], nil, nil, 20, nil, nil)

						-- set["count"]:setVisible(nItem.count > 1)
						set["count"]:setString( string.format("x%d", nItem.count) )
						-- if nItem.count == 0 then
						-- 	set["count"]:setFontFillColor(res.color4F.red, true)
						-- else
						-- 	set["count"]:setFontFillColor(res.color4F.white, true)
						-- end
						set["vip"]:setVisible(nItem.Vip > 0)
						if nItem.Vip > 0 then
							set["vip"]:setResid(string.format("N_CZ_vip%d.png", nItem.Vip))
						end

						set["layoutPrice_v"]:setString(nItem.Money)

						local canBuy = userFunc.getVipLevel() >= nItem.Vip
						if nItem.MoneyType == 1 then
							set["layoutPrice_k"]:setResid("N_TY_baoshi1.png")
							canBuy = canBuy and userFunc.getCoin() >= nItem.Money
							set["layoutPrice_v"]:setFontFillColor(userFunc.getCoin() >= nItem.Money and ccc4f(0.89,0.576,0.196,1.0) or res.color4F.red, true)
						elseif nItem.MoneyType == 2 then
							set["layoutPrice_k"]:setResid("SMSD_tubiao1.png")
							canBuy = canBuy and SilverCoinInfo.getRecord().SilverCoins >= nItem.Money
							set["layoutPrice_v"]:setFontFillColor(SilverCoinInfo.getRecord().SilverCoins >= nItem.Money and ccc4f(0.89,0.576,0.196,1.0) or res.color4F.red, true)
						end
						
						set["btnOk"]:setEnabled(not nItem.Used and canBuy)
						if nItem.Used then
							set["btnOk_text"]:setString(res.locString("ItemMall$BuyDone"))
						else
							set["btnOk_text"]:setString(res.locString("Global$BUY"))
						end
						set["btnOk"]:setListener(function ( ... )
							local param = {}
							if nItem.MoneyType == 1 then
								param.content = string.format(res.locString("League$shopText4"), "TY_jinglingshi_xiao.png", nItem.Money, nItem.name)
							elseif nItem.MoneyType == 2 then
								param.content = string.format(res.locString("League$shopText4"), "SMSD_tubiao1.png", nItem.Money .. res.locString("Global$SilverCoin"), nItem.name)
							end
							param.callback = function ( ... )
								self:send(netModel.getModelMysteryShopBuy(nItem.Id), function ( data )
									if data and data.D then
										gameFunc.updateResource(data.D.Resource)
										res.doActionGetReward(data.D.Reward)
										if nItem.MoneyType == 2 then
											SilverCoinInfo.getRecord().SilverCoins = SilverCoinInfo.getRecord().SilverCoins - nItem.Money
										end
										SilverCoinInfo.GoodBuyed( nItem.Id )
										refreshLayer(self, view)
									end
								end)
							end
							GleeCore:showLayer("DConfirmNT",param)
						end)
						set["btnDetail"]:setListener(function ( ... )
							if nItem.eventData then
								GleeCore:showLayer(nItem.eventData.dialog, nItem.eventData.data)
							end
						end)
					end
				end
			end)
		end
		view.buyList:update(getBuyData())

		view["pageBuy_layoutReward"]:removeAllChildrenWithCleanup(true)
		local silverCoinData = gameFunc.getActivityInfo().getDataByType(48)
		local limitValueList = silverCoinData.Data.GiftStars
		for i=1,5 do
			local btnRwd = view.createLuaSet("@btnRwd")
			view["pageBuy_layoutReward"]:addChild(btnRwd[1])
			
			btnRwd[1]:setEnabled( not table.find(SilverCoinInfo.getRecord().Gifts, i) )
			btnRwd[1]:setListener(function ( ... )
				GleeCore:showLayer("DSilverCoinPackageContent", {RwdIndex = i, isLocked = SilverCoinInfo.getStarAmount() < limitValueList[i], callback = function ( ... )
					refreshLayer(self, view)
				end})
			end)
			btnRwd["locked"]:setVisible(SilverCoinInfo.getStarAmount() < limitValueList[i])
			btnRwd["text"]:setString(string.format("%d/%d", math.min(SilverCoinInfo.getStarAmount(), limitValueList[i]) , limitValueList[i]))
			if SilverCoinInfo.getStarAmount() < limitValueList[i] then
				btnRwd["text"]:setFontFillColor(ccc4f(1,1,1,1), true)
			else
				btnRwd["text"]:setFontFillColor(ccc4f(0.89,0.576,0.196,1.0), true)
			end

			if i ~= 5 then
				local nextSet = view.createLuaSet("@next")
				view["pageBuy_layoutReward"]:addChild(nextSet[1])
			end
		end

		require 'LangAdapter'.fontSize(view["pageBuy_#tip"], nil, nil, 15, nil, nil)
	elseif view.tabIndex == 2 then
		if not view.sellList then
			view.sellList = LuaList.new(view["pageSell_bg4_list"], function ( ... )
				local sizeSet = view.createLuaSet("@size")
				sizeSet["setList"] = {}
				for i=1,4 do
					local itemSet = view.createLuaSet("@shopItem")
					sizeSet["layout"]:addChild(itemSet[1])
					table.insert(sizeSet["setList"], itemSet)
				end
				return sizeSet
			end, function ( nodeLuaSet, dataList, listIndex )
				local itemSetList = nodeLuaSet["setList"]
				for i,set in ipairs(itemSetList) do
					set[1]:setVisible(i <= #dataList)
					if i <= #dataList then
						local nItem = dataList[i]
						set["icon_bg"]:setResid( nItem.bg )
						set["icon"]:setResid( nItem.icon )
						set["iconFrame"]:setResid( nItem.frame )
						set["piece"]:setVisible( nItem.isPiece )
						if nItem.type == "Pet" or nItem.type == "PetPiece" then
							set["icon"]:setScale(0.8 * 140 / 95)
							local dbPet = dbManager.getCharactor(nItem.eventData.data.PetInfo.PetId)
						else
							set["icon"]:setScale(0.8)
						end
						if nItem.type == "Gem" then
							set["name"]:setString(nItem.name .. " Lv." .. nItem.lv)
						else
							set["name"]:setString(nItem.name)
						end
						require 'LangAdapter'.fontSize(set["name"], nil, nil, 20, nil, nil)

						-- set["count"]:setVisible(nItem.count > 1)
						set["count"]:setString( string.format("x%d", nItem.count) )
						-- if nItem.count == 0 then
						-- 	set["count"]:setFontFillColor(res.color4F.red, true)
						-- else
						-- 	set["count"]:setFontFillColor(res.color4F.white, true)
						-- end

						set["vip"]:setVisible(false)
						set["layoutPrice_v"]:setString(nItem.Money)

						local nMaterial = gameFunc.getBagInfo().getItemWithItemId(nItem.eventData.data.materialId)
						local ownCount = nMaterial and nMaterial.Amount or 0
						local canSell = nItem.type == "Material" and ownCount >= nItem.count and nItem.AlreadyBuyTimes < nItem.TotalTimes
						local lastCount = math.min(math.floor(ownCount / nItem.count), nItem.TotalTimes - nItem.AlreadyBuyTimes )
						if nItem.MoneyType == 1 then
							set["layoutPrice_k"]:setResid("N_TY_baoshi1.png")
						elseif nItem.MoneyType == 2 then
							set["layoutPrice_k"]:setResid("SMSD_tubiao1.png")
						end

						set["btnOk"]:setEnabled(canSell)
						set["btnOk_text"]:setString(res.locString("Global$Sale"))

						set["btnOk"]:setListener(function ( ... )	
							local function addAlreadyBuyTimes( nItem, addCount )
								local items = SilverCoinInfo.getSells()
								for i,v in ipairs(items) do
									if v.Id == nItem.Id then
										items[i].AlreadyBuyTimes = items[i].AlreadyBuyTimes + addCount
										local bagFunc = require "BagInfo"
										local temp = bagFunc.getItemWithItemId(nItem.ItemId)
										bagFunc.useItemByID(temp.Id, addCount)
										break
									end
								end
							end

							local function SilverCoinSell( amt, closeBuyLayer )
								self:send(netModel.getModelMysteryShopSell(nItem.Id, amt), function ( data )
									if data and data.D then
		   							if closeBuyLayer then
		   								closeBuyLayer()
		   							end
		   							addAlreadyBuyTimes(nItem, amt)

		   							SilverCoinInfo.setRecord(data.D.Record)
										userFunc.setCoin(data.D.Coin)
		   							refreshLayer(self, view)
										if nItem.MoneyType == 2 then
											set["layoutPrice_k"]:setResid("SMSD_tubiao1.png")
											self:toast(string.format(res.locString("SilverCoinShop$SellSuc"), nItem.Money * amt))
										end
									end
								end)
							end

							-- if lastCount == 1 then
							-- 	SilverCoinSell(1)
							-- else
								local param = {}
								param.itemType = "SilverCoinShop"
								param.hbReward = nItem
								param.hbPrice = nItem.Money
								param.hbAmtLimit = lastCount
								param.showLimit = (nItem.TotalTimes - nItem.AlreadyBuyTimes) * nItem.count 
								param.callback = function ( data )
									SilverCoinSell(data.amt, data.closeBuyLayer)
								end
								GleeCore:showLayer("DMallItemBuy", param)	
							-- end
						end)
						set["btnDetail"]:setListener(function ( ... )
							if nItem.eventData then
								GleeCore:showLayer(nItem.eventData.dialog, nItem.eventData.data)
							end
						end)

					end
				end
			end)
		end
		view.sellList:update(getSellData())
	end
end

refreshLayer = function ( self, view )
	local silverCoinData = gameFunc.getActivityInfo().getDataByType(48)
	print("-----silverCoinData")
	print(silverCoinData)
	if silverCoinData then
		if -math.floor(require "TimeListManager".getTimeUpToNow(silverCoinData.CloseAt)) <= 0 then
			self:onActivityFinish( require 'ActivityType'.SilverCoinShop )
			return
		end

		local seconds = -math.floor(require "TimeListManager".getTimeUpToNow(silverCoinData.CloseAt)) - 3600 * 24
		seconds = math.max(seconds, 0)
		local date = view["layout1_timer"]:getElfDate()
		date:setHourMinuteSecond(0, 0, seconds)
		date:setTimeFormat(DayHourMinuteSecond)
		if seconds > 0 then
			view["layout1_timer"]:setUpdateRate(-1)
			view["layout1_timer"]:addListener(function (  )
				self:onActivityFinish( require 'ActivityType'.SilverCoinShop )
			end)
		else
			view["layout1_timer"]:setUpdateRate(0)
		end

		view["bg1_v"]:setString(userFunc.getCoin())
		view["bg2_v"]:setString(SilverCoinInfo.getRecord().SilverCoins)
		
		view["tabBuy"]:setListener(function ( ... )
			view.tabIndex = 1
			updateTabLayers(self, view)
		end)

		view["tabSell"]:setListener(function ( ... )
			view.tabIndex = 2
			updateTabLayers(self, view)
		end)
		updateTabLayers(self, view)
	else
		self:onActivityFinish( require 'ActivityType'.SilverCoinShop )
	end
end

local update
update = function ( self, view, data )
	if data and data.D then
		SilverCoinInfo.setRecord(data.D.Record)
		SilverCoinInfo.setBuys(data.D.Buys)
		SilverCoinInfo.setSells(data.D.Sells)
		SilverCoinInfo.setStarAmount(data.D.StarAmount)
		refreshLayer(self, view)
		view["tabBuy"]:trigger(nil)
	else
		self:onActivityFinish( require 'ActivityType'.SilverCoinShop )
	end
end

local getNetModel = function ( )
	return netModel.getModelMysteryShopGet()
end

return {update = update, getNetModel = getNetModel, refreshLayer = refreshLayer}