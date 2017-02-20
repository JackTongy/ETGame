--[[
处理具体的战斗逻辑  
]]

-- print('why me!@@@@@@@@@@@@@@@@@@')

local actionManager=require 'ActionUtil'
local DirectionUtil=require 'DirectionUtil'
local rolePlayerManager=require 'RolePlayerManager'
local EventCenter=require 'EventCenter'
local FightEvent=require 'FightEvent'
local skillBasicManager=require 'SkillBasicManager'
local charactorConfigBasicManager = require 'CharactorConfigBasicManager' 
local fightEffectBasicManager = require 'FightEffectBasicManager'
local SkillUtil = require 'SkillUtil'
local FlyView=require "FlyView"
local YFMath = require "YFMath"
local UpdateRate = require "UpdateRate"
local Utils = require "framework.helper.Utils"
local LayerManager = require "LayerManager"
local TypeRole = require "TypeRole"
local RoleSelfManager = require 'RoleSelfManager'
local EmptyFlyItem = require 'EmptyFlyItem'

local LabelView = require 'LabelView'
local LabelUtils = require 'LabelUtils'

--create
local FightEffectView = require 'FightEffectView'

local ActionFactory = require 'ActionFactory'

local FlySpeed = 2000

require "TweenSkill"



local fightView={}

--[[  fightUIVo具备的数据

	skillId
	level  
	atk  =AbsPlayer
	uAtkArr =[  uAtkInfo ] 
	fightUIVo.IsCrit=data.D.IsCrit
	uAtkInfo={
	player
	hp  最终血量
	hpChange	／／血量的变化值


	}
]]

--[[
对除了飞行道具以外的受击都一样
--]]
function fightView.handleUAtkArray( fightUIVo )
	-- body
	--技能攻击时间间隔
	local skillBasicVo = skillBasicManager.getSkill(fightUIVo.skillId)
	local spanTime = 0

	local atk = fightUIVo.atk

	for i,uAtkInfo in ipairs(fightUIVo.uAtkArr) do
		local uAtk = uAtkInfo.player
		local uAtkHpD = uAtkInfo.hp
		local uAtkHpP = uAtkInfo.hpPercent
		-- assert(fightUIVo.uAtkDelay > 0)
		-- print('uAtkHpD='..uAtkHpD..',uAtkid='..uAtk.roleDyVo.playerId)
		if uAtk then

			uAtk:runWithDelay(function ()
				-- body
				if rolePlayerManager.usablePlayer(uAtk) then	---有效的 player

					if uAtkHpP>0 then		-- 受击动画
						if uAtkInfo.pos and not uAtk:isSkillActionLocked() then  -- 击退
							fightView.handleGeWuBuff(uAtk)
							print("处理击退222")

							local dir = uAtk:getActiveDirection()	
							if atk then
								dir=DirectionUtil.getDireciton(uAtk:getMapX(),atk:getMapX())
							end
							uAtk:splay(actionManager.Action_BeatBack,dir,false, 0, function( )

							end)
							print("moveCompleteDir2="..dir)
							uAtk:lock()
							uAtk:pureMoveToPos(uAtkInfo.pos, 20, function ()
								if rolePlayerManager.canFightPlayer(uAtk) then
									print("moveCompleteDir="..uAtk:getActiveDirection())
									uAtk:play(actionManager.Action_Stand,dir,true,nil,true)
									uAtk:unLock()
								end
							end)
							
						end

						uAtk:updateBloodPercent(uAtkInfo.hpPercent, uAtkInfo.hp, fightUIVo.skillId, fightUIVo.IsCrit)

					else
						if uAtk.roleDyVo.dyId==RoleSelfManager.dyId then   --为自己 ，死亡的时候不能拖动
							uAtk:stopMove()
						end
						---人物死亡 
						print("人物死亡")
						uAtk:playDead(atk, 0, function ( )
							print('人物死亡,删除角色 roleid='..uAtk.roleDyVo.playerId)
							EventCenter.eventInput(FightEvent.DeleteRole, uAtk)	--人物死亡 删除角色  
						end)
						
						uAtk:updateBloodPercent(uAtkInfo.hpPercent, uAtkInfo.hp, fightUIVo.skillId, fightUIVo.IsCrit)
					end

					----播放人物身上的受击特效
					fightView.addEffect(uAtk, uAtkEffectbasicVoArr)
				end

			end, fightUIVo.uAtkDelay + (i-1)*spanTime )
		end
	end
