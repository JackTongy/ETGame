--[[
管理所有的角色玩家
]]
local CharactorConfigBasicManager 	= require 'CharactorConfigBasicManager'
local SkillUtil 					= require 'SkillUtil'
local TypeRole 						= require 'TypeRole'
local RoleSelfManager 				= require 'RoleSelfManager'
local SkillBasicManager 			= require 'SkillBasicManager'
local YFMath 						= require 'YFMath'
local GridManager 					= require 'GridManager'
local Random 						= require 'Random'
local CfgHelper 					= require 'CfgHelper'


local RolePlayerManager={}
local _dict = {}
local _dictSorted = {}
-- local _deadDict = {}
local _size = 0

--己方英雄角色 
local _ownPlayerDict = {}
local _ownPlayerDictSorted = {}

--敌方英雄
local _otherPlayerDict = {}
local _otherPlayerDictSorted = {}

local _fightFinish = false

local function sortDict()
	-- body
	_dictSorted = {}
	_ownPlayerDictSorted = {}
	_otherPlayerDictSorted = {}

	for i,v in pairs(_dict) do
		table.insert(_dictSorted, v)
	end

	for i,v in pairs(_ownPlayerDict) do
		table.insert(_ownPlayerDictSorted, v)
	end

	for i,v in pairs(_otherPlayerDict) do
		table.insert(_otherPlayerDictSorted, v)
	end

	table.sort(_dictSorted, function ( p1, p2 )
		-- body
		if p1 and p2 then
			return p1.roleDyVo.playerId < p2.roleDyVo.playerId
		end
	end)

	table.sort(_ownPlayerDictSorted, function ( p1, p2 )
		-- body
		if p1 and p2 then
			return p1.roleDyVo.playerId < p2.roleDyVo.playerId
		end
	end)

	table.sort(_otherPlayerDictSorted, function ( p1, p2 )
		-- body
		if p1 and p2 then
			return p1.roleDyVo.playerId < p2.roleDyVo.playerId
		end
	end)
end


local function findHead( arr, compare )
	-- body
	-- assert(arr)
	-- assert(compare)

	local ret = arr[1]
	local len = #arr
	for i=2, len do
		local test = arr[i]
		if compare(test, ret) then
			ret = test
		end
	end

	return ret
end

function RolePlayerManager.reset()
	_fightFinish=false
	_ownPlayerDict = {}
	_otherPlayerDict = {}
	_dict = {}
	_size = 0

	sortDict()
end

--战斗 是否已经完成
function RolePlayerManager.isFightFinish( )
	return _fightFinish
end

function RolePlayerManager.addPlayer(player)
	if player  then
		if not _dict[player.roleDyVo.playerId] then
			print('addPlayer '..player.roleDyVo.playerId)

			_dict[player.roleDyVo.playerId]=player
			_size = _size+1

			if player.roleDyVo.dyId == RoleSelfManager.dyId then
				_ownPlayerDict[player.roleDyVo.playerId]=player
			else
				-- assert(false)
				_otherPlayerDict[player.roleDyVo.playerId]=player
			end

			sortDict()
		end
	end
end

function RolePlayerManager.removePlayer(player)
	if _dict[player.roleDyVo.playerId] then
		_size=_size-1

		-- _deadDict[player.roleDyVo.playerId] = player
		print('removePlayer '..player.roleDyVo.playerId)
	end

	_dict[player.roleDyVo.playerId]=nil
	_otherPlayerDict[player.roleDyVo.playerId]=nil
	_ownPlayerDict[player.roleDyVo.playerId]=nil

	sortDict()
end

function RolePlayerManager.getPlayer(playerId )
	return _dict[playerId]
end

function RolePlayerManager.getPlayerPos(playerId )
	local player = _dict[playerId] 
	-- or _deadDict[playerId]
	-- assert(player)
	if player then
		return player:getPosition()
	end
end




function RolePlayerManager.usablePlayer( player )
	if player:isDisposed() ==false then
		return true
	end
	return false
end

--玩家是否已经死亡
function RolePlayerManager.canFightPlayer( player )
	if player then
		if not player:isDisposed() and not player:isDead() then
			return true
		end
	end
	return false

	-- return true
