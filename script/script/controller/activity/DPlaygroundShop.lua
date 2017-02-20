local Config = require "Config"
local PlaygroundInfo = require "PlaygroundInfo"
local dbManager = require "DBManager"
local res = require "Res"
local LuaList = require "LuaList"
local gameFunc = require "AppData"
local netModel = require "netModel"

local DPlaygroundShop = class(LuaDialog)

function DPlaygroundShop:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPlaygroundShop.cocos.zip")
    return self._factory:createDocument("DPlaygroundShop.cocos")
end

--@@@@[[[[
function DPlaygroundShop:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._commonDialog = set:getElfNode("commonDialog")
   self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
   self._commonDialog_cnt_page = set:getElfNode("commonDialog_cnt_page")
   self._bg = set:getJoint9Node("bg")
   self._bg_list = set:getListNode("bg_list")
   self._layout = set:getLayoutNode("layout")
   self._bg = set:getElfNode("bg")
   self._icon = set:getElfNode("icon")
   self._iconFrame = set:getElfNode("iconFrame")
   self._piece = set:getElfNode("piece")
   self._theLast = set:getElfNode("theLast")
   self._theLast_count = set:getLabelNode("theLast_count")
   self._name = set:getLabelNode("name")
   self._count = set:getLabelNode("count")
   self._layoutPrice = set:getLinearLayoutNode("layoutPrice")
   self._layoutPrice_k = set:getLabelNode("layoutPrice_k")
   self._layoutPrice_v = set:getLabelNode("layoutPrice_v")
   self._btnOk = set:getClickNode("btnOk")
   self._btnOk_text = set:getLabelNode("btnOk_text")
   self._btnDetail = set:getButtonNode("btnDetail")
   self._layout = set:getLinearLayoutNode("layout")
   self._layout_v1 = set:getLabelNode("layout_v1")
   self._layout_btnSend = set:getClickNode("layout_btnSend")
   self._layout_btnSend_text = set:getLabelNode("layout_btnSend_text")
   self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
   self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
--   self._<FULL_NAME1> = set:getElfNode("@pageShop")
--   self._<FULL_NAME1> = set:getElfNode("@shopItemSize")
--   self._<FULL_NAME1> = set:getElfNode("@shopItem")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DPlaygroundShop:onInit( userData, netData )
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._commonDialog_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self.pageShop = self:createLuaSet("@pageShop")
	self._commonDialog_cnt_page:addChild(self.pageShop[1])
	self:updateLayer()

	res.doActionDialogShow(self._commonDialog)
end

function DPlaygroundShop:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DPlaygroundShop:updateLayer( ... )
	local setShop = self.pageShop
	if not self.shopItemList then
		self.shopItemList = LuaList.new(setShop["bg_list"], function ( ... )
			local sizeSet = self:createLuaSet("@shopItemSize")
			sizeSet["setList"] = {}
			for i=1,4 do
				local itemSet = self:createLuaSet("@shopItem")
				sizeSet["layout"]:addChild(itemSet[1])
				table.insert(sizeSet["setList"], itemSet)
			end
			return sizeSet
		end, function ( nodeLuaSet, dataList, listIndex )
			local itemSetList = nodeLuaSet["setList"]
			for i,set in ipairs(itemSetList) do
				set[1]:setVisible(i <= #dataList)
				if i <= #dataList then
					local thisData = dataList[i]
					local good = thisData.good[1]
					set["icon"]:setResid(good.icon)
					if good.type == "Pet" or good.type == "PetPiece" then
						set["icon"]:setScale(0.8 * 140 / 95)
					else
						set["icon"]:setScale(0.8)
					end
					set["iconFrame"]:setResid(good.frame)
					set["piece"]:setVisible(good.isPiece)
					
					if good.type == "Pet" or good.type == "PetPiece" then
						local dbPet = dbManager.getCharactor(good.eventData.data.PetInfo.PetId)
						set["name"]:setString(good.name)
					else
						if good.type == "Gem" then
							set["name"]:setString(good.name .. " Lv." .. good.lv)
						else
							set["name"]:setString(good.name)
						end
					end
					set["count"]:setVisible(good.count > 1)
					set["count"]:setString(string.format("x%d", good.count))


					set["theLast_count"]:setString(string.format(res.locString("Activity$PlaygroundShopLastCount"), thisData.Times))

					set["layoutPrice_v"]:setString(thisData.Price)
					if PlaygroundInfo.getPlayground().Score < thisData.Price then
						set["layoutPrice_v"]:setFontFillColor(ccc4f(1, 0, 0, 1), true)
					else
						set["layoutPrice_v"]:setFontFillColor(ccc4f(0.8,0.4235,0.13,1.0), true)
					end

					set["btnOk"]:setEnabled(thisData.Times > 0 and good.count > 0)
					set["btnOk"]:setListener(function ( ... )
						local buyIndex
						if PlaygroundInfo.getPlayground().Score >= thisData.Price then
							buyIndex = (listIndex - 1) * 4 + i
						else
							self:toast(res.locString("Activity$PlaygroundScoreNotEnough"))
						end
						if buyIndex and buyIndex > 0 then
							local param = {}
							local goodName = good.name
							if good.count > 1 then
								goodName = goodName .. " x" .. good.count
							end
							param.content = string.format(res.locString("League$shopText4"), "", res.locString("Activity$PlaygroundScore") .. tostring(thisData.Price), goodName)
							print(param.content)
							param.callback = function ( ... )
								self:send(netModel.getModelPlaygroundExchange(buyIndex - 1), function ( data )
									if data and data.D then
										PlaygroundInfo.setPlayground(data.D.Playground)
										require "EventCenter".eventInput("UpdateActivity")
										res.doActionGetReward(data.D.Reward)
										if data.D.Resource then
											gameFunc.updateResource(data.D.Resource)
										end
										self:updateLayer()
									end
								end)
							end
							GleeCore:showLayer("DConfirmNT",param)
						end
					end)
					
					set["btnOk_text"]:setString(good.count > 0 and res.locString("ItemMall$Buy") or res.locString("ItemMall$BuyDone"))
					set["btnDetail"]:setListener(function ( ... )
						GleeCore:showLayer(good.eventData.dialog, good.eventData.data)
					end)
				end
			end
		end)
	end

	self.shopItemList:update(self:getShopItemListData())

	setShop["layout_v1"]:setString(PlaygroundInfo.getPlayground().Score)
	setShop["layout_btnSend"]:setScale(#self.SendInfo > 0 and 1 or 0)
	setShop["layout_btnSend"]:setListener(function ( ... )
		GleeCore:showLayer("DPlaygroundSend", self.SendInfo)
	end)
end

function DPlaygroundShop:getShopItemListData( ... )
	local PlaygroundConfig = gameFunc.getActivityInfo().getDataByType(60)
	if PlaygroundConfig and PlaygroundConfig.Data and PlaygroundConfig.Data.Items then
		self.SendInfo = {}
		local list = {}
		for i=1,#PlaygroundConfig.Data.Items do
			local dbData = PlaygroundConfig.Data.Items[i]
			local nData = PlaygroundInfo.getPlayground().Items[i]
			if dbData and nData then
				local temp = table.clone(nData)
				temp.good = res.getRewardResList(dbData.Reward)
				table.insert(list, temp)
				if nData.Send then
					table.insert(self.SendInfo, {Idx = i - 1, Mid = temp.good[1].orgdata.MaterialId, Sent = nData.Sent or {}})
				end
			end
		end

		local result = {}
		for i,v in ipairs(list) do
			local a = math.floor((i - 1) / 4 + 1)
			local b = math.floor((i - 1) % 4 + 1)
			result[a] = result[a] or {}
			result[a][b] = v
		end
		print("DPlaygroundShop:getShopItemListData ======= ")
		print(list)
		return result
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPlaygroundShop, "DPlaygroundShop")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPlaygroundShop", DPlaygroundShop)
