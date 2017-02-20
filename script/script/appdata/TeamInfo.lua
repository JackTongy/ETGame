--[[
		队伍 (Team)
		字段				类型				说明
		Rid					Int					玩家id
		TeamId			Int					队伍id
		PetIdList			List<long>			队伍包含精灵唯一id列表（不包含替补）
		Active				Bool				当前激活
		BenchPetId	 		Long				替补席精灵唯一id
		CaptainPetId		Long				队长精灵唯一id
		CombatPower		Int					队伍战力
]]

-- 队伍模块
local teamFunc = {}
local teamData = {}

function teamFunc.cleanData()
	teamData = {}
end
function teamFunc.getTeamDataByPetIds( PetIds )
	local team = {}
	team.Rid 	= 0
	team.TeamId = 1
	team.PetIdList = {}--PetIds
	for i=1,5 do
		if PetIds[i] then
			table.insert(team.PetIdList,PetIds[i])
		end
	end

	team.Active = false
	team.CaptainPetId = PetIds[1]
	team.CombatPower = 0
	team.BenchPetId = PetIds[6] or 0
	return team
end

-- 返回队伍列表
function teamFunc.getTeamList(  )
	return teamData
end

-- 设置队伍列表
function teamFunc.setTeamList( list )
	teamData = list
end

function teamFunc.setTeam( team )
	for i,v in ipairs(teamData) do
		if v.TeamId == team.TeamId then
			teamData[i] = team
			break
		end
	end
end

function teamFunc.getFetterPetIdList( Id )
	local result = {}
	
	if Id and teamFunc.isInActiveTeam(Id) then
		local acitveIndex = teamFunc.getTeamActiveId()
		local teamInfo = teamFunc.getTeamList()[acitveIndex]
		if teamInfo then
			if teamInfo.PetIdList then
				for i,v in ipairs(teamInfo.PetIdList) do
					table.insert(result, v)
				end
			end
			
			if teamInfo.BenchPetId > 0 then
				table.insert(result, teamInfo.BenchPetId)
			end

			local partnerList = require "AppData".getPartnerInfo().getPartnerListWithTeamIndex(acitveIndex)
			if partnerList then
				for k,v in pairs(partnerList) do
					if v.PetId > 0 then
						table.insert(result, v.PetId)
					end
				end
			end
		end
		-- for k, v in pairs(result) do
		-- 	print('msg:----------------Name: '..tostring(require "AppData".getPetInfo().getPetWithId(v).Name))
		-- end

		result = require "AppData".getPetInfo().getPetIDsByIds(result)
	end

	return result
end

-- 返回激活的Team信息
function teamFunc.getTeamActive(  )
	local team, index
	for i,v in ipairs(teamData) do
		if v.Active == true then
			team = v
			index = i
			break
		end
	end
	return team, index
end

function teamFunc.getTeamActiveId(  )
	return teamFunc.getTeamActive().TeamId
end

-- 设置激活队伍中的成员，oldPetId为原先的精灵ID，newPetId为替换后的精灵ID，oldPetId = 0时表示先前该位置没有精灵
-- positionId为位置ID，1为队长，6为替补
function teamFunc.setMember( oldPetId, newPetId, positionId )
	local team = teamFunc.getTeamActive()
	if team then
		local oldTeamPetIdList = teamFunc.getPetListCanChange(team)
		local isInTeam, pos = teamFunc.isInActiveTeam( newPetId )
		positionId = math.min(positionId, 6)
		if positionId == 6 then -- 替补
			team.BenchPetId = newPetId
			if isInTeam and pos ~= 6 then
				team.PetIdList[pos] = oldPetId
			end
			if newPetId == team.CaptainPetId then
				team.CaptainPetId = oldPetId
			end
		else
			if team.PetIdList and #team.PetIdList > 0 then
				local canFind = false
				for i,v in ipairs(team.PetIdList) do
					if v == oldPetId then
						team.PetIdList[i] = newPetId
						canFind = true
						break
					end
				end	
				if canFind == false then
					table.insert(team.PetIdList, newPetId)
				end
			else
				team.PetIdList = {}
				table.insert(team.PetIdList, newPetId)
			end
			if isInTeam then
				if pos == 6 then
					team.BenchPetId = oldPetId
				else
					team.PetIdList[pos] = oldPetId
				end
			end
			if positionId == 1 then  --  队长
				team.CaptainPetId = newPetId
			else
				if newPetId == team.CaptainPetId then
					team.CaptainPetId = oldPetId
				end
			end
		end

		-- 更新阵容
		local setNil = false
		local newTeamPetIdList = teamFunc.getPetListCanChange(team)
		for i,v in ipairs(newTeamPetIdList) do
			if not table.find(oldTeamPetIdList, v) then
				team.AtkType = nil
				team.DefType = nil
				setNil = true
				break
			end
		end
		if not setNil and oldPetId ~= 0 then
			local p1 = table.keyOfItem(oldTeamPetIdList, newPetId)
			local p2 = table.keyOfItem(newTeamPetIdList, newPetId)
			if p1 and p2 then
				if team.AtkType then
					local t = team.AtkType[p1]
					team.AtkType[p1] = team.AtkType[p2]
					team.AtkType[p2] = t
				end
				if team.DefType then
					local t = team.DefType[p1]
					team.DefType[p1] = team.DefType[p2]
					team.DefType[p2] = t
				end
			end
		end
	end
