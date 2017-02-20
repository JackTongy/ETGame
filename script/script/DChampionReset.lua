local Config = require "Config"
local Res = require 'Res'
local DChampionReset = class(LuaDialog)

function DChampionReset:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DChampionReset.cocos.zip")
    return self._factory:createDocument("DChampionReset.cocos")
end

--@@@@[[[[
function DChampionReset:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getShieldNode("bg")
    self._bg_current = set:getElfNode("bg_current")
    self._bg_current_btnOk = set:getClickNode("bg_current_btnOk")
    self._bg_current_btnOk_title = set:getLabelNode("bg_current_btnOk_title")
    self._bg_next = set:getElfNode("bg_next")
    self._bg_next_btnOk = set:getClickNode("bg_next_btnOk")
    self._bg_next_btnOk_title = set:getLabelNode("bg_next_btnOk_title")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DChampionReset:onInit( userData, netData )
	require "LangAdapter".LabelNodeAutoShrink(self._set:getLabelNode("bg_current_icon_#text"),130)
	require "LangAdapter".LabelNodeAutoShrink(self._set:getLabelNode("bg_next_icon_#text"),130)

	if userData.showNext then
        self._bg_next_btnOk:setEnabled(true)
    else
        self._bg_next_btnOk:setEnabled(false)
    end

    self._bg_current_btnOk:setListener(function( ... )
        userData.callBack(false)
        --self:close()
        Res.doActionDialogHide(self._bg, self)
    end)

    self._bg_next_btnOk:setListener(function( ... )
        userData.callBack(true)
        --self:close()
        Res.doActionDialogHide(self._bg, self)
    end)

    self._clickBg:setListener(function()
        --self:close()
        Res.doActionDialogHide(self._bg, self)
    end)
    Res.doActionDialogShow(self._bg)
end

function DChampionReset:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DChampionReset, "DChampionReset")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DChampionReset", DChampionReset)


