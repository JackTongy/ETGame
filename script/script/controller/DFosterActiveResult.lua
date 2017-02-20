local Config = require "Config"
local Res = require 'Res'

local DFosterActiveResult = class(LuaDialog)

function DFosterActiveResult:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DFosterActiveResult.cocos.zip")
    return self._factory:createDocument("DFosterActiveResult.cocos")
end

--@@@@[[[[
function DFosterActiveResult:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_rect = set:getRectangleNode("root_rect")
   self._bgclick = set:getClickNode("bgclick")
   self._light = set:getElfNode("light")
   self._line = set:getElfNode("line")
   self._title = set:getElfNode("title")
   self._bg1 = set:getJoint9Node("bg1")
   self._bg1_atkgrow_oldv = set:getLabelNode("bg1_atkgrow_oldv")
   self._bg1_atkgrow_newv = set:getLabelNode("bg1_atkgrow_newv")
   self._bg1_hpgrow_oldv = set:getLabelNode("bg1_hpgrow_oldv")
   self._bg1_hpgrow_newv = set:getLabelNode("bg1_hpgrow_newv")
   self._bg1_atk_oldv = set:getLabelNode("bg1_atk_oldv")
   self._bg1_atk_newv = set:getLabelNode("bg1_atk_newv")
   self._bg1_hp_oldv = set:getLabelNode("bg1_hp_oldv")
   self._bg1_hp_newv = set:getLabelNode("bg1_hp_newv")
   self._bg1_starLayout = set:getLinearLayoutNode("bg1_starLayout")
   self._bg1_pet = set:getElfNode("bg1_pet")
   self._bg1_pet_pzbg = set:getElfNode("bg1_pet_pzbg")
   self._bg1_pet_frame = set:getElfNode("bg1_pet_frame")
   self._bg1_pet_pz = set:getElfNode("bg1_pet_pz")
   self._bg1_name = set:getLabelNode("bg1_name")
   self._line = set:getElfNode("line")
   self._title = set:getElfNode("title")
   self._bg1 = set:getJoint9Node("bg1")
   self._btnSave = set:getButtonNode("btnSave")
   self._movein = set:getElfAction("movein")
   self._FadeIn = set:getElfAction("FadeIn")
   self._leftIn = set:getElfAction("leftIn")
   self._rightIn = set:getElfAction("rightIn")
   self._scaleout = set:getElfAction("scaleout")
   self._rotate = set:getElfAction("rotate")
--   self._@suc = set:getElfNode("@suc")
--   self._@star = set:getElfNode("@star")
--   self._@fail = set:getElfNode("@fail")
--   self._@motionsuc = set:getSimpleAnimateNode("@motionsuc")
--   self._@motionfail = set:getSimpleAnimateNode("@motionfail")
--   self._@motionsucBZ = set:getSimpleAnimateNode("@motionsucBZ")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DFosterActiveResult:onInit( userData, netData )

	if userData and userData.suc then
		self:startSucMotion()
	else
		self:startFailMotion()
	end
	
end

function DFosterActiveResult:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DFosterActiveResult:startSucMotion( ... )
	self:runWithDelay(function ( ... )
		require 'framework.helper.MusicHelper'.playEffect('raw/ui_sfx_gemupgrade_done.mp3')
	end,1)

	self._root_rect:setVisible(false)
	self._motionsuc = self:createLuaSet('@motionsuc')[1]
	self._motionsuc:setLoops(1)
	-- self._motionsuc:setCurrentIndex(1)
	self._motionsuc:setVisible(true)
	self._motionsuc:setListener(function ( ... )
		local mbz = self:createLuaSet('@motionsucBZ')[1]
		mbz:setLoops(1)
		-- mbz:setCurrentIndex(1)
		mbz:setVisible(true)
		mbz:setListener(function ( ... )
			self._root_rect:setVisible(true)	
			self:motionEnd()
		end)
		self._root:addChild(mbz)
		
		local userData = self:getUserData()
		if userData and userData.callback then
			userData.callback()
		end
	end)
	self._root:addChild(self._motionsuc)

end

function DFosterActiveResult:startFailMotion( ... )
	self._root_rect:setVisible(false)
	self._motionsuc = self:createLuaSet('@motionfail')[1]
	self._motionsuc:setLoops(1)
	-- self._motionsuc:setCurrentIndex(1)
	self._motionsuc:setVisible(true)
	self._motionsuc:setListener(function ( ... )
		self._root_rect:setVisible(true)
		self:motionEnd()
		require 'framework.helper.MusicHelper'.playEffect('raw/ui_sfx_gemupgrade_fail.mp3')	
		local userData = self:getUserData()
		if userData and userData.callback then
			userData.callback()
		end
	end)
	self._root:addChild(self._motionsuc)

end

function DFosterActiveResult:motionEnd( ... )
	local userData = self:getUserData()
	local set = nil
	if userData and userData.suc then
		local oldPet = userData.oldPet
		local newPet = userData.newPet
		
		set = self:createLuaSet('@suc')
		-- set['elf_effect']:setVisible(true)
		-- set['elf_effect']:setLoops(1)
		-- set['elf_effect']:reset()
		-- set['elf_effect']:start()
		set['bg1_atkgrow_oldv']:setString(string.format('%.2f',oldPet.AtkP))
		set['bg1_atkgrow_newv']:setString(string.format('%.2f',newPet.AtkP))
		set['bg1_hpgrow_oldv']:setString(string.format('%.2f',oldPet.HpP))
		set['bg1_hpgrow_newv']:setString(string.format('%.2f',newPet.HpP))

		set['bg1_atk_oldv']:setString(string.format('%d',oldPet.Atk))
		set['bg1_atk_newv']:setString(string.format('%d',newPet.Atk))
		set['bg1_hp_oldv']:setString(string.format('%d',oldPet.Hp))
		set['bg1_hp_newv']:setString(string.format('%d',newPet.Hp))

		set['bg1_name']:setString(Res.getPetNameWithSuffix(newPet))
		set['bg1_name']:setFontFillColor(Res.getRankColorByAwake(newPet.AwakeIndex), true)
		-- local starname = Res.getStarResid(newPet.MotiCnt)
		-- for i=1,newPet.Star do
		-- 	local starset = self:createLuaSet('@star')
		-- 	starset[1]:setResid(starname)
		-- 	set['bg1_starLayout']:addChild(starset[1])
		-- end
		-- set['bg1_pet_pzbg']:setResid(Res.getPetIconBgByAwakeIndex(newPet.AwakeIndex))
		set['bg1_pet_frame']:setResid(Res.getPetIcon(newPet.PetId))
		set['bg1_pet_pz']:setResid(Res.getPetPZ(newPet.AwakeIndex))

		-- set['pet']:setResid(Res.getPetWithPetId(newPet.PetId))
		set['bgclick']:setListener(function ( ... )
			self:close()
		end)
		-- set[1]:setPosition(ccp(0,640))
		-- set[1]:runElfAction(self._movein:clone())
		self:sucAction(set)
	else
		set = self:createLuaSet('@fail')
		set['btnSave']:setListener(function ( ... )
			self:close()
		end)
		-- set[1]:setColorf(1.0,1.0,1.0,0.0)
		-- set[1]:runElfAction(self._FadeIn:clone())
		self:failAction(set)
	end

	self._root:addChild(set[1])	
	
end

function DFosterActiveResult:sucAction( set )
	set[1]:setVisible(true)
	set['line']:setPosition(ccp(-980.0,128.0))
	set['title']:setPosition(ccp(1466.0,128.0))
	set['bg1']:setScale(0)
	set['light']:setScale(0)
	set['line']:runElfAction(self._leftIn:clone())
	set['title']:runElfAction(self._rightIn:clone())
	set['bg1']:runElfAction(self._scaleout:clone())

	local lightaction = self._scaleout:clone()
	lightaction:setListener(function ( ... )
	set['light']:runElfAction(self._rotate:clone()) 
	end)
	set['light']:runElfAction(lightaction)
end

function DFosterActiveResult:failAction( set )
	set[1]:setVisible(true)
	set['line']:setPosition(ccp(-980.0,128.0))
	set['title']:setPosition(ccp(1466.0,128.0))
	set['bg1']:setScale(0)
	set['line']:runElfAction(self._leftIn:clone())
	set['title']:runElfAction(self._rightIn:clone())
	set['bg1']:runElfAction(self._scaleout:clone())
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DFosterActiveResult, "DFosterActiveResult")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DFosterActiveResult", DFosterActiveResult)
