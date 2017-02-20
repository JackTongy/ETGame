
local HeroPlayer 		= require 'HeroPlayer'
local OtherPlayer 		= require 'OtherPlayer'
local MonsterPlayer 	= require 'MonsterPlayer'
local SpeedMonster 		= require 'SpeedMonster'
local AirLandMonster 	= require 'AirLandMonster'
local InvisibleMonster 	= require 'InvisibleMonster'
local CopyMonster 		= require 'CopyMonster'
local BloodMonster 		= require 'BloodMonster'
local GrowMonster 		= require 'GrowMonster'
local DanceMonster      = require 'DanceMonster'
local ForwardMonster 	= require 'ForwardMonster'
local ThiefMonster 		= require 'ThiefMonster'
local CMBSMonster       = require 'CMBSMonster'
local ExplodeMonster    = require 'ExplodeMonster'
---竞技场
local OtherAIPlayer     = require 'OtherAIPlayer'
local SelfAIPlayer      = require 'SelfAIPlayer'
local YFMath 			= require 'YFMath'
local TypeRole 			= require 'TypeRole'
local RolePlayerManager = require 'RolePlayerManager'
local FightView 		= require 'FightView'
local LayerManager 		= require 'LayerManager'
local ActionUtil 		= require 'ActionUtil'
local DirectionUtil 	= require 'DirectionUtil'
local FightTimer 		= require 'FightTimer'
local BuffBasicManager 	= require 'BuffBasicManager'
local SkillUtil 		= require 'SkillUtil'
local UpdateRate 		= require 'UpdateRate'
local EventCenter 		= require 'EventCenter'
local SelectPlayerProxy = require 'SelectPlayerProxy'
local YFMath 			= require 'YFMath'
local FightEvent 		= require 'FightEvent'
local RoleSelfManager 	= require 'RoleSelfManager'
local SkillBasicManager = require "SkillBasicManager"
local LabelView 		= require 'LabelView'
local LabelUtils 		= require 'LabelUtils'
local AIType 			= require 'AIType'
local Global 			= require 'Global'
local CfgHelper 		= require 'CfgHelper'

local SceneRolesView=class()

function SceneRolesView:ctor(  )	
	self._playerDict 		= {}
	self._prePlayerDict 	= {}
	self._preTime 			= 0
end

function SceneRolesView:start()
	-- body
	if self._updateHandle then
		FightTimer.cancel(self._updateHandle)
		self._updateHandle = nil
	end

	self._updateHandle = FightTimer.tick(function (dt)
		local now = require 'FightTimer'.currentFightTimeMillis()
		if now - self._preTime >= 150 then
			self:arrangeDepth()
			self._preTime = now
		end
	end,0)

	self:addEvents()
end

-- 添加事件
function SceneRolesView:addEvents(  )

	--主动触发能量球技能
	EventCenter.addEventFunc( FightEvent.ReleaseSkill,function( data )

		require 'SkillChainManager'.actionSkill( data.dyId )

		local skillId 	= data.skillId
		local playerId 	= data.dyId
		local player 	= self._playerDict[playerId]
		
		if player then
			player:startToBigSkill()
		else
			print('error: SceneRolesView:addEvents, no player')
		end
	end , 'Fight')
	
	--- pve  子弹创建侦听
	EventCenter.addEventFunc(FightEvent.Pve_CreateBullet,function ( data )
		local skillBasicVo = data.skillBasicVo
		local player = data.player
		local isCrit = data.isCrit
		self:createBullet(skillBasicVo,player, isCrit)
		-- body
	end,'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_ShowWuDi, function ( data )
		-- body
		assert(data)
		assert(data.playerId)

		local player 	= self._playerDict[data.playerId]
		
		-- assert(player)

		if player then
			FightView.showWuDiLabel( player )
		end

	end, 'Fight')

end

--创建飞行道具 pve  使用
function SceneRolesView:createBullet( skillBasicVo,player, isCrit )
	-- body
	return require 'NewFlyTool'.createFlyTool(player, skillBasicVo.id, isCrit)
end

