local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local netModel = require "netModel"
local gameFunc = require "AppData"

local DEvolvePre = class(LuaDialog)

function DEvolvePre:createDocument()
		self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DEvolvePre.cocos.zip")
		return self._factory:createDocument("DEvolvePre.cocos")
end

--@@@@[[[[
function DEvolvePre:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_icon = set:getElfNode("bg_icon")
    self._bg_img = set:getElfNode("bg_img")
    self._bg_layoutName_name = set:getLabelNode("bg_layoutName_name")
    self._bg_layoutName_lv = set:getLabelNode("bg_layoutName_lv")
    self._bg_layoutName_quality = set:getLabelNode("bg_layoutName_quality")
    self._bg_layoutStar = set:getLayoutNode("bg_layoutStar")
    self._bg_career = set:getElfNode("bg_career")
    self._bg_property = set:getElfNode("bg_property")
    self._bg_layoutPower_pre = set:getLabelNode("bg_layoutPower_pre")
    self._bg_layoutPower_add = set:getLabelNode("bg_layoutPower_add")
    self._bg_layoutAtk_pre = set:getLabelNode("bg_layoutAtk_pre")
    self._bg_layoutAtk_add = set:getLabelNode("bg_layoutAtk_add")
    self._bg_layoutHp_pre = set:getLabelNode("bg_layoutHp_pre")
    self._bg_layoutHp_add = set:getLabelNode("bg_layoutHp_add")
    self._bg_layoutDef_pre = set:getLabelNode("bg_layoutDef_pre")
    self._bg_layoutDef_add = set:getLabelNode("bg_layoutDef_add")
    self._bg_layoutCri_pre = set:getLabelNode("bg_layoutCri_pre")
    self._bg_layoutCri_add = set:getLabelNode("bg_layoutCri_add")
    self._bg_layoutSkill = set:getLayoutNode("bg_layoutSkill")
    self._img = set:getElfNode("img")
    self._des = set:getLabelNode("des")
    self._suo = set:getElfNode("suo")
    self._btn = set:getButtonNode("btn")
    self._bg_btnSwitch = set:getButtonNode("bg_btnSwitch")
    self._bg_btnGo = set:getClickNode("bg_btnGo")
    self._actionOut = set:getElfAction("actionOut")
    self._actionIn = set:getElfAction("actionIn")
--    self._@star = set:getElfNode("@star")
--    self._@skill = set:getElfNode("@skill")
end
--@@@@]]]]


--------------------------------override functions----------------------

local Launcher = require 'Launcher'
Launcher.register("DEvolvePre", function ( userData )
   	Launcher.callNet(netModel.getModelPetEvToList(userData.nPetId),function ( data )
     		Launcher.Launching(data)   
   	end)
end)

function DEvolvePre:onInit( userData, netData )
	if netData and netData.D then
		self.list = netData.D.Pets or {}
	end
	self.nPetId = userData.nPetId
	res.doActionDialogShow(self._bg)
	self:setListenerEvent()
	self:updateLayer()
end

function DEvolvePre:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DEvolvePre:setListenerEvent( ... )
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_btnSwitch:setListener(function ( ... )
		self:doActionSwitch()
	end)

	self._bg_btnGo:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
		GleeCore:showLayer("DPetFoster", {pet = gameFunc.getPetInfo().getPetWithId(self.nPetId), tab='TLPetEvolve'})
	end)
end

function DEvolvePre:getPetEvolved( ... )
	local nPetEvolved
	if #self.list == 1 then
		nPetEvolved = self.list[1]
	elseif #self.list > 1 then
		self.petIndex = self.petIndex or 1
		nPetEvolved = self.list[self.petIndex]
	end
	return nPetEvolved
end

