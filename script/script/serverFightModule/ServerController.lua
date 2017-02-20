
local EventCenter 				= require 'EventCenter'
local ServerRoleFactory 		= require 'ServerRole'
local FightEvent 				= require 'FightEvent'
local CfgHelper 				= require 'CfgHelper'
local SkillUtil 				= require 'SkillUtil'
local ServerAccess 				= require 'ServerAccess'
local FightTimer 				= require 'FightTimer'
local Utils 					= require 'framework.helper.Utils'
local FightSettings 			= require 'FightSettings'
local TimerHelper 				= require 'framework.sync.TimerHelper'
local CSValueConverter 			= require 'CSValueConverter'

local Buffer_Crit = 7
local Buffer_Atk = 8
local Buffer_Hp = 9

local Awaken_Array = { 
	[0] = 0,
	[1] = 0,
	[2] = 0,
	[3] = 0,
	[4] = 1,
	[5] = 1,
	[6] = 1,
	[7] = 1,
	[8] = 1,
	[9] = 1,
	[10] = 1,
	[11] = 1,
	[12] = 2,
	[13] = 2,
	[14] = 2,
	[15] = 2,
	[16] = 3,
	[17] = 3,
	[18] = 3,
	[19] = 3,
	[20] = 3,
	[21] = 3,
	[22] = 3,
	[23] = 3,
	[24] = 3,
}

require "ServeSlotManager"
require 'ServePveWavesDyManger'

-- SkillUtil.Condition_Calc = 1
-- SkillUtil.Condition_HpEqual = 2
-- SkillUtil.Condition_HpLittle = 3
-- SkillUtil.Condition_HpGreater = 4
-- SkillUtil.Condition_FightRound = 5
-- SkillUtil.Condition_FightBossRound = 6
-- SkillUtil.Condition_OnBattleField = 7
-- SkillUtil.Condition_OnBenchFiled = 9
-- SkillUtil.Condition_BattleFieldType = 8
-- SkillUtil.Condition_KillAnEnemy = 10
-- SkillUtil.Condition_LoseAFriend = 11
-- SkillUtil.Condition_WhatEver = 12
-- SkillUtil.Condition_OnFightCrit = 13
-- SkillUtil.Condition_OnFightNormal = 14
-- SkillUtil.Condition_OnFightNormalAndKill = 15
-- SkillUtil.Condition_Win = 16

--[[
全部生成英雄
--]]

local ServerController = {}

local function createHeroArray( serverRoleArray, petList, isSelfOrOther )
	-- body
	local ret = {}


	for i,v in ipairs(petList) do
		if i > 6 then
			break
		end

		local heroargs = v

		print('load hero')
		print(heroargs)

		local args = {
			hp 				= true,
			hpMax 			= true,
			atk 			= true,
			def 			= true,
			cri 			= true,
			spd 			= true,
			charactorId 	= true,
			skillidarray 	= true,
			awaken 			= true,
			ismonster 		= false,
			point           = true,
			mana 			= true,
			atktime 		= true,
		}

		args.hp 			= 	heroargs.hp
		args.hpMax          =   (heroargs.HpMax or heroargs.hp)
		args.atk 			= 	heroargs.atk
		args.def 			= 	heroargs.def
		args.cri 			= 	heroargs.cri or heroargs.crit or 0
		args.spd 			= 	heroargs.spd
		args.charactorId	=	heroargs.charactorId
		args.awaken     	=   heroargs.awaken or #Awaken_Array
		args.atktime 		= 	heroargs.atktime

		-- 增加了怒气初始值 
		args.mana  			=   heroargs.energy or 0

		args.ismonster 		= 	not isSelfOrOther

		-- self.sv 	= args.sv or 0 		--最终伤害
		-- self.fv 	= args.fv or 0 		--最终免伤
		-- self.cv 	= args.cv or 0 		--暴击倍数
		-- self.bd 	= args.bd or 0 		--破防, 来自装备
		-- self.hpR 	= args.hpR or 0		--回复加成, 来自装备	
		-- self.gb 	= args.gb or {}		--宝石对宠物Buff效果的影响,   光环的map????
		--新增6项
		args.sv 			=  	heroargs.sv
		args.fv 			=   heroargs.fv
		args.cv     		=	heroargs.cv
		args.bd 			=	heroargs.bd
		args.hpR   			=   heroargs.hpR
		args.gb 			=	heroargs.gb
		args.eb 			=   heroargs.eb

		--处理BattleBuffer
		local hpAdd = ServerController._battleBuffer[Buffer_Hp] or 1
		local atkAdd = ServerController._battleBuffer[Buffer_Atk] or 1
		local criAdd = ServerController._battleBuffer[Buffer_Crit] or 1

		if hpAdd > 1.7 then
			hpAdd = 1
		end

		if atkAdd > 1.9 then
			atkAdd = 1
		end

		if criAdd > 1.1 then
			criAdd = 1
		end


		-- hpAdd  = math.min( hpAdd, 1.1 )
		-- atkAdd = math.min( atkAdd, 1.1 )
		-- criAdd = math.min( criAdd, 1.1 )

		-- args.hp 	= math.floor(args.hp 		* hpAdd)
		-- args.hpMax 	= math.floor(args.hpMax 	* hpAdd)
		local CSValueConverter = require 'CSValueConverter'
		if CSValueConverter.shouldConvert( false ) then
			args.hp 	= CSValueConverter.toC( CSValueConverter.toS( args.hp * hpAdd ) )
			args.hpMax 	= CSValueConverter.toC( CSValueConverter.toS( args.hpMax * hpAdd ) )
			args.atk 	= CSValueConverter.toC( CSValueConverter.toS( args.atk * atkAdd ) )
		else
			args.hp 	= args.hp 		* hpAdd
			args.hpMax 	= args.hpMax 	* hpAdd
			args.atk 	= args.atk 		* atkAdd
		end

		args.cri 	= args.cri 		* criAdd

		print('after battleBuffer')
		print(args)
		
		local item = CfgHelper.getCache('charactorConfig', 'id', heroargs.charactorId)

		args.skillidarray = {}
		--近战技能,大招技能
		table.insert( args.skillidarray, item.default_skill )
		table.insert( args.skillidarray, item.advance_skill )
		table.insert( args.skillidarray, item.skill_id )
		
		--大招点数
		args.point = CfgHelper.getCache('skill', 'id', item.skill_id, 'point')
		
		--加入觉醒规则
		--1, 3, 5  
		
		assert(item.abilityarray)

		local unlock_num = Awaken_Array[args.awaken] or 3

		for ii, vv in ipairs(item.abilityarray) do
			if ii > unlock_num then
				break
			end
			if vv ~= 0 then
				table.insert( args.skillidarray, vv )
			end
		end

		if heroargs.MKs and type(heroargs.MKs) == 'table' and #heroargs.MKs > 0 then
			for k,v in pairs(heroargs.MKs) do
				table.insert(args.skillidarray,v)
				print('秘宝附加技能:'..tostring(v))
			end
		end
		
		if heroargs.Sk and type(heroargs.Sk) == 'number' and heroargs.Sk > 0 then
			table.insert(args.skillidarray,heroargs.Sk)
			print('技能书附加技能:'..tostring(heroargs.Sk))
		end

		if require 'ServerRecord'.getMode() == 'guildfuben' and not isSelfOrOther then
			table.insert(args.skillidarray,6005)
		end

		local hero = ServerRoleFactory.createHeroByArgs(args)
		hero.isFriend = isSelfOrOther and heroargs.isFriend

		--设置唯一ID
		hero:setIdentifyId( heroargs.ID )
		hero:setLevel(heroargs.Lv)

		hero:setBigSkillId(item.skill_id)
		table.insert(ret, hero)

		serverRoleArray:addRole( hero )
		hero:setServerRoleArray(serverRoleArray)

		if i > 5 then
			--触发替补技能
			local data = {
				attacker 		= true,
				defenders 		= true,
				conditiontype 	= true,
				openorclose 	= true,
			}
			data.attacker 		= hero
			data.defenders 		= {}

			for ii=1,5 do
				table.insert(data.defenders, ret[ii])
			end

			data.conditiontype = SkillUtil.Condition_OnBenchFiled --触发位于板凳
			data.openorclose = true
			EventCenter.eventInput(FightEvent.TriggerAbility, data)
		end

		if isSelfOrOther then
			local heroModule = {
				Id = true,
				_Id = true,
				Hp = true,
				Speed = true,
				Sid = true,
				isFriend = true,
			}

			heroModule.Id = hero:getDyId()
			heroModule._Id = hero:getBasicId()
			-- heroModule.Point = {0, 0}
			--bug fixed not HpD
			heroModule.Hp 		= hero:getHpP()
			heroModule.Speed 	= hero:getSpeed()
			heroModule.Sid     	= hero:getBigSkillId()
			heroModule.isFriend = hero.isFriend
			heroModule.awaken 	= hero.awaken

			assert( hero.awaken )

			local m = {
				D = true
			}
			m.D = {
				V = true
			}
			m.D.V = heroModule

			if i > 5 then
				m.D.T = true
			end
			
			m.D.AI = false
			m.D.IsSelf = true

			if require 'Global'.Battle_Use_View then
				-- manaview needed
				EventCenter.eventInput( FightEvent.Pve_PreCreateHero, m )
			end
		end

		if args.hp <= 0 then
			hero:setDisposed()
		end
	end

	return ret
end





