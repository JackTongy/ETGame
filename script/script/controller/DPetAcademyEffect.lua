local Config = require "Config"
local Res = require 'Res'
local DBManager = require 'DBManager'
local GuideHelper = require 'GuideHelper'

local DPetAcademyEffect = class(LuaDialog)

function DPetAcademyEffect:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPetAcademyEffect.cocos.zip")
    return self._factory:createDocument("DPetAcademyEffect.cocos")
end

--@@@@[[[[
function DPetAcademyEffect:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_unvpet = set:getElfNode("root_unvpet")
   self._root_niudan = set:getFlashMainNode("root_niudan")
   self._root_niudan_root = set:getElfNode("root_niudan_root")
   self._root_niudan_root_tag1 = set:getElfNode("root_niudan_root_tag1")
   self._root_niudan_root_tag2 = set:getElfNode("root_niudan_root_tag2")
   self._root_niudan_root_tag3 = set:getElfNode("root_niudan_root_tag3")
   self._root_niudan_root_tag4 = set:getElfNode("root_niudan_root_tag4")
   self._root_niudan_root_tag5 = set:getElfNode("root_niudan_root_tag5")
   self._root_niudan_root_tag6 = set:getElfNode("root_niudan_root_tag6")
   self._root_niudan_root_tag7 = set:getElfNode("root_niudan_root_tag7")
   self._root_motion = set:getElfNode("root_motion")
   self._root_motion_secondbg = set:getElfNode("root_motion_secondbg")
   self._root_motion_skipclick = set:getButtonNode("root_motion_skipclick")
   self._root_motion_nextclick = set:getButtonNode("root_motion_nextclick")
   self._pet = set:getAddColorNode("pet")
   self._info = set:getElfNode("info")
   self._info_career = set:getElfNode("info_career")
   self._info_property = set:getElfNode("info_property")
   self._info_atk = set:getLinearLayoutNode("info_atk")
   self._info_atk_V = set:getLabelNode("info_atk_V")
   self._info_dfd = set:getLinearLayoutNode("info_dfd")
   self._info_dfd_V = set:getLabelNode("info_dfd_V")
   self._info_hp = set:getLinearLayoutNode("info_hp")
   self._info_hp_V = set:getLabelNode("info_hp_V")
   self._info_name = set:getLabelNode("info_name")
   self._info_starLayout = set:getLayoutNode("info_starLayout")
   self._in = set:getElfAction("in")
   self._scaleFit = set:getElfAction("scaleFit")
   self._out = set:getElfAction("out")
   self._scaleMin = set:getElfAction("scaleMin")
   self._scaleNormal = set:getElfAction("scaleNormal")
   self._infoIn = set:getElfAction("infoIn")
--   self._@detail = set:getElfNode("@detail")
--   self._@star = set:getElfNode("@star")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DPetAcademyEffect:onInit( userData, netData )
  
  self._root_motion_secondbg:setVisible(false)
  local ctrl = self._root_niudan:getCurrModifierController()
  -- ctrl:setFPS(5)
  local fv_role = ctrl:getFullPropertyModifierVectorByTarget(self._root_niudan_root_tag5)
  local fv_role2 = ctrl:getFullPropertyModifierVectorByTarget(self._root_niudan_root_tag2)
  local fv_role3 = ctrl:getFullPropertyModifierVectorByTarget(self._root_niudan_root_tag3)

  local pet = self:getPetAt(1)
  local resid = Res.getPetWithPetId(pet.PetId)
  fv_role:setKeyResid(resid,49,65)
  self._root_unvpet:setResid(resid)
  -- fv_role2:setKeyResid(resid,65,71)
  fv_role3:setKeyResid("null",24,30)
  -- fv_dan:setKeyResid('jinglingqiu.png',18,65)
  local config = Res.getPetPositionConfig(pet.PetId,'info')
  if config then
    local scale = config['info_scale']
    fv_role:setKeyScale(ccp(scale,math.abs(scale)),52,65)
    
    --[[
      swf tag5 endpos = (-165.0,-2) anrp(0.6879862,0.47953218)
    ]]
    -- 1 求配置设定的cpos
    local opos = {x=-568,y=320}
    local cpos = {x=opos.x+config['info_x'],y=opos.y-config['info_y']}
    -- 2 转化为当前anrp的cpos
    local anrpox = 0.6879862 - 0.5  -- +
    local anrpoy = 0.47953218 - 0.5 -- +
    local size = self._root_unvpet:getContentSize()
    cpos = {x=cpos.x+anrpox*size.width,y=cpos.y+anrpoy*size.height}
    -- 3 cpos与endpos得出offsetxy
    local offsetx = cpos.x - (-165)
    local offsety = cpos.y - (-2)

    fv_role:translateKeyPos(ccp(offsetx,offsety),49,65)
  end

  ctrl:setLoopMode(STAY)
  ctrl:setLoops(1)
  self._nowShowIndex = 0
  self._flashDone = false
  self._root_niudan:playWithCallback('swf',function ( ... )
    self:showDetail(1)
    self._flashDone = true
  end)
  
  require 'framework.helper.MusicHelper'.playEffect('raw/ui_sfx_summon.mp3')
  self._root_motion_skipclick:setVisible(false)
  self._root_motion_nextclick:setListener(function ( ... )
    local nextpet = self:getNextPet()
    if not nextpet then
      self:closeDelay()
    else
      self._root_motion_secondbg:setVisible(true)
      self:showDetail(1,true)
      self._root_motion_skipclick:setVisible(true)
      self._root_motion_nextclick:setListener(function ( ... )
        if not self:showNextDetail() then
          self:closeDelay()
        end
      end)

      if self._flashDone == true then
        self._root_motion_nextclick:trigger(nil)
      end

    end

  end)

  self._root_motion_skipclick:setListener(function ( ... )
    self:skipInOutAction()
  end)

end

function DPetAcademyEffect:onBack( userData, netData )
	
end

function DPetAcademyEffect:close( ... )
  GuideHelper:check('AnimtionEnd')
end
--------------------------------custom code-----------------------------

function DPetAcademyEffect:closeDelay( ... )
  self:runWithDelay(function ( ... )
    self:close()
    self._setIn = nil
    self._setOut = nil
    self:releaseTick()
  end,(self._flashDone and 0) or 1)
  self._root_motion_skipclick:setVisible(false)
  self._root_motion_nextclick:setVisible(false)
end

function DPetAcademyEffect:showDetail( index,petshow )
  require 'framework.helper.MusicHelper'.stopAllEffects()
  if self._nowShowIndex >= index then
    return
  end
  self._nowShowIndex = index

  --区分第一个与之后几个pet
  if index ~= 1 then
    self:swapSetInOut()
    local set = self:getDetailSetIn()
    self:refreshDetailSetIn(set,index,false)
    self:actionBegin()
    self:runInAction()
    self:runOutAction()
  else
    local setin = self:getDetailSetIn()
    self:refreshDetailSetIn(setin,index,true,petshow)
  end

  self:resetTick()

end

function DPetAcademyEffect:showNextDetail( ... )
  local nextpet = self:getPetAt(self._nowShowIndex+1)
  if nextpet then
    self:showDetail(self._nowShowIndex+1)
    return true
  end
  return false
end

function DPetAcademyEffect:getNextPet( ... )
  local nextpet = self:getPetAt(self._nowShowIndex+1)
  return nextpet
end

function DPetAcademyEffect:skipInOutAction( ... )
    local setin = self:getDetailSetIn()
    local setout = self:getDetailSetOut()

    setin[1]:stopAllActions()
    setout[1]:stopAllActions()

    setin[1]:setPosition(ccp(0,0))
    setout[1]:setPosition(ccp(1500,0))
    self:actionEnable(false,setin['pet'])
    self:actionEnable(false,setout['pet'])
    self:infoActionEnd(setin)
    self:infoActionEnd(setout)
end

function DPetAcademyEffect:actionBegin( ... )
  self._root_motion_nextclick:setVisible(false)
  self._root_motion_skipclick:setVisible(true)
end

function DPetAcademyEffect:actionEnd( ... )
  self._root_motion_nextclick:setVisible(true)
  self._root_motion_skipclick:setVisible(false)

  if self._dbPet and self._dbPet.voice and tostring(self._dbPet.voice) ~= '0' then
    require 'framework.helper.MusicHelper'.stopAllEffects()
    require 'framework.helper.MusicHelper'.playEffect(string.format('raw/role_voice/%s',self._dbPet.voice))
  end
end

function DPetAcademyEffect:runOutAction( callback )
  local set = self:getDetailSetOut()
  self._root_motion_secondbg:setVisible(true)
  set[1]:setVisible(true)
  set['pet']:setVisible(true)
  
  local action = self._out:clone()
  action:setListener(function ( ... )
    if callback then
      callback()
    end  
    self:runWithDelay(function ( ... )
      self:actionEnable(false,set['pet'])
    end)
  end)
  
  self:actionEnable(true,set['pet'])
  set[1]:runElfAction(action)
end

function DPetAcademyEffect:runInAction( callback )
  local set = self:getDetailSetIn()

  local action = self._in:clone()
  action:setListener(function ( ... )
    if callback then
      callback()
    end
    self:runInfoInAction(set)
    self:runWithDelay(function ( ... )
      self:actionEnable(false,set['pet'])
    end)
  end)
  
  self:actionEnable(true,set['pet'])
  set[1]:runElfAction(action)
end

function DPetAcademyEffect:runInfoInAction( set )
  set['info']:setScaleY(0.8)
  local action = self._infoIn:clone()
  action:setListener(function ( ... )
    set['info']:runElfAction(self._scaleNormal:clone())
    if set.starActionFunc then
      set.starActionFunc()
    end
  end)
  set['info']:runElfAction(action)
end

function DPetAcademyEffect:infoActionEnd( set )
  set['info']:setScaleY(1)
  set['info']:stopAllActions()
  if set.starActionEnd then
    set.starActionEnd()
  end
  set['info']:setPosition(ccp(217,-68))
end

function DPetAcademyEffect:getDetailSetIn(  )
  if self._setIn == nil then
    self._setIn = self:createLuaSet('@detail')
    self._root_motion:addChild(self._setIn[1],4000)
  end
  return self._setIn
end

function DPetAcademyEffect:getDetailSetOut( ... )
  if self._setOut == nil then
    self._setOut = self:createLuaSet('@detail')
    self._root_motion:addChild(self._setOut[1],4000)
  end
  return self._setOut
end

function DPetAcademyEffect:swapSetInOut( ... )
  local setin = self:getDetailSetIn()
  local setout = self:getDetailSetOut()
  self._setIn = setout
  self._setOut = setin
end

--初始化精灵出现时的信息
function DPetAcademyEffect:refreshDetailSetIn( set,index,first,petshow )
  local pet = self:getPetAt(index)
  local dbPet = DBManager.getCharactor(pet.PetId)
  self._dbPet = dbPet
  set['info_name']:setString(dbPet.name)
  set['info_atk_V']:setString(dbPet.atk)
  set['info_dfd_V']:setString(dbPet.def)
  set['info_hp_V']:setString(dbPet.hp)
  set['info_career']:setResid(Res.getPetCareerIcon(dbPet.atk_method_system,true))
  set['info_property']:setResid(Res.getPetPropertyIcon(dbPet.prop_1,true))
  set['info_starLayout']:removeAllChildrenWithCleanup(true)

  local stars = {}
  for i=1,dbPet.star_level do
    local star = self:createLuaSet("@star")
    star[1]:setResid(Res.getStarResid(pet.MotiCnt))
    star[1]:setColorf(1.0,1.0,1.0,0.0)
    set['info_starLayout']:addChild(star[1])
    table.insert(stars,star)
  end

  --设置星星出现的动画
  set.starActionEnd = function ( ... )
    for i,v in ipairs(stars) do
      v[1]:stopAllActions()
      v[1]:setColorf(1.0,1.0,1.0,1.0)
      v[1]:setScale(0.3)  
    end  
    self:actionEnd()
  end

  set.starActionFunc = function ( ... )
    local starAction = dbPet.star_level >= 5
    local delay = 0
    if starAction then
      for i,v in ipairs(stars) do
        self:runWithDelay(function ( ... )
          v[1]:runElfAction(self._scaleFit:clone())
        end,(i-1)*0.15,v[1])
        delay = delay + (i-1)*0.15
      end
    else
      for i,v in ipairs(stars) do
        v[1]:setColorf(1.0,1.0,1.0,1.0)
      end
    end

    self:runWithDelay(function ( ... )
      set.starActionEnd()
    end,delay+0.15)    
  end
  
  --设置精灵形像
  if Res.getPetPositionConfig(pet.PetId,'info') then
    set['pet']:setPosition(-568,320)
  end
  Res.adjustPetIconPosition(set['pet'],pet.PetId,'info')

  --初始化info的位置(屏幕之外) 正常显示位置(217.0,-68.0)
  set['info']:setPosition(ccp(660,-68))
  set[1]:setPosition(ccp(1500,0))
  set[1]:setScale(1)

  set['pet']:setVisible(not first or petshow)
  if first then
    self:runInfoInAction(set)
    set[1]:setPosition(ccp(0,0))
  end

end

function DPetAcademyEffect:actionEnable( enable,addcolornode )
  if addcolornode and enable then
    -- local SwfActionFactory = require 'framework.swf.SwfActionFactory'
    -- local tableData = require 'ActionBiSha'
    -- local a1 = SwfActionFactory.createPureAction(tableData.array[1],nil,nil,10)
    -- local action1 = CCRepeatForever:create(a1)
    -- addcolornode:runElfAction(action1)
    addcolornode:setAddColor(0.3,0.3,0.3,0)
  elseif addcolornode then
    addcolornode:stopAllActions()
    addcolornode:setAddColor(0,0,0,0)
    addcolornode:setColorf(1,1,1,1)
  end
end

function DPetAcademyEffect:getPetAt( index )
  local userData = self:getUserData()
  local petlist = userData

  if petlist then
    return petlist[index]
  end

  return nil

end

function DPetAcademyEffect:resetTick( ... )
  self:releaseTick()
  if self.tick == nil and self.handle == nil then
    local tick = require 'framework.sync.TimerHelper'
    self.tick = tick
    local fUpdateTime = function ( ... )
      self:showNextDetail()
    end
    self.handle = tick.tick(fUpdateTime,3)
  end
end

function DPetAcademyEffect:releaseTick( ... )
  if self.handle and self.tick then
    self.tick.cancel(self.handle)
    self.tick = nil
    self.handle = nil
  end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPetAcademyEffect, "DPetAcademyEffect")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPetAcademyEffect", DPetAcademyEffect)
