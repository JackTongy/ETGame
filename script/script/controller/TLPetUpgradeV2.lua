local Config = require "Config"
local res = require 'Res'
local Res = require 'Res'
local dbManager = require 'DBManager'
local DBManager = require 'DBManager'
local AppData = require 'AppData'
local GuideHelper = require 'GuideHelper'
local netModel = require 'netModel'

local TLPetUpgradeV2 = class(TabLayer)

function TLPetUpgradeV2:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLPetUpgradeV2.cocos.zip")
    return self._factory:createDocument("TLPetUpgradeV2.cocos")
end

--@@@@[[[[
function TLPetUpgradeV2:onInitXML()
    local set = self._set
   self._origin = set:getJoint9Node("origin")
   self._origin_name = set:getLabelNode("origin_name")
   self._origin_pet = set:getColorClickNode("origin_pet")
   self._origin_pet_pzbg = set:getElfNode("origin_pet_pzbg")
   self._origin_pet_icon = set:getElfNode("origin_pet_icon")
   self._origin_pet_pz = set:getElfNode("origin_pet_pz")
   self._origin_progress_bg = set:getElfNode("origin_progress_bg")
   self._origin_progress_newfore = set:getBarNode("origin_progress_newfore")
   self._origin_progress_fore = set:getBarNode("origin_progress_fore")
   self._result = set:getJoint9Node("result")
   self._result_name = set:getLabelNode("result_name")
   self._result_progress = set:getElfNode("result_progress")
   self._result_progress_bg = set:getElfNode("result_progress_bg")
   self._result_progress_newfore = set:getBarNode("result_progress_newfore")
   self._result_progress_fore = set:getBarNode("result_progress_fore")
   self._result_pet = set:getColorClickNode("result_pet")
   self._result_pet_pzbg = set:getElfNode("result_pet_pzbg")
   self._result_pet_icon = set:getElfNode("result_pet_icon")
   self._result_pet_pz = set:getElfNode("result_pet_pz")
   self._bottom = set:getElfNode("bottom")
   self._lvupinfo = set:getElfNode("lvupinfo")
   self._lvupinfo_lv_oldv = set:getLabelNode("lvupinfo_lv_oldv")
   self._lvupinfo_lv_newv = set:getLabelNode("lvupinfo_lv_newv")
   self._lvupinfo_atkgrow_oldv = set:getLabelNode("lvupinfo_atkgrow_oldv")
   self._lvupinfo_atkgrow_newv = set:getLabelNode("lvupinfo_atkgrow_newv")
   self._lvupinfo_hpgrow_oldv = set:getLabelNode("lvupinfo_hpgrow_oldv")
   self._lvupinfo_hpgrow_newv = set:getLabelNode("lvupinfo_hpgrow_newv")
   self._lvupinfo_btnConfirm = set:getClickNode("lvupinfo_btnConfirm")
   self._lvupinfo_btnConfirm_title = set:getLabelNode("lvupinfo_btnConfirm_title")
   self._gradeinfo = set:getElfNode("gradeinfo")
   self._gradeinfo_lvCap_label = set:getLabelNode("gradeinfo_lvCap_label")
   self._gradeinfo_lvCap_oldv = set:getLabelNode("gradeinfo_lvCap_oldv")
   self._gradeinfo_old = set:getElfNode("gradeinfo_old")
   self._gradeinfo_old_icon = set:getElfNode("gradeinfo_old_icon")
   self._gradeinfo_old_V = set:getLabelNode("gradeinfo_old_V")
   self._gradeinfo_new = set:getElfNode("gradeinfo_new")
   self._gradeinfo_new_icon = set:getElfNode("gradeinfo_new_icon")
   self._gradeinfo_new_V = set:getLabelNode("gradeinfo_new_V")
   self._gradeinfo_btnBeyond = set:getClickNode("gradeinfo_btnBeyond")
   self._gradeinfo_btnBeyond_title = set:getLabelNode("gradeinfo_btnBeyond_title")
   self._gradeinfo_lvCap_label1 = set:getLabelNode("gradeinfo_lvCap_label1")
   self._gradeinfo_lvCap_newv = set:getLabelNode("gradeinfo_lvCap_newv")
   self._list = set:getLayoutNode("list")
   self._ibg1 = set:getJoint9Node("ibg1")
   self._ibg = set:getJoint9Node("ibg")
   self._icon = set:getElfNode("icon")
   self._pz = set:getElfNode("pz")
   self._num = set:getLabelNode("num")
   self._btn = set:getButtonNode("btn")
   self._des = set:getLabelNode("des")
   self._anim = set:getSimpleAnimateNode("anim")
   self._need = set:getLabelNode("need")
   self._own = set:getLabelNode("own")
   self._maxlv = set:getJoint9Node("maxlv")
   self._maxlv_maxtip = set:getLabelNode("maxlv_maxtip")
   self._btnSkill = set:getClickNode("btnSkill")
   self._btnSkill_title = set:getLabelNode("btnSkill_title")
   self._breath = set:getElfAction("breath")
--   self._@unsed = set:getElfNode("@unsed")
--   self._@view = set:getElfNode("@view")
--   self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLPetUpgradeV2:onInit( userData, netData )
	
end

function TLPetUpgradeV2:onEnter( ... )

   require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['gradeinfo_label'],88)
   require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['gradeinfo_label1'],88)
   require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['lvupinfo_btnConfirm_title'],110)
   require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['gradeinfo_btnBeyond_title'],110)
   require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['maxlv_maxtip'],200)
   require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['gradeinfo_lvCap_label'],90)

    require 'LangAdapter'.NodesPosReverse(self._viewSet['lvupinfo_lv_#label'],self._viewSet["lvupinfo_lv_oldv"])
    require 'LangAdapter'.NodesPosReverse(self._viewSet['lvupinfo_lv_#label1'],self._viewSet["lvupinfo_lv_newv"])
    require 'LangAdapter'.NodesPosReverse(self._viewSet['lvupinfo_atkgrow_#label'],self._viewSet["lvupinfo_atkgrow_oldv"])
    require 'LangAdapter'.NodesPosReverse(self._viewSet['lvupinfo_atkgrow_#label1'],self._viewSet["lvupinfo_atkgrow_newv"])
    require 'LangAdapter'.NodesPosReverse(self._viewSet['lvupinfo_hpgrow_#label'],self._viewSet["lvupinfo_hpgrow_oldv"])
    require 'LangAdapter'.NodesPosReverse(self._viewSet['lvupinfo_hpgrow_#label1'],self._viewSet["lvupinfo_hpgrow_newv"])

    require 'LangAdapter'.LayoutChildrenReverseWithChildIfArabic(self._viewSet['gradeinfo_lvCap_oldv'])
    require 'LangAdapter'.LayoutChildrenReverseWithChildIfArabic(self._viewSet['gradeinfo_lvCap_newv'])

   self._Pet = (self._parent:getUserData() and self._parent:getUserData().pet)
   
   self:updateLayer(self._Pet)
   self._parent:setbgVisible(false)
   GuideHelper:registerPoint('升级',self._viewSet['lvupinfo_btnConfirm'])
   GuideHelper:registerPoint('超越',self._viewSet['gradeinfo_btnBeyond'])
