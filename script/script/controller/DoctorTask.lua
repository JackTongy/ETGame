local Config = require "Config"

local DoctorTask = class(LuaDialog)

function DoctorTask:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DoctorTask.cocos.zip")
    return self._factory:createDocument("DoctorTask.cocos")
end

--@@@@[[[[
function DoctorTask:onInitXML()
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
   self._progress = set:getElfNode("progress")
   self._progress_complete = set:getElfNode("progress_complete")
   self._progress_uncomplete = set:getElfNode("progress_uncomplete")
   self._progress_linear = set:getLinearLayoutNode("progress_linear")
   self._progress_linear_des = set:getLabelNode("progress_linear_des")
   self._progress_linear_p = set:getLabelNode("progress_linear_p")
   self._title2 = set:getLinearLayoutNode("title2")
   self._title2_head = set:getLabelNode("title2_head")
   self._title2_time = set:getTimeNode("title2_time")
   self._cur = set:getLinearLayoutNode("cur")
   self._cur_taskdes = set:getLabelNode("cur_taskdes")
--   self._@view = set:getElfNode("@view")
--   self._@item = set:getElfNode("@item")
--   self._@cell = set:getElfNode("@cell")
--   self._@empty = set:getElfNode("@empty")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DoctorTask:onInit( userData, netData )
	
end

function DoctorTask:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

local Res = require "Res"
local dbManager = require "DBManager"
local equipFunc = require "EquipInfo"
local appData = require 'AppData'
local TimeManager = require 'TimeManager'
local netModel = require 'netModel'
local eventCenter = require 'EventCenter'
local LangAdapter = require 'LangAdapter'

--func
local getNetModel
local update
local updateLayer
local updateList
local addCell
local hadGet
local getTaskReward

--data
local netData

getNetModel = function ()
  return netModel.getModelDoctorTaskGet()
end

update = function ( self,view,data )
  netData = data.D

  print('netData:')
  print(netData)

  updateLayer(self,view)
end

hadGet = function ( N )
  if netData.Task.Gots then
    for i,v in ipairs(netData.Task.Gots) do
      if tonumber(N) == v then
        return true
      end    
    end
  end
  
  return false
end

updateLayer = function ( self,view )
  local info = appData.getActivityInfo().getDataByType(33)

  LangAdapter.nodePos(view['title2'],ccp(-309.0,128.85715))
  LangAdapter.nodePos(view['cur'],ccp(-312.0,91.0))

  if info and info.Data then
    local taskcfg = dbManager.getDoctorTaskConfig(info.Data.Type)
    view['cur_taskdes']:setString(taskcfg.name)

    local cdseconds = TimeManager.timeOffset(info.CloseAt)
    if cdseconds < 0 then
      view['title2_time']:setHourMinuteSecond(0,0,-cdseconds)
      view['title2_time']:setUpdateRate(-1)
      view['title2_time']:setTimeFormat(DayHourMinuteSecond)
      view['title2_time']:addListener(function ( ... )
        self:onActivityFinish(require 'ActivityType'.DoctorTask)  
      end)
    else
      self:onActivityFinish(require 'ActivityType'.DoctorTask)
      return
    end

    updateList(self,view,info.Data,taskcfg.name)
  end
  
end

updateList = function ( self,view,data,tname )
    view['list']:getContainer():removeAllChildrenWithCleanup(true)

    if netData.Task then
      local gots = {}
      for i=1,5 do
        if not hadGet(i) then
          addCell(self,view,data[string.format('Cnt%d',i)],data[string.format('Reward%d',i)],tname,i)
        else
          table.insert(gots,i)
        end
      end

      for i,v in ipairs(gots) do
        addCell(self,view,data[string.format('Cnt%d',v)],data[string.format('Reward%d',v)],tname,v)
      end
    end

    view['list']:layout()
end

addCell = function ( self,view,cnt,reward,tname,N)

  if cnt and reward then
    local itemset = view.createLuaSet('@item')
    itemset['progress_linear_des']:setString(tname)
    itemset['progress_linear_p']:setString(string.format('(%s/%s)',tostring(netData.Task.Cnt),tostring(cnt)))
    local complete = netData.Task.Cnt >= cnt
    itemset['progress_complete']:setVisible(complete)
    itemset['progress_uncomplete']:setVisible(not complete)
    itemset['progress_linear_p']:setFontFillColor(complete and ccc4f(0.0,0.5,0.0,1.0) or Res.color4F.red,true)
    itemset['btnGet']:setEnabled(complete)
    require 'LangAdapter'.LabelNodeAutoShrink(itemset['btnGet_title'],75)

    if hadGet(N) then
      itemset['btnGet']:setEnabled(false)
      itemset['btnGet_title']:setString(Res.locString('Global$ReceiveFinish'))
    end

    itemset['btnGet']:setListener(function ( ... )
      getTaskReward(self,view,N)
    end)

    local reslist = Res.getRewardsNRList(reward)
    local emptycnt = 4
    if reslist then
      itemset['gifts']:removeAllChildrenWithCleanup(true)
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

        itemset['gifts']:addChild(cellSet[1])
        emptycnt = emptycnt - 1

        require 'LangAdapter'.LabelNodeAutoShrink(cellSet['name'],85)
        require 'LangAdapter'.selectLangkv({German=function ( ... )
          cellSet['name']:setVisible(false)
        end})
      end
    end

    for i=1,emptycnt do
      local emptyset = view.createLuaSet('@empty')
      itemset['gifts']:addChild(emptyset[1])
    end

    view['list']:getContainer():addChild(itemset[1])
  end

end

getTaskReward = function ( self,view,N )
  self:send(netModel.getModelDoctorTaskReward(N),function ( data )
    if data.D.Task then
      netData.Task =  data.D.Task

      local callback = function ( ... )
        updateLayer(self,view)
      end
      
      if data.D.Reward then
        data.D.Reward.callback = callback
        GleeCore:showLayer('DGetReward',data.D.Reward)
      else
        callback()
      end

      if data.D.Resource then
        appData.updateResource(data.D.Resource)
      end

    end
  end)
end

return {getNetModel=getNetModel,update=update}
