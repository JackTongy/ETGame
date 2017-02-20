local EventCenter 		= require 'EventCenter'
local XmlCache 			= require 'XmlCache'
local FightEvent    	= require 'FightEvent'
local FightSettings 	= require 'FightSettings'
local TimerHelper 		= require 'framework.sync.TimerHelper'
local CfgHelper 		= require 'CfgHelper'
local GuideHelper 		= require 'GuideHelper'


local WinSize = CCDirector:sharedDirector():getWinSize()

local FightGuider = {}
local self = {}

function FightGuider.initEvents()
	-- body
	EventCenter.resetGroup('FightGuider')

	self._soundArray = {}

	EventCenter.addEventFunc('Guider_Pve_FightPause', function ( data )
		-- body
		if data then
			FightSettings.pause()
		else
			FightSettings.resume()
		end
	end, 'FightGuider')

	EventCenter.addEventFunc('Guider_Pve_StopSound', function ( data )
		-- body
		for i,soundId in ipairs(self._soundArray) do
			require 'framework.helper.MusicHelper'.stopEffect(soundId)
		end

		self._soundArray = {}

	end, 'FightGuider')

	EventCenter.addEventFunc('Guider_Play_Effect', function ( data )
		-- body
		assert(data.sound)
		for i, soundId in ipairs(self._soundArray) do
			require 'framework.helper.MusicHelper'.stopEffect( soundId )
		end
		
		self._soundArray = {}
		
		local soundId = require 'framework.helper.MusicHelper'.playEffect( data.sound ) 
		table.insert(self._soundArray, soundId)
		
	end, 'FightGuider')

	EventCenter.addEventFunc('Guider_Next', function ( data )
		-- body
		FightGuider.setHandlePause( false )
		FightGuider.setStepGuiderDisposed()
	end, 'FightGuider')

	EventCenter.addEventFunc('Guider_AddMana', function ( data )
		-- body
		assert(data)
		assert(data.playerId)

		data.mana = 400
		-- EventCenter.eventInput( FightEvent.Pve_AddMana, data )

	end, 'FightGuider')

	EventCenter.addEventFunc('Guider_Pve_ReleaseSkill', function ( data )
		-- body
		assert(data)
		assert(data.playerId)

		EventCenter.eventInput( FightEvent.Pve_TriggerBigSkill, data )
	end, 'FightGuider')

	--引导结束跳转
	EventCenter.addEventFunc('Guider_Finished', function ( data )
		-- body

	end, 'FightGuider')
end

function FightGuider.setStepGuiderDisposed()
	-- body
	local index = self._lastTriggerIndex

	local luaset = self._luasetArray[index]
	if luaset and not tolua.isnull(luaset[1]) then
		NodeHelper:setTouchable(luaset[1], false)
		
		local fadeout = ElfAction:create( CCFadeOut:create(0.5) )
		fadeout:setListener(function ()
			-- body
			luaset[1]:removeFromParent()
		end)
		luaset[1]:runElfAction(fadeout)

		self._luasetArray[index] = nil
	end
end

function FightGuider.setHandlePause( enable )
	-- body
	self._handlePaused = enable

	print('setHandlePause '..tostring(self._handlePaused))
end

