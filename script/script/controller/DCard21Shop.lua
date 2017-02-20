local Config = require "Config"
local Card21Info = require "Card21Info"
local dbManager = require "DBManager"
local netModel = require "netModel"
local res = require "Res"
local LuaList = require "LuaList"
local gameFunc = require "AppData"

local DCard21Shop = class(LuaDialog)

function DCard21Shop:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DCard21Shop.cocos.zip")
    return self._factory:createDocument("DCard21Shop.cocos")
end

--@@@@[[[[
function DCard21Shop:onInitXML()
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
    self._layoutStar = set:getLayoutNode("layoutStar")
    self._piece = set:getElfNode("piece")
    self._name = set:getLabelNode("name")
    self._count = set:getLabelNode("count")
    self._layoutPrice = set:getLinearLayoutNode("layoutPrice")
    self._layoutPrice_icon = set:getElfNode("layoutPrice_icon")
    self._layoutPrice_v2 = set:getLabelNode("layoutPrice_v2")
    self._btnOk = set:getClickNode("btnOk")
    self._btnDetail = set:getButtonNode("btnDetail")
    self._commonDialog_cnt_layoutChip = set:getLinearLayoutNode("commonDialog_cnt_layoutChip")
    self._commonDialog_cnt_layoutChip_v0 = set:getLabelNode("commonDialog_cnt_layoutChip_v0")
    self._commonDialog_cnt_layoutChip_v1 = set:getLabelNode("commonDialog_cnt_layoutChip_v1")
    self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
    self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
--    self._@size = set:getElfNode("@size")
--    self._@itemGood = set:getElfNode("@itemGood")
end
--@@@@]]]]

--------------------------------override functions----------------------

local Launcher = require 'Launcher'
Launcher.register("DCard21Shop", function ( userData )
   	Launcher.callNet(netModel.getModelCard21ShopInfo(), function ( data )
   		print("Card21ShopInfo")
   		print(data)
   		if data and data.D then
   			Card21Info.setRecordsEx(data.D.Records)
	   		Card21Info.setItems(data.D.Items)
	   		Launcher.Launching(data)   
   		end
 	end)
end)

function DCard21Shop:onInit( userData, netData )
	self:updateLayer()
	self:setListenerEvent()
	res.doActionDialogShow(self._commonDialog)
end

function DCard21Shop:onBack( userData, netData )
	self:updateLayer()
end

--------------------------------custom code-----------------------------

function DCard21Shop:setListenerEvent( ... )
	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._commonDialog_btnClose:setListener(function (  )
		res.doActionDialogHide(self._commonDialog, self)
	end)
end

function DCard21Shop:updateLayer( ... )
	self._commonDialog_cnt_layoutChip_v1:setString( Card21Info.getCard21().Score )

	if not self.listShop then
		self.listShop = LuaList.new(self._commonDialog_cnt_bg_list, function (  )
			local sizeSet = self:createLuaSet("@size")
			sizeSet["setList"] = {}
			for i=1,4 do
				local itemSet = self:createLuaSet("@itemGood")
				sizeSet["layout"]:addChild(itemSet[1])
				table.insert(sizeSet["setList"], itemSet)
			end
			return sizeSet
		end, function ( nodeLuaSet, dataList )
			local itemSetList = nodeLuaSet["setList"]
			for i,item in ipairs(itemSetList) do
				item[1]:setVisible(i <= #dataList)
				if i <= #dataList then
					local data = dataList[i]
					local info = data.info
					local rewardList = res.getRewardResList(info.Reward)
					local v = rewardList[1]
					local scaleOrigal = 124 / 155
					item["icon_bg"]:setResid( v.bg )
					item["icon"]:setResid(v.icon)
					if v.type == "Pet" or v.type == "PetPiece" then
						item["icon"]:setScale(scaleOrigal * 140 / 95)
					else
						item["icon"]:setScale(scaleOrigal)
					end

					item["iconFrame"]:setResid(v.frame)
					item["iconFrame"]:setScale(scaleOrigal)
					
					item["layoutStar"]:removeAllChildrenWithCleanup(true)
					if v.type == "Pet" or v.type == "PetPiece" then
						local dbPet = dbManager.getCharactor(v.eventData.data.PetInfo.PetId)
						require 'PetNodeHelper'.updateStarLayout(item["layoutStar"], dbPet)
					end

					if v.type == "Gem" then
						item["name"]:setString(v.name .. " Lv." .. v.lv)
					else
						item["name"]:setString(v.name)
					end
					local lastCount = Card21Info.getExRecordWithId(info.Id)
					item["count"]:setString( string.format(res.locString("Global$Last"), lastCount) )
					if lastCount == 0 then
						item["count"]:setFontFillColor(res.color4F.red, true)
					else
						item["count"]:setFontFillColor(res.color4F.white, true)
					end	

					item["piece"]:setVisible(v.isPiece)
					item["layoutPrice_v2"]:setString(info.Score)
					item["btnDetail"]:setListener(function ( ... )
						if v.eventData then
							GleeCore:showLayer(v.eventData.dialog, v.eventData.data)
						end
					end)
					item["btnOk"]:setEnabled(Card21Info.getCard21().Score >= info.Score and lastCount > 0)
					item["btnOk"]:setListener(function ( ... )
						if Card21Info.getCard21().Score >= info.Score then
							local function Card21Exchange( amt, closeBuyLayer )
								self:send(netModel.getModelCard21ShopEx(info.Id, amt), function ( data )
									if data and data.D then
			   							if closeBuyLayer then
			   								closeBuyLayer()
			   							end

										Card21Info.setCard21(data.D.Card21)
			   							Card21Info.setRecordsEx(data.D.Records)
			   							gameFunc.updateResource(data.D.Resource)
			   							self:updateLayer()
			   							res.doActionGetReward(data.D.Reward)

			   							require "EventCenter".eventInput("UpdateCard21Chip")
									end
								end)
							end

							if lastCount == 1 or Card21Info.getCard21().Score < info.Score * 2 then
								Card21Exchange(1)
							else
								local param = {}
								param.itemType = "RewardType"
								param.costIcon = "HD1_21_CM.png"
								param.costIconScale = 0.5
								param.hbReward = v
								param.hbPrice = info.Score
								param.hbAmtLimit = math.min( math.floor(Card21Info.getCard21().Score / info.Score), lastCount )
								param.callback = function ( data )
									Card21Exchange(data.amt, data.closeBuyLayer)
								end
								GleeCore:showLayer("DMallItemBuy", param)	
							end
						else
							self:toast(res.locString("Card21$ScoreNotEnough"))
						end
					end)

					res.addRuneStars(item["iconFrame"], v)
				end
			end
		end)
	end

	self.listShop:update(self:getExchangeDataList())
end

function DCard21Shop:getExchangeDataList( ... )
	local list = {}
	local items = Card21Info.getItems()
	local records = Card21Info.getRecordsEx()
	if items ~= nil and records ~= nil and #items >= #records then
		for i=1,#items do
			table.insert(list, {info = items[i], record = records[i]})
		end
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

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DCard21Shop, "DCard21Shop")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DCard21Shop", DCard21Shop)
