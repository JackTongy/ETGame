local SCENE_INDEX = 0
local MENU_INDEX = 100
local DIALOG_INDEX = 200

local MainScene = ElfScene:create()
CCDirector:sharedDirector():runWithScene( MainScene )

local SceneLayer = CCLayer:create();
local MenuLayer = CCLayer:create();
local DialogLayer = CCLayer:create();

MainScene:addChild( SceneLayer, SCENE_INDEX )
MainScene:addChild( MenuLayer, MENU_INDEX )
MainScene:addChild( DialogLayer, DIALOG_INDEX )

local Dircetor = {}
local SceneStack = {}

local SceneRegisterMap = {}
local LayerRegisterMap = {}


--[[
registerLayer
registerLuaController
--]]
Dircetor.registerLayer = function ( name, class )
	-- body
	assert(LayerRegisterMap[name] == nil)
	LayerRegisterMap[name] = class
end

Dircetor.registerScene = function ( name, class )
	-- body
	assert(SceneRegisterMap[name] == nil)
	SceneRegisterMap[name] = class
end


--[[
	onInit		onBack

		onResume
		
		onPause
	
	onDestory	onSleep
--]]



--[[

pushScene,
popScene,
replaceScene,

showLayer,
hideLayer,

--]]

local function sleep( oldScene )
	-- body
	if oldScene then
		oldScene:onPause()

		local oldLayer = oldScene:getLayer()
		oldLayer:removeFromParentAndCleanup(false);

		oldScene:onSleep()
	end
end 

local function destory( oldScene )
	-- body
	if oldScene then
		oldScene:onPause()

		local oldLayer = oldScene:getLayer()
		oldLayer:removeFromParentAndCleanup(false);
		
		oldScene:onDestory()

		table.remove(SceneStack, #SceneStack)
	end
end

Dircetor.pushScene = function ( sceneName, data )
	-- body
	local class = SceneRegisterMap[sceneName]
	assert(class)

	local newScene = class.new()
	newScene:onInit(data)

	table.insert(SceneStack, newScene)

	local oldScene = SceneStack[#SceneStack]
	sleep(oldScene)
	
	local newLayer = newScene:getLayer()
	SceneLayer:addChild( newLayer )

	newScene:onResume()

	return newScene
end

Dircetor.popScene = function ()
	-- body
	local oldScene = SceneStack[#SceneStack]
	destory(oldScene)

	local newScene = SceneStack[#SceneStack]
	
	
	return oldScene
end

Dircetor.replaceScene = function ( sceneName, data )
	-- body
	local class = SceneRegisterMap[sceneName]
	assert(class)

	local newScene = class.new()
	newScene:onInit(data)

	table.insert(SceneStack, newScene)

	local oldScene = SceneStack[#SceneStack]
	destory(oldScene)
	
	local newLayer = newScene:getLayer()
	SceneLayer:addChild( newLayer )

	newScene:onResume()
	
	return newScene
end


return Dircetor