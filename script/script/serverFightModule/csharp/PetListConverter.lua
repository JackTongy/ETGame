local PetListConverter = {}

local function find( t,k,v )
	for _,vv in ipairs(t) do
		if vv[k] == v then
			return vv
		end
	end
end

local function convertToDungeonData( nPet, isFriend )
	local temp = {}
	temp.heroid = nPet.Id
	temp.charactorId = nPet.PetId
	temp.awaken = nPet.AwakeIndex
	temp.intimacy = nPet.Intimacy
	temp.hp = nPet.Hp
	temp.atk = nPet.Atk
	temp.def = nPet.Def
	temp.cri = nPet.Crit
	temp.spd = nPet.MoveSpeed
	temp.atktime = nPet.AtkTime
	temp.AwakeIndex = nPet.AwakeIndex

	temp.PetId = nPet.PetId
	temp.ID = nPet.Id
	temp.Lv = nPet.Lv
	if nPet.HpMax == 0 then
		temp.HpMax = nPet.Hp
	else
		temp.HpMax = nPet.HpMax
	end
	temp.isFriend = isFriend or false

	temp.sv = nPet.Sv
	temp.fv = nPet.Fv
	temp.cv = nPet.Cv
	temp.bd = nPet.Bd
	temp.hpR = nPet.HpR
	if nPet.Gb then
		temp.gb = table.clone(nPet.Gb)
	else
		temp.gb = nil
	end
	temp.energy = nPet.energy or 0
	temp.aiType = nPet.aiType
	return temp
end

function PetListConverter.getPetsInfo( info )
	assert(info)

	local selfPetList,enemyPetList = {},{}
	for i,team in ipairs(info.Teams) do
		local target = ( i==2 and selfPetList) or enemyPetList
		for _,pid in ipairs(team.PetIdList) do
			table.insert(target, convertToDungeonData( find(info.Pets,"Id",pid)) )
		end
		local benchPet = find(info.Pets,"Id",team.BenchPetId)
		if benchPet then
			table.insert(target, convertToDungeonData(benchPet))
		end
	end
	return selfPetList,enemyPetList
end

return PetListConverter
