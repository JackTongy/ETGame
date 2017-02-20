
local HeroPlayer = require 'HeroPlayer'
local OtherPlayer = require 'OtherPlayer'
local MonsterPlayer = require 'MonsterPlayer'

local YFMath=require 'YFMath'
local TypeRole = require 'TypeRole'
local RolePlayerManager = require 'RolePlayerManager'
local _fightView = require 'FightView'

local layerManager = require 'LayerManager'
local actionUtil = require 'ActionUtil'
local directionUtil = require 'DirectionUtil'
local FightTimer = require 'FightTimer'
local buffBasicManager = require 'BuffBasicManager'
local skillUtil = require 'SkillUtil'
local updateRate = require 'UpdateRate'
local eventCenter = require 'EventCenter'
local selectPlayerProxy = require 'SelectPlayerProxy'
local YFMath = require 'YFMath'
local fightEvent = require 'FightEvent'
local RoleSelfManager = require 'RoleSelfManager'
local skillBasicManager=require "SkillBasicManager"
local LabelView = require 'LabelView'
local LabelUtils = require 'LabelUtils'

local BattleUpdateToNet = require 'BattleUpdateToNet'

-- local rolesLayer;	--  role  player
--检测同步坐标的最大误差值
-- local checkRolePosLen = 80	
local CfgHelper = require 'CfgHelper'

local SceneRolesView=class()

function SceneRolesView:ctor(  )
	
	self._playerDict={}
	self._deadDict = {}
	self._preTime=0
end

function SceneRolesView:start()
	-- body
	if self._updateHandle then
		FightTimer.cancel(self._updateHandle)
		self._updateHandle = nil
	end

	self._updateHandle = FightTimer.tick(function ( )

		if SystemHelper:currentTimeMillis() -self._preTime>= 150 then
			self:arrangeDepth()
			self._preTime=SystemHelper:currentTimeMillis()
		end

	end,0)

	self:addEvents()
end

