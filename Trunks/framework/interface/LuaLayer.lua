require 'framework.interface.LuaInterface'

LuaLayer = class(LuaInterface)

function LuaLayer:ctor()
	print("create LuaLayer")

	self._showState = 'hide'
end

function LuaLayer:getNetModel()
	
end

function LuaLayer:getType()
	-- body
	return 'Layer'
end

function LuaLayer:setIndex( index )
	self._index = index
end

function LuaLayer:getIndex()
	-- body
	return self._index
end

function LuaLayer:setHideActionName( name )
	-- body
	self._hideActionName = name
end

function LuaLayer:setShowActionName( name )
	-- body
	self._showActionName = name
end

function LuaLayer:show(func)

	if self._showState ~= 'show' then

		self._showState = 'show'

		local function first()
			self:createGleeEventListener()
			func()
		end
		first()

		-- body
		-- add -> run action
		-- run action -> remove
		if self._showActionName then
			local myLayer = self:getLayer()
			local action = self._set:getElfAction(self._showActionName)

			if action then
				myLayer:runAction( action:clone() )
			end
		end
	else
		print(string.format('warnings: %s called show-func unexpected!', tostring(self:getName())))
	end
	--self:onInit( self:getUserData(), self:getNetData() )
end

function LuaLayer:hide(func) 
	-- body 
	if self._showState ~= 'hide' then
		self._showState = 'hide'

		local function finally() 
		-- body
			self:destoryGleeEventListener()
			self:releaseMembers()
			func()
		end

		if self._hideActionName then
			local myLayer = self:getLayer()
			local action = self._set:getElfAction(self._hideActionName)

			if action then
				local clone = action:clone()
				clone:setListener( finally )
				myLayer:runAction( clone )
			else
				finally()
			end
		else
			finally()
		end
	else
		print(string.format('warnings: %s called hide-func unexpected!', tostring(self:getName())))
	end
end

function LuaLayer:registerEventLC(event,func)
    -- body
    assert(event and func and type(event) == "number" and type(func) == "function","registerEvent arg invalid!")

    local eventListener = self._eventListener
    eventListener:addEvent(event,func)
end

function LuaLayer:createGleeEventListener()
	-- body
	self._eventListener = GleeEventListener:createWithTarget(nil)
	self._eventListener:active()
end

function LuaLayer:destoryGleeEventListener()
	-- body
	self._eventListener:resign()
end

require 'framework.basic.MetaHelper'.classDefinitionEnd(LuaLayer, 'LuaLayer')

