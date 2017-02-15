require 'framework.basic.BasicClass'

local frameWorkHelper = require "framework.basic.FrameWorkHelper"

local EventCenter = require 'framework.event.EventCenter'

local layerManager = require 'framework.interface.LuaLayerManager'

local utils = require 'framework.helper.Utils'

LuaInterface = class()

function LuaInterface:ctor()
	print("create LuaInterface")
end

------------------------------------retain, release------------------------------------
function LuaInterface:retainMembers()
    -- body
    self._document:retain()
    self._set:retain()
end

function LuaInterface:releaseMembers()
    -- body
    if self._document then
        self._document:release()
        self._document = nil
    end

    if self._set then
        self._set:release()
        self._set = nil
    end
    
    self:unregisterEvents()
end

------------------------------------createDocument, release------------------------------------
function LuaInterface:createDocument()
	--auto create
	assert("LuaInterface: createDocument must be overrided!")
end

function LuaInterface:onInitXML()
    --auto create
    assert("LuaInterface: onInitXML must be overrided!")
end

--[[
1. create factory
2. create document
3. create set
4. setLayer
5. init node and action members
6. retain set and document
--]]
function LuaInterface:assignXML()
    -- body
    local factory = XMLFactory:getInstance()
    self._factory = factory

    local raw_setZipFilePath = factory.setZipFilePath

    factory.setZipFilePath = function ( ccself, pname )
    	-- body
    	raw_setZipFilePath(ccself, pname)
    	self:setName(pname)
    end
    
    self._document = self:createDocument()
    
    factory.setZipFilePath = raw_setZipFilePath

    self._set = factory:createWithElement(factory:getRootElement(self._document))

    -- local luaset = utils.toluaSet(self._set)
    -- print('--------------------------------')
    -- for i,v in pairs(luaset) do 
    -- 	print(i..':'..tolua.type(v))
    -- end
    -- print('--------------------------------')
    --[[
    对 luacontroller 而言 也设置了 controller 
    --]]
    self:setLayer(self._set:getRootElfLayer())

    self:onInitXML()

    self:retainMembers()
end

function LuaInterface:setName( name )
	-- body
	self._name = name
end

function LuaInterface:getName()
	-- body
	return self._name or 'unknown'
end

--[[
CCLayer
--]]
function LuaInterface:setLayer( layer )
	-- body
	self._layer = layer
end

function LuaInterface:getLayer()
	-- body
	return self._layer
end

----------------------User Data-------------------
function LuaInterface:setUserData( data )
	-- body
	self._userData = data
end

function LuaInterface:getUserData()
	-- body
	return self._userData
end

----------------------Net Data--------------------
function LuaInterface:setNetData( data )
	-- body
	self._netData = data
end

function LuaInterface:getNetData()
	-- body
	return self._netData
end

function LuaInterface:onInit( userData, netData )
	-- body
end

function LuaInterface:onBack( userData, netData )
	-- body
end

function LuaInterface:getNetModel()
	-- body
	assert("LuaInterface: getNetModel must be overrided!")
end

function LuaInterface:loadXML()
	-- body
	self:assignXML()
end

---------------------------just called by frame work---------------------------
function LuaInterface:loadNet(userlistener, syslistener)
	-- body
	self:setNetData(nil)

	local netModel = self:getNetModel()

	if netModel then
		netModel:callNet(userlistener, syslistener)
	else
		local netData = 'No Net-Model For LoadNet'
		self:setNetData(netData)

		if syslistener then
			syslistener(netData)
		end

		if userlistener then
			userlistener(netData)
		end
	end
end

function LuaInterface:onLoad(userlistener, syslistener)
	-- body
	self:loadXML()
	self:loadNet(userlistener, syslistener)
end

---------------------------called by custom---------------------------
function LuaInterface:callNet( netModel, func )
	-- body
	assert(netModel ~= nil)

	--self:setEnabled(false)
	self:showNetView()

	netModel:callNet(func, function()
		self:hideNetView()
	end)
end

function LuaInterface:callNetBackground( netModel, func )
	-- body
	assert(netModel ~= nil)

	netModel:callNet( func )
end


function LuaInterface:setNetViewName(name)
	-- body
	self._netViewName = name
end

