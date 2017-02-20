local Config = require "Config"
local gameFunc = require "AppData"
local res = require "Res"
local dbManager = require "DBManager"
local eventCenter = require 'EventCenter'
local GuideHelper = require 'GuideHelper'
local netModel = require 'netModel'
local Toolkit = require 'Toolkit'
local TownHelper = require 'TownHelper'
local netModel = require 'netModel'
local Launcher = require 'Launcher'

Launcher.register("DPetDetailV", function ( userData )

   local nPet     = userData.nPet or userData.PetInfo
   local dbPet    = dbManager.getCharactor(nPet.PetId)
   local stageids = {}
   if (dbPet.capture_city and tostring(dbPet.capture_city) ~='0') then
      local towntype,ids = unpack(string.split(dbPet.capture_city,'|'))
      local items = string.split(ids,',')
      for k,v in pairs(items) do
         table.insert(stageids,tonumber(v))
      end
   end
   if stageids and #stageids > 0 then
      Launcher.callNet(netModel.getModelGetStages(stageids),function ( data )
         Launcher.Launching(data)
      end)
   else
      Launcher.Launching()
   end
   
end)

local DPetDetailV = class(LuaDialog)

function DPetDetailV:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPetDetailV.cocos.zip")
    return self._factory:createDocument("DPetDetailV.cocos")
end

