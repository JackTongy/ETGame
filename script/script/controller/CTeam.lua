local config = require "Config"
local gameFunc = require "AppData"
local res = require "Res"
local dbManager = require "DBManager"
local netModel = require "netModel"
local GuideHelper = require 'GuideHelper'
local EventCenter = require 'EventCenter'
local unLockManager = require "UnlockManager"

local memberMaxCount = 6
local teamFunc = gameFunc.getTeamInfo()
local petFunc = gameFunc.getPetInfo()
local partnerFunc = gameFunc.getPartnerInfo()
local equipFunc = gameFunc.getEquipInfo()
local mibaoFunc = gameFunc.getMibaoInfo()

local CTeam = class(LuaController)

function CTeam:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."CTeam.cocos.zip")
    return self._factory:createDocument("CTeam.cocos")
end

--@@@@[[[[
function CTeam:onInitXML()
	local set = self._set
    self._bg = set:getElfNode("bg")
    self._bg_clipSwip_petSwip = set:getSwipNode("bg_clipSwip_petSwip")
    self._bg_clipSwip_petSwip_linearlayout = set:getLinearLayoutNode("bg_clipSwip_petSwip_linearlayout")
    self._img = set:getElfNode("img")
    self._addPetTip = set:getLabelNode("addPetTip")
    self._btn = set:getColorClickNode("btn")
    self._partnerIconSet = set:getElfNode("partnerIconSet")
    self._icon = set:getElfNode("icon")
    self._name = set:getLabelNode("name")
    self._btn = set:getClickNode("btn")
    self._unLockAnim = set:getSimpleAnimateNode("unLockAnim")
    self._icon = set:getElfNode("icon")
    self._name = set:getLabelNode("name")
    self._btn = set:getClickNode("btn")
    self._unLockAnim = set:getSimpleAnimateNode("unLockAnim")
    self._icon = set:getElfNode("icon")
    self._name = set:getLabelNode("name")
    self._btn = set:getClickNode("btn")
    self._unLockAnim = set:getSimpleAnimateNode("unLockAnim")
    self._icon = set:getElfNode("icon")
    self._name = set:getLabelNode("name")
    self._btn = set:getClickNode("btn")
    self._unLockAnim = set:getSimpleAnimateNode("unLockAnim")
    self._icon = set:getElfNode("icon")
    self._name = set:getLabelNode("name")
    self._btn = set:getClickNode("btn")
    self._unLockAnim = set:getSimpleAnimateNode("unLockAnim")
    self._icon = set:getElfNode("icon")
    self._name = set:getLabelNode("name")
    self._btn = set:getClickNode("btn")
    self._unLockAnim = set:getSimpleAnimateNode("unLockAnim")
    self._bg_list = set:getListNode("bg_list")
    self._name = set:getLabelNode("name")
    self._point = set:getElfNode("point")
    self._des = set:getLabelNode("des")
    self._title = set:getLabelNode("title")
    self._bg_ftpos = set:getFitPositionNode("bg_ftpos")
    self._bg_ftpos_teamPowerTitle = set:getLabelNode("bg_ftpos_teamPowerTitle")
    self._bg_ftpos_teamPower = set:getLabelNode("bg_ftpos_teamPower")
    self._bg_ftpos_petLayout = set:getLinearLayoutNode("bg_ftpos_petLayout")
    self._highLight = set:getElfNode("highLight")
    self._icon = set:getElfNode("icon")
    self._starLayout = set:getLayoutNode("starLayout")
    self._titleIcon = set:getElfNode("titleIcon")
    self._point = set:getElfNode("point")
    self._btn = set:getClickNode("btn")
    self._highLight = set:getElfNode("highLight")
    self._icon = set:getElfNode("icon")
    self._starLayout = set:getLayoutNode("starLayout")
    self._titleIcon = set:getElfNode("titleIcon")
    self._point = set:getElfNode("point")
    self._btn = set:getClickNode("btn")
    self._bg_ftpos_btnTeamSwitch = set:getButtonNode("bg_ftpos_btnTeamSwitch")
    self._bg_ftpos_btnTeamSwitch_text = set:getLabelNode("bg_ftpos_btnTeamSwitch_text")
    self._bg_ftpos_btnHonor = set:getButtonNode("bg_ftpos_btnHonor")
    self._bg_ftpos_btnHonor_text = set:getLabelNode("bg_ftpos_btnHonor_text")
    self._bg_ftpos_btnHonor_height = set:getElfNode("bg_ftpos_btnHonor_height")
    self._bg_ftpos3 = set:getFitPositionNode("bg_ftpos3")
    self._bg_ftpos3_btnClose = set:getButtonNode("bg_ftpos3_btnClose")
    self._bg_ftpos3_btnImproveEquipOneKey = set:getButtonNode("bg_ftpos3_btnImproveEquipOneKey")
    self._bg_ftpos3_btnChangeEquipOneKey = set:getButtonNode("bg_ftpos3_btnChangeEquipOneKey")
    self._bg_ftpos3_btnPetChange = set:getButtonNode("bg_ftpos3_btnPetChange")
    self._bg_ftpos3_btnPetDetail = set:getButtonNode("bg_ftpos3_btnPetDetail")
    self._bg_ftpos3_btnFetter = set:getButtonNode("bg_ftpos3_btnFetter")
    self._bg_ftpos3_btnEvolve = set:getButtonNode("bg_ftpos3_btnEvolve")
    self._bg_ftpos4 = set:getFitPositionNode("bg_ftpos4")
    self._bg_ftpos4_canImproveRedPoint = set:getElfNode("bg_ftpos4_canImproveRedPoint")
    self._bg_ftpos4_btnGem = set:getButtonNode("bg_ftpos4_btnGem")
    self._bg_ftpos4_layoutGem = set:getLayoutNode("bg_ftpos4_layoutGem")
    self._bg_ftpos4_layoutGem_icon1 = set:getElfNode("bg_ftpos4_layoutGem_icon1")
    self._bg_ftpos4_layoutGem_icon2 = set:getElfNode("bg_ftpos4_layoutGem_icon2")
    self._bg_ftpos4_layoutGem_icon3 = set:getElfNode("bg_ftpos4_layoutGem_icon3")
    self._bg_ftpos4_layoutGem_icon4 = set:getElfNode("bg_ftpos4_layoutGem_icon4")
    self._bg_ftpos4_lyt_career = set:getElfNode("bg_ftpos4_lyt_career")
    self._bg_ftpos4_lyt_name = set:getLabelNode("bg_ftpos4_lyt_name")
    self._bg_ftpos4_starLayout = set:getLayoutNode("bg_ftpos4_starLayout")
    self._bg_ftpos4_layoutBar = set:getLinearLayoutNode("bg_ftpos4_layoutBar")
    self._layoutQuality_value = set:getLabelNode("layoutQuality_value")
    self._layoutPower_value = set:getLabelNode("layoutPower_value")
    self._layoutHp_value = set:getLabelNode("layoutHp_value")
    self._layoutAtk_value = set:getLabelNode("layoutAtk_value")
    self._layoutLv_value = set:getLabelNode("layoutLv_value")
    self._lv1_lv2 = set:getProgressNode("lv1_lv2")
    self._lv1_lv3 = set:getElfNode("lv1_lv3")
    self._btn = set:getButtonNode("btn")
    self._layoutEvolve = set:getLinearLayoutNode("layoutEvolve")
    self._icon = set:getElfNode("icon")
    self._a1 = set:getElfNode("a1")
    self._a2 = set:getElfNode("a2")
    self._icon = set:getElfNode("icon")
    self._a1 = set:getElfNode("a1")
    self._a2 = set:getElfNode("a2")
    self._icon = set:getElfNode("icon")
    self._btn = set:getButtonNode("btn")
    self._fetterTitle = set:getLabelNode("fetterTitle")
    self._fetterTitle_layoutFetter = set:getLayoutNode("fetterTitle_layoutFetter")
    self._highLight = set:getElfNode("highLight")
    self._btn = set:getButtonNode("btn")
    self._bg_ftpos5 = set:getFitPositionNode("bg_ftpos5")
    self._icon = set:getElfNode("icon")
    self._lv = set:getLabelNode("lv")
    self._rankDes = set:getLabelNode("rankDes")
    self._name = set:getLabelNode("name")
    self._btn = set:getButtonNode("btn")
    self._add = set:getElfNode("add")
    self._isSuit = set:getSimpleAnimateNode("isSuit")
    self._point = set:getElfNode("point")
    self._rune = set:getElfNode("rune")
    self._icon = set:getElfNode("icon")
    self._lv = set:getLabelNode("lv")
    self._rankDes = set:getLabelNode("rankDes")
    self._name = set:getLabelNode("name")
    self._btn = set:getButtonNode("btn")
    self._add = set:getElfNode("add")
    self._isSuit = set:getSimpleAnimateNode("isSuit")
    self._point = set:getElfNode("point")
    self._rune = set:getElfNode("rune")
    self._icon = set:getElfNode("icon")
    self._lv = set:getLabelNode("lv")
    self._rankDes = set:getLabelNode("rankDes")
    self._name = set:getLabelNode("name")
    self._btn = set:getButtonNode("btn")
    self._add = set:getElfNode("add")
    self._isSuit = set:getSimpleAnimateNode("isSuit")
    self._point = set:getElfNode("point")
    self._rune = set:getElfNode("rune")
    self._icon = set:getElfNode("icon")
    self._lv = set:getLabelNode("lv")
    self._rankDes = set:getLabelNode("rankDes")
    self._name = set:getLabelNode("name")
    self._btn = set:getButtonNode("btn")
    self._add = set:getElfNode("add")
    self._isSuit = set:getSimpleAnimateNode("isSuit")
    self._point = set:getElfNode("point")
    self._rune = set:getElfNode("rune")
    self._icon = set:getElfNode("icon")
    self._lv = set:getLabelNode("lv")
    self._rankDes = set:getLabelNode("rankDes")
    self._name = set:getLabelNode("name")
    self._btn = set:getButtonNode("btn")
    self._add = set:getElfNode("add")
    self._isSuit = set:getSimpleAnimateNode("isSuit")
    self._point = set:getElfNode("point")
    self._rune = set:getElfNode("rune")
    self._icon = set:getElfNode("icon")
    self._lv = set:getLabelNode("lv")
    self._rankDes = set:getLabelNode("rankDes")
    self._name = set:getLabelNode("name")
    self._btn = set:getButtonNode("btn")
    self._add = set:getElfNode("add")
    self._isSuit = set:getSimpleAnimateNode("isSuit")
    self._point = set:getElfNode("point")
    self._rune = set:getElfNode("rune")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._lv = set:getLabelNode("lv")
    self._name = set:getLabelNode("name")
    self._btn = set:getButtonNode("btn")
    self._point = set:getElfNode("point")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._lv = set:getLabelNode("lv")
    self._name = set:getLabelNode("name")
    self._btn = set:getButtonNode("btn")
    self._point = set:getElfNode("point")
--    self._@page = set:getElfNode("@page")
--    self._@pagePartner = set:getElfNode("@pagePartner")
--    self._@partner1 = set:getElfNode("@partner1")
--    self._@partner2 = set:getElfNode("@partner2")
--    self._@partner3 = set:getElfNode("@partner3")
--    self._@partner4 = set:getElfNode("@partner4")
--    self._@partner5 = set:getElfNode("@partner5")
--    self._@partner6 = set:getElfNode("@partner6")
--    self._@petTitle = set:getElfNode("@petTitle")
--    self._@desText = set:getElfNode("@desText")
--    self._@sep = set:getElfNode("@sep")
--    self._@none = set:getElfNode("@none")
--    self._@sepName = set:getElfNode("@sepName")
--    self._@pet = set:getElfNode("@pet")
--    self._@pet = set:getElfNode("@pet")
--    self._@star = set:getElfNode("@star")
--    self._@Bar1 = set:getJoint9Node("@Bar1")
--    self._@sepe = set:getElfNode("@sepe")
--    self._@Bar2 = set:getJoint9Node("@Bar2")
--    self._@evolvePet = set:getElfNode("@evolvePet")
--    self._@evolveArrow = set:getElfNode("@evolveArrow")
--    self._@evolvePet = set:getElfNode("@evolvePet")
--    self._@evolveArrow = set:getElfNode("@evolveArrow")
--    self._@evolvePet = set:getElfNode("@evolvePet")
--    self._@sepe = set:getElfNode("@sepe")
--    self._@Bar3 = set:getJoint9Node("@Bar3")
--    self._@fetterGird = set:getElfNode("@fetterGird")
--    self._@equip1 = set:getElfNode("@equip1")
--    self._@equip2 = set:getElfNode("@equip2")
--    self._@equip3 = set:getElfNode("@equip3")
--    self._@equip4 = set:getElfNode("@equip4")
--    self._@equip5 = set:getElfNode("@equip5")
--    self._@equip6 = set:getElfNode("@equip6")
--    self._@treasure1 = set:getElfNode("@treasure1")
--    self._@treasure2 = set:getElfNode("@treasure2")
end
--@@@@]]]]

