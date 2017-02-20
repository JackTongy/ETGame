local EventCenter 			= require 'EventCenter'
local FightEvent 			= require 'FightEvent'
local Res 					= require 'Res'
local FightTimer 			= require 'FightTimer'
local FightConfig			= require 'FightConfig'
local FightSettings 		= require 'FightSettings'
local UIHelper 				= require 'UIHelper'
local Res 					= require 'Res'

local JJCUIView = class(require 'BasicView')

local Career_Bgs = {
	[1] = 'XT_zhiye_1.png',
	[2] = 'XT_zhiye_2.png',
	[3] = 'XT_zhiye_3.png',
	[4] = 'XT_zhiye_4.png',
}

local Career_Kuangs = {
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



--[[
	createItemBy
--]]



local Bar_Images = {
	[1] = { 'JJC_zhanshi1.png', 'JJC_zhanshi2.png' },
	[2] = { 'JJC_tanke1.png', 	'JJC_tanke2.png' },
	[3] = { 'JJC_dps1.png', 	'JJC_dps2.png' },
	[4] = { 'JJC_zhiliao1.png', 'JJC_zhiliao2.png' },
} 

local Career_Images = {
	[0] = 'hei.png',
	[1] = 'zhanshi.png',
	[2] = 'tanke.png',
	[3] = 'dps.png',
	[4] = 'zhiliao.png',
} 

function JJCUIView:ctor( luaset, document )
	-- body
	self._luaset 	= luaset
	self._document 	= document

	self:initUI()

	self:addEvents()

	self:startHandler()
end

function JJCUIView:initUI()
	-- body
	---关闭原先的UI
	self._luaset['uiLayer_#lt']:setVisible(false)
	self._luaset['uiLayer_#rt']:setVisible(false)
	self._luaset['uiLayer_#rb2']:setVisible(false)
	self._luaset['uiLayer_#rb']:setVisible(false)
	self._luaset['layer_touchLayer']:setVisible(false)

	self._jjcluaset = self:createLuaSet(self._document, '@JJCUiLayer')
	self._luaset['uiLayer']:addChild(self._jjcluaset[1])

	if FightConfig.Accelerate then
		self._jjcluaset['jjcTop_btnAcce']:setStateSelected(true)
		FightSettings.setAccelerate(true)
	else
		self._jjcluaset['jjcTop_btnAcce']:setStateSelected(false)
		FightSettings.setAccelerate(false)
	end

	self._jjcluaset['jjcTop_btnAcce']:setListener(function (  )
		-- body
		local enabled = self._jjcluaset['jjcTop_btnAcce']:getStateSelected()
		FightSettings.setAccelerate(enabled)
		FightConfig.Accelerate = enabled
		FightConfig.save()
	end)

	self._jjcluaset['jjcTop_btnAuto']:setListener(function ()
		-- body
		UIHelper.toast2(Res.locString('CArena$AItips'))--('在竞技场中,自动AI默认开启!')
	end)

	---player Id -> luaset
	self._heroViewMap = {}
	self._heroDataMap = {}

end

function JJCUIView:addEvents()
	-- body
	local heroItemCount = 0
	EventCenter.addEventFunc(FightEvent.JJC_Create_HeroItem, function ( serverRole )
		-- body
		local playerId = serverRole.dyId
		assert(not self._heroViewMap[playerId])

		local petId = serverRole.charactorId

		local heroluaset = self:createLuaSet(self._document, '@heroItem')
		self._jjcluaset['jjcBottom_heroArray']:addChild(heroluaset[1])

		self._heroViewMap[playerId] = heroluaset
		local data = {}
		self._heroDataMap[playerId] = data
		data.mana = 0
		data.point = 0

		data.role = serverRole

		local petInfo = {}
		petInfo.AwakeIndex = serverRole.awaken

		local pic = Res.getPetIcon( petId )
		local picbg = Res.getPetIconBg( petInfo )
		local picKuang = Res.getPetIconFrame( petInfo )

		heroluaset['pic']:setResid(pic)
		heroluaset['bg']:setResid(picbg)
		heroluaset['kuang']:setResid(picKuang)

		--bar
		local career = serverRole:getCareer()
		data.career = career

		heroluaset['bar']:setResid(Bar_Images[career][1])
		heroluaset['progress']:setResid(Bar_Images[career][2])

		---几颗能量球
		data.pointMax = serverRole.point or 0

		for i=1, data.pointMax do
			local elfnode = ElfNode:create()
			elfnode:setResid( Career_Images[0] )

			heroluaset['layout']:addChild(elfnode)
			heroluaset['layout_ball'..i] = elfnode
		end

		heroluaset['die']:setVisible(false)
		heroluaset['tb']:setVisible(false)

		heroItemCount = heroItemCount + 1
		if heroItemCount > 5 then
			heroluaset['tb']:setVisible(true)
		end
	end, 'Fight')

end


function JJCUIView:startHandler()
	-- body
	assert(not self._handler)

	self._handler = FightTimer.addFunc(function ( dt )
		-- body
		if tolua.isnull(self._luaset['layer']) then
			return true
		end

		for i, luaset in pairs(self._heroViewMap) do
			local data = self._heroDataMap[i]

			if luaset and data then
				if data.role:isDisposed() then
					
					luaset['pic']:setColorf(1,1,1,0.5)
					luaset['die']:setVisible(true)

					luaset['progress']:setPercentageInTime(0,0)
					for ii=1, data.pointMax do
						local resid = Career_Images[data.career] 
						luaset['layout_ball'..ii]:setResid(resid)
						luaset['layout_ball'..ii]:setColorf(1,1,1,0.5)
					end

					self._heroViewMap[i] = false
					self._heroDataMap[i] = false
				else
					if data.mana ~= data.role.mana then
						
						local percent = 100 * (math.fmod(data.role.mana, 400)/400)
						--同一个区间??
						if math.floor(data.mana/400) ~= math.floor(data.role.mana/400) then
							if percent > 0 and percent < 100 then
								percent = percent + 100
							end
						end

						luaset['progress']:setPercentageInTime(percent, 0.2)

						data.point = math.floor( (data.role.mana+1) /400)

						for ii=1, data.pointMax do
							local resid
							if ii <= data.point then
								resid = Career_Images[data.career] 
							else
								resid = Career_Images[0]
							end

							assert(resid)

							luaset['layout_ball'..ii]:setResid(resid)
						end

						data.mana = data.role.mana
					end
				end
			end
		end
	end)
end



return JJCUIView