--返回使用该技能影响的玩家列表
-- function SceneRolesView:getPlayerbySkill(playerId,skillId)
-- 	return RolePlayerManager.getPlayerbySkill(playerId,skillId)
-- end

--[[
pve, 加入己方英雄
--]]
function SceneRolesView:addRole( roleDyVo  )
	local  player = self:createRole(roleDyVo)
	return player
end

function SceneRolesView:createMonster( roleDyVo )
	-- body 
	local args = {}
	args.charactorId = roleDyVo.basicId
	--[[
		isBoss
		charactorId
		bloodType
	--]]
	args.aiType 	= roleDyVo.aiType
	args.isMonster 	= true
	args.isBoss 	= roleDyVo.isBoss
	args.bloodType 	= (args.isBoss and TypeRole.BloodType_Boss) or TypeRole.BloodType_Monster

	local player = require 'MonsterFactory'.createMonster(args)
	player:initRoleDyVo(roleDyVo)
	
	player:initSelectBox()

	local charVo = CfgHelper.getCache('charactorConfig', 'id', roleDyVo.basicId)
	local charName = tostring(roleDyVo.playerId)..':'..tostring(charVo.atk_method_system).."."..charVo.id
	player:setName( charName )
	player:setTempPos( roleDyVo.birthPos )

	player:onEntry()
	
	return player
end

function SceneRolesView:addMonster( player )
	-- body
	self._playerDict[player.roleDyVo.playerId] = player
	RolePlayerManager.addPlayer(player)
	self:addToLayer(player)
end


--设置玩家的坐标
function SceneRolesView:updatePlayerPos( playerId,pos )
	local player=self._playerDict[playerId]
	if player then
		player:setPosition(pos.x,pos.y)
		return true
	end
	return false
end

function SceneRolesView:getPlayer( playerId )
	return self._playerDict[playerId]
end

function SceneRolesView:getPlayerAnyway( playerId )
	-- body
	return self._playerDict[playerId] 
end


-- add to player  layer 
function SceneRolesView:addToLayer(player)
	local rootnode = player:getRootNode()

	if rootnode and (not tolua.isnull(rootnode)) and LayerManager.roleLayer and (not tolua.isnull(LayerManager.roleLayer)) then
		local parent = rootnode:getParent()

		if parent==nil or parent ~= LayerManager.roleLayer then
			LayerManager.roleLayer:addChild(player:getRootNode())
		else
			error('addToLayer error......')
		end
	end
end
-- remove player from  role Layer
function SceneRolesView:removeLayer( player )
	-- local parent = player:getRootNode():getParent()
	-- if parent~=nil and parent==LayerManager.roleLayer then
	-- 	LayerManager.roleLayer:removeChild(player:getRootNode(),true)
	-- end
	-- 
	-- player:getRootNode():removeFromParent()
end

function SceneRolesView:deleteRole( player )
	RolePlayerManager.removePlayer(player)
	self._playerDict[player.roleDyVo.playerId] = nil
	-- self._deadDict[player.roleDyVo.playerId] = player
	self:removeLayer(player)
	player:dispose()
end

-- playerId
-- function SceneRolesView:updateMoveTo(playerdId,targetPos,curentPos )
-- 	local player =self._playerDict[playerId]
-- 	if player ~=nil then
-- 		-- check currentPos  
-- 		local distance=YFMath.distance(player:getMapX(),player:getMapY(),curentPos.x,curentPos.y)
-- 		if distance>=checkRolePosLen then	-- pullrole to the postion
-- 			player:setPosition(curentPos.x,curentPos.y)
-- 		end
-- 		player:moveTo(targetPos.x,targetPos.y) --移动到目标位置
-- 	end
-- end

--一般情况下dir ＝＝－1  只有才回归站位的移动才具有方向性
-- changeDir是移动的时候是否调整方向 一般默认情况下需要调整方向 ，但是当人物做战斗微调的时候是不需要调整移动方向
function SceneRolesView:updateMoveToByNet(playerId,curentPos,destPoint,serveTime,dir,changeDir)
	local player =	self._playerDict[playerId]

	if player then
		if player.roleDyVo.dyId ~= RoleSelfManager.dyId then

			-- local playerPos = player:getPosition()
			-- DirectionUtil.getDireciton(playerPos.x, destPoint.x)

			player:moveToPosByNet(curentPos,destPoint,serveTime,function(  )

				player:play(ActionUtil.Action_Stand,dir,true)
			end,changeDir)
		end
	end
