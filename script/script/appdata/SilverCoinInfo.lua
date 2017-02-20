local SilverCoinFunc = {}
local SilverCoinData = {}

function SilverCoinFunc.cleanData( ... )
	SilverCoinData = {}
end

function SilverCoinFunc.getRecord( ... )
	return SilverCoinData.Record
end

function SilverCoinFunc.setRecord( record )
	SilverCoinData.Record = record or {}
end

function SilverCoinFunc.getBuys( ... )
	return SilverCoinData.Buys
end

function SilverCoinFunc.setBuys( Buys )
	SilverCoinData.Buys = Buys or {}
end

function SilverCoinFunc.getSells( ... )
	return SilverCoinData.Sells
end

function SilverCoinFunc.setSells( Sells )
	SilverCoinData.Sells = Sells or {}
end

function SilverCoinFunc.getStarAmount( ... )
	return SilverCoinData.StarAmount
end

function SilverCoinFunc.setStarAmount( StarAmount )
	SilverCoinData.StarAmount = StarAmount
end

function SilverCoinFunc.GoodBuyed( Id )
	if SilverCoinData.Buys then
		for i,v in ipairs(SilverCoinData.Buys) do
			if v.Id == Id then
				SilverCoinData.Buys[i].Used = true
				break
			end
		end
	end
end

return SilverCoinFunc