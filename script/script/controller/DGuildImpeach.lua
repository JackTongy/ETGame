local Config = require "Config"
local res = require "Res"
local LuaList = require "LuaList"
local netModel = require "netModel"
local gameFunc = require "AppData"
local guildFunc = gameFunc.getGuildInfo()
local userFunc = gameFunc.getUserInfo()
local petFunc = gameFunc.getPetInfo()

local DGuildImpeach = class(LuaDialog)

function DGuildImpeach:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGuildImpeach.cocos.zip")
    return self._factory:createDocument("DGuildImpeach.cocos")
end

--@@@@[[[[
function DGuildImpeach:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_bg = set:getJoint9Node("commonDialog_cnt_bg")
    self._commonDialog_cnt_bg_list = set:getListNode("commonDialog_cnt_bg_list")
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
    self._like = set:getElfNode("like")
    self._likecount = set:getLabelNode("likecount")
    self._commonDialog_cnt_layoutTimer_timer = set:getTimeNode("commonDialog_cnt_layoutTimer_timer")
    self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
    self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
    self._commonDialog_btnHelp = set:getButtonNode("commonDialog_btnHelp")
--    self._@size = set:getElfNode("@size")
--    self._@itemMember = set:getElfNode("@itemMember")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DGuildImpeach", function ( userData )
   	Launcher.callNet(netModel.getModelGuildElectionStart(  ),function ( data )
     		Launcher.Launching(data)
   	end)
end)

function DGuildImpeach:onInit( userData, netData )
	if netData and netData.D then
		self.Votes = netData.D.Votes or {}
		self.ImpeachVote = netData.D.EndAt
		print(netData)
		guildFunc.setElectionState(2)
	end

	self:setListenerEvent()
	self:updateTime()
	self:updateList()
	res.doActionDialogShow(self._commonDialog)
end

function DGuildImpeach:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DGuildImpeach:setListenerEvent( ... )
	self._commonDialog_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._commonDialog_btnHelp:setListener(function ( ... )
		GleeCore:showLayer("DHelp", {type = "公会弹劾"})
	end)
end

function DGuildImpeach:updateTime( ... )
	local seconds = -math.floor(require "TimeListManager".getTimeUpToNow(self.ImpeachVote))
	seconds = math.max(seconds, 0)
	local date = self._commonDialog_cnt_layoutTimer_timer:getElfDate()
	date:setHourMinuteSecond(0, 0, seconds)
	self._commonDialog_cnt_layoutTimer_timer:setUpdateRate(-1)
	self._commonDialog_cnt_layoutTimer_timer:addListener(function (  )
		date:setHourMinuteSecond(0, 0, 0)
		self._commonDialog_cnt_layoutTimer_timer:setUpdateRate(0)
		res.doActionDialogHide(self._commonDialog, self)
		self:toast(res.locString("Guild$ImpeachFinish"))
	end)
end

function DGuildImpeach:updateList( ... )
	if not self.guildImpeachList then
		self.guildImpeachList = LuaList.new(self._commonDialog_cnt_bg_list, function (  )
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
						if not self.myChoseId then
							local param = {}
							param.content = string.format(res.locString("Guild$ImpeachConfirm"), nGuildMemberDetail.Name)
							param.callback = function ( ... )
								self:send(netModel.getModelGuildVote(nGuildMemberDetail.Rid), function ( data )
									if data and data.D then
										self.myChoseId = nGuildMemberDetail.Rid
										-- nGuildMemberDetail.Vote = nGuildMemberDetail.Vote + 1
										-- self:updateList()
										
										set["bg"]:setResid("N_GH_cy_bs.png")
										set["like"]:setResid("N_GH_zhichi1.png") 
										set["likecount"]:setString(nGuildMemberDetail.Vote + 1)
									end
								end)				
							end
							GleeCore:showLayer("DConfirmNT", param)
						end
					end)
					
					set["bg"]:setResid(nGuildMemberDetail.Rid ~= self.myChoseId and "N_GH_cy_hs.png" or "N_GH_cy_bs.png")
					set["like"]:setResid(nGuildMemberDetail.Rid == self.myChoseId and "N_GH_zhichi1.png" or "N_GH_zhichi2.png") 
					set["likecount"]:setString(nGuildMemberDetail.Vote)
				end
			end
		end)
	end

	self.guildImpeachList:update(self:getImpeachListData())
end

function DGuildImpeach:getVoteCount( rid )
	local count = 0
	for i,v in ipairs(self.Votes) do
		if v.PresidentId == rid then
			count = count + 1
		end
	end
	return count
end

function DGuildImpeach:getMyChoseId( ... )
	local iUserId = userFunc.getId()
	for i,v in ipairs(self.Votes) do
		if v.Rid == iUserId then
			return v.PresidentId
		end
	end
end

function DGuildImpeach:getImpeachListData( ... )
	self.memberList = self.memberList or table.clone(guildFunc.getGuildMemberList())
	self.memberList = self.memberList or {}
	local cloneList = self.memberList
	local removeIndex
	self.myChoseId = self:getMyChoseId()
	for i,v in ipairs(cloneList) do
		if guildFunc.isPresident( v.Rid ) then
			removeIndex = i
		else
			local count = self:getVoteCount( v.Rid )
			cloneList[i].Vote = count
		end
	end
	if removeIndex then
		table.remove(cloneList, removeIndex)
	end
	print("cloneListIMpeach")
	print(cloneList)
	table.sort(cloneList, function ( v1, v2 )
		if v1.Vote == v2.Vote then
			local vp1 = guildFunc.isVicePresident( v1.Rid )
			local vp2 = guildFunc.isVicePresident( v2.Rid )
			if vp1 == vp2 then
				if v1.TotalPoint == v2.TotalPoint then
					if v1.Lv == v2.Lv then
						return v1.Rid < v2.Rid
					else
						return v1.Lv > v2.Lv
					end
				else
					return v1.TotalPoint > v2.TotalPoint
				end
			else
				return vp1
			end
		else
			return v1.Vote > v2.Vote
		end
	end)

	local listData = {}
	lineCount = 2
	for i,v in ipairs(cloneList) do
		local a = math.floor((i - 1) / lineCount + 1)
		local b = math.floor((i - 1) % lineCount + 1)
		listData[a] = listData[a] or {}
		listData[a][b] = v
	end
	return listData
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGuildImpeach, "DGuildImpeach")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGuildImpeach", DGuildImpeach)


