---数学算法

local ActionUtil 		= require 'ActionUtil'
local RoleSelfManager 	= require 'RoleSelfManager'

local WinSize = {
	width = require 'Global'.getWidth(),
	height = require 'Global'.getHeight(),
}



-- CCDirector:sharedDirector():getWinSize()


local LOGIX_WIDTH = 1136
local LOGIX_HEIGHT = 640

local SCREEN_TO_LOGIC_X_RATE = WinSize.width/LOGIX_WIDTH
local SCREEN_TO_LOGIC_Y_RATE = WinSize.height/LOGIX_HEIGHT

local offsetY = 0*6

local function sortHead( array, compare )
	-- body
	local size = #array
	if size > 1 then
		local index = 1
		local ret = array[1]

		for i=2, size do
			local v = array[i]
			if compare(v, ret) then
				ret = v
				index = i
			end
		end

		if index ~= 1 then
			local tmp = array[1]
			array[1] = array[index]
			array[index] = tmp
		end
	end
	return array
end

--两个point相同
local function equalPoint( pos1,pos2 )
	if pos1.x ==pos2.x and pos1.y==pos2.y then
		return true
	end
	return false
end 

---计算两点之间的距离
local function  distance( startX,startY,endX,endY )
	assert(startX ~= nil)
	local dx = (startX-endX)
	local dy = (startY-endY)
	return math.sqrt(dx*dx + dy*dy);
end

local function  distance2( player1,player2 )
	return distance(player1:getMapX(),player1:getMapY(),player2:getMapX(),player2:getMapY())
end

local function quick_distance( startX,startY,endX,endY )
	-- body
	assert(startX ~= nil)
	local dx = (startX-endX)
	local dy = (startY-endY)
	return dx*dx + dy*dy
end

local function quick_distance2( player1,player2 )
	-- body
	return quick_distance(player1:getMapX(),player1:getMapY(),player2:getMapX(),player2:getMapY())
end


-- 根据两点  startPoint  endPoint 来 获得  线上距离 endPoint长度为lenToEnd 的点 注意 该点在 starPoint 和endPoint中间
--返回的 {x=x,y=y}
local function getLinePointToEnd(startX,startY,endX,endY,lenToEnd)
	local pt = {}
	if lenToEnd ~=0 then
		--使用  定比分点公式 
		local dis=distance(startX,startY,endX,endY);
		local lama=(dis-lenToEnd+0.001)/(lenToEnd+0.001);  --定比分点参数
		pt.x=(startX+lama*endX+0.001)/(1+lama+0.001);
		pt.y=(startY+lama*endY+0.001)/(1+lama+0.001);
	else
 		pt.x=endX
 		pt.y=endY
	end
	return pt
end

--点pos是否在椭圆内
local function isInEllipse(originPos,a,b, pos )
	local dx = (originPos.x-pos.x)/a
	local dy = (originPos.y-pos.y)/b
	local value = dx*dx + dy*dy

	-- local value=math.pow((originPos.x-pos.x),2)/math.pow(a,2)+math.pow((originPos.y-pos.y),2)/math.pow(b,2)
	return value <= 1 
end 

-- dir代表人物面朝向的方向  ActionUtil.Direction_
local function isInLine(originPos,width,height,dir,pos )
	local left
	local right
	local top
	local bottom
  	if dir == ActionUtil.Direction_Right then
  		left 	= originPos.x
  		top 	= originPos.y+height*0.5
  		right 	= originPos.x+width
  		bottom 	= originPos.y-height*0.5

  	elseif dir == ActionUtil.Direction_Left then 
  		right 	= originPos.x
  		top 	= originPos.y+height*0.5
  		left 	= originPos.x-width
  		bottom 	= originPos.y-height*0.5

  	else assert(false,"错误的方向")
  	end

  	if pos.x>left and pos.x<=right and pos.y>bottom and pos.y<=top then
  		return true
  	end

  	-- print('left:'..left)
  	-- print('right:'..right)
  	-- print('top:'..top)
  	-- print('bottom:'..bottom)
  	-- print('pos.x:'..pos.x)
  	-- print('pos.y:'..pos.y)

  	return false
