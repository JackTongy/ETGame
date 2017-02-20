local res = require "Res"
local dbManager = require "DBManager"
local netModel = require "netModel"
local eventCenter = require 'EventCenter'
local userFunc = require "UserInfo"
local RechargeConfig = require "ChargeConfig"
local petFunc = require "PetInfo"
local equipFunc = require "EquipInfo"
local gemFunc = require "GemInfo"
local bagFunc = require "BagInfo"

local LvReward = require "lvarrive"

local function getRankRewardList( top )
	local t = require "lvrank"
	local r,rewardList = {},{}
	for _,v in ipairs(t) do
		if top>=v.low and top<=v.top then
			r = v.reward
			break
		end
	end
	table.foreach(r,function ( _,id )
		local rewards = dbManager.getReward(id)
		table.foreach(rewards,function ( _,v )
			table.insert(rewardList,v)
		end)
	end)
	return rewardList
end

local function addRankItem( self,view,v, index)
	local item = view.createLuaSet("@item")
	if v.Top<=3 then
		item["rankIcon"]:setVisible(true)
		item["rankIcon"]:setResid(string.format("N_KFCJ_tubiao%d.png",v.Top))
		item["rank"]:setVisible(false)
	else
		item["rankIcon"]:setVisible(false)
		item["rank"]:setVisible(true)
		item["rank"]:setString("NO."..v.Top)
		-- item["rankIcon_rank"]:setString(v.Top)
	end
	item["name"]:setString(v.Name)
	item["lv"]:setString(string.format("Lv.%d",v.Lv))

	local rewardList = getRankRewardList(v.Top)
	table.foreach(rewardList,function ( i,v )
		local reward = view.createLuaSet("@reward")
		reward["r"]:setVisible(i==1)
		reward["count"]:setString(string.format("x%d",v.amount))
		if i == #rewardList then
			reward["l"]:setResid("CZ_hongtiao1.png")
			reward["l"]:setPosition(-46,-19)
			reward["l"]:setScaleX(1)
		end
		if v.itemtype == 1 then
			reward["icon"]:setResid("TY_jinbi_da.png")
			if v.amount>=10000 then
				reward["count"]:setString(string.format("x%dw",v.amount/10000))
				local func = function ( ... )
					reward["count"]:setString(string.format("x%dk",v.amount/1000))
				end
				require 'LangAdapter'.selectLangkv({Arabic=func,ES=func,PT=func,German=func})
			end
			reward["name"]:setString(res.locString("Global$Gold"))
		elseif v.itemtype == 2 then
			reward["icon"]:setResid("TY_jinglingshi_da.png")
			reward["name"]:setString(res.locString("Global$SpriteStone"))
		elseif v.itemtype == 6 then
			local pet = petFunc.getPetInfoByPetId(v.itemid)
			res.setPetDetail(reward["icon"],pet)
			reward["name"]:setString(pet.Name)
			reward["btn"]:setListener(function ( ... )
				GleeCore:showLayer("DPetDetailV",{PetInfo = pet})
			end)
		elseif v.itemtype == 7 then
			local equip = equipFunc.getEquipInfoByEquipmentID(v.itemid)
			res.setEquipDetail(reward["icon"],equip)
			reward["name"]:setString(equip.Name)
			reward["btn"]:setListener(function ( ... )
				-- GleeCore:showLayer("DEquipInfoWithNoGem",{EquipInfo = equip})
				GleeCore:showLayer("DEquipDetail",{nEquip = equip})
			end)
		elseif v.itemtype == 8 then
			local gem = gemFunc.getGemByGemID(v.itemid)
			res.setGemDetail(reward["icon"],gem)
			reward["name"]:setString(gem.Name)
			reward["btn"]:setListener(function ( ... )
				GleeCore:showLayer("DGemDetail",{GemInfo = gem,ShowOnly = true})
			end)
		elseif v.itemtype == 9 then
			local material = bagFunc.getItemByMID(v.itemid)
			res.setItemDetail(reward["icon"],material)
			reward["name"]:setString(dbManager.getInfoMaterial(v.itemid).name)
			reward["btn"]:setListener(function ( ... )
				GleeCore:showLayer("DMaterialDetail",{materialId = v.itemid})
			end)
		end
		item["rewardLayout"]:addChild(reward[1])
	end)
	view["rankBg_rankList"]:getContainer():addChild(item[1], index)
end

local update1
update1 = function ( self,view,data )
	local open = os.date("*t",require "TimeListManager".getTimestamp(data.OpenAt))
	local close = os.date("*t",require "TimeListManager".getTimestamp(data.CloseAt))
	view["layout_time"]:setString(string.format(res.locString("Activity$ActTimeRegion"),open.month,open.day,open.hour,close.month,close.day,close.hour))
	require 'LangAdapter'.selectLangkv({German=function ( ... )
	    view["layout_time"]:setString(string.format(res.locString("Activity$ActTimeRegion"),open.day,open.month,open.hour,close.day,close.month,close.hour))
	end})
	local lv = userFunc.getLevel()
	local nextTarget
	view["rewardLayout"]:removeAllChildrenWithCleanup(true)
	for i=1,#LvReward do
		local v = LvReward[i]
		local item = view.createLuaSet("@lvReward")
		item["count"]:setString("x"..v.coin)
		item["lvBg_lv"]:setString(v.lv)
		local status = data.Rds[i]
		item["red"]:setVisible(status == 2)
		item["gotIcon"]:setVisible(status == 3)
		if status == 1 then
			nextTarget =  nextTarget or v.lv
		elseif status == 2 then
			item["btn"]:setListener(function ( ... )
				self:send(netModel.getModelReceiveUpgradeActReward(v.lv),function ( data )
					print(data)
					require "AppData".updateResource(data.D.Resource)
					item["red"]:setVisible(false)
					item["gotIcon"]:setVisible(true)
					item["btn"]:setEnabled(false)
					self:roleNewsUpdate()
					return self:toast(res.locString("Activity$UpgradeRewardGotTip")..v.coin)
				end)
			end)
		end
		view["rewardLayout"]:addChild(item[1])
	end
	if nextTarget then
		view["nextGetTipLabel"]:setVisible(true)
		view["nextGetTipLabel_lv"]:setString(string.format(res.locString("Activity$UpgradeRewardStatus"),nextTarget))
	else
		view["nextGetTipLabel"]:setVisible(false)
	end

	if data.Top~=0 then
		if data.Top<=500 then
			view["rankBg_linearlayout_myRank"]:setString(data.Top)
		else
			view["rankBg_linearlayout_myRank"]:setString(res.locString("Activity$UpgradeRewardNoBoard"))
		end
	else
		view["rankBg_linearlayout_myRank"]:setString(res.locString("Global$None"))
	end
	local list = data.Ranks
	table.sort(list,function ( a,b )
		return a.Top<b.Top
	end)
	view["rankBg_rankList"]:stopAllActions()
	view["rankBg_rankList"]:getContainer():removeAllChildrenWithCleanup(true)
	print("rankBg_rankList_stop")
	for i,v in ipairs(list) do
		local index = i
		if i < 5 then
			print("addRankItem" .. index)
			addRankItem(self,view,v, index)
		else
			self:runWithDelay(function ( ... )
				print("addRankItem" .. index)
				addRankItem(self,view,v, index)
			end,0.1*(i-5),view["rankBg_rankList"])
		end
	end
	view["rankBg_rankList"]:layout()
end

local update
update = function ( self,view,data )
	update1(self,view,data.D.Activity)
end

local function getNetModel( )
	return netModel.getModelUpgradeActInfoGet()
end

return {getNetModel = getNetModel,update = update}