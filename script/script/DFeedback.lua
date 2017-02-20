local Config = require "Config"
local res = require "Res"
local accounthelper = require 'AccountHelper'

 -- local NetManager = require 'NetManager'

 local DFeedback = class(LuaDialog)

function DFeedback:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DFeedback.cocos.zip")
    return self._factory:createDocument("DFeedback.cocos")
end

--@@@@[[[[
function DFeedback:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._panel = set:getShieldNode("panel")
   self._panel_btn_close = set:getClickNode("panel_btn_close")
   self._panel_Panel_3_0 = set:getElfNode("panel_Panel_3_0")
   self._info_back = set:getElfNode("info_back")
   self._btnSubmit = set:getClickNode("btnSubmit")
   self._btnSubmit_title = set:getLabelNode("btnSubmit_title")
   self._option1 = set:getTabNode("option1")
   self._option2 = set:getTabNode("option2")
   self._option3 = set:getTabNode("option3")
   self._option4 = set:getTabNode("option4")
   self._info_back = set:getElfNode("info_back")
   self._info_back_list = set:getListNode("info_back_list")
   self._name = set:getLabelNode("name")
   self._time = set:getLabelNode("time")
   self._panel_Panel_3_0_tabCheck = set:getTabNode("panel_Panel_3_0_tabCheck")
   self._panel_Panel_3_0_tabSubmit = set:getButtonNode("panel_Panel_3_0_tabSubmit")
--   self._@pageSubmit = set:getElfNode("@pageSubmit")
--   self._@pageCheck = set:getElfNode("@pageCheck")
--   self._@title = set:getElfNode("@title")
--   self._@content = set:getLabelNode("@content")
end
--@@@@]]]]

-- local Launcher = require 'Launcher'

-- Launcher.register('DFeedback',function ( userData )
-- 	accounthelper.ACSFeedBackMylist(function ( datatable,tag,code,errorBuf )
-- 	  Launcher.Launching(datatable)
-- 	end)
-- end)

--------------------------------override functions----------------------
function DFeedback:onInit( userData, netData )
	res.doActionDialogShow(self._panel)
	self:addBtnListener()
	self._panel_Panel_3_0_tabSubmit:trigger(nil)
end

function DFeedback:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function DFeedback:addBtnListener( ... )
	self._clickBg:setEnabled(false)
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._panel, self)
	end)

	self._panel_btn_close:setListener(function ( ... )
		res.doActionDialogHide(self._panel, self)
	end)
	self._panel_Panel_3_0_tabCheck:setListener(function ( ... )
		if self._submitView then
			self._submitView[1]:setVisible(false)
		end
		self:showCheckView()
		self._checkView[1]:setVisible(true)
		self._panel_Panel_3_0:setResid("N_SZ_chakan.png")
	end)
	self._panel_Panel_3_0_tabSubmit:setListener(function ( ... )
		if self._checkView then
			self._checkView[1]:setVisible(false)
		end
		self:showSubmitView()
		self._submitView[1]:setVisible(true)
		self._panel_Panel_3_0:setResid("N_SZ_fankui.png")
	end)
end

