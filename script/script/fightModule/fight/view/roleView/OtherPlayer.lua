
-- 其他玩家
local TypeRole = require 'TypeRole'

local AbsPlayer = require 'AbsPlayer'

--[[
pvp
--]]

local OtherPlayer=class(AbsPlayer)

function OtherPlayer:isOtherPlayer()
	-- body
	return true
end

return OtherPlayer




