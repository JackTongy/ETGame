local MetaHelper 			= require 'framework.basic.MetaHelper'
local Timer 				= require 'framework.sync.TimerHelper'
local Indicator 			= require 'script.controller.DIndicator'
local handlerManager 		= require 'framework.net.SocketHandleManager'
local ArgQueue 				= require 'script.environment.ArgQueue'
local LayerManager 			= require "framework.interface.LuaLayerManager"

MetaHelper.classDefinitionEndRemoval(LuaInterface)


---- socket net
local client

function LuaInterface:send( data, callback, errcallback,delay,timeout, ptype,flag)
	
	client = client or require 'SocketClient'
	client.send0( data, callback, errcallback,delay,timeout, ptype,flag)

end

function LuaInterface:sendBackground( data,callback,errcallback,timeout,ptype )
	self:send(data,callback,errcallback,nil,timeout,ptype,false)
end

function LuaInterface:connect( ip,port,callback,errcallback)

	client = client or require 'SocketClient'
	client:connect(ip,port,function ( suc )
		if suc and callback then	
			callback(data.D)
		elseif not suc and errcallback then
			errcallback(data)
		end
	end)

end

--custom ui
local uihelper = require 'UIHelper'
--toast
function LuaInterface:toast( info )
	-- body
	--uihelper.toast( self:getLayer(), info )
	
	uihelper.toast2(info)
end

function LuaInterface:hiddenToast(  )
	uihelper.hidden()
end

GleeCore.toast = function ( self, info )
	-- body
	-- local node = CCDirector:sharedDirector():getRunningScene()
	-- uihelper.toast( node, info )
	uihelper.toast2(info)
end

GleeCore.reSet =  function (  )
	
	Indicator.reset()
	require 'LogHelper'.saveLog()
	-- local LuaLayerManager = require "framework.interface.LuaLayerManager"
	-- LuaLayerManager.closeAll()
	
	local SocketClient = require 'SocketClient'
	if SocketClient.getstatus then
		SocketClient:close()
	end
	
	local SocketClientPvp = require 'SocketClientPvp'
	if SocketClientPvp.getstatus then
		SocketClientPvp:close()
	end

end

GleeCore.reLogin = function ( ... )
	require 'ArgQueue'.clear()
	require 'AppData'.cleanLocalData()
	require 'GuideHelper':reset()
	require "NotificationManager".reset()
	require 'ChatInfo'.reset()

	require 'TimeListManager'.clear(  )
	
	require 'EventCenter'.resetGroup('PetKillObs')
	require 'EventCenter'.resetGroup('BossBattleObs')
	require 'EventCenter'.resetGroup('CHome')

	-- require 'EventCenter'.clear()
	-- require 'EventObserver'.reset()
	
	local layerManager = require "framework.interface.LuaLayerManager"
	layerManager.closeAll()
	GleeCore:popControllerTo(require "Config".loginc or require 'script.info.Info'.LOGIN)
end

GleeCore.retrySend = function ( ... )
	client = client or require 'SocketClient'
	client.sendRetry()
end

local Launcher = require 'Launcher'
local function checkControllerCheckIn(name)
	-- body
	assert(name, name)	
	print('Do Load I '..name)
	require (name)
end

GleeCore.pushControllerRaw = GleeCore.pushController
GleeCore.pushController = function (self, name, data, controller, transition,netdata)
	checkControllerCheckIn(name)
	local ret = Launcher.doLaunch('push',name,data,controller,transition,netdata)
	if not ret then
		GleeCore.pushControllerRaw(self,name,data,controller,transition,netdata)
	end
end

GleeCore.replaceControllerRaw = GleeCore.replaceController
GleeCore.replaceController = function (self, name, data, controller, transition,netdata)
	checkControllerCheckIn(name)
	local ret = Launcher.doLaunch('replace',name,data,controller,transition,netdata)
	if not ret then
		GleeCore.replaceControllerRaw(self,name,data,controller,transition,netdata)
	end
end

GleeCore.popControllerTo0Raw = GleeCore.popControllerTo0
GleeCore.popControllerTo0 = function ( self,controllername,data,controllerObject, transition,netdata)
	checkControllerCheckIn(controllername)
	local ret = Launcher.doLaunch('popControllerTo0',controllername,data,controllerObject,transition,netdata)
	if not ret then
		GleeCore.popControllerTo0Raw(self,controllername,data,controllerObject, transition,netdata)
	end
end

GleeCore.popController0Raw = GleeCore.popController0
GleeCore.popController0 = function (self,controllerObject, transition ,netdata)
	local nextcontrollername = GleeControllerManager:getInstance():getNextControllerName('pop')
	checkControllerCheckIn(controllername)
	local ret = false
	if nextcontrollername then
		ret = Launcher.doLaunch('popController0',nextcontrollername,nil,controllerObject,transition,netdata)
	end
	if not ret then
		GleeCore.popController0Raw(self,nextcontrollername,controllerObject,transition,netdata)
	end
end


GleeCore.showLayerRaw = GleeCore.showLayer
GleeCore.showLayer = function ( self, name, data, sub )
	-- 
	LayerManager.checkLayerCheckIn(name)
	local ret = Launcher.doLaunch('showLayer',name,data,sub)
	if not ret then
		GleeCore.showLayerRaw(self,name,data,sub)
	end
end

GleeCore.closeAllLayersRaw = GleeCore.closeAllLayers
GleeCore.closeAllLayers = function ( self,ignore )
	-- body
	require "Res".setTouchDispatchEvents(true)
	LayerManager.closeAll(ignore or {guideLayer=true})
end

MetaHelper.classDefinitionEnd(LuaInterface, 'LuaInterface')


--------
SequenceManager = {} 
SequenceManager.data = {}
local Raw_ElfAction_create = ElfAction.create
ElfAction.create = function ( self, ... )
	-- body
	local ret = Raw_ElfAction_create(self, ...)

	-- SequenceManager.data[ret] = debug.traceback()
	table.insert(SequenceManager.data, { action=ret, traceback = debug.traceback()} )

	return ret
end

SequenceManager.clean = function ()
	-- body
	SequenceManager.data = {}
end


SequenceManager.clean = function ()
	-- body
	print('-------------SequenceManager.clean------------')
	SequenceManager.data = {}
end

SequenceManager.snapShot = function ()
	-- body
	local count = 0
	local count_release = 0
	print('-------------SequenceManager.snapShot------------')
	for i,v in ipairs( SequenceManager.data ) do
		local action = v.action
		if not tolua.isnull(action) then
			local traceback = v.traceback
			print('##########')
			print(traceback)
			count = count + 1
		end
	end
	print('-------------count = '..count)

	for i,v in ipairs( SequenceManager.data ) do
		local action = v.action
		if tolua.isnull(action) then
			local traceback = v.traceback
			print('##########')
			print(traceback)
			count_release = count_release + 1
		end
	end

	print('count_release = '..count_release)
	print('-------------------------------------------------')
end


