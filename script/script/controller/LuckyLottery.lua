local Config = require "Config"

local LuckyLottery = class(LuaDialog)

function LuckyLottery:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."LuckyLottery.cocos.zip")
    return self._factory:createDocument("LuckyLottery.cocos")
end

--@@@@[[[[
function LuckyLottery:onInitXML()
    local set = self._set
   self._title1 = set:getLinearLayoutNode("title1")
   self._title1_V = set:getLabelNode("title1_V")
   self._title2 = set:getLinearLayoutNode("title2")
   self._title2_head = set:getLabelNode("title2_head")
   self._title2_time = set:getTimeNode("title2_time")
   self._tabs = set:getLayout2DNode("tabs")
   self._tabs_tab1 = set:getTabNode("tabs_tab1")
   self._tabs_tab1_pressed_pet = set:getElfNode("tabs_tab1_pressed_pet")
   self._tabs_tab1_point = set:getElfNode("tabs_tab1_point")
   self._tabs_tab2 = set:getTabNode("tabs_tab2")
   self._tabs_tab2_pressed_pet = set:getElfNode("tabs_tab2_pressed_pet")
   self._tabs_tab2_point = set:getElfNode("tabs_tab2_point")
   self._tabs_tab3 = set:getTabNode("tabs_tab3")
   self._tabs_tab3_pressed_pet = set:getElfNode("tabs_tab3_pressed_pet")
   self._tabs_tab3_point = set:getElfNode("tabs_tab3_point")
   self._content = set:getElfNode("content")
   self._content_bg = set:getElfNode("content_bg")
   self._content_anim = set:getSimpleAnimateNode("content_anim")
   self._content_layout = set:getLayout2DNode("content_layout")
   self._pzbg = set:getElfNode("pzbg")
   self._icon = set:getElfNode("icon")
   self._piece = set:getElfNode("piece")
   self._pz = set:getElfNode("pz")
   self._count = set:getLabelNode("count")
   self._btn = set:getButtonNode("btn")
   self._btnGet = set:getClickNode("btnGet")
   self._btnGet_title = set:getLabelNode("btnGet_title")
   self._title3 = set:getLinearLayoutNode("title3")
   self._title3_head = set:getLabelNode("title3_head")
   self._title3_v = set:getLabelNode("title3_v")
   self._title3_tail = set:getLabelNode("title3_tail")
--   self._@view = set:getElfNode("@view")
--   self._@cell = set:getElfNode("@cell")
end
--@@@@]]]]

--------------------------------override functions----------------------

function LuckyLottery:onInit( userData, netData )
	
end

function LuckyLottery:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

local Res = require "Res"
local dbManager = require "DBManager"
local equipFunc = require "EquipInfo"
local appData = require 'AppData'
local TimeManager = require 'TimeManager'
local netModel = require 'netModel'
local eventCenter = require 'EventCenter'


--func
local getNetModel
local update
local updateLayer
local updateContent
local getReward
local runAnim

--data
local netData
local curselect

getNetModel = function ()
  return netModel.getModelLuckyLotteryGet()
end

update = function ( self,view,data )
  netData = data.D
  print('netData:')
  print(netData)
  --[[
  Coin
  Lottery{BronzesState,SilverState,GoldState} --1 不能领取 2 可领取 3 已领取
  ]]
  curselect = nil
  runAnim(self,view,false)
  updateLayer(self,view)

end

