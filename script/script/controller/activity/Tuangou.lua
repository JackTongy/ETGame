-- local Config = require "Config"

-- local Tuangou = class(LuaController)

-- function Tuangou:createDocument()
--     self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."Tuangou.cocos.zip")
--     return self._factory:createDocument("Tuangou.cocos")
-- end

--@@@@[[[[
-- function Tuangou:onInitXML()
--     local set = self._set
--    self._timeLayout = set:getLinearLayoutNode("timeLayout")
--    self._timeLayout_time = set:getTimeNode("timeLayout_time")
--    self._layout = set:getLinearLayoutNode("layout")
--    self._layout_count2 = set:getLabelNode("layout_count2")
--    self._layout_count1 = set:getLabelNode("layout_count1")
--    self._list = set:getListNode("list")
--    self._icon = set:getElfNode("icon")
--    self._name = set:getLabelNode("name")
--    self._count = set:getLabelNode("count")
--    self._btn = set:getButtonNode("btn")
--    self._zhekou_label = set:getLabelNode("zhekou_label")
--    self._barBg_p = set:getProgressNode("barBg_p")
--    self._barBg_line1 = set:getElfNode("barBg_line1")
--    self._barBg_line2 = set:getElfNode("barBg_line2")
--    self._barBg_line3 = set:getElfNode("barBg_line3")
--    self._up1 = set:getLabelNode("up1")
--    self._up2 = set:getLabelNode("up2")
--    self._up3 = set:getLabelNode("up3")
--    self._up4 = set:getLabelNode("up4")
--    self._up5 = set:getLabelNode("up5")
--    self._down1 = set:getLabelNode("down1")
--    self._down2 = set:getLabelNode("down2")
--    self._down3 = set:getLabelNode("down3")
--    self._down4 = set:getLabelNode("down4")
--    self._down5 = set:getLabelNode("down5")
--    self._layout2 = set:getLinearLayoutNode("layout2")
--    self._layout2_count = set:getLabelNode("layout2_count")
--    self._layout3_count = set:getLabelNode("layout3_count")
--    self._buyTipLabel = set:getLabelNode("buyTipLabel")
--    self._buyCount = set:getLabelNode("buyCount")
--    self._buyBtn = set:getClickNode("buyBtn")
--    self._line = set:getElfNode("line")
-- --   self._@view = set:getElfNode("@view")
-- --   self._@item = set:getElfNode("@item")
-- end
--@@@@]]]]

-- --------------------------------override functions----------------------
-- function Tuangou:onInit( userData, netData )
	
-- end

-- function Tuangou:onBack( userData, netData )
	
-- end

-- --------------------------------custom code-----------------------------


-- --------------------------------class end-------------------------------
-- require 'framework.basic.MetaHelper'.classDefinitionEnd(Tuangou, "Tuangou")


-- --------------------------------register--------------------------------
-- GleeCore:registerLuaController("Tuangou", Tuangou)

local res = require "Res"
local dbManager = require "DBManager"
local netModel = require "netModel"
local eventCenter = require 'EventCenter'
local userFunc = require "UserInfo"
local RechargeConfig = require "ChargeConfig"
local petFunc = require "PetInfo"
local equipFunc = require "EquipInfo"
local gemFunc = require "GemInfo"
local bagFunc = require "BagInfo"
local timeTool = require "TimeListManager"
local LangAdapter = require 'LangAdapter'

local DiscountSteps = 5

local function getCurRateIndex( buycount,discountList )
	for i=1,#discountList do
		local v = discountList[i]
		if v.Amount>buycount then
			return i-1
		end
	end
	return #discountList
end

local function getRateString( d )
	if require 'Config'.LangName == 'thai' then
		return string.format(res.locString("Activity$TuangouZhekou"),math.floor(10*d*100+0.5)/10)
	elseif require "Config".LangName == "kor" then
		return math.floor(d*100+0.5).."%"
	elseif require "Config".LangName == "english" then
		return string.format(res.locString("Activity$TuangouZhekou"),math.floor((1-d)*100+0.5))
	elseif require "Config".LangName == "vn" then
		return string.format(res.locString("Activity$TuangouZhekou"),math.floor((1-d)*100+0.5).."%")
	elseif require "Config".LangName == "German" then
		return string.format(res.locString("Activity$TuangouZhekou"),math.floor((1-d)*100+0.5)) 
	else
		return string.format(res.locString("Activity$TuangouZhekou"),math.floor(d*100+0.5)/10)
	end
end

local function getPercent( buy,config )
	if buy <= 0 then
		return 0
	end
	local pre = 0
	for i=2,DiscountSteps do
		local c = config.Discounts[i].Amount
		if buy<=c then
			return (i-2)*0.25+0.25*(buy-pre)/(c-pre)
		end
		pre = c 
	end
	return 1
end

