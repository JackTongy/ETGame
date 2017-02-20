local Config = require "Config"
local res = require "Res"
local LuaList = require "LuaList"
local gameFunc = require "AppData"
local FriendHelper = require "FriendHelper"

local DFriendSearchList = class(LuaDialog)

function DFriendSearchList:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DFriendSearchList.cocos.zip")
    return self._factory:createDocument("DFriendSearchList.cocos")
end

--@@@@[[[[
function DFriendSearchList:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getJoint9Node("bg")
    self._bg_list = set:getListNode("bg_list")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._layout1 = set:getLinearLayoutNode("layout1")
    self._layout1_name = set:getLabelNode("layout1_name")
    self._layout1_lv = set:getLabelNode("layout1_lv")
    self._layoutBattleValue = set:getLinearLayoutNode("layoutBattleValue")
    self._layoutBattleValue_value = set:getLabelNode("layoutBattleValue_value")
    self._layoutStatus = set:getLinearLayoutNode("layoutStatus")
    self._layoutStatus_value = set:getLabelNode("layoutStatus_value")
    self._applyed = set:getLabelNode("applyed")
    self._btnAdd = set:getButtonNode("btnAdd")
    self._btnSendMail = set:getButtonNode("btnSendMail")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DFriendSearchList:onInit( userData, netData )
	self.dataList = userData

	self:setListenerEvent()
	self:updateLayer()
	res.doActionDialogShow(self._bg)
end

function DFriendSearchList:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DFriendSearchList:setListenerEvent( ... )
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)
end

function DFriendSearchList:updateLayer( ... )
	if not self.searchList then
		self.searchList = LuaList.new(self._bg_list, function ( ... )
			return self:createLuaSet("@item")
		end, function ( nodeLuaSet, friendInfo )
			res.setNodeWithPet(nodeLuaSet["icon"], gameFunc.getPetInfo().getPetInfoByPetId(friendInfo.PetId, friendInfo.AwakeIndex))
			nodeLuaSet["layout1_name"]:setString(friendInfo.Name)
			nodeLuaSet["layout1_lv"]:setString(string.format("Lv.%d", friendInfo.Lv))
			nodeLuaSet["layoutBattleValue_value"]:setString(friendInfo.CombatPower)
			if friendInfo.IsOnline then
				nodeLuaSet["layoutStatus_value"]:setString(res.locString("Friend$Online"))
			else
				local timerListManager = require "TimeListManager"
				local seconds = timerListManager.getTimeUpToNow(friendInfo.LoginAt)
				nodeLuaSet["layoutStatus_value"]:setString(self:getOffLineText(seconds / 60))
			end
			nodeLuaSet["btnSendMail"]:setEnabled( gameFunc.getUserInfo().getId() ~= friendInfo.Fid )
			nodeLuaSet["btnSendMail"]:setListener(function ( ... )
				local temp = {}
				temp.mailType = "MailSend"
				temp.receiveId = friendInfo.Fid
				temp.title = string.format(res.locString("Mail$MailTo"), friendInfo.Name)
				temp.titleReal = string.format(res.locString("Mail$MailFrom"), gameFunc.getUserInfo().getName())
				GleeCore:showLayer("DMailDetail", temp)
			end)
			local alreadyFriend = gameFunc.getFriendsInfo().isMyFriend(friendInfo.Fid)
			nodeLuaSet["applyed"]:setVisible(friendInfo.applyed == true or alreadyFriend)
			nodeLuaSet["applyed"]:setString(alreadyFriend and res.locString("Friend$AlreadyFriend") or res.locString("Friend$Applied"))
			nodeLuaSet["btnAdd"]:setVisible(not nodeLuaSet["applyed"]:isVisible())
			nodeLuaSet["btnAdd"]:setEnabled(gameFunc.getUserInfo().getId() ~= friendInfo.Fid)
			nodeLuaSet["btnAdd"]:setListener(function ( ... )
				FriendHelper.FriendApply(self, friendInfo.Fid, function ( data )
					friendInfo.applyed = true
					self:updateLayer()
					self:toast(res.locString("Friend$IsSendFriend"))
				end, function ( data )
					nodeLuaSet["btnAdd"]:setEnabled(false)
				end)
			end)
		end)
	end
	self.searchList:update(self.dataList)
end

function DFriendSearchList:getOffLineText( minute )
	local text
	if minute < 60 then
		text = res.locString("Friend$Time1")	
	elseif minute < 60 * 24 then
		text = res.locString("Friend$Time6")
	else
		text = string.format(res.locString("Friend$Time5"), math.floor(minute / (60 * 24)))
	end
	return text
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DFriendSearchList, "DFriendSearchList")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DFriendSearchList", DFriendSearchList)
