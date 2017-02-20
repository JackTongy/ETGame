local ServerSystemRole = class( require 'ServerRole'.getHeroClass())

function ServerSystemRole:ctor( args )

	self.dyId = -1
	self.atr = 2
	
end

function ServerSystemRole:getAtr()
	assert(false)
end

function ServerSystemRole:getDyId()
	assert(self.dyId==-1 or self.dyId==0 or self.dyId==1, 'ServerSystemRole:getDyId'..tostring(self.dyId))
	return self.dyId
end

function ServerSystemRole:getBasicId()
	assert(false)
end

function ServerSystemRole:getCareer(  )
	-- assert(false)
	return 1
end

function ServerSystemRole:getBuffArray()
	return self.buffarray
end

function ServerSystemRole:getSkillArray()
	-- assert(false)
	return self.skillarray
end

function ServerSystemRole:isDisposed()
	return self.state == 'dead' 
end

function ServerSystemRole:setDisposed()
	assert(false)
end

function ServerSystemRole:isMonster()
	-- assert(false)
	return false
end

function ServerSystemRole:onHpChange( dhp )
	-- assert(false)
end

function ServerSystemRole:getBasicHpD()
	-- assert(false)
	return 1
end

function ServerSystemRole:getHpD()
	-- assert(false)
	return 1
end

function ServerSystemRole:getHpP()
	-- assert(false)
	return 1
end

function ServerSystemRole:getSpeed()
	-- assert(false)
	return 0
end

function ServerSystemRole:getAtr( ... )
	
	return self.atr
end

local function createSystemRole()
	-- body
	local args = {}
	args.cri = 0
	args.atk = 0
	args.def = 0
	args.skillidarray = {}
	args.charactorId = 0
	args.hp = 1
	args.spd = 0

	return ServerSystemRole.new(args) 
end


return { createSystemRole = createSystemRole }