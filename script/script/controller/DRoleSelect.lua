local Config = require "Config"
local AppData = require 'AppData'
local netModel = require 'netModel'
local GuideHelper = require 'GuideHelper'

local DRoleSelect = class(LuaDialog)

function DRoleSelect:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DRoleSelect.cocos.zip")
    return self._factory:createDocument("DRoleSelect.cocos")
end

--@@@@[[[[
function DRoleSelect:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_linearlayout_pet3 = set:getClickNode("root_linearlayout_pet3")
   self._root_linearlayout_pet6 = set:getClickNode("root_linearlayout_pet6")
   self._root_linearlayout_pet9 = set:getClickNode("root_linearlayout_pet9")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DRoleSelect:onInit( userData, netData )
	self._root_linearlayout_pet3:setListener(function ( ... )
		self:selectPet(3)	
	end)
	self._root_linearlayout_pet6:setListener(function ( ... )
		self:selectPet(6)	
	end)
	self._root_linearlayout_pet9:setListener(function ( ... )
		self:selectPet(9)	
	end)
end

function DRoleSelect:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DRoleSelect:selectPet( PetId )
	self:send(netModel.getRoleChooseHero(PetId),function ( data )
		if data.D then
			local userinfo = AppData.getUserInfo()
			userinfo.setData(data.D.Role)

			local teaminfo = AppData.getTeamInfo()
			teaminfo.setTeamList(data.D.Teams)

			local petinfo = AppData.getPetInfo()
			petinfo.setPet(data.D.Pet)
			
			self:close()
			GuideHelper:check('selectRole')
		end
	end)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DRoleSelect, "DRoleSelect")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DRoleSelect", DRoleSelect)
