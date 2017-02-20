local config = require "Config"
local gameFunc = require "AppData"
local dbManager = require "DBManager"
local res = require "Res"
local netModel = require "netModel"
local GuideHelper = require 'GuideHelper'
local eventcenter = require "EventCenter"

local gemFunc = gameFunc.getGemInfo()

local DGemLevelUp = class(LuaDialog)

function DGemLevelUp:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."DGemLevelUp.cocos.zip")
    return self._factory:createDocument("DGemLevelUp.cocos")
end

--@@@@[[[[
function DGemLevelUp:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_rightBg = set:getElfNode("bg_rightBg")
    self._bg_rightBg_forAnim0 = set:getElfNode("bg_rightBg_forAnim0")
    self._bg_rightBg_top = set:getElfNode("bg_rightBg_top")
    self._bg_rightBg_top_xingzhen = set:getElfNode("bg_rightBg_top_xingzhen")
    self._bg_rightBg_top_gem = set:getElfNode("bg_rightBg_top_gem")
    self._bg_rightBg_top_title = set:getLabelNode("bg_rightBg_top_title")
    self._bg_rightBg_forAnim = set:getElfNode("bg_rightBg_forAnim")
    self._bg_rightBg_bottom_progressBg_progress = set:getProgressNode("bg_rightBg_bottom_progressBg_progress")
    self._bg_rightBg_bottom_btnLevelUp = set:getClickNode("bg_rightBg_bottom_btnLevelUp")
    self._bg_rightBg_bottom_btnLevelUp_btntext = set:getLabelNode("bg_rightBg_bottom_btnLevelUp_btntext")
    self._bg_rightBg_bottom_levelLimitView = set:getElfNode("bg_rightBg_bottom_levelLimitView")
    self._bg_rightBg_bottom_levelLimitView_sucRate = set:getLabelNode("bg_rightBg_bottom_levelLimitView_sucRate")
    self._bg_rightBg_bottom_levelLimitView_button1 = set:getButtonNode("bg_rightBg_bottom_levelLimitView_button1")
    self._bg_rightBg_bottom_levelLimitView_button1_btnImg = set:getElfNode("bg_rightBg_bottom_levelLimitView_button1_btnImg")
    self._bg_rightBg_bottom_levelLimitView_button2 = set:getButtonNode("bg_rightBg_bottom_levelLimitView_button2")
    self._bg_rightBg_bottom_levelLimitView_button2_btnImg = set:getElfNode("bg_rightBg_bottom_levelLimitView_button2_btnImg")
    self._bg_rightBg_bottom_levelLimitView_button3 = set:getButtonNode("bg_rightBg_bottom_levelLimitView_button3")
    self._bg_rightBg_bottom_levelLimitView_button3_btnImg = set:getElfNode("bg_rightBg_bottom_levelLimitView_button3_btnImg")
    self._bg_rightBg_bottom_levelLimitView_button4 = set:getButtonNode("bg_rightBg_bottom_levelLimitView_button4")
    self._bg_rightBg_bottom_levelLimitView_button4_btnImg = set:getElfNode("bg_rightBg_bottom_levelLimitView_button4_btnImg")
    self._bg_rightBg_bottom_levelLimitTip = set:getLabelNode("bg_rightBg_bottom_levelLimitTip")
    self._bg_rightBg_bottom_linearlayout_curLevel = set:getLabelNode("bg_rightBg_bottom_linearlayout_curLevel")
    self._bg_rightBg_bottom_linearlayout_nextLevel = set:getLabelNode("bg_rightBg_bottom_linearlayout_nextLevel")
    self._bg_fpLeft_leftBg_list = set:getListNode("bg_fpLeft_leftBg_list")
    self._titleLabel = set:getLabelNode("titleLabel")
    self._gemCount = set:getLabelNode("gemCount")
    self._layout = set:getLinearLayoutNode("layout")
    self._scale_btn = set:getButtonNode("scale_btn")
    self._scale_gem = set:getElfNode("scale_gem")
    self._title = set:getLabelNode("title")
    self._selectIcon = set:getElfNode("selectIcon")
    self._bg_fpLeft_leftBg_emptyView = set:getElfNode("bg_fpLeft_leftBg_emptyView")
    self._bg_topBar_btnReturn = set:getButtonNode("bg_topBar_btnReturn")
    self._screenBtn = set:getButtonNode("screenBtn")
--    self._@anim2 = set:getSimpleAnimateNode("@anim2")
--    self._@anim1 = set:getSimpleAnimateNode("@anim1")
--    self._@anim3 = set:getSimpleAnimateNode("@anim3")
--    self._@anim4 = set:getSimpleAnimateNode("@anim4")
--    self._@title = set:getElfNode("@title")
--    self._@gemLine = set:getElfNode("@gemLine")
--    self._@gemItem = set:getElfNode("@gemItem")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DGemLevelUp:onInit( userData, netData )
	require 'LangAdapter'.LabelNodeAutoShrink(self._bg_rightBg_bottom_btnLevelUp_btntext,110)
	self._set:getLabelNode("bg_fpLeft_leftBg_emptyView_#label"):setDimensions(CCSize(340,0))
	

	res.doActionDialogShow(self._bg)
	self.tickHandle = {}
	self.animFinishFuncs = {}

	-- self._bg_topBar_bg:setScaleX(CCDirector:sharedDirector():getWinSize().width/960)
	self.gemInfo = userData
	self.selectedGemList = {}
	self.selectedGemMap = {}
	self:updateView()
	self:setListenerEvent()
	self._screenBtn:setVisible(false)

	self:onEnter()
end

function DGemLevelUp:onEnter( ... )
	GuideHelper:registerPoint('宝石升级',self._bg_rightBg_bottom_btnLevelUp)
	GuideHelper:registerPoint('返回',self._bg_topBar_ftpos2_btnReturn)
	GuideHelper:registerPoint('关闭',self._bg_topBar_btnReturn)
	GuideHelper:check('DGemLevelUp')
end

function DGemLevelUp:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function DGemLevelUp:finishAnims( ... )
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
end


function DGemLevelUp:setListenerEvent(  )
	self._screenBtn:setPenetrate(false)
	self._screenBtn:setTriggleSound("")
	self._screenBtn:setListener(function ( ... )
		print("screenBtn touching--------------")
		if #self.animFinishFuncs>0 then
			self:finishAnims()
			return self:updateView()
		end
	end)

	self.close = function ( ... )
		self:finishAnims()
		self:hiddenToast()
		GuideHelper:check('CloseDialog')
	end

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)
	
	self._bg_topBar_btnReturn:setTriggleSound(res.Sound.back)
	self._bg_topBar_btnReturn:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_rightBg_bottom_btnLevelUp:setListener(function (  )
		print("onLevelUpClick------------")
		if gemFunc.isGemOutOfDate(self.gemInfo) then
			return self:toast("升级失败,宝石已过期")
		end

		local function checkUpLimit( ... )
			local pet = self.gemInfo.SetIn > 0 and require "PetInfo".getPetWithId(self.gemInfo.SetIn)
			if pet then
				local gemPetAwake = dbManager.getInfoGemLevelUp(self.gemInfo.Lv + 1).awake
				if pet.AwakeIndex >= gemPetAwake then
					return true
				else
			                	local awakeColor = nil
			                	if gemPetAwake == 4 then
			                    	awakeColor = res.locString("Global$ColorGreen")
			                	elseif gemPetAwake == 8 then
			                    	awakeColor = res.locString("Global$ColorBlue")
			                	elseif gemPetAwake == 12 then
			                    	awakeColor = res.locString("Global$ColorPurple")
			                elseif gemPetAwake == 16 then
			                    	awakeColor = res.locString("Global$ColorOrange")
		                    	elseif gemPetAwake == 20 then
		                    		awakeColor = res.locString("Global$ColorGolden")
		                    	elseif gemPetAwake == 24 then
		                    		awakeColor = res.locString("Global$ColorRed")
			                	end

			                	print("awakeColor = " .. awakeColor)
			                	if awakeColor then
			                    	self:toast(string.format(res.locString('PetGem$_GemLvUpTip'), awakeColor))
			                    	return false
			                	end
			            end
			end
			return true
		end
		if not checkUpLimit() then
			return
		end
		local idList = {}
		table.foreach(self.selectedGemList,function ( _,v )
			table.insert(idList,v.Id)
		end)
		self:send(netModel.getModelGemUpgrade(self.gemInfo.Id, table.concat(idList,",")), function ( data )
			GuideHelper:check('GemUpgrade')
			self.cachedUpdateFunc = function( ... )
				print(data)
				if data.D.Gem then
					self:toast(res.locString("Gem$UpdateSuccess"))
					self.gemInfo = data.D.Gem
					gemFunc.updateGem(self.gemInfo)
				else
					self:toast(res.locString("Gem$UpdateFail"))
				end
				gemFunc.removeGemList(idList)
				self.selectedGemList = {}
				self.selectedGemMap = {}
				GuideHelper:check('AnimtionEnd')
				if self.gemInfo.SetIn > 0 then
					eventcenter.eventInput("OnEquipmentUpdate")
				end
				eventcenter.eventInput("OnGemUpdate", self.gemInfo)
			end

			local map = {{111,-15,20,1.7},{158,-23,2,1.5},{206,-21,-20,1.5},{256,-26,-40,1.7}}

			local anim2 = self:createLuaSet("@anim2")[1]
			anim2:setLoops(1)
			self._bg_rightBg_forAnim0:addChild(anim2)
			anim2:setVisible(false)

			local _anim2 = self:createLuaSet("@anim2")[1]
			_anim2:setLoops(1)
			self._bg_rightBg_forAnim:addChild(_anim2)
			local t = ccBlendFunc:new()
			t.src = 770
			t.dst = 1
			_anim2:setBlendFunc(t)
			anim2:setVisible(false)
			_anim2:setColorf(1,1,1,0.5)

			local anim3
			if data.D.Gem then
				anim3 = self:createLuaSet("@anim3")[1]
			else
				anim3 = self:createLuaSet("@anim4")[1]
			end
			anim3:setLoops(1)
			self._bg_rightBg_forAnim:addChild(anim3)
			anim3:setVisible(false)



			for i=#self.selectedGemList,1,-1 do
				self.tickHandle[#self.tickHandle+1] =  require "framework.sync.TimerHelper".tick(function ( ... )
					local anim1 = self:createLuaSet("@anim1")[1]
					anim1:setPosition(map[i][1],map[i][2])
					anim1:setRotation(map[i][3])
					anim1:setScaleY(map[i][4])
					self._bg_rightBg_forAnim:addChild(anim1)
					anim1:setLoops(1)
					if i == 1 then
						self.tickHandle[#self.tickHandle+1] =  require "framework.sync.TimerHelper".tick(function ( ... )
							self._bg_rightBg_top_xingzhen:setVisible(false)
							anim2:setVisible(true)
							anim2:setListener(function ( ... )
								anim3:setVisible(true)
								anim3:start()
								anim3:setListener(function ( ... )
									table.remove(self.animFinishFuncs,1)()
									self.cachedUpdateFunc()
									self.cachedUpdateFunc = nil
									return self:updateView()
								end)
								require 'framework.helper.MusicHelper'.stopAllEffects()
								if data.D.Gem then
									require 'framework.helper.MusicHelper'.playEffect("raw/ui_sfx_gemupgrade_done.mp3")
								else
									require 'framework.helper.MusicHelper'.playEffect("raw/ui_sfx_gemupgrade_fail.mp3")
								end
							end)
							anim2:start()
							_anim2:setVisible(true)
							_anim2:start()
						      	return true
						end,0.1)
					end
					anim1:start()

					local _anim1 = self:createLuaSet("@anim1")[1]
					_anim1:setPosition(map[i][1],map[i][2])
					_anim1:setRotation(map[i][3])
					self._bg_rightBg_forAnim:addChild(_anim1)
					_anim1:setLoops(1)
					local t = ccBlendFunc:new()
					t.src = 770
					t.dst = 1
					_anim1:setBlendFunc(t)
					_anim1:setColorf(1,1,1,0.5)
					_anim1:start()

				      	return true
				end,(#self.selectedGemList-i)*0.05)
			end
			self._screenBtn:setVisible(true)
			self.animFinishFuncs[#self.animFinishFuncs+1] = function ( ... )
				self._bg_rightBg_forAnim0:removeAllChildrenWithCleanup(true)
				self._bg_rightBg_forAnim:removeAllChildrenWithCleanup(true)
				self._bg_rightBg_top_xingzhen:setVisible(true)
				self._screenBtn:setVisible(false)
				for _,v in ipairs(self.tickHandle) do
					require "framework.sync.TimerHelper".cancel(v)
				end
				self.tickHandle = {}
				require 'framework.helper.MusicHelper'.stopAllEffects()
			end

			require 'framework.helper.MusicHelper'.playEffect("raw/ui_sfx_gemupgrade.mp3")
		end)
	end)

	for i=1,4 do
		self[string.format("_bg_rightBg_bottom_levelLimitView_button%d",i)]:setListener(function (  )
			local gem = self.selectedGemList[i]
			if not gem then
				return 
			end
			table.remove(self.selectedGemList,i)
			self.selectedGemMap[gem.Id]["selectIcon"]:setVisible(false)
			return self:updateDetailView()
		end)
	end
end

function DGemLevelUp:updateView( ... )
	require "framework.sync.TimerHelper".tick(function ( ... )
		res.setGemDetail(self._bg_rightBg_top_gem,self.gemInfo,self.gemInfo.SetIn>0)
		self._bg_rightBg_top_title:setString(string.format("%sLv%d",dbManager.getInfoGem(self.gemInfo.GemId).name,self.gemInfo.Lv))
		self._bg_rightBg_bottom_linearlayout_curLevel:setString(string.format("Lv%d",self.gemInfo.Lv))
		self._bg_rightBg_bottom_linearlayout_nextLevel:setString(string.format("Lv%d",math.min(self.gemInfo.Lv+1,7)))
		self:updateList()
		self:updateDetailView()
	      	return true
	end)
end

function DGemLevelUp:updateList( ... )
	local gemList = gemFunc.getLevelUpRawList(self.gemInfo)
	self._bg_fpLeft_leftBg_list:getContainer():removeAllChildrenWithCleanup(true)
	local hasGems = #gemList>0
	self._bg_fpLeft_leftBg_list:setVisible(hasGems)
	self._bg_fpLeft_leftBg_emptyView:setVisible(not hasGems)
	if not hasGems then
		-- self._bg_fpLeft_leftBg_emptyView_title_gemCount:setString(string.format(res.locString("Gem$GemCount"),0))
		return
	end

	local firstnode = nil
	local gemnodes = {}
	gemList = self:classifyGemByLevel(gemList)
	for lv =1,7 do
		local list = gemList[lv]
		if list then
			local titleSet = self:createLuaSet("@title")
			local i
			if lv < 4 then
				i = 3
			elseif lv <6 then
				i = 2
			else
				i = 1
			end
			titleSet["titleLabel"]:setString(string.format("%s  LV%d",res.locString(string.format("Gem$GemLevelText%d",i)),lv))
			titleSet["gemCount"]:setString(string.format(res.locString("Gem$GemCount"),#list))
			self._bg_fpLeft_leftBg_list:addListItem(titleSet[1])

			self:resortGemList(list)
			local gemLine,index = nil,0
			table.foreach(list,function ( _,v )
				local set = self:createLuaSet("@gemItem")
	      			set["title"]:setString(dbManager.getInfoGem(v.GemId).name)
	      			-- set["lv"]:setString(string.format('Lv%d', lv))
	      			res.setGemDetail(set["scale_gem"],v)
	      			set["selectIcon"]:setVisible(false)
	      			if self.gemInfo.Lv >= 7 then
	      				set["scale_btn"]:setTouchEnable(false)
	      			else
		      			set["scale_btn"]:setTriggleSound(res.Sound.gem)
		      			set["scale_btn"]:setListener(function (  )
		      				print("ItemCLick---------")
		      				local indexInSelectedList = 0
		      				for ii,vv in ipairs(self.selectedGemList) do
		      					if vv.Id == v.Id then
		      						indexInSelectedList = ii
		      						break
		      					end
		      				end
		      				
		      				if indexInSelectedList > 0 then
		      					set["selectIcon"]:setVisible(false)
		      					table.remove(self.selectedGemList,indexInSelectedList)
		      					self.selectedGemMap[v.Id] = nil
		      				else
		      					if #self.selectedGemList >=4 then
			      					return
			      				end
		      					set["selectIcon"]:setVisible(true)
		      					table.insert(self.selectedGemList,v)
		      					self.selectedGemMap[v.Id] = set
		      				end
		      				self:updateDetailView()
		      				GuideHelper:check('GemSelected')
		      			end)
		      		end
	      			if index%4 == 0 then
	      				gemLine = self:createLuaSet("@gemLine")
	      				self._bg_fpLeft_leftBg_list:addListItem(gemLine[1])
	      			end
	      			gemLine["layout"]:addChild(set[1])
	      			index = index + 1
	      			table.insert(gemnodes,set['scale_btn'])
			end)
		end
	end

	self._bg_fpLeft_leftBg_list:layout()
	if gemnodes and #gemnodes >= 2 then
		for i=1,2 do
			GuideHelper:registerPoint(string.format('材料宝石%d',i),gemnodes[i])
		end
	end
end

function DGemLevelUp:updateDetailView( ... )
	local function getSuccessRate( ... )
		if #self.selectedGemList == 0 or self.gemInfo.Lv >= 7 then
			return 0
		end
		local p = 0
		table.foreach(self.selectedGemList,function ( _,v )
			p = p + dbManager.getInfoGemLevelUp(v.Lv).score
		end)
		local sucscore = dbManager.getInfoGemLevelUp(self.gemInfo.Lv+1).sucscore
		return require "CalculateTool".getGemLevelUpRate(p,sucscore)
	end
	local rate = getSuccessRate()
	self._bg_rightBg_bottom_progressBg_progress:setPercentage(rate)
	if self.gemInfo.Lv >= 7 then
		self._bg_rightBg_bottom_levelLimitView:setVisible(false)
		self._bg_rightBg_bottom_levelLimitTip:setVisible(true)
		self._bg_rightBg_bottom_btnLevelUp_btntext:setString(res.locString("Global$LevelCap"))
	else
		self._bg_rightBg_bottom_levelLimitView:setVisible(true)
		self._bg_rightBg_bottom_levelLimitTip:setVisible(false)
		self._bg_rightBg_bottom_levelLimitView_sucRate:setString(string.format(res.locString("Gem$SucRate"),rate))
		for i=1,4 do
			local node = self[string.format("_bg_rightBg_bottom_levelLimitView_button%d_btnImg",i)]
			node:removeAllChildrenWithCleanup(true)
			local gem = self.selectedGemList[i]
			res.setGemDetail(node,gem)
		end
	end
	local enable = self.gemInfo.Lv<7 and #self.selectedGemList>0
	self._bg_rightBg_bottom_btnLevelUp:setEnabled(enable)
	self._bg_rightBg_bottom_btnLevelUp:setOpacity(enable and 255 or 128)
end

function DGemLevelUp:resortGemList( list )
	table.sort(list,function ( a,b )
		local aType = dbManager.getInfoGem(a.GemId).type
		local bType = dbManager.getInfoGem(b.GemId).type
		if aType == bType then
			return a.GemId < b.GemId
		else
			return aType > bType
		end
	end)
end

function DGemLevelUp:classifyGemByLevel( gemList )
	local ret = {}
	table.foreach(gemList,function ( _,v )
		ret[v.Lv] = ret[v.Lv] or {}
		table.insert(ret[v.Lv],v)
	end)
	return ret
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGemLevelUp, "DGemLevelUp")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGemLevelUp", DGemLevelUp)


