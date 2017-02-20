local Config = require "Config"
local res = require "Res"
local Res = require 'Res'
local dbManager = require "DBManager"
local gameFunc = require "AppData"
local netModel = require "netModel"
local GuideHelper = require 'GuideHelper'
local UnlockManager = require 'UnlockManager'
local Launcher = require 'Launcher'
local AppData = require "AppData"
local netModel = require "netModel"

local TLAwake = class(TabLayer)

function TLAwake:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLAwake.cocos.zip")
    return self._factory:createDocument("TLAwake.cocos")
end

--@@@@[[[[
function TLAwake:onInitXML()
    local set = self._set
   self._bg1_btnActive = set:getClickNode("bg1_btnActive")
   self._bg1_tip = set:getLabelNode("bg1_tip")
   self._bg1_items_label = set:getLabelNode("bg1_items_label")
   self._bg1_items_linearlayout = set:getLinearLayoutNode("bg1_items_linearlayout")
   self._bg1_items_linearlayout_item1 = set:getElfNode("bg1_items_linearlayout_item1")
   self._bg1_items_linearlayout_item1_pzbg = set:getElfNode("bg1_items_linearlayout_item1_pzbg")
   self._bg1_items_linearlayout_item1_iconPet = set:getElfNode("bg1_items_linearlayout_item1_iconPet")
   self._bg1_items_linearlayout_item1_icon = set:getElfNode("bg1_items_linearlayout_item1_icon")
   self._bg1_items_linearlayout_item1_pz = set:getElfNode("bg1_items_linearlayout_item1_pz")
   self._bg1_items_linearlayout_item1_name = set:getLabelNode("bg1_items_linearlayout_item1_name")
   self._bg1_items_linearlayout_item1_btn = set:getButtonNode("bg1_items_linearlayout_item1_btn")
   self._bg1_items_linearlayout_item2 = set:getElfNode("bg1_items_linearlayout_item2")
   self._bg1_items_linearlayout_item2_icon = set:getElfNode("bg1_items_linearlayout_item2_icon")
   self._bg1_items_linearlayout_item2_name = set:getLabelNode("bg1_items_linearlayout_item2_name")
   self._bg1_items_linearlayout_item2_btn = set:getButtonNode("bg1_items_linearlayout_item2_btn")
   self._bg1_items_limit = set:getLabelNode("bg1_items_limit")
   self._bg1_items_star6pet = set:getLayoutNode("bg1_items_star6pet")
   self._pzbg = set:getElfNode("pzbg")
   self._iconPet = set:getElfNode("iconPet")
   self._icon = set:getElfNode("icon")
   self._pz = set:getElfNode("pz")
   self._name = set:getLabelNode("name")
   self._btn = set:getButtonNode("btn")
   self._icon = set:getElfNode("icon")
   self._name = set:getLabelNode("name")
   self._btn = set:getButtonNode("btn")
   self._bg1_title_linearlayout_C1 = set:getJoint9Node("bg1_title_linearlayout_C1")
   self._bg1_title_linearlayout_C1_V = set:getLabelNode("bg1_title_linearlayout_C1_V")
   self._bg1_title_linearlayout_C2 = set:getJoint9Node("bg1_title_linearlayout_C2")
   self._bg1_title_linearlayout_C2_V = set:getLabelNode("bg1_title_linearlayout_C2_V")
   self._bg1_title = set:getLabelNode("bg1_title")
   self._bg1_rolelv = set:getLinearLayoutNode("bg1_rolelv")
   self._bg1_rolelv_v = set:getLabelNode("bg1_rolelv_v")
   self._arrow = set:getElfNode("arrow")
   self._label = set:getLabelNode("label")
   self._skillDes = set:getListNode("skillDes")
   self._skillDes_container_content = set:getRichLabelNode("skillDes_container_content")
   self._old = set:getElfNode("old")
   self._old_pzbg = set:getElfNode("old_pzbg")
   self._old_icon = set:getElfNode("old_icon")
   self._old_pz = set:getElfNode("old_pz")
   self._old_step = set:getLabelNode("old_step")
   self._new = set:getElfNode("new")
   self._new_pzbg = set:getElfNode("new_pzbg")
   self._new_icon = set:getElfNode("new_icon")
   self._new_pz = set:getElfNode("new_pz")
   self._new_step = set:getLabelNode("new_step")
   self._atk = set:getLinearLayoutNode("atk")
   self._atk_cur = set:getLabelNode("atk_cur")
   self._atk_add = set:getLabelNode("atk_add")
   self._hp = set:getLinearLayoutNode("hp")
   self._hp_cur = set:getLabelNode("hp_cur")
   self._hp_add = set:getLabelNode("hp_add")
--   self._@unsed = set:getElfNode("@unsed")
--   self._@view = set:getElfNode("@view")
--   self._@itemcost = set:getElfNode("@itemcost")
--   self._@itemgold = set:getElfNode("@itemgold")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLAwake:onInit( userData, netData )
	
end

function TLAwake:onEnter( ... )
  
  require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['label'],180)
  if not self.norefresh then
    self:updateLayer()
  end
  self.norefresh = false
  GuideHelper:check('TabAwake')
end

function TLAwake:onBack( userData, netData )
	
end

function TLAwake:onRelease( ... )
  self._chooseinfo = nil
end
--------------------------------custom code-----------------------------

function TLAwake:updateLayer( ... )
  self._Pet = (self._parent:getUserData() and self._parent:getUserData().pet)
  self.dbPet = dbManager.getCharactor(self._Pet.PetId)
  local dbcur = dbManager.getAwake(self._Pet.AwakeIndex,self._Pet.Star,self.dbPet.quality)
  local dbnext = dbManager.getNextAwake(self._Pet.AwakeIndex,self._Pet.Star,self.dbPet.quality)
  local ismax = dbnext == nil
  self._selectPet = nil
  self._selectPets = nil
  self:updateLeft(ismax,dbcur,dbnext,self._Pet)
  self:updateRight(ismax,dbcur,dbnext,self._Pet)

  require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['bg1_items_linearlayout_item1_name'],120)
  require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['bg1_items_linearlayout_item2_name'],120)
end

function TLAwake:updateLeft( maxawake,dbcur,dbnext,nPet)
  self._viewSet['old_pzbg']:setResid(res.getPetIconBg(nPet))
  self._viewSet['old_pz']:setResid(res.getPetPZ(nPet.AwakeIndex))
  self._viewSet['old_icon']:setResid(res.getPetIcon(nPet.PetId))
  -- self._viewSet['old_step']:setFontFillColor(res.getRankColorByAwake(nPet.AwakeIndex), true)
  if dbcur and dbcur.Suffix > 0 then
    self._viewSet['old_step']:setString(string.format('%s+%d',nPet.Name,dbcur.Suffix))
  else
    self._viewSet['old_step']:setString(nPet.Name)
  end

  self._viewSet['new_pzbg']:setResid(res.getPetIconBg(AppData.getPetInfo().getPetInfoByPetId( nPet.PetId, nPet.AwakeIndex + 1 )))
  self._viewSet['new_pz']:setResid(res.getPetPZ(nPet.AwakeIndex+1))
  self._viewSet['new_icon']:setResid(res.getPetIcon(nPet.PetId))
  -- self._viewSet['new_step']:setFontFillColor(res.getRankColorByAwake(nPet.AwakeIndex+1), true)
  if dbnext and dbnext.Suffix > 0 then
    self._viewSet['new_step']:setString(string.format('%s+%d',nPet.Name,dbnext.Suffix))
  else
    self._viewSet['new_step']:setString(nPet.Name)
  end

  self._viewSet['label']:setVisible(not maxawake)
  self._viewSet['skillDes']:setVisible(not maxawake)
  self._viewSet['atk']:setVisible(not maxawake)
  self._viewSet['hp']:setVisible(not maxawake)
  if not maxawake then
    local charactor = dbManager.getCharactor(nPet.PetId)
    self._subtitle = nil
    self._subdes = nil
    self._viewSet['label']:setPosition(ccp(-169,-104))
    if dbcur and dbcur.unlockcount < dbnext.unlockcount then
      --有技能解锁
      self._subtitle = res.locString('PetFoster$UnlockSkill')
      self._viewSet['label']:setString(self._subtitle)
      local skillid = charactor.abilityarray[dbnext.unlockcount]
      local skillinfo = dbManager.getInfoSkill(skillid)
      self._subdes = string.format('[color=fef1d0ff]%s[/color] %s',skillinfo.name,skillinfo.skilldes)
      self._viewSet['skillDes_container_content']:setString(self._subdes)
      self._viewSet['skillDes']:setVisible(true)
      self._viewSet['atk']:setVisible(false)
      self._viewSet['hp']:setVisible(false)
      require 'LangAdapter'.nodePos(self._viewSet['label'],nil,nil,nil,nil,ccp(-169,-70))
      require 'LangAdapter'.nodePos(self._viewSet['skillDes'],nil,nil,nil,nil,ccp(-81,-149))
    elseif dbnext.Suffix == 0 and dbnext.damage > 0 then
      --有技能加强
      local skillid = charactor.skill_id
      local skillinfo = dbManager.getInfoSkill(skillid)
      self._subtitle = res.locString('PetFoster$INCSkillEFF')
      local subdes = string.format('%s%d%%',self._subtitle,dbnext.damage*100)
      self._subdes = string.format('[color=fef1d0ff]%s[/color] %s %s',skillinfo.name,'',subdes)--skillinfo.skilldes
      self._viewSet['label']:setString(self._subtitle)
      self._viewSet['skillDes_container_content']:setString(self._subdes)
      self._viewSet['skillDes']:setVisible(true)
      self._viewSet['atk']:setVisible(false)
      self._viewSet['hp']:setVisible(false)
      require 'LangAdapter'.nodePos(self._viewSet['label'],nil,nil,nil,nil,ccp(-169,-70))
      require 'LangAdapter'.nodePos(self._viewSet['skillDes'],nil,nil,nil,nil,ccp(-81,-149))
    else
      --属性提升
      self._subtitle = res.locString('PetFoster$propertyUP')
      self._viewSet['label']:setString(self._subtitle)  
      self._viewSet['skillDes']:setVisible(false)
      self._viewSet['atk']:setVisible(true)
      self._viewSet['hp']:setVisible(true)
      local raise = dbnext.Raise - ((dbcur and dbcur.Raise) or 0)
      local hpadd = charactor.hp_grow*raise
      local atkadd = charactor.atk_grow*raise
      self._viewSet['hp_cur']:setString(tostring(nPet.Hp))
      self._viewSet['hp_add']:setString(string.format('+%d',hpadd))
      self._viewSet['atk_cur']:setString(tostring(nPet.Atk))
      self._viewSet['atk_add']:setString(string.format('+%d',atkadd))
      
    end
  end
end

function TLAwake:updateRight( maxawake,dbcur,dbnext,nPet)
  
  local userInfo = AppData.getUserInfo()
  local bagInfo = AppData.getBagInfo()
  local stoneCnt = bagInfo.getItemCount(42)
  local dbstone = dbManager.getInfoMaterial(42)

  self._viewSet['bg1_title_linearlayout_C2_V']:setString(tostring(userInfo.getGold()))
  self._viewSet['bg1_title_linearlayout_C1_V']:setString(tostring(stoneCnt))
  self._viewSet['bg1_title_linearlayout_C1']:setContentSize(self._viewSet['bg1_title_linearlayout_C1_V']:getContentSize())
  self._viewSet['bg1_title_linearlayout_C2']:setContentSize(self._viewSet['bg1_title_linearlayout_C2_V']:getContentSize())
  local resenough = true
  local ghostenough = true

  self._viewSet['bg1_items_linearlayout']:setVisible(not maxawake)
  self._viewSet['bg1_items_star6pet']:setVisible(false)
  if not maxawake then
    if dbnext.CostGold ~= 0 then
      --消耗金币
      self._viewSet['bg1_items_linearlayout_item2_name']:setString(string.format('%s x%d',res.locString('Global$Gold'),dbnext.CostGold))
    end
    if dbnext.CostGold > userInfo.getGold() then
      resenough = false
      self._viewSet['bg1_items_linearlayout_item2_name']:setFontFillColor(res.color4F.red,true)  
    else
      self._viewSet['bg1_items_linearlayout_item2_name']:setFontFillColor(ccc4f(1.0,0.663,0.267,1.0),true)
    end

    self._viewSet['bg1_items_linearlayout_item1_icon']:setVisible(false)

    if dbnext.CostPetLimit and dbnext.CostPetLimit == 1 then
      
      local AwakeCost = self:getAwakeCost(self.dbPet.AwakeCost,dbnext.Grade)
      resenough = self:selectCostPet(nil,AwakeCost,dbnext.CostGold) and resenough
    
    elseif dbnext.CostStarLv and type(dbnext.CostStarLv) == 'table' then
      -- 消耗某星级精灵一只
      resenough = self:selectCostPet(dbnext.CostStarLv,nil,dbnext.CostGold) and resenough
      
    elseif dbnext.CostSamePet ~= 0 then
      -- 消耗相同精灵一只
      local enough,orgpetid = self:selectCostPet(nil,nPet.PetId)
      resenough = enough and resenough

      if not enough then
        self._viewSet['bg1_items_linearlayout_item1_btn']:setListener(function ( ... )
          local pet = AppData.getPetInfo().getPetInfoByPetId(orgpetid)
          GleeCore:showLayer("DPetDetailV",{PetInfo = pet})
        end)
      else
        self._viewSet['bg1_items_linearlayout_item1_btn']:setListener(function ( ... )
          local param = {}
          param.needRemove = self._needRemove
          param.funcChosePet = function ( newPetId )
            self._selectPet = AppData.getPetInfo().getPetWithId(newPetId)
            self:refreshSelectPetItem()
            return true
          end
          param.lowup = true
          self:gotoChose(param)
        end)
      end

    elseif dbnext.ghost ~= 0 then
      
      self._viewSet['bg1_items_linearlayout_item1_icon']:setVisible(true)
      local dbm = dbManager.getInfoMaterial(42)
      if dbm then
        self._viewSet['bg1_items_linearlayout_item1_pz']:setResid(Res.getMaterialIconFrame(dbm.color))
      end
      self._viewSet['bg1_items_linearlayout_item1_name']:setString(string.format('%s x%d',dbstone.name,dbnext.ghost))
      if dbnext.ghost > stoneCnt then
        resenough = false
        ghostenough = false
        self._viewSet['bg1_items_linearlayout_item1_name']:setFontFillColor(res.color4F.red,true)  
      else
        self._viewSet['bg1_items_linearlayout_item1_name']:setFontFillColor(ccc4f(1.0,0.663,0.267,1.0),true)  
      end
  
      self._viewSet['bg1_items_linearlayout_item1_btn']:setListener(function ( ... )
        GleeCore:showLayer('DMaterialDetail',{materialId=42,needAmount=dbnext.ghost})  
      end)

    end

    self._viewSet['bg1_btnActive']:setListener(function ( ... )
      self:clickAwake(dbnext)
    end)


    self._viewSet['bg1_tip']:setString(self:getTip(dbcur,dbnext,nPet))

  end

  self._viewSet['bg1_items_limit']:setVisible(maxawake) 
  if maxawake then
    local tip = res.locString('PetFoster$LIMIT')
    if nPet.Star < 4 then
      tip = string.format(res.locString('PetFoster$StarNoAwake'),res.Num[nPet.Star])
    end
    self._viewSet['bg1_items_limit']:setString(tip)
    self._viewSet['bg1_tip']:setString('')
  end
  self._viewSet['bg1_items_label']:setVisible(not maxawake)
  self._viewSet['bg1_btnActive']:setEnabled(not maxawake and resenough)--(resenough or not ghostenough)  )
  -- if not ghostenough then
  --   self._viewSet['bg1_btnActive']:setListener(function ( ... )
  --     GleeCore:showLayer("DMallItemBuy", {itemId=42})    
  --   end)
  -- end

  if dbnext then
    self._viewSet['bg1_rolelv_v']:setString(string.format('Lv.%s',tostring(dbnext.Rolelv)))
    local userlv = AppData.getUserInfo().getLevel()
    if userlv < dbnext.Rolelv then
      self._viewSet['bg1_rolelv_v']:setFontFillColor(res.color4F.red,true)
    else
      self._viewSet['bg1_rolelv_v']:setFontFillColor(ccc4f(1.0,0.8078,0.651,1.0),true)
    end

    self._viewSet['bg1_rolelv']:setVisible(dbnext.Rolelv > 1 and not maxawake)
    if dbnext.Rolelv > 1 then
      self._viewSet['bg1_rolelv']:setPosition(ccp(2.9999847,-171.38123))
    end
  end

  if not maxawake and resenough then
    GuideHelper:registerPoint('觉醒',self._viewSet['bg1_btnActive'])
  else
    GuideHelper:unregisterPoint('觉醒')
  end

  local realAwake = res.getRealAwake(nPet.AwakeIndex)
  
  if realAwake > 0 then
    self._viewSet['bg1_title']:setString(string.format(res.locString('Pet$_awakeDes'),res.Num[realAwake]))--setResid(string.format('JLXQ_JX_wenzi_%d.png',realAwake))
  else
    self._viewSet['bg1_title']:setString(res.locString('PetFoster$Awake0'))--setResid('JLXQ_JX_wenzi.png')
  end

  require 'LangAdapter'.LabelNodeAutoShrink(self._viewSet['bg1_title'],300)
