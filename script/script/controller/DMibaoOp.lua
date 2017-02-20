local Config = require "Config"
local dbManager = require "DBManager"
local res = require "Res"
local netModel = require "netModel"
local calculateTool = require "CalculateTool"
local toolkit = require "Toolkit"
local GuideHelper = require 'GuideHelper'
local eventcenter = require "EventCenter"

local ViewType = {Strengthen = 1,Reform = 2,Rebirth = 3,Refine = 4}

local DMibaoOp = class(LuaDialog)

function DMibaoOp:createDocument()
self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DMibaoOp.cocos.zip")
return self._factory:createDocument("DMibaoOp.cocos")
end

--@@@@[[[[
function DMibaoOp:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._equipBg_equipIcon = set:getElfNode("equipBg_equipIcon")
    self._equipBg_headBar_nameLayout = set:getLinearLayoutNode("equipBg_headBar_nameLayout")
    self._equipBg_anim = set:getElfNode("equipBg_anim")
    self._equipBg_typeLayout = set:getLinearLayoutNode("equipBg_typeLayout")
    self._strengthenDetailBg_ZB_wenzi0_subTitle = set:getLabelNode("strengthenDetailBg_ZB_wenzi0_subTitle")
    self._strengthenDetailBg_strengthenInfoBg_status1 = set:getElfNode("strengthenDetailBg_strengthenInfoBg_status1")
    self._strengthenDetailBg_strengthenInfoBg_status1_layout = set:getLinearLayoutNode("strengthenDetailBg_strengthenInfoBg_status1_layout")
    self._progressBg_p = set:getProgressNode("progressBg_p")
    self._name = set:getLabelNode("name")
    self._before = set:getLabelNode("before")
    self._icon = set:getElfNode("icon")
    self._after = set:getLabelNode("after")
    self._name = set:getLabelNode("name")
    self._value = set:getLabelNode("value")
    self._strengthenDetailBg_strengthenInfoBg_status2 = set:getLinearLayoutNode("strengthenDetailBg_strengthenInfoBg_status2")
    self._strengthenDetailBg_strengthenInfoBg_status3 = set:getLinearLayoutNode("strengthenDetailBg_strengthenInfoBg_status3")
    self._strengthenDetailBg_materialBg_mLayout = set:getLinearLayoutNode("strengthenDetailBg_materialBg_mLayout")
    self._icon = set:getElfNode("icon")
    self._strengthenDetailBg_materialBg_btn = set:getButtonNode("strengthenDetailBg_materialBg_btn")
    self._strengthenDetailBg_GoldCostLabel_goldLayout_GoldCostValueLabel = set:getLabelNode("strengthenDetailBg_GoldCostLabel_goldLayout_GoldCostValueLabel")
    self._strengthenDetailBg_autoStrengthenBtn = set:getClickNode("strengthenDetailBg_autoStrengthenBtn")
    self._strengthenDetailBg_strengthenBtn = set:getClickNode("strengthenDetailBg_strengthenBtn")
    self._reformDetailBg_ZB_wenzi0_subTitle = set:getLabelNode("reformDetailBg_ZB_wenzi0_subTitle")
    self._reformDetailBg_reformInfoBg_layout = set:getLinearLayoutNode("reformDetailBg_reformInfoBg_layout")
    self._reformDetailBg_reformInfoBg_layout_name = set:getLabelNode("reformDetailBg_reformInfoBg_layout_name")
    self._reformDetailBg_reformInfoBg_layout_before = set:getLabelNode("reformDetailBg_reformInfoBg_layout_before")
    self._icon = set:getElfNode("icon")
    self._after = set:getLabelNode("after")
    self._reformDetailBg_reformNeedBg_goldNeed = set:getLabelNode("reformDetailBg_reformNeedBg_goldNeed")
    self._reformDetailBg_reformNeedBg_petIcon = set:getElfNode("reformDetailBg_reformNeedBg_petIcon")
    self._reformDetailBg_reformNeedBg_petIcon_pet = set:getElfNode("reformDetailBg_reformNeedBg_petIcon_pet")
    self._reformDetailBg_reformNeedBg_petName = set:getLabelNode("reformDetailBg_reformNeedBg_petName")
    self._reformDetailBg_reformNeedBg_btn = set:getButtonNode("reformDetailBg_reformNeedBg_btn")
    self._reformDetailBg_lastReformCountLayout = set:getLinearLayoutNode("reformDetailBg_lastReformCountLayout")
    self._reformDetailBg_lastReformCountLayout_value = set:getLabelNode("reformDetailBg_lastReformCountLayout_value")
    self._reformDetailBg_reformBtn = set:getClickNode("reformDetailBg_reformBtn")
    self._reformDetailBg_reformBtn_btntext = set:getLabelNode("reformDetailBg_reformBtn_btntext")
    self._reformDetailBg_detailTitle_goldBg = set:getJoint9Node("reformDetailBg_detailTitle_goldBg")
    self._reformDetailBg_detailTitle_goldBg_goldCountLabel = set:getLabelNode("reformDetailBg_detailTitle_goldBg_goldCountLabel")
    self._reformDetailBg_detailTitle_coinBg = set:getJoint9Node("reformDetailBg_detailTitle_coinBg")
    self._reformDetailBg_detailTitle_coinBg_coinCountLabel = set:getLabelNode("reformDetailBg_detailTitle_coinBg_coinCountLabel")
    self._reformDetailBg_ZB_wenzi0_subTitle = set:getLabelNode("reformDetailBg_ZB_wenzi0_subTitle")
    self._reformDetailBg_reformInfoBg_left = set:getElfNode("reformDetailBg_reformInfoBg_left")
    self._reformDetailBg_reformInfoBg_left_icon = set:getElfNode("reformDetailBg_reformInfoBg_left_icon")
    self._reformDetailBg_reformInfoBg_left_nameLayout = set:getLinearLayoutNode("reformDetailBg_reformInfoBg_left_nameLayout")
    self._reformDetailBg_reformInfoBg_left_rankAndLevel = set:getLabelNode("reformDetailBg_reformInfoBg_left_rankAndLevel")
    self._reformDetailBg_reformInfoBg_right = set:getElfNode("reformDetailBg_reformInfoBg_right")
    self._reformDetailBg_reformInfoBg_right_icon = set:getElfNode("reformDetailBg_reformInfoBg_right_icon")
    self._reformDetailBg_reformInfoBg_right_nameLayout = set:getLinearLayoutNode("reformDetailBg_reformInfoBg_right_nameLayout")
    self._reformDetailBg_reformInfoBg_right_rankAndLevel = set:getLabelNode("reformDetailBg_reformInfoBg_right_rankAndLevel")
    self._reformDetailBg_reformBtn = set:getClickNode("reformDetailBg_reformBtn")
    self._reformDetailBg_reformBtn_btntext = set:getLabelNode("reformDetailBg_reformBtn_btntext")
    self._reformDetailBg_DiamondCostLabel_DiamondCostValueLabel = set:getLabelNode("reformDetailBg_DiamondCostLabel_DiamondCostValueLabel")
    self._reformDetailBg_detailTitle_goldBg = set:getJoint9Node("reformDetailBg_detailTitle_goldBg")
    self._reformDetailBg_detailTitle_goldBg_goldCountLabel = set:getLabelNode("reformDetailBg_detailTitle_goldBg_goldCountLabel")
    self._reformDetailBg_detailTitle_coinBg = set:getJoint9Node("reformDetailBg_detailTitle_coinBg")
    self._reformDetailBg_detailTitle_coinBg_coinCountLabel = set:getLabelNode("reformDetailBg_detailTitle_coinBg_coinCountLabel")
    self._reformDetailBg_ZB_wenzi0_subTitle = set:getLabelNode("reformDetailBg_ZB_wenzi0_subTitle")
    self._reformDetailBg_strengthenDes = set:getLabelNode("reformDetailBg_strengthenDes")
    self._reformDetailBg_reformInfoBg_leftBg_left = set:getElfNode("reformDetailBg_reformInfoBg_leftBg_left")
    self._reformDetailBg_reformInfoBg_leftBg_left_icon = set:getElfNode("reformDetailBg_reformInfoBg_leftBg_left_icon")
    self._reformDetailBg_reformInfoBg_leftBg_left_nameLayout = set:getLinearLayoutNode("reformDetailBg_reformInfoBg_leftBg_left_nameLayout")
    self._reformDetailBg_reformInfoBg_leftBg_left_pro = set:getLabelNode("reformDetailBg_reformInfoBg_leftBg_left_pro")
    self._reformDetailBg_reformInfoBg_leftBg_material = set:getElfNode("reformDetailBg_reformInfoBg_leftBg_material")
    self._reformDetailBg_reformInfoBg_leftBg_material_addicon = set:getElfNode("reformDetailBg_reformInfoBg_leftBg_material_addicon")
    self._reformDetailBg_reformInfoBg_leftBg_material_materialicon = set:getElfNode("reformDetailBg_reformInfoBg_leftBg_material_materialicon")
    self._reformDetailBg_reformInfoBg_leftBg_material_redPoint = set:getElfNode("reformDetailBg_reformInfoBg_leftBg_material_redPoint")
    self._reformDetailBg_reformInfoBg_leftBg_material_btn = set:getButtonNode("reformDetailBg_reformInfoBg_leftBg_material_btn")
    self._reformDetailBg_reformInfoBg_right = set:getElfNode("reformDetailBg_reformInfoBg_right")
    self._reformDetailBg_reformInfoBg_right_icon = set:getElfNode("reformDetailBg_reformInfoBg_right_icon")
    self._reformDetailBg_reformInfoBg_right_nameLayout = set:getLinearLayoutNode("reformDetailBg_reformInfoBg_right_nameLayout")
    self._reformDetailBg_reformInfoBg_right_pro = set:getLabelNode("reformDetailBg_reformInfoBg_right_pro")
    self._reformDetailBg_reformInfoBg_newProTip = set:getLinearLayoutNode("reformDetailBg_reformInfoBg_newProTip")
    self._reformDetailBg_reformInfoBg_newProTip_des = set:getLabelNode("reformDetailBg_reformInfoBg_newProTip_des")
    self._reformDetailBg_reformBtn = set:getClickNode("reformDetailBg_reformBtn")
    self._reformDetailBg_reformBtn_btntext = set:getLabelNode("reformDetailBg_reformBtn_btntext")
    self._reformDetailBg_DiamondCostLabel = set:getLinearLayoutNode("reformDetailBg_DiamondCostLabel")
    self._reformDetailBg_DiamondCostLabel_DiamondCostValueLabel = set:getLabelNode("reformDetailBg_DiamondCostLabel_DiamondCostValueLabel")
    self._reformDetailBg_refineMaxTip = set:getLabelNode("reformDetailBg_refineMaxTip")
    self._layout = set:getLinearLayoutNode("layout")
    self._name = set:getLabelNode("name")
    self._value = set:getLabelNode("value")
    self._bg_order1 = set:getElfNode("bg_order1")
    self._bg_order1_topBar = set:getElfNode("bg_order1_topBar")
    self._bg_order1_topBar_btnHelp = set:getButtonNode("bg_order1_topBar_btnHelp")
    self._bg_order1_topBar_btnReturn = set:getButtonNode("bg_order1_topBar_btnReturn")
    self._bg_order1_topBar_tabStrengthen = set:getTabNode("bg_order1_topBar_tabStrengthen")
    self._bg_order1_topBar_tabReform = set:getTabNode("bg_order1_topBar_tabReform")
    self._bg_order1_topBar_tabRebirth = set:getTabNode("bg_order1_topBar_tabRebirth")
    self._bg_order1_topBar_tabRefine = set:getTabNode("bg_order1_topBar_tabRefine")
    self._btnLeft = set:getButtonNode("btnLeft")
    self._btnRight = set:getButtonNode("btnRight")
    self._forAnim = set:getElfNode("forAnim")
    self._line1 = set:getRichLabelNode("line1")
    self._line2 = set:getLinearLayoutNode("line2")
    self._line2_goldUse = set:getLabelNode("line2_goldUse")
    self._line2_goldSave = set:getLabelNode("line2_goldSave")
    self._line3 = set:getLinearLayoutNode("line3")
    self._screenBtn = set:getButtonNode("screenBtn")
    self._RepeatForever = set:getElfAction("RepeatForever")
    self._Sequence = set:getElfAction("Sequence")
--    self._@equipView = set:getElfNode("@equipView")
--    self._@refineLvIcon = set:getElfNode("@refineLvIcon")
--    self._@equipName = set:getLabelNode("@equipName")
--    self._@strengthen1 = set:getSimpleAnimateNode("@strengthen1")
--    self._@reform1 = set:getSimpleAnimateNode("@reform1")
--    self._@proIcon = set:getElfNode("@proIcon")
--    self._@careerIcon = set:getElfNode("@careerIcon")
--    self._@pageStrengthen = set:getElfNode("@pageStrengthen")
--    self._@expBar = set:getElfNode("@expBar")
--    self._@proBar = set:getElfNode("@proBar")
--    self._@reformCountAddTip = set:getElfNode("@reformCountAddTip")
--    self._@mItem = set:getElfNode("@mItem")
--    self._@mItemDefault = set:getElfNode("@mItemDefault")
--    self._@pageReform = set:getElfNode("@pageReform")
--    self._@layoutAfter = set:getLinearLayoutNode("@layoutAfter")
--    self._@pageRebirth = set:getElfNode("@pageRebirth")
--    self._@anim = set:getSimpleAnimateNode("@anim")
--    self._@pageRefine = set:getElfNode("@pageRefine")
--    self._@equipPro = set:getElfNode("@equipPro")
--    self._@mbProtitle = set:getLabelNode("@mbProtitle")
--    self._@mbProBar = set:getLinearLayoutNode("@mbProBar")
--    self._@mbProTip = set:getLabelNode("@mbProTip")
--    self._@sp = set:getElfNode("@sp")
--    self._@tabPreBtn = set:getButtonNode("@tabPreBtn")
--    self._@strengthenInfo = set:getLinearLayoutNode("@strengthenInfo")
--    self._@line3Info = set:getLabelNode("@line3Info")
--    self._@line3space = set:getElfNode("@line3space")
--    self._@line3Info = set:getLabelNode("@line3Info")
--    self._@line3space = set:getElfNode("@line3space")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DMibaoOp:onInit( userData, netData )
	local maxW = 72
	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabStrengthen_normal_#title"),maxW)
	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabStrengthen_pressed_#title"),maxW)
	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabStrengthen_invalid_#title"),maxW)

	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabRefine_normal_#title"),maxW)
	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabRefine_pressed_#title"),maxW)
	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabRefine_invalid_#title"),maxW)

	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabReform_normal_#title"),maxW)
	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabReform_pressed_#title"),maxW)
	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabReform_invalid_#title"),maxW)

	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabRebirth_normal_#title"),maxW)
	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabRebirth_pressed_#title"),maxW)
	require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabRebirth_invalid_#title"),maxW)

	res.doActionDialogShow(self._bg)
	self.cachedUpdateFunc = nil

	self.views = {}
	self.tickHandle = {}
	self.animFinishFuncs = {}
	self.effectIds = {}
	self.equipInfo = userData.Info
	self.equipList = userData.List or {self.equipInfo}
	self.equipIndex = table.indexOf(self.equipList,self.equipInfo)
	self.dbInfo = dbManager.getInfoTreasure(self.equipInfo.MibaoId)
	self.hideLeftTabs = userData.hideLeftTabs

	self:addTopBtnListener()[userData.ViewType or ViewType.Strengthen]:trigger(nil)

	self._bg_order1:setOrder(1)

	self:onEnter()
    	self._btnLeft:runElfAction(self._RepeatForever:clone())
    	self._btnRight:runElfAction(self._RepeatForever:clone())
end

function DMibaoOp:onEnter( ... )

end

function DMibaoOp:onBack( userData, netData )
	self.tickHandle[#self.tickHandle+1] = require "framework.sync.TimerHelper".tick(function ( ... )
		self:updateView()
	      	return true
	end)
end

--------------------------------custom code-----------------------------
function DMibaoOp:addTopBtnListener( ... )
	local tabBtns = {[ViewType.Strengthen] = self._bg_order1_topBar_tabStrengthen,
				[ViewType.Reform] = self._bg_order1_topBar_tabReform,
				[ViewType.Rebirth] = self._bg_order1_topBar_tabRebirth,
				[ViewType.Refine] = self._bg_order1_topBar_tabRefine,}
	table.foreach(tabBtns,function ( viewType,tabBtn )
		tabBtn:setListener(function (  )
			if self.curViewType~=viewType then
				self:onTabChanged()
				self.curViewType = viewType
				self:updateView()
				-- GuideHelper:check(string.format('DMibaoOp%s',tostring(viewType)))
			end
		end)
	end)

	if self.hideLeftTabs then
		for k,v in pairs(tabBtns) do
			v:setVisible(false)
		end
	end

	local btn = self:createLuaSet("@tabPreBtn")[1]
	btn:setPosition(self._bg_order1_topBar_tabReform:getPosition())
	self._bg_order1_topBar:addChild(btn)
	btn:setListener(function ( ... )
		if self.equipInfo.Star<3 then
			return self:toast(res.locString("Mibao$cannotReformTip"))
		else
			return self._bg_order1_topBar_tabReform:trigger(nil)
		end
	end)

	btn = self:createLuaSet("@tabPreBtn")[1]
	btn:setPosition(self._bg_order1_topBar_tabRebirth:getPosition())
	self._bg_order1_topBar:addChild(btn)
	btn:setListener(function ( ... )
		if self.equipInfo.Star<3 then
			return self:toast(res.locString("Mibao$cannotRebirthTip"))
		else
			return self._bg_order1_topBar_tabRebirth:trigger(nil)
		end
	end)

	btn = self:createLuaSet("@tabPreBtn")[1]
	btn:setPosition(self._bg_order1_topBar_tabRefine:getPosition())
	self._bg_order1_topBar:addChild(btn)
	btn:setListener(function ( ... )
		if self.equipInfo.Star<3 then
			return self:toast(res.locString("Mibao$cannotRefineTip"))
		elseif self.equipInfo.Lv<20 then
			return self:toast(res.locString("Mibao$LvLimitForRefineTip"))
		else
			return self._bg_order1_topBar_tabRefine:trigger(nil)
		end
	end)
	self._bg_order1_topBar_tabRefine:setVisible(require "UnlockManager":isOpen("MibaoRefine") == true)

	self.close = function ( ... )
	 	-- GuideHelper:check('CloseDialg')
		self:onTabChanged()
		self.curViewType = 0
	end

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_order1_topBar_btnHelp:setListener(function (  )
		GleeCore:showLayer("DHelp", {type = "秘宝"})
	end)
	self._bg_order1_topBar_btnReturn:setTriggleSound(res.Sound.back)
	self._bg_order1_topBar_btnReturn:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)

	self._screenBtn:setPenetrate(false)
	self._screenBtn:setTriggleSound("")
	self._screenBtn:setListener(function ( ... )
		if #self.animFinishFuncs>0 then
			self:finishAnims()
			if self.cachedViewUpdateFunc then
				self.cachedViewUpdateFunc()
				self.cachedViewUpdateFunc = nil
			else
				if self.curViewType == ViewType.Strengthen then
					return self:showStrengthenView()
				elseif self.curViewType == ViewType.Reform then
					return self:showReformView()
				elseif self.curViewType == ViewType.Refine then
					return self:showRefineView()
				elseif self.curViewType == ViewType.Rebirth then
					return self:showRebirthView(true)
				end
			end
		end
	end)
	self._screenBtn:setVisible(false)

	local function updateNextDataIndex(nextIndexFunc)
		if self.curViewType == ViewType.Strengthen  then
			nextIndexFunc()
		elseif (self.curViewType == ViewType.Rebirth or self.curViewType == ViewType.Reform) then
			repeat
				nextIndexFunc()
			until self.equipList[self.equipIndex].Star >=3
		elseif self.curViewType == ViewType.Refine then
			repeat
				nextIndexFunc()
			until (self.equipList[self.equipIndex].Star >=3 and self.equipList[self.equipIndex].Lv>=20)
		end
	end

	self._btnLeft:setListener(function ( ... )
		updateNextDataIndex(function (  )
			self.equipIndex = self.equipIndex - 1
			if self.equipIndex <=0 then
				self.equipIndex = #self.equipList
			end
		end)
		self.equipInfo = self.equipList[self.equipIndex]
		self.dbInfo = dbManager.getInfoTreasure(self.equipInfo.MibaoId)
		self:onEquipChange()
	end)

	self._btnRight:setListener(function ( ... )
		updateNextDataIndex(function (  )
			self.equipIndex = self.equipIndex + 1
			if self.equipIndex > #self.equipList then
				self.equipIndex = 1
			end
		end)
		self.equipInfo = self.equipList[self.equipIndex]
		self.dbInfo = dbManager.getInfoTreasure(self.equipInfo.MibaoId)
		self:onEquipChange()
	end)
 
	return tabBtns
end

function DMibaoOp:onEquipChange( ... )
	for _,v in pairs(self.views) do
		v[1]:removeFromParentAndCleanup(true)
	end
	self.views = {}
	self.equipProSet[1]:removeFromParentAndCleanup(true)
	self.equipProSet = nil
	self.mLvUpMaterialList = nil
	self.mSelectMPet = nil
	self.mLayoutAfterSet = nil
	self:updateView()
    -- GuideHelper:check('onEquipChange')
end

function DMibaoOp:onEquipModify( new )
	-- local index = table.indexOf(self.equipList, self.equipInfo)
	-- self.equipList[index] = new
	-- self.equipInfo = new
	self.equipInfo.Lv = new.Lv
	self.equipInfo.Exp = new.Exp
	self.equipInfo.ForgeTimes = new.ForgeTimes
	self.equipInfo.CanForge = new.CanForge
	self.equipInfo.Effect = new.Effect
	self.equipInfo.Addition = new.Addition
	self.equipInfo.SetIn = new.SetIn
	self.equipInfo.RefineLv = new.RefineLv
	self.equipInfo.Amount = new.Amount
end

function DMibaoOp:finishAnims( ... )
	for _,v in ipairs(self.animFinishFuncs) do
		v()
	end
	self.animFinishFuncs = {}

	if self.cachedUpdateFunc then
		self.cachedUpdateFunc()
		self.cachedUpdateFunc = nil
	end
	for _,v in ipairs(self.tickHandle) do
		require "framework.sync.TimerHelper".cancel(v)
	end
	self.tickHandle = {}

	self._screenBtn:setVisible(false)
end

function DMibaoOp:onTabChanged( ... )
	self:finishAnims()
	self:hiddenToast()
	self.cachedViewUpdateFunc = nil
end

function DMibaoOp:updateView( ... )
	local funcViewMap = {[ViewType.Strengthen] = self.showStrengthenView,
				[ViewType.Reform] = self.showReformView,
				[ViewType.Refine] = self.showRefineView,
				-- [ViewType.Mosaic] = self.showMosaicView,
				[ViewType.Rebirth] = self.showRebirthView
			}
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
	self._btnLeft:setVisible(#self.equipList > 1)
	self._btnRight:setVisible(#self.equipList > 1)
end

function DMibaoOp:showStrengthenAnim( data,func )
	local anim1 = self:createLuaSet("@strengthen1")[1]
	self.equipViewSet["equipBg_anim"]:addChild(anim1)
	anim1:setVisible(false)
	anim1:setLoops(1)
	self.tickHandle[#self.tickHandle+1] =  require "framework.sync.TimerHelper".tick(function ( ... )
		anim1:setVisible(true)
		anim1:start()
		return true
	end,0.1)

	self.tickHandle[#self.tickHandle+1] =  require "framework.sync.TimerHelper".tick(function ( ... )
       		anim1:removeFromParentAndCleanup(true)
       		if #self.effectIds>0 then
			require 'framework.helper.MusicHelper'.stopEffect(table.remove(self.effectIds,1))
		end
      		func()
	      	return true
	end,1.5)

	self._screenBtn:setVisible(true)
	self.effectIds[#self.effectIds+1] = require 'framework.helper.MusicHelper'.playEffect("raw/ui_sfx_equipupgrade.mp3")
end

function DMibaoOp:showStrengthenView( ... )
	self:updateEquipView(set,self.equipInfo)

	self.mLvUpMaterialList = self.mLvUpMaterialList or {}
	-- self.mProgressBarAnimParam =  {}
	local curPer,addPer,lvLimit

	local set  = self.views[ViewType.Strengthen] 
	if not set then
		set = self:createLuaSet("@pageStrengthen")

		set["strengthenDetailBg_ZB_wenzi0_subTitle"]:setString(string.format("%s%s",res.locString("Mibao$OpTitle"),res.locString("Mibao$OpTab1")))
		require 'LangAdapter'.fontSize(set["strengthenDetailBg_#strengthenDes"],nil,nil,16,16,nil,nil,nil,nil,nil,16)
		
		require "LangAdapter".LabelNodeAutoShrink(set["strengthenDetailBg_autoStrengthenBtn_#btntext"],105)

		set["strengthenDetailBg_autoStrengthenBtn"]:setListener(function ( ... )
			local list = self:getSortedMibaoListForLvUpMaterial(true)
			if #list<=0 then
				return self:toast(res.locString("Mibao$NoStrengthenMaterialTip"))
			else
				local maxExp = dbManager.getInfoMibaoLvUpConfig(self.dbInfo.Star,toolkit.getMibaoLevelCap(self.dbInfo.Star)).Exp
				local curExp = self.equipInfo.Exp
				if curExp < maxExp then
					for i=1,6 do
						local m = list[i]
						if m then
							self.mLvUpMaterialList[i] = m
							curExp = curExp + calculateTool.getMibaoExpProvide(m)
							if curExp>=maxExp then
								break
							end
						end
					end
				end
				return self:showStrengthenView()
			end
		end)

		set["strengthenDetailBg_strengthenBtn"]:setListener(function ( ... )
			if #self.mLvUpMaterialList<=0 then
				return self:toast(res.locString("Mibao$InputStrengthenMaterialTip"))
			elseif self.mStrengthenNeedGold>require "UserInfo".getGold() then
				return self:toast(res.locString("Mibao$StrengthenGoldNotEnough"))
			end
			local needRebirthMaterialList = {}
			local ids = {}
			for i,v in ipairs(self.mLvUpMaterialList) do
				if v.ForgeTimes>0 then
					needRebirthMaterialList[#needRebirthMaterialList+1] = v
				end
				ids[#ids+1] = v.Id
			end

			local sendFunc = function (  )
				self:send(netModel.getMibaoStrength(self.equipInfo.Id,ids),function ( data )
					-- GuideHelper:check('EquipUpgrade')
					self.cachedUpdateFunc = function (  )
						if data.D.Pet then
							require "PetInfo".setPet(data.D.Pet)
						end
						self:onEquipModify(data.D.Mibao)
						require "MibaoInfo".setMibao(self.equipInfo)
						require "MibaoInfo".removeMibaoList(self.mLvUpMaterialList)
						for _,v in ipairs(self.mLvUpMaterialList) do
							for i,vv in ipairs(self.equipList) do
								if vv.Id == v.Id then
									table.remove(self.equipList,i)
									break
								end
							end
						end
						
						self.mLvUpMaterialList = {}
						require "UserInfo".setData(data.D.Role)
						-- GuideHelper:check('AnimtionEnd')
						eventcenter.eventInput("OnMibaoUpdate")
					end
					self.animFinishFuncs[#self.animFinishFuncs+1] = function ( ... )
						self.equipViewSet["equipBg_anim"]:removeAllChildrenWithCleanup(true)
						if #self.effectIds>0 then
							require 'framework.helper.MusicHelper'.stopEffect(table.remove(self.effectIds,1))
						end
						self._screenBtn:setVisible(false)
					end
					return self:showStrengthenAnim(data,function ( ... )
				           	self:showProgressBarAnim(function (  )
				           		self.cachedUpdateFunc()
							self.cachedUpdateFunc = nil
							table.remove(self.animFinishFuncs,1)()
							return self:showStrengthenView()
				           	end,unpack(self.mProgressBarAnimParam))
					end)
				end)
			end

			if #needRebirthMaterialList>0 then
				local param = {}
				param.content = res.locString("Mibao$StrengthenRebirthTip")
				param.LeftBtnText = res.locString("Equip$Rebirth")
				param.RightBtnText = res.locString("Mibao$OpTab1")
				param.callback = function ( ... )
					sendFunc()
				end
				param.cancelCallback = function ( ... )
					-- local unLockManager = require "UnlockManager"
					-- if unLockManager:isUnlock("EquipRebirth") then
						GleeCore:showLayer("DMibaoOp", {Info = needRebirthMaterialList[1], ViewType = ViewType.Rebirth, List = needRebirthMaterialList}, 0)
					-- else
					-- 	self:toast(string.format(res.locString("Home$LevelUnLockTip"), unLockManager:getUnlockLv("EquipRebirth")))
					-- end
				end
				param.clickClose = true
				GleeCore:showLayer("DConfirmNT",param)
			else
				sendFunc()
			end
		end)

		set["strengthenDetailBg_materialBg_btn"]:setListener(function ( ... )
			local param = {
				ListData = self:getSortedMibaoListForLvUpMaterial(),
				LimitCount = 6,
				SelectedList = self.mLvUpMaterialList,
				OnCompleted = function ( list )
					self.mLvUpMaterialList = list
					self:showStrengthenView()
				end
			}
			GleeCore:showLayer("DMibaoChoseMultiple",param)
		end)

		self.views[ViewType.Strengthen] = set
		self._bg:addChild(set[1])
	end
	

	local isGoldEnough
	-- local isLevelLimit = self.equipInfo.Lv>=self.equipInfo.levelMax
	-- if isLevelLimit then
	-- 	status = self:isTpLevelLimit() and 3 or 2
	-- end
	local canLvUp = false
	-- for st = 1,3 do
	-- 	set[string.format("strengthenDetailBg_strengthenInfoBg_status%d",st)]:setVisible(st == status)
	-- end

	local hasGold = require "UserInfo".getGold()

	set["strengthenDetailBg_materialBg_mLayout"]:removeAllChildrenWithCleanup(true)
	local expProvide = 0
	for i=1,6 do
		local mset
		local m = self.mLvUpMaterialList[i]
		if m then
			expProvide = expProvide + calculateTool.getMibaoExpProvide(m)
			mset = self:createLuaSet("@mItem")
			res.setNodeWithTreasure(mset["icon"],m)
		else
			mset = self:createLuaSet("@mItemDefault")
			selectLang(nil,nil,function (  )
				mset["#label"]:setFontSize(13)
			end,nil,function (  )
				mset["#label"]:setDimensions(CCSize(0,0))
				require 'LangAdapter'.LabelNodeAutoShrink(mset["#label"],75)
			end)
		end
		set["strengthenDetailBg_materialBg_mLayout"]:addChild(mset[1])
	end


	local levelLimit = self.equipInfo.Lv >= toolkit.getMibaoLevelCap(self.dbInfo.Star)
	local lvUpConfig = dbManager.getInfoMibaoLvUpConfig(self.dbInfo.Star,self.equipInfo.Lv)
	local per,expCap
	if levelLimit then
		per = 1
		expCap = 0
	else
		local lvUpConfig1 = dbManager.getInfoMibaoLvUpConfig(self.dbInfo.Star,self.equipInfo.Lv+1)
		expCap = lvUpConfig1.Exp - lvUpConfig.Exp
		per = (self.equipInfo.Exp - lvUpConfig.Exp) /expCap
	end
	curPer = per
	set["strengthenDetailBg_strengthenInfoBg_status1_layout"]:removeAllChildrenWithCleanup(true)
	local expBar = self:createLuaSet("@expBar")
	expBar["progressBg_p"]:setPercentage(per*100)
	set["strengthenDetailBg_strengthenInfoBg_status1_layout"]:addChild(expBar[1])

	local expAfter = self.equipInfo.Exp - lvUpConfig.Exp + expProvide
	local lvAfter = self.equipInfo.Lv
	if expAfter>=expCap then
		lvAfter = self:getLvAfterByExp(expAfter+lvUpConfig.Exp)
		canLvUp = lvAfter>self.equipInfo.Lv
	end

	local lvBar = self:createLuaSet("@proBar")
	lvBar["name"]:setString(res.locString("Global$Level"))
	lvBar["before"]:setString(self.equipInfo.Lv)
	if #self.mLvUpMaterialList>0 and not levelLimit then
		lvBar["after"]:setString(lvAfter)
		lvBar["icon"]:setVisible(true)
		lvBar["after"]:setVisible(true)
	else
		lvBar["icon"]:setVisible(false)
		lvBar["after"]:setVisible(false)
	end
	set["strengthenDetailBg_strengthenInfoBg_status1_layout"]:addChild(lvBar[1])

	local proBar = self:createLuaSet("@proBar")
	proBar["name"]:setString(self:getProName())
	proBar["before"]:setString(string.format("+%.1f%%",self.equipInfo.Effect*100))
	if #self.mLvUpMaterialList>0 and not levelLimit then
		proBar["after"]:setString(string.format("+%.1f%%",(dbManager.getInfoMibaoLvUpConfig(self.dbInfo.Star,lvAfter).Effect)*100))
		proBar["icon"]:setVisible(true)
		proBar["after"]:setVisible(true)
	else
		proBar["icon"]:setVisible(false)
		proBar["after"]:setVisible(false)
	end
	set["strengthenDetailBg_strengthenInfoBg_status1_layout"]:addChild(proBar[1])

	if canLvUp and  self.dbInfo.Star>=3  then
		local count = math.floor(lvAfter/5) - math.floor(self.equipInfo.Lv/5)
		if count>0 then
			local tipSet = self:createLuaSet("@reformCountAddTip")
			require "LangAdapter".nodePos(tipSet["value"],ccp(-7,0),nil,nil,nil,ccp(-7,0))
			tipSet["value"]:setString("+"..count)
			set["strengthenDetailBg_strengthenInfoBg_status1_layout"]:addChild(tipSet[1])
		end
	end

	set["strengthenDetailBg_#GoldCostLabel"]:setVisible(true)

	self.mStrengthenNeedGold = expProvide * dbManager.getInfoDefaultConfig("MibaoCostGold").Value
	set["strengthenDetailBg_GoldCostLabel_goldLayout_GoldCostValueLabel"]:setString(self.mStrengthenNeedGold)
	isGoldEnough = hasGold>=self.mStrengthenNeedGold
	if not isGoldEnough then
		set["strengthenDetailBg_GoldCostLabel_goldLayout_GoldCostValueLabel"]:setFontFillColor(res.color4F.red,true)
	else
		set["strengthenDetailBg_GoldCostLabel_goldLayout_GoldCostValueLabel"]:setFontFillColor(res.color4F.white,true)
	end
	-- local needRoleLevel = dbManager.getInfoEquipNeedRoleLevel(self.equipInfo.Lv+1)
	-- isRoleLevelLimit = needRoleLevel>require "UserInfo".getLevel()
	-- set["strengthenDetailBg_GoldCostLabel_lvLayout_userLvNeed"]:setString(string.format("Lv.%d",needRoleLevel))
	-- if isRoleLevelLimit then
	-- 	set["strengthenDetailBg_GoldCostLabel_lvLayout_userLvNeed"]:setFontFillColor(res.color4F.red,true)
	-- end
	-- set["strengthenDetailBg_autoStrengthenBtn"]:setEnabled(enable)
	set["strengthenDetailBg_strengthenBtn"]:setEnabled(not levelLimit)
	-- set["strengthenDetailBg_autoStrengthenBtn"]:setOpacity(enable and 255 or 128)

	-- GuideHelper:registerPoint('升级',set['strengthenDetailBg_strengthenBtn'])

	if not levelLimit and expProvide>0 then
		local percent
		if canLvUp then
			if lvAfter == toolkit.getMibaoLevelCap(self.dbInfo.Star) then
				percent = 1
				addPer = 1 - curPer + (lvAfter - self.equipInfo.Lv - 1)
				lvLimit = true
			else
				local config1 = dbManager.getInfoMibaoLvUpConfig(self.dbInfo.Star,lvAfter)
				local exp = expAfter+lvUpConfig.Exp - config1.Exp
				local config2 = dbManager.getInfoMibaoLvUpConfig(self.dbInfo.Star,lvAfter+1)
				percent = exp/(config2.Exp - config1.Exp)
				addPer = 1 - curPer + (lvAfter - self.equipInfo.Lv - 1) + percent
			end
		else
			percent = expAfter/expCap
			addPer = percent - curPer
		end
		expBar["progressBg_p"]:setPercentage(percent*100)
		expBar["progressBg_p"]:runElfAction(self._RepeatForever:clone())
	else
		expBar["progressBg_p"]:stopAllActions()
	end
	self.mProgressBarAnimParam = { expBar["progressBg_p"],curPer,addPer,lvLimit}
end

function DMibaoOp:showProgressBarAnim( finishFunc,bar,curPercent,addPercent,LvMax )
	curPercent = curPercent*100
	addPercent = addPercent*100 
	local cap = LvMax and 101 or 100
	bar:stopAllActions()
	bar:setColorf(1, 1, 1, 1)
	bar:setPercentage(curPercent)
	self.tickHandle[#self.tickHandle+1] =  require "framework.sync.TimerHelper".tick(function ( ... )
		if addPercent>0 then
			local add = math.min(15,addPercent)
			curPercent = math.floor(curPercent+add)%cap
			bar:setPercentage(curPercent)
			addPercent = addPercent - add
		else
			finishFunc()
			return true
		end
	end)
end

function DMibaoOp:showReformView( )
	self:updateEquipView(set,self.equipInfo)

	-- self.mSelectMPet = self.mSelectMPet or nil

	local set  = self.views[ViewType.Reform]

	if not set then
		set = self:createLuaSet("@pageReform")

		set["reformDetailBg_ZB_wenzi0_subTitle"]:setString(string.format("%s%s",res.locString("Mibao$OpTitle"),res.locString("Mibao$OpTab2")))
		set["reformDetailBg_reformInfoBg_layout_name"]:setString(string.format(res.locString("Mibao$ExName"),self:getProName()))

		require 'LangAdapter'.fontSize(set["reformDetailBg_#strengthenDes"],nil,nil,16,16,16)
		require 'LangAdapter'.fontSize(set["reformDetailBg_reformNeedBg_petIcon_default_#label"],nil,nil,nil,nil,12)
        		-- GuideHelper:registerPoint('重铸',set['reformDetailBg_reformBtn'])

        		set["reformDetailBg_reformNeedBg_btn"]:setListener(function ( ... )
        			-- if self.equipInfo.CanForge<=0 then
        			-- 	return
        			-- end
        			local list = require "PetInfo".getPetListForMix()
        			print(list)
        			local list2 = {}
        			local zizhi =  dbManager.getInfoMibaoForgeConfig(self.dbInfo.Star,self.equipInfo.ForgeTimes+1).PetQuality
        			print(zizhi)
        			local function fit( v )
        				local dbPet = dbManager.getCharactor(v.PetId)
        				if dbPet.quality == zizhi then
        					if self.equipInfo.Type == 1 then
        						return table.find(self.equipInfo.Property,dbPet.prop_1)
        					elseif self.equipInfo.Type == 2 then
        						return table.find(self.equipInfo.Property,dbPet.atk_method_system)
        					end
        				else
        					return false
        				end
        			end
        			for _,v in ipairs(list) do
        				if not v.Archived and fit(v) then
        					list2[#list2+1] = v
        				end
        			end
        			local selected = {self.mSelectMPet}
        			local param = {
        				petlist = list2,
        				selected = selected,
        				sortFunc = function ( l )
        					table.sort(l,function ( a,b )
        						local sA = table.find(selected,a)
        						local sB = table.find(selected,b)
        						if sA == sB then
        							return a.Lv<b.Lv
        						else
        							return sA
        						end
        					end)
        				end,
        				funcChosePet = function ( id )
        					self.mSelectMPet = require "PetInfo".getPetWithId(id)
        					self:showReformView()
        					return true
        				end
        			}
        			GleeCore:showLayer("DPetChose",param)
        		end)

		set["reformDetailBg_reformBtn"]:setListener(function ( ... )
			if self.equipInfo.CanForge<=0 then
				if self:canIncreaseForgeCount() then
					return self:toast(res.locString("Mibao$ForgeCountZeroTip1"))
				else
					return self:toast(res.locString("Mibao$ForgeCountZeroTip2"))
				end
			elseif self.mReformNeedGold>require "UserInfo".getGold() then
				return self:toast(res.locString("Mibao$ForgeGoldNotEnough"))
			elseif not self.mSelectMPet then
				return self:toast(res.locString("Mibao$MibaoForgePetInputTip"))
			end
			self:send(netModel.getMibaoForge(self.equipInfo.Id,{self.mSelectMPet.Id}),function ( data )
                			-- GuideHelper:check('RebirthDone')
				self.cachedUpdateFunc = function(  )
					print(data)
					if data.D.Pet then
						require "PetInfo".setPet(data.D.Pet)
					end
					self:onEquipModify(data.D.Mibao)
					require "UserInfo".setData(data.D.Role)
					require "MibaoInfo".setMibao(self.equipInfo)
					require "PetInfo".removePetById(self.mSelectMPet.Id)
					self.mSelectMPet = nil
					eventcenter.eventInput("OnMibaoUpdate")
				end

				local anim = self:createLuaSet("@reform1")[1]
				anim:setLoops(1)
				anim:setListener(function ( ... )
					table.remove(self.animFinishFuncs,1)()
					self.cachedUpdateFunc()
					self.cachedUpdateFunc = nil
					return self:showReformView()
				end)
				self.equipViewSet["equipBg_anim"]:addChild(anim)
				anim:start()
				self._screenBtn:setVisible(true)
				self.animFinishFuncs[#self.animFinishFuncs+1] = function ( ... )
					self._screenBtn:setVisible(false)
					anim:removeFromParentAndCleanup(true)
					require 'framework.helper.MusicHelper'.stopAllEffects()
				end
				require 'framework.helper.MusicHelper'.playEffect("raw/ui_sfx_reforge.mp3")
			end)
		end)
		self.views[ViewType.Reform] = set
		self._bg:addChild(set[1])
	end

	local reformConfig = dbManager.getInfoMibaoForgeConfig(self.dbInfo.Star,self.equipInfo.ForgeTimes+1)
	set["reformDetailBg_reformInfoBg_layout_before"]:setString(string.format("+%.1f%%",self.equipInfo.Addition*100))
	if reformConfig and self:canIncreaseForgeCount() then
		if not self.mLayoutAfterSet then
			self.mLayoutAfterSet = self:createLuaSet("@layoutAfter")
			set["reformDetailBg_reformInfoBg_layout"]:addChild(self.mLayoutAfterSet[1])
		end
		self.mLayoutAfterSet["after"]:setString(string.format("+%.1f%%",(self.equipInfo.Addition+reformConfig.Effect)*100))
	else
		if self.mLayoutAfterSet then
			self.mLayoutAfterSet[1]:removeFromParentAndCleanup(true)
			self.mLayoutAfterSet = nil
		end
	end

	self.mReformNeedGold = reformConfig and reformConfig.Gold or 0
	set["reformDetailBg_reformNeedBg_goldNeed"]:setString(string.format(res.locString("Mibao$ReformGoldNeed"),self.mReformNeedGold))
	if self.mSelectMPet then
		res.setPetDetail(set["reformDetailBg_reformNeedBg_petIcon_pet"],self.mSelectMPet)
		set["reformDetailBg_reformNeedBg_petName"]:setString(self.mSelectMPet.Name)
		set["reformDetailBg_reformNeedBg_petName"]:setFontFillColor(res.rankColor4F[res.getFinalAwake(self.mSelectMPet.AwakeIndex)],true)
		set["reformDetailBg_reformNeedBg_petIcon_pet"]:setVisible(true)
		set["reformDetailBg_reformNeedBg_petName"]:setVisible(true)
	else
		set["reformDetailBg_reformNeedBg_petIcon_pet"]:setVisible(false)
		set["reformDetailBg_reformNeedBg_petName"]:setVisible(false)
	end	
	set["reformDetailBg_lastReformCountLayout_value"]:setString(self.equipInfo.CanForge)
end

function DMibaoOp:showRebirthView( hasRebirth )
	self:updateEquipView(set,self.equipInfo)

	local set  = self.views[ViewType.Rebirth]
	local cost = self.dbInfo.ReforgeCost

	local function showEquip( node,equip,gray )
		if gray then
			node:setColorf(0.5,0.5,0.5,1)
		else
			node:setColorf(1,1,1,1)
		end
		local children = node:getChildren()
		local icon = children:objectAtIndex(0)
		tolua.cast(icon,"ElfNode")
		res.setNodeWithTreasure(icon,equip)

		-- local temp = children:objectAtIndex(1)
		-- tolua.cast(temp,"LabelNode")
		-- temp:setString(self.dbInfo.Name)
		
		local temp = children:objectAtIndex(1)
		tolua.cast(temp,"LinearLayoutNode")
		local name,lvIconRes = toolkit.getMibaoName(equip)
		temp:removeAllChildrenWithCleanup(true)
		if lvIconRes then
			local refineIcon = self:createLuaSet("@refineLvIcon")[1]
			refineIcon:setResid(lvIconRes)
			temp:addChild(refineIcon)
		end
		local nameNode = self:createLuaSet("@equipName")[1]
		nameNode:setString(name)
		temp:addChild(nameNode)


		temp = children:objectAtIndex(2)
		tolua.cast(temp,"LabelNode")
		temp:setString(string.format("%s: %d",res.locString("Mibao$ReformCount"),equip.ForgeTimes))
		require 'LangAdapter'.LabelNodeAutoShrink(temp,110)
	end

	if not set then
		set = self:createLuaSet("@pageRebirth")

		set["reformDetailBg_ZB_wenzi0_subTitle"]:setString(string.format("%s%s",res.locString("Mibao$OpTitle"),res.locString("Equip$Rebirth")))

		require 'LangAdapter'.fontSize(set["reformDetailBg_#strengthenDes"],nil,nil,16,16)

		set["reformDetailBg_reformBtn"]:setListener(function ( ... )
			if  require "UserInfo".getCoin()<cost then
				return toolkit.showDialogOnCoinNotEnough()
			end
			local param = {}
			param.content = res.locString("Mibao$RebirthTip")
			param.callback = function ( ... )
				self:send(netModel.getMibaoRebirth(self.equipInfo.Id),function ( data )
					self.cachedUpdateFunc = function ( ... )
						print(data)
						require "AppData".updateResource(data.D.Resource)
						self:onEquipModify(data.D.Mibao)
						require "MibaoInfo".setMibao(self.equipInfo)
						if data.D.Pet then
							require "PetInfo".setPet(data.D.Pet)
						end
						eventcenter.eventInput("OnMibaoUpdate")
					end
					self.cachedViewUpdateFunc = function ( ... )
						self:updateEquipView(set,self.equipInfo)
						self:updateCurHasBar(set["reformDetailBg_#detailTitle"],require "UserInfo".getGold(),require "UserInfo".getCoin())
						set["reformDetailBg_reformInfoBg_left"]:setColorf(0.5,0.5,0.5,1)
						set["reformDetailBg_reformInfoBg_right"]:setColorf(1,1,1,1)
						set["reformDetailBg_reformBtn"]:setEnabled(false)
						set["reformDetailBg_reformBtn"]:setOpacity(128)
						if data.D.Reward then
							GleeCore:showLayer("DGetReward", data.D.Reward)
						end
					end

					local anim1 = self:createLuaSet("@anim")[1]
					local ids = {}
					for i=1,anim1:getResidArraySize() do
						ids[i] = anim1:getResidByIndex(i-1)
					end
					anim1:clearResidArray()
					for i=#ids,1,-1 do
						anim1:addResidToArray(ids[i])
					end
					set["reformDetailBg_reformInfoBg_left"]:addChild(anim1)
					anim1:setLoops(1)
					anim1:start()

					local anim2 = self:createLuaSet("@anim")[1]
					set["reformDetailBg_reformInfoBg_right"]:addChild(anim2)
					anim2:setListener(function ( ... )
						print("-------anim2 end--------")
						table.remove(self.animFinishFuncs,1)()
						self.cachedUpdateFunc()
						self.cachedUpdateFunc = nil
						self.cachedViewUpdateFunc()
						self.cachedViewUpdateFunc = nil
					end)
					anim2:setLoops(1)
					anim2:start()
					self._screenBtn:setVisible(true)
					self.animFinishFuncs[#self.animFinishFuncs+1] = function ( ... )
						self._screenBtn:setVisible(false)
						anim1:removeFromParentAndCleanup(true)
						anim2:removeFromParentAndCleanup(true)
						require 'framework.helper.MusicHelper'.stopAllEffects()
					end
					require 'framework.helper.MusicHelper'.playEffect("raw/ui_sfx_melt.mp3")
				end)
			end
			GleeCore:showLayer("DConfirmNT",param)
		end)
		self.views[ViewType.Rebirth] = set
		self._bg:addChild(set[1])
	end

	self:updateCurHasBar(set["reformDetailBg_#detailTitle"],require "UserInfo".getGold(),require "UserInfo".getCoin())

	set["reformDetailBg_DiamondCostLabel_DiamondCostValueLabel"]:setString(cost)

	local enable = self.equipInfo.ForgeTimes > 0 or self.equipInfo.RefineLv > 0
	set["reformDetailBg_reformBtn"]:setEnabled(enable)
	set["reformDetailBg_reformBtn"]:setOpacity(enable and 255 or 128)
	
	showEquip(set["reformDetailBg_reformInfoBg_left"],self.equipInfo,hasRebirth)
	local temp = table.clone(self.equipInfo)
	temp.ForgeTimes = 0
	temp.RefineLv = 0
	showEquip(set["reformDetailBg_reformInfoBg_right"],temp,not hasRebirth)
end

function DMibaoOp:showRefineView( )
	self:updateEquipView(set,self.equipInfo)

	local set  = self.views[ViewType.Refine]
	local refineConfig = dbManager.getInfoMibaoRefineConfig(self.equipInfo.Type,self.equipInfo.Star,self.equipInfo.RefineLv)
	local cost = refineConfig.GoldCost

	local function showEquip( node,equip )
		local children = node:getChildren()
		local icon = children:objectAtIndex(0)
		tolua.cast(icon,"ElfNode")
		res.setNodeWithTreasure(icon,equip)
		local temp = children:objectAtIndex(1)
		tolua.cast(temp,"LinearLayoutNode")
		local name,lvIconRes = toolkit.getMibaoName(equip)
		temp:removeAllChildrenWithCleanup(true)
		if lvIconRes then
			local refineIcon = self:createLuaSet("@refineLvIcon")[1]
			refineIcon:setResid(lvIconRes)
			temp:addChild(refineIcon)
		end
		local nameNode = self:createLuaSet("@equipName")[1]
		nameNode:setString(name)
		temp:addChild(nameNode)

		temp = children:objectAtIndex(2)
		tolua.cast(temp,"LabelNode")
		temp:setString(string.format("%s+%d",self:getProName(equip),toolkit.getMibaoRefineProAdd(equip)))
	end

	if not set then
		set = self:createLuaSet("@pageRefine")

		set["reformDetailBg_ZB_wenzi0_subTitle"]:setString(string.format("%s%s",res.locString("Mibao$OpTitle"),res.locString("Mibao$OpTab3")))

		require 'LangAdapter'.fontSize(set["reformDetailBg_strengthenDes"],nil,nil,16,16)

		selectLang(nil,nil,function (  )
			set["reformDetailBg_reformInfoBg_newProTip"]:setPosition(-210,-66)
			set["reformDetailBg_reformInfoBg_newProTip_#label"]:setAnchorPoint(ccp(0.5,1))
			set["reformDetailBg_reformInfoBg_newProTip_des"]:setAnchorPoint(ccp(0.5,1))
			local w = set["reformDetailBg_reformInfoBg_newProTip_#label"]:getContentSize().width
			set["reformDetailBg_reformInfoBg_newProTip_des"]:setDimensions(CCSize(450-w,0))
		end)
		
		set["reformDetailBg_reformBtn"]:setListener(function ( ... )
			if  require "UserInfo".getGold()<cost then
				return self:toast(res.locString("Mibao$RefineGoldNotEnough"))
			end
			local function sendFunc(  )
				self:send(netModel.getMibaoRefine(self.equipInfo.Id,self.mRefineMaterial.Id),function ( data )
					self.cachedUpdateFunc = function ( ... )
						print(data)
						require "UserInfo".setData(data.D.Role)
						self:onEquipModify(data.D.Mibao)
						require "MibaoInfo".setMibao(self.equipInfo)
						require "MibaoInfo".removeMibao(self.mRefineMaterial)
						self.mRefineMaterial = nil
						if data.D.Pet then
							require "PetInfo".setPet(data.D.Pet)
						end
						eventcenter.eventInput("OnMibaoUpdate")		
					end
					-- self.cachedViewUpdateFunc = function ( ... )
					-- 	self:updateEquipView(set,self.equipInfo)
					-- 	self:updateCurHasBar(set["reformDetailBg_#detailTitle"],require "UserInfo".getGold(),require "UserInfo".getCoin())
					-- 	-- set["reformDetailBg_reformInfoBg_left"]:setColorf(0.5,0.5,0.5,1)
					-- 	-- set["reformDetailBg_reformInfoBg_right"]:setColorf(1,1,1,1)
					-- 	-- set["reformDetailBg_reformBtn"]:setEnabled(false)
					-- 	-- set["reformDetailBg_reformBtn"]:setOpacity(128)
					-- 	if data.D.Reward then
					-- 		GleeCore:showLayer("DGetReward", data.D.Reward)
					-- 	end
					-- end

					local anim1 = self:createLuaSet("@anim")[1]
					local ids = {}
					for i=1,anim1:getResidArraySize() do
						ids[i] = anim1:getResidByIndex(i-1)
					end
					anim1:clearResidArray()
					for i=#ids,1,-1 do
						anim1:addResidToArray(ids[i])
					end
					set["reformDetailBg_reformInfoBg_leftBg_left"]:addChild(anim1)
					anim1:setLoops(1)
					anim1:start()

					local anim2 = self:createLuaSet("@anim")[1]
					set["reformDetailBg_reformInfoBg_right"]:addChild(anim2)
					anim2:setListener(function ( ... )
						print("-------anim2 end--------")
						table.remove(self.animFinishFuncs,1)()
						self.cachedUpdateFunc()
						self.cachedUpdateFunc = nil
						return self:showRefineView()
					end)
					anim2:setLoops(1)
					anim2:start()
					self._screenBtn:setVisible(true)
					self.animFinishFuncs[#self.animFinishFuncs+1] = function ( ... )
						self._screenBtn:setVisible(false)
						anim1:removeFromParentAndCleanup(true)
						anim2:removeFromParentAndCleanup(true)
						require 'framework.helper.MusicHelper'.stopAllEffects()
					end
					require 'framework.helper.MusicHelper'.playEffect("raw/ui_sfx_melt.mp3")
				end)
			end
			if self.mRefineMaterial.Lv>1 then
				local param = {}
				param.content = res.locString("Mibao$RefineTip")
				param.callback = function ( ... )
					sendFunc()
				end
				GleeCore:showLayer("DConfirmNT",param)
			else
				sendFunc()
			end
		end)
		self.views[ViewType.Refine] = set
		self._bg:addChild(set[1])
	end

	self:updateCurHasBar(set["reformDetailBg_#detailTitle"],require "UserInfo".getGold(),require "UserInfo".getCoin())

	local enable = self.mRefineMaterial~=nil
	set["reformDetailBg_reformBtn"]:setEnabled(enable)
	set["reformDetailBg_reformBtn"]:setOpacity(enable and 255 or 128)
	
	showEquip(set["reformDetailBg_reformInfoBg_leftBg_left"],self.equipInfo)
	local temp
	local nextRefineConfig = toolkit.getMibaoNextRefineConfig(self.equipInfo)
	if not nextRefineConfig then
		temp = self.equipInfo
		set["reformDetailBg_reformInfoBg_newProTip"]:setVisible(false)
		set["reformDetailBg_strengthenDes"]:setVisible(false)
		set["reformDetailBg_reformInfoBg_leftBg_material_btn"]:setListener(function (  )
			return self:toast(res.locString("Mibao$RefineMaxTip"))
		end)
		set["reformDetailBg_DiamondCostLabel"]:setVisible(false)
		set["reformDetailBg_refineMaxTip"]:setVisible(true)
	else
		temp = table.clone(self.equipInfo)
		temp.RefineLv = temp.RefineLv + 1
		if nextRefineConfig.Unlock and string.len(nextRefineConfig.Unlock)>0 then
			set["reformDetailBg_reformInfoBg_newProTip"]:setVisible(true)
			set["reformDetailBg_reformInfoBg_newProTip_des"]:setString(nextRefineConfig.Unlock)
			if set["reformDetailBg_reformInfoBg_newProTip_des"]:getContentSize().height>34 then
				set["reformDetailBg_reformInfoBg_newProTip_des"]:setFontSize(12)
			else
				set["reformDetailBg_reformInfoBg_newProTip_des"]:setFontSize(16)
			end
		else
			set["reformDetailBg_reformInfoBg_newProTip"]:setVisible(false)
		end
		set["reformDetailBg_strengthenDes"]:setVisible(true)
		set["reformDetailBg_strengthenDes"]:setString(res.locString("Mibao$RefineMaterialTip"..refineConfig.MibaoCost))

		set["reformDetailBg_DiamondCostLabel_DiamondCostValueLabel"]:setString(cost)
		set["reformDetailBg_DiamondCostLabel"]:setVisible(true)
		set["reformDetailBg_refineMaxTip"]:setVisible(false)

		local materials = self:getSortedMibaoListForRefineMaterial(refineConfig.MibaoCost)
		set["reformDetailBg_reformInfoBg_leftBg_material_redPoint"]:setVisible(#materials>0)
		set["reformDetailBg_reformInfoBg_leftBg_material_btn"]:setListener(function (  )
			if #materials<=0 then
				return self:toast(res.locString("Mibao$NoRefineMaterialTip"))
			else
				local param = {
					ListData = materials,
					LimitCount = 1,
					SelectedList = {self.mRefineMaterial},
					OnCompleted = function ( list )
						self.mRefineMaterial = list[1]
						self:showRefineView()
					end
				}
				GleeCore:showLayer("DMibaoChoseMultiple",param)
			end
		end)
	end
	set["reformDetailBg_reformInfoBg_leftBg_material_addicon"]:setVisible(true)
	res.setNodeWithTreasure(set["reformDetailBg_reformInfoBg_leftBg_material_materialicon"],self.mRefineMaterial)
	set["reformDetailBg_reformInfoBg_leftBg_material_materialicon"]:setVisible(true)
	set["reformDetailBg_reformInfoBg_leftBg_material_addicon"]:setResid(string.format("MB_JL_mb%d.png",self.equipInfo.Type))
	showEquip(set["reformDetailBg_reformInfoBg_right"],temp)
end

function DMibaoOp:updateCurHasBar( bar,value1,value2,icon1,icon2)
	local bg2 = bar:findNodeByName("coinBg")
	local l2 = bg2:findNodeByName("coinCountLabel")
	tolua.cast(l2,"LabelNode")
	l2:setString(self:parseValue(value2))
	local width = l2:getContentSize().width
	bg2:setContentSize(CCSizeMake(width+30,25))
	l2:setPosition(bg2:getContentSize().width/2-5,0)
	local icon = bg2:findNodeByName("#coinIcon")
	if icon2 then
		icon:setResid(icon2)
	end
	icon:setPosition(-bg2:getContentSize().width/2,0)

	local bg1 = bar:findNodeByName("goldBg")
	local x,y = bg2:getPosition()
	bg1:setPosition(x-bg2:getContentSize().width-30,y)
	local l1 = bg1:findNodeByName("goldCountLabel")
	tolua.cast(l1,"LabelNode")
	l1:setString(self:parseValue(value1))
	local width = l1:getContentSize().width
	bg1:setContentSize(CCSizeMake(width+25,25))
	l1:setPosition(bg1:getContentSize().width/2-5,0)
	local icon = bg1:findNodeByName("#GoldIcon")
	if icon1 then
		icon:setResid(icon1)
	end
	icon:setPosition(-bg1:getContentSize().width/2,0)
end

function DMibaoOp:canIncreaseForgeCount(  )
	local cap = toolkit.getMibaoLevelCap(self.dbInfo.Star)
	local lv = self.equipInfo.Lv
	return (math.floor(lv/5)+1)*5<=cap
end

function DMibaoOp:getProName( equip )
	local data = equip or self.equipInfo
	return data.Type == 1 and res.locString("PetInfo$Atk") or res.locString("PetInfo$Hp")
end

function DMibaoOp:parseValue( v )
	if v>=1000000 then
		if Config.LangName == "english" or Config.LangName == "German" then
			v = string.format("%.1fK",v/1000)
		else
			v = string.format("%.1fw",v/10000)
		end
	end
	return v
end

function DMibaoOp:updateEquipView( nodeSet,data )
	local set = self.equipViewSet
	if not set then
		set = self:createLuaSet("@equipView")
		self._bg:addChild(set[1])
		self.equipViewSet = set
	end

	local name,lvIconRes = toolkit.getMibaoName(data)
	set["equipBg_headBar_nameLayout"]:removeAllChildrenWithCleanup(true)
	if lvIconRes then
		local refineIcon = self:createLuaSet("@refineLvIcon")[1]
		refineIcon:setResid(lvIconRes)
		set["equipBg_headBar_nameLayout"]:addChild(refineIcon)
	end
	local nameNode = self:createLuaSet("@equipName")[1]
	nameNode:setString(name)
	require 'LangAdapter'.selectLang(nil, nil, nil, nil, nil, nil, nil, nil, nil, function ( ... )
		nameNode:setFontSize(16)
	end)

	set["equipBg_headBar_nameLayout"]:addChild(nameNode)

	set["equipBg_typeLayout"]:removeAllChildrenWithCleanup(true)
	if data.Type == 1 then
		for _,v in ipairs(data.Property) do
			local item = self:createLuaSet("@proIcon")[1]
			item:setResid(res.getPetPropertyIcon(v,true))
			set["equipBg_typeLayout"]:addChild(item)
		end
	elseif data.Type == 2 then
		for _,v in ipairs(data.Property) do
			local item = self:createLuaSet("@careerIcon")[1]
			item:setResid(res.getPetCareerIcon(v))
			set["equipBg_typeLayout"]:addChild(item)
		end
	end
	set["equipBg_typeLayout"]:layout()
	res.setNodeWithTreasure(set["equipBg_equipIcon"],data)

	self:updateEquipView1(nodeSet,data)
end

function DMibaoOp:updateEquipView1( nodeSet,data )
	local set = self.equipProSet
	local lvBar,proBar,proBar1,exProBar
	if not set then
		set = self:createLuaSet("@equipPro")
		self.equipProSet = set
		self._bg:addChild(set[1])

		local baseTitle = self:createLuaSet("@mbProtitle")[1]
		require 'LangAdapter'.fontSize(baseTitle,nil,nil,22,nil)
		baseTitle:setString(res.locString("Mibao$BasePro"))
		set["layout"]:addChild(baseTitle,1)

		local bar = self:createLuaSet("@mbProBar")
		require 'LangAdapter'.fontSize(bar["name"],nil,nil,18,nil)
		require 'LangAdapter'.fontSize(bar["value"],nil,nil,18,nil)
		bar["name"]:setString(res.locString("Global$Level"))
		set["layout"]:addChild(bar[1],2)
		bar[1]:setName("lvBar")
		lvBar = bar[1]

		local proName = self:getProName()
		bar = self:createLuaSet("@mbProBar")
		require 'LangAdapter'.fontSize(bar["name"],nil,nil,18,nil)
		require 'LangAdapter'.fontSize(bar["value"],nil,nil,18,nil)
		bar["name"]:setString(proName)
		set["layout"]:addChild(bar[1],3)
		bar[1]:setName("proBar")
		proBar = bar[1]

		if self.dbInfo.Star>=3 then
			local sp = self:createLuaSet("@sp")[1]
			set["layout"]:addChild(sp,5)

			local exTitle = self:createLuaSet("@mbProtitle")[1]
			require 'LangAdapter'.fontSize(exTitle,nil,nil,22,nil)
			exTitle:setString(res.locString("Mibao$ExPro"))
			set["layout"]:addChild(exTitle,6)

			local bar = self:createLuaSet("@mbProBar")
			require 'LangAdapter'.fontSize(bar["name"],nil,nil,18,nil)
			require 'LangAdapter'.fontSize(bar["value"],nil,nil,18,nil)
			bar["name"]:setString(string.format(res.locString("Mibao$ExName"),proName))
			set["layout"]:addChild(bar[1],7)
			bar[1]:setName("exProBar")
			exProBar = bar[1]

			local tip = self:createLuaSet("@mbProTip")[1]
			require 'LangAdapter'.fontSize(tip,nil,nil,18,nil)
			local mbType,mbPros = "",{}
			if data.Type == 1 then
				mbType = res.locString("Global$Pro")
				for i,v in ipairs(data.Property) do
					mbPros[i] = res.locString(string.format("PetCC$_Prop%d",v))
				end
			elseif data.Type == 2 then
				for i,v in ipairs(data.Property) do
					mbPros[i] = res.locString(string.format("Bag$Treasure%d",v))
				end
			end
			tip:setString(string.format(res.locString("Mibao$ProTipFormat"),table.concat(mbPros,"/")..mbType))
			set["layout"]:addChild(tip,8)
		end
	else
		lvBar = set["layout"]:findNodeByName("lvBar")
		proBar = set["layout"]:findNodeByName("proBar")
		exProBar = set["layout"]:findNodeByName("exProBar")
		proBar1 = set["layout"]:findNodeByName("proBar1")
	end
	set[1]:setVisible(true)

	local lvValue = lvBar:findNodeByName("value")
	tolua.cast(lvValue,"LabelNode")
	lvValue:setString(string.format("%d/%d",data.Lv,toolkit.getMibaoLevelCap(data.Star)))

	local proValue = proBar:findNodeByName("value")
	tolua.cast(proValue,"LabelNode")
	proValue:setString(string.format("+%.1f%%",data.Effect*100))

	if data.RefineLv and data.RefineLv>0 then
		if not proBar1 then
			local bar = self:createLuaSet("@mbProBar")
			bar["name"]:setString(self:getProName())
			set["layout"]:addChild(bar[1],4)
			bar[1]:setName("proBar1")
			proBar1 = bar[1]
		end
		local proValue = proBar1:findNodeByName("value")
		tolua.cast(proValue,"LabelNode")
		proValue:setString(string.format("+%d",toolkit.getMibaoRefineProAdd(data)))
	else
		if proBar1 then
			proBar1:removeFromParentAndCleanup(true)
		end
	end

	if exProBar then
		local exProValue = exProBar:findNodeByName("value")
		tolua.cast(exProValue,"LabelNode")
		exProValue:setString(string.format("+%.1f%%",data.Addition*100))
	end
end

function DMibaoOp:getLvAfterByExp( exp )
	local t = require "MibaoLvUpConfig"
	for _,v in ipairs(t) do
		if v.Star == self.dbInfo.Star and v.Exp>exp then
			return v.Lv - 1
		end
	end
	return toolkit.getMibaoLevelCap(self.dbInfo.Star)
end

function DMibaoOp:getSortedMibaoListForLvUpMaterial( auto )
	local checkSetInFunc = function ( v )
		return require "EquipInfo".getSetInStatus(v) ~=3
	end
	local checkTypeFit = function ( v )
		if v.Type == self.equipInfo.Type then
			return true
		elseif v.Type == 3 and table.find(v.Property,self.equipInfo.Type) then
			return true
		else
			return false
		end
	end
	local list = require "MibaoInfo".getMibaoList()
	local ret = {}
	for _,v in ipairs(list) do
		if v.Id~=self.equipInfo.Id and not checkSetInFunc(v) and checkTypeFit(v) then
			if not auto or (v.Type == 3 or v.Star<3) then
				ret[#ret+1] = v
			end
		end
	end

	--unpack by amount
	local ret2 = {}
	for _,v in ipairs(ret) do
		local nv = table.clone(v)
		nv._materialIndex = 1
		ret2[#ret2+1] = nv
		if v.Amount > 1 then
			for i=2,v.Amount do
				nv = table.clone(v)
				nv._materialIndex = i
				ret2[#ret2+1] = nv
			end
		end
	end

	table.sort(ret2,function ( a,b )
		local selectedA = toolkit.containMibaoMaterial(self.mLvUpMaterialList,a)
		local selectedB = toolkit.containMibaoMaterial(self.mLvUpMaterialList,b)
		if selectedA == selectedB then
			if a.Type == b.Type then
				if a.Type ~= 3 then
					if a.Star == b.Star then
						return a.Lv<b.Lv
					else
						return a.Star<b.Star
					end
				else
					if a.Star == b.Star then
						return a._materialIndex < b._materialIndex
					else
						return a.Star>b.Star
					end
				end
			else
				return a.Type>b.Type
			end
		else
			return selectedA
		end
	end)

	return ret2
end

function DMibaoOp:getSortedMibaoListForRefineMaterial( costType )
	local checkSetInFunc = function ( v )
		return require "EquipInfo".getSetInStatus(v) ~=3
	end
	local checkTypeFit = function ( v )
		if costType == 1 then
			return v.Type == self.equipInfo.Type and v.Star == self.equipInfo.Star
		elseif costType == 2 then
			return v.MibaoId == self.equipInfo.MibaoId
		end
	end
	local list = require "MibaoInfo".getMibaoList()
	local ret = {}
	for _,v in ipairs(list) do
		if v.Id~=self.equipInfo.Id and not checkSetInFunc(v) and checkTypeFit(v) then
			ret[#ret+1] = v
		end
	end
	table.sort(ret,function ( a,b )
		local selectedA = self.mRefineMaterial and a.Id == self.mRefineMaterial.Id
		local selectedB = self.mRefineMaterial and b.Id == self.mRefineMaterial.Id
		if selectedA == selectedB then
			-- local setInA = checkSetInFunc(a)
			-- local setInB = checkSetInFunc(b)
			-- if setInA == setInB then
				if a.RefineLv == b.RefineLv then
					return a.Lv<b.Lv
				else
					return a.RefineLv<b.RefineLv
				end
			-- else
			-- 	return setInB
			-- end
		else
			return selectedA
		end
	end)
	return ret
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DMibaoOp, "DMibaoOp")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DMibaoOp", DMibaoOp)


