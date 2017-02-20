local FightEvent 		= require 'FightEvent'
local EventCenter 		= require 'EventCenter'
local Utils 			= require 'framework.helper.Utils'
local FightController 	= require 'FightController'
local FightTimer 		= require 'FightTimer'
local FightLoad 		= require 'FightLoad'
local FightResultVo 	= require 'FightResultVo'
local HeroPromoteVo 	= require 'HeroPromoteVo'
local PlayerPromoteVo 	= require 'PlayerPromoteVo'
local netModel 			= require 'netModel'
local CfgHelper 		= require 'CfgHelper'
local AppData 			= require 'AppData'
local GridManager 		= require 'GridManager'
local RoleSelfManager 	= require 'RoleSelfManager'
local FightSettings 	= require 'FightSettings'
local RolePlayerManager = require 'RolePlayerManager'
local Global 			= require 'Global'

local GameOverView = class( require 'BasicView' )

function GameOverView:ctor( luaset, document )
	-- body
	self._luaset = luaset
	self._document = document
	
	--发送网络
	EventCenter.addEventFunc(FightEvent.GameOver, function (data )
		-- print('-----GameOverData-----')
		-- print(data)
		-- assert(not require 'ServerRecord'.getGameOverFlag())

		if require 'ServerRecord'.getGameOverFlag() then
			return false
		end

		SystemHelper:setIgnoreBigTimeDelta(false)

		require 'ServerRecord'.setGameOverFlag(true)
		EventCenter.eventInput(FightEvent.StopTimer)

		local myFunc
		myFunc = function ()
			-- body
			RolePlayerManager.stopAll()

			Utils.delay( function ()
				-- body
				-- fight stop.
				require 'FightEffectView'.clean()
				require 'NumberView'.clean()
				require 'LabelView'.clean()
				require 'RoleView'.clean()
				require 'FightLoad'.reset()

				--删除所有角色
				FightController:reset() 
				FightTimer.reset()
				FightLoad.reset()
				GridManager.reset()
				
				--重置
				require 'UpdateRate'.setUpdateRateScale(1)
				-- CCDirector:sharedDirector():getScheduler():setTimeScale(1)

				print('----------GameOverView----------')
				print(data)

				if data.directExit then
					CCDirector:sharedDirector():getScheduler():setTimeScale( 1 )

			        GleeCore:popController()
			        FightSettings.unLock()

			        local completeData = {
				        mode = require 'ServerRecord'.getMode(),
				        isWin = false
				    }

			        EventCenter.eventInput('OnBattleCompleted', completeData)
	    			require 'ServerRecord'.reset()

	    			return true
				end

				--配置
				if data.mode == 'test' or RoleSelfManager.isPvp then
					if data.isWin then
						self:jumpForTest(data)
					else
						GleeCore:replaceController('GameOverLost')
					end

				elseif data.mode == 'fuben' or data.mode == 'fuben_boss' then
					if data.isWin then
						self:sendFuBenMsg(data)
					else
						GleeCore:replaceController('GameOverLost')
					end

				elseif data.mode == 'fuben_cat' then

					self:jumpForFubenCat(data)

				elseif data.mode == 'fuben_thief' then

					self:jumpForFubenThief(data)

				elseif data.mode == 'champion' then
					if data.isWin then
						self:sendChampionMsg(data)
					else
						self:sendChampionMsg(data)
						GleeCore:replaceController('GameOverLost')
					end
				elseif data.mode == 'train' then
					if data.isWin then
						self:sendTrainMsg(data)
					else
						GleeCore:replaceController('GameOverLost')
					end
				elseif data.mode == 'bossBattle' then
					self:jumpForBossBattle(data)

				elseif data.mode == 'CMBossBattle' then
					-- assert(false)
					self:jumpForCMBattle(data)

				elseif data.mode == 'SDNBossBattle' then
					-- assert(false)
					self:jumpForSDNBattle(data)

				elseif data.mode == 'ActRaid' then
					if data.isWin then
						self:sendActRaidMsg(data)
					else
						GleeCore:replaceController('GameOverLost')
					end

				elseif data.mode == 'arena' then
					if data.isWin then
						self:sendArenaMsg(data)
					else
						GleeCore:replaceController('GameOverLost', data)
					end
				elseif data.mode == 'friend' then
					if data.isWin then
						GleeCore:replaceController('GameOverWin',data)
					else
						GleeCore:replaceController('GameOverLost',data)
					end
				elseif data.mode == 'league' then
					if data.isWin then
						self:sendLeagueMsg(data)
					else
						GleeCore:replaceController('GameOverLost', data)
					end
					-- self:sendLeagueMsg(data)

				elseif data.mode == 'arena-record' then
					if data.isWin then
						GleeCore:replaceController('GameOverWin')
					else
						GleeCore:replaceController('GameOverLost')
					end
				elseif data.mode == 'guildmatch' then
					self:sendGuildmatchMsg(data)
				elseif data.mode == 'guildboss' then
					self:sendGuildBossMsg(data)
				elseif data.mode == 'guildfuben' then
					self:sendGuildFubenMsg(data)
				elseif data.mode == 'limit_fuben' then
					self:sendLimitFubenMsg(data)
				elseif data.mode == 'guildfuben_rob' then
					self:sendGuildFubenRob(data)
				elseif data.mode == 'guildfuben_revenge' then
					self:sendGuildFubenRevenge(data)
				elseif data.mode == 'RemainsFuben' then
					self:sendRemainsFuben(data)
				else
					GleeCore:replaceController('GameOverLost')
				end

				print('Game Over!') 
			end,  data.delay or 0,  self._luaset[1] ) 
		end

		if require 'ServerRecord'.getMode() == 'arena' and require 'Config'.ArenaCalcAfter then
			local netData = {}
			netData.C = 'ArenaV1Save'
			
			netData.D = {}
			netData.D.Seed 	= require 'ServerRecord'.getArenaSeed()
			netData.D.W 	= data.isWin
			netData.D.Bid 	= require 'ServerRecord'.getArenaBid()

			require 'ServerRecord'.setArenaReward(nil)
			local socketC = require "SocketClient"
			socketC.send0(netData, function ( reward )
				-- body
				print('Arena Reward')
				print(reward)

				require 'ServerRecord'.setArenaOrder(reward and reward.D and reward.D.No )
				require 'ServerRecord'.setArenaReward( reward and reward.D and reward.D.Reward )

				EventCenter.eventInput(FightEvent.ArenaGameOver, reward)

				myFunc()
			end)
		elseif require 'ServerRecord'.getMode() == 'league' then
			local netData = {}

			if data.isWin then
				netData.C = 'CsWin'
			else
				netData.C = 'CsFail'
			end
			
			netData.D = {}
			netData.D.Id 	= require 'ServerRecord'.getLeagueEnemyId()

			require 'ServerRecord'.setLeagueReward(nil)
			local socketC = require "SocketClient"
			socketC.send0(netData, function ( reward )
				-- body
				print('League Reward')
				print(reward)
				require 'ServerRecord'.setLeagueReward( reward )

				EventCenter.eventInput(FightEvent.LeagueGameOver, reward)

				myFunc()
			end)


		else
			myFunc()
		end
		
	end, 'Fight')
