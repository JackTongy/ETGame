local EventCenter 			= require 'EventCenter'
local Broadcast 			= require 'framework.net.Broadcast'
local FightEvent 			= require 'FightEvent'
local Utils 				= require 'framework.helper.Utils'
local FightTimer 			= require 'FightTimer'
local RolePlayerManager 	= require 'RolePlayerManager'
local SkillChainManager 	= require 'SkillChainManager'
local RoleSelfManager 		= require 'RoleSelfManager'
local SkinManager 			= require 'SkinManager'
local ActionCameraFactory 	= require 'ActionCameraFactory'
local TimerHelper 			= require 'framework.sync.TimerHelper'
local FightSettings 		= require 'FightSettings'
local TimeOutManager 		= require "TimeOut"
local Swf 					= require 'framework.swf.Swf'
local CfgHelper 			= require 'CfgHelper'
local StringViewHelper 		= require 'StringViewHelper'
local SelectHeroProxy 		= require 'SelectHeroProxy'
local MusicHelper 			= require 'framework.helper.MusicHelper'

local FakeReleaseSkill = class()

function FakeReleaseSkill:ctor()
	self:init()
end

function FakeReleaseSkill:init()
	-- body
	EventCenter.addEventFunc(FightEvent.Pve_TriggerBigSkill, function ( data )
		-- body
		local playerId = data.playerId
		assert(playerId)

		-- 判断mana是否足够
		local ServerController = require 'ServerController'
		local serverRole = ServerController.findRoleByDyIdAnyway(playerId)

		if serverRole and not serverRole:isDisposed() then

			local manaStep = require 'ManaManager'.ManaStep
			local mana = serverRole:getMana()
			-- manaStep = 0

			if mana >= manaStep or AlwaysSkill or serverRole:isMonster() then
				local player = require 'RolePlayerManager'.getPlayer(playerId)
				if player then
					EventCenter.eventInput( FightEvent.Pve_SubMana, { playerId = playerId } )

					local info = self:playerId2Info(playerId)
					if info then
						if info.player and info.player:isOwnerTeam() then
							-- self:setSkillLocked()
							-- self:setTouchable(true)
							-- self:showSkill(info)
						end
						EventCenter.eventInput(FightEvent.ReleaseSkill, { skillId=info.skillId, dyId=info.playerId } )
					end
				end
				
			end
		end
	end)
end

function FakeReleaseSkill:playerId2Info( playerId )
	-- body
	local player = require 'RolePlayerManager'.getPlayer(playerId)
	if player then
		local roleDyVo = player.roleDyVo
		local info = {}
		info.dyId 				= roleDyVo.dyId
		info.skillId 			= roleDyVo.skill_id
		info.career 			= roleDyVo.bigCategory
		info.playerId 			= roleDyVo.playerId
		info.player 			= player 

		info.duanWei 			= require 'ServerController'.getManaPointByDyId(playerId)
		assert(info.duanWei)

		local charactorBasicVo 	= CfgHelper.getCache('charactorConfig', 'id', roleDyVo.basicId)
		info.career 			= charactorBasicVo.atk_method_system
		info.charactorId 		= roleDyVo.basicId

		local skillVo 			= CfgHelper.getCache('skill', 'id', math.abs(info.skillId))
		assert(skillVo)
		info.skillName 			= skillVo.name
		info.point 				= skillVo.point

		return info
	end
end

return FakeReleaseSkill.new()