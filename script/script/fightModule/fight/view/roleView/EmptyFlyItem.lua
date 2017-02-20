local FlyView 		= require 'FlyView'
local LayerManager 	= require 'LayerManager'
local GridManager 	= require 'GridManager'

local EmptyFlyItem = class()

function EmptyFlyItem:flyTo(skinId, startPos, endPos, speed)
	-- body
	local viewset = FlyView.createFlyViewById(skinId)
	local view = viewset:getRootNode()
	LayerManager.skyLayer:addChild(view)
	
	-- print('start Pos'..startPos.x..','..startPos.y)
	-- print('end Pos'..endPos.x..','..endPos.y)

	startPos.x = startPos.x - GridManager.getLogicWidth()/2
	startPos.y = startPos.y - GridManager.getLogicHeight()/2

	endPos.x = endPos.x - GridManager.getLogicWidth()/2
	endPos.y = endPos.y - GridManager.getLogicHeight()/2

	view:setPosition(ccp(startPos.x, startPos.y))
	-- print('EmptyFlyItem')
	
	local time = math.sqrt((endPos.x-startPos.x)*(endPos.x-startPos.x) + (endPos.y-startPos.y)*(endPos.y-startPos.y))/speed

	local action = CCMoveBy:create(time, ccp(endPos.x-startPos.x, endPos.y-startPos.y))
	local elfAction = ElfAction:create(action)
	elfAction:setListener(function ( ... )
		-- body
		viewset:dispose()
	end)

	view:runAction(elfAction)
end


return EmptyFlyItem