
-- 其他玩家
-- imports
---------------------------------------------------------------------------------------------
local AbsPlayer 					= require 'AbsPlayer'
local RoleDyVo 						= require 'RoleDyVo'
local YFMath						= require 'YFMath'
local EventCenter 					= require 'EventCenter'
local ActionUtil 					= require 'ActionUtil'
local FightEvent 					= require 'FightEvent'
local SkillBasicManager 		 	= require 'SkillBasicManager'
local CharactorConfigBasicManager 	= require 'CharactorConfigBasicManager' 
local FightTimer 					= require 'FightTimer'
local RolePlayerManager 			= require 'RolePlayerManager'
local SkillUtil 					= require 'SkillUtil'
local RoleSelfManager 				= require 'RoleSelfManager'
local TypeRole 						= require 'TypeRole'
local Utils 						= require "framework.helper.Utils"
local Accelerate 					= require "Accelerate"
local TimeOutManager 				= require "TimeOut"
local SpecailManager 				= require "SpecailManager"
local DirectionUtil 				= require "DirectionUtil"
local CfgHelper 					= require 'CfgHelper'
local UpdateRate 					= require 'UpdateRate'
local GridManager 					= require 'GridManager'
local FightView 					= require 'FightView'
local GHType 						= require 'GHType'

local AIMaster 						= require 'AIMaster'
local BT_Node 						= require 'BT_Node'

local Min_Friend_Dis 				= 0.4

local Basic_Atk_Dis 				= 0.75

local Basic_Atk_Dis_Max 			= 0.95
local Basic_Atk_Dis_Min 			= 0.55

local Basic_Atk_Move_Dis_Max 			= 0.76
local Basic_Atk_Move_Dis_Min 			= 0.74

-- local Hero_Block_Dis  				= 1.5
local Monster_Block_Dis 			= 1.0
local Move_Block_Angle  			= 160

local Hero_Block_Dis_Arr = {
	[1] = 1.5,
	[2] = 1.5,
	[3] = 1.5,
	[4] = 1.0,
}


-- 远程攻击次数5
local Monster_LongRange_Times 		= CfgHelper.getCache('BattleSetConfig', 'Key', 'hittimes', 'Value')  or 30

--远程单位 连续攻击5次后停止攻击向危险区域移动  怪物远程单位只能远程 5次
---------------------------------------------------------------------------------------------
local HeroPlayer = class(AbsPlayer)

-- local CD_RATE = 1
-- local Career_CD = {
-- 	[TypeRole.Career_ZhanShi] 	= 1500 * CD_RATE,
-- 	[TypeRole.Career_QiShi] 	= 1750 * CD_RATE,
-- 	[TypeRole.Career_YuanCheng] = 2000 * CD_RATE,
-- 	[TypeRole.Career_ZiLiao] 	= 2000 * CD_RATE,
-- } 

-- local Guider_Career_CD = {
-- 	[TypeRole.Career_ZhanShi] 	= 1500,
-- 	[TypeRole.Career_QiShi] 	= 1750,
-- 	[TypeRole.Career_YuanCheng] = 2000,
-- 	[TypeRole.Career_ZiLiao] 	= 3500,
-- }

function HeroPlayer:ctor()	
	self._aiTime = RoleSelfManager.getAITime()
	--上一次技能触发d时间
	self:updateSkillTime()
end

function HeroPlayer:initRoleDyVo( roleDyVo )
	assert(roleDyVo)

	self.roleDyVo = roleDyVo

	print('hero dyvo')
	print(roleDyVo)
	
	self:initForIsDancer()

	self:checkCacheVo()
	
	self.roleDyVo.career = self:getCareer()
	
	if self._cloth then
		self._cloth:setRoleDyVo( self.roleDyVo, self:getCareer() )
	end

	if self:isMonsterBoss() then
		local defaultSkillCD 
		local mode = require 'ServerRecord'.getMode()
		
		if mode == 'bossBattle' then
			defaultSkillCD = CfgHelper.getCache('BattleSetConfig', 'Key', 'SpecialBossSkillCD', 'Value')
			assert(defaultSkillCD)
		elseif mode == 'CMBossBattle' or mode == 'SDNBossBattle' then
			defaultSkillCD = CfgHelper.getCache('BattleSetConfig', 'Key', 'BossActiveSkillCD', 'Value')
			assert(defaultSkillCD)
		end
		
		if defaultSkillCD then
			self.roleDyVo.SkillCD = defaultSkillCD
		end

		self:initBossBigSkillWarnings()
	end
end

---暂时用在怪物身上   怪物刚出生 走出来的时候放大招暂停，可能回导致怪物移动终止产生bug 所以需要加上这个值做补救
function HeroPlayer:setTempPos(pos )
	self._tempPos=pos
end

--暂时用在怪物身上
function HeroPlayer:getTempPos(  )
	return self._tempPos
end

function HeroPlayer:getAtkCD()
	-- body
	if not self._atkCD then
		if require 'ServerRecord'.isArenaMode() then
			local cd = CfgHelper.getCache('charactorConfig', 'id', self.roleDyVo.charactorId, 'Atktime')
			-- or 2
			if not cd then
				cd = 2
				print('getAtkCD not found id'..tostring(self.charactorId))
			end

			self._atkCD = cd * 1000
		-- elseif self:isMonster()
		elseif self.roleDyVo.heroid then
			local cd = CfgHelper.getCache('MonsterConfig', 'heroid', self.roleDyVo.heroid, 'atktime') or 2
			self._atkCD = cd * 1000
		else
			local cd = CfgHelper.getCache('charactorConfig', 'id', self.roleDyVo.basicId, 'Atktime') or 2
			self._atkCD = cd * 1000
		end

		print(string.format('Id=%d, cd=%.2f', self.roleDyVo.playerId, self._atkCD))
	end

	return self._atkCD
end

-- function HeroPlayer:setAtkSpdRate( rate )
-- 	-- body
-- 	assert(rate)

-- 	self._atkSpdRate = rate
-- end

-- function HeroPlayer:getAtkSpdRate( ... )
-- 	-- body
-- end

-- 不同职业的战斗频率不一样
function HeroPlayer:cantriggerSKillByCareer()
	--
	local currentTime = require 'FightTimer'.currentFightTimeMillis()
	local cd = self:getAtkCD()/self:getAtkSpdRate()

	if currentTime - self._preSkillTime >= cd then
		return  true
	end
end

function HeroPlayer:updateSkillTime( mills )
	mills = mills or 0
	if not self._preSkillTime then
		self._preSkillTime = require 'FightTimer'.currentFightTimeMillis() - 999999
	else
		self._preSkillTime = require 'FightTimer'.currentFightTimeMillis() - mills
	end
end

function HeroPlayer:startAI()

	if self._updateHandle == nil then
		self._preAITime = require 'FightTimer'.currentFightTimeMillis() - 50
		
		print(string.format('Ai order %d', self.roleDyVo.playerId))

		if self:isMonsterBoss() then
			self._bigSkillLastTimeStep = require 'FightTimer'.currentFightTimeMillis()	
		end

		self._updateHandle = FightTimer.addFunc( function ( dt )
			
			local time = require 'FightTimer'.currentFightTimeMillis()
			local dif = time - self._preAITime 

			if dif >= self._aiTime then

				local prev = SystemHelper:currentTimeMillis()
				
				self:handleAI()
				
				local now = SystemHelper:currentTimeMillis()
				
				if now - prev > 20 then
					print('Id = '..self.roleDyVo.playerId)
					print('Handle AI Time '..(now-prev))
				end
				
				self._preAITime = time
			end
		end)
	end
end



function HeroPlayer:stopAI()
	if self._updateHandle then
		FightTimer.removeFunc(self._updateHandle)
		self._updateHandle = nil
	end
end

-- rolePlayerArr敌方数组	
function HeroPlayer:handleAI()
	self:runHeroAILoop()
end


function HeroPlayer:isInEllipse(a,b, pos )
	return YFMath.isInEllipse(self:getPosition(),a,b,pos)
end

--近战检测
function HeroPlayer:isInEllipse2(skillBasicVo, target)
	local range = self:getRange(skillBasicVo)
	return self:isInEllipse(range[1]*GridManager.getUIGridWidth(), range[2]*GridManager.getUIGridHeight(),target:getPosition())
end

-- aUint bUint 是格子数 
function HeroPlayer:isInEllipse3(aUint,bUint, pos)
	return YFMath.isInEllipse(self:getPosition(),aUint*GridManager.getUIGridWidth(),bUint*GridManager.getUIGridHeight(),pos)
end

--目标对象target是否在巨型范围内
function HeroPlayer:isInLine( skillBasicVo, target )
	local dir = RoleSelfManager.getPlayerBackStandDir( self )
	local range = self:getRange(skillBasicVo)
	return YFMath.isInLine(self:getPosition(),skillBasicVo.range[1]*GridManager.getUIGridWidth(),skillBasicVo.range[2]*GridManager.getUIGridHeight(),dir, target:getPosition())
end

function HeroPlayer:isInLine2( skillBasicVo, target )
	local dir = self:getActiveDirection()
	local range = self:getRange(skillBasicVo)
	return YFMath.isInLine(self:getPosition(),skillBasicVo.range[1]*GridManager.getUIGridWidth(),skillBasicVo.range[2]*GridManager.getUIGridHeight(),dir, target:getPosition())
end

-- 加暴击修饰
function HeroPlayer:getActionBySkillVo( skillBasicVo, isCrit )
	-- body
	local  action =  nil
	if not isCrit  then
		-- 近战
		if skillBasicVo.skilltype == SkillUtil.SkillType_JinZhan or skillBasicVo.skilltype == SkillUtil.SkillType_YuanChengJinZhan  then
			action = ActionUtil.Action_Attack
		elseif skillBasicVo.skilltype == SkillUtil.SkillType_YuanCheng then
			action = ActionUtil.Action_RemoteAttack
		elseif skillBasicVo.skilltype == SkillUtil.SkillType_ZiLiao then
			action = ActionUtil.Action_ZhiLiao
		end
	else
		-- 近战
		if skillBasicVo.skilltype == SkillUtil.SkillType_JinZhan or skillBasicVo.skilltype == SkillUtil.SkillType_YuanChengJinZhan  then
			action = ActionUtil.Action_AttackCrit
		elseif skillBasicVo.skilltype == SkillUtil.SkillType_YuanCheng then
			action = ActionUtil.Action_RemoteCrit
		elseif skillBasicVo.skilltype == SkillUtil.SkillType_ZiLiao then
			action = ActionUtil.Action_ZhiLiao
		end
	end

	if skillBasicVo.skilltype >=10 then
		action = ActionUtil.Action_BigSkill
	end

	return action
end

--是否开启自动ai
function HeroPlayer:getAuto()
	return Accelerate.getAuto()
end


function HeroPlayer:getRange(skillVo)
	-- body
	assert(skillVo)

	if self.roleDyVo.isHealLarger then
		if skillVo.skilltype == SkillUtil.SkillType_ZiLiao then

			local serverRole = require 'ServerController'.findRoleByDyIdAnyway(self.roleDyVo.playerId)
			if serverRole then
				local buffArray = serverRole:getBuffArray()

				local larger = buffArray:getValueByKey( GHType.GH_HealLarger ) or 0 
				larger = larger + (buffArray:getValueByKey(GHType.GH_95) or 0)

				local range = {}
				range[1] = skillVo.range[1] + larger
				range[2] = skillVo.range[2] + larger

				return range
			end
		end
	end

	return skillVo.range
