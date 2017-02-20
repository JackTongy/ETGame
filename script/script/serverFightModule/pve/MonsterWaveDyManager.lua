local FightTimer 			= require 'FightTimer'
local EventCenter 			= require 'EventCenter'
local FightEvent 			= require 'FightEvent'
local IDCreator 			= require 'IDCreator'
local GridManager 			= require 'GridManager'
local TypeRole 				= require "TypeRole"
local RolePlayerManager 	= require 'RolePlayerManager'
local FightRunningHelper 	= require 'FightRunningHelper'
local Utils 				= require 'framework.helper.Utils'

require 'ServeMonsterDyVo'

local MonsterWaveDyManager = class()

function MonsterWaveDyManager:ctor( waveDataArray )

	self._currentTime = require 'FightTimer'.currentFightTimeMillis()
	self._isRunning = false

	self._birthDict = {}			--等待出生的怪物 
	self._onDict = {}				--已经出生了的怪物				 当 等待出生的monster 数组为0  并且 self._onDict的怪物为0  则这一波结束
	self._onDictSize = 0
	self._isBossWave = false

	self._waveId = waveDataArray.waveIndex

	-- print("waveId")
	-- print(waveId)
	-- assert(pve_waveBasicVoArr)
	for i, waveData in ipairs(waveDataArray) do

		local serveMonsterDyVo = ServeMonsterDyVo.new()

		serveMonsterDyVo.dyId			= -1
		serveMonsterDyVo.playerId 		= IDCreator.getID()
		serveMonsterDyVo.entertime 		= waveData.entertime
		serveMonsterDyVo.enterposition 	= waveData.enterposition
		serveMonsterDyVo.isboss 		= waveData.isboss

		serveMonsterDyVo.basicId 		= waveData.role.charactorId
		serveMonsterDyVo.heroid  		= waveData.role.heroid
		
		serveMonsterDyVo.isDropBox 		= waveData.isDropBox
		serveMonsterDyVo.isDropBall 	= waveData.isDropBall
		
		if serveMonsterDyVo.isboss == 1 then
			if require 'ServerRecord'.getDefaultBossCharId() then
				serveMonsterDyVo.basicId = require 'ServerRecord'.getDefaultBossCharId()
			end
		end

		-- if serveMonsterDyVo.basicId == 0 then
		-- 	serveMonsterDyVo.basicId = require 'ServerRecord'.getDefaultBossCharId()
		-- 	assert(serveMonsterDyVo.basicId and serveMonsterDyVo.basicId ~= 0)
		-- end
		
		serveMonsterDyVo.hp 			= waveData.role.hp
		serveMonsterDyVo.hpMax 			= waveData.role.hpMax or waveData.role.hp
		serveMonsterDyVo.atk 			= waveData.role.atk
		serveMonsterDyVo.def 			= waveData.role.def
		serveMonsterDyVo.cri 			= waveData.role.cri or waveData.role.crit
		serveMonsterDyVo.awaken			= waveData.awaken or waveData.role.awaken
		serveMonsterDyVo.SkillCD 		= waveData.role.SkillCD

		assert(serveMonsterDyVo.cri)

		serveMonsterDyVo.speed			= waveData.role.spd
		serveMonsterDyVo.atktime		= waveData.role.atktime
		serveMonsterDyVo.aiType			= waveData.role.aiType or waveData.aiType

		serveMonsterDyVo.birthPos 		= serveMonsterDyVo:getBirthPos()

		serveMonsterDyVo.ID             = waveData.ID

		---新增6项
		serveMonsterDyVo.sv 			=  	waveData.role.sv
		serveMonsterDyVo.fv 			=   waveData.role.fv
		serveMonsterDyVo.cv     		=	waveData.role.cv
		serveMonsterDyVo.bd 			=	waveData.role.bd
		serveMonsterDyVo.hpR   			=   waveData.role.hpR
		serveMonsterDyVo.gb 			=	waveData.role.gb
		
		serveMonsterDyVo.mana 			=   waveData.role.mana
		table.insert(self._birthDict, serveMonsterDyVo)

		--判断是否是boss
		if not self._isBossWave then
			if serveMonsterDyVo.isboss == TypeRole.Monster_Boss then
				self._isBossWave = true
			end
		end
	end

end

function MonsterWaveDyManager:insertServeMonsterDyVo( serveMonsterDyVo )
	-- body
	if self._birthDict then
		table.insert(self._birthDict, serveMonsterDyVo)
	end
end

function MonsterWaveDyManager:start( )
	self._currentTime = require 'FightTimer'.currentFightTimeMillis()
	self:addEvents()
end

--是否是boss波数
function MonsterWaveDyManager:isBossWave()
	return self._isBossWave
end

function MonsterWaveDyManager:pause()
	-- body
	-- self._currentTime = self._currentTime or SystemHelper:currentTimeMillis()
	-- self._offsetTime = SystemHelper:currentTimeMillis() - self._currentTime
	-- self._paused = true

	-- print('MonsterWaveDyManager paused')
