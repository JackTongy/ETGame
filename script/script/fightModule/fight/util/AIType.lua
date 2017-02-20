local AIType = {}

AIType.Normal_Type 		= 0		--普通怪
AIType.Speed_Type 		= 1     --速度怪
AIType.AirLand_Type 	= 2		--乱入怪
AIType.Explode_Type 	= 3		--自爆怪
AIType.Invisible_Type 	= 4		--隐形怪
AIType.Copy_Type 		= 5		--拟态怪
AIType.Forward_Type 	= 6		--冲锋怪
AIType.Blood_Type 		= 7		--嗜血怪
AIType.Grow_Type		= 8		--成长怪
AIType.Dance_Type		= 9		--辅助怪
AIType.Thief_Type 		= 10 	--盗贼怪

AIType.Copy2_Type       = 100   --复制怪, 用于程序根据 AIType.Copy_Type怪 复制后生成的怪物
AIType.Copy_CMBS_Type   = 101   --超梦变身
AIType.Copy2_CMBS_Type   = 102   --超梦变身, 用于程序根据 AIType.Copy_CMBS_Type怪变身后生成的怪物


return AIType