local Config = require "Config"
local LuaList = require "LuaList"
local res = require "Res"
local dbManager = require "DBManager"
local gameFunc = require "AppData"
local MibaoFunc = gameFunc.getMibaoInfo()
local netModel = require "netModel"

local DTreasure = class(LuaDialog)

function DTreasure:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DTreasure.cocos.zip")
    return self._factory:createDocument("DTreasure.cocos")
end

--@@@@[[[[
function DTreasure:onInitXML()
	local set = self._set
    self._root = set:getElfNode("root")
    self._root_bg = set:getElfNode("root_bg")
    self._root_ftpos_layoutList = set:getLinearLayoutNode("root_ftpos_layoutList")
    self._root_ftpos_layoutList_list = set:getListNode("root_ftpos_layoutList_list")
    self._btnDetail = set:getButtonNode("btnDetail")
    self._icon = set:getElfNode("icon")
    self._piece = set:getElfNode("piece")
    self._layoutProperty = set:getLayoutNode("layoutProperty")
    self._nameBg_name = set:getLabelNode("nameBg_name")
    self._layoutExp = set:getLinearLayoutNode("layoutExp")
    self._layoutExp_value = set:getLabelNode("layoutExp_value")
    self._layoutLv = set:getLinearLayoutNode("layoutLv")
    self._layoutLv_value = set:getLabelNode("layoutLv_value")
    self._layoutAtk = set:getLinearLayoutNode("layoutAtk")
    self._layoutAtk_key = set:getLabelNode("layoutAtk_key")
    self._layoutAtk_value = set:getLabelNode("layoutAtk_value")
    self._layoutAddition = set:getLinearLayoutNode("layoutAddition")
    self._layoutAddition_key = set:getLabelNode("layoutAddition_key")
    self._layoutAddition_value = set:getLabelNode("layoutAddition_value")
    self._addition = set:getLabelNode("addition")
    self._layoutAmount_v = set:getLabelNode("layoutAmount_v")
    self._btnMerge = set:getClickNode("btnMerge")
    self._btnMerge_text = set:getLabelNode("btnMerge_text")
    self._root_ftpos2_close = set:getButtonNode("root_ftpos2_close")
--    self._@sizeTreasure = set:getElfNode("@sizeTreasure")
--    self._@mbCareer = set:getElfNode("@mbCareer")
--    self._@mbProperty = set:getElfNode("@mbProperty")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DTreasure:onInit( userData, netData )
	self:setListenerEvent()
	self:updateLayer()
	res.doActionDialogShow(self._root)
end

function DTreasure:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DTreasure:setListenerEvent(  )
	self._root_ftpos2_close:setListener(function ( ... )
		self._root_ftpos_layoutList_list:stopAllActions()
		res.doActionDialogHide(self._root, self)
	end)
end

function DTreasure:updateLayer(  )
	local winSize = CCDirector:sharedDirector():getWinSize()
	self._root_bg:setScaleX(winSize.width / self._root_bg:getWidth())
	self._root_ftpos_layoutList_list:setContentSize(CCSize(winSize.width, self._root_ftpos_layoutList_list:getHeight()))
	self:updateList(true)
end

function DTreasure:updateList( refresh )
	if not self.treasureList then
		self.treasureList = LuaList.new(self._root_ftpos_layoutList_list, function ( ... )
			return self:createLuaSet("@sizeTreasure")
		end, function ( nodeLuaSet, nTreasure, listIndex )
			local dbTreasure = dbManager.getInfoTreasure(nTreasure.MibaoId)
			if dbTreasure then
				res.setNodeWithTreasure(nodeLuaSet["icon"], dbTreasure)
				nodeLuaSet["nameBg_name"]:setString(require "Toolkit".getMibaoName(nTreasure))

				nodeLuaSet["layoutExp"]:setVisible(dbTreasure.Type == 3)
				nodeLuaSet["layoutLv"]:setVisible(dbTreasure.Type ~= 3)
				nodeLuaSet["layoutAtk"]:setVisible(dbTreasure.Type ~= 3)
				nodeLuaSet["layoutAddition"]:setVisible(dbTreasure.Type ~= 3)
				nodeLuaSet["addition"]:setVisible(dbTreasure.Type ~= 3 and dbTreasure.Addition > 0)
 
				nodeLuaSet["layoutAmount_v"]:setString(string.format("%d/%d", nTreasure.Amount, dbTreasure.PieceNum))
				if nTreasure.Amount < dbTreasure.PieceNum then
					nodeLuaSet["layoutAmount_v"]:setFontFillColor(ccc4f(0.68, 0.16, 0.176, 1.0), true)
				else
					nodeLuaSet["layoutAmount_v"]:setFontFillColor(ccc4f(0.196, 0.49, 0.157, 1.0), true)
				end

				nodeLuaSet["layoutExp_value"]:setString(dbTreasure.Effect)
				nodeLuaSet["layoutLv_value"]:setString(string.format("%d/%d", 1, dbManager.getInfoMibaoLvLimit( dbTreasure.Star )))

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
					nodeLuaSet["layoutAtk_value"]:setString(string.format("+%g%%", dbTreasure.Effect * 100))
		
					nodeLuaSet["layoutAddition_key"]:setString( string.format(res.locString("Bag$TreasureAddition"), res.locString("Global$Atk")) )
					if dbTreasure.Addition > 0 then
						nodeLuaSet["layoutAddition_value"]:setString( string.format("+%g%%", dbTreasure.Addition * 100))
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
					nodeLuaSet["layoutAtk_value"]:setString(string.format("+%g%%", dbTreasure.Effect * 100))

					nodeLuaSet["layoutAddition_key"]:setString( string.format(res.locString("Bag$TreasureAddition"), res.locString("Global$Hp")) )
					if dbTreasure.Addition > 0 then
						nodeLuaSet["layoutAddition_value"]:setString( string.format("+%g%%", dbTreasure.Addition * 100))
						nodeLuaSet["addition"]:setString(string.format(res.locString("Bag$TreasureAdditionTip"), careerString))
						require 'LangAdapter'.fontSize(nodeLuaSet["addition"],nil,nil,18)
					else
						nodeLuaSet["layoutAddition_value"]:setString( res.locString("Bag$TreasureAdditionNo") )
					end
				end	
				nodeLuaSet["btnMerge"]:setEnabled(nTreasure.Amount >= dbTreasure.PieceNum)
				nodeLuaSet["btnMerge"]:setListener(function ( ... )
					self:send(netModel.getMibaoPieceCompose(dbTreasure.Id), function ( data )
						if data and data.D then
							gameFunc.updateResource(data.D.Resource)
							self:updateList()
							res.doActionGetReward(data.D.Reward)
						end
					end)
				end)
				nodeLuaSet["btnDetail"]:setListener(function ( ... )
					GleeCore:showLayer("DMibaoDetail", {Data = MibaoFunc.getMibaoWithDB(nTreasure.MibaoId)})
				end)

				require "LangAdapter".LabelNodeAutoShrink( nodeLuaSet["btnMerge_text"], 106 )
				require "LangAdapter".LabelNodeAutoShrink( nodeLuaSet["nameBg_name"], 134 )
				require 'LangAdapter'.selectLang(nil, nil, nil, nil, nil, nil, nil, nil, nil, function ( ... )
					nodeLuaSet["addition"]:setFontSize(16)
				end)
			end
		end)
	end
	self.treasureList:update(self:getTreasureListData(), refresh or false)
end

function DTreasure:getTreasureListData( ... )
	local list = MibaoFunc.getMibaoPieceList()
	table.sort(list, function ( v1, v2 )
		local dbTreasure1 = dbManager.getInfoTreasure(v1.MibaoId)
		local dbTreasure2 = dbManager.getInfoTreasure(v2.MibaoId)
		local enough1 = v1.Amount >= dbTreasure1.PieceNum
		local enough2 = v2.Amount >= dbTreasure2.PieceNum
		if enough1 == enough2 then
			if dbTreasure1.Star == dbTreasure2.Star then
				return v1.MibaoId < v2.MibaoId
			else
				return dbTreasure1.Star > dbTreasure2.Star
			end
		else
			return enough1
		end
	end)
	return list
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DTreasure, "DTreasure")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DTreasure", DTreasure)