end

function MonsterWaveDyManager:resume()
	-- body
	-- self._currentTime = SystemHelper:currentTimeMillis() - (self._offsetTime or 0) 
	-- self._paused = false

	-- print('MonsterWaveDyManager resume')
end

function MonsterWaveDyManager:addEvents(  )
	
	self._updateHandle = FightTimer.addFunc(function ( dt )
		if self._paused then
			return 
		end

		if self._birthDict then
			if #self._birthDict>0 then
				-- print("判断怪物出生")
				local difTime = require 'FightTimer'.currentFightTimeMillis() - self._currentTime

				-- print('difTime = '..difTime)

				local birthDict = {}
				for i,serveMonsterDyVo in ipairs(self._birthDict) do 	--还有没有可以出生的东西
					if difTime >= serveMonsterDyVo.entertime*1000 then	--出生怪物

						-- print('serveMonsterDyVo')
						-- print(serveMonsterDyVo)
						-- +playerId [6]
						-- +enterposition [2]
						-- +def [150]
						-- +entertime [0]
						-- +hp [500]
						-- +cri [40]
						-- +speed [140]
						-- +atktime [1.5]
						-- +atk [1000]
						-- +basicId [12]
						-- +aiType [0]
						-- +maxHp [500]
						-- +isboss [0]
						-- +dyId [-1]

						-- FightEvent.Pve_MonsterWarning = 'Pve_MonsterWarning'
						-- FightEvent.Pve_BossWarning = 'Pve_BossWarning'

						--怪物准备出波
						if serveMonsterDyVo.isboss == 1 then
							-- print('Pve_BossWarning 准备')

							FightRunningHelper.delay(function ()
								-- body
								-- self:birthMonster(serveMonsterDyVo)
								-- self._isRunning = true

								EventCenter.eventInput(FightEvent.Pve_BossWarning, serveMonsterDyVo)
							end, 2)

							-- EventCenter.eventInput(FightEvent.Pve_BossWarning, serveMonsterDyVo)
						else
							-- print('Pve_MonsterWarning 准备')
							EventCenter.eventInput(FightEvent.Pve_MonsterWarning, serveMonsterDyVo)
						end

						self:preBirthMonster(serveMonsterDyVo)

						local delaytime = 0
						if serveMonsterDyVo.entertime >= 0 then
							delaytime = 3
						end

						FightRunningHelper.delay(function ()
							-- body
							self:birthMonster(serveMonsterDyVo)
							self._isRunning = true
						end, delaytime)
						
					else
						table.insert(birthDict,serveMonsterDyVo)
					end
				end
				self._birthDict = birthDict

			else --所有的怪物都出生了   
				if self._onDictSize ==0 and self._isRunning then
					EventCenter.eventInput(FightEvent.Pve_CurrentWaveFinish, self._waveId)		---发送 该波已经完成
					print("currentWaveFinish")
					self:dispose()
				end
			end

		end
	end)
	
	EventCenter.addEventFunc(FightEvent.Pve_S_DeleteMonster,function(dyId )
		self:deleteMonster(dyId)
	end, 'Fight')

end

function MonsterWaveDyManager:preBirthMonster( serveMonsterDyVo )
	-- body
	if not RolePlayerManager.isFightFinish() then
		self._onDict[serveMonsterDyVo.playerId] = serveMonsterDyVo
		self._onDictSize = self._onDictSize + 1
	end
end

--怪物出生
function MonsterWaveDyManager:birthMonster( serveMonsterDyVo )
	if not RolePlayerManager.isFightFinish() then
		-- print("发送怪物出生事件")

		Utils.calcDeltaTime(function ()
			-- body
			-- self._onDict[serveMonsterDyVo.playerId]=serveMonsterDyVo
			-- self._onDictSize=self._onDictSize+1

			EventCenter.eventInput(FightEvent.Pve_S_MonsterBirth, serveMonsterDyVo)
		end, 'MonsterWave 生成怪物时间')
		-- print("发送怪物出生事件 end")
	end
end

-- function MonsterWaveDyManager:deleteMonster( serveMonsterDyVo )
-- 	self._onDict[serveMonsterDyVo.playerId]=nil
-- 	self._onDictSize=self._onDictSize-1
-- end

function MonsterWaveDyManager:deleteMonster( playerId )
	if self._onDict and self._onDict[playerId] then
		self._onDict[playerId]=nil
		self._onDictSize = self._onDictSize-1

		print('delete monster '..playerId)
	end
end



function MonsterWaveDyManager:removeEvents(  )
	-- body
	if self._updateHandle then
		FightTimer.removeFunc(self._updateHandle)
		self._updateHandle=nil
	end	
end

function MonsterWaveDyManager:dispose(  )
	self:removeEvents()

	self._birthDict = nil
	self._onDict = nil
end

return MonsterWaveDyManager