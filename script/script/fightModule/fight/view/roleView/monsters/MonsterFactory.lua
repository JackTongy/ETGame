-- AIType.Normal_Type 		= 0		--普通怪
-- AIType.Speed_Type 		= 1     --速度怪
-- AIType.AirLand_Type 	= 2		--乱入怪
-- AIType.Explode_Type 	= 3		--自爆怪
-- AIType.Invisible_Type 	= 4		--隐形怪
-- AIType.Copy_Type 		= 5		--拟态怪
-- AIType.Forward_Type 	= 6		--冲锋怪
-- AIType.Blood_Type 		= 7		--嗜血怪
-- AIType.Grow_Type		= 8		--成长怪
-- AIType.Dance_Type		= 9		--辅助怪
-- AIType.Thief_Type		= 10		--辅助怪

local MonsterFactory = {}
local ClassMap = {}

MonsterFactory.check = function ( key, class )
	-- body
	assert(key and not ClassMap[key], 'Unexpected '..tostring(key))

	ClassMap[key] = class
end

MonsterFactory.createMonster = function ( args )
	-- body
	assert(args)

	local aiType = args.aiType or 0

	print('aiType = '..aiType)
	-- if aiType <= 10 then
	-- 	aiType = 6
	-- end

	local class = ClassMap[ aiType ]

	assert(class, 'Unexpected aitype '..tostring(aiType))

	return class.new( args )
end

return MonsterFactory