local AIMain = class(require 'AIMaster')

function AIMain:ctor()
	-- body
end

function AIMain:init()
	-- body
	local selfPlayer = self:getPlayer()
	assert(selfPlayer)

	local funcMap = {}



	-------------------------------- Condition --------------------------------
	-- 是否角色死亡
	funcMap['C_IsPlayerAlived'] = function ()
		-- body
		return selfPlayer:C_IsPlayerAlived()
	end

	-- 是否处在AI状态
	funcMap['C_IsAIRunnable'] = function ()
		-- body
		return selfPlayer:C_IsAIRunnable()
	end
	-- 近战攻击范围内是否有敌人
	funcMap['C_IsEnemyNearBy'] = function ()
		-- body
		return selfPlayer:C_IsEnemyNearBy()
	end
	-- 直线上是否有敌人可以远程攻击
	funcMap['C_IsEnemyOnCurrentLine'] = function ()
		-- body
		return selfPlayer:C_IsEnemyOnCurrentLine()
	end
	-- 是否有友军在范围内可以加血
	funcMap['C_IsHurtedFriendsNearBy'] = function ()
		-- body
	end
	-- 是否敌军进入我方阵营
	funcMap['C_IsEnemyForcedInto'] = function ()
		-- body
	end

	-------------------------------- Action --------------------------------
	-- EmptyTrue
	funcMap['ActionTrue'] = function ()
		-- body
		return true
	end
	-- EmptyFalse
	funcMap['ActionFalse'] = function ()
		-- body
		return false
	end
	-- 调整处在位置的不适状态
	funcMap[''] = function ()
		-- body
	end
	-- 执行移动指令
	funcMap[''] = function ()
		-- body
	end
	-- 回归原位
	funcMap[''] = function ()
		-- body
	end
	--一直向前
	funcMap[''] = function ()
		-- body
	end
	--站立呼吸
	funcMap[''] = function ()
		-- body
	end
	--骑士格挡
	funcMap[''] = function ()
		-- body
	end
	-- 近战攻击
	funcMap[''] = function ()
		-- body
	end
	-- 远程攻击
	funcMap[''] = function ()
		-- body
	end
	-- 治疗
	funcMap[''] = function ()
		-- body
	end
	-- 大招攻击
	funcMap[''] = function ()
		-- body
	end
	-- 执行歌舞
	funcMap[''] = function ()
		-- body
	end
end


return AIMain