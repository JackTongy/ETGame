local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local toolkit = require "Toolkit"
local calculateTool = require "CalculateTool"
local gameFunc = require "AppData"
local equipFunc = gameFunc.getEquipInfo()
local netModel = require "netModel"
local LangAdapter = require "LangAdapter"

local DEquipDetail = class(LuaDialog)

function DEquipDetail:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DEquipDetail.cocos.zip")
    return self._factory:createDocument("DEquipDetail.cocos")
end

--@@@@[[[[
function DEquipDetail:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._root = set:getElfNode("root")
   self._root_bg1 = set:getElfNode("root_bg1")
   self._root_bg1_baseRoot = set:getElfNode("root_bg1_baseRoot")
   self._bg = set:getElfNode("bg")
   self._bg_icon = set:getElfNode("bg_icon")
   self._bg_name = set:getLabelNode("bg_name")
   self._bg_lv = set:getLabelNode("bg_lv")
   self._bg_rank = set:getLabelNode("bg_rank")
   self._bg_titleEquipFor_equipFor = set:getLabelNode("bg_titleEquipFor_equipFor")
   self._bg_btnAuth = set:getButtonNode("bg_btnAuth")
   self._bg_btnAuth_text = set:getRichLabelNode("bg_btnAuth_text")
   self._bg_layoutL = set:getLinearLayoutNode("bg_layoutL")
   self._name = set:getLabelNode("name")
   self._value = set:getLabelNode("value")
   self._bg_layoutR = set:getLinearLayoutNode("bg_layoutR")
   self._name = set:getLabelNode("name")
   self._value = set:getLabelNode("value")
   self._bg_layoutL2 = set:getLinearLayoutNode("bg_layoutL2")
   self._name = set:getLabelNode("name")
   self._value = set:getLabelNode("value")
   self._bg_layoutR2 = set:getLinearLayoutNode("bg_layoutR2")
   self._name = set:getLabelNode("name")
   self._value = set:getLabelNode("value")
   self._root_bg2 = set:getElfNode("root_bg2")
   self._root_bg2_baseRoot = set:getElfNode("root_bg2_baseRoot")
   self._root_bg2_baseRoot2 = set:getElfNode("root_bg2_baseRoot2")
   self._career = set:getElfNode("career")
   self._titleSet = set:getLabelNode("titleSet")
   self._bg = set:getElfNode("bg")
   self._bg_icon1 = set:getElfNode("bg_icon1")
   self._bg_title1 = set:getLabelNode("bg_title1")
   self._bg_icon2 = set:getElfNode("bg_icon2")
   self._bg_title2 = set:getLabelNode("bg_title2")
   self._bg_icon3 = set:getElfNode("bg_icon3")
   self._bg_title3 = set:getLabelNode("bg_title3")
   self._bg_icon4 = set:getElfNode("bg_icon4")
   self._bg_title4 = set:getLabelNode("bg_title4")
   self._bg_icon5 = set:getElfNode("bg_icon5")
   self._bg_title5 = set:getLabelNode("bg_title5")
   self._bg_icon6 = set:getElfNode("bg_icon6")
   self._bg_title6 = set:getLabelNode("bg_title6")
   self._bg_equipCount3 = set:getLabelNode("bg_equipCount3")
   self._bg_equipCount4 = set:getLabelNode("bg_equipCount4")
   self._bg_equipCount5 = set:getLabelNode("bg_equipCount5")
   self._bg_equipCount6 = set:getLabelNode("bg_equipCount6")
   self._root_btnOffLoad = set:getClickNode("root_btnOffLoad")
   self._root_btnOffLoad_text = set:getLabelNode("root_btnOffLoad_text")
   self._root_btnImprove = set:getClickNode("root_btnImprove")
   self._root_btnImprove_text = set:getLabelNode("root_btnImprove_text")
   self._root_btnImprove2 = set:getClickNode("root_btnImprove2")
   self._root_btnImprove2_text = set:getLabelNode("root_btnImprove2_text")
   self._root_btnChange = set:getClickNode("root_btnChange")
   self._root_btnChange_text = set:getLabelNode("root_btnChange_text")
   self._root_btnChose = set:getClickNode("root_btnChose")
   self._root_btnChose_text = set:getLabelNode("root_btnChose_text")
   self._root_btnClose = set:getClickNode("root_btnClose")
   self._root_btnClose_text = set:getLabelNode("root_btnClose_text")
   self._root_btnNext = set:getClickNode("root_btnNext")
   self._root_btnNext_text = set:getLabelNode("root_btnNext_text")
   self._root_btnShare = set:getButtonNode("root_btnShare")
--   self._@equipBase = set:getElfNode("@equipBase")
--   self._@base = set:getElfNode("@base")
--   self._@equipProBar = set:getLinearLayoutNode("@equipProBar")
--   self._@equipProBar = set:getLinearLayoutNode("@equipProBar")
--   self._@equipProBar = set:getLinearLayoutNode("@equipProBar")
--   self._@equipProBar = set:getLinearLayoutNode("@equipProBar")
--   self._@equipSet = set:getElfNode("@equipSet")
--   self._@equipSetAnim = set:getSimpleAnimateNode("@equipSetAnim")
end
--@@@@]]]]

