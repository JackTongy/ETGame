local Config = require "Config"
local Res       = require 'Res'
local netModel  = require 'netModel'
local dbManager = require 'DBManager'
local appData   = require 'AppData'

local DTitle = class(LuaDialog)

function DTitle:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DTitle.cocos.zip")
    return self._factory:createDocument("DTitle.cocos")
end

--@@@@[[[[
function DTitle:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bgclick = set:getButtonNode("root_bgclick")
   self._root_bg = set:getJoint9Node("root_bg")
   self._root_tbg = set:getElfNode("root_tbg")
   self._root_title = set:getElfNode("root_title")
   self._root_btnupgrade = set:getClickNode("root_btnupgrade")
   self._root_btnupgrade_title = set:getLabelNode("root_btnupgrade_title")
   self._root_lineareff_titledes = set:getLabelNode("root_lineareff_titledes")
   self._root_lineartitle = set:getLinearLayoutNode("root_lineartitle")
   self._root_lineartitle_num = set:getLabelNode("root_lineartitle_num")
   self._root_lineartitle_newtitle = set:getLabelNode("root_lineartitle_newtitle")
   self._root_linearstar = set:getLinearLayoutNode("root_linearstar")
   self._root_linearstar_num = set:getLabelNode("root_linearstar_num")
   self._root_linearstar_own = set:getLabelNode("root_linearstar_own")
   self._root_nextdes = set:getLabelNode("root_nextdes")
   self._root_anim = set:getElfNode("root_anim")
   self._root_anim_roadFires_1 = set:getElfNode("root_anim_roadFires_1")
   self._root_anim_roadFires_1_roadFire = set:getSimpleAnimateNode("root_anim_roadFires_1_roadFire")
   self._root_anim_roadFires_2 = set:getElfNode("root_anim_roadFires_2")
   self._root_anim_roadFires_2_roadFire = set:getSimpleAnimateNode("root_anim_roadFires_2_roadFire")
   self._root_anim_breakIcons_1 = set:getElfNode("root_anim_breakIcons_1")
   self._content = set:getLabelNode("content")
   self._root_anim_breakIcons_2 = set:getElfNode("root_anim_breakIcons_2")
   self._root_anim_breakIcons_3 = set:getElfNode("root_anim_breakIcons_3")
   self._fire = set:getSimpleAnimateNode("fire")
   self._tp = set:getLabelNode("tp")
   self._root_shield = set:getShieldNode("root_shield")
   self._movetopos1 = set:getElfAction("movetopos1")
   self._movetopos2 = set:getElfAction("movetopos2")
--   self._@tp = set:getElfNode("@tp")
--   self._@item = set:getElfNode("@item")
--   self._@break = set:getSimpleAnimateNode("@break")
end
--@@@@]]]]

--------------------------------override functions----------------------
--UserData
--[[
callback
]]
function DTitle:onInit( userData, netData )
	Res.doActionDialogShow(self._root)
  self._root_bgclick:setListener(function ( ... )
    Res.doActionDialogHide(self._root,self)
  end)
  self._root_shield:setVisible(false)
  self:updateLayer()
end

function DTitle:onBack( userData, netData )
	
end

function DTitle:close( ... )
  local userData = self:getUserData()
  return userData and userData.callback and userData.callback()
end
--------------------------------custom code-----------------------------