end

function fightView.handleGeWuBuff( player )
	if player then
			if player.roleDyVo.dyId==RoleSelfManager.dyId then
			if player.roleDyVo.isGeWu then
				if RoleSelfManager.isPvp then
					print("处理PVP歌舞")
					EventCenter.eventInput(FightEvent.Pvp_removeGeWuBuff,player)
				else
					print("处理PVe歌舞")
					EventCenter.eventInput(FightEvent.Pve_removeGeWuBuff,player)
				end
			end
		end
	end
end


function fightView.updateFight1( fightUIVo )
	-- body
	-- print("handleFight_1"..fightUIVo.skillId)
	-- local skillBasicVo -- 根据技能id  和 技能技能 SkillBasicManager.getSkillBasicVo(skillId,level)
	local skillBasicVo = skillBasicManager.getSkill(fightUIVo.skillId)

	local atkEffectBasicVoArr = fightEffectBasicManager.getFightEffectBasicVoArr(fightUIVo.atk_effectId) --特效表现  --攻击者的特效表现
	local uAtkEffectbasicVoArr = fightEffectBasicManager.getFightEffectBasicVoArr(fightUIVo.uAtk_effectId) --特效表现   受击者的特效表现

	-- assert(atkEffectBasicVoArr,'atk_effectId='..fightUIVo.atk_effectId)

	local atk = fightUIVo.atk
	assert(atk)

	local direction
	if atk then
		direction=atk:getActiveDirection()
	end
  
	-- local uAtk 

	local uAtkSize = #fightUIVo.uAtkArr
	if uAtkSize>0  and atk then
		if fightUIVo.uAtkArr[1].player then
			direction = DirectionUtil.getDireciton(atk:getMapX(),fightUIVo.uAtkArr[1].player:getMapX())				
		end
	end

	if atk then

		atk:stopMove()

		local action = actionManager.Action_Attack
		if fightUIVo.IsCrit then action=actionManager.Action_AttackCrit end
		
		if skillBasicVo.skilltype>=10  then  ---远程大招
			action=actionManager.Action_BigSkill
		end


		--冲锋 
		local forward = atk:chargeForward(skillBasicVo,  fightUIVo.uAtkArr)
		if forward then
			if (atk:isOwnerTeam() and true) == (RoleSelfManager.getFlipX() > 0) then
				direction = actionManager.Direction_Left

			else
				direction = actionManager.Direction_Right
			end
		end
		

		atk:splay(action,direction,false, 0, function (  )
			
			if rolePlayerManager.canFightPlayer(atk) then
				atk:play(actionManager.Action_Stand,direction)
			end
		end, function ()

			if rolePlayerManager.canFightPlayer(atk) then
				if not atk.bigSkillOnTrigger then   --没有执行大招
					atk:unLock()
				else 
					if action == actionManager.Action_BigSkill then   ---大招 
						atk.bigSkillOnTrigger = false
						atk:unLock()
					end
				end

				atk:unLock()
			end
		end)
		-- print('atk_fight_Dir:'..direction..','..atk:getActiveDirection())

		fightView.addEffect(atk,atkEffectBasicVoArr)
	end
	
	fightView.handleUAtkArray( fightUIVo )
end



