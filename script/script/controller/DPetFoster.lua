local Config = require "Config"
local res = require "Res"
local Res = require 'Res'
local dbManager = require "DBManager"
local gameFunc = require "AppData"
local netModel = require "netModel"
local GuideHelper = require 'GuideHelper'
local UnlockManager = require 'UnlockManager'
local Launcher = require 'Launcher'


-- Launcher.register('DPetFoster',function ( data )
--   local unlock = UnlockManager:isUnlock('lvup')
--   if unlock then
--     Launcher.Launching()
--   else
--     local msg = UnlockManager:getUnlockConditionMsg('lvup')
--     require 'UIHelper'.toast2(msg)
--     Launcher.cancel()
--   end
-- end)

local DPetFoster = class(TabDialog)

function DPetFoster:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPetFoster.cocos.zip")
    return self._factory:createDocument("DPetFoster.cocos")
end

--@@@@[[[[
function DPetFoster:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg = set:getElfNode("root_bg")
   self._root_tabs = set:getLinearLayoutNode("root_tabs")
   self._normal_v = set:getLabelNode("normal_v")
   self._pressed_v = set:getLabelNode("pressed_v")
   self._point = set:getElfNode("point")
   self._normal_v = set:getLabelNode("normal_v")
   self._pressed_v = set:getLabelNode("pressed_v")
   self._root_bgs = set:getElfNode("root_bgs")
   self._root_bgs_bg01 = set:getJoint9Node("root_bgs_bg01")
   self._root_bgs_bg02 = set:getJoint9Node("root_bgs_bg02")
   self._root_content = set:getElfNode("root_content")
   self._root_info = set:getElfNode("root_info")
   self._root_info_pet = set:getElfNode("root_info_pet")
   self._root_info_pet_pzbg = set:getElfNode("root_info_pet_pzbg")
   self._root_info_pet_icon = set:getElfNode("root_info_pet_icon")
   self._root_info_pet_pz = set:getElfNode("root_info_pet_pz")
   self._root_info_pet_property = set:getElfNode("root_info_pet_property")
   self._root_info_pet_career = set:getElfNode("root_info_pet_career")
   self._root_info_starLayout = set:getLayoutNode("root_info_starLayout")
   self._root_info_nameBg = set:getElfNode("root_info_nameBg")
   self._root_info_name = set:getLabelNode("root_info_name")
   self._root_info_QualityTitle = set:getLabelNode("root_info_QualityTitle")
   self._root_info_Quality = set:getLabelNode("root_info_Quality")
   self._root_info_LvTitle = set:getLabelNode("root_info_LvTitle")
   self._root_info_Lv = set:getLabelNode("root_info_Lv")
   self._root_info_AtkTitle = set:getLabelNode("root_info_AtkTitle")
   self._root_info_Atk = set:getLabelNode("root_info_Atk")
   self._root_info_HpTitle = set:getLabelNode("root_info_HpTitle")
   self._root_info_Hp = set:getLabelNode("root_info_Hp")
   self._root_info_petptitle = set:getLabelNode("root_info_petptitle")
   self._root_title = set:getElfNode("root_title")
   self._root_title_content = set:getLabelNode("root_title_content")
   self._root_close = set:getButtonNode("root_close")
   self._root_help = set:getButtonNode("root_help")
   self._root_btnLeft = set:getButtonNode("root_btnLeft")
   self._root_btnRight = set:getButtonNode("root_btnRight")
   self._head = set:getSimpleAnimateNode("head")
   self._suctitle = set:getElfNode("suctitle")
   self._failtitle = set:getElfNode("failtitle")
   self._shield = set:getShieldNode("shield")
   self._shield_rect = set:getRectangleNode("shield_rect")
   self._FadeIn = set:getElfAction("FadeIn")
   self._FadeOut = set:getElfAction("FadeOut")
   self._suc = set:getElfAction("suc")
   self._fail = set:getElfAction("fail")
   self._RepeatForever = set:getElfAction("RepeatForever")
--   self._@tab = set:getTabNode("@tab")
--   self._@lock = set:getClickNode("@lock")
--   self._@star = set:getElfNode("@star")
--   self._@activeEffAnim = set:getElfNode("@activeEffAnim")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DPetFoster:onInit( userData, netData )
  require 'LangAdapter'.LabelNodeAutoShrink(self._root_info_petptitle,150)
  require 'LangAdapter'.LabelNodeAutoShrink(self._root_info_AtkTitle,70)
  require 'LangAdapter'.LabelNodeAutoShrink(self._root_info_QualityTitle,70)

  self._shield:setVisible(false)

  self._Pet = (self:getUserData() and self:getUserData().pet) or nil
  if self._Pet == nil then
    local team = require 'AppData'.getTeamInfo().getTeamActive()
    self:selectPet(team.CaptainPetId)
  else
    self:selectPet(self._Pet.Id)  
  end
  
  self._Pets = (self:getUserData() and self:getUserData().pets) or nil
  self._Petids = (self:getUserData() and self:getUserData().petids) or nil

  self:initLeftRight()
  self:updateInfo()
  
	self._root_close:setListener(function ( ... )
    Res.doActionDialogHide(self._root, self)
  end)
  self:registerTabs()
  self._root_help:setListener(function ( ... )
   GleeCore:showLayer("DHelp", {type = "精灵培养"})
  end)

  self._root_btnLeft:runElfAction(self._RepeatForever:clone())
  self._root_btnRight:runElfAction(self._RepeatForever:clone())
end

function DPetFoster:onBack( userData, netData )
  self:refreshTab('back')
  self:refresRedPoint()
end

function DPetFoster:close( ... )
  GuideHelper:check('DPetFosterClose')  
  self._tabs = nil
  self._sets = nil
end

function DPetFoster:registerTabs( ... )
  
  local TLPotential = require 'TLPotential'
  self:setTabRootNode(self._root_content)


  local tab0,set0
  local tab1,set1 
  local tab2,set2
  local tab3,set3
  local tab4,set4
  local tab5,set5
  local tabs = {}
  local sets = {}
   
  -- self:registerTab('TLPotential',require 'TLPotential',tab1)
  -- self:registerTab('TLAwake',require 'TLAwake',tab2)
  -- self:registerTab('TLRebirth',require 'TLRebirth',tab3)

  local firstTab = nil
  if UnlockManager:isUnlock('lvup') then
    tab0,set0 = self:createTabSetWith('@tab',Res.locString('PetFoster$LvUp'))
    self:registerTab('TLPetUpgradeV2',require 'TLPetUpgradeV2',tab0)
    firstTab = firstTab or tab0
    tabs['TLPetUpgrade'] = tab0
    sets['TLPetUpgrade'] = set0
  end

  
  if UnlockManager:isUnlock('PetForster') then
    tab2,set2 = self:createTabSetWith('@tab',Res.locString('PetFoster$tab2'))
    self:registerTab('TLAwake',require 'TLAwake',tab2)
    firstTab = firstTab or tab2  
    GuideHelper:registerPoint('觉醒tab',set2[1])
    tabs['TLAwake']=tab2
  else
    -- tab2,set2 = self:createTabSetWith('@lock',Res.locString('PetFoster$tab2'))
    -- tab2:setListener(function ( ... )
    --   self:toast(UnlockManager:getUnlockConditionMsg('PetForster'))
    -- end)
  end
  

  if UnlockManager:isUnlock('PActive') then
    tab1, set1= self:createTabSetWith('@tab',Res.locString('PetFoster$tab1'))  
    self:registerTab('TLPotential',require 'TLPotential',tab1)
    firstTab = firstTab or tab1
    GuideHelper:registerPoint('潜力tab',set1[1])
    tabs['TLPotential'] = tab1
  else
    -- tab1, set1= self:createTabSetWith('@lock',Res.locString('PetFoster$tab1'))
    -- tab1:setListener(function ( ... )
    --   self:toast(UnlockManager:getUnlockConditionMsg('PActive'))
    -- end)
  end

  if UnlockManager:isUnlock('EvolvePet') then
    tab4,set4 = self:createTabSetWith('@tab',Res.locString('Evolution$_BTN_Evolution'))
    self:registerTab('TLPetEvolve',require 'TLPetEvolve',tab4)
    firstTab = firstTab or tab4
    GuideHelper:registerPoint('进化tab',set4[1])
    tabs['TLPetEvolve'] = tab4
    sets['TLPetEvolve'] = set4
  else
  end

  if UnlockManager:isUnlock('GemFuben') then
    tab5,set5 = self:createTabSetWith('@tab',Res.locString('Bag$TabTitleGem'))
    self:registerTab('TLPetGem',require 'TLPetGem',tab5)
    firstTab = firstTab or tab5
    GuideHelper:registerPoint('佩戴tab',set5[1])
    tabs['TLPetGem'] = tab5
  end
  
  if UnlockManager:isUnlock('PRebirth') then
    tab3,set3 = self:createTabSetWith('@tab',Res.locString('PetFoster$rebirthTitle'))
    self:registerTab('TLRebirth',require 'TLRebirth',tab3)
    firstTab = firstTab or tab3
    GuideHelper:registerPoint('重生tab',set3[1])
    tabs['TLRebirth'] = tab3
  else
    -- tab3,set3 = self:createTabSetWith('@lock',Res.locString('PetFoster$rebirthTitle'))
    -- tab3:setListener(function ( ... )
    --   self:toast(UnlockManager:getUnlockConditionMsg('PRebirth'))  
    -- end)
  end  

  local userData = self:getUserData()
  if userData and userData.tab and tabs[userData.tab] then
    firstTab = tabs[userData.tab]
  end
  firstTab:trigger(nil)

  self._root_tabs:layout()
  Res.doActionDialogShow(self._root,function ( ... )  
    GuideHelper:registerPoint('关闭',self._root_close)
    GuideHelper:check('CPetFoster')
  end)

  self._tabs = tabs
  self._sets = sets

  self:refresRedPoint()
end

--------------------------------custom code-----------------------------

function DPetFoster:updateInfo( ... )
  local nPet = self._Pet
  if nPet then
    local petFunc = gameFunc.getPetInfo()
    local itemListData = petFunc.getPetList()
    local dbPet = dbManager.getCharactor(nPet.PetId)

    if dbPet then
      self._root_info_pet_icon:setResid(res.getPetIcon(nPet.PetId))
      -- self._root_info_pet_pzbg:setResid(res.getPetIconBgByAwakeIndexN(nPet.AwakeIndex))
      self._root_info_pet_pz:setResid(res.getPetPZ(nPet.AwakeIndex))
      self._root_info_pet_property:setResid(res.getPetPropertyIcon(dbPet.prop_1,true))
      self._root_info_pet_career:setResid(res.getPetCareerIcon(dbPet.atk_method_system))

      self._root_info_starLayout:removeAllChildrenWithCleanup(true)
      
      require 'PetNodeHelper'.updateStarLayout(self._root_info_starLayout,dbPet)

      -- self._root_info_bottomBg_nameBg:setResid(res.getPetNameBg(nPet.AwakeIndex))
      -- self._root_info_name:setFontFillColor(res.getRankColorByAwake(nPet.AwakeIndex,true), true)
      self._root_info_name:setString(res.getPetNameWithSuffix(self._Pet))
      self._root_info_Quality:setString(dbPet.quality)

      local userInfo = gameFunc.getUserInfo()
      -- local levelCapTable = dbManager.getInfoRoleLevelCap(userInfo.getLevel())
      self._root_info_Lv:setString(string.format("%d/%d", nPet.Lv, dbManager.getPetLvCap(nPet)))
      self._root_info_Atk:setString(nPet.Atk)
      self._root_info_Hp:setString(nPet.Hp)

      require 'LangAdapter'.NodesPosReverse(self._root_info_LvTitle,self._root_info_Lv)
      require 'LangAdapter'.NodesPosReverse(self._root_info_AtkTitle,self._root_info_Atk)
      require 'LangAdapter'.NodesPosReverse(self._root_info_HpTitle,self._root_info_Hp)
      require 'LangAdapter'.NodesPosReverse(self._root_info_QualityTitle,self._root_info_Quality)

    end
    self:refresRedPoint()
  end
end

function DPetFoster:updatePet( nPet )
  if nPet then
    gameFunc.getPetInfo().setPet(nPet)
    gameFunc.getPetInfo().sortPetList()
    gameFunc.getPetInfo().modify()
    self:selectPet(nPet.Id)
    self:updateInfo()
    self:refreshTab()
  end
end

function DPetFoster:refresRedPoint( ... )
  local evolveenable = gameFunc.getPetInfo().satisfyAllEvolveCondition(self._Pet)
  local lvupenable   = gameFunc.getPetInfo().getPetUpgradeEnable(self._Pet)
  local set = self._sets and self._sets['TLPetUpgrade']
  if set then
    set['point']:setVisible(lvupenable)
  end
  set = self._sets and self._sets['TLPetEvolve']
  if set then
    set['point']:setVisible(evolveenable)
  end
end

function DPetFoster:createTabSetWith( nodename,tabname )
  local tab = self:createLuaSet(nodename)
  tab['normal_v']:setString(tabname)
  tab['pressed_v']:setString(tabname)
  require 'LangAdapter'.fontSize(tab['pressed_v'],nil,nil,nil,nil,20)
  require 'LangAdapter'.fontSize(tab['normal_v'],nil,nil,nil,nil,20)
  self._root_tabs:addChild(tab[1])
  return tab[1],tab
end

function DPetFoster:selectPet( PetId )
  self._Pet = gameFunc.getPetInfo().getPetWithId(PetId) 
  self:getUserData().pet = self._Pet
end

function DPetFoster:initLeftRight( ... )

  if self._Pets == nil and self._Petids then
    self._Pets = {}
    for i,v in ipairs(self._Petids) do
      table.insert(self._Pets,gameFunc.getPetInfo().getPetWithId(v))
    end
  end

  if not self._Pets or #self._Pets <= 1 then
    self._root_btnLeft:setVisible(false)
    self._root_btnRight:setVisible(false)
    return
  end

  for i,v in ipairs(self._Pets) do
    if v.Id == self._Pet.Id then
      self._selectIndex = i
      break
    end
  end
  
  self._root_btnLeft:setListener(function ( ... )
    self:selectPetIndex(self._selectIndex - 1)
  end)
  self._root_btnRight:setListener(function ( ... )
    self:selectPetIndex(self._selectIndex + 1)
    GuideHelper:check('selectPetIndex')
  end)

  GuideHelper:registerPoint('btnRight',self._root_btnRight)
end

function DPetFoster:selectPetIndex( index )
    index = (index < 1 and #self._Pets) or index
    index = (index > #self._Pets and 1) or index
    
    self:selectPet(self._Pets[index].Id)
    self:updateInfo()
    self:refreshTab()
    self._selectIndex = index
end

function DPetFoster:runShieldAction( callback )
  print('runShieldAction:')
  self._shield:setVisible(true)
  local fadein = self._FadeIn:clone()
  fadein:setListener(function ( ... )
    self._shield_rect:runElfAction(self._FadeOut:clone())
    self._shield:setVisible(false)
    return callback and callback()
  end)
  self._shield_rect:runElfAction(fadein)
end

function DPetFoster:setShiledVisible( v )
  self._shield:setVisible(v)
end

function DPetFoster:runActiveAnim( suc )
  local set = self:createLuaSet('@activeEffAnim')
  set['failtitle']:setVisible(not suc)
  set['suctitle']:setVisible(suc)
  if suc then
    set['suctitle']:setScale(0)
    set['head']:reset()
    set['head']:setLoops(1)
    set['head']:start()
    set['head']:setListener(function ( ... )
      local action = self._suc:clone()
      action:setListener(function ( ... )
        set[1]:removeFromParentAndCleanup(true)
      end)
      set['suctitle']:runElfAction(action)
    end)
  else
    set['head']:setVisible(false)
    local action = self._fail:clone()
    action:setListener(function ( ... )
      set[1]:removeFromParentAndCleanup(true)      
    end)
    set['failtitle']:setScale(0)
    set['failtitle']:runElfAction(action)
  end
  self._root:addChild(set[1])
end

function DPetFoster:setbgVisible( visible )
  self._root_bgs_bg01:setVisible(visible)
  self._root_bgs_bg02:setVisible(visible)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPetFoster, "DPetFoster")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPetFoster", DPetFoster)
