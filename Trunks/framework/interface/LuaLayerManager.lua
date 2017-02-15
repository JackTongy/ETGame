--[[
here layer above controller
--]]
local frameworkHelper = require 'framework.basic.FrameWorkHelper'
local TimerHelper = require 'framework.sync.TimerHelper'

local manager = {}

--[[
注册 Name <-> LuaLayerCreator
--]]
manager._creatorMap = {}

function manager.check( name, creator )
	-- body
	manager._creatorMap[name] = creator
end

manager._runningLayerList = {}

local function refresh()
	-- body
	local list = manager._runningLayerList
	local size = #list

	local shiedlBelow

	print('========================refresh===================')

	for i=size,1,-1 do
		local layer = list[i]

		local enable = not shiedlBelow
		print(layer:getName()..'->'..tostring(enable))
		layer:setEnabled(enable)
		
		shiedlBelow = shiedlBelow or layer:getShieldBelow()
	end

	local enable = not shiedlBelow

	print('enable='..tostring(enable))
	print('===============================================')
	
	local gleeControllerManager = GleeControllerManager:getInstance()
	
	local runningController = gleeControllerManager:getRunningController()
	if runningController then
		runningController:setEnabled(enable)
	end
	
    gleeControllerManager:setMenuEnabled( enable )
    gleeControllerManager:setDialogEnabled( enable )
    gleeControllerManager:setGuideEnabled( enable )
    gleeControllerManager:setAnnouncementEnable( enable )
    
	-- local controller = frameworkHelper.getRunningController()
	-- controller:setEnabled((not shiedlBelow))

	TimerHelper.tick(function ()
		-- body
		SystemHelper:cleanUnusedTexture()
		return true
	end)
end

local function closeDialogInArr( dialogs )
	if dialogs and dialogs:count() > 0 then
		for i=dialogs:count()-1,0,-1 do
			local dialog = dialogs:objectAtIndex(i)
			tolua.cast(dialog,'GleeDialog')
			dialog:hide()
		end
	end
end

local function closeMenuInArr( menus )
	if menus and menus:count() > 0 then
		for i=menus:count()-1,0,-1 do
			local menu = menus:objectAtIndex(i)
			tolua.cast(menu,'GleeMenu')
			menu:hide()
		end
	end
end

local function closeAll( ignore )
	local list = manager._runningLayerList
	local size = #list

	for i=size, 1, -1 do
		local layer = list[i]
		if not ignore or not ignore[layer.getType()] then
			layer:close()
		end
	end

	local gleeControllerManager = GleeControllerManager:getInstance()
	closeDialogInArr(gleeControllerManager:getDialogInstances())
	closeDialogInArr(gleeControllerManager:getGuideInstances())
	closeDialogInArr(gleeControllerManager:getAnnouncementInstances())
	closeMenuInArr(gleeControllerManager:getMenuInstances())
end

local function insertLayerInRunningList(layer)
	local list = manager._runningLayerList
	local myIndex = layer:getIndex()

	local insertIndex = 1

	for i,v in ipairs(list) do
		local index = v:getIndex()

		if index > myIndex then
			break
		end

		insertIndex = i + 1
	end

	table.insert(list, insertIndex, layer)

	refresh()
end

local function removeLayerInRunningList(layer)
	-- body
	local list = manager._runningLayerList
	local insertIndex
	for i,v in ipairs(list) do
		if v == layer then
			insertIndex = i
			break
		end
	end

	assert(insertIndex, "Layer %s Is Not In Running List", layer:getName())
	table.remove(list, insertIndex)

	-- new top layer
	if layer and layer:getType() == 'Dialog' then
		for i=insertIndex-1, 1, -1 do
			local newTopLayer = list[i]
			if newTopLayer and newTopLayer:getType() == 'Dialog' then
				newTopLayer:onBack(newTopLayer:getUserData(), nil)
				break
			end
		end
	end

	refresh()
end

manager._runningLayerMap = {}

--[[
show layer by name + data + key
--]]

