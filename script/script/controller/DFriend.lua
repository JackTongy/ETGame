local Config = require "Config"
local gameFunc = require "AppData"
local friendsFunc = gameFunc.getFriendsInfo()
local LuaList = require "LuaList"
local netModel = require "netModel"
local res = require "Res"
local dbManager = require "DBManager"
local eventCenter = require 'EventCenter'
local broadCastFunc = gameFunc.getBroadCastInfo()
local userFunc = gameFunc.getUserInfo()
local FriendHelper = require "FriendHelper"

local DFriend = class(LuaDialog)

function DFriend:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DFriend.cocos.zip")
    return self._factory:createDocument("DFriend.cocos")
end

--@@@@[[[[
function DFriend:onInitXML()
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
    self._btnSendAP = set:getClickNode("btnSendAP")
    self._btnSendAP_text = set:getLabelNode("btnSendAP_text")
    self._btnReceiveAP = set:getClickNode("btnReceiveAP")
    self._btnReceiveAP_text = set:getLabelNode("btnReceiveAP_text")
    self._layoutAPReceived = set:getLinearLayoutNode("layoutAPReceived")
    self._layoutAPReceived_value = set:getLabelNode("layoutAPReceived_value")
    self._btnSendAll = set:getClickNode("btnSendAll")
    self._btnReceiveAll = set:getClickNode("btnReceiveAll")
    self._noTip = set:getLabelNode("noTip")
    self._bg = set:getElfNode("bg")
    self._bg_list = set:getListNode("bg_list")
    self._bg2 = set:getElfNode("bg2")
    self._icon = set:getElfNode("icon")
    self._layout1 = set:getLinearLayoutNode("layout1")
    self._layout1_name = set:getLabelNode("layout1_name")
    self._layout1_lv = set:getLabelNode("layout1_lv")
    self._timer = set:getLabelNode("timer")
    self._des = set:getLabelNode("des")
    self._btnRefuse = set:getClickNode("btnRefuse")
    self._btnAgree = set:getClickNode("btnAgree")
    self._layoutFriendsCount = set:getLinearLayoutNode("layoutFriendsCount")
    self._layoutFriendsCount_value = set:getLabelNode("layoutFriendsCount_value")
    self._noTip = set:getLabelNode("noTip")
    self._bg = set:getElfNode("bg")
    self._bg_list = set:getListNode("bg_list")
    self._bg2 = set:getElfNode("bg2")
    self._icon = set:getElfNode("icon")
    self._btn = set:getButtonNode("btn")
    self._count = set:getLabelNode("count")
    self._title = set:getLabelNode("title")
    self._layoutReceiveRequest = set:getLinearLayoutNode("layoutReceiveRequest")
    self._layoutReceiveRequest_value = set:getLabelNode("layoutReceiveRequest_value")
    self._layoutPresentContent = set:getLinearLayoutNode("layoutPresentContent")
    self._layoutPresentContent_value = set:getLabelNode("layoutPresentContent_value")
    self._layoutProgress_value = set:getLabelNode("layoutProgress_value")
    self._btnReceive = set:getClickNode("btnReceive")
    self._btnReceive_text = set:getLabelNode("btnReceive_text")
    self._bg2 = set:getElfNode("bg2")
    self._icon = set:getElfNode("icon")
    self._btn = set:getButtonNode("btn")
    self._title = set:getLabelNode("title")
    self._content = set:getLabelNode("content")
    self._btnExchange = set:getClickNode("btnExchange")
    self._myInviteNumberTitle = set:getLabelNode("myInviteNumberTitle")
    self._inviteNumberBg = set:getElfNode("inviteNumberBg")
    self._inviteNumberBg_input = set:getLabelNode("inviteNumberBg_input")
    self._btnShare = set:getButtonNode("btnShare")
    self._layoutMyCode = set:getLinearLayoutNode("layoutMyCode")
    self._layoutMyCode_myInviteNumberTitle = set:getLabelNode("layoutMyCode_myInviteNumberTitle")
    self._layoutMyCode_e1 = set:getElfNode("layoutMyCode_e1")
    self._layoutMyCode_inviteNumberBg = set:getElfNode("layoutMyCode_inviteNumberBg")
    self._layoutMyCode_inviteNumberBg_input = set:getLabelNode("layoutMyCode_inviteNumberBg_input")
    self._layoutMyCode_e2 = set:getElfNode("layoutMyCode_e2")
    self._layoutMyCode_btnShare = set:getButtonNode("layoutMyCode_btnShare")
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
    self._btnChallenge = set:getClickNode("btnChallenge")
    self._btnSendMail = set:getClickNode("btnSendMail")
    self._btnDelete = set:getClickNode("btnDelete")
    self._FriendCountTitle = set:getLabelNode("FriendCountTitle")
    self._FriendCountValue = set:getLabelNode("FriendCountValue")
    self._AddFriend = set:getLabelNode("AddFriend")
    self._nameFrame = set:getElfNode("nameFrame")
    self._nameFrame_input = set:getInputTextNode("nameFrame_input")
    self._btnSearch = set:getButtonNode("btnSearch")
    self._noTip = set:getLabelNode("noTip")
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
    self._btnAdd = set:getClickNode("btnAdd")
    self._FriendCountTitle = set:getLabelNode("FriendCountTitle")
    self._FriendCountValue = set:getLabelNode("FriendCountValue")
    self._btnAddAll = set:getClickNode("btnAddAll")
    self._btnRefresh = set:getClickNode("btnRefresh")
    self._noTip = set:getLabelNode("noTip")
    self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
    self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
    self._commonDialog_tab = set:getElfNode("commonDialog_tab")
    self._commonDialog_tab_tabReceiveAP = set:getTabNode("commonDialog_tab_tabReceiveAP")
    self._commonDialog_tab_tabReceiveAP_title = set:getLabelNode("commonDialog_tab_tabReceiveAP_title")
    self._commonDialog_tab_tabReceiveAP_point = set:getElfNode("commonDialog_tab_tabReceiveAP_point")
    self._commonDialog_tab_tabMyFriends = set:getTabNode("commonDialog_tab_tabMyFriends")
    self._commonDialog_tab_tabMyFriends_title = set:getLabelNode("commonDialog_tab_tabMyFriends_title")
    self._commonDialog_tab_tabVerify = set:getTabNode("commonDialog_tab_tabVerify")
    self._commonDialog_tab_tabVerify_title = set:getLabelNode("commonDialog_tab_tabVerify_title")
    self._commonDialog_tab_tabVerify_point = set:getElfNode("commonDialog_tab_tabVerify_point")
    self._commonDialog_tab_tabInvite = set:getTabNode("commonDialog_tab_tabInvite")
    self._commonDialog_tab_tabInvite_title = set:getLabelNode("commonDialog_tab_tabInvite_title")
    self._commonDialog_tab_tabInvite_point = set:getElfNode("commonDialog_tab_tabInvite_point")
    self._commonDialog_tab_tabRecommend = set:getTabNode("commonDialog_tab_tabRecommend")
    self._commonDialog_tab_tabRecommend_title = set:getLabelNode("commonDialog_tab_tabRecommend_title")
    self._commonDialog_tab_tabRecommend_point = set:getElfNode("commonDialog_tab_tabRecommend_point")
--    self._@pageReceiveAP = set:getElfNode("@pageReceiveAP")
--    self._@item3 = set:getElfNode("@item3")
--    self._@pageFriendVerify = set:getElfNode("@pageFriendVerify")
--    self._@item4 = set:getElfNode("@item4")
--    self._@pageInvite = set:getElfNode("@pageInvite")
--    self._@item2 = set:getElfNode("@item2")
--    self._@itemExchange = set:getElfNode("@itemExchange")
--    self._@pageMyFriend = set:getElfNode("@pageMyFriend")
--    self._@item1 = set:getElfNode("@item1")
--    self._@pageRecommend = set:getElfNode("@pageRecommend")
--    self._@item5 = set:getElfNode("@item5")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DFriend", function ( userData )
	Launcher.callNet(netModel.getModelFriendGetFriend(),function ( ndata )
  		friendsFunc.setFriendList(ndata.D.Friends)
  		local function getFriendNetModel( tabSelected )
  			local model
  			if tabSelected == 1 then
  				model = netModel.getModelFriendGetAps()
  			elseif tabSelected == 3 then
  				model = netModel.getModelFriendGetApplys()
  			elseif tabSelected == 4 then
  			--	model = netModel.getModelFriendGetListByRandom()
  				model = netModel.getModelRoleCodeGetInfo()
  			end
  			return model
  		end

  		if userData and userData.tabIndexSelected then
  			local model = getFriendNetModel(userData.tabIndexSelected)
  			if model then
		   	Launcher.callNet(model,function ( data )
		     		Launcher.Launching(data)   
		   	end)
			else
				Launcher.Launching()
  			end
  		else
	 		local levelCapTable = dbManager.getInfoRoleLevelCap(userFunc.getLevel())
			if broadCastFunc.get("friend_receiveAP") then
		   	Launcher.callNet(netModel.getModelFriendGetAps(),function ( data )
		     		Launcher.Launching(data)   
		   	end)
			elseif broadCastFunc.get("friend_verify") and (#friendsFunc.getFriendList() < levelCapTable.friendcap) then
		   	Launcher.callNet(netModel.getModelFriendGetApplys(),function ( data )
		     		Launcher.Launching(data)   
		   	end)
			elseif broadCastFunc.get("friend_invite") then
		   	Launcher.callNet(netModel.getModelRoleCodeGetInfo(),function ( data )
		     		Launcher.Launching(data)   
		   	end)
			else
		   	Launcher.callNet(netModel.getModelFriendGetAps(),function ( data )
		     		Launcher.Launching(data)   
		   	end)
			end
  		end
	end)
end)

function DFriend:onInit( userData, netData )
	res.doActionDialogShow(self._commonDialog)

	self:setListenerEvent()
	self:broadcastEvent()
	self:initPageArray()

	local levelCapTable = dbManager.getInfoRoleLevelCap(userFunc.getLevel())
	friendsFunc.setEverydayApCap(levelCapTable.aptimes)

	if userData and userData.tabIndexSelected then
		self.tabIndexSelected = userData.tabIndexSelected
	else
		if broadCastFunc.get("friend_receiveAP") then
			self.tabIndexSelected = 1
		elseif broadCastFunc.get("friend_verify") and (#friendsFunc.getFriendList() < levelCapTable.friendcap) then
			self.tabIndexSelected = 3
		else
			self.tabIndexSelected = 1
		end
	end
	if self.tabIndexSelected == 1 then
		self:callbackReceiveAP(netData)
	elseif self.tabIndexSelected == 3 then
		self:callbackVerify(netData)
	elseif self.tabIndexSelected == 4 then
	--	self:callbackRecommend(netData)
		self:callbackInvite(netData)
	end

	self:updateTriggerState()
	self:updatePages()
	self:updateUpdatePoint()

	if require 'AccountHelper'.isItemOFF('CD_keyRUK') then
		self._commonDialog_tab_tabInvite:setVisible(false)
	end
	require 'GuideHelper':check('CFriend')
end

function DFriend:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function DFriend:setListenerEvent(  )
	require 'LangAdapter'.fontSize(self._commonDialog_tab_tabReceiveAP_title, nil, nil, nil, nil, nil, nil, nil, 20)
	require 'LangAdapter'.fontSize(self._commonDialog_tab_tabMyFriends_title, nil, nil, nil, nil, nil, nil, nil, 20)
	require 'LangAdapter'.fontSize(self._commonDialog_tab_tabVerify_title, nil, nil, nil, nil, nil, nil, nil, 20)
	require 'LangAdapter'.fontSize(self._commonDialog_tab_tabInvite_title, nil, nil, nil, nil, nil, nil, nil, 20)
	require 'LangAdapter'.fontSize(self._commonDialog_tab_tabRecommend_title, nil, nil, nil, nil, nil, nil, nil, 20)

	self._commonDialog_tab_tabMyFriends:setListener(function (  )
		if self.tabIndexSelected ~= 2 then
			self.tabIndexSelected = 2
			self:updatePages()
		end
	end)

	self._commonDialog_tab_tabInvite:setVisible(require "UnlockManager":isOpen("inviting"))
	self._commonDialog_tab_tabInvite:setListener(function (  )
		if self.tabIndexSelected ~= 4 then
			self.tabIndexSelected = 4
			self:updatePages()
		end
	end)

	self._commonDialog_tab_tabReceiveAP:setListener(function (  )
		if self.tabIndexSelected ~= 1 then
			self.tabIndexSelected = 1
			self:updatePages()
		end
	end)

	self._commonDialog_tab_tabVerify:setListener(function (  )
		if self.tabIndexSelected ~= 3 then
			self.tabIndexSelected = 3
			self:updatePages()
		end
	end)

	self._commonDialog_tab_tabRecommend:setVisible(false)
	self._commonDialog_tab_tabRecommend:setListener(function ( ... )
		if self.tabIndexSelected ~= 4 then
			self.tabIndexSelected = 4
			self:updatePages()
		end
	end)

	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._commonDialog_btnClose:setListener(function (  )
		res.doActionDialogHide(self._commonDialog, self)
	end)
end

function DFriend:initPageArray(  )
	self.pageList = {}
	for i=1,4 do
		local layer = ElfNode:create()
		 self._commonDialog_cnt_bg_page:addChild(layer)
		 table.insert(self.pageList, layer)
	end
end

function DFriend:updatePages(  )
	assert(self.tabIndexSelected >= 1 and self.tabIndexSelected <= 4)

	for i,v in ipairs(self.pageList) do
		local layer = tolua.cast(v, "ElfNode")
		layer:setVisible(i == self.tabIndexSelected)
	end
	if self.tabIndexSelected == 2 then
		self:updatePageMyFriend()
	elseif self.tabIndexSelected == 1 then
		self:updatePageReceiveAP()
	elseif self.tabIndexSelected == 3 then
		self:updatePageVerify()
	elseif self.tabIndexSelected == 4 then
		self:updatePageInvite()
	--	self:updatePageRecommend()
	end
	self:updateTabNameColor()
end

function DFriend:updateTabNameColor( ... )
	local tabNameList = {
		self._commonDialog_tab_tabReceiveAP_title,
		self._commonDialog_tab_tabMyFriends_title,
		self._commonDialog_tab_tabVerify_title,
	--	self._commonDialog_tab_tabRecommend_title,
		self._commonDialog_tab_tabInvite_title,
	}
	for i,v in ipairs(tabNameList) do
		if self.tabIndexSelected == i then
			v:setFontFillColor(res.tabColor2.selectedTextColor, true)
			v:enableStroke(res.tabColor2.selectedStrokeColor, 2, true)
		else
			v:setFontFillColor(res.tabColor2.unselectTextColor, true)
			v:enableStroke(res.tabColor2.unselectStrokeColor, 2, true)
		end
	end
end

function DFriend:updatePageMyFriend(  )
	if not self.myFriendNodeSet then
		self.myFriendNodeSet = self:createLuaSet("@pageMyFriend")
		local layer = tolua.cast(self.pageList[2], "ElfNode")
		layer:addChild(self.myFriendNodeSet[1])
		self.myFriendNodeSet[1]:setVisible(true)

		self.myFriendList = LuaList.new(self.myFriendNodeSet["bg_list"], function (  )
			return self:createLuaSet("@item1")
		end, function ( nodeLuaSet, data )
			local friendInfo = data
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
			--	nodeLuaSet["layoutStatus_value"]:setString(res.locString("Friend$Offline"))
			end
			nodeLuaSet["btnSendMail"]:setListener(function (  )
				local temp = {}
				temp.mailType = "MailSend"
				temp.receiveId = friendInfo.Fid
				temp.title = string.format(res.locString("Mail$MailTo"), friendInfo.Name)
				temp.titleReal = string.format(res.locString("Mail$MailFrom"), userFunc.getName())
				GleeCore:showLayer("DMailDetail", temp)
			end)
			nodeLuaSet["btnDelete"]:setListener(function (  )
				local param = {}
				param.title = res.locString("Friend$DeleteFriendTitle")
				param.content = res.locString("Friend$DeleteFriendDes")
				param.callback = function (  )
					self:send(netModel.getModelFriendDelete(friendInfo.Fid), function ( data )
						print("FriendDelete")
						print(data)
						friendsFunc.removeFriendWithId(friendInfo.Id)
						friendsFunc.removeFidFromRAps(friendInfo.Fid)
						self.myFriendList:update(friendsFunc.getFriendList())
						local levelCapTable = dbManager.getInfoRoleLevelCap(userFunc.getLevel())
						self.myFriendNodeSet["FriendCountValue"]:setString(string.format("%d/%d", #friendsFunc.getFriendList(), levelCapTable.friendcap))
					end)
				end
				GleeCore:showLayer("DConfirmNT", param)
			end)

			nodeLuaSet["btnChallenge"]:setListener(function ( ... )
				local param = {}
				param.type = "FriendChallenge"
				param.FriendData = {Rid = friendInfo.Fid, Name = friendInfo.Name}
				GleeCore:showLayer("DPrepareForStageBattle", param)	
			end)
			require 'LangAdapter'.fontSize(nodeLuaSet["btnSendMail_#text"], nil, nil, nil, nil, nil, nil, nil, 18)
			require 'LangAdapter'.fontSize(nodeLuaSet["btnDelete_#text"], nil, nil, nil, nil, nil, nil, nil, 18)
		end)

		self.myFriendNodeSet["nameFrame_input"]:setPlaceHolder(res.locString("Friend$InputFriendName"))
		local textNode = self.myFriendNodeSet["nameFrame_input"]:getInputTextNode()
		textNode:setFontFillColor(ccc4f(1.0, 0.722, 0.447, 1.0), true)
	--	textNode:setFontSize(24)
		self.myFriendNodeSet["btnSearch"]:setListener(function (  )
			local text = self.myFriendNodeSet["nameFrame_input"]:getText()
			if text and string.len(text) > 0 and text ~= "" and text ~= self.myFriendNodeSet["nameFrame_input"]:getPlaceHolder() then
				self:send(netModel.getModelFriendSearchV2(text), function ( data )
					print("FriendSearchV2" .. text)
					print(data)
					if data and data.D and data.D.Friends and #data.D.Friends > 0 then
						GleeCore:showLayer("DFriendSearchList", data.D.Friends)
					else
						self:toast(res.locString("Friend$findNone"))
					end
				end)
			else
				self:toast(res.locString("Friend$findNone"))
			end
		end)
	end

	friendsFunc.sortWithMyFriends()
	local friendsList = friendsFunc.getFriendList()
	self.myFriendList:update(friendsList)
	local levelCapTable = dbManager.getInfoRoleLevelCap(userFunc.getLevel())
	self.myFriendNodeSet["FriendCountValue"]:setString(string.format("%d/%d", #friendsList, levelCapTable.friendcap))

	self.myFriendNodeSet["noTip"]:setVisible(not (friendsList and #friendsList > 0))
end

function DFriend:updatePageInvite(  )
	if broadCastFunc.get("friend_invite") or not self.InviteListInfo then
		self:send(netModel.getModelRoleCodeGetInfo(), function ( data )
			self:callbackInvite(data)
			self:updatePageInvite()
		end)
	end
	if not self.InviteListInfo then
		return
	end

	if not self.InviteNodeSet then
		self.InviteNodeSet = self:createLuaSet("@pageInvite")
		local layer = tolua.cast(self.pageList[4], "ElfNode")
		layer:addChild(self.InviteNodeSet[1])
		self.InviteNodeSet[1]:setVisible(true)

		self.InviteNodeSet["myInviteNumberTitle"]:setVisible(false)
		self.InviteNodeSet["inviteNumberBg"]:setVisible(false)
		self.InviteNodeSet["inviteNumberBg_input"]:setVisible(false)
		self.InviteNodeSet["btnShare"]:setVisible(false)
	end

	self.InviteNodeSet["bg_list"]:getContainer():removeAllChildrenWithCleanup(true)
	local dbJR = dbManager.getInfoDefaultConfig("JuniorRewardDes")
	if userFunc.getLevel() <= dbJR.Value and self.InviteListInfo.JuniorCode == nil then
		local nodeLuaSet = self:createLuaSet("@itemExchange")
		self.InviteNodeSet["bg_list"]:getContainer():addChild(nodeLuaSet[1])
		res.setNodeWithPack(nodeLuaSet["icon"])
		nodeLuaSet["title"]:setString(res.locString("InviteKey$Title3"))
		nodeLuaSet["content"]:setString(dbJR.Des)
		nodeLuaSet["btnExchange"]:setListener(function ( ... )
			GleeCore:showLayer("DExchangeKey", {mode = "InviteKey", callback = function ( JuniorCode )
				self.InviteListInfo.JuniorCode = JuniorCode
				self:updatePageInvite()
			end})
		end)
	end
	for _,data in ipairs(self.InviteListInfo.Items) do
		local nodeLuaSet = self:createLuaSet("@item2")
		self.InviteNodeSet["bg_list"]:getContainer():addChild(nodeLuaSet[1])

		local dbRoleCodeConfig = dbManager.getInfoRoleCodeConfig(data.ConfigId)
		local dbReward = dbManager.getRewardItem(dbRoleCodeConfig.RewardId)
		local v = res.getDetailByDBReward(dbReward)
		res.setNodeWithRewardData(v, nodeLuaSet["icon"])
		nodeLuaSet["btn"]:setListener(function ( ... )
			if v.eventData then
				GleeCore:showLayer(v.eventData.dialog, v.eventData.data)
			end
		end)
		nodeLuaSet["count"]:setVisible(v.count > 1)
		nodeLuaSet["count"]:setString(v.count)
		nodeLuaSet["title"]:setString(dbRoleCodeConfig.Name)
		nodeLuaSet["layoutReceiveRequest_value"]:setString(dbRoleCodeConfig.Desc)
		nodeLuaSet["layoutReceiveRequest"]:layout()
		res.adjustNodeWidth( nodeLuaSet["layoutReceiveRequest"], 400 )
		nodeLuaSet["#layoutProgress"]:layout()
		res.adjustNodeWidth( nodeLuaSet["#layoutProgress"], 138 )

		nodeLuaSet["layoutPresentContent_value"]:setString(v.name .. "x" .. v.count)
		nodeLuaSet["layoutProgress_value"]:setString(string.format("%d/%d", data.Have, data.Need))
		if data.Have >= data.Need then
			nodeLuaSet["layoutProgress_value"]:setFontFillColor(res.color4F.green, true)
		else
			nodeLuaSet["layoutProgress_value"]:setFontFillColor(ccc4f(0.89,0.576,0.196,1.0), true)
		end
		
		nodeLuaSet["btnReceive_text"]:setString(data.Got and res.locString("Global$ReceiveFinish") or res.locString("Global$Receive"))
		nodeLuaSet["btnReceive"]:setEnabled(not data.Got and data.Have >= data.Need)
		nodeLuaSet["btnReceive"]:setListener(function (  )
			self:send(netModel.getModelRoleCodeReward( data.ConfigId ), function ( data )
				print("RoleCodeReward")
				print(data)
				if data and data.D then
					if data.D.Resource then
						gameFunc.updateResource(data.D.Resource)
					end
					if data.D.Reward then
						GleeCore:showLayer("DGetReward", data.D.Reward)
					end
					self:callbackInvite(data)
					self:updatePageInvite()
				end
				if not self:checkNewsInvite() then
					self:send(netModel.getModelRoleNewsUpdate("friend_invite"))
				end
			end)
		end)

		require "LangAdapter".selectLang(nil,nil,nil,function ( ... )
			nodeLuaSet["layoutReceiveRequest_#elf"]:setScale(0)
		end, function ( ... )
			nodeLuaSet["layoutReceiveRequest"]:layout()
			nodeLuaSet["layoutPresentContent"]:layout()
			res.adjustNodeWidth( nodeLuaSet["layoutReceiveRequest"], 400 )
			res.adjustNodeWidth( nodeLuaSet["layoutPresentContent"], 400 )
		end)
	end

	self.InviteNodeSet["layoutMyCode_inviteNumberBg_input"]:setString(self.InviteListInfo.MyCode)
	self.InviteNodeSet["layoutMyCode_btnShare"]:setListener(function (  )
		print("btnShare tapped.")
		self:toast(res.locString("Friend$shareTip"))
	end)

	if require "UnlockManager":isOpen("share") then
		self.InviteNodeSet["layoutMyCode_e2"]:setScale(1)
		self.InviteNodeSet["layoutMyCode_btnShare"]:setScale(1)
	else
		self.InviteNodeSet["layoutMyCode_e2"]:setScale(0)
		self.InviteNodeSet["layoutMyCode_btnShare"]:setScale(0)
	end
		
	if broadCastFunc.get("friend_invite") and not self:checkNewsInvite() then
		self:send(netModel.getModelRoleNewsUpdate("friend_invite"))
	end
	broadCastFunc.set("friend_invite", false)
	self:updateUpdatePoint()
end

function DFriend:updatePageReceiveAP(  )
	local function updateAPState( ... )
		local tempList = friendsFunc.getFriendList()
		self.receiveAPNodeSet["noTip"]:setVisible(not (tempList and #tempList > 0))

		self.receiveAPNodeSet["layoutAPReceived_value"]:setString(string.format("%d/%d", friendsFunc.getTodayAp(), friendsFunc.getEverydayApCap()))
		self.receiveAPNodeSet["btnReceiveAll"]:setEnabled(friendsFunc.getRAps() and #friendsFunc.getRAps() > 0 and friendsFunc.getTodayAp() < friendsFunc.getEverydayApCap())

		local canSendApList = friendsFunc.getCanSendApList()
		self.receiveAPNodeSet["btnSendAll"]:setEnabled(canSendApList and #canSendApList > 0)
	end

	if not self.receiveAPNodeSet then
		self.receiveAPNodeSet = self:createLuaSet("@pageReceiveAP")
		local layer = tolua.cast(self.pageList[1], "ElfNode")
		layer:addChild(self.receiveAPNodeSet[1])
		self.receiveAPNodeSet[1]:setVisible(true)

		self.receiveAPList = LuaList.new(self.receiveAPNodeSet["bg_list"], function (  )
			return self:createLuaSet("@item3")
		end, function ( nodeLuaSet, data )
			local friendInfo = data
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
			--	nodeLuaSet["layoutStatus_value"]:setString(res.locString("Friend$Offline"))
			end

			local isInSAps = friendsFunc.isInSAps(friendInfo.Fid)
			local isInRAps = friendsFunc.isInRAps(friendInfo.Fid)
			local isInTodayApList = friendsFunc.isInTodayApList(friendInfo.Fid)
			nodeLuaSet["btnSendAP"]:setEnabled(not isInSAps)
			nodeLuaSet["btnReceiveAP"]:setEnabled(isInRAps)
			nodeLuaSet["btnSendAP_text"]:setString(isInSAps and res.locString("Friend$SendApFinish") or res.locString("Friend$SendAP"))
			nodeLuaSet["btnReceiveAP_text"]:setString( (isInRAps or not isInTodayApList) and res.locString("Friend$ReceiveAP") or res.locString("Friend$ReceiveApFinish"))

			nodeLuaSet["btnSendAP"]:setListener(function (  )
				self:send(netModel.getModelFriendSendAp(friendInfo.Fid), function ( data )
					print("FriendSendAp")
					print(data)
					if data.D then
						friendsFunc.addFidToSAps(friendInfo.Fid)
						self.receiveAPList:update(friendsFunc.getFriendList())
						updateAPState()
						self:toast(res.locString("Friend$SendAPSuccess"))
					end
				end)
			end)
			nodeLuaSet["btnReceiveAP"]:setListener(function (  )
				if friendsFunc.getTodayAp() < friendsFunc.getEverydayApCap() then
					local levelCapTable = dbManager.getInfoRoleLevelCap(userFunc.getLevel())
					if userFunc.getAp() < levelCapTable.apcap then
						self:send(netModel.getModelFriendReceiveAp(friendInfo.Fid), function ( data )
							print("FriendReceiveAp")
							print(data)
							if data.D.Ap then
								self:toast(string.format(res.locString("Friend$ReceiveAPSuccess"), data.D.Ap - userFunc.getAp()))
								userFunc.setAp(data.D.Ap)
								eventCenter.eventInput("UpdateAp")

								friendsFunc.removeFidFromRAps(friendInfo.Fid)
								friendsFunc.addFidToSAps(friendInfo.Fid)
								friendsFunc.addFidToTodayApList(friendInfo.Fid)
								-- friendsFunc.sortWithAp( )
								self.receiveAPList:update(friendsFunc.getFriendList())
								updateAPState()
							end

							if not friendsFunc.checkNewsReceiveAP() then
								self:send(netModel.getModelRoleNewsUpdate("friend_receiveAP"))
							end
						end)
					else
						self:toast(res.locString("Friend$ApIsFull"))
					end
				else
					self:toast(res.locString("Friend$ReceiveAPLimit"))
				end
			end)

			require 'LangAdapter'.fontSize(nodeLuaSet["btnSendAP_text"], nil, nil, nil, nil, nil, nil, nil, 18)
			require 'LangAdapter'.fontSize(nodeLuaSet["btnReceiveAP_text"], nil, nil, nil, nil, nil, nil, nil, 18)
		end)

		self.receiveAPNodeSet["btnReceiveAll"]:setListener(function (  )
			if friendsFunc.getTodayAp() < friendsFunc.getEverydayApCap() then
				local levelCapTable = dbManager.getInfoRoleLevelCap(userFunc.getLevel())
				if userFunc.getAp() < levelCapTable.apcap then
					local fidList = {}
					friendsFunc.sortWithAp( )
					for i,v in ipairs(friendsFunc.getFriendList()) do
						if friendsFunc.isInRAps(v.Fid) then
							table.insert(fidList, v.Fid)
						end
					end
					self:send(netModel.getModelFriendReceiveApAll(table.concat(fidList, ",")), function ( data )
						print("FriendReceiveApAll")
						print(data)
						if data.D.Ap then
							self:toast(string.format(res.locString("Friend$ReceiveAPSuccess"), data.D.Ap - userFunc.getAp()))
							userFunc.setAp(data.D.Ap)
							eventCenter.eventInput("UpdateAp")
							
							if data.D.SAps then
								friendsFunc.setSAps(data.D.SAps)
							end
							if data.D.RAps then
								friendsFunc.setRAps(data.D.RAps)
							end
							if data.D.C then
								friendsFunc.setTodayApList(data.D.C)
							end

							friendsFunc.sortWithAp( )
							self.receiveAPList:update(friendsFunc.getFriendList())
							updateAPState()
						end

						if not friendsFunc.checkNewsReceiveAP() then
							self:send(netModel.getModelRoleNewsUpdate("friend_receiveAP"))
						end
					end)
				else
					self:toast(res.locString("Friend$ApIsFull"))
				end
			else
				self:toast(res.locString("Friend$ReceiveAPLimit"))
			end
		end)
		self.receiveAPNodeSet["btnSendAll"]:setListener(function ( ... )
			self:send(netModel.getModelFriendSendApAll(), function ( data )
				print("FriendSendApAll")
				print(data)
				local canSendApList = friendsFunc.getCanSendApList()
				for i,v in ipairs(canSendApList) do
					friendsFunc.addFidToSAps(v)
				end
				self.receiveAPList:update(friendsFunc.getFriendList())
				updateAPState()
				self:toast(res.locString("Friend$SendAPSuccess"))
			end)
		end)

		require 'LangAdapter'.fontSize(self.receiveAPNodeSet["btnSendAll_#text"], nil, nil, nil, nil, nil, nil, nil, 18)
		require 'LangAdapter'.fontSize(self.receiveAPNodeSet["btnReceiveAll_#text"], nil, nil, nil, nil, nil, nil, nil, 18)
	end	

	if broadCastFunc.get("friend_receiveAP") or friendsFunc.getSAps() == nil or friendsFunc.getRAps() == nil then
		self:send(netModel.getModelFriendGetAps(), function ( data )
			print("FriendGetAps")
			print(data)
			self:callbackReceiveAP(data)
			self:updatePageReceiveAP()
		
			if broadCastFunc.get("friend_receiveAP") and not friendsFunc.checkNewsReceiveAP() then
				self:send(netModel.getModelRoleNewsUpdate("friend_receiveAP"))
			end
			broadCastFunc.set("friend_receiveAP", false)
			self:updateUpdatePoint()
		end)
	end

	friendsFunc.sortWithAp( )
	self.receiveAPList:update(friendsFunc.getFriendList())
	updateAPState()
end

function DFriend:updatePageVerify(  )
	if not self.verifyNodeSet then
		self.verifyNodeSet = self:createLuaSet("@pageFriendVerify")
		local layer = tolua.cast(self.pageList[3], "ElfNode")
		layer:addChild(self.verifyNodeSet[1])
		self.verifyNodeSet[1]:setVisible(true)

		self.verifyList = LuaList.new(self.verifyNodeSet["bg_list"], function (  )
			return self:createLuaSet("@item4")
		end, function ( nodeLuaSet, data )
			local friendApply = data
			res.setNodeWithPet(nodeLuaSet["icon"], gameFunc.getPetInfo().getPetInfoByPetId(friendApply.PetId, friendApply.AwakeIndex))

			nodeLuaSet["layout1_name"]:setString(friendApply.Name)
			nodeLuaSet["layout1_lv"]:setString(string.format("Lv.%d", friendApply.Lv))
			nodeLuaSet["des"]:setString(string.format(res.locString("Friend$ApplyTip"), friendApply.Name))

			local timerListManager = require "TimeListManager"
			local seconds = timerListManager.getTimeUpToNow(friendApply.CreateAt)
			nodeLuaSet["timer"]:setString(res.getTimeText(seconds / 60))
			nodeLuaSet["btnRefuse"]:setListener(function (  )
				print("btnRefuse tapped.")
				self:send(netModel.getModelFriendRefuse(friendApply.Id), function ( data )
					print("FriendRefuse")
					print(data)
					friendsFunc.removeApplyWithId(friendApply.Id)
					self.verifyList:update(friendsFunc.getApplys())

					if not friendsFunc.chcekNewsVerify() then
						self:send(netModel.getModelRoleNewsUpdate("friend_verify"))
					end
					self:toast(string.format(res.locString("Friend$RefuseApply"), friendApply.Name))
				end)
			end)
			nodeLuaSet["btnAgree"]:setListener(function (  )
				print("btnAgree tapped.")
				local levelCapTable = dbManager.getInfoRoleLevelCap(userFunc.getLevel())
				if #friendsFunc.getFriendList() < levelCapTable.friendcap then
					self:send(netModel.getModelFriendAgree(friendApply.Id), function ( data )
						print("FriendAgree")
						print(data)
						if data and data.D and data.D.Friend then
							friendsFunc.addFriendToList(data.D.Friend)
							friendsFunc.removeApplyWithId(friendApply.Id)
							self.verifyList:update(friendsFunc.getApplys())

							self.verifyNodeSet["layoutFriendsCount_value"]:setString(string.format("%d/%d", #friendsFunc.getFriendList(), levelCapTable.friendcap))
							self:toast(string.format(res.locString("Friend$AgreeApply"), friendApply.Name))
						end
						if not friendsFunc.chcekNewsVerify() then
							self:send(netModel.getModelRoleNewsUpdate("friend_verify"))
						end
					end, function ( data )
						if data and data.Code == 1002 then
							friendsFunc.removeApplyWithId(friendApply.Id)
							self.verifyList:update(friendsFunc.getApplys())
						end
					end)
				else
					self:toast(res.locString("Friend$CapTip"))
				end
			end)
		end)
	end	

	local levelCapTable = dbManager.getInfoRoleLevelCap(userFunc.getLevel())
	self.verifyNodeSet["layoutFriendsCount_value"]:setString(string.format("%d/%d", #friendsFunc.getFriendList(), levelCapTable.friendcap))

	if broadCastFunc.get("friend_verify") or friendsFunc.getApplys() == nil then
		self:send(netModel.getModelFriendGetApplys(), function ( data )
			print("FriendGetApplys()")
			print(data)
			self:callbackVerify(data)
			self:updatePageVerify()
		end)
	end

	self.verifyList:update(friendsFunc.getApplys())
	if broadCastFunc.get("friend_verify") and not friendsFunc.chcekNewsVerify() then
		self:send(netModel.getModelRoleNewsUpdate("friend_verify"))
	end

	broadCastFunc.set("friend_verify", false)
	self:updateUpdatePoint()

	local tempList = friendsFunc.getApplys()
	self.verifyNodeSet["noTip"]:setVisible(not (tempList and #tempList > 0))
end

function DFriend:updatePageRecommend( ... )
	local function refreshList( ... )
		self:send(netModel.getModelFriendGetListByRandom(), function ( data )
			print("FriendGetListByRandom")
			print(data)
			self:callbackRecommend(data)
			self.recommendList:update(self.RecommendFriendList, true)
			self.recommendNodeSet["btnAddAll"]:setEnabled(true)
		end)
	end

	local function updateAddAllState( ... )
		local canApply = true
		if self.RecommendFriendList then
			canApply = false
			for i,v in ipairs(self.RecommendFriendList) do
				if not v.applyed then
					canApply = true
					break
				end
			end
		end
		self.recommendNodeSet["btnAddAll"]:setEnabled(canApply)
	end

	if not self.recommendNodeSet then
		self.recommendNodeSet = self:createLuaSet("@pageRecommend")
		local layer = tolua.cast(self.pageList[4], "ElfNode")
		layer:addChild(self.recommendNodeSet[1])
		self.recommendNodeSet[1]:setVisible(true)

		self.recommendList = LuaList.new(self.recommendNodeSet["bg_list"], function (  )
			return self:createLuaSet("@item5")
		end, function ( nodeLuaSet, data )
			local nFriend = data
			res.setNodeWithPet(nodeLuaSet["icon"], gameFunc.getPetInfo().getPetInfoByPetId(nFriend.PetId, nFriend.AwakeIndex))
			nodeLuaSet["layout1_name"]:setString(nFriend.Name)
			nodeLuaSet["layout1_lv"]:setString(string.format("Lv.%d", nFriend.Lv))
			nodeLuaSet["layoutBattleValue_value"]:setString(nFriend.CombatPower)
			if nFriend.IsOnline then
				nodeLuaSet["layoutStatus_value"]:setString(res.locString("Friend$Online"))
			else
				local timerListManager = require "TimeListManager"
				local seconds = timerListManager.getTimeUpToNow(nFriend.LoginAt)
				nodeLuaSet["layoutStatus_value"]:setString(self:getOffLineText(seconds / 60))
			--	nodeLuaSet["layoutStatus_value"]:setString(res.locString("Friend$Offline"))
			end

			nodeLuaSet["btnAdd"]:setEnabled(not nFriend.applyed)
			nodeLuaSet["btnAdd"]:setListener(function (  )
				FriendHelper.FriendApply(self, nFriend.Fid, function ( data )
					nFriend.applyed = true
					nodeLuaSet["btnAdd"]:setEnabled(false)
					updateAddAllState()
					self:toast(res.locString("Friend$IsSendFriend"))
				end)
			end)
		end)
	end

	local levelCapTable = dbManager.getInfoRoleLevelCap(userFunc.getLevel())
	self.recommendNodeSet["FriendCountValue"]:setString(string.format("%d/%d", #friendsFunc.getFriendList(), levelCapTable.friendcap))

	updateAddAllState()
	self.recommendNodeSet["btnAddAll"]:setListener(function ( ... )
		local fids = {}
		for i,v in ipairs(self.RecommendFriendList) do
			if not v.applyed then
				table.insert(fids, v.Fid)
			end
		end
		FriendHelper.FriendApplyList(self, fids, function ( data )
			for i,v in ipairs(self.RecommendFriendList) do
				v.applyed = true
			end
			self.recommendList:update(self.RecommendFriendList, false)
			updateAddAllState()
			self:toast(res.locString("Friend$IsSendFriend"))
		end)
	end)

	self.recommendNodeSet["btnRefresh"]:setListener(function ( ... )
		refreshList()
	end)

	if not self.RecommendFriendList then
		refreshList()
	else
		self.recommendList:update(self.RecommendFriendList)
	end
end

function DFriend:broadcastEvent(  )
	eventCenter.addEventFunc("EventFriendInvite", function ( data )
		print("CFriend_EventFriendInvite：")
		print(data)
		self:updateUpdatePoint()
	end, "DFriend")

	eventCenter.addEventFunc("EventFriendReceiveAP", function ( data )
		print("CFriend_EventFriendReceiveAP：")
		print(data)
		self:updateUpdatePoint()
	end, "DFriend")

	eventCenter.addEventFunc("EventFriendVerify", function ( data )
		print("CFriend_EventFriendVerify：")
		print(data)
		self:updateUpdatePoint()
	end, "DFriend")

	eventCenter.addEventFunc("EventFriendApplySuc", function ( data )
		print("EventFriendApplySuc:")
		print(data)
		self:updatePages()
	end, "DFriend")
end

function DFriend:close(  )
	eventCenter.resetGroup("DFriend")
end

function DFriend:updateUpdatePoint(  )
	self._commonDialog_tab_tabInvite_point:setVisible(broadCastFunc.get("friend_invite"))
	self._commonDialog_tab_tabReceiveAP_point:setVisible(broadCastFunc.get("friend_receiveAP"))

	local levelCapTable = dbManager.getInfoRoleLevelCap(userFunc.getLevel())
	self._commonDialog_tab_tabVerify_point:setVisible(broadCastFunc.get("friend_verify") and (#friendsFunc.getFriendList() < levelCapTable.friendcap) )
	self._commonDialog_tab_tabRecommend_point:setVisible(false)
end

function DFriend:callbackInvite( data )
	if data and data.D and data.D.Info then
		self.InviteListInfo = data.D.Info
	end
	broadCastFunc.set("friend_invite", false)
end

function DFriend:callbackReceiveAP( data )
	if data and data.D then
		if data.D.C then
			friendsFunc.setTodayApList(data.D.C)
		end
		if data.D.SAps then
			friendsFunc.setSAps(data.D.SAps)
		end
		if data.D.RAps then
			friendsFunc.setRAps(data.D.RAps)
		end
	end
end

function DFriend:callbackVerify( data )
	if data and data.D then
		friendsFunc.setApplys(data.D.Applys or {})
		friendsFunc.sortApplysWithVerify(  )
	end
end

function DFriend:callbackRecommend( data )
	self.RecommendFriendList = data.D.Friends or {}
	for i,v in ipairs(self.RecommendFriendList) do
		v.applyed = false
	end
end

function DFriend:getOffLineText( minute )
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

function DFriend:updateTriggerState( ... )
	if self.tabIndexSelected == 1 then
		self._commonDialog_tab_tabReceiveAP:trigger(nil)
	elseif self.tabIndexSelected == 2 then
		self._commonDialog_tab_tabMyFriends:trigger(nil)
	elseif self.tabIndexSelected == 3 then
		self._commonDialog_tab_tabVerify:trigger(nil)
	elseif self.tabIndexSelected == 4 then
	--	self._commonDialog_tab_tabRecommend:trigger(nil)
		self._commonDialog_tab_tabInvite:trigger(nil)
	end
end

function DFriend:checkNewsInvite( ... )
	if self.InviteListInfo then
		for _,data in ipairs(self.InviteListInfo.Items) do
			if not data.Got and data.Have >= data.Need then
				return true
			end
		end
	end
	return false
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DFriend, "DFriend")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DFriend", DFriend)