local function bornHero(serverRoleArray, heroarray, index )
	-- body
	assert(heroarray)

	local hero = heroarray[index]

	if hero then
		local heroModule = {
			Id = true,
			_Id = true,
			Hp = true,
			Speed = true,
			Sid = true,
			isFriend = true,
		}

		heroModule.Id = hero:getDyId()
		heroModule._Id = hero:getBasicId()
		-- heroModule.Point = {0, 0}
		--bug fixed not HpD
		heroModule.Hp 		= hero:getHpP()
		heroModule.Speed 	= hero:getSpeed()
		heroModule.Sid     	= hero:getBigSkillId()
		heroModule.isFriend = hero.isFriend
		heroModule.awaken 	= hero.awaken

		assert( hero.awaken )

		hero:onBorn()

		local m = {
			D = true
		}
		m.D = {
			V = true
		}
		m.D.V = heroModule

		if index > 5 then
			m.D.T = true
		end

		m.D.AI = false
		m.D.IsSelf = true
		EventCenter.eventInput( FightEvent.Pve_CreateHero, m )

		m.D.bornIJ = ServerController._bornIJArraySelf and ServerController._bornIJArraySelf[index]

		ServerController.runWithDelay(function ( ... )
			-- body
			if not hero:isDisposed() then
				if index > 5 then
					--替补上场
					--撤销该role的替补技能
					local data = {}
					data.attacker = hero
					data.conditiontype = SkillUtil.Condition_OnBenchFiled --取消位于板凳
					data.openorclose = false
					EventCenter.eventInput(FightEvent.TriggerAbility, data)
				end

				--触发该role的上场技能
				do
					local data = {
						attacker = true,
						conditiontype = true,
						openorclose = true
					}
					data.attacker = hero
					-- data.conditiontype = SkillUtil.Condition_OnBattleField --位于战场
					data.openorclose = true
					-- EventCenter.eventInput(FightEvent.TriggerAbility, data)

					data.conditiontype = SkillUtil.Condition_WhatEver --触发无条件
					EventCenter.eventInput(FightEvent.TriggerAbility, data)

					-- print('准备触发血量有关技能')

					data.conditiontype = SkillUtil.Condition_HpGreater
					EventCenter.eventInput(FightEvent.TriggerAbility, data)

					data.conditiontype = SkillUtil.Condition_HpEqual
					EventCenter.eventInput(FightEvent.TriggerAbility, data)

					data.conditiontype = SkillUtil.Condition_HpLittle
					EventCenter.eventInput(FightEvent.TriggerAbility, data)
					-- print('结束触发血量有关技能')

					---触发地形相关技能
					data.conditiontype = SkillUtil.Condition_BattleFieldType
					-- data.condition
					EventCenter.eventInput(FightEvent.TriggerAbility, data)

				end

				hero:forceRefreshAtkSpd()
			end
		end, 1)
	end

	return v
end

--[[
--]]
local function bornAIPlayer_Hero( serverRoleArray, heroarray, index, isSelfOrOther )
	-- body
	assert(heroarray)

	if index > 6 then
		return
	end

	local hero = heroarray[index]

	if hero then
		local heroModule = {
			Id = true,
			_Id = true,
			Hp = true,
			Speed = true,
			Sid = true,
			isFriend = true,
		}

		heroModule.Id = hero:getDyId()
		heroModule._Id = hero:getBasicId()
		-- heroModule.Point = {0, 0}
		--bug fixed not HpD
		heroModule.Hp = hero:getHpP()
		heroModule.Speed = hero:getSpeed()
		heroModule.Sid = hero:getBigSkillId()
		heroModule.isFriend = isSelfOrOther and hero.isFriend
		heroModule.awaken = hero.awaken

		hero:onBorn()

		local m = { 
			D = true
		} 

		m.D = {
			V = true
		}
		m.D.V = heroModule

		if index > 5 then
			m.D.T = true
		end



		if isSelfOrOther then
			m.D.AI = true
			m.D.IsSelf = true

			heroModule.AI = true
			heroModule.IsSelf = true

			-- tobe added
			m.D.bornIJ = ServerController._bornIJArraySelf and ServerController._bornIJArraySelf[index]
		else
			m.D.AI = true
			m.D.IsSelf = false

			heroModule.AI = true
			heroModule.IsSelf = false

			-- tobe added
			m.D.bornIJ = ServerController._bornIJArrayOther and ServerController._bornIJArrayOther[index]
		end

		-- assert(ServerController._bornIJArraySelf)
		-- assert(m.D.bornIJ)

		Utils.calcDeltaTime( function ()
			-- body
			EventCenter.eventInput( FightEvent.Pve_CreateHero, m )
		end, 'CreateHero:'..hero:getDyId())

		ServerController.runWithDelay(function ( ... )
			-- body
			if not hero:isDisposed() then
				if index > 5 then
					--替补上场
					--撤销该role的替补技能
					local data = {}
					data.attacker = hero
					data.conditiontype = SkillUtil.Condition_OnBenchFiled --取消位于板凳
					data.openorclose = false
					EventCenter.eventInput(FightEvent.TriggerAbility, data)
				end

				--触发该role的上场技能
				do
					local data = {
						attacker = true,
						conditiontype = true,
						openorclose = true
					} 

					data.attacker = hero
					-- data.conditiontype = SkillUtil.Condition_OnBattleField --位于战场
					data.openorclose = true
					-- EventCenter.eventInput(FightEvent.TriggerAbility, data)

					data.conditiontype = SkillUtil.Condition_WhatEver --触发无条件
					EventCenter.eventInput(FightEvent.TriggerAbility, data)

					-- print('准备触发血量有关技能')

					data.conditiontype = SkillUtil.Condition_HpGreater
					EventCenter.eventInput(FightEvent.TriggerAbility, data)

					data.conditiontype = SkillUtil.Condition_HpEqual
					EventCenter.eventInput(FightEvent.TriggerAbility, data)

					data.conditiontype = SkillUtil.Condition_HpLittle
					EventCenter.eventInput(FightEvent.TriggerAbility, data)
					-- print('结束触发血量有关技能')
				end

				hero:forceRefreshAtkSpd()
			end
		end, 1)
	end

	return v

end