--------------------------------override functions----------------------
function CTeam:onInit( userData, netData )
	print("CTeam:")
	print(userData)
	if userData then
		self.team = userData.Team
		self.petList = userData.Pets
		self.equipList = userData.Equips
		self.treasureList = userData.Mibaos
		self.gemList = userData.Gems
		self.Lv = userData.Lv
		self.partnerList = userData.Partners
		self.CloseFunc = userData.CloseFunc
		self.equipUnLock = userData.equipShow
		self.treasureUnLock = userData.mibaoShow
		self.runeList = userData.Runes
	end

	if self.team then
		self.teamSelected = self.team.TeamId
		self.equipUnLock = (self.equipUnLock == nil) or self.equipUnLock
		self.treasureUnLock = (self.treasureUnLock == nil) or self.treasureUnLock
	else
		self.teamSelected = teamFunc.getTeamActiveId()
		self.equipUnLock = unLockManager:isUnlock("EquipOn") or false
		self.treasureUnLock = unLockManager:isUnlock("Mibao") or false
	end
	if unLockManager:isOpen("Mibao") == false then
		self.treasureUnLock = false
	end
	
	self.petIndexSelected = 1

	if unLockManager:isUnlock("Team3") then
		self.maxTeamCount = 3
	elseif unLockManager:isUnlock("Team2") then
		self.maxTeamCount = 2
	else
		self.maxTeamCount = 1
	end
	self:setListenerEvent()
	self:initTeamsNodeSet()
	self:initEquipsNodeSet()
	self:initTreasuresNodeSet()
	self:updateTeamInfo()
	self:updatePetInfoWithIndex(self.petIndexSelected)

	EventCenter.addEventFunc('autoSelect2',function ( ... )
		self.petIndexSelected = 2
		self:updatePetInfoWithIndex(self.petIndexSelected)
		self:updateTeamInfo(true)
		GuideHelper:check('autoSelect2')
	end,'CTeam')

	EventCenter.addEventFunc('PetInfoModify',function ( ... )
		self:updateTeamInfo(true)
		self:updatePetInfoWithIndex(self.petIndexSelected)
	end,'CTeam')

	EventCenter.addEventFunc("OnEquipmentUpdate", function (  )
		self:updateTeamInfo(true)
		self:updatePetInfoWithIndex(self.petIndexSelected)
	end, "CTeam")

	EventCenter.addEventFunc("OnRuneUpdate", function (  )
		self:updateTeamInfo(true)
		self:updatePetInfoWithIndex(self.petIndexSelected)
	end, "CTeam")

	EventCenter.addEventFunc("UpdateMaterial", function (  )
		self:updatePetPoint()
		self:updatePetInfoWithIndex(self.petIndexSelected)
	end, "CTeam")
	
	EventCenter.addEventFunc("UpdatePetWithEvolve", function (  )
		self:updateTeamInfo()
		self:updatePetInfoWithIndex(self.petIndexSelected)
	end, "CTeam")

	EventCenter.addEventFunc("UserLevelUp", function (  )
		if unLockManager:isUnlock("Team3") then
			self.maxTeamCount = 3
		elseif unLockManager:isUnlock("Team2") then
			self.maxTeamCount = 2
		else
			self.maxTeamCount = 1
		end
		self._bg_ftpos_btnTeamSwitch:setVisible(self:isMyTeam() and self.maxTeamCount > 1)
		self:updatePetPoint()
		self:updatePetInfoWithIndex(self.petIndexSelected)
	end, "CTeam")

	EventCenter.addEventFunc("OnMibaoUpdate", function ( ... )
		self:updateTeamInfo(true)
		self:updatePetInfoWithIndex(self.petIndexSelected)
	end,'CTeam')

	if self._guideNode1 then
		GuideHelper:registerPoint('手',self._guideNode1['btn'])
	end
	if self._guideEquipOn then
		GuideHelper:registerPoint('已装备',self._guideEquipOn['btn'])
	else
		GuideHelper:unregisterPoint('已装备')
	end
	
	GuideHelper:registerPoint('切换',self._bg_ftpos_btnTeamSwitch)
	GuideHelper:registerPoint('返回',self._bg_ftpos3_btnClose)
	GuideHelper:registerPoint('详情',self._bg_ftpos3_btnPetDetail)
	GuideHelper:registerPoint('一键',self._bg_ftpos3_btnChangeEquipOneKey)
	GuideHelper:registerPoint('宝石',self._bg_ftpos4_btnGem)
	GuideHelper:check('CTeam')
	
end

function CTeam:onBack( userData, netData )
	self:updateTeamInfo(true)
	self:updatePetInfoWithIndex(self.petIndexSelected)
end

function CTeam:onRelease( ... )
	EventCenter.resetGroup('CTeam')
	-- CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(self.tickSwip)
	-- self.tickSwip = nil
end
--------------------------------custom code-----------------------------

function CTeam:setListenerEvent(  )
	-- local winSize = CCDirector:sharedDirector():getWinSize()
	-- local timerHelper = require "framework.sync.TimerHelper"
	-- self.tickSwip = timerHelper.tick(function ( dt )
	-- 	if self.pagePartnerSet then
	-- 		local pos = NodeHelper:getPositionInScreen(self.pagePartnerSet[1])
	-- 		local pos2 = NodeHelper:getPositionInScreen(self._bg_ftpos5)
	-- 		local pos3 = NodeHelper:getPositionInScreen(self._bg_topBar_ftpos)
	-- 		local pos4 = NodeHelper:getPositionInScreen(self._bg_ftpos3)
	-- 		if pos.x < 1136 + winSize.width / 2 then
	-- 			NodeHelper:setPositionInScreen(self._bg_ftpos5, ccp(pos.x - 1136, pos2.y))
	-- 			NodeHelper:setPositionInScreen(self._bg_topBar_ftpos, ccp(pos.x - 1136 - winSize.width / 2, pos3.y))
	-- 			NodeHelper:setPositionInScreen(self._bg_ftpos3, ccp(pos.x - 1136 + winSize.width / 2, pos4.y))
	-- 		else
	-- 			NodeHelper:setPositionInScreen(self._bg_ftpos5, ccp(winSize.width / 2, pos2.y))
	-- 			NodeHelper:setPositionInScreen(self._bg_topBar_ftpos, ccp(0, pos3.y))
	-- 			NodeHelper:setPositionInScreen(self._bg_ftpos3, ccp(winSize.width, pos4.y))
	-- 		end
	-- 	end
	-- end)

	self._bg_ftpos3_btnClose:setTriggleSound(res.Sound.back)
	self._bg_ftpos3_btnClose:setListener(function (  )
		if self.CloseFunc then
			self.CloseFunc()
		end

		if not self.team then
			gameFunc.getTempInfo().setValueForKey("TeamPoint", false)
		end
		GleeCore:popController(nil, res.getTransitionFade())
	end)

	local function setTeamActive( teamId )
		self:send(netModel.getModelTeamSetActive(teamId), function ( data )
			print("TeamSetActive:")
			print(data)
			if data and data.D then
				if data.D.Teams then
					teamFunc.setTeamList(data.D.Teams)
				end
				if data.D.Pets then
					petFunc.addPets(data.D.Pets)
				end
			end
			self.teamSelected = teamId
			self.petIndexSelected = 1
			self:updateTeamInfo()
			self:updatePetInfoWithIndex(self.petIndexSelected)
			GuideHelper:check('TeamSwith')
		end)
	end

	self._bg_ftpos_btnTeamSwitch:setVisible(self:isMyTeam() and self.maxTeamCount > 1)
	self._bg_ftpos_btnTeamSwitch:setListener(function (  )
		local nextTeamSelected = self.teamSelected + 1
		if nextTeamSelected == self.maxTeamCount + 1 then
			nextTeamSelected = 1
		end
		setTeamActive(nextTeamSelected)
	end)

	self._bg_ftpos_btnHonor:setVisible(self:isMyTeam())
	self._bg_ftpos_btnHonor:setListener(function ( ... )
		GleeCore:showLayer('DTitle', {callback = function ( ... )
			self:updateTeamInfo(true)
			self:updatePetInfoWithIndex(self.petIndexSelected)
		end})
	end)

	-- self._bg_clipSwip_petSwip:setInterType(InterHelper.Acce)
	self._bg_clipSwip_petSwip:setAnimateTime(0.3)
	self._bg_clipSwip_petSwip:registerSwipeListenerScriptHandler(function(state, oldIndex, newIndex)
		if state ~= 0 and oldIndex ~= newIndex then	-- animation just finished
			print("oldIndex = " .. tostring(oldIndex))
			print("newIndex = " .. tostring(newIndex))
			-- newIndex从0计数
			self.petIndexSelected = self:getPetIndex(newIndex + 1)
			self:updateTeamInfo(true)
			self:updatePetInfoWithIndex(self.petIndexSelected)
		end
	end)

	self._bg_ftpos3_btnPetDetail:setListener(function (  )
		self:doPetDetailEvent()
	end)

	self._bg_ftpos3_btnPetChange:setListener(function ( ... )
		local nPetId = self:getPetIdSelected()
		if nPetId > 0 then
			local param = {}
			param.needRemove = self:getPetIdListNeedRemove(nPetId, false)
			local positionId = self.petIndexSelected
			param.funcChosePet = function ( newPetId )
				if self:canSetInTeam(newPetId, nPetId, false) then
					self:chosePet( nPetId, newPetId, positionId )
					return true
				else
					return false
				end
			end
			param.sortFunc = function ( list )
				petFunc.sortWithTeam(list, self:getPetIdListSetIn(), nPetId)
			end
			GleeCore:showLayer("DPetChose", param)
		end
	end)

	self._bg_ftpos3_btnChangeEquipOneKey:setListener(function ( ... )
		self:loadEquipOneKey()
	end)

	self._bg_ftpos3_btnImproveEquipOneKey:setListener(function ( ... )
		local param = {}
		param.content = res.locString("Team$ImproveEquipOneKeyConfirm")
		param.callback = function ( ... )
			self:improveEquipOneKey()
		end
		GleeCore:showLayer("DConfirmNT", param)
	end)

	self._bg_ftpos3_btnFetter:setListener(function ( ... )
		self:doFetterEvent()
	end)

	self._bg_ftpos3_btnEvolve:setListener(function ( ... )
		GleeCore:showLayer("DEvolvePre", {nPetId = self:getPetIdSelected()})
	end)
