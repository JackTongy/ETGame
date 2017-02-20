local Job_Images = { [0]='hei.png', [1]='zhanshi.png', [2]='tanke.png', [3]='dps.png', [4]='zhiliao.png', }

local adaptX = (-(1136 - require 'Global'.getWidth())/2)*0 
local offsetX = -105
adaptX = adaptX + offsetX

local Target_Position_X = { adaptX+245, adaptX+177, adaptX+109, adaptX+41, adaptX-25, adaptX-95, adaptX-163, adaptX-231 }
local Target_Position_Y = -283

local Ball = class()

function Ball:ctor(parent, career)
	-- body
	self._career = career
	self._node = ElfNode:create()
	self._node:setResid( Job_Images[career] )

	if not tolua.isnull(parent) then
		parent:addChild(self._node)
	end
end

function Ball:getCareer()
	-- body
	return self._career
end

function Ball:isDisposed()
	-- body
	return self._isDisposed or tolua.isnull(self._node)
end

function Ball:setDisposed()
	-- body
	if not self._isDisposed then
		self._isDisposed = true

		if not tolua.isnull(self._node) then
			local action = CCFadeOut:create(0.5)
			local elfAction = ElfAction:create(action)

			elfAction:setListener(function ()
				-- body
				self._node:removeFromParent()
			end)
			self._node:runElfAction(elfAction)
		end
	end
end

function Ball:getPositionByIndex( index )
	-- body
	-- index = 4.5, x = -30 

	return { 178 - (index-1) * 68 , -2 }
end

function Ball:goToIndex( index )
	-- body
	if not self:isDisposed() then
		local pos = self:getPositionByIndex( index )

		local action = CCMoveTo:create(0.5, ccp(pos[1], pos[2]))
		self._node:runElfAction(action)
	end
end

function Ball:setToIndex( index )
	-- body
	if not self:isDisposed() then
		local pos = self:getPositionByIndex( index )
		self._node:setPosition(ccp(pos[1], pos[2]))
	end
end

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

local EventCenter = require 'EventCenter'
local EnergyView = require 'EnergyView'
local LadyBall = require 'LadyBall'
local DieBall = require 'DieBall'
local DeadBallManager = require 'DeadBallManager'

local FightEvent = require 'FightEvent'

local BallBarView = class( require 'BasicView' )

function BallBarView:ctor( luaset, document )
	-- body
	self._ballArray = {}
	self._luaset = luaset
	self._document = document

	self:addEvents()
end

function BallBarView:addEvents()
	-- body

	--能量球
	EventCenter.addEventFunc(FightEvent.Pve_Slot, function ( data )

		-- print(data)
		-- if true then
		-- 	return
		-- end

		if data.D.S == 1 then

			self:showSlot(data.D.Bs, data.D.label)

		elseif data.D.S == 2 then

			-- self:addArray(data.D.Bs)
			-- debug.catch(true, 'BallBarView 2')
			if self:islocked() then
				if data.D.Bs then
					for i,v in ipairs(data.D.Bs) do
						self:insertBallForLockedMode(v)
					end
				end
			else
				if data.D.Bs then
					for i,v in ipairs(data.D.Bs) do
						self:addBallByCareer(v)
					end
				end
			end

		elseif data.D.S == 3 then
			--击杀

			print('checkDeadPlayer '..tostring(data.D.Hid))

			DeadBallManager.checkDeadPlayer( data.D.Hid )

		end

	end, 'Fight')


	self._isUnderBossWave = false
	--Ladyball
	EventCenter.addEventFunc(FightEvent.Pve_NextWaveComing, function ( data )
		--
		if data.isboss then
			self:startLadyBall()
		else
			self:stopLadyBall()
		end
	end, 'Fight')

	-- local data = { isboss = self._waveArr[self._playIndex]:isBossWave(), waveIndex = self._playIndex, maxWaveIndex = self._waveSize }
	-- eventCenter.eventInput(fightEvent.Pve_NextWaveComing, data)	--//参数  true表示为boss false 表示为不是boss波数

	--死亡能量球
	EventCenter.addEventFunc(FightEvent.Pve_DieBall, function ( data )
		local dBall = DieBall.new(self._luaset, self._document, self)
		dBall:show( data.pos )
	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_StartLadyBallForChampion, function ( data )
		-- body
		self:startLadyBall2()
	end, 'Fight')

end

function BallBarView:getAllCareer()
	-- body
	local all = { 1, 2, 3, 4 }

	return all
end

--[[
老虎机
info:
career  	-> {1,2,4}
label  		-> 回合 xxx
result 		-> {1,1,4}
targetIndex	-> 1
--]]
function BallBarView:showSlot( result, label )
	-- body

	self:lock()

	local info = {}

	-- result = { 1, 2, 3 }

	info.career = self:getAllCareer()
	info.result = self:getFullResult( result )

	info.label = label
	info.targetIndex = self:getSize() + 1
	info.func = function ()
		-- body
		for i,v in ipairs( info.result ) do
			if v > 0 then
				self:addBallByCareer(v)
			end
		end

		self:unlock()
	end

	assert(self._luaset)
	assert(self._document)

	local eView = EnergyView.new( self._luaset, self._document )
	eView:show(info)

end

function BallBarView:lock()
	-- body
	self._lock = true
end

