local Config = require "Config"
local LuaList = require "LuaList"
local netModel = require "netModel"
local res = require "Res"
local dbManager = require "DBManager"
local timeManager = require "TimeManager"
local gameFunc = require "AppData"
local userFunc = gameFunc.getUserInfo()
local SilverCoinInfo = gameFunc.getSilverCoinInfo()

local tabList = {TabML = 1, TabRp = 2}

local DSilverCoinRankList = class(LuaDialog)

function DSilverCoinRankList:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DSilverCoinRankList.cocos.zip")
    return self._factory:createDocument("DSilverCoinRankList.cocos")
end

--@@@@[[[[
function DSilverCoinRankList:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getJoint9Node("bg")
    self._bg_tbg = set:getElfNode("bg_tbg")
    self._bg_tbg_title = set:getLabelNode("bg_tbg_title")
    self._bg_cbg = set:getElfNode("bg_cbg")
    self._bg_titileRankName = set:getLabelNode("bg_titileRankName")
    self._bg_titleServer = set:getLabelNode("bg_titleServer")
    self._bg_titleQinMi = set:getLabelNode("bg_titleQinMi")
    self._bg_titleTime12 = set:getLabelNode("bg_titleTime12")
    self._bg_titleTime21 = set:getLabelNode("bg_titleTime21")
    self._bg_titleTime24 = set:getLabelNode("bg_titleTime24")
    self._bg_list = set:getListNode("bg_list")
    self._btn = set:getTabNode("btn")
    self._btn_normal_bg = set:getElfNode("btn_normal_bg")
    self._btn_pressed_bg = set:getJoint9Node("btn_pressed_bg")
    self._rankIcon = set:getElfNode("rankIcon")
    self._rankLabel = set:getLabelNode("rankLabel")
    self._name = set:getLabelNode("name")
    self._server = set:getLabelNode("server")
    self._qinmi = set:getLabelNode("qinmi")
    self._group12 = set:getLayoutNode("group12")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._count = set:getLabelNode("count")
    self._piece = set:getElfNode("piece")
    self._group21 = set:getLayoutNode("group21")
    self._group24 = set:getLayoutNode("group24")
    self._getLabel12 = set:getLabelNode("getLabel12")
    self._getLabel21 = set:getLabelNode("getLabel21")
    self._getLabel24 = set:getLabelNode("getLabel24")
    self._showInfo12 = set:getClickNode("showInfo12")
    self._showInfo21 = set:getClickNode("showInfo21")
    self._showInfo24 = set:getClickNode("showInfo24")
    self._bg_btnTurnLeft = set:getButtonNode("bg_btnTurnLeft")
    self._bg_btnTurnRight = set:getButtonNode("bg_btnTurnRight")
    self._bg_titleBottom = set:getLabelNode("bg_titleBottom")
--    self._@cell = set:getElfNode("@cell")
--    self._@icon = set:getElfNode("@icon")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DSilverCoinRankList", function ( userData )
 	Launcher.callNet(netModel.getModelMysteryShopGetRanks(),function ( data )
 		if data and data.D then
 			Launcher.Launching(data)
 		end
 	end)
end)

function DSilverCoinRankList:onInit( userData, netData )
	if netData and netData.D then
		self.RpRanks = netData.D.RpRanks
		self.MlRanks = netData.D.MlRanks
		self.ServerName = netData.D.ServerName
	end
	self.tabIndex = tabList.TabML

	self:setListenerEvent()
	self:updateLayer()
	res.doActionDialogShow(self._bg)
end

function DSilverCoinRankList:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DSilverCoinRankList:setListenerEvent( ... )
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_btnTurnLeft:setListener(function ( ... )
		self.tabIndex = tabList.TabML
		self:updateLayer()
	end)

	self._bg_btnTurnRight:setListener(function ( ... )
		self.tabIndex = tabList.TabRp
		self:updateLayer()
	end)
end

function DSilverCoinRankList:updateLayer( ... )
	if not self.rankList then
		self.rankList = LuaList.new(self._bg_list, function ( ... )
			return self:createLuaSet("@cell")
		end, function ( row, v, listIndex )
			if self.selectUserId == v.Rid then
				row["btn"]:trigger(nil)
			end
			row["btn_normal_bg"]:setResid(string.format('JLD_PM_FL%d.png', listIndex%2 == 0 and 1 or 2))
			row["rankIcon"]:setVisible(v.Rank <= 3)
			row["rankLabel"]:setVisible(v.Rank > 3)
			local color
			if v.Rank <= 3 then
				row["rankIcon"]:setResid(string.format('PHB_PM%d.png', v.Rank))
				color = ccc4f(0.74509805,0.21176471,0.08627451,1.0)
			else
				row["rankLabel"]:setString(v.Rank <= 20 and tostring(v.Rank) or "20+")
				color = ccc4f(0.58431375,0.3882353,0.21568628,1.0)
			end
			row["rankLabel"]:setFontFillColor(color, true)
			row["name"]:setFontFillColor(color, true)
			row["server"]:setFontFillColor(color, true)
			row["qinmi"]:setFontFillColor(color, true)
			row["getLabel12"]:setFontFillColor(color, true)
			row["getLabel21"]:setFontFillColor(color, true)
			row["getLabel24"]:setFontFillColor(color, true)

			row["name"]:setString(v.Name)
			row["server"]:setString(v.ServerName)
			row["qinmi"]:setString(v.Value)

			local td = {12, 21, 24}
			local date = timeManager.getCurrentSeverDate()
			for i,t in ipairs(td) do
				local rewardVisible = v.nRewardList ~= nil and v.nRewardList[i] ~= nil and #v.nRewardList[i] > 0
				row[string.format("getLabel%d", t)]:setVisible(rewardVisible and date.hour >= t)
				row[string.format("group%d", t)]:setVisible(rewardVisible and date.hour < t)
				row[string.format("group%d", t)]:removeAllChildrenWithCleanup(true)
				if rewardVisible then
					for _,nReward in ipairs(v.nRewardList[i]) do
						local icon = self:createLuaSet("@icon")
						row[string.format("group%d", t)]:addChild(icon[1])
						self:updateRewardIcon(nReward, icon)
					end
				end

				row[string.format("showInfo%d", t)]:setVisible(rewardVisible and date.hour < t)
			   row[string.format("showInfo%d", t)]:setListener(function( ... )
			      GleeCore:showLayer('DHatchEggRankRewardInfo',{time = t,Rank = v.Rank,rewardList = v.nRewardList[i]})
			   end)
			end
		end)
	end

	self.selectUserId = userFunc.getId()
	if self.tabIndex == tabList.TabML then
		self._bg_tbg_title:setString(res.locString("SilverCoinShop$MLTitle"))
		self._bg_titleQinMi:setString(res.locString("SilverCoinShop$MLValue"))
		self._bg_btnTurnLeft:setVisible(false)
		self._bg_btnTurnRight:setVisible(true)
		self.rankList:update(self:getMlRankData())
	elseif self.tabIndex == tabList.TabRp then
		self._bg_tbg_title:setString(res.locString("SilverCoinShop$RPTitle"))
		self._bg_titleQinMi:setString(res.locString("SilverCoinShop$RPValue"))
		self._bg_btnTurnLeft:setVisible(true)
		self._bg_btnTurnRight:setVisible(false)
		self.rankList:update(self:getRpRankData())
	end
end

function DSilverCoinRankList:isUserInList( list )
	local userId = userFunc.getId()
	for i,v in ipairs(list) do
		if v.Rid == userId then
			return true
		end
	end
	return false
end

function DSilverCoinRankList:getMlRankData( ... )
	if self.MlRanksIsFormat then
		self.MlRanksIsFormat = true
		return self.MlRanks
	end

	if not self:isUserInList(self.MlRanks) then
		local me = {}
		me.Rid = userFunc.getId()
		me.Name = userFunc.getName()
		me.ServerName = self.ServerName
		me.Value = SilverCoinInfo.getRecord().MlValue
		table.insert(self.MlRanks, me)
	end

	local userId = userFunc.getId()
	for i,v in ipairs(self.MlRanks) do
		self.MlRanks[i].Rank = i
		self.MlRanks[i].nRewardList = {}
		local dbMl = dbManager.getInfoCharmRankReward(i)
		if dbMl then
			for j=1,3 do
				self.MlRanks[i].nRewardList[j] = {}
				for _,rwdId in ipairs(dbMl[string.format("reward%d", j)]) do
					local rewardSet = res.getDetailByDBReward( dbManager.getRewardItem(rwdId) )
					table.insert(self.MlRanks[i].nRewardList[j], rewardSet)
				end
			end
		end
	end
	return self.MlRanks
end

function DSilverCoinRankList:getRpRankData( ... )
	if self.RpRanksIsFormat then
		self.RpRanksIsFormat = true
		return self.RpRanks
	end

	if not self:isUserInList(self.RpRanks) then
		local me = {}
		me.Rid = userFunc.getId()
		me.Name = userFunc.getName()
		me.ServerName = self.ServerName
		me.Value = SilverCoinInfo.getRecord().RpValue
		table.insert(self.RpRanks, me)
	end

	local userId = userFunc.getId()
	for i,v in ipairs(self.RpRanks) do
		self.RpRanks[i].Rank = i
		self.RpRanks[i].nRewardList = {}
		local dbRp = dbManager.getInfoRpRankReward(i)
		if dbRp then
			for j=1,3 do
				self.RpRanks[i].nRewardList[j] = {}
				for _,rwdId in ipairs(dbRp[string.format("reward%d", j)]) do
					local rewardSet = res.getDetailByDBReward( dbManager.getRewardItem(rwdId) )
					table.insert(self.RpRanks[i].nRewardList[j], rewardSet)
				end
			end
		end
	end
	return self.RpRanks
end

function DSilverCoinRankList:updateRewardIcon( data , view)
   local scaleOrigal = 110 / 155
   view["bg"]:setResid(data.bg)
   view["bg"]:setScale(scaleOrigal)
   view["icon"]:setResid(data.icon)
   if data.type == "Pet" or data.type == "PetPiece" then
      view["icon"]:setScale(scaleOrigal * 140 / 95)
   else
      view["icon"]:setScale(scaleOrigal)
   end
   view["frame"]:setResid(data.frame)
   view["frame"]:setScale(scaleOrigal)
   view["count"]:setString(data.count)
   view["piece"]:setVisible(data.isPiece)

   res.addRuneStars( view["frame"], data )
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DSilverCoinRankList, "DSilverCoinRankList")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DSilverCoinRankList", DSilverCoinRankList)
