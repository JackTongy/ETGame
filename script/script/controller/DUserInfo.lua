local config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local gameFunc = require "AppData"
local netModel = require "netModel"
local userFunc = gameFunc.getUserInfo()
local teamFunc = gameFunc.getTeamInfo()
local petFunc = gameFunc.getPetInfo()
local eventCenter = require "EventCenter"

local DUserInfo = class(LuaDialog)

function DUserInfo:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."DUserInfo.cocos.zip")
    return self._factory:createDocument("DUserInfo.cocos")
end

--@@@@[[[[
function DUserInfo:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_top_head = set:getElfNode("bg_top_head")
    self._bg_top_lv = set:getLabelNode("bg_top_lv")
    self._bg_top_name = set:getLabelNode("bg_top_name")
    self._bg_top_vip = set:getElfNode("bg_top_vip")
    self._bg_top_vip_btn = set:getClickNode("bg_top_vip_btn")
    self._bg_top_honer = set:getElfNode("bg_top_honer")
    self._bg_top_coinValue = set:getLabelNode("bg_top_coinValue")
    self._bg_top_goldValue = set:getLabelNode("bg_top_goldValue")
    self._bg_top_btnChangeName = set:getClickNode("bg_top_btnChangeName")
    self._bg_top_btnChangeName_text = set:getLabelNode("bg_top_btnChangeName_text")
    self._bg_exp_value = set:getLabelNode("bg_exp_value")
    self._bg_exp_Lv = set:getLabelNode("bg_exp_Lv")
    self._bg_exp_des = set:getLabelNode("bg_exp_des")
    self._bg_exp_exp1_exp2 = set:getProgressNode("bg_exp_exp1_exp2")
    self._bg_ap_value = set:getLabelNode("bg_ap_value")
    self._bg_ap_ap1_ap2 = set:getProgressNode("bg_ap_ap1_ap2")
    self._bg_ap_des1 = set:getLabelNode("bg_ap_des1")
    self._bg_ap_time1 = set:getTimeNode("bg_ap_time1")
    self._bg_ap_des2 = set:getLabelNode("bg_ap_des2")
    self._bg_ap_time2 = set:getTimeNode("bg_ap_time2")
    self._bg_item1 = set:getLayoutNode("bg_item1")
    self._bg_item1_btnCharge = set:getClickNode("bg_item1_btnCharge")
    self._bg_item1_btnFeedback = set:getClickNode("bg_item1_btnFeedback")
    self._bg_item1_btnFeedback_text = set:getLabelNode("bg_item1_btnFeedback_text")
    self._bg_item1_btnNotice = set:getClickNode("bg_item1_btnNotice")
    self._bg_item1_btnNotice_text = set:getLabelNode("bg_item1_btnNotice_text")
    self._bg_item2 = set:getLayoutNode("bg_item2")
    self._bg_item2_btnSetting = set:getClickNode("bg_item2_btnSetting")
    self._bg_item2_btnExchangeKey = set:getClickNode("bg_item2_btnExchangeKey")
    self._bg_item2_btnRelogin = set:getClickNode("bg_item2_btnRelogin")
    self._bg_item2_btnRelogin_text = set:getLabelNode("bg_item2_btnRelogin_text")
    self._bg_btnClose = set:getButtonNode("bg_btnClose")
end
--@@@@]]]]

--------------------------------override functions----------------------

local Launcher = require 'Launcher'
Launcher.register("DUserInfo", function ( userData )
   	Launcher.callNet(netModel.getModelRoleSyncAp(),function ( data )
     		Launcher.Launching(data)   
   	end)
end)

function DUserInfo:onInit( userData, netData )
	
	require 'LangAdapter'.fontSize(self._bg_item1_btnFeedback_text,24)
	require 'LangAdapter'.fontSize(self._bg_item1_btnNotice_text,24)
	require 'LangAdapter'.fontSize(self._bg_item2_btnRelogin_text,24,nil,nil,nil,nil,nil,nil,24)
	require 'LangAdapter'.selectLang(nil, nil, function ( ... )
		self._bg_item1_btnFeedback:setVisible(false)
	end, nil, function ( ... )
		self._bg_top_btnChangeName_text:setFontSize(22)
	end)
	
	res.doActionDialogShow(self._bg)
	self:setListenerEvent()
	self:updateLayer()

	eventCenter.addEventFunc("OnAppStatChange", function ( state )
		if state == 2 then
			self:send(netModel.getModelRoleSyncAp(), function ( data )
				if data and data.D and data.D.Role then
					userFunc.setData(data.D.Role)
					self:updateLayer()
				end
			end)
		end
	end, "DUserInfo")

	eventCenter.addEventFunc("UpdateAp", function (  )
		self:updateAp()
	end, "DUserInfo")

	eventCenter.addEventFunc("UpdateGoldCoin", function (  )
		self:updateLayer()
	end, "DUserInfo")
	
