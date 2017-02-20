--每一波的时间间隔是一样的
local pve_fubensBasicManager = require "Pve_fubensBasicManager"
local MonsterWaveDyManager = require "MonsterWaveDyManager"
local EventCenter = require 'EventCenter'
local fightEvent = require "FightEvent"
local utils = require "framework.helper.Utils"
local FightRunningHelper = require 'FightRunningHelper'

ServePveWavesDyManger =class()

function ServePveWavesDyManger:ctor(  )
	self._waveArr={}	 --怪物波数 数组
	self:addEvents()
end
	
-- function ServePveWavesDyManger:init( fubenid )

-- 	local pve_fubenBasicVo = pve_fubensBasicManager.getPve_fubensBasicVo(fubenid)
-- 	local waveArr = pve_fubenBasicVo.wavearray	

-- 	self._waveSize = #waveArr
-- 	self._playIndex=0
-- 	local monsterWaveDyManager 

-- 	-- print("init-----")
-- 	for i,waveId in ipairs(waveArr) do
-- 		monsterWaveDyManager = MonsterWaveDyManager.new(waveId)
-- 		table.insert(self._waveArr,monsterWaveDyManager)
-- 	end

-- end

function ServePveWavesDyManger:init( fubenData )
	-- body
	self._fubenData = fubenData

	print('----------FubenData----------')
	print(self._fubenData)

	local waveArr 	= fubenData.WaveArray	
	self._waveSize 	= #waveArr
	self._playIndex = 0

	-- print("init-----")
	for i,v in ipairs(waveArr) do
		local monsterWaveDyManager = MonsterWaveDyManager.new( v )
		table.insert(self._waveArr, monsterWaveDyManager)
	end

end

function ServePveWavesDyManger:addEvents(  )

	EventCenter.addEventFunc(fightEvent.Pve_CurrentWaveFinish, function(waveId)
		self:startNext()
	end, 'Fight')	--当前波数完成

	EventCenter.addEventFunc(fightEvent.Pve_Pause, function ( pause )
		-- body
		local curr = self:getCurrentMonsterWaveDyManager()
		if curr then
			if pause then
				curr:pause()
			else
				curr:resume()
			end
		end
	end, 'Fight')
end

function ServePveWavesDyManger:getCurrentMonsterWaveDyManager(  )
	return self._waveArr[self._playIndex]
end

-- 开始下一波
function ServePveWavesDyManger:startNext(  )
	self._playIndex = self._playIndex + 1 

	print("self._playIndex:"..self._playIndex)

	if self._playIndex <= self._waveSize then	
		print('准备下一波:'..self._playIndex) 

		if self._playIndex == 1 then
			local data = { isboss = self._waveArr[self._playIndex]:isBossWave(), waveIndex = self._playIndex, maxWaveIndex = self._waveSize }
			
			FightRunningHelper.delay(function ( )	--停留1秒出现下一波
				EventCenter.eventInput(fightEvent.Pve_NextWaveComing, data)	--//参数  true表示为boss false 表示为不是boss波数
			end, 0)

			FightRunningHelper.delay(function ( )	--停留1秒出现下一波
				self._waveArr[self._playIndex]:start()   --开始刷怪物
			end, 0)
		else

			FightRunningHelper.delay(function ( )	--停留1秒出现下一波
				local waveVo = self._waveArr[self._playIndex]

				if waveVo then
					local data = { isboss = waveVo:isBossWave(), waveIndex = self._playIndex, maxWaveIndex = self._waveSize }
					EventCenter.eventInput(fightEvent.Pve_NextWaveComing, data)	--//参数  true表示为boss false 表示为不是boss波数
				end
				
			end, 0)

			FightRunningHelper.delay(function ( )	--停留1秒出现下一波
				local waveVo = self._waveArr[self._playIndex]
				if waveVo then
					waveVo:start()   --开始刷怪物
				end
			end, 0)
		end
	else --   finish 
		print("波数出完，战斗结束,")
		EventCenter.eventInput(fightEvent.Pve_PreGameOverData, require 'ServerRecord'.createGameOverData(true) )
	end
end

function ServePveWavesDyManger:removeEvents()
end