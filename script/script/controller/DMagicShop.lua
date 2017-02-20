local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local netModel = require "netModel"
local eventCenter = require 'EventCenter'
local UnlockManager = require "UnlockManager"

local DMagicShop = class(LuaDialog)

function DMagicShop:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DMagicShop.cocos.zip")
    return self._factory:createDocument("DMagicShop.cocos")
end

--@@@@[[[[
function DMagicShop:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_curHasLayout_count1 = set:getLabelNode("bg_curHasLayout_count1")
    self._bg_curHasLayout_count2 = set:getLabelNode("bg_curHasLayout_count2")
    self._bg_listbg_list = set:getListNode("bg_listbg_list")
    self._layout = set:getLinearLayoutNode("layout")
    self._bg_icon = set:getElfNode("bg_icon")
    self._bg_iconBtn = set:getButtonNode("bg_iconBtn")
    self._bg_count = set:getLabelNode("bg_count")
    self._bg_name = set:getLabelNode("bg_name")
    self._bg_linearlayout_icon = set:getElfNode("bg_linearlayout_icon")
    self._bg_linearlayout_price = set:getLabelNode("bg_linearlayout_price")
    self._bg_buyBtn = set:getClickNode("bg_buyBtn")
    self._bg_buyBtn_label = set:getLabelNode("bg_buyBtn_label")
    self._bg_layout1_time = set:getTimeNode("bg_layout1_time")
    self._bg_layout2_count = set:getLabelNode("bg_layout2_count")
    self._bg_layout2_label2 = set:getLabelNode("bg_layout2_label2")
    self._bg_updateBtn = set:getClickNode("bg_updateBtn")
    self._bg_topBar_btnHelp = set:getButtonNode("bg_topBar_btnHelp")
    self._bg_topBar_btnReturn = set:getButtonNode("bg_topBar_btnReturn")
    self._bg_immoBtn = set:getClickNode("bg_immoBtn")
--    self._@line = set:getElfNode("@line")
--    self._@item = set:getElfNode("@item")
--    self._@starLayout = set:getLayoutNode("@starLayout")
--    self._@star = set:getElfNode("@star")
end
--@@@@]]]]

local Launcher = require 'Launcher'

Launcher.register('DMagicShop',function ( userData )
	if UnlockManager:isUnlock("MagicShop") then
		Launcher.callNet(netModel.getModelPetGetPieces(),function ( data )
			require "AppData".getPetInfo().setPetPieces(data.D.Pieces)
			if require "GuideHelper":inGuide("GCfgUnlockLv5") then
				Launcher.callNet(netModel.getmodelMagicShopGetOnGuide(),function ( data )
					Launcher.Launching(data)   
				end)
			else
				Launcher.callNet(netModel.getmodelMagicShopGet(),function ( data )
					Launcher.Launching(data)   
				end)
			end
		end)
	else
		return GleeCore:toast(UnlockManager:getUnlockConditionMsg("MagicShop"))
	end
end)

