--[[
		每日签到和 7 日登陆奖励（TaskLogin）
		字段 				类型 					说明
		SignTimes 			Int 						签到天数（每月初始为 1）
		IsGot 				Bool 					今日是否已签到
		ServDays 			List<Int> 				7 日登陆（默认都为 1，当为 2 时表示可领取，3 表示已领取）
]]

local taskLoginData = {}
local taskLoginFunc = {}

function taskLoginFunc.cleanData()
	taskLoginData = {}
end

function taskLoginFunc.setData( data )
	taskLoginData = data
end

function taskLoginFunc.getData(  )
	return taskLoginData
end

function taskLoginFunc.signInAddOne(  )
	taskLoginData.SignTimes = taskLoginData.SignTimes + 1
end

function taskLoginFunc.getRewardSuc( index )
	
	if taskLoginData and taskLoginData.SevenDays then
		taskLoginData.SevenDays[index] = 3
	end
	
end

function taskLoginFunc.getDayState(index)
	
	if taskLoginData.SevenDays then
		return taskLoginData.SevenDays[index]
	end

end

--[[七日奖励是都领取完]]
function taskLoginFunc.isSevenDayRewardDone()

	if taskLoginData.SevenDays then
		for k,v in pairs(taskLoginData.SevenDays) do
			if v ~= 3 then
				return false
			end
		end
		return true
	end
	return false
	
end

function taskLoginFunc.isSevenDayRewardActive( ... )
	print('isSevenDayRewardActive:')
	print(taskLoginData)
	if taskLoginData.SevenDays then
		for k,v in pairs(taskLoginData.SevenDays) do
			if v == 2 then
				return true
			end
		end
	end
	return false
end

function taskLoginFunc.isHaveState( state )
	if taskLoginData.SevenDays then
		for k,v in pairs(taskLoginData.SevenDays) do
			if v == state then
				return true
			end
		end
	end
	return false
end

function taskLoginFunc.getSevenDiscountDay( ... )
	print("getSevenDiscountDay")
	print(taskLoginData)
	local count = 0
	-- if not require 'AccountHelper'.isItemOFF('SevenDiscount') then
	-- 	if taskLoginData.SevenDiscount then
	-- 		count = #taskLoginData.SevenDiscount
	-- 	end
	-- end
	return count
end

function taskLoginFunc.getSevenDiscountCount( ... )
	if taskLoginData.SevenDiscount and #taskLoginData.SevenDiscount <= 7 then
		return taskLoginData.SevenDiscount[#taskLoginData.SevenDiscount]
	end
end

function taskLoginFunc.setLuxurySign( sign )
	taskLoginData.LuxurySign = sign
end

function taskLoginFunc.getLuxurySign( ... )
	return taskLoginData.LuxurySign
end

return taskLoginFunc