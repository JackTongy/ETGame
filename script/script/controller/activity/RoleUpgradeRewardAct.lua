-- local Config = require "Config"

-- local RoleUpgradeRewardAct = class(LuaController)

-- function RoleUpgradeRewardAct:createDocument()
--     self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."RoleUpgradeRewardAct.cocos.zip")
--     return self._factory:createDocument("RoleUpgradeRewardAct.cocos")
-- end

--@@@@[[[[
-- function RoleUpgradeRewardAct:onInitXML()
-- 	local set = self._set
--     self._title2Layout_totalCoin = set:getLabelNode("title2Layout_totalCoin")
--     self._timeLayout = set:getLinearLayoutNode("timeLayout")
--     self._timeLayout_day = set:getLabelNode("timeLayout_day")
--     self._timeLayout_time = set:getTimeNode("timeLayout_time")
--     self._list = set:getListNode("list")
--     self._count = set:getLabelNode("count")
--     self._name = set:getLabelNode("name")
--     self._des = set:getLabelNode("des")
--     self._btn = set:getClickNode("btn")
--     self._btn_text = set:getLabelNode("btn_text")
-- --    self._@view = set:getElfNode("@view")
-- --    self._@item = set:getElfNode("@item")
-- end
--@@@@]]]]

-- --------------------------------override functions----------------------
-- function RoleUpgradeRewardAct:onInit( userData, netData )
	
-- end

-- function RoleUpgradeRewardAct:onBack( userData, netData )
	
-- end

-- --------------------------------custom code-----------------------------


-- --------------------------------class end-------------------------------
-- require 'framework.basic.MetaHelper'.classDefinitionEnd(RoleUpgradeRewardAct, "RoleUpgradeRewardAct")


-- --------------------------------register--------------------------------
-- GleeCore:registerLuaController("RoleUpgradeRewardAct", RoleUpgradeRewardAct)

local res = require "Res"
local timeTool = require "TimeListManager"
local netModel = require "netModel"

local function hasReward( rds )
	for i,v in ipairs(rds) do
		if v == 2 then
			return true
		end
	end
	return false
end

local function updateBtnStatus(item,status)
	if status == 1 then
		item["btn"]:setEnabled(false)
	elseif status == 2 then
		item["btn"]:setEnabled(true)
	elseif status == 3 then
		item["btn"]:setEnabled(false)
		item["btn_text"]:setString(res.locString("Global$ReceiveFinish"))
	end
end

local update
update = function ( self,view,data )
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

	local rewardConfig = require "lvarrive2"
	local totalCoin = 0
	local rds = data.D.Rds
	for i,v in ipairs(rewardConfig) do
		totalCoin = totalCoin + v.coin
		local item = view.createLuaSet("@item")
		item["count"]:setString("x"..v.coin)
		item["name"]:setString(string.format(res.locString("Activity$RoleUpgradeItemName"),v.lv))
		item["des"]:setString(string.format(res.locString("Activity$RoleUpgradeItemDes"),v.lv))
		
		item["btn"]:setListener(function ( ... )
			self:send(netModel.getModelReceiveUpgradeActReward(v.lv),function ( data )
				require "AppData".updateResource(data.D.Resource)
				rds[i] = 3
				if not hasReward(rds) then
					self:roleNewsUpdate()
				end
				updateBtnStatus(item,rds[i])
				return self:toast(res.locString("Activity$UpgradeRewardGotTip")..v.coin)
			end)
		end)
		updateBtnStatus(item,rds[i])
		view["list"]:addListItem(item[1])
	end
	view["title2Layout_totalCoin"]:setString(totalCoin)
end

local function getNetModel( )
	return netModel.getModelUpgradeRewardActInfoGet()
end

return {getNetModel = getNetModel,update = update}