--@@@@[[[[
function DPetDetailV:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._root = set:getElfNode("root")
   self._root_petImg = set:getElfNode("root_petImg")
   self._root_petImgun = set:getElfNode("root_petImgun")
   self._root_list = set:getListNode("root_list")
   self._bg = set:getElfNode("bg")
   self._bg_nameLayout = set:getLinearLayoutNode("bg_nameLayout")
   self._bg_nameLayout_name = set:getLabelNode("bg_nameLayout_name")
   self._bg_nameLayout_lv = set:getLabelNode("bg_nameLayout_lv")
   self._bg_zizhit = set:getLabelNode("bg_zizhit")
   self._bg_zizhi = set:getLabelNode("bg_zizhi")
   self._bg_layoutp = set:getLinearLayoutNode("bg_layoutp")
   self._bg_layoutp_job = set:getElfNode("bg_layoutp_job")
   self._bg_layoutp_pro = set:getElfNode("bg_layoutp_pro")
   self._bg_layout = set:getLinearLayoutNode("bg_layout")
   self._bg_layout_starLayout = set:getLayoutNode("bg_layout_starLayout")
   self._bg_p4Value = set:getLabelNode("bg_p4Value")
   self._bg_skillLayout = set:getLinearLayoutNode("bg_skillLayout")
   self._img = set:getElfNode("img")
   self._des = set:getLabelNode("des")
   self._suo = set:getElfNode("suo")
   self._btn = set:getButtonNode("btn")
   self._bg_linearlayout_p3Value = set:getLabelNode("bg_linearlayout_p3Value")
   self._bg_linear_p1Value = set:getLabelNode("bg_linear_p1Value")
   self._bg_linear_p2Value = set:getLabelNode("bg_linear_p2Value")
   self._minipet = set:getElfNode("minipet")
   self._minipet_monster = set:getElfNode("minipet_monster")
   self._minipet_btnatk = set:getButtonNode("minipet_btnatk")
   self._btnShare = set:getButtonNode("btnShare")
   self._btnEx = set:getButtonNode("btnEx")
   self._pet = set:getElfNode("pet")
   self._pzbg = set:getElfNode("pzbg")
   self._unkown = set:getElfNode("unkown")
   self._icon = set:getElfNode("icon")
   self._pz = set:getElfNode("pz")
   self._name = set:getLabelNode("name")
   self._pets = set:getLayout2DNode("pets")
   self._pzbg = set:getElfNode("pzbg")
   self._icon = set:getElfNode("icon")
   self._pz = set:getElfNode("pz")
   self._name = set:getLabelNode("name")
   self._pzbg = set:getElfNode("pzbg")
   self._icon = set:getElfNode("icon")
   self._pz = set:getElfNode("pz")
   self._name = set:getLabelNode("name")
   self._pzbg = set:getElfNode("pzbg")
   self._icon = set:getElfNode("icon")
   self._pz = set:getElfNode("pz")
   self._name = set:getLabelNode("name")
   self._pzbg = set:getElfNode("pzbg")
   self._icon = set:getElfNode("icon")
   self._pz = set:getElfNode("pz")
   self._name = set:getLabelNode("name")
   self._pet = set:getElfNode("pet")
   self._pzbg = set:getElfNode("pzbg")
   self._icon = set:getElfNode("icon")
   self._pz = set:getElfNode("pz")
   self._name = set:getLabelNode("name")
   self._pets = set:getLayout2DNode("pets")
   self._bg3 = set:getJoint9Node("bg3")
   self._get = set:getLabelNode("get")
   self._bg = set:getElfNode("bg")
   self._icon = set:getElfNode("icon")
   self._frame = set:getElfNode("frame")
   self._name = set:getLabelNode("name")
   self._tip = set:getLabelNode("tip")
   self._btn = set:getButtonNode("btn")
   self._lock = set:getElfNode("lock")
   self._btnBattleSpeed = set:getClickNode("btnBattleSpeed")
   self._btnReset = set:getClickNode("btnReset")
   self._btnGoto = set:getClickNode("btnGoto")
   self._bg = set:getElfNode("bg")
   self._icon = set:getElfNode("icon")
   self._frame = set:getElfNode("frame")
   self._name = set:getLabelNode("name")
   self._tip = set:getLabelNode("tip")
   self._btn = set:getButtonNode("btn")
   self._lock = set:getElfNode("lock")
   self._getInfo = set:getLabelNode("getInfo")
   self._gotoBtn = set:getClickNode("gotoBtn")
   self._gotoBtn_label = set:getLabelNode("gotoBtn_label")
   self._bg1 = set:getJoint9Node("bg1")
   self._linearlayout = set:getLinearLayoutNode("linearlayout")
   self._linearlayout_pets = set:getElfNode("linearlayout_pets")
   self._linearlayout_pets_layout = set:getLayout2DNode("linearlayout_pets_layout")
   self._pzbg = set:getElfNode("pzbg")
   self._icon = set:getElfNode("icon")
   self._pz = set:getElfNode("pz")
   self._name = set:getLabelNode("name")
   self._layout = set:getLinearLayoutNode("layout")
   self._layout_state = set:getElfNode("layout_state")
   self._layout_des = set:getRichLabelNode("layout_des")
   self._layout = set:getLinearLayoutNode("layout")
   self._layout_state = set:getElfNode("layout_state")
   self._layout_des = set:getRichLabelNode("layout_des")
   self._pet = set:getElfNode("pet")
   self._pzbg = set:getElfNode("pzbg")
   self._icon = set:getElfNode("icon")
   self._pz = set:getElfNode("pz")
   self._name = set:getLabelNode("name")
   self._pets = set:getLayout2DNode("pets")
   self._pzbg = set:getElfNode("pzbg")
   self._icon = set:getElfNode("icon")
   self._pz = set:getElfNode("pz")
   self._name = set:getLabelNode("name")
   self._pets2 = set:getLayout2DNode("pets2")
   self._pzbg = set:getElfNode("pzbg")
   self._icon = set:getElfNode("icon")
   self._pz = set:getElfNode("pz")
   self._name = set:getLabelNode("name")
   self._pzbg = set:getElfNode("pzbg")
   self._icon = set:getElfNode("icon")
   self._pz = set:getElfNode("pz")
   self._name = set:getLabelNode("name")
   self._root_btnStage = set:getClickNode("root_btnStage")
   self._root_btnStage_title = set:getLabelNode("root_btnStage_title")
   self._root_btnUnStage = set:getClickNode("root_btnUnStage")
   self._root_btnUnStage_title = set:getLabelNode("root_btnUnStage_title")
   self._root_close = set:getButtonNode("root_close")
--   self._@base = set:getElfNode("@base")
--   self._@star = set:getElfNode("@star")
--   self._@star = set:getElfNode("@star")
--   self._@star = set:getElfNode("@star")
--   self._@star = set:getElfNode("@star")
--   self._@star = set:getElfNode("@star")
--   self._@star = set:getElfNode("@star")
--   self._@skill = set:getElfNode("@skill")
--   self._@evolve1 = set:getElfNode("@evolve1")
--   self._@pet = set:getElfNode("@pet")
--   self._@pet = set:getElfNode("@pet")
--   self._@pet = set:getElfNode("@pet")
--   self._@pet = set:getElfNode("@pet")
--   self._@pet = set:getElfNode("@pet")
--   self._@evolve1_8 = set:getElfNode("@evolve1_8")
--   self._@pet = set:getElfNode("@pet")
--   self._@loot = set:getElfNode("@loot")
--   self._@lootlayout = set:getLinearLayoutNode("@lootlayout")
--   self._@itemget = set:getElfNode("@itemget")
--   self._@itemm = set:getElfNode("@itemm")
--   self._@lootForShop = set:getElfNode("@lootForShop")
--   self._@fetter = set:getElfNode("@fetter")
--   self._@pet = set:getElfNode("@pet")
--   self._@item = set:getElfNode("@item")
--   self._@item = set:getElfNode("@item")
--   self._@evolve2 = set:getElfNode("@evolve2")
--   self._@pet = set:getElfNode("@pet")
--   self._@pet = set:getElfNode("@pet")
--   self._@pet = set:getElfNode("@pet")
--   self._@pet = set:getElfNode("@pet")
end
--@@@@]]]]

