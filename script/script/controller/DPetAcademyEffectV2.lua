local Config = require "Config"
local DBManager = require 'DBManager'
local Res = require 'Res'
local GuideHelper = require 'GuideHelper'
local TimerHelper = require 'framework.sync.TimerHelper'

local Launcher = require 'Launcher'
Launcher.register('DPetAcademyEffectV2',function ( userData )

  local onshow = GleeCore:isRunningLayer('DPetAcademyEffectV2')
  if onshow then
    GleeCore:hideLayer('DPetAcademyEffectV2')
    Launcher.Launching()
  else
    Launcher.Launching()
  end
  
end)



local DPetAcademyEffectV2 = class(LuaDialog)

function DPetAcademyEffectV2:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPetAcademyEffectV2.cocos.zip")
    return self._factory:createDocument("DPetAcademyEffectV2.cocos")
end

--@@@@[[[[
function DPetAcademyEffectV2:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_close = set:getButtonNode("root_close")
   self._root_one = set:getElfNode("root_one")
   self._root_one_light = set:getElfNode("root_one_light")
   self._root_one_C = set:getElfNode("root_one_C")
   self._bg = set:getElfNode("bg")
   self._starbg = set:getElfNode("starbg")
   self._pet = set:getClipNode("pet")
   self._pet_icon = set:getElfNode("pet_icon")
   self._bg1 = set:getElfNode("bg1")
   self._isPieces = set:getElfNode("isPieces")
   self._starLayout = set:getLayoutNode("starLayout")
   self._nameBg = set:getElfNode("nameBg")
   self._name = set:getLabelNode("name")
   self._quality = set:getLinearLayoutNode("quality")
   self._quality_layout = set:getLinearLayoutNode("quality_layout")
   self._career = set:getElfNode("career")
   self._rect = set:getRectangleNode("rect")
   self._range = set:getElfNode("range")
   self._root_one_other = set:getElfNode("root_one_other")
   self._root_one_other_btnOnce = set:getClickNode("root_one_other_btnOnce")
   self._root_one_other_linear1 = set:getLinearLayoutNode("root_one_other_linear1")
   self._root_one_other_linear1_V = set:getLabelNode("root_one_other_linear1_V")
   self._root_one_other_linear1_title = set:getLabelNode("root_one_other_linear1_title")
   self._root_one_other_linear = set:getLinearLayoutNode("root_one_other_linear")
   self._root_one_other_linear_icon = set:getElfNode("root_one_other_linear_icon")
   self._root_one_other_linear_price = set:getLabelNode("root_one_other_linear_price")
   self._root_one_other_linear_title = set:getLabelNode("root_one_other_linear_title")
   self._root_one_other_btnConfirm = set:getClickNode("root_one_other_btnConfirm")
   self._root_one_other_btnConfirm_title = set:getLabelNode("root_one_other_btnConfirm_title")
   self._root_title = set:getLinearLayoutNode("root_title")
   self._root_title_elf1 = set:getElfNode("root_title_elf1")
   self._root_title_elf2 = set:getElfNode("root_title_elf2")
   self._root_title_elf3 = set:getElfNode("root_title_elf3")
   self._root_title_elf4 = set:getElfNode("root_title_elf4")
   self._root_ten = set:getElfNode("root_ten")
   self._root_ten_C = set:getLayout2DNode("root_ten_C")
   self._root_ten_other = set:getElfNode("root_ten_other")
   self._root_ten_other_btnTen = set:getClickNode("root_ten_other_btnTen")
   self._root_ten_other_linear = set:getLinearLayoutNode("root_ten_other_linear")
   self._root_ten_other_linear_icon = set:getElfNode("root_ten_other_linear_icon")
   self._root_ten_other_linear_price = set:getLabelNode("root_ten_other_linear_price")
   self._root_ten_other_linear_title = set:getLabelNode("root_ten_other_linear_title")
   self._root_ten_other_btnConfirm = set:getClickNode("root_ten_other_btnConfirm")
   self._root_ten_other_btnConfirm_title = set:getLabelNode("root_ten_other_btnConfirm_title")
   self._root_ten_other_linear2 = set:getLinearLayoutNode("root_ten_other_linear2")
   self._root_ten_other_linear2_V = set:getLabelNode("root_ten_other_linear2_V")
   self._root_ten_other_linear2_title = set:getLabelNode("root_ten_other_linear2_title")
   self._root_anim = set:getElfMotionNode("root_anim")
   self._root_anim_KeyStorage = set:getElfNode("root_anim_KeyStorage")
   self._root_anim_KeyStorage_qiu_Visible = set:getElfNode("root_anim_KeyStorage_qiu_Visible")
   self._root_anim_KeyStorage_jpganim_Scale = set:getElfNode("root_anim_KeyStorage_jpganim_Scale")
   self._root_anim_KeyStorage_jpganim_Visible = set:getElfNode("root_anim_KeyStorage_jpganim_Visible")
   self._root_anim_jpganim = set:getSimpleAnimateNode("root_anim_jpganim")
   self._root_anim_qiu = set:getAnimateNode("root_anim_qiu")
   self._root_anim_qiu_f0_f1 = set:getElfNode("root_anim_qiu_f0_f1")
   self._root_anim_qiu_f1_f2 = set:getElfNode("root_anim_qiu_f1_f2")
   self._root_anim_qiu_f2_f3 = set:getElfNode("root_anim_qiu_f2_f3")
   self._root_anim_qiu_f3_f4 = set:getElfNode("root_anim_qiu_f3_f4")
   self._root_anim_qiu_f4_f5 = set:getElfNode("root_anim_qiu_f4_f5")
   self._root_anim_qiu_f5_f6 = set:getElfNode("root_anim_qiu_f5_f6")
   self._root_anim_qiu_f6_f7 = set:getElfNode("root_anim_qiu_f6_f7")
   self._root_anim_qiu_f7_f8 = set:getElfNode("root_anim_qiu_f7_f8")
   self._root_anim_qiu_f8_f9 = set:getElfNode("root_anim_qiu_f8_f9")
   self._root_anim_qiu_f9_f10 = set:getElfNode("root_anim_qiu_f9_f10")
   self._root_anim_qiu_f10_f11 = set:getElfNode("root_anim_qiu_f10_f11")
   self._root_anim_qiu_f11_f12 = set:getElfNode("root_anim_qiu_f11_f12")
   self._root_anim_qiu_f12_f13 = set:getElfNode("root_anim_qiu_f12_f13")
   self._root_anim_qiu_f13_f14 = set:getElfNode("root_anim_qiu_f13_f14")
   self._root_anim_qiu_f14_f15 = set:getElfNode("root_anim_qiu_f14_f15")
   self._root_failed = set:getElfNode("root_failed")
   self._roate = set:getElfAction("roate")
   self._down = set:getElfAction("down")
   self._fade = set:getElfAction("fade")
   self._roate2 = set:getElfAction("roate2")
   self._downcell = set:getElfAction("downcell")
   self._rotatelight = set:getElfAction("rotatelight")
   self._blin = set:getElfAction("blin")
--   self._@petcell = set:getElfNode("@petcell")
--   self._@star = set:getElfNode("@star")
--   self._@num = set:getElfNode("@num")
--   self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DPetAcademyEffectV2:onInit( userData, netData )
  local pets = userData.pets

  local againFunc = function ( ... )
    return userData and userData.again and userData.again()
  end

  local doFunc
  if pets and #pets == 1 then
    self._root_one_other_linear:setVisible(userData.useCoin)
    self._root_one_other_linear1:setVisible(not userData.useCoin)
    if userData.useCoin and userData.coinNum then
      self._root_one_other_linear_price:setString(tostring(userData.coinNum))
    elseif userData.useCoin then
      local db1 = DBManager.getInfoDefaultConfig('NiudanCost')
      local oneprice = (db1 and db1.Value) or '260'
      self._root_one_other_linear_price:setString(tostring(oneprice))
    else
      self._root_one_other_linear1_V:setString('10')
    end
    
    self._root_one_other_btnOnce:setListener(againFunc)
    doFunc = function ( ... )
      self:showOne(pets[1])
    end
    GuideHelper:registerPoint('确定',self._root_one_other_btnConfirm)
    
    if userData.again == nil then
      self._root_one_other_btnConfirm:setPosition(ccp(0,0))
      self._root_one_other_linear1:setVisible(false)
      self._root_one_other_linear:setVisible(false)
      self._root_one_other_btnOnce:setVisible(false)
    end
  elseif userData and userData.failed then
    doFunc = function ( ... )
      self._root_title:setVisible(false)
      self._root_one:setVisible(false)
      self._root_ten:setVisible(false)
      self._root_failed:setVisible(true)
      self._root_failed:setOpacity(0)
      self._root_failed:runElfAction(self._fade:clone())
      self._root_close:setEnabled(true)
      self._root_close:setVisible(true)
      self._root_close:setListener(function ( ... )
        self:close()
        return userData.callback and userData.callback()
      end)
    end
  else
    if userData.useCoin then
      local db10 = DBManager.getInfoDefaultConfig('Niudan10Cost')
      local tenprice = userData.coinNum or ((db10 and db10.Value) or '2340')
      self._root_ten_other_linear_price:setString(tostring(tenprice))
      self._root_ten_other_btnTen:setListener(againFunc)
      doFunc = function ( ... )
        self:showTen(pets)
      end
    else --使用100张扭蛋卡
    		if require "AppData".getBagInfo().getItemCount(22)>=100 then
		      self._root_ten_other_linear:setVisible(false)
		      self._root_ten_other_linear2:setVisible(true)
		      self._root_ten_other_linear2_V:setString('100')
		      self._root_ten_other_btnTen:setListener(againFunc)
		else
			local x,y = self._root_ten_other_btnConfirm:getPosition()
			self._root_ten_other_btnConfirm:setPosition(ccp(0,y))
		      	self._root_ten_other_linear2:setVisible(false)
		      	self._root_ten_other_linear:setVisible(false)
		      	self._root_ten_other_btnTen:setVisible(false)
		end
	      doFunc = function ( ... )
	        self:showTen(pets)
	      end
    end

  end

  self._root_anim_jpganim:reset()
  self._root_anim_jpganim:setLoops(1)
  -- self._root_anim_jpganim:start()
  self._root_anim_jpganim:setVisible(false)
  self._root_anim_qiu:reset()
  self._root_anim_qiu:setVisible(false)
  

  self._root_one:setVisible(false)
  self._root_ten:setVisible(false)
  self._root_title:setVisible(false)
  self._root_anim:setVisible(true)
  self._root_anim:setListener(function ( ... )
    self._root_anim:setVisible(false)
    self:runWithDelay(function ( ... )
      self._root_title:setVisible(true)
      self._root_close:setVisible(false)
      return doFunc and doFunc()
    end)
  end)
  SystemHelper:setIgnoreBigTimeDelta(true)

  if Config.LangName == 'english' then
    self._root_anim:setVisible(false)
    self:runWithDelay(function ( ... )
      self._root_title:setVisible(true)
      return doFunc and doFunc()
    end)
  else
    self._root_anim:runAnimate(0,2400)
    require 'framework.helper.MusicHelper'.playEffect(Res.Sound.ui_summon)

    self._root_close:setVisible(true)
    self._root_close:setEnabled(true)
    self._root_close:setListener(function ( ... )
      self._root_anim:setVisible(false)
      self._root_close:setVisible(false)
      self._root_title:setVisible(true)
      return doFunc and doFunc()
    end)

  end

  require 'LangAdapter'.LabelNodeAutoShrink(self._root_one_other_linear_title,130)
  require 'LangAdapter'.LabelNodeAutoShrink(self._root_one_other_linear_price,38)
  require 'LangAdapter'.LabelNodeAutoShrink(self._root_ten_other_linear_price,38)
  require 'LangAdapter'.LabelNodeAutoShrink(self._root_ten_other_linear_title,130)
end

function DPetAcademyEffectV2:showOne( nPet )
  self._root_one:setVisible(true)
  self._root_ten:setVisible(false)
  
  self._root_one_C:removeAllChildrenWithCleanup(true)
  local set = self:createLuaSet('@petcell')
  self:refreshPetCell(set,nPet)
  self._root_one_C:addChild(set[1])
  self._root_one_other:setVisible(false)
  self._root_title:setScale(3)
  
  set[1]:setVisible(false)
  set[1]:setScale(2)
  set['rect']:setOpacity(0.5)
  self._root_one_light:setVisible(false)
  local action = self._down:clone()
  action:setListener(function ( ... )
    set[1]:setVisible(true)
    set['rect']:runElfAction(CCFadeOut:create(0.2))
    action = self._downcell:clone()
    action:setListener(function ( ... )
      require 'framework.helper.MusicHelper'.playEffect(Res.Sound.ui_reward)
      self._root_one_other:setVisible(true)
      self._root_one_other:setOpacity(0)
      self._root_one_other:runElfAction(self._fade:clone())
      self._root_one_light:setVisible(true)
      self._root_one_light:runElfAction(self._rotatelight:clone())
    end)
    set[1]:runElfAction(action)
  end)
  self._root_title:runElfAction(action)
  self._root_one_other_btnConfirm:setListener(function ( ... )
    self:close()
  end)
end

function DPetAcademyEffectV2:onBack( userData, netData )
	
end

function DPetAcademyEffectV2:close( ... )
  SystemHelper:setIgnoreBigTimeDelta(false)

  self:releaseTick()
  GuideHelper:check('closeDialog')
  GuideHelper:check('AnimtionEnd')
end
--------------------------------custom code-----------------------------

function DPetAcademyEffectV2:showTen( pets )
  self._root_one:setVisible(false)
  self._root_ten:setVisible(true)

  self._root_ten_C:removeAllChildrenWithCleanup(true)

  local scalexy = 0.58
  local actions = CCArray:create()
  for i=1,#pets do
    local set     = self:createLuaSet('@petcell')
    local spec    = self:refreshPetCell(set,pets[i])
    self._root_ten_C:addChild(set[1])
    local arr = CCArray:create()
    arr:addObject(CCCallFunc:create(function ( ... )
      require 'framework.helper.MusicHelper'.playEffect(Res.Sound.ui_reward)
    end))

    set[1]:setScale(0)
    arr:addObject(CCRotateBy:create(0.3,360))
    arr:addObject(CCScaleTo:create(0.3,scalexy))
    actions:addObject(CCTargetedAction:create(set[1],CCSpawn:create(arr)))

    if spec then
      local arr = CCArray:create()
      arr:addObject(CCScaleTo:create(0.1,1.5))
      arr:addObject(CCDelayTime:create(0.3))
      arr:addObject(CCScaleTo:create(0.05,scalexy*0.8))
      arr:addObject(CCScaleTo:create(0.05,scalexy*1.2))
      arr:addObject(CCScaleTo:create(0.05,scalexy))
      actions:addObject(CCTargetedAction:create(set[1],CCSequence:create(arr)))  
    end
  end
  self._root_ten_C:layout()
  actions:addObject(CCCallFunc:create(function ( ... )
    self._root_ten_other:setVisible(true)
    self._root_ten_other:setOpacity(0)
    self._root_ten_other:runElfAction(self._fade:clone())
  end))

  actions:retain()
  local action = self._down:clone()
  action:setListener(function ( ... )
    self._root_ten:runElfAction(CCSequence:create(actions))
    actions:release()
  end)
  self._root_title:runElfAction(action)
  
  self._root_ten_other:setVisible(false)  
  self._root_title:setScale(3)

  self._root_ten_other_btnConfirm:setListener(function ( ... )
    self:close()
  end)
end

function DPetAcademyEffectV2:getnums( number,spec )
  local tmp = {}
  local index = 1
  local resname = (spec and 'JLXY1_wenzi') or 'JLXY_wenzi'
  while(number > 0) do
    tmp[index]=string.format('%s%d.png',resname,number%10)
    number = math.floor(number/10)
    index = index + 1
  end
  return tmp
end

function DPetAcademyEffectV2:refreshPetCell( set,nPet )
  local dbPet = DBManager.getCharactor(nPet.PetId)
  local spec  = (not nPet.isPieces and dbPet.star_level >= 5) or dbPet.star_level >= 6
  set['name']:setString(dbPet.name)
  set['rect']:setOpacity(0)
  set['isPieces']:setVisible(nPet.isPieces)
  
  require 'PetNodeHelper'.updateStarLayout(set['starLayout'],dbPet)
  
  set['quality_layout']:removeAllChildrenWithCleanup(true)
  local nums = self:getnums(dbPet.quality,spec)
  for i=#nums,1,-1 do
    local numset = self:createLuaSet('@num')
    numset[1]:setResid(nums[i])
    set['quality_layout']:addChild(numset[1])
  end
  set['career']:setResid(Res.getPetCareerIcon(dbPet.atk_method_system))
  nums[1]=dbPet.quality/10
  nums[2]=dbPet.quality%10
  set['pet_icon']:setResid(Res.getPetWithPetId(nPet.PetId))
  Res.adjustPetIconPositionInParentLT(set['pet'],set['pet_icon'],dbPet.id,'academy',0) 

  set['starbg']:setVisible(spec)
  if spec then
    local update = function ( ... )
      for i=1,5 do
        self:runWithDelay(function ( ... )
          local itemset = self:createLuaSet('@item')
          local action  = self._blin:clone()
          local size = set['range']:getContentSize()
          local starnode = itemset[1]

          local nodesize = starnode:getContentSize()
          local x = math.random(-(size.width/2-nodesize.width/2),size.width/2-nodesize.width/2)
          local y = math.random(-(size.height/2-nodesize.height/2),size.height/2-nodesize.height/2)
          starnode:setPosition(ccp(x,y))
          starnode:setScale(math.random(0.3,1))
          set['range']:addChild(starnode)
          action:setListener(function ( ... )
            starnode:removeFromParentAndCleanup(true)
          end)
          starnode:runElfAction(action)
        end,i*0.15)
      end
    end
    self:startTick(update,1)
  end

  return spec 
end

function DPetAcademyEffectV2:startTick( func,du)
  self.handles = self.handles or {}
  self.handles[#self.handles+1] = TimerHelper.tick(func,du)
end

function DPetAcademyEffectV2:releaseTick( ... )
  if self.handles then
    for i,v in ipairs(self.handles) do
      TimerHelper.cancel(v)
    end
  end
  self.handles = nil
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPetAcademyEffectV2, "DPetAcademyEffectV2")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPetAcademyEffectV2", DPetAcademyEffectV2)

return DPetAcademyEffectV2