--[[
	mode: "Mode_OffLoad", "Mode_Change", "Mode_Improve", "Mode_Chose", "Mode_Auth"
]]

--------------------------------override functions----------------------
function DEquipDetail:onInit( userData, netData )
	self.nEquip = userData.nEquip
	self.mode = userData.mode
	self.callback = userData.callback
	self.EquipList = userData.EquipList
	self.improveCallback = userData.improveCallback
	self.arenaEquipData = userData.arenaEquipData

	self:updateLayer()
	self:setListenerEvent()

	res.doActionDialogShow(self._root)
end

function DEquipDetail:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DEquipDetail:setListenerEvent( ... )
	require 'LangAdapter'.fontSize(self._root_btnImprove_text, nil, nil, nil, nil, nil, nil, nil, 18)
	require 'LangAdapter'.fontSize(self._root_btnImprove2_text, nil, nil, nil, nil, nil, nil, nil, 18)

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._root, self)
	end)

	self._root_btnOffLoad:setListener(function ( ... )
		if self.callback then
			self.callback()
		end
		res.doActionDialogHide(self._root, self)
	end)

	self._root_btnImprove:setListener(function ( ... )
		res.doActionDialogHide(self._root, self)
		if self.improveCallback then
			self.improveCallback()
		end
		GleeCore:showLayer("DEquipOp", {EquipInfo = self.nEquip, EquipList = self.EquipList})
	end)
	
	self._root_btnImprove2:setListener(function ( ... )
		res.doActionDialogHide(self._root, self)
		GleeCore:showLayer("DEquipOp", {EquipInfo = self.nEquip, EquipList = self.EquipList})
	end)
	
	self._root_btnChange:setListener(function ( ... )
		if self.callback then
			self.callback()
		end
		res.doActionDialogHide(self._root, self)
	end)
	
	self._root_btnChose:setListener(function ( ... )
		if self.callback then
			self.callback()
		end
		res.doActionDialogHide(self._root, self)
	end)

	self._root_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._root, self)
	end)

	self._root_btnNext:setListener(function ( ... )
		local index = table.keyOfItem(self.EquipList, self.nEquip)
		self.nEquip = self.EquipList[math.min(index + 1, #self.EquipList)]
		self.authPropAddi = true
		self:updateLayer()
	end)

	self._root_btnShare:setVisible(self.mode ~= nil)
	self._root_btnShare:setListener(function ( ... )
		local unlockLv = require "UnlockManager":getUnlockLv("Chat")
		if require "UserInfo".getLevel()<unlockLv then
			return self:toast(string.format(res.locString("Chat$ToastLvlimit"),unlockLv))
		else
			local content = require "ChatInfo".createShareContent(2,self.nEquip.Id)
			self:send(netModel.getmodelChatSend(1,content,"",2,self.nEquip.Id),function ( data )
				return self:toast(res.locString("Global$ShareSuc"))
			end)
		end
	end)
end

function DEquipDetail:updateLayer(  )
	local nEquip = self.nEquip
	local dbEquip = dbManager.getInfoEquipment(nEquip.EquipmentId)
	self._root_bg1:setVisible(dbEquip.set == 0)
	self._root_bg2:setVisible(dbEquip.set ~= 0)
	if dbEquip.set == 0 then
		local equipBase = self:createLuaSet("@equipBase")
		self._root_bg1_baseRoot:removeAllChildrenWithCleanup(true)
		self._root_bg1_baseRoot:addChild(equipBase[1])
		self:updateEquipBase(equipBase, nEquip)

		self._root_btnShare:setPosition(ccp(148.57141,205.14282))
	else
		local equipBase = self:createLuaSet("@equipBase")
		self._root_bg2_baseRoot:removeAllChildrenWithCleanup(true)
		self._root_bg2_baseRoot:addChild(equipBase[1])
		self:updateEquipBase(equipBase, nEquip)

		local equipSet = self:createLuaSet("@equipSet")
		self._root_bg2_baseRoot2:removeAllChildrenWithCleanup(true)
		self._root_bg2_baseRoot2:addChild(equipSet[1])
		self:updateEquipSet(equipSet, nEquip)

		self._root_btnShare:setPosition(ccp(366.85715,199.42857))
	end

	self._root_btnOffLoad:setVisible(self.mode == "Mode_OffLoad")
	self._root_btnImprove:setVisible(self.mode == "Mode_OffLoad")
	self._root_btnChange:setVisible(self.mode == "Mode_Change")
	self._root_btnImprove2:setVisible(self.mode == "Mode_Improve")
	self._root_btnChose:setVisible(self.mode == "Mode_Chose")
	self._root_btnClose:setVisible(self.mode == "Mode_Auth")
	self._root_btnNext:setVisible(self.mode == "Mode_Auth" and self.EquipList[#self.EquipList] ~= self.nEquip)
	if not self._root_btnNext:isVisible() then
		self._root_btnClose:setPosition(ccp(0.0,-215))
	end
end

function DEquipDetail:updateEquipBase( equipBase, nEquip )
	local dbEquip = dbManager.getInfoEquipment(nEquip.EquipmentId)

	equipBase[1]:removeAllChildrenWithCleanup(true)
	local baseSet = self:createLuaSet("@base")
	equipBase[1]:addChild(baseSet[1])
	LangAdapter.fontSize(baseSet["bg_#titlePro"], nil, nil, 16)

	res.setEquipDetail(baseSet["bg_icon"],nEquip, nil, self.arenaEquipData and self.arenaEquipData.runeList or nil)
	local name = dbEquip.name
	if nEquip.Tp and nEquip.Tp>0 then
		name = name.."+"..nEquip.Tp
	end
	baseSet["bg_name"]:setString(name)
	local levelMax = toolkit.getEquipLevelCap(nEquip)
	baseSet["bg_lv"]:setString(string.format("%d/%d",nEquip.Lv,levelMax))
	baseSet["bg_rank"]:setString(res.getEquipRankText(equipFunc.getRank( nEquip )))

	require "LangAdapter".LayoutChildrenReverseWithChildIfArabic(baseSet["bg_lv"])
	require "LangAdapter".LayoutChildrenReverseWithChildIfArabic(baseSet["bg_rank"])

	if self.arenaEquipData then
		baseSet["bg_#titleEquipFor"]:setVisible(true)
		local dbPet = dbManager.getCharactor(self.arenaEquipData.nPet.PetId)
		baseSet["bg_titleEquipFor_equipFor"]:setString(dbPet.name)
	else
		self.petEquippedOn = toolkit.setEquipSetInLabel(nil,nEquip,function ( ret )
			if ret then
				baseSet["bg_#titleEquipFor"]:setVisible(true)
				baseSet["bg_titleEquipFor_equipFor"]:setString(ret)
			else
				baseSet["bg_#titleEquipFor"]:setVisible(false)
			end
		end)
	end

	local function findProbar( pos,index )
		local layout = pos == 0 and baseSet["bg_layoutL"] or baseSet["bg_layoutR"]
		local children = layout:getChildren()
		if not children or children:count()<index+1 then
			local temp = self:createLuaSet("@equipProBar")
			layout:addChild(temp[1])
			require "LangAdapter".LayoutChildrenReverseifArabic(temp[1])
			children =  layout:getChildren()
		end
		local bar = children:objectAtIndex(index)
		tolua.cast(bar,"ElfNode")
		return bar
	end

	-- 装备属性
	if self.authPropAddi == nil then
		self.authPropAddi = self.mode == "Mode_Auth"
	end

	local index = 0
	local function updateProBar( name,value,valueColor )
		local pos,i = index%2,math.floor(index/2)
		local bar = findProbar(pos,i)
		local temp = bar:findNodeByName("name")
		tolua.cast(temp,"LabelNode")
		temp:setString(name)
		temp = bar:findNodeByName("value")
		tolua.cast(temp,"LabelNode")
		temp:setString(value)
		if valueColor then
			temp:setFontFillColor(valueColor,true)
		end
		index = index + 1
	end

	local isAuthed = nEquip.Props and #nEquip.Props > 0
	baseSet["bg_btnAuth"]:setEnabled(isAuthed)
	if isAuthed then
		if self.authPropAddi then
			baseSet["bg_btnAuth_text"]:setString(res.locString("Equip$AuthPropType2"))
			baseSet["bg_btnAuth_text"]:setFontFillColor(ccc4f(0.16, 0.588, 1, 0.66), true)
		else
			baseSet["bg_btnAuth_text"]:setString(res.locString("Equip$AuthPropType1"))
			baseSet["bg_btnAuth_text"]:setFontFillColor(res.color4F.white, true)
		end
		baseSet["bg_btnAuth"]:setListener(function ( ... )
			self.authPropAddi = not self.authPropAddi
			self:updateEquipBase( equipBase, nEquip )
		end)
	else
		baseSet["bg_btnAuth_text"]:setString(res.locString("Equip$AuthUnFinish"))
	end
	require 'LangAdapter'.selectLang(nil,nil,nil,nil,function ( ... )
		baseSet["bg_btnAuth"]:setPosition(ccp(70,-21.428566))
	end, function ( ... )
		-- 不能删除，防止引用英文处理
	end, function ( ... )
		-- 不能删除，防止引用英文处理
	end)


	if isAuthed and self.authPropAddi then
		for i,v in ipairs(nEquip.Props) do
			local baseNode = i % 2  == 1 and baseSet["bg_layoutL"] or baseSet["bg_layoutR"]
			local equipProBar = self:createLuaSet("@equipProBar")
			baseNode:addChild(equipProBar[1])
			local name, value = toolkit.getEquipPropText(v)
			equipProBar["name"]:setString(name)
			equipProBar["value"]:setString(value)

			LangAdapter.fontSize(equipProBar["name"], nil, nil, 16, nil, 16)
			LangAdapter.fontSize(equipProBar["value"], nil, nil, 16, nil, 16)
			-- equipProBar["name"]:setFontFillColor(ccc4f(0.66, 0.16, 0.588, 1), true)
			-- equipProBar["value"]:setFontFillColor(ccc4f(0.66, 0.16, 0.588, 1), true)
		end
	else
		local pros = toolkit.getEquipProList(nEquip)
		for i,pro in ipairs(pros) do
			local baseNode = i % 2  == 1 and baseSet["bg_layoutL"] or baseSet["bg_layoutR"]
			local equipProBar = self:createLuaSet("@equipProBar")
			baseNode:addChild(equipProBar[1])
			equipProBar["name"]:setString(toolkit.getEquipProName(pro))
			equipProBar["value"]:setString(string.format("%s",calculateTool.getEquipProDataStrByEquipInfo(nEquip,pro)))
			LangAdapter.fontSize(equipProBar["name"], nil, nil, 16, nil, 16)
			LangAdapter.fontSize(equipProBar["value"], nil, nil, 16, nil, 16)

			local growth = calculateTool.getEquipProGrowth(nEquip,pro)
			if growth ~= 0 then
				local baseNode = i % 2  == 1 and baseSet["bg_layoutL2"] or baseSet["bg_layoutR2"]
				local equipProBar = self:createLuaSet("@equipProBar")
				baseNode:addChild(equipProBar[1])
				equipProBar["name"]:setString(string.format("%s%s",toolkit.getEquipProName(pro),res.locString("Global$GrowStatus")))
				equipProBar["value"]:setString(string.format("%.2f",growth))
				LangAdapter.fontSize(equipProBar["name"], nil, nil, 16, nil, 16)
				LangAdapter.fontSize(equipProBar["value"], nil, nil, 16, nil, 16)
			end
		end
	end

	local pros = toolkit.getEquipProList(nEquip)
	for i=1,#pros do
		local pro = pros[i]
		updateProBar(toolkit.getEquipProName(pro),string.format("%s",calculateTool.getEquipProDataStrByEquipInfo(nEquip,pro)))
		local growth = calculateTool.getEquipProGrowth(nEquip,pro)
		if growth ~= 0 then
			if require 'Config'.LangName == "Arabic" then
				updateProBar(string.format("%s",toolkit.getEquipProName(pro)),string.format("+%.2f",growth))
			else
				updateProBar(string.format("%s%s",toolkit.getEquipProName(pro), "+"),string.format("%.2f",growth))
			end	
		end
	end

	-- 符文加成
	local runeList
	if not (isAuthed and self.authPropAddi) then
		runeList = self.arenaEquipData and self.arenaEquipData.runeList or require "RuneInfo".selectByCondition(function ( nRune )
			return nRune.SetIn == nEquip.Id
		end)
	end

	if runeList then
		local showList = {}
		for i,nRune in ipairs(runeList) do
			local dbRune = dbManager.getInfoRune(nRune.RuneId)
			table.insert(showList, {key = res.locString(string.format("Rune$RuneType%d", dbRune.Location)), value = calculateTool.getRuneBaseProValue(nRune)})
		end
		local temp = {}
		for i,nRune in ipairs(runeList) do
			for _,v2 in pairs(nRune.Buffs) do
				if temp[v2.Type] then
					temp[v2.Type] = temp[v2.Type] + tonumber(v2.Value)
				else
					temp[v2.Type] = tonumber(v2.Value)
				end
			end
		end
		for tk,tv in pairs(temp) do
			table.insert(showList, {key = res.locString(string.format("Rune$RuneBuff%s", tk)), value = tv >= 0 and string.format("%g%%",math.floor(tv*1000)/10) or "?"})
		end

		for i,v in ipairs(showList) do
			local baseNode = i % 2  == 1 and baseSet["bg_layoutL2"] or baseSet["bg_layoutR2"]
			local equipProBar = self:createLuaSet("@equipProBar")
			baseNode:addChild(equipProBar[1])
			equipProBar["name"]:setString(v.key)
			equipProBar["value"]:setString(v.value)
			LangAdapter.fontSize(equipProBar["name"], nil, nil, 16, nil, 16)
			LangAdapter.fontSize(equipProBar["value"], nil, nil, 16, nil, 16)
		end
	end
end

function DEquipDetail:updateEquipSet( equipSet, nEquip )
	local dbEquip = dbManager.getInfoEquipment(nEquip.EquipmentId)
	local equipSetInfo = dbManager.getInfoEquipSet( dbEquip.set )
	if equipSetInfo then
		local setList = dbManager.getInfoEquipSetList(dbEquip.set)
		table.sort(setList,function ( a,b )
			return a.location < b.location
		end)

		local equipSetInCount = 1
		local equipIndex = {}
		for i,v in ipairs(setList) do
			require 'LangAdapter'.selectLang(nil, nil, function ( ... )
				equipSet[string.format("bg_title%d", i)]:setVisible(false)
			end, nil, nil, nil, nil, nil, function ( ... )
				equipSet[string.format("bg_title%d", i)]:setDimensions(CCSize(0,0))
				require 'LangAdapter'.LabelNodeAutoShrink(equipSet[string.format("bg_title%d", i)], 102)
			end, function ( ... )
				equipSet[string.format("bg_title%d", i)]:setFontSize(16)
			end)
			equipSet[string.format("bg_title%d", i)]:setString(setList[i].name)
			equipSet[string.format("bg_title%d", i)]:setFontFillColor(res.getEquipColor(setList[i].color),true)
			local icon = equipSet[string.format("bg_icon%d", i)]

			if setList[i].equipmentid ~= nEquip.EquipmentId then
				local theEquip = dbManager.getInfoEquipment(setList[i].equipmentid)
				local isSetIn = self:isEquipSetInPet(setList[i].equipmentid)
				if isSetIn then
					equipSetInCount = equipSetInCount + 1
					equipIndex[#equipIndex+1] = i

					res.setNodeWithEquip( icon, theEquip )
				else
					res.setNodeWithEquipGray( icon, theEquip )
				--	equipSet[string.format("bg_icon%d", i)]:setOpacity(255 * 0.5)
				end
			else
				res.setNodeWithEquip( icon, dbEquip )
				equipIndex[#equipIndex+1] = i
			end
		end
		if equipSetInCount>=3 then
			for _,v in ipairs(equipIndex) do
				local icon =  equipSet[string.format("bg_icon%d", v)]
				local anim = self:createLuaSet("@equipSetAnim")[1]
				-- local x,y = icon:getPosition()
				-- anim:setPosition(x-2,y)
				anim:setOrder(10)
				anim:setLoops(-1)
				icon:addChild(anim)
				anim:start()
			end
		end
		equipSet["career"]:setVisible(dbEquip.career > 0)
		if dbEquip.career > 0 then
			equipSet["career"]:setResid(res.getPetCareerIcon(dbEquip.career))
		end
		equipSet["titleSet"]:setString(string.format("%s %d/%d",equipSetInfo.name,equipSetInCount,#setList))

		for i=3,6 do
			local effectType,value = self:findEquipSetEffect(equipSetInfo,i)
			if value<1 then
				value = math.ceil(value*100)
			end
			local des = string.format(res.locString(string.format("Equip$SetEffect_%s",effectType)),value)
			local node = equipSet[string.format("bg_equipCount%d",i)]
			node:setString(string.format("%s%s",string.format(res.locString("Equip$SetEffectPre"),i),des))
			node:setFontFillColor(equipSetInCount>=i and ccc4f(0.996,0.945,0.823,1.0) or ccc4f(0.6, 0.6, 0.6, 0.5), true)
		end
	end
end

function DEquipDetail:findEquipSetEffect( info,cnt )
	local effects = {"atk","hp","def","broken","crit","speed","cure"}
	for _,v in ipairs(effects) do
		local data = info[v][cnt-2]
		if data>0 then
			return v,data
		end
	end
end

function DEquipDetail:isEquipSetInPet( equipmentId )
	local equipList
	if self.arenaEquipData then
		equipList = self.arenaEquipData.equipListOnPet
	else
		equipList = self.petEquippedOn and gameFunc.getEquipInfo().getEquipListWithPetId(self.petEquippedOn.Id)
	end
	if equipList then
		for k,v in pairs(equipList) do
			if v.EquipmentId == equipmentId then
				return true
			end
		end
	end
	return false
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DEquipDetail, "DEquipDetail")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DEquipDetail", DEquipDetail)

return DEquipDetail

