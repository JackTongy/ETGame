--[[
	探索地图元素 (Elemnt)
	字段 					类型 					说明
	OrdeNo 				Int 						序号
	EId 					Int 						元素配置 id
	MId 					Int 						怪物配置 id
	MV 					Bool 					怪物可见
	Type 					Int 						元素类型
											+		1:随机奖励 
											-		2:Buf 商店
											+		3:神秘商人
											+		4:木桶
											+		5:金币 
											+		6:宝箱 
											-		7:战旗 
											+		8:利爪
											+		9:心 
											-		10:传送门 
											-		11:铁砧
											+		12:金砖
											+		13:怪物 
											+		14:空地 
											+		15:退出/返回
											+		16:答题
											-		17:TipNpc
											-		18:剧情Npc
											+		19:盗贼
											+		20:喵喵
											+		21:树
											+		22:石块
											+		23:冰块
											+		24:水坑
											+		25:草丛
											+		26:燃烧的岩石
											-		27:漩涡
											+		28:精灵蛋
											+		29:魔法方块
											+		30:疯狂的科学家
											+		31:水井
											+		32:灵魂之壶
											+		33:属性研究博士
											-		34:神兽降临
											+		35:规则石块
	Reward 				Reward 				地图元素对应奖励
	SId 					Int 						神秘空间配置 id
	Stae 					Byte 					状态：
													1：有迷雾且够不着
													2：有迷雾，够得着
													3：迷雾打开待操作
													4：已操作
													5：被怪物锁定
													6：战旗、利爪、心 消失掉
	PetId 					Int 						精灵配置 id 
]]

local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local netModel = require "netModel"
local gameFunc = require "AppData"
local EventCenter = require 'EventCenter'
local GuideHelper = require 'GuideHelper'
local musicHelper = require 'framework.helper.MusicHelper'

local userFunc = gameFunc.getUserInfo()

local wGridCount = 8
local hGridCount = 5
local girdCount = wGridCount * hGridCount
local largeNum = 999999
local catBattleId = 28
local buffRate = 0.1
local wellCoinList = {30, 300, 1000, 3000}

local CDungeon = class(LuaController)

function CDungeon:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."CDungeon.cocos.zip")
    return self._factory:createDocument("CDungeon.cocos")
end

--@@@@[[[[
function CDungeon:onInitXML()
	local set = self._set
    self._dungeonBg = set:getElfNode("dungeonBg")
    self._dungeonBg_bg1 = set:getLinearLayoutNode("dungeonBg_bg1")
    self._dungeonBg_bg2 = set:getLinearLayoutNode("dungeonBg_bg2")
    self._dungeonBg_bg3 = set:getLinearLayoutNode("dungeonBg_bg3")
    self._dungeonBg_bg4 = set:getLinearLayoutNode("dungeonBg_bg4")
    self._dungeonBg_bg5 = set:getLinearLayoutNode("dungeonBg_bg5")
    self._dungeonBg_bg6 = set:getLinearLayoutNode("dungeonBg_bg6")
    self._dungeonBg_bg7 = set:getLinearLayoutNode("dungeonBg_bg7")
    self._dungeonBg_bg8 = set:getLinearLayoutNode("dungeonBg_bg8")
    self._dungeonBg_bg9 = set:getLinearLayoutNode("dungeonBg_bg9")
    self._bg = set:getClipNode("bg")
    self._bg_floorlayouty = set:getLayoutNode("bg_floorlayouty")
    self._bg_layouty = set:getLayoutNode("bg_layouty")
    self._click = set:getClickNode("click")
    self._shadow = set:getElfNode("shadow")
    self._lucky = set:getElfNode("lucky")
    self._shadow = set:getElfNode("shadow")
    self._effect = set:getSimpleAnimateNode("effect")
    self._frame = set:getElfNode("frame")
    self._icon = set:getElfNode("icon")
    self._effect2 = set:getSimpleAnimateNode("effect2")
    self._icon = set:getElfNode("icon")
    self._effect1 = set:getSimpleAnimateNode("effect1")
    self._icon = set:getElfNode("icon")
    self._effect1 = set:getSimpleAnimateNode("effect1")
    self._effect2 = set:getSimpleAnimateNode("effect2")
    self._icon = set:getElfNode("icon")
    self._effect = set:getSimpleAnimateNode("effect")
    self._icon2 = set:getElfNode("icon2")
    self._icon = set:getElfNode("icon")
    self._effect1 = set:getSimpleAnimateNode("effect1")
    self._effect2 = set:getSimpleAnimateNode("effect2")
    self._icon2 = set:getElfNode("icon2")
    self._icon = set:getElfNode("icon")
    self._bg = set:getElfNode("bg")
    self._bg_timer = set:getTimeNode("bg_timer")
    self._bg_title = set:getElfNode("bg_title")
    self._icon = set:getElfNode("icon")
    self._icon_shadow = set:getElfNode("icon_shadow")
    self._icon_monsterFlag = set:getElfNode("icon_monsterFlag")
    self._icon_nameBg = set:getElfNode("icon_nameBg")
    self._icon_nameBg_name = set:getLabelNode("icon_nameBg_name")
    self._icon_star = set:getElfNode("icon_star")
    self._icon_star_st1 = set:getElfNode("icon_star_st1")
    self._icon_star_st3 = set:getElfNode("icon_star_st3")
    self._icon_star_st2 = set:getElfNode("icon_star_st2")
    self._gold = set:getElfNode("gold")
    self._amount = set:getLabelNode("amount")
    self._icon = set:getElfNode("icon")
    self._icon = set:getElfNode("icon")
    self._icon_shadow = set:getElfNode("icon_shadow")
    self._icon_monsterFlag = set:getElfNode("icon_monsterFlag")
    self._icon_nameBg = set:getElfNode("icon_nameBg")
    self._icon_nameBg_name = set:getLabelNode("icon_nameBg_name")
    self._icon = set:getElfNode("icon")
    self._icon_shadow = set:getElfNode("icon_shadow")
    self._icon_monsterFlag = set:getElfNode("icon_monsterFlag")
    self._icon_nameBg = set:getElfNode("icon_nameBg")
    self._icon_nameBg_name = set:getLabelNode("icon_nameBg_name")
    self._icon = set:getElfNode("icon")
    self._icon_shadow = set:getElfNode("icon_shadow")
    self._icon_monsterFlag = set:getElfNode("icon_monsterFlag")
    self._icon_nameBg = set:getElfNode("icon_nameBg")
    self._icon_nameBg_name = set:getLabelNode("icon_nameBg_name")
    self._icon2 = set:getElfNode("icon2")
    self._effect = set:getSimpleAnimateNode("effect")
    self._icon = set:getElfNode("icon")
    self._icon_shadow = set:getElfNode("icon_shadow")
    self._icon_monsterFlag = set:getElfNode("icon_monsterFlag")
    self._icon_nameBg = set:getElfNode("icon_nameBg")
    self._icon_nameBg_name = set:getLabelNode("icon_nameBg_name")
    self._icon2 = set:getElfNode("icon2")
    self._effect = set:getSimpleAnimateNode("effect")
    self._icon = set:getElfNode("icon")
    self._icon_shadow = set:getElfNode("icon_shadow")
    self._icon_monsterFlag = set:getElfNode("icon_monsterFlag")
    self._icon_nameBg = set:getElfNode("icon_nameBg")
    self._icon_nameBg_name = set:getLabelNode("icon_nameBg_name")
    self._icon2 = set:getElfNode("icon2")
    self._effect = set:getSimpleAnimateNode("effect")
    self._icon = set:getElfNode("icon")
    self._icon_shadow = set:getElfNode("icon_shadow")
    self._icon_monsterFlag = set:getElfNode("icon_monsterFlag")
    self._icon_nameBg = set:getElfNode("icon_nameBg")
    self._icon_nameBg_name = set:getLabelNode("icon_nameBg_name")
    self._icon2 = set:getElfNode("icon2")
    self._effect = set:getSimpleAnimateNode("effect")
    self._effect2 = set:getSimpleAnimateNode("effect2")
    self._icon = set:getElfNode("icon")
    self._icon_shadow = set:getElfNode("icon_shadow")
    self._icon_monsterFlag = set:getElfNode("icon_monsterFlag")
    self._icon_nameBg = set:getElfNode("icon_nameBg")
    self._icon_nameBg_name = set:getLabelNode("icon_nameBg_name")
    self._icon2 = set:getElfNode("icon2")
    self._effect = set:getSimpleAnimateNode("effect")
    self._icon = set:getElfNode("icon")
    self._icon_shadow = set:getElfNode("icon_shadow")
    self._icon_monsterFlag = set:getElfNode("icon_monsterFlag")
    self._icon_nameBg = set:getElfNode("icon_nameBg")
    self._icon_nameBg_name = set:getLabelNode("icon_nameBg_name")
    self._icon2 = set:getElfNode("icon2")
    self._effect = set:getSimpleAnimateNode("effect")
    self._icon = set:getElfNode("icon")
    self._icon = set:getElfNode("icon")
    self._icon = set:getElfNode("icon")
    self._icon = set:getElfNode("icon")
    self._icon_shadow = set:getElfNode("icon_shadow")
    self._icon_monsterFlag = set:getElfNode("icon_monsterFlag")
    self._icon_nameBg = set:getElfNode("icon_nameBg")
    self._icon_nameBg_name = set:getLabelNode("icon_nameBg_name")
    self._tree = set:getElfNode("tree")
    self._lock = set:getElfNode("lock")
    self._hale = set:getSimpleAnimateNode("hale")
    self._reward = set:getElfNode("reward")
    self._reward_shadow = set:getElfNode("reward_shadow")
    self._reward_icon = set:getElfNode("reward_icon")
    self._decoverAnime = set:getSimpleAnimateNode("decoverAnime")
    self._dungeonFrame = set:getElfNode("dungeonFrame")
    self._dungeonFrame_pic = set:getElfNode("dungeonFrame_pic")
    self._dungeonFrame_pic_frame1 = set:getLinearLayoutNode("dungeonFrame_pic_frame1")
    self._dungeonFrame_pic_frame2 = set:getLinearLayoutNode("dungeonFrame_pic_frame2")
    self._dungeonFrame_pic_frame3 = set:getLinearLayoutNode("dungeonFrame_pic_frame3")
    self._dungeonFrame_pic_frame4 = set:getLinearLayoutNode("dungeonFrame_pic_frame4")
    self._dungeonFrame_pic_frame5 = set:getLinearLayoutNode("dungeonFrame_pic_frame5")
    self._dungeonFrame_pic_frame6 = set:getLinearLayoutNode("dungeonFrame_pic_frame6")
    self._dungeonFrame_pic_frame7 = set:getLinearLayoutNode("dungeonFrame_pic_frame7")
    self._dungeonFrame_pic_frame8 = set:getLinearLayoutNode("dungeonFrame_pic_frame8")
    self._dungeonFrame_pic_frame9 = set:getLinearLayoutNode("dungeonFrame_pic_frame9")
    self._dungeonFrame_titleBg_title = set:getLabelNode("dungeonFrame_titleBg_title")
    self._shield = set:getShieldNode("shield")
    self._actHeartbeat = set:getElfAction("actHeartbeat")
    self._actCoinMove = set:getElfAction("actCoinMove")
    self._actCoinFadeInOut = set:getElfAction("actCoinFadeInOut")
--    self._@floorlayoutx = set:getLayoutNode("@floorlayoutx")
--    self._@floor = set:getElfNode("@floor")
--    self._@layoutx = set:getLayoutNode("@layoutx")
--    self._@item = set:getElfNode("@item")
--    self._@elem0 = set:getElfNode("@elem0")
--    self._@elem1 = set:getElfNode("@elem1")
--    self._@elem2 = set:getElfNode("@elem2")
--    self._@elem3 = set:getElfNode("@elem3")
--    self._@elem4 = set:getElfNode("@elem4")
--    self._@elem5 = set:getElfNode("@elem5")
--    self._@elem6 = set:getElfNode("@elem6")
--    self._@elem7 = set:getElfNode("@elem7")
--    self._@elem8 = set:getElfNode("@elem8")
--    self._@elem9 = set:getElfNode("@elem9")
--    self._@elem10 = set:getElfNode("@elem10")
--    self._@elem11 = set:getElfNode("@elem11")
--    self._@elem12 = set:getElfNode("@elem12")
--    self._@goldTouchAnim = set:getSimpleAnimateNode("@goldTouchAnim")
--    self._@goldGetAnime = set:getSimpleAnimateNode("@goldGetAnime")
--    self._@coinText = set:getLabelNode("@coinText")
--    self._@goldBreak1 = set:getSimpleAnimateNode("@goldBreak1")
--    self._@goldBreak2 = set:getSimpleAnimateNode("@goldBreak2")
--    self._@goldBreak3 = set:getSimpleAnimateNode("@goldBreak3")
--    self._@elem13 = set:getElfNode("@elem13")
--    self._@elem14 = set:getElfNode("@elem14")
--    self._@elem15 = set:getElfNode("@elem15")
--    self._@elem16 = set:getElfNode("@elem16")
--    self._@answerRight = set:getLinearLayoutNode("@answerRight")
--    self._@elem17 = set:getElfNode("@elem17")
--    self._@elem18 = set:getElfNode("@elem18")
--    self._@elem19 = set:getElfNode("@elem19")
--    self._@elem20 = set:getElfNode("@elem20")
--    self._@elem21 = set:getElfNode("@elem21")
--    self._@elem22 = set:getElfNode("@elem22")
--    self._@elem23 = set:getElfNode("@elem23")
--    self._@elem24 = set:getElfNode("@elem24")
--    self._@elem25 = set:getElfNode("@elem25")
--    self._@elem26 = set:getElfNode("@elem26")
--    self._@elem27 = set:getElfNode("@elem27")
--    self._@elem28 = set:getElfNode("@elem28")
--    self._@elem29 = set:getElfNode("@elem29")
--    self._@elem30 = set:getElfNode("@elem30")
--    self._@elem31 = set:getElfNode("@elem31")
--    self._@elem32 = set:getElfNode("@elem32")
--    self._@elem33 = set:getElfNode("@elem33")
--    self._@elem34 = set:getElfNode("@elem34")
--    self._@elem35 = set:getElfNode("@elem35")
--    self._@appearAnime = set:getSimpleAnimateNode("@appearAnime")
--    self._@goldEffect = set:getSimpleAnimateNode("@goldEffect")
end
--@@@@]]]]