end

function CTeam:initTeamsNodeSet(  )
	self.teamNodeSet = {}
	for i=1,memberMaxCount do
		local pet = self:createLuaSet("@pet")
		self._bg_ftpos_petLayout:addChild(pet[1])
		
		pet["btn"]:setListener(function (  )
			self.petIndexSelected = i
			self:updatePetInfoWithIndex(self.petIndexSelected)
			self:updateTeamInfo(true)
			GuideHelper:check(string.format('SelectTeamPos%d',i))
		end)
		GuideHelper:registerPoint(string.format('TeamPos%d',i),pet["btn"])
		table.insert(self.teamNodeSet, pet)
	end
end

function CTeam:initEquipsNodeSet(  )
	self.equipsNodeSet = {}
	for i=1,6 do
		local equip = self:createLuaSet(string.format("@equip%d", i))
		
		------guidenode
		if i == 1 then
			self._guideNode1 = equip
		end
		local ngEquip = self:getEquipWithLocation(self:getPetIdSelected(), i)
		if ngEquip then
			self._guideEquipOn = self._guideEquipOn or equip
		end
		-------

		self._bg_ftpos5:addChild(equip[1])
		equip["btn"]:setListener(function (  )
			local teamInfo = self:getTeamSelected()

			local nPetId = self:getPetIdSelected()
			if nPetId > 0 then
				local nEquip = self:getEquipWithLocation(nPetId, i)
				local function netEqChange( newEquipId )
					local oldPid = 0
					if nEquip then
						oldPid = nEquip.Id
					end
					print("oldPid = " .. tostring(oldPid) .. " ,newEquipId = " .. tostring(newEquipId))
					self:send(netModel.getModelEqChange(self.petIndexSelected, oldPid, newEquipId, teamFunc.getTeamActiveId()), function ( data )
						print("EqChange:")
						print(data)
						GuideHelper:check('EquipOn')
						if data and data.D then
							if data.D.Oe then
								equipFunc.setEquipWithId(data.D.Oe)
							end
							if data.D.Ne then
								equipFunc.setEquipWithId(data.D.Ne)
							end
							if data.D.Teams then
								local teamFunc = gameFunc.getTeamInfo()
								teamFunc.setTeamList(data.D.Teams)
							end

							if data.D.Pets then
								for k,v in pairs(data.D.Pets) do
									petFunc.setPet(v)
								end
								
								for k,v in pairs(data.D.Pets) do
									if v.Id == nPetId then
										self:updatePetInfo(v)
										break
									end
								end
							end
							self:updateTeamInfo(true)
							self:updatePetInfoWithIndex(self.petIndexSelected)
						end
					end)
				end

				local function updateEquipEvent( newEquipId ) -- newEquipId = 0即为卸下
					netEqChange(newEquipId)
				end

				if self:isMyTeam() then
					local tempList = equipFunc.selectByCondition(function ( v )
						if dbManager.getInfoEquipment(v.EquipmentId).location~=i then
							return false
						end
						return true
					end)
					if tempList and #tempList > 0 then
						local param = {}
						param.choseType = "ForPutOn"
						param.nEquip = nEquip
						param.equipLocation = i
						param.updateEquipEvent = updateEquipEvent
						GleeCore:showLayer("DEquipChose", param)
					else
						self:toast(res.locString("Team$NoEquipCanSelect"))
					end
				else
					if nEquip then
						local arenaEquipData = {}
						arenaEquipData.nPet = self:getPetInfo(nPetId)
						arenaEquipData.equipListOnPet = equipFunc.getEquipListWithPetId0(nPetId, self.equipList, self.team)
						arenaEquipData.runeList = self:getRuneListWithEquipId( nEquip.Id )
						GleeCore:showLayer("DEquipDetail",{nEquip = nEquip, arenaEquipData = arenaEquipData})
					end
				end
			end
		end)
		table.insert(self.equipsNodeSet, equip)
		equip[1]:setVisible(self.equipUnLock)
	end
end