end

function RolePlayerManager.getPlayerMap()
	return _dict
end

function RolePlayerManager.getPlayerMapSorted()

	return _dictSorted
end

--己方英雄
function RolePlayerManager.getOwnPlayerMap(  )
	return _ownPlayerDict
end

function RolePlayerManager.getOwnPlayerMapSorted(  )
	return _ownPlayerDictSorted
end

--敌方英雄
function RolePlayerManager.getOtherPlayerMap(  )
	return _otherPlayerDict
end

--敌方英雄
function RolePlayerManager.getOtherPlayerMapSorted(  )
	return _otherPlayerDictSorted
end

--player是否是Hero
function RolePlayerManager.isHero( player )
	if player then
		if _ownPlayerDict[player.roleDyVo.playerId] then
			return true
		end
	end
	return false
end

--战斗结束 停掉所有的战斗UI
--停止pvp的ai
function RolePlayerManager.stopPVPAllAI(  )
	for key,player in pairs(_ownPlayerDict) do
		player:stopAI()
	end
	_fightFinish=true
end
--停止pve的 包括人物和怪物的ai
function RolePlayerManager.stopPVEAllAI(  )
	for key,player in pairs(_dict) do
		player:stopAI()
	end
	_fightFinish=true
end

function RolePlayerManager.stopAll()
	local ActionUtil = require 'ActionUtil'

	for key,player in pairs(_dict) do
		player:stopAI()
		player:stopMove()
		player:play( ActionUtil.Action_NoramlStand )
	end
end

--主角方是否存在远程
function RolePlayerManager.hasYuanChengInSelfRoles()
	for k,player in pairs(_ownPlayerDict) do
		local charactorConfigBssicVo = CharactorConfigBasicManager.getCharactorBasicVo(player.roleDyVo.basicId)
		if charactorConfigBssicVo.atk_method_system==TypeRole.Career_YuanCheng then
			return true
		end
	end
end

--寻找正在移动的怪物

