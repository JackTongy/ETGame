local Config = require "Config"
local Res = require 'Res'
local dbManager = require 'DBManager'
local AppData = require 'AppData'
local netModel = require 'netModel'
local eventCenter = require 'EventCenter'
local taskLoginFunc = AppData.getTaskLoginInfo()

local DSevenDayReward = class(LuaDialog)

function DSevenDayReward:createDocument()
		self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DSevenDayReward.cocos.zip")
		return self._factory:createDocument("DSevenDayReward.cocos")
end

--@@@@[[[[
function DSevenDayReward:onInitXML()
    local set = self._set
   self._btnbg = set:getButtonNode("btnbg")
   self._root = set:getElfNode("root")
   self._root_tab = set:getElfNode("root_tab")
   self._root_tab_tabReward = set:getTabNode("root_tab_tabReward")
   self._root_tab_tabReward_title = set:getLabelNode("root_tab_tabReward_title")
   self._root_tab_tabReward_point = set:getElfNode("root_tab_tabReward_point")
   self._root_tab_tabDiscount = set:getTabNode("root_tab_tabDiscount")
   self._root_tab_tabDiscount_title = set:getLabelNode("root_tab_tabDiscount_title")
   self._root_tab_tabDiscount_point = set:getElfNode("root_tab_tabDiscount_point")
   self._root_bgDiscount = set:getElfNode("root_bgDiscount")
   self._root_bgDiscount_light = set:getElfNode("root_bgDiscount_light")
   self._root_bgDiscount_icon = set:getElfNode("root_bgDiscount_icon")
   self._root_bgDiscount_btn = set:getButtonNode("root_bgDiscount_btn")
   self._root_bgDiscount_count = set:getLabelNode("root_bgDiscount_count")
   self._root_bgDiscount_name = set:getLabelNode("root_bgDiscount_name")
   self._root_bgDiscount_price = set:getLabelNode("root_bgDiscount_price")
   self._root_bgDiscount_price_line = set:getElfNode("root_bgDiscount_price_line")
   self._root_bgDiscount_todayPrice = set:getLabelNode("root_bgDiscount_todayPrice")
   self._root_bgDiscount_btnBuyNow = set:getClickNode("root_bgDiscount_btnBuyNow")
   self._root_bgDiscount_lastTime = set:getLabelNode("root_bgDiscount_lastTime")
   self._root_bgDiscount_day = set:getLabelNode("root_bgDiscount_day")
   self._root_bg = set:getElfNode("root_bg")
   self._root_bg_list = set:getListNode("root_bg_list")
   self._tab = set:getTabNode("tab")
   self._name = set:getLabelNode("name")
   self._root_bg_arrow = set:getElfNode("root_bg_arrow")
   self._root_bg_arrow_bottom = set:getElfNode("root_bg_arrow_bottom")
   self._root_bg_arrow_top = set:getElfNode("root_bg_arrow_top")
   self._root_bg_content = set:getElfNode("root_bg_content")
   self._root_bg_content_btnGet = set:getClickNode("root_bg_content_btnGet")
   self._root_bg_content_btnGet_title = set:getLabelNode("root_bg_content_btnGet_title")
   self._root_bg_content_gifts = set:getLinearLayoutNode("root_bg_content_gifts")
   self._content = set:getElfNode("content")
   self._content_pzbg = set:getElfNode("content_pzbg")
   self._content_icon = set:getElfNode("content_icon")
   self._content_pz = set:getElfNode("content_pz")
   self._name = set:getLabelNode("name")
   self._count = set:getLabelNode("count")
   self._btn = set:getButtonNode("btn")
   self._isSuit = set:getSimpleAnimateNode("isSuit")
   self._root_bg_content_des = set:getElfNode("root_bg_content_des")
   self._root_bg_content_des_content = set:getElfNode("root_bg_content_des_content")
   self._light = set:getElfNode("light")
   self._left = set:getElfNode("left")
   self._right = set:getElfNode("right")
   self._content = set:getElfNode("content")
   self._content_pzbg = set:getElfNode("content_pzbg")
   self._content_icon = set:getElfNode("content_icon")
   self._content_pz = set:getElfNode("content_pz")
   self._isSuit = set:getSimpleAnimateNode("isSuit")
   self._name = set:getLabelNode("name")
   self._count = set:getLabelNode("count")
   self._btn = set:getButtonNode("btn")
   self._starLayout = set:getLayoutNode("starLayout")
   self._root_titleBg_text1 = set:getElfNode("root_titleBg_text1")
   self._root_titleBg_text2 = set:getElfNode("root_titleBg_text2")
   self._root_close = set:getButtonNode("root_close")
   self._roate = set:getElfAction("roate")
--   self._@cell = set:getElfNode("@cell")
--   self._@item = set:getElfNode("@item")
--   self._@itemT = set:getElfNode("@itemT")
--   self._@star = set:getElfNode("@star")
end
--@@@@]]]]

