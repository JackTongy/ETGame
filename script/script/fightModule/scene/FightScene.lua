local config = require "Config"
require 'OtherPlayer'
require 'HeroPlayer'
local actionUtil = require 'ActionUtil'
local layerManager = require 'LayerManager'
local EventCenter = require 'EventCenter'
local fightEvent = require 'FightEvent'
local rolePlayerManager = require 'RolePlayerManager'
local utils = require 'framework.helper.Utils'

local FirstFightGuider = require 'FirstFightGuider'

local SocketClientPvp = require 'SocketClientPvp'
local FightSettings = require 'FightSettings'

local FightScene = class(LuaController)

function FightScene:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."FightScene.cocos.zip")
    return self._factory:createDocument("FightScene.cocos")
end

--@@@@[[[[
function FightScene:onInitXML()
    local set = self._set
   self._layer = set:getElfNode("layer")
   self._layer_bgLayer = set:getElfNode("layer_bgLayer")
   self._layer_bgLayer_bg1 = set:getElfNode("layer_bgLayer_bg1")
   self._layer_bgLayer_bg1_pic1 = set:getElfNode("layer_bgLayer_bg1_pic1")
   self._layer_bgLayer_bg1_pic2 = set:getElfNode("layer_bgLayer_bg1_pic2")
   self._layer_bgLayer_bg2 = set:getElfNode("layer_bgLayer_bg2")
   self._layer_bgLayer_bg2_pic1 = set:getElfNode("layer_bgLayer_bg2_pic1")
   self._layer_bgLayer_bg2_pic2 = set:getElfNode("layer_bgLayer_bg2_pic2")
   self._layer_bgLayer_bg3 = set:getElfNode("layer_bgLayer_bg3")
   self._layer_bgLayer_bg3_pic1 = set:getElfNode("layer_bgLayer_bg3_pic1")
   self._layer_bgLayer_bg3_pic2 = set:getElfNode("layer_bgLayer_bg3_pic2")
   self._layer_bgLayer_grid_bg = set:getElfNode("layer_bgLayer_grid_bg")
   self._layer_bgLayer_range_cure = set:getElfNode("layer_bgLayer_range_cure")
   self._layer_bgLayer_range_line = set:getElfNode("layer_bgLayer_range_line")
   self._layer_bgLayer_range_rect = set:getElfNode("layer_bgLayer_range_rect")
   self._layer_bgLayer_range_attack = set:getElfNode("layer_bgLayer_range_attack")
   self._layer_bgLayer_black = set:getRectangleNode("layer_bgLayer_black")
   self._layer_bgLayer_warning0 = set:getLayoutNode("layer_bgLayer_warning0")
   self._layer_bgLayer_warning1 = set:getLayoutNode("layer_bgLayer_warning1")
   self._layer_bgLayer_warning2 = set:getLayoutNode("layer_bgLayer_warning2")
   self._layer_bgSkillLayer = set:getElfNode("layer_bgSkillLayer")
   self._layer_touchLayer = set:getLuaTouchNode("layer_touchLayer")
   self._layer_touchLayer_circle = set:getElfNode("layer_touchLayer_circle")
   self._layer_touchLayer_rectangle = set:getRectangleNode("layer_touchLayer_rectangle")
   self._layer_touchLayer_line = set:getElfNode("layer_touchLayer_line")
   self._layer_touchLayer_target = set:getElfNode("layer_touchLayer_target")
   self._layer_bossBigSkillWarning = set:getElfNode("layer_bossBigSkillWarning")
   self._layer_bossBigSkillWarning_line = set:getElfNode("layer_bossBigSkillWarning_line")
   self._layer_bossBigSkillWarning_line_pic = set:getElfNode("layer_bossBigSkillWarning_line_pic")
   self._layer_bossBigSkillWarning_circle = set:getElfNode("layer_bossBigSkillWarning_circle")
   self._layer_bossBigSkillWarning_circle_pic = set:getElfNode("layer_bossBigSkillWarning_circle_pic")
   self._layer_roleLayer = set:getElfNode("layer_roleLayer")
   self._layer_touchLayerAbove = set:getElfNode("layer_touchLayerAbove")
   self._layer_touchLayerAbove_target = set:getElfNode("layer_touchLayerAbove_target")
   self._layer_skyLayer = set:getElfNode("layer_skyLayer")
   self._layer_specialLayer = set:getElfNode("layer_specialLayer")
   self._layer_fightTextLayer = set:getElfNode("layer_fightTextLayer")
   self._layer_bossWarning = set:getElfNode("layer_bossWarning")
   self._layer_bossWarning_bg = set:getJoint9Node("layer_bossWarning_bg")
   self._layer_bossWarning_bg0 = set:getJoint9Node("layer_bossWarning_bg0")
   self._layer_bossWarning_bg1 = set:getJoint9Node("layer_bossWarning_bg1")
   self._layer_bossWarning_bg2 = set:getJoint9Node("layer_bossWarning_bg2")
   self._p1 = set:getRectangleNode("p1")
   self._p1_label = set:getLabelNode("p1_label")
   self._p2 = set:getRectangleNode("p2")
   self._p2_label = set:getLabelNode("p2_label")
   self._p3 = set:getRectangleNode("p3")
   self._p3_label = set:getLabelNode("p3_label")
   self._p4 = set:getRectangleNode("p4")
   self._p4_label = set:getLabelNode("p4_label")
   self._p5 = set:getRectangleNode("p5")
   self._p5_label = set:getLabelNode("p5_label")
   self._p6 = set:getRectangleNode("p6")
   self._p6_label = set:getLabelNode("p6_label")
   self._p7 = set:getRectangleNode("p7")
   self._p7_label = set:getLabelNode("p7_label")
   self._p8 = set:getRectangleNode("p8")
   self._p8_label = set:getLabelNode("p8_label")
   self._p9 = set:getRectangleNode("p9")
   self._p9_label = set:getLabelNode("p9_label")
   self._p10 = set:getRectangleNode("p10")
   self._p10_label = set:getLabelNode("p10_label")
   self._p11 = set:getRectangleNode("p11")
   self._p11_label = set:getLabelNode("p11_label")
   self._p12 = set:getRectangleNode("p12")
   self._p12_label = set:getLabelNode("p12_label")
   self._p13 = set:getRectangleNode("p13")
   self._p13_label = set:getLabelNode("p13_label")
   self._p14 = set:getRectangleNode("p14")
   self._p14_label = set:getLabelNode("p14_label")
   self._p15 = set:getRectangleNode("p15")
   self._p15_label = set:getLabelNode("p15_label")
   self._p16 = set:getRectangleNode("p16")
   self._p16_label = set:getLabelNode("p16_label")
   self._p17 = set:getRectangleNode("p17")
   self._p17_label = set:getLabelNode("p17_label")
   self._p18 = set:getRectangleNode("p18")
   self._p18_label = set:getLabelNode("p18_label")
   self._p19 = set:getRectangleNode("p19")
   self._p19_label = set:getLabelNode("p19_label")
   self._p20 = set:getRectangleNode("p20")
   self._p20_label = set:getLabelNode("p20_label")
   self._p21 = set:getRectangleNode("p21")
   self._p21_label = set:getLabelNode("p21_label")
   self._rect = set:getRectangleNode("rect")
   self._layer_timer = set:getLabelNode("layer_timer")
   self._uiLayer = set:getElfNode("uiLayer")
   self._uiLayer_lt_bg = set:getElfNode("uiLayer_lt_bg")
   self._uiLayer_lt_clock = set:getElfNode("uiLayer_lt_clock")
   self._uiLayer_lt_clock_llayout = set:getLinearLayoutNode("uiLayer_lt_clock_llayout")
   self._uiLayer_lt_clock_llayout_n1 = set:getElfNode("uiLayer_lt_clock_llayout_n1")
   self._uiLayer_lt_clock_llayout_n2 = set:getElfNode("uiLayer_lt_clock_llayout_n2")
   self._uiLayer_lt_clock_llayout_n3 = set:getElfNode("uiLayer_lt_clock_llayout_n3")
   self._uiLayer_lt_clock_llayout_n4 = set:getElfNode("uiLayer_lt_clock_llayout_n4")
   self._uiLayer_lt_clock_llayout_n5 = set:getElfNode("uiLayer_lt_clock_llayout_n5")
   self._uiLayer_lt_boshu_llayout = set:getLinearLayoutNode("uiLayer_lt_boshu_llayout")
   self._uiLayer_lt_boshu_llayout_n1 = set:getElfNode("uiLayer_lt_boshu_llayout_n1")
   self._uiLayer_lt_boshu_llayout_n2 = set:getElfNode("uiLayer_lt_boshu_llayout_n2")
   self._uiLayer_lt_boshu_llayout_n3 = set:getElfNode("uiLayer_lt_boshu_llayout_n3")
   self._uiLayer_lt_boshu_llayout_n4 = set:getElfNode("uiLayer_lt_boshu_llayout_n4")
   self._uiLayer_lt_boshu_llayout_n5 = set:getElfNode("uiLayer_lt_boshu_llayout_n5")
   self._uiLayer_rt_AnNiuZu = set:getLinearLayoutNode("uiLayer_rt_AnNiuZu")
   self._uiLayer_rt_AnNiuZu_auto = set:getCheckBoxNode("uiLayer_rt_AnNiuZu_auto")
   self._uiLayer_rt_AnNiuZu_jjcAuto = set:getButtonNode("uiLayer_rt_AnNiuZu_jjcAuto")
   self._uiLayer_rt_AnNiuZu_acce = set:getCheckBoxNode("uiLayer_rt_AnNiuZu_acce")
   self._uiLayer_rt_AnNiuZu_acce_selected = set:getElfNode("uiLayer_rt_AnNiuZu_acce_selected")
   self._uiLayer_rt_AnNiuZu_pause = set:getButtonNode("uiLayer_rt_AnNiuZu_pause")
   self._uiLayer_rb_bg_l = set:getElfNode("uiLayer_rb_bg_l")
   self._uiLayer_rb_bg_m = set:getElfNode("uiLayer_rb_bg_m")
   self._uiLayer_rb_bg_r = set:getElfNode("uiLayer_rb_bg_r")
   self._uiLayer_rb_bg_r_p = set:getElfNode("uiLayer_rb_bg_r_p")
   self._uiLayer_rb_heroArray = set:getLayoutNode("uiLayer_rb_heroArray")
   self._button = set:getButtonNode("button")
   self._bg = set:getElfNode("bg")
   self._pic = set:getClipNode("pic")
   self._pic_delGray = set:getElfNode("pic_delGray")
   self._pic_delGray_tou = set:getElfGrayNode("pic_delGray_tou")
   self._pic_delGray_face = set:getElfGrayNode("pic_delGray_face")
   self._pic_del = set:getElfNode("pic_del")
   self._pic_del_tou = set:getElfNode("pic_del_tou")
   self._pic_del_face = set:getElfNode("pic_del_face")
   self._kuang = set:getElfNode("kuang")
   self._effect = set:getSimpleAnimateNode("effect")
   self._label = set:getLabelNode("label")
   self._disEffect = set:getSimpleAnimateNode("disEffect")
   self._starLayout = set:getLayoutNode("starLayout")
   self._KeyStorage = set:getElfNode("KeyStorage")
   self._KeyStorage_arr_Position = set:getElfNode("KeyStorage_arr_Position")
   self._root = set:getElfNode("root")
   self._root_arr = set:getElfNode("root_arr")
   self._uiLayer_labels = set:getElfNode("uiLayer_labels")
   self._KeyStorage_show_upBar_Position = set:getElfNode("KeyStorage_show_upBar_Position")
   self._KeyStorage_show_up1_Scale = set:getElfNode("KeyStorage_show_up1_Scale")
   self._KeyStorage_show_up2_Scale = set:getElfNode("KeyStorage_show_up2_Scale")
   self._KeyStorage_show_downBar_Position = set:getElfNode("KeyStorage_show_downBar_Position")
   self._KeyStorage_show_down1_Scale = set:getElfNode("KeyStorage_show_down1_Scale")
   self._KeyStorage_show_down2_Scale = set:getElfNode("KeyStorage_show_down2_Scale")
   self._KeyStorage_show_upBar_Scale = set:getElfNode("KeyStorage_show_upBar_Scale")
   self._KeyStorage_show_downBar_Rotate = set:getElfNode("KeyStorage_show_downBar_Rotate")
   self._KeyStorage_show_downBar_Scale = set:getElfNode("KeyStorage_show_downBar_Scale")
   self._KeyStorage_show_up3_Visible = set:getElfNode("KeyStorage_show_up3_Visible")
   self._KeyStorage_show_up3_Position = set:getElfNode("KeyStorage_show_up3_Position")
   self._KeyStorage_show_up4_Position = set:getElfNode("KeyStorage_show_up4_Position")
   self._KeyStorage_show_down3_Position = set:getElfNode("KeyStorage_show_down3_Position")
   self._KeyStorage_show_down3_Visible = set:getElfNode("KeyStorage_show_down3_Visible")
   self._KeyStorage_show_down4_Position = set:getElfNode("KeyStorage_show_down4_Position")
   self._root_upBar = set:getElfNode("root_upBar")
   self._root_upBar_up0 = set:getElfNode("root_upBar_up0")
   self._root_upBar_up1 = set:getElfNode("root_upBar_up1")
   self._root_upBar_up2 = set:getElfNode("root_upBar_up2")
   self._root_upBar_up3 = set:getElfNode("root_upBar_up3")
   self._root_upBar_up4 = set:getElfNode("root_upBar_up4")
   self._root_downBar = set:getElfNode("root_downBar")
   self._root_downBar_down0 = set:getElfNode("root_downBar_down0")
   self._root_downBar_down1 = set:getElfNode("root_downBar_down1")
   self._root_downBar_down2 = set:getElfNode("root_downBar_down2")
   self._root_downBar_down3 = set:getElfNode("root_downBar_down3")
   self._root_downBar_down4 = set:getElfNode("root_downBar_down4")
   self._root_pic_image2 = set:getElfNode("root_pic_image2")
   self._root_pic_image2_pic = set:getElfNode("root_pic_image2_pic")
   self._root_pic_image1 = set:getElfNode("root_pic_image1")
   self._root_pic_image1_pic = set:getElfNode("root_pic_image1_pic")
   self._root_pic_image0 = set:getElfNode("root_pic_image0")
   self._root_pic_image0_pic = set:getElfNode("root_pic_image0_pic")
   self._root_pic_image = set:getElfNode("root_pic_image")
   self._root_pic_image_pic = set:getElfNode("root_pic_image_pic")
   self._root_pic_image_combo = set:getElfNode("root_pic_image_combo")
   self._root_pic_image_combo_bg = set:getElfNode("root_pic_image_combo_bg")
   self._root_pic_image_combo_llayout1_num = set:getElfNode("root_pic_image_combo_llayout1_num")
   self._root_pic_image_combo_llayout2_num = set:getElfNode("root_pic_image_combo_llayout2_num")
   self._root_pic_image_label_dw = set:getElfNode("root_pic_image_label_dw")
   self._root_pic_image_label_dw_label = set:getLabelNode("root_pic_image_label_dw_label")
   self._uiLayer_labels_RoundView = set:getElfNode("uiLayer_labels_RoundView")
   self._uiLayer_labels_RoundView_bar = set:getElfNode("uiLayer_labels_RoundView_bar")
   self._uiLayer_labels_RoundView_bar_gray = set:getRectangleNode("uiLayer_labels_RoundView_bar_gray")
   self._uiLayer_labels_RoundView_label = set:getElfNode("uiLayer_labels_RoundView_label")
   self._uiLayer_labels_RoundView_label_hui = set:getAddColorNode("uiLayer_labels_RoundView_label_hui")
   self._uiLayer_labels_RoundView_label_he = set:getAddColorNode("uiLayer_labels_RoundView_label_he")
   self._uiLayer_labels_RoundView_label_n0 = set:getAddColorNode("uiLayer_labels_RoundView_label_n0")
   self._uiLayer_labels_RoundView_label_n1 = set:getAddColorNode("uiLayer_labels_RoundView_label_n1")
   self._uiLayer_labels_RoundView_label_n2 = set:getAddColorNode("uiLayer_labels_RoundView_label_n2")
   self._uiLayer_labels_RoundView_label_n3 = set:getAddColorNode("uiLayer_labels_RoundView_label_n3")
   self._uiLayer_labels_RoundView_label_n4 = set:getAddColorNode("uiLayer_labels_RoundView_label_n4")
   self._netLayer = set:getElfNode("netLayer")
   self._netLayer_black = set:getRectangleNode("netLayer_black")
   self._netLayer_netlabel = set:getLabelNode("netLayer_netlabel")
   self._preload = set:getElfNode("preload")
   self._preload_cmbs = set:getElfNode("preload_cmbs")
   self._testBtns = set:getElfNode("testBtns")
   self._testBtns_winclick = set:getColorClickNode("testBtns_winclick")
   self._testBtns_loseclick = set:getColorClickNode("testBtns_loseclick")
   self._bossKillLayer = set:getElfNode("bossKillLayer")
   self._bossKillLayer_white = set:getRectangleNode("bossKillLayer_white")
   self._topLayer = set:getElfNode("topLayer")
   self._topLayer_shield = set:getShieldNode("topLayer_shield")
   self._topSkip = set:getButtonNode("topSkip")
   self._ActionBallEnter = set:getElfAction("ActionBallEnter")
   self._ActionBiShaTwinkle = set:getElfAction("ActionBiShaTwinkle")
   self._ActionBallDisappear = set:getElfAction("ActionBallDisappear")
   self._ActionCureValue = set:getElfAction("ActionCureValue")
   self._ActionHurtValue = set:getElfAction("ActionHurtValue")
   self._ActionLockTarget = set:getElfAction("ActionLockTarget")
   self._ActionLockFriend = set:getElfAction("ActionLockFriend")
   self._ActionLockTargetHide = set:getElfAction("ActionLockTargetHide")
   self._ActionTwinkle = set:getElfAction("ActionTwinkle")
   self._ActionBloodBarShow = set:getElfAction("ActionBloodBarShow")
   self._ActionBloodBarHide = set:getElfAction("ActionBloodBarHide")
   self._ActionHurtRed = set:getElfAction("ActionHurtRed")
   self._ActionShake = set:getElfAction("ActionShake")
   self._ActionSelectRectShow = set:getElfAction("ActionSelectRectShow")
   self._ActionSelectRectHide = set:getElfAction("ActionSelectRectHide")
   self._ActionBlackInOut = set:getElfAction("ActionBlackInOut")
   self._ActionShowWarning = set:getElfAction("ActionShowWarning")
   self._ActionBossWarning = set:getElfAction("ActionBossWarning")
   self._ActionWhiteOut = set:getElfAction("ActionWhiteOut")
   self._ActionBigSkill_CircleIn = set:getElfAction("ActionBigSkill_CircleIn")
   self._ActionBigSkill_LineIn = set:getElfAction("ActionBigSkill_LineIn")
--   self._@warning = set:getLayoutNode("@warning")
--   self._@posLayer = set:getElfNode("@posLayer")
--   self._@heroMana = set:getElfNode("@heroMana")
--   self._@star = set:getElfNode("@star")
--   self._@star = set:getElfNode("@star")
--   self._@star = set:getElfNode("@star")
--   self._@star = set:getElfNode("@star")
--   self._@arrow = set:getElfMotionNode("@arrow")
--   self._@ReleaseSkill = set:getElfMotionNode("@ReleaseSkill")
end
--@@@@]]]]

