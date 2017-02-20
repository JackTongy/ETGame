local Config = require "Config"

local ChargeCost = class(LuaController)

function ChargeCost:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."ChargeCost.cocos.zip")
    return self._factory:createDocument("ChargeCost.cocos")
end

--@@@@[[[[
function ChargeCost:onInitXML()
    local set = self._set
   self._list = set:getListNode("list")
   self._bg = set:getElfNode("bg")
   self._gifts = set:getLinearLayoutNode("gifts")
   self._left = set:getElfNode("left")
   self._right = set:getElfNode("right")
   self._pzbg = set:getElfNode("pzbg")
   self._icon = set:getElfNode("icon")
   self._piece = set:getElfNode("piece")
   self._pz = set:getElfNode("pz")
   self._count = set:getLabelNode("count")
   self._name = set:getLabelNode("name")
   self._btn = set:getButtonNode("btn")
   self._btnGet = set:getClickNode("btnGet")
   self._btnGet_title = set:getLabelNode("btnGet_title")
   self._cnt = set:getLinearLayoutNode("cnt")
   self._cnt_V = set:getLabelNode("cnt_V")
   self._title1 = set:getLinearLayoutNode("title1")
   self._title1_V = set:getLabelNode("title1_V")
   self._title2 = set:getLinearLayoutNode("title2")
   self._title2_head = set:getLabelNode("title2_head")
   self._title2_time = set:getTimeNode("title2_time")
--   self._@view = set:getElfNode("@view")
--   self._@item = set:getElfNode("@item")
--   self._@cell = set:getElfNode("@cell")
--   self._@empty = set:getElfNode("@empty")
end
--@@@@]]]]

--------------------------------override functions----------------------
function ChargeCost:onInit( userData, netData )
	
end

function ChargeCost:onBack( userData, netData )
	
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
local updateList
local refreshDayCell
local hadGet
local getReward
local checkRedPoint
--data
local netData

getNetModel = function()
 	return netModel.getTCsGet()
end

update = function ( self,view,data)
  netData = data.D
    updateLayer(self,view)
end

updateLayer = function ( self,view )

  local info = appData.getActivityInfo().getDataByType(6)
  
  local lastseconds = TimeManager.timeOffset(info.CloseAt)
  view['title2_time']:clearListeners()
  if lastseconds < 0 then
    view['title2_time']:setHourMinuteSecond(0,0,-lastseconds)
    view['title2_time']:setTimeFormat(DayHourMinuteSecond)
    view['title2_time']:addListener(function ( ... )
      self:onActivityFinish(self.curShowActivity)
    end)
  else
    print('活动已过期！')
    self:refreshActivityInfo(view,6,function ( data )
      if data then
        updateLayer(self,view)
      else
        checkRedPoint(self)
      end
    end)
  end

  view['title1_V']:setString(tostring(netData.Coin))
  updateList(self,view,info)
end

updateList = function ( self,view,info )
  view['list']:getContainer():removeAllChildrenWithCleanup(true)

  local foucs = 0
  if info.Data then
    for i,v in ipairs(info.Data) do
      local hadget = hadGet(i)
      
      local itemset = view.createLuaSet('@item')
      refreshDayCell(self,itemset,v,i,view,hadget)
      view['list']:getContainer():addChild(itemset[1])    
      if hadget then
        foucs = i
      end
    end
  end

  view['list']:layout()
  view['list']:alignTo(foucs)

end

refreshDayCell = function (self, set, v,i,view,hadget)
  if hadget then
    set['btnGet_title']:setString(Res.locString('chargeA$HadGet'))
  end
  set['cnt_V']:setString(tostring(v.Coin))  
  set['btnGet']:setEnabled(netData.Coin >= v.Coin and not hadget)
  require 'LangAdapter'.LabelNodeAutoShrink(set['btnGet_title'],75)
  set['btnGet']:setListener(function ( ... )
      getReward(self,i,view)
  end)

  local reslist = Res.getRewardsNRList(v.Reward)
  local emptycnt = 4
  if reslist then
    set['gifts']:removeAllChildrenWithCleanup(true)
    for i,v in ipairs(reslist) do
      local cellSet = view.createLuaSet('@cell')
      cellSet['icon']:setResid(v.resid[2])
      cellSet['pz']:setResid(v.resid[3])
      cellSet['pzbg']:setResid(v.resid[1])
      cellSet['name']:setString(v.name)
      cellSet['count']:setString(string.format('x%s',tostring(v.amount)))
      -- local color = Res.rankColor4F[v.pzindex]
      -- cellSet['name']:setFontFillColor(color,true)
      cellSet['left']:setVisible(i == 1)
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

      set['gifts']:addChild(cellSet[1])
      emptycnt = emptycnt - 1

      require 'LangAdapter'.LabelNodeAutoShrink(cellSet['name'],90)

      require 'LangAdapter'.selectLangkv({German=function ( ... )
        cellSet['name']:setVisible(false)
      end})

    end
  end
  for i=1,emptycnt do
    local emptyset = view.createLuaSet('@empty')
    set['gifts']:addChild(emptyset[1])
  end
end

hadGet = function ( Day )
  if netData.Gots then
    for i,v in ipairs(netData.Gots) do
      if tonumber(Day) == v then
        return true
      end    
    end
  end
  
  return false
end

checkRedPoint = function ( self )
  local info = appData.getActivityInfo().getDataByType(6)
  if info.Data then
    for i,v in ipairs(info.Data) do
      local hadget = hadGet(i)
      if netData.Coin >= v.Coin and not hadget then
        return
      end
    end 
  end
  self:roleNewsUpdate()  

  if info.Data then
    for i,v in ipairs(info.Data) do
      local hadget = hadGet(i)
      if not hadget then
        return
      end
    end
  end
  appData.getActivityInfo().activityEnd(6)
  self:onActivityFinish(require 'ActivityType'.ChargeCost)
  -- GleeCore:popController(nil,Res.getTransitionFade())
end

--net
getReward = function ( self,N,view )
  self:send(netModel.getTCsReward(N),function ( data )
    if data.D then
      if netData.Gots  == nil then
        netData.Gots = {}
      end
      table.insert(netData.Gots,N)

      local callback = function ( ... )
        appData.updateResource(data.D.Resource)
        updateLayer(self,view)
        checkRedPoint(self)        
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
