
local EventCenter 					= require 'EventCenter'
local FightEvent 					= require 'FightEvent'
local Instance 						= require 'SceneRolesView'
local RoleDyVo 						= require 'RoleDyVo'
local UpdateRate 					= require 'UpdateRate'
local TypeRole 						= require "TypeRole"
local AIType 						= require 'AIType'
local ActionUtil 					= require 'ActionUtil'
local Broadcast 					= require 'framework.net.Broadcast'
local RolePlayerManager 			= require 'RolePlayerManager'
local BattleNet 					= require 'BattleUpdateToNet'
local CfgHelper 					= require 'CfgHelper'
local Utils 						= require 'framework.helper.Utils'
local RoleSelfManager 				= require 'RoleSelfManager'
local GridManager 					= require 'GridManager'
local CharactorConfigBasicManager 	= require 'CharactorConfigBasicManager'
local FightTimer 					= require 'FightTimer'
local YFMath 						= require 'YFMath'
local LayerManager 					= require 'LayerManager'
local DirectionUtil 				= require 'DirectionUtil'
local FightRunningHelper 			= require 'FightRunningHelper'

require 'TimeOut'

local FightController = class()

function FightController:ctor()
	self._scenerolesView = Instance --SceneRolesView.new()
end

function FightController:start( )
	--重置
	require 'FightTimer'.reset()
	require 'LayerManager'.reset()
	
	self:reset()
	
	EventCenter.resetGroup('Fight')
	
	self._scenerolesView:start()

	self:addEvents()
	self:addSocketEvent()

	--oo
end

--是否需要进行水平视图翻转
function FightController:setFlipX(  )
	LayerManager.setFlipX(RoleSelfManager.getFlipX())
end


function FightController:reset(  )
	self._scenerolesView:reset()
	RolePlayerManager.reset()
end

