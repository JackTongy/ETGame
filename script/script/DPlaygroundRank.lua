local Config = require "Config"
local res = require "Res"
local PlaygroundInfo = require "PlaygroundInfo"
local netModel = require "netModel"
local LuaList = require "LuaList"

local DPlaygroundRank = class(LuaDialog)

function DPlaygroundRank:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPlaygroundRank.cocos.zip")
    return self._factory:createDocument("DPlaygroundRank.cocos")
end

--@@@@[[[[
function DPlaygroundRank:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._commonDialog = set:getElfNode("commonDialog")
   self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
   self._commonDialog_cnt_page = set:getElfNode("commonDialog_cnt_page")
   self._bg = set:getJoint9Node("bg")
   self._titleBg = set:getElfNode("titleBg")
   self._titleBg_layoutTitle = set:getLayoutNode("titleBg_layoutTitle")
   self._titleBg_layoutTitle_rank = set:getLabelNode("titleBg_layoutTitle_rank")
   self._titleBg_layoutTitle_name = set:getLabelNode("titleBg_layoutTitle_name")
   self._titleBg_layoutTitle_seconds = set:getLabelNode("titleBg_layoutTitle_seconds")
   self._list = set:getListNode("list")
   self._bg = set:getElfNode("bg")
   self._layoutRankTitle = set:getLayoutNode("layoutRankTitle")
   self._layoutRankTitle_rank = set:getLabelNode("layoutRankTitle_rank")
   self._layoutRankTitle_rank_icon = set:getElfNode("layoutRankTitle_rank_icon")
   self._layoutRankTitle_name = set:getLabelNode("layoutRankTitle_name")
   self._layoutRankTitle_seconds = set:getLabelNode("layoutRankTitle_seconds")
   self._btn = set:getButtonNode("btn")
   self._noResult = set:getLabelNode("noResult")
   self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
   self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
--   self._<FULL_NAME1> = set:getElfNode("@pageRank")
--   self._<FULL_NAME1> = set:getElfNode("@itemRank")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DPlaygroundRank", function ( userData )
	Launcher.callNet(netModel.getModelPlaygroundRanks(), function ( data )
		Launcher.Launching(data)
	end)
end)

function DPlaygroundRank:onInit( userData, netData )
	if netData and netData.D then
		self.RankList = netData.D.Ranks
	end
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._commonDialog_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self.pageRank = self:createLuaSet("@pageRank")
	self._commonDialog_cnt_page:addChild(self.pageRank[1])
	self:updateLayer()

	res.doActionDialogShow(self._commonDialog)
end

function DPlaygroundRank:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DPlaygroundRank:updateLayer( ... )
	local pageRank = self.pageRank
	local RankList = self.RankList or {}
	
	pageRank["noResult"]:setVisible(#RankList == 0)
	pageRank["list"]:setVisible(#RankList > 0)
	if #RankList > 0 then
		if not self.RankNodeList then
			self.RankNodeList = LuaList.new(pageRank["list"], function ( ... )
				return self:createLuaSet("@itemRank")
			end, function ( nodeLuaSet, nRank, listIndex )
				nodeLuaSet["bg"]:setVisible(listIndex % 2 == 0)
				nodeLuaSet["layoutRankTitle_rank"]:setString(nRank.Rank < 4 and "" or nRank.Rank)
				nodeLuaSet["layoutRankTitle_rank_icon"]:setVisible(nRank.Rank < 4)
				if nRank.Rank < 4 then
					nodeLuaSet["layoutRankTitle_rank_icon"]:setResid(string.format("PHB_PM%d.png", nRank.Rank))
				end

				nodeLuaSet["layoutRankTitle_name"]:setString(nRank.Name)
				nodeLuaSet["layoutRankTitle_seconds"]:setString(nRank.Seconds)
			end)
		end
		self.RankNodeList:update(RankList)
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPlaygroundRank, "DPlaygroundRank")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPlaygroundRank", DPlaygroundRank)
