local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local equipFunc = require "EquipInfo"
local AppData = require 'AppData'
local DMagicBox = class(LuaDialog)
local GuideHelper = require 'GuideHelper'
local EventCenter = require "EventCenter"
local netModel = require "netModel"
local bagFunc = require "BagInfo"
local Toolkit = require "Toolkit"
local userFunc = AppData.getUserInfo()

function DMagicBox:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DMagicBox.cocos.zip")
    return self._factory:createDocument("DMagicBox.cocos")
end
 
--@@@@[[[[
function DMagicBox:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._BG = set:getElfNode("BG")
    self._BG_equipSynthesis = set:getElfNode("BG_equipSynthesis")
    self._BG_equipSynthesis_main = set:getElfNode("BG_equipSynthesis_main")
    self._BG_equipSynthesis_main_title1 = set:getLabelNode("BG_equipSynthesis_main_title1")
    self._BG_equipSynthesis_main_title2 = set:getRichLabelNode("BG_equipSynthesis_main_title2")
    self._BG_equipSynthesis_main_input1 = set:getElfNode("BG_equipSynthesis_main_input1")
    self._BG_equipSynthesis_main_input1_img = set:getElfNode("BG_equipSynthesis_main_input1_img")
    self._BG_equipSynthesis_main_input1_btn = set:getButtonNode("BG_equipSynthesis_main_input1_btn")
    self._BG_equipSynthesis_main_input2 = set:getElfNode("BG_equipSynthesis_main_input2")
    self._BG_equipSynthesis_main_input2_img = set:getElfNode("BG_equipSynthesis_main_input2_img")
    self._BG_equipSynthesis_main_input2_btn = set:getButtonNode("BG_equipSynthesis_main_input2_btn")
    self._BG_equipSynthesis_main_input3 = set:getElfNode("BG_equipSynthesis_main_input3")
    self._BG_equipSynthesis_main_input3_img = set:getElfNode("BG_equipSynthesis_main_input3_img")
    self._BG_equipSynthesis_main_input3_btn = set:getButtonNode("BG_equipSynthesis_main_input3_btn")
    self._BG_equipSynthesis_main_input4 = set:getElfNode("BG_equipSynthesis_main_input4")
    self._BG_equipSynthesis_main_input4_img = set:getElfNode("BG_equipSynthesis_main_input4_img")
    self._BG_equipSynthesis_main_input4_btn = set:getButtonNode("BG_equipSynthesis_main_input4_btn")
    self._BG_equipSynthesis_main_input5 = set:getElfNode("BG_equipSynthesis_main_input5")
    self._BG_equipSynthesis_main_input5_img = set:getElfNode("BG_equipSynthesis_main_input5_img")
    self._BG_equipSynthesis_main_input5_btn = set:getButtonNode("BG_equipSynthesis_main_input5_btn")
    self._BG_equipSynthesis_main_oneKeyInputBtn = set:getClickNode("BG_equipSynthesis_main_oneKeyInputBtn")
    self._BG_equipSynthesis_main_yaoyiyaoBtn = set:getClickNode("BG_equipSynthesis_main_yaoyiyaoBtn")
    self._BG_equipSynthesis_main_goldNeed_count = set:getLabelNode("BG_equipSynthesis_main_goldNeed_count")
    self._BG_equipSynthesis_main_box = set:getElfNode("BG_equipSynthesis_main_box")
    self._BG_equipSynthesis_main_open = set:getElfNode("BG_equipSynthesis_main_open")
    self._BG_equipSynthesis_main_forAnim = set:getElfNode("BG_equipSynthesis_main_forAnim")
    self._bgAnim = set:getSimpleAnimateNode("bgAnim")
    self._box = set:getElfNode("box")
    self._light = set:getElfNode("light")
    self._layout = set:getLayoutNode("layout")
    self._icon = set:getElfNode("icon")
    self._name = set:getLabelNode("name")
    self._BG_equipSynthesis_screenBtn = set:getButtonNode("BG_equipSynthesis_screenBtn")
    self._BG_equipBuy = set:getElfNode("BG_equipBuy")
    self._BG_equipBuy_button = set:getElfNode("BG_equipBuy_button")
    self._BG_equipBuy_button_btnNormal = set:getClickNode("BG_equipBuy_button_btnNormal")
    self._BG_equipBuy_button_btnNormal_point = set:getElfNode("BG_equipBuy_button_btnNormal_point")
    self._BG_equipBuy_button_btnOnce = set:getClickNode("BG_equipBuy_button_btnOnce")
    self._BG_equipBuy_button_btnOnce_title = set:getLabelNode("BG_equipBuy_button_btnOnce_title")
    self._BG_equipBuy_button_btnOnce_point = set:getElfNode("BG_equipBuy_button_btnOnce_point")
    self._BG_equipBuy_button_btnTen = set:getClickNode("BG_equipBuy_button_btnTen")
    self._BG_equipBuy_button_item1_V = set:getLabelNode("BG_equipBuy_button_item1_V")
    self._BG_equipBuy_button_item2 = set:getLinearLayoutNode("BG_equipBuy_button_item2")
    self._BG_equipBuy_button_item2_price = set:getLabelNode("BG_equipBuy_button_item2_price")
    self._BG_equipBuy_button_item3_price = set:getLabelNode("BG_equipBuy_button_item3_price")
    self._BG_equipBuy_button_time = set:getLabelNode("BG_equipBuy_button_time")
    self._BG_equipBuy_button_item3tip = set:getLinearLayoutNode("BG_equipBuy_button_item3tip")
    self._BG_equipBuy_button_item3tip_title = set:getLabelNode("BG_equipBuy_button_item3tip_title")
    self._BG_equipBuy_button_item3tip_v = set:getTimeNode("BG_equipBuy_button_item3tip_v")
    self._BG_equipBase = set:getElfNode("BG_equipBase")
    self._bg = set:getElfNode("bg")
    self._layoutGird = set:getLayoutNode("layoutGird")
    self._icon = set:getElfNode("icon")
    self._btn = set:getButtonNode("btn")
    self._anim = set:getSimpleAnimateNode("anim")
    self._icon = set:getElfNode("icon")
    self._btn = set:getButtonNode("btn")
    self._anim = set:getSimpleAnimateNode("anim")
    self._icon = set:getElfNode("icon")
    self._btn = set:getButtonNode("btn")
    self._anim = set:getSimpleAnimateNode("anim")
    self._icon = set:getElfNode("icon")
    self._btn = set:getButtonNode("btn")
    self._anim = set:getSimpleAnimateNode("anim")
    self._layoutCost = set:getLinearLayoutNode("layoutCost")
    self._layoutCost_v = set:getLabelNode("layoutCost_v")
    self._btnAddOneKey = set:getClickNode("btnAddOneKey")
    self._btnAuth = set:getClickNode("btnAuth")
    self._bg = set:getElfNode("bg")
    self._bg1 = set:getElfNode("bg1")
    self._bg1_eq = set:getElfNode("bg1_eq")
    self._bg1_eq_icon = set:getElfNode("bg1_eq_icon")
    self._bg1_eq_btn = set:getButtonNode("bg1_eq_btn")
    self._bg1_eq_text = set:getLabelNode("bg1_eq_text")
    self._bg1_eq_name = set:getLabelNode("bg1_eq_name")
    self._bg1_eq_layoutLv = set:getLinearLayoutNode("bg1_eq_layoutLv")
    self._bg1_eq_layoutLv_k = set:getLabelNode("bg1_eq_layoutLv_k")
    self._bg1_eq_layoutLv_v = set:getLabelNode("bg1_eq_layoutLv_v")
    self._bg1_eq_layoutRank = set:getLinearLayoutNode("bg1_eq_layoutRank")
    self._bg1_eq_layoutRank_k = set:getLabelNode("bg1_eq_layoutRank_k")
    self._bg1_eq_layoutRank_v = set:getLabelNode("bg1_eq_layoutRank_v")
    self._bg1_layoutProp = set:getLayoutNode("bg1_layoutProp")
    self._text = set:getLabelNode("text")
    self._text = set:getLabelNode("text")
    self._text = set:getLabelNode("text")
    self._text = set:getLabelNode("text")
    self._text = set:getLabelNode("text")
    self._text = set:getLabelNode("text")
    self._bg1_tip = set:getLabelNode("bg1_tip")
    self._bg2 = set:getElfNode("bg2")
    self._bg2_eq = set:getElfNode("bg2_eq")
    self._bg2_eq_icon = set:getElfNode("bg2_eq_icon")
    self._bg2_eq_btn = set:getButtonNode("bg2_eq_btn")
    self._bg2_eq_text = set:getLabelNode("bg2_eq_text")
    self._bg2_eq_name = set:getLabelNode("bg2_eq_name")
    self._bg2_eq_layoutLv = set:getLinearLayoutNode("bg2_eq_layoutLv")
    self._bg2_eq_layoutLv_k = set:getLabelNode("bg2_eq_layoutLv_k")
    self._bg2_eq_layoutLv_v = set:getLabelNode("bg2_eq_layoutLv_v")
    self._bg2_eq_layoutRank = set:getLinearLayoutNode("bg2_eq_layoutRank")
    self._bg2_eq_layoutRank_k = set:getLabelNode("bg2_eq_layoutRank_k")
    self._bg2_eq_layoutRank_v = set:getLabelNode("bg2_eq_layoutRank_v")
    self._bg2_layoutProp = set:getLayoutNode("bg2_layoutProp")
    self._bg = set:getElfNode("bg")
    self._text = set:getLabelNode("text")
    self._bg = set:getElfNode("bg")
    self._text = set:getLabelNode("text")
    self._bg = set:getElfNode("bg")
    self._text = set:getLabelNode("text")
    self._bg = set:getElfNode("bg")
    self._text = set:getLabelNode("text")
    self._bg = set:getElfNode("bg")
    self._text = set:getLabelNode("text")
    self._bg = set:getElfNode("bg")
    self._text = set:getLabelNode("text")
    self._bg2_tip = set:getLabelNode("bg2_tip")
    self._layoutTransCost = set:getLinearLayoutNode("layoutTransCost")
    self._layoutTransCost_v = set:getLabelNode("layoutTransCost_v")
    self._btnTrans = set:getClickNode("btnTrans")
    self._layoutSuccinctCost = set:getLinearLayoutNode("layoutSuccinctCost")
    self._layoutSuccinctCost_v = set:getLabelNode("layoutSuccinctCost_v")
    self._btnSuccinct = set:getClickNode("btnSuccinct")
    self._btnShield = set:getButtonNode("btnShield")
    self._BG_tabs = set:getLayoutNode("BG_tabs")
    self._BG_tabs_tabEquip = set:getTabNode("BG_tabs_tabEquip")
    self._BG_tabs_tabEquip_point = set:getElfNode("BG_tabs_tabEquip_point")
    self._BG_tabs_tabSynthesis = set:getTabNode("BG_tabs_tabSynthesis")
    self._BG_tabs_tabSynthesis_normal_des = set:getLabelNode("BG_tabs_tabSynthesis_normal_des")
    self._BG_tabs_tabSynthesis_pressed_des = set:getLabelNode("BG_tabs_tabSynthesis_pressed_des")
    self._BG_tabs_tabAuth = set:getTabNode("BG_tabs_tabAuth")
    self._BG_tabs_tabAuth_point = set:getElfNode("BG_tabs_tabAuth_point")
    self._BG_tabs_tabAuth_lock = set:getElfNode("BG_tabs_tabAuth_lock")
    self._BG_tabs_tabSuccinct = set:getTabNode("BG_tabs_tabSuccinct")
    self._BG_tabs_tabSuccinct_point = set:getElfNode("BG_tabs_tabSuccinct_point")
    self._BG_tabs_tabSuccinct_lock = set:getElfNode("BG_tabs_tabSuccinct_lock")
    self._BG_topBar_bg_title = set:getLabelNode("BG_topBar_bg_title")
    self._BG_topBar_btnHelp = set:getButtonNode("BG_topBar_btnHelp")
    self._BG_topBar_btnReturn = set:getButtonNode("BG_topBar_btnReturn")
    self._BG_btnHelp = set:getButtonNode("BG_btnHelp")
    self._Sequence = set:getElfAction("Sequence")
    self._Spawn = set:getElfAction("Spawn")
--    self._@lightAnim = set:getSimpleAnimateNode("@lightAnim")
--    self._@anim = set:getElfNode("@anim")
--    self._@equip = set:getElfNode("@equip")
--    self._@pageAuth = set:getElfNode("@pageAuth")
--    self._@itemAuth = set:getElfNode("@itemAuth")
--    self._@itemAuth = set:getElfNode("@itemAuth")
--    self._@itemAuth = set:getElfNode("@itemAuth")
--    self._@itemAuth = set:getElfNode("@itemAuth")
--    self._@pageSuccinct = set:getElfNode("@pageSuccinct")
--    self._@tabProp = set:getTabNode("@tabProp")
--    self._@tabProp = set:getTabNode("@tabProp")
--    self._@tabProp = set:getTabNode("@tabProp")
--    self._@tabProp = set:getTabNode("@tabProp")
--    self._@tabProp = set:getTabNode("@tabProp")
--    self._@tabProp = set:getTabNode("@tabProp")
--    self._@propText = set:getElfNode("@propText")
--    self._@propText = set:getElfNode("@propText")
--    self._@propText = set:getElfNode("@propText")
--    self._@propText = set:getElfNode("@propText")
--    self._@propText = set:getElfNode("@propText")
--    self._@propText = set:getElfNode("@propText")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DMagicBox", function ( userData )
 	Launcher.callNet(netModel.getModelEqPropUnlock(),function ( data )
 		if data and data.D then
 			Launcher.Launching(data)
 		end
 	end)
end)

function DMagicBox:onInit( userData, netData )
	require "LangAdapter".LabelNodeAutoShrink(self._set:getLabelNode("BG_equipSynthesis_main_yaoyiyaoBtn_#label"),110)
	require 'LangAdapter'.fontSize(self._BG_topBar_bg_title,nil,nil,30)
	-- require 'LangAdapter'.fontSize(self._BG_tabs_tabSynthesis_normal_des,nil,nil,28)
	-- require 'LangAdapter'.fontSize(self._BG_tabs_tabSynthesis_pressed_des,nil,nil,28)

	local tabTextAdjustFunc = function (  )
		local maxW = 72
		self._set:getLabelNode("BG_tabs_tabEquip_normal_#des"):setDimensions(CCSizeMake(0,0))
		self._set:getLabelNode("BG_tabs_tabEquip_pressed_#des"):setDimensions(CCSizeMake(0,0))
		self._BG_tabs_tabSynthesis_normal_des:setDimensions(CCSizeMake(0,0))
		self._BG_tabs_tabSynthesis_pressed_des:setDimensions(CCSizeMake(0,0))
		self._set:getLabelNode("BG_tabs_tabAuth_normal_#des"):setDimensions(CCSizeMake(0,0))
		self._set:getLabelNode("BG_tabs_tabAuth_pressed_#des"):setDimensions(CCSizeMake(0,0))
		self._set:getLabelNode("BG_tabs_tabSuccinct_normal_#des"):setDimensions(CCSizeMake(0,0))
		self._set:getLabelNode("BG_tabs_tabSuccinct_pressed_#des"):setDimensions(CCSizeMake(0,0))

		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("BG_tabs_tabEquip_normal_#des"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("BG_tabs_tabEquip_pressed_#des"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._BG_tabs_tabSynthesis_normal_des,maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._BG_tabs_tabSynthesis_pressed_des,maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("BG_tabs_tabAuth_normal_#des"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("BG_tabs_tabAuth_pressed_#des"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("BG_tabs_tabSuccinct_normal_#des"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("BG_tabs_tabSuccinct_pressed_#des"),maxW)
	end
	selectLang(nil,nil,tabTextAdjustFunc,nil,tabTextAdjustFunc)
	require 'LangAdapter'.LabelNodeAutoShrink(self._BG_equipSynthesis_main_title1,730)
	require 'LangAdapter'.LabelNodeAutoShrink(self._BG_equipSynthesis_main_title2,730)
	
	if netData and netData.D then
		self.EqPropUnLock = netData.D.Unlocked
	end
	selectLang(nil,nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
		self._set:getLabelNode("BG_equipSynthesis_main_yaoyiyaoBtn_#label"):setFontSize(22)
	end)

	res.doActionDialogShow(self._BG,function ( ... )
		require 'GuideHelper':registerPoint('免费赠送',self._BG_equipBuy_button_btnOnce)
		require 'GuideHelper':registerPoint('合成',self._BG_equipSynthesis_main_yaoyiyaoBtn)
		require 'GuideHelper':registerPoint('一键放入',self._BG_equipSynthesis_main_oneKeyInputBtn)
		require 'GuideHelper':registerPoint('合成tab',self._BG_tabs_tabSynthesis)
		require 'GuideHelper':registerPoint('鉴定',self._BG_tabs_tabAuth)
		require 'GuideHelper':check('DMagicBox')
	end)

	self.tickHandle = {}
	self.animFinishFuncs = {}
	self.mNeedCheck = false

	self:initPages()
	self:addBtnListener()

	self.tabIndexSelected = (userData and userData.ShowIndex) and userData.ShowIndex or 1
	self:updateTriggle()

	self:updateRedTip()

	local actData = AppData.getActivityInfo().getDataByType(23)
	if actData then
		self._BG_equipSynthesis_main_title1:setVisible(true)
		self._BG_equipSynthesis_main_title1:setString(string.format(res.locString("Activity$MagicBoxTitle1"),Toolkit.getLuckyMagicBoxMaxCount(actData)))
	else
		self._BG_equipSynthesis_main_title1:setVisible(false)
		local x,y = self._BG_equipSynthesis_main_title2:getPosition()
		self._BG_equipSynthesis_main_title2:setPosition(x,y-15)
	end

	EventCenter.addEventFunc("EventEquipTabSel", function ( data )
		if data and data.layer == "DMagicBox" and data.ShowIndex then
			self:updateTriggle(data.ShowIndex)
		end
	end, "DMagicBox")
end

function DMagicBox:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DMagicBox:updateTriggle( index )
	local tabBtns = {
		self._BG_tabs_tabEquip,
		self._BG_tabs_tabSynthesis,
		self._BG_tabs_tabAuth,
		self._BG_tabs_tabSuccinct,
	}
	tabBtns[index and index or self.tabIndexSelected]:trigger(nil)
end

function DMagicBox:initPages( ... )
	self.pageList = {}
	local pageAuth = self:createLuaSet("@pageAuth")
	self._BG_equipBase:addChild(pageAuth[1])
	self.pageList["pageAuth"] = pageAuth

	local pageSuccinct = self:createLuaSet("@pageSuccinct")
	self._BG_equipBase:addChild(pageSuccinct[1])
	self.pageList["pageSuccinct"] = pageSuccinct
end

function DMagicBox:updatePageAuth( ... )
	local setAuth = self.pageList["pageAuth"]

	setAuth["layoutGird"]:removeAllChildrenWithCleanup(true)
	self.AuthSelectList = self.AuthSelectList or {}
	local animList = {}
	for i=1,4 do
		local item = self:createLuaSet("@itemAuth")
		setAuth["layoutGird"]:addChild(item[1])
		if i <= #self.AuthSelectList then
			local nEquip = self.AuthSelectList[i]
			local dbEquip = dbManager.getInfoEquipment(nEquip.EquipmentId)
			res.setNodeWithEquip(item["icon"], dbEquip, nil, require "RuneInfo".selectByCondition(function ( nRune )
				return nRune.SetIn == nEquip.Id
			end), true)
			item["icon"]:setScale(94/150)
		end
		item["anim"]:stop()
		table.insert(animList, item["anim"])
		item["btn"]:setListener(function ( ... )
			local param = {}
			param.choseType = "ForEquipAuth"
			param.magicBoxSelectList = self.AuthSelectList
			param.magicBoxCallback = function (data)
				print(data)
				self.AuthSelectList = data
				self:updatePageAuth()
			end
			print(param)
			GleeCore:showLayer("DEquipChoseMultiple", param)
		end)
	end

	setAuth["btnAddOneKey"]:setEnabled(#self.AuthSelectList < 4)
	setAuth["btnAddOneKey"]:setListener(function ( ... )
		local list = equipFunc.selectByCondition(function ( v )
			if table.find(self.AuthSelectList, v) then
				return false
			end
			if v.Props and #v.Props > 0 then
				return false
			end
			return dbManager.getInfoEquipment(v.EquipmentId).color >= 3
		end)
		table.sort(list, function ( nEquip1, nEquip2 )
			local dbEquip1 = dbManager.getInfoEquipment(nEquip1.EquipmentId)
			local dbEquip2 = dbManager.getInfoEquipment(nEquip2.EquipmentId)
			if dbEquip1.color == dbEquip2.color then
				if nEquip1.Lv == nEquip2.Lv then
					return nEquip1.Id > nEquip2.Id
				else
					return nEquip1.Lv > nEquip2.Lv
				end
			else
				return dbEquip1.color > dbEquip2.color
			end
		end)

		for i,v in ipairs(list) do
			if #self.AuthSelectList >= 4 then 
				break
			end
			table.insert(self.AuthSelectList, v)
		end
		self:updatePageAuth()
	end)

	local cost = 0
	local costList = dbManager.getInfoDefaultConfig("EqIdentifyCost").Value
	for i,v in ipairs(self.AuthSelectList) do
		local equipColor = dbManager.getInfoEquipment(v.EquipmentId).color
		cost = cost + costList[math.min(math.max(equipColor - 2, 1), #costList)]
	end
	setAuth["layoutCost_v"]:setString(cost)
	local nItem = bagFunc.getItemWithItemId(15)
	if nItem and nItem.Amount >= cost then
		setAuth["layoutCost_v"]:setFontFillColor(ccc4f(0.0,0.0,0.0,1.0), true)
	else
		setAuth["layoutCost_v"]:setFontFillColor(ccc4f(1.0,0.0,0.0,1.0), true)
	end

	setAuth["btnAuth"]:setEnabled(#self.AuthSelectList > 0)
	setAuth["btnAuth"]:setListener(function ( ... )
		local nItem = bagFunc.getItemWithItemId(15)
		if nItem and nItem.Amount >= cost then
			local ids = {}
			table.foreach(self.AuthSelectList,function ( _,v )
				table.insert(ids,v.Id)
			end)

			self:send(netModel.getModelEqIdentify(ids), function ( data )
				if data and data.D then
					res.setTouchDispatchEvents(false)
					for i,v in ipairs(animList) do
						if i <= #self.AuthSelectList then
							v:setLoops(1)
							v:start()
						end
						if i == 1 then
							v:setListener(function ( ... )
								bagFunc.exchangeItem({data.D.Stones})
								equipFunc.addEquipments(data.D.Equipments)
								require "PetInfo".addPets(data.D.Pets)

								self.AuthSelectList = {}
								self:updatePageAuth()

								local param = {}
								param.nEquip = data.D.Equipments[1]
								param.mode = "Mode_Auth"
								param.EquipList = data.D.Equipments
								GleeCore:showLayer("DEquipDetail", param)
							
								res.setTouchDispatchEvents(true)
							end)
						end
					end
				end
			end)
		else
			self:toast(res.locString("Equip$AuthAuthAmountNotEnough"))
		end
	end)

	require "LangAdapter".LabelNodeAutoShrink( setAuth["btnAuth_#text"], 132 )
end

function DMagicBox:updatePageSuccinct( ... )
	local setSuccinct = self.pageList["pageSuccinct"]
	require "LangAdapter".fontSize(setSuccinct["bg2_tip"], nil, nil, 16)

	local clPropList = {}
	local function resetProps( ... )
		for i,propText in ipairs(clPropList) do
			propText["bg"]:setVisible(i == 1)
		end
	end
	local function startProps( endProp, callback )
		local function getPropsAction( index, callback )
			local delay = 0.2
			local actArray = CCArray:create()
			actArray:addObject(CCHide:create())
			actArray:addObject(CCFadeOut:create(0))
			actArray:addObject(CCDelayTime:create(delay * (index - 1)))
			actArray:addObject(CCShow:create())
			actArray:addObject(CCFadeIn:create(delay * 0.5))
			if callback then
				actArray:addObject(CCCallFunc:create(function ( ... )
					callback()
				end))
			else
				actArray:addObject(CCFadeOut:create(delay * 0.5))
				actArray:addObject(CCHide:create())
			end
			return CCSequence:create(actArray)
		end
		for i=1,#clPropList * 2 + endProp do
			if i ~= #clPropList * 2 + endProp then
				clPropList[ (i - 1) % #clPropList + 1]["bg"]:runAction( getPropsAction(i) )
			else
				clPropList[ (i - 1) % #clPropList + 1]["bg"]:runAction( getPropsAction(i, callback) )
			end
		end
	end

	local function updateSuccinctLeftRight( nEquip, idx )
		if nEquip then
			local dbEquip = dbManager.getInfoEquipment(nEquip.EquipmentId)
			res.setNodeWithEquip(setSuccinct[string.format("bg%d_eq_icon", idx)], dbEquip, nil, require "RuneInfo".selectByCondition(function ( nRune )
				return nRune.SetIn == nEquip.Id
			end), true)
			setSuccinct[string.format("bg%d_eq_icon", idx)]:setScale(94/150)

			setSuccinct[string.format("bg%d_eq_name", idx)]:setString(dbEquip.name)
			setSuccinct[string.format("bg%d_eq_name", idx)]:setFontFillColor(res.getEquipRankColor( nEquip.Rank ), true)
		
			local levelMax = Toolkit.getEquipLevelCap(nEquip)
			setSuccinct[string.format("bg%d_eq_layoutLv_v", idx)]:setString(string.format("%d/%d",nEquip.Lv,levelMax))
			setSuccinct[string.format("bg%d_eq_layoutRank_v", idx)]:setString(res.locString(string.format("Equip$Rank%d", nEquip.Rank)))
		else
			setSuccinct[string.format("bg%d_eq_icon", idx)]:removeAllChildrenWithCleanup(true)
			setSuccinct[string.format("bg%d_eq_icon", idx)]:setResid("YJ_tianjia.png")
			setSuccinct[string.format("bg%d_eq_icon", idx)]:setScale(1)
		end
		setSuccinct[string.format("bg%d_eq_name", idx)]:setVisible(nEquip ~= nil)
		setSuccinct[string.format("bg%d_eq_layoutLv", idx)]:setVisible(nEquip ~= nil)
		setSuccinct[string.format("bg%d_eq_layoutRank", idx)]:setVisible(nEquip ~= nil)
		setSuccinct[string.format("bg%d_eq_text", idx)]:setVisible(nEquip == nil)
		res.adjustNodeWidth(setSuccinct[string.format("bg%d_eq_text", idx)], 150)
		setSuccinct[string.format("bg%d_eq_btn", idx)]:setListener(function ( ... )
			if idx == 2 and self.PropEquip1 == nil then
				self:toast(res.locString("Equip$SuccinctTip3"))
				return
			end

			local param = {}
			param.choseType = "ForProp"
			local equipLocation
			if idx == 2 then
				equipLocation = dbManager.getInfoEquipment(self.PropEquip1.EquipmentId).location
			end
			param.selectCondition = function ( v )
				if not v.Props or #v.Props == 0 then
					return false
				end
				if nEquip and v == nEquip then
					return false
				end
				if equipLocation and dbManager.getInfoEquipment(v.EquipmentId).location ~= equipLocation then
					return false
				end
				if idx == 2 and v == self.PropEquip1 then
					return false
				end
				if idx == 2 and equipFunc.getSetInStatus( v ) ~= 3 then
					return false
				end
				
				return true
			end
			param.selectedSortFunc = function ( list )
				table.sort(list, function ( v1, v2 )
					local dbEquip1 = dbManager.getInfoEquipment(v1.EquipmentId)
					local dbEquip2 = dbManager.getInfoEquipment(v2.EquipmentId)
					if dbEquip1.color == dbEquip2.color then
						if v1.Lv == v2.Lv then
							return v1.Id < v2.Id
						else
							return v1.Lv > v2.Lv
						end
					else
						return dbEquip1.color > dbEquip2.color
					end
				end)
			end
			param.updateEquipEvent = function ( nEquipId )
				self[string.format("PropEquip%d", idx)] = equipFunc.getEquipWithId(nEquipId)
				if idx == 1 then
					self.PropIndex = 1

					if self.PropEquip2 then
						local equipLocation1 = dbManager.getInfoEquipment(self.PropEquip1.EquipmentId).location
						local equipLocation2 = dbManager.getInfoEquipment(self.PropEquip2.EquipmentId).location
						if equipLocation1 ~= equipLocation2 or self.PropEquip1.Id == self.PropEquip2.Id then
							self.PropEquip2 = nil
						end
					end
				end
				self:updatePageSuccinct()
			end
			GleeCore:showLayer("DEquipChose", param)
		end)
		setSuccinct[string.format("bg%d_layoutProp", idx)]:removeAllChildrenWithCleanup(true)
		if idx == 1 then
			if nEquip then
				for i=1,6 do
					local tabProp = self:createLuaSet("@tabProp")
					setSuccinct[string.format("bg%d_layoutProp", idx)]:addChild(tabProp[1])
					if nEquip.Props and i <= #nEquip.Props then
						local name, value = Toolkit.getEquipPropText(nEquip.Props[i])
						tabProp["text"]:setString(name .. "+" .. value)
					else
						tabProp["text"]:setString("")
					end
					tabProp[1]:setListener(function ( ... )
						self.PropIndex = i
					end)
					if self.PropIndex == i then
						tabProp[1]:trigger(nil)
					end
				end
			end
		else
			if nEquip and nEquip.Props and #nEquip.Props > 0 then
				clPropList = {}
				for i,v in ipairs(nEquip.Props) do
					local propText = self:createLuaSet("@propText")
					setSuccinct[string.format("bg%d_layoutProp", idx)]:addChild(propText[1])
					local name, value = Toolkit.getEquipPropText(nEquip.Props[i])
					propText["text"]:setString( name .. "+" .. value )
					table.insert(clPropList, propText)
				end
			end
		end
	end

	updateSuccinctLeftRight(self.PropEquip1, 1)
	updateSuccinctLeftRight(self.PropEquip2, 2)
	resetProps()

	local succinctCost, transCost
	if self.PropEquip1 ~= nil and self.PropEquip2 ~= nil then
		setSuccinct["btnSuccinct"]:setEnabled(true)
		setSuccinct["btnTrans"]:setEnabled(true)
		setSuccinct["layoutSuccinctCost"]:setVisible(true)
		setSuccinct["layoutTransCost"]:setVisible(true)

		local equipColor = dbManager.getInfoEquipment(self.PropEquip1.EquipmentId).color
		local costList = dbManager.getInfoDefaultConfig("EqCastCost").Value
		succinctCost = costList[math.min(math.max(equipColor - 2, 1), #costList)]
		setSuccinct["layoutSuccinctCost_v"]:setString(succinctCost)

		transCost = dbManager.getInfoDefaultConfig("EqExchangeCost").Value
		setSuccinct["layoutTransCost_v"]:setString(transCost)
	else
		setSuccinct["btnSuccinct"]:setEnabled(false)
		setSuccinct["btnTrans"]:setEnabled(false)
		setSuccinct["layoutSuccinctCost"]:setVisible(false)
		setSuccinct["layoutTransCost"]:setVisible(false)
	end
	
	self.PropIndex = self.PropIndex or 1
	self.PropIndex2 = self.PropIndex2 or 1

	local itemCount = bagFunc.getItemCount(69)
	setSuccinct["btnSuccinct"]:setListener(function ( ... )
		if itemCount >= succinctCost then
			local function EventRestore( cost )
				if userFunc.getCoin() >= cost then
					self:send(netModel.getModelEqPropRestore(self.PropEquip1.Id), function ( data )
						if data and data.D then
							userFunc.setData(data.D.Role)
							equipFunc.setEquipWithId(data.D.Equipment)
							require "PetInfo".addPets(data.D.Pets)
							self.PropEquip1 = equipFunc.getEquipWithId(self.PropEquip1.Id)
							self.PropEquip2 = nil
							self.PropIndex = 1
							self:updatePageSuccinct()
							self:toast(res.locString("Equip$SuccinctTip5"))
						end
					end)
					return true
				else
					Toolkit.showDialogOnCoinNotEnough()
					return false
				end
			end

			local function EventNetSuccinct( ... )
				self:send(netModel.getModelEqPropRefresh(self.PropEquip1.Id, self.PropIndex, self.PropEquip2.Id), function ( data )
					if data and data.D then
						local function EventSuccinct( ... )
							self.PropEquip1 = equipFunc.getEquipWithId(self.PropEquip1.Id)
							self.PropEquip2 = nil
							self.PropIndex = 1
							self:updatePageSuccinct()
							self:toast(res.locString("Equip$SuccinctTip4"))
						end

						local function EventSuccinctPre( ... )
							if self.PropIndex <= #self.PropEquip1.Props then
								local param = {}
								param.callback = EventSuccinct
								param.callbackRestore = EventRestore
								param.oldProp = self.PropEquip1.Props[self.PropIndex]
								param.newProp = self.PropEquip2.Props[data.D.ChoosedIdx]
								GleeCore:showLayer("DEquipSuccinct", param)
							else
								EventSuccinct()
							end
						end

						equipFunc.removeEquipByID(self.PropEquip2.Id)
						bagFunc.exchangeItem({data.D.Stones})
						require "PetInfo".addPets(data.D.Pets)
						equipFunc.setEquipWithId(data.D.Equipment)
						startProps(data.D.ChoosedIdx, function ( ... )
							EventSuccinctPre()
						end)

						setSuccinct["btnShield"]:setVisible(true)
						setSuccinct["btnShield"]:setListener(function ( ... )
							for i,propText in ipairs(clPropList) do
								propText["bg"]:stopAllActions()
							end
							EventSuccinctPre()
						end)
					end
				end)
			end

			if self.PropEquip2 and dbManager.getInfoEquipment(self.PropEquip2.EquipmentId).color >= 4 then
				local param = {}
				param.content = res.locString("Equip$SuccinctConfirmTip")
				param.callback = function ( ... )
					EventNetSuccinct()
				end
				GleeCore:showLayer("DConfirmNT", param)
			else
				EventNetSuccinct()
			end
		else
			self:toast(res.locString("Bag$MaterialNotEnough"))
		end
	end)

	require "LangAdapter".LabelNodeAutoShrink( setSuccinct["btnTrans_#text"], 108 )
	
	setSuccinct["btnTrans"]:setListener(function ( ... )
		if itemCount >= transCost then
			local function EventNetTrans( ... )
				self:send(netModel.getModelEqPropTransfer(self.PropEquip1.Id, self.PropEquip2.Id), function ( data )
					if data and data.D then
						bagFunc.exchangeItem({data.D.Stones})
						equipFunc.addEquipments(data.D.Equipments)
						require "PetInfo".addPets(data.D.Pets)
						self.PropEquip1 = equipFunc.getEquipWithId(self.PropEquip1.Id)
						self.PropEquip2 = equipFunc.getEquipWithId(self.PropEquip2.Id)
						self.PropIndex = 1
						self:updatePageSuccinct()
						self:toast(res.locString("Equip$TransSucTip"))
					end
				end)
			end

			local param = {}
			param.content = res.locString("Equip$TransConFirmTip")
			param.callback = function ( ... )
				EventNetTrans()
			end
			GleeCore:showLayer("DConfirmNT", param)
		else
			self:toast(res.locString("Bag$MaterialNotEnough"))
		end
	end)

	setSuccinct["btnShield"]:setVisible(false)
end

function DMagicBox:updateRedTip( ... )
	require "EventCenter".eventInput("RedPointEquipCenter")
	local NeData = require "LoginInfo".getData().Ne
	self._BG_tabs_tabEquip_point:setVisible(NeData.Free or NeData.TodayFirst or self:isM23Enough())
end

function DMagicBox:checkColor( list )
	if #list==0 then
		return false
	end
	local color
	for _,v in ipairs(list) do
		local c = dbManager.getInfoEquipment(v.EquipmentId).color
		if color then
			if c~=color then
				return false
			end
		else
			color = c
		end
	end
	return true
end

function DMagicBox:finishAnims( ... )
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
end

function DMagicBox:addBtnListener( ... )
	self._BG_tabs_tabEquip:setListener(function()
		self.tabIndexSelected = 1
		self._BG_equipSynthesis:setVisible(false)
		self._BG_equipBuy:setVisible(true)
		self._BG_equipBase:setVisible(false)
		self:updateEquipView()
	end)

 	self._BG_tabs_tabSynthesis:setListener(function()
 		self.tabIndexSelected = 2
 		self._BG_equipSynthesis:setVisible(true)
 		self._BG_equipBuy:setVisible(false)
 		self._BG_equipBase:setVisible(false)
 		local d = self:getUserData()
 		self:updateView(d and d.AutoFill)
 		require 'GuideHelper':check('tabSynthesis')
 	end)

 	self._BG_tabs_tabAuth_lock:setVisible(not self.EqPropUnLock)
 	self._BG_tabs_tabAuth:setListener(function ( ... )
 		if self.EqPropUnLock then
 			self.tabIndexSelected = 3
 			self._BG_equipSynthesis:setVisible(false)
 			self._BG_equipBuy:setVisible(false)
 			self._BG_equipBase:setVisible(true)
 			self.pageList["pageAuth"][1]:setVisible(true)
 			self.pageList["pageSuccinct"][1]:setVisible(false)
 			self:updatePageAuth()
 		else
 			self:updateTriggle()
 			self:toast(res.locString("Equip$AuthUnLockTip"))
 		end
 	end)

 	local isOpen = require "UnlockManager":isOpen( "Eqjianding" )
 	self._BG_tabs_tabAuth:setVisible( isOpen )
 	self._BG_tabs_tabSuccinct:setVisible( isOpen )

 	self._BG_tabs_tabSuccinct_lock:setVisible(not self.EqPropUnLock)

 	self._BG_tabs_tabSuccinct:setListener(function ( ... )
 		if self.EqPropUnLock then
 			self.tabIndexSelected = 4
  			self._BG_equipSynthesis:setVisible(false)
 			self._BG_equipBuy:setVisible(false)
 			self._BG_equipBase:setVisible(true)
 			self.pageList["pageAuth"][1]:setVisible(false)
 			self.pageList["pageSuccinct"][1]:setVisible(true)	
 			self:updatePageSuccinct()		
 		else
 			self:updateTriggle()
 			self:toast(res.locString("Equip$AuthUnLockTip"))
 		end
 	end)

	self.close = function ( ... )
		self:finishAnims()
		EventCenter.resetGroup("DMagicBox")
	end

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._BG, self)
	end)

	self._BG_topBar_btnHelp:setListener(function (  )
		GleeCore:showLayer("DHelp", {type = "合成装置"})
	end)
	self._BG_topBar_btnReturn:setTriggleSound(res.Sound.back)
	self._BG_topBar_btnReturn:setListener(function (  )
		res.doActionDialogHide(self._BG, self)
	end)

	self._BG_equipSynthesis_screenBtn:setPenetrate(true)
	self._BG_equipSynthesis_screenBtn:setTriggleSound("")
	self._BG_equipSynthesis_screenBtn:setListener(function ( ... )
		if #self.animFinishFuncs>0 then
			self:finishAnims()
			if self.cachedViewUpdateFunc then
				self.cachedViewUpdateFunc()
				self.cachedViewUpdateFunc = nil
			else
				return self:updateView()
			end
		end
	end)

	self._BG_btnHelp:setListener(function ( ... )
		GleeCore:showLayer("DHelp", {type = "装备中心"})
	end)
end

function DMagicBox:updateView( autofill )
	local vip = require "UserInfo".getVipLevel()
	local colorLimit
	-- if vip>=9 then

		colorLimit = dbManager.getInfoDefaultConfig("EqLimit").Value

		-- self._BG_equipSynthesis_main_title1:setString(res.locString("Activity$MagicBoxTitle0"))
	-- else
	-- 	colorLimit = 4
	-- 	self._BG_equipSynthesis_main_title1:setString(res.locString("Activity$MagicBoxTitle1"))
	-- end
	self._BG_equipSynthesis_main_title2:setString(res.locString("Activity$MagicBoxTitle2"))
	self._BG_equipSynthesis_main_title2:setFontFillColor(ccc4f(0.76,0.55,1,0.98),true)

	local curColor
	self.mSelectEquipList = self.mSelectEquipList or {}
	local itemCount
	if self.mEquipPieceEnable then
		itemCount = bagFunc.getItemCount(54)
	end
	for i=1,5 do
		local icon = self[string.format("_BG_equipSynthesis_main_input%d_img",i)]
		if self.mEquipPieceEnable then
			if i<=itemCount then
				res.setItemDetail(icon,bagFunc.getItemByMID(54))
			else
				res.setEquipDetail(icon,nil,true)
			end
		else
			local equip = self.mSelectEquipList[i]
			if equip then
				curColor = curColor or dbManager.getInfoEquipment(equip.EquipmentId).color
			end
			res.setEquipDetail(icon,equip,not equip)
		end
		self[string.format("_BG_equipSynthesis_main_input%d_btn",i)]:setListener(function ( ... )
			-- local param = {}
			-- param.mode = "Mode_Chose"
			-- param.isMagicBox = true
			-- local t = {}
			-- for i,v in ipairs(self.mSelectEquipList) do
			-- 	t[i] = v.Id
			-- end
			-- param.magicSelectList = t
			-- param.magicBoxCallback = function (data)
			-- 	print(data)
			-- 	self.mSelectEquipList = {}
			-- 	for i,v in ipairs(data) do
			-- 		self.mSelectEquipList[i] = equipFunc.getEquipWithId(v)
			-- 	end
			-- 	self:updateView()
			-- end
			-- GleeCore:showLayer("DBag", param)
			local param = {}
			param.choseType = "ForMagicBox"
			param.magicBoxSelectList = self.mSelectEquipList
			param.magicBoxCallback = function (data)
				print(data)
				self.mSelectEquipList = data
				self.mEquipPieceEnable = self.mEquipPieceEnable and #self.mSelectEquipList<=0
				self:updateView()
			end
			print(param)
			GleeCore:showLayer("DEquipChoseMultiple", param)	
		end)
	end
	
	self._BG_equipSynthesis_main_oneKeyInputBtn:setListener(function ( ... )
		if #self.mSelectEquipList>=5 then
			return
		end

		local function getEquipPieceEnable( ... )
			local count = bagFunc.getItemCount(54)
			self.mEquipPieceEnable = count>=5
			return self.mEquipPieceEnable
		end

		local function getEquipEnable( ... )
			local list = equipFunc.selectByCondition(function ( v )
				for _,v in ipairs(v.SetIn) do
					if v>0 then
						return false
					end
				end
				local color = dbManager.getInfoEquipment(v.EquipmentId).color
				if color>=colorLimit or (curColor and color~=curColor) then
					return false
				end
				if table.find(self.mSelectEquipList,v) then
					return false
				end
				return true
			end)

			local ret = {}
			for _,v in ipairs(list) do
				local color = dbManager.getInfoEquipment(v.EquipmentId).color
				ret[color] = ret[color] or {}
				table.insert(ret[color],v)
			end

			local function checkEnable( list )
				if self:checkColor(list) then
					return #list+#self.mSelectEquipList>=5
				elseif #list<5 then
					return false
				else
					for i=1,5 do
						local v = ret[i]
						if v and #v>=5 then
							return true,v
						end
					end
				end
			end
			local b,v = checkEnable(list)
			if b then
				list = v or list
			else
				for i=1,5 do
					if ret[i] then
						list = ret[i]
						break
					end
				end
			end

			equipFunc.sortForMagicBox(list)
			local index = 1
			for i=#self.mSelectEquipList+1,5 do
				if list[index] then
					self.mSelectEquipList[i] = list[index]
					index = index + 1
				else
					break
				end
			end
			return b
		end
		
		local b
		if #self.mSelectEquipList>0 then
			b = getEquipEnable()
		else
			b = getEquipPieceEnable() or getEquipEnable()
			self.mEquipPieceEnable = self.mEquipPieceEnable or (not b and bagFunc.getItemCount(54)>0)
			if self.mEquipPieceEnable then
				self.mSelectEquipList = {}
			end
		end

		self:updateView()
		
		if b then
			require 'GuideHelper':check('onekeyin')
		else
			return self:toast(res.locString("Activity$MagicBoxEmptyInput"))
		end
	end)

	local b = #self.mSelectEquipList>=5 or (self.mEquipPieceEnable and bagFunc.getItemCount(54)>=5)
	self._BG_equipSynthesis_main_open:setVisible(b)

	local goldNeed = 0
	if self.mEquipPieceEnable then
		curColor = 3
	end
	if curColor then
		if vip >=6 and curColor == 3 then
			goldNeed = 300000
		else
			goldNeed = dbManager.getInfoEquipColor(curColor).magicconsume
		end
		if vip >=9 and curColor == 4 then
			goldNeed = 500000
		end
	end
	
	self._BG_equipSynthesis_main_goldNeed_count:setString(goldNeed)
	if require "UserInfo".getGold()<goldNeed then
		self._BG_equipSynthesis_main_goldNeed_count:setFontFillColor(res.color4F.red,true)
		b = false
	end
	
	self._BG_equipSynthesis_main_yaoyiyaoBtn:setEnabled(b)

	if b then
		self._BG_equipSynthesis_main_yaoyiyaoBtn:setListener(function ( ... )
			local function sendMagicBox( ... )
				local ids = {}
				table.foreach(self.mSelectEquipList,function ( _,v )
					table.insert(ids,v.Id)
				end)
				self:send(require "netModel".getmodelEquipMagicBox(table.concat(ids,","),self.mEquipPieceEnable),function ( data )
					print(data)
					require 'GuideHelper':check('EquipMagicBox')
					local newEquips = {}
					for _,v in ipairs(data.D.Resource.Equipments) do
					 	if dbManager.getInfoEquipment(v.EquipmentId).color>curColor then
					 		newEquips[#newEquips+1] = v
					 	end
					 end 

					self.cachedUpdateFunc = function( ... )
						equipFunc.removeEquipByIds(ids)
						self.mSelectEquipList = {}
						if self.mEquipPieceEnable then
							bagFunc.useItem(54,5)
							self.mEquipPieceEnable = false
						end
						--local appFunc = require "AppData"
						AppData.updateResource(data.D.Resource)
						require "EventCenter".eventInput("OnEquipChange")
					end

					self.mIsAnimFinish = false

					local posBox = NodeHelper:getPositionInScreen(self._BG_equipSynthesis_main_box)

					local animSet = self:createLuaSet("@anim")
					self.mAnimSet = animSet
					for _,v in ipairs(newEquips) do
						local equipSet = self:createLuaSet("@equip")
						res.setEquipDetail(equipSet["icon"],v)
						local dbNewEquip = dbManager.getInfoEquipment(v.EquipmentId)
						equipSet["name"]:setString(dbNewEquip.name)
						equipSet["name"]:setFontFillColor(res.getEquipColor(dbNewEquip.color), true)
						animSet["layout"]:addChild(equipSet[1])
					end
					
					animSet["bgAnim"]:setVisible(false)
					animSet[1]:setVisible(false)
					self._BG_equipSynthesis:addChild(animSet[1])

					for i=1,5 do
						self.tickHandle[#self.tickHandle+1] =  require "framework.sync.TimerHelper".tick(function ( ... )
							local lightAnim = self:createLuaSet("@lightAnim")[1]
							lightAnim:setLoops(1)
							local x,y = self[string.format("_BG_equipSynthesis_main_input%d",i)]:getPosition()
							lightAnim:setPosition(x+17,y+2)
							self._BG_equipSynthesis_main_forAnim:addChild(lightAnim)
							lightAnim:setListener(function ( ... )
								local node = ElfNode:create()
								node:setScale(0.6)
								if self.mEquipPieceEnable then
									res.setItemDetail(node,bagFunc.getItemByMID(54))
								else
									res.setEquipDetail(node,self.mSelectEquipList[i])
								end
								res.setEquipDetail(self[string.format("_BG_equipSynthesis_main_input%d_img",i)],nil,true)
								node:setPosition(x,y)
								self._BG_equipSynthesis_main_forAnim:addChild(node)
								local posNode = NodeHelper:getPositionInScreen(node)
								local offset = CCPointMake(posBox.x-posNode.x,posBox.y-posNode.y)
								print(string.format("%d ----- %d",offset.x,offset.y))
								local actArray = CCArray:create()
								actArray:addObject(CCMoveBy:create(0.5,offset))
								actArray:addObject(CCScaleTo:create(0.5,0,0))
								local arr1 = CCArray:create()
								arr1:addObject(CCSpawn:create(actArray))
								if i == 5 then
									arr1:addObject(CCCallFunc:create(function ( ... )
										self._BG_equipSynthesis_main:setVisible(false)
										animSet[1]:setVisible(true)
										local shakeArr = CCArray:create()
										shakeArr:addObject(CCRotateBy:create(0.05,-10))
										shakeArr:addObject(CCRotateBy:create(0.1,20))
										shakeArr:addObject(CCRotateBy:create(0.1,-20))
										shakeArr:addObject(CCDelayTime:create(0.15))
										shakeArr:addObject(CCRotateBy:create(0.1,20))
										shakeArr:addObject(CCRotateBy:create(0.1,-20))
										shakeArr:addObject(CCRotateBy:create(0.1,20))
										shakeArr:addObject(CCRotateBy:create(0.05,-10))

										shakeArr:addObject(CCScaleTo:create(0.15,1,0.6))
										shakeArr:addObject(CCScaleTo:create(0.05,1,1))
										shakeArr:addObject(CCCallFunc:create(function ( ... )
											animSet["bgAnim"]:setVisible(true)
											animSet["bgAnim"]:setLoops(-1)
											animSet["bgAnim"]:start()
											animSet["light"]:setVisible(true)
											local nodeArr = CCArray:create()
											nodeArr:addObject(CCScaleTo:create(0.6,1,1))
											nodeArr:addObject(CCMoveTo:create(0.6,CCPointMake(0,100)))
											local nodeArr2 = CCArray:create()
											nodeArr2:addObject(CCSpawn:create(nodeArr))
											nodeArr2:addObject(CCCallFunc:create(function ( ... )
												self.mIsAnimFinish = true
												self.animFinishFuncs[#self.animFinishFuncs+1] = function ( ... )
													self:reset()
												end
											end))
											animSet["layout"]:runAction(CCSpawn:create(nodeArr2))
										end))
										animSet["box"]:runAction(CCSequence:create(shakeArr))
									end))
								end
								node:runAction(CCSequence:create(arr1))
							end)
							lightAnim:start()
						      return true
						end,0.05*(i-1))
					end
					
					self._BG_equipSynthesis_screenBtn:setPenetrate(false)

					self.animFinishFuncs[#self.animFinishFuncs+1] = function ( ... )
						self._BG_equipSynthesis_main_forAnim:removeAllChildrenWithCleanup(true)
						self._BG_equipSynthesis_main_forAnim:stopAllActions()
						require 'framework.helper.MusicHelper'.stopAllEffects()

						animSet[1]:setVisible(true)
						self._BG_equipSynthesis_main:setVisible(false)
						self._BG_equipSynthesis_screenBtn:setPenetrate(false)
						animSet["box"]:stopAllActions()
						animSet["box"]:setRotation(0)
						animSet["box"]:setScale(1)
						animSet["bgAnim"]:setVisible(true)
						animSet["bgAnim"]:setLoops(-1)
						animSet["bgAnim"]:start()
						animSet["light"]:setVisible(true)
						animSet["layout"]:stopAllActions()
						animSet["layout"]:setScale(1)
						animSet["layout"]:setPosition(0,100)

						if not self.mIsAnimFinish then
							require "framework.sync.TimerHelper".tick(function ( ... )
								self.animFinishFuncs[#self.animFinishFuncs+1] = function ( ... )
									self:reset()
								end
								return true
							end)
						end
					end
					require 'framework.helper.MusicHelper'.playEffect("raw/ui_sfx_composite.mp3")

					return self:updateView()
				end)
			end

			local function step2(  )
				local nEquip
				if self.mNeedCheck then
					local t = {}
					for i,v in ipairs(self.mSelectEquipList) do
						t[i] = equipFunc.getEquipWithId(v.Id)
					end
					self.mSelectEquipList = t
					self.mNeedCheck = false
				end
				for _,v in ipairs(self.mSelectEquipList) do
					if v.Use == 1 then
						nEquip = v
						break
					end
				end
				if nEquip then
					local param = {}
					param.content = res.locString("Activity$MagicBoxToast")
					-- param.LeftBtnText = res.locString("Equip$Rebirth")
					param.callback = function ( ... )
						sendMagicBox()
					end
					-- param.cancelCallback = function ( ... )
					-- 	local unLockManager = require "UnlockManager"
					-- 	if unLockManager:isUnlock("EquipRebirth") then
					-- 		GleeCore:showLayer("DEquipOp", {EquipInfo = nEquip, ViewType = 5, hideLeftTabs = true})
					-- 		self.mNeedCheck = true
					-- 	else
					-- 		self:toast(string.format(res.locString("Home$LevelUnLockTip"), unLockManager:getUnlockLv("EquipRebirth")))
					-- 	end
					-- end
					param.clickClose = true
					GleeCore:showLayer("DConfirmNT",param)
				else
					sendMagicBox()
				end
			end

			local function step1()
				local param = {}
				param.content = res.locString(curColor == 4 and "Activity$MagicBoxToastOnColor4To5" or "Activity$MagicBoxToastOnColor5To6")
				param.callback = function ( ... )
					step2()
				end
				GleeCore:showLayer("DConfirmNT",param)
			end

			if curColor >= 4 then
				step1()
			else
				step2()
			end
		end)
	end

	if autofill then
		require "framework.sync.TimerHelper".tick(function ( ... )
			self._BG_equipSynthesis_main_oneKeyInputBtn:trigger(nil)
			return true
		end)
	end
end

function DMagicBox:reset( ... )
	self.mAnimSet[1]:removeFromParentAndCleanup(true)
	self._BG_equipSynthesis_main:setVisible(true)
	self._BG_equipSynthesis_screenBtn:setPenetrate(true)
	self.mIsAnimFinish = true
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function DMagicBox:isM23Enough( ... )
	local mCount = bagFunc.getItemCount(23)
	local needCount = dbManager.getDeaultConfig("eqcardnum").Value
	-- local needCount = 10
	return mCount>=needCount,mCount,needCount
end

function DMagicBox:onNiudanSuccess( netData )
	print(netData)
	GuideHelper:check('EquipNiudanSuc')
	AppData.updateResource(netData.D.Resource)
	netData.D.Reward.Gold = 0
	GleeCore:showLayer("DGetReward", netData.D.Reward)
	require "LoginInfo".updateNEInfo(netData.D.Ne)
	self:updateRedTip()
end

function DMagicBox:updateEquipView( index )
	if not index or index == 1 then
		local enough,has,need = self:isM23Enough()
		local btntext = self._set:getLabelNode("BG_equipBuy_button_btnNormal_#title")
		require 'LangAdapter'.LabelNodeAutoShrink(btntext,120)
		if has>=need*10 then
			btntext:setString(res.locString("PetAcademy$niudanTen"))
		else
			btntext:setString(res.locString("PetAcademy$niudanonce"))
		end
		self._BG_equipBuy_button_item1_V:setString(string.format("%d/%d",has,need))
		self._BG_equipBuy_button_btnNormal_point:setVisible(enough)
		if enough then
			self._BG_equipBuy_button_item1_V:setFontFillColor(res.color4F.white,true)
		else
			self._BG_equipBuy_button_item1_V:setFontFillColor(ccc4f(0.937255,0.447059,0.125490,1.0),true)
		end
		self._BG_equipBuy_button_btnNormal:setEnabled(enough)
		self._BG_equipBuy_button_btnNormal:setListener(function ( ... )
			if enough then
				self:send(require "netModel".getModelEqNiudan(false,has>=need*10),function ( netData )
					self:onNiudanSuccess(netData)
					self:updateEquipView(1)
				end)
			else
				return self:toast(res.locString("Activity$MagicBoxMNotEnough"))
			end
		end)
	end

	if not index or index == 2 then
		local NeData = require "LoginInfo".getData().Ne
		local firstPrice = dbManager.getDeaultConfig("dailyeqprice").Value
		local normalPrice = dbManager.getDeaultConfig("zhuangbei1coin").Value
		local price = NeData.TodayFirst and firstPrice or normalPrice

		local actData = AppData.getActivityInfo().getDataByType(39)
		if actData and actData.Data then
			local enable ,offset_to = Toolkit.isTimeBetween(actData.Data.HourFrom,actData.Data.MinFrom,actData.Data.HourTo,actData.Data.MinTo)
	      		if enable then
		        		price = 1
		        		self:runWithDelay(function ( ... )
			            	self:updateEquipView(2)
			        end,math.abs(offset_to))
		      	end
		end

		local s = string.format("%d",firstPrice/normalPrice*10)
		selectLang(nil,nil,nil,function (  )
			s = string.format("%d%%",(1-firstPrice/normalPrice)*100)
		end,function (  )
			s = string.format("%d%%",(1-firstPrice/normalPrice)*100)
		end)
		self._BG_equipBuy_button_time:setString(string.format(res.locString("Activity$MagicBoxDayFirstTip"),s))
		require "LangAdapter".LabelNodeAutoShrink(self._BG_equipBuy_button_time,215)

		self._BG_equipBuy_button_item2_price:setString(price)
		if NeData.Free then
			self._BG_equipBuy_button_btnOnce_title:setString(res.locString('PetAcademy$Free'))
		else
			self._BG_equipBuy_button_btnOnce_title:setString(res.locString("PetAcademy$niudanonce"))
			-- local cdseconds = math.abs(require 'Toolkit'.getTimeOffset(0,0))--当天00:00:00
   --    			self._BG_equipBuy_button_time_v:setHourMinuteSecond(0,0,cdseconds)
   --       		self._BG_equipBuy_button_time_v:setUpdateRate(-1)
   --       		self._BG_equipBuy_button_time_v:addListener(function ( ... )
		 --            	NeData.Free = true
		 --            	require "LoginInfo".updateNEInfo(NeData)
		 --            	self:updateEquipView(2)
		 --            	self:updateRedTip()
	  --        	end)
		end

		require 'LangAdapter'.LabelNodeAutoShrink(self._BG_equipBuy_button_btnOnce_title,120)

		self._BG_equipBuy_button_item2:setVisible(not NeData.Free)
		self._BG_equipBuy_button_time:setVisible(not NeData.Free and NeData.TodayFirst)
		self._BG_equipBuy_button_btnOnce_point:setVisible(NeData.Free or NeData.TodayFirst)
		self._BG_equipBuy_button_btnOnce:setListener(function ( ... )
			local func = function ( )
				self:send(require "netModel".getModelEqNiudan(true,false),function ( netData )
					self:onNiudanSuccess(netData)
					self:updateEquipView(2)
				end)
			end

			if NeData.Free then
				return func()
			else
				local coin = require "UserInfo".getCoin()
				if coin<price then
					Toolkit.showDialogOnCoinNotEnough()
				else
					require "Toolkit".useCoinConfirm(func)
				end
			end
		end)
	end

	if not index or index == 3 then
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("BG_equipBuy_button_btnTen_#title"),120)

		local price = dbManager.getDeaultConfig("zhuangbei10coin").Value

		local actData = AppData.getActivityInfo().getDataByType(24)
		if actData then
			local lasttime = -require "TimeListManager".getTimeUpToNow(actData.CloseAt)
			local discount = tostring(math.floor(actData.Data.Discount*100+0.5)/10)
			selectLang(nil,nil,nil,nil,function (  )
				discount = string.format("%d",100-math.floor(actData.Data.Discount*100+0.5))
			end)
			
			self._BG_equipBuy_button_item3tip:setVisible(true)
			self._BG_equipBuy_button_item3tip_title:setString(string.format(res.locString("Activity$MagicBoxTenDiscount"),discount))
			self._BG_equipBuy_button_item3tip_v:setHourMinuteSecond(0,0,lasttime)
			if not self.mCdTimeListener then
				self.mCdTimeListener = ElfDateListener:create(function ( ... )
					self.mCdTimeListener = nil
					self:updateEquipView(3)
				end)
				self.mCdTimeListener:setHourMinuteSecond(0,0,1)
				self._BG_equipBuy_button_item3tip_v:addListener(self.mCdTimeListener)
			end

			price = math.floor(price * actData.Data.Discount)
		else
			self._BG_equipBuy_button_item3tip:setVisible(false)
		end
		
		self._BG_equipBuy_button_item3_price:setString(price)
		self._BG_equipBuy_button_btnTen:setListener(function ( ... )
			local coin = require "UserInfo".getCoin()
			if coin<price then
				Toolkit.showDialogOnCoinNotEnough()
			else
				require "Toolkit".useCoinConfirm(function (  )
					self:send(require "netModel".getModelEqNiudan(true,true),function ( netData )
						self:onNiudanSuccess(netData)
						self:updateEquipView(3)
					end)
				end)
			end
		end)
	end
end


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DMagicBox, "DMagicBox")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DMagicBox", DMagicBox)


