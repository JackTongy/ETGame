local Config 			= require 'Config'
local Global 			= require 'Global'
local EventCenter 		= require 'EventCenter'
local FightEvent 		= require 'FightEvent'
local TimeOut 			= require 'TimeOut'
local Swf 				= require 'framework.swf.Swf'
local LayerManager 		= require 'LayerManager'
local TimerHelper       = require 'framework.sync.TimerHelper'
local XmlCache 			= require 'XmlCache'
local FightSettings 	= require 'FightSettings'

local CMBSView = class(require 'BasicView')

function CMBSView:ctor( luaset, document )
	-- body
	self._luaset 	= luaset
	self._document 	= document

	EventCenter.addEventFunc(FightEvent.Guider_CMBS , function ( data )
		-- body
		-- Swf_bossShanChuTeXiao
		-- Swf_ChaoMengBianShen
		local mySwf = Swf.new('Swf_bossShanChuTeXiao')
		
		local shapeMap = {}
		shapeMap['shape-4'] = 'Swf_bossShanChuTeXiao-4.png'
		shapeMap['shape-8'] = 'Swf_bossShanChuTeXiao-8.png'
		-- for i=1,25 do
		-- 	shapeMap['shape-'..(i*2)] = 'Swf_ChaoMengBianShen-'..(i*2)..'.png'
		-- end
		-- shapeMap['white.png'] = 'white.png'
		
		-- 换黑色
		mySwf:play(shapeMap, nil, function ()
			-- body
			mySwf:getRootNode():removeFromParent()
		end)

		LayerManager.topLayer:addChild(mySwf:getRootNode())

		TimerHelper.tick(function ()
			-- body
			if not tolua.isnull(self._luaset['layer_bgLayer_bg1']) then
				-- self._luaset['layer_bgLayer_bg1']:setResid('subspace_1.png')
				-- self._luaset['layer_bgLayer_bg2']:setResid('subspace_1.png')
				-- self._luaset['layer_bgLayer_bg3']:setResid('subspace_1.png')

				local resid1 = 'subspace_1_01.jpg'
				local resid2 = 'subspace_1_02.jpg'

				self._luaset['layer_bgLayer_bg1_pic1']:setResid(resid1)
				self._luaset['layer_bgLayer_bg1_pic2']:setResid(resid2)

				self._luaset['layer_bgLayer_bg2_pic1']:setResid(resid1)
				self._luaset['layer_bgLayer_bg2_pic2']:setResid(resid2)

				self._luaset['layer_bgLayer_bg3_pic1']:setResid(resid1)
				self._luaset['layer_bgLayer_bg3_pic2']:setResid(resid2)
			end

			EventCenter.eventInput(FightEvent.Guider_Pve_FightPause, false)

			return true
		end, 17/24)
		
		-- 
		-- set background
		-- client delete role
		-- server delete role
		
	end, 'Fight')

	--引导结束跳转
	EventCenter.addEventFunc('Guider_Finished', function ( data )
		-- body
		print('Guider_Finished called!')

		if not tolua.isnull( LayerManager.topLayer ) then

			local slowRate = 0.15

			CCDirector:sharedDirector():getScheduler():setTimeScale( slowRate )

			-- TimerHelper.tick(function ()
				-- body
			local action = ElfAction:create(CCFadeIn:create(0.9*(0.1/slowRate)))
			local blackLuaset = XmlCache.createDyLuaset('@black', 'FightGuider', 'Fight' )
			blackLuaset[1]:setColorf(0,0,0,0)
			blackLuaset[1]:setVisible(true)
			blackLuaset[1]:runAction(action)
			LayerManager.topLayer:addChild(blackLuaset[1])
			-- 	return true
			-- end, 0.5)

			-- for i=1,5 do
			-- 	TimerHelper.tick(function ()
			-- 		-- body
			-- 		require 'framework.helper.MusicHelper'.setBackgroundMusicVolume(1-(i/5))
			-- 		return true
			-- 	end, (0.1/slowRate)*0.5*i/5)
			-- end

			-- TimerHelper.tick(function ()
			-- 	-- body
			-- 	require 'framework.helper.MusicHelper'.setBackgroundMusicVolume(1-(i/5))
			-- 	return true
			-- end, (0.1/slowRate)*0.5*15/5)

			local tttt = 0.1 * 0.5

			TimerHelper.tick(function ()
				-- body
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

				return true
			end, (tttt/slowRate)*0.8)

			TimerHelper.tick(function ()
				-- body
				require 'UpdateRate'.setUpdateRateScale(1)
				CCDirector:sharedDirector():getScheduler():setTimeScale(1)
				FightSettings.unLock()

				-- GleeCore:popController()
				GleeCore:replaceController('CHome')
				
				return true
			end, (tttt/slowRate)*1.0)

		end
	end, 'Fight')
end




return CMBSView


