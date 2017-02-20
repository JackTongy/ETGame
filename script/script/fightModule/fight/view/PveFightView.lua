--[[
处理具体的战斗逻辑  
]]
local ActionManager 				= require 'ActionUtil'
local ActionUtil 					= require 'ActionUtil'
local DirectionUtil 				= require 'DirectionUtil'
local RolePlayerManager 			= require 'RolePlayerManager'
local EventCenter 					= require 'EventCenter'
local FightEvent 					= require 'FightEvent'
local SkillBasicManager 			= require 'SkillBasicManager'
local CharactorConfigBasicManager 	= require 'CharactorConfigBasicManager' 
local FightEffectBasicManager 		= require 'FightEffectBasicManager'
local SkillUtil 					= require 'SkillUtil'
local FlyView 						= require "FlyView"
local YFMath 						= require "YFMath"
local UpdateRate 					= require "UpdateRate"
local Utils 						= require "framework.helper.Utils"
local LayerManager 					= require "LayerManager"
local TypeRole 						= require "TypeRole"
local RoleSelfManager 				= require 'RoleSelfManager'
local EmptyFlyItem 					= require 'EmptyFlyItem'
local CfgHelper 					= require 'CfgHelper'
local GridManager 					= require 'GridManager'
local Global 						= require 'Global'

local LabelView = require 'LabelView'
local LabelUtils = require 'LabelUtils'

local FightEffectView = require 'FightEffectView'

local ActionFactory = require 'ActionFactory'
require 'TimeOut'

local BeatBackSpeed = 20


require "TweenSkill"

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

local fightView={}

function fightView.atkCanPlayFight( atk , skillBasicVo  )

	if not RoleSelfManager.isPvp  then
		if skillBasicVo.skilltype >=11 then
			return true
		end
	else     --- pvp   可以进行播放
		return true
	end

	return false
end

function fightView.handleGeWuBuff( player )
	if player then
		if player.roleDyVo.dyId==RoleSelfManager.dyId then
			if player.roleDyVo.isGeWu then
				if RoleSelfManager.isPvp then
					print("处理PVP歌舞")
					EventCenter.eventInput(FightEvent.Pvp_removeGeWuBuff,player)
				else
					print("处理PVE歌舞")
					EventCenter.eventInput(FightEvent.Pve_removeGeWuBuff,player)
				end
			end
		end
	end
end


function fightView.getPositionInScreen( role, node )
	-- body
	if role:getCloth() then
		role:getCloth():addEffectNode(node, true)
		local pos = NodeHelper:getPositionInScreen(node)
		node:removeFromParent()
		return pos
	end
end

