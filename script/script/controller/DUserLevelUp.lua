local Config = require "Config"

local DUserLevelUp = class(LuaDialog)

function DUserLevelUp:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DUserLevelUp.cocos.zip")
    return self._factory:createDocument("DUserLevelUp.cocos")
end

--@@@@[[[[
function DUserLevelUp:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_dialog = set:getElfNode("bg_dialog")
    self._bg_dialog_bg = set:getJoint9Node("bg_dialog_bg")
    self._bg_dialog_powerLimit_arr = set:getElfNode("bg_dialog_powerLimit_arr")
    self._bg_dialog_powerLimit_num2 = set:getLabelNode("bg_dialog_powerLimit_num2")
    self._bg_dialog_powerLimit_num = set:getLabelNode("bg_dialog_powerLimit_num")
    self._bg_dialog_friendLimit_arr = set:getElfNode("bg_dialog_friendLimit_arr")
    self._bg_dialog_friendLimit_num2 = set:getLabelNode("bg_dialog_friendLimit_num2")
    self._bg_dialog_friendLimit_num = set:getLabelNode("bg_dialog_friendLimit_num")
    self._bg_dialog_power_arr = set:getElfNode("bg_dialog_power_arr")
    self._bg_dialog_power_num2 = set:getLabelNode("bg_dialog_power_num2")
    self._bg_dialog_power_num = set:getLabelNode("bg_dialog_power_num")
    self._bg_dialog_level_num2 = set:getLabelNode("bg_dialog_level_num2")
    self._bg_dialog_level_num = set:getLabelNode("bg_dialog_level_num")
    self._bg_line = set:getElfNode("bg_line")
    self._bg_title = set:getElfNode("bg_title")
    self._ActionScaleOut = set:getElfAction("ActionScaleOut")
    self._ActionRightIn = set:getElfAction("ActionRightIn")
    self._ActionLeftIn = set:getElfAction("ActionLeftIn")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DUserLevelUp:onInit( userData, netData )
	local oldRole = userData.oldRole
	local newRole = userData.newRole
	self:updateLayer(oldRole, newRole)
	self:runDialogActions()

	self._clickBg:setListener(function ( ... )
		self:close()
	end)
	require 'EventCenter'.eventInput("UserLevelUp")
end

function DUserLevelUp:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DUserLevelUp:updateLayer( oldRole, newRole )
	self._bg_dialog_level_num:setString(oldRole.Lv)
	self._bg_dialog_level_num2:setString(newRole.Lv)
	self._bg_dialog_power_num:setString(oldRole.Ap)
	self._bg_dialog_power_num2:setString(newRole.Ap)
	local CfgHelper = require 'CfgHelper'
	local old = CfgHelper.getCache('role_lv', 'lv', oldRole.Lv)
	local new = CfgHelper.getCache('role_lv', 'lv', newRole.Lv)
	self._bg_dialog_powerLimit_num:setString(old.apcap)
	self._bg_dialog_powerLimit_num2:setString(new.apcap)
	self._bg_dialog_friendLimit_num:setString(old.friendcap)
	self._bg_dialog_friendLimit_num2:setString(new.friendcap)
end

function DUserLevelUp:runDialogActions( ... )
	self._clickBg:setVisible(false)
	self._bg_line:setVisible(false)
	self._bg_line:runAction(self._ActionRightIn:clone())

	self._bg_title:setVisible(false)
	self._bg_title:runAction(self._ActionLeftIn:clone())

	self._bg_dialog:setVisible(false)
	local action = self._ActionScaleOut:clone()
	self._bg_dialog:runAction(action)
	action:setListener(function ( ... )
		self._clickBg:setVisible(true)
	end)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DUserLevelUp, "DUserLevelUp")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DUserLevelUp", DUserLevelUp)