--------------------------------override functions----------------------

function CDungeon:onInit( userData, netData )
	self.TownId = userData.TownId
	self.StageId = userData.StageId
	self.goldPadIsTappedList = {}
	if userData.Challenge then
		self.oldNotClear = userData.TownId == 1 and (not userData.Challenge.Clear)

		-- 根据服务端的时间数据决定是否重新随机泥土、数目的显示
		self:updateRandomTreeMap(userData.Challenge.DateAt) 
		self:updateChallengeData(userData.Challenge)
		self:updateBackgroundFrame()
		self:initFloorLayer()
		self:initCellNodeSet()
		self:updateCellNodeSet()
		self:broadcastEvent()

		musicHelper.playBackgroundMusic(res.Music.dungeon, true)
	end

	self._bg_layouty:layout()

	if self.isClear then
		self.animFinish = true
	end
	self.storyFinish = self.isClear or false

	local nTown = gameFunc.getTownInfo().getTownById(self.TownId)
	self.townAreadyClear = nTown and nTown.Clear or false

	self:setElementsTouchEnabled(true)

	require 'StoryManager'.checkDialogue({stageID = self.StageId, battleID = nil, condition = 1, passed = self.storyFinish})
end

function CDungeon:onEnter( ... )
	self:runWithDelay(function ( ... )
		for i,v in ipairs(self.itemSetList) do
			GuideHelper:registerPoint(string.format('block_%d', i), self.itemSetList[i]['click'])
		end

		if self._guideNode35 then
			GuideHelper:registerPoint('石碑',self._guideNode35)
		end
		if self._guideNode13 then
			GuideHelper:registerPoint('Boss',self._guideNode13)
		end
		if self._guideNode34 then
			GuideHelper:registerPoint('神兽',self._guideNode34)
		end
		GuideHelper:check('CDungeon')
	end)
end

function CDungeon:onBack( userData, netData )
	self.goldPadIsTappedList = {}
	self:updateCellNodeSet()
	musicHelper.playBackgroundMusic(res.Music.dungeon, true)
end

function CDungeon:onLeave( ... )
	GuideHelper:check('CDungeonOnLeave')
end
--------------------------------custom code-----------------------------

function CDungeon:onRelease(  )
	self._guideNode13 = nil
	self._guideNode35 = nil
	self._guideNode34 = nil
	EventCenter.resetGroup("CDungeon")
end

function CDungeon:broadcastEvent( ... )
	-- 战斗结算
	EventCenter.addEventFunc(require 'FightEvent'.Pve_FightResult, function ( data )
		print("战斗结算")
		print(data)
		if data and data.D then
			if data.D.Challenge then
				self:updateChallengeData(data.D.Challenge)
			end
			if data.D.Result then
				if data.D.Result.Resource then
					local oldlv = gameFunc.getUserInfo().getLevel()
					gameFunc.updateResource(data.D.Result.Resource)
					local newlv = gameFunc.getUserInfo().getLevel()
					require 'UnlockManager':userLv(oldlv,newlv)
				end
			end
			if data.D.Pets then
				gameFunc.getPetInfo().addPets(data.D.Pets)
			end
			if data.D.Towns then
				for k,v in pairs(data.D.Towns) do
					gameFunc.getTownInfo().setTown(v)
				end
			end
			if data.D.AreaId and data.D.AreaId > 0 then
				gameFunc.getTempInfo().setAreaId(data.D.AreaId)
			end
		end
	end, "CDungeon")

	EventCenter.addEventFunc("BattleStart", function ( data )
		self.battleId = data.data.battleId
		self.isStarBoss = data.type == "fuben_boss"
	end, "CDungeon")

	EventCenter.addEventFunc("OnBattleCompleted", function ( data )
		print("OnBattleCompleted")
		print(data)
		if not self.storyFinish and data.isWin then
			self:doFinishWithStory()
		end
		if self.isStarBoss and data and data.userData and data.userData.Result then
			require 'MATHelper'.StageBattle(self.StageId,data.userData.Result.stars)
		elseif self.isStarBoss and data and not data.isWin then
			require 'MATHelper'.StageBattle(self.StageId,0)
		end
	end, "CDungeon")

	EventCenter.addEventFunc(require 'FightEvent'.BattleThiefGameOver, function ( data )
		if data.isWin then
			self:challengeOperatorEvent(self.thiefOrderNo, 1)
		end
	end, "CDungeon")

	EventCenter.addEventFunc(require 'FightEvent'.FubenCatBattleEnd, function ( data )
		if data and data.Gold and data.Gold >= 0 then
			self:challengeOperatorEvent(self.catOrderNo, data.Gold)
		end
	end, "CDungeon")

	EventCenter.addEventFunc("UpdateDungeonCell", function ( ... )
		self.goldPadIsTappedList = {}
		self:updateCellNodeSet()
	end, "CDungeon")

	EventCenter.addEventFunc("UpdateDungeonChallenge", function ( data )
		self:updateChallengeData(data)
		for k,v in pairs(data.Elements) do
			self:updateCellNode(v.OrderNo, v)
		end
	end, "CDungeon")

	EventCenter.addEventFunc("GEventShowBossPos", function ( data )
		print("GEventShowBossPos")
		print(data)
		if data then
			self.isGuideBossPet = true
			local index = 0
			for k,v in pairs(self.ElementList) do
				if v.Type == 13 and v.State < 3 then
					index = v.OrderNo
					break
				end
			end
			if index ~= 0 then
				self:updateCellNode(index, self.ElementList[index])
				self.itemSetList[index]["tree"]:stopAllActions()
				self.itemSetList[index]["tree"]:runAction(res.getFadeAction(1))
				self:runWithDelay(function (  )
					self.isGuideBossPet = false
					self.itemSetList[index]["tree"]:stopAllActions()
					self.itemSetList[index]["tree"]:setOpacity(255)
					self:updateCellNode(index, self.ElementList[index])
				end, 3.0)
			end
		end
	end, "CDungeon")
end

function CDungeon:updateRandomTreeMap( dateAt )
	local Utils = require 'framework.helper.Utils'
	local pattern = "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)"
	local year, month, day, hour, minute, seconds = string.match(dateAt, pattern)
	local dateString = string.format("%d_%02d_%02d_%02d_%02d_%02d", year, month, day, hour, minute, seconds)
	local map = Utils.readTableFromFile('DungeonRandMap' .. dateString)
	if map and map.DateAt == dateAt then

	else
		map = {}
		map.TownId = self.TownId
		map.StageId = self.StageId
		map.DateAt = dateAt
		map.treeMap = {}
		map.earthMap = {}
		for i=1,wGridCount * hGridCount do
			table.insert(map.treeMap, math.random(100))
			table.insert(map.earthMap, math.random(100))
		end
		Utils.writeTableToFile(map, 'DungeonRandMap' .. dateString)
	end
	self.treeMap = map.treeMap
	self.earthMap = map.earthMap
end

function CDungeon:updateChallengeData( challenge )
	if (not self.townAreadyClear) and self.isClear ~= nil and self.isClear == false and challenge.Clear then 
		gameFunc.getTempInfo().setTownIsClear(true)
	end

	self.ChallengeId = challenge.Id
	self.WellStage = challenge.WellStage
	self.PotLeft = challenge.PotLeft
	self.PotType = challenge.PotType
	self.WellCoin = challenge.WellCoin
	self.DrProp = challenge.DrProp
	self.SRate = challenge.SRate
	-- self.Senior = challenge.Senior
	self.isClear = challenge.Clear or false

	self.ElementList = self.ElementList or {}
	for k,v in pairs(challenge.Elements) do
		local canFind = false
		for key,value in pairs(self.ElementList) do
			if value.OrderNo == v.OrderNo then
				self.ElementList[key] = v
				canFind = true
				break
			end
		end
		if not canFind then
			table.insert(self.ElementList, v)
		end
	end

	table.sort(self.ElementList, function ( a, b )
		if a.OrderNo < b.OrderNo then
			return true
		end
	end)
end

function CDungeon:initFloorLayer(  )
	local dbTownInfo = dbManager.getInfoTownConfig(self.TownId)
	if dbTownInfo then
		self.floorSetList = {}
		self._bg_floorlayouty:removeAllChildrenWithCleanup(true)
		for i=1,hGridCount do
			local floorLayoutxSet = self:createLuaSet("@floorlayoutx")
			self._bg_floorlayouty:addChild(floorLayoutxSet[1])
			for j=1,wGridCount do
				local floor = self:createLuaSet("@floor")
				floorLayoutxSet[1]:addChild(floor[1])
				table.insert(self.floorSetList, floor)
				floor[1]:setResid(self:getDungeonFloorPic(dbTownInfo.Terrain, self.earthMap[(i - 1) * wGridCount + j]))
			end
		end		
	end
end

