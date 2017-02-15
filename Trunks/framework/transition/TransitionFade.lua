local Transition = require "framework.transition.Transition"
local constants = require 'framework.basic.Constants'

------------以下是Transition的具体实现------------
local TransitionFade = class(Transition)

function TransitionFade:runTransition()
	local outController = self:getTarget():getOutController()
	local inController = self:getTarget():getInController()

	if inController and inController:getLayer() then
		inController:getLayer():setVisible(false)
	end
	
	local l = self:getColorLayer()
	GleeCore:getRootScene():addChild(l,constants.NET_VIEW_INDEX)

	local actions = CCArray:create()
	actions:addObject(CCFadeIn:create(self:getDuration()/2))
	actions:addObject( CCCallFunc:create( function()
		self:hideOutShowIn() 
	end))
	actions:addObject(CCFadeOut:create(self:getDuration()/2))
	actions:addObject( CCCallFunc:create( function() 
		self:finish() 
	end))
	actions:addObject(CCCallFunc:create(function ()
		l:removeFromParentAndCleanup(true)
	end))
	local seq = CCSequence:create(actions)
	l:runAction(seq)
end

function TransitionFade:getColorLayer(  )
	local colorLayer = CCLayerGradient:create(ccc4(0, 11, 25, 255), ccc4(2, 26, 60, 255), ccp(0, -1))
	colorLayer:setOpacity(0)
	return colorLayer
end

return TransitionFade