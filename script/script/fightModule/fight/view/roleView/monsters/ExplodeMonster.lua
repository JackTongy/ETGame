local EventCenter 					= require 'EventCenter'
local FightEvent 					= require 'FightEvent'
local SwfActionFactory 				= require 'framework.swf.SwfActionFactory'
local TimeOutManager 				= require 'TimeOut'
local ActionUtil 					= require 'ActionUtil'
local YFMath						= require 'YFMath'
local RoleSelfManager 				= require 'RoleSelfManager'

local ExplodeMonster = class( require 'MonsterPlayer' )

function ExplodeMonster:ctor()
	-- body
	-- assert(false)
end

function ExplodeMonster:trigger()
	-- body
	if self:isDisposed() or self:isDead() then
		return false
	end
	
	self:startToBigSkill()

	-- EventCenter.eventInput( FightEvent.Pve_TriggerBigSkill, { playerId = self.roleDyVo.playerId } )

	local skillBasicVo = self:getBigSkillVo()
	assert(skillBasicVo)
	local action = self:getActionBySkillVo(skillBasicVo,false)
	local animateTime = self:getAnimateTimeByNameMax(action, skillBasicVo)/1000 --ms

	local deadTime = self:getAnimateTimeByName( '死亡' ) / 1000

	self:runWithDelay(function ()
		-- body
		EventCenter.eventInput(FightEvent.Pve_QuickDie, { playerId = self.roleDyVo.playerId } )
		-- self:runWithDelay(function ()
		-- 	-- body
		-- end, deadTime)
		self:setClothVisible(false)
		self:playDead( self, 0, function ( )
			print('自爆人物死亡,删除角色 roleid='..self.roleDyVo.playerId)
			EventCenter.eventInput(FightEvent.DeleteRole, self)	--人物死亡 删除角色  
		end)

	end, animateTime)

	return true
end

function ExplodeMonster:runStage1()
	-- body
	if not self._stage1Finished then
		self._stage1Finished = true

		local action = '大招前'
		-- 毫秒
		local time = self:getAnimateTimeByName(action)/1000

		local completeCallback = function ()
			-- body
		end

		local forceCallback = function ()
			-- body
		end

		self:play(action, nil, false, completeCallback, true, forceCallback, time)

		self:setBloodViewVisible( false )

		print('自爆延迟 '..time)
		self:runWithDelay(function ()
			-- body
			self:trigger()
		end, time)

	end

	return true
end

function ExplodeMonster:startToBasicAttack()
	-- body
	local enemy = self:getBasicAttackTarget()
	if enemy then

		if self:isBlind() then
			return self:standFree()
		end

		return self:runStage1()
	end
end


require 'MonsterFactory'.check(require 'AIType'.Explode_Type, ExplodeMonster)

return ExplodeMonster