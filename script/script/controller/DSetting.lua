local Config = require "Config"
local res = require "Res"
local Utils = require 'framework.helper.Utils'
local notificationMapName = "notificationMap"
local MusicSettings = require 'MusicSettings'
local netModel = require "netModel"

local DSetting = class(LuaDialog)

function DSetting:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DSetting.cocos.zip")
    return self._factory:createDocument("DSetting.cocos")
end

--@@@@[[[[
function DSetting:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_bg = set:getJoint9Node("commonDialog_cnt_bg")
    self._commonDialog_cnt_bg_list = set:getListNode("commonDialog_cnt_bg_list")
    self._commonDialog_cnt_bg_list_container_item2 = set:getElfNode("commonDialog_cnt_bg_list_container_item2")
    self._commonDialog_cnt_bg_list_container_item2_title_text = set:getLabelNode("commonDialog_cnt_bg_list_container_item2_title_text")
    self._commonDialog_cnt_bg_list_container_item2_swMusic_title = set:getLabelNode("commonDialog_cnt_bg_list_container_item2_swMusic_title")
    self._commonDialog_cnt_bg_list_container_item2_swMusic_checkBox = set:getCheckBoxNode("commonDialog_cnt_bg_list_container_item2_swMusic_checkBox")
    self._commonDialog_cnt_bg_list_container_item2_swVoice_title = set:getLabelNode("commonDialog_cnt_bg_list_container_item2_swVoice_title")
    self._commonDialog_cnt_bg_list_container_item2_swVoice_checkBox = set:getCheckBoxNode("commonDialog_cnt_bg_list_container_item2_swVoice_checkBox")
    self._commonDialog_cnt_bg_list_container_item2_swBattleVoice_title = set:getLabelNode("commonDialog_cnt_bg_list_container_item2_swBattleVoice_title")
    self._commonDialog_cnt_bg_list_container_item2_swBattleVoice_checkBox = set:getCheckBoxNode("commonDialog_cnt_bg_list_container_item2_swBattleVoice_checkBox")
    self._commonDialog_cnt_bg_list_container_item3 = set:getElfNode("commonDialog_cnt_bg_list_container_item3")
    self._commonDialog_cnt_bg_list_container_item3_title_text = set:getLabelNode("commonDialog_cnt_bg_list_container_item3_title_text")
    self._commonDialog_cnt_bg_list_container_item3_swPushMessage_title = set:getLabelNode("commonDialog_cnt_bg_list_container_item3_swPushMessage_title")
    self._commonDialog_cnt_bg_list_container_item3_swPushMessage_checkBox = set:getCheckBoxNode("commonDialog_cnt_bg_list_container_item3_swPushMessage_checkBox")
    self._commonDialog_cnt_bg_list_container_item3_swPushApRec_title = set:getLabelNode("commonDialog_cnt_bg_list_container_item3_swPushApRec_title")
    self._commonDialog_cnt_bg_list_container_item3_swPushApRec_checkBox = set:getCheckBoxNode("commonDialog_cnt_bg_list_container_item3_swPushApRec_checkBox")
    self._commonDialog_cnt_bg_list_container_item3_swPushApFull_title = set:getLabelNode("commonDialog_cnt_bg_list_container_item3_swPushApFull_title")
    self._commonDialog_cnt_bg_list_container_item3_swPushApFull_checkBox = set:getCheckBoxNode("commonDialog_cnt_bg_list_container_item3_swPushApFull_checkBox")
    self._commonDialog_cnt_bg_list_container_item3_swPushBossBattle_title = set:getLabelNode("commonDialog_cnt_bg_list_container_item3_swPushBossBattle_title")
    self._commonDialog_cnt_bg_list_container_item3_swPushBossBattle_checkBox = set:getCheckBoxNode("commonDialog_cnt_bg_list_container_item3_swPushBossBattle_checkBox")
    self._commonDialog_cnt_bg_list_container_item3_swPushBestBossInvite_title = set:getLabelNode("commonDialog_cnt_bg_list_container_item3_swPushBestBossInvite_title")
    self._commonDialog_cnt_bg_list_container_item3_swPushBestBossInvite_checkBox = set:getCheckBoxNode("commonDialog_cnt_bg_list_container_item3_swPushBestBossInvite_checkBox")
    self._commonDialog_cnt_bg_list_container_item3_swPushFriendMail_title = set:getLabelNode("commonDialog_cnt_bg_list_container_item3_swPushFriendMail_title")
    self._commonDialog_cnt_bg_list_container_item3_swPushFriendMail_checkBox = set:getCheckBoxNode("commonDialog_cnt_bg_list_container_item3_swPushFriendMail_checkBox")
    self._commonDialog_cnt_bg_list_container_item3_swPushExplorationOver_title = set:getLabelNode("commonDialog_cnt_bg_list_container_item3_swPushExplorationOver_title")
    self._commonDialog_cnt_bg_list_container_item3_swPushExplorationOver_checkBox = set:getCheckBoxNode("commonDialog_cnt_bg_list_container_item3_swPushExplorationOver_checkBox")
    self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
    self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DSetting:onInit( userData, netData )
	self:setListenerEvent()
	self:updateLayer()
	res.doActionDialogShow(self._commonDialog)
	
	self.close = function ( ... )
		local notificationMap = Utils.readTableFromFile(notificationMapName)
		if notificationMap then
			self:send(netModel.getModelRoleSwitchPush(
				notificationMap.notify_PushMessage,
				notificationMap.notify_PushFriendMail,
				notificationMap.notify_PushApRec,
				notificationMap.notify_PushApFull,
				notificationMap.notify_PushBossBattle,
				notificationMap.notify_PushBestBossInvite,
				notificationMap.notify_PushExplorationOver
				))
		end
	end

	self:sendBackground(netModel.getModelRolePushInfo(), function ( data )
		if data and data.D then
			local notificationMap = Utils.readTableFromFile(notificationMapName)
			if notificationMap then
				notificationMap.notify_PushMessage = data.D.CanDo
				notificationMap.notify_PushApRec = data.D.Ap
				notificationMap.notify_PushApFull = data.D.Ap2
				notificationMap.notify_PushBossBattle = data.D.Ba
				notificationMap.notify_PushBestBossInvite = data.D.Bt
				notificationMap.notify_PushFriendMail = data.D.Lt
				notificationMap.notify_PushExplorationOver = data.D.Exr
				Utils.writeTableToFile(notificationMap, notificationMapName)

				self:updateLayer()
			end
		end
	end)

	require 'LangAdapter'.selectLang(nil, nil, function ( ... )
		local csize = CCSize(160, 0)
		self._commonDialog_cnt_bg_list_container_item2_title_text:setFontSize(24)
		self._commonDialog_cnt_bg_list_container_item3_title_text:setFontSize(24)

		self._commonDialog_cnt_bg_list_container_item2_swMusic_title:setFontSize(22)
		self._commonDialog_cnt_bg_list_container_item2_swVoice_title:setFontSize(22)
		self._commonDialog_cnt_bg_list_container_item2_swBattleVoice_title:setFontSize(22)
		self._commonDialog_cnt_bg_list_container_item3_swPushMessage_title:setFontSize(22)
		self._commonDialog_cnt_bg_list_container_item3_swPushApRec_title:setFontSize(22)
		self._commonDialog_cnt_bg_list_container_item3_swPushApFull_title:setFontSize(22)
		self._commonDialog_cnt_bg_list_container_item3_swPushBossBattle_title:setFontSize(22)
		self._commonDialog_cnt_bg_list_container_item3_swPushBestBossInvite_title:setFontSize(22)
		self._commonDialog_cnt_bg_list_container_item3_swPushFriendMail_title:setFontSize(22)
		self._commonDialog_cnt_bg_list_container_item3_swPushExplorationOver_title:setFontSize(22)

		self._commonDialog_cnt_bg_list_container_item2_swMusic_title:setDimensions(csize)
		self._commonDialog_cnt_bg_list_container_item2_swVoice_title:setDimensions(csize)
		self._commonDialog_cnt_bg_list_container_item2_swBattleVoice_title:setDimensions(csize)
		self._commonDialog_cnt_bg_list_container_item3_swPushMessage_title:setDimensions(csize)
		self._commonDialog_cnt_bg_list_container_item3_swPushApRec_title:setDimensions(csize)
		self._commonDialog_cnt_bg_list_container_item3_swPushApFull_title:setDimensions(csize)
		self._commonDialog_cnt_bg_list_container_item3_swPushBossBattle_title:setDimensions(csize)
		self._commonDialog_cnt_bg_list_container_item3_swPushBestBossInvite_title:setDimensions(csize)
		self._commonDialog_cnt_bg_list_container_item3_swPushFriendMail_title:setDimensions(csize)
		self._commonDialog_cnt_bg_list_container_item3_swPushExplorationOver_title:setDimensions(csize)
	end)
end

function DSetting:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
--[[
MusicSettings.setUISoundEnabled(enabled)
MusicSettings.getUISoundEnabled()
MusicSettings.setMusicEnabled(enabled)
MusicSettings.getMusicEnabled()
MusicSettings.setBattleVoiceEnabled(enabled)
MusicSettings.getBattleVoiceEnabled()
--]]

function DSetting:setListenerEvent(  )
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._commonDialog_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)
	
	self._commonDialog_cnt_bg_list_container_item2_swMusic_checkBox:setListener(function ( ... )
		local notificationMap = Utils.readTableFromFile(notificationMapName)
	--	notificationMap.notify_Music = not notificationMap.notify_Music
		notificationMap.notify_Music = self._commonDialog_cnt_bg_list_container_item2_swMusic_checkBox:getStateSelected()
		Utils.writeTableToFile(notificationMap, notificationMapName)

		MusicSettings.setMusicEnabled(notificationMap.notify_Music)
	end)

	self._commonDialog_cnt_bg_list_container_item2_swVoice_checkBox:setListener(function ( ... )
		local notificationMap = Utils.readTableFromFile(notificationMapName)
	--	notificationMap.notify_Voice = not notificationMap.notify_Voice
		notificationMap.notify_Voice = self._commonDialog_cnt_bg_list_container_item2_swVoice_checkBox:getStateSelected()
		Utils.writeTableToFile(notificationMap, notificationMapName)

		MusicSettings.setUISoundEnabled(notificationMap.notify_Voice)

		MusicSettings.flush()

		if not notificationMap.notify_Voice then
			self._commonDialog_cnt_bg_list_container_item2_swBattleVoice_checkBox:setStateSelected(false)
		end
	end)

	self._commonDialog_cnt_bg_list_container_item2_swBattleVoice_checkBox:setListener(function ( ... )
		local notificationMap = Utils.readTableFromFile(notificationMapName)
	--	notificationMap.notify_BattleVoice = not notificationMap.notify_BattleVoice
		notificationMap.notify_BattleVoice = self._commonDialog_cnt_bg_list_container_item2_swBattleVoice_checkBox:getStateSelected()
		Utils.writeTableToFile(notificationMap, notificationMapName)

		MusicSettings.setBattleVoiceEnabled(notificationMap.notify_BattleVoice)

		if notificationMap.notify_BattleVoice then
			self._commonDialog_cnt_bg_list_container_item2_swVoice_checkBox:setStateSelected(true)
		end
	end)

	self._commonDialog_cnt_bg_list_container_item3_swPushMessage_checkBox:setListener(function ( ... )
		local notificationMap = Utils.readTableFromFile(notificationMapName)
	--	notificationMap.notify_PushMessage = not notificationMap.notify_PushMessage
		notificationMap.notify_PushMessage = self._commonDialog_cnt_bg_list_container_item3_swPushMessage_checkBox:getStateSelected()
		Utils.writeTableToFile(notificationMap, notificationMapName)
	end)

	self._commonDialog_cnt_bg_list_container_item3_swPushApRec_checkBox:setListener(function ( ... )
		local notificationMap = Utils.readTableFromFile(notificationMapName)
	--	notificationMap.notify_PushApRec = not notificationMap.notify_PushApRec
		notificationMap.notify_PushApRec = self._commonDialog_cnt_bg_list_container_item3_swPushApRec_checkBox:getStateSelected()
		Utils.writeTableToFile(notificationMap, notificationMapName)
	end)

	self._commonDialog_cnt_bg_list_container_item3_swPushApFull_checkBox:setListener(function ( ... )
		local notificationMap = Utils.readTableFromFile(notificationMapName)
	--	notificationMap.notify_PushApFull = not notificationMap.notify_PushApFull
		notificationMap.notify_PushApFull = self._commonDialog_cnt_bg_list_container_item3_swPushApFull_checkBox:getStateSelected()
		Utils.writeTableToFile(notificationMap, notificationMapName)
	end)

	self._commonDialog_cnt_bg_list_container_item3_swPushBossBattle_checkBox:setListener(function ( ... )
		local notificationMap = Utils.readTableFromFile(notificationMapName)
	--	notificationMap.notify_PushBossBattle = not notificationMap.notify_PushBossBattle
		notificationMap.notify_PushBossBattle = self._commonDialog_cnt_bg_list_container_item3_swPushBossBattle_checkBox:getStateSelected()
		Utils.writeTableToFile(notificationMap, notificationMapName)
	end)

	self._commonDialog_cnt_bg_list_container_item3_swPushBestBossInvite_checkBox:setListener(function ( ... )
		local notificationMap = Utils.readTableFromFile(notificationMapName)
	--	notificationMap.notify_PushBestBossInvite = not notificationMap.notify_PushBestBossInvite
		notificationMap.notify_PushBestBossInvite = self._commonDialog_cnt_bg_list_container_item3_swPushBestBossInvite_checkBox:getStateSelected()
		Utils.writeTableToFile(notificationMap, notificationMapName)
	end)

	self._commonDialog_cnt_bg_list_container_item3_swPushFriendMail_checkBox:setListener(function ( ... )
		local notificationMap = Utils.readTableFromFile(notificationMapName)
	--	notificationMap.notify_PushFriendMail = not notificationMap.notify_PushFriendMail
		notificationMap.notify_PushFriendMail = self._commonDialog_cnt_bg_list_container_item3_swPushFriendMail_checkBox:getStateSelected()
		Utils.writeTableToFile(notificationMap, notificationMapName)
	end)

	self._commonDialog_cnt_bg_list_container_item3_swPushExplorationOver_checkBox:setListener(function ( ... )
		local notificationMap = Utils.readTableFromFile(notificationMapName)
	--	notificationMap.notify_PushExplorationOver = not notificationMap.notify_PushExplorationOver
		notificationMap.notify_PushExplorationOver = self._commonDialog_cnt_bg_list_container_item3_swPushExplorationOver_checkBox:getStateSelected()
		Utils.writeTableToFile(notificationMap, notificationMapName)
	end)
end

function DSetting:updateLayer( ... )
	local notificationMap = Utils.readTableFromFile(notificationMapName)
	if not notificationMap then
		notificationMap = {}
		notificationMap.notify_Music = true
		notificationMap.notify_Voice = true
		notificationMap.notify_BattleVoice = true
		notificationMap.notify_PushMessage = true
		notificationMap.notify_PushApRec = true
		notificationMap.notify_PushApFull = true
		notificationMap.notify_PushBossBattle = true
		notificationMap.notify_PushBestBossInvite = true
		notificationMap.notify_PushFriendMail = true
		notificationMap.notify_PushExplorationOver = true
		Utils.writeTableToFile(notificationMap, notificationMapName)
	end

	self._commonDialog_cnt_bg_list_container_item2_swMusic_checkBox:setStateSelected(notificationMap.notify_Music)
	self._commonDialog_cnt_bg_list_container_item2_swVoice_checkBox:setStateSelected(notificationMap.notify_Voice)
	self._commonDialog_cnt_bg_list_container_item2_swBattleVoice_checkBox:setStateSelected(notificationMap.notify_BattleVoice)
	self._commonDialog_cnt_bg_list_container_item3_swPushMessage_checkBox:setStateSelected(notificationMap.notify_PushMessage)
	self._commonDialog_cnt_bg_list_container_item3_swPushApRec_checkBox:setStateSelected(notificationMap.notify_PushApRec)
	self._commonDialog_cnt_bg_list_container_item3_swPushApFull_checkBox:setStateSelected(notificationMap.notify_PushApFull)
	self._commonDialog_cnt_bg_list_container_item3_swPushBossBattle_checkBox:setStateSelected(notificationMap.notify_PushBossBattle)
	self._commonDialog_cnt_bg_list_container_item3_swPushBestBossInvite_checkBox:setStateSelected(notificationMap.notify_PushBestBossInvite)
	self._commonDialog_cnt_bg_list_container_item3_swPushFriendMail_checkBox:setStateSelected(notificationMap.notify_PushFriendMail)
	self._commonDialog_cnt_bg_list_container_item3_swPushExplorationOver_checkBox:setStateSelected(notificationMap.notify_PushExplorationOver)

	self._commonDialog_cnt_bg_list:layout()
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DSetting, "DSetting")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DSetting", DSetting)


