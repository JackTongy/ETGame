local Config = require "Config"
local dbManager = require "DBManager"
local gameFunc = require "AppData"
local netModel = require "netModel"
local res = require "Res"
local Res = require 'Res'
local PerlBookFunc = require 'PerlBookInfo'

local PetInfo=require 'PetInfo'

local DPetSkillUpgrade = class(LuaDialog)

function DPetSkillUpgrade:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPetSkillUpgrade.cocos.zip")
    return self._factory:createDocument("DPetSkillUpgrade.cocos")
end

--@@@@[[[[
function DPetSkillUpgrade:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._bg = set:getElfNode("bg")
   self._bg_rightBg = set:getElfNode("bg_rightBg")
   self._bg_rightBg_forAnim0 = set:getElfNode("bg_rightBg_forAnim0")
   self._bg_rightBg_top = set:getElfNode("bg_rightBg_top")
   self._bg_rightBg_top_xingzhen = set:getElfNode("bg_rightBg_top_xingzhen")
   self._bg_rightBg_top_skill5 = set:getElfNode("bg_rightBg_top_skill5")
   self._bg_rightBg_top_skill5_skill5bg = set:getElfNode("bg_rightBg_top_skill5_skill5bg")
   self._bg_rightBg_top_skill5_skill5bg2 = set:getElfNode("bg_rightBg_top_skill5_skill5bg2")
   self._bg_rightBg_top_skill5_skill5name = set:getLabelNode("bg_rightBg_top_skill5_skill5name")
   self._bg_rightBg_top_skill5_book = set:getElfNode("bg_rightBg_top_skill5_book")
   self._bg_rightBg_top_skillbutton = set:getButtonNode("bg_rightBg_top_skillbutton")
   self._bg_rightBg_forAnim = set:getElfNode("bg_rightBg_forAnim")
   self._bg_rightBg_bottom_levelUpGroup = set:getElfNode("bg_rightBg_bottom_levelUpGroup")
   self._bg_rightBg_bottom_levelUpGroup_bs = set:getElfNode("bg_rightBg_bottom_levelUpGroup_bs")
   self._bg_rightBg_bottom_levelUpGroup_bs_button1 = set:getButtonNode("bg_rightBg_bottom_levelUpGroup_bs_button1")
   self._bg_rightBg_bottom_levelUpGroup_bs_button1_btnImg = set:getElfNode("bg_rightBg_bottom_levelUpGroup_bs_button1_btnImg")
   self._bg_rightBg_bottom_levelUpGroup_bs_button2 = set:getButtonNode("bg_rightBg_bottom_levelUpGroup_bs_button2")
   self._bg_rightBg_bottom_levelUpGroup_bs_button2_btnImg = set:getElfNode("bg_rightBg_bottom_levelUpGroup_bs_button2_btnImg")
   self._bg_rightBg_bottom_levelUpGroup_bs_button3 = set:getButtonNode("bg_rightBg_bottom_levelUpGroup_bs_button3")
   self._bg_rightBg_bottom_levelUpGroup_bs_button3_btnImg = set:getElfNode("bg_rightBg_bottom_levelUpGroup_bs_button3_btnImg")
   self._bg_rightBg_bottom_levelUpGroup_bs_button4 = set:getButtonNode("bg_rightBg_bottom_levelUpGroup_bs_button4")
   self._bg_rightBg_bottom_levelUpGroup_bs_button4_btnImg = set:getElfNode("bg_rightBg_bottom_levelUpGroup_bs_button4_btnImg")
   self._bg_rightBg_bottom_levelUpGroup_progressBg = set:getElfNode("bg_rightBg_bottom_levelUpGroup_progressBg")
   self._bg_rightBg_bottom_levelUpGroup_progressBg_progress = set:getProgressNode("bg_rightBg_bottom_levelUpGroup_progressBg_progress")
   self._bg_rightBg_bottom_levelUpGroup_progressBg_ptext = set:getLabelNode("bg_rightBg_bottom_levelUpGroup_progressBg_ptext")
   self._bg_rightBg_bottom_levelUpGroup_btnLevelUp = set:getClickNode("bg_rightBg_bottom_levelUpGroup_btnLevelUp")
   self._bg_rightBg_bottom_levelUpGroup_btnLevelUp_btntext = set:getLabelNode("bg_rightBg_bottom_levelUpGroup_btnLevelUp_btntext")
   self._bg_rightBg_bottom_levelUpGroup_levelLimitView = set:getElfNode("bg_rightBg_bottom_levelUpGroup_levelLimitView")
   self._bg_rightBg_bottom_levelUpGroup_levelLimitView_sucRate = set:getLabelNode("bg_rightBg_bottom_levelUpGroup_levelLimitView_sucRate")
   self._bg_rightBg_bottom_levelUpGroup_levelLimitView_button1 = set:getButtonNode("bg_rightBg_bottom_levelUpGroup_levelLimitView_button1")
   self._bg_rightBg_bottom_levelUpGroup_levelLimitView_button1_btnImg = set:getElfNode("bg_rightBg_bottom_levelUpGroup_levelLimitView_button1_btnImg")
   self._bg_rightBg_bottom_levelUpGroup_levelLimitView_button2 = set:getButtonNode("bg_rightBg_bottom_levelUpGroup_levelLimitView_button2")
   self._bg_rightBg_bottom_levelUpGroup_levelLimitView_button2_btnImg = set:getElfNode("bg_rightBg_bottom_levelUpGroup_levelLimitView_button2_btnImg")
   self._bg_rightBg_bottom_levelUpGroup_levelLimitView_button3 = set:getButtonNode("bg_rightBg_bottom_levelUpGroup_levelLimitView_button3")
   self._bg_rightBg_bottom_levelUpGroup_levelLimitView_button3_btnImg = set:getElfNode("bg_rightBg_bottom_levelUpGroup_levelLimitView_button3_btnImg")
   self._bg_rightBg_bottom_levelUpGroup_levelLimitView_button4 = set:getButtonNode("bg_rightBg_bottom_levelUpGroup_levelLimitView_button4")
   self._bg_rightBg_bottom_levelUpGroup_levelLimitView_button4_btnImg = set:getElfNode("bg_rightBg_bottom_levelUpGroup_levelLimitView_button4_btnImg")
   self._bg_rightBg_bottom_levelUpGroup_levelLimitTip = set:getLabelNode("bg_rightBg_bottom_levelUpGroup_levelLimitTip")
   self._bg_rightBg_bottom_levelUpGroup_levelUp = set:getElfNode("bg_rightBg_bottom_levelUpGroup_levelUp")
   self._bg_rightBg_bottom_levelUpGroup_levelUp_curLevel = set:getLabelNode("bg_rightBg_bottom_levelUpGroup_levelUp_curLevel")
   self._bg_rightBg_bottom_levelUpGroup_levelUp_nextLevel = set:getLabelNode("bg_rightBg_bottom_levelUpGroup_levelUp_nextLevel")
   self._bg_rightBg_bottom_TuPoGroup = set:getElfNode("bg_rightBg_bottom_TuPoGroup")
   self._bg_rightBg_bottom_TuPoGroup_bs = set:getElfNode("bg_rightBg_bottom_TuPoGroup_bs")
   self._bg_rightBg_bottom_TuPoGroup_bs_button1 = set:getButtonNode("bg_rightBg_bottom_TuPoGroup_bs_button1")
   self._bg_rightBg_bottom_TuPoGroup_bs_button1_btnImg = set:getElfNode("bg_rightBg_bottom_TuPoGroup_bs_button1_btnImg")
   self._bg_rightBg_bottom_TuPoGroup_levelTuPo = set:getElfNode("bg_rightBg_bottom_TuPoGroup_levelTuPo")
   self._bg_rightBg_bottom_TuPoGroup_levelTuPo_curLevel = set:getLabelNode("bg_rightBg_bottom_TuPoGroup_levelTuPo_curLevel")
   self._bg_rightBg_bottom_TuPoGroup_levelTuPo_nextLevel = set:getLabelNode("bg_rightBg_bottom_TuPoGroup_levelTuPo_nextLevel")
   self._bg_rightBg_bottom_TuPoGroup_levelLimitView = set:getElfNode("bg_rightBg_bottom_TuPoGroup_levelLimitView")
   self._bg_rightBg_bottom_TuPoGroup_levelLimitView_sucRate = set:getLabelNode("bg_rightBg_bottom_TuPoGroup_levelLimitView_sucRate")
   self._bg_rightBg_bottom_TuPoGroup_levelLimitView_button1 = set:getButtonNode("bg_rightBg_bottom_TuPoGroup_levelLimitView_button1")
   self._bg_rightBg_bottom_TuPoGroup_levelLimitView_button1_btnImg = set:getElfNode("bg_rightBg_bottom_TuPoGroup_levelLimitView_button1_btnImg")
   self._bg_rightBg_bottom_TuPoGroup_btnTP = set:getClickNode("bg_rightBg_bottom_TuPoGroup_btnTP")
   self._bg_rightBg_bottom_TuPoGroup_btnTP_btntext = set:getLabelNode("bg_rightBg_bottom_TuPoGroup_btnTP_btntext")
   self._bg_rightBg_bottom_TuPoGroup_levelLimitTip = set:getLabelNode("bg_rightBg_bottom_TuPoGroup_levelLimitTip")
   self._bg_fpLeft_leftBgLevelUp = set:getJoint9Node("bg_fpLeft_leftBgLevelUp")
   self._bg_fpLeft_leftBgLevelUp_list = set:getListNode("bg_fpLeft_leftBgLevelUp_list")
   self._titleLabel = set:getLabelNode("titleLabel")
   self._layout = set:getLinearLayoutNode("layout")
   self._scale_btn = set:getButtonNode("scale_btn")
   self._scale_icon = set:getElfNode("scale_icon")
   self._title = set:getLabelNode("title")
   self._selectIcon = set:getElfNode("selectIcon")
   self._bg_fpLeft_leftBgLevelUp_emptyView = set:getElfNode("bg_fpLeft_leftBgLevelUp_emptyView")
   self._bg_fpLeft_leftBgTuPo = set:getJoint9Node("bg_fpLeft_leftBgTuPo")
   self._bg_fpLeft_leftBgTuPo_list = set:getListNode("bg_fpLeft_leftBgTuPo_list")
   self._titleLabel = set:getLabelNode("titleLabel")
   self._layout = set:getLinearLayoutNode("layout")
   self._scale_btn = set:getButtonNode("scale_btn")
   self._scale_icon = set:getElfNode("scale_icon")
   self._title = set:getLabelNode("title")
   self._selectIcon = set:getElfNode("selectIcon")
   self._bg_fpLeft_leftBgTuPo_emptyView = set:getElfNode("bg_fpLeft_leftBgTuPo_emptyView")
   self._bg_noBookLabel = set:getLabelNode("bg_noBookLabel")
   self._bg_topBar_btnReturn = set:getButtonNode("bg_topBar_btnReturn")
   self._bg_topBar_SJ = set:getTabNode("bg_topBar_SJ")
   self._bg_topBar_SJ_normal_title = set:getLabelNode("bg_topBar_SJ_normal_title")
   self._bg_topBar_SJ_pressed_title = set:getLabelNode("bg_topBar_SJ_pressed_title")
   self._bg_topBar_SJ_invalid_title = set:getLabelNode("bg_topBar_SJ_invalid_title")
   self._bg_topBar_TP = set:getTabNode("bg_topBar_TP")
   self._bg_topBar_TP_normal_title = set:getLabelNode("bg_topBar_TP_normal_title")
   self._bg_topBar_TP_pressed_title = set:getLabelNode("bg_topBar_TP_pressed_title")
   self._bg_topBar_TP_invalid_title = set:getLabelNode("bg_topBar_TP_invalid_title")
   self._screenBtn = set:getButtonNode("screenBtn")
--   self._@anim2 = set:getSimpleAnimateNode("@anim2")
--   self._@anim1 = set:getSimpleAnimateNode("@anim1")
--   self._@anim3 = set:getSimpleAnimateNode("@anim3")
--   self._@anim4 = set:getSimpleAnimateNode("@anim4")
--   self._@title = set:getElfNode("@title")
--   self._@gemLine = set:getElfNode("@gemLine")
--   self._@gemItem = set:getElfNode("@gemItem")
--   self._@title = set:getElfNode("@title")
--   self._@gemLine = set:getElfNode("@gemLine")
--   self._@gemItem = set:getElfNode("@gemItem")
end
--@@@@]]]]


