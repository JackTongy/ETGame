local Config = require "Config"
local AppData = require 'AppData'
local Res = require 'Res'
local dbManager = require 'DBManager'
local netModel = require 'netModel'
local EventManager = require 'EventCenter'
local TimerHelper = require 'framework.sync.TimerHelper'

local DRechargeFT = class(LuaDialog)

function DRechargeFT:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DRechargeFT.cocos.zip")
    return self._factory:createDocument("DRechargeFT.cocos")
end

--@@@@[[[[
function DRechargeFT:onInitXML()
	local set = self._set
    self._root = set:getElfNode("root")
    self._root_close = set:getButtonNode("root_close")
    self._root_bg = set:getElfNode("root_bg")
    self._root_pet = set:getElfNode("root_pet")
    self._root_tips1 = set:getLinearLayoutNode("root_tips1")
    self._root_tips1_NO = set:getLabelNode("root_tips1_NO")
    self._root_tips1_tip4 = set:getLabelNode("root_tips1_tip4")
    self._root_tips1_tip6 = set:getLabelNode("root_tips1_tip6")
    self._root_tips2 = set:getLinearLayoutNode("root_tips2")
    self._root_tips2_NO = set:getLabelNode("root_tips2_NO")
    self._root_tips2_tip1 = set:getLabelNode("root_tips2_tip1")
    self._root_tips2_tip2 = set:getLabelNode("root_tips2_tip2")
    self._root_tips2_icon = set:getElfNode("root_tips2_icon")
    self._root_tips2_amount = set:getLabelNode("root_tips2_amount")
    self._root_tips2_tip4 = set:getLabelNode("root_tips2_tip4")
    self._root_tips2_tip6 = set:getLabelNode("root_tips2_tip6")
    self._root_tip3 = set:getLabelNode("root_tip3")
    self._root_btn = set:getClickNode("root_btn")
    self._root_btn_title = set:getLabelNode("root_btn_title")
    self._root_fitpos_btnRight = set:getButtonNode("root_fitpos_btnRight")
    self._root_fitpos_label = set:getLabelNode("root_fitpos_label")
    self._root_equip = set:getColorClickNode("root_equip")
    self._root_equip_normal_content = set:getElfNode("root_equip_normal_content")
    self._root_equip_normal_content_pzbg = set:getElfNode("root_equip_normal_content_pzbg")
    self._root_equip_normal_content_icon = set:getElfNode("root_equip_normal_content_icon")
    self._root_equip_normal_content_pz = set:getElfNode("root_equip_normal_content_pz")
    self._root_equip_normal_name = set:getLabelNode("root_equip_normal_name")
    self._root_equip_normal_starLayout = set:getLayoutNode("root_equip_normal_starLayout")
    self._root_range = set:getElfNode("root_range")
    self._root_list = set:getLinearLayoutNode("root_list")
    self._normal_content = set:getElfNode("normal_content")
    self._normal_content_pzbg = set:getElfNode("normal_content_pzbg")
    self._normal_content_icon = set:getElfNode("normal_content_icon")
    self._normal_content_pz = set:getElfNode("normal_content_pz")
    self._normal_count = set:getLabelNode("normal_count")
    self._normal_isSuit = set:getSimpleAnimateNode("normal_isSuit")
    self._root_giftDes = set:getElfNode("root_giftDes")
    self._blin = set:getElfAction("blin")
--    self._@starss = set:getElfNode("@starss")
--    self._@star = set:getElfNode("@star")
--    self._@line = set:getLinearLayoutNode("@line")
--    self._@gitem = set:getColorClickNode("@gitem")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DRechargeFT:onInit( userData, netData )
  self._root_close:setListener(function ( ... )
    self:releaseTick()
    Res.doActionDialogHide(self._root, self)
  end)
  self._root_fitpos_btnRight:setListener(function()
    --self._root_fitpos_btnRight:setEnabled(false)
    self:playAnimate()
  end)

	self:updateLayer()
  Res.doActionDialogShow(self._root)
end

function DRechargeFT:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DRechargeFT:updateLayer( ... )
  local info = AppData.getRechargeInfo()
  --133
  local enable
  local got 
  if info then
    enable = info.FcRewardGotEnable()
    got = info.isFcRewardGot()
    
    local func = function ( ... )
        self._root_close:trigger(nil)
    end
    local title
    if enable and not got then
      func = function ( ... )
        self:getReward()
      end
      title = Res.locString('DRechargeFT$getReward')
    elseif got then
      title = Res.locString('DRechargeFT$hadGotReward')
    else
      --前往
      func = function ( ... )
        GleeCore:showLayer('DRecharge')
        self:close()
      end
      title = Res.locString('DRechargeFT$GotoRecharge')
    end
    self._root_btn_title:setString(title)
    self._root_btn:setListener(func)
  end

  self:refreshRewards()

end

function DRechargeFT:refreshRewards( ... )
  --local rewardids = {10001,10002,10003,10004,10005}
  local rewardids = {10001,10002,10003,10004,10005}
  local dbrewards = dbManager.getRewards(rewardids)

  if not self.animatePets then
    self.animatePets = {dbrewards[1].itemid, dbrewards[1].itemid + 2}--{66, 68}--{133, 134, 135, 136, 196, 197, 470, 471, 700}
    self._root_pet:setResid(Res.getPetWithPetId(self.animatePets[1]))
    self.animateIndex = 1

    self.animatePos = {{x1 = 292.0, x2 = 831, y = 13}, 
    {x1 = 292.0, x2 = 831, y = 13}, 
    {x1 = 259.0, x2 = 831, y = -23.0},
     {x1 = 259.0, x2 = 831, y = -23.0}, 
     {x1 = 259.0, x2 = 831, y = -23.0},
      {x1 = 259.0, x2 = 831, y = -23.0}, 
      {x1 = 259.0, x2 = 831, y = -23.0}, 
      {x1 = 259.0, x2 = 831, y = -23.0},
       {x1 = 259.0, x2 = 831, y = -23.0}}
  end

  self:refreshBigItem(dbrewards[1])
  self._root_list:removeAllChildrenWithCleanup(true)
  local line
  for i = 1, (#dbrewards - 1) do
    if i % 2 == 1 then
      line = self:createLuaSet('@line')
      self._root_list:addChild(line[1])
    end

    local luaset = self:createLuaSet('@gitem')
    self:refreshGitem(luaset, dbrewards[i + 1])
    line[1]:addChild(luaset[1])
  end

  self._root_tips1_tip4:setString(dbManager.getCharactor(self.animatePets[1]).name)
  self._root_tips2_tip4:setString(dbManager.getCharactor(self.animatePets[2]).name)

end

function DRechargeFT:startTick(func, du)
  self.handles = self.handles or {}
  self.handles[#self.handles+1] = TimerHelper.tick(func,du)
end

function DRechargeFT:releaseTick()
  if self.handles then
    for i,v in ipairs(self.handles) do
      TimerHelper.cancel(v)
    end
  end
  self.handles = nil
end

function DRechargeFT:refreshPet(petID)
  local DBPet = dbManager.getCharactor(petID)

  self._root_equip_normal_name:setString(DBPet.name)
  --self._root_equip_normal_content_pzbg:setResid(resid[1])
  self._root_equip_normal_content_icon:setResid(Res.getPetIcon(DBPet.id))

  local tempPet = AppData.getPetInfo().getPetInfoByPetId(petID)
  self._root_equip_normal_content_pz:setResid(Res.getPetIconFrame(tempPet))

  require 'PetNodeHelper'.updateStarLayout(self._root_equip_normal_starLayout, DBPet)

  self._root_equip:setListener(function ( ... )
    GleeCore:showLayer("DPetDetailV", {PetInfo = AppData.getPetInfo().getPetInfoByPetId(petID)}) 
  end)
end

function DRechargeFT:refreshBigItem(dbreward)

  --self._root_name:setString(dbManager.getCharactor(68).name)
  self._root_tips2_amount:setString('500')
  require 'LangAdapter'.selectLang(nil,nil,nil,function ( ... )
    self._root_tips2_amount:setString('500 초과 구매 시')
    self._root_tips2_tip1:setString('')
    self._root_tips2_tip2:setString('')
    self._root_tips1_tip6:setString('를 드립니다.')
    self._root_tips2_icon:setScaleX(0)
    self._root_tips2_tip6:setString('를 드립니다.')
  end)
  self._root_tip3:setString(string.format(Res.locString('DRechargeFT$Title9'),'500'))
  
  --indo
  require 'LangAdapter'.selectLangkv({Indonesia=function ( ... )
    self._root_tip3:setVisible(false)
  end})
  
  local str,resid,pzindex = Res.getRewardStrAndResId(dbreward.itemtype,dbreward.itemid,dbreward.args)
  self._root_equip_normal_content_pzbg:setResid(resid[1])
  self._root_equip_normal_content_icon:setResid(resid[2])
  self._root_equip_normal_content_pz:setResid(resid[3])
  if dbreward.itemtype == 7 then
    local DBEquip = dbManager.getInfoEquipment(dbreward.itemid)
    self._root_equip_normal_name:setString(DBEquip.name)
  elseif dbreward.itemtype == 6 then
    -- local DBPet = dbManager.getCharactor(dbreward.itemid)
    -- self._root_equip_normal_name:setString(DBPet.name)
    self:refreshPet(dbreward.itemid)
  end

  local update = function ( ... )
    for i = 1, 5 do
      self:runWithDelay(function ( ... )
        local itemset = self:createLuaSet('@star')
        local action  = self._blin:clone()
        local size = self._root_range:getContentSize()
        local starnode = itemset[1]

        local nodesize = starnode:getContentSize()
        local x = math.random(-(size.width/2-nodesize.width/2),size.width/2-nodesize.width/2)
        local y = math.random(-(size.height/2-nodesize.height/2),size.height/2-nodesize.height/2)
        starnode:setPosition(ccp(x,y))
        starnode:setScale(math.random(0.3,1))
        self._root_range:addChild(starnode)
        action:setListener(function ( ... )
          starnode:removeFromParentAndCleanup(true)
        end)
        starnode:runElfAction(action)
      end, i * 0.15)
    end
  end
  self:startTick(update,1)
  -- if resid[3] then
  --   set['_root_equip_normal_content_icon']:setScale(135/set['normal_content_icon']:getContentSize().width)
  -- end
  
  -- if dbreward.itemtype == 6 or dbreward.itemtype == 7 then -- 精灵  装备
  --   set['normal_isSuit']:setVisible(true)
  -- else
  --   set['normal_isSuit']:setVisible(false)
  -- end
  
  -- if dbreward.itemtype == 7 then
  --   local equip = dbManager.getInfoEquipment(dbreward.itemid)  
  --   set['normal_isSuit']:setVisible(equip and equip.set ~= 0)
  -- end

  -- self._root_equip:setListener(function ( ... )
  --   if dbreward.itemtype == 6 then -- 精灵
  --     GleeCore:showLayer("DPetDetailV", {PetInfo = AppData.getPetInfo().getPetInfoByPetId(dbreward.itemid)})
  --   elseif dbreward.itemtype == 7 then -- 装备
  --     local EquipInfo = AppData.getEquipInfo().getEquipInfoByEquipmentID(dbreward.itemid)
  --     if dbreward.args then
  --       EquipInfo.Value = dbreward.args[1] or EquipInfo.Value
  --       EquipInfo.Grow = dbreward.args[2] or EquipInfo.Grow
  --       EquipInfo.Tp = dbreward.args[3] or EquipInfo.Tp
  --     end
  --     EquipInfo.Rank = AppData.getEquipInfo().getRank(EquipInfo)
  --     -- GleeCore:showLayer("DEquipInfoWithNoGem", {EquipInfo = EquipInfo})
  --     GleeCore:showLayer("DEquipDetail",{nEquip =EquipInfo})
  --   elseif dbreward.itemtype == 8 then -- 宝石
  --     GleeCore:showLayer("DGemDetail",{GemInfo = AppData.getGemInfo().getGemByGemID(dbreward.itemid, dbreward.args[1],dbreward.args[2]), ShowOnly = true})
  --   elseif dbreward.itemtype == 9 then -- 道具
  --     local Seconds = (dbreward.args and dbreward.args[1]) or 0
  --     GleeCore:showLayer("DMaterialDetail", {materialId = dbreward.itemid})
  --   end 
  -- end)

end

function DRechargeFT:refreshGitem( set,dbreward )
  local str,resid,pzindex = Res.getRewardStrAndResId(dbreward.itemtype,dbreward.itemid,dbreward.args)

  set['normal_content_pzbg']:setResid(resid[1])
  set['normal_content_icon']:setResid(resid[2])
  set['normal_content_pz']:setResid(resid[3])
  local amount = tonumber(dbreward.amount)
  if amount > 10000 then
  	if Config.LangName == "english" or Config.LangName == "German" then
		set['normal_count']:setString(string.format('x%dK',tonumber(dbreward.amount / 1000)))
	else
		set['normal_count']:setString(string.format('x%dw',tonumber(dbreward.amount / 10000)))
    local func = function ( ... )
      set['normal_count']:setString(string.format('x%dk',tonumber(dbreward.amount / 1000)))
    end

    require 'LangAdapter'.selectLangkv({Arabic=func,ES=func,PT=func})
	end
    
  else
    set['normal_count']:setString(string.format('x%d',tonumber(dbreward.amount)))
  end
  if resid[3] then
    set['normal_content_icon']:setScale(135/set['normal_content_icon']:getContentSize().width)
  end
  
  -- if dbreward.itemtype == 6 or dbreward.itemtype == 7 then -- 精灵  装备
  --   set['normal_isSuit']:setVisible(true)
  -- else
  --   set['normal_isSuit']:setVisible(false)
  -- end
  
  -- if dbreward.itemtype == 7 then
  --   local equip = dbManager.getInfoEquipment(dbreward.itemid)  
  --   set['normal_isSuit']:setVisible(equip and equip.set ~= 0)
  -- end

  set[1]:setListener(function ( ... )
    if dbreward.itemtype == 6 then -- 精灵
      GleeCore:showLayer("DPetDetailV", {PetInfo = AppData.getPetInfo().getPetInfoByPetId(dbreward.itemid)})
    elseif dbreward.itemtype == 7 then -- 装备
      local EquipInfo = AppData.getEquipInfo().getEquipInfoByEquipmentID(dbreward.itemid)
      if dbreward.args then
        EquipInfo.Value = dbreward.args[1] or EquipInfo.Value
        EquipInfo.Grow = dbreward.args[2] or EquipInfo.Grow
        EquipInfo.Tp = dbreward.args[3] or EquipInfo.Tp
      end
      EquipInfo.Rank = AppData.getEquipInfo().getRank(EquipInfo)
      -- GleeCore:showLayer("DEquipInfoWithNoGem", {EquipInfo = EquipInfo})
      GleeCore:showLayer("DEquipDetail",{nEquip =EquipInfo})
    elseif dbreward.itemtype == 8 then -- 宝石
      GleeCore:showLayer("DGemDetail",{GemInfo = AppData.getGemInfo().getGemByGemID(dbreward.itemid, dbreward.args[1],dbreward.args[2]), ShowOnly = true})
    elseif dbreward.itemtype == 9 then -- 道具
      local Seconds = (dbreward.args and dbreward.args[1]) or 0
      GleeCore:showLayer("DMaterialDetail", {materialId = dbreward.itemid})
    end 
  end)

end

--net
function DRechargeFT:getReward( ... )
  self:send(netModel.getRoleGetFcReward(),function ( data )
    if data and data.D then
      local callback = function ( ... )
        AppData.updateResource(data.D.Resource)
        self:close()
      end
      data.D.Reward.callback = callback
      GleeCore:showLayer('DGetReward',data.D.Reward)
      require 'RechargeInfo'.setFcRewardGot(true)
      EventManager.eventInput('RoleGetFcReward')
    end
  end)
end

function DRechargeFT:playAnimate()
  -- if not self.animatePets then
  --   self.animatePets = {72, 73}--{66, 68}--{133, 134, 135, 136, 196, 197, 470, 471, 700}
  --   self.animateIndex = 1

  --   self.animatePos = {{x1 = 292.0, x2 = 831, y = 13}, 
  --   {x1 = 292.0, x2 = 831, y = 13}, 
  --   {x1 = 259.0, x2 = 831, y = -23.0},
  --    {x1 = 259.0, x2 = 831, y = -23.0}, 
  --    {x1 = 259.0, x2 = 831, y = -23.0},
  --     {x1 = 259.0, x2 = 831, y = -23.0}, 
  --     {x1 = 259.0, x2 = 831, y = -23.0}, 
  --     {x1 = 259.0, x2 = 831, y = -23.0},
  --      {x1 = 259.0, x2 = 831, y = -23.0}}
  -- end
  local curIndex = self.animateIndex
  local nextIndex = self.animateIndex + 1
  if nextIndex > #self.animatePets then
    nextIndex = 1
  end
  
  local arr = CCArray:create()
  arr:addObject(self:getOutAciton(curIndex))
  
  local setNewPet = CCCallFunc:create(function ()
    self._root_pet:setResid(Res.getPetWithPetId(self.animatePets[nextIndex]))

    self._root_pet:setPosition(ccp(self.animatePos[nextIndex].x2, self.animatePos[nextIndex].y))
  end)

  local animateEnd = CCCallFunc:create(function ()
    --print('msg:----------------self.animatePets[nextIndex]:  '..tostring(self.animatePets[nextIndex]))
    self:refreshPet(self.animatePets[nextIndex])
    if nextIndex == 1 then
      self._root_fitpos_label:setString(Res.locString('DRechargeFT$final'))

      self._root_giftDes:setResid('N_CZ_jiahzi2.png')
    elseif nextIndex == 2 then
      self._root_fitpos_label:setString(Res.locString('DRechargeFT$origin'))

      self._root_giftDes:setResid('N_CZ_jiahzi.png')
    end
    --self._root_fitpos_btnRight:setEnabled(true)
  end)

  arr:addObject(setNewPet)
  arr:addObject(self:getInAciton(nextIndex))
  arr:addObject(animateEnd)
  local sequence = CCSequence:create(arr)

  self._root_pet:runAction(sequence)

  self.animateIndex = self.animateIndex + 1
  if self.animateIndex > #self.animatePets then
    self.animateIndex = 1
  end
end

function DRechargeFT:getInAciton(index)
  local arr = CCArray:create()
  --print('msg:--------------------------index: '..tostring(index)..'     self.animatePos[index].x1: '..tostring(self.animatePos[index].x1)..'   self.animatePos[index].y:  '..tostring(self.animatePos[index].y))
  local moveTo1 = CCMoveTo:create(0.3, ccp(self.animatePos[index].x1 - 20, self.animatePos[index].y))
  local fadeIn = CCFadeTo:create(0.3, 255)
  local spawn = CCSpawn:createWithTwoActions(moveTo1, fadeIn)

  local moveTo2 = CCMoveTo:create(0.2, ccp(self.animatePos[index].x1 + 20, self.animatePos[index].y))
  local moveTo3 = CCMoveTo:create(0.1, ccp(self.animatePos[index].x1, self.animatePos[index].y))
  
  arr:addObject(spawn)
  arr:addObject(moveTo2)
  arr:addObject(moveTo3)
  local sequence = CCSequence:create(arr)
  
  return sequence
end

function DRechargeFT:getOutAciton(index)
  local arr1 = CCArray:create()
  --print('msg:--------------------------index: '..tostring(index))--..'     self.animatePos[index].x1: '..tostring(self.animatePos[index].x1)..'   self.animatePos[index].y:  '..tostring(self.animatePos[index].y))
  local moveTo1 = CCMoveTo:create(0.2, ccp(self.animatePos[index].x1 - 20, self.animatePos[index].y))
  local moveTo2 = CCMoveTo:create(0.3, ccp(self.animatePos[index].x2, self.animatePos[index].y))
  local fadeOut = CCFadeTo:create(0.3, 0)

  local spawn = CCSpawn:createWithTwoActions(moveTo2, fadeOut)

  arr1:addObject(moveTo1)
  arr1:addObject(spawn)
  local sequence = CCSequence:create(arr1)
  
  return sequence
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DRechargeFT, "DRechargeFT")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DRechargeFT", DRechargeFT)
