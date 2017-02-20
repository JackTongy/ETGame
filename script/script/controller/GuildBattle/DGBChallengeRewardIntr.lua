local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"

local DGBChallengeRewardIntr = class(LuaDialog)

function DGBChallengeRewardIntr:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGBChallengeRewardIntr.cocos.zip")
    return self._factory:createDocument("DGBChallengeRewardIntr.cocos")
end

--@@@@[[[[
function DGBChallengeRewardIntr:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._root = set:getElfNode("root")
    self._root_list = set:getListNode("root_list")
    self._layout = set:getLinearLayoutNode("layout")
    self._layout_k = set:getLabelNode("layout_k")
    self._layout_v = set:getLabelNode("layout_v")
    self._text = set:getLabelNode("text")
    self._layout = set:getLinearLayoutNode("layout")
    self._layout_k = set:getLabelNode("layout_k")
    self._layout_v = set:getLabelNode("layout_v")
--    self._@title = set:getElfNode("@title")
--    self._@teamTitle = set:getElfNode("@teamTitle")
--    self._@item = set:getElfNode("@item")
--    self._@sep = set:getElfNode("@sep")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DGBChallengeRewardIntr:onInit( userData, netData )
	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._root, self)
	end)

	local container = self._root_list:getContainer()
	container:removeAllChildrenWithCleanup(true)

	local title = self:createLuaSet("@title")
	container:addChild(title[1])
	userData.coin = userData.coin or 0
	title["layout_v"]:setString(userData.coin)
	require 'LangAdapter'.selectLang(nil, nil, function ( ... )
		title["layout_k"]:setFontSize(20)
		title["layout_v"]:setFontSize(20)
	end, function ( ... )
		title["layout_k"]:setFontSize(20)
		title["layout_v"]:setFontSize(20)
	end, function ( ... )
		title["layout_k"]:setFontSize(20)
		title["layout_v"]:setFontSize(20)
	end,function ( ... )
		title["layout_k"]:setFontSize(21)
		title["layout_v"]:setFontSize(21)
		if userData.coin > 10000 then
			title["layout_v"]:setString(string.format("%dk", userData.coin / 1000))
		end
	end, function ( ... )
		title["layout_k"]:setFontSize(21)
		title["layout_v"]:setFontSize(21)
		if userData.coin > 10000 then
			title["layout_v"]:setString(string.format("%dk", userData.coin / 1000))
		end
	end)

	for i=1,3 do
		if i ~= 1 then
			local sep = self:createLuaSet("@sep")
			container:addChild(sep[1])
		end

		local teamTitle = self:createLuaSet("@teamTitle")
		container:addChild(teamTitle[1])
		teamTitle["text"]:setString( res.locString(string.format("GuildBattle$rewardTeam%d", i)) )
		require 'LangAdapter'.selectLang(nil, nil, function ( ... )
			teamTitle["text"]:setFontSize(18)
		end, function ( ... )
			teamTitle["text"]:setFontSize(18)
		end)		

		local t = dbManager.getGuildFightBossReward(i)
		if t then
			for i,v in ipairs(t) do
				local item = self:createLuaSet("@item")
				container:addChild(item[1])

				item["layout_k"]:setString( string.format(res.locString("GuildBattle$rewardItem1"), self:getNumberFormat( v.Harm ) ) )
				item["layout_v"]:setString( string.format(res.locString("GuildBattle$rewardItem2"), v.reward) )
			
				require 'LangAdapter'.selectLang(nil, nil, function ( ... )
					item["layout_k"]:setFontSize(16)
					item["layout_#elf"]:setScale(0.8)
					item["layout_v"]:setFontSize(16)
				end, function ( ... )
					item["layout_k"]:setFontSize(16)
					item["layout_#elf"]:setScale(0.8)
					item["layout_v"]:setFontSize(16)
				end)		
			end
		end
	end

	res.doActionDialogShow(self._root)
end

function DGBChallengeRewardIntr:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DGBChallengeRewardIntr:getNumberFormat( num )

	if num >= 10000 then
		return string.format("%dk", math.floor(num / 1000))
	else
		return tostring(num)
	end

	local func = function ( ... )
		if num >= 1000 then
			return string.format("%dk", math.floor(num / 1000))
		else
			return tostring(num)
		end
	end

	local funcPT = function ( ... )
		local temp = math.floor(num / 1000000)
		if temp >= 1 then
			return string.format("%dM", temp)
		else
			return string.format("%.1fM", temp)
		end		
	end

	local ret = require 'LangAdapter'.selectLangkv({Arabic=func,ES=funcPT,PT=funcPT})
	if ret then
		return ret
	end
	
	if num >= 10000 then
		if Config.LangName == "German" then
			return string.format("%dk",math.floor(num / 1000))
		end
		return string.format("%dw", math.floor(num / 10000))
	end

end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGBChallengeRewardIntr, "DGBChallengeRewardIntr")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGBChallengeRewardIntr", DGBChallengeRewardIntr)
