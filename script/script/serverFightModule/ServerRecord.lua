
local ServerController = require 'ServerController'

local ServerRecord = {}
local self = {}

-- battleDetailData.LastKillWithSkill = true
-- battleDetailData.TimeSpan = 200
-- battleDetailData.Pets = {}
-- table.insert(battleDetailData.Pets, {ID = 25, PetId = 1, Hp = 10, Lv = 3})


ServerRecord.reset = function ()
	-- body
	self._currentTimeMillis = nil
	self._lastMills = 0

	self._lastSkillWithSkill = nil

	self._normalKillCount = 0
	self._skillKillCount = 0

	self._battleId = nil

	self._bossHp = nil
	self._bid = nil

	self._skillTriggerTime = -2000

	self._gameOverFlag = nil

	self._dieRoleArray = {}
	self._additionTable = nil
	-- self._battleBgType = nil
	-- self._bossCatchFlag = nil
	-- self._arenaReward = nil
	self._arenaHandler = nil
	self._exdata = nil
end

ServerRecord.setArenaSeed = function ( seed )
	self._arenaSeed = seed
end

ServerRecord.getArenaSeed = function ( seed )
	return self._arenaSeed
end

ServerRecord.setArenaBid = function ( bid )
	-- body
	self._arenaBid = bid
end

ServerRecord.getArenaBid = function ( bid )
	-- body
	return self._arenaBid
end

ServerRecord.calcTime = function ( dt )
	-- body
	self._lastMills = self._lastMills + (dt*1000)
end

ServerRecord.getTimeSpan = function (  )
	-- body
	return self._lastMills
end

ServerRecord.setLastKillWithSkill = function ( is )
	-- body
	self._lastSkillWithSkill = is
end

ServerRecord.getLastKillWithSkill = function ()
	-- body
	return self._lastSkillWithSkill or false
end

ServerRecord.setMode = function ( mode )
	-- body
	self._mode = mode
end

ServerRecord.getMode = function ()
	-- body
	return self._mode
end

ServerRecord.isArenaMode = function ()
	-- body
	return (self._mode == 'arena') or (self._mode == 'arena-record') or (self._mode == 'league') or (self._mode == 'guildmatch') or (self._mode == 'guildfuben_rob') or (self._mode == 'guildfuben_revenge') or (self._mode == 'friend')
end

ServerRecord.isLeagueMode = function ()
	-- body
	return (self._mode == 'league')
end

ServerRecord.disablePause = function ( )
	return (self._mode == 'arena') or (self._mode == 'guildmatch') or (self._mode == 'guildfuben_rob') or (self._mode == 'guildfuben_revenge') or (self._mode == 'friend')
end

-- ServerRecord.setPetList = function ( petList )
-- 	-- body

-- 	--[[
-- 	+1+cri [0]
-- 	| +atk [3129]
-- 	| +def [1100]
-- 	| +awaken [4]
-- 	| +Lv [24]
-- 	| +spd [240]
-- 	| +atktime [0]
-- 	| +intimacy [20]
-- 	| +charactorId [40]
-- 	| +ID [457]
-- 	| +PetId [40]
-- 	| +hp [1711]
-- 	| +heroid [457]
-- 	--]]

-- 	ServerRecord._petList = petList
-- end

ServerRecord.addNormalKill = function ()
	-- body
	self._normalKillCount = self._normalKillCount + 1
end

ServerRecord.addSkillKill = function ()
	-- body
	self._skillKillCount = self._skillKillCount + 1
end

