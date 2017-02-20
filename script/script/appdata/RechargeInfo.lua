local RechargeInfo = {}
local data = nil

function RechargeInfo.cleanData()
	data = nil
end

function RechargeInfo.setData(arg)
	data = arg
end

function RechargeInfo.getData( ... )
	return data
end

function RechargeInfo.FcRewardGotEnable( ... )
	return data and data.ChargeTotal > 0
end

function RechargeInfo.isFcRewardGot( ... )
	return data and data.FcRewardGot
end

function RechargeInfo.isFcRewardEnable( ... )
	return data and (not data.FcRewardGot)
end

function RechargeInfo.setFcRewardGot( v )
	if data then
		data.FcRewardGot = v
	end	
end

return RechargeInfo