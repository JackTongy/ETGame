local Config = require "Config"

local MonDayGift = class(LuaDialog)

function MonDayGift:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."MonDayGift.cocos.zip")
    return self._factory:createDocument("MonDayGift.cocos")
end

--@@@@[[[[
function MonDayGift:onInitXML()
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
   self._date = set:getLabelNode("date")
--   self._@view = set:getElfNode("@view")
--   self._@cell = set:getElfNode("@cell")
end
--@@@@]]]]

--------------------------------override functions----------------------

function MonDayGift:onInit( userData, netData )
	
end

function MonDayGift:onBack( userData, netData )
	
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
local getDateFormat

--
local netData

getNetModel = function ( ... )
  return netModel.getModelMondayGiftGet()
end

update = function ( self,view,data )
  netData = data.D
  print('netData:')
  print(netData)
  updateLayer(self,view)
end

updateLayer = function ( self,view )

  local from = getDateFormat(netData.Data.FromTime)
  -- local to   = getDateFormat(netData.Data.EndTime)
  view['date']:setString(string.format('%s',from))
  --state -1:时间不符 0:可领取 1:已领取
  view['btnGet']:setEnabled(netData.State==0)
  view['btnGet_title']:setString((netData.State==0 or netData.State==-1) and Res.locString('CTask$Receive') or Res.locString('chargeA$HadGet'))
  view['btnGet']:setListener(function ( ... )
    getReward(self,view)
  end)
  updateList(self,view,netData.Data.Reward)
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

getReward = function ( self,view )
  self:send(netModel.getModelMondayGiftReward(),function ( data )
    if data and data.D then
      appData.updateResource(data.D.Resource)
      netData.State = 1
      local callback = function ( ... )
        updateLayer(self,view)
        self:roleNewsUpdate()
        checkRedPoint()
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

checkRedPoint = function ( ... )
  if netData and netData.State == 1 then
    appData.getActivityInfo().activityEnd(21)
    -- self:onActivityFinish(require 'ActivityType'.MonDayGift)
  end
end

getDateFormat = function ( utcdate )
  local timestamp = TimeManager.getTimestamp(utcdate)
  local ldt = os.date('*t',timestamp)
  local ret = require 'LangAdapter'.selectLangkv({German=function ( ... )
      return string.format(Res.locString('Activity$DateFormat'),ldt.day,ldt.month)
  end})

  return ret or string.format(Res.locString('Activity$DateFormat'),ldt.month,ldt.day)
end

return {getNetModel=getNetModel,update=update}
