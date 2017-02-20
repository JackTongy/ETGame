local SkinManager 		= require 'SkinManager'
local CfgHelper 		= require 'CfgHelper'
local FightEffectView 	= require 'FightEffectView'
local RoleView 			= require 'RoleView'
local XmlCache 			= require 'XmlCache'
local Global 			= require 'Global'
local EventCenter 		= require 'EventCenter'
local FightEvent 		= require 'FightEvent'
local SkillUtil         = require 'SkillUtil'

require 'ActionBaoJiWenZhi'
require 'ActionBiSha'
require 'Swf_BaoJiShuZi'
require 'Swf_Kaisi'
require 'Swf_ShengLi'
require 'Swf_ShiBai'
require 'EnergyView'
require 'NumberView'
require 'LabelView'

local FightLoad = class()

function FightLoad:ctor()
	-- body
	self._preLoadArray = CCArray:create()
	self._preLoadArray:retain()

	self._preLoadCharactorMap = {}
	self._preloadModelMap = {}
end

function FightLoad:reset()
	-- body
	self._preLoadCharactorMap = {}
	self._preloadModelMap = {}
	self._preLoadArray:removeAllObjects()

	RoleView.clean()
	FightEffectView.clean()
	XmlCache.cleanXmlCache('Fight')
end


function FightLoad:preloadUI()
	-- body
	--能量球
	--数字
	--lady ball
	--
end


function FightLoad:addCharactor( item, isHero )
	-- body
	print('FightLoad:addCharactor')
	print(item)

	local charactorId = item.charactorId
	charactorId = tonumber(charactorId)
	assert(charactorId)

	if not isHero then
		item.isMonster = true
	end

	RoleView.createViewCacheByArgs(item)

	-- if self._preLoadCharactorMap[charactorId] then
	-- 	--已经加载, 不需要重新加载
	-- 	return 
	-- end

	-- self._preLoadCharactorMap[charactorId] = true

	local ccarray = self._preLoadArray

	if isHero then
		--load pic + mask
		--一张大图 + 一张mask

		local big2 = SkinManager.getRoleBigIcon2ByCharactorId(charactorId)

		local pic = ElfNode:create()
		pic:setResid( big2[1] )
		ccarray:addObject( pic )

		local mask = ElfNode:create()
		mask:setResid( big2[2] )
		ccarray:addObject( mask )

	end

	--load 3 skill  -> atk_effectId, uatk_effectId
	local roleEffectVo = CfgHelper.getCache('roleEffect', 'handbook', charactorId)
	assert(roleEffectVo)

	local effectNames 

	if isHero then
		if require 'Config'.AutoArenaTest then
			effectNames = {
				-- 'skill_effectID', 			'B_skill_effectID',
				'natk_effectID', 			'B_natk_effectID',
				'crit_effectID', 			'B_crit_effectID',
				'remote_effectID', 			'B_remote_effectID',
				'crit_remote_effectID', 	'B_crit_remote_effectID',
				'cure_effectID',			'B_cure_effectID',
			}
		else
			effectNames = {
				'skill_effectID', 			'B_skill_effectID',
				'natk_effectID', 			'B_natk_effectID',
				'crit_effectID', 			'B_crit_effectID',
				'remote_effectID', 			'B_remote_effectID',
				'crit_remote_effectID', 	'B_crit_remote_effectID',
				'cure_effectID',			'B_cure_effectID',
			}
		end
	else
		if item.isBoss then
			effectNames = {
				'skill_effectID', 			'B_skill_effectID',
				'natk_effectID', 			'B_natk_effectID',
				'crit_effectID', 			'B_crit_effectID',
				'remote_effectID', 			'B_remote_effectID',
				'crit_remote_effectID', 	'B_crit_remote_effectID',
				'cure_effectID',			'B_cure_effectID',
			}
		else
			effectNames = {
				-- 'skill_effectID', 			'B_skill_effectID',
				'natk_effectID', 			'B_natk_effectID',
				'crit_effectID', 			'B_crit_effectID',
				'remote_effectID', 			'B_remote_effectID',
				'crit_remote_effectID', 	'B_crit_remote_effectID',
				'cure_effectID',			'B_cure_effectID',
			}
		end
	end

	for i, name in ipairs(effectNames) do
		local effectIDArray = roleEffectVo[name]
		-- assert(effectIDArray, 'no '..name)

		if effectIDArray then
			for ii, vv in ipairs(effectIDArray) do
				if vv ~= 0 then
					local realEffects = CfgHelper.getCacheArray('fightEffect', 'effectId', tonumber(vv))

					assert(realEffects, 'no '..vv)

					for iii, vvv in ipairs(realEffects) do
						--
						local modelId = vvv.model_id
						if not self._preloadModelMap[modelId] then
							self._preloadModelMap[modelId] = true

							if type(modelId) ~= 'number' or modelId ~= 0 then
								if vvv.layer == SkillUtil.Layer_Sound then
									-- require 'framework.helper.MusicHelper'.preloadEffect( 'raw/'..modelId )

								elseif vvv.layer == SkillUtil.Layer_Earth_Quake then
									--do nothing
								else
									FightEffectView.createCache(modelId)
								end
								
							end
						end
					end
				end
			end
		end
	end
	-- local charactorVo = CfgHelper.getCache('charactorConfig', 'id', charactorId)
	-- assert(charactorVo)