local ViewType = {SJ = 1,TP = 2}


--------------------------------override functions----------------------

function DPetSkillUpgrade:onInit( userData, netData )
	
   --背景点击关闭
   self._clickBg:setListener(function ( ... )
      res.doActionDialogHide(self._bg, self)

      if self.closeCallback then
         self.closeCallback(self.nPet,self.books);
      end

   end)

   --弹出动画
   res.doActionDialogShow(self._bg,function ( ... )
      
   end)

   --关闭按钮
   self._bg_topBar_btnReturn:setListener(function ( ... )
      res.doActionDialogHide(self._bg, self)

      if self.closeCallback then
         self.closeCallback(self.nPet,self.books);
      end

   end)

   self.closeCallback=userData.closeCallback;

   self.nPet=userData.nPet;
   self.dbPet=userData.dbPet;
   self.books=userData.books;
   self.skill=userData.skill;
   self.book=dbManager.getInfoBookConfig(self.nPet.Sk)

   self.levelUpSelected={};
   self.tupoSelected=nil;


   local me=self;

   for i=1,4 do
      local selBtn = self[string.format("_bg_rightBg_bottom_levelUpGroup_levelLimitView_button%d",i)]
      local selIcon = self[string.format("_bg_rightBg_bottom_levelUpGroup_levelLimitView_button%d_btnImg",i)]
      selBtn:setVisible(false)
      selBtn:setListener(function ( ... )
         --取消选择
         if selIcon.data ~= nil then

            selIcon.data.icon["selectIcon"]:setVisible(false);

            local index = table.indexOf(me.levelUpSelected,selIcon.data);

            table.remove(me.levelUpSelected,index)

            me:updateSelIcon();

         end
      end)
   end

   self._bg_rightBg_bottom_TuPoGroup_levelLimitView_button1:setListener(function ( ... )
      --取消图片图标的选择
      if me.tupoSelected == nil then
         return
      end

      me.tupoSelected.icon["selectIcon"]:setVisible(false);

      me.tupoSelected=nil;

      me:updateTupoView();

   end)

   require "LangAdapter".LabelNodeAutoShrink(self._bg_rightBg_bottom_levelUpGroup_btnLevelUp_btntext, 110)
   self._bg_rightBg_bottom_levelUpGroup_btnLevelUp:setListener(function ( ... )
      
      if #me.levelUpSelected >0 then

         --升级
         local books = {}

         local isPurple=false;

         print("book up ")
         print(me.levelUpSelected)
         for i=1,#me.levelUpSelected do
            table.insert(books,me.levelUpSelected[i].bookNetData.Id);

            if me.levelUpSelected[i].book.Color>=3 then
               isPurple=true;
            end

         end



         print(#books)

         print(books)

         

         function updateSkillLevel( ... )
            me:send(netModel.getModelPetSkillUp( me.nPet.Id ,books ), function ( data )
               if data and data.D then
                  
                  --重设数据 
                  for i,v in ipairs(me.levelUpSelected) do
                  --   v.bookNetData.Amount=v.bookNetData.Amount-1;
                     PerlBookFunc.removeBook( v.bookNetData.Id,1 )
                  end
                  PetInfo.setPet(data.D.Pet)

                  PerlBookFunc.updateBooks({data.D.Book})
                  
                  self.books=PerlBookFunc.getBooks();
                  self.nPet=data.D.Pet
                  self.book=dbManager.getInfoBookConfig(self.nPet.Sk)
                  self.skill=dbManager.getInfoSkill(self.nPet.Sk)

                  --成功 刷新列表
                  me:clearAll();
                  me:updateView();

                  me:updateSkillIcon();
               end
           end)
         end


         if isPurple then
            GleeCore:showLayer('DConfirmNT',{content = res.locString( 'PetKill$SkillUpgradeZSTS'), callback=function ()
               updateSkillLevel();
            end});
         else
            updateSkillLevel();
         end
        
      end

   end)

   self._bg_rightBg_bottom_TuPoGroup_btnTP:setListener(function ( ... )
      
      if me.tupoSelected ~= nil then
         --突破
         me:send(netModel.getModelPetSkillTp( me.nPet.Id ,me.tupoSelected.bookNetData.Id ), function ( data )
          if data and data.D then
            
          --  me.tupoSelected.bookNetData.Amount=me.tupoSelected.bookNetData.Amount-1;
            PerlBookFunc.removeBook( me.tupoSelected.bookNetData.Id,1 )

            PetInfo.setPet(data.D.Pet)

            self.nPet=data.D.Pet
            self.book=dbManager.getInfoBookConfig(self.nPet.Sk)
            self.skill=dbManager.getInfoSkill(self.nPet.Sk)
            
            --成功 刷新列表
            me:clearAll();
            me:updateView();

            me:updateSkillIcon();
          end
        end)

      end

   end)

   self._bg_rightBg_top_skillbutton:setListener(function ( ... )
      
      --显示详细
      GleeCore:showLayer('DSkillBookDetailUP',{book=me.book,skill=me.skill,nPet=me.nPet,dbPet=me.dbPet,nowSkill5=me.skill})

   end)

   self:updateSkillIcon();

   self:initTab();

   require 'LangAdapter'.fontSize(self._bg_topBar_SJ_normal_title,nil,nil,nil,nil,18)
   require 'LangAdapter'.fontSize(self._bg_topBar_SJ_pressed_title,nil,nil,nil,nil,18)
   require 'LangAdapter'.fontSize(self._bg_topBar_TP_normal_title,nil,nil,nil,nil,18)
   require 'LangAdapter'.fontSize(self._bg_topBar_TP_pressed_title,nil,nil,nil,nil,18)
end

function DPetSkillUpgrade:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------



function DPetSkillUpgrade:initTab()

   local tabBtns ={[ViewType.SJ] = self._bg_topBar_SJ , [ViewType.TP] = self._bg_topBar_TP}-- {ViewType.SJ = self._bg_topBar_SJ , ViewType.TP = self._bg_topBar_TP};

   table.foreach(tabBtns,function ( viewType,tabBtn )
      tabBtn:setListener(function (  )
         if self.curViewType~=viewType then
            self:onTabChanged()
            local preViewType = self.curViewType
            self.curViewType = viewType
            
            self:updateView()
         end
      end)
   end)

   self.curViewType = ViewType.SJ
   self._bg_topBar_SJ:trigger(nil)
   self:updateView()
end 


function DPetSkillUpgrade:onTabChanged( ... )
   -- body


end

function DPetSkillUpgrade:updateView( ... )
   -- body
   self._bg_rightBg_bottom_levelUpGroup:setVisible(false);
   self._bg_rightBg_bottom_TuPoGroup:setVisible(false);
   self._bg_fpLeft_leftBgLevelUp:setVisible(false);
   self._bg_fpLeft_leftBgTuPo:setVisible(false);

   if self.curViewType == ViewType.SJ then

      --切换到升级模块  释放突破
      self.tupoSelected=nil;
      self._bg_fpLeft_leftBgTuPo_list:getContainer():removeAllChildrenWithCleanup(true);

      self._bg_rightBg_bottom_levelUpGroup:setVisible(true);
      self._bg_fpLeft_leftBgLevelUp:setVisible(true);

      self:updateBag("LevelUp");

      self:updateSelIcon();

   elseif self.curViewType == ViewType.TP then

      --切换到突破模块 释放升级
      self.levelUpSelected={};
      self._bg_fpLeft_leftBgLevelUp_list:getContainer():removeAllChildrenWithCleanup(true);


      self._bg_rightBg_bottom_TuPoGroup:setVisible(true);
      self._bg_fpLeft_leftBgTuPo:setVisible(true);

      self:updateBag("TuPo");
      self:updateTupoView();
   end


end

function DPetSkillUpgrade:clearAll( ... )

      --释放突破
      self.tupoSelected=nil;
      self._bg_fpLeft_leftBgTuPo_list:getContainer():removeAllChildrenWithCleanup(true);

      --释放升级
      self.levelUpSelected={};
      self._bg_fpLeft_leftBgLevelUp_list:getContainer():removeAllChildrenWithCleanup(true);

end


function DPetSkillUpgrade:updateBag( type )

   local me=self;

   --清除现有的
   self[string.format("_bg_fpLeft_leftBg%s_list",type)]:getContainer():removeAllChildrenWithCleanup(true)
   --列出技能书
   local nPet = self.nPet
   local dbPet = self.dbPet

   local petClass = dbPet.atk_method_system
--[[
   服务器返回 技能书 Book
   Bid Int 配置 ID
   Amount Int 数量
   Tp Int 等级上限
]]--
   local books = self.books
   
 table.sort( books, function(a,b) 

         local abook=dbManager.getInfoBookConfig(a.Bid);
         local bbook=dbManager.getInfoBookConfig(b.Bid);

         if abook.Color == bbook.Color then
            if abook.skilllv == bbook.skilllv then
               return a.Id > b.Id
            else
               return abook.skilllv < bbook.skilllv
            end
         else
            return abook.Color<bbook.Color
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

   local function getBookClickFunc(data,callback)
      return function()  callback(data) end
   end

   local function putClassBook(classId)

      --检查存在的数量 如果等于0则直接退出
      local petbook= dbManager.getInfoBookConfig(nPet.Sk);
      local classCount=0;
      for i,v in ipairs(books) do
         local book=dbManager.getInfoBookConfig(v.Bid);

         if type == "LevelUp" and book.ClassId==classId then
            --技能升级 所有书籍都可以作为被选对象
            classCount=classCount+1;

         elseif type == "TuPo" and book.ClassId==classId then
            --技能突破  只能选择Color 相同的技能书 ,如果达到20级 只能使用相同的技能书进行突破
            if book.Color == petbook.Color then

               if nPet.SkTp >=20 then

                  if book.Cid == petbook.Cid then
                     classCount=classCount+1;
                  end

               else
                  classCount=classCount+1;
               end 
               
            end
         end

      end

      if classCount == 0 then
         return;
      end


      --创建标题
      local title= self:createLuaSet("@title");

      title.titleLabel:setString(res.locString(string.format("Bag$Treasure%d",classId)));

      self[ string.format("_bg_fpLeft_leftBg%s_list",type)]:getContainer():addChild(title[1]);



      local line= self:createLuaSet("@gemLine");
      local count=0;--用于控制一行显示4个
      for i,v in ipairs(books) do
         local book=dbManager.getInfoBookConfig(v.Bid);

         local skill=dbManager.getInfoSkill(book.SkillId);
         
         local ok=false;
         if type == "LevelUp" and book.ClassId==classId then
            --技能升级 所有书籍都可以作为被选对象
            ok=true

         elseif type == "TuPo" and book.ClassId==classId then
            --技能突破  只能选择Color 相同的技能书
            if book.Color == petbook.Color then
               if nPet.SkTp >=20 then
                  if book.Cid == petbook.Cid then
                     ok=true
                  end

               else
                  ok=true
               end 
            end
         end


         --职业类型
         if ok then
            --全部列出
            for index=1,v.Amount do
               

               if count>=4 then
                  line=self:createLuaSet("@gemLine");
                  count=0;
               end

               count=count+1

               if count==1 then
                  self[string.format("_bg_fpLeft_leftBg%s_list",type)]:getContainer():addChild(line[1]);
               end

               local icon=self:createLuaSet("@gemItem");
               icon["title"]:setString(skill.name);
               
               icon["title"]:setDimensions(CCSize(0,0))
               require "LangAdapter".LabelNodeAutoShrink(icon["title"],85)

               icon["selectIcon"]:setVisible(false);


               require 'LangAdapter'.fontSize(icon['title'],nil,nil,nil,nil,14)
               line["layout"]:addChild(icon[1]);

               --设置图标样式
               res.setNodeWithBook(icon["scale_icon"],book)

               local me=self;
               if type == "LevelUp" then

                  icon["scale_btn"]:setListener(
                     --可以选择4本书，用于升级
                     getBookClickFunc({icon=icon,book=book,skill=skill,bookNetData=v,nPet=nPet,dbPet=dbPet},function ( data  )
                        if me.book.NextID == 0  or self.nPet.SkTp==self.book.skilllv then
                           return;
                        end

                        --如果已经选择，则进行移除
                        if data.icon["selectIcon"]:isVisible()==true then

                           data.icon["selectIcon"]:setVisible(false);

                           local index = table.indexOf(me.levelUpSelected,data);

                           table.remove(me.levelUpSelected,index)

                           me:updateSelIcon();

                        elseif #me.levelUpSelected <4 then
                           --添加选择项

                           if table.indexOf(me.levelUpSelected,data) ~= -1 then
                              return
                           end


                           data.icon["selectIcon"]:setVisible(true);
                           table.insert(me.levelUpSelected,data);
                           local selIcon = me[string.format("_bg_rightBg_bottom_levelUpGroup_levelLimitView_button%d_btnImg",#me.levelUpSelected)]
                           selIcon.data=data;
                           me:updateSelIcon();

                        end

                     end)
                  )

               elseif type == "TuPo" then
                  icon["scale_btn"]:setListener(
                     --选择同品质的技能书 用于升级 可以替换
                     getBookClickFunc({icon=icon,book=book,skill=skill,bookNetData=v,nPet=nPet,dbPet=dbPet},function ( data  )

                        local maxLv = me.book.uplimit --最大突破上限
                        local nowLv= me.nPet.SkTp --当前最大的升级等级

                        if maxLv == nowLv then
                           return
                        end

                        if data.icon["selectIcon"]:isVisible()==true then
                           --已选择则移除
                           data.icon["selectIcon"]:setVisible(false);

                           me.tupoSelected=nil;

                           me:updateTupoView();

                        elseif me.tupoSelected ~= nil then
                           return
                        else
                           data.icon["selectIcon"]:setVisible(true);
                           if me.tupoSelected ~= nil then
                              me.tupoSelected.icon["selectIcon"]:setVisible(false);
                           end

                           me.tupoSelected=data;
                           me:updateTupoView();
                        end

                     end)
                  );
               end



            end
         end
         
      end
   end

   putClassBook(0);
   putClassBook(1);
   putClassBook(2);
   putClassBook(3);
   putClassBook(4);


end


function DPetSkillUpgrade:updateSkillIcon( ... )
   
      --当前技能图标信息
   local nowBook = self.book
   self._bg_rightBg_top_skill5:setResid(string.format("N_ZB_biankuang%d.png", nowBook.Color));
   self._bg_rightBg_top_skill5_skill5bg:setResid(string.format("N_PZ%d_bg.png", nowBook.Color));
   self._bg_rightBg_top_skill5_skill5bg2:setResid(string.format("JN_jineng%d.png", nowBook.Color));
   self._bg_rightBg_top_skill5_skill5name:setString(self.skill.name);
   require 'LangAdapter'.labelDimensions(self._bg_rightBg_top_skill5_skill5name,nil,nil,nil,nil,CCSizeMake(0,0))
   require 'LangAdapter'.LabelNodeAutoShrink(self._bg_rightBg_top_skill5_skill5name,90)

   if nowBook.Color == 1 then
      --绿色
      self._bg_rightBg_top_skill5_skill5name:setFontFillColor(ccc4f(0.0,0.38039216,0.05882353,1.0), true);
   elseif nowBook.Color == 2 then
      --蓝色
      self._bg_rightBg_top_skill5_skill5name:setFontFillColor(ccc4f(0.015686275,0.101960786,0.23137255,1.0), true);
   elseif nowBook.Color == 3 then
      --紫色
      self._bg_rightBg_top_skill5_skill5name:setFontFillColor(ccc4f(0.16078432,0.039215688,0.21176471,1.0), true);
   elseif nowBook.Color ==4 then
      --黄色
      self._bg_rightBg_top_skill5_skill5name:setFontFillColor(ccc4f(0.44313726,0.14117648,0.0,1.0), true);
   end
   
   self._bg_rightBg_top_skill5_book:setResid(string.format("N_skillbook_%d.png", nowBook.ClassId));

end


function DPetSkillUpgrade:updateSelIcon( ... )
   
   --经验升级信息
   local maxLv = self.nPet.SkTp
   local nowLv = self.book.skilllv
   local nextLv = nowLv

   self._bg_rightBg_bottom_levelUpGroup_levelUp_curLevel:setString( string.format(res.locString("PetKill$SkillUpgradeLVUPcur"),nowLv,maxLv));
   
   local maxExp=self.book.ExpUp;
   local nowExp=self.nPet.SExp;
   local nextExp=nowExp

   if #self.levelUpSelected > 0 then
      for i,v in ipairs(self.levelUpSelected) do
         print(v.book.ExpOffer)
         nextExp=nextExp+v.book.ExpOffer;

         if self.book.ClassId == v.book.ClassId then
            nextExp=nextExp+v.book.ExpOffer;
         end
      end
   end


   if self.book.NextID~=0 then
      --等级信息
      local nextBook = self.book;
      local ccExp=0;
      while(nextBook and nextExp-ccExp >= nextBook.ExpUp)
      do
         print(nowExp)
         print(nextExp)
         print(nextBook.ExpUp)
         ccExp=ccExp+nextBook.ExpUp;

         nextLv=nextLv+1;
         if nextBook.NextID == 0 then 
            nextBook=nil
         else
            nextBook=dbManager.getInfoBookConfig(nextBook.NextID);
         end
      end

      if nextLv > maxLv then
         nextLv = maxLv
      end

   end


   self._bg_rightBg_bottom_levelUpGroup_levelUp_nextLevel:setString( string.format(res.locString("PetKill$SkillUpgradeLVUPnext"),nextLv,maxLv));

   print("exp..........."..self.nPet.SExp)
   print(maxExp)
   print(nextExp)
   self._bg_rightBg_bottom_levelUpGroup_progressBg_ptext:setString(string.format("%d%%",(nextExp/maxExp)*100));
   self._bg_rightBg_bottom_levelUpGroup_progressBg_progress:setPercentage((nextExp/maxExp)*100);



   --4本书
   for i=1,4 do
      local selBtn = self[string.format("_bg_rightBg_bottom_levelUpGroup_levelLimitView_button%d",i)]
      local selIcon = self[string.format("_bg_rightBg_bottom_levelUpGroup_levelLimitView_button%d_btnImg",i)]

      selIcon:removeAllChildrenWithCleanup(true);
      selBtn:setVisible(false);
      selIcon.data=nil;
      if self.levelUpSelected[i] ~= nil then
         selIcon.data=self.levelUpSelected[i];
         res.setNodeWithBook(selIcon,self.levelUpSelected[i].book)
         selBtn:setVisible(true);
      end
   end

   --按钮
   if #self.levelUpSelected==0 then
      --可点击

      self._bg_rightBg_bottom_levelUpGroup_btnLevelUp:setEnabled(false)
   else
      --不可点击
      self._bg_rightBg_bottom_levelUpGroup_btnLevelUp:setEnabled(true)

   end

   

   if self.book.NextID == 0 or maxLv==nowLv then
      --隐藏
      self._bg_rightBg_bottom_levelUpGroup_levelLimitTip:setVisible(true);
      self._bg_rightBg_bottom_levelUpGroup_progressBg:setVisible(false);
      self._bg_rightBg_bottom_levelUpGroup_btnLevelUp:setVisible(false);
      self._bg_rightBg_bottom_levelUpGroup_levelLimitView:setVisible(false);
      self._bg_rightBg_bottom_levelUpGroup_levelUp:setVisible(false);
      self._bg_rightBg_bottom_levelUpGroup_bs:setVisible(false)
   else
      self._bg_rightBg_bottom_levelUpGroup_levelLimitTip:setVisible(false);
      self._bg_rightBg_bottom_levelUpGroup_progressBg:setVisible(true);
      self._bg_rightBg_bottom_levelUpGroup_btnLevelUp:setVisible(true);
      self._bg_rightBg_bottom_levelUpGroup_levelLimitView:setVisible(true);
      self._bg_rightBg_bottom_levelUpGroup_levelUp:setVisible(true);
      self._bg_rightBg_bottom_levelUpGroup_bs:setVisible(true)
   end


   require "LangAdapter".fontSize(self._bg_noBookLabel, nil, nil, 22,nil,nil,22)
   require "LangAdapter".fontSize(self._bg_rightBg_bottom_TuPoGroup_levelTuPo_curLevel, nil, nil, 22,nil,17,15,15)
   require "LangAdapter".fontSize(self._bg_rightBg_bottom_TuPoGroup_levelTuPo_nextLevel, nil, nil, 22,nil,17,15,15)
   require "LangAdapter".fontSize(self._bg_rightBg_bottom_TuPoGroup_levelLimitView_sucRate, nil, nil, 14,nil,14,15,15)
   require "LangAdapter".fontSize(self._bg_rightBg_bottom_levelUpGroup_levelUp_curLevel, nil, nil, 22,nil,nil,20,20)
   require "LangAdapter".fontSize(self._bg_rightBg_bottom_levelUpGroup_levelUp_nextLevel, nil, nil, 22,nil,nil,20,20)
   require "LangAdapter".fontSize(self._bg_rightBg_bottom_levelUpGroup_levelLimitView_sucRate,nil,nil,14,nil,14,14,14,nil,nil,14)
   require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,function ( ... )
   	self._bg_rightBg_bottom_TuPoGroup_levelLimitView_sucRate:setPosition(ccp(0,56.571434))
   end)

   if self._bg_fpLeft_leftBgLevelUp_list:getContainer():getChildrenCount() == 0 then
      self._bg_noBookLabel:setVisible(true);
   else
      self._bg_noBookLabel:setVisible(false);
   end
end

function DPetSkillUpgrade:updateTupoView( ... )
   -- body
   local maxLv = self.book.uplimit --最大突破上限
   
   local nowLv= self.nPet.SkTp --当前最大的升级等级

   local nextLv = nowLv + 5 --突破一次加5级


   if nowLv == maxLv then
      --已经达到等级上限
      self._bg_rightBg_bottom_TuPoGroup_levelLimitTip:setVisible(true);
      self._bg_rightBg_bottom_TuPoGroup_levelTuPo:setVisible(false);
      self._bg_rightBg_bottom_TuPoGroup_levelLimitView:setVisible(false);
      self._bg_rightBg_bottom_TuPoGroup_btnTP:setVisible(false);
      self._bg_rightBg_bottom_TuPoGroup_bs:setVisible(false);
      return;

   else

      self._bg_rightBg_bottom_TuPoGroup_levelLimitTip:setVisible(false);
      self._bg_rightBg_bottom_TuPoGroup_levelTuPo:setVisible(true);
      self._bg_rightBg_bottom_TuPoGroup_levelLimitView:setVisible(true);
      self._bg_rightBg_bottom_TuPoGroup_btnTP:setVisible(true);
      self._bg_rightBg_bottom_TuPoGroup_bs:setVisible(true);


   end

   print("TP.....")
   print(nowLv);
   print(nextLv);
   self._bg_rightBg_bottom_TuPoGroup_levelTuPo_curLevel:setString(string.format(res.locString("PetKill$SkillUpgradeTPcur"),nowLv))
   self._bg_rightBg_bottom_TuPoGroup_levelTuPo_nextLevel:setString(string.format(res.locString("PetKill$SkillUpgradeTPNext"),nextLv))


   local btn=self._bg_rightBg_bottom_TuPoGroup_levelLimitView_button1;
   local btnImg = self._bg_rightBg_bottom_TuPoGroup_levelLimitView_button1_btnImg;
   btn:setVisible(self.tupoSelected ~= nil)

   if self.tupoSelected then
      res.setNodeWithBook(btnImg,self.tupoSelected.book)
   end


   --按钮
   if self.tupoSelected then
      self._bg_rightBg_bottom_TuPoGroup_btnTP:setEnabled(true)
   else
      self._bg_rightBg_bottom_TuPoGroup_btnTP:setEnabled(false)
   end


   if self._bg_fpLeft_leftBgTuPo_list:getContainer():getChildrenCount() == 0 then
      self._bg_noBookLabel:setVisible(true);
   else
      self._bg_noBookLabel:setVisible(false);
   end

   --突破提示文字

   if self.nPet.SkTp >= 20 then
      self._bg_rightBg_bottom_TuPoGroup_levelLimitView_sucRate:setString(res.locString("PetKill$SkillUpgradeTPMessage2"))
   else
      self._bg_rightBg_bottom_TuPoGroup_levelLimitView_sucRate:setString(res.locString("PetKill$SkillUpgradeTPMessage"))
   end

   
   


end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPetSkillUpgrade, "DPetSkillUpgrade")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPetSkillUpgrade", DPetSkillUpgrade)