--------------------------------override functions----------------------
--  userData 其他control传过来的数据
function FightScene:onInit( userData, netData )

    -- CCDirector:sharedDirector():getScheduler():setTimeScale( 0.2 )

    print('FightScene userData')
    print(userData)

    -- assert( not FightSettings.isLocked() )
    FightSettings.setLocked()

	local luaset = utils.toluaSet(self._set)
   
	--init layers 
    local obj = {}
    obj.bgLayer = self._layer_bgLayer
    obj.bgSkillLayer = self._layer_bgSkillLayer
    obj.roleLayer = self._layer_roleLayer
    obj.skyLayer = self._layer_skyLayer
    obj.specialLayer = self._layer_specialLayer
    obj.uiLayer = self._layer_uiLayer
    obj.fightTextLayer = self._layer_fightTextLayer
    obj.touchLayer = self._layer_touchLayer
    obj.touchLayerAbove = self._layer_touchLayerAbove
    obj.topLayer = self._topLayer

	-- layerManager.initLayer(self._layer_bgLayer,self._layer_bgSkillLayer,self._layer_roleLayer,self._layer_skyLayer,self._layer_specialLayer, self._layer_uiLayer)
	layerManager.initLayer(obj, luaset)
    -- layerManager.createLuaSet = function ( name )
    --     return self:createLuaSet(name)
    -- end
    layerManager.luaset = luaset

    local FingerView    = require 'FingerView'.new(luaset):start()
    local GameOverView  = require 'GameOverView'.new(luaset, self._document)
    local TimerView     = require 'TimerView'.new(luaset, self._document )
    local GridView      = require 'GridView'.new(luaset)

    local CMBSView
    local FightGuiderView
    local RoundView
    local BossKillLayer
    local CatchBossView
    local DropView
    local ReleaseSkillView
    local ManaView
    local BossBigSkillWarningView
    local UIView
    local TipView
    
    if userData.type ~= 'pvp' then
        -- if userData.type == 'arena' or userData.type == 'arena-record' then
        --     require 'JJCUIView'.new(luaset, self._document)
        -- end

        CMBSView                = require 'CMBSView'.new(luaset, self._document)
        FightGuiderView         = require 'FightGuiderView'.new(luaset, self._document)

        RoundView               = require 'RoundView'.new(luaset, self._document)
        BossKillLayer           = require 'BossKillLayer'.new(luaset, self._document)
        CatchBossView           = require 'CatchBossView'.new(luaset, self._document)
        DropView                = require 'DropView'.new(luaset, self._document)
        ReleaseSkillView        = require 'ReleaseSkillView'.new(luaset, self._document)
        ManaView                = require 'ManaView'.new(luaset, self._document)
        BossBigSkillWarningView = require 'BossBigSkillWarningView'.new(luaset, self._document)
        
        -- require 'SlotView'.new(luaset, self._document, 'pve'):start()
        UIView                  = require 'UIView'.new(luaset, true)
        TipView                 = require 'TipView'.new(luaset, self._document)

        require 'ServerController'.start( userData.data )

        print('进入 '..tostring(userData.type))

    else

        UIView = require 'UIView'.new(luaset, false)
        -- EventCenter.eventInput(fightEvent.OnEnterFightScene, userData.data)

        EventCenter.addEventFunc('Go', function ( data )
             -- body
            print('进入PVP')
            require 'SlotView'.new(luaset, self._document, 'pvp'):start()
            EventCenter.eventInput(fightEvent.OnEnterFightScene, userData.data)
         
        end, 'Fight')
        SocketClientPvp:send( { C = 'Ready' } )

    end

end

function FightScene:onBack( userData, netData )
	
end

function FightScene:onRelease()
    
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(FightScene, "FightScene")


--------------------------------register--------------------------------
GleeCore:registerLuaController("FightScene", FightScene)


