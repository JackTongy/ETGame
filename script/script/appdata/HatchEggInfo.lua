local HatchEggFunc = {}
local HatchEggData = {}

function HatchEggFunc.cleanData()
	HatchEggData = {}
end

function HatchEggFunc.setMyData( data )
	HatchEggData.MyData = data
end

function HatchEggFunc.getMyData( ... )
	return HatchEggData.MyData
end

function HatchEggFunc.setTotal( data )
	HatchEggData.Total = data
end

function HatchEggFunc.getTotal( ... )
	return HatchEggData.Total
end

function HatchEggFunc.setMyRank( data )
	HatchEggData.MyRank = data
end

function HatchEggFunc.getMyRank( ... )
	return HatchEggData.MyRank
end

function HatchEggFunc.setRanks( data )
	HatchEggData.Ranks = data
end

function HatchEggFunc.getRanks( ... )
	return HatchEggData.Ranks
end

function HatchEggFunc.getIntimateWithStep( step )
	local HatchEggConfig = require "AppData".getActivityInfo().getDataByType(46)
	local intimate = HatchEggData.Total
	if step > 1 then
		intimate = math.max(intimate - HatchEggConfig.Data.Energy[step - 1], 0)
	end
	return intimate
end

function HatchEggFunc.getCurStep( ... )
	local HatchEggConfig = require "AppData".getActivityInfo().getDataByType(46)
	local intimate = HatchEggData.Total
	for i=1,8 do
		if intimate < HatchEggConfig.Data.Energy[i] then
			return i
		end
	end
	return 8
end

function HatchEggFunc.isHatched( step )
	if HatchEggData.MyData and HatchEggData.MyData.Hatched then
		return HatchEggData.MyData.Hatched[step] > 0
	end
	return false
end

function HatchEggFunc.getEnergyList( ... )
	local list = {}
	local HatchEggConfig = require "AppData".getActivityInfo().getDataByType(46)
	if HatchEggConfig.Data.Energy then
		local last = 0
		for i,v in ipairs(HatchEggConfig.Data.Energy) do
			list[i] = v - last
			last = v
		end
	end
	return list
end

return HatchEggFunc