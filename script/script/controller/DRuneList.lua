local Config = require "Config"
local Res = require "Res"
local Toolkit = require "Toolkit"

local DRuneList = class(LuaDialog)

function DRuneList:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DRuneList.cocos.zip")
    return self._factory:createDocument("DRuneList.cocos")
end

--@@@@[[[[
function DRuneList:onInitXML()
	local set = self._set
    self._root = set:getElfNode("root")
    self._root_bg = set:getElfNode("root_bg")
    self._root_ftpos_layoutList = set:getLinearLayoutNode("root_ftpos_layoutList")
    self._root_ftpos_layoutList_list = set:getListNode("root_ftpos_layoutList_list")
    self._cur = set:getElfNode("cur")
    self._btnDetail = set:getButtonNode("btnDetail")
    self._icon = set:getElfNode("icon")
    self._isEquiped = set:getElfNode("isEquiped")
    self._nameBg_name = set:getLabelNode("nameBg_name")
    self._basePro_key = set:getLabelNode("basePro_key")
    self._basePro_value = set:getLabelNode("basePro_value")
    self._layout = set:getLinearLayoutNode("layout")
    self._name = set:getLabelNode("name")
    self._text = set:getLabelNode("text")
    self._root_ftpos2_close = set:getButtonNode("root_ftpos2_close")
--    self._@size = set:getElfNode("@size")
--    self._@layoutName = set:getLinearLayoutNode("@layoutName")
--    self._@btnImprove = set:getClickNode("@btnImprove")
--    self._@btnOk = set:getClickNode("@btnOk")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DRuneList:onInit( userData, netData )
	self.mListData = userData.ListData
	self.mCurRune = userData.CurRune
	self.mCallback = userData.Callback

	local winSize = CCDirector:sharedDirector():getWinSize()
	self._root_bg:setScaleX(winSize.width / self._root_bg:getWidth())
	self._root_ftpos_layoutList_list:setContentSize(CCSize(winSize.width, self._root_ftpos_layoutList_list:getHeight()))

	self:addBtnListener()
	self:updateView()

	Res.doActionDialogShow(self._root)
end

function DRuneList:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function DRuneList:addBtnListener( ... )
	self._root_ftpos2_close:setListener(function ( ... )
		Res.doActionDialogHide(self._root, self)
	end)
end

function DRuneList:updateView( ... )
	for i=1,#self.mListData do
		if i<7 then
			self:updateListItem(self.mListData[i])
		else
			self:runWithDelay(function ( ... )
				self:updateListItem(self.mListData[i])
			end,0.1*(i-6))
		end
	end
	self._root_ftpos_layoutList_list:alignTo(0)
end

function DRuneList:updateListItem( data )
	local dbinfo = require "DBManager".getInfoRune(data.RuneId)
	local set = self:createLuaSet("@size")
	local isCur = self.mCurRune and  self.mCurRune.Id == data.Id
	set["cur"]:setVisible(isCur)
	set["btnDetail"]:setListener(function ( ... )
		GleeCore:showLayer("DRuneDetail",{RuneData = data})
	end)
	Res.setNodeWithRune(set["icon"],data.RuneId,data.Star,data.Lv)
	set["isEquiped"]:setVisible(isCur)
	set["nameBg_name"]:setString(Toolkit.getRuneName(data.RuneId,data.Lv))

	set["basePro_key"]:setString(Res.locString(string.format("Rune$RuneType%d",dbinfo.Location)))
	set["basePro_value"]:setString(require "CalculateTool".getRuneBaseProValue(data))

	if data.SetIn and data.SetIn>0 then
		local e = self:createLuaSet("@layoutName")
		e["name"]:setString(Toolkit.getEquipNameById(data.SetIn))
		set["layout"]:addChild(e[1])
	end

	if isCur then
		local btnSet = self:createLuaSet("@btnImprove")
		btnSet[1]:setListener(function ( ... )
			self:close()
			GleeCore:showLayer("DRuneOp",{RuneData = data})
		end)
		set["layout"]:addChild(btnSet[1])

		require "LangAdapter".LabelNodeAutoShrink(btnSet["#text"], 110)
	end

	local btnSet = self:createLuaSet("@btnOk")
	if isCur then
		btnSet["text"]:setString(Res.locString("PetGem$_GetOff"))
	else
		if self.mCurRune then
			btnSet["text"]:setString(Res.locString("Equip$Change"))
		else
			btnSet["text"]:setString(Res.locString("Equip$Set"))
		end
	end
	btnSet[1]:setListener(function (  )
		self.mCallback(data)
		self:close()
	end)

	set["layout"]:addChild(btnSet[1])
	require "LangAdapter".LabelNodeAutoShrink(btnSet["text"], 110)

	self._root_ftpos_layoutList_list:addListItem(set[1])
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DRuneList, "DRuneList")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DRuneList", DRuneList)


