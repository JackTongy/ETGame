local Config = require "Config"
local dbManager = require "DBManager"
local res = require "Res"
local netModel = require "netModel"
local timeTool = require "TimeListManager"
local userFunc = require "UserInfo"
local petFunc = require "PetInfo"
local equipFunc = require "EquipInfo"
local gemFunc = require "GemInfo"
local calculateTool = require "CalculateTool"
local EventCenter = require 'EventCenter'
local musicHelper = require 'framework.helper.MusicHelper'
local teamFunc = require "TeamInfo"

local ViewType = {Arena = 1,Report= 2,Exchange = 3,Rank = 4}

local DArena = class(LuaDialog)

function DArena:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DArena.cocos.zip")
    return self._factory:createDocument("DArena.cocos")
end

--@@@@[[[[
function DArena:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_contentBg = set:getJoint9Node("bg_contentBg")
    self._bg_contentBg_top_honorLayout_honorLabel = set:getLabelNode("bg_contentBg_top_honorLayout_honorLabel")
    self._bg_contentBg_top_honorLayout_honor = set:getLabelNode("bg_contentBg_top_honorLayout_honor")
    self._bg_contentBg_top_ranklayout_rank = set:getLabelNode("bg_contentBg_top_ranklayout_rank")
    self._myTeam = set:getElfNode("myTeam")
    self._myTeam_bg_powerLayout_power = set:getLabelNode("myTeam_bg_powerLayout_power")
    self._myTeam_bg_teamChangeBtn = set:getClickNode("myTeam_bg_teamChangeBtn")
    self._myTeam_bg_teamLayout = set:getLinearLayoutNode("myTeam_bg_teamLayout")
    self._icon = set:getElfNode("icon")
    self._starLayout = set:getLayoutNode("starLayout")
    self._playerLayout = set:getLinearLayoutNode("playerLayout")
    self._icon = set:getElfNode("icon")
    self._iconBtn = set:getButtonNode("iconBtn")
    self._lvBg = set:getElfNode("lvBg")
    self._lvBg_lv = set:getLabelNode("lvBg_lv")
    self._name = set:getLabelNode("name")
    self._layout_rankLayout = set:getLinearLayoutNode("layout_rankLayout")
    self._layout_rankLayout_rank = set:getLabelNode("layout_rankLayout_rank")
    self._layout_powerLayout = set:getLinearLayoutNode("layout_powerLayout")
    self._layout_powerLayout_rank = set:getLabelNode("layout_powerLayout_rank")
    self._challengeBtn = set:getClickNode("challengeBtn")
    self._lastCount = set:getLabelNode("lastCount")
    self._changeBtn = set:getClickNode("changeBtn")
    self._timelayout = set:getLinearLayoutNode("timelayout")
    self._timelayout_time = set:getTimeNode("timelayout_time")
    self._leaderIcon = set:getElfNode("leaderIcon")
    self._benchIcon = set:getElfNode("benchIcon")
    self._list = set:getListNode("list")
    self._bg_icon = set:getElfNode("bg_icon")
    self._bg_content = set:getRichLabelNode("bg_content")
    self._bg_timeLabel = set:getLabelNode("bg_timeLabel")
    self._bg_replayBtn = set:getClickNode("bg_replayBtn")
    self._list = set:getListNode("list")
    self._bg_icon = set:getElfNode("bg_icon")
    self._bg_iconBtn = set:getButtonNode("bg_iconBtn")
    self._bg_name = set:getLabelNode("bg_name")
    self._bg_honorNeed = set:getLabelNode("bg_honorNeed")
    self._bg_exchangeBtn = set:getClickNode("bg_exchangeBtn")
    self._bg_desLayout_label = set:getLabelNode("bg_desLayout_label")
    self._bg_desLayout_count = set:getLabelNode("bg_desLayout_count")
    self._list = set:getListNode("list")
    self._rank = set:getLabelNode("rank")
    self._name = set:getLabelNode("name")
    self._powerLayout_power = set:getLabelNode("powerLayout_power")
    self._teamLayout = set:getLinearLayoutNode("teamLayout")
    self._icon = set:getElfNode("icon")
    self._career = set:getElfNode("career")
    self._lv = set:getLabelNode("lv")
    self._starLayout = set:getLayoutNode("starLayout")
    self._btn = set:getButtonNode("btn")
    self._lv = set:getLabelNode("lv")
    self._bg_topBar_btnHelp = set:getButtonNode("bg_topBar_btnHelp")
    self._bg_topBar_btnReturn = set:getButtonNode("bg_topBar_btnReturn")
    self._bg_topBar_tabArena = set:getTabNode("bg_topBar_tabArena")
    self._bg_topBar_tabRank = set:getTabNode("bg_topBar_tabRank")
    self._bg_topBar_tabReward = set:getTabNode("bg_topBar_tabReward")
    self._bg_topBar_tabReport = set:getTabNode("bg_topBar_tabReport")
--    self._@arena = set:getElfNode("@arena")
--    self._@pet = set:getElfNode("@pet")
--    self._@star = set:getElfNode("@star")
--    self._@item = set:getElfNode("@item")
--    self._@report = set:getElfNode("@report")
--    self._@reportItem = set:getElfNode("@reportItem")
--    self._@exchange = set:getElfNode("@exchange")
--    self._@exchangeItem = set:getElfNode("@exchangeItem")
--    self._@rank = set:getElfNode("@rank")
--    self._@player = set:getElfNode("@player")
--    self._@rankPet = set:getElfNode("@rankPet")
--    self._@star = set:getElfNode("@star")
--    self._@NewRecord = set:getBMFontNode("@NewRecord")
end
--@@@@]]]]

