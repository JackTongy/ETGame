local EventCenter 		= require 'EventCenter'
local FightEvent 		= require 'FightEvent'
local CfgHelper 		= require 'CfgHelper'
local CSValueConverter 	= require 'CSValueConverter'

local EventObserver = {}

function EventObserver.reset()
	-- body
	EventCenter.addEventFunc( FightEvent.LogicBattleStart, function ( data )
		-- body
		print("##################################################################################################################")

		print('-----LogicBattleStart-----')
		print(data)
		data.data.type = data.type

		require 'Global'.Battle_Use_View = false

		require 'FightController':start()
	    require 'ServerController'.start( data.data )

	    local fightResult

	    -----用于快速计算
	    EventCenter.addEventFunc(FightEvent.GameOver, function (resultData)
	    	-- body
	    	require 'FightTimer'.pause()
	    	fightResult = fightResult or resultData

	    	print(fightResult)
	    	print('xxxxxxxxxxx!')
	    end, 'Fight')


		require 'FightTimer'.resume()

	    local raw_print = print
	    -- print = function ( ... )
	    -- 	-- body
	    -- end

	    local pre = SystemHelper:currentTimeMillis()

	    require 'FightTimer'.doUntilFinished( function ()
	    	-- body
	    	return fightResult
	    end )

	    local now = SystemHelper:currentTimeMillis()

	    print = raw_print
	    require 'FightTimer'.resume()


	    require 'Global'.Battle_Use_View = true
		--删除所有角色
		require 'FightController':reset()
		require 'FightTimer'.reset()
		require 'FightLoad'.reset()
		require 'GridManager'.reset()

	    assert(fightResult)

	    print('运行了 '..(now-pre)/1000)

		print("##################################################################################################################")

		--返回计算结果
		return fightResult
	end, 'Nerver')

	EventCenter.addEventFunc("OnBattleCompleted",function ( data )
		local GuideHelper 	= require 'GuideHelper'

		print("------------OnBattleCompleted---------")
		print(data)

		local mode = data.mode
		if mode == "ActRaid" then
			GleeCore:showLayer("DActRaid")
		elseif mode == "fuben" then
		elseif mode == "champion" then
			GleeCore:showLayer("DRoadOfChampion")
			require "GuideHelper":check("firstBattleOver")
		elseif mode == "bossBattle" then
		elseif mode == "CMBossBattle" then
		elseif mode == "SDNBossBattle" then
		elseif mode == "arena" then
			GleeCore:showLayer("DArena",{FromBattle = true})
			require "GuideHelper":check("ArenaBattleBack")
		elseif mode == "arena-record" then
			GleeCore:showLayer("DArena",{ViewType = 2})
		elseif mode == "fuben_thief" then
		end
	end, 'Nerver')

	EventCenter.addEventFunc('BattleStart', function ( data )
		-- body
		local GuideHelper 	= require 'GuideHelper'

		print("##################################################################################################################")
		print("##################################################################################################################")
		print("##################################################################################################################")
		print("##################################################################################################################")
		print("##################################################################################################################")
		print("##################################################################################################################")

		print('-----BattleStart-----')
		print(data)

		data.data.type = data.type

		local seed = data.data.Seed or data.data.seed or data.Seed or data.seed
		data.seed 		= seed
		data.data.seed 	= seed

		-- paramsData.battleId == 10001 强制改为第一场战斗
		-- data.data.battleId = 10001
		--[[
		test
		bossBattle
		fuben
		champion
		pvp
		--]]
		print('Default Boss Id = '..tostring( data.data.bossId))
		require 'ServerRecord'.setDefaultBossCharId( data.data.bossId)
		require 'ServerRecord'.setBattleBgType( data.data.bgType)
		require 'ServerRecord'.setBossCatchFlag( data.data.catchBossFlag )
		require 'ServerRecord'.setFuBenDropNum( data.data.dropNum )
		require 'ServerRecord'.setMode( data.type )
		require 'ServerRecord'.setLeagueEnemyId( data.data.enemyId )

		require 'ServerRecord'.setArenaEnemyName( data.data.enemyName )
		require 'ServerRecord'.setArenaSeed( data.data.seed )
		require 'ServerRecord'.setArenaBid( data.data.Bid )

		require 'ServerRecord'.setPreAp( data.data.preAp )
		
		require 'ServerRecord'.setArenaOrder( data.data.No )
		require 'ServerRecord'.setArenaReward( data.data.Reward )

		require 'BattleBgManager'.getBgResidByType()

		GleeCore:closeAllLayers()

		local function runBattle()
			-- body
			GleeCore:closeAllLayers()

			if not data.type then
				--pvp
				GleeCore:pushController('GameStart', data)
			else
				if data.type == 'guider' then
					GleeCore:replaceController('FightLoading', data)
				else
					GleeCore:pushController('FightLoading', data)
				end
			end

			GuideHelper:check('StartBattle')
		end

		local function converBossDataToPet( bossData )
			-- body
			assert(bossData)
			assert(bossData.petid)
			--petid = 145,	atk = 20000,	hp = 10000,	abilityarray = {1120,3012,4029}

			--[[
			+1+intimacy [0]
			| +spd [197.8768]
			| +cv [1.5]
			| +hp [5293]
			| +fv [91.33]
			| +HpMax [5293]
			| +AwakeIndex [0]
			| +PetId [144]
			| +gb
			| +Lv [10]
			| +atk [4857]
			| +def [1659]
			| +sv [16.23]
			| +ID [35912]
			| +hpR [0]
			| +bd [0]
			| +cri [0]
			| +atktime [2]
			| +isFriend [false]
			| +charactorId [144]
			| +awaken [0]
			| +energy [0]
			| +heroid [35912]
			]]

			local petData = {}

			local tData = CfgHelper.getCache('charactorConfig', 'id', bossData.petid)
			assert(tData)

			petData.intimacy 	= 0
			petData.spd 		= tData.Spd
			petData.cv 			= CSValueConverter.toC( 1.5 ) --tData.Cv
			petData.hp 			= CSValueConverter.toC( bossData.hp )
			petData.fv 			= CSValueConverter.toC( tData.Fv )
			petData.AwakeIndex 	= 27
			petData.PetId 		= bossData.petid
			petData.gb 			= {}
			petData.gb['k']		= bossData.k
			petData.Lv 			= 1
			petData.atk 		= CSValueConverter.toC( bossData.atk )
			petData.def 		= CSValueConverter.toC( tData.def )
			petData.sv 			= CSValueConverter.toC( tData.Sv )
			petData.ID 			= 1
			petData.hpR 		= 0
			petData.bd 			= 0
			petData.cri 		= tData.crit
			petData.atktime 	= tData.Atktime
			petData.isFriend 	= false
			petData.charactorId = bossData.petid
			petData.awaken 		= 27
			petData.energy 		= 0
			petData.heroid 		= petData.ID 

			return petData
		end

		--check
		local function checkStory()
			-- body
			require 'ServerRecord'.setBossHelperBasicId( nil )

			local triggerData = nil

			-- data.data.battleId = 10002

			if data.data.type == 'fuben' or data.data.type == 'fuben_boss' then
				local battleId = data.data.battleId
				assert(battleId)

				triggerData = CfgHelper.getCache('BattleTriggerStory', 'BattleId', battleId)
			end

			if triggerData then

				-- 神兽助战
				if triggerData.BossId then
					assert( data.data.petList )

					local isOnlyCaptain = triggerData.onlycaptain == 1

					if isOnlyCaptain then
						local newPetList = {}
						-- newPetList[1] = data.data.petList[1]
						table.insert(newPetList, data.data.petList[1])

						for i,bossId in ipairs(triggerData.BossId) do
							local bossData = CfgHelper.getCache('BattleBoss', 'BossId', bossId)
							local petData = converBossDataToPet(bossData)
							table.insert(newPetList, petData)

							require 'ServerRecord'.setBossHelperBasicId( petData.PetId )
						end

						data.data.petList = newPetList

					else
						local petsNum = #data.data.petList
						local bosses = #triggerData.BossId

						if bosses > 0 then
							local insertIndex = 6 - bosses
							if petsNum < insertIndex then
								insertIndex = petsNum + 1
							end

							for i,bossId in ipairs(triggerData.BossId) do
								local bossData = CfgHelper.getCache('BattleBoss', 'BossId', bossId)
								local petData = converBossDataToPet(bossData)
								data.data.petList[insertIndex] = petData
								insertIndex = insertIndex + 1
							end
						end
					end
				end

				-- 队长免伤
				if triggerData.captain == 1 then
					assert(data.data.petList)
					data.data.petList[1].fv = require 'CSValueConverter'.toC( 999999 )
					print('触发队长免伤.')
				end

				-- 剧情触发
				if triggerData.BattleStory and triggerData.BattleStory > 0 and (not require 'AccountHelper'.isItemOFF('PetName')) then

					-- local defaultPetId = data.data.petList[1].PetId
					local defaultPetId = require 'UserInfo'.getLeaderPetID()

					local storyData = {}

					storyData.StoryId = triggerData.BattleStory
					storyData.defaultPetId = defaultPetId
					storyData.callback = function ( ... )
						-- body
						require 'FightSettings'.resume()
					end

					local triggerStoryFunc = function ()
						-- body
						require 'FightSettings'.pause()
						GleeCore:showLayer('BattleStory', storyData)
					end
					
					data.data.triggerStory = triggerStoryFunc

				end
			end
		end

		print('petList')
		print(data.data.petList)

		checkStory()
		runBattle()
		
	end ,'Nerver')

	EventCenter.addEventFunc("OnAppStatChange", function ( state )
		if state == 1 then
			-- pause
		elseif state == 2 then
			-- resume
			require 'MusicSettings'.apply()
		end
	end, 'Nerver')
end

if SystemHelper.setListener then
	SystemHelper:setListener(function ( state )
		-- body
		if state == 1 then
			print('App OnBackground')
			EventCenter.eventInput('OnAppStatChange', state)
		elseif state == 2 then
			print('App OnForeground')
			EventCenter.eventInput('OnAppStatChange', state)
		end
	end)
end

EventObserver.reset()

return EventObserver