----master 发起者 是否反转, 由它决定
function fightView.addEffectById( role, effectId, containsFlyTool, minY, master )
	-- body
	-- if true then
	-- 	return
	-- end
	-- assert(master)

	master = master or role

	if not Global.Battle_Use_View then return true end

	local array = CfgHelper.getCacheArray('fightEffect', 'effectId', effectId)

	if array then
		-- body
		for i,vo in ipairs(array) do
			role:runWithDelay(function ()
				--处理地震
				if vo.layer == SkillUtil.Layer_Earth_Quake then
					fightView.playEarthQuake()
					return
				end

				if vo.layer == SkillUtil.Layer_Sound then
					require 'framework.helper.MusicHelper'.playEffect('raw/'..tostring(vo.model_id))
					return
				end

				if role:isDisposed() or not role:getCloth() then
					return
				end

				--处理飞行道具
				if containsFlyTool and vo.layer == SkillUtil.Layer_FlyTool then
					-- if vo.model_id > 0 then
					-- 	--子弹肯定要反转
					-- 	--这里不处理
					-- end
				end

				--处理特效
				if type(vo.model_id)=='string' or  vo.model_id > 0 then
					--有效的ID
					--特效都是播放完成自动移除

					--处理方向问题
					local scaleX = 1
					local dir = vo.direction
					local myDir = master:getActiveDirection()

					assert(dir == 1 or dir == -1)

					---需要反转
					if dir == -1 then
						if myDir == ActionManager.Direction_Right then
							scaleX = -1
						end
					end

					-- print('')

					local view = FightEffectView.create(vo.model_id)
					local listenerArray = {}

					view:setAutoRemoveFromParent(true, function ()
						-- body
						for i,v in ipairs(listenerArray) do
							v();
						end
					end)

					--加入到一个数组上, 便于在放大招, 或者别冰冻的时候去除攻击者特效
					role:addAtkEffectView( view )

					local rootNode = view:getRootNode()
					rootNode:setScaleX( rootNode:getScaleX() * scaleX )
					-- if type(vo.model_id)=='string' and vo.model_id == '69_atk' then
					-- 	debug.catch(true, ''..vo.model_id)
					-- end

					if vo.layer == SkillUtil.Layer_Role then
						--暂时当做 Layer_Role_Up 处理
						role:getCloth():addEffectNode(rootNode, true)
						-- LayerManager.skyLayer:addChild( view:getRootNode() )

					elseif vo.layer == SkillUtil.Layer_Role_Up then
						--
						role:getCloth():addEffectNode(rootNode, true)
						-- LayerManager.skyLayer:addChild( view:getRootNode() )

					elseif vo.layer == SkillUtil.Layer_Role_Down then 
						--
						role:getCloth():addEffectNode(rootNode, false)
						-- LayerManager.skyLayer:addChild( view:getRootNode() )

					elseif vo.layer == SkillUtil.Layer_Floor then
						--
						LayerManager.bgSkillLayer:addChild( rootNode )

					elseif vo.layer == SkillUtil.Layer_Sky then
						--
						LayerManager.skyLayer:addChild( rootNode )

					elseif vo.layer == SkillUtil.Layer_Role_Y then

						minY = minY or 0

						local node = ElfNode:create()
						LayerManager.roleLayer:addChild(node)
						node:setPosition( ccp(0, minY) )

						local pos = fightView.getPositionInScreen(role, rootNode)
						if pos then
							node:addChild(rootNode)
							NodeHelper:setPositionInScreen(rootNode, pos)

							table.insert(listenerArray, function ()
								-- body
								node:removeFromParent()
							end)
						end
						--清除攻击特效

					--攻击者动机特效, Y跟随攻击者, X水平居中
					elseif vo.layer == SkillUtil.Layer_Role_Y_Stay then
						local px, py = role:getCloth():getRootNode():getPosition()
						rootNode:setPosition(ccp( -px, 0))
						role:getCloth():addEffectNode(rootNode, true)

					elseif vo.layer == SkillUtil.Layer_Role_Sky then
						--
						local pos = fightView.getPositionInScreen(role, rootNode)
						if pos then
							LayerManager.skyLayer:addChild(rootNode)
							NodeHelper:setPositionInScreen(rootNode, pos)
						end

					end

				end
			end,  vo.delay )
		end
	end
end

---处理攻击者
function fightView.handleAtk( fightUIVo )
	-- body
	local effectIdArray = fightView.getEffectIdArray(fightUIVo, true) 
	local atk = fightUIVo.atk

	if effectIdArray then
		for i,effectId in ipairs(effectIdArray) do
			--
			fightView.addEffectById( atk, effectId, nil, nil, atk )
		end
	end
end

