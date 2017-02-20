--[[
控制动画的方向  
目前是 单方向的  
]]
local actionManager=require 'ActionUtil'

local function getDireciton(startX,endX )
	local direction =actionManager.Direction_Left    --2
	if endX >startX then
		direction = actionManager.Direction_Right --1
	elseif endX <startX then
		direction=actionManager.Direction_Left  --2
	else
		direction = -1
	end
	return direction
end

return {getDireciton=getDireciton}