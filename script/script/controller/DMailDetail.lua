local Config = require "Config"
local gameFunc = require "AppData"
local netModel = require "netModel"
local res = require "Res"
local dbManager = require "DBManager"
local timeListManager = require "TimeListManager"

local mailType = {"MailSend", "MailSystem", "MailFriend"}

local DMailDetail = class(LuaDialog)

function DMailDetail:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DMailDetail.cocos.zip")
    return self._factory:createDocument("DMailDetail.cocos")
end

--@@@@[[[[
function DMailDetail:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_btnClose = set:getButtonNode("bg_btnClose")
    self._bg_bg = set:getElfNode("bg_bg")
    self._bg_tabName = set:getLabelNode("bg_tabName")
    self._bg_layoutTime = set:getLinearLayoutNode("bg_layoutTime")
    self._bg_layoutTime_date = set:getLabelNode("bg_layoutTime_date")
    self._bg_layoutTime_clock = set:getLabelNode("bg_layoutTime_clock")
    self._bg_title = set:getLabelNode("bg_title")
    self._bg_text = set:getElfNode("bg_text")
    self._bg_list = set:getListNode("bg_list")
    self._layout = set:getLayoutNode("layout")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._piece = set:getElfNode("piece")
    self._name = set:getLabelNode("name")
    self._count = set:getLabelNode("count")
    self._btn = set:getClickNode("btn")
    self._bg_btnGetReward = set:getClickNode("bg_btnGetReward")
    self._bg_btnGetReward_normal_textBg_text = set:getLabelNode("bg_btnGetReward_normal_textBg_text")
    self._bg_btnGetReward_pressed_textBg_text = set:getLabelNode("bg_btnGetReward_pressed_textBg_text")
    self._bg_btnGetReward_invalid_textBg_text = set:getLabelNode("bg_btnGetReward_invalid_textBg_text")
    self._bg_btnSend = set:getClickNode("bg_btnSend")
    self._bg_btnSend_normal_textBg_text = set:getLabelNode("bg_btnSend_normal_textBg_text")
    self._bg_btnSend_pressed_textBg_text = set:getLabelNode("bg_btnSend_pressed_textBg_text")
    self._bg_btnSend_invalid_textBg_text = set:getLabelNode("bg_btnSend_invalid_textBg_text")
    self._bg_btnResponse = set:getClickNode("bg_btnResponse")
    self._bg_btnResponse_normal_textBg_text = set:getLabelNode("bg_btnResponse_normal_textBg_text")
    self._bg_btnResponse_pressed_textBg_text = set:getLabelNode("bg_btnResponse_pressed_textBg_text")
    self._bg_btnResponse_invalid_textBg_text = set:getLabelNode("bg_btnResponse_invalid_textBg_text")
--    self._@content = set:getRichLabelNode("@content")
--    self._@reward = set:getElfNode("@reward")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DMailDetail:onInit( userData, netData )
	res.doActionDialogShow(self._bg)
	self.mailType = userData.mailType
	self.mailData = userData.mailData
	self.mailTitle = userData.title
	self.mailTitleReal = userData.titleReal
	self.callback = userData.callback
	self.receiveId = userData.receiveId
	self.guildId = userData.guildId

	self:initMailContent()
	self:updateMailType()
	self:setListenerEvent()
end

function DMailDetail:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DMailDetail:initMailContent(  )
	local mailData = self.mailData

	self.inputText = InputTextNode:create(" ", "Helvetica", 24)
	self.inputText:setDimensions(self._bg_text:getContentSize())
	self._bg_text:addChild(self.inputText)
	self.inputText:setLimitNum(420)
	self.inputText:setPlaceHolder(res.locString("Mail$EditMailTip"))
	self.inputText:setColorSpaceHolder(ccc3(212, 181, 144))
	self.inputText:setFontFillColor(ccc3(167, 117, 64), true)
	self.inputText:setPriorityLevel(-99999)

	if self.mailType ~= "MailSend" then
		print("mailData:")
		print(mailData)
		self._bg_list:getContainer():removeAllChildrenWithCleanup(true)
		if mailData.Content then
			local content = self:createLuaSet("@content")
			self._bg_list:getContainer():addChild(content[1])
			content[1]:setString("        " .. mailData.Content)
			content[1]:setFontFillColor(ccc4f(0.384, 0, 1.0, 0.584), true)		-- (g, b, a, r)
		end

		if mailData.Reward then
			local list = res.getRewardResList(mailData.Reward)
			local reward
			for i,v in ipairs(list) do
				if i % 4 == 1 then
					reward = self:createLuaSet("@reward")
					self._bg_list:getContainer():addChild(reward[1])
				end	

				local item = self:createLuaSet("@item")
				reward["layout"]:addChild(item[1])
				item["name"]:setString(v.name)
				
				require "LangAdapter".selectLang(nil,nil,nil,nil,function ( ... )
					item["name"]:setDimensions(CCSize(0,0))
					res.adjustNodeWidth(item["name"], 86)
				end)
				require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
					item["name"]:setVisible(false)
				end)
				item["bg"]:setResid(v.bg)
				item["icon"]:setResid(v.icon)
				local sc = item["icon"]:getScale()
				if v.type == "Pet" or v.type == "PetPiece" then
					item["icon"]:setScale(sc * 140 /95)
				end
				item["frame"]:setResid(v.frame)
				item["piece"]:setVisible(v.isPiece)
				item["count"]:setString(v.count)

				res.addRuneStars( item["frame"], v )
				item["btn"]:setListener(function (  )
					if v.eventData then
						GleeCore:showLayer(v.eventData.dialog, v.eventData.data)
					end
				end)

				if v.type == "Pet" then
					self.rewardPet = true
				elseif v.type == "Equipment" then
					self.rewardEquip = true
				end
			end
		end
	end
end

function DMailDetail:updateMailType(  )
	local mailData = self.mailData
	if self.mailType == "MailSend" then
		self._bg_tabName:setVisible(false)
		self._bg_layoutTime:setVisible(false)

		self._bg_list:setVisible(false)
		self._bg_text:setVisible(true)
		self._bg_btnSend:setVisible(true)
		self._bg_btnGetReward:setVisible(false)
		self._bg_btnResponse:setVisible(false)
		self._bg_title:setString(self.mailTitle)
	else
		self._bg_tabName:setVisible(true)
		if self.mailType == "MailSystem" then
			self._bg_tabName:setString(res.locString("Mail$SystemMailTitle"))
		elseif self.mailType == "MailFriend" then
			self._bg_tabName:setString(res.locString("Mail$PlayerMailTitle"))
		end

		self._bg_title:setString(mailData.Title)
		self._bg_layoutTime:setVisible(true)
		local createTime = os.date("*t", timeListManager.getTimestamp(mailData.CreateAt))
		self._bg_layoutTime_date:setString(string.format("%02d-%02d", createTime.month, createTime.day))
		self._bg_layoutTime_clock:setString(string.format("%02d:%02d", createTime.hour, createTime.min))

		self._bg_list:setVisible(true)
		self._bg_text:setVisible(false)
		self._bg_btnSend:setVisible(false)
		self._bg_btnGetReward:setVisible(mailData.Sid == 0 and mailData.Reward ~= nil)
		self._bg_btnResponse:setVisible(mailData.Sid > 0)
	end
end

function DMailDetail:setListenerEvent(  )
	self._clickBg:setListener(function (  )
		if self.mailType ~= "MailSend" then
			res.doActionDialogHide(self._bg, self)
		end
	end)

	self._bg_btnSend:setListener(function (  )
		local content = self.inputText:getString()
		if content then
			if string.len(content) > 0 then
				if self.guildId then
					self:send(netModel.getModelGuildSendLetter(self.guildId, self.mailTitleReal, content), function ( data )
						print("GuildSendLetter")
						print(data)
						if data and data.D then
							self:toast(res.locString("Mail$SendSuccessTip"))
						end
						res.doActionDialogHide(self._bg, self)
					end )
				else
					self:send(netModel.getModelLetterSend(self.receiveId, self.mailTitleReal, content), function ( data )
						print("LetterSend")
						print(data)
						if data and data.D then
							self:toast(res.locString("Mail$SendSuccessTip"))
						end
						res.doActionDialogHide(self._bg, self)
					end)					
				end
			else
				self:toast(res.locString("Mail$SendEmptyTip"))
			end
		end
	end)

	self._bg_btnGetReward:setListener(function (  )
		local isPetFull = false
		local isEquipFull = false
		if self.rewardPet then
			local petList = gameFunc.getPetInfo().getPetList()
			isPetFull = petList and #petList >= 100
		elseif self.rewardEquip then
			local equipList = gameFunc.getEquipInfo().getEquipList()
			isEquipFull = equipList and #equipList >= 300
		end
		if isPetFull then
			require 'Toolkit'.showDialogOnPetListMax()
			-- local param = {}
			-- param.content = res.locString("Mail$PetIsFull")
			-- param.LeftBtnText = res.locString("Pet$Sacrifice")
			-- param.cancelCallback = function ( ... )

			-- 	GleeCore:showLayer("DPetList", {tab = 3})
			-- end
			-- GleeCore:showLayer("DConfirmNT", param)
		elseif isEquipFull then
			require "Toolkit".showDialogOnEquipListMax()
		else
			self:send(netModel.getModelLetterReceive(self.mailData.Id), function ( data )
				print("LetterReceive")
				print(data)
				if data and data.D then
					if data.D.Resource then
						gameFunc.updateResource(data.D.Resource)
					end
					res.doActionGetReward(data.D.Reward)

					if self.callback then
						self.callback()
					end
					res.doActionDialogHide(self._bg, self)
				end
			end)	
		end
	end)
	
	self._bg_btnResponse:setListener(function (  )
		self.mailType = "MailSend"
		self.receiveId = self.mailData.Sid
		if self.mailData.Title and string.len(self.mailData.Title) > 2 then
			if string.sub(self.mailData.Title, 1, 2) == "Re" then
				self.mailTitle = self.mailData.Title
				self.mailTitleReal = self.mailData.Title
			else
				self.mailTitle = string.format(res.locString("Mail$ReMailFrom"), self.mailData.Sender)
				self.mailTitleReal = string.format(res.locString("Mail$ReMailFrom"), self.mailData.Sender)				
			end
		end
		self:updateMailType()
	end)

	self._bg_btnClose:setTriggleSound(res.Sound.back)
	self._bg_btnClose:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DMailDetail, "DMailDetail")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DMailDetail", DMailDetail)
