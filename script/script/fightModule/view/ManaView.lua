local EventCenter 			= require 'EventCenter'
local FightEvent 			= require 'FightEvent'
local Res 					= require 'Res'
local FightTimer 			= require 'FightTimer'
local FightConfig			= require 'FightConfig'
local FightSettings 		= require 'FightSettings'
local UIHelper 				= require 'UIHelper'
-- local 

local Career_Kuangs = {
	[1] = 'XT_zhiye_1.png',
	[2] = 'XT_zhiye_2.png',
	[3] = 'XT_zhiye_3.png',
	[4] = 'XT_zhiye_4.png',
}

local Career_Bgs = {
	[1] = 'XT_zhiye1s.png',
	[2] = 'XT_zhiye2s.png',
	[3] = 'XT_zhiye3s.png',
	[4] = 'XT_zhiye4s.png',
}

local Career_BB_Balls = {
	[1] = 'XT_zhiye1.png',
	[2] = 'XT_zhiye2.png',
	[3] = 'XT_zhiye3.png',
	[4] = 'XT_zhiye4.png',
} 

--3/3,2/3,1/3,0/3,   2/2,1/2,0/2,   1/1,0/1
local Point_Images = {
	['3-3'] = 'XT_nengliang3_4.png',
	['3-2'] = 'XT_nengliang3_3.png',
	['3-1'] = 'XT_nengliang3_2.png',
	['3-0'] = 'XT_nengliang3_1.png',

	['2-2'] = 'XT_nengliang2_3.png',
	['2-1'] = 'XT_nengliang2_2.png',
	['2-0'] = 'XT_nengliang2_1.png',

	['1-1'] = 'XT_nengliang1_2.png',
	['1-0'] = 'XT_nengliang1_1.png',
}

local Career_Index = {
	[1] = 1,
	[2] = 2,
	[3] = 4,
	[4] = 3,
}

local Mana_Colors = {
	[1] = { 1, 1, 1, 1 },
	[2] = { 1.0,0.76862746,0.2784314,1.0 },
	-- 
	[3] = { 1.0,0.32156864,0.36862746,1.0 },
	-- 
}

local ManaView = class(require 'BasicView')

function ManaView:ctor(luaset, document)
	-- body
	self._luaset 	= luaset
	self._document 	= document

	self._playerMap = {}

	self:initEvents()
end