ServerController.initEventFunc = function ( serverRoleArray )
	-- body
	-- FightSettings.setAccelerate( FightSettings.getAccelerate() )

	--监听角色死亡
	EventCenter.addEventFunc(FightEvent.Pve_RoleDie, function ( data )
		-- body
		local heroarray = serverRoleArray:getHeroArray()
		local monsterarray = serverRoleArray:getMonsterArray()

		local isMonster = data.isMonster

		-- print('死亡='..data.role:getDyId())
		if not isMonster then
			for i,role in ipairs(heroarray) do
				if not role:isDisposed() and role:isBorned() then
					local mydata = {
						attacker = true,
						openorclose = true,
						carryData = true,
						conditiontype = true,
					}

					mydata.attacker = role
					mydata.openorclose = true
					mydata.carryData = data.role:getDyId()
					mydata.conditiontype = SkillUtil.Condition_LoseAFriend
					EventCenter.eventInput(FightEvent.TriggerAbility, mydata)
				end
			end
		end

		if isMonster then
			for i,role in ipairs(monsterarray) do
				if not role:isDisposed() then
					local mydata = {
						attacker = true,
						openorclose = true,
						carryData = true,
						conditiontype = true,
					}
					mydata.attacker = role
					mydata.openorclose = true
					mydata.carryData = data.role:getDyId()
					mydata.conditiontype = SkillUtil.Condition_LoseAFriend
					EventCenter.eventInput(FightEvent.TriggerAbility, mydata)
				end
			end
		end

		----移除职业能量球
		if not isMonster then
			--
			local career = data.career
			assert(career)
			
			local exsitedCareerMap = {}
			for i,role in ipairs(heroarray) do
				if not role:isDisposed() then
					exsitedCareerMap[role.career] = true
				end
			end

			if not exsitedCareerMap[career] then
				EventCenter.eventInput(FightEvent.RemoveCareer, { career = career })
			end
		end

	end, 'Fight')
	
	--监听被动触发
	EventCenter.addEventFunc(FightEvent.TriggerAbility, function ( data )
		-- body
		--触发条件
		--触发对象
		--触发数值
		--触发开关
		--[[
		data.attacker 攻击者
		data.conditiontype
		data.openorclose
		data.defenders 默认为nil, 则有该被动技能选择目标, 否则使用defenders
		data.cirt
		--]]
		assert(data.attacker and data.conditiontype)

		-- local validDefenders
		-- if data.defenders then
		-- 	for i,v in ipairs (data.defenders) do
		-- 		if not v:isDisposed() then
		-- 			validDefenders = validDefenders or {}
		-- 			table.insert(validDefenders, v)
		-- 		end
		-- 	end
		-- 	data.defenders = validDefenders
		-- end

		-- if validDefenders then
		-- 	local idarray = {}
		-- 	for i,v in ipairs(validDefenders) do
		-- 		table.insert(idarray, v:getDyId())
		-- 	end
		-- 	print('found validDefenders condition='..data.conditiontype..',defenders='..table.concat(idarray,','))
		-- end
		-- Utils.calcDeltaTime(function ()
			-- body
			serverRoleArray:onSkillConditionByRole(data.attacker, data.conditiontype, data.openorclose, data.defenders, data.crit, data.carryData)
		-- end, '计算被动技能时间')

		
	end, 'Fight')

	--监听防守方被动触发
	EventCenter.addEventFunc(FightEvent.TriggerAbilityDef, function ( data )

		assert(data.attacker and data.conditiontype)
		serverRoleArray:onSkillConditionByRole2(data.attacker, data.conditiontype, data.openorclose, data.defenders, data.crit, data.carryData)
		
	end, 'Fight')

	--monster
	--监听怪物出生
	EventCenter.addEventFunc(FightEvent.Pve_S_MonsterBirth, function(dyvo)
		-- print('serverController Pve_S_MonsterBirth:')
		-- print(dyvo)
		local args = { 
			hp 			= true,
			atk 		= true,
			def 		= true,
			cri 		= true,
			spd 		= true,
			atktime 	= true,
			dyId 		= true,
			ismonster 	= true,
			charactorId = true,
			isboss 		= true,
			awaken 		= true,
		}

		args.hp 		= dyvo.hp
		args.hpMax 		= dyvo.HpMax or dyvo.hpMax 
		args.atk 		= dyvo.atk
		args.def 		= dyvo.def
		args.cri 		= dyvo.cri or dyvo.crit
		args.spd 		= dyvo.speed
		args.atktime 	= dyvo.atktime
		args.dyId 		= dyvo.playerId
		args.ismonster 	= true
		args.charactorId = dyvo.basicId
		args.isboss 	= dyvo.isboss 
		args.awaken 	= dyvo.awaken or #Awaken_Array

		args.heroid 	=   dyvo.heroid

		-- assert(args.awaken, '********************')

		--[[
		新增6项
		--]]
		args.sv 	=  	dyvo.sv
		args.fv 	=   dyvo.fv
		args.cv     =	dyvo.cv
		args.bd 	=	dyvo.bd
		args.hpR   	=   dyvo.hpR
		args.gb 	=	dyvo.gb
		args.eb 	= 	dyvo.eb 

		--
		args.mana   = dyvo.mana
		
		--basicId
		local item = CfgHelper.getCache('charactorConfig', 'id', dyvo.basicId)
		args.skillidarray = {}
		--近战技能, 大招技能
		table.insert( args.skillidarray, item.default_skill )
		table.insert( args.skillidarray, item.advance_skill )
		table.insert( args.skillidarray, item.skill_id )

		--
		assert(item.NPC_abilityarray)

		local unlock_num = Awaken_Array[args.awaken]

				-- 引导怪物的觉醒等级为0
		if args.ismonster and require 'ServerRecord'.getMode() == 'guider' then
			unlock_num = 0
		end

		for ii, vv in ipairs(item.NPC_abilityarray) do
			if ii > unlock_num then
				break
			end

			if vv ~= 0 then
				table.insert( args.skillidarray, vv )
			end
		end

		if require 'ServerRecord'.getMode() == 'guildfuben' then
			table.insert(args.skillidarray,6005)
		end

		local monster = ServerRoleFactory.createHeroByArgs(args)
		-- print('add monster : '..monster:getDyId() )
		table.insert( ServerController._monsterModuleArray, monster )

		monster:setIdentifyId( dyvo.ID )

		serverRoleArray:addRole( monster )
		monster:onBorn()

		ServerController.runWithDelay(function ()
			-- body
			--延迟一秒后触发技能
			if not monster:isDisposed() then
				local data = {
					attacker = true,
					conditiontype = true,
					openorclose = true,
				}
				data.attacker = monster
				-- data.conditiontype = SkillUtil.Condition_OnBattleField --位于战场
				data.openorclose = true
				-- EventCenter.eventInput(FightEvent.TriggerAbility, data)

				-- data = {}
				data.attacker = monster
				data.openorclose = true
				data.conditiontype = SkillUtil.Condition_WhatEver --触发无条件
				EventCenter.eventInput(FightEvent.TriggerAbility, data)

				-- local mydata = {}
				data.conditiontype = SkillUtil.Condition_HpGreater
				data.openorclose = true
				data.attacker = monster
				EventCenter.eventInput(FightEvent.TriggerAbility, data)

				-- mydata = {}
				data.conditiontype = SkillUtil.Condition_HpEqual
				data.openorclose = true
				data.attacker = monster
				EventCenter.eventInput(FightEvent.TriggerAbility, data)

				-- mydata = {}
				data.conditiontype = SkillUtil.Condition_HpLittle
				data.openorclose = true
				data.attacker = monster
				EventCenter.eventInput(FightEvent.TriggerAbility, data)

				monster:forceRefreshAtkSpd()
			end
		end, 1)

	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_Copy_Monster, function ( data )
		-- body
		local playerId 			= data.playerId
		local birthPos 			= data.birthPos
		local sourceMonsterId 	= data.sourceMonsterId
		-- local ai 				= data.ai

		assert(playerId and birthPos and sourceMonsterId)
		-- assert(ai)

		local serverRole = serverRoleArray:findRoleByDyIdAnyway( playerId ) 

		if not serverRole then
			print(serverRoleArray)
		end

		assert(serverRole, 'No serverRole '..tostring(playerId))

		if serverRole then
			-- serveMonsterDyVo.dyId			= -1
			-- serveMonsterDyVo.playerId 		= IDCreator.getID()
			-- serveMonsterDyVo.entertime 		= waveData.entertime
			-- serveMonsterDyVo.enterposition 	= waveData.enterposition
			-- serveMonsterDyVo.isboss 		= waveData.isboss
			-- serveMonsterDyVo.basicId 		= waveData.role.charactorId
			-- serveMonsterDyVo.hp 			= waveData.role.hp
			-- serveMonsterDyVo.maxHp 			= waveData.role.hp
			-- serveMonsterDyVo.atk 			= waveData.role.atk
			-- serveMonsterDyVo.def 			= waveData.role.def
			-- serveMonsterDyVo.cri 			= waveData.role.cri or waveData.role.crit
			-- assert(serveMonsterDyVo.cri)

			-- serveMonsterDyVo.speed			= waveData.role.spd
			-- serveMonsterDyVo.atktime		= waveData.role.atktime
			-- serveMonsterDyVo.aiType			= waveData.role.aiType

			-- serveMonsterDyVo.birthPos 		= serveMonsterDyVo:getBirthPos()

			local serverMonsterDyVo 		= ServeMonsterDyVo.new()
			serverMonsterDyVo.dyId 			= -1
			serverMonsterDyVo.playerId 		= require 'IDCreator'.getID()
			serverMonsterDyVo.entertime		= -1  --需要立即执行
			serverMonsterDyVo.enterposition = -1
			serverMonsterDyVo.isboss 		= 0
			serverMonsterDyVo.basicId 		= serverRole:getBasicId()

			serverMonsterDyVo.hp 			= math.max( serverRole:getHpD(), 10) 
			serverMonsterDyVo.hpMax 		= serverRole:getBasicHpD() 
			serverMonsterDyVo.atk 			= CSValueConverter.toS( serverRole.atk )
			serverMonsterDyVo.def           = CSValueConverter.toS( serverRole.def )
			
			serverMonsterDyVo.cri 			= serverRole.cri
			serverMonsterDyVo.speed 		= serverRole.spd
			serverMonsterDyVo.atktime       = serverRole.atktime
			serverMonsterDyVo.awaken        = serverRole.awaken
			serverMonsterDyVo.aiType        = require 'AIType'.Copy2_Type
			serverMonsterDyVo.birthPos      = birthPos
			

			local spwdm = ServerController.getServerPveWavesDyManger()
			if spwdm then
				local mwdm = spwdm:getCurrentMonsterWaveDyManager()
				if mwdm then
					mwdm:insertServeMonsterDyVo(serverMonsterDyVo)
				end
			end

			local sourceMonster = serverRoleArray:findRoleByDyIdAnyway(sourceMonsterId)
			assert(sourceMonster)

			if sourceMonster then
				sourceMonster:setDisposed()
			end

		else
			print('Not Exsit Hero '..playerId..' For Copy!')
		end
	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_QuickDie, function ( data )
		-- body
		assert(data)
		assert(data.playerId)

		local sourceMonster = serverRoleArray:findRoleByDyIdAnyway(data.playerId)
		assert(sourceMonster)

		if sourceMonster then
			sourceMonster:setDisposed()
		end

	end, 'Fight')
	
	--复制超梦变身
	EventCenter.addEventFunc(FightEvent.Pve_Copy_Monster_CMBS, function ( data )
		-- body
		local birthPos 			= data.birthPos
		local sourceMonsterId 	= data.sourceMonsterId
		assert(birthPos and sourceMonsterId)
		assert(data.basicId)
		assert(data.hp)
		assert(data.hpMax)
		-- assert(data.atk)
		assert(data.def)
		assert(data.cri)
		assert(data.speed)
		assert(data.atktime)

		local sourceMonster = serverRoleArray:findRoleByDyIdAnyway(sourceMonsterId)
		assert(sourceMonster)

		local serverMonsterDyVo 		= ServeMonsterDyVo.new()
		serverMonsterDyVo.dyId 			= -1
		serverMonsterDyVo.playerId 		= require 'IDCreator'.getID()
		serverMonsterDyVo.entertime		= -1  --需要立即执行
		serverMonsterDyVo.enterposition = 1
		serverMonsterDyVo.isboss 		= 1
		serverMonsterDyVo.basicId 		= data.basicId
		serverMonsterDyVo.hp 			= data.hp
		serverMonsterDyVo.hpMax 		= data.hpMax
		serverMonsterDyVo.atk 			= sourceMonster.atk --data.atk
		serverMonsterDyVo.def           = data.def
		serverMonsterDyVo.cri 			= data.cri
		serverMonsterDyVo.speed 		= data.speed
		serverMonsterDyVo.atktime       = data.atktime
		serverMonsterDyVo.aiType        = require 'AIType'.Copy2_CMBS_Type
		serverMonsterDyVo.birthPos      = birthPos


		local spwdm = ServerController.getServerPveWavesDyManger()
		if spwdm then
			local mwdm = spwdm:getCurrentMonsterWaveDyManager()
			if mwdm then
				mwdm:insertServeMonsterDyVo(serverMonsterDyVo)
			end
		end

		if sourceMonster then
			sourceMonster:setDisposed()
		end
	end, 'Fight')

	--监听战斗伤害计算
	EventCenter.addEventFunc(FightEvent.Pve_SendAction, function ( data )
		--伤害计算
		print('监听从客户端发来的技能计算')
		print(data.D)

		-- Utils.calcDeltaTime(function ()
			-- body
			serverRoleArray:battleCalc( data.D )
		-- end, '计算战斗协议时间')
	end, 'Fight')

	--监听波数事件
	--下一波即将出现 
	-- fightEvent.Pve_NextWaveComing="Pve_NextWaveComing"
	-- local data = { isboss = self._waveArr[self._playIndex]:isBossWave(), waveIndex = self._playIndex }
	-- eventCenter.eventInput(fightEvent.Pve_NextWaveComing, data)	--//参数  true表示为boss false 表示为不是boss波数
	EventCenter.addEventFunc(FightEvent.Pve_NextWaveComing, function ( data )
		-- body
		--触发回合的被动技能
		local heroarray = serverRoleArray:getHeroArray()
		for i, role in ipairs(heroarray) do
			if role:isBorned() then

				local mydata = {}
				mydata.conditiontype = SkillUtil.Condition_FightRound
				mydata.openorclose = true
				mydata.attacker = role
				EventCenter.eventInput(FightEvent.TriggerAbility, mydata)

				--取消boss波效果
				mydata.conditiontype = SkillUtil.Condition_FightBossRound
				mydata.openorclose = false
				EventCenter.eventInput(FightEvent.TriggerAbility, mydata)
				
				if data.isboss then
					mydata.openorclose = true
					EventCenter.eventInput(FightEvent.TriggerAbility, mydata)
				end
			end
		end
	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_Monster_Property_Change, function ( data )
		-- body
		--触发回合的被动技能
		local playerId = data.playerId

		local serverRole = serverRoleArray:findRoleByDyIdAnyway(playerId)

		if serverRole then
			if data.atk_times then
				serverRole.atk = serverRole.basicAtk * data.atk_times
			end
		end
	end, 'Fight')

	--监听替补上场
	local benchIndex = 5
	local enemyBenchIndex = 5
	EventCenter.addEventFunc(FightEvent.Pve_ComeOffBench, function ( data )
		-- body
		if not require 'ServerRecord'.isArenaMode() then
			if data.isHero and ServerController._heroModuleArray then
				benchIndex = benchIndex + 1
				bornHero(serverRoleArray, ServerController._heroModuleArray, benchIndex )
			end
		else
			if data.isHero and ServerController._heroModuleArray then
				benchIndex = benchIndex + 1
				bornAIPlayer_Hero(serverRoleArray, ServerController._heroModuleArray, benchIndex, true )
			elseif (not data.isHero) and ServerController._enemyModuleArray then
				enemyBenchIndex = enemyBenchIndex + 1
				bornAIPlayer_Hero(serverRoleArray, ServerController._enemyModuleArray, enemyBenchIndex, false )
			end
		end
	end, 'Fight')

	--处理歌舞类技能
	EventCenter.addEventFunc(FightEvent.Pve_removeGeWuBuff, function ( data )
		-- body data = player
		-- 歌舞类技能被打断
		print('--------歌舞打断!!----------')
		-- print(debug.traceback())
		local bigSkillId = data.roleDyVo.skill_id
		assert(bigSkillId > 0)

		local serverRole = serverRoleArray:findRoleByDyIdAnyway( data.roleDyVo.playerId )
		assert( serverRole )

		serverRole:stopDanceSkill( bigSkillId )
	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_Protect, function ( data )
		-- body
		--dur 单位是毫秒
		-- { Hid=xxx, Dur = xxx }
		local serverRole = serverRoleArray:findRoleByDyIdAnyway( data.Hid )
		if serverRole then
			serverRole:setProtectTime( data.Dur/1000 )
			print('Protect id = '..tostring(data.Hid)..' , Dur = '..tostring(data.Dur))
		else
			print('No Protect id = '..tostring(data.Hid)..' , Dur = '..tostring(data.Dur))
		end
	end, 'Fight')


	EventCenter.addEventFunc('Guide_Pve_FightPause', function ( data )
		-- body
		if data then
			FightSettings.pause()
		else
			FightSettings.resume()
		end
	end, 'Fight')


	EventCenter.addEventFunc(FightEvent.Pve_AddMana, function ( data )
		-- body
		local serverRole = ServerController.findRoleByDyIdAnyway(data.playerId)
		if serverRole then
			serverRole:addMana( data.mana )
		else
			-- assert(false)
		end
	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_SubMana, function ( data )
		-- body
		-- assert(false)
		assert(data.playerId)
		local serverRole = ServerController.findRoleByDyIdAnyway(data.playerId)
		if serverRole then
			serverRole:subMana()
		else
			-- assert(false)
		end
	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_ManaLock, function ( data )
		-- body
		assert(data.playerId)
		local serverRole = ServerController.findRoleByDyIdAnyway(data.playerId)
		if serverRole then
			serverRole:setManaLocked( data.lockMana )
		end
	end, 'Fight')