--能否触发技能
function RolePlayerManager.canTriggerSkill(hero, skillBasicVo, target )
	assert(hero and skillBasicVo and target)

	---如果有隐形单位
	if not target:isBodyVisible() then
		if hero:isMonster() ~= target:isMonster() then
			if skillBasicVo.skilltype < 10 then
				return false
			end
		end
	end

	if skillBasicVo.target==SkillUtil.SkillTarget_Self then
		if hero.roleDyVo.playerId==target.roleDyVo.playerId  then
			return true
		end
	elseif skillBasicVo.target == SkillUtil.SkillTarget_FriendExceptSelf then
		-- debug.catch(true, 'SkillTarget_FriendExceptSelf')
		if hero.roleDyVo.dyId==target.roleDyVo.dyId and hero.roleDyVo.playerId ~=target.roleDyVo.playerId  then

			return true
		else
			-- debug.catch(true, 'SkillTarget_FriendExceptSelf self')
			return false
		end

	elseif skillBasicVo.target==SkillUtil.SkillTarget_Friend then
		if hero.roleDyVo.dyId==target.roleDyVo.dyId then
			return true
		end
	elseif skillBasicVo.target==SkillUtil.SkillTarget_FirstEnemy then
		if hero.roleDyVo.dyId~=target.roleDyVo.dyId then
			return true
		end
	elseif skillBasicVo.target==SkillUtil.SkillTarget_Enemy then
		if hero.roleDyVo.dyId~=target.roleDyVo.dyId then
			return true
		end
	elseif skillBasicVo.target==SkillUtil.SkillTarget_System then
		return true

	elseif skillBasicVo.target==SkillUtil.SkillTarget_RandomEnemy then
		if hero.roleDyVo.dyId~=target.roleDyVo.dyId then
			return true
		end
	elseif skillBasicVo.target==SkillUtil.SkillTarget_LastEnemy then
		if hero.roleDyVo.dyId~=target.roleDyVo.dyId then
			return true
		end

	elseif skillBasicVo.target==SkillUtil.SkillTarget_CurrentTarget then
		if hero.roleDyVo.dyId~=target.roleDyVo.dyId then
			return true
		end
	elseif skillBasicVo.target==SkillUtil.SkillTarget_ZhanshiExceptSelf then
		if hero.roleDyVo.playerId ~=target.roleDyVo.playerId then
			local charactorConfigBssicVo = CharactorConfigBasicManager.getCharactorBasicVo(target.roleDyVo.basicId)
			if charactorConfigBssicVo.atk_method_system==TypeRole.Career_ZhanShi or charactorConfigBssicVo.atk_method_system==TypeRole.Career_QiShi then
				return true
			end
		end

	elseif skillBasicVo.target==SkillUtil.SkillTarget_YuanChengExceptSelf then
		if hero.roleDyVo.playerId ~=target.roleDyVo.playerId then
			local charactorConfigBssicVo = CharactorConfigBasicManager.getCharactorBasicVo(target.roleDyVo.basicId)
			if charactorConfigBssicVo.atk_method_system==TypeRole.Career_YuanCheng then
				return true
			end
		end

	elseif skillBasicVo.target==SkillUtil.SkillTarget_All_Friend_Physics then
		if hero.roleDyVo.dyId==target.roleDyVo.dyId then
			local charactorConfigBssicVo = CharactorConfigBasicManager.getCharactorBasicVo(target.roleDyVo.basicId)
			if charactorConfigBssicVo.atk_method_system==TypeRole.Career_ZhanShi or charactorConfigBssicVo.atk_method_system==TypeRole.Career_QiShi then
				return true
			end
		end
	elseif skillBasicVo.target == SkillUtil.SkillTarget_All_Enemy_Physics then
		if hero.roleDyVo.dyId~=target.roleDyVo.dyId then
			local charactorConfigBssicVo = CharactorConfigBasicManager.getCharactorBasicVo(target.roleDyVo.basicId)
			if charactorConfigBssicVo.atk_method_system==TypeRole.Career_ZhanShi or charactorConfigBssicVo.atk_method_system==TypeRole.Career_QiShi then
				return true
			end
		end
	elseif skillBasicVo.target==SkillUtil.SkillTarget_All_Friend_Magic then
		if hero.roleDyVo.dyId==target.roleDyVo.dyId then
			local charactorConfigBssicVo = CharactorConfigBasicManager.getCharactorBasicVo(target.roleDyVo.basicId)
			if charactorConfigBssicVo.atk_method_system~=TypeRole.Career_ZhanShi and charactorConfigBssicVo.atk_method_system~=TypeRole.Career_QiShi then
				return true
			end
		end
	elseif skillBasicVo.target==SkillUtil.SkillTarget_AllEnemyAndSelf then
		if hero.roleDyVo.dyId ~= target.roleDyVo.dyId or hero.roleDyVo.playerId == target.roleDyVo.playerId then
			return true
		end
	elseif skillBasicVo.target==SkillUtil.SkillTarget_MinHp then
		if hero.roleDyVo.dyId==target.roleDyVo.dyId then
			return true
		end
	elseif skillBasicVo.target==SkillUtil.SkillTarget_All_Enemy_CureRemote then
		if hero.roleDyVo.dyId~=target.roleDyVo.dyId then
			local charactorConfigBssicVo = CharactorConfigBasicManager.getCharactorBasicVo(target.roleDyVo.basicId)
			if charactorConfigBssicVo.atk_method_system==TypeRole.Career_YuanCheng or charactorConfigBssicVo.atk_method_system==TypeRole.Career_ZiLiao then
				return true
			end
		end
	elseif skillBasicVo.target==SkillUtil.SkillTarget_All_Enemy_HighterQual then
		if hero.roleDyVo.dyId~=target.roleDyVo.dyId then
			local selfBasicVo = CharactorConfigBasicManager.getCharactorBasicVo(hero.roleDyVo.basicId)
			local charactorConfigBssicVo = CharactorConfigBasicManager.getCharactorBasicVo(target.roleDyVo.basicId)
			if charactorConfigBssicVo.quality >= selfBasicVo.quality then
				return true
			end	
		end
	elseif skillBasicVo.target==SkillUtil.SkillUtil.SkillTarget_All_Enemy_LowerQual then
		if hero.roleDyVo.dyId~=target.roleDyVo.dyId then
			local selfBasicVo = CharactorConfigBasicManager.getCharactorBasicVo(hero.roleDyVo.basicId)
			local charactorConfigBssicVo = CharactorConfigBasicManager.getCharactorBasicVo(target.roleDyVo.basicId)
			if charactorConfigBssicVo.quality <= selfBasicVo.quality then
				return true
			end	
		end
	else
		return true
	end

	return false
