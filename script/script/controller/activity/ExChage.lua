local Config = require "Config"

local ExChage = class(LuaController)

function ExChage:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."ExChage.cocos.zip")
    return self._factory:createDocument("ExChage.cocos")
end

--@@@@[[[[
function ExChage:onInitXML()
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
   self._namebg = set:getElfNode("namebg")
   self._name = set:getLabelNode("name")
   self._btn = set:getButtonNode("btn")
   self._btnGet = set:getClickNode("btnGet")
   self._cnt = set:getLinearLayoutNode("cnt")
   self._label = set:getLabelNode("label")
   self._title2 = set:getLinearLayoutNode("title2")
   self._title2_head = set:getLabelNode("title2_head")
   self._title2_time = set:getTimeNode("title2_time")
--   self._@view = set:getElfNode("@view")
--   self._@item = set:getElfNode("@item")
--   self._@cell = set:getElfNode("@cell")
--   self._@Arrow = set:getElfNode("@Arrow")
end
--@@@@]]]]

--------------------------------override functions----------------------
function ExChage:onInit( userData, netData )
	
end

function ExChage:onBack( userData, netData )
	
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
local updateSet
local refreshDayCell
local exChangeEnable
local hasEnough
local setItemGray
local getExReward
local getRecordAmount
local useItem
local costPetOrPetPiece
--data
local netData
local setmap

 getNetModel = function ( )
  return netModel.getExGet()
 end

update = function ( self,view,data )
  netData = data.D 
  print('netData:')
  print(netData)

  appData.getPetInfo().syncPetPieces(self,function ( ... )
    updateLayer(self,view)
  end)
end

updateLayer = function ( self,view )
  local info = appData.getActivityInfo().getDataByType(7)
  print('info:')
  print(info)

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
    self:refreshActivityInfo(view,7,function ( data )
      if data then
        updateLayer(self,view)
      else
        checkRedPoint(self)
      end
    end)
  end

  require 'LangAdapter'.nodePos(view['title2'],nil,nil,nil,nil,ccp(-308.0,136.85715))
  updateList(self,view,info)

end

updateList = function ( self,view,info )
  view['list']:getContainer():removeAllChildrenWithCleanup(true)
  setmap = {}
  if info.Data then
    for i,v in ipairs(info.Data) do
      local itemset = view.createLuaSet('@item')
      refreshDayCell(self,itemset,v,i,view)
      view['list']:getContainer():addChild(itemset[1])    
      setmap[i]=itemset
    end
  end

  view['list']:layout()

end

updateSet = function ( self,view,N )
  local set = setmap[N]
  if set then
    local info = appData.getActivityInfo().getDataByType(7)
    if info and info.Data then
      refreshDayCell(self,set,info.Data[N],N,view)
    end
  end
end

refreshDayCell = function (self, set, v,i,view)

  set['gifts']:removeAllChildrenWithCleanup(true)

  local refreshCell = function ( cellSet,v ,i,flag)
    
    cellSet['icon']:setResid(v.resid[2])
    cellSet['pz']:setResid(v.resid[3])
    cellSet['pzbg']:setResid(v.resid[1])
    cellSet['name']:setString(v.name)
    cellSet['count']:setString(string.format('x%s',tostring(v.amount)))
    -- local color = Res.rankColor4F[v.pzindex]
    -- cellSet['name']:setFontFillColor(color,true)
    -- cellSet['left']:setVisible(i == 1)
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

    setItemGray(cellSet,flag)   
    cellSet['piece']:setVisible(v.isPiece)
    
    require 'LangAdapter'.selectLangkv({German=function ( ... )
      cellSet['name']:setVisible(false)
    end})
  end

  local refreshCells = function ( reslist ,own)
    local isenough = true
    local details  = nil
    if reslist then
      for i,v in ipairs(reslist) do
        local cellSet = view.createLuaSet('@cell')
        local enough,exs = hasEnough(v.orgdata,v.typename,v.amount)
        refreshCell(cellSet,v,i,own and not enough)
        set['gifts']:addChild(cellSet[1])
        if not enough then
          isenough = false
        elseif exs then
          details = details or {}
          table.insert(details,{typename=v.typename,amount=v.amount,exs=exs})
        end
      end
    end
    return isenough,details
  end

  local reslist = Res.getRewardsNRList(v.R1)
  local enough,details = refreshCells(reslist,true)

  local cellSet = view.createLuaSet('@Arrow')
  if v.Amount == 0 then
    set['label']:setString(string.format(Res.locString('Activity$ExchageNoLimit'),v.Amount))
  else
    local lastamount = v.Amount - getRecordAmount(i)
    lastamount = (lastamount > 0 and lastamount) or 0
    set['label']:setString(string.format(Res.locString('Activity$Exchage'),lastamount))  
  end
  
  set['gifts']:addChild(cellSet[1])

  reslist = Res.getRewardsNRList(v.R2)
  refreshCells(reslist)

  set['btnGet']:setEnabled(enough and exChangeEnable(i,v))
  set['btnGet']:setListener(function ( ... )
      getExReward(self,view,i,details)
  end)
  require 'LangAdapter'.LabelNodeAutoShrink(set['btnGet_#title'],80)
  
end


