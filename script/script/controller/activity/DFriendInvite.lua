local Config = require "Config"
local netModel = require 'netModel'
local Res = require 'Res'
local friendsFunc = require 'AppData'.getFriendsInfo()
local eventCenter = require 'EventCenter'
local dbManager = require 'DBManager'

local DFriendInvite = class(LuaDialog)

function DFriendInvite:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DFriendInvite.cocos.zip")
    return self._factory:createDocument("DFriendInvite.cocos")
end

--@@@@[[[[
function DFriendInvite:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_btnbg = set:getButtonNode("root_btnbg")
   self._root_bg0 = set:getElfNode("root_bg0")
   self._root_bg0_bg1 = set:getJoint9Node("root_bg0_bg1")
   self._root_bg0_bg1_tip = set:getLabelNode("root_bg0_bg1_tip")
   self._root_bg0_bg1_list = set:getListNode("root_bg0_bg1_list")
   self._bg = set:getElfNode("bg")
   self._icon = set:getElfNode("icon")
   self._frame = set:getElfNode("frame")
   self._starLayout = set:getLayoutNode("starLayout")
   self._layout1 = set:getLinearLayoutNode("layout1")
   self._layout1_name = set:getLabelNode("layout1_name")
   self._layout1_lv = set:getLabelNode("layout1_lv")
   self._layoutBattleValue = set:getLinearLayoutNode("layoutBattleValue")
   self._layoutBattleValue_value = set:getLabelNode("layoutBattleValue_value")
   self._layoutStatus = set:getLinearLayoutNode("layoutStatus")
   self._layoutStatus_value = set:getLabelNode("layoutStatus_value")
   self._btnInvite = set:getClickNode("btnInvite")
   self._root_title = set:getElfNode("root_title")
   self._root_title_content = set:getLabelNode("root_title_content")
   self._root_close = set:getButtonNode("root_close")
--   self._@item1 = set:getElfNode("@item1")
--   self._@pet = set:getElfNode("@pet")
--   self._@star = set:getElfNode("@star")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DFriendInvite:onInit( userData, netData )
	Res.doActionDialogShow(self._root)

  self._root_btnbg:setListener(function ( ... )
    if self._inviteFriend then
      eventCenter.eventInput('BossBattleRefresh')
    end
    Res.doActionDialogHide(self._root, self)
  end)
  self._root_close:setListener(function ( ... )
    self._root_btnbg:trigger(nil)
  end)

  self._invitedFs = userData.Fs
  local friends = friendsFunc.getFriendList()
  if friends == nil or #friends == 0 then
  	self:send(netModel.getModelFriendGetFriend(), function ( data )
      if data and data.D then
        friendsFunc.setFriendList(data.D.Friends)
        self:updateLayer()
      end
    end)
  else
    self:updateLayer(true)
  end

end

function DFriendInvite:onBack( userData, netData )
	
end

function DFriendInvite:close( ... )
  self._setmaps = nil
end

--------------------------------custom code-----------------------------

function DFriendInvite:updateLayer( ... )
  
  self:updateList(...)

end

function DFriendInvite:updateList( flag )
  
  friendsFunc.sortWithMyFriends()
  local friends = friendsFunc.getFriendList()
  if friends then
    self._root_bg0_bg1_list:getContainer():removeAllChildrenWithCleanup(true)
    for i,v in ipairs(friends) do
      if i < 4 then
        local itemSet = self:createLuaSet('@item1')
        self:refreshCell(itemSet,v)
        self._root_bg0_bg1_list:getContainer():addChild(itemSet[1])
      else
        self:runWithDelay(function ( ... )
          local itemSet = self:createLuaSet('@item1')
          self:refreshCell(itemSet,v)
          self._root_bg0_bg1_list:getContainer():addChild(itemSet[1])
        end,0.1)
      end
    end
  end

  self._root_bg0_bg1_list:layout()

  self._root_bg0_bg1_tip:setVisible((not friends or #friends == 0) and not flag)
end

function DFriendInvite:refreshCell( set,friend,petset)
  
  local petLuaSet = petset or self:createLuaSet('@pet')
  if not petset then
    petLuaSet['icon']:setResid(Res.getPetIcon(friend.PetId))
    petLuaSet['frame']:setResid(Res.getPetPZ(friend.AwakeIndex))
    local dbPet = dbManager.getCharactor(friend.PetId)
    require 'PetNodeHelper'.updateStarLayout(petLuaSet['starLayout'],dbPet)
    set[1]:addChild(petLuaSet[1])  
    set['petset']=petLuaSet
  end

  set['layout1_name']:setString(friend.Name)
  set['layout1_lv']:setString(string.format("Lv.%d", friend.Lv))
  set['layoutBattleValue_value']:setString(tostring(friend.CombatPower))
  if friend.IsOnline then
    set['layoutStatus_value']:setString(Res.locString("Friend$Online"))  
  else
    set['layoutStatus_value']:setString(Res.locString("Friend$Offline")) 
  end

  if self:alreadyInFs(friend.Fid) then
    set['btnInvite']:setEnabled(false)
  else
    set['btnInvite']:setEnabled(true)
    set['btnInvite']:setListener(function ( ... )
      self:clickInvite(friend)  
    end)    
  end
  
  self:setFriendSet(set,friend)
end

--helper
function DFriendInvite:alreadyInFs( fid )

  if self._invitedFs then
    for k,v in pairs(self._invitedFs) do
      if v == fid then
        return true
      end
    end
  end  

  return false

end

function DFriendInvite:setFriendSet( set,friend )
  self._setmaps = self._setmaps or {}
  self._setmaps[friend.Fid] = set
end

function DFriendInvite:updateFriendSet( friend )
  local set = self._setmaps[friend.Fid]
  self:refreshCell(set,friend,set['petset'])
end

--net
function DFriendInvite:clickInvite( friend )
  
  local userData = self:getUserData()
  self:send(netModel.getModelBossInvite(userData.Bid,friend.Fid),function ( data )
    table.insert(self._invitedFs,friend.Fid)
    self._inviteFriend = true
    -- self:updateLayer()
    self:updateFriendSet(friend)
  end)

end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DFriendInvite, "DFriendInvite")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DFriendInvite", DFriendInvite)
