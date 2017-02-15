local controller_map = {}

--------------------------------Glee Core Redirect--------------------------------
local top_user_data_map = {}
local top_net_data_map = {}

----------------------------------controller----------------------------------------
local function cleanUnusedTexture()
	-- body
	require 'framework.sync.TimerHelper'.tick(function ()
		-- body
		SystemHelper:cleanUnusedTexture()
		return true
	end)
end

local function checkControllerCheckIn(name)
	-- body
	assert(name, name)
	if not controller_map[name] then
		print('Do Load G '..name)
		require (name)
	end
end


local RAW_GleeCore_registerLuaController = GleeCore.registerLuaController
GleeCore.registerLuaController = function (self, name, class )
	
	assert(controller_map[name] == nil, string.format('controller %s has already checked in !', name))
	assert(class and type(class) == 'table', type(class)..':'..name)

	controller_map[name] = class

	--called from C++
	RAW_GleeCore_registerLuaController(self, name, function ( target )
		
		local obj = class.new() 
		obj:setName(name)
		
		--bind C++ <-> Lua
   		obj:setTarget(target) 
   		target:registerScriptHandler(function(state, enable) 
   			if state == tOnInit or state == tOnBack then
   				obj:setUserData( top_user_data_map[name] )
   				obj:setNetData( top_net_data_map[name] )
   			end

   			if state == tOnRelease then
   				top_user_data_map[name] = nil
   				top_net_data_map[name] = nil
   			end

        	return obj:onState(state, enable) 
        end)

   		obj:loadXML()
	end)
end 

local RAW_GleeCore_pushController = GleeCore.pushController
GleeCore.pushController = function (self, name, data, controller, transition,netdata)
	checkControllerCheckIn(name)

	top_user_data_map[name] = data
	top_net_data_map[name] = netdata

	if type(data) ~= 'userdata' then
		RAW_GleeCore_pushController(self, name, nil, controller, transition)
	else
		RAW_GleeCore_pushController(self, name, data, controller, transition)
	end

	-- top_user_data = nil
	-- top_net_data = netdata

	cleanUnusedTexture()
end

local RAW_GleeCore_pushTop = GleeCore.pushTop
GleeCore.pushTop = function ( self,name,data,controller,transition,netdata )
	top_user_data_map[name] = data
	top_net_data_map[name] = netdata

	if type(data) ~= 'userdata' then
		RAW_GleeCore_pushTop(self, name, nil, controller, transition)
	else
		RAW_GleeCore_pushTop(self, name, data, controller, transition)
	end

	-- top_user_data = nil
	-- top_net_data = netdata

	cleanUnusedTexture()
end

local RAW_GleeCore_replaceController = GleeCore.replaceController
GleeCore.replaceController = function (self, name, data, controller, transition,netdata)

	checkControllerCheckIn(name)

	top_user_data_map[name] = data
	top_net_data_map[name] = netdata

	if type(data) ~= 'userdata' then
		RAW_GleeCore_replaceController(self, name, nil, controller, transition)
	else 
		RAW_GleeCore_replaceController(self, name, data, controller, transition)
	end

	-- top_user_data = nil
	-- top_net_data = nil

	cleanUnusedTexture()
end

--GleeController* controllerObject = NULL, GleeTransitionShell* transition = NULL
local RAW_GleeCore_popController = GleeCore.popController
GleeCore.popController = function ( self, controllerObject, transition )
	-- body
	RAW_GleeCore_popController(self, controllerObject, transition)

	cleanUnusedTexture()
end

GleeCore.popController0 = function ( self,name, controllerObject, transition,netdata )
	-- body
	top_net_data_map[name] = netdata
	RAW_GleeCore_popController(self, controllerObject, transition)

	cleanUnusedTexture()
end


--const char* controllername,GleeController* controllerObject = NULL,GleeTransitionShell* transition = NULL
local RAW_GleeCore_popControllerAboveAnd = GleeCore.popControllerAboveAnd
GleeCore.popControllerAboveAnd = function (self, controllername, controllerObject, transition)
	-- body
	RAW_GleeCore_popControllerAboveAnd(self, controllername, controllerObject, transition)

	cleanUnusedTexture()
end

--const char* controllername,GleeController* controllerObject = NULL, GleeTransitionShell* transition = NULL
local RAW_GleeCore_popControllerTo = GleeCore.popControllerTo
GleeCore.popControllerTo = function ( self, controllername, controllerObject, transition )
	-- body
	RAW_GleeCore_popControllerTo(self, controllername, controllerObject, transition)

	cleanUnusedTexture()
end

GleeCore.popControllerTo0 = function ( self,name,data,controllerObject, transition,netdata)
	-- controller userData transmit in lua
	top_user_data_map[name] = data
	top_net_data_map[name] = netdata

	RAW_GleeCore_popControllerTo(self, name, controllerObject, transition)

	-- top_user_data = nil
	-- top_net_data = netdata

	cleanUnusedTexture()
