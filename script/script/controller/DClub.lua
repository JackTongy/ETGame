local Config = require "Config"
local res = require "Res"
local netModel = require "netModel"
local dbManager = require "DBManager"

local DClub = class(LuaDialog)

function DClub:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DClub.cocos.zip")
    return self._factory:createDocument("DClub.cocos")
end

--@@@@[[[[
function DClub:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_listbg_list = set:getListNode("bg_listbg_list")
    self._bg_icon = set:getElfNode("bg_icon")
    self._bg_name = set:getLabelNode("bg_name")
    self._bg_joinBtn = set:getClickNode("bg_joinBtn")
    self._bg_joinBtn_label = set:getLabelNode("bg_joinBtn_label")
    self._bg_conditionLabel = set:getLabelNode("bg_conditionLabel")
    self._bg_layout1_lv = set:getLabelNode("bg_layout1_lv")
    self._bg_layout2 = set:getLinearLayoutNode("bg_layout2")
    self._bg_layout2_leader = set:getLabelNode("bg_layout2_leader")
    self._bg_layout3_power = set:getLabelNode("bg_layout3_power")
    self._bg_layout4 = set:getLinearLayoutNode("bg_layout4")
    self._bg_layout4_count = set:getLabelNode("bg_layout4_count")
    self._bg_updateBtn = set:getClickNode("bg_updateBtn")
    self._bg_searchBtn = set:getButtonNode("bg_searchBtn")
    self._bg_topBar_btnHelp = set:getButtonNode("bg_topBar_btnHelp")
    self._bg_topBar_btnReturn = set:getButtonNode("bg_topBar_btnReturn")
    self._bg_inputBg_input = set:getInputTextNode("bg_inputBg_input")
    self._bg_createBtn = set:getClickNode("bg_createBtn")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

local Launcher = require 'Launcher'

Launcher.register('DClub',function ( userData )
	Launcher.callNet(netModel.getModelClubGetLast10(),function ( data )
		print(data)
		Launcher.Launching(data)   
	end)
end)

--------------------------------override functions----------------------
function DClub:onInit( userData, netData )
	require "LangAdapter".LabelNodeAutoShrink(self._set:getLabelNode("bg_createBtn_#label"),108)
	require "LangAdapter".LabelNodeAutoShrink(self._set:getLabelNode("bg_createBtn_#label"),108)

	res.doActionDialogShow(self._bg)

	local input = self._bg_inputBg_input:getInputTextNode()
	input:setFontName("wenzi.ttf")
	input:setFontSize(24)
	input:setFontFillColor(res.color4F.white,true)
	input:enableStroke(ccc4f(0,0,0,0.5),2,true)
	self._bg_inputBg_input:setFontColor(res.color4F.white)
	self._bg_inputBg_input:setPlaceHolder(res.locString("DClub$inputPlaceHolder"))

	self:addBtnListener()

	self.mApplyList = netData.D.Applys or {}
	self.mClubs = netData.D.Guilds

	self.tickHandlers = {}

	self:updateView(self.mClubs)
end

function DClub:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function DClub:resetList( ... )
	for _,v in pairs(self.tickHandlers) do
		require "framework.sync.TimerHelper".cancel(v)
	end
	self.tickHandlers = {}

	self._bg_listbg_list:getContainer():removeAllChildrenWithCleanup(true)
end

function DClub:addBtnListener( ... )
	self.close = function ( ... )
		self:resetList()
	end

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_topBar_btnHelp:setListener(function (  )
		GleeCore:showLayer("DHelp", {type = "公会"})
	end)

	self._bg_topBar_btnReturn:setTriggleSound(res.Sound.back)
	self._bg_topBar_btnReturn:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_searchBtn:setListener(function ( ... )
		local content = self._bg_inputBg_input:getText()
		if content and string.len(content)>0 and content~= self._bg_inputBg_input:getPlaceHolder() then
			print(content)
			return self:send(netModel.getModelClubSearch(content),function ( data )
				print(data)
				if not data.D.Guilds then
					return self:toast(res.locString("DClub$noClubFindTip"))
				else
					self:updateView(data.D.Guilds)
				end
			end)
		else
			return self:toast(res.locString("DClub$inputPlaceHolder"))
		end
	end)

	self._bg_updateBtn:setListener(function ( ... )
		self:send(netModel.getModelClubRefresh10(),function ( data )
			print(data)
			self.mClubs = data.D.Guilds
			self:updateView(self.mClubs)
		end)
	end)

	self._bg_createBtn:setListener(function ( ... )
		GleeCore:showLayer("DClubCreate")
	end)
end

function DClub:updateView( clubList )
	self:resetList()

	table.sort(clubList,function ( a,b )
		local aJoin = table.find(self.mApplyList,a.Id)
		local bJoin = table.find(self.mApplyList,b.Id)
		if aJoin and not bJoin then
			return true
		elseif not aJoin and bJoin then
			return false
		end
	end)
	for i=1,#clubList do
		if i<=3 then
			self._bg_listbg_list:addListItem(self:createClubItem(clubList[i]))
		else
			self.tickHandlers[#self.tickHandlers+1] = require "framework.sync.TimerHelper".tick(function ( ... )
				self._bg_listbg_list:addListItem(self:createClubItem(clubList[i]))
			      	return true
			end,(i-3)*0.1)
		end
	end
	self._bg_listbg_list:alignTo(0)
end

function DClub:createClubItem( data )
	local set = self:createLuaSet("@item")

	require "LangAdapter".LabelNodeAutoShrink(set["bg_joinBtn_label"],108)
	require 'LangAdapter'.LayoutChildrenReverseifArabic(set["bg_#layout1"])
	require 'LangAdapter'.LayoutChildrenReverseifArabic(set["bg_layout2"])
	require 'LangAdapter'.LayoutChildrenReverseifArabic(set["bg_#layout3"])
	require 'LangAdapter'.LayoutChildrenReverseifArabic(set["bg_layout4"])
	require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
		set["bg_name"]:setAnchorPoint(ccp(1,0.5))
		set["bg_name"]:setPosition(ccp(115,25))
	end)

	require "Toolkit".setClubIcon(set["bg_icon"],data.Pic)
	set["bg_name"]:setString(data.Title)
	set["bg_layout1_lv"]:setString(data.Lv)
	set["bg_layout2_leader"]:setString(data.Name)
	set["bg_layout3_power"]:setString(data.Power)
	set["bg_layout4_count"]:setString(string.format("%d/%d",data.Number,dbManager.getGuildlv(data.Lv).number))
	if data.JoinLv>0 then
		set["bg_conditionLabel"]:setVisible(true)
		set["bg_conditionLabel"]:setString(string.format(res.locString("Club$JoinCondition"),data.JoinLv))
	else
		set["bg_conditionLabel"]:setVisible(false)
		local x,y = set["bg_joinBtn"]:getPosition()
		set["bg_joinBtn"]:setPosition(x,0)
	end
	
	self:updateOnJoin(set,data)
	
	require 'LangAdapter'.selectLang(nil,nil,nil,function ( ... )
		set["bg_layout2"]:setPosition(ccp(-25, -3))
		set["bg_layout4"]:setPosition(ccp(-25, -28))
	end)

	return set[1]
end

function DClub:updateOnJoin( set,data )
	if table.find(self.mApplyList,data.Id) then
		set["bg_joinBtn_label"]:setString(res.locString("Club$CancelJoinLabel"))
		set["bg_joinBtn"]:setListener(function ( ... )
			self:send(netModel.getModelClubCancelJoin(data.Id),function ( netData )
				print(netData)
				table.remove(self.mApplyList,table.indexOf(self.mApplyList,data.Id))
				return self:updateOnJoin(set,data)
			end)
		end)
		set["#bg"]:setResid("N_XJ_beijing2_sel.png")
	else
		set["bg_joinBtn_label"]:setString(res.locString("Club$JoinLabel"))
		set["bg_joinBtn"]:setListener(function ( ... )
			if require "UserInfo".getLevel()<data.JoinLv then
				return self:toast(string.format(res.locString("DClub$joinLimitTip1"),data.JoinLv))
			elseif #self.mApplyList>=3 then
				return self:toast(res.locString("DClub$joinLimitTip2"))
			elseif data.Number >= dbManager.getGuildlv(data.Lv).number then
				return self:toast(res.locString("DClub$joinLimitTip3"))
			else
				self:send(netModel.getModelClubJoin(data.Id),function ( netData )
					print(netData)
					table.insert(self.mApplyList,data.Id)
					return self:updateOnJoin(set,data)
				end)
			end
		end)
		set["#bg"]:setResid("N_XJ_beijing2.png")
	end
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DClub, "DClub")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DClub", DClub)


