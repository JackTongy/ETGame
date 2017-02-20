--[[
		装备信息（Equipment）
		字段					类型			说明
		Id 						Long 			主键 id
		EquipmentId 			Int 				装备 id
		Rank 					Int 				品级
		Lv						Int 				等级
		Tp 						Int 				突破阶数
		Value 					Int 				初始值
		Grow				Double 		成长值
		Energy 				Double 		能量
		SetIn 					Int 				装备于哪个精灵
]]

local dbManager = require "DBManager"
local gameFunc = require "AppData"

-- 装备模块
local equipInfoFunc = {}
local equipInfoData = {}

function equipInfoFunc.cleanData()
	equipInfoData = {}
end

function equipInfoFunc.getEquipInfoByEquipmentID( id )
	local dbInfo = dbManager.getInfoEquipment(id)
	local equip = {}
	equip.Name = dbInfo.name
	equip.Color = dbInfo.color
	equip.EquipmentId = id
	equip.Rank = 1
	equip.Lv = 1
	equip.Tp = 0
	for _,v in ipairs(require "Toolkit".getAllEquipPro()) do
		equip[string.format("%sv",string.upper(v))] = dbInfo[string.format("%sv",v)]
	end
	equip.Grow = 0
	equip.SetIn = {0,0,0}
	return equip
end

-- 返回装备列表
function equipInfoFunc.getEquipList(  )
	return equipInfoData
end

function equipInfoFunc.selectByCondition( condition )
	local ret = {}
	for _,v in pairs(equipInfoData) do
		if condition(v) then
			table.insert(ret,v)
		end
	end
	return ret
end

function equipInfoFunc.getCountByConditon( condition )
	local count = 0
	for _,v in ipairs(equipInfoData) do
		if condition(v) then
			count = count + 1
		end
	end
	return count
end

function equipInfoFunc.getPetEquippedOn( setInList,team )
	local petID = equipInfoFunc.getPetIdEquippedOn(setInList,team)
	if petID >0 then
		return require "PetInfo".getPetWithId(petID)
	else
		return nil
	end
end

function equipInfoFunc.getPetIdEquippedOn( setInList,team )
	local curTeam,teamIndex 
	if not team then
		curTeam,teamIndex  = require "TeamInfo".getTeamActive()
	else
		curTeam,teamIndex = team,team.TeamId
	end
	local index = setInList[teamIndex]
	local petId = 0
	if index and index >0 then
		if index == 6 then
			petId =  curTeam.BenchPetId
		else
			petId =  curTeam.PetIdList[index]
		end
	end
	return petId or 0
end

-- 设置装备列表
function equipInfoFunc.setEquipList( list )
	equipInfoData = list
end

-- 返回相应ID的装备
function equipInfoFunc.getEquipWithId( id )
	for k,v in pairs(equipInfoData) do
		if v.Id == id then
			return v
		end
	end
	return nil
end

function equipInfoFunc.removeEquipByIds( ids )
	local ret = {}
	local gemFunc = require "GemInfo"
	local RuneFunc = require "RuneInfo"
	for i,v in ipairs(equipInfoData) do
		local k = table.keyOfItem(ids,v.Id)
		if k then
			table.remove(ids,k)

			local runeList = RuneFunc.selectByCondition(function ( nRune )
				return nRune.SetIn == v.Id
			end)
			for _,nRune in pairs(runeList) do
				nRune.SetIn = 0
			end
		else
			table.insert(ret,v)
		end
	end
	equipInfoData = ret
end

function equipInfoFunc.addEquipments( list )
	table.foreach(list,function ( _,v )
		equipInfoFunc.setEquipWithId(v)
	end)
end

-- 设置相应ID的装备
function equipInfoFunc.setEquipWithId( equip )
	if equip and (not equip.Id or equip.Id == 0) then
		--装备没有唯一ID时 已有装备数量已达上限
		require 'Toolkit'.showDialogOnEquipListMax()
		return 
	end

	local canFind = false
	for i,v in ipairs(equipInfoData) do
		if v.Id == equip.Id then
			equipInfoData[i] = equip
			canFind = true
			break
		end
	end
	if canFind == false then
		table.insert(equipInfoData, equip)
	end
