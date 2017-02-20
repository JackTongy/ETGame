local Config = require "Config"
local res = require 'Res'
local DFosterAwakeResult = class(LuaDialog)

function DFosterAwakeResult:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DFosterAwakeResult.cocos.zip")
    return self._factory:createDocument("DFosterAwakeResult.cocos")
end

--@@@@[[[[
function DFosterAwakeResult:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_motion2 = set:getElfMotionNode("root_motion2")
   self._root_motion2_KeyStorage = set:getElfNode("root_motion2_KeyStorage")
   self._root_motion2_KeyStorage_juexing3_Visible = set:getElfNode("root_motion2_KeyStorage_juexing3_Visible")
   self._root_motion2_KeyStorage_ball2_Visible = set:getElfNode("root_motion2_KeyStorage_ball2_Visible")
   self._root_motion2_KeyStorage_ball1_Visible = set:getElfNode("root_motion2_KeyStorage_ball1_Visible")
   self._root_motion2_KeyStorage_juexing2_Visible = set:getElfNode("root_motion2_KeyStorage_juexing2_Visible")
   self._root_motion2_KeyStorage_juexing4_Visible = set:getElfNode("root_motion2_KeyStorage_juexing4_Visible")
   self._root_motion2_KeyStorage_juexing1_Visible = set:getElfNode("root_motion2_KeyStorage_juexing1_Visible")
   self._root_motion2_KeyStorage_ball1_Position = set:getElfNode("root_motion2_KeyStorage_ball1_Position")
   self._root_motion2_KeyStorage_ball2_Position = set:getElfNode("root_motion2_KeyStorage_ball2_Position")
   self._root_motion2_KeyStorage_juexing3_1_Visible = set:getElfNode("root_motion2_KeyStorage_juexing3_1_Visible")
   self._root_motion2_juexing3 = set:getSimpleAnimateNode("root_motion2_juexing3")
   self._root_motion2_juexing3_1 = set:getSimpleAnimateNode("root_motion2_juexing3_1")
   self._root_motion2_juexing1 = set:getSimpleAnimateNode("root_motion2_juexing1")
   self._root_motion2_juexing4 = set:getSimpleAnimateNode("root_motion2_juexing4")
   self._root_motion2_juexing2 = set:getSimpleAnimateNode("root_motion2_juexing2")
   self._root_motion2_ball1 = set:getSimpleAnimateNode("root_motion2_ball1")
   self._root_motion2_ball2 = set:getSimpleAnimateNode("root_motion2_ball2")
   self._root_motion2_bgclick = set:getClickNode("root_motion2_bgclick")
   self._root_motion3 = set:getElfMotionNode("root_motion3")
   self._root_motion3_KeyStorage = set:getElfNode("root_motion3_KeyStorage")
   self._root_motion3_KeyStorage_juexing3_Visible = set:getElfNode("root_motion3_KeyStorage_juexing3_Visible")
   self._root_motion3_KeyStorage_ball2_Visible = set:getElfNode("root_motion3_KeyStorage_ball2_Visible")
   self._root_motion3_KeyStorage_ball1_Visible = set:getElfNode("root_motion3_KeyStorage_ball1_Visible")
   self._root_motion3_KeyStorage_juexing2_Visible = set:getElfNode("root_motion3_KeyStorage_juexing2_Visible")
   self._root_motion3_KeyStorage_juexing4_Visible = set:getElfNode("root_motion3_KeyStorage_juexing4_Visible")
   self._root_motion3_KeyStorage_juexing1_Visible = set:getElfNode("root_motion3_KeyStorage_juexing1_Visible")
   self._root_motion3_KeyStorage_ball1_Position = set:getElfNode("root_motion3_KeyStorage_ball1_Position")
   self._root_motion3_KeyStorage_ball2_Position = set:getElfNode("root_motion3_KeyStorage_ball2_Position")
   self._root_motion3_KeyStorage_juexing3_1_Visible = set:getElfNode("root_motion3_KeyStorage_juexing3_1_Visible")
   self._root_motion3_KeyStorage_juexing3_2_Visible = set:getElfNode("root_motion3_KeyStorage_juexing3_2_Visible")
   self._root_motion3_KeyStorage_ball3_Visible = set:getElfNode("root_motion3_KeyStorage_ball3_Visible")
   self._root_motion3_KeyStorage_ball3_Position = set:getElfNode("root_motion3_KeyStorage_ball3_Position")
   self._root_motion3_juexing3 = set:getSimpleAnimateNode("root_motion3_juexing3")
   self._root_motion3_juexing3_1 = set:getSimpleAnimateNode("root_motion3_juexing3_1")
   self._root_motion3_juexing3_2 = set:getSimpleAnimateNode("root_motion3_juexing3_2")
   self._root_motion3_juexing1 = set:getSimpleAnimateNode("root_motion3_juexing1")
   self._root_motion3_juexing4 = set:getSimpleAnimateNode("root_motion3_juexing4")
   self._root_motion3_juexing2 = set:getSimpleAnimateNode("root_motion3_juexing2")
   self._root_motion3_ball1 = set:getSimpleAnimateNode("root_motion3_ball1")
   self._root_motion3_ball2 = set:getSimpleAnimateNode("root_motion3_ball2")
   self._root_motion3_ball3 = set:getSimpleAnimateNode("root_motion3_ball3")
   self._root_motion3_bgclick = set:getClickNode("root_motion3_bgclick")
   self._root_motion4 = set:getElfMotionNode("root_motion4")
   self._root_motion4_KeyStorage = set:getElfNode("root_motion4_KeyStorage")
   self._root_motion4_KeyStorage_juexing3_Visible = set:getElfNode("root_motion4_KeyStorage_juexing3_Visible")
   self._root_motion4_KeyStorage_ball2_Visible = set:getElfNode("root_motion4_KeyStorage_ball2_Visible")
   self._root_motion4_KeyStorage_ball1_Visible = set:getElfNode("root_motion4_KeyStorage_ball1_Visible")
   self._root_motion4_KeyStorage_juexing2_Visible = set:getElfNode("root_motion4_KeyStorage_juexing2_Visible")
   self._root_motion4_KeyStorage_juexing4_Visible = set:getElfNode("root_motion4_KeyStorage_juexing4_Visible")
   self._root_motion4_KeyStorage_juexing1_Visible = set:getElfNode("root_motion4_KeyStorage_juexing1_Visible")
   self._root_motion4_KeyStorage_ball1_Position = set:getElfNode("root_motion4_KeyStorage_ball1_Position")
   self._root_motion4_KeyStorage_ball2_Position = set:getElfNode("root_motion4_KeyStorage_ball2_Position")
   self._root_motion4_KeyStorage_juexing3_1_Visible = set:getElfNode("root_motion4_KeyStorage_juexing3_1_Visible")
   self._root_motion4_KeyStorage_juexing3_2_Visible = set:getElfNode("root_motion4_KeyStorage_juexing3_2_Visible")
   self._root_motion4_KeyStorage_ball3_Visible = set:getElfNode("root_motion4_KeyStorage_ball3_Visible")
   self._root_motion4_KeyStorage_ball3_Position = set:getElfNode("root_motion4_KeyStorage_ball3_Position")
   self._root_motion4_KeyStorage_juexing3_3_Visible = set:getElfNode("root_motion4_KeyStorage_juexing3_3_Visible")
   self._root_motion4_KeyStorage_ball4_Position = set:getElfNode("root_motion4_KeyStorage_ball4_Position")
   self._root_motion4_KeyStorage_ball4_Visible = set:getElfNode("root_motion4_KeyStorage_ball4_Visible")
   self._root_motion4_juexing3 = set:getSimpleAnimateNode("root_motion4_juexing3")
   self._root_motion4_juexing3_1 = set:getSimpleAnimateNode("root_motion4_juexing3_1")
   self._root_motion4_juexing3_2 = set:getSimpleAnimateNode("root_motion4_juexing3_2")
   self._root_motion4_juexing3_3 = set:getSimpleAnimateNode("root_motion4_juexing3_3")
   self._root_motion4_juexing1 = set:getSimpleAnimateNode("root_motion4_juexing1")
   self._root_motion4_juexing4 = set:getSimpleAnimateNode("root_motion4_juexing4")
   self._root_motion4_juexing2 = set:getSimpleAnimateNode("root_motion4_juexing2")
   self._root_motion4_ball1 = set:getSimpleAnimateNode("root_motion4_ball1")
   self._root_motion4_ball2 = set:getSimpleAnimateNode("root_motion4_ball2")
   self._root_motion4_ball3 = set:getSimpleAnimateNode("root_motion4_ball3")
   self._root_motion4_ball4 = set:getSimpleAnimateNode("root_motion4_ball4")
   self._root_motion4_bgclick = set:getClickNode("root_motion4_bgclick")
   self._root_rect = set:getRectangleNode("root_rect")
   self._root_suc = set:getElfNode("root_suc")
   self._root_suc_bgclick = set:getClickNode("root_suc_bgclick")
   self._root_suc_light = set:getElfNode("root_suc_light")
   self._root_suc_line = set:getElfNode("root_suc_line")
   self._root_suc_title = set:getElfNode("root_suc_title")
   self._root_suc_bg1 = set:getJoint9Node("root_suc_bg1")
   self._root_suc_bg1_items_list = set:getListNode("root_suc_bg1_items_list")
   self._root_suc_bg1_items_list_container_des = set:getRichLabelNode("root_suc_bg1_items_list_container_des")
   self._root_suc_bg1_elf_title = set:getLabelNode("root_suc_bg1_elf_title")
   self._root_suc_bg1_newpet = set:getElfNode("root_suc_bg1_newpet")
   self._root_suc_bg1_newpet_pzbg = set:getElfNode("root_suc_bg1_newpet_pzbg")
   self._root_suc_bg1_newpet_frame = set:getElfNode("root_suc_bg1_newpet_frame")
   self._root_suc_bg1_newpet_pz = set:getElfNode("root_suc_bg1_newpet_pz")
   self._root_suc_bg1_newpet_V = set:getLabelNode("root_suc_bg1_newpet_V")
   self._root_suc_bg1_oldpet = set:getElfNode("root_suc_bg1_oldpet")
   self._root_suc_bg1_oldpet_pzbg = set:getElfNode("root_suc_bg1_oldpet_pzbg")
   self._root_suc_bg1_oldpet_frame = set:getElfNode("root_suc_bg1_oldpet_frame")
   self._root_suc_bg1_oldpet_pz = set:getElfNode("root_suc_bg1_oldpet_pz")
   self._root_suc_bg1_oldpet_V = set:getLabelNode("root_suc_bg1_oldpet_V")
   self._root_suc_bg1_atk = set:getElfNode("root_suc_bg1_atk")
   self._root_suc_bg1_atk_oldv = set:getLabelNode("root_suc_bg1_atk_oldv")
   self._root_suc_bg1_atk_newv = set:getLabelNode("root_suc_bg1_atk_newv")
   self._root_suc_bg1_hp = set:getElfNode("root_suc_bg1_hp")
   self._root_suc_bg1_hp_oldv = set:getLabelNode("root_suc_bg1_hp_oldv")
   self._root_suc_bg1_hp_newv = set:getLabelNode("root_suc_bg1_hp_newv")
   self._old_name = set:getLabelNode("old_name")
   self._new_name = set:getLabelNode("new_name")
   self._movein = set:getElfAction("movein")
   self._quake = set:getElfAction("quake")
   self._leftIn = set:getElfAction("leftIn")
   self._rightIn = set:getElfAction("rightIn")
   self._scaleout = set:getElfAction("scaleout")
   self._rotate = set:getElfAction("rotate")
--   self._@unused = set:getElfNode("@unused")
end
--@@@@]]]]

