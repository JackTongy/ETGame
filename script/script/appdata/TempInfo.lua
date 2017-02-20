local tempData = {}
local tempFunc = {}

function tempFunc.cleanData()
	tempData = {}
end

function tempFunc.getHomeToolBarVisible(  )
	return tempData.homeToolBarVisible or false
end

function tempFunc.setHomeToolBarVisible( visible )
	tempData.homeToolBarVisible = visible
end

function tempFunc.getHomeMenuStatus( ... )
	return tempData.homeMenuStatus or false
end

function tempFunc.setHomeMenuStatus( status )
	tempData.homeMenuStatus = status
end

function tempFunc.getAreaId(  )
	local AreaId
	require "TownInfo".PlayBranchEvent(function ( ... )
		AreaId = tempData.areaId
	end, function ( ... )
		local dbTownInfo = require "DBManager".getInfoTownConfig(require "AppData".getUserInfo().getData().NextTownIdSenior)
		AreaId = dbTownInfo.AreaId
	end, function ( ... )
		local dbTownInfo = require "DBManager".getInfoTownConfig(require "AppData".getUserInfo().getData().NextTownIdHero)
		AreaId = dbTownInfo.AreaId
	end)
	return AreaId
end

function tempFunc.setAreaId( areaId )
	require "TownInfo".PlayBranchEvent(function ( ... )
		tempData.areaId = areaId
	end)
end

function tempFunc.setLastAreaId( areaId )
	tempData.lastAreaId = areaId
end

function tempFunc.getLastAreaId(  )
	return tempData.lastAreaId or tempData.areaId
end

function tempFunc.setTownIsClear( townIsClear )
	tempData.townIsClear = townIsClear
end

function tempFunc.getTownIsClear(  )
	return tempData.townIsClear
end

-- function tempFunc.setLastOpenTownId( lastOpenTownId )
-- 	tempData.lastOpenTownId = lastOpenTownId
-- end

-- function tempFunc.getLastOpenTownId(  )
-- 	return tempData.lastOpenTownId
-- end

function tempFunc.setHomeAdjustName( name )
	tempData.homeAdjustName = name
end

function tempFunc.getHomeAdjustName(  )
	return tempData.homeAdjustName
end

function tempFunc.resetData(  )
	tempData = {}
end

function tempFunc.setValueForKey( key, value )
	tempData[key] = value
end

function tempFunc.getValueForKey( key )
	return tempData[key]
end

return tempFunc