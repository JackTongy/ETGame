local Config = require "Config"
local Res = require "Res"
local dbManager = require "DBManager"
local appData = require "AppData"
local netModel = require "netModel"
local eventCenter = require 'EventCenter'
local Launcher = require 'Launcher'
local UnlockManager = require 'UnlockManager'

local TLDailyTask = class(TabLayer)

function TLDailyTask:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLDailyTask.cocos.zip")
    return self._factory:createDocument("TLDailyTask.cocos")
end

--@@@@[[[[
function TLDailyTask:onInitXML()
    local set = self._set
   self._bg1_title = set:getLabelNode("bg1_title")
   self._info = set:getElfNode("info")
   self._info_title = set:getElfNode("info_title")
   self._info_progress = set:getElfNode("info_progress")
   self._info_progress_bg = set:getElfNode("info_progress_bg")
   self._info_progress_fore = set:getBarNode("info_progress_fore")
   self._info_progress_V = set:getLabelNode("info_progress_V")
   self._info_titledes = set:getLabelNode("info_titledes")
   self._info_btnupgrade = set:getClickNode("info_btnupgrade")
   self._info_linearlayout_scorev = set:getLabelNode("info_linearlayout_scorev")
   self._info_gifts = set:getListNode("info_gifts")
   self._score = set:getLinearLayoutNode("score")
   self._score_title = set:getLabelNode("score_title")
   self._score_v = set:getLabelNode("score_v")
   self._btn = set:getClickNode("btn")
   self._btn_title = set:getLabelNode("btn_title")
   self._gifts = set:getLinearLayoutNode("gifts")
   self._content = set:getElfNode("content")
   self._content_pzbg = set:getElfNode("content_pzbg")
   self._content_icon = set:getElfNode("content_icon")
   self._content_pz = set:getElfNode("content_pz")
   self._count = set:getLabelNode("count")
   self._btn = set:getButtonNode("btn")
   self._list = set:getListNode("list")
   self._bgcomp = set:getElfNode("bgcomp")
   self._bgcomp_complabel = set:getLabelNode("bgcomp_complabel")
   self._bguncomp = set:getElfNode("bguncomp")
   self._bguncomp_btnGoto = set:getButtonNode("bguncomp_btnGoto")
   self._bguncomp_btnComp = set:getClickNode("bguncomp_btnComp")
   self._bguncomp_btnComp_title = set:getLabelNode("bguncomp_btnComp_title")
   self._bguncomp_goto = set:getElfNode("bguncomp_goto")
   self._linear = set:getLinearLayoutNode("linear")
   self._linear_condes = set:getLabelNode("linear_condes")
   self._linear_progress = set:getLabelNode("linear_progress")
   self._score = set:getLinearLayoutNode("score")
   self._score_title = set:getLabelNode("score_title")
   self._score_V = set:getLabelNode("score_V")
--   self._@view = set:getElfNode("@view")
--   self._@item = set:getElfNode("@item")
--   self._@gitem = set:getElfNode("@gitem")
--   self._@cell = set:getElfNode("@cell")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLDailyTask:onInit( userData, netData )
	
end

function TLDailyTask:onEnter( ... )
   self:updateLayer()
end

function TLDailyTask:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function TLDailyTask:updateLayer( ... )

   if self._parent._DailyTaskGet.Packs ~= self._Packs then
      self._Packs = self._parent._DailyTaskGet.Packs
      self:updateInfo()
   end

   if self._parent._DailyTaskGet.Tasks ~= self._Tasks then
      self._Tasks = self._parent._DailyTaskGet.Tasks
      self:updateTaskList()
   end

end

function TLDailyTask:updateInfo( ... )

   self._DailyTaskScore = self._parent._DailyTaskGet.DailyTaskScore
   self._ToadyScore = self._parent._DailyTaskGet.TodayScore
   self:refreshPointState()

   --[[
   self._TitleID = appData.getUserInfo().getTitleID()
   local enableupgrade = false
   local dbtitle = dbManager.getTrainTitle(self._TitleID)
   local ntitle = dbManager.getTrainTitle(self._TitleID+1)
   local p1
   
   if dbtitle then

      if ntitle then
         self._viewSet['info_progress_V']:setString(string.format('%d/%d',tonumber(self._DailyTaskScore),tonumber(ntitle.score)))
         enableupgrade = self._DailyTaskScore >= ntitle.score
         p1 = self._DailyTaskScore/ntitle.score
      else
         self._viewSet['info_progress_V']:setString(string.format('%d/%d',tonumber(dbtitle.score),tonumber(dbtitle.score)))
         p1 = 1
      end

      self._viewSet['info_title']:setResid(string.format('XL_%d.png',dbtitle.Id))
      self._viewSet['info_titledes']:setString(string.format(Res.locString('CTask$TitleDesFormat'),dbtitle.atkrate*100,dbtitle.hprate*100))--dbtitle.TrainRate*100
      self._viewSet['info_progress_fore']:setLength(self._viewSet['info_progress_bg']:getContentSize().width*p1,true)
   end

   self._viewSet['info_btnupgrade']:setEnabled(enableupgrade)
   if enableupgrade then
      self._viewSet['info_btnupgrade']:setListener(function ( ... )
         self:RaiseTitle()
      end)
   end
   ]]

   self._viewSet['info_linearlayout_scorev']:setString(tostring(self._ToadyScore))
   self:updateGiftList()

   appData.getBroadCastInfo().set('daily_task',false)
   self._parent:refreshPoint()

end

function TLDailyTask:refreshPointState( ... )

   local Packs = self._parent._DailyTaskGet.Packs
   
   for i,v in ipairs(Packs) do
      if tonumber(v) == 0 then
         return
      end
   end

   self:sendBackground(netModel.getModelRoleNewsUpdate('daily_task',false),function ( ... )
       
   end)

end

function TLDailyTask:updateTaskList( ... )
   
   self._viewSet['list']:stopAllActions()
   self._viewSet['list']:getContainer():removeAllChildrenWithCleanup(true)

   if self._parent._DailyTaskGet then

      local Tasks = self._parent._DailyTaskGet.Tasks
      for i,v in ipairs(Tasks) do
         if v.Taskid == 17 then
            v.Done = true
            break
         end
      end
      
      table.sort(Tasks,function ( v1,v2 )
         if v1 and v2 then
            if not v1.Done and v2.Done then
               return true
            elseif v1.Done == v2.Done then
               return v1.Taskid < v2.Taskid
            end
         end
      end)
      
      local vip4abv = (appData.getUserInfo().getVipLevel() >= 4)
      for i,v in ipairs(Tasks) do   
         if i <= 3 then
            local set = self:createLuaSet('@cell')
            self:refreshTaskItem(set,v,vip4abv)
            self._viewSet['list']:getContainer():addChild(set[1])
         else
            self:runWithDelay(function ( ... )
               local set = self:createLuaSet('@cell')
               self:refreshTaskItem(set,v,vip4abv)
               self._viewSet['list']:getContainer():addChild(set[1])
            end,(i-3)*0.1,self._viewSet['list'])
         end
      end
   
      self._viewSet['list']:layout()
   end

end

function TLDailyTask:refreshTaskItem( set,Task ,abv)
   local espt = function ( ... )
      set['bguncomp_goto_#title']:setVisible(false)
      set['bguncomp_btnComp_title']:setVisible(false)
   end
   require 'LangAdapter'.selectLang( nil ,nil,nil,nil,nil,espt,espt)
   local dbtask = dbManager.getDailyTask(Task.Taskid)
   if Task.Taskid == 17 then
      local viplvl = appData.getUserInfo().getVipLevel()
      local ismaxVip = appData.getUserInfo().isMaxVip()
      local curContent = string.format(dbtask.Content,viplvl)
      dbtask.Score = Task.Count
      dbtask.Content = curContent
      if dbtask.Content and require 'AccountHelper'.isItemOFF('Vip') then
         dbtask.Content = string.gsub(dbtask.Content, 'VIP', Res.locString('TS$VIPREP'))
         dbtask.Content = string.gsub(dbtask.Content, 'vip', Res.locString('TS$VIPREP'))
      end
      -- local nextContent = (ismaxVip and '') or Res.locString('CTask$scoreVipTask')--(提升1级VIP,可额外获得5积分)
      -- set['bgcomp_complabel']:setString(nextContent)
   end

   require 'LangAdapter'.LabelNodeAutoShrink(set['linear_condes'],200)
   set['linear_condes']:setString(dbtask.Content)
   set['score_V']:setString(tostring(dbtask.Score))
   require 'LangAdapter'.labelDimensions(set['bguncomp_btnComp_title'], nil,nil,CCSizeMake(60,0))
   local tfunc = function ( ... )
      set['bguncomp_btnComp_title']:setFontSize(18)
      set['bguncomp_btnComp_title']:setDimensions(CCSizeMake(0,0))
   end
   require 'LangAdapter'.selectLangkv({Indonesia=tfunc,German=tfunc})

   set['bguncomp']:setVisible(not Task.Done)
   -- set['linear']:setVisible(not Task.Done)
   set['bgcomp']:setVisible(Task.Done)

   if not Task.Done then
      set['linear_progress']:setString(string.format('(%d/%d)',Task.Count,dbtask.Count))
      set['bguncomp_btnComp']:setListener(function ( ... )

         local callback = function ( ... )
            self:finishTask(dbtask)   
         end

         local str = string.format(Res.locString('CTask$ConfirmFinish'),dbtask.Coin)
         GleeCore:showLayer('DConfirmNT',{content=str,callback=callback})
      
      end)

      set['bguncomp_btnComp']:setVisible(abv)
      set['bguncomp_goto']:setVisible(not abv)
      set['bguncomp_btnGoto']:setListener(function ( ... )
         self._parent:gotoTask(dbtask.GoTo)
      end)
   end

end

function TLDailyTask:updateGiftList( ... )
   self._viewSet['info_gifts']:getContainer():removeAllChildrenWithCleanup(true)

   if self._parent._DailyTaskGet then
      local Packs = self._parent._DailyTaskGet.Packs
      local DailyTaskRewardConfig = require 'DailyTaskRewardConfig'

      local index = -1
      for i,v in ipairs(Packs) do
         local set = self:createLuaSet('@item')
         local state = self:refreshGiftItem(set,v,DailyTaskRewardConfig[i],0.4+0.05*i)

         if (state == 0 or state == -1) and index == -1 then
            index = i
         end
         self._viewSet['info_gifts']:getContainer():addChild(set[1])   
      end

      index = (index <= 1 and 1) or index
      self._viewSet['info_gifts']:layout()
      self._viewSet['info_gifts']:alignTo(index-1)   
   end
      
end

function TLDailyTask:refreshGiftItem( set,Pack,dbPack,scale)

   set['score_v']:setString(string.format('%d',dbPack.Score))
   local color = ccc4f(0.329412,0.898039,0.254902,1.0)
   if Pack == -1 then
      set['btn']:setEnabled(false)
      color = ccc4f(0.992157,0.266667,0.133333,1.0)
   elseif Pack == 0 then
      set['btn']:setEnabled(true)

      set['btn']:setListener(function ( ... )
         self:getGift(dbPack)
      end)
   elseif Pack == 1 then
      set['btn']:setEnabled(false)
      local title = Res.locString('DRechargeFT$hadGotReward')
      set['btn_title']:setString(title)
      set['btn_title']:setString(title)
      set['btn_title']:setString(title)
   end
   set['score_v']:setFontFillColor(color,true)
   require 'LangAdapter'.LabelNodeAutoShrink(set['score_title'],84)
   self:refreshGiftContent(set,dbPack)

   return Pack
end

--help
function TLDailyTask:noticeReward( dbPack )

   if dbPack then
      local Reward = table.clone(dbPack)
      Reward.Materials = nil
      local Mtable = {}
      if dbPack.Materials and string.len(dbPack.Materials) > 0 then
         local items = Res.Split(dbPack.Materials,',')
         for i,v in ipairs(items) do
            local idcnt = Res.Split(v,':')
            table.insert(Mtable,{MaterialId=tonumber(idcnt[1]),Amount=tonumber(idcnt[2]),Seconds=0})
         end
         Reward.Materials = Mtable
      end

      GleeCore:showLayer('DGetReward',Reward)
   end
   require 'BIHelper'.record('DailyTask','getReward')
end

function TLDailyTask:refreshGiftContent( set,dbPack )
   if dbPack then
      
      reward = table.clone(dbPack)
      reward.Materials = {}
      
      if dbPack.Materials and string.len(dbPack.Materials) > 0 then
      
         local items = Res.Split(dbPack.Materials,',')
         for i,v in ipairs(items) do
            local idcnt = Res.Split(v,':')
            table.insert(reward.Materials,{MaterialId=tonumber(idcnt[1]),Amount=idcnt[2]})
         end

      end

      local reslist = Res.getRewardsNRList(reward)

      if reslist then
         set['gifts']:removeAllChildrenWithCleanup(true)
         for i,v in ipairs(reslist) do
            local cellSet = self:createLuaSet('@gitem')
            cellSet['content_icon']:setResid(v.resid[2])
            cellSet['content_pz']:setResid(v.resid[3])
            cellSet['content_pzbg']:setResid(v.resid[1])
            cellSet['count']:setString(string.format('x%s',Res.getGoldFormat(tonumber(v.amount),10000)))
            if v.showfunc and cellSet['btn'] then
               cellSet['btn']:setListener(v.showfunc)
            end
            -- local scale = 0.58
            -- if v.resid[2] and v.resid[3] then
            --   local pzsize = cellSet['pz']:getContentSize()
            --   local iconsize = cellSet['icon']:getContentSize()
            --   cellSet['icon']:setScaleX(135/iconsize.width*scale)
            --   cellSet['icon']:setScaleY(135/iconsize.height*scale)
            -- else
            --   cellSet['icon']:setScale(scale)
            -- end

            set['gifts']:addChild(cellSet[1])
         end
      end

   end

end

--net
function TLDailyTask:RaiseTitle( ... )

   self:send(netModel.getModelRoleRaiseTitle(),function ( data )
      local olddbtitle = dbManager.getTrainTitle(self._TitleID)
      local oldresid = string.format('XL_%d.png',olddbtitle.Id)

      if data.D.Role then
         appData.getUserInfo().setData(data.D.Role) 
         local dbtitle = dbManager.getTrainTitle(data.D.Role.TitleId)
      end

      self._viewSet['info_title']:setResid(nil)
      self._TitleID = appData.getUserInfo().getTitleID()
      local dbtitle = dbManager.getTrainTitle(self._TitleID)
      local resid = string.format('XL_%d.png',dbtitle.Id)

      self._parent:runTitleMotion(resid,oldresid,function ( ... )
         self:updateInfo()
         self:toast(string.format(Res.locString('CTask$upgradeSuc'),dbtitle.Name))
      end)

   end)

end

function TLDailyTask:finishTask( dbtask )
   
   self:send(netModel.getModelDailyTaskFinish(dbtask.Id),function ( data )
      if data.D.Role then
         appData.getUserInfo().setData(data.D.Role)
      end   

      if data.D.Tasks then
         self._parent._DailyTaskGet.Tasks = data.D.Tasks
      end

      if data.D.Packs then
         self._parent._DailyTaskGet.Packs = data.D.Packs
      end

      self._parent._DailyTaskGet.DailyTaskScore = data.D.DailyTaskScore
      self._parent._DailyTaskGet.TodayScore = data.D.TodayScore

      self:updateLayer()

      self:toast(string.format(Res.locString('DTask$Complete'),dbtask.Content))
   end)

end

function TLDailyTask:getGift( dbPack )

   self:send(netModel.getDailyTaskGetReward(dbPack.Id),function ( data )

      if data.D.Packs then
         self._parent._DailyTaskGet.Packs = data.D.Packs
      end

      if data.D.Role then
         appData.getUserInfo().setData(data.D.Role)
      end   

      if data.D.Resource then
         appData.updateResource(data.D.Resource)
      end

      self:updateInfo()

      self:noticeReward(dbPack)
   end)

end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLDailyTask, "TLDailyTask")


--------------------------------register--------------------------------
return TLDailyTask
