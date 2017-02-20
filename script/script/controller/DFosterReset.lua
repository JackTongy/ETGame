local Config = require "Config"
local Res = require 'Res'
local DFosterReset = class(LuaDialog)

function DFosterReset:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DFosterReset.cocos.zip")
    return self._factory:createDocument("DFosterReset.cocos")
end

--@@@@[[[[
function DFosterReset:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg1 = set:getJoint9Node("root_bg1")
   self._root_bg1_content = set:getRichLabelNode("root_bg1_content")
   self._root_bg1_btnSave = set:getClickNode("root_bg1_btnSave")
   self._root_bg1_btnCanel = set:getClickNode("root_bg1_btnCanel")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DFosterReset:onInit( userData, netData )
	Res.doActionDialogShow(self._root_bg1)
	self._root_bg1_content:setString(Res.locString('PetFoster$TIP5'))
	self._root_bg1_btnCanel:setListener(function ( ... )
		Res.doActionDialogHide(self._root_bg1, self)
	end)	

	self._root_bg1_btnSave:setListener(function ( ... )
		if userData and userData.callback then
			userData.callback()
		end
	end)
end

function DFosterReset:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DFosterReset, "DFosterReset")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DFosterReset", DFosterReset)
