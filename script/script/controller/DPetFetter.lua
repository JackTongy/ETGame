local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local netModel = require "netModel"
local LuaList = require "LuaList"
local EventCenter = require "EventCenter"
local gameFunc = require "AppData"
local partnerFunc = gameFunc.getPartnerInfo()
local teamFunc = gameFunc.getTeamInfo()
local petFunc = gameFunc.getPetInfo()
local UnlockManager = require "UnlockManager"

local DPetFetter = class(LuaDialog)

function DPetFetter:createDocument()
		self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPetFetter.cocos.zip")
		return self._factory:createDocument("DPetFetter.cocos")
end

--@@@@[[[[
function DPetFetter:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_bg1 = set:getJoint9Node("commonDialog_cnt_bg1")
    self._commonDialog_cnt_bg1_list = set:getListNode("commonDialog_cnt_bg1_list")
    self._icon = set:getElfNode("icon")
    self._name = set:getLabelNode("name")
    self._btn = set:getButtonNode("btn")
    self._commonDialog_cnt_bg2 = set:getJoint9Node("commonDialog_cnt_bg2")
    self._commonDialog_cnt_bg2_list = set:getListNode("commonDialog_cnt_bg2_list")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._name = set:getLabelNode("name")
    self._btn = set:getButtonNode("btn")
    self._commonDialog_cnt_bg3 = set:getJoint9Node("commonDialog_cnt_bg3")
    self._commonDialog_cnt_bg3_list = set:getListNode("commonDialog_cnt_bg3_list")
    self._commonDialog_cnt_bg3_list_container_fetterbase = set:getElfNode("commonDialog_cnt_bg3_list_container_fetterbase")
    self._bg1 = set:getElfNode("bg1")
    self._linearlayout = set:getLinearLayoutNode("linearlayout")
    self._linearlayout_pets = set:getElfNode("linearlayout_pets")
    self._linearlayout_pets_layout = set:getLayout2DNode("linearlayout_pets_layout")
    self._pzbg = set:getElfNode("pzbg")
    self._icon = set:getElfNode("icon")
    self._pz = set:getElfNode("pz")
    self._name = set:getLabelNode("name")
    self._pzbg = set:getElfNode("pzbg")
    self._icon = set:getElfNode("icon")
    self._pz = set:getElfNode("pz")
    self._name = set:getLabelNode("name")
    self._pzbg = set:getElfNode("pzbg")
    self._icon = set:getElfNode("icon")
    self._pz = set:getElfNode("pz")
    self._name = set:getLabelNode("name")
    self._pzbg = set:getElfNode("pzbg")
    self._icon = set:getElfNode("icon")
    self._pz = set:getElfNode("pz")
    self._name = set:getLabelNode("name")
    self._pzbg = set:getElfNode("pzbg")
    self._icon = set:getElfNode("icon")
    self._pz = set:getElfNode("pz")
    self._name = set:getLabelNode("name")
    self._pzbg = set:getElfNode("pzbg")
    self._icon = set:getElfNode("icon")
    self._pz = set:getElfNode("pz")
    self._name = set:getLabelNode("name")
    self._layout = set:getLinearLayoutNode("layout")
    self._layout_state = set:getElfNode("layout_state")
    self._layout_des = set:getRichLabelNode("layout_des")
    self._layout = set:getLinearLayoutNode("layout")
    self._layout_state = set:getElfNode("layout_state")
    self._layout_des = set:getRichLabelNode("layout_des")
    self._layout = set:getLinearLayoutNode("layout")
    self._layout_state = set:getElfNode("layout_state")
    self._layout_des = set:getRichLabelNode("layout_des")
    self._layout = set:getLinearLayoutNode("layout")
    self._layout_state = set:getElfNode("layout_state")
    self._layout_des = set:getRichLabelNode("layout_des")
    self._layout = set:getLinearLayoutNode("layout")
    self._layout_state = set:getElfNode("layout_state")
    self._layout_des = set:getRichLabelNode("layout_des")
    self._commonDialog_cnt2 = set:getElfNode("commonDialog_cnt2")
    self._commonDialog_cnt2_bg = set:getJoint9Node("commonDialog_cnt2_bg")
    self._commonDialog_cnt2_list = set:getListNode("commonDialog_cnt2_list")
    self._layout = set:getLayoutNode("layout")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._posIcon = set:getElfNode("posIcon")
    self._name = set:getLabelNode("name")
    self._changeRate = set:getLinearLayoutNode("changeRate")
    self._changeRate_value = set:getLabelNode("changeRate_value")
    self._effect = set:getLinearLayoutNode("effect")
    self._effect_key = set:getLabelNode("effect_key")
    self._effect_value = set:getLabelNode("effect_value")
    self._lv = set:getElfNode("lv")
    self._btn = set:getClickNode("btn")
    self._btn2 = set:getClickNode("btn2")
    self._pos = set:getLabelNode("pos")
    self._tapText = set:getLabelNode("tapText")
    self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
    self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
    self._commonDialog_tab = set:getLayoutNode("commonDialog_tab")
    self._commonDialog_tab_tab1 = set:getTabNode("commonDialog_tab_tab1")
    self._commonDialog_tab_tab1_title = set:getLabelNode("commonDialog_tab_tab1_title")
    self._commonDialog_tab_tab2 = set:getTabNode("commonDialog_tab_tab2")
    self._commonDialog_tab_tab2_title = set:getLabelNode("commonDialog_tab_tab2_title")
    self._commonDialog_tab_tab2_lock = set:getElfNode("commonDialog_tab_tab2_lock")
    self._commonDialog_btnHelp = set:getButtonNode("commonDialog_btnHelp")
--    self._@itemPartner = set:getElfNode("@itemPartner")
--    self._@itemPetInTeam = set:getElfNode("@itemPetInTeam")
--    self._@fetter = set:getElfNode("@fetter")
--    self._@pet = set:getElfNode("@pet")
--    self._@pet = set:getElfNode("@pet")
--    self._@pet = set:getElfNode("@pet")
--    self._@pet = set:getElfNode("@pet")
--    self._@pet = set:getElfNode("@pet")
--    self._@pet = set:getElfNode("@pet")
--    self._@item = set:getElfNode("@item")
--    self._@item = set:getElfNode("@item")
--    self._@item = set:getElfNode("@item")
--    self._@item = set:getElfNode("@item")
--    self._@item = set:getElfNode("@item")
--    self._@petNoFetter = set:getLabelNode("@petNoFetter")
--    self._@size = set:getElfNode("@size")
--    self._@item2 = set:getElfNode("@item2")
end
--@@@@]]]]

