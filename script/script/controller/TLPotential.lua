local Config = require "Config"
local Config = require "Config"
local res = require "Res"
local Res = require 'Res'
local dbManager = require "DBManager"
local gameFunc = require "AppData"
local netModel = require "netModel"
local GuideHelper = require 'GuideHelper'
local UnlockManager = require 'UnlockManager'
local Launcher = require 'Launcher'

local TLPotential = class(TabLayer)

function TLPotential:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLPotential.cocos.zip")
    return self._factory:createDocument("TLPotential.cocos")
end

--@@@@[[[[
function TLPotential:onInitXML()
    local set = self._set
   self._bg1_title_linearlayout_C2 = set:getJoint9Node("bg1_title_linearlayout_C2")
   self._bg1_title_linearlayout_C2_V = set:getLabelNode("bg1_title_linearlayout_C2_V")
   self._bg1_title_linearlayout_C1 = set:getJoint9Node("bg1_title_linearlayout_C1")
   self._bg1_title_linearlayout_C1_V = set:getLabelNode("bg1_title_linearlayout_C1_V")
   self._bg1_title_linearlayout_C3 = set:getJoint9Node("bg1_title_linearlayout_C3")
   self._bg1_title_linearlayout_C3_V = set:getLabelNode("bg1_title_linearlayout_C3_V")
   self._bg1_btnActive = set:getClickNode("bg1_btnActive")
   self._bg1_btnActive_title = set:getLabelNode("bg1_btnActive_title")
   self._bg1_items_item1 = set:getElfNode("bg1_items_item1")
   self._bg1_items_item1_tab = set:getTabNode("bg1_items_item1_tab")
   self._bg1_items_item1_linearlayout_label = set:getLabelNode("bg1_items_item1_linearlayout_label")
   self._bg1_items_item1_linearlayout_C3 = set:getLabelNode("bg1_items_item1_linearlayout_C3")
   self._bg1_items_item1_suc = set:getLabelNode("bg1_items_item1_suc")
   self._bg1_items_item2 = set:getElfNode("bg1_items_item2")
   self._bg1_items_item2_tab = set:getTabNode("bg1_items_item2_tab")
   self._bg1_items_item2_linearlayout_label = set:getLabelNode("bg1_items_item2_linearlayout_label")
   self._bg1_items_item2_linearlayout_C3 = set:getLabelNode("bg1_items_item2_linearlayout_C3")
   self._bg1_items_item2_linearlayout_i2 = set:getElfNode("bg1_items_item2_linearlayout_i2")
   self._bg1_items_item2_linearlayout_C2 = set:getLabelNode("bg1_items_item2_linearlayout_C2")
   self._bg1_items_item2_suc = set:getLabelNode("bg1_items_item2_suc")
   self._bg1_items_item3 = set:getElfNode("bg1_items_item3")
   self._bg1_items_item3_tab = set:getTabNode("bg1_items_item3_tab")
   self._bg1_items_item3_linearlayout_label = set:getLabelNode("bg1_items_item3_linearlayout_label")
   self._bg1_items_item3_linearlayout_C3 = set:getLabelNode("bg1_items_item3_linearlayout_C3")
   self._bg1_items_item3_linearlayout_i2 = set:getElfNode("bg1_items_item3_linearlayout_i2")
   self._bg1_items_item3_linearlayout_C2 = set:getLabelNode("bg1_items_item3_linearlayout_C2")
   self._bg1_items_item3_suc = set:getLabelNode("bg1_items_item3_suc")
   self._bg1_items_limit = set:getLabelNode("bg1_items_limit")
   self._bg1_btnActiveAll = set:getClickNode("bg1_btnActiveAll")
   self._bg1_btnActiveAll_title = set:getLabelNode("bg1_btnActiveAll_title")
   self._activeTitle = set:getElfNode("activeTitle")
   self._linearlayout_curv = set:getLabelNode("linearlayout_curv")
   self._linearCurSucce_label = set:getLabelNode("linearCurSucce_label")
   self._linearCurSucce_v = set:getLabelNode("linearCurSucce_v")
   self._btnReset = set:getClickNode("btnReset")
   self._btnReset_title = set:getLabelNode("btnReset_title")
   self._info = set:getElfNode("info")
   self._info_atkgrow_oldv = set:getLabelNode("info_atkgrow_oldv")
   self._info_atkgrow_newv = set:getLabelNode("info_atkgrow_newv")
   self._info_hpgrow_oldv = set:getLabelNode("info_hpgrow_oldv")
   self._info_hpgrow_newv = set:getLabelNode("info_hpgrow_newv")
--   self._@unsed = set:getElfNode("@unsed")
--   self._@view = set:getElfNode("@view")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLPotential:onInit( userData, netData )
	
end

function TLPotential:onBack( userData, netData )
	
end

function TLPotential:onEnter( ... )

  
  require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['bg1_items_item3_suc'] ,250)
  require 'LangAdapter'.fontSize(self._viewSet['btnReset_title'],nil,nil,24,nil,nil,nil,nil,nil,nil,20)
  require 'LangAdapter'.fontSize(self._viewSet['bg1_btnActive_title'],nil,nil,nil,nil,nil,nil,nil,nil,nil,28)
  require 'LangAdapter'.fontSize(self._viewSet['bg1_btnActiveAll_title'],nil,nil,24,nil,20,20,20)
  require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['linearCurSucce_label'] ,110)
  require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['bg1_items_item1_linearlayout_label'],150)
  require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['bg1_items_item2_linearlayout_label'],150)
  require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['bg1_items_item3_linearlayout_label'],150)

  require 'LangAdapter'.selectLangkv({Indonesia=function ( ... )
    self._viewSet['btnReset_title']:setFontSize(23)
  end})
  self._Pet = (self._parent:getUserData() and self._parent:getUserData().pet)

   self:updateSelectLayer()
   GuideHelper:check('TLPotential')
   GuideHelper:registerPoint('激发',self._viewSet['bg1_btnActive'])
