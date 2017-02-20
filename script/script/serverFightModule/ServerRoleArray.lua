local RoleArrayClass = class()
local access = require 'ServerAccess'

local EventCenter 		= require 'EventCenter'
local FightEvent 		= require 'FightEvent'
local SkillUtil 		= require 'SkillUtil'
local Random 			= require 'Random'
local GHType 			= require 'GHType'
local GridManager 		= require 'GridManager'
local TypeRole			= require 'TypeRole'

-- SkillUtil.Condition_Calc = 1
-- SkillUtil.Condition_HpEqual = 2
-- SkillUtil.Condition_HpLittle = 3
-- SkillUtil.Condition_HpGreater = 4
-- SkillUtil.Condition_FightRound = 5
-- SkillUtil.Condition_FightBossRound = 6
-- SkillUtil.Condition_OnBattleField = 7
-- SkillUtil.Condition_OnBenchFiled = 9
-- SkillUtil.Condition_BattleFieldType = 8
-- SkillUtil.Condition_KillAnEnemy = 10
-- SkillUtil.Condition_LoseAFriend = 11
-- SkillUtil.Condition_WhatEver = 12
-- SkillUtil.Condition_OnFightCrit = 13
-- SkillUtil.Condition_OnFightNormal = 14
-- SkillUtil.Condition_OnFightNormalAndKill = 15
-- SkillUtil.Condition_Win = 16

local TriggerAbilityEvent = function ( role,conditiontype,defenders )
	defenders = defenders or {}	
	local mydata = {
		conditiontype = true,
		openorclose = true,
		attacker = true,
		defenders = true,
		crit = true,
	}
	mydata.conditiontype = conditiontype
	mydata.openorclose = true
	mydata.attacker = role
	mydata.defenders = defenders
	mydata.crit = false
	EventCenter.eventInput(FightEvent.TriggerAbility,mydata)

end

function RoleArrayClass:ctor()
	-- body
	self.array = {}

	self.npc = require 'ServerSystemRole'.createSystemRole()
	self.initTimeMillis = require 'FightTimer'.currentFightTimeMillis()
	self._LastSceonds = {}
	--role Id 2 role
	-- self._roleMap = {}
end

--已经生成的英雄数组
--获取player数组
function RoleArrayClass:getPlayerArr(  )
	return self.array
end

function RoleArrayClass:addRole( role )
	-- body
	-- print( 'RoleArrayClass:addRole '..role:getDyId() )
	-- debug.catch(true)
	table.insert(self.array, role)
end

function RoleArrayClass:getHeroArray(  )
	-- body
	local myarray = {}
	for i,v in ipairs(self.array) do 
		-- if not v:isDisposed() and not v:isMonster() then
		if not v:isMonster() then
			table.insert(myarray, v)
		end
	end
	return myarray
end

function RoleArrayClass:getMonsterArray(  )
	-- body
	local myarray = {}
	for i,v in ipairs(self.array) do 
		-- if not v:isDisposed() and v:isMonster() then
		if v:isMonster() then
			table.insert(myarray, v)
		end
	end
	return myarray
end

function RoleArrayClass:getNpc()
	-- body
	return self.npc
end

function RoleArrayClass:findRoleByDyIdAnyway( dyid )
	-- body
	if dyid == -1 then
		return self.npc
	end

	-- local role = self._roleMap[dyid]

	for i,v in pairs(self.array) do 
		if v:getDyId() == dyid then
			-- self._roleMap[dyid] = v
			return v
		end
	end
end


function RoleArrayClass:findRoleByDyId( dyid )
	-- body
	assert( type(dyid) == 'number' )

	if dyid == -1 then
		return self.npc
	end

	for i,v in pairs(self.array) do 
		-- if not v:isDisposed() then
			if v:getDyId() == dyid then
				return v
			end
		-- end
	end

	-- for i,v in pairs(self.array) do 
	-- 	if v:isDisposed() then
	-- 		if v:getDyId() ==dyid then
	-- 			print('find wrong role')
	-- 			print(dyid)
	-- 			print('---------------')
	-- 			break
	-- 		end
	-- 	end
	-- end 

	-- assert(false, 'no such dyid in ')
	-- error(string.format('No such dyid %s in role array!', tostring(dyid)))