--------------------------------override functions----------------------

--[[
:
FromShop
Callback
BtnText
FromTownID

:
petSelectFunc
pets
petids
needRemove
nPet
funcChosePet
dataChosePet
isPetFromDbPet
isCollected
isNotMine
fetterPetIdListWithPartners
]]
function DPetDetailV:onInit( userData, netData )
   if netData and netData.D then
      self.nStageList = netData.D.Stages
   end

	res.doActionDialogShow(self._root)
   self._clickBg:setListener(function ( ... )
      res.doActionDialogHide(self._root,self)
   end)
   self._root_close:setListener(function ( ... )
      self._clickBg:trigger(nil)
   end)
   
   eventCenter.addEventFunc('PetInfoModify',function ( data )
      self._needRefresh = true
   end,'DPetDetailV')

   self:archiveIdsInit()
   self:selectPetData(userData)

   require 'LangAdapter'.LabelNodeAutoShrink(self._root_btnStage_title,110)
   require 'LangAdapter'.LabelNodeAutoShrink(self._root_btnUnStage_title,110)
end

function DPetDetailV:onBack( userData, netData )
   if self._needRefresh then
      local Userdata = self:getUserData()
      if Userdata and Userdata.nPet then
         local Id = Userdata.nPet.Id
         Userdata.nPet = gameFunc.getPetInfo().getPetWithId(Id) or gameFunc.getPetInfo().getPetWithPetIdArchived(self.nPet.PetId)
         self:selectPetData(Userdata)
      end
      self._needRefresh = false
   end
end

function DPetDetailV:close( ... )
   eventCenter.resetGroup('DPetDetailV')
   local userData = self:getUserData()
   if userData and userData.callback then
      userData.callback(self._idsarchive)
   end
end

