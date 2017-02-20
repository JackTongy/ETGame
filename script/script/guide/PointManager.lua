--[[
	记录坐标点在设备屏幕中的坐标，及其所要点击节点的大小
]]
local PointManager = {}

function PointManager:init()
	self:clear()	
end

function PointManager:registerPoint( name,node )
	if not name or not node then
		return
	end

	local pinfo = {}
	pinfo.pins = NodeHelper:getPositionInScreen(node) --point in screen
	pinfo.psize = node:getContentSize()
	pinfo.node = node
	self._PMap[name] = pinfo
	
	--计算出以(0.5,0.5)为锚点的坐标	
	local ancp = node:getAnchorPoint()
	print(string.format('%s 坐标：',name))
	print(string.format('ancp:(%f,%f)',ancp.x,ancp.y))
	print(string.format('pins:(%f,%f)',pinfo.pins.x,pinfo.pins.y))
	if ancp.x ~= 0.5 or ancp.y ~= 0.5 then
		local offsetx = -(ancp.x - 0.5) * pinfo.psize.width
		local offsety = -(ancp.y - 0.5) * pinfo.psize.height
		pinfo.pins.x = pinfo.pins.x + offsetx
		pinfo.pins.y = pinfo.pins.y + offsety
		print(string.format('pins:(%f,%f)',pinfo.pins.x,pinfo.pins.y))
	end
	
end

function PointManager:unregisterPoint( name )
	if not name then
		return
	end

	self._PMap[name] = nil
end

function PointManager:reInit( pinfo )
	if pinfo and pinfo.node then
		local node = pinfo.node
		local pins = NodeHelper:getPositionInScreen(node) --point in screen
		local ancp = node:getAnchorPoint()
		pinfo.pins = pins
		if ancp.x ~= 0.5 or ancp.y ~= 0.5 then
			local offsetx = -(ancp.x - 0.5) * pinfo.psize.width
			local offsety = -(ancp.y - 0.5) * pinfo.psize.height
			pinfo.pins.x = pinfo.pins.x + offsetx
			pinfo.pins.y = pinfo.pins.y + offsety
			print(string.format('pins:(%f,%f)',pinfo.pins.x,pinfo.pins.y))
		end
	end
end

function PointManager:getPoint( name )
	if not name then
		return
	end

	return self._PMap[name]
end

function PointManager:getPointInNode( name,node )
	if not name or not node then
		return
	end

	local pinfo = self:getPoint(name)
	if pinfo then
		local errorcallback = function ( msg )
			print('PointManager:'..tostring(msg))
		end
		local func = function ( ... )
			self:reInit(pinfo)
		end
		xpcall(func,errorcallback)

		pinfo.pinn = node:convertToNodeSpaceAR(pinfo.pins)
		print(string.format('pins:(%f,%f)',pinfo.pins.x,pinfo.pins.y))
		print(string.format('pinn:(%f,%f)',pinfo.pinn.x,pinfo.pinn.y))
	end
	return pinfo
end

function PointManager:clear( ... )
	self._PMap = {}
end

PointManager:init()

return PointManager