end


function HeroPlayer:dispose(  )
	-- body
	if not self._isDispose then

		self._tweenSimple:dispose()
		self._tweenSimple = nil

		self:deleteGrid()

		GridManager.removePlayerState(self)

		if self._cloth then
			self._cloth:dispose()
			self._cloth = nil
		end

		self:stopAI()

		self._buffMap = nil

		self._isDispose=true

		self:onDead()
	end
end

--[[
冲锋, 格子数量
--]]
function HeroPlayer:chargeForward( skillVo, arr, direction )
	-- body
	local gridNum = skillVo.assault or 0

	if gridNum > 0 and skillVo.skilltype >= 10 then

		

		local delay = 8*0.05

		local time = 10*0.03
		local dx = GridManager.getUIGridWidth() * gridNum

		dx = math.min(dx, 1136)
		dx = math.max(dx, 0)

		local pos = self:getPosition()

		local aDir = self:getActiveDirection()

		assert(aDir==1 or aDir==2, 'dir = '..tostring(aDir))

		print('forward dir ='..tostring(aDir))
		print('forward dir2 ='..tostring(direction))
		-- actionManager.Direction_Right = 1
		-- actionManager.Direction_Left = 2

		if direction == -1 then
			direction = aDir
		end

		local nextX

		if direction == ActionUtil.Direction_Left then
			nextX = pos.x - dx
			
			nextX = math.min(nextX, 1136)
			nextX = math.max(nextX, 0)

			dx = pos.x - nextX
			pos.x = nextX
		else
			nextX = pos.x + dx

			nextX = math.min(nextX, 1136)
			nextX = math.max(nextX, 0)

			dx = nextX - pos.x
			pos.x = nextX
		end

		local speed = (dx / time) / UpdateRate.getOriginRate()

		-- self:set
		local dir = -1

		self:runWithDelay(function ()
			-- body
			self:pureMoveToPos(pos, speed, function ()
				-- print('moveCompleteDir2222=')
				if RolePlayerManager.canFightPlayer(self) then
					-- print("moveCompleteDir="..uAtk:getActiveDirection())
					self:play(ActionUtil.Action_Stand, dir, true, nil, true)
					-- uAtk:unLockBeatback()
				end
			end)
		end, delay)

		return true
	end

	return false
end

function HeroPlayer:setAutoTarget( target )
	-- body
	self._autoTarget = target
end

function HeroPlayer:getAutoTarget()
	-- body
	return self._autoTarget
end


---------------------------------------------------------------------------
---------------------------------------------------------------------------
--New API
---------------------------AI----------------------
--[[ 
一些前置条件:
1.安全区  --除去竞技场,有
2.大招无敌状态

3.准备攻击的敌人
4.准备发起攻击的位置
5.准备移动过去的格子
5.内部指令 -> 
6.外部指令 ->

执行内部指令
执行外部指令

一些词汇:
近战, 远程, 治疗, 大招
jz, yc, zl, dz
--]]

--basic api
function HeroPlayer:checkCacheVo()
	-- body
	if not self._charactorVo then
		self._charactorVo 		= CharactorConfigBasicManager.getCharactorBasicVo(self.roleDyVo.basicId)
		self._basicSkillVo 		= SkillBasicManager.getSkill(self._charactorVo.default_skill)

		-- 远程 或者 治疗
		local career = self:getCareer()

		if career == TypeRole.Career_ZiLiao or career == TypeRole.Career_YuanCheng then
			self._advancedSkillVo = SkillBasicManager.getSkill(self._charactorVo.advance_skill)
		end

		if self._charactorVo.skill_id ~= 0 then
			self._bigSkillVo 		= SkillBasicManager.getSkill(self._charactorVo.skill_id)
		end
	end
end

function HeroPlayer:getCharactorVo()
	-- body
	self:checkCacheVo()
	return self._charactorVo
end

function HeroPlayer:getBasicSkillVo()
	-- body
	self:checkCacheVo()
	return self._basicSkillVo
end

function HeroPlayer:getAdvancedSkillVo()
	-- body
	self:checkCacheVo()
	return self._advancedSkillVo
end

function HeroPlayer:getBigSkillVo()
	-- body
	self:checkCacheVo()
	return self._bigSkillVo
end

function HeroPlayer:getCareer()
	-- body
	return self:getCharactorVo().atk_method_system
end

function HeroPlayer:isAiUnlocked()
	-- body
	if self:isDisposed() then
		return false
	end

	if require 'ServerRecord'.getGameOverFlag() then
		self:runWithDelay(function ()
			-- body
			if self._cloth then
				self._cloth:doNotPlayWalk()
			end
		end, 1)

		self:stopAI()

		return false
	end

	if not self.roleDyVo:canMove() then
		return false
	end

	if self.roleDyVo.isGeWu then  --处在歌舞当中
		return false
	end

	if (not self:isTotalLocked()) then
		if self.roleDyVo.hpPercent > 0 then
			return true
		end
	end

	return false
end

function HeroPlayer:getBasicAttackTarget()
	-- check
	if self._basicAttackTarget then
		if self._basicAttackTarget:isDisposed() then
			self._basicAttackTarget = nil
		end
	end
	return self._basicAttackTarget
end

function HeroPlayer:setBasicAttackTarget(target)
	-- body
	if self._basicAttackTarget then
		self._basicAttackTarget:addBasicAttackerCount(-1)
	end

	self._basicAttackTarget = target

	if self._basicAttackTarget then
		assert(type(self._basicAttackTarget) == 'table')
		self._basicAttackTarget:addBasicAttackerCount(1)
	end

	return true
end

-- 记录多少player准备近战攻击自己
function HeroPlayer:addBasicAttackerCount(add)
	-- body
	assert(add)
	self._basicAttackerCount = self._basicAttackerCount or 0
	self._basicAttackerCount = self._basicAttackerCount + add
end

function HeroPlayer:getBasicAttackerCount()
	-- body
	self._basicAttackerCount = self._basicAttackerCount or 0
	return self._basicAttackerCount
end

function HeroPlayer:setInnerCommand( endPoint )
	-- body
	self._innerEndPoint = endPoint
	self._innerIsUiPoint = GridManager.isUICenter(endPoint)
	return true
end

function HeroPlayer:cancelInnerCommand()
	-- body
	return self:setInnerCommand(nil,nil)
end

function HeroPlayer:checkInnerCommand()
	-- body
	if self:isDisposed() or self:isPlayDeadCalled() then
		return self:cancelOuterCommand()
	end

	if self._innerEndPoint then
		if self._innerIsUiPoint then
			-- 检查当前UI点是否有人占据
			local valid = GridManager.isSelfUICenterValid(self, self._innerEndPoint)
			if not valid then
				self:cancelInnerCommand()
			end
		end
	end
end

function HeroPlayer:getInnerEndPoint()
	-- body
	self:checkInnerCommand()
	return self._innerEndPoint
end

function HeroPlayer:setOuterCommand( endTarget, isPlayer )
	-- body
	self._outerEndTarget = endTarget
	self._outerIsPlayer = isPlayer

	if self._outerEndTarget then
		if (not self:isSkillActionLocked()) and (not self:isDisposed()) and (not self:isPlayDeadCalled()) then
			self:cancelAttack()
			self:executeOuterCommand()
		end
	end

	return true
end

function HeroPlayer:checkOuterCommand()
	-- body
	if self:isDisposed() or self:isPlayDeadCalled() then
		return self:cancelOuterCommand()
	end

	if self._outerIsPlayer then
		if self._outerEndTarget then
			if self._outerEndTarget:isDisposed() then
				return self:cancelOuterCommand()
			end
		end
	end
end

function HeroPlayer:executeInnerCommand()
	-- body
	self:checkInnerCommand()
	if self._innerEndPoint then
		self:moveToNewPos(self._innerEndPoint, function ()
			-- body
			if self._innerIsUiPoint then
				-- self:standToEnemyTeam()
			else
				-- do nothing
			end
		end)
	end
end

function HeroPlayer:cancelOuterCommand()
	-- body
	return self:setOuterCommand(nil,nil)
end

function HeroPlayer:getOuterEndPoint()
	-- body
	self:checkOuterCommand()
	if self._outerEndTarget then
		if self._outerIsPlayer then
			return self._outerEndTarget:getPosition()
		else
			return self._outerEndTarget
		end
	end
end

function HeroPlayer:executeOuterCommand()
	-- body
	self:setMoveBackEnable(false)

	self:checkOuterCommand()
	if self._outerEndTarget then
		-- move
		if self._outerIsPlayer then
			local pos = self._outerEndTarget:getPosition()
			self:moveToNewPos(pos, function ()
				-- body
				self:cancelOuterCommand()
			end)
		else
			local pos = self._outerEndTarget
			self:moveToNewPos(pos, function ()
				-- body
				self:cancelOuterCommand()
				-- self:standToEnemyTeam()
			end)
		end

		return true
	end
end

function HeroPlayer:getOuterPoint()
	-- body
	self:checkOuterCommand()
	if self._outerEndTarget then
		if self._outerIsPlayer then
			return self._outerEndTarget:getPosition()
		else
			return { x=self._outerEndTarget.x, y=self._outerEndTarget.y }
		end
	end
end

function HeroPlayer:hasOuterCommand()
	-- body
	self:checkOuterCommand()
	return self._outerEndTarget
end

-- 
function HeroPlayer:getCurrentEndPos()
	-- body
	return self._currentEndPos
end

function HeroPlayer:setCurrentEndPos( pos )
	-- body
	self._currentEndPos = pos
end

function HeroPlayer:moveToNewPos(pos, func)
	assert(pos)

	if self:isDisposed() then
		return false
	end

	if not self.roleDyVo:canMove() then
		print("处于冰冻中...")
		return 
	end 

	local changeDir = true

	if not self:isTotalLocked() then

		GridManager.updatePlayerState(self, pos)

		local selfPos = self:getPosition() 

		if changeDir then
			self:updatePathDirection(pos.x, pos.y)
		else
			self:play(ActionUtil.Action_Walk)
		end

		self:deleteGrid()
		self._tweenSimple:stop()

		self:setCurrentEndPos(pos)

		self._tweenSimple:tweenTo(self.roleDyVo.speed, self._moveVo, pos.x, pos.y, function ( )
			--completed
			self:updateGrid()
			if func ~=nil  then
				func()
			end

			GridManager.updatePlayerState(self, self:getPosition())
			self:setCurrentEndPos(nil)

			if self:isInSelfUICenter() then
				self:setReturnBackPoint(self:getPosition())
			end

		end, function(x, y)
			--update
			self:updatePostion()
			if changeDir then
				self:updatePathDirection(pos.x, pos.y)
			else
				self:play(ActionUtil.Action_Walk)
			end
		end, 0)
	else
		print("hero locked:bigCategory:"..self.roleDyVo.bigCategory..",id="..self.roleDyVo.playerId)
	end
end

function HeroPlayer:setReturnBackPoint(point)
	-- body
	self._returnBackPoint = point
end

function HeroPlayer:checkReturnBackPoint()
	-- body
	if self._returnBackPoint then
		if not GridManager.isSelfUICenterValid(self, self._returnBackPoint) then
			self._returnBackPoint = GridManager.getSelfIdleUICenter(self, false)
		end
	else
		self._returnBackPoint = GridManager.getSelfIdleUICenter(self, false)
	end
end

function HeroPlayer:getReturnBackPoint()
	-- body 带检查
	self:checkReturnBackPoint()
	assert(self._returnBackPoint)
	return self._returnBackPoint
