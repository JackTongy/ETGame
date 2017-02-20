local Config = require "Config"
local netModel = require "netModel"
local res = require "Res"
local gameFunc = require "AppData"
local PlaygroundInfo = require "PlaygroundInfo"

local playgroundMid = 126

local Playground = class(LuaDialog)

--@@@@[[[[
function Playground:onInitXML()
    local set = self._set
   self._bg_layout1_timer = set:getTimeNode("bg_layout1_timer")
   self._bg_myScore = set:getLabelNode("bg_myScore")
   self._bg_ticket = set:getLabelNode("bg_ticket")
   self._bg_btnReward = set:getClickNode("bg_btnReward")
   self._bg_btnRank = set:getClickNode("bg_btnRank")
   self._bg_btnTry = set:getClickNode("bg_btnTry")
   self._bg_btnTry_layoutText = set:getLinearLayoutNode("bg_btnTry_layoutText")
   self._bg_btnTry_layoutText_k = set:getLabelNode("bg_btnTry_layoutText_k")
   self._bg_btnTry_layoutText_v = set:getLabelNode("bg_btnTry_layoutText_v")
   self._bg_btnDetail = set:getClickNode("bg_btnDetail")
--   self._<FULL_NAME1> = set:getElfNode("@view")
end
--@@@@]]]]

--------------------------------override functions----------------------

--------------------------------custom code-----------------------------

local update
update = function ( self, view, data )
	if data and data.D then
		PlaygroundInfo.setPlayground(data.D.Playground)
	else
		self:onActivityFinish( require 'ActivityType'.Playground )
		return
	end
	
	local PlaygroundConfig = gameFunc.getActivityInfo().getDataByType(60)
	if PlaygroundConfig then
		local seconds = -math.floor(require "TimeListManager".getTimeUpToNow(PlaygroundConfig.CloseAt))
		seconds = math.max(seconds, 0)
		local date = view["bg_layout1_timer"]:getElfDate()
		date:setHourMinuteSecond(0, 0, seconds)
		date:setTimeFormat(DayHourMinuteSecond)
		if seconds > 0 then
			view["bg_layout1_timer"]:setUpdateRate(-1)
			view["bg_layout1_timer"]:addListener(function (  )
				self:onActivityFinish( require 'ActivityType'.Playground )
			end)
		else
			view["bg_layout1_timer"]:setUpdateRate(0)
			self:onActivityFinish( require 'ActivityType'.Playground )
			return
		end

		view["bg_myScore"]:setString(string.format(res.locString("Activity$PlaygroundCurrentScore"), PlaygroundInfo.getPlayground().Score))
		local ticketCount = gameFunc.getBagInfo().getItemCount(playgroundMid)
		view["bg_ticket"]:setString(ticketCount)

		view["bg_btnReward"]:setListener(function ( ... )
			GleeCore:showLayer("DPlaygroundShop")
		end)

		view["bg_btnRank"]:setListener(function ( ... )
			GleeCore:showLayer("DPlaygroundRank")
		end)

		view["bg_btnTry_layoutText_v"]:setString("1")
		view["bg_btnTry"]:setListener(function ( ... )
			GleeCore:pushController("CPlayground", nil, nil, res.getTransitionFade())
		end)

		view["bg_btnDetail"]:setListener(function ( ... )
			GleeCore:showLayer("DHelp", {type = "精灵游乐园"})
		end)
	else
		self:onActivityFinish( require 'ActivityType'.Playground )
	end
end

local getNetModel = function ( )
	return netModel.getModelPlaygroundGet()
end

return {update = update, getNetModel = getNetModel}