--------------------------------override functions----------------------

local Launcher = require 'Launcher'
Launcher.register("DPetFetter", function ( userData )
   	Launcher.callNet(netModel.getModelPartnerGet(  ),function ( data )
     		Launcher.Launching(data)
   	end)
end)

function DPetFetter:onInit( userData, netData )
	if netData and netData.D then
		gameFunc.getPartnerInfo().setPartnerList(netData.D.Partners)
	end

	self.getPetChoseData = userData.getPetChoseData
	self.getFetterPetIdListWithPartners = userData.getFetterPetIdListWithPartners
	self.getFetterPetIdList = userData.getFetterPetIdList
	self.getPetInfo = userData.getPetInfo
	self.partnerList = userData.partnerList
	self.isMyTeam = userData.isMyTeam
	self.nPetIdSelected = userData.nPetIdSelected
	self.tabIndexSelected = 1

	self:setListenerEvent()
	self:broadcastEvent()
	self:updatePages()
	self:AlignTeamPet()
	res.doActionDialogShow(self._commonDialog)
end

function DPetFetter:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DPetFetter:close(  )
	EventCenter.resetGroup("DPetFetter")
end

function DPetFetter:broadcastEvent( ... )
	EventCenter.addEventFunc("PetFetterUpdate", function ( ... )
		self:updatePages()
	end, "DPetFetter")
end