end

--helper
function TLAwake:selectCostPet( star,PetId,gold )

  local petInfo = AppData.getPetInfo()
  local trainInfo = AppData.getTrainInfo()
  local teamInfo = AppData.getTeamInfo()
  local partnerInfo = AppData.getPartnerInfo()
  local exploreinfo = AppData.getExploreInfo()
  local pet
  self._needRemove = {}
  
  self._viewSet['bg1_items_linearlayout_item1_iconPet']:setOpacity(255)

  local getStarPetCnt = function ( star,exceptIds )
    return petInfo.getPetByCondition(function ( v )
      local inexcepts = false
      if exceptIds then
        for i,vexc in ipairs(exceptIds) do
          if vexc == v.Id then
            inexcepts = true
          end
        end
      end
      
      if (v.Star == star and v.Id ~= self._Pet.Id and not inexcepts and not teamInfo.isInTeam(v.Id) and not trainInfo.isPetInTrain(v.Id) and not partnerInfo.isInPartner(v.Id)) and not exploreinfo.petInExploration(v.Id) then
        return true
      else
        table.insert(self._needRemove,v.Id)
        return false
      end
    end)
  end

  local count = 0
  if star and #star > 1 then
    local notenough = false
    local petids = {}
    local selectPets = {}
    for i,v in ipairs(star) do
      count = getStarPetCnt(v,petids)
      if count > 0 then
        local pet = petInfo.getPetLow(nil,petids,v)
        table.insert(selectPets,pet)
        table.insert(petids,pet.Id)
      end  
    end
    self:refreshSelect6StarPetItem(selectPets,petids,gold,star)
  elseif star then
    star = star[1]
    count = getStarPetCnt(star)
    if count ~= 0 then
      self._selectPet = petInfo.getPetLow(nil,{self._Pet.Id},star)
      self:refreshSelectPetItem()
    else
      self._viewSet['bg1_items_linearlayout_item1_name']:setString(string.format(Res.locString('PetFoster$petcost'),res.Num[star]))
      self._viewSet['bg1_items_linearlayout_item1_name']:setFontFillColor(Res.color4F.red,true)
    end

  elseif PetId and type(PetId) == 'table' then

    local foundinPets = function ( t,id )
      if t then
        for i,v in ipairs(t) do
          if v and type(v) == 'table' and v.Id == id then
            return true
          end
        end
      end
      return false
    end

    local selectPets = {}
    local petids = {}
    local enough = true
    for i,pid in ipairs(PetId) do
      local petids = dbManager.getSkinPetIds(pid)
      local needRemove = {}
      
      count = petInfo.getPetByCondition(function ( v )
        if (table.find(petids,v.PetId) and v.Id ~= self._Pet.Id and not teamInfo.isInTeam(v.Id) and not trainInfo.isPetInTrain(v.Id) and not partnerInfo.isInPartner(v.Id)) and not exploreinfo.petInExploration(v.Id) and not foundinPets(selectPets,v.Id) then
          return true
        else
          table.insert(needRemove,v.Id)
          return false
        end
      end)

      if count ~= 0 then
        local selectpet = petInfo.getLowEvoveLevel(petInfo.getPetsByPetIds(petids,needRemove),{pid})
        table.insert(selectPets,selectpet)
        table.insert(petids,selectpet.Id)
        self:setNeedRemoves(pid,needRemove)
      else
        table.insert(selectPets,0)
        table.insert(petids,0)
        enough = false
      end
    end
    self:refreshSelect6StarPetItem2(selectPets,petids,gold,PetId)
    count = (enough and 1) or 0

  elseif PetId then
    --进化线上的精灵都可以为觉醒材料
    --getpetlow 加入skin_id相同的精灵，evove_level低的优先
    --有多个时精灵材料为可选
    local petids = dbManager.getSkinPetIds(PetId)

    count = petInfo.getPetByCondition(function ( v )
      if (table.find(petids,v.PetId) and v.Id ~= self._Pet.Id and not teamInfo.isInTeam(v.Id) and not trainInfo.isPetInTrain(v.Id) and not partnerInfo.isInPartner(v.Id)) and not exploreinfo.petInExploration(v.Id) then
        return true
      else
        table.insert(self._needRemove,v.Id)
        return false
      end
    end)
    if count ~= 0 then
      local pets = petInfo.getPetsByPetIds(petids,self._needRemove)
      self._selectPet = petInfo.getLowEvoveLevel(pets,{self._Pet.Id})
      self:refreshSelectPetItem()
    else
      local pet = dbManager.getCharactor(PetId)
      pet = dbManager.getSkinPetOrg(pet.skin_id)
      self._viewSet['bg1_items_linearlayout_item1_name']:setString(string.format('%sx1',pet.name))
      self._viewSet['bg1_items_linearlayout_item1_name']:setFontFillColor(Res.color4F.red,true)
      self._viewSet['bg1_items_linearlayout_item1_iconPet']:setResid(res.getPetIcon(pet.id))
      self._viewSet['bg1_items_linearlayout_item1_iconPet']:setOpacity(128)
      self._viewSet['bg1_items_linearlayout_item1_pz']:setResid('N_ZB_biankuang0.png')
      return count > 0,pet.id
    end
  end

  if count == 0 then
    -- self._viewSet['bg1_items_linearlayout_item1_pzbg']:setResid('PZ0_bg.png')
    self._viewSet['bg1_items_linearlayout_item1_iconPet']:setResid('PZ_dianjixuanze.png')
    self._viewSet['bg1_items_linearlayout_item1_pz']:setResid('N_ZB_biankuang0.png')
    self._viewSet['bg1_items_linearlayout_item1_icon']:setVisible(false)
    self._viewSet['bg1_items_linearlayout_item1_btn']:setListener(function ( ... )
      self:toast(Res.locString('PetFoster$Toast1'))
    end)
  end

  return count > 0

