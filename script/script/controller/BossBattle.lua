local Config = require "Config"

local BossBattle = class(LuaController)

function BossBattle:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."BossBattle.cocos.zip")
    return self._factory:createDocument("BossBattle.cocos")
end

--@@@@[[[[
function BossBattle:onInitXML()
    local set = self._set
   self._btnRank = set:getClickNode("btnRank")
   self._title1 = set:getLabelNode("title1")
   self._time = set:getTimeNode("time")
   self._boss = set:getElfNode("boss")
   self._range = set:getElfNode("range")
   self._bossname = set:getElfNode("bossname")
   self._bossnamelv = set:getElfNode("bossnamelv")
   self._bossnamelv_V = set:getLabelNode("bossnamelv_V")
   self._wait = set:getElfNode("wait")
   self._wait_Tip = set:getLabelNode("wait_Tip")
   self._wait_linearplayer_names = set:getLabelNode("wait_linearplayer_names")
   self._wait_linearkiller_names = set:getLabelNode("wait_linearkiller_names")
   self._wait_lineartime_time = set:getTimeNode("wait_lineartime_time")
   self._wait_Tip2 = set:getLabelNode("wait_Tip2")
   self._battleing = set:getElfNode("battleing")
   self._battleing_btnStart = set:getClickNode("battleing_btnStart")
   self._battleing_Hp = set:getLabelNode("battleing_Hp")
   self._battleing_linearbuff = set:getLinearLayoutNode("battleing_linearbuff")
   self._battleing_linearbuff_names = set:getLabelNode("battleing_linearbuff_names")
   self._battleing_progress = set:getElfNode("battleing_progress")
   self._battleing_progress_bg = set:getElfNode("battleing_progress_bg")
   self._battleing_progress_fore = set:getBarNode("battleing_progress_fore")
   self._battleing_progress_V = set:getLabelNode("battleing_progress_V")
   self._battleing_lineartime = set:getLinearLayoutNode("battleing_lineartime")
   self._battleing_lineartime_time = set:getTimeNode("battleing_lineartime_time")
   self._hpShow = set:getElfAction("hpShow")
   self._quake = set:getElfAction("quake")
--   self._@view = set:getElfNode("@view")
--   self._@dmg = set:getLabelNode("@dmg")
end
--@@@@]]]]

--------------------------------override functions----------------------
function BossBattle:onInit( userData, netData )
	
end

function BossBattle:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

local Res = require "Res"
local dbManager = require "DBManager"
local equipFunc = require "EquipInfo"
local appData = require 'AppData'
local TimeManager = require 'TimeManager'
local netModel = require 'netModel'
local eventCenter = require 'EventCenter'
local ActivityType = require "ActivityType"
local TimerHelper = require 'framework.sync.TimerHelper'

--data
local curdbBoss
local netData = {}
local handle2s
local handle10s
local CD = 60
local ActiveSeconds = 15*60
--

--func
local updateNetData
local updateLayer
local updateWait
local updateBattling
local updateBossInfo
local getNames
local getCDSeconds
local getOffsetSeconds
local showDmgs
local getDmgColor
local updateHarms
local startTick
local releaseTick
local startBattle
local getBossData
local checkBossState
local uploadHarm
local getBossIcon
local getBossName
--

local getNetModel = function (AType)
  
  if AType == ActivityType.BossBattle1 then
    curdbBoss = dbManager.getBossAtk(1)
  elseif AType == ActivityType.BossBattle2 then
    curdbBoss = dbManager.getBossAtk(2)
  end
	return netModel.getBossAtkGet(curdbBoss.Id)
  -- self:send(netModel.getBossAtkGet(curdbBoss.Id),function ( data )

  --   netData.BossAtkGet = data.D
  --   -- print(data.D)
  --   onInitSuccess()
  -- end,
  -- function ( ... )
  --   onInitFail()
  -- end)

end