end

-- 1:装备在当前队伍 2:装备在其他队伍 3:未装备
function equipInfoFunc.getSetInStatus( equip )
	local petInfo = require "EquipInfo".getPetEquippedOn(equip.SetIn)
	if petInfo then
		return 1
	else
		local activeTeamId = require "TeamInfo".getTeamActiveId()
		local hasEquipAnother = false
		for i=1,3 do
			if i ~= activeTeamId and equip.SetIn[i]>0 then
				hasEquipAnother = true
				break
			end
		end
		if hasEquipAnother then
			return 2
		else
			return 3
		end
	end
end

--[[
	排序规则1：
	1.已装备
	部位
	2.品质
	3.等级
	4.装备ID 升序
	5.成长
]]
function equipInfoFunc.sortNormal( list )
	local sortList = list or equipInfoData
	table.sort(sortList,function ( a,b )
		local aSetIn,bSetIn = equipInfoFunc.getSetInStatus(a),equipInfoFunc.getSetInStatus(b)
		if aSetIn == bSetIn then
			local aEID,bEID = a.EquipmentId,b.EquipmentId
			local aDbInfo =  dbManager.getInfoEquipment(aEID)
			local bDbInfo =  dbManager.getInfoEquipment(bEID)

	--		if aDbInfo.location == bDbInfo.location then
				local aColor,bColor = aDbInfo.color,bDbInfo.color
				if aColor == bColor then
					if aDbInfo.set == bDbInfo.set then
						local aLv,bLv = a.Lv,b.Lv
						if aLv == bLv then
							if aEID == bEID then
								if a.Grow == b.Grow then
									return a.Id < b.Id
								else
									return a.Grow > b.Grow
								end
							else
								return aEID < bEID
							end
						else
							return aLv > bLv
						end
					else
						return aDbInfo.set > bDbInfo.set
					end
				else
					return aColor > bColor
				end
			-- else
			-- 	return aDbInfo.location < bDbInfo.location
			-- end
		else
			return aSetIn<bSetIn
		end
	end)
end

function equipInfoFunc.sortWithLocation( list )
	if list then
		table.sort(list, function ( a, b )
			local aEID,bEID = a.EquipmentId,b.EquipmentId
			local aDbInfo =  dbManager.getInfoEquipment(aEID)
			local bDbInfo =  dbManager.getInfoEquipment(bEID)
			if aDbInfo.location == bDbInfo.location then
				return a.Id < b.Id
			else
				return aDbInfo.location < bDbInfo.location
			end
		end)
	end
end

function equipInfoFunc.sortChose( list, nEquipIdSelected )
	local sortList = list or equipInfoData
	table.sort(sortList,function ( a,b )
		if a.Id == nEquipIdSelected then
			return true
		elseif b.Id == nEquipIdSelected then
			return false
		end

		local aSetIn,bSetIn = equipInfoFunc.getSetInStatus(a),equipInfoFunc.getSetInStatus(b)
		if aSetIn == 2 then
			aSetIn = 3
		end
		if bSetIn == 2 then
			bSetIn = 3
		end

		if aSetIn == bSetIn then
			local aEID,bEID = a.EquipmentId,b.EquipmentId
			local aDbInfo =  dbManager.getInfoEquipment(aEID)
			local bDbInfo =  dbManager.getInfoEquipment(bEID)

			if aDbInfo.location == bDbInfo.location then
				local aColor,bColor = aDbInfo.color,bDbInfo.color
				if aColor == bColor then
					local aLv,bLv = a.Lv,b.Lv
					if aLv == bLv then
						if aEID == bEID then
							if a.Grow == b.Grow then
								return a.Id < b.Id
							else
								return a.Grow > b.Grow
							end
						else
							return aEID < bEID
						end
					else
						return aLv > bLv
					end
				else
					return aColor > bColor
				end
			else
				return aDbInfo.location < bDbInfo.location
			end
		else
			return aSetIn > bSetIn
		end
	end)
