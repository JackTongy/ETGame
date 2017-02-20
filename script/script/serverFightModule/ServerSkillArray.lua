local serverSkill = require 'ServerSkill'

local ServerSkillArrayClass = class()

function ServerSkillArrayClass:ctor(owner)
	-- body
	self.array = {}
	self.owner = owner

	--skillId 2 skill
	self._skillMap = {}
end

function ServerSkillArrayClass:getArray()
	-- body
	return self.array
end

function ServerSkillArrayClass:onDisposed(  )
	-- body
	for i, v in ipairs(self.array) do 
		-- v:invalid()
		v:recycle()
	end
end

function ServerSkillArrayClass:addSkillByBasicId( skillid )
	-- body
	local skill = serverSkill.createSkill( skillid )
	if skill then
		skill:setOwner( self.owner )
		table.insert( self.array, skill )

		self._skillMap[skillid] = skill
	else

		print('error: no found skillid = '..tostring(skillid)..' !')
		print(debug.traceback())
	end
end

--[[
by basic skill id
--]]
function ServerSkillArrayClass:findSkillByBasicId( skillid )
	-- body
	-- for i,v in ipairs(self.array) do
	-- 	if v:getBasicId() == skillid then
	-- 		return v
	-- 	end
	-- end

	return self._skillMap[skillid]
end

return ServerSkillArrayClass