local Config = require "Config"
local Res = require "Res"
local dbManager = require "DBManager"
local appData = require "AppData"
local netModel = require "netModel"
local eventCenter = require 'EventCenter'
local Launcher = require 'Launcher'
local UnlockManager = require 'UnlockManager'
local townFunc = require "TownInfo"

local actionTable = 
{
   [1]={C='CWorldMap',D={PlayBranch=townFunc.getPlayBranchList().PlayBranchNormal}},-- 1:主界面
   [2]={SD='DPetAcademyV2'},-- 2.精灵学院
   [3]={SD='DMagicShop',MN='MagicShop'},--D={ShowActivity = require "ActivityType".MagicShop}},-- 3.神秘商店
   [4]={SD='DBagWithList'},-- 4.背包
   [5]={SD='DTrain',MN='Train'},--D={ShowActivity = require "ActivityType".Practice}},-- 5.训练
   [6]={SD='DBagWithList',D={tabIndexSelected=2}},-- 6.装备列表
   [7]={SD='DMagicBox',MN='MagicBox',D={ShowIndex = 2}},--D={ShowActivity = require "ActivityType".MagicBox}},-- 7.神秘盒子
   [8]={SD='DRoadOfChampion',MN='RoadOfChampion'},--D={ShowActivity = require 'ActivityType'.RoadOfChampion}},-- 8.试炼之塔
   [9]={SD='DArena',MN='Arena'},-- 9.竞技场
   [10]={SD='DPetList'},-- 10.精灵列表
   [11]={SD='DMall'},--D={tab=2}},-- 11.商城
   [12]={SD='DActivity',D={ShowActivity = require 'ActivityType'.RoastDuck}},--12.香烤大葱鸭
   [13]={SD='DActRaid',MN='EquipFuben'},--D={ShowActivity = require 'ActivityType'.ActRaid}},-- 13.活动副本
   [14]={SD='DActivity',D={ShowActivity = require 'ActivityType'.LuckyCat}},-- 14.招财喵喵
   [15]={SD='DPetKill'},--D={ShowActivity = require 'ActivityType'.PetKill}},-- 15.神兽降临
   [16]={SD='DRoadOfChampion',MN='RoadOfChampion',D={tabIndexSelected=3}},--D={ShowActivity = require 'ActivityType'.RoadOfChampion}},-- 16.冠军之塔
   --[17]={C='CActivity',D={ShowActivity = require 'ActivityType'.LuckyCat}},-- 17.馆长争夺战
   [18]={SD='DFriend'},
   [19]={C='CWorldMap',D={PlayBranch=townFunc.getPlayBranchList().PlayBranchSenior}},
   [20]={SD='DPetFoster',D={tab='TLAwake'}},
   [21]={SD='DPetFoster',D={tab='TLPetUpgrade'}},
   [22]={SD='DPetList',D={tab=3}},
}

Launcher.register('DTask',function ( userData )

   Launcher.callNet(netModel.getModelDailyTaskGet(),function ( data )
      Launcher.Launching(data)   
   end)
   
end)


local DTask = class(TabDialog)

function DTask:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DTask.cocos.zip")
    return self._factory:createDocument("DTask.cocos")
end

