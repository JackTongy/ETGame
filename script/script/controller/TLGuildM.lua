local Config = require "Config"
local AppData = require 'AppData'
local Res = require 'Res'
local netModel = require 'netModel'
local BroadCastInfo = require 'BroadCastInfo'
local TLGuildM = class(TabLayer)
local DBManager = require 'DBManager'
local eventCenter = require 'EventCenter'

function TLGuildM:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLGuildM.cocos.zip")
    return self._factory:createDocument("TLGuildM.cocos")
end

--@@@@[[[[
function TLGuildM:onInitXML()
	local set = self._set
    self._info = set:getElfNode("info")
    self._info_btnedit = set:getClickNode("info_btnedit")
    self._info_icon = set:getElfNode("info_icon")
    self._info_icon_bg = set:getElfNode("info_icon_bg")
    self._info_icon_icon = set:getElfNode("info_icon_icon")
    self._info_icon_pz = set:getElfNode("info_icon_pz")
    self._info_namelv = set:getLabelNode("info_namelv")
    self._info_btnChangeName = set:getClickNode("info_btnChangeName")
    self._info_rank = set:getLinearLayoutNode("info_rank")
    self._info_rank_V = set:getLabelNode("info_rank_V")
    self._info_dona = set:getLinearLayoutNode("info_dona")
    self._info_dona_V = set:getLabelNode("info_dona_V")
    self._info_mem = set:getLinearLayoutNode("info_mem")
    self._info_mem_title = set:getLabelNode("info_mem_title")
    self._info_mem_V = set:getLabelNode("info_mem_V")
    self._info_power = set:getLinearLayoutNode("info_power")
    self._info_power_V = set:getLabelNode("info_power_V")
    self._info_notice = set:getLabelNode("info_notice")
    self._info_memitem = set:getElfNode("info_memitem")
    self._info_memitem_icon = set:getElfNode("info_memitem_icon")
    self._info_memitem_num = set:getLinearLayoutNode("info_memitem_num")
    self._info_memitem_num_V = set:getLabelNode("info_memitem_num_V")
    self._info_memitem_point = set:getElfNode("info_memitem_point")
    self._info_memitem_btn = set:getButtonNode("info_memitem_btn")
    self._info_memitem_tip = set:getLabelNode("info_memitem_tip")
    self._info_battle = set:getElfNode("info_battle")
    self._info_battle_icon = set:getElfNode("info_battle_icon")
    self._info_battle_time = set:getLinearLayoutNode("info_battle_time")
    self._info_battle_time_V = set:getTimeNode("info_battle_time_V")
    self._info_battle_btn = set:getButtonNode("info_battle_btn")
    self._info_mydona = set:getLinearLayoutNode("info_mydona")
    self._info_mydona_title = set:getLabelNode("info_mydona_title")
    self._info_mydona_V = set:getLabelNode("info_mydona_V")
    self._sign = set:getElfNode("sign")
    self._sign_light = set:getElfNode("sign_light")
    self._sign_icon = set:getElfNode("sign_icon")
    self._sign_btn = set:getClickNode("sign_btn")
    self._oper = set:getElfNode("oper")
    self._oper_btn1 = set:getClickNode("oper_btn1")
    self._oper_btn1_title = set:getLabelNode("oper_btn1_title")
    self._oper_btn2 = set:getClickNode("oper_btn2")
    self._oper_btn2_title = set:getLabelNode("oper_btn2_title")
    self._oper_btn3 = set:getClickNode("oper_btn3")
    self._oper_btn3_title = set:getLabelNode("oper_btn3_title")
    self._RepeatForever = set:getElfAction("RepeatForever")
--    self._@unused = set:getElfNode("@unused")
--    self._@view = set:getElfNode("@view")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLGuildM:onInit( userData, netData )

   
   require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['info_mem_title'],70)
   require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['info_mydona_title'],90)
   require 'LangAdapter'.fontSize(self._viewSet['oper_btn1_title'],nil,nil,22)
   require 'LangAdapter'.fontSize(self._viewSet['oper_btn2_title'],nil,nil,22)
   require 'LangAdapter'.fontSize(self._viewSet['oper_btn3_title'],nil,nil,22)
   require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['sign_btn_#label'],110)
   self._viewSet['oper_btn1']:setListener(function ( ... )
      GleeCore:showLayer('DGuildDonate')
   end)

   self._viewSet['info_memitem_btn']:setListener(function ( ... )
      GleeCore:showLayer('DGuildMember')
   end)

   self._viewSet['info_battle_btn']:setListener(function ( ... )
      -- self:toast(Res.locString('Guild$battleToast1'))
      if not require 'UnlockManager':isOpen('GuildBattle') then
            self:toast(Res.locString('Explore$_Tips'))
            return    
      end

      local callback = function ( ... )
         GleeCore:showLayer('DGuild')
      end
      GleeCore:pushController("CGBMain", {callback=callback}, nil, Res.getTransitionFade())
   end)
   self._viewSet['info_battle_time']:setVisible(false) 

  if require 'AccountHelper'.isItemOFF('PetName') then
    self._viewSet['info_battle']:setVisible(false)
  end
end

function TLGuildM:onBack( userData, netData )
	
end

function TLGuildM:onEnter( ... )
   self:updateLayer()

  eventCenter.resetGroup('TLGuildM') 
  eventCenter.addEventFunc("EventGuildApply", function ( data )
    self._viewSet['info_memitem_point']:setVisible(BroadCastInfo.get('guild_apply')) 
  end, "TLGuildM")

  eventCenter.addEventFunc("EventGuildRename", function ( data )
  	 local guild = AppData.getGuildInfo().getData()
    self._viewSet['info_namelv']:setString(string.format('%s Lv.%d',guild.Title,guild.Lv))
  end, "TLGuildM")
end

function TLGuildM:onRelease( ... )
  eventCenter.resetGroup('TLGuildM')
end
--------------------------------custom code-----------------------------

function TLGuildM:updateLayer( ... )
   local guild = AppData.getGuildInfo().getData()
   if guild == nil then
    return
   end
   local meminfo = AppData.getGuildInfo().getGuildMember()
   local ranks = AppData.getGuildInfo().getRanks()
   local lvcfg = DBManager.getGuildlv(guild.Lv)

   local memcnt = string.format('%s/%s',tostring(guild.Number),tostring(lvcfg.number))

   self._viewSet['info_namelv']:setString(string.format('%s Lv.%d',guild.Title,guild.Lv))
   self._viewSet['info_rank_V']:setString(tostring(ranks.Top))
   self._viewSet['info_dona_V']:setString(tostring(guild.Point))
   self._viewSet['info_mem_V']:setString(memcnt)
   self._viewSet['info_power_V']:setString(tostring(guild.Power))
   local notice = (string.len(tostring(guild.Des)) == 0 and Res.locString('Guild$noticedefault')) or tostring(guild.Des)
   self._viewSet['info_notice']:setString(notice)
   self._viewSet['info_memitem_num_V']:setString(memcnt)
   self._viewSet['info_battle_time_V']:setHourMinuteSecond(0,0,0)
   self._viewSet['info_battle_time_V']:setUpdateRate(0)
   self._viewSet['info_mydona_V']:setString(tostring(meminfo.Point))
   self._viewSet['sign_btn']:setListener(function ( ... )
      self:send(netModel.getModelGuildMemberSign(),function ( data )
         
         -- if data.D.Reward then
         --    GleeCore:showLayer('DGetReward',data.D.Reward)
         -- end

         local incgold = AppData.getUserInfo().getGold()
         AppData.getGuildInfo().addMPoint(data.D.MPoint)
         AppData.getGuildInfo().addGPoint(data.D.GPoint)
         AppData.updateResource(data.D.Resource)
         require 'EventCenter'.eventInput("UpdateGoldCoin")
         meminfo.Sign = true
         incgold = AppData.getUserInfo().getGold()-incgold

         self:toast(string.format(Res.locString('Guild$toastSign'),tostring(data.D.MPoint),tostring(incgold)))
         self:updateLayer()
         eventCenter.eventInput('RedPointGuild')
      end)
   end)

   self._viewSet['oper_btn1']:setEnabled(not meminfo.Donate)
   if guild.SignTimes >= lvcfg.dttimes then
    self._viewSet['oper_btn1']:setListener(function ( ... )
      self:toast(Res.locString('Guild$DonateLimit'))
    end)
   end

   self._viewSet['sign_btn']:setEnabled(not meminfo.Sign)
   self:lightAction(not meminfo.Sign)

   self._viewSet['oper_btn2']:setListener(function ( ... )
      local temp = {}
      temp.mailType = "MailSend"
      temp.guildId = meminfo.Gid
      temp.title = Res.locString("Mail$MailGuildSendAll")
      temp.titleReal = string.format(Res.locString("Mail$MailFrom"), AppData.getUserInfo().getName())
      GleeCore:showLayer("DMailDetail", temp)
   end)

   self:updateLayerWithJob(guild)
   require 'Toolkit'.setClubIcon(self._viewSet['info_icon_icon'],guild.Pic)

   self._viewSet['info_memitem_tip']:setVisible(AppData.getGuildInfo().getElectionState() == 2)

	self._viewSet['info_btnChangeName']:setVisible(AppData.getGuildInfo().selfPresident())
   self._viewSet['info_btnChangeName']:setListener(function ( ... )
   	GleeCore:showLayer("DClubCreate", {IsChangeName = true})
   end)
end

function TLGuildM:updateLayerWithJob( guild )
  self._viewSet['info_memitem_point']:setVisible(BroadCastInfo.get('guild_apply'))
   if AppData.getGuildInfo().selfPresident() then
      self._viewSet['info_btnedit']:setVisible(true)--修改公会公告
      self._viewSet['info_btnedit']:setListener(function ( ... )
         GleeCore:showLayer('DGuildSetting',{callback=function ( ... )
            self:updateLayer()
         end})
      end)
      self._viewSet['oper_btn3_title']:setString(Res.locString('Guild$disband'))
      self._viewSet['oper_btn3']:setListener(function ( ... )
         local callback = function ( ... )
            self:send(netModel.getModelGuildDisband(),function ( data )
               local guildinfo = AppData.getGuildInfo()
               guildinfo:setData(nil)
               guildinfo.setGuildMember(data.D.Member)
               self:toast(Res.locString('Guild$toast4'))
               self._parent:close()
            end)
         end
         
         GleeCore:showLayer('DConfirmNT',{content=Res.locString('Guild$SidbandTip'),callback=callback})
      end)
   else
      self._viewSet['info_btnedit']:setVisible(false)
      self._viewSet['oper_btn3_title']:setString(Res.locString('Guild$btnLeave'))
      self._viewSet['oper_btn3']:setListener(function ( ... )
         local callback = function ( ... )
            self:send(netModel.getModelGuildMemberLeave(),function ( data )
               self:toast(Res.locString('Guild$toast5'))
               local guildinfo = AppData.getGuildInfo()
               guildinfo:setData(nil)
               guildinfo.setGuildMember(data.D.Member)
               self._parent:close() 
            end)
         end

         local tip = Res.locString('Guild$MemberLeave')
         local mem = AppData.getGuildInfo().getGuildMember()

         if mem and mem.LeaveTotal > 0 then
          local hour = 24+mem.LeaveTotal*6
          tip = string.gsub(tip,'24',tostring(hour))
         end
         GleeCore:showLayer('DConfirmNT',{content=tip,callback=callback})
      end)
   end
end

function TLGuildM:lightAction( enable )
   if enable then
      local action = CCRepeatForever:create(CCRotateBy:create(4,360))
      self._viewSet['sign_light']:runAction(action)
   else
      self._viewSet['sign_light']:stopAllActions()      
   end
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLGuildM, "TLGuildM")


--------------------------------register--------------------------------
return TLGuildM