function DPetFetter:setListenerEvent( ... )
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._commonDialog_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._commonDialog_btnHelp:setListener(function ( ... )
		GleeCore:showLayer("DHelp", {type = "羁绊"})
	end)

	for i=1,2 do
		require 'LangAdapter'.fontSize(self[string.format("_commonDialog_tab_tab%d_title", i)], nil, nil, nil, nil, 16)
		self[string.format("_commonDialog_tab_tab%d", i)]:setListener(function ( ... )
			if i == 2 and not UnlockManager:isUnlock("FetterAdd") then
				self:toast(UnlockManager:getUnlockConditionMsg("FetterAdd"))
				self._commonDialog_tab_tab1:trigger(nil)
				return
			end

			if self.tabIndexSelected ~= i then
				self.tabIndexSelected = i
				self:updatePages()
			end
		end)
	end
	self._commonDialog_tab_tab2_lock:setVisible(not UnlockManager:isUnlock("FetterAdd"))
end

function DPetFetter:updatePages( ... )
	self[string.format("_commonDialog_tab_tab%d", self.tabIndexSelected)]:trigger(nil)
	self:updateTabNameColor()
	
	if self.tabIndexSelected == 1 then
		self._commonDialog_cnt:setVisible(true)
		self._commonDialog_cnt2:setVisible(false)
		self:updatePartners()
		self:updatePetTeamInList()
		self:updateFetter()
	elseif self.tabIndexSelected == 2 then
		self._commonDialog_cnt:setVisible(false)
		self._commonDialog_cnt2:setVisible(true)
		self:updateResonant()
	end
end

function DPetFetter:updateTabNameColor( ... )
	for i=1,2 do
		local titleNode = self[string.format("_commonDialog_tab_tab%d_title", i)]
		if self.tabIndexSelected == i then
			titleNode:setFontFillColor(res.tabColor2.selectedTextColor, true)
			titleNode:enableStroke(res.tabColor2.selectedStrokeColor, 2, true)
		else
			titleNode:setFontFillColor(res.tabColor2.unselectTextColor, true)
			titleNode:enableStroke(res.tabColor2.unselectStrokeColor, 2, true)
		end
	end
end

function DPetFetter:updatePartners( ... )
	local partnerList = self.partnerList()
	local unLockedCount = #partnerList
	self._commonDialog_cnt_bg1_list:getContainer():removeAllChildrenWithCleanup(true)
	local partnerConfig = require "PartnerConfig"
	local allCount = #partnerConfig
	if require "UnlockManager":isOpen("fetterPos2") == false then
		allCount = 6
	end
	for j=1,allCount do
		local partner = self:createLuaSet("@itemPartner")
		self._commonDialog_cnt_bg1_list:getContainer():addChild(partner[1])
		if j <= unLockedCount then
			if partnerList[j].PetId > 0 then
				local nPet = self.getPetInfo(partnerList[j].PetId)
				res.setNodeWithPet(partner["icon"], nPet)
				local dbPet = dbManager.getCharactor(nPet.PetId)
				partner["name"]:setString(res.getPetNameWithSuffix(nPet))
				partner["name"]:setVisible(true)
			else
				partner["icon"]:setResid("N_DW_xiaohuoban_kuang1.png")
				partner["name"]:setVisible(false)
			end

			partner["btn"]:setEnabled(self.isMyTeam)
			partner["btn"]:setListener(function (  )
				self:partnerChosePet(j)
			end)
		elseif j == unLockedCount + 1 then -- 需要解锁
			partner["icon"]:setResid("N_DW_xiaohuoban_kuang4.png")
			partner["name"]:setVisible(false)
			partner["btn"]:setEnabled(self.isMyTeam)
			partner["btn"]:setListener(function (  )
				self:partnerUnLock(j)
			end)
		else
			partner["icon"]:setResid("N_DW_xiaohuoban_weijiesuo.png")
			partner["name"]:setVisible(false)
			partner["btn"]:setEnabled(false)
		end
	end
end

