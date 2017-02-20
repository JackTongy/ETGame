local Config = require "Config"

local CHomeMain = class(LuaController)

function CHomeMain:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."CHomeMain.cocos.zip")
    return self._factory:createDocument("CHomeMain.cocos")
end

--@@@@[[[[
function CHomeMain:onInitXML()
    local set = self._set
   self._FarBg = set:getElfNode("FarBg")
   self._FarBg_linearlayout_linearlayout_a = set:getElfNode("FarBg_linearlayout_linearlayout_a")
   self._FarBg_linearlayout_linearlayout_b = set:getElfNode("FarBg_linearlayout_linearlayout_b")
   self._FarBg_linearlayout_linearlayout_c = set:getElfNode("FarBg_linearlayout_linearlayout_c")
   self._FarBg_linearlayout_linearlayout_d = set:getElfNode("FarBg_linearlayout_linearlayout_d")
   self._FarBg_linearlayout_linearlayout_a = set:getElfNode("FarBg_linearlayout_linearlayout_a")
   self._FarBg_linearlayout_linearlayout_b = set:getElfNode("FarBg_linearlayout_linearlayout_b")
   self._FarBg_linearlayout_linearlayout_c = set:getElfNode("FarBg_linearlayout_linearlayout_c")
   self._FarBg_linearlayout_linearlayout_d = set:getElfNode("FarBg_linearlayout_linearlayout_d")
   self._map = set:getMapNode("map")
   self._map_container_bg = set:getElfNode("map_container_bg")
   self._map_container_bg_linearlayout_a = set:getElfNode("map_container_bg_linearlayout_a")
   self._map_container_bg_linearlayout_linearlayout_a = set:getElfNode("map_container_bg_linearlayout_linearlayout_a")
   self._map_container_bg_linearlayout_linearlayout_b = set:getElfNode("map_container_bg_linearlayout_linearlayout_b")
   self._map_container_bg_linearlayout_linearlayout_c = set:getElfNode("map_container_bg_linearlayout_linearlayout_c")
   self._map_container_bg_linearlayout_linearlayout_d = set:getElfNode("map_container_bg_linearlayout_linearlayout_d")
   self._map_container_bg_linearlayout_linearlayout_e = set:getElfNode("map_container_bg_linearlayout_linearlayout_e")
   self._map_container_bg_btnArean = set:getClickNode("map_container_bg_btnArean")
   self._map_container_bg_btnArean_laba = set:getFlashMainNode("map_container_bg_btnArean_laba")
end
--@@@@]]]]

--------------------------------override functions----------------------

function CHomeMain:onInit( userData, netData )
   print("CHomeMain onInit")

   self._map:getMoveNode():setPosition(ccp(0, 0))
   self._map:onRestrict(nil)
  
  local w1 = self._FarBg:getContentSize().width
   local w2 = self._map:getMoveNode():getContentSize().width
   local winWidth = CCDirector:sharedDirector():getWinSize().width
   local rate = (w1 - winWidth) / (w2 - winWidth)
   local timerHelper = require "framework.sync.TimerHelper"
   self.tickMap = timerHelper.tick(function ( dt )
      local mapX, mapY = self._map:getMoveNode():getPosition()

      self._FarBg:setPosition(ccp(mapX * rate, mapY))
   end)

   print("CHomeMain onInit 2")
   self:playflash(self._map_container_bg_btnArean_laba)

   self._map_container_bg_btnArean:setListener(function ( ... )
   -- body
      print("Enter Home Btn Clicked")
   end)
end

function CHomeMain:onBack( userData, netData )
	
end

function CHomeMain:playswf( name,shapeMap,node, scale)
   local Swf = require 'framework.swf.Swf'
   print("swfName = " .. name)
   local myswf = Swf.new(name)
   myswf:getRootNode():setPosition(ccp(0,0))
   node:addChild( myswf:getRootNode() )
   myswf:getRootNode():setScale(scale or 1.0)
   myswf:playLoop(shapeMap)
end


function CHomeMain:playflash( flashNode )
   -- body
   assert(flashNode.getModifierControllerByName)
   local c = flashNode:getModifierControllerByName('swf')
   c:setLoopMode(LOOP)
   c:setLoops(999999999)
   flashNode:play("swf")
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(CHomeMain, "CHomeMain")


--------------------------------register--------------------------------
GleeCore:registerLuaController("CHomeMain", CHomeMain)