--------------------------------override functions----------------------
function DMagicShop:onInit( userData, netData )
	require "LangAdapter".nodePos(self._set:getLinearLayoutNode("bg_#layout2"),nil,nil,ccp(106,-215),ccp(106,-215),ccp(106,-215))

	require "LangAdapter".LabelNodeAutoShrink(self._set:getLabelNode("bg_updateBtn_#label"),108)
	require "LangAdapter".LabelNodeAutoShrink(self._set:getLabelNode("bg_immoBtn_#label"),108)

	require "LangAdapter".nodePos(self._set:getLinearLayoutNode("bg_#curHasLayout"),nil,nil,nil,nil,nil,nil,nil,nil,nil,ccp(-369,-229))
	require "LangAdapter".nodePos(self._set:getLinearLayoutNode("bg_#layout1"),nil,nil,nil,nil,nil,nil,nil,nil,nil,ccp(-369,-175))
	require "LangAdapter".nodePos(self._set:getLinearLayoutNode("bg_#layout2"),nil,nil,nil,nil,nil,nil,nil,nil,nil,ccp(0,-199))

	res.doActionDialogShow(self._bg,function ( ... )
		self:guideNotify()
	end)

	eventCenter.addEventFunc("OnAppStatChange", function ( state )
		if state == 2 then
			self:updateTimer()
			-- 刷新商品
			if require "GuideHelper":inGuide("GCfgUnlockLv5") then
				self:send(netModel.getmodelMagicShopGetOnGuide(),function ( data )
					self.mData = data.D.Items
					self:updateList()
					self:guideNotify()
				end)
			else
				self:send(netModel.getmodelMagicShopGet(),function ( data )
					self.mData = data.D.Items
					self:updateList()
				end)
			end
		end
	end, "DMagicShop")

	self.mData = netData.D.Items
	self.mUpdatePrice = 30
	local vipInfo = dbManager.getVipInfo(require "UserInfo".getVipLevel())
	self.mRefreshCount = vipInfo.ExShop - netData.D.Times

	self:addBtnListener()
	self:updateView()
end

function DMagicShop:onBack( userData, netData )
	self:guideNotify()
end

function DMagicShop:guideNotify( ... )
	require 'GuideHelper':registerPoint('兑换',self._firstBtn)
	require 'GuideHelper':registerPoint('献祭',self._bg_immoBtn)
	require 'GuideHelper':check('DMagicShop')
end

--------------------------------custom code-----------------------------
function DMagicShop:addBtnListener( ... )
	self.close = function ( ... )
		eventCenter.resetGroup("DMagicShop")
	end

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_topBar_btnHelp:setListener(function (  )
		GleeCore:showLayer("DHelp", {type = "黑市"})
	end)
	self._bg_topBar_btnReturn:setTriggleSound(res.Sound.back)
	self._bg_topBar_btnReturn:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_immoBtn:setListener(function ( ... )
		GleeCore:showLayer('DPetList',{tab=3,callback = function ( ... )
			self:updateView()
		end})
	end)

	self._bg_updateBtn:setListener(function ( ... )
		if self.mRefreshCount <=0 then
			if require "UserInfo".getVipLevel()<15 then
				local param = {}
				param.content = res.locString("Activity$MagicShopRefreshBuyTip")
				param.RightBtnText = res.locString("Global$BtnRecharge")
				param.callback = function ( ... )
					GleeCore:showLayer("DRecharge")
				end
				GleeCore:showLayer("DConfirmNT",param)
			else
				return self:toast(res.locString("Activity$MagicShopNoRefreshCountTip"))
			end
		else
			local user = require "UserInfo"
			if user.getCoin()<self.mUpdatePrice then
				require "Toolkit".showDialogOnCoinNotEnough()
			else
				local func = function (  )
					self:send(netModel.getmodelMagicShopRefresh(false),function ( data )
						print(data)
		                                  local coin = user.getCoin()
		                                  coin = coin - self.mUpdatePrice
		                                  user.setCoin(coin)
		                                  eventCenter.eventInput("UpdateGoldCoin")
		                                  self.mData = data.D.Items
		                                  self:updateList()
						self.mRefreshCount = self.mRefreshCount - 1
						self._bg_curHasLayout_count2:setString(require "UserInfo".getCoin())
					end)
				end
				if require 'Config'.LangName == 'kor' then
					GleeCore:showLayer('DConfirmNT',{content="진행하시겠습니까?",callback=func})
				else
					func()
				end
			end
		end
	end)
end

function DMagicShop:updateView( ... )
	self._bg_curHasLayout_count1:setString(require "UserInfo".getSoul())
	self._bg_curHasLayout_count2:setString(require "UserInfo".getCoin())
	self:updateTimer()
	self:updateList()
end

