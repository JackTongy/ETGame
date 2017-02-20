local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"

local DGBChangeOrder = class(LuaDialog)

function DGBChangeOrder:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGBChangeOrder.cocos.zip")
    return self._factory:createDocument("DGBChangeOrder.cocos")
end

--@@@@[[[[
function DGBChangeOrder:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._root = set:getElfNode("root")
    self._root_layout = set:getLayoutNode("root_layout")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._name = set:getLabelNode("name")
    self._des = set:getLabelNode("des")
    self._btnChose = set:getClickNode("btnChose")
--    self._@order = set:getElfNode("@order")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DGBChangeOrder:onInit( userData, netData )
	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._root, self)
	end)

	local iconList = {"N_GHZ_gj.png", "N_GHZ_fy.png", "N_GHZ_zy.png"}
	local desKey = {"GuildFightAtk", "GuildFightDef", "GuildFightAst"}

	self._root_layout:removeAllChildrenWithCleanup(true)
	for i=1,3 do
		local orderSet = self:createLuaSet("@order")
		self._root_layout:addChild(orderSet[1])
		orderSet["icon"]:setResid(iconList[i])
		orderSet["name"]:setString( res.locString( string.format("GuildBattle$OrderIndex%d", i) ) )
		orderSet["des"]:setString( dbManager.getDeaultConfig(desKey[i]).Value )
		orderSet["btnChose"]:setListener(function ( ... )
			res.doActionDialogHide(self._root, self)
			require "EventCenter".eventInput("GuildFightChoseOrder", {orderType = i, castleId = userData.castleId})
		end)

		require 'LangAdapter'.fontSize( orderSet["des"], nil, nil, 22, nil, nil, nil, nil, nil, nil, 20)
	end

	res.doActionDialogShow(self._root)
end

function DGBChangeOrder:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGBChangeOrder, "DGBChangeOrder")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGBChangeOrder", DGBChangeOrder)


