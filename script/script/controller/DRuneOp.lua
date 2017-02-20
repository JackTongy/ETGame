local Config = require "Config"
local res = require "Res"
local DBManager = require "DBManager"
local Toolkit = require "Toolkit"
local netModel = require "netModel"
local eventcenter = require "EventCenter"
local RuneFunc = require "RuneInfo"
local userFunc = require "UserInfo"

local DRuneOp = class(LuaDialog)

function DRuneOp:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DRuneOp.cocos.zip")
    return self._factory:createDocument("DRuneOp.cocos")
end

--@@@@[[[[
function DRuneOp:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_rightBg = set:getElfNode("bg_rightBg")
    self._bg_rightBg_subTitle = set:getLabelNode("bg_rightBg_subTitle")
    self._bg_rightBg_hasLayout_coinCount = set:getLabelNode("bg_rightBg_hasLayout_coinCount")
    self._bg_rightBg_hasLayout_magicStoneCount = set:getLabelNode("bg_rightBg_hasLayout_magicStoneCount")
    self._tip = set:getLabelNode("tip")
    self._lvupBtn = set:getClickNode("lvupBtn")
    self._lvupBtn_btntext = set:getLabelNode("lvupBtn_btntext")
    self._priceLayout = set:getLinearLayoutNode("priceLayout")
    self._priceLayout_price = set:getLabelNode("priceLayout_price")
    self._icon = set:getElfNode("icon")
    self._strengthenAnim = set:getSimpleAnimateNode("strengthenAnim")
    self._name = set:getLabelNode("name")
    self._equipLayout = set:getLinearLayoutNode("equipLayout")
    self._equipLayout_equipName = set:getLabelNode("equipLayout_equipName")
    self._lvUpIcon = set:getElfNode("lvUpIcon")
    self._btn = set:getButtonNode("btn")
    self._tip = set:getLabelNode("tip")
    self._layout = set:getLinearLayoutNode("layout")
    self._layout_left = set:getElfNode("layout_left")
    self._layout_left_icon = set:getElfNode("layout_left_icon")
    self._layout_left_name = set:getLabelNode("layout_left_name")
    self._layout_left_btn = set:getButtonNode("layout_left_btn")
    self._layout_right = set:getElfNode("layout_right")
    self._layout_right_icon = set:getElfNode("layout_right_icon")
    self._layout_right_name = set:getLabelNode("layout_right_name")
    self._layout_right_btn = set:getButtonNode("layout_right_btn")
    self._count = set:getLabelNode("count")
    self._btn = set:getClickNode("btn")
    self._btn_btntext = set:getLabelNode("btn_btntext")
    self._priceLayout_price = set:getLabelNode("priceLayout_price")
    self._equipLayout = set:getLinearLayoutNode("equipLayout")
    self._equipLayout_equipName = set:getLabelNode("equipLayout_equipName")
    self._bg_item1 = set:getElfNode("bg_item1")
    self._bg_item1_btn = set:getTabNode("bg_item1_btn")
    self._bg_item2 = set:getElfNode("bg_item2")
    self._bg_item2_btn = set:getTabNode("bg_item2_btn")
    self._bg_item3 = set:getElfNode("bg_item3")
    self._bg_item3_btn = set:getTabNode("bg_item3_btn")
    self._bg_item4 = set:getElfNode("bg_item4")
    self._bg_item4_btn = set:getTabNode("bg_item4_btn")
    self._tip = set:getLabelNode("tip")
    self._addBtn = set:getClickNode("addBtn")
    self._addBtn_btntext = set:getLabelNode("addBtn_btntext")
    self._count = set:getLabelNode("count")
    self._m1 = set:getElfNode("m1")
    self._m1_btnImg = set:getElfNode("m1_btnImg")
    self._m1_btn = set:getButtonNode("m1_btn")
    self._m1_anim = set:getSimpleAnimateNode("m1_anim")
    self._m2 = set:getElfNode("m2")
    self._m2_btnImg = set:getElfNode("m2_btnImg")
    self._m2_btn = set:getButtonNode("m2_btn")
    self._m2_anim = set:getSimpleAnimateNode("m2_anim")
    self._m3 = set:getElfNode("m3")
    self._m3_btnImg = set:getElfNode("m3_btnImg")
    self._m3_btn = set:getButtonNode("m3_btn")
    self._m3_anim = set:getSimpleAnimateNode("m3_anim")
    self._m4 = set:getElfNode("m4")
    self._m4_btnImg = set:getElfNode("m4_btnImg")
    self._m4_btn = set:getButtonNode("m4_btn")
    self._m4_anim = set:getSimpleAnimateNode("m4_anim")
    self._m5 = set:getElfNode("m5")
    self._m5_btnImg = set:getElfNode("m5_btnImg")
    self._m5_btn = set:getButtonNode("m5_btn")
    self._m5_anim = set:getSimpleAnimateNode("m5_anim")
    self._resolveBtn = set:getClickNode("resolveBtn")
    self._resolveBtn_btntext = set:getLabelNode("resolveBtn_btntext")
    self._bg = set:getElfNode("bg")
    self._bg_itemMerge0 = set:getElfNode("bg_itemMerge0")
    self._bg_itemMerge0_icon = set:getElfNode("bg_itemMerge0_icon")
    self._bg_itemMerge0_tip = set:getLabelNode("bg_itemMerge0_tip")
    self._bg_itemMerge0_lock = set:getElfNode("bg_itemMerge0_lock")
    self._bg_itemMerge0_btn = set:getButtonNode("bg_itemMerge0_btn")
    self._bg_itemMerge0_anim = set:getSimpleAnimateNode("bg_itemMerge0_anim")
    self._bg_itemMerge1 = set:getElfNode("bg_itemMerge1")
    self._bg_itemMerge1_icon = set:getElfNode("bg_itemMerge1_icon")
    self._bg_itemMerge1_tip = set:getLabelNode("bg_itemMerge1_tip")
    self._bg_itemMerge1_lock = set:getElfNode("bg_itemMerge1_lock")
    self._bg_itemMerge1_btn = set:getButtonNode("bg_itemMerge1_btn")
    self._bg_itemMerge1_anim = set:getSimpleAnimateNode("bg_itemMerge1_anim")
    self._bg_itemMerge2 = set:getElfNode("bg_itemMerge2")
    self._bg_itemMerge2_icon = set:getElfNode("bg_itemMerge2_icon")
    self._bg_itemMerge2_tip = set:getLabelNode("bg_itemMerge2_tip")
    self._bg_itemMerge2_lock = set:getElfNode("bg_itemMerge2_lock")
    self._bg_itemMerge2_btn = set:getButtonNode("bg_itemMerge2_btn")
    self._bg_itemMerge2_anim = set:getSimpleAnimateNode("bg_itemMerge2_anim")
    self._bg_itemMerge3 = set:getElfNode("bg_itemMerge3")
    self._bg_itemMerge3_icon = set:getElfNode("bg_itemMerge3_icon")
    self._bg_itemMerge3_tip = set:getLabelNode("bg_itemMerge3_tip")
    self._bg_itemMerge3_lock = set:getElfNode("bg_itemMerge3_lock")
    self._bg_itemMerge3_btn = set:getButtonNode("bg_itemMerge3_btn")
    self._bg_itemMerge3_anim = set:getSimpleAnimateNode("bg_itemMerge3_anim")
    self._layoutCost = set:getLinearLayoutNode("layoutCost")
    self._layoutCost_k = set:getElfNode("layoutCost_k")
    self._layoutCost_v = set:getLabelNode("layoutCost_v")
    self._mergeBtn = set:getClickNode("mergeBtn")
    self._mergeBtn_btntext = set:getLabelNode("mergeBtn_btntext")
    self._bg_fpLeft_leftBg_list = set:getListNode("bg_fpLeft_leftBg_list")
    self._icon = set:getElfNode("icon")
    self._titleLabel = set:getLabelNode("titleLabel")
    self._gemCount = set:getLabelNode("gemCount")
    self._layout = set:getLinearLayoutNode("layout")
    self._scale_btn = set:getButtonNode("scale_btn")
    self._scale_icon = set:getElfNode("scale_icon")
    self._title = set:getLabelNode("title")
    self._selectIcon = set:getElfNode("selectIcon")
    self._equipIcon = set:getElfNode("equipIcon")
    self._bg_fpLeft_leftBg_emptyView = set:getElfNode("bg_fpLeft_leftBg_emptyView")
    self._bg_topBar_btnHelp = set:getButtonNode("bg_topBar_btnHelp")
    self._bg_topBar_btnReturn = set:getButtonNode("bg_topBar_btnReturn")
    self._bg_topBar_tabStrengthen = set:getTabNode("bg_topBar_tabStrengthen")
    self._bg_topBar_tabReborn = set:getTabNode("bg_topBar_tabReborn")
    self._bg_topBar_tabResolve = set:getTabNode("bg_topBar_tabResolve")
    self._bg_topBar_tabMerge = set:getTabNode("bg_topBar_tabMerge")
    self._screenBtn = set:getButtonNode("screenBtn")
--    self._@pageStrengthen = set:getElfNode("@pageStrengthen")
--    self._@pageReborn = set:getElfNode("@pageReborn")
--    self._@anim = set:getSimpleAnimateNode("@anim")
--    self._@addIcon = set:getElfNode("@addIcon")
--    self._@ex = set:getElfNode("@ex")
--    self._@pageResolve = set:getElfNode("@pageResolve")
--    self._@pageMerge = set:getElfNode("@pageMerge")
--    self._@title = set:getElfNode("@title")
--    self._@gemLine = set:getElfNode("@gemLine")
--    self._@gemItem = set:getElfNode("@gemItem")
end
--@@@@]]]]

