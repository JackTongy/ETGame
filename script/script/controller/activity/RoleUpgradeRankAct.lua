-- local Config = require "Config"

-- local RoleUpgradeRankAct = class(LuaController)

-- function RoleUpgradeRankAct:createDocument()
--     self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."RoleUpgradeRankAct.cocos.zip")
--     return self._factory:createDocument("RoleUpgradeRankAct.cocos")
-- end

--@@@@[[[[
-- function RoleUpgradeRankAct:onInitXML()
-- 	local set = self._set
--     self._linearlayout_myRank = set:getLabelNode("linearlayout_myRank")
--     self._timeLayout = set:getLinearLayoutNode("timeLayout")
--     self._timeLayout_day = set:getLabelNode("timeLayout_day")
--     self._timeLayout_time = set:getTimeNode("timeLayout_time")
--     self._rankList = set:getListNode("rankList")
--     self._rankIcon = set:getElfNode("rankIcon")
--     self._rank = set:getLabelNode("rank")
--     self._name = set:getLabelNode("name")
--     self._lv = set:getLabelNode("lv")
--     self._rewardLayout = set:getLinearLayoutNode("rewardLayout")
--     self._icon = set:getElfNode("icon")
--     self._count = set:getLabelNode("count")
--     self._name = set:getLabelNode("name")
--     self._btn = set:getButtonNode("btn")
-- --    self._@view = set:getElfNode("@view")
-- --    self._@item = set:getElfNode("@item")
-- --    self._@reward = set:getElfNode("@reward")
-- end
--@@@@]]]]

-- --------------------------------override functions----------------------
-- function RoleUpgradeRankAct:onInit( userData, netData )
	
-- end

-- function RoleUpgradeRankAct:onBack( userData, netData )
	
-- end

-- --------------------------------custom code-----------------------------


-- --------------------------------class end-------------------------------
-- require 'framework.basic.MetaHelper'.classDefinitionEnd(RoleUpgradeRankAct, "RoleUpgradeRankAct")


-- --------------------------------register--------------------------------
-- GleeCore:registerLuaController("RoleUpgradeRankAct", RoleUpgradeRankAct)
local res = require "Res"
local dbManager = require "DBManager"
local netModel = require "netModel"
local petFunc = require "PetInfo"
local equipFunc = require "EquipInfo"
local gemFunc = require "GemInfo"
local bagFunc = require "BagInfo"
local timeTool = require "TimeListManager"

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
	end
	item["name"]:setString(v.Name)
	item["lv"]:setString(string.format("%d",v.Lv))

	local rewardList = getRankRewardList(v.Top)
	table.foreach(rewardList,function ( i,v )
		local reward = view.createLuaSet("@reward")
		reward["count"]:setString(string.format("x%d",v.amount))
		if v.itemtype == 1 then
			reward["icon"]:setResid("TY_jinbi_da.png")
			if v.amount>=10000 then
				reward["count"]:setString(string.format(res.locString("Activity$RoleUpgradeGoldFormat"),v.amount/10000))
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
		selectLang(nil,nil,nil,nil,nil,nil,nil,nil,nil,function (  )
			reward["name"]:setString("")
		end)
		item["rewardLayout"]:addChild(reward[1])
	end)
	
	view["rankList"]:getContainer():addChild(item[1], index)
end

local update
update = function ( self,view,data )
	view["#rankRewardTip"]:setAnchorPoint(ccp(0,0.5))
	view["#rankRewardTip"]:setPosition(-280,150)

	selectLang(nil,nil,nil,nil,nil,
		function (  )
		view["#rankRewardTip"]:setPosition(-280,130)
		view["timeLayout"]:setPosition(-278,88)
		view["#linearlayout"]:setPosition(287,97)
	end,function (  )
		view["#rankRewardTip"]:setPosition(-280,130)
		view["timeLayout"]:setPosition(-278,88)
		view["#linearlayout"]:setPosition(287,97)
	end,nil,nil,function (  )
		view["#rankRewardTip"]:setPosition(-280,130)
		view["timeLayout"]:setPosition(-278,88)
		view["#linearlayout"]:setPosition(287,97)
	end)

	local closeAt = data.D.CloseAt
	local cd = -timeTool.getTimeUpToNow(closeAt)
	local h,m,s = timeTool.getTimeInfoBySeconds(cd)
	local d = math.floor(h/24)
	h = h%24
	if d>0 then
		view["timeLayout_day"]:setString(d..res.locString("Activity$DayTaild"))
	else
		view["timeLayout_day"]:removeFromParentAndCleanup(true)
	end
	view["timeLayout_time"]:setHourMinuteSecond(h,m,s)

	local listener = ElfDateListener:create(function ( ... )
		if d>0 then
			d = d - 1
			if d>0 then
				view["timeLayout_day"]:setString(d..res.locString("Activity$DayTaild"))
			else
				view["timeLayout_day"]:removeFromParentAndCleanup(true)
			end
		else
			return self:onActivityFinish(self.curShowActivity)
		end
	end)
	listener:setHourMinuteSecond(0,0,1)
	view["timeLayout_time"]:addListener(listener)

	local selfRank = data.D.Top
	if selfRank~=0 then
		if selfRank<=500 then
			view["linearlayout_myRank"]:setString(selfRank)
		else
			view["linearlayout_myRank"]:setString(res.locString("Activity$UpgradeRewardNoBoard"))
		end
	else
		view["linearlayout_myRank"]:setString(res.locString("Global$None"))
	end

	local list = data.D.Ranks
	table.sort(list,function ( a,b )
		return a.Top<b.Top
	end)
	view["rankList"]:getContainer():removeAllChildrenWithCleanup(true)
	for i,v in ipairs(list) do
		local index = i
		if i < 5 then
			addRankItem(self,view,v, index)
		else
			self.tickHandle[#self.tickHandle+1] = require "framework.sync.TimerHelper".tick(function (  )
				addRankItem(self,view,v,index)
				return true
			end,0.1*(i-5))
		end
	end
end

local function getNetModel( )
	return netModel.getModelUpgradeRankActInfoGet()
end

return {getNetModel = getNetModel,update = update}
