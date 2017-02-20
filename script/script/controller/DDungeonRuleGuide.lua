local Config = require "Config"
local res = require "Res"
local GuideHelper = require 'GuideHelper'

local DDungeonRuleGuide = class(LuaDialog)

function DDungeonRuleGuide:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DDungeonRuleGuide.cocos.zip")
    return self._factory:createDocument("DDungeonRuleGuide.cocos")
end

--@@@@[[[[
function DDungeonRuleGuide:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_btnOk = set:getClickNode("bg_btnOk")
    self._bg_item1 = set:getElfNode("bg_item1")
    self._bg_item1_icon = set:getElfNode("bg_item1_icon")
    self._bg_item1_name = set:getLabelNode("bg_item1_name")
    self._bg_item1_unClear = set:getElfNode("bg_item1_unClear")
    self._bg_item1_isBoss = set:getElfGrayNode("bg_item1_isBoss")
    self._bg_item2 = set:getElfNode("bg_item2")
    self._bg_item2_icon = set:getElfNode("bg_item2_icon")
    self._bg_item2_name = set:getLabelNode("bg_item2_name")
    self._bg_item2_unClear = set:getElfNode("bg_item2_unClear")
    self._bg_item2_isBoss = set:getElfGrayNode("bg_item2_isBoss")
    self._bg_item3 = set:getElfNode("bg_item3")
    self._bg_item3_icon = set:getElfNode("bg_item3_icon")
    self._bg_item3_name = set:getLabelNode("bg_item3_name")
    self._bg_item3_unClear = set:getElfNode("bg_item3_unClear")
    self._bg_item3_isBoss = set:getElfGrayNode("bg_item3_isBoss")
    self._bg_item4 = set:getElfNode("bg_item4")
    self._bg_item4_icon = set:getElfNode("bg_item4_icon")
    self._bg_item4_name = set:getLabelNode("bg_item4_name")
    self._bg_item4_unClear = set:getElfNode("bg_item4_unClear")
    self._bg_item4_isBoss = set:getElfGrayNode("bg_item4_isBoss")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DDungeonRuleGuide:onInit( userData, netData )
	local petClearList = userData.petClearList

	res.doActionDialogShow(self._bg)

	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_btnOk:setTriggleSound(res.Sound.yes)
	self._bg_btnOk:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)

	local petFunc = require "AppData".getPetInfo()
	for i=1,4 do
		if i <= #petClearList then
			self[string.format("_bg_item%d_name", i)]:setString(petClearList[i].name)
			self[string.format("_bg_item%d_unClear", i)]:setVisible(petClearList[i].isFinish)
			if petClearList[i].isFinish then
				res.setNodeWithPetGray(self[string.format("_bg_item%d_icon", i)], petFunc.getPetInfoByPetId( petClearList[i].petId ))
				self[string.format("_bg_item%d_name", i)]:setFontFillColor(ccc4f(0.62, 0.588, 0.478, 1.0), true)
			else
				res.setNodeWithPet(self[string.format("_bg_item%d_icon", i)], petFunc.getPetInfoByPetId( petClearList[i].petId ))
				self[string.format("_bg_item%d_name", i)]:setFontFillColor(ccc4f(0.60392,0.38039,0.1098,1.0), true)
			end
			self[string.format("_bg_item%d_isBoss", i)]:setVisible(petClearList[i].isBoss)
			self[string.format("_bg_item%d_isBoss", i)]:setGrayEnabled(petClearList[i].isFinish)
		else
			self[string.format("_bg_item%d_icon", i)]:setResid("N_ZY_xkkkk.png")
			self[string.format("_bg_item%d_icon", i)]:setScale(0.8 * 155 / 92)
			self[string.format("_bg_item%d_name", i)]:setVisible(false)
			self[string.format("_bg_item%d_unClear", i)]:setVisible(false)
			self[string.format("_bg_item%d_isBoss", i)]:setVisible(false)
		end
	end

	GuideHelper:check('DDungeonRuleGuide')
end

function DDungeonRuleGuide:onBack( userData, netData )
	
end

function DDungeonRuleGuide:close( ... )
	GuideHelper:check('AnimtionEnd')
end
--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DDungeonRuleGuide, "DDungeonRuleGuide")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DDungeonRuleGuide", DDungeonRuleGuide)
