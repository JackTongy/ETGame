local Config = require "Config"
local res = require "Res"
local GBHelper = require "GBHelper"
local dbManager = require "DBManager"
local netModel = require "netModel"
local gameFunc = require "AppData"

local DGBBox = class(LuaDialog)

function DGBBox:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGBBox.cocos.zip")
    return self._factory:createDocument("DGBBox.cocos")
end

--@@@@[[[[
function DGBBox:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._root = set:getElfNode("root")
    self._root_bg1 = set:getElfNode("root_bg1")
    self._root_bg1_layoutAdd_v = set:getLabelNode("root_bg1_layoutAdd_v")
    self._root_bg1_layoutAddCan = set:getLinearLayoutNode("root_bg1_layoutAddCan")
    self._root_bg1_layoutAddCan_v = set:getLabelNode("root_bg1_layoutAddCan_v")
    self._root_bg1_opened = set:getLabelNode("root_bg1_opened")
    self._root_bg2 = set:getElfNode("root_bg2")
    self._root_bg2_layoutAdd_v = set:getLabelNode("root_bg2_layoutAdd_v")
    self._root_bg2_layoutAddCan = set:getLinearLayoutNode("root_bg2_layoutAddCan")
    self._root_bg2_layoutAddCan_v = set:getLabelNode("root_bg2_layoutAddCan_v")
    self._root_bg2_opened = set:getLabelNode("root_bg2_opened")
    self._root_des = set:getLabelNode("root_des")
    self._root_layoutReward = set:getLayoutNode("root_layoutReward")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._count = set:getLabelNode("count")
    self._piece = set:getElfNode("piece")
    self._btn = set:getButtonNode("btn")
    self._root_layoutCost = set:getLinearLayoutNode("root_layoutCost")
    self._root_layoutCost_v = set:getLabelNode("root_layoutCost_v")
    self._root_btnOpen = set:getClickNode("root_btnOpen")
    self._root_btnOpen_text = set:getLabelNode("root_btnOpen_text")
--    self._@item = set:getElfNode("@item")
--    self._@item2 = set:getElfNode("@item2")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DGBBox:onInit( userData, netData )
	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._root, self)
	end)

	self:updateLayer()
	res.doActionDialogShow(self._root)
end

function DGBBox:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DGBBox:updateLayer( ... )
	local playerInfo = GBHelper.getGuildMatchPlayer()
	local boxCount = GBHelper.getGuildMatchBoxCount(playerInfo.ServerId, playerInfo.Gid)
	local atkAddition = dbManager.getInfoDefaultConfig("GBBUFFATK").Value
	local hpAddition = dbManager.getInfoDefaultConfig("GBBUFFHP").Value
	self._root_bg1_layoutAdd_v:setString(atkAddition * boxCount)
	self._root_bg1_layoutAddCan:setVisible(not playerInfo.Box)
	self._root_bg1_layoutAddCan_v:setString(atkAddition)
	self._root_bg1_opened:setVisible(playerInfo.Box)
	self._root_bg2_layoutAdd_v:setString(hpAddition * boxCount)
	self._root_bg2_layoutAddCan:setVisible(not playerInfo.Box)
	self._root_bg2_layoutAddCan_v:setString(hpAddition)
	self._root_bg2_opened:setVisible(playerInfo.Box)
	self._root_des:setString(dbManager.getInfoDefaultConfig("GBDEFAULT").Value)
	require 'LangAdapter'.fontSize(self._root_des, nil, nil, 15, nil, nil, 16, 16)

	local rewardList = {}
	local dbRewardList = dbManager.getInfoDefaultConfig("GBBOXREWARD").Value
	for i,v in ipairs(dbRewardList) do
		table.insert(rewardList, res.getDetailByDBReward( dbManager.getRewardItem(v) ))
	end

	self._root_layoutReward:removeAllChildrenWithCleanup(true)
	for i,v in ipairs(rewardList) do
		local item = self:createLuaSet("@item")
		self._root_layoutReward:addChild(item[1])
					
		item["bg"]:setResid(v.bg)
		item["icon"]:setResid(v.icon)
		if v.type == "Pet" or v.type == "PetPiece" then
			item["icon"]:setScale(140 / 95)
		else
			item["icon"]:setScale(1)
		end
		item["frame"]:setResid(v.frame)
		item["count"]:setString(v.count)
		item["piece"]:setVisible(v.isPiece)
		res.addRuneStars( item["frame"], v )
		item["btn"]:setListener(function ( ... )
			if v.eventData then
				GleeCore:showLayer(v.eventData.dialog, v.eventData.data)
			end
		end)
	end
	local emptyCount = 6 - #rewardList
	for i=1,emptyCount do
		local empty = self:createLuaSet("@item2")
		self._root_layoutReward:addChild(empty[1])
	end

	local coinCost = dbManager.getInfoDefaultConfig("GBBOXCOST").Value
	self._root_layoutCost_v:setString(coinCost)
	
	local status = GBHelper.getMatchStatusWithSeconds(  )
	self._root_btnOpen:setEnabled(not playerInfo.Box and (status == GBHelper.MatchStatus.BattleArraySetting or status == GBHelper.MatchStatus.FightPrepare))
	self._root_btnOpen_text:setString(playerInfo.Box and res.locString("GuildBattle$BoxBoxOpened") or res.locString("GuildBattle$BoxOpenBox"))
	self._root_btnOpen:setListener(function ( ... )
		if gameFunc.getUserInfo().getCoin() >= coinCost then
			local param = {}
			param.content = string.format(res.locString("GuildBattle$BoxBoxOpenTip"), coinCost)
			param.callback = function ( ... )
				self:send(netModel.getModelGuildMatchBox(), function ( data )
					if data and data.D then
						if data.D.Resource then
							gameFunc.updateResource(data.D.Resource)
						end
						GBHelper.setGuildMatchPlayer(data.D.Player)
						GBHelper.addMyGuildMatchBoxCount()
						self:updateLayer()
						res.doActionGetReward(data.D.Reward)	
						require "EventCenter".eventInput("GuildFightCastleUpdate")		
					end
				end)
			end
			GleeCore:showLayer("DConfirmNT", param)
		else
			require "Toolkit".showDialogOnCoinNotEnough()
		end
	end)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGBBox, "DGBBox")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGBBox", DGBBox)