end

function TLAwake:refreshSelectPetItem( )
  
  if self._selectPet then
    -- self._viewSet['bg1_items_linearlayout_item1_pzbg']:setResid(res.getPetIconBgByAwakeIndex(self._selectPet.AwakeIndex))
    self._viewSet['bg1_items_linearlayout_item1_iconPet']:setResid(res.getPetIcon(self._selectPet.PetId))
    self._viewSet['bg1_items_linearlayout_item1_pz']:setResid(res.getPetPZ(self._selectPet.AwakeIndex))
    self._viewSet['bg1_items_linearlayout_item1_icon']:setVisible(false)
    self._viewSet['bg1_items_linearlayout_item1_name']:setString(string.format('%sx1',self._selectPet.Name))
    self._viewSet['bg1_items_linearlayout_item1_name']:setFontFillColor(ccc4f(1.0,0.663,0.267,1.0),true)  
    self._viewSet['bg1_items_linearlayout_item1_btn']:setListener(function ( ... )
      local param = {}
      param.needRemove = self._needRemove
      -- param.selectPetID = self._selectPet.Id
      param.funcChosePet = function ( newPetId )
        self._selectPet = AppData.getPetInfo().getPetWithId(newPetId)
        self:refreshSelectPetItem()
        return true
      end
      param.lowup = true
      self:gotoChose(param)
    end)

  end