function FightController:addEvents( )

	--- 处理 pvp 歌舞buff的发送
	EventCenter.addEventFunc(FightEvent.Pvp_removeGeWuBuff,function (player )
		---发送socket remove 歌舞buff协议
		print("发送socket remove 歌舞buff协议")

		local Hid = player.roleDyVo.playerId
		local Sid = player.roleDyVo.skill_id
		BattleNet.sendRemoveDance(Hid, Sid)
	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_PreCreateHero, function ( data )
		-- body
		local playerData = data.D.V

		local roleDyVo 			= RoleDyVo.new()
		roleDyVo.dyId 			= (data.D.IsSelf and RoleSelfManager.dyId) or RoleSelfManager.otherDyId	
		roleDyVo.bigCategory 	= TypeRole.BigCategory_Role
		roleDyVo.playerId 		= playerData.Id
		roleDyVo.basicId 		= playerData._Id
		roleDyVo.hpPercent 		= playerData.Hp
		roleDyVo.speed 			= playerData.Speed/UpdateRate.getOriginRate()
		roleDyVo.name			= roleDyVo.playerId
		roleDyVo.skill_id 		= playerData.Sid
		roleDyVo.isFriend 		= playerData.isFriend
		roleDyVo.ai             = data.D.AI
		roleDyVo.awaken 		= playerData.awaken

		-- 
		roleDyVo.bornIJ 		= data.D.bornIJ

		assert(roleDyVo.awaken)
		
		local cloth 	= self._scenerolesView:preCreateRoleCloth(roleDyVo)
		local basicId = roleDyVo.basicId 
		local playerId  = roleDyVo.playerId

		local charactorBasicVo 	= CfgHelper.getCache('charactorConfig', 'id', roleDyVo.basicId)
		local career 			= charactorBasicVo.atk_method_system

		if not data.D.T then
			--不是替补
			if data.D.IsSelf then
				EventCenter.eventInput( FightEvent.Pve_CreatePlayerMana, { cloth = cloth, basicId = basicId, playerId = playerId, career = career, isFriend = roleDyVo.isFriend } )
			end
		else	--替补
			EventCenter.eventInput( FightEvent.Pve_CreatePlayerMana, { cloth = cloth, basicId = basicId, playerId = playerId, career = career, T = true, isFriend = roleDyVo.isFriend } )
		end
	end, 'Fight')

	--pve 添加角色
	EventCenter.addEventFunc(FightEvent.Pve_CreateHero,function(data)
		-- print(data)
		self:setFlipX()
		local playerData = data.D.V

		local roleDyVo 			= RoleDyVo.new()
		roleDyVo.dyId 			= (data.D.IsSelf and RoleSelfManager.dyId) or RoleSelfManager.otherDyId	
		roleDyVo.bigCategory 	= TypeRole.BigCategory_Role
		roleDyVo.playerId 		= playerData.Id
		roleDyVo.basicId 		= playerData._Id
		roleDyVo.hpPercent 		= playerData.Hp
		roleDyVo.speed 			= playerData.Speed/UpdateRate.getOriginRate()
		roleDyVo.name			= roleDyVo.playerId
		roleDyVo.skill_id 		= playerData.Sid
		roleDyVo.isFriend 		= playerData.isFriend
		roleDyVo.ai             = data.D.AI
		roleDyVo.awaken 		= playerData.awaken

		-- 
		roleDyVo.bornIJ 		= data.D.bornIJ

		print('Pve_CreateHero')
		print(data)

		local charactorConfig = CharactorConfigBasicManager.getCharactorBasicVo(roleDyVo.basicId)
		roleDyVo.career = charactorConfig.atk_method_system

		assert(roleDyVo.awaken)

		local timeDelay = (data.D.T and 2) or 0
		
		if not data.D.T then
			--不是替补
			local player = self._scenerolesView:addRole(roleDyVo)
			player:goToBattleField()
		else	--替补
			-- TimeOut.new(2, function ()
				local player = self._scenerolesView:addRole(roleDyVo)
				player:goToBattleField()
			-- end):start()
		end

		print("hero DyId=="..RoleSelfManager.dyId)
	end, 'Fight')


	--人物死亡 删除 角色

	EventCenter.addEventFunc(FightEvent.DeleteRole,function( player )
		self._scenerolesView:deleteRole(player)
		print('role__delete___'..player.roleDyVo.playerId)
	end, 'Fight')


	--请求战斗
	EventCenter.addEventFunc(FightEvent.C_Fight,function( fightVo )
		BattleNet.sendFight(fightVo)
	end, 'Fight')

	-- pve 战斗 
	--pve战斗返回
	EventCenter.addEventFunc(FightEvent.Pve_Action,function(data)
		self:handleAction(data)
	end, 'Fight')
	-- 添加buff
	EventCenter.addEventFunc(FightEvent.Pve_Buff,function(data )
		print('收到Buff')
		print(data)
		self:handleAddBuff(data)
	end, 'Fight')
	
	-- 移出buff
	EventCenter.addEventFunc(FightEvent.Pve_RemoveBuff,function ( data )
		self:handleRemoveBuff(data)
	end, 'Fight')
	
	---怪物出生
	EventCenter.addEventFunc(FightEvent.Pve_S_MonsterBirth,function ( serveMonsterDyVo )
		print("怪物出生-----")

		local roleDyVo 			= RoleDyVo.new()
		roleDyVo.dyId 			= serveMonsterDyVo.dyId
		roleDyVo.playerId 		= serveMonsterDyVo.playerId
		roleDyVo.basicId 		= serveMonsterDyVo.basicId
		roleDyVo.bigCategory 	= TypeRole.BigCategory_Monster
		roleDyVo.hpPercent		= math.ceil(serveMonsterDyVo.hp*100/serveMonsterDyVo.hpMax)
		roleDyVo.speed 			= serveMonsterDyVo.speed/UpdateRate.getOriginRate()
		roleDyVo.name			= roleDyVo.playerId
		roleDyVo.birthPos 		= serveMonsterDyVo.birthPos
		roleDyVo.awaken         = serveMonsterDyVo.awaken
		roleDyVo.SkillCD 		= serveMonsterDyVo.SkillCD
		roleDyVo.aiType 		= serveMonsterDyVo.aiType
		roleDyVo.isBoss 		= (serveMonsterDyVo.isboss == TypeRole.Monster_Boss)

		roleDyVo.isDropBox 		= serveMonsterDyVo.isDropBox
		roleDyVo.isDropBall 	= serveMonsterDyVo.isDropBall

		roleDyVo.heroid 		= serveMonsterDyVo.heroid

		print(string.format('Monster init hp = %f, %f, %f', serveMonsterDyVo.hp, serveMonsterDyVo.hpMax, roleDyVo.hpPercent))
		
		-- 处理完 onEntry
		self._scenerolesView:createMonster( roleDyVo )

	end, 'Fight')

	--战斗结束 
	EventCenter.addEventFunc(FightEvent.PVEFinish, function(data)
		assert(not data)
		-----敌方穿越危险区
		EventCenter.eventInput(FightEvent.Pve_GameOverQuick, require 'ServerRecord'.createGameOverData(false) )
		-- end
		
		--停止所有的英雄何怪物的ai
		RolePlayerManager.stopPVEAllAI()
	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pvp_Protect, function ( data )
		-- body
		BattleNet.sendProtect( data.Hid, data.Dur )
	end, 'Fight')

	-- EventCenter.addEventFunc(FightEvent.Pve_setSlowRate, function ( data )
	-- 	-- body
	-- 	assert(data)
	-- 	assert(data.playerId)
	-- 	assert(data.slowRate)

	-- 	local player = RolePlayerManager.getPlayer(data.playerId)
	-- 	if player then
	-- 		player:setAtkSpdRate(data.slowRate)
	-- 	end
	-- end, 'Fight')
	
	EventCenter.addEventFunc(FightEvent.Pve_setAtkSlowRate, function ( data )
		-- body
		assert(data)
		assert(data.playerId)
		assert(data.atkSlowRate)

		local player = RolePlayerManager.getPlayer(data.playerId)
		if player then
			player:setAtkSpdRate(data.atkSlowRate)
		end
	end, 'Fight')
end


