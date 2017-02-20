local Config = require "Config"

local DNetTimeOut = class(LuaDialog)

function DNetTimeOut:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DNetTimeOut.cocos.zip")
    return self._factory:createDocument("DNetTimeOut.cocos")
end

--@@@@[[[[
function DNetTimeOut:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg1 = set:getJoint9Node("root_bg1")
   self._root_bg1_content = set:getRichLabelNode("root_bg1_content")
   self._root_bg1_btnSave = set:getClickNode("root_bg1_btnSave")
   self._root_bg1_btnSave_title = set:getLabelNode("root_bg1_btnSave_title")
   self._root_bg1_btnCanel = set:getClickNode("root_bg1_btnCanel")
   self._root_bg1_btnCanel_title = set:getLabelNode("root_bg1_btnCanel_title")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DNetTimeOut:onInit( userData, netData )
	assert( userData.func )

    self._root_bg1_btnSave:setListener(function (  )
        -- body
        userData.func()

        self:close()
        
    end)

end

function DNetTimeOut:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DNetTimeOut, "DNetTimeOut")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DNetTimeOut", DNetTimeOut)