--------------------------------custom code-----------------------------
--[[选中精灵]]
function DPetDetailV:selectPetData( userData )
   
   self.nPet      = userData.nPet or userData.PetInfo
   if self.nPet and self.nPet.PetId and (not self.nPet.Lv or self.nPet.Lv == 0)then
      self.nPet   = gameFunc.getPetInfo().getPetInfoByPetId(self.nPet.PetId)
   end
   self.petInfo   = self.nPet

   self.dbInfo    = dbManager.getCharactor(self.nPet.PetId)
   self.fromShop  = userData.FromShop
   self.callback  = userData.Callback
   self.btnText   = userData.BtnText
   self.fromTownID   = userData.FromTownID or 0

   self.needRemove = userData.needRemove
   self.funcChosePet = userData.funcChosePet
   self.dataChosePet = userData.dataChosePet
   self.isPetFromDbPet = userData.isPetFromDbPet
   self.isCollect = (userData.isCollect == nil and true) or userData.isCollect
   self.isNotMine = userData.isNotMine
   if self.isNotMine == nil  then
      self.isNotMine = gameFunc.getPetInfo().getPetWithId(self.nPet.Id) == nil
   end
   self.fetterPetIdListWithPartners = userData.fetterPetIdListWithPartners
   self.equipments = userData.equipments
   self.team       = userData.team
   
   self._root_list:getContainer():removeAllChildrenWithCleanup(true)
   self:updateBase(userData)
   self:updateEvolve(userData)
   self:updateFetter(userData)
   self:updateLoot(userData)
   self:updateStage(userData)
   self._root_list:layout()


   if userData.isPetFromDbPet and not userData.isCollect then
      self._root_petImg:setVisible(false)
      self._root_petImgun:setVisible(true)
      return
   end

   if res.getPetPositionConfig(self.petInfo.PetId,'chat') then
      self._root_petImg:setPosition(-560,320)
      self._root_petImg:setAnchorPoint(ccp(0.5,0.5))
   end
   res.adjustPetIconPosition( self._root_petImg,self.petInfo.PetId,'chat')

end

