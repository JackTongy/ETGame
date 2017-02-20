local CfgHelper 		= require 'CfgHelper'

local CheckRoleEffect = {}

function CheckRoleEffect.check()
	-- body
	local dataArr = require 'roleEffect'
	---[[
	-- [1] = {	ID = 3,	handbook = 3,	
	-- name = [[妙蛙花]],	
	-- career = [[远程物理]],	
	-- skillname = [[飞叶风暴]],	
	-- skilldes = [[消耗3级怒气,攻击全体敌人,造成攻击力的533%伤害,有30%几率附加致盲效果]],	
	--[[
	skill_ID = 103014,	
	effect_type = 11,	
	B_skill_time = 3,	
	skill_in_time = 0,	
	B_natk_time = 0.6400,	
	B_crit_time = 0.6400,	
	flight_time = 0.6500,	
	crit_flight_time = 1,	
	B_cure_time = 0,

	skill_effectID = {35709,4309,309,1000016,1000025},	
	B_skill_effectID = {301,601,1000026},	
	natk_effectID = {1801,1000024},	
	B_natk_effectID = {301,1000019},	
	crit_effectID = {1801,1000024},	
	B_crit_effectID = {301,1000020},	
	remote_effectID = {105,1000011},	
	B_remote_effectID = {301,1000021},	
	crit_remote_effectID = {105,1000010},	
	B_crit_remote_effectID = {301,1000021},	
	cure_effectID = {0},	
	B_cure_effectID = {0},	
	--]]
	local arrayLabels = {
	'skill_effectID','B_skill_effectID','natk_effectID','B_natk_effectID',
	'crit_effectID','B_crit_effectID','remote_effectID','B_remote_effectID',
	'crit_remote_effectID','B_crit_remote_effectID','cure_effectID','B_cure_effectID',
	}

	local numLables = {
	'skill_ID','effect_type','B_skill_time','skill_in_time',
	'B_natk_time','B_crit_time','flight_time','crit_flight_time',
	'B_cure_time'
	}

	for i,item in ipairs(dataArr) do
		for ii, key in ipairs(arrayLabels) do
			if type(item[key]) ~= 'table' then
				print(string.format('Warning:roleEffect ID=%d, key=%s not an array!', item.ID, key))
			end
		end
		
		for ii, key in ipairs(numLables) do
			if type(item[key]) ~= 'number' then
				print(string.format('Warning:roleEffect ID=%d, key=%s not a number!', item.ID, key))
			end
		end
	end

	-- 检查延迟 和 动作
	-- local 
	-- local boneDataArr = require 'BonesData'
	--[[
	handbook = .
	B_skill_time = 大招受击特效延迟   [大招]
	B_natk_time = 普通近战受击特效延迟 [近战攻击]
	B_crit_time = 近战暴击受击特效延迟 [近战暴击]
	flight_time = 远程飞行道具打出延迟 [远程攻击]
	crit_flight_time = 暴击飞行道具打出延迟 [远程暴击]
	B_cure_time = 接受治疗特效延迟 [治疗]
	--]]

	local pairArr = {
		{ 'B_skill_time', '大招' },
		{ 'B_natk_time', '近战攻击' },
		{ 'B_crit_time', '近战暴击' },
		{ 'flight_time', '远程攻击' },
		{ 'crit_flight_time', '远程暴击' },
		{ 'B_cure_time', '治疗' },
	}

	for i,v in ipairs(dataArr) do

		local id = v.handbook

		-- role-700
		local roleid 
		if id < 10 then
			roleid = string.format('role-00%d', id)
		elseif id < 100 then
			roleid = string.format('role-0%d', id)
		else
			roleid = string.format('role-%d', id)
		end	
		
		assert(roleid)

		local boneItem = CfgHelper.getCache('BonesData','name', roleid)

		if boneItem then
			local charVo = CfgHelper.getCache('charactorConfig','id', id)
			assert(charVo)

			-- SpecailManager.getDelayTimeByCharIdAndSkillId = function (charId, skillId, crit )
			if charVo then
				for ii, vv in ipairs(pairArr) do
					local delay = (v[vv[1]] or 0)*1000
					local time =  boneItem[vv[2]] or 0

					if time < delay then
						print(string.format('Warning:Id=%d, action=%s, delay=%.2f, time=%.2f!', id, vv[2], delay, time))
					end
				end
			end
		else
			print(string.format('Warning:Not Found %s In BonesData!', roleid))
		end
	end

end

CheckRoleEffect.check()

return CheckRoleEffect