function DFeedback:showSubmitView( ... )
	if not self._submitView then
		self._submitView = self:createLuaSet("@pageSubmit")
		self._panel_Panel_3_0:addChild(self._submitView[1])

		 local getContent,resetContent

		if SystemHelper:getPlatFormID() == 13 then--for wp
			 local box = ElfEditBox:create(nil,nil,nil)
			box:setContentSize(CCSizeMake(370,270))
			box:setPlaceHolder("")
			box:setMargin(2,2,2,2)
			box:setKeyBoardListener(function ( event )
				if event == -2 then
					box:setText(box:getText())
			     	end
			end)
			 local inputLable = box:getInputTextNode()
			inputLable:setDimensions(CCSize(370, 0))
			inputLable:setAnchorPoint(ccp(0, 1))
			inputLable:setPosition(ccp(-185, 135))
			inputLable:setFontSize(24)
			self._submitView["info_back"]:addChild(box)
			getContent = function ( ... )
				return box:getText()
			end
			resetContent = function ( ... )
				box:setText("")
			end
		else
			local inputText = InputTextNode:create(" ", "wenzi.ttf", 24)
			inputText:setDimensions(CCSizeMake(370,246))
			inputText:setPriorityLevel(-99999)
			self._submitView["info_back"]:addChild(inputText)
			-- inputText:enableStroke(ccc3(0, 0, 0), 1, true)
			inputText:setFontFillColor(ccc3(150,98,31), true)
			getContent = function ( ... )
				return inputText:getString()
			end
			resetContent = function ( ... )
				inputText:setString("","")
			end
		end

		for i = 1, 4 do
			self._submitView[string.format('option%d', i)]:setListener(function()
				self.option = i + 1
			end)
		end
		self._submitView['option1']:trigger(nil)

		self._submitView["btnSubmit"]:setListener(function ( ... )
			 local message = getContent()
			if not message or string.len(message)<=0 then
				return self:toast(res.locString('Set$Feedback2'))
			end

			if GleeUtils:utf8_strlen(message) > 270 then
				return self:toast(res.locString("Set$FeedbackOutOfLimit"))
	        end

			accounthelper.ACSFeedBack(self.option, message, function( datatable, tag, code, errorBuf ) 
				self:toast(res.locString('Set$Feedback1'))
				print(datatable)
				resetContent()
			end)
		end)
	end
end

function DFeedback:showCheckView( ... )
	if not self._checkView then
		self._checkView = self:createLuaSet("@pageCheck")
		self._panel_Panel_3_0:addChild(self._checkView[1])
	end
	--self._checkView[1]:setVisible(true)
	self._checkView["info_back_list"]:getContainer():removeAllChildrenWithCleanup(true)

	 local colorMap = {
		{ccc4f(0.56,0.18,0.04,1),ccc4f(0.66,0.29,0.13,1)},--gm
		{ccc4f(0.36,0.25,0.07,1),ccc4f(0.59,0.38,0.12,1)}--player
	}
	accounthelper.ACSFeedBackMylist(function ( datatable,tag,code,errorBuf )
	  	if not datatable or not next(datatable) then
			return
		end
		local userInfo = require 'AppData'.getUserInfo()
		local name = userInfo.getName()
		local count = 0
		for _,v in ipairs(datatable) do
			count = count + 1 + #v.Items
			local title = self:createLuaSet("@title")
			title["name"]:setString(name)
			title["name"]:setFontFillColor(colorMap[2][1],true)
			title["time"]:setString(string.sub(tostring(v.CreateAt), 6, -1))
			title["time"]:setFontFillColor(colorMap[2][1],true)
			self._checkView["info_back_list"]:addListItem(title[1])

			local content = self:createLuaSet("@content")[1]
			content:setString(v.Msg)
			content:setFontFillColor(colorMap[2][2],true)
			self._checkView["info_back_list"]:addListItem(content)

			for k1, v1 in pairs(v.Items) do
				local title = self:createLuaSet("@title")
				title["name"]:setString(res.locString('Set$Feedback3'))
				title["name"]:setFontFillColor(colorMap[1][1],true)
				title["time"]:setString(string.sub(tostring(v1.CreateAt), 6, -1))
				title["time"]:setFontFillColor(colorMap[1][1],true)
				self._checkView["info_back_list"]:addListItem(title[1])

				local content = self:createLuaSet("@content")[1]
				content:setString(v1.Msg)
				content:setFontFillColor(colorMap[1][2],true)
				self._checkView["info_back_list"]:addListItem(content)
			end
		end
		self:runWithDelay(function()
			self._checkView["info_back_list"]:alignTo(count * 2)
		end, 0.15)
	end)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DFeedback, "DFeedback")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DFeedback", DFeedback)


