local Config 			= require 'Config'
local Global 			= require 'Global'
local FightSettings 	= require 'FightSettings'
local Default 			= require 'Default'
local GridManager 		= require 'GridManager'
local YFMath 			= require 'YFMath'
local EventCenter 		= require 'EventCenter'
local FightEvent 		= require 'FightEvent'
local UIHelper 			= require 'UIHelper'
local Utils 			= require 'framework.helper.Utils'
local FightConfig 		= require 'FightConfig'
local GridManager 		= require 'GridManager'
local TimerHelper  		= require 'framework.sync.TimerHelper'
local CfgHelper 		= require 'CfgHelper'
local Res 				= require 'Res'
local UIView = class(require 'BasicView')

function UIView:ctor( luaset, isPveOrPvp )
	-- body

	local acceUnlockLevel 		= CfgHelper.getCache('BattleSetConfig', 'Key', 'battlespeedupunlock', 'Value') or 12
	local hideOrToastForAcce 	= CfgHelper.getCache('BattleSetConfig', 'Key', 'battlespeedupvisible', 'Value') == 0
	local autoFightUnlockLevel  = -1 or CfgHelper.getCache('BattleSetConfig', 'Key', 'autofightunlocklv', 'Value') or 12

	print('UIView:ctor scale='..(Global.getWidth() / 1136))

	luaset['layer_bgLayer_#grid']:setScaleX( Global.getWidth() / 1136)
	-- luaset['layer_roleLayer']:setScaleX( Global.WinSize.width / 1136)
	-- luaset['layer_skyLayer']:setScaleX( Global.WinSize.width / 1136)

	-- if Global.getWidth() == 960 then
	-- 	luaset['uiLayer_rb_#']:setPosition(ccp(-112.0,18.0))
	-- else
	-- 	luaset['uiLayer_rb_#']:setPosition(ccp(-156.0,18.0))
	-- end

	if not require 'ServerRecord'.isArenaMode() then
		local level = require 'UserInfo'.getLevel() or 0
		if level < acceUnlockLevel then
			FightConfig.Accelerate = false
		end			
	end
	
	if require 'ServerRecord'.getMode() == 'guider' then
		FightConfig.Auto_AI = false
		FightConfig.Accelerate = false

		luaset['topSkip']:setVisible(true)
		luaset['topSkip']:setPosition(ccp( 556*Global.getWidth()/1136,-288))

		luaset['topSkip']:setListener(function ()
			-- body
			luaset['topSkip']:setVisible(false)

			TimerHelper.tick(function ()
				-- body
				EventCenter.resetGroup( 'FightGuider' )

				require 'ServerRecord'.setGameOverFlag(true)
				EventCenter.eventInput(FightEvent.StopTimer)
				-- body
				require 'FightEffectView'.clean()
				require 'NumberView'.clean()
				require 'LabelView'.clean()
				require 'RoleView'.clean()
				require 'FightLoad'.reset()
				
				--删除所有角色
				require 'FightController':reset() 
				require 'FightTimer'.reset()
				require 'FightLoad'.reset()
				require 'GridManager'.reset()
				
				--重置
				-- CCDirector:sharedDirector():getScheduler():setTimeScale(1)
				require 'UpdateRate'.setUpdateRateScale(1)
				require 'framework.helper.MusicHelper'.stopBackgroundMusic()
				-- require 'framework.helper.MusicHelper'.setBackgroundMusicVolume(1)

				require 'UpdateRate'.setUpdateRateScale(1)
				CCDirector:sharedDirector():getScheduler():setTimeScale(1)
				FightSettings.unLock()

				FightSettings.resume()

				-- GleeCore:popController()
				GleeCore:replaceController('CHome')

				return true
			end, 0)

			-- TimerHelper.tick(function ()
			-- 	-- body
			-- 	return true
			-- end, 0.01)
		end)
	else
		luaset['topSkip']:setVisible(false)
	end

	luaset['uiLayer_rt_AnNiuZu']:setVisible(isPveOrPvp)

	if require 'ServerRecord'.isArenaMode() then
		luaset['layer_bgLayer_grid_bg']:setVisible(false)

		luaset['uiLayer_lt_#boshu']:setVisible(false)
		luaset['uiLayer_lt_#boshu']:setScale(0)
	else
		luaset['uiLayer_lt_#boshu']:setVisible(true)
		luaset['uiLayer_lt_#boshu']:setScale(1)
	end
	
	if require 'ServerRecord'.getMode() == 'guider' or require 'ServerRecord'.getMode() == 'champion' then
		luaset['uiLayer_lt_clock']:setScale(0)
		luaset['uiLayer_lt_clock']:setVisible(false)
	end
	
	if FightConfig.Accelerate then
		luaset['uiLayer_rt_AnNiuZu_acce']:setStateSelected(true)
		FightSettings.setAccelerate(true)
	else
		luaset['uiLayer_rt_AnNiuZu_acce']:setStateSelected(false)
		FightSettings.setAccelerate(false)
	end

	if require 'ServerRecord'.isArenaMode() then
		FightSettings.setAccelerate(true,true)
		local mode = FightSettings.getAccelerateMode()
		local btnimgname = string.format('btn_JS_0%d.png',mode)
		luaset['uiLayer_rt_AnNiuZu_acce']:getSelectedNode():setResid(btnimgname)
		luaset['uiLayer_rt_AnNiuZu_acce']:getUnselectedNode():setResid(btnimgname)
	end

	-- getSelectedNode
	-- getUnselectedNode

	-- init 
	-- if require 'ServerRecord'.isArenaMode() then
	-- 	local resid = luaset['uiLayer_rt_AnNiuZu_acce']:getSelectedNode():getResid()
	-- 	luaset['uiLayer_rt_AnNiuZu_acce']:getUnselectedNode():setResid(resid)
	-- else
	-- 	local level = require 'UserInfo'.getLevel() or 0
	-- 	if level < 5 then
	-- 		local resid = luaset['uiLayer_rt_AnNiuZu_acce']:getUnselectedNode():getResid()
	-- 		luaset['uiLayer_rt_AnNiuZu_acce']:getSelectedNode():setResid(resid)
	-- 	else
	-- 		-- local resid = luaset['uiLayer_rt_AnNiuZu_acce']:getUnselectedNode():getResid()
	-- 		-- luaset['uiLayer_rt_AnNiuZu_acce']:getSelectedNode():setResid(resid)
	-- 	end
	-- end


	if require 'ServerRecord'.isArenaMode() then
		-- local resid = luaset['uiLayer_rt_AnNiuZu_acce']:getSelectedNode():getResid()
		-- luaset['uiLayer_rt_AnNiuZu_acce']:getUnselectedNode():setResid(resid)

		-- if hideOrToastForAcce then
		-- 	luaset['uiLayer_rt_AnNiuZu_acce']:setScale(0)
		-- 	luaset['uiLayer_rt_AnNiuZu_acce']:setVisible(false)
		-- else
			local resid = luaset['uiLayer_rt_AnNiuZu_acce']:getSelectedNode():getResid()
			luaset['uiLayer_rt_AnNiuZu_acce']:getUnselectedNode():setResid(resid)
		-- end
	else
		local level = require 'UserInfo'.getLevel() or 0
		if level < acceUnlockLevel then
			if hideOrToastForAcce then
				luaset['uiLayer_rt_AnNiuZu_acce']:setScale(0)
				luaset['uiLayer_rt_AnNiuZu_acce']:setVisible(false)
			else
				local resid = luaset['uiLayer_rt_AnNiuZu_acce']:getUnselectedNode():getResid()
				luaset['uiLayer_rt_AnNiuZu_acce']:getSelectedNode():setResid(resid)
			end
		else
			-- local resid = luaset['uiLayer_rt_AnNiuZu_acce']:getUnselectedNode():getResid()
			-- luaset['uiLayer_rt_AnNiuZu_acce']:getSelectedNode():setResid(resid)
		end

		if level < autoFightUnlockLevel then
			local resid = luaset['uiLayer_rt_AnNiuZu_auto']:getUnselectedNode():getResid()
			luaset['uiLayer_rt_AnNiuZu_auto']:getSelectedNode():setResid(resid)
		end
	end

	luaset['uiLayer_rt_AnNiuZu_acce']:setListener(function ()
		-- body
		if require 'ServerRecord'.isArenaMode() then
			if FightSettings.swithAccelerateModeEnabled() then
				FightSettings.swithAccelerateMode(true)
				--updateview
				local mode = FightSettings.getAccelerateMode()
				local btnimgname = string.format('btn_JS_0%d.png',mode)
				luaset['uiLayer_rt_AnNiuZu_acce']:getSelectedNode():setResid(btnimgname)
				luaset['uiLayer_rt_AnNiuZu_acce']:getUnselectedNode():setResid(btnimgname)
			else
				UIHelper.toast2(Res.locString('Battle$arenaTips'))	
			end

			-- luaset['uiLayer_rt_AnNiuZu_acce']:setStateSelected(true)			
		else
			local level = require 'UserInfo'.getLevel() or 0
			if level < acceUnlockLevel then
				UIHelper.toast2(string.format(Res.locString('Activity$ActRaidToast'), acceUnlockLevel))
				-- luaset['uiLayer_rt_AnNiuZu_acce']:setStateSelected(false)
			else
				local enabled = luaset['uiLayer_rt_AnNiuZu_acce']:getStateSelected()
				FightSettings.setAccelerate(enabled)
				FightConfig.Accelerate = enabled
				FightConfig.save()
			end
		end
	end)





	-- if require 'ServerRecord'.getMode() == 'guider' or 
	-- 	require 'UserInfo'.getLevel() < 3  or true then

	-- 	luaset['uiLayer_rt_AnNiuZu_acce']:setScale(0)
	-- 	luaset['uiLayer_rt_AnNiuZu_acce']:setVisible(false)
	-- end

	--[[
	--]]

	-- local lastSnapShot
	--暂停
	luaset['uiLayer_rt_AnNiuZu_pause']:setListener(function (  )
		-- body
		GleeCore:showLayer('GamePause')
		
		-- if lastSnapShot then
		-- 	local newSnapShot = Utils.dumpSnapShot()
		-- 	Utils.printSnapShot(newSnapShot, lastSnapShot)
		-- 	lastSnapShot = newSnapShot
		-- else
		-- 	lastSnapShot = Utils.dumpSnapShot()
		-- end
	end)


	luaset['uiLayer_rt_AnNiuZu_jjcAuto']:setListener(function ()
		-- body
		UIHelper.toast2(Res.locString('CArena$AItips'))--('在竞技场中,自动AI默认开启!')
	end)
	
	-- 
	if Default.Debug and Default.Debug.state and luaset['layer_posLayer'] then
		luaset['layer_posLayer']:setVisible(true)

		local index = 1
		for i=-3,3 do
			for j=-1,1 do
				local pos = GridManager.getUICenterByIJ(i, j)
				local sPos = YFMath.logic2physic(pos)

				local pointNode = luaset['layer_posLayer_p'..index]
				
				pointNode:setVisible(true)
				NodeHelper:setPositionInScreen( pointNode, ccp(sPos.x, sPos.y))
				index = index + 1
			end
		end

		-- 
		EventCenter.addEventFunc('GridManagerChange', function ()
			-- body
			if Default.Debug and Default.Debug.state then 
				local index = 1
				for i=-3,3 do
					for j=-1,1 do
						local ownerId = GridManager.getOwnerIdByIJ(i,j)
						local textNode = luaset['layer_posLayer_p'..index..'_label']
						if ownerId then
							textNode:setString(''..ownerId)
						else
							textNode:setString('')
						end
						index = index + 1
					end
				end
			end
		end, 'Fight')

		local originPos = GridManager.getUICenterByIJ(-3, -1)
		
		luaset['layer_posLayer_rect']:setVisible(true)
		luaset['layer_posLayer_rect']:setWidth(GridManager.getUIGridWidth() * GridManager.getScaleX())
		luaset['layer_posLayer_rect']:setHeight(GridManager.getUIGridHeight())
		
		NodeHelper:setPositionInScreen(luaset['layer_posLayer_rect'], ccp(originPos.x, originPos.y))
	else
		if luaset['layer_posLayer'] then
			luaset['layer_posLayer']:setVisible(false)
		end
	end

	EventCenter.addEventFunc('OnAppStatChange', function ( state )
		-- body
		if not require 'ServerRecord'.getMode() == 'guider' then
			if not tolua.isnull(self._luaset[1]) then
				if state == 1 then
					if not FightSettings.isPaused() then
						GleeCore:showLayer('GamePause')
					end
				end
			end
		end
	end, 'Fight')

	if Default.Debug and Default.Debug.state then
		luaset['testBtns_winclick']:setListener(function ()
			-- body
			EventCenter.eventInput(FightEvent.Pve_GameOverQuick, require 'ServerRecord'.createGameOverData(true) )
		end)

		luaset['testBtns_loseclick']:setListener(function ()
			-- body
			EventCenter.eventInput(FightEvent.Pve_GameOverQuick, require 'ServerRecord'.createGameOverData(false) )
		end)
	else
		luaset['testBtns_winclick']:setVisible(false)
		luaset['testBtns_loseclick']:setVisible(false)
	end


	if require 'ServerRecord'.isArenaMode() then

		luaset['uiLayer_rt_AnNiuZu_auto']:setVisible(false)
		luaset['uiLayer_rt_AnNiuZu_auto']:setScaleX(0)

		if require 'ServerRecord'.disablePause() then
			luaset['uiLayer_rt_AnNiuZu_pause']:setVisible(false)
			luaset['uiLayer_rt_AnNiuZu_pause']:setScaleX(0)
		end

		NodeHelper:setTouchable( luaset['layer_touchLayer'], false )
		NodeHelper:setTouchable( luaset['uiLayer_rb_heroArray'], false )
	else
		luaset['uiLayer_rt_AnNiuZu_jjcAuto']:setVisible(false)
		luaset['uiLayer_rt_AnNiuZu_jjcAuto']:setScaleX(0)
	end

	if require 'ServerRecord'.getMode() == 'guildfuben' then
		luaset['uiLayer_rt_AnNiuZu_pause']:setVisible(false)
		luaset['uiLayer_rt_AnNiuZu_pause']:setScaleX(0)
	end

	local resid1, resid2 = require 'BattleBgManager'.getLastBgResid()
	luaset['layer_bgLayer_bg1_pic1']:setResid(resid1)
	luaset['layer_bgLayer_bg1_pic2']:setResid(resid2)

	luaset['layer_bgLayer_bg2_pic1']:setResid(resid1)
	luaset['layer_bgLayer_bg2_pic2']:setResid(resid2)

	luaset['layer_bgLayer_bg3_pic1']:setResid(resid1)
	luaset['layer_bgLayer_bg3_pic2']:setResid(resid2)

	-- 引导副本自动ai
	if FightConfig.Auto_AI then
		luaset['uiLayer_rt_AnNiuZu_auto']:setStateSelected(true)
	else
		luaset['uiLayer_rt_AnNiuZu_auto']:setStateSelected(false)
	end

	local function isGuideForFubenBossAuto()
		return require 'ServerRecord'.getMode() == 'fuben' or require 'ServerRecord'.getMode() == 'fuben_boss'
	end

	luaset['uiLayer_rt_AnNiuZu_auto']:setListener(function (  )
		-- body
		local level = require 'UserInfo'.getLevel() or 0
		if level < autoFightUnlockLevel then
			UIHelper.toast2(string.format('玩家等级达到%d级解锁',autoFightUnlockLevel))
			return
		end

		FightConfig.Auto_AI = luaset['uiLayer_rt_AnNiuZu_auto']:getStateSelected()
		if require 'ServerRecord'.getMode() ~= 'guider' then
			FightConfig.save()
		end

		if isGuideForFubenBossAuto() then
			require 'GuideHelper':check('clickAuto')
		end
	end)

	EventCenter.addEventFunc(FightEvent.Guider_Click_AutoFight, function ( data )
		local node = luaset['uiLayer_rt_AnNiuZu_auto']
		if not tolua.isnull(node) then
			node:trigger(node)
		end
	end, 'Fight')

	luaset['uiLayer_rt_AnNiuZu']:layout()

	if isGuideForFubenBossAuto() then
		require 'GuideHelper':registerPoint('自动', luaset['uiLayer_rt_AnNiuZu_auto'])
		require 'GuideHelper':check('BossBattleStart')
	end

	EventCenter.addEventFunc(FightEvent.Pve_FirstFight, function (data)
		-- body
		FightConfig.Auto_AI = false

		luaset['uiLayer_rt_AnNiuZu_auto']:setVisible(false)
		luaset['uiLayer_rt_AnNiuZu_auto']:setScaleX(0)

		-- luaset['uiLayer_rt_AnNiuZu_acce']:setVisible(false)
		-- luaset['uiLayer_rt_AnNiuZu_acce']:setScaleX(0)

	end, 'Fight')

	if require 'ServerRecord'.getMode() == 'guider' then
		luaset['uiLayer_rt_AnNiuZu_acce']:setVisible(false)
		luaset['uiLayer_rt_AnNiuZu_acce']:setScaleX(0)

		luaset['uiLayer_rt_AnNiuZu_auto']:setVisible(false)
		luaset['uiLayer_rt_AnNiuZu_auto']:setScaleX(0)

		luaset['uiLayer_rt_AnNiuZu_pause']:setVisible(false)
		luaset['uiLayer_rt_AnNiuZu_pause']:setScaleX(0)
	end

	EventCenter.addEventFunc(FightEvent.Pve_SecondFight, function (data)
		-- body
		FightConfig.Auto_AI = false
		luaset['uiLayer_rt_AnNiuZu_auto']:setStateSelected(false)

		luaset['uiLayer_rt_AnNiuZu_auto']:setVisible(false)
		luaset['uiLayer_rt_AnNiuZu_auto']:setScaleX(0)
		
	end, 'Fight')
	
	EventCenter.addEventFunc(FightEvent.Pve_FirstStage, function (data)
		-- body
		FightConfig.Auto_AI = false
		luaset['uiLayer_rt_AnNiuZu_auto']:setStateSelected(false)
		
		luaset['uiLayer_rt_AnNiuZu_auto']:setVisible(false)
		luaset['uiLayer_rt_AnNiuZu_auto']:setScaleX(0)
		
	end, 'Fight')
	
	EventCenter.addEventFunc(FightEvent.Pve_FirstStage, function (data)
		-- body
		FightConfig.Auto_AI = false
		luaset['uiLayer_rt_AnNiuZu_auto']:setStateSelected(false)
		
		luaset['uiLayer_rt_AnNiuZu_auto']:setVisible(false)
		luaset['uiLayer_rt_AnNiuZu_auto']:setScaleX(0)
		
	end, 'Fight')

	self._luaset = luaset
	-- self:addDyElement()
end

function UIView:addDyElement()
	-- body
	-- local rect = RectangleNode:create()
	-- rect:setColorf(0,0,0,0.5)
	-- rect:setWidth(1136)
	-- rect:setHeight(640)
	-- self._luaset['layer_specialLayer']:addChild(rect)
	self._luaset['layer_bgLayer_bg1']:setColorf(0.5,0.5,0.5,1)
	self._luaset['layer_bgLayer_bg2']:setColorf(0.5,0.5,0.5,1)
	self._luaset['layer_bgLayer_bg3']:setColorf(0.5,0.5,0.5,1)

	local particle = ParticleNode:create('particle/particle_rain2.plist','particle/particle_rain2.png')
	self._luaset['layer_specialLayer']:addChild(particle)
end

function UIView:update()
	-- body
end

return UIView