--处理战斗消息
function FightController:handleAction(data)

	print('FightController:handleAction')
	print(data)

	local fightUIVo = {}
	local atkId = data.D.Hid
	local skillId = data.D.Sid
	local uAtkInfoJsonArr = data.D.Es or {}

	fightUIVo.basicId = data.D.BasicId

	fightUIVo.atk = self._scenerolesView:getPlayerAnyway(atkId) -- RolePlayerManager.getPlayer(atkId)
	assert(fightUIVo.atk or fightUIVo.basicId, 'not atk '..atkId)

	fightUIVo.skillId = skillId
	fightUIVo.IsCrit = data.D.IsCrit
	fightUIVo.uAtkArr = {}

	-- print("skillId=="..skillId)
	-- print('jsonData')
	-- print(uAtkInfoJsonArr)
	
	local delay_func

	delay_func = function ( ... )
		-- body
		for k,actionEffect in ipairs(uAtkInfoJsonArr) do
			local uAtkId = actionEffect.Hid
			local hp = actionEffect.HpD  -- 
			local hpPercent = actionEffect.HpP

			-- print("hpPercent=="..hpPercent..",playerId="..uAtkId)
			local uAtkPlayer = self._scenerolesView:getPlayer(uAtkId) --RolePlayerManager.getPlayer(uAtkId)
			
			-- local uAtkPosX = uAtkPlayer:getMapX()--actionEffect.PosX  --被击退到的目标位置
			-- local uAtkPosY = uAtkPlayer:getMapY()--actionEffect.PosY
			-- print("击飞...")
			local uAtkInfo = {player=uAtkPlayer,hp=hp,hpPercent=hpPercent}
			if actionEffect.MoveTo then
				uAtkInfo.pos={x=actionEffect.MoveTo[1],y=actionEffect.MoveTo[2]}
				print("具备击飞效果")
			end
			
			table.insert(fightUIVo.uAtkArr,uAtkInfo)

			-- print('hp--------------')
			-- print(hp)
			-- print('hpPercent--------------')
			-- print(hpPercent)
		end
		
		self._scenerolesView:updateFight(fightUIVo)

		--响应战斗事件
		print("skill2=="..skillId)
	end
	
	FightRunningHelper.delay(delay_func, 0)
	
	if RolePlayerManager.isHero(fightUIVo.atk) then  	--如果是主角玩家
		EventCenter.eventInput(FightEvent.TriggerSkill,{skillId=skillId,Ss=data.D.Ss,playerId=fightUIVo.atk.roleDyVo.playerId})
		print("skill=="..skillId)
	end

end

--处理添加buff
function FightController:handleAddBuff(data)
	-- print('Buff')
	-- print(data)
	-- print('=============')

	for k,buff in ipairs(data.D.Vs) do
		local playerId = buff.Hid
		local buffId = buff.Id
		local speed = buff.Speed
		local hp = buff.HpD
		local hpPercent = buff.HpP

		local skillId = buff.Sid
		local crit = buff.IsCrit
		local triggerFlag = buff.TriggerFlag
		-- assert(skillId)

		if buff.State == 'imm' then
			self._scenerolesView:justAddBuff(buffId,playerId,hp,hpPercent,speed, skillId, crit, triggerFlag)
		else
			self._scenerolesView:addBuff(buffId,playerId,hp,hpPercent,speed, skillId, crit, triggerFlag)
		end
		
	end
end

function FightController:handleRemoveBuff(data)
	-- print('FightController:handleRemoveBuff')
	-- print(debug.traceback())

	local buffId = data.D.Id
	local playerId = data.D.Hid
	local skillId = data.Sid or (data.D and data.D.Sid)
	local crit = data.IsCrit or (data.D and data.D.IsCrit)
	local speed = data.Speed or (data.D and data.D.Speed)
	-- assert(skillId)
	self._scenerolesView:removeBuff(buffId,playerId,skillId,crit,speed)
	-- print('移除buff')
end

--接受socket消息
function FightController:addSocketEvent( )

	EventCenter.addEventFunc('Move', function ( data )
		local playerId=data.D.Hid
		local currentPos=data.D.Pf
		local endPos=data.D.Pt
		local serverTime = data.D.T
		local myCurentPos = {x=currentPos[1],y=currentPos[2]}
		local myEndPos = {x=endPos[1],y=endPos[2]}
		local dir = data.D.Dir or -1   	-- dir 为可选参数
		local changeDir=  data.D.ChangeDir

		print("changeDir333")
		print(changeDir)
		self._scenerolesView:updateMoveToByNet(playerId,myCurentPos,myEndPos,serverTime,dir,changeDir)
	end, 'Fight')

	EventCenter.addEventFunc('Action',function(data )
		self:handleAction(data)
	end, 'Fight')

	EventCenter.addEventFunc('Buff', function ( data )
		--收到 Buff
		print('-----收到Buff----')
		print(data)


		self:handleAddBuff(data)
	end, 'Fight')

	EventCenter.addEventFunc('Rbuff',function(data)
		self:handleRemoveBuff(data)
	end, 'Fight')

end

return FightController.new()

