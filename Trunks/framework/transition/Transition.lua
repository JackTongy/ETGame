require "framework.basic.BasicClass"

local Transition = class()

function Transition:ctor(t)
	local transition = GleeTransitionShell:create()	
	self._isInControllerOnTop = true
	self._duration = t
	self._transition = transition
	transition:registerScriptHandler(function( )
		self:onBegin()
	end)
end

function Transition:setInControllerOnTop( istop )
	self._isInControllerOnTop = istop
end

function Transition:isInControllerOnTop( )
	return self._isInControllerOnTop
end

function Transition:setTarget( transition )
	self._transition = transition
end

function Transition:getTarget( )
	return self._transition
end

function Transition:setDuration( duration )
	self._duration = duration
end

function Transition:getDuration( )
	return self._duration
end

function Transition:onBegin( )
	self:drawController()
	self:runTransition()
end

function Transition:runTransition()

end

function Transition:drawController()
	local outController = self:getTarget():getOutController()
	local inController = self:getTarget():getInController()

	if outController then
		local outLayer = outController:getLayer()
		if outLayer:getParent() == nil then
			GleeCore:getControllerLayer():addChild(outLayer, 1)
		else 
			GleeCore:getControllerLayer():reorderChild(outLayer, 1)
		end
	end

	if inController then
		local inLayer = inController:getLayer()
		if inLayer:getParent() == nil then
			if self:isInControllerOnTop() then 
				GleeCore:getControllerLayer():addChild(inLayer, 2)
			else
				GleeCore:getControllerLayer():addChild(inLayer, 0)
			end
		end
	end
end

function Transition:hideOutShowIn()
	local outController = self:getTarget():getOutController()
	local inController = self:getTarget():getInController()

	if outController then
		outController:getLayer():setVisible(false)
	end

	if inController then
		inController:getLayer():setVisible(true)
	end
end

function Transition:finish()
	local scriptId
	local unschedule = function()
		CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(scriptId)
		self:getTarget():setNewController(0)
	end

	scriptId = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(unschedule, 0, false)
end


return Transition