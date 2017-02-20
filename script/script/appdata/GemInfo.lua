--[[
	宝石信息（Gem）
	字段				类型				说明
	Id					Int					主键 id
	GemId				Int					宝石配置 id
	Lv 					Int 					等级
	SetIn 				Int 					装备于（装备 ID 默认 0）
	Seconds			Int 					活动时间
	CreateAt	 		Int 					时间戳
]]

local dbManager = require "DBManager"
local timeUtil = require "TimeListManager"

-- 宝石模块
local gemFunc = {}
local gemData = {}

function gemFunc.cleanData()
	gemData = {}
end

function gemFunc.getGemByGemID( id,Lv,Seconds )
	local gem = {}
	gem.GemId = id
	gem.Lv = Lv or 1
	gem.SetIn = 0
	gem.Seconds = Seconds or 0
	gem.Name = dbManager.getInfoGem(id).name
	return gem
end

-- 设置所有宝石
function gemFunc.setGemAll( gem )
	gemData = gem
end

-- 添加宝石列表
function gemFunc.addGemList( list )
	for i,v in ipairs(list) do
		table.insert(gemData, v)
	end
end

function gemFunc.updateGem( gem )
	local index = #gemData+1
	for i,v in ipairs(gemData) do
		if v.Id == gem.Id then
			index = i
			break
		end
	end
	gemData[index] = gem
end

-- 返回所有宝石
function gemFunc.getGemAll(  )
	gemFunc.removeGemsOutOfDate()
	gemFunc.sort(gemData)
	return gemData
end

-- 宝石排序
function gemFunc.sort( gemTable )
	-- if gemTable and #gemTable > 1 then
	-- 	table.sort(gemTable, function ( a, b )
	-- 		if a.SetIn > b.SetIn then
	-- 			return true
	-- 		elseif a.SetIn == b.SetIn then
	-- 			local compContinue = false
	-- 			if a.Seconds == b.Seconds and a.Seconds == 0 then
	-- 				compContinue = true
	-- 			elseif a.Seconds > 0 and b.Seconds == 0 then
	-- 				return true
	-- 			elseif a.Seconds > 0 and b.Seconds > 0 then
	-- 				if a.Seconds + a.CreateAt < b.Seconds + b.CreateAt then
	-- 					return true
	-- 				elseif a.Seconds + a.CreateAt == b.Seconds + b.CreateAt then
	-- 					compContinue = true
	-- 				end
	-- 			end
	-- 			if compContinue then
	-- 				local gem1 = dbManager.getInfoGem(a.GemId)
	-- 				local gem2 = dbManager.getInfoGem(b.GemId)
	-- 				if gem1.type > gem2.type then
	-- 					return true
	-- 				elseif gem1.type == gem2.type then
	-- 					if a.GemId > b.GemId then
	-- 						return true
	-- 					elseif a.GemId == b.GemId then
	-- 						if a.Lv > b.Lv then
	-- 							return true
	-- 						end
	-- 					end 
	-- 				end
	-- 			end
	-- 		end
	-- 	end)
	-- end
end

-- 返回佩戴的宝石
function gemFunc.getGemEquiped(  )
	gemFunc.removeGemsOutOfDate()
	local temp = {}
	for k,v in pairs(gemData) do
		if v.SetIn ~= 0 then
			table.insert(temp, v)
		end
	end
	gemFunc.sort(temp)
	return temp
end

-- 返回佩戴于精灵ID为Id的宝石
function gemFunc.getGemWithPetId(petID)
	assert(petID > 0)
	local temp = {}
	for k, v in pairs(gemData) do
		if v.SetIn == petID then
			table.insert(temp, v)
		end
	end
	--gemFunc.sort(temp)
	return temp
end

function gemFunc.getOffGem(petID)
	assert(petID > 0)
	for i = 1, #gemData do
		if gemData[i].SetIn == petID then
			gemData[i].SetIn = 0
		end
	end
end

function gemFunc.selectGemsByCondition( condition )
	gemFunc.removeGemsOutOfDate()
	local ret = {}
	for k,v in pairs(gemData) do
		if condition(v) then
			table.insert(ret,v)
		end
	end
	gemFunc.sort(ret)
	return ret