ServerRecord.createGameOverData = function ( isWin )
	-- body
	local gameOverData = {}
	gameOverData.isWin = isWin

	gameOverData.mode = self._mode
	
	gameOverData.TimeSpan = ServerRecord.getTimeSpan()

	gameOverData.FinishInTime = true
	gameOverData.NoLost = true --是否有死亡
	gameOverData.LastKillWithSkill = ServerRecord.getLastKillWithSkill()
	gameOverData.Lost = 0
	---灵魂之湖
	gameOverData.Soul = nil


	----Buff ??
	-- gameOverData.Er = 0 --额外经验
	gameOverData.Gr = 0 --额外金币

	-- ServerController.getCharactorArray()
	gameOverData.Team = {}
	gameOverData.NpcTeam = {}

	gameOverData.Energys = {}

	local array = ServerController.getServerHeroArray()
	-- assert(array)
	--PVP 没有这些数据
	if array then
		for i, v in ipairs(array) do
			local item = {}

			item.petId = v:getIdentifyId()
			item.charactorId = v:getBasicId()
			item.hpP = v:getHpP()

			item.lv = v:getLevel()
			item.atk = v.atk
			item.hpD = v:getBasicHpD()

			table.insert(gameOverData.Team, item)

			gameOverData.Energys[tostring(item.petId)] = v:getMana()

			if v:getHpP() <= 0 then
				gameOverData.NoLost = false

				gameOverData.Lost = gameOverData.Lost + 1
			end
		end
	end

	local npcArray = ServerController.getServerMonsterArray()
	if npcArray then
		for i, v in ipairs(npcArray) do
			local item = {}

			item.petId = v:getIdentifyId()
			item.charactorId = v:getBasicId()
			item.hpP = v:getHpP()

			item.lv = v:getLevel()
			item.atk = v.atk
			item.hpD = v:getBasicHpD()
			item.mana = v:getMana()
			item.GH = (1 + (v:getBuffArray():getValueByKey(require 'GHType'.GH_MaxHp) or 0) + (v:getBuffArray():getValueByKey(require 'GHType'.GH_236) or 0) )
			table.insert(gameOverData.NpcTeam, item)
		end
	end

	local enemyArray = ServerController.getServerEnemyModuleArray()
	if enemyArray then
		gameOverData.EnemyTeam = {}
		for i,v in ipairs(enemyArray) do
			local item = {}
			item.petId = v:getIdentifyId()
			item.charactorId = v:getBasicId()
			item.hpP = v:getHpP()

			item.lv = v:getLevel()
			item.atk = v.atk
			item.hpD = v:getBasicHpD()
			item.mana = v:getMana()
			item.GH = (1 + (v:getBuffArray():getValueByKey(require 'GHType'.GH_MaxHp) or 0) + (v:getBuffArray():getValueByKey(require 'GHType'.GH_236) or 0) )
			table.insert(gameOverData.EnemyTeam, item)
		end
	end
	
	gameOverData.BattleId = self._battleId

	print('----gameOverData----')
	print(gameOverData)
	
	if self._arenaHandler then
		require 'FightTimer'.removeFunc(self._arenaHandler)
		self._arenaHandler = nil
	end
	require 'EventCenter'.eventInput(require 'FightEvent'.StopTimer)

	return gameOverData
end



ServerRecord.setBossHp = function ( oldHp )
	-- body
	self._bossHp = oldHp
end

ServerRecord.getBossHp = function ()
	-- body
	return self._bossHp
end

ServerRecord.setBossHpMax = function ( hpMax )
	-- body
	self._bossHpMax = hpMax
end

ServerRecord.getBossHpMax = function ()
	-- body
	return self._bossHpMax
end

ServerRecord.setBossId = function ( bid )
	-- body
	self._bid = bid
end

ServerRecord.getBossId = function ()
	-- body
	return self._bid
end


ServerRecord.setBattleId = function ( battleId )
	-- body
	self._battleId = battleId
end


ServerRecord.getBattleId = function ()
	-- body
	return self._battleId
end

ServerRecord.setSkillTriggerTime = function ( time )
	-- body
	self._skillTriggerTime = time
end

ServerRecord.getSkillTriggerTime = function ()
	-- body
	return self._skillTriggerTime
end

ServerRecord.setRandomSeed = function ( seed )
	-- body
	self._randomSeed = seed
end

ServerRecord.getRandomSeed = function ()
	-- body
	return self._randomSeed
end

ServerRecord.setArenaReward = function ( reward )
	-- body
	self._arenaReward = reward
end

ServerRecord.getArenaReward = function ()
	-- body
	return self._arenaReward
end

ServerRecord.getLeagueReward = function ()
	-- body
	return self._leagueReward
end

ServerRecord.setLeagueReward = function (reward)
	-- body
	self._leagueReward = reward
end

ServerRecord.setArenaEnemyName = function ( name )
	-- body
	self._arenaEnemyName = name
end

ServerRecord.getArenaEnemyName = function ()
	-- body
	return self._arenaEnemyName
end

ServerRecord.setArenaOrder = function ( order )
	-- body
	self._arenaOrder = order
end

ServerRecord.getArenaOrder = function ()
	-- body
	return self._arenaOrder
end

ServerRecord.setGameOverFlag = function ( flag )
	-- body
	self._gameOverFlag = flag
end

ServerRecord.getGameOverFlag = function ()
	-- body
	return self._gameOverFlag
end

ServerRecord.setDefaultBossCharId = function ( charId )
	-- body
	self._defaultBossCharId = charId
end

ServerRecord.getDefaultBossCharId = function ()
	-- body
	return self._defaultBossCharId
