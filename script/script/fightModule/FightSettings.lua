
local RoleSelfManager 	= require 'RoleSelfManager'
local LayerManager 		= require 'LayerManager'
local Config 			= require 'Config'
local EventCenter 		= require 'EventCenter'
local FightEvent 		= require 'FightEvent'
local FightTimer 		= require 'FightTimer'
local FightController 	= require 'FightController'

local AcceleModes = nil

local FightSettings = {}

FightSettings._isPaused = false
FightSettings._accelerate = false
FightSettings._acceleMode = 1

function FightSettings.getChildren( layer )
	-- body
	local ret = {}

	if not tolua.isnull( layer ) then
		local ccarray = layer:getChildren()
		if ccarray then
			local size = ccarray:count()
			
			for i=1,size do
				local index = i-1
				local child = ccarray:objectAtIndex(index)

				table.insert(ret, child)
			end
		end
	end

	return ret
end

function FightSettings.setLayerPaused(layer, paused )
	-- body
	if not tolua.isnull( layer ) then
		layer:setNodePaused( (paused and true) or false)
	end 

	-- local ccScheduler = CCDirector:sharedDirector():getScheduler()
	-- local ccActionManager = CCDirector:sharedDirector():getActionManager()

	-- local array = FightSettings.getChildren( layer )
	-- for i,v in ipairs(array) do
	-- 	if paused then
	-- 		-- v:pauseSchedulerAndActions()

	-- 		-- ccScheduler:pauseTarget(v);
	-- 		ccActionManager:pauseTarget(v);

	-- 		ccActionManager:pauseAllRunningActions()

	-- 	else
	-- 		-- ccScheduler:resumeTarget(v);
	-- 		ccActionManager:resumeTarget(v);

	-- 		-- resumeTargets
	-- 	end
	-- end
end

function FightSettings.setPaused( paused )
	-- body
-- layerManager.bgLayer=obj.bgLayer
-- layerManager.bgSkillLayer=obj.bgSkillLayer
-- layerManager.roleLayer=obj.roleLayer
-- layerManager.skyLayer=obj.skyLayer
-- layerManager.specialLayer=obj.specialLayer
-- layerManager.uiLayer=obj.uiLayer
-- layerManager.fightTextLayer=obj.fightTextLayer
-- layerManager.touchLayer=obj.touchLayer
-- layerManager.touchLayerAbove=obj.touchLayerAbove
	FightSettings.setLayerPaused( LayerManager.bgLayer, paused )
	FightSettings.setLayerPaused( LayerManager.bgSkillLayer, paused )
	FightSettings.setLayerPaused( LayerManager.roleLayer, paused )
	FightSettings.setLayerPaused( LayerManager.skyLayer, paused )
	FightSettings.setLayerPaused( LayerManager.specialLayer, paused )
	FightSettings.setLayerPaused( LayerManager.fightTextLayer, paused )
	FightSettings.setLayerPaused( LayerManager.bgLayer, paused )

	FightSettings._isPaused = paused
end

function FightSettings.isPaused()
	-- body
	return FightSettings._isPaused
end

function FightSettings.pause(  )
	-- body
	-- debug.catch(true, 'FightSettings.pause')

	if RoleSelfManager.isPvp  then 
		return false
	end

	-- debug.catch(true, 'pause')

	FightTimer.pause()

	EventCenter.eventInput(FightEvent.Pve_Pause, true)

	local ccActionManager = CCDirector:sharedDirector():getActionManager()
	FightSettings.setPaused( true )

	if FightSettings._set then
		FightSettings._set:release()
		FightSettings._set = nil
	end
	
	FightSettings._set = ccActionManager:pauseAllRunningActions()
	FightSettings._set:retain()
end

function FightSettings.resume( )
	-- body
	-- debug.catch(true, 'FightSettings.resume')
	
	if RoleSelfManager.isPvp  then 
		return false
	end

	-- debug.catch(true, 'resume')

	FightTimer.resume()

	EventCenter.eventInput(FightEvent.Pve_Pause, false)

	local ccActionManager = CCDirector:sharedDirector():getActionManager()
	
	FightSettings.setPaused( false )

	if FightSettings._set then
		ccActionManager:resumeTargets(FightSettings._set)
		FightSettings._set:release()
		FightSettings._set = nil
	end

end


--[[
--]]
function FightSettings.isLocked()
	-- body
	return FightSettings._locked
end

function FightSettings.setLocked()
	-- body
	FightSettings._locked = true
end

function FightSettings.unLock()
	-- body
	FightSettings._locked = false
end


function FightSettings.quit()
	-- body
	FightTimer.reset()

	--删除所有角色
	FightController:reset() 

	--重置
	require 'UpdateRate'.setUpdateRateScale(1) 
	CCDirector:sharedDirector():getScheduler():setTimeScale(1) 

	FightTimer.setSpeedRate(1)
end

local function setAccelerateFunc( rate )
	FightTimer.setSpeedRate(rate)
	CCDirector:sharedDirector():getScheduler():setTimeScale(rate)
end

function FightSettings.setAccelerate( enable,isArenaMode )
	-- body
	FightSettings.initAccelerateMode()

	if RoleSelfManager.isPvp  then 
		return false
	end

	FightSettings._accelerate = enable

	if enable then
		-- require 'UpdateRate'.setUpdateRateScale(1.5)
		local scale = 1.5
		if isArenaMode then
		--[[
			拥有月卡时激活3倍加速特权
			拥有豪华月卡时激活4倍加速特权 玩家可以点击加速按钮切换加速度 默认为最高速度
		]]
			FightSettings._acceleMode = (AcceleModes[4] and 4) or (AcceleModes[3] and 3) or (AcceleModes[2] and 2)
			scale = AcceleModes[FightSettings._acceleMode]
		end
		setAccelerateFunc(scale)

	else
		setAccelerateFunc(1)
	end
end

function FightSettings.getAccelerate()
	-- body
	if RoleSelfManager.isPvp  then 
		return false
	end

	return FightSettings._accelerate
end

function FightSettings.swithAccelerateMode( isArenaMode )

	local nextmode = 2
	for i=FightSettings._acceleMode+1,#AcceleModes do
		if AcceleModes[i] then
			nextmode = i
			break
		end
	end

	setAccelerateFunc(AcceleModes[nextmode])
	FightSettings._acceleMode = nextmode
end

function FightSettings.swithAccelerateModeEnabled( ... )
	return AcceleModes[3] or AcceleModes[4]
end

function FightSettings.initAccelerateMode( ... )
	AcceleModes = 
	{
		[1] = 1,
		[2] = 1.5,
		[3] = 2,
		[4] = 2.5,
	}
	local rechargeInfo = require "RechargeInfo".getData()
	if not rechargeInfo.MCard then
		AcceleModes[3] = nil
	end

	if not rechargeInfo.MCardLux then
		AcceleModes[4] = nil
	end
end

function FightSettings.getAccelerateMode( ... )
	return FightSettings._acceleMode
end

return FightSettings