--	self:send(netModel.getModelRoleSyncAp(), function ( netData )
		if netData and netData.D and netData.D.Role then
			userFunc.setData(netData.D.Role)
			print("更新体力")
			print(netData.D.Role)
			self:updateLayer()
		end
--	end)
end

function DUserInfo:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DUserInfo:close(  )
	eventCenter.resetGroup("DUserInfo")
end

function DUserInfo:setListenerEvent( ... )
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_top_vip_btn:setListener(function ( ... )
		GleeCore:showLayer("DRecharge", {ShowIndex = 2})
	end)

	self._bg_item1_btnCharge:setListener(function ( ... )
		GleeCore:showLayer("DRecharge")
	end)

	self._bg_item1_btnFeedback:setListener(function ( ... )
		GleeCore:showLayer("DFeedback")
	end)

	self._bg_item1_btnNotice:setListener(function ( ... )
		GleeCore:showLayer("DNotice")
	end)

	self._bg_item2_btnSetting:setListener(function ( ... )
		GleeCore:showLayer("DSetting")
	end)

	self._bg_item2_btnExchangeKey:setListener(function ( ... )
		GleeCore:showLayer("DExchangeKey", {mode = "ExchangeKey"})
	end)

	self._bg_item2_btnRelogin:setListener(function ( ... )
		local sdkloginout = require 'AccountInfo'.getLogOutFunc()
		if sdkloginout then
			sdkloginout()
		end
		self:close()
		GleeCore:reLogin()
	end)

	local off = require 'AccountHelper'.isItemOFF('CD_keyRUK')
	self._bg_item2_btnExchangeKey:setVisible(not off)
	self._bg_top_btnChangeName:setListener(function ( ... )
		GleeCore:showLayer("DChangeName")
	end)

	local esptfunc = function ( ... )
		self._bg_item1_btnNotice_text:setString('Facebook')
		self._bg_item1_btnNotice:setListener(function ( ... )
			WebView:getInstance():gotoURL('https://www.facebook.com/ThePocketQ')
		end)
		self._bg_item1_btnFeedback:setListener(function ( ... )
			WebView:getInstance():gotoURL('mailto:pqsupport@gamebau.com')
		end)
	end
	require 'LangAdapter'.selectLang(nil,nil,nil,function ( ... )
		self._bg_item1_btnFeedback:setListener(function ( ... )
			WebView:getInstance():gotoURL('http://m.cafe.naver.com/monxmon')
		end)
		self._bg_item1_btnNotice:setListener(function ( ... )
			--注销
			GleeCore:showLayer('DConfirmNT',{title='게임탈퇴',content=[[경고!!
탈퇴 완료 시 모든 정보는 삭제되어 복구가 불가능합니다.]], callback=function ( )
				require 'AccountHelper'.ACSReset(function ( data )
					local sdkloginout = require 'AccountInfo'.getLogOutFunc()
					if sdkloginout then
						sdkloginout()
					end
					self:close()
					GleeCore:reLogin()
				end)
			end})
		end)
	end,nil,esptfunc,esptfunc,nil,nil,function ( ... )
		self._set:getLabelNode("bg_top_btnChangeName_text"):setString("Ändern")
		self._set:getLabelNode("bg_item1_btnCharge_#text"):setString("Aufladen")
		self._set:getLabelNode("bg_item1_btnFeedback_text"):setString("Hilfe")
		self._set:getLabelNode("bg_item1_btnNotice_text"):setString("Facebook")
		self._set:getLabelNode("bg_item2_btnExchangeKey_#text"):setString("Coupon")
		self._set:getLabelNode("bg_item2_btnRelogin_text"):setString("Logout")
		self._bg_item1_btnNotice:setListener(function ( ... )
			WebView:getInstance():gotoURL('https://www.facebook.com/pocketevolutionde')
		end)
	end)
	
end

