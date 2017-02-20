local Config = require "Config"
local LuaList = require "LuaList"
local netModel = require "netModel"
local res = require "Res"

local DSilverCoinFriend = class(LuaDialog)

function DSilverCoinFriend:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DSilverCoinFriend.cocos.zip")
    return self._factory:createDocument("DSilverCoinFriend.cocos")
end

--@@@@[[[[
function DSilverCoinFriend:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_bg = set:getJoint9Node("commonDialog_cnt_bg")
    self._commonDialog_cnt_bg_page = set:getElfNode("commonDialog_cnt_bg_page")
    self._commonDialog_cnt_bg_page_list = set:getListNode("commonDialog_cnt_bg_page_list")
    self._bg2 = set:getElfNode("bg2")
    self._icon = set:getElfNode("icon")
    self._layout1 = set:getLinearLayoutNode("layout1")
    self._layout1_name = set:getLabelNode("layout1_name")
    self._layout1_lv = set:getLabelNode("layout1_lv")
    self._layoutCharm = set:getLinearLayoutNode("layoutCharm")
    self._layoutCharm_value = set:getLabelNode("layoutCharm_value")
    self._layoutMySendPoint = set:getLinearLayoutNode("layoutMySendPoint")
    self._layoutMySendPoint_value = set:getLabelNode("layoutMySendPoint_value")
    self._btnSend = set:getClickNode("btnSend")
    self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
    self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DSilverCoinFriend", function ( userData )
 	Launcher.callNet(netModel.getModelMysteryShopGetFriends(),function ( data )
 		if data and data.D then
 			Launcher.Launching(data)
 		end
 	end)
end)

function DSilverCoinFriend:onInit( userData, netData )
	self.Friends = netData.D.Friends or {}
	self.StarAmount = userData.StarAmount
	self.callback = userData.callback
	self:setListenerEvent()
	self:updateLayer()
	res.doActionDialogShow(self._commonDialog)
end

function DSilverCoinFriend:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DSilverCoinFriend:setListenerEvent( ... )
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._commonDialog_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)
end

function DSilverCoinFriend:updateLayer( ... )
	self.FriendList = LuaList.new(self._commonDialog_cnt_bg_page_list, function ( ... )
		return self:createLuaSet("@item")
	end, function ( nodeLuaSet, v, listIndex )
		res.setNodeWithPet(nodeLuaSet["icon"], require "PetInfo".getPetInfoByPetId(v.PetId, v.AwakeIndex))
		nodeLuaSet["layout1_name"]:setString(v.Name)
		nodeLuaSet["layout1_lv"]:setString("Lv." .. v.Lv)
		nodeLuaSet["layoutCharm_value"]:setString(v.OwnMl)
		nodeLuaSet["layoutMySendPoint_value"]:setString(v.SendMl)
		nodeLuaSet["btnSend"]:setListener(function ( ... )
			self:send(netModel.getModelMysteryShopSend(v.Fid, self.StarAmount), function ( data )
				if data and data.D then
					local bagFunc = require "BagInfo"
					local nWater = bagFunc.getItemWithItemId(68)
					bagFunc.useItemByID(nWater.Id, self.StarAmount)
					require "SilverCoinInfo".setRecord(data.D.Record)
					require "EventCenter".eventInput("UpdateActivity")
					res.doActionDialogHide(self._commonDialog, function ( ... )
						if self.callback then
							self.callback()
							self:close()
						end
					end)
					self:toast(string.format(res.locString("SilverCoinShop$SendSuc"), self.StarAmount))
				end
			end)
		end)
	end)
	
	table.sort(self.Friends, function ( v1, v2 )
		if v1.SendMl == v2.SendMl then
			if v1.OwnMl == v2.OwnMl then
				if v1.Lv == v2.Lv then
					return v1.Fid < v2.Fid
				else
					return v1.Lv > v2.Lv
				end
			else
				return v1.OwnMl > v2.OwnMl
			end
		else
			return v1.SendMl > v2.SendMl
		end
	end)

	self.FriendList:update(self.Friends)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DSilverCoinFriend, "DSilverCoinFriend")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DSilverCoinFriend", DSilverCoinFriend)


