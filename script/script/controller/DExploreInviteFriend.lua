local Config = require "Config"
local LuaList = require "LuaList"
local res = require "Res"
local dbManager = require "DBManager"
local gameFunc = require "AppData"
local netModel = require "netModel"
local friendsFunc = gameFunc.getFriendsInfo()
local exploreFunc = gameFunc.getExploreInfo()

local DExploreInviteFriend = class(LuaDialog)

function DExploreInviteFriend:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DExploreInviteFriend.cocos.zip")
    return self._factory:createDocument("DExploreInviteFriend.cocos")
end

--@@@@[[[[
function DExploreInviteFriend:onInitXML()
	local set = self._set
    self._root = set:getElfNode("root")
    self._root_bg = set:getElfNode("root_bg")
    self._root_ftpos_layoutList = set:getLinearLayoutNode("root_ftpos_layoutList")
    self._root_ftpos_layoutList_list = set:getListNode("root_ftpos_layoutList_list")
    self._icon = set:getElfNode("icon")
    self._starLayout = set:getLayoutNode("starLayout")
    self._nameBg_name = set:getLabelNode("nameBg_name")
    self._layoutBelong = set:getLinearLayoutNode("layoutBelong")
    self._layoutBelong_value = set:getLabelNode("layoutBelong_value")
    self._layoutLv = set:getLinearLayoutNode("layoutLv")
    self._layoutLv_value = set:getLabelNode("layoutLv_value")
    self._layoutQuality = set:getLinearLayoutNode("layoutQuality")
    self._layoutQuality_value = set:getLabelNode("layoutQuality_value")
    self._layoutPower = set:getLinearLayoutNode("layoutPower")
    self._layoutPower_value = set:getLabelNode("layoutPower_value")
    self._btnChose = set:getClickNode("btnChose")
    self._btnChose_text = set:getLabelNode("btnChose_text")
    self._root_ftpos2_close = set:getButtonNode("root_ftpos2_close")
--    self._@sizePet = set:getElfNode("@sizePet")
--    self._@star = set:getElfNode("@star")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DExploreInviteFriend:onInit( userData, netData )
	self.callback = userData.callback
	self:setListenerEvent()
	self:updateLayer()
	res.doActionDialogShow(self._root)
end

function DExploreInviteFriend:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DExploreInviteFriend:setListenerEvent(  )
	self._root_ftpos2_close:setListener(function ( ... )
		self._root_ftpos_layoutList_list:stopAllActions()
		res.doActionDialogHide(self._root, self)
	end)
end

function DExploreInviteFriend:updateLayer(  )
	local winSize = CCDirector:sharedDirector():getWinSize()
	self._root_bg:setScaleX(winSize.width / self._root_bg:getWidth())
	self._root_ftpos_layoutList_list:setContentSize(CCSize(winSize.width, self._root_ftpos_layoutList_list:getHeight()))
	self:updateList()
end

function DExploreInviteFriend:updateList(  )
	if not self.friendList then
		self.friendList = LuaList.new(self._root_ftpos_layoutList_list, function ( ... )
			return self:createLuaSet("@sizePet")
		end, function ( nodeLuaSet, data, listIndex )
			local nPet = data.Pet
			local dbPet = dbManager.getCharactor(nPet.PetId)
			if dbPet then
				res.setNodeWithPet(nodeLuaSet["icon"], nPet)
				require 'PetNodeHelper'.updateStarLayout(nodeLuaSet["starLayout"], dbPet)
				nodeLuaSet["nameBg_name"]:setString(dbPet.name)
				nodeLuaSet["layoutBelong_value"]:setString(data.Name)
				nodeLuaSet["layoutLv_value"]:setString(nPet.Lv)
				nodeLuaSet["layoutQuality_value"]:setString(dbPet.quality)
				nodeLuaSet["layoutPower_value"]:setString(nPet.Power)
				nodeLuaSet["btnChose_text"]:setString(data.isInExploreTeam and res.locString("Pet$TeamOffload") or res.locString("Global$BtnSelect"))
				nodeLuaSet["btnChose"]:setListener(function ( ... )
					if self.callback then
						self.callback(nPet.Id)
					end
					res.doActionDialogHide(self._root, self)
				end)
			end
		end)
	end
	self.friendList:update(self:getFriendListData())
end

function DExploreInviteFriend:getFriendListData( ... )
	local rob = exploreFunc.getExploreRob()
	local list = table.clone(friendsFunc.getFriendList())
	local function isInTeam( nPetId )
		for _,v in pairs(rob.FPets) do
			if v.Id == nPetId then
				return true
			end
		end
		return false
	end
	for i,v in ipairs(list) do
		list[i].isInExploreTeam = isInTeam(v.Pet.Id)
	end
	table.sort(list, function ( v1, v2 )
		if v1.isInExploreTeam == v2.isInExploreTeam then
			if v1.Pet.Power == v2.Pet.Power then
				return v1.Id < v2.Id
			else
				return v1.Pet.Power > v2.Pet.Power
			end
		else
			return v1.isInExploreTeam
		end
	end)
	return list
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DExploreInviteFriend, "DExploreInviteFriend")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DExploreInviteFriend", DExploreInviteFriend)


