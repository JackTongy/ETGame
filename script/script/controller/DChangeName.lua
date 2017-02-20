local Config = require "Config"
local res = require "Res"
local gameFunc = require "AppData"
local netModel = require "netModel"
local userFunc = gameFunc.getUserInfo()

local DChangeName = class(LuaDialog)

function DChangeName:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DChangeName.cocos.zip")
    return self._factory:createDocument("DChangeName.cocos")
end

--@@@@[[[[
function DChangeName:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_input = set:getInputTextNode("bg_input")
    self._bg_random = set:getClickNode("bg_random")
    self._bg_btnCancel = set:getClickNode("bg_btnCancel")
    self._bg_btnOk = set:getClickNode("bg_btnOk")
    self._bg_free = set:getLabelNode("bg_free")
    self._bg_layoutCost = set:getLinearLayoutNode("bg_layoutCost")
    self._bg_layoutCost_v = set:getLabelNode("bg_layoutCost_v")
end
--@@@@]]]]

--------------------------------override functions----------------------

local Launcher = require 'Launcher'
Launcher.register("DChangeName", function ( userData )
   	Launcher.callNet(netModel.getModelRoleRenameCost(), function ( data )
   		print("RoleRenameCost")
   		print(data)
   		Launcher.Launching(data)   
 	end)
end)

function DChangeName:onInit( userData, netData )
	local cost = netData and netData.D and netData.D.Cost or 0

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	local UserName = require 'UserName'
	self._bg_input:setText(UserName.randomName())
	self._bg_input:setKeyBoardListener(function ( event )
		print("__changeName__event = " .. event)
		if event == -2 then
			local text = self._bg_input:getText()
			self._bg_btnOk:setEnabled(string.len(text) > 0 and userFunc.getCoin() >= cost)
		end
	end)

	self._bg_random:setListener(function ( ... )
    		self._bg_input:setText(UserName.randomName())  
    		self._bg_btnOk:setEnabled(true)
	end)

	self._bg_btnCancel:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_btnOk:setListener(function ( ... )
		if userFunc.getCoin() >= cost then
			local text = self._bg_input:getText()
			if text == nil or string.len(text) == 0 then
				self:toast(res.locString('PetDetail$NAMENOTEMPTY'))
			elseif text == userFunc.getName() then
				self:toast(res.locString('UserInfo$NameRepeat'))
			else
				self:send(netModel.getRoleRename(text), function ( data )
					if data.D and data.D.Role then
						userFunc.setCoin( userFunc.getCoin() - cost)
						userFunc.setName(data.D.Role.Name)
						require "EventCenter".eventInput("UpdateGoldCoin")
						self:toast(res.locString("UserInfo$NameChangeSuc"))
						res.doActionDialogHide(self._bg, self)
					end
				end)
			end
		else
			require "Toolkit".showDialogOnCoinNotEnough()
		end
	end)
	self._bg_free:setVisible(cost <= 0)
	self._bg_layoutCost:setVisible(cost > 0)
	if cost > 0 then
		self._bg_layoutCost_v:setString(cost)
		if userFunc.getCoin() >= cost then
			self._bg_layoutCost_v:setFontFillColor(res.color4F.white, true)
		else
			self._bg_layoutCost_v:setFontFillColor(ccc4f(0.8588, 0.094, 0.106, 1), true)
		end
	end

	res.doActionDialogShow(self._bg)
end

function DChangeName:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DChangeName, "DChangeName")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DChangeName", DChangeName)


