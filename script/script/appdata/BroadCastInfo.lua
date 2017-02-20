--[[
friend_invite 
friend_receiveAP
friend_verify
letter_sys
letter_friend
task_reward
]]

local data = {}
local BroadCastInfo = {}

function BroadCastInfo.cleanData()
	data = {}
end

function BroadCastInfo.setData( arg )
	data = arg
end

function BroadCastInfo.set( key,V)
	data[key] = V
	require 'EventCenter'.eventInput("UpdatePoint")
end

function BroadCastInfo.get( key )
	if key then
		return data[key] or false
	else
		return false
	end
end

local ActivityKey = 
{
	-- 'training',
	'roast_duck',
	'daily_charge',
	'onece_charge',
	'total_charge',
	'total_consume',
	'lv_top',
	'time_pet',
	'pray',
	'monday_gift',
	'login_gift',
	'fund',
	'tuangou',
	'lucky_lottery',
	'seven_day_reward',
}

function BroadCastInfo.getActivity( ... )
	for k,v in pairs(ActivityKey) do
		if BroadCastInfo.get(v) then
			return true
		end
	end
	return false
end

return BroadCastInfo