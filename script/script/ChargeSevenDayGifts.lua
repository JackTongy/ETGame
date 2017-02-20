local Config = require "Config"

local ChargeSevenDayGifts = class(LuaDialog)

function ChargeSevenDayGifts:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."ChargeSevenDayGifts.cocos.zip")
    return self._factory:createDocument("ChargeSevenDayGifts.cocos")
end

--@@@@[[[[
function ChargeSevenDayGifts:onInitXML()
    local set = self._set
   self._bg = set:getElfNode("bg")
   self._btnGet = set:getClickNode("btnGet")
   self._btnGet_title = set:getLabelNode("btnGet_title")
   self._gifts = set:getLinearLayoutNode("gifts")
   self._pzbg = set:getElfNode("pzbg")
   self._icon = set:getElfNode("icon")
   self._isPiece = set:getElfNode("isPiece")
   self._pz = set:getElfNode("pz")
   self._count = set:getLabelNode("count")
   self._btn = set:getButtonNode("btn")
   self._title = set:getLabelNode("title")
   self._linearlayout_time = set:getElfNode("linearlayout_time")
   self._linearlayout_time_linear = set:getLinearLayoutNode("linearlayout_time_linear")
   self._linearlayout_time_linear_v = set:getTimeNode("linearlayout_time_linear_v")
   self._tabs = set:getElfNode("tabs")
   self._tabs_tab1 = set:getTabNode("tabs_tab1")
   self._tabs_tab1_normal_flag = set:getElfNode("tabs_tab1_normal_flag")
   self._tabs_tab1_pressed_flag = set:getElfNode("tabs_tab1_pressed_flag")
   self._tabs_tab1_arrow = set:getElfNode("tabs_tab1_arrow")
   self._tabs_tab2 = set:getTabNode("tabs_tab2")
   self._tabs_tab2_normal_flag = set:getElfNode("tabs_tab2_normal_flag")
   self._tabs_tab2_pressed_flag = set:getElfNode("tabs_tab2_pressed_flag")
   self._tabs_tab2_arrow = set:getElfNode("tabs_tab2_arrow")
   self._tabs_tab3 = set:getTabNode("tabs_tab3")
   self._tabs_tab3_normal_flag = set:getElfNode("tabs_tab3_normal_flag")
   self._tabs_tab3_pressed_flag = set:getElfNode("tabs_tab3_pressed_flag")
   self._tabs_tab3_arrow = set:getElfNode("tabs_tab3_arrow")
   self._tabs_tab4 = set:getTabNode("tabs_tab4")
   self._tabs_tab4_normal_flag = set:getElfNode("tabs_tab4_normal_flag")
   self._tabs_tab4_pressed_flag = set:getElfNode("tabs_tab4_pressed_flag")
   self._tabs_tab4_arrow = set:getElfNode("tabs_tab4_arrow")
   self._tabs_tab5 = set:getTabNode("tabs_tab5")
   self._tabs_tab5_normal_flag = set:getElfNode("tabs_tab5_normal_flag")
   self._tabs_tab5_pressed_flag = set:getElfNode("tabs_tab5_pressed_flag")
   self._tabs_tab5_arrow = set:getElfNode("tabs_tab5_arrow")
   self._tabs_tab6 = set:getTabNode("tabs_tab6")
   self._tabs_tab6_normal_flag = set:getElfNode("tabs_tab6_normal_flag")
   self._tabs_tab6_pressed_flag = set:getElfNode("tabs_tab6_pressed_flag")
   self._tabs_tab6_arrow = set:getElfNode("tabs_tab6_arrow")
   self._tabs_tab7 = set:getTabNode("tabs_tab7")
   self._tabs_tab7_normal_flag = set:getElfNode("tabs_tab7_normal_flag")
   self._tabs_tab7_pressed_flag = set:getElfNode("tabs_tab7_pressed_flag")
   self._tabs_tab7_arrow = set:getElfNode("tabs_tab7_arrow")
--   self._@view = set:getElfNode("@view")
--   self._@cell = set:getElfNode("@cell")
end
--@@@@]]]]

--------------------------------override functions----------------------

function ChargeSevenDayGifts:onInit( userData, netData )
	
end

function ChargeSevenDayGifts:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


local Res = require "Res"
local dbManager = require "DBManager"
local equipFunc = require "EquipInfo"
local appData = require 'AppData'
local TimeManager = require 'TimeManager'
local netModel = require 'netModel'
local eventCenter = require 'EventCenter'

local getNetModel
local update
local updateLayer
local updateList
local getReward
local checkRedPoint
local selectTab
--
local netData
local info

getNetModel = function (  )
  return netModel.getModelSevenDaysRewardGet()
end

