local Config = require "Config"
local SwfActionFactory = require "framework.swf.SwfActionFactory"
local Swf = require 'framework.swf.Swf'
local eventCenter = require 'EventCenter'
local dbManager = require "DBManager"
local res = require "Res"
local Toolkit = require 'Toolkit'

local petIdList = {1, 4, 7}
local petList = {
	[petIdList[1]] = {x = -100, y = 0, des = res.locString("Guide$petSkill3")},
	[petIdList[2]] = {x = 360, y = -290, des = res.locString("Guide$petSkill6")},
	[petIdList[3]] = {x = 150, y = 0, des = res.locString("Guide$petSkill9")}
}

local DGuidePetSelect = class(LuaDialog)

function DGuidePetSelect:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGuidePetSelect.cocos.zip")
    return self._factory:createDocument("DGuidePetSelect.cocos")
end

--@@@@[[[[
function DGuidePetSelect:onInitXML()
	local set = self._set
    self._YD_xuanze_bg_1 = set:getElfNode("YD_xuanze_bg_1")
    self._YD_xuanze_bg_2 = set:getElfNode("YD_xuanze_bg_2")
    self._text = set:getLabelNode("text")
    self._btn = set:getClickNode("btn")
    self._btn_normal_text = set:getLabelNode("btn_normal_text")
    self._btn_pressed_text = set:getLabelNode("btn_pressed_text")
    self._btn_invalid_text = set:getLabelNode("btn_invalid_text")
    self._des = set:getLabelNode("des")
    self._text = set:getLabelNode("text")
    self._icon = set:getElfNode("icon")
    self._starLayout = set:getLayoutNode("starLayout")
--    self._@bg = set:getLinearLayoutNode("@bg")
--    self._@btnItem1 = set:getButtonNode("@btnItem1")
--    self._@btnItem2 = set:getButtonNode("@btnItem2")
--    self._@btnItem3 = set:getButtonNode("@btnItem3")
--    self._@icon = set:getElfNode("@icon")
--    self._@detailBg = set:getElfNode("@detailBg")
--    self._@name = set:getElfNode("@name")
--    self._@star5 = set:getSimpleAnimateNode("@star5")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DGuidePetSelect:onInit( userData, netData )
	self.indexSelect = 0
	self.shapeMap = {
		['shape-4'] = '',
		['shape-6'] = '',
		['shape-8'] = '',
		['shape-10'] = '',
		['shape-12'] = '',
		['shape-14'] = '',
		['shape-16'] = '',
		['shape-18'] = '',
		['shape-20'] = '',
		['shape-22'] = '',
		['shape-24'] = '',
		['shape-26'] = '',
		['shape-28'] = '',
		['shape-30'] = '',
	}
	self:initItems()

	self.animBg = RectangleNode:create()
	self.animBg:setContentSize(CCDirector:sharedDirector():getWinSize())
	self.animBg:setColorf(0, 0, 0, 0.8)
	self:getLayer():addChild(self.animBg)

	local rootNode = ElfNode:create()
	self:getLayer():addChild(rootNode)
	rootNode:setScale(CCDirector:sharedDirector():getWinSize().width / 1136)
	
	for i=1,3 do
		self[string.format("swf%d", i)] = Swf.new(string.format("Swf_XuanJueSe%d", i))
		rootNode:addChild( self[string.format("swf%d", i)]:getRootNode() )
	end
	self:playSwf(1, {1, 49})
end

function DGuidePetSelect:onBack( userData, netData )
	
end

function DGuidePetSelect:close(  )
	self.animBg:removeFromParentAndCleanup(true)
	for k,v in pairs(self.nodeList) do
		v[1]:release()
	end
	for i=1,3 do
		self[string.format("swf%d", i)]:getRootNode():removeFromParentAndCleanup(true)
	end
end

--------------------------------custom code-----------------------------

function DGuidePetSelect:initItems(  )
	self.nodeList = {}

	self.nodeList[2] = self:createLuaSet("@bg")

	for i=1,3 do
		local btnItem = self:createLuaSet(string.format("@btnItem%d", i))
		btnItem[1]:setListener(function (  )
			self:actionSelectedIndex(i)
		end)
		self.nodeList[2 + i] = btnItem
	end

	local petId = petIdList[1]
	self.nodeList[6] = self:initPetIcon(petId)
	self.nodeList[7] = self:initPetDetail(petId)
	self.nodeList[8] = self:initPetName(petId)

	petId = petIdList[2]
	self.nodeList[9] = self:initPetIcon(petId)
	self.nodeList[10] = self:initPetDetail(petId)
	self.nodeList[11] = self:initPetName(petId)

	petId = petIdList[3]
	self.nodeList[12] = self:initPetIcon(petId)
	self.nodeList[13] = self:initPetDetail(petId)
	self.nodeList[14] = self:initPetName(petId)

	for k,v in pairs(self.nodeList) do
		v[1]:retain()
	end
end

function DGuidePetSelect:initPetIcon( petId )
	local dbPet = dbManager.getCharactor(petId)
	if dbPet then
		local icon = self:createLuaSet("@icon")
		icon[1]:setResid(string.format("role_%03d.png", petId))
		local dbBattleCharactor = require 'CfgHelper'.getCache('BattleCharactor', 'id', petId)
		icon[1]:setScale(dbBattleCharactor.troop_scale)
	--	icon[1]:setDebug(true)
		icon[1]:setPosition(ccp(petList[petId].x, petList[petId].y))
		return icon
	end
	return nil
end

function DGuidePetSelect:initPetDetail( petId )
	local dbPet = dbManager.getCharactor(petId)
	if dbPet then
		local detailBgSet = self:createLuaSet("@detailBg")
		detailBgSet["des"]:setString(petList[petId].des)
		require "LangAdapter".LabelNodeSetHorizontalAlignmentIfArabic(detailBgSet["des"])
		detailBgSet["btn"]:setListener(function (  )
			print("select " .. petId)
			self:selectPet(petId)
		end)
		return detailBgSet
	end
	return nil
end

function DGuidePetSelect:initPetName( petId )
	local dbPet = dbManager.getCharactor(petId)
	if dbPet then
		local nameSet = self:createLuaSet("@name")
		nameSet["text"]:setString(dbPet.name)
		nameSet["icon"]:setResid(res.getPetPropertyIcon(dbPet.prop_1,true))
		-- nameSet["starLayout"]:removeAllChildrenWithCleanup(true)
		-- for i=1,dbPet.star_level do
		-- 	nameSet["starLayout"]:addChild(self:createLuaSet("@star")[1])
		-- end
		require 'PetNodeHelper'.updateStarLayout(nameSet["starLayout"], dbPet)
		return nameSet
	end
	return nil
end

function DGuidePetSelect:updateItems( index )
	print("start swf" .. index)
	for k,v in pairs(self.nodeList) do
		local x = 0
		local y = 0
		local visible = false
		local scale = 1.0
		local opacity = 255
		local color = ccc3(255, 255, 255)

		local vparent = v[1]:getParent()
		if vparent then
			x, y = vparent:getPosition()
			visible = vparent:isVisible()
			scale = vparent:getScale()
			opacity = vparent:getOpacity()
			color = vparent:getColor()
			v[1]:removeFromParentAndCleanup(false)
		end

		local parent = self[string.format("swf%d", index)]:getNodeByTag(k)
		if parent then
			parent:addChild(v[1])
			print("add node[" .. k .. "]" .. ", visible = " .. tostring(visible) .. ", x = " .. x .. ", y = ".. y ..", scale = " .. scale .. ", opacity = " .. opacity .. ", color.r = " .. color.r .. ", color.g = " .. color.g .. ", color.b = " .. color.b )
			parent:setPosition(ccp(x, y))
			parent:setVisible(visible)
			parent:setScale(scale)
			parent:setOpacity(opacity)
			parent:setColor(color)
		end
	end
end

function DGuidePetSelect:playSwf( index, range )
	for i=1,3 do
		self[string.format("swf%d", i)]:getRootNode():setVisible(index == i)
	end
	self:updateItems(index)
	self[string.format("swf%d", index)]:play(self.shapeMap, range, function (  )
		print("swf" .. index .. " finished!")
		for k,v in pairs(self.nodeList) do
			local vparent = self[string.format("swf%d", index)]:getNodeByTag(k)
			if vparent then
				local x, y = vparent:getPosition()
				local visible = vparent:isVisible()
				local scale = vparent:getScale()
				local opacity = vparent:getOpacity()
				local color = vparent:getColor()
				print("check node[" .. k .. "]" .. ", visible = " .. tostring(visible) .. ", x = " .. x .. ", y = ".. y ..", scale = " .. scale .. ", opacity = " .. opacity .. ", color.r = " .. color.r .. ", color.g = " .. color.g .. ", color.b = " .. color.b )
			end
		end
		self:setTouchEnabled(true)
	end)
end

function DGuidePetSelect:actionSelectedIndex( index )
	self:setTouchEnabled(false)
	if self.indexSelect == 0 then
		self:playSwf(index, {49, 75})
	elseif self.indexSelect == 1 then
		if index == 2 then
			self:playSwf(1, {80, 108})	
		elseif index == 3 then
			self:playSwf(2, {107, 136})
		end
	elseif self.indexSelect == 2 then
		if index == 1 then
			self:playSwf(3, {113, 148})
		elseif index == 3 then
			self:playSwf(1, {110, 133})
		end
	elseif self.indexSelect == 3 then
		if index == 1 then
			self:playSwf(2, {130, 170})
		elseif index == 2 then
			self:playSwf(3, {84, 113})
		end
	end
	self.indexSelect = index

	Toolkit.playPetVoice(petIdList[index])
end

function DGuidePetSelect:setTouchEnabled( enable )
	CCDirector:sharedDirector():getTouchDispatcher():setDispatchEvents(enable);
end

function DGuidePetSelect:selectPet( PetId )
	local AppData 	= require 'AppData'
	local netModel 	= require 'netModel'
	self:send(netModel.getRoleChooseHero(PetId),function ( data )
		if data.D then
			local userinfo = AppData.getUserInfo()
			userinfo.setData(data.D.Role)

			local teaminfo = AppData.getTeamInfo()
			teaminfo.setTeamList(data.D.Teams)

			local petinfo = AppData.getPetInfo()
			petinfo.setPet(data.D.Pet)
			
			require 'GuideHelper':check('selectRole')
			self:close()
		end
	end)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGuidePetSelect, "DGuidePetSelect")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGuidePetSelect", DGuidePetSelect)


