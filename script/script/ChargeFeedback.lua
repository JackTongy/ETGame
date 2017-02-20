local Config = require "Config"

local ChargeFeedback = class(LuaDialog)

function ChargeFeedback:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."ChargeFeedback.cocos.zip")
    return self._factory:createDocument("ChargeFeedback.cocos")
end

--@@@@[[[[
function ChargeFeedback:onInitXML()
    local set = self._set
   self._bg = set:getElfNode("bg")
   self._btnGet = set:getClickNode("btnGet")
   self._btnGet_title = set:getLabelNode("btnGet_title")
   self._linearlayout_richlabel = set:getRichLabelNode("linearlayout_richlabel")
   self._linearlayout_time = set:getElfNode("linearlayout_time")
   self._linearlayout_time_linear = set:getLinearLayoutNode("linearlayout_time_linear")
   self._linearlayout_time_linear_v = set:getTimeNode("linearlayout_time_linear_v")
   self._p = set:getLabelNode("p")
--   self._@view = set:getElfNode("@view")
end
--@@@@]]]]

--------------------------------override functions----------------------

function ChargeFeedback:onInit( userData, netData )
	
end

function ChargeFeedback:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------

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

update = function ( self,view,data )
  updateLayer(self,view)
end

updateLayer = function ( self,view )
  
  view['linearlayout_richlabel']:setString(Res.locString('Activity$ChargeFeedbackT'))

  local info = appData.getActivityInfo().getDataByType(40)
  local cdseconds = TimeManager.timeOffset(info.CloseAt)
  if cdseconds < 0 then
    view['linearlayout_time_linear_v']:setHourMinuteSecond(0,0,-cdseconds)
    view['linearlayout_time_linear_v']:setUpdateRate(-1)
    view['linearlayout_time_linear_v']:setTimeFormat(DayHourMinuteSecond)
    view['linearlayout_time_linear_v']:addListener(function ( ... )
      self:onActivityFinish(require 'ActivityType'.ChargeFeedback)  
    end)
  else
    self:onActivityFinish(require 'ActivityType'.ChargeFeedback)
    return
  end

  view['btnGet']:setListener(function ( ... )
    GleeCore:showLayer('DRecharge',{ShowIndex = 1})
    self:close()
  end)

  if info and info.Data and type(info.Data) == 'number' then
    view['p']:setString(string.format('%d%%',info.Data*100))
  end
end

return {update=update}