end

function HeroPlayer:isInAttackCD()
	-- body
	local currentTime = require 'FightTimer'.currentFightTimeMillis()
	local cd = self:getAtkCD()/self:getAtkSpdRate()

	if currentTime - self._preSkillTime >= cd then
		return  false
	end

	return true
end

function HeroPlayer:standToEnemy()
	-- body
	local enemy = self:getBasicAttackTarget()
	-- assert()
	if enemy then
		self:stopMove()
		local backStandDir = DirectionUtil.getDireciton(self:getMapX(), enemy:getMapX())
		self:play(ActionUtil.Action_Stand, backStandDir, true)
		return true
	end
end

function HeroPlayer:standToEnemyTeam()
	-- body
	self:stopMove()
	local backStandDir = RoleSelfManager.getPlayerBackStandDir(self)
	self:play(ActionUtil.Action_Stand, backStandDir, true)
	return true
end

function HeroPlayer:standFree()
	-- body
	self:stopMove()
	local backStandDir = nil
	self:play(ActionUtil.Action_Stand, backStandDir, true)
	return true
end

function HeroPlayer:setFightTimeOut( timeOut )
	-- body
	if self._currentFightTimeOut then
		self._currentFightTimeOut:dispose()
		self._currentFightTimeOut = nil
	end

	self._currentFightTimeOut = timeOut

	if self._currentFightTimeOut then
		self._currentFightTimeOut:start()
	end
end

-- 播放
function HeroPlayer:playNewFightInPVE( skillBasicVo, arr, isCrit )
	assert(skillBasicVo)
	assert(arr)
	-- assert(callbackdelay)

	local action = self:getActionBySkillVo(skillBasicVo, isCrit)
	local direction = -1

	if #arr > 0 then
		direction = DirectionUtil.getDireciton(self:getMapX(), arr[1]:getMapX())
		if arr[1].roleDyVo.dyId == self.roleDyVo.dyId then   --己方队伍 无需转身
			direction = -1
		end
	end

	--远程要注意攻击者的方向
	--攻击范围是矩形的要注意攻击者的方向
	if skillBasicVo.shapes == SkillUtil.Type_Line then
		direction = RoleSelfManager.getPlayerBackStandDir(self)
	end

	local isBigSkill = skillBasicVo.skilltype >= 10

	self:stopMove()

	local completeCallback = function ()
		--如果没死
		if RolePlayerManager.canFightPlayer(self) then
			self:play(ActionUtil.Action_Stand, direction)
		end
	end

	local forceCallback = function ()
		if RolePlayerManager.canFightPlayer(self) then
			if isBigSkill then
				self:unLockSkillAction()
			else
				self:unLockFight()
			end
		end
	end

	-- 战斗锁定
	if isBigSkill then
		self:setSkillActionLocked()

		-- print('playNewFightInPVE')
		-- print(skillBasicVo)
	else
		self:setFightLocked()
	end

	--处理冲锋 
	local forward = self:chargeForward(skillBasicVo, arr, direction)
	if forward then
		-- 
	end

	-- 毫秒
	local time = self:getAnimateTimeByNameMax(action, skillBasicVo)/1000
	-- if isBigSkill then
	-- 	print('')
	-- end

	self:play(action, direction, false, completeCallback, true, forceCallback, time)
	
	--播放攻击者特效?
	self:cleanAllAtkEffectViews()
	FightView.handleAtkByRoleAndSkill(self, arr, skillBasicVo.id, isCrit)
end

-- 
function HeroPlayer:noticeNewFight( skillBasicVo, playerArr, isCrit)
	if self:isDisposed() then
		return false
	end

	if not self:isDisposed() and self.roleDyVo.hpPercent>0 then

		-- self:cancelAttack()
		-- if not self:isTotalLocked() then
			local data = {}
			data.Hid = self.roleDyVo.playerId
			data.Sid = skillBasicVo.id
			data.Hids = {}

			for k,player in pairs(playerArr) do
				table.insert(data.Hids,player.roleDyVo.playerId)
			end

			data.IsCrit = isCrit
			data.ManaRate = require 'ServerAccess'.getManaRateById(self.roleDyVo.playerId)

			local effect_type
			if skillBasicVo.skilltype >= 10 then
				effect_type = CfgHelper.getCache('roleEffect', 'handbook', self.roleDyVo.basicId).effect_type
			else
				effect_type = skillBasicVo.effect_type
			end

			if effect_type == SkillUtil.fightType_2 then   ---远程  pve  发送子弹
				EventCenter.eventInput(FightEvent.Pve_CreateBullet, {skillBasicVo = skillBasicVo,player = self, isCrit = isCrit } )
			else--- 非子弹类型
				EventCenter.eventInput(FightEvent.C_Fight, data)
			end
		-- end
	end
end

function HeroPlayer:getAnimateTimeByNameMax( action,  skillBasicVo, isCrit)
	-- body
	assert(action)
	assert(skillBasicVo)

	local time = SpecailManager.getDelayTime(self, skillBasicVo.id, isCrit) or 0
	local animateTime = self:getAnimateTimeByName(action)

	local ret = math.max(animateTime, (1000*time)+300 )
	
	print(time)
	print(animateTime)
	print(string.format('time action = %s, %.2f', action, ret ))

	return ret
end

-- 主要是notice, protect
function HeroPlayer:beginToNoticeNewFight( skillBasicVo, arr, isCrit )
	-- body
	-- 近战
	assert(skillBasicVo)

	-- assert(not self:isSkillActionLocked()) 

	-- print('beginToNoticeNewFight')
	-- print(skillBasicVo)

	local isBigSkill = skillBasicVo.skilltype >= 10
	-- if isBigSkill then
	-- 	print('beginToNoticeNewFight')
	-- 	print(skillBasicVo)
	-- end

	-- miao
	local time = SpecailManager.getDelayTime(self, skillBasicVo.id, isCrit) or 0
	-- 比如攻击速度加快
	if not isBigSkill then
		time = time / self:getAtkSpdRate()
	end

	self:setFightTimeOut(nil)

	local timeOut = TimeOutManager.getTimeOut(time, function ()
		--普通攻击可能被打断, 大招不会被打断
		self:updateSkillTime(time*1000)  --更新职业的攻击频率
		self:noticeNewFight(skillBasicVo, arr, isCrit) --
	end)
	self:setFightTimeOut(timeOut)

	local action = self:getActionBySkillVo(skillBasicVo,isCrit)
	local animateTime = self:getAnimateTimeByNameMax(action, skillBasicVo, isCrit)
	assert(type(animateTime) == 'number', action)

	if not isBigSkill then
		animateTime = animateTime / self:getAtkSpdRate()
	end

	if 1000*time > animateTime then
		local info = string.format('延迟时间必须比动作时间更短: 动作=%s, id = %d, 伤害延迟=%.2f, 动作时间=%.2f ',
		tostring(action), self.roleDyVo.basicId, 1000*time, animateTime)

		assert(false, info)
	end
	
	--发送大招保护指令
	if isBigSkill then
		local action = self:getActionBySkillVo(skillBasicVo,isCrit)

		local data = {}
		data.Hid = self.roleDyVo.playerId 
		-- 毫秒
		data.Dur = self:getAnimateTimeByNameMax(action, skillBasicVo) 
		EventCenter.eventInput(FightEvent.Pve_Protect, data) 

	end

	return true
end

-- 取消普通攻击
function HeroPlayer:cancelAttack()
	-- body
	if not self:isSkillActionLocked() then
		if self:isFightLocked() then
			self:unLockFight()
			self:setFightTimeOut(nil)
			-- 攻击者特效取消
			self:cleanAllAtkEffectViews()
			self:standFree()
			return true
		end
	end
end

function HeroPlayer:countBasicAttackTimes()
	-- body
	self._basicAttackTimes = self._basicAttackTimes or 0
	self._basicAttackTimes = self._basicAttackTimes + 1
end

function HeroPlayer:getBasicAttackTimes()
	-- body
	self._basicAttackTimes = self._basicAttackTimes or 0
	return self._basicAttackTimes
end

function HeroPlayer:startToBasicAttack()
	-- body
	local enemy = self:getBasicAttackTarget()
	if enemy then
		-- 播放
		-- self:standToEnemy()
		-- --计算是否暴击
		-- --播放人物动作
		-- 一定延迟后发起攻击协议(打出飞行道具)=
		if self:isBlind() then
			return self:standFree()
		end

		if self:isSkillActionLocked() then
			return self:standFree()
		end

		-- 
		self:countBasicAttackTimes()

		local skillBasicVo = self:getBasicSkillVo()
		local arr = RolePlayerManager.getTargetArrayByPlayerAndSkill(self, skillBasicVo, enemy)
		local isCrit = SpecailManager.getCritHappened(skillBasicVo.id, self)    --是否暴击
		
		self:beginToNoticeNewFight(skillBasicVo, arr, isCrit) 
		self:playNewFightInPVE(skillBasicVo, arr, isCrit)  --锁定

		return true
	end
end

function HeroPlayer:countLongRangeAttackTimes()
	-- body
	self._longRangeAttackTimes = self._longRangeAttackTimes or 0
	self._longRangeAttackTimes = self._longRangeAttackTimes + 1
end

function HeroPlayer:getLongRangeAttackTimes()
	-- body
	self._longRangeAttackTimes = self._longRangeAttackTimes or 0
	return self._longRangeAttackTimes
end

function HeroPlayer:startToLongRangeAttack()
	-- body
	if self:isSkillActionLocked() then
		return self:standFree()
	end

	if self:isBlind() then
		return self:standFree()
	end

	self:countLongRangeAttackTimes()

	local skillBasicVo = self:getAdvancedSkillVo()
	local arr = RolePlayerManager.getTargetArrayByPlayerAndSkill(self, skillBasicVo, nil)
	local isCrit = SpecailManager.getCritHappened(skillBasicVo.id, self)    --是否暴击
	
	self:beginToNoticeNewFight(skillBasicVo, arr, isCrit)
	self:playNewFightInPVE(skillBasicVo, arr, isCrit)

	return true
end

function HeroPlayer:countBasicCureTimes()
	-- body
	self._basicCureTimes = self._basicCureTimes or 0
	self._basicCureTimes = self._basicCureTimes + 1
end

function HeroPlayer:getBasicCureTimes()
	-- body
	self._basicCureTimes = self._basicCureTimes or 0
	return self._basicCureTimes
end

function HeroPlayer:startToCure()
	-- body
	local skillBasicVo = self:getAdvancedSkillVo()
	local arr = RolePlayerManager.getTargetArrayByPlayerAndSkill(self, skillBasicVo, nil)

	if #arr <= 0 then
		return false
	end

	if self:isSkillActionLocked() then
		return self:standFree()
	end

	self:standToEnemyTeam()

	self:countBasicCureTimes()

	local isCrit = false
	
	self:beginToNoticeNewFight(skillBasicVo, arr, isCrit)
	self:playNewFightInPVE(skillBasicVo, arr, isCrit)

	return true
end

function HeroPlayer:countBigSkillTimes()
	-- body
	self._bigSkillTimes = self._bigSkillTimes or 0
	self._bigSkillTimes = self._bigSkillTimes + 1
end

function HeroPlayer:getBigSkillTimes()
	-- body
	self._bigSkillTimes = self._bigSkillTimes or 0
	return self._bigSkillTimes
end

function HeroPlayer:showBossBigSkillWarnings()
	-- body
end