updateLayer = function ( self,view )
  local info = appData.getActivityInfo().getDataByType(34)
  print('info:')
  print(info)
  if info and info.Data then
    view['tabs_tab1']:setListener(function ( ... )
      updateContent(self,view,info.Data.Bronzes,1,'BronzesState')
      curselect = view['tabs_tab1']
    end)
    view['tabs_tab2']:setListener(function ( ... )
      updateContent(self,view,info.Data.Silvers,2,'SilverState')
      curselect = view['tabs_tab2']
    end)
    view['tabs_tab3']:setListener(function ( ... )
      updateContent(self,view,info.Data.Golds,3,'GoldState')
      curselect = view['tabs_tab3']
    end)

    local cdseconds = TimeManager.timeOffset(info.CloseAt)
    if cdseconds < 0 then
      view['title2_time']:setHourMinuteSecond(0,0,-cdseconds)
      view['title2_time']:setUpdateRate(-1)
      view['title2_time']:setTimeFormat(DayHourMinuteSecond)
      view['title2_time']:addListener(function ( ... )
        self:onActivityFinish(require 'ActivityType'.LuckyLottery)  
      end)
    else
      self:onActivityFinish(require 'ActivityType'.LuckyLottery)
      return
    end
    curselect = curselect or view['tabs_tab1']
    curselect:trigger(nil)
  end

  view['title1_V']:setString(tostring(netData.Coin))
  view['tabs_tab1_point']:setVisible(netData.Lottery.BronzesState == 2)
  view['tabs_tab2_point']:setVisible(netData.Lottery.SilverState == 2)
  view['tabs_tab3_point']:setVisible(netData.Lottery.GoldState == 2)

  if netData.Lottery.BronzesState ~= 2 and netData.Lottery.SilverState ~= 2 and netData.Lottery.GoldState ~= 2 then
    self:roleNewsUpdate()
  end
end

updateContent = function ( self,view ,rewards,N,key)
  view['content_layout']:removeAllChildrenWithCleanup(true)
  for i,v in ipairs(rewards) do
    -----------
    if i > 8 then
      break
    end
    -----------
    local reward = v.Reward
    local reslist = Res.getRewardsNRList(reward)
    if reslist then
      for i,v in ipairs(reslist) do
        local cellSet = view.createLuaSet('@cell')
        cellSet['icon']:setResid(v.resid[2])
        cellSet['pz']:setResid(v.resid[3])
        cellSet['pzbg']:setResid(v.resid[1])
        cellSet['count']:setString(string.format('x%s',tostring(v.amount)))
        cellSet['piece']:setVisible(v.isPiece)

        if cellSet['btn'] and v.showfunc then
          cellSet['btn']:setListener(v.showfunc)
        end
        local scale = 0.58
        if v.resid[2] and v.resid[3] then
          local pzsize = cellSet['pz']:getContentSize()
          local iconsize = cellSet['icon']:getContentSize()
          cellSet['icon']:setScaleX(135/iconsize.width*scale)
          cellSet['icon']:setScaleY(135/iconsize.height*scale)
        else
          cellSet['icon']:setScale(scale)
        end
        view['content_layout']:addChild(cellSet[1])
      end
    end    
  end

  local state = netData.Lottery[key]
  view['btnGet']:setEnabled(true)
  if state == 2 then
    view['btnGet']:setListener(function ( ... )
      getReward(self,view,N,key)
    end)
    view['btnGet_title']:setString(Res.locString('Activity$LuckyLotterybtn'))
  elseif state == 1 then
    view['btnGet']:setListener(function ( ... )
      GleeCore:showLayer('DRecharge',{ShowIndex = 1})
      self:close()
    end)
    view['btnGet_title']:setString(Res.locString('Activity$V6NoticeBtnLabel'))
  elseif state == 3 then
    view['btnGet']:setEnabled(false)
    view['btnGet_title']:setString(Res.locString('Global$ReceiveFinish'))
  end

  local db = dbManager.getInfoDefaultConfig(string.format('LuckDeposit%d',N))
  local name = Res.locString(string.format('Activity$LuckyLotteryLName%d',N))
  view['title3_v']:setString(string.format('%s%s',tostring(db.Value),Res.locString('Global$Coin')))
  view['title3_tail']:setString(string.format(Res.locString('Activity$LuckyLotteryT3tail'),name))
end

getReward = function ( self,view,N,key )
  
  local netcallback = function ( data )

    runAnim(self,view,false)
    if data.D then
      netData.Lottery[key]=3

      local callback = function ( ... )
        updateLayer(self,view)  
      end

      if data.D.Reward then
        data.D.Reward.callback = callback
        GleeCore:showLayer('DGetReward',data.D.Reward,'LuckyLottery')
      else
        callback()
      end
      
      if data.D.Resource then
        appData.updateResource(data.D.Resource)
      end
    end
  end

  runAnim(self,view,true)

  self:runWithDelay(function ( ... )
    self:send(netModel.getModelLuckyLotteryReceive(N),netcallback)  
  end,1)
  
end

runAnim = function ( self,view,show )
  view['content_bg']:setVisible(not show)
  view['content_anim']:setVisible(show)
end

return {getNetModel=getNetModel,update=update}