end

ServerController.loadPetList = function ( teamid )
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

--[[
--]]
ServerController.loadGuiderPetList = function ( teamid )
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

--加载pve英雄上场
ServerController.loadHeroTeam = function ( serverRoleArray, petList )
	-- body

	local heroModuleArray = createHeroArray(serverRoleArray, petList, true)
	ServerController._heroModuleArray = heroModuleArray -- 为替补上场保存

	--前5个上场
	local count = 0
	for i,v in ipairs(heroModuleArray) do
		if not v:isDisposed() then
			bornHero(serverRoleArray, heroModuleArray, i)
			
			count = count + 1
			if count >= 5 then
				break
			end
		end
	end
end

ServerController.loadHeroTeamForArena = function ( serverRoleArray, petList, isSelfOrOther )
	-- body

	local heroModuleArray = createHeroArray(serverRoleArray, petList, isSelfOrOther)

	if isSelfOrOther then
		ServerController._heroModuleArray = heroModuleArray -- 为替补上场保存
	else
		ServerController._enemyModuleArray = heroModuleArray -- 为替补上场保存
	end

	--前5个上场
	for i,v in ipairs(heroModuleArray) do
		if i > 5 then
			break
		end

		--延迟???
		-- ServerController.runWithDelay(function ( ... )
			-- body
			bornAIPlayer_Hero(serverRoleArray, heroModuleArray, i, isSelfOrOther)
		-- end, 0.1 * i)
		
	end
end

--[[
data 包含 teamid 和 fubenid

--测试
data.teamid
data.fubenid

--正式
data.battleid -> funben
data.petList  

--接入测试副本
--]]
local function isFirstStage( battleId )
	-- body
	local battleIdArray = { 10001,10002,101011,101012 }
	for i,v in ipairs(battleIdArray) do
		if v == battleId then
			return true
		end
	end

	return false
end

ServerController.start = function ( paramsData )
	
	ServerController._battleBuffer = paramsData.battleBuffer or {}
	print('BattleBuffer')
	print(paramsData.battleBuffer)

	print('BattleParamsData')
	print(paramsData)
	-- ServerController._battleBuffer[8] = 1.1
	-- ServerController._battleBuffer[9] = 1.1

	if paramsData.type == 'test' and paramsData.teamid and paramsData.fubenid then
		ServerController.startForTest(paramsData.teamid, paramsData.fubenid)
	elseif paramsData.type == 'guider' and paramsData.teamid and paramsData.battleId then
		ServerController.startForGuider(paramsData.teamid, paramsData.battleId)
	elseif paramsData.type == 'fuben' and paramsData.petList and paramsData.battleId then
		-- 第一场战斗
		if paramsData.battleId == 10001 and (require 'GuideHelper':getLastSavePoint() < 1610)  then
			GleeCore:showLayer('FirstFightGuider')
			EventCenter.eventInput(FightEvent.Pve_FirstFight)
		elseif paramsData.battleId == 10002 and (require 'GuideHelper':getLastSavePoint() < 1700) then
			EventCenter.eventInput(FightEvent.Pve_SecondFight)
		end

		if isFirstStage(paramsData.battleId) then
			EventCenter.eventInput(FightEvent.Pve_FirstStage)
		end

		ServerController.startForBattle(paramsData.petList, paramsData.battleId, paramsData.triggerStory)
	elseif paramsData.type == 'fuben_boss' and paramsData.petList and paramsData.battleId then
		-- 第一场战斗
		if paramsData.battleId == 10001 and (require 'GuideHelper':getLastSavePoint() < 1610)  then
			GleeCore:showLayer('FirstFightGuider')
			EventCenter.eventInput(FightEvent.Pve_FirstFight)
		elseif paramsData.battleId == 10002 and (require 'GuideHelper':getLastSavePoint() < 1700) then
			EventCenter.eventInput(FightEvent.Pve_SecondFight)
		end

		if isFirstStage(paramsData.battleId) then
			EventCenter.eventInput(FightEvent.Pve_FirstStage)
		end

		ServerController.startForBattleFubenBoss(paramsData.petList, paramsData.battleId, paramsData.triggerStory)
		-- data.D.Towns[1].Stars
	elseif paramsData.type == 'fuben_cat' and paramsData.petList and paramsData.battleId then
		ServerController.startForFubenCat(paramsData.petList, paramsData.battleId)
	elseif paramsData.type == 'fuben_thief' and paramsData.petList and paramsData.battleId then
		ServerController.startForFubenThief(paramsData.petList, paramsData.battleId)
	elseif paramsData.type == 'champion' and paramsData.myTeam and paramsData.npcTeam then
		ServerController.startForChampion(paramsData.myTeam, paramsData.npcTeam)
	elseif paramsData.type == 'bossBattle' and paramsData.petList and paramsData.boss and paramsData.Bid then
		ServerController.startForBossBattle(paramsData.petList, paramsData.boss, paramsData.Bid)
	elseif paramsData.type == 'CMBossBattle' and paramsData.petList and paramsData.boss and paramsData.Bid then
		ServerController.startForCMBossBattle(paramsData.petList, paramsData.boss, paramsData.Bid)
	elseif paramsData.type == 'SDNBossBattle' and paramsData.petList and paramsData.boss and paramsData.Bid then
		ServerController.startForSDNBossBattle(paramsData.petList, paramsData.boss, paramsData.Bid)
	elseif paramsData.type == 'ActRaid' and paramsData.petList and paramsData.battleId then
		ServerController.startForActRaid(paramsData.petList, paramsData.battleId)
	elseif paramsData.type == 'arena' and paramsData.petList and paramsData.enemyList and paramsData.seed then
		-- assert(paramsData.petBornIJList)
		-- assert(paramsData.enemyBornIJList)
		ServerController.startForArena(paramsData.petList, paramsData.enemyList, paramsData.seed,paramsData.petBornIJList,paramsData.enemyBornIJList)
	elseif paramsData.type == 'arena-record' and paramsData.petList and paramsData.enemyList and paramsData.seed then
		-- assert(paramsData.petBornIJList)
		-- assert(paramsData.enemyBornIJList)
		ServerController.startForArenaRecord(paramsData.petList, paramsData.enemyList, paramsData.seed, paramsData.isChallenger,paramsData.petBornIJList,paramsData.enemyBornIJList)
	elseif paramsData.type == 'league' and paramsData.petList and paramsData.enemyList and paramsData.seed then
		-- assert(paramsData.petBornIJList)
		-- assert(paramsData.enemyBornIJList)
		ServerController.startForLeague(paramsData.petList, paramsData.enemyList, paramsData.seed,paramsData.petBornIJList,paramsData.enemyBornIJList)
	
	elseif paramsData.type == 'train' and paramsData.myTeam and paramsData.npcTeam then
		ServerController.startForTrain(paramsData.myTeam, paramsData.npcTeam)
	elseif paramsData.type == 'guildmatch' then
		ServerController.startForGuildMatch(paramsData.petList,paramsData.enemyList,paramsData.additionTable,paramsData.petBornIJList,paramsData.enemyBornIJList)
	elseif paramsData.type == 'guildboss' then
		ServerController.startForGuildBoss(paramsData.petList,paramsData.battleId,paramsData.petBornIJList)
	elseif paramsData.type == 'guildfuben' then
		ServerController.startForGuildFuben(paramsData.petList,paramsData.enemyList,paramsData.additionTable,paramsData.petBornIJList,paramsData.enemyBornIJList)
	elseif paramsData.type == 'limit_fuben' then
		ServerController.startForLimitFuben(paramsData.petList,paramsData.enemyList,paramsData.additionTable,paramsData.petBornIJList,paramsData.enemyBornIJList)
	elseif paramsData.type == 'guildfuben_rob' then
		ServerController.startForGuildFubenRob(paramsData.petList, paramsData.enemyList, paramsData.seed,paramsData.petBornIJList,paramsData.enemyBornIJList)
	elseif paramsData.type == 'guildfuben_revenge' then
		ServerController.startForGuildFubenRevenge(paramsData.petList, paramsData.enemyList, paramsData.seed,paramsData.petBornIJList,paramsData.enemyBornIJList)
	elseif paramsData.type == 'RemainsFuben' then
		ServerController.startForRemainsFuben(paramsData.petList,paramsData.enemyList,paramsData.petBornIJList,paramsData.enemyBornIJList)
	elseif paramsData.type == 'friend' and paramsData.petList and paramsData.enemyList and paramsData.seed then
		-- assert(paramsData.petBornIJList)
		-- assert(paramsData.enemyBornIJList)
		ServerController.startForFriend(paramsData.petList, paramsData.enemyList, paramsData.seed,paramsData.petBornIJList,paramsData.enemyBornIJList)
	else
		print('-----Unexpected ServerController start data ---------')
		print(paramsData)
		assert(false)
	end
