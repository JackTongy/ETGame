local Config = require "Config"

local dbManager = require "DBManager"
local res = require "Res"
local netModel = require "netModel"
local timeManager = require "TimeManager"


local HatchEggInfo = require "HatchEggInfo"

local DHatchEggRank = class(LuaDialog)

function DHatchEggRank:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DHatchEggRank.cocos.zip")
    return self._factory:createDocument("DHatchEggRank.cocos")
end

--@@@@[[[[
function DHatchEggRank:onInitXML()
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
    self._bg_titleTime21 = set:getLabelNode("bg_titleTime21")
    self._bg_titleTime24 = set:getLabelNode("bg_titleTime24")
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
    self._group12 = set:getLayoutNode("group12")
    self._group21 = set:getLayoutNode("group21")
    self._group24 = set:getLayoutNode("group24")
    self._getLabel12 = set:getLabelNode("getLabel12")
    self._getLabel21 = set:getLabelNode("getLabel21")
    self._getLabel24 = set:getLabelNode("getLabel24")
    self._showInfo12 = set:getClickNode("showInfo12")
    self._showInfo21 = set:getClickNode("showInfo21")
    self._showInfo24 = set:getClickNode("showInfo24")
    self._normal_bg = set:getElfNode("normal_bg")
    self._pressed_bg = set:getJoint9Node("pressed_bg")
    self._rankIcon = set:getElfNode("rankIcon")
    self._rankLabel = set:getLabelNode("rankLabel")
    self._name = set:getLabelNode("name")
    self._server = set:getLabelNode("server")
    self._qinmi = set:getLabelNode("qinmi")
    self._group12 = set:getLayoutNode("group12")
    self._group21 = set:getLayoutNode("group21")
    self._group24 = set:getLayoutNode("group24")
    self._getLabel12 = set:getLabelNode("getLabel12")
    self._getLabel21 = set:getLabelNode("getLabel21")
    self._getLabel24 = set:getLabelNode("getLabel24")
    self._showInfo12 = set:getClickNode("showInfo12")
    self._showInfo21 = set:getClickNode("showInfo21")
    self._showInfo24 = set:getClickNode("showInfo24")
    self._bg_titleBottom = set:getLabelNode("bg_titleBottom")
--    self._@cell1 = set:getTabNode("@cell1")
--    self._@icon = set:getElfNode("@icon")
--    self._@cell2 = set:getTabNode("@cell2")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DHatchEggRank:onInit( userData, netData )
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
   local endRank=4;
   if myRank==0 then
      startRank,endRank=#ranks-3,#ranks;
   elseif myRank<=2 then
      --显示前4名玩家
      startRank,endRank=1,4;
   elseif myRank<20 then
      --显示自己前2名和后一名
      startRank,endRank=myRank-2,myRank+1;
   else
      --显示17到18
      startRank,endRank=#ranks-3,#ranks;
   end

   if startRank<1 then startRank=1 end
   --展示
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

function DHatchEggRank:onBack( userData, netData )
	
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
function DHatchEggRank:createRow( eggHatchRank , index)
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

   row["getLabel12"]:setVisible(false)
   row["getLabel21"]:setVisible(false)
   row["getLabel24"]:setVisible(false)


   local reward1List = {}
   local reward2List = {}
   local reward3List = {}

   --[[
      返回结构
      Rank      = Rank
      RewardID1 = 12点奖励
      RewardID2 = 21点奖励
      RewardID3 = 24点奖励
   ]]--
   local eggRankReward = dbManager.getInfoEggRankReward(eggHatchRank.Rank)

-- eggRankReward={}
-- eggRankReward.RewardID1={10001,10002,10003}
-- eggRankReward.RewardID2={10001,10002,10003}
-- eggRankReward.RewardID3={10001,10002,10003}
   if eggRankReward then
      initRewardList(eggRankReward.RewardID1,reward1List)
      initRewardList(eggRankReward.RewardID2,reward2List)
      initRewardList(eggRankReward.RewardID3,reward3List)
   end

   local reward1IconList={}
   local reward2IconList={}
   local reward3IconList={}

   for i=1,3 do
      for j=1,3 do
         local icon=self:createLuaSet("@icon");
         table.insert(i==1 and reward1IconList or i==2 and reward2IconList or reward3IconList,icon);
         row[string.format("group%d",i==1 and 12 or i==2 and 21 or 24)]:addChild(icon[1]);
      end
   end



   initIcons(reward1List,reward1IconList);
   initIcons(reward2List,reward2IconList);
   initIcons(reward3List,reward3IconList);

   --根据时间来展示是否已领取
   local date = timeManager.getCurrentSeverDate()
   if date.hour >= 12 then
      row["getLabel12"]:setVisible(true)
      row["group12"]:setVisible(false)
   end
   if date.hour >= 21 then
      row["getLabel21"]:setVisible(true)
      row["group21"]:setVisible(false)
   end

   --奖励组的点击时，弹出详细信息
   row["showInfo12"]:setListener(function( ... )
      GleeCore:showLayer('DHatchEggRankRewardInfo',{time = 12,Rank = eggHatchRank.Rank,rewardList = reward1List})
   end)

   row["showInfo21"]:setListener(function( ... )
      GleeCore:showLayer('DHatchEggRankRewardInfo',{time = 21,Rank = eggHatchRank.Rank,rewardList = reward2List})
   end)

   row["showInfo24"]:setListener(function( ... )
      GleeCore:showLayer('DHatchEggRankRewardInfo',{time = 24,Rank = eggHatchRank.Rank,rewardList = reward3List})
   end)


   return row;
end


function DHatchEggRank:updateRewardIcon( data , view)
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

function DHatchEggRank:clearRow( ... )
   
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DHatchEggRank, "DHatchEggRank")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DHatchEggRank", DHatchEggRank)