exChangeEnable = function ( N,v )
  if v == nil then
    return false
  end

  local lastamount = v.Amount - getRecordAmount(N)
  print(string.format('lastamount:%d v.Amount:%d getRecordAmount:%d',lastamount,v.Amount,getRecordAmount(N)))
  
  return lastamount > 0 or v.Amount == 0

end

hasEnough = function ( orgdata,typename,amount )
  
  local userinfo = appData.getUserInfo()
  local hasamount = 0
  local needamount = amount
  local exs = nil

  if typename == 'Honor' then

  elseif typename == 'Ap' then
    hasamount = userinfo.getAp()
  elseif typename == 'Gold' then
    hasamount = userinfo.getGold()
  elseif typename == 'Soul' then
    hasamount = userinfo.getSoul()
  elseif typename == 'Exp'  then
    hasamount = userinfo.getExp()
  elseif typename == 'Coin' then
    hasamount = userinfo.getCoin()
  elseif typename == 'Equipment' then
    local EquipInfo = appData.getEquipInfo()
    hasamount = EquipInfo.getEquipmentAmount(orgdata.EquipmentId,true)
  elseif typename == 'Gem' then
    local GemInfo = appData.getGemInfo()
    hasamount = GemInfo.getGemAmount(orgdata.GemId,true)
  elseif typename == 'Pet' then
    local petInfo = appData.getPetInfo()
    hasamount,exs = petInfo.getPetIdsForExchage(orgdata.PetId,needamount)
  elseif typename == 'PetPiece' then
    local petInfo = appData.getPetInfo()
    hasamount = petInfo.getPetPieceAmount(orgdata.PetId)
  elseif typename == 'Material' then
    local bagInfo = appData.getBagInfo()
    hasamount = bagInfo.getItemCount(orgdata.MaterialId)
  elseif typename == '' then
    local petInfo = appData.getPetInfo()
    hasamount = bagInfo.getPetPieceAmount(orgdata.PetId)
  end

  return hasamount >= needamount,exs
end

setItemGray = function ( cellSet,flag )

  local color = (flag and ccc4f(0.5,0.5,0.5,1)) or Res.color4F.white
  if cellSet then
    cellSet['pzbg']:setColorf(color.r,color.g,color.b,color.a)
    cellSet['icon']:setColorf(color.r,color.g,color.b,color.a)
    cellSet['pz']:setColorf(color.r,color.g,color.b,color.a)
    cellSet['count']:setColorf(color.r,color.g,color.b,color.a)
    -- cellSet['left']:setColorf(color.r,color.g,color.b,color.a)
    -- cellSet['right']:setColorf(color.r,color.g,color.b,color.a)
    -- cellSet['namebg']:setColorf(color.r,color.g,color.b,color.a)
    cellSet['name']:setColorf(color.r,color.g,color.b,color.a)
    cellSet['piece']:setColorf(color.r,color.g,color.b,color.a)
  end

end

getRecordAmount = function ( N )
  local amount = 0
  if netData.Records and netData.Records[N] then
    amount = tonumber(netData.Records[N])
  end

  return amount
end

local activityEndCheck = function ( self )
  local info = appData.getActivityInfo().getDataByType(7)
  if info and info.Data then
    for i,v in ipairs(info.Data) do
      if exChangeEnable(i,v) then
        return
      end
    end
  end

  appData.getActivityInfo().activityEnd(7)
  self:onActivityFinish(require 'ActivityType'.ExChage)
  -- GleeCore:popController(nil,Res.getTransitionFade())
end

--netData
getExReward = function (self, view,N,details )

  local Pids = nil
  if details then
    Pids = {}
    for k,v in pairs(details) do
      if v.typename == 'Pet' and v.exs then
        for k1,v1 in pairs(v.exs) do
          table.insert(Pids,v1)
        end
      end
    end
  end
  
  self:send(netModel.getExRewardV2(N,Pids),function ( data )
    if data.D then
      if netData.Records  == nil then
        netData.Records = {}
      end
      local times = 1
      if netData.Records[N] then
        times = netData.Records[N] + 1
      end
      netData.Records[N] = times
      
      local callback = function ( ... )
        appData.updateResource(data.D.Resource)
        useItem(N,Pids)
        -- updateLayer(self,view)
        activityEndCheck(self)
        updateSet(self,view,N)
      end
      if data.D.Reward then
        data.D.Reward.callback=callback
        GleeCore:showLayer('DGetReward',data.D.Reward)
      else
        callback()
      end
    end 
    
  end)

end

useItem = function ( N ,Pids)
  local info = appData.getActivityInfo().getDataByType(7)
  local v = info.Data[N]
  local materials = v.R1.Materials
  local PetPieces = v.R1.PetPieces
  if materials then
    local baginfo = require 'AppData'.getBagInfo()
    for k,v in pairs(materials) do
      local materialId = baginfo.getItemWithMaterial(v.MaterialId).Id
      baginfo.useItemByID(materialId,v.Amount)
    end
  elseif Pids then
    require 'AppData'.getPetInfo().removePetByIds(Pids)
  elseif PetPieces then
    for k,v in pairs(PetPieces) do
      require 'AppData'.getPetInfo().removePetPiecesByPetId(v.PetId,v.Amount)
    end
  end

end

return {getNetModel=getNetModel,update=update}
