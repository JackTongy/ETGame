local res = require "Res"
local gameFunc = require "AppData"
local netModel = require "netModel"

local update
update = function ( self, view, data )
	local mCardData = gameFunc.getActivityInfo().getDataByType(31)
	if mCardData and data and data.D then
		print("mCardData = ")
		print(mCardData)
		local timeManager = require "TimeManager"
		local openTime = os.date("*t", timeManager.getTimestamp(mCardData.OpenAt))
		local closeTime = os.date("*t", timeManager.getTimestamp(mCardData.CloseAt))
		view["bg_date"]:setString(string.format(res.locString("Activity$TownDoubleTime"), openTime.month, openTime.day, openTime.hour, closeTime.month, closeTime.day, closeTime.hour))
		require 'LangAdapter'.selectLang(nil, nil, function ( ... )
			view["bg_date"]:setString(string.format(res.locString("Activity$TownDoubleTime"), openTime.hour, openTime.day, openTime.month, closeTime.hour, closeTime.day, closeTime.month))
		end)
		require 'LangAdapter'.selectLangkv({German=function ( ... )
		    view["bg_date"]:setString(string.format(res.locString("Activity$TownDoubleTime"),  openTime.day, openTime.month, openTime.hour, closeTime.day, closeTime.month,closeTime.hour))
		end})

		view["bg_layout"]:removeAllChildrenWithCleanup(true)
		local rewardList = res.getRewardResList(mCardData.Data)
		if rewardList then
			for i,v in ipairs(rewardList) do
				local item = view.createLuaSet("@item")
				view["bg_layout"]:addChild(item[1])
	
				local scaleOrigal = 110 / 155
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
				item["btn"]:setListener(function ( ... )
					if v.eventData then
						GleeCore:showLayer(v.eventData.dialog, v.eventData.data)
					end
				end)

				res.addRuneStars(item["frame"], v)
			end
		end

		if data.D.State == 0 then
			view["bg_btnGet_title"]:setString(res.locString("Global$Receive"))
		elseif data.D.State == 1 then
			view["bg_btnGet_title"]:setString(res.locString("Global$ReceiveFinish"))
		elseif data.D.State == 2 then
			view["bg_btnGet_title"]:setString(res.locString("Global$BtnRecharge"))
		end
		view["bg_btnGet"]:setEnabled(data.D.State ~= 1)
		view["bg_btnGet"]:setListener(function ( ... )
			if data.D.State == 0 then
				self:send(netModel.getModelMCardGiftReward(), function ( netData )
					if netData and netData.D then
						data.D.State = 1
						update(self, view, data)

						gameFunc.updateResource(netData.D.Resource)
						res.doActionGetReward(netData.D.Reward)
					end
				end)
			elseif data.D.State == 2 then
				GleeCore:showLayer("DRecharge")
			end
		end)
	end
end

local getNetModel = function ( )
	return netModel.getModelMCardGiftGet()
end

return {update = update, getNetModel = getNetModel}