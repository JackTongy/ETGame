local Config = require "Config"
local Res    = require 'Res'
local Launcher = require 'Launcher'
local netModel = require 'netModel'
local TimeManager = require 'TimeManager'
local GuildInfo   = require 'GuildInfo'
local dbManager   = require 'DBManager'
local GBHelper    = require "GBHelper"
local AppData     = require 'AppData'
local EventCenter = require 'EventCenter'

Launcher.register('DGuildBSC',function ( userData )

   --[[
   local data = {}
   
   data.Signed = false
   data.ServerTime = "2015-8-11 1:47:00"

   data.Schedule = {}
   data.Schedule.SeasonStart  = "2015-8-3 00:00:00"--DateTime 本赛季开始时间
   --报名
   data.Schedule.SignUpFinish = "2015-8-11 02:07:00"--DateTime 报名截止时间
   --阵容设置
   data.Schedule.MatchStart   = "2015-8-12 00:00:00"--DateTime 正赛开始时间
   --比赛进行中
   data.Schedule.ChallengeStartOne  = "2015-8-13 00:00:00"--DateTime 第一次挑战开始时间
   data.Schedule.ChallengeFinishOne = "2015-8-14 00:00:00"--DateTime 第一次挑战结束时间
   data.Schedule.ChallengeStartTwo  = "2015-8-15 00:00:00"--DateTime 第二次挑战开始时间
   data.Schedule.ChallengeFinishiTwo = "2015-8-16 00:00:00"--DateTime 第二次挑战结束时间
   data.Schedule.MatchFinish  = "2015-8-17 00:00:00"  --DateTime 正赛结束时间
   --结束
   --]]

   local data = GBHelper.getGuildMatchSchedule()
   if data then
      Launcher.Launching(data)
   else
      Launcher.callNet(netModel.getModelGuildMatchScheduleGet(),function ( data )
         Launcher.Launching(data.D)
      end)
   end
   
end)


local DGuildBSC = class(LuaDialog)

function DGuildBSC:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGuildBSC.cocos.zip")
    return self._factory:createDocument("DGuildBSC.cocos")
end

