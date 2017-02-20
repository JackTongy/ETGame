---加速参数
local RoleSelfManager = require "RoleSelfManager"
local Accelerate = {}

Accelerate.rate = 1.5

--获取当前的加速比例  不加速的是 1 
function Accelerate.getCurrentRate()
	-- body
	if not  RoleSelfManager.isPvp  then 		 --不为pvp  也就是为pve
		if Accelerate.getAccelerate() then
			return Accelerate.rate
		end
	end
	return 1
end

--是否加速
function Accelerate.getAuto()
	return require 'FightConfig'.Auto_AI
end

function Accelerate.getAccelerate()
	return require 'FightConfig'.Accelerate 
end


return Accelerate
