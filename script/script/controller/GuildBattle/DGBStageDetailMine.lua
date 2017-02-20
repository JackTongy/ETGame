local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local LuaList = require "LuaList"
local gameFunc = require "AppData"
local netModel = require "netModel"
local GBHelper = require "GBHelper"

local DGBStageDetailMine = class(LuaDialog)

function DGBStageDetailMine:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGBStageDetailMine.cocos.zip")
    return self._factory:createDocument("DGBStageDetailMine.cocos")
end

--@@@@[[[[
function DGBStageDetailMine:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._root = set:getElfNode("root")
    self._root_kl_icon = set:getElfNode("root_kl_icon")
    self._root_kl_order = set:getElfNode("root_kl_order")
    self._root_kl_name = set:getLabelNode("root_kl_name")
    self._root_kl_btnChange = set:getClickNode("root_kl_btnChange")
    self._root_kl_btnChange_text = set:getLabelNode("root_kl_btnChange_text")
    self._root_kl_layoutGuildBelong_v = set:getLabelNode("root_kl_layoutGuildBelong_v")
    self._root_kl_layoutDefTeam_v = set:getLabelNode("root_kl_layoutDefTeam_v")
    self._root_kl_layoutDefBattleValue_v = set:getLabelNode("root_kl_layoutDefBattleValue_v")
    self._root_kl_stageAddPro = set:getLabelNode("root_kl_stageAddPro")
    self._root_kl_stageAddPro_layoutAddPro = set:getLayoutNode("root_kl_stageAddPro_layoutAddPro")
    self._root_kr_list = set:getListNode("root_kr_list")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._title = set:getLabelNode("title")
    self._layoutBattleValue = set:getLinearLayoutNode("layoutBattleValue")
    self._layoutBattleValue_v = set:getLabelNode("layoutBattleValue_v")
    self._checkbox = set:getCheckBoxNode("checkbox")
    self._state = set:getElfNode("state")
    self._btnRecover = set:getClickNode("btnRecover")
--    self._@pro = set:getLabelNode("@pro")
--    self._@pro = set:getLabelNode("@pro")
--    self._@pro = set:getLabelNode("@pro")
--    self._@pro = set:getLabelNode("@pro")
--    self._@teamItem = set:getElfNode("@teamItem")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DGBStageDetailMine", function ( userData )
	Launcher.callNet(netModel.getModelGuildMatchCastleDetails(userData.castle.CastleId, userData.castle.ServerId, userData.castle.GuildId),function ( data )
		if data and data.D then
			print("GuildMatchCastleDetails--------")
			print(data)
			Launcher.Launching(data) 
		end
	end)
end)

function DGBStageDetailMine:onInit( userData, netData )
	self.CastleBase = userData.castle
	self.CastleDetail = netData.D.Detail
	self.idleTeams = netData.D.MyTeams or {}

	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._root, self)
	end)

	require 'LangAdapter'.fontSize(self._root_kl_btnChange_text,nil,nil,nil,nil,16)
	self._root_kl_btnChange:setListener(function ( ... )
		local userId = gameFunc.getUserInfo().getId()
		local GuildInfo = gameFunc.getGuildInfo()
		local isPresidentOrVice = GuildInfo.isPresident(userId) or GuildInfo.isVicePresident(userId)
		if isPresidentOrVice then
			res.doActionDialogHide(self._root, self)
			GleeCore:showLayer("DGBChangeOrder", {castleId = self.CastleBase.CastleId})
		else
			self:toast(res.locString("GuildBattle$changeOrderFailTip"))
		end
	end)

	if userData.castle.CastleId == GBHelper.MidCastle then
		self._root_kl_icon:setScale(self._root_kl_icon:getScale() * 0.6)
	end
	self:updateLayer()

	res.doActionDialogShow(self._root)
end

function DGBStageDetailMine:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DGBStageDetailMine:updateLayer( ... )
	self._root_kl_icon:setResid( GBHelper.getGuildColorIcon(self.CastleBase.ServerId, self.CastleBase.GuildId, self.CastleBase.CastleId) )
	self._root_kl_order:setVisible( self.CastleDetail.CastleCmd > 0 )
	self._root_kl_name:setString(string.format(res.locString("GuildBattle$castleIndex"), self.CastleBase.CastleId))
	local cmdList = {"N_GHZ_gongji.png", "N_GHZ_fangyu.png", "N_GHZ_zhiyuan.png"}
	self._root_kl_order:setResid( cmdList[self.CastleDetail.CastleCmd])
	self._root_kl_layoutGuildBelong_v:setString( self.CastleDetail.GuildName )
	self._root_kl_layoutDefTeam_v:setString( string.format(res.locString("GuildBattle$teamCount"), self.CastleDetail.DefTeamCnt) )
	self._root_kl_layoutDefBattleValue_v:setString( self.CastleDetail.DefTeamPwr )
	self._root_kl_stageAddPro_layoutAddPro:removeAllChildrenWithCleanup(true)
	local tips = dbManager.getGuildMatchCastleConfig( self.CastleBase.CastleId ).Tips or {}
	local addition = 0
	if self.CastleDetail.CastleCmd == 2 then
		addition = addition + dbManager.getInfoDefaultConfig("GuildDefBuff").Value
	end
	if GBHelper.isCastleLineToCamp( self.CastleBase.CastleId, self.CastleBase.ServerId, self.CastleBase.GuildId ) then
		addition = addition + dbManager.getInfoDefaultConfig("GuildBaseBuff").Value
	end
	if addition > 0 then
		table.insert(tips, string.format(res.locString("GuildBattle$allPetsAtk"), addition))
		table.insert(tips, string.format(res.locString("GuildBattle$allPetsHp"), addition))
	end

	local sizeStageAddPro = self._root_kl_stageAddPro:getContentSize()
	self._root_kl_stageAddPro_layoutAddPro:setPosition(ccp(sizeStageAddPro.width * -0.5, -sizeStageAddPro.height))
	
	for i,v in ipairs(tips) do
		local proSet = self:createLuaSet("@pro")
		self._root_kl_stageAddPro_layoutAddPro:addChild(proSet[1])
		proSet[1]:setString(v)
		require 'LangAdapter'.selectLang(nil, nil, function ( ... )
			proSet[1]:setFontSize(18)
		end)
	end
	self._root_kl_btnChange:setEnabled( GBHelper.getMyCastleCanCmd( self.CastleBase ) and GBHelper.getMatchStatusWithSeconds() == GBHelper.MatchStatus.BattleArraySetting )
	
	self:updateList()
end

function DGBStageDetailMine:updateList( ... )
	if not self.itemList then
		self.itemList = LuaList.new(self._root_kr_list, function ( ... )
			return self:createLuaSet("@teamItem")
		end, function ( nodeLuaSet, data, index )	
			res.setNodeWithPet(nodeLuaSet["icon"], gameFunc.getPetInfo().getPetInfoByPetId(data.PetId, data.AwakeIndex))
			nodeLuaSet["title"]:setString(data.Name .. res.locString("GuildBattle$nameTeamConnect"))
			nodeLuaSet["layoutBattleValue_v"]:setString(data.Pwr)

			nodeLuaSet["checkbox"]:setVisible(data.status == "Def" or data.status == "Idle")
			nodeLuaSet["checkbox"]:setListener(function ( ... )
				-- body
			end)
			nodeLuaSet["checkbox"]:setStateSelected(data.status == "Def")
			nodeLuaSet["checkbox"]:setListener(function ( ... )
				if data.status == "Def" then
					self:send(netModel.getModelGuildMatchSendDefTeam( 0, data.TeamId, data.Rid ),function ( netData )
						if netData and netData.D then
							GBHelper.setGuildMatchPlayer(netData.D.Player)
							self.listData[index].status = "Idle"
							self.CastleDetail.DefTeamCnt = math.max(self.CastleDetail.DefTeamCnt - 1, 0)
							self.CastleDetail.DefTeamPwr = self.CastleDetail.DefTeamPwr - data.Pwr
							-- nodeLuaSet["checkbox"]:unregisterScriptHandler()
							-- self:updateLayer()
							self._root_kl_layoutDefTeam_v:setString( string.format(res.locString("GuildBattle$teamCount"), self.CastleDetail.DefTeamCnt) )
							self._root_kl_layoutDefBattleValue_v:setString( self.CastleDetail.DefTeamPwr )
							nodeLuaSet["state"]:setResid("N_GHZ_z1.png")
							nodeLuaSet["bg"]:setResid("N_GHZ_zr_k3.png")
						end
					end)
				elseif data.status == "Idle" then
					self:send(netModel.getModelGuildMatchSendDefTeam( self.CastleBase.CastleId, data.TeamId, data.Rid ),function ( netData )
						if netData and netData.D then
							print("MatchSendDefTeam")
							print(netData)
							GBHelper.setGuildMatchPlayer(netData.D.Player)
							self.listData[index].status = "Def"
							self.CastleDetail.DefTeamCnt = self.CastleDetail.DefTeamCnt + 1
							self.CastleDetail.DefTeamPwr = self.CastleDetail.DefTeamPwr + data.Pwr
							-- nodeLuaSet["checkbox"]:unregisterScriptHandler()
							-- self:updateLayer()
							self._root_kl_layoutDefTeam_v:setString( string.format(res.locString("GuildBattle$teamCount"), self.CastleDetail.DefTeamCnt) )
							self._root_kl_layoutDefBattleValue_v:setString( self.CastleDetail.DefTeamPwr )
							nodeLuaSet["state"]:setResid("N_GHZ_z2.png")
							nodeLuaSet["bg"]:setResid("N_GHZ_zr_k2.png")
						end
					end)
				end
			end)
			nodeLuaSet["state"]:setVisible(data.status ~= nil)
			nodeLuaSet["btnRecover"]:setListener(function ( ... )
				self:send(netModel.getModelGuildMatchRecover(), function ( data )
					if data and data.D then
						GBHelper.setGuildMatchPlayer( data.D.Player )

						local isInIdle = false
						for i,v in ipairs(self.idleTeams) do
							if v.Rid == gameFunc.getUserInfo().getId() and v.HpLeft <= 0 then
								self.idleTeams[i].HpLeft = 1	-- 大于0就行，刷新界面时会显示成空闲，而不是死亡
								isInIdle = true
								break
							end
						end
						if not isInIdle then
							if self.CastleDetail.DefTeams then
								for i,v in ipairs(self.CastleDetail.DefTeams) do
									if v.Rid == gameFunc.getUserInfo().getId() and v.HpLeft <= 0 then
										self.CastleDetail.DefTeams[i].HpLeft = 1	-- 大于0就行，刷新界面时会显示成空闲，而不是死亡
										break
									end
								end
							end
						end

						self:updateLayer()
					end
				end)
			end)
			if data.status == "Def" then
				nodeLuaSet["btnRecover"]:setVisible(false)
				nodeLuaSet["state"]:setResid("N_GHZ_z2.png")
				nodeLuaSet["bg"]:setResid("N_GHZ_zr_k2.png")
			elseif data.status == "Idle" then
				nodeLuaSet["btnRecover"]:setVisible(false)
				nodeLuaSet["state"]:setResid("N_GHZ_z1.png")
				nodeLuaSet["bg"]:setResid("N_GHZ_zr_k3.png")
			elseif data.status == "Dead" then
				local playerInfo = GBHelper.getGuildMatchPlayer()
				nodeLuaSet["btnRecover"]:setVisible(not playerInfo.Recovered)
				nodeLuaSet["state"]:setResid("N_GHZ_z3.png")
				nodeLuaSet["bg"]:setResid("N_GHZ_zr_k3.png")
			else
				nodeLuaSet["btnRecover"]:setVisible(false)
				nodeLuaSet["bg"]:setResid("N_GHZ_zr_k3.png")
			end
		end)
	end

	self:setListData()
	self.itemList:update( self.listData )
end

function DGBStageDetailMine:setListData( ... )
	local status = GBHelper.getMatchStatusWithSeconds()
	if status == GBHelper.MatchStatus.BattleArraySetting or status == GBHelper.MatchStatus.Fighting then
		-- if not GBHelper.getMyCastleCanCmd( self.CastleBase ) then
		-- 	self.listData = {}
		-- 	return
		-- end

		for i,v in ipairs(self.idleTeams) do
			self.idleTeams[i].status = "Idle"
		end
		self.listData = table.clone(self.idleTeams)
		if self.CastleDetail.DefTeams then
			if #self.CastleDetail.DefTeams > 0 then
				local userId = gameFunc.getUserInfo().getId()
				table.sort(self.CastleDetail.DefTeams, function ( v1, v2 )
					if v1.Rid == v2.Rid then
						return v1.TeamId < v2.TeamId
					else
						if v1.Rid == userId then
							return true
						elseif v2.Rid == userId then
							return false
						else
							return v1.Rid < v2.Rid
						end
					end
				end)
			end

			local userId = gameFunc.getUserInfo().getId()
			local isPresidentOrVice = gameFunc.getGuildInfo().isPresident(userId) or gameFunc.getGuildInfo().isVicePresident(userId)
			if isPresidentOrVice then
				for i,v in ipairs(self.CastleDetail.DefTeams) do
					self.CastleDetail.DefTeams[i].status = "Def"
				end
			else
				for i,v in ipairs(self.CastleDetail.DefTeams) do
					if v.Rid == userId then
						self.CastleDetail.DefTeams[i].status = "Def"
					end
				end		
			end

			table.insertTo(self.listData, self.CastleDetail.DefTeams)
		end
		for i,v in ipairs(self.listData) do
			if v.Rid == gameFunc.getUserInfo().getId() and v.HpLeft <= 0 then
				self.listData[i].status = "Dead"
			end
		end
	elseif status == GBHelper.MatchStatus.MatchBefore or status == GBHelper.MatchStatus.FightPrepare or status == GBHelper.MatchStatus.Dealing then
		self.listData = {}
		if self.CastleDetail.DefTeams and #self.CastleDetail.DefTeams > 0 then
			local userId = gameFunc.getUserInfo().getId()
			table.sort(self.CastleDetail.DefTeams, function ( v1, v2 )
				if v1.Rid == v2.Rid then
					return v1.TeamId < v2.TeamId
				else
					if v1.Rid == userId then
						return true
					elseif v2.Rid == userId then
						return false
					else
						return v1.Rid < v2.Rid
					end
				end
			end)
			self.listData = table.clone(self.CastleDetail.DefTeams)
		end
	else
		self.listData = {}
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGBStageDetailMine, "DGBStageDetailMine")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGBStageDetailMine", DGBStageDetailMine)