function fightView.handleAtkByRoleAndSkill( role, arr, skillId, crit )
	-- body
	if not Global.Battle_Use_View then return true end

	local effectIdArray = fightView.getEffectIdArrayByRoleAndSkill( role, skillId, crit, true ) 
	local atk = role
	
	if effectIdArray then
		local minY = 2000
		for i,v in ipairs(arr) do
			--
			local cloth = v:getCloth()

			local pos = cloth and cloth:getPosition()
			if pos then
				local y = pos.y
				if y < minY then
					minY = y
				end
			end	
		end

		minY = minY - 1

		for i,effectId in ipairs(effectIdArray) do
			fightView.addEffectById( atk, effectId, true, minY, atk )
		end

		---攻击者特效 加在被攻击者身上
		do
			local specailArray = {}

			for i,effectId in ipairs(effectIdArray) do
				-- fightView.addEffectById( atk, effectId, true, minY )
				local array = CfgHelper.getCacheArray('fightEffect', 'effectId', effectId)
				for ii, vo in ipairs(array) do
					if vo.layer == SkillUtil.Layer_Target_Up then
						table.insert(specailArray, vo)
					end
				end
			end

			local spanTime = fightView.getSkillSpanTime( { atk = role, skillId = skillId } )

			for i, vo in ipairs (specailArray) do

				for ii, target in ipairs(arr) do
					--不包含 飞行道具
					fightView.addEffectById( atk, effectId, false, minY, atk )

					role:runWithDelay(function ()

						if target:isDisposed() or not target:getCloth() then
							return
						end

						--处理特效
						if type(vo.model_id)=='string' or  vo.model_id > 0 then
							--有效的ID
							--特效都是播放完成自动移除

							--处理方向问题
							local scaleX = 1
							local dir = vo.direction
							local myDir = atk:getActiveDirection()
					
							assert(dir == 1 or dir == -1)

							---需要反转
							if dir == -1 then
								if myDir == ActionManager.Direction_Right then
									scaleX = -1
								end
							end

							local view = FightEffectView.create(vo.model_id)
							local listenerArray = {}

							view:setAutoRemoveFromParent(true, function ()
								-- body
								for i,v in ipairs(listenerArray) do
									v();
								end
							end)

							--加入到一个数组上, 便于在放大招, 或者别冰冻的时候去除攻击者特效
							-- role:addAtkEffectView( view ) 

							local rootNode = view:getRootNode()
							rootNode:setScaleX( rootNode:getScaleX() * scaleX )

							--类似当做 Layer_Role_Up 处理
							target:getCloth():addEffectNode(rootNode, true)
						end
					end,  vo.delay + (ii-1)*spanTime )

				end
			end
		end
	end
end

--[[
对除了飞行道具以外的受击都一样
--]]
function fightView.handleUnderAtk( fightUIVo )
	-- body
	-- uatk -> false
	-- atk  -> true
	local effectIdArray = fightView.getEffectIdArray(fightUIVo, false) 
	--技能攻击时间间隔
	local spanTime = fightView.getSkillSpanTime(fightUIVo)

	local atk = fightUIVo.atk

	for i,uAtkInfo in ipairs(fightUIVo.uAtkArr) do
		local uAtk = uAtkInfo.player
		local uAtkHpD = uAtkInfo.hp
		local uAtkHpP = uAtkInfo.hpPercent

		if uAtk then

			uAtk:runWithDelay(function ()
				-- body
				if RolePlayerManager.usablePlayer(uAtk) then	---有效的 player

					if uAtkHpP>0 then		-- 受击动画
						if uAtkInfo.pos and uAtk:isAIStarted() and not uAtk:isSkillActionLocked() then  -- 击退

							--被击退
							fightView.handleGeWuBuff(uAtk)

							local dir = uAtk:getActiveDirection()	
							if atk then
								dir = DirectionUtil.getDireciton(uAtk:getMapX(),atk:getMapX())
							end

							uAtk:splay(ActionManager.Action_BeatBack,dir,false, 0, function( )
								--
							end)
							
							uAtk:setBeatbackLocked()
							uAtk:pureMoveToPos(uAtkInfo.pos, BeatBackSpeed, function ()
								-- print('moveCompleteDir2222=')
								if RolePlayerManager.canFightPlayer(uAtk) then
									print("moveCompleteDir="..uAtk:getActiveDirection())
									uAtk:play(ActionManager.Action_Stand,dir,true,nil,true)
								end
								
							end)

							-- 1/30
							local dis = math.abs(uAtkInfo.pos.x - uAtk:getPosition().x )
							local btbTime = dis / ( BeatBackSpeed/require 'FightTimer'.getFrameInterval() )
							uAtk:runWithDelay(function ()
								-- body
								uAtk:unLockBeatback()
							end, btbTime)

						end

						uAtk:updateBloodPercent(uAtkInfo.hpPercent, uAtkInfo.hp, fightUIVo.skillId, fightUIVo.IsCrit)

					else
						if uAtk.roleDyVo.dyId == RoleSelfManager.dyId then   --为自己 ，死亡的时候不能拖动
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
					if effectIdArray then
						for ii, effectId in ipairs(effectIdArray) do
							fightView.addEffectById( uAtk, effectId, nil, nil, atk )
						end
					end
				end

			end, fightUIVo.uAtkDelay + (i-1)*spanTime )
		end
	end
