local res = require "Res"
local gameFunc = require "AppData"
local netModel = require "netModel"
local LuaList = require "LuaList"

local update
update = function ( self, view, data )
	local trialBoxData = gameFunc.getActivityInfo().getDataByType(29)
	print(trialBoxData)
	if trialBoxData and data and data.D then
		if data.D.Gots and trialBoxData.Data and #data.D.Gots == #trialBoxData.Data then
			self:sendBackground(netModel.getModelRoleNewsUpdate("adv_box_buy", false),function ( ... )
	   			print('DActivity Role newsUpdate done_adv_box_buy')
			end)
		end

		view["bg_bg0_layout0_count"]:setString( tostring(data.D.Cnt) .. res.locString("Global$Count") )
		require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
			view["bg_bg0_layout0_#v1"]:setFontSize(22)
			view["bg_bg0_layout0_count"]:setFontSize(22)
		end)

		local seconds = -math.floor(require "TimeListManager".getTimeUpToNow(trialBoxData.CloseAt))
		seconds = math.max(seconds, 0)
		local date = view["bg_layout1_timer"]:getElfDate()
		date:setHourMinuteSecond(0, 0, seconds)
		if seconds > 0 then
			view["bg_layout1_timer"]:setUpdateRate(-1)
			view["bg_layout1_timer"]:addListener(function (  )
				self:onActivityFinish( require 'ActivityType'.TrialBox )
			end)
		else
			view["bg_layout1_timer"]:setUpdateRate(0)
		end

		local function isRewardGet( index )
			return data.D.Gots and table.find(data.D.Gots, index)
		end

		if not view.rewardList then
			view.rewardList = LuaList.new(view["bg_list"], function ( ... )
				return view.createLuaSet("@item")
			end, function ( nodeLuaSet, nodeData, nodeIndex )
				nodeLuaSet["titleBg_count"]:setString( tostring(nodeData.Cnt) .. res.locString("Global$Count") )

				local tempList = res.getRewardResList( nodeData.Reward )
				nodeLuaSet["layout"]:removeAllChildrenWithCleanup(true)
				for i=1,4 do
					local subSet = view.createLuaSet("@sub")
					nodeLuaSet["layout"]:addChild(subSet[1])

					subSet["bg"]:setVisible(i <= #tempList)
					subSet["icon"]:setVisible(true)
					subSet["frame"]:setVisible(i <= #tempList)
					subSet["name"]:setVisible(i <= #tempList)
					require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
						subSet["name"]:setVisible(false)
					end)
					subSet["count"]:setVisible(i <= #tempList)
					subSet["piece"]:setVisible(i <= #tempList and tempList[i].isPiece)
					if i <= #tempList then
						local v = tempList[i]
						local scaleOrigal = 87 / 155
						if v.type == "Gem" then
							subSet["name"]:setString(v.name .. " Lv." .. v.lv)
						else
							subSet["name"]:setString(v.name)
						end
						
						subSet["bg"]:setResid(v.bg)
						subSet["bg"]:setScale(scaleOrigal)
						subSet["icon"]:setResid(v.icon)
						if v.type == "Pet" or v.type == "PetPiece" then
							subSet["icon"]:setScale(scaleOrigal * 140 / 95)
						else
							subSet["icon"]:setScale(scaleOrigal)
						end
						subSet["frame"]:setResid(v.frame)
						subSet["frame"]:setScale(scaleOrigal)
						subSet["count"]:setString(string.format("x%d", v.count))
						subSet["btn"]:setListener(function ( ... )
							GleeCore:showLayer(v.eventData.dialog, v.eventData.data)
						end)
					else
						subSet["icon"]:setResid("N_HDX_xk.png")
					end
				end
				nodeLuaSet["btnReceive"]:setEnabled( data.D.Cnt >= nodeData.Cnt and not isRewardGet(nodeIndex) )
				nodeLuaSet["btnReceive_text"]:setString( isRewardGet(nodeIndex) and res.locString("Friend$ReceiveApFinish") or res.locString("Global$Receive"))
				nodeLuaSet["btnReceive"]:setListener(function ( ... )
					self:send(netModel.getModelAdvBoxBuyReward(nodeIndex), function ( netData )
						if netData and netData.D then
							if netData.D.Resource then
								gameFunc.updateResource(netData.D.Resource)
							end
							res.doActionGetReward(netData.D.Reward)

							data.D.Gots = data.D.Gots or {}
							table.insert(data.D.Gots, nodeIndex)
							update(self, view, data)
						end
					end)
				end)
			end)
		end
		view.rewardList:update(trialBoxData.Data)
	end
end

local getNetModel = function ( )
	return netModel.getModelAdvBoxBuyGet()
end

return {update = update, getNetModel = getNetModel}