local Config = require "Config"
local Res = require 'Res'
local DVipDetial = class(LuaDialog)
local AppData = require 'AppData'
local viptable = require 'vip'

function DVipDetial:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DVipDetial.cocos.zip")
    return self._factory:createDocument("DVipDetial.cocos")
end

--@@@@[[[[
function DVipDetial:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_btnbg = set:getButtonNode("root_btnbg")
   self._root_bg1 = set:getJoint9Node("root_bg1")
   self._root_bg1_tip = set:getLabelNode("root_bg1_tip")
   self._root_bg1_list = set:getListNode("root_bg1_list")
   self._icon = set:getElfNode("icon")
   self._content = set:getLabelNode("content")
--   self._@vip = set:getElfNode("@vip")
--   self._@des = set:getElfNode("@des")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DVipDetial:onInit( userData, netData )
	Res.doActionDialogShow(self._root_bg1)
  self._root_btnbg:setListener(function ( ... )
    Res.doActionDialogHide(self._root_bg1, self)
  end)

  local ismax = AppData.getUserInfo().isMaxVip()
  local viplvl = AppData.getUserInfo().getVipLevel()
  
  if ismax then
    self._root_bg1_tip:setString(Res.locString('VIP$MAXTIP'))
  else
    local nextvip = viptable[viplvl+2]
    self._root_bg1_tip:setString(string.format(Res.locString('VIP$TIPFORMAT'),nextvip.Charge,viplvl+1))
  end

	self:updateList()
end

function DVipDetial:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DVipDetial:updateList( ... )
  
  local viplvl = AppData.getUserInfo().getVipLevel()
  viplvl = math.max(viplvl,1)
  self._root_bg1_list:getContainer():removeAllChildrenWithCleanup(true)
  self._curIndex = 0

--[[
  local alignToindex = nil
  local delay = 0
  for i,v in ipairs(viptable) do

    if v.vip > 0 then

      if alignToindex == nil then

        if v.vip == viplvl then
          alignToindex = self._curIndex
        end

        self:addVipTitle(tonumber(v.vip))
        self:addVipDesItem(v.Privilege)
      else
        delay = delay + 0.1
        self:runWithDelay(function ( ... )
          self:addVipTitle(tonumber(v.vip))
        end,delay)

        delay = self:addVipDesItem(v.Privilege,delay)

      end

    end  


  end


  self:runWithDelay(function ( ... )
    self._root_bg1_list:alignTo(alignToindex,0.1)  
  end,delay)
]]

  for i,v in ipairs(viptable) do
    if v.vip > 0 and v.vip == viplvl then
      self:addVipTitle(tonumber(v.vip))
      self:addVipDesItem(v.Privilege)
      break
    end
  end

  local delay = 0
  for i,v in ipairs(viptable) do
    if v.vip > 0 and v.vip ~= viplvl then
        delay = delay + 0.1
        self:runWithDelay(function ( ... )
          self:addVipTitle(tonumber(v.vip))
        end,delay)

        delay = self:addVipDesItem(v.Privilege,delay)
    end
  end
  
  self._root_bg1_list:layout()

end

function DVipDetial:addVipTitle( viplvl )
  local luaset = self:createLuaSet('@vip')
  luaset['icon']:setResid(string.format('vip0_vip%d.png',viplvl))
  self._root_bg1_list:getContainer():addChild(luaset[1])
  self._curIndex = self._curIndex + 1
end

function DVipDetial:addVipDesItem( text ,delay)

  local items = Res.Split(text,'|')
  for i,v in ipairs(items) do
    if delay == nil then
      local luaset = self:createLuaSet('@des')
      luaset['content']:setString(v)
      self._root_bg1_list:getContainer():addChild(luaset[1])  
      self._curIndex = self._curIndex + 1
    else
      delay = delay + 0.1
      self:runWithDelay(function ( ... )
        local luaset = self:createLuaSet('@des')
        luaset['content']:setString(v)
        self._root_bg1_list:getContainer():addChild(luaset[1])  
        self._curIndex = self._curIndex + 1      
      end,delay)
    end
  end

  return delay

end


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DVipDetial, "DVipDetial")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DVipDetial", DVipDetial)
