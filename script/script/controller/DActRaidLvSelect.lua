local Config = require "Config"
local res = require "Res"
local equipFunc = require "EquipInfo"
local gemFunc = require "GemInfo"
local bagFunc = require "BagInfo"
local userFunc = require "UserInfo"
local netModel = require "netModel"

local DActRaidLvSelect = class(LuaDialog)

function DActRaidLvSelect:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DActRaidLvSelect.cocos.zip")
    return self._factory:createDocument("DActRaidLvSelect.cocos")
end

--@@@@[[[[
function DActRaidLvSelect:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getShieldNode("bg")
    self._bg_detailBg_list = set:getListNode("bg_detailBg_list")
    self._icon = set:getElfNode("icon")
    self._name = set:getElfNode("name")
    self._bottomlayout = set:getLinearLayoutNode("bottomlayout")
    self._bottomlayout_tiplayout_power = set:getLabelNode("bottomlayout_tiplayout_power")
    self._bottomlayout_btn = set:getClickNode("bottomlayout_btn")
    self._bottomlayout_btn_label = set:getLabelNode("bottomlayout_btn_label")
    self._starLayout = set:getLayoutNode("starLayout")
    self._bg_detailBg_N_TY_biaoti1 = set:getElfNode("bg_detailBg_N_TY_biaoti1")
    self._bg_detailBg_tip = set:getLabelNode("bg_detailBg_tip")
    self._bg_detailBg_closeBtn = set:getButtonNode("bg_detailBg_closeBtn")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DActRaidLvSelect:onInit( userData, netData )
	self.vipNeedForSaodang = 1

	self.raidInfo = userData.RaidInfo
	self.stars = userData.RaidInfo.Stars
	-- self.stars = {3,3,3}
	self.config = userData.Config
	self.raidType = userData.RaidType
	self:updateView()

	res.doActionDialogShow(self._bg)
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)
	self._bg_detailBg_closeBtn:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)
end

function DActRaidLvSelect:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function DActRaidLvSelect:updateView( ... )
	local userLevel = userFunc.getLevel()
	local recommendPowers = self:getRecommendPower()
	local power = math.max(require "UserInfo".getData().HiPwr,require "TeamInfo".getTeamCombatPower())
	local vipEnableForSaodang = userFunc.getVipLevel()>=self.vipNeedForSaodang
	local nItem = (self.raidType >= 1 and self.raidType <= 3) and 6 or 3
	local last3StarIndex
	for i=1,nItem do
		local set = self:createLuaSet("@item")

		require 'LangAdapter'.LabelNodeAutoShrink(set["bottomlayout_btn_label"],100)
		require 'LangAdapter'.fontSize(set["bottomlayout_tiplayout_#label"],nil,nil,16,nil,nil,nil,16,nil,nil,16)
		require 'LangAdapter'.fontSize(set["bottomlayout_tiplayout_power"],nil,nil,16,nil,nil,nil,16,nil,nil,16)
		require 'LangAdapter'.LayoutChildrenReverseifArabic(set["bottomlayout_#tiplayout"])

		-- local isUnlock = userLevel>=self.config.UnlockLevel[i]
		-- local isUnlock = true
		if self.raidType == 1 then
			set["icon"]:setResid("TY_jinbi_da.png")
		elseif self.raidType == 2 then
			if Config.LangName == "vn" or Config.LangName == "kor" or Config.LangName == "english" or Config.LangName == "PT" or Config.LangName == "ES" or Config.LangName == "Indonesia" or Config.LangName == "German" or Config.LangName == "Arabic" then
				res.setEquipDetail(set["icon"],equipFunc.getEquipInfoByEquipmentID(5003+math.min(5,i)*100))
			else
				res.setEquipDetail(set["icon"],equipFunc.getEquipInfoByEquipmentID(5003+i*100))
			end
		elseif self.raidType== 3 then
			res.setItemDetail(set["icon"],bagFunc.getItemByMID(69))
		elseif self.raidType == 4 then
			res.setItemDetail(set["icon"],bagFunc.getItemByMID(43))
		elseif self.raidType == 5 then
			res.setItemDetail(set["icon"],bagFunc.getItemByMID(44))
		elseif self.raidType == 6 then
			res.setItemDetail(set["icon"],bagFunc.getItemByMID(45))
		elseif self.raidType == 7 then
			res.setItemDetail(set["icon"],bagFunc.getItemByMID(46))
		elseif self.raidType == 8 then
			res.setItemDetail(set["icon"],bagFunc.getItemByMID(47))
		end

		-- if not isUnlock then
		-- 	-- set["icon"]:setResid("N_DW_xiaohuoban_kuang2.png")
		-- 	local tip = self:createLuaSet("@tip")[1]
		-- 	tip:setString(string.format(res.locString("Activity$ActRaidLockTip1"),self.config.UnlockLevel[i]))
		-- 	set["bottomlayout"]:addChild(tip,-1)
		-- end
		set["name"]:setResid(string.format("N_HDFB_nandu%d.png",i))
		local starCount = self.stars[i]
		if starCount>=3 then
			last3StarIndex = i-1
		end

		for j=1,3 do
			local node = ElfNode:create()
			if j<=starCount then
				node:setResid("SX_xingxing1.png")
			else
				node:setResid("SX_xingxing2.png")
			end
			set["starLayout"]:addChild(node)
		end

		local function GoldFormat( Gold )
			if Gold >= 100000 then
				return string.format("%dK", Gold / 1000)
			else
				return tostring(Gold)
			end
		end

		set["bottomlayout_tiplayout_power"]:setString(GoldFormat(recommendPowers[i]))

		local isUnlock = power >= recommendPowers[i]
		if isUnlock then
			set["bottomlayout_btn"]:setEnabled(true)
			local saodaoEnable = starCount>=3  and vipEnableForSaodang
			if saodaoEnable then
				set["bottomlayout_btn_label"]:setString(res.locString("Dungeon$ChallengeSpeed"))
			end
			set["bottomlayout_btn"]:setListener(function ( ... )
				if saodaoEnable  then
					self:send(netModel.getModelActRaidRewardGet(self.raidType,i,true,3),function ( data )
						local param = {
							Results = {{Reward = data.D.Reward}},
							callback = function (  )
								require "AppData".updateResource(data.D.Resource)
								self.raidInfo.TimesLeft = self.raidInfo.TimesLeft - 1
								self:close()
							end
						}
						GleeCore:showLayer("DBattleSpeed", param)
					end)
				else
					local para = {}
					if self.raidType == 1 then
						local tempList = {1, 2, 3, 67, 68, 69}
						para.battleId = tempList[i]
					elseif self.raidType == 2 then
						local tempList = {4, 5, 6, 64, 65, 66}
						para.battleId = tempList[i]
					elseif self.raidType == 3 then
						local tempList = {7, 8, 9, 70, 71, 72}
						para.battleId = tempList[i]
					elseif self.raidType<=8 then
						para.battleId = i+(self.raidType-1)*3+39
					end
					para.type = "ActRaid"
					return GleeCore:showLayer("DPrepareForStageBattle", para)
				end
			end)
		else
			set["bottomlayout_tiplayout_power"]:setFontFillColor(res.color4F.red,true)
			set["bottomlayout_btn"]:setEnabled(false)
		end
		self._bg_detailBg_list:getContainer():addChild(set[1])
	end
	self._bg_detailBg_tip:setString(string.format(res.locString("Activity$ActRaidSaodangTip"),self.vipNeedForSaodang))
	self._bg_detailBg_list:getContainer():layout()
	if last3StarIndex and last3StarIndex>0 then
		self._bg_detailBg_list:alignTo(last3StarIndex)
	end
end

function DActRaidLvSelect:getPowerStr( power )
	if Config.LangName == "vn" or Config.LangName == "kor" then
		return math.floor(power/1000) .. "K"
	else
		return power
	end
end

function DActRaidLvSelect:getRecommendPower( )
	if self.raidType == 1 then
		return {8000,30000,50000,250000,700000,1500000}
	elseif self.raidType == 2 then
		return {1500,25000,55000,250000,700000,1500000}
	elseif self.raidType == 3 then
		return {700000, 1500000, 2500000, 4000000, 5500000, 7000000}
	elseif self.raidType >= 4 and self.raidType <= 8 then
		return {6000,25000,45000}
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DActRaidLvSelect, "DActRaidLvSelect")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DActRaidLvSelect", DActRaidLvSelect)