end
--------------------------------custom code-----------------------------

function TLPotential:Limit( v )
   self._viewSet['info']:setVisible(not v)
  self._viewSet['bg1_items_item1']:setVisible(not v)
  self._viewSet['bg1_items_item2']:setVisible(not v)
  self._viewSet['bg1_items_item3']:setVisible(not v)
  self._viewSet['bg1_items_limit']:setVisible(v)
  if v then
    self:updateLayer(0)
    self._viewSet['btnReset']:setEnabled(false)
    self._viewSet['bg1_btnActive']:setEnabled(false)
    self._viewSet['bg1_btnActiveAll']:setEnabled(false)
  end
  
  if v then
    if self._Pet.Star == 2 then
      self._viewSet['bg1_items_limit']:setString(res.locString('PetFoster$LIMIT_potential2'))
    else
      self._viewSet['bg1_items_limit']:setString(res.locString('PetFoster$LIMIT_potential'))
    end
  end
end

function TLPotential:selectDefualt( ... )
  self._selectMode = self._selectMode or 3

  if self._selectMode == 1 then
    self._viewSet['bg1_items_item1_tab']:trigger(nil)
  elseif self._selectMode == 2 then
    self._viewSet['bg1_items_item2_tab']:trigger(nil)
  elseif self._selectMode == 3 then
    self._viewSet['bg1_items_item3_tab']:trigger(nil)
  end
end