--------------------------------override functions----------------------

--{oldpet=nPet,newpet=data.D.Pet,subtitle=subtitle,subdes=subdes,consumecnt}
function DFosterAwakeResult:onInit( userData, netData )

  require 'GuideHelper':check('DFosterAwakeResult')
  self._root_motion = self[string.format('_root_motion%s',tostring(userData.consumecnt))]
  self._root_motion_bgclick = self[string.format('_root_motion%s_bgclick',tostring(userData.consumecnt))]
  self:startMotion(userData)
	self._root_suc_bgclick:setListener(function ( ... )
		self:close()
	end)
  self._root_motion_bgclick:setListener(function ( ... )
    self._root_motion:setPauseMotion(true)
    self:MotionEnd()
    require 'framework.helper.MusicHelper'.stopAllEffects()
  end)
  self._root_suc_bg1_elf_title:setString(tostring(userData.subtitle))
  if userData.subdes then
    self._root_suc_bg1_items_list_container_des:setString(userData.subdes)
    self._root_suc_bg1_hp:setVisible(false)
    self._root_suc_bg1_atk:setVisible(false)
    self._root_suc_bg1_items_list:setVisible(true)
  else
    self._root_suc_bg1_hp:setVisible(true)
    self._root_suc_bg1_atk:setVisible(true)
    self._root_suc_bg1_items_list:setVisible(false)
    self._root_suc_bg1_hp_oldv:setString(tostring(userData.oldpet.Hp))
    self._root_suc_bg1_hp_newv:setString(tostring(userData.newpet.Hp))
    self._root_suc_bg1_atk_oldv:setString(tostring(userData.oldpet.Atk))
    self._root_suc_bg1_atk_newv:setString(tostring(userData.newpet.Atk))
  end
  
  -- self._root_suc_bg1_old_name:setString(userData.oldpet.Name)
  self._root_suc_bg1_oldpet_V:setString(tostring(userData.oldname))
  -- self._root_suc_bg1_new_name:setString(userData.newpet.Name)
  self._root_suc_bg1_newpet_V:setString(tostring(userData.newname))
  self._root_suc_bg1_oldpet_V:setFontFillColor(res.getRankColorByAwake(userData.oldpet.AwakeIndex), true)
  self._root_suc_bg1_newpet_V:setFontFillColor(res.getRankColorByAwake(userData.newpet.AwakeIndex), true)
  -- self._root_suc_bg1_old_name:setFontFillColor(res.getRankColorByAwake(userData.oldpet.AwakeIndex), true)
  -- self._root_suc_bg1_new_name:setFontFillColor(res.getRankColorByAwake(userData.newpet.AwakeIndex), true)

  -- self._root_suc_bg1_oldpet_pzbg:setResid(res.getPetIconBgByAwakeIndex(userData.oldpet.AwakeIndex))
  self._root_suc_bg1_oldpet_frame:setResid(res.getPetIcon(userData.oldpet.PetId))
  self._root_suc_bg1_oldpet_pz:setResid(res.getPetPZ(userData.oldpet.AwakeIndex))

  -- self._root_suc_bg1_newpet_pzbg:setResid(res.getPetIconBgByAwakeIndex(userData.newpet.AwakeIndex))
  self._root_suc_bg1_newpet_frame:setResid(res.getPetIcon(userData.newpet.PetId))
  self._root_suc_bg1_newpet_pz:setResid(res.getPetPZ(userData.newpet.AwakeIndex))

  -- self._root_suc_pet:setResid(res.getPetWithPetId(userData.newpet.PetId))