end


function FightLoad:preloadBuff()
	-- body
	--buff

	local buffModelIds = { 40,41, 42, 43, 44, 80, 81, -40, -41, -42, -43, -44 }
	for i,modelId in ipairs(buffModelIds) do
		if not self._preloadModelMap[modelId] then
			self._preloadModelMap[modelId] = true

			FightEffectView.createCache(modelId)
		end
	end
	
end

function FightLoad:getArenaRunnableArray( inputData )
	-- body
	-- inputData.Bid = inputData.Bid or 1

	assert(inputData.petList)
	assert(inputData.enemyList)
	assert(inputData.seed)
	-- assert(inputData.Bid)
	assert(inputData.enemyName)

	local data = {}
	data.type = 'arena'
	data.data = {}

	data.data.petList 			= inputData.petList
	data.data.enemyList 		= inputData.enemyList
	data.data.seed 				= inputData.seed
	data.data.petBornIJList 	= inputData.petBornIJList
	data.data.enemyBornIJList 	= inputData.enemyBornIJList

	local Bid = inputData.Bid

	---Bid
	---enemyName
	---petList
	---enemyList

	--[[
	竞技场挑战
	local data = {}
	data.type = 'arena'
	data.data = {}
	data.data.petList = xxx
	data.data.enemyList = xxx

	data.data.Bid = xxx
	data.data.enemyName = xxx
	--]]

	--[[
	竞技场战报
	local data = {}
	data.type = 'arena-record'
	data.data = {}
	data.data.petList = xxx
	data.data.enemyList = xxx
	
	data.data.enemyName = xxx
	
	----战报才有
	data.data.isChallenger = xxx
	data.data.seed = xxx
	data.data.reward = xxxx

	--

	--]]

	local runArray = {}
	---
	local func
	func = function ()
		-- body
		--[[
		Config.AutoCHomeTest = true
		Config.AutoArenaTest = true
		Config.AutoArenaBattleTest = true
		--]]
		if require 'Config'.AutoArenaTest then
			return true
		end

		if not require 'Config'.ArenaCalcBefore then
			return true
		end

		-- local fightResult = EventCenter.eventInput(FightEvent.LogicBattleStart, data)
		-- assert(fightResult)

		-- -- print(fightResult)

		-- local netData = {}
		-- netData.C = 'ArenaV1Save'
		
		-- netData.D = {}
		-- netData.D.Seed = inputData.seed
		-- netData.D.W = fightResult.isWin
		-- netData.D.Bid = inputData.Bid

		-- require 'ServerRecord'.setArenaReward(nil)
		-- local socketC = require "SocketClient"
		-- socketC:send(netData, function ( reward )
		-- 	-- body
		-- 	print('Arena Reward')
		-- 	print(reward)

		-- 	require 'ServerRecord'.setArenaOrder(reward and reward.D and reward.D.No )
		-- 	require 'ServerRecord'.setArenaReward( reward and reward.D and reward.D.Reward )

		-- 	EventCenter.eventInput(FightEvent.ArenaGameOver, reward)
		-- end)
	end

	-- local funcEmpty = function()
	-- end

	-- table.insert(runArray, funcEmpty)
	-- table.insert(runArray, funcEmpty)
	
	table.insert(runArray, func)
	-----

	return runArray
end


function FightLoad:getRunnableArray( heroCharactorIdArray, monsterCharactorIdArray )
	-- body
	local array = {}

	self:reset()

	-- table.insert(array, function ()
	-- 	self:reset()
	-- end)

	if Global.Battle_Use_View then
		table.insert(array, function ()
			self:preloadUI()
		end)

		table.insert(array, function ()
			self:preloadBuff()
		end)

		table.insert(array, function ()
			-- body
			require 'NumberView'.initViewCache()
		end)

		table.insert(array, function ()
			-- body
			require 'LabelView'.initViewCache()
		end)

		for i, item in ipairs(heroCharactorIdArray) do
			table.insert(array, function ()
				print('load hero charactor='..item.charactorId)
				self:addCharactor(item, true)
			end)
		end

		for i, item in ipairs(monsterCharactorIdArray) do
			table.insert(array, function ()
				print('load hero monster='..tostring(item.charactorId))
				self:addCharactor(item, false)
			end)
		end

	end

	table.insert(array, function ()
		XmlCache.cleanXmlCache('Fight')
	end)

	print('load role size = '..(#monsterCharactorIdArray + #heroCharactorIdArray))

	return array
end

local instance = FightLoad.new()

local reset = function ( ... )
	-- body
	return instance:reset()
end

local getRunnableArray = function ( ... )
	-- body
	return instance:getRunnableArray(...)
end

local getArenaRunnableArray = function ( ... )
	-- body
	return instance:getArenaRunnableArray(...)
end


return { reset = reset, getRunnableArray = getRunnableArray, getArenaRunnableArray = getArenaRunnableArray }