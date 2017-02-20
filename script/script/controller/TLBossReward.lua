local Config = require "Config"
local Res = require "Res"
local dbManager = require "DBManager"
local appData = require "AppData"
local netModel = require "netModel"
local eventCenter = require 'EventCenter'

local TLBossReward = class(TabLayer)

function TLBossReward:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLBossReward.cocos.zip")
    return self._factory:createDocument("TLBossReward.cocos")
end

--@@@@[[[[
function TLBossReward:onInitXML()
    local set = self._set
   self._bg_list = set:getListNode("bg_list")
   self._content = set:getLabelNode("content")
   self._content = set:getLabelNode("content")
   self._content = set:getLabelNode("content")
   self._linear = set:getLinearLayoutNode("linear")
   self._linear_range = set:getLabelNode("linear_range")
   self._linear_content = set:getLabelNode("linear_content")
   self._bg_Tip = set:getLabelNode("bg_Tip")
--   self._@view = set:getElfNode("@view")
--   self._@des1 = set:getElfNode("@des1")
--   self._@des2 = set:getElfNode("@des2")
--   self._@des3 = set:getElfNode("@des3")
--   self._@reward = set:getElfNode("@reward")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLBossReward:onInit( userData, netData )
	self:initRewardData()
  self:updateLayer()
end

function TLBossReward:onEnter( ... )
  
end

function TLBossReward:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function TLBossReward:updateLayer( ... )
  self.dbinfo = self._parent._curdbBoss
  local userInfo = appData.getUserInfo()
  -- self._bg_title:setString(string.format('%s击杀排行',dbinfo.Name))
  self:updateReward()
  self._viewSet['bg_Tip']:setString(string.format(Res.locString('BossBattleRank$rewardTIp'),self.dbinfo.Name))
  require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['bg_Tip'],650)
  
end

function TLBossReward:updateReward( ... )
  local list = self._viewSet['bg_list']
  list:getContainer():removeAllChildrenWithCleanup(true)
  
  local set = self:createLuaSet('@des1')
  -- local bid = self.dbinfo.Id
  -- local vt = {[1]='200000',[2]='300000'}  
  -- set['content']:setString(string.format(Res.locString('BossBattleRank$rewardDes1'),vt[bid]))
  
  -- list:getContainer():addChild(set[1])
  set = self:createLuaSet('@des2')
  local size = set['content']:getContentSize()
  set[1]:setContentSize(CCSizeMake(size.width,size.height))
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

function TLBossReward:initRewardData( ... )
  local BossId = self._parent._curdbBoss.Id
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

function TLBossReward:getRewardSimple( reward )
  
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

function TLBossReward:refreshRewardItem(set, title,content )
  
  set['linear_content']:setString(content)
  local csize = set['linear_content']:getContentSize()
  set['linear_range']:setDimensions(CCSizeMake(160,csize.height))
  set['linear_range']:setString(title)
  set['linear']:layout()
  set[1]:setContentSize(CCSizeMake(730,csize.height+6))
end


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLBossReward, "TLBossReward")


--------------------------------register--------------------------------
return TLBossReward
