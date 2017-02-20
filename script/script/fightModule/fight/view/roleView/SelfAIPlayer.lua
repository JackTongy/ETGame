local AbsPlayer 					= require 'AbsPlayer'
local RoleDyVo 						= require 'RoleDyVo'
local YFMath 						= require 'YFMath'
local EventCenter 					= require 'EventCenter'
local MessageSendManager 			= require 'BattleUpdateToNet'
local FightEvent 					= require 'FightEvent'
local SkillBasicManager 			= require 'SkillBasicManager'
local CharactorConfigBasicManager 	= require 'CharactorConfigBasicManager'
local FightTimer 					= require 'FightTimer'
local RolePlayerManager 			= require 'RolePlayerManager'
local GridManager 					= require 'GridManager'
local SkillUtil 					= require 'SkillUtil'
local RoleSelfManager 				= require 'RoleSelfManager'
local TypeRole 						= require 'TypeRole'
local Utils 						= require "framework.helper.Utils"
local Accelerate 					= require "Accelerate"
local FightTimer 					= require "FightTimer"
local TimeOutManager 				= require "TimeOut"
local SpecailManager 				= require "SpecailManager"
local DirectionUtil 				= require "DirectionUtil"
local ActionUtil 					= require 'ActionUtil'
local CfgHelper 					= require 'CfgHelper'
local UpdateRate 					= require 'UpdateRate'
local FightView 					= require 'FightView'

local Career_CD = {
	[TypeRole.Career_ZhanShi] 	= 1500,
	[TypeRole.Career_QiShi] 	= 1750,
	[TypeRole.Career_YuanCheng] = 2000,
	[TypeRole.Career_ZiLiao] 	= 2000,
}

local HeroPlayer = require 'HeroPlayer'

--[[
竞技场
--]]
local SelfAIPlayer = class( HeroPlayer )

function SelfAIPlayer:ctor()
	-- body
end

-- 战士, 法师, 治疗
-- 
function SelfAIPlayer:handleAI()
	self:runArenaAILoop()
end

-- access.isManaFull

function SelfAIPlayer:isOtherPlayer()
	-- body
	return false
end

function SelfAIPlayer:isMonster()
	-- body
	return false
end


return SelfAIPlayer




