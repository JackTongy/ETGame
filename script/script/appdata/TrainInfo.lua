--[[
		训练槽位 (TrainSlot)
		字段 				类型 				说明
		Rid 				Int 					玩家 id
		SlotId 				Int 					槽位编号
		Type 				Int 					训练模式
		Pid 				Long 				精灵唯一 id
		StarTime 			String 				训练开始时间(yy-m-d h:m:s)
]]

-- 精灵训练模块

local trainFunc = {}
local trainData = {}

function trainFunc.cleanData()
	trainData = {}
end

-- 返回训练列表（已解锁）
function trainFunc.getList(  )
	return trainData
end

-- 设置训练列表
function trainFunc.setList( list )
	trainData = list
end

-- 返回某一个槽位的训练信息
function trainFunc.getTrainSlotWithSlotId( slotId )
	for k,v in pairs(trainData) do
		if v.SlotId == slotId then
			return v
		end
	end
end

-- 设置某一个槽位的训练信息
function trainFunc.setTrainSlot( slot )
	for i,v in ipairs(trainData) do
		if v.Id == slot.Id then
			trainData[i] = slot
			break
		end
	end
end

-- 精灵是否在训练中
function trainFunc.isPetInTrain( nPetId )
	for k,v in pairs(trainData) do
		if v.Pid == nPetId then
			return true
		end
	end
	return false
end

-- 是否有精灵还在训练中
function trainFunc.isAnyPetInTrain( ... )
	for k,v in pairs(trainData) do
		if v.Pid > 0 then
			return true
		end
	end
	return false
end


-- 返回训练UI模型列表{petId = ..., state = ..., type = ..., seconds = ... }
function trainFunc.getTrainUIModelList(  )
	local slotList = trainFunc.getList()
	local list = {}
	local seconds = 0
	local curTimer = require "TimeManager".getCurrentSeverTime() / 1000
	for i=1,8 do
		local temp = {}
		temp.slotId = i
		if i <= #slotList then
			temp.petId = slotList[i].Pid
			if slotList[i].Pid == 0 then
				temp.state = 3
			else
				temp.type = slotList[i].Type
				seconds = 8 * 3600 - math.max(curTimer - require "TimeListManager".getTimestamp(slotList[i].StartTime), 0)
				temp.seconds = math.max(seconds, 0)
				if temp.seconds <= 0 then
					temp.state = 1
				else
					temp.state = 2
				end
			end
		else
			if i == #slotList + 1 then
				temp.state = 4
			else
				temp.state = 5
			end
		end
		table.insert(list, temp)
	end
	return list
end

return trainFunc