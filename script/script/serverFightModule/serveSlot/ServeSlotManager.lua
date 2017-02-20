--服务端能量球  控制器
local FightTimer =require "FightTimer"
local CharactorConfigBasicManager = require "CharactorConfigBasicManager"
local FightEvent = require "FightEvent"
local EventCenter = require "EventCenter"
local Random = require 'Random'

ServeSlotManager = class()

function ServeSlotManager:ctor(serveRoleArray)
	self._serveRoleArray=serveRoleArray

	-- print('self:initPVEOnWaveCreate()')
	self:initPVEOnWaveCreate()
end

function ServeSlotManager:start( )
	-- body
	self._currentTime = require 'FightTimer'.currentFightTimeMillis()
	
end

-- pve 没有每隔20时间获取能量球的方式
-- function ServeSlotManager:updateIt(  )
-- 	if SystemHelper:currentTimeMillis() - self._currentTime >= 20 then

-- 	end
-- end

--创建能量球
function ServeSlotManager:createSlotBall( num )
	local careerArr = {}
	local playerArr = self._serveRoleArray:getPlayerArr()
	local charactorBasicVo 

	for i,heroClass in ipairs(playerArr) do
		-- print('----heroClass----')
		-- print(heroClass)
		if heroClass.charactorId and (not heroClass:isMonster()) and (not heroClass:isDisposed()) and heroClass:isBorned() then
			charactorBasicVo = CharactorConfigBasicManager.getCharactorBasicVo(heroClass.charactorId)
			careerArr[charactorBasicVo.atk_method_system] = charactorBasicVo.atk_method_system
		end
	end

	local careerArray = {}
	for k,atk_method_system in pairs(careerArr) do
		table.insert(careerArray,atk_method_system)
	end

	local len = #careerArray
	local  ret = {}
	for i=1,num do
		local random = Random.ranI(1, len)
		local testCareer = careerArray[random]
		table.insert(ret,testCareer)
	end
	return ret
end

--pve开始时候发送能量球
function ServeSlotManager:PVEStartCreate(label)

	local arr ={1,2,3}
	local len = #arr
	local index = Random.ranI(1, len)
	local dataNum = arr[index]

	-- local dataNum = 8
	local mode = require 'ServerRecord'.getMode()
	if mode == 'champion' then
		dataNum = 3
	end

	local Bs = self:createSlotBall(dataNum)
	local S = 1
	local serveData ={ D = { Bs = Bs, S = S, label = label } }

	print('Slot Create')
	print(serveData)

	EventCenter.eventInput(FightEvent.Pve_Slot, serveData )
end

function ServeSlotManager:initPVEOnWaveCreate()

	-- print('ServeSlotManager:initPVEOnWaveCreate()')
	-- print(debug.traceback())

	-- body
	-- EventCenter.eventInput(FightEvent.Pve_NextWaveComing,self._waveArr[self._playIndex]:isBossWave())	--//参数  true表示为boss false 表示为不是boss波数
	EventCenter.addEventFunc(FightEvent.Pve_NextWaveComing, function ( data )
		-- body
		print('recv Pve_NextWaveComing:')
		print(data)

		local label = string.format('%d/%d',data.waveIndex, data.maxWaveIndex)

		local index = data.waveIndex
		-- if index > 1 then
		self:PVEStartCreate(label)
		-- end

		-- self:PVEStartCreate()
	end, 'Fight') 

	EventCenter.addEventFunc(FightEvent.Pve_MakeASkillBall, function ( data )
		-- body
		self:makeAKillBall( data.Hid )

	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_MakeInitBalls, function ( data )
		-- body
		self:makeBalls(data)

	end, 'Fight')

end

--[[

--]]
function ServeSlotManager:makeBalls(num)
	-- body
	-- local arr ={1}
	-- local len = #arr
	-- local index = 1
	-- local dataNum = arr[index]
	-- num = num 
	local Bs = self:createSlotBall(num)
	local S = 2
	local serveData ={ D = { Bs = Bs, S = S} }

	print('Slot makeBalls')
	print(serveData)

	EventCenter.eventInput(FightEvent.Pve_Slot, serveData )
end

function ServeSlotManager:makeAKillBall( Hid )
	-- body
	-- local arr ={1}
	-- local len = #arr
	-- local index = 1
	-- local dataNum = arr[index]
	-- num = num 
	local Bs = self:createSlotBall(1)
	local S = 3
	local serveData ={ D = { Bs = Bs, S = S, Hid = Hid} }

	print('Slot makeAKillBall')
	print(serveData)

	EventCenter.eventInput(FightEvent.Pve_Slot, serveData )
end
