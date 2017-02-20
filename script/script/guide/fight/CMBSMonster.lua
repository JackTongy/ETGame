local EventCenter = require 'EventCenter'
local FightEvent = require 'FightEvent'
local SwfActionFactory = require 'framework.swf.SwfActionFactory'
local SpecailManager = require 'SpecailManager'
local TimeOutManager = require "TimeOut"
local ActionUtil = require 'ActionUtil'
local TimerHelper = require 'framework.sync.TimerHelper'

local CMBSMonster = class(require 'MonsterPlayer')

function CMBSMonster:ctor()
	-- body
	self._hasTrigger  = false
	self._hasPlayDead = false

	self:initEvents()
end

function CMBSMonster:initEvents()
	-- body

	EventCenter.addEventFunc(FightEvent.Guider_CMBS, function ( data )
		-- body
		-- EventCenter.eventInput( FightEvent.Guider_Pve_FightPause, true)
		self:transform()

	end, 'Fight')
end

--[[
超梦变身
--]]
function CMBSMonster:transform()
	-- body
	self:updateBloodPercent(0, nil)
	
	self:playDead(0, function ( )
		print('人物死亡,删除角色 roleid='..self.roleDyVo.playerId)
		EventCenter.eventInput(FightEvent.DeleteRole, self)
	end)

	-- 播放动画
	-- self:playFightInPVE(skillBasicVo, isCrit, arr, time)
	self:trigger()
end

--播放 死亡动作
function CMBSMonster:playDead( attacker, delay, completeCall )
	-- self:cleanAllAtkEffectViews()
	if not self._playDeadCalled  then
		self._playDeadCalled = true

		local rootNode = self:getRootNode()
		if rootNode then
			rootNode:setVisible(false)
		end

		local timeOut = TimeOutManager.getTimeOut(6*2/20, function ()
			if completeCall then
				completeCall()
			end
		end)
		timeOut:start()
	end
end

function CMBSMonster:trigger()
	-- body
	print(string.format('CMBSMonster trigger %d',self.roleDyVo.playerId ))

	local data = {}
	data.sourceMonsterId 	= self.roleDyVo.playerId
	data.birthPos 			= self:getPosition()

	data.basicId 			= 150001
	data.hp 				= 150000
	data.hpMax  			= 150000
	-- data.atk 				= 20000
	data.def 				= 0
	data.cri 				= 0
	data.speed 				= 80 * 0.2
	data.atktime 			= 1.8

	EventCenter.eventInput( FightEvent.Pve_Copy_Monster_CMBS, data )
end


require 'MonsterFactory'.check(require 'AIType'.Copy_CMBS_Type, CMBSMonster)

---------------------------------------------------------------
local NewCMBSCopyMonster = class(require 'MonsterPlayer')

function NewCMBSCopyMonster:ctor()
	-- body
	self:initEvents()
end

function NewCMBSCopyMonster:initEvents()
	-- body
	EventCenter.addEventFunc(FightEvent.Guider_CM_ReleaseSkill, function ()
		-- body
		EventCenter.eventInput( FightEvent.Pve_TriggerBigSkill, { playerId = self.roleDyVo.playerId } )
	end, 'Fight')
end

function NewCMBSCopyMonster:onEntry()
	-- body
	--blink action
	local LayerManager = require 'LayerManager'
	local RoleSelfManager = require 'RoleSelfManager'
	
	local targetPos = self:getTempPos()

	local rootNode = self:getRootNode()
	LayerManager.roleLayer:addChild( rootNode )

	self:setPositionWithoutGrid(targetPos.x, targetPos.y)

	self:updateBloodPercent( self.roleDyVo.hpPercent )
	local backStandDir = RoleSelfManager.getOtherRoleBackStandDir()
	self:play( ActionUtil.Action_Stand, backStandDir, true, nil, true)

	rootNode:retain()
	rootNode:removeFromParent()
	
	require 'PveSceneRolesView':addMonster(self) 
	rootNode:release()

	-- self:setd

	self:startAI()
	self:setPosition(targetPos.x, targetPos.y) 
end

function NewCMBSCopyMonster:startAI()

end

function NewCMBSCopyMonster:isBodyVisible()
	-- body
	return true
end

require 'MonsterFactory'.check(require 'AIType'.Copy2_CMBS_Type, NewCMBSCopyMonster)
