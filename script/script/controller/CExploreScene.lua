local Config = require "Config"
local Res = require 'Res'
local res = Res
local netModel = require "netModel"
local EventCenter = require 'EventCenter'
local UnlockManager = require 'UnlockManager'
local AppData = require 'AppData'
local GuildCopyFunc = AppData.getGuildCopyInfo()

local CExploreScene = class(LuaController)

function CExploreScene:createDocument()
		self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."CExploreScene.cocos.zip")
		return self._factory:createDocument("CExploreScene.cocos")
end

--@@@@[[[[
function CExploreScene:onInitXML()
	local set = self._set
    self._BG = set:getElfNode("BG")
    self._BG_map = set:getMapNode("BG_map")
    self._BG_map_container_bg = set:getElfNode("BG_map_container_bg")
    self._BG_map_container_bg_ship1 = set:getElfNode("BG_map_container_bg_ship1")
    self._BG_map_container_bg_ship2 = set:getElfNode("BG_map_container_bg_ship2")
    self._BG_map_container_bg_ship3 = set:getElfNode("BG_map_container_bg_ship3")
    self._BG_map_container_bg_entrance = set:getClickNode("BG_map_container_bg_entrance")
    self._BG_map_container_bg_entrance_nameBg_name = set:getLabelNode("BG_map_container_bg_entrance_nameBg_name")
    self._BG_map_container_bg_entrance_nameBg_lock = set:getElfNode("BG_map_container_bg_entrance_nameBg_lock")
    self._BG_map_container_bg_entrance_nameBg_point = set:getElfNode("BG_map_container_bg_entrance_nameBg_point")
    self._BG_map_container_bg_championLeague = set:getClickNode("BG_map_container_bg_championLeague")
    self._BG_map_container_bg_championLeague_nameBg_name = set:getLabelNode("BG_map_container_bg_championLeague_nameBg_name")
    self._BG_map_container_bg_championLeague_nameBg_lock = set:getElfNode("BG_map_container_bg_championLeague_nameBg_lock")
    self._BG_map_container_bg_championLeague_nameBg_point = set:getElfNode("BG_map_container_bg_championLeague_nameBg_point")
    self._BG_map_container_bg_championLeague_balloon1 = set:getElfNode("BG_map_container_bg_championLeague_balloon1")
    self._BG_map_container_bg_championLeague_balloon2 = set:getElfNode("BG_map_container_bg_championLeague_balloon2")
    self._BG_map_container_bg_championLeague_balloon3 = set:getElfNode("BG_map_container_bg_championLeague_balloon3")
    self._BG_map_container_bg_endlessTrials = set:getClickNode("BG_map_container_bg_endlessTrials")
    self._BG_map_container_bg_endlessTrials_nameBg_name = set:getLabelNode("BG_map_container_bg_endlessTrials_nameBg_name")
    self._BG_map_container_bg_endlessTrials_nameBg_lock = set:getElfNode("BG_map_container_bg_endlessTrials_nameBg_lock")
    self._BG_map_container_bg_endlessTrials_nameBg_point = set:getElfNode("BG_map_container_bg_endlessTrials_nameBg_point")
    self._BG_map_container_bg_endlessTrials_elfmotion = set:getElfMotionNode("BG_map_container_bg_endlessTrials_elfmotion")
    self._BG_map_container_bg_endlessTrials_elfmotion_KeyStorage = set:getElfNode("BG_map_container_bg_endlessTrials_elfmotion_KeyStorage")
    self._BG_map_container_bg_endlessTrials_elfmotion_KeyStorage_animate2_Visible = set:getElfNode("BG_map_container_bg_endlessTrials_elfmotion_KeyStorage_animate2_Visible")
    self._BG_map_container_bg_endlessTrials_elfmotion_animate1 = set:getSimpleAnimateNode("BG_map_container_bg_endlessTrials_elfmotion_animate1")
    self._BG_map_container_bg_endlessTrials_elfmotion_animate2 = set:getSimpleAnimateNode("BG_map_container_bg_endlessTrials_elfmotion_animate2")
    self._BG_map_container_bg_guildBattle = set:getClickNode("BG_map_container_bg_guildBattle")
    self._BG_map_container_bg_guildBattle_nameBg_name = set:getLabelNode("BG_map_container_bg_guildBattle_nameBg_name")
    self._BG_map_container_bg_guildBattle_nameBg_lock = set:getElfNode("BG_map_container_bg_guildBattle_nameBg_lock")
    self._BG_map_container_bg_guildBattle_nameBg_point = set:getElfNode("BG_map_container_bg_guildBattle_nameBg_point")
    self._BG_map_container_bg_guildBattle_showdow2 = set:getElfNode("BG_map_container_bg_guildBattle_showdow2")
    self._BG_map_container_bg_guildBattle_showdow1 = set:getElfNode("BG_map_container_bg_guildBattle_showdow1")
    self._BG_map_container_bg_guildBattle_module2 = set:getElfNode("BG_map_container_bg_guildBattle_module2")
    self._BG_map_container_bg_guildBattle_module2_light = set:getElfNode("BG_map_container_bg_guildBattle_module2_light")
    self._BG_map_container_bg_guildBattle_module1 = set:getElfNode("BG_map_container_bg_guildBattle_module1")
    self._BG_map_container_bg_guildBattle_module1_light = set:getElfNode("BG_map_container_bg_guildBattle_module1_light")
    self._BG_map_container_bg_hunt = set:getClickNode("BG_map_container_bg_hunt")
    self._BG_map_container_bg_hunt_nameBg_name = set:getLabelNode("BG_map_container_bg_hunt_nameBg_name")
    self._BG_map_container_bg_hunt_nameBg_lock = set:getElfNode("BG_map_container_bg_hunt_nameBg_lock")
    self._BG_map_container_bg_hunt_nameBg_point = set:getElfNode("BG_map_container_bg_hunt_nameBg_point")
    self._BG_map_container_bg_btnRemains = set:getClickNode("BG_map_container_bg_btnRemains")
    self._BG_map_container_bg_btnRemains_nameBg_name = set:getLabelNode("BG_map_container_bg_btnRemains_nameBg_name")
    self._BG_map_container_bg_btnRemains_nameBg_lock = set:getElfNode("BG_map_container_bg_btnRemains_nameBg_lock")
    self._BG_map_container_bg_btnRemains_nameBg_point = set:getElfNode("BG_map_container_bg_btnRemains_nameBg_point")
    self._BG_map_container_bg_btnRemains_flash = set:getFlashMainNode("BG_map_container_bg_btnRemains_flash")
    self._BG_map_container_bg_stupidDesign1 = set:getColorClickNode("BG_map_container_bg_stupidDesign1")
    self._BG_map_container_bg_stupidDesign2 = set:getColorClickNode("BG_map_container_bg_stupidDesign2")
    self._BG_map_container_bg_stupidDesign3 = set:getColorClickNode("BG_map_container_bg_stupidDesign3")
    self._BG_btnClose = set:getButtonNode("BG_btnClose")
    self._RepeatForever1 = set:getElfAction("RepeatForever1")
    self._RepeatForever2 = set:getElfAction("RepeatForever2")
    self._RepeatForever3 = set:getElfAction("RepeatForever3")
    self._guildBLeft = set:getElfAction("guildBLeft")
    self._guildBRight = set:getElfAction("guildBRight")
    self._light1 = set:getElfAction("light1")
    self._light2 = set:getElfAction("light2")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("CExploreScene", function ( userData )
	if UnlockManager:isUnlock("GuildCopyLv") then
		if require "GuildInfo".isInGuild() then
			GuildCopyFunc.cleanStagesData()
			Launcher.callNet(netModel.getModelGuildCopyGet(), function ( data )
				print("GuildCopyGet")
				print(data)
				if data and data.D then
					GuildCopyFunc.setGuildCopy(data.D.GuildCopy)
					GuildCopyFunc.setGuildCopyRecord(data.D.Record)
					Launcher.Launching(data)
				end
			end)
		else
			Launcher.Launching()
		end	
	else
		Launcher.Launching()
	end
end)

function CExploreScene:onInit( userData, netData )
	require 'LangAdapter'.LabelNodeAutoShrink(self._BG_map_container_bg_entrance_nameBg_name,105)
    require 'LangAdapter'.LabelNodeAutoShrink(self._BG_map_container_bg_championLeague_nameBg_name,105)
    require 'LangAdapter'.LabelNodeAutoShrink(self._BG_map_container_bg_endlessTrials_nameBg_name,105)
    require 'LangAdapter'.LabelNodeAutoShrink(self._BG_map_container_bg_guildBattle_nameBg_name,105)
	require 'LangAdapter'.LabelNodeAutoShrink(self._BG_map_container_bg_hunt_nameBg_name,105)
    require 'LangAdapter'.LabelNodeAutoShrink(self._BG_map_container_bg_btnRemains_nameBg_name,105)

	self:setListenerEvent()
	self:updateLayer()

	self._BG_map:setContentSize(CCDirector:sharedDirector():getWinSize())
	self._BG_map:getMoveNode():setPosition(ccp(-self._BG_map_container_bg_hunt:getPosition(), 0))
	self._BG_map:onRestrict(nil)

	EventCenter.addEventFunc("explore", function ( data )
		self:updateState()
	end, "CExploreScene")

	EventCenter.addEventFunc("OnBattleCompleted", function ( data )
		if data.mode == 'league' then
			GleeCore:showLayer('DLeague', {isWin = data and data.isWin})
		elseif data.mode == 'train' then
			if data.isWin then
				GleeCore:showLayer('DTrials', {isBattleReturnBack = data.userData.D.Adventure.CurrentType ~= 0})
			else
				GleeCore:showLayer('DTrials', {isBattleReturnBack = true})
			end
		end
	end, "CExploreScene")
end

function CExploreScene:onBack( userData, netData )
	require 'framework.helper.MusicHelper'.playBackgroundMusic(Res.Music.home, true)
end

function CExploreScene:onRelease( ... )
	EventCenter.resetGroup('CExploreScene')
end

function CExploreScene:onEnter( ... )
	require 'GuideHelper':registerPoint('试练',self._BG_endlessTrials)
	require 'GuideHelper':check('CExploreScene')
end

--------------------------------custom code-----------------------------
function CExploreScene:setListenerEvent( ... )
	self._BG_map_container_bg_entrance:setListener(function()
		GleeCore:showLayer('DExploration')
	end)
	
	self._BG_map_container_bg_championLeague:setListener(function()
		if not require 'UnlockManager':isOpen('League') then
			self:toast(Res.locString('Explore$_Tips'))
			return    
		end
		GleeCore:showLayer('DLeague')
	end)

	self._BG_map_container_bg_endlessTrials:setListener(function()
		if not require 'UnlockManager':isOpen('ELTrain') then
			self:toast(Res.locString('Explore$_Tips'))
			return    
		end
		GleeCore:showLayer('DTrials')
	end)

	self._BG_map_container_bg_guildBattle:setListener(function()
		if not require 'UnlockManager':isOpen('GuildBattle') then
			self:toast(Res.locString('Explore$_Tips'))
			return    
		end
		GleeCore:pushController("CGBMain", nil, nil, Res.getTransitionFade())
	end)

	self._BG_map_container_bg_hunt:setListener(function ( ... )
		if not require 'UnlockManager':isOpen('Hunt') then
			self:toast(Res.locString('Explore$_Tips'))
			return    
		end
		GleeCore:showLayer("DHunt")
	end)

	self._BG_map_container_bg_btnRemains:setListener(function ( ... )
		if not require 'UnlockManager':isOpen('yiji') then
			self:toast(Res.locString('Explore$_Tips'))
			return    
		end
		GleeCore:showLayer("DRemains")
	end)

	for i=1,3 do
		self[string.format("_BG_map_container_bg_stupidDesign%d", i)]:setListener(function()
			self:toast(Res.locString('Explore$_Tips'))
		end)
	end

	self._BG_btnClose:setListener(function()
		GleeCore:popController(nil, Res.getTransitionFade())
	end)
end

function CExploreScene:updateLayer( ... )
	self._BG_map_container_bg_ship1:runAction(self._RepeatForever1:clone())
	self._BG_map_container_bg_ship2:runAction(self._RepeatForever2:clone())
	self._BG_map_container_bg_ship3:runAction(self._RepeatForever3:clone())
	self:setEntranceState('ChampionshipLv', self._BG_map_container_bg_championLeague_nameBg_name, self._BG_map_container_bg_championLeague_nameBg_lock)
	self._BG_map_container_bg_championLeague_balloon1:runAction(self._RepeatForever1:clone())
	self._BG_map_container_bg_championLeague_balloon2:runAction(self._RepeatForever2:clone())
	self._BG_map_container_bg_championLeague_balloon3:runAction(self._RepeatForever3:clone())
	self:setEntranceState('AdventureLv', self._BG_map_container_bg_endlessTrials_nameBg_name, self._BG_map_container_bg_endlessTrials_nameBg_lock)
	self._BG_map_container_bg_guildBattle_showdow2:runAction(self._guildBLeft:clone())
	self._BG_map_container_bg_guildBattle_showdow1:runAction(self._guildBRight:clone())
	self._BG_map_container_bg_guildBattle_module2:runAction(self._guildBLeft:clone())
	self._BG_map_container_bg_guildBattle_module2_light:runAction(self._light2:clone())
	self._BG_map_container_bg_guildBattle_module1:runAction(self._guildBRight:clone())
	self._BG_map_container_bg_guildBattle_module1_light:runAction(self._light1:clone())
	self:setEntranceState('GuildCopyLv', self._BG_map_container_bg_hunt_nameBg_name, self._BG_map_container_bg_hunt_nameBg_lock)

	local c = self._BG_map_container_bg_btnRemains_flash:getModifierControllerByName('swf')
	c:setLoopMode(LOOP)
	c:setLoops(999999999)
	self._BG_map_container_bg_btnRemains_flash:play("swf")
	self:setEntranceState('Remain', self._BG_map_container_bg_btnRemains_nameBg_name, self._BG_map_container_bg_btnRemains_nameBg_lock)

	self:updateState()
end

function CExploreScene:setEntranceState(name, nameNode, lockNode)
	local isUnLock = UnlockManager:isUnlock(name)
	lockNode:setVisible(not isUnLock)
	if isUnLock then
		nameNode:setFontFillColor(ccc4f(1.0, 1.0, 1.0, 1.0), true)
	else
		nameNode:setFontFillColor(ccc4f(0.66, 0.66, 0.66, 1.0), true)
	end
end

function CExploreScene:updateState()
	self._BG_map_container_bg_entrance_nameBg_point:setVisible(AppData.getExploreInfo().hasCompleteExplore() or AppData.getExploreInfo().hasEmptySlot())

	local record = GuildCopyFunc.getGuildCopyRecord()
	local huntPoint = record and record.TimesLeft > 0 or false
	if not huntPoint then
		local record = GuildCopyFunc.getGuildCopyRecord()
		for i=1,3 do
			if record and not record[string.format("Box%dOpened", i)] then
				if GuildCopyFunc.getBoxProcess(i) >= 1 then
					huntPoint = true
					break
				end
			end
		end
	end
	self._BG_map_container_bg_hunt_nameBg_point:setVisible( huntPoint )
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(CExploreScene, "CExploreScene")


--------------------------------register--------------------------------
GleeCore:registerLuaController("CExploreScene", CExploreScene)


