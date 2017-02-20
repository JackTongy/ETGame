local Config = require "Config"
local teamFunc = require "TeamInfo"
local petFunc = require "PetInfo"
local dbManager = require "DBManager"
local res = require "Res"
local netModel = require "netModel"

local DArenaTeamChoose = class(LuaDialog)

function DArenaTeamChoose:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DArenaTeamChoose.cocos.zip")
    return self._factory:createDocument("DArenaTeamChoose.cocos")
end

--@@@@[[[[
function DArenaTeamChoose:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._shield = set:getShieldNode("shield")
    self._dialogbg = set:getElfNode("dialogbg")
    self._dialogbg_btnCancel = set:getClickNode("dialogbg_btnCancel")
    self._dialogbg_btnBattle = set:getClickNode("dialogbg_btnBattle")
    self._dialogbg_atkTeamBg_clipSwip_teamSwip = set:getSwipNode("dialogbg_atkTeamBg_clipSwip_teamSwip")
    self._dialogbg_atkTeamBg_clipSwip_teamSwip_linearlayout = set:getLinearLayoutNode("dialogbg_atkTeamBg_clipSwip_teamSwip_linearlayout")
    self._layout = set:getLinearLayoutNode("layout")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._career = set:getElfNode("career")
    self._lv = set:getLabelNode("lv")
    self._bench = set:getElfNode("bench")
    self._starLayout = set:getLayoutNode("starLayout")
    self._dialogbg_atkTeamBg_titleBg_teamIndex = set:getLabelNode("dialogbg_atkTeamBg_titleBg_teamIndex")
    self._dialogbg_atkTeamBg_titleBg_power = set:getLabelNode("dialogbg_atkTeamBg_titleBg_power")
    self._dialogbg_atkTeamBg_turnLeft = set:getButtonNode("dialogbg_atkTeamBg_turnLeft")
    self._dialogbg_atkTeamBg_turnRight = set:getButtonNode("dialogbg_atkTeamBg_turnRight")
    self._dialogbg_defTeamBg_clipSwip_teamSwip = set:getSwipNode("dialogbg_defTeamBg_clipSwip_teamSwip")
    self._dialogbg_defTeamBg_clipSwip_teamSwip_linearlayout = set:getLinearLayoutNode("dialogbg_defTeamBg_clipSwip_teamSwip_linearlayout")
    self._layout = set:getLinearLayoutNode("layout")
    self._dialogbg_defTeamBg_titleBg_teamIndex = set:getLabelNode("dialogbg_defTeamBg_titleBg_teamIndex")
    self._dialogbg_defTeamBg_titleBg_power = set:getLabelNode("dialogbg_defTeamBg_titleBg_power")
    self._dialogbg_defTeamBg_turnLeft = set:getButtonNode("dialogbg_defTeamBg_turnLeft")
    self._dialogbg_defTeamBg_turnRight = set:getButtonNode("dialogbg_defTeamBg_turnRight")
--    self._@page = set:getElfNode("@page")
--    self._@pet = set:getElfNode("@pet")
--    self._@star = set:getElfNode("@star")
--    self._@page = set:getElfNode("@page")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DArenaTeamChoose:onInit( userData, netData )
	local nTeam = 1
	if require "UnlockManager":isUnlock("Team3") then
		nTeam = 3
	elseif require "UnlockManager":isUnlock("Team2") then
		nTeam = 2
	end
	self.nTeam = nTeam

	self.onAtkTeamChange = userData.OnAtkTeamChange
	self:updateView()

	res.doActionDialogShow(self._dialogbg)
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._dialogbg, self)
	end)
end

function DArenaTeamChoose:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function DArenaTeamChoose:updateView( ... )
	local teamList = teamFunc.getTeamList()
	for i,v in ipairs(teamList) do
		if v.IsAtk then
			self.initAtkIndex = i
		end
		if v.IsDef then
			self.initDefIndex = i
		end
	end

	self:updateTeamChoose("_dialogbg_atkTeamBg",true)
	self:updateTeamChoose("_dialogbg_defTeamBg",false)

	self._dialogbg_btnCancel:setTriggleSound(res.Sound.back)
	self._dialogbg_btnCancel:setListener(function ( ... )
		res.doActionDialogHide(self._dialogbg, self)
	end)

	self._dialogbg_btnBattle:setTriggleSound(res.Sound.yes)
	self._dialogbg_btnBattle:setListener(function ( ... )
		if self.atkIndex ~= self.initAtkIndex then
			self:send(netModel.getModelArenaSetAtkTeam(self.atkIndex),function ( ... )
				teamList[self.initAtkIndex].IsAtk = false
				teamList[self.atkIndex].IsAtk = true
				if self.onAtkTeamChange then
					local pets = {}
					for _,v in ipairs(teamList[self.atkIndex].PetIdList) do
						table.insert(pets,petFunc.getPetWithId(v))
					end
					local benchPet =petFunc.getPetWithId(teamList[self.atkIndex].BenchPetId)
					if benchPet then
						pets[6] = benchPet
					end
					self.onAtkTeamChange(pets,teamList[self.atkIndex].CombatPower)
				end
			end)
		end
		if self.defIndex ~= self.initDefIndex then
			self:send(netModel.getModelArenaSetDefTeam(self.defIndex),function ( ... )
				teamList[self.initDefIndex].IsDef = false
				teamList[self.defIndex].IsDef = true
			end)
		end
		res.doActionDialogHide(self._dialogbg, self)
	end)
end

function DArenaTeamChoose:updateTeamChoose( root,isAtk )
	local pointSetList = {}
	local teamList = teamFunc.getTeamList()
	for i=1,self.nTeam do
		local v = teamList[i]
		local page = self:createLuaSet("@page")
		local petIds = table.clone(v.PetIdList)
		petIds[6] = v.BenchPetId
		for j=1,6 do
			local petSet = self:createLuaSet("@pet")
			local pet = petFunc.getPetWithId(petIds[j])
			self:setPetIcon(petSet,pet,j==6)
			page["layout"]:addChild(petSet[1])
		end
		self[root.."_clipSwip_teamSwip_linearlayout"]:addChild(page[1])
		self[root.."_clipSwip_teamSwip"]:addStayPoint(-648 * (i - 1), 0)
	end
	
	local swipIndex = 1
	local function updateSwipIndex( ... )
		-- for i,v in ipairs(pointSetList) do
		-- 	if i == swipIndex then
		-- 		v[1]:setResid("ZDYQ_D1.png")
		-- 	else
		-- 		v[1]:setResid("ZDYQ_D2.png")
		-- 	end				
		-- end
		self[root.."_titleBg_teamIndex"]:setString(res.getTeamIndexText(swipIndex))
		self[root.."_titleBg_power"]:setString(teamList[swipIndex].CombatPower)

		self[root.."_turnLeft"]:setVisible(swipIndex > 1)
		self[root.."_turnRight"]:setVisible(swipIndex < self.nTeam)

		if isAtk then
			self.atkIndex = swipIndex
		else
			self.defIndex = swipIndex
		end
	end

	self[root.."_turnLeft"]:setListener(function ( ... )
		print("_turnLeft")
		swipIndex = swipIndex - 1
		self[root.."_clipSwip_teamSwip"]:setStayIndex(swipIndex-1)
		updateSwipIndex()
	end)

	self[root.."_turnRight"]:setListener(function ( ... )
		print("_turnRight")
		swipIndex = swipIndex + 1
		self[root.."_clipSwip_teamSwip"]:setStayIndex(swipIndex-1)
		updateSwipIndex()
	end)

	self[root.."_clipSwip_teamSwip"]:registerSwipeListenerScriptHandler(function(state, oldIndex, newIndex)
		if state ~= 0 and oldIndex ~= newIndex then
			print("newIndex---->"..newIndex)
			swipIndex = newIndex + 1
			updateSwipIndex()
		end
	end)
	swipIndex = isAtk and self.initAtkIndex or self.initDefIndex
	self[root.."_clipSwip_teamSwip"]:setStayIndex(swipIndex-1)
	updateSwipIndex()
end

function DArenaTeamChoose:setPetIcon( petLuaSet,data,isBench )
	
	if data then
		petLuaSet["frame"]:setResid(string.format("PZ%d_dengji.png",math.max(res.getFinalAwake(data.AwakeIndex) -1, 0)))
		petLuaSet["icon"]:setResid(res.getPetIcon(data.PetId))
		petLuaSet["icon"]:setScale(0.6*140/95)
		local petData = dbManager.getCharactor(data.PetId)
		petLuaSet["career"]:setResid(res.getPetCareerIcon(petData.atk_method_system))
		-- petLuaSet["property"]:setResid(res.getPetPropertyIcon(petData.prop_1))
		petLuaSet["starLayout"]:removeAllChildrenWithCleanup(true)
		require "PetNodeHelper".updateStarLayout(petLuaSet["starLayout"],petData)
		-- for i=1,petData.star_level do
		-- 	local star = self:createLuaSet("@star")
		-- 	star[1]:setResid(res.getStarResid(data.MotiCnt))
		-- 	petLuaSet["starLayout"]:addChild(star[1])
		-- end
		petLuaSet["lv"]:setString(data.Lv)
	else
		petLuaSet["icon"]:setResid("N_DW_xiaohuoban_kuang1.png")
	end
	petLuaSet["frame"]:setVisible(data~=nil)
	petLuaSet["career"]:setVisible(data ~= nil)
	-- petLuaSet["property"]:setVisible(data ~= nil)
	petLuaSet["starLayout"]:setVisible(data ~= nil)
	petLuaSet["lv"]:setVisible(data ~= nil)
	petLuaSet["bench"]:setVisible(isBench)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DArenaTeamChoose, "DArenaTeamChoose")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DArenaTeamChoose", DArenaTeamChoose)