end


function fightView.getSkillSpanTime( fightUIVo )
	-- body
	local skillBasicVo = SkillBasicManager.getSkill(fightUIVo.skillId)
	local atk = fightUIVo.atk
	local charId = atk.roleDyVo.basicId

	--大招才有
	if skillBasicVo.skilltype >= 10 then
		return CfgHelper.getCache('roleEffect', 'handbook', charId, 'skill_in_time') or 0
	end

	return 0
end

function fightView.getEffectIdArrayByRoleAndSkill( role, skillId, crit, isAtkOrUAtk )
	if not role then
		debug.catch(true, 'getEffectIdArrayByRoleAndSkill no role!')
		return
	end

	local skillBasicVo = SkillBasicManager.getSkill(skillId)
	local charId = role.roleDyVo.basicId

	local keys = { 
		'natk_effectID',		'B_natk_effectID',			'B_natk_time',			--近战
		'crit_effectID',		'B_crit_effectID', 			'B_crit_time',			--近战暴击
		'remote_effectID',		'B_remote_effectID', 		'flight_time',			--远程
		'crit_remote_effectID',	'B_crit_remote_effectID', 	'crit_flight_time',		--远程暴击
		'cure_effectID',		'B_cure_effectID', 			'B_cure_time',			--治疗
		'skill_effectID',		'B_skill_effectID', 		'B_skill_time',			--大招
	}

	local index
	
	if skillBasicVo.skilltype == SkillUtil.SkillType_JinZhan then
		index = 1 + 0 + ((crit and 3) or 0) + ((isAtkOrUAtk and 0) or 1)
	elseif skillBasicVo.skilltype ==4 then --远程近战
		index = 1 + 0 + ((crit and 3) or 0) + ((isAtkOrUAtk and 0) or 1)
	elseif skillBasicVo.skilltype == SkillUtil.SkillType_YuanCheng then
		index = 1 + 6 + ((critand and 3) or 0) + ((isAtkOrUAtk and 0) or 1)
	elseif skillBasicVo.skilltype == SkillUtil.SkillType_ZiLiao then 
		index = 1 + 12 + ((isAtkOrUAtk and 0) or 1)
	elseif skillBasicVo.skilltype >= 10 then 				--大招
		index = 1 + 15 + ((isAtkOrUAtk and 0) or 1)
	end

	-- print('charId='..charId)
	-- print('skillId='..skillId)
	-- print('index='..index)
	-- print('keyId='..keys[index])

	local effectIdArray = CfgHelper.getCache( 'roleEffect', 'handbook', charId, keys[index] )

	-- if effectIdArray then
	-- 	for i,v in ipairs(effectIdArray) do
	-- 		print('effectId = '..v)
	-- 	end
	-- end

	-- return (type(effectIdArray) == 'table') and effectIdArray
	return effectIdArray
end
--[[

--]]
function fightView.getEffectIdArray( fightUIVo, isAtkOrUAtk )
	-- body
	return fightView.getEffectIdArrayByRoleAndSkill(fightUIVo.atk, fightUIVo.skillId, fightUIVo.IsCrit, isAtkOrUAtk)
end

function fightView.updateFight1( fightUIVo )

	fightView.handleUnderAtk( fightUIVo )
end


--飞行道具表现

