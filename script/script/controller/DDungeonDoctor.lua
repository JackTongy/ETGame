local Config = require "Config"
local res = require "Res"

local DDungeonDoctor = class(LuaDialog)

function DDungeonDoctor:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DDungeonDoctor.cocos.zip")
    return self._factory:createDocument("DDungeonDoctor.cocos")
end

--@@@@[[[[
function DDungeonDoctor:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._detailBg = set:getElfNode("detailBg")
    self._detailBg_title = set:getLabelNode("detailBg_title")
    self._detailBg_layout = set:getLayoutNode("detailBg_layout")
    self._frame = set:getElfNode("frame")
    self._name = set:getLabelNode("name")
    self._medalNeedLayout_icon = set:getElfNode("medalNeedLayout_icon")
    self._medalNeedLayout_count = set:getLabelNode("medalNeedLayout_count")
    self._btnBuy = set:getClickNode("btnBuy")
    self._btnBuy_title = set:getLabelNode("btnBuy_title")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._name = set:getLabelNode("name")
    self._medalNeedLayout_icon = set:getElfNode("medalNeedLayout_icon")
    self._medalNeedLayout_count = set:getLabelNode("medalNeedLayout_count")
    self._btnBuy = set:getClickNode("btnBuy")
    self._btnBuy_title = set:getLabelNode("btnBuy_title")
--    self._@item = set:getElfNode("@item")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DDungeonDoctor:onInit( userData, netData )
	res.doActionDialogShow(self._detailBg)
	
	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._detailBg, self)
	end)

	local list = {{icon = "N_TY_jinbi1.png", des = 5000, rate = 0.2, cost = 5000, frame = "N_ZB_biankuang3.png"}, 
				{icon = "N_TY_baoshi1.png", des = 10, rate = 0.5, cost = 10, frame = "N_ZB_biankuang4.png"}}
	for i,v in ipairs(list) do
		local itemSet = self:createLuaSet("@item")
		self._detailBg_layout:addChild(itemSet[1])
		itemSet["btnBuy"]:setListener(function ( ... )
			if userData.callback then
				userData.callback(v.cost)
				res.doActionDialogHide(self._detailBg, self)
			end
		end)

		itemSet["medalNeedLayout_icon"]:setResid(v.icon)
		itemSet["name"]:setString(string.format(res.locString("Dungeon$CatchSucRateTip"), v.rate * 100))
		itemSet["medalNeedLayout_count"]:setString(tostring(v.des))
		itemSet["frame"]:setResid(v.frame)
	end
end

function DDungeonDoctor:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DDungeonDoctor, "DDungeonDoctor")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DDungeonDoctor", DDungeonDoctor)
