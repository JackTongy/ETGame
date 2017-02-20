local Config = require "Config"
local Res = require 'Res'
local DBManager = require 'DBManager'
local DguildBattleStat = class(LuaDialog)

function DguildBattleStat:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DguildBattleStat.cocos.zip")
    return self._factory:createDocument("DguildBattleStat.cocos")
end

--@@@@[[[[
function DguildBattleStat:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getJoint9Node("bg")
    self._bg_left = set:getElfNode("bg_left")
    self._bg_left_badge_bg = set:getElfNode("bg_left_badge_bg")
    self._bg_left_badge_icon = set:getElfNode("bg_left_badge_icon")
    self._bg_left_badge_frame = set:getElfNode("bg_left_badge_frame")
    self._bg_left_badge_name = set:getLabelNode("bg_left_badge_name")
    self._bg_left_honor = set:getLinearLayoutNode("bg_left_honor")
    self._bg_left_honor_union = set:getLabelNode("bg_left_honor_union")
    self._bg_left_des = set:getLabelNode("bg_left_des")
    self._bg_left_reward = set:getLinearLayoutNode("bg_left_reward")
    self._bg_left_reward_icon = set:getElfNode("bg_left_reward_icon")
    self._bg_left_reward_des = set:getLabelNode("bg_left_reward_des")
    self._bg_left_reward_amount = set:getLabelNode("bg_left_reward_amount")
    self._bg_right = set:getElfNode("bg_right")
    self._bg_right_icon_bg = set:getElfNode("bg_right_icon_bg")
    self._bg_right_icon_img = set:getElfNode("bg_right_icon_img")
    self._bg_right_icon_frame = set:getElfNode("bg_right_icon_frame")
    self._bg_right_name = set:getLabelNode("bg_right_name")
    self._bg_right_honor = set:getLinearLayoutNode("bg_right_honor")
    self._bg_right_honor_union = set:getLabelNode("bg_right_honor_union")
    self._bg_right_des = set:getLabelNode("bg_right_des")
    self._bg_right_layout_cell1 = set:getElfNode("bg_right_layout_cell1")
    self._bg_right_layout_cell1_rankIcon = set:getElfNode("bg_right_layout_cell1_rankIcon")
    self._bg_right_layout_cell1_reward = set:getLinearLayoutNode("bg_right_layout_cell1_reward")
    self._bg_right_layout_cell1_reward_icon = set:getElfNode("bg_right_layout_cell1_reward_icon")
    self._bg_right_layout_cell1_reward_des = set:getLabelNode("bg_right_layout_cell1_reward_des")
    self._bg_right_layout_cell1_reward_amount = set:getLabelNode("bg_right_layout_cell1_reward_amount")
    self._bg_right_layout_cell1_money = set:getLinearLayoutNode("bg_right_layout_cell1_money")
    self._bg_right_layout_cell1_money_des = set:getLabelNode("bg_right_layout_cell1_money_des")
    self._bg_right_layout_cell1_money_amount = set:getLabelNode("bg_right_layout_cell1_money_amount")
    self._bg_right_layout_cell2 = set:getElfNode("bg_right_layout_cell2")
    self._bg_right_layout_cell2_rankIcon = set:getElfNode("bg_right_layout_cell2_rankIcon")
    self._bg_right_layout_cell2_reward = set:getLinearLayoutNode("bg_right_layout_cell2_reward")
    self._bg_right_layout_cell2_reward_icon = set:getElfNode("bg_right_layout_cell2_reward_icon")
    self._bg_right_layout_cell2_reward_des = set:getLabelNode("bg_right_layout_cell2_reward_des")
    self._bg_right_layout_cell2_reward_amount = set:getLabelNode("bg_right_layout_cell2_reward_amount")
    self._bg_right_layout_cell2_money = set:getLinearLayoutNode("bg_right_layout_cell2_money")
    self._bg_right_layout_cell2_money_des = set:getLabelNode("bg_right_layout_cell2_money_des")
    self._bg_right_layout_cell2_money_amount = set:getLabelNode("bg_right_layout_cell2_money_amount")
    self._bg_right_layout_cell3 = set:getElfNode("bg_right_layout_cell3")
    self._bg_right_layout_cell3_rankIcon = set:getElfNode("bg_right_layout_cell3_rankIcon")
    self._bg_right_layout_cell3_reward = set:getLinearLayoutNode("bg_right_layout_cell3_reward")
    self._bg_right_layout_cell3_reward_icon = set:getElfNode("bg_right_layout_cell3_reward_icon")
    self._bg_right_layout_cell3_reward_des = set:getLabelNode("bg_right_layout_cell3_reward_des")
    self._bg_right_layout_cell3_reward_amount = set:getLabelNode("bg_right_layout_cell3_reward_amount")
    self._bg_right_layout_cell3_money = set:getLinearLayoutNode("bg_right_layout_cell3_money")
    self._bg_right_layout_cell3_money_des = set:getLabelNode("bg_right_layout_cell3_money_des")
    self._bg_right_layout_cell3_money_amount = set:getLabelNode("bg_right_layout_cell3_money_amount")
    self._bg_right_layout_stronghold = set:getLinearLayoutNode("bg_right_layout_stronghold")
    self._bg_right_layout_stronghold_union = set:getLabelNode("bg_right_layout_stronghold_union")
    self._bg_right_layout_score = set:getLinearLayoutNode("bg_right_layout_score")
    self._bg_right_layout_score_union = set:getLabelNode("bg_right_layout_score_union")
    self._bg_right_layout_rank = set:getLinearLayoutNode("bg_right_layout_rank")
    self._bg_right_layout_rank_union = set:getLabelNode("bg_right_layout_rank_union")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DguildBattleStat:onInit( userData, netData )
    Res.doActionDialogShow(self._bg)
    self._clickBg:setListener(function ( ... )
        Res.doActionDialogHide(self._bg, self)
    end)
	self:updateDialog()
end

function DguildBattleStat:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DguildBattleStat:updateDialog()
    local personal = require 'GBHelper'.getGuildMatchPlayer()
    self._bg_left_badge_icon:setResid(string.format('guild_touxian_%d.png', personal.TitleId))
    local guildTitle = DBManager.getGuildTitle(personal.TitleId)
    self._bg_left_badge_name:setString(guildTitle.title)
    self._bg_left_honor_union:setString(' '..tostring(personal.Honor))
    self._bg_left_reward_amount:setString(string.format('%s+%d', Res.locString('Global$coin'), personal.TodayHonor * guildTitle.args[1] + guildTitle.args[2]))
    
    local info = self:getUserData().info
    require 'Toolkit'.setClubIcon(self._bg_right_icon_img, info.GuildPic)
    self._bg_right_name:setString(info.GuildName)
    self._bg_right_honor_union:setString(' '..info.ServerName)
    
    local amount =  0
    if info.CastleId and next(info.CastleId) then
        amount = #info.CastleId
    end
    self._bg_right_layout_stronghold_union:setString(" "..tostring(amount))
    self._bg_right_layout_score_union:setString(" "..tostring(info.Score))
    self._bg_right_layout_rank_union:setString(" "..string.format(Res.locString('Global$NOX'), info.Rank))

    local tableInfo = require 'guild_fight_top'
    for i = 1, 3 do
        self[string.format('_bg_right_layout_cell%d_reward_amount', i)]:setString(string.format('+%d', tableInfo[i].memberpoint))
        self[string.format('_bg_right_layout_cell%d_money_amount', i)]:setString(string.format('+%d', tableInfo[i].guildpoint))

        require 'LangAdapter'.selectLang(nil,nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
        		self[string.format('_bg_right_layout_cell%d_reward', i)]:layout()
        		Res.adjustNodeWidth( self[string.format('_bg_right_layout_cell%d_reward', i)], 72)
        		self[string.format('_bg_right_layout_cell%d_money', i)]:layout()
        		Res.adjustNodeWidth( self[string.format('_bg_right_layout_cell%d_money', i)], 76)
        end)
    end

	require 'LangAdapter'.selectLang(nil, nil, function ( ... )
		self["_bg_right_des"]:setFontSize(22)
		self["_bg_left_des"]:setFontSize(18)
	end,nil,nil,nil,function ( ... )
		self._set:getLabelNode("bg_right_layout_score_#des"):setString("Pts")
	end,nil,nil,function ( ... )
		self._bg_right_layout_score:layout()
		Res.adjustNodeWidth( self._bg_right_layout_score, 124)
		self._bg_right_layout_rank:layout()
		Res.adjustNodeWidth( self._bg_right_layout_rank, 124)
	end)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DguildBattleStat, "DguildBattleStat")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DguildBattleStat", DguildBattleStat)


