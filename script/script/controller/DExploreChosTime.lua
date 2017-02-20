local Config = require "Config"
local Res = require 'Res'

local DExploreChosTime = class(LuaDialog)

function DExploreChosTime:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DExploreChosTime.cocos.zip")
    return self._factory:createDocument("DExploreChosTime.cocos")
end

--@@@@[[[[
function DExploreChosTime:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._root = set:getElfNode("root")
    self._root_bg = set:getJoint9Node("root_bg")
    self._root_topBG_title = set:getLabelNode("root_topBG_title")
    self._root_close = set:getButtonNode("root_close")
    self._root_layout_cell1 = set:getElfNode("root_layout_cell1")
    self._root_layout_cell1_click = set:getColorClickNode("root_layout_cell1_click")
    self._root_layout_cell1_click_normal_des = set:getLabelNode("root_layout_cell1_click_normal_des")
    self._root_layout_cell1_click_normal_linearlayout_predict = set:getLabelNode("root_layout_cell1_click_normal_linearlayout_predict")
    self._root_layout_cell1_btnConfirm = set:getClickNode("root_layout_cell1_btnConfirm")
    self._root_layout_cell1_btnConfirm_title = set:getLabelNode("root_layout_cell1_btnConfirm_title")
    self._root_layout_cell2 = set:getElfNode("root_layout_cell2")
    self._root_layout_cell2_click = set:getColorClickNode("root_layout_cell2_click")
    self._root_layout_cell2_click_normal_des = set:getLabelNode("root_layout_cell2_click_normal_des")
    self._root_layout_cell2_click_normal_linearlayout_predict = set:getLabelNode("root_layout_cell2_click_normal_linearlayout_predict")
    self._root_layout_cell2_btnConfirm = set:getClickNode("root_layout_cell2_btnConfirm")
    self._root_layout_cell2_btnConfirm_title = set:getLabelNode("root_layout_cell2_btnConfirm_title")
    self._root_layout_cell3 = set:getElfNode("root_layout_cell3")
    self._root_layout_cell3_click = set:getColorClickNode("root_layout_cell3_click")
    self._root_layout_cell3_click_normal_des = set:getLabelNode("root_layout_cell3_click_normal_des")
    self._root_layout_cell3_click_normal_linearlayout_predict = set:getLabelNode("root_layout_cell3_click_normal_linearlayout_predict")
    self._root_layout_cell3_btnConfirm = set:getClickNode("root_layout_cell3_btnConfirm")
    self._root_layout_cell3_btnConfirm_title = set:getLabelNode("root_layout_cell3_btnConfirm_title")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DExploreChosTime:onInit( userData, netData )

     Res.doActionDialogShow(self._root)
    self._clickBg:setListener(function ( ... )
        Res.doActionDialogHide(self._root, self)
    end)
    self._root_close:setTriggleSound(Res.Sound.back)
    self._root_close:setListener(function (  )
        Res.doActionDialogHide(self._root, self)
    end)


	self._root_layout_cell1_click:setListener(function()
        self:chosTime(1)
    end)
    self._root_layout_cell1_btnConfirm:setListener(function()
        self:chosTime(1)
    end)


    self._root_layout_cell2_click:setListener(function()
        self:chosTime(3)
    end)
    self._root_layout_cell2_btnConfirm:setListener(function()
        self:chosTime(3)
    end)


    self._root_layout_cell3_click:setListener(function()
        self:chosTime(8)
    end)
    self._root_layout_cell3_btnConfirm:setListener(function()
        self:chosTime(8)
    end)

    for i = 1, 3 do
        self[string.format('_root_layout_cell%d_click_normal_linearlayout_predict', i)]:setString(tostring(userData[string.format('price%d', i)]))
   	  require "LangAdapter".LabelNodeAutoShrink(self[string.format('_root_layout_cell%d_btnConfirm_title', i)], 104)
    end
end

function DExploreChosTime:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DExploreChosTime:chosTime(hours)
    if self:getUserData().callBack then
        self:getUserData().callBack(hours)
        self:close()
    end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DExploreChosTime, "DExploreChosTime")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DExploreChosTime", DExploreChosTime)


