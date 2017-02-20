local Config = require "Config"
local res = require "Res"
local netModel = require "netModel"

local DBuffExchangeForRoadOfChampion = class(LuaDialog)

function DBuffExchangeForRoadOfChampion:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DBuffExchangeForRoadOfChampion.cocos.zip")
    return self._factory:createDocument("DBuffExchangeForRoadOfChampion.cocos")
end

--@@@@[[[[
function DBuffExchangeForRoadOfChampion:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getShieldNode("bg")
    self._bg_detailBg_layout = set:getLinearLayoutNode("bg_detailBg_layout")
    self._name = set:getLabelNode("name")
    self._btn = set:getClickNode("btn")
    self._buffIcon = set:getElfNode("buffIcon")
    self._bg_detailBg_closeBtn = set:getButtonNode("bg_detailBg_closeBtn")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DBuffExchangeForRoadOfChampion:onInit( userData, netData )
	res.doActionDialogShow(self._bg)
	self.BuffList = userData.BuffList
	self.OnBuffExchange = userData.OnBuffExchange
	self:updateView()
	
	-- self._clickBg:setListener(function ( ... )
	-- 	res.doActionDialogHide(self._bg, self)
	-- end)
	self._bg_detailBg_closeBtn:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	require "GuideHelper":check("firstBuffEx")
end

function DBuffExchangeForRoadOfChampion:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function DBuffExchangeForRoadOfChampion:updateView( ... )
	local resMap = {"N_ZJZT_gongji.png","N_ZJZT_gongji2.png","N_ZJZT_huifu.png"}
	for i=1,3 do
		local set = self:createLuaSet("@item")
		local buffType = self.BuffList[i].Type
		local value = self.BuffList[i].Rate*100
		set["buffIcon"]:setResid(resMap[buffType])
		set["name"]:setString(string.format(res.locString(string.format("Activity$BuffType%d",buffType)),value))
		set["btn"]:setListener(function ( ... )
			self:send(netModel.getModelRoadOfChampionBuffChoose(i),function ( data )
				res.doActionDialogHide(self._bg, self)
				self.OnBuffExchange(data.D.Tower)
				-- return self:toast("Buff兑换成功")
			end)
		end)
		self._bg_detailBg_layout:addChild(set[1])
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DBuffExchangeForRoadOfChampion, "DBuffExchangeForRoadOfChampion")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DBuffExchangeForRoadOfChampion", DBuffExchangeForRoadOfChampion)