--[[基础]]
function DPetDetailV:updateBase( userData )
   local set = self:createLuaSet('@base')
   require 'LangAdapter'.LabelNodeAutoShrink(set['bg_nameLayout_name'],140)
   require 'LangAdapter'.LabelNodeAutoShrink(set['bg_zizhit'],70)
   set["bg_nameLayout_name"]:setString(self.dbInfo.name)
   set["bg_nameLayout_lv"]:setString(string.format(" lv%d",self.petInfo.Lv))
   set["bg_nameLayout_name"]:setFontFillColor(res.rankColor4F[res.getFinalAwake(self.petInfo.AwakeIndex)],true)
   set["bg_nameLayout_lv"]:setFontFillColor(res.rankColor4F[res.getFinalAwake(self.petInfo.AwakeIndex)],true)
   set["bg_zizhi"]:setString(self.dbInfo.quality)

   require 'PetNodeHelper'.updateStarLayout(set['bg_layout_starLayout'],self.dbInfo, nil,true)
   -- set["bg_layout_starLayout"]:layout()
   
   -- local starSize = CCSizeMake(31,30)
   -- local space = set["bg_layout_starLayout"]:getSpace()
   -- set["bg_layout_starLayout"]:setContentSize(CCSize(starSize.width*self.petInfo.Star-(starSize.width-space)*(self.petInfo.Star-1),starSize.height))
   set["bg_layoutp_job"]:setResid(res.getPetCareerIcon(self.dbInfo.atk_method_system,true))
   set["bg_layoutp_pro"]:setResid(res.getPetPropertyIcon(self.dbInfo.prop_1,true))
   set["bg_layout"]:layout()

   set["bg_linear_p1Value"]:setString(self.petInfo.Atk)
   set["bg_linear_p2Value"]:setString(self.petInfo.Def)
   set["bg_linearlayout_p3Value"]:setString(string.format('%d%%',tonumber(self.petInfo.Crit)*100))
   set["bg_p4Value"]:setString(self.petInfo.Hp)

   local skill = self:createLuaSet("@skill")
   set["bg_skillLayout"]:addChild(skill[1])
   require 'LangAdapter'.labelDimensions(skill["des"],CCSizeMake(0,0),nil,CCSizeMake(80,0),nil,CCSizeMake(0,0))
   require 'LangAdapter'.LabelNodeAutoShrink(skill['des'],80)
   skill["img"]:setResid("JLXQ_jineng1.png")
   local skillitem = dbManager.getInfoSkill(self.dbInfo.skill_id)
   local skillName = skillitem.name
   res.petSkillFormatScale(skill["des"])
   skill["des"]:setString( res.petSkillFormat(skillName) )
   res.LabelNodeAutoShrinkIfArabic(skill["des"], 56)

   skill["des"]:setFontFillColor(ccc4f(0.36,0.15,0,1),true)
   skill["btn"]:setListener(function ( ... )
      self._needRefresh = false
      local nodePos = NodeHelper:getPositionInScreen(skill["btn"])
      self._needRefresh = false
      GleeCore:showLayer('DSkillInfo',{skillitem=skillitem,cost=true,point=nodePos,offset=50})
   end)

   local unlockcount = res.getAbilityUnlockCount(self.petInfo.AwakeIndex,self.petInfo.Star)
   for i=1,#self.dbInfo.abilityarray do
      if self.dbInfo.abilityarray[i] == 0 then
         --无技能
      elseif unlockcount >= i then --已解锁
         local skill = self:createLuaSet("@skill")
         set["bg_skillLayout"]:addChild(skill[1])
         require 'LangAdapter'.labelDimensions(skill["des"],CCSizeMake(0,0),nil,CCSizeMake(80,0),nil,CCSizeMake(0,0))
         -- require 'LangAdapter'.fontSize(skill['des'],nil,nil,nil,nil,16)
         require 'LangAdapter'.LabelNodeAutoShrink(skill['des'],80)
         skill["img"]:setResid("JLXQ_jineng2.png")
         local skillitem = dbManager.getInfoSkill(self.dbInfo.abilityarray[i])
         local skillName = skillitem.name
         res.petSkillFormatScale(skill["des"])
         skill["des"]:setString(res.petSkillFormat(skillName))
         skill["des"]:setFontFillColor(ccc4f(0.11,0.27,0,1),true)
         res.LabelNodeAutoShrinkIfArabic(skill["des"], 56)
         skill["btn"]:setListener(function ( ... )
            self._needRefresh = false
            local nodePos = NodeHelper:getPositionInScreen(skill["btn"])
            self._needRefresh = false
            GleeCore:showLayer('DSkillInfo',{skillitem=skillitem,cost=false,point=nodePos,offset=50})
         end)
      else --没有解锁
         local skill = self:createLuaSet("@skill")
         set["bg_skillLayout"]:addChild(skill[1])
         skill["img"]:setResid("JLXQ_jineng3.png") 
         skill["des"]:setVisible(false)
         skill['suo']:setResid('XHB_suoding.png')

         local skillitem = dbManager.getInfoSkill(self.dbInfo.abilityarray[i])
         skillitem.abilityIndex = i
         skill['btn']:setListener(function ( ... )
            self._needRefresh = false
            local nodePos = NodeHelper:getPositionInScreen(skill["btn"])
            self._needRefresh = false
            GleeCore:showLayer('DSkillInfo',{skillitem=skillitem,cost=false,point=nodePos,offset=50})
         end)
      end   
   end

   --技能书技能
   if self.nPet and self.nPet.Sk and type(self.nPet.Sk) == 'number' and self.nPet.Sk ~= 0 then
      local book=dbManager.getInfoBookConfig(self.nPet.Sk)

      local skill = self:createLuaSet("@skill")
      set["bg_skillLayout"]:addChild(skill[1])

      require 'LangAdapter'.labelDimensions(skill["des"],CCSizeMake(0,0),nil,CCSizeMake(80,0),nil,CCSizeMake(0,0))
      -- require 'LangAdapter'.fontSize(skill['des'],nil,nil,nil,nil,16)
      require 'LangAdapter'.LabelNodeAutoShrink(skill['des'],80)

      skill["img"]:setResid(string.format("JN_jineng%d.png", book.Color))
      local skillitem = dbManager.getInfoSkill(self.nPet.Sk)
      local skillName = skillitem.name
      require 'LangAdapter'.selectLang(nil,function ( ... )
         skillName = string.gsub(skillName,'lv','\nlv')
      end)
      skill["des"]:setString(skillName)
      skill["des"]:setFontFillColor(res.Book[book.Color],true)
      skill["btn"]:setListener(function ( ... )
         local nodePos = NodeHelper:getPositionInScreen(skill["btn"])
         self._needRefresh = false
         GleeCore:showLayer('DSkillInfo',{skillitem=skillitem,cost=false,point=nodePos,offset=50})
      end)
   end

   set["bg_skillLayout"]:layout()

   self._actionview = require 'ActionView'.createActionViewById(self.petInfo.PetId)
   if self._actionview then
      local monsterNode = self._actionview:getRootNode()
      monsterNode:setVisible(true)
      monsterNode:setScale(0.5)
      monsterNode:setPosition(ccp(0, -30))
      monsterNode:setTransitionMills(0)
      self._actionview:play("待机",-1)
      monsterNode:setBatchDraw(true)
      set['minipet_monster']:addChild(monsterNode)
      set['minipet_btnatk']:setListener(function ( ... )
         self:petAttackAction()
      end)
   end

   set['btnEx']:setListener(function ( ... )
      self._needRefresh = false
      GleeCore:showLayer('DPetExInfo',{nPet=self.nPet,equipments=self.equipments,team=self.team})
   end)

   self:updateShare(userData,set)
   self._root_list:getContainer():addChild(set[1])
