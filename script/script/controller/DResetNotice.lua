local Config = require "Config"
local res = require "Res"

local DResetNotice = class(LuaDialog)

function DResetNotice:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DResetNotice.cocos.zip")
    return self._factory:createDocument("DResetNotice.cocos")
end

--@@@@[[[[
function DResetNotice:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._root = set:getElfNode("root")
    self._root_bg1 = set:getElfNode("root_bg1")
    self._root_bg1_title = set:getLabelNode("root_bg1_title")
    self._root_bg1_content = set:getRichLabelNode("root_bg1_content")
    self._root_bg1_tip = set:getLabelNode("root_bg1_tip")
    self._root_bg1_btnOk = set:getClickNode("root_bg1_btnOk")
    self._root_bg1_btnOk_title = set:getLabelNode("root_bg1_btnOk_title")
    self._root_bg1_btnCancel = set:getClickNode("root_bg1_btnCancel")
    self._root_bg1_btnCancel_title = set:getLabelNode("root_bg1_btnCancel_title")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DResetNotice:onInit( userData, netData )
	res.doActionDialogShow(self._root_bg1)
	self._root_bg1_btnOk:setTriggleSound(res.Sound.yes)
	self._root_bg1_btnCancel:setTriggleSound(res.Sound.back)
	if userData then
		if userData.title then
			self._root_bg1_title:setString(userData.title)
		end
	--	self._root_bg1_content:setDebug(true)
		self._root_bg1_content:setString(userData.content)
		if userData.tip then
			self._root_bg1_tip:setString(userData.tip)
		end
		self._root_bg1_tip:setVisible(userData.tip ~= nil)
		if userData.RightBtnText then
			self._root_bg1_btnOk_title:setString(userData.RightBtnText)
		end
		if userData.LeftBtnText then
			self._root_bg1_btnCancel_title:setString(userData.LeftBtnText)
		end
		if userData.rightBtnEnable ~= nil then
			self._root_bg1_btnOk:setEnabled(userData.rightBtnEnable)
		end
		self._root_bg1_btnOk:setListener(function ( ... )
			res.doActionDialogHide(self._root_bg1, function ( ... )
				self:close()
				if userData.callback then
					userData.callback()
				end
			end)
		end)
		self._root_bg1_btnCancel:setListener(function ( ... )
			if userData.cancelCallback then
				userData.cancelCallback()
			end
			res.doActionDialogHide(self._root_bg1, self)
		end)

		self._clickBg:setListener(function ( ... )
			res.doActionDialogHide(self._root_bg1, self)
		end)

		require "LangAdapter".LabelNodeAutoShrink(self._root_bg1_btnOk_title, 108)
		require "LangAdapter".LabelNodeAutoShrink(self._root_bg1_btnCancel_title, 108)
	end
end

function DResetNotice:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DResetNotice, "DResetNotice")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DResetNotice", DResetNotice)


