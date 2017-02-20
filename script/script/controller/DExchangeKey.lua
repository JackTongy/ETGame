local Config = require "Config"
local netModel = require "netModel"
local gameFunc = require "AppData"
local res = require "Res"

local DExchangeKey = class(LuaDialog)

function DExchangeKey:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DExchangeKey.cocos.zip")
    return self._factory:createDocument("DExchangeKey.cocos")
end

--@@@@[[[[
function DExchangeKey:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._bg = set:getElfNode("bg")
   self._bg_title = set:getLabelNode("bg_title")
   self._bg_des = set:getLabelNode("bg_des")
   self._bg_exchangeKeyBg_input = set:getInputTextNode("bg_exchangeKeyBg_input")
   self._bg_btnExchange = set:getClickNode("bg_btnExchange")
   self._bg_btnExchange_text = set:getLabelNode("bg_btnExchange_text")
   self._bg_btnOk = set:getClickNode("bg_btnOk")
   self._bg_btnOk_text = set:getLabelNode("bg_btnOk_text")
   self._bg_btnCancel = set:getClickNode("bg_btnCancel")
   self._bg_btnCancel_text = set:getLabelNode("bg_btnCancel_text")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DExchangeKey:onInit( userData, netData )
	self.mode = userData.mode
	if userData.mode == "ExchangeKey" then
		self._bg_title:setString(res.locString("Setting$ExchangeKey"))
		self._bg_des:setString(res.locString("Setting$ExchangeTitle"))
		self._bg_btnExchange:setVisible(true)
		self._bg_btnOk:setVisible(false)
		self._bg_btnCancel:setVisible(false)
	elseif userData.mode == "InviteKey" then
		self.callback = userData.callback
		self._bg_title:setString(res.locString("InviteKey$Title1"))
		self._bg_des:setString(res.locString("InviteKey$Des1"))
		self._bg_btnExchange:setVisible(true)
		self._bg_btnOk:setVisible(false)
		self._bg_btnCancel:setVisible(false)
	elseif userData.mode == "SeniorGift" then
		self._bg_title:setString(res.locString("InviteKey$Title2"))
		self._bg_des:setString(res.locString("InviteKey$Des2"))
		self._bg_btnExchange:setVisible(false)
		self._bg_btnOk:setVisible(true)
		self._bg_btnCancel:setVisible(true)
		require "LangAdapter".selectLang(nil, nil, nil, nil, function ( ... )
			self._bg_des:setPosition(ccp(-187.35718,72.38096))
		end)
	end

	self._bg_exchangeKeyBg_input:setPlaceHolder(res.locString("Setting$ExchangeKeyInput"))
	local textNode = self._bg_exchangeKeyBg_input:getInputTextNode()
	textNode:setFontFillColor(ccc4f(1.0, 0.69, 0.588, 0.502), true)
--	textNode:setFontSize(24)
	self:setListenerEvent()
end

function DExchangeKey:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DExchangeKey:setListenerEvent( ... )
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_btnExchange:setListener(function ( ... )
		local text = self._bg_exchangeKeyBg_input:getText()
		if text and string.len(text) > 0 and text ~= "" and text ~= self._bg_exchangeKeyBg_input:getPlaceHolder() then
			if self.mode == "ExchangeKey" then
				self:send(netModel.getModelExCodeDh(text), function ( data )
					if data and data.D then
						if data.D.Resource then
							gameFunc.updateResource(data.D.Resource)
						end
						if data.D.Reward then
							GleeCore:showLayer("DGetReward", data.D.Reward)
						end
						res.doActionDialogHide(self._bg, self)
					end
				end, function ( data )
					if data and data.Msg then
						self:toast(data.Msg)
					end
				end)
			elseif self.mode == "InviteKey" then
				self:send(netModel.getModelRoleCodeSetJunior(text), function ( data )
					if data and data.D then
						if data.D.Resource then
							gameFunc.updateResource(data.D.Resource)
						end
						if data.D.Reward then
							data.D.Reward.callback = function ( ... )
								self.callback(text)
							end
							GleeCore:showLayer("DGetReward", data.D.Reward)
						end
						res.doActionDialogHide(self._bg, self)
					end
				end, function ( data )
					if data and data.Msg then
						self:toast(data.Msg)
					end
				end)
			end
		else
			self:toast(res.locString("Setting$ExchangeTitle"))
		end
	end)

	self._bg_btnOk:setListener(function ( ... )
		local text = self._bg_exchangeKeyBg_input:getText()
		if text and string.len(text) > 0 and text ~= "" and text ~= self._bg_exchangeKeyBg_input:getPlaceHolder() then
			self:send(netModel.getModelRoleCodeSetSenior(text), function ( data )
				if data and data.D then
					res.doActionDialogHide(self._bg, self)
				end
			end, function ( data )
				if data and data.Msg then
					self:toast(data.Msg)
				end
			end)
		else
			self:toast(res.locString("InviteKey$Des1"))
		end
	end)

	self._bg_btnCancel:setListener(function ( ... )
		self:send(netModel.getModelRoleCodeSetSenior(""), function ( data )
			if data and data.D then
				res.doActionDialogHide(self._bg, self)
			end
		end, function ( data )
			if data and data.Msg then
				self:toast(data.Msg)
			end
		end)
	end)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DExchangeKey, "DExchangeKey")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DExchangeKey", DExchangeKey)