end

function TLPetUpgradeV2:onLeave( )
   self._parent:setbgVisible(true)
end


function TLPetUpgradeV2:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function TLPetUpgradeV2:updateLayer( nPet )

   self._viewSet['origin_name']:setString(res.getPetNameWithSuffix(nPet))
   self._viewSet['result_name']:setString(res.getPetNameWithSuffix(nPet))
   self._viewSet['origin_pet_pz']:setResid(res.getPetPZ(nPet.AwakeIndex))
   self._viewSet['result_pet_pz']:setResid(res.getPetPZ(nPet.AwakeIndex))
   self._viewSet['origin_pet_icon']:setResid(res.getPetIcon(nPet.PetId))
   self._viewSet['result_pet_icon']:setResid(res.getPetIcon(nPet.PetId))

   local grade = self._Pet.Grade
  grade = ((grade == nil or grade == 0) and 1) or grade
  local gradecfg = dbManager.getPetGradeConfig(grade)
  
  local lvconfig  = (require 'PetLvConfig')
  local maxpetlv  = lvconfig[#lvconfig].Lv

  print('maxpetlv:'..maxpetlv)
  local maxlv = self._Pet.Lv == maxpetlv
  self._viewSet['maxlv']:setVisible(maxlv)
  if maxlv then
    self._viewSet['lvupinfo']:setVisible(false)
    self._viewSet['gradeinfo']:setVisible(true)
    self:updateUpgradeView(grade,gradecfg,maxlv)
    self:updateMaxLvView(grade)
  elseif self._Pet.NeedBadge then
    self._viewSet['lvupinfo']:setVisible(false)
    self._viewSet['gradeinfo']:setVisible(true)
    self:updateUpgradeView(grade,gradecfg)
  else
    self._viewSet['gradeinfo']:setVisible(false)
    self._viewSet['lvupinfo']:setVisible(true)
    self:updateLvupView(grade,gradecfg)
  end

  self:refreshSkillButton(self._Pet.Lv)
end

function TLPetUpgradeV2:updateLvupView( grade,gradecfg )
   local nPet = self._Pet

  local dbPet = dbManager.getCharactor(nPet.PetId)
  local dbnextlv = dbManager.getInfoPetLvConfig(nPet.Lv)
  local curatk = dbPet.atk  + nPet.AtkP*(nPet.Lv-1)
  local curhp = dbPet.hp + nPet.HpP*(nPet.Lv-1)
  local ex_atk = self._Pet.Atk-curatk
  local ex_hp = self._Pet.Hp-curhp
  curatk = curatk+ex_atk
  curhp = curhp+ex_hp

  local nextExp = dbnextlv.Exp - nPet.Exp
  local totallength = self._viewSet['origin_progress_bg']:getContentSize().width
  local costs = dbManager.getPetLvupCosts(dbPet.prop_1,grade)
  -- self:runbreath(self._viewSet['lvupinfo_progress_newfore'])

  local Fruits,sets = self:refreshCosts(costs)
  self._costsets = sets
  self._viewSet['lvupinfo_btnConfirm']:setListener(function ( ... )
    self:send(netModel.getPetUseFruit(self._Pet.Id,Fruits),function ( data )
      GuideHelper:check('upLvDone')
      self:runUpgradeAnim(self._costsets,function ( ... )
        if data.D.Fruits then
          AppData.getBagInfo().updateItemsCount(data.D.Fruits)
        end
        local guidenotify = function ( ... )
          GuideHelper:check('AnimtionEnd')
          self._parent:updatePet(data.D.Pet)
        end
        GleeCore:showLayer('DUpgradeLvEffect',{lv=true,oldpet=self._Pet,newpet=data.D.Pet,callback=guidenotify})
      end,nil,data.D.Pet.Lv-self._Pet.Lv)
    end)
  end)

  local totalExp = 0 --本次能提供的经验
  if Fruits then
    for k,v in pairs(Fruits) do
      local dbm = dbManager.getInfoMaterial(tonumber(k))
      totalExp = totalExp + (dbm.effects[1] * v)
    end
  end
  
  self._viewSet['lvupinfo_btnConfirm']:setEnabled(totalExp > 0)
  if totalExp <= 0 then
    -- self._viewSet['lvupinfo_btnConfirm']:setListener(function ( ... )
    --   self:toast('果实不足，无法升级哦')
    -- end)
  end

  local newlv = nPet.Lv--当前可提供的经验所能达到达到的等级
  local tagetlv = nPet.Lv
  local nextExp0 = nextExp
  while (totalExp-nextExp0 >= 0) do
    newlv = newlv + 1
    local nextlvcfg = dbManager.getInfoPetLvConfig(newlv)
    if nextlvcfg == nil then
      break
    end
    
    nextExp0 = nextExp0 + nextlvcfg.Exp
  end

  local newExp = nPet.Exp + totalExp --本次有的经验 不大于下级经验和
  newExp = (newExp > dbnextlv.Exp and dbnextlv.Exp) or newExp

  local tmplv = math.max(tagetlv,newlv)
  local newatk = dbPet.atk + nPet.AtkP*(tmplv-1)
  local newhp = dbPet.hp + nPet.HpP*(tmplv-1)
  newatk = newatk + ex_atk
  newhp = newhp + ex_hp

  self._viewSet['lvupinfo_lv_oldv']:setString(tostring(nPet.Lv))
  self._viewSet['lvupinfo_lv_newv']:setString(tostring(tmplv))
  self._viewSet['lvupinfo_atkgrow_oldv']:setString(string.format('%d',curatk))
  self._viewSet['lvupinfo_atkgrow_newv']:setString(string.format('%d',newatk))
  self._viewSet['lvupinfo_hpgrow_oldv']:setString(string.format('%d',curhp))
  self._viewSet['lvupinfo_hpgrow_newv']:setString(string.format('%d',newhp))

  local new_length  = totallength*math.min(newExp/dbnextlv.Exp,1)
  local fore_length = totallength*nPet.Exp/dbnextlv.Exp
  self._viewSet['result_progress_newfore']:setLength(new_length,false)
  self._viewSet['result_progress_fore']:setLength(fore_length,false)
  self._viewSet['origin_progress_fore']:setLength(totallength*nPet.Exp/dbnextlv.Exp,false)
  self._viewSet['result_progress_fore']:setVisible(not (new_length > 0 and fore_length > new_length))
  self:runbreath(self._viewSet['result_progress_newfore'])
  self._viewSet['gradeinfo_btnBeyond']:setListener(function ( ... )
     self:toast(string.format(Res.locString('PetFoster$beyondCond'),tostring(gradecfg.PetLvCap)))
  end)
  
end

function TLPetUpgradeV2:updateMaxLvView( grade )
  local nPet = self._Pet
  local dbPet = dbManager.getCharactor(nPet.PetId)
  local curatk = self._Pet.Atk
  local curhp = self._Pet.Hp

  local totallength = self._viewSet['origin_progress_bg']:getContentSize().width
  self._viewSet['lvupinfo_lv_oldv']:setString(tostring(nPet.Lv))
  self._viewSet['lvupinfo_lv_newv']:setString(tostring(nPet.Lv))
  self._viewSet['result_progress_newfore']:setLength(totallength,false)
  self._viewSet['result_progress_fore']:setLength(totallength,false)
  self._viewSet['origin_progress_fore']:setLength(totallength,false)
  self._viewSet['lvupinfo_atkgrow_oldv']:setString(string.format('%d',curatk))
  self._viewSet['lvupinfo_atkgrow_newv']:setString(string.format('%d',curatk))
  self._viewSet['lvupinfo_hpgrow_oldv']:setString(string.format('%d',curhp))
  self._viewSet['lvupinfo_hpgrow_newv']:setString(string.format('%d',curhp))

  local costs = dbManager.getPetLvupCosts(dbPet.prop_1,grade)
  self:refreshCosts(costs,true)
end

function TLPetUpgradeV2:checkPetUpgradeGuide( ... )
  
  if GuideHelper:inGuide('GCfg06') then
    return
  end

  local key = 'Step111'
  if self._Pet.NeedBadge and not AppData.getNapkinInfo().isUsed(key) then
    self:send(netModel.getModelRoleUseNapkin(key),function ( data )
      AppData.getNapkinInfo().setValue(key,true)
      AppData.updateResource(data.D.Rs)
      self:updateLayer(self._Pet)
      GuideHelper:startGuide('GCfg07')
    end)
  end
end

function TLPetUpgradeV2:updateUpgradeView(grade,gradecfg,maxlv)

   self:checkPetUpgradeGuide()
   self._costsets = self:refreshUpgradeCost(gradecfg)
   self._viewSet['gradeinfo_btnBeyond']:setListener(function ( ... )
    self:send(netModel.getPetUseBadge(self._Pet.Id),function ( data )
      GuideHelper:check('UpgradeDone')
      self:runUpgradeAnim(self._costsets,function() 
        AppData.updateResource({Role=data.D.Role})
        AppData.getBagInfo().updateItemCount(data.D.Badge)
        GleeCore:showLayer('DUpgradeLvEffect',{grade=true,oldpet=self._Pet,newpet=data.D.Pet})
        self._parent:updatePet(data.D.Pet)
      end, nil)
      
    end)
   end)
   
   self._viewSet['gradeinfo_old_V']:setString(gradecfg.Name)
   self._viewSet['gradeinfo_lvCap_oldv']:setString(tostring(gradecfg.PetLvCap))
   require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['gradeinfo_old_V'],60)
   require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['gradeinfo_new_V'],60)
   
   local totallength = self._viewSet['origin_progress_bg']:getContentSize().width
   self._viewSet['origin_progress_fore']:setLength(totallength,false)

   local ngradecfg = dbManager.getPetGradeConfig(grade + 1)
   if ngradecfg then
     self._viewSet['gradeinfo_new_V']:setString(ngradecfg.Name)
     self._viewSet['gradeinfo_lvCap_newv']:setString(tostring(ngradecfg.PetLvCap))
   end
   self._viewSet['result_progress_fore']:setLength(totallength,false)
   self._viewSet['result_progress_newfore']:setLength(0,false)
   
   self._viewSet['gradeinfo_btnBeyond']:setEnabled(not maxlv)
   self._viewSet['gradeinfo_old_icon']:setResid(Res.getGradeIcon(grade))
   if maxlv then
      self._viewSet['gradeinfo_btnBeyond']:setEnabled(false)
      -- self._viewSet['gradeinfo_btnBeyond']:setListener(function ( ... )
      --    self:toast('精灵已达最高等级上限，无法再超越了哦')
      -- end)
      return
   end
   
   local dbm = dbManager.getInfoMaterial(gradecfg.BadgeId)
   local cnt = AppData.getBagInfo().getItemCount(gradecfg.BadgeId)

   local userInfo = AppData.getUserInfo()
   local RoleLv = userInfo.getLevel()
   local golden = AppData.getUserInfo().getGold() >= gradecfg.Gold
   local badgeen = cnt >= gradecfg.BadgeAmt
   local lven = RoleLv >= gradecfg.RoleLv

   if not golden or not badgeen then
      self._viewSet['gradeinfo_btnBeyond']:setEnabled(false)
      -- self._viewSet['gradeinfo_btnBeyond']:setListener(function ( ... )
      --    self:toast('所需不足，无法超越哦')
      -- end)
   end
   --
   self._viewSet['gradeinfo_new_icon']:setResid(Res.getGradeIcon(grade+1))
   if not lven then
      self._viewSet['gradeinfo_btnBeyond']:setListener(function ( ... )
         self:toast(string.format(Res.locString('PetFoster$beyonCond1'),gradecfg.RoleLv))
      end)
   end
   -- self._viewSet['lvupinfo_btnConfirm']:setListener(function ( ... )
   --    self:toast('需要超越等级上限,才能继续升级哦')
   -- end)
