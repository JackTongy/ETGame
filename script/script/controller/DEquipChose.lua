local Config = require "Config"
local LuaList = require "LuaList"
local res = require "Res"
local dbManager = require "DBManager"
local toolkit = require "Toolkit"
local calculateTool = require "CalculateTool"
local gameFunc = require "AppData"
local equipFunc = gameFunc.getEquipInfo()
local GuideHelper = require 'GuideHelper'
local DEquipChose = class(LuaDialog)

function DEquipChose:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DEquipChose.cocos.zip")
    return self._factory:createDocument("DEquipChose.cocos")
end

--@@@@[[[[
function DEquipChose:onInitXML()
	local set = self._set
    self._root = set:getElfNode("root")
    self._root_bg = set:getElfNode("root_bg")
    self._root_ftpos_tabBg = set:getElfNode("root_ftpos_tabBg")
    self._root_ftpos_tabBg_icon = set:getElfNode("root_ftpos_tabBg_icon")
    self._root_ftpos_tabBg_name = set:getLabelNode("root_ftpos_tabBg_name")
    self._root_ftpos_tabBg2 = set:getElfNode("root_ftpos_tabBg2")
    self._root_ftpos_tabBg2_name = set:getLabelNode("root_ftpos_tabBg2_name")
    self._root_ftpos_layoutList = set:getLinearLayoutNode("root_ftpos_layoutList")
    self._root_ftpos_layoutList_list = set:getListNode("root_ftpos_layoutList_list")
    self._bg2 = set:getElfNode("bg2")
    self._btnDetail = set:getButtonNode("btnDetail")
    self._icon = set:getElfNode("icon")
    self._career = set:getElfNode("career")
    self._isEquiped = set:getElfNode("isEquiped")
    self._nameBg_name = set:getLabelNode("nameBg_name")
    self._layoutRank_value = set:getLabelNode("layoutRank_value")
    self._layoutLv_value = set:getLabelNode("layoutLv_value")
    self._layoutProy = set:getLayoutNode("layoutProy")
    self._key = set:getLabelNode("key")
    self._value = set:getLabelNode("value")
    self._layoutName = set:getLinearLayoutNode("layoutName")
    self._layoutName_name = set:getLabelNode("layoutName_name")
    self._btnOk = set:getClickNode("btnOk")
    self._btnOk_text = set:getLabelNode("btnOk_text")
    self._btnImprove = set:getClickNode("btnImprove")
    self._select = set:getElfNode("select")
    self._root_ftpos2_close = set:getButtonNode("root_ftpos2_close")
--    self._@size = set:getElfNode("@size")
--    self._@layoutProx = set:getLinearLayoutNode("@layoutProx")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DEquipChose:onInit( userData, netData )
	self.choseType = userData.choseType
	self.nEquip = userData.nEquip
	self.equipLocation = userData.equipLocation
	self.updateEquipEvent = userData.updateEquipEvent
	self.selectCondition = userData.selectCondition
	self.selectedSortFunc = userData.selectedSortFunc

	self:setListenerEvent()
	self:updateLayer()
	res.doActionDialogShow(self._root,function ( ... )
		GuideHelper:registerPoint('强化',self._guideBtnImprove)
		GuideHelper:check('DEquipChose')
	end)
end

function DEquipChose:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DEquipChose:setListenerEvent(  )
	self._root_ftpos2_close:setListener(function ( ... )
		self._root_ftpos_layoutList_list:stopAllActions()
		res.doActionDialogHide(self._root, self)
	end)
end

function DEquipChose:updateList( refresh )
	if not self.equipList then
		self.equipList = LuaList.new(self._root_ftpos_layoutList_list, function ( ... )
			return self:createLuaSet("@size")
		end, function ( nodeLuaSet, data, listIndex )
			self:updateCell(nodeLuaSet, data, false)
		end)
	end
	self.equipList:update(self:getEquipListData(), refresh or false)
end

function DEquipChose:updateCell( nodeLuaSet, nEquip, isEquiped )
	local dbEquip = dbManager.getInfoEquipment(nEquip.EquipmentId)

	nodeLuaSet["bg2"]:setVisible(isEquiped)
	nodeLuaSet["btnDetail"]:setEnabled(self.choseType ~= "ForProp")
	nodeLuaSet["btnDetail"]:setListener(function ( ... )
		local param = {}
		param.nEquip = nEquip
		if self.choseType == "ForPutOn" then
			if isEquiped then
				param.mode = "Mode_OffLoad"
				param.callback = function ( ... )
					if self.updateEquipEvent then
						self.updateEquipEvent(0)
					end
					self:close()
				end
				local petId = equipFunc.getPetIdEquippedOn(nEquip.SetIn)
				if petId > 0 then
					local itemListData = equipFunc.getEquipListWithPetId(petId) 
					equipFunc.sortWithLocation(itemListData)
					param.EquipList = itemListData
				end
				param.improveCallback = function ( ... )
					self:close()
				end
			else
				param.mode = "Mode_Change"
				param.callback = function ( ... )
					if self.updateEquipEvent then
						self.updateEquipEvent(nEquip.Id)
					end
					self:close()
				end
			end
		elseif self.choseType == "ForUse" then
			param.mode = "Mode_Chose"
			param.callback = function ( ... )
				if self.updateEquipEvent then
					self.updateEquipEvent(nEquip.Id)
				end
				self:close()
			end
		end
		print(param)
		GleeCore:showLayer("DEquipDetail", param, 2)
	end)
	res.setNodeWithEquip(nodeLuaSet["icon"], dbEquip, nil, require "RuneInfo".selectByCondition(function ( nRune )
		return nRune.SetIn == nEquip.Id
	end), true)
	nodeLuaSet["career"]:setVisible(dbEquip.career > 0)
	if dbEquip.career > 0 then
		nodeLuaSet["career"]:setResid(res.getPetCareerIcon(dbEquip.career))
	end
	nodeLuaSet["isEquiped"]:setVisible(isEquiped)
	local name = dbEquip.name
	if nEquip.Tp and nEquip.Tp > 0 then
		name = name .. "+" .. nEquip.Tp
	end
	nodeLuaSet["nameBg_name"]:setString(name)

	require 'LangAdapter'.fontSize(nodeLuaSet["layoutRank_#key"], nil, nil, nil, nil, 18)
	require 'LangAdapter'.fontSize(nodeLuaSet["layoutRank_value"], nil, nil, nil, nil, 18)
	require 'LangAdapter'.fontSize(nodeLuaSet["layoutLv_#key"], nil, nil, nil, nil, 18)
	require 'LangAdapter'.fontSize(nodeLuaSet["layoutLv_value"], nil, nil, nil, nil, 18)

	require 'LangAdapter'.fontSize(nodeLuaSet["btnImprove_#text"], nil, nil, nil, nil, nil, nil, nil, 18)
	res.adjustNodeWidth( nodeLuaSet["nameBg_name"], 135 )

	require 'LangAdapter'.fontSize(nodeLuaSet["btnOk_text"], nil, nil, nil, nil, nil, nil, nil, nil, nil, 18)
	require 'LangAdapter'.fontSize(nodeLuaSet["btnImprove_#text"], nil, nil, nil, nil, nil, nil, nil, 18, nil, 18)

	nodeLuaSet["layoutRank_value"]:setString(res.getEquipRankText(nEquip.Rank))
	nodeLuaSet["layoutLv_value"]:setString(string.format("%d/%d", nEquip.Lv, toolkit.getEquipLevelCap(nEquip)))
	if isEquiped then
		nodeLuaSet["layoutRank_value"]:setFontFillColor(ccc4f(1.0, 1.0, 1.0, 1.0), true)
		nodeLuaSet["layoutLv_value"]:setFontFillColor(ccc4f(1.0, 1.0, 1.0, 1.0), true)
	end
	nodeLuaSet["layoutProy"]:removeAllChildrenWithCleanup(true)
	local proList = toolkit.getEquipProList(nEquip)
	if proList then
		for i,pro in ipairs(proList) do
			local set = self:createLuaSet("@layoutProx")
			nodeLuaSet["layoutProy"]:addChild(set[1])
			set["key"]:setString(toolkit.getEquipProName(pro))
			set["value"]:setString(calculateTool.getEquipProDataStrByEquipInfo(nEquip, pro))
			if isEquiped then
				set["value"]:setFontFillColor(ccc4f(1.0, 1.0, 1.0, 1.0), true)
			end

			require 'LangAdapter'.fontSize(set["key"], nil, nil, nil, nil, 18)
			require 'LangAdapter'.fontSize(set["value"], nil, nil, nil, nil, 18)
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

	if self.choseType == "ForPutOn" then
		nodeLuaSet["btnImprove"]:setVisible(isEquiped)
		nodeLuaSet["btnOk"]:setVisible(not isEquiped)
		nodeLuaSet["btnOk_text"]:setString(res.locString("Global$ChangeEquip"))
		nodeLuaSet["select"]:setVisible(false)
	elseif self.choseType == "ForUse" then
		nodeLuaSet["btnImprove"]:setVisible(false)
		nodeLuaSet["btnOk"]:setVisible(self.nEquip.Id ~= nEquip.Id)
		nodeLuaSet["btnOk_text"]:setString(res.locString("Global$BtnSelect"))
		nodeLuaSet["select"]:setVisible(self.nEquip.Id == nEquip.Id)
	elseif self.choseType == "ForProp" then
		nodeLuaSet["btnImprove"]:setVisible(false)
		nodeLuaSet["btnOk"]:setVisible(true)
		nodeLuaSet["btnOk_text"]:setString(res.locString("Global$BtnSelect"))
		nodeLuaSet["select"]:setVisible(false)
	end

	nodeLuaSet["btnImprove"]:setListener(function ( ... )
		self._root_ftpos_layoutList_list:stopAllActions()
		res.doActionDialogHide(self._root, self)
		local petId = equipFunc.getPetIdEquippedOn(nEquip.SetIn)
		if petId > 0 then
			local itemListData = equipFunc.getEquipListWithPetId(petId) 
			equipFunc.sortWithLocation(itemListData)
			GleeCore:showLayer("DEquipOp", {EquipInfo = nEquip, EquipList = itemListData})
		else
			GleeCore:showLayer("DEquipOp", {EquipInfo = nEquip})
		end
	end)
	self._guideBtnImprove = self._guideBtnImprove or nodeLuaSet['btnImprove']
	nodeLuaSet["btnOk"]:setListener(function ( ... )
		if self.updateEquipEvent then
			self.updateEquipEvent(nEquip.Id)
		end
		self._root_ftpos_layoutList_list:stopAllActions()
		res.doActionDialogHide(self._root, self)
	end)
end

function DEquipChose:getEquipListData( ... )
	local itemListData = {}
	if self.choseType == "ForPutOn" then
		itemListData = equipFunc.selectByCondition(function ( v )
			if dbManager.getInfoEquipment(v.EquipmentId).location ~= self.equipLocation then
				return false
			end
			if self.nEquip and v == self.nEquip then
				return false
			end
			return true
		end)
		table.sort(itemListData, function ( v1, v2 )
			local SetIn1,SetIn2 = equipFunc.getSetInStatus(v1),equipFunc.getSetInStatus(v2)
			local on1 = SetIn1 == 1
			local on2 = SetIn2 == 1
			local dbEquip1 = dbManager.getInfoEquipment(v1.EquipmentId)
			local dbEquip2 = dbManager.getInfoEquipment(v2.EquipmentId)
			if self.nEquip then
				local dbEquip = dbManager.getInfoEquipment(self.nEquip.EquipmentId)
				if on1 == on2 then
					if dbEquip1.color == dbEquip2.color then
						if v1.Lv == v2.Lv then
							return v1.Id < v2.Id
						else
							return v1.Lv > v2.Lv
						end
					else
						return dbEquip1.color > dbEquip2.color
					end
				else
					if on1 then
						return dbEquip2.color < dbEquip.color
					else
						return dbEquip1.color >= dbEquip.color
					end
				end
			else
				if SetIn1 == SetIn2 then
					if dbEquip1.color == dbEquip2.color then
						if v1.Lv == v2.Lv then
							return v1.Id < v2.Id
						else
							return v1.Lv > v2.Lv
						end
					else
						return dbEquip1.color > dbEquip2.color
					end
				else
					return SetIn1 > SetIn2
				end
			end
		end)
	elseif self.choseType == "ForUse" or self.choseType == "ForProp" then
		itemListData = equipFunc.selectByCondition(self.selectCondition)
		self.selectedSortFunc(itemListData)
	end
	return itemListData
end

function DEquipChose:updateLayer( nEquip )
	local winSize = CCDirector:sharedDirector():getWinSize()
	self._root_bg:setScaleX(winSize.width / self._root_bg:getWidth())
	if self.choseType == "ForPutOn" then
		self._root_ftpos_tabBg:setVisible(true)
		self._root_ftpos_tabBg_icon:setResid(res.getEquipTypeRes(self.equipLocation))
		self._root_ftpos_tabBg_name:setString(res.locString(string.format("Equip$EquipType%d", self.equipLocation)))
		self._root_ftpos_tabBg2:setVisible(false)

		require 'LangAdapter'.fontSize(self._root_ftpos_tabBg_name, nil, nil, nil, nil, nil, 22, nil, 20, nil, 18)
	elseif self.choseType == "ForUse" then
		self._root_ftpos_tabBg:setVisible(false)
		self._root_ftpos_tabBg2:setVisible(true)
	elseif self.choseType == "ForProp" then
		self._root_ftpos_tabBg:setVisible(false)
		self._root_ftpos_tabBg2:setVisible(true)
	end
	local listWitdh = winSize.width
	if self.choseType == "ForPutOn" and self.nEquip then
		local set = self:createLuaSet("@size")
		self._root_ftpos_layoutList:addChild(set[1], -1)
		self:updateCell(set, self.nEquip, true)
		listWitdh = listWitdh - set[1]:getWidth()
	end
	self._root_ftpos_layoutList_list:setContentSize(CCSize(listWitdh, self._root_ftpos_layoutList_list:getHeight()))
	self:updateList(true)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DEquipChose, "DEquipChose")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DEquipChose", DEquipChose)

return DEquipChose
