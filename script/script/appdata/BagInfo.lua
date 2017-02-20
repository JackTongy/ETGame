--[[
		道具信息（Material）
		字段 			类型			说明
		Id 				Int				主键 id
		MaterialId 		Int 				道具配置 id
		Amount 		Int 				数量
		Seconds		Int				限时时间
		CreateAt		DateTime		创建时间
]]

local dbManager = require "DBManager"
local timeUtil = require "TimeListManager"
local res = require "Res"

-- 背包模块
local bagFunc = {}
local bagData = {}
local bagPackList = {} -- 运营礼包
local egg

function bagFunc.cleanData()
	bagData = {}
	bagPackList = {} -- 运营礼包
	egg = nil
end

function bagFunc.getItemByMID( id )
	local item = {}
	item.MaterialId = id
	item.Amount = 1
	item.Seconds = 0
	return item
end

-- 返回背包中的道具
function bagFunc.getItems(  )
	bagFunc.removeItemsOutOfDate()
	return bagData
end

-- 设置背包中的道具
function bagFunc.setItems( items )
	bagData = items or {}
	bagFunc.sortItemList(bagData)
end

function bagFunc.getItemWithItemId( itemId )
	for k,v in pairs(bagData) do
		if v.MaterialId == itemId and v.Amount > 0 then
			return v
		end
	end
	return nil
end

function bagFunc.setItem( material )
	for k,v in pairs(bagData) do
		if v.MaterialId == material.MaterialId then
			if v.Amount == 0 then
				table.remove(bagData, k)
			else
				bagData[k] = material
			end
			break
		end
	end
end

-- 检测是否可以使用道具
function bagFunc.isItemCanUse( nMaterialId, count )
	count = count or 1
	local nMaterial
	for k,v in pairs(bagData) do
		if v.Id == nMaterialId then
			nMaterial = v
			break
		end
	end
	local errMsg
	local gotoMall
	if nMaterial then
		if bagFunc.isItemOutOfDate(nMaterial) then
			errMsg = res.locString("Bag$MaterialIsOutOfDate")
		else
			if nMaterial.Amount >= count then
				local dbMaterial = dbManager.getInfoMaterial(nMaterial.MaterialId)
				if dbMaterial then
					if dbMaterial.consume == 0 then
						return true
					else
						local consumeList = bagFunc.getItemListByMID(dbMaterial.consume)
						if consumeList and #consumeList > 0 then
							return true
						else
							local dbConsume = dbManager.getInfoMaterial(dbMaterial.consume)
							gotoMall = string.format(res.locString("Bag$MaterialGotoMall"), dbConsume.name)
						end
					end
				else
					errMsg = res.locString("Bag$MaterialDBCanFound")
				end
			else
				errMsg = res.locString("Bag$MaterialNotEnough")
			end	
		end
	else
		errMsg = res.locString("Bag$MaterialCanFound")
	end
	if not errMsg then
		errMsg = res.locString("Bag$MaterialUseFailed")
	end
	return false, errMsg, gotoMall
end

function bagFunc.getItemListByMID( materialId )
	local itemDidUse = {}
	for i,v in ipairs(bagData) do
		if v.MaterialId == materialId and v.Amount > 0 and not bagFunc.isItemOutOfDate(v) then
			table.insert(itemDidUse, i)
		end
	end

	table.sort(itemDidUse,function ( a,b )
		a,b = bagData[a],bagData[b]
		if a.Seconds == 0 then
			return false
		elseif b.Seconds == 0 then
			return true
		else
			local lastA = a.Seconds-timeUtil.getTimeUpToNow(a.CreateAt)
			local lastB = b.Seconds-timeUtil.getTimeUpToNow(b.CreateAt)
			return lastA<lastB
		end
	end)

	return itemDidUse
end

function bagFunc.useItemByID( id,cnt )
	if not cnt then
		cnt = 1
	end
	local needRemove,consume,redPoint
	for i,v in ipairs(bagData) do
		if v.Id == id then
			v.Amount = v.Amount - cnt
			local materialInfo = dbManager.getInfoMaterial(v.MaterialId)
			consume = materialInfo and materialInfo.consume
			redPoint = materialInfo and materialInfo.red_point
			if v.Amount == 0 then
				needRemove = i
			end
			break
		end
	end
	if needRemove then
		table.remove(bagData,needRemove)
	end

	if consume and consume>0 then
		bagFunc.useItem(consume,cnt,true)
	end
	if redPoint and redPoint > 0 then
		require "EventCenter".eventInput("UpdatePoint")
	end
	require "EventCenter".eventInput("UpdateMaterial")
end

-- 使用道具
--flag:递归调用时设置为true,避免重复递归使用道具
function bagFunc.useItem( materialId,cnt,flag)
	if not cnt then
		cnt = 1
	end

	local itemDidUse = bagFunc.getItemListByMID(materialId)

	local index = 1
	local needRemove = {}
	local count = cnt
	while count>0 do
		if index > #itemDidUse then
			break
		end
		local i = itemDidUse[index]
		local remove  = math.min(bagData[i].Amount,count)
		bagData[i].Amount  = bagData[i].Amount - remove
		if bagData[i].Amount==0 then
			table.insert(needRemove,i)
		end
		index = index + 1
		count = count - remove
	end

	table.sort(needRemove,function ( a,b )
		return a>b
	end)

	for i=1,#needRemove do
		table.remove(bagData,needRemove[i])
	end
	if not flag then
		local materialInfo = dbManager.getInfoMaterial(materialId)
		local consume = materialInfo and materialInfo.consume

		if consume and consume>0 then
			bagFunc.useItem(consume,cnt,true)
		end
	end