function FightGuider.run( stepArray, layerManager )
	-- body
	assert(stepArray)
	assert(layerManager)

	FightGuider.initEvents()

	GuideHelper:recordGuideStepDes('战斗前剧情结束')

	self._progress = 0
	self._lastTriggerIndex = 0
	self._handlePaused = false
	self._luasetArray = {}

	self._lastMills = require 'FightTimer'.currentFightTimeMillis()


	local adjustElemets = {
		['@Guide1_0']=true, ['@Guide1_1']=true, ['@Guide1_2']=true,
		['@Guide2_0']=true, ['@Guide2_1']=true, ['@Guide2_2']=true,
		['@Guide3_0']=true, ['@Guide3_1']=true, ['@Guide3_2']=true,
		['@Guide4_0']=true, ['@Guide4_1']=true, ['@Guide4_2']=true,
	}

	self._handle = TimerHelper.tick(function ( pppp )
		-- body
		if self._lastTriggerIndex >= #stepArray then
			print('战斗引导运行结束!')
			return true
		end

		---time form fight?
		if not self._handlePaused then
			local nowMills = require 'FightTimer'.currentFightTimeMillis()
			local dt = (nowMills - self._lastMills)/1000

			self._progress = self._progress + dt

			self._lastMills = nowMills

			local nextIndex = self._lastTriggerIndex + 1

			local guideStep = stepArray[nextIndex]
			assert(guideStep)
			assert(guideStep.time)
			assert(guideStep.init)

			-- assert(guideStep.element)
			-- assert(guideStep.triggers)
			print('guideStep.time='..guideStep.time)
			print('self._progress='..self._progress)

			if guideStep.time <= self._progress then
				-- self._progress = guideStep.time
				-- 增加引导信息收集
				-- index. 第几步骤
				-- time, 当前战斗运行的时间(单位秒)

				print('index:'..nextIndex)
				print('time:'..self._progress)
				GuideHelper:recordGuideStepDes(string.format('战斗引导中:index=%d', nextIndex))
				-- local SocketClient = require 'SocketClient'
				-- SocketClient.send0( data, callback, errcallback,delay,timeout, ptype,flag)

				
				FightGuider.setHandlePause( true )
				self._lastTriggerIndex = nextIndex
				
				
				if not tolua.isnull(layerManager.topLayer) then
					if guideStep.element then
						local luaset = XmlCache.createDyLuaset(guideStep.element, 'FightGuider', 'Fight')
						assert(luaset)



						if guideStep.CID then
							local value = CfgHelper.getCache('Dialogue', 'CID', guideStep.CID)
							local text = value['Content']

							luaset['tips_bg_info']:setString(''..text)

							local DBManager = require 'DBManager'
							local name = DBManager.getCharactor( value['PetID'] ).name

							if luaset['tips_bg_name'] then
								luaset['tips_bg_name']:setString( name )
							end
						end

						if adjustElemets[guideStep.element] then
							if luaset['shader'] then
								luaset['shader']:setScaleX(WinSize.width/1136)

								if luaset['shader_sb_circle'] then
									luaset['shader_sb_circle']:setScaleX(1136/WinSize.width)
								end
							end

							if luaset['effect'] then
								local px, py = luaset['effect']:getPosition()
								luaset['effect']:setPosition(ccp(px*WinSize.width/1136, py))
							end
						end

						for key,actionArray in pairs(guideStep.triggers) do
							assert(luaset[key])

							luaset[key]:setListener(function ()
								-- body
								print('trigger actionArray!')

								for ii,actionItem in ipairs(actionArray) do

									if actionItem.action == 'Guider_TouchEvent' then
										local eData = {}
										local currentPos = NodeHelper:getPositionInScreen(luaset[key])

										eData.eventType = actionItem.data.eventType
										eData.x = currentPos.x
										eData.y = currentPos.y

										-- print('trigger event')
										-- print(eData)

										EventCenter.eventInput( actionItem.action, eData )
									else

										-- print('trigger event')
										-- print(actionItem)

										EventCenter.eventInput( actionItem.action, actionItem.data )
									end
									
								end
							end)
						end

						-- local fadein = CCFadeIn:create(0.5)
						luaset[1]:setColorf(1,1,1,1)
						luaset[1]:setVisible(true)
						-- luaset[1]:runElfAction(fadein)
						layerManager.topLayer:addChild( luaset[1] )

						self._luasetArray[self._lastTriggerIndex] = luaset
					end
				end

				-- 初始化
				for i,actionItem in ipairs(guideStep.init) do
					EventCenter.eventInput( actionItem.action, actionItem.data )
				end
			end
		end
	end)
end

function FightGuider.start()
	-- body
	FightGuider.init()

end

function FightGuider.init()
	EventCenter.eventInput(FightEvent.Pve_FightGuiderEnable, true)
	FightGuider.run( require 'FightGuiderSteps'.step ,require 'LayerManager' )
end

return FightGuider


-- local EventCenter 	= require 'EventCenter'
-- local FightEvent 	= require 'FightEvent'
-- local FightGuider   = require 'FightGuider'

-- local FightGuiderController = {}
-- local self = {}

-- function FightGuiderController.start()
-- 	-- body
-- 	FightGuiderController.init()

-- end

-- function FightGuiderController.init()
-- 	EventCenter.eventInput(FightEvent.Pve_FightGuiderEnable, true)

-- 	FightGuider.start( require 'FightGuiderSteps'.step ,require 'LayerManager' )
-- end

-- return FightGuiderController