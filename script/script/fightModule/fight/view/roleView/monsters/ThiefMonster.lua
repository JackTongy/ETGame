local ThiefMonster = class ( require 'MonsterPlayer' )

function ThiefMonster:runMonsterAILoop()
	-- body
	if self:isAiUnlocked() then
		-- 处理是否到达边线
		do
			local ret = self:checkMonsterReachDeadLine()
			if ret then
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

require 'MonsterFactory'.check(require 'AIType'.Thief_Type, ThiefMonster)

return ThiefMonster