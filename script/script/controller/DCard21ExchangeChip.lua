local Config = require "Config"
local res = require "Res"
local Card21Info = require "Card21Info"
local netModel = require "netModel"
local dbManager = require "DBManager"
local EventCenter = require "EventCenter"

local DCard21ExchangeChip = class(LuaDialog)

function DCard21ExchangeChip:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DCard21ExchangeChip.cocos.zip")
    return self._factory:createDocument("DCard21ExchangeChip.cocos")
end

--@@@@[[[[
function DCard21ExchangeChip:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._detailBg = set:getElfNode("detailBg")
    self._detailBg_canExchange = set:getLabelNode("detailBg_canExchange")
    self._detailBg_tip = set:getLabelNode("detailBg_tip")
    self._detailBg_btnRecharge = set:getClickNode("detailBg_btnRecharge")
    self._detailBg_layout = set:getLayoutNode("detailBg_layout")
    self._icon = set:getElfNode("icon")
    self._name = set:getLabelNode("name")
    self._layout_count = set:getLabelNode("layout_count")
    self._btnOk = set:getClickNode("btnOk")
    self._icon = set:getElfNode("icon")
    self._name = set:getLabelNode("name")
    self._layout_count = set:getLabelNode("layout_count")
    self._btnOk = set:getClickNode("btnOk")
    self._icon = set:getElfNode("icon")
    self._name = set:getLabelNode("name")
    self._layout_count = set:getLabelNode("layout_count")
    self._btnOk = set:getClickNode("btnOk")
--    self._@item = set:getElfNode("@item")
--    self._@item = set:getElfNode("@item")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DCard21ExchangeChip:onInit( userData, netData )
	require 'LangAdapter'.fontSize(self._detailBg_canExchange, nil, nil, 22, 22)
	require 'LangAdapter'.fontSize(self._detailBg_tip, nil, nil, 18, 18)

	res.doActionDialogShow(self._detailBg)

	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._detailBg, self)
	end)

	local exchange = Card21Info.getCard21().Exchange or 0
	self._detailBg_canExchange:setString( string.format(res.locString("Card21$canExchange"), exchange) )
	self._detailBg_btnRecharge:setListener(function ( ... )
		res.doActionDialogHide(self._detailBg, self)
		GleeCore:showLayer("DRecharge")
	end)

	local list = {dbManager.getDeaultConfig("21pointExchange1").Value, dbManager.getDeaultConfig("21pointExchange2").Value}
	if exchange > 0 then
		table.insert(list, exchange)
	end
	for i,v in ipairs(list) do
		local item = self:createLuaSet("@item")
		self._detailBg_layout:addChild(item[1])
		item["icon"]:setResid(string.format("HD1_21_CM%d.png", i))
		item["name"]:setString(tostring(v) .. res.locString("Global$Chip"))
		item["layout_count"]:setString(v)
		item["btnOk"]:setEnabled(exchange >= v)
		item["btnOk"]:setListener(function ( ... )
			local oldCoin = require "UserInfo".getCoin()
			if oldCoin >= v then
				self:send(netModel.getModelCard21PointEx(i), function ( data )
					if data and data.D then
						require "UserInfo".setCoin( oldCoin - v )
						EventCenter.eventInput("UpdateGoldCoin")
						Card21Info.setCard21(data.D.Card21)
						res.doActionDialogHide(self._detailBg, self)
						EventCenter.eventInput("UpdateCard21Chip")
						self:toast(string.format(res.locString("Card21$exchangeSuc"), v))
					end
				end)
			else
				require "Toolkit".showDialogOnCoinNotEnough()
			end
		end)
	end
end

function DCard21ExchangeChip:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DCard21ExchangeChip, "DCard21ExchangeChip")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DCard21ExchangeChip", DCard21ExchangeChip)


