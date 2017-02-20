SkillDyVo=class()

function SkillDyVo:ctor( )
	self.skillBasicVo=nil
	self._preTime = require 'FightTimer'.currentFightTimeMillis()
end

function SkillDyVo:updateCD(  )
	self._preTime = require 'FightTimer'.currentFightTimeMillis()
end

---无cd概念
function SkillDyVo:canTrigger(  )
	return true 
end