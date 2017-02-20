local Config = require "Config"

local SilverCoinShop = class(LuaController)

function SilverCoinShop:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."SilverCoinShop.cocos.zip")
    return self._factory:createDocument("SilverCoinShop.cocos")
end

--@@@@[[[[
function SilverCoinShop:onInitXML()
	local set = self._set
    self._layout1_timer = set:getTimeNode("layout1_timer")
    self._bg1_v = set:getLabelNode("bg1_v")
    self._bg2_v = set:getLabelNode("bg2_v")
    self._tabBuy = set:getTabNode("tabBuy")
    self._tabBuy_text = set:getLabelNode("tabBuy_text")
    self._tabSell = set:getTabNode("tabSell")
    self._tabSell_text = set:getLabelNode("tabSell_text")
    self._pageBuy = set:getElfNode("pageBuy")
    self._pageBuy_count = set:getLabelNode("pageBuy_count")
    self._pageBuy_layoutRefresh = set:getLinearLayoutNode("pageBuy_layoutRefresh")
    self._pageBuy_layoutRefresh_time = set:getTimeNode("pageBuy_layoutRefresh_time")
    self._pageBuy_btnRefresh = set:getClickNode("pageBuy_btnRefresh")
    self._pageBuy_btnRefresh_text = set:getLabelNode("pageBuy_btnRefresh_text")
    self._pageBuy_bg3 = set:getJoint9Node("pageBuy_bg3")
    self._pageBuy_bg3_list = set:getListNode("pageBuy_bg3_list")
    self._layout = set:getLayoutNode("layout")
    self._bg = set:getElfNode("bg")
    self._icon_bg = set:getElfNode("icon_bg")
    self._icon = set:getElfNode("icon")
    self._iconFrame = set:getElfNode("iconFrame")
    self._piece = set:getElfNode("piece")
    self._name = set:getLabelNode("name")
    self._count = set:getLabelNode("count")
    self._vip = set:getElfNode("vip")
    self._layoutPrice = set:getLinearLayoutNode("layoutPrice")
    self._layoutPrice_k = set:getElfNode("layoutPrice_k")
    self._layoutPrice_v = set:getLabelNode("layoutPrice_v")
    self._btnOk = set:getClickNode("btnOk")
    self._btnOk_text = set:getLabelNode("btnOk_text")
    self._btnDetail = set:getButtonNode("btnDetail")
    self._pageBuy_layoutReward = set:getLinearLayoutNode("pageBuy_layoutReward")
    self._locked = set:getElfNode("locked")
    self._text = set:getLabelNode("text")
    self._pageSell = set:getElfNode("pageSell")
    self._pageSell_bg4 = set:getJoint9Node("pageSell_bg4")
    self._pageSell_bg4_list = set:getListNode("pageSell_bg4_list")
    self._layout = set:getLayoutNode("layout")
    self._bg = set:getElfNode("bg")
    self._icon_bg = set:getElfNode("icon_bg")
    self._icon = set:getElfNode("icon")
    self._iconFrame = set:getElfNode("iconFrame")
    self._piece = set:getElfNode("piece")
    self._name = set:getLabelNode("name")
    self._count = set:getLabelNode("count")
    self._vip = set:getElfNode("vip")
    self._layoutPrice = set:getLinearLayoutNode("layoutPrice")
    self._layoutPrice_k = set:getElfNode("layoutPrice_k")
    self._layoutPrice_v = set:getLabelNode("layoutPrice_v")
    self._btnOk = set:getClickNode("btnOk")
    self._btnOk_text = set:getLabelNode("btnOk_text")
    self._btnDetail = set:getButtonNode("btnDetail")
--    self._@view = set:getElfNode("@view")
--    self._@size = set:getElfNode("@size")
--    self._@shopItem = set:getElfNode("@shopItem")
--    self._@btnRwd = set:getClickNode("@btnRwd")
--    self._@next = set:getElfNode("@next")
--    self._@size = set:getElfNode("@size")
--    self._@shopItem = set:getElfNode("@shopItem")
end
--@@@@]]]]

--------------------------------override functions----------------------
function SilverCoinShop:onInit( userData, netData )
	
end

function SilverCoinShop:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(SilverCoinShop, "SilverCoinShop")


--------------------------------register--------------------------------
GleeCore:registerLuaController("SilverCoinShop", SilverCoinShop)


