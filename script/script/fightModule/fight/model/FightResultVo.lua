local FightResultVo = class()

function FightResultVo:ctor()
	-- body

	self.condition = { 1, 0, 1 }

	self.addMoney = 150
	self.totalMoney = 1000

	self.addExp = 234
	self.totalExp = 1800
	self.nextExp = 2400 --下一个等级的经验值

end

return FightResultVo