end



--map坐标坐标转化为平行四边形的坐标 ，做的一个坐标映射转化
local function getUIPoint( mapPoint)
	local tan= 0
	local myY = mapPoint.y-WinSize.height*0.5-offsetY
	
	local offsetX = tan * myY

	return {x=mapPoint.x+offsetX,y=mapPoint.y}
end 

--平行四边形坐标转化为 垂直坐标     uiPoint    转化后的 1136 ＊ 640下的坐标
local function getMapPoint( uiPoint )
	local myY = uiPoint.y-WinSize.height*0.5-offsetY
	local tan = 0
	local offsetX = tan* myY
	return {x=uiPoint.x-offsetX,y=uiPoint.y}
end 


--逻辑坐标转换到物理的屏幕坐标
local function logic2physic( mapPoint )
	-- body
	local p = getUIPoint(mapPoint)

	if RoleSelfManager.getFlipX() < 0 then
		p.x = LOGIX_WIDTH - p.x 
	end

	p.x = p.x * SCREEN_TO_LOGIC_X_RATE
	p.y = p.y * SCREEN_TO_LOGIC_Y_RATE	

	return p
end

--物理屏幕坐标转化到逻辑坐标
local function physic2logic( physicPoint )
	-- body
	local p = {}
	p.x = physicPoint.x / SCREEN_TO_LOGIC_X_RATE
	p.y = physicPoint.y / SCREEN_TO_LOGIC_Y_RATE

	if RoleSelfManager.getFlipX() < 0 then
		p.x = LOGIX_WIDTH - p.x 
	end

	return getMapPoint(p)
end

local function isInOvel( posCenter, testPos, radiusX, radiusY )
	-- body
	assert(posCenter)
	assert(testPos)

	assert(radiusX)
	assert(radiusY)

	local offX = (testPos.x - posCenter.x)/radiusX
	local offY = (testPos.y - posCenter.y)/radiusY

	return (offX*offX + offY*offY) <= 1
end

-- 判断向量积
-- pos1(selfPos), pos2(endPos)
local function isInFanShaped( pos1, pos2, testPos, radiusX, radiusY, angle )
	-- body
	assert(pos1)
	assert(pos2)
	assert(testPos)
	assert(radiusX)
	assert(radiusY)
	assert(angle)
	assert(angle > 0)

	if not isInOvel(pos1, testPos, radiusX, radiusY) then
		return false
	end

	-- 带修正 ?
	local vec1 = { x = (pos2.x - pos1.x), 			y = (pos2.y - pos1.y) }

	local vec2 = { x = (testPos.x - pos1.x), 		y = (testPos.y - pos1.y) }

	local xiangliangJI = vec1.x*vec2.x + vec1.y*vec2.y

	local xiangliangMo = math.sqrt( (vec1.x*vec1.x + vec1.y*vec1.y)*(vec2.x*vec2.x + vec2.y*vec2.y) )
	
	if xiangliangMo <= 0 then
		return true
	end
	
	local cosA = xiangliangJI / xiangliangMo
	local minCosA = math.cos( (angle/2) * math.pi/180 )
	
	return cosA >= minCosA
end



return {

	distance 			= distance,
	distance2 			= distance2,
	getLinePointToEnd 	= getLinePointToEnd,
	isInEllipse 		= isInEllipse,
	isInLine 			= isInLine,
	getUIPoint 			= getUIPoint,
	getMapPoint 		= getMapPoint,
	logic2physic 		= logic2physic, 
	physic2logic 		= physic2logic,
	equalPoint 			= equalPoint,
	quick_distance 		= quick_distance, 
	quick_distance2 	= quick_distance2, 
	sortHead 			= sortHead, 
	isInFanShaped 		= isInFanShaped, 
	isInOvel 			= isInOvel, 

}
