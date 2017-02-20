local appData = require 'AppData'
local timeTool = require "TimeListManager"
local userFunc = require "UserInfo"
local petFunc = require "PetInfo"
local res = require "Res"
local netModel = require "netModel"

local update,update1

local function updateCoinView(self,view,coin)
	view["bg_coinBg_diamondCount"]:setString(coin)
	local w = view["bg_coinBg_diamondCount"]:getContentSize().width+30
	view["bg_#coinBg"]:setContentSize(CCSizeMake(w,35))
	view["bg_coinBg_diamondCount"]:setPosition(w/2-5,0)
	view["bg_coinBg_#diamondIcon"]:setPosition(-w/2,0)
end

local function onPetExtractCallback( self,view,data,again,useCoin )
	print(data)
	if data.D.Role then
		userFunc.setData(data.D.Role)
		updateCoinView(self,view,userFunc.getCoin())
		require "EventCenter".eventInput("UpdateGoldCoin")
		-- view["diamondCount"]:setString(userFunc.getCoin())
	end
	petFunc.setPet(data.D.Pet)
	petFunc.addPets(data.D.Pets)
	if data.D.TimePet.ScoreFree then
		again = nil
		useCoin = nil
	end
	GleeCore:showLayer('DPetAcademyEffectV2',{pets={data.D.Pet},again=again,useCoin=useCoin})
	-- self:toast("恭喜获得"..data.D.Pet.Name)
	return update1(self,view,data.D)
end

local function onFreeEnable( self,view,free,isTimeEnd )
	view["bg_nextFree"]:setVisible(not free and not isTimeEnd)
	local enable = free and not isTimeEnd
	view["bg_freeBtn"]:setEnabled(enable)
--	view["bg_freeBtn"]:setOpacity(enable and 255 or 128)
	if enable then
		view["bg_freeBtn"]:setListener(function ( ... )
			self:send(netModel.getModelTimePetExtract(true),function ( data )
				return onPetExtractCallback(self,view,data)
			end)
		end)
	end
end

update1 = function ( self,view,data )
	local actInfo = appData.getActivityInfo().getDataByType(3)
	local isTimeEnd = -math.floor(timeTool.getTimeUpToNow(actInfo.CloseAt)) - 3600 * 24 <= 0

	view.mRanks = data.Ranks

	local free = data.TimePet.Cnt == 0
	if not free and not isTimeEnd then
		local nextFreeTime = 12*3600 - math.floor(timeTool.getTimeUpToNow(data.TimePet.LastFreeTime))
		if nextFreeTime<=0 then
			free = true
		else
			print(view["bg_nextFree_time"])
			view["bg_nextFree_time"]:setHourMinuteSecond(timeTool.getTimeInfoBySeconds(nextFreeTime))
			if not view.mFreeTimeListener then
				view.mFreeTimeListener = ElfDateListener:create(function ( ... )
					view.mFreeTimeListener = nil
					isTimeEnd = -math.floor(timeTool.getTimeUpToNow(actInfo.CloseAt)) - 3600 * 24 <= 0
					return onFreeEnable(self,view,true,isTimeEnd)
				end)
				view.mFreeTimeListener:setHourMinuteSecond(0,0,1)
				view["bg_nextFree_time"]:addListener(view.mFreeTimeListener)
			end
		end
	end
	onFreeEnable(self,view,free,isTimeEnd)

	local c = 9 - data.TimePet.Cnt%10
	view["bg_status1"]:setVisible(c ~= 0)
	view["bg_status2"]:setVisible(c == 0)
	if c ~= 0 then
		view["bg_status1_count"]:setString(c)
	end

	if not free and not data.TimePet.ScoreFree then
		self:roleNewsUpdate()
	end

	view["bg_diamondBtn"]:setVisible(not data.TimePet.ScoreFree)
	view["bg_diamondBtn1"]:setVisible(data.TimePet.ScoreFree)
	view["bg_diamondBtn"]:setEnabled(not isTimeEnd)
	view["bg_diamondBtn1"]:setEnabled(not isTimeEnd)
	if data.TimePet.ScoreFree then
		view["bg_diamondBtn1"]:setListener(function ( ... )
			self:send(netModel.getModelTimePetExtract(false),function ( data )
				return onPetExtractCallback(self,view,data)
			end)
		end)
	else
		local price = require 'DBManager'.getInfoDefaultConfig('NiudanCost').Value
		view['bg_diamondBtn_linearlayout_#label']:setString(string.format(res.locString("Activity$TimeLimitPetBtnTip1"), price))
		local func 
		func = function ( ... )
			if userFunc.getCoin() < price then
				require "Toolkit".showDialogOnCoinNotEnough()
			else
				self:send(netModel.getModelTimePetExtract(false),function ( data )
					return onPetExtractCallback(self,view,data,func,true)
				end)
			end
		end
		view["bg_diamondBtn"]:setListener(func)
	end

	view["bg_scoreBg_layout"]:removeAllChildrenWithCleanup(true)
	for i=1,3 do
		local v = data.Ranks[i]
		if v then
			local item = view.createLuaSet("@player")
			item["rank"]:setString(string.format("NO.%d",v.Id))
			item["name"]:setString(v.Name)
			item["score"]:setString(v.Score)
			item["gift"]:setResid(string.format("libao%d.png",v.Id))
			view["bg_scoreBg_layout"]:addChild(item[1])
		end
	end

	view["bg_scoreLayout_myScore"]:setString(" "..data.TimePet.Score)
	if data.Rank then
		view["bg_rankLayout_myRank"]:setString(" "..data.Rank.Id)
	else
		view["bg_rankLayout_myRank"]:setString(" "..res.locString("Global$None"))
	end
