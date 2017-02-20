local Config = require "Config"
local dbManager = require "DBManager"
local res = require "Res"

local DPetInfo = class(LuaDialog)

function DPetInfo:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPetInfo.cocos.zip")
    return self._factory:createDocument("DPetInfo.cocos")
end

--@@@@[[[[
function DPetInfo:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getShieldNode("bg")
    self._bg_detailBg_petImg = set:getElfNode("bg_detailBg_petImg")
    self._bg_detailBg_list = set:getListNode("bg_detailBg_list")
    self._bg = set:getElfNode("bg")
    self._bg_nameLayout = set:getLinearLayoutNode("bg_nameLayout")
    self._bg_nameLayout_name = set:getLabelNode("bg_nameLayout_name")
    self._bg_nameLayout_lv = set:getLabelNode("bg_nameLayout_lv")
    self._bg_zizhi = set:getLabelNode("bg_zizhi")
    self._bg_layout = set:getLinearLayoutNode("bg_layout")
    self._bg_layout_starLayout = set:getLayoutNode("bg_layout_starLayout")
    self._bg_layout_job = set:getElfNode("bg_layout_job")
    self._bg_layout_pro = set:getElfNode("bg_layout_pro")
    self._bg_p1Value = set:getLabelNode("bg_p1Value")
    self._bg_p2Value = set:getLabelNode("bg_p2Value")
    self._bg_p3Value = set:getLabelNode("bg_p3Value")
    self._bg_p4Value = set:getLabelNode("bg_p4Value")
    self._bg_skillLayout = set:getLinearLayoutNode("bg_skillLayout")
    self._img = set:getElfNode("img")
    self._des = set:getLabelNode("des")
    self._suo = set:getElfNode("suo")
    self._btn = set:getButtonNode("btn")
    self._bg3 = set:getJoint9Node("bg3")
    self._get = set:getLabelNode("get")
    self._bg_img = set:getElfNode("bg_img")
    self._bg_lock = set:getElfNode("bg_lock")
    self._bg_name = set:getLabelNode("bg_name")
    self._bg_tip = set:getLabelNode("bg_tip")
    self._bg_btn = set:getButtonNode("bg_btn")
    self._bg_des = set:getLabelNode("bg_des")
    self._getInfo = set:getLabelNode("getInfo")
    self._gotoBtn = set:getClickNode("gotoBtn")
    self._gotoBtn_label = set:getLabelNode("gotoBtn_label")
--    self._@base = set:getElfNode("@base")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
--    self._@skill = set:getElfNode("@skill")
--    self._@loot = set:getElfNode("@loot")
--    self._@lootlayout = set:getLinearLayoutNode("@lootlayout")
--    self._@raid = set:getElfNode("@raid")
--    self._@lootForShop = set:getElfNode("@lootForShop")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DPetInfo:onInit( userData, netData )
	res.doActionDialogShow(self._bg)

	self.fromShop = userData.FromShop
	self.callback = userData.Callback
	self.btnText = userData.BtnText
	self.fromTownID = userData.FromTownID or 0

	self.petInfo = userData.PetInfo
	self.dbInfo = dbManager.getCharactor(self.petInfo.PetId)
	self:updateView()
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)
end

function DPetInfo:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function  DPetInfo:updateView( ... )
	if res.getPetPositionConfig(self.petInfo.PetId,'chat') then
		self._bg_detailBg_petImg:setPosition(-560,320)
		self._bg_detailBg_petImg:setAnchorPoint(ccp(0.5,0.5))
	end
	res.adjustPetIconPosition( self._bg_detailBg_petImg,self.petInfo.PetId,'chat')

	self._bg_detailBg_list:addListItem(self:createBaseInfo())

	self._bg_detailBg_list:addListItem(self:createLootInfo())
end

function DPetInfo:createLootInfo( ... )
	local set = self:createLuaSet("@loot")
	if self.fromShop then
		local set1 = self:createLuaSet("@lootForShop")
		set1["getInfo"]:setString(self.dbInfo.CaptureInfo)
		set1["gotoBtn_label"]:setString(self.btnText)
		if self.callback then
			set1["gotoBtn"]:setListener(function ( ... )
				self:close()
				self.callback()
			end)
		else
			set1["gotoBtn"]:setEnabled(false)
		end

		set1[1]:setVisible(true)
		set[1]:addChild(set1[1])
	else
		local set1 = self:createLuaSet("@lootlayout")

		local townType,townIds = 1,{}
		if tonumber(self.dbInfo.capture_city) == nil then
			local k1,k2 = unpack(string.split(self.dbInfo.capture_city,"|"))
			townType = tonumber(k1)
			for v in string.gmatch(k2,"%d+") do
				townIds[#townIds+1] = tonumber(v)
			end
		end

		local lockTownIds = {}
		for _,v in ipairs(townIds) do
			if require "TownInfo".isTownOpen(v,townType == 2) then
				set1[1]:addChild(self:createTownItem(v,townType))
			else
				lockTownIds[#lockTownIds+1] = v
			end
		end

		if self.fromTownID >0 then
			set["get"]:setString(res.locString("PetInfo$AppearTip"))
		else
			if self.dbInfo.getmode then
				local desList = string.split(self.dbInfo.getmode,"|")
			   	for _,v in ipairs(desList) do
			   		local t,des = unpack(string.split(v,","))
			   		t = tonumber(t)
			   		set1[1]:addChild(self:createOtherItem(t,des))
			   	end
			end
		end

		for _,v in ipairs(lockTownIds) do
			set1[1]:addChild(self:createTownItem(v,townType))
		end

		set1[1]:layout()

		local h = set1[1]:getContentSize().height
		local H = h+40
		local w = set["bg3"]:getContentSize().width
		set["bg3"]:setContentSize(CCSizeMake(w,H))
		set[1]:setContentSize(CCSizeMake(w,H))
		local x = set["get"]:getPosition()
		set["get"]:setPosition(x,H/2-20)

		set1[1]:setPosition(0,H/2-33)

		set[1]:addChild(set1[1])
	end

	return set[1]
end

function DPetInfo:createBaseInfo(  )
	local set = self:createLuaSet("@base")
	set["bg_nameLayout_name"]:setString(self.dbInfo.name)
	set["bg_nameLayout_lv"]:setString(string.format(" lv%d",self.petInfo.Lv))
	set["bg_nameLayout_name"]:setFontFillColor(res.rankColor4F[res.getFinalAwake(self.petInfo.AwakeIndex)],true)
	set["bg_nameLayout_lv"]:setFontFillColor(res.rankColor4F[res.getFinalAwake(self.petInfo.AwakeIndex)],true)
	set["bg_zizhi"]:setString(self.dbInfo.quality)
	local starSize
	for j=1,self.petInfo.Star do
		local star = self:createLuaSet("@star")[1]
		star:setResid(res.getStarResid(0))
		starSize = starSize or star:getContentSize()
		set["bg_layout_starLayout"]:addChild(star)
	end
	set["bg_layout_starLayout"]:layout()
	local space = set["bg_layout_starLayout"]:getSpace()
	set["bg_layout_starLayout"]:setContentSize(CCSize(starSize.width*self.petInfo.Star-(starSize.width-space)*(self.petInfo.Star-1),starSize.height))
	set["bg_layout_job"]:setResid(res.getPetCareerIcon(self.dbInfo.atk_method_system,true))
	set["bg_layout_pro"]:setResid(res.getPetPropertyIcon(self.dbInfo.prop_1,true))
	set["bg_layout"]:layout()

	set["bg_p1Value"]:setString(self.petInfo.Atk)
	set["bg_p2Value"]:setString(self.petInfo.Def)
	set["bg_p3Value"]:setString(self.petInfo.Crit)
	set["bg_p4Value"]:setString(self.petInfo.Hp)

	local skill = self:createLuaSet("@skill")
	set["bg_skillLayout"]:addChild(skill[1])
	skill["img"]:setResid("JLXQ_jineng1.png")
	require 'LangAdapter'.labelDimensions(skill["des"],CCSizeMake(0,0),nil,nil,nil,CCSizeMake(0,0))
	local skillitem = dbManager.getInfoSkill(self.dbInfo.skill_id)
	local skillName = skillitem.name
	
	res.petSkillFormatScale(skill["des"])
	skill["des"]:setString(res.petSkillFormat(skillName))	
	res.LabelNodeAutoShrinkIfArabic(skill["des"], 56)
	skill["des"]:setFontFillColor(ccc4f(0.36,0.15,0,1),true)
	skill["btn"]:setListener(function ( ... )
		local nodePos = NodeHelper:getPositionInScreen(skill["btn"])
		GleeCore:showLayer('DSkillInfo',{skillitem=skillitem,cost=true,point=nodePos,offset=50})
	end)

	local unlockcount = res.getAbilityUnlockCount(self.petInfo.AwakeIndex,self.petInfo.Star)
	for i=1,#self.dbInfo.abilityarray do
		if self.dbInfo.abilityarray[i] == 0 then
			--无技能
		elseif unlockcount >= i then --已解锁
			local skill = self:createLuaSet("@skill")
			set["bg_skillLayout"]:addChild(skill[1])
			require 'LangAdapter'.labelDimensions(skill["des"],CCSizeMake(0,0),nil,nil,nil,CCSizeMake(0,0))
			skill["img"]:setResid("JLXQ_jineng2.png")
			local skillitem = dbManager.getInfoSkill(self.dbInfo.abilityarray[i])
			local skillName = skillitem.name
			res.petSkillFormatScale(skill["des"])
			skill["des"]:setString(res.petSkillFormat(skillName))
			res.LabelNodeAutoShrinkIfArabic(skill["des"], 56)
			skill["des"]:setFontFillColor(ccc4f(0.11,0.27,0,1),true)
			skill["btn"]:setListener(function ( ... )
				local nodePos = NodeHelper:getPositionInScreen(skill["btn"])
				GleeCore:showLayer('DSkillInfo',{skillitem=skillitem,cost=false,point=nodePos,offset=50})
			end)
		else --没有解锁
			local skill = self:createLuaSet("@skill")
			set["bg_skillLayout"]:addChild(skill[1])
			skill["img"]:setResid("JLXQ_jineng3.png")	
			skill["des"]:setVisible(false)
			skill['suo']:setResid('XHB_suoding.png')

			local skillitem = dbManager.getInfoSkill(self.dbInfo.abilityarray[i])
			skillitem.abilityIndex = i
			skill['btn']:setListener(function ( ... )
				local nodePos = NodeHelper:getPositionInScreen(skill["btn"])
				GleeCore:showLayer('DSkillInfo',{skillitem=skillitem,cost=false,point=nodePos,offset=50})
			end)
		end	
	end
	set["bg_skillLayout"]:layout()

	return set[1]
end

function DPetInfo:createOtherItem( lootType,des )
	local set = self:createLuaSet("@raid")
	require "Toolkit".setLootIcon(set["bg_img"],lootType)
	set["bg_lock"]:setVisible(false)
	set["bg_name"]:setVisible(false)
	set["bg_tip"]:setVisible(false)
	set["bg_des"]:setVisible(true)
	set["bg_des"]:setString(des)
	set["bg_btn"]:setVisible(false)
	return set[1]
end

function DPetInfo:createTownItem( townid,townType )
	local dbTown = dbManager.getInfoTownConfig(townid)
	local dbArea = dbManager.getArea(dbTown.AreaId)
	local unlock = require "TownInfo".isTownOpen(townid,townType == 2)
	local set = self:createLuaSet("@raid")
	set["bg_img"]:setResid(string.format('%s.png',dbTown.Town_pic))
	set["bg_lock"]:setVisible(not unlock)
	local name = string.format("%s-%s",dbArea.Name,dbTown.Name)
	if townType == 2 then
		name = name.."(精英)"
	end
	set["bg_name"]:setString(name)

	if self.fromTownID>0 then
		if townType == 1 then
			set["bg_name"]:setVisible(false)
			set["bg_tip"]:setVisible(false)
			set["bg_des"]:setVisible(true)
			set["bg_des"]:setString(self.dbInfo.capture_condition)
		else
			set["bg_tip"]:setString(self.dbInfo.capture_condition)
   			set["bg_tip"]:setFontFillColor(ccc4f(1,0.94,0.81,1),true)
   		end
		set["bg_btn"]:setVisible(false)
	else
		set["bg_tip"]:setString(unlock and '点击前往' or '未解锁')
		set["bg_tip"]:setFontFillColor(unlock and res.color4F.green or ccc4f(0.95,0.26,0.19,1),true)
		if unlock then
			set["bg_btn"]:setListener(function ( ... )
				require 'EventCenter'.eventInput("GoToTown", {isSenior = townType == 2, townId = townid, petId = self.dbInfo.id})
			end)
		else
			set["bg_btn"]:setVisible(false)
		end
	end
	
	return set[1]
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPetInfo, "DPetInfo")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPetInfo", DPetInfo)