local Launcher = require 'Launcher'
local func
func = function ( userData )
	if userData and userData.NetData then
		Launcher.Launching(userData.NetData)
	else
	   	Launcher.callNet(netModel.getModelArenaInfo(),function ( data )
	     		Launcher.Launching(data)   
	   	end,function ( data )
			if data.Code == 807 then
				require 'UIHelper'.hidden()
				Launcher.callNet(netModel.getModelArenaAdd(),function ( ... )
					return func()
				end)
			else
				Launcher.cancel()
			end
		end)
	end
end

Launcher.register('DArena',func)

local preNo
local hasNewRecord

--------------------------------override functions----------------------
function DArena:onInit( userData, netData )
	require 'LangAdapter'.LayoutChildrenReverseifArabic(self._set:getLinearLayoutNode('bg_contentBg_top_#ranklayout'))
	require 'LangAdapter'.LayoutChildrenReverseifArabic(self._set:getLinearLayoutNode('bg_contentBg_top_#honorLayout'))

	self._set:getLabelNode("bg_topBar_tabArena_normal_#title"):setDimensions(CCSize(0,0))
	self._set:getLabelNode("bg_topBar_tabArena_pressed_#title"):setDimensions(CCSize(0,0))
	self._set:getLabelNode("bg_topBar_tabArena_invalid_#title"):setDimensions(CCSize(0,0))

	self._set:getLabelNode("bg_topBar_tabRank_normal_#title"):setDimensions(CCSize(0,0))
	self._set:getLabelNode("bg_topBar_tabRank_pressed_#title"):setDimensions(CCSize(0,0))
	self._set:getLabelNode("bg_topBar_tabRank_invalid_#title"):setDimensions(CCSize(0,0))
	
	self._set:getLabelNode("bg_topBar_tabReward_normal_#title"):setDimensions(CCSize(0,0))
	self._set:getLabelNode("bg_topBar_tabReward_pressed_#title"):setDimensions(CCSize(0,0))
	self._set:getLabelNode("bg_topBar_tabReward_invalid_#title"):setDimensions(CCSize(0,0))

	self._set:getLabelNode("bg_topBar_tabReport_normal_#title"):setDimensions(CCSize(0,0))
	self._set:getLabelNode("bg_topBar_tabReport_pressed_#title"):setDimensions(CCSize(0,0))
	self._set:getLabelNode("bg_topBar_tabReport_invalid_#title"):setDimensions(CCSize(0,0))

	---
	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabArena_normal_#title"),72)
	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabArena_pressed_#title"),72)
	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabArena_invalid_#title"),72)

	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabRank_normal_#title"),72)
	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabRank_pressed_#title"),72)
	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabRank_invalid_#title"),72)

	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabReward_normal_#title"),72)
	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabReward_pressed_#title"),72)
	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabReward_invalid_#title"),72)

	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabReport_normal_#title"),72)
	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabReport_pressed_#title"),72)
	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabReport_invalid_#title"),72)

	require "LangAdapter".LabelNodeAutoShrink(self._bg_contentBg_top_honorLayout_honorLabel,250)

	res.doActionDialogShow(self._bg,function ( ... )
		require 'GuideHelper':registerPoint('挑战第一个',self.mFirstPlayerBtn)
	end)

	self.views = {}
	self.refreshTable = {[ViewType.Arena] = true,[ViewType.Report] = true,[ViewType.Exchange] = true,[ViewType.Rank] = true}

	local triggerBtn = self:addTopBtnListener()[userData and userData.ViewType or ViewType.Arena]
	print(netData)
	self.mArenaInfo = netData.D
	self.mMyArenaInfo = self:find(self.mArenaInfo.Arenas,"Rid",userFunc.getId())

	EventCenter.addEventFunc("OnAppStatChange", function ( state )
		if state == 2 then
			if self.curViewType == ViewType.Arena then
				return self:showArenaView()
			end
		end
	end, "DArena")

	self:onEnter()

	triggerBtn:trigger(nil)

	self:updateRedPoint()

	if userData and userData.FromBattle and hasNewRecord then
	-- if hasNewRecord then
		hasNewRecord = false
		self._bg_contentBg_top_ranklayout_rank:setString(preNo)
		require "framework.sync.TimerHelper".tick(function ( ... )
			local Swf = require 'framework.swf.Swf'
			local myswf = Swf.new('Swf_1')
			self._bg:addChild( myswf:getRootNode() )

			myswf:getRootNode():setPosition(0,15)

			local animBg = RectangleNode:create()
			animBg:setContentSize(CCSize(1136*2,640*2))
			animBg:setColorf(0, 0, 0, 0.6)
			myswf:getNodeByTag(1):addChild(animBg)

			local record = self:createLuaSet("@NewRecord")[1]
			record:setString(self.mMyArenaInfo.No)
			record:setAnchorPoint(ccp(0.5,0.5))
			record:setPosition(240- self._bg_contentBg_top_ranklayout_rank:getContentSize().width,-25)
			myswf:getNodeByTag(4):addChild(record)

			local shapeMap = {
				["shape-2"] = "",
				['shape-4'] = 'NEWRECORD.png',
				['shape-6'] = "",
				['shape-3'] = "",
			}
			myswf:play(shapeMap, nil, function ( ... )
				myswf:getRootNode():removeFromParentAndCleanup(true)
				self._bg_contentBg_top_ranklayout_rank:setVisible(true)
				self._bg_contentBg_top_ranklayout_rank:setString(self.mMyArenaInfo.No)
			end)
			musicHelper.playEffect(res.Sound.ui_star)
			self:runWithDelay(function ( ... )
				musicHelper.playEffect(res.Sound.ui_taxt)
				self._bg_contentBg_top_ranklayout_rank:setVisible(false)
			end,1.5)
			return true
		end)
	end