local update = function ( self,view,data ,AType)
  netData.BossAtkGet = data.D
  --updateNetData(self,view)
  updateLayer(self,view)

  view['btnRank']:setListener(function ( ... )
    GleeCore:showLayer('DBossBattleRank',{BossId = curdbBoss.Id,dbinfo = curdbBoss})
  end)

  eventCenter.addEventFunc('SDNBossBattleEnd',function ( data )
    uploadHarm(self,view,data)
  end,'BossBattle')
  
  eventCenter.addEventFunc('CMBossBattleEnd',function ( data )
    uploadHarm(self,view,data)
  end,'BossBattle')

  eventCenter.addEventFunc('BossBattleRefresh',function ( data )
    updateLayer(self,view)
  end,'BossBattle')

  eventCenter.addEventFunc('updateBossInfo',function ( data )
    if netData.BossAtkGet.BossAtk.HpLeft == 0 then
      updateNetData(self,view)
    else
      updateBossInfo(self,view)  
    end
  end,'BossBattle')

  self.activityRemoveHandler = function ( ... )
    releaseTick()
    eventCenter.resetGroup('BossBattle')
  end

end

updateNetData = function ( self,view )
  self:send(netModel.getBossAtkGet(curdbBoss.Id),function ( data )
    -- print(data)
    netData.BossAtkGet = data.D
    updateLayer(self,view)
  end)
end

uploadHarm = function ( self,view,data )
  self:send(netModel.getBossAtkHarm(data.Bid,data.Hp),function ( data )
    if data.D then
      netData.BossAtkGet = data.D
      updateLayer(self,view)
    end
  end)
end

updateLayer = function ( self,view )
  
  view['battleing_lineartime_time']:clearListeners()
  view['wait_lineartime_time']:clearListeners()
  view['time']:clearListeners()

  if netData.BossAtkGet then
    if netData.BossAtkGet.BossAtk.IsOpen then
      updateBattling(self,view)
    else
      updateWait(self,view)
    end
  end

  local icons = 
  {
    [1]='CM_juese2.png',
    [2]='CM_juese1.png'
  }
  local names = 
  {
    [1]='CM_wenzi2.png',
    [2]='CM_wenzi.png'
  }
  view['boss']:setResid(icons[curdbBoss.Id])
  view['bossname']:setResid(names[curdbBoss.Id])
  view['bossnamelv_V']:setString(string.format('%s Lv.%d',curdbBoss.Name,netData.BossAtkGet.BossAtk.Lv))

end

updateWait = function ( self,view )
  
  local lineartime = view['wait_lineartime_time']
  lineartime:clearListeners()
  local offset = getOpenTimeOffset()
  if offset > 0 then
    lineartime:setTimeFormat(Hour99MinuteSecond)
    lineartime:setHourMinuteSecond(0,0,offset)
    lineartime:setUpdateRate(-1)    
    lineartime:addListener(function ( ... )
      updateNetData(self,view)
    end)  
  else
    print('活动时间已到，但没有开启boss战！')
  end

  view['wait_Tip']:setString(string.format(Res.locString('Activity$BossBattleTip'),curdbBoss.Name))
  view['wait_Tip2']:setString(Res.locString((curdbBoss.Id == 1 and 'Activity$BossBattleTip3') or 'Activity$BossBattleTip2'))
  view['wait_linearplayer_names']:setString(getNames(netData.BossAtkGet.LastTops))
  view['wait_linearkiller_names']:setString(getNames(netData.BossAtkGet.LastKill))

  view['wait']:setVisible(true)
  view['battleing']:setVisible(false)
  view['title1']:setVisible(false)
  view['time']:setVisible(false)
end

updateBossInfo = function (self,view)

  local hpleft = netData.BossAtkGet.BossAtk.HpLeft
  local hptotal = netData.BossAtkGet.BossAtk.Hp
  local length = view['battleing_progress_bg']:getContentSize().width*hpleft/hptotal
  view['battleing_progress_fore']:setLength(length)
  view['battleing_progress_V']:setString(string.format('%d/%d',hpleft,hptotal))
  view['battleing_Hp']:setString(string.format('%s%.2f%%',Res.locString('Activity$BossBattleLastHP'),100*hpleft/hptotal))

end

