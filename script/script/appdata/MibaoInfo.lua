local MibaoFunc = {}
local MibaoData = {}

function MibaoFunc.getMibaoWithDB( mibaoId )
	local mibao = {}
	mibao.MibaoId = mibaoId
	local dbManager = require "DBManager"
	local dbMibao = dbManager.getInfoTreasure(mibaoId)
	mibao.Name = dbMibao.Name
	mibao.Type = dbMibao.Type
	mibao.Star = dbMibao.Star
	mibao.Property = dbMibao.Property
	mibao.Lv = 1
	mibao.Exp = dbMibao.Exp
	mibao.ForgetTimes = 0
	mibao.CanForge = 1
	mibao.Effect = dbMibao.Effect
	mibao.Addition = dbMibao.Addition
	mibao.SetIn = nil
	mibao.RefineLv = 0
	return mibao
end

function MibaoFunc.cleanData( ... )
	MibaoData.MibaoList = {}
	MibaoData.MibaoPieceList = {}
end

function MibaoFunc.getMibaoList( ... )
	return MibaoData.MibaoList or {}
end

function MibaoFunc.setMibaoList( list )
	MibaoData.MibaoList = list or {}
end

function MibaoFunc.getMibaoPieceList( ... )
	return MibaoData.MibaoPieceList or {}
end

function MibaoFunc.setMibaoPieceList( list )
	MibaoData.MibaoPieceList = list or {}
end

function MibaoFunc.setMibao( mibao )
	if mibao then
		MibaoData.MibaoList = MibaoData.MibaoList or {}
		local canFind = false
		for i,v in ipairs(MibaoData.MibaoList) do
			if v.Id == mibao.Id then
				MibaoData.MibaoList[i] = mibao
				canFind = true
				break
			end
		end
		if not canFind then
			table.insert(MibaoData.MibaoList, mibao)
		end
	end
end

function MibaoFunc.setMibaoPiece( mibaoPiece )
	if mibaoPiece then
		MibaoData.MibaoPieceList = MibaoData.MibaoPieceList or {}
		local canFind = false
		for i,v in ipairs(MibaoData.MibaoPieceList) do
			if v.MibaoId == mibaoPiece.MibaoId then
				if mibaoPiece.Amount == 0 then
					table.remove(MibaoData.MibaoPieceList, i)
				else
					MibaoData.MibaoPieceList[i] = mibaoPiece
				end	
				canFind = true
				break
			end
		end
		if not canFind then
			table.insert(MibaoData.MibaoPieceList, mibaoPiece)
		end
	end
end

function MibaoFunc.removeMibao( v )
	if MibaoData.MibaoList then
		for i,vv in ipairs(MibaoData.MibaoList) do
			if v.Id == vv.Id then
				vv.Amount = vv.Amount - 1
				if vv.Amount <= 0 then
					table.remove(MibaoData.MibaoList,i)
				end
				break
			end
		end
	end
end

function MibaoFunc.removeMibaoList( list )
	for _,v in ipairs(list) do
		MibaoFunc.removeMibao(v)
	end
end

function MibaoFunc.updateMibaoList( list )
	if list then
		for i,v in ipairs(list) do
			MibaoFunc.setMibao( v )
		end
	end
end

function MibaoFunc.updateMibaoPieceList( list )
	if list then
		for i,v in ipairs(list) do
			MibaoFunc.setMibaoPiece( v )
		end
	end
end

function MibaoFunc.getPetMibaoPutOn( setInList,team )
	local petID = MibaoFunc.getPetIdMibaoPutOn(setInList,team)
	if petID >0 then
		return require "PetInfo".getPetWithId(petID)
	else
		return nil
	end
end

function MibaoFunc.getPetIdMibaoPutOn( setInList,team )
	local curTeam,teamIndex 
	if not team then
		curTeam,teamIndex  = require "TeamInfo".getTeamActive()
	else
		curTeam,teamIndex = team,team.TeamId
	end
	local index = setInList[teamIndex]
	local petId = 0
	if index and index >0 then
		if index == 6 then
			petId =  curTeam.BenchPetId
		else
			petId =  curTeam.PetIdList[index]
		end
	end
	return petId or 0
end

function MibaoFunc.getMibaoListWithPetId( petId )
	return MibaoFunc.getMibaoListWithPetId0(petId, MibaoData.MibaoList)
end

function MibaoFunc.getMibaoListWithPetId0( petId,mibaoList,team )
	local temp = {}
	if petId > 0 and mibaoList then
		for i,v in ipairs(mibaoList) do
			local petID = MibaoFunc.getPetIdMibaoPutOn(v.SetIn,team)
			if petID== petId then
				table.insert(temp, v)
			end
		end
	end
	return temp
end

function MibaoFunc.selectByCondition( condition )
	local ret = {}
	if MibaoData.MibaoList then
		for _,v in pairs(MibaoData.MibaoList) do
			if condition(v) then
				table.insert(ret,v)
			end
		end
	end
	return ret
end

-- 1:装备在当前队伍 2:装备在其他队伍 3:未装备
function MibaoFunc.getSetInStatus( mibao )
	local petInfo = MibaoFunc.getPetMibaoPutOn(mibao.SetIn)
	if petInfo then
		return 1
	else
		local activeTeamId = require "TeamInfo".getTeamActiveId()
		local hasEquipAnother = false
		for i=1,3 do
			if i ~= activeTeamId and mibao.SetIn[i]>0 then
				hasEquipAnother = true
				break
			end
		end
		if hasEquipAnother then
			return 2
		else
			return 3
		end
	end
end

return MibaoFunc