end

function RolePlayerManager.isInRange( player, skillBasicVo, otherPlayer )
	-- body
	assert(player)
	assert(skillBasicVo)
	assert(otherPlayer)

	if RolePlayerManager.canTriggerSkill(player, skillBasicVo, otherPlayer) then
		if skillBasicVo.shapes == SkillUtil.Type_Circle then -- 如果是圆形检测的近战技能
			if player:isInEllipse2(skillBasicVo, otherPlayer) then
				return true
			end
		elseif skillBasicVo.shapes == SkillUtil.Type_Line then    --  如果是直线检测
			if player:isInLine(skillBasicVo, otherPlayer) then   --  远程攻击
				return true
			end
		elseif skillBasicVo.shapes == SkillUtil.Type_Line2 then
			if player:isInLine2(skillBasicVo, otherPlayer) then   --  远程攻击
				return true
			end
		else
			assert(false)
		end
	end
end

-- 符合范围 + 条件
-- 
function RolePlayerManager.getSelectTargetArray( player, skillBasicVo, needSort )
	-- body
	assert(player)
	assert(skillBasicVo)

	local arr = {}
	local playerMap = RolePlayerManager.getPlayerMapSorted()
	for i, target in ipairs(playerMap) do
		if RolePlayerManager.isInRange(player, skillBasicVo, target) then
			-- 如果是治疗的话
			if skillBasicVo.skilltype == SkillUtil.SkillType_ZiLiao then
				if target.roleDyVo.hpPercentReal < 100 then
					table.insert(arr, target)
				end
			elseif skillBasicVo.skilltype == SkillUtil.SkillType_DaZhaoZhiLiao then
				table.insert(arr, target)
			else
				table.insert(arr, target)
			end
		end
	end

	if needSort then
		if skillBasicVo.shapes == SkillUtil.Type_Circle or skillBasicVo.shapes == SkillUtil.Type_Line2 then
			table.sort(arr, function (firstPlayer, secondPlayer)
				-- body
				return YFMath.quick_distance2(firstPlayer, player) < YFMath.quick_distance2(secondPlayer, player)
			end)
		elseif skillBasicVo.shapes == SkillUtil.Type_Line then 
			local flagLittle = (RoleSelfManager.getFlipX() > 0 and not (player:isMonster() or player:isOtherPlayer()) ) or 
			(RoleSelfManager.getFlipX() < 0 and (player:isMonster() or player:isOtherPlayer()) )

			table.sort(arr, function (firstPlayer, secondPlayer)
				-- body
				if flagLittle then
					return firstPlayer:getMapX() > secondPlayer:getMapX()
				else
					return firstPlayer:getMapX() < secondPlayer:getMapX()
				end
			end)
		-- elseif  then 

		end
	end
	
	return arr
end

function RolePlayerManager.findMinHpFriend( player, skillBasicVo )
	-- body
	assert(player)
	assert(skillBasicVo)

	local selectArr = RolePlayerManager.getSelectTargetArray(player, skillBasicVo, false)
	return findHead(selectArr, function ( firstPlayer, secondPlayer )
		-- body
		return firstPlayer.roleDyVo.hpPercent < secondPlayer.roleDyVo.hpPercent
	end)


	-- table.sort(selectArr, function ( firstPlayer, secondPlayer )
	-- 	-- body
	-- 	return firstPlayer.roleDyVo.hpPercent < secondPlayer.roleDyVo.hpPercent
	-- end)
	-- return selectArr[1]
end

