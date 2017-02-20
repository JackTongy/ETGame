local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local netModel = require "netModel"
local EventCenter = require "EventCenter"
local gameFunc = require "AppData"
local userFunc =  gameFunc.getUserInfo()
local LuaList = require "LuaList"
local GBHelper = require "GBHelper"

local DGBMall = class(LuaDialog)

function DGBMall:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGBMall.cocos.zip")
    return self._factory:createDocument("DGBMall.cocos")
end

--@@@@[[[[
function DGBMall:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_bg = set:getJoint9Node("commonDialog_cnt_bg")
    self._commonDialog_cnt_bg_list = set:getListNode("commonDialog_cnt_bg_list")
    self._layout = set:getLayoutNode("layout")
    self._bg = set:getElfNode("bg")
    self._icon_bg = set:getElfNode("icon_bg")
    self._icon = set:getElfNode("icon")
    self._iconFrame = set:getElfNode("iconFrame")
    self._piece = set:getElfNode("piece")
    self._layoutStar = set:getLayoutNode("layoutStar")
    self._name = set:getLabelNode("name")
    self._count = set:getLabelNode("count")
    self._layoutPrice = set:getLinearLayoutNode("layoutPrice")
    self._layoutPrice_k = set:getElfNode("layoutPrice_k")
    self._layoutPrice_v = set:getLabelNode("layoutPrice_v")
    self._btnOk = set:getClickNode("btnOk")
    self._btnOk_text = set:getLabelNode("btnOk_text")
    self._btnDetail = set:getButtonNode("btnDetail")
    self._commonDialog_cnt_layoutRefresh_time = set:getTimeNode("commonDialog_cnt_layoutRefresh_time")
    self._commonDialog_cnt_refreshTip = set:getRichLabelNode("commonDialog_cnt_refreshTip")
    self._commonDialog_cnt_layoutOwn_v1 = set:getLabelNode("commonDialog_cnt_layoutOwn_v1")
    self._commonDialog_cnt_layoutOwn_v2 = set:getLabelNode("commonDialog_cnt_layoutOwn_v2")
    self._commonDialog_cnt_btnRefresh = set:getClickNode("commonDialog_cnt_btnRefresh")
    self._commonDialog_cnt_btnRefresh_text = set:getLabelNode("commonDialog_cnt_btnRefresh_text")
    self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
    self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
--    self._@shopItemSize = set:getElfNode("@shopItemSize")
--    self._@shopItem = set:getElfNode("@shopItem")
end
--@@@@]]]]

--------------------------------override functions----------------------

local Launcher = require 'Launcher'
Launcher.register("DGBMall", function ( userData )
	Launcher.callNet(netModel.getModelGuildFightStoreGet(),function ( data )
		Launcher.Launching(data)   
	end)
end)

function DGBMall:onInit( userData, netData )
	if netData and netData.D then
		self.gbData = netData.D
	end

	res.doActionDialogShow(self._commonDialog)
	self:setListenerEvent()
	self:broadcastEvent()
	self:updateLayer()
end

function DGBMall:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DGBMall:setListenerEvent( ... )
	self._commonDialog_cnt_btnRefresh:setListener(function ( ... )
		local freeTimes = dbManager.getVipInfo( userFunc.getVipLevel() ).GuildFightStoreFreeTimes
		if freeTimes > self.gbData.FreeCount then
			self:send(netModel.getModelGuildFightStoreRefreshFree(), function ( data )
				if data and data.D then
					self.gbData = data.D
					self:updateLayer()
				end
			end)
		else
			if userFunc.getCoin() >= self:getRefreshCost() then
				self:send(netModel.getModelGuildFightStoreRefreshCost(), function ( data )
					if data and data.D then
						userFunc.setCoin( userFunc.getCoin() - self:getRefreshCost() )
						self.gbData = data.D
						self:updateLayer()
					end
				end)
			else
				require "Toolkit".showDialogOnCoinNotEnough()
			end
		end
	end)

	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._commonDialog_btnClose:setListener(function (  )
		res.doActionDialogHide(self._commonDialog, self)
	end)
end

function DGBMall:broadcastEvent( ... )
	EventCenter.addEventFunc("OnAppStatChange", function ( state )
		if state == 2 then
			self:updateLayer()
		end
	end, "DGBMall")
end