end

ServerController.AdjustBornIJList = function ( petBornIJList,enemyBornIJList )
	--一对一精灵的站位调整
	if petBornIJList and enemyBornIJList and #petBornIJList == 1 and #enemyBornIJList == 1 then
		local petij = petBornIJList[1]
		local enemyij = enemyBornIJList[1]
		if math.abs(petij.j - enemyij.j) == 1 then
			enemyij.j = petij.j
		end
	end
end

ServerController.getServerHeroArray = function ()
	-- body
	return ServerController._heroModuleArray
end

ServerController.getServerEnemyModuleArray = function ( ... )
	-- body
	return ServerController._enemyModuleArray
end

ServerController.getServerMonsterArray = function ()
	-- body
	return ServerController._monsterModuleArray
end

ServerController.startUpdateController = function ()
	-- body
	assert(ServerController._updatehandle == nil)
	--buff update handle
	ServerController._updatehandle = FightTimer.addFunc(function ( dt )
		-- body
		-- dt = dt/1000
		-- Utils.calcDeltaTime(function ()
			-- body
			ServerController._serverRoleArray:check()
			ServerController._serverRoleArray:updateRole( dt )
			ServerController._serverRoleArray:updateBuff( dt )

			require 'SkillChainManager'.update(dt)
			require 'ServerRecord'.calcTime(dt)

			ServerController.gc(dt)

			-- end, '计算ServerController时间')
	end)
end

---引导
function ServerController.startForGuider( teamid, battleId )
	-- body
	--新建角色数组
	--PVE 战斗开始
	ServerController.reset( 1 )

	require 'FightGuiderController'.start()
	EventCenter.eventInput(FightEvent.StartGuiderTimer)

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	require 'ServerRecord'.setMode('guider')
	require 'ServerRecord'.setBattleId( battleId )

	-- ServerController.runWithDelay(function ()
	-- 	-- body
	-- 	EventCenter.eventInput(FightEvent.Guider_CMBS)
	-- end, 5)
	

	print(string.format('battleId = %d, teamId = %d !', battleId, teamid))

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	local petList = ServerController.loadGuiderPetList(teamid)

	ServerController.initEventFunc( serverRoleArray )
	ServerController.loadHeroTeam(serverRoleArray, petList)

	--创建能量球
	ServeSlotManager.new(serverRoleArray)
	-- :PVEStartCreate()	

	local fubenData = ServerController.fubenFromBattleId(battleId)

	local servePveWavesDyManger = ServePveWavesDyManger.new()
	servePveWavesDyManger:init( fubenData )
	servePveWavesDyManger:startNext()

	ServerController._servePveWavesDyManger = servePveWavesDyManger

	ServerController.startUpdateController()
end

ServerController.startForTest = function ( teamid, fubenid )
	--新建角色数组
	--PVE 战斗开始
	-- teamid = 11138
	-- fubenid = 21048
	ServerController.reset( 1 )
	EventCenter.eventInput(FightEvent.StartGuiderTimer)

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	require 'ServerRecord'.setMode('test')
	require 'ServerRecord'.setBattleId( fubenid )

	print(string.format('fubenId = %d, teamId = %d !', fubenid, teamid))

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	local petList = ServerController.loadPetList(teamid)

	ServerController.initEventFunc( serverRoleArray )
	ServerController.loadHeroTeam(serverRoleArray, petList)

	--创建能量球
	ServeSlotManager.new(serverRoleArray)
	-- :PVEStartCreate()	

	local fubenData = ServerController.fubenFromFubenId(fubenid)

	local servePveWavesDyManger = ServePveWavesDyManger.new()
	servePveWavesDyManger:init( fubenData )
	servePveWavesDyManger:startNext()

	ServerController._servePveWavesDyManger = servePveWavesDyManger

	ServerController.startUpdateController()
end

--data.data.triggerStory
ServerController.startForBattle = function ( petList, battleId, triggerStory )
	--新建角色数组
	--PVE 战斗开始
	ServerController.reset()

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	require 'ServerRecord'.setMode('fuben')
	require 'ServerRecord'.setBattleId( battleId )

	print(string.format('battleId = %d !', battleId))

	print(petList)

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)
	ServerController.loadHeroTeam(serverRoleArray, petList)

	--创建能量球
	ServeSlotManager.new(serverRoleArray)
	-- :PVEStartCreate()	

	local fubenData = ServerController.fubenFromBattleId(battleId)

	local servePveWavesDyManger = ServePveWavesDyManger.new()
	servePveWavesDyManger:init( fubenData )
	servePveWavesDyManger:startNext()

	ServerController._servePveWavesDyManger = servePveWavesDyManger

	ServerController.startUpdateController()

	--增加限时
	local countTime = fubenData.TimeLimit or 0
	if countTime > 0 then
		EventCenter.eventInput(FightEvent.StartTimer, countTime)
		ServerController.logicTimeCount( countTime )
	end

	if triggerStory then
		ServerController.runWithDelay(function ()
			-- body
			triggerStory()
		end, 3.1)
	end
end

--data.data.triggerStory
ServerController.startForBattleFubenBoss = function ( petList, battleId, triggerStory )
	--新建角色数组
	--PVE 战斗开始
	ServerController.reset()

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	require 'ServerRecord'.setMode('fuben_boss')
	require 'ServerRecord'.setBattleId( battleId )

	print(string.format('battleId = %d !', battleId))

	print(petList)

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)
	ServerController.loadHeroTeam(serverRoleArray, petList)

	--创建能量球
	ServeSlotManager.new(serverRoleArray)
	-- :PVEStartCreate()	

	local fubenData = ServerController.fubenFromBattleId(battleId)

	local servePveWavesDyManger = ServePveWavesDyManger.new()
	servePveWavesDyManger:init( fubenData )
	servePveWavesDyManger:startNext()

	ServerController._servePveWavesDyManger = servePveWavesDyManger

	ServerController.startUpdateController()

	--增加限时
	local countTime = fubenData.TimeLimit or 0
	if countTime > 0 then
		EventCenter.eventInput(FightEvent.StartTimer, countTime)
		ServerController.logicTimeCount( countTime )
	end

	if triggerStory then
		ServerController.runWithDelay(function ()
			-- body
			triggerStory()
		end, 3.1)
	end
end

ServerController.startForFubenCat = function ( petList, battleId )
	--新建角色数组
	--PVE 战斗开始
	ServerController.reset()

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	require 'ServerRecord'.setMode('fuben_cat')
	require 'ServerRecord'.setBattleId( battleId )

	print(string.format('Cat battleId = %d !', battleId))

	print(petList)
	
	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)
	ServerController.loadHeroTeam(serverRoleArray, petList)

	--创建能量球
	ServeSlotManager.new(serverRoleArray)
	-- :PVEStartCreate()	

	local fubenData = ServerController.fubenFromBattleId(battleId)

	local servePveWavesDyManger = ServePveWavesDyManger.new()
	servePveWavesDyManger:init( fubenData )
	servePveWavesDyManger:startNext()

	ServerController._servePveWavesDyManger = servePveWavesDyManger

	ServerController.startUpdateController()

	----倒计时
	local countTime = CfgHelper.getCache('BattleSetConfig', 'Key', 'cattime', 'Value')
	assert(countTime)
	EventCenter.eventInput(FightEvent.StartTimer, countTime)
	ServerController.logicTimeCount( countTime )
end


function ServerController.startForChampion( petList, monsterList )
	-- body
	ServerController.reset()

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	require 'ServerRecord'.setMode( 'champion' )

	print('PetList')
	print(petList)

	print('MonsterList')
	print(monsterList)

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)
	ServerController.loadHeroTeam(serverRoleArray, petList)

	--创建能量球
	ServeSlotManager.new(serverRoleArray)
	-- :PVEStartCreate()	

	local fubenData = ServerController.loadFubenFromList(monsterList)

	local servePveWavesDyManger = ServePveWavesDyManger.new()
	servePveWavesDyManger:init( fubenData )
	servePveWavesDyManger:startNext()

	ServerController._servePveWavesDyManger = servePveWavesDyManger

	ServerController.startUpdateController()

	EventCenter.eventInput( FightEvent.Pve_StartLadyBallForChampion )

end

function ServerController.startForTrain( petList,monsterList )
	ServerController.reset()

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	require 'ServerRecord'.setMode( 'train' )

	print('PetList')
	print(petList)

	print('MonsterList')
	print(monsterList)

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)
	ServerController.loadHeroTeam(serverRoleArray, petList)

	--创建能量球
	ServeSlotManager.new(serverRoleArray)
	-- :PVEStartCreate()	

	local fubenData = ServerController.loadFubenFromList(monsterList)

	local servePveWavesDyManger = ServePveWavesDyManger.new()
	servePveWavesDyManger:init( fubenData )
	servePveWavesDyManger:startNext()

	ServerController._servePveWavesDyManger = servePveWavesDyManger

	ServerController.startUpdateController()

	-- EventCenter.eventInput( FightEvent.Pve_StartLadyBallForChampion )
	----倒计时	
	local countTime = CfgHelper.getCache('BattleSetConfig', 'Key', 'AdvBattleTimeLimit', 'Value')
	assert(countTime)
	EventCenter.eventInput(FightEvent.StartTimer, countTime)
	ServerController.logicTimeCount( countTime )
end