local ViewType = {Strengthen = 1,Reborn = 2,Resolve = 3, Merge = 4}

--------------------------------override functions----------------------
function DRuneOp:onInit( userData, netData )
	selectLang(nil,nil,nil,nil,function (  )
		local maxW = 72
		-- self._set:getLabelNode("bg_topBar_tabChampion_normal_#title"):setDimensions(CCSize(0,0))
		-- self._set:getLabelNode("bg_topBar_tabChampion_pressed_#title"):setDimensions(CCSize(0,0))
		-- self._set:getLabelNode("bg_topBar_tabChampion_invalid_#title"):setDimensions(CCSize(0,0))

		-- self._set:getLabelNode("bg_topBar_tabRank_normal_#title"):setDimensions(CCSize(0,0))
		-- self._set:getLabelNode("bg_topBar_tabRank_pressed_#title"):setDimensions(CCSize(0,0))
		-- self._set:getLabelNode("bg_topBar_tabRank_invalid_#title"):setDimensions(CCSize(0,0))
		
		-- self._set:getLabelNode("bg_topBar_tabShop_normal_#title"):setDimensions(CCSize(0,0))
		-- self._set:getLabelNode("bg_topBar_tabShop_pressed_#title"):setDimensions(CCSize(0,0))
		-- self._set:getLabelNode("bg_topBar_tabShop_invalid_#title"):setDimensions(CCSize(0,0))

		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabStrengthen_normal_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabStrengthen_pressed_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabStrengthen_invalid_#title"),maxW)

		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabReborn_normal_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabReborn_pressed_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabReborn_invalid_#title"),maxW)

		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabResolve_normal_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabResolve_pressed_#title"),maxW)
		require 'LangAdapter'.LabelNodeAutoShrink(self._set:getLabelNode("bg_topBar_tabResolve_invalid_#title"),maxW)
	end)
	require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
		self._set:getLabelNode("bg_topBar_tabMerge_normal_#title"):setString("Kombi")
		self._set:getLabelNode("bg_topBar_tabMerge_pressed_#title"):setString("Kombi")
		self._set:getLabelNode("bg_topBar_tabMerge_invalid_#title"):setString("Kombi")
	end)

	self.mCurRune = userData.RuneData
	self.cachedUpdateFunc = nil
	self.views = {}
	self.tickHandle = {}
	self.animFinishFuncs = {}
	self.effectIds = {}

	self:init()
	local showViewType = userData.ViewType or ViewType.Strengthen
	if showViewType ~= ViewType.Resolve and showViewType ~= ViewType.Merge then	
		local item = self.mItems[self.mCurRune]
		print("CurListIndex----"..self.mItems[self.mCurRune].mListIndex)
		self._bg_fpLeft_leftBg_list:alignTo(item.mListIndex<5 and  0 or item.mListIndex-1)
	end
	local btns = self:addTopBtnListener()
	require "framework.sync.TimerHelper".tick(function ( ... )
		btns[showViewType]:trigger(nil)
	      	return true
	end)