local function getKey(name, sub)
	assert( type(name) == 'string' )

	if sub then
		return name..tostring(sub)
	else
		return name
	end
end

local function showLayer(newlayer, name, sub)
	--asign close function
	local key = getKey(name, sub)

	local raw_close = newlayer.close
	newlayer.close = function(self, closedata)
		if raw_close then
			raw_close(self,closedata)
		end
		manager.hide(name, closedata, sub)
	end

	--add to running scene
	newlayer:show(function()
		local scene = frameworkHelper.getRunningScene()
		local cclayer = newlayer:getLayer()
		local index = newlayer:getIndex()

		scene:addChild(cclayer, index)

		manager._runningLayerMap[key] = newlayer

		insertLayerInRunningList(newlayer)
	end)
end

local function hideLayer( oldlayer, key )
	-- body
	oldlayer:hide(function()
		-- oldlayer:onBack( oldlayer:getUserData(), oldlayer:getNetData() )

		local cclayer = oldlayer:getLayer()
		cclayer:removeFromParent()

		removeLayerInRunningList(oldlayer)
		manager._runningLayerMap[key] = nil
	end)
end

local function checkLayerCheckIn( name )
	-- body
	assert(name)
	if not manager._creatorMap[name] then
		require (name)
	end
end

function manager.show( name, data, sub,netdata )
	-- body
	local key = getKey(name,sub)

	assert(manager._runningLayerMap[key] == nil, string.format("Layer %s Has Already Running!", key))

	checkLayerCheckIn( name )
	local creator = manager._creatorMap[name]
	assert(creator ~= nil, string.format("Layer %s Has Not Checked Yet!", name))

	local newlayer = creator.new()

	newlayer:setUserData(data)
	--[[
	load xml
	load net if needed
	--]]
	newlayer:onLoad()
	newlayer:setNetData(netdata)
	newlayer:onInit( newlayer:getUserData(), newlayer:getNetData() )

	--asign close function
	showLayer(newlayer, name, sub)
end

function manager.hide( name, data, sub )
	-- body
	local key = getKey(name,sub)

	local oldLayer = manager._runningLayerMap[key]

	-- if oldLayer == nil then
	-- 	return
	-- end
	if oldLayer then
		assert(oldLayer ~= nil, string.format("Layer %s Is Not Running!", key))
	
		--do trigger on __hide action finished
		oldLayer:setUserData(data)

		hideLayer(oldLayer, key)
	end
end

function manager.load2layer(name, data, sub, name2, data2, sub2)
	-- body
	manager.show(name2, data2, sub2)

	local loaderfunction = function()
		local loadlayer = manager._runningLayerMap[ getKey(name2, sub2) ]
		
		local key = getKey(name, sub)

		assert(manager._runningLayerMap[key] == nil, string.format("Layer %s Has Already Running!", key))

		checkLayerCheckIn( name )
		local creator = manager._creatorMap[name]
		assert(creator ~= nil, string.format("Layer %s Has Not Checked Yet!", name))
	
		local newlayer = creator.new()

		newlayer:setUserData(data)
		
		local netProgress = 0
		local xmlProgress = 0

		local function do_progress()
			local pValue = netProgress + xmlProgress
			loadlayer:setProgress(pValue)

			if pValue >= 100 then
				--finally do
				loadlayer:close()

				newlayer:onInit( newlayer:getUserData(), newlayer:getNetData() )

				showLayer(newlayer, name, sub)
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

	    newlayer:onLoad( function(data, tag, code, errorBuf)
	    	obj:setNetData(data)
	    	netProgress = 5
	    	do_progress()
	    end) 
	end  
end

function manager.getRunningLayer( name, sub )
	-- body
	local key = name
	if sub then
		key = key..tostring(sub)
	end
	return manager._runningLayerMap[key]
end

function manager.isRunning(name, sub)
	-- body
	return manager.getRunningLayer(name, sub) ~= nil
end

manager.refresh = refresh
manager.closeAll = closeAll
manager.checkLayerCheckIn = checkLayerCheckIn

return manager