function TLPotential:updateSelectLayer( ... )

  local getsize = function ( size )
    print(string.format('size:(%d,%d)',size.width,size.height))
    if size and size.width < 10 then
      size.width = 15
    end
    print(string.format('size:(%d,%d)',size.width,size.height))
    return size
  end

  local userInfo = gameFunc.getUserInfo()
  self._viewSet['bg1_title_linearlayout_C1_V']:setString(res.getGoldFormat(userInfo.getGold()))
  self._viewSet['bg1_title_linearlayout_C2_V']:setString(tostring(gameFunc.getBagInfo().getItemCount(1)))
  self._viewSet['bg1_title_linearlayout_C3_V']:setString(tostring(userInfo.getCoin()))
  self._viewSet['bg1_title_linearlayout_C1']:setContentSize(getsize(self._viewSet['bg1_title_linearlayout_C1_V']:getContentSize()))
  self._viewSet['bg1_title_linearlayout_C2']:setContentSize(getsize(self._viewSet['bg1_title_linearlayout_C2_V']:getContentSize()))
  self._viewSet['bg1_title_linearlayout_C3']:setContentSize(getsize(self._viewSet['bg1_title_linearlayout_C3_V']:getContentSize()))
  local limit = self._Pet.Star == 2
  self:Limit(limit)

  local nPet = self._Pet
  if nPet and not limit then
    local dbnext = dbManager.getMotivate(nPet.Lv-nPet.Potential+1)
    self._MotivateNext = dbnext
    
    self._viewSet['bg1_items_item1_suc']:setString(string.format(res.locString('PetFoster$ActiveItemSuc'),(100*dbnext.Rate)))
    self._viewSet['bg1_items_item1_linearlayout_C3']:setString(tostring(dbnext.Stone))
    
    self._viewSet['bg1_items_item2_suc']:setString(string.format(res.locString('PetFoster$ActiveItemSuc'),(100*dbnext.GoldRate)))
    self._viewSet['bg1_items_item2_linearlayout_C3']:setString(tostring(dbnext.Stone))
    self._viewSet['bg1_items_item2_linearlayout_C2']:setString(tostring(dbnext.Gold))

    self._viewSet['bg1_items_item3_suc']:setString(string.format(res.locString('PetFoster$ActiveItemSucAdv'),100))
    self._viewSet['bg1_items_item3_linearlayout_C3']:setString(tostring(dbnext.Stone))
    self._viewSet['bg1_items_item3_linearlayout_C2']:setString(tostring(dbnext.Coin))

    local stone = gameFunc.getBagInfo().getItemCount(1)
    local coin = gameFunc.getUserInfo().getCoin()
    local gold = gameFunc.getUserInfo().getGold()

    local defaultcolor = ccc4f(1.0,0.8078,0.651,1.0)
    if stone < dbnext.Stone then
      self._viewSet['bg1_items_item1_linearlayout_C3']:setFontFillColor(res.color4F.red,true)
      self._viewSet['bg1_items_item2_linearlayout_C3']:setFontFillColor(res.color4F.red,true)
      self._viewSet['bg1_items_item3_linearlayout_C3']:setFontFillColor(res.color4F.red,true)
    else
      self._viewSet['bg1_items_item1_linearlayout_C3']:setFontFillColor(defaultcolor,true)
      self._viewSet['bg1_items_item2_linearlayout_C3']:setFontFillColor(defaultcolor,true)
      self._viewSet['bg1_items_item3_linearlayout_C3']:setFontFillColor(defaultcolor,true)
    end

    if coin < dbnext.Coin then
      self._viewSet['bg1_items_item3_linearlayout_C2']:setFontFillColor(res.color4F.red,true)
    else
      self._viewSet['bg1_items_item3_linearlayout_C2']:setFontFillColor(defaultcolor,true)
    end

    if gold < dbnext.Gold then
      self._viewSet['bg1_items_item2_linearlayout_C2']:setFontFillColor(res.color4F.red,true)
    else
      self._viewSet['bg1_items_item2_linearlayout_C2']:setFontFillColor(defaultcolor,true)
    end

    self._viewSet['bg1_items_item1_tab']:setListener(function ( )
      self._selectMode = 1
      self:updateLayer(dbnext.Grow)
    end)

    self._viewSet['bg1_items_item2_tab']:setListener(function ( )
      self._selectMode = 2
      self:updateLayer(dbnext.Grow)
    end)

    self._viewSet['bg1_items_item3_tab']:setListener(function ( )
      self._selectMode = 3
      self:updateLayer(dbnext.AdvGrow)
    end)

    self:selectDefualt()

    self._viewSet['bg1_btnActive']:setListener(function (  )

      if not self:checkMaterialEnough() then
        return
      end

      self:send(netModel.getModelPetMotivate(nPet.Id,self._selectMode == 2,self._selectMode == 3), function ( data )
        self:updateWithNetData(data)
      end)
    end)

    local viplv = require 'AppData'.getUserInfo().getVipLevel()
    local viptable = require 'vip'
    local needviplv = 0
    for i=1,#viptable do
      local v = viptable[i]
      if v.FastMotivate and v.FastMotivate == 1 then
        needviplv = v.vip
        break
      end
    end

    self._viewSet['bg1_btnActiveAll']:setListener(function ( ... )
      if viplv < needviplv then
        self:toast(string.format(Res.locString('PetFoster$Unlockoneky'),tostring(needviplv)))
        return
      end

      if not self:checkMaterialEnough() then
        return
      end

      require 'Toolkit'.useCoinConfirm(function ( ... )
        self:send(netModel.getModelPetMotivateAll(nPet.Id),function ( data )
          self:updateWithNetData(data)
        end)
      end)

    end)
    self._viewSet['bg1_btnActive']:setEnabled(nPet.Potential > 0)
    self._viewSet['bg1_btnActiveAll']:setEnabled(nPet.Potential > 0 and self._selectMode == 3)

    local aenable = viplv >= needviplv
    self._viewSet['bg1_btnActiveAll']:setVisible(aenable)
    self._viewSet['bg1_btnActive']:setPosition(ccp(aenable and 80.0 or 0,-192.0))
  end

end