--------------------------------override functions----------------------

local Launcher = require 'Launcher'
Launcher.register("DSevenDayReward", function ( userData )
   	Launcher.callNet(netModel.getModelTLGet(),function ( data )
   		print("TLGet")
   		print(data)
		if data then
			taskLoginFunc.setData(data.D.TaskLogin)
		end

		local day = taskLoginFunc.getSevenDiscountDay()
		if (day <= 0 or day >= 8) and taskLoginFunc.isSevenDayRewardDone() then
			eventCenter.eventInput('UpdateSevenDayReward')
			GleeCore:toast(Res.locString("SuperPrice$OutOfTime"))
		else
			Launcher.Launching(data)
		end
   	end)
end)

function DSevenDayReward:onInit( userData, netData )
	Res.doActionDialogShow(self._root)
	self._btnbg:setListener(function ( ... )
		Res.doActionDialogHide(self._root, self)
	end)
	self._root_close:setListener(function ( ... )
		Res.doActionDialogHide(self._root, self)
	end)

	self.tabIndexSelected = 1
	self._root_tab_tabReward:trigger(nil)
	self._root_tab_tabReward_point:setVisible(false)
	self._root_tab_tabReward:setListener(function ( ... )
		if self.tabIndexSelected ~= 1 then
			self.tabIndexSelected = 1
			self:updateLayerSelected()
		end
	end)

	self._root_tab_tabDiscount_point:setVisible(false)
	self._root_tab_tabDiscount:setListener(function ( ... )
		if self.tabIndexSelected ~= 2 then
			self.tabIndexSelected = 2
			self:updateLayerSelected()
		end
	end)
	
	self:updateLayerSelected()

	require 'LangAdapter'.fontSize(self._root_tab_tabReward_title,nil,nil,24,nil,24)
	require 'LangAdapter'.fontSize(self._root_tab_tabDiscount_title,nil,nil,24,nil,24)
	require 'LangAdapter'.LabelNodeAutoShrink(self._root_bg_content_btnGet_title,120)
end

function DSevenDayReward:onBack( userData, netData )
	
end

function DSevenDayReward:close( ... )
	 self:releaseTick()
end
--------------------------------custom code-----------------------------

function DSevenDayReward:updateLayerSelected( ... )
	local day = taskLoginFunc.getSevenDiscountDay()
	local isDiscountDay = day > 0 and day < 8
	local isSevendayRewardUnDone = not taskLoginFunc.isSevenDayRewardDone()

	if not isDiscountDay and not isSevendayRewardUnDone then
		Res.doActionDialogHide(self._root, self)
	else
		if not isDiscountDay then
			self.tabIndexSelected = 1
		elseif not isSevendayRewardUnDone then
			self.tabIndexSelected = 2
		end
		self._root_tab_tabReward:setVisible(isDiscountDay and isSevendayRewardUnDone)
		self._root_tab_tabDiscount:setVisible(isDiscountDay and isSevendayRewardUnDone)
		self._root_bg:setVisible(self.tabIndexSelected == 1)
		self._root_bgDiscount:setVisible(self.tabIndexSelected == 2)
		self._root_titleBg_text1:setVisible(self.tabIndexSelected == 1)
		self._root_titleBg_text2:setVisible(self.tabIndexSelected == 2)
		self._root_bgDiscount_btn:setVisible(self.tabIndexSelected == 2)
		if self.tabIndexSelected == 1 then
			self:updateLayer()
		elseif self.tabIndexSelected == 2 then
			self:updateSuperPrice()
		end
	end