end

function DArena:onBack( userData, netData )
	
end

function DArena:onEnter( ... )
	require 'GuideHelper':check('CArena')
end

function DArena:onRelease( ... )
	EventCenter.resetGroup("DArena")
end

--------------------------------custom code-----------------------------
function DArena:updateRedPoint( ... )
	local cd = -timeTool.getOffsetTimeToNow(self.mMyArenaInfo.Cd)
	if self.mArenaInfo.C<=0 or cd>0 then
		self:sendBackground(netModel.getModelRoleNewsUpdate("arena"))
		require "BroadCastInfo".set("arena", false)
		require 'EventCenter'.eventInput("EventArena")
	end

	local timeManager = require "TimeListManager"
	if cd>0 and self.mArenaInfo.C>0 then
		timeManager.addToTimeList(timeManager.packageTimeStruct("arenaCD", cd, function ( delta, data )
		--	print(delta)
			if delta <= 0 then
				require "BroadCastInfo".set("arena", true)
				require 'EventCenter'.eventInput("EventArena")
			end
		end))
	else
		timeManager.removeFromTimeList("arenaCD")
	end
end

function DArena:addTopBtnListener( ... )
	local tabBtns = {[ViewType.Arena] = self._bg_topBar_tabArena,
				[ViewType.Report] = self._bg_topBar_tabReport,
				[ViewType.Exchange] = self._bg_topBar_tabReward,
				[ViewType.Rank] = self._bg_topBar_tabRank}
	table.foreach(tabBtns,function ( viewType,tabBtn )
		tabBtn:setListener(function (  )
			if self.curViewType~=viewType then
				self.curViewType = viewType
				return self:updateView()
			end
		end)
	end)

	self.close = function ( ... )
		self:onRelease()
	end

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_topBar_btnHelp:setListener(function (  )
		GleeCore:showLayer("DHelp", {type = "竞技场", arenaRank = tonumber(self.mMyArenaInfo.No)})
	end)

	self._bg_topBar_btnReturn:setTriggleSound(res.Sound.back)
	self._bg_topBar_btnReturn:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)

	return tabBtns
end

function DArena:updateView( ... )
	local funcViewMap = {[ViewType.Arena] = self.showArenaView,
				[ViewType.Report] = self.showReportView,
				[ViewType.Exchange] = self.showExchangeView,
				[ViewType.Rank] = self.showRankView}
	table.foreach(ViewType,function ( _,v )
		if self.curViewType == v then
			funcViewMap[v](self)
			self.views[v][1]:setVisible(true)
		else
			if self.views[v] then
				self.views[v][1]:setVisible(false)
			end
		end
	end)
end

function DArena:showTop( ... )
	if self.curViewType == ViewType.Rank then
		self._bg_contentBg_top_honorLayout_honorLabel:setString(res.locString("CArena$HonorDailyTip"))
		self._bg_contentBg_top_honorLayout_honor:setString(calculateTool.getArenaHornorByRank(self.mMyArenaInfo.No))
	else
		self._bg_contentBg_top_honorLayout_honorLabel:setString(res.locString("CArena$MyHonor"))
		self._bg_contentBg_top_honorLayout_honor:setString(self.mMyArenaInfo.Honor)
	end
	self._bg_contentBg_top_ranklayout_rank:setString(self.mMyArenaInfo.No)
end

function DArena:createTeamLayout( view,pets,n )
	view:removeAllChildrenWithCleanup(true)
	for i=1,n do
		local pet = pets[i]
		local petSet = self:createLuaSet("@pet")
		if pet then
			res.setPetDetail(petSet["icon"],pet)
			local dbPet = dbManager.getCharactor(pet.PetId)
			require "PetNodeHelper".updateStarLayout(petSet["starLayout"],dbPet)
			-- for i=1,dbPet.star_level do
			-- 	local star = self:createLuaSet("@star")
			-- 	star[1]:setResid(res.getStarResid(pet.MotiCnt))
			-- 	petSet["starLayout"]:addChild(star[1])
			-- end
			petSet["starLayout"]:setVisible(true)
		end
		view:addChild(petSet[1])
	end
end