end

ServerRecord.pushDeadRole = function ( serverRole )
	-- body
	assert(serverRole)
	
	table.insert(self._dieRoleArray, serverRole)
end

ServerRecord.getLastEnemyDeadRole = function ()
	-- body
	local len = #self._dieRoleArray
	for i=len,1,-1 do
		local role = self._dieRoleArray[i]
		if role:isMonster() then
			return role
		end
	end
end

ServerRecord.getLastHeroDeadRole = function ()
	-- body
	local len = #self._dieRoleArray
	for i=len,1,-1 do
		local role = self._dieRoleArray[i]
		if not role:isMonster() then
			return role
		end
	end
end

---设置地形
ServerRecord.setBattleBgType = function ( bgtype )
	-- body
	self._battleBgType = bgtype
end

ServerRecord.getBattleBgType = function ()
	-- body
	return self._battleBgType
end

ServerRecord.setBossCatchFlag = function ( flag )
	-- body
	self._bossCatchFlag = flag
end

ServerRecord.getBossCatchFlag = function ()
	-- body
	return self._bossCatchFlag
end

ServerRecord.setFuBenDropNum = function (num)
	-- body
	self._fubenDropNum = num
end

ServerRecord.getFuBenDropNum = function ()
	-- body
	return self._fubenDropNum or 0
end

-- 
ServerRecord.setPreAp = function (preAp)
	-- body
	self._preAp = preAp
end

ServerRecord.getPreAp = function ()
	-- body
	return self._preAp
end

ServerRecord.setBossHelperBasicId = function ( basicId )
	-- body
	self._bossHelperBasicId = basicId
end

ServerRecord.getBossHelperBasicId = function ()
	-- body
	return self._bossHelperBasicId
end

ServerRecord.setLeagueEnemyId = function ( enemyId )
	-- body
	self._leagueEnemyId = enemyId
end

ServerRecord.getLeagueEnemyId = function ()
	-- body
	return self._leagueEnemyId
end

ServerRecord.recordOriginalData = function ( ... )

	local data = {}
	self._originalData = data

	data.Team = {}
	data.NpcTeam = {}

	local array = ServerController.getServerHeroArray()
	-- assert(array)
	--PVP 没有这些数据
	if array then
		for i, v in ipairs(array) do
			local item = {}

			item.petId = v:getIdentifyId()
			item.charactorId = v:getBasicId()
			item.hpP = v:getHpP()

			item.lv = v:getLevel()
			item.atk = v.atk
			item.hpD = v:getBasicHpD()

			table.insert(data.Team, item)

			if v:getHpP() <= 0 then
				data.NoLost = false

				data.Lost = data.Lost + 1
			end
		end
	end

	local npcArray = ServerController.getServerMonsterArray()
	if npcArray then
		for i, v in ipairs(npcArray) do
			local item = {}

			item.petId = v:getIdentifyId()
			item.charactorId = v:getBasicId()
			item.hpP = v:getHpP()

			item.lv = v:getLevel()
			item.atk = v.atk
			item.hpD = v:getBasicHpD()

			table.insert(data.NpcTeam, item)
		end
	end

	local enemyArray = ServerController.getServerEnemyModuleArray()
	if enemyArray then
		data.EnemyTeam = {}
		for i,v in ipairs(enemyArray) do
			local item = {}
			item.petId = v:getIdentifyId()
			item.charactorId = v:getBasicId()
			item.hpP = v:getHpP()

			item.lv = v:getLevel()
			item.atk = v.atk
			item.hpD = v:getBasicHpD()

			table.insert(data.EnemyTeam, item)
		end
	end
	
end

ServerRecord.getOriginalData = function ( ... )
	return self._originalData
end

ServerRecord.setAdditionTable = function ( t )
	self._additionTable = t
end

ServerRecord.getAdditionTable = function ( ... )
	return self._additionTable
end

ServerRecord.isEnemyBigSkillEnabled = function ( ... )
	return ServerRecord.getMode() == 'champion' or ServerRecord.getMode() == 'train' or ServerRecord.getMode() == 'guildfuben'
end

ServerRecord.isEnemyManaAutoEnabled = function ( ... )
	return ServerRecord.getMode() == 'champion' or ServerRecord.getMode() == 'train' or ServerRecord.getMode() == 'guildfuben'
end

ServerRecord.setArenaHandler = function ( Handler )
	self._arenaHandler = Handler
end

ServerRecord.setExData = function ( data )
	self._exdata = data
end

ServerRecord.getExData = function ( ... )
	return self._exdata
end

return ServerRecord