end

function TLAwake:refreshSelect6StarPetItem2( selectPets,petids,CostGold,AwakeCost)
  self._selectPets = selectPets
  self._viewSet['bg1_items_linearlayout']:setVisible(false)
  self._viewSet['bg1_items_star6pet']:setVisible(true)
  self._viewSet['bg1_items_star6pet']:removeAllChildrenWithCleanup(true)

  local replaceFunc = function ( pets,i,newPetId )
    local newpet = AppData.getPetInfo().getPetWithId(newPetId)
    table.remove(pets,i)
    table.insert(pets,i,newpet)
    local newpetids = {}
    for k,v in pairs(pets) do
      if v and v ~= 0 then
        table.insert(newpetids,i,v.Id)
      end
    end
    return newpetids
  end

  for i=1,#AwakeCost do
    local v = selectPets[i]
    local needRemove = self:getNeedRemoves(AwakeCost[i])
    local costset = self:createLuaSet('@itemcost')
    self._viewSet['bg1_items_star6pet']:addChild(costset[1])
    if v and v ~= 0 then
      costset['iconPet']:setResid(res.getPetIcon(v.PetId))
      costset['pz']:setResid(res.getPetPZ(v.AwakeIndex))
      costset['icon']:setVisible(false)
      costset['name']:setString(string.format('%sx1',v.Name))
      costset['name']:setFontFillColor(ccc4f(1.0,0.663,0.267,1.0),true)  
      costset['btn']:setListener(function ( ... )
        local param = {}
        param.needRemove = needRemove
        param.funcChosePet = function ( newPetId )
          petids = replaceFunc(selectPets,i,newPetId)
          self:refreshSelect6StarPetItem2(selectPets,petids,CostGold,AwakeCost)
          return true
        end
        param.lowup = true
        self:gotoChose(param,v)
      end)
    else
      local pet = AppData.getPetInfo().getPetInfoByPetId(AwakeCost[i])
      costset['name']:setString(string.format('%sx1',pet.Name))
      costset['name']:setFontFillColor(Res.color4F.red,true)
      costset['iconPet']:setResid(res.getPetIcon(pet.PetId))
      costset['iconPet']:setOpacity(128)
      costset['pz']:setResid('N_ZB_biankuang0.png')
      costset['icon']:setVisible(false)
      costset['btn']:setListener(function ( ... )
        GleeCore:showLayer("DPetDetailV",{PetInfo = pet})
      end)
    end
    require 'LangAdapter'.LabelNodeAutoShrink(costset['name'],120)
  end

  local userInfo = AppData.getUserInfo()
  local goldset = self:createLuaSet('@itemgold')
  self._viewSet['bg1_items_star6pet']:addChild(goldset[1])
  goldset['name']:setString(string.format('%s x%d',res.locString('Global$Gold'),CostGold))
  if CostGold > userInfo.getGold() then
    goldset['name']:setFontFillColor(res.color4F.red,true)  
  else
    goldset['name']:setFontFillColor(ccc4f(1.0,0.663,0.267,1.0),true)
  end