function DEvolvePre:updateLayer(  )
	local nPet = self:getPetEvolved()
	local dbPet = dbManager.getCharactor(nPet.PetId)
	local prePet = gameFunc.getPetInfo().getPetWithId(self.nPetId)

	local iconView = require 'ActionView'.createActionViewById(dbPet.id)
	if iconView then
		local monsterNode = iconView:getRootNode()
		monsterNode:setVisible(true)
		monsterNode:setScale(0.5)
		monsterNode:setPosition(ccp(0, -30))
		monsterNode:setTransitionMills(0)
		monsterNode:setBatchDraw(true)
		iconView:play("待机",-1)
		self._bg_icon:removeAllChildrenWithCleanup(true)
		self._bg_icon:addChild(monsterNode)
	end

	self._bg_layoutName_name:setString(dbPet.name)
	self._bg_layoutName_lv:setString("  lv." .. nPet.Lv)
	self._bg_layoutName_quality:setString(dbPet.quality)
	-- self._bg_layoutStar:removeAllChildrenWithCleanup(true)
	-- for i=1,dbPet.star_level do
	-- 	local star = self:createLuaSet("@star")
	-- 	self._bg_layoutStar:addChild(star[1])
	-- end
	require 'PetNodeHelper'.updateStarLayout(self._bg_layoutStar, dbPet, nil, true)
	self._bg_career:setResid(res.getPetCareerIcon(dbPet.atk_method_system))
	self._bg_property:setResid(res.getPetPropertyIcon(dbPet.prop_1, true))
	self._bg_layoutPower_pre:setString(prePet.Power)
	self._bg_layoutAtk_pre:setString(prePet.Atk)
	self._bg_layoutHp_pre:setString(prePet.Hp)
	self._bg_layoutDef_pre:setString(prePet.Def)
	self._bg_layoutCri_pre:setString(prePet.Crit)
	local function getDisString( now, pre )
		if now == pre then
			return ""
		elseif now > pre then
			return "+" .. (now - pre)
		else
			return "-" .. (pre - now)
		end
	end

	self._bg_layoutPower_add:setString( getDisString(nPet.Power, prePet.Power) )
	self._bg_layoutAtk_add:setString( getDisString(nPet.Atk, prePet.Atk) )
	self._bg_layoutHp_add:setString( getDisString(nPet.Hp, prePet.Hp) )
	self._bg_layoutDef_add:setString( getDisString(nPet.Def, prePet.Def) )
	self._bg_layoutCri_add:setString( getDisString(nPet.Crit, prePet.Crit) )

	-- 技能
	self._bg_layoutSkill:removeAllChildrenWithCleanup(true)
	local skill = self:createLuaSet("@skill")
	require 'LangAdapter'.fontSize(skill["des"],nil,nil,nil,nil,nil,nil,nil,16)
	self._bg_layoutSkill:addChild(skill[1])
	require 'LangAdapter'.labelDimensions(skill["des"],CCSizeMake(0,0),nil,nil,nil,CCSizeMake(0,0))
	skill["img"]:setResid("JLXQ_jineng1.png")
	local skillitem = dbManager.getInfoSkill(dbPet.skill_id)
	local skillName = skillitem.name

	res.petSkillFormatScale(skill["des"])
	skill["des"]:setString( res.petSkillFormat(skillName) )  
	skill["des"]:setFontFillColor(ccc4f(0.36,0.15,0,1),true)
	res.LabelNodeAutoShrinkIfArabic(skill["des"], 56)
	skill["btn"]:setListener(function ( ... )
		local nodePos = NodeHelper:getPositionInScreen(skill["btn"])
		GleeCore:showLayer('DSkillInfo',{skillitem=skillitem,cost=true,point=nodePos,offset=50})
	end)

	for i=1,#dbPet.abilityarray do
		if dbPet.abilityarray[i] > 0 then
			 local skill = self:createLuaSet("@skill")
			 require 'LangAdapter'.fontSize(skill["des"],nil,nil,nil,nil,nil,nil,nil,16)
			 self._bg_layoutSkill:addChild(skill[1])
			 require 'LangAdapter'.labelDimensions(skill["des"],CCSizeMake(0,0),nil,nil,nil,CCSizeMake(0,0))
			 skill["img"]:setResid("JLXQ_jineng2.png")
			 local skillitem = dbManager.getInfoSkill(dbPet.abilityarray[i])
			 local skillName = skillitem.name
			 res.petSkillFormatScale(skill["des"])
			 skill["des"]:setString( res.petSkillFormat(skillName) )
			 skill["des"]:setFontFillColor(ccc4f(0.11,0.27,0,1),true)
			 res.LabelNodeAutoShrinkIfArabic(skill["des"], 56)
			 skill["btn"]:setListener(function ( ... )
				local nodePos = NodeHelper:getPositionInScreen(skill["btn"])
				GleeCore:showLayer('DSkillInfo',{skillitem=skillitem,cost=false,point=nodePos,offset=50})
			 end)
		end   
	end
	 self._bg_layoutSkill:layout()

	res.adjustPetIconPositionInParentLT(self._bg, self._bg_img, dbPet.id, 'troop', 200, -30)

	self._bg_btnSwitch:setVisible(self.list and #self.list > 1)
end

function DEvolvePre:doActionSwitch( ... )
	self:updatePetActionNode()
	self._bg_img:stopAllActions()
	if self.petIndex then
		self.petIndex = math.fmod(self.petIndex, #self.list) + 1
	else
		self.petIndex = 1
	end
	
	local outAction = self._actionOut:clone()
	outAction:setListener(function ( ... )
		self:updatePetActionNode()
		local x, y = self._bg_img:getPosition()
		self._bg_img:setPosition(ccp(x + 400, y))

		local inAction = self._actionIn:clone()
		inAction:setListener(function ( ... )
			self:updateLayer()
		end)
		self._bg_img:runAction(inAction)
	end)
	self._bg_img:runAction(outAction)
end

function DEvolvePre:updatePetActionNode( ... )
	local nPet = self:getPetEvolved()
	local dbPet = dbManager.getCharactor(nPet.PetId)
	res.adjustPetIconPositionInParentLT(self._bg, self._bg_img, dbPet.id, 'troop', 200, -30)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DEvolvePre, "DEvolvePre")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DEvolvePre", DEvolvePre)