end

--[[
	排序规则2：
	0.未装备
	1.低品质
	2.低突破等级
	3.低品级
	4.低装备等级
	5.ID升序
]]

function equipInfoFunc.sortForMagicBoxFunc( a, b )
	local aSetIn,bSetIn = equipInfoFunc.getSetInStatus(a),equipInfoFunc.getSetInStatus(b)
	if aSetIn == bSetIn then
		local aEID,bEID = a.EquipmentId,b.EquipmentId
		local aDbInfo =  dbManager.getInfoEquipment(aEID)
		local bDbInfo =  dbManager.getInfoEquipment(bEID)
		local aColor,bColor = aDbInfo.color,bDbInfo.color
		if aColor == bColor then
			if a.Tp == b.Tp then
				if a.Rank == b.Rank then
					local aLv,bLv = a.Lv,b.Lv
					if aLv == bLv then
						if aEID == bEID then
							return a.Id < b.Id
						else
							return aEID < bEID
						end
					else
						return aLv < bLv
					end
				else
					return a.Rank < b.Rank
				end
			else
				return a.Tp < b.Tp
			end
		else
			return aColor < bColor
		end
	else
		return aSetIn>bSetIn
	end
end

function equipInfoFunc.sortForMagicBox( list )
	local sortList = list or equipInfoData
	table.sort(sortList, equipInfoFunc.sortForMagicBoxFunc)
end

function equipInfoFunc.getEquipListWithPetId( petId )
	return equipInfoFunc.getEquipListWithPetId0(petId,equipInfoData)
end

function equipInfoFunc.getEquipListWithPetId0( petId,equipList,team )
	local temp = {}
	if petId > 0 then
		for i,v in ipairs(equipList) do
			local petID = equipInfoFunc.getPetIdEquippedOn(v.SetIn,team)
			if petID== petId then
				table.insert(temp, v)
			end
		end
	end
	return temp
end

function equipInfoFunc.getEquipListWithTeamIndex( teamIndex )
	local temp = {}
	for i,v in ipairs(equipInfoData) do
		if v.SetIn[teamIndex] > 0 then
			table.insert(temp, v)
		end
	end
	return temp
end

function equipInfoFunc.getCountGemCanFix( nEquip )
	assert(nEquip)
	local dbEquip = dbManager.getInfoEquipment(nEquip.EquipmentId)
	return dbManager.getInfoEquipColor(dbEquip.color).gems
end

function equipInfoFunc.getEquipListWithLocation( location )
	if location == 0 then
		return equipInfoData
	end
	local temp = {}
	for i,v in ipairs(equipInfoData) do
		local dbEquip = dbManager.getInfoEquipment(v.EquipmentId)
		if dbEquip and dbEquip.location == location then
			table.insert(temp, v)
		end
	end
	return temp
end

function equipInfoFunc.removeEquipByID( EquipmentId )
	for i,v in ipairs(equipInfoData) do
		if v.Id == EquipmentId then
			table.remove(equipInfoData,i)
			break
		end
	end
end

function equipInfoFunc.getEquipLow( EquipmentId )
	local tmp = nil
	for k,v in pairs(equipInfoData) do
		if v.EquipmentId == EquipmentId then
			if tmp == nil or tmp.Value > v.Value then
				tmp = v
			end
		end
	end
	return tmp
end


function equipInfoFunc.isEquipOn( equip )
	if equip and equip.SetIn then
		return (equip.SetIn[1] ~= 0 or equip.SetIn[2] ~= 0 or equip.SetIn[3] ~= 0)	
	end
	return false
end

function equipInfoFunc.getEquipAmountList( nEquipList )
	local result = {}
	for k,v in pairs(nEquipList) do
		local canFind = false
		for k2,v2 in pairs(result) do
			if v.EquipmentId == v2.equipmentId then
				v2.amount = v2.amount + 1
				canFind = true
				break
			end
		end
		if not canFind then
			table.insert(result, {equipmentId = v.EquipmentId, amount = 1})
		end
	end
	return result