---活动副本
function ServerController.startForActRaid( petList, battleId )
	-- body
	--新建角色数组
	--PVE 战斗开始
	ServerController.reset()

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	require 'ServerRecord'.setMode('ActRaid')
	require 'ServerRecord'.setBattleId( battleId )

	print(string.format('ActRaid battleId = %d !', battleId))

	print(petList)

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)
	ServerController.loadHeroTeam(serverRoleArray, petList)

	--创建能量球
	ServeSlotManager.new(serverRoleArray)
	-- :PVEStartCreate()	

	local fubenData = ServerController.fubenFromBattleId(battleId)

	local servePveWavesDyManger = ServePveWavesDyManger.new()
	servePveWavesDyManger:init( fubenData )
	servePveWavesDyManger:startNext()

	ServerController._servePveWavesDyManger = servePveWavesDyManger

	ServerController.startUpdateController()

	--增加限时
	local countTime = fubenData.TimeLimit or 0
	if countTime > 0 then
		EventCenter.eventInput(FightEvent.StartTimer, countTime)
		ServerController.logicTimeCount( countTime )
	end
end

---活动副本
function ServerController.startForFubenThief( petList, battleId )
	-- body
	--新建角色数组
	--PVE 战斗开始
	ServerController.reset()

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	require 'ServerRecord'.setMode('fuben_thief')
	require 'ServerRecord'.setBattleId( battleId )

	print(string.format('fuben_thief battleId = %d !', battleId))

	print(petList)

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)
	ServerController.loadHeroTeam(serverRoleArray, petList)

	--创建能量球
	ServeSlotManager.new(serverRoleArray)
	-- :PVEStartCreate()	

	local fubenData = ServerController.fubenFromBattleId(battleId)

	local servePveWavesDyManger = ServePveWavesDyManger.new()
	servePveWavesDyManger:init( fubenData )
	servePveWavesDyManger:startNext()

	ServerController._servePveWavesDyManger = servePveWavesDyManger

	ServerController.startUpdateController()

	--增加限时
	local countTime = fubenData.TimeLimit or 0
	if countTime > 0 then
		EventCenter.eventInput(FightEvent.StartTimer, countTime)
		ServerController.logicTimeCount( countTime )
	end

end

---竞技场
function ServerController.startForArena( petList, enemyList, seed, petBornIJList, enemyBornIJList )
	-- body
	ServerController.reset(seed)
	ServerController.setBornIJArrays( petBornIJList, enemyBornIJList )

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	require 'ServerRecord'.setMode( 'arena' )

	print('PetList')
	print(petList)

	print('EnemyList')
	print(enemyList)

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)

	ServerController.loadHeroTeamForArena(serverRoleArray, petList, true)

	ServerController.loadHeroTeamForArena(serverRoleArray, enemyList, false)

	ServerController.startUpdateController()

	----倒计时
	local countTime = CfgHelper.getCache('BattleSetConfig', 'Key', 'arenatime', 'Value')
	assert(countTime)
	EventCenter.eventInput(FightEvent.StartTimer, countTime)
	ServerController.logicTimeCount( countTime )
end

---竞技场
function ServerController.startForLeague( petList, enemyList, seed, petBornIJList, enemyBornIJList )
	-- body
	ServerController.reset(seed)
	ServerController.AdjustBornIJList(petBornIJList, enemyBornIJList)
	ServerController.setBornIJArrays( petBornIJList, enemyBornIJList )

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	require 'ServerRecord'.setMode( 'league' )

	print('PetList')
	print(petList)

	print('EnemyList')
	print(enemyList)

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)

	ServerController.loadHeroTeamForArena(serverRoleArray, petList, true)

	ServerController.loadHeroTeamForArena(serverRoleArray, enemyList, false)

	ServerController.startUpdateController()

	----倒计时
	local countTime = CfgHelper.getCache('BattleSetConfig', 'Key', 'arenatime', 'Value')
	assert(countTime)
	EventCenter.eventInput(FightEvent.StartTimer, countTime)
	ServerController.logicTimeCount( countTime )
end

---竞技场
function ServerController.startForFriend( petList, enemyList, seed, petBornIJList, enemyBornIJList )
	-- body
	ServerController.reset(seed)
	ServerController.setBornIJArrays( petBornIJList, enemyBornIJList )

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	require 'ServerRecord'.setMode( 'friend' )

	print('PetList')
	print(petList)

	print('EnemyList')
	print(enemyList)

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)

	ServerController.loadHeroTeamForArena(serverRoleArray, petList, true)

	ServerController.loadHeroTeamForArena(serverRoleArray, enemyList, false)

	ServerController.startUpdateController()

	----倒计时
	local countTime = CfgHelper.getCache('BattleSetConfig', 'Key', 'arenatime', 'Value')
	assert(countTime)
	EventCenter.eventInput(FightEvent.StartTimer, countTime)
	ServerController.logicTimeCount( countTime )
end

function ServerController.logicTimeCount( seconds, isdefender )
	-- body
	print('logicTimeCount')
	print(seconds)
	print(isdefender)

	if seconds <= 0 then
		return 
	end

	local serverRoleArray = ServerController._serverRoleArray
	local timeCount = 0
	local arenaHandler = FightTimer.addFunc(function ( dt )

		if require 'ServerRecord'.isArenaMode() then
			if not serverRoleArray:hasHeroExisted() then
				EventCenter.eventInput(FightEvent.Pve_PreGameOverData, require 'ServerRecord'.createGameOverData(false))
				return true
			elseif not serverRoleArray:hasEnemyExisted() then
				EventCenter.eventInput(FightEvent.Pve_PreGameOverData, require 'ServerRecord'.createGameOverData(true))
				return true
			end
		end

		timeCount = timeCount + dt
		if timeCount > seconds then

			if require 'ServerRecord'.isArenaMode() then
				if isdefender then
					EventCenter.eventInput(FightEvent.Pve_GameOverQuick, require 'ServerRecord'.createGameOverData(true))
				else
					EventCenter.eventInput(FightEvent.Pve_GameOverQuick, require 'ServerRecord'.createGameOverData(false))
				end

				return true
			end

			EventCenter.eventInput(FightEvent.Pve_GameOverQuick, require 'ServerRecord'.createGameOverData(false))
			return true
		end
	end)

	require 'ServerRecord'.setArenaHandler(arenaHandler)
end



---竞技场记录
function ServerController.startForArenaRecord( petList, enemyList, seed, isChallenger, petBornIJList, enemyBornIJList )
	-- body
	ServerController.reset(seed)
	ServerController.setBornIJArrays( petBornIJList, enemyBornIJList )

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	require 'ServerRecord'.setMode( 'arena-record' )

	print('PetList')
	print(petList)

	print('EnemyList')
	print(enemyList)

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)

	if isChallenger then
		ServerController.loadHeroTeamForArena(serverRoleArray, petList, true)
		ServerController.loadHeroTeamForArena(serverRoleArray, enemyList, false)
	else
		-- assert(false)
		ServerController.loadHeroTeamForArena(serverRoleArray, enemyList, false)
		ServerController.loadHeroTeamForArena(serverRoleArray, petList, true)
	end

	ServerController.startUpdateController()

	----倒计时
	local countTime = CfgHelper.getCache('BattleSetConfig', 'Key', 'arenatime', 'Value')
	assert(countTime)
	EventCenter.eventInput(FightEvent.StartTimer, countTime)

	ServerController.logicTimeCount( countTime, not isChallenger )
end

-- 
function ServerController.startForBossBattle( petList, worldBoss, bid )
	-- body
	ServerController.reset()
	require 'ServerRecord'.setMode( 'bossBattle' )

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	print('PetList')
	print(petList)

	print('WorldBoss')
	print(worldBoss)

	worldBoss.isboss = 1

	require 'ServerRecord'.setBossHp( worldBoss.hp )
	require 'ServerRecord'.setBossHpMax( worldBoss.HpMax )
	require 'ServerRecord'.setBossId( bid )

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)
	ServerController.loadHeroTeam(serverRoleArray, petList)

	--创建能量球
	ServeSlotManager.new(serverRoleArray)
	-- :PVEStartCreate()	

	local fubenData = ServerController.loadFubenFromList( { worldBoss } )

	local servePveWavesDyManger = ServePveWavesDyManger.new()
	servePveWavesDyManger:init( fubenData )
	servePveWavesDyManger:startNext()

	ServerController._servePveWavesDyManger = servePveWavesDyManger

	ServerController.startUpdateController()

	----倒计时
	local countTime = CfgHelper.getCache('BattleSetConfig', 'Key', 'SpecialBossTimeLimit', 'Value')
	assert(countTime)
	EventCenter.eventInput(FightEvent.StartTimer, countTime)
	ServerController.logicTimeCount( countTime )
end


function ServerController.startForCMBossBattle( petList, worldBoss, bid )
	-- body
	ServerController.reset()
	require 'ServerRecord'.setMode( 'CMBossBattle' )

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	print('PetList')
	print(petList)

	print('WorldBoss')
	print(worldBoss)

	worldBoss.isboss = 1

	require 'ServerRecord'.setBossHp( worldBoss.hp )
	require 'ServerRecord'.setBossHpMax( worldBoss.HpMax )
	require 'ServerRecord'.setBossId( bid )

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)
	ServerController.loadHeroTeam(serverRoleArray, petList)

	--创建能量球
	ServeSlotManager.new(serverRoleArray)
	-- :PVEStartCreate()	

	local fubenData = ServerController.loadFubenFromList( { worldBoss } )

	local servePveWavesDyManger = ServePveWavesDyManger.new()
	servePveWavesDyManger:init( fubenData )
	servePveWavesDyManger:startNext()

	ServerController._servePveWavesDyManger = servePveWavesDyManger

	ServerController.startUpdateController()

	----倒计时
	local countTime = CfgHelper.getCache('BattleSetConfig', 'Key', 'BossActiveTimeLimit', 'Value')
	assert(countTime)
	EventCenter.eventInput(FightEvent.StartTimer, countTime)
	ServerController.logicTimeCount( countTime )
end