function HeroPlayer:initBossBigSkillWarnings()
	-- body
	if self:isMonsterBoss() then

		local skillBasicVo = self:getBigSkillVo()
		assert(skillBasicVo)

		local range = self:getRange( skillBasicVo )
		EventCenter.eventInput(FightEvent.Pve_BigSkill_Warning_Init, {range = range, shapes = skillBasicVo.shapes} )

	end
end

function HeroPlayer:onSetClothPos( x, y )
	-- body
	if self:isMonsterBoss() then
		local data = {}
		data.pos = {x=x, y=y}

		EventCenter.eventInput(FightEvent.Pve_BigSkill_Warning_Pos, data )
	end
end

function HeroPlayer:onSetDirection( dir )
	-- body
	if self:isMonsterBoss() then
		local data = {}
		data.dir = dir

		EventCenter.eventInput(FightEvent.Pve_BigSkill_Warning_Dir, data )
	end
end


function HeroPlayer:startToBigSkill( force )
	-- body
	-- 冰冻不适放
	if not force and self:isFrozen() then
		return false
	end

	self:countBigSkillTimes()

	local skillBasicVo = self:getBigSkillVo()
	local arr = RolePlayerManager.getTargetArrayByPlayerAndSkill(self, skillBasicVo, self:getBasicAttackTarget())
	local isCrit = false
	
	self:beginToNoticeNewFight(skillBasicVo, arr, isCrit)
	self:playNewFightInPVE(skillBasicVo, arr, isCrit)

	return true
end


function HeroPlayer:iteratorEnemyTeam( func )
	-- body
	local playerMap = RolePlayerManager.getPlayerMapSorted()
	for playerId, player in ipairs(playerMap) do
		if not player:isDisposed() and player:isBodyVisible() then
			if player.roleDyVo.dyId ~= self.roleDyVo.dyId then
				local ret = func( player )
				if ret then
					return ret
				end
			end
		end
	end
end

function HeroPlayer:iteratorSelfTeam( func )
	-- body
	local playerMap = RolePlayerManager.getPlayerMapSorted()
	for playerId, player in ipairs(playerMap) do
		if not player:isDisposed() and player:isBodyVisible() then
			if player.roleDyVo.dyId == self.roleDyVo.dyId then
				local ret = func( player )
				if ret then
					return ret
				end
			end
		end
	end
end

--[[
lastEnemy
judgeFuc
--]]
function HeroPlayer:searchEnemy( lastEnemy, judgeFuc )
	-- body
	assert(judgeFuc)

	-- quick judge
	if lastEnemy then
		if not lastEnemy:isDisposed() and lastEnemy:isBodyVisible() then
			if judgeFuc(lastEnemy) then
				return lastEnemy
			end
		end
	end

	local retEnemy
	local itFunc = function ( enemy )
		-- body
		-- 符合条件
		if judgeFuc(enemy) then
			-- if enemy == lastEnemy then
			-- 	retEnemy = enemy
			-- 	return retEnemy
			-- else
				if retEnemy then
					if YFMath.quick_distance2(self, enemy) < YFMath.quick_distance2(self, retEnemy) then
						retEnemy = enemy
					end
				else
					retEnemy = enemy
				end
			-- end
		end
	end

	self:iteratorEnemyTeam( itFunc )

	return retEnemy
end

-- 
function HeroPlayer:findEnemyInBlockArea( extraJudge )
	-- body
	local lastEnmey = self:getBasicAttackTarget()

	local endPoint = self:getCurrentEndPos()
	local selfPos = self:getPosition()

	local nearestEnemy 

	local blockDis
	if require 'ServerRecord'.isArenaMode() then
		blockDis = Hero_Block_Dis_Arr[self:getCareer()]
	else
		blockDis = (self:isMonster() and Monster_Block_Dis) or Hero_Block_Dis_Arr[self:getCareer()]
	end

	-- local outerPoint = self:getOuterPoint()

	if self:hasOuterCommand() and (not self:getMoveBackEnable()) and endPoint and self:isMove() and not self:isMonster() then
		-- 扫描60度范围内的敌人
		-- radius?
		-- angle = 60
		local radiusX = GridManager.getUIGridWidth() 	* blockDis
		local radiusY = GridManager.getUIGridHeight() 	* blockDis
		
		-- lastEnemy, judgeFunc
		nearestEnemy = self:searchEnemy(lastEnmey, function ( enemy )
			-- body
			if extraJudge and not extraJudge(enemy) then
				return nil
			end

			local testPos = enemy:getPosition()
			
			local ret = YFMath.isInFanShaped(selfPos, endPoint, testPos, radiusX, radiusY, Move_Block_Angle)
			return ret
		end)

	else
		-- 扫描360度范围内的敌人
		local width = GridManager.getUIGridWidth() 		* blockDis
		local height = GridManager.getUIGridHeight() 	* blockDis

		nearestEnemy = self:searchEnemy(lastEnmey, function ( enemy )
			-- body
			if extraJudge and not extraJudge(enemy) then
				return nil
			end

			local testPos = enemy:getPosition()
			local ret = YFMath.isInOvel(selfPos, testPos, width, height)
			return ret
		end)
	end

	if nearestEnemy then
		self:setBasicAttackTarget(nearestEnemy)
		return nearestEnemy
	end
end

-- 登入战场
function HeroPlayer:goToBattleField()
	-- body

	local pos = GridManager.getSelfIdleUICenter(self, true)
	
	local isOtherPlayer = self:isOtherPlayer()

	local selfPos = { 
		x = pos.x,
		y = pos.y,
	}

	if isOtherPlayer then
		selfPos.x = selfPos.x - GridManager.getUIGridWidth() * 3.5
	else
		selfPos.x = selfPos.x + GridManager.getUIGridWidth() * 3.5
	end

	self:setPosition(selfPos.x, selfPos.y)

	self:runWithDelay(function ()
		-- body
		self:moveToNewPos(pos, function ()
			-- body
			self:standToEnemyTeam()
			self:startAI()
		end)
	end, 0.1)

	self:runWithDelay(function ()
		-- body
		self:startAI()
	end, 3)

	return true
end

--
function HeroPlayer:runBasicAttack()
	-- body
	local target = self:getBasicAttackTarget()
	if target then

		if self:isPosSuitableForBasicAttack() then
			if self:isInAttackCD() then
				-- print('近战 处于CD')
				return self:standToEnemy()
			else
				-- print('近战 开始攻击')
				return self:startToBasicAttack()
			end
		else
			local pos = self:findPosSuitableForBasicAttack( true )

			if pos then
				-- print('近战 向目标移动')
				self:moveToNewPos(pos, function ()
					-- body
					self:standToEnemy()
				end)
				return true
			else
				-- assert(false, '为什么没有合适的攻击位置????')
				print('为什么没有合适的攻击位置???? %d', self.roleDyVo.playerId)
				debug.catch(true)
			end
		end
	else
		print('为什么没有合适的攻击对象???? %d', self.roleDyVo.playerId)
		debug.catch(true)
	end
end

-- 
function HeroPlayer:findEnemyInBasicCheckArea()
	-- body
	-- 扫描360度范围内的敌人
	local lastEnmey = self:getBasicAttackTarget()
	local selfPos = self:getPosition()

	local width = GridManager.getUIGridWidth() * 1 --???????
	local height = GridManager.getUIGridHeight() * 1 --???????

	local nearestEnemy = self:searchEnemy(lastEnmey, function ( enemy )
		-- body
		local testPos = enemy:getPosition()
		local ret = YFMath.isInOvel(selfPos, testPos, width, height)
		return ret
	end)

	if nearestEnemy then
		self:setBasicAttackTarget(nearestEnemy)
		return nearestEnemy
	end
end

function HeroPlayer:isAutoAiOpened()
	-- body
	return self:getAuto()
end

function HeroPlayer:findEnemyInAutoBasicCheckArea()
	-- body
	assert(self:isCareerJinZhan())
	if self:isAutoAiOpened() then
		local lastEnmey = self:getBasicAttackTarget()
		local nearestEnemy = self:searchEnemy(lastEnmey, function ( enemy )
			-- body
			return true
		end) 

		if nearestEnemy then
			self:setBasicAttackTarget(nearestEnemy)
			return nearestEnemy
		else
			-- assert(false)
			-- print(string.format('Id=%d, 找不到自动近战目标', self.roleDyVo.playerId))
		end
	end
end

function HeroPlayer:isInSelfUICenter()
	-- body 
	return GridManager.isInSelfUICenter(self)
end

function HeroPlayer:isInUICenter()
	-- body
	return GridManager.isInUICenter(self)
end

function HeroPlayer:isPosSuitableForBasicAttack(pos)
	-- body
	local enemy = self:getBasicAttackTarget()
	if enemy then
		pos = pos or self:getPosition()

		local width
		local height
		local width2
		local height2

		if self:isMove() then
			-- 运动的条件下, 严格
			width = Basic_Atk_Move_Dis_Max * GridManager.getUIGridWidth()
			height = Basic_Atk_Move_Dis_Max * GridManager.getUIGridHeight()

			width2 = Basic_Atk_Move_Dis_Min * GridManager.getUIGridWidth()
			height2 = Basic_Atk_Move_Dis_Min * GridManager.getUIGridHeight()
		else
			-- 静止的条件下, 宽松
			width = Basic_Atk_Dis_Max * GridManager.getUIGridWidth()
			height = Basic_Atk_Dis_Max * GridManager.getUIGridHeight()

			width2 = Basic_Atk_Dis_Min * GridManager.getUIGridWidth()
			height2 = Basic_Atk_Dis_Min * GridManager.getUIGridHeight()
		end

		
		local isInCircle = YFMath.isInOvel(enemy:getPosition(), pos, width, height )
		local isOutInnerCircle = not YFMath.isInOvel(enemy:getPosition(), pos, width2, height2 )

		if isInCircle and isOutInnerCircle then
			local conflict = false

			local conflictWidth 	= Min_Friend_Dis * GridManager.getUIGridWidth()
			local conflictHeight 	= Min_Friend_Dis * GridManager.getUIGridHeight()

			self:iteratorSelfTeam(function ( friend )
				-- body
				if friend ~= self then
					if not friend:isMove() then
						if not conflict then
							conflict = YFMath.isInOvel(friend:getPosition(), pos, conflictWidth, conflictHeight)
							return conflict
						end
					end
				end
			end)

			return not conflict
		end

	end
end

function HeroPlayer:setMoveBackEnable( enable )
	-- body
	self._moveBackEnable = enable
end

function HeroPlayer:getMoveBackEnable()
	-- body
	return self._moveBackEnable
end

function HeroPlayer:findPosSuitableForBasicAttack( findNew )
	-- body
	local enemy = self:getBasicAttackTarget()

	if enemy then
		local enemyPos = enemy:getPosition()
		local pos = self:getCurrentEndPos()

		if pos then
			if self:isPosSuitableForBasicAttack(pos) then
				return pos
			else 
				pos = nil
			end
		end

		if not pos then

			local selfPos = self:getPosition()

			-- 寻找最近的点
			local radiusX = Basic_Atk_Dis * GridManager.getUIGridWidth()
			local radiusY = Basic_Atk_Dis * GridManager.getUIGridHeight()

			-- 扩大还是缩小?
			if YFMath.isInOvel(selfPos, enemyPos, radiusX, radiusY) then
				self:setMoveBackEnable(true)
			else
				self:setMoveBackEnable(false)
			end

			local div = 24
			local step = 2*math.pi/div

			
			local minPos
			local midDis 

			for i=1, div do
				local testArc = i*step
				local testPos = { x=enemyPos.x+math.cos(testArc)*radiusX, y=enemyPos.y+math.sin(testArc)*radiusY }
				if GridManager.isPosInBattleField(testPos) and self:isPosSuitableForBasicAttack(testPos) then
					if not minPos then
						minPos = testPos
						minDis = YFMath.quick_distance(selfPos.x, selfPos.y, minPos.x, minPos.y)
					else
						local testDis = YFMath.quick_distance(selfPos.x, selfPos.y, testPos.x, testPos.y)
						if testDis < minDis then
							minPos = testPos
							minDis = testDis
						end
					end
				end
			end

			pos = minPos

		end

		if pos then
			return pos
		else
			-- assert(false, '为什么没有找到合适的占位!')
			print('为什么没有找到合适的占位!')
		end
	end
