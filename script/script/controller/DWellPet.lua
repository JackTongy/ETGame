local Config = require "Config"
local res = require "Res"

local DWellPet = class(LuaDialog)

function DWellPet:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DWellPet.cocos.zip")
    return self._factory:createDocument("DWellPet.cocos")
end

--@@@@[[[[
function DWellPet:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._root = set:getElfNode("root")
    self._root_pet = set:getElfNode("root_pet")
    self._root_bg = set:getElfNode("root_bg")
    self._root_petName = set:getLabelNode("root_petName")
    self._root_ask = set:getRichLabelNode("root_ask")
    self._root_answer = set:getRichLabelNode("root_answer")
    self._root_btnNo = set:getButtonNode("root_btnNo")
    self._root_btnNo_text = set:getLabelNode("root_btnNo_text")
    self._root_btnYes = set:getButtonNode("root_btnYes")
    self._root_btnYes_text = set:getLabelNode("root_btnYes_text")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DWellPet:onInit( userData, netData )
	self.closeCallback = userData.callback
	self.answerFinish = false
	self._clickBg:setListener(function (  )
		if self.answerFinish == true then
			self:doActionFadeOut()
		end
	end)
	self._root_ask:setString(string.format(res.locString("Dungeon$WellHello"), userData.coin))
	self._root_answer:setVisible(false)

	self._root_btnNo:setListener(function (  )
		self._root_ask:setVisible(false)
		self._root_btnNo:setVisible(false)
		self._root_btnYes:setVisible(false)
		self._root_answer:setString(string.format(res.locString("Dungeon$WellTip2"), userData.coin))
		self._root_answer:runAction(self:getFadeInAction(0.6))
		self.answerFinish = true
	end)

	self._root_btnYes:setListener(function (  )
		self._root_ask:setVisible(false)
		self._root_btnNo:setVisible(false)
		self._root_btnYes:setVisible(false)
		self._root_answer:setString(string.format(res.locString("Dungeon$WellTip1"), userData.oldCoin * 2, userData.coin))
		self._root_answer:runAction(self:getFadeInAction(0.6))
		self.answerFinish = true
	end)

	self:doActionFadeIn()
end

function DWellPet:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DWellPet:getFadeInNodeArray( ... )
	local temp = {}
	table.insert(temp, self._root_pet)
	table.insert(temp, self._root_bg)
	table.insert(temp, self._root_petName)
	table.insert(temp, self._root_ask)
	table.insert(temp, self._root_btnYes)
	table.insert(temp, self._root_btnYes_text)
	table.insert(temp, self._root_btnNo)
	table.insert(temp, self._root_btnNo_text)
	return temp
end

function DWellPet:getFadeOutNodeArray( ... )
	local temp = {}
	table.insert(temp, self._root_pet)
	table.insert(temp, self._root_bg)
	table.insert(temp, self._root_petName)
	table.insert(temp, self._root_answer)
	return temp
end

function DWellPet:getFadeInAction( fadeDelta )
	local actArray = CCArray:create()
	actArray:addObject(CCHide:create())
	actArray:addObject(CCFadeTo:create(0, 0))
	actArray:addObject(CCShow:create())
	actArray:addObject(CCFadeIn:create(fadeDelta))
	return CCSequence:create(actArray)
end

function DWellPet:getFadeOutAction( fadeDelta )
	local actArray = CCArray:create()
	actArray:addObject(CCShow:create())
	actArray:addObject(CCFadeTo:create(0, 255))
	actArray:addObject(CCFadeOut:create(fadeDelta))
	actArray:addObject(CCHide:create())
	actArray:addObject(CCCallFunc:create(function ( ... )
		self:close()
		if self.closeCallback then
			self.closeCallback()
		end
	end))
	return CCSequence:create(actArray)
end

function DWellPet:doActionFadeIn( ... )
	local list = self:getFadeInNodeArray()
	for k,v in pairs(list) do
		v:setVisible(false)
		v:runAction(self:getFadeInAction(0.6))
	end
end

function DWellPet:doActionFadeOut( ... )
	local list = self:getFadeOutNodeArray()
	for k,v in pairs(list) do
		v:runAction(self:getFadeOutAction(0.6))
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DWellPet, "DWellPet")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DWellPet", DWellPet)
