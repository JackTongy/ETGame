--[[
		Explore 探宝数据
		字段 类型 说明
		Sid Int 槽位 id
		Hours Int 时长（小时）
		Pid Long 精灵唯一 id
		Finish Bool 已完成
		EndAt DateTime 完成时间点
]]

local TimeListManager = require 'TimeListManager'
local EventCenter = require 'EventCenter'
local TimeManager = require 'TimeManager'

-- 探宝模块
local exploreFunc = {}
local exploreData = {}
local petInExplore = {}
local noticefication = {}
local exploreRob = {}

function exploreFunc.cleanData()
	exploreData = {}
	petInExplore = {}
	noticefication = {}
	exploreRob = {}
end

function exploreFunc.getExploreData(  )
	return exploreData
end

function exploreFunc.updateEarliestCompleteClock()
	noticefication.item = nil
	local earliestTime = nil
	for k, v in pairs(exploreData) do
		if v.Pid ~= 0 then
			local temp = TimeManager.getTimestampLocal(v.EndAt)
			if not earliestTime or earliestTime > temp then
				earliestTime = temp
				noticefication.item = v
			end
		end
	end

	if noticefication.item then
	    local offSet = -TimeManager.timeOffset(noticefication.item.EndAt)
		TimeListManager.addToTimeList(TimeListManager.packageTimeStruct("explore", offSet, function (delta)
			if delta <= 0 then
				require 'framework.helper.Utils'.delay(function ()
					EventCenter.eventInput("explore")
				end, 2)
			end
		end))
	end
end

function exploreFunc.getEarliestCompleteTime()
	if not noticefication.item then return -1 end
	local offSet = -TimeManager.timeOffset(noticefication.item.EndAt)
	if offSet < 0 then 
		offSet = 0
	end
	return offSet
end

function exploreFunc.hasCompleteExplore()
	return exploreFunc.getEarliestCompleteTime() == 0
end

function exploreFunc.hasEmptySlot()
	for i = 1, #exploreData do
		if exploreData[i].Pid == 0 then
            local config = require "DBManager".getExploreConfig(i)
            if config.UnlockLv <= require 'UserInfo'.getLevel() or (config.UnlockVip > 0 and config.UnlockVip <= require 'UserInfo'.getVipLevel()) then
            	return true
            end
        end
    end
    return false
end

function exploreFunc.setExploreData(data)
	exploreData = data
	-- reset table
	petInExplore = {}
	if exploreData and next(exploreData) then
		for k, v in pairs(exploreData) do
			petInExplore[v.Pid] = true
		end
	end
	exploreFunc.updateEarliestCompleteClock()
end

function exploreFunc.petInExploration(ID)
	return petInExplore[ID]
end

function exploreFunc.setExploreRob( robData )
	exploreRob = robData
end

function exploreFunc.getExploreRob( ... )
	return exploreRob
end

return exploreFunc