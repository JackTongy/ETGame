local data = {} --[Town={Rid,TownId,IsOpen}]
local DBTownsWithPub = nil --与精灵学院相关的城镇
local lastTownId = nil
local areaBoxList = {}
local lastBattleStageId = nil

local PlayBranchList = {
	PlayBranchNormal = 0,
	PlayBranchSenior = 1,
	PlayBranchHero = 2,
}
local PlayBranch = PlayBranchList.PlayBranchNormal

local TownInfo = {}

TownInfo.cleanData = function ()
	data = {}
	DBTownsWithPub = nil
	lastTownId = nil
	areaBoxList = {}
	lastBattleStageId = nil
	PlayBranch = PlayBranchList.PlayBranchNormal
end

TownInfo.setTowns = function ( arg )

	data = arg or {}

end

TownInfo.isTownOpen = function ( TownId, thisPlayBranch )
	local list = {}

	TownInfo.PlayBranchEvent(function ( ... )
		list = data
	end, function ( ... )
		local nextTownIdSenior = require "AppData".getUserInfo().getData().NextTownIdSenior
		for i,value in ipairs(data) do
			if nextTownIdSenior == 0 then
				break
			end
			if value.TownId == nextTownIdSenior then
				table.insert(list, value)
				break
			end
			table.insert(list, value)
		end
	end, function ( ... )
		local NextTownIdHero = require "AppData".getUserInfo().getData().NextTownIdHero
		for i,value in ipairs(data) do
			if NextTownIdHero == 0 then
				break
			end
			if value.TownId == NextTownIdHero then
				table.insert(list, value)
				break
			end
			table.insert(list, value)
		end
	end, thisPlayBranch)

	for k,value in pairs(list) do
		if value.TownId == TownId then
			return value.IsOpen
		end
	end
	
	return false
end

TownInfo.openTown = function (  Town )
	
	local tmp = TownInfo.getTownById(Town.TownId)
	if tmp == nil then
		table.insert(data,Town)
	else
		for k,v in pairs(data) do
			if v.TownId == TownId then
				data[k] = Town
				break
			end
		end
	end

end

TownInfo.updateTowns = function ( towns )
	
	for k,v in pairs(towns) do
		TownInfo.openTown(v)
	end

end

TownInfo.isPubUnlock = function ( pubid )

	local dbtown = TownInfo.getDBTownByPub(pubid)
	if dbtown then
		return TownInfo.isTownOpen(dbtown.Id)
	end

	return false

end

TownInfo.getTownById = function ( TownId )
	
	for k,v in pairs(data) do
		if v.TownId == TownId then
			return v
		end
	end

	return nil

end

TownInfo.getTownsWithPub = function ( ... )

	if DBTownsWithPub == nil then
		DBTownsWithPub = {}
		local dbtable = require 'TownConfig'
		for k,v in pairs(dbtable) do
			if v.PubId ~= 0 then
				table.insert(DBTownsWithPub,v)
			end
		end
	end

	return DBTownsWithPub

end

TownInfo.getDBTownByPub = function ( pubid )
	
	local townspub = TownInfo.getTownsWithPub()
	for k,v in pairs(townspub) do
		if v.PubId == pubid then
			return v
		end
	end

end

function TownInfo.getLastTownId( areaId )
	local dbManager = require "DBManager"
	local gameFunc = require "AppData"

	if lastTownId then
		local dbTownInfo = dbManager.getInfoTownConfig(lastTownId)
		if dbTownInfo and dbTownInfo.AreaId == areaId then
			return lastTownId
		else
			lastTownId = nil
		end
	else
		local curAreaId = gameFunc.getTempInfo().getAreaId()
		if areaId == curAreaId then
			return gameFunc.getUserInfo().getNextTownId()
		elseif areaId < curAreaId then
			for k,v in pairs(data) do
				local dbTownInfo = dbManager.getInfoTownConfig(v.TownId)
				if dbTownInfo and dbTownInfo.AreaId == areaId and dbTownInfo.LastTown > 0 then
					return v.TownId
				end
			end
		end
	end
	return nil
end

function TownInfo.setLastTownId( townId )
	lastTownId = townId
end

function TownInfo.getNewTown( towns )
	for k,v in pairs(towns) do
		if not TownInfo.getTownById(v.TownId) then
			return v
		end
	end
	return nil