end

function TLPetUpgradeV2:refreshUpgradeCost(gradecfg)
   local list = self._viewSet['list']
  list:removeAllChildrenWithCleanup(true)

  local set1,set2
  for i=1,6 do
   local itemset = self:createLuaSet('@item')
   list:addChild(itemset[1])
   if i == 1 then
      set1 = itemset
   elseif i == 2 then
      set2 = itemset
   end
  end

   local dbm = dbManager.getInfoMaterial(gradecfg.BadgeId)
   if dbm == nil then
    return
  end
   local cnt = AppData.getBagInfo().getItemCount(gradecfg.BadgeId)

   local userInfo = AppData.getUserInfo()
   local golds = AppData.getUserInfo().getGold()
   local golden = golds >= gradecfg.Gold

   set1['pz']:setResid(Res.getMaterialIconFrame(dbm.color))
   set1['icon']:setResid(Res.getMaterialIcon(gradecfg.BadgeId))
   set1['need']:setString(dbm.name)
   set1['own']:setString(string.format('%d/%d',cnt,gradecfg.BadgeAmt))
   if cnt == 0 then
      set1['des']:setString(Res.locString('PetFoster$uTip1'))
      self:runbreath(set1['des'])
   end
   self:textcolor(cnt >= gradecfg.BadgeAmt,set1['own'])
   self:textcolor(cnt >= gradecfg.BadgeAmt,set1['need'])
   
   set1['btn']:setListener(function ( ... )
      GleeCore:showLayer("DMaterialDetail", {materialId = gradecfg.BadgeId,needAmount=gradecfg.BadgeAmt})   
   end)

   set2['pz']:setResid('N_ZB_biankuang0.png')
   set2['icon']:setResid('TY_jinbi_da.png')
   set2['need']:setString(Res.locString('Global$Gold'))
   set2['own']:setString(string.format('%d',gradecfg.Gold))
   self:textcolor(golds >= gradecfg.Gold,set2['own'])
   self:textcolor(golds >= gradecfg.Gold,set2['need'])

  require 'LangAdapter'.LabelNodeAutoShrink(set1['des'],75)
  require 'LangAdapter'.LabelNodeAutoShrink(set1['need'],75)
  require 'LangAdapter'.LabelNodeAutoShrink(set1['own'],75)

  require 'LangAdapter'.LabelNodeAutoShrink(set2['des'],75)
  require 'LangAdapter'.LabelNodeAutoShrink(set2['need'],75)
  require 'LangAdapter'.LabelNodeAutoShrink(set2['own'],75)

   if set1 then
      GuideHelper:registerPoint('果实',set1['btn'])
    end
    
  require 'LangAdapter'.LabelNodeAutoShrink(set1['need'],80)
   return {set1,set2}
