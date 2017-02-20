local Config = require "Config"

local TimeLimitPet = class(LuaController)

function TimeLimitPet:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TimeLimitPet.cocos.zip")
    return self._factory:createDocument("TimeLimitPet.cocos")
end

--@@@@[[[[
function TimeLimitPet:onInitXML()
	local set = self._set
    self._bg_petLayout = set:getLinearLayoutNode("bg_petLayout")
    self._clip_pet = set:getElfNode("clip_pet")
    self._clip_btn = set:getButtonNode("clip_btn")
    self._clip_starLayout = set:getLayoutNode("clip_starLayout")
    self._bg_nextFree = set:getElfNode("bg_nextFree")
    self._bg_nextFree_time = set:getTimeNode("bg_nextFree_time")
    self._bg_freeBtn = set:getClickNode("bg_freeBtn")
    self._bg_diamondBtn = set:getClickNode("bg_diamondBtn")
    self._bg_diamondBtn1 = set:getClickNode("bg_diamondBtn1")
    self._bg_diamondBtn1_text = set:getLabelNode("bg_diamondBtn1_text")
    self._bg_status1 = set:getElfNode("bg_status1")
    self._bg_status1_count = set:getLabelNode("bg_status1_count")
    self._bg_status2 = set:getClipNode("bg_status2")
    self._bg_scoreBg_btn = set:getButtonNode("bg_scoreBg_btn")
    self._bg_scoreBg_title_checkTip = set:getLabelNode("bg_scoreBg_title_checkTip")
    self._bg_scoreBg_layout = set:getLinearLayoutNode("bg_scoreBg_layout")
    self._rank = set:getLabelNode("rank")
    self._name = set:getLabelNode("name")
    self._score = set:getLabelNode("score")
    self._gift = set:getElfNode("gift")
    self._bg_timerBg = set:getJoint9Node("bg_timerBg")
    self._bg_timerBg_layout = set:getLinearLayoutNode("bg_timerBg_layout")
    self._bg_timerBg_layout_ActCountDownTime = set:getTimeNode("bg_timerBg_layout_ActCountDownTime")
    self._bg_coinBg_diamondCount = set:getLabelNode("bg_coinBg_diamondCount")
    self._bg_scoreLayout_myScore = set:getLabelNode("bg_scoreLayout_myScore")
    self._bg_rankLayout_myRank = set:getLabelNode("bg_rankLayout_myRank")
--    self._@view = set:getElfNode("@view")
--    self._@petItem = set:getElfNode("@petItem")
--    self._@star = set:getElfNode("@star")
--    self._@player = set:getElfNode("@player")
end
--@@@@]]]]

--------------------------------override functions----------------------
function TimeLimitPet:onInit( userData, netData )
	
end

function TimeLimitPet:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TimeLimitPet, "TimeLimitPet")


--------------------------------register--------------------------------
GleeCore:registerLuaController("TimeLimitPet", TimeLimitPet)


