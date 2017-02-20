local Config = require "Config"
local res = require "Res"
local netModel = require "netModel"

local DGBReport = class(LuaDialog)

function DGBReport:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGBReport.cocos.zip")
    return self._factory:createDocument("DGBReport.cocos")
end

--@@@@[[[[
function DGBReport:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._root = set:getElfNode("root")
   self._root_title = set:getLabelNode("root_title")
   self._root_btnLeft = set:getButtonNode("root_btnLeft")
   self._root_btnRight = set:getButtonNode("root_btnRight")
   self._root_list = set:getListNode("root_list")
--   self._@text = set:getRichLabelNode("@text")
--   self._@sep = set:getElfNode("@sep")
--   self._@text = set:getRichLabelNode("@text")
end
--@@@@]]]]

--------------------------------override functions----------------------

local Launcher = require 'Launcher'
Launcher.register("DGBReport", function ( ... )
	Launcher.callNet(netModel.getModelGuildMatchInfoGet(),function ( data )
		Launcher.Launching(data) 
	end)
end)

function DGBReport:onInit( userData, netData )
	if netData and netData.D then
		self.reportData = netData.D
	end

	self.isMyGuild = false
	self:setListenerEvent()
	self:updateLayer()
	res.doActionDialogShow(self._root)
end

function DGBReport:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DGBReport:setListenerEvent( ... )
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._root, self)
	end)

	self._root_btnLeft:setListener(function ( ... )
		self.isMyGuild = not self.isMyGuild
		self:updateLayer()
	end)

	self._root_btnRight:setListener(function ( ... )
		self.isMyGuild = not self.isMyGuild
		self:updateLayer()
	end)
end

function DGBReport:updateLayer( ... )
	self._root_title:setString(res.locString(string.format("GuildBattle$reportTitle%d", self.isMyGuild and 2 or 1)))

	self._root_list:getContainer():removeAllChildrenWithCleanup(true)
	local contentList = self:getContentList()
	if contentList then
		for i,v in ipairs(contentList) do
			if i ~= 1 then
				local sep = self:createLuaSet("@sep")
				self._root_list:addListItem(sep[1])
			end
			local item = self:createLuaSet("@text")
			self._root_list:addListItem(item[1])
			item[1]:setString(v.Msg)
		end
	end
	self._root_list:layout()
	
	self._root_btnLeft:setVisible(self.isMyGuild)
	self._root_btnRight:setVisible(not self.isMyGuild)
end

function DGBReport:getContentList( ... )
	if self.reportData then
		if self.isMyGuild then
			return self.reportData.Ours
		else
			return self.reportData.All
		end
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGBReport, "DGBReport")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGBReport", DGBReport)
