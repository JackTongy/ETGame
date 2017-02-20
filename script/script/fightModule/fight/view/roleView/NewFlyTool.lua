local LayerManager 				= require 'LayerManager'
local FightTimer 				= require 'FightTimer'
local YFMath 					= require 'YFMath'
local RolePlayerManager 		= require 'RolePlayerManager'
local FlyView 					= require 'FlyView'
local CfgHelper 				= require 'CfgHelper'
local FightEffectBasicManager 	= require 'FightEffectBasicManager'
local SkillUtil 				= require 'SkillUtil'
local EventCenter 				= require 'EventCenter'
local FightEvent				= require 'FightEvent'
local GridManager 				= require 'GridManager'
local Global 					= require 'Global'
local RoleSelfManager 			= require 'RoleSelfManager'
local GridManager 				= require 'GridManager'

local NewFlyTool = class()

local Fly_Count = 0

--[[
飞行道具准备两种类型
NewFlyTool是一种水平方向移动的飞行道具
--]]

function NewFlyTool:ctor( atk, skillId, crit )
	-- body
	self._atk = atk
	self._skillId = skillId
	self._isCrit = crit

	-- print('准备创建飞行道具 skillId = '..skillId)

	--mana
	if atk then
		self._manaRate = require 'ServerAccess'.getManaRateById(atk.roleDyVo.playerId)
	end

	local key = nil

	if atk.roleDyVo.skill_id == skillId then
		--大招
		key = 'skill_effectID'
	else
		--远程
		if crit then
			key = 'crit_remote_effectID'
		else
			key = 'remote_effectID'
		end
	end

	local charactorId = atk.roleDyVo.basicId
	
	local effectIdArray = CfgHelper.getCache('roleEffect', 'handbook', charactorId, key)

	assert(effectIdArray)

	local flyItem = self:findFlyItem(effectIdArray)

	assert(flyItem, '没有飞行道具 skillId = '..skillId)

	if flyItem.model_id == 0 then
		self._view = nil
		print('飞行道具没有 model_id. skillId='..skillId)
	else
		self._view = nil
		if Global.Battle_Use_View then
			self._view = self:createFlyView( flyItem.model_id )
		end
	end

	if self._view then
		self._view:setVisible(false)
	end

	local offset = { flyItem.offset[1], flyItem.offset[2] }

	if self:isLeftOrRight() then
		offset[1] = 0 - offset[1]
	end

	if flyItem.speed and flyItem.speed > 0 then
		--2
		self._speed = math.abs(flyItem.speed)/1000
	else
		self._speed = 2
	end

	-- print('fly speed = '..self._speed)
	
	self._attackCount = 0
	self._attackCountMax = 1

	local skillVo = CfgHelper.getCache('skill', 'id', skillId)

	----是否要贯穿
	if atk.roleDyVo.isGuangChuang or skillVo.target == SkillUtil.SkillTarget_Enemy then
		self._attackCountMax = 100
	end

	self._isBigSkill = skillVo.skilltype >= 10

	-- if atk._chuantou

	self._startPos = { x = atk:getMapX() + offset[1], y = atk:getMapY() + offset[2] }
	self._currentPos = { x = self._startPos.x, y = self._startPos.y }

	---重设速度
	self:setDirection( not self:isLeftOrRight() )
	
	self._firstChecked = false

	self._firstStepTime = ((self._view and self._view:getFirstStepTime()) or 0)*1000 
	self._lastStepTime  = ((self._view and self._view:getLastStepTime()) or 0)*1000 

	----弥补动画
	self._currentPos.x = self._currentPos.x - (self._speed * self._firstStepTime)

	self:setRange(0, 1136)

	self:move(0)

	self:setDistance(2000)
	self._isDisposed = false

end

function NewFlyTool:setRange( x1, x2 )
	-- body
	self._range = {}
	
	self._range.min = math.min(x1, x2)
	self._range.max = math.max(x1, x2)

	if self:isLeftOrRight() then
		self._range.max = self._range.max - self._lastStepTime * self._speed
	else
		self._range.min = self._range.min - self._lastStepTime * self._speed
	end
end

function NewFlyTool:setDistance( d )
	-- body
	self._distance = d

	self._distance = self._distance - math.abs(self._lastStepTime * self._speed) 
end


