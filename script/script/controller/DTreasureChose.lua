local Config = require "Config"
local LuaList = require "LuaList"
local res = require "Res"
local dbManager = require "DBManager"
local toolkit = require "Toolkit"

local DTreasureChose = class(LuaDialog)

function DTreasureChose:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DTreasureChose.cocos.zip")
    return self._factory:createDocument("DTreasureChose.cocos")
end

--@@@@[[[[
function DTreasureChose:onInitXML()
	local set = self._set
    self._root = set:getElfNode("root")
    self._root_bg = set:getElfNode("root_bg")
    self._root_ftpos_tabBg_icon = set:getElfNode("root_ftpos_tabBg_icon")
    self._root_ftpos_tabBg_name = set:getLabelNode("root_ftpos_tabBg_name")
    self._root_ftpos_layoutList = set:getLinearLayoutNode("root_ftpos_layoutList")
    self._root_ftpos_layoutList_list = set:getListNode("root_ftpos_layoutList_list")
    self._btnDetail = set:getButtonNode("btnDetail")
    self._icon = set:getElfNode("icon")
    self._layoutProperty = set:getLayoutNode("layoutProperty")
    self._isEquiped = set:getElfNode("isEquiped")
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
    self._layoutName = set:getLinearLayoutNode("layoutName")
    self._layoutName_name = set:getLabelNode("layoutName_name")
    self._btnEquip = set:getClickNode("btnEquip")
    self._btnEquip_text = set:getLabelNode("btnEquip_text")
    self._btnImprove = set:getClickNode("btnImprove")
    self._root_ftpos2_close = set:getButtonNode("root_ftpos2_close")
--    self._@size = set:getElfNode("@size")
--    self._@mbCareer = set:getElfNode("@mbCareer")
--    self._@mbProperty = set:getElfNode("@mbProperty")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DTreasureChose:onInit( userData, netData )
	self.type = userData.treasureType
	self.nTreasure = userData.nTreasure
	self.treasureDataList = userData.treasureList
	self.updateTreasureEvent = userData.updateTreasureEvent

	self:setListenerEvent()
	self:updateLayer()
	res.doActionDialogShow(self._root)
end

function DTreasureChose:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DTreasureChose:setListenerEvent(  )
	self._root_ftpos2_close:setListener(function ( ... )
		self._root_ftpos_layoutList_list:stopAllActions()
		res.doActionDialogHide(self._root, self)
	end)
end

function DTreasureChose:updateLayer( ... )
	local winSize = CCDirector:sharedDirector():getWinSize()
	self._root_bg:setScaleX(winSize.width / self._root_bg:getWidth())

	self._root_ftpos_tabBg_icon:setResid(res.getMibaoTypeRes(self.type))
	self._root_ftpos_tabBg_name:setString(res.locString(string.format("Global$MibaoType%dTitle", self.type)))
	
	local listWitdh = winSize.width
	if self.nTreasure then
		local set = self:createLuaSet("@size")
		self._root_ftpos_layoutList:addChild(set[1], -1)
		self:updateCell(set, self.nTreasure, true)
		listWitdh = listWitdh - set[1]:getWidth()
	end
	self._root_ftpos_layoutList_list:setContentSize(CCSize(listWitdh, self._root_ftpos_layoutList_list:getHeight()))
	self:updateList(true)
end

function DTreasureChose:updateList( refresh )
	if not self.treasureNodeList then
		self.treasureNodeList = LuaList.new(self._root_ftpos_layoutList_list, function ( ... )
			return self:createLuaSet("@size")
		end, function ( nodeLuaSet, nTreasure )
			self:updateCell( nodeLuaSet, nTreasure, false)
		end)
	end
	self.treasureNodeList:update(self.treasureDataList, refresh or false)
end

function DTreasureChose:updateCell( nodeLuaSet, nTreasure, isEquiped )
	local dbTreasure = dbManager.getInfoTreasure(nTreasure.MibaoId)
	if dbTreasure then
		-- nodeLuaSet["bg2"]:setVisible(isEquiped)
		nodeLuaSet["isEquiped"]:setVisible(isEquiped)
		res.setNodeWithTreasure(nodeLuaSet["icon"], nTreasure)
		nodeLuaSet["nameBg_name"]:setString(require "Toolkit".getMibaoName(nTreasure))

		nodeLuaSet["layoutExp"]:setVisible(dbTreasure.Type == 3)
		nodeLuaSet["layoutLv"]:setVisible(dbTreasure.Type ~= 3)
		nodeLuaSet["layoutAtk"]:setVisible(dbTreasure.Type ~= 3)
		nodeLuaSet["layoutAddition"]:setVisible(dbTreasure.Type ~= 3)
		nodeLuaSet["addition"]:setVisible(dbTreasure.Type ~= 3 and nTreasure.Addition > 0)

		local setInInfo = toolkit.getMibaoSetInInfo(nTreasure)
		nodeLuaSet["layoutName"]:setVisible(setInInfo.text ~= nil)
		if setInInfo.text then
			nodeLuaSet["layoutName_name"]:setString( setInInfo.text )
		end

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
				require 'LangAdapter'.fontSize(nodeLuaSet["addition"],nil,nil,18)
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
				require 'LangAdapter'.fontSize(nodeLuaSet["addition"],nil,nil,18)
			else
				nodeLuaSet["layoutAddition_value"]:setString( res.locString("Bag$TreasureAdditionNo") )
			end
		end	
		nodeLuaSet["btnEquip"]:setListener(function ( ... )
			if self.updateTreasureEvent then
				self.updateTreasureEvent(nTreasure.Id)
			end
			self._root_ftpos_layoutList_list:stopAllActions()
			res.doActionDialogHide(self._root, self)
		end)
		nodeLuaSet["btnEquip"]:setVisible(not isEquiped)
		nodeLuaSet["btnImprove"]:setVisible(isEquiped)
		nodeLuaSet["btnImprove"]:setListener(function ( ... )
			res.doActionDialogHide(self._root, self)
			local treasureList = require "MibaoInfo".getMibaoListWithPetId( setInInfo.nPet.Id )
			GleeCore:showLayer("DMibaoOp", {Info = nTreasure, List = #treasureList > 1 and treasureList or nil})
		end)
		nodeLuaSet["btnDetail"]:setEnabled(true)
		nodeLuaSet["btnDetail"]:setListener(function ( ... )
			GleeCore:showLayer("DMibaoDetail", {Data = nTreasure})
		end)

		require "LangAdapter".LabelNodeAutoShrink(nodeLuaSet["btnImprove_#text"], 110)
		require "LangAdapter".LabelNodeAutoShrink(nodeLuaSet["btnEquip_text"], 110)
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DTreasureChose, "DTreasureChose")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DTreasureChose", DTreasureChose)