-- 等确认??
function RolePlayerManager.findLastEnemy( player, skillBasicVo )
	-- body
	assert(player)
	assert(skillBasicVo)

	local selectArr = RolePlayerManager.getSelectTargetArray(player, skillBasicVo, false)

	local flagLittle = (RoleSelfManager.getFlipX() > 0 and not (player:isMonster() or player:isOtherPlayer())) or 
	(RoleSelfManager.getFlipX() < 0 and (player:isMonster() or player:isOtherPlayer()))

	return findHead(selectArr, function(firstPlayer, secondPlayer)   --从大到小
		if flagLittle then
			return firstPlayer:getMapX() < secondPlayer:getMapX()
		else
			return firstPlayer:getMapX() > secondPlayer:getMapX()
		end
	end)

	-- table.sort(selectArr, function(firstPlayer, secondPlayer)   --从大到小
	-- 	if flagLittle then
	-- 		return firstPlayer:getMapX() < secondPlayer:getMapX()
	-- 	else
	-- 		return firstPlayer:getMapX() > secondPlayer:getMapX()
	-- 	end
	-- end)

	-- return selectArr[1]
end

-- 给player的ai用
function RolePlayerManager.getTargetArrayByPlayerAndSkill(player, skillBasicVo, defaultEnemy)
	assert(player)
	assert(skillBasicVo)

	local playerId = player.roleDyVo.playerId
	local skillId = skillBasicVo.id
	local enemyId = (defaultEnemy and defaultEnemy.roleDyVo.playerId)
	
	local idArray = RolePlayerManager.getTargetIdArrayByPlayerIdAndSkillId(playerId, skillId, enemyId)

	local targetArr = {}
	for _i, playerId in ipairs(idArray) do
		local target = RolePlayerManager.getPlayer(playerId)
		if target then
			table.insert(targetArr, target)
		end
	end
	return targetArr
end

