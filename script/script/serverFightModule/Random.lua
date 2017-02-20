local random = {}

local debugCount = 0

function random.randomseed( seed )
	-- body
	seed = seed or 0
	-- math.randomseed(seed)	
	debugCount = 0

	SystemHelper:initRandom( seed )

end

function random.ranI(i1, i2)
	-- body
	assert(i1)
	assert(i2)

	if i1 == i2 or i1 > i2 then
		return i1
	end

	local ret = SystemHelper:random(i1, i2+1)

	-- debugCount = debugCount + 1
	-- print(string.format('Random C=%d,[%d,%d]->%d, t=%f', debugCount, i1, i2, ret, require 'FightTimer'.currentFightTimeMillis()))

	return ret
end

function random.ranF()
	-- body
	-- local ret = math.random()
	-- assert(ret >= 0 and ret <= 1)
	-- return ret

	local ret = SystemHelper:random()
	assert(ret >= 0 and ret <= 1)

	-- debugCount = debugCount + 1
	-- print(string.format('Random C=%d,f=%f, t=%f', debugCount, ret, require 'FightTimer'.currentFightTimeMillis()))

	return ret

end

-- print('-------------Random-------------')
-- for i=1, 1000 do
-- 	print( random.ranF() )
-- end
-- print('--------------------------------')

function random.generateSeed()
	-- body
	return math.floor( math.modf(SystemHelper:currentTimeMillis()/10000) )
end

-------------------------------------------------------------------
-- local bit = require 'bit'

-- local NewRandom = class()

-- function NewRandom:ctor( seed )
-- 	-- body
-- 	seed = seed or 0

-- 	self._seed = seed
-- end

-- function NewRandom.ranI( i1, i2 )
-- 	-- body
-- 	local seed = self._seed

-- 	seed = seed * 0x343fd + 0x269EC3

-- 	*seed = *seed * 0x343fd + 0x269EC3;  // a=214013, b=2531011

-- 	seed = bit.brshift(seed, 0x10)
-- end

-- static int m_rand(int* seed)
-- {
--     *seed = *seed*0x343fd + 0x269EC3;  // a=214013, b=2531011
--     return (*seed >> 0x10) & 0x7FFF;
-- }


return random
