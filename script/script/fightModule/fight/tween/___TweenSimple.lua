--[[
移动控制类
]]

-- local timer = require 'framework.sync.TimerHelper'
-- local tick = timer.tick
-- local cancel = timer.cancel
local YFMath = require 'YFMath'
local FightTimer = require 'FightTimer'
local UpdateRate = require 'UpdateRate'


--- 禁止的对象 目标点 可以采用时间来判断完成  ，假如目标为活动的 需要 以时间 和距离双重标准 只要满足其中一项 既可完成  比如 当前位置 距离目标点的位置再一个半圆内 可以判定他们
TweenSimple=class()


--[[
 moveVo MoveVo 数据 {x,y}    endX  endY 是最终要移动到的目标点  speed 是 移动速度
 lostTime 丢失的时间 单位毫秒 切割 100份
]]
function TweenSimple:tweenTo(speed,moveVo,endX,endY,completeCall,updateFunc,lostTime)

	
	-- if self._speed==speed and self._endX==endX and self._endY==endY then			--防止不断的重复创建发送
	-- 	self:start(false)
	-- 	return 
	-- end

	self._speed=speed
	self._moveVo=moveVo
	self._endX=endX
	self._endY=endY
	self._startX=moveVo.x
	self._startY=moveVo.y


	self._xLen =self._endX -self._startX   -- x 方向的长度 含有方向性
	self._yLen =self._endY -self._startY   -- y 方向的长度 含有方向性    用来比对最终点是否超过目标

	self._completeCall=completeCall
	self._updateFunc=updateFunc
	
	
	self._isStart=false
	-- self._preTime=preTime
	local distance = YFMath.distance(moveVo.x,moveVo.y,endX,endY)
	local costTime = distance/(speed*UpdateRate.rate)

--	if costTime*1000>lostTime then
	local costTime2 =costTime*1
	lostTime =lostTime or 0

	self._lostlen=costTime2*UpdateRate.rate*3

--	self._lostlen=120
	if self._lostlen>0 then
		self._lostInteval=lostTime/self._lostlen
	else
		self._lostInteval=0
	end

	-- self._firstTime=SystemHelper:currentTimeMillis()
	-- print('_lostInteval====='..self._lostInteval.."costlen"..self._lostlen)
	-- self:stop()
	-- self.s=(distance*UpdateRate.IntervalRate/speed)- lostTime
	-- print('self._maxusingTime')
	-- print(self._maxusingTime..','..lostTime..",distance:"..distance.."speed"..speed)

	self:start()

end


function TweenSimple:updateSpeedXY()
	self._speedX=self._speed*math.cos(self._rad)
 	self._speedY=self._speed*math.sin(self._rad)

end

--是否该目标点 正在靠近  这个方法防止不断重复调用 使用 用来屏蔽重复动作
function TweenSimple:equalEnd( pos )
	-- local minThredhold = 0.0000001
	-- if math.abs(pos.x-self._endX) < minThredhold and math.abs(pos.y-self._endY) < minThredhold and self._isStart then
	-- 	return true
	-- else
	-- 	return false
	-- end

	if pos.x==self._endX and pos.y==self._endY and self._isStart then
		-- print("equal == true")
		-- print(pos)
		-- print(self._endX)
		-- print(self._endY)
		-- print(self._isStart)
		return true
	end
	-- print("equal == false")
	return false
end


function TweenSimple:updateEnd( x,y )
	self._endX=x
	self._endY=y

	self._xLen =self._endX -self._startX   -- x 方向的长度 含有方向性
	self._yLen =self._endY -self._startY   -- y 方向的长度 含有方向性    用来比对最终点是否超过目标

end
function TweenSimple:start()
	-- self._firstTime=SystemHelper:currentTimeMillis()
	-- self._lastTime=SystemHelper:currentTimeMillis()
	self._isStart=true

	self._curentTime = SystemHelper:currentTimeMillis()

	if self._endX ==self._moveVo.x and self._endY ==self._moveVo.y then

			self:finishIt()
	else 
				-- 运动的弧度
		self._rad=math.atan2(self._endY-self._moveVo.y,self._endX-self._moveVo.x) 
		self:updateSpeedXY()
		-- self._updateHandle=tick(function ( dt)
		-- 	self:updateIt(dt)
		-- end	,0)	

		if not self._updateHandle then
			self._updateHandle = FightTimer.addFunc(function (  )
					self:updateIt()
			end)
		end
	end 
end


function TweenSimple:stop()
	if self._isStart then			---一定要加 if  否则就粗乱了 标示 第一次stop时候 矫正停止坐标
		self._isStart=false
		self:updatePos()
	end