end

function gemFunc.getGemWithType(gemType)
	gemFunc.removeGemsOutOfDate()
	if gemType == 0 then
		return gemData
	end
	
	local temp = {}
	for k,v in pairs(gemData) do
		local gem = dbManager.getInfoGem(v.GemId)
		if gem and gem.type == gemType then
			table.insert(temp, v)
		end
	end
	gemFunc.sort(temp)
	return temp
end

function gemFunc.getGemAvailableByType(gemType)
	gemFunc.removeGemsOutOfDate()
	if gemType == 0 then
		return gemData
	end
	
	local temp = {}
	for k, v in pairs(gemData) do
		if v.SetIn == 0 then
			local gem = dbManager.getInfoGem(v.GemId)
			if gem and gem.type == gemType then
				table.insert(temp, v)
			end
		end
	end
	--gemFunc.sort(temp)
	return temp
end

function gemFunc.getGemAmountX()
	return #gemData
end

-- 返回对应ID的宝石
function gemFunc.getGemWithId( id )
	for k,v in pairs(gemData) do
		if v.Id == id then
			return v
		end
	end
	return nil
end

-- 宝石比较
function gemFunc.isGemEqualToAnother( gem1, gem2 )
	return gem1.GemId == gem2.GemId and gem1.Lv == gem2.Lv
end

-- 升级gem可选原材料的宝石列表
function gemFunc.getLevelUpRawList( gem )
	gemFunc.removeGemsOutOfDate()
	local temp = {}
	local dbGem = dbManager.getInfoGem(gem.GemId)
	for k,v in pairs(gemData) do
		if v.Id ~= gem.Id and v.SetIn == 0 and v.Seconds == 0 then
			local vDbGem = dbManager.getInfoGem(v.GemId)
			if dbGem.type == vDbGem.type then
				table.insert(temp, v)
			end
		end
	end
	gemFunc.sort(temp)
	return temp
end

-- 删除宝石列表
function gemFunc.removeGemList( gemIdList )
	for k,v in pairs(gemIdList) do
		for i=#gemData,1, -1 do
			if v == gemData[i].Id then
				table.remove(gemData, i)
				break
			end
		end
	end
end

function gemFunc.getGemAmountList( gemList )
	local result = {}
	for k,v in pairs(gemList) do
		local canFind = false
		for k2,v2 in pairs(result) do
			if gemFunc.isGemEqualToAnother(v2, v) then
				v2.amount = v2.amount + 1
				canFind = true
				break
			end
		end
		if not canFind then
			table.insert(result, {GemId = v.GemId, Lv = v.Lv, amount = 1})
		end
	end
	return result
end

function gemFunc.isGemOutOfDate( gem )
	if gem.Seconds > 0 then
		local seconds = timeUtil.getTimeUpToNow(gem.CreateAt)
		if seconds >= gem.Seconds then
			return true
		end
	end
	return false
end

function gemFunc.removeGemsOutOfDate( ... )
	for i=#gemData,1,-1 do
		if gemFunc.isGemOutOfDate(gemData[i]) then
			table.remove(gemData, i)
		end
	end
end

function gemFunc.getGemAmount( GemId,idle )
	local amount = 0
	for k,v in pairs(gemData) do
		if v.GemId == GemId and (v.SetIn == 0 or not idle) then
			amount = amount + 1
		end
	end
	return amount
end

function gemFunc.getGemListWithPetId( nPetId )
	local list = {}
	if nPetId > 0 then
		for k,v in pairs(gemData) do
			if v.SetIn == nPetId then 
				table.insert(list, v)
			end
		end
	end
	return list
end

function gemFunc.getGemCountUnLock( ... )
	local unLockManager = require "UnlockManager"
	if unLockManager:isUnlock("GemFubenNo4") then
		return 4
	elseif unLockManager:isUnlock("GemFubenNo3") then
		return 3
	elseif unLockManager:isUnlock("GemFuben") then
		return 2
	else
		return 0
	end
end

return gemFunc