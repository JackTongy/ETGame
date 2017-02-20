local CfgHelper = require 'CfgHelper'
local RolePlayerManager = require 'RolePlayerManager'

local SelectHeroProxy = {}


function SelectHeroProxy.setSelectPlayer( player )
	-- body
	SelectHeroProxy._selectPlayer = player
end

function SelectHeroProxy.getSelectPlayer()
	-- body
	return SelectHeroProxy._selectPlayer
end

function SelectHeroProxy.getDefaultPlayer()
	-- body

	-- 默认的
	local default 

	local map = RolePlayerManager.getOwnPlayerMap()
	if map then
		for i,player in pairs(map) do
			if not player:isDisposed() then
				if not default then
					default = player
				else
					if player.roleDyVo.dyId < default.roleDyVo.dyId then
						default = player
					end
				end
			end
		end
	end

	return default
end

-- function SelectHeroProxy.getAllHero( )
-- 	-- body
-- end

--[[
dyId
skillId
skillName
point
career

--]]
function SelectHeroProxy.getSelectPlayerInfo()
	-- body
	local player = SelectHeroProxy._selectPlayer

	if not player or player:isDisposed() then 
		player = SelectHeroProxy.getDefaultPlayer()
	end

	if player and not player:isDisposed() then
		local roleDyVo = player.roleDyVo

		local info = {}
		info.dyId 		= roleDyVo.dyId
		info.skillId 	= roleDyVo.skill_id
		info.career 	= roleDyVo.bigCategory
		info.playerId 	= roleDyVo.playerId
		
		info.player = player 

		local charactorBasicVo = CfgHelper.getCache('charactorConfig', 'id', roleDyVo.basicId)
		info.career 	= charactorBasicVo.atk_method_system
		info.charactorId = roleDyVo.basicId

		local skillVo 	= CfgHelper.getCache('skill', 'id', math.abs(info.skillId))
		assert(skillVo)

		info.skillName 	= skillVo.name
		info.point 		= skillVo.point

		return info
	end

	-- return SelectHeroProxy.getDefaultPlayer()
end



return SelectHeroProxy