end

---替补上场走到目标点
function SceneRolesView:updateMoveToPos(playerId,currPos,destPoint,dir,complete )
	local player =	self._playerDict[playerId]

	if player then
		local playerPos = player:getPosition()

		-- DirectionUtil.getDireciton(playerPos.x, destPoint.x)

		player:moveToPosByNet(currPos,destPoint,nil,function(  )
			player:play(ActionUtil.Action_Stand,dir,true)
			if complete then
				complete()
			end
		end)
	end
end

function SceneRolesView:updateFight(fightUIVo)
	FightView.updateFight(fightUIVo)
end

function SceneRolesView:preCreateRoleCloth( roleDyVo )
	local bloodType

	local args = {}
	args.charactorId = roleDyVo.basicId

	if roleDyVo.bigCategory == TypeRole.BigCategory_Role then
		if roleDyVo.dyId == RoleSelfManager.dyId then	--自己的玩家 
			if roleDyVo.isFriend then
				args.bloodType = TypeRole.BloodType_Friend
			else
				args.bloodType = TypeRole.BloodType_Hero
			end
		else --对方玩家
			if roleDyVo.ai then
				args.bloodType = TypeRole.BloodType_Monster
			else
				args.bloodType = TypeRole.BloodType_NotFriend
			end
		end		
	elseif roleDyVo.bigCategory == TypeRole.BigCategory_Monster then --怪物 
		args.isMonster = true
		args.isBoss = roleDyVo.isBoss
		if args.isBoss then
			args.bloodType = TypeRole.BloodType_Boss
		else
			args.bloodType = TypeRole.BloodType_Monster
		end
	end	

	local cloth = require 'RoleView'.getPureViewCacheByArgs( args )

	cloth:getActionNode():setTransitionMills(0)
	cloth:getActionNode():play(ActionUtil.Action_NoramlStand)
	cloth:getActionNode():update(0)

	return cloth
end

function SceneRolesView:preCreateRole( roleDyVo )
	-- body
	if self._prePlayerDict[roleDyVo.playerId] then
		return self._prePlayerDict[roleDyVo.playerId]
	end

	local player   
	local backStandDir 
	local bloodType

	local args = {}
	args.charactorId = roleDyVo.basicId
	--[[
		isBoss
		charactorId
		bloodType
	--]]
	if roleDyVo.bigCategory == TypeRole.BigCategory_Role then
		if roleDyVo.dyId == RoleSelfManager.dyId then	--自己的玩家 

			if roleDyVo.isFriend then
				args.bloodType = TypeRole.BloodType_Friend
			else
				args.bloodType = TypeRole.BloodType_Hero
			end

			if roleDyVo.ai then
				player = SelfAIPlayer.new(args) 
			else
				player = HeroPlayer.new(args) 
			end
			player:initRoleDyVo(roleDyVo)	
			
		else --对方玩家
			if roleDyVo.ai then
				args.bloodType = TypeRole.BloodType_Monster
				args.isMonster = true
				player = OtherAIPlayer.new(args)
			else
				args.bloodType = TypeRole.BloodType_NotFriend
				player = OtherPlayer.new(args)
			end
			player:initRoleDyVo(roleDyVo)
		end		
	elseif roleDyVo.bigCategory == TypeRole.BigCategory_Monster then --怪物 
		args.isMonster = true
		args.isBoss = roleDyVo.isBoss
		----AIType
		-- args.isBoss = true
		if args.isBoss then
			args.bloodType = TypeRole.BloodType_Boss
		else
			args.bloodType = TypeRole.BloodType_Monster
		end

		player = MonsterPlayer.new(args)
		player:initRoleDyVo(roleDyVo)
	end	

	player:play(ActionUtil.Action_Stand)
	self._prePlayerDict[ roleDyVo.playerId ] = player

	return player
end

