local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local Toolkit = require "Toolkit"

local DEquipSuccinct = class(LuaDialog)

function DEquipSuccinct:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DEquipSuccinct.cocos.zip")
    return self._factory:createDocument("DEquipSuccinct.cocos")
end

--@@@@[[[[
function DEquipSuccinct:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._root = set:getElfNode("root")
   self._root_bg2_old = set:getLabelNode("root_bg2_old")
   self._root_bg2_new = set:getLabelNode("root_bg2_new")
   self._root_layoutCost = set:getLinearLayoutNode("root_layoutCost")
   self._root_layoutCost_v = set:getLabelNode("root_layoutCost_v")
   self._root_btnRestore = set:getClickNode("root_btnRestore")
   self._root_btnOk = set:getClickNode("root_btnOk")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DEquipSuccinct:onInit( userData, netData )
	local cost = dbManager.getInfoDefaultConfig("EqRestoreCost").Value
	local name, value = Toolkit.getEquipPropText(userData.oldProp)
	self._root_bg2_old:setString(name .. "+" .. value)
	name, value = Toolkit.getEquipPropText(userData.newProp)
	self._root_bg2_new:setString(name .. "+" .. value)
	self._root_layoutCost_v:setString(cost)	

	self._root_btnRestore:setListener(function ( ... )
		if userData.callbackRestore(cost) then
			res.doActionDialogHide(self._root, self)
		end
	end)

	self._root_btnOk:setListener(function ( ... )
		userData.callback()
		res.doActionDialogHide(self._root, self)
	end)

	res.doActionDialogShow(self._root)
end

function DEquipSuccinct:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DEquipSuccinct, "DEquipSuccinct")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DEquipSuccinct", DEquipSuccinct)