end

function TLAwake:refreshSelect6StarPetItem(selectPets,petids,CostGold,star)
  self._selectPets = selectPets
  self._viewSet['bg1_items_linearlayout']:setVisible(false)
  self._viewSet['bg1_items_star6pet']:setVisible(true)
  self._viewSet['bg1_items_star6pet']:removeAllChildrenWithCleanup(true)

  local replaceFunc = function ( pets,i,newPetId )
    local newpet = AppData.getPetInfo().getPetWithId(newPetId)
    table.remove(pets,i)
    table.insert(pets,i,newpet)
    local newpetids = {}
    for k,v in pairs(pets) do
      table.insert(newpetids,i,v.Id)
    end
    return newpetids
  end

  for i=1,#star do
    local v = selectPets[i]
    local costset = self:createLuaSet('@itemcost')
    self._viewSet['bg1_items_star6pet']:addChild(costset[1])

    if v then
      costset['iconPet']:setResid(res.getPetIcon(v.PetId))
      costset['pz']:setResid(res.getPetPZ(v.AwakeIndex))
      costset['icon']:setVisible(false)
      costset['name']:setString(string.format('%sx1',v.Name))
      costset['name']:setFontFillColor(ccc4f(1.0,0.663,0.267,1.0),true)  
      costset['btn']:setListener(function ( ... )
        local param = {}
        param.needRemove = self._needRemove
        param.funcChosePet = function ( newPetId )
          petids = replaceFunc(selectPets,i,newPetId)
          self:refreshSelect6StarPetItem(selectPets,petids,CostGold,star)
          return true
        end
        param.lowup = true
        self:gotoChose(param,v)
      end)
    else
      costset['name']:setString(string.format(Res.locString('PetFoster$petcost'),res.Num[star[i]]))
      costset['name']:setFontFillColor(Res.color4F.red,true)
      costset['iconPet']:setResid('PZ_dianjixuanze.png')
      costset['pz']:setResid('N_ZB_biankuang0.png')
      costset['icon']:setVisible(false)
      costset['btn']:setListener(function ( ... )
        self:toast(Res.locString('PetFoster$Toast1'))
      end)
    end
  end

  local userInfo = AppData.getUserInfo()
  local goldset = self:createLuaSet('@itemgold')
  self._viewSet['bg1_items_star6pet']:addChild(goldset[1])
  goldset['name']:setString(string.format('%s x%d',res.locString('Global$Gold'),CostGold))
  if CostGold > userInfo.getGold() then
    goldset['name']:setFontFillColor(res.color4F.red,true)  
  else
    goldset['name']:setFontFillColor(ccc4f(1.0,0.663,0.267,1.0),true)
  end

