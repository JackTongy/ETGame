local Config = require "Config"
local TypeRole = require 'TypeRole'
local TimerHelper = require 'framework.sync.TimerHelper'
local CfgHelper = require 'CfgHelper'
local Random = require 'Random'

local FightLoading = class(LuaController)

function FightLoading:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."FightLoading.cocos.zip")
    return self._factory:createDocument("FightLoading.cocos")
end

--@@@@[[[[
function FightLoading:onInitXML()
	local set = self._set
    self._pic = set:getElfNode("pic")
    self._linear_labelLeft = set:getLabelNode("linear_labelLeft")
    self._linear_labelNum = set:getLabelNode("linear_labelNum")
    self._tip = set:getLabelNode("tip")
end
--@@@@]]]]

--------------------------------override functions----------------------
local CfgHelper = require 'CfgHelper'

function FightLoading:onInit( userData, netData )

	self:runWithDelay(function ( ... )
		-- body
		require 'framework.helper.MusicHelper'.stopAllEffects()
	end, 2)
	require 'framework.helper.MusicHelper'.stopBackgroundMusic()

	local tipData = require 'TipsConfig'
	local index = Random.ranI(1, #tipData)
	local tip = tipData[index].Tips

	-- 
	if userData and userData.type == 'guider' then
		tip = CfgHelper.getCache('BattleSetConfig', 'Key', 'FirstBattleTips', 'Value') or '开启声音，有惊喜哟！'
	end

	self._tip:setString(string.format('Tips:%s', tostring(tip)))

	local FightLoad = require 'FightLoad'

	self._userData = userData
	local runArray

	-- self:runWithDelay(function ()
		-- body
		if userData then
			local heroIdArray	
			local monsterIdArray

			local data = userData.data
			data.type = userData.type

			if userData.type == 'test' then
				local data = userData.data
				
				if data.teamid and data.fubenid then
					local petList = self:loadPetList(data.teamid)
					--not id any more
					heroIdArray = self:loadPetListCharactorIdArray(petList)
					monsterIdArray = self:loadMonsterCharactorIdArray(data.fubenid, 'pve_fubens', 'pve_waves', 'pve_monster')
				else
					print('-----Unexpected ServerController start data ---------')
					print(paramsData)
					assert(false)
				end

				runArray = FightLoad.getRunnableArray(heroIdArray, monsterIdArray)

				self:runNext(runArray, 1)

			elseif userData.type == 'guider' then
				local data = userData.data
				
				if data.teamid and data.battleId then
					local petList = self:loadGuiderPetList(data.teamid)
					--not id any more
					heroIdArray = self:loadPetListCharactorIdArray(petList)
					monsterIdArray = self:loadMonsterCharactorIdArray(data.battleId, 'BattleConfig', 'WaveConfig', 'MonsterConfig')
				else
					print('-----Unexpected ServerController guider data ---------')
					print(data)
					assert(false)
				end

				runArray = FightLoad.getRunnableArray(heroIdArray, monsterIdArray)

				self:runNext(runArray, 1)
			elseif userData.type == 'fuben' or userData.type == 'fuben_boss' then
				local data = userData.data
				
				if data.petList and data.battleId then
					heroIdArray = self:loadPetListCharactorIdArray(data.petList)
					monsterIdArray = self:loadMonsterCharactorIdArray(data.battleId, 'BattleConfig', 'WaveConfig', 'MonsterConfig')
				else
					print('-----Unexpected ServerController start data ---------')
					print(paramsData)
					assert(false)
				end

				runArray = FightLoad.getRunnableArray(heroIdArray, monsterIdArray)

				self:runNext(runArray, 1)

			elseif userData.type == 'fuben_cat' then
				local data = userData.data
				
				if data.petList and data.battleId then
					heroIdArray = self:loadPetListCharactorIdArray(data.petList)
					monsterIdArray = self:loadMonsterCharactorIdArray(data.battleId, 'BattleConfig', 'WaveConfig', 'MonsterConfig')
				else
					print('-----Unexpected ServerController start data ---------')
					print(paramsData)
					assert(false)
				end

				runArray = FightLoad.getRunnableArray(heroIdArray, monsterIdArray)

				self:runNext(runArray, 1)

			elseif userData.type == 'fuben_thief' then
				local data = userData.data
				
				if data.petList and data.battleId then
					heroIdArray = self:loadPetListCharactorIdArray(data.petList)
					monsterIdArray = self:loadMonsterCharactorIdArray(data.battleId, 'BattleConfig', 'WaveConfig', 'MonsterConfig')
				else
					print('-----Unexpected ServerController start data ---------')
					print(paramsData)
					assert(false)
				end
				
				runArray = FightLoad.getRunnableArray(heroIdArray, monsterIdArray)
				
				self:runNext(runArray, 1)
				
			elseif userData.type == 'ActRaid' then
				local data = userData.data
				
				if data.petList and data.battleId then
					heroIdArray = self:loadPetListCharactorIdArray(data.petList)
					monsterIdArray = self:loadMonsterCharactorIdArray(data.battleId, 'BattleConfig', 'WaveConfig', 'MonsterConfig')
				else
					print('-----Unexpected ServerController start data ---------')
					print(paramsData)
					assert(false)
				end
				
				runArray = FightLoad.getRunnableArray(heroIdArray, monsterIdArray)

				self:runNext(runArray, 1)

			elseif userData.type == 'champion' then
				local data = userData.data
				
				heroIdArray = self:loadPetListCharactorIdArray(data.myTeam)
				monsterIdArray = self:loadMonsterListCharactorIdArray(data.npcTeam)
				
				runArray = FightLoad.getRunnableArray(heroIdArray, monsterIdArray)
				self:runNext(runArray, 1)
			elseif userData.type == 'train' then
				local data = userData.data
				
				heroIdArray = self:loadPetListCharactorIdArray(data.myTeam)
				monsterIdArray = self:loadMonsterListCharactorIdArray(data.npcTeam)
				
				runArray = FightLoad.getRunnableArray(heroIdArray, monsterIdArray)
				self:runNext(runArray, 1)
			elseif userData.type == 'arena' or userData.type == 'friend' then
				local data = userData.data
				
				data.seed = data.seed or require 'Random'.generateSeed()

				heroIdArray = self:loadPetListCharactorIdArray(data.petList)
				monsterIdArray = self:loadEnemyListCharactorIdArray(data.enemyList)
				
				runArray = FightLoad.getRunnableArray(heroIdArray, monsterIdArray)

				local runArray2 = FightLoad.getArenaRunnableArray(data)
				-- 预先结算
				for i,run in ipairs(runArray2) do
					table.insert(runArray, 1, run)
				end

				self:runWithDelay(function ()
					-- body
					self:runNext(runArray, 1)
				end, 0.3)

			elseif userData.type == 'league' then
				local data = userData.data
				
				data.seed = data.seed or require 'Random'.generateSeed()

				heroIdArray = self:loadPetListCharactorIdArray(data.petList)
				monsterIdArray = self:loadEnemyListCharactorIdArray(data.enemyList)
				
				runArray = FightLoad.getRunnableArray(heroIdArray, monsterIdArray)

				local runArray2 = FightLoad.getArenaRunnableArray(data)
				-- 预先结算
				for i,run in ipairs(runArray2) do
					table.insert(runArray, 1, run)
				end

				self:runWithDelay(function ()
					-- body
					self:runNext(runArray, 1)
				end, 0.3)

			elseif userData.type == 'arena-record' then
				local data = userData.data

				heroIdArray = self:loadPetListCharactorIdArray(data.petList)
				monsterIdArray = self:loadEnemyListCharactorIdArray(data.enemyList)

				---- data.isChallenger or not   ?????
				runArray = FightLoad.getRunnableArray(heroIdArray, monsterIdArray)

				self:runNext(runArray, 1)

			elseif userData.type == 'bossBattle' then
				local data = userData.data
				data.boss.isBoss = true

				heroIdArray = self:loadPetListCharactorIdArray(data.petList)
				monsterIdArray = self:loadMonsterListCharactorIdArray( { data.boss } )
				runArray = FightLoad.getRunnableArray(heroIdArray, monsterIdArray)
				self:runNext(runArray, 1)
			elseif userData.type == 'CMBossBattle' then
				local data = userData.data
				data.boss.isBoss = true

				heroIdArray = self:loadPetListCharactorIdArray(data.petList)
				monsterIdArray = self:loadMonsterListCharactorIdArray( { data.boss } )
				runArray = FightLoad.getRunnableArray(heroIdArray, monsterIdArray)
				self:runNext(runArray, 1)
			elseif userData.type == 'SDNBossBattle' then
				local data = userData.data
				data.boss.isBoss = true

				heroIdArray = self:loadPetListCharactorIdArray(data.petList)
				monsterIdArray = self:loadMonsterListCharactorIdArray( { data.boss } )
				runArray = FightLoad.getRunnableArray(heroIdArray, monsterIdArray)
				self:runNext(runArray, 1)
			elseif userData.type == 'guildboss' then
				local data = userData.data
				
				if data.petList and data.battleId then
					heroIdArray = self:loadPetListCharactorIdArray(data.petList)
					monsterIdArray = self:loadMonsterCharactorIdArray(data.battleId, 'BattleConfig', 'WaveConfig', 'MonsterConfig')
				else
					print('-----Unexpected ServerController start data ---------')
					print(paramsData)
					assert(false)
				end

				runArray = FightLoad.getRunnableArray(heroIdArray, monsterIdArray)

				self:runNext(runArray, 1)
			elseif userData.type == 'guildmatch' then
				local data = userData.data
				
				data.seed = data.seed or require 'Random'.generateSeed()

				heroIdArray = self:loadPetListCharactorIdArray(data.petList)
				monsterIdArray = self:loadEnemyListCharactorIdArray(data.enemyList)
				
				runArray = FightLoad.getRunnableArray(heroIdArray, monsterIdArray)

				local runArray2 = FightLoad.getArenaRunnableArray(data)
				-- 预先结算
				for i,run in ipairs(runArray2) do
					table.insert(runArray, 1, run)
				end

				self:runWithDelay(function ()
					-- body
					self:runNext(runArray, 1)
				end, 0.3)
			elseif userData.type == 'guildfuben_rob' then
				local data = userData.data
				
				data.seed = data.seed or require 'Random'.generateSeed()

				heroIdArray = self:loadPetListCharactorIdArray(data.petList)
				monsterIdArray = self:loadEnemyListCharactorIdArray(data.enemyList)
				
				runArray = FightLoad.getRunnableArray(heroIdArray, monsterIdArray)

				local runArray2 = FightLoad.getArenaRunnableArray(data)
				-- 预先结算
				for i,run in ipairs(runArray2) do
					table.insert(runArray, 1, run)
				end

				self:runWithDelay(function ()
					-- body
					self:runNext(runArray, 1)
				end, 0.3)
			elseif userData.type == 'guildfuben_revenge' then
				local data = userData.data
				require 'ServerRecord'.setExData({SlotId=data.SlotId})
				data.seed = data.seed or require 'Random'.generateSeed()

				heroIdArray = self:loadPetListCharactorIdArray(data.petList)
				monsterIdArray = self:loadEnemyListCharactorIdArray(data.enemyList)
				
				runArray = FightLoad.getRunnableArray(heroIdArray, monsterIdArray)

				local runArray2 = FightLoad.getArenaRunnableArray(data)
				-- 预先结算
				for i,run in ipairs(runArray2) do
					table.insert(runArray, 1, run)
				end

				self:runWithDelay(function ()
					-- body
					self:runNext(runArray, 1)
				end, 0.3)
			elseif userData.type == 'guildfuben' then
				local data = userData.data

				heroIdArray = self:loadPetListCharactorIdArray(data.petList)
				monsterIdArray = self:loadEnemyListCharactorIdArray(data.enemyList)
				runArray = FightLoad.getRunnableArray(heroIdArray,monsterIdArray)
				self:runNext(runArray,1)
			elseif userData.type == 'limit_fuben' then
				local data = userData.data
				require 'ServerRecord'.setExData({stageId=data.stageId})
				heroIdArray = self:loadPetListCharactorIdArray(data.petList)
				monsterIdArray = self:loadEnemyListCharactorIdArray(data.enemyList)
				runArray = FightLoad.getRunnableArray(heroIdArray,monsterIdArray)
				self:runNext(runArray,1)
			elseif userData.type == 'RemainsFuben' then
				local data = userData.data
				require 'ServerRecord'.setExData({Id=data.Id})
				heroIdArray = self:loadPetListCharactorIdArray(data.petList)
				monsterIdArray = self:loadEnemyListCharactorIdArray(data.enemyList)
				runArray = FightLoad.getRunnableArray(heroIdArray,monsterIdArray)
				self:runNext(runArray,1)
			end
		end
	-- end, 1)
	
	local len = (runArray and #runArray) or 0
	self._linear_labelNum:setString(string.format('(0/%d)', #runArray))
	
	-- if paramsData.teamid and paramsData.fubenid then
	-- 	ServerController.startForTest(paramsData.teamid, paramsData.fubenid)
	-- elseif paramsData.petList and paramsData.battleId then
	-- 	ServerController.startForBattle(paramsData.petList, paramsData.battleId)
	-- else 
	-- 	print('-----Unexpected ServerController start data ---------')
	-- 	print(paramsData)
	-- 	assert(false)
	-- end
end



function FightLoading:runNext( runArray, index )
	-- body
	if index > #runArray then
		GleeCore:replaceController('GameStart', self._userData)
	else
		self._linear_labelNum:setString(string.format('(%d/%d)', index, #runArray))

		local func = runArray[index]
		func()
		--delay?
		-- TimerHelper.tick
		self:runWithDelay(function ()
			-- body
			self:runNext(runArray, index+1)
		end, 0.1)
	end
end

function FightLoading:loadPetListCharactorIdArray( petList )
	-- body
	local retArray = {}

	for i,v in ipairs(petList) do

		local item = {}
		item.charactorId = v.charactorId
		item.isBoss = false
		item.isMonster = false

		--------friend ? 
		item.bloodType = (v.isFriend and TypeRole.BloodType_Friend) or   TypeRole.BloodType_Hero
		
		table.insert(retArray, item)
	end
	
	return retArray
end

function FightLoading:loadEnemyListCharactorIdArray( petList )
	-- body
	local retArray = {}

	for i,v in ipairs(petList) do

		-- print('???????????')
		-- print(v)
		
		local item = {}
		item.charactorId = v.charactorId

		item.isBoss = false
		item.isMonster = true

		item.bloodType = TypeRole.BloodType_Monster
		
		table.insert(retArray, item)
	end
	
	return retArray
end

function FightLoading:loadMonsterListCharactorIdArray( monsterList )
	-- body
	local retArray = {}

	for i,v in ipairs(monsterList) do

		local item = {}
		item.charactorId = v.charactorId

		item.isBoss = v.isBoss  ---????
		item.isMonster = true 
		item.bloodType = (v.isBoss and TypeRole.BloodType_Boss)or TypeRole.BloodType_Monster

		if item.isBoss then
			if require 'ServerRecord'.getDefaultBossCharId() then
				item.charactorId = require 'ServerRecord'.getDefaultBossCharId()
			end
		end

		table.insert(retArray, item)
	end

	return retArray
end

function FightLoading:loadPetList( teamid )
	-- body
	local heroarray = CfgHelper.getCache('pve_charactor_teams', 'teamid', teamid, 'heroarray')
	assert(heroarray)

	local petList = {}
	for i,v in ipairs(heroarray) do
		local heroVo = CfgHelper.getCache('pve_charactor', 'heroid', v)
		assert(heroVo)

		table.insert(petList, heroVo)
	end

	return petList
end

function FightLoading:loadGuiderPetList( teamid )
	-- body
	local heroarray = CfgHelper.getCache('guide_battle_teams', 'teamid', teamid, 'heroarray')
	assert(heroarray)

	local petList = {}
	for i,v in ipairs(heroarray) do
		local heroVo = CfgHelper.getCache('guide_battle_charactor', 'heroid', v)
		assert(heroVo)

		table.insert(petList, heroVo)
	end

	return petList
end

function FightLoading:loadMonsterCharactorIdArray( fubenid, fubenConfig, waveConfig, monsterConfig )
	-- body

	--[[
	assert(args.charactorId)
	assert(args.bloodType)
	args.isBoss, args.isMonster
	assert(args.isBoss)
	--]]

	local retArray = {}

	local fubenVo = CfgHelper.getCache(fubenConfig, 'fubenid', fubenid)
	assert(fubenVo)

	local wavearray = fubenVo.wavearray

	assert(wavearray, fubenVo)

	local waveTable = require (waveConfig)

	for i,v in ipairs(wavearray) do
		local waveid = v

		for ii, vv in ipairs(waveTable) do
			if vv['waveid'] == waveid then

				local roleid = vv.heroid
				local role = CfgHelper.getCache(monsterConfig, 'heroid', roleid)

				assert(role)

				local item = {}
				item.charactorId = role.charactorId

				item.isBoss = ((vv.isboss or vv.IsBoss) == 1)
				item.isMonster = true
				item.bloodType = (item.isBoss and TypeRole.BloodType_Boss) or TypeRole.BloodType_Monster

				if item.isBoss then
					if require 'ServerRecord'.getDefaultBossCharId() then
						item.charactorId = require 'ServerRecord'.getDefaultBossCharId()
					end
				end

				table.insert(retArray, item)
			end
		end
	end

	return retArray
end

function FightLoading:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(FightLoading, "FightLoading")


--------------------------------register--------------------------------
GleeCore:registerLuaController("FightLoading", FightLoading)