function DMagicShop:updateTimer( ... )
	local t = require "TimeManager".getCurrentSeverDate()
	local nextH = t.hour%2==0 and t.hour+2 or t.hour+1
	local lasttime = (nextH - t.hour)*3600 - t.min*60 - t.sec
	self._bg_layout1_time:setHourMinuteSecond(require "TimeListManager".getTimeInfoBySeconds(lasttime))
	self._bg_layout1_time:setUpdateRate(-1)
	if not self.mTimeListener then
		self.mTimeListener = ElfDateListener:create(function ( ... )
			self.mTimeListener = nil
			self._bg_layout1_time:setUpdateRate(0)
			self:send(netModel.getmodelMagicShopRefresh(true,nextH%24),function ( data )
				print(data)
				self.mData = data.D.Items
				self:updateList()
				self:updateTimer()
			end)
		end)
		self.mTimeListener:setHourMinuteSecond(0,0,0)
		self._bg_layout1_time:addListener(self.mTimeListener)
	end
	self._bg_layout2_count:setString(self.mUpdatePrice)
end

function DMagicShop:updateList( x,y )
	self._bg_listbg_list:getContainer():removeAllChildrenWithCleanup(true)
	local index = 0
	local line
	table.foreach(self.mData,function ( _,v )
		local set = self:createLuaSet("@item")
		if index%4 == 0 then
			line = self:createLuaSet("@line")
			self._bg_listbg_list:addListItem(line[1])
		end
		line["layout"]:addChild(set[1])
		index = index + 1

		local buyFunc

		-- local count = v.IsExchange and 0 or 1
		-- set["bg_count"]:setString(string.format(res.locString("Global$BuyLimitTip"),count))
		-- if count<=0 then
		-- 	set["bg_count"]:setFontFillColor(res.color4F.red,true)
		-- end
		-- set["bg_count"]:setVisible(false)
		set["bg_count"]:setString("x".. v.Amount)

		set["bg_linearlayout_icon"]:setResid(v.Type == 7 and  "N_TY_baoshi1.png" or "N_TY_jinglingzhihun1.png")
		set["bg_linearlayout_price"]:setString(v.Consume)
		local enable = true
		local enough = v.Type == 7 and (require "UserInfo".getCoin()>=v.Consume) or (require "UserInfo".getSoul()>=v.Consume)
		if not enough then
			set["bg_linearlayout_price"]:setFontFillColor(res.color4F.red,true)
			enable = false
		end
		if v.IsExchange then
			-- set["layout_buyCount"]:setFontFillColor(res.color4F.red,true)
			set["bg_buyBtn_label"]:setString(res.locString("Activity$MagicShopHasBuy"))
			enable = false
		end
		require "LangAdapter".LabelNodeAutoShrink(set["bg_buyBtn_label"],108)
		require "LangAdapter".LabelNodeAutoShrink(set["bg_name"],168)

		local name,desForBuyDialog
		if enable then
			buyFunc = function ( ... )
				local param = {}
				param.content = string.format(res.locString("Activity$MagicShopBuyConfirm"),v.Type == 7 and "TY_jinglingshi_xiao.png" or "TY_jinglingzhihun1.png",v.Consume,desForBuyDialog)
				print(param.content)
				param.callback = function ( ... )
					self:send(netModel.getmodelMagicShopBuy(v.Id),function ( data )
						print(data)
						local appFunc = require "AppData"
						appFunc.updateResource(data.D.Resource)
						v.IsExchange = true
						self._bg_curHasLayout_count1:setString(require "UserInfo".getSoul())
						self._bg_curHasLayout_count2:setString(require "UserInfo".getCoin())
						self:updateList(self._bg_listbg_list:getContainer():getPosition())
						GleeCore:showLayer("DGetReward", data.D.Reward)
					end)
				end
				GleeCore:showLayer("DConfirmNT",param)
			end
			set["bg_buyBtn"]:setListener(function ( ... )
				buyFunc()
			end)
		else
			set["bg_buyBtn"]:setEnabled(false)
		end
		if index == 1 then
			self._firstBtn = set['bg_buyBtn']
		end
		if v.Type == 6 or v.Type == 10 then--pet
			local pet = require "PetInfo".getPetInfoByPetId(v.ItemId)
			res.setPetDetail(set["bg_icon"],pet,v.Type == 10)
			name = pet.Name
			if v.Type == 10 then
				-- name = name..res.locString("Global$Fragment")
				desForBuyDialog = name..res.locString("Global$Fragment")
				if require 'Config'.LangName ~= "vn" then
					name = name..string.format(res.locString("Activity$MagicShopCurHas"),require "PetInfo".getPetPieceAmount(v.ItemId))
				end
				-- name = name..string.format("%d/%d",require "PetInfo".getPetPieceAmount(v.ItemId),dbManager.getMixConfig(pet.Star,pet.quality).Compose)
			end
			local starLayout = self:createLuaSet("@starLayout")[1]
			require "PetNodeHelper".updateStarLayout(starLayout,nil,v.ItemId)
			-- for j=1,pet.Star do
			-- 	local star = self:createLuaSet("@star")[1]
			-- 	star:setResid(res.getStarResid(0))
			-- 	starLayout:addChild(star)
			-- end
			set["#bg"]:addChild(starLayout)
			set["bg_iconBtn"]:setListener(function ( ... )
				GleeCore:showLayer("DPetDetailV",{PetInfo = pet,FromShop = true,Callback = buyFunc,BtnText = set["bg_buyBtn_label"]:getString()})
			end)
		elseif v.Type == 7 then--equip
			local equip = require "EquipInfo".getEquipInfoByEquipmentID(v.ItemId)
			res.setEquipDetail(set["bg_icon"],equip)
			name = equip.Name
			set["bg_name"]:setFontFillColor(res.getEquipColor(equip.Color),true)
			set["bg_iconBtn"]:setListener(function ( ... )
				GleeCore:showLayer("DEquipDetail",{nEquip = equip})
				-- GleeCore:showLayer("DEquipInfoWithNoGem",{EquipInfo = equip,FromShop = true,Callback = buyFunc,BtnText = set["bg_buyBtn_label"]:getString()})
			end)
		elseif v.Type == 8 then--gem
			local gem = require "GemInfo".getGemByGemID(v.ItemId,v.Lv)
			res.setGemDetail(set["bg_icon"],gem)
			name = string.format("%sLv%d",gem.Name,gem.Lv)
			set["bg_iconBtn"]:setListener(function ( ... )
				GleeCore:showLayer("DGemDetail",{GemInfo = gem,ShowOnly = true})
			end)
		elseif v.Type == 9 then--materials
			local material = require "BagInfo".getItemByMID(v.ItemId)
			res.setItemDetail(set["bg_icon"],material)
			local info = dbManager.getInfoMaterial(v.ItemId)
			name = info.name
			
			-- set["bg_name"]:setFontFillColor(ccc4f(0.97,0.66,0.07,1),true)
			set["bg_iconBtn"]:setListener(function ( ... )
				GleeCore:showLayer("DMaterialDetail",{materialId = v.ItemId})
			end)
		end
		desForBuyDialog = desForBuyDialog or name
		desForBuyDialog = string.format(" %sx%d",desForBuyDialog,v.Amount)
		set["bg_name"]:setString(name)

		if not v.IsExchange and v.Type == 7 and (require "UserInfo".getCoin() < v.Consume) then
			set["bg_buyBtn"]:setEnabled(true)
			set["bg_buyBtn"]:setListener(function ( ... )
				local param = {}
				param.content = res.locString("Recharge$CoinNotEnoughDialogContent")
				param.RightBtnText = res.locString("Global$BtnRecharge")
				param.callback = function ( ... )
					GleeCore:showLayer("DRecharge")
				end
				GleeCore:showLayer("DConfirmNT", param)
			end)
		end
	end)
  	self._bg_listbg_list:layout()
  	if x then
  		self._bg_listbg_list:getContainer():setPosition(x,y)
  	end

  	require 'GuideHelper':registerPoint('兑换',self._firstBtn)
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DMagicShop, "DMagicShop")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DMagicShop", DMagicShop)


