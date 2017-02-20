local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local netModel = require "netModel"

local DTrialBuffer = class(LuaDialog)

function DTrialBuffer:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DTrialBuffer.cocos.zip")
    return self._factory:createDocument("DTrialBuffer.cocos")
end

--@@@@[[[[
function DTrialBuffer:onInitXML()
	local set = self._set
    self._bg = set:getJoint9Node("bg")
    self._bg_bg1_layoutPro1_k = set:getElfNode("bg_bg1_layoutPro1_k")
    self._bg_bg1_layoutPro1_v = set:getLabelNode("bg_bg1_layoutPro1_v")
    self._bg_bg1_layoutPro2_k = set:getElfNode("bg_bg1_layoutPro2_k")
    self._bg_bg1_layoutPro2_v = set:getLabelNode("bg_bg1_layoutPro2_v")
    self._bg_bg1_layoutPro3_k = set:getElfNode("bg_bg1_layoutPro3_k")
    self._bg_bg1_layoutPro3_v = set:getLabelNode("bg_bg1_layoutPro3_v")
    self._bg_bg1_layoutPro4_k = set:getElfNode("bg_bg1_layoutPro4_k")
    self._bg_bg1_layoutPro4_v = set:getLabelNode("bg_bg1_layoutPro4_v")
    self._bg_layoutOwn_v = set:getLabelNode("bg_layoutOwn_v")
    self._bg_layoutBuff = set:getLayoutNode("bg_layoutBuff")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._plus = set:getElfNode("plus")
    self._des = set:getLabelNode("des")
    self._star = set:getElfNode("star")
    self._count = set:getLabelNode("count")
    self._btnExchange = set:getClickNode("btnExchange")
--    self._@buff = set:getElfNode("@buff")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DTrialBuffer:onInit( userData, netData )
	self.Adventure = userData.data
	self.callback = userData.callback
	self:updateLayer()
	res.doActionDialogShow(self._bg)
end

function DTrialBuffer:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DTrialBuffer:updateLayer( ... )
	local dataAdventure = self.Adventure
	for i=1,4 do
		res.setNodeWithBuff( self[string.format("_bg_bg1_layoutPro%d_k", i)], i )
		local rate = self:getBufferWithType(i)
		self[string.format("_bg_bg1_layoutPro%d_v", i)]:setString( string.format(res.locString(string.format("Trials$Buff%d", i)), math.floor(rate * 100)) )
	end
	self._bg_layoutOwn_v:setString(dataAdventure.Stars)
	self._bg_layoutBuff:removeAllChildrenWithCleanup(true)
	local starList = {3, 15, 30}
	for i,v in ipairs(dataAdventure.Rs) do
		local buffSet = self:createLuaSet("@buff")
		self._bg_layoutBuff:addChild(buffSet[1])
		res.setNodeWithBuff( buffSet["icon"], v.Type )
		local desString = string.format(res.locString(string.format("Trials$Buff%d", v.Type)), math.floor(v.Rate * 100))
		buffSet["des"]:setString( desString )
		require "LangAdapter".LabelNodeAutoShrink( buffSet["des"], 140)

		buffSet["count"]:setString(starList[i])
		buffSet["btnExchange"]:setEnabled( dataAdventure.Stars >= starList[i] )
		buffSet["btnExchange"]:setListener(function ( ... )
			if dataAdventure.Stars >= starList[i] then
				local param = {}
				param.title = res.locString("Trials$BUFFExchangeTitle")
				param.content = string.format(res.locString("Trials$BuffExchangeTip"), desString)
				param.callback = function ( ... )
					self:send(netModel.getModelAdvBuff(i), function ( data )
						if data and data.D then
							self.callback(data.D.Adventure)
							res.doActionDialogHide(self._bg, self)
							if self.Adventure.CurrentType ~= 0 then
								self:toast( string.format(res.locString("Trials$BuffExchangeSucc"), desString) )
							end
						end
					end)
				end
				GleeCore:showLayer("DConfirmNT", param)
			end
		end)
	end
end

function DTrialBuffer:getBufferWithType( type )
	local result = 0
	if self.Adventure.Buffs then
		for k,v in pairs(self.Adventure.Buffs) do
			if v.Type == type then
				result = v.Rate
				break
			end
		end
	end
	return result
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DTrialBuffer, "DTrialBuffer")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DTrialBuffer", DTrialBuffer)


