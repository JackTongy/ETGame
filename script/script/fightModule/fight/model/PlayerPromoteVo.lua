local PlayerPromoteVo = class()

function PlayerPromoteVo:ctor()
	-- body
	self.level = {10, 11}
	self.power = {110, 150} --体力
	self.powerLimit = { 150, 160 }
	self.friendLimit = { 30, 35 }
	
end

return PlayerPromoteVo