end
-- function TweenSimple:stopIt()
-- 	if self._isStart then			---一定要加 if  否则就粗乱了 标示 第一次stop时候 矫正停止坐标
-- 		self._isStart=false
-- 		self:updatePos()
-- 	end
-- end

function TweenSimple:isStart()
	-- body
	return self._isStart
end


function TweenSimple:cancelIt(  )
	-- if(self._updateHandle) then
	-- 	cancel(self._updateHandle)
	-- end
	if self._updateHandle then
		FightTimer.removeFunc(self._updateHandle)
		self._updateHandle=nil
	end
end


-- function TweenSimple:updateEnd( endX,endY)
-- 	self._endX=endX
-- 	self._endY=endY
-- 	self._rad=math.atan2((self._endY-self._moveVo.y+0.0001),(self._endX-self._moveVo.x+0.0001)) 
-- 	self:updateSpeedXY()
-- end

function TweenSimple:updateIt( dt )
	if self._isStart then
		-- self._lastTime=SystemHelper:currentTimeMillis()
		-- if self._lastTime-self._firstTime >=self._maxusingTime then
		-- 	self._moveVo.x =self._endX
		-- 	self._moveVo.y =self._endY
		-- 	self._updateFunc(self._moveVo.x, self._moveVo.y)

		-- 	self:finishIt()

		-- else

			local nowT = SystemHelper:currentTimeMillis()
			local dif =nowT -self._curentTime

			if self._lostlen>0 then
				dif =dif +self._lostInteval
				self._lostlen=self._lostlen-1
			end
			local realCost = dif*UpdateRate.rate/1000
			self._moveVo.x =self._moveVo.x +self._speedX*realCost;
			self._moveVo.y =self._moveVo.y+self._speedY*realCost;


			local xLen = self._moveVo.x - self._startX
			local ylen = self._moveVo.y - self._startY

			local absXLen = math.abs(self._xLen)
			local absYLen = math.abs(self._yLen)

			local nowXLen = math.abs(xLen)
			local nowYLen = math.abs(ylen)

			if xLen*self._xLen >=0 and ylen*self._yLen >=0 and nowXLen >= absXLen  and nowYLen >= absYLen  then
				self._moveVo.x =self._endX
				self._moveVo.y =self._endY
				self._updateFunc(self._moveVo.x, self._moveVo.y)

				self:finishIt()
			elseif xLen*self._xLen >=0 and nowXLen >= absXLen  then
				self._moveVo.x =self._endX
				self._updateFunc(self._moveVo.x, self._moveVo.y)
			elseif ylen*self._yLen >=0 and nowYLen >= absYLen then
				self._moveVo.y =self._endY
				self._updateFunc(self._moveVo.x, self._moveVo.y)
			else
				self._updateFunc(self._moveVo.x, self._moveVo.y)
			end

			self._curentTime=nowT			--	nowT必须是nowT不能重新设置 当前时间 否则有逻辑漏洞
			

		-- end
	end	
	return false
end

function  TweenSimple:updatePos(  )
	local nowT = SystemHelper:currentTimeMillis()
	local dif =nowT -self._curentTime

	if self._lostlen>0 then
		dif =dif +self._lostInteval
		self._lostlen=self._lostlen-1
	end
	local realCost = dif*UpdateRate.rate/1000
	self._moveVo.x =self._moveVo.x +self._speedX*realCost;
	self._moveVo.y =self._moveVo.y+self._speedY*realCost;

	local xLen = self._moveVo.x - self._startX
	local ylen = self._moveVo.y - self._startY

	local absXLen = math.abs(self._xLen)
	local absYLen = math.abs(self._yLen)

	local nowXLen = math.abs(xLen)
	local nowYLen = math.abs(ylen)

	-- if xLen*self._xLen >=0 and ylen*self._yLen >=0 and nowXLen >= absXLen  and nowYLen >= absYLen  then
	-- 	self._moveVo.x =self._endX
	-- 	self._moveVo.y =self._endY
	-- end
	if xLen*self._xLen >=0 and ylen*self._yLen >=0 and nowXLen >= absXLen  and nowYLen >= absYLen  then
		self._moveVo.x =self._endX
		self._moveVo.y =self._endY
	elseif xLen*self._xLen >=0 and nowXLen >= absXLen  then
		self._moveVo.x =self._endX
	elseif ylen*self._yLen >=0 and nowYLen >= absYLen then
		self._moveVo.y =self._endY
	end
	self._updateFunc(self._moveVo.x, self._moveVo.y)
	self._curentTime=nowT

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