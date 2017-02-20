local Config = require "Config"
local res = require "Res"
local toolkit =require "Toolkit"
local dbManager = require "DBManager"

local DClubIconChoose = class(LuaDialog)

function DClubIconChoose:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DClubIconChoose.cocos.zip")
    return self._factory:createDocument("DClubIconChoose.cocos")
end

--@@@@[[[[
function DClubIconChoose:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getShieldNode("bg")
    self._bg_bg_list = set:getListNode("bg_bg_list")
    self._layout = set:getLinearLayoutNode("layout")
    self._icon = set:getElfNode("icon")
    self._btn = set:getButtonNode("btn")
--    self._@line = set:getElfNode("@line")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DClubIconChoose:onInit( userData, netData )
	self.mListener = userData.Listener

	res.doActionDialogShow(self._bg)

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self:updateView()
end

function DClubIconChoose:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function DClubIconChoose:updateView( ... )
	local line
	local index = 0
	for i,v in ipairs(require "guild_icon") do
		local item = self:createLuaSet("@item")
		toolkit.setClubIcon(item["icon"],v.id)
		item["btn"]:setListener(function ( ... )
			res.doActionDialogHide(self._bg, function ( ... )
				self:close()
				self.mListener(v.id)
			end)
		end)
		if index%4 == 0 then
			line = self:createLuaSet("@line")
			self._bg_bg_list:addListItem(line[1])
		end
		line["layout"]:addChild(item[1])
		index = index + 1
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DClubIconChoose, "DClubIconChoose")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DClubIconChoose", DClubIconChoose)


