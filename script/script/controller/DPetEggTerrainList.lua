local Config = require "Config"
local res = require "Res"

local DPetEggTerrainList = class(LuaDialog)

function DPetEggTerrainList:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPetEggTerrainList.cocos.zip")
    return self._factory:createDocument("DPetEggTerrainList.cocos")
end

--@@@@[[[[
function DPetEggTerrainList:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_listBg = set:getJoint9Node("bg_listBg")
    self._bg_listBg_list = set:getListNode("bg_listBg_list")
    self._icon = set:getElfNode("icon")
    self._name = set:getLabelNode("name")
    self._discover = set:getLinearLayoutNode("discover")
    self._discover_title = set:getLabelNode("discover_title")
    self._discover_amount = set:getLabelNode("discover_amount")
    self._bg_allDiscover_amount = set:getLabelNode("bg_allDiscover_amount")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DPetEggTerrainList:onInit( userData, netData )
	res.doActionDialogShow(self._bg)

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	local count = 300
	self._bg_allDiscover_amount:setString(string.format("%d/%d", count - userData.Left, count))

	local listData = {}
	for k,v in pairs(userData.Process) do
		if v > 0 then
			table.insert(listData, {index = tonumber(k), amount = v})
		end
	end
	table.sort(listData, function ( a, b )
		if a.amount == b.amount then
			return a.index < b.index
		else
			return a.amount > b.amount
		end
	end)

	self._bg_listBg_list:getContainer():removeAllChildrenWithCleanup(true)
	for i,v in ipairs(listData) do
		local item = self:createLuaSet("@item")
		self._bg_listBg_list:getContainer():addChild(item[1])
		item["icon"]:setResid(string.format("BB_tubiao%d.png", v.index))
		item["name"]:setString(self:getTerrainName(v.index))
		item["discover_amount"]:setString(v.amount)
	end
end

function DPetEggTerrainList:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DPetEggTerrainList:getTerrainName( index )
	return res.locString(string.format("Dungeon$TerrainName%d", index))
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPetEggTerrainList, "DPetEggTerrainList")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPetEggTerrainList", DPetEggTerrainList)