function DArena:showArenaView( )
	local set  = self.views[ViewType.Arena]
	if not set then
		set = self:createLuaSet("@arena")
		self.views[ViewType.Arena] = set
		self._bg_contentBg:addChild(set[1])

		set["changeBtn"]:setListener(function ( ... )
			self:send(netModel.getModelArenaInfo(),function ( netData )
				print(netData)
				self.mArenaInfo = netData.D
				self:setNetData(netData)
				self.mMyArenaInfo = self:find(self.mArenaInfo.Arenas,"Rid",userFunc.getId())
				self.refreshTable[ViewType.Arena] = true
				self.refreshTable[ViewType.Report] = true
				return self:showArenaView()
			end)
		end)

		require 'LangAdapter'.LabelNodeAutoShrink(set["#lastCountLabel"],130)
		require 'LangAdapter'.LabelNodeAutoShrink(set["myTeam_bg_teamChangeBtn_#label"],88)
		require 'LangAdapter'.LayoutChildrenReverseifArabic(set["myTeam_bg_#powerLayout"])
	end
	if self.refreshTable[ViewType.Arena] then
		self.refreshTable[ViewType.Arena] = false

		set["playerLayout"]:removeAllChildrenWithCleanup(true)

		local function onAtkTeamChange( pets,power )
			self:createTeamLayout(set["myTeam_bg_teamLayout"],pets,6)
			set["myTeam_bg_powerLayout_power"]:setString(power)
		end

		local function showSelfTeam( info )
			local team = self:find(self.mArenaInfo.Teams,"Rid",info.Rid)
			local pets = {}
			for _,pid in ipairs(team.PetIdList) do
				table.insert(pets,self:find(self.mArenaInfo.Pets,"Id",pid))
			end
			local benchPet = self:find(self.mArenaInfo.Pets,"Id",team.BenchPetId)
			if benchPet then
				pets[6] = benchPet
			end
			self:createTeamLayout(set["myTeam_bg_teamLayout"],pets,6)
			set["myTeam_bg_powerLayout_power"]:setString(team.CombatPower)
			set["myTeam_bg_teamChangeBtn"]:setListener(function ( ... )
				--return GleeCore:showLayer('DArenaTeamChoose',{OnAtkTeamChange = onAtkTeamChange})
				GleeCore:showLayer("DArenaBattleArray", {OnAtkTeamChange = onAtkTeamChange})
			end)
		end

		local function addPlayer( item,info )
			local team = self:find(self.mArenaInfo.Teams,"Rid",info.Rid)
			local pets = {}
			for _,pid in ipairs(team.PetIdList) do
				table.insert(pets,self:find(self.mArenaInfo.Pets,"Id",pid))
			end
			
			local role = self:find(self.mArenaInfo.Roles,"Id",info.Rid)
			local userPet = petFunc.getPetInfoByPetId(role.PetId)
			userPet.AwakeIndex = role.AwakeIndex
			res.setPetDetail(item["icon"],userPet)
			item["lvBg"]:setResid(string.format("N_JJC_%d.png",res.getFinalAwake(role.AwakeIndex)))
			item["lvBg_lv"]:setString(role.Lv)
			item["name"]:setString(role.Name)
			item["layout_rankLayout_rank"]:setString(info.No)
			item["layout_powerLayout_rank"]:setString(team.CombatPower)
			if not self.mFirstPlayerBtn then
				self.mFirstPlayerBtn = item["challengeBtn"]
			end
			item["challengeBtn"]:setListener(function ( ... )
				local function battle( ... )
					self:send(netModel.getModelArenaBattle(info.Rid,info.No,self.mMyArenaInfo.No),function ( netData )
						print('challengeBtn')
						print(netData)
						local data = {}
						data.type = 'arena'
						data.data = {}
						data.data.petList,data.data.enemyList = self:getPetsInfo(netData.D.Info)
						data.data.Bid = netData.D.Bid
						data.data.enemyName = info.Name
						preNo = self.mMyArenaInfo.No

						for i,v in ipairs(netData.D.Info.Teams) do
							if v.Rid == userFunc.getId() then
								data.data.petBornIJList = teamFunc.getPosListAtkType(v)
							else
								data.data.enemyBornIJList = teamFunc.getPosListDefType(v)
							end
						end

						EventCenter.eventInput("BattleStart", data)
						require "GuideHelper":check("ArenaBattle")
					end,function ( netData )
						if netData.Code == 803 then
							self:hiddenToast()
							self:toast(res.locString("CArena$RankChangeTip"))
							self:send(netModel.getModelArenaInfo(),function ( netData )
								self.mArenaInfo = netData.D
								self:setNetData(netData)
								self.mMyArenaInfo = self:find(self.mArenaInfo.Arenas,"Rid",userFunc.getId())
								self.refreshTable[ViewType.Arena] = true
								self.refreshTable[ViewType.Report] = true
								self.refreshTable[ViewType.Rank] = true
								return self:showArenaView()
							end)
						end
					end)
				end

				if self.mArenaInfo.C>0 then
					if self.mCdTimeListener then
						local param = {}
						param.content = res.locString("CArena$ClearCDTip")
						local price = calculateTool.getArenaCDCost(-timeTool.getOffsetTimeToNow(self.mMyArenaInfo.Cd))
						param.content = string.format(param.content,price)
						param.callback = function ( ... )
							local coin = userFunc.getCoin()
							if coin<price then
								require "Toolkit".showDialogOnCoinNotEnough()
							else
								self:send(netModel.getModelArenaClearCD(),function ( data )
									userFunc.setCoin(coin - data.D.Coin)
									EventCenter.eventInput("UpdateGoldCoin")
									self.mCdTimeListener = nil
									set["timelayout"]:setVisible(false)
									self.mMyArenaInfo.Cd = 0
									return battle()
								end)
							end
						end
						GleeCore:showLayer("DConfirmNT",param)
					else
						return battle()
					end
				elseif self.mArenaInfo.C == 0 then
					local vip = userFunc.getVipLevel()
					if vip<4 then
						local param = {}
						param.content = res.locString("CArena$BuyCountTip0")
						param.RightBtnText = res.locString("Global$BtnRecharge")
						param.callback = function ( ... )
							GleeCore:showLayer("DRecharge")
						end
						GleeCore:showLayer("DConfirmNT",param)
					else
						local buyCountLast = dbManager.getVipInfo(vip).Arena - self.mArenaInfo.Exc
						if buyCountLast>0 then
							local price = calculateTool.getArenaBuyCountPrice(self.mArenaInfo.Exc)
							local param = {}
							param.content = res.locString("CArena$BuyCountTip1")
							param.content = string.format(param.content,price,buyCountLast)
							param.RightBtnText = res.locString("Global$BUY")
							param.callback = function ( ... )
								local coin = userFunc.getCoin()
								if coin<price then
									require "Toolkit".showDialogOnCoinNotEnough()
								else
									self:send(netModel.getModelArenaBuyCount(),function ( netData )
										userFunc.setCoin(coin - price)
										EventCenter.eventInput("UpdateGoldCoin")
										self.mArenaInfo.C = 1
										self.mArenaInfo.Exc = self.mArenaInfo.Exc + 1
										if self.mCdTimeListener then
											self:updateRedPoint()
											return self:showArenaView()
										else
											return battle()
										end
									end)
								end
							end
							GleeCore:showLayer("DConfirmNT",param)
						else
							if vip<15 then
								local param = {}
								param.content = res.locString("CArena$BuyCountTip2")
								param.content = string.format(param.content,calculateTool.getArenaBuyCountPrice(self.mArenaInfo.Exc),buyCountLast)
								param.RightBtnText = res.locString("Global$BtnRecharge")
								param.callback = function ( ... )
									GleeCore:showLayer("DRecharge")
								end
								GleeCore:showLayer("DConfirmNT",param)
							else
								return self:toast(res.locString("CArena$BuyCountTip3'"))
							end
						end
					end
				end
			end)
			item["iconBtn"]:setListener(function ( ... )
				local benchPet = self:find(self.mArenaInfo.Pets,"Id",team.BenchPetId)
				if benchPet then
					table.insert(pets,benchPet)
				end
				self:send(netModel.getModelArenaTeamEquipmentInfo(team.Rid,team.TeamId),function ( data )
					print(data)
					local param = {}
					param.Team = team
					param.Pets = {unpack(pets)}
					param.Equips = data.D.Equipments
					param.Mibaos = data.D.Mibaos
					param.Gems = data.D.Gems
					param.Partners = data.D.Partners
					param.Lv = info.Lv
					param.Runes = data.D.Runes
					for _,v in ipairs(data.D.PartnerPets) do
						table.insert(param.Pets,v)
					end
					param.CloseFunc = function ( ... )
						require "framework.sync.TimerHelper".tick(function ( ... )
							GleeCore:showLayer("DArena",{ViewType = ViewType.Arena,NetData = self:getNetData()})
							return true
						end)
					end
					GleeCore:closeAllLayers()
					GleeCore:pushController("CTeam",param, nil, res.getTransitionFade())
				end)
			end)
		end

		table.sort(self.mArenaInfo.Arenas,function ( a,b )
			return a.No<b.No
		end)

		local trigger = false

		for i,v in ipairs(self.mArenaInfo.Arenas) do
			local isSelf = v.Rid == userFunc.getId()
			if isSelf then
				showSelfTeam(v)
			else
				local item = self:createLuaSet("@item")
				set["playerLayout"]:addChild(item[1])
				require 'LangAdapter'.LabelNodeAutoShrink(item["challengeBtn_#label"],88)
				require 'LangAdapter'.LayoutChildrenReverseifArabic(item["layout_rankLayout"])
				require 'LangAdapter'.LayoutChildrenReverseifArabic(item["layout_powerLayout"])
				item["layout_rankLayout_#sp"]:setContentSize(CCSize(5,0))
				item["layout_powerLayout_#sp"]:setContentSize(CCSize(5,0))
				require 'LangAdapter'.fontSize(item["layout_rankLayout_#label"],nil,nil,nil,nil,nil,nil,nil,nil,16)
				require 'LangAdapter'.fontSize(item["layout_rankLayout_rank"],nil,nil,nil,nil,nil,nil,nil,nil,16)
				require 'LangAdapter'.fontSize(item["layout_powerLayout_#label"],nil,nil,nil,nil,nil,nil,nil,nil,16)
				require 'LangAdapter'.fontSize(item["layout_powerLayout_rank"],nil,nil,nil,nil,nil,nil,nil,nil,16)
				require 'LangAdapter'.nodePos(item["#layout"],nil,nil,nil,nil,nil,nil,nil,nil,ccp(0,-25))
				addPlayer(item,v)
				if not trigger and Config.AutoArenaBattleTest then
					-- require "framework.sync.TimerHelper".tick(function ( ... )
						item["challengeBtn"]:trigger(nil)
						-- return true
					-- end)
					trigger = true
				end
			end
		end
	end

	-- local rewardTime = timeTool.getOffsetTimeToNow(self.mArenaInfo.Award)
	-- if rewardTime>0 then
	-- 	set["rewardTimeLayout_time"]:setHourMinuteSecond(0,0,0)
	-- 	set["rewardTimeLayout_time"]:setUpdateRate(0)
	-- else
	-- 	set["rewardTimeLayout_time"]:setHourMinuteSecond(timeTool.getTimeInfoBySeconds(-rewardTime))
	-- 	set["rewardTimeLayout_time"]:setUpdateRate(-1)
	-- 	if not self.mRewardTimeListener then
	-- 		self.mRewardTimeListener = ElfDateListener:create(function ( ... )
	-- 			self.mRewardTimeListener = nil
	-- 			set["rewardTimeLayout_time"]:setHourMinuteSecond(0,0,0)
	-- 			set["rewardTimeLayout_time"]:setUpdateRate(0)
	-- 		end)
	-- 		self.mRewardTimeListener:setHourMinuteSecond(0,0,1)
	-- 		set["rewardTimeLayout_time"]:addListener(self.mRewardTimeListener)
	-- 	end
	-- end

	self:showTop()
	set["lastCount"]:setString(string.format("%d/%d",self.mArenaInfo.C,self.mArenaInfo.Fc+self.mArenaInfo.Exc))
	local cd = -timeTool.getOffsetTimeToNow(self.mMyArenaInfo.Cd)
	print("cd:".. cd)
	if cd>0 then
		print("setVisible true")
		set["timelayout"]:setVisible(true)
		set["timelayout_time"]:setHourMinuteSecond(timeTool.getTimeInfoBySeconds(cd))
		set["timelayout_time"]:setUpdateRate(-1)
		if not self.mCdTimeListener then
			self.mCdTimeListener = ElfDateListener:create(function ( ... )
				self.mCdTimeListener = nil
				print("setVisible false")
				set["timelayout"]:setVisible(false)
			end)
			self.mCdTimeListener:setHourMinuteSecond(0,0,1)
			set["timelayout_time"]:addListener(self.mCdTimeListener)
		end
	else
		print("setVisible false")
		set["timelayout"]:setVisible(false)
		self.mCdTimeListener = nil
	end