end

--[[进化]]
function DPetDetailV:updateEvolve( userData )
   -- body
   local dbPet = self.dbInfo
   local orgDbPet = dbManager.getSkinPetOrg(dbPet.skin_id)
   if orgDbPet.ev_pet == nil or #orgDbPet.ev_pet == 0 then
      return
   end
   --找到最原始的pet

   local evolvelen = 1
   local dbPetnext = dbManager.getCharactor(orgDbPet.ev_pet[1])
   evolvelen = evolvelen + ((dbPetnext.ev_pet and 1) or 0)

   local addPetSet = function ( parent,id,dbpet )
      dbpet = dbpet or dbManager.getCharactor(id)
      local set = self:createLuaSet('@pet')
      set['icon']:setResid(res.getPetIcon(dbpet.id))
      set["pz"]:setResid(res.getPetPZ(0))
      set["name"]:setString(dbpet.name)
      if id ~= self.dbInfo.id then
         set[1]:setOpacity(128)
      end
      parent:addChild(set[1])
   end

   local set
   if evolvelen == 1 and #orgDbPet.ev_pet <= 4 then
      set = self:createLuaSet('@evolve1')
   elseif evolvelen == 1 and #orgDbPet.ev_pet > 4 then
      set = self:createLuaSet('@evolve1_8') 
   else
      set = self:createLuaSet('@evolve2')
   end
   
   addPetSet(set['pet'],orgDbPet.id)
   
   for i,v in ipairs(orgDbPet.ev_pet) do
      addPetSet(set['pets'],v)
   end
   set['pets']:layout()

   if evolvelen >= 2 then
      for i,v in ipairs(dbPetnext.ev_pet) do
         addPetSet(set['pets2'],v)
      end
      set['pets2']:layout()
   end

   self._root_list:getContainer():addChild(set[1])
end

