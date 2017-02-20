local Config = require "Config"
local res = require "Res"

local DDungeonAnswerQuestion = class(LuaDialog)

function DDungeonAnswerQuestion:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DDungeonAnswerQuestion.cocos.zip")
    return self._factory:createDocument("DDungeonAnswerQuestion.cocos")
end

--@@@@[[[[
function DDungeonAnswerQuestion:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_content = set:getRichLabelNode("bg_content")
    self._bg_layer1 = set:getElfNode("bg_layer1")
    self._bg_layer1_btn1 = set:getClickNode("bg_layer1_btn1")
    self._bg_layer1_btn1_text = set:getLabelNode("bg_layer1_btn1_text")
    self._bg_layer1_btn2 = set:getClickNode("bg_layer1_btn2")
    self._bg_layer1_btn2_text = set:getLabelNode("bg_layer1_btn2_text")
    self._bg_layer2 = set:getElfNode("bg_layer2")
    self._bg_layer2_btn1 = set:getClickNode("bg_layer2_btn1")
    self._bg_layer2_btn1_text = set:getLabelNode("bg_layer2_btn1_text")
    self._bg_layer2_btn2 = set:getClickNode("bg_layer2_btn2")
    self._bg_layer2_btn2_text = set:getLabelNode("bg_layer2_btn2_text")
    self._bg_layer2_btn3 = set:getClickNode("bg_layer2_btn3")
    self._bg_layer2_btn3_text = set:getLabelNode("bg_layer2_btn3_text")
    self._bg_layer2_btn4 = set:getClickNode("bg_layer2_btn4")
    self._bg_layer2_btn4_text = set:getLabelNode("bg_layer2_btn4_text")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DDungeonAnswerQuestion:onInit( userData, netData )
	res.doActionDialogShow(self._bg)

	self._bg_content:setString(userData.question)
	self._bg_layer1:setVisible(#userData.answerdata == 2)
	self._bg_layer2:setVisible(#userData.answerdata == 4)

	if #userData.answerdata == 2 then
		for i=1,#userData.answerdata do
			self[string.format("_bg_layer1_btn%d", i)]:setListener(function ( ... )
				res.doActionDialogHide(self._bg, self)
				userData.callback(i == userData.answer)
			end)
		end
	elseif #userData.answerdata == 4 then
		for i=1,#userData.answerdata do
			self[string.format("_bg_layer2_btn%d", i)]:setListener(function ( ... )
				res.doActionDialogHide(self._bg, self)
				userData.callback(i == userData.answer)
			end)
			self[string.format("_bg_layer2_btn%d_text", i)]:setString(userData.answerdata[i])
		end
	end

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	require "LangAdapter".LabelNodeSetHorizontalAlignmentIfArabic( self._bg_content )
end

function DDungeonAnswerQuestion:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DDungeonAnswerQuestion, "DDungeonAnswerQuestion")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DDungeonAnswerQuestion", DDungeonAnswerQuestion)


