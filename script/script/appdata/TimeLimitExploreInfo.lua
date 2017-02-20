local TimeLimitExploreFunc = {}
local TimeLimitExploreData = {}

function TimeLimitExploreFunc.cleanData()
	TimeLimitExploreData = {}
end

function TimeLimitExploreFunc.setExplore( explore )
	TimeLimitExploreData.Explore = explore
end

function TimeLimitExploreFunc.getExplore( ... )
	return TimeLimitExploreData.Explore
end

function TimeLimitExploreFunc.setTimeCopyStageList( list )
	TimeLimitExploreData.TimeCopyStageList = list
end

function TimeLimitExploreFunc.getTimeCopyStageList( ... )
	return TimeLimitExploreData.TimeCopyStageList
end

function TimeLimitExploreFunc.getItems( ... )
	return TimeLimitExploreData.items
end

function TimeLimitExploreFunc.setItems( items )
	TimeLimitExploreData.items = items
end

function TimeLimitExploreFunc.setRecordsEx( recordsEx )
	TimeLimitExploreData.recordsEx = recordsEx
end

function TimeLimitExploreFunc.getRecordsEx( ... )
	return TimeLimitExploreData.recordsEx
end

function TimeLimitExploreFunc.getExRecordWithId( id )
	if TimeLimitExploreData.recordsEx then
		for i,v in ipairs(TimeLimitExploreData.recordsEx) do
			if v.ExId == id then
				return v.TimesLeft
			end
		end
	end
	return -1
end

function TimeLimitExploreFunc.getNetStageWithStageId( stageId )
	if TimeLimitExploreData.TimeCopyStageList then
		for k,v in pairs(TimeLimitExploreData.TimeCopyStageList) do
			if v.StageId == stageId then
				return v
			end
		end
	end
end

return TimeLimitExploreFunc