end

function RoleArrayClass:check()
	-- body
	local size = #(self.array)
	for i=size,1,-1 do 
		local role = self.array[i]
		if role:couldRemove() then
			table.remove(self.array, i)
		end
	end
end

function RoleArrayClass:dealSkillResult( result )
	-- body
end

--被动技能触发
function RoleArrayClass:onSkillConditionByRole(role, conditiontype, openorclose , outDefenders, crit, carryData )
	-- body
	-- print('conditiontype = '..tostring(conditiontype))
	-- print('carryData = '..tostring(carryData))

	local roleDyId = role:getDyId()
	local skillarray = role:getSkillArray():getArray()
	for ii, skill in ipairs(skillarray) do 
		
		if skill:isOnCondition(conditiontype) and skill:onRate() then
			local defenders

			assert(skill.skillcondition)
			assert(skill.target)

			-- SkillUtil.Condition_OnBenchFiled
			--触发条件是替补席上
			--选择目标类型是当前目标
			if skill.target == SkillUtil.SkillTarget_CurrentTarget or skill.skillcondition == SkillUtil.Condition_OnBenchFiled then
				defenders = outDefenders

				-- print('skill--------')
				-- print(skill)
				-- print('conditiontype='..conditiontype)
				-- print('roleDyId='..roleDyId)
				-- print('skillId='..skill:getBasicId())

				-- assert(defenders)

				-- if not defenders then
				-- 	defenders = {}
				-- 	local roleIdArray = access.select(roleDyId, skill:getBasicId())
				-- 	for iii,vvv in ipairs(roleIdArray) do 
				-- 		local myrole = self:findRoleByDyId( vvv )

				-- 		if myrole then
				-- 			table.insert(defenders, myrole)
				-- 		else
				-- 			--roleid = -1
				-- 			print('onSkillConditionByRole:')
				-- 			print('conditiontype='..conditiontype)
				-- 			print('roleDyId='..roleDyId)
				-- 			print('skillId='..skill:getBasicId())
				-- 			print('should not here: error id='..vvv)
				-- 			-- print(self.array)
				-- 		end
						
				-- 	end
				-- end
			else
							-- if not defenders then
				defenders = {}

				local roleIdArray = access.select(roleDyId, skill:getBasicId())

				for iii,vvv in ipairs(roleIdArray) do 
					local myrole = self:findRoleByDyIdAnyway( vvv )

					if myrole then
						table.insert(defenders, myrole)
					else
						--roleid = -1
						print('onSkillConditionByRole:')
						print('conditiontype='..conditiontype)
						print('roleDyId='..roleDyId)
						print('skillId='..skill:getBasicId())
						print('should not here: wrong id='..vvv)
						-- print(self.array)
					end
				end

			end

			local args = { attacker = role, defenders = defenders }
			local result = skill:onCondition( conditiontype, args, openorclose, carryData )

			-- print('被动结果')
			-- print(result)

			if result then
				local Vs = {}

				for i,v in ipairs(result.buffadd) do 
					local d = defenders[i] 

					for ii,vv in ipairs(v) do 
						-- 免疫 合并 增加

						local addRet = d:getBuffArray():addBuff( vv )

						local data = {
							Id = true,
							Hid = true,
							Speed = true,
							HpD = true,
							HpP = true,
							State = true,
							Sid = true,
							IsCrit = true,
						}
						data.Id = vv:getBasicId()
						data.Hid = d:getDyId()
						data.Speed = d:getSpeed()

						--增加Buff HpD 为 0
						data.HpD = nil
						data.HpP = d:getHpP()

						-- assert(data.HpP < 100)

						-- if addRet == 'imm' then
						-- elseif addRet == 'add' then
						-- elseif addRet == 'merge' then
						-- end

						data.State = addRet

						data.Sid = skill:getBasicId()
						data.IsCrit = crit
						
						table.insert(Vs, data)
					end
				end

				if Vs[1] then
					local bb = { D = { Vs = Vs } }
					print('PVE-Server被动:AddBuff')
					print(bb)

					EventCenter.eventInput( FightEvent.Pve_Buff, bb )
				end


				for i,v in ipairs(result.buffrem) do 
					local d = defenders[i]

					for ii,vv in ipairs(v) do
						local remSuc = d:getBuffArray():remBuffById( vv )

						if remSuc then
							--推送
							local data = {
								Id = true,
								Hid = true,
								Speed = true,
								Sid = true,
								IsCrit = true,
							}
							data.Id = vv
							data.Hid = d:getDyId()
							data.Speed = d:getSpeed()

							data.Sid = skill:getBasicId()
							data.IsCrit = crit

							print('PVE-Server被动:RemoveBuff:'..role:getDyId()..'->'..d:getDyId()..','..vv:getBasicId())
							print(data)

							EventCenter.eventInput( FightEvent.Pve_RemoveBuff, { D = data } )
						else

						end
					end
				end

				if defenders then
					for i,d in ipairs(defenders) do
						d:forceRefreshAtkSpd()
					end
				end
			end
		end
	end