function ManaView:initEvents()
	-- body
	EventCenter.addEventFunc(FightEvent.Pve_CreatePlayerMana, function ( data )
		-- body
		----friend? 替补?
		local isFriend 	= data.isFriend
		local isTibu 	= data.T
		local isGuildMember = data.isGuildMember
		local cloth 	= data.cloth
		assert(cloth)

		local playerId 	= data.playerId
		assert(playerId)

		local career 	= data.career
		assert(career)
		assert(career>=1 and career<=4)

		local basicId = data.basicId
		assert(basicId)

		local actionNode = cloth:getActionNode()
		assert(actionNode)

		local bloodView = cloth:getBloodView()
		assert(bloodView)

		local careerIndex = Career_Index[career]
		if isTibu then
			careerIndex = 10
		end

		print('Pve_CreatePlayerMana')
		local dataStruct = {playerId = playerId,  cloth = tostring(cloth), bloodView = tostring(bloodView), basicId = basicId, career = career}
		print(dataStruct)

		local item = self:createLuaSet(self._document, '@heroMana')
		self._luaset['uiLayer_rb_heroArray']:addChild( item[1], careerIndex )

		item['button']:setListener(function ()
			-- body
			-- 开关...
			EventCenter.eventInput( FightEvent.Pve_TriggerBigSkill_Btn, { playerId = playerId } )

			if item['arrow'] then
				item['arrow']:setVisible(false)
				item['arrow'] = nil
			end
		end)

		item['bg']:setResid( Career_Bgs[career] )
		item['kuang']:setResid( Career_Kuangs[career] )


		item['pic_del_tou']:setResid( require 'SkinManager'.getTouImage(basicId) )
		item['pic_del_face']:setResid( require 'SkinManager'.getNormalFaceImage(basicId) )

		item['pic_delGray_tou']:setResid( require 'SkinManager'.getTouImage(basicId) )
		item['pic_delGray_face']:setResid( require 'SkinManager'.getNormalFaceImage(basicId) )

		local Device = require 'framework.basic.Device'
		if Device.platform == "android" then
			item['pic_del_tou']:setETCAlphaEnable(true)
			item['pic_del_face']:setETCAlphaEnable(true)
			item['disEffect']:setETCAlphaEnable(true)
			item['effect']:setETCAlphaEnable(true)
		end

		item['pic_del']:setVisible(true)
		item['pic_delGray']:setVisible(false)
		
		-- local delegateNode = DelegateDrawNode:create()
		-- item['pic_del']:addChild(delegateNode)
		-- delegateNode:setDelegateNode(actionNode)

		if isTibu then
			item['label']:setString(Res.locString('Battle$charType1'))
		elseif isFriend then
			item['label']:setString(Res.locString('Battle$charType2'))
		elseif isGuildMember then
			item['label']:setString(Res.locString('Battle$charType3'))
		end

		-- local data = { point = 0 }

		assert(not self._playerMap[playerId])	
		self._playerMap[playerId] = { bloodView = bloodView, manaView = item, point = 0, basicId = basicId }

		--6 2*380
		--125
		local count = self._luaset['uiLayer_rb_heroArray']:getChildrenCount()
		local len = 2*380 - (6-count)*125
		local scaleX = len/2
		self._luaset['uiLayer_rb_bg_m']:setScaleX(scaleX)

		-- layout,dbPet,petid, isLeftMode
		item['starLayout']:setVisible(false)
		require 'PetNodeHelper'.updateStarLayout( item['starLayout'], nil, basicId, nil, false )


		if require 'ServerRecord'.getBossHelperBasicId() == basicId then
			local arrow = self:createLuaSet(self._document, '@arrow')

			item[1]:addChild( arrow[1] )
			
			item['arrow'] = arrow[1]
			item['arrow']:setVisible(false)
		end

	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_RoleDie, function ( data )
		-- body
		--[[
		EventCenter.eventInput(FightEvent.Pve_RoleDie , { 
			role = self, 
			isMonster = self:isMonster(),
			skill = skill,
			career = self:getCareer()
		})	
		--]]
		local playerId 	= data.role:getDyId()
		local item = self._playerMap[playerId]
		if item then
			item.manaView[1]:setColorf(1,1,1,0.5)

			item.manaView['pic_del']:setVisible(false)
			item.manaView['pic_delGray']:setVisible(true)
			-- item.manaView['pic_del_tou']:setGrayEnabled(true)
			-- item.manaView['pic_del_face']:setGrayEnabled(true);

			item.manaView['starLayout']:removeAllChildrenWithCleanup(true)
			require 'PetNodeHelper'.updateStarLayout( item.manaView['starLayout'], nil, item.basicId, nil, true )
		end

		-- 
	end, 'Fight')


	
	EventCenter.addEventFunc(FightEvent.Pve_SetMana, function ( data )
		-- body
		local playerId 	= data.playerId
		local mana 		= data.mana
		local maxPoint 	= data.maxPoint

		assert(playerId)
		assert(mana)
		assert(maxPoint)

		--setPic
		local item = self._playerMap[playerId]
		if item then
			local manaStep = require 'ManaManager'.ManaStep
			local percent = 100 * math.fmod(mana, manaStep)/manaStep
			local point  = math.floor(mana/manaStep)

			if point == maxPoint then
				percent = 100
			end

			local manaData = { playerId = playerId, percent = percent, point = point, maxPoint = maxPoint }
			item.bloodView:setManaData( manaData )

			if point > item.point then
				item.bloodView:triggerTwinkle()
			end

			if require 'ServerRecord'.isArenaMode() and point<maxPoint then
				item.manaView['effect']:setVisible(false)
				
				item.manaView[1]:setColorf(1,1,1,1)

				item.point = point
			else
				if point == 0 and item.point > 0 then
					--消失
					-- bt_explosive
					local color = Mana_Colors[item.point]
					
					require 'framework.helper.MusicHelper'.playEffect( require 'Res'.Sound.bt_explosive )
					item.manaView['disEffect']:setColorf(color[1], color[2], color[3], color[4])
					item.manaView['disEffect']:setLoops(1)
					item.manaView['disEffect']:start()
				end

				local color = Mana_Colors[point]

				if point >= 1 and item.manaView['arrow'] then
					if not item.manaView['arrow']:isVisible() then
						local arrowMotion = item.manaView['arrow']
						local life = 1000*2000*arrowMotion:getMotionSpeed()
			            arrowMotion:setVisible(true)
			            arrowMotion:setListener(function ()
			                arrowMotion:setVisible(false)
			            end)
			            arrowMotion:runAnimate(0, life, 'KeyStorage')

						-- item.manaView['arrow'] = nil
					end
				end

				if point == 1 then
					item.manaView['effect']:setColorf(color[1], color[2], color[3], color[4])
					item.manaView['effect']:setVisible(true)

					item.manaView[1]:setColorf(1,1,1,1)
				elseif point == 2 then
					item.manaView['effect']:setColorf(color[1], color[2], color[3], color[4])
					item.manaView['effect']:setVisible(true)

					item.manaView[1]:setColorf(1,1,1,1)
				elseif point == 3 then
					item.manaView['effect']:setColorf(color[1], color[2], color[3], color[4])
					item.manaView['effect']:setVisible(true)

					item.manaView[1]:setColorf(1,1,1,1)
				else
					item.manaView['effect']:setVisible(false)

					item.manaView[1]:setColorf(1,1,1,1)
				end

				item.point = point
			end

		end
	end, 'Fight')
end


--[[
ReleaseSkill ?
--]]

return ManaView