function ServerController.startForSDNBossBattle( petList, worldBoss, bid )
	-- body
	ServerController.reset()
	require 'ServerRecord'.setMode( 'SDNBossBattle' )

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	print('PetList')
	print(petList)

	print('WorldBoss')
	print(worldBoss)

	worldBoss.isboss = 1

	require 'ServerRecord'.setBossHp( worldBoss.hp )
	require 'ServerRecord'.setBossHpMax( worldBoss.HpMax )
	require 'ServerRecord'.setBossId( bid )

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)
	ServerController.loadHeroTeam(serverRoleArray, petList)

	--创建能量球
	ServeSlotManager.new(serverRoleArray)
	-- :PVEStartCreate()	

	local fubenData = ServerController.loadFubenFromList( { worldBoss } )

	local servePveWavesDyManger = ServePveWavesDyManger.new()
	servePveWavesDyManger:init( fubenData )
	servePveWavesDyManger:startNext()

	ServerController._servePveWavesDyManger = servePveWavesDyManger

	ServerController.startUpdateController()

	----倒计时
	local countTime = CfgHelper.getCache('BattleSetConfig', 'Key', 'BossActiveTimeLimit', 'Value')
	assert(countTime)
	EventCenter.eventInput(FightEvent.StartTimer, countTime)
	ServerController.logicTimeCount( countTime )
end

function ServerController.startForGuildMatch( petList,enemyList ,additionTable, petBornIJList,enemyBornIJList)
	-- body
	ServerController.reset()
	ServerController.setBornIJArrays( petBornIJList, enemyBornIJList )

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	require 'ServerRecord'.setMode( 'guildmatch' )
	require 'ServerRecord'.setAdditionTable(additionTable)
	print('PetList')
	print(petList)

	print('EnemyList')
	print(enemyList)

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)

	ServerController.loadHeroTeamForArena(serverRoleArray, petList, true)

	ServerController.loadHeroTeamForArena(serverRoleArray, enemyList, false)

	require 'ServerRecord'.recordOriginalData()
	ServerController.startUpdateController()

	----倒计时
	local countTime = CfgHelper.getCache('BattleSetConfig', 'Key', 'GuildFightTimeLimit', 'Value')
	assert(countTime)
	EventCenter.eventInput(FightEvent.StartTimer, countTime)
	ServerController.logicTimeCount( countTime )

end

function ServerController.startForGuildBoss( petList,battleId ,petBornIJList)
	ServerController.reset()
	ServerController.setBornIJArrays( petBornIJList )

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	require 'ServerRecord'.setMode('guildboss')
	require 'ServerRecord'.setBattleId( battleId )

	print(string.format('guildboss battleId = %d !', battleId))

	print(petList)

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)
	ServerController.loadHeroTeam(serverRoleArray, petList)

	--创建能量球
	ServeSlotManager.new(serverRoleArray)
	-- :PVEStartCreate()	

	local fubenData = ServerController.fubenFromBattleId(battleId)

	local servePveWavesDyManger = ServePveWavesDyManger.new()
	servePveWavesDyManger:init( fubenData )
	servePveWavesDyManger:startNext()

	ServerController._servePveWavesDyManger = servePveWavesDyManger
	
	ServerController.startUpdateController()

	--增加限时
	local countTime = fubenData.TimeLimit or 0
	if countTime > 0 then
		EventCenter.eventInput(FightEvent.StartTimer, countTime)
		ServerController.logicTimeCount( countTime )
	end
end

function ServerController.startForGuildFuben(petList,enemyList,additionTable,petBornIJList,enemyBornIJList)
-- body
	ServerController.reset()
	ServerController.setBornIJArrays( petBornIJList, enemyBornIJList )

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	require 'ServerRecord'.setMode( 'guildfuben' )
	require 'ServerRecord'.setAdditionTable(additionTable)
	print('PetList')
	print(petList)

	print('EnemyList')
	print(enemyList)

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)

	ServerController.loadHeroTeam(serverRoleArray, petList, true)

	---[[
	local fubenData = ServerController.loadFubenFromList(enemyList)

	local servePveWavesDyManger = ServePveWavesDyManger.new()
	servePveWavesDyManger:init( fubenData )
	servePveWavesDyManger:startNext()

	ServerController._servePveWavesDyManger = servePveWavesDyManger

	
	--]]
	
	--[[
	ServerController.loadHeroTeamForArena(serverRoleArray, enemyList, false)
	--]]

	-- require 'ServerRecord'.recordOriginalData()
	ServerController.startUpdateController()

	----倒计时
	local countTime = CfgHelper.getCache('BattleSetConfig', 'Key', 'GuildBattleTimeLimit', 'Value')
	assert(countTime)
	EventCenter.eventInput(FightEvent.StartTimer, countTime)
	ServerController.logicTimeCount( countTime )
end

function ServerController.startForLimitFuben(petList,enemyList,additionTable,petBornIJList,enemyBornIJList)
-- body
	local exdata = require 'ServerRecord'.getExData()
	ServerController.reset()
	require 'ServerRecord'.setExData(exdata)
	ServerController.setBornIJArrays( petBornIJList, enemyBornIJList )

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	require 'ServerRecord'.setMode( 'limit_fuben' )
	require 'ServerRecord'.setAdditionTable(additionTable)
	print('PetList')
	print(petList)

	print('EnemyList')
	print(enemyList)

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)

	ServerController.loadHeroTeam(serverRoleArray, petList, true)

	---[[
	local fubenData = ServerController.loadFubenFromList(enemyList)

	local servePveWavesDyManger = ServePveWavesDyManger.new()
	servePveWavesDyManger:init( fubenData )
	servePveWavesDyManger:startNext()

	ServerController._servePveWavesDyManger = servePveWavesDyManger

	
	--]]
	
	--[[
	ServerController.loadHeroTeamForArena(serverRoleArray, enemyList, false)
	--]]

	-- require 'ServerRecord'.recordOriginalData()
	ServerController.startUpdateController()

	----倒计时
	local countTime = CfgHelper.getCache('BattleSetConfig', 'Key', 'TLAdvBattleTimeLimit', 'Value')
	assert(countTime)
	EventCenter.eventInput(FightEvent.StartTimer, countTime)
	ServerController.logicTimeCount( countTime )
end

---探宝抢夺
function ServerController.startForGuildFubenRob( petList, enemyList, seed, petBornIJList, enemyBornIJList )
	-- body
	ServerController.reset(seed)
	ServerController.setBornIJArrays( petBornIJList, enemyBornIJList )

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	require 'ServerRecord'.setMode( 'guildfuben_rob' )

	print('PetList')
	print(petList)

	print('EnemyList')
	print(enemyList)

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)

	ServerController.loadHeroTeamForArena(serverRoleArray, petList, true)

	ServerController.loadHeroTeamForArena(serverRoleArray, enemyList, false)

	ServerController.startUpdateController()

	----倒计时
	local countTime = CfgHelper.getCache('BattleSetConfig', 'Key', 'RobBattleTime', 'Value')
	assert(countTime)
	EventCenter.eventInput(FightEvent.StartTimer, countTime)
	ServerController.logicTimeCount( countTime )
end

---抢夺复仇
function ServerController.startForGuildFubenRevenge( petList, enemyList, seed, petBornIJList, enemyBornIJList )
	-- body
	local exdata = require 'ServerRecord'.getExData()
	ServerController.reset(seed)
	require 'ServerRecord'.setExData(exdata)
	
	ServerController.setBornIJArrays( petBornIJList, enemyBornIJList )

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	require 'ServerRecord'.setMode( 'guildfuben_revenge' )

	print('PetList')
	print(petList)

	print('EnemyList')
	print(enemyList)

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)

	ServerController.loadHeroTeamForArena(serverRoleArray, petList, true)

	ServerController.loadHeroTeamForArena(serverRoleArray, enemyList, false)

	ServerController.startUpdateController()

	----倒计时
	local countTime = CfgHelper.getCache('BattleSetConfig', 'Key', 'RobBattleTime', 'Value')
	assert(countTime)
	EventCenter.eventInput(FightEvent.StartTimer, countTime)
	ServerController.logicTimeCount( countTime )
end

--远古遗迹
function ServerController.startForRemainsFuben(petList,enemyList,petBornIJList,enemyBornIJList)

	local exdata = require 'ServerRecord'.getExData()
	ServerController.reset()
	require 'ServerRecord'.setExData(exdata)

	ServerController.setBornIJArrays( petBornIJList, enemyBornIJList )

	require 'RoleSelfManager'.isPvp = false
	require 'RoleSelfManager'.isLeft = false

	require 'ServerRecord'.setMode( 'RemainsFuben' )
	require 'ServerRecord'.setAdditionTable(additionTable)
	print('PetList')
	print(petList)

	print('EnemyList')
	print(enemyList)

	ServerController.stop()

	local serverRoleArray = require 'ServerRoleArray'.new()
	ServerController._serverRoleArray = serverRoleArray

	ServerController.initEventFunc(serverRoleArray)

	ServerController.loadHeroTeam(serverRoleArray, petList, true)

	---[[
	local fubenData = ServerController.loadFubenFromList(enemyList)

	local servePveWavesDyManger = ServePveWavesDyManger.new()
	servePveWavesDyManger:init( fubenData )
	servePveWavesDyManger:startNext()

	ServerController._servePveWavesDyManger = servePveWavesDyManger

	
	--]]
	
	--[[
	ServerController.loadHeroTeamForArena(serverRoleArray, enemyList, false)
	--]]

	-- require 'ServerRecord'.recordOriginalData()
	ServerController.startUpdateController()

	----倒计时
	local countTime = CfgHelper.getCache('BattleSetConfig', 'Key', 'GuildBattleTimeLimit', 'Value')
	assert(countTime)
	EventCenter.eventInput(FightEvent.StartTimer, countTime)
	ServerController.logicTimeCount( countTime )
end

function ServerController.getServerPveWavesDyManger()
	-- body
	return ServerController._servePveWavesDyManger
end

--[[
接入正式的副本

+petList+1+cri [0]
|       | +atk [1330]
|       | +def [50]
|       | +awaken [0]
|       | +charactorId [1]
|       | +spd [240]
|       | +intimacy [0]
|       | +hp [870]
|       | +heroid [25]
|       +2+cri [0]
|         +atk [1700]
|         +def [100]
|         +awaken [0]
|         +charactorId [5]
|         +spd [240]
|         +intimacy [0]
|         +hp [1000]
|         +heroid [26]
+battleData+Id [420]
           +IsMysticSpace [false]
           +BossPetIds
           +BossCapture
           +RecordId [237]
           +BattleId [10014]
           +OrderNo [15]
           +Rid [2]


battlt     +1+


waveList -> 		
					+isboss or IsBoss
					+enterposition
					+entertime
					+H + hp
					   + atk
					   + def
					   + crit
					   + spd
					   + atktime
					   + charactorId

测试fuben, pve_fubens, pve_waves, pve_monster
正式fuben, BattleConfig, WaveConfig, MonsterConfig
--]]

