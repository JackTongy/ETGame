local Config = require "Config"

local Res = require "Res"
local dbManager = require "DBManager"
local equipFunc = require "EquipInfo"
local appData = require 'AppData'
local TimeManager = require 'TimeManager'
local netModel = require 'netModel'
local eventCenter = require 'EventCenter'

local db1   = dbManager.getInfoDefaultConfig('BossDownBattleCD')
local CD = (db1 and db1.Value and (db1.Value * 60) ) or 25*60
local BossLifeSeconds = 60*60
local update
local updateLayer
local refreshCell
local getBattleCount
local refreshNetData
local updateBossInfo
local hadBattle
local sortBossList
local refreshPreReward

local netData = {}

local setlist = {}
local function RichTextTouchEnable( enable )
  if setlist then
    for k,v in pairs(setlist) do
      if v and v['info_invite'] and not tolua.isnull(v['info_invite']) then --
        v['info_invite']:setVisible(enable)
      end
    end
  end
end

local function RichTextTouchInsert( itemSet )
  table.insert(setlist,itemSet)
end

local function RichTextTouchClear( )
  setlist = {}
end


local getMaxBattleCount = function ( ... )
  local viplv = require 'AppData'.getUserInfo().getVipLevel()
  local vipcfg = dbManager.getVipInfo(viplv)
  local count = (vipcfg and vipcfg.BossDownBattleTimes) or 3

  return count
end

local getNetModel = function ()
  
  return netModel.getModelBossGet()
end

update = function ( self,view,data )
  netData.Bosses = data.D.Bosses
  netData.Record = data.D.Record
    netData.BattleCountMax = getMaxBattleCount()
      netData.BattleCount = getBattleCount(netData.Bosses)

  --refreshNetData(self,view)
  updateLayer(self,view)
  eventCenter.addEventFunc('BossBattleRefresh',function ( data )
    updateLayer(self,view)
  end,'PetKill')

  eventCenter.addEventFunc('EventBossReload',function ( ... )
    refreshNetData(self,view)
  end,'PetKill')

  -- eventCenter.addEventFunc('BossBattleEnd',function ( data )
  --   local Bid = data.Bid
  --   local Hp = data.Hp
  --   self:send(netModel.getModelBossBattle( Bid,Hp ),function ( data )
  --       if data.D.Boss then
  --         updateBossInfo(data.D.Boss)
  --         updateLayer(self,view)
  --       end
  --   end)

  -- end,'PetKill')

  eventCenter.resetGroup('PetKillObs')
  eventCenter.addEventFunc('BossBattleEnd',function ( data )
    -- local Bid = data.Bid
    -- local Hp = data.Hp
    -- self:send(netModel.getModelBossBattle( Bid,Hp ),function ( data )
    --   -- GleeCore:showLayer('DPetKill')
    -- end)

  end,'PetKillObs')
  
  eventCenter.addEventFunc('OnBattleCompleted',function ( data )
    GleeCore:showLayer('DPetKill')
  end,'PetKillObs')

  require 'LangAdapter'.LabelNodeAutoShrink(view['bg_linearAmout_#title'],220)
  require 'LangAdapter'.LabelNodeAutoShrink(view['bg_linear_#title'],220)
end

updateBossInfo = function ( Boss )
  if netData.Bosses then
    for i,v in ipairs(netData.Bosses) do
      if v.Bid == Boss.Bid then
        netData.Bosses[i] = Boss
        break
      end
    end
  end

end

refreshNetData = function ( self,view )
  
  self:send(netModel.getModelBossGet(),function ( data )
    netData.Bosses = data.D.Bosses
    netData.Record = data.D.Record
    netData.BattleCountMax = getMaxBattleCount()
    netData.BattleCount = getBattleCount(netData.Bosses)
    updateLayer(self,view)
    return self.updateBossRecord and self:updateBossRecord(data.D.Record)
  end)

end