end

-- 获取道具数量
function bagFunc.getItemCount( materialId )
	local count = 0
	for k,v in pairs(bagData) do
		if v.MaterialId == materialId and not bagFunc.isItemOutOfDate(v) then
			count = count+v.Amount
		end
	end
	return count
end

-- 道具排序
function bagFunc.sortItemList( list )
	table.sort(list, function ( a, b )
		if (a.Seconds == 0 and b.Seconds == 0) or (a.Seconds > 0 and b.Seconds > 0) then
			local itemInfo1 = dbManager.getInfoMaterial(a.MaterialId)
			local itemInfo2 = dbManager.getInfoMaterial(b.MaterialId)
			if itemInfo1 and itemInfo2 then
				if itemInfo1.sort < itemInfo2.sort then
					return true
				elseif itemInfo1.sort == itemInfo2.sort then
					if itemInfo1.materialid < itemInfo2.materialid then
						return true
					end 
				end
			end
		else
			return a.Seconds > b.Seconds
		end
	end)
end

-- 替换道具
function bagFunc.exchangeItem( itemList )
	print(bagData)
	local countChange = false
	local boxChange = false
	local redPointHome = false
	for k,v in pairs(itemList) do
		if v.MaterialId == 22 then
			require "MATHelper":Change(3, v.Amount, bagFunc.getItemCount(v.MaterialId))
		elseif v.MaterialId == 23 then
			require "MATHelper":Change(2, v.Amount, bagFunc.getItemCount(v.MaterialId))
		elseif v.MaterialId == 42 then
			require "MATHelper":Change(5, v.Amount, bagFunc.getItemCount(v.MaterialId))
		end

		local canFind = false
		for k2,v2 in pairs(bagData) do
			if v2.Id == v.Id then
				bagData[k2] = v
				canFind = true
				break
			end
		end
		if canFind == false then
			table.insert(bagData, v)
			countChange = true
		end

		local dbMaterial = dbManager.getInfoMaterial(v.MaterialId)
		if dbMaterial and dbMaterial.red_point > 0 then
			boxChange = true
		end
		if v.MaterialId >= 22 and v.MaterialId <= 23 then
			redPointHome = true
		end
	end
	if countChange then
		bagFunc.sortItemList(bagData)
	end
	if boxChange then
		require "EventCenter".eventInput("UpdatePoint")
	end
	if redPointHome then
		require "EventCenter".eventInput("RedPointHome")
	end
	require "EventCenter".eventInput("UpdateMaterial")
end

-- 获取道具在排序中的序号
-- function bagFunc.getIndexOfItem( item )
-- 	for i,v in ipairs(bagData) do
-- 		if v.MaterialId == item.MaterialId then
-- 			return i
-- 		end
-- 	end
-- 	return 0
-- end

-- 装备是否过期
function bagFunc.isItemOutOfDate( item )
	if item.Seconds > 0 then
		local seconds = timeUtil.getTimeUpToNow(item.CreateAt)
		if seconds >= item.Seconds then
			return true
		end
	end
	return false
end

-- 移除过期的道具
function bagFunc.removeItemsOutOfDate( ... )
	for i=#bagData,1,-1 do
		if bagFunc.isItemOutOfDate(bagData[i]) then
			table.remove(bagData, i)
		end
	end
end

-- 设置运营礼包
function bagFunc.setPackList( packList )
	bagPackList = packList
end

-- 获得运营礼包
function bagFunc.getPackList( ... )
	return bagPackList
end

-- 更新运营礼包
function bagFunc.updatePackList( packList )
	if bagPackList then
		for i,v in ipairs(packList) do
			local canFind = false
			for ii,vv in ipairs(bagPackList) do
				if vv.Id == v.Id then
					canFind = true
					bagPackList[ii] = v
					break
				end
			end
			if not canFind then
				table.insert(bagPackList, v)
			end
		end
	else
		bagPackList = packList
	end
end

function bagFunc.usePack( id, count )
	if bagPackList then
		for i,v in ipairs(bagPackList) do
			if v.Id == id then
				bagPackList[i].Amount = math.max(bagPackList[i].Amount - (count or 1), 0)
				if bagPackList[i].Amount == 0 then
					table.remove(bagPackList, i)
				end
				break
			end
		end
	end
end

function bagFunc.setEgg( theEgg )
	egg = theEgg
end

function bagFunc.getEgg( ... )
	return egg
end

function bagFunc.useEgg( ... )
	egg = nil
end

function bagFunc.updateItemCount( Material )
	for k,v in pairs(bagData) do
		if v.MaterialId == Material.MaterialId then
			v.Amount = Material.Amount
		end
	end
end

function bagFunc.updateItemsCount( Materials )
	if Materials then
		for k,v in pairs(Materials) do
			bagFunc.updateItemCount(v)
		end
	end
end

function bagFunc.getPetEggLastTime( ... )
	local nEgg = bagFunc.getEgg()
	local lastTime = -1
	if nEgg then
		lastTime = - math.floor(require "TimeListManager".getTimeUpToNow(nEgg.EndAt))
		lastTime = math.max(lastTime, 0)
	end
	return lastTime
end

function bagFunc.getItemWithMaterial( materialId )
	local nMaterial
	for k,v in pairs(bagData) do
		if v.MaterialId == materialId and not bagFunc.isItemOutOfDate(v) then
			nMaterial = v
			break
		end
	end
	return nMaterial
end

return bagFunc