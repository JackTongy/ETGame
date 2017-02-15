local Transition = require "framework.transition.Transition"

------------以下是Transition的具体实现------------
local TransitionMoveRightToLeft = class(Transition)

function TransitionMoveRightToLeft:runTransition()

	local outController = self:getTarget():getOutController()
	local inController = self:getTarget():getInController()

	local actions = CCArray:create()
	if outController then
		local layer = outController:getLayer()
		local moveout = CCMoveBy:create(self:getDuration() / 2, CCPoint(-layer:getContentSize().width, 0))
		local action = CCTargetedAction:create(layer, moveout)
		actions:addObject(action)
	end
    
	actions:addObject( CCCallFunc:create( function()
		self:hideOutShowIn() 
	end))

	if inController then
		local layer = inController:getLayer()
		layer:setPosition(CCPoint(layer:getContentSize().width, 0))
		local moveIn = CCMoveBy:create(self:getDuration() / 2, CCPoint(-layer:getContentSize().width, 0))
		local action = CCTargetedAction:create(layer, moveIn)
		actions:addObject(action)
	end
    
    actions:addObject( CCCallFunc:create( function() 
    	self:finish() 
    end))
    
    GleeCore:getRootScene():runAction(CCSequence:create(actions));
end


return TransitionMoveRightToLeft