local Config = require "Config"
local Res = require "Res"
local dbManager = require "DBManager"
local appData = require "AppData"
local netModel = require "netModel"
local eventCenter = require 'EventCenter'
local Launcher = require 'Launcher'
local TLBossRank = class(TabLayer)

function TLBossRank:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLBossRank.cocos.zip")
    return self._factory:createDocument("TLBossRank.cocos")
end

--@@@@[[[[
function TLBossRank:onInitXML()
    local set = self._set
   self._list = set:getListNode("list")
   self._bg = set:getElfNode("bg")
   self._fore = set:getJoint9Node("fore")
   self._rank = set:getLabelNode("rank")
   self._name = set:getLabelNode("name")
   self._score = set:getLabelNode("score")
   self._icon = set:getElfNode("icon")
   self._selfRank = set:getElfNode("selfRank")
   self._selfRank_bg = set:getElfNode("selfRank_bg")
   self._selfRank_fore = set:getElfNode("selfRank_fore")
   self._selfRank_rank = set:getLabelNode("selfRank_rank")
   self._selfRank_name = set:getLabelNode("selfRank_name")
   self._selfRank_score = set:getLabelNode("selfRank_score")
   self._selfRank_icon = set:getElfNode("selfRank_icon")
--   self._@view = set:getElfNode("@view")
--   self._@itemRank = set:getElfNode("@itemRank")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLBossRank:onInit( userData, netData )
	self._ranks = self._parent._netData.rankData.Ranks
  self:updateLayer()
end

function TLBossRank:onEnter( ... )

  self._parent:refreshBossTitle(true)
  if not self._ranks or (type(self._ranks) == 'table' and #self._ranks == 0) then
    self:send(netModel.getBossAtkRank(self._parent._netData.D.BossAtk.BossId),function ( data )
      self._parent._netData.rankData = data.D
      self._ranks = self._parent._netData.rankData.Ranks
      self:updateLayer()
    end)
  end
  
end

function TLBossRank:onBack( userData, netData )
	
end

function TLBossRank:onLeave( ... )
  self._parent:refreshBossTitle()
end

--------------------------------custom code-----------------------------
function TLBossRank:updateLayer( ... )
  self:updateRank(self._ranks)
end

function TLBossRank:updateRank( ranks )

  self._viewSet['list']:getContainer():removeAllChildrenWithCleanup(true)
  self._viewSet['selfRank']:setVisible(false)
  local selfId = appData.getUserInfo().getId()
  for i,v in ipairs(ranks) do
    local luaset = self:refreshRankCell(nil,v,i,selfId)
    if luaset then
      self._viewSet['list']:getContainer():addChild(luaset[1])  
    end
  end
  
end

function TLBossRank:refreshRankCell( set,item,i,selfId )

  if selfId == item.Rid then
    if i <= 3 then
      self._viewSet['selfRank_icon']:setResid(string.format('paiming_tubiao%d.png',i))
    end
    self._viewSet['selfRank_name']:setString(string.format('%s Lv.%d',item.Name,item.Lv))
    self._viewSet['selfRank_rank']:setString(string.format('NO.%d',item.Rank))
    self._viewSet['selfRank_score']:setString(string.format('%d (%s)',item.Harm,item.Percent))
    self._viewSet['selfRank_fore']:setVisible(true)
    self._viewSet['selfRank']:setVisible(true)
  end

  if selfId == item.Rid and item.Rank > 10 then
    return nil
  end

  local set = self:createLuaSet('@itemRank')
  if i <= 3 then
    set['icon']:setResid(string.format('paiming_tubiao%d.png',i))
  end
  set['name']:setString(string.format('%s Lv.%d',item.Name,item.Lv))
  set['rank']:setString(string.format('NO.%d',item.Rank))
  set['score']:setString(string.format('%d (%s)',item.Harm,item.Percent))
  set['bg']:setVisible(i%2 ~= 0)
  set['fore']:setVisible(false)
  return set

end


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLBossRank, "TLBossRank")


--------------------------------register--------------------------------
return TLBossRank
