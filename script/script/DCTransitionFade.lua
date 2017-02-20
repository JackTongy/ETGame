local Config = require "Config"
local constants = require 'framework.basic.Constants'
local layerManager = require "framework.interface.LuaLayerManager"
local DIndicator = require 'DIndicator'

local DCTransitionFade = class(LuaDialog)

function DCTransitionFade:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DCTransitionFade.cocos.zip")
    return self._factory:createDocument("DCTransitionFade.cocos")
end

--@@@@[[[[
function DCTransitionFade:onInitXML()
    local set = self._set
end
--@@@@]]]]

--------------------------------override functions----------------------

function DCTransitionFade:onInit( userData, netData )
	self._index = constants.NET_VIEW_INDEX

	self._colorLayer = CCLayerGradient:create(ccc4(0, 11, 25, 255), ccc4(2, 26, 60, 255), ccp(0, -1))
	local x,y = self._colorLayer:getPosition()
		
	if not self._colorLayer.removeFromParent then
		self._colorLayer.removeFromParent = function ( node )
			node:removeFromParentAndCleanup(true)
		end
	end
	self:setLayer(self._colorLayer)

	local delay = (userData and userData.delay) or 0.2
	local callback = userData and userData.callback
	local actions = CCArray:create()
	actions:addObject(CCFadeIn:create(delay))
	actions:addObject(CCCallFunc:create(function ( ... )
		if callback then
			callback()
		end
	end))
	self._colorLayer:setOpacity(0)
	local seq = CCSequence:create(actions)
	self._colorLayer:runAction(seq)

	DIndicator.setRectAlpha(0)
end

function DCTransitionFade:onBack( userData, netData )
	
end

function DCTransitionFade:close( ... )
	DIndicator.resetRectAlpha()
end
--------------------------------custom code-----------------------------
function DCTransitionFade:closeDelay( data )
	self:fadeOut(data)	
end

function DCTransitionFade:fadeOut( data )
	local actions =  CCArray:create()
	actions:addObject(CCFadeOut:create((data and data.delay) or 0.2))
	actions:addObject(CCCallFunc:create(function ()
		self:close()
	end))
	self._colorLayer:runAction(CCSequence:create(actions))
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DCTransitionFade, "DCTransitionFade")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DCTransitionFade", DCTransitionFade)

local TransitionCtrl = {}
local Cnt = 0


local showTransition = function ( delay,callback )

	local show = GleeCore:isRunningLayer('DCTransitionFade')

	if Cnt > 0 and not show then
		GleeCore:showLayer('DCTransitionFade',{delay=delay,callback=callback})
	elseif Cnt <= 0 and show then
		view = layerManager.getRunningLayer('DCTransitionFade')
		if view then
			view:closeDelay({delay=delay,callback=callback})
			view = nil
		end
	end
	
end

TransitionCtrl.show = function ( delay,callback )
	Cnt = Cnt + 1
	showTransition(delay,callback)
end

TransitionCtrl.hide = function ( )
	Cnt = Cnt - 1
	if Cnt < 0 then 
		Cnt = 0 
	end
	showTransition()
end

TransitionCtrl.reset = function ( )
	Cnt = 0
	showTransition()
end

return TransitionCtrl
