local dbManager = require "DBManager"
local res = require "Res"
local gameFunc = require "AppData"
local netModel = require "netModel"
local userFunc = gameFunc.getUserInfo()
local timeLimitExploreFunc = gameFunc.getTimeLimitExploreInfo()
local EventCenter = require "EventCenter"

local function checkTeam( ... )
	local exploreData = gameFunc.getActivityInfo().getDataByType(42)
	local teamFunc = gameFunc.getTeamInfo()
	local nPetList = teamFunc.getPetListWithTeam( teamFunc.getTeamActive() )
	local LangName = require 'Config'.LangName or ''
	if exploreData.Data.ConType == 1 then
		for i,v in ipairs(nPetList) do
			local dbPet = dbManager.getCharactor(v.PetId)
			if dbPet.prop_1 ~= exploreData.Data.ConValue then
				local content = res.locString("Activity$TimeLimitExploreTip2") .. res.locString(string.format("PetCC$_Prop%d", exploreData.Data.ConValue)) .. res.locString("Global$Pro") .. res.locString("Global$TitlePet")
				if LangName == "vn" then
					content = res.locString("Activity$TimeLimitExploreTip2") .. res.locString("Global$TitlePet") .. res.locString("Global$Pro") .. res.locString(string.format("PetCC$_Prop%d", exploreData.Data.ConValue))
				end
				content = content .. res.locString("Activity$TimeLimitExploreTip5")
				return false, content
			end
		end
	elseif exploreData.Data.ConType == 2 then
		for i,v in ipairs(nPetList) do
			local dbPet = dbManager.getCharactor(v.PetId)
			if dbPet.atk_method_system ~= exploreData.Data.ConValue then
				local content = res.locString("Activity$TimeLimitExploreTip2") .. res.locString(string.format("Bag$Treasure%d", exploreData.Data.ConValue)) .. res.locString("Global$TitlePet")
				if LangName == "vn" then
					content = res.locString("Activity$TimeLimitExploreTip2") .. res.locString("Global$TitlePet") .. res.locString(string.format("Bag$Treasure%d", exploreData.Data.ConValue))
				end
				content = content .. res.locString("Activity$TimeLimitExploreTip5")
				return false, content
			end
		end
	end
	return true
end

