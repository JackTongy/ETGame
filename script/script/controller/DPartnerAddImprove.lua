local Config = require "Config"
local res = require "Res"
local netModel = require "netModel"
local dbManager = require "DBManager"
local gameFunc = require "AppData"
local userFunc = gameFunc.getUserInfo()

local DPartnerAddImprove = class(LuaDialog)

function DPartnerAddImprove:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPartnerAddImprove.cocos.zip")
    return self._factory:createDocument("DPartnerAddImprove.cocos")
end

--@@@@[[[[
function DPartnerAddImprove:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._root = set:getElfNode("root")
    self._root_icon = set:getElfNode("root_icon")
    self._root_posIcon = set:getElfNode("root_posIcon")
    self._root_layoutLv = set:getLinearLayoutNode("root_layoutLv")
    self._root_layoutLv_pre = set:getLabelNode("root_layoutLv_pre")
    self._root_layoutLv_after = set:getLabelNode("root_layoutLv_after")
    self._root_layoutLv2 = set:getLinearLayoutNode("root_layoutLv2")
    self._root_layoutLv2_pre = set:getLabelNode("root_layoutLv2_pre")
    self._root_layoutCost = set:getLinearLayoutNode("root_layoutCost")
    self._root_layoutCost_value = set:getLabelNode("root_layoutCost_value")
    self._root_btnSub = set:getClickNode("root_btnSub")
    self._root_improveRate = set:getLabelNode("root_improveRate")
    self._root_btnAdd = set:getClickNode("root_btnAdd")
    self._root_btn100 = set:getClickNode("root_btn100")
    self._root_btn100_normal_text = set:getLabelNode("root_btn100_normal_text")
    self._root_btn100_pressed_text = set:getLabelNode("root_btn100_pressed_text")
    self._root_btn100_invalid_text = set:getLabelNode("root_btn100_invalid_text")
    self._root_gold = set:getElfNode("root_gold")
    self._root_count = set:getLabelNode("root_count")
    self._root_btnOk = set:getClickNode("root_btnOk")
    self._root_btnOk_text = set:getLabelNode("root_btnOk_text")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DPartnerAddImprove:onInit( userData, netData )
	self.partner = userData.partner
	self.getPetInfo = userData.getPetInfo
	self.rateAdd = 0
	self:setListenerEvent()
	self:updateLayer()
	res.doActionDialogShow(self._root)
end

function DPartnerAddImprove:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DPartnerAddImprove:setListenerEvent( ... )
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._root, self)
	end)

	self._root_btnOk:setListener(function ( ... )
		local dbPartnerLvUp = dbManager.getInfoPartnerLvUpConfig(self.partner.Lv)
		if userFunc.getGold() >= dbPartnerLvUp.Gold then
			local cost = math.floor(math.pow(self.rateAdd * 100, 1.5))
			if userFunc.getCoin() >= cost then
				self:send(netModel.getModelPartnerLvUp(self.partner.PositionId, dbPartnerLvUp.Rate + self.rateAdd), function ( data )
					if data and data.D then
						local oldLv = self.partner.Lv

						if data.D.Partners then
							gameFunc.getPartnerInfo().updatePartner(data.D.Partners)
						end
						if data.D.Pets then
							gameFunc.getPetInfo().addPets(data.D.Pets)
						end
						if data.D.Role then
							gameFunc.getUserInfo().setData(data.D.Role)
						end
						self.partner = gameFunc.getPartnerInfo().getPartnerWithOldPartner(self.partner)
						self.rateAdd = 0
						self:updateLayer()
						require "EventCenter".eventInput("PetFetterUpdate")
						require "EventCenter".eventInput("PetInfoModify")
						
						if self.partner.Lv == oldLv then
							self:toast(res.locString("Team$FetterResonantImproveFail"))
						else
							self:toast(res.locString("Team$FetterResonantImproveSuc"))
						end
					end
				end)
			else
				require "Toolkit".showDialogOnCoinNotEnough()
			end
		else
			self:toast(res.locString("Dungeon$GoldIsNotEnough"))
		end		
	end)

	self._root_btnSub:setListener(function ( ... )
		self.rateAdd = math.max(self.rateAdd - 0.01, 0)
		self:updateLayer()
	end)
	
	self._root_btnAdd:setListener(function ( ... )
		self.rateAdd = self.rateAdd + 0.01
		local dbPartnerLvUp = dbManager.getInfoPartnerLvUpConfig(self.partner.Lv)
		if self.rateAdd > 1 - dbPartnerLvUp.Rate then
			self.rateAdd = 1 - dbPartnerLvUp.Rate
		end
		self:updateLayer()
	end)
	
	self._root_btn100:setListener(function ( ... )
		local dbPartnerLvUp = dbManager.getInfoPartnerLvUpConfig(self.partner.Lv)
		self.rateAdd = 1 - dbPartnerLvUp.Rate
		self:updateLayer()
	end)
end

function DPartnerAddImprove:updateLayer( ... )
	local nPartner = self.partner

	if nPartner.PetId > 0 then
		local nPet = self.getPetInfo(nPartner.PetId)
		res.setNodeWithPet(self._root_icon, nPet)
	else
		self._root_icon:setResid("N_JL_touxiang.png")
	end
	local dbPartnerLvUp = dbManager.getInfoPartnerLvUpConfig(self.partner.Lv)

	self._root_posIcon:setResid(string.format("N_DW_biaoqian%d.png", nPartner.PositionId))
	local maxLv = dbManager.getPartnerLvMax()
	if nPartner.Lv >= maxLv then -- lvTop
		self._root_layoutLv:setVisible(false)
		self._root_layoutLv2:setVisible(true)
		self._root_layoutLv2_pre:setString(nPartner.Lv)
		self._root_btnOk_text:setString(res.locString("Global$LevelCap"))
		self._root_btnOk:setEnabled(false)
	else
		self._root_layoutLv:setVisible(true)
		self._root_layoutLv_pre:setString(nPartner.Lv)
		self._root_layoutLv_after:setString(math.min(nPartner.Lv + 1, maxLv))
		self._root_layoutLv2:setVisible(false)
		self._root_btnOk_text:setString(res.locString("Team$FetterResonantImprovePos"))
		self._root_btnOk:setEnabled(true)
	end
	local cost = math.floor(math.pow(self.rateAdd * 100, 1.8))
	self._root_layoutCost_value:setString(cost)
	if userFunc.getCoin() >= cost then
		self._root_layoutCost_value:setFontFillColor(ccc4f(0.549,0.47,0.455,1.0), true)
	else
		self._root_layoutCost_value:setFontFillColor(ccc4f(0.89, 0.243, 0.172, 1.0), true)
	end
	self._root_improveRate:setString(string.format(res.locString("Team$FetterResonantImproveRate2"), (dbPartnerLvUp.Rate + self.rateAdd) * 100))
	self._root_count:setString(res.getGoldFormat(dbPartnerLvUp.Gold, 10000))
	if userFunc.getGold() >= dbPartnerLvUp.Gold then
		self._root_count:setFontFillColor(ccc4f(1.0,1.0,1.0,1.0), true)
	else
		self._root_count:setFontFillColor(ccc4f(0.89, 0.243, 0.172, 1.0), true)
	end
	self._root_btnSub:setEnabled(self.rateAdd > 0)
	self._root_btnAdd:setEnabled(dbPartnerLvUp.Rate + self.rateAdd < 1)
	self._root_btn100:setEnabled(dbPartnerLvUp.Rate + self.rateAdd < 1)
end

function DPartnerAddImprove:getGoldFormat( gold )
	local func = function ( ... )
		if gold >= 10000 then
			return string.format("%dk", gold / 1000)
		else
			return tostring(gold)
		end
	end

	local ret = require 'LangAdapter'.selectLangkv({Arabic=func,ES=func,PT=func})
	if ret then
		return ret
	end
	
	if gold >= 100000 then
		if Config.LangName == "German" then
			return string.format("%dk",gold/1000)
		end
		return string.format("%dw", gold / 10000)
	else
		return tostring(gold)
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPartnerAddImprove, "DPartnerAddImprove")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPartnerAddImprove", DPartnerAddImprove)


