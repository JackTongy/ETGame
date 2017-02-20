local dbManager = require "DBManager"
local res = require "Res"
local gameFunc = require "AppData"
local netModel = require "netModel"
local userFunc = gameFunc.getUserInfo()
local HatchEggInfo = require "HatchEggInfo"

local function moveAction( isShake )
	local fps = 24
	local actArray = CCArray:create()
	actArray:addObject(CCRotateTo:create(0, 0))
	actArray:addObject(CCMoveBy:create(6/fps, ccp(0, -5)))
	actArray:addObject(CCMoveBy:create(30/fps, ccp(0, 25)))

	if isShake then
		local spawnArray
		local p = {-0.2, -0.1, 0.3, 0.05, -0.45, 0.4}
		local r = {1.5, -3.76, -4, -1.5, 3.76, 4}
		for i=1,#p do
			spawnArray = CCArray:create()
			spawnArray:addObject(CCMoveBy:create(1/fps, ccp(0,p[i])))
			spawnArray:addObject(CCRotateBy:create(1/fps, r[i]))
			actArray:addObject(CCSpawn:create(spawnArray))
		end
	end

	actArray:addObject(CCMoveBy:create(24/fps, ccp(0, -20)))

	return CCSequence:create(actArray)
end

local function updateLayer( self, view, oldshowActivityType )
	local HatchEggConfig = gameFunc.getActivityInfo().getDataByType(46)
	if HatchEggConfig then
		if -math.floor(require "TimeListManager".getTimeUpToNow(HatchEggConfig.CloseAt)) <= 0 then
			self:onActivityFinish( require 'ActivityType'.HatchEgg )
			return
		end

		local seconds = -math.floor(require "TimeListManager".getTimeUpToNow(HatchEggConfig.OpenAt)) + 3600 * 24
		seconds = math.max(seconds, 0)
		local date = view["bg_layout1_timer"]:getElfDate()
		date:setHourMinuteSecond(0, 0, seconds)
		if seconds > 0 then
			view["bg_layout1_timer"]:setUpdateRate(-1)
			view["bg_layout1_timer"]:addListener(function (  )
				updateLayer( self, view, require 'ActivityType'.HatchEgg )
			end)
		else
			view["bg_layout1_timer"]:setUpdateRate(0)
			if oldshowActivityType ~= require 'ActivityType'.HatchEgg then
				self:runWithDelay(function ( ... )
					GleeCore:showLayer("DHatchEggEnd")
				end, 0.5)
			end
		end

		view["bg_intimate"]:setString(HatchEggInfo.getMyData().Energy)
		local myRank = HatchEggInfo.getMyRank()
		myRank = myRank == 0 and 21 or myRank
		view["bg_reward_icon"]:setResid(string.format("JLD_PM%d.png", myRank))
		view["bg_reward_btn"]:setListener(function ( ... )
			if seconds > 0 then
				GleeCore:showLayer("DHatchEggRank")
			else
				GleeCore:showLayer("DHatchEggEnd")
			end
		end)

		local LangName = require 'Config'.LangName or ''
		view["bg_btnDetail"]:setVisible(LangName ~= 'ES' and LangName ~= 'PT')
		view["bg_btnDetail"]:setListener(function ( ... )
			GleeCore:showLayer("DHelp", {type = "孵化精灵蛋"})
		end)

		self.eggIndex = self.eggIndex or HatchEggInfo.getCurStep()
		local energyList = HatchEggInfo.getEnergyList()
		local energy = math.min(HatchEggInfo.getIntimateWithStep(self.eggIndex), energyList[self.eggIndex])
		view["bg_intimateBg_progress"]:setPercentage(100 * energy / energyList[self.eggIndex])
		view["bg_intimateBg_layoutText_v"]:setString(string.format("%d/%d", energy, energyList[self.eggIndex]))
		view["bg_intimateBg_progress_text"]:setVisible(HatchEggInfo.isHatched(self.eggIndex))
		view["bg_intimateBg_progress_text"]:setString(self.eggIndex ~= 8 and res.locString("Activity$HatchEggAlreadyGetReward") or res.locString("Global$ReceiveFinish"))

		view["bg_clipSwip_eggSwip"]:setAnimateTime(0.3)
		view["bg_clipSwip_eggSwip"]:registerSwipeListenerScriptHandler(function(state, oldIndex, newIndex)
			if state ~= 0 and oldIndex ~= newIndex then	-- animation just finished
				print("oldIndex = " .. tostring(oldIndex))
				print("newIndex = " .. tostring(newIndex))
				-- newIndex从0计数
				self.eggIndex = newIndex + 1
				updateLayer(self, view, require 'ActivityType'.HatchEgg)
			end
		end)
		view["bg_clipSwip_eggSwip_linearlayout"]:removeAllChildrenWithCleanup(true)
		view["bg_clipSwip_eggSwip"]:clearStayPoints()	
		for i=1,8 do
			local page = view.createLuaSet("@page")
			view["bg_clipSwip_eggSwip_linearlayout"]:addChild(page[1])
			view["bg_clipSwip_eggSwip"]:addStayPoint(-page[1]:getWidth() * (i - 1), 0) 
			page["icon"]:setResid(string.format("JLD_%d.png", i))
			page["icon_ed"]:setVisible(HatchEggInfo.isHatched(i) and i ~= 8)
			page["icon_btn"]:setListener(function ( ... )
				if not HatchEggInfo.isHatched(i) then
					GleeCore:showLayer("DHatchEggReward", {eggIndex = i})
				end
			end)
			page["icon"]:runAction(CCRepeatForever:create(moveAction(energy >= energyList[self.eggIndex] and not HatchEggInfo.isHatched(i))))
		end
		view["bg_clipSwip_eggSwip"]:setStayIndex(self.eggIndex - 1)
	end
end

local update = function ( self, view, data, showActivityType, oldshowActivityType )
	if data and data.D then
		HatchEggInfo.setMyData(data.D.MyData)
		HatchEggInfo.setTotal(data.D.Total)
		HatchEggInfo.setMyRank(data.D.MyRank)
		HatchEggInfo.setRanks(data.D.Ranks)
		updateLayer( self, view, oldshowActivityType )
	end
end

local getNetModel = function ( )
	return netModel.getModelEggHatchGet()
end

return {update = update, getNetModel = getNetModel}