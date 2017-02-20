local Config = require "Config"
local Card21Info = require "Card21Info"
local dbManager = require "DBManager"
local netModel = require "netModel"
local res = require "Res"
local gameFunc = require "AppData"
local userFunc = gameFunc.getUserInfo()

local DCard21Bet = class(LuaDialog)

function DCard21Bet:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DCard21Bet.cocos.zip")
    return self._factory:createDocument("DCard21Bet.cocos")
end

--@@@@[[[[
function DCard21Bet:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_layoutBg_s = set:getElfNode("bg_layoutBg_s")
    self._bg_layoutChip = set:getLayoutNode("bg_layoutChip")
    self._bg = set:getElfNode("bg")
    self._textBg = set:getElfNode("textBg")
    self._textBg_amt = set:getLabelNode("textBg_amt")
    self._btn = set:getButtonNode("btn")
--    self._@chip = set:getElfNode("@chip")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DCard21Bet:onInit( userData, netData )
	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_layoutChip:removeAllChildrenWithCleanup(true)
	local list = {dbManager.getInfoDefaultConfig("21pointCost1").Value, dbManager.getInfoDefaultConfig("21pointCost2").Value}
	if userFunc.getVipLevel() >= 10 then
		table.insert(list, dbManager.getInfoDefaultConfig("21pointCost3").Value)
	end
	
	for i,v in ipairs(list) do
		local chip = self:createLuaSet("@chip")
		self._bg_layoutChip:addChild(chip[1])
		chip["bg"]:setResid(string.format("HD2_21_CM%d.png", i))
		chip["textBg_amt"]:setString(res.locString("Card21$Bet") .. v)
		chip["btn"]:setListener(function ( ... )
			if Card21Info.getCard21().Score >= v then
				self:send(netModel.getModelCard21Bet(v), function ( data )
					if data and data.D then
						Card21Info.setCard21(data.D.Card21)
						res.doActionDialogHide(self._bg, self)
						require "EventCenter".eventInput("UpdateCard21CardPlay")
					end
				end)
			else
				self:toast(res.locString("Card21$chipNotEnough"))
			end
		end)
	end
	res.doActionDialogShow(self._bg)
end

function DCard21Bet:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DCard21Bet, "DCard21Bet")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DCard21Bet", DCard21Bet)


