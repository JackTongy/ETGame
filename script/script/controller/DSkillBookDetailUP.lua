local Config = require "Config"

local res = require "Res"
local netModel = require "netModel"
local PerlBookFunc = require 'PerlBookInfo'


local DSkillBookDetailUP = class(LuaDialog)

function DSkillBookDetailUP:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DSkillBookDetailUP.cocos.zip")
    return self._factory:createDocument("DSkillBookDetailUP.cocos")
end

--@@@@[[[[
function DSkillBookDetailUP:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._root = set:getElfNode("root")
   self._root_icon = set:getElfNode("root_icon")
   self._root_piece = set:getElfNode("root_piece")
   self._root_count = set:getLabelNode("root_count")
   self._root_name = set:getLabelNode("root_name")
   self._root_des = set:getRichLabelNode("root_des")
   self._root_btnClose2 = set:getClickNode("root_btnClose2")
   self._root_btnClose2_text = set:getLabelNode("root_btnClose2_text")
   self._root_btnClose = set:getClickNode("root_btnClose")
   self._root_btnClose_text = set:getLabelNode("root_btnClose_text")
   self._root_btnLearn = set:getClickNode("root_btnLearn")
   self._root_btnLearn_text = set:getLabelNode("root_btnLearn_text")
   self._root_levelUp = set:getLabelNode("root_levelUp")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DSkillBookDetailUP:onInit( userData, netData )
	   --背景点击关闭
   self._clickBg:setListener(function ( ... )
      res.doActionDialogHide(self._root, self)
   end)

   --弹出动画
   res.doActionDialogShow(self._root,function ( ... )
      
   end)

   --关闭按钮
   self._root_btnClose:setListener(function ( ... )
      res.doActionDialogHide(self._root, self)
   end)

    self._root_btnClose2:setListener(function ( ... )
      res.doActionDialogHide(self._root, self)
   end)

  self._root_btnClose2:setVisible(false);

   self.skill=userData.skill;
   self.book=userData.book;
   self.nPet=userData.nPet;
   self.dbPet=userData.dbPet
   self.nowSkill5=userData.nowSkill5

   --[[
   服务器返回 技能书 Book
   Bid Int 配置 ID
   Amount Int 数量
   Tp Int 等级上限
  ]]--
   self.netData=userData.bookNetData;

   self.callback=userData.callback;

   local me = self

   self._root_btnLearn:setListener(function ( ... )
      --学习技能
      --成功 删除数据
      --刷新界面

      if me.nPet.Sk == 0 then
        me:learnSkill();
      else
        GleeCore:showLayer('DConfirmNT',{content = string.format(res.locString( 'PetKill$PetLearnSkillRP'),me.skill.name,me.nowSkill5.name), callback=function ()
          me:learnSkill();
        end});
      end

   end)

   res.setNodeWithBook(self._root_icon,self.book)
   self._root_name:setString(self.skill.name);
   self._root_des:setString(self.skill.skilldes);


   local tp=5;
   if me.netData ~= nil then
      tp=me.netData.Tp;
   else
      tp=me.nPet.SkTp;
   end

   self._root_levelUp:setString(string.format(res.locString("PetKill$SkillLevelUp"),tp))

   if self.netData == nil then

      self._root_btnLearn:setVisible(false);
      self._root_btnClose:setPositionX(self._root_btnClose:getPositionX()+80)
   end

end

function DSkillBookDetailUP:learnSkill()
        if self.netData.Amount>0 then

        self:send(netModel.getModelPetLearn( self.nPet.Id ,self.netData.Id ), function ( data )
          if data and data.D then
            
            --成功 进行回调 
            print("book error")

            print(self.nPet.Sk)
            print(data.D.Pet.Sk)
            print(data.D.Books)
            -- if self.nPet.Sk ~= data.D.Pet.Sk then
            --   --只有不相同的书才会替换
               PerlBookFunc.removeBook(self.netData.Id,1);
            -- end


            if data.D.Books ~= nil then
              PerlBookFunc.updateBooks(data.D.Books);
            end

            self.callback(data.D);

            res.doActionDialogHide(self._root, self)

          end
        end)

      else
        self:toast("技能书数量不足,很明显这是bug");
      end

end

function DSkillBookDetailUP:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DSkillBookDetailUP, "DSkillBookDetailUP")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DSkillBookDetailUP", DSkillBookDetailUP)
