local DanceMonster = class( require 'MonsterPlayer' )

function DanceMonster:ctor()
	-- body
end

function DanceMonster:runMonsterBigSkill()
	local basicAttackTimes = self:getBasicAttackTimes()
	local bigSkillTimes = self:getBigSkillTimes()

	local step = 3
	
	if basicAttackTimes >= (bigSkillTimes+1)*step then
		return self:startToBigSkill()
	end
end


require 'MonsterFactory'.check(require 'AIType'.Dance_Type, DanceMonster)

return DanceMonster