local ForwardMonster = class(require 'MonsterPlayer')

local CfgHelper = require 'CfgHelper'
local AtkSteps = CfgHelper.getCache('BattleSetConfig', 'Key', 'rushatktimes', 'Value') or 5

function ForwardMonster:ctor()
	-- body
end

function ForwardMonster:runMonsterBigSkill()
	local basicAttackTimes = self:getBasicAttackTimes()
	local bigSkillTimes = self:getBigSkillTimes()

	local step = AtkSteps

	if basicAttackTimes >= (bigSkillTimes+1)*step then
		return self:startToBigSkill()
	end
end


require 'MonsterFactory'.check(require 'AIType'.Forward_Type, ForwardMonster)

return ForwardMonster