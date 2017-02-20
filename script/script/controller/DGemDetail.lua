local Config = require "Config"
local dbManager = require "DBManager"
local res = require "Res"
local socket = require 'SocketClient'
local netModel = require "netModel"
local eventCenter = require 'EventCenter'
local GuideHelper = require 'GuideHelper'

local DGemDetail = class(LuaDialog)

function DGemDetail:createDocument()
	self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGemDetail.cocos.zip")
	return self._factory:createDocument("DGemDetail.cocos")
end

--@@@@[[[[
function DGemDetail:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getShieldNode("bg")
    self._bg_detailBg_gemIconBg_gemIcon = set:getElfNode("bg_detailBg_gemIconBg_gemIcon")
    self._bg_detailBg_gemIconBg_gemName = set:getLabelNode("bg_detailBg_gemIconBg_gemName")
    self._bg_detailBg_gemIconBg_layoutName = set:getLinearLayoutNode("bg_detailBg_gemIconBg_layoutName")
    self._bg_detailBg_gemIconBg_layoutName_name = set:getLabelNode("bg_detailBg_gemIconBg_layoutName_name")
    self._bg_detailBg_gemEffectDes = set:getLabelNode("bg_detailBg_gemEffectDes")
    self._bg_detailBg_layoutProy = set:getLayoutNode("bg_detailBg_layoutProy")
    self._key = set:getLabelNode("key")
    self._value = set:getLabelNode("value")
    self._bg_detailBg_timeLimitView = set:getElfNode("bg_detailBg_timeLimitView")
    self._bg_detailBg_timeLimitView_linearlayout_time = set:getTimeNode("bg_detailBg_timeLimitView_linearlayout_time")
    self._bg_detailBg_shareTimeLimitNodeTip = set:getLabelNode("bg_detailBg_shareTimeLimitNodeTip")
    self._bg_detailBg_updateBtn = set:getClickNode("bg_detailBg_updateBtn")
    self._bg_detailBg_updateBtn_btntext = set:getLabelNode("bg_detailBg_updateBtn_btntext")
    self._bg_detailBg_mosaicBtn = set:getClickNode("bg_detailBg_mosaicBtn")
    self._bg_detailBg_mosaicBtn_btntext = set:getLabelNode("bg_detailBg_mosaicBtn_btntext")
    self._bg_detailBg_layout = set:getLinearLayoutNode("bg_detailBg_layout")
    self._bg_detailBg_layout_mosaicOnLabel = set:getLabelNode("bg_detailBg_layout_mosaicOnLabel")
    self._bg_detailBg_shareBtn = set:getButtonNode("bg_detailBg_shareBtn")
--    self._@layoutProx = set:getLinearLayoutNode("@layoutProx")
--    self._@equipName = set:getLabelNode("@equipName")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DGemDetail:onInit( userData, netData )
	res.doActionDialogShow(self._bg,function ( ... )
		GuideHelper:registerPoint('升级',self._bg_detailBg_updateBtn)
		GuideHelper:check('DGemDetail')
	end)
	
	eventCenter.addEventFunc("OnAppStatChange", function ( state )
		if state == 2 then
			return self:updateViewNormal()
		end
	end, "DGemDetail")
	self.close = function ( ... )
		eventCenter.resetGroup("DGemDetail")
	end

	self.gemInfo = userData.GemInfo
	self.gemInfo.SetIn = self.gemInfo.SetIn or 0
	self.gemInfo.Seconds = self.gemInfo.Seconds or 0
	self.mosaicOnEquip = userData.EquipInfo
	self.cachedCloseFunc = userData.CloseFunc
	self.btnExText = userData.BtnExText
	self.btnExFunc = userData.BtnExFunc
	self.dbInfo = dbManager.getInfoGem(self.gemInfo.GemId)
	if userData.ShowOnly then
		self:updateViewForShowOnly()
	else
		self:updateViewNormal()
	end
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)
end

function DGemDetail:onBack( userData, netData )

end

--------------------------------custom code-----------------------------
function DGemDetail:updateViewNormal( ... )
	self._bg_detailBg_gemIconBg_gemName:setString(string.format("%sLv%d",self.dbInfo.name,self.gemInfo.Lv))
	local mosaic = self.gemInfo.SetIn and self.gemInfo.SetIn > 0
	res.setGemDetail(self._bg_detailBg_gemIconBg_gemIcon,self.gemInfo,mosaic)
	if mosaic then
		local pet = require "PetInfo".getPetWithId(self.gemInfo.SetIn)
		local DBPet = dbManager.getCharactor(pet.PetId)
		self._bg_detailBg_gemIconBg_layoutName_name:setString(DBPet.name)
		self._bg_detailBg_gemIconBg_layoutName:setVisible(true)
	else
		self._bg_detailBg_gemIconBg_layoutName:setVisible(false)
	end

	self._bg_detailBg_gemEffectDes:setString(string.format(res.locString("Gem$GemEffectDes"),require "Toolkit".getGemDes(self.gemInfo)))
	
	self._bg_detailBg_layoutProy:removeAllChildrenWithCleanup(true)	
	local desList = string.split(self.dbInfo.description, ",")
	if desList then
		for i,des in ipairs(desList) do
			local temp = string.split(des, "|")
			local canFind, pos = string.find(temp[2],"%%")
			local value = self.dbInfo[string.format("effect%d", i)][self.gemInfo.Lv]
			if canFind then
				value = value * 100
			end

			local set = self:createLuaSet("@layoutProx")
			self._bg_detailBg_layoutProy:addChild(set[1])

			set["key"]:setString(temp[1])
			set["value"]:setString(string.gsub(temp[2],"{$}", value))
		end
	end

	if self.gemInfo.Seconds > 0 then
		local lastTime = self.gemInfo.Seconds - math.floor(require "TimeListManager".getTimeUpToNow(self.gemInfo.CreateAt))
		print(lastTime)
		local function onTimeFinished( ... )
			print("on time finished----------------")
			require "GemInfo".removeGemList({self.gemInfo.Id})
			self:toast(res.locString("Gem$TimeLimitTip"))
			res.doActionDialogHide(self._bg, self)
			if self.cachedCloseFunc then
				self.cachedCloseFunc()
			end
		end
		if lastTime > 0 then
			self._bg_detailBg_timeLimitView_linearlayout_time:setHourMinuteSecond(require "TimeListManager".getTimeInfoBySeconds(lastTime))
			local listener = ElfDateListener:create(onTimeFinished)
			listener:setHourMinuteSecond(0,0,1)
			self._bg_detailBg_timeLimitView_linearlayout_time:addListener(listener)
			self._bg_detailBg_timeLimitView:setVisible(true)
		else
			self._bg_detailBg_timeLimitView:setVisible(false)
			onTimeFinished()
		end
	else
		self._bg_detailBg_timeLimitView:setVisible(false)
	end

	if self.gemInfo.Lv == 7 then
		self._bg_detailBg_updateBtn_btntext:setString(res.locString("Gem$GemLvMax"))
		self._bg_detailBg_updateBtn:setEnabled(false)
	else
		self._bg_detailBg_updateBtn:setListener(function ( ... )
			if require "UnlockManager":isUnlock("GemFuben") then
				GleeCore:showLayer("DGemLevelUp",self.gemInfo)
				self:close()
			else
				self:toast( string.format(res.locString("Bag$GemUnLock"), require "UnlockManager":getUnlockLv("GemFuben") ) )
			end
		end)
	end

	self:updateBtnEx()

	self._bg_detailBg_shareBtn:setListener(function ( ... )
		-- local content = require "ChatInfo".createShareContent(3,self.gemInfo.Id)
		-- self:send(netModel.getmodelChatSend(1,content,"",3,self.gemInfo.Id),function ( data )
		-- 	return self:toast(res.locString("Global$ShareSuc"))
		-- end)
	end)
end

function DGemDetail:updateViewForShowOnly( ... )
	self._bg_detailBg_gemIconBg_gemName:setString(string.format("%sLv%d",self.dbInfo.name,self.gemInfo.Lv))
	local mosaic = self.gemInfo.SetIn > 0
	res.setGemDetail(self._bg_detailBg_gemIconBg_gemIcon,self.gemInfo)
	if mosaic then
		local pet = require "PetInfo".getPetWithId(self.gemInfo.SetIn)
		local DBPet = dbManager.getCharactor(pet.PetId)
		self._bg_detailBg_gemIconBg_layoutName_name:setString(DBPet.name)
		self._bg_detailBg_gemIconBg_layoutName:setVisible(true)
	else
		self._bg_detailBg_gemIconBg_layoutName:setVisible(false)
	end

	self._bg_detailBg_gemEffectDes:setString(string.format(res.locString("Gem$GemEffectDes"),require "Toolkit".getGemDes(self.gemInfo)))
	self._bg_detailBg_layoutProy:removeAllChildrenWithCleanup(true)	
	local desList = string.split(self.dbInfo.description, ",")
	if desList then
		for i,des in ipairs(desList) do
			local temp = string.split(des, "|")
			local canFind, pos = string.find(temp[2],"%%")
			local value = self.dbInfo[string.format("effect%d", i)][self.gemInfo.Lv]
			if canFind then
				value = value * 100
			end

			local set = self:createLuaSet("@layoutProx")
			self._bg_detailBg_layoutProy:addChild(set[1])

			set["key"]:setString(temp[1])
			set["value"]:setString(string.gsub(temp[2],"{$}", value))
		end
	end

	if self.gemInfo.Seconds > 0 then
		self._bg_detailBg_timeLimitView:setVisible(true)
		self._bg_detailBg_timeLimitView_linearlayout_time:setTimeFormat(Hour99MinuteSecond)
		self._bg_detailBg_timeLimitView_linearlayout_time:setHourMinuteSecond(require "TimeListManager".getTimeInfoBySeconds(self.gemInfo.Seconds))
		self._bg_detailBg_timeLimitView_linearlayout_time:setUpdateRate(0)
		-- self._bg_detailBg_shareTimeLimitNodeTip:setVisible(self.gemInfo.Seconds > 0)
	else
		self._bg_detailBg_timeLimitView:setVisible(false)
	end

	self._bg_detailBg_updateBtn_btntext:setString(res.locString("Global$Close"))
	self._bg_detailBg_updateBtn:setTriggleSound(res.Sound.back)
	self._bg_detailBg_updateBtn:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self:updateBtnEx()

	self._bg_detailBg_shareBtn:setVisible(false)
end

function DGemDetail:updateBtnEx(  )
	if self.btnExText then
		self._bg_detailBg_mosaicBtn:setVisible(true)
		self._bg_detailBg_mosaicBtn_btntext:setString(self.btnExText)
		self._bg_detailBg_mosaicBtn:setListener(function ( ... )
			self.btnExFunc()
			res.doActionDialogHide(self._bg, self)
		end)
	else
		self._bg_detailBg_mosaicBtn:setVisible(false)
		self._bg_detailBg_updateBtn:setPosition(0,-178)
	end
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGemDetail, "DGemDetail")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGemDetail", DGemDetail)