function LuaInterface:showNetView()
	-- body
	if self._netViewName then
		self._showNetCount = self._showNetCount or 0
		self._showNetCount = self._showNetCount + 1
		if self._showNetCount == 1 then
			layerManager.show(self._netViewName)
		end
	end
	--print("showNetView:"..tostring(self._showNetCount)..self:getName())
end

function LuaInterface:hideNetView()
	-- body
	if self._netViewName and self._showNetCount and self._showNetCount > 0 then
		self._showNetCount = self._showNetCount - 1

		if self._showNetCount == 0 then
			layerManager.hide(self._netViewName)
		end
	end
	--print("hideNetView:"..tostring(self._showNetCount)..self:getName())
end

--[[
decide is the layer will shield layers-below or not
--]]
function LuaInterface:getShieldBelow()
	-- body
	return true
end

function LuaInterface:setEnabled(enabled)
	--print('setEnabled:'..tostring(enabled).." <- "..tostring(self:getName()) )
	NodeHelper:setTouchable(self:getLayer(), enabled)
end

--[[
run a function with delaytime safely
--]]
function LuaInterface:runWithDelay( func, delay, node )
	-- body
	node = node or self:getLayer()
	utils.delay(func, delay, node)

	-- local aliveNode = node or self:getLayer()
	-- local newFunc = function ()
	-- 	-- body
	-- 	if not tolua.isnull(aliveNode) then
	-- 		func()
	-- 	end
	-- end

	-- utils.delay(newFunc, delay)
end

function LuaInterface:runWithInterval(funcs, interval, delay, node )
	-- body
	node = node or self:getLayer()
	delay = delay or 0

	local len = #funcs

	local seqRun
	seqRun = function(index)
		-- body
		local func = funcs[index]
		func()

		if index < len then
			local action = ElfDelay:create(interval)
			action:setListener(function ()
				seqRun(index+1)
			end)
			node:runAction(action)
		end
	end

	self:runWithDelay(function ()
		seqRun(1)
	end,delay,node)
end

--[[
create a set dynamically
--]]
function LuaInterface:createSet( name )
	-- body
	local factory = self._factory
	local element = factory:findElementByName(self._document, name)
	assert(element, "%s Is Not A Element Of %s", name, tostring(self:getName()) ) 
	return factory:createWithElement(element)
end

function LuaInterface:createLuaSet( name )
	-- body
	local ccset = self:createSet(name)
	return utils.toluaSet(ccset)
end

--[[
	注册到由c++实现的事件中心，lua与c++可以相互传递数据
	event : number
--]]
function LuaInterface:registerEventLC(event,func)
	-- body
	assert(false, "LuaInterface:registerEventLC Must Be Overrided!")
end

--[[
	注册到由lua实现的事件中心 接收c++ Eventmanager及lua EventCenter中的事件
	eventname : 事件名
	func : 事件响应的回调方法 这里的回调第一个参数为 self 
	groupname : 指定的事件组名
				nil 时默认接收为广播事件
				指定名称时，则接收点对点或是组播信息
--]]
function LuaInterface:registerEvent( eventname,func,groupname )
	-- body
	EventCenter.addEvent(self,tostring(eventname),func,groupname)
end

--临时function 的管理队列
function LuaInterface:getEventFuncNames()
	local eventnames = self.eventnames
	if eventnames == nil then
		eventnames = {}
		self.eventnames = eventnames
	end
	return eventnames
end

function LuaInterface:registerEventFunc( eventname,func,groupname )
	EventCenter.addEventFunc( tostring(eventname),func,groupname )
	local eventnames = self:getEventFuncNames()
	table.insert(eventnames,eventname)
end

function LuaInterface:unregisterEvents()
	EventCenter.removeEvents(self)
	EventCenter.removeEventFuncs(self:getEventFuncNames())
end


function LuaInterface:isDisposed()
	-- body
	local layer = self:getLayer()
	return tolua.isnull(layer)
end

require 'framework.basic.MetaHelper'.classDefinitionEnd(LuaInterface, 'LuaInterface')


--[[

	onStart
		|	
		v
	onEnter	->	onResume
		|			^
		v			|
	onExit	->	onPause
		|
		v
	onStop

	SUPER_onStart

--]]