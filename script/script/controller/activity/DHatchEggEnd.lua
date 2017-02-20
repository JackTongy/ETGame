local Config = require "Config"
local dbManager = require "DBManager"
local res = require "Res"
local netModel = require "netModel"
local timeManager = require "TimeManager"


local HatchEggInfo = require "HatchEggInfo"

local DHatchEggEnd = class(LuaDialog)

function DHatchEggEnd:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DHatchEggEnd.cocos.zip")
    return self._factory:createDocument("DHatchEggEnd.cocos")
end

--@@@@[[[[
function DHatchEggEnd:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._bg = set:getJoint9Node("bg")
   self._bg_tbg = set:getElfNode("bg_tbg")
   self._bg_tbg_title = set:getLabelNode("bg_tbg_title")
   self._bg_cbg = set:getElfNode("bg_cbg")
   self._bg_titileRankName = set:getLabelNode("bg_titileRankName")
   self._bg_titleServer = set:getLabelNode("bg_titleServer")
   self._bg_titleQinMi = set:getLabelNode("bg_titleQinMi")
   self._bg_titleTime12 = set:getLabelNode("bg_titleTime12")
   self._bg_list = set:getListNode("bg_list")
   self._normal_bg = set:getElfNode("normal_bg")
   self._pressed_bg = set:getJoint9Node("pressed_bg")
   self._rankIcon = set:getElfNode("rankIcon")
   self._rankLabel = set:getLabelNode("rankLabel")
   self._name = set:getLabelNode("name")
   self._server = set:getLabelNode("server")
   self._qinmi = set:getLabelNode("qinmi")
   self._bg = set:getElfNode("bg")
   self._icon = set:getElfNode("icon")
   self._frame = set:getElfNode("frame")
   self._count = set:getLabelNode("count")
   self._piece = set:getElfNode("piece")
   self._group = set:getLayoutNode("group")
   self._showInfo = set:getClickNode("showInfo")
   self._normal_bg = set:getElfNode("normal_bg")
   self._pressed_bg = set:getJoint9Node("pressed_bg")
   self._rankIcon = set:getElfNode("rankIcon")
   self._rankLabel = set:getLabelNode("rankLabel")
   self._name = set:getLabelNode("name")
   self._server = set:getLabelNode("server")
   self._qinmi = set:getLabelNode("qinmi")
   self._group = set:getLayoutNode("group")
   self._showInfo = set:getClickNode("showInfo")
--   self._@cell1 = set:getTabNode("@cell1")
--   self._@icon = set:getElfNode("@icon")
--   self._@cell2 = set:getTabNode("@cell2")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DHatchEggEnd:onInit( userData, netData )
	--背景点击关闭
   self._clickBg:setListener(function ( ... )
      res.doActionDialogHide(self._bg, self)
   end)

   --弹出动画
   res.doActionDialogShow(self._bg,function ( ... )
      
   end)

   --展示排行榜
   local myRank = HatchEggInfo.getMyRank();
   local ranks = HatchEggInfo.getRanks()
   table.sort(ranks,function ( a,b )
      return a.Rank < b.Rank
   end)


   --根据自己的排名来展示指定位置的排行信息
   local startRank=1;
   local endRank=20;
   for i=startRank,endRank do
      if ranks[i] then
         local rowView = self:createRow(ranks[i],i)
         self._bg_list:getContainer():addChild(rowView[1]);
         if i == myRank then
            rowView[1]:trigger(nil)
         end
      end
   end

end

function DHatchEggEnd:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

--[[

EggHatchRankGet
孵化精灵蛋活动 获取排行数据
请求数据
参数 类型 说明
返回数据

参数      类型                说明
MyRank   Int                 没上榜时 返回 0
Ranks    List<EggHatchRank>



EggHatchRank 
孵化精灵蛋活动 排行数据

字段            类型      说明
Rank           Int      排名
ServerName     String   服务器名
Name           String   玩家名
Energy         Int      亲密度值
Rid            Int      玩家 Id
ServerId       Int      服务器 Id

]]--
function DHatchEggEnd:createRow( eggHatchRank , index)
   local me=self;

   local function initRewardList( idList,resultList )
      for i,rewardID in ipairs(idList) do
         local dbReward = dbManager.getRewardItem(rewardID)
         table.insert(resultList, res.getDetailByDBReward(dbReward))
      end
   end

   local function initIcons(rewardList,iconList)
      for i,reward in ipairs(rewardList) do
         local view=iconList[i];
         print("rewardrewardrewardrewardreward")

         print(reward)

         me:updateRewardIcon(reward,view)
      end
   end


   index = index or 0

   local row=nil;

   if eggHatchRank.Rank <= 3 then
      row = self:createLuaSet("@cell1");

      row["rankIcon"]:setResid(string.format('PHB_PM%d.png', eggHatchRank.Rank))
   else
      row = self:createLuaSet("@cell2");

      row["rankLabel"]:setString(tostring(eggHatchRank.Rank))
   end

   row["name"]:setString(eggHatchRank.Name);
   row["server"]:setString(eggHatchRank.ServerName);
   res.adjustNodeWidth( row["server"], 102)
   row["qinmi"]:setString(tostring(eggHatchRank.Energy));

   row["normal_bg"]:setResid(string.format('JLD_PM_FL%d.png', index%2 == 0 and 1 or 2));


   local rewardList = {}
   --[[
      返回结构
      Rank      = Rank
      RewardID1 = 12点奖励
      RewardID2 = 21点奖励
      RewardID3 = 24点奖励
   ]]--
   local eggRankReward = dbManager.getInfoEggRankReward(eggHatchRank.Rank)

   if eggRankReward then
      initRewardList(eggRankReward.RewardID3,rewardList)
   end

   local rewardIconList={}

   for j=1,3 do
      local icon=self:createLuaSet("@icon");
      table.insert(rewardIconList,icon);
      row["group"]:addChild(icon[1]);
   end

   initIcons(rewardList,rewardIconList);

   --奖励组的点击时，弹出详细信息
   row["showInfo"]:setListener(function( ... )
      GleeCore:showLayer('DHatchEggRankRewardInfo',{time = 24,Rank = eggHatchRank.Rank,rewardList = rewardList})
   end)


   return row;
end


function DHatchEggEnd:updateRewardIcon( data , view)
   local scaleOrigal = 110 / 155
   if data.type == "Gem" then
      --view["name"]:setString(data.name .. " Lv." .. data.lv)
   else
      --view["name"]:setString(data.name)
   end
   
   view["bg"]:setResid(data.bg)
   view["bg"]:setScale(scaleOrigal)
   view["icon"]:setResid(data.icon)
   if data.type == "Pet" or data.type == "PetPiece" then
      view["icon"]:setScale(scaleOrigal * 140 / 95)
   else
      view["icon"]:setScale(scaleOrigal)
   end
   view["frame"]:setResid(data.frame)
   view["frame"]:setScale(scaleOrigal)
   view["count"]:setString(data.count)
   view["piece"]:setVisible(data.isPiece)

   res.addRuneStars( view["frame"], data )
end

function DHatchEggEnd:clearRow( ... )
   
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DHatchEggEnd, "DHatchEggEnd")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DHatchEggEnd", DHatchEggEnd)
