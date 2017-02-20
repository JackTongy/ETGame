local Config = require "Config"
local GBHelper = require "GBHelper"
local EventCenter = require "EventCenter"
local netModel = require "netModel"
local res = require "Res"
local dbManager = require "DBManager"
local gameFunc = require "AppData"
local GuildInfo = require "GuildInfo"

local CGBMain = class(LuaController)

function CGBMain:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."CGBMain.cocos.zip")
    return self._factory:createDocument("CGBMain.cocos")
end

--@@@@[[[[
function CGBMain:onInitXML()
	local set = self._set
    self._root = set:getElfNode("root")
    self._root_mapNode = set:getElfNode("root_mapNode")
    self._root_mapNode_btnStage10 = set:getClickNode("root_mapNode_btnStage10")
    self._root_mapNode_btnStage10_normal = set:getElfNode("root_mapNode_btnStage10_normal")
    self._root_mapNode_btnStage10_pressed = set:getElfNode("root_mapNode_btnStage10_pressed")
    self._root_mapNode_btnStage10_invalid = set:getElfNode("root_mapNode_btnStage10_invalid")
    self._root_mapNode_btnStage10_orderBase = set:getElfNode("root_mapNode_btnStage10_orderBase")
    self._root_mapNode_btnStage10_orderBase2 = set:getElfNode("root_mapNode_btnStage10_orderBase2")
    self._root_mapNode_btnStage11 = set:getClickNode("root_mapNode_btnStage11")
    self._root_mapNode_btnStage11_normal = set:getElfNode("root_mapNode_btnStage11_normal")
    self._root_mapNode_btnStage11_pressed = set:getElfNode("root_mapNode_btnStage11_pressed")
    self._root_mapNode_btnStage11_invalid = set:getElfNode("root_mapNode_btnStage11_invalid")
    self._root_mapNode_btnStage11_orderBase = set:getElfNode("root_mapNode_btnStage11_orderBase")
    self._root_mapNode_btnStage11_orderBase2 = set:getElfNode("root_mapNode_btnStage11_orderBase2")
    self._root_mapNode_btnStage12 = set:getClickNode("root_mapNode_btnStage12")
    self._root_mapNode_btnStage12_normal = set:getElfNode("root_mapNode_btnStage12_normal")
    self._root_mapNode_btnStage12_pressed = set:getElfNode("root_mapNode_btnStage12_pressed")
    self._root_mapNode_btnStage12_invalid = set:getElfNode("root_mapNode_btnStage12_invalid")
    self._root_mapNode_btnStage12_orderBase = set:getElfNode("root_mapNode_btnStage12_orderBase")
    self._root_mapNode_btnStage12_orderBase2 = set:getElfNode("root_mapNode_btnStage12_orderBase2")
    self._root_mapNode_btnStage13 = set:getClickNode("root_mapNode_btnStage13")
    self._root_mapNode_btnStage13_normal = set:getElfNode("root_mapNode_btnStage13_normal")
    self._root_mapNode_btnStage13_pressed = set:getElfNode("root_mapNode_btnStage13_pressed")
    self._root_mapNode_btnStage13_invalid = set:getElfNode("root_mapNode_btnStage13_invalid")
    self._root_mapNode_btnStage13_orderBase = set:getElfNode("root_mapNode_btnStage13_orderBase")
    self._hp2 = set:getProgressNode("hp2")
    self._root_mapNode_btnStage13_orderBase2 = set:getElfNode("root_mapNode_btnStage13_orderBase2")
    self._root_mapNode_btnStage14 = set:getClickNode("root_mapNode_btnStage14")
    self._root_mapNode_btnStage14_normal = set:getElfNode("root_mapNode_btnStage14_normal")
    self._root_mapNode_btnStage14_pressed = set:getElfNode("root_mapNode_btnStage14_pressed")
    self._root_mapNode_btnStage14_invalid = set:getElfNode("root_mapNode_btnStage14_invalid")
    self._root_mapNode_btnStage14_orderBase = set:getElfNode("root_mapNode_btnStage14_orderBase")
    self._root_mapNode_btnStage14_orderBase2 = set:getElfNode("root_mapNode_btnStage14_orderBase2")
    self._root_mapNode_btnStage15 = set:getClickNode("root_mapNode_btnStage15")
    self._root_mapNode_btnStage15_normal = set:getElfNode("root_mapNode_btnStage15_normal")
    self._root_mapNode_btnStage15_pressed = set:getElfNode("root_mapNode_btnStage15_pressed")
    self._root_mapNode_btnStage15_invalid = set:getElfNode("root_mapNode_btnStage15_invalid")
    self._root_mapNode_btnStage15_orderBase = set:getElfNode("root_mapNode_btnStage15_orderBase")
    self._root_mapNode_btnStage15_orderBase2 = set:getElfNode("root_mapNode_btnStage15_orderBase2")
    self._root_mapNode_btnStage16 = set:getClickNode("root_mapNode_btnStage16")
    self._root_mapNode_btnStage16_normal = set:getElfNode("root_mapNode_btnStage16_normal")
    self._root_mapNode_btnStage16_pressed = set:getElfNode("root_mapNode_btnStage16_pressed")
    self._root_mapNode_btnStage16_invalid = set:getElfNode("root_mapNode_btnStage16_invalid")
    self._root_mapNode_btnStage16_orderBase = set:getElfNode("root_mapNode_btnStage16_orderBase")
    self._root_mapNode_btnStage16_orderBase2 = set:getElfNode("root_mapNode_btnStage16_orderBase2")
    self._root_mapNode_btnStage17 = set:getClickNode("root_mapNode_btnStage17")
    self._root_mapNode_btnStage17_normal = set:getElfNode("root_mapNode_btnStage17_normal")
    self._root_mapNode_btnStage17_pressed = set:getElfNode("root_mapNode_btnStage17_pressed")
    self._root_mapNode_btnStage17_invalid = set:getElfNode("root_mapNode_btnStage17_invalid")
    self._root_mapNode_btnStage17_orderBase = set:getElfNode("root_mapNode_btnStage17_orderBase")
    self._root_mapNode_btnStage17_orderBase2 = set:getElfNode("root_mapNode_btnStage17_orderBase2")
    self._root_mapNode_btnStage20 = set:getClickNode("root_mapNode_btnStage20")
    self._root_mapNode_btnStage20_normal = set:getElfNode("root_mapNode_btnStage20_normal")
    self._root_mapNode_btnStage20_pressed = set:getElfNode("root_mapNode_btnStage20_pressed")
    self._root_mapNode_btnStage20_invalid = set:getElfNode("root_mapNode_btnStage20_invalid")
    self._root_mapNode_btnStage20_orderBase = set:getElfNode("root_mapNode_btnStage20_orderBase")
    self._root_mapNode_btnStage20_orderBase2 = set:getElfNode("root_mapNode_btnStage20_orderBase2")
    self._root_mapNode_btnStage21 = set:getClickNode("root_mapNode_btnStage21")
    self._root_mapNode_btnStage21_normal = set:getElfNode("root_mapNode_btnStage21_normal")
    self._root_mapNode_btnStage21_pressed = set:getElfNode("root_mapNode_btnStage21_pressed")
    self._root_mapNode_btnStage21_invalid = set:getElfNode("root_mapNode_btnStage21_invalid")
    self._root_mapNode_btnStage21_orderBase = set:getElfNode("root_mapNode_btnStage21_orderBase")
    self._root_mapNode_btnStage21_orderBase2 = set:getElfNode("root_mapNode_btnStage21_orderBase2")
    self._root_mapNode_btnStage22 = set:getClickNode("root_mapNode_btnStage22")
    self._root_mapNode_btnStage22_normal = set:getElfNode("root_mapNode_btnStage22_normal")
    self._root_mapNode_btnStage22_pressed = set:getElfNode("root_mapNode_btnStage22_pressed")
    self._root_mapNode_btnStage22_invalid = set:getElfNode("root_mapNode_btnStage22_invalid")
    self._root_mapNode_btnStage22_orderBase = set:getElfNode("root_mapNode_btnStage22_orderBase")
    self._root_mapNode_btnStage22_orderBase2 = set:getElfNode("root_mapNode_btnStage22_orderBase2")
    self._root_mapNode_btnStage23 = set:getClickNode("root_mapNode_btnStage23")
    self._root_mapNode_btnStage23_normal = set:getElfNode("root_mapNode_btnStage23_normal")
    self._root_mapNode_btnStage23_pressed = set:getElfNode("root_mapNode_btnStage23_pressed")
    self._root_mapNode_btnStage23_invalid = set:getElfNode("root_mapNode_btnStage23_invalid")
    self._root_mapNode_btnStage23_orderBase = set:getElfNode("root_mapNode_btnStage23_orderBase")
    self._root_mapNode_btnStage23_orderBase2 = set:getElfNode("root_mapNode_btnStage23_orderBase2")
    self._root_mapNode_btnStage24 = set:getClickNode("root_mapNode_btnStage24")
    self._root_mapNode_btnStage24_normal = set:getElfNode("root_mapNode_btnStage24_normal")
    self._root_mapNode_btnStage24_pressed = set:getElfNode("root_mapNode_btnStage24_pressed")
    self._root_mapNode_btnStage24_invalid = set:getElfNode("root_mapNode_btnStage24_invalid")
    self._root_mapNode_btnStage24_orderBase = set:getElfNode("root_mapNode_btnStage24_orderBase")
    self._root_mapNode_btnStage24_orderBase2 = set:getElfNode("root_mapNode_btnStage24_orderBase2")
    self._root_mapNode_btnStage25 = set:getClickNode("root_mapNode_btnStage25")
    self._root_mapNode_btnStage25_normal = set:getElfNode("root_mapNode_btnStage25_normal")
    self._root_mapNode_btnStage25_pressed = set:getElfNode("root_mapNode_btnStage25_pressed")
    self._root_mapNode_btnStage25_invalid = set:getElfNode("root_mapNode_btnStage25_invalid")
    self._root_mapNode_btnStage25_orderBase = set:getElfNode("root_mapNode_btnStage25_orderBase")
    self._root_mapNode_btnStage25_orderBase2 = set:getElfNode("root_mapNode_btnStage25_orderBase2")
    self._root_mapNode_btnStage26 = set:getClickNode("root_mapNode_btnStage26")
    self._root_mapNode_btnStage26_normal = set:getElfNode("root_mapNode_btnStage26_normal")
    self._root_mapNode_btnStage26_pressed = set:getElfNode("root_mapNode_btnStage26_pressed")
    self._root_mapNode_btnStage26_invalid = set:getElfNode("root_mapNode_btnStage26_invalid")
    self._root_mapNode_btnStage26_orderBase = set:getElfNode("root_mapNode_btnStage26_orderBase")
    self._root_mapNode_btnStage26_orderBase2 = set:getElfNode("root_mapNode_btnStage26_orderBase2")
    self._root_mapNode_btnStage27 = set:getClickNode("root_mapNode_btnStage27")
    self._root_mapNode_btnStage27_normal = set:getElfNode("root_mapNode_btnStage27_normal")
    self._root_mapNode_btnStage27_pressed = set:getElfNode("root_mapNode_btnStage27_pressed")
    self._root_mapNode_btnStage27_invalid = set:getElfNode("root_mapNode_btnStage27_invalid")
    self._root_mapNode_btnStage27_orderBase = set:getElfNode("root_mapNode_btnStage27_orderBase")
    self._root_mapNode_btnStage27_orderBase2 = set:getElfNode("root_mapNode_btnStage27_orderBase2")
    self._root_mapNode_btnStage30 = set:getClickNode("root_mapNode_btnStage30")
    self._root_mapNode_btnStage30_normal = set:getElfNode("root_mapNode_btnStage30_normal")
    self._root_mapNode_btnStage30_pressed = set:getElfNode("root_mapNode_btnStage30_pressed")
    self._root_mapNode_btnStage30_invalid = set:getElfNode("root_mapNode_btnStage30_invalid")
    self._root_mapNode_btnStage30_orderBase = set:getElfNode("root_mapNode_btnStage30_orderBase")
    self._root_mapNode_btnStage30_orderBase2 = set:getElfNode("root_mapNode_btnStage30_orderBase2")
    self._root_mapNode_btnStage31 = set:getClickNode("root_mapNode_btnStage31")
    self._root_mapNode_btnStage31_normal = set:getElfNode("root_mapNode_btnStage31_normal")
    self._root_mapNode_btnStage31_pressed = set:getElfNode("root_mapNode_btnStage31_pressed")
    self._root_mapNode_btnStage31_invalid = set:getElfNode("root_mapNode_btnStage31_invalid")
    self._root_mapNode_btnStage31_orderBase = set:getElfNode("root_mapNode_btnStage31_orderBase")
    self._root_mapNode_btnStage31_orderBase2 = set:getElfNode("root_mapNode_btnStage31_orderBase2")
    self._root_mapNode_btnStage32 = set:getClickNode("root_mapNode_btnStage32")
    self._root_mapNode_btnStage32_normal = set:getElfNode("root_mapNode_btnStage32_normal")
    self._root_mapNode_btnStage32_pressed = set:getElfNode("root_mapNode_btnStage32_pressed")
    self._root_mapNode_btnStage32_invalid = set:getElfNode("root_mapNode_btnStage32_invalid")
    self._root_mapNode_btnStage32_orderBase = set:getElfNode("root_mapNode_btnStage32_orderBase")
    self._root_mapNode_btnStage32_orderBase2 = set:getElfNode("root_mapNode_btnStage32_orderBase2")
    self._root_mapNode_btnStage33 = set:getClickNode("root_mapNode_btnStage33")
    self._root_mapNode_btnStage33_normal = set:getElfNode("root_mapNode_btnStage33_normal")
    self._root_mapNode_btnStage33_pressed = set:getElfNode("root_mapNode_btnStage33_pressed")
    self._root_mapNode_btnStage33_invalid = set:getElfNode("root_mapNode_btnStage33_invalid")
    self._root_mapNode_btnStage33_orderBase = set:getElfNode("root_mapNode_btnStage33_orderBase")
    self._root_mapNode_btnStage33_orderBase2 = set:getElfNode("root_mapNode_btnStage33_orderBase2")
    self._root_mapNode_btnStage34 = set:getClickNode("root_mapNode_btnStage34")
    self._root_mapNode_btnStage34_normal = set:getElfNode("root_mapNode_btnStage34_normal")
    self._root_mapNode_btnStage34_pressed = set:getElfNode("root_mapNode_btnStage34_pressed")
    self._root_mapNode_btnStage34_invalid = set:getElfNode("root_mapNode_btnStage34_invalid")
    self._root_mapNode_btnStage34_orderBase = set:getElfNode("root_mapNode_btnStage34_orderBase")
    self._root_mapNode_btnStage34_orderBase2 = set:getElfNode("root_mapNode_btnStage34_orderBase2")
    self._root_mapNode_btnStage35 = set:getClickNode("root_mapNode_btnStage35")
    self._root_mapNode_btnStage35_normal = set:getElfNode("root_mapNode_btnStage35_normal")
    self._root_mapNode_btnStage35_pressed = set:getElfNode("root_mapNode_btnStage35_pressed")
    self._root_mapNode_btnStage35_invalid = set:getElfNode("root_mapNode_btnStage35_invalid")
    self._root_mapNode_btnStage35_orderBase = set:getElfNode("root_mapNode_btnStage35_orderBase")
    self._root_mapNode_btnStage35_orderBase2 = set:getElfNode("root_mapNode_btnStage35_orderBase2")
    self._root_mapNode_btnStage36 = set:getClickNode("root_mapNode_btnStage36")
    self._root_mapNode_btnStage36_normal = set:getElfNode("root_mapNode_btnStage36_normal")
    self._root_mapNode_btnStage36_pressed = set:getElfNode("root_mapNode_btnStage36_pressed")
    self._root_mapNode_btnStage36_invalid = set:getElfNode("root_mapNode_btnStage36_invalid")
    self._root_mapNode_btnStage36_orderBase = set:getElfNode("root_mapNode_btnStage36_orderBase")
    self._root_mapNode_btnStage36_orderBase2 = set:getElfNode("root_mapNode_btnStage36_orderBase2")
    self._root_mapNode_btnStage37 = set:getClickNode("root_mapNode_btnStage37")
    self._root_mapNode_btnStage37_normal = set:getElfNode("root_mapNode_btnStage37_normal")
    self._root_mapNode_btnStage37_pressed = set:getElfNode("root_mapNode_btnStage37_pressed")
    self._root_mapNode_btnStage37_invalid = set:getElfNode("root_mapNode_btnStage37_invalid")
    self._root_mapNode_btnStage37_orderBase = set:getElfNode("root_mapNode_btnStage37_orderBase")
    self._root_mapNode_btnStage37_orderBase2 = set:getElfNode("root_mapNode_btnStage37_orderBase2")
    self._root_mapNode_btnStage1 = set:getClickNode("root_mapNode_btnStage1")
    self._root_mapNode_btnStage1_normal = set:getElfNode("root_mapNode_btnStage1_normal")
    self._root_mapNode_btnStage1_pressed = set:getElfNode("root_mapNode_btnStage1_pressed")
    self._root_mapNode_btnStage1_invalid = set:getElfNode("root_mapNode_btnStage1_invalid")
    self._root_mapNode_btnStage1_orderBase = set:getElfNode("root_mapNode_btnStage1_orderBase")
    self._k_timer = set:getProgressNode("k_timer")
    self._root_mapNode_btnStage1_orderBase2 = set:getElfNode("root_mapNode_btnStage1_orderBase2")
    self._root_matchCountDown = set:getLinearLayoutNode("root_matchCountDown")
    self._root_matchCountDown_v1 = set:getLabelNode("root_matchCountDown_v1")
    self._root_matchCountDown_timer = set:getTimeNode("root_matchCountDown_timer")
    self._root_challengeCountDown = set:getLinearLayoutNode("root_challengeCountDown")
    self._root_challengeCountDown_v1 = set:getLabelNode("root_challengeCountDown_v1")
    self._root_challengeCountDown_timer = set:getTimeNode("root_challengeCountDown_timer")
    self._root_ylayout = set:getLayoutNode("root_ylayout")
    self._btn = set:getButtonNode("btn")
    self._layout = set:getLinearLayoutNode("layout")
    self._layout_text = set:getLabelNode("layout_text")
    self._layout_iii = set:getElfNode("layout_iii")
    self._c = set:getLabelNode("c")
    self._root_btnHelp = set:getButtonNode("root_btnHelp")
    self._root_btnClose = set:getButtonNode("root_btnClose")
    self._root_btnReport = set:getButtonNode("root_btnReport")
    self._root_btnTroop = set:getButtonNode("root_btnTroop")
    self._root_btnTroop_title = set:getLabelNode("root_btnTroop_title")
    self._root_btnShop = set:getButtonNode("root_btnShop")
    self._root_btnShop_title = set:getLabelNode("root_btnShop_title")
    self._root_btnChallenge = set:getButtonNode("root_btnChallenge")
    self._root_btnChallenge_hight = set:getFlashMainNode("root_btnChallenge_hight")
    self._root_btnChallenge_hight_root = set:getElfNode("root_btnChallenge_hight_root")
    self._root_btnChallenge_title = set:getLabelNode("root_btnChallenge_title")
    self._root_btnMatchStatus = set:getButtonNode("root_btnMatchStatus")
    self._root_btnMatchStatus_title = set:getLabelNode("root_btnMatchStatus_title")
    self._root_btnGBReward = set:getButtonNode("root_btnGBReward")
    self._root_btnGBReward_icon = set:getElfNode("root_btnGBReward_icon")
    self._root_btnGBReward_animation = set:getSimpleAnimateNode("root_btnGBReward_animation")
    self._root_bgOp = set:getElfNode("root_bgOp")
    self._root_bgOp_layout = set:getLinearLayoutNode("root_bgOp_layout")
    self._root_bgOp_layout_text = set:getLabelNode("root_bgOp_layout_text")
    self._root_bgOp_layout_timer = set:getTimeNode("root_bgOp_layout_timer")
    self._root_bgOp_layout_btnAdd = set:getButtonNode("root_bgOp_layout_btnAdd")
    self._root_bgOp_layout_btnArrow = set:getButtonNode("root_bgOp_layout_btnArrow")
    self._root_btnChat = set:getClickNode("root_btnChat")
    self._root_btnChat_normal_christmas = set:getElfNode("root_btnChat_normal_christmas")
    self._root_btnChat_pressed_christmas = set:getElfNode("root_btnChat_pressed_christmas")
    self._root_mask = set:getElfNode("root_mask")
    self._begin = set:getStencilBeginNode("begin")
    self._end = set:getStencilEndNode("end")
    self._btnBase = set:getElfNode("btnBase")
    self._arrow = set:getElfNode("arrow")
--    self._@hp1 = set:getElfNode("@hp1")
--    self._@atk = set:getSimpleAnimateNode("@atk")
--    self._@order = set:getElfNode("@order")
--    self._@camping = set:getElfNode("@camping")
--    self._@gub = set:getElfNode("@gub")
--    self._@clk = set:getShieldNode("@clk")
--    self._@clkLight = set:getElfNode("@clkLight")
--    self._@clkLine = set:getElfNode("@clkLine")
--    self._@clkbtn = set:getButtonNode("@clkbtn")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("CGBMain", function ( userData )
	local function doGuildMatch( ... )
		local guildLvLimit = dbManager.getInfoDefaultConfig("GuildFightLevelLimit").Value
		if GuildInfo.getData().Lv >= guildLvLimit then
			local userLvLimit = dbManager.getInfoDefaultConfig("GuildFightUnlockLv").Value
			if gameFunc.getUserInfo().getLevel() >= userLvLimit then
				Launcher.callNet(netModel.getModelGuildMatchScheduleGet(), function ( data )
					print("GuildMatchScheduleGet:")
					print(data)
					if data and data.D then
						GBHelper.setGuildMatchSchedule(data.D)

						local status = GBHelper.getMatchStatusWithSeconds()
						print("Launch_Status = " .. status)
						if status == GBHelper.MatchStatus.SignupBefore then
							GleeCore:toast(res.locString("GuildBattle$matchfail0"))
						elseif status == GBHelper.MatchStatus.Signuping then
							Launcher.callNet(netModel.getModelGuildMatchGet(),function ( data )
								if data and data.D then
									print("GuildMatchGet---------1")
									print(data)
									GBHelper.setMatches(data.D.Matches)
									GBHelper.setCastles(data.D.Castles)
									GBHelper.setGuildMatchPlayer(data.D.Player)
									GleeCore:closeAllLayers()
									Launcher.Launching(data)  
								end
							end)
						else
							if data.D.Signed then
								Launcher.callNet(netModel.getModelGuildMatchGet(),function ( data )
									if data and data.D then
										print("GuildMatchGet---------2")
										print(data)
										GBHelper.setMatches(data.D.Matches)
										GBHelper.setCastles(data.D.Castles)
										GBHelper.setGuildMatchPlayer(data.D.Player)
										if data.D.Matches and #data.D.Matches == 3 then
											GleeCore:closeAllLayers()
											Launcher.Launching(data)  
										else
											if data.D.Matching then
												GleeCore:toast(res.locString("GuildBattle$matchfail2"))
											else
												GleeCore:toast(res.locString("GuildBattle$matchfail"))
											end
										end
									end
								end)
							else
								GleeCore:toast(res.locString("GuildBattle$matchfail"))
							end
						end	
					end
				end)
			else
				GleeCore:toast(string.format(res.locString("GuildBattle$UserLvLimit"), userLvLimit))
			end
		else
			GleeCore:toast(string.format(res.locString("GuildBattle$GuildLvLimit"), guildLvLimit))
		end		
	end
	if not GuildInfo.getGuildMember() or GuildInfo.getGuildMember().Gid == 0 then
		GleeCore:toast(res.locString("GuildBattle$noGuildTip"))
	else
		if GuildInfo.getData() then
			doGuildMatch()
		else
			Launcher.callNet(netModel.getModelGuildGet(GuildInfo.getGuildMember().Gid),function ( data )
				GuildInfo.setData(data.D.Guild)
				GuildInfo.setPresidentLastLoginAt(data.D.PresidentLastLoginAt)
				GuildInfo.setElectionState(data.D.ElectionState)
				doGuildMatch()
			end)
		end
	end
end)

function CGBMain:onInit( userData, netData )
	self.closeCallback = userData and userData.callback
	self:setListenerEvent()
	self:broadcastEvent()
	self:updateLayer()
	local status = GBHelper.getMatchStatusWithSeconds()
	if not GBHelper.isMatchStart() and (status == GBHelper.MatchStatus.Signuping or status == GBHelper.MatchStatus.MatchBefore) then
		GleeCore:showLayer("DGuildBSC")
	end

	require 'LangAdapter'.selectLang(nil, nil, function ( ... )
		self["_root_btnMatchStatus_title"]:setFontSize(18)
		self["_root_btnChallenge_title"]:setFontSize(18)
		self["_root_btnShop_title"]:setFontSize(18)
		self["_root_btnTroop_title"]:setFontSize(18)
	end, nil, function ( ... )
		self["_root_btnMatchStatus_title"]:setFontSize(18)
		self["_root_btnChallenge_title"]:setFontSize(18)
		self["_root_btnShop_title"]:setFontSize(18)
		self["_root_btnTroop_title"]:setFontSize(18)
	end)	

	if status == GBHelper.MatchStatus.Fighting then
		if GBHelper.getGuildMatchPlayer().Killed and not GBHelper.getGuildMatchPlayer().Recovered then
			local param = {}
			param.content = res.locString("GuildBattle$recoverTip")
			param.hideCancel = true
			GleeCore:showLayer("DConfirmNT", param)
		end
	end

end

function CGBMain:onBack( userData, netData )
	self:updateLayer()
end

--------------------------------custom code-----------------------------

function CGBMain:setListenerEvent( ... )
	self._root_btnHelp:setListener(function ( ... )
		GleeCore:showLayer("DHelp", {type = "公会战"})
	end)

	self._root_btnClose:setListener(function ( ... )
		GleeCore:popController(nil, res.getTransitionFade())
		if self.closeCallback then
			self.closeCallback()
		end
	end)

	self._root_btnReport:setListener(function ( ... )
		GleeCore:showLayer("DGBReport")
	end)

	self._root_btnTroop:setListener(function ( ... )
		GleeCore:showLayer("DArenaBattleArray", {type = "GuildBattle"})
	end)

	self._root_btnShop:setListener(function ( ... )
		GleeCore:showLayer("DGBMall")
	end)

	self._root_btnChallenge:setListener(function ( ... )
		GleeCore:showLayer("DGBChallenge")
	end)

	self._root_btnMatchStatus:setListener(function ( ... )
		GleeCore:showLayer("DGuildBSC")
	end)

	self._root_btnGBReward:setListener(function ( ... )
		GleeCore:showLayer("DGBBox")
	end)

	self._root_btnChat:setListener(function ( ... )
		GleeCore:showLayer("DChat")
	end)
end

function CGBMain:broadcastEvent( ... )
	EventCenter.addEventFunc("GuildFightChoseOrder", function ( data )
		local oldOrder = GBHelper.getCastleWithId( data.castleId ).Cmd
		if data.orderType == 1 then
			local clist = GBHelper.getOpponentCastleIdListConnect( data.castleId )
			if clist and #clist > 1 then
				self:updateMaskLayer( data.castleId )
			else
				self:toast(res.locString("GuildBattle$noAtkTarget"))
			end
		else
			if data.orderType ~= oldOrder then
				self:send(netModel.getModelGuildMatchCmd( data.castleId, data.orderType ), function ( netData )
					if netData and netData.D then
						self:showAnimationChangeOrder(data.castleId, oldOrder, data.orderType, function ( ... )
							GBHelper.updateCastle( netData.D.Castle )
							self:updateCastles()
						end)
					end
				end)
			end
		end
	end, "CGBMain")

	EventCenter.addEventFunc("GuildFightCastleUpdate", function ( data )
		self:updateLayer()
	end, "CGBMain")

	EventCenter.addEventFunc("OnBattleCompleted", function ( data )
		print("CGBMain_OnBattleCompleted")
		print(data)
		if data.mode == "guildboss" then
			GBHelper.setGuildMatchPlayer(data.userData.D.Player)
			self:updateLayer()
			GleeCore:showLayer("DGBChallenge")
		elseif data.mode == "guildmatch" then
			if data.userData.D.Matches and #data.userData.D.Matches > 0 then
				GBHelper.setMatches(data.userData.D.Matches)
			end
			if data.userData.D.Castles and #data.userData.D.Castles > 0 then
				GBHelper.updateCastles(data.userData.D.Castles)
			end
			if data.userData.D.Occupied then
				self:toast(res.locString("GuildBattle$castleIsDown"))
			end
			if data.userData.D.Player then
				GBHelper.setGuildMatchPlayer(data.userData.D.Player)
			end
			self:updateLayer()
		end
	end, "CGBMain")

	EventCenter.addEventFunc("OnAppStatChange", function ( state )
		if state == 2 then
			self:updateLayer()
		end
	end, "CGBMain")

	EventCenter.addEventFunc("UpdateGuildMatchMap", function (  )
		self:send(netModel.getModelGuildMatchGet(), function ( data )
			if data and data.D then
				print("UpdateGuildMatchMap")
				print(data)
				GBHelper.setMatches(data.D.Matches)
				GBHelper.setCastles(data.D.Castles)
				GBHelper.setGuildMatchPlayer(data.D.Player)
				self:updateLayer()
			end
		end)
	end, "CGBMain")
end

function CGBMain:onRelease(  )
	EventCenter.resetGroup("CGBMain")
end

function CGBMain:updateLayer( ... )
	self:updateCastles()
	self:updateMatchInfo()
end

function CGBMain:updateCastles( ... )
	local castles = GBHelper.getCastles()
	if castles then
		for i,v in ipairs(castles) do
			self:updateCastle(v)
		end
		self:updateCastlesTarget()
	end
end

function CGBMain:updateMatchInfo( ... )
	local isMatchStart = GBHelper.isMatchStart()
	local status, seconds = GBHelper.getMatchStatusWithSeconds(  )
	print("status = " .. status .. ", seconds = " .. seconds)
	local challengeStatus, challengeSeconds = GBHelper.getChallengeStatusWithSeconds(  )
	print("challengeStatus = " .. challengeStatus .. ", challengeSeconds = " .. challengeSeconds)

	local isMatchCountDown = status ~= GBHelper.MatchStatus.Undefined and status ~= GBHelper.MatchStatus.GameOver and status ~= GBHelper.MatchStatus.SignupBefore
	self._root_matchCountDown_v1:setString( res.locString(string.format("GuildBattle$matchStatus%d", status )) )
	self._root_matchCountDown_timer:setVisible( isMatchCountDown )
	if isMatchCountDown then
		local date = self._root_matchCountDown_timer:getElfDate()
		date:setHourMinuteSecond(0, 0, seconds)
		date:setTimeFormat(DayHourMinuteSecond)
		self._root_matchCountDown_timer:setUpdateRate(-1)
		self._root_matchCountDown_timer:addListener(function (  )
			self:updateLayer()
		end)
	else
		self._root_matchCountDown_timer:getElfDate():setHourMinuteSecond(0, 0, 0)
		self._root_matchCountDown_timer:setUpdateRate(0)
	end
	
	local isChallengeCountDown = challengeStatus ~= GBHelper.ChallengeStatus.Undefined and challengeStatus ~= GBHelper.ChallengeStatus.GameOver
	self._root_challengeCountDown:setVisible(isMatchStart)
	self._root_challengeCountDown_v1:setString( res.locString(string.format("GuildBattle$challengeStatus%d", challengeStatus)) )
	self._root_challengeCountDown_timer:setVisible(isChallengeCountDown)
	if isMatchStart and isChallengeCountDown then
		local date = self._root_challengeCountDown_timer:getElfDate()
		date:setTimeFormat(DayHourMinuteSecond)
		date:setHourMinuteSecond(0, 0, challengeSeconds)
		self._root_challengeCountDown_timer:setUpdateRate(-1)
		self._root_challengeCountDown_timer:addListener(function (  )
			self:updateLayer()
		end)
	else
		self._root_challengeCountDown_timer:getElfDate():setHourMinuteSecond(0, 0, 0)
		self._root_challengeCountDown_timer:setUpdateRate(0)
	end

	local playerInfo = GBHelper.getGuildMatchPlayer()
	self._root_ylayout:removeAllChildrenWithCleanup(true)
	local matches = GBHelper.getMatches()
	if matches then
		for i,v in ipairs(matches) do
			local gub = self:createLuaSet("@gub")
			self._root_ylayout:addChild(gub[1])
			gub[1]:setResid(GBHelper.getGuildBar(v.ServerId, v.GuildId))
			gub["c"]:setString(#v.CastleId)
			gub["layout_text"]:setString(v.GuildName)
			gub["btn"]:setListener(function ( ... )
				GleeCore:showLayer("DguildBattleStat", {info = v})
			end)
		end
	end

	-- 行动力
	self._root_bgOp:setVisible( isMatchStart )
	if playerInfo and isMatchStart then
		if playerInfo.Cd == 0 or playerInfo.ActionPoint == 0 then
			self._root_bgOp_layout_text:setString( string.format(res.locString("GuildBattle$xdl"), playerInfo.ActionPoint) )
			self._root_bgOp_layout_timer:setVisible(false)
			self._root_bgOp_layout_btnArrow:setVisible(false)
			self._root_bgOp_layout_btnAdd:setVisible(playerInfo.ActionPoint == 0)
			self._root_bgOp_layout_btnAdd:setListener(function ( ... )
				local userFunc = gameFunc.getUserInfo()
				local param = {}
				local costList = dbManager.getInfoDefaultConfig("GuildFightBuyCost").Value
				local cost = (playerInfo.ApBought + 1 <= #costList) and costList[playerInfo.ApBought + 1] or costList[#costList]
				param.content = string.format(res.locString("GuildBattle$xdlgm"), cost)
				param.callback = function ( ... )
					if userFunc.getCoin() >= cost then
						self:send(netModel.getModelGuildMatchBuyAp(), function ( data )
							if data and data.D then
								GBHelper.setGuildMatchPlayer(data.D.Player)
								userFunc.setCoin(userFunc.getCoin() - cost)
								self:updateMatchInfo()
							end
						end)
					else
						require "Toolkit".showDialogOnCoinNotEnough()
					end
				end
				GleeCore:showLayer("DConfirmNT", param)
			end)
		else
			self._root_bgOp_layout_text:setString( res.locString("GuildBattle$xdlq") )
			self._root_bgOp_layout_timer:setVisible(true)
			local date = self._root_bgOp_layout_timer:getElfDate()
			date:setHourMinuteSecond(0, 0, playerInfo.Cd)
			self._root_bgOp_layout_timer:setUpdateRate(-1)
			self._root_bgOp_layout_timer:addListener(function (  )
				playerInfo.Cd = 0
				self:updateLayer()
			end)
			self._root_bgOp_layout_btnArrow:setVisible(true)
			self._root_bgOp_layout_btnAdd:setVisible(false)
			self._root_bgOp_layout_btnArrow:setListener(function ( ... )
				local curDate = self._root_bgOp_layout_timer:getElfDate()
				local minLast = curDate:getHour() * 60 + curDate:getMinute() + (curDate:getSecond() > 0 and 1 or 0) 
				local cost = dbManager.getInfoDefaultConfig("GuildFightCDCost").Value * minLast
				local param = {}
				param.title = res.locString("GuildBattle$xdlq")
				param.content = string.format(res.locString("GuildBattle$xdlcd"), cost)
				param.callback = function ( ... )
					if gameFunc.getUserInfo().getCoin() >= cost then
						self:send(netModel.getModelGuildMatchClearCd(), function ( data )
							print("GuildMatchClearCd-------")
							print(data)
							if data and data.D then
								GBHelper.setGuildMatchPlayer(data.D.Player)
								gameFunc.getUserInfo().setCoin(data.D.CoinLeft)
								self:updateMatchInfo()
							end
						end)
					else
						require "Toolkit".showDialogOnCoinNotEnough()
					end
				end
				GleeCore:showLayer("DConfirmNT", param)	
			end)
		end
	end
	
	self._root_btnMatchStatus:setVisible(not isMatchStart)
	self._root_btnChallenge:setVisible(isMatchStart)
	self._root_btnChallenge_hight:setVisible(challengeStatus == GBHelper.ChallengeStatus.Challenging)
	self._root_btnTroop:setEnabled( GBHelper.canBattleArraySetting() )

	if status == GBHelper.MatchStatus.MatchBefore or status == GBHelper.MatchStatus.BattleArraySetting
		or status == GBHelper.MatchStatus.FightPrepare or status == GBHelper.MatchStatus.Fighting then
		self._root_btnGBReward:setVisible(true)
	else
		self._root_btnGBReward:setVisible(false)
	end

	if playerInfo then
		if not playerInfo.Box and (status == GBHelper.MatchStatus.BattleArraySetting or status == GBHelper.MatchStatus.FightPrepare) then
			self._root_btnGBReward_icon:setVisible(false)
			self._root_btnGBReward_animation:setVisible(true)
		else
			self._root_btnGBReward_icon:setVisible(true)
			self._root_btnGBReward_animation:setVisible(false)
		end
	end

	-- 聊天按钮
	local isChristmas = not require 'AccountHelper'.isItemOFF('Spring')
	self._root_btnChat_normal_christmas:setVisible(isChristmas)
	self._root_btnChat_pressed_christmas:setVisible(isChristmas)
end

function CGBMain:updateCastlesTarget( ... )
	local list = GBHelper.getTargetsMine()
	local castles = GBHelper.getCastles()
	if castles then
		local status = GBHelper.getMatchStatusWithSeconds()
		local targetShow = status >= GBHelper.MatchStatus.BattleArraySetting and status <= GBHelper.MatchStatus.Fighting

		for i,v in ipairs(castles) do
			self[string.format("_root_mapNode_btnStage%d_orderBase2", v.CastleId)]:removeAllChildrenWithCleanup(true)
			if targetShow and table.find(list, v.CastleId) then
				local atkSet = self:createLuaSet("@atk")
				self[string.format("_root_mapNode_btnStage%d_orderBase2", v.CastleId)]:addChild(atkSet[1])
			end
		end
	end
end

function CGBMain:updateCastle( castle )
	local isMyCastle = GBHelper.isMyCastle( castle )
	print("isMyCastle = " .. tostring(isMyCastle) .. " ,Occupied = " .. tostring(castle.Occupied))
	local function castleDetail( castle )
		GleeCore:showLayer( isMyCastle and "DGBStageDetailMine" or "DGBStageDetailOpponent", {castle = castle})
	end

	if castle.CastleId == GBHelper.MidCastle then
		self[string.format("_root_mapNode_btnStage%d", castle.CastleId)]:setListener(function ( ... )
			castleDetail( castle )
		end)
	elseif GBHelper.isCamp(castle.CastleId) then
		self[string.format("_root_mapNode_btnStage%d", castle.CastleId)]:setListener(function ( ... )
			GleeCore:showLayer("DGBGuildInfo", {castle = castle})
		end)
	else
		self[string.format("_root_mapNode_btnStage%d", castle.CastleId)]:setListener(function ( ... )
			castleDetail( castle )
		end)
		local img = GBHelper.getGuildColorIcon(castle.ServerId, castle.GuildId)
		self[string.format("_root_mapNode_btnStage%d_normal", castle.CastleId)]:setResid(img)
		self[string.format("_root_mapNode_btnStage%d_pressed", castle.CastleId)]:setResid(img)
		self[string.format("_root_mapNode_btnStage%d_invalid", castle.CastleId)]:setResid(img)
	end
	
	local status = GBHelper.getMatchStatusWithSeconds()
	local showCmdShow = status >= GBHelper.MatchStatus.BattleArraySetting and status <= GBHelper.MatchStatus.Fighting
	self[string.format("_root_mapNode_btnStage%d_orderBase", castle.CastleId)]:removeAllChildrenWithCleanup(true)
	
	if isMyCastle and castle.Cmd > 0 and showCmdShow then
		local orderSet = self:createLuaSet("@order")
		self[string.format("_root_mapNode_btnStage%d_orderBase", castle.CastleId)]:addChild(orderSet[1])
		local cmdList = {"N_GHZ_gongji.png", "N_GHZ_fangyu.png", "N_GHZ_zhiyuan.png"}
		orderSet[1]:setResid( cmdList[castle.Cmd])
		orderSet[1]:stopAllActions()
		orderSet[1]:runAction(res.getScaleAction(0.8))
	end

	if not isMyCastle and not GBHelper.isCamp(castle.CastleId) and (status >= GBHelper.MatchStatus.FightPrepare and status <= GBHelper.MatchStatus.Fighting) then
		local targets = GBHelper.getTargetsMine()
		if table.find(targets, castle.CastleId) then
			local hp1 = self:createLuaSet("@hp1")
			self[string.format("_root_mapNode_btnStage%d_orderBase", castle.CastleId)]:addChild(hp1[1])
			if castle.HpMax == 0 then
				hp1["hp2"]:setPercentage(100)
			else
				hp1["hp2"]:setPercentage(castle.HpLeft * 100 / castle.HpMax)
			end
			
			if castle.CastleId == GBHelper.MidCastle then
				hp1[1]:setPosition(ccp(0, -84))
			end
		end
	end

	if isMyCastle then
		if castle.Target > 0 and showCmdShow then
			self[string.format("_root_mapNode_btnStage%d_orderBase2", castle.Target)]:removeAllChildrenWithCleanup(true)
			local atkSet = self:createLuaSet("@atk")
			self[string.format("_root_mapNode_btnStage%d_orderBase2", castle.Target)]:addChild(atkSet[1])
		end
	end

	if status == GBHelper.MatchStatus.Fighting and castle.Occupied then
		local restoreMax = dbManager.getInfoDefaultConfig("GBProtectTime").Value * 60
		local seconds = -math.floor(require "TimeListManager".getTimeUpToNow(castle.LockedToTime))
		seconds = math.max(seconds, 0)
		seconds = math.min(seconds, restoreMax)
		if seconds > 0 then
			local camping = self:createLuaSet("@camping")
			self[string.format("_root_mapNode_btnStage%d_orderBase", castle.CastleId)]:addChild(camping[1])

			camping["k_timer"]:setPercentage(seconds * 100 / restoreMax)
			camping["k_timer"]:setPercentageInTime(0, seconds)
			self:runWithDelay(function ( ... )
				castle.Occupied = false
				self:updateCastles()
			end, seconds)
		else
			castle.Occupied = false
			self:updateCastles()
		end
	end
end

function CGBMain:updateMaskLayer( castleId )
	self._root_mask:setVisible(true)
	self._root_mask:removeAllChildrenWithCleanup(true)
	local clk = self:createLuaSet("@clk")
	self._root_mask:addChild(clk[1])

	local clist = GBHelper.getOpponentCastleIdListConnect( castleId )
	local x0, y0
	for i,v in ipairs(clist) do
		local clkLight = self:createLuaSet("@clkLight")
		clk["begin"]:addChild(clkLight[1])
		local x, y = self[string.format("_root_mapNode_btnStage%d", v)]:getPosition()
		clkLight[1]:setPosition(ccp(x, y))

		local clkbtn = self:createLuaSet("@clkbtn")
		clk["btnBase"]:addChild(clkbtn[1])
		clkbtn[1]:setPosition(ccp(x, y))
		clkbtn["arrow"]:setVisible(i ~= 1)
		clkbtn[1]:setEnabled(i ~= 1)
		clkbtn[1]:setListener(function ( ... )
			local oldCastle = GBHelper.getCastleWithId( castleId )
			if oldCastle.Cmd == 1 and oldCastle.Target == v then
				self._root_mask:removeAllChildrenWithCleanup(true)
			else
				-- 选择攻击目标
				self:send(netModel.getModelGuildMatchCmd( castleId, 1, v ), function ( data )
					if data and data.D then
						GBHelper.updateCastle( data.D.Castle )
						self._root_mask:removeAllChildrenWithCleanup(true)
						if data.D.Castle.Cmd == oldCastle.Cmd then
							--self:updateCastle( data.D.Castle, oldCastle.Target )
							self:updateCastles()
						else
							self:showAnimationChangeOrder(data.D.Castle.CastleId, oldCastle.Cmd, 1, function ( ... )
							--	self:updateCastle( data.D.Castle )
								self:updateCastles()
							end)
						end
					end
				end)
			end
		end)

		if v == 0 then
			local sc = 1.4
			clkLight[1]:setScale(sc)
			clkbtn[1]:setScale(sc)
			clkbtn["arrow"]:setScale(1.0/sc)
		end

		if i == 1 then
			x0 = x
			y0 = y
		else
			local clkLine = self:createLuaSet("@clkLine")
			clk["end"]:addChild(clkLine[1])
			clkLine[1]:setPosition(ccp(0.5 * (x0 + x), 0.5 * (y0 + y)))
			local kx = x - x0
			local ky = y - y0

			clkLine[1]:setScaleY(math.sqrt(kx * kx + ky * ky) / clkLine[1]:getContentSize().height)
			clkLine[1]:setRotation(270 - math.atan2(ky, kx) * 180 / math.pi)
		end
	end
end

function CGBMain:showAnimationChangeOrder( castleId, oldOrder, newOrder, callback )
	self[string.format("_root_mapNode_btnStage%d_orderBase", castleId)]:removeAllChildrenWithCleanup(true)
	local orderRes = {"N_GHZ_gongji.png", "N_GHZ_fangyu.png", "N_GHZ_zhiyuan.png"}
	local Swf = require 'framework.swf.Swf'
	local myswf = Swf.new('Swf_GengHuanTuBiao')
	self[string.format("_root_mapNode_btnStage%d", castleId)]:addChild( myswf:getRootNode() )
	myswf:getRootNode():setPosition(ccp(0, 40))
	local shapeMap = {
		['shape-2'] = orderRes[oldOrder],
		['shape-4'] = 'Swf_GengHuanTuBiao-4.png', 
		['shape-6'] = 'Swf_GengHuanTuBiao-6.png',
		['shape-8'] = 'Swf_GengHuanTuBiao-8.png',
		['shape-10'] = 'Swf_GengHuanTuBiao-10.png',
		['shape-12'] = 'Swf_GengHuanTuBiao-12.png',
		['shape-14'] = 'Swf_GengHuanTuBiao-14.png',
		['shape-16'] = 'Swf_GengHuanTuBiao-16.png',
		['shape-18'] = 'Swf_GengHuanTuBiao-18.png',
		['shape-20'] = 'Swf_GengHuanTuBiao-20.png',
		['shape-22'] = 'Swf_GengHuanTuBiao-22.png',
		['shape-24'] = 'Swf_GengHuanTuBiao-24.png',
		['shape-26'] = 'Swf_GengHuanTuBiao-26.png',
		['shape-28'] = orderRes[newOrder],
		['shape-30'] = 'Swf_GengHuanTuBiao-30.png',
		['shape-32'] = 'Swf_GengHuanTuBiao-32.png',
		['shape-34'] = 'Swf_GengHuanTuBiao-34.png',
		['shape-36'] = 'Swf_GengHuanTuBiao-36.png',
		['shape-38'] = 'Swf_GengHuanTuBiao-38.png',
		['shape-40'] = 'Swf_GengHuanTuBiao-40.png',
		['shape-42'] = 'Swf_GengHuanTuBiao-42.png',
		['shape-44'] = 'Swf_GengHuanTuBiao-44.png',
	}
	myswf:play(shapeMap, nil, function ( ... )
		myswf:getRootNode():removeFromParentAndCleanup(true)
		if callback then
			callback()
		end
	end)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(CGBMain, "CGBMain")


--------------------------------register--------------------------------
GleeCore:registerLuaController("CGBMain", CGBMain)