--飞行道具表现
function fightView.updateFight2(fightUIVo)
	
	print("updateFight2=="..fightUIVo.skillId)
	print("len=="..#fightUIVo.uAtkArr)

	local skillBasicVo = skillBasicManager.getSkill(fightUIVo.skillId)

	local atkEffectBasicVoArr=fightEffectBasicManager.getFightEffectBasicVoArr(fightUIVo.atk_effectId) --特效表现  --攻击者的特效表现
	local uAtkEffectbasicVoArr=fightEffectBasicManager.getFightEffectBasicVoArr(fightUIVo.uAtk_effectId) --特效表现   受击者的特效表现
	
	assert(atkEffectBasicVoArr ,'fightUIVo.atk_effectId='..tostring(fightUIVo.atk_effectId))

	local atk = fightUIVo.atk

	local direction
	if atk then
		direction=atk:getActiveDirection()
	end

	-- local uAtk 

	local uAtkSize = #fightUIVo.uAtkArr
	if uAtkSize>0  and atk then
		if fightUIVo.uAtkArr[1].player then
			direction=DirectionUtil.getDireciton(atk:getMapX(),fightUIVo.uAtkArr[1].player:getMapX())				
		end
	end

	if atk then

		atk:stopMove()
		local action = actionManager.Action_RemoteAttack
		if fightUIVo.IsCrit then
		 	action=actionManager.Action_RemoteCrit
		end
		if skillBasicVo.skilltype>=11  then  ---远程大招
			action=actionManager.Action_BigSkill
		end

		-- print("产生回调吗？？=="..atk.roleDyVo.playerId)

		atk:runWithDelay(function ()
			-- print("产生回调=="..atk.roleDyVo.playerId)
			-- body
			if action ~= actionManager.Action_BigSkill  then   ---大招不能立刻unlock

				if not fightUIVo.IsCrit then 

					if not atk.bigSkillOnTrigger then   --没有执行大招
						atk:unLock()
						-- print("atk unLock=="..atk.roleDyVo.playerId)
					else
						-- print("大招啊，不进行unlock")
					end
				else
					-- print("暴击啊")

				end
			else
				-- print("big skill")
			end
			 
			--0.5 用来调试的数值
		end, fightUIVo.uAtkDelay + 0.4)


		-- print("play播放？？？=="..atk.roleDyVo.playerId)
		atk:splay(action,direction,false, 0, function (  )
			-- print("play播放=="..atk.roleDyVo.playerId)
			if rolePlayerManager.canFightPlayer(atk) then
				atk:play(actionManager.Action_Stand,direction)

				-- if action == actionManager.Action_BigSkill  then   --//大招完成后unlock
				-- 	if atk.bigSkillOnTrigger then 
				-- 		atk:unLock()
				-- 		atk.bigSkillOnTrigger =false

				-- 	end
				-- elseif	fightUIVo.IsCrit then
				-- 	if not atk.bigSkillOnTrigger then   --没有执行大招
				-- 		atk:unLock()
				-- 	end
				-- end	
			end
		end,function ( )
			if rolePlayerManager.canFightPlayer(atk) then
				if action == actionManager.Action_BigSkill  then   --//大招完成后unlock
					if atk.bigSkillOnTrigger then 
						atk:unLock()
						atk.bigSkillOnTrigger =false

					end
				elseif	fightUIVo.IsCrit then
					if not atk.bigSkillOnTrigger then   --没有执行大招
						atk:unLock()
					end
				end	
			end
		end)
		-- print('atk_fight_Dir:'..direction..','..atk:getActiveDirection())

		fightView.addEffect(atk, atkEffectBasicVoArr)
	else
		print("atk not found")
	end


	---处理攻击者 上下两层
	---处理受击 动画
	local distance = 0
	local waitTime = 0

	--移动速度 暂时定死
	local moveSpeed = FlySpeed

	local startPos = {x=0,y=0}

	local flyItem = fightView.findFlyItem(atkEffectBasicVoArr)


	assert(flyItem, 'flyItem = nil, fightUIVo.skillId='..fightUIVo.skillId)

	
	local flyDelay = flyItem.delay
	
	--计算距离最长的目标.
	--
	local maxDistance = 0
	local lastUAtk
	for i,uAtkInfo in ipairs(fightUIVo.uAtkArr) do
		local uAtk = uAtkInfo.player
		if rolePlayerManager.canFightPlayer(uAtk) then	---有效的 player
			local distance = YFMath.distance2(atk,uAtk)
			if distance > maxDistance then
				maxDistance = distance
				lastUAtk = uAtk
			end
		end
	end

	if not lastUAtk then
		--init position
		atk:runWithDelay(function (  )
			-- body
			local endPos
			local skinId = flyItem.model_id

			if skinId == nil then
				print('flyItem.model_id')
				print(flyItem)
			end

			if atk then
				startPos = atk:getPosition()
				--出来左方还是右方
				if (atk:isOwnerTeam() and true) == (RoleSelfManager.getFlipX() > 0) then
					--在右侧
					startPos.x = startPos.x + flyItem.offset[1]
					startPos.y = startPos.y + flyItem.offset[2]

					endPos = {x = startPos.x - 2000, y = startPos.y}
				else
					startPos.x = startPos.x - flyItem.offset[1]
					startPos.y = startPos.y + flyItem.offset[2]

					endPos = {x = startPos.x + 2000, y = startPos.y}
				end
				
				--强制打出一个空的飞行道具
				-- print('播放空的飞行道具!!!')
				fightView.playEmptyMoveEffect(skinId, startPos, endPos, moveSpeed)
			end
			
		end, flyDelay)
		-- return
	else
		---播放飞行道具技能动画
		atk:runWithDelay(function (  )
			-- body
			
			local skinId = flyItem.model_id
			if atk then
				startPos = atk:getPosition()
				--出来左方还是右方
				if (atk:isOwnerTeam() and true) == (RoleSelfManager.getFlipX() > 0) then
					--在右侧
					startPos.x = startPos.x + flyItem.offset[1]
					startPos.y = startPos.y + flyItem.offset[2]
				else
					startPos.x = startPos.x - flyItem.offset[1]
					startPos.y = startPos.y + flyItem.offset[2]
				end
				
			else
				startPos = uAtk:getPosition()
			end

			fightView.playMoveEffect(skinId, startPos, lastUAtk, moveSpeed/UpdateRate.getOriginRate())
			
		end, flyDelay)
	end

	for i,uAtkInfo in ipairs(fightUIVo.uAtkArr) do
		local uAtk = uAtkInfo.player
		
		if rolePlayerManager.canFightPlayer(uAtk) then	---有效的 player
			--放到延迟上进行

			if atk then
				distance = YFMath.distance2(atk,uAtk)
			else
				distance = 0
			end

			--init position
			waitTime = distance/moveSpeed   --飞行时间

			local arriveTime = waitTime + flyDelay
			

			-- local offsetTime = -flyDelay*1000 --ms
			if uAtkInfo.hpPercent>0 and not uAtk:isSkillActionLocked() then		-- 受击动画
				-- print("处理飞行道具受击")
				if not uAtkInfo.pos then
					-- print("没有击退")
					local inJureAction =  nil --actionManager.Action_Injure
					local uAtCharactorConfig = charactorConfigBasicManager.getCharactorBasicVo(uAtk.roleDyVo.basicId)
					-- print("远程=="..uAtk.roleDyVo.playerId)
					-- print(skillBasicVo.skilltype)
					-- print(uAtCharactorConfig.atk_method_system)

					if uAtCharactorConfig.atk_method_system==TypeRole.Career_QiShi and skillBasicVo.skilltype==SkillUtil.SkillType_YuanCheng then  --远程大招不格挡
						inJureAction=actionManager.Action_GeDang
						-- print("产生格挡")
					end

					--暂时不播放受击动画
					if inJureAction == actionManager.Action_GeDang then
						--格挡动画
						-- print("格挡动画")
						-- uAtk:splay(inJureAction,uAtk:getActiveDirection(),false, arriveTime * 1000,function( )
						-- 	-- print("处理回调响应8888")
						-- 	if rolePlayerManager.canFightPlayer(uAtk) then
						-- 		uAtk:play(actionManager.Action_Stand,uAtk:getActiveDirection(),true,nil,true)
						-- 		-- print("处理回调响应9999")
						-- 		-- print("格挡回调")
						-- 	end
						-- end)


						uAtk:stopMove()
						
						uAtk:setGeDangLocked()
						uAtk:splay(inJureAction, uAtk:getActiveDirection(), false, arriveTime * 1000, function( )
							-- print("处理回调响应8888")
							if RolePlayerManager.canFightPlayer(uAtk) then
								uAtk:play(ActionManager.Action_Stand,uAtk:getActiveDirection(),true,nil,true)
								-- print("处理回调响应9999")
								
							end
						end, function (  )
							-- body
							print("格挡回调")
							-- uAtk:resumeQiShi()
							uAtk:unLockGeDang()
						end)
					end

				else  -- 击退
					fightView.handleGeWuBuff(uAtk)

					print("处理击退111")
					local dir = uAtk:getActiveDirection()	
					print("dir=="..dir)
					if atk then
						print(uAtk:getMapX())
						print(atk:getMapX())

						dir = DirectionUtil.getDireciton(uAtk:getMapX(),atk:getMapX())
						print("dir222=="..dir)
					end
					uAtk:splay(actionManager.Action_BeatBack,dir,false, arriveTime * 1000,function( )
						-- if rolePlayerManager.canFightPlayer(uAtk) then
						-- 	uAtk:play(actionManager.Action_Stand,uAtk:getActiveDirection(),true,nil,true)
						-- end
					end)
					-- print("处理pureMoveTo:"..waitTime)

					Utils.delay(function(  )
						-- print("处理pureMoveTo22")
						uAtk:lock()
						uAtk:pureMoveToPos(uAtkInfo.pos, 20,function ( )
							if rolePlayerManager.canFightPlayer(uAtk) then
								uAtk:play(actionManager.Action_Stand,dir,true,nil,false)
								uAtk:unLock()
							end
						end)
					end,arriveTime)

				end

				Utils.delay(function(  )

					 uAtk:updateBloodPercent(uAtkInfo.hpPercent, uAtkInfo.hp, fightUIVo.skillId, fightUIVo.IsCrit)
				end, arriveTime)

			else	

				if uAtk.roleDyVo.dyId==RoleSelfManager.dyId then   --为自己 ，死亡的时候不能拖动
					uAtk:stopMove()
				end
				---人物死亡 
				uAtk:playDead(atk, arriveTime * 1000,function ()
					print('人物死亡,删除角色 roleid='..uAtk.roleDyVo.playerId)
					EventCenter.eventInput(FightEvent.DeleteRole,uAtk)	--人物死亡 删除角色  
				end)

				uAtk:runWithDelay(function ()

					uAtk:updateBloodPercent(uAtkInfo.hpPercent, uAtkInfo.hp, fightUIVo.skillId, fightUIVo.IsCrit)
				end, arriveTime)
			end

			----播放人物身上的受击特效
			uAtk:runWithDelay(function ()
				-- body

				fightView.addEffect(uAtk, uAtkEffectbasicVoArr)
			end, arriveTime)
			
		end
	end
end

--治疗战斗表现
function fightView.updateFight3(fightUIVo )
-- body
	-- print("handleFight_3:"..fightUIVo.skillId)
	-- print(fightUIVo)
	-- local skillBasicVo -- 根据技能id  和 技能技能 SkillBasicManager.getSkillBasicVo(skillId,level)
	local skillBasicVo = skillBasicManager.getSkill(fightUIVo.skillId)

	local atkEffectBasicVoArr=fightEffectBasicManager.getFightEffectBasicVoArr(fightUIVo.atk_effectId) --特效表现  --攻击者的特效表现
	local uAtkEffectbasicVoArr=fightEffectBasicManager.getFightEffectBasicVoArr(fightUIVo.uAtk_effectId) --特效表现   受击者的特效表现

	-- assert(atkEffectBasicVoArr)

	local atk = fightUIVo.atk

	if atk then

		atk:stopMove()
		local action = actionManager.Action_ZhiLiao
		if skillBasicVo.skilltype>=10  then  ---远程大招
			action=actionManager.Action_BigSkill
		end

		if #fightUIVo.uAtkArr>=0 then
			print("delay=="..fightUIVo.uAtkDelay)

			atk:runWithDelay(function ( ... )
				-- body
				atk:unLock()
				if action==actionManager.Action_BigSkill then
					atk.bigSkillOnTrigger =false
				end

			end, fightUIVo.uAtkDelay)

			atk:splay(action, -1, false, 0, function (  )
				-- atk:unLock()

				if rolePlayerManager.canFightPlayer(atk) then
					atk:play(actionManager.Action_Stand)
					-- print('atk_stand_Dir:'..direction..','..atk:getActiveDirection())
				end
			end)

		else
			-- atk:unLock()

			atk:runWithDelay(function ( ... )
				-- body
				atk:unLock()
				if action==actionManager.Action_BigSkill then
					atk.bigSkillOnTrigger =false
				end

			end, fightUIVo.uAtkDelay)
		end
		-- print('atk_fight_Dir:'..direction..','..atk:getActiveDirection())

		fightView.addEffect(atk,atkEffectBasicVoArr)
	end

	fightView.handleUAtkArray( fightUIVo )
end


--歌舞战斗表现
function fightView.updateFight4(fightUIVo )
-- body
	-- print("handleFight_3:"..fightUIVo.skillId)
	-- print(fightUIVo)
	-- local skillBasicVo -- 根据技能id  和 技能技能 SkillBasicManager.getSkillBasicVo(skillId,level)
	local skillBasicVo = skillBasicManager.getSkill(fightUIVo.skillId)

	local atkEffectBasicVoArr=fightEffectBasicManager.getFightEffectBasicVoArr(fightUIVo.atk_effectId) --特效表现  --攻击者的特效表现
	local uAtkEffectbasicVoArr=fightEffectBasicManager.getFightEffectBasicVoArr(fightUIVo.uAtk_effectId) --特效表现   受击者的特效表现

	-- assert(atkEffectBasicVoArr)

	local atk = fightUIVo.atk

	if atk then

		atk:stopMove()
		local action = actionManager.Action_ZhiLiao
		if skillBasicVo.skilltype>=10  then  ---远程大招
			action=actionManager.Action_BigSkill
		end

		-- print("delay=="..fightUIVo.uAtkDelay)

		atk:runWithDelay(function ( ... )
			-- body
			atk:unLock()
			if action==actionManager.Action_BigSkill then
				atk.bigSkillOnTrigger =false
			end

		end, fightUIVo.uAtkDelay)

		atk:splay(action, -1, false, 0, function (  )
			-- atk:unLock()

			if rolePlayerManager.canFightPlayer(atk) and skillBasicVo.skilltype ~= SkillUtil.SkillType_Dance then
				atk:play(actionManager.Action_Stand)
				-- print('atk_stand_Dir:'..direction..','..atk:getActiveDirection())
			end
		end)
		-- print('atk_fight_Dir:'..direction..','..atk:getActiveDirection())

		fightView.addEffect(atk,atkEffectBasicVoArr)
	end

	fightView.handleUAtkArray( fightUIVo )
end


--全屏大招类表现
function fightView.updateFight11( fightUIVo )
	-- body
	-- print("handleFight_1"..fightUIVo.skillId)
	-- local skillBasicVo -- 根据技能id  和 技能技能 SkillBasicManager.getSkillBasicVo(skillId,level)

	local skillBasicVo = skillBasicManager.getSkill(fightUIVo.skillId)

	local atkEffectBasicVoArr = fightEffectBasicManager.getFightEffectBasicVoArr(fightUIVo.atk_effectId) --特效表现  --攻击者的特效表现
	local uAtkEffectbasicVoArr = fightEffectBasicManager.getFightEffectBasicVoArr(fightUIVo.uAtk_effectId) --特效表现   受击者的特效表现

	-- assert(atkEffectBasicVoArr,'atk_effectId='..fightUIVo.atk_effectId)

	local atk = fightUIVo.atk

	local direction
	if atk then
		direction=atk:getActiveDirection()
	end
  
	-- local uAtk 

	local uAtkSize = #fightUIVo.uAtkArr
	if uAtkSize>0  and atk then
		if fightUIVo.uAtkArr[1].player then
			direction = DirectionUtil.getDireciton(atk:getMapX(),fightUIVo.uAtkArr[1].player:getMapX())				
		end
	end

	if atk then

		atk:stopMove()

		local action = actionManager.Action_Attack
		if fightUIVo.IsCrit then action=actionManager.Action_AttackCrit end
		
		if skillBasicVo.skilltype>=11  then  ---远程大招
			action=actionManager.Action_BigSkill
		end

		atk:runWithDelay(function ()
			-- body
		end, fightUIVo.uAtkDelay)
		

		atk:splay(action,direction,false, 0, function (  )
			
			if rolePlayerManager.canFightPlayer(atk) then
				atk:play(actionManager.Action_Stand,direction)
			end
		end,function (  )
			if rolePlayerManager.canFightPlayer(atk) then
				if not atk.bigSkillOnTrigger then   --没有执行大招
					atk:unLock()
				else 
					if action == actionManager.Action_BigSkill then   ---大招 
						atk.bigSkillOnTrigger = false
						atk:unLock()
					end
				end
			end
		end)
		-- print('atk_fight_Dir:'..direction..','..atk:getActiveDirection())

		fightView.addEffect(atk, atkEffectBasicVoArr)
	end
	
	fightView.handleUAtkArray( fightUIVo )
end




-- 总体表现
function fightView.updateFight(fightUIVo)

	local skillBasicVo = skillBasicManager.getSkill(fightUIVo.skillId)

	local atk = fightUIVo.atk
	local charId = atk.roleDyVo.basicId

	local mType 
	if skillBasicVo.skilltype >= 10 then
		mType = CfgHelper.getCache('roleEffect', 'handbook', charId).effect_type or 1
	else
		mType = skillBasicVo.effect_type
	end

	-- print('skillId = '..fightUIVo.skillId..' ,effectType = '..mType)

	local uAtkDelay
	local uAtkEffectId
	local atkEffectId

	if fightUIVo.IsCrit then
		fightView.showCritLabel( fightUIVo.atk )

		fightUIVo.uAtkDelay = skillBasicVo.red_time[2] or skillBasicVo.red_time[1]
		fightUIVo.uAtk_effectId = skillBasicVo.uAtk_effectId[2] or skillBasicVo.uAtk_effectId[1]
		fightUIVo.atk_effectId = skillBasicVo.atk_effectId[2] or skillBasicVo.atk_effectId[1]
	else
		fightUIVo.uAtkDelay = skillBasicVo.red_time[1]
		fightUIVo.uAtk_effectId = skillBasicVo.uAtk_effectId[1]
		fightUIVo.atk_effectId = skillBasicVo.atk_effectId[1]
	end

	-- if not fightUIVo.atk_effectId or not fightUIVo.uAtk_effectId then
	-- 	print('skillVo')
	-- 	print(skillBasicVo)
	-- end

	assert(fightUIVo.atk_effectId, 'skilid='..fightUIVo.skillId)
	assert(fightUIVo.uAtk_effectId, 'skilid='..fightUIVo.skillId)

	-- local atkEffectBasicVoArr=fightEffectBasicManager.getFightEffectBasicVoArr(skillBasicVo.atk_effectId) --特效表现  --攻击者的特效表现
	-- mType = atkEffectBasicVoArr[1].type

	print('PVP type='..mType..' skill='..fightUIVo.skillId)

	if mType==1 then --近战表现
		fightView.updateFight1(fightUIVo)
	elseif mType==2 then --远程表现
		fightView.updateFight2(fightUIVo)
	elseif mType==3 then --治疗表现
		if skillBasicVo.skilltype == SkillUtil.SkillType_Dance then 
			fightView.updateFight4(fightUIVo)
		else
			fightView.updateFight3(fightUIVo)
		end

	elseif mType == 11 then --全屏大招表现

		fightView.updateFight11(fightUIVo)

	elseif mType == 12 then --连击类型
		fightView.updateFight1(fightUIVo)
	else
		print('ERROR:Unexpected fightType = '..mType)
	end	
end



function fightView.addToLayer( player, direction, layer, model_id, delay)

	Utils.delay(function ( ... )
		-- body
		local view = FightEffectView.create(model_id)
		if view then
			local flipX = RoleSelfManager.getFlipX()
			local isOwnerTeam = player:isOwnerTeam()

			local rootNode = view:getRootNode()

			if isOwnerTeam then
				
			else
				if direction == -1 then
					rootNode:setScaleX(-1)
				end
			end

			layer:addChild( view:getRootNode() )

		end
	end, delay)
	
end

--给玩家添加相应的特效, 非Buff
function fightView.addEffect( player,effectBassicArr )
	if not effectBassicArr then
		return
	end

	for k,effectBasicVo in pairs(effectBassicArr) do
		
		effectBasicVo.model_id = tonumber(effectBasicVo.model_id)

		if effectBasicVo.model_id>0 then

			if effectBasicVo.layer==SkillUtil.Layer_Role_Up then

				-- print('fightView.addFrontEffect '..effectBasicVo.model_id)

				player:addFrontEffect(effectBasicVo.model_id)

			elseif effectBasicVo.layer==SkillUtil.Layer_Role_Down then

				-- print('fightView.addBackEffect '..effectBasicVo.model_id)

				player:addBackEffect(effectBasicVo.model_id)

			elseif effectBasicVo.layer==SkillUtil.Layer_Sky then

				-- print('fightView.addLayer_Sky '..effectBasicVo.model_id)

			elseif effectBasicVo.layer==SkillUtil.Layer_Sky then --

				fightView.addToLayer(player, effectBasicVo.direction,  LayerManager.skyLayer, effectBasicVo.model_id, effectBasicVo.delay)

			elseif effectBasicVo.layer==SkillUtil.Layer_Floor then --地面层级

				--LayerManager.bgSkillLayer:addChild()
				fightView.addToLayer(player, effectBasicVo.direction,  LayerManager.bgSkillLayer, effectBasicVo.model_id, effectBasicVo.delay)

			elseif effectBasicVo.layer == 6 then --角色层级

				--LayerManager.bgSkillLayer:addChild()
				fightView.addToLayer(player, effectBasicVo.direction,  LayerManager.skyLayer, effectBasicVo.model_id, effectBasicVo.delay)
			end
		end

		-- effectBasicVo.action_id = 'Action_shakeEarth1'
		if effectBasicVo.action_id then
			if effectBasicVo.layer == 10 then --震动层级
				fightView.shakeEarth( effectBasicVo.action_id , effectBasicVo.delay)
			end
		end
	end
end


function fightView.shakeEarth( action_id, delay )
	-- body
	if action_id then
		Utils.delay(function ()
			-- body
			-- print('shakeEarth!!')
			local action = ActionFactory.createAction( require(action_id) )
			LayerManager.bgLayer:runAction(action)
		end, delay)
	end
end

function fightView.showCritLabel( atk )
	-- body
	if atk then
		local view = LabelView.createLabelView( LabelUtils.Label_BaoJi )
		if view then
			local node = atk:getRootNode()
			local labelNode = view:getRootNode()
			if labelNode then
				atk:addLabel( labelNode )
			end
		end
	end
end

--处理天空层 地面层特效
-- function fightView.handleLayerEffect(conatiner,model_id,modelTimeArr )
-- 	local skin = 1
-- 	for k,v in pairs(modelTimeArr) do
-- 		skin
-- 		conatiner:addChild(skin)
-- 	end
-- end

--播放飞行道具特效
function fightView.playMoveEffect(skinId,startPos,targetPlayer,speed)
	-- body
	local view =TweenSkill.new()
	view:setSkin(skinId, startPos)
	view:tweenTo(targetPlayer,speed)
end

function fightView.playEmptyMoveEffect(skinId,startPos,targetPos,speed)
	-- local view =TweenSkill.new()
	-- view:setSkin(skinId,startPos)
	-- view:tweenToPos(targetPos,speed)
	local item = EmptyFlyItem.new()
	item:flyTo(skinId,startPos,targetPos,speed)
end

function fightView.findFlyItem( effectBassicArr )
	for k,effectBasicVo in pairs(effectBassicArr) do
		if effectBasicVo.layer==SkillUtil.Layer_FlyTool then
			return effectBasicVo
		end
	end

	print('not findFlyItem')
	print(effectBassicArr)
	print('---------------')
end

-- function fightView.findSkinId( effectBassicArr )
-- 	for k,effectBasicVo in pairs(effectBassicArr) do
-- 		if effectBasicVo.layer==SkillUtil.Layer_FlyTool then
-- 			return effectBasicVo.model_id
-- 		end
-- 	end
-- end

-- require 'NewFlyTool'.createFlyTool(player, skillBasicVo.id, isCrit)

return fightView


