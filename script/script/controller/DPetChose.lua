local Config = require "Config"
local gameFunc = require "AppData"
local res = require "Res"
local dbManager = require "DBManager"
local GuideHelper = require 'GuideHelper'

local DPetChose = class(LuaDialog)

function DPetChose:createDocument()
		self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPetChose.cocos.zip")
		return self._factory:createDocument("DPetChose.cocos")
end

--@@@@[[[[
function DPetChose:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg = set:getElfNode("root_bg")
   self._root_topBar_ftpos_tabs = set:getLinearLayoutNode("root_topBar_ftpos_tabs")
   self._root_topBar_ftpos_tabs_tab = set:getTabNode("root_topBar_ftpos_tabs_tab")
   self._root_topBar_ftpos_tabs_tab_normal_v = set:getLabelNode("root_topBar_ftpos_tabs_tab_normal_v")
   self._root_topBar_ftpos_tabs_tab_pressed_v = set:getLabelNode("root_topBar_ftpos_tabs_tab_pressed_v")
   self._root_topBar_ftpos2_close = set:getButtonNode("root_topBar_ftpos2_close")
   self._root_content = set:getElfNode("root_content")
   self._root_list = set:getListNode("root_list")
   self._pet = set:getElfNode("pet")
   self._pet_pzbg = set:getElfNode("pet_pzbg")
   self._pet_icon = set:getElfNode("pet_icon")
   self._pet_pz = set:getElfNode("pet_pz")
   self._pet_property = set:getElfNode("pet_property")
   self._pet_career = set:getElfNode("pet_career")
   self._starLayout = set:getLayoutNode("starLayout")
   self._nameBg = set:getElfNode("nameBg")
   self._name = set:getLabelNode("name")
   self._Quality = set:getLabelNode("Quality")
   self._Lv = set:getLabelNode("Lv")
   self._Atk = set:getLabelNode("Atk")
   self._Hp = set:getLabelNode("Hp")
   self._btnSelect = set:getClickNode("btnSelect")
   self._btnSelect_title = set:getLabelNode("btnSelect_title")
   self._onTeam = set:getElfNode("onTeam")
   self._select = set:getElfNode("select")
--   self._@size = set:getElfNode("@size")
--   self._@star = set:getElfNode("@star")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DPetChose:onInit( userData, netData )
	-- needRemove 需要排序的精灵ID列表
	-- updatePetEvent  选择精灵后的回调函数，为nil时则无回掉
	-- selectPetID 所要选择的精灵类型
	require 'LangAdapter'.fontSize(self._root_topBar_ftpos_tabs_tab_pressed_v,nil,nil,24,nil,24,nil,nil,nil,nil,20)
	require 'LangAdapter'.fontSize(self._root_topBar_ftpos_tabs_tab_normal_v,nil,nil,24,nil,24,nil,nil,nil,nil,20)

	print('userData:')
	print(userData)
	self.selectPetID = userData.selectPetID
	self.needRemove = userData.needRemove
	self.updatePetEvent = userData.funcChosePet
	self.offloadPetId = userData.offloadPetId
	self.lowup = userData.lowup
	self.selected = userData.selected
	self.petTypeId = userData.petTypeId
	self.petlist = userData.petlist
	self.sortFunc = userData.sortFunc

	local size = CCDirector:sharedDirector():getWinSize()
	self._root_list:setContentSize(CCSize(size.width, self._root_list:getHeight()))
	self._root_bg:setScaleX(size.width / self._root_bg:getWidth())
	self:setListenerEvent()

	self:updatePetList()
	res.doActionDialogShow(self._root,function ( ... )
		GuideHelper:check('CPetChose')
	end)
	
	self._root_topBar_ftpos_tabs_tab:trigger(nil)

	require "EventCenter".addEventFunc("PetChoseClose", function ( ... )
		res.doActionDialogHide(self._root, self)
	end, "DPetChose")
end

function DPetChose:onBack( userData, netData )
	
end

function DPetChose:close( ... )
	require "EventCenter".resetGroup("DPetChose")
end

--------------------------------custom code-----------------------------

function DPetChose:setListenerEvent(  )
	self._root_topBar_ftpos2_close:setTriggleSound(res.Sound.back)
	self._root_topBar_ftpos2_close:setListener(function (  )
		res.doActionDialogHide(self._root, self)
	end)  
end

function DPetChose:getListData(  )
	local petFunc = gameFunc.getPetInfo()
	if not self.petlist then
		petFunc.sortPetList()
	end

	local itemListData = self.petlist or petFunc.getPetList()
	local temp = {}
	local selecteds = {}
	if itemListData then
		if self.offloadPetId and self.offloadPetId > 0 then
			table.insert(temp, petFunc.getPetWithId(self.offloadPetId))
			for i,v in ipairs(itemListData) do
				if v.Id ~= self.offloadPetId then
					table.insert(temp, v)
				end
			end   
		else
			temp = table.clone(itemListData)
		end
		for i=#temp,1,-1 do
			if self.needRemove then
				if table.find(self.needRemove, temp[i].Id) then
					table.remove(temp, i)
				end
			end
			if self.selectPetID and temp[i] and temp[i].PetId ~= self.selectPetID then
				table.remove(temp,i)
			end
			if temp[i] and self.selected and table.find(self.selected,temp[i].Id) then
				table.insert(selecteds,temp[i])
				table.remove(temp,i)
			end
		end
		
		if self.petTypeId then
			for i=#temp,1,-1 do
				if temp[i].PetId ~= self.petTypeId then
					table.remove(temp,i)
				end
			end
		end
	end

	if self.lowup and #temp > 1 then
		petFunc.sortPetListInMix(temp)
	end

	if self.sortFunc then
		self.sortFunc(temp)
	end

	if selecteds and #selecteds then
		for k,v in pairs(selecteds) do
			table.insert(temp,1,v)
		end
	end

	return temp
end

function DPetChose:updatePetList(  )
	self._root_list:stopAllActions()
	self._root_list:getContainer():removeAllChildrenWithCleanup(true)

	local itemListData = self:getListData()
	local firstset
	for i,v in ipairs(itemListData) do
		if i <= 7 then
			local itemSet = self:createLuaSet("@size")
			self:refreshCell(itemSet,v)
			self._root_list:getContainer():addChild(itemSet[1])
			if i == 1 then
				firstset = itemSet
			end
		else
			self:runWithDelay(function ( ... )
				local itemSet = self:createLuaSet("@size")
				self:refreshCell(itemSet,v)
				self._root_list:getContainer():addChild(itemSet[1])
			end,0.1*(i-7),self._root_list)
		end 
	end

	self._root_list:layout()
	if firstset then
		GuideHelper:registerPoint('选中精灵',firstset['btnSelect'])
	end
end

function DPetChose:refreshCell( itemSet,nPet )
	local dbPet = dbManager.getCharactor(nPet.PetId)
	if dbPet then
		itemSet['name']:setString(res.getPetNameWithSuffix(nPet))
		itemSet['pet_pz']:setResid(res.getPetPZ(nPet.AwakeIndex))
		itemSet['pet_icon']:setResid(res.getPetIcon(nPet.PetId))
		itemSet["pet_property"]:setResid(res.getPetPropertyIcon(dbPet.prop_1,true))
		itemSet["pet_career"]:setResid(res.getPetCareerIcon(dbPet.atk_method_system))
		require 'PetNodeHelper'.updateStarLayout(itemSet['starLayout'],dbPet)
		
		local petFunc = gameFunc.getPetInfo()
		itemSet['onTeam']:setVisible(petFunc.isPetInActiveTeam(nPet.Id))
		itemSet["Quality"]:setString(dbPet.quality)
		
		local userInfo = gameFunc.getUserInfo()
		-- local levelCapTable = dbManager.getInfoRoleLevelCap(userInfo.getLevel())
		itemSet["Lv"]:setString(string.format("%d/%d", nPet.Lv, dbManager.getPetLvCap(nPet)))
		itemSet["Atk"]:setString(nPet.Atk)
		itemSet["Hp"]:setString(nPet.Hp)

		itemSet["btnSelect"]:setListener(function (  )
			if self.updatePetEvent then
				if self.updatePetEvent(nPet.Id) then
					self:close()
				end
			end
			GuideHelper:check('ChoseDone')
		end)
		itemSet["btnSelect"]:setTouchGiveUpOnMoveOrOutOfRange(true)
		-- itemSet["offloadBg"]:setVisible(self.offloadPetId and self.offloadPetId == nPet.Id)
		if self.offloadPetId and self.offloadPetId == nPet.Id then
			itemSet["btnSelect_title"]:setString(res.locString("Pet$TeamOffload"))
		else
			itemSet["btnSelect_title"]:setString(res.locString("Pet$TouchSelect"))
		end

		if self.selected then
			local found = table.find(self.selected,nPet.Id)
			itemSet['select']:setVisible(found)
			itemSet['btnSelect']:setEnabled(not found)
		end

	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPetChose, "DPetChose")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPetChose", DPetChose)