function DPetFetter:updatePetTeamInList(  )
	if not self.itemList then
		self.itemList = LuaList.new(self._commonDialog_cnt_bg2_list, function ( ... )
			return self:createLuaSet("@itemPetInTeam")
		end, function ( nodeLuaSet, nPetId )
			local nPet = nPetId > 0 and self.getPetInfo(nPetId) or nil
			local dbPet = nPet and dbManager.getCharactor(nPet.PetId) or nil
			if dbPet then
				nodeLuaSet["bg"]:setResid(self.nPetIdSelected == nPet.Id and "N_HCZZ_ZK_sel.png" or "N_HCZZ_ZK.png")
				res.setNodeWithPet( nodeLuaSet["icon"], nPet )
				nodeLuaSet["name"]:setString(dbPet.name)
				if self.nPetIdSelected == nPet then
					nodeLuaSet["name"]:setFontFillColor(res.color4F.khaki, true)
				else
					nodeLuaSet["name"]:setFontFillColor(ccc4f(0.376,0.28,0.217,1.0), true)
				end
				res.adjustNodeWidth( nodeLuaSet["name"], 110 )

				nodeLuaSet["btn"]:setListener(function ( ... )
					if self.nPetIdSelected ~= nPet.Id then
						self.nPetIdSelected = nPet.Id
						self:updatePetTeamInList()
						self:updateFetter()
					end
				end)
			end
		end)
	end

	self.itemList:update( self.getFetterPetIdList() )
end

function DPetFetter:AlignTeamPet( ... )
	local list = self.getFetterPetIdList()
	self.nPetIdSelected = self.nPetIdSelected or list[1]
	self:runWithDelay(function ( ... )
		local index = table.keyOfItem(list, self.nPetIdSelected)
		if index then
			self._commonDialog_cnt_bg2_list:alignTo(index - 1)
		end
	end, 0)
end

