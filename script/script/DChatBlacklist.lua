local Config = require "Config"
local res = require "Res"
local LuaList = require "LuaList"
local gameFunc = require "AppData"
local BlacklistInfo = require "BlacklistInfo"
local netModel = require "netModel"
local dbManager = require "DBManager"

local DChatBlacklist = class(LuaDialog)

function DChatBlacklist:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DChatBlacklist.cocos.zip")
    return self._factory:createDocument("DChatBlacklist.cocos")
end

--@@@@[[[[
function DChatBlacklist:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_bg = set:getJoint9Node("commonDialog_cnt_bg")
    self._commonDialog_cnt_bg_page = set:getElfNode("commonDialog_cnt_bg_page")
    self._bg = set:getElfNode("bg")
    self._bg_list = set:getListNode("bg_list")
    self._bg2 = set:getElfNode("bg2")
    self._icon = set:getElfNode("icon")
    self._layout1 = set:getLinearLayoutNode("layout1")
    self._layout1_name = set:getLabelNode("layout1_name")
    self._layout1_lv = set:getLabelNode("layout1_lv")
    self._layoutBattleValue = set:getLinearLayoutNode("layoutBattleValue")
    self._layoutBattleValue_value = set:getLabelNode("layoutBattleValue_value")
    self._layoutStatus = set:getLinearLayoutNode("layoutStatus")
    self._layoutStatus_value = set:getLabelNode("layoutStatus_value")
    self._btnDel = set:getClickNode("btnDel")
    self._layoutCount = set:getLinearLayoutNode("layoutCount")
    self._layoutCount_k = set:getLabelNode("layoutCount_k")
    self._layoutCount_v = set:getLabelNode("layoutCount_v")
    self._btnDelAll = set:getClickNode("btnDelAll")
    self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
    self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
--    self._@pageBlacklist = set:getElfNode("@pageBlacklist")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DChatBlacklist:onInit( userData, netData )
	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._commonDialog, function ( ... )
			self:close()
			if self.BlackListUpdate then
				require "EventCenter".eventInput("BlackListUpdate")
			end
		end)
	end)

	self._commonDialog_btnClose:setListener(function (  )
		res.doActionDialogHide(self._commonDialog, function ( ... )
			self:close()
			if self.BlackListUpdate then
				require "EventCenter".eventInput("BlackListUpdate")
			end
		end)
	end)

	local pageBlacklist = self:createLuaSet("@pageBlacklist")
	self._commonDialog_cnt_bg_page:addChild(pageBlacklist[1])
	self:updatePage(pageBlacklist)

	res.doActionDialogShow(self._commonDialog)
end

function DChatBlacklist:onBack( userData, netData )
	
end

function DChatBlacklist:updatePage( set )
	if not self.blacklist then
		self.blacklist = LuaList.new(set["bg_list"], function ( ... )
			return self:createLuaSet("@item")
		end, function ( nodeLuaSet, nBlackInfo, listIndex )
			res.setNodeWithPet(nodeLuaSet["icon"], gameFunc.getPetInfo().getPetInfoByPetId(nBlackInfo.PetId, nBlackInfo.AwakeIndex))
			nodeLuaSet["layout1_name"]:setString(nBlackInfo.Name)
			nodeLuaSet["layout1_lv"]:setString(string.format("Lv.%d", nBlackInfo.Lv))
			nodeLuaSet["layoutBattleValue_value"]:setString(nBlackInfo.Pwr)
			if nBlackInfo.IsOnline then
				nodeLuaSet["layoutStatus_value"]:setString(res.locString("Friend$Online"))
			else
				local timerListManager = require "TimeListManager"
				local seconds = timerListManager.getTimeUpToNow(nBlackInfo.LoginAt)
				nodeLuaSet["layoutStatus_value"]:setString(res.getTimeText(seconds/60))
			end

			nodeLuaSet["btnDel"]:setListener(function (  )
				self:send(netModel.getModelBlackListUpdate(nBlackInfo.Rid * -1), function ( data )
					if data and data.D then
						BlacklistInfo.remove(nBlackInfo.Rid)
						self:updatePage(set)
						self.BlackListUpdate = true
						self:toast(res.locString("Blacklist$delSuc"))
					end
				end)
			end)
		end)
	end
	local list = BlacklistInfo.getBlackList() or {}
	self.blacklist:update(list)
	local limit = dbManager.getInfoDefaultConfig("BlackListLimit").Value
	set["layoutCount_v"]:setString(#list .. "/" .. limit)
	set["btnDelAll"]:setEnabled(#list > 0)
	set["btnDelAll"]:setListener(function ( ... )
		self:send(netModel.getModelBlackListClear(), function ( data )
			if data and data.D then
				BlacklistInfo.clearBlackList()
				self:updatePage(set)
				self.BlackListUpdate = true
				self:toast(res.locString("Blacklist$delSuc"))
			end
		end)
	end)
	require "LangAdapter".LabelNodeAutoShrink(set["btnDelAll_#text"], 104)
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DChatBlacklist, "DChatBlacklist")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DChatBlacklist", DChatBlacklist)
