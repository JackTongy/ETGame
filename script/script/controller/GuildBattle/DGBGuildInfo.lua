local Config = require "Config"
local res = require "Res"
local netModel = require "netModel"
local LuaList = require "LuaList"
local petFunc = require "AppData".getPetInfo()

local DGBGuildInfo = class(LuaDialog)

function DGBGuildInfo:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGBGuildInfo.cocos.zip")
    return self._factory:createDocument("DGBGuildInfo.cocos")
end

--@@@@[[[[
function DGBGuildInfo:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._root = set:getElfNode("root")
    self._root_kl_icon = set:getElfNode("root_kl_icon")
    self._root_kl_guildName = set:getLabelNode("root_kl_guildName")
    self._root_kl_layoutGuildMaster_v = set:getLabelNode("root_kl_layoutGuildMaster_v")
    self._root_kl_layoutBattleValueAll_v = set:getLabelNode("root_kl_layoutBattleValueAll_v")
    self._root_kl_layoutPlayerCount_v = set:getLabelNode("root_kl_layoutPlayerCount_v")
    self._root_kr_list = set:getListNode("root_kr_list")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._title = set:getLabelNode("title")
    self._layoutBattleValue = set:getLinearLayoutNode("layoutBattleValue")
    self._layoutBattleValue_v = set:getLabelNode("layoutBattleValue_v")
    self._layoutHonor = set:getLinearLayoutNode("layoutHonor")
    self._layoutHonor_v = set:getLabelNode("layoutHonor_v")
--    self._@player = set:getElfNode("@player")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DGBGuildInfo", function ( userData )
	Launcher.callNet(netModel.getModelGuildMatchHomeInfo(userData.castle.ServerId, userData.castle.GuildId),function ( data )
		if data and data.D then
			Launcher.Launching(data)   
		end
	end)
end)

function DGBGuildInfo:onInit( userData, netData )
	local guildInfo = netData.D

	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._root, self)
	end)

	require 'Toolkit'.setClubIcon(self._root_kl_icon, guildInfo.Pic)
	self._root_kl_guildName:setString(guildInfo.GuildName .. " Lv." .. guildInfo.GuildLv)
	self._root_kl_layoutGuildMaster_v:setString(guildInfo.GuildHeader)
	self._root_kl_layoutBattleValueAll_v:setString(guildInfo.TotalPwr)
	self._root_kl_layoutPlayerCount_v:setString(tostring(guildInfo.TotalPlayer) .. res.locString("GuildBattle$people"))

	if not self.itemList then
		self.itemList = LuaList.new(self._root_kr_list, function ( ... )
			return self:createLuaSet("@player")
		end, function ( nodeLuaSet, data )
			res.setNodeWithPet( nodeLuaSet["icon"], petFunc.getPetInfoByPetId( data.PetId, data.AwakeIndex ) )
			nodeLuaSet["title"]:setString(data.Name .. " Lv." .. data.Lv)
			nodeLuaSet["layoutBattleValue_v"]:setString(data.Pwr)
			nodeLuaSet["layoutHonor_v"]:setString(data.Title)

			local function adjust( ... )
				nodeLuaSet["title"]:setPosition(ccp(-102.85741,28.571442))
				nodeLuaSet["layoutBattleValue"]:setPosition(ccp(-102.85741,2.8571472))
				nodeLuaSet["layoutHonor"]:setPosition(ccp(-102.85741,-25.71428))
			end
			require 'LangAdapter'.selectLang(nil, nil, adjust, nil, function ( ... )
				nodeLuaSet["layoutHonor"]:layout()
				res.adjustNodeWidth( nodeLuaSet["layoutHonor"], 144 )
			end, adjust, adjust)
		end)
	end
	self.itemList:update(guildInfo.Players)

	res.doActionDialogShow(self._root)
end

function DGBGuildInfo:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGBGuildInfo, "DGBGuildInfo")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGBGuildInfo", DGBGuildInfo)