end

function GameOverView:jumpForTest( data )
	-- body
	GleeCore:replaceController('GameOverWin', data )
end

function GameOverView:dealNet( netModule, callback,errcallback )
	-- body
	local func
	func = function ()
		-- body
		local socketC = require 'SocketClient'
		socketC.send0(netModule, function ( netData )
			-- body
			callback( netData )

		end,errcallback
		-- , function ( errorData )
		-- 	-- body
			
		-- 	print('---------GameOverView:dealNet----------')
		-- 	print(errorData)
			
		-- 	-- GleeCore:showLayer('DNetTimeOut', { func = func} )
		-- end
		)
	end

	func()
end


function GameOverView:jumpForBossBattle( data )
	-- body
	local boss = data.NpcTeam[1]
	if boss then
		local hpD = boss.hpD*boss.hpP/100
		-- local hpD = boss:getHpD()
		local oldHpD = require 'ServerRecord'.getBossHp()
		local maxHp = require 'ServerRecord'.getBossHpMax()
		local hurtValue = (oldHpD - hpD)
		local hurtPercent = 100*hurtValue/maxHp

		data.hurtValue = hurtValue
		data.hurtPercent = hurtPercent
	else
		data.hurtValue = 0
		data.hurtPercent = 0
	end

	local eventData = {}
	eventData.Hp = data.hurtValue
	eventData.Bid = require 'ServerRecord'.getBossId()

	-- 
	-- winData.Result.Reward.PetPieces 	= netData.D.Result.Reward.PetPieces
	-- winData.Result.Reward.Pets 			= netData.D.Result.Reward.Pets
	-- winData.Result.Reward.Materials 	= netData.D.Result.Reward.Materials
	-- winData.Result.Reward.Equipments 	= netData.D.Result.Reward.Equipments

	local Bid = eventData.Bid
    local Hp = eventData.Hp
    self:dealNet(netModel.getModelBossBattle( Bid,Hp ),function ( netData )
        local func = function ()
			-- body
			print('BossBattleEnd')
			print(eventData)
			print(netData)
			EventCenter.eventInput('BossBattleEnd', netData)
		end
		func()
		
		data.Reward = netData.D.Reward
		require 'AppData'.updateResource(netData.D.Resource)
		
		if data.isWin then
			GleeCore:replaceController('GameOverWin', data)
		else
			GleeCore:replaceController('GameOverLost', data)
		end
    end)
