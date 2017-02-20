local RoleSelfManager 			= require 'RoleSelfManager'
local FightTimer 				= require 'FightTimer'
local ActionUtil 				= require 'ActionUtil'
local GridManager 				= require 'GridManager'
local EventCenter 				= require 'EventCenter'
local FightEvent 				= require 'FightEvent'
local CfgHelper 				= require 'CfgHelper'



local GrowTime = CfgHelper.getCache('BattleSetConfig', 'Key', 'growtime', 'Value') or 3
print('GrowTime '..tostring(GrowTime))

local GrowSize = CfgHelper.getCache('BattleSetConfig', 'Key', 'sizegrow', 'Value') or 0.1
print('GrowSize '..tostring(GrowSize))

local GrowAtk = CfgHelper.getCache('BattleSetConfig', 'Key', 'atkgrow', 'Value') or 0.2
print('GrowAtk '..tostring(GrowAtk))

local BaseSize = CfgHelper.getCache('BattleSetConfig', 'Key', 'basesize', 'Value') or 0.7
print('BaseSize '..tostring(BaseSize))

local BaseAtk = CfgHelper.getCache('BattleSetConfig', 'Key', 'baseatk', 'Value') or 1
print('BaseAtk '..tostring(BaseAtk))

local Grow_Time = {
	0, 5, 10, 15, 20, 25
}
-- GrowTime = 1
for i=0, 5 do
	Grow_Time[i] = i * GrowTime
end

local GrowMonster = class( require 'MonsterPlayer' )

function GrowMonster:ctor()
	-- body
	self._growHandle = nil
end

function GrowMonster:startGrowHandle()
	-- body
	if not self._growHandle then

		local count_time = 0

		self._growHandle = FightTimer.addFunc(function ( dt )
			-- body
			if self:isDisposed() then
				self._growHandle = nil
				return true
			end

			local new_count_time = count_time + dt

			local count_index 		= (#Grow_Time + 1)
			local new_count_index 	= (#Grow_Time + 1)
			
			for i,v in ipairs(Grow_Time) do
				if v >= count_time then
					count_index = i
					break
				end
			end

			for i,v in ipairs(Grow_Time) do
				if v >= new_count_time then
					new_count_index = i
					break
				end
			end

			if new_count_index > count_index then
				self:growUp(count_index, new_count_index)
			end

			if new_count_index == count_index and new_count_index >= (#Grow_Time + 1) then
				self._growHandle = nil
				return true
			end

			count_time = new_count_time
		end)
	end
end

function GrowMonster:growUp( index, new_count_index )
	-- body
	index = index - 1
	index = math.max(index, 0)

	new_count_index = new_count_index - 1

	new_count_index = math.min(new_count_index, #Grow_Time-1)
	new_count_index = math.max(new_count_index, 0)
	
	print(string.format('growUp index=%d, new_index=%d', index, new_count_index))

	local sizeScale = BaseSize + GrowSize * new_count_index
	local atkScale = BaseAtk + GrowAtk * new_count_index

	local rootNode = self:getRootNode()
	if rootNode then
		rootNode:setScale(sizeScale)

		local data = {}
		data.playerId = self.roleDyVo.playerId
		data.atk_times = atkScale

		EventCenter.eventInput(FightEvent.Pve_Monster_Property_Change, data)
	end
end

function GrowMonster:onEntryForSpecail()
	-- body
	self:growUp( 0, 1 )

	self:runWithDelay(function ()
		-- body
		self:startGrowHandle()
	end, 1.5)
	
end

require 'MonsterFactory'.check(require 'AIType'.Grow_Type, GrowMonster)
return GrowMonster
