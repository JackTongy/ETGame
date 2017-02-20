local CfgHelper = require 'CfgHelper'

local function getArray( tablename, key, value )
	-- body
	local array = {}

	local tabledata = require (tablename)

	for i,v in ipairs(tabledata) do
		if v[key] == value then
			table.insert(array, v)
		end
	end

	return array
end

-- local 
local function CheckSkillByCharactor( skillVo, charactorVo)
	-- body
	--atk_method_system
	--近战1,骑士2,远程3,治疗4

	--skilltype
	-- 被动-1, 近战1, 远程2, 治疗3, 远程近战4, 大招攻击11, 大招治疗12, 特殊大招13

	--1.技能类型 与 角色 职业的符合度
	--伤害计算
	if 	   skillVo.skilltype == 1 and charactorVo.atk_method_system == 1 and skillVo.id == charactorVo.default_skill then --近战的default
	elseif skillVo.skilltype == 1 and charactorVo.atk_method_system == 2 and skillVo.id == charactorVo.default_skill then --骑士的default
	elseif skillVo.skilltype == 1 and charactorVo.atk_method_system == 4 and skillVo.id == charactorVo.default_skill then --治疗的default

	elseif skillVo.skilltype == 2 and charactorVo.atk_method_system == 3 and skillVo.id == charactorVo.advance_skill then --远程的advance

	elseif skillVo.skilltype == 3 and charactorVo.atk_method_system == 4 and skillVo.id == charactorVo.advance_skill then --治疗的advance

	elseif skillVo.skilltype == 4 and charactorVo.atk_method_system == 3 and skillVo.id == charactorVo.default_skill then --远程的default

	elseif skillVo.skilltype > 10 then --大招不做检查

	else
		-- print(string.format('skilltype=%d, atk_method_system=%d, skillid=%d, default=%d, advance=%d', skillVo.skilltype,charactorVo.atk_method_system,skillVo.id,charactorVo.default_skill,charactorVo.advance_skill))
		return false, string.format('char=%d,skill=%d not matched!', charactorVo.id, skillVo.id)
	end

	--2.技能类型 与 技能表现符合度
	--检查暴击
	if 	   skillVo.skilltype == 1 and #skillVo.atk_effectId == 2 and #skillVo.uAtk_effectId == 2 then --有暴击可能
	elseif skillVo.skilltype == 2 and #skillVo.atk_effectId == 2 and #skillVo.uAtk_effectId == 2 then --有暴击可能
	elseif skillVo.skilltype == 4 and #skillVo.atk_effectId == 2 and #skillVo.uAtk_effectId == 2 then --有暴击可能
	elseif #skillVo.atk_effectId == 1 and #skillVo.uAtk_effectId == 1 then --没有暴击可能
	else
		return false, string.format('skill=%d,#atk_effectId or #uAtk_effectId not match with the skilltype!', skillVo.id)
	end

	--1上,2下,3天空,4地面,5飞行
	--检查攻击者的effectId
	for i,effectId in ipairs(skillVo.atk_effectId) do
		-- if effectId must be a useful id
		local effectVo = CfgHelper.getCache('fightEffect', 'effectId', effectId)
		if effectVo then
			if skillVo.effect_type == 2 and effectVo.layer ~= 5 then
				return false, string.format('char=%d,skill=%d,atk_effectId=%d not matched!', charactorVo.id, skillVo.id, effectId)
			end
		else
			return false, string.format('char=%d,skill=%d,atk_effectId=%d not exsited!', charactorVo.id, skillVo.id, effectId)
		end
	end

	--检查被攻击者的effectId
	for i,effectId in ipairs(skillVo.uAtk_effectId) do
		-- if effectId must be a useful id
		local effectVo = CfgHelper.getCache('fightEffect', 'effectId', effectId)
		if effectVo then
			if skillVo.effect_type == 2 and effectVo.layer ~= 5 then
				return false, string.format('char=%d,skill=%d,uAtk_effectId=%d not matched!', charactorVo.id, skillVo.id, effectId)
			end
		else
			return false, string.format('char=%d,skill=%d,uAtk_effectId=%d not exsited!', charactorVo.id, skillVo.id, effectId)
		end
	end

	--effect_type 1近战, 2远程, 3治疗
	-- 被动-1, 近战1, 远程2, 治疗3, 远程近战4, 大招攻击11, 大招治疗12, 特殊大招13
	if 	   skillVo.effect_type == 1 and  skillVo.skilltype == 1 then
	elseif skillVo.effect_type == 1 and  skillVo.skilltype == 4 then
	elseif skillVo.effect_type == 2 and  skillVo.skilltype == 2 then
	elseif skillVo.effect_type == 3 and  skillVo.skilltype == 3 then

	elseif skillVo.effect_type == 3 and  skillVo.skilltype == 12 then

	elseif skillVo.effect_type == 1 and  skillVo.skilltype == 11 then
	elseif skillVo.effect_type == 2 and  skillVo.skilltype == 11 then

	elseif skillVo.effect_type == 1 and  skillVo.skilltype == 13 then --换血??

	else
		return false , string.format('char=%d,skill=%d,effect_type=%d not matched!', charactorVo.id, skillVo.id, skillVo.effect_type)
	end

	--检查生成或这删除buff数组
	if #skillVo.buffproarray == #skillVo.buffidarray and #skillVo.revproarray == #skillVo.revabnarray then
	else
		return false, string.format('char=%d,skill=%d, buffarray not matched!', charactorVo.id, skillVo.id )
	end

	--生成buff数组的检查
	for i,buffid in ipairs(skillVo.buffidarray) do
		if buffid > 0 then
			local buffVo = CfgHelper.getCache('buff','buffid',buffid)
			if buffVo then
				--查找buffVo的effectId
				local effectId = buffVo.model_id
				if effectId > 0 then
					local effectVo = CfgHelper.getCache('fightEffect','effectId',effectId)
					if effectVo then
						--layer的选择只有2中, 前或者后
						if effectVo.layer == 1 or effectVo.layer == 2 then

						else 
							return false, string.format('char=%d,skill=%d, add_buffid=%d, effectId=%d, not matched layer!', charactorVo.id, skillVo.id, buffid, effectId)
						end
					else
						return false, string.format('char=%d,skill=%d, add_buffid=%d, effectId=%d, not exsited!', charactorVo.id, skillVo.id, buffid, effectId)
					end
				end
			else
				return false, string.format('char=%d,skill=%d, add_buffid=%d, not exsited!', charactorVo.id, skillVo.id, buffid)
			end
		end
	end

	--移除buff数组的检查
	for i,buffid in ipairs(skillVo.revabnarray) do
		if buffid > 0 then
			local buffVo = CfgHelper.getCache('buff','buffid',buffid)
			if buffVo then
				--查找buffVo的effectId
				local effectId = buffVo.model_id
				if effectId > 0 then
					local effectVo = CfgHelper.getCache('fightEffect','effectId',effectId)
					if effectVo then
						--layer的选择只有2中, 前或者后
						if effectVo.layer == 1 or effectVo.layer == 2 then

						else 
							return false, string.format('char=%d,skill=%d, rem_buffid=%d, effectId=%d, not matched layer!', charactorVo.id, skillVo.id, buffid, effectId)
						end
					else
						return false, string.format('char=%d,skill=%d, rem_buffid=%d, effectId=%d, not exsited!', charactorVo.id, skillVo.id, buffid, effectId)
					end
				end
			else
				return false, string.format('char=%d,skill=%d, rem_buffid=%d, not exsited!', charactorVo.id, skillVo.id, buffid)
			end
		end
	end

	return true
