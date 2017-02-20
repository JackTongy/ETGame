local Config = require "Config"
local AppData = require 'AppData'
local Toolkit = require 'Toolkit'
local Res = require 'Res'
local DBManager = require 'DBManager'
local TLGuildRank = class(TabLayer)

function TLGuildRank:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLGuildRank.cocos.zip")
    return self._factory:createDocument("TLGuildRank.cocos")
end

--@@@@[[[[
function TLGuildRank:onInitXML()
    local set = self._set
   self._bg_titleRank = set:getLabelNode("bg_titleRank")
   self._bg_titleName = set:getLabelNode("bg_titleName")
   self._bg_titleScore = set:getLabelNode("bg_titleScore")
   self._bg_titleP = set:getLabelNode("bg_titleP")
   self._bg_titleMem = set:getLabelNode("bg_titleMem")
   self._bg_list = set:getListNode("bg_list")
   self._bg = set:getElfNode("bg")
   self._rank = set:getLabelNode("rank")
   self._score = set:getLabelNode("score")
   self._icon = set:getElfNode("icon")
   self._guild = set:getLinearLayoutNode("guild")
   self._guild_flag = set:getElfNode("guild_flag")
   self._guild_name = set:getLabelNode("guild_name")
   self._p = set:getLabelNode("p")
   self._mem = set:getLabelNode("mem")
   self._selfRank = set:getElfNode("selfRank")
   self._selfRank_bg = set:getElfNode("selfRank_bg")
   self._selfRank_fore = set:getElfNode("selfRank_fore")
   self._selfRank_rank = set:getLabelNode("selfRank_rank")
   self._selfRank_score = set:getLabelNode("selfRank_score")
   self._selfRank_icon = set:getElfNode("selfRank_icon")
   self._selfRank_guild = set:getLinearLayoutNode("selfRank_guild")
   self._selfRank_guild_flag = set:getElfNode("selfRank_guild_flag")
   self._selfRank_guild_name = set:getLabelNode("selfRank_guild_name")
   self._selfRank_p = set:getLabelNode("selfRank_p")
   self._selfRank_mem = set:getLabelNode("selfRank_mem")
--   self._@view = set:getElfNode("@view")
--   self._@itemRank = set:getElfNode("@itemRank")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLGuildRank:onInit( userData, netData )
  self:updateLayer()
end

function TLGuildRank:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function TLGuildRank:updateLayer( ... )
  self:updateList()
end

function TLGuildRank:updateList( ... )
  local guildinfo = AppData.getGuildInfo()
  local ranks = guildinfo.getRanks().Guilds
  local list = self._viewSet['bg_list']
  list:stopAllActions()
  list:getContainer():removeAllChildrenWithCleanup(true)
  for i,v in ipairs(ranks) do
    local set = self:createLuaSet('@itemRank')
    list:getContainer():addChild(set[1])  
    if i < 10 then
      self:refreshSet(set,v,i)
    else
      self:runWithDelay(function ( ... )
        self:refreshSet(set,v,i)
      end,(i-10)*0.1,list)
    end
  end

  list:layout()
  self:refreshSelfRank(guildinfo)
end

function TLGuildRank:refreshSet( set,v ,i)
  set['bg']:setVisible(i%2~=0)
  if i <= 3 then
    set['icon']:setResid(string.format('paiming_tubiao%d.png',i))
  end
  set['rank']:setString(string.format('NO.%d',i))
  Toolkit.setClubIcon(set['guild_flag'],v.Pic)  
  set['guild_name']:setString(tostring(v.Title))
  set['score']:setString(tostring(v.Power))
  set['p']:setString(tostring(v.Name))

  local lvcfg = DBManager.getGuildlv(v.Lv)
  set['mem']:setString(string.format('%s/%s',tostring(v.Number),tostring(lvcfg.number)))
end

function TLGuildRank:refreshSelfRank( guildinfo )
  local rank = guildinfo.getRanks().Top
  local pname = guildinfo.getRanks().Name
  local guild = guildinfo.getData()
  if rank <= 3 then
    self._viewSet['selfRank_icon']:setResid(string.format('paiming_tubiao%d.png',rank))
  end
  self._viewSet['selfRank_rank']:setString(string.format('NO.%d',rank))
  Toolkit.setClubIcon(self._viewSet['selfRank_guild_flag'],guild.Pic)
  self._viewSet['selfRank_guild_name']:setString(tostring(guild.Title))
  self._viewSet['selfRank_score']:setString(tostring(guild.Power))
  self._viewSet['selfRank_p']:setString(tostring(pname))

  local lvcfg = DBManager.getGuildlv(guild.Lv)
  local memcnt = string.format('%s/%s',tostring(guild.Number),tostring(lvcfg.number))
  self._viewSet['selfRank_mem']:setString(memcnt)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLGuildRank, "TLGuildRank")


--------------------------------register--------------------------------
return TLGuildRank
