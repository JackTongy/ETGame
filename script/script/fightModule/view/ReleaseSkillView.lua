local EventCenter 			= require 'EventCenter'
local Broadcast 			= require 'framework.net.Broadcast'
local FightEvent 			= require 'FightEvent'
local Utils 				= require 'framework.helper.Utils'
local FightTimer 			= require 'FightTimer'
local RolePlayerManager 	= require 'RolePlayerManager'
local SkillChainManager 	= require 'SkillChainManager'
local RoleSelfManager 		= require 'RoleSelfManager'
local SkinManager 			= require 'SkinManager'
local ActionCameraFactory 	= require 'ActionCameraFactory'
local TimerHelper 			= require 'framework.sync.TimerHelper'
local FightSettings 		= require 'FightSettings'
local TimeOutManager 		= require "TimeOut"
local BallBarView 			= require 'BallBarView'
local Swf 					= require 'framework.swf.Swf'
local CfgHelper 			= require 'CfgHelper'
local StringViewHelper 		= require 'StringViewHelper'
local SelectHeroProxy 		= require 'SelectHeroProxy'
local MusicHelper 			= require 'framework.helper.MusicHelper'
local UIHelper 				= require 'UIHelper'
local LabelView 			= require 'LabelView'
local LabelUtils 			= require 'LabelUtils'
local Res 					= require 'Res'
local CartoonRate 			= 2/1.2

require "TimeOut"

local Default = require 'Default'
local alwaysSkill = Default.Debug and Default.Debug.release

local Career_Name = { '战士', '骑士', '远程', '治疗'}

local Job_Images = { [0]='hei.png', [1]='zhanshi.png', [2]='tanke.png', [3]='dps.png', [4]='zhiliao.png'}
local Small_Job_Images = {'zhanshi_small.png', 'tanke_small.png', 'dps_small.png', 'zhiliao_small.png'}
local Hei_Image = 'hei.png'

local Ball_N_Image = { [0] = NULL, [1] = 'ZD_JN_1.png', [2] = 'ZD_JN_2.png', [3] = 'ZD_JN_3.png',}

local Combo_N_Image = { [1] = 'ZD_1.png', [2] = 'ZD_2.png', [3] = 'ZD_3.png', [4] = 'ZD_4.png', }
local Combo_UP_Image = { [1] = 'ZD_bisha1.png', [2] = 'ZD_bisha2.png', [3] = 'ZD_bisha3.png', [4] = 'ZD_bisha5.png' }

local AlwaysSkill = Default.Debug and Default.Debug.release

--[[
*************************************************************************************************************************
--]]

--[[
static setting
--]]

local ReleaseSkillView = class( require 'BasicView' )

function ReleaseSkillView:ctor( luaset, document )
	-- body
	self._luaset 	= luaset
	self._document 	= document

	self:getReleaseSkillLuaSet()

	self:initEvents()
end

function ReleaseSkillView:playerId2Info( playerId )
	-- body
	local player = require 'RolePlayerManager'.getPlayer(playerId)
	if player then
		local roleDyVo = player.roleDyVo
		local info = {}
		info.dyId 				= roleDyVo.dyId
		info.skillId 			= roleDyVo.skill_id
		info.career 			= roleDyVo.bigCategory
		info.playerId 			= roleDyVo.playerId
		info.player 			= player 

		info.duanWei 			= require 'ServerController'.getManaPointByDyId(playerId)
		assert(info.duanWei)

		local charactorBasicVo 	= CfgHelper.getCache('charactorConfig', 'id', roleDyVo.basicId)
		info.career 			= charactorBasicVo.atk_method_system
		info.charactorId 		= roleDyVo.basicId

		local skillVo 			= CfgHelper.getCache('skill', 'id', math.abs(info.skillId))
		assert(skillVo)
		info.skillName 			= skillVo.name
		info.point 				= skillVo.point

		return info
	end
end

