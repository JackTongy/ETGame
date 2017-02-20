local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"

local DActivityChampionNpcDetail = class(LuaDialog)

function DActivityChampionNpcDetail:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DActivityChampionNpcDetail.cocos.zip")
    return self._factory:createDocument("DActivityChampionNpcDetail.cocos")
end

--@@@@[[[[
function DActivityChampionNpcDetail:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getElfNode("bg")
    self._bg_layout1_name = set:getLabelNode("bg_layout1_name")
    self._bg_layout1_Lv = set:getLabelNode("bg_layout1_Lv")
    self._bg_layout1_process = set:getLabelNode("bg_layout1_process")
    self._bg_btnChallenge = set:getClickNode("bg_btnChallenge")
    self._bg_layout2 = set:getLinearLayoutNode("bg_layout2")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._hpBg = set:getElfNode("hpBg")
    self._hpBg_hpPro = set:getProgressNode("hpBg_hpPro")
    self._career = set:getElfNode("career")
    self._property = set:getElfNode("property")
    self._lv = set:getLabelNode("lv")
    self._starLayout = set:getLayoutNode("starLayout")
    self._isDead = set:getElfNode("isDead")
--    self._@pet = set:getElfNode("@pet")
--    self._@star6_2 = set:getSimpleAnimateNode("@star6_2")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DActivityChampionNpcDetail:onInit( userData, netData )
	res.doActionDialogShow(self._bg)
	
	print(userData.Data)
	local topTower = userData.Data
	local topStageId = userData.Index
	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_btnChallenge:setListener(function (  )
		local lvLimit = 10
		local canEnter = false
		local gameFunc = require "AppData"
		local petFunc = gameFunc.getPetInfo()
		for i,v in ipairs(petFunc.getPetList()) do
			if v.Lv >= lvLimit then
				canEnter = true
				break
			end
		end
		if canEnter then
			self:close()
			GleeCore:showLayer("DPrepareForChampionBattle", topTower)
		else
			self:toast( string.format(res.locString("Activity$ChampionCannotEnterTip"), lvLimit) )
		end
	end)

	local topStageData = topTower.Stages[topStageId]
	if topStageData then
		self._bg_layout1_name:setString(topStageData.Name)
		self._bg_layout1_Lv:setString("Lv.".. topStageData.Lv)
		self._bg_layout1_process:setString(string.format("(%d/%d)", topStageId, 10))
		local canChallenge = false
		if topStageData.Pets then
			self._bg_layout2:removeAllChildrenWithCleanup(true)
			for i,v in ipairs(topStageData.Pets) do
				local nPet = v
				local petSet = self:createLuaSet("@pet")
				self._bg_layout2:addChild(petSet[1])
				petSet["icon"]:setResid(res.getPetIcon(nPet.PetId))
				local petData = dbManager.getCharactor(nPet.PetId)
				petSet["career"]:setResid(res.getPetCareerIcon(petData.atk_method_system))
--				petSet["property"]:setResid(res.getPetPropertyIcon(petData.prop_1))
				-- petSet["starLayout"]:removeAllChildrenWithCleanup(true)
				-- for i=1,petData.star_level do
				-- 	local star = self:createLuaSet("@star")
				-- 	star[1]:setResid(res.getStarResid(nPet.MotiCnt))
				-- 	petSet["starLayout"]:addChild(star[1])
				-- end
				require 'PetNodeHelper'.updateStarLayout(petSet["starLayout"], petData)

				print("AwakeIndex-->"..nPet.AwakeIndex)
				local res = res.getPetIconFrameWithLv(nPet)
				print(res)
				petSet["frame"]:setResid(res)
				-- petSet["bg"]:setResid(res)
				petSet["lv"]:setString(nPet.Lv)
				petSet["isDead"]:setVisible(nPet.Hp <= 0)
				petSet["hpBg_hpPro"]:setPercentage(nPet.Hp / nPet.HpMax * 100)
				if nPet.Hp > 0 then
					canChallenge = true
				end
			end
		end
		self._bg_btnChallenge:setEnabled(canChallenge and topStageId == topTower.N + 1)
	end
end

function DActivityChampionNpcDetail:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DActivityChampionNpcDetail, "DActivityChampionNpcDetail")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DActivityChampionNpcDetail", DActivityChampionNpcDetail)