function TLPotential:updateWithNetData( data )
  if data and data.D then
    --update date and refresh layer
    local callback = function ( ... )
      if data.D.Role then
         gameFunc.getUserInfo().setData(data.D.Role)
      end

      if data.D.Amount then
        local cnt = gameFunc.getBagInfo().getItemCount(1)
        gameFunc.getBagInfo().useItem(1,cnt - data.D.Amount)
      else
        gameFunc.getBagInfo().useItem(1,self._MotivateNext.Stone)
      end

      if data.D.Pet then
        self._parent:updatePet(data.D.Pet)
      end

      self._viewSet['activeTitle']:setVisible(true)
    end
    self._viewSet['activeTitle']:setVisible(false)

    callback()
    self:runWithDelay(function ( ... )
      self._parent:runActiveAnim(data.D.Success)
    end,nil,self._viewSet['bg1_items_item3'])
    -- GleeCore:showLayer('DFosterActiveResult',{suc = (data.D.Pet ~= nil),oldPet = self._Pet,newPet = data.D.Pet,callback =callback})
    
    GuideHelper:check('ActiveDone')
  end
end

function TLPotential:getGrowString( v )
  if v >= 100 then
    return string.format('%.1f',v)
  else
    return string.format('%.2f',v)
  end
end

function TLPotential:updateLayer( grow )
  
  local nPet = self._Pet
  if nPet then
    local dbPet = dbManager.getCharactor(nPet.PetId)
    local growAtk = nPet.AtkP + dbPet.atk_grow * grow
    local growHp = nPet.HpP + dbPet.hp_grow * grow
    local newatk = dbPet.atk  + growAtk*(nPet.Lv-1)
    local newhp = dbPet.hp + growHp*(nPet.Lv-1)

    self._viewSet['info_atkgrow_oldv']:setString(self:getGrowString(nPet.AtkP))
    self._viewSet['info_atkgrow_newv']:setString(self:getGrowString(growAtk))

    self._viewSet['info_hpgrow_oldv']:setString(self:getGrowString(nPet.HpP))
    self._viewSet['info_hpgrow_newv']:setString(self:getGrowString(growHp))

    -- self._viewSet['atk_oldv:setString(string.format('%d',nPet.Atk))
    -- self._viewSet['atk_newv:setString(string.format('%d',newatk))

    -- self._viewSet['hp_oldv:setString(string.format('%d',nPet.Hp))
    -- self._viewSet['hp_newv:setString(string.format('%d',newhp))

    --当前
    self._viewSet['linearlayout_curv']:setString(tostring(nPet.Potential))
    -- self._viewSet['linearCur_v:setString(string.format('%d/%d',nPet.Lv-nPet.Potential,nPet.Lv))
    self._viewSet['linearCurSucce_v']:setString(string.format('%d/%d',nPet.MotiCnt,nPet.Lv-nPet.Potential))
    self._viewSet['btnReset']:setEnabled(nPet.Lv-nPet.Potential ~= 0)
    self._viewSet['btnReset']:setListener(function ( )

      GleeCore:showLayer('DConfirmNT',{content = res.locString('PetFoster$TIP5'), callback=function ( )
        --遗忘之石
        if gameFunc.getBagInfo().getItemCount(3) < 1 then
          self:MaterialNotEnough(3)
          return
        end

        self:send(netModel.getPetResetMoti(nPet.Id), function ( data )
          if data and data.D then
            self._parent:updatePet(data.D.Pet)
            gameFunc.getBagInfo().exchangeItem(data.D.Materials)
            self:toast(Res.locString('PetFoster$pToast'))
          end
        end)            
      end})

    end)

  end

  if self._selectMode == 2 and self._MotivateNext then
    --local userInfo = gameFunc.getUserInfo()
    --self._viewSet['bg1_btnActive:setEnabled(self._MotivateNext.Gold < userInfo.getGold())
  else
    self._viewSet['bg1_btnActive']:setEnabled(true)
  end

  self._viewSet['bg1_btnActive']:setEnabled(nPet.Potential > 0)
  self._viewSet['bg1_btnActiveAll']:setEnabled(nPet.Potential > 0 and self._selectMode == 3)
end


function TLPotential:MaterialNotEnough( materialId )
  GleeCore:showLayer('DMallItemBuy',{itemId=materialId,callback=function ( count )
    self:updateSelectLayer()
  end})
end

function TLPotential:checkMaterialEnough( ... )

  if self._MotivateNext then
    local stone = gameFunc.getBagInfo().getItemCount(1)
    local coin = gameFunc.getUserInfo().getCoin()
    local gold = gameFunc.getUserInfo().getGold()

    if stone < self._MotivateNext.Stone then
      self:MaterialNotEnough(1)
      return false
    elseif self._selectMode == 3 and coin < self._MotivateNext.Coin then
      require "Toolkit".showDialogOnCoinNotEnough()
      return false
    elseif self._selectMode == 2 and gold < self._MotivateNext.Gold then
      self:toast(Res.locString('PetFoster$pToast1'))
      return false
    end

  end

  return true

end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLPotential, "TLPotential")


--------------------------------register--------------------------------
return TLPotential
