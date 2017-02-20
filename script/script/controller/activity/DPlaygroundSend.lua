local Config = require "Config"
local res = require "Res"
local gameFunc = require "AppData"
local friendsFunc = gameFunc.getFriendsInfo()
local netModel = require "netModel"
local LuaList = require "LuaList"
local PlaygroundInfo = require "PlaygroundInfo"
local dbManager = require "DBManager"

local DPlaygroundSend = class(LuaDialog)

function DPlaygroundSend:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPlaygroundSend.cocos.zip")
    return self._factory:createDocument("DPlaygroundSend.cocos")
end

--@@@@[[[[
function DPlaygroundSend:onInitXML()
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
   self._btnSend1 = set:getClickNode("btnSend1")
   self._btnSend1_icon = set:getElfGrayNode("btnSend1_icon")
   self._btnSend0 = set:getClickNode("btnSend0")
   self._btnSend0_icon = set:getElfGrayNode("btnSend0_icon")
   self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
   self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
--   self._<FULL_NAME1> = set:getElfNode("@pageMain")
--   self._<FULL_NAME1> = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DPlaygroundSend", function ( userData )
	local friends = friendsFunc.getFriendList()
	if friends == nil or #friends == 0 then
		Launcher.callNet(netModel.getModelFriendGetFriend(), function ( data )
			if data and data.D then
				friendsFunc.setFriendList(data.D.Friends)
				Launcher.Launching()
			end
		end)	
	else
		Launcher.Launching()
	end
end)

function DPlaygroundSend:onInit( userData, netData )
	self.SendInfo = userData
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._commonDialog_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self.pageMain = self:createLuaSet("@pageMain")
	self._commonDialog_cnt_bg_page:addChild(self.pageMain[1])
	self:updateLayer()

	res.doActionDialogShow(self._commonDialog)
end

function DPlaygroundSend:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DPlaygroundSend:updateLayer( ... )
	local pageMain = self.pageMain
	local BagInfo = require "BagInfo"
	if not self.FriendList then
		self.FriendList = LuaList.new(pageMain["bg_list"], function ( ... )
			return self:createLuaSet("@item")
		end, function ( nodeLuaSet, nFriend, listIndex )
			res.setNodeWithPet(nodeLuaSet["icon"], gameFunc.getPetInfo().getPetInfoByPetId(nFriend.PetId, nFriend.AwakeIndex))
			nodeLuaSet["layout1_name"]:setString(nFriend.Name)
			nodeLuaSet["layout1_lv"]:setString(string.format("Lv.%d", nFriend.Lv))
			nodeLuaSet["layoutBattleValue_value"]:setString(nFriend.CombatPower)
			
			nodeLuaSet["btnSend1"]:setVisible(#self.SendInfo > 1)
			for i,v in ipairs(self.SendInfo) do
				if v.Mid == 127 then
					nodeLuaSet[string.format("btnSend%d_icon", i-1)]:setResid("JLYLY_baoxiang.png")
				elseif v.Mid == 128 then
					nodeLuaSet[string.format("btnSend%d_icon", i-1)]:setResid("JLYLY_yaoshi.png")
				end
				local canSend = not table.find(v.Sent, nFriend.Fid)
				nodeLuaSet[string.format("btnSend%d_icon", i-1)]:setGrayEnabled(not canSend)
				nodeLuaSet[string.format("btnSend%d", i-1)]:setEnabled(canSend)
				nodeLuaSet[string.format("btnSend%d", i-1)]:setListener(function (  )
					local iCount = BagInfo.getItemCount(v.Mid)
					if iCount > 0 then
						local param = {}
						local dbMaterial = dbManager.getInfoMaterial(v.Mid)
						param.content = string.format(res.locString("Activity$PlaygroundSendTip"), dbMaterial.name)
						param.callback = function ( ... )
							self:send(netModel.getModelPlaygroundSend(v.Idx, nFriend.Fid), function ( data )
								if data and data.D then
									BagInfo.useItem(v.Mid, 1, true)
									
									PlaygroundInfo.setPlayground(data.D.Playground)
									table.insert(self.SendInfo[i].Sent, nFriend.Fid)
									self:updateLayer()
								end
							end)
						end
						GleeCore:showLayer("DConfirmNT",param)
					else
						self:toast(res.locString("Bag$MaterialNotEnough"))
					end
				end)
			end
		end)
	end
	self.FriendList:update(friendsFunc.getFriendList())
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPlaygroundSend, "DPlaygroundSend")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPlaygroundSend", DPlaygroundSend)