end

function RoleArrayClass:onSkillConditionByRole2(role, conditiontype, openorclose , outDefenders, crit, carryData )
	if conditiontype and outDefenders then
		for k,v in pairs(outDefenders) do
			self:onSkillConditionByRole(v,conditiontype,openorclose,{role},crit,carryData)
		end
	end
end

function RoleArrayClass:updateRole( timetick )
	-- body
	local size = #self.array
	for i=size,1,-1 do
		local role = self.array[i]
		if role:couldRemove() then
			table.remove(self.array, i)
		else
			if role:isBorned() then
				role:update(timetick) 
			end
		end
	end
	-- for i, role in ipairs(self.array) do 
	-- 	role:update(timetick) 
	-- end
end

function RoleArrayClass:updateBuff( timetick )
	-- body
	for i, v in ipairs(self.array) do 
		local buffarray = v:getBuffArray()
		if buffarray then
			buffarray:update(timetick, v)
		end
	end
end

--[[
伤害计算
args.Hid
args.Sid
args.Hids  []
args.ManaRate
T 

Action

Hid Int 英雄 Id
Sid Int 技能 Id
Es ActionEffect[] 受影响的英雄变化数据
Ss Int[] 消耗能量球列表

ActionEffect

Hid Int 受影响的英雄 Id
HpD Int 暴血量
HpP Int 剩余血量的百分比
MoveTo Int[] 击飞移动的坐标点
--]]
function RoleArrayClass:battleCalc( args )
	-- body
	-- print('battleCalc')
	-- print(args)

	local role = self:findRoleByDyIdAnyway( args.Hid )
	
	-- ppp('--------治疗------')
	local defenders = {}

	for i,v in ipairs(args.Hids) do 
		local d = self:findRoleByDyIdAnyway( v )
		-- assert(d, 'v='..v)
		if d then
			table.insert(defenders, d)
		else
			-- print('已经死亡 roleid='..v)
		end
	end
	-- ppp('--------------------')

	--如果攻击者都不存在了...
	if not role then
		-- print('-----------------------')
		-- print('roleid='..args.Hid..'已经删除')
		-- print('-----------------------')
		local ret = {
			Hid = true,
			Sid = true,
			Ss = true,
			Es = true,
		}

		ret.Hid = args.Hid
		ret.Sid = args.Sid
		ret.Ss = {}
		ret.Es = {}

		for i,v in ipairs(defenders) do
			local ae = {
				Hid = true,
				HpD = true,
				Hpp = true,
			}
			ae.Hid = v:getDyId()
			ae.HpD = 0
			ae.HpP = v:getHpP()
			ret.Es[i] = ae
		end

		EventCenter.eventInput( FightEvent.Pve_Action, { D = ret } )
		return 
	end

	local isMonster = role:isMonster()

	-- print('role')
	-- print(role)

	local skill = role:getSkillArray():findSkillByBasicId( args.Sid )

	if not skill then
		print('RoleArrayClass:battleCalc')
		print(args)

		print('role='..tostring(role:getBasicId()))
		print('args.Sid='..tostring( args.Sid ))
		print('skill='..tostring(skill))
	end

	assert(skill)

	-- if #defenders == 0 then
	-- 	print('-------')
	-- 	print('RoleArrayClass:battleCalc')
	-- 	print(args)

	-- 	print('role='..tostring(role:getBasicId()))
	-- 	print('args.Sid='..tostring( args.Sid ))
	-- 	print('skill='..tostring(skill))
	-- 	print('no defenders!')
	-- end
	local myargs = { attacker=role, defenders = defenders }

	--计算是否暴击
	local isCrit = args.IsCrit or false

	-- if skill:isActiveSkill() then
	-- 	if skill.skilltype == SkillUtil.SkillType_JinZhan or skill.skilltype == SkillUtil.SkillType_YuanCheng or skill.skilltype == SkillUtil.SkillType_YuanChengJinZhan then
	-- 		isCrit = ( Random.ranF() < (role.cri or 0) ) 
	-- 	end
	-- end

	-- SkillUtil.Condition_BeforeFightCrit = 18
	-- SkillUtil.Condition_BeforeFightNormal = 19
	-- SkillUtil.Condition_BeforeFightSkill = 20
	self:timeCountCondition(role,defenders)
	self:noticeBeforeCalc(role,defenders)

	if isCrit then

		--暴击时触发
		local mydata = {
			conditiontype = true,
			openorclose = true,
			attacker = true,
			defenders = true,
			crit = true,
		}
		mydata.conditiontype = SkillUtil.Condition_BeforeFightCrit
		mydata.openorclose = true
		mydata.attacker = role
		mydata.defenders = defenders
		mydata.crit = true

		EventCenter.eventInput(FightEvent.TriggerAbility, mydata)

	elseif skill:isNormalAttack() then
		--普通攻击
		local mydata = {
			conditiontype = true,
			openorclose = true,
			attacker = true,
			defenders = true,
			crit = true,
		}
		mydata.conditiontype = SkillUtil.Condition_BeforeFightNormal
		mydata.openorclose = true
		mydata.attacker = role
		mydata.defenders = defenders
		mydata.crit = false

		EventCenter.eventInput(FightEvent.TriggerAbility, mydata)

		--
		local tmpdefenders = {}
		local qishi = {}
		for k,v in pairs(defenders) do
			
			if v.career == TypeRole.Career_ZhanShi or v.career == TypeRole.Career_QiShi then
				table.insert(tmpdefenders,v)
			end

			if v.career == TypeRole.Career_QiShi then
				table.insert(qishi,v)
			end
		end

		if #tmpdefenders > 0 then
			local mydata1 = {
				conditiontype = true,
				openorclose = true,
				attacker = true,
				defenders = true,
				crit = true,
			}
			mydata1.conditiontype = SkillUtil.Condition_BeforeFightNormalGK
			mydata1.openorclose = true
			mydata1.attacker = role
			mydata1.defenders = tmpdefenders
			mydata1.crit = false
			EventCenter.eventInput(FightEvent.TriggerAbility,mydata1)
		end
		
		if #qishi > 0 then
			local mydata3 = {
				conditiontype = true,
				openorclose = true,
				attacker = true,
				defenders = true,
				crit = true,
			}
			mydata3.conditiontype = SkillUtil.Condition_33
			mydata3.openorclose = true
			mydata3.attacker = role
			mydata3.defenders = tmpdefenders
			mydata3.crit = false
			EventCenter.eventInput(FightEvent.TriggerAbility,mydata3)
		end

		local mydata2 = {
			conditiontype = true,
			openorclose = true,
			attacker = true,
			defenders = true,
			crit = true,
		}
		mydata2.conditiontype = SkillUtil.Condition_BeNormalAttacked
		mydata2.openorclose = true
		mydata2.attacker = role
		mydata2.defenders = defenders
		mydata2.crit = false

		EventCenter.eventInput(FightEvent.TriggerAbilityDef,mydata2)

		--远程 治疗
		local tmpdefenders = {}
		for k,v in pairs(defenders) do
			if v.career == TypeRole.Career_YuanCheng or v.career == TypeRole.Career_ZiLiao then
				table.insert(tmpdefenders,v)
			end
		end
		TriggerAbilityEvent(role,SkillUtil.Condition_RoleTypeYuanChengZiLiao,tmpdefenders)

	elseif skill:isNormalCure() then
		--普通治疗
		local mydata = {
			conditiontype = true,
			openorclose = true,
			attacker = true,
			defenders = true,
			crit = true,
		}
		mydata.conditiontype = SkillUtil.Condition_BeforeFightCure
		mydata.openorclose = true
		mydata.attacker = role
		mydata.defenders = defenders
		mydata.crit = false

		EventCenter.eventInput(FightEvent.TriggerAbility, mydata)
		
	elseif skill:isBigSkill() then
		--主动技能释放
		local mydata = {
			conditiontype = true,
			openorclose = true,
			attacker = true,
			defenders = true,
			crit = true,
		}
		mydata.conditiontype = SkillUtil.Condition_BeforeFightSkill
		mydata.openorclose = true
		mydata.attacker = role
		mydata.defenders = defenders
		EventCenter.eventInput(FightEvent.TriggerAbility, mydata)
	end
	
	--触发战斗技能
	local manaRate = args.ManaRate
	local result = skill:onFightCondition(1, myargs, isCrit, manaRate )

	-- local result = skill:onCondition(1, myargs, true )
	-- result.cri = true
	--buffadd, buffrem, hurt
	if not result then
		print('RoleArrayClass:battleCalc222')
		print(args)

		print('role='..tostring(role:getBasicId()))
		print('args.Sid='..tostring( args.Sid ))
		print('skill='..tostring(skill))

		print(skill)
	end
	assert(result)

	--
	--推送
	local Vs = {}

	for i,v in ipairs(result.buffadd) do 
		local d = defenders[i] 
		for ii,vv in ipairs(v) do 
			-- 免疫 合并 增加
			local addRet = d:getBuffArray():addBuff( vv )

			local data = {
				Id = true,
				Hid = true,
				Speed = true,
				HpD = true,
				HpP = true,
				State = true,
				Sid = true,
				IsCrit = true,
			}

			data.Id = vv:getBasicId()
			data.Hid = d:getDyId()
			data.Speed = d:getSpeed()

			--增加Buff HpD 为 0
			data.HpD = nil
			data.HpP = d:getHpP()

			-- if addRet == 'imm' then
			-- elseif addRet == 'add' then
			-- elseif addRet == 'merge' then
			-- end

			data.State = addRet

			data.Sid = args.Sid
			data.IsCrit = result.cri 
			
			-- print(data)
			table.insert(Vs, data)
		end		
	end

	--存在addBuff的情况
	if Vs[1] then
		local bb = { D = { Vs = Vs } }
		print('PVE-Server主动:AddBuff')
		print(bb)
		EventCenter.eventInput( FightEvent.Pve_Buff, bb )
	end

	for i,v in ipairs(result.buffrem) do 
		local d = defenders[i]

		for ii,vv in ipairs(v) do
			local remSuc = d:getBuffArray():remBuffById( vv )

			if remSuc then
				--推送
				local data = {
					Id = true,
					Hid = true,
					Speed = true,
					Sid = true,
					IsCrit = true,
				}

				data.Id = vv
				data.Hid = d:getDyId()
				data.Speed = d:getSpeed()

				data.Sid = args.Sid
				data.IsCrit = result.cri 

				-- print('PVE-Server:RemoveBuff')
				print('PVE-Server:主动 RemoveBuff:'..role:getDyId()..'->'..d:getDyId()..','..vv)
				print(data)
				EventCenter.eventInput( FightEvent.Pve_RemoveBuff, { D = data } )
			end
		end
	end

	-- if result.hurt then
	-- 	for i,d in ipairs(defenders) do
	-- 		local hurtValue = result.hurt[i]
	-- 		--移除冻结
	-- 		if hurtValue < 0 then
	-- 			--42 为冻结 Buff
	-- 			local vv = 42
	-- 			local remSuc = d:getBuffArray():remBuffById( vv )

	-- 			if remSuc then
	-- 				--推送
	-- 				local data = {}
	-- 				data.Id = vv
	-- 				data.Hid = d:getDyId()

	-- 				data.Sid = args.Sid
	-- 				data.IsCrit = result.cri 

	-- 				-- print('PVE-Server:RemoveBuff')
	-- 				print('PVE-Server:攻击后 RemoveBuff 冰冻:'..role:getDyId()..'->'..d:getDyId()..','..vv)
	-- 				print(data)
	-- 				EventCenter.eventInput( FightEvent.Pve_RemoveBuff, { D = data } )
	-- 			end
	-- 		end
	-- 	end
	-- end

	if not result.hurt then
		print('---------result----------')
		print(result)
		print('---------args----------')
		print(args)
	end

	for i,v in ipairs(result.hurt) do 
		if v ~= 0 then
			local d = defenders[i]
			d:onHpChange( v, skill )

			--触发与hp有关的被动技能

			if not d:isDisposed() then
				local mydata = {
					conditiontype = true,
					openorclose = true,
					attacker = true,
				}
				mydata.conditiontype = SkillUtil.Condition_HpGreater
				mydata.openorclose = true
				mydata.attacker = d
				EventCenter.eventInput(FightEvent.TriggerAbility, mydata)

				-- mydata = {
				-- 	conditiontype = true,
				-- 	openorclose = true,
				-- 	attacker = true,
				-- }
				mydata.conditiontype = SkillUtil.Condition_HpEqual
				-- mydata.openorclose = true
				-- mydata.attacker = d
				EventCenter.eventInput(FightEvent.TriggerAbility, mydata)

				-- mydata = {
				-- 	conditiontype = true,
				-- 	openorclose = true,
				-- 	attacker = true,
				-- }
				mydata.conditiontype = SkillUtil.Condition_HpLittle
				-- mydata.openorclose = true
				-- mydata.attacker = d
				EventCenter.eventInput(FightEvent.TriggerAbility, mydata)
			end

			if d:isDisposed() and skill:isNormalAttack() then
				--触发普通攻击击败敌人
				local mydata = {
					conditiontype = true,
					openorclose = true,
					attacker = true,
					carryData = true,
				}
				mydata.conditiontype = SkillUtil.Condition_OnFightNormalAndKill
				mydata.openorclose = true
				mydata.attacker = role
				mydata.carryData = d:getDyId()
				EventCenter.eventInput(FightEvent.TriggerAbility, mydata)
			end

			if d:isDisposed() then
				--触发杀死一个敌人的被动技能
				local mydata = {
					conditiontype = true,
					openorclose = true,
					attacker = true,
					carryData = true,
				}
				mydata.attacker = role
				mydata.openorclose = true
				mydata.carryData = d:getDyId()
				mydata.conditiontype = SkillUtil.Condition_KillAnEnemy
				EventCenter.eventInput(FightEvent.TriggerAbility, mydata)

				role:addMana( require 'ManaManager'.ManaTable[role:getCareer()].A )
				
				-- 触发杀死一个敌人的所有友军被动技能
				-- Condition_KillAnEnemyForAll
				mydata.openorclose = true
				mydata.conditiontype = SkillUtil.Condition_KillAnEnemyForAll
				mydata.carryData = nil
				
				if isMonster then
					local arr = self:getMonsterArray()
					for _ii, __vv in ipairs(arr) do
						mydata.attacker = __vv
						EventCenter.eventInput(FightEvent.TriggerAbility, mydata)
					end
				else
					local arr = self:getHeroArray()
					for _ii, __vv in ipairs(arr) do
						mydata.attacker = __vv
						EventCenter.eventInput(FightEvent.TriggerAbility, mydata)
					end
				end
			end 
		end
	end

	
	--[[
	buff 推送
	--]]

	--[[
	--]]
	local ret = {
		Hid = true,
		Sid = true,
		Ss = true,
		Es = true,
		IsCrit = true
	}

	ret.Hid = args.Hid
	ret.Sid = args.Sid
	ret.Ss = {}
	ret.Es = {}
	ret.IsCrit = result.cri 

	if ret.IsCrit then
		--暴击时触发

		-- error('never here')
		-- print('触发暴击')

		local mydata = {
			conditiontype = true,
			openorclose = true,
			attacker = true,
			defenders = true,
			crit = true
		} 
		mydata.conditiontype = SkillUtil.Condition_OnFightCrit
		mydata.openorclose = true
		mydata.attacker = role
		mydata.defenders = defenders
		mydata.crit = true

		EventCenter.eventInput(FightEvent.TriggerAbility, mydata)

	elseif skill:isNormalAttack() then
		--普通攻击
		local mydata = {
			conditiontype = true,
			openorclose = true,
			attacker = true,
			defenders = true,
			crit = true
		}

		mydata.conditiontype = SkillUtil.Condition_OnFightNormal
		mydata.openorclose = true
		mydata.attacker = role
		mydata.defenders = defenders
		mydata.crit = false

		-- require 'framework.helper.Utils'.delay(function ( ... )
		-- 	-- body
		-- 	print('----触发普通攻击被动 1 ----')
			
		-- 	print('----触发普通攻击被动 2 ----')
		-- end)

		EventCenter.eventInput(FightEvent.TriggerAbility, mydata)
		
		-- print(mydata)

	elseif skill:isBigSkill() then
		--主动技能释放
		local mydata = {
			conditiontype = true,
			openorclose = true,
			attacker = true,
			defenders = true,
			crit = true
		}

		mydata.conditiontype = SkillUtil.Condition_OnFightSkill
		mydata.openorclose = true
		mydata.attacker = role
		mydata.defenders = defenders

		EventCenter.eventInput(FightEvent.TriggerAbility, mydata)
	end

	--计算击飞
	local beatbackGrid = role:getBuffArray():getValueByKey(GHType.GH_BeatMore) or 0

	for i,v in ipairs(defenders) do
		local ae = {
			Hid = true,
			HpD = true,
			HpP = true,
		}
		ae.Hid = v:getDyId()
		ae.HpD = (result.hurt and result.hurt[i]) or 0
		ae.HpP = v:getHpP()

		--beatback
		local beatback = ((result.beatback and result.beatback[i]) or 0) + beatbackGrid
		--击退免疫
		local beatbackImmune  = v:getBuffArray():getValueByKey(GHType.GH_202) or 0
		-- if beatback ~= 0 and beatbackImmune ~= 0 then print('击退免疫') end
		if beatback ~= 0 and beatbackImmune == 0 then
			print('击退格数 = '..beatback)
			print('被击退者 = '..v:getDyId())

			local range = { min = require 'GridManager'.getUICenterByIJ(-3.25,1).x , max = require 'GridManager'.getUICenterByIJ(3.25,1).x }
			local pos = access.getPositionByRoleDyId( v:getDyId() )

			if pos and pos.x > range.min and pos.x < range.max then
				local uiWidth = GridManager.getUIGridWidth()

				if not isMonster then
					ae.MoveTo = { [1] = pos.x - beatback * uiWidth , [2] = pos.y }
				else
					ae.MoveTo = { [1] = pos.x + beatback * uiWidth , [2] = pos.y }
				end

				ae.MoveTo[1] = math.max(ae.MoveTo[1], range.min)
				ae.MoveTo[1] = math.min(ae.MoveTo[1], range.max)
			end
		end

		ret.Es[i] = ae
	end

	---可能来自远程, 需要保留这个基础Id
	ret.BasicId = args.BasicId

	print('send Pve_Action')
	print(ret)


	EventCenter.eventInput( FightEvent.Pve_Action, { D = ret } )
	-- print('-------Pve_Action---------')
	-- print(ret)
	-- print('--------------------------')