end

function teamFunc.getPetListCanChange( team )
	local list = table.clone(team.PetIdList)
	if #team.PetIdList < 5 and team.BenchPetId > 0 then
		table.insert(list, team.BenchPetId)
	end
	return list
end

function teamFunc.getPetListWithTeam( team )
	local petFunc = require "PetInfo"
	local list = {}
	for i,v in ipairs(team.PetIdList) do
		table.insert(list, petFunc.getPetWithId(v))
	end
	if team.BenchPetId > 0 then
		table.insert(list, petFunc.getPetWithId(team.BenchPetId))
	end
	return list
end

function teamFunc.getConvertPetListWithTeam( team )
	local petFunc = require "PetInfo"
	local list = {}
	for i,v in ipairs(team.PetIdList) do
		table.insert(list, petFunc.convertToDungeonData( petFunc.getPetWithId(v) ))
	end
	if team.BenchPetId > 0 then
		table.insert(list, petFunc.convertToDungeonData( petFunc.getPetWithId(team.BenchPetId) ))
	end
	return list
end

function teamFunc.getPetIdListWithBench( ... )
	local team = teamFunc.getTeamActive()
	local list = table.clone(team.PetIdList)
	if team.BenchPetId > 0 then
		table.insert(list, team.BenchPetId)
	end
	return list
end

function teamFunc.isInTeam( petId )
	local list = teamFunc.getTeamList()

	for k1,team in pairs(list) do
		for k,v in pairs(team.PetIdList) do
			if v == petId then
				return true
			end
		end	
		if team.BenchPetId == petId then
			return true
		end
	end

	return false
end

function teamFunc.isInActiveTeam( petId )
	local team = teamFunc.getTeamActive(  )
	for i,v in ipairs(team.PetIdList) do
		if v == petId then
			return true, i
		end
	end	
	if team.BenchPetId == petId then
		return true, 6
	end
	return false, 0
end

function teamFunc.getTeamCombatPower(  )
	local combatPower = 0
	local petFunc = require "PetInfo"
	local team = teamFunc.getTeamActive(  )
	if team then
		for i,v in ipairs(team.PetIdList) do
			if v > 0 then
				combatPower = combatPower + petFunc.getPetWithId(v).Power
			end
		end	
		if team.BenchPetId > 0 then
			combatPower = combatPower + petFunc.getPetWithId(team.BenchPetId).Power
		end
	end
	return combatPower
end

function teamFunc.getTeamCombatPowerWithTeamId( teamId )
	local combatPower = 0
	local petFunc = require "PetInfo"
	local teamList = teamFunc.getTeamList()
	local team = teamList[teamId]
	if team then
		for i,v in ipairs(team.PetIdList) do
			if v > 0 then
				combatPower = combatPower + petFunc.getPetWithId(v).Power
			end
		end	
		if team.BenchPetId > 0 then
			combatPower = combatPower + petFunc.getPetWithId(team.BenchPetId).Power
		end
	end
	return combatPower