end

function TownInfo.getTowns( ... )
	return data
end

function TownInfo.setTown( newTown )
	local canFind = false
	for k,v in pairs(data) do
		if v.TownId == newTown.TownId then
			data[k] = newTown
			canFind = true
			break
		end
	end
	if not canFind then
		table.insert(data, newTown)
	end

	TownInfo.updateAreaBoxDoneWithTown( newTown )
end

function TownInfo.getStarAmount( areaId )
	local amount = 0
	local dbManager = require "DBManager"
	for k,v in pairs(data) do
		local dbTown = dbManager.getInfoTownConfig(v.TownId)
		if dbTown and dbTown.AreaId == areaId then
			amount = amount + v.Stars
		end
	end
	return amount
end

function TownInfo.getStarAmountAllArea( ... )
	local amount = 0
	for i=1,5 do
		amount = amount + TownInfo.getStarAmount(i)
	end
	return amount
end

function TownInfo.setAreaBoxList( list, areaId )
	areaBoxList[areaId] = list
end

function TownInfo.getAreaBoxList( areaId )
	return areaBoxList[areaId]
end

function TownInfo.setAreaBox( areaBox )
	if areaBoxList[areaBox.AreaId] then
		for i,v in ipairs(areaBoxList[areaBox.AreaId]) do
			if v.ConfigId == areaBox.ConfigId then
				areaBoxList[areaBox.AreaId][i] = areaBox
				break
			end
		end
	else
		areaBoxList[areaBox.AreaId] = {}
		areaBoxList[areaBox.AreaId][1] = areaBox
	end
end

function TownInfo.getAreaBoxWithId( areaBoxId )
	local dbManager = require "DBManager"
	local dbAreaReward = dbManager.getAreaRewardWithId(areaBoxId)
	if dbAreaReward then
		if areaBoxList[dbAreaReward.AreaId] then
			for k,v in pairs(areaBoxList[dbAreaReward.AreaId]) do
				if v.ConfigId == areaBoxId then
					return v
				end
			end
		end
	end
	return nil
end

function TownInfo.updateAreaBoxDoneWithTown( newTown )
	local dbManager = require "DBManager"
	local dbTownInfo = dbManager.getInfoTownConfig( newTown.TownId )
	local starAmount = TownInfo.getStarAmount(dbTownInfo.AreaId)
	local list = TownInfo.getAreaBoxList(dbTownInfo.AreaId)
	if list then
		for i,v in ipairs(list) do
			local dbAreaReward = dbManager.getAreaRewardWithId(v.ConfigId)
			if starAmount >= dbAreaReward.Stars then
				v.Done = true
			end
		end
	end
end

function TownInfo.checkAreaBoxCanGetReward( areaId )
	if areaBoxList[areaId] then
		for i,v in ipairs(areaBoxList[areaId]) do
			if v.Done and not v.RewardGot then
				return true
			end
		end
	end
	return false
end

function TownInfo.checkAreaBoxGetAllRewards( areaId )
	local result = false
	if areaBoxList[areaId] then
		result = true
		for i,v in ipairs(areaBoxList[areaId]) do
			if not v.RewardGot then
				result = false
				break
			end
		end
	end
	return result
end

function TownInfo.setLastBattleStageId( id )
	lastBattleStageId = id
end

function TownInfo.getLastBattleStageId( ... )
	return lastBattleStageId
end

function TownInfo.getPlayBranch( ... )
	return PlayBranch
end

function TownInfo.setPlayBranch( branch )
	PlayBranch = branch
end

function TownInfo.isPlayBranchNormal( playBranch )
	local branch = playBranch ~= nil and playBranch or PlayBranch
	return branch == PlayBranchList.PlayBranchNormal
end

function TownInfo.getPlayBranchList( ... )
	return PlayBranchList
end

function TownInfo.PlayBranchEvent( callback1, callback2, callback3, playBranch )
	local branch = playBranch ~= nil and playBranch or PlayBranch
	if branch == PlayBranchList.PlayBranchNormal then
		if callback1 then
			callback1()
		end
	elseif branch == PlayBranchList.PlayBranchSenior then
		if callback2 then
			callback2()
		end
	elseif branch == PlayBranchList.PlayBranchHero then
		if callback3 then
			callback3()
		end		
	end
end

return TownInfo