end

function DFosterAwakeResult:onBack( userData, netData )
	
end

function DFosterAwakeResult:close( ... )
  require 'GuideHelper':check('AnimtionEnd')
end
--------------------------------custom code-----------------------------

function DFosterAwakeResult:startMotion( userData )
  self._root_motion:setVisible(true)
  self._root_suc:setVisible(false)
  self._root_rect:setVisible(false)
  self._root_motion:setListener(function ( ... )
    self:MotionEnd()
  end)
  self._root_motion:runAnimate(0,3900)
  
  require 'framework.helper.MusicHelper'.playEffect('raw/ui_sfx_rise.mp3')
  self:runWithDelay(function ( ... )
    if self._root_suc:isVisible() then
      return
    end
    local scence = CCDirector:sharedDirector():getRunningScene()
    scence:runAction(self._quake:clone())
  end,1.7)
end

function DFosterAwakeResult:MotionEnd( ... )
  self._root_suc:setVisible(true)
  self._root_rect:setVisible(true)
  self._root_motion:setVisible(false)
  -- self._root_suc:setPosition(ccp(1136,0))
  self:ActionStep2()

  local userData = self:getUserData()
  if userData and userData.callback then
    userData.callback()
  end
end

function DFosterAwakeResult:ActionStep2( ... )
  self._root_suc_line:setPosition(ccp(-980.0,128.0))
  self._root_suc_title:setPosition(ccp(1466.0,128.0))
  self._root_suc_bg1:setScale(0)
  self._root_suc_light:setScale(0)
  self._root_suc_line:runElfAction(self._leftIn:clone())
  self._root_suc_title:runElfAction(self._rightIn:clone())
  self._root_suc_bg1:runElfAction(self._scaleout:clone())
  require 'framework.helper.MusicHelper'.playEffect('raw/dg_buff_sword.mp3')
  local lightaction = self._scaleout:clone()
  lightaction:setListener(function ( ... )
    self._root_suc_light:runElfAction(self._rotate:clone()) 
  end)
  self._root_suc_light:runElfAction(lightaction)
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DFosterAwakeResult, "DFosterAwakeResult")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DFosterAwakeResult", DFosterAwakeResult)
