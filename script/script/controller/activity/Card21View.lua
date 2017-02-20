local res = require "Res"
local dbManager = require "DBManager"
local gameFunc = require "AppData"
local netModel = require "netModel"
local userFunc = gameFunc.getUserInfo()
local Card21Info = gameFunc.getCard21Info()

local update
update = function ( self, view, data )
	local card21Data = gameFunc.getActivityInfo().getDataByType(37)
	if card21Data and data and data.D then
		Card21Info.setCard21(data.D.Card21)
		local card21 = data.D.Card21
		view["bg_bg0_chip"]:setString(card21.Score)
		view["bg_bg0_coin"]:setString(userFunc.getCoin())

		local seconds = -math.floor(require "TimeListManager".getTimeUpToNow(card21Data.CloseAt))
		seconds = math.max(seconds, 0)
		local date = view["bg_layout1_timer"]:getElfDate()
		date:setHourMinuteSecond(0, 0, seconds)
		if seconds > 0 then
			view["bg_layout1_timer"]:setUpdateRate(-1)
			view["bg_layout1_timer"]:addListener(function (  )
				self:onActivityFinish( require 'ActivityType'.Card21 )
			end)
		else
			view["bg_layout1_timer"]:setUpdateRate(0)
		end

		view["bg_btnReward"]:setListener(function ( ... )
			GleeCore:showLayer("DCard21Shop")
		end)

		view["bg_btnExchange"]:setListener(function ( ... )
			GleeCore:showLayer("DCard21ExchangeChip")
		end)

		view["bg_btnTry"]:setListener(function ( ... )
			GleeCore:pushController("CCard21", nil, nil, res.getTransitionFade())
		end)

		view["bg_btnDetail"]:setListener(function ( ... )
			GleeCore:showLayer("DHelp", {type = "游戏厅游戏"})
		end)
	end
end

local getNetModel = function ( )
	return netModel.getModelCard21Get()
end

return {update = update, getNetModel = getNetModel}