update = function ( self,view,data )
  netData = data.D -- .Rds List<int> 领取记录，1：未领取，2 可领取 3：已领取
  for i=1,7 do
    view[string.format('tabs_tab%d',i)]:setListener(function ( ... )
       selectTab(self,view,i)
    end)   
  end

  updateLayer(self,view)

end

updateLayer = function ( self,view )
   
   info = appData.getActivityInfo().getDataByType(41)
   -- info.CloseAt = '2015-11-6 00:00:00'
   local cdseconds = TimeManager.timeOffset(info.CloseAt)
   -- print('ChargeSevenDayGifts:')
   -- print(info)
   -- print(cdseconds)
   view['linearlayout_time_linear_v']:clearListeners()
   if cdseconds < 0 then
      view['linearlayout_time_linear_v']:setHourMinuteSecond(0,0,-cdseconds)
      view['linearlayout_time_linear_v']:setUpdateRate(-1)
      view['linearlayout_time_linear_v']:setTimeFormat(DayHourMinuteSecond)
      view['linearlayout_time_linear_v']:addListener(function ( ... )
         self:onActivityFinish(require 'ActivityType'.ChargeSevenDayGifts)  
      end)
   else
      self:onActivityFinish(require 'ActivityType'.ChargeSevenDayGifts)
    return
  end

  local defaultTabIndex = 0
  for i,v in ipairs(netData.Rds) do    
    view[string.format('tabs_tab%d_normal_flag',i)]:setVisible(v ~= 3)
    view[string.format('tabs_tab%d_pressed_flag',i)]:setVisible(v ~= 3)
    view[string.format('tabs_tab%d_arrow',i)]:setVisible(i == tonumber(netData.Day or 0))
    if i == tonumber(netData.Day or 0) then
      defaultTabIndex = i
    end
  end
  defaultTabIndex = defaultTabIndex ~= 0 and defaultTabIndex or 1

  view[string.format('tabs_tab%d',defaultTabIndex)]:trigger(nil)
end

selectTab = function ( self,view, N)
  view['btnGet']:setListener(function ( ... )
    getReward(self,view,N)
  end)

  view['btnGet']:setEnabled(netData.Rds[N] ~= 3)
  if netData.Rds[N] == 3 then
    view['btnGet_title']:setString(Res.locString('DRechargeFT$hadGotReward'))
  elseif netData.Rds[N] == 2 then
    view['btnGet_title']:setString(Res.locString('DRechargeFT$getReward'))
  elseif netData.Rds[N] == 1 then
    view['btnGet_title']:setString(Res.locString('Activity$V6NoticeBtnLabel'))
    view['btnGet']:setListener(function ( ... )
      GleeCore:showLayer('DRecharge',{ShowIndex = 1})
      self:close()
    end)
  end
  
  updateList(self,view,info.Data[N])
end

updateList = function ( self,view,Reward )
  local reslist = Res.getRewardsNRList(Reward)
  if reslist then
    view['gifts']:removeAllChildrenWithCleanup(true)
    for i,v in ipairs(reslist) do
      local cellSet = view.createLuaSet('@cell')
      cellSet['icon']:setResid(v.resid[2])
      cellSet['pz']:setResid(v.resid[3])
      cellSet['pzbg']:setResid(v.resid[1])
      cellSet['isPiece']:setVisible(v.isPiece)
      -- cellSet['name']:setString(v.name)
      -- cellSet['name']:setFontFillColor(color,true)
      cellSet['count']:setString(string.format('x%s',tostring(v.amount)))
      local color = Res.rankColor4F[v.pzindex or 1]
      if cellSet['btn'] and v.showfunc then
        cellSet['btn']:setListener(v.showfunc)
      end
      local scale = 0.61
      if v.resid[2] and v.resid[3] then
        local pzsize = cellSet['pz']:getContentSize()
        local iconsize = cellSet['icon']:getContentSize()
        cellSet['icon']:setScaleX(135/iconsize.width*scale)
        cellSet['icon']:setScaleY(135/iconsize.height*scale)
      else
        cellSet['icon']:setScale(scale)
      end
      if v.showfunc and cellSet['btn'] then
         cellSet['btn']:setListener(v.showfunc)
      end

      view['gifts']:addChild(cellSet[1])
    end
  end

end

getReward = function ( self,view,N )
  self:send(netModel.getModelSevenDaysRewardReceive(N),function ( data )
    if data and data.D then
      appData.updateResource(data.D.Resource)
      netData.Rds[N] = 3
      view[string.format('tabs_tab%d',N)]:trigger(nil)
      local callback = function ( ... )
        updateLayer(self,view)
        self:roleNewsUpdate()
        -- checkRedPoint()
      end
      if data.D.Reward then
        data.D.Reward.callback = callback 
        GleeCore:showLayer('DGetReward',data.D.Reward)
      else
        callback()
      end
    end
  end)
end

return {getNetModel=getNetModel,update=update}

