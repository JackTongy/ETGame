local GuildCopyFunc = {}
local GuildCopyData = {}

function GuildCopyFunc.cleanData( ... )
	GuildCopyData = {}
end

function GuildCopyFunc.setGuildCopyRecord( record )
	GuildCopyData.record = record
end

function GuildCopyFunc.getGuildCopyRecord( ... )
	return GuildCopyData.record
end

function GuildCopyFunc.setGuildCopy( copy )
	GuildCopyData.copy = copy
end

function GuildCopyFunc.getGuildCopy( ... )
	return GuildCopyData.copy
end

function GuildCopyFunc.getKeyAmountWithProperty( propId )
	if GuildCopyData.copy and GuildCopyData.copy.KeysGot then
		for i,v in ipairs(GuildCopyData.copy.KeysGot) do
			if v.PropId == propId then
				return v.Amount
			end
		end
	end
	return 0
end

function GuildCopyFunc.getGuildCopyKeyDict( boxIndex )
	if GuildCopyData.copy then
		local keyNeed
		if boxIndex == 1 then
			keyNeed = GuildCopyData.copy.Box1KeysNeed
		elseif boxIndex == 2 then
			keyNeed = GuildCopyData.copy.Box2KeysNeed
		elseif boxIndex == 3 then
			keyNeed = GuildCopyData.copy.Box3KeysNeed
		end
		local result = {}
		for i,v in ipairs(keyNeed) do
			table.insert(result, {PropId = v.PropId, Amount = v.Amount, Own = GuildCopyFunc.getKeyAmountWithProperty(v.PropId) })
		end
		return result
	end
end

function GuildCopyFunc.getBoxProcess( boxIndex )
	local keyInfoList = GuildCopyFunc.getGuildCopyKeyDict( boxIndex )
	if keyInfoList then
		local count = 0
		for i,v in ipairs(keyInfoList) do
			if v.Own >= v.Amount then
				count = count + 1
			end
		end
		return count / #keyInfoList
	end
	return 0
end

function GuildCopyFunc.setGuildCopyPetsMine( pets )
	GuildCopyData.PetsMine = pets
end

function GuildCopyFunc.getGuildCopyPetsMine( ... )
	return GuildCopyData.PetsMine
end

function GuildCopyFunc.setGuildCopyPetsOthers( pets )
	GuildCopyData.PetsOthers = pets
end

function GuildCopyFunc.getGuildCopyPetsOthers( ... )
	return GuildCopyData.PetsOthers
end

function GuildCopyFunc.getGuildCopyPetWithId( nPetId )
	if GuildCopyData.PetsOthers then
		for i,v in ipairs(GuildCopyData.PetsOthers) do
			if v.Pet.Id == nPetId then
				return v.Pet
			end
		end
	end
end

function GuildCopyFunc.setAreaStages( areaId, stages )
	GuildCopyData.AreaStages = GuildCopyData.AreaStages or {}
	GuildCopyData.AreaStages[areaId] = stages
end

function GuildCopyFunc.getStagesWithAreaId( areaId )
	return GuildCopyData.AreaStages and GuildCopyData.AreaStages[areaId]
end

function GuildCopyFunc.getStagesWithAreaTownId( areaId, townId )
	local list = GuildCopyFunc.getStagesWithAreaId( areaId ) or {}
	local result = {}
	for i,v in ipairs(list) do
		if v.TownId == townId then
			table.insert(result, v)
		end
	end
	return result
end

function GuildCopyFunc.getTownPercent( areaId, townId )
	local stages = GuildCopyFunc.getStagesWithAreaTownId( areaId, townId ) or {}
	local count = 0
	for i,v in ipairs(stages) do
		if v.Clear then
			count = count + 1
		end
	end
	return #stages > 0 and (count / #stages) or 0
end

function GuildCopyFunc.getStageInfo( areaId, townId, stageId )
	local stages = GuildCopyFunc.getStagesWithAreaTownId( areaId, townId ) or {}
	for i,v in ipairs(stages) do
		if v.StageId == stageId then
			return v
		end
	end
end

function GuildCopyFunc.cleanStagesData( ... )
	GuildCopyData.AreaStages = nil
end

function GuildCopyFunc.setStage( nStage )
	if nStage then
		local oldStages = GuildCopyFunc.getStagesWithAreaId( nStage.AreaId ) or {}
		local canFind = false
		for i,v in ipairs(oldStages) do
			if v.StageId == nStage.StageId then
				oldStages[i] = nStage
				canFind = true
				break
			end
		end
		if not canFind then
			GuildCopyData.AreaStages = GuildCopyData.AreaStages or {}
			GuildCopyData.AreaStages[nStage.AreaId] = GuildCopyData.AreaStages[nStage.AreaId] or {}
			table.insert(GuildCopyData.AreaStages[nStage.AreaId], nStage)
		end
	end
end

return GuildCopyFunc