end

function DArena:showRankView( ... )
	local set  = self.views[ViewType.Rank] 
	if not set then
		set = self:createLuaSet("@rank")
		self.views[ViewType.Rank] = set
		self._bg_contentBg:addChild(set[1])
		
	end
	if self.refreshTable[ViewType.Rank] then
		self.refreshTable[ViewType.Rank] = false
		self:send(netModel.getModelArenaTopsGet(),function ( data )
			table.sort(data.D.Arenas,function ( a,b )
				return a.No<b.No
			end)

			set["list"]:getContainer():removeAllChildrenWithCleanup(true)
			for i,v in ipairs(data.D.Arenas) do
				local team = self:find(data.D.Teams,"Rid",v.Rid)
				local pets = {}
				for _,pid in ipairs(team.PetIdList) do
					table.insert(pets,self:find(data.D.Pets,"Id",pid))
				end
				local player = self:createLuaSet("@player")
				require 'LangAdapter'.fontSize(player["lv"],nil,nil,18)
				require 'LangAdapter'.nodePos(player["#powerLayout"],nil,nil,ccp(-305,-35))
				require 'LangAdapter'.fontSize(player["powerLayout_#label"],nil,nil,18)
				require 'LangAdapter'.fontSize(player["powerLayout_power"],nil,nil,18)

				player["rank"]:setString(v.No)
				player["name"]:setString(v.Name)
				player["lv"]:setString("Lv."..v.Lv)
				require 'LangAdapter'.selectLang(nil,nil,nil,nil,nil,function ( ... )
			      player["lv"]:setString("Nv."..v.Lv)
			  	end)
				player["powerLayout_power"]:setString(team.CombatPower)
				for i=1,5 do
					local pet = pets[i]
					local petSet
					if pet then
						petSet = self:createLuaSet("@rankPet")
						res.setNodeWithPetAuto(petSet,pet,self)
						-- res.setPetDetail(petSet["icon"],pet)
						-- local dbPet = dbManager.getCharactor(pet.PetId)
						-- for i=1,dbPet.star_level do
						-- 	local star = self:createLuaSet("@star")
						-- 	star[1]:setResid(res.getStarResid(pet.MotiCnt))
						-- 	petSet["starLayout"]:addChild(star[1])
						-- end
						-- petSet["starLayout"]:setVisible(true)
					else
						petSet = self:createLuaSet("@pet")
					end
					player["teamLayout"]:addChild(petSet[1])
				end

				-- self:createTeamLayout(player["teamLayout"],pets,5,true)
				player["btn"]:setListener(function ( ... )
					local benchPet = self:find(data.D.Pets,"Id",team.BenchPetId)
					if benchPet then
						table.insert(pets,benchPet)
					end
					self:send(netModel.getModelArenaTeamEquipmentInfo(team.Rid,team.TeamId),function ( data )
						print(data)
						local param = {}
						param.Team = team
						param.Pets = {unpack(pets)}
						param.Equips = data.D.Equipments
						param.Mibaos = data.D.Mibaos
						param.Gems = data.D.Gems
						param.Partners = data.D.Partners
						param.Lv = v.Lv
						param.Runes = data.D.Runes
						for _,v in ipairs(data.D.PartnerPets) do
							table.insert(param.Pets,v)
						end
						param.CloseFunc = function ( ... )
							require "framework.sync.TimerHelper".tick(function ( ... )
								GleeCore:showLayer("DArena",{ViewType = ViewType.Rank,NetData = self:getNetData()})
								return true
							end)
						end
						GleeCore:closeAllLayers()
						GleeCore:pushController("CTeam",param, nil, res.getTransitionFade())
					end)
				end)
				set["list"]:addListItem(player[1])
			end
		end)
	end
	self:showTop()