end


function GameOverView:jumpForFubenThief( data )
	-- body
	EventCenter.eventInput(FightEvent.BattleThiefGameOver, data) 

	if data.isWin then

		local netData = {}
		netData.C = 'BattleThief'
		netData.D = {}
		netData.D.Win = true

		self:dealNet(netData, function ( goldData )
			-- body
			data.gold = goldData and goldData.D and goldData.D.Gold 
			GleeCore:replaceController('GameOverWin', data)
		end )		

	else
		GleeCore:replaceController('GameOverLost')
	end
end



---超梦来袭
function GameOverView:jumpForCMBattle( data )
	-- body
	local boss = data.NpcTeam[1]

	if boss then
		local hpD = boss.hpD*boss.hpP/100
		local oldHpD = require 'ServerRecord'.getBossHp()
		local maxHp = require 'ServerRecord'.getBossHpMax()
		local hurtValue = (oldHpD - hpD)
		local hurtPercent = 100*hurtValue/maxHp

		print('------CMLX------')
		print('maxHp       = '..maxHp)
		print('maxHp2      = '..boss.hpD)
		print('hpD         = '..hpD)
		print('oldHpD      = '..oldHpD)
		print('hurtValue   = '..hurtValue)
		print('hurtPercent = '..hurtPercent)

		data.hurtValue = hurtValue
		data.hurtPercent = hurtPercent
	else
		data.hurtValue = 0
		data.hurtPercent = 0
	end

	local eventData = {}
	eventData.Hp = data.hurtValue
	eventData.Bid = require 'ServerRecord'.getBossId()

	local func = function ()
		-- body
		print('CMBattleEnd')
		print(eventData)
		EventCenter.eventInput('CMBossBattleEnd', eventData)
	end
	
	-- data.callback = func
	func()

	if data.isWin then
		GleeCore:replaceController('GameOverWin', data)
	else
		GleeCore:replaceController('GameOverLost', data)
	end
end

---闪电鸟
function GameOverView:jumpForSDNBattle( data )
	-- body
	local boss = data.NpcTeam[1] 
	
	if boss then
		local hpD = boss.hpD*boss.hpP/100
		local oldHpD = require 'ServerRecord'.getBossHp()
		local maxHp = require 'ServerRecord'.getBossHpMax()
		local hurtValue = (oldHpD - hpD)
		local hurtPercent = 100*hurtValue/maxHp

		data.hurtValue = hurtValue
		data.hurtPercent = hurtPercent
	else
		data.hurtValue = 0
		data.hurtPercent = 0
	end
	

	local eventData = {}
	eventData.Hp = data.hurtValue
	eventData.Bid = require 'ServerRecord'.getBossId()
	
	local func = function ()
		-- body
		print('SDNBattleEnd')
		print(eventData)
		EventCenter.eventInput('SDNBossBattleEnd', eventData)
	end

	-- data.callback = func
	func()
	
	if data.isWin then
		GleeCore:replaceController('GameOverWin', data)
	else
		GleeCore:replaceController('GameOverLost', data)
	end
end


