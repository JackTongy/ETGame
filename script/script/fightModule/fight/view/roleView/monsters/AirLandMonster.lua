local ActionUtil 		= require 'ActionUtil'
local FightEvent 		= require 'FightEvent'
local EventCenter 		= require 'EventCenter'
local Random 			= require 'Random'
local MonsterPlayer 	= require 'MonsterPlayer'
local GridManager 		= require 'GridManager'
local CfgHelper  		= require 'CfgHelper'

local AirLandMonster = class( MonsterPlayer )

function AirLandMonster:ctor()
	-- body
end

function AirLandMonster:getLandTargetPos()
	-- body


	if not self._landTargetPos then

		local posij  = CfgHelper.getCache('BattleSetConfig', 'Key', 'appearposition', 'Value')
		assert(posij)
		local sizeij = CfgHelper.getCache('BattleSetConfig', 'Key', 'appearsize', 'Value')
		assert(sizeij)

		local fx = Random.ranF()
		local fy = Random.ranF()

		local i = posij[1] + sizeij[1]*(fx-0.5)
		local j = posij[2] + sizeij[2]*(fy-0.5)

		local uiPos = GridManager.getUICenterByIJ(i, j)

		self._landTargetPos = uiPos
	end
	return self._landTargetPos
end

---准备入场
function AirLandMonster:onEntry()
	-- body
	self:showTips()
	self:land()
end

function AirLandMonster:isBodyVisible()
	return true
end

function AirLandMonster:showTips()
	-- body
	local targetPos = self:getLandTargetPos()
	EventCenter.eventInput(FightEvent.Pve_AirLandWarning, { x = targetPos.x - 1136/2, y=targetPos.y - 640/2} )
end

--降落
function AirLandMonster:land()
	-- body
	local height = 640
	local LayerManager = require 'LayerManager'
	local RoleSelfManager = require 'RoleSelfManager'

	local targetPos = self:getLandTargetPos()

	local rootNode = self:getRootNode()
	LayerManager.skyLayer:addChild( rootNode )

	self:setPositionWithoutGrid(targetPos.x, targetPos.y + height)

	self:updateBloodPercent( self.roleDyVo.hpPercent )
	local backStandDir = RoleSelfManager.getOtherRoleBackStandDir()
	self:play( ActionUtil.Action_Stand, backStandDir, true, nil, true)

	self:runWithDelay(function ()
		-- body
		local action = CCMoveBy:create(0.5, ccp(0,-height))
		local elfaction = ElfAction:create(action)
		elfaction:setListener(function ()
			-- body
			rootNode:retain()
			rootNode:removeFromParent()
			
			require 'PveSceneRolesView':addMonster(self) 
			rootNode:release()
			
			self:startAI()
			self:setPosition(targetPos.x, targetPos.y) 

			self:showMonsterName()
		end)
		rootNode:runAction(elfaction)
		
	end, 2.5)


end

require 'MonsterFactory'.check(require 'AIType'.AirLand_Type, AirLandMonster)

return AirLandMonster