local update
update = function ( self, view, data )
	local exploreData = gameFunc.getActivityInfo().getDataByType(42)
	if exploreData and data and data.D then
		print('exploreData:')
		print(exploreData)
		timeLimitExploreFunc.setExplore(data.D.TimeCopy)
		timeLimitExploreFunc.setTimeCopyStageList(data.D.Stages)

		local exploreInfo = timeLimitExploreFunc.getExplore()
		local maxTicketNum = dbManager.getInfoDefaultConfig("TicketNum").Value
		view["bg_ticket"]:setString(string.format("%d/%d", exploreInfo.Tickets, maxTicketNum))
		view["bg_stone"]:setString(exploreInfo.Score)
		local seconds = -math.floor(require "TimeListManager".getTimeUpToNow(exploreInfo.RecoverTime))
		print("exploreSecond = " .. seconds)
		seconds = math.max(seconds, 0)
		seconds = math.min(seconds, 3600)
		if exploreInfo.Tickets < maxTicketNum and seconds > 0 then
			seconds = seconds + 1
			local date = view["bg_timer"]:getElfDate()
			date:setHourMinuteSecond(0, 0, seconds)
			view["bg_timer"]:setVisible(true)
			view["bg_timer"]:setUpdateRate(-1)
			view["bg_timer"]:addListener(function (  )
				exploreInfo.Tickets = math.min(exploreInfo.Tickets + 1, maxTicketNum)
				if exploreInfo.Tickets == maxTicketNum then
					view["bg_timer"]:setUpdateRate(0)
					view["bg_timer"]:setVisible(false)
				else
					date:setHourMinuteSecond(0, 0, 3600)
				end
				view["bg_ticket"]:setString(string.format("%d/%d", exploreInfo.Tickets, maxTicketNum))

				self:send(netModel.getModelTimeCopyGet(), function ( data )
					if data and data.D then
						timeLimitExploreFunc.setExplore(data.D.TimeCopy)
						timeLimitExploreFunc.setTimeCopyStageList(data.D.Stages)
						update(self, view, data)
						EventCenter.eventInput("UpdateTimeLimitExploreCountDown")
					end
				end)
			end)
		else
			view["bg_timer"]:setUpdateRate(0)
			view["bg_timer"]:setVisible(false)
		end	

		do
			local seconds = -math.floor(require "TimeListManager".getTimeUpToNow(exploreData.CloseAt))
			seconds = math.max(seconds, 0)
			local date = view["bg_layout1_timer"]:getElfDate()
			date:setHourMinuteSecond(0, 0, seconds)
			if seconds > 0 then
				view["bg_layout1_timer"]:setUpdateRate(-1)
				view["bg_layout1_timer"]:addListener(function (  )
					self:onActivityFinish( require 'ActivityType'.TimeLimitExplore )
				end)
			else
				view["bg_layout1_timer"]:setUpdateRate(0)
			end	
		end

		if exploreData.Data.ConType == 1 then
			view["bg_layoutTip_v"]:setString(res.locString(string.format("PetCC$_Prop%d", exploreData.Data.ConValue)) .. res.locString("Global$Pro") .. res.locString("Global$TitlePet"))
		elseif exploreData.Data.ConType == 2 then
			view["bg_layoutTip_v"]:setString(res.locString(string.format("Bag$Treasure%d", exploreData.Data.ConValue)) .. res.locString("Global$TitlePet"))
		end
		local LangName = require 'Config'.LangName or ''
		if LangName == "kor" then
			view["bg_layoutTip_k"]:setString("추천!")
			require "LangAdapter".LayoutChildrenReverse(view["bg_layoutTip"])
		elseif LangName == "vn" then
			if exploreData.Data.ConType == 1 then
				view["bg_layoutTip_v"]:setString(res.locString("Global$TitlePet") .. res.locString("Global$Pro") .. res.locString(string.format("PetCC$_Prop%d", exploreData.Data.ConValue)))
			elseif exploreData.Data.ConType == 2 then
				view["bg_layoutTip_v"]:setString(res.locString("Global$TitlePet") .. res.locString(string.format("Bag$Treasure%d", exploreData.Data.ConValue)))
			end
		elseif LangName == "German" then
			if exploreData.Data.ConType == 1 then
				view["bg_layoutTip_v"]:setString(res.locString(string.format("PetCC$_Prop%d", exploreData.Data.ConValue)) .. " " .. res.locString("Global$Pro") .. " " .. res.locString("Global$TitlePet"))
			elseif exploreData.Data.ConType == 2 then
				view["bg_layoutTip_v"]:setString(res.locString(string.format("Bag$Treasure%d", exploreData.Data.ConValue)) .. " " .. res.locString("Global$TitlePet"))
			end			
		end

		view["bg_pet1"]:setResid(string.format("role_%03d.png", exploreData.Data.PetId1))
		res.adjustPetIconPositionInParentLT(view["bg"], view["bg_pet1"], exploreData.Data.PetId1,'TLAdv')
		view["bg_pet2"]:setResid(string.format("role_%03d.png", exploreData.Data.PetId2))
		res.adjustPetIconPositionInParentLT(view["bg"], view["bg_pet2"], exploreData.Data.PetId2,'TLAdv')

		view["bg_btnExplore"]:setListener(function ( ... )
			local isTeamNormal, content = checkTeam()
			if isTeamNormal then
				gameFunc.getTempInfo().setValueForKey("TimeLimitExploreTeamNormal", true)
				GleeCore:showLayer("DTimeLimitExploreMain")
			else
				local param = {}
				param.content = content
				param.callback = function ( ... )
					gameFunc.getTempInfo().setValueForKey("TimeLimitExploreTeamNormal", false)
					gameFunc.getTempInfo().setValueForKey("TimeLimitExploreTeamConType", exploreData.Data.ConType)
					gameFunc.getTempInfo().setValueForKey("TimeLimitExploreTeamConValue", exploreData.Data.ConValue)
					GleeCore:showLayer("DTimeLimitExploreMain")
				end
				GleeCore:showLayer("DConfirmNT", param)
			end
		end)

		view["bg_btnExchange"]:setListener(function ( ... )
			GleeCore:showLayer("DTimeLimitExploreShop")
		end)

		view["bg_btnCall1"]:setListener(function ( ... )
			GleeCore:showLayer("DTimeLimitExploreCallPet", {PetId = exploreData.Data.PetId1})
		end)

		view["bg_btnCall2"]:setListener(function ( ... )
			GleeCore:showLayer("DTimeLimitExploreCallPet", {PetId = exploreData.Data.PetId2})
		end)

		view["bg_btnDetail"]:setListener(function ( ... )
			GleeCore:showLayer("DHelp", {type = "限时探险"})
		end)

		view["bg_btnAddTicket"]:setListener(function ( ... )
			local function TimeLimitExploreTicketBuy( amt, closeBuyLayer )
				self:send(netModel.getModelTimeCopyTicketBuy(amt), function ( data )
					if data and data.D then
						if closeBuyLayer then
							closeBuyLayer()
						end
						timeLimitExploreFunc.setExplore(data.D.TimeCopy)
						gameFunc.getUserInfo().setData(data.D.Role)
						update(self, view, data)
						EventCenter.eventInput("UpdateTimeLimitExplore")
					end
				end)
			end

			local cost = dbManager.getInfoDefaultConfig("TLAdvBuyCost").Value
			if userFunc.getCoin() >= cost then
				local param = {}
				param.itemType = "TimeLimitExploreTicket"
				param.hbPrice = cost
				param.hbAmtLimit = math.floor(userFunc.getCoin() / cost)
				param.callback = function ( data )
					TimeLimitExploreTicketBuy(data.amt, data.closeBuyLayer)
				end
				GleeCore:showLayer("DMallItemBuy", param)
			else
				require "Toolkit".showDialogOnCoinNotEnough()
			end
		end)

		require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,function ( ... )
			view["bg_#label"]:setPosition(ccp(-281.42862,167.14285))
			view["bg_#layout1"]:setPosition(ccp(-274.7621,117.142815))
		end)
	end
end

local getNetModel = function ( )
	return netModel.getModelTimeCopyGet()
end

return {update = update, getNetModel = getNetModel}