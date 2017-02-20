local Config = require "Config"
local res = require "Res"


local DHatchEggRankRewardInfo = class(LuaDialog)

function DHatchEggRankRewardInfo:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DHatchEggRankRewardInfo.cocos.zip")
    return self._factory:createDocument("DHatchEggRankRewardInfo.cocos")
end

--@@@@[[[[
function DHatchEggRankRewardInfo:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getJoint9Node("bg")
    self._bg_layoutReward = set:getLayoutNode("bg_layoutReward")
    self._hale = set:getElfNode("hale")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._name = set:getLabelNode("name")
    self._count = set:getLabelNode("count")
    self._piece = set:getElfNode("piece")
    self._btn = set:getElfNode("btn")
    self._hale = set:getElfNode("hale")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._name = set:getLabelNode("name")
    self._count = set:getLabelNode("count")
    self._piece = set:getElfNode("piece")
    self._btn = set:getElfNode("btn")
    self._hale = set:getElfNode("hale")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._name = set:getLabelNode("name")
    self._count = set:getLabelNode("count")
    self._piece = set:getElfNode("piece")
    self._btn = set:getElfNode("btn")
    self._bg_title = set:getLabelNode("bg_title")
    self._bg_title2 = set:getLabelNode("bg_title2")
    self._bg_rankIcon = set:getElfNode("bg_rankIcon")
    self._bg_rankLabel = set:getLabelNode("bg_rankLabel")
--    self._@item = set:getElfNode("@item")
--    self._@item = set:getElfNode("@item")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------

--[[

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

function DHatchEggRankRewardInfo:onInit( userData, netData )
	
   --背景点击关闭
   self._clickBg:setListener(function ( ... )
      res.doActionDialogHide(self._bg, self)
   end)

   --弹出动画
   res.doActionDialogShow(self._bg,function ( ... )
      
   end)

   --读取数据
   local time = userData.time
   local Rank = userData.Rank
   local rewardList = userData.rewardList

   --刷新界面
   self._bg_title:setString(string.format(res.locString("Activity$HatchEggRankRewardInfoTimeTitle"), userData.time));


   if Rank <= 3 then
      self._bg_rankIcon:setResid(string.format('PHB_PM%d.png', Rank));
      self._bg_rankIcon:setScale(0.6)
      self._bg_rankLabel:setString("")
   else
      self._bg_rankIcon:setScale(0)
      self._bg_rankLabel:setString(Rank)
   end

   for i,v in ipairs(rewardList) do
      local item=self:createLuaSet("@item");
      self:updateRewardIcon(v,item);
      self._bg_layoutReward:addChild(item[1]);
   end



end

function DHatchEggRankRewardInfo:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DHatchEggRankRewardInfo:updateRewardIcon( data , view)
   local scaleOrigal = 110 / 220
   if data.type == "Gem" then
      view["name"]:setString(data.name .. " Lv." .. data.lv)
   else
      view["name"]:setString(data.name)
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


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DHatchEggRankRewardInfo, "DHatchEggRankRewardInfo")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DHatchEggRankRewardInfo", DHatchEggRankRewardInfo)