ServerController.loadFubenFromList = function ( monsterList )
	-- body
	local fuben = {}

	fuben.TimeLimit = nil  --限时性副本
	fuben.PetExp 	= nil
	fuben.RoleExp 	= nil
	fuben.Gold 		= nil
	fuben.WaveArray = {}

	--[[
	2,1,3,  1,3,2
	--]]
	local enterposition_array = { 2,1,3,1,3,2 }

	local waveDataArray = {}
	for i,monster in ipairs(monsterList) do

		-- temp.heroid = nPet.Id
		-- temp.charactorId = nPet.PetId
		-- temp.awaken = nPet.AwakeIndex
		-- temp.intimacy = nPet.Intimacy
		-- temp.hp = curHp or nPet.Hp
		-- temp.atk = nPet.Atk
		-- temp.def = nPet.Def
		-- temp.cri = nPet.Crit
		-- temp.spd = nPet.MoveSpeed
		-- temp.atktime = nPet.AtkSpeed
		-- temp.AwakeIndex = nPet.AwakeIndex

		-- temp.PetId = nPet.PetId
		-- temp.ID = nPet.Id
		-- temp.Lv = nPet.Lv
		-- temp.HpMax = nPet.Hp
		
		local role = {}
		role.charactorId 	= monster.charactorId

		role.hp 			= monster.hp
		role.hpMax 			= monster.HpMax or monster.hp
		role.HpMax 			= monster.HpMax or monster.hp
		role.atk 			= monster.atk
		role.def 			= monster.def
		role.crit 			= monster.cri or monster.crit

		role.sv 			= monster.sv
		role.fv 			= monster.fv
		role.cv     		= monster.cv
		role.bd 			= monster.bd
		role.hpR   			= monster.hpR

		role.spd 			= monster.spd
		role.atktime        = monster.atktime
		role.awaken     	= monster.awaken or monster.AwakeIndex

		-- if not role.awaken then
		-- 	print('**************')
		-- 	print(monster)
		-- 	assert(false)
		-- end


		-- print('role.awaken')
		-- print(role.awaken)
		-- assert( monster.awaken )

		--

		role.gb 			=	monster.gb
		role.ID 			=   monster.ID
		role.mana 			=   monster.energy
		role.eb 			=	monster.eb

		local wData = {}
		wData.role          = role
		wData.entertime 	= (i>3 and (require 'GridManager'.getUIGridWidth()/role.spd)) or 0 
		wData.enterposition = enterposition_array[i]
		wData.isboss 		= monster.isboss or 0
		wData.ID            = monster.ID

		wData.aiType 		= monster.aiType or 0

		print('monster.aiType='..tostring(monster.aiType))

		table.insert(waveDataArray, wData)
	end

	waveDataArray.waveIndex = 1

	table.insert(fuben.WaveArray, waveDataArray)

	return fuben
end

local function random_drop( array, dropNum )
	-- body
	for i=1, #array do
		local r = require 'Random'.ranI(1, #array)
		local tmp = array[i]
		array[i] = array[r]
		array[r] = tmp
	end

	for i=1, dropNum do
		array[i].isDropBox = true
	end
end

local function modifier_dropBox( waveArray, dropNum )
	-- body
	assert(waveArray)
	assert(dropNum)

	local waveNum = #waveArray

	local minDrop = math.floor( 0.001 + dropNum/waveNum )
	local maxDrop = dropNum - minDrop*(waveNum - 1)

	for i=1, waveNum do
		local waveDataArray = waveArray[i]
		local usedDataArray = {}
		for ii, waveData in ipairs(waveDataArray) do
			if not waveData.isDropBall then
				table.insert(usedDataArray, waveData)
			end
		end

		local n = (i==waveNum and maxDrop) or minDrop
		assert(#usedDataArray >= n )
		random_drop(usedDataArray, n)
	end
end

ServerController.loadFuben = function ( fubenid, fubenConfig, waveConfig, monsterConfig )
	-- body
	local fuben = {}

	local fubenVo = CfgHelper.getCache(fubenConfig, 'fubenid', fubenid)
	assert(fubenVo)

	fuben.TimeLimit = fubenVo.TimeLimit or fubenVo.totaltime  --限时性副本
	fuben.PetExp 	= fubenVo.PetExp
	fuben.RoleExp 	= fubenVo.RoleExp
	fuben.Gold 		= fubenVo.Glod
	fuben.WaveArray = {}

	local wavearray = fubenVo.wavearray

	assert(wavearray, fubenVo)

	local waveTable = require (waveConfig)

	for i,v in ipairs(wavearray) do
		local waveid = v
		local waveDataArray = {}

		for ii, vv in ipairs(waveTable) do
			if vv['waveid'] == waveid then
				local wData = {}
				wData.entertime 	= vv.entertime
				wData.enterposition = vv.enterposition
				wData.aiType 		= vv.aiType or 0
				wData.isboss 		= vv.isboss or vv.IsBoss

				if wData.isboss == 1 then
					ServerController._bossFlag = true

					if require 'ServerRecord'.getBossCatchFlag() then
						wData.isDropBall = true
					end
				end

				local roleid = vv.heroid
				local role = CfgHelper.getCache(monsterConfig, 'heroid', roleid)
				--[[
				{	heroid = 1,	charactorId = 11,	hp = 101,	atk = 80,	def = 0,	crit = 0,	spd = 124,	atktime = 1.5000,},
				--]]
				assert(role)
				wData.role 			=  Utils.copyTable( role )

				-- hp = 2700,	atk = 951,	def = 115,	crit = 0,

				table.insert(waveDataArray, wData)
			end
		end

		-- -- 修饰掉落
		-- if i > dropMinWaveIndex then
		-- 	local randomDrop = require 'Random'.ranI(1, #waveDataArray)
		-- 	local wData = waveDataArray[randomDrop]
		-- 	assert(wData)
		-- 	if wData.isboss == 1 then
		-- 		randomDrop = randomDrop + 1
		-- 		if randomDrop > #waveDataArray then
		-- 			randomDrop = 1
		-- 		end
		-- 	end

		-- 	wData = waveDataArray[randomDrop]
		-- 	assert(wData)

		-- 	assert(wData.isboss ~= 1 )

		-- 	wData.isDropBox = true
		-- end 

		table.insert(fuben.WaveArray, waveDataArray)
		waveDataArray.waveIndex = #(fuben.WaveArray)
	end

	local dropNum = require 'ServerRecord'.getFuBenDropNum()
	-- local dropMinWaveIndex = #wavearray - dropNum
	modifier_dropBox(fuben.WaveArray, dropNum)

	return fuben
end


ServerController.fubenFromBattleId = function ( battleId )
	-- body
	return ServerController.loadFuben(battleId, 'BattleConfig', 'WaveConfig', 'MonsterConfig')
end

ServerController.fubenFromFubenId = function ( fubenId )
	-- body
	return ServerController.loadFuben(fubenId, 'pve_fubens', 'pve_waves', 'pve_monster')
end

ServerController.pause = function ( )
	-- body
end

ServerController.resume = function ( )
	-- body
end

ServerController.runWithDelay = function ( func, delay )
	-- body
	local timeOut = TimeOut.new(delay, function ()
		-- body
		func()
	end)
	timeOut:start()
end

ServerController.stop = function (  )
	-- body
	if ServerController._updatehandle then
		FightTimer.removeFunc( ServerController._updatehandle )
		ServerController._updatehandle = nil
	end
end

ServerController.getRoleCrit = function ( roleId )
	-- body
	local role = ServerController._serverRoleArray:findRoleByDyIdAnyway(roleId)
	if role then
		return (role and role:getCrit() or 0)
	end
	return 0
end

ServerController.findRoleByDyIdAnyway = function ( roleId )
	-- body
	local role = ServerController._serverRoleArray:findRoleByDyIdAnyway(roleId)
	return role
end

ServerController.getManaPointByDyId = function ( roleId )
	-- body
	local role = ServerController._serverRoleArray:findRoleByDyIdAnyway(roleId)
	if role then
		return role:getManaPoint()
	else
		-- assert(false)
		return 0
	end
end

ServerController.setProtectTimeByDyId = function ( roleId, time )
	-- body
	local role = ServerController._serverRoleArray:findRoleByDyIdAnyway(roleId)
	if role then
		return role:setProtectTime(time)
	end
end



ServerController.getFubenBossFlag = function()
	return ServerController._bossFlag
end


local GC_Count = 0
ServerController.gc = function (dt)
	-- body
	-- local function clean()
	--     print('*---------------------*')
	--     print('before clean, memory size = '..collectgarbage('count'))

	--     collectgarbage('collect')
	--     collectgarbage('collect')

	--     print('after clean, memory size = '..collectgarbage('count'))
	--     print('*---------------------*')
	-- end

	-- GC_Count = GC_Count + dt

	-- if GC_Count > 0 then
	-- 	GC_Count = 0
	-- 	clean()
	-- end
end

---每场战斗开始前初始话
ServerController.reset = function ( seed )
	-- body
	seed = seed or require 'Random'.generateSeed()

	print('ServerController')
	print('Seed = '..seed) 
	-- debug.catch(true)
	
	require 'Random'.randomseed(seed)

	print('Random.ranF='.. require 'Random'.ranF() )

	-- 存在Boss flag
	ServerController._bossFlag 		= false 
	ServerController._heroModuleArray = nil
	ServerController._monsterModuleArray = {}

	ServerController._serverRoleArray  = nil

	-- assert(not ServerController._bornIJArraySelf)
	ServerController._bornIJArraySelf = nil
	ServerController._bornIJArrayOther = nil

	require 'GridManager'.reset()

	require 'DamageFormula'.reset()
	require 'IDCreator'.reset()
	require 'ServerRecord'.reset()
	require 'SkillChainManager'.reset()

	require 'ServerGameOver'.new()
	EventCenter.eventInput(FightEvent.Pve_IgnoreCatchBoss)
end

ServerController.setBornIJArrays = function ( selfArray, otherArray )
	-- body
	-- assert(selfArray)
	-- assert(otherArray)

	ServerController._bornIJArraySelf = selfArray 
	ServerController._bornIJArrayOther = otherArray 
end

ServerController.clean = function ()
	-- body
	ServerController._bossFlag 		= false 
	ServerController._heroModuleArray = nil
	ServerController._monsterModuleArray = nil
	ServerController._enemyModuleArray = nil

	ServerController._serverRoleArray  = nil

	ServerController._servePveWavesDyManger = nil

	ServerController.stop()
end

return ServerController