function SceneRolesView:createRole( roleDyVo ) 
	assert(roleDyVo)

	local player = self:preCreateRole( roleDyVo )
	assert(player)

	player:initSelectBox()

	local backStandDir 

	local args = {}
	args.charactorId = roleDyVo.basicId
	--[[
		isBoss
		charactorId
		bloodType
	--]]
	if roleDyVo.bigCategory == TypeRole.BigCategory_Role then
		if roleDyVo.dyId == RoleSelfManager.dyId then	--自己的玩家 

			backStandDir = RoleSelfManager.getHeroBackStandDir()
			
		else --对方玩家
			backStandDir = RoleSelfManager.getOtherRoleBackStandDir()
			
		end		
	elseif roleDyVo.bigCategory == TypeRole.BigCategory_Monster then --怪物 
		backStandDir = RoleSelfManager.getOtherRoleBackStandDir()
	end	

	self._playerDict[player.roleDyVo.playerId] = player
	RolePlayerManager.addPlayer(player)

	local charVo = CfgHelper.getCache('charactorConfig', 'id', roleDyVo.basicId)
	local charName = tostring(roleDyVo.playerId)..':'..tostring(charVo.atk_method_system).."."..charVo.id

	player:setName( charName )
	player:updateBloodPercent( player.roleDyVo.hpPercent, nil )
	player:play(ActionUtil.Action_Stand, backStandDir, true, nil, true)
	self:addToLayer(player)

	return player
end
-- set zorder 
function SceneRolesView:arrangeDepth( )

	if LayerManager.roleLayer then
		local ccarray = LayerManager.roleLayer:getChildren()

		if ccarray then
			local count = ccarray:count()
			for i=1,count do
				local node = tolua.cast( ccarray:objectAtIndex(i-1), 'CCNode')
				LayerManager.roleLayer:reorderChild( node, - node:getPositionY() )
			end
		end
	end
end

function SceneRolesView:calcUAtkDelayBySkillIdAndCrit( skillId, crit )
	-- body
	-- if skillId then
	-- 	local skillBasicVo = require 'CfgHelper'.getCache('skill', 'id', skillId)
	-- 	if crit then
	-- 		return skillBasicVo.red_time[2]
	-- 	else
	-- 		return skillBasicVo.red_time[1]
	-- 	end	
	-- end
	-- assert(false)
	return 0
end

--[[
免疫Buff的效果
--]]

-- LabelUtils.Label_BaoJi 		= '@BaoJiWenZi'
-- LabelUtils.Label_DongJie 	= '@DongJieWenZi'
-- LabelUtils.Label_HuanShu 	= '@HuanSuWenZi'
-- LabelUtils.Label_HunMi 		= '@HunMiWenZi'
-- LabelUtils.Label_MianYi 		= '@MianYiWenZi'
-- LabelUtils.Label_ZhiMang 	= '@ZhiMangWenZi'
-- LabelUtils.Label_ZhongDu 	= '@ZhongDuWenZi'

function SceneRolesView:justAddBuff(buffId,playerId,hp,hpPercent,speed ,skillId,crit, triggerFlag )
	print('just buffId---')
	print(buffId)

	print("skillUil==")
	print(SkillUtil.BuffType_GuangChuang)

	local player = self._playerDict[playerId]

	local mydelay = self:calcUAtkDelayBySkillIdAndCrit(skillId,crit)
	player:runWithDelay(function ()
		-- body
		if not triggerFlag then
			-- assert(false)

			local view = LabelView.createLabelView( LabelUtils.Label_MianYi )
			if view then
				local labelNode = view:getRootNode()
				if labelNode then
					player:addLabel( labelNode )
				else
				end
			else
				
			end

			player:addUpBuff(buffId, -1)
		end
	end, mydelay)
end


--添加buff   
-- buff有持续性的buff 可状态的buff