end

function DSevenDayReward:updateSuperPrice( ... )
	local day = taskLoginFunc.getSevenDiscountDay()
	day = math.min(math.max(1, day), 7)
	local dbSevenday =  dbManager.getSevenday(day)
	local dbReward = dbManager.getRewardItem(dbSevenday.Discount)

	local offset = (os.time() - os.time(os.date("!*t"))) / 3600
	print("offset = " .. offset)
	if offset <= 2 then
		offset = offset + 1
	end
	local serverTimeArea = 8
	local curTime = os.date("*t", math.floor(require "TimeManager".getCurrentSeverTime() / 1000))
	curTime.hour = curTime.hour - offset + serverTimeArea
	print("curTime")
	print(curTime)
	if curTime.hour < 0 then
		curTime.hour = curTime.hour + 24
	end
	local time = 24 - curTime.hour % 24
	if time <= 0 then
		time = 24
	end
	self._root_bgDiscount_lastTime:setString(string.format(Res.locString("SuperPrice$LastTime"), time))
	self._root_bgDiscount_day:setString(string.format(Res.locString("SuperPrice$dayTip"), day))
	self._root_bgDiscount_count:setString(string.format("x %d", dbReward.amount))
	self._root_bgDiscount_light:stopAllActions()
	self._root_bgDiscount_light:runElfAction(self._roate:clone()) 

	Res.updateRewardItem(dbReward, self._root_bgDiscount_icon, self._root_bgDiscount_name, nil, self._root_bgDiscount_btn)

	self._root_bgDiscount_price:setString(string.format(Res.locString("SuperPrice$Price"), dbSevenday.Prices[2]))
	self._root_bgDiscount_todayPrice:setString(string.format(Res.locString("SuperPrice$TodayPrice"), dbSevenday.Prices[1]))
	self._root_bgDiscount_btnBuyNow:setEnabled(taskLoginFunc.getSevenDiscountCount() <= 0)
	self._root_bgDiscount_btnBuyNow:setListener(function ( ... )
		self:send(netModel.getModelBuyDiscGood(day), function ( data )
			print("BuyDiscGood")
			print(data)
			if data and data.D then
				if data.D.TaskLogin then
					taskLoginFunc.setData(data.D.TaskLogin)
				end
				if data.D.Resource then
					AppData.updateResource(data.D.Resource)
				else
					self:toast(Res.locString("SuperPrice$BuyErrorTip"))
				end
				Res.doActionGetReward(data.D.Reward)

				self:updateLayerSelected()
			end
		end)
	end)
end

function DSevenDayReward:updateLayer( ... )
	 self:updateList()
	 AppData.getBroadCastInfo().set('seven_days',false)
	 eventCenter.eventInput('EventSevenDays')
end

function DSevenDayReward:selectTab( index )

	 if self._selectTab == index then
			return
	 end
	 self._selectTab = index

	 self:updateContent()

end

function DSevenDayReward:updateList( ... )

	 local taskinfo = AppData.getTaskLoginInfo().getData()
	 if taskinfo then
			
			self._first = nil
			self._last = nil
			self._selectTab = nil
			self._root_bg_list:getContainer():removeAllChildrenWithCleanup(true)

			local firsttab = nil
			local SevenDays = taskinfo.SevenDays
			for i,v in ipairs(SevenDays) do

				 if v <= 2 then
						local str = string.format(Res.locString('SevenDay$TabTitle'),Res.Num[i])
						local set = self:createLuaSet('@cell')
						self._root_bg_list:getContainer():addChild(set[1])
						set['name']:setString(str)

						set['tab']:setListener(function ( ... )
							 self:selectTab(i)
						end)

						if v == 2 and self._selectTab == nil then
							 set['tab']:trigger(nil)
						end

						if self._first == nil then
							 self._first = set[1]
							 firsttab = set['tab']
						else
							 self._last = set[1]   
						end
				 end

			end

			if self._selectTab == nil and firsttab then
				 firsttab:trigger(nil)
			end

			if self._first == nil then

				 self:getLayer():setVisible(false)
				 self:runWithDelay(function ( ... )
						eventCenter.eventInput('SevenDayReward')
						self:updateLayerSelected()
					--	Res.doActionDialogHide(self._root, self)
				 end)
				 
			else
				 self._root_bg_list:layout()
				 self:releaseTick()
				 self:setTick()
			end

	 end

