local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local DMibaoDetail = class(LuaDialog)

function DMibaoDetail:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DMibaoDetail.cocos.zip")
    return self._factory:createDocument("DMibaoDetail.cocos")
end

--@@@@[[[[
function DMibaoDetail:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._root = set:getElfNode("root")
    self._root_icon = set:getElfNode("root_icon")
    self._root_name = set:getLabelNode("root_name")
    self._root_careerLabel = set:getLinearLayoutNode("root_careerLabel")
    self._root_careerLabel_label = set:getLabelNode("root_careerLabel_label")
    self._root_careerLabel_layoutProperty = set:getLayoutNode("root_careerLabel_layoutProperty")
    self._root_layoutLv = set:getLinearLayoutNode("root_layoutLv")
    self._root_layoutLv_value = set:getLabelNode("root_layoutLv_value")
    self._root_layoutAtk = set:getLinearLayoutNode("root_layoutAtk")
    self._root_layoutAtk_key = set:getLabelNode("root_layoutAtk_key")
    self._root_layoutAtk_value = set:getLabelNode("root_layoutAtk_value")
    self._root_layoutAddition = set:getLinearLayoutNode("root_layoutAddition")
    self._root_layoutAddition_key = set:getLabelNode("root_layoutAddition_key")
    self._root_layoutAddition_value = set:getLabelNode("root_layoutAddition_value")
    self._root_layoutExp = set:getLinearLayoutNode("root_layoutExp")
    self._root_layoutExp_value = set:getLabelNode("root_layoutExp_value")
    self._root_addition = set:getLabelNode("root_addition")
    self._root_layout_btnImprove = set:getClickNode("root_layout_btnImprove")
    self._root_layout_btnImprove_text = set:getLabelNode("root_layout_btnImprove_text")
    self._root_layout_btnClose = set:getClickNode("root_layout_btnClose")
    self._root_layout_btnClose_text = set:getLabelNode("root_layout_btnClose_text")
--    self._@mbCareer = set:getElfNode("@mbCareer")
--    self._@mbProperty = set:getElfNode("@mbProperty")
end
--@@@@]]]]

local Launcher = require 'Launcher'

Launcher.register('DMibaoDetail',function ( userData )
	local nTreasure = userData.Data
	local dbTreasure = dbManager.getInfoTreasure(nTreasure.MibaoId)
	if dbTreasure.Type<3 and dbTreasure.Star>2 then
		GleeCore:showLayer("DMibaoDetail1",userData)
	else
		Launcher.Launching()
	end
end)

--------------------------------override functions----------------------
--userData:{Data = mibaoData,NeedImprove = true/false}
function DMibaoDetail:onInit( userData, netData )
	require 'LangAdapter'.LabelNodeAutoShrink(self._root_layout_btnImprove_text,120)
	require 'LangAdapter'.LabelNodeAutoShrink(self._root_layout_btnClose_text,120)
	
	local nTreasure = userData.Data
	local needImprove = userData.NeedImprove
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._root, self)
	end)

	local dbTreasure = dbManager.getInfoTreasure(nTreasure.MibaoId)
	res.setNodeWithTreasure(self._root_icon, nTreasure)
	local name,lvIconRes = require "Toolkit".getMibaoName(nTreasure)
	self._root_name:setString(name)

	self._root_layoutExp:setVisible(dbTreasure.Type == 3)
	self._root_layoutLv:setVisible(dbTreasure.Type ~= 3)
	self._root_layoutAtk:setVisible(dbTreasure.Type ~= 3)
	self._root_layoutAddition:setVisible(dbTreasure.Type ~= 3)
	self._root_addition:setVisible(dbTreasure.Type ~= 3 and nTreasure.Addition > 0)

	self._root_layoutExp_value:setString(dbTreasure.Effect)
	self._root_layoutLv_value:setString(string.format("%d/%d", nTreasure.Lv, dbManager.getInfoMibaoLvLimit( dbTreasure.Star )))

	if dbTreasure.Type == 1 then
		local propertyString = ""
		if dbTreasure.Property and #dbTreasure.Property>0 then
			self._root_careerLabel_label:setString(res.locString("Global$Pro"))
			for i,v in ipairs(dbTreasure.Property) do
				if v > 0 then
					local mbProperty = self:createLuaSet("@mbProperty")
					self._root_careerLabel_layoutProperty:addChild(mbProperty[1])
					mbProperty[1]:setResid( res.getPetPropertyIcon( v, true ) )
					propertyString = propertyString .. res.locString(string.format("PetCC$_Prop%d", v))
				end
			end
			self._root_careerLabel:setVisible(true)
		else
			self._root_careerLabel:setVisible(false)
		end
		self._root_layoutAtk_key:setString(res.locString("Global$Atk"))
		self._root_layoutAtk_value:setString(string.format("+%g%%", nTreasure.Effect * 100))

		self._root_layoutAddition_key:setString( string.format(res.locString("Bag$TreasureAddition"), res.locString("Global$Atk")) )
		if nTreasure.Addition > 0 then
			self._root_layoutAddition_value:setString( string.format("+%g%%", nTreasure.Addition * 100))
			self._root_addition:setString(string.format(res.locString("Bag$TreasureAdditionTip"), propertyString))
		else
			self._root_layoutAddition_value:setString( res.locString("Bag$TreasureAdditionNo") )
		end
	elseif dbTreasure.Type == 2 then
		local careerString = ""
		if dbTreasure.Property and #dbTreasure.Property>0 then
			self._root_careerLabel_label:setString(res.locString("PetDetail$CareerTitle"))
			for i,v in ipairs(dbTreasure.Property) do
				if v > 0 then
					local mbCareer = self:createLuaSet("@mbCareer")
					self._root_careerLabel_layoutProperty:addChild(mbCareer[1])
					mbCareer[1]:setResid( res.getPetCareerIcon( v ) )
					careerString = careerString .. res.locString(string.format("Bag$Treasure%d", v))
				end
			end
			self._root_careerLabel:setVisible(true)
		else
			self._root_careerLabel:setVisible(false)
		end
		self._root_layoutAtk_key:setString(res.locString("Global$Hp"))
		self._root_layoutAtk_value:setString(string.format("+%g%%", nTreasure.Effect * 100))

		self._root_layoutAddition_key:setString( string.format(res.locString("Bag$TreasureAddition"), res.locString("Global$Hp")) )
		if nTreasure.Addition > 0 then
			self._root_layoutAddition_value:setString( string.format("+%g%%", nTreasure.Addition * 100))
			self._root_addition:setString(string.format(res.locString("Bag$TreasureAdditionTip"), careerString))
		else
			self._root_layoutAddition_value:setString( res.locString("Bag$TreasureAdditionNo") )
		end
	end	

	self._root_layout_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._root, self)
	end)
	if needImprove and dbTreasure.Type~=3 then
		self._root_layout_btnImprove:setListener(function (  )
			res.doActionDialogHide(self._root, function (  )
				self:close()
				GleeCore:showLayer("DMibaoOp",{Info = nTreasure})
			end)
		end)
	else
		self._root_layout_btnImprove:removeFromParentAndCleanup(true)
	end

	res.doActionDialogShow(self._root)
end

function DMibaoDetail:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DMibaoDetail, "DMibaoDetail")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DMibaoDetail", DMibaoDetail)


