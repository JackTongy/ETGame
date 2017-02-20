local charactorBasicManager = require 'CharactorConfigBasicManager'
local skillBasicManager = require 'SkillBasicManager'
local eventCenter = require 'EventCenter'
local fightEvent = require 'FightEvent'
--当前选中的对象
local selectProxy = {}

function selectProxy.setPlayer( player )
	if player ~=selectProxy._player then
		selectProxy._player=player
		-- local package = {}

		-- package.data = selectProxy.getCareerNum()
		-- package.player = player

		-- eventCenter.eventInput(fightEvent.SelectPlayerChange, package )
	end
end
function selectProxy.getPlayer( player )
	if selectProxy._player then
		if selectProxy._player.roleDyVo.hpPercent>0 then
			return selectProxy._player
		end
	end
	return nil
end

--能否触发能量球技能 map[type] =num
function selectProxy.canTrigger( map )
	if selectProxy._player then
		local roleDyVo = selectProxy._player.roleDyVo
		local charactorBasicVo = charactorBasicManager.getCharactorBasicVo(roleDyVo.basicId)
		local skillId = charactorBasicVo.skill_id
		local skillBasicVo = skillBasicManager.getSkill(skillId)
		if map[charactorBasicVo.atk_method_system]>=skillBasicVo.point then
			return true
		end
	end
	return false
end

--获取职业类型 和需要的能量球个数   职业类型 枚举在  TypeRole文件  TypeRole._
function selectProxy.getCareerNum( ) 
	if selectProxy._player then
		local roleDyVo = selectProxy._player.roleDyVo
		local charactorBasicVo = charactorBasicManager.getCharactorBasicVo(roleDyVo.basicId)
		-- local skillId = charactorBasicVo.skill_id

		local skillId = roleDyVo.skill_id
		local skillIdValue = math.abs(skillId)
		local skillBasicVo = skillBasicManager.getSkill(skillIdValue)

		return {career=charactorBasicVo.atk_method_system,num=skillBasicVo.point,name=skillBasicVo.name,skillId=skillId,playerId=roleDyVo.playerId}
	end
	return nil
end

--获取能量球技能
function selectProxy.getSkillBasicVo( ) 
	if selectProxy._player then
		local roleDyVo = selectProxy._player.roleDyVo
		-- local charactorBasicVo = charactorBasicManager.getCharactorBasicVo(roleDyVo.basicId)
		-- local skillId = charactorBasicVo.skill_id
		local skillId = roleDyVo.skill_id
		if skillId>0 then
			local skillBasicVo = skillBasicManager.getSkill(skillId)
			-- print('search skill id '.. skillId)
			return skillBasicVo
		else 
			print('error skillId '..skillId)
		end
	else
		print('no selectProxy._player!')
	end
	return nil
end




return selectProxy