end

function HeroPlayer:runReturnBack()
	-- body
	local returnPos = self:getReturnBackPoint()
	if returnPos then

		-- self:setInnerCommand
		-- if self.roleDyVo.playerId == 7 then
		-- 	print('Id=7, returnPos:'..returnPos.x..','..returnPos.y)
		-- end

		self:moveToNewPos(returnPos, function ()
			-- body
			self:standToEnemyTeam()
		end)
		return true
	else
		assert(false, '为什么会没有返回点?')
	end
end


-------------------------远程及其自动AI-------------------------
function HeroPlayer:runLongRangeAttack(  )
	-- body
	assert(self:isCareerYuanCheng())
	if self:isInSelfUICenter() then
		if self:isEnemyInSelfLineForShoot() then
			if self:isInAttackCD() then
				return self:standToEnemyTeam()
			else
				return self:startToLongRangeAttack()
			end
		end
	end
end

-- 
function HeroPlayer:isEnemyInSelfLineForShoot(selfPos)
	-- body
	selfPos = selfPos or self:getPosition()
	local selfI, selfJ = GridManager.getIJByPos(selfPos)
	-- if selfJ >=-1 and selfJ <= 1 then
	local isOtherPlayer = self:isOtherPlayer()

	return self:iteratorEnemyTeam(function ( enemy )
		-- body
		local enemyPos = enemy:getPosition()
		local enemyI, enemyJ = GridManager.getIJByPos(enemyPos)
		if enemyJ == selfJ then
			if (isOtherPlayer and selfPos.x<enemyPos.x ) or (not isOtherPlayer and selfPos.x>enemyPos.x ) then
				return true
			end
		end
	end)
end

function HeroPlayer:findEnemyInTeamCamp()
	-- body
	local lastEnmey = self:getBasicAttackTarget()
	local nearestEnemy = self:searchEnemy(lastEnmey, function ( enemy )
		-- body
		local isOtherPlayer = enemy:isOtherPlayer() or enemy:isMonster()

		if GridManager.isInEnemyCampByPos(enemy:getPosition(),isOtherPlayer) then
			if enemy:isMove() and (enemy:getBasicAttackerCount() == 0 or (lastEnmey == enemy)) then 
				return true
			end
		end
	end)
	return nearestEnemy
end


function HeroPlayer:runAutoLongRangeAttack1()
	-- body
	assert(self:isCareerYuanCheng())

	if self:isAutoAiOpened() then
		local enemy = self:findEnemyInTeamCamp()
		if enemy then
			self:setBasicAttackTarget(enemy)
			return self:runBasicAttack()
		end
	end
end

function HeroPlayer:runAutoLongRangeAttack2()
	-- body
	assert(self:isCareerYuanCheng())

	if self:isAutoAiOpened() then
		local uiPos = self:findPosForShootEnemyInOtherLine()
		if uiPos then
			print('远程自动AI UI pos='..uiPos.x..','..uiPos.y)
			assert( GridManager.isInSelfCampByPos(uiPos, self:isOtherPlayer()) )
		end

		if uiPos then
			self:moveToNewPos(uiPos, function ()
				-- body
				self:standToEnemyTeam()
			end)
			return true
		end
	end
end

-- 上一次的UIPos
function HeroPlayer:findPosForShootEnemyInOtherLine()
	-- body
	local selfPos = self:getPosition()
	local selfI, selfJ = GridManager.getIJByPos(selfPos)
	if selfJ >= -1 and selfJ <= 1 then
		local isOtherPlayer = self:isOtherPlayer()

		local uiPosArray = GridManager.getSelfIdleUICenterArraySorted(self)

		local oldUiPos = self:getCurrentEndPos()
		if oldUiPos then
			if uiPosArray and #uiPosArray > 0 then
				for i, testUiPos in ipairs(uiPosArray) do
					if testUiPos.x == oldUiPos.x and testUiPos.y == oldUiPos.y then
						if self:isEnemyInSelfLineForShoot(oldUiPos) then
							return oldUiPos
						end
					end
				end
			end
		end

		if uiPosArray and #uiPosArray > 0 then
			for i, uiPos in ipairs(uiPosArray) do
				if self:isEnemyInSelfLineForShoot(uiPos) then
					return uiPos
				end
			end
		end
	end
end

-- function HeroPlayer:findPosForShootEnemyInSelfLine()
-- 	-- body
-- 	local selfPos = self:getPosition()
-- 	local selfI, selfJ = GridManager.getIJByPos(selfPos)
-- 	if selfJ >= -1 and selfJ <= 1 then
-- 		local isOtherPlayer = self:isOtherPlayer()

-- 		local uiPosArray = GridManager.getSelfIdleUICenterArraySorted(self)

-- 		local oldUiPos = self:getCurrentEndPos()
-- 		if oldUiPos then
-- 			if uiPosArray and #uiPosArray > 0 then
-- 				for i, testUiPos in ipairs(uiPosArray) do
-- 					if testUiPos.x == oldUiPos.x and testUiPos.y == oldUiPos.y then
-- 						if self:isEnemyInSelfLineForShoot(oldUiPos) then
-- 							return oldUiPos
-- 						end
-- 					end
-- 				end
-- 			end
-- 		end

-- 		if uiPosArray and #uiPosArray > 0 then
-- 			for i, uiPos in ipairs(uiPosArray) do
-- 				if self:isEnemyInSelfLineForShoot(uiPos) then
-- 					return uiPos
-- 				end
-- 			end
-- 		end
-- 	end
-- end

function HeroPlayer:findMonsterPosForShootEnemyInOtherLine()
	-- body
	local selfPos = self:getPosition()
	local selfI, selfJ = GridManager.getIJByPos(selfPos)
	local isOtherPlayer = self:isOtherPlayer()

	local uiPosArray = GridManager.getMonsterIdleUICenterArraySorted(self)

	-- local oldUiPos = self:getCurrentEndPos()

	-- if oldUiPos then
	-- 	if uiPosArray and #uiPosArray > 0 then
	-- 		for i, testUiPos in ipairs(uiPosArray) do
	-- 			if testUiPos.x == oldUiPos.x and testUiPos.y == oldUiPos.y then
	-- 				if self:isEnemyInSelfLineForShoot(oldUiPos) then
	-- 					return oldUiPos
	-- 				end
	-- 			end
	-- 		end
	-- 	end
	-- end

	if uiPosArray and #uiPosArray > 0 then
		for i, uiPos in ipairs(uiPosArray) do
			if self:isEnemyInSelfLineForShoot(uiPos) then
				return uiPos
			end
		end
	end
end

-------------------------治疗及其自动AI-------------------------
function HeroPlayer:getCureRange()
	-- body
	assert(self:isCareerZiLiao())

	local skillVo = self:getAdvancedSkillVo()

	if self.roleDyVo.isHealLarger then
		local serverRole = require 'ServerController'.findRoleByDyIdAnyway(self.roleDyVo.playerId)
		if serverRole then
			local buffArray = serverRole:getBuffArray()
			local larger = buffArray:getValueByKey( require 'GHType'.GH_HealLarger ) or 0 
			larger = larger + (buffArray:getValueByKey(GHType.GH_95) or 0)
			
			local range = {}
			range[1] = skillVo.range[1] + larger
			range[2] = skillVo.range[2] + larger

			print('更大的治疗的大小:'..range[1]..','..range[2])

			return range
		end
	end
	return skillVo.range
end

function HeroPlayer:isFriendInCircleForCure( extraJudge, defaultPos )
	-- body
	local cureRange = self:getCureRange()
	local selfPos = defaultPos or self:getPosition()

	return self:iteratorSelfTeam(function ( friend )
		-- body
		if extraJudge and not extraJudge(friend) then
			return false
		end

		if friend.roleDyVo.hpPercent < 100 then
			local friendPos = friend:getPosition()
			if YFMath.isInOvel(selfPos, friendPos, cureRange[1]*GridManager.getUIGridWidth(), cureRange[2]*GridManager.getUIGridHeight()) then
				return true
			end
		end
	end)
end

function HeroPlayer:countFriendInCircleForCure( defaultPos )
	-- body
	local cureRange = self:getCureRange()
	local selfPos = defaultPos or self:getPosition()

	local count = 0

	self:iteratorSelfTeam(function ( friend )
		-- body

		if friend.roleDyVo.playerId ~= self.roleDyVo.playerId and friend.roleDyVo.hpPercent < 100 then
			local friendPos = friend:getPosition()
			if YFMath.isInOvel(selfPos, friendPos, cureRange[1]*GridManager.getUIGridWidth(), cureRange[2]*GridManager.getUIGridHeight()) then
				count = count + 1
			end
		end
	end)

	if count > 0 then
		print('countFriendInCircleForCure')
		print(count)
	end

	return count
end

function HeroPlayer:runBasicCure()
	-- body
	assert(self:isCareerZiLiao())
	if self:isInSelfUICenter() then
		if self:isFriendInCircleForCure() then
			if self:isInAttackCD() then
				return self:standToEnemyTeam()
			else
				return self:startToCure()
			end
		end
	end
end

function HeroPlayer:runBasicJinZhan()
	-- body
	assert(self:isCareerJinZhan())
	local enemy = self:findEnemyInBasicCheckArea()
	if enemy then
		self:setBasicAttackTarget(enemy)
		return self:runBasicAttack()
	end
end

function HeroPlayer:runAutoCure()
	-- body
	assert(self:isCareerZiLiao())
	if self:isAutoAiOpened() then
		if not self:hasYuanChengIdle() then
			local enemy = self:findEnemyInTeamCamp()
			if enemy then
				self:setBasicAttackTarget(enemy)
				return self:runBasicAttack()
			end
		end
	end
end

function HeroPlayer:runAutoJinZhan()
	-- body
	assert(self:isCareerJinZhan())
	local enemy = self:findEnemyInAutoBasicCheckArea()
	if enemy then
		self:setBasicAttackTarget(enemy)
		return self:runBasicAttack()
	end
end




----------Condition----------
--[[
1.近战检测范围内有敌人
2.远程检测范围内有敌人
3.治疗检测范围内有友军需要加血
4.检测站位是否合适
5.是否有手指指令
6.是否有内部指令
7.回到自己的占位
8.是否处在战斗CD中 ? 要单独区分近战,远程,治疗么?
9.是否在己方阵营?
10.是否在己方有效位置?
11.是否有治疗以外职业的队友,处在我的治疗范围内
12.是否处在安全区
13.我所在的行是否有敌人可以远程攻击
14.其他行是否有敌人可以远程攻击
15.是否出来自动AI状态
15.
--]]