end
----------------------------------------load controller-----------------------------------------


local function loadToController( pushOrReplace, name, data, transitionControllerName, data2, transition )
	--body
	checkControllerCheckIn(transitionControllerName)

	local transitionClass = controller_map[transitionControllerName]
	assert(transitionClass ~= nil, string.format('controller %s has not checked in !', transitionControllerName))

	local transitionObj = transitionClass.new()
	transitionObj:setUserData(data2)
	transitionObj:setName(transitionControllerName)
	transitionObj:loadXML()

	assert(transitionObj.setProgress ~= nil, string.format('controller %s has not setProgress !', transitionControllerName))
	
	local loaderfunction = function()

		checkControllerCheckIn(name)

		local class = controller_map[name]

		assert(class ~= nil, string.format('controller %s has not checked in !', name))

		local obj = class.new()
		obj:setUserData(data)
		obj:setName(name)
		
		local netProgress = 0
		local xmlProgress = 0

		local function do_progress()
			local pValue = netProgress + xmlProgress
			transitionObj:setProgress(pValue)

			if pValue >= 100 then
				GleeCore:replaceController(name, nil, obj:getTarget(), transition)
			end
		end

	 	local loader = ElfLoader:shared()
	 	loader:setLoadEnable(true)
	 	loader:setLoadTimePerFrame(2)
	 	loader:setListener( function(progress)
	    	if progress >= 100 then
	    		xmlProgress = 95
	    	else
	    		xmlProgress = progress * 0.94
	    	end

	    	do_progress()
	    end)

	    obj:loadXML()
	    obj:loadNet(nil, function(data, tag, code, errorBuf)
	    	obj:setNetData(data)
	    	netProgress = 5
	    	do_progress()
	    end) 
	end  

	transitionObj:addStateListener(function(state)
		if state == tOnInTransitionEnd then
			loaderfunction()
		end
	end)
	
	if pushOrReplace then
		GleeCore:pushController(transitionControllerName, nil, transitionObj:getTarget(), transition)
	else
		GleeCore:replaceController(transitionControllerName, nil, transitionObj:getTarget(), transition)
	end
end

GleeCore.load2PushController = function ( self, name, data, transitionControllerName, data2, transition)
	--body
	loadToController(true, name, data, transitionControllerName, data2, transition)
end

GleeCore.load2ReplaceController = function ( self, name, data, transitionControllerName, data2, transition)
	--body
	loadToController(false, name, data, transitionControllerName, data2, transition)
end


-- local 

--[[
layers like menu, dialog, netView...
--]]
local layerManager = require "framework.interface.LuaLayerManager"
GleeCore.registerLuaLayer = function( self, name, creator )
	-- body
	layerManager.check(name, creator)
end

GleeCore.showLayer = function ( self, name, data, sub ,netdata)
	-- body
	return layerManager.show(name, data, sub,netdata)
end

GleeCore.hideLayer = function ( self, name, data, sub )
	-- body
	return layerManager.hide(name, data, sub)
end

GleeCore.getRunningLayer = function ( self, name, sub )
	-- body
	return layerManager.getRunningLayer(name, sub)
end

GleeCore.isRunningLayer = function ( self, name, sub )
	-- body
	return layerManager.isRunning(name, sub)
end

GleeCore.refreshAllLayer = function ( self )
	-- body
	return layerManager.refresh()
end

GleeCore.closeAllLayers = function ( self )
	-- body
	layerManager.closeAll()
end

--[[
name1, data1, sub1 对应 目标layer参数
name2, data2, sub2 对应 loading-layer参数
--]]
GleeCore.load2layer = function (self, name1, data1, sub1, name2, data2, sub2)
	-- body
	return layerManager.load2layer(name1, data1, sub1, name2, data2, sub2)
end

local EventCenter = require 'framework.event.EventCenter'
--[[
	事件发送统一入口
	当事件中心无法根据参数来识别时，事件向两个中心依次发送
	当且仅当 eventname 为 number 且 arg 为userdata 向c++实现的事件中心进行发送

	eventname : number 
				string 
	arg : 
	groupname : 可以为nil 详见见EventCenter的功能描述
]]
GleeCore.eventInput = function(self,eventname,arg,groupname,tag)

	if eventname and type(eventname) == "number" and ((arg and type(arg) == "userdata") or arg == nil) then
		GleeCore:eventInputLC(eventname,arg,tag or 0)
	else
		EventCenter.eventInput(tostring(eventname),arg,groupname)	
	end
	
end

GleeCore.initControllerInstance = function (self, controllername )
	GleeControllerManager:getInstance():initControllerInstance(controllername)	
end