updateBattling = function ( self,view )
  
  local time = view['time']
  time:clearListeners()
  local offset = getOpenTimeOffset()
  local lastsec = ActiveSeconds + offset
  if lastsec > 0 then
    time:setTimeFormat(Hour99MinuteSecond)
    time:setHourMinuteSecond(0,0,lastsec)
    time:setUpdateRate(-1)  
    time:addListener(function ( ... )
      updateNetData(self,view)
    end)
  else
    print('活动已过期，但没有关闭boss战！')
  end

  view['wait']:setVisible(false)
  view['battleing']:setVisible(true)
  view['title1']:setVisible(true)
  view['time']:setVisible(true)

  updateBossInfo(self,view)

  local buff = tonumber(netData.BossAtkGet.Summary.CdBuff)

  local cdseconds = getCDSeconds()
  local lineartime = view['battleing_lineartime_time']
  view['battleing_lineartime']:setVisible(cdseconds > 0)
  lineartime:clearListeners()
  if cdseconds > 0 then
    lineartime:setHourMinuteSecond(0,0,cdseconds)
    lineartime:setUpdateRate(-1)
    lineartime:addListener(function ( ... )
      view['battleing_lineartime']:setVisible(false)
    end)
  end

  view['battleing_linearbuff']:setVisible(buff > 0)
  view['battleing_linearbuff_names']:setString(string.format(Res.locString('Activity$BossBuffAdd'),buff*100))
  
  local gotobattlefunc = function ( ... )
    local para = {}
    para.Boss = getBossData()
    para.Boss.Callback = function ( data )
        startBattle(self,data)
    end
    para.battleBuffer = {[8]=1+buff}
    para.type = (curdbBoss.Id == 2 and 'CMBossBattle') or 'SDNBossBattle'
    GleeCore:showLayer("DPrepareForStageBattle", para)
  end

  local clearCDfunc = function ( cdseconds )
    local clearfunc = function ( ... )
      self:send(netModel.getBossAtkCd(curdbBoss.Id),function ( data )
        if data.D.Summary then
          netData.BossAtkGet.Summary = data.D.Summary
          updateLayer(self,view)
        end
        if data.D.Coin then
          appData.getUserInfo().setCoin(data.D.Coin)
        end
      end)
    end
    local str = string.format(Res.locString('Activity$BossBattleClearCD'),curdbBoss.CdCost)
    GleeCore:showLayer('DConfirmNT',{content=str,callback=clearfunc})  
  end

  view['battleing_btnStart']:setListener(function ( ... )
    local cdseconds = getCDSeconds()
    if cdseconds > 0 then
      clearCDfunc(cdseconds)      
    else
      gotobattlefunc()  
    end
  end)

  view['battleing_btnStart']:setEnabled(not netData.BossAtkGet.BossAtk.Killed)
  
  if not netData.BossAtkGet.BossAtk.Killed then
    startTick(self,view)
  else
    releaseTick()
  end

end

getBossData = function ( ... )

  local Boss = {}
  Boss.Pet = appData.getPetInfo().getPetInfoByPetId(curdbBoss.PetId)
  Boss.Pet.Hp = netData.BossAtkGet.BossAtk.HpLeft
  Boss.Pet.Atk = netData.BossAtkGet.BossAtk.Atk
  Boss.Pet.Def = curdbBoss.Def
  Boss.Pet.AtkSpeed = curdbBoss.AtkSpd
  Boss.Pet.MoveSpeed = curdbBoss.MoveSpd
  Boss.Pet.HpMax = netData.BossAtkGet.BossAtk.Hp
  Boss.Pet.Lv = netData.BossAtkGet.BossAtk.Lv
  Boss.Bid = curdbBoss.Id
  return Boss

end

--进入战斗前获取最新的boss信息
startBattle = function ( self,gamedata )
  self:send(netModel.getBossAtkStart(curdbBoss.Id),function ( data )
    netData.BossAtkGet.BossAtk = data.D.BossAtk
    if checkBossState() then
      local boss = getBossData()
      local bossconv =  appData.getPetInfo().convertToDungeonData(boss.Pet,false)
      gamedata.boss = bossconv
      eventCenter.eventInput("BattleStart", gamedata)
    end
  end)
end

checkBossState =  function ( ... )
  if netData.BossAtkGet.BossAtk.Killed then
    eventCenter.eventInput('BossBattleRefresh')
    self:toast(Res.locString('BossBattle$BossKilled'))
    return false
  end

  return true
end

