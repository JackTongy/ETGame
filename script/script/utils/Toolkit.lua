local Toolkit = {}

local res = require "Res"
local dbManager = require "DBManager"
local timeManager = require 'TimeManager'
local layerManager = require "framework.interface.LuaLayerManager"
local eventCenter = require 'EventCenter'
local Utils = require 'framework.helper.Utils'

local lootIconConfig = {
	[1] = {"daoju6.png",4,0.5},
	[2] = {"dan_dan2.png",2,0.4},
	[3] = {"daoju1.png",2,0.4},
	[4] = {"FB_shu.png",-1,0.5},
	[5] = {"FB_caocong.png",-1,0.5},
	[6] = {"FB_shikuai.png",-1,0.5},
	[7] = {"FB_ranshaoyanshi.png",-1,0.5},
	[8] = {"FB_bingkuai.png",-1,0.5},
	[9] = {"FB_shuitan.png",-1,0.5},
	[10] = {"daoju2.png",1,0.4},
	[11] = {"material_24.png",1,0.6},
	[12] = {"FB_wenti.png",-5,0.5},
	[13] = {"material_9.png",1,0.4},
	[14] = {"daoju3.png",1,0.4},
	[15] = {"N_JH_tubiao.png",0,1},
	[16] = {"N_ZC_ss.png",0,1},
	[17] = {"material_40.png",0,1},
	[18] = {"material_24.png",0,1},
}

function Toolkit.setLootIcon( node,lootType )
	local config = lootIconConfig[lootType]
	if config then
		node:setResid(config[1])
		local x = node:getPosition()
		node:setPosition(x,config[2])
		node:setScale(config[3])
	end
end

function Toolkit.setClubIcon( node,picID )
	local dbInfo = dbManager.getInfoGuildIcon(picID)
	if dbInfo.itemtype == 9 then
		local material = require "BagInfo".getItemByMID(dbInfo.itemid)
		local _1,_2,bg1 = res.setItemDetail(node,material)
		bg1:setResid("N_ZB_biankuang0.png")
	elseif dbInfo.itemtype == 8 then
		local gem = require "GemInfo".getGemByGemID(dbInfo.itemid,dbInfo.color+1)
		res.setGemDetail(node,gem)
	elseif dbInfo.itemtype == 7 then
		local equip = require "EquipInfo".getEquipInfoByEquipmentID(dbInfo.itemid)
		local _1,_2,frameBg,runeRootNode = res.setEquipDetail(node,equip)
		frameBg:setResid("N_ZB_biankuang0.png")
		if runeRootNode then
			runeRootNode:setVisible(false)
		end
	elseif dbInfo.itemtype == 6 then
		local pet = require "PetInfo".getPetInfoByPetId(dbInfo.itemid,dbInfo.color*4)
		res.setPetDetail(node,pet)
	end
end

function Toolkit.getMibaoSetInInfo( mibao )
	local result = {}
	local nPet = require "MibaoInfo".getPetMibaoPutOn(mibao.SetIn)
	if nPet then
		result.text = res.getPetNameWithSuffix(nPet)
		result.nPet = nPet
	else
		local activeTeamId = require "TeamInfo".getTeamActiveId()
		for i=1,3 do
			if i ~= activeTeamId and mibao.SetIn[i]>0 then
				result.text = res.locString("Equip$EquipOnAnotherTeam")
				break
			end
		end
	end
	return result
end