end 

function TLAwake:clickAwake( dbnext )
  --请求并更新数据
  local nPet = self._Pet

  local userlv = AppData.getUserInfo().getLevel()
  if userlv < dbnext.Rolelv then
    self:toast(string.format(Res.locString('PetFoster$RoleLvLimit'),dbnext.Rolelv))
    return
  end

  local consumeid = {0}
  local confirmFunc = function ( ... )
    self:send(netModel.getModelPetAwake(nPet.Id,consumeid), function ( data )
      if data and data.D then
        if data.D.Role then
          AppData.getUserInfo().setData(data.D.Role)
        end  
        if self._selectPet then
          AppData.getPetInfo().removePetByIds(consumeid)
        end
        if self._selectPets then
          AppData.getPetInfo().removePetByIds(consumeid)
        end
        if data.D.Material then
          -- local oldstoneCnt = AppData.getBagInfo().getItemCount(42)
          AppData.getBagInfo().updateItemCount(data.D.Material)
          -- local newstoneCnt = AppData.getBagInfo().getItemCount(42)
          -- require 'MATHelper':Consumed(5,oldstoneCnt-newstoneCnt,Res.locString('PetFoster$Awake0'))
        end
        local callback = function ( ... )
          self._parent:updatePet(data.D.Pet)  
        end
        self.norefresh = true
        GleeCore:showLayer('DFosterAwakeResult',{consumecnt =#consumeid+1,oldpet=nPet,newpet=data.D.Pet,subtitle=self._subtitle,subdes=self._subdes,
          oldname = self._viewSet['old_step']:getString(),newname=self._viewSet['new_step']:getString(),callback=callback}) 
        GuideHelper:check('Awake')
      end
    end)  
  end

  if self._selectPet then
    consumeid = {self._selectPet.Id}
    local ret = self:noticeRebirth(confirmFunc,self._selectPet)
    if not ret then
      confirmFunc()
    end
  elseif self._selectPets then
    consumeid = {}
    for i,v in ipairs(self._selectPets) do
      table.insert(consumeid,v.Id)
    end

    local ret = false
    for i,v in ipairs(self._selectPets) do
      ret = self:noticeRebirth(confirmFunc,v) or ret
    end
    if not ret then
      confirmFunc()
    end
  else
    confirmFunc()
  end