end

update = function ( self,view,data,showActivityType, oldshowActivityType )
	require 'LangAdapter'.fontSize(view["bg_scoreBg_subtitle_#label1"],nil,nil,nil,nil,18,nil,nil,nil,nil,16)
	require 'LangAdapter'.fontSize(view["bg_scoreBg_subtitle_#label2"],nil,nil,nil,nil,18,nil,nil,nil,nil,16)
	require 'LangAdapter'.fontSize(view["bg_scoreBg_subtitle_#label3"],nil,nil,nil,nil,18,nil,nil,nil,nil,16)
	require 'LangAdapter'.fontSize(view["bg_scoreBg_title_#title"],nil,nil,nil,nil,nil,18,18,nil,nil,16)
	require 'LangAdapter'.fontSize(view["bg_scoreBg_title_checkTip"],nil,nil,nil,nil,nil,18,18,nil,nil,16)
	require 'LangAdapter'.fontSize(view["bg_nextFree_#label"],nil,nil,18)
	require 'LangAdapter'.fontSize(view["bg_nextFree_time"],nil,nil,18)
	require 'LangAdapter'.nodePos(view["bg_nextFree"],nil,nil,ccp(-150,-25))
	require 'LangAdapter'.nodePos(view["bg_status1_count"],nil,nil,ccp(-37,14),ccp(12,12),ccp(-66,13),ccp(0,13),ccp(50,14))
	selectLang(nil,nil,nil,function (  )
		view["bg_status2_#elf"]:setPosition(0,13)
	end,function (  )
		view["bg_status1"]:setScale(0.8)
		view["bg_status2"]:setScale(0.8)
		view["bg_status2"]:setContentSize(CCSize(404,25))
		view["bg_status2_#elf"]:setPosition(-5,14)
	end,function (  )
		view["bg_status2"]:setContentSize(CCSize(404,25))
		view["bg_status2_#elf"]:setPosition(-5,14)
	end,function (  )
		view["bg_status2"]:setContentSize(CCSize(404,25))
		view["bg_status2_#elf"]:setPosition(-5,14)
	end)
	require 'LangAdapter'.fontSize(view["bg_diamondBtn_linearlayout_#label"],nil,nil,22,nil,nil,22,22)
	require 'LangAdapter'.LabelNodeAutoShrink(view["bg_diamondBtn1_text"],220)

	local actInfo = appData.getActivityInfo().getDataByType(3)
	if -math.floor(require "TimeListManager".getTimeUpToNow(actInfo.CloseAt)) <= 0 then
		self:onActivityFinish( require 'ActivityType'.TimeLimitPet )
		return
	end

	local lastTime =  -math.floor(timeTool.getTimeUpToNow(actInfo.CloseAt)) - 3600 * 24
	lastTime = math.max(lastTime, 0)

	local date = view["bg_timerBg_layout_ActCountDownTime"]:getElfDate()
	date:setHourMinuteSecond(0, 0, lastTime)
	if lastTime > 0 then
		view["bg_timerBg_layout_ActCountDownTime"]:setUpdateRate(-1)
		view["bg_timerBg_layout_ActCountDownTime"]:addListener(function (  )
			view["bg_timerBg_layout_ActCountDownTime"]:setUpdateRate(0)
			GleeCore:showLayer("DTimeLimitPetRankList", data.D.Ranks)
			update1(self,view,data.D)
		end)
	else
		view["bg_timerBg_layout_ActCountDownTime"]:setUpdateRate(0)
		if oldshowActivityType ~= require 'ActivityType'.TimeLimitPet then
			self:runWithDelay(function ( ... )
				GleeCore:showLayer("DTimeLimitPetRankList", data.D.Ranks)
			end, 0.5)
		end
	end

	local w = view["bg_timerBg_layout"]:getContentSize().width+115
	view["bg_timerBg_layout"]:setPosition(-w/2+5,0)
	view["bg_timerBg"]:setContentSize(CCSize(w,35))

	require 'LangAdapter'.fontSize(view["bg_timerBg_layout_#countdownLabel"],nil,nil,nil,nil,nil,18,18)
	require 'LangAdapter'.fontSize(view["bg_timerBg_layout_ActCountDownTime"],nil,nil,nil,nil,nil,18,18)

	updateCoinView(self,view,userFunc.getCoin())
	-- view["diamondCount"]:setString(userFunc.getCoin())

	view["bg_petLayout"]:removeAllChildrenWithCleanup(true)
	local ids = actInfo.Data.Pets
	table.foreach(ids,function ( id,_ )
		id = tonumber(id)
		local item = view.createLuaSet("@petItem")

		local parent = item["clip_pet"]:getParent()
		res.adjustPetIconPositionInParentLT( parent,item["clip_pet"],id,'limited' )
		local pet = petFunc.getPetInfoByPetId(id)
		item["clip_btn"]:setListener(function ( ... )
			local param = {}
			param.nPet = pet
			--param.isPetFromDbPet = true
			param.isNotMine = true
			GleeCore:showLayer("DPetDetailV", param)
		end)
		require "PetNodeHelper".updateStarLayout(item["clip_starLayout"],nil,id)
		-- for i=1,pet.Star do
		-- 	local star = view.createLuaSet("@star")[1]
		-- 	star:setResid(res.getStarResid(0))
		-- 	item["clip_starLayout"]:addChild(star)
		-- end
		view["bg_petLayout"]:addChild(item[1])
	end)

	view["bg_scoreBg_title_checkTip"]:runElfAction(res.getFadeAction(1))

	view["bg_scoreBg_btn"]:setListener(function ( ... )
		GleeCore:showLayer("DTimeLimitPetRankList",data.D.Ranks)
	end)

	require "LangAdapter".nodePos(view["bg_status2_#elf"],ccp(-58,0))

	update1(self,view,data.D)
end

local function getNetModel( )
	return netModel.getModelTimePetGet()
end

return {getNetModel = getNetModel,update = update}