--如果有skillId 真要计算延迟时间
function SceneRolesView:addBuff(buffId,playerId,hp,hpPercent,speed ,skillId,crit, triggerFlag )
	-- print('buffId---')
	-- print(buffId)
	-- print("playerId=="..playerId)
	-- print("skillUil==")
	-- print(SkillUtil.BuffType_GuangChuang)

	print('SceneRolesView 处理增加Buff '..buffId..' ,player '..tostring(playerId)..' ,skill='..tostring(skillId))

	-- if self._justCalled then
	-- 	return
	-- end
	-- self._justCalled = true
	-- if 

	local player = self._playerDict[playerId]

	if player then
		if hpPercent then
			-- print("hp发生改变"..hpPercent)
			player.roleDyVo.hpPercent=hpPercent

			if hpPercent <= 0 then
				-- self:deleteRole(player)
				player:playDead(nil, 0, function ()
					self:deleteRole(player) 	--人物死亡 删除角色  
				end)
				player:updateBloodBar()
			end
		end

		if hp then
			print('冒血啊。。。。')
		end

		if speed then
			player.roleDyVo.speed=speed/UpdateRate.getOriginRate()
			print('添加了speed'..player.roleDyVo.speed)
		end

		-- LabelUtils.Label_BaoJi 		= '@BaoJiWenZi'
		-- LabelUtils.Label_DongJie 	= '@DongJieWenZi'
		-- LabelUtils.Label_HuanShu 	= '@HuanSuWenZi'
		-- LabelUtils.Label_HunMi 		= '@HunMiWenZi'
		-- LabelUtils.Label_MianYi 	= '@MianYiWenZi'
		-- LabelUtils.Label_ZhiMang 	= '@ZhiMangWenZi'
		-- LabelUtils.Label_ZhongDu 	= '@ZhongDuWenZi'

		local buffBasicVo = BuffBasicManager.getBuffBasicVo(buffId)
		
		if BuffBasicManager.isFreeze(buffId) then
			player.roleDyVo.isFreeze = true

			if Global.Battle_Use_View then
				local view = LabelView.createLabelView( LabelUtils.Label_DongJie )
				if view then
					local labelNode = view:getRootNode()
					if labelNode then
						player:addLabel( labelNode )
					end
				end
			end
		end

		if BuffBasicManager.isComa(buffId) then
			player.roleDyVo.isComa = true

			if Global.Battle_Use_View then
				local view = LabelView.createLabelView( LabelUtils.Label_HunMi )
				if view then
					local labelNode = view:getRootNode()
					if labelNode then
						player:addLabel( labelNode )
					end
				end
			end
		end

		if BuffBasicManager.isBlind(buffId) then
			player.roleDyVo.isBlind = true

			if Global.Battle_Use_View then
				local view = LabelView.createLabelView( LabelUtils.Label_ZhiMang )
				if view then
					local labelNode = view:getRootNode()
					if labelNode then
						player:addLabel( labelNode )
					end
				end
			end
		end
		
		if BuffBasicManager.isPoison(buffId) then

			if Global.Battle_Use_View then
				local view = LabelView.createLabelView( LabelUtils.Label_ZhongDu )
				if view then
					local labelNode = view:getRootNode()
					if labelNode then
						player:addLabel( labelNode )
					end
				end
			end
		end

		if BuffBasicManager.isSlow(buffId) then

			if Global.Battle_Use_View then
				local view = LabelView.createLabelView( LabelUtils.Label_HuanShu )
				if view then
					local labelNode = view:getRootNode()
					if labelNode then
						player:addLabel( labelNode )
					end
				end
			end
		end


		player.roleDyVo.isGuangChuang= player.roleDyVo.isGuangChuang or BuffBasicManager.isGuangChuang(buffId)

		player.roleDyVo.isHealLarger= player.roleDyVo.isHealLarger or BuffBasicManager.isHealLarger(buffId)

		player:setViewFrozen(player.roleDyVo.isFreeze)

		if player.roleDyVo.isFreeze or  player.roleDyVo.isComa then

			--如果增加了冰冻效果, 则取消攻击特效
			player:runWithDelay(function()
				-- body
				player:cleanAllAtkEffectViews()
				player:stopMove()

				if not player:isSkillActionLocked() then
					player:play(ActionUtil.Action_Stand)
				end
			end)

			FightView.handleGeWuBuff(player)
			
			print("产生了冰冻或者昏迷效果...."..player.roleDyVo.dyId)
		end

		if player.roleDyVo.isBlind then

			print("产生了致盲效果")   
			-- player:stopMove()
			-- player:play(ActionUtil.Action_Stand)
		end

		if player.roleDyVo.isGuangChuang then
			print("产生了贯穿"..player.roleDyVo.playerId)
		end

		-- 歌舞类buff添加
		if BuffBasicManager.isGeWu(buffId) then
			print("产生了歌舞类效果")
			player.roleDyVo.isGeWu = true
		end

		-- if buffBasicVo.model_id>0 then
		-- 	if buffBasicVo.layer==SkillUtil.Layer_Role_Up then

		local mydelay = self:calcUAtkDelayBySkillIdAndCrit(skillId,crit)
		player:runWithDelay(function ()
			-- body
			if not triggerFlag then
				player:addUpBuff(buffId)
			end

			player:updateBloodPercent(hpPercent, hp)
		end, mydelay)
			-- elseif buffBasicVo.layer==SkillUtil.Layer_Role_Down then
			-- 	player:addDownBuff(buffId)
			-- end
		-- end
	else
		print('add buff but no player')

	end
