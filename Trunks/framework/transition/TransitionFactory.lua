local TransitionMoveRightToLeft = require "framework.transition.TransitionMoveRightToLeft"
local TransitionFade = require "framework.transition.TransitionFade"

local TransitionFactory = {}

---------------已支持的TransitionType---------------
TransitionFactory.Type = {
	tCustom = 1,
	tFadeOutIn = 2,
	tMoveRightToLeft = 3
}

function TransitionFactory:getTransition( mTime, mType )
	if mType == self.Type.tCustom then
		--c++实现
		return GleeTransitionCustom:create(mTime)

	elseif mType == self.Type.tFadeOutIn then
	
		local transition = TransitionFade.new(mTime)
		return transition:getTarget()
		--c++实现
		-- return GleeTransitionFadeOutIn:create(mTime)
	elseif mType == self.Type.tMoveRightToLeft then
		local transition = TransitionMoveRightToLeft.new(mTime)
		return transition:getTarget()

	else	
		print("Transition "..tostring(mType).." is not implement")
		return nil
	end
end

return TransitionFactory