--[[
local info = {}
info.dyId 		= roleDyVo.dyId
info.skillId 	= roleDyVo.skill_id
info.career 	= roleDyVo.bigCategory
info.playerId 	= roleDyVo.playerId

info.player = player 

local charactorBasicVo = CfgHelper.getCache('charactorConfig', 'id', roleDyVo.basicId)
info.career 	= charactorBasicVo.atk_method_system
info.charactorId = roleDyVo.basicId

local skillVo 	= CfgHelper.getCache('skill', 'id', math.abs(info.skillId))
assert(skillVo)

info.skillName 	= skillVo.name
info.point 		= skillVo.point
--]]
function ReleaseSkillView:initEvents()
	-- body
	EventCenter.addEventFunc(FightEvent.Pve_TriggerBigSkill, function ( data )
		-- body
		local playerId = data.playerId
		assert(playerId)

		-- 判断mana是否足够
		local ServerController = require 'ServerController'
		local serverRole = ServerController.findRoleByDyIdAnyway(playerId)

		if serverRole and not serverRole:isDisposed() then

			local manaStep = require 'ManaManager'.ManaStep
			local mana = serverRole:getMana()
			-- manaStep = 0

			if mana >= manaStep or AlwaysSkill or serverRole:isMonster() then
				local player = require 'RolePlayerManager'.getPlayer(playerId)
				if player then
					EventCenter.eventInput( FightEvent.Pve_SubMana, { playerId = playerId } )

					local info = self:playerId2Info(playerId)
					if info then
						if info.player and info.player:isOwnerTeam() then
							self:setSkillLocked()
							self:setTouchable(true)
							self:showSkill(info)
						end
						EventCenter.eventInput(FightEvent.ReleaseSkill, { skillId=info.skillId, dyId=info.playerId } )
					end
				end
				
			end
		end
	end, 'Fight')


	EventCenter.addEventFunc(FightEvent.Pve_TriggerBigSkill_Btn, function ( data )
		-- body

		-- isSkillActionLocked
		assert(data)
		local playerId = data.playerId
		assert(playerId)
		local player = require 'RolePlayerManager'.getPlayer(playerId)

		if player then
			if self:isSkillLocked() or player:isSkillActionLocked() 
				-- or (not player:canMove()) 
				then
				UIHelper.toast2(Res.locString('Battle$SkillInCD'))
			else
				if not player:canMove() then
					self:addBrokenLabel( player )
				end
				
				EventCenter.eventInput(FightEvent.Pve_TriggerBigSkill, data)
			end
		end
		
	end, 'Fight')

end


function ReleaseSkillView:runCamera( dx, dy, callback )
	-- body
	--[[
	action 时间 40帧, 20fps
	--]]

	local action = ActionCameraFactory.createAction( dx, dy, CartoonRate )

	if callback then
		action:setListener(callback)
	end

	self._luaset['layer']:runElfAction( action )

	-- self._luaset['layer_bgLayer']:runAction( action:clone() )
	-- self._luaset['layer_bgSkillLayer']:runAction(makeAction())
	-- self._luaset['layer_touchLayer']:runAction(makeAction())
	-- self._luaset['layer_roleLayer']:runAction(makeAction())
	-- self._luaset['layer_touchLayerAbove']:runAction(makeAction())
	-- self._luaset['layer_skyLayer']:runAction(makeAction())
	-- self._luaset['layer_specialLayer']:runAction(makeAction())
	-- self._luaset['layer_fightTextLayer']:runAction(makeAction())
end

function ReleaseSkillView:addBrokenLabel( player )
	-- body
	if player then
		local view = LabelView.createLabelView( LabelUtils.Label_Broken )
		if view then
			local node = player:getRootNode()
			local labelNode = view:getRootNode()
			if labelNode then
				player:addLabel( labelNode )
			end
		end
	end
end

