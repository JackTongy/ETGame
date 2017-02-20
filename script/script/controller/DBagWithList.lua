local Config = require "Config"
local res = require "Res"
local gameFunc = require "AppData"
local equipFunc = gameFunc.getEquipInfo()
local bagFunc = gameFunc.getBagInfo()
local gemFunc = gameFunc.getGemInfo()
local mibaoFunc = gameFunc.getMibaoInfo()
local runeFunc = gameFunc.getRuneInfo()
local LuaList = require "LuaList"
local dbManager = require "DBManager"
local netModel = require "netModel"
local toolkit = require "Toolkit"
local calculateTool = require "CalculateTool"
local eventCenter = require 'EventCenter'
local GuideHelper = require 'GuideHelper'


local tabList = {["TabMaterial"] = 1, ["TabEquip"] = 2, ["TabGem"] = 3, ["TabTreasure"] = 4, ["TabRune"] = 5, ["TabCount"] = 5}
local gemCountPage = 50

local DBagWithList = class(LuaDialog)

function DBagWithList:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DBagWithList.cocos.zip")
    return self._factory:createDocument("DBagWithList.cocos")
end

--@@@@[[[[
function DBagWithList:onInitXML()
	local set = self._set
    self._root = set:getElfNode("root")
    self._root_bg = set:getElfNode("root_bg")
    self._root_ftpos_layoutTab = set:getLayoutNode("root_ftpos_layoutTab")
    self._root_ftpos_layoutTab_tab1 = set:getTabNode("root_ftpos_layoutTab_tab1")
    self._root_ftpos_layoutTab_tab1_title = set:getLabelNode("root_ftpos_layoutTab_tab1_title")
    self._root_ftpos_layoutTab_tab2 = set:getTabNode("root_ftpos_layoutTab_tab2")
    self._root_ftpos_layoutTab_tab2_title = set:getLabelNode("root_ftpos_layoutTab_tab2_title")
    self._root_ftpos_layoutTab_tab3 = set:getTabNode("root_ftpos_layoutTab_tab3")
    self._root_ftpos_layoutTab_tab3_title = set:getLabelNode("root_ftpos_layoutTab_tab3_title")
    self._root_ftpos_layoutTab_tab4 = set:getTabNode("root_ftpos_layoutTab_tab4")
    self._root_ftpos_layoutTab_tab4_title = set:getLabelNode("root_ftpos_layoutTab_tab4_title")
    self._root_ftpos_layoutTab_tab5 = set:getTabNode("root_ftpos_layoutTab_tab5")
    self._root_ftpos_layoutTab_tab5_title = set:getLabelNode("root_ftpos_layoutTab_tab5_title")
    self._title = set:getLabelNode("title")
    self._root_ftpos_pageList = set:getElfNode("root_ftpos_pageList")
    self._btnDetail = set:getButtonNode("btnDetail")
    self._icon = set:getElfNode("icon")
    self._career = set:getElfNode("career")
    self._nameBg_name = set:getLabelNode("nameBg_name")
    self._layoutRank_value = set:getLabelNode("layoutRank_value")
    self._layoutLv_value = set:getLabelNode("layoutLv_value")
    self._layoutProy = set:getLayoutNode("layoutProy")
    self._key = set:getLabelNode("key")
    self._value = set:getLabelNode("value")
    self._layoutName = set:getLinearLayoutNode("layoutName")
    self._layoutName_name = set:getLabelNode("layoutName_name")
    self._btnImprove = set:getClickNode("btnImprove")
    self._btnImprove_text = set:getLabelNode("btnImprove_text")
    self._btnDetail = set:getButtonNode("btnDetail")
    self._icon = set:getElfNode("icon")
    self._layoutTime = set:getLinearLayoutNode("layoutTime")
    self._layoutTime_time = set:getTimeNode("layoutTime_time")
    self._nameBg_name = set:getLabelNode("nameBg_name")
    self._layoutProy = set:getLayoutNode("layoutProy")
    self._key = set:getLabelNode("key")
    self._value = set:getLabelNode("value")
    self._key = set:getLabelNode("key")
    self._value = set:getLabelNode("value")
    self._layoutName = set:getLinearLayoutNode("layoutName")
    self._layoutName_name = set:getLabelNode("layoutName_name")
    self._btnUpgrade = set:getClickNode("btnUpgrade")
    self._btnUpgrade_text = set:getLabelNode("btnUpgrade_text")
    self._btnDetail = set:getButtonNode("btnDetail")
    self._icon = set:getElfNode("icon")
    self._nameBg_name = set:getLabelNode("nameBg_name")
    self._count = set:getLabelNode("count")
    self._des = set:getRichLabelNode("des")
    self._btnSale = set:getClickNode("btnSale")
    self._btnSale_text = set:getLabelNode("btnSale_text")
    self._btnUse = set:getClickNode("btnUse")
    self._btnUse_text = set:getLabelNode("btnUse_text")
    self._btnUse_point = set:getElfNode("btnUse_point")
    self._btnEggHatch = set:getClickNode("btnEggHatch")
    self._btnEggHatch_text = set:getLabelNode("btnEggHatch_text")
    self._layoutTime = set:getLinearLayoutNode("layoutTime")
    self._layoutTime_time = set:getTimeNode("layoutTime_time")
    self._btnDetail = set:getButtonNode("btnDetail")
    self._icon = set:getElfNode("icon")
    self._layoutProperty = set:getLayoutNode("layoutProperty")
    self._nameBg_name = set:getLabelNode("nameBg_name")
    self._layoutLv = set:getLinearLayoutNode("layoutLv")
    self._layoutLv_value = set:getLabelNode("layoutLv_value")
    self._layoutExp = set:getLinearLayoutNode("layoutExp")
    self._layoutExp_value = set:getLabelNode("layoutExp_value")
    self._layoutAmt = set:getLinearLayoutNode("layoutAmt")
    self._layoutAmt_value = set:getLabelNode("layoutAmt_value")
    self._layoutAtk = set:getLinearLayoutNode("layoutAtk")
    self._layoutAtk_key = set:getLabelNode("layoutAtk_key")
    self._layoutAtk_value = set:getLabelNode("layoutAtk_value")
    self._layoutAddition = set:getLinearLayoutNode("layoutAddition")
    self._layoutAddition_key = set:getLabelNode("layoutAddition_key")
    self._layoutAddition_value = set:getLabelNode("layoutAddition_value")
    self._addition = set:getLabelNode("addition")
    self._layoutName = set:getLinearLayoutNode("layoutName")
    self._layoutName_name = set:getLabelNode("layoutName_name")
    self._btnImprove = set:getClickNode("btnImprove")
    self._btnImprove_text = set:getLabelNode("btnImprove_text")
    self._btnDetail = set:getButtonNode("btnDetail")
    self._icon = set:getElfNode("icon")
    self._nameBg_name = set:getLabelNode("nameBg_name")
    self._layoutProxCtn = set:getLinearLayoutNode("layoutProxCtn")
    self._layoutProxCtn_key = set:getLabelNode("layoutProxCtn_key")
    self._layoutProxCtn_value = set:getLabelNode("layoutProxCtn_value")
    self._layoutName = set:getLinearLayoutNode("layoutName")
    self._layoutName_name = set:getLabelNode("layoutName_name")
    self._btnImprove = set:getClickNode("btnImprove")
    self._btnImprove_text = set:getLabelNode("btnImprove_text")
    self._root_ftpos2_close = set:getButtonNode("root_ftpos2_close")
    self._root_ftpos2_btnEquipSell = set:getButtonNode("root_ftpos2_btnEquipSell")
    self._root_ftpos2_btnTreasurePiece = set:getButtonNode("root_ftpos2_btnTreasurePiece")
    self._root_ftpos4_GemPage = set:getElfNode("root_ftpos4_GemPage")
    self._root_ftpos4_GemPage_btnExit = set:getButtonNode("root_ftpos4_GemPage_btnExit")
    self._root_ftpos4_GemPage_bg = set:getJoint9Node("root_ftpos4_GemPage_bg")
    self._root_ftpos4_GemPage_bg_arrow = set:getElfNode("root_ftpos4_GemPage_bg_arrow")
    self._root_ftpos4_GemPage_list = set:getListNode("root_ftpos4_GemPage_list")
    self._isSelected = set:getElfNode("isSelected")
    self._num = set:getLabelNode("num")
    self._root_ftpos4_GemPage_btnGemPage = set:getClickNode("root_ftpos4_GemPage_btnGemPage")
    self._root_ftpos4_GemPage_btnGemPage_num = set:getLabelNode("root_ftpos4_GemPage_btnGemPage_num")
    self._root_ftpos4_GemPage_btnGemPage_arrow = set:getElfNode("root_ftpos4_GemPage_btnGemPage_arrow")
    self._root_ftpos4_tabLayoutGem = set:getLayoutNode("root_ftpos4_tabLayoutGem")
    self._title = set:getLabelNode("title")
    self._root_ftpos4_tabLayoutRune = set:getLayoutNode("root_ftpos4_tabLayoutRune")
    self._title = set:getLabelNode("title")
--    self._@dyTab = set:getTabNode("@dyTab")
--    self._@equipList = set:getListNode("@equipList")
--    self._@sizeEquip = set:getElfNode("@sizeEquip")
--    self._@layoutProx = set:getLinearLayoutNode("@layoutProx")
--    self._@gemList = set:getListNode("@gemList")
--    self._@sizeGem = set:getElfNode("@sizeGem")
--    self._@layoutProxCtn = set:getLinearLayoutNode("@layoutProxCtn")
--    self._@layoutProxCtn = set:getLinearLayoutNode("@layoutProxCtn")
--    self._@materialList = set:getListNode("@materialList")
--    self._@sizeMaterial = set:getElfNode("@sizeMaterial")
--    self._@treasureList = set:getListNode("@treasureList")
--    self._@sizeTreasure = set:getElfNode("@sizeTreasure")
--    self._@mbCareer = set:getElfNode("@mbCareer")
--    self._@mbProperty = set:getElfNode("@mbProperty")
--    self._@runeList = set:getListNode("@runeList")
--    self._@sizeRune = set:getElfNode("@sizeRune")
--    self._@btnPageGem = set:getClickNode("@btnPageGem")
--    self._@tabGem = set:getTabNode("@tabGem")
--    self._@tabRune = set:getTabNode("@tabRune")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DBagWithList:onInit( userData, netData )
	res.doActionDialogShow(self._root, function ( ... )
		self:guideNotify()
	end)
	
	self.gemType = 0
	self.gemPage = 1
	self.runeType = 0
	self.tabIndexSelected = userData and userData.tabIndexSelected or tabList.TabMaterial
	self:initPageArray()
	self:setListenerEvent()
	self:broadcastEvent()
	self:updatePages(true)
end

function DBagWithList:onBack( userData, netData )
	self:runWithDelay(function ( ... )
		self:updatePages()
	end, 0.2)
end

function DBagWithList:close(  )
	eventCenter.resetGroup("DBagWithList")
	GuideHelper:check('DBagBack')
end

--------------------------------custom code-----------------------------
function DBagWithList:guideNotify( ... )
	-- GuideHelper:registerPoint('装备选择',self.detailPageList[tabList.TabEquip]["btnChose"])

	if self.tabList[tabList.TabEquip] then
		GuideHelper:registerPoint('装备tab',self.tabList[tabList.TabEquip][1])
	end
	if self.tabList[tabList.TabGem] then
		GuideHelper:registerPoint('宝石tab',self.tabList[tabList.TabGem][1])
	end
	if self.tabList[tabList.TabTreasure] then
		GuideHelper:registerPoint('秘宝tab',self.tabList[tabList.TabTreasure][1])
	end
	GuideHelper:registerPoint('关闭',self._root_ftpos2_close)
	GuideHelper:check('DBag')
end

function DBagWithList:broadcastEvent(  )
	eventCenter.addEventFunc("OnAppStatChange", function ( state )
		if state == 2 then
			self:updatePages()
		end
	end, "DBagWithList")

	eventCenter.addEventFunc("OnEquipmentUpdate", function (  )
		self:updatePages()
	end, "DBagWithList")

	eventCenter.addEventFunc("OnGemUpdate", function ( nGem )
		if nGem then
			self:resetGemPage(nGem)
		end
		self:updatePages()
	end, "DBagWithList")

	eventCenter.addEventFunc("OnRuneUpdate", function (  )
		self:updatePages()
	end, "DBagWithList")
end

function DBagWithList:initPageArray( ... )
	local dyList = {
		[tabList.TabMaterial] = "@materialList",
		[tabList.TabEquip] = "@equipList", 
		[tabList.TabGem] = "@gemList", 
		[tabList.TabTreasure] = "@treasureList",
		[tabList.TabRune] = "@runeList",
	}
	self.pageList = {}
	for i,v in ipairs(dyList) do
		local set = self:createLuaSet(v)
		self._root_ftpos_pageList:addChild(set[1])
		set[1]:setVisible(false)
		table.insert(self.pageList, set)
	end
end

function DBagWithList:setListenerEvent(  )
	self.tabList = {}
	local nameList = {"Bag$TabTitleMaterial", "Bag$TabTitleEquip", "Bag$TabTitleGem", "Bag$TabTitleTreasure", "Bag$TabTitleRune"}
	self._root_ftpos_layoutTab:removeAllChildrenWithCleanup(true)
	for i=1,tabList.TabCount do
		local visible = true
		if i == tabList.TabTreasure then
			visible = self:isTreasureVisible()
		elseif i == tabList.TabGem then
			visible = self:isGemVisible()
		elseif i == tabList.TabRune then
			visible = self:isRuneVisible()
		end

		if visible then
			local tab = self:createLuaSet("@dyTab")
			self._root_ftpos_layoutTab:addChild(tab[1])
			tab["title"]:setString( res.locString(nameList[i]) )
			require 'LangAdapter'.fontSize(tab["title"],nil,nil,nil,nil,24,nil,nil,nil,nil,18)

			tab[1]:setListener(function ( ... )
				if self.tabIndexSelected ~= i then
					self.tabIndexSelected = i
					self:updatePages(true)

					for k,v in pairs(tabList) do
						if v == i then
							GuideHelper:check(k)
						end
					end
				end
			end)

			table.insert(self.tabList, i, tab)
		end
	end

	self._root_ftpos2_close:setListener(function ( ... )
		self.pageList[self.tabIndexSelected][1]:stopAllActions()
		res.doActionDialogHide(self._root, self)
	end)

	self._root_ftpos2_btnEquipSell:setListener(function ( ... )
		GleeCore:showLayer("DEquipChoseMultiple", {choseType = "ForSell"})
	end)

	self._root_ftpos2_btnTreasurePiece:setListener(function ( ... )
		GleeCore:showLayer("DTreasure")
	end)

	self._root_ftpos4_GemPage_btnExit:setListener(function ( ... )
		self:updateGemList(false)
	end)

	self._root_ftpos4_GemPage_btnGemPage:setListener(function ( ... )
		self._root_ftpos4_GemPage_btnGemPage:setVisible(false)
		self._root_ftpos4_GemPage_bg:setVisible(true)
		self._root_ftpos4_GemPage_list:setVisible(true)
		self._root_ftpos4_GemPage_btnExit:setVisible(true)

		local totalPage = self:getGemTotalPage()
		self._root_ftpos4_GemPage_list:getContainer():removeAllChildrenWithCleanup(true)
		local btnPageGemWidth, btnPageGemheight
		for i=1,totalPage do
			local btnPageGem = self:createLuaSet("@btnPageGem")
			self._root_ftpos4_GemPage_list:getContainer():addChild(btnPageGem[1])
			btnPageGem["isSelected"]:setVisible(i == self.gemPage)
			btnPageGem["num"]:setString(string.format("%d/%d", i, totalPage))
			btnPageGem[1]:setListener(function ( ... )
				local refresh = self.gemPage ~= i
				self.gemPage = i
				self:updateGemList(refresh)
			end)
			if not btnPageGemWidth then
				btnPageGemWidth = btnPageGem[1]:getWidth()
				btnPageGemheight = btnPageGem[1]:getHeight()
			end
		end
		self._root_ftpos4_GemPage_list:layout()
		if totalPage <= 7 then
			self._root_ftpos4_GemPage_list:setContentSize(CCSize(btnPageGemWidth, btnPageGemheight * totalPage))
			self._root_ftpos4_GemPage_bg:setContentSize(CCSize(btnPageGemWidth, btnPageGemheight * totalPage + 16))
		else
			self._root_ftpos4_GemPage_list:setContentSize(CCSize(btnPageGemWidth, btnPageGemheight * 7 + 30))
			self._root_ftpos4_GemPage_bg:setContentSize(CCSize(btnPageGemWidth, btnPageGemheight * 7 + 30 + 16))
		end
		self._root_ftpos4_GemPage_bg_arrow:setPosition(ccp(0, -self._root_ftpos4_GemPage_bg:getHeight() / 2 - 13))
	end)

	res.adjustNodeWidth( self._set:getLabelNode("root_ftpos2_btnEquipSell_#title"), 112)
end

function DBagWithList:updatePages( refresh )
	local winSize = CCDirector:sharedDirector():getWinSize()
	self._root_bg:setScaleX(winSize.width / self._root_bg:getWidth())
	for i,v in ipairs(self.pageList) do
		v[1]:setVisible(i == self.tabIndexSelected)
		v[1]:setContentSize(CCSize(winSize.width, v[1]:getHeight()))
	end

	self.tabList[self.tabIndexSelected][1]:trigger(nil)
	if self.tabIndexSelected == tabList.TabMaterial then
		self:updateMaterialList(refresh)
	elseif self.tabIndexSelected == tabList.TabEquip then
		self:updateEquipmentList(refresh)
	elseif self.tabIndexSelected == tabList.TabGem then
		self:updateGemList(refresh)
	elseif self.tabIndexSelected == tabList.TabTreasure then
		self:updateTreasureList(refresh)
	elseif self.tabIndexSelected == tabList.TabRune then
		self:updateRuneList(refresh)
	end

	self:updateTabNameColor()

	self._root_ftpos2_btnEquipSell:setVisible(self.tabIndexSelected == tabList.TabEquip)
	self._root_ftpos4_tabLayoutGem:setVisible(self.tabIndexSelected == tabList.TabGem)
	self._root_ftpos2_btnTreasurePiece:setVisible(self.tabIndexSelected == tabList.TabTreasure)
	self._root_ftpos4_tabLayoutRune:setVisible(self.tabIndexSelected == tabList.TabRune)
	self._root_ftpos4_GemPage:setVisible(self.tabIndexSelected == tabList.TabGem)
end

function DBagWithList:updateTabNameColor(  )
	for k,v in pairs(self.tabList) do
		local titleNode = v["title"]
		if self.tabIndexSelected == k then
			titleNode:setFontFillColor(res.tabColor2.selectedTextColor, true)
			titleNode:enableStroke(res.tabColor2.selectedStrokeColor, 2, true)
		else
			titleNode:setFontFillColor(ccc4f(0.611765,0.333333,0.619608,1.0), true)
			titleNode:enableStroke(ccc4f(0.0,0.0,0.0,0.5), 2, true)
		end		
	end
end

function DBagWithList:updateEquipmentList( refresh )
	self._firstEquip = self._firstEquip
	if not self.equipList then
		self.equipList = LuaList.new(self.pageList[tabList.TabEquip][1], function (  )
			return self:createLuaSet("@sizeEquip")
		end, function ( nodeLuaSet, data, listIndex )
			local nEquip = data
			local dbEquip = dbManager.getInfoEquipment(nEquip.EquipmentId)

			nodeLuaSet["btnDetail"]:setListener(function ( ... )
				local param = {}
				param.nEquip = nEquip
				param.mode = "Mode_Improve"
			--	param.EquipList = self:getEquipListData()
				GleeCore:showLayer("DEquipDetail", param)
			end)

			res.setNodeWithEquip(nodeLuaSet["icon"], dbEquip, nil, require "RuneInfo".selectByCondition(function ( nRune )
				return nRune.SetIn == nEquip.Id
			end), true)
			nodeLuaSet["career"]:setVisible(dbEquip.career > 0)
			if dbEquip.career > 0 then
				nodeLuaSet["career"]:setResid(res.getPetCareerIcon(dbEquip.career))
			end
			local name = dbEquip.name
			if nEquip.Tp and nEquip.Tp>0 then
				name = name.."+"..nEquip.Tp
			end	
			nodeLuaSet["nameBg_name"]:setString(name)
			require 'LangAdapter'.selectLang(nil, nil, function ( ... )
				nodeLuaSet["nameBg_name"]:setFontSize(18)
			end, nil, function ( ... )
				nodeLuaSet["nameBg_name"]:setFontSize(20)
				nodeLuaSet["layoutRank_#key"]:setFontSize(20)
				nodeLuaSet["layoutRank_value"]:setFontSize(20)
			end, nil, function ( ... )
				nodeLuaSet["nameBg_name"]:setFontSize(18)
			end)
			res.adjustNodeWidth( nodeLuaSet["nameBg_name"], 112 )

			nodeLuaSet["layoutRank_value"]:setString(res.getEquipRankText(nEquip.Rank))
			nodeLuaSet["layoutLv_value"]:setString(string.format("%d/%d", nEquip.Lv, toolkit.getEquipLevelCap(nEquip)))
		
			nodeLuaSet["layoutProy"]:removeAllChildrenWithCleanup(true)
			local proList = toolkit.getEquipProList(nEquip)
			if proList then
				for i,pro in ipairs(proList) do
					local set = self:createLuaSet("@layoutProx")
					nodeLuaSet["layoutProy"]:addChild(set[1])
					set["key"]:setString(toolkit.getEquipProName(pro))
					set["value"]:setString(calculateTool.getEquipProDataStrByEquipInfo(nEquip, pro))
				end
			end
		
			toolkit.setEquipSetInLabel(nil, nEquip, function ( ret )
				if ret then
					nodeLuaSet["layoutName"]:setVisible(true)
					nodeLuaSet["layoutName_name"]:setString(ret)
				else
					nodeLuaSet["layoutName"]:setVisible(false)
				end
			end)
		
			nodeLuaSet["btnImprove"]:setListener(function ( ... )
				GleeCore:showLayer("DEquipOp", {EquipInfo = nEquip, EquipList = self:getEquipListData()})
			end)
			self._firstEquip = self._firstEquip or nodeLuaSet['btnImprove']

			require 'LangAdapter'.selectLang(nil, nil, function ( ... )
				nodeLuaSet["btnImprove_text"]:setFontSize(24)
			end, nil, nil, nil, nil, function ( ... )
				nodeLuaSet["btnImprove_text"]:setFontSize(20)
			end, nil, function ( ... )
				res.adjustNodeWidth( nodeLuaSet["btnImprove_text"], 92 )
				nodeLuaSet["#layoutRank"]:layout()
				res.adjustNodeWidth( nodeLuaSet["#layoutRank"], 134 )
			end)
		end)
	end
	local list = self:getEquipListData()
	if refresh and #list > 138 then
		local param = {}
		param.content = res.locString("Bag$EquipSoManyTip")
		param.RightBtnText = res.locString("Global$Sale")
		param.callback = function ( ... )
			GleeCore:showLayer("DEquipChoseMultiple", {choseType = "ForSell"})
		end
		GleeCore:showLayer("DConfirmNT", param)
	end
	self.equipList:update(list, refresh or false)
	
	GuideHelper:registerPoint('强化',self._firstEquip)
	GuideHelper:registerPoint('强化1',self._firstEquip)
end

function DBagWithList:updateGemList( refresh )
	self._firstGem = nil
	if not self.gemList then
		self.gemList = LuaList.new(self.pageList[tabList.TabGem][1], function (  )
			return self:createLuaSet("@sizeGem")
		end, function ( nodeLuaSet, data, listIndex )
			local nGem = data
			local dbGem = dbManager.getInfoGem(nGem.GemId)
			nodeLuaSet["btnDetail"]:setListener(function ( ... )
				GleeCore:showLayer("DGemDetail",{GemInfo = nGem})
			end)
			res.setNodeWithGem(nodeLuaSet["icon"], nGem.GemId, nGem.Lv)
			nodeLuaSet["nameBg_name"]:setString(string.format("%sLv.%d", dbGem.name, nGem.Lv))
			require 'LangAdapter'.selectLang(nil, nil, function ( ... )
				nodeLuaSet["nameBg_name"]:setFontSize(18)
			end, nil, nil, nil, nil, function ( ... )
				nodeLuaSet["nameBg_name"]:setFontSize(17)
			end, nil, function ( ... )
				require 'LangAdapter'.LabelNodeAutoShrink(nodeLuaSet["nameBg_name"], 138)
			end)
			local nPet = gameFunc.getPetInfo().getPetWithId(nGem.SetIn)
			local dbPet = nPet and dbManager.getCharactor(nPet.PetId) or nil
			nodeLuaSet["layoutName"]:setVisible(dbPet ~= nil)
			if dbPet then
				nodeLuaSet["layoutName_name"]:setString(dbPet.name)
			end

			nodeLuaSet["btnUpgrade"]:setEnabled(nGem.Lv < 7) -- 宝石7级满级
			nodeLuaSet["btnUpgrade"]:setListener(function ( ... )
				if require "UnlockManager":isUnlock("GemFuben") then
					GleeCore:showLayer("DGemLevelUp", nGem)
				else
					self:toast( string.format(res.locString("Bag$GemUnLock"), require "UnlockManager":getUnlockLv("GemFuben") ) )
				end
			end)
			self._firstGem = self._firstGem or nodeLuaSet['btnUpgrade']
			if nGem.Lv < 7 then
				nodeLuaSet["btnUpgrade_text"]:setString(res.locString("Gem$LevelUp"))
			else
				nodeLuaSet["btnUpgrade_text"]:setString(res.locString("Global$LevelCap"))
			end

			nodeLuaSet["layoutProy"]:removeAllChildrenWithCleanup(true)	

			local desList = string.split(dbGem.description, ",")
			if desList then
				for i,des in ipairs(desList) do
					local temp = string.split(des, "|")
					local canFind, pos = string.find(temp[2],"%%")
					local value = dbGem[string.format("effect%d", i)][nGem.Lv]
					if canFind then
						value = value * 100
					end

					local set = self:createLuaSet("@layoutProxCtn")
					nodeLuaSet["layoutProy"]:addChild(set[1])

					set["key"]:setString(temp[1])
					set["value"]:setString(string.gsub(temp[2],"{$}", value))

					set[1]:layout()
					local w = set[1]:getWidth()
					if w > 155 then
						set[1]:setScale(155/w)
					end
				end
			end

			if nGem.Seconds > 0 then
				local lastTime = nGem.Seconds - math.floor(require "TimeListManager".getTimeUpToNow(nGem.CreateAt))
				if lastTime > 0 then
					nodeLuaSet["layoutTime"]:setVisible(true)
					nodeLuaSet["layoutTime_time"]:getElfDate():setHourMinuteSecond(require "TimeListManager".getTimeInfoBySeconds(lastTime))
					nodeLuaSet["layoutTime_time"]:setUpdateRate(-1)
					nodeLuaSet["layoutTime_time"]:addListener(function (  )
						nodeLuaSet["layoutTime_time"]:setUpdateRate(0)
						gemFunc.removeGemList({[1] = nGem.Id})
						self:updatePages()
					end)
				else
					nodeLuaSet["layoutTime"]:setVisible(false)
				end
			else
				nodeLuaSet["layoutTime"]:setVisible(false)
			end

			require 'LangAdapter'.selectLang(nil, nil, function ( ... )
				nodeLuaSet["btnUpgrade_text"]:setFontSize(24)
			end,nil,nil,nil,nil,nil,nil,function ( ... )
				nodeLuaSet["btnUpgrade_text"]:setFontSize(22)
			end)
		end)
	end

	self.gemList:update(self:getGemListData(), refresh or false)
	GuideHelper:registerPoint('升级',self._firstGem)

	self:updateGemLayout()
	self:updateGemPage()
end

function DBagWithList:getGemTypeList( ... )
	local temp = {}
	table.insert(temp, 0)
	for k,v in pairs(gemFunc.getGemAll()) do
		local gem = dbManager.getInfoGem(v.GemId)
		if gem and not table.find(temp, gem.type) then
			table.insert(temp, gem.type)
		end
	end
	table.sort(temp, function ( v1, v2 )
		return v1 < v2
	end)


	return temp
end

function DBagWithList:updateGemLayout( ... )
	if self.tabIndexSelected == tabList.TabGem then
		self._root_ftpos4_tabLayoutGem:removeAllChildrenWithCleanup(true)
		self.gemLayoutSet = {}
		for i,v in ipairs(self:getGemTypeList()) do
			local tabGem = self:createLuaSet("@tabGem")
			self._root_ftpos4_tabLayoutGem:addChild(tabGem[1])
			tabGem["title"]:setString(res.locString(string.format("Gem$Effect%d", v)))
			require 'LangAdapter'.selectLang(nil, nil, function ( ... )
				tabGem["title"]:setFontSize(20)
			end, nil, function ( ... )
				tabGem["title"]:setFontSize(20)
			end)

			tabGem[1]:setListener(function ( ... )
				if self.gemType ~= v then
					self.gemPage = 1
					self.gemType = v
					self:updatePages(true)
				end
			end)
			self.gemLayoutSet[v] = tabGem
		end
		if not self.gemLayoutSet[self.gemType] then
			self.gemType = 0
		end
		self.gemLayoutSet[self.gemType][1]:trigger(nil)
	end
end

function DBagWithList:updateGemPage( ... )
	self._root_ftpos4_GemPage_btnGemPage:setVisible(true)
	local totalPage = self:getGemTotalPage()
	self._root_ftpos4_GemPage_btnGemPage_num:setString(string.format("%d/%d", self.gemPage, math.max(totalPage, self.gemPage)))
	self._root_ftpos4_GemPage_btnGemPage:setEnabled(totalPage > 1)
	self._root_ftpos4_GemPage_btnGemPage_arrow:setVisible(totalPage > 1)
	self._root_ftpos4_GemPage_bg:setVisible(false)
	self._root_ftpos4_GemPage_list:setVisible(false)
	self._root_ftpos4_GemPage_btnExit:setVisible(false)
end

function DBagWithList:getGemTotalPage( ... )
	local itemListData = self:getGemsOrigal()
	return math.floor( (#itemListData - 1) / gemCountPage) + 1
end

function DBagWithList:updateMaterialList( refresh )
	if not self.materialList then
		self.materialList = LuaList.new(self.pageList[tabList.TabMaterial][1], function (  )
			return self:createLuaSet("@sizeMaterial")
		end, function ( nodeLuaSet, data, listIndex )
			local nData = data
			if nData.EndAt then	-- 精灵蛋
				nodeLuaSet["btnEggHatch"]:setVisible(true)
				nodeLuaSet["btnEggHatch"]:setListener(function ( ... )
					if math.floor(require "TimeListManager".getTimeUpToNow(nData.EndAt)) > 0 then
						self:send(netModel.getModelPackHatch(), function ( data )
							if data and data.D then
								gameFunc.updateResource(data.D.Resource)
								gameFunc.getPetInfo().addPets(data.D.Pets)
								bagFunc.useEgg()

								self:updatePages(false)
							--	res.doActionGetReward(data.D.Reward)
								GleeCore:showLayer('DPetAcademyEffectV2',{pets={data.D.Resource.Pets[1]} })
								eventCenter.eventInput("UpdatePetEgg")
							end
						end)
					else
						self:toast(res.locString("Egg$HatchSucTip"))
					end
				end)

				require 'LangAdapter'.selectLang(nil, nil, function ( ... )
					nodeLuaSet["btnEggHatch_text"]:setFontSize(24)
				end)
				res.setNodeWithEgg(nodeLuaSet["icon"], nData)
				nodeLuaSet["nameBg_name"]:setString(res.locString("Bag$PetEggJuniorTitle"))
				nodeLuaSet["des"]:setString(string.format(res.locString("Bag$DesFormat"), res.locString("Bag$PetEggDes")))

				nodeLuaSet["count"]:setString("1")
				nodeLuaSet["btnUse"]:setVisible(false)
				nodeLuaSet["btnSale"]:setVisible(false)

				local lastTime = - math.floor(require "TimeListManager".getTimeUpToNow(nData.EndAt))
				if lastTime > 0 then
					nodeLuaSet["layoutTime"]:setVisible(true)
					nodeLuaSet["layoutTime_time"]:getElfDate():setHourMinuteSecond(require "TimeListManager".getTimeInfoBySeconds(lastTime))
					nodeLuaSet["layoutTime_time"]:setUpdateRate(-1)
					nodeLuaSet["layoutTime_time"]:addListener(function (  )
						nodeLuaSet["layoutTime_time"]:setUpdateRate(0)
						self:updatePages()
					end)
				else
					nodeLuaSet["layoutTime"]:setVisible(false)
				end
			elseif nData.Reward then -- 运营礼包
				nodeLuaSet["layoutTime"]:setVisible(false)
				nodeLuaSet["btnEggHatch"]:setVisible(false)
				nodeLuaSet["btnDetail"]:setVisible(false)
				res.setNodeWithPack(nodeLuaSet["icon"])
				nodeLuaSet["nameBg_name"]:setString(nData.Name)
				nodeLuaSet["count"]:setString(nData.Amount)
				nodeLuaSet["btnUse_point"]:setVisible(false)
				nodeLuaSet["btnUse"]:setVisible(true)
				nodeLuaSet["btnUse"]:setListener(function ( ... )
					self:send(netModel.getModelUsePack(nData.Id), function ( data )
						print("UsePack")
						print(data)
						if data and data.D then
							gameFunc.updateResource(data.D.Resource)
							bagFunc.usePack(nData.Id)

							self:updatePages(false)
							res.doActionGetReward(data.D.Reward)
						end
					end)
				end)
				nodeLuaSet["btnSale"]:setVisible(false)
				nodeLuaSet["des"]:setString(string.format(res.locString("Bag$DesFormat"), nData.Des))

				require 'LangAdapter'.selectLang(nil, nil, function ( ... )
					nodeLuaSet["btnUse_text"]:setFontSize(24)
				end)
			else -- 普通道具
				local dbMaterial = dbManager.getInfoMaterial(nData.MaterialId)
				if dbMaterial then
					nodeLuaSet["layoutTime"]:setVisible(false)
					nodeLuaSet["btnEggHatch"]:setVisible(false)
					nodeLuaSet["btnDetail"]:setListener(function ( ... )
						GleeCore:showLayer("DMaterialDetail", {materialId = nData.MaterialId})
					end)
					res.setNodeWithMaterial(nodeLuaSet["icon"], dbMaterial)
					nodeLuaSet["nameBg_name"]:setString(dbMaterial.name)
					require 'LangAdapter'.selectLang(nil, nil, function ( ... )
						nodeLuaSet["nameBg_name"]:setFontSize(18)
					end, function ( ... )
						nodeLuaSet["nameBg_name"]:setFontSize(18)
					end, function ( ... )
						nodeLuaSet["nameBg_name"]:setFontSize(18)
					end,nil,nil,nil,nil,function ( ... )
						if dbMaterial.materialid >= 200 and dbMaterial.materialid <= 1000 then
							nodeLuaSet["nameBg_name"]:setScale(0.7)
						else
							res.adjustNodeWidth( nodeLuaSet["nameBg_name"], 112 )
						end
					end)

					nodeLuaSet["count"]:setString(nData.Amount)
					nodeLuaSet["des"]:setString(string.format(res.locString("Bag$DesFormat"), dbMaterial.describe or ""))

					local function useMaterial( ... )
						if bagFunc.isItemOutOfDate(nData) then
							self:toast(res.locString("Bag$MaterialIsOutOfDate"))
							self:updatePages(false)
						else
							local canUse, errMsg, gotoMall = bagFunc.isItemCanUse(nData.Id)
							if canUse then
								self:send(netModel.getModelPackUse(nData.Id), function ( data )
									print("PackUse Data:")
									print(data)
									if data and data.D then
										bagFunc.useItemByID(nData.Id)
										gameFunc.updateResource(data.D.Resource)

										self:updatePages(false)
										res.doActionGetReward(data.D.Reward)
									end
								end)
							else
								if gotoMall then
									if nData.MaterialId == 127 or nData.MaterialId == 128 then
										local dbTarget = dbManager.getInfoMaterial(dbMaterial.consume)
										self:toast(string.format(res.locString("Activity$PlaygroundUseMaterialNotEnough"), dbTarget.name))
									else
										local param = {}
										param.content = gotoMall
										param.RightBtnText = res.locString("Global$Goto")
										param.callback = function ( ... )
											GleeCore:showLayer("DMall")
										end
										GleeCore:showLayer("DConfirmNT", param)									
									end
								elseif errMsg then
									self:toast(errMsg)
								end
							end
						end
					end

					nodeLuaSet["btnUse_point"]:setVisible(dbMaterial.red_point > 0 and bagFunc.isItemCanUse(nData.Id))
					nodeLuaSet["btnUse"]:setVisible(dbMaterial.enable ~= 0)
					local isUseEnable = dbMaterial.enable ~= 0
					if dbMaterial.materialid == 22 then
						isUseEnable = bagFunc.getItemCount(dbMaterial.materialid) >= 10
					elseif dbMaterial.materialid == 23 then
						isUseEnable = bagFunc.getItemCount(dbMaterial.materialid) >= dbManager.getDeaultConfig("eqcardnum").Value
					elseif dbMaterial.materialid == 54 then
						isUseEnable = bagFunc.getItemCount(dbMaterial.materialid) >= 5
					end
					nodeLuaSet["btnUse"]:setEnabled(isUseEnable)
					nodeLuaSet["btnUse"]:setListener(function ( ... )
						if dbMaterial.tenenable and dbMaterial.tenenable > 0 then
							local useCount = bagFunc.getItemCount(dbMaterial.materialid)
							if dbMaterial.consume > 0 then
								local count2 = bagFunc.getItemCount(dbMaterial.consume)
								useCount = math.min(useCount, count2)
							end

							if useCount >= 10 then
								useCount = 10
							end

							if useCount <= 1 then
								useMaterial()
							else
								local param = {}
								param.content = res.locString("Bag$UseBox10Tip")
								param.RightBtnText = res.locString(string.format("Bag$UseCount%d", useCount))
								param.LeftBtnText = res.locString("Bag$UseCount1")
								param.callback = function ( ... )
									if bagFunc.isItemOutOfDate(nData) then
										self:toast(res.locString("Bag$MaterialIsOutOfDate"))
										self:updatePages(false)
									else
										local canUse, errMsg, gotoMall = bagFunc.isItemCanUse(nData.Id, useCount)
										if canUse then
											self:send(netModel.getModelBoxOpen10(nData.Id), function ( data )
												print("BoxOpen10 Data:")
												print(data)
												if data and data.D then
													print("useCount = " .. useCount)
													bagFunc.useItemByID(nData.Id, useCount)
													gameFunc.updateResource(data.D.Resource)
													self:updatePages(false)

													if data.D.Rewards then
														res.doActionGetReward({rewardType = "List", rewardList = data.D.Rewards})
													end	
												end
											end)
										else
											if gotoMall then
												if nData.MaterialId == 127 or nData.MaterialId == 128 then
													local dbTarget = dbManager.getInfoMaterial(dbMaterial.consume)
													self:toast(string.format(res.locString("Activity$PlaygroundUseMaterialNotEnough"), dbTarget.name))
												else
													local param = {}
													param.content = gotoMall
													param.RightBtnText = res.locString("Global$Goto")
													param.callback = function ( ... )
														GleeCore:showLayer("DMall")
													end
													GleeCore:showLayer("DConfirmNT", param)
												end
											elseif errMsg then
												self:toast(errMsg)
											end
										end
									end
								end
								param.cancelCallback = function ( ... )
									useMaterial()
								end
								param.clickClose = true
								GleeCore:showLayer("DConfirmNT", param)
							end
						elseif dbMaterial.materialid == 22 then	-- 扭蛋卡
							GleeCore:showLayer("DPetAcademyV2")
						elseif dbMaterial.materialid == 23 then	-- 装备卡
							GleeCore:showLayer("DMagicBox")
						elseif dbMaterial.materialid == 54 then	-- 橙装碎片
							GleeCore:showLayer("DMagicBox", {ShowIndex = 2, AutoFill = true})
						else
							useMaterial()
						end
					end)

					require "LangAdapter".LabelNodeAutoShrink(nodeLuaSet["btnSale_text"], 108)
					nodeLuaSet["btnSale"]:setVisible(dbMaterial.CanSell > 0)
					nodeLuaSet["btnSale"]:setListener(function ( ... )
						local param = {}
						param.itemType = "MaterialSale"
						param.itemId = dbMaterial.materialid
						param.callback = function ( ... )
							self:updatePages()
						end
						GleeCore:showLayer("DMallItemBuy", param)
					end)

					require 'LangAdapter'.selectLang(nil, nil, function ( ... )
						nodeLuaSet["btnUse_text"]:setFontSize(24)
						nodeLuaSet["btnSale_text"]:setFontSize(24)
					end)
				end
			end

			nodeLuaSet["btnDetail"]:setVisible(false) --屏蔽道具详情
		end)
	end

	self.materialList:update(self:getMaterialListData(), refresh or false)
end

function DBagWithList:getEquipListData( ... )
	local itemListData = equipFunc.getEquipListWithLocation(0)
	equipFunc.sortNormal(itemListData)
	return itemListData
end

function DBagWithList:getMaterialListData( ... )
	local itemListData = {}
	if bagFunc.getEgg() then
		table.insert(itemListData, bagFunc.getEgg())
	end

	for i,v in ipairs(bagFunc.getItems()) do
		if v.Amount > 0 then
			table.insert(itemListData, v)
		end
	end
	-- for i,v in ipairs(bagFunc.getPackList()) do
	-- 	if v.Amount > 0 then
	-- 		table.insert(itemListData, v)
	-- 	end
	-- end
	return itemListData
end

function DBagWithList:getGemsOrigal( ... )
	-- if self.nGemListData then
	-- 	return self.nGemListData
	-- end
	local itemListData = gemFunc.getGemWithType(self.gemType)
	table.sort(itemListData,function ( a,b )
		if a.Seconds>0 and b.Seconds>0 then
			local lastA = a.Seconds - math.floor(require "TimeListManager".getTimeUpToNow(a.CreateAt))
			local lastB = b.Seconds - math.floor(require "TimeListManager".getTimeUpToNow(b.CreateAt))
			return lastA<lastB
		elseif a.Seconds>0 then
			return true
		elseif b.Seconds>0 then
			return false
		else
			local aMosaic = a.SetIn > 0
			local bMosaic = b.SetIn > 0
			if aMosaic == bMosaic then
				local aLv,bLv = a.Lv,b.Lv
				if aLv == bLv then
					if a.GemId == b.GemId then
						return a.Id < b.Id
					else
						return a.GemId < b.GemId
					end
				else
					return aLv > bLv
				end
			else
				return aMosaic
			end
		end
	end)
	-- self.nGemListData = itemListData
	return itemListData
end

function DBagWithList:getGemListData( ... )
	local itemListData = self:getGemsOrigal()
	local arg={ unpack(itemListData, gemCountPage * (self.gemPage - 1) + 1, math.min(gemCountPage * (self.gemPage - 1) + gemCountPage, #itemListData) ) }
	local list = {}
	for i,v in ipairs(arg) do
		table.insert(list, v)
	end
	return list
end

function DBagWithList:resetGemPage( nGem )
	local itemListData = self:getGemsOrigal()
	for i,v in ipairs(itemListData) do
		if v.Id == nGem.Id then
			self.gemPage = math.floor((i - 1) / gemCountPage) + 1
			break
		end
	end
end

function DBagWithList:updateTreasureList( refresh )
	if not self.treasureList then
		self.treasureList =  LuaList.new(self.pageList[tabList.TabTreasure][1], function ( ... )
			return self:createLuaSet("@sizeTreasure")
		end, function ( nodeLuaSet, nTreasure, listIndex )
			local dbTreasure = dbManager.getInfoTreasure(nTreasure.MibaoId)
			if dbTreasure then
				res.setNodeWithTreasure(nodeLuaSet["icon"], nTreasure)
				nodeLuaSet["nameBg_name"]:setString(require "Toolkit".getMibaoName(nTreasure))
				require 'LangAdapter'.fontSize(nodeLuaSet["nameBg_name"],nil,nil,nil,nil,18)

				nodeLuaSet["layoutExp"]:setVisible(dbTreasure.Type == 3)
				nodeLuaSet["layoutAmt"]:setVisible(dbTreasure.Type == 3)
				nodeLuaSet["layoutLv"]:setVisible(dbTreasure.Type ~= 3)
				nodeLuaSet["layoutAtk"]:setVisible(dbTreasure.Type ~= 3)
				nodeLuaSet["layoutAddition"]:setVisible(dbTreasure.Type ~= 3)
				nodeLuaSet["addition"]:setVisible(dbTreasure.Type ~= 3 and nTreasure.Addition > 0)

				local putOnText = toolkit.getMibaoSetInInfo(nTreasure).text
				nodeLuaSet["layoutName"]:setVisible(putOnText ~= nil)
				if putOnText then
					nodeLuaSet["layoutName_name"]:setString( putOnText )
				end

				nodeLuaSet["btnImprove"]:setVisible(dbTreasure.Type ~= 3)
				nodeLuaSet["layoutExp_value"]:setString(dbTreasure.Effect)
				nodeLuaSet["layoutAmt_value"]:setString(nTreasure.Amount)
				nodeLuaSet["layoutLv_value"]:setString(string.format("%d/%d", nTreasure.Lv, dbManager.getInfoMibaoLvLimit( dbTreasure.Star )))
				nodeLuaSet["layoutProperty"]:removeAllChildrenWithCleanup(true)
				if dbTreasure.Type == 1 then
					local propertyString = ""
					if dbTreasure.Property then
						for i,v in ipairs(dbTreasure.Property) do
							if v > 0 then
								local mbProperty = self:createLuaSet("@mbProperty")
								nodeLuaSet["layoutProperty"]:addChild(mbProperty[1])
								mbProperty[1]:setResid( res.getPetPropertyIcon( v, true ) )
								propertyString = propertyString .. res.locString(string.format("PetCC$_Prop%d", v)) .. " "
							end
						end
					end
					nodeLuaSet["layoutAtk_key"]:setString(res.locString("Global$Atk"))
					nodeLuaSet["layoutAtk_value"]:setString(string.format("+%g%%", nTreasure.Effect * 100))
		
					nodeLuaSet["layoutAddition_key"]:setString( string.format(res.locString("Bag$TreasureAddition"), res.locString("Global$Atk")) )
					if nTreasure.Addition > 0 then
						nodeLuaSet["layoutAddition_value"]:setString( string.format("+%g%%", nTreasure.Addition * 100))
						nodeLuaSet["addition"]:setString(string.format(res.locString("Bag$TreasureAdditionTip"), propertyString))
						require 'LangAdapter'.fontSize(nodeLuaSet["addition"],nil,nil,18,nil,nil,nil,nil,18)
					else
						nodeLuaSet["layoutAddition_value"]:setString( res.locString("Bag$TreasureAdditionNo") )
					end
				elseif dbTreasure.Type == 2 then
					local careerString = ""
					if dbTreasure.Property then
						for i,v in ipairs(dbTreasure.Property) do
							if v > 0 then
								local mbCareer = self:createLuaSet("@mbCareer")
								nodeLuaSet["layoutProperty"]:addChild(mbCareer[1])
								mbCareer[1]:setResid( res.getPetCareerIcon( v ) )
								careerString = careerString .. res.locString(string.format("Bag$Treasure%d", v)) .. " "
							end
						end
					end
					nodeLuaSet["layoutAtk_key"]:setString(res.locString("Global$Hp"))
					nodeLuaSet["layoutAtk_value"]:setString(string.format("+%g%%", nTreasure.Effect * 100))

					nodeLuaSet["layoutAddition_key"]:setString( string.format(res.locString("Bag$TreasureAddition"), res.locString("Global$Hp")) )
					if nTreasure.Addition > 0 then
						nodeLuaSet["layoutAddition_value"]:setString( string.format("+%g%%", nTreasure.Addition * 100))
						nodeLuaSet["addition"]:setString(string.format(res.locString("Bag$TreasureAdditionTip"), careerString))
						require 'LangAdapter'.fontSize(nodeLuaSet["addition"],nil,nil,18,nil,nil,nil,nil,18)
					else
						nodeLuaSet["layoutAddition_value"]:setString( res.locString("Bag$TreasureAdditionNo") )
					end
				end	
				nodeLuaSet["btnImprove"]:setListener(function ( ... )
					if require "UnlockManager":isUnlock("Mibao") then
						local list = self:getTreasureListData()
						local result = {}
						for i,v in ipairs(list) do
							if v.Type ~= 3 then
								table.insert(result, v)
							end
						end
						GleeCore:showLayer("DMibaoOp", {Info = nTreasure, List = result})
					else
						self:toast( string.format(res.locString("Home$LevelUnLockTip"), require "UnlockManager":getUnlockLv("Mibao") ) )
					end
				end)
				nodeLuaSet["btnDetail"]:setListener(function ( ... )
					GleeCore:showLayer("DMibaoDetail", {Data = nTreasure,NeedImprove = true})
				end)

				require 'LangAdapter'.selectLang(nil, nil, function ( ... )
					nodeLuaSet["btnImprove_text"]:setFontSize(24)
					nodeLuaSet["nameBg_name"]:setFontSize(18)
				end, nil, nil, nil, nil, function ( ... )
					nodeLuaSet["btnImprove_text"]:setFontSize(20)
				end, nil, function ( ... )
					nodeLuaSet["btnImprove_text"]:setFontSize(20)
					nodeLuaSet["addition"]:setFontSize(16)
				end)
			end
		end)
	end
	self.treasureList:update(self:getTreasureListData(), refresh or false)
end

function DBagWithList:getTreasureListData( ... )
	local list = mibaoFunc.getMibaoList()
	table.sort(list, function ( v1, v2 )
		if (v1.Type == 3 and v2.Type == 3) or (v1.Type ~= 3 and v2.Type ~= 3) then
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
		else
			return v1.Type ~= 3
		end
	end)
	return list
end

function DBagWithList:isTreasureVisible( ... )
	local list = mibaoFunc.getMibaoList()
	return require "UnlockManager":isOpen( "Mibao" ) and ((list and #list > 0) or require "UnlockManager":isUnlock("Mibao"))
end

function DBagWithList:isGemVisible( ... )
	local list = gemFunc.getGemAll()
	return (list and #list > 0) or require "UnlockManager":isUnlock("GemFuben")
end

function DBagWithList:isRuneVisible( ... )
	local list = runeFunc.getRuneList()
	return require "UnlockManager":isOpen( "Rune" ) and ((list and #list > 0) or require "UnlockManager":isUnlock("GuildCopyLv"))
end

function DBagWithList:updateRuneList( refresh )
	if not self.runeList then
		self.runeList = LuaList.new(self.pageList[tabList.TabRune][1], function (  )
			return self:createLuaSet("@sizeRune")
		end, function ( nodeLuaSet, nRune, listIndex )
			local dbRune = dbManager.getInfoRune(nRune.RuneId)
			nodeLuaSet["btnDetail"]:setListener(function ( ... )
				GleeCore:showLayer("DRuneDetail",{RuneData = nRune})
			end)
			res.setNodeWithRune(nodeLuaSet["icon"], nRune.RuneId, nRune.Star, nRune.Lv)
			if nRune.Lv > 0 then
				nodeLuaSet["nameBg_name"]:setString(string.format("%s+%d", dbRune.Name, nRune.Lv))
			else
				nodeLuaSet["nameBg_name"]:setString(dbRune.Name)
			end
		
			nodeLuaSet["layoutProxCtn_key"]:setString( res.locString(string.format("Rune$RuneType%d", dbRune.Location)) )
			nodeLuaSet["layoutProxCtn_value"]:setString( calculateTool.getRuneBaseProValue(nRune) )

			nodeLuaSet["layoutName"]:setVisible(nRune.SetIn > 0)
			if nRune.SetIn > 0 then
				nodeLuaSet["layoutName_name"]:setString(toolkit.getEquipNameById(nRune.SetIn))
			end

			nodeLuaSet["btnImprove"]:setListener(function ( ... )
				if require "UnlockManager":isUnlock("GuildCopyLv") then
					GleeCore:showLayer("DRuneOp", {RuneData = nRune})
				else
					self:toast( string.format(res.locString("Bag$RuneUnLock"), require "UnlockManager":getUnlockLv("GuildCopyLv") ) )
				end
			end)
			require 'LangAdapter'.fontSize(nodeLuaSet["btnImprove_text"],nil,nil,nil,nil,nil,nil,nil,20,nil,20)
		end)
	end
	self.runeList:update(self:getRuneListData(), refresh or false)
	self:updateRuneLayout()
end

function DBagWithList:updateRuneLayout( ... )
	if self.tabIndexSelected == tabList.TabRune then
		self._root_ftpos4_tabLayoutRune:removeAllChildrenWithCleanup(true)
		self.runeLayoutSet = {}
		for i,v in ipairs(self:getRuneTypeList()) do
			local tabRune = self:createLuaSet("@tabRune")
			self._root_ftpos4_tabLayoutRune:addChild(tabRune[1])
			tabRune["title"]:setString(res.locString(string.format("Rune$TabEffect%d", v)))
			require 'LangAdapter'.selectLang(nil, nil, nil, nil, nil, nil, nil, function ( ... )
				tabRune["title"]:setFontSize(20)
			end)

			tabRune[1]:setListener(function ( ... )
				if self.runeType ~= v then
					self.runeType = v
					self:updatePages(true)
				end
			end)
			self.runeLayoutSet[v] = tabRune
		end
		if not self.runeLayoutSet[self.runeType] then
			self.runeType = 0
		end
		self.runeLayoutSet[self.runeType][1]:trigger(nil)
	end
end

function DBagWithList:getRuneListData( ... )
	local itemListData = runeFunc.getRuneWithType(self.runeType) or {}
	table.sort(itemListData,function ( a,b )
		local aIn = a.SetIn > 0
		local bIn = b.SetIn > 0
		if aIn == bIn then
			if a.Star == b.Star then
				if a.Lv == b.Lv then
					local dbRune1 = dbManager.getInfoRune(a.RuneId)
					local dbRune2 = dbManager.getInfoRune(b.RuneId)
					if dbRune1.Location == dbRune2.Location then
						return a.Id < b.Id
					else
						return dbRune1.Location < dbRune2.Location
					end
				else
					return a.Lv > b.Lv
				end
			else
				return a.Star > b.Star
			end
		else
			return aIn
		end
	end)
	return itemListData
end

function DBagWithList:getRuneTypeList( ... )
	local temp = {}
	table.insert(temp, 0)
	for k,v in pairs(runeFunc.getRuneList()) do
		local dbRune = dbManager.getInfoRune(v.RuneId)
		if dbRune and not table.find(temp, dbRune.Location) then
			table.insert(temp, dbRune.Location)
		end
	end
	table.sort(temp, function ( v1, v2 )
		return v1 < v2
	end)
	return temp
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DBagWithList, "DBagWithList")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DBagWithList", DBagWithList)


