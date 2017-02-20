local CfgHelper = require 'CfgHelper'
local FightEffectBasicManager = require 'FightEffectBasicManager'
local SkillUtil = require 'SkillUtil'

local SpecailManager = {}

function findFlyItem( effectBassicArr )
	for k,effectBasicVo in pairs(effectBassicArr) do
		if effectBasicVo.layer == SkillUtil.Layer_FlyTool then
			return effectBasicVo
		end
	end

	print('not findFlyItem')
	print(effectBassicArr)
	print('---------------')
end

SpecailManager.getEffectType = function( charId, skillId, isCrit )
	-- body
	local skillVo = CfgHelper.getCache('skill','id', skillId)
	
	if skillVo.skilltype >= 10 then
		-- local charVo = CfgHelper.getCache('charactorConfig','id', charId)
		return CfgHelper.getCache('roleEffect', 'handbook', charId, 'effcet_type')
	else
		return skillVo.effcet_type
	end
end


--单位为秒 pve战斗时攻击动作做到多少后发起攻击协议
SpecailManager.getDelayTime = function (atk, skillId, crit )
	-- body

	local skillBasicVo = CfgHelper.getCache('skill','id',skillId)
	local charId = atk.roleDyVo.basicId

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
		index = 3 + ((crit and 3) or 0)
	elseif skillBasicVo.skilltype ==4 then --远程近战
		index = 3 + ((crit and 3) or 0) 
	elseif skillBasicVo.skilltype == SkillUtil.SkillType_YuanCheng then
		index = 9 + ((critand and 3) or 0) 
	elseif skillBasicVo.skilltype == SkillUtil.SkillType_ZiLiao then 
		index = 15
	elseif skillBasicVo.skilltype >= 10 then 				--大招
		index = 18
	end
	
	return CfgHelper.getCache( 'roleEffect', 'handbook', charId, keys[index] )
end

SpecailManager.getDelayTimeByCharIdAndSkillId = function (charId, skillId, crit )
	-- body
	assert(charId)
	assert(skillId)

	local skillBasicVo = CfgHelper.getCache('skill','id',skillId)
	assert(skillBasicVo)

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
		index = 3 + ((crit and 3) or 0)
	elseif skillBasicVo.skilltype ==4 then --远程近战
		index = 3 + ((crit and 3) or 0) 
	elseif skillBasicVo.skilltype == SkillUtil.SkillType_YuanCheng then
		index = 9 + ((critand and 3) or 0) 
	elseif skillBasicVo.skilltype == SkillUtil.SkillType_ZiLiao then 
		index = 15
	elseif skillBasicVo.skilltype >= 10 then 				--大招
		index = 18
	end
	
	return CfgHelper.getCache( 'roleEffect', 'handbook', charId, keys[index] )
end

---是否暴击
SpecailManager.getCritHappened = function ( skillId, atk )
	-- body
	local ServerController = require 'ServerController'
	local Random = require 'Random'

	local skillVo = CfgHelper.getCache('skill','id',skillId)
	assert(skillVo)
	
	local isCrit = false
	local crit = ServerController.getRoleCrit(atk.roleDyVo.playerId)

	if skillVo.skilltype == SkillUtil.SkillType_JinZhan or skillVo.skilltype == SkillUtil.SkillType_YuanCheng or skillVo.skilltype == SkillUtil.SkillType_YuanChengJinZhan then
		isCrit = ( Random.ranF() < ( crit or 0) ) 
	end
	
	return isCrit	
end

return SpecailManager