updateLayer = function ( self,view )
  -- view['btnRank']:setListener(function ( ... )
  --   GleeCore:showLayer('DPetKillRank',{Bosses=netData.Bosses})
  -- end)
  sortBossList(netData.Bosses)
  view['bg_linear_value']:setString(string.format(Res.locString('PetKill$count1'),tostring(netData.BattleCountMax-netData.BattleCount)))
  view['bg_linearAmout_value']:setString(string.format(Res.locString('PetKill$count2'),tostring(netData.Record.TodayBattleTimes)))

  local list = view['bg_list']
  list:getContainer():removeAllChildrenWithCleanup(true)

  RichTextTouchClear()
  if netData.Bosses then
    for i,v in ipairs(netData.Bosses) do
      local itemSet = self:createLuaSet('@item1')
      local ret = refreshCell(itemSet,v,self,view)
      if ret then
        list:getContainer():addChild(itemSet[1])  
        RichTextTouchInsert(itemSet)
      end
    end
  end

  list:layout()
end

--helper

getBattleCount = function ( Bosses )

  local cnt = 0
  if Bosses then
    for k,v in pairs(Bosses) do
      if hadBattle(v) then
        cnt = cnt + 1
      end
    end
  end

  return (cnt > netData.BattleCountMax and netData.BattleCountMax) or cnt

end

hadBattle = function ( BossDetail )
  return BossDetail.IsBattle
end

local getCDSeconds = function ( BossDetail )
  if (not BossDetail.IsClear or BossDetail.IsClear == 0) then
    local offset = TimeManager.timeOffset(BossDetail.BattleAt)
    if offset - CD < 0 then
      return CD - offset
    end
  end

  return 0

end

local getLastSeconds = function ( BossDetail )
  
  local offset = TimeManager.timeOffset(BossDetail.CreateAt)
  local lasts = BossLifeSeconds - offset

  return (lasts > 0 and lasts) or 0

end

--[[
  return
  0： 普通
  1： 挑战中（可挑战/cd）
  2： 已逃走
  3： 已击杀
]]
local getBossState = function ( BossDetail )

  if BossDetail.Pet.Hp == 0 then
    return 3
  elseif getLastSeconds(BossDetail) <= 0 then
    return 2
  elseif hadBattle(BossDetail) then
    return 1
  end

  return 0

end

local getFlagIcon = function ( state,BossDetail )
  if state == 1 and BossDetail and BossDetail.NotJoinReward then
    return 'SSJL_dengdaizhong.png'
  end

  local T = {
    [1]='SSJL_tiaozhanzhong.png',
    [2]='SSJL_yitaozou.png',
    [3]='SSJL_yitaozou.png',
  }
  return T[state]
end

local isGotoVisible = function ( BossDetail,withoutreward )

  local state = getBossState(BossDetail)
  return state < 2 and (hadBattle(BossDetail) or (netData.BattleCount < netData.BattleCountMax) or withoutreward )

end


