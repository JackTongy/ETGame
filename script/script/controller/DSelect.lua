local Config = require "Config"

local DSelect = class(LuaDialog)

function DSelect:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DSelect.cocos.zip")
    return self._factory:createDocument("DSelect.cocos")
end

--@@@@[[[[
function DSelect:onInitXML()
    local set = self._set
   self._btnbg = set:getButtonNode("btnbg")
   self._bg1_title = set:getLabelNode("bg1_title")
   self._bg1_btnConfirm = set:getClickNode("bg1_btnConfirm")
   self._bg1_list = set:getListNode("bg1_list")
   self._tab = set:getTabNode("tab")
   self._content = set:getLabelNode("content")
--   self._@cell = set:getElfNode("@cell")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DSelect:onInit( userData, netData )

	self._bg1_btnConfirm:setListener(function ( ... )
		self:close()	
	end)
	self._btnbg:setListener(function ( ... )
		self:close()
	end)

	if userData.param then
		self:updateList(userData.param,userData.selected)
	end

	self._bg1_btnConfirm:setListener(function ( ... )
		self:Confirm()
	end)

	if userData.title then
		self._bg1_title:setString(tostring(userData.title))
	end

end

function DSelect:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------



function DSelect:updateList( list ,selected)
	self._bg1_list:getContainer():removeAllChildrenWithCleanup(true)

	if list then
		for i,v in ipairs(list) do
			local set = self:createLuaSet('@cell')
			set['tab']:setListener(function ( ... )
				self._selectIndex = i
			end)

			local des
			if type(v) == 'table' then
				des = table.concat( v, ":")
			else
				des = tostring(v)
			end

			set['content']:setString(des)

			if selected and selected == i then
				set['tab']:trigger(nil)
			end

			self._bg1_list:getContainer():addChild(set[1])
		end
	end

end

function DSelect:Confirm( ... )
	
	local userData = self:getUserData()

	if userData and userData.callback then
		userData.callback(self._selectIndex)
	end

	self:close()

end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DSelect, "DSelect")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DSelect", DSelect)
