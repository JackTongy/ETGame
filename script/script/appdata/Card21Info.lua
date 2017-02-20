local Card21Func = {}
local Card21Data = {}

function Card21Func.cleanData()
	Card21Data = {}
end

function Card21Func.setCard21( card21 )
	Card21Data.Card21 = card21
end

function Card21Func.getCard21( ... )
	return Card21Data.Card21
end

function Card21Func.getItems( ... )
	return Card21Data.items
end

function Card21Func.setItems( items )
	Card21Data.items = items
end

function Card21Func.setRecordsEx( recordsEx )
	Card21Data.recordsEx = recordsEx
end

function Card21Func.getRecordsEx( ... )
	return Card21Data.recordsEx
end

function Card21Func.getExRecordWithId( id )
	if Card21Data.recordsEx then
		for i,v in ipairs(Card21Data.recordsEx) do
			if v.ExId == id then
				return v.TimesLeft
			end
		end
	end
	return -1
end

return Card21Func