refreshCell = function ( itemSet,BossDetail,self,view )
  --243 244 245 PetId
  if BossDetail == nil or BossDetail.Pid == 0 then
    return false
  end

  local dbpet = dbManager.getCharactor(BossDetail.Pet.PetId)
  
  itemSet['bggray']:setResid(string.format('SSJL_bjt_%d.png',BossDetail.Pet.PetId))
  itemSet['info_nameBg_name']:setString(string.format('%s Lv.%s',dbpet.name,tostring(BossDetail.Pet.Lv)))
  require 'LangAdapter'.selectLang(nil,nil,nil,nil,nil,function ( ... )
      itemSet['info_nameBg_name']:setString(string.format('%s Nv.%s',dbpet.name,tostring(BossDetail.Pet.Lv)))
  end)
  require 'LangAdapter'.LabelNodeAutoShrink(itemSet['info_invite'],420)

  local state = getBossState(BossDetail)
  local cdseconds = getCDSeconds(BossDetail)
  --state
  itemSet['bggray']:setGrayEnabled(state == 2 or state == 3)
  itemSet['progress']:setVisible(state < 2)
  itemSet['cd']:setVisible(cdseconds > 0 and state == 1)
  itemSet['cd_time']:clearListeners()
  if cdseconds > 0 then
    itemSet['cd_time']:setHourMinuteSecond(0,0,cdseconds)
    itemSet['cd_time']:addListener(function ( ... )
      itemSet['cd']:setVisible(false)
      cdseconds = 0
    end)
  end

  itemSet['state']:setResid(getFlagIcon(state,BossDetail))

  local hpleftpv = BossDetail.Pet.Hp/BossDetail.Pet.HpMax
  local bgsize = itemSet['progress_bg']:getContentSize()
  itemSet['hpLayout_content']:setString(string.format('%.1f%%',100*hpleftpv))
  itemSet['progress_newfore']:setLength(bgsize.width*hpleftpv,false)
  refreshPreReward(itemSet,BossDetail)

  itemSet['btnInvite']:setEnabled(false)
  if BossDetail.Cid == appData.getUserInfo().getId() then
    local fscnt = (BossDetail.Fs == nil and 0) or #BossDetail.Fs
    itemSet['info_invite']:setString(string.format(Res.locString('PetKill$InviteMore0'),fscnt))  
    -- itemSet['btnInvite']:setListener(function ( ... )
    --   GleeCore:showLayer('DFriendInvite',BossDetail)
    -- end)
    -- itemSet['btnInvite']:setEnabled(state < 2)
    itemSet['info_invite']:setLinkTarget(0,CCCallFunc:create(function ( ... )
      if state < 2 then
        GleeCore:showLayer('DFriendInvite',BossDetail)
        RichTextTouchEnable(false)
      end
    end))
    itemSet['info_invite']:setLinkTarget(1,CCCallFunc:create(function ( ... )
      if state < 2 then
        --邀请全部
        self:send(netModel.getModelBossInviteAll(BossDetail.Bid),function ( data )
          self:toast(Res.locString('PetKill$InviteMore1'))
          if data.D and data.D.Boss then
            updateBossInfo(data.D.Boss)
            updateLayer(self,view)
          end
        end)
      end
    end))
  else
    itemSet['info_invite']:setString(string.format(Res.locString('PetKill$InviteInfo'),BossDetail.CName))
    itemSet['btnInvite']:setEnabled(false)
  end
  
  local callfunc = function ( ... )
    if cdseconds <= 0 then
      --前往战斗
      local para = {}
      para.Boss = BossDetail
      para.Boss.Pet.aiType = BossDetail.AiType
      para.Boss.Pet.AwakeIndex = para.Boss.Pet.AwakeIndex or 24
      para.type = 'bossBattle'
      GleeCore:showLayer("DPrepareForStageBattle", para)
      RichTextTouchEnable(false)
    else
      --清除 cd 的弹出框
      local clearfunc = function ( ... )
        self:send(netModel.getModelBossClear(BossDetail.Bid),function ( data )
          BossDetail.IsClear = true
          if data.D.Coin then
            local curcoin = appData.getUserInfo().getCoin()
            appData.getUserInfo().setCoin(curcoin-data.D.Coin)
            require 'EventCenter'.eventInput("UpdateGoldCoin")
          end
          eventCenter.eventInput('BossBattleRefresh')
        end)
      end
      local coin = math.ceil(cdseconds/60)*3
      local str = string.format(Res.locString('PetKill$ClearCD'),coin)
      GleeCore:showLayer('DConfirmNT',{content=str,callback=clearfunc})
      RichTextTouchEnable(false)
    end
  end

  if isGotoVisible(BossDetail) then
    itemSet['goto']:setVisible(true)
    itemSet['btngoto']:setListener(callfunc)
  elseif isGotoVisible(BossDetail,true) then
    itemSet['goto']:setVisible(true)
    itemSet['btngoto']:setListener(function ( ... )
      GleeCore:showLayer('DConfirmNT',{content=Res.locString('PetKill$tip1'),callback=callfunc})
      RichTextTouchEnable(false)
    end)
  else
    itemSet['goto']:setVisible(false)
  end
  
  local lastseconds = getLastSeconds(BossDetail)
  if lastseconds <= 0 or BossDetail.Pet.Hp <= 0 then
    itemSet['info_timeLayout']:removeFromParent()
    itemSet['info_invite']:removeFromParent()  
  elseif lastseconds > 0 then 
    itemSet['info_timeLayout_time']:setHourMinuteSecond(0,0,lastseconds)
    itemSet['info_timeLayout_time']:clearListeners()
    itemSet['info_timeLayout_time']:addListener(function ( ... )
      eventCenter.eventInput('BossBattleRefresh')
    end)
  end

  return true
end

