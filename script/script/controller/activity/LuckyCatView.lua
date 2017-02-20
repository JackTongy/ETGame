local dbManager = require "DBManager"
local res = require "Res"
local gameFunc = require "AppData"
local netModel = require "netModel"
local userFunc = gameFunc.getUserInfo()

local function getGoldAndCoin( count )
	local gold = 0
	local coin = 0
	if count <= 5 then
		coin = 5
		gold = 25000 + userFunc.getLevel() * 50
	else
		coin = (count - 4)*5
		gold = 25000 + userFunc.getLevel() * 50 + coin * 1000
	end
	return gold, coin
end

local function getMultiAction( target )
	local frameCount = 20
	local actArray = CCArray:create()
	actArray:addObject(CCHide:create())
	actArray:addObject(CCScaleTo:create(0, 0))
	actArray:addObject(CCShow:create())

	local array = CCArray:create()
	array:addObject(CCMoveBy:create(5 / frameCount, ccp(0, 210)))
	local array2 = CCArray:create()
	array2:addObject(CCScaleTo:create(3 / frameCount, 1.442))
	array2:addObject(CCScaleTo:create(1 / frameCount, 1.343))
	array2:addObject(CCScaleTo:create(1 / frameCount, 1.442))
	array:addObject(CCSequence:create(array2))
	array:addObject(CCFadeIn:create(5 / frameCount))
	actArray:addObject(CCSpawn:create(array))

	actArray:addObject(CCDelayTime:create(10 / 20))

	local array3 = CCArray:create()
	array3:addObject(CCScaleTo:create(4 / frameCount, 1.808))
	array3:addObject(CCFadeOut:create(4 / frameCount))
	actArray:addObject(CCSpawn:create(array3))

	actArray:addObject(CCCallFunc:create(function ( ... )
		target:removeFromParentAndCleanup(true)
	end))

	return CCSequence:create(actArray)
end

local function updateLayer( self, view, count )
	local miaoInfo = dbManager.getVipInfo(userFunc.getVipLevel())
	if miaoInfo then
		local isDouble = false
		local catData = gameFunc.getActivityInfo().getDataByType(32)
		if catData then
			local seconds = -math.floor(require "TimeListManager".getTimeUpToNow(catData.CloseAt))
			isDouble = seconds > 0
		end
		
		view["layoutCoinTitle_value"]:setString(userFunc.getCoin())
		view["layoutGoldTitle_value"]:setString(userFunc.getGold())
		view["bg_countDes"]:setString(string.format(res.locString("Activity$LuckyCatCountDes"), count, miaoInfo.Miao))
		local vipCap = #(require "vip") - 1
		view["bg_vipDes1"]:setVisible(count <= 0 and userFunc.getVipLevel() < vipCap and not require 'AccountHelper'.isItemOFF('Vip'))
		view["bg_vipDes2"]:setVisible(count <= 0 and userFunc.getVipLevel() < vipCap)
		
		local gold, coin = getGoldAndCoin( math.max(miaoInfo.Miao - count, 0) + 1 )
		view["bg_layout_des2"]:setString(tostring(coin))
		view["bg_double"]:setVisible(isDouble)
		if isDouble then
			view["bg_layout_des4"]:setString(tostring(gold) .. "x2")
		else
			view["bg_layout_des4"]:setString(tostring(gold))
		end
		view["bg_btnLucky"]:setListener(function (  )
			if userFunc.getCoin() < coin then
				require "Toolkit".showDialogOnCoinNotEnough()
			else
				if count <= 0 then
					local param = {}
					param.content = res.locString("Activity$LuckyCatRecharge")
					param.RightBtnText = res.locString("Global$BtnRecharge")
					param.callback = function ( ... )
						GleeCore:showLayer("DRecharge")
					end
					GleeCore:showLayer("DConfirmNT", param)
				else
					self:send(netModel.getModelRoleMiao(), function ( data )
						if data and data.D then
							if data.D.Resource then
								gameFunc.updateResource(data.D.Resource)
							end

							if data.D.Miao and data.D.Miao.Left then
								updateLayer(self, view, data.D.Miao.Left)
							end

							if data.D.Gold and data.D.Gold > 0 then
								local m = math.floor(data.D.Gold / gold)
								if data.D.ActOpen then
									m = m / 2
								end
								if m >= 2 and m <= 5 then
									local multipleSet = view.createLuaSet("@multiple")
									multipleSet[1]:setResid(string.format("N_HD_ZCMMx%d.png", m))
									view["#bg"]:addChild(multipleSet[1])
									multipleSet[1]:setVisible(false)
									multipleSet[1]:setOpacity(0)
									multipleSet[1]:runAction(getMultiAction(multipleSet[1]))
								end

								self:toast(res.locString("Bag$ToastReardGet") .. data.D.Gold .. res.locString("Global$Gold"))
							end
						end
					end)
				end
			end
		end)

		require 'LangAdapter'.selectLang(nil, nil, function ( ... )
			view["bg_countDes"]:setFontSize(24)
		end, nil, nil, nil, function ( ... )
			view["bg_countDes"]:setFontSize(22)
		end)
	end
end

local update = function ( self, view, data )
	if data and data.D and data.D.Miao and data.D.Miao.Left then
		updateLayer(self, view, data.D.Miao.Left)
	end
end

local getNetModel = function ( )
	return netModel.getModelMiaoGet()
end

return {update = update, getNetModel = getNetModel}