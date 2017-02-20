
-- 1.当正在近战战斗时，拖动到攻击对象或者攻击对象身后所阻挡的位置，都不应该发生移动。
-- 2.我方的任何移动都不应该穿过地方单位
-- 3.npc不应该追着逃跑的角色打。当目标移走后，若攻击范围有其他人，应该自动转换目标；攻击范围内无人应该优先向危险区域移动，
-- 4.怪物的攻击范围应该为0.8格，警戒范围对npc无效。当前近战npc会移动到不同行进行攻击
local FightTimer 		= require 'FightTimer'
local EventCenter 		= require 'EventCenter'
local FightEvent		= require 'FightEvent'
local TimeOutManager    = require 'TimeOut'
local DirUtil 			= require 'DirectionUtil'
local GridManager 		= require 'GridManager'
local CfgHelper 		= require 'CfgHelper'

local function getGodTimeMs()
	-- body
	if require 'ServerRecord'.getMode() == 'guider' then
		return 2000
	else
		return (CfgHelper.getCache('BattleSetConfig', 'Key', 'battleunatktime', 'Value') or 3.1) * 1000
	end
end

local MonsterPlayer = class(require 'HeroPlayer')

function MonsterPlayer:ctor()
	-- body
	self._godTimeMs = getGodTimeMs()
end

function MonsterPlayer:showMonsterName()
	-- body
	if self._cloth then
		self._cloth:showMonsterName()
	end
end

function MonsterPlayer:handleAI()
	self:runMonsterAILoop()
end

-- delay s
function MonsterPlayer:onPlayDead(delay, attacker)
	-- body
	if self.roleDyVo.isBoss then
		EventCenter.eventInput(FightEvent.Pve_BigSkill_Warning_Hide)
		EventCenter.eventInput(FightEvent.Pve_KillBoss, {boss = self, attacker = attacker, delay = delay} )
	end

	local dropPos

	if self.roleDyVo.isDropBall or self.roleDyVo.isDropBox then
		dropPos = self:getPosition()
		local scaleX = ((self._activeDirection == DirUtil.Direction_Right) and -1) or 1

		local offset = { x = 100, y = 100}

		dropPos.x = dropPos.x - 100*scaleX - (1136/2) + offset.x
		dropPos.y = dropPos.y - 320 + offset.y
	end

	---掉落精灵球
	if self.roleDyVo.isDropBall then
		----通知需要捕捉标记
		EventCenter.eventInput(FightEvent.Pve_NeedCatchBoss, true)

		--延迟1.1s执行 捕捉动画
		local timeOut = TimeOutManager.getTimeOut(delay + 0.3, function ()
			EventCenter.eventInput(FightEvent.Pve_Drop_Ball, { pos = dropPos } )
			-- EventCenter.eventInput(FightEvent.Pve_ShowCatchBoss, { pos = dropPos } )
		end)
		timeOut:start()

		--通知捕捉动画完成
		local timeOut2 = TimeOutManager.getTimeOut(delay + 2.3,function ( )
			EventCenter.eventInput(FightEvent.Pve_CatchBossFinished , true )
		end)
		timeOut2:start()
	end

	-- 掉落宝箱
	if self.roleDyVo.isDropBox then

		local data = { playerId = self.roleDyVo.playerId }
		EventCenter.eventInput(FightEvent.Pve_NeedDropBox, data )

		TimeOutManager.getTimeOut(delay+0.3, function ()
			EventCenter.eventInput(FightEvent.Pve_Drop_Box, { pos = dropPos } )
			
		end):start()

		TimeOutManager.getTimeOut(delay+2.3, function ()
			EventCenter.eventInput(FightEvent.Pve_DropBoxAnimateFinished, data )
		end):start()
	end
end

--[[
展示名字,
更新血条
--]]
function MonsterPlayer:onEntry()
	-- body
	self:showMonsterName()
	self:updateBloodPercent( self.roleDyVo.hpPercent )
	
	local fromPos = self:getTempPos()
	self:setPosition( -150, fromPos.y )
	self:standToEnemyTeam()

	local firstPos = GridManager.getUICenterByIJ( -3,0 )

	self:runWithDelay(function ()
		-- body
		self:moveToNewPos( { x=firstPos.x, y = fromPos.y} , function ()
			-- body
			self:startAI() 
		end)
	end, 0.1)

	self:runWithDelay(function ()
		-- body
		self:startAI() 
	end, 1)
	
	require 'PveSceneRolesView':addMonster(self) 

	-- 无敌2秒
	self._monsterEntryTime = FightTimer.currentFightTimeMillis()
	
	self:onEntryForSpecail()
end

function MonsterPlayer:isBodyVisible()
	-- body
	if self._monsterEntryTime then
		local t = FightTimer.currentFightTimeMillis()
		return (t - self._monsterEntryTime) >= self._godTimeMs
	end
end

function MonsterPlayer:onEntryForSpecail()
	-- body
end

function MonsterPlayer:isOtherPlayer()
	-- body
	return true
end

function MonsterPlayer:isMonster()
	-- body
	return true
end

require 'MonsterFactory'.check(require 'AIType'.Normal_Type, MonsterPlayer)

return MonsterPlayer