end

function DArena:showReportView( ... )
	local set  = self.views[ViewType.Report] 
	if not set then
		set = self:createLuaSet("@report")
		self.views[ViewType.Report] = set
		self._bg_contentBg:addChild(set[1])
		
	end
	if self.refreshTable[ViewType.Report] then
		self.refreshTable[ViewType.Report] = false
		self:send(netModel.getModelArenaReportsGet(),function ( data )
			print(data)
			return self:showReportDetail(set,data.D.Bfs)
		end)
	end
	self:showTop()
end

function DArena:showReportDetail( set,info )
	table.sort(info,function ( a,b )
		return a.T>b.T
	end)
	set["list"]:getContainer():removeAllChildrenWithCleanup(true)
	for _,v in ipairs(info) do
		local item = self:createLuaSet("@reportItem")
		local state--1:防守成功 2:防守失败 3:挑战成功 4:挑战失败
		local params = {}
		local selfRid = userFunc.getId()
		if v.DefRid == selfRid then
			state = v.WRid == v.DefRid and 1 or (v.No==0 and 5 or 2)
			table.insert(params,v.AtkName)
			if state == 2 then
				table.insert(params,-v.No)
			end
		else
			state = v.WRid == v.AtkRid and (v.No==0 and 6 or 3) or 4
			table.insert(params,v.DefName)
			if state == 3 then
				table.insert(params,v.No)
			end
			table.insert(params,v.Reward and v.Reward.Honor or 0)
		end
		local index = state
		index = index == 5 and 2 or index
		index = index == 6 and 3 or index
		item["bg_icon"]:setResid(string.format("N_JJC_wenzi%d.png",index))
		item["bg_content"]:setString(string.format(res.locString(string.format("CArena$reportFormat%d",state)),unpack(params)))

		local seconds = timeTool.getOffsetTimeToNow(math.floor(v.T/1000))
		item["bg_timeLabel"]:setString(res.getTimeText(seconds / 60))

		selectLang(nil,function (  )
			item["bg_replayBtn"]:setVisible(false)
		end,nil)

		require "LangAdapter".LabelNodeAutoShrink(item["bg_replayBtn_#label"],90)

		item["bg_replayBtn"]:setListener(function ( ... )
			self:send(netModel.getModelArenaReportGet(v.Id),function ( netData )--Data Field 
				local selfPetList,enemyPetList = self:getPetsInfo(netData.D.Data)
				local data = {}
				data.type = 'arena-record'
				data.data = {}
				data.data.petList = selfPetList
				data.data.enemyList = enemyPetList
				
				data.data.enemyName = params[1]
				
				----战报才有
				data.data.isChallenger = v.AtkRid == selfRid
				data.data.seed = v.Seed

				print("ArenaReportGet")
				print(netData)

				for i,v in ipairs(netData.D.Data.Teams) do
					if v.Rid == userFunc.getId() then
						if v.Rid == netData.D.Field.AtkRid then
							data.data.petBornIJList = teamFunc.getPosListAtkType(v)
						else
							data.data.petBornIJList = teamFunc.getPosListDefType(v)
						end
					else
						if v.Rid == netData.D.Field.AtkRid then
							data.data.enemyBornIJList = teamFunc.getPosListAtkType(v)
						else
							data.data.enemyBornIJList = teamFunc.getPosListDefType(v)
						end
					end
				end

				EventCenter.eventInput("BattleStart", data)
			end)
		end)
		set["list"]:addListItem(item[1])
	end