-- 主动,被动技能都通用
function RolePlayerManager.getTargetIdArrayByPlayerIdAndSkillId(playerId, skillId, defaultEnemyId)
	-- body
	local player = RolePlayerManager.getPlayer(playerId)
	local skillBasicVo = SkillBasicManager.getSkill(skillId)

	-- 
	if not player then
		return {}
	end

	assert(player, playerId)
	assert(skillBasicVo, skillId)

	local arr = {}
	
	if skillBasicVo.target == SkillUtil.SkillTarget_System then
		table.insert(arr,-1)
		return arr
	else
		-- 默认近战的情况
		if skillBasicVo.skilltype == SkillUtil.SkillType_JinZhan or skillBasicVo.skilltype == SkillUtil.SkillType_YuanChengJinZhan then
			local defaultEnemy = (defaultEnemyId and RolePlayerManager.getPlayer(defaultEnemyId))
			if defaultEnemy and RolePlayerManager.isInRange(player,skillBasicVo, defaultEnemy) then
				table.insert(arr, defaultEnemyId)
			end
			return arr
		end

		local effect_type
		if skillBasicVo.skilltype >= 10 then
			effect_type = CfgHelper.getCache('roleEffect', 'handbook', player.roleDyVo.basicId).effect_type
		else
			effect_type = skillBasicVo.effect_type
		end
		assert(effect_type)

		-- 远程不需要立即的目标
		-- 飞行道具的
		if effect_type == SkillUtil.fightType_2 then
			return arr
		end

		-- SkillUtil.SkillTarget_Self = 1 					-- 自身
		-- SkillUtil.SkillTarget_FriendExceptSelf = 3  		-- 友军 不包含自己
		-- SkillUtil.SkillTarget_Friend = 4  				-- 友军 包含自己
		-- SkillUtil.SkillTarget_FirstEnemy = 5  			-- 第一名敌军
		-- SkillUtil.SkillTarget_Enemy = 7  				-- 所有敌军
		-- SkillUtil.SkillTarget_System = 8 				-- 添加给系统的
		-- SkillUtil.SkillTarget_RandomEnemy = 9 			-- 随机敌军
		-- SkillUtil.SkillTarget_LastEnemy = 11 			-- 正前方最后一名敌军
		-- SkillUtil.SkillTarget_CurrentTarget = 12 		-- 当前目标
		-- SkillUtil.SkillTarget_ZhanshiExceptSelf = 13	 	-- 除自身外的我方战士
		-- SkillUtil.SkillTarget_YuanChengExceptSelf = 14 	-- 除自身外的我方远程
		-- SkillUtil.SkillTarget_MinHp = 15 				-- 我方血量最低的角色
		-- SkillUtil.SkillTarget_AllEnemyAndSelf = 16 		-- 自己和区域内所有敌军
		-- SkillUtil.SkillTarget_All_Friend_Physics = 17  	-- 战士,骑士
		-- SkillUtil.SkillTarget_All_Friend_Magic = 18 		-- 法师,牧师

		-- 符合条件, 范围判断, 优先级排序
		-- SkillTarget_MinHp, SkillTarget_LastEnemy, 
		if skillBasicVo.target == SkillUtil.SkillTarget_Self then
			table.insert(arr, playerId)
			return arr
		elseif skillBasicVo.target == SkillUtil.SkillTarget_MinHp then
			local target = RolePlayerManager.findMinHpFriend( player, skillBasicVo )
			if target then
				table.insert(arr, target.roleDyVo.playerId)
			end
			return arr
		elseif skillBasicVo.target == SkillUtil.SkillTarget_LastEnemy then
			local target = RolePlayerManager.findLastEnemy( player, skillBasicVo )
			if target then
				table.insert(arr, target.roleDyVo.playerId)
			end
			return arr
		elseif skillBasicVo.target == SkillUtil.SkillTarget_RandomEnemy then
			local selectArr = RolePlayerManager.getSelectTargetArray(player, skillBasicVo)
			local maxTimes = (skillBasicVo.repeatN)
			for i=1, maxTimes do
				local index = Random.ranI(1, #selectArr)
				local roleDyVo = selectArr[index] and selectArr[index].roleDyVo
				if roleDyVo then
					table.insert(arr, roleDyVo.playerId )
				end
			end
			return arr
		elseif skillBasicVo.target == SkillUtil.SkillTarget_FirstEnemy then
			local target = nil
			local defaultEnemy = (defaultEnemyId and RolePlayerManager.getPlayer(defaultEnemyId))
			if defaultEnemy and RolePlayerManager.isInRange(player,skillBasicVo, defaultEnemy) then
				target = defaultEnemy
			else
				local selectArr = RolePlayerManager.getSelectTargetArray(player, skillBasicVo, true)
				target = selectArr[1]
			end

			if target then
				local maxTimes = (skillBasicVo.repeatN)
				for i=1, maxTimes do
					table.insert(arr, target.roleDyVo.playerId)
				end
			end
			return arr
		else
			local selectArr = RolePlayerManager.getSelectTargetArray(player, skillBasicVo, true)

			local maxPerTime = math.min(skillBasicVo.maxnum, #selectArr)

			for i=1, skillBasicVo.repeatN do
				for j=1, maxPerTime do

					if #arr >= skillBasicVo.maxnum then
						break
					end

					table.insert(arr, selectArr[j].roleDyVo.playerId)
				end
			end
		end
	end

	return arr
end


--返回使用该技能影响的玩家列表 
--被动技能
function RolePlayerManager.getPlayerbySkill( playerId, skillId, defaultNum, defaultEnemy )

	return RolePlayerManager.getTargetIdArrayByPlayerIdAndSkillId( playerId, skillId )
end

--[[
优先选择 exceptPlayer
--]]
function RolePlayerManager.getPlayerbySkill2(hero, skillId, num, exceptPlayer )
	assert(false)

	local idArray = RolePlayerManager.getPlayerbySkill(hero and hero.roleDyVo.playerId, skillId, num, exceptPlayer)
	local playerArray = {}
	if idArray then
		for i,v in ipairs(idArray) do
			table.insert(playerArray, RolePlayerManager.getPlayer(v) )
		end
	end
	return playerArray
end

function RolePlayerManager.getSize(  )
	return _size
end


--检测怪物这一条线 是否存在玩家
function RolePlayerManager.cheMonsterLineHasPlayer(monster)
	local monsterCenter = GridManager.getUICenterByPos(monster:getPosition())
	local playerArr = RolePlayerManager.getOwnPlayerMap()
	local playerPos 
	for k,player in pairs(playerArr) do
		playerCenter = GridManager.getUICenterByPos(player:getPosition())
		if playerCenter.y == monsterCenter.y then
			return true
		end
	end
	return false
end

return RolePlayerManager
