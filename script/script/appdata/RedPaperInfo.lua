local redPaperFunc = {}
local redPaperData = {}

function redPaperFunc.cleanData()
	redPaperData = {}
end

function redPaperFunc.setRankList( list )
	redPaperData.rankList = list
	table.sort(redPaperData.rankList, function ( v1, v2 )
		return v1.Rank < v2.Rank
	end)
end

function redPaperFunc.getRankList( ... )
	return redPaperData.rankList
end

function redPaperFunc.setMySummary( data )
	redPaperData.mySummary = data
end

function redPaperFunc.getMySummary( ... )
	return redPaperData.mySummary
end

function redPaperFunc.setEndAt( EndAt )
	redPaperData.EndAt = EndAt
end

function redPaperFunc.getEndAt( ... )
	return redPaperData.EndAt
end

function redPaperFunc.setRecords( records )
	redPaperData.records = records
end

function redPaperFunc.getRecords( ... )
	return redPaperData.records
end

function redPaperFunc.setRecordsEx( recordsEx )
	redPaperData.recordsEx = recordsEx
end

function redPaperFunc.getRecordsEx( ... )
	return redPaperData.recordsEx
end

function redPaperFunc.setItems( items )
	redPaperData.items = items
end

function redPaperFunc.getItems( ... )
	return redPaperData.items
end

function redPaperFunc.getExRecordWithId( id )
	if redPaperData.recordsEx then
		for i,v in ipairs(redPaperData.recordsEx) do
			if v.ExId == id then
				return v.TimesLeft
			end
		end
	end
	return -1
end

return redPaperFunc