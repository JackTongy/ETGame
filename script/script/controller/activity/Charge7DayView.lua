local appData = require 'AppData'
local netModel = require "netModel"
local res = require "Res"

local update,update1,updateItem

update = function ( self,view,data )
	local rechargeToday = data.D.Today
	local tags = data.D.Records
	local days = data.D.Days
	view["text1_textday"]:setString(string.format(res.locString("Activity$Charge7DayTitle"),days))
	view["text1_textday"]:setAnchorPoint(ccp(0,0.5))
	view["text1_textday"]:setPosition(-400,-4)
	require 'LangAdapter'.fontSize(view["text1_textday"],nil,nil,nil,nil,40)

	require 'LangAdapter'.fontSize(view["charge1"],nil,nil,nil,nil,16)
	require 'LangAdapter'.fontSize(view["charge2"],nil,nil,nil,nil,16)
	require 'LangAdapter'.fontSize(view["charge3"],nil,nil,nil,nil,16)
	require 'LangAdapter'.fontSize(view["charge4"],nil,nil,nil,nil,16)
	local southAmericaAdjust = function(  )
		view["text1_textday"]:setDimensions(CCSize(280,0))
		view["text1_textday"]:setAnchorPoint(ccp(0,1))
		view["text1_textday"]:setPosition(-404,45)
		view["#text"]:setPosition(-225,170)
	end

	selectLang(nil,nil,nil,nil,nil,southAmericaAdjust,southAmericaAdjust)

	view["#rewardTodayText"]:setAnchorPoint(ccp(0,0.5))
	view["#rewardTodayText"]:setPosition(-317,146)

	view["rewardTomorrowText"]:setAnchorPoint(ccp(0,0.5))
	view["rewardTomorrowText"]:setPosition(-317,-36)

	view["txtCharge"]:setString(rechargeToday.."")
	local label_x,label_y = view["#text"]:getPosition()
	local w = view["#text"]:getContentSize().width
	view["txtCharge"]:setPosition(label_x+w/2,label_y)
	
	view["tag1"]:setVisible(tags[1] == 1)
	view["tag2"]:setVisible(tags[2] == 1)
	local dataList = data.D.Data 
	if #dataList == 1 then
		view["rewardTomorrowText"]:setVisible(false)
		view["QR_bg2"]:setVisible(false)
		view["charge3"]:setVisible(false)
		view["charge4"]:setVisible(false)
		view["rewardTomorrowlayout1"]:setVisible(false)
		view["rewardTomorrowlayout2"]:setVisible(false)
	end
	for k,v in ipairs(dataList) do
		update1(self,view,k,v)
	end

	view["btnRecharge"]:setListener(function ( ... )
		self:close()
		require "framework.sync.TimerHelper".tick(function ( ... )
			GleeCore:showLayer("DRecharge")
			return true
		end)
	end)

	view["btnDetails"]:setListener(function ( ... )
		GleeCore:showLayer("DCharge7DayDetail")
	end)
end

local function formatMoney(m)
	-- if m<10 then
	-- 	return " "..m
	-- else
		return tostring(m)
	-- end
end

update1 = function ( self,view,key,v)
	local money1 = v.Money1
	local reward1 = v.Reward1
	local money2 = v.Money2
	local reward2 = v.Reward2
	local rewardList1 = res.getRewardResList( reward1 )
	local rewardList2 = res.getRewardResList( reward2 )
	local layout1,layout2
	local charge1,charge2

	if key == 1 then
		layout1 = "rewardTodaylayout1"
		layout2 = "rewardTodaylayout2"
		charge1 = "charge1"
		charge2 = "charge2"
	else
		layout1 = "rewardTomorrowlayout1"
		layout2 = "rewardTomorrowlayout2"
		charge1 = "charge3"
		charge2 = "charge4"
	end
	view[layout1]:removeAllChildrenWithCleanup(true)
	for i,v in ipairs(rewardList1) do
		updateItem(self,view,v,layout1)
	end
	-- view[charge1]:setString(string.format(res.locString("Activity$Charge7DayNeedRecharge"), formatMoney(money1)))
	-- money1
	if money1 > 10 then 
		view[charge1]:setString(string.format(res.locString("Activity$Charge7DayNeedRecharge"), formatMoney(money1)))
	end

	view[layout2]:removeAllChildrenWithCleanup(true)
	for i,v in ipairs(rewardList2) do
		updateItem(self,view,v,layout2)
	end
	view[charge2]:setString(string.format(res.locString("Activity$Charge7DayNeedRecharge"), formatMoney(money2)))
end

updateItem = function ( self,view,v,layout )
	local scaleOrigal = 1
	local item = view.createLuaSet("@item")
	
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
	
	if v.eventData then
		item["btn"]:setEnabled(true)
		local dialog = v.eventData.dialog
		local  dialogData = v.eventData.data
		item["btn"]:setListener(function ( ... )
			GleeCore:showLayer(dialog, dialogData)
		end)
	end

	view[layout]:addChild(item[1])
end

local function getNetModel( )
	return netModel.getModelCharge7Day()
end

return {getNetModel = getNetModel,update = update}