-- 添加事件
function SceneRolesView:addEvents(  )

	--主动触发能量球技能
	eventCenter.addEventFunc(fightEvent.ReleaseSkill,function( data )
		-- local player = selectPlayerProxy.getPlayer()
		local skillId = data.skillId
		local playerId = data.dyId
		local player = self._playerDict[playerId]
		print('SceneRolesView:addEvents on receive ReleaseSkill=='..playerId)
		if player then
			-- local skillBasicVo = selectPlayerProxy.getSkillBasicVo()
			local skillBasicVo=skillBasicManager.getSkill(skillId)
			-- 
			if skillBasicVo then 
				local arr = {}
				local num = skillBasicVo.maxnum

				if skillBasicVo.target ==skillUtil.SkillTarget_MinHp then   --搜索血量最少的
					
					local playerArr = RolePlayerManager.getPlayerMapSorted()
					local minHpPlayer =nil
					for k,player in ipairs(playerArr) do
						if not minHpPlayer then
							minHpPlayer =player 
						else
							if player.roleDyVo.hpPercent < minHpPlayer.roleDyVo.hpPercent then
								minHpPlayer=player
							end
						end
					end
					
					if minHpPlayer then
						table.insert(arr,minHpPlayer)
					end

				elseif skillBasicVo.target ==skillUtil.SkillTarget_LastEnemy then   --最后一个人
					num = 20
					arr=RolePlayerManager.getPlayerbySkill2(player,skillBasicVo.id,num)
					print("检测最后一人，检测的数组长度 =="..#arr)
					table.sort(arr,function ( firstPlayer,secondPlayer )   --从大到小
						-- local distance1 = YFMath.distance2(firstPlayer,player)
						-- local distance2 = YFMath.distance2(secondPlayer,player)
						-- return distance1>distance2
						if RoleSelfManager.getFlipX() > 0 then
							if player:isMonster() or player:isOtherPlayer() then
								return firstPlayer:getMapX() > secondPlayer:getMapX()
							else
								return firstPlayer:getMapX() < secondPlayer:getMapX()
							end
						else
							if player:isMonster() or player:isOtherPlayer() then
								return firstPlayer:getMapX() < secondPlayer:getMapX()
							else
								return firstPlayer:getMapX() > secondPlayer:getMapX()
							end
						end
					end)
					arr={arr[1]}

				else  
					local  fightTarget = player:getFightTarget()

					if player.roleDyVo.isGuangChuang then  --具备贯穿效果
						num = 20
					end

					-- if fightTarget then
					-- 	if RolePlayerManager.canTriggerSkill(player,skillBasicVo,fightTarget ) then
					-- 		num=num-1
					-- 		if num<0 then 
					-- 			num=0
					-- 		end
					-- 		print("数量少了一个")
					-- 	end
					-- end

					arr=RolePlayerManager.getPlayerbySkill2(player,skillBasicVo.id,num,fightTarget)
					print("搜到=="..#arr)

					if fightTarget then
						if RolePlayerManager.canTriggerSkill(player,skillBasicVo,fightTarget ) then
							table.insert(arr,fightTarget)
						end
					end
				end
					

				print('能量球技能发送='..#arr)
				-- print(arr)
				-- print("------")
				player.bigSkillOnTrigger=true  --在触发大招的时候，是不能进行解锁的
				-- player:noticeFight(skillBasicVo,arr,true) 

				player:beginToNoticeFight(skillBasicVo,arr,true)
			else
				print('error: SceneRolesView:addEvents, no skillBasicVo')
			end
		else
			print('error: SceneRolesView:addEvents, no player')
		end
	end , 'Fight')



	--- pve  子弹创建侦听
	eventCenter.addEventFunc(fightEvent.Pve_CreateBullet,function ( data )
		local skillBasicVo = data.skillBasicVo
		local player = data.player
		local isCrit = data.isCrit
		self:createBullet(skillBasicVo,player, isCrit)
		-- body
	end,'Fight')

end

--创建飞行道具 pve  使用
function SceneRolesView:createBullet( skillBasicVo,player )
	-- body
	-- print("pve创建即时飞行道具")

	require 'NewFlyTool'.createFlyTool(player, skillBasicVo.id)
end

--返回使用该技能影响的玩家列表
-- function SceneRolesView:getPlayerbySkill(playerId,skillId)
-- 	return RolePlayerManager.getPlayerbySkill(playerId,skillId)
-- end


function SceneRolesView:addRole( roleDyVo  )
	local  player = self:createRole(roleDyVo)
	return player
end
--设置玩家的坐标
function SceneRolesView:updatePlayerPos( playerId,pos )
	BattleUpdateToNet.sendUpdatePos( playerId,pos )

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
	return self._playerDict[playerId] or self._deadDict[playerId]
end

-- add to player  layer 
function SceneRolesView:addToLayer(player)
	local parent = player:getRootNode():getParent()
	if parent==nil or parent ~=layerManager.roleLayer then
		layerManager.roleLayer:addChild(player:getRootNode())
	else
		print('warnings......')
	end
end
-- remove player from  role Layer
function SceneRolesView:removeLayer( player )
	-- local parent = player:getRootNode():getParent()
	-- if parent~=nil and parent==layerManager.roleLayer then
	-- 	layerManager.roleLayer:removeChild(player:getRootNode(),true)
	-- end

	-- 
	-- player:getRootNode():removeFromParent()
end

function SceneRolesView:deleteRole( player )
	RolePlayerManager.removePlayer(player)
	self._playerDict[player.roleDyVo.playerId]=nil

	self._deadDict[player.roleDyVo.playerId] = player
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

		if player.roleDyVo.dyId ~=RoleSelfManager.dyId then
			local playerPos = player:getPosition()
			directionUtil.getDireciton(playerPos.x,destPoint.x)
			player:moveToPosByNet(curentPos,destPoint,serveTime,function(  )

				player:play(actionUtil.Action_Stand,dir,true)
			end,changeDir)
		end
	end
end

---替补上场走到目标点
function SceneRolesView:updateMoveToPos(playerId,currPos,destPoint,dir,complete )

	local player =	self._playerDict[playerId]

	if player then
		local playerPos = player:getPosition()
		directionUtil.getDireciton(playerPos.x,destPoint.x)
		player:moveToPosByNet(currPos,destPoint,nil,function(  )
			player:play(actionUtil.Action_Stand,dir,true)
			if complete then
				complete()
			end
		end)
	end
end




function SceneRolesView:updateFight(fightUIVo)
	_fightView.updateFight(fightUIVo)
end

function SceneRolesView:createRole(roleDyVo) 
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

	if roleDyVo.bigCategory==TypeRole.BigCategory_Role then
		if roleDyVo.dyId==RoleSelfManager.dyId then	--自己的玩家 
			args.bloodType = TypeRole.BloodType_Hero

			player = HeroPlayer.new(args)
			-- player:initSelectBox()

			player:startAI()
			backStandDir = RoleSelfManager.getHeroBackStandDir()
			
		else --对方玩家
			args.bloodType = TypeRole.BloodType_NotFriend

			player=OtherPlayer.new(args)
			-- player:initSelectBox()

			backStandDir=RoleSelfManager.getOtherRoleBackStandDir()
			
		end		
	elseif roleDyVo.bigCategory==TypeRole.BigCategory_Monster then --怪物 
		args.isMonster = true
		args.isBoss = roleDyVo.isBoss

		-- args.isBoss = true

		if args.isBoss then
			args.bloodType = TypeRole.BloodType_Boss
		else
			args.bloodType = TypeRole.BloodType_Monster
		end

		player = MonsterPlayer.new(args)
		-- player:initSelectBox()

		backStandDir=RoleSelfManager.getOtherRoleBackStandDir()
		print("backStandDir::"..backStandDir)
		player:startAI()
	end

	player:initRoleDyVo(roleDyVo)

	self._playerDict[player.roleDyVo.playerId]=player
	RolePlayerManager.addPlayer(player)

	print('roleDyVo')
	print(roleDyVo.basicId)
	local charVo = CfgHelper.getCache('charactorConfig', 'id', roleDyVo.basicId)
	local charName = tostring(roleDyVo.playerId)..':'..tostring(charVo.atk_method_system).."."..charVo.id

	player:setName(charName)

	player:updateBloodPercent( 100 )
	player:play(actionUtil.Action_Stand,backStandDir,true,nil,true)
	-- layerManager.roleLayer:addChild(player:getRootNode())
	self:addToLayer(player)

	return player
end
-- set zorder 
function SceneRolesView:arrangeDepth( )
	for playerId,player in pairs(self._playerDict) do
		-- if player:isOwnerTeam() then
		-- 	layerManager.roleLayer:reorderChild(player:getRootNode(), 1000 -player:getMapY())
		-- else
			layerManager.roleLayer:reorderChild(player:getRootNode(), -player:getMapY())
		-- end
	end
end

function SceneRolesView:calcUAtkDelayBySkillIdAndCrit( skillId, crit )
	-- body


	if skillId then
		local skillBasicVo = require 'CfgHelper'.getCache('skill', 'id', skillId)
		if crit then
			return skillBasicVo.red_time[2]
		else
			return skillBasicVo.red_time[1]
		end	
	end
	
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
	print(skillUtil.BuffType_GuangChuang)

	local player = self._playerDict[playerId]

	local mydelay = self:calcUAtkDelayBySkillIdAndCrit(skillId,crit)
	player:runWithDelay(function ()
		-- body
		if not triggerFlag then
			local view = LabelView.createLabelView( LabelUtils.Label_MianYi )
			if view then
				local labelNode = view:getRootNode()
				if labelNode then
					player:addLabel( labelNode )
				end
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
	-- print(skillUtil.BuffType_GuangChuang)

	print('SceneRolesView 处理增加Buff '..buffId..' ,player '..tostring(playerId)..' ,skill='..tostring(skillId))


	local player = self._playerDict[playerId]

	if player then
		if hpPercent then
			-- print("hp发生改变"..hpPercent)
			player.roleDyVo.hpPercent=hpPercent

			if hpPercent <= 0 then
				-- self:deleteRole(player)
				player:playDead(nil, 0, function ( )
					self:deleteRole(player) 	--人物死亡 删除角色  
				end)
				player:updateBloodBar()
			end
		end

		if hp then
			print('冒血啊。。。。')
		end

		if speed then
			player.roleDyVo.speed=speed/updateRate.getOriginRate()
			print('添加了speed'..player.roleDyVo.speed)
		end

		local buffBasicVo = buffBasicManager.getBuffBasicVo(buffId)
		
		player.roleDyVo.isFreeze = player.roleDyVo.isFreeze or buffBasicManager.isFreeze(buffId)

		player.roleDyVo.isComa = player.roleDyVo.isComa or buffBasicManager.isComa(buffId)

		player.roleDyVo.isBlind= player.roleDyVo.isBlind or buffBasicManager.isBlind(buffId)

		player.roleDyVo.isGuangChuang= player.roleDyVo.isGuangChuang or buffBasicManager.isGuangChuang(buffId)

		player.roleDyVo.isHealLarger= player.roleDyVo.isHealLarger or buffBasicManager.isHealLarger(buffId)

		player:setViewFrozen(player.roleDyVo.isFreeze)

		if player.roleDyVo.isFreeze or  player.roleDyVo.isComa then

			player:stopMove()
			player:play(actionUtil.Action_Stand)

			_fightView.handleGeWuBuff(player)
			
			print("产生了冰冻或者昏迷效果...."..player.roleDyVo.dyId)
		end
		if player.roleDyVo.isBlind then

			print("产生了致盲效果")   
			-- player:stopMove()
			player:play(actionUtil.Action_Stand)
		end

		if player.roleDyVo.isGuangChuang then
			
			print("产生了贯穿"..player.roleDyVo.playerId)

		end

		-- 歌舞类buff添加
		if buffBasicManager.isGeWu(buffId) then
			print("产生了歌舞类效果")
			player.roleDyVo.isGeWu = true
		end

		-- if buffBasicVo.model_id>0 then
		-- 	if buffBasicVo.layer==skillUtil.Layer_Role_Up then

		local mydelay = self:calcUAtkDelayBySkillIdAndCrit(skillId,crit)
		player:runWithDelay(function ()
			-- body
			if not triggerFlag then
				player:addUpBuff(buffId)
			end

			player:updateBloodPercent(hpPercent, hp)
		end, mydelay)
			-- elseif buffBasicVo.layer==skillUtil.Layer_Role_Down then
			-- 	player:addDownBuff(buffId)
			-- end
		-- end
	end
end

--移除buff 
function SceneRolesView:removeBuff( buffId,playerId ,skillId,crit, speed)

	print('SceneRolesView 处理移除Buff '..buffId..' ,player '..tostring(playerId)..' ,skill='..tostring(skillId))

	local player = self._playerDict[playerId]
	if player then
		local buffBasicVo = buffBasicManager.getBuffBasicVo(buffId)
		-- print('buffId------')
		-- print(buffId)
		-- print('buffId===')
		print("解除buff"..buffId)
		assert(buffBasicVo, 'buffId='..buffId)

		if speed then
			player.roleDyVo.speed=speed/updateRate.getOriginRate()
			print('removeBuff 添加了speed'..player.roleDyVo.speed)
		end

		if buffBasicManager.isFreeze(buffId) then
			player.roleDyVo.isFreeze=false
			print("解除冰冻效果.")

		end
		if buffBasicManager.isComa(buffId) then
			player.roleDyVo.isComa=false
			print("解除昏迷效果")
		end
		if buffBasicManager.isBlind(buffId) then
			player.roleDyVo.isBlind=false
			print("解除致盲效果")
		end

		if buffBasicManager.isGuangChuang(buffId) then
			player.roleDyVo.isGuangChuang=false
			print("解除贯穿效果")
		end

		if buffBasicManager.isHealLarger(buffId) then
			player.roleDyVo.isHealLarger=false
			print("解除治疗变大效果")
		end

		-- 歌舞类buff添加
		if buffBasicManager.isGeWu(buffId) then
			print("解除歌舞类效果")
			player.roleDyVo.isGeWu = false
			player:play(actionUtil.Action_Stand)
			--歌舞移除攻击特效
			player:cleanAllAtkEffectViews()
		end

		player:setViewFrozen(player.roleDyVo.isFreeze)

		if buffBasicVo.model_id>0 then
			if buffBasicVo.layer==skillUtil.Layer_Role_Up then

				print('a remove buff up '..buffId)
				local mydelay = self:calcUAtkDelayBySkillIdAndCrit(skillId, crit)
				
				player:runWithDelay(function ( ... )
					-- body
					print('b remove buff up '..buffId)
					player:removeUpBuff(buffId)
				end, mydelay)
				
			elseif buffBasicVo.layer==skillUtil.Layer_Role_Down then
				print('a remove buff down '..buffId)
				local mydelay = self:calcUAtkDelayBySkillIdAndCrit(skillId, crit)
				player:runWithDelay(function ( ... )
					-- body
					print('b remove buff down '..buffId)
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

	-- RolePlayerManager.reset()

end

local instance = SceneRolesView.new()

return instance


