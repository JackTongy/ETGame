local Config = require "Config"
local Res = require 'Res'
local netModel = require 'netModel'
local dbManager = require 'DBManager'
local AppData = require 'AppData'

local TLPetKillRank = class(TabLayer)

function TLPetKillRank:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLPetKillRank.cocos.zip")
    return self._factory:createDocument("TLPetKillRank.cocos")
end

--@@@@[[[[
function TLPetKillRank:onInitXML()
    local set = self._set
   self._touchLayer = set:getLuaTouchNode("touchLayer")
   self._bg = set:getJoint9Node("bg")
   self._bg_title = set:getLabelNode("bg_title")
   self._bg_from = set:getRichLabelNode("bg_from")
   self._bg_clipSwip_pageSwip = set:getSwipNode("bg_clipSwip_pageSwip")
   self._bg_clipSwip_pageSwip_linearlayout = set:getLinearLayoutNode("bg_clipSwip_pageSwip_linearlayout")
   self._bg_list = set:getListNode("bg_list")
   self._bg = set:getElfNode("bg")
   self._rank = set:getLabelNode("rank")
   self._name = set:getLabelNode("name")
   self._score = set:getLabelNode("score")
   self._icon = set:getElfNode("icon")
   self._selfRank = set:getElfNode("selfRank")
   self._selfRank_bg = set:getElfNode("selfRank_bg")
   self._selfRank_fore = set:getElfNode("selfRank_fore")
   self._selfRank_rank = set:getLabelNode("selfRank_rank")
   self._selfRank_name = set:getLabelNode("selfRank_name")
   self._selfRank_score = set:getLabelNode("selfRank_score")
   self._selfRank_icon = set:getElfNode("selfRank_icon")
   self._bg_pageindex = set:getLinearLayoutNode("bg_pageindex")
--   self._@view = set:getJoint9Node("@view")
--   self._@pageRankList = set:getElfNode("@pageRankList")
--   self._@itemRank = set:getElfNode("@itemRank")
--   self._@point = set:getElfNode("@point")
--   self._@sp = set:getElfNode("@sp")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLPetKillRank:onInit( userData, netData )
	self._Bosses = self._parent:getNetData().D.Bosses
  self:initPages()
  self._viewSet['bg_clipSwip_pageSwip']:setStayIndex(0)
  self._selectIndex = 1
  self:updateLayer()
end

function TLPetKillRank:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function TLPetKillRank:initPages( ... )
  
  local rankcnt = 0
  if self._Bosses ~= nil and #self._Bosses > 0 then
    rankcnt = #self._Bosses
    for i=1,#self._Bosses do
      local BossDetail = self._Bosses[i]
      local dbpet = dbManager.getCharactor(BossDetail.Pet.PetId)
      local title = tostring(dbpet.name)
      local rankpage = self:createLuaSet('@pageRankList')
      self:addRankPageSet(i,rankpage,title,BossDetail.CName,self.updateRankPage,BossDetail)
      self._viewSet['bg_clipSwip_pageSwip_linearlayout']:addChild(rankpage[1])
      self:addPoint(i,'N_TY_dian.png','N_TY_dian_sel.png') 
    end
  end

  self._viewSet['bg_clipSwip_pageSwip_linearlayout']:layout()

  self:initSwipNode()

end

function TLPetKillRank:updateLayer( )
  self:selectPage(self._selectIndex)
end

function TLPetKillRank:selectPage( index )

  local page = self:getRankPage(index)
  page.updatefunc(self,page)

  self:selectPoint(index)
end

function TLPetKillRank:updateRankPage( page)

  self._viewSet['bg_title']:setString(page.title)
  self._viewSet['bg_from']:setString(string.format(Res.locString('PetKillRank$from'),tostring(page.from)))

  if page.refreshDone then    
    return
  end

  page.refreshDone = true
  local list = page.pageSet['bg_list']
  list:getContainer():removeAllChildrenWithCleanup(true)
  page.pageSet['selfRank']:setVisible(false)
  local updatelist = function ( ranks )
    for i,v in ipairs(ranks) do
      local set = self:createLuaSet('@itemRank')
      self:refreshCell(set,v,i,page.BossDetail,page.pageSet)
      list:getContainer():addChild(set[1])    
    end
    
    list:layout()
  end

  if page.Ranks == nil then
    self:send(netModel.getModelBossRank(page.BossDetail.Bid),function ( data )
      page.Ranks = data.D.Ranks
      if page.Ranks then
        updatelist(data.D.Ranks)
      end  
    end)
  else
    updatelist(page.Ranks)
  end

end

function TLPetKillRank:refreshCell( set,rank,i,BossDetail,pageSet )
  local selfname = AppData.getUserInfo().getName()
  local isself = selfname == rank.Name
  if isself then
    if i <= 3 then
      pageSet['selfRank_icon']:setResid(string.format('paiming_tubiao%d.png',i))
    end
    pageSet['selfRank_name']:setString(tostring(rank.Name))
    pageSet['selfRank_rank']:setString(string.format('NO.%d',i))
    pageSet['selfRank_score']:setString(string.format('%d(%.2f%%)',rank.Ht,100*rank.Ht/BossDetail.Pet.HpMax))
    pageSet['selfRank_fore']:setVisible(true)
    pageSet['selfRank']:setVisible(true)
  end

  if isself and i > 10 then
    return nil
  end

  if i <= 3 then
    set['icon']:setResid(string.format('paiming_tubiao%d.png',i))
  end
  set['name']:setString(rank.Name)
  set['rank']:setString(string.format('NO.%d',i))
  set['score']:setString(string.format('%d(%.2f%%)',rank.Ht,100*rank.Ht/BossDetail.Pet.HpMax))
  set['bg']:setVisible(i%2 ~= 0)

end

--helper
function TLPetKillRank:addRankPageSet( index,pageSet,title,from,updatefunc,BossDetail )
  
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

function TLPetKillRank:getPageCount( ... )
  
  if self._pages ~= nil then
    return #self._pages
  end

  return 0

end

function TLPetKillRank:getRankPage( index )
  
  if self._pages then
    return self._pages[index]
  end

  return nil

end

function TLPetKillRank:addPoint( index,normal,sel)

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

function TLPetKillRank:selectPoint( index )
  
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

function TLPetKillRank:initSwipNode( ... )
  
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


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLPetKillRank, "TLPetKillRank")


--------------------------------register--------------------------------
return TLPetKillRank