showDmgs = function (self, view )
  
  local harms = netData.BossAtkGet.Harms
  if harms and type(harms) == 'table' then

    local top = table.clone(harms)
    table.sort(top,function ( v1,v2 )
      return tonumber(v1) > tonumber(v2)
    end)

    local delay = 0
    local quakecnt = 0
    local posx,posy = view['boss']:getPosition()
    for i,v in ipairs(harms) do
      quakecnt = quakecnt + 1
      local quakeneed = v == top[1] or v == top[2] or v == top[3]
      quakeneed = quakeneed and quakecnt <= 3

      delay = delay + i*0.1
      self:runWithDelay(function ( ... )
        local hpnode = view.createLuaSet('@dmg')[1]
        local hpshow = view.createLuaSet('hpShow')[1]
        local quake = view.createLuaSet('quake')[1]
        hpnode:setString(string.format('-%s',tostring(v)))
        hpnode:setFontFillColor(getDmgColor(v),true)
        local size = view['range']:getContentSize()
        local nodesize = hpnode:getContentSize()
        local x = math.random(-(size.width/2-nodesize.width/2),size.width/2-nodesize.width/2)
        local y = math.random(-(size.height/2-nodesize.height/2),size.height/2-nodesize.height/2)
        hpnode:setPosition(ccp(x,y))
        view['range']:addChild(hpnode)
        local action = hpshow:clone()
        action:setListener(function ( ... )
          hpnode:removeFromParentAndCleanup(true)
        end)
        hpnode:runElfAction(action)

        if quakeneed then
          view['boss']:setPosition(ccp(posx,posy))
          view['boss']:runElfAction(quake:clone())
        end  
      end,delay,view[1])
    end

  end

end

--get more dmgs info
updateHarms = function ( self )
  self:send(netModel.getBossAtkGetHarms(curdbBoss.Id),function ( data )
    netData.BossAtkGet.Harms = data.D.List
    --更新血量
    if data.D.HpLeft and data.D.HpLeft ~= netData.BossAtkGet.BossAtk.HpLeft then
      netData.BossAtkGet.BossAtk.HpLeft = data.D.HpLeft
      eventCenter.eventInput('updateBossInfo')
    end

  end)
end

startTick = function ( self,view )
  if handle2s == nil then
    local update2s = function ( ... )
      showDmgs(self,view)
    end
    handle2s = TimerHelper.tick(update2s,3)
    update2s()
  end
  if handle10s == nil then
    local update10s = function ( ... )
      updateHarms(self,view)
    end
    handle10s = TimerHelper.tick(update10s,10)
  end
end

releaseTick = function ( ... )
  if handle2s then
    TimerHelper.cancel(handle2s)
    handle2s = nil
  end  
  if handle10s then
    TimerHelper.cancel(handle10s)
    handle10s = nil
  end
end

getDmgColor = function ( harm )
  
  local v = tonumber(harm)
  if v > 0 and v <= 20000 then
    return ccc4f(0.988235,0.266667,0.121569,1.0)
  elseif v > 20000 and v <= 40000 then
    return ccc4f(0.992157,0.584314,0.152941,1.0)
  elseif v > 40000 then
    return ccc4f(0.984314,0.921569,0.203922,1.0)
  end
  return ccc4f(0.988235,0.266667,0.121569,1.0)

end

getNames = function ( names )

  local str = nil  
  if names and type(names) == 'table' then
    for i,v in ipairs(names) do
      if not str then
        str = v
      else
        str = string.format('%s,%s',str,v)
      end
    end
  end  

  return str or Res.locString('Activity$BossBattleEmpty')

end

--挑战间隔
getCDSeconds = function ( ... )
  if netData.BossAtkGet.Summary.Cd == 0 then
    return 0
  end

  local offset = TimeManager.timeOffset(netData.BossAtkGet.Summary.LastTime)
  local cd = CD - offset
  return (cd > 0 and cd) or 0
end

--当前服务器时间 与活动开启时间点 的间隔
getOpenTimeOffset = function ( ... )
  local offset = TimeManager.timeOffset(netData.BossAtkGet.BossAtk.OpenTime)
  return -offset
end

return {update = update,getNetModel = getNetModel}
