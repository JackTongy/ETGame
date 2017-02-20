local Config = require "Config"
local Res = require 'Res'
local dbManager = require 'DBManager'
local layerManager = require "framework.interface.LuaLayerManager"
local AppData = require 'AppData'
local GuideHelper = require 'GuideHelper'
local netModel = require "netModel"
local gameFunc = require "AppData"
local userFunc = gameFunc.getUserInfo()
local LuaList  = require 'LuaList'

local TownHelper = require "TownHelper"

local DMaterialDetail = class(LuaDialog)

function DMaterialDetail:createDocument()
		self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DMaterialDetail.cocos.zip")
		return self._factory:createDocument("DMaterialDetail.cocos")
end

--@@@@[[[[
function DMaterialDetail:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._bg = set:getShieldNode("bg")
   self._bg_bg = set:getJoint9Node("bg_bg")
   self._bg_detailBg_Des = set:getRichLabelNode("bg_detailBg_Des")
   self._bg_detailBg_gemIconBg_bg = set:getElfNode("bg_detailBg_gemIconBg_bg")
   self._bg_detailBg_gemIconBg_gemIcon = set:getElfNode("bg_detailBg_gemIconBg_gemIcon")
   self._bg_detailBg_gemIconBg_frame = set:getElfNode("bg_detailBg_gemIconBg_frame")
   self._bg_detailBg_gemIconBg_gemName = set:getLabelNode("bg_detailBg_gemIconBg_gemName")
   self._bg_amount_V = set:getLabelNode("bg_amount_V")
   self._bg_timeLimitView = set:getElfNode("bg_timeLimitView")
   self._bg_from = set:getElfNode("bg_from")
   self._bg_from_list = set:getListNode("bg_from_list")
   self._frame = set:getElfNode("frame")
   self._icon = set:getElfNode("icon")
   self._name = set:getLabelNode("name")
   self._tip = set:getLabelNode("tip")
   self._btn = set:getButtonNode("btn")
   self._lock = set:getElfNode("lock")
   self._btnBattleSpeed = set:getClickNode("btnBattleSpeed")
   self._btnBattleSpeed_text = set:getLabelNode("btnBattleSpeed_text")
   self._btnReset = set:getClickNode("btnReset")
   self._btnReset_text = set:getLabelNode("btnReset_text")
   self._btnGoto = set:getClickNode("btnGoto")
   self._btnGoto_text = set:getLabelNode("btnGoto_text")
   self._bg_btnClose = set:getClickNode("bg_btnClose")
   self._bg_btnClose_title = set:getLabelNode("bg_btnClose_title")
   self._bg_linearlayout = set:getLinearLayoutNode("bg_linearlayout")
   self._bg_linearlayout_time = set:getTimeNode("bg_linearlayout_time")
--   self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DMaterialDetail", function ( userData )
	local sendForStage = false
	if not userData.Soul then
		local dbMaterial = dbManager.getInfoMaterial(userData.materialId)
		if dbMaterial and dbMaterial.stage and type(dbMaterial.stage)=='table' and #dbMaterial.stage > 0 then
			sendForStage = true
			Launcher.callNet(netModel.getModelGetStages(dbMaterial.stage),function ( data )
				Launcher.Launching(data)   
			end)
		end
	end

	if not sendForStage then
		Launcher.Launching()
	end
end)

--[[
materialId = 
Soul
Seconds
speed --默认为-1 为0时停止倒计时 
isBuy
Callback
needAmount
]]
function DMaterialDetail:onInit( userData, netData )
	selectLang(nil,nil,nil,nil,function (  )
		self._set:getLabelNode("bg_from_#label"):setAnchorPoint(ccp(0,0.5))
		self._set:getLabelNode("bg_from_#label"):setPosition(-211,103)
	end)

	if netData and netData.D then
		self.nStageList = netData.D.Stages
	end

	Res.doActionDialogShow(self._bg,function ( ... )
		GuideHelper:check('DMaterialDetail')
	end)
	self._bg_from:setVisible(false)
	if userData.isBuy then
		self._bg_btnClose_title:setString(Res.locString("ItemMall$Buy"))
		self._bg_timeLimitView:setVisible(false)
	end
	self._bg_btnClose:setListener(function ( ... )
		if userData.isBuy then
			if userData.closeDialog then
				Res.doActionDialogHide(self._bg, self)
			end
			if userData.Callback then
				userData.Callback()
			end
		else
			Res.doActionDialogHide(self._bg, self)
		end
	end)
	
	self._clickBg:setListener(function ( ... )
		Res.doActionDialogHide(self._bg, self)
	end)

	if userData.Seconds then
		self._bg_linearlayout_time:setTimeFormat(Hour99MinuteSecond)
		self._bg_linearlayout_time:setHourMinuteSecond(0,0,userData.Seconds)
		self._bg_linearlayout_time:setUpdateRate(userData.speed or -1)
	end
	self._bg_linearlayout:setVisible(userData.Seconds ~= nil)

	self:updateLayer()
end

function DMaterialDetail:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DMaterialDetail:updateLayer( ... )
	local userData = self:getUserData()
	local resid
	local dbm
	local amount = 0
	if userData.Soul then
		resid = Res.getSoulImageName()
		local config = dbManager.getDeaultConfig('Soul')
		dbm = {}
		dbm.from = 2
		dbm.describe = config.Value
		dbm.name = config.name or Res.locString('PetFoster$SOUL')
		amount = AppData.getUserInfo().getSoul()
	else
		resid =  Res.getMaterialIcon(userData.materialId)
		dbm = dbManager.getInfoMaterial(userData.materialId)
		amount = AppData.getBagInfo().getItemCount(userData.materialId)
	end

	if userData.needAmount then
		self._bg_amount_V:setString(string.format('%s/%s',tostring(amount),tostring(userData.needAmount)))
	end
	
	if dbm then
		self.dbMaterial = dbm
		local goto 		= nil
		local fromstage = (dbm.stage and type(dbm.stage) == 'table')
		if fromstage then
			title = ''
			self:showGotoStageList(dbm)
		end

		local title = Res.locString('Pet$Sacrifice')
		if not dbm.from and fromstage then
			
		elseif dbm.from == 2 then

			goto = function ( ... )
				Res.doActionDialogHide(self._bg, self)
				self:gotoShowLayer('DPetList',{tab=3})
			end
			self:showGetWay('daoju5.png',title,goto,fromstage)
		elseif dbm.from == 1 or dbm.from == 3 then
			
			goto = function ( ... )
				Res.doActionDialogHide(self._bg, self)
				self:gotoShowLayer('DMall',{tab=2})
			end

			title = Res.locString('Pet$mall')
			self:showGetWay('daoju4.png',title,goto,fromstage)
		elseif dbm.from == 4 then
			title = Res.locString('DMDetail$title4')
			goto = function ( ... )
				local ActivityType = require "ActivityType"
				Res.doActionDialogHide(self._bg, self)
				self:gotoShowLayer('DActivity',{ShowActivity = ActivityType.RoastDuck})
			end
			self:showGetWay('material_24.png',title,goto,fromstage)
		elseif dbm.from == 5 then
			title = Res.locString('DMDetail$title5')
			goto = function ( ... )
				Res.doActionDialogHide(self._bg, self)
				self:gotoShowLayer('DMagicShop')
			end
			self:showGetWay('daoju1.png',title,goto,fromstage)
		elseif dbm.from == 8 then
			title = Res.locString('Home$ActTask')
			goto = function ( ... )
				Res.doActionDialogHide(self._bg,self)
				self:gotoShowLayer('DActRaid')
			end
			self:showGetWay('daoju7.png',title,goto,fromstage)
		elseif dbm.from == 0 then
			title = ''
		end

		self._bg_detailBg_gemIconBg_gemIcon:setResid(resid)
		self._bg_detailBg_gemIconBg_bg:setResid(Res.getMaterialIconBg(dbm.color))
		self._bg_detailBg_gemIconBg_frame:setResid(Res.getMaterialIconFrame(dbm.color))
		self._bg_detailBg_Des:setString(string.format('[color=f3e0bbff]%s[/color] [color=ffffffff]%s[/color]',Res.locString('Material$_TitleDes'),dbm.describe))
		self._bg_detailBg_gemIconBg_gemName:setString(dbm.name)
	end

	if userData.FromTownID then
		self._bg_from:setVisible(false)
		self._bg_btnClose:setVisible(true)
	end
end

function DMaterialDetail:gotoShowLayer( name,data )
	if not GleeCore:isRunningLayer(name) then
		GleeCore:closeAllLayers({Menu=true,guideLayer=true})
		GleeCore:showLayer(name,data)
	end
end

function DMaterialDetail:showGetWay( iconname,name,gotofunc,fromstage )
	if not fromstage then
		self._bg_from_list:getContainer():removeAllChildrenWithCleanup(true)
		self._bg_from_list:setTouchEnable(false)
		self._bg_from:setVisible(true)
	end
	
	self:addGetWay(iconname,name,gotofunc)
end

function DMaterialDetail:addGetWay( iconname,name,gotofunc )
	local set = self:createLuaSet('@item')
	set['icon']:setResid(iconname or 'FB_wenti.png')
	local x,y = set['icon']:getPosition()
	set['icon']:setPosition(ccp(x-2,0))
	set['icon']:setScale(0.4)
	set['name']:setString(tostring(name))
	set['lock']:setVisible(false)
	set['btnReset']:setVisible(false)
	set['btnBattleSpeed']:setVisible(false)
	set['btn']:setVisible(true)
	set['btn']:setListener(function ( ... )
		return gotofunc and gotofunc()
	end)
	local px,py = set['name']:getPosition()
	set['name']:setPosition(px,0)
	self._bg_from_list:getContainer():addChild(set[1],self._bg_from_list:getContainer():getChildrenCount() + 1)
	require 'LangAdapter'.LabelNodeAutoShrink(set['name'],210)
	require 'LangAdapter'.LabelNodeAutoShrink(set['btnReset_text'],120)
	require 'LangAdapter'.LabelNodeAutoShrink(set['btnBattleSpeed_text'],120)
	require 'LangAdapter'.LabelNodeAutoShrink(set['btnGoto_text'],120)
end

function DMaterialDetail:showGotoStageList( dbm )
	self._bg_from_list:setTouchEnable(true)
	local stages = dbm.stage
	self._bg_from:setVisible(true)
	self._bg_linearlayout:setVisible(false)
	self._bg_btnClose:setVisible(false)

	local TownInfo = AppData.getTownInfo()
	

	local function getStageNetData( nStageId )
		local nStage
		if self.nStageList then
			for k,v in pairs(self.nStageList) do
				if v.StageId == nStageId then
					nStage = v
					break
				end
			end
		end
		return nStage
	end

	local function isStageReset( nStage )
		return nStage and nStage.TodayTimes == 0 and nStage.CostAp > 0 or false
	end

	local refreshcell = function ( set,v )

		local updatecallback = function ( data )
			if data.D.Stage then
				self:updateStageData(data.D.Stage)
				self:updateLayer()
			end
		end

		TownHelper.updateSet(self,set,v,self.nStageList,updatecallback,updatecallback)
		--[[
		local dbstage = dbManager.getInfoStage(v)
		local dbTown = dbManager.getInfoTownConfig(dbstage.TownId)
		local dbarea = dbManager.getArea(dbTown.AreaId)
		local isSenior = dbstage.Senior == 1
		local unlock = TownInfo.isTownOpen(dbstage.TownId, isSenior)
		local nTownInfo = gameFunc.getTownInfo().getTownById(dbstage.TownId)
		local nStage = getStageNetData(v)
		local isReset = isStageReset(nStage)
		local isClear = nil
		set['icon']:setResid(string.format('%s.png',dbTown.Town_pic))
		if isSenior then
			isClear = nTownInfo and nTownInfo.SeniorClear or false
			set['name']:setString(string.format('%s-%s(精英)',dbarea.Name,dbTown.Name))
		else
			isClear = nTownInfo and nTownInfo.Clear or false
			set['name']:setString(string.format('%s-%s',dbarea.Name,dbTown.Name))
		end
		if unlock then
			if isClear then
				set['tip']:setString(string.format("挑战次数 %d/%d", nStage.TodayTimes, dbstage.DailyTimes))
				set['tip']:setFontFillColor(Res.color4F.green,true)
			else
				set['tip']:setString('未通关')
				set['tip']:setFontFillColor(Res.color4F.red,true)
			end
		else
			set['tip']:setString('未解锁')
			set['tip']:setFontFillColor(Res.color4F.red,true)
		end
		-- set['btn']:setListener(function ( ... )
		-- 	gotoTown(dbstage.TownId, dbstage.Senior, dbstage.Id)
		-- end)
		set['lock']:setVisible(not (unlock and isClear))

		set["btnBattleSpeed"]:setVisible(not isReset and (isSenior or dbstage.StageType == 1) and isClear)
		set["btnBattleSpeed"]:setListener(function ( ... )
			if self:canBattleSpeed() then
				if userFunc.getAp() < nStage.CostAp then
					Res.doEventAddAP()
				else
					if isSenior then
						TownHelper.stageBattleSpeed(self, nStage, function ( data )
							if data.D.Stage then
								self:updateStageData(data.D.Stage)
								self:updateLayer()
							end				
						end)
					else
						TownHelper.stageChallengeSpeed(self, nStage, function ( data )
							if data.D.Stage then
								self:updateStageData(data.D.Stage)
								self:updateLayer()
							end
						end)
					end
				end	
			else
				self:toast(string.format(Res.locString("Dungeon$BattleSpeedUnlock"), dbManager.getUnLockLvConfig("BattleSpeed")))
			end
		end)
		set["btnReset"]:setVisible(isReset and (isSenior or dbstage.StageType == 1))
		set["btnReset"]:setListener(function ( ... )
			TownHelper.stageReset(self, nStage, function ( data )
				if data.D.Stage then
					self:updateStageData(data.D.Stage)
					self:updateLayer()
				end
			end)
		end)
		]]
	end

	local firstset
	-- self._bg_from_list:getContainer():removeAllChildrenWithCleanup(true)
	-- if stages and #stages > 0 then
	-- 	for i,v in ipairs(stages) do
	-- 		local set = self:createLuaSet('@item')
	-- 		refreshcell(set,v)
	-- 		firstset = firstset or set
	-- 		self._bg_from_list:getContainer():addChild(set[1])
	-- 	end
	-- end
	-- self._bg_from_list:layout()

	self.gotolualist = LuaList.new(self._bg_from_list, function (  )
		local set = self:createLuaSet('@item')
		firstset = firstset or set
		require 'LangAdapter'.LabelNodeAutoShrink(set['btnReset_text'],100)
		require 'LangAdapter'.LabelNodeAutoShrink(set['btnBattleSpeed_text'],100)
		require 'LangAdapter'.LabelNodeAutoShrink(set['btnGoto_text'],100)
		return set
	end, 
	function ( nodeLuaSet, data )
		refreshcell(nodeLuaSet,data)
	end)
	self.gotolualist:update(stages)

	if firstset then
		GuideHelper:registerPoint('item1',firstset['btn'])
	end
end

function DMaterialDetail:canBattleSpeed( ... )
	return userFunc.getLevel() >= dbManager.getUnLockLvConfig("BattleSpeed") or userFunc.getVipLevel() >= 4
end

function DMaterialDetail:updateStageData( nStage )
	if nStage and self.nStageList then
		for i,v in ipairs(self.nStageList) do
			if v.StageId == nStage.StageId then
				self.nStageList[i] = nStage
				break
			end
		end
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DMaterialDetail, "DMaterialDetail")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DMaterialDetail", DMaterialDetail)