function NewFlyTool:isLeftOrRight()
	-- body
	-- 数值从小到大
	if self._atk then
		return not self._atk:isOwnerTeam()
	end
end

function NewFlyTool:start()
	-- body
	assert(not self._updateHandler)

	if self._view then
		local node = self._view:getRootNode()
		assert( node )
		LayerManager.skyLayer:addChild( node )
	end

	assert(self._updateHandler == nil)

	self._updateHandler = FightTimer.addFunc(function ( dt )
		-- body
		return self:update(dt)
	end)

end

function NewFlyTool:update( dt )
	-- body
	--毫秒
	dt = dt * 1000

	local step = 25
	while dt > step do
		local ret = self:doStep(step)
		if ret then
			return true
		end
		dt = dt - step
	end

	return self:doStep(dt)
end

function NewFlyTool:doStep( dt )
	-- body
	if not self:isDisposed() then
		--move
		self:move(dt)

		--
		self:checkEnemy(dt)

		--
		return self:checkShouldDisposed(dt)
	end
end

--dt mills
function NewFlyTool:move( dt )
	-- body
	self._currentPos.x = self._currentPos.x + self._speed * dt

	local node = self:getRootNode()
	-- assert(node)
	--JointAnimateNode
	if node then
		if not self._disposedFalg then
			local objtype = tolua.type(node)
			if objtype == 'JointAnimateNode'  then
				if node:getRunningStep() == 1 then
					self:updatePosition()
				end
			else
				self:updatePosition()
			end
		end
	end
end

function NewFlyTool:checkEnemy()
	-- body
	--弥补子弹距离攻击者太远
	if not self._firstChecked then
		self._firstChecked = true

		if self._view then
			self._view:setVisible(true)
		end

		local curPos = { x = self._currentPos.x, y = self._currentPos.y }
		self._currentPos.x = self._startPos.x
		self:updatePosition()
		self._currentPos.x = curPos.x

		if self._atk then 
			local atkPos = self._atk:getPosition()

			local steps = 10

			for i=0, steps do
				self._currentPos.x = atkPos.x + (curPos.x - atkPos.x) * i / steps
				self._currentPos.y = atkPos.y + (curPos.y - atkPos.y) * i / steps

				local enemy = self:findEnemy()
				if enemy then
					self:attackEnemy(enemy)
				end
			end

			self._currentPos.x = curPos.x
			self._currentPos.y = curPos.y
		end
	end

	local enemy = self:findEnemy()
	if enemy then
		self:attackEnemy(enemy)
	end
end

function NewFlyTool:checkShouldDisposed(dt)
	-- body
	if self._disposedFalg then
		self._lastStepTime = self._lastStepTime - dt
		if self._lastStepTime <= 0 then
			if self._updateHandler then
				self:setFinalDisposed()
				FightTimer.removeFunc( self._updateHandler )
				self._updateHandler = nil

				self._view = nil
				self._isDisposed = true

				return true
			end
		end
	end

	--攻击次数达到上限
	if self._attackCount >= self._attackCountMax then
		return self:setDisposed()
	end

	--飞出范围
	if self:isLeftOrRight() and self._currentPos.x >= self._range.max then
		return self:setDisposed()
	elseif not self:isLeftOrRight() and self._currentPos.x <= self._range.min then

		-- print('why!!!!!')
		return self:setDisposed()
	end

	-- if self._currentPos.x < -self._range.min or self._currentPos.x > self._range.max then
	-- 	return self:setDisposed()
	-- end

	--超出距离
	if math.abs(self._currentPos.x - self._startPos.x) > self._distance then
		return self:setDisposed()
	end



end


function NewFlyTool:getRootNode()
	-- body
	if self._view then
		return self._view:getRootNode()
	end	
end

function NewFlyTool:setDirection( toLeft )
	-- body
	self._speed = math.abs(self._speed) * ( (toLeft and -1) or 1)

	local node = self:getRootNode()
	if node then
		node:setScaleX( node:getScaleX() * ((toLeft and 1) or -1) )
	end

	self:updatePosition()
end

function NewFlyTool:updatePosition()
	-- body
	local node = self:getRootNode()
	if node then
		assert(self._currentPos)
		local screenPos = YFMath.logic2physic( self._currentPos )
		NodeHelper:setPositionInScreen(node, ccp(screenPos.x, screenPos.y) )
	end