function ReleaseSkillView:showSkill( info )
	-- body
	-- local info = SelectHeroProxy.getSelectPlayerInfo()
	-- assert(info)

	assert(info)

	if info then

		if not require 'ServerRecord'.isArenaMode() then
			FightSettings.pause()
		end

		local blackNode = self._luaset['layer_bgLayer_black']
		blackNode:runElfAction(self._luaset['ActionBlackInOut']:clone())

		local maxScale = 1.7
		local delayTime = 1.5 

		local winSize = {
			width = require 'Global'.getWidth(),
			height = require 'Global'.getHeight(),
		}
		
		local targetCenter = { x=836-1136/2, y=230 - 640/2 }
		-- local targetCenter = { x=0, y=0 }

		local node = info.player:getRootNode()
		local playerPosition = NodeHelper:getPositionInScreen( node )
		local center = { x=winSize.width/2, y=winSize.height/2}

		local offsetScale1 = maxScale
		local offset1 = { x= -offsetScale1*(playerPosition.x-center.x), y =-offsetScale1*(playerPosition.y-center.y) }

		offset1.x = offset1.x + targetCenter.x
		offset1.y = offset1.y + targetCenter.y

		-- 2s
		self:runCamera( offset1.x, offset1.y)

		TimerHelper.tick(function ()
			-- body
			self:unLockSkill()
			return true
		end, 2.5 / CartoonRate )

		local root = self._releaseSkillLuaSet[1]
		
		self._releaseSkillLuaSet['root_pic_image_#label']:setString( info.skillName ) 

		self._releaseSkillLuaSet['root_#shield']:setVisible(true)

		local labelwidth = self._releaseSkillLuaSet['root_pic_image_#label']:getWidth()
		self._releaseSkillLuaSet['root_pic_image_label_dw']:setPosition(ccp( -labelwidth/2 - 60, 0))

		local dwlables = { [0]=Res.locString('Battle$grade1'), [1]=Res.locString('Battle$grade1'), [2]=Res.locString('Battle$grade2'), [3]=Res.locString('Battle$grade3')}
		info.duanWei = info.duanWei
		self._releaseSkillLuaSet['root_pic_image_label_dw_label']:setString( tostring(dwlables[info.duanWei]) )

		root:setListener(function ()
			-- body
		end)

		if require 'MusicSettings'.getBattleVoiceEnabled() then
			TimerHelper.tick(function ()
				-- body
				local voice = CfgHelper.getCache('charactorConfig', 'id', info.charactorId, 'voice')  
				if voice then
					-- 去掉引导声音
					EventCenter.eventInput('Guider_Pve_StopSound')

					require 'framework.helper.MusicHelper'.playEffect('raw/role_voice/'..voice)
				else
					-- assert(false, info.charactorId)
				end
				return true
			end, 0)
		end

		--1.5
		TimerHelper.tick(function ( ... )
			-- body
			if not require 'ServerRecord'.isArenaMode() then
				FightSettings.resume() 
			end
			
			return true
		end, delayTime / CartoonRate )	

		TimerHelper.tick(function ( ... )
			-- body
			root:setVisible(true)
			root:runAnimate(0, 2000,'#KeyStorage_show')
			return true
		end, 0.3 / CartoonRate )
		

		local big2 = SkinManager.getRoleBigIcon2ByCharactorId(info.charactorId)
		local offsetVo = CfgHelper.getCache('BattleCharactor', 'id', info.charactorId)

		-- info_scale

		-- assert()

		local resNodeArray = {
			[1] = self._releaseSkillLuaSet['root_pic_image2_pic'],
			[2] = self._releaseSkillLuaSet['root_pic_image1_pic'],
			[3] = self._releaseSkillLuaSet['root_pic_image0_pic'],
			[4] = self._releaseSkillLuaSet['root_pic_image_pic'],
		}

		if offsetVo then
			local Global = require 'Global'

			-- stay pos

			local offsetX = -(-72.15) - ( Global.getWidth()/2 - offsetVo.battle_x )
			local offsetY = -(-9.75)  + ( Global.getHeight()/2 - offsetVo.battle_y )

			-- self._releaseSkillLuaSet['root_#pic']:setPosition(ccp(offsetX, offsetY))

			for i,node in ipairs(resNodeArray) do
				node:setPosition(ccp(offsetX, offsetY))
			end
			-- self._releaseSkillLuaSet['root_#pic']:setScaleX(offsetVo.battle_scale)
			-- self._releaseSkillLuaSet['root_#pic']:setScaleY(math.abs(offsetVo.battle_scale))
		end

		for i,node in ipairs(resNodeArray) do
			node:setResid(big2[1])
			
			node:setScaleX(offsetVo.battle_scale)
			node:setScaleY(math.abs(offsetVo.battle_scale))
		end

		local nodeMap = {
			[1] = self._releaseSkillLuaSet['root_pic_image2'],
			[2] = self._releaseSkillLuaSet['root_pic_image1'],
			[3] = self._releaseSkillLuaSet['root_pic_image0'],
			[4] = self._releaseSkillLuaSet['root_pic_image'],
		} 

		for i,node in ipairs(nodeMap) do
			node:setVisible(false)
		end

		local mySwf = Swf.new('Swf_DaZhao', nodeMap)
		mySwf:play()

		local length = SkillChainManager.getChainLength( info.playerId )
		if length <= 1 then
			self._releaseSkillLuaSet['root_pic_image_combo']:setVisible(false)
		else
			self._releaseSkillLuaSet['root_pic_image_combo']:setVisible(true)
			self._releaseSkillLuaSet['root_pic_image_combo']:setVisible(false)

			length = length - 1
			length = math.min(length, 4)

			self._releaseSkillLuaSet['root_pic_image_combo_llayout1_num']:setResid( Combo_UP_Image[length] )
			self._releaseSkillLuaSet['root_pic_image_combo_llayout2_num']:setResid( Combo_N_Image[length] )
		end

	else

		print('------------------------------------')
		print('showSkill error:')
		print(data)

		print('already have '..self:getBallNumByType(data.career))
		print('------------------------------------')

	end

