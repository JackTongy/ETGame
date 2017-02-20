local res = require "Res"
local dbManager = require "DBManager"
local gameFunc = require "AppData"
local netModel = require "netModel"
local userFunc = gameFunc.getUserInfo()

local wellCoinList = {30, 300, 1000, 3000}

local function updateLayer( self, view, wellData )
	if wellData and wellData.Stage < #wellCoinList then
		local seconds = -math.floor(require "TimeListManager".getTimeUpToNow(wellData.DisppearAt))
		seconds = math.max(seconds, 0)
		local date = view["bg_layoutTime_v"]:getElfDate()
		date:setHourMinuteSecond(0, 0, seconds)
		if seconds > 0 then
			view["bg_layoutTime_v"]:setUpdateRate(-1)
			view["bg_layoutTime_v"]:addListener(function (  )
				self:onActivityFinish( require 'ActivityType'.WellPet )
			end)
		else
			view["bg_layoutTime_v"]:setUpdateRate(0)
			self:onActivityFinish( require 'ActivityType'.WellPet )
		end
		local cost = wellCoinList[wellData.Stage + 1]
		view["bg_des"]:setFontFillColor(ccc4f(0, 0, 1, 0), true)
		view["bg_des"]:setString( string.format(res.locString("Activity$WellPetDes"), cost) )

		view["bg_btnLucky"]:setListener(function ( ... )
			if userFunc.getCoin() >= cost then
				self:send(netModel.getModelWellUse(), function ( netData )
					print("WellUse___")
					print(netData)
					if netData and netData.D then
						userFunc.setCoinWell(netData.D.Well)
						if not netData.D.Reward then
							self:onActivityFinish( require 'ActivityType'.WellPet )
						else
							userFunc.setCoin( netData.D.Coin )
							require 'EventCenter'.eventInput("UpdateGoldCoin")
							local param = {}
							param.coin = netData.D.Reward.Coin + wellCoinList[netData.D.Well.Stage]
							param.oldCoin = wellCoinList[netData.D.Well.Stage]
							param.callback = function ( ... )
								updateLayer( self, view, netData.D.Well )
							end
							GleeCore:showLayer("DWellPet", param)
						end
					end
				end)
			else
				require "Toolkit".showDialogOnCoinNotEnough()
			end
		end)
	else
		self:onActivityFinish( require 'ActivityType'.WellPet )
	end
end

local update = function ( self, view, data )
	userFunc.setCoinWell(data.D.Well)
	updateLayer( self, view, data and data.D and data.D.Well )
end

local getNetModel = function ( )
	return netModel.getModelWellGet()
end

return {update = update, getNetModel = getNetModel}