end

--移除buff 
function SceneRolesView:removeBuff( buffId,playerId ,skillId,crit, speed)

	print('SceneRolesView 处理移除Buff '..buffId..' ,player '..tostring(playerId)..' ,skill='..tostring(skillId))

	local player = self._playerDict[playerId]
	if player then
		local buffBasicVo = BuffBasicManager.getBuffBasicVo(buffId)
		-- print('buffId------')
		-- print(buffId)
		-- print('buffId===')
		print("解除buff"..buffId)
		assert(buffBasicVo, 'buffId='..buffId)

		if speed then
			player.roleDyVo.speed=speed/UpdateRate.getOriginRate()
			print('removeBuff 添加了speed'..player.roleDyVo.speed)
		end

		if BuffBasicManager.isFreeze(buffId) then
			player.roleDyVo.isFreeze=false
			print("解除冰冻效果.")

		end
		if BuffBasicManager.isComa(buffId) then
			player.roleDyVo.isComa=false
			print("解除昏迷效果")
		end
		if BuffBasicManager.isBlind(buffId) then
			player.roleDyVo.isBlind=false
			print("解除致盲效果")
		end

		if BuffBasicManager.isGuangChuang(buffId) then
			player.roleDyVo.isGuangChuang=false
			print("解除贯穿效果")
		end

		if BuffBasicManager.isHealLarger(buffId) then
			player.roleDyVo.isHealLarger=false
			print("解除治疗变大效果")
		end

		-- 歌舞类buff添加
		if BuffBasicManager.isGeWu(buffId) then
			print("解除歌舞类效果")
			player.roleDyVo.isGeWu = false
			player:play(ActionUtil.Action_Stand)
			--歌舞移除攻击特效
			player:cleanAllAtkEffectViews()
		end

		player:setViewFrozen(player.roleDyVo.isFreeze)


		if buffBasicVo.model_id>0 then
			if buffBasicVo.layer==SkillUtil.Layer_Role_Up then

				-- print('a remove buff up '..buffId)
				local mydelay = self:calcUAtkDelayBySkillIdAndCrit(skillId, crit)
				
				player:runWithDelay(function ( ... )
					-- body
					-- print('b remove buff up '..buffId)
					player:removeUpBuff(buffId)
				end, mydelay)
				
			elseif buffBasicVo.layer==SkillUtil.Layer_Role_Down then
				-- print('a remove buff down '..buffId)
				local mydelay = self:calcUAtkDelayBySkillIdAndCrit(skillId, crit)
				player:runWithDelay(function ( ... )
					-- body
					-- print('b remove buff down '..buffId)
					player:removeDownBuff(buffId)
				end, mydelay)
			end
		end
	end
end

function SceneRolesView:reset()
	-- body
	local mymap = {}
	
	for i,v in pairs(self._playerDict) do
		mymap[i] = v
	end

	for i,player in pairs(mymap) do
		self:deleteRole(player)
	end

	self._preTime = 0
	self._prePlayerDict = {}

	if self._updateHandle then
		FightTimer.cancel(self._updateHandle)
		self._updateHandle = nil
	end
end

local instance = SceneRolesView.new()

return instance