function DTitle:updateLayer( anim )
  self._TitleID = appData.getUserInfo().getTitleID()

  local dbtitle = dbManager.getTrainTitle(self._TitleID)
  local titles = dbManager.getTrainTitleList(dbtitle.Name)
  local trainTimes  = titles[#titles].Id - self._TitleID
  local nLvtitle  = dbManager.getTrainTitle(titles[#titles].Id+1)
  local ntitle    = dbManager.getTrainTitle(self._TitleID+1)
  self._titles    = titles
  local clickfunc

  clickfunc = function ( ... )
    self:RaiseTitle()  
  end

  if nLvtitle and trainTimes > 0 then
    --训练
    self._root_lineartitle_num:setString(string.format(Res.locString('DTtitle$number'),trainTimes))
    self._root_lineartitle_newtitle:setString(nLvtitle.Name)
    self._root_lineartitle:setVisible(true)
    self._root_btnupgrade_title:setString(Res.locString('DTtitle$btn1'))
  elseif nLvtitle and trainTimes == 0 then
    --晋升
    self._root_lineartitle:setVisible(false)
    self._root_btnupgrade_title:setString(Res.locString('DTtitle$btn2'))
  elseif nLvtitle == nil then
    --max
    self._root_nextdes:setString(Res.locString('DTtitle$Tip5'))
    self._root_linearstar:setVisible(false)
    self._root_btnupgrade:setVisible(false)
    self._root_lineartitle:setVisible(false)
  end

  if ntitle then
    local totalstars = appData.getUserInfo().getTotalStars()
    self._root_linearstar_num:setString(tostring(ntitle.score))
    self._root_linearstar_own:setString(tostring(totalstars))
    self._root_nextdes:setString(self:getEffectDes(dbtitle,ntitle))
    if totalstars < ntitle.score then
      clickfunc = function ( ... )
        self:toast(Res.locString('DTtitle$Tip6'))
      end
    end
    self._root_btnupgrade:setEnabled(totalstars >= ntitle.score)
  end

  self._root_title:setResid(string.format('XL_%d.png',dbtitle.titlelv or 0))
  self._root_lineareff_titledes:setString(self:getEffectDes(dbtitle))

  self._root_btnupgrade:setListener(function ( ... )
     return clickfunc and clickfunc()
  end)

  self:updateStar(anim)
end

function DTitle:updateStar( anim )
  local curIndex = 1
  for i,v in ipairs(self._titles) do
      if v.Id == self._TitleID then
        curIndex = i
        break
      end
  end

  local nextsteps = (#self._titles-curIndex)
  local pos = (nextsteps < 3 and (3-nextsteps)) or 1
  local moveaction = false
  if anim and pos == 1 and curIndex > 1 then
    pos = 2
    moveaction = true
  end

  local startIndex = curIndex - (pos -1)
  local set3
  for i=1,3 do
    local tmpindex = startIndex+i-1
    local node    = self[string.format('_root_anim_breakIcons_%d',i)]
    node:removeAllChildrenWithCleanup(true)
    
    if tmpindex <= curIndex then
      local set = self:createLuaSet('@item')
      set['tp']:setString(tostring(tmpindex))
      node:addChild(set[1])

      --点亮动画
      if tmpindex == curIndex and anim then
        local breakset = self:createLuaSet('@break')
        node:addChild(breakset[1])
        breakset[1]:setLoops(1)
        breakset[1]:reset()
        breakset[1]:start()
        set['fire']:setVisible(false)
        breakset[1]:setListener(function ( ... )
          set['fire']:setVisible(true)
          self:runWithDelay(function ( ... )
            self._root_shield:setVisible(false)
            self:runMoveAction(moveaction,set,set3,function ( ... )
              self:updateStar(false)
            end)

            if moveaction then
              self._root_anim_roadFires_1:setVisible(false)
              self._root_anim_breakIcons_1:removeAllChildrenWithCleanup(true)
              -- self._root_anim_breakIcons_3:removeAllChildrenWithCleanup(true)
            end
          end,0.2)
        end)
        self._root_shield:setVisible(true)
      end

    else
      local tpset = self:createLuaSet('@tp')
      tpset['content']:setString(tostring(tmpindex))
      node:addChild(tpset[1])
      set3 = tpset
    end
  end

  self._root_anim_roadFires_1:setVisible(pos>1)
  self._root_anim_roadFires_2:setVisible(pos>2)
end

function DTitle:runMoveAction( moveaction,set,set3,callback )
  if moveaction then
    local action = self._movetopos1:clone()
    action:setListener(function ( ... )
      return callback and callback()  
    end)
    set[1]:runElfAction(action)

    local action2 = self._movetopos2:clone()
    if set3 then
      set3[1]:runElfAction(action2)
    end
  else
    return callback and callback()
  end
end

function DTitle:getEffectDes( dbtitle,ntitle )
  local v1 = dbtitle.atkrate
  local v2 = dbtitle.hprate
  if ntitle then
    v1 = ntitle.atkrate - dbtitle.atkrate
    v2 = ntitle.hprate  - dbtitle.hprate
  end
  local vstr1 = (v1 > 0 and string.format(Res.locString('DTtitle$AtkEffect'),v1)) or ''
  local vstr2 = (v2 > 0 and string.format(Res.locString('DTtitle$HpEffect'),v2)) or ''
  local strdiv = (v2 > 0 and v1 > 0 and ' ') or ''
  return string.format('%s%s%s',vstr1,strdiv,vstr2) 
end

function DTitle:RaiseTitle( ... )
   self:send(netModel.getModelRoleRaiseTitle(),function ( data )
      if data.D.Role then
         appData.getUserInfo().setData(data.D.Role) 
      end

      self:updateLayer(true)
   end)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DTitle, "DTitle")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DTitle", DTitle)