end

function TLPetUpgradeV2:textcolor( enough,node )
   if not enough then
      node:setFontFillColor(Res.color4F.red,true)
   else
      node:setFontFillColor(ccc4f(0.996078,0.945098,0.815686,1.0),true)
   end   
end

function TLPetUpgradeV2:refreshCosts(costs,maxlv)
  local Fruits = {}
  local sets = {}
  local emptysets = {}
  local list = self._viewSet['list']
  local firstset
  list:removeAllChildrenWithCleanup(true)

  local index = 1
  local additemset = function ( itemset )
   list:addChild(itemset[1])
   index = index+1
  end

  for i=1,6 do
    local itemset = self:createLuaSet('@item')
    local Fruit = self:refreshItem(itemset,costs[i],maxlv)

    if Fruit and Fruit.cnt > 0 then
      Fruits[Fruit.Mid]=Fruit.cnt
      table.insert(sets,itemset)
      firstset = firstset or itemset
    end

    if Fruit and Fruit.Amt <= 0 then
      table.insert(emptysets,itemset)
    else
      additemset(itemset)
      firstset = firstset or itemset
    end
  end

  for k,v in pairs(emptysets) do
    additemset(v)
  end

  list:layout()
  
  if firstset then
    GuideHelper:registerPoint('果实',firstset['btn'])
  end

  return Fruits,sets