function GameOverView:getGoldForCatByHurt( hurt )
    -- body
   --  local indexs = {    5000, 10000, 30000, 50000, 100000, 200000, 400000 }
   --  local values = {  5000, 10000, 15000, 20000, 25000, 30000, 35000, 40000 }
   -- for i,v in ipairs(indexs) do
   --      if hurt <= v then
   --          return values[i]
   --      end
   -- end
   -- return values[#values]

   return math.min( math.floor( math.sqrt(math.abs(hurt))*70 ), 50000)
end

function GameOverView:jumpForFubenCat( data )
	-- body
	-- assert(not data.isWin)

	local boss = data.NpcTeam[1]
	-- assert(boss)
	
	local hurtValue = (boss and math.floor( boss.hpD - boss.hpD*boss.hpP/100 )) or 0

	data.hurtValue =  hurtValue
	data.gold      = self:getGoldForCatByHurt(hurtValue)
	
	local eventData = {}
	eventData.Hp = hurtValue
	eventData.Gold = data.gold
	
	local func = function ()
		-- body
		print('FubenCatBattleEnd')
		print(eventData)
		EventCenter.eventInput(FightEvent.FubenCatBattleEnd, eventData)
	end
	
	data.callback = func

	GleeCore:replaceController('GameOverLost', data)
end


function GameOverView:sendArenaMsg()
	-- body
	local mydata = {}
	mydata.mode = 'arena'

	---荣誉

	GleeCore:replaceController('GameOverWin', mydata)
end

function GameOverView:sendLeagueMsg( data )
	-- body
	local mydata = {}
	mydata.mode = 'league'

	---荣誉

	GleeCore:replaceController('GameOverWin', mydata)
end

function GameOverView:sendActRaidMsg( data )
	-- body
	local battleId = nil or data.BattleId

	local item = CfgHelper.getCache('BTR', 'battleId', battleId)

	self:dealNet( netModel.getModelActRaidRewardGet( item.type, item.rank, true,self:getResultStars(data) ), function ( netData )

		print('===============')
		print(netData)
		
		local mydata = {}
		mydata.mode = 'ActRaid'
		
		mydata.type = item.type

		mydata.data = {}
		mydata.data.stars = self:getResultStars(data)
		if not netData.D then
			mydata.data.equipments = {}
			mydata.data.golds = 0
			mydata.data.gems =  {}
			mydata.data.materials = {}
			
			GleeCore:replaceController('GameOverWin', mydata)
		else
			mydata.data.equipments = netData.D.Resource.Equipments
			mydata.data.golds = netData.D.Reward.Gold
			mydata.data.gems =  netData.D.Resource.Gems

			mydata.data.materials = netData.D.Reward.Materials

			GleeCore:replaceController('GameOverWin', mydata)

			-- 给其他模块使用
			EventCenter.eventInput(FightEvent.Pve_RewardFubenResult, netData)
		end

		if item.type == 3 then
			require 'GuideHelper':startGuide('GCfg19')
		end
	end)
end

function GameOverView:getResultStars(data)
	if data.Lost then
		if data.Lost <= 0 then
			return 3
		elseif data.Lost <= 1 then
			return 2
		else
			return 1
		end
	end

	return 3
end

function GameOverView:sendFuBenMsg( data )
	-- body
	-- 战斗结算
	print('fight event over.')
	print(data)
	--[[
	+LastKillWithSkill [false]
	+Er [0]
	+Gr [0]
	+isWin [true]
	+Team+1+hpD [1711]
	|    | +atk [3129]
	|    | +charactorId [40]
	|    | +hpP [100]
	|    | +lv [24]
	|    | +petId [457]
	+NoLost [true]
	+FinishInTime [true]
	+TimeSpan [20000]
	--]]

	local userInfo = AppData.getUserInfo()
	local petInfo = AppData.getPetInfo()

	local function getVoByPetId( petId )
		-- body
		for i,v in ipairs(data.Team) do
			if v.petId == petId then
				return v
			end
		end

		-- assert(false, 'petId = '..petId)
		local petVo = require 'PetInfo'.getPetWithId(petId)
		assert(petVo, 'petId = '..petId)

		local data = {}
		data.hpD = petVo.Hp
		data.hpP = 100
		data.atk = petVo.Atk
		data.lv = petVo.Lv
		data.petId = petId
		data.charactorId = petVo.PetId

		return data
	end

	local battleDetailData = {}

	battleDetailData.LastKillWithSkill = data.LastKillWithSkill
	battleDetailData.TimeSpan 	= data.TimeSpan
	battleDetailData.NoLost 	= data.NoLost
	battleDetailData.Lost 		= data.Lost
	battleDetailData.Bid 		= require 'ServerRecord'.getBattleId()

	-- battleDetailData.Er = data.Er
	battleDetailData.Gr = data.Gr

	self:dealNet( netModel.getModelBattleGetResult(battleDetailData), function ( netData )
		print('BattleGetResult')
		print(netData)
		--[[
+C ['BattleGetResult'']
+D+TaskMainId [2]
  
  +Result+Id [899]
  |      +Resource+Role+Exp [1549]
  |      |             +ActiveCode ['4BDC06DD9C39F708'']
  |      |             +DailyTaskRewards+1 [0]
  |      |             |                +2 [-1]
  |      |             |                +3 [-1]
  |      |             |                +4 [-1]
  |      |             |                +5 [-1]
  |      |             |                +6 [-1]
  |      |             +ApResume [471]
  |      |             +Gold [2845167]
  |      |             +Lv [8]
  |      |             +TodayScore [50]
  |      |             +Vip [5]
  |      |             +Coin [6889]
  |      |             +Soul [8830]
  |      |             +IsActive [false]
  |      |             +DuckGot [2]
  |      |             +Name ['player776'']
  |      |             +TitleId [5]
  |      |             +TrainType [1]
  |      |             +DailyTaskScore [3015]
  |      |             +Id [776]
  |      |             +Ap [41]
  |      +SmallPets+1+Id [457]
  |      |         | +Lv [24]
  |      |         | +ExpR [0.45032467532468]
  |      +Rid [776]
  |      +BattleId [10022]
  |      +PExp [420]
  |      +Reward+Coin [0]
  |             +Gold [630]
  |             +Soul [0]
  |             +Exp [210]
  |             +Ap [0]
  +Pets+1+Intimacy [20]
       | +Exp [13870]
       | +Modified [false]
       | +Hp [1711]
       | +Prop [9]
       | +Potential [5]
       | +AwakeIndex [4]
       | +Star [4]
       | +AtkP [39.06]
       | +Id [457]
       | +Atk [3129]
       | +Def [1100]
       | +AtkMethod [4]
       | +HpP [28.21]
       | +MoveSpeed [240]
       | +Power [4268]
       | +AtkSpeed [0]
       | +MotiCnt [17]
       | +Name ['胖丁么么嗒'']
       | +Fetter+1 [668]
       | +ResCnt [0]
       | +Lv [24]
       | +Crit [0]
       | +PetId [40]
		--]]

		local winData = {}
		winData.mode = require 'ServerRecord'.getMode()

		netData.D.Pets = netData.D.Pets or {}

		local function getNetVoByPetId( petId )
			-- body
			for i,v in ipairs(netData.D.Pets) do
				if v.Id == petId then
					return v
				end
			end

			-- assert(false)
			return {}
		end

		winData.Team = {}

		-----升级列表
		if netData.D.Result.LvUpPets then
			winData.HeroPromoteArray = {}
			for i,pet in ipairs(netData.D.Result.LvUpPets) do
				-- self.name = '皮卡丘'
				-- self.star = 5
				-- self.charactorId = 110
				-- self.level = { 10, 15 }
				-- self.hp = {200, 300}
				-- self.atk = {100, 200}
				-- self.potential = 1 --潜力点

				local vo = HeroPromoteVo.new()
				vo.name = pet.Name
				vo.charactorId = pet.PetId
				vo.star = pet.Star
				vo.level = {  getVoByPetId(pet.Id).lv, pet.Lv }
				vo.hp = { getVoByPetId(pet.Id).hpD, pet.Hp }
				vo.atk = { getVoByPetId(pet.Id).atk,  pet.Atk }

				local oldPotential = AppData.getPetInfo().getPetWithId(pet.Id).Potential or 0
				vo.potential = pet.Potential - oldPotential

				table.insert(winData.HeroPromoteArray, vo)
			end
		end
		-- netData.D.Pets.
		winData.Result = FightResultVo.new()
		--[[
			self.condition = { 1, 0, 1 }
			self.addMoney = 150
			self.totalMoney = 1000
			self.addExp = 234
			self.totalExp = 1800
			self.nextExp = 2400 --下一个等级的经验值
		--]]
		winData.Result.condition[1] = (data.FinishInTime and 1) or 0
		winData.Result.condition[2] = (data.NoLost and 1) or 0
		winData.Result.condition[3] = (data.LastKillWithSkill and 1) or 0
		
		winData.Result.addMoney = netData.D.Result.Reward.Gold
		winData.Result.totalMoney = netData.D.Result.Resource.Role.Gold
		winData.Result.addExp = netData.D.Result.Reward.Exp
		winData.Result.totalExp = netData.D.Result.Resource.Role.Exp
		winData.Result.addLv = (netData.D.Result.Resource.Role.Lv - userInfo.getLevel())

		-- winData.Result.stars = netData.D.Towns and netData.D.Towns[1] and netData.D.Towns[1].Stars
		winData.Result.stars = self:getResultStars(data)

		-- [1] = {	lv = 1,	friendcap = 10,	apcap = 38,	petlvcap = 20,	eqlvcap = 20,	exp = 800,	LvUpAp = 20,},
		winData.Result.nextExp = CfgHelper.getCache('role_lv', 'lv', netData.D.Result.Resource.Role.Lv).exp
		winData.Result.lastExpRate = userInfo.getExp() / userInfo.getExpCap()

		winData.Result.Reward = {}
		
		winData.Result.Reward.PetPieces 	= netData.D.Result.Reward.PetPieces
		winData.Result.Reward.Pets 			= netData.D.Result.Reward.Pets
		
		winData.Result.Reward.Materials 	= netData.D.Result.Reward.Materials
		winData.Result.Reward.Equipments 	= netData.D.Result.Reward.Equipments

		if (not winData.Result.Reward.PetPieces) and (not winData.Result.Reward.Pets) and 
			(not winData.Result.Reward.Materials) and (not winData.Result.Reward.Equipments) then
			winData.Result.Reward = nil
		end
		
		--[[
		userInfoFunc.setId(role.Id)
		userInfoFunc.setName(role.Name)
		userInfoFunc.setLevel(role.Lv)
		userInfoFunc.setVipLevel(role.Vip)
		userInfoFunc.setExp(role.Exp)
		userInfoFunc.setAp(role.Ap)
		userInfoFunc.setGold(role.Gold)
		userInfoFunc.setCoin(role.Coin)
		userInfoFunc.setTitleID(role.TitleId)
		userInfoFunc.setBattleValue(role.Power)
		userInfoFunc.setApResume(role.ApResume)
		userInfoFunc.setActiveCode(role.ActiveCode)
		userInfoFunc.setSoul(role.Soul)
		userInfoFunc.setTrainType(role.TrainType)
		--]]

		--玩家升级 
		local newLevel = netData.D.Result.Resource.Role.Lv
		if newLevel > userInfo.getLevel() then
			local curserver = require 'AccountInfo'.getCurrentServer()
   			local userinfo = require 'AppData'.getUserInfo()
   			if curserver and userinfo and userinfo.isValid() then
				require "AndroidUtil".submitRoleInfo(userinfo.getId(),userinfo.getName(),newLevel,userinfo.getCoin(),userinfo.getVipLevel(),"",curserver.N,curserver.Id)
			end
			-- EventCenter.eventInput('UserLevelUp', { newLevel = newLevel } )

			winData.PlayerPromote = PlayerPromoteVo.new()
			--[[
				self.level = {10, 11}
				self.power = {110, 150} --体力
				self.powerLimit = { 150, 160 }
				self.friendLimit = { 30, 35 }
			--]]
			-- winData.PlayerPromote
			winData.PlayerPromote.level = { userInfo.getLevel(), newLevel }
			winData.PlayerPromote.power = { require 'ServerRecord'.getPreAp() or userInfo.getAp(),  netData.D.Result.Resource.Role.Ap } 
			-- winData.PlayerPromote.hp = { userInfo.getAp(),  netData.D.Result.Resource.Role.Hp }

			local old = CfgHelper.getCache('role_lv', 'lv', userInfo.getLevel())
			local new = CfgHelper.getCache('role_lv', 'lv', newLevel)

			winData.PlayerPromote.powerLimit = { old.apcap, new.apcap }
			winData.PlayerPromote.friendLimit = { old.friendcap, new.friendcap }
		end

		--给其他模块使用
		EventCenter.eventInput(FightEvent.Pve_FightResult, netData)

		GleeCore:replaceController('GameOverWin', winData )

	end, 5)
end

function GameOverView:sendChampionMsg( data )
	-- body

	local netPackage = {}
	netPackage.C = 'TopBattle'
	netPackage.D = {}
	netPackage.D.Hurts = {}
	netPackage.D.Mines = {}
	netPackage.D.Team = {}
	
	local all = true
	for i,pet in ipairs(data.Team) do
		local id = pet.petId
		local hp = pet.hpP * pet.hpD / 100

		if not data.isWin then
			all = false 
			netPackage.D.Mines[''..id] = 0
		else
			-- netPackage.D.Mines[''..id] = hp
			netPackage.D.Mines[''..id] = pet.hpP / 100
			if hp <= 0 then
				all = false
			end
		end
		
		table.insert(netPackage.D.Team, id)
	end

	for i,pet in ipairs(data.NpcTeam) do
		local id = pet.petId
		local hp = pet.hpP * pet.hpD / 100

		netPackage.D.Hurts[''..id] = hp
	end

	netPackage.D.Win = data.isWin
	netPackage.D.Skill = data.LastKillWithSkill
	netPackage.D.All = all

	-- 增加怒气
	netPackage.D.Energys = data.Energys


	-- local json_string = require 'framework.basic.Json'.encode(netPackage)
	-- print('---------json_string------')
	-- print(json_string)
	
	self:dealNet(netPackage, function ( netData )
		-- body
		if data.isWin then
			local winData = {}
			winData.mode = data.mode

			local userInfo = require 'UserInfo'

			print('----champion data----')
			print(netData)

			winData.addMoney = netData.D.Gold
			winData.addHonor = netData.D.Hz
			winData.totalExp = userInfo.getExp()
			winData.nextExp = CfgHelper.getCache('role_lv', 'lv', userInfo.getLevel() ).exp

			winData.condition = { false, false, false }
			winData.condition[1] = (data.FinishInTime and 1) or 0
			winData.condition[2] = (data.NoLost and 1) or 0
			winData.condition[3] = (data.LastKillWithSkill and 1) or 0

			winData.Reward = netData.D.Reward

			if netData.D.Resource then
				-- updateResource()
				require 'AppData'.updateResource(netData.D.Resource)
			end

			GleeCore:replaceController('GameOverWin', winData)
		end

		EventCenter.eventInput(FightEvent.Pve_ChampionResult, netData)
	end)
end

function GameOverView:sendTrainMsg( data )
	print('GameOverView:sendTrainMsg:')
	print(data)
	if data.isWin then
		local netData = {}
		netData.C = 'AdvWin'
		netData.D = {}
		netData.D.Lost = data.Lost

		self:dealNet(netData, function ( netData )
			-- body
			-- ret.D.Adventure
			netData.mode = data.mode
			netData.Lost = data.Lost
			GleeCore:replaceController('GameOverWin', netData)
		end )		
	end
end

function GameOverView:sendGuildmatchMsg( data )
	local orginaldata = require 'ServerRecord'.getOriginalData()
	local additiontable = require 'ServerRecord'.getAdditionTable()
	local AtkHarms = 0
	local DefHarms = 0
	local DefHpLeft = {}
	print('sendGuildmatchMsg:')
	print(orginaldata)
	print(data)
	
	local PetInfo = require 'AppData'.getPetInfo()
	PetInfo.resetPetsAdditionWithBox(data.Team)
	PetInfo.resetPetsAdditionWithBox(data.EnemyTeam)
	PetInfo.resetPetsAdditionWithBox(orginaldata.EnemyTeam)
	--减去加成值
	if additiontable then
		PetInfo.reSetPetsAddition(data.Team,additiontable.prop,additiontable.rate)
		PetInfo.reSetPetsAddition(data.EnemyTeam,additiontable.prop,additiontable.rate,additiontable.noPropRate)
		PetInfo.reSetPetsAddition(orginaldata.EnemyTeam,additiontable.prop,additiontable.rate,additiontable.noPropRate)
	end
	--

	local findfunc = function ( list,charactorId,k )
		if list[k] and list[k].charactorId == charactorId then
			return list[k]
		end
		for k,v in pairs(list) do
			if v.charactorId == charactorId then
				return v
			end
		end
	end

	for k,v in pairs(data.Team) do
		local hv = math.floor(v.hpD - v.hpD*(v.hpP/100))
		hv = hv > 0 and hv or 0
		DefHarms = DefHarms + hv
	end

	for k,v in pairs(data.EnemyTeam) do
		local oldv = findfunc(orginaldata.EnemyTeam,v.charactorId,k)
		local hv = math.floor(oldv.hpD*(oldv.hpP/100) - v.hpD*(v.hpP/100))
		hv = hv > 0 and hv or 0
		AtkHarms = AtkHarms + hv
		DefHpLeft[tostring(v.petId)] = math.floor(v.hpD*(v.hpP/100))
	end

	local netPackage = {}
	netPackage.C = 'GuildMatchAtkSettle'
	netPackage.D = {}
	netPackage.D.AtkHarms = AtkHarms
	netPackage.D.DefHarms = DefHarms
	netPackage.D.DefHpLeft = DefHpLeft
	self:dealNet(netPackage,function ( netData )
		if netData.D then
			netData.mode = data.mode
			netData.AtkHarms = AtkHarms
			if data.isWin then
				GleeCore:replaceController('GameOverWin',netData)
			else
				GleeCore:replaceController('GameOverLost',netData)
			end
		end
	end)
end

function GameOverView:sendGuildBossMsg( data )
	local Harm = 0
	for k,v in pairs(data.NpcTeam) do
		local hv = math.floor(v.hpD - v.hpD * (v.hpP/100))
		hv = hv > 0 and hv or 0
		Harm = Harm + hv
	end

	local netPackage = {}
	netPackage.C = 'GuildMatchBoss'
	netPackage.D = {}
	netPackage.D.Harm = Harm
	self:dealNet(netPackage,function ( netData )
		netData.mode = data.mode
		netData.AtkHarms = Harm
		if data.isWin then
			GleeCore:replaceController('GameOverWin',netData)
		else
			GleeCore:replaceController('GameOverLost',netData)
		end
	end)
end

function GameOverView:sendGuildFubenMsg( data )
	local DefHpLeft = {}
	local DefEnergyLeft = {}
	local NpcTotalhpP = 0
	local totalHp = 0
	local totalHpMax = 0

	for k,v in pairs(data.NpcTeam) do
		v.hpD = v.hpD/(v.GH or 1)
		DefHpLeft[tostring(v.petId)] = math.floor(v.hpD*(v.hpP/100))
		DefEnergyLeft[tostring(v.petId)] = math.floor(v.mana)
		totalHpMax = v.hpD + totalHpMax
		totalHp = DefHpLeft[tostring(v.petId)] + totalHp
	end

	NpcTotalhpP = totalHp/totalHpMax*100
	local netPackage = {}
	netPackage.C = 'GuildCopySettle'
	netPackage.D = {}
	netPackage.D.HpLeft = DefHpLeft
	netPackage.D.Energy = DefEnergyLeft
	self:dealNet(netPackage,function ( netData )
		print('GuildCopySettle:')
		print(netData)
		netData.mode = data.mode
		netData.NpcTotalhpP = NpcTotalhpP
		if data.isWin then
			GleeCore:replaceController('GameOverWin',netData)
		else
			GleeCore:replaceController('GameOverLost',netData)
		end
	end)	
end

function GameOverView:sendLimitFubenMsg( data )
	local exdata = require 'ServerRecord'.getExData()
	
	if data.isWin then
		local netPackage = {}
		netPackage.C = 'TimeCopySettle'	
		netPackage.D = {}
		netPackage.D.StageId = exdata and exdata.stageId or 0
		netPackage.D.Stars = self:getResultStars(data)
		self:dealNet(netPackage,function ( netData )
			print('TimeCopySettle:')
			print(netData)
			netData.mode = data.mode
			netData.stars = netPackage.D.Stars
			GleeCore:replaceController('GameOverWin',netData)
		end,function ( netData )
			if netData and netData.Code == 605 then
				GleeCore:replaceController('GameOverLost',netData)
			end
		end)
	else
		GleeCore:replaceController('GameOverLost',netData)
	end
	
end

function GameOverView:sendGuildFubenRob( data )
	local netPackage = {}
	netPackage.C = 'ExploreRobSettle'
	netPackage.D = {}
	netPackage.D.Win = data.isWin
	self:dealNet(netPackage,function ( netData )
		print('ExploreRobSettle:')
		print(netData)
		netData.mode = data.mode
		if data.isWin then
			GleeCore:replaceController('GameOverWin',netData)
		else
			GleeCore:replaceController('GameOverLost',netData)
		end
	end)
end

function GameOverView:sendGuildFubenRevenge( data )
	local exdata = require 'ServerRecord'.getExData()

	local netPackage = {}
	netPackage.C = 'ExploreRevengeSettle'
	netPackage.D = {}
	netPackage.D.Win = data.isWin
	netPackage.D.SlotId = exdata and exdata.SlotId or 0
	self:dealNet(netPackage,function ( netData )
		print('ExploreRevengeSettle:')
		print(netData)
		netData.mode = data.mode
		if data.isWin then
			GleeCore:replaceController('GameOverWin',netData)
		else
			GleeCore:replaceController('GameOverLost',netData)
		end
	end)
end

function GameOverView:sendRemainsFuben(data)
	if not data.isWin then
		GleeCore:replaceController('GameOverLost')
		return
	end

	local exdata = require 'ServerRecord'.getExData()
	local Hps = {}
	for k,v in pairs(data.Team) do
		local hpP = v.hpP/100
		hpP = hpP >= 0 and hpP or 0
		table.insert(Hps,hpP)
	end

	if data.isWin then
	else

	end

	local netPackage = {}
	netPackage.C = 'RemainOp'
	netPackage.D = {}
	netPackage.D.Id = exdata and exdata.Id or 0
	netPackage.D.Hps = Hps
	self:dealNet(netPackage,function ( netData )
		netData.mode = data.mode
		GleeCore:replaceController('GameOverWin',netData)
	end)
end 	

return GameOverView