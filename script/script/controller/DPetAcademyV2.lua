local Config = require "Config"
local dbManager = require 'DBManager'
local netmodel = require 'netModel'
local Res = require 'Res'
local PubConfig = require 'PubConfig'
local GuideHelper = require 'GuideHelper'
local appData = require 'AppData'
local TimeManager = require 'TimeManager'
local EventCenter = require 'EventCenter'
local ActivityInfo = require 'ActivityInfo'
local LangAdapter = require 'LangAdapter'

local DPetAcademyV2 = class(LuaDialog)

function DPetAcademyV2:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPetAcademyV2.cocos.zip")
    return self._factory:createDocument("DPetAcademyV2.cocos")
end

--@@@@[[[[
function DPetAcademyV2:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg = set:getElfNode("root_bg")
   self._root_bg1 = set:getJoint9Node("root_bg1")
   self._root_tabs = set:getLinearLayoutNode("root_tabs")
   self._root_tabs_tab1 = set:getTabNode("root_tabs_tab1")
   self._root_tabs_tab1_normal_v = set:getLabelNode("root_tabs_tab1_normal_v")
   self._root_tabs_tab1_pressed_v = set:getLabelNode("root_tabs_tab1_pressed_v")
   self._root_tabs_tab4 = set:getTabNode("root_tabs_tab4")
   self._root_tabs_tab4_normal_v = set:getLabelNode("root_tabs_tab4_normal_v")
   self._root_tabs_tab4_pressed_v = set:getLabelNode("root_tabs_tab4_pressed_v")
   self._root_tabs_tab2 = set:getTabNode("root_tabs_tab2")
   self._root_tabs_tab2_normal_v = set:getLabelNode("root_tabs_tab2_normal_v")
   self._root_tabs_tab2_pressed_v = set:getLabelNode("root_tabs_tab2_pressed_v")
   self._root_tabs_tab3 = set:getTabNode("root_tabs_tab3")
   self._root_tabs_tab3_normal_v = set:getLabelNode("root_tabs_tab3_normal_v")
   self._root_tabs_tab3_pressed_v = set:getLabelNode("root_tabs_tab3_pressed_v")
   self._root_content = set:getElfNode("root_content")
   self._root_content_layout_pet1 = set:getElfNode("root_content_layout_pet1")
   self._root_content_layout_pet1_tip = set:getElfNode("root_content_layout_pet1_tip")
   self._root_content_layout_pet1_tip_linearlayout = set:getLinearLayoutNode("root_content_layout_pet1_tip_linearlayout")
   self._root_content_layout_pet1_tip_vn = set:getLinearLayoutNode("root_content_layout_pet1_tip_vn")
   self._root_content_layout_pet1_tip_vn_label = set:getLabelNode("root_content_layout_pet1_tip_vn_label")
   self._root_content_layout_pet2 = set:getElfNode("root_content_layout_pet2")
   self._root_content_layout_pet2_linearlayout = set:getLinearLayoutNode("root_content_layout_pet2_linearlayout")
   self._root_content_layout_pet2_linearlayout_label1 = set:getLabelNode("root_content_layout_pet2_linearlayout_label1")
   self._root_content_layout_pet2_linearlayout_label2 = set:getLabelNode("root_content_layout_pet2_linearlayout_label2")
   self._root_content_layout_pet2_linearlayout_label3 = set:getLabelNode("root_content_layout_pet2_linearlayout_label3")
   self._root_content_layout_pet2_tip = set:getLinearLayoutNode("root_content_layout_pet2_tip")
   self._root_content_layout_pet2_tip_label = set:getLabelNode("root_content_layout_pet2_tip_label")
   self._root_content_layout_pet2_tip_num = set:getLabelNode("root_content_layout_pet2_tip_num")
   self._root_content_layout_pet2_tip_label2 = set:getLabelNode("root_content_layout_pet2_tip_label2")
   self._root_content_layout_pet2_tip_label3 = set:getLabelNode("root_content_layout_pet2_tip_label3")
   self._root_content_layout_pet2_vn = set:getElfNode("root_content_layout_pet2_vn")
   self._root_content_layout_pet2_vn_linearlayout = set:getLinearLayoutNode("root_content_layout_pet2_vn_linearlayout")
   self._root_content_layout_pet2_vn_linearlayout_label = set:getLabelNode("root_content_layout_pet2_vn_linearlayout_label")
   self._root_content_layout_pet2_vn_linearlayout_label1 = set:getLabelNode("root_content_layout_pet2_vn_linearlayout_label1")
   self._root_content_layout_pet2_vn_tip = set:getLinearLayoutNode("root_content_layout_pet2_vn_tip")
   self._root_content_layout_pet2_vn_tip_label = set:getLabelNode("root_content_layout_pet2_vn_tip_label")
   self._root_content_layout_pet2_vn_tip_num = set:getLabelNode("root_content_layout_pet2_vn_tip_num")
   self._root_content_layout_pet2_vn_tip_label2 = set:getLabelNode("root_content_layout_pet2_vn_tip_label2")
   self._root_content_layout_pet3 = set:getElfNode("root_content_layout_pet3")
   self._root_content_layout_pet3_linearlayout = set:getLinearLayoutNode("root_content_layout_pet3_linearlayout")
   self._root_content_layout_pet3_tip = set:getLinearLayoutNode("root_content_layout_pet3_tip")
   self._root_content_layout_pet3_tip_label = set:getLabelNode("root_content_layout_pet3_tip_label")
   self._root_content_layout_pet3_tip_num = set:getLabelNode("root_content_layout_pet3_tip_num")
   self._root_content_layout_pet3_tip_label2 = set:getLabelNode("root_content_layout_pet3_tip_label2")
   self._root_content_layout_pet3_vn = set:getElfNode("root_content_layout_pet3_vn")
   self._root_content_layout_pet3_vn_tip = set:getLinearLayoutNode("root_content_layout_pet3_vn_tip")
   self._root_content_layout_pet3_vn_tip_label = set:getLabelNode("root_content_layout_pet3_vn_tip_label")
   self._root_content_layout_pet3_vn_tip_num = set:getLabelNode("root_content_layout_pet3_vn_tip_num")
   self._root_content_layout_pet3_vn_tip_label2 = set:getLabelNode("root_content_layout_pet3_vn_tip_label2")
   self._root_content_layout_pet3_vn_linearlayout_label = set:getLabelNode("root_content_layout_pet3_vn_linearlayout_label")
   self._pet1 = set:getElfNode("pet1")
   self._pet1_clip = set:getClipNode("pet1_clip")
   self._pet1_clip_icon = set:getElfNode("pet1_clip_icon")
   self._pet2 = set:getElfNode("pet2")
   self._pet2_clip = set:getClipNode("pet2_clip")
   self._pet2_clip_icon = set:getElfNode("pet2_clip_icon")
   self._pet3 = set:getElfNode("pet3")
   self._pet3_clip = set:getClipNode("pet3_clip")
   self._pet3_clip_icon = set:getElfNode("pet3_clip_icon")
   self._root_content_button = set:getElfNode("root_content_button")
   self._root_content_button_btnNormal = set:getClickNode("root_content_button_btnNormal")
   self._root_content_button_btnNormal_title = set:getLabelNode("root_content_button_btnNormal_title")
   self._root_content_button_btnNormal_point = set:getElfNode("root_content_button_btnNormal_point")
   self._root_content_button_btnOnce = set:getClickNode("root_content_button_btnOnce")
   self._root_content_button_btnOnce_title = set:getLabelNode("root_content_button_btnOnce_title")
   self._root_content_button_btnOnce_point = set:getElfNode("root_content_button_btnOnce_point")
   self._root_content_button_item1 = set:getLinearLayoutNode("root_content_button_item1")
   self._root_content_button_item1_V = set:getLabelNode("root_content_button_item1_V")
   self._root_content_button_linear = set:getLinearLayoutNode("root_content_button_linear")
   self._root_content_button_linear_icon = set:getElfNode("root_content_button_linear_icon")
   self._root_content_button_linear_price = set:getLabelNode("root_content_button_linear_price")
   self._root_content_button_linearTen = set:getLinearLayoutNode("root_content_button_linearTen")
   self._root_content_button_linearTen_icon = set:getElfNode("root_content_button_linearTen_icon")
   self._root_content_button_linearTen_price = set:getLabelNode("root_content_button_linearTen_price")
   self._root_content_button_time = set:getLinearLayoutNode("root_content_button_time")
   self._root_content_button_time_title = set:getLabelNode("root_content_button_time_title")
   self._root_content_button_time_v = set:getTimeNode("root_content_button_time_v")
   self._root_content_button_onsale = set:getElfNode("root_content_button_onsale")
   self._root_content_button_onsale_time3 = set:getLinearLayoutNode("root_content_button_onsale_time3")
   self._root_content_button_onsale_time3_title = set:getLabelNode("root_content_button_onsale_time3_title")
   self._root_content_button_onsale_time3_v = set:getTimeNode("root_content_button_onsale_time3_v")
   self._root_content_button_onsale_linearonsale = set:getLinearLayoutNode("root_content_button_onsale_linearonsale")
   self._root_content_button_onsale_linearonsale_icon = set:getElfNode("root_content_button_onsale_linearonsale_icon")
   self._root_content_button_onsale_linearonsale_price = set:getLabelNode("root_content_button_onsale_linearonsale_price")
   self._root_content_button_onsale_linearonsale_onsale = set:getElfNode("root_content_button_onsale_linearonsale_onsale")
   self._root_content_button_onsale_linearonsale_onsale_price = set:getLabelNode("root_content_button_onsale_linearonsale_onsale_price")
   self._root_content_button_btnTen = set:getClickNode("root_content_button_btnTen")
   self._root_content_button_btnTen_title = set:getLabelNode("root_content_button_btnTen_title")
   self._root_content1 = set:getElfNode("root_content1")
   self._root_content1_layout_pet1 = set:getElfNode("root_content1_layout_pet1")
   self._root_content1_layout_pet1_btndetail = set:getButtonNode("root_content1_layout_pet1_btndetail")
   self._root_content1_layout_pet1_btndetail_icon = set:getElfNode("root_content1_layout_pet1_btndetail_icon")
   self._root_content1_layout_pet1_btnteam = set:getButtonNode("root_content1_layout_pet1_btnteam")
   self._root_content1_layout_pet2 = set:getElfNode("root_content1_layout_pet2")
   self._root_content1_layout_pet2_btndetail = set:getButtonNode("root_content1_layout_pet2_btndetail")
   self._root_content1_layout_pet2_btndetail_icon = set:getElfNode("root_content1_layout_pet2_btndetail_icon")
   self._root_content1_layout_pet2_btnteam = set:getButtonNode("root_content1_layout_pet2_btnteam")
   self._root_content1_layout_pet3 = set:getElfNode("root_content1_layout_pet3")
   self._root_content1_layout_pet3_btndetail = set:getButtonNode("root_content1_layout_pet3_btndetail")
   self._root_content1_layout_pet3_btndetail_icon = set:getElfNode("root_content1_layout_pet3_btndetail_icon")
   self._root_content1_layout_pet3_btnteam = set:getButtonNode("root_content1_layout_pet3_btnteam")
   self._root_content1_button = set:getElfNode("root_content1_button")
   self._root_content1_button_btn1 = set:getClickNode("root_content1_button_btn1")
   self._root_content1_button_btn2 = set:getClickNode("root_content1_button_btn2")
   self._root_content1_button_btn2_title = set:getLabelNode("root_content1_button_btn2_title")
   self._root_content1_button_btn3 = set:getClickNode("root_content1_button_btn3")
   self._root_content2 = set:getElfNode("root_content2")
   self._root_content2_layout_pet1 = set:getElfNode("root_content2_layout_pet1")
   self._root_content2_layout_pet1_btndetail = set:getButtonNode("root_content2_layout_pet1_btndetail")
   self._root_content2_layout_pet1_btndetail_icon = set:getElfNode("root_content2_layout_pet1_btndetail_icon")
   self._root_content2_layout_pet1_btnteam = set:getButtonNode("root_content2_layout_pet1_btnteam")
   self._root_content2_layout_pet2 = set:getElfNode("root_content2_layout_pet2")
   self._root_content2_layout_pet2_btndetail = set:getButtonNode("root_content2_layout_pet2_btndetail")
   self._root_content2_layout_pet2_btndetail_icon = set:getElfNode("root_content2_layout_pet2_btndetail_icon")
   self._root_content2_layout_pet2_btnteam = set:getButtonNode("root_content2_layout_pet2_btnteam")
   self._root_content2_button = set:getElfNode("root_content2_button")
   self._root_content2_button_btn1 = set:getClickNode("root_content2_button_btn1")
   self._root_content2_button_btn2 = set:getClickNode("root_content2_button_btn2")
   self._root_content2_button_btn2_title = set:getLabelNode("root_content2_button_btn2_title")
   self._root_content3 = set:getElfNode("root_content3")
   self._root_content3_petSynthesis = set:getElfNode("root_content3_petSynthesis")
   self._root_content3_petSynthesis_btnSyn = set:getClickNode("root_content3_petSynthesis_btnSyn")
   self._root_content3_petSynthesis_btnSyn_title = set:getLabelNode("root_content3_petSynthesis_btnSyn_title")
   self._root_content3_petSynthesis_BG_list = set:getListNode("root_content3_petSynthesis_BG_list")
   self._normal_name = set:getLabelNode("normal_name")
   self._pressed_name = set:getLabelNode("pressed_name")
   self._pet = set:getColorClickNode("pet")
   self._pet_normal_elf_frame = set:getElfNode("pet_normal_elf_frame")
   self._pet_normal_elf_icon = set:getElfNode("pet_normal_elf_icon")
   self._dot = set:getElfNode("dot")
   self._numberLayout = set:getLinearLayoutNode("numberLayout")
   self._v = set:getElfNode("v")
   self._v = set:getElfNode("v")
   self._root_content3_petSynthesis_result = set:getColorClickNode("root_content3_petSynthesis_result")
   self._root_content3_petSynthesis_result_normal_clip = set:getClipNode("root_content3_petSynthesis_result_normal_clip")
   self._root_content3_petSynthesis_result_normal_clip_icon = set:getElfNode("root_content3_petSynthesis_result_normal_clip_icon")
   self._root_content3_petSynthesis_result_normal_clip_quality = set:getLabelNode("root_content3_petSynthesis_result_normal_clip_quality")
   self._root_content3_petSynthesis_result_normal_clip_numberLayout = set:getLinearLayoutNode("root_content3_petSynthesis_result_normal_clip_numberLayout")
   self._v = set:getElfNode("v")
   self._v = set:getElfNode("v")
   self._root_content3_petSynthesis_result_normal_starLayout = set:getLayoutNode("root_content3_petSynthesis_result_normal_starLayout")
   self._root_content3_petSynthesis_result_normal_nameBg = set:getElfNode("root_content3_petSynthesis_result_normal_nameBg")
   self._root_content3_petSynthesis_result_normal_nameBg_name = set:getLabelNode("root_content3_petSynthesis_result_normal_nameBg_name")
   self._root_content3_petSynthesis_result_normal_career = set:getElfNode("root_content3_petSynthesis_result_normal_career")
   self._root_content3_petSynthesis_material1 = set:getColorClickNode("root_content3_petSynthesis_material1")
   self._root_content3_petSynthesis_material1_normal_pet = set:getElfNode("root_content3_petSynthesis_material1_normal_pet")
   self._root_content3_petSynthesis_material1_normal_pet_frame = set:getElfNode("root_content3_petSynthesis_material1_normal_pet_frame")
   self._root_content3_petSynthesis_material1_normal_pet_icon = set:getElfNode("root_content3_petSynthesis_material1_normal_pet_icon")
   self._root_content3_petSynthesis_material1_normal_none = set:getElfNode("root_content3_petSynthesis_material1_normal_none")
   self._root_content3_petSynthesis_material1_anim = set:getSimpleAnimateNode("root_content3_petSynthesis_material1_anim")
   self._root_content3_petSynthesis_material1_name = set:getLabelNode("root_content3_petSynthesis_material1_name")
   self._root_content3_petSynthesis_material2 = set:getColorClickNode("root_content3_petSynthesis_material2")
   self._root_content3_petSynthesis_material2_normal_pet = set:getElfNode("root_content3_petSynthesis_material2_normal_pet")
   self._root_content3_petSynthesis_material2_normal_pet_frame = set:getElfNode("root_content3_petSynthesis_material2_normal_pet_frame")
   self._root_content3_petSynthesis_material2_normal_pet_icon = set:getElfNode("root_content3_petSynthesis_material2_normal_pet_icon")
   self._root_content3_petSynthesis_material2_normal_none = set:getElfNode("root_content3_petSynthesis_material2_normal_none")
   self._root_content3_petSynthesis_material2_anim = set:getSimpleAnimateNode("root_content3_petSynthesis_material2_anim")
   self._root_content3_petSynthesis_material2_name = set:getLabelNode("root_content3_petSynthesis_material2_name")
   self._root_content3_petSynthesis_material3 = set:getColorClickNode("root_content3_petSynthesis_material3")
   self._root_content3_petSynthesis_material3_normal_pet = set:getElfNode("root_content3_petSynthesis_material3_normal_pet")
   self._root_content3_petSynthesis_material3_normal_pet_frame = set:getElfNode("root_content3_petSynthesis_material3_normal_pet_frame")
   self._root_content3_petSynthesis_material3_normal_pet_icon = set:getElfNode("root_content3_petSynthesis_material3_normal_pet_icon")
   self._root_content3_petSynthesis_material3_normal_none = set:getElfNode("root_content3_petSynthesis_material3_normal_none")
   self._root_content3_petSynthesis_material3_anim = set:getSimpleAnimateNode("root_content3_petSynthesis_material3_anim")
   self._root_content3_petSynthesis_material3_name = set:getLabelNode("root_content3_petSynthesis_material3_name")
   self._root_content3_petSynthesis_material4 = set:getColorClickNode("root_content3_petSynthesis_material4")
   self._root_content3_petSynthesis_material4_normal_pet = set:getElfNode("root_content3_petSynthesis_material4_normal_pet")
   self._root_content3_petSynthesis_material4_normal_pet_frame = set:getElfNode("root_content3_petSynthesis_material4_normal_pet_frame")
   self._root_content3_petSynthesis_material4_normal_pet_icon = set:getElfNode("root_content3_petSynthesis_material4_normal_pet_icon")
   self._root_content3_petSynthesis_material4_normal_none = set:getElfNode("root_content3_petSynthesis_material4_normal_none")
   self._root_content3_petSynthesis_material4_anim = set:getSimpleAnimateNode("root_content3_petSynthesis_material4_anim")
   self._root_content3_petSynthesis_material4_name = set:getLabelNode("root_content3_petSynthesis_material4_name")
   self._root_content3_petSynthesis_material5 = set:getColorClickNode("root_content3_petSynthesis_material5")
   self._root_content3_petSynthesis_material5_normal_pet = set:getElfNode("root_content3_petSynthesis_material5_normal_pet")
   self._root_content3_petSynthesis_material5_normal_pet_frame = set:getElfNode("root_content3_petSynthesis_material5_normal_pet_frame")
   self._root_content3_petSynthesis_material5_normal_pet_icon = set:getElfNode("root_content3_petSynthesis_material5_normal_pet_icon")
   self._root_content3_petSynthesis_material5_normal_none = set:getElfNode("root_content3_petSynthesis_material5_normal_none")
   self._root_content3_petSynthesis_material5_anim = set:getSimpleAnimateNode("root_content3_petSynthesis_material5_anim")
   self._root_content3_petSynthesis_material5_name = set:getLabelNode("root_content3_petSynthesis_material5_name")
   self._root_content3_petSynthesis_price = set:getLinearLayoutNode("root_content3_petSynthesis_price")
   self._root_content3_petSynthesis_price_value = set:getLabelNode("root_content3_petSynthesis_price_value")
   self._root_title = set:getElfNode("root_title")
   self._root_title_content = set:getLabelNode("root_title_content")
   self._root_close = set:getButtonNode("root_close")
--   self._@layout = set:getLayoutNode("@layout")
--   self._@tabCell = set:getTabNode("@tabCell")
--   self._@litterNum = set:getElfNode("@litterNum")
--   self._@litterNum = set:getElfNode("@litterNum")
--   self._@bigNum = set:getElfNode("@bigNum")
--   self._@bigNum = set:getElfNode("@bigNum")
--   self._@star = set:getElfNode("@star")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DPetAcademyV2:onInit( userData, netData )
  require 'DPetAcademyV2Syn'.initSubView(nil, self)

   self._ZhaohuanConfig = require 'ZhaohuanConfig'
   local cfg1 = dbManager.getZhaoHuanCfg(self._ZhaohuanConfig[1].PetId)
   local cfg2 = dbManager.getZhaoHuanCfg(self._ZhaohuanConfig[5].PetId)
   self.vipLv1 = cfg1.Vip
   self.vipLv2 = cfg2.Vip
   self.actinfo = ActivityInfo.getDataByType(20)
   self.actinfo38 = ActivityInfo.getDataByType(38)
   if not self.actinfo then
      self:fetchActivityInfo()
   end

	Res.doActionDialogShow(self._root,function ( ... )
      GuideHelper:registerPoint('扭蛋',self._root_content_button_btnOnce)
      GuideHelper:registerPoint('关闭',self._root_close)
      GuideHelper:check('PetAcademy')
   end)
   self._root_close:setListener(function ( ... )
      Res.doActionDialogHide(self._root,self)
   end)
   
   self:initTabs()   
   local selectTab = (userData and userData.tab) or 1
   local tabnode = self[string.format('_root_tabs_tab%d',selectTab)]
   if tabnode then
      tabnode:trigger(nil)
   end
   self._selectTab = selectTab

   LangAdapter.nodePos(self._root_content1_layout_pet1_btnteam,ccp(4.0,135.0),nil,ccp(4.0,135.0),nil,ccp(4.0,120.0),ccp(4.0,120.0),ccp(4.0,120.0))
   LangAdapter.nodePos(self._root_content1_layout_pet2_btnteam,ccp(4.0,135.0),nil,ccp(4.0,135.0),nil,ccp(4.0,120.0),ccp(4.0,120.0),ccp(4.0,120.0))
   LangAdapter.nodePos(self._root_content1_layout_pet3_btnteam,ccp(4.0,135.0),nil,ccp(4.0,135.0),nil,ccp(4.0,120.0),ccp(4.0,120.0),ccp(4.0,120.0))
   LangAdapter.nodePos(self._root_content1_layout_pet1_btndetail_icon,ccp(20.0,-37.0),nil,ccp(20.0,-37.0),nil,ccp(20.0,-37.0),ccp(20.0,-37.0),ccp(20.0,-37.0))
   LangAdapter.nodePos(self._root_content1_layout_pet2_btndetail_icon,ccp(20.0,-37.0),nil,ccp(20.0,-37.0),nil,ccp(20.0,-37.0),ccp(20.0,-37.0),ccp(20.0,-37.0))
   LangAdapter.nodePos(self._root_content1_layout_pet3_btndetail_icon,ccp(20.0,-37.0),nil,ccp(20.0,-37.0),nil,ccp(20.0,-37.0),ccp(20.0,-37.0),ccp(20.0,-37.0))
   LangAdapter.nodePos(self._root_content2_layout_pet1_btndetail_icon,ccp(-8.0,-35.0),ccp(-8.0,-35.0),ccp(-8.0,-35.0),nil,ccp(-8.0,-35.0),ccp(-8.0,-35.0),ccp(-8.0,-35.0))
   LangAdapter.nodePos(self._root_content2_layout_pet2_btndetail_icon,ccp(-8.0,-35.0),ccp(-8.0,-35.0),ccp(-8.0,-35.0),nil,ccp(-8.0,-35.0),ccp(-8.0,-35.0),ccp(-8.0,-35.0))
   local adptfunc = function ( ... )
      self._root_content_layout_pet1_tip_linearlayout:setVisible(false)
      self._root_content_layout_pet2_linearlayout:setVisible(false)
      self._root_content_layout_pet3_linearlayout:setVisible(false)
      self._root_content_layout_pet3_tip:setVisible(false)
      self._root_content_layout_pet2_tip:setVisible(false)
      self._root_content_layout_pet1_tip_vn:setVisible(true)
      self._root_content_layout_pet2_vn:setVisible(true)
      self._root_content_layout_pet3_vn:setVisible(true)
      LangAdapter.LabelNodeAutoShrink(self._root_content_layout_pet3_vn_tip_label,200)
   end
   local enadptfunc = function ( ... )
      adptfunc()

      self._root_content_layout_pet1_tip_vn_label:setFontSize(28)
      self._root_content_layout_pet2_vn_linearlayout_label:setFontSize(28)
      self._root_content_layout_pet2_vn_linearlayout_label1:setFontSize(28)
      self._root_content_layout_pet2_vn_tip_label:setFontSize(28)
      self._root_content_layout_pet2_vn_tip_num:setFontSize(28)
      self._root_content_layout_pet2_vn_tip_label2:setFontSize(28)
      self._root_content_layout_pet3_vn_tip_num:setFontSize(28)
      self._root_content_layout_pet3_vn_tip_label:setFontSize(26)
      self._root_content_layout_pet3_vn_tip_label2:setFontSize(26)
   end
   LangAdapter.selectLang(nil,nil,adptfunc,nil, enadptfunc,enadptfunc,enadptfunc)

   LangAdapter.selectLang(nil,nil,nil,function ( ... )
      self._root_content_layout_pet2_linearlayout_label2:setString('정령 획득 가능')
      self._root_content_layout_pet2_linearlayout:setScale(0.8)
      self._root_content_layout_pet2_tip_label3:setString(Res.locString('PetAcademy$buttontiptext6'))
      self._root_content_layout_pet2_linearlayout_label1:setScaleX(0)
   end)


   LangAdapter.selectLangkv({Indonesia=function ( ... )
      self._root_content_layout_pet3_vn_linearlayout_label:setFontSize(28)
   end})
   LangAdapter.LabelNodeAutoShrink(self._root_content_button_btnNormal_title,110)
   LangAdapter.LabelNodeAutoShrink(self._root_content_button_btnOnce_title,110)
   LangAdapter.LabelNodeAutoShrink(self._root_content_button_btnTen_title,110)
   LangAdapter.LabelNodeAutoShrink(self._root_content3_petSynthesis_btnSyn_title,110)
end

function DPetAcademyV2:close( ... )
   GuideHelper:check('CloseDialg')
   require 'DPetAcademyV2Syn'.release()
end

function DPetAcademyV2:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DPetAcademyV2:updateLayer( ... )
   local db1 = dbManager.getInfoDefaultConfig('NiudanCost')
   local db10 = dbManager.getInfoDefaultConfig('Niudan10Cost')
   self._buyOncePrice = (db1 and db1.Value) or '260'
   self._buyTenPrice = (db10 and db10.Value) or '2340'

   -- self:updatePetIcon()
   self:updateOnceButton(self:inGuide())
   self:updateTenButton()
end

function DPetAcademyV2:updatePetIcon( ... )
   for i=1,3 do
      local petconfig = dbManager.getAcademyCharactor(i)
      if petconfig then
         local key = string.format('_root_content_layout_pet%d_clip_icon',i)
         self[key]:setResid(Res.getPetWithPetId(petconfig.cha_id))
         self[key]:setScale(petconfig.scale)
         self[key]:setPosition(ccp(-92.5+petconfig.x,205-petconfig.y))
      end
   end
end


function DPetAcademyV2:updateOnceButton( inguide )

   --普通
   local itemcount = appData.getBagInfo().getItemCount(22)
   local enable = itemcount >= 10
   local color = ccc4f(1.0,1.0,1.0,1.0)
   if not enable then
      color = ccc4f(0.937255,0.447059,0.125490,1.0)
   end
   self._root_content_button_item1_V:setFontFillColor(color,true)
   self._root_content_button_item1_V:setString(string.format('%s/10',tostring(itemcount)))
   self._root_content_button_btnNormal:setEnabled(enable)
   self._root_content_button_btnNormal_point:setVisible(enable)
   self._root_content_button_btnNormal:setListener(function ( ... )
      self:buyOnce(false)
   end)
   
   if itemcount >= 100 then
      self._root_content_button_btnNormal_title:setString(Res.locString('PetAcademy$niudanTen'))
      self._root_content_button_btnNormal:setListener(function ( ... )
         self:buyTen(true)
      end)
   else
      self._root_content_button_btnNormal_title:setString(Res.locString('PetAcademy$niudanonce'))
   end

   --免费倒计时信息
   -- self._root_content_button_time_v:clearListeners()
   local NDInfo = appData.getLoginInfo().getData().Nd
   if NDInfo then
      self._root_content_button_time:setVisible(not NDInfo.Free)
      self._root_content_button_linear:setVisible(not NDInfo.Free)
      self._root_content_button_btnOnce_point:setVisible(NDInfo.Free)
      if not NDInfo.Free then
         local cdseconds = math.abs(require 'Toolkit'.getTimeOffset(5,0))--当天00:00:00
         self._root_content_button_time_v:setHourMinuteSecond(0,0,cdseconds)
         self._root_content_button_time_v:setUpdateRate(-1)
         self._root_content_button_time_v:addListener(function ( ... )
            NDInfo.Free = true
            self:updateOnceButton()
         end)
      end

      local left = (inguide and 1) or NDInfo.Left
      -- self._root_content_layout_pet2_tip_num:setVisible(left > 0)
      if left == 0 then
         self._root_content_layout_pet2_tip_num:setString('')
         self._root_content_layout_pet2_tip_label:setString(Res.locString('PetAcademy$buttontiptext8'))
         self._root_content_layout_pet2_tip_label2:setString('')
         self._root_content_layout_pet2_vn_tip_num:setString('')
         self._root_content_layout_pet2_vn_tip_label:setString(Res.locString('PetAcademy$buttontiptext8'))
         self._root_content_layout_pet2_vn_tip_label2:setString('')
      else
         if Config.LangName == 'tra_ch' or Config.LangName == 'HKTW' or Config.LangName == 'ES' or Config.LangName == 'PT' then
            left = left + 1
         end
         self._root_content_layout_pet2_tip_num:setString(tostring(left))  
         self._root_content_layout_pet2_tip_label:setString(Res.locString('PetAcademy$buttontiptext4'))
         self._root_content_layout_pet2_tip_label2:setString(Res.locString('PetAcademy$buttontiptext5'))
         self._root_content_layout_pet2_vn_tip_num:setString(tostring(left))   
         self._root_content_layout_pet2_vn_tip_label:setString(Res.locString('PetAcademy$buttontiptext4'))
         self._root_content_layout_pet2_vn_tip_label2:setString(Res.locString('PetAcademy$buttontiptext5'))
      end
      
   end

   --英雄
   local price = self._buyOncePrice
   if self.actinfo38 and self.actinfo38.Data then
      local enable ,offset_to = require 'Toolkit'.isTimeBetween(self.actinfo38.Data.HourFrom,self.actinfo38.Data.MinFrom,self.actinfo38.Data.HourTo,self.actinfo38.Data.MinTo)
      if enable then
         price = 1
         self:runWithDelay(function ( ... )
            self:updateLayer()
         end,math.abs(offset_to))
      end
   end

   self._root_content_button_linear_price:setString(tostring(price))
   if (NDInfo and NDInfo.Free) then
      local btntext = Res.locString('PetAcademy$Free')
      self._root_content_button_btnOnce_title:setString(btntext)
   else
      self._root_content_button_btnOnce_title:setString(Res.locString('PetAcademy$niudanonce'))
   end

   self._root_content_button_btnOnce:setListener(function ( )
      self:buyOnce(true)
   end)
end

function DPetAcademyV2:updateTenButton( )
   local price = self._buyTenPrice
   self._currentTenPrice = price
   self._root_content_button_linearTen_price:setString(price)
   self._root_content_button_btnTen:setListener(function (  )
      self:buyTen()
   end)

   local NDInfo = appData.getLoginInfo().getData().Nd
   -- local first = NDInfo and NDInfo.TenTimes and (NDInfo.TenTimes == 0)
   -- local resselect = first and 'JLXY_niudanwenzi4_36.png' or 'N_ND_jl_3.png'
   -- self._root_content_layout_pet3:setResid(resselect)
   -- self._root_content_button_onsale:setResid(resselect)

   --偶数次必送 15资质5星精灵
   local star5q = NDInfo and NDInfo.TenTimes and (NDInfo.TenTimes%2 == 0)
   if star5q then
      self._root_content_layout_pet3_tip_label:setString(Res.locString('PetAcademy$buttontiptext11'))
      self._root_content_layout_pet3_tip_num:setString('')
      self._root_content_layout_pet3_tip_label2:setString('')
      self._root_content_layout_pet3_vn_tip_label:setString(Res.locString('PetAcademy$buttontiptext11'))
      self._root_content_layout_pet3_vn_tip_num:setString('')
      self._root_content_layout_pet3_vn_tip_label2:setString('')
   else
      local num = 1
      if Config.LangName == 'tra_ch' or Config.LangName == 'HKTW' or Config.LangName == 'ES' or Config.LangName == 'PT' then
         num = num + 1
      end

      self._root_content_layout_pet3_tip_label:setString(Res.locString('PetAcademy$buttontiptext4'))
      self._root_content_layout_pet3_tip_num:setString(tostring(num))
      self._root_content_layout_pet3_tip_label2:setString(Res.locString('PetAcademy$buttontiptext10'))
      self._root_content_layout_pet3_vn_tip_label:setString(Res.locString('PetAcademy$buttontiptext4'))
      self._root_content_layout_pet3_vn_tip_num:setString(tostring(num))
      self._root_content_layout_pet3_vn_tip_label2:setString(Res.locString('PetAcademy$buttontiptext10'))
      require 'LangAdapter'.selectLangkv({Indonesia=function ( ... )
         self._root_content_layout_pet3_tip_label:setString('Mungkin')
         self._root_content_layout_pet3_tip_num:setString('')
         self._root_content_layout_pet3_tip_label2:setString('dapat')
         self._root_content_layout_pet3_vn_tip_label:setString('Mungkin')
         self._root_content_layout_pet3_vn_tip_num:setString('')
         self._root_content_layout_pet3_vn_tip_label2:setString('dapat')
      end})
      local sizel2 = self._root_content_layout_pet3_tip_label2:getContentSize()
      self._root_content_layout_pet3_tip:layout()
      self._root_content_layout_pet3_tip_num:setDimensions(CCSizeMake(0,sizel2.height-8))
      self._root_content_layout_pet3_vn_tip_num:setDimensions(CCSizeMake(0,sizel2.height-8))

   end
   
   local enable = false
   if self.actinfo and self.actinfo.Data then
      local lastseconds = TimeManager.timeOffset(self.actinfo.CloseAt)
      local Discount    = tonumber(self.actinfo.Data.Discount)
      enable = lastseconds < 0
      if enable then
         self._root_content_button_onsale_time3_v:setHourMinuteSecond(0,0,-lastseconds)
         self._root_content_button_onsale_time3_v:setUpdateRate(-1)
         self._root_content_button_onsale_time3_v:addListener(function ( ... )
            self:updateTenButton()
         end)
         local displayCount = Discount
         require 'LangAdapter'.selectLang(nil,nil,nil,nil,function ( ... )
            displayCount = 1-Discount
         end)
         
         self._root_content_button_onsale_time3_title:setString(string.format(Res.locString('PetAcademy$Onsalesp'),tostring(displayCount*100)))
         self._root_content_button_onsale_linearonsale_price:setString(price)
         self._currentTenPrice = math.floor(tonumber(price)*Discount)
         self._root_content_button_onsale_linearonsale_onsale_price:setString(tostring(self._currentTenPrice))
         
      end
   else
      self._root_content_button_onsale_time3_v:clearListeners()
   end
   self._root_content_button_onsale:setVisible(enable)

end

--net
function DPetAcademyV2:guideFirstNiudan( ... )
   self:send(netmodel.getRoleFirstNiudan(),function ( data )
      if data and data.D then
         appData.getPetInfo().addPets({data.D.Pet})
         appData.getLoginInfo().updateNDInfo(data.D.Nd)
         self:updateOnceButton()
         self:recvPetNotice({data.D.Pet})
         GuideHelper:check('FirstNiudan')
      end
   end)
end

function DPetAcademyV2:buyOnce( coin )

   local func 
   func = function ( ... )
      require 'Toolkit'.useCoinConfirm(function ( ... )
         self:send(netmodel.getModelPetNiudan(nil,coin),function ( data )
            if data and data.D then
               appData.getPetInfo().addPets({data.D.Pet})   
               appData.getPetInfo().addPets(data.D.Pets)
               appData.getPetInfo().sortPetList()      
               appData.getBagInfo().exchangeItem(data.D.Materials)
               appData.getUserInfo().setData(data.D.Role)
               appData.getLoginInfo().updateNDInfo(data.D.Nd)
               if not coin then
                  local itemcount = appData.getBagInfo().getItemCount(22)
                  if itemcount < 10 then
                     func = nil
                  end
               end
               self:recvPetNotice({data.D.Pet},func,coin)

               self:updateOnceButton()
            end
         end)
      end)
   end

   if false then
      func = function ( ... )
         self:buyOnce(coin)
      end
      
      local pet 
      while (not pet) do
         self._petvisit = (self._petvisit and self._petvisit+1) or 1
         pet = dbManager.getCharactor(self._petvisit)
      end
      pet = appData.getPetInfo().getPetInfoByPetId(self._petvisit)
      
      local pet = appData.getPetInfo().getPetInfoByPetId(18)
      local pet = appData.getPetInfo().getPetInfoByPetId(149)
      local pet1 = appData.getPetInfo().getPetInfoByPetId(123)
      local pet2 = appData.getPetInfo().getPetInfoByPetId(152)
      local pet3 = appData.getPetInfo().getPetInfoByPetId(153)
      local pet4 = appData.getPetInfo().getPetInfoByPetId(154)
      local pet5 = appData.getPetInfo().getPetInfoByPetId(158)
      local pet6 = appData.getPetInfo().getPetInfoByPetId(385)
      local pet7 = appData.getPetInfo().getPetInfoByPetId(197)
      local pet8 = appData.getPetInfo().getPetInfoByPetId(589)
      local pet9 = appData.getPetInfo().getPetInfoByPetId(357)

      GleeCore:showLayer('DPetAcademyEffectV2',{pets={pet,pet1,pet2,pet3,pet4,pet5,pet6,pet7,pet8,pet9},again=func,useCoin=coin})
      return
   end
   
   if self:inGuide() then
      self:guideFirstNiudan()
      return
   end

   func()

end

function DPetAcademyV2:buyTen( UseCard )
   
   local func 
   func = function ( ... )
      require 'Toolkit'.useCoinConfirm(function ( ... )
         self:send(netmodel.getModelPetNiudanTen(UseCard or false),function ( data )
            if data and data.D then
               appData.getPetInfo().addPets(data.D.PetList)
               appData.getPetInfo().addPets(data.D.Pets)
               appData.getPetInfo().sortPetList()
               appData.getUserInfo().setData(data.D.Role)
               appData.getBagInfo().exchangeItem(data.D.Materials)
               appData.getLoginInfo().updateNDInfo(data.D.Nd)
               self:updateTenButton()
               if UseCard then
                  self:updateOnceButton()
               end
               self:recvPetNotice(data.D.PetList,func,not UseCard,self._currentTenPrice)
            
            end
         end)
      end)
   end
   
   func()
end

function DPetAcademyV2:recvPetNotice( petlist,again,useCoin,coinNum)
   GleeCore:showLayer('DPetAcademyEffectV2',{pets=petlist,again=again,useCoin=useCoin,coinNum=coinNum})
   EventCenter.eventInput('RedPointCallPet')
end

function DPetAcademyV2:inGuide( ... )
   local sp = GuideHelper:getLastSavePoint()
   local inguide = GuideHelper:inGuide('GCfg')
   return (inguide and sp < 1200)
end

------------------------------------------------------------------------------------------------------
function DPetAcademyV2:initTabs( ... )
   local viewvisible = function ( content,content1,content2,content3 )
      self._root_content:setVisible(content)
      self._root_content1:setVisible(content1)
      self._root_content2:setVisible(content2)
      self._root_content3:setVisible(content3)

      self._root_bg1:setVisible(not content3)
   end

   self._root_tabs_tab1:setListener(function ( ... )
      viewvisible(true,false,false,false)
      self:selectTab(1)
   end)
   self._root_tabs_tab2:setListener(function ( ... )
      viewvisible(false,true,false,false)
      self:selectTab(2)
   end)
   self._root_tabs_tab3:setListener(function ( ... )
      viewvisible(false,false,true,false)
      self:selectTab(3)
   end)
   self._root_tabs_tab4:setListener(function ( ... )
      viewvisible(false,false,false,true)
      self:selectTab(4)
   end)

   for i=1,4 do
      local node = self[string.format('_root_tabs_tab%d_normal_v',i)]
      LangAdapter.fontSize(node,nil,nil,nil,nil,19)
      node = self[string.format('_root_tabs_tab%d_pressed_v',i)]
      LangAdapter.fontSize(node,nil,nil,nil,nil,19)
   end

   require 'LangAdapter'.selectLangkv({Indonesia=function ( ... )
      self._root_tabs_tab3_normal_v:setFontSize(17)
      self._root_tabs_tab3_pressed_v:setFontSize(17)
   end,German=function ( ... )
      self._root_tabs_tab4_pressed_v:setFontSize(17)
      self._root_tabs_tab4_normal_v:setFontSize(17)
   end})

end

function DPetAcademyV2:selectTab( index )
   if self._selectTab and self._selectTab == index then
      return
   end
   if index == 1 then
      self:updateLayer()
   elseif index == 2 then
      self:updateContent1()
   elseif index == 3 then
      self:updateContent2()
   elseif index == 4 then
      self:updateContent3()   
   end
   
   self:unlockAdjust()

   self._selectTab = index
end

function DPetAcademyV2:initssListener( btn1,btn2,btn3,petid ,tab,viplv )
   btn1:setListener(function ( ... )
      GleeCore:showLayer('DPetSSCall',{PetId=petid,vipLv=viplv})
   end)
   btn2:setListener(function ( ... )
      GleeCore:showLayer('DPetDetailV',{nPet={PetId=petid}})
   end)
   btn3:setListener(function ( ... )
      local cfg = dbManager.getZhaoHuanCfg(petid)
      local petids = {}
      
      local start5Petlist = cfg.fivestarPetList
      for i,v in ipairs(start5Petlist) do
         table.insert(petids,v)
      end

      local param = {}
      param.Pets = {}
      param.Team = require 'TeamInfo'.getTeamDataByPetIds(petids)
      
      local CombatPower = 0
      for i,v in ipairs(petids) do
         local npet = require 'PetInfo'.getPetInfoByPetId(v,nil,true)
         table.insert(param.Pets,npet)
         CombatPower = CombatPower + npet.Power
      end
      param.Team.CombatPower = CombatPower
      
      param.Equips = {}
      param.Gems = {}
      param.Partners = {}
      param.equipShow = false
      param.mibaoShow = false
      param.CloseFunc = function ( ... )
         require "framework.sync.TimerHelper".tick(function ( ... )
            GleeCore:showLayer("DPetAcademyV2",{tab=tab})
            return true
         end)
      end
      GleeCore:closeAllLayers()
      GleeCore:pushController("CTeam",param, nil, Res.getTransitionFade())

   end)
end

function DPetAcademyV2:updateContent1( ... )
   self:initssListener(self._root_content1_button_btn1,self._root_content1_layout_pet1_btndetail,self._root_content1_layout_pet1_btnteam,self._ZhaohuanConfig[1].PetId,2,self.vipLv1)
   self:initssListener(self._root_content1_button_btn2,self._root_content1_layout_pet2_btndetail,self._root_content1_layout_pet2_btnteam,self._ZhaohuanConfig[2].PetId,2,self.vipLv1)
   self:initssListener(self._root_content1_button_btn3,self._root_content1_layout_pet3_btndetail,self._root_content1_layout_pet3_btnteam,self._ZhaohuanConfig[3].PetId,2,self.vipLv1)
end

function DPetAcademyV2:updateContent2( ... )
   self:initssListener(self._root_content2_button_btn1,self._root_content2_layout_pet1_btndetail,self._root_content2_layout_pet1_btnteam,self._ZhaohuanConfig[4].PetId,3,self.vipLv2)
   self:initssListener(self._root_content2_button_btn2,self._root_content2_layout_pet2_btndetail,self._root_content2_layout_pet2_btnteam,self._ZhaohuanConfig[5].PetId,3,self.vipLv2)
end

function DPetAcademyV2:updateContent3( ... )
   require 'DPetAcademyV2Syn'.updateSynthesisView()
end

function DPetAcademyV2:unlockAdjust( ... )
   local viplv = require 'AppData'.getUserInfo().getVipLevel()

   -- self._root_tabs_tab1:setVisible(viplv >= self.vipLv1-1)
   
   self._root_tabs_tab2:setVisible(viplv >= self.vipLv1-1)
   self._root_tabs_tab3:setVisible(viplv >= self.vipLv2-1)

   -- if viplv < self.vipLv1 then
   --    local unlocktoast = function ( ... )
   --       self:toast(string.format('VIP%d即可召唤哦',self.vipLv1))
   --    end
   --    self._root_content1_button_btn1:setListener(unlocktoast)
   --    self._root_content1_button_btn2:setListener(unlocktoast)
   --    self._root_content1_button_btn3:setListener(unlocktoast)
   -- end
   -- if viplv < self.vipLv2 then
   --    local unlocktoast = function ( ... )
   --       self:toast(string.format('VIP%d即可召唤哦',self.vipLv2))
   --    end
   --    self._root_content2_button_btn1:setListener(unlocktoast)
   --    self._root_content2_button_btn2:setListener(unlocktoast)
   -- end

end

function DPetAcademyV2:fetchActivityInfo( ... )
   self:send(netmodel.getModelActivityGet(20),function ( data )
      if data.D then
         ActivityInfo.updateActivityInfo(data.D.Activity)
         self.actinfo = ActivityInfo.getDataByType(20)
         self:updateTenButton()
      end
   end)

   self:send(netmodel.getModelActivityGet(38),function ( data )
      if data.D then
         ActivityInfo.updateActivityInfo(data.D.Activity)
         self.actinfo38 = ActivityInfo.getDataByType(38)
         self:updateOnceButton()
      end
   end)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPetAcademyV2, "DPetAcademyV2")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPetAcademyV2", DPetAcademyV2)
