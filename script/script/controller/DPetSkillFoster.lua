local Config = require "Config"
local dbManager = require "DBManager"
local gameFunc = require "AppData"
local netModel = require "netModel"
local res = require "Res"
local Res = require 'Res'
local PerlBookFunc = require 'PerlBookInfo'

local PetInfo=require 'PetInfo'

local DPetSkillFoster = class(LuaDialog)

function DPetSkillFoster:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPetSkillFoster.cocos.zip")
    return self._factory:createDocument("DPetSkillFoster.cocos")
end

--@@@@[[[[
function DPetSkillFoster:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._clickBg_shield = set:getShieldNode("clickBg_shield")
   self._clickBg_shield_rect = set:getRectangleNode("clickBg_shield_rect")
   self._root = set:getElfNode("root")
   self._root_bg = set:getElfNode("root_bg")
   self._root_bgs = set:getElfNode("root_bgs")
   self._root_bgs_bg01 = set:getJoint9Node("root_bgs_bg01")
   self._root_bgs_bg01_leftBg_noBookLabel = set:getLabelNode("root_bgs_bg01_leftBg_noBookLabel")
   self._root_bgs_bg01_leftBg_list = set:getListNode("root_bgs_bg01_leftBg_list")
   self._titleLabel = set:getLabelNode("titleLabel")
   self._layout = set:getLinearLayoutNode("layout")
   self._scale_btn = set:getButtonNode("scale_btn")
   self._scale_icon = set:getElfNode("scale_icon")
   self._title = set:getLabelNode("title")
   self._root_bgs_bg01_leftBg_emptyView = set:getElfNode("root_bgs_bg01_leftBg_emptyView")
   self._root_bgs_bg02 = set:getJoint9Node("root_bgs_bg02")
   self._root_bgs_bg02_JN_wenzi = set:getElfNode("root_bgs_bg02_JN_wenzi")
   self._root_bgs_bg02_label = set:getLabelNode("root_bgs_bg02_label")
   self._root_bgs_bg02_skillCompass = set:getClickNode("root_bgs_bg02_skillCompass")
   self._root_bgs_bg02_skillCompass_skill1 = set:getElfNode("root_bgs_bg02_skillCompass_skill1")
   self._root_bgs_bg02_skillCompass_skill1_name = set:getLabelNode("root_bgs_bg02_skillCompass_skill1_name")
   self._root_bgs_bg02_skillCompass_skill2 = set:getElfNode("root_bgs_bg02_skillCompass_skill2")
   self._root_bgs_bg02_skillCompass_skill2_name = set:getLabelNode("root_bgs_bg02_skillCompass_skill2_name")
   self._root_bgs_bg02_skillCompass_skill3 = set:getElfNode("root_bgs_bg02_skillCompass_skill3")
   self._root_bgs_bg02_skillCompass_skill3_name = set:getLabelNode("root_bgs_bg02_skillCompass_skill3_name")
   self._root_bgs_bg02_skillCompass_skill4 = set:getElfNode("root_bgs_bg02_skillCompass_skill4")
   self._root_bgs_bg02_skillCompass_skill4_name = set:getLabelNode("root_bgs_bg02_skillCompass_skill4_name")
   self._root_bgs_bg02_skillCompass_skill5 = set:getElfNode("root_bgs_bg02_skillCompass_skill5")
   self._root_bgs_bg02_skillCompass_skill5_name = set:getLabelNode("root_bgs_bg02_skillCompass_skill5_name")
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
   self._root_info_Lv = set:getLabelNode("root_info_Lv")
   self._root_info_AtkTitle = set:getLabelNode("root_info_AtkTitle")
   self._root_info_Atk = set:getLabelNode("root_info_Atk")
   self._root_info_Hp = set:getLabelNode("root_info_Hp")
   self._root_info_petptitle = set:getLabelNode("root_info_petptitle")
   self._root_title = set:getElfNode("root_title")
   self._root_title_content = set:getLabelNode("root_title_content")
   self._root_close = set:getButtonNode("root_close")
   self._head = set:getSimpleAnimateNode("head")
--   self._@title = set:getElfNode("@title")
--   self._@gemLine = set:getElfNode("@gemLine")
--   self._@gemItem = set:getElfNode("@gemItem")
--   self._@star = set:getElfNode("@star")
--   self._@activeEffAnim = set:getElfNode("@activeEffAnim")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DPetSkillFoster", function ( userData )
   	Launcher.callNet(netModel.getModelPetGet(userData.Pet.Id),function ( data )
   		Launcher.Launching(data)
   	end)
end)

function DPetSkillFoster:onInit( userData, netData )
	require "LangAdapter".fontSize(self._root_bgs_bg01_leftBg_noBookLabel, nil, nil, 22)
	require "LangAdapter".fontSize(self._root_info_petptitle, nil, nil, 18)
	require "LangAdapter".fontSize(self._root_bgs_bg02_label, nil, nil, 15,nil,15)
  for i=1,5 do

    local label = self[string.format('_root_bgs_bg02_skillCompass_skill%d_name',i)]
    require 'LangAdapter'.labelDimensions(label,nil,nil,nil,nil,CCSizeMake(0,0))
    -- require "LangAdapter".fontSize(label,nil,nil,nil,nil,18)
    require 'LangAdapter'.LabelNodeAutoShrink(label,60)
  end
  
   if netData and netData.D then
   	PetInfo.setPet(netData.D.Pet)
   	self._Pet=netData.D.Pet
   else
   	self._Pet=userData.Pet
   end
   self._DBPet=dbManager.getCharactor(self._Pet.PetId)
   self._Books = PerlBookFunc.getBooks()

   self._callback=userData.callback;

   if self._Pet.Sk ~= 0 then

      self._nowSkill5= dbManager.getInfoSkill(self._Pet.Sk);

   end


   --背景点击关闭
   self._clickBg:setListener(function ( ... )
      res.doActionDialogHide(self._root, self)

      self._callback(self._Pet)

   end)

   --弹出动画
   res.doActionDialogShow(self._root,function ( ... )
      
   end)

   --关闭按钮
   self._root_close:setListener(function ( ... )
      res.doActionDialogHide(self._root, self)

      self._callback(self._Pet)
   end)

--[[
   ID = ID
   SkillId = 技能ID
   ClassId = 职业类型
   Color = 品质
   NextID = 升级后ID
   ExpUp = 升级所需经验
   ExpOffer = 提供多少经验

--]]


   print("DPetSkillFoster pet data")
   print(self._Pet)
   print(self._DBPet)

	self:updateInfo();

   --罗盘点击
   local me=self;
   self._root_bgs_bg02_skillCompass:setListener(function() 

      if me._Pet.Sk == 0 then
         --未学习新技能
      else
         --以学习技能，显示技能罗盘
         GleeCore:showLayer("DPetSkillUpgrade",{nPet=self._Pet,dbPet=self._DBPet,books=self._Books,skill=self._nowSkill5,closeCallback=function ( pet ,books )
            
            --窗口关闭时，进行视图刷新 防止数据有修改
            me._Pet=pet
            me._nowSkill5= dbManager.getInfoSkill(me._Pet.Sk);
            me._Books=books;
            
            me:updateInfo();

         end});

      end

   end)
end

function DPetSkillFoster:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DPetSkillFoster:getSkillName( name )
  if name and not (string.find(name,'\r') or string.find(name,'\n')) then
     name = string.gsub(name,'lv.',"\rlv.")
  end
  return name
end

function DPetSkillFoster:updateInfo( ... )

   --刷新精灵信息
   local nPet = self._Pet
   local dbPet = self._DBPet

   if nPet then
    local petFunc = gameFunc.getPetInfo()
    local itemListData = petFunc.getPetList()

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
    end
   end


   --刷新技能罗盘信息
   
   --获取技能解锁数
   local unlockcount = Res.getAbilityUnlockCount(nPet.AwakeIndex, dbPet.star_level)

   --隐藏罗盘文字
   for i = 2, 5 do
      self[string.format('_root_bgs_bg02_skillCompass_skill%d', i)]:setVisible(false)
   end


   local skillitem = dbManager.getInfoSkill(dbPet.skill_id)

   --require 'LangAdapter'.labelDimensions(self._viewSet[string.format('%s_skillLayout_skill1_normal_name', headStr)], CCSizeMake(80,0))

   local name = skillitem.name
   
   name = self:getSkillName(name)
   

   self._root_bgs_bg02_skillCompass_skill1_name:setString(name)


   for i = 2, 4 do --#dbPet.abilityarrays
     local ability = dbPet.abilityarray[i - 1]

     if unlockcount >= i - 1 then --已解锁
         local sk = dbManager.getInfoSkill(ability)
         self[string.format('_root_bgs_bg02_skillCompass_skill%d', i)]:setVisible(true)

         local name = sk.name
         name = self:getSkillName(name)

         self[string.format('_root_bgs_bg02_skillCompass_skill%d_name', i)]:setString(name)
         require "LangAdapter".fontSize(self[string.format('_root_bgs_bg02_skillCompass_skill%d_name', i)],nil,nil,15,nil,nil,nil,nil,14)

     else --没有解锁
         
     end
   end


   --第5个技能
   if nPet.Sk==0 then
      --没有学习新技能

   else
      --已经学习新技能
      local nowSkill5=dbManager.getInfoSkill(nPet.Sk)
      self[string.format('_root_bgs_bg02_skillCompass_skill%d', 5)]:setVisible(true)


       local name = nowSkill5.name
      name = self:getSkillName(name)
      self[string.format('_root_bgs_bg02_skillCompass_skill%d_name', 5)]:setString(name)
      require "LangAdapter".fontSize(self[string.format('_root_bgs_bg02_skillCompass_skill%d_name', 5)],nil,nil,15,nil,nil,nil,nil,14)

      local book=dbManager.getInfoBookConfig(nPet.Sk)
      --逻辑颜色
      if book.Color == 1 then
         --绿色
         self[string.format('_root_bgs_bg02_skillCompass_skill%d_name', 5)]:setFontFillColor(ccc4f(0.0,0.38039216,0.05882353,1.0), true);
      elseif book.Color == 2 then
         --蓝色
         self[string.format('_root_bgs_bg02_skillCompass_skill%d_name', 5)]:setFontFillColor(ccc4f(0.015686275,0.101960786,0.23137255,1.0), true);
      elseif book.Color == 3 then
         --紫色
         self[string.format('_root_bgs_bg02_skillCompass_skill%d_name', 5)]:setFontFillColor(ccc4f(0.16078432,0.039215688,0.21176471,1.0), true);
      elseif book.Color ==4 then
         --黄色
         self[string.format('_root_bgs_bg02_skillCompass_skill%d_name', 5)]:setFontFillColor(ccc4f(0.44313726,0.14117648,0.0,1.0), true);
      end
      
      self._root_bgs_bg02_skillCompass_skill5:setResid(string.format("JN_jineng%d.png", book.Color));

      end

   --刷新技能书
   self:updateBag();

end

function DPetSkillFoster:updateBag( ... )

   local me=self;

   --清除现有的
   self._root_bgs_bg01_leftBg_list:getContainer():removeAllChildrenWithCleanup(true)
   --列出技能书
   local nPet = self._Pet
   local dbPet = self._DBPet

   local petClass = dbPet.atk_method_system
--[[
   服务器返回 技能书 Book
   Bid Int 配置 ID
   Amount Int 数量
   Tp Int 等级上限
]]--
   local books = self._Books

   --对技能书进行排序  从品质从高到低

   table.sort( books, function(a,b) 

         local abook=dbManager.getInfoBookConfig(a.Bid);
         local bbook=dbManager.getInfoBookConfig(b.Bid);

         if abook.Color == bbook.Color then
            if abook.skilllv == bbook.skilllv then
               return a.Id > b.Id
            else
               return abook.skilllv > bbook.skilllv
            end
         else
            return abook.Color>bbook.Color
         end

      end)

--[[
   Book
   ID = ID
   SkillId = 技能ID
   skilllv = 技能等级
   ClassId = 职业类型
   Color = 品质
   NextID = 升级后ID
   ExpUp = 升级所需经验
   ExpOffer = 提供多少经验
   uplimit = 最高等级上限
   Cid = 唯一标示

--]]

   local function getShowSkillBookDetailFunc(data)
      return function()  GleeCore:showLayer('DSkillBookDetailUP',data) end
   end

   local function putClassBook(classId)

      --检查存在的数量 如果等于0则直接退出
      local classCount=0;
      for i,v in ipairs(books) do
         local book=dbManager.getInfoBookConfig(v.Bid);

         if book.ClassId == classId then
            classCount=classCount+1;
         end
      end

      if classCount == 0 then
         return;
      end


      --创建标题
      local title= self:createLuaSet("@title");

      title.titleLabel:setString(res.locString(string.format("Bag$Treasure%d",classId)));

      self._root_bgs_bg01_leftBg_list:getContainer():addChild(title[1]);



      local line= self:createLuaSet("@gemLine");
      local count=0;--用于控制一行显示4个
      for i,v in ipairs(books) do
         local book=dbManager.getInfoBookConfig(v.Bid);

         print("book............")
         print(book)
         local skill=dbManager.getInfoSkill(book.SkillId);
         


         --职业类型
         if book.ClassId == classId then
            --全部列出
            for index=1,v.Amount do
               

               if count>=4 then
                  line=self:createLuaSet("@gemLine");
                  count=0;
               end

               count=count+1

               if count==1 then
                  self._root_bgs_bg01_leftBg_list:getContainer():addChild(line[1]);
               end

               local icon=self:createLuaSet("@gemItem");
               icon["title"]:setString(skill.name);
               line["layout"]:addChild(icon[1]);

               require 'LangAdapter'.labelDimensions(icon['title'],nil,nil,nil,nil,CCSizeMake(0,0))
               require 'LangAdapter'.LabelNodeAutoShrink(icon['title'],85)

               icon["scale_btn"]:setListener(
                  --弹出详细信息框
                  getShowSkillBookDetailFunc({book=book,skill=skill,bookNetData=v,nPet=nPet,dbPet=dbPet,nowSkill5=me._nowSkill5,callback=function ( data  )
                     
                     --设置尽量新数据，然后刷新界面
                     print(data)
                     if data.Pet then
                         PetInfo.setPet(data.Pet)
                        me._Pet=data.Pet
                        me._nowSkill5= dbManager.getInfoSkill(me._Pet.Sk);
                        me._Books=PerlBookFunc.getBooks();

                        me:updateInfo();

                     else
                        me:toast("技能书学习遇到错误。");
                     end


                  end})
               )

               --设置窗口样式
               res.setNodeWithBook(icon["scale_icon"],book)

            end
         end
         
      end
   end

   putClassBook(0);
   putClassBook(petClass);

   if self._root_bgs_bg01_leftBg_list:getContainer():getChildrenCount() == 0 then
      self._root_bgs_bg01_leftBg_noBookLabel:setVisible(true);
   else
      self._root_bgs_bg01_leftBg_noBookLabel:setVisible(false);
   end

   

end


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPetSkillFoster, "DPetSkillFoster")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPetSkillFoster", DPetSkillFoster)