end

function TLAwake:noticeRebirth( confirmFunc,nPet )
  local rebirthEnable = nPet.AwakeIndex ~= 0 or nPet.Lv ~= 1 or nPet.Exp > 0 or ((nPet.Lv-nPet.Potential) > 0 and nPet.Star > 2)
  if rebirthEnable then
    self.norefresh = true --不重生
    GleeCore:showLayer('DConfirmNT',{clickClose=true,content = res.locString('PetFoster$rebirthNotice'), callback=function ( )
      confirmFunc()
    end,LeftBtnText=res.locString('PetFoster$rebirthTitle'),cancelCallback=function ( ... )
      GleeCore:showLayer('DPetFoster',{pet=nPet,tab='TLRebirth'},'Rebirth')
    end})
    return true
  end
  return false
end

function TLAwake:getTip( dbcur,dbnext,nPet )

  local AwakeIndex  = nPet.AwakeIndex
  local star        = nPet.PetId
  local charactor = dbManager.getCharactor(nPet.PetId)

  --[[
  再觉醒N次,将解锁被动技能'吸取lv.4'
  再觉醒N次,将提升主动技能'十万伏特
  ]]
  local getEffect = function ( index,n )

    local dbnext = dbManager.getAwake(index,self._Pet.Star,self.dbPet.quality)
    local subdes = ''
    if (dbcur and dbcur.unlockcount < dbnext.unlockcount) or (not dbcur and dbnext.unlockcount > 0) then
      --有技能解锁
      local skillid = charactor.abilityarray[dbnext.unlockcount]
      local skillinfo = dbManager.getInfoSkill(skillid)
      if skillinfo then
        subdes = string.format(Res.locString('PetFoster$abAwake'),n,skillinfo.name)
      end
    elseif dbnext.Suffix == 0 and dbnext.damage > 0 then
      local skillid = charactor.skill_id
      local skillinfo = dbManager.getInfoSkill(skillid)
      subdes = string.format(Res.locString('PetFoster$SkillAwake'),n,skillinfo.name)
    end
    return subdes
  end

  for i=AwakeIndex,24 do
    local des = getEffect(i+1,(i+1)-AwakeIndex)
    if des then
      return des
    end
  end

  return Res.locString('PetFoster$TIP2')

