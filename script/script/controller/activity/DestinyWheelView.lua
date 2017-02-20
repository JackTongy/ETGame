local res = require "Res"
local dbManager = require "DBManager"
local LuaList = require "LuaList"
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

local function updateLayer( self, view, FateWheel )
	local function setViewTouchEnabled( enable )
		view["shield"]:setVisible(not enable)
	end

	local destinyData = gameFunc.getActivityInfo().getDataByType(43)
	print("-----destinyData")
	print(destinyData)
	print("-----FateWheel")
	print(FateWheel)
	if destinyData and FateWheel then
		setViewTouchEnabled(true)
		view["pet"]:setResid(string.format("role_%03d.png", destinyData.Data.PetId))
		res.adjustPetIconPositionInParentLT(view[1], view["pet"], destinyData.Data.PetId,'lottery')

		view["layout0_v"]:setString(view.Consumed)
		local seconds = -math.floor(require "TimeListManager".getTimeUpToNow(destinyData.CloseAt))
		seconds = math.max(seconds, 0)
		local date = view["layout1_timer"]:getElfDate()
		date:setHourMinuteSecond(0, 0, seconds)
		if seconds > 0 then
			view["layout1_timer"]:setUpdateRate(-1)
			view["layout1_timer"]:addListener(function (  )
				self:onActivityFinish( require 'ActivityType'.DestinyWheel )
			end)
		else
			view["layout1_timer"]:setUpdateRate(0)
		end

		view["bg1_count"]:setString(FateWheel.Keys)
		local function buyKey( ... )
			local function FateWheelKeysBuy( amt, closeBuyLayer )
				self:send(netModel.getModelFateWheelKeysBuy(amt), function ( data )
					if data and data.D then
						if closeBuyLayer then
							closeBuyLayer()
						end
						view.Consumed = data.D.Consumed
						userFunc.setData(data.D.Role)
						updateLayer(self, view, data.D.FateWheel)
					end
				end)
			end

			local param = {}
			param.itemType = "DestinyWheel"
			param.hbPrice = dbManager.getInfoDefaultConfig("FateWheelKeyPrice").Value
			param.hbAmtLimit = math.floor(userFunc.getCoin() / param.hbPrice)
			param.callback = function ( data )
				FateWheelKeysBuy(data.amt, data.closeBuyLayer)
			end
			GleeCore:showLayer("DMallItemBuy", param)
		end

		view["bg1_btn"]:setListener(function ( ... )
			buyKey()
		end)

		local function keyCoinIsGet( coin )
			if FateWheel.CoinKeysGot then
				for k,v in pairs(FateWheel.CoinKeysGot) do
					if tonumber(k) == coin then
						return true
					end
				end
			end
			return false
		end

		if destinyData.Data.CoinKeys then
			local coinKeyList = {}
			for k, v in pairs(destinyData.Data.CoinKeys) do
				table.insert(coinKeyList, {coin = tonumber(k), key = tonumber(v)})
			end
			table.sort(coinKeyList, function ( v1, v2 )
				return v1.coin < v2.coin
			end)

			local costIndex = 1
			for i=1,5 do
				local temp = coinKeyList[i]
				local bGet = keyCoinIsGet(temp.coin)
				view[string.format("rwd%d_count", i)]:setString("x" .. temp.key)
				view[string.format("rwd%d_isGet", i)]:setVisible(bGet)
				view[string.format("rwd%d_btn", i)]:setEnabled(not bGet and view.Consumed >= temp.coin)
				view[string.format("rwd%d_btn", i)]:setListener(function ( ... )
					self:send(netModel.getModelFateWheelRwdGet(temp.coin), function ( data )
						if data and data.D then
							local getKeyCount = data.D.FateWheel.Keys - FateWheel.Keys
							if getKeyCount > 0 then
								GleeCore:showLayer("DGetReward", {DestinyWheelKey = getKeyCount})
							end
							updateLayer(self, view, data.D.FateWheel)
						end
					end)
				end)
				view[string.format("rwd%d_isPoint", i)]:setVisible(not bGet and view.Consumed >= temp.coin)
				view[string.format("rwd%d_layoutCost", i)]:setVisible(view.Consumed < temp.coin)
				view[string.format("rwd%d_layoutCost_v", i)]:setString(temp.coin)
				if view.Consumed >= temp.coin then
					costIndex = i
				end
			end
			view["bg3_process"]:setPercentage( (costIndex - 1) / 4 * 100)
		end

		-- record log
		require 'LangAdapter'.selectLang(nil, nil, nil, nil, function ( ... )
			view["logTitle"]:setPosition(ccp(-8,-96))
			view["logTitle"]:setRotation(90)
		end)

		view.recordList = LuaList.new(view["list"], function ( ... )
			return view.createLuaSet("@layoutSize")
		end, function ( nodeLuaSet, data )
			local date = os.date("*t", math.floor(require "TimeManager".getTimestamp(data.GotAt) ))
			local rewardItem = res.getRewardResList(data.Reward)[1]
			nodeLuaSet["log"]:setString(string.format(res.locString("Activity$DestinyWheelLogFormat"), date.hour, date.min, data.Name, rewardItem.name .. "x" .. tostring(rewardItem.count)))
			nodeLuaSet[1]:setHeight( nodeLuaSet["log"]:getHeight() + 4 )
		end)
		view.recordList:update(view.Records or {})

		----------------------------------
		if FateWheel.Items and #FateWheel.Items == 8 then
			for i=1,8 do
				local v = res.getRewardResList(FateWheel.Items[i])[1]
				local scaleOrigal = 54 / 155
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

		----------------------------------
		local function doActionBg( ... )
			local img = ""
			view["kbg_bg"]:runAction(fadeAction(0.5, function ( ... )
				if img == "MYZP_ZP_liangdian3.png" then
					img = "MYZP_ZP_liangdian2.png"
				elseif img == "MYZP_ZP_liangdian2.png" then
					img = "MYZP_ZP_liangdian1.png"
				elseif img == "MYZP_ZP_liangdian1.png" then
					img = "MYZP_ZP_liangdian2.png"
				elseif img == "" then
					img = "MYZP_ZP_liangdian3.png"
				end
				view["kbg_bg"]:setResid(img)
				view["kbg_bg"]:setOpacity(0)
			end, nil, true))
		end

		view["kbg_btn"]:setListener(function ( ... )
			if FateWheel.Keys > 0 then
				local function fateWheelGo( cnt )
					self:send(netModel.getModelFateWheelGo( cnt ), function ( data )
						if data and data.D then
							gameFunc.updateResource(data.D.Resource)
			--				updateLayer(self, view, data.D.FateWheel)
			--				GleeCore:showLayer("DGetReward", {rewardType = "List", rewardList = data.D.Rewards})
							local function oneTime( ... )
								local nReward = data.D.Rewards[1]
								setViewTouchEnabled(false)
								doActionBg()
								local tSpeed = 1		-- 起始加速时间
								local tSpeed2 = 1		-- 终止减速时间
								local theIndex = 16 + data.D.Index or 3	-- 运动格子数目
								local speedDis = 3		-- 起始加速距离
								local speedDis2 = 3	-- 终止减速距离
								for thei=1,theIndex do
									local i = math.fmod(thei - 1, 8) + 1
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
														view["kbg_bg"]:setResid("")
														view["kbg_bg"]:stopAllActions()

														view[string.format("kbg_item%d_hale", i)]:runAction(fadeAction(1, nil, function ( ... )
															setViewTouchEnabled(true)
															view.Records = view.Records or {}
															local nowRecord = {}
															nowRecord.Name = userFunc.getName()
															nowRecord.Reward = nReward
															local date = os.date("*t", math.floor(require "TimeManager".getCurrentSeverTime() / 1000 - (os.time() - os.time(os.date("!*t")))))
															nowRecord.GotAt = string.format("%d-%d-%d %02d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)
															table.insert(view.Records, 1, nowRecord)

															nReward.callback = function ( ... )
																updateLayer(self, view, data.D.FateWheel)
															end
															res.doActionGetReward(nReward)
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

								view["kbg_go"]:setRotation(0)
								local rotateArray = CCArray:create()
								rotateArray:addObject(CCDelayTime:create(1))
								rotateArray:addObject(CCEaseIn:create(CCRotateBy:create(tSpeed, speedDis * 45), 4))
								rotateArray:addObject(CCRotateBy:create((theIndex - speedDis - speedDis2) * (tSpeed / (2 * speedDis)), (theIndex - speedDis - speedDis2 - 1) * 45 ))
								rotateArray:addObject(CCEaseOut:create(CCRotateBy:create(tSpeed2, speedDis2 * 45), 4))
								view["kbg_go"]:runAction(CCSequence:create(rotateArray))
							end
							local function tenTimes( ... )
								setViewTouchEnabled(false)
								view["kbg_bg"]:runAction(fadeAction(1, function ( ... )
									view["kbg_bg"]:setResid("MYZP_ZP_liangdian3.png")
									view["kbg_bg"]:setOpacity(0)
								end, function ( ... )
									view["kbg_bg"]:setResid("")
									view["kbg_bg"]:setOpacity(255)
								end))

								for i=1,8 do
									view[string.format("kbg_item%d_hale", i)]:setOpacity(0)
									view[string.format("kbg_item%d_hale", i)]:setVisible(true)
									if i == 8 then
										view[string.format("kbg_item%d_hale", i)]:runAction(fadeAction(1, nil, function ( ... )
											res.doActionGetReward({rewardType = "List", rewardList = data.D.Rewards, callback = function ( ... )
												view.Records = view.Records or {}

												local date = os.date("*t", math.floor(require "TimeManager".getCurrentSeverTime() / 1000 - (os.time() - os.time(os.date("!*t")))))
												local gotString = string.format("%d-%d-%d %02d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)
												for _,v in ipairs(data.D.Rewards) do
													local nowRecord = {}
													nowRecord.Name = userFunc.getName()
													nowRecord.Reward = v
													nowRecord.GotAt = gotString
													table.insert(view.Records, 1, nowRecord)									
												end

												updateLayer(self, view, data.D.FateWheel)
												setViewTouchEnabled(true)
											end})
										end))
									else
										view[string.format("kbg_item%d_hale", i)]:runAction(fadeAction(1))
									end
								end
							end
							if cnt == 1 then
								oneTime()
							elseif cnt == 10 then
								tenTimes()
							end
						end
					end)
				end

				GleeCore:showLayer("DDestinyWheelTimes", {keyCount = FateWheel.Keys, callback = function ( tryTimes )
					fateWheelGo(tryTimes)
				end})
			else
				buyKey()
			end
		end)
	end
end

local update
update = function ( self, view, data )
	view.Consumed = data.D.Consumed
	view.Records = data.D.Records
	updateLayer( self, view, data.D.FateWheel)
end

local getNetModel = function ( )
	return netModel.getModelFateWheelGet()
end

return {update = update, getNetModel = getNetModel}