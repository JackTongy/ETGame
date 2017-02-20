local res = require "Res"
local dbManager = require "DBManager"
local LuaList = require "LuaList"
local gameFunc = require "AppData"
local netModel = require "netModel"
local userFunc = gameFunc.getUserInfo()
local SilverCoinInfo = gameFunc.getSilverCoinInfo()

local function updateView( self, view, oldshowActivityType )
	local silverCoinData = gameFunc.getActivityInfo().getDataByType(48)
	print("-----silverCoinData")
	print(silverCoinData)
	if silverCoinData then
		if -math.floor(require "TimeListManager".getTimeUpToNow(silverCoinData.CloseAt)) <= 0 then
			self:onActivityFinish( require 'ActivityType'.LoveOfWater )
			return
		end

		local seconds = -math.floor(require "TimeListManager".getTimeUpToNow(silverCoinData.CloseAt)) - 3600 * 24
		seconds = math.max(seconds, 0)
		local isTimeEnd = seconds == 0
		local date = view["layout1_timer"]:getElfDate()
		date:setHourMinuteSecond(0, 0, seconds)
		date:setTimeFormat(DayHourMinuteSecond)
		if seconds > 0 then
			view["layout1_timer"]:setUpdateRate(-1)
			view["layout1_timer"]:addListener(function (  )
				updateView( self, view, require 'ActivityType'.LoveOfWater )
			end)
		else
			view["layout1_timer"]:setUpdateRate(0)
			if oldshowActivityType ~= require 'ActivityType'.LoveOfWater then
				self:runWithDelay(function ( ... )
					GleeCore:showLayer("DSilverCoinRankList")
				end, 0.5)
			end
		end

		require 'LangAdapter'.fontSize(view["#tip"], nil, nil, 15, nil, nil)

		local nWater = gameFunc.getBagInfo().getItemWithItemId(68)
		view.iStar = nWater and nWater.Amount or 0 -- 自己的水滴数
		view["bg1_v"]:setString(view.iStar)

		view.sendStar = view.sendStar or 0
		local function updateStarView( ... )
			view["textBg_text"]:setString(view.sendStar)
			view["btnSend"]:setEnabled(view.sendStar > 0 and view.sendStar <= view.iStar and not isTimeEnd)
		end
		updateStarView()
		
		view["btnBuy"]:setEnabled(not isTimeEnd)
		view["btnBuy"]:setListener(function ( ... )
			self.mTabBtns[require 'ActivityType'.SilverCoinShop]:trigger(nil)
	--		self:updateView(require 'ActivityType'.SilverCoinShop)
		end)

		view["btnSend"]:setListener(function ( ... )
			local UnlockManager = require 'UnlockManager'
			if not UnlockManager:isUnlock("watergift") then
				self:toast(UnlockManager:getUnlockConditionMsg("watergift"))
			elseif require "UserInfo".getData().HiPwr < 100000 then
				self:toast(string.format(res.locString("SilverCoinShop$SendCondition"), 100000))
			else
				GleeCore:showLayer("DSilverCoinFriend", {StarAmount = view.sendStar, callback = function ( ... )
					view.sendStar = 0
					updateStarView()
				end})
			end
		end)

		view["btnRankList"]:setListener(function ( ... )
			GleeCore:showLayer("DSilverCoinRankList")
		end)

		view["btnDetail"]:setVisible(false)
		view["btnDetail"]:setListener(function ( ... )
			GleeCore:showLayer("DHelp", {type = "心之水滴"})
		end)

		view["btnSub10"]:setListener(function ( ... )
			view.sendStar = math.max(view.sendStar - 10, 0)
			updateStarView()
		end)

		view["btnAdd10"]:setListener(function ( ... )
			view.sendStar = math.min(view.sendStar + 10, view.iStar)
			updateStarView()
		end)

		view["btnSub1"]:setListener(function ( ... )
			view.sendStar = math.max(view.sendStar - 1, 0)
			updateStarView()
		end)

		view["btnAdd1"]:setListener(function ( ... )
			view.sendStar = math.min(view.sendStar + 1, view.iStar)
			updateStarView()
		end)

		view["btnSub10"]:setEnabled(not isTimeEnd)
		view["btnAdd10"]:setEnabled(not isTimeEnd)
		view["btnSub1"]:setEnabled(not isTimeEnd)
		view["btnAdd1"]:setEnabled(not isTimeEnd)
	else
		self:onActivityFinish( require 'ActivityType'.LoveOfWater )
	end
end

local update = function ( self, view, data, showActivityType, oldshowActivityType )
	if data and data.D then
		SilverCoinInfo.setRecord(data.D.Record)
		SilverCoinInfo.setBuys(data.D.Buys)
		SilverCoinInfo.setSells(data.D.Sells)
		SilverCoinInfo.setStarAmount(data.D.StarAmount)
		updateView(self, view, oldshowActivityType)
	else
		self:onActivityFinish( require 'ActivityType'.LoveOfWater )
	end
end

local getNetModel = function ( )
	return netModel.getModelMysteryShopGet()
end

return {update = update, getNetModel = getNetModel}