function Toolkit.setEquipSetInLabel( label,equip,func )
	local ret
	local color
	local setInText = res.locString("Equip$EquipNo")
	local petInfo = require "EquipInfo".getPetEquippedOn(equip.SetIn)
	if petInfo then
		local dbPet = dbManager.getCharactor(petInfo.PetId)
		setInText = res.locString("Equip$EquipOn")..dbManager.getCharactor(dbPet.id).name
		color = ccc4f(0.78,0.98,1.0,1.0)
		ret = dbManager.getCharactor(dbPet.id).name
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
			setInText = res.locString("Equip$EquipOn")..res.locString("Equip$EquipOnAnotherTeam")
			color = ccc4f(0.78,0.98,1.0,1.0)
			ret = res.locString("Equip$EquipOnAnotherTeam")
		else
			color = ccc4f(0.6,0.75,0.81,1.0)
		end
	end
	if label then
		label:setFontFillColor(color,true)
		label:setString( setInText )
	end
	if func then
		func(ret)
	end

	return petInfo
end

function Toolkit.showDialogOnCoinNotEnough( ... )
	local param = {}
	param.content = res.locString("Recharge$CoinNotEnoughDialogContent")
	param.RightBtnText = res.locString("Global$BtnRecharge")
	param.callback = function ( ... )
		GleeCore:showLayer("DRecharge")
	--	GleeCore:closeAllLayers()
	--	GleeCore:pushController("CRecharge", nil, nil, res.getTransitionFade())
	end
	GleeCore:showLayer("DConfirmNT",param)
end

function Toolkit.showDialogOnPetListMax( ... )
	local param = {}
	param.content = res.locString('Pet$MAXNotice')
	param.RightBtnText = res.locString('Pet$Sacrifice')
	param.callback = function ( ... )
		if GleeCore:isRunningLayer('DPetList') then
			eventCenter.eventInput('EventTabSelect',{tab=3,layer='DPetList'})
		else
			GleeCore:showLayer('DPetList',{tab=3})	
		end
	end
	if not GleeCore:isRunningLayer('DConfirmNT') then
		GleeCore:showLayer('DConfirmNT',param)
	end
end

function Toolkit.showDialogOnEquipListMax( ... )
	local param = {}
	param.content = res.locString('Equip$MAXNotice')
	param.RightBtnText = res.locString('Equip$MergeEquip')
	param.callback = function ( ... )
		if GleeCore:isRunningLayer('DMagicBox') then
			eventCenter.eventInput('EventEquipTabSel',{ShowIndex=2,layer='DMagicBox'})
		else
			GleeCore:showLayer('DMagicBox',{ShowIndex=2})	
		end
	end
	if not GleeCore:isRunningLayer('DConfirmNT') then
		GleeCore:showLayer('DConfirmNT',param)
	end
end

function Toolkit.getMibaoLevelCap( star )
	return dbManager.getInfoMibaoLvLimit(star)
end

function Toolkit.getEquipLevelCap( equip )
	local LvLimit = 40
 	if equip.Tp > 0 then
 		LvLimit = LvLimit + dbManager.getInfoEquipTp(equip.Tp).lvup
 	end
 	return LvLimit
end

function Toolkit.getAllEquipPro( ... )
	return {"a","h","d","s","f","m"}
end

function Toolkit.getEquipProList( equip )
	local dbInfo = dbManager.getInfoEquipment(equip.EquipmentId)
	local proTable = Toolkit.getAllEquipPro()
	local ret = {}
	for i=1,#proTable do
		local key = string.format("%sv",proTable[i])
		if dbInfo[key] and dbInfo[key]>0 then
			table.insert(ret,proTable[i])
		end
	end
	return ret
end

function Toolkit.getEquipProName( pro )
	return res.locString(string.format("Equip$Pro_%s",pro))
end

function Toolkit.getGemDes( gem )
	local dbInfo = dbManager.getInfoGem(gem.GemId)
	local des = dbInfo.description
	local v,e= {},0
	for i=1,2 do
		local b
		b,e = string.find(des,"{$}",e)
		if not b then
			break
		else
			local value = dbInfo[string.format("effect%d",i)][gem.Lv]
			if string.sub(des,e+1,e+1)=="%" then
				value = value*100
			end
			v[i] = value
		end
	end
	for i=1,#v do
		des = string.gsub(des,"{$}",v[i],1)
	end
	return des
