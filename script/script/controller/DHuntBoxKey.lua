local Config = require "Config"
local LuaList = require "LuaList"
local res = require "Res"
local GuildCopyFunc = require "GuildCopyInfo"
local HuntHelper = require "HuntHelper"
local EventCenter = require "EventCenter"
local dbManager = require "DBManager"

local DHuntBoxKey = class(LuaDialog)

function DHuntBoxKey:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DHuntBoxKey.cocos.zip")
    return self._factory:createDocument("DHuntBoxKey.cocos")
end

--@@@@[[[[
function DHuntBoxKey:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getJoint9Node("bg")
    self._bg_title_text = set:getLabelNode("bg_title_text")
    self._bg_box = set:getElfNode("bg_box")
    self._bg_layoutKey = set:getLayoutNode("bg_layoutKey")
    self._icon = set:getElfNode("icon")
    self._count = set:getLabelNode("count")
    self._icon = set:getElfNode("icon")
    self._count = set:getLabelNode("count")
    self._icon = set:getElfNode("icon")
    self._count = set:getLabelNode("count")
    self._icon = set:getElfNode("icon")
    self._count = set:getLabelNode("count")
    self._icon = set:getElfNode("icon")
    self._count = set:getLabelNode("count")
    self._bg_list = set:getListNode("bg_list")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._key = set:getLabelNode("key")
    self._path = set:getLabelNode("path")
    self._btn = set:getButtonNode("btn")
    self._bg_processBase = set:getElfNode("bg_processBase")
    self._bg_bg0 = set:getElfNode("bg_bg0")
    self._pro = set:getLinearLayoutNode("pro")
    self._pro_l = set:getElfNode("pro_l")
    self._pro_pro0 = set:getElfNode("pro_pro0")
    self._pro_r = set:getElfNode("pro_r")
    self._percent = set:getLabelNode("percent")
--    self._@itemKey = set:getElfNode("@itemKey")
--    self._@itemKey = set:getElfNode("@itemKey")
--    self._@itemKey = set:getElfNode("@itemKey")
--    self._@itemKey = set:getElfNode("@itemKey")
--    self._@itemKey = set:getElfNode("@itemKey")
--    self._@itemPath = set:getElfNode("@itemPath")
--    self._@process = set:getElfNode("@process")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DHuntBoxKey:onInit( userData, netData )
	self.boxIndex = userData and userData.boxIndex

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)
	self:updateLayer()

	res.doActionDialogShow(self._bg)
end

function DHuntBoxKey:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DHuntBoxKey:updateLayer( ... )
	self.keyInfoList = GuildCopyFunc.getGuildCopyKeyDict(self.boxIndex)

	self._bg_box:setResid(string.format("N_SLC_BZ_wenzi%d.png", self.boxIndex))
	self._bg_layoutKey:removeAllChildrenWithCleanup(true)
	local ownAmount = 0
	for i,v in ipairs(self.keyInfoList) do
		local itemKey = self:createLuaSet("@itemKey")
		self._bg_layoutKey:addChild(itemKey[1])
		res.setNodeWithKey(itemKey["icon"], v.PropId)
		itemKey["count"]:setString(string.format("%d/%d", v.Own, v.Amount))
		if v.Own >= v.Amount then
			itemKey["count"]:setFontFillColor(ccc4f(0.45, 0.66, 0.314, 1), true)
			ownAmount = ownAmount + 1
		else
			itemKey["count"]:setFontFillColor(ccc4f(0.71, 0.243, 0.23, 1), true)
		end
	end

	self._bg_processBase:removeAllChildrenWithCleanup(true)
	local process = self:createLuaSet("@process")
	self._bg_processBase:addChild(process[1])
	HuntHelper.updateProcess(process, 120, ownAmount / #self.keyInfoList)

	self:updateList()
end

function DHuntBoxKey:updateList( ... )
	local klist = {
		[2] = "GrassKeySource",
		[3] = "ElectricKeySource",
		[6] = "WaterKeySource",
		[7] = "StoneKeySource",
		[8] = "FireKeySource"
	}

	self.pathList = LuaList.new(self._bg_list, function ( ... )
		return self:createLuaSet("@itemPath")
	end, function ( nodeLuaSet, data )
		local propId = data.PropId
		res.setNodeWithKey(nodeLuaSet["icon"], propId)
		nodeLuaSet["key"]:setString( res.locString(string.format("Hunt$key%d", propId)) )
		nodeLuaSet["path"]:setString( dbManager.getInfoDefaultConfig(klist[propId]).Des )
		nodeLuaSet["btn"]:setListener(function ( ... )
			local temp = {[2] = 1, [3] = 2, [6] = 3, [7] = 4, [8] = 5}
			EventCenter.eventInput("GoToHunt", {AreaId = temp[propId]})
			res.doActionDialogHide(self._bg, self)
		end)
	end)

	self.pathList:update(self.keyInfoList)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DHuntBoxKey, "DHuntBoxKey")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DHuntBoxKey", DHuntBoxKey)