----------Action----------
--[[
1.什么都不做
2.待机
3.攻击前站位调整
4.发起近战攻击
5.发起远程攻击
6.发起治疗
7.发起大招
8.向目标移动
9.占位分散,  如果
10.
--]]

function HeroPlayer:hasYuanChengIdle()
	-- body
	return self:iteratorSelfTeam(function ( friend )
		-- body
		-- 不在战斗中, 
		if friend:isCareerYuanCheng() and (not friend:isMove()) and friend:isInSelfUICenter() and friend:isAiUnlocked() then
			return friend
		end
	end)
end


-- 黑板
function HeroPlayer:setBlackboard()
	-- body
end

-- used by ziliao
-- function HeroPlayer:findMovingEnemyInBlockArea()
-- 	-- body
-- 	local lastEnmey = self:getBasicAttackTarget()

-- 	local endPoint = self:getCurrentEndPos()
-- 	local selfPos = self:getPosition()

-- 	local nearestEnemy 

-- 	local blockDis = (self:isMonster() and Monster_Block_Dis) or Hero_Block_Dis_Arr[self:getCareer()]

-- 	if self:hasOuterCommand() and endPoint and self:isMove() and not self:isMonster() then
-- 		-- 扫描60度范围内的敌人
-- 		-- radius?
-- 		-- angle = 60
-- 		local radiusX = GridManager.getUIGridWidth() 	* blockDis
-- 		local radiusY = GridManager.getUIGridHeight() 	* blockDis

-- 		-- lastEnemy, judgeFunc
-- 		nearestEnemy = self:searchEnemy(lastEnmey, function ( enemy )
-- 			-- body
-- 			local testPos = enemy:getPosition()
-- 			local ret = YFMath.isInFanShaped(selfPos, endPoint, testPos, radiusX, radiusY, Move_Block_Angle)
-- 			return ret
-- 		end)

-- 	else
-- 		-- 扫描360度范围内的敌人
-- 		local width = GridManager.getUIGridWidth() 		* blockDis
-- 		local height = GridManager.getUIGridHeight() 	* blockDis

-- 		nearestEnemy = self:searchEnemy(lastEnmey, function ( enemy )
-- 			-- body
-- 			local testPos = enemy:getPosition()
-- 			local ret = YFMath.isInOvel(selfPos, testPos, width, height)
-- 			return ret
-- 		end)
-- 	end

-- 	if nearestEnemy then
-- 		self:setBasicAttackTarget(nearestEnemy)
-- 		return nearestEnemy
-- 	end
-- end

function HeroPlayer:findFrontPosForCure()
	-- body
	if self:isCareerZiLiao() then
		local posArr = require 'GridManager'.getSelfFrontIdleUICenterArraySorted( self )

		if #posArr > 0 then

			local maxCount = 0
			local retPos = nil

			for i, pos in ipairs(posArr) do
				local count = self:countFriendInCircleForCure(pos)
				if count > maxCount then
					maxCount = count
					retPos = pos
				end
			end

			return retPos
		end
	end
end

function HeroPlayer:runGoToFrontForCure()
	-- body
	if self:isCareerZiLiao() then
		local pos = self:findFrontPosForCure()
		if pos then
			self:moveToNewPos(pos, function ()
				-- body
				self:standToEnemyTeam()
			end)
			return true
		end
	end
end

function HeroPlayer:runHeroZiLiaoAI()
	-- body
	if self:isCareerZiLiao() then

		-- 处理拦截
		do
			local enemy = self:findEnemyInBlockArea()
			if enemy then
				self:setBasicAttackTarget(enemy)
				local ret = self:runBasicAttack()
				if ret then 
					print(string.format('Id=%d, 处理移动拦截!', self.roleDyVo.playerId))
					return true 
				end
			end
		end


		-- 处理外部指令
		do
			local ret = self:executeOuterCommand()
			if ret then 
				print(string.format('Id=%d, 处理外部指令!', self.roleDyVo.playerId))
				return true 
			end
		end

		-- 处理内部指令
		do
			local ret = self:executeInnerCommand()
			if ret then 
				print(string.format('Id=%d, 处理内部指令!', self.roleDyVo.playerId))
				return true 
			end
		end

		-- 处理自动拦截
		do
			if self:isAutoAiOpened() then
				if not self:hasYuanChengIdle() then
					local enemy = self:findEnemyInTeamCamp()
					if enemy then
						self:setBasicAttackTarget(enemy)
						return self:runBasicAttack()
					end
				end
			end
		end

		-- 处理治疗
		do
			if self:isInSelfUICenter() then
				local ret = self:isFriendInCircleForCure()

				if ret then
					if self:isInAttackCD() then
						return self:standToEnemyTeam()
					else
						return self:startToCure()
					end
				end
			end
		end

		-- 处理主动靠前 进而进行治疗
		do
			if self:isAutoAiOpened() then
				-- 1.find pos idle
				-- 2.find most cureable pos
				local ret = self:runGoToFrontForCure()
				if ret then
					print(string.format('Id=%d, 处理治疗向前!', self.roleDyVo.playerId))
					return true 
				end
			end
		end

		-- 处理待机
		do
			if self:isInSelfUICenter() then
				local ret = self:standToEnemyTeam()
				if ret then 
					print(string.format('Id=%d, 处理待机!', self.roleDyVo.playerId))
					return true 
				end
			end
		end

		-- 处理回归位置
		do
			if not self:isInSelfUICenter() then
				local ret = self:runReturnBack()
				if ret then 
					print(string.format('Id=%d, 处理回归位置!', self.roleDyVo.playerId))
					return true 
				end
			end
		end

		print(string.format('Id=%d, 为什么我什么都不用做!', self.roleDyVo.playerId))
	end
end


function HeroPlayer:runHeroYuanChengAI()
	-- body
	if self:isCareerYuanCheng() then

		-- 处理拦截
		do
			local enemy = self:findEnemyInBlockArea()
			if enemy then
				self:setBasicAttackTarget(enemy)

				local ret = self:runBasicAttack()
				if ret then 
					print(string.format('Id=%d, 处理拦截!', self.roleDyVo.playerId))
					return true 
				end
			end
		end

		-- 处理外部指令
		do
			local ret = self:executeOuterCommand()
			if ret then 
				print(string.format('Id=%d, 处理外部指令!', self.roleDyVo.playerId))
				return true 
			end
		end

		-- 处理内部指令
		do
			local ret = self:executeInnerCommand()
			if ret then 
				print(string.format('Id=%d, 处理内部指令!', self.roleDyVo.playerId))
				return true 
			end
		end

		-- 处理远程自动 AI
		do
			local ret = self:runAutoLongRangeAttack1()
			if ret then 
				print(string.format('Id=%d, 处理远程自动1 AI!', self.roleDyVo.playerId))
				return true 
			end
		end

		-- 处理远程攻击
		do
			local ret = self:runLongRangeAttack()
			if ret then 
				print(string.format('Id=%d, 处理远程攻击!', self.roleDyVo.playerId))
				return true 
			end
		end

		-- 处理远程自动 AI
		do
			local ret = self:runAutoLongRangeAttack2()
			if ret then 
				print(string.format('Id=%d, 处理远程自动2 AI!', self.roleDyVo.playerId))
				return true 
			end
		end

		-- 处理待机
		do
			if self:isInSelfUICenter() then
				local ret = self:standToEnemyTeam()
				if ret then 
					print(string.format('Id=%d, 处理待机!', self.roleDyVo.playerId))
					return true 
				end
			end
		end

		-- 处理回归位置
		do
			if not self:isInSelfUICenter() then
				local ret = self:runReturnBack()
				if ret then 
					print(string.format('Id=%d, 处理回归位置!', self.roleDyVo.playerId))
					return true 
				end
			end
		end

		print(string.format('Id=%d, 为什么我什么都不用做!', self.roleDyVo.playerId))

	end
end


function HeroPlayer:runHeroJinZhanAI()
	-- body
	if self:isCareerJinZhan() then

		-- 处理拦截
		do
			local enemy = self:findEnemyInBlockArea()
			if enemy then
				self:setBasicAttackTarget(enemy)

				local ret = self:runBasicAttack()
				if ret then 
					print(string.format('Id=%d, 处理拦截!', self.roleDyVo.playerId))
					return true 
				end
			end
		end

		-- 处理外部指令
		do
			local ret = self:executeOuterCommand()
			if ret then 
				print(string.format('Id=%d, 处理外部指令!', self.roleDyVo.playerId))
				return true 
			end
		end

		-- 处理内部指令
		do
			local ret = self:executeInnerCommand()
			if ret then 
				print(string.format('Id=%d, 处理内部指令!', self.roleDyVo.playerId))
				return true 
			end
		end

		-- 处理近战检测范围内的敌人
		do
			local ret = self:runBasicJinZhan()
			if ret then 
				print(string.format('Id=%d, 处理近战攻击!', self.roleDyVo.playerId))
				return true 
			end
		end

		-- 处理近战特自动AI
		do
			local ret = self:runAutoJinZhan()
			if ret then 
				print(string.format('Id=%d, 处理近战特自动AI!', self.roleDyVo.playerId))
				return true 
			end
		end

		-- 处理待机
		do
			if self:isInSelfUICenter() then
				local ret = self:standToEnemyTeam()
				if ret then 
					print(string.format('Id=%d, 处理待机!', self.roleDyVo.playerId))
					return true 
				end
			end
		end

		-- 处理回归位置
		do
			if not self:isInSelfUICenter() then
				local ret = self:runReturnBack()
				if ret then 
					print(string.format('Id=%d, 处理回归位置!', self.roleDyVo.playerId))
					return true 
				end
			end
		end

		print(string.format('Id=%d, 为什么我什么都不用做!', self.roleDyVo.playerId))

	end
end


function HeroPlayer:runHeroAILoop()
	-- body
	if self:isAiUnlocked() then
		
		self:runHeroJinZhanAI()
		
		self:runHeroYuanChengAI()

		self:runHeroZiLiaoAI()
		
	end
end

-- 怪物AI特有
--[[
检查怪物是否到边线
--]]
function HeroPlayer:checkMonsterReachDeadLine()
	-- body
	if self:isMonster() then
		local selfPos = self:getPosition()
		if selfPos.x >= GridManager.getMonsterDeadLine() then
			print('怪物到达警戒线结束战斗:'..self.roleDyVo.playerId.."basicId"..self.roleDyVo.basicId.."speed="..self.roleDyVo.speed)
			EventCenter.eventInput(FightEvent.PVEFinish, false)
			return true
		end
	end
end

-- function HeroPlayer:startToMonsterBigSkill()
-- 	-- body
-- end

function HeroPlayer:runMonsterBigSkill()
	-- body
	if require 'ServerRecord'.isEnemyBigSkillEnabled() then
		
		return self:runChampionMonsterBigSkill()

	elseif self:isMonsterBoss() then

		local skillCD = self.roleDyVo.SkillCD
		-- assert(skillCD)
		-- SpecialBossSkillCD Value 神兽降临
		-- BossActiveSkillCD

		-- 测试用
		-- if not skillCD then
		-- 	skillCD = { 5, 5 }
		-- 	self.roleDyVo.SkillCD = skillCD
		-- end

		if skillCD then
			print('MonsterBigSkill')
			print(skillCD)

			local now = require 'FightTimer'.currentFightTimeMillis()	

			self._bigSkillCount			 	= self._bigSkillCount or 0
			self._bigSkillLastTimeStep 		= self._bigSkillLastTimeStep or now

			local timeStep = ((self._bigSkillCount <= 0 and skillCD[1]) or skillCD[2]) * 1000
			local diff = now - self._bigSkillLastTimeStep

			if diff >= timeStep then

				if not self._isWaitForReleaseSkill then
					self._isWaitForReleaseSkill = true

					EventCenter.eventInput(FightEvent.Pve_BigSkill_Warning_Show)

					self:runWithDelay(function ()
						-- body
						if not self:isDisposed() and not self:isFrozen() then
							self._bigSkillCount = self._bigSkillCount + 1
							self._bigSkillLastTimeStep = now
							EventCenter.eventInput( FightEvent.Pve_TriggerBigSkill, { playerId = self.roleDyVo.playerId } )
						end

						self._isWaitForReleaseSkill = nil
						EventCenter.eventInput(FightEvent.Pve_BigSkill_Warning_Hide)
					end, 2.5)
				end

				return false
			end
		end
	end