end

function TLPetUpgradeV2:runbreath( node )
  local arr = CCArray:create()
  arr:addObject(CCFadeTo:create(0.65,60))
  arr:addObject(CCFadeTo:create(0.65,255))
  local seq = CCSequence:create(arr)
  if node then
    node:runElfAction(CCRepeatForever:create(seq))
  end
end

function TLPetUpgradeV2:refreshItem( set,v,maxlv )
  require 'LangAdapter'.LabelNodeAutoShrink(set['des'],75)
  require 'LangAdapter'.LabelNodeAutoShrink(set['need'],75)
  require 'LangAdapter'.LabelNodeAutoShrink(set['own'],75)
  
  if v and set then
    local getcntdes = function ( v )
      local cnt = AppData.getBagInfo().getItemCount(v.Mid)
      local des = ''
      local Fruits = self._Pet.Fruits
      
      local alreadycost = 0
      if Fruits then
        alreadycost = Fruits[tostring(v.Mid)] or 0
      end
  
      if alreadycost == v.Amt or maxlv then
        des = Res.locString('PetFoster$uTip2')
      elseif cnt == 0 and alreadycost < v.Amt then
        des = Res.locString('PetFoster$uTip1')
        self:runbreath(set['des'])
      end

      local Amt = (maxlv and 0) or (v.Amt - alreadycost)
      return cnt,des,Amt
    end

    local dbm = dbManager.getInfoMaterial(v.Mid)
    set['icon']:setResid(Res.getMaterialIcon(v.Mid))
    set['pz']:setResid(Res.getMaterialIconFrame(dbm.color))

    local cnt,des,Amt = getcntdes(v)
    set['btn']:setListener(function ( ... )
      GleeCore:showLayer("DMaterialDetail", {materialId = v.Mid,needAmount=Amt})
    end)

    -- set['num']:setString(string.format('%d/%d',cnt,Amt))
    set['need']:setString(string.format(Res.locString('PetFoster$uneed'),tostring(Amt)))
    set['own']:setString(string.format(Res.locString('PetFoster$uown'),tostring(cnt)))
    set['des']:setString(des)
    local visible = Amt > 0-- and not maxlv
    set['num']:setVisible(visible)
    set['des']:setVisible(visible)
    set['btn']:setVisible(visible)
    set['pz']:setVisible(visible)
    set['icon']:setVisible(visible)
    set['need']:setVisible(visible)
    set['own']:setVisible(visible)

    return {Mid=tostring(v.Mid),cnt=math.min(cnt,Amt),Amt=Amt}
  end
