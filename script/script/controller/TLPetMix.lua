local Config = require "Config"
local appData = require 'AppData'
local res = require 'Res'
local dbManager = require 'DBManager'
local mixConfig = require 'MixConfig'
local netmodel = require 'netModel'
local GuideHelper = require 'GuideHelper'
local eventCenter = require 'EventCenter'

local TLPetMix = class(TabLayer)

function TLPetMix:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLPetMix.cocos.zip")
    return self._factory:createDocument("TLPetMix.cocos")
end

--@@@@[[[[
function TLPetMix:onInitXML()
    local set = self._set
   self._list = set:getListNode("list")
   self._pet = set:getElfNode("pet")
   self._pet_pzbg = set:getElfNode("pet_pzbg")
   self._pet_icon = set:getElfNode("pet_icon")
   self._pet_pz = set:getElfNode("pet_pz")
   self._pet_property = set:getElfNode("pet_property")
   self._pet_career = set:getElfNode("pet_career")
   self._starLayout = set:getLayoutNode("starLayout")
   self._nameBg = set:getElfNode("nameBg")
   self._name = set:getLabelNode("name")
   self._Quality = set:getLabelNode("Quality")
   self._Lv = set:getLabelNode("Lv")
   self._click = set:getButtonNode("click")
   self._soul_V = set:getLabelNode("soul_V")
   self._select = set:getElfNode("select")
   self._bottom_BL = set:getElfNode("bottom_BL")
   self._bottom_BL_bg_linear_label = set:getLabelNode("bottom_BL_bg_linear_label")
   self._bottom_BL_bg_linear_v1 = set:getLabelNode("bottom_BL_bg_linear_v1")
   self._bottom_BL_bg_linear_label1 = set:getLabelNode("bottom_BL_bg_linear_label1")
   self._bottom_BL_bg_linear_v2 = set:getLabelNode("bottom_BL_bg_linear_v2")
   self._bottom_BR = set:getElfNode("bottom_BR")
   self._bottom_BR_btnBringUp = set:getClickNode("bottom_BR_btnBringUp")
   self._bottom_BR_btnBringUp_title = set:getLabelNode("bottom_BR_btnBringUp_title")
   self._bottom_BR_btnSelect3 = set:getClickNode("bottom_BR_btnSelect3")
   self._bottom_BR_btnSelect3_title = set:getLabelNode("bottom_BR_btnSelect3_title")
   self._bottom_BR_btnSelect2 = set:getClickNode("bottom_BR_btnSelect2")
   self._bottom_BR_btnSelect2_title = set:getLabelNode("bottom_BR_btnSelect2_title")
   self._bottom_BR_btnUnSelect3 = set:getClickNode("bottom_BR_btnUnSelect3")
   self._bottom_BR_btnUnSelect3_title = set:getLabelNode("bottom_BR_btnUnSelect3_title")
   self._bottom_BR_btnUnSelect2 = set:getClickNode("bottom_BR_btnUnSelect2")
   self._bottom_BR_btnUnSelect2_title = set:getLabelNode("bottom_BR_btnUnSelect2_title")
   self._topBar_ftpos2_linear_v2 = set:getLabelNode("topBar_ftpos2_linear_v2")
--   self._@view = set:getElfNode("@view")
--   self._@size = set:getElfNode("@size")
--   self._@star = set:getElfNode("@star")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLPetMix:onInit( userData, netData )
	local size = CCDirector:sharedDirector():getWinSize()
  self._viewSet['list']:setContentSize(CCSize(size.width, self._viewSet['list']:getHeight()))

  self._viewSet['bottom_BR']:setPosition(ccp(size.width/2,-size.height/2))
  self._viewSet['bottom_BL']:setPosition(ccp(-size.width/2,-size.height/2))

  eventCenter.addEventFunc('alginTo',function ( data )
    self:alginToList(data)  
  end,'TLPetMix')

  local func = function ( ... )
    self._viewSet['bottom_BR_btnSelect3_title']:setFontSize(23)
    self._viewSet['bottom_BR_btnSelect2_title']:setFontSize(23)
    self._viewSet['bottom_BR_btnUnSelect3_title']:setFontSize(23)
    self._viewSet['bottom_BR_btnUnSelect2_title']:setFontSize(23)
    self._viewSet['bottom_BR_btnBringUp_title']:setFontSize(23)
    self._viewSet['bottom_BL_bg_linear_label']:setFontSize(20)
    self._viewSet['bottom_BL_bg_linear_label1']:setFontSize(20)
  end

  require 'LangAdapter'.selectLangkv({Indonesia=func,German=func})
end

function TLPetMix:onEnter( ... )
  
  local args = {...}
  if #args > 0 and args[1] == 'back' then
    return
  end

  self:updateLayer()
  GuideHelper:registerPoint('确认献祭',self._viewSet['bottom_BR_btnBringUp'])
end

function TLPetMix:onLeave( ... )
  self._setmap = nil
  self._selectmap = nil
end

function TLPetMix:onBack( userData, netData )
	
end

function TLPetMix:onRelease( ... )
  self._setmap = nil
  self._selectmap = nil
  eventCenter.resetGroup('TLPetMix')
end
--------------------------------custom code-----------------------------

function TLPetMix:updateLayer( ... )
  local userInfo = appData.getUserInfo()

  self._viewSet['topBar_ftpos2_linear_v2']:setString(userInfo.getSoul())

  self._pets = appData.getPetInfo().getPetListForMix()
  appData.getPetInfo().sortPetListInMix(self._pets)

  self._PetCnt = appData.getPetInfo().getPetCountByStar(self._pets)
  self:checkButtonEnable()
  -- body
  
  -- local levelCapTable = dbManager.getInfoRoleLevelCap(userInfo.getLevel())
  
  self:updatePetList()

  self._viewSet['bottom_BR_btnSelect2']:setListener(function ( ... )
    self:selectAllStar(2,true)
    self:selectAllStar(3,true)
    self:buttonState(2,true)
  end)

  self._viewSet['bottom_BR_btnSelect3']:setListener(function ( ... )
    self:selectAllStar(4,true)
    self:buttonState(3,true)
  end)

  self._viewSet['bottom_BR_btnUnSelect2']:setListener(function ( ... )
    self:selectAllStar(2,false)
    self:selectAllStar(3,false)
    self:buttonState(2,false)
  end)

  self._viewSet['bottom_BR_btnUnSelect3']:setListener(function ( ... )
    self:selectAllStar(4,false)
    self:buttonState(3,false)
  end)

  self._viewSet['bottom_BR_btnBringUp']:setListener(function ( ... )
    
    if self._neednotice then
      GleeCore:showLayer('DConfirmNT',{content2=self:getNoticeContent(),callback=function ( ... )
        self:Mix()
      end})
    else
      self:Mix()
    end

  end)

  self:updateBottomInfo()
end

function TLPetMix:checkButtonEnable( ... )

  self._viewSet['bottom_BR_btnSelect2']:setEnabled(self._PetCnt[2] ~= nil or self._PetCnt[3] ~= nil)
  self._viewSet['bottom_BR_btnSelect3']:setEnabled(self._PetCnt[4] ~= nil)

end

function TLPetMix:updateBottomInfo(  )
  local petcnt = 0
  local soulsum = 0
  local starType = {}--选中内容的所包含的星级种类

  if self._selectmap then
    for k,v in pairs(self._selectmap) do
      if v then
        local pet = appData.getPetInfo().getPetWithId(k)
        local dbPet = dbManager.getCharactor(pet.PetId)
        petcnt = petcnt + 1
        soulsum = soulsum + self:getSoulCount(dbPet.star_level,dbPet.quality )
        starType[pet.Star] = (starType[pet.Star] == nil and 1) or (starType[pet.Star] + 1)
      end
    end
  end

  self._viewSet['bottom_BL_bg_linear_v1']:setString(tostring(petcnt))
  self._viewSet['bottom_BL_bg_linear_v2']:setString(tostring(soulsum))
  self._soulsum = soulsum
  self._viewSet['bottom_BR_btnBringUp']:setEnabled(petcnt > 0)

  if starType[2] == nil and starType[3] == nil then
    self:buttonState(2,false)
  elseif self._PetCnt[2] == starType[2] and self._PetCnt[3] == starType[3] then
    self:buttonState(2,true)
  end

  if starType[4] == nil then
    self:buttonState(3,false)
  elseif self._PetCnt[4] == starType[4] then
    self:buttonState(3,true)    
  end

  self._neednotice = false
  for k,v in pairs(starType) do
    if k >= 5 and v > 0 then
      self._neednotice = true
    end
  end
  
end

function TLPetMix:buttonState( star,select )

  if star == 2 then
    self._viewSet['bottom_BR_btnUnSelect2']:setVisible(select)
    self._viewSet['bottom_BR_btnSelect2']:setVisible(not select)
  elseif star == 3 then
    self._viewSet['bottom_BR_btnUnSelect3']:setVisible(select)
    self._viewSet['bottom_BR_btnSelect3']:setVisible(not select)
  end

end


function TLPetMix:updatePetList( ... )
  local pets = self._pets

  if GuideHelper:inGuide('GCfgUnlockLv5') then
    local spet = nil
    for i,v in ipairs(pets) do
      if v.PetId == 19 then
        spet = v
        table.remove(pets,i)
      end
    end
    if spet then
      table.insert(pets,1,spet)
    end
  end

  if pets then
    self._viewSet['list']:stopAllActions()
    self._viewSet['list']:getContainer():removeAllChildrenWithCleanup(true)
    

    for i,v in ipairs(pets) do
      if i < 7 then
        self:addCellWithPet(v)
      else
        self:runWithDelay(function ( ... )
          self:addCellWithPet(v)
        end,0.1*(i-7),self._viewSet['list'])
      end
    end

    self._viewSet['list']:layout()
  end
end

function TLPetMix:addCellWithPet( pet )
  local cellSet = self:createLuaSet('@size')
  self:refreshPetCell(cellSet,pet)
  self._viewSet['list']:getContainer():addChild(cellSet[1])
  self:bindSetPid(cellSet,pet.Id)
end

function TLPetMix:refreshPetCell( itemSet,nPet)

  if not nPet then
    print('pet is nil CPetMix')
    return
  end

  local dbPet = dbManager.getCharactor(nPet.PetId)
  
  itemSet["pet_icon"]:setResid(res.getPetIcon(nPet.PetId))
  itemSet["pet_pz"]:setResid(res.getPetPZ(nPet.AwakeIndex))
  itemSet["pet_property"]:setResid(res.getPetPropertyIcon(dbPet.prop_1,true))
  itemSet["pet_career"]:setResid(res.getPetCareerIcon(dbPet.atk_method_system))
  require 'PetNodeHelper'.updateStarLayout(itemSet['starLayout'],dbPet)  
  
  itemSet["name"]:setString(res.getPetNameWithSuffix(nPet))
  itemSet["Quality"]:setString(dbPet.quality)
  
  itemSet["Lv"]:setString(string.format("%d/%d", nPet.Lv, dbManager.getPetLvCap(nPet)))
  itemSet['soul_V']:setString(tostring(self:getSoulCount(dbPet.star_level,dbPet.quality)))
  itemSet['click']:setListener(function ( ... )
    self:select(nPet.Id)
    self:updateBottomInfo()
  end)

  require 'LangAdapter'.NodesPosReverse(itemSet['#LvTitle'],itemSet["Lv"])
  require 'LangAdapter'.NodesPosReverse(itemSet['#QualityTitle'],itemSet["Quality"])
end

function TLPetMix:getSoulCount( star,quality )

  if self._soulStarT == nil then
    self._soulStarT = {}
    for k,v in pairs(mixConfig) do
      if self._soulStarT[v.Stars] == nil then
        self._soulStarT[v.Stars] = {}
      end
      self._soulStarT[v.Stars][v.quality] = v.Soul
    end  
  end

  if not self._soulStarT[star] then
    return 0
  end

  return self._soulStarT[star][quality] or self._soulStarT[star][0]
end

function TLPetMix:select( petid ,flag)

  if self._selectmap == nil then
    self._selectmap = {}
  end

  if flag ~= nil then
    self._selectmap[petid] = flag
  else
    self._selectmap[petid] = not self._selectmap[petid]
  end
    
  local itemSet = self:getSetByPid(petid)
  if itemSet then
    itemSet['select']:setVisible(self._selectmap[petid])
  end

  GuideHelper:check('MixSelected')
end

function TLPetMix:getSelectIds( ... )
  
  local ids = {}
  local item = {}
  for k,v in pairs(self._selectmap) do
    if v then
      if #item < 50 then
        table.insert(item,k)
      else
        table.insert(ids,item)
        item = {}
        table.insert(item,k)  
      end
    end
  end  
  table.insert(ids,item)

  return ids

end

function TLPetMix:selectAllStar( star,flag )
  local pets = self._pets
  for k,v in pairs(pets) do
    if v.Star == star then
      self:select(v.Id,flag)
    end
  end  

  self:updateBottomInfo()
end

function TLPetMix:bindSetPid( luaset,petid )
  if self._setmap == nil then
    self._setmap = {}
  end  

  self._setmap[petid] = luaset
end

function TLPetMix:getSetByPid( petid )
  if self._setmap then
    return self._setmap[petid]
  end
end

function TLPetMix:Mix(  )
  local idsarr = self:getSelectIds()
  local pos = 1
  local soulsum = 0

  local callnet 
  callnet = function ( ids )
    self:send(netmodel.getModelPetMix(ids),function ( data )
      if data and data.D then
        if data.D.Role then
          appData.getUserInfo().setData(data.D.Role)
        end
        self:removeSelectIds(ids)

        if data.D.Soul then
          soulsum = tonumber(data.D.Soul) + soulsum
        end

        pos = pos + 1
        if idsarr[pos] then
          callnet(idsarr[pos])
        else
          local callback =  function ( ... )
            self._selectmap = nil
            self._setmap = nil
            self:updateLayer()  
          end
          GleeCore:showLayer('DGetReward',{Soul=soulsum,callback=callback},'TLPetMix')
          GuideHelper:check('MixDone')
        end

        -- require 'MATHelper':Produced(4,soulsum,res.locString('Pet$Sacrifice'))
      end
    end)
  end

  callnet(idsarr[pos])

end

function TLPetMix:removeSelectIds( ids )

  if ids then
    for k,v in pairs(ids) do
      appData.getPetInfo().removePetById(v)
    end
  end

  appData.getPetInfo().modify()
end

function TLPetMix:alginToList( data )
  if data then
    local petid = tonumber(data)
    local index = 0
    local Id = 0
    for i,v in ipairs(self._pets) do
      if v.PetId == petid and v.Lv <= 1 and Id == 0 then
        index = i-1
        Id = v.Id
        break
      end
    end
    self._viewSet['list']:alignTo(index)
    self._viewSet['list']:layout()
    local luaset = self:getSetByPid(Id)
    if luaset and luaset['click'] then
      GuideHelper:registerPoint(string.format('PetId%d',petid),luaset['click'])
    end
    GuideHelper:check('alginToDone')
  end
end

function TLPetMix:getNoticeContent( ... )
  local content = {}
  local foundnormal5 = false
  local foundstar5 = false
  for k,v in pairs(self._selectmap) do
    if v then
      local npet  = appData.getPetInfo().getPetWithId(k)
      local dbpet = dbManager.getCharactor(npet.PetId)
      
      if dbpet and dbpet.star_level == 6 and not dbpet.mixtips then
        foundstar5 = true
      elseif dbpet and dbpet.star_level == 6 and dbpet.mixtips then
        table.insert(content,string.format('[color=f3e0bbff]%s[/color]',dbpet.mixtips))
      elseif dbpet and dbpet.star_level == 5 then
        foundnormal5 = true
      end
    end
  end
  
  if foundstar5 then
    table.insert(content,1,res.locString('PetMIx$confirmContent1'))
  end
  
  if foundnormal5 then
    table.insert(content,res.locString('PetMIx$confirmContent'))
  end

  local content = table.concat(content,';\n')
  return string.format(res.locString('PetMIx$confirmC'),content)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLPetMix, "TLPetMix")


--------------------------------register--------------------------------
return TLPetMix
