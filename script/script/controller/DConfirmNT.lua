local Config = require "Config"
local Res = require 'Res'
local GuideHelper = require 'GuideHelper'

local DConfirmNT = class(LuaDialog)

function DConfirmNT:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DConfirmNT.cocos.zip")
    return self._factory:createDocument("DConfirmNT.cocos")
end

--@@@@[[[[
function DConfirmNT:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._root = set:getElfNode("root")
   self._root_bg1 = set:getElfNode("root_bg1")
   self._root_bg1_title = set:getLabelNode("root_bg1_title")
   self._root_bg1_content = set:getRichLabelNode("root_bg1_content")
   self._root_bg1_list_container = set:getListContainerNode("root_bg1_list_container")
   self._root_bg1_list_container_c = set:getElfNode("root_bg1_list_container_c")
   self._root_bg1_list_container_c_content = set:getRichLabelNode("root_bg1_list_container_c_content")
   self._root_bg1_btnOk = set:getClickNode("root_bg1_btnOk")
   self._root_bg1_btnOk_title = set:getLabelNode("root_bg1_btnOk_title")
   self._root_bg1_btnCancel = set:getClickNode("root_bg1_btnCancel")
   self._root_bg1_btnCancel_title = set:getLabelNode("root_bg1_btnCancel_title")
   self._root_bg1_btnOk2 = set:getClickNode("root_bg1_btnOk2")
   self._root_bg1_btnOk2_title = set:getLabelNode("root_bg1_btnOk2_title")
end
--@@@@]]]]

--------------------------------override functions----------------------
--[[
	content=''
	callback=func
	cancelCallback
	RightBtnText
	LeftBtnText
]]
function DConfirmNT:onInit( userData, netData )
	Res.doActionDialogShow(self._root_bg1)
	self._root_bg1_btnOk:setTriggleSound(Res.Sound.yes)
	self._root_bg1_btnCancel:setTriggleSound(Res.Sound.back)
	if userData then
		if userData.title then
			self._root_bg1_title:setString(userData.title)
		end
		
		self._root_bg1_list_container_c_content:setString(userData.content2 or '')
		self._root_bg1_content:setString(userData.content or '')
		if userData.content2 then
			local size = self._root_bg1_list_container_c_content:getContentSize()
			size.height = (size.height > 156 and size.height) or 156
			self._root_bg1_list_container_c:setContentSize(CCSizeMake(size.width,size.height))
		end

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
			if userData.noclose then
				if userData.callback then
					userData.callback()
				end
			else
				Res.doActionDialogHide(self._root_bg1, function ( ... )
					self:close()
					if userData.callback then
						userData.callback()
					end
				end)	
			end
		end)
		self._root_bg1_btnCancel:setListener(function ( ... )
			if userData.cancelCallback then
				userData.cancelCallback()
			end
			Res.doActionDialogHide(self._root_bg1, self)
		end)
		if userData.hideCancel then
			self._root_bg1_btnOk:setVisible(false)
			self._root_bg1_btnCancel:setVisible(false)
			self._root_bg1_btnOk2:setVisible(true)
			self._root_bg1_btnOk2:setListener(function (  )
				Res.doActionDialogHide(self._root_bg1, function ( ... )
					self:close()
					if userData.callback then
						userData.callback()
					end
				end)				
			end)
		else
			self._root_bg1_btnOk2:setVisible(false)
		end

		self._clickBg:setVisible(userData.clickClose or false)
		self._clickBg:setListener(function ( ... )
			Res.doActionDialogHide(self._root_bg1, self)
		end)
	end

	GuideHelper:registerPoint('确定',self._root_bg1_btnOk)
	GuideHelper:check('DConfirmNT')

	require "LangAdapter".LabelNodeAutoShrink(self._root_bg1_btnOk_title, 108)
	require "LangAdapter".LabelNodeAutoShrink(self._root_bg1_btnOk2_title, 108)
	require "LangAdapter".LabelNodeAutoShrink(self._root_bg1_btnCancel_title, 108)
end

function DConfirmNT:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DConfirmNT, "DConfirmNT")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DConfirmNT", DConfirmNT)