end



local function CheckCharactor(charactorId)
	local charactorVo = CfgHelper.getCache('charactorConfig', 'id', charactorId)

	if charactorVo then
		--charactorVo

		--技能类型
		-- 被动-1, 近战1, 远程2, 治疗3, 远程近战4, 大招攻击11, 大招治疗12, 特殊大招13

		--职业类型
		--战士1,坦克2,远程3,治疗4

		--远程物理,远程魔法,近战输出,近战T,治疗

		--职业对应关系
		-- career = "远程物理",	atk_method = 6,	atk_method_system = 3,

		--检查职业
		-- if charactorVo.atk_method_system == 1 and charactorVo.career == '近战输出' then
		-- elseif charactorVo.atk_method_system == 2 and charactorVo.career == '近战T' then
		-- elseif charactorVo.atk_method_system == 3 and charactorVo.career == '远程物理' then
		-- elseif charactorVo.atk_method_system == 3 and charactorVo.career == '远程魔法' then
		-- elseif charactorVo.atk_method_system == 3 and charactorVo.career == '远程' then
		-- elseif charactorVo.atk_method_system == 4 and charactorVo.career == '治疗' then
		-- else
		-- 	return false, string.format('charId=%d, atk_method_system and career are not matched!', charactorId)
		-- end

		--检查技能
		local defaultSkillId = charactorVo.default_skill
		local defaultSkillVo = CfgHelper.getCache('skill','id', defaultSkillId)
		if defaultSkillVo then
			return CheckSkillByCharactor(defaultSkillVo, charactorVo)
		else
			return false, string.format('charId=%d, defaultSkillId=%d not existed!', charactorId, defaultSkillId)
		end

		-- checkRange = 检测范围
		-- autoCheckRange = 自动ai检测范围

		if type( charactorVo.checkRange ) ~= 'table' then
			return false, string.format('charId=%d, checkRange not a table!', charactorId)
		end

		if type( charactorVo.autoCheckRange ) ~= 'table' then
			return false, string.format('charId=%d, autoCheckRange not a table!', charactorId)
		end

		local advanceSkillId = charactorVo.advance_skill
		local advanceSkillVo = CfgHelper.getCache('skill','id', advanceSkillId)
		if advanceSkillVo then
			return CheckSkillByCharactor(advanceSkillVo, charactorVo)
		elseif charactorVo.atk_method_system == 1 or charactorVo.atk_method_system == 2 then
		else
			return false, string.format('charId=%d, advanceSkillId=%d not existed!', charactorId, advanceSkillId)
		end

		local bigSkillId = charactorVo.skin_id
		local bigSkillVo = CfgHelper.getCache('skill','id', bigSkillId)
		if bigSkillVo then
			return CheckSkillByCharactor(bigSkillVo, charactorVo)
		else 
			return false, string.format('charId=%d, bigSkillId=%d not existed!', charactorId, bigSkillId)
		end


		--验证被动技能
		-- for i,v in ipairs () do
		-- end

		-- default skill
		-- advance skill
		-- skill id
		-- abilityarray
		-- fightEffect

		--xxx

	else
		return false, string.format('charId=%s not exsited!', tostring(charactorId))
	end

	return true, 'why me!'
