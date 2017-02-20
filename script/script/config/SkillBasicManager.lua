local skillTable = require 'skill'

local skillBasicManager = {}

local dict = {}

for k,skillBasicVo in pairs(skillTable) do
	dict[skillBasicVo.id]=skillBasicVo
end




function skillBasicManager.getSkill( skillId )

	-- for k,skillBasicVo in pairs(skillTable) do
	-- 	if skillBasicVo.id==skillId then
	-- 		return skillBasicVo
	-- 	end
	-- end
	if type(skillId)=="table" then
		assert(false,'skill数据错误:')
	end
	local vo = dict[skillId]
	-- print('skillId--')
	-- print(skillId)
	-- print('skillId==')
	assert(vo,'skill数据错误:'..skillId)
	return vo
end

return skillBasicManager

