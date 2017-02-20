local Config = require "Config"
local dbManager = require "DBManager"
local res = require "Res"
local gameFunc = require "AppData"
local netModel = require "netModel"
local userFunc = gameFunc.getUserInfo()
local timeLimitExploreFunc = gameFunc.getTimeLimitExploreInfo()

local DTimeLimitExploreCallPet = class(LuaDialog)

function DTimeLimitExploreCallPet:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DTimeLimitExploreCallPet.cocos.zip")
    return self._factory:createDocument("DTimeLimitExploreCallPet.cocos")
end

--@@@@[[[[
function DTimeLimitExploreCallPet:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._commonDialog = set:getElfNode("commonDialog")
    self._commonDialog_cnt = set:getElfNode("commonDialog_cnt")
    self._commonDialog_cnt_bg = set:getElfNode("commonDialog_cnt_bg")
    self._commonDialog_cnt_bg_pet = set:getElfNode("commonDialog_cnt_bg_pet")
    self._commonDialog_cnt_bg_bg1_des = set:getRichLabelNode("commonDialog_cnt_bg_bg1_des")
    self._commonDialog_cnt_bg_bg2_des = set:getRichLabelNode("commonDialog_cnt_bg_bg2_des")
    self._commonDialog_cnt_bg_bg3_stone = set:getLabelNode("commonDialog_cnt_bg_bg3_stone")
    self._commonDialog_cnt_bg_name = set:getLabelNode("commonDialog_cnt_bg_name")
    self._commonDialog_cnt_bg_starLayout = set:getLayoutNode("commonDialog_cnt_bg_starLayout")
    self._commonDialog_cnt_bg_tip = set:getLabelNode("commonDialog_cnt_bg_tip")
    self._commonDialog_cnt_bg_rateBg1_rateBg2 = set:getProgressNode("commonDialog_cnt_bg_rateBg1_rateBg2")
    self._commonDialog_cnt_bg_rateBg1_rate = set:getLabelNode("commonDialog_cnt_bg_rateBg1_rate")
    self._commonDialog_cnt_bg_btnOK = set:getClickNode("commonDialog_cnt_bg_btnOK")
    self._commonDialog_cnt_bg_btnOK_text = set:getLabelNode("commonDialog_cnt_bg_btnOK_text")
    self._commonDialog_cnt_bg_fail = set:getElfNode("commonDialog_cnt_bg_fail")
    self._commonDialog_title_text = set:getLabelNode("commonDialog_title_text")
    self._commonDialog_btnClose = set:getButtonNode("commonDialog_btnClose")
--    self._@star = set:getElfNode("@star")
--    self._@star = set:getElfNode("@star")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DTimeLimitExploreCallPet:onInit( userData, netData )
	self.PetId = userData.PetId
	self:setListenerEvent()
	self:updateLayer()
	res.doActionDialogShow(self._commonDialog)

	require "LangAdapter".LabelNodeAutoShrink(self._commonDialog_cnt_bg_tip, 740)
	require 'LangAdapter'.fontSize(self._commonDialog_cnt_bg_bg1_des, nil,nil,nil,nil,nil,nil,13,nil,nil,16)
	require 'LangAdapter'.fontSize(self._commonDialog_cnt_bg_bg2_des, nil,nil,nil,nil,nil,nil,14)
	require 'LangAdapter'.selectLang(nil,nil,nil,nil,nil,nil,function ( ... )
		require "LangAdapter".LabelNodeSetHorizontalAlignment(self._commonDialog_cnt_bg_tip, kCCTextAlignmentCenter)
	end)
end

function DTimeLimitExploreCallPet:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DTimeLimitExploreCallPet:setListenerEvent( ... )
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)
	
	self._commonDialog_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._commonDialog, self)
	end)

	self._commonDialog_cnt_bg_btnOK:setListener(function ( ... )
		local exploreInfo = timeLimitExploreFunc.getExplore()
		if exploreInfo.Score >= dbManager.getInfoDefaultConfig("TLAdvPetCost").Value then
			self:send(netModel.getModelTimeCopyZhaohuan(self.PetId), function ( data )
				if data and data.D then
					timeLimitExploreFunc.setExplore(data.D.TimeCopy)
					gameFunc.updateResource(data.D.Resource)
					self:updateLayer()
					res.doActionGetReward(data.D.Reward)
					require "EventCenter".eventInput("UpdateTimeLimitExplore")
					if data.D.Reward then
						GleeCore:showLayer('DPetAcademyEffectV2',{pets={data.D.Resource.Pets[1]} })
					--	self:toast(res.locString("Activity$TimeLimitExploreCallPetSuc"))
					else
						self._commonDialog_cnt_bg_fail:setOpacity(0)
						self._commonDialog_cnt_bg_fail:setVisible(true)
						
						GleeCore:showLayer('DPetAcademyEffectV2',{failed=true})
					--	self:toast(res.locString("Activity$TimeLimitExploreCallPetfail"))
					end
				end
			end)
		else
			self:toast(res.locString("Activity$TimeLimitExploreStoneNotEnough"))
		end
	end)
end

function DTimeLimitExploreCallPet:updateLayer( ... )
	local exploreInfo = timeLimitExploreFunc.getExplore()
	self._commonDialog_cnt_bg_bg1_des:setString(res.locString("Activity$TimeLimitExploreCallPet1"))
	self._commonDialog_cnt_bg_bg1_des:setFontFillColor(ccc4f(0,0,1,0), true)
	self._commonDialog_cnt_bg_bg2_des:setString(res.locString("Activity$TimeLimitExploreCallPet2"))
	self._commonDialog_cnt_bg_bg2_des:setFontFillColor(ccc4f(0,0,1,0), true)
	self._commonDialog_cnt_bg_bg3_stone:setString(exploreInfo.Score)

	local dbPet = dbManager.getCharactor(self.PetId)
	self._commonDialog_cnt_bg_name:setString(dbPet.name)
	require 'PetNodeHelper'.updateStarLayout(self._commonDialog_cnt_bg_starLayout, dbPet)
	self._commonDialog_cnt_bg_btnOK_text:setString(string.format(res.locString("Activity$TimeLimitExploreCallPetOnce"), dbManager.getInfoDefaultConfig("TLAdvPetCost").Value))
	local rate = exploreInfo.PetRate[tostring(self.PetId)] or 0
	self._commonDialog_cnt_bg_rateBg1_rateBg2:setPercentage(math.floor(rate * 100))
	self._commonDialog_cnt_bg_rateBg1_rate:setString(string.format(res.locString("Activity$TimeLimitExploreSucRate"), rate * 100))

	self._commonDialog_cnt_bg_pet:setResid(string.format("role_%03d.png", self.PetId))
	res.adjustPetIconPositionInParentLT(self._commonDialog_cnt_bg, self._commonDialog_cnt_bg_pet, self.PetId,'AdvPet')
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DTimeLimitExploreCallPet, "DTimeLimitExploreCallPet")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DTimeLimitExploreCallPet", DTimeLimitExploreCallPet)


