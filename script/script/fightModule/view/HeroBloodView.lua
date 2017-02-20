-- local TypeRole = require 'TypeRole'

-- --3/3,2/3,1/3,0/3,   2/2,1/2,0/2,   1/1,0/1
-- local Point_Images = {
-- 	['3-3'] = 'XT_nengliang3_4.png',
-- 	['3-2'] = 'XT_nengliang3_3.png',
-- 	['3-1'] = 'XT_nengliang3_2.png',
-- 	['3-0'] = 'XT_nengliang3_1.png',

-- 	['2-2'] = 'XT_nengliang2_3.png',
-- 	['2-1'] = 'XT_nengliang2_2.png',
-- 	['2-0'] = 'XT_nengliang2_1.png',

-- 	['1-1'] = 'XT_nengliang1_2.png',
-- 	['1-0'] = 'XT_nengliang1_1.png',
-- }

-- local Career_BB_Balls = {
-- 	[1] = 'XT_zhiye1.png',
-- 	[2] = 'XT_zhiye2.png',
-- 	[3] = 'XT_zhiye3.png',
-- 	[4] = 'XT_zhiye4.png',
-- } 

-- local HeroBloodView = class( require 'AbsView' )

-- function HeroBloodView:ctor()
-- 	-- body
-- 	self:setXmlName('BloodBarSet')
-- 	self:setXmlGroup('Fight')
-- 	self._bloodType = bloodtype
	
-- 	local luaset = self:createDyLuaset('@bbHero')
-- 	self._luaset = luaset
-- end

-- function HeroBloodView:setHpPercent( hpPercent )
-- 	-- body
-- 	self._luaset['hp']:setPercentageInTime(manaPercent, 0.5)
-- end

-- function HeroBloodView:setManaPercent( manaPercent )
-- 	-- body
-- 	self._luaset['mana']:setPercentageInTime(manaPercent, 0.5)
-- end

-- function HeroBloodView:setPointBg( point, maxPoint )
-- 	-- body
-- 	local key = string.format('%d-%d', maxPoint, point)
-- 	local resid = Point_Images[key]

-- 	assert(resid, key)
-- 	self._luaset['resid']:setResid(resid)
-- end

-- function HeroBloodView:setCareer( career )
-- 	-- body
-- 	local resid = Career_BB_Balls[career]
-- 	self._luaset['career']:setResid(resid)
-- end

-- return HeroBloodView