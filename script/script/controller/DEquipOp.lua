local Config = require "Config"
local dbManager = require "DBManager"
local res = require "Res"
local netModel = require "netModel"
local calculateTool = require "CalculateTool"
local toolkit = require "Toolkit"
local GuideHelper = require 'GuideHelper'
local eventcenter = require "EventCenter"

local ViewType = {Strengthen = 1,Reform = 2,Break = 3,Mosaic = 4,Rebirth = 5}

local DEquipOp = class(LuaDialog)

function DEquipOp:createDocument()
self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DEquipOp.cocos.zip")
return self._factory:createDocument("DEquipOp.cocos")
end

--@@@@[[[[
function DEquipOp:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._bg = set:getElfNode("bg")
   self._equipBg_headBar_equipName = set:getLabelNode("equipBg_headBar_equipName")
   self._equipBg_equipTypeIcon = set:getElfNode("equipBg_equipTypeIcon")
   self._equipBg_equipIcon = set:getElfNode("equipBg_equipIcon")
   self._equipBg_btn = set:getTabNode("equipBg_btn")
   self._strengthenDetailBg_detailTitle_goldBg = set:getJoint9Node("strengthenDetailBg_detailTitle_goldBg")
   self._strengthenDetailBg_detailTitle_goldBg_goldCountLabel = set:getLabelNode("strengthenDetailBg_detailTitle_goldBg_goldCountLabel")
   self._strengthenDetailBg_detailTitle_coinBg = set:getJoint9Node("strengthenDetailBg_detailTitle_coinBg")
   self._strengthenDetailBg_detailTitle_coinBg_coinCountLabel = set:getLabelNode("strengthenDetailBg_detailTitle_coinBg_coinCountLabel")
   self._strengthenDetailBg_ZB_wenzi0_subTitle = set:getLabelNode("strengthenDetailBg_ZB_wenzi0_subTitle")
   self._strengthenDetailBg_strengthenInfoBg_status1 = set:getElfNode("strengthenDetailBg_strengthenInfoBg_status1")
   self._strengthenDetailBg_strengthenInfoBg_status1_layout = set:getLinearLayoutNode("strengthenDetailBg_strengthenInfoBg_status1_layout")
   self._name = set:getLabelNode("name")
   self._before = set:getLabelNode("before")
   self._after = set:getLabelNode("after")
   self._strengthenDetailBg_strengthenInfoBg_status2 = set:getLinearLayoutNode("strengthenDetailBg_strengthenInfoBg_status2")
   self._strengthenDetailBg_strengthenInfoBg_status3 = set:getLinearLayoutNode("strengthenDetailBg_strengthenInfoBg_status3")
   self._strengthenDetailBg_GoldCostLabel_lvLayout_userLvNeed = set:getLabelNode("strengthenDetailBg_GoldCostLabel_lvLayout_userLvNeed")
   self._strengthenDetailBg_GoldCostLabel_goldLayout_GoldCostValueLabel = set:getLabelNode("strengthenDetailBg_GoldCostLabel_goldLayout_GoldCostValueLabel")
   self._strengthenDetailBg_autoStrengthenBtn = set:getClickNode("strengthenDetailBg_autoStrengthenBtn")
   self._strengthenDetailBg_strengthenBtn = set:getClickNode("strengthenDetailBg_strengthenBtn")
   self._reformDetailBg_detailTitle_goldBg = set:getJoint9Node("reformDetailBg_detailTitle_goldBg")
   self._reformDetailBg_detailTitle_goldBg_goldCountLabel = set:getLabelNode("reformDetailBg_detailTitle_goldBg_goldCountLabel")
   self._reformDetailBg_detailTitle_coinBg = set:getJoint9Node("reformDetailBg_detailTitle_coinBg")
   self._reformDetailBg_detailTitle_coinBg_coinCountLabel = set:getLabelNode("reformDetailBg_detailTitle_coinBg_coinCountLabel")
   self._reformDetailBg_ZB_wenzi0_subTitle = set:getLabelNode("reformDetailBg_ZB_wenzi0_subTitle")
   self._reformDetailBg_reformInfoBg_limit = set:getLabelNode("reformDetailBg_reformInfoBg_limit")
   self._reformDetailBg_reformInfoBg_layout = set:getLinearLayoutNode("reformDetailBg_reformInfoBg_layout")
   self._name = set:getLabelNode("name")
   self._before = set:getLabelNode("before")
   self._icon = set:getElfNode("icon")
   self._after = set:getLabelNode("after")
   self._updownIcon = set:getElfNode("updownIcon")
   self._reformDetailBg_reformBtn = set:getClickNode("reformDetailBg_reformBtn")
   self._reformDetailBg_reformBtn_btntext = set:getLabelNode("reformDetailBg_reformBtn_btntext")
   self._reformDetailBg_DiamondCostLabel_icon = set:getElfNode("reformDetailBg_DiamondCostLabel_icon")
   self._reformDetailBg_DiamondCostLabel_btn = set:getButtonNode("reformDetailBg_DiamondCostLabel_btn")
   self._reformDetailBg_DiamondCostLabel_DiamondCostValueLabel = set:getLabelNode("reformDetailBg_DiamondCostLabel_DiamondCostValueLabel")
   self._reformDetailBg_DiamondCostLabel_iconTen = set:getElfNode("reformDetailBg_DiamondCostLabel_iconTen")
   self._reformDetailBg_DiamondCostLabel_btnTen = set:getButtonNode("reformDetailBg_DiamondCostLabel_btnTen")
   self._reformDetailBg_DiamondCostLabel_DiamondCostValueLabelTen = set:getLabelNode("reformDetailBg_DiamondCostLabel_DiamondCostValueLabelTen")
   self._reformDetailBg_reformBtnTen = set:getClickNode("reformDetailBg_reformBtnTen")
   self._reformDetailBg_reformBtnTen_btntext = set:getLabelNode("reformDetailBg_reformBtnTen_btntext")
   self._breakDetailBg_ZB_wenzi0_subTitle = set:getLabelNode("breakDetailBg_ZB_wenzi0_subTitle")
   self._breakDetailBg_roadFires_1 = set:getElfNode("breakDetailBg_roadFires_1")
   self._breakDetailBg_roadFires_2 = set:getElfNode("breakDetailBg_roadFires_2")
   self._breakDetailBg_roadFires_3 = set:getElfNode("breakDetailBg_roadFires_3")
   self._breakDetailBg_roadFires_4 = set:getElfNode("breakDetailBg_roadFires_4")
   self._breakDetailBg_roadFires_5 = set:getElfNode("breakDetailBg_roadFires_5")
   self._breakDetailBg_roadFires_6 = set:getElfNode("breakDetailBg_roadFires_6")
   self._breakDetailBg_breakIcons_1 = set:getElfNode("breakDetailBg_breakIcons_1")
   self._breakDetailBg_breakIcons_2 = set:getElfNode("breakDetailBg_breakIcons_2")
   self._breakDetailBg_breakIcons_3 = set:getElfNode("breakDetailBg_breakIcons_3")
   self._breakDetailBg_breakIcons_4 = set:getElfNode("breakDetailBg_breakIcons_4")
   self._breakDetailBg_breakIcons_5 = set:getElfNode("breakDetailBg_breakIcons_5")
   self._breakDetailBg_breakIcons_6 = set:getElfNode("breakDetailBg_breakIcons_6")
   self._breakDetailBg_breakIcons_7 = set:getElfNode("breakDetailBg_breakIcons_7")
   self._fire = set:getSimpleAnimateNode("fire")
   self._tp = set:getLabelNode("tp")
   self._breakDetailBg_breakTipLayout = set:getLinearLayoutNode("breakDetailBg_breakTipLayout")
   self._breakDetailBg_breakInfoBg_linearlayout_equipType = set:getLabelNode("breakDetailBg_breakInfoBg_linearlayout_equipType")
   self._breakDetailBg_breakInfoBg_linearlayout_suffix = set:getLabelNode("breakDetailBg_breakInfoBg_linearlayout_suffix")
   self._breakDetailBg_breakInfoBg_icon = set:getElfNode("breakDetailBg_breakInfoBg_icon")
   self._breakDetailBg_breakInfoBg_btn = set:getButtonNode("breakDetailBg_breakInfoBg_btn")
   self._breakDetailBg_breakInfoBg_btn_text = set:getLabelNode("breakDetailBg_breakInfoBg_btn_text")
   self._breakDetailBg_breakBtn = set:getClickNode("breakDetailBg_breakBtn")
   self._breakDetailBg_tpMaxTipLabel = set:getLabelNode("breakDetailBg_tpMaxTipLabel")
   self._animBg = set:getElfNode("animBg")
   self._reformDetailBg_bottomRotate = set:getFlashMainNode("reformDetailBg_bottomRotate")
   self._reformDetailBg_bottomRotate_root = set:getElfNode("reformDetailBg_bottomRotate_root")
   -- self._reformDetailBg_bottomRotate_root_tag-1 = set:getAddColorNode("reformDetailBg_bottomRotate_root_tag-1")
   self._reformDetailBg_ZB_wenzi0_subTitle = set:getLabelNode("reformDetailBg_ZB_wenzi0_subTitle")
   self._reformDetailBg_mosaicBtn = set:getClickNode("reformDetailBg_mosaicBtn")
   self._reformDetailBg_mosaicBtn_btntext = set:getLabelNode("reformDetailBg_mosaicBtn_btntext")
   self._reformDetailBg_lvUpBtn = set:getClickNode("reformDetailBg_lvUpBtn")
   self._reformDetailBg_lvUpBtn_btntext = set:getLabelNode("reformDetailBg_lvUpBtn_btntext")
   self._reformDetailBg_slot1 = set:getElfNode("reformDetailBg_slot1")
   self._reformDetailBg_slot1_icon = set:getElfNode("reformDetailBg_slot1_icon")
   self._reformDetailBg_slot1_btn = set:getButtonNode("reformDetailBg_slot1_btn")
   self._reformDetailBg_slot1_upIcon = set:getElfNode("reformDetailBg_slot1_upIcon")
   self._reformDetailBg_slot1_mosaicAnim = set:getFlashMainNode("reformDetailBg_slot1_mosaicAnim")
   self._reformDetailBg_slot1_mosaicAnim_root = set:getElfNode("reformDetailBg_slot1_mosaicAnim_root")
   -- self._reformDetailBg_slot1_mosaicAnim_root_tag-2 = set:getAddColorNode("reformDetailBg_slot1_mosaicAnim_root_tag-2")
   self._reformDetailBg_slot1_upgradeAnim = set:getFlashMainNode("reformDetailBg_slot1_upgradeAnim")
   self._reformDetailBg_slot1_upgradeAnim_root = set:getElfNode("reformDetailBg_slot1_upgradeAnim_root")
   -- self._reformDetailBg_slot1_upgradeAnim_root_tag-1 = set:getAddColorNode("reformDetailBg_slot1_upgradeAnim_root_tag-1")
   -- self._reformDetailBg_slot1_upgradeAnim_root_tag-2 = set:getAddColorNode("reformDetailBg_slot1_upgradeAnim_root_tag-2")
   self._reformDetailBg_slot2 = set:getElfNode("reformDetailBg_slot2")
   self._reformDetailBg_slot2_icon = set:getElfNode("reformDetailBg_slot2_icon")
   self._reformDetailBg_slot2_btn = set:getButtonNode("reformDetailBg_slot2_btn")
   self._reformDetailBg_slot2_upIcon = set:getElfNode("reformDetailBg_slot2_upIcon")
   self._reformDetailBg_slot2_mosaicAnim = set:getFlashMainNode("reformDetailBg_slot2_mosaicAnim")
   self._reformDetailBg_slot2_mosaicAnim_root = set:getElfNode("reformDetailBg_slot2_mosaicAnim_root")
   -- self._reformDetailBg_slot2_mosaicAnim_root_tag-2 = set:getAddColorNode("reformDetailBg_slot2_mosaicAnim_root_tag-2")
   self._reformDetailBg_slot2_upgradeAnim = set:getFlashMainNode("reformDetailBg_slot2_upgradeAnim")
   self._reformDetailBg_slot2_upgradeAnim_root = set:getElfNode("reformDetailBg_slot2_upgradeAnim_root")
   -- self._reformDetailBg_slot2_upgradeAnim_root_tag-1 = set:getAddColorNode("reformDetailBg_slot2_upgradeAnim_root_tag-1")
   -- self._reformDetailBg_slot2_upgradeAnim_root_tag-2 = set:getAddColorNode("reformDetailBg_slot2_upgradeAnim_root_tag-2")
   self._reformDetailBg_slot3 = set:getElfNode("reformDetailBg_slot3")
   self._reformDetailBg_slot3_icon = set:getElfNode("reformDetailBg_slot3_icon")
   self._reformDetailBg_slot3_btn = set:getButtonNode("reformDetailBg_slot3_btn")
   self._reformDetailBg_slot3_upIcon = set:getElfNode("reformDetailBg_slot3_upIcon")
   self._reformDetailBg_slot3_mosaicAnim = set:getFlashMainNode("reformDetailBg_slot3_mosaicAnim")
   self._reformDetailBg_slot3_mosaicAnim_root = set:getElfNode("reformDetailBg_slot3_mosaicAnim_root")
   -- self._reformDetailBg_slot3_mosaicAnim_root_tag-2 = set:getAddColorNode("reformDetailBg_slot3_mosaicAnim_root_tag-2")
   self._reformDetailBg_slot3_upgradeAnim = set:getFlashMainNode("reformDetailBg_slot3_upgradeAnim")
   self._reformDetailBg_slot3_upgradeAnim_root = set:getElfNode("reformDetailBg_slot3_upgradeAnim_root")
   -- self._reformDetailBg_slot3_upgradeAnim_root_tag-1 = set:getAddColorNode("reformDetailBg_slot3_upgradeAnim_root_tag-1")
   -- self._reformDetailBg_slot3_upgradeAnim_root_tag-2 = set:getAddColorNode("reformDetailBg_slot3_upgradeAnim_root_tag-2")
   self._reformDetailBg_slot4 = set:getElfNode("reformDetailBg_slot4")
   self._reformDetailBg_slot4_icon = set:getElfNode("reformDetailBg_slot4_icon")
   self._reformDetailBg_slot4_btn = set:getButtonNode("reformDetailBg_slot4_btn")
   self._reformDetailBg_slot4_upIcon = set:getElfNode("reformDetailBg_slot4_upIcon")
   self._reformDetailBg_slot4_mosaicAnim = set:getFlashMainNode("reformDetailBg_slot4_mosaicAnim")
   self._reformDetailBg_slot4_mosaicAnim_root = set:getElfNode("reformDetailBg_slot4_mosaicAnim_root")
   -- self._reformDetailBg_slot4_mosaicAnim_root_tag-2 = set:getAddColorNode("reformDetailBg_slot4_mosaicAnim_root_tag-2")
   self._reformDetailBg_slot4_upgradeAnim = set:getFlashMainNode("reformDetailBg_slot4_upgradeAnim")
   self._reformDetailBg_slot4_upgradeAnim_root = set:getElfNode("reformDetailBg_slot4_upgradeAnim_root")
   -- self._reformDetailBg_slot4_upgradeAnim_root_tag-1 = set:getAddColorNode("reformDetailBg_slot4_upgradeAnim_root_tag-1")
   -- self._reformDetailBg_slot4_upgradeAnim_root_tag-2 = set:getAddColorNode("reformDetailBg_slot4_upgradeAnim_root_tag-2")
   self._reformDetailBg_detailTitle_goldBg = set:getJoint9Node("reformDetailBg_detailTitle_goldBg")
   self._reformDetailBg_detailTitle_goldBg_goldCountLabel = set:getLabelNode("reformDetailBg_detailTitle_goldBg_goldCountLabel")
   self._reformDetailBg_detailTitle_coinBg = set:getJoint9Node("reformDetailBg_detailTitle_coinBg")
   self._reformDetailBg_detailTitle_coinBg_coinCountLabel = set:getLabelNode("reformDetailBg_detailTitle_coinBg_coinCountLabel")
   self._reformDetailBg_ZB_wenzi0_subTitle = set:getLabelNode("reformDetailBg_ZB_wenzi0_subTitle")
   self._reformDetailBg_reformInfoBg_left = set:getElfNode("reformDetailBg_reformInfoBg_left")
   self._reformDetailBg_reformInfoBg_left_icon = set:getElfNode("reformDetailBg_reformInfoBg_left_icon")
   self._reformDetailBg_reformInfoBg_left_name = set:getLabelNode("reformDetailBg_reformInfoBg_left_name")
   self._reformDetailBg_reformInfoBg_left_rankAndLevel = set:getLabelNode("reformDetailBg_reformInfoBg_left_rankAndLevel")
   self._reformDetailBg_reformInfoBg_right = set:getElfNode("reformDetailBg_reformInfoBg_right")
   self._reformDetailBg_reformInfoBg_right_icon = set:getElfNode("reformDetailBg_reformInfoBg_right_icon")
   self._reformDetailBg_reformInfoBg_right_name = set:getLabelNode("reformDetailBg_reformInfoBg_right_name")
   self._reformDetailBg_reformInfoBg_right_rankAndLevel = set:getLabelNode("reformDetailBg_reformInfoBg_right_rankAndLevel")
   self._reformDetailBg_reformBtn = set:getClickNode("reformDetailBg_reformBtn")
   self._reformDetailBg_reformBtn_btntext = set:getLabelNode("reformDetailBg_reformBtn_btntext")
   self._reformDetailBg_DiamondCostLabel_DiamondCostValueLabel = set:getLabelNode("reformDetailBg_DiamondCostLabel_DiamondCostValueLabel")
   self._layout = set:getLinearLayoutNode("layout")
   self._pet = set:getLabelNode("pet")
   self._layout_proLayout = set:getElfNode("layout_proLayout")
   self._layout_proLayout_layoutL = set:getLinearLayoutNode("layout_proLayout_layoutL")
   self._name = set:getLabelNode("name")
   self._value = set:getLabelNode("value")
   self._layout_proLayout_layoutR = set:getLinearLayoutNode("layout_proLayout_layoutR")
   self._bg_order1 = set:getElfNode("bg_order1")
   self._bg_order1_topBar_btnHelp = set:getButtonNode("bg_order1_topBar_btnHelp")
   self._bg_order1_topBar_btnReturn = set:getButtonNode("bg_order1_topBar_btnReturn")
   self._bg_order1_topBar_tabStrengthen = set:getTabNode("bg_order1_topBar_tabStrengthen")
   self._bg_order1_topBar_tabBreak = set:getTabNode("bg_order1_topBar_tabBreak")
   self._bg_order1_topBar_tabReform = set:getTabNode("bg_order1_topBar_tabReform")
   self._bg_order1_topBar_tabRebirth = set:getTabNode("bg_order1_topBar_tabRebirth")
   self._bg_order1_topBar_tabMosaic = set:getTabNode("bg_order1_topBar_tabMosaic")
   self._btnLeft = set:getButtonNode("btnLeft")
   self._btnRight = set:getButtonNode("btnRight")
   self._forAnim = set:getElfNode("forAnim")
   self._line1 = set:getRichLabelNode("line1")
   self._line2 = set:getLinearLayoutNode("line2")
   self._line2_goldUse = set:getLabelNode("line2_goldUse")
   self._line2_goldSave = set:getLabelNode("line2_goldSave")
   self._line3 = set:getLinearLayoutNode("line3")
   self._forAnim_runeMosaicAnim = set:getFlashMainNode("forAnim_runeMosaicAnim")
   self._forAnim_runeMosaicAnim_root = set:getElfNode("forAnim_runeMosaicAnim_root")
   -- self._forAnim_runeMosaicAnim_root_tag-9 = set:getAddColorNode("forAnim_runeMosaicAnim_root_tag-9")
   -- self._forAnim_runeMosaicAnim_root_tag-10 = set:getAddColorNode("forAnim_runeMosaicAnim_root_tag-10")
   -- self._forAnim_runeMosaicAnim_root_tag-12 = set:getAddColorNode("forAnim_runeMosaicAnim_root_tag-12")
   -- self._forAnim_runeMosaicAnim_root_tag-15 = set:getAddColorNode("forAnim_runeMosaicAnim_root_tag-15")
   self._forAnim_runeUpgradeAnim = set:getFlashMainNode("forAnim_runeUpgradeAnim")
   self._forAnim_runeUpgradeAnim_root = set:getElfNode("forAnim_runeUpgradeAnim_root")
   -- self._forAnim_runeUpgradeAnim_root_tag-8 = set:getAddColorNode("forAnim_runeUpgradeAnim_root_tag-8")
   -- self._forAnim_runeUpgradeAnim_root_tag-9 = set:getAddColorNode("forAnim_runeUpgradeAnim_root_tag-9")
   -- self._forAnim_runeUpgradeAnim_root_tag-10 = set:getAddColorNode("forAnim_runeUpgradeAnim_root_tag-10")
   -- self._forAnim_runeUpgradeAnim_root_tag-11 = set:getAddColorNode("forAnim_runeUpgradeAnim_root_tag-11")
   -- self._forAnim_runeUpgradeAnim_root_tag-12 = set:getAddColorNode("forAnim_runeUpgradeAnim_root_tag-12")
   -- self._forAnim_runeUpgradeAnim_root_tag-16 = set:getAddColorNode("forAnim_runeUpgradeAnim_root_tag-16")
   -- self._forAnim_runeUpgradeAnim_root_tag-17 = set:getAddColorNode("forAnim_runeUpgradeAnim_root_tag-17")
   self._screenBtn = set:getButtonNode("screenBtn")
   self._RepeatForever = set:getElfAction("RepeatForever")
   self._Sequence = set:getElfAction("Sequence")
--   self._@equipView = set:getElfNode("@equipView")
--   self._@strengthen1 = set:getSimpleAnimateNode("@strengthen1")
--   self._@reform1 = set:getSimpleAnimateNode("@reform1")
--   self._@pageStrengthen = set:getElfNode("@pageStrengthen")
--   self._@proBar = set:getElfNode("@proBar")
--   self._@pageReform = set:getElfNode("@pageReform")
--   self._@reformBar = set:getElfNode("@reformBar")
--   self._@pageBreak = set:getElfNode("@pageBreak")
--   self._@roadFire = set:getSimpleAnimateNode("@roadFire")
--   self._@curBreakIcon = set:getElfNode("@curBreakIcon")
--   self._@tip = set:getRichLabelNode("@tip")
--   self._@break1 = set:getSimpleAnimateNode("@break1")
--   self._@break2 = set:getSimpleAnimateNode("@break2")
--   self._@tpNode = set:getElfNode("@tpNode")
--   self._@break4 = set:getSimpleAnimateNode("@break4")
--   self._@break3 = set:getSimpleAnimateNode("@break3")
--   self._@pageMosaic = set:getElfNode("@pageMosaic")
--   self._@pageRebirth = set:getElfNode("@pageRebirth")
--   self._@anim = set:getSimpleAnimateNode("@anim")
--   self._@equipPro = set:getElfNode("@equipPro")
--   self._@equipOnLayout = set:getLinearLayoutNode("@equipOnLayout")
--   self._@equipProBar = set:getLinearLayoutNode("@equipProBar")
--   self._@lockBtn = set:getButtonNode("@lockBtn")
--   self._@strengthenInfo = set:getLinearLayoutNode("@strengthenInfo")
--   self._@line3Info = set:getLabelNode("@line3Info")
--   self._@line3space = set:getElfNode("@line3space")
--   self._@line3Info = set:getLabelNode("@line3Info")
--   self._@line3space = set:getElfNode("@line3space")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DEquipOp:onInit( userData, netData )
	-- if Config.LangName == "english" then
		local maxW = 72
		self._set:getLabelNode("bg_order1_topBar_tabStrengthen_normal_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_order1_topBar_tabStrengthen_pressed_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_order1_topBar_tabStrengthen_invalid_#title"):setDimensions(CCSize(0,0))

		self._set:getLabelNode("bg_order1_topBar_tabBreak_normal_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_order1_topBar_tabBreak_pressed_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_order1_topBar_tabBreak_invalid_#title"):setDimensions(CCSize(0,0))
		
		self._set:getLabelNode("bg_order1_topBar_tabReform_normal_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_order1_topBar_tabReform_pressed_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_order1_topBar_tabReform_invalid_#title"):setDimensions(CCSize(0,0))

		self._set:getLabelNode("bg_order1_topBar_tabRebirth_normal_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_order1_topBar_tabRebirth_pressed_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_order1_topBar_tabRebirth_invalid_#title"):setDimensions(CCSize(0,0))
		
		self._set:getLabelNode("bg_order1_topBar_tabMosaic_normal_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_order1_topBar_tabMosaic_pressed_#title"):setDimensions(CCSize(0,0))
		self._set:getLabelNode("bg_order1_topBar_tabMosaic_invalid_#title"):setDimensions(CCSize(0,0))

		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabStrengthen_normal_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabStrengthen_pressed_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabStrengthen_invalid_#title"),maxW)

		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabBreak_normal_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabBreak_pressed_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabBreak_invalid_#title"),maxW)

		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabReform_normal_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabReform_pressed_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabReform_invalid_#title"),maxW)

		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabRebirth_normal_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabRebirth_pressed_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabRebirth_invalid_#title"),maxW)

		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabMosaic_normal_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabMosaic_pressed_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_order1_topBar_tabMosaic_invalid_#title"),maxW)
	-- end
		require 'LangAdapter'.selectLang(nil,nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
			self._set:getLabelNode("bg_order1_topBar_tabMosaic_normal_#title"):setFontSize(16)
			self._set:getLabelNode("bg_order1_topBar_tabMosaic_pressed_#title"):setFontSize(16)
			self._set:getLabelNode("bg_order1_topBar_tabMosaic_invalid_#title"):setFontSize(16)
		end)

	res.doActionDialogShow(self._bg,function ( ... )
        GuideHelper:registerPoint('突破tab',self._bg_order1_topBar_tabBreak)
        GuideHelper:registerPoint('重铸tab',self._bg_order1_topBar_tabReform)
        GuideHelper:registerPoint('回炉tab',self._bg_order1_topBar_tabRebirth)
        -- GuideHelper:registerPoint('镶嵌tab',self._bg_order1_topBar_tabMosaic)
        GuideHelper:registerPoint('关闭',self._bg_order1_topBar_btnReturn)
        GuideHelper:registerPoint('btnRight',self._btnRight)
        GuideHelper:check('DEquipOp')
    end)
	self.cachedUpdateFunc = nil
	-- self._bg_topBar_bg:setScaleX(CCDirector:sharedDirector():getWinSize().width/960)
	-- self._screenBtn:setVisible(false)

	-- self._bg_order1_topBar_tabMosaic:setVisible(false)

	self.views = {}
	self.tickHandle = {}
	self.animFinishFuncs = {}
	self.effectIds = {}
	self.equipInfo = userData.EquipInfo
	self.equipList = userData.EquipList or {self.equipInfo}
	self.equipIndex = table.indexOf(self.equipList,self.equipInfo)
	self.dbInfo = dbManager.getInfoEquipment(self.equipInfo.EquipmentId)
	self.hideLeftTabs = userData.hideLeftTabs

	self:updateOnLock()

	self:addTopBtnListener()[userData.ViewType or ViewType.Strengthen]:trigger(nil)

	self._bg_order1:setOrder(1)

	self:onEnter()
    self._btnLeft:runElfAction(self._RepeatForever:clone())
    self._btnRight:runElfAction(self._RepeatForever:clone())
end

function DEquipOp:onEnter( ... )

end

function DEquipOp:onBack( userData, netData )
	self.tickHandle[#self.tickHandle+1] = require "framework.sync.TimerHelper".tick(function ( ... )
		self:updateView()
	      	return true
	end)
end

--------------------------------custom code-----------------------------

function DEquipOp:hideTabAdjustPos(tab)
    if self.tabPos == nil then
        self.tabPos = {{-429.0, -163.0}, {-429.0,-245.0}, {-429.0,-327.0}, {-429.0,-409.0}, {-429.0,-491.0}}
    end

    if self.tabIndex == nil then
        self.tabIndex = {['tabStrengthen'] = 1, ['tabBreak'] = 2, ['tabReform'] = 3, ['tabRebirth'] = 4, ['tabMosaic'] = 5}
    end

    -- body
    self[string.format('_bg_order1_topBar_%s', tab)]:setVisible(false)
    local index = self.tabIndex[tab]
    if not index then return end

    for k, v in pairs(self.tabIndex) do
        if v and v > index then
            self[string.format('_bg_order1_topBar_%s', k)]:setPosition(ccp(self.tabPos[v - 1][1], self.tabPos[v - 1][2]))
            self.tabIndex[k] = v - 1
        end
    end
    --table.remove(tabIndex, tab)
    self.tabIndex[tab] = nil
end

function DEquipOp:updateOnLock( ... )
	local mgr = require "UnlockManager"
	-- local function addLock( node,mode )
	-- 	local btn = self:createLuaSet("@lockBtn")[1]
	-- 	local x,y = node:getPosition()
	-- 	btn:setPosition(x-30,y+28)
	-- 	node:getParent():addChild(btn)
	-- 	btn:setListener(function ( ... )
	-- 		self:toast(mgr:getUnlockConditionMsg(mode))
	-- 	end)
	-- end
	-- if not mgr:isUnlock("EquipTP") then
	-- 	addLock(self._bg_order1_topBar_tabBreak,"EquipTP")
	-- end
	-- if not mgr:isUnlock("EquipReset") then
	-- 	addLock(self._bg_order1_topBar_tabReform,"EquipReset")
	-- end
	-- if not mgr:isUnlock("EquipRebirth") then
	-- 	addLock(self._bg_order1_topBar_tabRebirth,"EquipRebirth")
	-- end
	-- if not mgr:isUnlock("GemFuben") then
	-- 	addLock(self._bg_order1_topBar_tabMosaic,"GemFuben")
	-- end

    if not mgr:isUnlock("EquipTP") then
        self:hideTabAdjustPos('tabBreak')
    end
    if not mgr:isUnlock("EquipReset") then
        self:hideTabAdjustPos('tabReform')
    end
    if not mgr:isUnlock("EquipRebirth") then
        self:hideTabAdjustPos('tabRebirth')
    end
    if not mgr:isUnlock("GuildCopyLv") or not mgr:isOpen("Rune") then
        self:hideTabAdjustPos('tabMosaic')
    end

	-- self._bg_order1_topBar_tabBreak:setVisible(mgr:isUnlock("EquipTP"))
	-- self._bg_order1_topBar_tabReform:setVisible(mgr:isUnlock("EquipReset"))
	-- self._bg_order1_topBar_tabRebirth:setVisible(mgr:isUnlock("EquipRebirth"))
	-- self._bg_order1_topBar_tabMosaic:setVisible(mgr:isUnlock("GemFuben"))
end

function DEquipOp:addTopBtnListener( ... )
	local tabBtns = {[ViewType.Strengthen] = self._bg_order1_topBar_tabStrengthen,
				[ViewType.Reform] = self._bg_order1_topBar_tabReform,
				[ViewType.Break] = self._bg_order1_topBar_tabBreak,
				[ViewType.Mosaic] = self._bg_order1_topBar_tabMosaic,
				[ViewType.Rebirth] = self._bg_order1_topBar_tabRebirth}
	table.foreach(tabBtns,function ( viewType,tabBtn )
		tabBtn:setListener(function (  )
			if self.curViewType~=viewType then
				self:onTabChanged()
				self.curViewType = viewType
				self:updateView()
				GuideHelper:check(string.format('DEquipOp%s',tostring(viewType)))
			end
		end)
	end)

	if self.hideLeftTabs then
		for k,v in pairs(tabBtns) do
			v:setVisible(false)
		end
	end

	self.close = function ( ... )
	 	GuideHelper:check('CloseDialg')
		self:onTabChanged()
		self.curViewType = 0
	end

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_order1_topBar_btnHelp:setListener(function (  )
		GleeCore:showLayer("DHelp", {type = "装备强化"})
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
				elseif self.curViewType == ViewType.Break then
					return self:showBreakView()
				elseif self.curViewType == ViewType.Rebirth then
					return self:showRebirthView(true)
				elseif self.curViewType == ViewType.Mosaic then
					return self:showMosaicView()
				end
			end
		end
	end)
	self._screenBtn:setVisible(false)

	self._btnLeft:setListener(function ( ... )
		self.equipIndex = self.equipIndex - 1
		if self.equipIndex <=0 then
			self.equipIndex = #self.equipList
		end
		self.equipInfo = self.equipList[self.equipIndex]
		self.dbInfo = dbManager.getInfoEquipment(self.equipInfo.EquipmentId)
		self:onEquipChange()
	end)

	self._btnRight:setListener(function ( ... )
		self.equipIndex = self.equipIndex + 1
		if self.equipIndex < 1 or self.equipIndex > #self.equipList then
			self.equipIndex = 1
		end

	        if not self.equipList or not next(self.equipList) then
	            	return
	        end
		self.equipInfo = self.equipList[self.equipIndex]
		self.dbInfo = dbManager.getInfoEquipment(self.equipInfo.EquipmentId)
		self:onEquipChange()
	end)
 
	return tabBtns
end

function DEquipOp:onEquipChange( ... )
	for _,v in pairs(self.views) do
		v[1]:removeFromParentAndCleanup(true)
	end
	self.views = {}
	self.equipProSet[1]:removeFromParentAndCleanup(true)
	self.equipProSet = nil
	self.breakCostEquip = nil
	self.mRunes = nil
	self:updateView()
    GuideHelper:check('onEquipChange')
end

function DEquipOp:onEquipModify( new )
	local index = table.indexOf(self.equipList, self.equipInfo)
	self.equipList[index] = new
	self.equipInfo = new
end

function DEquipOp:finishAnims( ... )
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

function DEquipOp:onTabChanged( ... )
	self:finishAnims()
	self:hiddenToast()
	self.cachedViewUpdateFunc = nil
end

function DEquipOp:updateView( ... )
	local funcViewMap = {[ViewType.Strengthen] = self.showStrengthenView,
				[ViewType.Reform] = self.showReformView,
				[ViewType.Break] = self.showBreakView,
				[ViewType.Mosaic] = self.showMosaicView,
				[ViewType.Rebirth] = self.showRebirthView}
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

function DEquipOp:getStrengthenDetail( netData )
	local curLv = self.equipInfo.Lv
	local upCount,criCount,upLevel,goldUse,goldSave = 0,0,0,0,0
	local t = netData.D.Lv and {netData.D.Lv} or netData.D.Lvs
	for _,v in ipairs(t) do
		if v>1 then
			criCount = criCount + 1
			for i=1,v-1 do
				goldSave = goldSave + calculateTool.getEquipStrengthenNeedGold(self.dbInfo.color,curLv+i)
			end
		end
		curLv = curLv + v
	end
	upCount = #t
	upLevel =  curLv - self.equipInfo.Lv
	goldUse = netData.D.Gold
	return upCount,criCount,upLevel,goldUse,goldSave
end

function DEquipOp:showStrengthenAnim( data,func )
	local anim1 = self:createLuaSet("@strengthen1")[1]
	self.equipViewSet["#equipBg"]:addChild(anim1)
	anim1:setVisible(false)
	anim1:setLoops(1)
	self.tickHandle[#self.tickHandle+1] =  require "framework.sync.TimerHelper".tick(function ( ... )
		anim1:setVisible(true)
		anim1:start()
		return true
	end,0.1)
	
	local Swf = require 'framework.swf.Swf'
	local myswf = Swf.new('Swf_equipStrengthenCrit')
	self._forAnim:addChild( myswf:getRootNode() )
	myswf:getRootNode():setVisible(false)
	myswf:getRootNode():setPosition(0,40)

	local set = self:createLuaSet("@strengthenInfo")
	require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
		set["#sp"]:removeFromParentAndCleanup(true)
		set[1]:setScale(0.9)
	end)
	local upCount,criCount,upLevel,goldUse,goldSave = self:getStrengthenDetail(data)
	set["line1"]:setString(string.format(res.locString("Equip$StrengthenInfoLine1Format"),upCount,criCount,upLevel))
	set["line2_goldUse"]:setString(string.format(" %s ",self:parseValue(goldUse)))
	set["line2_goldSave"]:setString(string.format("%s ( %.1f%% )",self:parseValue(goldSave),goldSave/(goldSave+goldUse)*100))

	-- set["line2"]:setString(string.format(res.locString("Equip$StrengthenInfoLine2Format"),self:parseValue(goldUse),self:parseValue(goldSave),goldSave/(goldSave+goldUse)*100))
	local list = self:getEquipStrengthenToastString(self.equipInfo,upLevel)
	for i,v in ipairs(list) do
		local p = self:createLuaSet("@line3Info")[1]
		p:setString(v)
		set["line3"]:addChild(p)
		if i~=#list then
			set["line3"]:addChild(self:createLuaSet("@line3space")[1])
		end
	end

	myswf:getNodeByTag(4):addChild(set[1])
	set[1]:setVisible(true)

	local bg = ElfNode:create()
	bg:setResid("N_ZB_bj_bj.png")
	myswf:getNodeByTag(2):addChild(bg)

	local shapeMap
	if criCount==0 then
		set[1]:setPosition(0,-2)
		bg:setScaleY(0.5)
	else
		local node = ElfNode:create()
		node:setResid("N_ZB_bjz.png")
		node:setPosition(0,65)
		myswf:getNodeByTag(3):addChild(node)
		set[1]:setPosition(0,-50)
	end
	local shapeMap = {
		["shape-4"] = "",
		['shape-6'] = '',
		['shape-8'] = "",
	}
	-- local anim2 = self:createLuaSet("@strengthen2")
	-- local list = self:getEquipStrengthenToastString(self.equipInfo,lvUp)
	-- for i=1,5 do
	-- 	local label = anim2[string.format("#label%d",i)]
	-- 	if list[i] then
	-- 		label:setString(list[i])
	-- 	else
	-- 		label:setString("")
	-- 	end
	-- end
	-- local anim = anim2[1]
	-- self.equipViewSet["equipBg_forAnim"]:addChild(anim)
	-- anim:setVisible(false)

	local canFinish = require "UserInfo".getLevel()>=25

	self.tickHandle[#self.tickHandle+1] =  require "framework.sync.TimerHelper".tick(function ( ... )
		myswf:getRootNode():setVisible(true)
		myswf:play(shapeMap, nil, function ( ... )
			print("-----------OnStrengthenAnimEnd---------")
			if canFinish then
	                		table.remove(self.animFinishFuncs,1)()
	                	else
		      		self._screenBtn:setVisible(false)
				anim1:removeFromParentAndCleanup(true)
				myswf:getRootNode():removeFromParentAndCleanup(true)
				if #self.effectIds>0 then
					require 'framework.helper.MusicHelper'.stopEffect(table.remove(self.effectIds,1))
				end
			end
	      		return func()
		end)
	      	return true
	end,0.5)

	self._screenBtn:setVisible(true)
	if canFinish then
		self.animFinishFuncs[#self.animFinishFuncs+1] = function ( ... )
			-- self._screenBtn:setVisible(false)
			anim1:removeFromParentAndCleanup(true)
			myswf:getRootNode():removeFromParentAndCleanup(true)
			if #self.effectIds>0 then
				require 'framework.helper.MusicHelper'.stopEffect(table.remove(self.effectIds,1))
			end
		end
	end
	self.effectIds[#self.effectIds+1] = require 'framework.helper.MusicHelper'.playEffect("raw/ui_sfx_equipupgrade.mp3")
end

function DEquipOp:showStrengthenView( ... )
	self:updateEquipView(set,self.equipInfo)

	local set  = self.views[ViewType.Strengthen] 
	if not set then
		set = self:createLuaSet("@pageStrengthen")

		set["strengthenDetailBg_ZB_wenzi0_subTitle"]:setString(string.format("%s%s",res.locString("Equip$ListTitle"),res.locString("Equip$Stengthen")))

		require 'LangAdapter'.LabelNodeAutoShrink(set["strengthenDetailBg_strengthenInfoBg_status2_#2"],440)

		require 'LangAdapter'.LabelNodeAutoShrink(set["strengthenDetailBg_autoStrengthenBtn_#btntext"],106)

		require "LangAdapter".fontSize(set["strengthenDetailBg_#strengthenDes"],nil,nil,nil,nil,16)

		require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
			require 'LangAdapter'.LabelNodeSetHorizontalAlignment(set["strengthenDetailBg_#strengthenDes"],kCCTextAlignmentRight)
			-- set["strengthenDetailBg_#strengthenDes"]:setHorizontalAlignment(kCCTextAlignmentRight)
			set["strengthenDetailBg_detailTitle_#curHasLabel"]:setVisible(false)
		end)

		set["strengthenDetailBg_autoStrengthenBtn"]:setListener(function ( ... )
			-- self:send(netModel.getmodelEquipAutoStrengthen(self.equipInfo.Id),function ( data )
			-- 	local user = require "UserInfo"
			-- 	local preGold = user.getGold()
			-- 	self.cachedUpdateFunc = function (  )
			-- 		if data.D.Pet then
			-- 			require "PetInfo".setPet(data.D.Pet)
			-- 		end
			-- 		self:onEquipModify(data.D.Equipment)
			-- 		require "EquipInfo".setEquipWithId(data.D.Equipment)
			-- 		user.setGold(preGold - data.D.Gold)
			-- 		eventcenter.eventInput("OnEquipmentUpdate")
			-- 		eventcenter.eventInput("UpdateGoldCoin")
			-- 	end
			-- 	local update
			-- 	update = function ( ... )
			-- 		local lvUp = table.remove(data.D.Lvs,1)
			-- 		self:showStrengthenAnim(lvUp,function ( ... )
			-- 			if self.cachedUpdateFunc == nil then
			-- 				return
			-- 			end
			-- 			user.setGold(user.getGold()-calculateTool.getEquipStrengthenNeedGold(self.dbInfo.color,self.equipInfo.Lv))
			-- 			self.equipInfo.Lv = self.equipInfo.Lv + lvUp
			-- 			local continue = #data.D.Lvs>0
			-- 			if not continue then
			-- 				self.cachedUpdateFunc()
			-- 				self.cachedUpdateFunc = nil
			-- 				self._screenBtn:setVisible(false)
			-- 			-- else
			-- 			-- 	update()
			-- 			end
			-- 			self:showStrengthenView()
			-- 		end)
			-- 	end
			-- 	print(data)
			-- 	update()
			-- 	for i=1,#data.D.Lvs do
			-- 		self.tickHandle[#self.tickHandle+1] =  require "framework.sync.TimerHelper".tick(function ( ... )
			-- 			update()
			-- 			return true
			-- 		end,i*1.5)
			-- 	end
				
			-- 	-- if not self._screenBtn:isVisible() then
			-- 	-- 	self._screenBtn:setVisible(true)
					
			-- 	-- 	self._screenBtn:setListener(function ( ... )
			-- 	-- 		self._screenBtn:setVisible(false)
			-- 	-- 		self:onTabChanged()
			-- 	-- 		return self:showStrengthenView()
			-- 	-- 	end)
			-- 	-- end
			-- end)

			self:send(netModel.getmodelEquipAutoStrengthen(self.equipInfo.Id),function ( data )
				GuideHelper:check('EquipUpgrade')
				self.cachedUpdateFunc = function (  )
					if data.D.Pet then
						require "PetInfo".setPet(data.D.Pet)
					end
					self:onEquipModify(data.D.Equipment)
					require "EquipInfo".setEquipWithId(self.equipInfo)
					local user = require "UserInfo"
					user.setGold(user.getGold()-data.D.Gold)
					GuideHelper:check('AnimtionEnd')
					eventcenter.eventInput("OnEquipmentUpdate")
					eventcenter.eventInput("UpdateGoldCoin")
				end
				return self:showStrengthenAnim(data,function ( ... )
			           	self.cachedUpdateFunc()
					self.cachedUpdateFunc = nil
					self._screenBtn:setVisible(false)
					return self:showStrengthenView()
				end)
			end)
		end)

		set["strengthenDetailBg_strengthenBtn"]:setListener(function ( ... )
			self:send(netModel.getmodelEquipStrengthen(self.equipInfo.Id),function ( data )
				GuideHelper:check('EquipUpgrade')
				self.cachedUpdateFunc = function (  )
					if data.D.Pet then
						require "PetInfo".setPet(data.D.Pet)
					end
					self:onEquipModify(data.D.Equipment)
					require "EquipInfo".setEquipWithId(self.equipInfo)
					local user = require "UserInfo"
					user.setGold(user.getGold()-data.D.Gold)
					GuideHelper:check('AnimtionEnd')
					eventcenter.eventInput("OnEquipmentUpdate")
					eventcenter.eventInput("UpdateGoldCoin")
				end
				return self:showStrengthenAnim(data,function ( ... )
			           	self.cachedUpdateFunc()
					self.cachedUpdateFunc = nil
					self._screenBtn:setVisible(false)
					return self:showStrengthenView()
				end)
			end)
		end)

		self.views[ViewType.Strengthen] = set
		self._bg:addChild(set[1])
	end
	

	local isGoldEnough,isRoleLevelLimit
	local status = 1
	local isLevelLimit = self.equipInfo.Lv>=self.equipInfo.levelMax
	if isLevelLimit then
		status = self:isTpLevelLimit() and 3 or 2
	end
	for st = 1,3 do
		set[string.format("strengthenDetailBg_strengthenInfoBg_status%d",st)]:setVisible(st == status)
	end

	local hasGold = require "UserInfo".getGold()
	self:updateCurHasBar(set["strengthenDetailBg_#detailTitle"],hasGold,require "UserInfo".getCoin())

	if status == 1 then
		local pros = toolkit.getEquipProList(self.equipInfo)
		local barList = set["strengthenDetailBg_strengthenInfoBg_status1_layout"]:getChildren()
		if not barList then
			for i=1,#pros+1 do
				local bar = self:createLuaSet("@proBar")
				set["strengthenDetailBg_strengthenInfoBg_status1_layout"]:addChild(bar[1])
			end
			barList = set["strengthenDetailBg_strengthenInfoBg_status1_layout"]:getChildren()
		end
		local function updateBar( bar,name,before,after )
			local nameNode = bar:findNodeByName("name")
			tolua.cast(nameNode,"LabelNode")
			local beforeNode = bar:findNodeByName("before")
			tolua.cast(beforeNode,"LabelNode")
			local afterNode = bar:findNodeByName("after")
			tolua.cast(afterNode,"LabelNode")
			nameNode:setString(name)
			beforeNode:setString(before)
			afterNode:setString(after)
		end 

		local bar = barList:objectAtIndex(0)
		tolua.cast(bar,"ElfNode")
		updateBar(bar,res.locString("Global$Level"),self.equipInfo.Lv,self.equipInfo.Lv+1)
		for i=1,#pros do

			local pro = pros[i]
			local growth = calculateTool.getEquipProGrowth(self.equipInfo,pro)
			if growth == 0 then
				if barList:count()>i then
					bar = barList:objectAtIndex(i)
					bar:removeFromParentAndCleanup(true)
				end
			else
				bar = barList:objectAtIndex(i)
				tolua.cast(bar,"ElfNode")

				local after = string.format("%d",calculateTool.getEquipProData(self.equipInfo[string.format("%sv",string.upper(pro))],self.equipInfo.Lv+1,calculateTool.getEquipProGrowth(self.equipInfo,pro),self.equipInfo.Tp))
				after = after + calculateTool.getEquipProAddByRune(self.equipInfo,pro)
				updateBar(bar,toolkit.getEquipProName(pro),string.format("%s",calculateTool.getEquipProDataStrByEquipInfo(self.equipInfo,pro)),after)
			end
		end

		set["strengthenDetailBg_#GoldCostLabel"]:setVisible(true)

		local needGold = calculateTool.getEquipStrengthenNeedGold(self.dbInfo.color,self.equipInfo.Lv)
		set["strengthenDetailBg_GoldCostLabel_goldLayout_GoldCostValueLabel"]:setString(needGold)
		isGoldEnough = hasGold>=needGold
		if not isGoldEnough then
			set["strengthenDetailBg_GoldCostLabel_goldLayout_GoldCostValueLabel"]:setFontFillColor(res.color4F.red,true)
		end
		local needRoleLevel = dbManager.getInfoEquipNeedRoleLevel(self.equipInfo.Lv+1)
		isRoleLevelLimit = needRoleLevel>require "UserInfo".getLevel()
		set["strengthenDetailBg_GoldCostLabel_lvLayout_userLvNeed"]:setString(string.format("Lv.%d",needRoleLevel))
		if isRoleLevelLimit then
			set["strengthenDetailBg_GoldCostLabel_lvLayout_userLvNeed"]:setFontFillColor(res.color4F.red,true)
		end
	else
		set["strengthenDetailBg_#GoldCostLabel"]:setVisible(false)
	end
	local enable = not isLevelLimit and isGoldEnough and not isRoleLevelLimit and self.cachedUpdateFunc==nil
	set["strengthenDetailBg_autoStrengthenBtn"]:setEnabled(enable)
	set["strengthenDetailBg_strengthenBtn"]:setEnabled(enable)
	set["strengthenDetailBg_autoStrengthenBtn"]:setOpacity(enable and 255 or 128)
	set["strengthenDetailBg_strengthenBtn"]:setOpacity(enable and 255 or 128)     

	GuideHelper:registerPoint('升级',set['strengthenDetailBg_strengthenBtn'])
end

function DEquipOp:showReformView( )
	self:updateEquipView(set,self.equipInfo)

	local set  = self.views[ViewType.Reform]
	local rank = self.equipInfo.Rank
	local grow = self.equipInfo.Grow
	local reformDiamondCost = dbManager.getInfoEquipColor(self.dbInfo.color).reformconsume

	local function updateReformBar( bar,name,before,after,compare )
		local nameNode = bar:findNodeByName("name")
		tolua.cast(nameNode,"LabelNode")
		nameNode:setString(name)
		local beforeNode = bar:findNodeByName("before")
		tolua.cast(beforeNode,"LabelNode")
		beforeNode:setString(before)
		local icon1 = bar:findNodeByName("icon")
		local afterNode = bar:findNodeByName("after")
		tolua.cast(afterNode,"LabelNode")
		local updownIcon = bar:findNodeByName("updownIcon")
		local b = after~=nil
		icon1:setVisible(b)
		afterNode:setVisible(b)
		updownIcon:setVisible(b)
		if b then
			afterNode:setString(after)
			if compare < 0 then
				afterNode:setFontFillColor(ccc4f(0.7,1.0,0.4,1.0),true)
				updownIcon:setResid("ZB_shangsheng.png")
			elseif compare == 0 then
				afterNode:setFontFillColor(ccc4f(1.0,1.0,1.0,1.0),true)
				updownIcon:setResid(nil)
			else
				afterNode:setFontFillColor(ccc4f(0.9,0.5,0.2,1.0),true)
				updownIcon:setResid("ZB_xiajiang.png")
			end
		end
	end

	local function updateStatus( status )
		set["reformDetailBg_reformInfoBg_layout"]:setVisible(status~=3)
		set["reformDetailBg_reformInfoBg_limit"]:setVisible(status==3)
	end
	local function updateOnGrowthLimit(  )
		updateStatus(3)
		set["reformDetailBg_reformBtn"]:setEnabled(false)
		set["reformDetailBg_reformBtn"]:setOpacity(128)
		set["reformDetailBg_reformBtnTen"]:setEnabled(false)
		set["reformDetailBg_reformBtnTen"]:setOpacity(128)
	end
	if not set then
		set = self:createLuaSet("@pageReform")

		local material = require "BagInfo".getItemByMID(15)
		res.setItemDetail(set["reformDetailBg_DiamondCostLabel_icon"],material)
		set["reformDetailBg_DiamondCostLabel_btn"]:setListener(function ( ... )
			GleeCore:showLayer("DMaterialDetail",{materialId = 15})
		end)
		res.setItemDetail(set["reformDetailBg_DiamondCostLabel_iconTen"],material)
		set["reformDetailBg_DiamondCostLabel_btnTen"]:setListener(function ( ... )
			GleeCore:showLayer("DMaterialDetail",{materialId = 15})
		end)

		require "LangAdapter".nodePos(set["reformDetailBg_DiamondCostLabel_icon"],nil,nil,nil,nil,nil,ccp(-90,52),ccp(-90,52))
		require "LangAdapter".nodePos(set["reformDetailBg_DiamondCostLabel_iconTen"],nil,nil,nil,nil,nil,ccp(90,52),ccp(90,52))
		require "LangAdapter".nodePos(set["reformDetailBg_DiamondCostLabel_DiamondCostValueLabel"],nil,nil,nil,nil,nil,ccp(-90,-12),ccp(-90,-12))
		require "LangAdapter".nodePos(set["reformDetailBg_DiamondCostLabel_DiamondCostValueLabelTen"],nil,nil,nil,nil,nil,ccp(90,-12),ccp(90,-12))

		require "LangAdapter".LabelNodeAutoShrink(set["reformDetailBg_reformBtn_btntext"],108)
		require "LangAdapter".LabelNodeAutoShrink(set["reformDetailBg_reformBtnTen_btntext"],108)

		require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
			set["reformDetailBg_detailTitle_#curHasLabel"]:setVisible(false)
		end)

		set["reformDetailBg_ZB_wenzi0_subTitle"]:setString(string.format("%s%s",res.locString("Equip$ListTitle"),res.locString("Equip$Reform")))
        		GuideHelper:registerPoint('重铸',set['reformDetailBg_reformBtn'])

        		local reformCallback = function ( data,cost )
        			GuideHelper:check('RebirthDone')
			self.cachedUpdateFunc = function(  )
				print(data)
				if data.D.Pet then
					require "PetInfo".setPet(data.D.Pet)
				end
				self:onEquipModify(data.D.Equipment)
				require "EquipInfo".setEquipWithId(self.equipInfo)
				--重铸水晶数据需更新
				local bagInfo = require "BagInfo"
				bagInfo.useItem(15,cost)
				eventcenter.eventInput("OnEquipmentUpdate")
				-- local item = bagInfo.getItemByMID(15)
				-- item.Amount = item.Amount - reformDiamondCost
			end
			self.cachedViewUpdateFunc = function ( ... )
				local bagInfo = require "BagInfo"
				self:updateCurHasBar(set["reformDetailBg_#detailTitle"],require "BagInfo".getItemCount(15),require "UserInfo".getCoin(),"N_TY_chongzhushuijing1.png")
				-- bagInfo.exchangeItem({item})

				local pros = toolkit.getEquipProList(self.equipInfo)
				local barList = set["reformDetailBg_reformInfoBg_layout"]:getChildren()
				local bar = barList:objectAtIndex(0)
				tolua.cast(bar,"ElfNode")
				updateReformBar(bar,res.locString("Global$Rank"),res.getEquipRankText(rank),res.getEquipRankText(self.equipInfo.Rank),rank-self.equipInfo.Rank)

				for i=1,barList:count()-1 do
					bar = barList:objectAtIndex(i)
					tolua.cast(bar,"ElfNode")
					local pro = pros[i]
					local growth1 = calculateTool.getEquipProGrowth(self.equipInfo,pro,grow)
					local growth2 = calculateTool.getEquipProGrowth(self.equipInfo,pro)
					if Config.LangName == "PT" then
						updateReformBar(bar,string.format("%s%s",toolkit.getEquipProName(pro),"+"),string.format("%.2f",growth1),string.format("%.2f",growth2),growth1-growth2)
					else
						updateReformBar(bar,string.format("%s%s",toolkit.getEquipProName(pro),res.locString("Global$GrowStatus")),string.format("%.2f",growth1),string.format("%.2f",growth2),growth1-growth2)
					end
				end

				updateStatus(2)

				self:updateEquipView(set,self.equipInfo)
				
				rank = self.equipInfo.Rank
				grow = self.equipInfo.Grow

				if self.equipInfo.Grow>=1 then
					updateOnGrowthLimit()
				end
			end

			local anim = self:createLuaSet("@reform1")[1]
			anim:setLoops(1)
			anim:setListener(function ( ... )
				table.remove(self.animFinishFuncs,1)()
				self.cachedUpdateFunc()
				self.cachedUpdateFunc = nil
				self.cachedViewUpdateFunc()
				self.cachedViewUpdateFunc = nil
			end)
			self.equipViewSet["#equipBg"]:addChild(anim)
			anim:start()
			self._screenBtn:setVisible(true)
			self.animFinishFuncs[#self.animFinishFuncs+1] = function ( ... )
				self._screenBtn:setVisible(false)
				anim:removeFromParentAndCleanup(true)
				require 'framework.helper.MusicHelper'.stopAllEffects()
			end
			require 'framework.helper.MusicHelper'.playEffect("raw/ui_sfx_reforge.mp3")
        		end

        		set["reformDetailBg_reformBtnTen"]:setListener(function ( ... )
        			local hasItemCount = require "BagInfo".getItemCount(15)
			if hasItemCount<reformDiamondCost*10 then
				local param = {itemId=15,callback=function ( count )
					self:updateCurHasBar(set["reformDetailBg_#detailTitle"],require "BagInfo".getItemCount(15),require "UserInfo".getCoin(),"N_TY_chongzhushuijing1.png")
				end}
				param.count = reformDiamondCost*10 - hasItemCount
				return GleeCore:showLayer('DMallItemBuy',param)
			end
			
			self:send(netModel.getmodelEquipReformTen(self.equipInfo.Id),function ( data )
                			reformCallback(data,reformDiamondCost*10)
			end)
        		end)

		set["reformDetailBg_reformBtn"]:setListener(function ( ... )
			local hasItemCount = require "BagInfo".getItemCount(15)
			if hasItemCount<reformDiamondCost then
				local param = {itemId=15,callback=function ( count )
					self:updateCurHasBar(set["reformDetailBg_#detailTitle"],require "BagInfo".getItemCount(15),require "UserInfo".getCoin(),"N_TY_chongzhushuijing1.png")
				end}
				param.count = reformDiamondCost - hasItemCount
				return GleeCore:showLayer('DMallItemBuy',param)
			end
			
			self:send(netModel.getmodelEquipReform(self.equipInfo.Id),function ( data )
                			reformCallback(data,reformDiamondCost)
			end)
		end)
		self.views[ViewType.Reform] = set
		self._bg:addChild(set[1])
	end

	self:updateCurHasBar(set["reformDetailBg_#detailTitle"],require "BagInfo".getItemCount(15),require "UserInfo".getCoin(),"N_TY_chongzhushuijing1.png")
	-- set["reformDetailBg_detailTitle_diamondCountLabel"]:setString(require "BagInfo".getItemCount(15))
	-- set["reformDetailBg_detailTitle_coinCountLabel"]:setString(require "UserInfo".getCoin())

	set["reformDetailBg_DiamondCostLabel_DiamondCostValueLabel"]:setString(string.format("%sx%d",dbManager.getInfoMaterial(15).name,reformDiamondCost))
	set["reformDetailBg_DiamondCostLabel_DiamondCostValueLabelTen"]:setString(string.format("%sx%d",dbManager.getInfoMaterial(15).name,reformDiamondCost*10))
	require 'LangAdapter'.selectLangkv({German=function ( ... )
        set["reformDetailBg_DiamondCostLabel_DiamondCostValueLabel"]:setString(string.format("x%d",reformDiamondCost))
		set["reformDetailBg_DiamondCostLabel_DiamondCostValueLabelTen"]:setString(string.format("x%d",reformDiamondCost*10))
    end})
	updateStatus(1)
	if self.equipInfo.Grow>=1 then
		updateOnGrowthLimit()
	else
		set["reformDetailBg_reformBtn"]:setEnabled(true)
		set["reformDetailBg_reformBtn"]:setOpacity(255)
		set["reformDetailBg_reformBtnTen"]:setEnabled(true)
		set["reformDetailBg_reformBtnTen"]:setOpacity(255)

		local pros = toolkit.getEquipProList(self.equipInfo)
		local barList = set["reformDetailBg_reformInfoBg_layout"]:getChildren()
		if not barList then
			for i=1,#pros+1 do
				local bar = self:createLuaSet("@reformBar")
				set["reformDetailBg_reformInfoBg_layout"]:addChild(bar[1])
			end
			barList = set["reformDetailBg_reformInfoBg_layout"]:getChildren()
		end
		local bar = barList:objectAtIndex(0)
		tolua.cast(bar,"ElfNode")
		updateReformBar(bar,res.locString("Global$Rank"),res.getEquipRankText(rank))

		for i=1,#pros do
			local pro = pros[i]
			local growth = calculateTool.getEquipProGrowth(self.equipInfo,pro,grow)
			if growth == 0 then
				if barList:count()>i then
					bar = barList:objectAtIndex(i)
					bar:removeFromParentAndCleanup(true)
				end
			else
				bar = barList:objectAtIndex(i)
				tolua.cast(bar,"ElfNode")
				if Config.LangName == "PT" then
					updateReformBar(bar,string.format("%s%s",toolkit.getEquipProName(pro),"+"),string.format("%.2f",growth))
				else
					updateReformBar(bar,string.format("%s%s",toolkit.getEquipProName(pro),res.locString("Global$GrowStatus")),string.format("%.2f",growth))
				end
			end
		end
	end
end

function DEquipOp:showBreakView( ... )
	self:updateEquipView(set,self.equipInfo)

	local set  = self.views[ViewType.Break] 

	local function createBall( node,tp )
		local iconSet = self:createLuaSet("@curBreakIcon")
		iconSet["tp"]:setString(tp)
		iconSet["tp"]:setFontFillColor(ccc4f(0.97,0.6,0.38,1.0),true)
		iconSet["fire"]:setLoops(-1)
		iconSet["fire"]:start()
		node:addChild(iconSet[1])
	end

	if not set then
		set = self:createLuaSet("@pageBreak")

		set["breakDetailBg_ZB_wenzi0_subTitle"]:setString(string.format("%s%s",res.locString("Equip$ListTitle"),res.locString("Equip$Breakthrough")))

		local recheck = false
		set["breakDetailBg_breakBtn"]:setListener(function ( ... )

            		local ct = dbManager.getInfoEquipTp(self.equipInfo.Tp)
           		local userLevel = require 'AppData'.getUserInfo().getLevel()

           		if ct.RoleLv > userLevel then
                			return self:toast(string.format(res.locString("Equip$breakLevelLimit"), ct.RoleLv))
           		 end

			print("----------on breakDetailBg_breakBtn click-----------")
			local func = function ( ... )
				self:send(netModel.getModelEquipBreak(self.equipInfo.Id,self.breakCostEquip.Id),function ( data )
					self.cachedUpdateFunc = function( ... )
						if data.D.Pet then
							require "PetInfo".setPet(data.D.Pet)
						end
						require "EquipInfo".removeEquipByIds({self.breakCostEquip.Id})
						for i,v in ipairs(self.equipList) do
							if v.Id == self.breakCostEquip.Id then
								table.remove(self.equipList,i)
								break
							end
						end

						-- local gems = require "GemInfo".getGemWithEquipId(self.breakCostEquip.Id)
						-- for _,v in ipairs(gems) do
						-- 	v.SetIn = 0
						-- end
						self.breakCostEquip = nil
						self.equipInfo.Use = 1
						self.equipInfo.Tp = self.equipInfo.Tp+1
						self:onEquipModify(self.equipInfo)
						require "EquipInfo".setEquipWithId(self.equipInfo)
						eventcenter.eventInput("OnEquipmentUpdate")
					end

					local anim1 = self:createLuaSet("@break1")[1]
					anim1:setLoops(1)
					anim1:setListener(function ( ... )
						print("-------anim1 end-----------")
						anim1:removeFromParentAndCleanup(true)
						local tp = math.max(1,self.equipInfo.Tp)
						local node = set[string.format("breakDetailBg_breakIcons_%d",tp)]
						local anim2 = self:createLuaSet("@break2")[1]
						set["animBg"]:addChild(anim2)
						local posNode,posAnim2 = NodeHelper:getPositionInScreen(node),NodeHelper:getPositionInScreen(anim2)
						local offset = CCPointMake(posNode.x-posAnim2.x,posNode.y-posAnim2.y)
						print(string.format("%d ----- %d",offset.x,offset.y))
						anim2:setRotation(math.atan2(offset.y,offset.x)/math.pi*180)
						local actArray = CCArray:create()
						actArray:addObject(CCMoveBy:create(0.3,offset))
						actArray:addObject(CCCallFunc:create(function (  )
							print("-------anim2 end-----------")
							local function sameEnding( ... )
								local anim3 = self:createLuaSet("@break3")[1]
								anim3:setLoops(1)
								anim3:setListener(function ( ... )
									print("-------anim3 end-----------")
									anim3:removeFromParentAndCleanup(true)
									local tpNode = self:createLuaSet("@tpNode")[1]
									tpNode:setResid(string.format("ZB_wenzi3_%d.png",self.equipInfo.Tp+1))
									tpNode:setPosition(node:getPosition())
									local actArray = CCArray:create()

									local arr1 = CCArray:create()
									arr1:addObject(CCMoveTo:create(0.5,CCPointMake(0,211)))
									arr1:addObject(CCEaseSineOut:create(CCScaleTo:create(0.5,2)))
									actArray:addObject(CCSpawn:create(arr1))
									actArray:addObject(CCHide:create())
									actArray:addObject(CCCallFunc:create(function (  )
										tpNode:removeFromParentAndCleanup(true)

										set["breakDetailBg_ZB_wenzi0_subTitle"]:setString(string.format("%s+%d",res.locString("Equip$Breakthrough"),self.equipInfo.Tp+1))
										local anim4 = self:createLuaSet("@break4")[1]
										set["animBg"]:addChild(anim4)
										anim4:setLoops(1)
										anim4:setListener(function ( ... )
											print("-------anim4 end-----------")
											table.remove(self.animFinishFuncs,1)()
											self.cachedUpdateFunc()
											self.cachedUpdateFunc = nil
											return self:showBreakView()
										end)
										anim4:start()
									end))
									set["animBg"]:addChild(tpNode)
									tpNode:runAction(CCSequence:create(actArray))
								end)
								local x,y = anim3:getPosition()
								local _x,_y = node:getPosition()
								anim3:setPosition(x+_x,y+_y)
								set["animBg"]:addChild(anim3)
								anim3:start()
							end

							anim2:removeFromParentAndCleanup(true)
							if self.equipInfo.Tp == 0 then
								createBall(node,1)
								sameEnding()
							else
								node:removeAllChildrenWithCleanup(true)
								local fire = self:createLuaSet("@roadFire")[1]
								fire:setLoops(-1)
								set[string.format("breakDetailBg_roadFires_%d",tp)]:addChild(fire)
								fire:start()
								local p = fire:getParent()
								p:setScaleX(0)
								local actArray = CCArray:create()
								actArray:addObject(CCScaleTo:create(0.5,1,1))
								actArray:addObject(CCCallFunc:create(function (  )
									node = set[string.format("breakDetailBg_breakIcons_%d",tp+1)]
									createBall(node,tp+1)
									sameEnding()
								end))
								p:runAction(CCSequence:create(actArray))
							end

						end))
						anim2:setLoops(-1)
						set["animBg"]:addChild(anim2)
						anim2:start()
						anim2:runAction(CCSequence:create(actArray))
					end)
					set["animBg"]:addChild(anim1)
					anim1:start()
					self._screenBtn:setVisible(true)
					self.animFinishFuncs[#self.animFinishFuncs+1] = function ( ... )
						self._screenBtn:setVisible(false)
						set["animBg"]:removeAllChildrenWithCleanup(true)
						local tp = math.max(1,self.equipInfo.Tp)
						local node = set[string.format("breakDetailBg_roadFires_%d",tp)]
						node:stopAllActions()
						node:setScale(1)
						require 'framework.helper.MusicHelper'.stopAllEffects()
					end
					require 'framework.helper.MusicHelper'.playEffect("raw/ui_sfx_breakthrough.mp3")
				end)
			end

			if recheck then
				self.breakCostEquip = require "EquipInfo".getEquipWithId(self.breakCostEquip.Id)
				recheck = false
			end

			if self.breakCostEquip.Use == 1 then
				local param = {}
				param.content = res.locString("Equip$BreakBtnTip")
				param.LeftBtnText = res.locString("Equip$Rebirth")
				param.callback = function ( ... )
					-- GleeCore:closeAllLayers()
					func()
				end
				param.cancelCallback = function ( ... )
					local unLockManager = require "UnlockManager"
					if unLockManager:isUnlock("EquipRebirth") then
						GleeCore:showLayer("DEquipOp", {EquipInfo = self.breakCostEquip, ViewType = 5, hideLeftTabs = true}, 0)
						recheck = true
					else
						self:toast(string.format(res.locString("Home$LevelUnLockTip"), unLockManager:getUnlockLv("EquipRebirth")))
					end
				end
				param.clickClose = true
				GleeCore:showLayer("DConfirmNT",param)
			else
				func()
			end
		end)

		self.views[ViewType.Break] = set
		self._bg:addChild(set[1])
	end

	if self.equipInfo.Tp<=0 then
		set["breakDetailBg_ZB_wenzi0_subTitle"]:setString(res.locString("Equip$EquipNoTp"))
	else
		set["breakDetailBg_ZB_wenzi0_subTitle"]:setString(string.format("%s+%d",res.locString("Equip$Breakthrough"),self.equipInfo.Tp))
	end

	local b = self:isTpLevelLimit()

	local nextTp = math.min(self.equipInfo.Tp+1,7) 
	local nextTpInfo = dbManager.getInfoEquipTp(nextTp)
	local lvUpOneTp = self.equipInfo.Tp ==  0 and  nextTpInfo.lvup or nextTpInfo.lvup - dbManager.getInfoEquipTp(nextTp-1).lvup
	local function createTip( content )
		local tip = self:createLuaSet("@tip")[1]
		tip:setString(content)
		tip:setFontFillColor(ccc4f(0.9,1.0,1,0.3),true)
		set["breakDetailBg_breakTipLayout"]:addChild(tip)
	end
	set["breakDetailBg_breakTipLayout"]:removeAllChildrenWithCleanup(true)
	createTip(string.format(res.locString("Equip$BreakTip"),nextTp,lvUpOneTp))
	-- createTip(string.format(res.locString("Equip$BreakTip1"),nextTpInfo.gemlv))
	for _,v in ipairs(toolkit.getEquipProList(self.equipInfo)) do
		if v~= "m" then
			createTip(string.format(res.locString("Equip$BreakTip2"),toolkit.getEquipProName(v),self.equipInfo[string.format("%sv",string.upper(v))]))
		end
	end

	for i=1,7 do
		local node = set[string.format("breakDetailBg_breakIcons_%d",i)]
		if i == self.equipInfo.Tp then
			if node:getChildrenCount()<=0 then
				createBall(node,self.equipInfo.Tp)
			end
		else
			node:removeAllChildrenWithCleanup(true)
		end
		local fireNode = set[string.format("breakDetailBg_roadFires_%d",i)]
		if fireNode then
			if i<self.equipInfo.Tp  and fireNode:getChildrenCount()<=0 then
				local fire = self:createLuaSet("@roadFire")[1]
				fire:setLoops(-1)
				fireNode:addChild(fire)
				fire:start()
			end
			if i>=self.equipInfo.Tp then
				fireNode:removeAllChildrenWithCleanup(true)
			end
		end
	end

	set["breakDetailBg_#breakInfoBg"]:setVisible(not b)
	set["breakDetailBg_tpMaxTipLabel"]:setVisible(b)
	if not b then
		local color = dbManager.getInfoEquipColor(self.dbInfo.color).tpneeds[nextTp]
		set["breakDetailBg_breakInfoBg_linearlayout_equipType"]:setString(res.locString(string.format("Equip$NameByColor%d",color)))
		set["breakDetailBg_breakInfoBg_linearlayout_equipType"]:setFontFillColor(res.rankColor4F[color+1],true)
		set["breakDetailBg_breakInfoBg_linearlayout_suffix"]:setString("x1")
		set["breakDetailBg_breakInfoBg_linearlayout_suffix"]:setFontFillColor(res.rankColor4F[color+1],true)

        -- print('msg:-------------------------------self.equipInfo')
        -- print(self.equipInfo)
		-- if not self.breakCostEquip then
		-- 	local selectCondition = function ( v )
		-- 		if v == self.equipInfo then
		-- 			return false
		-- 		end
		-- 		local hasEquip  = false
		-- 		for _,vv in ipairs(v.SetIn) do
		-- 			if vv>0 then
		-- 				hasEquip = true
		-- 				break
		-- 			end
		-- 		end
		-- 		if hasEquip then
		-- 			return false
		-- 		end

		-- 		return dbManager.getInfoEquipment(v.EquipmentId).color==color
		-- 	end

		-- 	local list = require "EquipInfo".selectByCondition(selectCondition)
		-- 	require "EquipInfo".sortForMagicBox(list)
		-- 	if #list>0 then
		-- 		self.breakCostEquip = list[1]
		-- 	end
		-- end
        if not self.breakCostEquip then
            local list = require "EquipInfo".selectByCondition(function(v)
                if v == self.equipInfo then
                        return false
                    end
                    local hasEquip  = false
                    for _,vv in ipairs(v.SetIn) do
                        if vv>0 then
                            hasEquip = true
                            break
                        end
                    end
                    if hasEquip then
                        return false
                    end

                    return dbManager.getInfoEquipment(v.EquipmentId).color==color
            end)
            require "EquipInfo".sortForMagicBox(list)
            if #list>0 then
                self.breakCostEquip = list[1]
            end
        end

		res.setEquipDetail(set["breakDetailBg_breakInfoBg_icon"],self.breakCostEquip,true)
		set["breakDetailBg_breakInfoBg_btn"]:setListener(function ( ... )
			local equipFunc = require "EquipInfo"
			local selectCondition = function ( v )
				if v == self.equipInfo then
					return false
				end
				if equipFunc.getSetInStatus(v) ~= 3 then
					return false
				end
				return dbManager.getInfoEquipment(v.EquipmentId).color==color
			end

			local function selectedSortFunc( list )
				if list then
					local nEquipId = self.breakCostEquip and self.breakCostEquip.Id
					table.sort(list, function ( a, b )
						if nEquipId then
							if a.Id == nEquipId then
								return true
							elseif b.Id == nEquipId then
								return false
							else
								return equipFunc.sortForMagicBoxFunc(a, b)
							end
						else
							return equipFunc.sortForMagicBoxFunc(a, b)
						end
					end)
				end
			end

			local itemListData = equipFunc.selectByCondition(selectCondition)
			if itemListData and #itemListData > 0 then
				local param = {}
				param.choseType = "ForUse"
				param.nEquip = self.breakCostEquip
				param.selectCondition = selectCondition
				param.selectedSortFunc = selectedSortFunc
				param.updateEquipEvent = function ( equipId )
					self.breakCostEquip = equipFunc.getEquipWithId(equipId)
					return self:showBreakView()		
				end
				GleeCore:showLayer("DEquipChose", param, 2)
			else
			 	self:toast(res.locString("Equip$NoEquipForChoose"))
			end
		end)
		set["breakDetailBg_breakInfoBg_btn_text"]:setVisible(self.breakCostEquip~=nil)
		if self.breakCostEquip then
			set["breakDetailBg_breakInfoBg_btn_text"]:runElfAction(res.getFadeAction(1))
		else
			set["breakDetailBg_breakInfoBg_btn_text"]:stopAllActions()
		end
	end

	local enable = not b and self.breakCostEquip~=nil

	set["breakDetailBg_breakBtn"]:setEnabled(enable)
	set["breakDetailBg_breakBtn"]:setOpacity(enable and 255 or 128)
end

function DEquipOp:showMosaicView( selectGemID,x,y )
	self:updateEquipView(set,self.equipInfo)

	if not self.mRunes then
		local runes = require "RuneInfo".selectByCondition(function ( v )
			return v.SetIn == self.equipInfo.Id
		end)
		self.mRunes = {}
		for _,v in ipairs(runes) do
			local dbinfo = dbManager.getInfoRune(v.RuneId)
			self.mRunes[dbinfo.Location] = v
		end
	end

	local set = self.views[ViewType.Mosaic]
	if not set then
		set = self:createLuaSet("@pageMosaic")

		set["reformDetailBg_ZB_wenzi0_subTitle"]:setString(string.format("%s%s",res.locString("Rune$Rune"),res.locString("Equip$Set")))
		self:playFlash(set["reformDetailBg_bottomRotate"],-1)

		require 'LangAdapter'.LabelNodeAutoShrink(set["reformDetailBg_mosaicBtn_btntext"],105)
		require 'LangAdapter'.LabelNodeAutoShrink(set["reformDetailBg_lvUpBtn_btntext"],105)

		set["reformDetailBg_mosaicBtn"]:setListener(function ( ... )
			if not self:checkMosaicEnable() then
				return
			end

			local newRunes = {}
			local newRuneIds = {}
			local new,rune
			for i=1,4 do
				rune = self.mRunes[i]
				new  = require "RuneInfo".selectByCondition(function ( v )
					local dbinfo = dbManager.getInfoRune(v.RuneId)
					if dbinfo.Location == i then
						if rune then
							return v.Id~=rune.Id and v.SetIn==0 and (v.Star>rune.Star or (v.Star == rune.Star and v.Lv>rune.Lv) )
						else
							return v.SetIn == 0
						end
					else
						return false
					end
				end)
				if #new>0 then
					table.sort(new,function ( a,b )
						if a.Star == b.Star then
							return a.Lv>b.Lv
						else
							return a.Star>b.Star
						end
					end)
					newRunes[i] = new[1]
					newRuneIds[#newRuneIds+1] = new[1].Id
				end
			end
			if #newRuneIds>0 then
				self:send(netModel.getModelRuneMosaicAll(self.equipInfo.Id,newRuneIds),function ( data )
					local posList = {}
					for i=1,4 do
						if newRunes[i] then
							posList[#posList+1] = i
						end
					end
					self.cachedUpdateFunc = function (  )
						print(data)
						if data.D.Pet then
							require "PetInfo".setPet(data.D.Pet)
						end
						for i=1,4 do
							if newRunes[i] then
								if self.mRunes[i] then
									self.mRunes[i].SetIn = 0
								end
								newRunes[i].SetIn = self.equipInfo.Id
								self.mRunes[i] = newRunes[i]
							end
						end
						eventcenter.eventInput("OnRuneUpdate")
					end
					self:showMosaicAnim(set,posList,function (  )
						self.cachedUpdateFunc()
						self.cachedUpdateFunc = nil
						self._screenBtn:setVisible(false)
						return self:showMosaicView()
					end)
				end)
			else
				return self:toast(res.locString("Rune$RuneOneKeyMosaicTip"))
			end
		end)

		set["reformDetailBg_lvUpBtn"]:setListener(function (  )
			local count = require "BagInfo".getItemCount(58)
			local useCount = 0
			local ids = {}
			for i=1,4 do
				local rune = self.mRunes[i]
				if rune then
					local price =  toolkit.getRuneLvUpCost(rune.Star,rune.Lv)
					if price<=count then
						ids[#ids+1] = rune.Id
						count = count - price
						useCount = useCount + price
						if count<=0 then
							break
						end
					end
				end
			end
			self:send(netModel.getModelRuneUpgradeAll(ids),function ( data )
				local posList = {}
				for _,v in ipairs(data.D.Runes) do
					for i=1,4 do
						local rune = self.mRunes[i]
						if rune and rune.Id == v.Id then
							if rune.Lv<v.Lv then
								posList[#posList+1] = i
							end
						end
					end
				end
				self.cachedUpdateFunc = function (  )
					print(data)
					if data.D.Pet then
						require "PetInfo".setPet(data.D.Pet)
					end
					require "BagInfo".useItem(58,useCount)
					for _,v in ipairs(data.D.Runes) do
						for i=1,4 do
							local rune = self.mRunes[i]
							if rune and rune.Id == v.Id then
								self.mRunes[i] = v
							end
						end
					end
					require "RuneInfo".updateRuneList(data.D.Runes)
					eventcenter.eventInput("OnRuneUpdate")
				end

				self:showUpgradeAnim(set,posList,function (  )
					self.cachedUpdateFunc()
					self.cachedUpdateFunc = nil
					self._screenBtn:setVisible(false)
					return self:showMosaicView()
				end)
			end)
		end)

		local btn
		for i=1,4 do
			btn = set[string.format("reformDetailBg_slot%d_btn",i)]
			btn:setListener(function (  )
				if not self:checkMosaicEnable() then
					return
				end
				local rune = self.mRunes[i]
				local listdata = require "RuneInfo".selectByCondition(function ( v )
					local dbinfo = dbManager.getInfoRune(v.RuneId)
					return dbinfo.Location == i
				end)
				table.sort(listdata,function ( a,b )
					local aSet = rune and  a.Id == rune.Id
					local bSet = rune and b.Id == rune.Id
					if aSet == bSet then
						return require "RuneInfo".commonSortFunc(a,b)
					else
						return aSet
					end
				end)
				GleeCore:showLayer("DRuneList",{ListData = listdata,CurRune = self.mRunes[i],Callback = function ( target )
					if not rune or rune.Id~=target.Id then
						self:send(netModel.getModelRuneMosaic(self.equipInfo.Id,target.Id),function ( data )
							self.cachedUpdateFunc = function (  )
								print(data)
								if data.D.Pets then
									for _,v in ipairs(data.D.Pets) do
										require "PetInfo".setPet(v)
									end
								end
								if rune then
									rune.SetIn = 0
								end
								target.SetIn = self.equipInfo.Id
								self.mRunes[i] = target
								eventcenter.eventInput("OnRuneUpdate")
							end
							self:showMosaicAnim(set,{i},function (  )
								self.cachedUpdateFunc()
								self.cachedUpdateFunc = nil
								self._screenBtn:setVisible(false)
								return self:showMosaicView()
							end)
						end)
					else
						self:send(netModel.getModelRuneMosaicDown(self.equipInfo.Id,target.Id),function ( data )
							print(data)
							if data.D.Pet then
								require "PetInfo".setPet(data.D.Pet)
							end
							target.SetIn = 0
							self.mRunes[i] = nil
							eventcenter.eventInput("OnRuneUpdate")
							return self:showMosaicView()
						end)
					end
				end})
			end)
		end

		self.views[ViewType.Mosaic] = set
		self._bg:addChild(set[1])
	end

	local icon,upIcon,rune,price,enable
	local hasMagicStoneCount = require "BagInfo".getItemCount(58)
	for i=1,4 do
		icon = set[string.format("reformDetailBg_slot%d_icon",i)]
		upIcon = set[string.format("reformDetailBg_slot%d_upIcon",i)]
		rune = self.mRunes[i]
		if rune then
			icon:setResid(string.format("rune-%d.png",rune.RuneId))
			price = toolkit.getRuneLvUpCost(rune.Star,rune.Lv)
			upIcon:setVisible(hasMagicStoneCount>=price)
			enable = enable or hasMagicStoneCount>=price
		else
			icon:setResid(nil)
			upIcon:setVisible(false)
		end
	end
	set["reformDetailBg_lvUpBtn"]:setEnabled(enable)
	set["reformDetailBg_bottomRotate"]:setPaused(true)
end

function DEquipOp:playFlash( node,loop,callback )
	node:setVisible(true)
	node:setPaused(false)
	local c = node:getModifierControllerByName('swf')
	c:setLoopMode(LOOP)
	c:setLoops(loop)
	if callback then
		node:playWithCallback("swf",callback)
	else
		node:play("swf")
	end
end

function DEquipOp:showMosaicAnim( set,posList,callback )
	set["reformDetailBg_bottomRotate"]:setPaused(false)
	self:playFlash(self._forAnim_runeMosaicAnim,1,function (  )
		print("------MosaicAnim Finish-------")
		table.remove(self.animFinishFuncs,1)()
		return callback()
	end)
	for _,v in ipairs(posList) do
		local flashNode =  set[string.format("reformDetailBg_slot%d_mosaicAnim",v)]
		self:playFlash(flashNode,1,function (  )
			flashNode:setPaused(true)
			flashNode:setVisible(false)
		end)
	end
	self._screenBtn:setVisible(true)
	self.animFinishFuncs[#self.animFinishFuncs+1] = function ( ... )
		self._forAnim_runeMosaicAnim:setPaused(true)
		self._forAnim_runeMosaicAnim:setVisible(false)
	end
end

function DEquipOp:showUpgradeAnim( set,posList,callback )
	set["reformDetailBg_bottomRotate"]:setPaused(false)
	self:playFlash(self._forAnim_runeUpgradeAnim,1,function (  )
		print("------UpgradeAnim Finish-------")
		table.remove(self.animFinishFuncs,1)()
		return callback()
	end)
	for _,v in ipairs(posList) do
		set[string.format("reformDetailBg_slot%d_upIcon",v)]:setVisible(false)
		local flashNode =  set[string.format("reformDetailBg_slot%d_upgradeAnim",v)]
		self:playFlash(flashNode,1,function (  )
			flashNode:setPaused(true)
			flashNode:setVisible(false)
		end)
	end
	self._screenBtn:setVisible(true)
	self.animFinishFuncs[#self.animFinishFuncs+1] = function ( ... )
		self._forAnim_runeUpgradeAnim:setPaused(true)
		self._forAnim_runeUpgradeAnim:setVisible(false)
	end
end

function DEquipOp:showRebirthView( hasRebirth )

    GuideHelper:startGuide('GCfg09')
	self:updateEquipView(set,self.equipInfo)

	local set  = self.views[ViewType.Rebirth]
	local cost = dbManager.getInfoEquipColor(self.dbInfo.color).reuseconsume

	local function showEquip( node,equip,gray )
		if gray then
			node:setColorf(0.5,0.5,0.5,1)
		else
			node:setColorf(1,1,1,1)
		end
		local children = node:getChildren()
		local icon = children:objectAtIndex(0)
		tolua.cast(icon,"ElfNode")
		res.setEquipIconNew(icon,equip)
		local name = self.dbInfo.name
		if equip.Tp and equip.Tp>0 then
			name = name.."+"..equip.Tp
		end
		local temp = children:objectAtIndex(1)
		tolua.cast(temp,"LabelNode")
		temp:setString(name)
		temp:setFontFillColor(res.getEquipColor(self.dbInfo.color), true)
		temp = children:objectAtIndex(2)
		tolua.cast(temp,"LabelNode")
		temp:setString(string.format("%s Lv.%d",res.getEquipRankText(equip.Rank),equip.Lv))
	end

	if not set then
		set = self:createLuaSet("@pageRebirth")

		set["reformDetailBg_ZB_wenzi0_subTitle"]:setString(string.format("%s%s",res.locString("Equip$ListTitle"),res.locString("Equip$Rebirth")))

		require "LangAdapter".LabelNodeAutoShrink(set["reformDetailBg_#strengthenDes"],450)

		require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
			set["reformDetailBg_detailTitle_#curHasLabel"]:setVisible(false)
		end)

		set["reformDetailBg_reformBtn"]:setListener(function ( ... )
			if  require "UserInfo".getCoin()<cost then
				return toolkit.showDialogOnCoinNotEnough()
			end
			local param = {}
			param.content = res.locString("Equip$RebirthTip")
			param.callback = function ( ... )
                -- 还原突破界面已经选择的材料
				self.breakCostEquip = nil
				self:send(netModel.getmodelEquipRebirth(self.equipInfo.Id),function ( data )
					self.cachedUpdateFunc = function ( ... )
						print(data)
						local appFunc = require "AppData"
						appFunc.updateResource(data.D.Resource)
						self:onEquipModify(data.D.Equipment)
						require "EquipInfo".setEquipWithId(self.equipInfo)
						if data.D.Pet then
							require "PetInfo".setPet(data.D.Pet)
						end
							
						-- local gems = require "GemInfo".getGemWithEquipId(self.equipInfo.Id)
						-- for _,v in ipairs(gems) do
						-- 	v.SetIn = 0
						-- end
						eventcenter.eventInput("OnEquipmentUpdate")
					end
					self.cachedViewUpdateFunc = function ( ... )
						self:updateEquipView(set,self.equipInfo)
						self:updateCurHasBar(set["reformDetailBg_#detailTitle"],require "BagInfo".getItemCount(15),require "UserInfo".getCoin(),"N_TY_chongzhushuijing1.png")
						-- set["reformDetailBg_detailTitle_coinCountLabel"]:setString(require "UserInfo".getCoin())
						-- set["reformDetailBg_detailTitle_diamondCountLabel"]:setString(require "BagInfo".getItemCount(15))
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

	self:updateCurHasBar(set["reformDetailBg_#detailTitle"],require "BagInfo".getItemCount(15),require "UserInfo".getCoin(),"N_TY_chongzhushuijing1.png")

	-- set["reformDetailBg_detailTitle_diamondCountLabel"]:setString(require "BagInfo".getItemCount(15))
	-- set["reformDetailBg_detailTitle_coinCountLabel"]:setString(require "UserInfo".getCoin())
	set["reformDetailBg_DiamondCostLabel_DiamondCostValueLabel"]:setString(cost)

	set["reformDetailBg_reformBtn"]:setEnabled(self.equipInfo.Use == 1)
	set["reformDetailBg_reformBtn"]:setOpacity(self.equipInfo.Use == 1 and 255 or 128)
	
	showEquip(set["reformDetailBg_reformInfoBg_left"],self.equipInfo,hasRebirth)
	local temp = table.clone(self.equipInfo)
	temp.Tp = 0
	temp.Lv = 1
	temp.Rank = 1
	showEquip(set["reformDetailBg_reformInfoBg_right"],temp,not hasRebirth)
end

function DEquipOp:checkMosaicEnable(  )
	if require "Toolkit".isRuneMosaicEnable(self.dbInfo.location) then
		return true
	else
		self:toast(res.locString("Rune$MosaicEnableCheckTip"))
		return false
	end
end

function DEquipOp:parseValue( v )
	if v>=1000000 then
		if Config.LangName == "english" or Config.LangName == "German" then
			v = string.format("%.1fK",v/1000)
		else
			v = string.format("%.1fw",v/10000)
		end
	end
	return v
end

function DEquipOp:updateCurHasBar( bar,value1,value2,icon1,icon2)
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

function DEquipOp:updateEquipView( nodeSet,data )
	local set = self.equipViewSet
	if not set then
		set = self:createLuaSet("@equipView")
		self._bg:addChild(set[1])
		self.equipViewSet = set
	end

	local name = self.dbInfo.name
	if data.Tp and data.Tp>0 then
		name = name.."+"..data.Tp
	end
	set["equipBg_headBar_equipName"]:setString(name)
	-- set["equipBg_headBar_equipName"]:setFontFillColor(res.getEquipColor(self.dbInfo.color), true)
	set["equipBg_equipTypeIcon"]:setResid(res.getEquipTypeRes(self.dbInfo.location))
	res.setEquipIconNew(set["equipBg_equipIcon"],data)

	self:updateEquipView1(nodeSet,data)
end

function DEquipOp:updateEquipView1( nodeSet,data )
	local set = self.equipProSet
	if not set then
		set = self:createLuaSet("@equipPro")
		self.equipProSet = set
		print("1")
		toolkit.setEquipSetInLabel(nil,data,function ( ret )
			if ret then
				local equiplayout = self:createLuaSet("@equipOnLayout")
				require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
					equiplayout["#sp"]:removeFromParentAndCleanup(true)
					set["layout_#title"]:setFontSize(23)
					equiplayout["#label"]:setFontSize(23)
				end)
				equiplayout["pet"]:setString(ret)
				print("2")
				set["layout"]:addChild(equiplayout[1],-1)
				set["layout"]:visit()
				set["layout"]:layout()
			end
		end)
		print("3")
		self._bg:addChild(set[1])

		selectLang(nil,nil,function (  )
	    	local x,y = set["layout"]:getPosition()
	    	set["layout"]:setPosition(x-40,y)
	    end,nil,function (  )
	    	local x,y = set["layout"]:getPosition()
	    	set["layout"]:setPosition(x-40,y)
	    end,nil,function (  )
	    	local x,y = set["layout"]:getPosition()
	    	set["layout"]:setPosition(x-40,y)
	    end,function (  )
	    	
	    end,function (  )
	    	-- local x,y = set["layout"]:getPosition()
	    	-- set["layout"]:setPosition(x-40,y)
	    end)
	end
	set[1]:setVisible(true)

	local function findProbar( pos,index )
		local layout = pos == 0 and set["layout_proLayout_layoutL"] or set["layout_proLayout_layoutR"]
		local children = layout:getChildren()
		if not children or children:count()<index+1 then
			local temp = self:createLuaSet("@equipProBar")
			require 'LangAdapter'.LayoutChildrenReverseifArabic(temp[1])
			layout:addChild(temp[1])
			children =  layout:getChildren()
		end
		local bar = children:objectAtIndex(index)
		tolua.cast(bar,"ElfNode")
		return bar
	end

	local index = 0

	local function updateProBar( name,value,valueColor )
		local pos,i = index%2,math.floor(index/2)
		local bar = findProbar(pos,i)
		local temp = bar:findNodeByName("name")
		tolua.cast(temp,"LabelNode")
		require 'LangAdapter'.fontSize(temp,nil,nil,18,18,18)
		temp:setString(name)
		temp = bar:findNodeByName("value")
		tolua.cast(temp,"LabelNode")
		require 'LangAdapter'.fontSize(temp,nil,nil,18,18,18)
		temp:setString(value)
		if valueColor then
			temp:setFontFillColor(valueColor,true)
		end
		index = index + 1
	end

	local levelMax = toolkit.getEquipLevelCap(data)
	data.levelMax = levelMax

	local color = data.Lv>=data.levelMax and res.color4F.red or res.color4F.white
	updateProBar(res.locString("Global$Level"),string.format("%d/%d",data.Lv,data.levelMax),color)
	updateProBar(res.locString("Global$Rank"),res.getEquipRankText(data.Rank))
	local pros = toolkit.getEquipProList(data)
	for i=1,#pros do
		local pro = pros[i]
		updateProBar(toolkit.getEquipProName(pro),string.format("%s",calculateTool.getEquipProDataStrByEquipInfo(data,pro)))
		local growth = calculateTool.getEquipProGrowth(data,pro)
		if growth ~= 0 then
			if Config.LangName == "vn" or Config.LangName == "Arabic" then
				updateProBar(res.locString("Global$GrowStatus"),string.format("%.2f",growth))
			elseif Config.LangName == "PT" then
				updateProBar(string.format("%s%s",toolkit.getEquipProName(pro),"+"),string.format("%.2f",growth))
			else
				updateProBar(string.format("%s%s",toolkit.getEquipProName(pro),res.locString("Global$GrowStatus")),string.format("%.2f",growth))
			end
		end
	end
    set["layout_proLayout_layoutL"]:layout()
	local h = set["layout_proLayout_layoutL"]:getContentSize().height+20
	set["layout_proLayout"]:setContentSize(CCSizeMake(142,h))
	set["layout_proLayout_layoutL"]:setPosition(-70,h / 2)
	set["layout_proLayout_layoutR"]:setPosition(50,h / 2)
    -- self:runWithDelay(function()
        
    -- --set["layout_proLayout_layoutR"]:layout()
    --     set["layout"]:layout()
    -- end, 0.1)
    set["layout"]:layout()
    selectLang(nil,nil,function (  )
    	set["layout_proLayout_layoutR"]:setPosition(20,h/2)
    end,nil,function (  )
    	set["layout_proLayout_layoutR"]:setPosition(20,h/2)
    end,nil,function (  )
    	set["layout_proLayout_layoutR"]:setPosition(20,h/2)
    end,function (  )
    	set["layout_proLayout_layoutR"]:setPosition(30,h / 2)
    end,function (  )
  --   	set["layout_proLayout_layoutL"]:setPosition(-20,h / 2)
		set["layout_proLayout_layoutR"]:setPosition(20,h / 2)
    end)
	-- local x = set["equipInfoBg_layoutR"]:getPosition()
	-- local _,y = set["equipInfoBg_layoutL"]:getPosition()
	-- y = y+set["equipInfoBg_layoutL"]:getContentSize().height/2
	-- set["equipInfoBg_layoutR"]:setPosition(x,y)
end

function DEquipOp:checkSameTypeOfGem( gems,gemType )
	for _,v in pairs(gems) do
		local dbGem = dbManager.getInfoGem(v.GemId)
		if dbGem.type == gemType then
			return false
		end
	end
	return true
end

function DEquipOp:getEquipStrengthenToastString( equip,lvUp )
	local list = {}
    print(tostring(lvUp))
	-- table.insert(list,string.format("等级+%d",lvUp))
	local pros = toolkit.getEquipProList(equip)

	local t = {}
	for i=1,#pros do
		local pro = pros[i]
		if pro ~= "m" then
			local name = toolkit.getEquipProName(pro)
			local pre = calculateTool.getEquipProDataByEquipInfo(self.equipInfo,pro) - calculateTool.getEquipProAddByRune(self.equipInfo,pro)
			local now = calculateTool.getEquipProData(self.equipInfo[string.format("%sv",string.upper(pro))],self.equipInfo.Lv+lvUp,calculateTool.getEquipProGrowth(self.equipInfo,pro),self.equipInfo.Tp)
			table.insert(list,string.format("%s +%d",name,now-pre))
		end
	end
	return list
end

function DEquipOp:getGemTypeForEquip( equipLocation )
	local data = require "gem"
	local ret = {}
	for i,v in ipairs(data) do
		if table.find(v.location,equipLocation) then
			if not table.find(ret,v.type) then
				table.insert(ret,v.type)
			end
		end
	end
	return ret
end

function DEquipOp:getSelectedGemList( list,lvLimit )
	table.sort(list,function ( a,b )
		local aLv,bLv = a.Lv,b.Lv
		if (aLv>lvLimit and bLv>lvLimit) or (aLv<=lvLimit and bLv<=lvLimit) then
			if aLv == bLv then
				local aId,bId = a.GemId,b.GemId
				return aId<bId
			else
				return aLv>bLv
			end
		else
			return aLv<=lvLimit
		end
	end)
	return list
end

function DEquipOp:isTpLevelLimit( ... )
	local info = dbManager.getInfoEquipTp(self.equipInfo.Tp+1)
	return not info or self.dbInfo.color<info.color
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DEquipOp, "DEquipOp")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DEquipOp", DEquipOp)


