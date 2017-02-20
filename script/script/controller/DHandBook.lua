local Config = require "Config"
local dbManager = require "DBManager"
local res = require "Res"
local netModel = require "netModel"
local petFunc = require "AppData".getPetInfo()

local showStarLevelTop = 6
local orderValue = 10000
local DHandBook = class(LuaDialog)
local lineCount = 5

function DHandBook:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DHandBook.cocos.zip")
    return self._factory:createDocument("DHandBook.cocos")
end

--@@@@[[[[
function DHandBook:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_bg = set:getJoint9Node("commonDialog_cnt_bg")
    self._commonDialog_cnt_bg_pageList = set:getElfNode("commonDialog_cnt_bg_pageList")
    self._bg = set:getElfNode("bg")
    self._starLayout = set:getLayoutNode("starLayout")
    self._text = set:getLabelNode("text")
    self._layout = set:getLayoutNode("layout")
    self._bg = set:getElfNode("bg")
    self._name = set:getLabelNode("name")
    self._icon = set:getElfNode("icon")
    self._sel = set:getElfNode("sel")
    self._career = set:getElfNode("career")
    self._property = set:getElfNode("property")
    self._starLayout = set:getLayoutNode("starLayout")
    self._collect = set:getElfNode("collect")
    self._btn = set:getButtonNode("btn")
    self._bg = set:getElfNode("bg")
    self._name = set:getLabelNode("name")
    self._atkAddition = set:getLabelNode("atkAddition")
    self._hpAddition = set:getLabelNode("hpAddition")
    self._layout = set:getLayoutNode("layout")
    self._bg = set:getElfNode("bg")
    self._name = set:getLabelNode("name")
    self._icon = set:getElfNode("icon")
    self._sel = set:getElfNode("sel")
    self._career = set:getElfNode("career")
    self._property = set:getElfNode("property")
    self._starLayout = set:getLayoutNode("starLayout")
    self._collect = set:getElfNode("collect")
    self._btn = set:getButtonNode("btn")
    self._commonDialog_cnt_bg_additionEffectBg = set:getElfNode("commonDialog_cnt_bg_additionEffectBg")
    self._commonDialog_cnt_bg_additionEffectBg_atkAddition = set:getLabelNode("commonDialog_cnt_bg_additionEffectBg_atkAddition")
    self._commonDialog_cnt_bg_additionEffectBg_hpAddition = set:getLabelNode("commonDialog_cnt_bg_additionEffectBg_hpAddition")
    self._commonDialog_cnt_bg_career = set:getElfNode("commonDialog_cnt_bg_career")
    self._commonDialog_cnt_bg_career_btn = set:getClickNode("commonDialog_cnt_bg_career_btn")
    self._commonDialog_cnt_bg_careerBg = set:getElfNode("commonDialog_cnt_bg_careerBg")
    self._commonDialog_cnt_bg_careerBg_layout_btn4 = set:getButtonNode("commonDialog_cnt_bg_careerBg_layout_btn4")
    self._commonDialog_cnt_bg_careerBg_layout_btn3 = set:getButtonNode("commonDialog_cnt_bg_careerBg_layout_btn3")
    self._commonDialog_cnt_bg_careerBg_layout_btn2 = set:getButtonNode("commonDialog_cnt_bg_careerBg_layout_btn2")
    self._commonDialog_cnt_bg_careerBg_layout_btn1 = set:getButtonNode("commonDialog_cnt_bg_careerBg_layout_btn1")
    self._commonDialog_cnt_bg_careerBg_layout_btn0 = set:getButtonNode("commonDialog_cnt_bg_careerBg_layout_btn0")
    self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
    self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
    self._commonDialog_tab = set:getElfNode("commonDialog_tab")
    self._commonDialog_tab_tabNormal = set:getTabNode("commonDialog_tab_tabNormal")
    self._commonDialog_tab_tabNormal_title = set:getLabelNode("commonDialog_tab_tabNormal_title")
    self._commonDialog_tab_tabAddition = set:getTabNode("commonDialog_tab_tabAddition")
    self._commonDialog_tab_tabAddition_title = set:getLabelNode("commonDialog_tab_tabAddition_title")
    self._commonDialog_btnHelp = set:getButtonNode("commonDialog_btnHelp")
--    self._@listNormal = set:getListNode("@listNormal")
--    self._@starBar = set:getElfNode("@starBar")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@size = set:getElfNode("@size")
--    self._@item = set:getElfNode("@item")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@listAddition = set:getListNode("@listAddition")
--    self._@title = set:getElfNode("@title")
--    self._@size = set:getElfNode("@size")
--    self._@item = set:getElfNode("@item")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DHandBook", function ( userData )
	Launcher.Launching()
end)

function DHandBook:onInit( userData, netData )
	self.petIdListCollected = petFunc.getPetIdCollectionList()
	self:setListenerEvent()	
	self.tabIndexSelected = 1
	self:initPageArray()
	self:updatePages()

	self._commonDialog_cnt_bg_career:setVisible(true)
	self._commonDialog_cnt_bg_careerBg:setVisible(false)

	res.doActionDialogShow(self._commonDialog)
	require 'LangAdapter'.fontSize(self._commonDialog_tab_tabNormal_title, nil, nil, nil, nil, 22, nil, nil, 22)
	require 'LangAdapter'.fontSize(self._commonDialog_tab_tabAddition_title, nil, nil, nil, nil, 22, nil, nil, 22)
end

function DHandBook:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DHandBook:setListenerEvent( ... )
	self._commonDialog_tab_tabNormal:trigger(nil)
	self._commonDialog_tab_tabNormal:setListener(function ( ... )
		if self.tabIndexSelected ~= 1 then
			self.tabIndexSelected = 1
			self:updatePages()
		end
	end)

	self._commonDialog_tab_tabAddition:setListener(function ( ... )
		if self.tabIndexSelected ~= 2 then
			self.tabIndexSelected = 2
			self:updatePages()
		end
	end)

	self._commonDialog_btnHelp:setVisible(false)
	self._commonDialog_btnHelp:setListener(function ( ... )
		GleeCore:showLayer("DHelp", {type = "图鉴"})
	end)

	self._commonDialog_btnClose:setListener(function ( ... )
		self.pageList[self.tabIndexSelected][1]:stopAllActions()
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._commonDialog_cnt_bg_career_btn:setListener(function ( ... )
		self._commonDialog_cnt_bg_career:setVisible(false)
		self._commonDialog_cnt_bg_careerBg:setVisible(true)
	end)

	for i=0,4 do
		self[string.format("_commonDialog_cnt_bg_careerBg_layout_btn%d", i)]:setListener(function ( ... )
			self._commonDialog_cnt_bg_career:setVisible(true)
			self._commonDialog_cnt_bg_careerBg:setVisible(false)
			print("self.career = " .. self.career)
			if self.career ~= i then
				local list = {"N_TJ_qb.png", "N_TJ_za.png", "N_TJ_sh.png", "N_TJ_yc.png", "N_TJ_zl.png"}
				self._commonDialog_cnt_bg_career:setResid(list[i + 1])
				self.career = i
				self:updateCareer()
			end
		end)
	end
end

function DHandBook:initPageArray( ... )
	local dyList = {"@listNormal", "@listAddition"}
	self.pageList = {}
	for i,v in ipairs(dyList) do
		local set = self:createLuaSet(v)
		self._commonDialog_cnt_bg_pageList:addChild(set[1])
		set[1]:setVisible(false)
		table.insert(self.pageList, set)
	end
end

function DHandBook:initPageNormal( ... )
	if self.generalLayerInited then
		do return end
	end
	self.generalLayerInited = true

	self.career = 0 -- 0表示全部
	self:updateCareer()
end

function DHandBook:initPageAddition( ... )
	if self.additionLayerInited then
		do return end
	end
	self.additionLayerInited = true

	local listNode = self.pageList[2][1]

	local groupList = dbManager.getInfoCollectionGroupConfig()
	if showStarLevelTop < 6 then
		for i=#groupList,1, -1 do
			local canFind = false
			for i,v in ipairs(groupList[i].Group) do
				local dbPet = dbManager.getCharactor(v)
				if (not dbPet) or dbPet.star_level == 6 then
					canFind = true
					break
				end
			end
			if canFind then
				table.remove(groupList, i)
			end
		end
	end

	local atkAddition = 0
	local hpAddition = 0
	local updateCell = function ( cellData, i )
		local titleSet = self:createLuaSet("@title")
		listNode:getContainer():addChild(titleSet[1], orderValue * i)
		titleSet["name"]:setString(cellData.name)
		titleSet["atkAddition"]:setString(string.format(res.locString("HandBook$AtkAddition"), cellData.Attack))
		titleSet["hpAddition"]:setString(string.format(res.locString("HandBook$HpAddition"), cellData.Hp))

		local collectSuccess = self:isCollectionGroupSuccess(cellData.Group)
		if collectSuccess then
			titleSet["bg"]:setResid("N_TJ_38.png")
			titleSet["name"]:setFontFillColor(ccc4f(0.584,0.384,0.0,1.0), true)
			titleSet["atkAddition"]:setFontFillColor(ccc4f(0.584,0.384,0.0,1.0), true)
			titleSet["hpAddition"]:setFontFillColor(ccc4f(0.584,0.384,0.0,1.0), true)
			atkAddition = atkAddition + cellData.Attack
			hpAddition = hpAddition + cellData.Hp
		else
			titleSet["bg"]:setResid("N_TJ_34.png")
			titleSet["name"]:setFontFillColor(ccc4f(0.518,0.482,0.42,1.0), true)
			titleSet["atkAddition"]:setFontFillColor(ccc4f(0.518,0.482,0.42,1.0), true)
			titleSet["hpAddition"]:setFontFillColor(ccc4f(0.518,0.482,0.42,1.0), true)
		end
		self._commonDialog_cnt_bg_additionEffectBg_atkAddition:setString(string.format(res.locString("HandBook$AtkAddition"), atkAddition))
		self._commonDialog_cnt_bg_additionEffectBg_hpAddition:setString(string.format(res.locString("HandBook$HpAddition"), hpAddition))

		local temp = {}
		for i,petId in ipairs(cellData.Group) do
			local dbPet = dbManager.getCharactor(petId)
			table.insert(temp, dbPet)
		end
		self:updateItemList(listNode, temp, true, orderValue * i)
	end

	self.additionItemList = {}
	listNode:stopAllActions()
	listNode:getContainer():removeAllChildrenWithCleanup(true)
	for i=1,#groupList do
		local index = i
		if i < 7 then
			updateCell(groupList[index], index)
		else
			self:runWithDelay(function (  )
				updateCell(groupList[index], index)
			end, 0.1 * (i - 6), listNode )
		end
	end
	listNode:layout()
end

function DHandBook:updateCareer( ... )
	local listNode = self.pageList[1][1]

	local listData
	if self.career >= 0 and self.career <= 4 then
		if not self["career_" .. tostring(self.career)] then
			self["career_" .. tostring(self.career)] = self:getPetsWithCareer(self.career)
		end
		listData = self:getPetListWithStarLevel(self["career_" .. tostring(self.career)])
	end

	local updateCell = function ( starLevelList, i, starBarVisible, idx )
		if starLevelList then
			if starBarVisible then
				local starBar = self:createLuaSet("@starBar")
				listNode:getContainer():addChild(starBar[1], (showStarLevelTop - i) * orderValue + idx )

				for j=1,i do
					local star = self:createLuaSet("@star")
					starBar["starLayout"]:addChild(star[1])
				end
				self.starBarList = self.starBarList or {}
				self.starBarList[i] = starBar
				self.starBarListData = self.starBarListData or {}
				self.starBarListData[i] = self.starBarListData[i] or {}
				self.starBarListData[i]["_pre"] = 0
				self.starBarListData[i]["_after"] = 0
			end
			self.starBarListData[i]["_pre"] = self.starBarListData[i]["_pre"] + self:getCollectionCount(starLevelList)
			self.starBarListData[i]["_after"] = self.starBarListData[i]["_after"] + #starLevelList
			self.starBarList[i]["text"]:setString(string.format("%d / %d", self.starBarListData[i]["_pre"], self.starBarListData[i]["_after"]))
			self:updateItemList(listNode, starLevelList, false, (showStarLevelTop - i) * orderValue + idx )
		end
	end

	self.normalItemList = {}
	listNode:stopAllActions() -- 关闭之前未加载完成的列表条目
	listNode:getContainer():removeAllChildrenWithCleanup(true)
	local kList = {}
	for i=showStarLevelTop,3,-1 do
		local index = i
		if #listData[index] <= lineCount then
			table.insert(kList, {list = listData[index], index = index, starBarVisible = true})
		else
			local tempList
			local flag = true
			for i,v in ipairs(listData[index]) do
				if i % lineCount == 1 then
					tempList = {}
				end
				table.insert(tempList, v)
				if #tempList == lineCount or i == #listData[index] then
					table.insert(kList, {list = tempList, index = index, starBarVisible = flag})
					flag = false
				end
			end
		end
	end
	for i,v in ipairs(kList) do
		local idx = i
		if i < 5 then
			updateCell(v.list, v.index, v.starBarVisible, idx)
		else
			self:runWithDelay(function ( ... )
				updateCell(v.list, v.index, v.starBarVisible, idx)
			end, 0.1 * (i - 1), listNode)		
		end
	end
	listNode:layout()
end

function DHandBook:updateItemList( listNode, dataList, isAddition, zOrder)
	local sizeSet
	for i, dbPet in ipairs(dataList) do
		if i % lineCount == 1 then
			sizeSet = self:createLuaSet("@size")
			listNode:getContainer():addChild(sizeSet[1], zOrder + i)
		end

		local itemSet = self:createLuaSet("@item")
		sizeSet["layout"]:addChild(itemSet[1])
		self:updateItem(dbPet, itemSet, isAddition)

		if isAddition then
			self.additionItemList[dbPet.id] = itemSet
		else
			self.normalItemList[dbPet.id] = itemSet
		end
	end
end

function DHandBook:updateItem( dbPet, itemSet, isAddition )
	local nPet = petFunc.getPetInfoByPetId(dbPet.id)
	local isCollect = self:isCollectionGroupSuccess({[1] = dbPet.id}) 
	local isArchived = false
	local ArchivedCount = 0
	if isCollect then
		ArchivedCount = petFunc.getPetArchivedCount(dbPet.id)
		isArchived = ArchivedCount > 0
	end
	if isArchived then
		itemSet["name"]:setFontFillColor(ccc4f(0.988,0.427,0.239,1.0), true)
		itemSet["name"]:setString(dbPet.name .. "x" .. ArchivedCount)
	else
		if isCollect then
			itemSet["name"]:setFontFillColor(ccc4f(0.396,0.286,0.247,1.0), true)
		else
			itemSet["name"]:setFontFillColor(ccc4f(0.812,0.694,0.655,1.0), true)
		end
		itemSet["name"]:setString(dbPet.name)
	end

	local nameWidth = itemSet["name"]:getWidth()
	if nameWidth > 120 then
		itemSet["name"]:setScale(120/nameWidth)
	end

	itemSet["sel"]:setVisible(isArchived)
	itemSet["collect"]:setVisible(not isCollect)
	if isCollect then
		res.setNodeWithPet(itemSet["icon"], nPet)
		itemSet["career"]:setResid(res.getPetCareerIcon(dbPet.atk_method_system))
		-- itemSet["starLayout"]:removeAllChildrenWithCleanup(true)
		-- for i=1,dbPet.star_level do
		-- 	local star = self:createLuaSet("@star")
		-- 	itemSet["starLayout"]:addChild(star[1])
		-- end
		require 'PetNodeHelper'.updateStarLayout(itemSet["starLayout"], dbPet)
	else
		self:setNodeWithUnknown(itemSet["icon"])
		itemSet["career"]:setResid("")
		itemSet["starLayout"]:removeAllChildrenWithCleanup(true)
	end

	itemSet["btn"]:setListener(function ( ... )	
		local param = {}
		param.nPet = petFunc.getPetInfoByPetId(dbPet.id)
		param.isPetFromDbPet = true
		-- param.petSelectFunc = function ( offset )
		-- 	local newPetId
		-- 	if isAddition then
		-- 		newPetId = self:getPetInCollectionGroupList(param.nPet.PetId, offset)
		-- 	else
		-- 		newPetId = self:getPetIdInCareerList(param.nPet.PetId, offset, self.career)
		-- 	end
			
		-- 	if newPetId > 0 then
		-- 		param.nPet = petFunc.getPetInfoByPetId(newPetId)
		-- 		return param
		-- 	end
		-- 	return nil
		-- end
		param.callback = function ( list )
			self:updateArchivedPet(list)
		end
		param.isCollect = isCollect
		GleeCore:showLayer("DPetDetailV", param)	
	end)
end

function DHandBook:updatePages( ... )
	for i,v in ipairs(self.pageList) do
		v[1]:setVisible(i == self.tabIndexSelected)
	end
	if self.tabIndexSelected == 1 then
		self:initPageNormal()
		self._commonDialog_cnt_bg_career:setVisible(true)
		self._commonDialog_cnt_bg_careerBg:setVisible(false)
	elseif self.tabIndexSelected == 2 then
		self:initPageAddition()
		self._commonDialog_cnt_bg_career:setVisible(false)
		self._commonDialog_cnt_bg_careerBg:setVisible(false)
	end

	self._commonDialog_cnt_bg_additionEffectBg:setVisible(self.tabIndexSelected == 2)
	
	self:updateTabNameColor()
end

function DHandBook:updateTabNameColor(  )
	local tabNameList = {
		self._commonDialog_tab_tabNormal_title,
		self._commonDialog_tab_tabAddition_title
	}
	for i,v in ipairs(tabNameList) do
		if self.tabIndexSelected == i then
			v:setFontFillColor(res.tabColor2.selectedTextColor, true)
			v:enableStroke(res.tabColor2.selectedStrokeColor, 2, true)
		else
			v:setFontFillColor(res.tabColor2.unselectTextColor, true)
			v:enableStroke(res.tabColor2.unselectStrokeColor, 2, true)
		end
	end
end

function DHandBook:isCollectionGroupSuccess( pedIdList )
	local result = false
	if self.petIdListCollected then
		result = true
		for k,v in pairs(pedIdList) do
			local canFind = false
			for k2,v2 in pairs(self.petIdListCollected) do
				if v2 == v then
					canFind = true
					break
				end
			end
			if not canFind then
				result = false
				break
			end
		end
	end
	return result
end

function DHandBook:getCollectionCount( starLevelList )
	local count = 0
	if self.petIdListCollected then
		for k,v in pairs(starLevelList) do
			for k2,v2 in pairs(self.petIdListCollected) do
				if v2 == v.id then
					count = count + 1
					break
				end
			end
		end
	end
	return count
end

function DHandBook:getPetsWithCareer( career )
	local list
	if career >= 1 and career <= 4 then
		list = dbManager.getInfoCharactorList(career)
	else
		list = require "charactorConfig"
	end
	-- if career == 0 or career == 1 then
	-- 	for i=#list,1,-1 do
	-- 		if list[i].id == 150001 then
	-- 			table.remove(list, i)
	-- 			break
	-- 		end
	-- 	end
	-- end

	table.sort(list, function ( a, b )
		if a.star_level == b.star_level then
			if a.quality == b.quality then
				if a.skin_id == b.skin_id then
					if a.evove_level == b.evove_level then
						return a.id < b.id
					else
						return a.evove_level < b.evove_level
					end
				else
					return a.skin_id < b.skin_id
				end
			else
				return a.quality > b.quality
			end
		else
			return a.star_level > b.star_level
		end
	end)

	return list
end

function DHandBook:getPetListWithStarLevel( list )
	local result = {}
	for i=2,6 do
		result[i] = {}
	end
	for i,v in ipairs(list) do
		if v.star_level >= 2 and v.star_level <= 6 then
			table.insert(result[v.star_level], v)
		end
	end
	return result
end

function DHandBook:getPetInCollectionGroupList( petId, offset )
	if not self.groupPetList then
		self.groupPetList = {}
		local groupList = dbManager.getInfoCollectionGroupConfig()
		for i,v in ipairs(groupList) do
			for i2,v2 in ipairs(v.Group) do
				local dbPet = dbManager.getCharactor(v2)
				if dbPet and (dbPet.star_level ~= 6) and self:isCollectionGroupSuccess({[1] = v2}) then
					table.insert(self.groupPetList, v2)
				end
			end
		end
	end

	local index = 0
	for i,v in ipairs(self.groupPetList) do
		if v == petId then
			index = i
			break
		end
	end
	if index ~= 0 then
		if index + offset >= 1 and index + offset <= #self.groupPetList then
			return self.groupPetList[index + offset]
		end
	end
	return 0
end

function DHandBook:getPetIdInCareerList( petId, offset, career )
	local list0 = self:getPetsWithCareer(career)
	local list = {}
	for i,v in ipairs(list0) do
		if self:isCollectionGroupSuccess({[1] = v.id}) then
			table.insert(list, v)
		end
	end

	local index = 0
	for i,v in ipairs(list) do
		if v.id == petId then
			index = i
			break
		end
	end
	if index ~= 0 then
		if index + offset >= 1 and index + offset <= #list then
			return list[index + offset].id
		end
	end
	return 0	
end

function DHandBook:updateArchivedPet( petStateList )
	petStateList = petStateList or {}
	if self.additionItemList then
		for key,v in pairs(petStateList) do
			for k,itemSet in pairs(self.additionItemList) do
				if key == k then
					self:updateItem(dbManager.getCharactor(k), itemSet, true)
					break
				end
			end	
		end
	end
	if self.normalItemList then
		for key,v in pairs(petStateList) do
			for k,itemSet in pairs(self.normalItemList) do
				if key == k then
					self:updateItem(dbManager.getCharactor(k), itemSet, false)
					break
				end
			end	
		end
	end
end

function DHandBook:setNodeWithUnknown( rootNode )
	rootNode:setResid("")
	rootNode:removeAllChildrenWithCleanup(true)

	local bg = ElfNode:create()
	bg:setResid(res.getPetIconBg(nil))
	rootNode:addChild(bg)

	local icon = ElfNode:create()
	icon:setResid("FB_wenti.png")
	icon:setPosition(ccp(0, -12))
	rootNode:addChild(icon)

	local frame = ElfNode:create()
	frame:setResid(res.getPetIconFrame(nil))
	rootNode:addChild(frame)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DHandBook, "DHandBook")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DHandBook", DHandBook)


