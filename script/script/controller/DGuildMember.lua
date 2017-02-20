local Config = require "Config"
local LuaList = require "LuaList"
local netModel = require "netModel"
local timerListManager = require "TimeListManager"
local gameFunc = require "AppData"
local res = require "Res"
local eventCenter = require 'EventCenter'
local petFunc = gameFunc.getPetInfo()
local guildFunc = gameFunc.getGuildInfo()
local userFunc = gameFunc.getUserInfo()
local broadCastFunc = gameFunc.getBroadCastInfo()

local DGuildMember = class(LuaDialog)

function DGuildMember:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGuildMember.cocos.zip")
    return self._factory:createDocument("DGuildMember.cocos")
end

--@@@@[[[[
function DGuildMember:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_bg = set:getJoint9Node("commonDialog_cnt_bg")
    self._commonDialog_cnt_bg_pageList = set:getElfNode("commonDialog_cnt_bg_pageList")
    self._layout = set:getLayoutNode("layout")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._LvBg = set:getElfNode("LvBg")
    self._LvBg_lv = set:getLabelNode("LvBg_lv")
    self._name = set:getLabelNode("name")
    self._battleValue = set:getLinearLayoutNode("battleValue")
    self._battleValue_value = set:getLabelNode("battleValue_value")
    self._contribute = set:getLinearLayoutNode("contribute")
    self._contribute_value = set:getLabelNode("contribute_value")
    self._onlineStatus = set:getLinearLayoutNode("onlineStatus")
    self._onlineStatus_value = set:getLabelNode("onlineStatus_value")
    self._btn = set:getClickNode("btn")
    self._state = set:getElfNode("state")
    self._impeaching = set:getLabelNode("impeaching")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._LvBg = set:getElfNode("LvBg")
    self._LvBg_lv = set:getLabelNode("LvBg_lv")
    self._name = set:getLabelNode("name")
    self._battleValue = set:getLinearLayoutNode("battleValue")
    self._battleValue_value = set:getLabelNode("battleValue_value")
    self._timer = set:getLinearLayoutNode("timer")
    self._timer_value = set:getLabelNode("timer_value")
    self._btnRefuse = set:getClickNode("btnRefuse")
    self._btnAgree = set:getClickNode("btnAgree")
    self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
    self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
    self._commonDialog_tab = set:getElfNode("commonDialog_tab")
    self._commonDialog_tab_tabMember = set:getTabNode("commonDialog_tab_tabMember")
    self._commonDialog_tab_tabMember_title = set:getLabelNode("commonDialog_tab_tabMember_title")
    self._commonDialog_tab_tabApply = set:getTabNode("commonDialog_tab_tabApply")
    self._commonDialog_tab_tabApply_title = set:getLabelNode("commonDialog_tab_tabApply_title")
    self._commonDialog_tab_tabApply_point = set:getElfNode("commonDialog_tab_tabApply_point")
--    self._@listMember = set:getListNode("@listMember")
--    self._@size = set:getElfNode("@size")
--    self._@itemMember = set:getElfNode("@itemMember")
--    self._@listApply = set:getListNode("@listApply")
--    self._@itemApply = set:getElfNode("@itemApply")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DGuildMember", function ( userData )
   	Launcher.callNet(netModel.getModelGuildMemberGet( guildFunc.getGuildMember().Gid ),function ( data )
     		Launcher.Launching(data)
   	end)
end)

function DGuildMember:onInit( userData, netData )
	if netData and netData.D then
		self.Members = netData.D.Members or {}
		guildFunc.setGuildMemberList( self.Members )
		if netData.D.Guild then
			guildFunc.setData(netData.D.Guild)
		end
		print(netData)
	end

	self:setListenerEvent()
	self:broadcastEvent()
	self.tabIndexSelected = 1
	self:initPageArray()
	self:updatePages()
	self:updateGuildTabVisible()

	res.doActionDialogShow(self._commonDialog)
end

function DGuildMember:onBack( userData, netData )
	self:updatePages()
	self:updateGuildTabVisible()
end

function DGuildMember:close(  )
	eventCenter.resetGroup("DGuildMember")
end

--------------------------------custom code-----------------------------

function DGuildMember:setListenerEvent(  )
	require 'LangAdapter'.fontSize(self._commonDialog_tab_tabMember_title,nil,nil,nil,nil,18)
	require 'LangAdapter'.fontSize(self._commonDialog_tab_tabApply_title,nil,nil,nil,nil,18)

	self._commonDialog_tab_tabMember:trigger(nil)
	self._commonDialog_tab_tabMember:setListener(function ( ... )
		if self.tabIndexSelected ~= 1 then
			self.tabIndexSelected = 1
			self:updatePages()
		end
	end)

	self._commonDialog_tab_tabApply:setListener(function ( ... )
		if self.tabIndexSelected ~= 2 then
			self.tabIndexSelected = 2
			self:updatePages()
		end
	end)

	self._commonDialog_btnClose:setListener(function ( ... )
		self.pageList[self.tabIndexSelected][1]:stopAllActions()
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._clickBg:setListener(function ( ... )
		self.pageList[self.tabIndexSelected][1]:stopAllActions()
		res.doActionDialogHide(self._commonDialog, self)
	end)
end

function DGuildMember:broadcastEvent( ... )
	eventCenter.addEventFunc("GuildFire", function ( data )
		for i,v in ipairs(self.Members) do
			if data.Rid == v.Rid then
				table.remove(self.Members, i)
				break
			end
		end
		self:updatePages()
	end, "DGuildMember")

	eventCenter.addEventFunc("EventGuildApply", function ( data )
		print("EventGuildApply:")
		print(data)
		self:updateUpdatePoint()
	end, "DGuildMember")
end

function DGuildMember:updateTabNameColor( ... )
	local tabNameList = {
		self._commonDialog_tab_tabMember_title,
		self._commonDialog_tab_tabApply_title
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

function DGuildMember:initPageArray( ... )
	local dyList = {"@listMember", "@listApply"}
	self.pageList = {}
	for i,v in ipairs(dyList) do
		local set = self:createLuaSet(v)
		self._commonDialog_cnt_bg_pageList:addChild(set[1])
		set[1]:setVisible(false)
		table.insert(self.pageList, set)
	end
end

function DGuildMember:updatePages( ... )
	for i,v in ipairs(self.pageList) do
		v[1]:setVisible(i == self.tabIndexSelected)
	end
	if self.tabIndexSelected == 1 then
		self:updateGuildMember()
	elseif self.tabIndexSelected == 2 then
		self:updateGuildApply()
	end
	self:updateTabNameColor()
	self:updateUpdatePoint()
end

function DGuildMember:updateGuildMember( ... )
	if not self.guildMemberList then
		self.guildMemberList = LuaList.new(self.pageList[1][1], function (  )
			local sizeSet = self:createLuaSet("@size")
			sizeSet["setList"] = {}
			for i=1,2 do
				local itemSet = self:createLuaSet("@itemMember")
				sizeSet["layout"]:addChild(itemSet[1])
				table.insert(sizeSet["setList"], itemSet)
			end
			return sizeSet
		end, function (  nodeLuaSet, dataList )
			local itemSetList = nodeLuaSet["setList"]
			for i,set in ipairs(itemSetList) do
				set[1]:setVisible(i <= #dataList)
				if i <= #dataList then
					local nGuildMemberDetail = dataList[i]
					local nPet = petFunc.getPetInfoByPetId( nGuildMemberDetail.PetId, nGuildMemberDetail.AwakeIndex )
					res.setNodeWithPet(set["icon"], nPet)
				
					set["LvBg"]:setResid(string.format("N_JJC_%d.png", res.getFinalAwake(nGuildMemberDetail.AwakeIndex)))
					set["LvBg_lv"]:setString(nGuildMemberDetail.Lv)
					set["name"]:setString(nGuildMemberDetail.Name)
					set["battleValue_value"]:setString(nGuildMemberDetail.CombatPower)
					set["contribute_value"]:setString(nGuildMemberDetail.TotalPoint)
					if nGuildMemberDetail.IsOnline then
						set["onlineStatus_value"]:setString(res.locString("Friend$Online"))
					else
						local timerListManager = require "TimeListManager"
						local seconds = timerListManager.getTimeUpToNow(nGuildMemberDetail.LastOnlineAt)
						set["onlineStatus_value"]:setString(res.getTimeText(seconds / 60))
					end

					set["btn"]:setListener(function ( ... )
						GleeCore:showLayer("DGuildMemberInfo", nGuildMemberDetail)
					end)
					
					if guildFunc.isPresident(nGuildMemberDetail.Rid) then
						set["state"]:setResid("N_GH_huizhang.png")
						set["state"]:setVisible(true)
						local status = guildFunc.getElectionState()
						set["impeaching"]:setVisible(status > 0)
						if status == 1 then
							set["impeaching"]:setString(res.locString("Guild$CanImpeach"))
						elseif status == 2 then
							set["impeaching"]:setString(res.locString("Guild$Impeaching"))
						end
					elseif guildFunc.isVicePresident(nGuildMemberDetail.Rid) then
						set["state"]:setResid("N_GH_fuhuizhang.png")
						set["state"]:setVisible(true)
						set["impeaching"]:setVisible(false)
					else
						set["state"]:setVisible(false)
						set["impeaching"]:setVisible(false)
					end
				end
			end
		end)
	end

	self.guildMemberList:update(self:getGuildMemberData())
end

function DGuildMember:updateGuildApply( ... )
	if not self.guildApplyList then
		self.guildApplyList = LuaList.new(self.pageList[2][1], function (  )
			return self:createLuaSet("@itemApply")
		end, function (  nodeLuaSet, data )
			local nGuildApplyDetail = data
			local nPet = petFunc.getPetInfoByPetId( nGuildApplyDetail.PetId, nGuildApplyDetail.AwakeIndex )
			res.setNodeWithPet(nodeLuaSet["icon"], nPet)

			nodeLuaSet["LvBg"]:setResid(string.format("N_JJC_%d.png", res.getFinalAwake(nGuildApplyDetail.AwakeIndex)))
			nodeLuaSet["LvBg_lv"]:setString(nGuildApplyDetail.Lv)

			nodeLuaSet["name"]:setString(nGuildApplyDetail.Name)
			nodeLuaSet["battleValue_value"]:setString(nGuildApplyDetail.CombatPower)

			local seconds = timerListManager.getTimeUpToNow(nGuildApplyDetail.CreateAt)
			nodeLuaSet["timer_value"]:setString(res.getTimeText(seconds / 60))
			nodeLuaSet["btnAgree"]:setListener(function ( ... )
				self:send(netModel.getModelGuildAgree(nGuildApplyDetail.Id), function ( data )
					print(data)
					if data and data.D then
						if data.D.Guild then
							guildFunc.setData(data.D.Guild)
						end
						if data.D.Members then
							for i,v in ipairs(self.applyListData) do
								if nGuildApplyDetail.Rid == v.Rid then
									table.remove(self.applyListData, i)
									self:updateGuildApply()
									break
								end
							end
							self.Members = data.D.Members
						end
						self:updateGuildMember()

						if not self:checkGuildApply() then
							self:send(netModel.getModelRoleNewsUpdate("guild_apply"))
						end
					end
				end, function ( data )
					for i,v in ipairs(self.applyListData) do
						if nGuildApplyDetail.Rid == v.Rid then
							table.remove(self.applyListData, i)
							self:updateGuildApply()
							break
						end
					end
					if not self:checkGuildApply() then
						self:send(netModel.getModelRoleNewsUpdate("guild_apply"))
					end
				end)
			end)

			nodeLuaSet["btnRefuse"]:setListener(function ( ... )
				self:send(netModel.getModelGuildRefuse(nGuildApplyDetail.Id), function ( data )
					print("GuildRefuse")
					print(data)
					for i,v in ipairs(self.applyListData) do
						if nGuildApplyDetail.Rid == v.Rid then
							table.remove(self.applyListData, i)
							self:updateGuildApply()
							break
						end
					end					
					if data.D.Guild then
						guildFunc.setData(data.D.Guild)
					end
					if not self:checkGuildApply() then
						self:send(netModel.getModelRoleNewsUpdate("guild_apply"))
					end
				end)
			end)
		end)
	end

	local list = self:getGuildApplyData()
	if list == nil or broadCastFunc.get("guild_apply") then
		self:send(netModel.getModelGuildGetApplyAll(guildFunc.getGuildMember().Gid), function ( data )
			if data and data.D then
				self.applyListData = data.D.Applys
				self:updateGuildApply()

				if not self:checkGuildApply() then
					self:send(netModel.getModelRoleNewsUpdate("guild_apply"))
				end
			end
		end )
	else
		self:sortGuildApplyList(list)
		self.guildApplyList:update(list)
	end

	broadCastFunc.set("guild_apply", false)
	self:updateUpdatePoint()
end

function DGuildMember:sortGuildMember( ... )
	if self.Members and #self.Members > 0 then
		table.sort(self.Members, function ( a, b )
			if guildFunc.isPresident(a.Rid) then
				return true
			elseif guildFunc.isPresident(b.Rid) then
				return false
			else
				local va = guildFunc.isVicePresident(a.Rid)
				local vb = guildFunc.isVicePresident(b.Rid)
				if va and not vb then
					return true
				elseif vb and not va then
					return false
				else
					if a.TotalPoint == b.TotalPoint then
						if a.CombatPower == b.CombatPower then
							if a.Lv == b.Lv then
								return a.Rid < b.Rid
							else
								return a.Lv > b.Lv
							end
						else
							return a.CombatPower > b.CombatPower
						end
					else
						return a.TotalPoint > b.TotalPoint
					end
				end		
			end
		end)
	end
end

function DGuildMember:sortGuildApplyList( list )
	if list and #list > 1 then
		table.sort(list, function ( a, b )
			local timer1 = timerListManager.getTimestamp(a.CreateAt)
			local timer2 = timerListManager.getTimestamp(b.CreateAt)
			if timer1 == timer2 then
				if a.Lv == b.Lv then
					return a.Lv > b.Lv
				else
					return a.Rid < b.Rid
				end
			else
				return timer1 > timer2
			end
		end)
	end
end

function DGuildMember:getGuildMemberData( ... )
	local listData = {}
	if self.Members then
		self:sortGuildMember()
		lineCount = 2
		for i,v in ipairs(self.Members) do
			local a = math.floor((i - 1) / lineCount + 1)
			local b = math.floor((i - 1) % lineCount + 1)
			listData[a] = listData[a] or {}
			listData[a][b] = v
		end
	end
	return listData
end

function DGuildMember:getGuildApplyData( ... )
	print("self.applyListData")
	print(self.applyListData)
	return self.applyListData
end

function DGuildMember:updateGuildTabVisible( ... )
	local isVisible = guildFunc.isPresident(userFunc.getId()) or guildFunc.isVicePresident(userFunc.getId())
	self._commonDialog_tab_tabMember:setVisible(isVisible)
	self._commonDialog_tab_tabApply:setVisible(isVisible)
end

function DGuildMember:updateUpdatePoint(  )
	self._commonDialog_tab_tabApply_point:setVisible(broadCastFunc.get("guild_apply"))
end

function DGuildMember:checkGuildApply( ... )
	return self.applyListData and #self.applyListData > 0
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGuildMember, "DGuildMember")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGuildMember", DGuildMember)
