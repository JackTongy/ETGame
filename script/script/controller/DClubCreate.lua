local Config = require "Config"
local res = require "Res"
local netModel = require "netModel"
local dbManager = require "DBManager"

local DClubCreate = class(LuaDialog)

function DClubCreate:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DClubCreate.cocos.zip")
    return self._factory:createDocument("DClubCreate.cocos")
end

--@@@@[[[[
function DClubCreate:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._bg = set:getShieldNode("bg")
   self._bg_detailBg_title_text = set:getLabelNode("bg_detailBg_title_text")
   self._bg_detailBg_inputBg_input = set:getInputTextNode("bg_detailBg_inputBg_input")
   self._bg_detailBg_icon = set:getElfNode("bg_detailBg_icon")
   self._bg_detailBg_changeBtn = set:getButtonNode("bg_detailBg_changeBtn")
   self._bg_detailBg_cancelBtn = set:getClickNode("bg_detailBg_cancelBtn")
   self._bg_detailBg_createBtn = set:getClickNode("bg_detailBg_createBtn")
   self._bg_detailBg_createBtn_text = set:getLabelNode("bg_detailBg_createBtn_text")
   self._bg_detailBg_layout = set:getLinearLayoutNode("bg_detailBg_layout")
   self._bg_detailBg_layout_label = set:getLabelNode("bg_detailBg_layout_label")
   self._bg_detailBg_layout_coinNeed = set:getLabelNode("bg_detailBg_layout_coinNeed")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DClubCreate:onInit( userData, netData )
	require "LangAdapter".LabelNodeAutoShrink(self._set:getLabelNode("bg_detailBg_#nameLabel"),105)
	require "LangAdapter".LabelNodeAutoShrink(self._set:getLabelNode("bg_detailBg_#iconLabel"),105)

	require "LangAdapter".LabelNodeAutoShrink(self._set:getLabelNode("bg_detailBg_cancelBtn_#label"),108)
	require "LangAdapter".LabelNodeAutoShrink(self._bg_detailBg_createBtn_text,108)


	res.doActionDialogShow(self._bg)
	self.IsChangeName = userData and userData.IsChangeName or false

	local input = self._bg_detailBg_inputBg_input:getInputTextNode()
	input:setFontName("wenzi.ttf")
	input:setFontSize(24)
	input:setFontFillColor(res.color4F.white,true)
	self._bg_detailBg_inputBg_input:setFontColor(res.color4F.white)
	
	self:addBtnListener()

	if self.IsChangeName then
		self.mPrice = 500
		self.mCurPicID = require "GuildInfo".getData().Pic

		self._bg_detailBg_title_text:setString(res.locString("Club$ChangeName"))
		self._bg_detailBg_layout_label:setString(res.locString("Club$ChangeNeedLabel"))
		self._bg_detailBg_createBtn_text:setString(res.locString("Club$BtnChangeName"))
		self._bg_detailBg_inputBg_input:setPlaceHolder(require "GuildInfo".getData().Title)
	else
		local conf = dbManager.getDeaultConfig("GuildCreate")
		self.mPrice = conf and conf.Value or 300
		self.mCurPicID = 1

		self._bg_detailBg_title_text:setString(res.locString("Club$CreateLabel"))
		self._bg_detailBg_layout_label:setString(res.locString("Club$CreateNeedLabel"))
		self._bg_detailBg_createBtn_text:setString(res.locString("Club$CreateLabel"))
		self._bg_detailBg_inputBg_input:setPlaceHolder(res.locString("DClub$CreatePlaceHolder"))
	end

	self:updateView()
end

function DClubCreate:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function DClubCreate:addBtnListener( ... )
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_detailBg_cancelBtn:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_detailBg_createBtn:setListener(function ( ... )
		local userFunc = require "UserInfo"
		if userFunc.getCoin()<self.mPrice then
			require "Toolkit".showDialogOnCoinNotEnough()
		else
			local content = self._bg_detailBg_inputBg_input:getText()
			if content and string.len(content)>0 then
				if content~= self._bg_detailBg_inputBg_input:getPlaceHolder() then
					if self:isLegal(content) then
						if self.IsChangeName then
							self:send(netModel.getModelGuildRename(content,self.mCurPicID), function ( data )
								if data and data.D then
									userFunc.setData(data.D.Role)
									require "GuildInfo".setData(data.D.Guild)
									res.doActionDialogHide(self._bg, self)
									require "EventCenter".eventInput("EventGuildRename")
								end
							end)
						else
							self:send(netModel.getModelClubCreate(content,self.mCurPicID),function ( data )
								print(data)
								local coin = userFunc.getCoin()
								coin = coin - self.mPrice
								userFunc.setCoin(coin)
								require "EventCenter".eventInput("UpdateGoldCoin")
								GleeCore:closeAllLayers({Menu=true,guideLayer=true})
								require "GuildInfo".setData(data.D.Guild)
								require "GuildInfo".setGuildMember(data.D.Member)
								GleeCore:showLayer("DGuild")
							end)				
						end
					else
						return self:toast(res.locString("DClub$CreateNameError"))
					end
				else
					if self.IsChangeName then
						self:toast(res.locString("Club$ChangeNameError1"))
					else
						self:toast(res.locString("DClub$CreatePlaceHolder1"))
					end
				end
			else
				self:toast(res.locString("DClub$CreatePlaceHolder1"))
			end
		end
	end)

	self._bg_detailBg_changeBtn:setListener(function ( ... )
		GleeCore:showLayer("DClubIconChoose",{Listener = function ( id )
			self.mCurPicID = id
			return self:updateView()
		end})
	end)
end

function DClubCreate:updateView( ... )
	self._bg_detailBg_layout_coinNeed:setString(self.mPrice)

	require "Toolkit".setClubIcon(self._bg_detailBg_icon,self.mCurPicID)
end

function DClubCreate:isLegal( name )
	for _,v in ipairs(require "BadWordConfig") do
		local s,e = string.find(name,v.Word,nil,true)
		if s then
			if not (v.Word == '法*' and string.len(name) == e) then
				return false
			end
		end
	end
	return true
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DClubCreate, "DClubCreate")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DClubCreate", DClubCreate)


