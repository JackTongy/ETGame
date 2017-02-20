-- 其他玩家
local TypeRole = require 'TypeRole'

local AbsPlayer = require 'AbsPlayer'
local HeroPlayer = require 'HeroPlayer'
local MonsterPlayer = require 'MonsterPlayer'
local SelfAIPlayer = require 'SelfAIPlayer'
--[[
竞技场
--]]

local OtherAIPlayer = class( SelfAIPlayer )

function OtherAIPlayer:ctor(  )
	-- body
	-- assert(false)
end

--[[
AI
--]]

function OtherAIPlayer:isOtherPlayer()
	-- body
	return true
end

function OtherAIPlayer:isMonster()
	-- body
	return true
end

return OtherAIPlayer