end

function HeroPlayer:runMonsterMoveToDeadLine()
	-- body
	local line = GridManager.getMonsterDeadLine()
	local selfPos = self:getPosition()
	local endPos = { x = line + 10, y = selfPos.y }

	self:moveToNewPos(endPos, function ()
		-- body
		self:standToEnemyTeam()
	end)

	return true
end

--[[
	if self:checkReached(rolePlayerArr, dt) then
	-- elseif self:checkBigSkill(rolePlayerArr, dt) then
	elseif self:handleBasic(rolePlayerArr, dt) then
	elseif self:handleAdvanced(rolePlayerArr, dt) then
	-- elseif self:checkZhiLiaoStay(rolePlayerArr) then
	else
		self:doWhenNoTarget()
	end
--]]

function HeroPlayer:isMonsterRemainTimesToShoot()
	-- body
	if self:isCareerYuanCheng() and self:isMonster() then
		self._monsterShootTimes = self._monsterShootTimes or 0
		if self._monsterShootTimes < Monster_LongRange_Times then
			return true
		end
	end
end

function HeroPlayer:countMonsterShoot()
	-- body
	self._monsterShootTimes = self._monsterShootTimes or 0
	self._monsterShootTimes = self._monsterShootTimes + 1
end

function HeroPlayer:runMonsterBasicAttack()
	-- body
	local target = self:getBasicAttackTarget()
	if target then
		if self:isPosSuitableForBasicAttack() then
			if self:isInAttackCD() then
				return self:standToEnemy()
			else
				if self:runMonsterBigSkill() then
					return true
				else
					return self:startToBasicAttack()
				end
			end
		else
			local pos = self:findPosSuitableForBasicAttack( true )
			if pos then
				self:moveToNewPos(pos, function ()
					-- body
					self:standToEnemy()
				end)
				return true
			else
				-- assert(false, '为什么没有合适的攻击位置????')
				-- print('为什么没有合适的攻击位置????')
			end
		end
	end
end

function HeroPlayer:runMonsterBlock()
	-- body
	local enemy = self:findEnemyInBlockArea()
	if enemy then
		self:setBasicAttackTarget(enemy)
		-- assert(false)
		local ret = self:runMonsterBasicAttack()
		if ret then 
			print(string.format('Id=%d, 处理拦截!', self.roleDyVo.playerId))
			return true 
		end
	end
end

function HeroPlayer:runMonsterLongRangeAttack()
	-- body
	if self:isCareerYuanCheng() then
		if self:isMonsterRemainTimesToShoot() then
			if self:isEnemyInSelfLineForShoot() then
				if self:isInSelfUICenter() then

					if self:isInAttackCD() then
						return self:standToEnemyTeam()
					else
						if self:runMonsterBigSkill() then
							return true
						else
							self:countMonsterShoot()
							return self:startToLongRangeAttack()
						end
					end
				else
					-- 不需要换行
					local uiPosArr = GridManager.getMonsterIdleUICenterArrayNoChangeLine(self)
					local nextUiPos = uiPosArr[1] 
					if nextUiPos then
						self:moveToNewPos(nextUiPos, function ()
							-- body
							self:standToEnemyTeam() 
						end)
						return true
					else
						-- assert(false)
						return false
					end
				end
			else
				-- 寻找一个点
				local pos = self:findMonsterPosForShootEnemyInOtherLine()
				if pos then
					self:moveToNewPos(pos, function ()
						-- body
						self:standToEnemyTeam()
					end)
					return true
				else
					-- 不用再远程攻击了
					-- assert(false)
					return false
				end
			end
		end
	end

	-- assert(false)
	return false
end

function HeroPlayer:isMonsterFriendExceptZiLiaoAround()
	-- body
	local selfPos = self:getPosition()

	local cureRange = self:getCureRange()

	local wdith = cureRange[1] * GridManager.getUIGridWidth()
	local height = cureRange[2] * GridManager.getUIGridHeight()

	return self:iteratorSelfTeam(function ( friend )
		-- body
		if not friend:isCareerZiLiao() then
			local friendPos = friend:getPosition()
			if YFMath.isInOvel(selfPos,friendPos,wdith,height) then
				return true
			end
		end
	end)
end

function HeroPlayer:runMonsterZiLiao()
	-- body
	if self:isCareerZiLiao() then
		if self:isInUICenter() then

			if self:isMonsterFriendExceptZiLiaoAround() then
				print('治疗怪物 准备治疗')
				if self:isFriendInCircleForCure() then
					if self:isInAttackCD() then
						return self:standToEnemyTeam()
					else
						if self:runMonsterBigSkill() then
							return true
						else
							return self:startToCure()
						end
					end
				end

				return self:standToEnemyTeam()
			else
				print('治疗怪物在自己格子, 但是没有排除治疗外的友军!')
			end
		else
			-- goto nextUiPos ?
			local uiPosArr = GridManager.getMonsterIdleUICenterArrayNoChangeLine(self)
			local nextUiPos = uiPosArr[1] 

			if nextUiPos then
				self:moveToNewPos(nextUiPos, function ()
					-- body
					self:standToEnemyTeam()
				end)

				local selfPos = self:getPosition()
				print('治疗怪物 当前位置:'..tostring(selfPos.x)..','..tostring(selfPos.y))
				print('治疗怪物 下一个治疗点:'..tostring(nextUiPos.x)..','..tostring(nextUiPos.y))

				return true
			else
				print('治疗怪物没有找到下一个治疗点')
			end
		end
	end
end

-- to be overrided
function HeroPlayer:runCheckMonster()
	-- body
end

function HeroPlayer:runMonsterAILoop()
	-- body
	if self:isAiUnlocked() then

		-- 处理是否到达边线
		do
			local ret = self:checkMonsterReachDeadLine()
			if ret then
				return true
			end
		end

		-- 检查怪物
		do
			local ret = self:runCheckMonster()
			if ret then
				print(string.format('Id=%d, 处理怪物检查!', self.roleDyVo.playerId))
				return true
			end
		end

		-- 处理拦截
		do
			local ret = self:runMonsterBlock()
			if ret then
				print(string.format('Id=%d, 处理怪物拦截!', self.roleDyVo.playerId))
				return true
			end
		end

		-- 处理内部指令
		do
			-- 没有所谓的内部指令
			local ret = self:executeInnerCommand()
			if ret then 
				print(string.format('Id=%d, 处理怪物内部指令!', self.roleDyVo.playerId))
				return true 
			end
		end


		-- 处理怪物远程
		do
			local ret = self:runMonsterLongRangeAttack()
			if ret then
				print(string.format('Id=%d, 处理怪物远程!', self.roleDyVo.playerId))
				return true
			end
		end

		-- 处理怪物治疗
		do
			local ret = self:runMonsterZiLiao()
			if ret then
				print(string.format('Id=%d, 处理怪物治疗!', self.roleDyVo.playerId))
				return true
			end
		end

		-- 向边线靠拢
		do
			local ret = self:runMonsterMoveToDeadLine()
			if ret then
				print(string.format('Id=%d, 处理怪物向目的地进发!', self.roleDyVo.playerId))
				return true
			end
		end
	end
end

-- 
function HeroPlayer:runMoveToNewPos()
	-- body
	local pos = self:getMoveTarget()
	if pos then
		self:moveToNewPos(pos)
		return true
	end
end


-- 竞技场AI
function HeroPlayer:findEnemyInBattleField()
	-- body
	local lastEnmey = self:getBasicAttackTarget()
	return self:searchEnemy(lastEnmey, function ( enemy )
		-- body
		return true
	end)
end

function HeroPlayer:findFriendsExceptZiLiao()
	-- body
	return self:iteratorSelfTeam(function ( friend )
		-- body
		if not friend:isCareerZiLiao() then
			return friend
		end
	end)
end

function HeroPlayer:findFriendsExceptYuanCheng()
	-- body
	return self:iteratorSelfTeam(function ( friend )
		-- body
		if not friend:isCareerYuanCheng() then
			return friend
		end
	end)
end

function HeroPlayer:runChampionMonsterBigSkill( ... )
	-- body
	if require 'ServerAccess'.isManaFull(self.roleDyVo.playerId) then
		EventCenter.eventInput( FightEvent.Pve_TriggerBigSkill, { playerId = self.roleDyVo.playerId } )
		return true
	else
		return false
	end
end


function HeroPlayer:runArenaBigSkill( ... )
	-- body
	if require 'ServerAccess'.isManaFull(self.roleDyVo.playerId) then
		EventCenter.eventInput( FightEvent.Pve_TriggerBigSkill, { playerId = self.roleDyVo.playerId } )
		return true
	else
		return false
	end
end

function HeroPlayer:runArenaBasicAttack()
	-- body
	local target = self:getBasicAttackTarget()
	if target then

		if self:isPosSuitableForBasicAttack() then
			if self:isInAttackCD() then
				-- print('近战 处于CD')
				return self:standToEnemy()
			else
				-- print('近战 开始攻击')
				if self:runArenaBigSkill() then
					print(string.format('Id=%d, 竞技场 处理大招攻击!', self.roleDyVo.playerId))
					return true
				end

				return self:startToBasicAttack()
			end
		else
			local pos = self:findPosSuitableForBasicAttack( true )

			if pos then
				-- print('近战 向目标移动')
				self:moveToNewPos(pos, function ()
					-- body
					self:standToEnemy()
				end)
				return true
			else
				-- assert(false, '为什么没有合适的攻击位置????')
				print('为什么没有合适的攻击位置???? %d', self.roleDyVo.playerId)
				debug.catch(true)
			end
		end
	else
		print('为什么没有合适的攻击对象???? %d', self.roleDyVo.playerId)
		debug.catch(true)
	end
end

function HeroPlayer:runArenaJinZhanAI( ... )
	-- body
	if self:isCareerJinZhan() then
		-- 战士类AI
		local enemy = self:findEnemyInBattleField()
		if enemy then
			self:setBasicAttackTarget(enemy)
			local ret = self:runArenaBasicAttack()
			if ret then
				print(string.format('Id=%d, 竞技场战士 处理近战!', self.roleDyVo.playerId))
				return true
			end
		elseif self:isInSelfUICenter() then
			local ret = self:standToEnemyTeam()
			if ret then
				print(string.format('Id=%d, 竞技场战士 处理待机!', self.roleDyVo.playerId))
				return true
			end
		else
			local ret = self:runReturnBack()
			if ret then
				print(string.format('Id=%d, 竞技场战士 处理回退!', self.roleDyVo.playerId))
				return true
			end
		end
	end
end



