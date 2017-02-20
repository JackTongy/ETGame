local Config = require "Config"
local Res = require "Res"
local DBManager = require "DBManager"
local AppData = require 'AppData'
local netModel = require 'netModel'
local TimeManager = require 'TimeManager'
local loginGift = class(LuaDialog)

function loginGift:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."loginGift.cocos.zip")
    return self._factory:createDocument("loginGift.cocos")
end

--@@@@[[[[
function loginGift:onInitXML()
	local set = self._set
    self._bg_btnGet = set:getClickNode("bg_btnGet")
    self._bg_btnGet_title = set:getLabelNode("bg_btnGet_title")
    self._bg_gift = set:getElfNode("bg_gift")
    self._bg_gift_layout = set:getLinearLayoutNode("bg_gift_layout")
    self._normal_content = set:getElfNode("normal_content")
    self._normal_content_pzbg = set:getElfNode("normal_content_pzbg")
    self._normal_content_icon = set:getElfNode("normal_content_icon")
    self._normal_content_pz = set:getElfNode("normal_content_pz")
    self._normal_content_piece = set:getElfNode("normal_content_piece")
    self._normal_count = set:getLabelNode("normal_count")
    self._normal_isSuit = set:getSimpleAnimateNode("normal_isSuit")
    self._normal_starLayout = set:getLayoutNode("normal_starLayout")
    self._bg_detail = set:getColorClickNode("bg_detail")
    self._bg_date = set:getLabelNode("bg_date")
--    self._@view = set:getElfNode("@view")
--    self._@gitem = set:getColorClickNode("@gitem")
--    self._@starss = set:getElfNode("@starss")
end
--@@@@]]]]

--------------------------------override functions----------------------
function loginGift:onInit( userData, netData )
	
end

function loginGift:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

local updateList = function (self, view, Reward)
  local reslist = Res.getRewardsNRList(Reward)
  if reslist then
    view['bg_gift_layout']:removeAllChildrenWithCleanup(true)
    for i, v in ipairs(reslist) do
      local cellSet = view.createLuaSet('@gitem')
      cellSet['normal_content_icon']:setResid(v.resid[2])
      cellSet['normal_content_pz']:setResid(v.resid[3])
      cellSet['normal_content_pzbg']:setResid(v.resid[1])
      -- cellSet['name']:setString(v.name)
      -- cellSet['name']:setFontFillColor(color,true)
      cellSet['normal_count']:setString(string.format('x%s',tostring(v.amount)))
      local color = Res.rankColor4F[v.pzindex or 1]
      if cellSet[1] and v.showfunc then
        cellSet[1]:setListener(v.showfunc)
      else
        cellSet[1]:setEnabled(false)
      end

      -- local scale = 0.61
      -- if v.resid[2] and v.resid[3] then
      --   local pzsize = cellSet['normal_content_pz']:getContentSize()
      --   local iconsize = cellSet['normal_content_icon']:getContentSize()
      --   cellSet['normal_content_icon']:setScaleX(135/iconsize.width*scale)
      --   cellSet['normal_content_icon']:setScaleY(135/iconsize.height*scale)
      -- else
      --   cellSet['normal_content_icon']:setScale(scale)
      -- end
      if v.typename == 'PetPiece' then
        cellSet['normal_content_icon']:setScale(1.5)
        cellSet['normal_content_piece']:setVisible(true)
        --cellSet['normal_starLayout']:setVisible(true)
        --require 'PetNodeHelper'.updateStarLayout(cellSet['normal_starLayout'], DBManager.getCharactor(v.orgdata.PetId))
      end
      if v.typename == 'Pet' then
        cellSet['normal_content_icon']:setScale(1.5)
        --cellSet['normal_starLayout']:setVisible(true)
        --require 'PetNodeHelper'.updateStarLayout(cellSet['normal_starLayout'], DBManager.getCharactor(v.orgdata.PetId))
      end

      view['bg_gift_layout']:addChild(cellSet[1])
    end
  end
end

local getFormatTime = function(dateTime)
  -- local temp = string.sub(dateTime, 1, 10)
  -- local strTable = {}
  -- for subStr in string.gmatch(temp, '([^-]+)') do
  --   table.insert(strTable, subStr)
  -- end

  -- if #strTable >= 3 then
  --   return string.format(Res.locString('Global$Date'), tonumber(strTable[2]), tonumber(strTable[3]))
  -- else
  --   return 'dateTime format error!'
  -- end

  local timestamp = TimeManager.getTimestamp(dateTime)
  local ldt = os.date('*t',timestamp)
  local ret = string.format(Res.locString('Global$Date'), ldt.month, ldt.day)
  require 'LangAdapter'.selectLangkv({German=function ( ... )
    ret = string.format(Res.locString('Global$Date'), ldt.day, ldt.month)
  end})

  return ret

  
end

local checkRedPoint = function ( self )
  self:roleNewsUpdate()
  --AppData.getActivityInfo().activityEnd(22)
  --self:onActivityFinish(require 'ActivityType'.loginGift)
end

local function updateLayer(self, view, data)
  local info = AppData.getActivityInfo().getDataByType(22)
  local start = getFormatTime(info.OpenAt)
  local endt = getFormatTime(info.CloseAt)
  local dateTime = string.format('%s - %s', start, endt)
  view['bg_date']:setString(dateTime)

    if data.IsGot then
        view['bg_btnGet_title']:setString(Res.locString('DRechargeFT$hadGotReward'))
        view['bg_btnGet']:setEnabled(false)
    else
        view['bg_btnGet_title']:setString(Res.locString('Global$Receive'))
        view['bg_btnGet']:setEnabled(true)
        view['bg_btnGet']:setListener(function()
            self:send(netModel.getModelLoginGiftReward(), function(netdata)
                if netdata and netdata.D then
                    if netdata.D.Resource then
                        AppData.updateResource(netdata.D.Resource)
                    end
                    -- if netdata.D.Pray then
                    --     updateLayer(self, view, data.D.Pray)
                    -- end
                    Res.doActionGetReward(netdata.D.Reward)

                    view['bg_btnGet_title']:setString(Res.locString('DRechargeFT$hadGotReward'))
                    view['bg_btnGet']:setEnabled(false)
                    checkRedPoint(self)
                end
            end)
        end)
    end
    updateList(self, view, data.Reward)

    view['bg_detail']:setListener(function()
        GleeCore:showLayer("DLGDetail", {dateTime = dateTime, info = info})
    end)
end

local update = function (self, view, data)
    if data and data.D then
        updateLayer(self, view, data.D)
        --checkRedPoint(self)
    end
end

local getNetModel = function ( )
    return netModel.getModelLoginGiftGet()
end

return {getNetModel=getNetModel,update=update}
