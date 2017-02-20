local SkillChainManager = {}

local Chain_Time_Max = 15000

SkillChainManager._currentTimeMillis = 0
SkillChainManager._skillArray = {}
SkillChainManager._otherSkillArray = {}

SkillChainManager.reset = function ()
	-- body
	SkillChainManager._currentTimeMillis = 0

	SkillChainManager._skillArray = {}
	SkillChainManager._otherSkillArray = {}
end

SkillChainManager.getLastTime = function ()
	-- body
	local size = #SkillChainManager._skillArray
	if size > 0 then
		local last = SkillChainManager._skillArray[size]
		return last.time
	end

	--1973
	return -(Chain_Time_Max*2)
end


-- roleid ???
SkillChainManager.actionSkill = function ( roleid )
	-- body
	--必须是大招 而且是 英雄释放的
	-- print('SkillChainManager actionSkill !'..(SkillChainManager.currentTimeMillis()))

	local ServerController = require 'ServerController'
	local owner = ServerController.findRoleByDyIdAnyway(roleid)

	if not owner then
		return false
	end

	local arrayName 
	if owner:isMonster() then
		arrayName = '_otherSkillArray'
	else
		arrayName = '_skillArray'
	end

	local time = SkillChainManager.currentTimeMillis()
	local item = { time = time, roleid = roleid }

	for i,v in ipairs(SkillChainManager[arrayName]) do
		if v.roleid == item.roleid then
			SkillChainManager[arrayName] = {}
			table.insert(SkillChainManager[arrayName], item)
			return
		end
	end

	local size = #SkillChainManager[arrayName]
	if size > 0 then
		local last = SkillChainManager[arrayName][size]

		if last.time + Chain_Time_Max >= item.time then
			table.insert(SkillChainManager[arrayName], item)
		else
			SkillChainManager[arrayName] = {}
			table.insert(SkillChainManager[arrayName], item)
		end
	else
		table.insert(SkillChainManager[arrayName], item)
	end

end

-- 确保是英雄的roleid 
-- 是否存在锁链效果
SkillChainManager.checkChain = function ( roleid )
	-- body
	local ServerController = require 'ServerController'
	local owner = ServerController.findRoleByDyIdAnyway(roleid)

	if not owner then
		return false
	end

	local arrayName 
	if owner:isMonster() then
		arrayName = '_otherSkillArray'
	else
		arrayName = '_skillArray'
	end

	local time 		= SkillChainManager.currentTimeMillis()
	local lastTime 	= SkillChainManager.getLastTime()

	if lastTime + Chain_Time_Max > time then
		for i, v in ipairs(SkillChainManager[arrayName]) do
			if v.roleid == roleid then
				return false
			end
		end
		
		return true
	end

	return false
end

SkillChainManager.getChainEffectRate = function (roleid)
	-- body
	if true then
		return 0
	end

	print('SkillChainManager getChainEffectRate !'..(SkillChainManager.currentTimeMillis()))

	local ServerController = require 'ServerController'
	local owner = ServerController.findRoleByDyIdAnyway(roleid)

	if not owner then
		return 0
	end

	local arrayName 
	if owner:isMonster() then
		arrayName = '_otherSkillArray'
	else
		arrayName = '_skillArray'
	end

	local size = #SkillChainManager[arrayName]
	if size <= 1 then
		return 0
	elseif size == 2 then
		return 0.1
	elseif size == 3 then
		return 0.2
	elseif size == 4 then
		return 0.3
	else
		return 0.5
	end
end

SkillChainManager.getChainLength = function ( roleid )
	-- body
	-- print('SkillChainManager getChainLength !'..(SkillChainManager.currentTimeMillis()))

	local ServerController = require 'ServerController'
	local owner = ServerController.findRoleByDyIdAnyway(roleid)

	if not owner then
		return 0
	end

	local arrayName 
	if owner:isMonster() then
		arrayName = '_otherSkillArray'
	else
		arrayName = '_skillArray'
	end

	if SkillChainManager.checkChain(roleid) then
		local size = #SkillChainManager[arrayName] + 1
		return size
	else
		return 0
	end
end

SkillChainManager.update = function ( dt )
	-- body
	SkillChainManager._currentTimeMillis = SkillChainManager._currentTimeMillis + (dt*1000)
end

SkillChainManager.currentTimeMillis = function ()
	-- body
	return SkillChainManager._currentTimeMillis
end

return SkillChainManager