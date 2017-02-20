local Config = require "Config"
local Res = require "Res"
local dbManager = require "DBManager"
local appData = require "AppData"
local netModel = require "netModel"
local eventCenter = require 'EventCenter'
local Launcher = require 'Launcher'


local TLRewardTask = class(TabLayer)

function TLRewardTask:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLRewardTask.cocos.zip")
    return self._factory:createDocument("TLRewardTask.cocos")
end

--@@@@[[[[
function TLRewardTask:onInitXML()
    local set = self._set
   self._list = set:getListNode("list")
   self._bguncomp = set:getElfNode("bguncomp")
   self._bguncomp_complabel = set:getLabelNode("bguncomp_complabel")
   self._bgcomp = set:getElfNode("bgcomp")
   self._bgcomp_btnGoto = set:getClickNode("bgcomp_btnGoto")
   self._bgcomp_btnGoto_title = set:getLabelNode("bgcomp_btnGoto_title")
   self._condes = set:getLabelNode("condes")
   self._score = set:getLinearLayoutNode("score")
   self._score_title = set:getLabelNode("score_title")
   self._score_V = set:getLabelNode("score_V")
   self._progress = set:getLabelNode("progress")
   self._item = set:getElfNode("item")
   self._item_pzbg = set:getElfNode("item_pzbg")
   self._item_icon = set:getElfNode("item_icon")
   self._item_pz = set:getElfNode("item_pz")
   self._tip = set:getLabelNode("tip")
--   self._@view = set:getElfNode("@view")
--   self._@cell = set:getElfNode("@cell")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLRewardTask:onInit( userData, netData )
	
end

function TLRewardTask:onEnter( ... )
   self._Tasks = self._parent._Tasks
   if self._Tasks == nil then
      self:send(netModel.getModelTRGet(),function ( data )
         self._Tasks = data.D.Tasks
         self._MCardLeft = data.D.MCardLeft or 0
         self._MCardLuxLeft = data.D.MCardLuxLeft or 0
         self:updateTaskList()
      end)
   end

   appData.getBroadCastInfo().set('task_reward',false)
   self._parent:refreshPoint()
end

function TLRewardTask:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function TLRewardTask:updateTaskList( )

   self:refreshPointState()
   self._viewSet['tip']:setVisible(self._Tasks == nil or #self._Tasks == 0)   

   if self._Tasks then
      table.sort(self._Tasks,function ( v1,v2 )
         if v1 and v2 then
            local dbtask1 = dbManager.getRewardTask(v1.TaskId)
            local dbtask2 = dbManager.getRewardTask(v2.TaskId)

            local comp1 = v1.Complete/dbtask1.condition
            local comp2 = v2.Complete/dbtask2.condition

            if v1.State == 3 and v2.State ~= 3 then
               return true
            elseif v1.State == v2.State and comp1 ~= comp2 then
               return comp1 > comp2
            elseif v1.State == v2.State then
               return v1.TaskId < v2.TaskId   
            end
         end
      end)

      --11001 月卡 排在相同状态的最前
      local temp = self._Tasks
      local mcards = {}
      local tindex = nil
      self._Tasks = {}
      for i=1,#temp do
         local v = temp[i]
         if  self:isMCard(v) then
            table.insert(mcards,v)
         else
            self._Tasks[#self._Tasks+1] = v
         end
         if v.State ~= 3 then
            tindex = tindex or i
         end
      end

      if not require 'AccountHelper'.isItemOFF('MCardName') then
         for i,mcard in ipairs(mcards) do
            if (mcard and mcard.TaskId == 11001) or (mcard and mcard.TaskId == 12001 and not require 'AccountHelper'.isItemOFF('MCardLux')) then
               if mcard and mcard.State == 3 then
                  table.insert(self._Tasks,1,mcard)
               else
                  tindex = tindex or #self._Tasks+1
                  table.insert(self._Tasks,tindex,mcard)
               end   
            end
         end
      end
      
      self._viewSet['list']:stopAllActions()
      self._viewSet['list']:getContainer():removeAllChildrenWithCleanup(true)
      local index = 1
      for k,v in pairs(self._Tasks) do
         if v.State == 2 or v.State == 3 or self:isMCard(v) then
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
      end
      self._viewSet['list']:layout()

   end

end

function TLRewardTask:refreshCell( set,Task)
   local dbtask = dbManager.getRewardTask(Task.TaskId)
   local reswardStr,resid = self:getRewardStrAndResId(dbtask)

   if resid then
      set['item_pzbg']:setResid((resid[1] == nil and '') or resid[1])
      set['item_icon']:setResid(resid[2])
      set['item_pz']:setResid((resid[3] == nil and '') or resid[3])
      if resid[3] then
         set['item_icon']:setScale(135/set['item_icon']:getContentSize().width)
      end
   end

   require 'LangAdapter'.LabelNodeAutoShrink(set['condes'],400)
   require 'LangAdapter'.LabelNodeAutoShrink(set['score_title'],80)
   require 'LangAdapter'.LabelNodeAutoShrink(set['score_V'],130)
   require 'LangAdapter'.LabelNodeAutoShrink(set['bguncomp_complabel'],85)
   require 'LangAdapter'.LabelNodeAutoShrink(set['progress'],96)

   set['condes']:setString(dbtask.des)
   set['score_V']:setString(tostring(reswardStr))
   set['progress']:setString(string.format(Res.locString('DTask$Progress'),Task.Complete,dbtask.condition))   
   
   --Task.State 1：未解锁 2：已解锁 3：已完成 4：已领取
   set['bgcomp']:setVisible(Task.State == 3)
   set['bguncomp']:setVisible(Task.State == 2)


   if Task.State == 3 then
      
      set['bgcomp_btnGoto']:setListener(function ( ... )
         self:getReward(Task,reswardStr)
      end)
      set['progress']:setFontFillColor(ccc4f(0.235294,0.584314,0.003922,1.0),true)

   elseif Task.State == 2 then
      set['progress']:setFontFillColor(Res.color4F.red,true)
   end

   local left = self:getMCardLeft(Task)
   if left then
      set['bgcomp']:setVisible(true)
      set['bguncomp']:setVisible(false)
      set['progress']:setString(string.format(Res.locString('DTask$MCardLast'),tostring(left)))
      if Task.State == 2 then
         --前往购买
         set['bgcomp_btnGoto']:setListener(function ( ... )
            GleeCore:showLayer("DRecharge")
            self._parent:close()
         end)

         require 'LangAdapter'.selectLang(nil,nil,nil,function ( ... )
            set['bgcomp_btnGoto']:setListener(function ( ... )
               GleeCore:showLayer('DConfirmNT',{content = '월간카드 구입 후 수령가능', callback=function ( )
                  GleeCore:showLayer("DRecharge")
                  self._parent:close()  
               end})
            end)
         end)
      elseif Task.State == 4 then
         --已领取
         set['bgcomp_btnGoto']:setEnabled(false)
         set['bgcomp_btnGoto_title']:setString(Res.locString('Friend$ReceiveApFinish'))
      end
   end

end

--help
--[[
type:
1.金币
2.钻石
3.精灵之魂
4.体力
5.经验
6.精灵 --table
7.装备 --table
8.宝石 --table
9.道具 --table
]]
function TLRewardTask:getRewardStrAndResId( dbtask )
   
   local str,resid = Res.getRewardStrAndResId(dbtask.type,dbtask.item)
   
   str = string.format('%sx%d',tostring(str),dbtask.amount)

   return str,resid

end


--net
function TLRewardTask:getReward( Task,rewardMsg )
   self:send(netModel.getModelTRReceive(Task.TaskId),function ( data )
      
      local callback = function ( ... )
         if data.D.MCardLeft then
            self._MCardLeft = data.D.MCardLeft
            self._MCardLuxLeft = data.D.MCardLuxLeft
         end
         
         if data.D.Tasks then
            self._Tasks = data.D.Tasks
            self:updateTaskList()
         end
         if data.D.Resource then
            appData.updateResource(data.D.Resource)
         end
      end

      if data.D.Reward then
         data.D.Reward.callback = callback
         GleeCore:showLayer('DGetReward',data.D.Reward)
      else
         callback()
      end
      --self:toast(string.format('恭喜获得: %s',rewardMsg))

   end)   
end

function TLRewardTask:refreshPointState( ... )

   for i,v in ipairs(self._Tasks) do
      if v.State == 3 then
         return
      end
   end

   self:sendBackground(netModel.getModelRoleNewsUpdate('task_reward',false),function ( ... )
       
   end)

end

function TLRewardTask:isMCard( task )
   return task.TaskId == 12001 or task.TaskId == 11001
end

function TLRewardTask:getMCardLeft( Task )
   if Task.TaskId == 11001 then
      return self._MCardLeft
   elseif Task.TaskId == 12001 then
      return self._MCardLuxLeft
   end
   return false
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLRewardTask, "TLRewardTask")


--------------------------------register--------------------------------
return TLRewardTask