end

function DSevenDayReward:updateContent( ... )
	 local state = AppData.getTaskLoginInfo().getDayState(self._selectTab)
	 self._root_bg_content_btnGet:setEnabled(state == 2)
	 
	 if self._itemTSet == nil then
			self._itemTSet = self:createLuaSet('@itemT')
			self._root_bg_content:addChild(self._itemTSet[1])
			self._itemTSet['light']:runElfAction(self._roate:clone()) 
	 end

	 local dbday = dbManager.getSevenday(self._selectTab)
	 local dbrewards = dbManager.getRewards(dbday.reward)

	 if dbrewards then
			local str,resid,pzindex = self:refreshGiftItem(self._itemTSet,dbrewards[1])
			self._itemTSet['name']:setVisible(true)
			require 'LangAdapter'.LabelNodeAutoShrink(self._itemTSet['name'],140)
			local des = dbday.des or ''
			self:refreshGifts(dbrewards)
	 end

	 self._root_bg_content_btnGet:setListener(function ( ... )
			self:getReward(dbrewards)
	 end)

	 self._root_bg_content_des_content:setResid(string.format('N_DL_wenzi%d.png',self._selectTab))

end

function DSevenDayReward:refreshGifts( dbrewards )
	 
	 self._root_bg_content_gifts:removeAllChildrenWithCleanup(true)

	 for i,v in ipairs(dbrewards) do
			if i > 1 then
				 local itemSet = self:createLuaSet('@item')
				 self._root_bg_content_gifts:addChild(itemSet[1])
				 self:refreshGiftItem(itemSet,v)
			end
	 end
	 
end

function DSevenDayReward:refreshGiftItem( itemSet,dbreward,scale )

	local str,resid,pzindex = Res.getRewardStrAndResId(dbreward.itemtype,dbreward.itemid,dbreward.args)
	
	require 'LangAdapter'.setVisible(itemSet['name'],nil,nil,false,nil,false)
	itemSet['name']:setVisible(false)
	itemSet['name']:setString(str)
	itemSet['content_pzbg']:setResid(resid[1] or '')
	itemSet['content_icon']:setResid(resid[2] or '')
	itemSet['content_pz']:setResid(resid[3] or '')

	itemSet['count']:setString(string.format('x%s',Res.getGoldFormat(tonumber(dbreward.amount),100000)))
	
	if resid[3] then
		itemSet['content_icon']:setScale(135/itemSet['content_icon']:getContentSize().width)
	end

	if itemSet['starLayout'] then
		itemSet['starLayout']:removeAllChildrenWithCleanup(true)
	end
	if itemSet['starLayout'] and dbreward.itemtype == 6 then
		local dbInfo = dbManager.getCharactor(dbreward.itemid)
		require 'PetNodeHelper'.updateStarLayout(itemSet['starLayout'],dbInfo)
	end

	if dbreward.itemtype == 7 then
		local dbequip = dbManager.getInfoEquipment(dbreward.itemid)  
		itemSet['isSuit']:setVisible(dbequip and dbequip.set ~= 0)
	else
		itemSet['isSuit']:setVisible(false)
	end
	------
	if itemSet['btn'] then
	itemSet['btn']:setListener(function ( ... )
		if dbreward.itemtype == 6 then -- 精灵
			GleeCore:showLayer("DPetDetailV", {PetInfo = AppData.getPetInfo().getPetInfoByPetId(dbreward.itemid)})
		elseif dbreward.itemtype == 7 then -- 装备
			local EquipInfo = AppData.getEquipInfo().getEquipInfoByEquipmentID(dbreward.itemid)
			if dbreward.args then
				EquipInfo.Value = dbreward.args[1] or 0
				EquipInfo.Grow = dbreward.args[2] or 0
				EquipInfo.Tp = dbreward.args[3] or 0
			end
			EquipInfo.Rank = AppData.getEquipInfo().getRank(EquipInfo)
			-- GleeCore:showLayer("DEquipInfoWithNoGem", {EquipInfo = EquipInfo})
			GleeCore:showLayer("DEquipDetail",{nEquip = EquipInfo})
		elseif dbreward.itemtype == 8 then -- 宝石
			if dbreward.args then
				GleeCore:showLayer("DGemDetail",{GemInfo = AppData.getGemInfo().getGemByGemID(dbreward.itemid, dbreward.args[1],dbreward.args[2]), ShowOnly = true})
			else
				GleeCore:showLayer("DGemDetail",{GemInfo = AppData.getGemInfo().getGemByGemID(dbreward.itemid, nil,nil), ShowOnly = true})
			end
		elseif dbreward.itemtype == 9 then -- 道具
			if dbreward.args then
				GleeCore:showLayer("DMaterialDetail", {materialId = dbreward.itemid,Seconds = dbreward.args[1], speed = 0})
			else
				GleeCore:showLayer("DMaterialDetail", {materialId = dbreward.itemid})
			end
		end  
	end)

	end

	return str,resid,pzindex
