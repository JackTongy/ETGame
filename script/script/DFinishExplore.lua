local Config = require "Config"
local Res = require 'Res'
local DFinishExplore = class(LuaDialog)

function DFinishExplore:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DFinishExplore.cocos.zip")
    return self._factory:createDocument("DFinishExplore.cocos")
end

--@@@@[[[[
function DFinishExplore:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._root = set:getElfNode("root")
    self._root_title = set:getLabelNode("root_title")
    self._root_content = set:getRichLabelNode("root_content")
    self._root_btnOk = set:getClickNode("root_btnOk")
    self._root_btnOk_title = set:getLabelNode("root_btnOk_title")
    self._root_btnCancel = set:getClickNode("root_btnCancel")
    self._root_btnCancel_title = set:getLabelNode("root_btnCancel_title")
    self._root_btnOk2 = set:getClickNode("root_btnOk2")
    self._root_btnOk2_title = set:getLabelNode("root_btnOk2_title")
    self._root_reward_number = set:getRichLabelNode("root_reward_number")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DFinishExplore:onInit( userData, netData )
    self._root_content:setString(string.format(Res.locString('Explore$_finish_aheadOfSchedule'), userData.remanderMin))
    self._root_reward_number:setString(tostring(userData.earnings))
	self._root_btnOk:setListener(function( ... )
        userData.callBack()
        --self:close()
        Res.doActionDialogHide(self._root, self)
    end)

    self._root_btnCancel:setListener(function( ... )
        --self:close()
        Res.doActionDialogHide(self._root, self)
    end)
    
    self._clickBg:setListener(function()
        -- body
        Res.doActionDialogHide(self._root, self)
    end)

    Res.doActionDialogShow(self._root)
end

function DFinishExplore:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DFinishExplore, "DFinishExplore")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DFinishExplore", DFinishExplore)