end


function TLPetUpgradeV2:runUpgradeAnim( sets,callback,anim,lvcnt )
  self._parent:setShiledVisible(true)
  local node = self._viewSet['list']
  if sets then
   local delay = 0
   local lastv = sets[#sets]    
   for i,v in ipairs(sets) do
   self:runWithDelay(function ( ... )
     v['anim']:setVisible(true)
     v['anim']:setLoops(1)
     v['anim']:reset()
     v['anim']:start()
     self:playEffect('ui_sfx_reforge')
   end,delay,node)
   delay = delay + i*0.1
   end

   lastv['anim']:setListener(function ( ... )
      self._parent:runShieldAction(callback)
      self:playEffect('ui_sfx_petup_done')
   end)

  elseif anim then
    anim:setVisible(true)
    anim:setLoops(1)
    anim:reset()
    anim:start()
    anim:setListener(function ( ... )
      self._parent:runShieldAction(callback)
    end)
  end
end

function TLPetUpgradeV2:playEffect( soundname )
  require 'framework.helper.MusicHelper'.playEffect(string.format('raw/%s.mp3',tostring(soundname)))
end

function TLPetUpgradeV2:refreshSkillButton( petLv )
  local petneedlv = 60
  local enable = require 'UserInfo'.getLevel() >= 55
  local petenable = petLv >= petneedlv
  
  local pos = enable and ccp(-17.0,-182.0) or ccp(112,-182.0)
  self._viewSet['lvupinfo_btnConfirm']:setPosition(pos)
  self._viewSet['gradeinfo_btnBeyond']:setPosition(pos)
  self._viewSet['btnSkill']:setVisible(enable and require 'UnlockManager':isOpen('skillbook'))
  self._viewSet['btnSkill']:setListener(function ( ... )
    if petenable then
      GleeCore:showLayer('DPetSkillFoster',{Pet=self._Pet,callback=function ( npet )
        self._parent:updatePet(npet)
      end})
    else
      self:toast(string.format(Res.locString('PetFoster$SkillBookUnlock'),petneedlv))
    end
    
  end)
  
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLPetUpgradeV2, "TLPetUpgradeV2")


--------------------------------register--------------------------------
return TLPetUpgradeV2