function BallBarView:unlock()
	-- body
	self._lock = false

	self:runWithDelay(function ()
		-- body
		if self._lockBallArray then
			for i,v in ipairs(self._lockBallArray) do
				self:addBallByCareer(v)
			end
			self._lockBallArray = nil
		end

	end, 1)
end

function BallBarView:islocked()
	-- body
	return self._lock
end

function BallBarView:insertBallForLockedMode( career )
	-- body
	self._lockBallArray = self._lockBallArray or {}
	table.insert(self._lockBallArray, career)
end

function BallBarView:getFullResult( result )
	-- body
	if result then
		local fullResult = {0,0,0}

		for i,v in ipairs(result) do
			fullResult[i] = result[i]
		end

		--resort
		for i=1,3 do
			local randomIndex = math.random(1,3) --return 1-3
			assert(randomIndex>=1 and randomIndex<=3)
			local tmp = fullResult[i]
			fullResult[i] = fullResult[randomIndex]
			fullResult[randomIndex] = tmp
		end

		return fullResult
	end

	return result
end


function BallBarView:startLadyBall()
	-- body
	self._isUnderBossWave = true
	self._nextLadyTimeMs = 20

	self._ladyBallProgress = 0

	if not self._handler then
		self._handler = require 'FightTimer'.addFunc(function ( dt )
			-- body
			self:updateLadyBall(dt)
		end)
	end
	
	if self._lastLadyBall then
		self._lastLadyBall:hide()
		self._lastLadyBall = nil
	end
end

-----10s for champion
function BallBarView:startLadyBall2()
	-- body
	self._isUnderBossWave = true
	self._nextLadyTimeMs = 10

	self._ladyBallProgress = 0

	if not self._handler then
		self._handler = require 'FightTimer'.addFunc(function ( dt )
			-- body
			self:updateLadyBall(dt)
		end)
	end
	
	if self._lastLadyBall then
		self._lastLadyBall:hide()
		self._lastLadyBall = nil
	end
end

function BallBarView:stopLadyBall()
	-- body
	self._isUnderBossWave = false

	if self._lastLadyBall then
		self._lastLadyBall:hide()
		self._lastLadyBall = nil
	end
end

function BallBarView:updateLadyBall( dt )
	-- body
	-- print('BallBarView dt = '..dt)

	if not self._isUnderBossWave then
		return false
	end

	if self._lastLadyBall and not self._lastLadyBall:isDisposed() then
		return false
	end

	if tolua.isnull(self._document) then
		return true
	end

	-- local x = self._luaset[1]:getPositionX()
	-- print('my x = '..x)

	self._ladyBallProgress = self._ladyBallProgress + dt

	if self._ladyBallProgress  >= self._nextLadyTimeMs then

		print('出现 LadyBall !')

		local lView = LadyBall.new(self._luaset, self._document, self)
		lView:show()

		self._ladyBallProgress = 0
		self._lastLadyBall = lView
		return false
	end

	return false
end

function BallBarView:removeBallByCareer( career, num )
	-- body
	num = num or 10 --全部移除

	-- local removeIndexArray = {}
	local removedCount = 0
	
	local size = #self._ballArray
	for i=1, size do
		local ball = self._ballArray[i]
		
		if ball:getCareer() == career and num > removedCount then
			-- print('removedCount = '..removedCount)
			ball:setDisposed()
			removedCount = removedCount + 1
		end
		
		if removedCount > 0 and not ball:isDisposed() then
			ball:goToIndex( i - removedCount )
		end
	end
	
	for i=size,1,-1 do
		local ball = self._ballArray[i]
		if ball:isDisposed() then
			table.remove(self._ballArray, i)
		end
	end
end

function BallBarView:addBallByCareer( career )
	-- body
	if not self:isFull() and career > 0 then
		local ball = Ball.new(self._luaset['uiLayer_rb_ballBar'], career)
		table.insert(self._ballArray, ball)

		local index = #self._ballArray
		ball:setToIndex(index)
	end
end

function BallBarView:getBallNumByCareer( career )
	-- body
	local num = 0

	for i,ball in ipairs(self._ballArray) do
		if not ball:isDisposed() and ball:getCareer()==career then
			num = num + 1
		end
	end
	
	return num
end

function BallBarView:getSize()
	-- body
	return #self._ballArray
end

function BallBarView:getMaxSize()
	-- body
	return 8
end

function BallBarView:isFull()
	-- body
	return self:getSize() >= self:getMaxSize()
end


function BallBarView:getTargetPositionByIndex( index )
	-- body
	return {  Target_Position_X[index], Target_Position_Y }
end

function BallBarView:getAllCareer()
	-- body
	local RolePlayerManager = require 'RolePlayerManager'

	local ownPlayerDict = RolePlayerManager.getOwnPlayerMapSorted()

	local map = {}
	local array = {}

	for i,role in ipairs(ownPlayerDict) do
		if not role:isDead() then
			local career = role.roleDyVo.career
			if not map[career] then
				map[career] = true
				table.insert(array, career)
			end
			
		end
	end

	return array
end

--[[
called by DieBall
--]]
function BallBarView:getRandomCareer()
	-- body
	local array = self:getAllCareer()

	if #array > 0 then
		local index = math.random(1, #array)
		return array[index]
	end

	return 0
end

function BallBarView:getImageByCareer( career )
	-- body
	return Job_Images[career]
end


return BallBarView
