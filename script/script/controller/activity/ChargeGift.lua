local Config = require "Config"

local ChargeGift = class(LuaController)

function ChargeGift:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."ChargeGift.cocos.zip")
    return self._factory:createDocument("ChargeGift.cocos")
end

--@@@@[[[[
function ChargeGift:onInitXML()
    local set = self._set
   self._info = set:getElfNode("info")
   self._info_time = set:getTimeNode("info_time")
   self._info_label = set:getLabelNode("info_label")
   self._range = set:getElfNode("range")
   self._title = set:getElfNode("title")
   self._btnGet = set:getClickNode("btnGet")
   self._btnGet_title = set:getLabelNode("btnGet_title")
   self._gifts = set:getLinearLayoutNode("gifts")
   self._left = set:getElfNode("left")
   self._right = set:getElfNode("right")
   self._pzbg = set:getElfNode("pzbg")
   self._icon = set:getElfNode("icon")
   self._pz = set:getElfNode("pz")
   self._count = set:getLabelNode("count")
   self._isPiece = set:getElfNode("isPiece")
   self._name = set:getLabelNode("name")
   self._btn = set:getButtonNode("btn")
   self._linear = set:getLinearLayoutNode("linear")
   self._linear_V = set:getLabelNode("linear_V")
--   self._@view = set:getElfNode("@view")
--   self._@cell = set:getElfNode("@cell")
end
--@@@@]]]]

--------------------------------override functions----------------------
function ChargeGift:onInit( userData, netData )
	
end

function ChargeGift:onBack( userData, netData )
	
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
local getReward
local refreshGift
local checkRedPoint
--data
local netData

getNetModel = function ()
  return netModel.getOChGet()
end

update = function ( self,view,data )
	netData = data.D
  updateLayer(self,view)
end

updateLayer = function ( self,view )

  local info = appData.getActivityInfo().getDataByType(8)
  print(netData)
  print(info)
  local lastseconds = TimeManager.timeOffset(info.CloseAt)
  view['info_time']:clearListeners()
  if lastseconds < 0 then
    view['info_time']:setHourMinuteSecond(0,0,-lastseconds)
    view['info_time']:setTimeFormat(DayHourMinuteSecond)
    view['info_time']:addListener(function ( ... )
      self:onActivityFinish(self.curShowActivity)
    end)
  else
    print('活动已过期！')
    self:refreshActivityInfo(view,8,function ( data )
      if data then
        updateLayer(self,view)
      else
        checkRedPoint(self)
      end
    end)
  end
  require 'LangAdapter'.fontSize(view['info_label'],nil,nil,20) 
  view['info_label']:setString(string.format(Res.locString('Activity$ChagreGiftTip'),tostring(info.Data.Coin)))
  view['linear_V']:setString(tostring(netData.Coin))
  view['btnGet']:setListener(function ( ... )
    getReward(self,view)
  end)
  view['btnGet']:setEnabled((netData.Got ~= nil and not netData.Got) and netData.Coin >= info.Data.Coin)
  if netData.Got ~= nil and netData.Got then
    self:roleNewsUpdate()
  end

  refreshGift(self,view,info.Data)

  if netData.Got then
    view['btnGet_title']:setString(Res.locString('chargeA$HadGet'))
  end
  
end


refreshGift = function ( self,view,v )

  local reslist = Res.getRewardsNRList(v.Reward)
  if reslist then
    view['gifts']:removeAllChildrenWithCleanup(true)
    for i,v in ipairs(reslist) do
      local cellSet = view.createLuaSet('@cell')
      cellSet['icon']:setResid(v.resid[2])
      cellSet['pz']:setResid(v.resid[3])
      cellSet['pzbg']:setResid(v.resid[1])
      cellSet['name']:setString(v.name)
      cellSet['count']:setString(string.format('x%s',tostring(v.amount)))
      cellSet['isPiece']:setVisible(v.isPiece)
      local color = Res.rankColor4F[v.pzindex or 1]
      cellSet['name']:setFontFillColor(color,true)
      require 'LangAdapter'.LabelNodeAutoShrink(cellSet['name'],100)
      cellSet['left']:setVisible(i == 1)
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

      view['gifts']:addChild(cellSet[1])

      require 'LangAdapter'.selectLangkv({German=function ( ... )
        cellSet['name']:setVisible(false)
      end})
    end
  end
end

checkRedPoint = function ( self )
  self:roleNewsUpdate()
end

local activityEnd = function ( self )
  appData.getActivityInfo().activityEnd(8)
  self:onActivityFinish(require 'ActivityType'.ChargeGift)
  -- GleeCore:popController(nil,Res.getTransitionFade())
end

--net
getReward = function ( self,view )
  self:send(netModel.getOChReward(),function ( data )
    netData.Got = true
    -- local reslist = Res.getRewardsNRList(data.D.Reward)
    -- local msg = '成功领取:'
    -- for i,v in ipairs(reslist) do
    --   msg = string.format('%s %sx%s',msg,v.name,tostring(v.amount))
    -- end
    -- self:toast(msg)
    -- print(data)
    if data.D.Reward then
      GleeCore:showLayer('DGetReward',data.D.Reward)
    end

    appData.updateResource(data.D.Resource)
    updateLayer(self,view)
    checkRedPoint(self)
    activityEnd(self)
  end)
end

return {update=update,getNetModel=getNetModel}
