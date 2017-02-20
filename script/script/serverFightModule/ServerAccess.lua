local access = {}

local RolePlayerManager = require 'RolePlayerManager'

function access.select( roleid, skillid )
	-- body
	local ret = RolePlayerManager.getPlayerbySkill( roleid, skillid )
	return ret
end

function access.getPositionByRoleDyId( roleid )
	-- body
	return RolePlayerManager.getPlayerPos( roleid )
end

function access.getManaRateById( roleid )
	-- body
	local role = require 'ServerController'.findRoleByDyIdAnyway(roleid)
	if role then
		return role:getManaRate()
	end
end

function access.isManaFull( roleid )
	-- body
	local role = require 'ServerController'.findRoleByDyIdAnyway(roleid)
	if role then
		return role:isManaFull()
	end
end

-- function access.isBodyVisible( roleid )
-- 	-- body
-- 	local player = RolePlayerManager.getPlayer(roleid)
-- 	if player then
-- 		return player:isBodyVisible()
-- 	end
-- end

return access