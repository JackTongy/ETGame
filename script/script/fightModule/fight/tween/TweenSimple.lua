--[[
移动控制类
]]

local YFMath = require 'YFMath'
local UpdateRate = require 'UpdateRate'

local FightTimer = require "FightTimer"

local Interval = FightTimer.getFrameInterval() 
-- * 1000


--- 禁止的对象 目标点 可以采用时间来判断完成  ，假如目标为活动的 需要 以时间 和距离双重标准 只要满足其中一项 既可完成  比如 当前位置 距离目标点的位置再一个半圆内 可以判定他们
local TweenSimple=class()


--[[
 moveVo MoveVo 数据 {x,y}    endX  endY 是最终要移动到的目标点  speed 是 移动速度
 lostTime 丢失的时间 单位毫秒 切割 100份
]]
function TweenSimple:tweenTo(speed, moveVo, endX, endY, completeCall, updateFunc, lostTime)
	
	self._speed = speed

	self._moveVo = moveVo

	self._endX = endX
	self._endY = endY

	self._startX = moveVo.x
	self._startY = moveVo.y

	self._completeCall = completeCall
	self._updateFunc = updateFunc
	
	self._isStart=false

	self:start()
end


function TweenSimple:updateSpeedXY()
	self._speedX = self._speed * math.cos(self._rad)
 	self._speedY = self._speed * math.sin(self._rad)
 	-- print('speed = '..self._speedX..','..self._speedY)
end

--是否该目标点 正在靠近  这个方法防止不断重复调用 使用 用来屏蔽重复动作
function TweenSimple:equalEnd( pos )
	-- local thredhold = 0.0001
	if pos.x==self._endX and pos.y==self._endY and self._isStart then
		return true
	end

	return false
end


function TweenSimple:updateEnd( x,y )
	assert(false)
	self._endX=x
	self._endY=y
end

function TweenSimple:start()
	
	self._isStart=true
	
	if self._endX ==self._moveVo.x and self._endY ==self._moveVo.y then
		self:finishIt()
	else 
		-- 运动的弧度
		-- self._rad = math.floor(math.atan2(self._endY - self._moveVo.y, self._endX - self._moveVo.x)*100) /100
		self._rad = math.atan2(self._endY - self._moveVo.y, self._endX - self._moveVo.x)
		self:updateSpeedXY()

		if not self._updateHandle then
			self._updateHandle = FightTimer.addFunc(function ( dt )
				self:updateIt( dt )
			end)
		end
	end 
end


function TweenSimple:stop()
	self._isStart = false
end

function TweenSimple:isStart()
	-- body
	return self._isStart
end


function TweenSimple:cancelIt(  )

	if self._updateHandle then
		FightTimer.removeFunc(self._updateHandle)
		self._updateHandle=nil
	end
end

function TweenSimple:updateMove( dt )
	local rate = dt/Interval

	local newX = self._moveVo.x + self._speedX * rate
	local newY = self._moveVo.y + self._speedY * rate	

	-- print('rate = '..rate)

	local thredhold = 0

	if (newX+thredhold > self._endX) == (self._moveVo.x <= self._endX+thredhold) then
		newX = self._endX
	end

	if (newY+thredhold > self._endY) == (self._moveVo.y <= self._endY+thredhold) then
		newY = self._endY
	end

	self._moveVo.x = newX
	self._moveVo.y = newY

	if (self._moveVo.x == self._endX) and (self._moveVo.y == self._endY) then
		self._updateFunc(self._moveVo.x, self._moveVo.y)
		self:finishIt()
	else
		self._updateFunc(self._moveVo.x, self._moveVo.y)
	end
end

function TweenSimple:updateIt( dt )

	if self._isStart then

		-- while self._times >0 do
		-- 	self:updateMove()
		-- 	self._times = self._times -1 
		-- 	if self._times <= 0 then
		-- 		self._times = 0 
		-- 	end
		-- end
		
		self:updateMove( dt )
	end	

	-- return false
end


function TweenSimple:finishIt(  )

	if self._completeCall ~=nil then 
	 	self._completeCall()
	end 
	-- self:stop()
	self._isStart=false

end 
function TweenSimple:dispose( )
	-- self:stop()
	self._isStart=false
	self:cancelIt()
	self._completeCall=nil
	self._updateFunc=nil
	self._moveVo=nil
end

function TweenSimple:setTraceback()
	-- body
	self._traceback = true
end

return TweenSimple