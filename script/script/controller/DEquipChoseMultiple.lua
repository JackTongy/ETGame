local Config = require "Config"
local LuaList = require "LuaList"
local res = require "Res"
local dbManager = require "DBManager"
local toolkit = require "Toolkit"
local calculateTool = require "CalculateTool"
local gameFunc = require "AppData"
local equipFunc = gameFunc.getEquipInfo()
local netModel = require "netModel"

local DEquipChoseMultiple = class(LuaDialog)

function DEquipChoseMultiple:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DEquipChoseMultiple.cocos.zip")
    return self._factory:createDocument("DEquipChoseMultiple.cocos")
end

--@@@@[[[[
function DEquipChoseMultiple:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg = set:getElfNode("root_bg")
   self._root_ftpos_tabBg_name = set:getLabelNode("root_ftpos_tabBg_name")
   self._root_ftpos_layoutList = set:getLinearLayoutNode("root_ftpos_layoutList")
   self._root_ftpos_layoutList_list = set:getListNode("root_ftpos_layoutList_list")
   self._icon = set:getElfNode("icon")
   self._nameBg_name = set:getLabelNode("nameBg_name")
   self._layoutRank_key = set:getLabelNode("layoutRank_key")
   self._layoutRank_value = set:getLabelNode("layoutRank_value")
   self._layoutLv_key = set:getLabelNode("layoutLv_key")
   self._layoutLv_value = set:getLabelNode("layoutLv_value")
   self._layoutProy = set:getLayoutNode("layoutProy")
   self._key = set:getLabelNode("key")
   self._value = set:getLabelNode("value")
   self._key = set:getLabelNode("key")
   self._value = set:getLabelNode("value")
   self._key = set:getLabelNode("key")
   self._value = set:getLabelNode("value")
   self._layoutGold = set:getLinearLayoutNode("layoutGold")
   self._layoutGold_value = set:getLabelNode("layoutGold_value")
   self._select = set:getElfNode("select")
   self._btnDetail = set:getClickNode("btnDetail")
   self._root_ftpos2_close = set:getButtonNode("root_ftpos2_close")
   self._root_ftpos3_bgMagicBox = set:getJoint9Node("root_ftpos3_bgMagicBox")
   self._root_ftpos3_bgMagicBox_layout = set:getLinearLayoutNode("root_ftpos3_bgMagicBox_layout")
   self._root_ftpos3_bgMagicBox_layout_value = set:getLabelNode("root_ftpos3_bgMagicBox_layout_value")
   self._root_ftpos3_bgSell = set:getJoint9Node("root_ftpos3_bgSell")
   self._root_ftpos3_bgSell_layout1 = set:getLinearLayoutNode("root_ftpos3_bgSell_layout1")
   self._root_ftpos3_bgSell_layout1_value = set:getLabelNode("root_ftpos3_bgSell_layout1_value")
   self._root_ftpos3_bgSell_layout2 = set:getLinearLayoutNode("root_ftpos3_bgSell_layout2")
   self._root_ftpos3_bgSell_layout2_value = set:getLabelNode("root_ftpos3_bgSell_layout2_value")
   self._root_ftpos4_btnOk = set:getClickNode("root_ftpos4_btnOk")
   self._root_ftpos4_btnOk_text = set:getLabelNode("root_ftpos4_btnOk_text")
   self._root_ftpos4_btnSell = set:getClickNode("root_ftpos4_btnSell")
   self._root_ftpos4_btnSell_text = set:getLabelNode("root_ftpos4_btnSell_text")
   self._root_ftpos4_btnChoseBlueAll = set:getClickNode("root_ftpos4_btnChoseBlueAll")
   self._root_ftpos4_btnChoseBlueAll_text = set:getLabelNode("root_ftpos4_btnChoseBlueAll_text")
   self._root_ftpos4_btnChoseGreenAll = set:getClickNode("root_ftpos4_btnChoseGreenAll")
   self._root_ftpos4_btnChoseGreenAll_text = set:getLabelNode("root_ftpos4_btnChoseGreenAll_text")
--   self._@size = set:getElfNode("@size")
--   self._@layoutProx = set:getLinearLayoutNode("@layoutProx")
--   self._@layoutProx = set:getLinearLayoutNode("@layoutProx")
--   self._@layoutProx = set:getLinearLayoutNode("@layoutProx")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DEquipChoseMultiple:onInit( userData, netData )
	self.choseType = userData.choseType
	if self.choseType == "ForSell" then
		self.nEquipSelList = {}
	elseif self.choseType == "ForMagicBox" or self.choseType == "ForEquipAuth" then
		self.origalList = userData.magicBoxSelectList
		self.nEquipSelList = {}
		if userData.magicBoxSelectList then
			for i,v in ipairs(userData.magicBoxSelectList) do
				table.insert(self.nEquipSelList, v)
			end
		end
		self.magicBoxCallback = userData.magicBoxCallback
	end

	self:setListenerEvent()
	self:updateLayer(true)

	require 'LangAdapter'.fontSize(self._root_ftpos4_btnChoseBlueAll_text, nil, nil, nil, 18)
	require 'LangAdapter'.fontSize(self._root_ftpos4_btnChoseGreenAll_text, nil, nil, nil, 18)
	require 'LangAdapter'.selectLang(nil,nil,nil,nil,function ( ... )
		self._root_ftpos3_bgSell_layout1:layout()
		res.adjustNodeWidth( self._root_ftpos3_bgSell_layout1, 160 )
	end)

	res.doActionDialogShow(self._root)
end

function DEquipChoseMultiple:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DEquipChoseMultiple:setListenerEvent( ... )
	self._root_ftpos2_close:setListener(function ( ... )
		if self.choseType == "ForMagicBox" or self.choseType == "ForEquipAuth" then
			self.nEquipSelList = self.origalList
		end
		self._root_ftpos_layoutList_list:stopAllActions()
		res.doActionDialogHide(self._root, self)
	end)

	self._root_ftpos4_btnOk:setListener(function ( ... )
		if self.magicBoxCallback then
			self.magicBoxCallback(self.nEquipSelList)
		end
		self._root_ftpos_layoutList_list:stopAllActions()
		res.doActionDialogHide(self._root, self)
	end)

	self._root_ftpos4_btnSell:setListener(function ( ... )
		if #self.nEquipSelList == 0 then
			self:toast(res.locString("Equip$NoEquipCanSell"))
			return
		end
		local function sellEquip( nEquipList )
			local list = {}
			for i,v in ipairs(nEquipList) do
				local a = math.floor((i - 1) / 50 + 1)
				local b = math.floor((i - 1) % 50 + 1)
				list[a] = list[a] or {}
				list[a][b] = v
			end

			local goldValue = 0
			for i,equipList in ipairs(list) do
				self:send(netModel.getModelEqSell(equipList), function ( data )
					print("EqSell")
					print(data)
					if data and data.D then
						equipFunc.removeEquipByIds(equipList)

						gameFunc.updateResource(data.D.Resource)

						if data.D.Reward.Gold and data.D.Reward.Gold > 0 then
							goldValue = goldValue + data.D.Reward.Gold
						end			

						if i == #list then
							self.equipListDataCache = nil
							self.nEquipSelList = {}
							self:updateLayer()
						--	res.doActionGetReward()
							self:toast(string.format(res.locString("Bag$SellEquipGetGold"), goldValue))
						end
					end
				end)
			end
		end

		local list = {}
		for i,v in ipairs(self.nEquipSelList) do
			table.insert(list, v.Id)
		end
		local canSell = true
		for i,nEquip in ipairs(self.nEquipSelList) do
			local dbEquip = dbManager.getInfoEquipment(nEquip.EquipmentId)
			if dbEquip and dbEquip.color >= 3 then -- 紫装及以上
				local param = {}
				param.content = res.locString("Bag$SellEquipConfirm")
				param.RightBtnText = res.locString("Global$Sale")
				param.callback = function ( ... )
					sellEquip(list)
				end
				GleeCore:showLayer("DConfirmNT", param)
				canSell = false
				break
			end
		end
		if canSell then
			sellEquip(list)
		end
	end)

	self._root_ftpos4_btnChoseBlueAll:setListener(function ( ... )
		local equipList = self:getEquipListData()
		for i,nEquip in ipairs(equipList) do
			local dbEquip = dbManager.getInfoEquipment(nEquip.EquipmentId)
			if dbEquip.color == 2 then
				if self.choseBlueAll then
					local key = table.keyOfItem(self.nEquipSelList, nEquip)
					if key ~= nil then
						table.remove(self.nEquipSelList, key)
					end
				else
					if not self:isInSelectedList(nEquip) then
						table.insert(self.nEquipSelList, nEquip)
					end
				end
			end
		end
		self:updateList()
		self:updateChoseBtnStatus()
	end)

	self._root_ftpos4_btnChoseGreenAll:setListener(function ( ... )
		print("self.choseGreenAll " .. tostring(self.choseGreenAll))
		local equipList = self:getEquipListData()
		for i,nEquip in ipairs(equipList) do
			local dbEquip = dbManager.getInfoEquipment(nEquip.EquipmentId)
			if dbEquip.color == 1 then
				if self.choseGreenAll then
					local key = table.keyOfItem(self.nEquipSelList, nEquip)
					if key ~= nil then
						table.remove(self.nEquipSelList, key)
					end
				else
					if not self:isInSelectedList(nEquip) then
						table.insert(self.nEquipSelList, nEquip)
					end
				end
			end
		end
		self:updateList()
		self:updateChoseBtnStatus()
	end)
end

function DEquipChoseMultiple:updateLayer( refresh )
	local winSize = CCDirector:sharedDirector():getWinSize()
	self._root_bg:setScaleX(winSize.width / self._root_bg:getWidth())
	if self.choseType == "ForSell" then
		self._root_ftpos_tabBg_name:setString(res.locString("Equip$titleEquipSell"))
		self._root_ftpos4_btnOk:setVisible(false)
		self._root_ftpos4_btnSell:setVisible(true)
		self._root_ftpos4_btnChoseBlueAll:setVisible(true)
		self._root_ftpos4_btnChoseGreenAll:setVisible(true)
		self._root_ftpos3_bgSell:setVisible(true)
		self._root_ftpos3_bgMagicBox:setVisible(false)
	elseif self.choseType == "ForMagicBox" or self.choseType == "ForEquipAuth" then
		self._root_ftpos_tabBg_name:setString(res.locString("Equip$titleEquipChose"))
		self._root_ftpos4_btnOk:setVisible(true)
		self._root_ftpos4_btnSell:setVisible(false)
		self._root_ftpos4_btnChoseBlueAll:setVisible(false)
		self._root_ftpos4_btnChoseGreenAll:setVisible(false)
		self._root_ftpos3_bgSell:setVisible(false)
		self._root_ftpos3_bgMagicBox:setVisible(true)
	end
	self._root_ftpos_layoutList_list:setContentSize(CCSize(winSize.width, self._root_ftpos_layoutList_list:getHeight()))
	self:updateList(refresh)
	self:updateChoseBtnStatus()
end

function DEquipChoseMultiple:updateChoseBtnStatus( ... )
	local list = self:getEquipListData()
	local blue = false
	local green = false
	self.choseGreenAll = true
	self.choseBlueAll = true
	for i,nEquip in ipairs(list) do
		local dbEquip = dbManager.getInfoEquipment(nEquip.EquipmentId)
		if dbEquip.color == 1 then
			green = true
		elseif dbEquip.color == 2 then
			blue = true
		end

		if self.choseGreenAll and dbEquip.color == 1 and (not self:isInSelectedList(nEquip)) then
			self.choseGreenAll = false
		end

		if self.choseBlueAll and dbEquip.color == 2 and (not self:isInSelectedList(nEquip)) then
			self.choseBlueAll = false
		end
	end
	if green == false then
		self.choseGreenAll = false
	end
	if blue == false then
		self.choseBlueAll = false
	end
	self._root_ftpos4_btnChoseGreenAll:setEnabled(green)
	self._root_ftpos4_btnChoseBlueAll:setEnabled(blue)
	if self.choseGreenAll then
		self._root_ftpos4_btnChoseGreenAll_text:setFontFillColor(ccc4f(0.6, 0.6, 0.6, 0.5), true)
	else
		self._root_ftpos4_btnChoseGreenAll_text:setFontFillColor(ccc4f(1.0, 1.0, 1.0, 1.0), true)
	end
	if self.choseBlueAll then
		self._root_ftpos4_btnChoseBlueAll_text:setFontFillColor(ccc4f(0.6, 0.6, 0.6, 0.5), true)
	else
		self._root_ftpos4_btnChoseBlueAll_text:setFontFillColor(ccc4f(1.0, 1.0, 1.0, 1.0), true)
	end
end

function DEquipChoseMultiple:updateList( refresh )
	if not self.equipList then
		self.equipList = LuaList.new(self._root_ftpos_layoutList_list, function ( ... )
			return self:createLuaSet("@size")
		end, function ( nodeLuaSet, data, listIndex )
			self:updateCell(nodeLuaSet, data)
		end)
	end
	self.equipList:update(self:getEquipListData(), refresh or false)
	self:updateEquipStatus()
end

function DEquipChoseMultiple:updateCell( nodeLuaSet, nEquip )
	local dbEquip = dbManager.getInfoEquipment(nEquip.EquipmentId)
	res.setNodeWithEquip(nodeLuaSet["icon"], dbEquip, nil, require "RuneInfo".selectByCondition(function ( nRune )
		return nRune.SetIn == nEquip.Id
	end), true)
	local name = dbEquip.name
	if nEquip.Tp and nEquip.Tp > 0 then
		name = name .. "+" .. nEquip.Tp
	end
	nodeLuaSet["nameBg_name"]:setString(name)
	nodeLuaSet["layoutRank_value"]:setString(res.getEquipRankText(nEquip.Rank))
	require 'LangAdapter'.fontSize(nodeLuaSet["layoutRank_value"], nil, nil, nil, nil, 18)

	nodeLuaSet["layoutLv_value"]:setString(string.format("%d/%d", nEquip.Lv, toolkit.getEquipLevelCap(nEquip)))

	if self.choseType == "ForSell" then
		nodeLuaSet["layoutGold"]:setVisible(true)
		nodeLuaSet["layoutGold_value"]:setString(100 * math.pow(5, dbEquip.color))
		nodeLuaSet["layoutProy"]:setVisible(false)
	elseif self.choseType == "ForMagicBox" or self.choseType == "ForEquipAuth" then
		nodeLuaSet["layoutGold"]:setVisible(false)
		nodeLuaSet["layoutProy"]:setVisible(true)
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
	end

	local key,isSelected
	for k,v in pairs(self.nEquipSelList) do
		if v.Id == nEquip.Id then
			key = k
			isSelected = true
			break
		end
	end
	-- local key = table.keyOfItem(self.nEquipSelList, nEquip)
	-- local isSelected = key ~= nil
	nodeLuaSet["select"]:setVisible(isSelected)
	nodeLuaSet["btnDetail"]:setListener(function ( ... )
		if self.choseType == "ForSell" then
			if isSelected then
				table.remove(self.nEquipSelList, key)
			else
				table.insert(self.nEquipSelList, nEquip)
			end
			self:updateLayer()
		elseif self.choseType == "ForMagicBox" or self.choseType == "ForEquipAuth" then
			if isSelected then
				for k,v in pairs(self.nEquipSelList) do
					if v.Id == nEquip.Id then
						table.remove(self.nEquipSelList, k)
						break
					end
				end
				if #self.nEquipSelList == 0 then
					self:updateLayer(true)
				else
					self:updateCell(nodeLuaSet, nEquip)
					self:updateEquipStatus()
				end
			else
				local limitCount = self.choseType == "ForMagicBox" and 5 or 4
				if self.nEquipSelList and #self.nEquipSelList >= limitCount then
					self:toast(string.format(res.locString("Bag$EquipCountLimitFormat"), limitCount))
					return
				else
					table.insert(self.nEquipSelList, nEquip)
					if #self.nEquipSelList == 1 then
						self:updateLayer(true)
					else
						self:updateCell(nodeLuaSet, nEquip)
						self:updateEquipStatus()
					end
				end	
			end
		end
	end)
end

function DEquipChoseMultiple:getEquipListData( ... )
	local itemListData = {}
	if self.choseType == "ForSell" then
		if self.equipListDataCache then
			return self.equipListDataCache
		end

		itemListData = equipFunc.selectByCondition(function ( v )
			return equipFunc.getSetInStatus(v) == 3
		end)
		table.sort(itemListData, function ( nEquip1, nEquip2 )
			local dbEquip1 = dbManager.getInfoEquipment(nEquip1.EquipmentId)
			local dbEquip2 = dbManager.getInfoEquipment(nEquip2.EquipmentId)
			if dbEquip1.color == dbEquip2.color then
				if nEquip1.Lv == nEquip2.Lv then
					return nEquip1.Id < nEquip2.Id
				else
					return nEquip1.Lv < nEquip2.Lv
				end
			else
				return dbEquip1.color < dbEquip2.color
			end
		end)

		self.equipListDataCache = itemListData
	elseif self.choseType == "ForMagicBox" then
		itemListData = equipFunc.selectByCondition(function ( v )
			-- if table.find(self.nEquipSelList, v) then
			-- 	return false
			-- end
			if equipFunc.getSetInStatus(v) ~= 3 then
				return false
			end
			local colorLimit = dbManager.getInfoDefaultConfig("EqLimit").Value
			if dbManager.getInfoEquipment(v.EquipmentId).color >= colorLimit then
				return false
			end
			if self.nEquipSelList and #self.nEquipSelList > 0 then
				local tempEquip = dbManager.getInfoEquipment(equipFunc.getEquipWithId(self.nEquipSelList[1].Id).EquipmentId)
				if dbManager.getInfoEquipment(v.EquipmentId).color~= tempEquip.color then
					return false
				end	
			end
			return true
		end)
		table.sort(itemListData, function ( nEquip1, nEquip2 )
			local isInList1 = self:isInSelectedList(nEquip1)
			local isInList2 = self:isInSelectedList(nEquip2)
			if isInList1 == isInList2 then
				local dbEquip1 = dbManager.getInfoEquipment(nEquip1.EquipmentId)
				local dbEquip2 = dbManager.getInfoEquipment(nEquip2.EquipmentId)
				if dbEquip1.color == dbEquip2.color then
					if nEquip1.Lv == nEquip2.Lv then
						return nEquip1.Id < nEquip2.Id
					else
						return nEquip1.Lv < nEquip2.Lv
					end
				else
					return dbEquip1.color < dbEquip2.color
				end
			else
				return isInList1
			end
		end)
	elseif self.choseType == "ForEquipAuth" then
		itemListData = equipFunc.selectByCondition(function ( v )
			return not (v.Props and #v.Props > 0) and dbManager.getInfoEquipment(v.EquipmentId).color >= 3
		end)
		table.sort(itemListData, function ( nEquip1, nEquip2 )
			local isInList1 = self:isInSelectedList(nEquip1)
			local isInList2 = self:isInSelectedList(nEquip2)
			if isInList1 == isInList2 then
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
			else
				return isInList1
			end
		end)
	end
	return itemListData
end

function DEquipChoseMultiple:isInSelectedList( nEquip )
	return table.find(self.nEquipSelList, nEquip)
end

function DEquipChoseMultiple:updateEquipStatus( ... )
	if self.choseType == "ForSell" then
		self._root_ftpos3_bgSell_layout1_value:setString(tostring(#self.nEquipSelList))
		local gold = 0
		for i,nEquip in ipairs(self.nEquipSelList) do
			local dbEquip = dbManager.getInfoEquipment(nEquip.EquipmentId)
			gold = gold + 100 * math.pow(5, dbEquip.color)
		end
		self._root_ftpos3_bgSell_layout2_value:setString(tostring(gold))
		self._root_ftpos4_btnSell:setEnabled(self.nEquipSelList and #self.nEquipSelList > 0)
	elseif self.choseType == "ForMagicBox" or self.choseType == "ForEquipAuth" then
		self._root_ftpos3_bgMagicBox_layout_value:setString(tostring(#self.nEquipSelList))
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DEquipChoseMultiple, "DEquipChoseMultiple")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DEquipChoseMultiple", DEquipChoseMultiple)