function DUserInfo:updateLayer(  )
	if teamFunc and teamFunc.getTeamActive() then
		local nPetId = teamFunc.getTeamActive().CaptainPetId
		if nPetId > 0 then
			self._bg_top_head:setResid(res.getPetIcon(petFunc.getPetWithId(nPetId).PetId))
		end
	end
	self._bg_top_lv:setString(userFunc.getLevel())
	self._bg_top_name:setString(userFunc.getName())
	self._bg_top_vip:setResid(res.getVipIcon(userFunc.getVipLevel()))
	self._bg_top_honer:setResid(res.getPlayerTitle(userFunc.getTitleID()))
	self._bg_top_coinValue:setString(userFunc.getCoin())
	self._bg_top_goldValue:setString(userFunc.getGold())
	local levelTable = dbManager.getInfoRoleLevelCap(userFunc.getLevel())
	self._bg_exp_value:setString(string.format("%s/%s", res.getExpFormat(userFunc.getExp()), res.getExpFormat(levelTable.exp)))
	self._bg_exp_Lv:setString(res.locString("Global$Level") .. tostring(userFunc.getLevel()))
	if userFunc.getLevel() >= dbManager.getInfoDefaultConfig("rolelvlimit").Value then
		self._bg_exp_des:setString(res.locString("Global$LevelCap"))
	else
		self._bg_exp_des:setString(string.format(res.locString("UserInfo$LevelUpDes"), math.max(levelTable.exp - userFunc.getExp(), 0)))
	end
	self._bg_exp_exp1_exp2:setPercentage(userFunc.getExp() * 100 / levelTable.exp)
	self:updateAp()
	require 'LangAdapter'.selectLang(nil, nil, function ( ... )
		self._bg_exp_Lv:setVisible(false)
	end, nil, nil, function ( ... )
		self._bg_exp_des:setVisible(false)
	end, function ( ... )
		self._bg_exp_des:setVisible(false)
	end, nil, nil, function ( ... )
		self._bg_exp_des:setVisible(false)
		self._bg_ap_des1:setFontSize(16)
		self._bg_ap_des2:setFontSize(16)
		self._bg_ap_time1:setFontSize(16)
		self._bg_ap_time2:setFontSize(16)
	end)

--	self:updateTeam()
end

-- function DUserInfo:updateTeam(  )
-- 	local team = teamFunc.getTeamActive()
-- 	self._bg_team_layoutBattleValue_power:setString(tostring(teamFunc.getTeamCombatPower()))

-- 	self._bg_team_layoutTeam:removeAllChildrenWithCleanup(true)
-- 	for i=1, 6 do
-- 		local petSet = self:createLuaSet("@pet")
-- 		self._bg_team_layoutTeam:addChild(petSet[1])
-- 		local nPet
-- 		if i == 6 then
-- 			if team.BenchPetId > 0 then
-- 				nPet = petFunc.getPetWithId(team.BenchPetId)
-- 			end
-- 			petSet["smallIcon"]:setResid("TY_tibu.png")
-- 		else
-- 			if i <= #team.PetIdList then
-- 				nPet = petFunc.getPetWithId(team.PetIdList[i])
-- 			end
-- 			petSet["smallIcon"]:setVisible(i == 1)
-- 			if i == 1 then
-- 				petSet["smallIcon"]:setResid("TY_duiwu.png")
-- 			end
-- 		end
-- 		if nPet then
-- 			res.setNodeWithPet(petSet["icon"], nPet)
-- 			petSet["icon"]:setScale(0.75)
-- 		else
-- 			petSet["icon"]:setResid("N_ZY_xkkkk.png")
-- 			petSet["icon"]:setScale(0.75 * 155 / 92)
-- 		--	res.setNodeWithPetNone(petSet["icon"])
-- 		end
-- 	end
-- end

function DUserInfo:updateAp(  )
	require 'LangAdapter'.selectLang(nil, nil, function ( ... )
		self._bg_ap_des1:setFontSize(16)
		self._bg_ap_time1:setFontSize(16)
		self._bg_ap_des2:setFontSize(16)
		self._bg_ap_time2:setFontSize(16)
	end)

	local levelTable = dbManager.getInfoRoleLevelCap(userFunc.getLevel())
	self._bg_ap_value:setString(string.format("%d/%d", userFunc.getAp(), levelTable.apcap))
	self._bg_ap_ap1_ap2:setPercentage(userFunc.getAp() * 100 / levelTable.apcap)
	local levelTable = dbManager.getInfoRoleLevelCap(userFunc.getLevel())
	if userFunc.getAp() < levelTable.apcap then
		local date = self._bg_ap_time1:getElfDate()
		date:setHourMinuteSecond(0, 0, userFunc.getApResume())
		self._bg_ap_time1:setUpdateRate(-1)
		-- 后台数据倒计时为0时会发送updateAp消息，更新界面
		-- if userFunc.getApResume() > 0 then
		-- 	self._bg_ap_time1:addListener(function (  )
		-- 	end)
		-- end

		local date2 = self._bg_ap_time2:getElfDate()
		date2:setHourMinuteSecond(0, 0, userFunc.getApTotalResume())
		self._bg_ap_time2:addListener(function (  )
			date2:setHourMinuteSecond(0, 0, 0)
			self._bg_ap_time2:setUpdateRate(0)
		end)
	else -- 满体力
		self._bg_ap_time1:getElfDate():setHourMinuteSecond(0, 0, 0)
		self._bg_ap_time1:setUpdateRate(0)
		self._bg_ap_time2:getElfDate():setHourMinuteSecond(0, 0, 0)	
		self._bg_ap_time2:setUpdateRate(0)
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DUserInfo, "DUserInfo")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DUserInfo", DUserInfo)
