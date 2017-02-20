local Json = require "framework.basic.Json"

local data = nil
local other = {}
local Acs = {}
local ActivityStatus = {}

Acs.cleanData = function()
	data = nil
	other = {}
	ActivityStatus = {}
end

Acs.setData = function( arg )
	print("--------ActivityInfo------")
	print(arg)
	data = arg
end

--[[
取得对应活动的数据
活动一（酒馆活动）type=1
活动二（商城折扣）type=2
活动三（限时精灵）type=3
活动四（天天好礼）type=4
活动五（累计充值）type=5
活动六（消费好礼）type=6
活动七（疯狂兑换）type=7
活动八（充值好礼）type=8

(博士的任务)type=33
]]
Acs.getDataByType = function( Type )
	local tmp = nil
	if data then
		for k,v in pairs(data) do
			if v.Type == Type then
				tmp = v
				break
			end
		end
	end

	if tmp and not Acs.checkTimeEnable(tmp.CloseAt) then
		tmp = nil
		Acs.activityEnd(Type)
	end

	if tmp and tmp.Data and type(tmp.Data) == 'string' then
		tmp.Data = Json.decode(tmp.Data)
	end

	return tmp
end

Acs.checkTimeEnable = function ( time )
	local t = -require "TimeListManager".getTimeUpToNow(time)
	return t>0
end

Acs.activityEnd = function ( Type )
	if data then
		for i,v in ipairs(data) do
			if v.Type == Type then
				table.remove(data,i)
				break
			end
		end
	end
end

Acs.petHasDouble = function ( petId )

	local info = Acs.getDataByType(1)
	if info and info.Data then
		for k,v in pairs(info.Data) do
			if v.PetId == petId then
				return true
			end
		end
	end

	return false
end

Acs.setOther = function ( k,v)
	if k then
		other[k] = v
	end
end

Acs.getOther = function ( k )
	local v = other[k]
	if v and type(v) == 'table' and v.CloseAt then
		if not Acs.checkTimeEnable(v.CloseAt) then
			other[k] = nil
			v = nil
		end
	end
	return v
end

Acs.getActivityStatus = function ( ... )
	return ActivityStatus
end

Acs.getNdTenPrice = function ( ... )
	local db10 		= require 'DBManager'.getInfoDefaultConfig('Niudan10Cost')
	local actinfo 	= Acs.getDataByType(20)
	local price 	= (db10 and db10.Value) or '2340'
	if actinfo and actinfo.Data then
		local lastseconds = require 'TimeManager'.timeOffset(actinfo.CloseAt)
		local Discount    = tonumber(actinfo.Data.Discount)
		if lastseconds < 0 then
			price = math.floor(tonumber(price)*Discount)
		end
	end
    return tostring(price)
end

Acs.updateActivityInfo = function (info)
	if info then
		data = data or {}
		local found = false
		for k,v in pairs(data) do
			if v.Type == info.Type then
				found = true
				data[k] = info
				break
			end
		end

		if not found then
			table.insert(data,info)
		end
	end
end

return Acs