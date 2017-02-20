local Config = require "Config"
local LuaList = require "LuaList"
local netModel = require "netModel"
local res = require "Res"
local timeListManager = require "TimeListManager"
local eventCenter = require 'EventCenter'
local broadCastFunc = require "BroadCastInfo"
local gameFunc = require "AppData"

local DMail = class(LuaDialog)

function DMail:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DMail.cocos.zip")
    return self._factory:createDocument("DMail.cocos")
end

--@@@@[[[[
function DMail:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._commonDialog = set:getElfNode("commonDialog")
   self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
   self._commonDialog_cnt_bg = set:getJoint9Node("commonDialog_cnt_bg")
   self._commonDialog_cnt_bg_list = set:getListNode("commonDialog_cnt_bg_list")
   self._btnDetail = set:getClickNode("btnDetail")
   self._bgStatus = set:getElfNode("bgStatus")
   self._icon = set:getElfNode("icon")
   self._iconStatus = set:getElfNode("iconStatus")
   self._layoutTitle = set:getLinearLayoutNode("layoutTitle")
   self._layoutTitle_title = set:getLabelNode("layoutTitle_title")
   self._layoutTitle_present = set:getElfNode("layoutTitle_present")
   self._layoutSender = set:getLinearLayoutNode("layoutSender")
   self._layoutSender_value = set:getLabelNode("layoutSender_value")
   self._layoutTime = set:getLinearLayoutNode("layoutTime")
   self._layoutTime_date = set:getLabelNode("layoutTime_date")
   self._layoutTime_clock = set:getLabelNode("layoutTime_clock")
   self._btnDel = set:getClickNode("btnDel")
   self._commonDialog_cnt_bg_noMail = set:getLabelNode("commonDialog_cnt_bg_noMail")
   self._commonDialog_cnt_bg_layoutMailTotal = set:getLinearLayoutNode("commonDialog_cnt_bg_layoutMailTotal")
   self._commonDialog_cnt_bg_layoutMailTotal_value = set:getLabelNode("commonDialog_cnt_bg_layoutMailTotal_value")
   self._commonDialog_cnt_bg_btnRecOneKey = set:getClickNode("commonDialog_cnt_bg_btnRecOneKey")
   self._commonDialog_cnt_bg_btnRecOneKey_text = set:getLabelNode("commonDialog_cnt_bg_btnRecOneKey_text")
   self._commonDialog_cnt_bg_btnDelOneKey = set:getClickNode("commonDialog_cnt_bg_btnDelOneKey")
   self._commonDialog_cnt_bg_btnDelOneKey_text = set:getLabelNode("commonDialog_cnt_bg_btnDelOneKey_text")
   self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
   self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
   self._commonDialog_tab = set:getElfNode("commonDialog_tab")
   self._commonDialog_tab_tabSystemMail = set:getTabNode("commonDialog_tab_tabSystemMail")
   self._commonDialog_tab_tabSystemMail_title = set:getLabelNode("commonDialog_tab_tabSystemMail_title")
   self._commonDialog_tab_tabSystemMail_point = set:getElfNode("commonDialog_tab_tabSystemMail_point")
   self._commonDialog_tab_tabPlayerMail = set:getTabNode("commonDialog_tab_tabPlayerMail")
   self._commonDialog_tab_tabPlayerMail_title = set:getLabelNode("commonDialog_tab_tabPlayerMail_title")
   self._commonDialog_tab_tabPlayerMail_point = set:getElfNode("commonDialog_tab_tabPlayerMail_point")
   self._touchLayer = set:getLuaTouchNode("touchLayer")
--   self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------

local Launcher = require 'Launcher'
Launcher.register("DMail", function ( userData )
	if not broadCastFunc.get("letter_sys") and broadCastFunc.get("letter_friend") then
		Launcher.callNet(netModel.getModelLetterGetFriend(),function ( data )
     		Launcher.Launching(data)   
   	end)
	else
		Launcher.callNet(netModel.getModelLetterGetSys(),function ( data )
     		Launcher.Launching(data)   
   	end)
	end
end)

function DMail:onInit( userData, netData )
	self.delStateList = {}
	res.doActionDialogShow(self._commonDialog)
	self:setListenerEvent()
	self:broadcastEvent()

	if not broadCastFunc.get("letter_sys") and broadCastFunc.get("letter_friend") then
		self.tabIndexSelected = 2
		self._commonDialog_tab_tabPlayerMail:trigger(nil)
		self:callbackLetterGetFriends(netData)
	else
		self.tabIndexSelected = 1
		self._commonDialog_tab_tabSystemMail:trigger(nil)
		self:callbackLetterGetSys(netData)
	end
end

function DMail:onBack( userData, netData )
	
end

function DMail:close(  )
	eventCenter.resetGroup("DMail")
end

--------------------------------custom code-----------------------------
function DMail:setListenerEvent( ... )
	self._commonDialog_tab_tabSystemMail:setListener(function (  )
		if self.tabIndexSelected ~= 1 then
			self.tabIndexSelected = 1
			self.delStateList = {}
			self:updateLayer(true)			
		end	
	end)

	self._commonDialog_tab_tabPlayerMail:setListener(function (  )
		if self.tabIndexSelected ~= 2 then
			self.tabIndexSelected = 2
			self.delStateList = {}
			self:updateLayer(true)
		end
	end)
	
	self._commonDialog_btnClose:setTriggleSound(res.Sound.back)
	self._commonDialog_btnClose:setListener(function (  )
		self._commonDialog_cnt_bg_list:stopAllActions()
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._clickBg:setListener(function (  )
		self._commonDialog_cnt_bg_list:stopAllActions()
		res.doActionDialogHide(self._commonDialog, self)
	end)

	local itemSet = self:createLuaSet("@item")
	local size = itemSet[1]:getContentSize()
	local winSize = CCDirector:sharedDirector():getWinSize()
	local function getListIndexWithPoint( x, y )
		if x >  winSize.width / 2 + size.width / 2 or x < winSize.width / 2 -size.width or y > 350 / 2 + winSize.height / 2 then
			return -1
		else
			local _, cy = self._commonDialog_cnt_bg_list:getContainer():getPosition()
			print("cy = " .. cy .. ", winSize.height = " .. winSize.height .. ", height = " .. size.height .. ", y = " .. y)
			return math.ceil ((cy - 170 + 350 / 2 + winSize.height / 2 - y) / size.height)
		end
	end
	self._touchLayer:setListener(function ( status, x, y ) 
		print("status = " .. status .. ", x = " .. x .. ", y = " .. y)
		if status == 0 then -- touchDown
			self.pointx = x
			self.lastIndex = getListIndexWithPoint(x, y)
		elseif status == 2 then -- touchUp
			local index = getListIndexWithPoint(x, y)
			if self.lastIndex and self.lastIndex >= 0 and index == self.lastIndex then
				if x - self.pointx > 100 then
					self.delStateList[self.lastIndex] = false
				elseif x - self.pointx < -100 then
					self.delStateList = {}
					self.delStateList[self.lastIndex] = true
				end
				self:updateLayer(false)
			end
		end
	end)

	self._commonDialog_cnt_bg_btnRecOneKey:setListener(function ( ... )
		local param = {}
		param.content = res.locString("Mail$MailRecOneKeyTip")
		param.callback = function ( ... )
			self:getMailRewardPre(function ( ... )
				self:send(netModel.getModelLetterReceiveAll(), function ( data )
					if data and data.D then
						gameFunc.updateResource(data.D.Resource)
						res.doActionGetReward(data.D.Reward)

						if self.tabIndexSelected == 1 then
							self:callbackLetterGetSys(data)
						elseif self.tabIndexSelected == 2 then
							self:callbackLetterGetFriends(data)
						end
					end
				end)
			end)
		end
		GleeCore:showLayer("DConfirmNT", param)
	end)

	self._commonDialog_cnt_bg_btnDelOneKey:setListener(function ( ... )
		local param = {}
		param.content = res.locString("Mail$MailDelOneKeyTip")
		param.callback = function ( ... )
			self:send(netModel.getModelLetterDelAll(self.tabIndexSelected == 1), function ( data )
				if data and data.D then
					gameFunc.updateResource(data.D.Resource)
					res.doActionGetReward(data.D.Reward)
					self:toast(res.locString("Mail$MailDelSucTip"))

					if self.tabIndexSelected == 1 then
						self:callbackLetterGetSys(data)
					elseif self.tabIndexSelected == 2 then
						self:callbackLetterGetFriends(data)
					end
				end
			end)
		end
		GleeCore:showLayer("DConfirmNT", param)
	end)

	require "LangAdapter".fontSize(self._commonDialog_cnt_bg_btnRecOneKey_text, nil, nil, nil, nil, 20)
	require "LangAdapter".fontSize(self._commonDialog_cnt_bg_btnDelOneKey_text, nil, nil, nil, nil, 20)
end

function DMail:updateUpdatePoint(  )
	self._commonDialog_tab_tabSystemMail_point:setVisible(broadCastFunc.get("letter_sys"))
	self._commonDialog_tab_tabPlayerMail_point:setVisible(broadCastFunc.get("letter_friend"))
end

function DMail:broadcastEvent(  )
	eventCenter.addEventFunc("EventLetterSystem", function ( data )
		print("EventLetterSystem:")
		print(data)
		self:updateUpdatePoint()
	end, "DMail")

	eventCenter.addEventFunc("EventLetterFriend", function ( data )
		print("EventLetterFriend:")
		print(data)
		self:updateUpdatePoint()
	end, "DMail")
end

function DMail:updateTabNameColor( ... )
	local tabNameList = {
		self._commonDialog_tab_tabSystemMail_title,
		self._commonDialog_tab_tabPlayerMail_title, 
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

function DMail:callbackLetterGetSys( data )
	print("LetterGetSys:")
	print(data)
	if data and data.D then
		self.systemMailList = data.D.Letters or {}
		table.sort(self.systemMailList, function ( mail1, mail2 )
			if mail1.State == mail2.State then
				return timeListManager.getTimestamp(mail1.CreateAt) > timeListManager.getTimestamp(mail2.CreateAt)
			else
				return mail1.State < mail2.State
			end
		end)

		if broadCastFunc.get("letter_sys") and not self:checkNewsMail() then
			self:send(netModel.getModelRoleNewsUpdate("letter_sys"))
		end
		broadCastFunc.set("letter_sys", false)
		self:updateUpdatePoint()

		self:updateLayer(true)
	end
end

function DMail:callbackLetterGetFriends( data )
	print("LetterGetFriend:")
	print(data)
	if data and data.D then
		self.playerMailList = data.D.Letters or {}
		table.sort(self.playerMailList, function ( mail1, mail2 )
			if mail1.State == mail2.State then
				return timeListManager.getTimestamp(mail1.CreateAt) > timeListManager.getTimestamp(mail2.CreateAt)
			else
				return mail1.State < mail2.State
			end
		end)

		if broadCastFunc.get("letter_friend") and not self:checkNewsMail() then
			self:send(netModel.getModelRoleNewsUpdate("letter_friend"))
		end
		broadCastFunc.set("letter_friend", false)
		self:updateUpdatePoint()

		self:updateLayer(true)
	end
end

function DMail:updateLayer( refreshList )
	if self.tabIndexSelected == 1 then
		if not self.systemMailList or broadCastFunc.get("letter_sys") then
			self:send(netModel.getModelLetterGetSys(), function ( data )
				self:callbackLetterGetSys(data)
			end)
		end
	elseif self.tabIndexSelected == 2 then
		if not self.playerMailList or broadCastFunc.get("letter_friend") then
			self:send(netModel.getModelLetterGetFriend(), function ( data )
				self:callbackLetterGetFriends(data)
			end)
		end
	end

	self:updateTabNameColor()

	if not self.mailList then
		self.mailList = LuaList.new(self._commonDialog_cnt_bg_list, function ( ... )
			return self:createLuaSet("@item")
		end, function ( nodeLuaSet, data, index )
			local mailData = data
			if mailData.State == 1 then
				nodeLuaSet["bgStatus"]:setResid("N_XJ_beijing2_sel.png")
				nodeLuaSet["icon"]:setResid("N_XJ_tubiao1.png")
				nodeLuaSet["iconStatus"]:setResid("N_XJ_weidu.png")
			elseif mailData.State == 2 then
				nodeLuaSet["bgStatus"]:setResid("N_XJ_beijing2.png")
				nodeLuaSet["icon"]:setResid("N_XJ_tubiao2.png")
				nodeLuaSet["iconStatus"]:setResid("N_XJ_yidu.png")
			end
			nodeLuaSet["layoutTitle_title"]:setString(mailData.Title)
			nodeLuaSet["layoutTitle_present"]:setVisible(mailData.Reward ~= nil)
			nodeLuaSet["layoutSender_value"]:setString(mailData.Sender)
			require "LangAdapter".selectLang(nil,nil,nil,nil,nil,function ( ... )
				nodeLuaSet["layoutSender"]:setPosition(ccp(-204.28569,-25.214294))
			end,function ( ... )
				nodeLuaSet["layoutSender"]:setPosition(ccp(-204.28569,-25.214294))
			end)

			local createTime = os.date("*t", timeListManager.getTimestamp(mailData.CreateAt))
			nodeLuaSet["layoutTime_date"]:setString(string.format("%02d-%02d", createTime.month, createTime.day))
			nodeLuaSet["layoutTime_clock"]:setString(string.format("%02d:%02d", createTime.hour, createTime.min))
			nodeLuaSet["btnDetail"]:setListener(function (  )
				if mailData.State == 1 and mailData.Reward == nil then
					self:send(netModel.getModelLetterRead(mailData.Id), function ( data )
						mailData.State = 2
						nodeLuaSet["bgStatus"]:setResid("N_XJ_beijing2.png")
						nodeLuaSet["icon"]:setResid("N_XJ_tubiao2.png")
						nodeLuaSet["iconStatus"]:setResid("N_XJ_yidu.png")

						if not self:checkNewsMail() then
							if self.tabIndexSelected == 1 then
								self:send(netModel.getModelRoleNewsUpdate("letter_sys"))
							elseif self.tabIndexSelected == 2 then
								self:send(netModel.getModelRoleNewsUpdate("letter_friend"))
							end
						end
					end)
				end
				self.delStateList = {}
				GleeCore:showLayer("DMailDetail", {mailData = mailData, mailType =  self.tabIndexSelected == 1 and "MailSystem" or "MailFriend", callback = function (  )
					if self.tabIndexSelected == 1 then
						for i,v in ipairs(self.systemMailList) do
							if v.Id == data.Id then
								table.remove(self.systemMailList, i)
								break
							end
						end
						self:updateLayer(false)

						if not self:checkNewsMail() then
							self:send(netModel.getModelRoleNewsUpdate("letter_sys"))
						end
					end
				end})
			end)
			nodeLuaSet["btnDel"]:setListener(function (  )
				self:send(netModel.getModelLetterDel(mailData.Id), function ( data )
					print("LetterDel")
					print(data)
					if data and data.D then
						local listData
						if self.tabIndexSelected == 1 then
							listData = self.systemMailList 
						elseif self.tabIndexSelected == 2 then
							listData = self.playerMailList
						end

						for i,v in ipairs(listData) do
							if v.Id == mailData.Id then
								table.remove(listData, i)
								break
							end
						end
						self.delStateList = {}
						self:updateLayer(false)
					end
				end)
			end)

			local delVisible = (self.tabIndexSelected == 2 or mailData.Reward == nil) and self.delStateList[index] or false
		--	print("visible =  " .. tostring(self.delStateList[index]) ..", index = " .. index .. ", delVisible = " .. tostring(delVisible))
			nodeLuaSet["btnDel"]:setVisible(delVisible)
			nodeLuaSet["layoutTime"]:setVisible(not delVisible)
		end)
	end

	local listData
	if self.tabIndexSelected == 1 then
		listData = self.systemMailList 
	elseif self.tabIndexSelected == 2 then
		listData = self.playerMailList
	end
	listData = listData or {}
	self.mailList:update(listData, refreshList)

	self._commonDialog_cnt_bg_noMail:setVisible(#listData == 0)

	self._commonDialog_cnt_bg_layoutMailTotal_value:setString(#listData)
	self._commonDialog_cnt_bg_btnRecOneKey:setVisible(self.tabIndexSelected == 1)
	self._commonDialog_cnt_bg_btnRecOneKey:setEnabled(self:checkMailCanRecRwd())
	self._commonDialog_cnt_bg_btnDelOneKey:setEnabled(self:checkMailCanDel())
end

function DMail:checkNewsMail( ... )
	local listData
	if self.tabIndexSelected == 1 then
		listData = self.systemMailList 
	elseif self.tabIndexSelected == 2 then
		listData = self.playerMailList
	end
	if listData then
		for k,v in pairs(listData) do
			if v.State == 1 then
				return true
			end
		end
	end
	return false
end

function DMail:checkMailCanRecRwd( ... )
	if self.tabIndexSelected == 1 then
		for k,v in pairs(self.systemMailList) do
			if v.State == 1 and v.Reward ~= nil then
				return true
			end
		end
	end
	return false
end

function DMail:checkMailCanDel( ... )
	if self.tabIndexSelected == 1 then
		if self.systemMailList then
			for k,v in pairs(self.systemMailList) do
				if v.Reward == nil then
					return true
				end
			end
		end
		return false
	elseif self.tabIndexSelected == 2 then
		return self.playerMailList and #self.playerMailList > 0
	end
end

function DMail:getMailRewardPre( callback )
	local nRewardList = {}
	for k,v in pairs(self.systemMailList) do
		if v.State == 1 and v.Reward ~= nil then
			table.insert(nRewardList, v.Reward)
		end
	end

	local isPetFull = false
	local isEquipFull = false

	local petList = gameFunc.getPetInfo().getPetList()
	isPetFull = petList and #petList >= 100

	local equipList = gameFunc.getEquipInfo().getEquipList()
	isEquipFull = equipList and #equipList >= 300

	local rwdPet, rwdEquip, rwdOther = false, false, false
	local canGet = false
	for i,nReward in ipairs(nRewardList) do
		local list = res.getRewardResList(nReward)
		local flag = true
		for i,v in ipairs(list) do
			if v.type == "Pet" then
				rwdPet = true
				if isPetFull then
					flag = false
				end
			elseif v.type == "Equipment" then
				rwdEquip = true
				if isEquipFull then
					flag = false
				end
			else
				rwdOther = true
			end
			if rwdPet and rwdEquip and rwdOther then
				break
			end
		end
		if flag then
			canGet = true
		end
	end
	
	if canGet then
		callback()
		return
	end

	-- if (rwdPet and not isPetFull) or (rwdEquip and not isEquipFull) then
	-- 	callback()
	-- else
		if isPetFull and rwdPet then
			require 'Toolkit'.showDialogOnPetListMax()
		elseif isEquipFull and rwdEquip then
			require "Toolkit".showDialogOnEquipListMax()
		end
	-- end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DMail, "DMail")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DMail", DMail)


