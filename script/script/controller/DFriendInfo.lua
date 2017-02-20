local config = require "Config"
local res = require "Res"
local netModel = require "netModel"
local gameFunc = require "AppData"
local dbManager = require "DBManager"
local FriendHelper = require "FriendHelper"
local BlacklistInfo = require "BlacklistInfo"

local DFriendInfo = class(LuaDialog)

function DFriendInfo:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."DFriendInfo.cocos.zip")
    return self._factory:createDocument("DFriendInfo.cocos")
end

--@@@@[[[[
function DFriendInfo:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg1 = set:getElfNode("bg1")
    self._bg1_title = set:getLabelNode("bg1_title")
    self._icon = set:getElfNode("icon")
    self._starLayout = set:getLayoutNode("starLayout")
    self._bg1_layout1_name = set:getLabelNode("bg1_layout1_name")
    self._bg1_layout1_lv = set:getLabelNode("bg1_layout1_lv")
    self._bg1_layoutBattleValue_value = set:getLabelNode("bg1_layoutBattleValue_value")
    self._bg1_btnAddFriend = set:getClickNode("bg1_btnAddFriend")
    self._bg1_btnSendMail = set:getClickNode("bg1_btnSendMail")
    self._bg1_btnShield = set:getClickNode("bg1_btnShield")
    self._bg1_btnClose = set:getButtonNode("bg1_btnClose")
--    self._@pet = set:getElfNode("@pet")
--    self._@star = set:getElfNode("@star")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DFriendInfo", function ( userData )
	if BlacklistInfo.getBlackList() then
		Launcher.Launching()
	else
		Launcher.callNet(netModel.getModelBlackListGet(), function ( data )
			if data and data.D then
				BlacklistInfo.setBlackList(data.D.BlackList)
				Launcher.Launching()
			end
		end)
	end
end)

function DFriendInfo:onInit( userData, netData )
	res.doActionDialogShow(self._bg1)

	self:updateLayer(userData)
end

function DFriendInfo:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DFriendInfo:updateLayer( friendInfo )
	if gameFunc.getFriendsInfo().isMyFriend(friendInfo.Fid) then
		self._bg1_title:setString(res.locString("Friend$InfoTitle"))
	else
		self._bg1_title:setString(res.locString("Global$UserInfoTitle"))
	end
	self._bg1_layout1_name:setString(friendInfo.Name)
	self._bg1_layout1_lv:setString(string.format("Lv.%d", friendInfo.Lv))
	self._bg1_layoutBattleValue_value:setString(friendInfo.CombatPower)

	if not self.petSet then
		self.petSet = self:createLuaSet("@pet")
		self._bg1:addChild(self.petSet[1])
	end

	res.setNodeWithPet(self.petSet["icon"], gameFunc.getPetInfo().getPetInfoByPetId(friendInfo.PetId, friendInfo.AwakeIndex) )
	
	local dbPet = dbManager.getCharactor(friendInfo.PetId)
	-- self.petSet["starLayout"]:removeAllChildrenWithCleanup(true)
	-- for i=1,dbPet.star_level do
	-- 	self.petSet["starLayout"]:addChild(self:createLuaSet("@star")[1])
	-- end
	require 'PetNodeHelper'.updateStarLayout(self.petSet["starLayout"], dbPet)

	self._bg1_btnAddFriend:setEnabled((gameFunc.getUserInfo().getId() ~= friendInfo.Fid) and (not gameFunc.getFriendsInfo().isMyFriend(friendInfo.Fid)))
	self._bg1_btnAddFriend:setListener(function (  )
		FriendHelper.FriendApply(self, friendInfo.Fid, function ( data )
			self._bg1_btnAddFriend:setEnabled(false)
			self:toast(res.locString("Friend$IsSendFriend"))
		end, function ( data )
		--	if data and data.Code == 1001 then
				self._bg1_btnAddFriend:setEnabled(false)
		--	end
		end)
	end)

	self._bg1_btnSendMail:setEnabled( gameFunc.getUserInfo().getId() ~= friendInfo.Fid )
	self._bg1_btnSendMail:setListener(function (  )
		local temp = {}
		temp.mailType = "MailSend"
		temp.receiveId = friendInfo.Fid
		temp.title = string.format(res.locString("Mail$MailTo"), friendInfo.Name)
		temp.titleReal = string.format(res.locString("Mail$MailFrom"), gameFunc.getUserInfo().getName())
		GleeCore:showLayer("DMailDetail", temp)
	end)

	self._bg1_btnShield:setEnabled(not BlacklistInfo.isInBlacklist(friendInfo.Fid))
	self._bg1_btnShield:setListener(function ( ... )
		local limit = dbManager.getInfoDefaultConfig("BlackListLimit").Value
		local blist = BlacklistInfo.getBlackList()
		if #blist < limit then
			local param = {}
			param.content = string.format(res.locString("Blacklist$shieldTip"), friendInfo.Name)
			param.callback = function ( ... )
				self:send(netModel.getModelBlackListUpdate(friendInfo.Fid), function ( data )
					if data and data.D then
						BlacklistInfo.setBlackList(data.D.BlackList)
						res.doActionDialogHide(self._bg1, self)
						require "EventCenter".eventInput("BlackListUpdate")
						self:toast(res.locString("Blacklist$shieldSuc"))
					end
				end)
			end
			GleeCore:showLayer("DConfirmNT", param)
		else
			self:toast(res.locString("Blacklist$shieldTip2"))
		end
	end)

	self._bg1_btnClose:setTriggleSound(res.Sound.back)
	self._bg1_btnClose:setListener(function (  )
		res.doActionDialogHide(self._bg1, self)
	end)

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg1, self)
	end)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DFriendInfo, "DFriendInfo")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DFriendInfo", DFriendInfo)


