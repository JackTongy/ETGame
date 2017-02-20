local Config = require "Config"
local netModel = require "netModel"
local eventCenter = require 'EventCenter'
local chatFunc = require "ChatInfo"
local res = require "Res"
local userFunc = require "UserInfo"
local BlacklistInfo = require "BlacklistInfo"

local DChat = class(LuaDialog)

local ColorConfig = {
	vip 		= {name = ccc4f(1,0.36,0.14,1),content = ccc4f(0.36,0.14,1,1)},--1,0.36,0.14,1)
	com 		= {name = ccc4f(0.96,0.99,1,1),content = ccc4f(0.99,1,1,0.96)},--0.96,0.99,1,1
	sys 		= {name = ccc4f(0.19,0.76,1,1),content = ccc4f(0.76,1,1,0.19)},--0.19,0.76,1,1
	notify 	= {name = ccc4f(0.97,0.6,0.08,1),content = ccc4f(0.6,0.08,1,0.97)}--0.97,0.6,0.08,1
}

local ChatType = {World = 1,Frient = 2,Club = 3,Notify = 4}

local notifyPrice = 15

function DChat:createDocument()
	self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DChat.cocos.zip")
	return self._factory:createDocument("DChat.cocos")
end

--@@@@[[[[
function DChat:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._fp_bg_list = set:getListNode("fp_bg_list")
    self._top = set:getElfNode("top")
    self._top_topLayout = set:getLinearLayoutNode("top_topLayout")
    self._top_topLayout_userName = set:getLabelNode("top_topLayout_userName")
    self._top_topLayout_userLevel = set:getLabelNode("top_topLayout_userLevel")
    self._top_topLayout_vipLogo = set:getElfNode("top_topLayout_vipLogo")
    self._top_time = set:getLabelNode("top_time")
    self._content = set:getRichLabelNode("content")
    self._contentBtn = set:getButtonNode("contentBtn")
    self._headIcon = set:getElfNode("headIcon")
    self._headBtn = set:getButtonNode("headBtn")
    self._bg = set:getElfNode("bg")
    self._fp_bg_sysList = set:getListNode("fp_bg_sysList")
    self._fp_bg_clubChatlist = set:getListNode("fp_bg_clubChatlist")
    self._fp_bg_notifyList = set:getListNode("fp_bg_notifyList")
    self._fp_bg_chatBar = set:getElfNode("fp_bg_chatBar")
    self._fp_bg_chatBar_sendBtn = set:getClickNode("fp_bg_chatBar_sendBtn")
    self._fp_bg_chatBar_inputBg_input = set:getInputTextNode("fp_bg_chatBar_inputBg_input")
    self._fp_bg_closeBtn = set:getButtonNode("fp_bg_closeBtn")
    self._fp_bg_notifyBar = set:getElfNode("fp_bg_notifyBar")
    self._fp_bg_notifyBar_sendBtn = set:getClickNode("fp_bg_notifyBar_sendBtn")
    self._fp_bg_notifyBar_inputBg_input = set:getInputTextNode("fp_bg_notifyBar_inputBg_input")
    self._fp_bg_notifyBar_free = set:getLabelNode("fp_bg_notifyBar_free")
    self._fp_bg_notifyBar_notfree = set:getElfNode("fp_bg_notifyBar_notfree")
    self._fp_bg_notifyBar_notfree_price = set:getLabelNode("fp_bg_notifyBar_notfree_price")
    self._fp_bg_tabSys = set:getTabNode("fp_bg_tabSys")
    self._fp_bg_tabChat = set:getTabNode("fp_bg_tabChat")
    self._fp_bg_tabNotify = set:getTabNode("fp_bg_tabNotify")
    self._fp_bg_tabClub = set:getTabNode("fp_bg_tabClub")
    self._fp_bg_btnBlackList = set:getButtonNode("fp_bg_btnBlackList")
    self._fp_bg_christmas1 = set:getElfNode("fp_bg_christmas1")
    self._fp_bg_christmas2 = set:getElfNode("fp_bg_christmas2")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DChat", function ( userData )
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


function DChat:onInit( userData, netData )
	self._fp_bg_christmas1:setVisible(not require 'AccountHelper'.isItemOFF('Spring'))
	self._fp_bg_christmas2:setVisible(not require 'AccountHelper'.isItemOFF('Spring'))

	local input = self._fp_bg_chatBar_inputBg_input:getInputTextNode()
	input:setFontName("wenzi.ttf")
	input:setFontSize(24)
	input:setFontFillColor(ccc4f(0.6,0.44,0.23,1),true)
	self._fp_bg_chatBar_inputBg_input:setFontColor(ccc4f(0.6,0.44,0.23,1))
	-- input:enableStroke(ccc4f(0,0,0,0.5),2,true)

	input = self._fp_bg_notifyBar_inputBg_input:getInputTextNode()
	input:setFontName("wenzi.ttf")
	input:setFontSize(24)
	input:setFontFillColor(ccc4f(0.6,0.44,0.23,1),true)
	self._fp_bg_notifyBar_inputBg_input:setFontColor(ccc4f(0.6,0.44,0.23,1))
	self._fp_bg_notifyBar_inputBg_input:setPlaceHolder(res.locString("DChat$inputPlaceHolder"))
	
	self._clickBg:setListener(function ( ... )
		self:close()
	end)

	self:updateOnLock()

	self.mChatListCtrl = chatFunc.createChatListController(self._fp_bg_list,function ( info )
		return self:createListItem(info)
	end)

	self.mSysListCtrl = chatFunc.createChatListController(self._fp_bg_sysList,function ( info )
		return self:createListItem(info)
	end)

	self.mNotifyListCtrl = chatFunc.createChatListController(self._fp_bg_notifyList,function ( info )
		return self:createListItem(info)
	end)

	self.mClubChatListCtrl = chatFunc.createChatListController(self._fp_bg_clubChatlist,function ( info )
		return self:createListItem(info)
	end)

	self.isNotificationSynchronized = false
	self.isClubChatInfoSynchronized = false
	self.mSyncHandlers = {}
	self.mChatType = ChatType.World

	self.close = function ( ... )
		print("onClose-----------")
		self:stopSync()
		self.mChatListCtrl.cancel()
		self.mSysListCtrl.cancel()
		self.mNotifyListCtrl.cancel()
		self.mClubChatListCtrl.cancel()
		eventCenter.resetGroup("DChat")
		-- GleeControllerManager:getInstance():releaseUnusedTextureNF()
	end

	self:initChatData(function (  )
		self:updateView()
	end)

	self:addBtnListener()
	self._fp_bg_tabChat:trigger(nil)

	require 'GuideHelper':check('DChat')

	eventCenter.addEventFunc("NewChatGet", function ( data )
		self:onNewChatGet(data)
	end, "DChat")

	eventCenter.addEventFunc("BlackListUpdate", function ( data )
		self:updateView()
	end, "DChat")

	if not require "UnlockManager":isOpen("GuildChat") then
		self._fp_bg_tabClub:setVisible(false)
		self._fp_bg_tabNotify:setPosition(self._fp_bg_tabClub:getPosition())
	end
end

function DChat:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function DChat:initChatData( callback )
	if chatFunc.getChatInfoCount(self.mChatType)<30 then
		self:send(netModel.getmodelChatGet(self.mChatType,0),function ( data )
			print(data)
			if data.D.Chats and #data.D.Chats>0 then
				chatFunc.setChatData(data.D.Chats,self.mChatType)
			end
			if callback then
				callback()
			end
		end)
	else
		self:send(netModel.getmodelChatGet(self.mChatType,chatFunc.getLastChatInfo(self.mChatType).Id),function ( data )
			print(data)
			if data.D.Chats and #data.D.Chats>0 then
				local chats = data.D.Chats
				table.sort(chats,function ( a,b )
					return a.Id<b.Id
				end)
				for i,v in ipairs(chats) do
					chatFunc.addChatInfo(v,self.mChatType)
				end
			end
			if callback then
				callback()
			end
		end)
	end
end

function DChat:addBtnListener( ... )
	self._fp_bg_tabChat:setListener(function ( ... )
		self.mChatType = ChatType.World
		self:startSyncChatInfo(self.mChatType,10)
		self._fp_bg_chatBar:setVisible(true)
		self._fp_bg_notifyBar:setVisible(false)
		self._fp_bg_notifyBar_inputBg_input:setText("")
		self._fp_bg_chatBar_inputBg_input:setText("")
		self.mChatListCtrl.setVisible(true)
		self.mSysListCtrl.setVisible(false)
		self.mNotifyListCtrl.setVisible(false)
		self.mClubChatListCtrl.setVisible(false)
	end)

	self._fp_bg_tabSys:setListener(function ( ... )
		self.mChatType = ChatType.World
		self:startSyncChatInfo(self.mChatType,10)
		self._fp_bg_chatBar:setVisible(true)
		self._fp_bg_notifyBar:setVisible(false)
		self._fp_bg_notifyBar_inputBg_input:setText("")
		self._fp_bg_chatBar_inputBg_input:setText("")
		self.mChatListCtrl.setVisible(false)
		self.mSysListCtrl.setVisible(true)
		self.mNotifyListCtrl.setVisible(false)
		self.mClubChatListCtrl.setVisible(false)
	end)

	self._fp_bg_tabNotify:setListener(function ( ... )
		self.mChatType = ChatType.Notify
		self._fp_bg_chatBar:setVisible(false)
		self._fp_bg_notifyBar:setVisible(true)
		self._fp_bg_notifyBar_inputBg_input:setText("")
		self._fp_bg_chatBar_inputBg_input:setText("")

		if not self.isNotificationSynchronized then
			self:send(netModel.getmodelChatGet(1,0,true),function ( data )
				print(data)
				local chats = data.D.Chats
				table.sort(chats,function ( a,b )
					return a.Id<b.Id
				end)
				for i,v in ipairs(chats) do
					if chatFunc.addChatInfo(v) then
						if self:canShowInSysList(v) then
							self.mSysListCtrl.addChat(v)
						end
						if self:canShowInChatList(v) then
							self.mChatListCtrl.addChat(v)
						end
					end
				end
				self.mNotifyListCtrl.initWithList(chats)
				self.isNotificationSynchronized = true
				self.mChatListCtrl.setVisible(false)
				self.mSysListCtrl.setVisible(false)
				self.mNotifyListCtrl.setVisible(true)
				self.mClubChatListCtrl.setVisible(false)
			end)
		else
			self.mChatListCtrl.setVisible(false)
			self.mSysListCtrl.setVisible(false)
			self.mNotifyListCtrl.setVisible(true)
			self.mClubChatListCtrl.setVisible(false)
		end
	end)

	self._fp_bg_tabClub:setListener(function ( ... )
		self.mChatType = ChatType.Club
		
		self._fp_bg_chatBar:setVisible(true)
		self._fp_bg_notifyBar:setVisible(false)
		self._fp_bg_notifyBar_inputBg_input:setText("")
		self._fp_bg_chatBar_inputBg_input:setText("")
		self.mChatListCtrl.setVisible(false)
		self.mSysListCtrl.setVisible(false)
		self.mNotifyListCtrl.setVisible(false)
		self.mClubChatListCtrl.setVisible(true)
		if self:checkInGuild() then
			if not self.isClubChatInfoSynchronized then
				self:initChatData(function (  )
					self:startSyncChatInfo(self.mChatType,10)
					local chatList = chatFunc.getChatData(self.mChatType)
					self.mClubChatListCtrl.initWithList(chatList)
				end)
				self.isClubChatInfoSynchronized = true
			end
		else
			self:stopSync(ChatType.Club)
		end
	end)


	self._fp_bg_chatBar_sendBtn:setListener(function ( ... )
		if self.mChatType == ChatType.Club and not self:checkInGuild() then
			return
		end

		local content = self._fp_bg_chatBar_inputBg_input:getText()
		if content and string.len(content)>0 and content~= self._fp_bg_chatBar_inputBg_input:getPlaceHolder() then
			print(content)
			content = string.gsub(content,"[/%[%]]","")
			return self:send(netModel.getmodelChatSend(self.mChatType,content,"",0,0),function ( data )
				print(data)
				self._fp_bg_chatBar_inputBg_input:setText("")
				local chats = data.D.Chats
				table.sort(chats,function ( a,b )
					return a.Id<b.Id
				end)

				if self.mChatType == ChatType.World then
					for i,v in ipairs(chats) do
						eventCenter.eventInput("NewChatGet",v)
					end
				elseif self.mChatType == ChatType.Club then
					for i,v in ipairs(chats) do
						self:onNewClubChatGet(v)
					end
				end
			end)
		else
			return self:toast(res.locString("Chat$ChatInputTip"))
		end
	end)

	self._fp_bg_notifyBar_sendBtn:setListener(function ( ... )
		local user = require "UserInfo"
		if not self.mNotifyFree and user.getCoin()<notifyPrice then
			require "Toolkit".showDialogOnCoinNotEnough()
		else
			local func = function (  )
				local content = self._fp_bg_notifyBar_inputBg_input:getText()
				if content and string.len(content)>0 and content~= self._fp_bg_notifyBar_inputBg_input:getPlaceHolder() then
					print(content)
					content = string.gsub(content,"[/%[%]]","")
					return self:send(netModel.getmodelChatSend(1,content,"",0,0,true),function ( data )
						print(data)
						self._fp_bg_notifyBar_inputBg_input:setText("")
						local chats = data.D.Chats
						table.sort(chats,function ( a,b )
							return a.Id<b.Id
						end)
						for i,v in ipairs(chats) do
							eventCenter.eventInput("NewChatGet",v)
						end
						if data.D.Role then
							require "UserInfo".setData(data.D.Role)
							self:updateNotifyFreeCount()
						end
						return self:close()
					end)
				else
					return self:toast(res.locString("Chat$ChatInputTip"))
				end
			end
			if self.mNotifyFree then
				func()
			else
				if require 'Config'.LangName == 'kor' then
					GleeCore:showLayer('DConfirmNT',{content="15정력석이 소모됩니다. 전송 하시겠습니까? ",callback=func})
				else
					func()
				end
			end
		end
	end)

	self._fp_bg_closeBtn:setListener(function ( ... )
		self:close()
	end)

	self._fp_bg_btnBlackList:setListener(function ( ... )
		GleeCore:showLayer("DChatBlacklist")
	end)
end

function DChat:updateOnLock( ... )
	local unlock = require "UnlockManager":isUnlock("Chat")
	if not unlock then
		self._fp_bg_chatBar_inputBg_input:setEnabled(false)
		self._fp_bg_chatBar_sendBtn:setEnabled(false)
		self._fp_bg_notifyBar_inputBg_input:setEnabled(false)
		self._fp_bg_notifyBar_sendBtn:setEnabled(false)
		self.mPlaceHolderStr = string.format(res.locString("Chat$LockTip"),require "UnlockManager":getUnlockLv("Chat"))
	else
		self.mPlaceHolderStr = res.locString("Chat$ChatInputTip").."..."
	end
end

function DChat:startSyncChatInfo( chatType,interval )
	if self.mSyncHandlers[chatType] then
		return
	end
	local get = true
	self.mSyncHandlers[chatType] =  require "framework.sync.TimerHelper".tick(function ( ... )
		if get then
			local lastchat = chatFunc.getLastChatInfo(chatType)
			local lastID = lastchat and lastchat.Id or 0
			self:sendBackground(netModel.getmodelChatGet(chatType,lastID),function ( data )
				local chats = data.D.Chats
				if chats and type(chats)=="table" and #chats>0 then
					table.sort(chats,function ( a,b )
						return a.Id<b.Id
					end)
					if chatType == ChatType.World then
						for i,v in ipairs(chats) do
							eventCenter.eventInput("NewChatGet",v)
							-- self:onNewChatGet(v)
						end
					elseif chatType == ChatType.Club then
						for i,v in ipairs(chats) do
							self:onNewClubChatGet(v)
						end
					end
				end
				get = true
			end,function (  )
				get = true
			end)
			get = false
		end
	end,interval)
end

function DChat:stopSync( chatType )
	if not chatType then
		for _,v in pairs(self.mSyncHandlers) do
			require "framework.sync.TimerHelper".cancel(v)
		end
	else
		local h = self.mSyncHandlers[chatType]
		if h then
			require "framework.sync.TimerHelper".cancel(h)
		end
	end
end

function DChat:onNewChatGet( data )
	print("NewChatGet")
	print(data)
	if chatFunc.addChatInfo(data,ChatType.World) then
	-- eventCenter.eventInput("NewChatGet", data)
		print("---------OnNewChatGet-----------")
		if self:canShowInChatList(data) then
			self.mChatListCtrl.addChat(data)
		end
		if self:canShowInSysList(data) then
			self.mSysListCtrl.addChat(data)
		end
		if data.Broadcast then
			self.mNotifyListCtrl.addChat(data)
		end
	end
end

function DChat:onNewClubChatGet( data )
	print("NewClubChatGet")
	print(data)
	if chatFunc.addChatInfo(data,ChatType.Club) then
	-- eventCenter.eventInput("NewChatGet", data)
		print("---------OnNewChatGet-----------")
		self.mClubChatListCtrl.addChat(data)
	end
end

function DChat:isShenshouhecheng( data )
	if data.Rid == 0 and data.ShareType == 1 and data.Broadcast == true then
		if data.SharePet.Star>5 then
			return true
		else
			return require "DBManager".getCharactor(data.SharePet.PetId).quality>15
		end
	else
		return false
	end
end

function DChat:canShowInSysList( data )
	return data.Rid == 0
end

function DChat:canShowInChatList( data )
	return ( data.Rid~=0 or self:isShenshouhecheng(data) ) and not BlacklistInfo.isInBlacklist(data.Rid)
end

function DChat:updateView( ... )
	self._fp_bg_notifyBar_notfree_price:setString(notifyPrice)
	self._fp_bg_chatBar_inputBg_input:setPlaceHolder(self.mPlaceHolderStr)
	self._fp_bg_notifyBar_inputBg_input:setPlaceHolder(self.mPlaceHolderStr)

	local chatList = chatFunc.getChatData()
	
	local sys,chat = {},{}
	for _,v in ipairs(chatList) do
		if self:canShowInChatList(v) then
			chat[#chat+1] = v
		end
		if self:canShowInSysList(v) then
			sys[#sys+1] = v
		end
	end
	self.mChatListCtrl.cancel()
	self.mChatListCtrl.initWithList(chat)
	self.mSysListCtrl.initWithList(sys)

	self:updateNotifyFreeCount()
end

function DChat:updateNotifyFreeCount(  )
	local allCount = require "DBManager".getVipInfo(userFunc.getVipLevel()).Broadcast or 0
	local usedCount = userFunc.getData().TodayBroadcast or 0
	self.mNotifyFree = allCount>0 and usedCount<allCount
	self._fp_bg_notifyBar_free:setVisible(self.mNotifyFree)
	self._fp_bg_notifyBar_notfree:setVisible(not self.mNotifyFree)
end

function DChat:createListItem( info )
	local set = self:createLuaSet("@item")
	-- set["bg"]:setVisible(zOrder%2==0)

	if info.Rid == 0 then--from sys
		set["headIcon"]:setResid("N_LT_gonggao.png")
		set["headIcon"]:setScale(0.7)
		set["top_topLayout_userName"]:setString(res.locString("Chat$SystemSend"))
		set["top_topLayout_userLevel"]:setString("")
		set["top_topLayout_vipLogo"]:setResid(nil)
		set["top_time"]:setFontFillColor(ColorConfig.sys.name,true)
		set["top_topLayout_userName"]:setFontFillColor(ColorConfig.sys.name,true)
		set["content"]:setFontFillColor(ColorConfig.sys.content,true)
	else
		res.setPetDetail(set["headIcon"],require "PetInfo".getPetInfoByPetId(info.PetId,info.AwakeIndex))
		set["top_topLayout_userName"]:setString(info.Name)
		set["top_topLayout_userLevel"]:setString(string.format("  Lv.%d  ",info.Lv))
		if info.Vip>0 and not require 'AccountHelper'.isItemOFF('Vip') then
			set["top_topLayout_vipLogo"]:setResid(string.format("chat_vip%d.png",info.Vip>=6 and 2 or 1))
		else
			set["top_topLayout_vipLogo"]:setResid(nil)
		end
		local color = info.Broadcast and ColorConfig.notify or (info.Vip>0 and ColorConfig.vip or ColorConfig.com)
		set["top_time"]:setFontFillColor(color.name,true)
		set["top_topLayout_userName"]:setFontFillColor(color.name,true)
		set["top_topLayout_userLevel"]:setFontFillColor(color.name,true)
		set["content"]:setFontFillColor(color.content,true)
		if info.Rid~=userFunc.getId() then
			set["headBtn"]:setListener(function ( ... )
				self:send(netModel.getModelFriendGet(info.Rid), function ( data )
					print(data)
					if data.D and data.D.Friend then
						return GleeCore:showLayer("DFriendInfo", data.D.Friend)
					else
						return self:toast(res.locString("DChat$noUserFindTip"))
					end
				end)
			end)
		end
	end
	set["top_time"]:setString(self:getFormatTimeString(info.SendAt))

	set["content"]:setString(info.Content)

	local contentSize = set["content"]:getContentSize()
	local marginTop,marginBot = 20,20
	local h,x,y
	if contentSize.height>30 then
		local marginTop,marginBot = 20,20
		h = contentSize.height+30+marginTop+marginBot
		set[1]:setContentSize(CCSize(set[1]:getContentSize().width,h))
		-- set["bg"]:setContentSize(CCSize(set["bg"]:getContentSize().width,h+20))
		x,y = set["headIcon"]:getPosition()
		set["headIcon"]:setPosition(x,h/2 - marginTop-10)
		set["headBtn"]:setPosition(set["headIcon"]:getPosition())
		x,y = set["content"]:getPosition()
		set["content"]:setPosition(x,-h/2+marginBot+contentSize.height-4)
		x,y = set["content"]:getPosition()
		local x2,y2 = set["top"]:getPosition()
		set["top"]:setPosition(x2,y-20)
	else
		local h = 71.5+marginTop+marginBot
		set[1]:setContentSize(CCSize(set[1]:getContentSize().width,h))
		-- set["bg"]:setContentSize(CCSize(set["bg"]:getContentSize().width,h+20))
		local x,y = set["headIcon"]:getPosition()
		set["headIcon"]:setPosition(x,h/2 - marginTop - 6)
		set["headBtn"]:setPosition(set["headIcon"]:getPosition())
		x,y = set["top"]:getPosition()
		set["top"]:setPosition(x,h/2 - marginTop - 65)
		x,y = set["content"]:getPosition()
		set["content"]:setPosition(x,0-10)
	end
	if info.Rid == 0 then
		local x,y = set["headIcon"]:getPosition()
		set["headIcon"]:setPosition(x,y+6)
	end
	set["bg"]:setPosition(0,-set[1]:getContentSize().height/2)

	if info.ShareType>0 then
		set["contentBtn"]:setContentSize(CCSize(contentSize.width,contentSize.height))
		set["contentBtn"]:setPosition(set["content"]:getPosition())
		set["contentBtn"]:setListener(function ( ... )
			if info.ShareType == 1 then
				GleeCore:showLayer("DPetDetailV",{PetInfo = info.SharePet})
			elseif info.ShareType == 2 then
				-- if not info.ShareGem or #info.ShareGem<=0 then
					-- GleeCore:showLayer("DEquipInfoWithNoGem",{EquipInfo = info.ShareEquip})
					GleeCore:showLayer("DEquipDetail",{nEquip = info.ShareEquip})
				-- else
				-- 	GleeCore:showLayer("DEquipInfo",{EquipInfo = info.ShareEquip,Gems = info.ShareGem})
				-- end
			elseif info.ShareType == 3 then
				GleeCore:showLayer("DGemDetail",{GemInfo = info.ShareGem[1],ShowOnly = true,EquipInfo = info.ShareEquip})
			end
		end)
	end

	return set[1]
end

local offsetTime = os.time() - os.time(os.date("!*t"))
function DChat:checkInGuild( )
	if require "GuildInfo".isInGuild() then
		return true
	else
		self:toast(res.locString("Chat$ChatGuildLimitTip"))
		return false
	end
end

function DChat:getFormatTimeString( time )
	local timestamp = require 'TimeManager'.getTimestamp(time)
  	local ldt = os.date('*t',timestamp)
	if require 'Config'.LangName ~= "kor" or self.mChatType ~= ChatType.Club then
		return string.format("%02d:%02d",ldt.hour,ldt.min)
	else
	  	return string.format("%02d/%02d %02d:%02d",ldt.month,ldt.day,ldt.hour,ldt.min)
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DChat, "DChat")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DChat", DChat)