end

function NewFlyTool:createFlyView( moduleId )
	-- body
	local view = FlyView.createFlyViewById(moduleId)
	local node = view:getRootNode()
	return view
end

function NewFlyTool:setFinalDisposed()
	-- body
	-- self._atk = nil
	self._attackedList = nil
end

function NewFlyTool:setDisposed(  )
	-- body
	if not self._disposedFalg then
		self._disposedFalg = true

		if self._view then
			self._view:setDisposed()
		end

		-- if self._updateHandler then
		-- 	FightTimer.removeFunc( self._updateHandler )
		-- 	self._updateHandler = nil
		-- end
	end
end

function NewFlyTool:isDisposed(  )
	-- body
	return self._isDisposed
end


function NewFlyTool:hasInAttackedList( enemy )
	-- body
	return self._attackedList and self._attackedList[enemy]
end

function NewFlyTool:attackEnemy( enemy )
	-- body
	if enemy and self._attackCount < self._attackCountMax then

		self._attackedList = self._attackedList or {}
		self._attackedList[enemy] = true

		--Action
		--发送战斗协议
		local data = {}
		data.Hid = self._atk.roleDyVo.playerId
		data.Sid = self._skillId
		data.Hids = { enemy.roleDyVo.playerId }
		data.IsCrit = self._isCrit
		data.BasicId = self._atk.roleDyVo.basicId

		data.ManaRate = self._manaRate

		for i=1, self._attackCount do
			table.insert(data.Hids, 1, -1)
		end

		-- table.insert(data.Hids, enemy.roleDyVo.playerId )
		-- data.Hids = { -1, -1, -1, enemy.roleDyVo.playerId }
		-- self._manaRate
		
		if self._attackCount >= 1 then
			EventCenter.eventInput(FightEvent.Pve_ManaLock, { playerId = data.Hid, lockMana = true} )
			EventCenter.eventInput(FightEvent.C_Fight, data)
			EventCenter.eventInput(FightEvent.Pve_ManaLock, { playerId = data.Hid, lockMana = false} )
		else
			EventCenter.eventInput(FightEvent.C_Fight, data)
		end
		
		self._attackCount = self._attackCount + 1
	end

end

function NewFlyTool:findEnemy()

	if RoleSelfManager.isPvp then
		return nil
	end

	local current = self._currentPos

	local isRight = not self:isLeftOrRight()
	local enemyArray = (isRight and RolePlayerManager.getOtherPlayerMapSorted() )or RolePlayerManager.getOwnPlayerMapSorted()
	local enemy

	local threldholdY = GridManager.getUIGridHeight()/2 + 20
	local threldholdX = GridManager.getUIGridWidth()/4 + 20

	for i,role in ipairs(enemyArray) do
		if not role:isDead() and (role:isBodyVisible() or self._isBigSkill) and not self:hasInAttackedList(role) then
			local roleX = role:getMapX()
			local roleY = role:getMapY()
			
			if math.abs(roleY - current.y) <= threldholdY then
				if math.abs(roleX - current.x) <= threldholdX then
					if not enemy then
						enemy = role
					elseif isRight then
						if enemy:getMapX() < roleX then
							enemy = role
						end
					else
						if enemy:getMapX() > roleX then
							enemy = role
						end
					end

				end
			end
		end
	end

	return enemy
end

function NewFlyTool:findFlyItem( effectIdArray )
	for i,v in ipairs(effectIdArray) do
		local array = CfgHelper.getCacheArray('fightEffect', 'effectId', v)
		if array then
			for ii,vv in ipairs(array) do
				if vv.layer == SkillUtil.Layer_FlyTool then
					return vv
				end
			end
		end
	end

	--如果没找到用103代替
	local array = CfgHelper.getCacheArray('fightEffect', 'effectId', 103)
	if array then
		for ii,vv in ipairs(array) do
			if vv.layer == SkillUtil.Layer_FlyTool then
				return vv
			end
		end
	end

	print('not findFlyItem')
	print(effectBassicArr)
	print('---------------')
end

function createFlyTool( atk, skillId, crit )
	-- body
	local flyTool = NewFlyTool.new(atk, skillId, crit )
	flyTool:start()

	return flyTool
end


return { createFlyTool = createFlyTool } 