--Pve下的远程表现
function fightView.updateFight2(fightUIVo)

	local skillBasicVo = SkillBasicManager.getSkill(fightUIVo.skillId)

	local atkEffectBasicVoArr=FightEffectBasicManager.getFightEffectBasicVoArr(fightUIVo.atk_effectId) --特效表现  --攻击者的特效表现
	local uAtkEffectbasicVoArr=FightEffectBasicManager.getFightEffectBasicVoArr(fightUIVo.uAtk_effectId) --特效表现   受击者的特效表现
	
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

	for i,uAtkInfo in ipairs(fightUIVo.uAtkArr) do
		local uAtk = uAtkInfo.player

		if RolePlayerManager.canFightPlayer(uAtk) then	---有效的 player
			
			--放到延迟上进行
			local arriveTime = 0 --飞行时间
			

			-- local offsetTime = -flyDelay*1000 --ms
			if uAtkInfo.hpPercent>0  then		-- 受击动画
				-- print("处理飞行道具受击")
				if not uAtkInfo.pos then
					-- print("没有击退")
					local inJureAction =  nil --ActionManager.Action_Injure
					local uAtCharactorConfig = CharactorConfigBasicManager.getCharactorBasicVo(uAtk.roleDyVo.basicId)
					-- print("远程=="..uAtk.roleDyVo.playerId)
					-- print(skillBasicVo.skilltype)
					-- print(uAtCharactorConfig.atk_method_system)

					if uAtCharactorConfig.atk_method_system==TypeRole.Career_QiShi and skillBasicVo.skilltype==SkillUtil.SkillType_YuanCheng and not uAtk:isSkillActionLocked() then  --远程大招不格挡
						inJureAction = ActionManager.Action_GeDang
						print("产生格挡")
					end

					--暂时不播放受击动画
					if inJureAction == ActionManager.Action_GeDang then
						--格挡动画
						-- print("格挡动画")
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
							uAtk:unLockGeDang()
							uAtk:resumeQiShi()
						end)
					end

				elseif uAtk:isAIStarted() then 
					-- 击退
					fightView.handleGeWuBuff(uAtk)

					print("处理击退111")
					local dir = uAtk:getActiveDirection()	
					print("dir=="..dir)
					if atk then
						print(uAtk:getMapX())
						print(atk:getMapX())

						dir=DirectionUtil.getDireciton(uAtk:getMapX(),atk:getMapX())
						print("dir222=="..dir)
					end
					uAtk:splay(ActionManager.Action_BeatBack,dir,false, arriveTime * 1000,function( )
						-- if RolePlayerManager.canFightPlayer(uAtk) then
						-- 	uAtk:play(ActionManager.Action_Stand,uAtk:getActiveDirection(),true,nil,true)
						-- end
					end)
					-- print("处理pureMoveTo:"..waitTime)

					local timeOut = TimeOut.new(arriveTime, function(  )
						-- print("处理pureMoveTo22")
						uAtk:setBeatbackLocked()
						uAtk:pureMoveToPos(uAtkInfo.pos, BeatBackSpeed,  function ( )
							if RolePlayerManager.canFightPlayer(uAtk) then
								uAtk:play(ActionManager.Action_Stand,dir,true,nil,false)
							end
						end)

						-- 1/30
						local dis = math.abs(uAtkInfo.pos.x - uAtk:getPosition().x )
						local btbTime = dis / ( BeatBackSpeed/require 'FightTimer'.getFrameInterval() )
						uAtk:runWithDelay(function ()
							-- body
							uAtk:unLockBeatback()
						end, btbTime)
					end)

					timeOut:start()
				end
				
				local timeOut = TimeOut.new(arriveTime, function(  )
					uAtk:updateBloodPercent(uAtkInfo.hpPercent, uAtkInfo.hp, fightUIVo.skillId, fightUIVo.IsCrit)
				end)
				timeOut:start()

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
				local effectIdArray = fightView.getEffectIdArray(fightUIVo, false) 
				if effectIdArray then
					for ii, effectId in ipairs(effectIdArray) do
						fightView.addEffectById( uAtk, effectId, nil, nil, atk )
					end
				end
			end, arriveTime)
			
		end
	end
end

--治疗战斗表现
function fightView.updateFight3( fightUIVo )
	-- body
	fightView.handleUnderAtk( fightUIVo )
end


