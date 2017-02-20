local AIConfigManager = {}

--[[
	if self:handleCommand() then
	elseif self:handleBasic(rolePlayerArr) then
	elseif self:handleEndTarget(rolePlayerArr) then
	elseif self:handleZhiLiaoAuto(rolePlayerArr) then
	elseif self:handleAdvanced(rolePlayerArr) then
	elseif self:handleYuanChengAuto(rolePlayerArr) then
	elseif self:handleWhenNoTarget(rolePlayerArr) then
	end

攻击距离0.7~0.8格子
阻截距离1.0格子
检测距离r >= 阻截距离

是否处在移动中. isMoving

C = Judge + Select

EndTarget
InnerEndTarget

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
			
-------近战AI流程-------
C:是否处于非锁定状态				--isAiUnlocked
	Select:
		C:是否阻截范围内有敌人 		--findEnemyInBlockArea
			Sequence:
				A:选择一个最优的阻截范围内的敌人 ? 优先使用目标敌人 	--findBasicAttackTarget    (setBasicAttackTarget)
				A:近战攻击流程									--runBasicAttack
		
		C:是否需要执行外部指令		--isToExecuteOuterCommand
			A:取消内部指令		--cancelInnerCommand
			A:执行外部指令        --executeOuterCommand
		
		C:是否需要执行内部指令     --isToExecuteInnerCommand
			C:内部指令是否合理 (远程的自动拦截, 如果目标单位已经不在我方阵营, 则无效) (远程的自动换位, 如果目标已经有其它对象前往, 这无效)   --checkInnerCommand
				A:执行内部指令 		--executeInnerCommand
			A:取消内部指令 ( false )  --cancelInnerCommand
			
		C:是否有敌人在近战检测范围内(优先选择上一次选择的对象,其次选择最近的)     --findEnemyInBasicCheckArea
			A:近战攻击流程			 --runBasicAttack
		
		-- ************* 职业特有的AI ************* 
		C:是否开启自动AI              --isAutoAiOpened
			C:是否有敌人在近战自动AI检测范围内    --findEnemyInAutoBasicCheckArea
				A:近战攻击流程				 --runBasicAttack
		-- ************* 职业特有的AI ************* 
		
		-- 
		C:是否处在己方阵营的UI格子并且占据            --isInSelfUIPoint
			A:待机(面朝敌方阵营,站立)               --standToEnemyTeam
		
		Sequence:
			Select:
				C:是否上次记录的返回点当前有人占领    --checkReturnBackPoint
					A:寻找符合职业的无人占领的空的UI格子
			C:是否有返回点                         --isReturnBackPointValid
				A:设置为内部指令 (回调为停止移动 + 占领该UI格子)		--runReturnBack
	
		Error:I Must Do Somethings!
		assert(false)

-------远程攻击流程-------
远程AI流程,仅限于职业特有的AI
C:是否处在己方的UI格子并且占据                      	--isInSelfUIPoint
	C:自己所在行是否有敌人可以进行远程攻击			--isEnemyInSelfLineForShoot
		Select:	
			C:是否处于攻击CD中						--isInAttackCD                    
				A:待机 							--standToEnemyTeam
			A:远程攻击 							--startToLongRangeAttack

C:是否开启AI 										--isAutoAiOpened
	C:是否有敌方单位进入我方阵营 					--isEnemyInTeamCamp
		Sequence:
			A:寻找一个没有被我方任何单位设置为目标的敌人, 并设置为 setBasicAttackTarget (优先使用自己上一次的目标敌人)(优先选择没有被作为目标的对象) (优先选择离自己最近的敌人)  --findTargetForBlock
			A:近战攻击流程     --runBasicAttack

	C:是否其他行有敌人     --isEnemyInOtherLineForShoot
		Sequence:
			A:寻找一个最近的空的占位 (并且没有友军的目标是该点)   --findNearestUIPointForShoot
			A:设置改点为目标点 (内部指令)                      --
			A:向目标点靠拢 (回掉为占领位置, 站立, 返回点重设)     --moveToUIPoint
		
-------治疗AI流程-------
C:是否开启AI:       				--isAutoAiOpened
	C:是否有敌方单位进入我方阵营 	--isEnemyInTeamCamp
		Sequence:
			A:寻找一个没有被我方任何单位设置为目标的敌人, 并设置为 FightTarget (优先使用自己上一次的目标敌人) (优先选择离自己最近的敌人)  --findTargetForBlock
			A:近战攻击流程 		--runBasicAttack

C:是否处在己方的UI格子并且占据      				--isInSelfUIPoint
	C:是否在治疗范围内有残血的友军(包括自己) 		--isFriendInCircleForCure
		C:是否在攻击CD中                  	--isInAttackCD
			A:站立(面朝地方阵营)          		--standToEnemyTeam
		A:执行治疗                       		--startToCure


-------骑士AI流程-------
通战士AI流程:
执行格挡下,会停止AI + 停止移动
--]]



--[[
create node
--]]

--[[
--]]

-- local A_
-- local C_
-- local Select = {}
-- local xx

-- local runBasicAttack = {
-- 	type = '',
-- 	key = '',
-- },


return AIConfigManager