end

function RoleArrayClass:hasHeroExisted()
	-- body
	for i,v in ipairs (self.array) do
		if not v:isMonster() and not v:isDisposed() then
			return true
		end
	end
end

function RoleArrayClass:hasEnemyExisted()
	-- body
	for i,v in ipairs (self.array) do
		if v:isMonster() and not v:isDisposed() then
			return true
		end
	end
end

function RoleArrayClass:timeCountCondition( role,defenders  )
	local passsceonds = (require 'FightTimer'.currentFightTimeMillis() - self.initTimeMillis) /1000
	if (passsceonds - (self._LastSceonds['5'] or -5)) >= 5 then
		self:noticeAllWithSkillCondition(role,SkillUtil.Condition_PreSecond5,defenders)
		self._LastSceonds['5'] = passsceonds
	end
	if (passsceonds - (self._LastSceonds['10'] or -10)) >= 10 then
		self:noticeAllWithSkillCondition(role,SkillUtil.Condition_PreSecond10,defenders)
		self._LastSceonds['10'] = passsceonds
	end
end

function RoleArrayClass:noticeAllWithSkillCondition( role,conditiontype,defenders )
	TriggerAbilityEvent(role,SkillUtil.Condition_PreSecond5,defenders)

	local dyId = role:getDyId()
	for i,v in ipairs(self.array) do
		if v:getDyId() ~= dyId then
			TriggerAbilityEvent(v,conditiontype)
		end
	end
end

function RoleArrayClass:noticeBeforeCalc( role,defenders )
	local diffatrs = {}
	local diffcareers = {}
	for i,v in ipairs(defenders) do
		if v:getAtr() ~= role:getAtr() then
			table.insert(diffatrs,v)
		end
		if v:getCareer() ~= role:getCareer() then
			table.insert(diffcareers,v)
		end
	end

	TriggerAbilityEvent(role,SkillUtil.Condition_31,defenders)
		
	if #diffatrs > 0 then
		TriggerAbilityEvent(role,SkillUtil.Condition_EnemyProDiffSelf,diffatrs)
	end
	if #diffcareers > 0 then
		TriggerAbilityEvent(role,SkillUtil.Condition_EnemyCareerDiffSelf,diffcareers)
	end
end

--[[
-- pve 战斗返回  
FightEvent.Pve_Action="Pve_Action"
-- pve 客户端请求战斗
FightEvent.Pve_SendAction="Pve_SendAction"

--pve添加buff
FightEvent.Pve_Buff="Pve_Buff"
--pve 移除buff
FightEvent.Pve_RemoveBuff="Pve_RemoveBuff"
--]]

return RoleArrayClass