--[[羁绊]]
function DPetDetailV:updateFetter( userData )
   local dbPet = self.dbInfo
   if not dbPet.relate_arr or #(dbPet.relate_arr) == 0 then
      return
   end

   local set = self:createLuaSet('@fetter')
   require 'PetNodeHelper'.updateFetter(self,set,dbPet,self.fetterPetIdListWithPartners)

   set['linearlayout']:layout()
   local size = set['linearlayout']:getContentSize()
   local bsize = set['bg1']:getContentSize()
   set['bg1']:setContentSize(CCSizeMake(bsize.width,size.height+20))
   set[1]:setContentSize(CCSizeMake(bsize.width,size.height+40))
   self._root_list:getContainer():addChild(set[1])
end

--[[获取]]
function DPetDetailV:updateLoot( userData )
   
   local set = self:createLuaSet("@loot")   
   local set1  = self:createLuaSet("@lootlayout")
   local dbPet = self.dbInfo
   if (dbPet.capture_city and tostring(dbPet.capture_city) ~='0') or (dbPet.getmode and tostring(dbPet.getmode) ~='0')  then
      self:refreshGetWays(set1[1],dbPet.capture_city,dbPet.getmode)
   end

   set1[1]:layout()
   local h = set1[1]:getContentSize().height
   local H = h+40
   local w = set["bg3"]:getContentSize().width
   set["bg3"]:setContentSize(CCSizeMake(w,H))
   set[1]:setContentSize(CCSizeMake(w,H))
   local x = set["get"]:getPosition()
   set["get"]:setPosition(x,H/2-20)

   set1[1]:setPosition(0,H/2-33)

   set[1]:addChild(set1[1])

   self._root_list:getContainer():addChild(set[1])
end

--[[图鉴存入取出]]
function DPetDetailV:updateStage( userData )
   local size = CCSizeMake(445.0,403.0)
   local size1 = CCSizeMake(445.0,350.0)
   self._root_btnUnStage:setVisible(self.isPetFromDbPet)
   self._root_btnStage:setVisible(self.isPetFromDbPet)
   if self.isPetFromDbPet then
      self._root_list:setContentSize(size1)
      local stagecnt = gameFunc.getPetInfo().getPetArchivedCount(self.nPet.PetId)
      local idlecnt = gameFunc.getPetInfo().getPetAmount(self.nPet.PetId,true)
      
      self._root_btnStage:setEnabled(idlecnt > 0)
      self._root_btnUnStage:setEnabled(stagecnt > 0)

      self._root_btnStage:setListener(function ( ... )
         local param = {}
         param.funcChosePet = function ( Id )
            self:archive(Id,true)
            return true
         end
         param.petTypeId = self.nPet.PetId
         local r1,r2 = gameFunc.getPetInfo().getPetAmount(self.nPet.PetId,true)
         param.petlist = r2 
         self._needRefresh = false
         GleeCore:showLayer('DPetChose',param)
      end)

      self._root_btnUnStage:setListener(function ( ... )
         local param = {}
         param.funcChosePet = function ( Id )
            self:archive(Id,false)
            return true
         end
         param.petTypeId = self.nPet.PetId
         -- param.petlist = gameFunc.getPetInfo().getPetArchived()
         self:send(netModel.getModelPetGetArchived(self.nPet.PetId),function ( netData )
            param.petlist = netData.D.Pets
            self._needRefresh = false
            GleeCore:showLayer('DPetChose',param)
         end)
         
      end)
   else
      self._root_list:setContentSize(size)
   end

end

--[[聊天分享]]
function DPetDetailV:updateShare( userData,base )
   local unlock = require "UnlockManager":isUnlock('Chat')
   base['btnShare']:setListener(function ( ... )
      if not unlock then
         local unlockLv = require 'UnlockManager':getUnlockLv('Chat')
         return self:toast(string.format(Res.locString('Chat$ToastLvlimit'),unlockLv))
      end
      local content = require "ChatInfo".createShareContent(1,self.nPet.Id)
         self:send(require "netModel".getmodelChatSend(1,content,"",1,self.nPet.Id),function ( data )
         return self:toast(res.locString('Global$ShareSuc'))
      end)      
   end)
   base['btnShare']:setVisible(not (userData.isPetFromDbPet or self.isNotMine))