end

function Toolkit.playPetVoice( PetId )
	if PetId then
		local dbPet = dbManager.getCharactor(PetId)
		require 'framework.helper.MusicHelper'.stopAllEffects()
		if dbPet.voice then
			require 'framework.helper.MusicHelper'.playEffect(string.format('raw/role_voice/%s',dbPet.voice))
		end
	end
end

--同年同月非第二天 reutrn false
function Toolkit.isTheSecondDay( date1,stimes)
	
	local ldt1 = timeManager.getDateTimeLocal(date1)
	local ldt2 = timeManager.getDateTimeLocal(nil,stimes)

	local items1 = string.split(ldt1,' ')
	local yd1 = string.split(items1[1],'-')

	local items2 = string.split(ldt2,' ')
	local yd2 = string.split(items2[1],'-')
	
	if tonumber(yd1[1]) == tonumber(yd2[1]) and tonumber(yd1[2]) == tonumber(yd2[2]) then
		return (tonumber(yd2[3])-tonumber(yd1[3])) >= 1
	end

	return true
end

--当天指点时间点所剩秒数 以服务器所服务的时区为准
--[[
	将服务器所指向的时间换算为本地时间
	计算差值
	hour mm 参数对应的是服务器所指定的时区时间
]]
function Toolkit.getTimeOffset(hour,mm )
	local TZone_S	 = require 'AccountInfo'.getCurrentServerUTCOffset()
	local TZone_C 	 = os.time() - os.time(os.date('!*t'))

	local servertime = timeManager.getCurrentSeverTime()/1000 --内网服务器时钟不准
	local date  = os.date('!*t',servertime+TZone_S)
	date.hour   = hour
	date.min    = mm
	date.sec    = 0
	local offset   = (os.time(date) + TZone_C) - (servertime + TZone_S)
	return (offset > 0 and offset) or (3600*24+offset)

end

function Toolkit.isTimeBetween( fhour,fmm,tohour,tomm)
	local offset_f = Toolkit.getTimeOffset(fhour,fmm)
	local offset_to = Toolkit.getTimeOffset(tohour,tomm)
	return (offset_to - offset_f) < 0 , offset_to
end

function Toolkit.isLegal( name )
	local t = os.time()
	for _,v in ipairs(require "BadWordConfig") do
		if string.find(name,v.Word,nil,true) then
			return false,v.Word
		end
	end
	return true
end

