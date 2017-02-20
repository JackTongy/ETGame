local HeroPromoteVo = class()

function HeroPromoteVo:ctor()
	-- body
	self.name = '皮卡丘'
	self.star = 5
	self.charactorId = 110
	self.level = { 10, 15 }
	self.hp = {200, 300}
	self.atk = {100, 200}

	self.potential = 1 --潜力点
end

return HeroPromoteVo