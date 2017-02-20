local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local netModel = require "netModel"
local gameFunc = require "AppData"
local EventCenter = require 'EventCenter'
local userFunc = gameFunc.getUserInfo()
local petFunc = gameFunc.getPetInfo()
local GuideHelper = require 'GuideHelper'
local TownHelper = require "TownHelper"
local townFunc = gameFunc.getTownInfo()

local DTown = class(LuaDialog)

function DTown:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DTown.cocos.zip")
    return self._factory:createDocument("DTown.cocos")
end

--@@@@[[[[
function DTown:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_bg = set:getJoint9Node("commonDialog_cnt_bg")
    self._commonDialog_cnt_bg_bg1 = set:getElfNode("commonDialog_cnt_bg_bg1")
    self._commonDialog_cnt_bg_bg1_num = set:getElfNode("commonDialog_cnt_bg_bg1_num")
    self._commonDialog_cnt_bg_bg1_state = set:getElfNode("commonDialog_cnt_bg_bg1_state")
    self._commonDialog_cnt_bg_bg1_challengeCount = set:getLinearLayoutNode("commonDialog_cnt_bg_bg1_challengeCount")
    self._commonDialog_cnt_bg_bg1_challengeCount_value = set:getLabelNode("commonDialog_cnt_bg_bg1_challengeCount_value")
    self._commonDialog_cnt_bg_bg1_stageListBase = set:getElfNode("commonDialog_cnt_bg_bg1_stageListBase")
    self._sc = set:getElfNode("sc")
    self._sc_icon = set:getElfGrayNode("sc_icon")
    self._sc_bg = set:getElfNode("sc_bg")
    self._sc_num = set:getElfNode("sc_num")
    self._point = set:getElfNode("point")
    self._sel = set:getElfNode("sel")
    self._name = set:getLabelNode("name")
    self._icon = set:getElfNode("icon")
    self._name = set:getLabelNode("name")
    self._arrow = set:getElfNode("arrow")
    self._commonDialog_cnt_bg_bg1_stageListHard = set:getElfNode("commonDialog_cnt_bg_bg1_stageListHard")
    self._commonDialog_cnt_bg_bg1_stageListHard_bg2 = set:getElfNode("commonDialog_cnt_bg_bg1_stageListHard_bg2")
    self._commonDialog_cnt_bg_bg1_stageListHard_item1 = set:getElfNode("commonDialog_cnt_bg_bg1_stageListHard_item1")
    self._commonDialog_cnt_bg_bg1_stageListHard_item1_sc = set:getElfNode("commonDialog_cnt_bg_bg1_stageListHard_item1_sc")
    self._commonDialog_cnt_bg_bg1_stageListHard_item1_sc_icon = set:getElfGrayNode("commonDialog_cnt_bg_bg1_stageListHard_item1_sc_icon")
    self._commonDialog_cnt_bg_bg1_stageListHard_item1_sc_bg = set:getElfNode("commonDialog_cnt_bg_bg1_stageListHard_item1_sc_bg")
    self._commonDialog_cnt_bg_bg1_stageListHard_item1_sc_num = set:getElfNode("commonDialog_cnt_bg_bg1_stageListHard_item1_sc_num")
    self._commonDialog_cnt_bg_bg1_stageListHard_item1_point = set:getElfNode("commonDialog_cnt_bg_bg1_stageListHard_item1_point")
    self._commonDialog_cnt_bg_bg1_stageListHard_item1_name = set:getLabelNode("commonDialog_cnt_bg_bg1_stageListHard_item1_name")
    self._commonDialog_cnt_bg_bg1_stageListHard_item1_sel = set:getElfNode("commonDialog_cnt_bg_bg1_stageListHard_item1_sel")
    self._commonDialog_cnt_bg_bg1_stageListHard_item1_btn = set:getClickNode("commonDialog_cnt_bg_bg1_stageListHard_item1_btn")
    self._commonDialog_cnt_bg_bg1_stageListHard_item2 = set:getElfNode("commonDialog_cnt_bg_bg1_stageListHard_item2")
    self._commonDialog_cnt_bg_bg1_stageListHard_item2_sc = set:getElfNode("commonDialog_cnt_bg_bg1_stageListHard_item2_sc")
    self._commonDialog_cnt_bg_bg1_stageListHard_item2_sc_icon = set:getElfGrayNode("commonDialog_cnt_bg_bg1_stageListHard_item2_sc_icon")
    self._commonDialog_cnt_bg_bg1_stageListHard_item2_sc_bg = set:getElfNode("commonDialog_cnt_bg_bg1_stageListHard_item2_sc_bg")
    self._commonDialog_cnt_bg_bg1_stageListHard_item2_sc_num = set:getElfNode("commonDialog_cnt_bg_bg1_stageListHard_item2_sc_num")
    self._commonDialog_cnt_bg_bg1_stageListHard_item2_point = set:getElfNode("commonDialog_cnt_bg_bg1_stageListHard_item2_point")
    self._commonDialog_cnt_bg_bg1_stageListHard_item2_sel = set:getElfNode("commonDialog_cnt_bg_bg1_stageListHard_item2_sel")
    self._commonDialog_cnt_bg_bg1_stageListHard_item2_name = set:getLabelNode("commonDialog_cnt_bg_bg1_stageListHard_item2_name")
    self._commonDialog_cnt_bg_bg1_stageListHard_item2_btn = set:getClickNode("commonDialog_cnt_bg_bg1_stageListHard_item2_btn")
    self._commonDialog_cnt_bg_bg1_clearReward = set:getElfNode("commonDialog_cnt_bg_bg1_clearReward")
    self._commonDialog_cnt_bg_bg1_clearReward_icon = set:getElfNode("commonDialog_cnt_bg_bg1_clearReward_icon")
    self._commonDialog_cnt_bg_bg1_clearReward_count = set:getLabelNode("commonDialog_cnt_bg_bg1_clearReward_count")
    self._commonDialog_cnt_bg_bg1_clearReward_effect = set:getSimpleAnimateNode("commonDialog_cnt_bg_bg1_clearReward_effect")
    self._commonDialog_cnt_bg_bg1_clearReward_isClear = set:getElfNode("commonDialog_cnt_bg_bg1_clearReward_isClear")
    self._commonDialog_cnt_bg_bg1_clearReward_point = set:getElfNode("commonDialog_cnt_bg_bg1_clearReward_point")
    self._commonDialog_cnt_bg_bg1_clearReward_btn = set:getClickNode("commonDialog_cnt_bg_bg1_clearReward_btn")
    self._commonDialog_cnt_bg_bg1_des = set:getLabelNode("commonDialog_cnt_bg_bg1_des")
    self._commonDialog_cnt_bg_bg2_list = set:getListNode("commonDialog_cnt_bg_bg2_list")
    self._icon = set:getElfNode("icon")
    self._btn = set:getClickNode("btn")
    self._icon = set:getElfNode("icon")
    self._career = set:getElfNode("career")
    self._property = set:getElfNode("property")
    self._fragment = set:getLabelNode("fragment")
    self._starLayout = set:getLayoutNode("starLayout")
    self._btn = set:getClickNode("btn")
    self._icon = set:getElfNode("icon")
    self._icon = set:getElfNode("icon")
    self._icon = set:getElfNode("icon")
    self._commonDialog_cnt_bg_bg2_left = set:getElfNode("commonDialog_cnt_bg_bg2_left")
    self._commonDialog_cnt_bg_bg2_right = set:getElfNode("commonDialog_cnt_bg_bg2_right")
    self._commonDialog_cnt_bg_apCost = set:getLinearLayoutNode("commonDialog_cnt_bg_apCost")
    self._commonDialog_cnt_bg_apCost_value = set:getLabelNode("commonDialog_cnt_bg_apCost_value")
    self._commonDialog_cnt_bg_btnBattleSpeed = set:getClickNode("commonDialog_cnt_bg_btnBattleSpeed")
    self._commonDialog_cnt_bg_btnBattleSpeed_text = set:getLabelNode("commonDialog_cnt_bg_btnBattleSpeed_text")
    self._commonDialog_cnt_bg_btnDungeon = set:getClickNode("commonDialog_cnt_bg_btnDungeon")
    self._commonDialog_cnt_bg_btnDungeon_text = set:getLabelNode("commonDialog_cnt_bg_btnDungeon_text")
    self._commonDialog_cnt_bg_btnBattle = set:getClickNode("commonDialog_cnt_bg_btnBattle")
    self._commonDialog_cnt_bg_btnBattle_text = set:getLabelNode("commonDialog_cnt_bg_btnBattle_text")
    self._commonDialog_cnt_bg_btnReset = set:getClickNode("commonDialog_cnt_bg_btnReset")
    self._commonDialog_cnt_bg_btnReset_text = set:getLabelNode("commonDialog_cnt_bg_btnReset_text")
    self._commonDialog_cnt_bg_btnContinue = set:getClickNode("commonDialog_cnt_bg_btnContinue")
    self._commonDialog_cnt_bg_btnContinue_text = set:getLabelNode("commonDialog_cnt_bg_btnContinue_text")
    self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
    self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
--    self._@stagelayout = set:getLinearLayoutNode("@stagelayout")
--    self._@stageLine = set:getElfNode("@stageLine")
--    self._@stageLine = set:getElfNode("@stageLine")
--    self._@stageLine = set:getElfNode("@stageLine")
--    self._@stageLine = set:getElfNode("@stageLine")
--    self._@stageLine = set:getElfNode("@stageLine")
--    self._@stageItem = set:getElfNode("@stageItem")
--    self._@stageItem2 = set:getElfNode("@stageItem2")
--    self._@stageFirst = set:getElfNode("@stageFirst")
--    self._@item = set:getElfNode("@item")
--    self._@pet = set:getElfNode("@pet")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@none = set:getElfNode("@none")
--    self._@none = set:getElfNode("@none")
--    self._@none = set:getElfNode("@none")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DTown", function ( userData )
	local function doLaunch( isSenior, isHero )
   	Launcher.callNet(netModel.getModelTownGetStages(userData.townId, isSenior, isHero), function ( data )
  			Launcher.Launching(data)   
		end)
	end

	local unLockManager = require "UnlockManager"
	local PlayBranch = userData.PlayBranch ~= nil and userData.PlayBranch or townFunc.getPlayBranch()
	townFunc.PlayBranchEvent(function ( ... )
		doLaunch( false, false )
	end, function ( ... )
		if unLockManager:isUnlock("Elite") then
			doLaunch( true, false )
		else
			require 'UIHelper'.toast2(string.format(res.locString("Home$LevelUnLockTip"), unLockManager:getUnlockLv("Elite")))
		end
	end, function ( ... )
		if unLockManager:isUnlock("HeroElite") then
			doLaunch( false, true )
		else
			require 'UIHelper'.toast2(string.format(res.locString("Home$LevelUnLockTip"), unLockManager:getUnlockLv("HeroElite")))
		end
	end, PlayBranch)
end)

function DTown:onInit( userData, netData )
	gameFunc.getTempInfo().setValueForKey("LastDTownData", userData)
	self.townId = userData.townId
	self.PlayBranch = userData.PlayBranch ~= nil and userData.PlayBranch or townFunc.getPlayBranch()
	self.isNotNormal = not townFunc.isPlayBranchNormal(self.PlayBranch)

	local dbTownInfo = dbManager.getInfoTownConfig(self.townId)
	if dbTownInfo then
		self._commonDialog_title_text:setString(dbTownInfo.Name)
		self.townIcon = dbTownInfo.Town_pic and (dbTownInfo.Town_pic .. ".png") or ""
		self._commonDialog_cnt_bg_bg1_des:setString(dbTownInfo.story or "")
		require 'LangAdapter'.fontSize(self._commonDialog_cnt_bg_bg1_des,nil,nil,17)

		require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
			self._commonDialog_cnt_bg_bg1_des:setAnchorPoint(ccp(1, 0.5))
			self._commonDialog_cnt_bg_bg1_des:setPosition(ccp(198,-98.571434))
			self._commonDialog_cnt_bg_bg1_des:setHorizontalAlignment(kCCTextAlignmentRight)
		end)
	end
	if netData then
		print("TownGetStages")
		print(netData.D.Stages)
		self.stageList, self.curStageInfo = self:getStageList( netData.D.Stages )
	end
	if self.PlayBranch then
		if userData.petId then
			local index
			local petId = userData.petId
			local dbPet = dbManager.getCharactor(petId)
			if dbPet then
				local townType,townIds = 1,{}
				if tonumber(dbPet.capture_city) == nil then
					local k1,k2 = unpack(string.split(dbPet.capture_city,"|"))
					townType = tonumber(k1)
					for v in string.gmatch(k2,"%d+") do
						townIds[#townIds+1] = tonumber(v)
					end
				end
				if townType == 2 then
					index = table.keyOfItem(townIds, self.townId)
				end
			end
			if index and dbPet.stageorder then
				local temp = self.stageList[dbPet.stageorder[index]]
				if temp.netData.IsOpen then
					self.curStageInfo = temp
				end
			end
		elseif userData.stageId then
			for i,v in ipairs(self.stageList) do
				if v.configData.Id == userData.stageId and v.netData.IsOpen then
					self.curStageInfo = v
					break
				end
			end
		end
	end

	self:setListenerEvent()
	self:updateStageList()
	
	self:runWithDelay(function ()
		self:updateCurStageInfo()
	end, 0.05)

	self:runWithDelay(function ()
		self:updateTownClearReward()
	end, 0.1)

	self:runWithDelay(function ()
		self:updateStageReward()
	end, 0.15)

	self.isTownClear = gameFunc.getTempInfo().getTownIsClear() and not gameFunc.getTempInfo().getValueForKey("TownOpenActionDelay")
	gameFunc.getTempInfo().setValueForKey("TownOpenActionDelay", false)
	gameFunc.getTempInfo().setTownIsClear(false)

	if userData.PlayBranch == nil then
		gameFunc.getTownInfo().setLastTownId(self.townId)
		EventCenter.eventInput( "EventLastTownIdUpdate")
	end

	local guideNotify = function ( ... )
		if self.curStageInfo.netData.CostAp > 0 then
			GuideHelper:registerPoint('挑战',self._commonDialog_cnt_bg_btnDungeon)
		else
			GuideHelper:registerPoint('挑战',self._commonDialog_cnt_bg_btnContinue)
		end
		
		GuideHelper:registerPoint('关闭列表',self._commonDialog_btnClose)
		GuideHelper:registerPoint('领取通关奖励',self._commonDialog_cnt_bg_bg1_clearReward_btn)

		require 'UnlockManager':TownPass(self.townId, self.PlayBranch == townFunc.getPlayBranchList().PlayBranchSenior,
			self.PlayBranch == townFunc.getPlayBranchList().PlayBranchHero)
		GuideHelper:check('DStageList')
	end
	if not hideTransitionAnim then
		res.doActionDialogShow(self._commonDialog,function ( ... )
			guideNotify()
		end)
	else
		guideNotify()
	end

	require 'LangAdapter'.selectLang(nil, nil, nil, nil, function ( ... )
		self._commonDialog_cnt_bg_btnBattleSpeed_text:setFontSize(22)
		self._commonDialog_cnt_bg_btnDungeon_text:setFontSize(22)
		self._commonDialog_cnt_bg_btnBattle_text:setFontSize(22)
		self._commonDialog_cnt_bg_btnReset_text:setFontSize(22)
		self._commonDialog_cnt_bg_btnContinue_text:setFontSize(22)
	end)
end

function DTown:onBack( userData, netData )
	
end

function DTown:close( ... )
	GuideHelper:check('DStageListClose')
end
--------------------------------custom code-----------------------------

function DTown:setListenerEvent( ... )
	self._commonDialog_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
		if self.isTownClear then
			require 'EventCenter'.eventInput( "MainTaskIdUpdate")
		end		
	end)

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
		if self.isTownClear then
			require 'EventCenter'.eventInput( "MainTaskIdUpdate")
		end	
	end)

	self._commonDialog_cnt_bg_btnBattleSpeed:setListener(function ( ... )
		if self:canBattleSpeed() then
			if userFunc.getAp() < self.curStageInfo.netData.CostAp then
				res.doEventAddAP()
			else
				if self.isNotNormal then
					TownHelper.stageBattleSpeed(self, self.curStageInfo.netData, function ( data )
						if data.D.Stage then
							self:setStage(data.D.Stage)
							self:updateStageList()
							self:updateCurStageInfo()
						end
					end)
				else
					local nTownInfo = gameFunc.getTownInfo().getTownById(self.townId)
					if userFunc.getVipLevel() >= 1 or nTownInfo.Stars >= 3 then
						TownHelper.stageChallengeSpeed(self, self.curStageInfo.netData, function ( data )
							if data.D.Stage then
								self:setStage(data.D.Stage)
								self:updateCurStageInfo()
								self:updateStageList()
							end
						end)
					else
						self:toast(res.locString("Dungeon$BattleSpeedFailTip"))
					end					
				end
			end	
		else
			self:toast(string.format(res.locString("Dungeon$BattleSpeedUnlock"), dbManager.getUnLockLvConfig("BattleSpeed")))
		end
	end)

	self._commonDialog_cnt_bg_btnBattle:setListener(function ( ... )
		if userFunc.getAp() < self.curStageInfo.netData.CostAp then
			res.doEventAddAP()
		else
			self:stageBattle()
		end	
	end)

	self._commonDialog_cnt_bg_btnDungeon:setListener(function ( ... )
		if userFunc.getAp() < self.curStageInfo.netData.CostAp then
			res.doEventAddAP()
		else
			self:stageChallenge()
		end	
	end)

	self._commonDialog_cnt_bg_btnReset:setListener(function ( ... )
		TownHelper.stageReset(self, self.curStageInfo.netData, function ( data )
			if data.D.Stage then
				self:setStage(data.D.Stage)
				self:updateCurStageInfo()
			end
		end)
	end)

	self._commonDialog_cnt_bg_btnContinue:setListener(function ( ... )
		self:stageChallenge()
	end)
end

function DTown:canBattleSpeed( ... )
	return userFunc.getLevel() >= dbManager.getUnLockLvConfig("BattleSpeed")
end

function DTown:updateCurStageInfo(  )
	local curStage = self.curStageInfo
	self._commonDialog_cnt_bg_bg1_num:setResid(string.format("N_GK_%d.png", curStage.index))

	townFunc.PlayBranchEvent(function ( ... )
		self._commonDialog_cnt_bg_bg1_state:setResid("N_GK_xkq.png")
	end, function ( ... )
		self._commonDialog_cnt_bg_bg1_state:setResid("N_GK_ytg.png")
	end, function ( ... )
		self._commonDialog_cnt_bg_bg1_state:setResid("N_hero_FB_kuang_jiaobiao.png")
	end, self.PlayBranch)
	self._commonDialog_cnt_bg_bg1_challengeCount_value:setString(curStage.netData.TodayTimes)
	require "LangAdapter".LayoutChildrenReverseifArabic(self._commonDialog_cnt_bg_bg1_challengeCount)

	local isReset = curStage.netData.TodayTimes == 0 and curStage.netData.CostAp > 0
	self._commonDialog_cnt_bg_apCost_value:setString(tostring(curStage.netData.CostAp))
	self._commonDialog_cnt_bg_apCost:setVisible(not isReset)
	require "LangAdapter".LayoutChildrenReverseifArabic(self._commonDialog_cnt_bg_apCost)

	local nTownInfo = gameFunc.getTownInfo().getTownById(self.townId)

	local isClear
	townFunc.PlayBranchEvent(function ( ... )
		isClear = nTownInfo.Clear
	end, function ( ... )
		isClear = nTownInfo.SeniorClear
	end, function ( ... )
		isClear = nTownInfo.HeroClear
	end, self.PlayBranch)

	if not isReset then
		if curStage.netData.Fast and self:canBattleSpeed() then
			self._commonDialog_cnt_bg_apCost:setPosition(ccp(290, -77))
			self._commonDialog_cnt_bg_btnDungeon:setPosition(ccp(290, -180))
			self._commonDialog_cnt_bg_btnContinue:setPosition(ccp(290, -180))
			self._commonDialog_cnt_bg_btnBattle:setPosition(ccp(290, -180))
		else
			self._commonDialog_cnt_bg_apCost:setPosition(ccp(290, -95))
			self._commonDialog_cnt_bg_btnDungeon:setPosition(ccp(290, -150))
			self._commonDialog_cnt_bg_btnContinue:setPosition(ccp(290, -150))
			self._commonDialog_cnt_bg_btnBattle:setPosition(ccp(290, -150))
		end
	else
		self._commonDialog_cnt_bg_apCost:setPosition(ccp(290, -95))
	end

	self._commonDialog_cnt_bg_btnBattle:setVisible(not isReset and (self.isNotNormal or curStage.configData.StageType == 2))
	self._commonDialog_cnt_bg_btnReset:setVisible(isReset and (self.isNotNormal or curStage.configData.StageType == 1))
	self._commonDialog_cnt_bg_btnDungeon:setVisible(not self.isNotNormal and curStage.configData.StageType == 1 and not isReset and curStage.netData.CostAp > 0)
	self._commonDialog_cnt_bg_btnContinue:setVisible(not self.isNotNormal and curStage.configData.StageType == 1 and not isReset and curStage.netData.CostAp == 0)
	self._commonDialog_cnt_bg_btnBattleSpeed:setVisible(not isReset and (self.isNotNormal or curStage.configData.StageType == 1) and curStage.netData.Fast and self:canBattleSpeed())
	self._commonDialog_cnt_bg_btnDungeon_text:setString(res.locString(isClear and "Town$ReDungeon" or "Town$Dungeon"))
end

function DTown:updateStageReward(  )
	local stageId = self.curStageInfo.configData.Id
	local dbStage = dbManager.getInfoStage(stageId)
	print("stageId = " .. stageId)
	print(dbStage)
	if dbStage then
		self._commonDialog_cnt_bg_bg2_list:getContainer():removeAllChildrenWithCleanup(true)
		local rewardAmount = 0
		if dbStage.Rewards then
			rewardAmount = #dbStage.Rewards
			for i,v in ipairs(dbStage.Rewards) do
				local item = self:createLuaSet("@item")
				self._commonDialog_cnt_bg_bg2_list:getContainer():addChild(item[1])
				local itemId = v[2]
				if v[1] == 7 then
					local dbEquip = dbManager.getInfoEquipment(itemId)
					if dbEquip then
						res.setNodeWithEquip(item["icon"], dbEquip)
						item["btn"]:setListener(function (  )
							GleeCore:showLayer("DEquipDetail",{nEquip = gameFunc.getEquipInfo().getEquipInfoByEquipmentID(itemId)})
						end)
					end
				elseif v[1] == 9 then
					local dbMaterial = dbManager.getInfoMaterial(itemId)
					if dbMaterial then
						res.setNodeWithMaterial(item["icon"], dbMaterial)
						item["btn"]:setListener(function (  )
							GleeCore:showLayer("DMaterialDetail", {materialId = itemId, FromTownID = self.townId})	
						end)
					end
				end
			end
		end

		if dbStage.CpJuniorIds then
			rewardAmount = rewardAmount + #dbStage.CpJuniorIds
			for i,v in ipairs(dbStage.CpJuniorIds) do
				local nPet = petFunc.getPetInfoByPetId(v)
				local petSet = self:createLuaSet("@pet")
				self._commonDialog_cnt_bg_bg2_list:getContainer():addChild(petSet[1])
				res.setNodeWithPet(petSet["icon"], nPet)

				local dbPet = dbManager.getCharactor(nPet.PetId)
				petSet["career"]:setResid(res.getPetCareerIcon(dbPet.atk_method_system))
				require 'PetNodeHelper'.updateStarLayout(petSet["starLayout"], dbPet)

				petSet["btn"]:setListener(function (  )
					GleeCore:showLayer("DPetDetailV", {PetInfo = gameFunc.getPetInfo().getPetInfoByPetId(nPet.PetId), FromTownID = self.townId})
				end)
			end
		end

		self._commonDialog_cnt_bg_bg2_list:setTouchEnable(rewardAmount > 5)
		self._commonDialog_cnt_bg_bg2_left:setVisible(rewardAmount > 5)
		self._commonDialog_cnt_bg_bg2_right:setVisible(rewardAmount > 5)
		if rewardAmount < 5 then
			for i=1,5 - rewardAmount do
				local noneSet = self:createLuaSet("@none")
				self._commonDialog_cnt_bg_bg2_list:getContainer():addChild(noneSet[1])
			end
		end
		self._commonDialog_cnt_bg_bg2_list:layout()
	end
end

function DTown:updateTownClearReward( ... )
	local nTownInfo = gameFunc.getTownInfo().getTownById(self.townId)
	local dbTownInfo = dbManager.getInfoTownConfig(self.townId)
	if dbTownInfo then
		local isSenior, isHero, isClear, isRewardGot
		townFunc.PlayBranchEvent(function ( ... )
			if dbTownInfo.ClearReward > 0 then
				res.setNodeWithCoin(self._commonDialog_cnt_bg_bg1_clearReward_icon)
				self._commonDialog_cnt_bg_bg1_clearReward_count:setString("x" .. dbTownInfo.ClearReward)
			end
			self._commonDialog_cnt_bg_bg1_clearReward:setVisible(dbTownInfo.ClearReward > 0)
			isSenior, isHero, isClear, isRewardGot = false, false, nTownInfo.Clear, nTownInfo.RewardGot
		end, function ( ... )
			if dbTownInfo.ClearRewardSenior > 0 then
				local dbMaterial = dbManager.getInfoMaterial(42)
				if dbMaterial then
					res.setNodeWithMaterial(self._commonDialog_cnt_bg_bg1_clearReward_icon, dbMaterial)
					self._commonDialog_cnt_bg_bg1_clearReward_count:setString("x" .. dbTownInfo.ClearRewardSenior)
				end
			end
			self._commonDialog_cnt_bg_bg1_clearReward:setVisible(dbTownInfo.ClearRewardSenior > 0)
			isSenior, isHero, isClear, isRewardGot = true, false, nTownInfo.SeniorClear, nTownInfo.RewardSeniorGot
		end, function ( ... )
			if dbTownInfo.ClearRewardHero > 0 then
				local dbMaterial = dbManager.getInfoMaterial(69)
				if dbMaterial then
					res.setNodeWithMaterial(self._commonDialog_cnt_bg_bg1_clearReward_icon, dbMaterial)
					self._commonDialog_cnt_bg_bg1_clearReward_count:setString("x" .. dbTownInfo.ClearRewardHero)
				end
			end
			self._commonDialog_cnt_bg_bg1_clearReward:setVisible(dbTownInfo.ClearRewardHero > 0)
			isSenior, isHero, isClear, isRewardGot = false, true, nTownInfo.HeroClear, nTownInfo.RewardHeroGot
		end, self.PlayBranch)

		self._commonDialog_cnt_bg_bg1_clearReward_isClear:setVisible(isRewardGot)
		self._commonDialog_cnt_bg_bg1_clearReward_effect:setVisible(isClear and not isRewardGot)
		self._commonDialog_cnt_bg_bg1_clearReward_point:setVisible(isClear and not isRewardGot)
		self._commonDialog_cnt_bg_bg1_clearReward_btn:setEnabled(isClear and not isRewardGot)
		self._commonDialog_cnt_bg_bg1_clearReward_btn:setListener(function ( ... )
			self:send(netModel.getModelTownClearReward(self.townId, isSenior, isHero), function ( data )
				if data and data.D then
					gameFunc.getTownInfo().setTown(data.D.Town)
					gameFunc.updateResource(data.D.Resource)

					self._commonDialog_cnt_bg_bg1_clearReward_isClear:setVisible(true)
					self._commonDialog_cnt_bg_bg1_clearReward_effect:setVisible(false)
					self._commonDialog_cnt_bg_bg1_clearReward_point:setVisible(false)
					self._commonDialog_cnt_bg_bg1_clearReward_btn:setEnabled(false)
					if data.D.Reward then
						GleeCore:showLayer("DGetReward", data.D.Reward)
					end
					EventCenter.eventInput('UpdateTownsRedPoint')
				end
			end)
		end)
	end
end

function DTown:getStageList( nStageList )
	local function getStageInfoWithId( stageId )
		for k,v in pairs(nStageList) do
			if v.StageId == stageId then
				return v
			end
		end
		return nil
	end

	local listData = {}
	local stageListInfo = dbManager.getInfoStageList(self.townId, self.PlayBranch)
	local index = nil
	if stageListInfo then
		for i,v in ipairs(stageListInfo) do
			local nData = getStageInfoWithId(v.Id)
			if nData then
				table.insert(listData, {configData = v, netData = nData, index = i})
				if nData.IsOpen and not nData.Clear then
					index = i
				end
			end
		end
		if not index then -- 全部通关
			index = #stageListInfo
		end
	end
	return listData, listData[index]
end

function DTown:setStage( nStage )
	self.curStageInfo.netData = nStage
	self.stageList[self.curStageInfo.index] = self.curStageInfo
end

function DTown:updateStageList( ... )
	self._commonDialog_cnt_bg_bg1_stageListBase:setVisible(not self.isNotNormal)
	self._commonDialog_cnt_bg_bg1_stageListHard:setVisible(self.isNotNormal)

	if self.isNotNormal then
		for j=1,2 do
			if j <= #self.stageList then
				if self.stageList[j].netData.IsOpen then
					self[string.format("_commonDialog_cnt_bg_bg1_stageListHard_item%d_sc_bg", j)]:setResid("N_GK_73.png")
					self[string.format("_commonDialog_cnt_bg_bg1_stageListHard_item%d_point", j)]:setResid("N_GK_95.png")
					self[string.format("_commonDialog_cnt_bg_bg1_stageListHard_item%d_sc_num", j)]:setResid(string.format("N_GK_%d.png", j))
					self[string.format("_commonDialog_cnt_bg_bg1_stageListHard_item%d_name", j)]:setFontFillColor(ccc4f(0.79, 0.43, 0.3, 1.0), true)
				else
					self[string.format("_commonDialog_cnt_bg_bg1_stageListHard_item%d_sc_bg", j)]:setResid("N_GK_75.png")
					self[string.format("_commonDialog_cnt_bg_bg1_stageListHard_item%d_point", j)]:setResid("N_GK_85.png")
					self[string.format("_commonDialog_cnt_bg_bg1_stageListHard_item%d_sc_num", j)]:setResid("QY_tubiao_suoding.png")
					self[string.format("_commonDialog_cnt_bg_bg1_stageListHard_item%d_name", j)]:setFontFillColor(ccc4f(0.51, 0.345, 0.27, 1.0), true)
				end
				
				self[string.format("_commonDialog_cnt_bg_bg1_stageListHard_item%d_sc_icon", j)]:setGrayEnabled(not self.stageList[j].netData.IsOpen or (self.stageList[j].configData.DailyTimes == 1 and self.stageList[j].netData.Clear))
				self[string.format("_commonDialog_cnt_bg_bg1_stageListHard_item%d_sc_icon", j)]:setResid(res.getPetIcon(self.stageList[j].netData.PetId))
				self[string.format("_commonDialog_cnt_bg_bg1_stageListHard_item%d_sel", j)]:setVisible(self.curStageInfo.index == j)

				self[string.format("_commonDialog_cnt_bg_bg1_stageListHard_item%d_name", j)]:setString(self.stageList[j].configData.Name)
				-- self[string.format("_commonDialog_cnt_bg_bg1_stageListHard_item%d_btn", j)]:setEnabled(self.stageList[j].netData.IsOpen)
				-- self[string.format("_commonDialog_cnt_bg_bg1_stageListHard_item%d_btn", j)]:setListener(function ( ... )
				-- 	self.curStageInfo = self.stageList[j]
				-- 	self:updateStageReward()
				-- 	self:updateStageList()
				-- 	self:updateCurStageInfo()
				-- end)
				self[string.format("_commonDialog_cnt_bg_bg1_stageListHard_item%d_sc", j)]:setScale(self.curStageInfo.index == j and 1 or 0.7)
			else
				self[string.format("_commonDialog_cnt_bg_bg1_stageListHard_item%d", j)]:setVisible(false)
				self._commonDialog_cnt_bg_bg1_stageListHard_bg2:setVisible(false)
				self._commonDialog_cnt_bg_bg1_stageListHard_item1:setPosition(ccp(-63, -6))
			end
		end
	else
		self._commonDialog_cnt_bg_bg1_stageListBase:removeAllChildrenWithCleanup(true)
		local stageLayoutSet = self:createLuaSet("@stagelayout")
		self._commonDialog_cnt_bg_bg1_stageListBase:addChild(stageLayoutSet[1])
		
		local count = #self.stageList
		local itemCount = math.min(count, 5)
		local setList = {}
		local lineList = {}
		for i=1,itemCount do
			local stageLineSet = self:createLuaSet("@stageLine")
			stageLayoutSet[1]:addChild(stageLineSet[1])
			stageLineSet[1]:setScaleX( (487.5 / itemCount) / stageLineSet[1]:getContentSize().width)
			table.insert(lineList, stageLineSet)

			if i == itemCount then
				local stageItem2Set = self:createLuaSet("@stageItem2")
				self._commonDialog_cnt_bg_bg1_stageListBase:addChild(stageItem2Set[1])
				stageItem2Set["icon"]:setResid(self.townIcon)
				
				if self.stageList[count].netData.Clear then
					stageItem2Set["name"]:setFontFillColor(ccc4f(0.79, 0.43, 0.3, 1.0), true)
				else
					stageItem2Set["name"]:setFontFillColor(ccc4f(0.51, 0.345, 0.27, 1.0), true)
				end

				stageItem2Set["name"]:setString(self.stageList[count].configData.Name)
				table.insert(setList, stageItem2Set)

				if self.curStageInfo.index == count then
					stageLineSet[1]:setResid("N_GK_96.png")
				elseif self.curStageInfo.index == count - 1 then
					stageLineSet[1]:setResid("N_GK_88.png")
				else
					if count < 6 then
						stageLineSet[1]:setResid("N_GK_88.png")
					else
						stageLineSet[1]:setResid("N_GK_888.png")
					end
				end
			else
				local j 	-- j为真正的关卡序号
				if self.curStageInfo.index > 4 then
					if self.curStageInfo.index == count then
						j =  i + count - itemCount
					else
						j =  i + self.curStageInfo.index - 4
					end
				else
					j = i
				end
				
				local stageItemSet = self:createLuaSet("@stageItem")
				self._commonDialog_cnt_bg_bg1_stageListBase:addChild(stageItemSet[1])
				
				stageItemSet["sc_icon"]:setResid(res.getPetIcon(self.stageList[j].netData.PetId))
				if self.stageList[j].netData.Clear then
					stageItemSet["sc_bg"]:setResid("N_GK_73.png")
					stageItemSet["name"]:setFontFillColor(ccc4f(0.79, 0.43, 0.3, 1.0), true)
					stageItemSet["sc_icon"]:setGrayEnabled(true)
					stageItemSet["sc_num"]:setResid(string.format("N_GK_z_%d.png", self.stageList[j].index))
					stageLineSet[1]:setResid("N_GK_96.png")
					stageItemSet["point"]:setResid("N_GK_95.png")
				else
					stageItemSet["sc_bg"]:setResid("N_GK_75.png")
					stageItemSet["name"]:setFontFillColor(ccc4f(0.51, 0.345, 0.27, 1.0), true)
					stageItemSet["sc_icon"]:setGrayEnabled(false)
					if not self.stageList[j].netData.Clear and self.stageList[j].netData.IsOpen then
						stageItemSet["sc_num"]:setResid(string.format("N_GK_%d.png", self.stageList[j].index))
					else
						stageItemSet["sc_num"]:setResid("QY_tubiao_suoding.png")
					end
					stageItemSet["sc_num"]:setScale(33 / stageItemSet["sc_num"]:getContentSize().width)

					stageLineSet[1]:setResid("N_GK_88.png")
					stageItemSet["point"]:setResid("N_GK_85.png")
				end

				stageItemSet["name"]:setString(self.stageList[j].configData.Name)
				stageItemSet["point"]:setScale(1)
				stageItemSet["sel"]:setScale(stageItemSet["point"]:getScale())
				stageItemSet["sel"]:setVisible(self.curStageInfo.index == j)
				table.insert(setList, stageItemSet)

				stageItemSet["sc"]:setScale(self.curStageInfo.index == j and 1.3 or 1.0)
			end
		end
		stageLayoutSet[1]:layout()
		for i,v in ipairs(setList) do
			NodeHelper:setPositionInScreen(v[1], NodeHelper:getPositionInScreen(lineList[i][1]))
		end

		if itemCount == 1 and self.townId == 1 then
			self._commonDialog_cnt_bg_bg1_stageListBase:addChild(self:createLuaSet("@stageFirst")[1])
		end
	end
end

function DTown:stageChallenge(  )
	local stageId = self.curStageInfo.netData.StageId
	self:send(netModel.getModelStageChallenge(stageId), function ( data )
		print("StageChallenge:")
		print(data)
		self:close()
		if data and data.D then
			if data.D.Role then
				local isUpdateAp = data.D.Role.Ap ~= userFunc.getAp()
				if isUpdateAp then
					userFunc.setData(data.D.Role)
					require 'EventCenter'.eventInput("UpdateAp")
				end
			end
		end
		GleeCore:closeAllLayers()
		GleeCore:pushController("CDungeon", {TownId = self.townId, StageId = stageId, Challenge = data.D.Challenge}, nil, res.getTransitionFade())
		EventCenter.eventInput("HomeToolBarHide")
	end)		
end

function DTown:stageBattle( ... )
	local para = {}
	para.type = "battleFuben"
	para.stageId = self.curStageInfo.netData.StageId
	para.bossId = self.curStageInfo.netData.PetId
	para.terrian = dbManager.getInfoTownConfig(self.townId).Terrain
	para.preAp = math.max(userFunc.getAp() - self.curStageInfo.netData.CostAp, 0)
	GleeCore:showLayer("DPrepareForStageBattle", para)

	-- print('stageBattle:'..para.stageId)
	
	-- local db1 = dbManager.getInfoDefaultConfig('petupguidestage')
	-- if db1 and para.stageId == db1.Value then
	-- 	EventCenter.resetGroup('GCfg06')
	-- 	EventCenter.addEventFunc(require 'FightEvent'.Pve_FightResult, function ( data )
	-- 		print('recv listener')
	-- 		GuideHelper:startGuide('GCfg06')
	-- 	end,'GCfg06')
	-- end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DTown, "DTown")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DTown", DTown)


