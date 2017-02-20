-- 道具商城模块
local itemMallFunc = {}
local itemMallData = {}

function itemMallFunc.cleanData()
	itemMallData = {}
end

function itemMallFunc.setGoods( goods )
	itemMallData.goods = goods
end

function itemMallFunc.getGoods(  )
	if itemMallData.goods then
		local timeListManager = require "TimeListManager"
		for i = #itemMallData.goods, 1, -1 do
			if timeListManager.getTimeUpToNow(itemMallData.goods[i].CloseAt) >= 0 then
				table.remove(itemMallData.goods, i)
				break
			end

			if timeListManager.getTimeUpToNow(itemMallData.goods[i].OpenAt) < 0 then
				table.remove(itemMallData.goods, i)
				break
			end
		end
	end
	return itemMallData.goods
end

function itemMallFunc.getItems(  )
	return require "material"
end

function itemMallFunc.getItemsSaleInShop(  )
	local temp = {}
	local list = require "material"
	local userFunc = require "UserInfo"
	for i,v in ipairs(list) do
		if v.isshow and v.isshow > 0 and userFunc.getLevel() >= v.unlocklv then
			table.insert(temp, v)
		end
	end
	return temp
end

-- 商城是否正在打折
function itemMallFunc.isDiscounting( ... )
	local activeData = require "ActivityInfo".getDataByType(2)
	if activeData and activeData.CloseAt then
		return require "TimeListManager".getTimeUpToNow(activeData.CloseAt) < 0
	end
	return false
end

function itemMallFunc.getMaterialDiscount( materialId )
	local activeData = require "ActivityInfo".getDataByType(2)
	if activeData and activeData.Data then
		for k,v in pairs(activeData.Data) do
			if tonumber(k) == materialId then
				return v
			end
		end
	end
	return nil
end

function itemMallFunc.setBuyRecord( BuyRecord )
	itemMallData.BuyRecord = BuyRecord
end

function itemMallFunc.getBuyRecord(  )
	return itemMallData.BuyRecord
end

function itemMallFunc.getBuyRecordDm( materialId )
	for k,v in pairs(itemMallData.BuyRecord.Dms) do
		if materialId == tonumber(k) then
			return v
		end
	end
	return 0
end

function itemMallFunc.getBuyRecordDg( gid )
	for k,v in pairs(itemMallData.BuyRecord.Dgs) do
		if gid == tonumber(k) then
			return v
		end
	end
	return 0
end

function itemMallFunc.getBuyRecordTg( gid )
	for k,v in pairs(itemMallData.BuyRecord.Tgs) do
		if gid == tonumber(k) then
			return v
		end
	end
	return 0
end

function itemMallFunc.setBuyRecordDm( materialId, amountOffset )
	local canFind = false
	for k,v in pairs(itemMallData.BuyRecord.Dms) do
		if materialId == tonumber(k) then
			itemMallData.BuyRecord.Dms[k] = v + amountOffset
			canFind = true
			break
		end
	end
	if not canFind then
		itemMallData.BuyRecord.Dms[materialId] = amountOffset
	end
end

function itemMallFunc.setBuyRecordDg( gid, amountOffset )
	local canFind = false
	for k,v in pairs(itemMallData.BuyRecord.Dgs) do
		if gid == tonumber(k) then
			itemMallData.BuyRecord.Dgs[k] = v + amountOffset
			canFind = true
			break
		end
	end
	if not canFind then
		itemMallData.BuyRecord.Dgs[gid] = amountOffset
	end
end

function itemMallFunc.setBuyRecordTg( gid )
	local canFind = false
	for k,v in pairs(itemMallData.BuyRecord.Tgs) do
		if materialId == tonumber(k) then
			itemMallData.BuyRecord.Tgs[k] = v + amountOffset
			canFind = true
			break
		end
	end
	if not canFind then
		itemMallData.BuyRecord.Tgs[gid] = amountOffset
	end
end

function itemMallFunc.updateBuyRecord( nGood, amountOffset )
	if nGood.Lm == 2 then
		itemMallFunc.setBuyRecordDg(nGood.Gid, amountOffset)	
	elseif nGood.Lm == 3 then
		itemMallFunc.setBuyRecordTg(nGood.Gid, amountOffset)
	end
end

return itemMallFunc