--[[
--------近战攻击流程------
runBasicAttack
Select:
	C:是否有准备攻击的对象 (带判断攻击对象是否有效)   	--getBasicAttackTarget ()
		C:是否处在合理的攻击占位 (攻击距离范围)(不与队友占位冲突) 	--isPosSuitableForBasicAttack
			A:取消内部指令 		--cancelInnerCommand
			C:是否处在攻击CD中 	--isInAttackCD
				A:面朝敌人站立	--standToEnemy
			A:发起近战攻击 		--startToBasicAttack
		Sequence:
			A:寻找合理攻击位置, 并且设置为内部指令 (优先使用上个并且合理的位置, 否则重新找一个)		--findSuitablePosForBasicAttack
			A:向合理的攻击位置靠拢 (回调站立, 面向敌人)										--moveToSuitablePosForBasicAttack
--]]
local BasicAttackAI = {
	type = 'Condition', key = 'getBasicAttackTarget', 
	children = {
		{ 	type = 'Condition', 'isPosSuitableForBasicAttack',
			children = { 

			} 
		},

	}
}


local HeroAI_JinZhan = {}

HeroAI_JinZhan = { 
	type = 'Select', key = nil, 
	children = {

	}
}





