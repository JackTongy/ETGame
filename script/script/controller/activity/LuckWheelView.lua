local res = require "Res"
local dbManager = require "DBManager"
local gameFunc = require "AppData"
local netModel = require "netModel"
local userFunc = gameFunc.getUserInfo()

local function fadeAction( delta, callback, callback2, forever )
	local actArray = CCArray:create()
	if callback then
		actArray:addObject(CCCallFunc:create(function ( ... )
			callback()
		end))
	end
	actArray:addObject(CCFadeIn:create(delta / 6))
	actArray:addObject(CCFadeOut:create(delta * 5 / 6))
	if callback2 then
		actArray:addObject(CCCallFunc:create(function ( ... )
			callback2()
		end))
	end
	if forever then
		return CCRepeatForever:create(CCSequence:create(actArray))
	else
		return CCSequence:create(actArray)
	end
end

local update
update = function ( self, view, data )
	local function setViewTouchEnabled( enable )
		view["shield"]:setVisible(not enable)
	end

	local luckyData = gameFunc.getActivityInfo().getDataByType(30)
	if luckyData and data and data.D then
		setViewTouchEnabled(true)
		view["count"]:setString(string.format(res.locString("Activity$LuckyWheelTimes"), data.D.Activity.FreeCnt))

		local seconds = -math.floor(require "TimeListManager".getTimeUpToNow(luckyData.CloseAt))
		seconds = math.max(seconds, 0)
		local date = view["layout1_timer"]:getElfDate()
		date:setHourMinuteSecond(0, 0, seconds)
		if seconds > 0 then
			view["layout1_timer"]:setUpdateRate(-1)
			view["layout1_timer"]:addListener(function (  )
				self:onActivityFinish( require 'ActivityType'.LuckWheel )
			end)
		else
			view["layout1_timer"]:setUpdateRate(0)
		end
		
		local costOne = dbManager.getInfoDefaultConfig("LuckyBuy1").Value
		local costTen = dbManager.getInfoDefaultConfig("LuckyBuy10").Value
		local costRefresh = dbManager.getInfoDefaultConfig("LuckyRefresh").Value

		local function doActionBg( ... )
			local img = "N_HD_yj_k3.png"
			view["kbg_bg"]:runAction(fadeAction(0.5, function ( ... )
				if img == "N_HD_yj_k4.png" then
					img = "N_HD_yj_k2.png"
				elseif img == "N_HD_yj_k2.png" then
					img = "N_HD_yj_k1.png"
				elseif img == "N_HD_yj_k1.png" then
					img = "N_HD_yj_k2.png"
				elseif img == "N_HD_yj_k3.png" then
					img = "N_HD_yj_k4.png"
				end
				view["kbg_bg"]:setResid(img)
				view["kbg_bg"]:setOpacity(0)
			end, nil, true))
		end

		view["btnTurn1"]:setListener(function ( ... )
			if data.D.Activity.FreeCnt > 0 or userFunc.getCoin() >= costOne then
				self:send(netModel.getModelLuckyDrawDraw(false), function ( data )
					if data and data.D then
						gameFunc.updateResource(data.D.Resource)
						
						setViewTouchEnabled(false)
						doActionBg()
						local tSpeed = 1
						local tSpeed2 = 1
						local theIndex = 24 + data.D.Index or 5
						local speedDis = 6
						local speedDis2 = 8
						for thei=1,theIndex do
							local i = math.fmod(thei - 1, 12) + 1
							view[string.format("kbg_item%d_hale", i)]:setOpacity(0)
							view[string.format("kbg_item%d_hale", i)]:setVisible(true)
							view[string.format("kbg_item%d_hale", i)]:runAction(fadeAction(1, nil, function ( ... )
								if thei <= speedDis + 1 then
									self:runWithDelay(function ( ... )
										view[string.format("kbg_item%d_hale", i)]:runAction(fadeAction(1))
									end, math.sqrt( (thei - 1)/speedDis ) * tSpeed )
								elseif thei >= theIndex - speedDis2 then
									local tttt = tSpeed + (theIndex - speedDis2 - speedDis - 1) * (tSpeed / (2 * speedDis)) + tSpeed2 - math.sqrt( (theIndex - thei) / speedDis2) * tSpeed2
									if thei == theIndex then
										self:runWithDelay(function ( ... )
											view[string.format("kbg_item%d_hale", i)]:runAction(fadeAction(1, nil, function ( ... )
												view["kbg_bg"]:setResid("N_HD_yj_k3.png")
												view["kbg_bg"]:stopAllActions()

												view[string.format("kbg_item%d_hale", i)]:runAction(fadeAction(1, nil, function ( ... )
													setViewTouchEnabled(true)
													
													data.D.Rewards[1].callback = function ( ... )
														update(self, view, data)
													end
													res.doActionGetReward(data.D.Rewards[1])
												end))

											end))
										end, tttt )
									else
										self:runWithDelay(function ( ... )
											view[string.format("kbg_item%d_hale", i)]:runAction(fadeAction(1))
										end, tttt )
									end
								else
									self:runWithDelay(function ( ... )
										view[string.format("kbg_item%d_hale", i)]:runAction(fadeAction(1))
									end, tSpeed + (thei - speedDis - 1) * (tSpeed / (2 * speedDis)) )
								end
							end))
						end

					end
				end)
			else
				require "Toolkit".showDialogOnCoinNotEnough()
			end
		end)

		view["btnTurn1_free"]:setVisible(data.D.Activity.FreeCnt > 0)
		view["btnTurn1_layout"]:setVisible(data.D.Activity.FreeCnt <= 0)		
		if data.D.Activity.FreeCnt <= 0 then
			view["btnTurn1_layout_count"]:setFontFillColor(userFunc.getCoin() >= costOne and ccc4f(0, 0, 0, 1.0) or ccc4f(1.0, 0, 0, 1.0), true)
			view["btnTurn1_layout_count"]:setString(costOne)
		end

		view["btnTurn10"]:setListener(function ( ... )
			if userFunc.getCoin() >= costOne then
				self:send(netModel.getModelLuckyDrawDraw(true), function ( data )
					if data and data.D then
						gameFunc.updateResource(data.D.Resource)

						setViewTouchEnabled(false)
						view["kbg_bg"]:runAction(fadeAction(1, function ( ... )
							view["kbg_bg"]:setResid("N_HD_yj_k4.png")
							view["kbg_bg"]:setOpacity(0)
						end, function ( ... )
							view["kbg_bg"]:setResid("N_HD_yj_k3.png")
							view["kbg_bg"]:setOpacity(255)
						end))

						for i=1,12 do
							view[string.format("kbg_item%d_hale", i)]:setOpacity(0)
							view[string.format("kbg_item%d_hale", i)]:setVisible(true)
							if i == 12 then
								view[string.format("kbg_item%d_hale", i)]:runAction(fadeAction(1, nil, function ( ... )
									res.doActionGetReward({rewardType = "List", rewardList = data.D.Rewards, callback = function ( ... )
										setViewTouchEnabled(true)
										update(self, view, data)
									end})
								end))
							else
								view[string.format("kbg_item%d_hale", i)]:runAction(fadeAction(1))
							end
						end
					end
				end)
			else
				require "Toolkit".showDialogOnCoinNotEnough()
			end
		end)
		view["btnTurn10_layout_count"]:setFontFillColor(userFunc.getCoin() >= costTen and ccc4f(0, 0, 0, 1.0) or ccc4f(1.0, 0, 0, 1.0), true)
		view["btnTurn10_layout_count"]:setString(costTen)

		-----------------------------------
		view["kbg"]:setResid("N_HD_yj_k3.png")

		if data.D.Activity.Items and #data.D.Activity.Items == 12 then
			for i=1,12 do
				local v = res.getRewardResList(data.D.Activity.Items[i])[1]
				local scaleOrigal = 65 / 155
				view[string.format("kbg_item%d_bg", i)]:setResid(v.bg)
				view[string.format("kbg_item%d_bg", i)]:setScale(scaleOrigal)
				view[string.format("kbg_item%d_icon", i)]:setResid(v.icon)
				if v.type == "Pet" or v.type == "PetPiece" then
					view[string.format("kbg_item%d_icon", i)]:setScale(scaleOrigal * 140 / 95)
				else
					view[string.format("kbg_item%d_icon", i)]:setScale(scaleOrigal)
				end
				view[string.format("kbg_item%d_frame", i)]:setResid(v.frame)
				view[string.format("kbg_item%d_frame", i)]:setScale(scaleOrigal)
				view[string.format("kbg_item%d_count", i)]:setString(string.format("x%d", v.count))
				view[string.format("kbg_item%d_btn", i)]:setListener(function ( ... )
					if v.eventData then
						GleeCore:showLayer(v.eventData.dialog, v.eventData.data)
					end
				end)
				view[string.format("kbg_item%d_piece", i)]:setVisible(v.isPiece)
				view[string.format("kbg_item%d_hale", i)]:setVisible(false)
			end
		end

		view["kbg_btnRefresh"]:setListener(function ( ... )
			if userFunc.getGold() >= costRefresh then
				self:send(netModel.getModelLuckyDrawRefresh(), function ( data )
					if data and data.D then
						userFunc.setGold( userFunc.getGold() - costRefresh )
						require 'EventCenter'.eventInput("UpdateGoldCoin")
						
						setViewTouchEnabled(false)
						view["kbg_bg"]:runAction(fadeAction(1, function ( ... )
							view["kbg_bg"]:setResid("N_HD_yj_k4.png")
							view["kbg_bg"]:setOpacity(0)
						end, function ( ... )
							view["kbg_bg"]:setResid("N_HD_yj_k3.png")
							view["kbg_bg"]:setOpacity(255)
						end))

						for i=1,12 do
							view[string.format("kbg_item%d_hale", i)]:setOpacity(0)
							view[string.format("kbg_item%d_hale", i)]:setVisible(true)
							if i == 12 then
								view[string.format("kbg_item%d_hale", i)]:runAction(fadeAction(1, nil, function ( ... )
									setViewTouchEnabled(true)
									update(self, view, data)
								end))
							else
								view[string.format("kbg_item%d_hale", i)]:runAction(fadeAction(1))
							end
						end
					end
				end)
			else
				self:toast(res.locString("Dungeon$GoldIsNotEnough"))
			end
		end)
		view["kbg_btnRefresh_layout_count"]:setFontFillColor(userFunc.getGold() >= costRefresh and ccc4f(0, 0, 0, 1.0) or ccc4f(1.0, 0, 0, 1.0), true)
		view["kbg_btnRefresh_layout_count"]:setString(costRefresh)

	--	luckyData.Data.PetId = 258
		view["pet"]:setResid(string.format("role_%03d.png", luckyData.Data.PetId))
		res.adjustPetIconPositionInParentLT(view[1], view["pet"], luckyData.Data.PetId,'lottery')
		view["kbg_btnRefresh_pet"]:setResid(string.format("role_%03d.png", luckyData.Data.PetId))
		res.adjustPetIconPositionInParentLT(view["kbg_btnRefresh"], view["kbg_btnRefresh_pet"], luckyData.Data.PetId,'lotteryS')
	end
end

local getNetModel = function ( )
	return netModel.getModelLuckyDrawGet()
end

return {update = update, getNetModel = getNetModel}