end

function DArena:getPetsInfo( info )
	local selfPetList,enemyPetList = {},{}
	for _,team in ipairs(info.Teams) do
		local target = team.Rid == userFunc.getId() and selfPetList or enemyPetList
		for _,pid in ipairs(team.PetIdList) do
			table.insert(target,petFunc.convertToDungeonData(self:find(info.Pets,"Id",pid)))
		end
		local benchPet = self:find(info.Pets,"Id",team.BenchPetId)
		if benchPet then
			table.insert(target,petFunc.convertToDungeonData(benchPet))
		end
	end
	return selfPetList,enemyPetList
end

function DArena:showExchangeView( )
	local set  = self.views[ViewType.Exchange] 
	if not set then
		set = self:createLuaSet("@exchange")
		self.views[ViewType.Exchange] = set
		self._bg_contentBg:addChild(set[1])
	end

	self:showTop()

	if self.refreshTable[ViewType.Exchange] then
		self.refreshTable[ViewType.Exchange] = false
		set["list"]:getContainer():removeAllChildrenWithCleanup(true)

		local lv = userFunc.getLevel()
		for _,v in ipairs(require "arena_material") do
			if not v.unlocklv or lv >= v.unlocklv then
				local count,desType
				if v.tcount and v.tcount>0 then
					local hasBuy = self.mArenaInfo.Eid and self.mArenaInfo.Eid[tostring(v.Id)]
					hasBuy = hasBuy or 0
					count = v.tcount - hasBuy
					desType = 1
				else
					local hasBuy
					local map = self.mArenaInfo.Did and self.mArenaInfo.Did[tostring(v.Id)]
					if map then
						hasBuy= map[self.mArenaInfo.Dk]
					end
					hasBuy = hasBuy or 0
					count = v.dcount - hasBuy
					desType = 2
				end

				if count>0 or desType == 2 then
					local reward = dbManager.getReward(v.rewardid)[1]
					local item = self:createLuaSet("@exchangeItem")
			
					item["bg_desLayout_label"]:setString(res.locString(string.format("CArena$exchangeCountTip%d",desType)))
					item["bg_desLayout_count"]:setString(count)
					if count<=0 then
						item["bg_desLayout_count"]:setFontFillColor(res.color4F.red,true)
					else
						item["bg_desLayout_count"]:setFontFillColor(res.color4F.green,true)
					end
					item["bg_honorNeed"]:setString(string.format(res.locString("CArena$HonorExchangeTip"),v.honor))
					local enough = self.mMyArenaInfo.Honor>=v.honor
					if not enough then
						item["bg_honorNeed"]:setFontFillColor(res.color4F.red,true)
					end
					item["bg_exchangeBtn"]:setEnabled(enough and count>0)
					local buyFunc
					if enough and count>0 then
						buyFunc = function ( ... )
							self:send(netModel.getModelArenaHornorExchange(v.Id),function ( data)
								print(data)
								require "MATHelper":Change(6, 0, v.Honor)
								self.mMyArenaInfo = data.D.Arena
								self.mArenaInfo.Did = data.D.Did
								self.mArenaInfo.Eid = data.D.Eid
								local appFunc = require "AppData"
								appFunc.updateResource(data.D.Resource)
								GleeCore:showLayer("DGetReward", data.D.Reward)
								self.refreshTable[ViewType.Exchange] = true
								return self:showExchangeView()
							end)
						end
						item["bg_exchangeBtn"]:setListener(function ( ... )
							local param = {}
							local des1 = string.format("[color=00ff00ff]%d[/color]%s",v.honor,res.locString("Global$ArenaHonor"))
							local des2 = item["bg_name"]:getString()
							param.content = string.format(res.locString("Global$ExchangeConfirmTip"),des1,des2)
							param.callback = function (  )
								return buyFunc()
							end
							GleeCore:showLayer("DConfirmNT",param)
						end)
					end

					if reward.itemtype == 6 or reward.itemtype == 10 then
						local pet = petFunc.getPetInfoByPetId(reward.itemid)
						res.setPetDetail(item["bg_icon"],pet,reward.itemtype == 10)
						local name = pet.Name
						if reward.itemtype == 10 then
							name = name..res.locString("Global$Fragment")
						end
						item["bg_name"]:setString(name)
						item["bg_iconBtn"]:setListener(function ( ... )
							GleeCore:showLayer("DPetDetailV",{PetInfo = pet})
						end)
					elseif reward.itemtype == 7 then
						local equip = equipFunc.getEquipInfoByEquipmentID(reward.itemid)
						res.setEquipDetail(item["bg_icon"],equip)
						item["bg_name"]:setString(equip.Name)
						item["bg_iconBtn"]:setListener(function ( ... )
							-- GleeCore:showLayer("DEquipInfoWithNoGem",{EquipInfo = equip})
							GleeCore:showLayer("DEquipDetail",{nEquip = equip})
						end)
					elseif reward.itemtype == 8 then
						local gem = gemFunc.getGemByGemID(reward.itemid)
						res.setGemDetail(item["bg_icon"],gem)
						item["bg_name"]:setString(gem.Name)
						item["bg_iconBtn"]:setListener(function ( ... )
							GleeCore:showLayer("DGemDetail",{GemInfo = gem,ShowOnly = true})
						end)
					elseif reward.itemtype == 9 then
						local material = require "BagInfo".getItemByMID(reward.itemid)
						res.setItemDetail(item["bg_icon"],material)
						local info = dbManager.getInfoMaterial(reward.itemid)
						item["bg_name"]:setString(info.name)
						item["bg_iconBtn"]:setListener(function ( ... )
							GleeCore:showLayer("DMaterialDetail",{materialId = reward.itemid})
						end)
					elseif reward.itemtype == 14 or reward.itemtype == 15 then
						local mb = dbManager.getInfoTreasure(reward.itemid)
						res.setNodeWithTreasure(item["bg_icon"],mb,reward.itemtype == 15)
						local name = require "Toolkit".getMibaoName(mb)
						if reward.itemtype == 15 then
							name = name..res.locString("Global$Fragment")
						end
						item["bg_name"]:setString(name)
						item["bg_iconBtn"]:setListener(function ( ... )
							-- GleeCore:showLayer("DPetDetailV",{PetInfo = pet})
						end)
					end
					if reward.amount>1 then
						item["bg_name"]:setString(string.format("%s x%d",item["bg_name"]:getString(),reward.amount))
					end

					set["list"]:addListItem(item[1])
				end
			end
		end
	end
end

function DArena:find( t,k,v )
	for _,vv in ipairs(t) do
		if vv[k] == v then
			return vv
		end
	end
	print("------------Find---------")
	print("key:"..k)
	print("value:"..v)
	print("table:")
	print(t)
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DArena, "DArena")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DArena", DArena)

EventCenter.addEventFunc(require 'FightEvent'.ArenaGameOver, function ( data )
	print("-----------OnArenaGameOverGet-------------")
	print(data)
	-- data.data.Seed = netData.D.Seed
	-- data.data.Reward = netData.D.Reward
	-- data.data.No = netData.D.No
	-- data.data.Resource = netData.D.Resource
	require "AppData".updateResource(data.D.Resource)
	hasNewRecord = data.D.GtTopNo
	-- self:send(netModel.getModelArenaInfo(),function ( netData )
	-- 	self.mArenaInfo = netData.D
	-- 	self.mMyArenaInfo = self:find(self.mArenaInfo.Arenas,"Rid",userFunc.getId())
	-- 	self.refreshTable[ViewType.Arena] = true
	-- 	self.refreshTable[ViewType.Report] = true
	-- 	return self:showArenaView()
	-- end)
end)