local updateItem
updateItem = function ( self,view,set,itemIndex,itemData )
	local netData = view.mData
	local actConfig = view.mActData.Data.Items[itemIndex]

	local curBuyAll = netData.AreadyBuys[itemIndex]
	local curBuySelf = netData.BuyRecords[itemIndex]
	local rateIndex = getCurRateIndex(curBuyAll,actConfig.Discounts)

	local percent = getPercent(curBuyAll,actConfig)

	set["barBg_line1"]:setVisible(percent>0.25)
	set["barBg_line2"]:setVisible(percent>0.5)
	set["barBg_line3"]:setVisible(percent>0.75)
	set["barBg_p"]:setPercentage(percent*100)

	for i=1,5 do
		local upNode = set["up"..i]
		upNode:setFontFillColor(rateIndex ~= i and ccc4f(0,0,0,1) or ccc4f(0.776,0,0,1),true)
		upNode:setFontSize(rateIndex ~= i and 18 or  26)
		require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
			upNode:setFontSize(rateIndex ~= i and 14 or 18)
		end)
	end
	set["down1"]:setString(string.format(res.locString("Activity$TuangouCurBuy"),curBuyAll))

	local curRate = actConfig.Discounts[rateIndex].Discount
	set["zhekou_label"]:setString(getRateString(curRate))
	require 'LangAdapter'.LabelNodeAutoShrink(set['zhekou_label'],70)
	local price = math.floor(actConfig.Price * curRate)
	set["layout3_count"]:setString(price)

	set["buyCount"]:setString(string.format("( %d/%d )",actConfig.Amount - curBuySelf,actConfig.Amount))
	require 'LangAdapter'.LabelNodeAutoShrink(set["buyBtn_#label"],60)
	
	set["buyBtn"]:setEnabled(curBuySelf<actConfig.Amount)
	set["buyBtn"]:setListener(function (  )
		local netData = view.mData
		local realCost = price - netData.GroupPurchase.CardAmount
		realCost = realCost >=0 and realCost or 0
		if userFunc.getCoin()<realCost then
			return require "Toolkit".showDialogOnCoinNotEnough()
		end
		local param = {}
		local des1
		if netData.GroupPurchase.CardAmount>0 and realCost>0 then
			des1 = string.format("[color=00ff00ff]%d[/color]%s,[image=TY_jinglingshi_xiao.png] [/image][color=00ff00ff]%d[/color]",netData.GroupPurchase.CardAmount,res.locString("Activity$TuangouCurHas2"),realCost)
		elseif netData.GroupPurchase.CardAmount>0 then
			des1 = string.format("[color=00ff00ff]%d[/color]%s",netData.GroupPurchase.CardAmount,res.locString("Activity$TuangouCurHas2"))
		else
			des1 = string.format("[image=TY_jinglingshi_xiao.png] [/image][color=00ff00ff]%d[/color]",realCost)
		end
		local des2  = string.format("%sx%d",itemData.name,itemData.count)

		param.content = string.format(res.locString("Global$BuyConfirmTip"),des1,des2)
		param.callback = function (  )
			self:send(netModel.getModelTuangouBuy(itemIndex),function ( data )
				local reward = data.D.Reward
				reward.callback = function (  )
					require "AppData".updateResource(data.D.Resource)
					data.D.Resource = nil
					data.D.Reward = nil
					view.mData = data.D
					view["layout_count1"]:setString(view.mData.GroupPurchase.CardAmount)
					view["layout_count2"]:setString(userFunc.getCoin())
					updateItem(self,view,set,itemIndex,itemData)
				end
				GleeCore:showLayer("DGetReward", reward)
			end)
		end
		GleeCore:showLayer("DConfirmNT",param)
	end)
end

local update
update = function ( self,view,data )
	view.mData = data.D
	view.mActData = require "ActivityInfo".getDataByType(35)

	LangAdapter.nodePos(view['timeLayout'],ccp(-280.0,85.0))
	LangAdapter.nodePos(view['layout'],ccp(-280.0,64.0))
	
	local lastTime =  -math.floor(timeTool.getTimeUpToNow(view.mActData.CloseAt))
	view["timeLayout_time"]:setHourMinuteSecond(timeTool.getTimeInfoBySeconds(lastTime))
	view.mActTimeListener = ElfDateListener:create(function ( ... )
		view.mActTimeListener = nil
		return self:onActivityFinish(self.curShowActivity)
	end)
	view.mActTimeListener:setHourMinuteSecond(0,0,1)
	view["timeLayout_time"]:addListener(view.mActTimeListener)

	view["layout_count1"]:setString(view.mData.GroupPurchase.CardAmount)
	view["layout_count2"]:setString(userFunc.getCoin())

	local listData = view.mActData.Data.Items
	for i,v in ipairs(listData) do
		local set = view.createLuaSet("@item")
		local itemData = res.getRewardResList(v.Reward)[1]
		res.setNodeWithRewardData(itemData,set["icon"])
		set["name"]:setString(itemData.name)
		require "LangAdapter".LabelNodeAutoShrink(set["name"],140)
		set["count"]:setString("x"..itemData.count)
		if itemData.eventData then
			set["btn"]:setListener(function (  )
				GleeCore:showLayer(itemData.eventData.dialog,itemData.eventData.data)
			end)
		end

		set["layout2_count"]:setString(v.Price)
		set["layout2"]:layout()
		local size = set["layout2"]:getContentSize()
		local x,y = set["layout2"]:getPosition()
		set["line"]:setPosition(x+size.width/2,y)
		set["line"]:setScaleX(size.width/2)
		set["line"]:setScaleY(2)
		set["line"]:setRotation(-math.atan((size.height-15)/size.width)*180/math.pi)

		for k=1,DiscountSteps do
			local d = v.Discounts[k]
			local upNode = set["up"..k]
			upNode:setString(getRateString(d.Discount))
			
			local downNode = set["down"..k]
			if k~=1 then
				downNode:setString(d.Amount)
			end
		end

		updateItem(self,view,set,i,itemData)

		view["list"]:addListItem(set[1])
	end
	self:roleNewsUpdate(self.curShowActivity,true)
end

local function getNetModel( )
	return netModel.getModelTuangouGet()
end

return {getNetModel = getNetModel,update = update}
