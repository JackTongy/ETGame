local EventCenter 		= require 'EventCenter'
local FightEvent 		= require 'FightEvent'

local BloodMonster = class(require 'MonsterPlayer')

function BloodMonster:ctor()
	-- body
end

function BloodMonster:runCheckMonster()
	self:setBloodMode( self.roleDyVo.hpPercent < 30 )
end


function BloodMonster:setBloodMode( enable )
	-- body
	enable = (enable and true) or false

	if self._bloodModeEnable ~= enable then
		self._bloodModeEnable = enable

		if enable then
			-- print('setAtkSpdRate')
			self:setAtkSpdRate(1.2)

			local data = {}
			data.playerId = self.roleDyVo.playerId
			data.atk_times = 1.3
			
			EventCenter.eventInput(FightEvent.Pve_Monster_Property_Change, data)
		else
			self:setAtkSpdRate(1)

			local data = {}
			data.playerId = self.roleDyVo.playerId
			data.atk_times = 1
			
			EventCenter.eventInput(FightEvent.Pve_Monster_Property_Change, data)
		end
	end
end

require 'MonsterFactory'.check(require 'AIType'.Blood_Type, BloodMonster)

return BloodMonster