--@@@@[[[[
function DGuildBSC:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_close = set:getButtonNode("root_close")
   self._root_bg = set:getJoint9Node("root_bg")
   self._root_bg_tbg = set:getElfNode("root_bg_tbg")
   self._root_bg_title = set:getLabelNode("root_bg_title")
   self._root_scheme = set:getElfNode("root_scheme")
   self._root_scheme_item1 = set:getElfNode("root_scheme_item1")
   self._root_scheme_item1_date = set:getLabelNode("root_scheme_item1_date")
   self._root_scheme_item1_time = set:getLabelNode("root_scheme_item1_time")
   self._root_scheme_item1_off = set:getElfNode("root_scheme_item1_off")
   self._root_scheme_item1_off_title = set:getLabelNode("root_scheme_item1_off_title")
   self._root_scheme_item1_on = set:getElfNode("root_scheme_item1_on")
   self._root_scheme_item1_on_title = set:getLabelNode("root_scheme_item1_on_title")
   self._root_scheme_item1_on_linear = set:getLinearLayoutNode("root_scheme_item1_on_linear")
   self._root_scheme_item1_on_linear_title = set:getLabelNode("root_scheme_item1_on_linear_title")
   self._root_scheme_item1_on_linear_time = set:getTimeNode("root_scheme_item1_on_linear_time")
   self._root_scheme_item1_on_scname = set:getElfNode("root_scheme_item1_on_scname")
   self._root_scheme_item1_on_des = set:getLabelNode("root_scheme_item1_on_des")
   self._root_scheme_item1_on_linear = set:getLinearLayoutNode("root_scheme_item1_on_linear")
   self._root_scheme_item1_on_linear_title = set:getLabelNode("root_scheme_item1_on_linear_title")
   self._root_scheme_item1_on_linear_price = set:getLabelNode("root_scheme_item1_on_linear_price")
   self._root_scheme_item1_on_btnSign = set:getClickNode("root_scheme_item1_on_btnSign")
   self._root_scheme_item1_on_btnSign_title = set:getLabelNode("root_scheme_item1_on_btnSign_title")
   self._root_scheme_item1_on_date = set:getLabelNode("root_scheme_item1_on_date")
   self._root_scheme_item2 = set:getElfNode("root_scheme_item2")
   self._root_scheme_item2_date = set:getLabelNode("root_scheme_item2_date")
   self._root_scheme_item2_time = set:getLabelNode("root_scheme_item2_time")
   self._root_scheme_item2_off = set:getElfNode("root_scheme_item2_off")
   self._root_scheme_item2_off_title = set:getLabelNode("root_scheme_item2_off_title")
   self._root_scheme_item2_on = set:getElfNode("root_scheme_item2_on")
   self._root_scheme_item2_on_title = set:getLabelNode("root_scheme_item2_on_title")
   self._root_scheme_item2_on_linear = set:getLinearLayoutNode("root_scheme_item2_on_linear")
   self._root_scheme_item2_on_linear_title = set:getLabelNode("root_scheme_item2_on_linear_title")
   self._root_scheme_item2_on_linear_time = set:getTimeNode("root_scheme_item2_on_linear_time")
   self._root_scheme_item2_on_scname = set:getElfNode("root_scheme_item2_on_scname")
   self._root_scheme_item3 = set:getElfNode("root_scheme_item3")
   self._root_scheme_item3_date = set:getLabelNode("root_scheme_item3_date")
   self._root_scheme_item3_time = set:getLabelNode("root_scheme_item3_time")
   self._root_scheme_item3_off = set:getElfNode("root_scheme_item3_off")
   self._root_scheme_item3_off_title = set:getLabelNode("root_scheme_item3_off_title")
   self._root_scheme_item3_on = set:getElfNode("root_scheme_item3_on")
   self._root_scheme_item3_on_title = set:getLabelNode("root_scheme_item3_on_title")
   self._root_scheme_item3_on_linear = set:getLinearLayoutNode("root_scheme_item3_on_linear")
   self._root_scheme_item3_on_linear_title = set:getLabelNode("root_scheme_item3_on_linear_title")
   self._root_scheme_item3_on_linear_time = set:getTimeNode("root_scheme_item3_on_linear_time")
   self._root_scheme_item3_on_scname = set:getElfNode("root_scheme_item3_on_scname")
   self._root_scheme_item3_on_btnFormat = set:getClickNode("root_scheme_item3_on_btnFormat")
   self._root_scheme_item3_on_btnFormat_title = set:getLabelNode("root_scheme_item3_on_btnFormat_title")
   self._root_scheme_item3_on_des = set:getLabelNode("root_scheme_item3_on_des")
   self._root_scheme_item3_on_date = set:getLabelNode("root_scheme_item3_on_date")
   self._root_scheme_item4 = set:getElfNode("root_scheme_item4")
   self._root_scheme_item4_date = set:getLabelNode("root_scheme_item4_date")
   self._root_scheme_item4_time = set:getLabelNode("root_scheme_item4_time")
   self._root_scheme_item4_off = set:getElfNode("root_scheme_item4_off")
   self._root_scheme_item4_off_title = set:getLabelNode("root_scheme_item4_off_title")
   self._root_scheme_item4_on = set:getElfNode("root_scheme_item4_on")
   self._root_scheme_item4_on_title = set:getLabelNode("root_scheme_item4_on_title")
   self._root_scheme_item4_on_linear = set:getLinearLayoutNode("root_scheme_item4_on_linear")
   self._root_scheme_item4_on_linear_title = set:getLabelNode("root_scheme_item4_on_linear_title")
   self._root_scheme_item4_on_linear_time = set:getTimeNode("root_scheme_item4_on_linear_time")
   self._root_scheme_item5 = set:getElfNode("root_scheme_item5")
   self._root_scheme_item5_date = set:getLabelNode("root_scheme_item5_date")
   self._root_scheme_item5_time = set:getLabelNode("root_scheme_item5_time")
   self._root_scheme_item5_off = set:getElfNode("root_scheme_item5_off")
   self._root_scheme_item5_off_title = set:getLabelNode("root_scheme_item5_off_title")
   self._root_scheme_item5_on = set:getElfNode("root_scheme_item5_on")
   self._root_scheme_item5_on_title = set:getLabelNode("root_scheme_item5_on_title")
   self._root_scheme_item5_on_linear = set:getLinearLayoutNode("root_scheme_item5_on_linear")
   self._root_scheme_item5_on_linear_title = set:getLabelNode("root_scheme_item5_on_linear_title")
   self._root_scheme_item5_on_linear_time = set:getTimeNode("root_scheme_item5_on_linear_time")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DGuildBSC:onInit( userData, netData )
   print('netData:')
	print(netData)
   
   require 'LangAdapter'.selectLangkv({German=function ( ... )
      self._root_scheme_item1_on_title:setFontSize(17)
      self._root_scheme_item2_off_title:setFontSize(17)
   end})

   self:updateLayer(netData)

   Res.doActionDialogShow(self._root,function ( ... )
      -- require 'GuideHelper':check('DGuildBSC')
   end)

   self._root_close:setListener(function ( ... )
      Res.doActionDialogHide(self._root, self)
   end)

   EventCenter.addEventFunc("OnAppStatChange", function ( state )
      if state == 2 then
         self:updateLayer()
      end
   end, 'DGuildBSC')

end

function DGuildBSC:onBack( userData, netData )
	
end

function DGuildBSC:close( ... )
   EventCenter.resetGroup('DGuildBSC')
end
--------------------------------custom code-----------------------------

function DGuildBSC:updateLayer( netData )
   netData = netData or self:getNetData()
   if netData then
      self:updateTimeLine(netData.Schedule)

      if TimeManager.timeOffset(netData.Schedule.SeasonStart) > 0 then
         local SignUpFinish = TimeManager.timeOffset(netData.Schedule.SignUpFinish)
         local MatchStart   = TimeManager.timeOffset(netData.Schedule.MatchStart)
         local MatchFinish  = TimeManager.timeOffset(netData.Schedule.MatchFinish)
         
         if SignUpFinish < 0 then
            self:updateSignup(math.abs(SignUpFinish),netData.Signed)
         elseif MatchStart < 0 then
            self:updateFormating(math.abs(MatchStart))
         elseif MatchFinish < 0 then
            self:updateGaming(math.abs(MatchFinish))
         end
      else
         self:toast('没有定义的状态')
      end
   end
end

function DGuildBSC:updateTimeLine( Schedule )
   local setDateString = function ( dlabel,tlabel,date )
      
      date = TimeManager.getDateTimeLocal(date)
      local pattern = "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)"
      local runyear, runmonth, runday, runhour, runminute, runseconds = string.match(date, pattern)
      dlabel:setString(string.format(Res.locString('Guild$DateMD'),runmonth,runday))
      tlabel:setString(string.format('%s:%s',runhour,runminute))

      local func = function ( ... )
         dlabel:setString(string.format(Res.locString('Guild$DateMD'),runday,runmonth))
      end

      require 'LangAdapter'.selectLang(nil,nil,func,nil,nil,nil,nil,nil,nil,func)

   end

   setDateString(self._root_scheme_item1_date,self._root_scheme_item1_time,Schedule.SeasonStart)
   setDateString(self._root_scheme_item2_date,self._root_scheme_item2_time,Schedule.SignUpFinish)
   setDateString(self._root_scheme_item3_date,self._root_scheme_item3_time,Schedule.MatchStart)
   setDateString(self._root_scheme_item4_date,self._root_scheme_item4_time,Schedule.MatchStart)
   setDateString(self._root_scheme_item5_date,self._root_scheme_item5_time,Schedule.MatchFinish)
   
   local getFormtoDate = function ( begin,finish )
      begin = TimeManager.getDateTimeLocal(begin)
      finish = TimeManager.getDateTimeLocal(finish)
      local pattern = "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)"
      local beginyear, beginmonth, beginday, beginhour, beginminute, beginseconds = string.match(begin, pattern)

      local fyear, fmonth, fday, fhour, fminute, fseconds = string.match(finish, pattern)

      return tostring(beginmonth),tostring(beginday),tostring(fmonth),tostring(fday)
   end

   self._root_scheme_item1_on_date:setString(string.format(Res.locString('GuildBattle$signDate'),getFormtoDate(Schedule.SeasonStart,Schedule.SignUpFinish)))
   -- self._root_scheme_item3_on_date:setString(string.format(Res.locString('GuildBattle$FormatingDate'),getFormtoDate(Schedule.SignUpFinish,Schedule.MatchStart)))
   require 'LangAdapter'.selectLang(nil,nil,function ( ... )
      local bm,bd,fm,fd = getFormtoDate(Schedule.SeasonStart,Schedule.SignUpFinish)
      self._root_scheme_item1_on_date:setString(string.format(Res.locString('GuildBattle$signDate'),bd,bm,fd,fm))
   end)
   require 'LangAdapter'.selectLangkv({German=function ( ... )
   	local bm,bd,fm,fd = getFormtoDate(Schedule.SeasonStart,Schedule.SignUpFinish)
      self._root_scheme_item1_on_date:setString(string.format(Res.locString('GuildBattle$signDate'),bd,bm,fd,fm))
   end})

end

--报名
function DGuildBSC:updateSignup( seconds,Sign )
   self:setViewOn(true)

   local timenode = self._root_scheme_item1_on_linear_time
   timenode:clearListeners()
   timenode:setTimeFormat(Hour99MinuteSecond)
   timenode:setHourMinuteSecond(0,0,seconds)
   timenode:setUpdateRate(-1)
   timenode:addListener(function ( ... )
      self:setViewOn()
      self:runWithDelay(function ( ... )
         self:updateLayer(self:getNetData())
      end)
   end)

   local cguildlv = dbManager.getInfoDefaultConfig('GuildFightLevelLimit')
   local ulv = dbManager.getInfoDefaultConfig('GuildFightUnlockLv')
   cguildlv = cguildlv and cguildlv.Value or 3
   ulv = ulv and ulv.Value or 45

   self._root_scheme_item1_on_des:setString(string.format(Res.locString('Guild$BattleSCTip1'),tonumber(cguildlv),tonumber(ulv)))
   
   --没有报名时 会长/副会长
   if not Sign and GuildInfo.selfPresidentOrVicePresident() then
      self._root_scheme_item1_on_linear:setVisible(true)
      self._root_scheme_item1_on_btnSign_title:setString(Res.locString('Guild$BattleSCBtn1'))
      self._root_scheme_item1_on_btnSign:setEnabled(true)

      local db1 = dbManager.getInfoDefaultConfig('GuildFightSignCost')
      self._root_scheme_item1_on_linear_price:setString(tostring(db1 and db1.Value or '250'))
      self._root_scheme_item1_on_btnSign:setListener(function ( ... )
         self:send(netModel.getModelGuildMatchSignUp(),function ( data )
            local netData = self:getNetData()
            netData.Signed = data.D.Signed
            if data.D.Coin then
               AppData.getUserInfo().setCoin(data.D.Coin)
               require 'EventCenter'.eventInput("UpdateGoldCoin")
            end
            if data.D.Point then
               AppData.getGuildInfo().setGPoint(data.D.Point)
            end
            if netData.Signed then
               self:toast(Res.locString('Guild$BattleSignSuc'))
            end
            GBHelper.setGuildMatchSchedule(netData)
            self:updateLayer(netData)
         end,function ( ... )
            self:send(netModel.getModelGuildMatchScheduleGet(),function ( data )
               self:setNetData(data.D)
               GBHelper.setGuildMatchSchedule(data.D)
               self:updateLayer(data.D)
            end)
         end)
      end)

      self._root_scheme_item1_on_btnSign:setEnabled(AppData.getUserInfo().getLevel() >= ulv and GuildInfo.getData().Lv >= cguildlv)
   else
      self._root_scheme_item1_on_linear:setVisible(false)
      self._root_scheme_item1_on_btnSign:setEnabled(false)

      if Sign then
         self._root_scheme_item1_on_btnSign_title:setString(Res.locString('Guild$BattleSCBtn4'))
      else
         self._root_scheme_item1_on_btnSign_title:setString(Res.locString('Guild$BattleSCBtn2'))
      end
   end

end

--阵容设置
function DGuildBSC:updateFormating( seconds )
   self:setViewOn(false,false,true)

   local timenode = self._root_scheme_item3_on_linear_time
   timenode:clearListeners()
   timenode:setTimeFormat(Hour99MinuteSecond)
   timenode:setHourMinuteSecond(0,0,seconds)
   timenode:setUpdateRate(-1)
   timenode:addListener(function ( ... )
      self:setViewOn()
      self:runWithDelay(function ( ... )
         self:updateLayer(self:getNetData())
      end)
   end)

   self._root_scheme_item3_on_btnFormat:setListener(function ( ... )
      GleeCore:showLayer("DArenaBattleArray", {type = "GuildBattle"})
   end)
end

--比赛进行中
function DGuildBSC:updateGaming( seconds )
   self:setViewOn(false,false,false,true)

   local timenode = self._root_scheme_item4_on_linear_time
   timenode:clearListeners()
   timenode:setTimeFormat(Hour99MinuteSecond)
   timenode:setHourMinuteSecond(0,0,seconds)
   timenode:setUpdateRate(-1)
   timenode:addListener(function ( ... )
      self:setViewOn()
      self:send(netModel.getModelGuildMatchScheduleGet(),function ( data )
         self:setNetData(data.D)
         GBHelper.setGuildMatchSchedule(data.D)
         self:updateLayer(data.D)
      end)
   end)

end

function DGuildBSC:setViewOn( item1,item2,item3,item4,item5 )
   self._root_scheme_item1_on:setVisible(item1)
   self._root_scheme_item1_off:setVisible(not item1)
   self._root_scheme_item2_on:setVisible(item2)
   self._root_scheme_item2_off:setVisible(not item2)
   self._root_scheme_item3_on:setVisible(item3)
   self._root_scheme_item3_off:setVisible(not item3)
   self._root_scheme_item4_on:setVisible(item4)
   self._root_scheme_item4_off:setVisible(not item4)
   self._root_scheme_item5_on:setVisible(item5)
   self._root_scheme_item5_off:setVisible(not item5)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGuildBSC, "DGuildBSC")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGuildBSC", DGuildBSC)
