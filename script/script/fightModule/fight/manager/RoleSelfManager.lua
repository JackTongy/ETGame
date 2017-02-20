
--[[
主角玩家的信息
]]
local ActionUtil = require 'ActionUtil'
local RoleSelfManager = {}

--当前玩具的动态id 
RoleSelfManager.dyId 		= 1
RoleSelfManager.otherDyId 	= -1
--这场战斗是pvp还是pve
RoleSelfManager.isPvp		= false
--当前玩具再屏幕中的站位 是再左边还是再右边
RoleSelfManager.isLeft		= false



--获得回归站位时候应该站立的方向
function RoleSelfManager.getHeroBackStandDir(  )
	if RoleSelfManager.isLeft then
		return ActionUtil.Direction_Right
	else --站在右边 面朝左边
		return ActionUtil.Direction_Left
	end
end

--其他角色  怪物的回归时的站位
function RoleSelfManager.getOtherRoleBackStandDir(  )
	if RoleSelfManager.isLeft then
		return ActionUtil.Direction_Left
	else --站在右边 面朝左边
		return ActionUtil.Direction_Right
	end
end

--获得回归站位时候应该站立的方向
function RoleSelfManager.getPlayerBackStandDir( player )
	assert(player)
	
	local isHero = not (player:isMonster() or player:isOtherPlayer())
	if isHero then
		return RoleSelfManager.getHeroBackStandDir()
	else
		return RoleSelfManager.getOtherRoleBackStandDir()
	end
end

function RoleSelfManager.getAITime(  )
	if RoleSelfManager.isPvp then
		return 250
	else
		return 0
	end
end

--获取游戏的翻转
function RoleSelfManager.getFlipX( )
	-- body
	if RoleSelfManager.isLeft then
		return -1
	else
		return 1
	end
	return 1
end

function RoleSelfManager.isSelfOnRight()
	-- body
	return not RoleSelfManager.isLeft
end

return RoleSelfManager