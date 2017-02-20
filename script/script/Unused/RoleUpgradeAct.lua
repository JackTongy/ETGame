local Config = require "Config"

local RoleUpgradeAct = class(LuaController)

function RoleUpgradeAct:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."RoleUpgradeAct.cocos.zip")
    return self._factory:createDocument("RoleUpgradeAct.cocos")
end

--@@@@[[[[
function RoleUpgradeAct:onInitXML()
	local set = self._set
    self._layout_time = set:getLabelNode("layout_time")
    self._nextGetTipLabel = set:getLinearLayoutNode("nextGetTipLabel")
    self._nextGetTipLabel_lv = set:getLabelNode("nextGetTipLabel_lv")
    self._rewardLayout = set:getLayoutNode("rewardLayout")
    self._count = set:getLabelNode("count")
    self._btn = set:getButtonNode("btn")
    self._lvBg_lv = set:getLabelNode("lvBg_lv")
    self._red = set:getElfNode("red")
    self._gotIcon = set:getElfNode("gotIcon")
    self._rankBg_linearlayout_myRank = set:getLabelNode("rankBg_linearlayout_myRank")
    self._rankBg_rankList = set:getListNode("rankBg_rankList")
    self._rankIcon = set:getElfNode("rankIcon")
    self._rank = set:getLabelNode("rank")
    self._name = set:getLabelNode("name")
    self._lv = set:getLabelNode("lv")
    self._rewardLayout = set:getLinearLayoutNode("rewardLayout")
    self._icon = set:getElfNode("icon")
    self._count = set:getLabelNode("count")
    self._l = set:getElfNode("l")
    self._r = set:getElfNode("r")
    self._m = set:getElfNode("m")
    self._name = set:getLabelNode("name")
    self._btn = set:getButtonNode("btn")
    self._HuoDongTongYong960x640_KaiFuChongJiJiangLi-new = set:getElfNode("HuoDongTongYong960x640_KaiFuChongJiJiangLi-new")
--    self._@view = set:getElfNode("@view")
--    self._@lvReward = set:getElfNode("@lvReward")
--    self._@item = set:getElfNode("@item")
--    self._@reward = set:getElfNode("@reward")
end
--@@@@]]]]

--------------------------------override functions----------------------
function RoleUpgradeAct:onInit( userData, netData )
	
end

function RoleUpgradeAct:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(RoleUpgradeAct, "RoleUpgradeAct")


--------------------------------register--------------------------------
GleeCore:registerLuaController("RoleUpgradeAct", RoleUpgradeAct)


