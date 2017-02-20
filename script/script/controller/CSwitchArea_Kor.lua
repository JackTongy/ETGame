local Config = require "Config"
local res = require "Res"
local eventCenter = require 'EventCenter'
local gameFunc = require "AppData"
local CSwitchArea_Kor = class(LuaController)

function CSwitchArea_Kor:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."CSwitchArea_Kor.cocos.zip")
    return self._factory:createDocument("CSwitchArea_Kor.cocos")
end

--@@@@[[[[
function CSwitchArea_Kor:onInitXML()
	local set = self._set
    self._bg = set:getElfNode("bg")
    self._bg_btnArea1 = set:getClickNode("bg_btnArea1")
    self._bg_btnArea1_pressed = set:getElfNode("bg_btnArea1_pressed")
    self._bg_btnArea1_lock = set:getElfNode("bg_btnArea1_lock")
    self._bg_btnArea1_atBg = set:getElfNode("bg_btnArea1_atBg")
    self._bg_btnArea1_atBg_at = set:getElfNode("bg_btnArea1_atBg_at")
    self._bg_btnArea2 = set:getClickNode("bg_btnArea2")
    self._bg_btnArea2_pressed = set:getElfNode("bg_btnArea2_pressed")
    self._bg_btnArea2_lock = set:getElfNode("bg_btnArea2_lock")
    self._bg_btnArea2_atBg = set:getElfNode("bg_btnArea2_atBg")
    self._bg_btnArea2_atBg_at = set:getElfNode("bg_btnArea2_atBg_at")
    self._bg_btnArea3 = set:getClickNode("bg_btnArea3")
    self._bg_btnArea3_pressed = set:getElfNode("bg_btnArea3_pressed")
    self._bg_btnArea3_lock = set:getElfNode("bg_btnArea3_lock")
    self._bg_btnArea3_atBg = set:getElfNode("bg_btnArea3_atBg")
    self._bg_btnArea3_atBg_at = set:getElfNode("bg_btnArea3_atBg_at")
    self._bg_btnArea4 = set:getClickNode("bg_btnArea4")
    self._bg_btnArea4_pressed = set:getElfNode("bg_btnArea4_pressed")
    self._bg_btnArea4_lock = set:getElfNode("bg_btnArea4_lock")
    self._bg_btnArea4_atBg = set:getElfNode("bg_btnArea4_atBg")
    self._bg_btnArea4_atBg_at = set:getElfNode("bg_btnArea4_atBg_at")
    self._bg_btnArea5 = set:getClickNode("bg_btnArea5")
    self._bg_btnArea5_pressed = set:getElfNode("bg_btnArea5_pressed")
    self._bg_btnArea5_lock = set:getElfNode("bg_btnArea5_lock")
    self._bg_btnArea5_atBg = set:getElfNode("bg_btnArea5_atBg")
    self._bg_btnArea5_atBg_at = set:getElfNode("bg_btnArea5_atBg_at")
    self._bg_btnReturn = set:getClickNode("bg_btnReturn")
end
--@@@@]]]]

--------------------------------override functions----------------------
function CSwitchArea_Kor:onInit( userData, netData )
	local function switchArea( areaId )
		if areaId ~= userData.areaId then
			gameFunc.getTempInfo().setLastAreaId(areaId)
			gameFunc.getTownInfo().setLastTownId(nil)
			gameFunc.getTempInfo().setValueForKey("SwitchAreaId", areaId)
		end
		GleeCore:popController(nil, res.getTransitionFade())
	end
	
	local openAreaId = gameFunc.getTempInfo().getAreaId()
--	local shadePicList = {"change_guandong.png", "change_shenao.png", "change_chengdu.png", "change_fengyuan.png", "change_hezhong.png"}
	for i=1,5 do
		-- local shadeerNode = ShaderNode:create()
		-- shadeerNode:setResid(shadePicList[i])
		-- shadeerNode:setShaderVertFrag(NULL, "shaders/elf_outline.fsh")
		-- self[string.format("_bg_btnArea%d_pressed", i)]:addChild(shadeerNode)
		self[string.format("_bg_btnArea%d", i)]:setEnabled(i <= openAreaId)
		self[string.format("_bg_btnArea%d", i)]:setListener(function (  )
			switchArea(i)
		end)
		
		self[string.format("_bg_btnArea%d_lock", i)]:setVisible(i > openAreaId)
		self[string.format("_bg_btnArea%d_atBg", i)]:setVisible(i == userData.areaId)
		if i == userData.areaId then
			local actArray = CCArray:create()
			actArray:addObject(CCPlace:create(ccp(0, 20)))
			actArray:addObject(CCMoveBy:create(1, ccp(0, 10)))
			actArray:addObject(CCMoveBy:create(1, ccp(0, -10)))
			self[string.format("_bg_btnArea%d_atBg_at", i)]:stopAllActions()
			self[string.format("_bg_btnArea%d_atBg_at", i)]:runAction(CCRepeatForever:create(CCSequence:create(actArray)))
		end
	end
	self._bg_btnReturn:setTriggleSound(res.Sound.back)
	self._bg_btnReturn:setListener(function (  )
		switchArea(userData.areaId)
	end)
end

function CSwitchArea_Kor:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(CSwitchArea_Kor, "CSwitchArea_Kor")


--------------------------------register--------------------------------
GleeCore:registerLuaController("CSwitchArea_Kor", CSwitchArea_Kor)


