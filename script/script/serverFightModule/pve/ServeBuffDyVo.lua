local buffBasicManager = require 'BuffBasicManager'
-- 服务端buff类
ServeBuffDyVo = class()

function ServeBuffDyVo:ctor( )
	self.buffType=-1	--buff惟一id
  	self.addNum=1 	-- buff叠加次数
  	self.progress=0 --已经执行的时间的时间
  	self.buffhastriggered=0 --已经触发的次数
	self.buffstate = 'running'
	self.duration=0			--

end

-- 该buff能触发的次数
function ServeBuffDyVo:getBuffTriggerTimes( )
	local buffBasicVo = buffBasicManager.getBuffBasicVo(self.buffType)
	if buffBasicVo.interval>0 then
		return 	math.floor(self.duration*self.addNum / buffBasicVo.interval)
	end
	return 0
end


function ServeBuffDyVo:merge( newBuff )
	-- assert(not self:isDisposed() and not newBuff:isDisposed())
	-- -- body
	-- -- 时间延长
	-- local newlife = (self.bufflife-self.buffprogress) + newBuff.bufflife
	-- self.bufftriggertimes = math.floor(self.bufftriggertimes*newlife/self.bufflife)
	-- self.bufflife = newlife
	-- -- 光环加强
	-- for i,v in pairs(newBuff.datamap) do 
	-- 	self.datamap[i] = self.datamap[i] + v
	-- end
	
	
	if newBuff.buffType==self.buffType then
		self.addNum=self.addNum + 1
	end
end




function ServeBuffDyVo:getBuffId()
	-- body
	return self.buffType
end

function ServeBuffDyVo:onEnter( hero )
	-- body
	self.owner = hero
end

function ServeBuffDyVo:onExit( hero )
	-- body
	assert(self.owner == hero)
	self.owner = nil
end

function ServeBuffDyVo:isDisposed()
	-- body
	return self.buffstate == 'dead'
end
--已经触发的次数
function ServeBuffDyVo:getTriggerTimesByProgress( progress )
	-- local buffBasicVo = buffBasicManager.getBuffBasicVo(self.buffType)

	local life = self.duration*self.addNum
	local max = self:getBuffTriggerTimes()

	if progress >= life then
		return max
	else 
		return math.floor( max * progress / life )
	end
end

function ServeBuffDyVo:tick( ticktime, args )
	-- body
	if self:isDisposed() then
		return 
	end
	-- local buffBasicVo = buffBasicManager.getBuffBasicVo(self.buffType)

	local life = self.duration*self.addNum
	local progress = self.progress + ticktime
	local count = self:getTriggerTimesByProgress(progress)

	if count > self.buffhastriggered then
		for i=self.buffhastriggered,count-1 do 
			self:trigger(args)
		end

		self.buffhastriggered = count
	end

	self.progress = progress

	if progress >= life then
		self:onExit(args)

		self.buffstate = 'dead'
	end

end

function ServeBuffDyVo:trigger(args)
	-- body
	if self.triggertype == 1 then
		--加血
		-- self.owner:
	elseif self.triggertype == 2 then
		--扣血
		
	end
end

function ServeBuffDyVo:isDisposed()
	-- body
	return self.buffstate == 'dead'
end






