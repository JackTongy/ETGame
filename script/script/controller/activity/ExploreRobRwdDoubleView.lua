local gameFunc = require "AppData"
local res = require "Res"
local UnlockManager = require 'UnlockManager'

local update = function ( self, view, data )
	local exploreRobRwdDoubleData = gameFunc.getActivityInfo().getDataByType(45)
	if exploreRobRwdDoubleData then
		local seconds = -math.floor(require "TimeListManager".getTimeUpToNow(exploreRobRwdDoubleData.CloseAt))
		seconds = math.max(seconds, 0)
		local date = view["layout1_timer"]:getElfDate()
		date:setHourMinuteSecond(0, 0, seconds)
		if seconds > 0 then
			view["layout1_timer"]:setUpdateRate(-1)
			view["layout1_timer"]:addListener(function (  )
				self:onActivityFinish( require 'ActivityType'.ExploreRobRwdDouble )
			end)
		else
			view["layout1_timer"]:setUpdateRate(0)
		end

		view["btnGo"]:setListener(function ( ... )
			if UnlockManager:isUnlock("Exploration") then
				GleeCore:closeAllLayers()
				GleeCore:pushController("CExploreScene", nil, nil, res.getTransitionFade())
				require 'framework.helper.Utils'.delay(function (  )
					GleeCore:showLayer('DExploration')
				end, 0.8)
			else
				self:toast(UnlockManager:getUnlockConditionMsg("Exploration"))
			end
		end)

	    	require 'LangAdapter'.selectLang(nil, nil, function ( ... )
			view["#title"]:setFontSize(18)
		end, nil, nil)
	end
end

return {update = update}