--@@@@[[[[
function DTask:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg = set:getElfNode("root_bg")
   self._root_tabs = set:getLinearLayoutNode("root_tabs")
   self._normal_v = set:getLabelNode("normal_v")
   self._pressed_v = set:getLabelNode("pressed_v")
   self._point = set:getElfNode("point")
   self._normal_v = set:getLabelNode("normal_v")
   self._pressed_v = set:getLabelNode("pressed_v")
   self._point = set:getElfNode("point")
   self._root_content = set:getElfNode("root_content")
   self._root_title = set:getElfNode("root_title")
   self._root_title_content = set:getLabelNode("root_title_content")
   self._root_close = set:getButtonNode("root_close")
   self._root_help = set:getButtonNode("root_help")
   self._KeyStorage = set:getElfNode("KeyStorage")
   self._KeyStorage_light_Position = set:getElfNode("KeyStorage_light_Position")
   self._KeyStorage_light_Rotate = set:getElfNode("KeyStorage_light_Rotate")
   self._KeyStorage_white_Color = set:getElfNode("KeyStorage_white_Color")
   self._KeyStorage_nexttitle_Visible = set:getElfNode("KeyStorage_nexttitle_Visible")
   self._KeyStorage_nexttitle_Scale = set:getElfNode("KeyStorage_nexttitle_Scale")
   self._KeyStorage_nexttitle_Position = set:getElfNode("KeyStorage_nexttitle_Position")
   self._KeyStorage_nexttitle_Rotate = set:getElfNode("KeyStorage_nexttitle_Rotate")
   self._KeyStorage_title2_Visible = set:getElfNode("KeyStorage_title2_Visible")
   self._KeyStorage_rect1_Position = set:getElfNode("KeyStorage_rect1_Position")
   self._KeyStorage_rect1_Rotate = set:getElfNode("KeyStorage_rect1_Rotate")
   self._light = set:getElfNode("light")
   self._stb_rect1 = set:getRectangleNode("stb_rect1")
   self._titleold = set:getElfNode("titleold")
   self._white = set:getRectangleNode("white")
   self._title = set:getElfNode("title")
   self._title_content = set:getLabelNode("title_content")
   self._help1 = set:getButtonNode("help1")
   self._nexttitle = set:getElfNode("nexttitle")
   self._help2 = set:getButtonNode("help2")
   self._title2 = set:getElfNode("title2")
   self._title2_content = set:getLabelNode("title2_content")
--   self._@tab = set:getTabNode("@tab")
--   self._@lock = set:getClickNode("@lock")
--   self._@motion = set:getElfMotionNode("@motion")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DTask:onInit( userData, netData )
  self.actionTable = actionTable
	self:registerTabs()
  Res.doActionDialogShow(self._root,function ( ... )
    require 'GuideHelper':check('CTask')
  end)
  self._root_close:setListener(function ( ... )
    Res.doActionDialogHide(self._root, self)
  end)

  if netData then
      self._DailyTaskGet = netData.D
      self:runWithDelay(function ( ... )
         self:defualtSelect()
      end,0.21)
      
   else
      self:send(netModel.getModelDailyTaskGet(),function ( data )
         self._DailyTaskGet = data.D  
         self:defualtSelect()
      end,
      function ( ... )
         self:close()
      end)
   end

   eventCenter.addEventFunc('EventTaskReward',function ( data )
      self:refreshPoint()
   end,"CTask")

   eventCenter.addEventFunc('EventDailyTask',function ( data )
      self:refreshPoint()   
   end,'CTask')

   self:refreshPoint()
   self._root_help:setVisible(false)
  self._root_help:setListener(function ( ... )
  	GleeCore:showLayer("DHelp", {type = "任务"})
  end)
end

function DTask:onBack( userData, netData )

--[[
	self._Tasks = nil
   self._DailyTaskGet = nil 

   self:send(netModel.getModelDailyTaskGet(),function ( data )
      self._DailyTaskGet = data.D  
      self:refreshTab()
   end)
]]
end

function DTask:close( ... )
  self:releaseTabs()
  eventCenter.resetGroup("CTask")
end

function DTask:registerTabs( ... )
  local taskmain = appData.getLoginInfo().getTaskMain()
  self._showtaskmain = taskmain and #taskmain > 0
  
  self:setTabRootNode(self._root_content)
  local firsttab
  local tab1,set1

  local tab0,set0
  if self._showtaskmain then
    tab0,set0 = self:createTabSetWith('@tab',Res.locString('CTask$MainTask'))
    self:registerTab('TLMainTask',require 'TLMainTask',tab0)
    firsttab = firsttab or tab0
  else
    self:sendBackground(netModel.getModelRoleNewsUpdate('task_main',false),function ( ... )
       
    end)
  end

  local datetime = require 'AppData'.getUserInfo().getRoleCreateDateTime()
  local stimes   = require 'TimeManager'.getCurrentSeverTime()/1000
  self._isTheSecondDay = require 'Toolkit'.isTheSecondDay(datetime,stimes)
  if self._isTheSecondDay then
    tab1,set1 = self:createTabSetWith('@tab',Res.locString('CTask$DailyTaskV2'))
    self:registerTab('TLDailyTask',require 'TLDailyTask',tab1)
    firsttab = firsttab or tab1
  else
    tab1,set1 = self:createTabSetWith('@lock',Res.locString('CTask$DailyTaskV2'))
    tab1:setListener(function ( ... )
      self:toast(Res.locString("Home$TaskUnLockTip"))
    end)
  end

  
  local tab2,set2 = self:createTabSetWith('@tab',Res.locString('CTask$RewardTaskV2'))
  self:registerTab('TLRewardTask',require 'TLRewardTask',tab2)
  firsttab = firsttab or tab2

  self._tab1 = firsttab
  self._tab0set = set0
  self._tab1set = set1
  self._tab2set = set2  
end

function DTask:createTabSetWith( nodename,tabname )
  local tab = self:createLuaSet(nodename)
  tab['normal_v']:setString(tabname)
  tab['pressed_v']:setString(tabname)
  require 'LangAdapter'.fontSize(tab['normal_v'],nil,nil,24,nil,24,24,24)
  require 'LangAdapter'.fontSize(tab['pressed_v'],nil,nil,24,nil,24,24,24)
  self._root_tabs:addChild(tab[1])
  return tab[1],tab
end
--------------------------------custom code-----------------------------
function DTask:refreshPoint( ... )
  local point = appData.getBroadCastInfo().get('task_main')
  if self._tab0set then
     self._tab0set['point']:setVisible(point ~= nil and point)
   end
   local point = appData.getBroadCastInfo().get('task_reward')
   self._tab2set['point']:setVisible(point ~= nil and point)
   local point = appData.getBroadCastInfo().get('daily_task')
   self._tab1set['point']:setVisible(point ~= nil and point)
end

function DTask:defualtSelect( ... )
  local task_main = appData.getBroadCastInfo().get('task_main')
  local reward = appData.getBroadCastInfo().get('task_reward')
  local daily = appData.getBroadCastInfo().get('daily_task')

  local selectset = nil
  -- if require 'GuideHelper':isGuideDone() then
    selectset = selectset or (task_main and self._tab0set)
    selectset = selectset or (daily and self._tab1set)
    selectset = selectset or (reward and self._tab2set)
    selectset = selectset or self._tab0set
    selectset = selectset or (self._isTheSecondDay and self._tab1set)
    selectset = selectset or self._tab2set
    selectset[1]:trigger(nil)
  -- else
  --   self._tab1:trigger(nil)
  -- end

end

function DTask:runTitleMotion( titleresid,oldresid,callback )

  if self._motion == nil then
    self._motion = self:createLuaSet('@motion')
    self._root:addChild(self._motion[1])
  end
  
  self._motion[1]:runAnimate(0,1500)
  self._motion[1]:setVisible(true)
  self._motion['nexttitle']:setResid(titleresid)
  self._motion['titleold']:setResid(oldresid)
  self._motion[1]:setListener(function ( ... )
    self._motion[1]:setVisible(false)
    return callback and callback() 
  end)

end

function DTask:gotoTask( GoTo )
   local action = self.actionTable[GoTo]
   if action and action.MN and not UnlockManager:isUnlock(action.MN) then
      self:toast(UnlockManager:getUnlockConditionMsg(action.MN))
      return
   end

   if action and action.C and string.len(action.C) > 0 then
    if action.C == "CWorldMap" then
      require 'EventCenter'.eventInput("GoToTown", {PlayBranch = action.D.PlayBranch})
      self:close()
    else
      GleeCore:pushController(action.C,action.D, nil, Res.getTransitionFade())
      self:close()
    end
   elseif action and action.P and string.len(action.P) then
      -- GleeCore:popControllerTo(action.P)
   elseif action and action.SD and string.len(action.SD) > 0 then
      GleeCore:showLayer(action.SD,action.D)
      self:close()
   end

end

function DTask:tabReInit( ... )
  self:releaseTabs()
  self._root_tabs:removeAllChildrenWithCleanup(true)
  self:registerTabs()
  self:defualtSelect()
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DTask, "DTask")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DTask", DTask)
