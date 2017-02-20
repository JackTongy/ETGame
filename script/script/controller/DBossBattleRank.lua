local Config = require "Config"
local Res = require "Res"
local dbManager = require "DBManager"
local appData = require "AppData"
local netModel = require "netModel"
local eventCenter = require 'EventCenter'
local Launcher = require 'Launcher'

Launcher.register('DBossBattleRank',function ( userData )

   Launcher.callNet(netModel.getBossAtkRank(userData.BossId),function ( data )
      print(data)
      Launcher.Launching(data)   
   end,nil,0)
   
end)

local DBossBattleRank = class(LuaDialog)

function DBossBattleRank:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DBossBattleRank.cocos.zip")
    return self._factory:createDocument("DBossBattleRank.cocos")
end

--@@@@[[[[
function DBossBattleRank:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._touchLayer = set:getLuaTouchNode("touchLayer")
   self._bg = set:getJoint9Node("bg")
   self._bg_title = set:getLabelNode("bg_title")
   self._bg_leftArrow = set:getElfNode("bg_leftArrow")
   self._bg_rightArrow = set:getElfNode("bg_rightArrow")
   self._bg_clipSwip_pageSwip = set:getSwipNode("bg_clipSwip_pageSwip")
   self._bg_clipSwip_pageSwip_linearlayout = set:getLinearLayoutNode("bg_clipSwip_pageSwip_linearlayout")
   self._bg_clipSwip_pageSwip_linearlayout_pageRankList = set:getElfNode("bg_clipSwip_pageSwip_linearlayout_pageRankList")
   self._bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_list = set:getListNode("bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_list")
   self._bg = set:getElfNode("bg")
   self._fore = set:getJoint9Node("fore")
   self._rank = set:getLabelNode("rank")
   self._name = set:getLabelNode("name")
   self._score = set:getLabelNode("score")
   self._icon = set:getElfNode("icon")
   self._bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank = set:getElfNode("bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank")
   self._bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank_bg = set:getElfNode("bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank_bg")
   self._bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank_fore = set:getJoint9Node("bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank_fore")
   self._bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank_rank = set:getLabelNode("bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank_rank")
   self._bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank_name = set:getLabelNode("bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank_name")
   self._bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank_score = set:getLabelNode("bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank_score")
   self._bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank_icon = set:getElfNode("bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank_icon")
   self._bg_clipSwip_pageSwip_linearlayout_pageReward = set:getElfNode("bg_clipSwip_pageSwip_linearlayout_pageReward")
   self._bg_clipSwip_pageSwip_linearlayout_pageReward_bg_list = set:getListNode("bg_clipSwip_pageSwip_linearlayout_pageReward_bg_list")
   self._content = set:getLabelNode("content")
   self._content = set:getLabelNode("content")
   self._content = set:getLabelNode("content")
   self._linear = set:getLinearLayoutNode("linear")
   self._linear_range = set:getLabelNode("linear_range")
   self._linear_content = set:getLabelNode("linear_content")
   self._bg_clipSwip_pageSwip_linearlayout_pageReward_bg_Tip = set:getLabelNode("bg_clipSwip_pageSwip_linearlayout_pageReward_bg_Tip")
   self._bg_pageindex = set:getLinearLayoutNode("bg_pageindex")
   self._bg_pageindex_point = set:getElfNode("bg_pageindex_point")
   self._bg_pageindex_sp = set:getElfNode("bg_pageindex_sp")
--   self._@itemRank = set:getElfNode("@itemRank")
--   self._@des1 = set:getElfNode("@des1")
--   self._@des2 = set:getElfNode("@des2")
--   self._@des3 = set:getElfNode("@des3")
--   self._@reward = set:getElfNode("@reward")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DBossBattleRank:onInit( userData, netData )
	Res.doActionDialogShow(self._bg)
  self._clickBg:setListener(function ( ... )
    Res.doActionDialogHide(self._bg, self)
  end)
  
  self:initRewardData()
  self:initSwipNode()
  self:updateLayer()

end

function DBossBattleRank:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DBossBattleRank:initSwipNode( ... )
  self._bg_clipSwip_pageSwip:registerSwipeListenerScriptHandler(function (onstart, preIndex, newIndex)
    self:selectPage(newIndex+1)
  end)
  self:selectPage(1)
end

function DBossBattleRank:updateLayer( ... )
  local dbinfo = self:getUserData().dbinfo
  local netData = self:getNetData()
  local userInfo = appData.getUserInfo()
  self._bg_title:setString(string.format('%s击杀排行',dbinfo.Name))
  self._bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank_name:setString(string.format('%s Lv.%d',userInfo.getName(),userInfo.getLevel()))
  self._bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank_rank:setString('-')
  self._bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank_score:setString('0')
  self:updateRank(netData.D.Ranks)
  self:updateReward()
end

function DBossBattleRank:updateRank( ranks )

  self._bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_list:getContainer():removeAllChildrenWithCleanup(true)
  local selfId = appData.getUserInfo().getId()
  for i,v in ipairs(ranks) do
    local luaset = self:refreshRankCell(nil,v,i,selfId)
    if luaset then
      self._bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_list:getContainer():addChild(luaset[1])  
    end
  end
  
end

function DBossBattleRank:updateReward( ... )
  local list = self._bg_clipSwip_pageSwip_linearlayout_pageReward_bg_list
  list:getContainer():removeAllChildrenWithCleanup(true)
  
  local set = self:createLuaSet('@des1')
  local bid = self:getUserData().dbinfo.Id
  local vt = {[1]='100000',[2]='200000'}  
  set['content']:setString(string.format(Res.locString('BossBattleRank$rewardDes1'),vt[bid]))
  
  list:getContainer():addChild(set[1])
  set = self:createLuaSet('@des2')
  list:getContainer():addChild(set[1])
  --排行奖励
  -- local rankr = {
  --   '金币400000+黄金宝箱*5+黄金钥匙*5',
  --   '金币300000+黄金宝箱*3+黄金钥匙*3+白银宝箱*2+白银钥匙*2 ',
  --   '金币280000+黄金宝箱*3+黄金钥匙*3+白银宝箱*1+白银钥匙*1+青铜宝箱*1+青铜钥匙*1 ',
  --   '金币260000+黄金宝箱*2+黄金钥匙*2+白银宝箱*2+白银钥匙*2+青铜宝箱*1+青铜钥匙*1 ',
  --   '金币240000+黄金宝箱*2+黄金钥匙*2+白银宝箱*1+白银钥匙*1+青铜宝箱*2+青铜钥匙*2 ',
  --   '金币220000+黄金宝箱*1+黄金钥匙*1+白银宝箱*2+白银钥匙*2+青铜宝箱*2+青铜钥匙*2 ',
  --   '金币200000+黄金宝箱*1+黄金钥匙*1+白银宝箱*1+白银钥匙*1+青铜宝箱*3+青铜钥匙*3 ',
  --   '金币180000+黄金宝箱*1+黄金钥匙*1+白银宝箱*1+白银钥匙*1+青铜宝箱*3+青铜钥匙*3 ',
  --   '金币160000+黄金宝箱*1+黄金钥匙*1+白银宝箱*1+白银钥匙*1+青铜宝箱*3+青铜钥匙*3',
  --   '金币140000+黄金宝箱*1+黄金钥匙*1+白银宝箱*1+白银钥匙*1+青铜宝箱*3+青铜钥匙*3',
  -- }
  local rankr = self.rankr
  for i,v in ipairs(rankr) do
    set = self:createLuaSet('@reward')
    self:refreshRewardItem(set,string.format(Res.locString('BossBattle$Reward'),i),v)
    list:getContainer():addChild(set[1]) 
  end

  set = self:createLuaSet('@des3')
  list:getContainer():addChild(set[1])
  --伤害范围奖励
  -- local harmr = {
  --   {0,0.5,'获得80000金币，1个青铜宝箱，1青铜钥匙'},
  --   {0.5,3,'获得120000金币，2个青铜宝箱，2青铜钥匙'},
  --   {3,6,'获得140000金币，1个白银宝箱，1白银钥匙，1个青铜宝箱，1青铜钥匙'},
  --   {6,12,'获得160000金币，2个白银宝箱，2白银钥匙'},
  --   {12,100,'获得200000金币，3个白银宝箱'}
  -- }
  local harmr = self.harmr
  for i,v in ipairs(harmr) do
    set = self:createLuaSet('@reward')
    self:refreshRewardItem(set,string.format('[%s%%~%s%%]',tostring(v[1]),tostring(v[2])),v[3])
    list:getContainer():addChild(set[1])
  end

  -- set = self:createLuaSet('@Tip')
  -- list:getContainer():addChild(set[1])
  list:layout()
end

function DBossBattleRank:initRewardData( ... )
  local userData = self:getUserData()
  local BossId = userData.BossId
  local BossAtkReward = require 'BossAtkReward'
  local curBossConfig = {}
  for i,v in ipairs(BossAtkReward) do
    if v.BossId == BossId then
      table.insert(curBossConfig,v)
    end  
  end

  self.rankr = {}
  for i,v in ipairs(curBossConfig) do
    if v.HarmLow == v.HarmUp and v.HarmLow == 0 and v.Kill == 0 then
      local simple = self:getRewardSimple(v)
      table.insert(self.rankr,simple)
    end
  end

  self.harmr = {}
  for i,v in ipairs(curBossConfig) do
    if v.HarmLow ~= v.HarmUp or v.HarmLow ~= 0 and v.Kill == 0 then
      local simple = self:getRewardSimple(v)
      local tmp = {[1]=v.HarmLow*100,[2]=v.HarmUp*100,[3]=simple}
      table.insert(self.harmr,tmp)
    end
  end

end

function DBossBattleRank:getRewardSimple( reward )
  
  local tmp = nil
  
  for i,v in ipairs(reward.RewardIds) do
    local item = dbManager.getRewardItem(v)
    local name = Res.getRewardStrAndResId(item.itemtype,item.itemid,item.args)
    local des = string.format('%sx%s',tostring(name),tostring(item.amount))
    if not tmp then
      tmp = des
    else
      tmp = string.format('%s+%s',tmp,des)
    end
  end

  return tmp

end

function DBossBattleRank:refreshRewardItem(set, title,content )
  
  set['linear_content']:setString(content)
  local csize = set['linear_content']:getContentSize()
  set['linear_range']:setDimensions(CCSizeMake(160,csize.height))
  set['linear_range']:setString(title)
  set['linear']:layout()
  set[1]:setContentSize(CCSizeMake(730,csize.height+6))
end

function DBossBattleRank:refreshRankCell( set,item,i,selfId )

  if selfId == item.Rid then
    if i <= 3 then
      self._bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank_icon:setResid(string.format('paiming_tubiao%d.png',i))
    end
    self._bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank_name:setString(string.format('%s Lv.%d',item.Name,item.Lv))
    self._bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank_rank:setString(string.format('NO.%d',item.Rank))
    self._bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank_score:setString(string.format('%d (%s)',item.Harm,item.Percent))
    self._bg_clipSwip_pageSwip_linearlayout_pageRankList_bg_selfRank_fore:setVisible(true)
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

function DBossBattleRank:selectPage( index )
  if index == 1 then
    self._bg_pageindex_point:setResid('huadong2.png')
    self._bg_pageindex_sp:setResid('huadong5.png')
  elseif index == 2 then
    self._bg_pageindex_point:setResid('huadong3.png')
    self._bg_pageindex_sp:setResid('huadong4.png')
  end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DBossBattleRank, "DBossBattleRank")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DBossBattleRank", DBossBattleRank)
