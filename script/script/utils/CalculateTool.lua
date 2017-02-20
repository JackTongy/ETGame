local dbManager = require "DBManager"

local CalculateTool = {}

function CalculateTool.getMibaoExpProvide( v )
	local dbinfo = dbManager.getInfoTreasure(v.MibaoId)
	if dbinfo.Type == 3 then
		return dbinfo.Effect
	else
		return math.floor(v.Exp*0.8+dbinfo.Exp)
	end
end

function CalculateTool.getEquipProGrowth( equip,pro,grow )
	if pro == "m" then
		return 0
	end
	local dbInfo = dbManager.getInfoEquipment(equip.EquipmentId)
	local value = equip[string.format("%sv",string.upper(pro))]
	grow = grow or equip.Grow
	local low,high = dbInfo[string.format("%sl",pro)],dbInfo[string.format("%sh",pro)]
	return grow*(high-low)+low
end

function CalculateTool.getEquipProData( value,lv,growth,tp )
		  return value + growth * ( lv -1 ) + tp*value
end

function CalculateTool.getEquipProAddByRune( equip,pro )
	if require "EquipInfo".getEquipWithId(equip.Id) then
		local runes = require "RuneInfo".selectByCondition(function ( v )
			return v.SetIn == equip.Id
		end)
		local proAdd = {a = 0,h = 0,d = 0}
		for _,v in ipairs(runes) do
			local dbRune = dbManager.getInfoRune(v.RuneId)
			if dbRune.Location == 1 then
				proAdd.h = proAdd.h + CalculateTool.getRuneBaseProValueData(v)
			elseif dbRune.Location == 2 then
				proAdd.a = proAdd.a + CalculateTool.getRuneBaseProValueData(v)
			elseif dbRune.Location == 3 then
				proAdd.d = proAdd.d + CalculateTool.getRuneBaseProValueData(v)
			end
		end
		return proAdd[pro] or 0
	else
		return 0
	end
end

function CalculateTool.getEquipProDataByEquipInfo( equip,pro )
	local value = equip[string.format("%sv",string.upper(pro))]
	if pro ~= "m" then
		value = CalculateTool.getEquipProData(value,equip.Lv,CalculateTool.getEquipProGrowth(equip,pro),equip.Tp)
	end
	return value + CalculateTool.getEquipProAddByRune(equip,pro)
end

function CalculateTool.getEquipProDataStrByEquipInfo( equip,pro )
	local value = CalculateTool.getEquipProDataByEquipInfo( equip,pro )
	if pro == "m" then
		return string.format("%d%%",value*100)
	else
		return string.format("%d",value)
	end
end

function CalculateTool.getEquipStrengthenNeedGold(color,lv)
	return math.floor( color^0.9*lv^2.4+10)
end

function CalculateTool.getGemLevelUpRate( score,sucscore )
	local rate = math.ceil((score/sucscore)^1.5*100)
	return math.min(rate,100)
end

function CalculateTool.getArenaHornorByRank( rank )
	if rank == 1 then
		return 3000
	elseif rank == 2 then
		return 2500
	elseif rank == 3 then
		return 2300
	elseif rank == 4 then
		return 2100
	elseif rank == 5 then
		return 2000
	elseif rank<=10 then
		return 2000-(rank-5)*10
	elseif rank<=50 then
		return 1950-(rank-10)*5
	elseif rank<=150 then
		return 1750-(rank-50)*4
	elseif rank<=200 then
		return 1350-(rank-150)*3
	elseif rank<=300 then
		return 1200-(rank-200)*2
	elseif rank<=500 then
		return 1000-(rank-300)*1
	elseif rank<=600 then
		return math.floor(800-(rank-500)*0.5)
	elseif rank<=700 then
		return math.floor(750-(rank-600)*0.3)
	elseif rank<=800 then
		return math.floor(720-(rank-700)*0.2)
	elseif rank<=5000 then
		return math.floor(700-(rank-800)*0.1)
	elseif rank<=6000 then
		return math.floor(280-(rank-5000)*0.05)
	elseif rank<=7000 then
		return math.floor(230-(rank-6000)*0.03)
	elseif rank<=16000 then
		return math.floor(200-(rank-7000)*0.02)
	else
		return 20
	end
end

function CalculateTool.getArenaCDCost( cd )
	local min = math.ceil(cd/60)
	return min*3
end

function CalculateTool.getArenaBuyCountPrice( hasbuyCount )
	return math.min(200,(hasbuyCount+1)*10)
end

function CalculateTool.getRuneBaseProValueData( rune )
	local dbinfo = dbManager.getInfoRune(rune.RuneId)
	local base = dbinfo.Values[rune.Star]
	local grow = dbinfo.Grows[rune.Star]
	local value = base + rune.Lv*grow
	return value
end

function CalculateTool.getRuneBaseProValue( rune )
	local dbinfo = dbManager.getInfoRune(rune.RuneId)
	local value = CalculateTool.getRuneBaseProValueData(rune)
	if dbinfo.Location == 4 then
		return string.format("%g%%",value*100)
	else
		return value
	end
end

function CalculateTool.getMagicStoneCountByResolved( star,consume )
	return star*star*100+consume*0.4
end

function CalculateTool.getRuneRebornCost( curLv,targetLv )
	if targetLv == 0 then
		return dbManager.getInfoDefaultConfig("RuneRebornCost").Value
	else
		return 1200 - ( curLv - targetLv - 1 ) * 100
	end
end

return CalculateTool