end

function DSevenDayReward:noticeReward( dbrewards )
	
	local msg = '恭喜获得：'
	for k,v in pairs(dbrewards) do
		local str = Res.getRewardStrAndResId(v.itemtype,v.itemid)
		msg = string.format('%s %s',msg,string.format('%sx%d',str,v.amount))
	end  

	self:toast(msg)

end

--net 
function DSevenDayReward:getReward( dbrewards )

	 self:send(netModel.getModelTLLogin(self._selectTab),function ( data )
			
			local callback = function ( ... )
				AppData.updateResource(data.D.Resource)
				AppData.getTaskLoginInfo().getRewardSuc(self._selectTab)
				eventCenter.eventInput('UpdateAp')
				self:updateLayerSelected()
				self:refreshRedPointState()
			end

			if data.D.Reward then
				data.D.Reward.callback = callback
				GleeCore:showLayer('DGetReward',data.D.Reward)
			else
				callback()
			end

			-- self:noticeReward(dbrewards)
	 end)

end

function DSevenDayReward:refreshRedPointState( ... )
	local enable = AppData.getTaskLoginInfo().isHaveState(2)
	if not enable then
		self:sendBackground(netModel.getModelRoleNewsUpdate('seven_days',false),function ( ... )
			 eventCenter.eventInput('EventSevenDays')
		end)
	end
end

function DSevenDayReward:setTick( ... )
	-- body

	local listsize = self._root_bg_list:getContentSize()

	local  fUpdateTime = function ( ... )
		local  fisrt = self._first
		local last = self._last
		
		local firstPos = NodeHelper:getPositionInScreen(fisrt)
		local lastPos = NodeHelper:getPositionInScreen(last)
		local listPos = NodeHelper:getPositionInScreen(self._root_bg_list)

		local bShow = false
		local tShow = false
		if firstPos.y - listPos.y > listsize.height/2 then
			tShow = true
		end
	
		if lastPos.y - listPos.y < -listsize.height/2 then
			bShow = true
		end

		self._root_bg_arrow_bottom:setVisible(bShow)
		self._root_bg_arrow_top:setVisible(tShow)
	end

	if self.tick == nil and self.handle == nil then
		local tick = require 'framework.sync.TimerHelper'
			self.tick = tick
			self.handle = tick.tick(fUpdateTime,0.4)
	end

	fUpdateTime()

end

function DSevenDayReward:releaseTick(  )
	 if self.handle and self.tick then
			self.tick.cancel(self.handle)
			self.tick = nil
			self.handle = nil
	 end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DSevenDayReward, "DSevenDayReward")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DSevenDayReward", DSevenDayReward)
