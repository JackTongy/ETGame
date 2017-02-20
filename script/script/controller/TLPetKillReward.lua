local Config = require "Config"
local dbManager = require 'DBManager'
local Res = require 'Res'
local netModel = require 'netModel'

local TLPetKillReward = class(TabLayer)

function TLPetKillReward:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLPetKillReward.cocos.zip")
    return self._factory:createDocument("TLPetKillReward.cocos")
end

--@@@@[[[[
function TLPetKillReward:onInitXML()
    local set = self._set
   self._touchLayer = set:getLuaTouchNode("touchLayer")
   self._bg = set:getJoint9Node("bg")
   self._bg_title = set:getLabelNode("bg_title")
   self._bg_from = set:getRichLabelNode("bg_from")
   self._list = set:getListNode("list")
   self._list_container_des0 = set:getElfNode("list_container_des0")
   self._list_container_des0_layout = set:getLayout2DNode("list_container_des0_layout")
   self._pet = set:getElfNode("pet")
   self._pet_pzbg = set:getElfNode("pet_pzbg")
   self._pet_icon = set:getElfNode("pet_icon")
   self._pet_pz = set:getElfNode("pet_pz")
   self._pet_property = set:getElfNode("pet_property")
   self._pet_career = set:getElfNode("pet_career")
   self._starLayout = set:getLayoutNode("starLayout")
   self._num = set:getLabelNode("num")
   self._btn = set:getButtonNode("btn")
   self._list_container_des0_content = set:getLinearLayoutNode("list_container_des0_content")
   self._list_container_des0_content_num = set:getLabelNode("list_container_des0_content_num")
   self._list_container_des0_content1 = set:getLinearLayoutNode("list_container_des0_content1")
   self._list_container_des0_content1_num = set:getLabelNode("list_container_des0_content1_num")
   self._list_container_des0_content2 = set:getLinearLayoutNode("list_container_des0_content2")
   self._list_container_des1 = set:getElfNode("list_container_des1")
   self._list_container_des1_content = set:getLinearLayoutNode("list_container_des1_content")
   self._list_container_des1_content2 = set:getLinearLayoutNode("list_container_des1_content2")
   self._list_container_des1_content2_content = set:getLabelNode("list_container_des1_content2_content")
   self._list_container_des1_content3 = set:getLinearLayoutNode("list_container_des1_content3")
   self._list_container_des1_content3_content = set:getLabelNode("list_container_des1_content3_content")
   self._list_container_des3 = set:getElfNode("list_container_des3")
   self._list_container_des3_content = set:getLinearLayoutNode("list_container_des3_content")
   self._list_container_des3_content2 = set:getLinearLayoutNode("list_container_des3_content2")
   self._list_container_des3_content2_content = set:getLabelNode("list_container_des3_content2_content")
   self._list_container_des3_content3 = set:getLinearLayoutNode("list_container_des3_content3")
   self._list_container_des3_content3_content = set:getLabelNode("list_container_des3_content3_content")
   self._list_container_des3_content4 = set:getLinearLayoutNode("list_container_des3_content4")
   self._list_container_des3_content4_content = set:getLabelNode("list_container_des3_content4_content")
   self._linear = set:getLinearLayoutNode("linear")
   self._linear_range = set:getLabelNode("linear_range")
   self._linear_content = set:getLabelNode("linear_content")
   self._bg_clipSwip_pageSwip = set:getSwipNode("bg_clipSwip_pageSwip")
   self._bg_clipSwip_pageSwip_linearlayout = set:getLinearLayoutNode("bg_clipSwip_pageSwip_linearlayout")
   self._bg_Tip = set:getLabelNode("bg_Tip")
   self._bg_pageindex = set:getLinearLayoutNode("bg_pageindex")
--   self._@view = set:getElfNode("@view")
--   self._@page = set:getElfNode("@page")
--   self._@item = set:getElfNode("@item")
--   self._@star = set:getElfNode("@star")
--   self._@star = set:getElfNode("@star")
--   self._@star = set:getElfNode("@star")
--   self._@star = set:getElfNode("@star")
--   self._@star = set:getElfNode("@star")
--   self._@star = set:getElfNode("@star")
--   self._@reward = set:getElfNode("@reward")
--   self._@point = set:getElfNode("@point")
--   self._@sp = set:getElfNode("@sp")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLPetKillReward:onInit( userData, netData )
  local db1   = dbManager.getInfoDefaultConfig('BossBattleTimes')
  self.times  = db1.Value

  self._pageview = self:createLuaSet('@page')
  self._viewSet['bg']:addChild(self._pageview[1])

  local netdata = self._parent:getNetData() 
	self._Bosses = netdata.D.Bosses

  -- self:initPages()
  -- self._viewSet['bg_clipSwip_pageSwip']:setStayIndex(0)
  self._selectIndex = 1
  self:updateLayer()
end

function TLPetKillReward:onEnter( ... )
  local netdata = self._parent:getNetData()
  local TodayBattleTimes = (netdata and netdata.D.Record and netdata.D.Record.TodayBattleTimes) or 0

  self:refresPetsLayout(self._pageview['list_container_des0_layout'])
  self._pageview['list_container_des0_content_num']:setString(tostring(TodayBattleTimes))
  self._pageview['list_container_des0_content1_num']:setString(tostring(self.times))

  local func = function ( ... )
    print('refontsize:')
    self._pageview['list_container_des0_content1_#content']:setFontSize(17)
    self._pageview['list_container_des0_content1_#1']:setFontSize(19)
    self._pageview['list_container_des1_content2_content']:setFontSize(19)
  end
  require 'LangAdapter'.selectLang(nil,nil,nil,nil,nil,func,func,nil,nil,func)
  require 'LangAdapter'.LabelNodeAutoShrink(self._pageview['list_container_des3_content3_content'],660)

  self._pageview['list']:layout()
  local des1x,des1y = self._pageview['list_container_des1_content']:getPosition()
  local size_des1c2 = self._pageview['list_container_des1_content2_content']:getContentSize()
  local size_des1c3 = self._pageview['list_container_des1_content3_content']:getContentSize()
  self._pageview['list_container_des1_content3']:setPositionY(des1y-size_des1c2.height-size_des1c3.height/2-self._pageview['list_container_des1_content']:getContentSize().height/2)
  self._pageview['list_container_des1']:setContentSize(CCSizeMake(730.0,24+size_des1c2.height+size_des1c3.height))

  local des3x,des3y = self._pageview['list_container_des3_content']:getPosition()
  local size_des3c2 = self._pageview['list_container_des3_content2_content']:getContentSize()
  local size_des3c3 = self._pageview['list_container_des3_content3_content']:getContentSize()
  local size_des3c4 = self._pageview['list_container_des3_content4_content']:getContentSize()
  local y = des3y-size_des3c2.height-size_des3c3.height/2-self._pageview['list_container_des3_content']:getContentSize().height/2
  self._pageview['list_container_des3_content3']:setPositionY(y)
  self._pageview['list_container_des3_content4']:setPositionY(y-size_des3c3.height/2)
  self._pageview['list_container_des3']:setContentSize(CCSizeMake(730.0,24+size_des3c2.height+size_des3c3.height+size_des3c4.height))

end

function TLPetKillReward:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function TLPetKillReward:updateLayer( )
  -- self:selectPage(self._selectIndex)
  self:updateRewardPage(nil,self._pageview)
end

function TLPetKillReward:updateRewardPage(  page,pageSet )  

  -- self._viewSet['bg_title']:setString(page.title)
  -- self._viewSet['bg_from']:setString(string.format(Res.locString('PetKillRank$from'),tostring(page.from)))
  -- if page.refreshDone then    
  --   return
  -- end
  -- page.refreshDone = true

  -- local bosslv = page.BossDetail.Pet.Lv
  -- local boss_active = require 'boss_active'
  -- local rewards = {}
  -- for i,v in ipairs(boss_active) do
  --   local tmp = {}
  --   tmp[1] = v.low*100
  --   tmp[2] = v.high*100
  --   tmp[3] = string.format('%dx神兽等级',v.gold)
  --   tmp[4] = string.format('神兽等级%s+%d',(v.dividend == 1 and '') or string.format('/%d',v.dividend),v.addnumber)-- math.ceil(bosslv/v.dividend) + v.addnumber
  --   table.insert(rewards,tmp)
  -- end

  -- local rewards = 
  -- {
  --   {0,5,2000,1},
  --   {5,10,6000,5},
  --   {10,20,10000,8},
  --   {20,30,20000,10},
  --   {30,40,30000,12},
  --   {40,50,40000,15},
  --   {50,100,50000,20},
  -- }

  -- pageSet['list_container_des0_content']:setString(string.format('每日挑战神兽%d次，可选择领取1个神兽碎片（点击领取）',self.times))
  -- local stonenum = ' 50+神兽等级/5'--50+math.floor(page.BossDetail.Pet.Lv/5) --2、击杀奖励，本次boss被击杀，触发BOSS方额外获得50+神兽等级/5的觉醒之石
  -- pageSet['list_container_des1_content']:setString(string.format(Res.locString('PetKillRank$RewardFormat'),stonenum))
  -- local size = pageSet['list_container_des1_content']:getContentSize()
  -- local osize = pageSet['list_container_des1']:getContentSize()
  -- pageSet['list_container_des1']:setContentSize(CCSizeMake(osize.width,size.height))

  -- local list = pageSet['list']
  -- local linear = list:getContainer()

  -- for i,v in ipairs(rewards) do
  --   local rewardSet = self:createLuaSet('@reward')
  --   linear:addChild(rewardSet[1])
  --   rewardSet['linear_range']:setString(string.format('[%d%%,%d%%]',v[1],v[2]))
  --   rewardSet['linear_content']:setString(string.format('可获得金币 %s,觉醒之石 %s',v[3],v[4]))  
  -- end
  
  -- list:layout()

end

function TLPetKillReward:refresPetsLayout( layout )

  layout:removeAllChildrenWithCleanup(true)
  
  local netdata = self._parent:getNetData()
  local TodayGet = netdata and netdata.D.Record and netdata.D.Record.TodayGet
  local TodayBattleTimes = (netdata and netdata.D.Record and netdata.D.Record.TodayBattleTimes) or 0

  local t = {243,244,245}
  for i,v in ipairs(t) do
    local itemset = self:createLuaSet('@item')
    layout:addChild(itemset[1])
    require 'PetNodeHelper'.updatePetItem(self, itemset,v)

    -- if TodayGet then
    --   itemset['btn']:setEnabled(false)
    --   itemset[1]:setOpacity(128)
    -- else

      local func
      if TodayBattleTimes < self.times then
        func = function (  )
          self:toast(string.format(Res.locString('PetKill$RewardRCond'),self.times))
        end
      elseif TodayGet then
        func = function ( ... )
          self:toast(Res.locString('PetKill$Toast1'))
        end
      else
        local callback = function ( ... )
          self:send(netModel.getModelBossReceive(v),function ( data )
            netdata.D.Record.TodayGet = true
            self:recvPetP(data)
          end)
        end

        func = function ( ... )
          local dbpet = dbManager.getCharactor(v)
          GleeCore:showLayer('DConfirmNT',{clickClose=true,content=string.format(Res.locString('PetKill$RewardRConfirm'),dbpet.name),callback=function ( ... )
            callback()
          end})
        end
      end

      itemset['btn']:setListener(func)
    end

  -- end

end

function TLPetKillReward:recvPetP( data )
  if data and data.D then
    data.D.Reward.callback = function ( ... )
      self:refresPetsLayout(self._pageview['list_container_des0_layout'])
    end
    GleeCore:showLayer('DGetReward',data.D.Reward)
    require 'AppData'.updateResource(data.D.Resource)
  end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--helper
function TLPetKillReward:addRankPageSet( index,pageSet,title,from,updatefunc,BossDetail )
  
  if self._pages == nil then
    self._pages = {}
  end

  if self._pages[index] == nil then
    self._pages[index] = {}
  end

  self._pages[index].pageSet = pageSet
  self._pages[index].title = title
  self._pages[index].from = from
  self._pages[index].updatefunc = updatefunc
  self._pages[index].BossDetail = BossDetail
end

function TLPetKillReward:getPageCount( ... )
  
  if self._pages ~= nil then
    return #self._pages
  end

  return 0

end

function TLPetKillReward:getRewardPage( index )
  
  if self._pages then
    return self._pages[index]
  end

  return nil

end

function TLPetKillReward:addPoint( index,normal,sel)

  if self._points == nil then
    self._points = {}
  end

  if self._points[index] == nil then
    self._points[index] = {}
  end

  local point = self:createLuaSet('@point')
  self._viewSet['bg_pageindex']:addChild(point[1])
  self._points[index].normal = normal
  self._points[index].sel = sel
  self._points[index].set = point
  point[1]:setResid(normal)

  local sp = self:createLuaSet('@sp')
  self._viewSet['bg_pageindex']:addChild(sp[1])
end

function TLPetKillReward:selectPoint( index )
  
  if self._points then
    for k,v in pairs(self._points) do
        if k == index then
          v.set[1]:setResid(v.sel)
        else
          v.set[1]:setResid(v.normal)
        end
    end
  end

end

function TLPetKillReward:initSwipNode( ... )
  
  self._viewSet['bg_clipSwip_pageSwip']:registerSwipeListenerScriptHandler(function (onstart, preIndex, newIndex)
    self:selectPage(newIndex+1)
  end)


  self._viewSet['bg_clipSwip_pageSwip']:clearStayPoints()
  local maxcnt = self:getPageCount()
  local pagew = 731
  local totalw = 731*maxcnt
  local firstx = totalw/2 - pagew/2
  for i=1,maxcnt do
      self._viewSet['bg_clipSwip_pageSwip']:addStayPoint(firstx,0)
      firstx = firstx - 731
  end

end

function TLPetKillReward:selectPage( index )

  local page = self:getRewardPage(index)
  page.updatefunc(self,page)

  self:selectPoint(index)
end

function TLPetKillReward:initPages( ... )
  local rankcnt = 0
  if self._Bosses ~= nil and #self._Bosses > 0 then
    rankcnt = #self._Bosses
    for i=1,#self._Bosses do
      local BossDetail = self._Bosses[i]
      local dbpet = dbManager.getCharactor(BossDetail.Pet.PetId)
      local title = tostring(dbpet.name)
      local page = self:createLuaSet('@page')
      self:addRankPageSet(i,page,title,BossDetail.CName,self.updateRewardPage,BossDetail)
      self._viewSet['bg_clipSwip_pageSwip_linearlayout']:addChild(page[1])
      self:addPoint(i,'N_TY_dian.png','N_TY_dian_sel.png') 
    end
  end

  self._viewSet['bg_clipSwip_pageSwip_linearlayout']:layout()

  self:initSwipNode()

end


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLPetKillReward, "TLPetKillReward")


--------------------------------register--------------------------------
return TLPetKillReward