end

function equipInfoFunc.hasChange( a,b,gems )
	local index = require "TeamInfo".getTeamActiveId()
	if a.Lv~=b.Lv then
		return true
	elseif a.Grow~=b.Grow then
		return true
	elseif a.Tp~=b.Tp  then
		return true
	elseif a.SetIn[index] ~=b.SetIn[index] then
		return true
	end
	return false
end

function equipInfoFunc.getRank( equipinfo )
	local Value = equipinfo.Grow
	if Value >= 0 and Value < 0.2 then
		return 1
	elseif Value >= 0.2 and Value < 0.4 then
		return 2
	elseif Value >= 0.4 and Value < 0.6 then
		return 3
	elseif Value >= 0.6 and Value < 0.8 then
		return 4
	elseif Value >= 0.8 and Value <= 1 then
		return 5
	end
	return 1
end

function equipInfoFunc.getEquipmentAmount( equipmentId,idle )
	local amount = 0
	for k,v in pairs(equipInfoData) do
		if v.EquipmentId == equipmentId and (v.SetIn == 0 or not idle) then
			amount = amount + 1
		end
	end	
	return amount
end

function equipInfoFunc.setIsEffect( nEquip )	
	local dbEquip = dbManager.getInfoEquipment(nEquip.EquipmentId)
	if dbEquip and dbEquip.set > 0 then
		local nPetId = equipInfoFunc.getPetIdEquippedOn(nEquip.SetIn)
		if nPetId > 0 then
			local equipList = equipInfoFunc.getEquipListWithPetId(nPetId)
			if equipList then
				local count = 0
				for k,v in pairs(equipList) do
					if dbManager.getInfoEquipment(v.EquipmentId).set == dbEquip.set then
						count = count + 1
					end
				end
				if count >= 3 then
					return true
				end
			end
		end
	end
	return false
end

--返回table的key:
-- "a",攻击
-- "h",生命
-- "d",防御
-- "s",伤害
-- "f",免伤
-- "m",移动速度
-- "broken",破甲
-- "crit",暴击伤害
-- "speed",攻击速度
-- "cure",治疗

--team:不传则默认为自己的当前激活队伍，在计算其他玩家信息时，必传
--equipData:不传则默认为自己的所有装备列表
function equipInfoFunc.getEquipEffectsWithPetId( id,team,equipData )
	local equipList = equipInfoFunc.getEquipListWithPetId0(id,equipData or equipInfoData,team)
	local t = {}
	local set = {}

	for _,v in ipairs(equipList) do
		local setid = dbManager.getInfoEquipment(v.EquipmentId).set
		if setid>0 then
			set[setid] = set[setid] or {}
			table.insert(set[setid],v)
		end
		for _,p in ipairs(require "Toolkit".getEquipProList(v)) do
			t[p] = t[p] or 0
			t[p] = t[p]+require "CalculateTool".getEquipProDataByEquipInfo(v,p)
		end
	end

	local setEffectKey
	for setid,list in pairs(set) do
		if #list>=3 then
			setEffectKey = setEffectKey or  {"atk","hp","def","broken","crit","speed","cure"}
			local equipSetInfo = dbManager.getInfoEquipSet( setid )
			for i=3,#list do
				for _,v in ipairs(setEffectKey) do
					local data = equipSetInfo[v][i-2]
					if data>0 then
						t[v] = t[v] or 0
						t[v] = t[v] + data
					end
				end
			end
		end
	end

	if t["a"] and t["atk"] and t["atk"]>0 then
		t["a"] = t["a"]*(1+t["atk"])
	end
	if t["h"] and t["hp"] and t["hp"]>0 then
		t["h"] = t["h"]*(1+t["hp"])
	end
	if t["d"] and t["def"] and t["def"]>0 then
		t["d"] = t["d"]+t["def"]
	end

	print(t)
	return t
end

return equipInfoFunc
