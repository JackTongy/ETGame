local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"

local DMibaoDetail1 = class(LuaDialog)

function DMibaoDetail1:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DMibaoDetail1.cocos.zip")
    return self._factory:createDocument("DMibaoDetail1.cocos")
end

--@@@@[[[[
function DMibaoDetail1:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._root = set:getElfNode("root")
    self._root_icon = set:getElfNode("root_icon")
    self._root_name = set:getLabelNode("root_name")
    self._root_careerLabel = set:getLinearLayoutNode("root_careerLabel")
    self._root_careerLabel_label = set:getLabelNode("root_careerLabel_label")
    self._root_careerLabel_layoutProperty = set:getLayoutNode("root_careerLabel_layoutProperty")
    self._root_refineLvLabel = set:getLinearLayoutNode("root_refineLvLabel")
    self._root_refineLvLabel_value = set:getElfNode("root_refineLvLabel_value")
    self._root_layoutPro1 = set:getLinearLayoutNode("root_layoutPro1")
    self._root_layoutPro1_key = set:getLabelNode("root_layoutPro1_key")
    self._root_layoutPro1_value = set:getLabelNode("root_layoutPro1_value")
    self._root_layoutLv = set:getLinearLayoutNode("root_layoutLv")
    self._root_layoutLv_value = set:getLabelNode("root_layoutLv_value")
    self._root_layoutAtk = set:getLinearLayoutNode("root_layoutAtk")
    self._root_layoutAtk_key = set:getLabelNode("root_layoutAtk_key")
    self._root_layoutAtk_value = set:getLabelNode("root_layoutAtk_value")
    self._root_layoutAddition = set:getLinearLayoutNode("root_layoutAddition")
    self._root_layoutAddition_key = set:getLabelNode("root_layoutAddition_key")
    self._root_layoutAddition_value = set:getLabelNode("root_layoutAddition_value")
    self._root_addition = set:getLabelNode("root_addition")
    self._root_layout_btnImprove = set:getClickNode("root_layout_btnImprove")
    self._root_layout_btnImprove_text = set:getLabelNode("root_layout_btnImprove_text")
    self._root_layout_btnClose = set:getClickNode("root_layout_btnClose")
    self._root_layout_btnClose_text = set:getLabelNode("root_layout_btnClose_text")
    self._root_proList = set:getListNode("root_proList")
    self._index = set:getLabelNode("index")
    self._des = set:getLabelNode("des")
--    self._@mbCareer = set:getElfNode("@mbCareer")
--    self._@mbProperty = set:getElfNode("@mbProperty")
--    self._@proItem = set:getElfNode("@proItem")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DMibaoDetail1:onInit( userData, netData )
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
	if lvIconRes then
		self._root_refineLvLabel:setVisible(true)
		self._root_refineLvLabel_value:setResid(lvIconRes)
	else
		self._root_refineLvLabel:setVisible(false)
	end

	self._root_addition:setVisible(nTreasure.Addition > 0)

	-- self._root_layoutExp_value:setString(dbTreasure.Effect)
	self._root_layoutLv_value:setString(string.format("%d/%d", nTreasure.Lv, dbManager.getInfoMibaoLvLimit( dbTreasure.Star )))

	if nTreasure.RefineLv and nTreasure.RefineLv>0 then
		self._root_layoutPro1_value:setString(string.format("+%d",require "Toolkit".getMibaoRefineProAdd(nTreasure)))
		self._root_layoutPro1:setVisible(true)
	else
		self._root_layoutPro1:setVisible(false)
	end

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
		self._root_layoutPro1_key:setString(res.locString("Global$Atk"))
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
		self._root_layoutPro1_key:setString(res.locString("Global$Hp"))
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
	if needImprove then
		self._root_layout_btnImprove:setListener(function (  )
			res.doActionDialogHide(self._root, function (  )
				self:close()
				GleeCore:showLayer("DMibaoOp",{Info = nTreasure})
			end)
		end)
	else
		self._root_layout_btnImprove:removeFromParentAndCleanup(true)
	end

	local refineConfigs = dbManager.getInfoMibaoRefineConfigs(dbTreasure.Type,dbTreasure.Star)
	for _,v in ipairs(refineConfigs) do
		if v.Unlock and string.len(v.Unlock)>0 then
			local proItemSet = self:createLuaSet("@proItem")
			local lv1,lv2 = math.floor(v.RefineLv/10),v.RefineLv%10
			proItemSet["index"]:setString(string.format("%s+%d",lv1>0 and res.locString("Mibao$RefineLvDes"..lv1) or "",lv2))
			local w = proItemSet["index"]:getContentSize().width
			proItemSet["des"]:setDimensions(CCSize(300-w-10,0))
			proItemSet["des"]:setString(v.Unlock)
			local h = proItemSet["des"]:getContentSize().height
			proItemSet[1]:setContentSize(CCSize(300,h+5))
			proItemSet["index"]:setPosition(-150,h/2-proItemSet["index"]:getContentSize().height/2)
			local color = nTreasure.RefineLv>=v.RefineLv and ccc4f(1,0.95,0.8,1) or ccc4f(0.5,0.5,0.5,1)
			proItemSet["index"]:setFontFillColor(color,true)
			proItemSet["des"]:setFontFillColor(color,true)
			self._root_proList:getContainer():addChild(proItemSet[1])
		end
	end

	res.doActionDialogShow(self._root)
end

function DMibaoDetail1:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DMibaoDetail1, "DMibaoDetail1")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DMibaoDetail1", DMibaoDetail1)


