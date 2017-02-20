local Config = require "Config"
local DBManager = require "DBManager"
local Res = require 'Res'
local AppData = require 'AppData'

local DEvolveInfo = class(LuaDialog)

function DEvolveInfo:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DEvolveInfo.cocos.zip")
    return self._factory:createDocument("DEvolveInfo.cocos")
end

--@@@@[[[[
function DEvolveInfo:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getJoint9Node("bg")
    self._bg_title = set:getLabelNode("bg_title")
    self._bg_list = set:getListNode("bg_list")
    self._condition = set:getLabelNode("condition")
    self._origin = set:getColorClickNode("origin")
    self._origin_normal_elf_frame = set:getElfNode("origin_normal_elf_frame")
    self._origin_normal_elf_icon = set:getElfNode("origin_normal_elf_icon")
    self._origin_normal_elf_property = set:getElfNode("origin_normal_elf_property")
    self._origin_normal_elf_career = set:getElfNode("origin_normal_elf_career")
    self._origin_normal_name = set:getLabelNode("origin_normal_name")
    self._result = set:getColorClickNode("result")
    self._result_normal_elf_frame = set:getElfNode("result_normal_elf_frame")
    self._result_normal_elf_icon = set:getElfNode("result_normal_elf_icon")
    self._result_normal_elf_property = set:getElfNode("result_normal_elf_property")
    self._result_normal_elf_career = set:getElfNode("result_normal_elf_career")
    self._result_normal_name = set:getLabelNode("result_normal_name")
--    self._@cell = set:getElfNode("@cell")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DEvolveInfo:onInit( userData, netData )
	Res.doActionDialogShow(self._bg)
    self._clickBg:setListener(function (  )
        Res.doActionDialogHide(self._bg, self)
    end)
    self:updateDialog(userData)
end

function DEvolveInfo:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function DEvolveInfo:updateDialog(NPet)
	local charactor = DBManager.getCharactor(NPet.PetId)
    if charactor.ev_pet and #charactor.ev_pet > 1 then
    	for k, v in pairs(charactor.ev_pet) do
    		self:createCell(NPet, DBManager.getCharactor(v))
    	end
    end
    if charactor.ev_pet_mega and #charactor.ev_pet_mega > 1 then
        for k,v in pairs(charactor.ev_pet_mega) do
           self:createCell(NPet, DBManager.getCharactor(v)) 
        end
    end

	self._bg_list:layout()
end

function DEvolveInfo:createCell(NPet, DBPet)
	local set = self:createLuaSet('@cell')
	self:refreshPet(set, 'origin', NPet, DBManager.getCharactor(NPet.PetId))
	self:refreshPet(set, 'result', AppData.getPetInfo().getPetInfoByPetId(DBPet.id, NPet.AwakeIndex), DBPet)

	if DBPet.ev_condition_des then
		set['condition']:setString(DBPet.ev_condition_des)
	end

	self._bg_list:getContainer():addChild(set[1])
end

function DEvolveInfo:refreshPet(set, headStr, NPet, DBPet)
    set[headStr]:setMaxMove(10)
	set[headStr]:setListener(function()
		GleeCore:showLayer("DPetDetailV", {nPet = NPet})
	end)
	set[string.format('%s_normal_elf_frame', headStr)]:setResid(Res.getPetIconFrame(NPet))
	set[string.format('%s_normal_elf_icon', headStr)]:setResid(Res.getPetIcon(DBPet.id))
    set[string.format('%s_normal_name', headStr)]:setString(DBPet.name)
    set[string.format('%s_normal_elf_career', headStr)]:setResid(Res.getPetCareerIcon(DBPet.atk_method_system, true))
    set[string.format('%s_normal_elf_property', headStr)]:setResid(Res.getPetPropertyIcon(DBPet.prop_1, true))

end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DEvolveInfo, "DEvolveInfo")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DEvolveInfo", DEvolveInfo)