end

function DRuneOp:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function DRuneOp:addTopBtnListener( ... )
	local tabBtns = {[ViewType.Strengthen] = self._bg_topBar_tabStrengthen,
				[ViewType.Reborn] = self._bg_topBar_tabReborn,
				[ViewType.Resolve] = self._bg_topBar_tabResolve,
				[ViewType.Merge] = self._bg_topBar_tabMerge}
	table.foreach(tabBtns,function ( viewType,tabBtn )
		tabBtn:setListener(function (  )
			if self.curViewType~=viewType then
				self:onTabChanged()
				local preViewType = self.curViewType
				self.curViewType = viewType
				if (self.curViewType == ViewType.Resolve or preViewType == ViewType.Resolve) or
					(self.curViewType == ViewType.Merge or preViewType == ViewType.Merge) then
					self:showRuneList()
				end
				self:updateView()
			end
		end)
	end)

	self.close = function ( ... )
		for _,v in pairs(self.mItems) do
			v[1]:release()
		end
		for _,v in ipairs(self.mTitles) do
			v[1]:release()
		end
		if self.cachedAddIcon then
			self.cachedAddIcon:release()
		end
		if self.cachedExSet then
			self.cachedExSet[1]:release()
		end
		self:onTabChanged()
		self.curViewType = 0
	end

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_topBar_btnHelp:setListener(function (  )
		GleeCore:showLayer("DHelp", {type = "符文"})
	end)
	self._bg_topBar_btnReturn:setTriggleSound(res.Sound.back)
	self._bg_topBar_btnReturn:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)

	self._screenBtn:setPenetrate(false)
	self._screenBtn:setTriggleSound("")
	self._screenBtn:setListener(function ( ... )
		if #self.animFinishFuncs>0 then
			self:finishAnims()
			if self.cachedViewUpdateFunc then
				self.cachedViewUpdateFunc()
				self.cachedViewUpdateFunc = nil
			else
				if self.curViewType == ViewType.Strengthen then
					return self:showStrengthenView()
				elseif self.curViewType == ViewType.Reborn then
					return self:showRebornView()
				elseif self.curViewType == ViewType.Resolve then
					return self:showResolveView()
				elseif self.curViewType == ViewType.Merge then
					return self:showMergeView()
				end
			end
		end
	end)
	self._screenBtn:setVisible(false)
 
	return tabBtns
end

function DRuneOp:finishAnims( ... )
	for _,v in ipairs(self.animFinishFuncs) do
		v()
	end
	self.animFinishFuncs = {}

	if self.cachedUpdateFunc then
		self.cachedUpdateFunc()
		self.cachedUpdateFunc = nil
	end
	for _,v in ipairs(self.tickHandle) do
		require "framework.sync.TimerHelper".cancel(v)
	end
	self.tickHandle = {}

	self._screenBtn:setVisible(false)
end

function DRuneOp:onTabChanged( )
	self:finishAnims()
	self:hiddenToast()
	self.cachedViewUpdateFunc = nil

	self.mResolveList = {}
end

function DRuneOp:updateView( ... )
	local funcViewMap = {[ViewType.Strengthen] = self.showStrengthenView,
				[ViewType.Reborn] = self.showRebornView,
				[ViewType.Resolve] = self.showResolveView,
				[ViewType.Merge] = self.showMergeView}
	table.foreach(ViewType,function ( _,v )
		if self.curViewType == v then
			funcViewMap[v](self)
			self.views[v][1]:setVisible(true)
		else
			if self.views[v] then
				self.views[v][1]:setVisible(false)
			end
		end
	end)
