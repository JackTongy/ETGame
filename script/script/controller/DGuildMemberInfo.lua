local Config = require "Config"
local res = require "Res"
local netModel = require "netModel"
local gameFunc = require "AppData"
local guildFunc = gameFunc.getGuildInfo()

local DGuildMemberInfo = class(LuaDialog)

function DGuildMemberInfo:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGuildMemberInfo.cocos.zip")
    return self._factory:createDocument("DGuildMemberInfo.cocos")
end

--@@@@[[[[
function DGuildMemberInfo:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_icon = set:getElfNode("bg_icon")
    self._bg_LvBg = set:getElfNode("bg_LvBg")
    self._bg_LvBg_lv = set:getLabelNode("bg_LvBg_lv")
    self._bg_name = set:getLabelNode("bg_name")
    self._bg_battleValue_value = set:getLabelNode("bg_battleValue_value")
    self._bg_contribute_value = set:getLabelNode("bg_contribute_value")
    self._bg_contToday2 = set:getLabelNode("bg_contToday2")
    self._bg_contToday = set:getLinearLayoutNode("bg_contToday")
    self._bg_contToday_value = set:getLabelNode("bg_contToday_value")
    self._bg_btnClose = set:getButtonNode("bg_btnClose")
    self._bg_btnSendMail = set:getClickNode("bg_btnSendMail")
    self._bg_btnRelinquish = set:getClickNode("bg_btnRelinquish")
    self._bg_btnPromote = set:getClickNode("bg_btnPromote")
    self._bg_btnRelieve = set:getClickNode("bg_btnRelieve")
    self._bg_btnFire = set:getClickNode("bg_btnFire")
    self._bg_btnAddFriend = set:getClickNode("bg_btnAddFriend")
    self._bg_btnImpeach = set:getClickNode("bg_btnImpeach")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DGuildMemberInfo:onInit( userData, netData )
	res.doActionDialogShow(self._bg)
	
	self.nGuildMemberDetail = userData
	self:setListenerEvent()
	self:updateLayer()
end

function DGuildMemberInfo:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DGuildMemberInfo:setListenerEvent( ... )
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_btnSendMail:setListener(function ( ... )
		local temp = {}
		temp.mailType = "MailSend"
		temp.receiveId = self.nGuildMemberDetail.Rid
		temp.title = string.format(res.locString("Mail$MailTo"), self.nGuildMemberDetail.Name)
		temp.titleReal = string.format(res.locString("Mail$MailFrom"), gameFunc.getUserInfo().getName())
		GleeCore:showLayer("DMailDetail", temp)
		self:close()
	end)

	self._bg_btnRelinquish:setListener(function ( ... )
		local param = {}
		param.content = string.format(res.locString("Guild$RelinquishTip"), self.nGuildMemberDetail.Name)
		param.callback = function ( ... )
			self:send(netModel.getModelGuildSetPresident(guildFunc.getData().Id, self.nGuildMemberDetail.Rid), function ( data )
				if data and data.D then
					guildFunc.setData(data.D.Guild)
					self:close()
					self:toast(res.locString("Guild$MemberOper1"))
				end
			end)
		end
		GleeCore:showLayer("DConfirmNT", param)
	end)

	self._bg_btnPromote:setListener(function ( ... )
		self:send(netModel.getModelGuildSetVicePresident(guildFunc.getData().Id, self.nGuildMemberDetail.Rid), function ( data )
			if data and data.D then
				guildFunc.setData(data.D.Guild)
				self:close()
				self:toast(res.locString("Guild$MemberOper2"))
			end
		end)
	end)

	self._bg_btnRelieve:setListener(function ( ... )
		self:send(netModel.getModelGuildDelVicePresident(guildFunc.getData().Id, self.nGuildMemberDetail.Rid), function ( data )
			if data and data.D then
				guildFunc.setData(data.D.Guild)
				self:close()
				self:toast(res.locString("Guild$MemberOper3"))
			end
		end)
	end)

	self._bg_btnFire:setListener(function ( ... )
		local param = {}
		param.content = string.format(res.locString("Guild$FireTip"), self.nGuildMemberDetail.Name)
		param.callback = function ( ... )
			self:send(netModel.getModelGuildMemberDel(guildFunc.getData().Id, self.nGuildMemberDetail.Rid), function ( data )
				if data and data.D then
					guildFunc.setData(data.D.Guild)
					require 'EventCenter'.eventInput("GuildFire", {Rid = self.nGuildMemberDetail.Rid})
					self:close()
					self:toast(self.nGuildMemberDetail.Name .. res.locString("Guild$MemberOper4"))
				end
			end, function ( data )
				if data and data.Code == 16009 then -- 公会权限不够
					self:send(netModel.getModelGuildGet(guildFunc.getData().Id), function ( data )
						guildFunc.setData(data.D.Guild)
						guildFunc.setPresidentLastLoginAt(data.D.PresidentLastLoginAt)
						guildFunc.setElectionState(data.D.ElectionState)
						self:close()
					end)
				end
			end)
		end
		GleeCore:showLayer("DConfirmNT", param)
	end)

	self._bg_btnAddFriend:setEnabled(not gameFunc.getFriendsInfo().isMyFriend(self.nGuildMemberDetail.Rid))
	self._bg_btnAddFriend:setListener(function ( ... )
		require "FriendHelper".FriendApply(self, self.nGuildMemberDetail.Rid, function ( data )
			self._bg_btnAddFriend:setEnabled(false)
			self:toast(res.locString("Friend$IsSendFriend"))
		end, function ( data )
			self._bg_btnAddFriend:setEnabled(false)
		end)
	end)

	self._bg_btnImpeach:setListener(function ( ... )
		GleeCore:showLayer("DGuildImpeach")
	end)
end

function DGuildMemberInfo:updateLayer(  )
	local nGuildMemberDetail = self.nGuildMemberDetail

	local nPet = gameFunc.getPetInfo().getPetInfoByPetId( nGuildMemberDetail.PetId, nGuildMemberDetail.AwakeIndex )
	res.setNodeWithPet(self._bg_icon, nPet)
	
	self._bg_LvBg:setResid(string.format("N_JJC_%d.png", res.getFinalAwake(nGuildMemberDetail.AwakeIndex)))
	self._bg_LvBg_lv:setString(nGuildMemberDetail.Lv)
	self._bg_name:setString(nGuildMemberDetail.Name)
	self._bg_battleValue_value:setString(nGuildMemberDetail.CombatPower)
	self._bg_contribute_value:setString(nGuildMemberDetail.TotalPoint)

	if nGuildMemberDetail.DonateDays == 0 then
		self._bg_contToday:setVisible(true)
		self._bg_contToday2:setVisible(false)
		self._bg_contToday_value:setString(nGuildMemberDetail.TodayPoint)
	elseif nGuildMemberDetail.DonateDays == 1 then
		self._bg_contToday:setVisible(false)
		self._bg_contToday2:setVisible(true)
		self._bg_contToday2:setString(res.locString("Guild$ContributeTip0"))
	elseif nGuildMemberDetail.DonateDays >= 2 then
		self._bg_contToday:setVisible(false)
		self._bg_contToday2:setVisible(true)
		self._bg_contToday2:setString(string.format(res.locString("Guild$ContributeTip1"), nGuildMemberDetail.DonateDays ))
	end

	require "LangAdapter".LabelNodeAutoShrink( self._bg_contToday2, 340 )

	local iUserId = gameFunc.getUserInfo().getId()
	if nGuildMemberDetail.Rid == iUserId then
		self._bg_btnSendMail:setVisible(false)
		self._bg_btnRelinquish:setVisible(false)
		self._bg_btnPromote:setVisible(false)
		self._bg_btnRelieve:setVisible(false)
		self._bg_btnFire:setVisible(false)
		self._bg_btnAddFriend:setVisible(false)
		self._bg_btnImpeach:setVisible(false)
	else
		if guildFunc.isPresident(iUserId) then
			self._bg_btnSendMail:setVisible(true)
			self._bg_btnRelinquish:setVisible(true)
			local isVicePresident = guildFunc.isVicePresident(nGuildMemberDetail.Rid)
			self._bg_btnPromote:setVisible(not isVicePresident)
			self._bg_btnRelieve:setVisible(isVicePresident)
			self._bg_btnFire:setVisible(true)
			self._bg_btnAddFriend:setVisible(true)
			self._bg_btnImpeach:setVisible(false)

			self._bg_btnSendMail:setPosition(ccp(-167.14285,-48.57143))
			self._bg_btnRelinquish:setPosition(ccp(-167.14285,-118.571434))
			self._bg_btnPromote:setPosition(ccp(185.7143,-48.57143))
			self._bg_btnRelieve:setPosition(ccp(185.7143,-48.57143))
			self._bg_btnFire:setPosition(ccp(10.0,-118.571434))
			self._bg_btnAddFriend:setPosition(ccp(10.0,-48.57143))
		elseif guildFunc.isVicePresident(iUserId) then
			self._bg_btnSendMail:setVisible(true)
			self._bg_btnRelinquish:setVisible(false)
			self._bg_btnPromote:setVisible(false)
			self._bg_btnRelieve:setVisible(false)
			self._bg_btnAddFriend:setVisible(true)
			local isPresidentOrVice = guildFunc.isPresident(nGuildMemberDetail.Rid) or guildFunc.isVicePresident(nGuildMemberDetail.Rid)
			self._bg_btnFire:setVisible(not isPresidentOrVice)
		
			local canImpeach = guildFunc.isPresident(nGuildMemberDetail.Rid) and self:canImpeach()
			self._bg_btnImpeach:setVisible(canImpeach)

			if canImpeach then
				self._bg_btnSendMail:setPosition(ccp(-167.14285,-84.28571))
				self._bg_btnAddFriend:setPosition(ccp(10.0,-84.28571))
				self._bg_btnImpeach:setPosition(ccp(185.7143,-84.28571))
			else
				if isPresidentOrVice then
					self._bg_btnSendMail:setPosition(ccp(-114.28571,-84.28571))
					self._bg_btnAddFriend:setPosition(ccp(124.28571,-84.28571))
				else
					self._bg_btnSendMail:setPosition(ccp(-167.14285,-84.28571))
					self._bg_btnAddFriend:setPosition(ccp(10.0,-84.28571))
					self._bg_btnFire:setPosition(ccp(185.7143,-84.28571))
				end		
			end
		else
			self._bg_btnSendMail:setVisible(true)
			self._bg_btnRelinquish:setVisible(false)
			self._bg_btnPromote:setVisible(false)
			self._bg_btnRelieve:setVisible(false)
			self._bg_btnFire:setVisible(false)
			self._bg_btnAddFriend:setVisible(true)
			local canImpeach = guildFunc.isPresident(nGuildMemberDetail.Rid) and self:canImpeach()
			self._bg_btnImpeach:setVisible( canImpeach )

			if canImpeach then
				self._bg_btnSendMail:setPosition(ccp(-167.14285,-84.28571))
				self._bg_btnAddFriend:setPosition(ccp(10.0,-84.28571))
				self._bg_btnImpeach:setPosition(ccp(187.14287,-84.28571))
			else
				self._bg_btnSendMail:setPosition(ccp(-114.28571,-84.28571))
				self._bg_btnAddFriend:setPosition(ccp(124.28571,-84.28571))
			end
		end
	end
end

function DGuildMemberInfo:canImpeach( ... )
	local seconds = math.floor(require "TimeListManager".getTimeUpToNow(guildFunc.getPresidentLastLoginAt()))
	print("seconds = " .. seconds)
	return seconds >= 3600 * 24 * 7
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGuildMemberInfo, "DGuildMemberInfo")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGuildMemberInfo", DGuildMemberInfo)