function HeroPlayer:runArenaYuanChengAI()
	-- body
	if self:isCareerYuanCheng() then
		-- 处理排挤???
		local enemy = self:findEnemyInBlockArea()
		if enemy then
			self:setBasicAttackTarget(enemy)
			local ret = self:runArenaBasicAttack()

			if ret then
				print(string.format('Id=%d, 竞技场远程 处理拦截! (准备攻击 %d)', self.roleDyVo.playerId, enemy.roleDyVo.playerId))
				return true
			end

		elseif self:isInSelfUICenter() then
			if self:isEnemyInSelfLineForShoot() then
				if self:isInAttackCD() then
					local ret = self:standToEnemyTeam()

					if ret then
						print(string.format('Id=%d, 竞技场远程 处理CD中!', self.roleDyVo.playerId))
						return true
					end

				else
					if self:runArenaBigSkill() then
						print(string.format('Id=%d, 竞技场远程 处理大招攻击!', self.roleDyVo.playerId))
						return true
					end

					local ret = self:startToLongRangeAttack()

					if ret then
						print(string.format('Id=%d, 竞技场远程 处理远程攻击!', self.roleDyVo.playerId))
						return true
					end
				end
			else
				local pos = self:findPosForShootEnemyInOtherLine()
				if pos then
					self:moveToNewPos(pos, function ()
						-- body
						self:standToEnemyTeam()
					end)

					print(string.format('Id=%d, 竞技场远程 处理换行1!', self.roleDyVo.playerId))
					return true
				end
			end
		else
			local pos = self:findPosForShootEnemyInOtherLine()
			if pos then
				self:moveToNewPos(pos, function ()
					-- body
					self:standToEnemyTeam()
				end)

				print(string.format('Id=%d, 竞技场远程 处理换行2! (准备换行 %.2f, %.2f)', self.roleDyVo.playerId, pos.x, pos.y))
				return true
			end
		end

		if not self:findFriendsExceptYuanCheng() then
			local enemy = self:findEnemyInBattleField()
			if enemy then
				self:setBasicAttackTarget(enemy)
				local ret = self:runArenaBasicAttack()

				if ret then
					print(string.format('Id=%d, 竞技场远程 处理最后近战!', self.roleDyVo.playerId))
					return true
				end
			end
		end

		if self:isInSelfUICenter() then
			local ret = self:standToEnemyTeam()
			if ret then
				print(string.format('Id=%d, 竞技场远程 处理待机!', self.roleDyVo.playerId))
				return true
			end
		else
			local ret = self:runReturnBack()
			if ret then
				print(string.format('Id=%d, 竞技场远程 处理回退!', self.roleDyVo.playerId))
				return true
			end
		end
	end
end

function HeroPlayer:runArenaZiLiaoAI()
	-- body
	if self:isCareerZiLiao() then
		--有大招 优先放大招
		if self:runArenaBigSkill() then
			print(string.format('Id=%d, 竞技场治疗 处理大招攻击!', self.roleDyVo.playerId))
			return true
		end

		local enemy = self:findEnemyInBlockArea()
		if enemy then
			self:setBasicAttackTarget(enemy)
			local ret = self:runArenaBasicAttack()
			if ret then
				print(string.format('Id=%d, 竞技场治疗 处理拦截!', self.roleDyVo.playerId))
				return true
			end
		elseif self:isInSelfUICenter() then

			if self:isFriendInCircleForCure() then
				if self:isInAttackCD() then
					local ret = self:standToEnemyTeam()
					if ret then
						print(string.format('Id=%d, 竞技场治疗 处理治疗CD!', self.roleDyVo.playerId))
						return true
					end
				else
					if self:runArenaBigSkill() then
						print(string.format('Id=%d, 竞技场治疗 处理大招攻击!', self.roleDyVo.playerId))
						return true
					end

					local ret = self:runBasicCure()
					if ret then
						print(string.format('Id=%d, 竞技场治疗 处理治疗!', self.roleDyVo.playerId))
						return true
					end
				end
			end
		end

		do
			local ret = self:runGoToFrontForCure()
			if ret then
				print(string.format('Id=%d, 竞技场治疗向前!', self.roleDyVo.playerId))
				return true 
			end
		end

		if not self:findFriendsExceptZiLiao() then
			local enemy = self:findEnemyInBattleField()
			if enemy then
				self:setBasicAttackTarget(enemy)
				local ret = self:runArenaBigSkill()
				if ret then
					print(string.format('Id=%d, 竞技场治疗 最后近战!', self.roleDyVo.playerId))
					return true
				end
			end
		end

		if not self:isInSelfUICenter() then
			local ret = self:runReturnBack()
			if ret then
				print(string.format('Id=%d, 竞技场治疗 处理回退!', self.roleDyVo.playerId))
				return true
			end
		end

	end
end

function HeroPlayer:runArenaAILoop()
	-- body
	if self:isAiUnlocked() then

		self:runArenaJinZhanAI()

		self:runArenaYuanChengAI()

		self:runArenaZiLiaoAI()
	end
end


-- function HeroPlayer:setFanScan( fanScan )
-- 	-- body
-- 	self._useFanScan = fanScan
-- end

-- function HeroPlayer:getFanScan( fanScan )
-- 	-- body
-- 	return self._useFanScan
-- end


-- 目标点
-- 目标对象
-- local function createBasicAttackNode()
-- 	-- body

-- 	-- And, Or, If, C, A, 
-- 	local c_0 = BT_Node.new('C', 	HeroPlayer.getBasicAttackTarget )

-- 	local c_1 = BT_Node.new('C', 	HeroPlayer.isPosSuitableForBasicAttack )
-- 	local c_2 = BT_Node.new('C', 	HeroPlayer.isInAttackCD )
	
-- 	local a_0 = BT_Node.new('A', 	HeroPlayer.standToEnemy )
-- 	local a_1 = BT_Node.new('A', 	HeroPlayer.startToBasicAttack )
-- 	-- local a_2 = 

-- 	-- like or 
-- 	local if_0 = BT_Node.new('If', 	nil )

-- 	local tree = {
-- 		type = 'C',
-- 		func = HeroPlayer.getBasicAttackTarget,

-- 		arr = {
-- 			{ 	type = 'If', --只会选择一个进入
-- 				arr = {
-- 					{ 	type = 'C', 
-- 						func =  HeroPlayer.isPosSuitableForBasicAttack,
-- 						arr = {
-- 						-- 
-- 						},
-- 					},

-- 					{ 	type = 'And', 
-- 						arr = {
-- 						-- 
-- 						},
-- 					},
-- 				},
-- 			},
-- 		},
-- 	},


-- 	-- ( op = And, Or, )
-- 	-- func, dec = 'Not'


-- 寻找敌人的优先级, 上一个目标, 距离自己最短, 符合当前的搜索规则
-- 寻找位置的规则,类同上

--流程A 	--处理近战攻击流程
			-- 是不是有基础攻击目标
				-- 是不是在合适的位置上
					-- 是不是在CD中
						-- 面朝目标敌人站立
					-- 否则
						-- 发起近战攻击
				--寻找一个适合的位置
				--向合适的位置移动

--流程B 	--处理远程攻击
			-- 是不是在己方的格子中心
				-- 当前行有没有敌人
					-- 有没有符合技能搜索范围的敌人
						-- 是不是在CD中
							-- 面朝敌方站立
						-- 否则
							-- 发起远程攻击
--流程C  --处理治疗
		-- 是不是在己方的格子中心
			-- 治疗范围内是否有扣血的友军
					-- 是不是在CD中
						-- 面朝敌方站立
					-- 否则
						-- 发起治疗

-- 是不是AI可以运行
	-- 是不是战士职业
		-- (拦截)
			-- 找一个拦截范围内的敌人,并设为基础攻击目标
			-- 处理流程A
		-- (近战)
			-- 找一个近战范围内的敌人,并设为基础攻击目标
			-- 处理流程A
		-- (自动近战)
			-- 全屏找敌人
			-- 处理流程A
		-- 处理归位
		-- 处理待机

	-- 是不是远程职业
		-- (拦截)
			-- 找一个拦截范围内的敌人,并设为基础攻击目标
			-- 处理流程A
		-- (远程)
			-- 处理流程B(远程)
		-- 是否开启自动
			-- (我方本阵拦截)
				-- 找一个进入我方区域的无人处理的敌人,并设为基础攻击对象
				-- 处理流程A
			-- 寻找可以发起远程攻击的位置 (优先当前行, 其次距离最短)
			-- 向该位置靠拢
		-- 处理归位
		-- 处理待机

	-- 是不是治疗职业
		-- (拦截)
			-- 找一个拦截范围内的敌人,并设为基础攻击目标
			-- 处理流程A
		-- 是否开启自动
			-- (我方本阵拦截)
				-- 是否没有空闲的远程了( 指没有正在攻击, 或正在移动, 或处于阻断AI的异常状态的远程 )
					-- 找一个进入我方区域的无人处理的敌人,并设为基础攻击对象
					-- 处理流程A
		-- 处理流程C(治疗)
		-- 处理归位
		-- 处理待机

-- 			

-- 	--执行战士AI
-- 		--执行拦截(And)
-- 			--执行找一个拦截范围内的敌人,并设为基础攻击目标
-- 			--执行近战攻击流程
-- 				-- 是否有目标?
-- 					-- 是否在合适的占位可以发起攻击? 
-- 						-- 是否处在CD中
-- 							-- 面朝地方,站立
-- 						-- else
-- 							-- 发起近战攻击
-- 				--  

-- 		--执行命令
-- 			-- 是否有外部命令

-- 		--执行近战
-- 			-- 

-- 		--执行近战自动
-- 			--

-- 		--执行回位
-- 		--执行待机
-- 		--非法执行

-- 	--执行远程AI

-- 	--执行治疗AI 


-- 	return tree
-- end

-- AIMaster
function HeroPlayer:createAIMaster()
	-- body
	assert(self._AIMaster)

	-- Sequence, Condition, Action, Select
	-- local target = self:getBasicAttackTarget()
	-- if target then
	-- 	if self:isPosSuitableForBasicAttack() then
	-- 		if self:isInAttackCD() then
	-- 			return self:standToEnemy()
	-- 		else
	-- 			return self:startToBasicAttack()
	-- 		end
	-- 	else
	-- 		local pos = self:findPosSuitableForBasicAttack()
	-- 		if pos then
	-- 			self:moveToNewPos(pos, function ()
	-- 				-- body
	-- 				self:standToEnemy()
	-- 			end)
-- 			return true
	-- 		else
	-- 		end
	-- 	end
	-- end

end




function HeroPlayer:onDead()
	-- body
end

function HeroPlayer:isBlind()
	-- body
	return self.roleDyVo.isBlind
end

function HeroPlayer:isFrozen()
	-- body
	return self.roleDyVo.isFreeze
end

function HeroPlayer:isMonster()
	-- body
	return false
end

function HeroPlayer:isOtherPlayer()
	-- body
	return false
end

function HeroPlayer:isMonsterBoss()
	-- body
	return self.roleDyVo.isBoss
end

function HeroPlayer:isCareerYuanCheng()
	-- body
	local career = self:getCareer()
	return career == TypeRole.Career_YuanCheng
end

function HeroPlayer:isCareerZiLiao()
	-- body
	local career = self:getCareer()
	return career == TypeRole.Career_ZiLiao
end

function HeroPlayer:isCareerJinZhan()
	-- body
	local career = self:getCareer()
	return career == TypeRole.Career_ZhanShi or career == TypeRole.Career_QiShi
end

return HeroPlayer