function Toolkit.getLuckyMagicBoxMaxCount( actData )
	local maxCount = 0
	if actData then
		local keys = {"EqGreen","EqBlue","EqPurple","EqOrange"}
		for _,v in ipairs(keys) do
			local t = actData["Data"][v]
			if t and type(t)=="table" then
				maxCount = math.max(maxCount,#t)
			end
		end
	end
	return maxCount+1
end

function Toolkit.getRuneName( runeid,lv )
	local dbinfo = dbManager.getInfoRune(runeid)
	if lv and lv > 0 then
		return dbinfo.Name.."+"..lv
	else
		return dbinfo.Name
	end
end

function Toolkit.getRuneLvUpCost( star,lv )
	local lvCap = Toolkit.getRuneLvCap1(star)
	if lv<lvCap then
		local config = require "RuneLvConfig"
		for _,v in ipairs(config) do
			if star == v.star and lv == v.Lv then
				return v.UpgradeAmount
			end
		end
	end
	return math.huge
end

function Toolkit.getRuneLvCap1( star )
	local config = require "RuneLvConfig"
	local max = 0
	for _,v in ipairs(config) do
		if v.star == star then
			max = math.max(max,v.Lv)
		end
	end
	return max
end

function Toolkit.getRuneLvCap( rune )
	return Toolkit.getRuneLvCap1(rune.Star)
end

function Toolkit.getEquipNameById( id )
	local equip = require "EquipInfo".getEquipWithId(id)
	local dbinfo = dbManager.getInfoEquipment(equip.EquipmentId)
	if equip.Tp and equip.Tp>0 then
		return dbinfo.name.."+"..equip.Tp
	else
		return dbinfo.name
	end
end

local recordfile = 'nil'
function Toolkit.runFuncOnce( idf,func,elfunc )
	idf = tostring(idf)
	local record = Utils.readTableFromFile(recordfile) or {}
	local used = record[idf]
	if not used then
		record[idf] = true
		Utils.writeTableToFile(record,recordfile)

		return func and func()
	else
		return elfunc and elfunc();
	end
end

function Toolkit.useCoinConfirm( callback )
	if require 'Config'.LangName == 'kor' then
		GleeCore:showLayer('DConfirmNT',{content=require 'Res'.locString('UseCoin$ConfirmNotice'),callback=callback})
	else
		return callback and callback()
	end
end


function Toolkit.getMibaoName( mibao )
	local dbinfo
	if mibao.MibaoId then
		dbinfo = dbManager.getInfoTreasure(mibao.MibaoId)
	else
		dbinfo = mibao
	end
	local name = dbinfo.Name
	local lvIconRes
	if mibao.RefineLv and mibao.RefineLv > 0 then
		local lv1,lv2 = math.floor(mibao.RefineLv / 10),mibao.RefineLv%10
		if lv2 > 0 then
			name = name .. "+" .. lv2
		end
		if lv1 > 0 then
			lvIconRes = string.format("MB_JL_tb%d.png",lv1)
		end
	end
	return name,lvIconRes
end

function Toolkit.getMibaoRefineProAdd( mibao )
	local refineConfig = dbManager.getInfoMibaoRefineConfig(mibao.Type,mibao.Star,mibao.RefineLv)
	return refineConfig.Effect
end

function Toolkit.getMibaoNextRefineConfig( mibao )
	local refineConfig = dbManager.getInfoMibaoRefineConfig(mibao.Type,mibao.Star,mibao.RefineLv+1)
	return refineConfig
end

function Toolkit.isRuneMosaicEnable(location)
	return location == 1 or location == 2 or location == 4 or location == 5
end

function Toolkit.containMibaoMaterial( t,mibao )
	for _,v in ipairs(t) do
		if v.Id == mibao.Id and v._materialIndex == mibao._materialIndex then
			return true
		end
	end
	return false
end

function Toolkit.getEquipPropText( nProp )
	local config = dbManager.getInfoEqPropConfig(nProp.Type)
	local value
	if config.Type == 1 then
		value = nProp.Value
	elseif config.Type == 2 then
		value = string.format("%g%%", nProp.Value * 100)
	end
	return config.Name, value
end

function Toolkit.showDialogNewVersion(url,cancelcallback)
	local param = {}
	param.content = res.locString("NewVersion$Msg")
	param.RightBtnText = res.locString("NewVersion$Confirm")
	param.LeftBtnText = res.locString("NewVersion$Later")
	param.callback = function ( ... )
		if url then
			WebView:getInstance():gotoURL(url)
		end
	end	
	param.cancelCallback=cancelcallback
	param.noclose = true
	GleeCore:showLayer("DConfirmNT",param)
end


--获取当天所剩次数 5点刷新
function Toolkit.getEveryDaysFileName()
  return string.format('%s-everyday',os.date("%Y-%m-%d",os.time()-5*60*60)) 
end

function Toolkit.getEveryDaysLastCount( key,max )
	local filename = Toolkit.getEveryDaysFileName()
	local _table = Utils.readTableFromFile(filename) or {}
	return max - (_table[key] or 0)
end

function Toolkit.reduceEveryDaysLastCount( key,count )
	local filename = Toolkit.getEveryDaysFileName()
	local _table = Utils.readTableFromFile(filename) or {}
	_table[key] = (_table[key] or 0) + count
	Utils.writeTableToFile(_table,filename)
end

return Toolkit