function CDungeon:initCellNodeSet(  )
	self.itemSetList = {}
	self._bg_layouty:removeAllChildrenWithCleanup(true)
	for i=1,hGridCount do
		local layoutxSet = self:createLuaSet("@layoutx")
		self._bg_layouty:addChild(layoutxSet[1])
		for j=1,wGridCount do
			local item = self:createLuaSet("@item")
			layoutxSet[1]:addChild(item[1])
			
			local index = (i - 1) * wGridCount + j
			local nElement = self.ElementList[index]
			if nElement and nElement.Type == 35 then
				self._guideNode35 = item['click']
			elseif nElement and nElement.Type == 13 then
				local monsterInfo = dbManager.getInfoElementMonsterConfigWithMonsterId(nElement.MId)
				if monsterInfo and monsterInfo.IsBoss == 0 then
					self._guideNode13 = item['click']
				end
			elseif nElement and nElement.Type == 34 then
				self._guideNode34 = item['click']
			end

			table.insert(self.itemSetList, item)
			item["click"]:setTriggleSound("")
			item["click"]:setListener(function (  )
				self:playElementEffect( self.ElementList[index] )
				local status = self.ElementList[index].State
				if status == 2 then
					item["decoverAnime"]:setLoops(1)
					item["decoverAnime"]:start()
				--	self:send(netModel.getModelChallengeDiscover(self.ChallengeId, index), function ( data )
				--		print("ChallengeDiscover")
				--		if data and data.D and data.D.Elements then
				--			print(data.D.Elements)
							-- 木桶、宝箱、怪物...有入场动画1
							-- 利爪、战旗...有入场动画2
							local animList = {3, 4, 6, 13, 17, 19, 20, 30, 32, 33, 34}
							local animList2 = {7, 8, 16, 28}
							local typeIsInAnimList = function ( list, elemType )
								for k,v in pairs(list) do
									if v == elemType then
										return true
									end
								end
								return false
							end

							local actionKey = 0
							local elemType = self.ElementList[index].Type
							if elemType == 34 then
								actionKey = 3
							elseif elemType == 13 then
								local dbPet = dbManager.getCharactor(self.ElementList[index].PetId)
								if dbPet.star_level > 5 and not(self.ElementList[index].MId >= 10 and self.ElementList[index].MId < 10000) then
									actionKey = 3
								else
									actionKey = 1
								end
							elseif typeIsInAnimList(animList, elemType) then
								actionKey = 1
							elseif typeIsInAnimList(animList2, elemType) then
								actionKey = 2
							end

							local updateNoList = self:updateGridsStatusTogetherWith(index)
							if self.PotType > 0 and self.PotLeft > 0 then
								self.PotLeft = math.max(self.PotLeft - 1, 0)
								if self.PotLeft == 0 then
									local oldPotType = self.PotType
									self.PotType = -1
									for i,v in ipairs(self.ElementList) do
										if v.Type == 32 then
											self.ElementList[i].State = 4
											table.insert(updateNoList, i)
											self:toast(res.locString(string.format("Dungeon$SoulPotDisappear%d", oldPotType)))
											break
										end
									end
								end
							end

							for k,v in pairs(updateNoList) do
								self:updateCellNode(v, self.ElementList[v])
							end

							if actionKey == 1 or actionKey == 3 then
								self:playEffectInternal(res.Sound.dg_monster)

								item["tree"]:setVisible(false)
								self.elemSetList[index]["icon"]:setVisible(false)

								local appearAnime = self:createLuaSet("@appearAnime")
								self.elemSetList[index][1]:addChild(appearAnime[1])
								appearAnime[1]:setOrder(self.elemSetList[index]["icon"]:getOrder() - 1)
								appearAnime[1]:setLoops(largeNum)
								appearAnime[1]:setVisible(false)
								appearAnime[1]:setListener(function (  )
									appearAnime[1]:removeFromParentAndCleanup(true)
									GuideHelper:check('AnimtionEnd')
								end)
								appearAnime[1]:setFrameDelay(0.07)
								local actArray = CCArray:create()
								actArray:addObject(CCHide:create())
								actArray:addObject(CCFadeTo:create(0, 0))
								actArray:addObject(CCScaleTo:create(0, 1.5))
								actArray:addObject(CCShow:create())
								actArray:addObject(CCFadeIn:create(0.5))
								actArray:addObject(CCScaleTo:create(0, 1))

								if actionKey == 1 then
									self.elemSetList[index]["icon"]:runAction(CCSequence:create(actArray))
									appearAnime[1]:setLoops(1)
									appearAnime[1]:start()
								else
									actArray:addObject(CCCallFunc:create(function (  )
										self:setElementsTouchEnabled(true)
									end))
									actArray:retain()
									self:setElementsTouchEnabled(false)
									self:showAnimationBossPet(self.ElementList[index].PetId, function ( ... )
										self.elemSetList[index]["icon"]:runAction(CCSequence:create(actArray))
										actArray:release()
										appearAnime[1]:setLoops(1)
										appearAnime[1]:start()
									end)
								end
							elseif actionKey == 2 then
								local duration = 0.07
								local deltaAngle = 30
								local actArray = CCArray:create()
								actArray:addObject(CCHide:create())
								actArray:addObject(CCDelayTime:create(0.5))
								actArray:addObject(CCMoveBy:create(0, ccp(0, 5)))
								actArray:addObject(CCShow:create())
								actArray:addObject(CCMoveBy:create(duration, ccp(0, -5)))
								actArray:addObject(CCRotateBy:create(duration, deltaAngle))
								actArray:addObject(CCRotateBy:create(duration, -deltaAngle * 2))
								actArray:addObject(CCRotateBy:create(duration, deltaAngle * 2))
								actArray:addObject(CCRotateBy:create(duration, -deltaAngle * 2))
								actArray:addObject(CCRotateBy:create(duration, deltaAngle))
								if elemType == 28 then
									self.itemSetList[index]["reward_icon"]:runAction(CCSequence:create(actArray))
								else
									self.elemSetList[index][1]:runAction(CCSequence:create(actArray))
								end
							end

							if self.ElementList[index].Type == 9 then
								self:playEffectInternal(res.Sound.dg_heart)
							elseif self.ElementList[index].Type == 8 then
								self:playEffectInternal(res.Sound.dg_sword)
							end
				--		end
				--	end)
					self:sendBackground(netModel.getModelChallengeDiscover(self.ChallengeId, index), function ( data )
						if data and data.D then
							for k,v in pairs(data.D.Challenge.Elements) do
								if index == v.OrderNo then
									if v.Type == 29 then
										self.ElementList[index] = v
										self:updateCellNode(index, v)
										break
									end
								end
							end
							-- if data.D.Challenge.Senior ~= self.Senior then
							-- 	self.Senior = data.D.Challenge.Senior
							-- 	self:updateSeniorBoss()
							-- end			
						end
					end)
					GuideHelper:elementGuide(elemType)
					GuideHelper:check('Appear')
					if self:canDoGuide() then
						self:doGuide()
					end
				elseif status == 3 then
					self:elementEvent(index)
					if (not self.isClosing) and self:canDoGuide() then
						self:doGuide()
					end
				elseif status == 4 then
					if self.ElementList[index].Type == 8 then
						self:toast(string.format(res.locString("Dungeon$BuffAtk"), buffRate * 100))
					elseif self.ElementList[index].Type == 9 then
						self:toast(string.format(res.locString("Dungeon$BuffHp"), buffRate * 100))
					end
				elseif status == 1 then
					if self.ElementList[index].Type == 0 then
						self:toast(res.locString("Dungeon$AreaNotOpen"))
					end
				end
			end)
		end
		layoutxSet[1]:layout()
	end
end

function CDungeon:updateCellNodeSet(  )
	for i,v in ipairs(self.ElementList) do
		if i <= #self.itemSetList then
			self:updateCellNode(i, v)
		end
	end
end

function CDungeon:updateCellNode( index, data )
	local dbTownInfo = dbManager.getInfoTownConfig(self.TownId)
	if dbTownInfo then
		local nodeSet = self.itemSetList[index]
		local status = data.State
		nodeSet["click"]:setEnabled((status == 1 and data.Type == 0) or status == 2 or status == 3 or (status == 4 and (data.Type == 8 or data.Type == 9)))
		if data.Type ~= 0 then
			nodeSet["tree"]:setResid(self:getDungeonTreePic(dbTownInfo.Terrain, self.treeMap[index]))
		else
			nodeSet["tree"]:setResid("FB_noused.png")
		end
		
		nodeSet["tree"]:setVisible( (status == 1 or status == 2 or status == 5) and not(data.Type >= 21 and data.Type <= 27) )
		nodeSet["shadow"]:setVisible(nodeSet["tree"]:isVisible() or (data.Type == 12 and status == 3) ) -- 显示树木或者金砖
		nodeSet["hale"]:setVisible(data.Type == 29 and (status == 1 or status == 2 or status == 5))
		if status == 1 then
			nodeSet["tree"]:setColorf(0.6, 0.6, 0.6, 1)
			self.floorSetList[index][1]:setColorf(0.6, 0.6, 0.6, 1)
		else
			nodeSet["tree"]:setColorf(1, 1, 1, 1)
			self.floorSetList[index][1]:setColorf(1, 1, 1, 1)
		end
	
		nodeSet["lock"]:setVisible(status == 5)
		local rewardVisible = status == 3 and data.Reward and data.Type ~= 3 and data.Type ~= 31 and data.Type ~= 32 and data.Type ~= 33
		nodeSet["reward"]:setVisible(rewardVisible)
		if rewardVisible then
			nodeSet["reward_shadow"]:setVisible(data.Reward and data.Reward.Gold == 0 and data.Type ~= 4 and data.Type ~= 6 and data.Type ~= 28)
			self:updateReward(nodeSet["reward_icon"], data.Reward)
		end
		self:updateLucky(index, data)
	end
end