end

function teamFunc.convertToBattlePosWithIndex( index )
	local temp = {}
	temp.i = (index - 1) % 3 + 1
	temp.j = math.floor((9 - index) / 3) - 1
	return temp
end

function teamFunc.getPosListAtkType( teamInfo )
	if teamInfo.AtkType then
		local result = {}
		for i,v in ipairs(teamInfo.AtkType) do
			table.insert( result, teamFunc.convertToBattlePosWithIndex(v) )
		end
		return result
	end
end

function teamFunc.getPosListDefType( teamInfo )
	if teamInfo.DefType then
		local result = {}
		for i,v in ipairs(teamInfo.DefType) do
			table.insert( result, teamFunc.convertToBattlePosWithIndex(v) )
		end
		return result
	end
end

function teamFunc.getPosListCsTypeAtk( teamInfo )
	if teamInfo.CsType then
		local result = {}
		for i,v in ipairs(teamInfo.CsType) do
			table.insert( result, teamFunc.convertToBattlePosWithIndex(v) )
		end
		return result
	end
end

function teamFunc.getPosListCsTypeDef( teamInfo )
	if teamInfo.CsDefType then
		local result = {}
		for i,v in ipairs(teamInfo.CsDefType) do
			table.insert( result, teamFunc.convertToBattlePosWithIndex(v) )
		end
		return result
	end
end

function teamFunc.getTeamIdAtkType( ... )
	local teamList = teamFunc.getTeamList()
	for i,v in ipairs(teamList) do
		if v.IsAtk then
			return v.TeamId
		end
	end
end

function teamFunc.getTeamIdDefType( ... )
	local teamList = teamFunc.getTeamList()
	for i,v in ipairs(teamList) do
		if v.IsDef then
			return v.TeamId
		end
	end
end

function teamFunc.getTeamIdCsTypeAtk( ... )
	local teamList = teamFunc.getTeamList()
	for i,v in ipairs(teamList) do
		if v.IsCs then
			return v.TeamId
		end
	end
end

function teamFunc.getTeamIdCsTypeDef( ... )
	local teamList = teamFunc.getTeamList()
	for i,v in ipairs(teamList) do
		if v.IsCsDef then
			return v.TeamId
		end
	end
end

function teamFunc.getTeamCsTypeAtk( ... )
	local teamList = teamFunc.getTeamList()
	for i,v in ipairs(teamList) do
		if v.IsCs then
			return v
		end
	end
end

function teamFunc.getTeamCsTypeDef( ... )
	local teamList = teamFunc.getTeamList()
	for i,v in ipairs(teamList) do
		if v.IsCsDef then
			return v
		end
	end
end

function teamFunc.getTeamGBType( type )
	if type then
		local result = {}
		for i,v in ipairs(type) do
			table.insert( result, teamFunc.convertToBattlePosWithIndex(v) )
		end
		return result
	end
end

function teamFunc.getTeamPetsWithTeamId( teamId )
	local list = teamFunc.getTeamList()
	return teamFunc.getPetListWithTeam( list[teamId] )
end

function teamFunc.getTeamIdExploreAtkType( ... )
	local teamList = teamFunc.getTeamList()
	for i,v in ipairs(teamList) do
		if v.ExploreAtk then
			return v.TeamId
		end
	end
end

function teamFunc.getTeamIdExploreDefType( ... )
	local teamList = teamFunc.getTeamList()
	for i,v in ipairs(teamList) do
		if v.ExploreDef then
			return v.TeamId
		end
	end
end

function teamFunc.getPosListExploreAtkType( teamInfo )
	if teamInfo.ExploreAtkType then
		local result = {}
		for i,v in ipairs(teamInfo.ExploreAtkType) do
			table.insert( result, teamFunc.convertToBattlePosWithIndex(v) )
		end
		return result
	end
end

function teamFunc.getPosListExploreDefType( teamInfo )
	if teamInfo.ExploreDefType then
		local result = {}
		for i,v in ipairs(teamInfo.ExploreDefType) do
			table.insert( result, teamFunc.convertToBattlePosWithIndex(v) )
		end
		return result
	end
end

return teamFunc