function CTeam:initTreasuresNodeSet( ... )
	self.treasureNodeSet = {}
	for i=1,2 do
		local treasure = self:createLuaSet(string.format("@treasure%d", i))
		self._bg_ftpos5:addChild(treasure[1])
		treasure["btn"]:setListener(function ( ... )
			local teamInfo = self:getTeamSelected()
			local nPetId = self:getPetIdSelected()
			if nPetId > 0 then
				local nTreasure = self:getTreasureWithType(nPetId, i)
				if self:isMyTeam() then
					local tempList = mibaoFunc.selectByCondition(function ( v )
						if nTreasure then
							return nTreasure.Id ~= v.Id and dbManager.getInfoTreasure(v.MibaoId).Type == i
						else
							return dbManager.getInfoTreasure(v.MibaoId).Type == i
						end
					end)
					if (tempList and #tempList > 0) or nTreasure then
						local param = {}
						param.treasureType = i
						param.nTreasure = nTreasure
						table.sort(tempList, function ( v1, v2 )
							local SetIn1,SetIn2 = mibaoFunc.getSetInStatus(v1),mibaoFunc.getSetInStatus(v2)
							local on1 = SetIn1 == 1
							local on2 = SetIn2 == 1
							if on1 == on2 then
								local dbTreasure1 = dbManager.getInfoTreasure(v1.MibaoId)
								local dbTreasure2 = dbManager.getInfoTreasure(v2.MibaoId)
								if dbTreasure1.Star == dbTreasure2.Star then
									if v1.Lv == v2.Lv then
										if v1.MibaoId == v2.MibaoId then
											return v1.Id < v2.Id
										else
											return v1.MibaoId < v2.MibaoId
										end
									else
										return v1.Lv > v2.Lv
									end
								else
									return dbTreasure1.Star > dbTreasure2.Star
								end	
							else
								return on1
							end
						end)
						param.treasureList = tempList
						param.updateTreasureEvent = function ( newTreasureId )
							self:send(netModel.getModelMibaoEquip(newTreasureId, self.petIndexSelected), function ( data )
								if data and data.D then
									mibaoFunc.updateMibaoList(data.D.Mibaos)
									if data.D.Pets then
										for k,v in pairs(data.D.Pets) do
											petFunc.setPet(v)
										end
										
										for k,v in pairs(data.D.Pets) do
											if v.Id == nPetId then
												self:updatePetInfo(v)
												break
											end
										end
									end	
									self:updateTeamInfo(true)
									self:updatePetInfoWithIndex(self.petIndexSelected)
								end
							end)
						end
						GleeCore:showLayer("DTreasureChose", param)
					else
						self:toast(res.locString("Team$NoMibaoCanSelect"))
					end
				end
			end
		end)

		treasure["treasureAnimBase"] = ElfNode:create()
		treasure[1]:addChild(treasure["treasureAnimBase"])

		table.insert(self.treasureNodeSet, treasure)
		treasure[1]:setVisible(self.treasureUnLock)
	end
end

function CTeam:updatePetInfo( nPet )
	local dbPet = nPet and dbManager.getCharactor(nPet.PetId) or nil
	self._bg_ftpos4:setVisible(dbPet ~= nil)
	if dbPet then
		self._bg_ftpos4_canImproveRedPoint:setVisible(self:petCanImprove(nPet.Id))

		local gemList = self:getGemListWithPetId(nPet.Id)
		local gemUnLock = gameFunc.getGemInfo().getGemCountUnLock() > 0
		self._bg_ftpos4_layoutGem:setVisible( gemUnLock )
		self._bg_ftpos4_btnGem:setVisible(self:isMyTeam() and gemUnLock)
		if gemUnLock then
			local gemCount = self:getGemCountUnLock()
			for i=1,4 do
				if gemList and i <= #gemList then
					res.setNodeWithGem( self[string.format("_bg_ftpos4_layoutGem_icon%d", i)], gemList[i].GemId, gemList[i].Lv )
				else
					self:setGem(self[string.format("_bg_ftpos4_layoutGem_icon%d", i)], i <= gemCount)
				end
			end
		end
		self._bg_ftpos4_btnGem:setListener(function ( ... )
			GleeCore:showLayer("DPetFoster", {pet=nPet,petids=self:getSwipPagesIdList(),tab='TLPetGem'})
		end)

		self._bg_ftpos4_lyt_career:setResid(res.getPetCareerIcon(dbPet.atk_method_system))
		self._bg_ftpos4_lyt_name:setString(res.getPetNameWithSuffix(nPet))
		require 'PetNodeHelper'.updateStarLayout(self._bg_ftpos4_starLayout, dbPet)
		
		self:updateEquip(nPet.Id)
		self:updateTreasure(nPet.Id)

		---------------------------------------
		self._bg_ftpos4_layoutBar:removeAllChildrenWithCleanup(true)
		local Bar1Set = self:createLuaSet("@Bar1")
		self._bg_ftpos4_layoutBar:addChild(Bar1Set[1])
		Bar1Set["layoutQuality_value"]:setString(dbPet.quality)
		Bar1Set["layoutPower_value"]:setString(nPet.Power)
		Bar1Set["layoutHp_value"]:setString(nPet.Hp)
		Bar1Set["layoutAtk_value"]:setString(nPet.Atk)
		Bar1Set["layoutLv_value"]:setString(string.format("%d/%d", nPet.Lv, dbManager.getPetLvCap(nPet)))
		Bar1Set["lv1_lv2"]:setPercentage(nPet.Lv * 100 / dbManager.getPetLvCap(nPet))
		Bar1Set["lv1_lv3"]:stopAllActions()
		if nPet.Lv >= dbManager.getPetLvCap(nPet) then
			Bar1Set["lv1_lv3"]:setVisible(true)
			Bar1Set["lv1_lv3"]:runAction(res.getFadeAction(1))
		else
			Bar1Set["lv1_lv3"]:setVisible(false)
		end
		Bar1Set["btn"]:setListener(function ( ... )
			self:doPetDetailEvent()
		end)

		------
		if dbPet.ev_pet ~= nil then
			local sepeSet = self:createLuaSet("@sepe")
			self._bg_ftpos4_layoutBar:addChild(sepeSet[1])

			local Bar2Set = self:createLuaSet("@Bar2")
			self._bg_ftpos4_layoutBar:addChild(Bar2Set[1])
			Bar2Set["layoutEvolve"]:removeAllChildrenWithCleanup(true)

			local list = dbManager.getSkinPetList( dbPet.skin_id )
			if list and #list > 1 then
				table.sort(list, function ( a, b )
					if a.evove_level == b.evove_level then
						return a.id < b.id
					else
						return a.evove_level < b.evove_level
					end
				end)

				for i,v in ipairs(list) do
					if i > 1 and v.evove_level == list[i-1].evove_level then
						break
					end
					if v.ev_lv and v.ev_lv >= 200 then -- mega进化精灵屏蔽
						break
					end
					local evolveArrowSet
					if v.evove_level > 1 then
						evolveArrowSet = self:createLuaSet("@evolveArrow")
						Bar2Set["layoutEvolve"]:addChild(evolveArrowSet[1])
					end
					local evolvePetSet = self:createLuaSet("@evolvePet")
					Bar2Set["layoutEvolve"]:addChild(evolvePetSet[1])
					
					if dbPet.evove_level >= v.evove_level then
						res.setNodeWithPet(evolvePetSet["icon"], petFunc.getPetInfoByPetId(v.id))
					elseif dbPet.ev_pet[1] == v.id then
						local nodeList = res.setNodeWithPet(evolvePetSet["icon"], petFunc.getPetInfoByPetId(v.id))
						for i,v in ipairs(nodeList) do
							v:stopAllActions()
							v:runAction(res.getTintActionDuration(1, 0.5, 0.5, 0.5, 1, 1, 1))
						end
						evolveArrowSet["a1"]:stopAllActions()
						evolveArrowSet["a1"]:runAction(res.getTintActionDuration(1, 0.5, 0.5, 0.5, 1, 1, 1))
						evolveArrowSet["a2"]:stopAllActions()
						evolveArrowSet["a2"]:runAction(res.getTintActionDuration(1, 0.5, 0.5, 0.5, 1, 1, 1))
					else
						evolveArrowSet["a1"]:setColorf(0.5, 0.5, 0.5, 1)
						evolveArrowSet["a2"]:setColorf(0.5, 0.5, 0.5, 1)
						local nodeList = res.setNodeWithPet(evolvePetSet["icon"], petFunc.getPetInfoByPetId(v.id))
						for i,v in ipairs(nodeList) do
							nodeList[i]:setColorf(0.5, 0.5, 0.5, 1)
						end
					end
				end
			end
			Bar2Set["layoutEvolve"]:layout()
			local size = Bar2Set["layoutEvolve"]:getContentSize()
			local size0 = Bar2Set[1]:getContentSize()
			Bar2Set[1]:setContentSize(CCSize(size.width + 20, size0.height))

			Bar2Set["btn"]:setContentSize(CCSize(size.width + 20, size0.height))
			Bar2Set["btn"]:setVisible(self:isMyTeam())
			Bar2Set["btn"]:setListener(function ( ... )
				GleeCore:showLayer("DEvolvePre", {nPetId = self:getPetIdSelected()})
			end)
		end

		------
		if dbPet.relate_arr and #dbPet.relate_arr > 0 then
			local sepeSet = self:createLuaSet("@sepe")
			self._bg_ftpos4_layoutBar:addChild(sepeSet[1])

			local Bar3Set = self:createLuaSet("@Bar3")
			self._bg_ftpos4_layoutBar:addChild(Bar3Set[1])
			local count = 0
			local fetterPetIdListWithPartners = self:getFetterPetIdListWithPartners()
			for i,v in ipairs(dbPet.relate_arr) do
				if gameFunc.fetterIsActive(dbManager.getInfoFetterConfig(v), fetterPetIdListWithPartners) == true then
					count = count + 1
				end
			end
			Bar3Set["fetterTitle_layoutFetter"]:removeAllChildrenWithCleanup(true)
			for i=1,#dbPet.relate_arr do
				local fetterGirdSet = self:createLuaSet("@fetterGird")
				Bar3Set["fetterTitle_layoutFetter"]:addChild(fetterGirdSet[1])
				if i <= count then
					fetterGirdSet[1]:setResid("N_TY_jiban1.png")
					fetterGirdSet["highLight"]:setVisible(true)
					fetterGirdSet["highLight"]:stopAllActions()
					fetterGirdSet["highLight"]:runAction(res.getFadeAction(1))
				else
					fetterGirdSet[1]:setResid("N_TY_jiban2.png")
					fetterGirdSet["highLight"]:setVisible(false)
					fetterGirdSet["highLight"]:stopAllActions()
				end
			end

			Bar3Set["btn"]:setListener(function ( ... )
				self:doFetterEvent()
			end)
		end
	else
		self:updateEquip(-1)
		self:updateTreasure(-1)
	end
end

function CTeam:updateTeamInfo( justSwitch )
	local teamInfo = self:getTeamSelected()
	if teamInfo then
		print("updateTeamInfo:")
		print(teamInfo)
		self._bg_ftpos_teamPowerTitle:setString(string.format(res.locString("Team$TeamPowerTItle"), self.teamSelected))
		if self:isMyTeam() then
			self._bg_ftpos_teamPower:setString(teamFunc.getTeamCombatPower())
		else
			self._bg_ftpos_teamPower:setString(self:getTeamSelected().CombatPower)
		end
		for i,petSet in ipairs(self.teamNodeSet) do
			petSet[1]:setScale(i == self.petIndexSelected and 0.65 or 0.55)
			petSet["point"]:setScale(1 / petSet[1]:getScale())
			petSet["highLight"]:setVisible(i == self.petIndexSelected)
			if i == #self.teamNodeSet then		-- 替补
				petSet["starLayout"]:removeAllChildrenWithCleanup(true)
				if teamInfo.BenchPetId > 0 then
					local nPet = self:getPetInfo(teamInfo.BenchPetId)
					local dbPet = dbManager.getCharactor(nPet.PetId)
					self:setPet(petSet["icon"], nPet)
					-- for i=1,dbPet.star_level do
					-- 	local starSmall = self:createLuaSet("@starSmall")
					-- 	petSet["starLayout"]:addChild(starSmall[1])
					-- end
					require 'PetNodeHelper'.updateStarLayout(petSet["starLayout"], dbPet)
				else
					self:setPet(petSet["icon"], nil, true)
				end
				petSet["btn"]:setVisible(true)
				petSet["titleIcon"]:setResid("TY_tibu_1.png")
			else
				petSet["starLayout"]:removeAllChildrenWithCleanup(true)
				if i <= #teamInfo.PetIdList then
					local nPet = self:getPetInfo(teamInfo.PetIdList[i])
					local dbPet = dbManager.getCharactor(nPet.PetId)
					self:setPet(petSet["icon"], nPet)
					petSet["btn"]:setVisible(true)
					-- for i=1,dbPet.star_level do
					-- 	local starSmall = self:createLuaSet("@starSmall")
					-- 	petSet["starLayout"]:addChild(starSmall[1])
					-- end
					require 'PetNodeHelper'.updateStarLayout(petSet["starLayout"], dbPet)
				elseif i == #teamInfo.PetIdList + 1 then
					self:setPet(petSet["icon"], nil, true)
					petSet["btn"]:setVisible(self:isMyTeam())
				else
					self:setPet(petSet["icon"], nil, false)
					petSet["btn"]:setVisible(false)
				end
				if i == 1 then
					petSet["titleIcon"]:setResid("TY_duiwu_1.png")
				else
					petSet["titleIcon"]:setResid("")
				end
			end
		end

		self:updatePetPoint()
		self:updateHonor()
	end
	self:updateSwipPages( justSwitch )
end

function CTeam:setPet( node, petInfo, showAdd )
	if petInfo then
		res.setNodeWithPet(node, petInfo)
	else
		node:removeAllChildrenWithCleanup(true)
		if showAdd then
			node:setResid("N_DW_touxiang.png")
		else
			node:setResid("N_DW_wsz2.png")
		end
	end
end

function CTeam:setGem( node, isUnlock )
	node:setResid("")
	node:removeAllChildrenWithCleanup(true)

	local bg = ElfNode:create()
	bg:setResid("N_ZB_biankuang_bg.png")
	node:addChild(bg)

	local icon = ElfNode:create()
	if isUnlock then
		icon:setResid("N_XLTC_jia.png")
	else
		icon:setResid("N_XLTC_suo.png")
	end
	node:addChild(icon)

	local frame = ElfNode:create()
	frame:setResid("N_ZB_biankuang0.png")
	node:addChild(frame)
end

function CTeam:setPetPartner( node, petInfo )
	if petInfo then
		res.setNodeWithPet(node, petInfo)
	else
		node:setResid("N_DW_xiaohuoban_kuang1.png")
	end
end

function CTeam:setIconLock( node )
	node:removeAllChildrenWithCleanup(true)
	node:setResid("")

	local nodeBg = ElfNode:create()
	nodeBg:setResid("N_DW_xiaohuoban_kuang2.png")
	node:addChild(nodeBg)	

	local nodeIcon = ElfNode:create()
	nodeIcon:setResid("N_DW_xiaohuoban_kuang3.png")
	node:addChild(nodeIcon)	
end

function CTeam:setEquip( nodeSet, nEquip, location, petId )
	local dbEquip
	if nEquip then	
		dbEquip = dbManager.getInfoEquipment(nEquip.EquipmentId)
		res.setNodeWithEquipLv(nodeSet["icon"], dbEquip)
	else
		nodeSet["icon"]:removeAllChildrenWithCleanup(true)
		nodeSet["icon"]:setResid(res.getEquipIconBgWithLocation(location))
	end
	nodeSet["add"]:setVisible(nEquip == nil)
	nodeSet["point"]:setVisible(false)
	if petId > 0 and self:isMyTeam() then
		local petIdActiveList = teamFunc.getPetIdListWithBench()
		local tempList = equipFunc.selectByCondition(function ( v )
			if dbManager.getInfoEquipment(v.EquipmentId).location~=location then
				return false
			end
			local nPet = equipFunc.getPetEquippedOn(v.SetIn)
			if nPet then
				if nPet.Id == petId then
					return false
				else
					if table.find(petIdActiveList, nPet.Id) then
						return false
					else
						if nEquip then
							if dbEquip.color >= dbManager.getInfoEquipment(v.EquipmentId).color then
								return false
							end
						end
					end
				end
			else
				if nEquip then
					if dbEquip.color >= dbManager.getInfoEquipment(v.EquipmentId).color then
						return false
					end
				end
			end
			return true
		end)
		if tempList and #tempList > 0 then
			nodeSet["point"]:setVisible(true)
		end
	end
end

function CTeam:loadEquipOneKey(  )
	local nPetId = self:getPetIdSelected()
	local nPet = self:getPetInfo(nPetId)
	local dbPet = dbManager.getCharactor(nPet.PetId)
	local petIdActiveList = teamFunc.getPetIdListWithBench()

	local function compareTwoEquip( v1, v2 )
		local dbEquip1 = dbManager.getInfoEquipment(v1.EquipmentId)
		local dbEquip2 = dbManager.getInfoEquipment(v2.EquipmentId)
		if dbEquip1.color == dbEquip2.color then
			local b1 = dbEquip1.career == dbPet.atk_method_system
			local b2 = dbEquip2.career == dbPet.atk_method_system
			if b1 == b2 then
				if dbEquip1.set == dbEquip2.set then
					if v1.Lv == v2.Lv then
						return v1.Id < v2.Id
					else
						return v1.Lv > v2.Lv
					end
				else
					return dbEquip1.set > dbEquip2.set
				end
			else
				return b1
			end
		else
			return dbEquip1.color > dbEquip2.color
		end
	end

	local function getBestEquipList( location, nEquip )
		return equipFunc.selectByCondition(function ( v )
			if dbManager.getInfoEquipment(v.EquipmentId).location~=location then
				return false
			end
			local nPet = equipFunc.getPetEquippedOn(v.SetIn)
			if nPet then
				if nPet.Id == nPetId then
					return true
				else
					if table.find(petIdActiveList, nPet.Id) then
						return false
					else
						if nEquip then
							return compareTwoEquip(v, nEquip)
						end
					end
				end
			else
				if nEquip then
					return compareTwoEquip(v, nEquip)
				end
			end
			return true
		end)
	end

	local needNetWork = false
	local list = {}
	for i,v in ipairs(self.equipsNodeSet) do
		local nEquip = self:getEquipWithLocation(nPetId, i)
		local tempList = getBestEquipList(i, nEquip)
		print(tempList)
		if tempList and #tempList > 0 then
			table.sort(tempList, function ( v1, v2 )
				if v1 and v2 then
					return compareTwoEquip(v1, v2)
				end
			end)
			table.insert(list, tempList[1].Id)

			if not needNetWork then
				if nEquip then
					if nEquip.Id ~= tempList[1].Id then
						needNetWork = true
					end
				else
					needNetWork = true
				end
			end
		end
	end
	if needNetWork and list and #list > 0 then
		self:send(netModel.getModelEqChangeOk(self.petIndexSelected, list, teamFunc.getTeamActiveId()), function ( data )
			print("EqChangeOk:")
			print(data)
			if data and data.D then
				if data.D.OldEqs then
					for i,v in ipairs(data.D.OldEqs) do
						equipFunc.setEquipWithId(v)
					end
				end
				if data.D.NewEqs then
					for i,v in ipairs(data.D.NewEqs) do
						equipFunc.setEquipWithId(v)
					end
				end
				if data.D.Pet then
					petFunc.setPet(data.D.Pet)
					self:updatePetInfo(data.D.Pet)
				end
				self:updateTeamInfo(true)
				self:updatePetInfoWithIndex(self.petIndexSelected)
				GuideHelper:check('EquipOn')
			end
		end)
	else
		self:toast(res.locString("Team$NoEquipSuitForMe"))
	end
end

function CTeam:getSwipPagesIdList(  )
	local result = {}
	local teamInfo = self:getTeamSelected()
	if teamInfo and teamInfo.PetIdList then
		for i,v in ipairs(teamInfo.PetIdList) do
			table.insert(result, v)
		end
		if #result < 5 then
			table.insert(result, 0)
		end
		table.insert(result, teamInfo.BenchPetId)
	--	table.insert(result, -1) -- 用于判断是否是小伙伴的页面
	end
	return result
end

function CTeam:getFetterPetIdList(  )
	local result = {}
	local teamInfo = self:getTeamSelected()
	if teamInfo then
		if teamInfo.PetIdList then
			for i,v in ipairs(teamInfo.PetIdList) do
				table.insert(result, v)
			end
		end
		if teamInfo.BenchPetId > 0 then
			table.insert(result, teamInfo.BenchPetId)
		end
	end
	return result
end

-- justSwitch == true时表示仅仅切换页面，没有重建的过程
function CTeam:updateSwipPages( justSwitch )
	if not justSwitch then
		self._bg_clipSwip_petSwip_linearlayout:removeAllChildrenWithCleanup(true)
		self._bg_clipSwip_petSwip:clearStayPoints()

		local list = self:getSwipPagesIdList()

		for i,v in ipairs(list) do
			if v > 0 then
				local page = self:createLuaSet("@page")
				self._bg_clipSwip_petSwip_linearlayout:addChild(page[1])			
				local nPet = self:getPetInfo(v)
				
				res.adjustPetIconPositionInParentLT(page[1],page['img'],nPet.PetId,'troop')

				page["addPetTip"]:setVisible(false)
				page["btn"]:setEnabled(self:isMyTeam())
				page["btn"]:setListener(function (  )
					GleeCore:showLayer('DPetFoster',{pet=nPet,petids=self:getSwipPagesIdList()})
					self._bg_clipSwip_petSwip:goToNewStayIndex(self:getPageIndex(self.petIndexSelected))
				end)
			elseif v == 0 then
				local page = self:createLuaSet("@page")
				self._bg_clipSwip_petSwip_linearlayout:addChild(page[1])
				page["img"]:setResid("DW_renwujianying.png")
				page["addPetTip"]:setVisible(true)
				page["btn"]:setListener(function (  )
					local param = {}
					param.needRemove = self:getPetIdListNeedRemove(0, false)
					local positionId = self.petIndexSelected
					param.funcChosePet = function ( newPetId )
						if self:canSetInTeam(newPetId, 0, false) then
							self:chosePet( 0, newPetId, positionId )
							return true
						else
							return false
						end
					end
					param.sortFunc = function ( list )
						petFunc.sortWithTeam(list, self:getPetIdListSetIn())
					end
					GleeCore:showLayer("DPetChose", param)
					self._bg_clipSwip_petSwip:goToNewStayIndex(self:getPageIndex(self.petIndexSelected))
				end)
				page["btn"]:setEnabled(self:isMyTeam())
			else  -- partner
				local pagePartner = self:createLuaSet("@pagePartner")
				self._bg_clipSwip_petSwip_linearlayout:addChild(pagePartner[1])
				self.pagePartnerSet = pagePartner 

				local function updateFetterPage( ... )
					local partnerList = self:getPartner(self.teamSelected)
					print("partnerList(" .. tostring(self.teamSelected) .. "):")
					print(partnerList)
					pagePartner["partnerIconSet"]:removeAllChildrenWithCleanup(true)
					local unLockedCount = #partnerList
					for j=1,6 do
						local partner = self:createLuaSet(string.format("@partner%d", j))
						pagePartner["partnerIconSet"]:addChild(partner[1])
						if j <= unLockedCount then
							if partnerList[j].PetId > 0 then
								local nPet = self:getPetInfo(partnerList[j].PetId)
								self:setPetPartner(partner["icon"], nPet)
								local dbPet = dbManager.getCharactor(nPet.PetId)
								partner["name"]:setString(res.getPetNameWithSuffix(nPet))
							--	partner["name"]:setFontFillColor(res.getRankColorByAwake(nPet.AwakeIndex), true)
							else
								self:setPetPartner(partner["icon"])
								partner["name"]:setString(res.locString("Team$AddPetTip"))
								partner["name"]:setVisible(self:isMyTeam())
							end

							partner["btn"]:setEnabled(self:isMyTeam())
							partner["btn"]:setListener(function (  )	
								local param = {}
								param.offloadPetId = partnerList[j].PetId
								param.needRemove = self:getPetIdListNeedRemove(partnerList[j].PetId, true)
								param.funcChosePet = function ( newPetId )
									if newPetId == param.offloadPetId then
										newPetId = 0
									end
									if self:canSetInTeam(newPetId, partnerList[j].PetId, true) then
										print("选择小伙伴nPet.Id = " .. tostring(newPetId) .. " , j = " .. tostring(j))
										self:send(netModel.getModelPartnerUpdate(j, newPetId, self.teamSelected), function ( data )
											print("PartnerUpdate:")
											print(data)
											if data and data.D then
												if data.D.Pets then
													for k,v in pairs(data.D.Pets) do
														petFunc.setPet(v)
													end
												end
												if data.D.Partners then
													partnerFunc.setPartnerListWithTeamIndex(data.D.Partners)
													updateFetterPage()
												end
											end
										end)
										return true
									else
										return false
									end
								end
								param.sortFunc = function ( list )
									petFunc.sortWithTeam(list, self:getPetIdListSetIn())
								end
								GleeCore:showLayer("DPetChose", param)
							end)
						elseif j == unLockedCount + 1 then -- 需要解锁
							self:setIconLock(partner["icon"])
							partner["name"]:setString(res.locString("Dungeon$TouchUnlock"))
							partner["name"]:setVisible(self:isMyTeam())
							partner["btn"]:setEnabled(self:isMyTeam())
							partner["btn"]:setListener(function (  )
								local dbPartner = dbManager.getInfoPartner(j)
								local param = {}
								param.content = string.format(res.locString("Dungeon$UnlockContent"), dbPartner.Cost)
								param.callback = function ( ... )
									local userFunc = gameFunc.getUserInfo()
									if userFunc.getCoin() >= dbPartner.Cost then
										self:send(netModel.getModelPartnerOpen(j), function ( data )
											print("PartnerOpen:")
											print(data)
											if data and data.D then
												if data.D.Role then
													userFunc.setCoin(data.D.Role.Coin)
												end

												if data.D.Partners then
													partnerFunc.setPartnerList(data.D.Partners)

													local delta = 0.1
													local originx, originy = 0, 0
													local actArray = CCArray:create()
													actArray:addObject(CCMoveTo:create(0, ccp(originx, originy)))
													actArray:addObject(CCMoveTo:create(delta, ccp(originx, originy + 10)))
													actArray:addObject(CCMoveTo:create(delta, ccp(originx, originy - 8)))
													actArray:addObject(CCMoveTo:create(delta, ccp(originx - 8, originy)))
													actArray:addObject(CCMoveTo:create(delta, ccp(originx + 8, originy)))
													actArray:addObject(CCMoveTo:create(delta, ccp(originx - 4, originy)))
													actArray:addObject(CCMoveTo:create(delta, ccp(originx, originy)))
													actArray:addObject(CCDelayTime:create(delta))
													actArray:addObject(CCHide:create())
													actArray:addObject(CCCallFunc:create(function ( ... )
														partner["unLockAnim"]:setLoops(1)
														partner["unLockAnim"]:setListener(function (  )
															partner["btn"]:setEnabled(true)
															updateFetterPage()
														end)
														partner["unLockAnim"]:start()
													end))

													local lockNode = tolua.cast(partner["icon"]:getChildren():objectAtIndex(1), "ElfNode") 
													lockNode:runAction(CCSequence:create(actArray))
													partner["btn"]:setEnabled(false)
													require 'framework.helper.MusicHelper'.playEffect(res.Sound.ui_sfx_unlock)
												end
											end
										end)
									else
										require "Toolkit".showDialogOnCoinNotEnough()
									end
								end
								GleeCore:showLayer("DConfirmNT", param)
							end)
						else
							self:setIconLock(partner["icon"])
							partner["name"]:setString("")
						end
					end

					-- 羁绊
					local container = pagePartner["bg_list"]:getContainer()
					container:removeAllChildrenWithCleanup(true)
					local fetterPetList = self:getFetterPetIdList()
					if fetterPetList and #fetterPetList > 0 then
						local fetterIndex = 0
						local fetterPetIdListWithPartners = self:getFetterPetIdListWithPartners()
						for m,value in ipairs(fetterPetList) do
							local nPet = self:getPetInfo(value)
							local dbPet = dbManager.getCharactor(nPet.PetId)

							if dbPet.relate_arr and #dbPet.relate_arr > 0 then
								if fetterIndex ~= 0 then
									local sepName = self:createLuaSet("@sepName")
									container:addChild(sepName[1])	
								end
								fetterIndex = fetterIndex + 1
								
								local petTitle = self:createLuaSet("@petTitle")
								container:addChild(petTitle[1])
								petTitle["name"]:setString(dbPet.name)

								for i,v in ipairs(dbPet.relate_arr) do
									if i ~= 1 then
										local sep = self:createLuaSet("@sep")
										container:addChild(sep[1])
									end
									local fetterTable = dbManager.getInfoFetterConfig(v)
									local text = self:createLuaSet("@desText")
									container:addChild(text[1])
									text["des"]:setString(fetterTable.Description)
								--	
									if gameFunc.fetterIsActive(fetterTable, fetterPetIdListWithPartners) == true then
										text["des"]:setFontFillColor(ccc4f(0.569, 0.863, 0.373, 1.0), true)
										text["point"]:setResid("N_JLXQ_17.png")
									else
										text["des"]:setFontFillColor(ccc4f(0.867, 0.75, 0.624, 1.0), true)
										text["point"]:setResid("N_JLXQ_19.png")
									end
									text[1]:setContentSize(CCSize(text[1]:getWidth(), text["des"]:getHeight()))
									text["point"]:setPosition(ccp(text["point"]:getPosition(), text[1]:getHeight() / 2 - 12))
								end
							end
						end
					else
						local none = self:createLuaSet("@none")
						container:addChild(none[1])
					end
				end

				if not self.runDelayNode then
					self.runDelayNode = ElfNode:create()
					self:getLayer():addChild(self.runDelayNode)
				end
				self.runDelayNode:stopAllActions()
				self:runWithDelay(function ( ... )
					updateFetterPage()
				end, 0.5, self.runDelayNode)	
			end
			self._bg_clipSwip_petSwip:addStayPoint(-1136 * (i - 1), 0) -- page宽度必须保证1136，而不是屏幕宽度
		end

		self:updatePageIndexList()	
	end
	self._bg_clipSwip_petSwip:setStayIndex(self:getPageIndex(self.petIndexSelected))
end

function CTeam:updatePageIndexList(  )
	self.pageIndexList = {}
	local teamInfo = self:getTeamSelected()
	local pageIndex = 1
	for i=1,memberMaxCount do
		if i <= #teamInfo.PetIdList + 1 or i >= memberMaxCount then
			table.insert(self.pageIndexList, pageIndex)
			pageIndex = pageIndex + 1
		else
			table.insert(self.pageIndexList, 0)
		end
	end
end

function CTeam:getPageIndex( petIndex )
	return self.pageIndexList[petIndex ] - 1
end

function CTeam:getPetIndex( pageIndex )
	for i,v in ipairs(self.pageIndexList) do
		if v == pageIndex then
			return i
		end
	end
	return 0
end

function CTeam:updatePetInfoWithIndex( index )
	local nPetId = self:getPetIdSelected()
	if nPetId > 0 then
		self:updatePetInfo(self:getPetInfo(nPetId))
	else
		self:updatePetInfo(nil)
	end

	self._bg_ftpos3_btnFetter:setVisible(nPetId > 0)
	self._bg_ftpos3_btnPetDetail:setVisible(nPetId > 0)
	self._bg_ftpos3_btnPetChange:setVisible(self:isMyTeam() and nPetId > 0)
	self._bg_ftpos3_btnChangeEquipOneKey:setVisible(self:isMyTeam() and nPetId > 0)

	local dbPet = nPetId > 0 and dbManager.getCharactor(self:getPetInfo(nPetId).PetId) or nil
	self._bg_ftpos3_btnEvolve:setVisible(self:isMyTeam() and nPetId > 0 and dbPet.ev_pet ~= nil)

	self._bg_ftpos3_btnImproveEquipOneKey:setVisible(self:isMyTeam() and unLockManager:isUnlock("OneKeyEquipUp") and nPetId > 0)
end

-- function CTeam:updateBenchSkillInfo(index, nPetId )
-- 	local function showSkillDetail( node,skillitem , cost)
-- 		local nodePos = NodeHelper:getPositionInScreen(node)
-- 		GleeCore:showLayer('DSkillInfo',{skillitem=skillitem,cost=cost,point=nodePos,align=4,offset= 50})
-- 	end

-- 	local teamInfo = self:getTeamSelected()
-- 	self._bg_topBar_ftpos_bg2:setVisible(teamInfo.BenchPetId > 0 and teamInfo.BenchPetId == nPetId)
-- 	if teamInfo.BenchPetId > 0 and teamInfo.BenchPetId == nPetId then
-- 		self._bg_topBar_ftpos_bg2_none:setVisible(nPetId > 0)
-- 		self._bg_topBar_ftpos_bg2_skill:setVisible(nPetId > 0)
-- 		if nPetId > 0 then
-- 			local canFind = false
-- 			local nPet = self:getPetInfo(nPetId)
-- 			local dbPet = dbManager.getCharactor(nPet.PetId)
-- 			local unlockcount = res.getAbilityUnlockCount(nPet.AwakeIndex,nPet.Star)
-- 			for i=1,#dbPet.abilityarray do
-- 				if dbPet.abilityarray[i]  >= 8000 and dbPet.abilityarray[i] <= 10000 then
-- 					canFind = true
-- 					local skillitem = dbManager.getInfoSkill(dbPet.abilityarray[i])
-- 					local skillName = skillitem.name
-- 					if unlockcount >= i then --已解锁
-- 						self._bg_topBar_ftpos_bg2_skill:setResid("JLXQ_jineng2.png")
-- 						self._bg_topBar_ftpos_bg2_skill_title:setString(skillName)
-- 						if string.len(skillName) < 15 then
-- 							self._bg_topBar_ftpos_bg2_skill_title:setDimensions(CCSize(46, 0))
-- 						else
-- 							self._bg_topBar_ftpos_bg2_skill_title:setDimensions(CCSize(70, 0))
-- 						end
-- 						self._bg_topBar_ftpos_bg2_skill_btn:setListener(function (  )
-- 							showSkillDetail(self._bg_topBar_ftpos_bg2_skill_btn, skillitem)
-- 						end)
-- 					else --没有解锁
-- 						skillitem.abilityIndex = i
-- 						self._bg_topBar_ftpos_bg2_skill_title:setString("")
-- 						self._bg_topBar_ftpos_bg2_skill:setResid("JLXQ_jineng3.png")
-- 						self._bg_topBar_ftpos_bg2_skill_btn:setListener(function (  )
-- 							showSkillDetail(self._bg_topBar_ftpos_bg2_skill_btn, skillitem)
-- 						end)
-- 					end
-- 					break
-- 				end
-- 			end

-- 			self._bg_topBar_ftpos_bg2_none:setVisible(not canFind)
-- 			self._bg_topBar_ftpos_bg2_skill:setVisible(canFind)
-- 		end
-- 	end
-- end

function CTeam:updateEquip( nPetId )
	if not self.equipUnLock then
		do return end
	end

	for i,v in ipairs(self.equipsNodeSet) do
		local nodeSet = v
		local nEquip = self:getEquipWithLocation(nPetId, i)
		if nEquip then
			self:setEquip(nodeSet, nEquip, i, nPetId)
			nodeSet["lv"]:setVisible(true)
			nodeSet["lv"]:setString(string.format("%d", nEquip.Lv))

			local dbEquip = dbManager.getInfoEquipment(nEquip.EquipmentId)

			if unLockManager:isUnlock("EquipReset") then
				nodeSet["rankDes"]:setString(res.getEquipRankTextSimple(nEquip.Rank))
				nodeSet["rankDes"]:setFontFillColor(res.getEquipRankColor( nEquip.Rank ), true)
			else
				nodeSet["rankDes"]:setString("")
			end

			if nEquip.Tp > 0 then
				nodeSet["name"]:setString(string.format("%s +%d", dbEquip.name, nEquip.Tp))
			else
				nodeSet["name"]:setString(dbEquip.name)
			end

			nodeSet["isSuit"]:setVisible(self:equipSetIsEffect(nEquip))

			local runeUnlock = require "Toolkit".isRuneMosaicEnable(dbEquip.location) and require "UnlockManager":isUnlock("GuildCopyLv")
			nodeSet["rune"]:setVisible(runeUnlock)
			if runeUnlock then
				local runeList = self:getRuneListWithEquipId( nEquip.Id )
				res.setNodeWithRuneSetIn(nodeSet["rune"], runeList)
			end			
		else
			self:setEquip(nodeSet, nil, i, nPetId)
			
			nodeSet["lv"]:setVisible(false)
			nodeSet["rankDes"]:setString("")
			nodeSet["name"]:setString("")
			nodeSet["isSuit"]:setVisible(false)
			nodeSet["rune"]:setVisible(false)
		end
	end
end

function CTeam:updateTreasure( nPetId )
	if not self.treasureUnLock then
		do return end
	end

	for i,nodeSet in ipairs(self.treasureNodeSet) do
		local nTreasure = self:getTreasureWithType(nPetId, i)
		local dbTreasure = nTreasure and dbManager.getInfoTreasure(nTreasure.MibaoId) or nil
		nodeSet["treasureAnimBase"]:removeAllChildrenWithCleanup(true)
		if nTreasure then
			nodeSet["icon"]:setResid( string.format("mibao_%d.png", dbTreasure.Id) )
			nodeSet["icon"]:setScale(0.5)
			nodeSet["frame"]:setVisible(true)
			nodeSet["frame"]:setScale(0.5)
			nodeSet["frame"]:setResid(string.format("PZ%d_dengji.png", math.max(dbTreasure.Star - 1, 1)))
			nodeSet["lv"]:setVisible(true)
			nodeSet["lv"]:setString(nTreasure.Lv)
			nodeSet["name"]:setVisible(true)
			nodeSet["name"]:setString(require "Toolkit".getMibaoName( nTreasure ))
			res.addTreasureAnim(nodeSet["treasureAnimBase"], nTreasure)
			nodeSet["treasureAnimBase"]:setScale( 0.5 )
		else
			nodeSet["icon"]:setResid(string.format("N_ZB_mibao%d.png", i == 1 and 2 or 1))
			nodeSet["icon"]:setScale(1.0)
			nodeSet["frame"]:setVisible(false)
			nodeSet["lv"]:setVisible(false)
			nodeSet["name"]:setVisible(false)
		end
		nodeSet["point"]:setVisible(false)
		if nPetId > 0 and self:isMyTeam() then
			local petIdActiveList = teamFunc.getPetIdListWithBench()
			local tempList = mibaoFunc.selectByCondition(function ( v )
				if dbManager.getInfoTreasure(v.MibaoId).Type ~= i then
					return false
				end
				local nPet = mibaoFunc.getPetMibaoPutOn(v.SetIn)
				if nPet then
					if nPet.Id == nPetId then
						return false
					else
						if table.find(petIdActiveList, nPet.Id) then
							return false
						else
							if nTreasure then
								if dbTreasure.Star >= dbManager.getInfoTreasure(v.MibaoId).Star then
									return false
								end
							end
						end
					end
				else
					if nTreasure then
						if dbTreasure.Star >= dbManager.getInfoTreasure(v.MibaoId).Star then
							return false
						end
					end
				end
				return true
			end)
			if tempList and #tempList > 0 then
				nodeSet["point"]:setVisible(true)
			end
		end
	end
end

function CTeam:getEquipWithLocation( nPetId, location )
	local equipList
	if self:isMyTeam() then
		equipList = equipFunc.getEquipListWithPetId( nPetId )
	else
		equipList = equipFunc.getEquipListWithPetId0(nPetId, self.equipList, self.team)
	end
	for k,v in pairs(equipList) do
		local dbEquip = dbManager.getInfoEquipment(v.EquipmentId)
		if dbEquip and dbEquip.location == location then
			return v
		end
	end
	return nil
end

function CTeam:getTreasureWithType( nPetId, mibaoType )
	local treasureList
	if self:isMyTeam() then
		treasureList = mibaoFunc.getMibaoListWithPetId( nPetId )
	else
		treasureList = mibaoFunc.getMibaoListWithPetId0( nPetId, self.treasureList, self.team )
	end
	for k,v in pairs(treasureList) do
		local dbTreasure = dbManager.getInfoTreasure(v.MibaoId)
		if dbTreasure and dbTreasure.Type == mibaoType then
			return v
		end
	end
	return nil
end

function CTeam:isPetClash( dbPet, expectPetId )
	local list = self:getPetIdListSetIn()
	for i,v in ipairs(list) do
		if not (expectPetId and expectPetId == v) then
			local dbPet1 = dbManager.getCharactor(self:getPetInfo(v).PetId)
			if self:isPetClashBetween(dbPet1, dbPet) then
				return true
			end
		end
	end
	return false
end

function CTeam:isPetClashBetween( dbPet1, dbPet2 )
	return dbPet1.id == dbPet2.id or (require "PetInfo".isPetInSameBranch(dbPet2, dbPet1) and dbPet1.evove_level ~= dbPet2.evove_level)
end

function CTeam:canSetInTeam( newPetId, nPetId, isPartnerMode )
--	print("newPetId = " .. newPetId .. ", nPetId = " .. nPetId .. ", isPartnerMode = " .. tostring(isPartnerMode))
	local dbPetOld = nPetId > 0 and dbManager.getCharactor(petFunc.getPetWithId(nPetId).PetId) or nil
	local dbPet = newPetId > 0 and dbManager.getCharactor(petFunc.getPetWithId(newPetId).PetId) or nil
	if isPartnerMode then
		if newPetId == 0 then
			return true
		end
		local partnerIdList = self:getPartnerIdList()
		if partnerIdList and table.find(partnerIdList, newPetId) then
			return true
		end
	else
		if nPetId > 0 then
			if table.find(self:getFetterPetIdList(), newPetId) then
				return true
			end
		end
	end
	if self:isPetClash(dbPet, nPetId) then
		self:toast(res.locString("Team$CannotSetInTip"))
		return false
	else
		return true
	end	
end

function CTeam:getPetIdListNeedRemove( nPetId, isPartnerMode )
	if isPartnerMode then
		return self:getFetterPetIdList()
	end

	local result = self:getPartnerIdList()
	if nPetId > 0 then
		table.insert(result, 1, nPetId)
	else
		table.insertTo(result, self:getFetterPetIdList())	
	end
	return result
end

function CTeam:getPetIdListSetIn(  )
	local result = self:getFetterPetIdList()
	table.insertTo(result, self:getPartnerIdList())
	return result
end

function CTeam:isMyTeam( ... )
	return self.team == nil
end

function CTeam:getTeamSelected( ... )
	if self:isMyTeam() then
		local teamList = teamFunc.getTeamList()
		return teamList[self.teamSelected]
	else
		return self.team
	end
end

function CTeam:getPetIdSelected( ... )
	local nPetId = 0
	local teamInfo = self:getTeamSelected()
	if self.petIndexSelected == memberMaxCount then 	-- 替补
		nPetId = teamInfo.BenchPetId
	elseif self.petIndexSelected <= #teamInfo.PetIdList then	-- 拥有的精灵
		nPetId = teamInfo.PetIdList[self.petIndexSelected]
	end
	return nPetId
end

function CTeam:getPetInfo( nPetId )
	if self:isMyTeam() then
		return petFunc.getPetWithId(nPetId)
	else
		if self.petList then
			for i,v in ipairs(self.petList) do
				if v.Id == nPetId then
					return v
				end
			end
		end
	end
	return nil
end

function CTeam:getPartner( teamIndex )
	if self:isMyTeam() then
		return partnerFunc.getPartnerListWithTeamIndex(self.teamSelected)
	else
		if self.partnerList then
			local temp = {}
			for i,v in ipairs(self.partnerList) do
				if v.TeamId == teamIndex then
					table.insert(temp, v)
				end
			end	
			return temp
		end
	end
	return nil
end

function CTeam:getGemListWithPetId( nPetId )
	local gemList = {}
	if self:isMyTeam() then
		gemList = gameFunc.getGemInfo().getGemListWithPetId(nPetId)
	else
		if self.gemList and nPetId > 0 then
			for k,v in pairs(self.gemList) do
				if v.SetIn == nPetId then 
					table.insert(gemList, v)
				end
			end
		end
	end
	return gemList
end

function CTeam:getGemCountUnLock(  )
	if self:isMyTeam() then
		return gameFunc.getGemInfo().getGemCountUnLock()
	else
		if self.Lv then
			if self.Lv >= dbManager.getUnLockLvConfig("GemFubenNo4") then
				return 4
			elseif self.Lv >= dbManager.getUnLockLvConfig("GemFubenNo3") then
				return 3
			elseif self.Lv >= dbManager.getUnLockLvConfig("GemFuben") then
				return 2
			end
		end
		return 0
	end
end

function CTeam:getPartnerIdList(  )
	local result = {}
	local partnerList = self:getPartner(self.teamSelected)
	if partnerList then
		for k,v in pairs(partnerList) do
			if v.PetId > 0 then
				table.insert(result, v.PetId)
			end
		end
	end
	return result
end

function CTeam:getFetterPetIdListWithPartners( ... )
	local result = self:getFetterPetIdList()
	table.insertTo(result, self:getPartnerIdList())

	if self:isMyTeam() then
		result = petFunc.getPetIDsByIds(result)
	else
		local temp = {}
		for k,v in pairs(result) do
			local nPet =  self:getPetInfo( v )
			table.insert(temp, nPet.PetId)
		end
		result = temp
	end
	return result
end

function CTeam:equipSetIsEffect( nEquip )	
	local dbEquip = dbManager.getInfoEquipment(nEquip.EquipmentId)
	if dbEquip and dbEquip.set > 0 then
		local nPetId = equipFunc.getPetIdEquippedOn(nEquip.SetIn, self:getTeamSelected())
		if nPetId > 0 then
			local equipList
			if self:isMyTeam() then
				equipList = equipFunc.getEquipListWithPetId( nPetId )
			else
				equipList = equipFunc.getEquipListWithPetId0(nPetId, self.equipList, self.team)
			end
			if equipList then
				local count = 0
				for k,v in pairs(equipList) do
					if dbManager.getInfoEquipment(v.EquipmentId).set == dbEquip.set then
						count = count + 1
					end
				end
				if count >= 3 then
					return true
				end
			end
		end
	end
	return false
end

function CTeam:chosePet( oldPetId, newPetId, positionId )
	teamFunc.setMember(oldPetId, newPetId, positionId)
	self:send(netModel.getModelTeamUpdate(teamFunc.getTeamActive(), oldPetId, newPetId), function ( data )
		print("TeamUpdate:")
		print(data)
		if data and data.D then
			if data.D.Teams then
				teamFunc.setTeamList(data.D.Teams)
			end
			if data.D.Pets then
				for k,v in pairs(data.D.Pets) do
					petFunc.setPet(v)
				end
			end
			self:updateTeamInfo()
			self:updatePetInfoWithIndex(self.petIndexSelected)
			if GuideHelper:isGuideDone() then
				local nPet = self:getPetInfo(newPetId)
				require "Toolkit".playPetVoice( nPet.PetId )
			end
		end
	end)		
end

function CTeam:getPetPointCount( ... )
	local count = 0
	if self:isMyTeam() then
		local team = self:getTeamSelected()
		local emptyCount = 5 - #team.PetIdList
		if team.BenchPetId == 0 then
			emptyCount = emptyCount + 1
		end
		if emptyCount > 0 then
			local checkList = {}	
			if team.PetIdList and #team.PetIdList > 0 then
				for k,v in pairs(team.PetIdList) do
					table.insert(checkList, v)
				end
			end
			if team.BenchPetId > 0 then
				table.insert(checkList, team.BenchPetId)
			end
			local partnerList = self:getPartner(team.TeamId)
			if partnerList then
				for k,v in pairs(partnerList) do
					if v.PetId > 0 then
						table.insert(checkList, v.PetId)
					end
				end
			end

			local petList = petFunc.getPetList()
			for i,pet in ipairs(petList) do
				if count >= emptyCount then
					break
				end
				local petId = pet.PetId
				local canFind = false
				for k,v in pairs(checkList) do
					local nPet = petFunc.getPetWithId(v)
					if nPet and nPet.PetId == petId then
						canFind = true
						break
					end
				end
				if not canFind then
					table.insert(checkList, pet)
					count = count + 1
				end	
			end
		end
	end
	return count
end

function CTeam:updatePetPoint( ... )
	local count = self:getPetPointCount()
	local team = self:getTeamSelected()
	for i,petSet in ipairs(self.teamNodeSet) do
		if i <= #team.PetIdList then
			petSet["point"]:setVisible(self:petCanImprove(team.PetIdList[i]))
		elseif i == memberMaxCount and team.BenchPetId > 0 then
			petSet["point"]:setVisible(self:petCanImprove(team.BenchPetId))
		else
			if count > 0 then
				petSet["point"]:setVisible(true)
				count = count - 1
			else
				petSet["point"]:setVisible(false)
			end
		end
	end
end

function CTeam:updateQuality( quality )
	if quality < 10 then
		self._bg_ftpos4_Quality_a:setResid(string.format("JLXY_wenzi%d.png", quality % 10))
		self._bg_ftpos4_Quality_b:setResid("")
	else
		self._bg_ftpos4_Quality_a:setResid(string.format("JLXY_wenzi%d.png", math.floor(quality / 10)))
		self._bg_ftpos4_Quality_b:setResid(string.format("JLXY_wenzi%d.png", quality % 10))
	end
end

function CTeam:doPetDetailEvent( ... )
	local nPetId = self:getPetIdSelected()
	if nPetId > 0 then
		local param = {}
		param.needRemove = self:getPetIdListNeedRemove(nPetId, false)
		local positionId = self.petIndexSelected
		param.funcChosePet = function ( newPetId )
			if self:canSetInTeam(newPetId, nPetId, false) then
				self:chosePet( nPetId, newPetId, positionId )
				return true
			else
				return false
			end
		end
		param.nPet = self:getPetInfo(nPetId) 
		if not self:isMyTeam() then
			param.isNotMine = true
		end	
		param.fetterPetIdListWithPartners = self:getFetterPetIdListWithPartners()
		param.petids = self:getSwipPagesIdList()
		param.equipments = self.equipList  -- 自己的装备为nil
		param.team = self.team  -- 自己的队伍为nil
		GleeCore:showLayer("DPetDetailV", param)
	end
end

function CTeam:doFetterEvent( ... )
	GleeCore:showLayer("DPetFetter", {
		getPetChoseData = function ( oldPetId, callback )
			local param = {}
			param.offloadPetId = oldPetId
			param.needRemove = self:getPetIdListNeedRemove(oldPetId, true)
			param.sortFunc = function ( list )
				petFunc.sortWithTeam(list, self:getPetIdListSetIn(), oldPetId, oldPetId)
			end
			param.funcChosePet = function ( newPetId )
				if newPetId == param.offloadPetId then
					newPetId = 0
				end
				if self:canSetInTeam(newPetId, oldPetId, true) then
					callback(newPetId)
					return true
				else
					return false
				end
			end
			return param
		end,
		getFetterPetIdListWithPartners = function ( ... )
			return self:getFetterPetIdListWithPartners()
		end,
		getFetterPetIdList = function ( ... )
			return self:getFetterPetIdList()
		end,
		getPetInfo = function ( nPetId )
			return self:getPetInfo(nPetId)
		end,
		partnerList = function ( ... )
			return self:getPartner(self.teamSelected)
		end,
		isMyTeam = self:isMyTeam(),
		nPetIdSelected = self:getPetIdSelected()
	})
end

function CTeam:petCanImprove( nPetId )
	if self:isMyTeam() then
		local nPet = petFunc.getPetWithId(nPetId)
		return petFunc.satisfyAllEvolveCondition(nPet) or petFunc.getPetUpgradeEnable(nPet)
	else
		return false
	end
end

function CTeam:updateHonor( ... )
	self._bg_ftpos_btnHonor_text:setString(gameFunc.getUserInfo().getTitleNameHorizontal())
--	require 'LangAdapter'.labelDimensions(self._bg_ftpos_btnHonor_text, CCSizeMake(0,0))
	require 'LangAdapter'.selectLang(function ( ... )
		self._bg_ftpos_btnHonor_text:setDimensions(CCSizeMake(0,0))
	end, nil, nil, nil, function ( ... )
		self._bg_ftpos_btnHonor_text:setRotation(90)
		self._bg_ftpos_btnTeamSwitch_text:setDimensions(CCSize(0,0))
	end, function ( ... )
		self._bg_ftpos_btnHonor_text:setRotation(90)
		self._bg_ftpos_btnHonor_text:setFontSize(20)
		self._bg_ftpos_btnTeamSwitch_text:setDimensions(CCSize(0,0))
	end, function ( ... )
		self._bg_ftpos_btnHonor_text:setRotation(90)
		self._bg_ftpos_btnHonor_text:setFontSize(20)
		self._bg_ftpos_btnTeamSwitch_text:setDimensions(CCSize(0,0))
		self._bg_ftpos_btnTeamSwitch_text:setRotation(90)
	end, function ( ... )
		self._bg_ftpos_btnTeamSwitch_text:setDimensions(CCSize(0,0))
		self._bg_ftpos_btnHonor_text:setRotation(90)
		self._bg_ftpos_btnHonor_text:setFontSize(20)
	end, function ( ... )
		self._bg_ftpos_btnTeamSwitch_text:setDimensions(CCSize(0,0))
	end)

	local isVisible = gameFunc.getUserInfo().isTitleUpgradeEnable()
	self._bg_ftpos_btnHonor_height:setVisible(isVisible)
	self._bg_ftpos_btnHonor_height:stopAllActions()
	if isVisible then
		self._bg_ftpos_btnHonor_height:runAction(res.getFadeAction(1))
	end
end

function CTeam:improveEquipOneKey( ... )
	local nPetId = self:getPetIdSelected()
	local elist = equipFunc.getEquipListWithPetId( nPetId )
	local result = false
	local eidList = {}
	local userFunc = gameFunc.getUserInfo()
	if elist and #elist > 0 then
		table.sort(elist, function ( v1, v2 )
			local dbEquip1 = dbManager.getInfoEquipment(v1.EquipmentId)
			local dbEquip2 = dbManager.getInfoEquipment(v2.EquipmentId)
			return dbEquip1.location < dbEquip2.location
		end)
		local calculateTool = require "CalculateTool"
		for i,nEquip in ipairs(elist) do
			if nEquip.Lv < require "Toolkit".getEquipLevelCap( nEquip ) then
				if userFunc.getLevel() >= dbManager.getInfoEquipNeedRoleLevel(nEquip.Lv + 1) then
					result = true
					if userFunc.getGold() >= calculateTool.getEquipStrengthenNeedGold(dbManager.getInfoEquipment(nEquip.EquipmentId).color, nEquip.Lv) then
						table.insert(eidList, nEquip.Id)
					end
				end
			end
		end
	end
	if result then
		if #eidList > 0 then
			self:send(netModel.getModelEqMaxStrengthenAll( teamFunc.getTeamActiveId(), self.petIndexSelected, nPetId, eidList ), function ( data )
				if data and data.D then
					userFunc.setGold( math.max(userFunc.getGold() - data.D.Gold, 0) )
					EventCenter.eventInput("UpdateGoldCoin")

					if data.D.Pet then
						petFunc.setPet(data.D.Pet)
						self:updatePetInfo(data.D.Pet)
					end
				
					if data.D.Equipments then
						for i,v in ipairs(data.D.Equipments) do
							equipFunc.setEquipWithId(v)
						end
					end

					self:updatePetInfoWithIndex(self.petIndexSelected)
					self:updateTeamInfo(true)
					self:toast(res.locString("Team$ImproveEquipOneKeySuc"))
				end
			end)
		else
			self:toast(res.locString("Team$ImproveEquipOneKeyError1"))
		end
	else
		self:toast(res.locString("Team$ImproveEquipOneKeyError2"))
	end
end

function CTeam:getRuneListWithEquipId( nEquipId )
	if self:isMyTeam() then
		return require "RuneInfo".selectByCondition(function ( nRune )
			return nRune.SetIn == nEquipId
		end)
	else
		if self.runeList then
			local temp = {}
			for i,v in ipairs(self.runeList) do
				if v.SetIn == nEquipId then
					table.insert(temp, v)
				end
			end
			return temp
		end
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(CTeam, "CTeam")


--------------------------------register--------------------------------
GleeCore:registerLuaController("CTeam", CTeam)


