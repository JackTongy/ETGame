local RuneFunc = {}
local RuneData = {}

function RuneFunc.getRuneWithDB( runeId,star,lv )
	local rune = {}
	rune.RuneId = runeId
	local dbManager = require "DBManager"
	local dbRune = dbManager.getInfoRune(runeId)
	rune.Star = star or 1
	rune.Lv = lv or 0
	rune.Consume = 0
	rune.SetIn = 0
	rune.Buffs = {}
	return rune
end

function RuneFunc.cleanData( ... )
	RuneData.RuneList = {}
end

function RuneFunc.getRuneList( ... )
	return RuneData.RuneList or {}
end

function RuneFunc.setRuneList( list )
	RuneData.RuneList = list or {}
end

function RuneFunc.isMyRune( id )
	for _,v in ipairs(RuneData.RuneList) do
		if v.Id == id then
			return true
		end
	end
	return false
end

function RuneFunc.setRune( rune )
	if rune then
		RuneData.RuneList = RuneData.RuneList or {}
		local canFind = false
		for i,v in ipairs(RuneData.RuneList) do
			if v.Id == rune.Id then
				RuneData.RuneList[i] = rune
				canFind = true
				break
			end
		end
		if not canFind then
			table.insert(RuneData.RuneList, rune)
		end
	end
end

function RuneFunc.removeRune( v )
	if RuneData.RuneList then
		for i,vv in ipairs(RuneData.RuneList) do
			if v.Id == vv.Id then
				table.remove(RuneData.RuneList,i)
				break
			end
		end
	end
end

function RuneFunc.removeRuneList( list )
	for _,v in ipairs(list) do
		RuneFunc.removeRune(v)
	end
end

function RuneFunc.updateRuneList( list )
	if list then
		for i,v in ipairs(list) do
			RuneFunc.setRune( v )
		end
	end
end

function RuneFunc.selectByCondition( condition )
	local ret = {}
	if RuneData.RuneList then
		for _,v in pairs(RuneData.RuneList) do
			if condition(v) then
				table.insert(ret,v)
			end
		end
	end
	return ret
end

function RuneFunc.getRuneWithType( runeType )
	if runeType == 0 then
		return RuneData.RuneList
	end
	
	local dbManager = require "DBManager"
	local temp = {}
	for k,v in pairs(RuneData.RuneList) do
		local rune = dbManager.getInfoRune(v.RuneId)
		if rune and rune.Location == runeType then
			table.insert(temp, v)
		end
	end
	return temp
end

function RuneFunc.commonSortFunc( a,b )
	local aSet1 = a.SetIn>0
	local bSet1 = b.SetIn>0
	if aSet1 == bSet1 then
		if a.Star == b.Star then
			if a.Lv == b.Lv then
				return a.Id<b.Id
			else
				return a.Lv>b.Lv
			end
		else
			return a.Star>b.Star
		end
	else
		return aSet1
	end
end

function RuneFunc.commonSortFunc1( a,b )
	local aSet1 = a.SetIn>0
	local bSet1 = b.SetIn>0
	if aSet1 == bSet1 then
		if a.Star == b.Star then
			if a.Lv == b.Lv then
				return a.Id<b.Id
			else
				return a.Lv<b.Lv
			end
		else
			return a.Star<b.Star
		end
	else
		return bSet1
	end
end

return RuneFunc