end

function TLAwake:gotoChose( param,curpet)
  self.norefresh = true

  local selected = {}
  if self._selectPet then
    table.insert(selected,self._selectPet.Id)
  end

  if self._selectPets then
    for k,v in pairs(self._selectPets) do
      if v and v ~= 0 and ((curpet and v.Id == curpet.Id) or curpet == nil) then
        table.insert(selected,v.Id)
      end
    end
  end
  
  if param.needRemove and #selected > 0 then

    if self._selectPets then
      for i,v in ipairs(self._selectPets) do
        if v and not table.find(param.needRemove,v.Id) then
          table.insert(param.needRemove,v.Id)
        end
      end
    end

    for k,v in pairs(selected) do
      for k1,v1 in pairs(param.needRemove) do
        if v == v1 then
          table.remove(param.needRemove,k1)
        end
      end
    end
  end

  param.selected = selected
  GleeCore:showLayer("DPetChose", param)
end


function TLAwake:setNeedRemoves( skinid,value )
  self._chooseinfo = self._chooseinfo or {}
  self._chooseinfo[skinid] = value
end

function TLAwake:getNeedRemoves( skinid )
  return self._chooseinfo and self._chooseinfo[skinid]
end


function TLAwake:getAwakeCost(AwakeCost,Grade)
  --[[16|175,280;20|175,280;24|245]]
  local ret = {}
  local items = string.split(AwakeCost,';')
  if items then
    for k,v in pairs(items) do
      local item = string.split(v,'|')
      local grade = (item and tonumber(item[1])) or 0
      if grade == Grade and item[2] then
        local petids = string.split(item[2],',')
        for i,v in ipairs(petids) do
          table.insert(ret,tonumber(v))
        end
        break
      end
    end
  end
  return ret 

end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLAwake, "TLAwake")


--------------------------------register--------------------------------
return TLAwake