function CDungeon:updateLucky( index, data )
	local nodeSet = self.itemSetList[index]
	nodeSet["lucky"]:removeAllChildrenWithCleanup(true)
	local elemSet = self:createLuaSet(string.format("@elem%d", data.Type))
	nodeSet["lucky"]:addChild(elemSet[1])
	elemSet[1]:setPosition(ccp(0, 0))
	self.elemSetList = self.elemSetList or {}
	self.elemSetList[index] = elemSet

	if data.Type == 0 then

	elseif data.Type == 1 then
		if data.State == 3 and not data.Reward then
			elemSet["effect"]:clearResidArray()
			local randomRewardList = dbManager.getInfoRandomRewardConfig(self.TownId)
			for i,v in ipairs(randomRewardList) do
				if v.IsGold and v.IsGold > 0 then
					elemSet["effect"]:addResidToArray("TY_jinbi_da.png")
				end
				if v.MaterialId and v.MaterialId > 0 then
					elemSet["effect"]:addResidToArray(res.getMaterialIcon(v.MaterialId))
				end
			end
			elemSet["effect"]:setLoops(999999999)
			elemSet["effect"]:setFrameDelay(0.2)
			elemSet["effect"]:start()
		end
		elemSet[1]:setVisible(data.State == 3 and not data.Reward)
	elseif data.Type == 2 then

	elseif data.Type == 3 then
		elemSet[1]:setVisible(data.State == 3)
	elseif data.Type == 4 then
		if data.State == 3 then
			if data.Reward then
				elemSet["icon"]:setResid("FB_DXC_poguanzi.png")
			else
				elemSet["icon"]:setResid("FB_DXC_guanzi.png")
			end
		elseif data.State == 4 then
			elemSet["icon"]:setResid("FB_DXC_poguanzi.png")
		end
		elemSet["effect1"]:stop()
		elemSet["effect2"]:stop()	
	elseif data.Type == 5 then
	elseif data.Type == 6 then
		if data.State == 3 then
			if data.Reward then
				elemSet["icon"]:setResid("FB_DXC_baoxiang.png")
			else
				elemSet["icon"]:setResid("FB_DXC_baoxiang2.png")
			end
			elemSet["effect1"]:start()
		elseif data.State == 4 then
			elemSet["icon"]:setResid("FB_DXC_baoxiang.png")
			elemSet["effect1"]:stop()
			elemSet["effect2"]:stop()
		end
	elseif data.Type == 7 then
		elemSet[1]:setPosition(ccp(0, -30))
		if data.State == 3 then
			elemSet["icon"]:setResid("FB_DXC_qi2.png")
			elemSet["icon"]:setVisible(true)
			elemSet["effect"]:clearResidArray()
			for i=0,55 do
				elemSet["effect"]:addResidToArray(string.format("hongxian_%05d.png", i))
			end
			elemSet["effect"]:start()
		elseif data.State == 4 then
			elemSet["icon"]:setResid("FB_DXC_qi1.png")
			elemSet["icon"]:setVisible(true)
			elemSet["effect"]:clearResidArray()
			for i=0,55 do
				elemSet["effect"]:addResidToArray(string.format("lanxian_%05d.png", i))
			end
			elemSet["effect"]:start()
		else
			elemSet["icon"]:setVisible(false)
			elemSet["effect"]:stop()
		end
	elseif data.Type == 8 then
		elemSet[1]:setVisible(data.State == 3 or data.State == 4)
		elemSet["icon2"]:setVisible(data.State == 4)
		if data.State == 3 then
			elemSet["icon"]:setResid("FB_DXC_jian.png")
			elemSet["icon"]:setVisible(true)
			elemSet["effect"]:clearResidArray()
			for i=1,55,2 do
				elemSet["effect"]:addResidToArray(string.format("hongxian_%05d.png", i))
			end
			elemSet["effect"]:start()
		elseif data.State == 4 then
			elemSet["icon"]:setResid("FB_DXC_jian2.png")
			elemSet["icon"]:setVisible(true)
			elemSet["effect"]:clearResidArray()
			for i=1,55, 2 do
				elemSet["effect"]:addResidToArray(string.format("lanxian_%05d.png", i))
			end
			elemSet["effect"]:start()
		else
			elemSet["icon"]:setVisible(false)
			elemSet["effect"]:setVisible(false)
			elemSet["effect"]:stop()
		end
	elseif data.Type == 9 then
		elemSet[1]:setVisible(data.State == 3 or data.State == 4)
		elemSet["icon"]:stopAllActions()
		elemSet["icon2"]:setVisible(data.State == 4)
		if data.State == 3 or data.State == 4 then
			elemSet["icon"]:runAction(self._actHeartbeat:clone())
			if data.State == 4 then
				elemSet["effect1"]:stop()
				elemSet["effect2"]:start()
			end
		end
	elseif data.Type == 10 then

	elseif data.Type == 11 then

	elseif data.Type == 12 then
		elemSet[1]:setVisible(data.State == 3)
	elseif data.Type == 13 or data.Type == 19 or data.Type == 20 or data.Type == 34 then
		if (data.State == 3 and not data.Reward) or self.isGuideBossPet then
			if data.PetId > 0 then
				local monsterNode = self:getNpcUIModel(data.PetId)
				elemSet["icon"]:addChild(monsterNode)
				monsterNode:setOrder(elemSet["icon_shadow"]:getOrder() + 10)

				local dbPet = dbManager.getCharactor(data.PetId)
				elemSet["icon_nameBg_name"]:setString(dbPet.name)
				elemSet["icon_nameBg"]:setOrder(elemSet["icon_shadow"]:getOrder() + 30)

				if data.Type == 13 then
					local monsterInfo = dbManager.getInfoElementMonsterConfigWithMonsterId(data.MId)
					local nTown =	gameFunc.getTownInfo().getTownById(self.TownId)
					elemSet["icon_star"]:setVisible(false and nTown and monsterInfo and monsterInfo.IsBoss > 0) -- 第一个false强制屏蔽星星
					elemSet["icon_star"]:setOrder(elemSet["icon_shadow"]:getOrder() + 60)
					if elemSet["icon_star"]:isVisible() then
						for i=1,3 do
							elemSet[string.format("icon_star_st%d", i)]:setResid(i <= nTown.Stars and "SX_xingxing1.png" or "SX_xingxing2.png")
						end
					end

					if dbPet.star_level > 5 and not(data.MId >= 10 and data.MId < 10000) then
						elemSet["icon_monsterFlag"]:setResid("FB_DXC_shenshou.png")
					else
						if monsterInfo then
							if monsterInfo.IsBoss > 0 then
								elemSet["icon_monsterFlag"]:setResid("FB_DXC_boss.png")
								-- if self.Senior then
								-- 	elemSet["icon_nameBg_name"]:setString(res.locString("InstanceDungeon$BossPetLeftTrim") .. dbPet.name)
								-- end
							else
								if monsterInfo.Type >= 7 and monsterInfo.Type <= 9 then
									elemSet["icon_monsterFlag"]:setResid("FB_DXC_jinbiguai.png")
								elseif monsterInfo.Type >= 10 and monsterInfo.Type <= 12 then
									elemSet["icon_monsterFlag"]:setResid("FB_DXC_jingyanguai.png")
								else
									elemSet["icon_monsterFlag"]:setResid("")
								end
							end
						end						
					end
				elseif data.Type == 34 then
					elemSet["icon_monsterFlag"]:setResid("FB_DXC_shenshou.png")
				else
					elemSet["icon_monsterFlag"]:setResid("FB_DXC_jinbiguai.png")
				end
				elemSet["icon_monsterFlag"]:setOrder(elemSet["icon_shadow"]:getOrder() + 20)
			end
			elemSet["icon"]:setVisible(true)
		else
			elemSet["icon"]:setVisible(false)
		end
	elseif data.Type == 14 then

	elseif data.Type == 15 then

	elseif data.Type == 16 then
		elemSet[1]:setVisible(data.State == 3)
	elseif data.Type == 17 then
		elemSet[1]:setVisible(data.State == 3)
	elseif data.Type == 18 then
	elseif data.Type >= 21 and data.Type <= 27 then
		if data.Reward then
			elemSet[1]:setVisible(false)
		else
			elemSet[1]:setVisible(true)
			if data.PetId < 0 then
				elemSet["icon"]:setVisible(false)
				if data.Type == 24 then
					if data.State == 1 then
						elemSet["icon2"]:setColorf(0.35, 0.35, 0.35, 1)
						elemSet["icon2"]:setVisible(true)
						elemSet["effect2"]:setVisible(false)
						elemSet["effect"]:setVisible(false)
						elemSet[1]:setVisible(true)
					elseif data.State == 3 or data.State == 5 then
						elemSet["icon"]:setVisible(false)
						elemSet["effect2"]:setVisible(true)
						elemSet["effect"]:setVisible(false)
						elemSet[1]:setVisible(true)
					else
						elemSet[1]:setVisible(false)
					end
				else
					if data.State == 1 then
						elemSet["icon2"]:setColorf(0.35, 0.35, 0.35, 1)
						elemSet["effect"]:setVisible(false)
						elemSet[1]:setVisible(true)
					elseif data.State == 3 or data.State == 5 then
						elemSet["icon2"]:setColorf(1, 1, 1, 1)
						elemSet["effect"]:setVisible(false)
						elemSet[1]:setVisible(true)
					else
						elemSet[1]:setVisible(false)
					end
				end
			else
				if data.State == 3 then
					local monsterNode = self:getNpcUIModel(data.PetId)
					elemSet["icon"]:addChild(monsterNode)
					monsterNode:setOrder(elemSet["icon_shadow"]:getOrder() + 10)

					local dbPet = dbManager.getCharactor(data.PetId)
					elemSet["icon_nameBg_name"]:setString(dbPet.name)
					elemSet["icon_nameBg"]:setOrder(elemSet["icon_shadow"]:getOrder() + 30)

					elemSet["icon_monsterFlag"]:setResid(self:getSpecialPetIconWithType(data.Type))
					elemSet["icon_monsterFlag"]:setOrder(elemSet["icon_shadow"]:getOrder() + 20)
					elemSet["icon"]:setVisible(true)
				elseif data.State == 4 then
					elemSet["icon"]:setVisible(false)
				end

				elemSet["icon2"]:setVisible(false)
				elemSet["effect"]:setVisible(false)
				if data.Type == 24 then
					elemSet["effect2"]:setVisible(false)
				end
			end
		end
	elseif data.Type == 28 then
	elseif data.Type == 29 then
	elseif data.Type == 30 then
		if data.State == 3 then
			elemSet["icon"]:setResid("FB_kexuejia.png")
		else
			elemSet["icon"]:setResid("")
		end
	elseif data.Type == 31 then
		elemSet[1]:setVisible(data.State == 3 and self.WellStage >= 0 and self.WellStage < #wellCoinList)
	elseif data.Type == 32 then
		if data.State == 3 then
			if self.PotType == 1 then
				elemSet["icon"]:setResid("FB_fashi1.png")
			elseif self.PotType == 2 then
				elemSet["icon"]:setResid("FB_fashi2.png")
			else
				elemSet["icon"]:setResid("")
			end
		end
		elemSet[1]:setVisible(data.State == 3)
	elseif data.Type == 33 then
		elemSet[1]:setVisible(data.State == 3)
	elseif data.Type == 34 then
	elseif data.Type == 35 then
		elemSet[1]:setVisible(data.State == 3)
	end
end

function CDungeon:elementEvent( index )
	local nElement = self.ElementList[index]
	if nElement.Type == 1 then
		local randomRewardList = dbManager.getInfoRandomRewardConfig(self.TownId)
		if randomRewardList and #randomRewardList > 0 then
			if nElement.Reward then
				self:rewardEvent(index)
			else
				self:challengeOperatorEvent(index, self:getRandomRewardId(randomRewardList))
			end
		end
	elseif nElement.Type == 3 then
		GleeCore:showLayer("DMall", {dungeonRewardList = nElement.Goods, callback = function ( selectIndex )
			self:challengeOperatorEvent(index, selectIndex)
		end})
	elseif nElement.Type == 4 or nElement.Type == 6 or nElement.Type == 29 then
		if nElement.Reward then
			self:rewardEvent(index)
		else
			self:challengeOperatorEvent(index)
		end
	elseif nElement.Type == 5 then
	--	self:setElementsTouchEnabled(false)
		-- self.elemSetList[index]["effect"]:stop()
		-- self.elemSetList[index]["effect"]:setVisible(false)
	--	self:runActionGold(self.elemSetList[index][1], index)
		if nElement.Reward then
			self:rewardEvent(index)
		end
	elseif nElement.Type == 9 then
	--	self:setElementsTouchEnabled(false)
		self.elemSetList[index]["effect1"]:setLoops(1)
		self.elemSetList[index]["effect1"]:start()
		self.elemSetList[index]["effect1"]:setListener(function (  )
			self:challengeOperatorEvent(index)
		end)
	elseif nElement.Type == 12 then
		local base = math.ceil(userFunc.getLevel() / 20) + 2
		if self.goldPadIsTappedList[nElement.OrderNo] then
		 	self.goldPadIsTappedList[nElement.OrderNo] = self.goldPadIsTappedList[nElement.OrderNo] + 1
		else
			require 'GuideHelper':recordGuideStepDes('点击金砖')
			table.insert(self.goldPadIsTappedList, nElement.OrderNo, 1)
			self.countNode = CCLabelAtlas:create("", "bmfont/x_hit_number.png", 31, 38, 48) -- ASCII '\0' 的十进制表示是48
			self.elemSetList[index]["bg_title"]:addChild(self.countNode)
			self.countNode:setAnchorPoint(ccp(1, 0))

			local goldBreak3 = self:createLuaSet("@goldBreak3")
			self.elemSetList[index]["icon"]:addChild(goldBreak3[1])
			goldBreak3[1]:setVisible(false)
			goldBreak3[1]:setListener(function (  )
				goldBreak3[1]:removeFromParentAndCleanup(true)
				self.elemSetList[index][1]:removeAllChildrenWithCleanup(true)
			end)
					
			local goldBreak2 = self:createLuaSet("@goldBreak2")
			self.elemSetList[index]["icon"]:addChild(goldBreak2[1])
			goldBreak2[1]:setVisible(false)
			goldBreak2[1]:setListener(function (  )
				goldBreak2[1]:removeFromParentAndCleanup(true)
				goldBreak3[1]:setVisible(true)
				goldBreak3[1]:setLoops(1)	
				goldBreak3[1]:start()	
			end)

			local goldBreak1 = self:createLuaSet("@goldBreak1")
			self.elemSetList[index]["icon"]:addChild(goldBreak1[1])
			goldBreak1[1]:setVisible(false)
			goldBreak1[1]:setListener(function (  )
				goldBreak1[1]:removeFromParentAndCleanup(true)
				goldBreak2[1]:setVisible(true)
				goldBreak2[1]:setLoops(1)
				goldBreak2[1]:start()	
			end)

			self:runWithDelay(function (  )
				self.elemSetList[index]["icon"]:setResid("")
				goldBreak1[1]:setVisible(true)
				goldBreak1[1]:setLoops(1)
				goldBreak1[1]:start()
			end, 0.8)

			local date = self.elemSetList[index]["bg_timer"]:getElfDate()
			date:setHourMinuteSecond(0, 0, 5)
			self.elemSetList[index]["bg_timer"]:addListener(function (  )
				self.elemSetList[index]["bg_timer"]:setUpdateRate(0)
				self.elemSetList[index]["bg_timer"]:setVisible(false)
				self.elemSetList[index]["bg"]:setVisible(false)	
				self.countNode:removeFromParentAndCleanup(true)

				local sum = 0
				for i=1,self.goldPadIsTappedList[nElement.OrderNo] do
					sum = sum + i * base
				end
				sum = math.min(sum, 22680)

				if not self.isClosing then
					self:challengeOperatorEvent(index, sum)
				end
			end)
			self.elemSetList[index]["bg"]:setVisible(true)
		end
		self.countNode:setString(tostring(self.goldPadIsTappedList[nElement.OrderNo]))

		local curGold = base * self.goldPadIsTappedList[nElement.OrderNo]

		-- action
		self.elemSetList[index]["icon"]:stopAllActions()
		self.elemSetList[index]["icon"]:runAction(self._actCoinMove:clone())

		local goldTouchAnim = self:createLuaSet("@goldTouchAnim")
		self.elemSetList[index]["icon"]:addChild(goldTouchAnim[1])
		goldTouchAnim[1]:setLoops(1)
		goldTouchAnim[1]:setListener(function (  )
			goldTouchAnim[1]:removeFromParentAndCleanup(true)
		end)
		goldTouchAnim[1]:start()

		local goldGetAnime = self:createLuaSet("@goldGetAnime")
		self.elemSetList[index]["icon"]:addChild(goldGetAnime[1])
		goldGetAnime[1]:setLoops(1)
		goldGetAnime[1]:setListener(function (  )
			goldGetAnime[1]:removeFromParentAndCleanup(true)
		end)
		goldGetAnime[1]:start()

		local coinText = self:createLuaSet("@coinText")
		self.elemSetList[index]["icon"]:addChild(coinText[1])
		coinText[1]:setString(string.format("+%d", curGold))
		coinText[1]:runAction(self._actCoinFadeInOut:clone())

		-- music effect
		self:playEffectInternal(res.Sound.dg_coin)
	elseif nElement.Type == 13 then
		if nElement.Reward then
			self:rewardEvent(index)
		else
			local monsterInfo = dbManager.getInfoElementMonsterConfigWithMonsterId(nElement.MId)
			local nTown =	gameFunc.getTownInfo().getTownById(self.TownId)
			local isBoss = monsterInfo and monsterInfo.IsBoss > 0
			if nTown and nTown.Clear and nTown.Stars > 0 and not (monsterInfo and monsterInfo.IsBoss > 0) then
				self:challengeFastEvent(nElement.OrderNo)
			else
				self:prepareForBattle(index, "fuben", nil, isBoss)
			end
		end
	elseif nElement.Type == 15 then
		if GuideHelper:inGuide('GCfg') and (not self.isClear) then
			self:toast(res.locString("Dungeon$GuideTip1"))
			return
		end

		self.elemSetList[index][1]:setResid("FB_DXC_louti_open.jpg")

		local lastDTownData = gameFunc.getTempInfo().getValueForKey("LastDTownData")
		lastDTownData.hideTransitionAnim = true

		local function exitTown( ... )
			self.isClosing = true
			GleeCore:popController(nil, res.getTransitionFade())
			self:runWithDelay(function (  )
				GleeCore:showLayer("DTown", lastDTownData)
			end, res.getTransitionFadeDelta() / 2)
		end

		if GuideHelper:isGuideDone() then
			if self:wellIsExit() then
				local param = {}
				param.content = res.locString("Dungeon$WellRechargeTip")
				param.RightBtnText = res.locString("Global$BtnRecharge")
				param.LeftBtnText = res.locString("Global$Exit")
				param.callback = function ( ... )
					GleeCore:showLayer("DRecharge")
				end
				param.cancelCallback = function ( ... )
					exitTown()
				end
				param.clickClose = true
				GleeCore:showLayer("DConfirmNT", param)	
			elseif self:showFinishTip() then
				local param = {}
				param.title = res.locString("Dungeon$FinishTitle")
				param.content = res.locString("Dungeon$FinishDes")
				param.callback = function ( ... )
					exitTown()
				end
				GleeCore:showLayer("DConfirmNT", param)
			else
				exitTown()
			end
		else
			exitTown()
		end
	elseif nElement.Type == 16 then
		require 'GuideHelper':recordGuideStepDes('点击进入答题')
		
		local questionList = dbManager.getElementQuestionList()
		if questionList then
			local cell
			for i,v in ipairs(questionList) do
				if v.id == nElement.MId then
					cell = v
					break
				end
			end
			if cell then
				local param = {}
				param.question = cell.question
				param.answerdata = cell.answerdata
				param.answer = cell.answer
				param.callback = function ( isRight )
					self.answerList = self.answerList or {}
					self.answerList[nElement.OrderNo] = isRight or false
					self:challengeOperatorEvent(index, isRight and 1 or 0)
				end
				GleeCore:showLayer("DDungeonAnswerQuestion", param)
			end
		end
	elseif nElement.Type == 17 then
		GleeCore:showLayer("DTipNpc", {text = self:getTipNpcText()})
	elseif nElement.Type == 18 then
	elseif nElement.Type == 19 then
		self.thiefOrderNo = index
		self:prepareForBattle(index, "fuben_thief", math.ceil(userFunc.getLevel() / 5) + catBattleId)
	elseif nElement.Type == 20 then
		self.catOrderNo = index
		self:prepareForBattle(index, "fuben_cat", catBattleId)
	elseif nElement.Type >= 21 and nElement.Type <= 27 then
		if nElement.Reward then
			self:rewardEvent(index)
		else
			if nElement.PetId > 0 then
				self:prepareForBattle(index, "fuben", nil)
			else
				if self:canBattleWithPetType(nElement.Type) then
					self:setElementsTouchEnabled(false)
					--self.itemSetList[index]["click"]:setEnabled(false)
					if nElement.Type == 24 then
						self.elemSetList[index]["effect2"]:stop()
						self.elemSetList[index]["effect2"]:setVisible(false)
					end
					self.elemSetList[index]["icon2"]:setVisible(false)
					self.elemSetList[index]["effect"]:setLoops(1)
					self.elemSetList[index]["effect"]:setVisible(true)
					self.elemSetList[index]["effect"]:start()
					self.elemSetList[index]["effect"]:setListener(function (  )
						self.elemSetList[index]["effect"]:setVisible(false)
						self:setElementsTouchEnabled(true)
						--self.itemSetList[index]["click"]:setEnabled(true)
						self:challengeOperatorEvent(index)
					end)
				else
					self:toast(res.locString(string.format("Dungeon$RarePet%d", nElement.Type)))
				end				
			end
		end
	elseif nElement.Type == 28 then
	--	self:setElementsTouchEnabled(false)
		-- local point0 = NodeHelper:getPositionInScreen(self._ftpos2_getBg_materialCount)
		-- local point = NodeHelper:getPositionInScreen(self.elemSetList[index][1])
		-- self.elemSetList[index][1]:runAction(self:getMoveAction( self.elemSetList[index][1]:getWidth(), point0.x - point.x, point0.y - point.y, function (  )
		-- 	self:challengeOperatorEvent(index)
		-- end ))
		self:challengeOperatorEvent(index)
	elseif nElement.Type == 30 then
		self:challengeOperatorEvent(index)
		-- local param = {}
		-- param.callback = function ( data )
		-- 	self:challengeOperatorEvent(index, data)
		-- end
		-- GleeCore:showLayer("DDungeonDoctor", param)
	elseif nElement.Type == 31 then
		if self.WellStage >=0 and self.WellStage < #wellCoinList then
			local param = {}
			param.content = string.format(res.locString("Dungeon$WellContent"), wellCoinList[self.WellStage + 1])
			param.callback = function ( ... )
				if userFunc.getCoin() >= wellCoinList[self.WellStage + 1] then
					self:challengeOperatorEvent(index)
				else
					require "Toolkit".showDialogOnCoinNotEnough()
				end
			end
			GleeCore:showLayer("DWell", param)
		end
	elseif nElement.Type == 32 then
		if self.PotType == 1 or self.PotType == 2 then
			local param = {}
			param.PotType = self.PotType
			if self.PotLeft < 0 then
				self.PotLeft = 10
				self:challengeOperatorEvent(index)
			end
			param.PotLeft = self.PotLeft
			param.soul = nElement.Reward and nElement.Reward.Soul or 0
			param.callback = function ( ... )
				self:challengeOperatorEvent(index)
			end
			GleeCore:showLayer("DSoulPot", param)
		end
	elseif nElement.Type == 33 then
		if self.DrProp == 0 then
			self:challengeOperatorEvent(index)
		else
			local param = {}
			param.content = res.locString("Dungeon$DoctorRewardTip")
			param.RightBtnText = res.locString("Global$Receive")
			param.rightBtnEnable = nElement.Reward and nElement.Reward.Soul and nElement.Reward.Soul > 0 or false
			param.callback = function ( ... )
				self:challengeOperatorEvent(index)
			end
			GleeCore:showLayer("DConfirmNT", param)
		end
	elseif nElement.Type == 34 then
		self:challengeOperatorEvent(index)
	elseif nElement.Type == 35 then
		GleeCore:showLayer("DDungeonRuleGuide", {petClearList = self:getPetClearList()})
	else
		self:challengeOperatorEvent(index)
	end
end

function CDungeon:prepareForBattle( index, battleType, battleId, isBoss )
	local para = {}
	para.type = battleType
	para.ChallengeId = self.ChallengeId
	para.OrderNo = index
	para.battleBuffer = self:getBattleBuffer()
	para.battleId = battleId
	para.bossId = self.ElementList[index].PetId
	para.soulType = self.PotType
	para.terrian = dbManager.getInfoTownConfig(self.TownId).Terrain
	para.isStarBoss = isBoss
	GleeCore:showLayer("DPrepareForStageBattle", para)
end

function CDungeon:updateReward( node, reward )
	node:removeAllChildrenWithCleanup(true)
	if reward.Gold and reward.Gold > 0 then
		local goldEffectSet = self:createLuaSet("@goldEffect")
		node:addChild(goldEffectSet[1])
		goldEffectSet[1]:start()
	elseif reward.MyEgg then
		node:setResid("FB_jinglingdan.png")
	else
		if reward.Coin and reward.Coin > 0 then
			res.setNodeWithCoin(node)
		end
		if reward.Soul and reward.Soul > 0 then
			res.setNodeWithSoul(node)
		end
		if reward.Equipments and #reward.Equipments > 0 and reward.Equipments[1].EquipmentId then
			local dbEquip = dbManager.getInfoEquipment(reward.Equipments[1].EquipmentId)
			if dbEquip then
				res.setNodeWithEquip(node, dbEquip)
			end
		end
		if reward.Gems and #reward.Gems > 0 then
			res.setNodeWithGem(node, reward.Gems[1].GemId, reward.Gems[1].Lv)
		end
		if reward.Materials and #reward.Materials > 0 and reward.Materials[1].MaterialId then
			local dbMaterial = dbManager.getInfoMaterial(reward.Materials[1].MaterialId)
			if dbMaterial then
				res.setNodeWithMaterial(node, dbMaterial)
			end
		end
		node:setScale(78 / 155)
		node:setPosition(ccp(0, 18.571442))
	end
	self:runWithDelay(function ( ... )
		GuideHelper:check('AnimtionEnd')
	end,1)
	
end

function CDungeon:challengeOperatorEvent( orderNo, para )
	self:send(netModel.getModelChallengeOperate(self.ChallengeId, orderNo, para), function ( data )
		print("ChallengeOperate:")
		print(data)
		if data and data.D and data.D.Resource then
			gameFunc.updateResource(data.D.Resource)
		end

		local needDoGuide = true
		if data and data.D and data.D.Challenge then
			local oldRewardIsNil = self.ElementList[orderNo].Reward == nil
			local oldDrProp = self.DrProp
		--	local oldSenior = self.Senior
			local nElement = data.D.Challenge.Elements[1]

			self:updateChallengeData(data.D.Challenge)
			for k,v in pairs(data.D.Challenge.Elements) do
				self:updateCellNode(v.OrderNo, v)
			end

			-- if data.D.Challenge.Senior ~= oldSenior then
			-- 	self:updateSeniorBoss()
			-- end	

			if nElement.State == 3 then
				if nElement.Type == 3 then 
					self:showSecretBusinessman(nElement.Reward, orderNo)
				elseif nElement.Type == 4 or nElement.Type == 6 then
					if nElement.Reward and oldRewardIsNil then
						if nElement.Type == 4 then
							self.elemSetList[orderNo]["effect1"]:setLoops(1)
							self.elemSetList[orderNo]["effect1"]:start()
							self.elemSetList[orderNo]["effect2"]:setLoops(1)
							self.elemSetList[orderNo]["effect2"]:start()
							self:playEffectInternal(res.Sound.dg_pot)
						elseif nElement.Type == 6 then
							self.elemSetList[orderNo]["effect2"]:setLoops(1)
							self.elemSetList[orderNo]["effect2"]:start()
							self:playEffectInternal(res.Sound.dg_chest)
						end

						if nElement.Reward.Gold == 0 then	
							self.itemSetList[orderNo]["reward_icon"]:setVisible(false)
							local scale = self.itemSetList[orderNo]["reward_icon"]:getScale()
							local x, y = self.itemSetList[orderNo]["reward_icon"]:getPosition()
							local actArray = CCArray:create()
							actArray:addObject(CCCallFunc:create(function (  )
								self.itemSetList[orderNo]["click"]:setEnabled(false)
							end))
							actArray:addObject(CCMoveTo:create(0, ccp(0, 0)))
							actArray:addObject(CCScaleTo:create(0, 0))
							actArray:addObject(CCShow:create())
							local spawnArray = CCArray:create()
							spawnArray:addObject(CCScaleTo:create(0.2, scale))
							spawnArray:addObject(CCMoveTo:create(0.2, ccp(x, y)))
							actArray:addObject(CCSpawn:create(spawnArray))
							actArray:addObject(CCCallFunc:create(function (  )
								self.itemSetList[orderNo]["click"]:setEnabled(true)
							end))
							self.itemSetList[orderNo]["reward_icon"]:runAction(CCSequence:create(actArray))
						else
							self.itemSetList[orderNo]["reward_icon"]:setVisible(true)
						end
					end
				elseif nElement.Type >= 21 and nElement.Type <= 27 then
					self.elemSetList[nElement.OrderNo]["icon"]:setVisible(false)
					self:showAnimationSpecialPet(nElement.Type, nElement.PetId, nElement.OrderNo, function ( ... )
						self.elemSetList[nElement.OrderNo]["icon"]:setVisible(true)
					end)
				elseif nElement.Type == 31 then
					GleeCore:showLayer("DWellPet", {coin = nElement.Reward.Coin, oldCoin = wellCoinList[self.WellStage]})
				elseif nElement.Type == 33 then
					if oldDrProp == 0 and self.DrProp ~= 0 then
						local param = {}
						param.content = res.locString("Dungeon$DoctorRewardTip")
						param.RightBtnText = res.locString("Global$Receive")
						param.rightBtnEnable = nElement.Reward and nElement.Reward.Soul and nElement.Reward.Soul > 0 or false
						param.callback = function ( ... )
							self:challengeOperatorEvent(index)
						end
						GleeCore:showLayer("DConfirmNT", param)
					end
				end
			elseif nElement.State == 4 then
				if nElement.Type == 8 then
					self:toast(string.format(res.locString("Dungeon$BuffAtk"), buffRate * 100))
				elseif nElement.Type == 9 then
					self:toast(string.format(res.locString("Dungeon$BuffHp"), buffRate * 100))
				elseif nElement.Type == 16 then
					if nElement.Reward then
						needDoGuide = false
						nElement.Reward.callback = function ( ... )
							if self:canDoGuide() then
								self:doGuide()
							end
						end
						if self.answerList[nElement.OrderNo] then
							self:showAnimationAnswerRight(nElement.Reward)
						else
							self:showAnimationAnswerWrong(nElement.Reward)
						end
					end
				elseif nElement.Type == 28 then
					-- if nElement.Reward.MyEgg.Cnt == 0 then
					-- 	self:toast(res.locString("Dungeon$FirstEgg"))
					-- end
				--	gameFunc.getBagInfo().setEgg({})
				-- elseif nElement.Type == 30 then
				-- 	if self.SRate > 0 then
				-- 		EventCenter.eventInput("UpdateGoldCoin")
				-- 		self:toast(string.format(res.locString("Dungeon$CatchRateUpTip"), self.SRate * 100))
				-- 	end
				elseif nElement.Type == 31 then
					GleeCore:showLayer("DWellPet", {coin = nElement.Reward.Coin, oldCoin = wellCoinList[self.WellStage]})
				elseif nElement.Type == 32 then
					self:toast(res.locString("Global$Get") .. res.locString("Global$Soul") .. nElement.Reward.Soul)
				elseif nElement.Type == 34 then
					gameFunc.getBroadCastInfo().set("boss_down", true) -- 避免断网导致神兽标记不同步
					self:showAnimationBossPetRunaway(nElement.PetId, nElement.OrderNo, function (  )
						local dbPet = dbManager.getCharactor(nElement.PetId)
						if dbPet then
							local param = {}
							param.title = res.locString("Dungeon$BestBossTitle")
							param.content = string.format(res.locString("Dungeon$BestBossContent"), dbPet.name)
							param.RightBtnText = res.locString("Dungeon$BestBossBtnOk")
							param.LeftBtnText = res.locString("Dungeon$BestBossBtnCancel")
							param.callback = function ( ... )
								gameFunc.getTempInfo().setHomeAdjustName("bestBoss")
								GleeCore:popControllerTo("CHome", nil, res.getTransitionFade())
							end
							param.cancelCallback = function (  )
								self:toast(string.format(res.locString("Dungeon$BestBossTip"), res.locString("Home$BestBoss"), dbPet.name))
							end
							GleeCore:showLayer("DConfirmNT", param)
						end
					end)
				end

				if nElement.Reward and nElement.Type ~= 16 and nElement.Type ~= 31 then
					needDoGuide = false
					nElement.Reward.callback = function ( ... )
						if self:canDoGuide() then
							self:doGuide()
						end
					end
					if nElement.Type == 12 then
						self:runWithDelay(function (  )
							GleeCore:showLayer("DGetReward", nElement.Reward, 2)
						end, 0.5)
					elseif nElement.Type == 28 then
						nElement.Reward.callback = function ( ... )
							if nElement.Reward.MyEgg and nElement.Reward.MyEgg.Cnt == 0 then
								local param = {}
								param.content = res.locString("Dungeon$FirstEgg")
								param.hideCancel = true
								GleeCore:showLayer("DConfirmNT", param)	
							end
						end
						GleeCore:showLayer("DGetReward", nElement.Reward, 2)
					else
						if nElement.Reward.Gold and nElement.Reward.Gold > 0 then
							self:toast(string.format(res.locString("Dungeon$GoldGetTip"), nElement.Reward.Gold))
							GuideHelper:check('DGetReward')
						else
							GleeCore:showLayer("DGetReward", nElement.Reward)
						end
					end
				end
			end
		end

		if needDoGuide and self:canDoGuide() then
			self:doGuide()
		end
	end)	
end

function CDungeon:challengeFastEvent( orderNo )
	self:send(netModel.getModelChallengeFast(self.ChallengeId, orderNo), function ( data )
		print("ChallengeFast")
		print(data)
		if data and data.D and data.D.Challenge then
			self:updateChallengeData(data.D.Challenge)
			for k,v in pairs(data.D.Challenge.Elements) do
				self:updateCellNode(v.OrderNo, v)
			end

			local oldlv = userFunc.getLevel()
			local oldRole = userFunc.getData()
			if data and data.D and data.D.Result and data.D.Result.Resource then
				gameFunc.updateResource(data.D.Result.Resource)
			end
			local newlv = userFunc.getLevel()
			local newRole = userFunc.getData()
			local param = {}
			param.Results = {data.D.Result}
			if newlv > oldlv then
				param.newRole = newRole
				param.oldRole = oldRole
			end
			param.callback = function ( ... )
				if not self.storyFinish then
					self:doFinishWithStory()
				end
				require 'UnlockManager':userLv(oldlv,newlv)
			end
			GleeCore:showLayer("DBattleSpeed", param)
		end
	end)
end

function CDungeon:rewardEvent( index )
--	if self.ElementList[index].Reward then
	--	self:setElementsTouchEnabled(false)
	--	if  self.ElementList[index].Reward then
			-- GleeCore:showLayer("DGetReward", self.ElementList[index].Reward)
--			self:challengeOperatorEvent(index)
	--	end
		-- if self.ElementList[index].Reward.Gold > 0 then
		-- 	local animateNode = tolua.cast(self.itemSetList[index]["reward_icon"]:getUserObject(), "SimpleAnimateNode")
		-- 	animateNode:stop()
		-- 	self:runActionGold(self.itemSetList[index]["reward"], index)
		-- else
		-- 	local point0 = NodeHelper:getPositionInScreen(self._ftpos2_getBg_materialCount)
		-- 	local point = NodeHelper:getPositionInScreen(self.itemSetList[index]["reward"])
		-- 	self.itemSetList[index]["reward"]:runAction(self:getMoveAction( self.itemSetList[index]["reward"]:getWidth(), point0.x - point.x, point0.y - point.y, function (  )
		-- 		self:challengeOperatorEvent(index)
		-- 	end ))
		-- end
--	else
		self:challengeOperatorEvent(index)
--	end
end

function CDungeon:showSecretBusinessman( reward, index )
	local rGold = math.abs(reward.Gold) 
	local rCoin = math.abs(reward.Coin)
	local name = ""
	local color = ""
	if reward.Equipments and #reward.Equipments > 0 and reward.Equipments[1].EquipmentId then
		local dbEquip = dbManager.getInfoEquipment(reward.Equipments[1].EquipmentId)
		name = dbEquip and dbEquip.name or ""
		color = res.RankColorStr[dbEquip.color + 1]
	end
	if reward.Materials and #reward.Materials > 0 and reward.Materials[1].MaterialId then
		local dbMaterial = dbManager.getInfoMaterial(reward.Materials[1].MaterialId)
		name = dbMaterial and dbMaterial.name or ""
		color = res.RankColorStr[dbMaterial.color + 1]
	end

	local param = {}
	if rGold > 0 then
		param.content = string.format(res.locString("Dungeon$BusinessTipGold"), rGold, color, name)
		param.callback = function ( ... )
			if userFunc.getGold() < rGold then
				self:toast(res.locString("Dungeon$GoldIsNotEnough"))
			else
				self:challengeOperatorEvent(index)
			end
		end
	elseif rCoin > 0 then
		param.content = string.format(res.locString("Dungeon$BusinessTipCoin"), rCoin, color, name)
		param.callback = function ( ... )
			if userFunc.getCoin() < rCoin then
				require "Toolkit".showDialogOnCoinNotEnough()
			else
				self:challengeOperatorEvent(index)
			end
		end
	end 
	GleeCore:showLayer("DConfirmNT", param)
end

function CDungeon:getBattleBuffer(  )
	-- 最多只可能出现一个buffer
	for i,v in ipairs(self.ElementList) do
		local nElement = v
		if nElement.Type >= 7 and nElement.Type <= 9 then
			if nElement.State == 4 then -- buffer加成
				local temp = {}
				temp[nElement.Type] = 1 + buffRate
				return temp
			end
		end
	end
	return nil
end

function CDungeon:getIndexListTogetherWith( index )
	local temp = {}
	index = index - 1
	local x1 = index % wGridCount
	local y1 = math.floor(index / wGridCount)
	for i=0,wGridCount * hGridCount - 1 do
		local x2 = i % wGridCount
		local y2 = math.floor(i / wGridCount)
		if math.abs(x2 - x1) <= 1 and math.abs(y2 - y1) <= 1 then
			if x2 == x1 and y2 == y1 then
				-- nothing
			else
				table.insert(temp, i + 1)
			end
		end
	end
	return temp
end

function CDungeon:canDoGuide( ... )
	return self.oldNotClear and self:canReset()
end

function CDungeon:canReset( ... )
	local reset = false
	if self.isClear then
		reset = true
		local klist = {1, 4, 5, 6, 12, 16, 19, 20, 28, 29, 32, 34, 21, 22, 23, 24, 25, 26, 27}
		for i,v in ipairs(self.ElementList) do
			local nElement = v
			if nElement.Type ~= 0 then
				if nElement.State < 3 or nElement.State == 5 then
					reset = false
					break
				end
				if nElement.State == 3 and table.find(klist, nElement.Type) then
					reset = false
					break
				end
			end
		end
	end
	return reset
end

function CDungeon:wellIsExit( ... )
	for i,nElement in ipairs(self.ElementList) do
		if nElement.Type == 31 and nElement.State == 3 then
			return true
		end
	end
	return false
end

function CDungeon:showFinishTip(  )
	if self:canReset() then
		local klist2 = {3, 21, 22, 23, 24, 25, 26, 31}
		for i,v in ipairs(self.ElementList) do
			local nElement = v
			if table.find(klist2, nElement.Type) and nElement.State == 3 then
				return true
			end
		end
	end
	return false
end

function CDungeon:doGuide( ... )
	print("CDungeon:doGuide")
	GuideHelper:startGuide('GCfg05',1,1,nil,1)
end

function CDungeon:doGuideImprove( ... )
	if self.isStarBoss then
		local nTown =	gameFunc.getTownInfo().getTownById(self.TownId)
		if nTown.Stars < 3 and nTown.Stars >= 1 then
			GuideHelper:startGuideIfIdle('GCfg14' )
			GuideHelper:startGuideIfIdle('GCfg14_2')
		end
	end
end

-- 开启蒙板引起的相关格子状态改变，由本地计算临时修改数据，播放动画特效等。后续服务器返回后更新数据
-- 返回需要更新的单元格列表
 function CDungeon:updateGridsStatusTogetherWith( index )
 	local updateNoList = {}
 	table.insert(updateNoList, index)
 	if self.ElementList[index].Type == 14 then
 		self.ElementList[index].State = 4
 	else
 		self.ElementList[index].State = 3
 	end
 	local elemType = self.ElementList[index].Type
 	local list = self:getIndexListTogetherWith(index)
 	for i,v in ipairs(list) do
 		if self.ElementList[v].Type ~= 15 and self.ElementList[v].Type ~= 0 then
	 		if elemType == 13 then
	 			if self.ElementList[v].State < 3 then
	 				-- if self.ElementList[v].Type >= 21 and self.ElementList[v].Type <= 27 then
	 				-- 	self.ElementList[v].State = 5
	 				-- 	self:updateGridsStatusTogetherWith(v)
	 				-- else
	 					self.ElementList[v].State = 5
	 					table.insert(updateNoList, v)
	 				-- end
	 			end
	 		else
	 			if (math.abs(v - index) == 1 or math.abs(v - index) == wGridCount) and self.ElementList[v].State == 1 then
	 				if self.ElementList[v].Type >= 21 and self.ElementList[v].Type <= 27 then
	 					self.ElementList[v].State = 3
	 					local tempList = self:updateGridsStatusTogetherWith(v)
	 					for k,v in pairs(tempList) do
	 						table.insert(updateNoList, v)
	 					end
	 				else
	 					self.ElementList[v].State = 2
	 					table.insert(updateNoList, v)
	 				end
	 			end
	 		end
 		end
 	end
 	return updateNoList
 end

 function CDungeon:canBattleWithPetType( elementType )
 	do return true end
 	
 	local typePropList = {
 		[21] = 3,
 		[22] = 7,
 		[23] = 8,
 		[24] = 6,
 		[25] = 2,
 		[26] = 6,
 	}
	local teamFunc = gameFunc.getTeamInfo()
	local team = teamFunc.getTeamActive()
	local petFunc = gameFunc.getPetInfo()
	if team.PetIdList then
		for i,v in ipairs(team.PetIdList) do
			local nPet = petFunc.getPetWithId(v)
			local dbPet = dbManager.getCharactor(nPet.PetId)
			if dbPet.prop_1 == typePropList[elementType] then
				return true
			end
		end
	end
	if team.BenchPetId and team.BenchPetId > 0 then
		local nPet = petFunc.getPetWithId(team.BenchPetId)
		local dbPet = dbManager.getCharactor(nPet.PetId)
		if dbPet.prop_1 == typePropList[elementType] then
			return true
		end	
	end
	return false
 end

 function CDungeon:getIndexWithRand( list, randValue )
 	local index = 0
 	if list then
 		for i,v in ipairs(list) do
 			if i > 1 then
 				list[i] = list[i] + list[i-1]
 			end
 		end

 		for i,v in ipairs(list) do
 			if randValue <= v then
 				index = i
 				break
 			end
 		end
 		if index == 0 then
 			index = #list
 		end
 	end
 	return index
 end

function CDungeon:getDungeonTreePic( terrian, randValue ) 
	randValue = randValue * girdCount / 100
	local terrianList = {
		[1] = {"FB_caodi_cao1.png", "FB_caodi_cao2.png", "FB_caodi_cao3.png"},
		[2] = {"FB_xuedi_jixue1.png", "FB_xuedi_jixue2.png", "FB_xuedi_jixue3.png", "FB_xuedi_jixue4.png"},
		[3] = {"FB_huangmo_shadi2.png", "FB_huangmo_shadi3.png", "FB_huangmo_shadi1.png"},
		[4] = {"FB_chengshi_lumian4.png", "FB_chengshi_lumian1.png", "FB_chengshi_lumian2.png", "FB_chengshi_lumian3.png", "FB_chengshi_lumian5.png"},
		[5] = {"FB_haiyang_haishui1.png", "FB_haiyang_haishui2.png", "FB_haiyang_haishui3.png"},
		[6] = {"FB_huoshan_yanshi3.png", "FB_huoshan_yanshi1.png", "FB_huoshan_yanshi2.png"},
		[7] = {"FB_DXC_shu1.png", "FB_DXC_shu2.png", "FB_DXC_shu3.png"},
		[8] = {"FB_shanmai_shanti1.png", "FB_shanmai_shanti2.png", "FB_shanmai_shanti3.png"},
		[9] = {"FB_shidi_caodi1.png", "FB_shidi_caodi2.png", "FB_shidi_shui1.png", "FB_shidi_shui2.png", "FB_shidi_shui3.png"}
	}
	local randList = {
		[1] = {7, 10, 23},
		[2] = {4, 24, 6, 6},
		[3] = {7, 5, 28},
		[4] = {15, 10, 7, 5, 3},
		[5] = {3, 25, 12},
		[6] = {16, 14, 10},
		[7] = {20, 14, 6},
		[8] = {12, 9, 19},
		[9] = {5, 12, 14, 4, 5},
	}

	local tree = ""
	if terrianList[terrian] then
		local index = self:getIndexWithRand(randList[terrian], randValue)
		if index >= 1 and index <= #terrianList[terrian] then
			tree = terrianList[terrian][index]
		end
	end
	return tree
end

function CDungeon:getDungeonFloorPic( terrian, randValue )
	randValue = randValue * girdCount / 100
	local terrianList = {
		[1] = {"FB_caodi_diban1.png", "FB_caodi_diban2.png", "FB_caodi_diban3.png"},
		[2] = {"FB_xuedi_diban1.png", "FB_xuedi_diban2.png", "FB_xuedi_diban3.png"},
		[3] = {"FB_huangmo_diban1.png", "FB_huangmo_diban2.png", "FB_huangmo_diban3.png"},
		[4] = {"FB_chengshi_diban1.png", "FB_chengshi_diban2.png", "FB_chengshi_diban3.png"},
		[5] = {"FB_haiyang_diban1.png", "FB_haiyang_diban2.png", "FB_haiyang_diban3.png"},
		[6] = {"FB_huoshan_diban1.png", "FB_huoshan_diban2.png", "FB_huoshan_diban3.png"},
		[7] = {"FB_DXC_diban1.png", "FB_DXC_diban2.png"},
		[8] = {"FB_shanmai_diban1.png", "FB_shanmai_diban2.png", "FB_shanmai_diban3.png"},
		[9] = {"FB_shidi_diban3.png", "FB_shidi_diban1.png", "FB_shidi_diban2.png"}
	}
	local randList = {
		[1] = {26, 10, 4},
		[2] = {25, 6, 9},
		[3] = {12, 8, 20},
		[4] = {4, 9, 27},
		[5] = {6, 30, 4},
		[6] = {8, 12, 20},
		[7] = {20, 20},
		[8] = {8, 12, 20},
		[9] = {26, 10, 4},
	}

	local floor = ""
	if terrianList[terrian] then
		local index = self:getIndexWithRand(randList[terrian], randValue)
		if index >= 1 and index <= #terrianList[terrian] then
			floor = terrianList[terrian][index]
		end
	end
	return floor
end

function CDungeon:getDungeonTreeSound( index )
	local musicEffect
	local dbTownInfo = dbManager.getInfoTownConfig(self.TownId)
	if dbTownInfo then
		local terrian = dbTownInfo.Terrain
		local treeRand = self.treeMap[index]
		if terrian == 1 then
			musicEffect = res.Sound.dg_touch_meadow
		elseif terrian == 2 then
			if treeRand <= 70 then
				musicEffect = res.Sound.dg_touch_snow
			else
				musicEffect = res.Sound.dg_touch_ice
			end
		elseif terrian == 3 then
			musicEffect = res.Sound.dg_touch_sand
		elseif terrian == 4 then
			if treeRand > 80 and treeRand <= 92.5 then
				musicEffect = res.Sound.dg_touch_stone
			else
				musicEffect = res.Sound.dg_touch
			end
		elseif terrian == 5 then
			if treeRand <= 70 then
				musicEffect = res.Sound.dg_touch_water
			else
				musicEffect = res.Sound.dg_touch
			end
		elseif terrian == 6 then
			if treeRand <= 40 then
				musicEffect = res.Sound.dg_touch_lava
			else
				musicEffect = res.Sound.dg_touch
			end
		elseif terrian == 7 then
			musicEffect = res.Sound.dg_touch_forest
		elseif terrian == 8 then
			musicEffect = res.Sound.dg_touch
		elseif terrian == 9 then
			musicEffect = res.Sound.dg_touch_wetland
		end
	end
	if not musicEffect then
		musicEffect = res.Sound.dg_touch
	end
	return musicEffect
end

 function CDungeon:getTipNpcText( ... )
 	return dbManager.getTipsConfigRandom()
 end

 function CDungeon:getRuleText( ... )
 	local result
 	local stageInfo = dbManager.getInfoStage(self.StageId)
 	if stageInfo then
 		if stageInfo.SeniorType and stageInfo.SeniorType >= 1 and stageInfo.SeniorType <= 4 then
 			local list = dbManager.getInfoElementMonsterConfigList(self.StageId, stageInfo.SeniorCondition)
 			local textFormat = res.locString(string.format("Dungeon$RuleTips%d", stageInfo.SeniorType))
 			if stageInfo.SeniorType == 1 and #list == 3 then
 				result = string.format(textFormat, dbManager.getCharactor(list[1].petid).name, dbManager.getCharactor(list[2].petid).name, dbManager.getCharactor(list[3].petid).name)
 			elseif stageInfo.SeniorType == 2 and #list == 1 then
 				result = string.format(textFormat, dbManager.getCharactor(list[1].petid).name)
 			elseif stageInfo.SeniorType == 3 and #list == 1 then
 				result = string.format(textFormat, dbManager.getCharactor(list[1].petid).name)
 			elseif stageInfo.SeniorType == 4 then
 				result = textFormat
 			end
 			result = result .. res.locString("Dungeon$RuleTipsEnd")
 		end
 	end
 	return result
 end

 function CDungeon:getNpcUIModel( petId )
	local monsterNode = require "ActionView".createActionViewById(petId):getRootNode()
	monsterNode:setVisible(true)
	monsterNode:setScale(0.5)
	monsterNode:setPosition(ccp(0, -30))
	monsterNode:setTransitionMills(0)
	monsterNode:play("待机")
	monsterNode:setBatchDraw(true)
	return monsterNode
 end

 -- function CDungeon:getMoveAction( originWidth, movex, movey, callback )
 -- 	local actArray = CCArray:create()
 -- 	actArray:addObject(CCScaleTo:create(0, 50 / originWidth))
	-- actArray:addObject(CCMoveTo:create(0.4, ccp(movex, movey)))
	-- actArray:addObject(CCHide:create())
	-- if callback then
	-- 	actArray:addObject(CCCallFunc:create(callback))		
	-- end
	-- return CCSequence:create(actArray)
 -- end

-- function CDungeon:runActionGold( node, index )
-- 	local goldAnimeSet = self:createLuaSet("@goldAnime")
-- 	node:addChild(goldAnimeSet[1])

-- 	local actArray = CCArray:create()
-- 	actArray:addObject(CCDelayTime:create(0.1))
-- 	local point0 = NodeHelper:getPositionInScreen(self._ftpos2_getBg_goldCount)
-- 	local point = NodeHelper:getPositionInScreen(node)
-- 	actArray:addObject(CCMoveTo:create(0.3, ccp(point0.x - point.x, point0.y - point.y)))
-- 	actArray:addObject(CCDelayTime:create(0.1))
-- 	actArray:addObject(CCCallFunc:create(function (  )
-- 		goldAnimeSet[1]:stop()
-- 		goldAnimeSet[1]:removeFromParentAndCleanup(true)
-- 		self:challengeOperatorEvent(index)
-- 	end))
-- 	goldAnimeSet[1]:runAction(CCSequence:create(actArray))
-- 	goldAnimeSet[1]:setStepLoops(1, 0)
-- 	goldAnimeSet[1]:setStepLoops(1, 1)
-- 	goldAnimeSet[1]:setStepLoops(1, 2)
-- 	goldAnimeSet[1]:setLoops(1)
-- 	goldAnimeSet[1]:start()

-- 	self:playEffectInternal(res.Sound.dg_pickcoin)
-- end

function CDungeon:playEffectInternal( name )
	musicHelper.playEffect(name)
end

function CDungeon:playElementEffect( nElement )
	local musicEffect
	local elementType = nElement.Type
	if nElement.State == 2 then
		musicEffect = self:getDungeonTreeSound(nElement.OrderNo)
	elseif nElement.State == 3 then
		if nElement.Reward then
			if nElement.Type ~= 12 and nElement.Type ~= 16 and nElement.Type ~= 31 then
				if nElement.Reward.Gold == 0 then
					musicEffect = res.Sound.dg_pickitem
				else
					self:playEffectInternal(res.Sound.dg_pickcoin)
				end
			end
		else
			if elementType >= 21 and elementType <= 27 then
				if nElement.PetId <= 0 then
					if self:canBattleWithPetType(elementType) then
						if elementType == 21 then
							musicEffect = res.Sound.dg_tree
						elseif elementType == 22 then
							musicEffect = res.Sound.dg_rock
						elseif elementType == 23 then
							musicEffect = res.Sound.dg_ice
						elseif elementType == 24 then
							musicEffect = res.Sound.dg_pool
						elseif elementType == 25 then
							musicEffect = res.Sound.dg_grass
						elseif elementType == 26 then
							musicEffect = res.Sound.dg_lava
						end
					end			
				end
			elseif elementType == 8 then
				musicEffect = res.Sound.dg_buff_sword
			elseif elementType == 9 then
				musicEffect = res.Sound.dg_buff_heart
			elseif elementType == 12 then
				musicEffect = res.Sound.dg_brick
			elseif elementType == 15 then
				musicEffect = res.Sound.dg_touch_open
			end
		end
		if not musicEffect then
			musicEffect = res.Sound.pick
		end
	elseif nElement.State == 4 then
		if elementType == 8 or elementType == 9 then
			musicEffect = res.Sound.pick
		end
	elseif nElement.State == 1 and elementType == 0 then
		musicEffect = res.Sound.pick
	end

	if musicEffect then
		self:playEffectInternal(musicEffect)
	end
end

function CDungeon:setElementsTouchEnabled( enable )
	print("setElementsTouchEnabled" .. tostring(enable))
--	CCDirector:sharedDirector():getTouchDispatcher():setDispatchEvents(enable)
	self._shield:setVisible(not enable)
end

function CDungeon:showAnimationFinish( ... )
	if self.animFinish then
		do return end
	end
	self.animFinish = true

	local animBg = RectangleNode:create()
	animBg:setContentSize(CCDirector:sharedDirector():getWinSize())
	animBg:setColorf(0, 0, 0, 0.6)
	self:getLayer():addChild(animBg)

	local Swf = require 'framework.swf.Swf'
	local myswf = Swf.new('Swf_TongGuan_XingXing')
	self:getLayer():addChild( myswf:getRootNode() )
	local shapeMap = {
		['shape-4'] = 'FB_clear_di.png',
		['shape-6'] = 'FB_clear_1.png',
		['shape-8'] = 'FB_clear_2.png',
		['shape-10'] = 'FB_clear_3.png',
		['shape-12'] = 'FB_clear_4.png',
		['shape-14'] = 'FB_clear_5.png',
		['shape-16'] = 'FB_clear_6.png',
		['shape-18'] = ''
	}

	local nTown =	gameFunc.getTownInfo().getTownById(self.TownId)
	for i=1,3 do
		local nodeStar = ElfNode:create()
		myswf:getNodeByTag(10 + i):addChild(nodeStar)
		nodeStar:setResid(i <= nTown.Stars and "SX_xingxing1.png" or "SX_xingxing2.png")
		nodeStar:setScale(4)
	end

	myswf:play(shapeMap, nil, function ( ... )
		myswf:getRootNode():removeFromParentAndCleanup(true)
		animBg:removeFromParentAndCleanup(true)
		self:setElementsTouchEnabled(true)
		GuideHelper:check('AnimtionEnd')
		
		if self:canDoGuide() then
			self:doGuide()
		end
		self:doGuideImprove()
	end)

	for i=1,8 do
		self:runWithDelay(function ( ... )
			self:playEffectInternal(res.Sound.ui_taxt)
		end, 6 / 20 + (i - 1) * 3 / 20 )
	end

	for i=1,3 do
		self:runWithDelay(function ( ... )
			self:playEffectInternal(res.Sound.ui_clear_stars)
		end, 29 / 20 + (i - 1) * 4 / 20 )
	end

	self:setElementsTouchEnabled(false)
end

function CDungeon:showAnimationAnswerRight( reward )
	local animBg = RectangleNode:create()
	animBg:setContentSize(CCDirector:sharedDirector():getWinSize())
	animBg:setColorf(0, 0, 0, 0.6)
	self:getLayer():addChild(animBg)

	local Swf = require 'framework.swf.Swf'
	local myswf = Swf.new('Swf_CuoWu')
	self:getLayer():addChild( myswf:getRootNode() )
	local shapeMap = {
		['shape-4'] = 'FB_clear_di.png',
		['shape-6'] = 'FB_right_1.png',
		['shape-8'] = 'FB_right_2.png',
		['shape-10'] = 'FB_right_3.png',
		['shape-12'] = 'FB_right_4.png',
	}
	myswf:play(shapeMap, nil, function ( ... )
		myswf:getRootNode():removeFromParentAndCleanup(true)
		animBg:removeFromParentAndCleanup(true)
		GleeCore:showLayer("DGetReward", reward)
		self:setElementsTouchEnabled(true)
	end)

	for i=1,4 do
		self:runWithDelay(function ( ... )
			self:playEffectInternal(res.Sound.ui_taxt)
		end, i * 6 / 40)
	end

	self:setElementsTouchEnabled(false)
end

function CDungeon:showAnimationAnswerWrong( reward )
	local animBg = RectangleNode:create()
	animBg:setContentSize(CCDirector:sharedDirector():getWinSize())
	animBg:setColorf(0, 0, 0, 0.6)
	self:getLayer():addChild(animBg)

	local Swf = require 'framework.swf.Swf'
	local myswf = Swf.new('Swf_CuoWu')
	self:getLayer():addChild( myswf:getRootNode() )
	local shapeMap = {
		['shape-4'] = 'FB_clear_di.png',
		['shape-6'] = 'FB_wrong_1.png',
		['shape-8'] = 'FB_wrong_2.png',
		['shape-10'] = 'FB_wrong_3.png',
		['shape-12'] = 'FB_wrong_4.png',
	}
	myswf:play(shapeMap, nil, function ( ... )
		myswf:getRootNode():removeFromParentAndCleanup(true)
		animBg:removeFromParentAndCleanup(true)
		GleeCore:showLayer("DGetReward", reward)
		self:setElementsTouchEnabled(true)
	end)

	for i=1,4 do
		self:runWithDelay(function ( ... )
			self:playEffectInternal(res.Sound.ui_taxt)
		end, i * 6 / 40)
	end
	
	self:setElementsTouchEnabled(false)
end

function CDungeon:showAnimationBossPet( petId, callback )
	local animBg = RectangleNode:create()
	local winSize = CCDirector:sharedDirector():getWinSize()
	animBg:setContentSize(CCSize(winSize.width + 200, winSize.height + 200))
	animBg:setColorf(0, 0, 0, 0.6)
	animBg:setVisible(false)
	self:getLayer():addChild(animBg)

	local Swf = require 'framework.swf.Swf'
	local myswf = Swf.new('Swf_ShenShou', {[2] = animBg})
	self:getLayer():addChild( myswf:getRootNode() )
	myswf:getRootNode():setScaleX(winSize.width / 1136)
	myswf:getRootNode():setScaleY(winSize.height / 640)

	for i=3,5 do
		local petIcon = ElfNode:create()
		petIcon:setResid(string.format("role_%03d.png", petId))
		petIcon:setScale(require 'CfgHelper'.getCache('BattleCharactor', 'id', petId).troop_scale)
		myswf:getNodeByTag(i):addChild(petIcon)
	end
	local shapeMap = {
		['shape-19'] = "",
		['shape-21'] = 'FB_ssjl01.png',
		['shape-23'] = 'FB_ssjl02.png',
		['shape-25'] = 'FB_ssjl03.png',
		['shape-27'] = 'FB_ssjl04.png',
	}
	myswf:play(shapeMap, nil, function ( ... )
		myswf:getRootNode():removeFromParentAndCleanup(true)
		animBg:removeFromParentAndCleanup(true)
		if callback then
			callback()
		end
		self:setElementsTouchEnabled(true)
		GuideHelper:check('BossPetAnimationEnd')
	end)

	self:runWithDelay(function ( ... )
		self:playEffectInternal(res.Sound.ui_sfx_advent)
	end, 16 / 24)
	self:setElementsTouchEnabled(false)
end

function CDungeon:showAnimationBossPetRunaway( petId, orderNo, callback )
	local function getBossOffset( orderNo )
		local size = self.floorSetList[orderNo][1]:getContentSize()
		orderNo = orderNo - 1
		local x = orderNo % wGridCount
		local y = math.floor(orderNo / wGridCount)
		return ccp((x - 3) * size.width, (3 - y) * size.height)
	end

	local Swf = require 'framework.swf.Swf'
	local myswf = Swf.new('Swf_ShenShouTaoPao')
	self:getLayer():addChild( myswf:getRootNode() )

	for i=2,4 do
		local elemSet = self:createLuaSet("@elem34")
		elemSet[1]:setPosition(getBossOffset(orderNo))
		local monsterNode = self:getNpcUIModel(petId)
		elemSet["icon"]:addChild(monsterNode)
		monsterNode:setOrder(elemSet["icon_shadow"]:getOrder() + 1)
		elemSet["icon_monsterFlag"]:setResid("FB_DXC_shenshou.png")
		elemSet["icon_monsterFlag"]:setOrder(elemSet["icon_shadow"]:getOrder() + 2)
		local dbPet = dbManager.getCharactor(petId)
		elemSet["icon_nameBg_name"]:setString(dbPet.name)
		elemSet["icon_nameBg"]:setOrder(elemSet["icon_shadow"]:getOrder() + 3)
		elemSet["icon"]:setVisible(true)
		myswf:getNodeByTag(i):addChild(elemSet[1])
	end
	local shapeMap = {
		['shape-4'] = "",
	}
	myswf:play(shapeMap, {1, 12}, function ( ... )
		myswf:getRootNode():removeFromParentAndCleanup(true)
		if callback then
			callback()
		end
		self:setElementsTouchEnabled(true)
	end)
	self:setElementsTouchEnabled(false)
end

function CDungeon:showAnimationSpecialPet( elemType, petId, orderNo, callback )
	local function getBossOffset( orderNo )
		local size = self.floorSetList[orderNo][1]:getContentSize()
		orderNo = orderNo - 1
		local x = orderNo % wGridCount
		local y = math.floor(orderNo / wGridCount)
		return ccp((x - 3) * size.width + 11, (3 - y) * size.height - 20)
	end

	local Swf = require 'framework.swf.Swf'
	local myswf = Swf.new('Swf_TeShuGuaiChuXian')
	self:getLayer():addChild( myswf:getRootNode() )

	for i=2,4 do
		local elemSet = self:createLuaSet("@elem34")
		elemSet[1]:setPosition(getBossOffset(orderNo))
		local monsterNode = self:getNpcUIModel(petId)
		elemSet["icon"]:addChild(monsterNode)
		monsterNode:setOrder(elemSet["icon_shadow"]:getOrder() + 1)
		elemSet["icon_monsterFlag"]:setResid(self:getSpecialPetIconWithType(elemType))
		elemSet["icon_monsterFlag"]:setOrder(elemSet["icon_shadow"]:getOrder() + 2)
		local dbPet = dbManager.getCharactor(petId)
		elemSet["icon_nameBg_name"]:setString(dbPet.name)
		elemSet["icon_nameBg"]:setOrder(elemSet["icon_shadow"]:getOrder() + 3)
		elemSet["icon"]:setVisible(true)
		myswf:getNodeByTag(i):addChild(elemSet[1])
	end
	local shapeMap = {
		['shape-4'] = "",
	}
	myswf:play(shapeMap, nil, function ( ... )
		myswf:getRootNode():removeFromParentAndCleanup(true)
		if callback then
			callback()
		end
	--	self:setElementsTouchEnabled(true)
	end)
--	self:setElementsTouchEnabled(false)
end

function CDungeon:getPetClearList( ... )
	local list = {}
	for k,v in pairs(self.ElementList) do
		if v.Type == 13 then
			local dbPet = dbManager.getCharactor(v.PetId)
			if dbPet then
				local isBoss = false
				local monsterInfo = dbManager.getInfoElementMonsterConfigWithMonsterId(v.MId)
				if monsterInfo and monsterInfo.IsBoss > 0 then
					isBoss = true
				end

				local param = {}
				param.petId = dbPet.id
				param.name = dbPet.name
				param.isBoss = isBoss
				param.isFinish = (v.State == 4 or (v.State == 3 and v.Reward ~= nil))
				table.insert(list, param)
			end
		end
	end
	return list
end

function CDungeon:getRandomRewardId( list )
	local index
	while true do
		index = math.random(#list)
		local canFind = false
		local idList = {1, 15}  -- 潜力石，重铸水晶
		for i,v in ipairs(idList) do
			local dbMaterial = dbManager.getInfoMaterial(v)
			if list[index].MaterialId == v and dbMaterial and userFunc.getLevel() < dbMaterial.unlocklv then
				table.remove(list, index)
				canFind = true
				break
			end
		end
		if not canFind then
			break
		end
	end
	return list[index].Id
end

-- function CDungeon:updateSeniorBoss(  )
-- 	for k,v in pairs(self.ElementList) do
-- 		if v.Type == 13 then
-- 			local monsterInfo = dbManager.getInfoElementMonsterConfigWithMonsterId(v.MId)
-- 			if monsterInfo and monsterInfo.IsBoss > 0 then
-- 				self:updateCellNode(v.OrderNo, self.ElementList[v.OrderNo])
-- 				break
-- 			end
-- 		end
-- 	end
-- end

function CDungeon:updateBackgroundFrame( ... )
	local dbTownInfo = dbManager.getInfoTownConfig(self.TownId)
	if dbTownInfo then
		for i=1,9 do
			self[string.format("_dungeonBg_bg%d", i)]:setVisible(i == dbTownInfo.Terrain)
			self[string.format("_dungeonFrame_pic_frame%d", i)]:setVisible(i == dbTownInfo.Terrain)
		end

		local stageInfo = dbManager.getInfoStage(self.StageId)
		if stageInfo then
			self._dungeonFrame_titleBg_title:setString(stageInfo.Name)
		end
	end
end

function CDungeon:getSpecialPetIconWithType( elemType )
	if elemType >= 21 and elemType <= 26 then
		local list = {
			[21] = "FB_DXC_jinhuashi_dian.png",
			[22] = "FB_DXC_jinhuashi_shi.png",
			[23] = "FB_DXC_jinhuashi_shui.png",
			[24] = "FB_DXC_jinhuashi_shui.png",
			[25] = "FB_DXC_jinhuashi_cao.png",
			[26] = "FB_DXC_jinhuashi_huo.png",
		}
		return list[elemType]
	else
		return ""
	end
end

function CDungeon:doFinishWithStory( ... )
	require 'StoryManager'.checkDialogue({stageID = self.StageId, battleID = self.battleId, condition = 2, passed = self.storyFinish, isWin = true, callback = function ( ... )
		if self.isClear then
			self:showAnimationFinish()
		else
			self:doGuideImprove()
		end
	end})
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(CDungeon, "CDungeon")


--------------------------------register--------------------------------
GleeCore:registerLuaController("CDungeon", CDungeon)
