local TypeRole = require 'TypeRole'
local BloodView = class( require 'AbsView' )

local Career_Star = {
	[1] = 'ZD_XT_JN3.png',
	[2] = 'ZD_XT_JN1.png',
	[3] = 'ZD_XT_JN2.png',
	[4] = 'ZD_XT_JN0.png',
}

local Awaken_Bg = {
	[0] = 'ZD_XTK0.png',
	[1] = 'ZD_XTK1.png',
	[2] = 'ZD_XTK2.png',
	[3] = 'ZD_XTK3.png',
	[4] = 'ZD_XTK4.png',
	[5] = 'ZD_XTK5.png',
	[6] = 'ZD_XTK6.png',
	[7] = 'ZD_XTK7.png',
}

--3/3,2/3,1/3,0/3,   2/2,1/2,0/2,   1/1,0/1
local Point_Images = {
	['3-3'] = 'XT_nengliang3_4.png',
	['3-2'] = 'XT_nengliang3_3.png',
	['3-1'] = 'XT_nengliang3_2.png',
	['3-0'] = 'XT_nengliang3_1.png',

	['2-2'] = 'XT_nengliang2_3.png',
	['2-1'] = 'XT_nengliang2_2.png',
	['2-0'] = 'XT_nengliang2_1.png',

	['1-1'] = 'XT_nengliang1_2.png',
	['1-0'] = 'XT_nengliang1_1.png',
}

local Career_BB_Balls = {
	[1] = 'XT_zhiye1.png',
	[2] = 'XT_zhiye2.png',
	[3] = 'XT_zhiye3.png',
	[4] = 'XT_zhiye4.png',
} 

function BloodView:ctor(bloodtype)
	print("bloodtype:"..bloodtype)
	-- body
	self:setXmlName('BloodBarSet')
	self:setXmlGroup('Fight')
	--[[
	'@bb'
	bloodtype = 'Boss', 'Hero', 'Monster',
	--]]

	self._bloodType = bloodtype

	local luaset = self:createDyLuaset('@bb'..bloodtype)
	self._luaset = luaset

	self._lastPercentage = 100

	self:setPercentage(100)
	self:setMode(0)
end

function BloodView:setCareer( career )
	-- body
	assert(career)
	assert(career >= 1 and career <= 4)

	-- assert(self._luaset)
	-- for i,v in pairs(self._luaset) do
	-- 	print(i)
	-- end	
	---
	-- self._luaset['star_normal']:setResid( Career_Star[career] )

	local resid = Career_BB_Balls[career]
	self._luaset['career']:setResid(resid)
end

function BloodView:setAwakenIndex( index )
	-- body
	-- index = require 'Res'.getFinalAwake(index)
	-- -- index = 3
	-- local resid = Awaken_Bg[index] or Awaken_Bg[0]
	-- self._luaset['#bg']:setResid(resid)
end

--[[
得到根节点
--]]
function BloodView:getRootNode()
	-- body
	return self._luaset and self._luaset[1]
end

function BloodView:triggerTwinkle()
	-- body
	local node = self._luaset['twinkle']
	if not tolua.isnull(node) then
		require 'framework.helper.MusicHelper'.playEffect( require 'Res'.Sound.bt_rage )
		node:setLoops(1)
		node:start()
	end
end

