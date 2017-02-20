local EventCenter 					= require 'EventCenter'
local FightEvent 					= require 'FightEvent'
local SwfActionFactory 				= require 'framework.swf.SwfActionFactory'
local TimeOutManager 				= require 'TimeOut'
local ActionUtil 					= require 'ActionUtil'
local YFMath						= require 'YFMath'
local RoleSelfManager 				= require 'RoleSelfManager'

local CopyMonster = class(require 'MonsterPlayer')

local Blink_To_Visible_Data = {}
local Blink_To_Invisible_Data = {}

for i=1,6 do
	local vis = (math.fmod(i, 2) == 0)

	Blink_To_Visible_Data[2*i-1] 	= { f = 2*i-1, v = not vis }
	Blink_To_Invisible_Data[2*i-1] 	= { f = 2*i-1, v = vis }

	Blink_To_Visible_Data[2*i] 		= { f = 2*i, v = vis }
	Blink_To_Invisible_Data[2*i] 	= { f = 2*i, v = not vis }
end

function CopyMonster:ctor()
	-- body
	self._hasTrigger = false
	self._hasPlayDead = false
end

function CopyMonster:startToBasicAttack()
	-- body
	local enemy = self:getBasicAttackTarget()
	if enemy then
		if self:isBlind() then
			return self:standFree()
		end

		-- RolePlayerManager.isHero
		if not require 'RolePlayerManager'.isHero(enemy) then
			return false
		end

		if not self._hasTrigger then
			self._hasTrigger = true
			require 'ServerController'.setProtectTimeByDyId(self.roleDyVo.playerId, 100*1000)

			local target = enemy
			self:trigger( target.roleDyVo.playerId )

			self:runWithDelay(function ()
				-- body
				print('人物死亡,删除角色 roleid='..self.roleDyVo.playerId)
				EventCenter.eventInput(FightEvent.DeleteRole, self)	--人物死亡 删除角色  
			end, 2.5)

			-- self:updateBloodPercent(0, 0)
			self:playDead( self, 0, function ( )
				
			end)

			return true
		end

		return true
	end
end

function CopyMonster:trigger( playerId )
	-- body
	print(string.format('Copy %d -> %d',self.roleDyVo.playerId, playerId))

	local data 				= {}
	data.sourceMonsterId 	= self.roleDyVo.playerId
	data.playerId 			= playerId
	data.birthPos 			= self:getPosition()
	EventCenter.eventInput( FightEvent.Pve_Copy_Monster, data )
end

--播放 死亡动作
function CopyMonster:playDead( attacker, delay, completeCall )
	-- self:cleanAllAtkEffectViews()
	delay = delay or 0

	if not self._playDeadCalled  then
		self._playDeadCalled = true

		if self._hasTrigger then
			local rootNode = self:getRootNode()
			if rootNode then
				local elfaction = SwfActionFactory.createAction(Blink_To_Invisible_Data,nil,nil,20)
				elfaction:setListener(function ()
					-- body
				end)
				rootNode:runAction(elfaction)
			end
			
			local timeOut = TimeOutManager.getTimeOut(6*2/20, function (  )
				-- self:setDisposed()
				if completeCall then
					completeCall()
				end
			end)
			timeOut:start()

			do
				local dieTime = self:getAnimateTimeByName( ActionUtil.Action_Dead )
				local timeOut = TimeOutManager.getTimeOut((0+delay+dieTime)/1000,function ( )
					EventCenter.eventInput(FightEvent.Pve_DieAnimateFinished , { playerId = self.roleDyVo.playerId } )
				end)
				timeOut:start()
			end

		else

			self:cleanAllAtkEffectViews()
			if completeCall then
				local timeOut = TimeOutManager.getTimeOut((200+delay)/1000,function ( )
					completeCall()
				end)
				timeOut:start()
			end

			if self._cloth then
				self._cloth:playDead(delay)
			end

			

			---通知死亡动画完成
			do
				local dieTime = self:getAnimateTimeByName( ActionUtil.Action_Dead )
				local timeOut = TimeOutManager.getTimeOut((0+delay+dieTime)/1000,function ( )
					EventCenter.eventInput(FightEvent.Pve_DieAnimateFinished , { playerId = self.roleDyVo.playerId } )
				end)
				timeOut:start()
			end

		end
	end
end

require 'MonsterFactory'.check(require 'AIType'.Copy_Type, CopyMonster)

---------------------------------------------------------------
local NewCopyMonster = class(require 'MonsterPlayer')

function NewCopyMonster:ctor()
	-- body
end

function NewCopyMonster:onEntry()
	-- body

	local LayerManager = require 'LayerManager'
	local RoleSelfManager = require 'RoleSelfManager'
	
	local targetPos = self:getTempPos()

	local rootNode = self:getRootNode()
	LayerManager.roleLayer:addChild( rootNode )

	self:setPositionWithoutGrid(targetPos.x, targetPos.y)

	self:updateBloodPercent( self.roleDyVo.hpPercent )
	local backStandDir = RoleSelfManager.getOtherRoleBackStandDir()
	self:play( ActionUtil.Action_Stand, backStandDir, true, nil, true)

	local elfaction = SwfActionFactory.createAction( Blink_To_Visible_Data, nil, nil, 20)
	elfaction:setListener(function ()
		-- body
		rootNode:retain()
		rootNode:removeFromParent()
		
		require 'PveSceneRolesView':addMonster(self) 
		rootNode:release()
		
		self:startAI()
		self:setPosition(targetPos.x, targetPos.y) 
	end)
	rootNode:runAction(elfaction) 
end

function NewCopyMonster:isBodyVisible()
	return true
end

require 'MonsterFactory'.check(require 'AIType'.Copy2_Type, NewCopyMonster)




return CopyMonster