----歌舞吟唱战斗表现
function fightView.updateFight4( fightUIVo )
	-- body
	fightView.handleUnderAtk( fightUIVo )
end


--全屏大招类表现
function fightView.updateFight11( fightUIVo )
	-- body
	local skillBasicVo = SkillBasicManager.getSkill(fightUIVo.skillId)

	local uAtkEffectbasicVoArr = FightEffectBasicManager.getFightEffectBasicVoArr(fightUIVo.uAtk_effectId) --特效表现   受击者的特效表现

	local atk = fightUIVo.atk
 	
	local direction
	if atk then
		direction=atk:getActiveDirection()
	end
  	
	local uAtkSize = #fightUIVo.uAtkArr
	if uAtkSize>0  and atk then
		if fightUIVo.uAtkArr[1].player then
			direction = DirectionUtil.getDireciton(atk:getMapX(),fightUIVo.uAtkArr[1].player:getMapX())				
		end
	end

	fightView.handleUnderAtk( fightUIVo )
end




-- 总体表现
function fightView.updateFight(fightUIVo)

	local skillBasicVo = SkillBasicManager.getSkill(fightUIVo.skillId)
	-- local 
	local atk = fightUIVo.atk
	-- assert(atk)

	local charId = (atk and atk.roleDyVo.basicId) or fightUIVo.basicId

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

		fightUIVo.uAtkDelay = 0
		fightUIVo.uAtk_effectId = skillBasicVo.uAtk_effectId[2] or skillBasicVo.uAtk_effectId[1]
		fightUIVo.atk_effectId = skillBasicVo.atk_effectId[2] or skillBasicVo.atk_effectId[1]
	else
		fightUIVo.uAtkDelay = 0
		fightUIVo.uAtk_effectId = skillBasicVo.uAtk_effectId[1]
		fightUIVo.atk_effectId = skillBasicVo.atk_effectId[1]
	end

	-- if not fightUIVo.atk_effectId or not fightUIVo.uAtk_effectId then
	-- 	print('skillVo')
	-- 	print(skillBasicVo)
	-- end

	assert(fightUIVo.atk_effectId, 'skilid='..fightUIVo.skillId)
	assert(fightUIVo.uAtk_effectId, 'skilid='..fightUIVo.skillId)

	-- local atkEffectBasicVoArr=FightEffectBasicManager.getFightEffectBasicVoArr(skillBasicVo.atk_effectId) --特效表现  --攻击者的特效表现
	-- mType = atkEffectBasicVoArr[1].type
	
	if mType==1 then --近战表现
		fightView.updateFight1(fightUIVo)
	elseif mType==2 then --远程表现
		fightView.updateFight2(fightUIVo)
	elseif mType==3 then --治疗表现
		fightView.updateFight3(fightUIVo)

	elseif mType == 11 then --全屏大招表现
		
		fightView.updateFight11(fightUIVo)
	elseif mType == 12 then --连击类型
		fightView.updateFight1(fightUIVo)
	else
		print('ERROR:Unexpected fightType = '..mType)
	end	
end


function fightView.playEarthQuake()
	-- body
	if not Global.Battle_Use_View then return true end

	LayerManager.playEarthQuake()
end

function fightView.showCritLabel( atk )
	-- body
	if not Global.Battle_Use_View then return true end

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

function fightView.showWuDiLabel( player )
	-- body
	if not Global.Battle_Use_View then return true end

	-- debug.catch('true', 'showWuDiLabel')
	
	if player then
		local view = LabelView.createLabelView( LabelUtils.Label_WuDi )
		if view then
			local node = player:getRootNode()
			local labelNode = view:getRootNode()
			if labelNode then
				player:addLabel( labelNode )
			end
		end
	end
end


--播放飞行道具特效
function fightView.playMoveEffect(skinId,startPos,targetPlayer,speed)
	-- body
	local view = TweenSkill.new()
	view:setSkin(skinId, startPos)
	view:tweenTo(targetPlayer, speed)
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
		if effectBasicVo.layer == SkillUtil.Layer_FlyTool then
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

return fightView