function DPetFetter:updateFetter(  )
	self._commonDialog_cnt_bg3_list_container_fetterbase:removeAllChildrenWithCleanup(true)
	local set = self:createLuaSet("@fetter")
	self._commonDialog_cnt_bg3_list_container_fetterbase:addChild(set[1])

	local nPet = self.getPetInfo(self.nPetIdSelected)
	local dbPet = dbManager.getCharactor(nPet.PetId)
	require 'PetNodeHelper'.updateFetter(self, set, dbPet, self.getFetterPetIdListWithPartners())

	set['linearlayout']:layout()
	local size = set['linearlayout']:getContentSize()
	set[1]:setContentSize(CCSizeMake(size.width,size.height+20))
	
	if not (dbPet.relate_arr and #dbPet.relate_arr > 0) then
		local petNoFetter = self:createLuaSet("@petNoFetter")
		self._commonDialog_cnt_bg3_list_container_fetterbase:addChild(petNoFetter[1])
	end
end

function DPetFetter:updateResonant( ... )
	local partnerList = self.partnerList()
	local unLockedCount = #partnerList
	self._commonDialog_cnt2_list:getContainer():removeAllChildrenWithCleanup(true)
	local partnerConfig = require "PartnerConfig"
	local allCount = #partnerConfig
	if require "UnlockManager":isOpen("fetterPos2") == false then
		allCount = 6
	end
	local sizeSet
	for j=1,allCount do
		if j % 2 == 1 then
			sizeSet = self:createLuaSet("@size")
			self._commonDialog_cnt2_list:getContainer():addChild(sizeSet[1])
		end
		local partner = self:createLuaSet("@item2")
		sizeSet["layout"]:addChild(partner[1])

		if j <= unLockedCount then
			local petAlive = partnerList[j].PetId > 0
			partner["name"]:setVisible(petAlive)
			partner["posIcon"]:setVisible(petAlive)
			partner["changeRate"]:setVisible(petAlive)
			partner["effect"]:setVisible(petAlive)
			partner["pos"]:setVisible(not petAlive)
			partner["tapText"]:setVisible(not petAlive)
			partner["lv"]:setVisible(true)
			if petAlive then
				local nPet = self.getPetInfo(partnerList[j].PetId)
				res.setNodeWithPet(partner["icon"], nPet)
				local dbPet = dbManager.getCharactor(nPet.PetId)
				partner["name"]:setString(res.getPetNameWithSuffix(nPet))
				partner["posIcon"]:setResid(string.format("N_DW_biaoqian%d.png", j))
				partner["changeRate_value"]:setString(string.format("%g%%", tonumber(string.format("%.4f", partnerList[j].Rate)) * 100))
				if nPet.AwakeIndex >= dbManager.getInfoDefaultConfig("PartnerAwake").Value then
					local dbPartner = dbManager.getInfoPartner(j)
					partner["effect_key"]:setString( res.locString(string.format("Team$FetterResonantAddition%d", dbPartner.Atk)) )
					partner["effect_value"]:setString(partnerList[j].Addition)
				else
					partner["effect_key"]:setString(res.locString("Team$FetterResonantActiveAddition"))
					partner["effect_value"]:setString("")
				end
				partner["lv"]:setResid(string.format("N_DW_lv1_%d.png", partnerList[j].Lv))
			else
				partner["icon"]:setResid("N_DW_xiaohuoban_kuang1.png")
				partner["pos"]:setString(res.locString("Team$FetterResonantPosition") .. j)
				partner["tapText"]:setString(res.locString("Team$FetterResonantTapChose"))
				partner["lv"]:setResid(string.format("N_DW_lv2_%d.png", partnerList[j].Lv))
			end

			partner["btn"]:setEnabled(self.isMyTeam)
			partner["btn"]:setListener(function (  )
				self:partnerChosePet(j)
			end)
			partner["btn2"]:setEnabled(self.isMyTeam)
			partner["btn2"]:setListener(function (  )
				GleeCore:showLayer("DPartnerAddImprove", {partner = partnerList[j], getPetInfo = self.getPetInfo})
			end)
		elseif j == unLockedCount + 1 then -- 需要解锁
			partner["icon"]:setResid("N_DW_xiaohuoban_kuang4.png")
			partner["name"]:setVisible(false)
			partner["posIcon"]:setVisible(false)
			partner["changeRate"]:setVisible(false)
			partner["effect"]:setVisible(false)
			partner["lv"]:setVisible(true)
			partner["lv"]:setResid("N_DW_lv2_0.png")
			partner["btn"]:setEnabled(self.isMyTeam)
			partner["btn"]:setListener(function (  )
				self:partnerUnLock(j)
			end)
			partner["btn2"]:setEnabled(self.isMyTeam)
			partner["btn2"]:setListener(function (  )
				self:partnerUnLock(j)
			end)
			partner["pos"]:setVisible(true)
			partner["pos"]:setString(res.locString("Team$FetterResonantPosition") .. j)
			partner["tapText"]:setVisible(true)
			partner["tapText"]:setString(res.locString("Team$FetterResonantTapUnLock"))
		else
			partner["icon"]:setResid("N_DW_xiaohuoban_weijiesuo.png")
			partner["name"]:setVisible(false)
			partner["posIcon"]:setVisible(false)
			partner["changeRate"]:setVisible(false)
			partner["effect"]:setVisible(false)
			partner["lv"]:setVisible(true)
			partner["lv"]:setResid("N_DW_lv2_0.png")
			partner["btn"]:setEnabled(false)
			partner["btn2"]:setEnabled(false)
			partner["pos"]:setVisible(true)
			partner["pos"]:setString(res.locString("Team$FetterResonantPosition") .. j)
			partner["pos"]:setPosition(ccp(-71.000015, 0))
		end
	end
end

function DPetFetter:partnerChosePet( j )
	if self.getPetChoseData then
		local partnerList = self.partnerList()
		local param = self.getPetChoseData(partnerList[j].PetId, function ( newPetId )
			local _, teamActiveId = teamFunc.getTeamActive()
			self:send(netModel.getModelPartnerUpdate(j, newPetId, teamActiveId), function ( data )
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
					end
					self:updatePages()
					require "EventCenter".eventInput("PetInfoModify")
				end
			end)
		end)
		GleeCore:showLayer("DPetChose", param)
	end
end

function DPetFetter:partnerUnLock( j )
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
					end
					self:updatePages()
				--[[
					local function unLockAnimPlay( ... )
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
					unLockAnimPlay()
				]]
				end
			end)
		else
			require "Toolkit".showDialogOnCoinNotEnough()
		end
	end
	GleeCore:showLayer("DConfirmNT", param)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPetFetter, "DPetFetter")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPetFetter", DPetFetter)