end


--helper
function DPetDetailV:petAttackAction( ... )
   if self.dbInfo and self.dbInfo.voice and tostring(self.dbInfo.voice) ~= '0' then
      require 'framework.helper.MusicHelper'.stopAllEffects()
      require 'framework.helper.MusicHelper'.playEffect(string.format('raw/role_voice/%s',self.dbInfo.voice))
   end
   if self._actionview then
      self._actionview:play('近战攻击',false,function ( ... )
         self._actionview:play("待机",-1)
      end)
   end
end

function DPetDetailV:refreshGetWays( node,capture_city,getmode )

  local TownInfo = gameFunc.getTownInfo()

  local addCity = function ( towntype,townid )
    towntype = tonumber(towntype)
    townid = tonumber(townid)
    
    -- local unlock = TownInfo.isTownOpen(townid,towntype == 2)
    -- local dbtown = dbManager.getInfoTownConfig(townid)
    -- local dbarea = dbManager.getArea(dbtown.AreaId)
    local set = self:createLuaSet('@itemget')
    local updateStagesFunc 
    local refreshCell
    updateStagesFunc = function ( data )
       TownHelper.updateStageData(data.D.Stage,self.nStageList)
       refreshCell()
    end
    refreshCell = function()
       TownHelper.updateSet(self,set,townid,self.nStageList,updateStagesFunc,updateStagesFunc)
    end
    refreshCell()

    node:addChild(set[1])
  end

  local addMode = function ( modeitem )
    local Type,des = unpack(string.split(modeitem,','))
    if Type and (tonumber(Type) == 17 or tonumber(Type) == 15 ) and require 'AccountHelper'.isItemOFF('Vip') then
      return
    end

    local set = self:createLuaSet('@itemm')
    
    Toolkit.setLootIcon(set['icon'],tonumber(Type))
    local fsize = set['frame']:getContentSize()
    local isize = set['icon']:getContentSize()
    set['icon']:setScaleX((fsize.width-8)/(isize.width) * set['frame']:getScaleX())
    set['icon']:setScaleY((fsize.height-8)/(isize.height) * set['frame']:getScaleY())
    set['name']:setString(tostring(des))
    set['lock']:setVisible(false)
    node:addChild(set[1])
  end

  --capture_city = [[2|2004,3008,5013]],
  if capture_city and tostring(capture_city) ~= '0' then
    local towntype,stageids = unpack(string.split(capture_city,'|'))
    stageids = string.split(stageids,',')
    if stageids and #stageids > 0 then
      for i,v in ipairs(stageids) do
        xpcall(function ( ... )
          addCity(towntype,v)
        end,function ( msg )
          print(tostring(msg))
        end)
      end
    end
  end

  --getmode = [[1,精灵召唤(神奇宝贝塔)获得|3,黑市兑换]]
  if getmode and tostring(getmode) ~= '0' then
    local modes = string.split(getmode,'|')
    if modes and #modes > 0 then
      for i,v in ipairs(modes) do
        xpcall(function ( ... )
          addMode(v)
        end,function ( msg )
          print(tostring(msg))
        end)
      end
    end
  end

end

function DPetDetailV:archive( Id,Inflag )
   self:send(netModel.getPetArchive({Id}),function ( data )
      gameFunc.getPetInfo().updatePetArchived(data.D.Pets)
      self:archiveIn(Id,Inflag)
      self:toast(string.format(res.locString('PetDetail$ArchiveRet'),Inflag and res.locString('PetDetail$Stage') or res.locString('PetDetail$unStage')))
   end)
end
function DPetDetailV:archiveIdsInit( ... )
   self._idsarchive = {}
end

function DPetDetailV:archiveIn( Id ,flag)
   self._idsarchive[self.nPet.PetId] = true
   self:updateStage(self:getUserData())
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPetDetailV, "DPetDetailV")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPetDetailV", DPetDetailV)