sortBossList = function ( Bosses )
  -- 活动中的boss-正在战斗的boss -自己的触发的boss-时间前面排序 
  if #Bosses > 1 then
    local selfid = appData.getUserInfo().getId()
    table.sort( Bosses,function ( v1,v2 )
      if v1 and v2 then
        local v1state = getBossState(v1)
        local v2state = getBossState(v2)

        if v1state ~= v2state then
          if v1state == 1 then
            return true
          end
          if v1state == 0 and v2state ~= 1 then
            return true
          end
        else
          if v1.Cid ~= v2.Cid then
            return selfid == v1.Cid
          else
            return TimeManager.getTimestamp(v1.CreateAt) < TimeManager.getTimestamp(v2.CreateAt)
          end
        end

      end
    end)
  end

end

refreshPreReward = function (itemSet, BossDetail )
  local state = getBossState(BossDetail)
  itemSet['info_perRecv']:setVisible(state < 2)

  local title   = ''
  local content = '0'
  if (BossDetail.Cid == appData.getUserInfo().getId()) or not BossDetail.NotJoinReward then
    title = Res.locString('PetKill$preReward')
    local harm   = BossDetail.Ht/BossDetail.Pet.HpMax
    local dbitem = dbManager.getBossActive(harm)
    if dbitem then
      local gold   = BossDetail.Pet.Lv * dbitem.gold
      local stone  = math.ceil(BossDetail.Pet.Lv/dbitem.dividend) + dbitem.addnumber
      content = string.format(Res.locString('PetKill$preRewardContent'),tostring(gold),tostring(stone))
    end
  else
    content = Res.locString('PetKill$friendHelp')
  end

  itemSet['info_perRecv_title']:setString(title)
  itemSet['info_perRecv_content']:setString(content)
end

local TLPetKill = class(TabLayer)

function TLPetKill:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLPetKill.cocos.zip")
    return self._factory:createDocument("TLPetKill.cocos")
end

--@@@@[[[[
function TLPetKill:onInitXML()
    local set = self._set
   self._bg_list = set:getListNode("bg_list")
   self._bggray = set:getElfGrayNode("bggray")
   self._btn = set:getButtonNode("btn")
   self._state = set:getElfNode("state")
   self._goto = set:getButtonNode("goto")
   self._cd = set:getLinearLayoutNode("cd")
   self._cd_time = set:getTimeNode("cd_time")
   self._btnInvite = set:getButtonNode("btnInvite")
   self._btngoto = set:getButtonNode("btngoto")
   self._info = set:getLinearLayoutNode("info")
   self._info_nameBg = set:getElfNode("info_nameBg")
   self._info_nameBg_name = set:getLabelNode("info_nameBg_name")
   self._info_timeLayout = set:getLinearLayoutNode("info_timeLayout")
   self._info_timeLayout_time = set:getTimeNode("info_timeLayout_time")
   self._info_perRecv = set:getLinearLayoutNode("info_perRecv")
   self._info_perRecv_title = set:getLabelNode("info_perRecv_title")
   self._info_perRecv_sp = set:getElfNode("info_perRecv_sp")
   self._info_perRecv_content = set:getLabelNode("info_perRecv_content")
   self._info_invite = set:getRichLabelNode("info_invite")
   self._progress = set:getElfNode("progress")
   self._progress_bg = set:getElfNode("progress_bg")
   self._progress_newfore = set:getBarNode("progress_newfore")
   self._hpLayout = set:getLinearLayoutNode("hpLayout")
   self._hpLayout_title = set:getLabelNode("hpLayout_title")
   self._hpLayout_content = set:getLabelNode("hpLayout_content")
   self._bg_linear_value = set:getLabelNode("bg_linear_value")
   self._bg_linearAmout_value = set:getLabelNode("bg_linearAmout_value")
--   self._@view = set:getElfNode("@view")
--   self._@item1 = set:getElfNode("@item1")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLPetKill:onInit( userData, netData )
	update(self,self._viewSet,self._parent:getNetData())
end

function TLPetKill:onBack( userData, netData )
	
end

function TLPetKill:onRelease( ... )
  eventCenter.resetGroup('PetKill')
end

function TLPetKill:parentnotify( state )
  if state then
    if state == 'back' then
      RichTextTouchEnable(true)
    elseif state == 'leave' then
      RichTextTouchEnable(false)
    end
  end
end

--------------------------------custom code-----------------------------
function TLPetKill:updateBossRecord( Record )
  local netdata = self._parent:getNetData()
  if netdata then
    netdata.D.Record = Record
  end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLPetKill, "TLPetKill")


--------------------------------register--------------------------------
return TLPetKill
