local Config = require "Config"
local Res = require "Res"
local dbManager = require "DBManager"
local appData = require "AppData"
local netModel = require "netModel"
local eventCenter = require 'EventCenter'

local TLMainTask = class(TabLayer)

function TLMainTask:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLMainTask.cocos.zip")
    return self._factory:createDocument("TLMainTask.cocos")
end

--@@@@[[[[
function TLMainTask:onInitXML()
    local set = self._set
   self._list = set:getListNode("list")
   self._bguncomp = set:getElfNode("bguncomp")
   self._bguncomp_complabel = set:getLabelNode("bguncomp_complabel")
   self._bguncomp_btnGoto = set:getClickNode("bguncomp_btnGoto")
   self._bgcomp = set:getElfNode("bgcomp")
   self._bgcomp_btnGoto = set:getClickNode("bgcomp_btnGoto")
   self._condes = set:getLabelNode("condes")
   self._score = set:getLinearLayoutNode("score")
   self._score_title = set:getLabelNode("score_title")
   self._score_V = set:getLabelNode("score_V")
   self._progress = set:getLabelNode("progress")
   self._item = set:getElfNode("item")
   self._item_pzbg = set:getElfNode("item_pzbg")
   self._item_icon = set:getElfNode("item_icon")
   self._item_pz = set:getElfNode("item_pz")
--   self._@view = set:getElfNode("@view")
--   self._@cell = set:getElfNode("@cell")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLMainTask:onInit( userData, netData )
	
end

function TLMainTask:onEnter( ... )
  self._TasksMain = appData.getLoginInfo().getTaskMain()
  
  self:send(netModel.getTaskMainGet(),function ( data )
    self._TasksMain = data.D.Tasks
    appData.getLoginInfo().updateTaskMain(data.D.Tasks)
    self:updateTaskList()
  end)

  appData.getBroadCastInfo().set('task_main',false)
  self._parent:refreshPoint()
end

function TLMainTask:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function TLMainTask:updateTaskList( ... )
  self:refreshPointState()

  self._viewSet['list']:stopAllActions()
  self._viewSet['list']:getContainer():removeAllChildrenWithCleanup(true)
  local index = 1
  for i,v in ipairs(self._TasksMain) do
    if index <= 6 then
      local set = self:createLuaSet('@cell')
      self:refreshCell(set,v)
      self._viewSet['list']:getContainer():addChild(set[1])
    else
      self:runWithDelay(function ( ... )
        local set = self:createLuaSet('@cell')
        self:refreshCell(set,v)
        self._viewSet['list']:getContainer():addChild(set[1])
      end,0.1*(index-6),self._viewSet['list'])
    end
    index = index + 1
  end
  self._viewSet['list']:layout()

end

function TLMainTask:refreshCell( set,Task )
  --[[
|         RewardGot [false]
|         +TaskId [101]
|         +Cnt [0]
|         +Passed [false]
|         +Id [1]
]]
  local dbtask = dbManager.getInfoTaskMainConfig(Task.TaskId)
  local reswardStr,resid = self:getRewardStrAndResId(dbtask)

  if resid then
    set['item_pzbg']:setResid((resid[1] == nil and '') or resid[1])
    set['item_icon']:setResid(resid[2])
    set['item_pz']:setResid((resid[3] == nil and '') or resid[3])
    if resid[3] then
       set['item_icon']:setScale(135/set['item_icon']:getContentSize().width)
    end
  end

  set['condes']:setString(dbtask.des)
  set['score_V']:setString(tostring(reswardStr))
  set['progress']:setString(string.format(Res.locString('DTask$Progress'),Task.Cnt,dbtask.num))

  --Task.State 1：未解锁 2：已解锁 3：已完成 4：已领取
  set['bgcomp']:setVisible(Task.Passed)
  set['bguncomp']:setVisible(not Task.Passed)
  if Task.Passed then
    
    set['bgcomp_btnGoto']:setListener(function ( ... )
       self:getReward(Task.TaskId)
    end)
    set['progress']:setFontFillColor(ccc4f(0.235294,0.584314,0.003922,1.0),true)

  else
    set['progress']:setFontFillColor(Res.color4F.red,true)
    set['bguncomp_btnGoto']:setListener(function ( ... )
      self._parent:gotoTask(dbtask.GoTo)
    end)
  end
end

function TLMainTask:getRewardStrAndResId(dbtask )
  local dbreward = dbManager.getRewardItem(dbtask.rewardid)
  local str,resid,pzindex = Res.getRewardStrAndResId(dbreward.itemtype,dbreward.itemid,dbreward.args)
  str = string.format('%sx%d',tostring(str),dbreward.amount)
  return str,resid
end

--
function TLMainTask:getReward( TaskId )
  self:send(netModel.getTaskMainGetReward(TaskId),function ( data )
    local callback = function ( ... )
      if data.D.Resource then
        appData.updateResource(data.D.Resource)
      end

      appData.getLoginInfo().updateTaskMain(data.D.Tasks)
      if data.D.Tasks and #data.D.Tasks > 0 then
        self._TasksMain = data.D.Tasks
        self:updateTaskList()
      else
        self:refreshPointState()
        self._parent:tabReInit()
      end
    end

    if data.D.Reward then
      data.D.Reward.callback = callback
      GleeCore:showLayer('DGetReward',data.D.Reward)
    else
      callback()
    end
  end)
end

function TLMainTask:refreshPointState( ... )

   for i,v in ipairs(self._TasksMain) do
      if v.Passed then
        return
      end
   end

   self:sendBackground(netModel.getModelRoleNewsUpdate('task_main',false),function ( ... )
       
   end)
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLMainTask, "TLMainTask")


--------------------------------register--------------------------------
return TLMainTask