--[[
设置血量百分比 percentage = 0-100
--]]
function BloodView:setPercentage( percentage, value )
	-- body
	if self:isDisposed() then
		return 
	end

	----hero mode ?
	if self._bloodType == TypeRole.BloodType_Hero or self._bloodType == TypeRole.BloodType_Friend or
		self._bloodType == TypeRole.BloodType_NotFriend then
		self._luaset['hp']:setPercentageInTime(percentage, 0.5)
		return
	end

	-- print('setPercentage = '..tostring(percentage))

	if self._lastPercentage and value then
		if value > 0 then
			if self._lastPercentage > percentage then
				--ignore
				return 
			end
		elseif value < 0 then
			if self._lastPercentage < percentage then
				--ignore
				return 
			end
		end
	end

	--100% -> pos = 77,0
	--0%   -> pos = 7,0
	local rate = percentage/100
	local pos1
	local pos2

	-- TypeRole.BloodType_Boss="Boss"
	-- TypeRole.BloodType_Hero="Hero"
	-- TypeRole.BloodType_Monster="Monster"
	-- TypeRole.BloodType_NotFriend="NotFriend"
	-- TypeRole.BloodType_Friend="Friend"

	if self._bloodType == TypeRole.BloodType_Monster then

		pos1 = {x=0, y=0}
		pos2 = {x=91,y=0}

	elseif self._bloodType == TypeRole.BloodType_Boss then
		pos1 = {x=6, y=0}
		pos2 = {x=163,y=0}

	end

	if self._bloodType == TypeRole.BloodType_Boss then
		print('boss blood = '..percentage)
	end

	if self._lastPercentage > percentage then
		--红色血条
		self:setBarRate(self._luaset['clip_red'], pos1, pos2, rate, 0)
		--黑色血条
		self:setBarRate(self._luaset['clip_black'], pos1, pos2, rate, 0.5)

	elseif self._lastPercentage < percentage then
		--黑色血条
		self:setBarRate(self._luaset['clip_black'], pos1, pos2, rate, 0)
		--红色血条
		self:setBarRate(self._luaset['clip_red'], pos1, pos2, rate, 0.5)

	elseif percentage == 100 then
		--黑色血条
		self:setBarRate(self._luaset['clip_black'], pos1, pos2, rate, 0)
		--红色血条
		self:setBarRate(self._luaset['clip_red'], pos1, pos2, rate, 0)

	end

	self._lastPercentage = percentage
end

function BloodView:setBarRate( node, pos1, pos2, rate, time )
	-- body
	-- time = 0

	if self:isDisposed() or not node then
		return 
	end

	node:stopAllActions()

	local ccpos = ccp( pos1.x + (pos2.x-pos1.x)*rate, pos1.y + (pos2.y-pos1.y)*rate )

	if time > 0 then
		local moveto = CCMoveTo:create(time, ccpos)
		local acton = ElfInterAction:create(moveto, InterHelper.Viscous)
		node:runElfAction(acton)
	else
		node:setPosition(ccpos)
	end
end

function BloodView:setLevel( level )
	-- body
	-- if level == 1 then
	-- 	--
	-- elseif level == 2 then
	-- 	--
	-- end
end

function BloodView:setManaData( data )
	-- body
	if not self:isDisposed() then
		local point 	= data.point
		local maxPoint 	= data.maxPoint
		local percent 	= data.percent

		assert(point)
		assert(maxPoint)
		assert(percent)

		-- print('BloodView:setManaData')
		-- print(data)

		--怪物没怒气
		local key = string.format('%d-%d', maxPoint, point)
		local resid = Point_Images[key]
		-- print(resid)

		assert(resid, key)
		self._luaset['point']:setResid(resid)

		self._luaset['mana']:setPercentageInTime(percent, 0.5)
	end
end

--[[
设置血条Mode 
0.不可释放
1.可释放
2.连锁 
-- 一闪一闪 (代表技能能否释放)
--]]
function BloodView:setMode( mode )
	-- body
	if self:isDisposed() then
		return 
	end
	
	if self._mode ~= mode then
		-- if self._luaset['star_twinkle'] then
		-- 	if mode == 0 then
		-- 		self._luaset['star_twinkle']:stop()
		-- 		self._luaset['star_normal']:setVisible(false)

		-- 	elseif mode == 1 then
		-- 		self._luaset['star_twinkle']:stop()
		-- 		self._luaset['star_normal']:setVisible(true)

		-- 	elseif mode == 2 then
		-- 		self._luaset['star_twinkle']:start()
		-- 		self._luaset['star_normal']:setVisible(false)

		-- 	else
		-- 		error('BloodView:setMode='..mode)
		-- 	end
		-- end
		
		self._mode = mode
	end
end

local function createBloodViewByType( pType )
	-- body
	return BloodView.new( pType )
end

return { createBloodViewByType = createBloodViewByType }