end

function DRuneOp:showRuneList(  )
	self.mTitles = self.mTitles or {}
	self.mItems = self.mItems or {}
	local runes
	local r = {0,90,-90,180}
	local listIndex = 0
	self._bg_fpLeft_leftBg_list:getContainer():removeAllChildrenWithCleanup(true)

	local MergeLocation
	if self.curViewType == ViewType.Merge and self.mMergeList and #self.mMergeList > 0 then
		MergeLocation = DBManager.getInfoRune(self.mMergeList[1].RuneId).Location
	end

	for i=1,4 do
		if not MergeLocation or MergeLocation == i then
			runes = require "RuneInfo".selectByCondition(function ( v )
				if self.curViewType == ViewType.Resolve and v.SetIn>0 then
					return false
				elseif self.curViewType == ViewType.Merge and v.Star ~= 4 then
					return false
				else
					local dbinfo = DBManager.getInfoRune(v.RuneId)
					return dbinfo.Location == i
				end
			end)

			local title = self.mTitles[i]
			if not title then
				title = self:createLuaSet("@title")
				title["icon"]:setRotation(r[i])
				if Config.LangName == "vn" then
					title["titleLabel"]:setString(res.locString("Rune$Rune")..res.locString(string.format("Rune$RuneType%d",i)))
				elseif Config.LangName == "PT" or Config.LangName == "ES" then
					title["titleLabel"]:setString(res.locString(string.format("Rune$RuneType%d",i)))
				else
					title["titleLabel"]:setString(res.locString(string.format("Rune$RuneType%d",i))..res.locString("Rune$Rune"))
				end
					
				self.mTitles[i] = title
				title[1]:retain()
			end
			title["gemCount"]:setString(string.format(res.locString("Gem$GemCount"),#runes))
			self._bg_fpLeft_leftBg_list:addListItem(title[1])
			listIndex = listIndex + 1
			if #runes>0 then
				local index = 0
				local gemLine = nil
				table.sort(runes,function ( a,b )
					if self.curViewType == ViewType.Resolve then
						return require "RuneInfo".commonSortFunc1(a,b)
					elseif self.curViewType == ViewType.Merge then
						if MergeLocation then
							if self.mMergeList[1].Id == a.Id then
								return true
							elseif self.mMergeList[1].Id == b.Id then
								return false
							else
								return require "RuneInfo".commonSortFunc1(a,b)
							end
						else
							return require "RuneInfo".commonSortFunc(a,b)
						end
					else
						return require "RuneInfo".commonSortFunc(a,b)
					end
				end)
				for _,v in ipairs(runes) do
					self.mCurRune = self.mCurRune or v

					local item = self.mItems[v]
					if not item then
						item = self:createLuaSet("@gemItem")
						item["title"]:setString(Toolkit.getRuneName(v.RuneId))
						item["equipIcon"]:setVisible(v.SetIn>0)
						self.mItems[v] = item
						item[1]:retain()
					end
					item["selectIcon"]:setVisible(MergeLocation and table.find(self.mMergeList, v))
					res.setNodeWithRune(item["scale_icon"],v.RuneId,v.Star,v.Lv)
					item["scale_btn"]:setListener(function (  )
						self.mOnItemClicked[self.curViewType](item,v)
					end)
					
					if index%4 == 0 then
	   				gemLine = self:createLuaSet("@gemLine")
	   				self._bg_fpLeft_leftBg_list:addListItem(gemLine[1])
	   				listIndex = listIndex + 1
	   			end
	   			gemLine["layout"]:addChild(item[1])
	   			index = index + 1
	   			item.mListIndex = listIndex
				end
			end
		end
	end
	self._bg_fpLeft_leftBg_list:getContainer():layout()
	self._bg_fpLeft_leftBg_list:alignTo(0)
end

function DRuneOp:init(  )
	self.mOnItemClicked = {}
	self.mOnItemClicked[ViewType.Strengthen] = function ( item,v )
		if self.mCurRune then
			self.mItems[self.mCurRune]["selectIcon"]:setVisible(false)
		end
		self.mCurRune = v
		item["selectIcon"]:setVisible(true)
		return self:showStrengthenView()
	end
	self.mOnItemClicked[ViewType.Reborn] = function ( item,v )
		if self.mCurRune then
			self.mItems[self.mCurRune]["selectIcon"]:setVisible(false)
		end
		self.mCurRune = v
		item["selectIcon"]:setVisible(true)
		return self:showRebornView()
	end
	self.mOnItemClicked[ViewType.Resolve] = function ( item,v )
		self.mResolveList = self.mResolveList or {}
		local index = table.indexOf(self.mResolveList,v)
		if index>0 then
			table.remove(self.mResolveList,index)
			item["selectIcon"]:setVisible(false)
		else
			if #self.mResolveList<5 then
				table.insert(self.mResolveList,v)
				item["selectIcon"]:setVisible(true)
			end
		end
		return self:showResolveView()
	end
	self.mOnItemClicked[ViewType.Merge] = function ( item, v )
		self.mMergeList = self.mMergeList or {}
		local index = table.indexOf(self.mMergeList,v)
		if index > 0 then
			if index == 1 then
				self.mMergeList = {}
				self:showRuneList()
			else
				table.remove(self.mMergeList,index)
				item["selectIcon"]:setVisible(false)
			end
		else
			if #self.mMergeList<4 then
				table.insert(self.mMergeList,v)
				item["selectIcon"]:setVisible(true)
				if #self.mMergeList == 1 then
					self:showRuneList()
				end
			end
		end

		self:showMergeView()
	end
	self:showRuneList()
	self:updateResourceView()
end

function DRuneOp:updateResourceView(  )
	self._bg_rightBg_hasLayout_coinCount:setString(require "UserInfo".getCoin())
	self._bg_rightBg_hasLayout_magicStoneCount:setString(require "BagInfo".getItemCount(58))
end

function DRuneOp:adjustOpTipLabel( node )
	node:setDimensions(CCSize(324,0))
	node:setAnchorPoint(ccp(0.5,1))
	node:setPosition(0,111)
	require "LangAdapter".fontSize(node,nil,nil,16,nil,nil)
end

function DRuneOp:showStrengthenView( )
	self._bg_rightBg_subTitle:setString(res.locString("Rune$Rune")..res.locString("Mibao$OpTab1"))
	local set = self.views[ViewType.Strengthen]
	if not set then
		set = self:createLuaSet("@pageStrengthen")
		self.views[ViewType.Strengthen] = set
		self._bg_rightBg:addChild(set[1])

		self:adjustOpTipLabel(set["tip"])

		set["lvupBtn"]:setListener(function (  )
			self:send(netModel.getModelRuneUpgrade(self.mCurRune.Id),function ( data )
				local success = data.D.Rune.Lv>self.mCurRune.Lv
				self.cachedUpdateFunc = function ( ... )
					print(data)
					if data.D.Pet then
						require "PetInfo".setPet(data.D.Pet)
					end
					require "BagInfo".useItem(58,Toolkit.getRuneLvUpCost(self.mCurRune.Star,self.mCurRune.Lv))
					self:onRuneModify(data.D.Rune)
				end
				self.cachedViewUpdateFunc = function ( ... )
					self:toast(success and res.locString("Gem$UpdateSuccess") or res.locString("Gem$UpdateFail"))
					self:updateResourceView()	
					return self:showStrengthenView()
				end

				local anim = set["strengthenAnim"]
				anim:setLoops(1)
				anim:setListener(function (  )
					table.remove(self.animFinishFuncs,1)()
					self.cachedUpdateFunc()
					self.cachedUpdateFunc = nil
					self.cachedViewUpdateFunc()
					self.cachedViewUpdateFunc = nil
				end)
				anim:start()

				self._screenBtn:setVisible(true)
				self.animFinishFuncs[#self.animFinishFuncs+1] = function ( ... )
					self._screenBtn:setVisible(false)
					anim:setPaused(true)
					anim:setVisible(false)
				end
				require 'framework.helper.MusicHelper'.playEffect("raw/ui_sfx_equipupgrade.mp3")
			end)
		end)

		set["btn"]:setListener(function (  )
			GleeCore:showLayer("DRuneDetail",{RuneData = self.mCurRune})
		end)
	end
	self.mItems[self.mCurRune]["selectIcon"]:setVisible(true)
	local price = Toolkit.getRuneLvUpCost(self.mCurRune.Star,self.mCurRune.Lv)
	set["priceLayout_price"]:setString(price)
	res.setNodeWithRune(set["icon"],self.mCurRune.RuneId,self.mCurRune.Star,self.mCurRune.Lv)
	set["name"]:setString(Toolkit.getRuneName(self.mCurRune.RuneId,self.mCurRune.Lv))

	if self.mCurRune.SetIn>0 then
		set["equipLayout_equipName"]:setString(Toolkit.getEquipNameById(self.mCurRune.SetIn))
		set["equipLayout"]:setVisible(true)
	else
		set["equipLayout"]:setVisible(false)
	end

	local lvenable = self.mCurRune.Lv < Toolkit.getRuneLvCap(self.mCurRune)
	local priceEnable = price<=require "BagInfo".getItemCount(58)
	local enable = priceEnable and lvenable
	set["lvupBtn"]:setEnabled(enable)
	set["lvupBtn_btntext"]:setString(lvenable and res.locString("Mibao$OpTab1") or res.locString("Equip$StrengthenLimitTip1"))
	set["priceLayout"]:setVisible(lvenable)
	set["priceLayout_price"]:setFontFillColor(priceEnable and ccc4f(0,0,0,1) or ccc4f(1,0,0,1),true)
	set["lvUpIcon"]:setVisible(enable)
end

function DRuneOp:updateRuneNodeInRebornView( node,rune,gray )
	if gray then
		node:setColorf(0.5,0.5,0.5,1)
	else
		node:setColorf(1,1,1,1)
	end
	local children = node:getChildren()
	local icon = children:objectAtIndex(0)
	tolua.cast(icon,"ElfNode")
	res.setNodeWithRune(icon,rune.RuneId,rune.Star,rune.Lv)
	
	local temp = children:objectAtIndex(1)
	tolua.cast(temp,"LabelNode")
	temp:setString(Toolkit.getRuneName(rune.RuneId,rune.Lv))
end

function DRuneOp:updateRebornView( selectIndex )
	local set = self.views[ViewType.Reborn]
	local targetLv =  (selectIndex-1)*3
	local cost = require "CalculateTool".getRuneRebornCost(self.mCurRune.Lv,targetLv)
	set["priceLayout_price"]:setString(cost)
	set["priceLayout_price"]:setFontFillColor(require "UserInfo".getCoin()>=cost and ccc4f(0,0,0,1) or ccc4f(1,0,0,1),true)
	
	local temp = table.clone(self.mCurRune)
	temp.Lv = targetLv
	local buffRemoveCount = #temp.Buffs - math.floor(temp.Lv/3)
	for i=1,buffRemoveCount do
		table.remove(temp.Buffs)
	end
	self:updateRuneNodeInRebornView(set["layout_right"],temp)
	set["layout_right_btn"]:setListener(function ( ... )
		GleeCore:showLayer("DRuneDetail",{RuneData = temp})
	end)

	if selectIndex == 1 then
		set["layout"]:addChild(self.cachedAddIcon)
		set["layout"]:addChild(self.cachedExSet[1])
		self.cachedExSet["count"]:setString(math.floor(self.mCurRune.Consume * 0.7))
		set["layout"]:layout()
	else
		self.cachedAddIcon:removeFromParentAndCleanup(true)
		self.cachedExSet[1]:removeFromParentAndCleanup(true)
		set["layout"]:layout()
	end
end

function DRuneOp:showRebornView( )
	self._bg_rightBg_subTitle:setString(res.locString("Rune$Rune")..res.locString("Rune$RuneReborn"))

	local curSelect = 0

	local set = self.views[ViewType.Reborn]
	if not set then
		set = self:createLuaSet("@pageReborn")
		require 'LangAdapter'.LabelNodeAutoShrink( set["btn_btntext"], 110 )
		
		self.views[ViewType.Reborn] = set
		self._bg_rightBg:addChild(set[1])

		self:adjustOpTipLabel(set["tip"])

		set["btn"]:setListener(function ( ... )
			local targetLv =  (curSelect-1)*3
			local cost = require "CalculateTool".getRuneRebornCost(self.mCurRune.Lv,targetLv)
			if  require "UserInfo".getCoin()<cost then
				return Toolkit.showDialogOnCoinNotEnough()
			end
			local param = {}
			param.content = string.format(res.locString(curSelect == 1 and "Rune$RebornConfirmTip" or  "Rune$RebornConfirmTip1"),cost)
			param.callback = function ( ... )
				self:send(curSelect == 1 and netModel.getModelRuneReborn(self.mCurRune.Id) or netModel.getModelRuneRebornToLv(self.mCurRune.Id,targetLv),function ( data )
					self.cachedUpdateFunc = function ( ... )
						print(data)
						if data.D.Resource then
							require "AppData".updateResource(data.D.Resource)
						else
							require "UserInfo".setCoin(require "UserInfo".getCoin()-cost)
						end
						self:onRuneModify(data.D.Rune)
						if data.D.Pet then
							require "PetInfo".setPet(data.D.Pet)
						end
					end
					self.cachedViewUpdateFunc = function ( ... )
						if data.D.Reward then
							local reward = data.D.Reward
							reward.callback = function (  )
								self:updateResourceView()
								self:showRebornView()
							end
							-- set["left"]:setColorf(0.5,0.5,0.5,1)
							-- set["right"]:setColorf(1,1,1,1)
							-- set["btn"]:setEnabled(false)
							
							GleeCore:showLayer("DGetReward", reward)
						else
							self:updateResourceView()
							self:showRebornView()
						end
					end

					local anim1 = self:createLuaSet("@anim")[1]
					local ids = {}
					for i=1,anim1:getResidArraySize() do
						ids[i] = anim1:getResidByIndex(i-1)
					end
					anim1:clearResidArray()
					for i=#ids,1,-1 do
						anim1:addResidToArray(ids[i])
					end
					set["layout_left"]:addChild(anim1)
					anim1:setLoops(1)
					anim1:start()

					local anim2 = self:createLuaSet("@anim")[1]
					set["layout_right"]:addChild(anim2)
					anim2:setListener(function ( ... )
						print("-------anim2 end--------")
						table.remove(self.animFinishFuncs,1)()
						self.cachedUpdateFunc()
						self.cachedUpdateFunc = nil
						self.cachedViewUpdateFunc()
						self.cachedViewUpdateFunc = nil
					end)
					anim2:setLoops(1)
					anim2:start()
					self._screenBtn:setVisible(true)
					self.animFinishFuncs[#self.animFinishFuncs+1] = function ( ... )
						self._screenBtn:setVisible(false)
						anim1:removeFromParentAndCleanup(true)
						anim2:removeFromParentAndCleanup(true)
						require 'framework.helper.MusicHelper'.stopAllEffects()
					end
					require 'framework.helper.MusicHelper'.playEffect("raw/ui_sfx_melt.mp3")
				end)
			end
			GleeCore:showLayer("DConfirmNT",param)
		end)

		set["layout_left_btn"]:setListener(function (  )
			GleeCore:showLayer("DRuneDetail",{RuneData = self.mCurRune})
		end)

		self.cachedAddIcon = self:createLuaSet("@addIcon")[1]
		self.cachedAddIcon:retain()

		self.cachedExSet = self:createLuaSet("@ex")
		self.cachedExSet[1]:retain()

		for i=1,4 do
			set[string.format("bg_item%d_btn",i)]:setListener(function ( ... )
				curSelect = i
				self:updateRebornView(i)
			end)
		end
	end

	self.mItems[self.mCurRune]["selectIcon"]:setVisible(true)

	self.cachedAddIcon:removeFromParentAndCleanup(true)
	self.cachedExSet[1]:removeFromParentAndCleanup(true)

	set["priceLayout_price"]:setString(0)
	set["btn"]:setEnabled(false)
	self:updateRuneNodeInRebornView(set["layout_left"],self.mCurRune,hasRebirth)
	local temp = table.clone(self.mCurRune)
	temp.Lv = 0
	temp.Buffs = {}
	self:updateRuneNodeInRebornView(set["layout_right"],temp,not hasRebirth)
	set["layout_right_btn"]:setListener(function ( ... )
		GleeCore:showLayer("DRuneDetail",{RuneData = temp})
	end)

	if self.mCurRune.SetIn>0 then
		local strContent = Toolkit.getEquipNameById(self.mCurRune.SetIn)
		strContent = string.gsub(strContent, '\r', '')
		strContent = string.gsub(strContent, '\n', '')
		set["equipLayout_equipName"]:setString(strContent)
		set["equipLayout"]:setVisible(true)
	else
		set["equipLayout"]:setVisible(false)
	end

	for i=1,4 do
		local enable = self.mCurRune.Lv > (i-1)*3
		if enable then
			set[string.format("bg_item%d",i)]:setColorf(1,1,1,1)
		else
			set[string.format("bg_item%d",i)]:setColorf(0.5,0.5,0.5,1)
		end
		local btn = set[string.format("bg_item%d_btn",i)]
		btn:setEnabled(enable)
		btn:onReleased()

		if i == 1 and enable then
			btn:trigger(nil)
		end
	end
	set["btn"]:setEnabled(self.mCurRune.Lv>0)
end

function DRuneOp:showResolveView( )
	self._bg_rightBg_subTitle:setString(res.locString("Rune$Rune")..res.locString("Rune$RuneResolve"))
	local set = self.views[ViewType.Resolve]
	if not set then
		set = self:createLuaSet("@pageResolve")
		self.views[ViewType.Resolve] = set
		self._bg_rightBg:addChild(set[1])

		self:adjustOpTipLabel(set["tip"])

		require "LangAdapter".LabelNodeAutoShrink( set["addBtn_btntext"], 108 )
		
		set["addBtn"]:setListener(function (  )
			if #self.mResolveList>=5 then
				return
			end
			local runes = require "RuneInfo".selectByCondition(function ( v )
				return v.SetIn==0 and not table.find(self.mResolveList,v)
			end)
			if #runes>0 then
				table.sort(runes,function ( a,b )
					return require "RuneInfo".commonSortFunc1(a,b)
				end)
				local index = 1
				repeat
					local rune = runes[index]
					self.mResolveList[#self.mResolveList+1] = rune
					self.mItems[rune]["selectIcon"]:setVisible(true)
					index = index + 1
				until #self.mResolveList == 5 or index >#runes
				self:showResolveView()
			end
		end)

		set["resolveBtn"]:setListener(function ( ... )
			local ids = {}
			local hasLv3,hasStar3
			local curRuneIn = false
			for i,v in ipairs(self.mResolveList) do
				ids[i] = v.Id
				hasLv3 = hasLv3 or v.Lv>=3
				hasStar3 = hasStar3 or v.Star>=3
				if v.Id == self.mCurRune.Id then
					curRuneIn = true
				end
			end
			local sendFunc = function (  )
				self:send(netModel.getModelRuneResolve(ids),function ( data )
					self.cachedUpdateFunc = function ( ... )
						print(data)
						if data.D.Pets then
							for _,v in ipairs(data.D.Pets) do
								require "PetInfo".setPet(v)
							end
						end
						require "AppData".updateResource(data.D.Resource)
						require "RuneInfo".removeRuneList(self.mResolveList)
					end
					self.cachedViewUpdateFunc = function ( ... )
						self.mResolveList = {}
						local reward = data.D.Reward
						reward.callback = function (  )
							if #require "RuneInfo".getRuneList()<=0 then
								self:toast(res.locString("Rune$RuneListEmpty"))
								self._bg_topBar_btnReturn:trigger(nil)
							else
								self.mCurRune = nil
								self:updateResourceView()	
								self:showRuneList()
								return self:showResolveView()
							end
						end
						GleeCore:showLayer("DGetReward", reward)	
					end

					for i=1,#self.mResolveList do
						local anim = set[string.format("m%d_anim",i)]
						if i == 1 then
							anim:setListener(function (  )
								table.remove(self.animFinishFuncs,1)()
								self.cachedUpdateFunc()
								self.cachedUpdateFunc = nil
								self.cachedViewUpdateFunc()
								self.cachedViewUpdateFunc = nil
							end)
						end
						anim:setLoops(1)
						anim:start()
					end

					self._screenBtn:setVisible(true)
					self.animFinishFuncs[#self.animFinishFuncs+1] = function ( ... )
						self._screenBtn:setVisible(false)
						for i=1,5 do
							local anim = set["m"..i.."_anim"]
							anim:setPaused(true)
							anim:setVisible(false)
						end
					end
					require 'framework.helper.MusicHelper'.playEffect("raw/ui_sfx_reforge.mp3")
				end)
			end
			if hasLv3 or hasStar3 then
				local param = {}
				param.content = hasLv3 and res.locString("Rune$ResolveConfirmTipForLv3") or res.locString("Rune$ResolveConfirmTipForStar3")
				param.callback = function ( ... )
					return sendFunc()
				end
				GleeCore:showLayer("DConfirmNT",param)
			else
				return sendFunc()
			end
		end)
	end

	self.mResolveList = self.mResolveList or {}
	local icon,btn,anim
	local count = 0
	for i=1,5 do
		icon = set[string.format("m%d_btnImg",i)]
		btn = set[string.format("m%d_btn",i)]
		anim = set[string.format("m%d_anim",i)]
		local rune = self.mResolveList[i]
		if rune then
			icon:setVisible(true)
			btn:setVisible(true)
			res.setNodeWithRune(icon,rune.RuneId,rune.Star,rune.Lv)
			btn:setListener(function ( ... )
				GleeCore:showLayer("DRuneDetail",{RuneData = rune})
			end)
			count = count + require "CalculateTool".getMagicStoneCountByResolved(rune.Star,rune.Consume)
		else
			icon:setVisible(false)
			btn:setVisible(false)
		end
		anim:setVisible(false)
	end
	set["count"]:setString(count)
	set["resolveBtn"]:setEnabled(#self.mResolveList>0)
end

function DRuneOp:showMergeView( ... )
	self._bg_rightBg_subTitle:setString(res.locString("Rune$Rune")..res.locString("Remains$Merge"))

	local set = self.views[ViewType.Merge]
	if not set then
		set = self:createLuaSet("@pageMerge")
		self.views[ViewType.Merge] = set
		self._bg_rightBg:addChild(set[1])
	end

	require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
		self._bg_rightBg_subTitle:setString(res.locString("Rune$Rune").." "..res.locString("Remains$Merge"))	
		local size = CCSize(160,62)
		set["mergeBtn"]:setContentSize(size)
		set["mergeBtn_normal_#joint9"]:setContentSize(size)
		set["mergeBtn_pressed_#joint9"]:setContentSize(size)
		set["mergeBtn_invalid_#joint9"]:setContentSize(size)
	end)

	self.mMergeList = self.mMergeList or {}
	local icon, tip, lock, btn, anim
	local count = 0
	for i=1,4 do
		icon = set[string.format("bg_itemMerge%d_icon", i-1)]
		tip = set[string.format("bg_itemMerge%d_tip", i-1)]
		lock = set[string.format("bg_itemMerge%d_lock", i-1)]
		btn = set[string.format("bg_itemMerge%d_btn", i-1)]
		anim = set[string.format("bg_itemMerge%d_anim", i-1)]
		local rune = self.mMergeList[i]
		if rune then
			icon:setVisible(true)
			tip:setVisible(false)
			lock:setVisible(false)
			btn:setVisible(true)
			res.setNodeWithRune(icon,rune.RuneId,rune.Star,rune.Lv)
			btn:setListener(function ( ... )
				GleeCore:showLayer("DRuneDetail",{RuneData = rune})
			end)
			count = count + require "CalculateTool".getMagicStoneCountByResolved(rune.Star,rune.Consume)
		else
			icon:setVisible(false)
			lock:setVisible(i ~= 1 and self.mMergeList[1] == nil)
			tip:setVisible(not lock:isVisible())
			btn:setVisible(false)
		end
		anim:setListener(function ( ... ) -- can not del
			-- do nothing
		end)
		anim:stop()

		require "LangAdapter".selectLang(nil,nil,nil,nil,function ( ... )
			tip:setDimensions(CCSize(0,0))
		end)
	end

	local cost = DBManager.getInfoDefaultConfig("RuneMixCost").Value
	set["layoutCost_v"]:setString(cost)
	set["mergeBtn"]:setEnabled(#self.mMergeList == 4)
	set["mergeBtn"]:setListener(function ( ... )
		local function RuneMixEvent( ... )
			local cids = {}
			for i,v in ipairs(self.mMergeList) do
				if i ~= 1 then
					table.insert(cids, v.Id)
				end
			end
			self:send(netModel.getModelRuneMix(cids, self.mMergeList[1].Id), function ( data )
				if data and data.D then
					res.setTouchDispatchEvents(false)
					for i=1,4 do
						local v = set[string.format("bg_itemMerge%d_anim", i-1)]
						v:setLoops(1)
						v:start()
						if i == 1 then
							v:setListener(function ( ... )
								RuneFunc.removeRuneList(self.mMergeList)
								RuneFunc.setRune(data.D.Rune)
								userFunc.setCoin(data.D.Coin)
								eventcenter.eventInput("UpdateGoldCoin")
								if data.D.Pet then
									require "PetInfo".setPet(data.D.Pet)
								end

								self.mMergeList = {}
								self:showRuneList()
								self:showMergeView()
								self:updateResourceView()

								data.D.Rune.Amount = 1
								res.doActionGetReward({Runes = {data.D.Rune}})
								res.setTouchDispatchEvents(true)
							end)
						end
					end
				end
			end)
		end

		if userFunc.getCoin() >= cost then
			local param = {}
			param.content = string.format(res.locString("Rune$MergeTip1"), cost)
			param.callback = RuneMixEvent
			GleeCore:showLayer("DConfirmNT", param)
		else
			require "Toolkit".showDialogOnCoinNotEnough()
		end
	end)
end

function DRuneOp:onRuneModify( new )
	self.mCurRune.SetIn = new.SetIn
	self.mCurRune.Lv = new.Lv
	self.mCurRune.Buffs = new.Buffs
	self.mCurRune.Consume = new.Consume
	eventcenter.eventInput("OnRuneUpdate")
	local item = self.mItems[self.mCurRune]
	res.setNodeWithRune(item["scale_icon"],self.mCurRune.RuneId,self.mCurRune.Star,self.mCurRune.Lv)
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DRuneOp, "DRuneOp")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DRuneOp", DRuneOp)