function DGBMall:updateList( ... )
	if not self.itemList then
		self.itemList = LuaList.new(self._commonDialog_cnt_bg_list, function (  )
			local sizeSet = self:createLuaSet("@shopItemSize")
			sizeSet["setList"] = {}
			for i=1,4 do
				local itemSet = self:createLuaSet("@shopItem")
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
					set["layoutStar"]:removeAllChildrenWithCleanup(true)
					if nItem.type == "Pet" or nItem.type == "PetPiece" then
						set["icon"]:setScale(0.8 * 140 / 95)
						local dbPet = dbManager.getCharactor(nItem.eventData.data.PetInfo.PetId)
						require 'PetNodeHelper'.updateStarLayout(set["layoutStar"], dbPet)
					else
						set["icon"]:setScale(0.8)
					end

					local function adjustName( ... )
						if nItem.type == "MibaoPiece" then
							local first = string.find(nItem.name, res.locString("Global$Fragment"))
							if first then
								nItem.name = string.sub(nItem.name, 1, first - 1)
							end
						end
					end
					require 'LangAdapter'.selectLang(nil,nil,nil,nil,nil,adjustName,adjustName)

					if nItem.type == "Gem" then
						set["name"]:setString(nItem.name .. " Lv." .. nItem.lv)
					else
						set["name"]:setString(nItem.name)
					end
					require 'LangAdapter'.fontSize( set["name"], nil, nil, 20)

					require 'LangAdapter'.selectLang(nil,nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
						require 'LangAdapter'.LabelNodeAutoShrink(set["name"], 160)
					end)

					set["count"]:setVisible(nItem.count > 1)
					set["count"]:setString( string.format("x%d", nItem.count) )
					if nItem.count == 0 then
						set["count"]:setFontFillColor(res.color4F.red, true)
					else
						set["count"]:setFontFillColor(res.color4F.white, true)
					end	
					set["layoutPrice_v"]:setString(nItem.Consume)
					local playerInfo = GBHelper.getGuildMatchPlayer()
					local canBuy = playerInfo and playerInfo.Coin and playerInfo.Coin >= nItem.Consume or false
					set["btnOk"]:setEnabled(not nItem.IsExchange and canBuy)
					if nItem.IsExchange then
						set["btnOk_text"]:setString(res.locString("ItemMall$BuyDone"))
					else
						set["btnOk_text"]:setString(res.locString("Global$BUY"))
					end
					set["btnOk"]:setListener(function ( ... )
						local param = {}
						param.content = string.format(res.locString("League$shopText4"), "", nItem.Consume .. res.locString("Global$GuildFightPoint"), nItem.name)
						param.callback = function ( ... )
							self:send(netModel.getModelGuildFightStoreBuy(nItem.Id), function ( data )
								if data and data.D then
									gameFunc.updateResource(data.D.Resource)
									res.doActionGetReward(data.D.Reward)

									local player = GBHelper.getGuildMatchPlayer()
									player.Coin = math.max(player.Coin - nItem.Consume, 0)
									self.gbData.Items[(nodeIndex - 1) * 4 + i].IsExchange = true
									self:updateLayer()
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

	self.itemList:update(self:getListData())
end

function DGBMall:getListData( ... )
	local list = {}
	if self.gbData and self.gbData.Items then
		for i,v in ipairs(self.gbData.Items) do
			local info = res.getRewardResWithDB( dbManager.getGuildFightStoreInfo(v.Type, v.ItemId) )
			info.count = v.Amount
			info.Consume = v.Consume
			info.IsExchange = v.IsExchange
			info.Id = v.Id
			table.insert(list, info)
		end
	end
	print("公会战物品列表")
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

function DGBMall:close(  )
	EventCenter.resetGroup("DGBMall")
end

function DGBMall:updateLayer( ... )
	local curDate = require "TimeManager".getCurrentSeverDate()
	print("curDate:")
	print(curDate)
	local deadline = table.clone(curDate)
	deadline.hour = dbManager.getInfoDefaultConfig("GuildFightStoreRef").Value
	deadline.min = 0
	deadline.sec = 0
	print("deadline")
	print(deadline)
	local seconds = math.fmod(24 * 3600 + os.difftime(os.time(deadline), os.time(curDate)), 24 * 3600)
	print("seconds = " ..seconds)
	if seconds <= 0 then
		seconds = 24 * 3600
	end
	local date = self._commonDialog_cnt_layoutRefresh_time:getElfDate()
	date:setHourMinuteSecond(0, 0, math.max(seconds, 0))
	self._commonDialog_cnt_layoutRefresh_time:setUpdateRate(-1)
	self._commonDialog_cnt_layoutRefresh_time:addListener(function (  )
		print("GuildFightStoreRefreshTime")
		print(require "TimeManager".getCurrentSeverTime())
		self:send(netModel.getModelGuildFightStoreRefreshTime(), function ( data )
			if data and data.D then
				self.gbData = data.D
				self:updateLayer()
			end
		end)
	end)

	local freeTimes = dbManager.getVipInfo( userFunc.getVipLevel() ).GuildFightStoreFreeTimes
	if freeTimes > self.gbData.FreeCount then
		self._commonDialog_cnt_refreshTip:setString(res.locString("GuildBattle$shopRefreshFree"))
	else
		self._commonDialog_cnt_refreshTip:setString(string.format(res.locString("GuildBattle$shopRefreshCost"), self:getRefreshCost()))
	end
	self._commonDialog_cnt_refreshTip:setFontFillColor(ccc4f(0.286,0.247,1.0,0.396), true)		-- (g, b, a, r)

	require 'LangAdapter'.selectLang(nil, nil, function ( ... )
		self._commonDialog_cnt_refreshTip:setPosition(ccp(-40,-189.00002))
		self._commonDialog_cnt_refreshTip:setFontSize(20)
	end, function ( ... )
		self._commonDialog_cnt_refreshTip:setPosition(ccp(10,-189.00002))
	end, nil, function ( ... )
		self._commonDialog_cnt_refreshTip:setPosition(ccp(20,-189.00002))
	end, function ( ... )
		self._commonDialog_cnt_refreshTip:setPosition(ccp(20,-189.00002))
	end,nil,nil,function ( ... )
		self._commonDialog_cnt_refreshTip:setPosition(ccp(-2.857143,-189.00002))
		self._commonDialog_cnt_btnRefresh_text:setFontSize(18)
	end)

	local playerInfo = GBHelper.getGuildMatchPlayer()
	self._commonDialog_cnt_layoutOwn_v1:setString(playerInfo and playerInfo.Coin or 0)
	self._commonDialog_cnt_layoutOwn_v2:setString(gameFunc.getUserInfo().getCoin())
	self:updateList()
end

function DGBMall:getRefreshCost( ... )
	local costList = dbManager.getInfoDefaultConfig("GuildFightStoreCosts").Value
	if costList then
		if self.gbData.PayCount < #costList then
			return costList[self.gbData.PayCount + 1]
		else
			return costList[#costList]
		end
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGBMall, "DGBMall")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGBMall", DGBMall)