end

function ReleaseSkillView:setSkillLocked()
	-- body
	self._skillLocked = true
end

function ReleaseSkillView:unLockSkill()
	-- body
	self._skillLocked = false
end

function ReleaseSkillView:isSkillLocked()
	-- body
	return self._skillLocked
end

function ReleaseSkillView:setTouchable( enable )
	-- body
	NodeHelper:setTouchable(self._luaset['layer'], enable)
	NodeHelper:setTouchable(self._luaset['uiLayer'], enable)
end

function ReleaseSkillView:getReleaseSkillLuaSet()
	-- body
	if not self._releaseSkillLuaSet then
		self._releaseSkillLuaSet = self:createLuaSet(self._document, '@ReleaseSkill')
		-- self._releaseSkillLuaSet[1]:setProgress(1999)
		self._releaseSkillLuaSet[1]:setVisible(false)
		self._releaseSkillLuaSet[1]:setPauseMotion(true)
		-- self._releaseSkillLuaSet[1]:runAnimate(0, 2000,'#KeyStorage_show')
		
		local nodeMap = {
			[1] = self._releaseSkillLuaSet['root_pic_image2'],
			[2] = self._releaseSkillLuaSet['root_pic_image1'],
			[3] = self._releaseSkillLuaSet['root_pic_image0'],
			[4] = self._releaseSkillLuaSet['root_pic_image'],
		} 

		local winWidth = require 'Global'.getWidth()
		-- local px, py = self._releaseSkillLuaSet['root_downBar_#']:getPosition()
		-- self._releaseSkillLuaSet['root_downBar_#']:setPosition(ccp( px-(winWidth-1136)/2 , py))
		
		for i,node in ipairs(nodeMap) do
			-- node:setResid(big2[1])
			node:setVisible(false)
			-- 最后一帧
			node:setPosition(ccp(-706.45, -3.90))
			node:setColorf(1,1,1,0)
		end

		self._luaset['uiLayer_labels']:addChild( self._releaseSkillLuaSet[1], 100 )

		if RoleSelfManager.isPvp then
			local node = self._releaseSkillLuaSet['slot_#line']
			if node and not tolua.isnull(node) then
				node:setVisible(false)
				node:removeFromParent()
			end
		end
	end

	return self._releaseSkillLuaSet
end


return ReleaseSkillView