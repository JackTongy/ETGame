local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local LuaList = require "LuaList"
local netModel = require "netModel"
local userFunc = require "UserInfo"

local DSeniorSevenDay = class(LuaDialog)

function DSeniorSevenDay:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DSeniorSevenDay.cocos.zip")
    return self._factory:createDocument("DSeniorSevenDay.cocos")
end

--@@@@[[[[
function DSeniorSevenDay:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_bg = set:getJoint9Node("commonDialog_cnt_bg")
    self._commonDialog_cnt_bg_list = set:getListNode("commonDialog_cnt_bg_list")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._icon_text = set:getLabelNode("icon_text")
    self._layoutReward = set:getLayoutNode("layoutReward")
    self._icon = set:getElfNode("icon")
    self._count = set:getLabelNode("count")
    self._name = set:getLabelNode("name")
    self._btn = set:getButtonNode("btn")
    self._btnGet = set:getClickNode("btnGet")
    self._commonDialog_cnt_bg_tip = set:getLabelNode("commonDialog_cnt_bg_tip")
    self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
    self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
--    self._@item = set:getElfNode("@item")
--    self._@rwd = set:getElfNode("@rwd")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DSeniorSevenDay:onInit( userData, netData )
	self:setListenerEvent()
	self:updateLayer()
	res.doActionDialogShow(self._commonDialog)
end

function DSeniorSevenDay:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DSeniorSevenDay:setListenerEvent( ... )
	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._commonDialog_btnClose:setListener(function (  )
		res.doActionDialogHide(self._commonDialog, self)
	end)
end

function DSeniorSevenDay:GoldFormat( Gold )
	if Gold >= 100000 then
		return string.format("%dK", Gold / 1000)
	else
		return tostring(Gold)
	end
end

function DSeniorSevenDay:updateLayer( ... )
	res.adjustNodeWidth(self._commonDialog_cnt_bg_tip, 700)

	if not self.list then
		self.list = LuaList.new(self._commonDialog_cnt_bg_list, function ( ... )
			return self:createLuaSet("@item")
		end, function ( nodeLuaSet, data )
			local Day = data.day
			nodeLuaSet["icon_text"]:setString(string.format(res.locString("Senior7D$whichDay"), Day))
		
			nodeLuaSet["layoutReward"]:removeAllChildrenWithCleanup(true)
			local rewardIds = dbManager.getInfoSeniorReturn7DRewardConfig(Day).RewardIds
			local rewardList = {}
			if rewardIds then
				for i,v in ipairs(rewardIds) do
					table.insert(rewardList, res.getDetailByDBReward( dbManager.getRewardItem(v) ))
				end
			end
			for i,v in ipairs(rewardList) do
				local set = self:createLuaSet("@rwd")
				nodeLuaSet["layoutReward"]:addChild(set[1])
				res.setNodeWithRewardData(v, set["icon"])
				set["count"]:setString("x" .. self:GoldFormat(v.count))
				set["name"]:setString(v.name)
				set["btn"]:setListener(function ( ... )
					if v.eventData then
						GleeCore:showLayer(v.eventData.dialog, v.eventData.data)
					end
				end)
				require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
					set["name"]:setVisible(false)
				end)
			end

			nodeLuaSet["btnGet"]:setEnabled(data.canGet)
			nodeLuaSet["btnGet"]:setListener(function ( ... )
				self:send(netModel.getModelSenior7DReward(Day), function ( data )
					if data and data.D then
						require "AppData".updateResource(data.D.Resource)
						res.doActionGetReward(data.D.Reward)
						userFunc.getData().Senior7D[Day] = 1
						
						local allGet = true
						for k,v in pairs(userFunc.getData().Senior7D) do
							if v ~= 1 then
								allGet = false
								break
							end
						end
						if allGet then
							require "EventCenter".eventInput("UpdateSeniorSevenDay")
							res.doActionDialogHide(self._commonDialog, self)
						else
							self:updateLayer()
						end
					end
				end)
			end)
			require "LangAdapter".fontSize(nodeLuaSet["btnGet_#text"],nil,nil,nil,nil,22)
		end)
	end

	local list = {}
	for i,v in ipairs(userFunc.getData().Senior7D) do
		if v ~= 1 then
			table.insert(list, {day = i, canGet = v == 0})
		end
	end
	self.list:update(list)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DSeniorSevenDay, "DSeniorSevenDay")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DSeniorSevenDay", DSeniorSevenDay)
