local Config = require "Config"
local LuaList = require "LuaList"
local res = require "Res"
local dbManager = require "DBManager"
local toolkit = require "Toolkit"
local calculateTool = require "CalculateTool"
local gameFunc = require "AppData"
local netModel = require "netModel"

local DMibaoChoseMultiple = class(LuaDialog)

function DMibaoChoseMultiple:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DMibaoChoseMultiple.cocos.zip")
    return self._factory:createDocument("DMibaoChoseMultiple.cocos")
end

--@@@@[[[[
function DMibaoChoseMultiple:onInitXML()
	local set = self._set
    self._root = set:getElfNode("root")
    self._root_bg = set:getElfNode("root_bg")
    self._root_ftpos_tabBg_name = set:getLabelNode("root_ftpos_tabBg_name")
    self._root_ftpos_list = set:getListNode("root_ftpos_list")
    self._icon = set:getElfNode("icon")
    self._layoutProperty = set:getLayoutNode("layoutProperty")
    self._nameBg_name = set:getLabelNode("nameBg_name")
    self._layoutLv = set:getLinearLayoutNode("layoutLv")
    self._layoutLv_value = set:getLabelNode("layoutLv_value")
    self._layoutExp = set:getLinearLayoutNode("layoutExp")
    self._layoutExp_value = set:getLabelNode("layoutExp_value")
    self._layoutAtk = set:getLinearLayoutNode("layoutAtk")
    self._layoutAtk_key = set:getLabelNode("layoutAtk_key")
    self._layoutAtk_value = set:getLabelNode("layoutAtk_value")
    self._layoutAddition = set:getLinearLayoutNode("layoutAddition")
    self._layoutAddition_key = set:getLabelNode("layoutAddition_key")
    self._layoutAddition_value = set:getLabelNode("layoutAddition_value")
    self._addition = set:getLabelNode("addition")
    self._select = set:getElfNode("select")
    self._btnDetail = set:getClickNode("btnDetail")
    self._root_ftpos2_close = set:getButtonNode("root_ftpos2_close")
    self._root_ftpos3_bgMagicBox = set:getJoint9Node("root_ftpos3_bgMagicBox")
    self._root_ftpos3_bgMagicBox_layout = set:getLinearLayoutNode("root_ftpos3_bgMagicBox_layout")
    self._root_ftpos3_bgMagicBox_layout_value = set:getLabelNode("root_ftpos3_bgMagicBox_layout_value")
    self._root_ftpos4_btnOk = set:getClickNode("root_ftpos4_btnOk")
    self._root_ftpos4_btnOk_text = set:getLabelNode("root_ftpos4_btnOk_text")
--    self._@item = set:getElfNode("@item")
--    self._@mbCareer = set:getElfNode("@mbCareer")
--    self._@mbProperty = set:getElfNode("@mbProperty")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DMibaoChoseMultiple:onInit( userData, netData )
	self.mListData = userData.ListData
	self.mLimitCount = userData.LimitCount
	self.mOriginalList = userData.SelectedList
	self.mSelectList = {}
	if userData.SelectedList then
		for i,v in ipairs(userData.SelectedList) do
			table.insert(self.mSelectList, v)
		end
	end
	self.mOnCompleted = userData.OnCompleted

	self:setListenerEvent()
	self:updateLayer(true)

	res.doActionDialogShow(self._root)

	require "LangAdapter".LabelNodeAutoShrink(self._root_ftpos_tabBg_name, 110)
	require "LangAdapter".LabelNodeAutoShrink(self._root_ftpos4_btnOk_text, 106)
end

function DMibaoChoseMultiple:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DMibaoChoseMultiple:setListenerEvent( ... )
	self._root_ftpos2_close:setListener(function ( ... )
		self.mSelectList = self.mOriginalList
		self._root_ftpos_list:stopAllActions()
		res.doActionDialogHide(self._root, self)
	end)

	self._root_ftpos4_btnOk:setListener(function ( ... )
		if self.mOnCompleted then
			self.mOnCompleted(self.mSelectList)
		end
		self._root_ftpos_list:stopAllActions()
		res.doActionDialogHide(self._root, self)
	end)
end

function DMibaoChoseMultiple:updateLayer( refresh )
	local winSize = CCDirector:sharedDirector():getWinSize()
	self._root_bg:setScaleX(winSize.width / self._root_bg:getWidth())
		
	self._root_ftpos_list:setContentSize(CCSize(winSize.width, self._root_ftpos_list:getHeight()))
	self:updateList(refresh)
	self:updateSelectCount()
end

function DMibaoChoseMultiple:updateList( refresh )
	if not self.mList then
		self.mList = LuaList.new(self._root_ftpos_list, function ( ... )
			return self:createLuaSet("@item")
		end, function ( nodeLuaSet, data, listIndex )
			self:updateCell(nodeLuaSet, data)
		end)
	end
	self.mList:update(self.mListData, refresh or false)
end

function DMibaoChoseMultiple:updateCell( nodeLuaSet, nTreasure )
	res.setNodeWithTreasure(nodeLuaSet["icon"],nTreasure)
	nodeLuaSet["nameBg_name"]:setString(require "Toolkit".getMibaoName(nTreasure))

	local dbTreasure = dbManager.getInfoTreasure(nTreasure.MibaoId)
	
	nodeLuaSet["layoutExp"]:setVisible(dbTreasure.Type == 3)
	nodeLuaSet["layoutLv"]:setVisible(dbTreasure.Type ~= 3)
	nodeLuaSet["layoutAtk"]:setVisible(dbTreasure.Type ~= 3)
	nodeLuaSet["layoutAddition"]:setVisible(dbTreasure.Type ~= 3)
	nodeLuaSet["addition"]:setVisible(dbTreasure.Type ~= 3 and nTreasure.Addition > 0)

	-- local setInInfo = toolkit.getMibaoSetInInfo(nTreasure)
	-- nodeLuaSet["layoutName"]:setVisible(setInInfo.text ~= nil)
	-- if setInInfo.text then
	-- 	nodeLuaSet["layoutName_name"]:setString( setInInfo.text )
	-- end

	nodeLuaSet["layoutExp_value"]:setString(dbTreasure.Effect)
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
					propertyString = propertyString .. res.locString(string.format("PetCC$_Prop%d", v))
				end
			end
		end
		nodeLuaSet["layoutAtk_key"]:setString(res.locString("Global$Atk"))
		nodeLuaSet["layoutAtk_value"]:setString(string.format("+%g%%", nTreasure.Effect * 100))

		nodeLuaSet["layoutAddition_key"]:setString( string.format(res.locString("Bag$TreasureAddition"), res.locString("Global$Atk")) )
		if nTreasure.Addition > 0 then
			nodeLuaSet["layoutAddition_value"]:setString( string.format("+%g%%", nTreasure.Addition * 100))
			nodeLuaSet["addition"]:setString(string.format(res.locString("Bag$TreasureAdditionTip"), propertyString))
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
					careerString = careerString .. res.locString(string.format("Bag$Treasure%d", v))
				end
			end
		end
		nodeLuaSet["layoutAtk_key"]:setString(res.locString("Global$Hp"))
		nodeLuaSet["layoutAtk_value"]:setString(string.format("+%g%%", nTreasure.Effect * 100))

		nodeLuaSet["layoutAddition_key"]:setString( string.format(res.locString("Bag$TreasureAddition"), res.locString("Global$Hp")) )
		if nTreasure.Addition > 0 then
			nodeLuaSet["layoutAddition_value"]:setString( string.format("+%g%%", nTreasure.Addition * 100))
			nodeLuaSet["addition"]:setString(string.format(res.locString("Bag$TreasureAdditionTip"), careerString))
		else
			nodeLuaSet["layoutAddition_value"]:setString( res.locString("Bag$TreasureAdditionNo") )
		end
	end	

	local isSelected = toolkit.containMibaoMaterial(self.mSelectList, nTreasure)

	nodeLuaSet["select"]:setVisible(isSelected)
	nodeLuaSet["btnDetail"]:setListener(function ( ... )
		if isSelected then
			isSelected = false
			self:onUnCheck(nTreasure)
		else
			if #self.mSelectList >= self.mLimitCount then
				self:toast(res.locString("Mibao$MultiChooseCountLimitTip"))
				return
			else
				isSelected = true
				self:onCheck(nTreasure)
			end
		end
		nodeLuaSet["select"]:setVisible(isSelected)
	end)
end

function DMibaoChoseMultiple:isInSelectedList( v )
	return table.find(self.mSelectList, v)
end

function DMibaoChoseMultiple:onCheck( v )
	table.insert(self.mSelectList,v)
	self:updateSelectCount()
end

function DMibaoChoseMultiple:onUnCheck( v )
	 for i = #self.mSelectList, 1, -1 do
	 	local vv = self.mSelectList[i]
        if vv.Id == v.Id and vv._materialIndex == v._materialIndex then
            table.remove(self.mSelectList, i)
        end
    end
	self:updateSelectCount()
end

function DMibaoChoseMultiple:updateSelectCount( ... )
	self._root_ftpos3_bgMagicBox_layout_value:setString(string.format("%d/%d",#self.mSelectList,self.mLimitCount))
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DMibaoChoseMultiple, "DMibaoChoseMultiple")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DMibaoChoseMultiple", DMibaoChoseMultiple)
