local Config = require "Config"
local LuaList = require "LuaList"
local res = require "Res"
local dbManager = require "DBManager"
local toolkit = require "Toolkit"
local calculateTool = require "CalculateTool"
local gameFunc = require "AppData"
local netModel = require "netModel"
local PerlBookInfo = gameFunc.getPerlBookInfo()

local DCareerBall = class(LuaDialog)

function DCareerBall:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DCareerBall.cocos.zip")
    return self._factory:createDocument("DCareerBall.cocos")
end

--@@@@[[[[
function DCareerBall:onInitXML()
	local set = self._set
    self._root = set:getElfNode("root")
    self._root_bg = set:getElfNode("root_bg")
    self._root_ftpos_tabBg_name = set:getLabelNode("root_ftpos_tabBg_name")
    self._root_ftpos_list = set:getListNode("root_ftpos_list")
    self._icon = set:getElfNode("icon")
    self._nameBg_name = set:getLabelNode("nameBg_name")
    self._des = set:getLabelNode("des")
    self._select = set:getElfNode("select")
    self._btnDetail = set:getClickNode("btnDetail")
    self._root_ftpos2_close = set:getButtonNode("root_ftpos2_close")
    self._root_ftpos3_bgMagicBox = set:getJoint9Node("root_ftpos3_bgMagicBox")
    self._root_ftpos3_bgMagicBox_layout = set:getLinearLayoutNode("root_ftpos3_bgMagicBox_layout")
    self._root_ftpos3_bgMagicBox_layout_value = set:getLabelNode("root_ftpos3_bgMagicBox_layout_value")
    self._root_ftpos4_btnOk = set:getClickNode("root_ftpos4_btnOk")
    self._root_ftpos4_btnOk_text = set:getLabelNode("root_ftpos4_btnOk_text")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DCareerBall:onInit( userData, netData )
	self.mOriginalList = userData.SelectedList
	self.mSelectList = {}
	if userData.SelectedList then
		for i,v in ipairs(userData.SelectedList) do
			table.insert(self.mSelectList, v)
		end
	end
	self.mOnCompleted = userData.OnCompleted

	self:setListenerEvent()
	self:updateLayer()

	res.doActionDialogShow(self._root)

	require "LangAdapter".fontSize(self._root_ftpos_tabBg_name, nil, nil, nil, nil, 16)

	require "LangAdapter".LabelNodeAutoShrink(self._root_ftpos4_btnOk_text, 108)
end

function DCareerBall:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function DCareerBall:setListenerEvent( ... )
	self._root_ftpos2_close:setListener(function ( ... )
		self.mSelectList = self.mOriginalList
		self._root_ftpos_list:stopAllActions()
		res.doActionDialogHide(self._root, self)
	end)

	self._root_ftpos4_btnOk:setListener(function ( ... )
		if self.mOnCompleted then
			self.mOnCompleted(self.mSelectList)
		end
		self._root_ftpos_list:stopAllActions()
		res.doActionDialogHide(self._root, self)
	end)
end

function DCareerBall:updateLayer(  )
	local winSize = CCDirector:sharedDirector():getWinSize()
	self._root_bg:setScaleX(winSize.width / self._root_bg:getWidth())
		
	self._root_ftpos_list:setContentSize(CCSize(winSize.width, self._root_ftpos_list:getHeight()))
	self:updateList()
	self:updateSelectCount()
end

function DCareerBall:updateList(  )
	if not self.mList then
		self.mList = LuaList.new(self._root_ftpos_list, function ( ... )
			return self:createLuaSet("@item")
		end, function ( nodeLuaSet, data, listIndex )
			self:updateCell(nodeLuaSet, data)
		end)
	end
	self.mList:update( PerlBookInfo.getPerlsWithSingle() )
end

function DCareerBall:updateCell( nodeLuaSet, nPerl )
	local dbPerl = dbManager.getInfoPerlConfig(nPerl.Pid)
	res.setNodeWithBall(nodeLuaSet["icon"], dbPerl)
	nodeLuaSet["nameBg_name"]:setString(dbPerl.name)
	nodeLuaSet["des"]:setString(dbPerl.tips)
	require "LangAdapter".fontSize(nodeLuaSet["des"], nil, nil, 16, nil, 18, nil, nil, 15)

	local key,isSelected
	for k,v in pairs(self.mSelectList) do
		if v.Id == nPerl.Id and v._index == nPerl._index then
			key = k
			isSelected = true
			break
		end
	end

	nodeLuaSet["select"]:setVisible(isSelected)
	nodeLuaSet["btnDetail"]:setListener(function ( ... )
		if isSelected then
			isSelected = false
			self:onUnCheck(nPerl)
		else
			if self.mSelectList and #self.mSelectList >= 4 then
				self:toast(res.locString("Mibao$MultiChooseCountLimitTip"))
				return
			else
				isSelected = true
				self:onCheck(nPerl)
			end
		end
		nodeLuaSet["select"]:setVisible(isSelected)
	end)
end

function DCareerBall:onCheck( v )
	table.insert(self.mSelectList,v)
	self:updateSelectCount()
end

function DCareerBall:onUnCheck( v )
	for i = #self.mSelectList, 1, -1 do
		local vv = self.mSelectList[i]
		if vv.Id == v.Id then
			table.remove(self.mSelectList, i)
			break
		end
	end
	self:updateSelectCount()
end

function DCareerBall:updateSelectCount( ... )
	self._root_ftpos3_bgMagicBox_layout_value:setString(string.format("%d/%d",#self.mSelectList, 4))
	self._root_ftpos3_bgMagicBox_layout:layout()
	res.adjustNodeWidth(self._root_ftpos3_bgMagicBox_layout, 190)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DCareerBall, "DCareerBall")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DCareerBall", DCareerBall)