end

local function CheckHero( heroid )
	-- body
	local hero = CfgHelper.getCache('pve_charactor', 'heroid', heroid)
	if hero then
		return CheckCharactor(hero.charactorId)
	else
		return false, string.format('heroid=%d no such hero!',heroid)
	end

end

local function CheckMonster( heroid )
	-- body
	local hero = CfgHelper.getCache('pve_monster', 'heroid', heroid)
	if hero then
		return CheckCharactor(hero.charactorId)
	else
		return false, string.format('heroid=%d no such monster!',heroid)
	end
end


local function CheckPVE_FuBen()
	-- body
	local sb

	local fubens = require 'pve_fubens'
	--	[1] = {	fubenid = 1,	wavearray = {10},	totaltime = 0,},
	for i,v in ipairs(fubens) do 
		local wavearray = v.wavearray
		for ii, waveid in ipairs(wavearray) do
			-- vv.heroid
			local array = getArray('pve_waves','waveid', waveid)

			if #array > 0 then
				for iii, vvv in ipairs(array) do
					local suc, msg = CheckMonster(vvv.heroid)
					if not suc then
						sb = sb or {}
						table.insert(sb, msg)
						-- print('msg='..tostring(msg))
					end
				end
			else
				sb = sb or {}
				table.insert(sb, string.format('wave=%d, not found!', waveid))
			end
		end
	end
	
	if sb then
		return '\n'..table.concat(sb,'\n')
	end
end

local function CheckPVE_Team()
	-- body
	local sb

	local teams = require 'pve_charactor_teams'
	--	[1] = {	fubenid = 1,	wavearray = {10},	totaltime = 0,},
	for i,v in ipairs(teams) do 
		local heroarray = v.heroarray
		for ii, vv in ipairs(heroarray) do
			-- vv.heroid
			local suc, msg = CheckHero(vv)
			if not suc then
				sb = sb or {}
				table.insert(sb, msg)
			end
		end
	end
	
	if sb then
		return '\n'..table.concat(sb,'\n')
	end
end

local function CheckAllChar()
	-- body
	local sb 

	local all = require 'charactorConfig'
	for i,v in ipairs(all) do
		local suc, msg = CheckCharactor(v.id)
		if not suc then
			sb = sb or {}
			table.insert(sb, msg)
		end
	end

	local set = {}

	for i,v in ipairs(all) do
		if set[v.id] then
			sb = sb or {}
			table.insert(sb, string.format('charactor=%d 重复出现!', v.id))
		else
			set[v.id] = true
		end
	end

	if sb then
		return '\n'..table.concat(sb,'\n')
	end
end

local function check( funcFailed, funcSuc )
	-- body
	local msgFuBen = CheckPVE_FuBen()

	local msgTeam = CheckPVE_Team()

	local msgAll = CheckAllChar()

	if msgFuBen then
		print('-------副本配置错误--------')
		print(msgFuBen)
		print('-------------------------')
	end

	if msgTeam then
		print('-------队伍配置错误--------')
		print(msgTeam)
		print('-------------------------')
	end

	if msgAll then
		print('-------角色配置错误--------')
		print(msgAll)
		print('-------------------------')
	end

	if msgFuBen or msgTeam or msgAll then
		if funcFailed then
			funcFailed()
		end
	else
		if funcSuc then
			funcSuc()
		end
	end
end

--xpcall 
return { check = check }
