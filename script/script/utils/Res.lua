local localize = require "framework.basic.Localize"
local config = require "Config"
local dbManager = require "DBManager"
local Config = require 'Config'

print("config.LANGUAGE = " .. config.LANGUAGE)
localize.loadStrings(config.LANGUAGE)--localize.filename(config.LANGUAGE))

local Res = {}

Res.color4F = {
	black = ccc4f(0, 0, 0, 1),
	gray = ccc4f(0.8235, 0.8235, 0.8235, 1),
	white = ccc4f(1, 1, 1, 1),
	red = ccc4f(1, 0, 0, 1),
	green = ccc4f(0.12549, 0.67, 0, 1),
	orange = ccc4f(1, 0.6627, 0.2667, 1),
	khaki = ccc4f(0.953, 0.878, 0.7333, 1),
	yellow = ccc4f(1, 0.9216, 0.243, 1),
	blue = ccc4f(0.1647, 0.9451, 0.9922, 1),
	purple = ccc4f(0.976, 0.592, 1, 1),
}

Res.rankColor4F = {
	[0] = ccc4f(0.8235, 0.8235, 0.8235, 1),
	ccc4f(1, 1, 1, 1),
	ccc4f(0.63, 0.9255, 0.4235, 1),
	ccc4f(0.5725, 0.933, 0.988, 1),
	ccc4f(0.976, 0.592, 1, 1),
	ccc4f(0.956863,0.474510,0.125490,1.0),
	ccc4f(1.0,1.0,0,1),
	ccc4f(1.0,0.239216,0.2,1.0)
}


Res.rankColor4FInList = {
	[0] = ccc4f(0.8235, 0.8235, 0.8235, 1),
	ccc4f(1, 1, 1, 1),
	ccc4f(0.63, 0.9255, 0.4235, 1),
	ccc4f(0.5725, 0.933, 0.988, 1),
	ccc4f(0.976, 0.592, 1, 1),
	ccc4f(1.0,0.596078,0.266667,1.0),
	ccc4f(1.0,0.980392,0.117647,1.0),
	ccc4f(1.0,0.737255,0.72549,1.0)
}


Res.tabColor = {
	unselectTextColor = ccc4f(0.4,0.88,1,1),
	unselectStrokeColor = ccc4f(0,0.22,0.42,1),
	selectedTextColor = ccc4f(1,1,1,1),
	selectedStrokeColor = ccc4f(0.4,0.2,0,1),
	invalidTextColor = ccc4f(0.3,0.74,0.84,1),
	invalidStrokeColor = ccc4f(0.06,0.36,0.46,1)
}

Res.tabColor2 = {
	unselectTextColor = ccc4f(1,0.74,0.61,1),
	unselectStrokeColor = ccc4f(0,0.22,0.42,1),
	selectedTextColor = ccc4f(1,1,1,1),
	selectedStrokeColor = ccc4f(0.4,0.2,0,1),
}

--灰 白 绿 蓝 紫 橙 金 红
Res.RankColorStr = {
	[0] = 'd2d2d2ff',
	'FFFFFFFF',
	'A1EC6CFF',
	'92EEFCFF',
	'F997FFFF',
	'f47920FF',
	'ffff00ff',
	'ff3d33ff'
}

Res.closeColor = {
	[1]=ccc4f(0.466667,0.666667,0.784314,1),
	[2]=ccc4f(0.545098,0.956863,0.921569,1),
	[3]=ccc4f(0.749020,1.000000,0.431373,1),
	[4]=ccc4f(1.000000,0.984314,0.192157,1),
	[5]=ccc4f(1.000000,0.670588,0.419608,1),
}

Res.ServerColor = {
	[1]=ccc4f(0.458824,1.000000,0.462745,1.0),--新
	[2]=ccc4f(0.988235,0.376471,0.239216,1.0),--火
	[3]=ccc4f(1.000000,0.874510,0.192157,1.0),--维
}

Res.Num = {
	[1]=localize.getLanguage('Global$Num1'),
	[2]=localize.getLanguage('Global$Num2'),
	[3]=localize.getLanguage('Global$Num3'),
	[4]=localize.getLanguage('Global$Num4'),
	[5]=localize.getLanguage('Global$Num5'),
	[6]=localize.getLanguage('Global$Num6'),
	[7]=localize.getLanguage('Global$Num7'),
}

Res.Book = {
	[1]=ccc4f(0.0,0.38039216,0.05882353,1.0),
	[2]=ccc4f(0.015686275,0.101960786,0.23137255,1.0),
	[3]=ccc4f(0.16078432,0.039215688,0.21176471,1.0),
	[4]=ccc4f(0.44313726,0.14117648,0.0,1.0),
}

Res.Sound = {
	--old fasion
	back 				= "raw/ui_back.mp3",
	bar 				= "raw/ui_bar.mp3",
	dg_brick			= "raw/dg_brick.mp3",
	dg_buff_heart 		= "raw/dg_buff_heart.mp3",
	dg_buff_sword 		= "raw/dg_buff_sword.mp3",
	dg_chest			= "raw/dg_chest.mp3",
	dg_coin 			= "raw/dg_coin.mp3",
	dg_grass 			= "raw/dg_grass.mp3",
	dg_heart 			= "raw/dg_heart.mp3",
	dg_ice 				= "raw/dg_ice.mp3",
	dg_lava 			= "raw/dg_lava.mp3",
	dg_monster 			= "raw/dg_monster.mp3",
	dg_pickcoin 		= "raw/dg_pickcoin.mp3",
	dg_pickitem 		= "raw/dg_pickitem.mp3",
	dg_pool 			= "raw/dg_pool.mp3",
	dg_pot 				= "raw/dg_pot.mp3",
	dg_rock 			= "raw/dg_rock.mp3",
	dg_stopwatch 		= "raw/dg_stopwatch.mp3",
	dg_sword 			= "raw/dg_sword.mp3",
	dg_tree 			= "raw/dg_tree.mp3",
	dg_touch 			= "raw/dg_touch.mp3",
	dg_touch_forest 	= "raw/dg_touch_forest.mp3",
	dg_touch_ice 		= "raw/dg_touch_ice.mp3",
	dg_touch_lava 		= "raw/dg_touch_lava.mp3",
	dg_touch_meadow 	= "raw/dg_touch_meadow.mp3",
	dg_touch_open 		= "raw/dg_touch_open.mp3",
	dg_touch_sand 		= "raw/dg_touch_sand.mp3",
	dg_touch_snow 		= "raw/dg_touch_snow.mp3",
	dg_touch_stone 		= "raw/dg_touch_stone.mp3",
	dg_touch_water 		= "raw/dg_touch_water.mp3",
	dg_touch_wetland 	= "raw/dg_touch_wetland.mp3",
	gem 				= "raw/ui_gem.mp3",
	lvup 				= "raw/ui_lvup.mp3",
	pick 				= "raw/ui_pick.mp3",
	reward 				= "raw/ui_reward.mp3",
	star 				= "raw/ui_star.mp3",
	yes 				= "raw/ui_yes.mp3",
	
	--battle
	bt_target 			= 'raw/bt_target.mp3',
	bt_slots_roll 		= 'raw/bt_slots_roll.mp3',
	bt_slots_selected 	= 'raw/bt_slots_selected.mp3',
	bt_slots_displace	= 'raw/bt_slots_displace.mp3',
	bt_slots_grid		= 'raw/bt_slots_grid.mp3',
	bt_tank_block		= 'raw/bt_tank_block.mp3',
	bt_explosive  		= 'raw/bt_explosive.mp3',
	bt_win 				= 'raw/bt_win.mp3',
	bt_lose 			= 'raw/bt_lose.mp3',
	bt_rage 			= 'raw/bt_rage.mp3',
	bt_warning 			= 'raw/bt_warning.mp3',
	bt_drop_beat 		= 'raw/bt_chests.mp3',
	
	--ui
	ui_back 			= 'raw/ui_back.mp3',
	ui_bar 				= 'raw/ui_bar.mp3',
	ui_gem 				= 'raw/ui_gem.mp3',
	ui_lvup 			= 'raw/ui_lvup.mp3',
	ui_pick 			= 'raw/ui_pick.mp3',
	ui_reward 			= 'raw/ui_reward.mp3',
	ui_star 			= 'raw/ui_star.mp3',
	ui_yes 				= 'raw/ui_yes.mp3',
	ui_clear_stars 		= 'raw/ui_sfx_clear.mp3',

	ui_sfx_unlock 		= 'raw/ui_sfx_unlock.mp3',
	ui_sfx_advent		= 'raw/ui_sfx_advent.mp3',
	ui_taxt				= 'raw/ui_taxt.mp3',
	ui_newworld		= 'raw/ui_newworld.mp3',
	ui_summon		= 'raw/ui_summon.mp3',
}

Res.Music = {
	world				= 'raw/ui_music_world.mp3',
	dungeon 			= 'raw/dg_music_dungeon.mp3',
	home 				= 'raw/ui_music_nexus.mp3',
	battle 				= 'raw/bt_music_battle.mp3',
	boss 				= 'raw/bt_music_boss.mp3',
	dialogue 			= 'raw/htp_dialogue.mp3',
}

Res.equipScale = 155 / 140

function Res.getEquipColor( color )
	return Res.getRankColor(color+1)
end

function Res.getRankColor( rank )
	assert(rank > 0 and rank < 8)
	return Res.rankColor4F[rank]
end

function Res.getEquipRankColor( rank )
	local list = {
		ccc4f(0.157, 1, 0.216, 1),
		ccc4f(0.5, 0.682, 1, 1),
		ccc4f(0.94, 0.49, 0.89, 1),
		ccc4f(1, 0.47, 0, 1),
		ccc4f(1, 0.8, 0.19, 1),
	}
	return list[rank] or Res.color4F.white
end

function Res.getRankColorByAwake( awakeIndex,bg)

	awakeIndex = Res.getFinalAwake(awakeIndex)
	if bg then
		return Res.rankColor4FInList[awakeIndex]
	end
	return Res.rankColor4F[awakeIndex]
	
end

function Res.getRankColorStrByAwake( awakeIndex )
	awakeIndex = Res.getFinalAwake(awakeIndex)

	return Res.RankColorStr[awakeIndex]
end

function Res.locString( k )
	assert(k and type(k) == "string","")
	local str = localize.getLanguage(k)
	if str and require 'AccountHelper'.isItemOFF('Vip') then
		str = string.gsub(str, 'VIP', localize.getLanguage('TS$VIPREP'))
		str = string.gsub(str, 'vip', localize.getLanguage('TS$VIPREP'))
	end
	return str
end

function Res.getDialogShowAction( delta ,callback)
	local actArray = CCArray:create()
	-- actArray:addObject(CCCallFunc:create(function ( ... )
	-- 	Res.setTouchDispatchEvents(false)
	-- end))
	actArray:addObject(CCHide:create())
	actArray:addObject(CCScaleTo:create(0, 0))
	actArray:addObject(CCShow:create())
	actArray:addObject(CCScaleTo:create(delta * 0.9, 1.2))
	actArray:addObject(CCScaleTo:create(delta * 0.1, 1))
	actArray:addObject(CCCallFunc:create(function ( ... )
		if callback then
			callback()
		end
	end))
	actArray:addObject(CCCallFunc:create(function ( ... )
		Res.setTouchDispatchEvents(true)
	end))
	return CCSequence:create(actArray)
end

function Res.getDialogHideAction( delta, callback )
	local actArray = CCArray:create()
	-- actArray:addObject(CCCallFunc:create(function ( ... )
	-- 	Res.setTouchDispatchEvents(false)
	-- end))
	actArray:addObject(CCScaleTo:create(delta * 0.1, 1.2))
	local arr = CCArray:create()
	arr:addObject(CCScaleTo:create(delta*0.9,0))
	arr:addObject(CCFadeOut:create(delta*0.9))
	actArray:addObject(CCSpawn:create(arr))
	actArray:addObject(CCCallFunc:create(function (  )
		callback()
	end))
	actArray:addObject(CCCallFunc:create(function ( ... )
		Res.setTouchDispatchEvents(true)
	end))
	return CCSequence:create(actArray)
end

function Res.getFadeAction( delta )
	local actArray = CCArray:create()
	actArray:addObject(CCFadeIn:create(delta))
	actArray:addObject(CCFadeOut:create(delta))
	return CCRepeatForever:create(CCSequence:create(actArray))
end

function Res.getScaleAction( scale )
	local actArray = CCArray:create()
	actArray:addObject(CCScaleTo:create(0.5, scale))
	actArray:addObject(CCScaleTo:create(0.5, 1))
	return CCRepeatForever:create(CCSequence:create(actArray))
end

function Res.getTintActionDuration( delta, r1, g1, b1, r2, g2, b2 )
	local actArray = CCArray:create()
	actArray:addObject(CCTintTo:create(delta, r1 * 255, g1* 255, b1* 255))
	actArray:addObject(CCTintTo:create(delta, r2 * 255, g2* 255, b2* 255))
	return CCRepeatForever:create(CCSequence:create(actArray))
end

function Res.doActionDialogShow( rootNode ,callback)
	rootNode:setVisible(false)
	Res.setTouchDispatchEvents(false)
	rootNode:runAction(Res.getDialogShowAction(0.2,callback))
end

function Res.doActionDialogHide( rootNode, target )
	if type(target) == "table" then
		Res.setTouchDispatchEvents(false)
		rootNode:runAction(Res.getDialogHideAction(0.2, function ( ... )
			target:close()
		end))
	elseif type(target) == "function" then
		Res.setTouchDispatchEvents(false)
		rootNode:runAction(Res.getDialogHideAction(0.2, target))
	end
end

function Res.doActionGetReward( reward )
	if reward then
		GleeCore:showLayer("DGetReward", reward)
	end
end

function Res.getGemIcon( gemId )
	return string.format("gems_%d.png", gemId)
end

function Res.getGemIconBg( lv )
	return string.format("PZ%d_bg.png", lv + 1)
end

function Res.getGemIconFrame( lv )
	return string.format("N_ZB_biankuang%d.png", math.max(lv - 1, 0))
end

function Res.getGemIconFrameWithLv( lv )
	return string.format("PZ%d_dengji.png", math.max(lv - 1, 0))
end

function Res.setGemDetail( node,gem,mosaic,needChoosIcon )
	node:removeAllChildrenWithCleanup(true)
	node:setResid(nil)
	local bg0 = ElfNode:create()
	local bg1 = ElfNode:create()
	if gem then
		local index = gem.Lv-1
		bg0:setResid(string.format("gems_%d.png",gem.GemId))
		-- bg0:setScale(140/96)
		bg1:setResid(string.format("N_ZB_biankuang%d.png",index))
	else
		bg0:setResid("N_ZB_xiangqian_xk.png")
		bg0:setScale(155/83)
		if needChoosIcon then
			local icon = ElfNode:create()
			icon:setResid("PZ_dianjixuanze.png")
			node:addChild(icon,3)
		end
	end
	node:addChild(bg0,1)
	node:addChild(bg1,2)
	-- if mosaic then
	-- 	local icon = ElfNode:create()
	-- 	icon:setScale(0.96)
	-- 	icon:setResid("xiangqian.png")
	-- 	node:addChild(icon,3)
	-- end
end

function Res.setItemDetail( node,item )
	print("setItemDetail----------")
	print(item)
	node:setResid(nil)
	node:removeAllChildrenWithCleanup(true)
	local bg0 = ElfNode:create()
	local bg1 = ElfNode:create()
	if item then
		bg0:setResid(string.format("material_%d.png",item.MaterialId))
		local color = dbManager.getInfoMaterial(item.MaterialId).color
		bg1:setResid(string.format("N_ZB_biankuang%d.png",color))
	end
	node:addChild(bg0,1)
	node:addChild(bg1,2)
	return node,bg0,bg1
end

function Res.setEquipIconNew( node,equipInfo,showAdd,runeList )
	node:removeAllChildrenWithCleanup(true)
	node:setResid(nil)
	local dbEquip
	local runeRootNode
	if equipInfo then
		dbEquip = dbManager.getInfoEquipment(equipInfo.EquipmentId)
		-- node:setResid(Res.getEquipIconBg(dbEquip))

		local nodeEquip = ElfNode:create()
		nodeEquip:setResid(Res.getEquipIcon(equipInfo.EquipmentId))
		node:addChild(nodeEquip, 1)

		if require "UnlockManager":isOpen("Rune") and require "Toolkit".isRuneMosaicEnable(dbEquip.location) and require "UnlockManager":isUnlock("GuildCopyLv") then
			runeRootNode = ElfNode:create()
			node:addChild(runeRootNode,2)
			runeRootNode:setScale(0.25)
			runeRootNode:setPosition(ccp(35.0,-35.0))
			local runes = runeList or require "RuneInfo".selectByCondition(function ( v )
				return v.SetIn>0 and v.SetIn == equipInfo.Id
			end)
			Res.setNodeWithRuneSetIn( runeRootNode, runes )
		end
	else
		node:setResid(Res.getEquipIconBg(nil))

		-- local nodeBase = ElfNode:create()
		-- nodeBase:setResid(Res.getEquipIconBgWithLocation(location))
		-- node:addChild(nodeBase, 2)

		if showAdd then
			local nodePet = ElfNode:create()
			nodePet:setResid("PZ_dianjixuanze.png")
			nodePet:setScale(1.5)
			node:addChild(nodePet, 3)	
		end	
	end

	local nodeFrame = ElfNode:create()
	-- nodeFrame:setScale(1.1)
	nodeFrame:setResid(string.format("N_ZB_biankuang%d.png",dbEquip and dbEquip.color or 0))
	node:addChild(nodeFrame, 4)
	return node,nodeEquip,nodeFrame,runeRootNode
end

function Res.setEquipDetail( node,equipInfo,showAdd,runeList )
	return Res.setEquipIconNew(node,equipInfo,showAdd,runeList)
end

function Res.setPetDetail( node,petInfo,isFrag )
	node:removeAllChildrenWithCleanup(true)
	node:setResid(Res.getPetIconBg(petInfo))
	if petInfo then
		local nodePet = ElfNode:create()
		nodePet:setResid(Res.getPetIcon(petInfo.PetId))
		nodePet:setScale(140/95)
		node:addChild(nodePet, 1)

		if isFrag then
			local frag = ElfNode:create()
			frag:setResid("N_TY_suipian.png")
			frag:setPosition(ccp(-42.5,-41.25))
			node:addChild(frag, 4)
		end	
	else
		local nodePet = ElfNode:create()
		nodePet:setResid("JL_touxiang.png")
		node:addChild(nodePet, 1)	

		-- if showAdd then
		-- 	local nodePet = ElfNode:create()
		-- 	nodePet:setResid("PZ_dianjixuanze.png")
		-- 	nodePet:setPosition(ccp(27.142853,-28.571434))
		-- 	node:addChild(nodePet, 2)	
		-- end
	end
	local nodeFrame = ElfNode:create()
	nodeFrame:setResid(Res.getPetIconFrame(petInfo))
	node:addChild(nodeFrame, 3)
end

function Res.getMaterialIcon( materialId )
	if materialId >= 24 and materialId <= 39 then	-- vip0 ~ vip15
		materialId = 24
	end
	return string.format("material_%d.png", materialId)
end

function Res.getPetIcon( petId )
	return string.format("card_%03d.png", petId)
end

function Res.getPetCareerIcon( career )
	local careerTable = {"zhanshi.png", "tanke.png", "dps.png", "zhiliao.png"}
	return careerTable[career]
end

function Res.getPetCareerIconEvolve( career )
	local careerTable = {"zhanshi_jinhua.png", "tanke_jinhua.png", "dps_jinhua.png", "zhiliao_jinhua.png"}
	return careerTable[career]
end

function Res.getPetCareerName( career )
	return Res.locString(string.format("Global$Career%d", career))
end

function Res.getPetPropertyIcon( property ,flag)
	if not flag then
		return nil
	end
	local proTable = {"bing1.png", "cao2.png", "dian3.png", "du4.png", "gedou5.png", "shui6.png", "yanshi7.png", "huo8.png", "yiban9.png"}
	return proTable[property]
end

function Res.getPetPropertyIconEvolve( property ,flag)
	if not flag then
		return nil
	end
	local proTable = {"none", "cao2_jinhua.png", "dian3_jinhua.png", "none", "none", "shui6_jinhua.png", "yanshi7_jinhua.png", "huo8_jinhua.png", "none"}
	return proTable[property]
end

function Res.getPetIconFrame( nPet )
	if nPet then
		local awakeIndex = Res.getFinalAwake(nPet.AwakeIndex)
		return string.format("N_ZB_biankuang%d.png", math.max(awakeIndex -1, 0))
	else
		return "N_ZB_biankuang0.png"
	end
end

function Res.getPetIconFrameWithLv( nPet )
	if nPet then
		local awakeIndex = Res.getFinalAwake(nPet.AwakeIndex)
		return string.format("PZ%d_dengji.png", math.max(awakeIndex -1, 0))
	else
		return "N_ZB_biankuang0.png"
	end
end

function Res.getPetIconBgByAwakeIndex( awakeIndex )
	awakeIndex = Res.getFinalAwake(awakeIndex)
	return string.format("PZ%d_bg.png", awakeIndex+1)	
end

function Res.getPetIconFrameByAwakeIndex( awakeIndex )
	awakeIndex = Res.getFinalAwake(awakeIndex)

	return string.format("PZ%d.png", awakeIndex+1) 
end

function Res.getEquipIconBg( dbEquip )
	-- if dbEquip then
	-- 	return string.format("PZ%d_bg.png", dbEquip.color + 1)
	-- else
	-- 	return "PZ0_bg.png"
	-- end
	return "N_ZB_biankuang_bg.png"
end

function Res.getEquipIconFrameWithLv( dbEquip )
	if dbEquip then
		return string.format("PZ%d_dengji.png", dbEquip.color)
	else
		return "N_ZB_biankuang0.png"
	end
end

function Res.getEquipIconFrame( dbEquip )
	return string.format("N_ZB_biankuang%d.png",dbEquip and dbEquip.color or 0)
end

function Res.getEquipIconBgByColor(color)
	return string.format('PZ%d_bg.png',color)
end

function Res.getEquipPZByColor( color )
	return string.format('PZ%d.png',color)
end

function Res.setPet( node, petId )
	node:removeAllChildrenWithCleanup(true)
	node:setResid("touxiangkuang2.png")

	if petId > 0 then
		local nodePet = ElfNode:create()
		nodePet:setResid(Res.getPetIcon(petId))
		node:addChild(nodePet, 2)
	end
	
	local nodeFrame = ElfNode:create()
	nodeFrame:setResid("touxiangkuang1.png")
	node:addChild(nodeFrame, 3)
end

function Res.getPetBg( awakeIndex )
	awakeIndex = Res.getFinalAwake(awakeIndex)
	local bgTable = {"JLLB_RWPZ_bai.png", "JLLB_RWPZ_lv.png", "JLLB_RWPZ_lan.png", "JLLB_RWPZ_zi.png", "JLLB_RWPZ_cheng.png",'JLLB_RWPZ_jin.png','JLLB_RWPZ_hong.png'}
	return bgTable[awakeIndex]
end

function Res.getPetFrame( awakeIndex )
	awakeIndex = Res.getFinalAwake(awakeIndex)
	local frameTable = {"JLLB_RWPZ_baifaguang.png", "JLLB_RWPZ_lvfaguang.png", "JLLB_RWPZ_lanfaguang.png", "JLLB_RWPZ_zifaguang.png", "JLLB_RWPZ_chengfaguang.png","JLLB_RWPZ_jinfaguang.png","JLLB_RWPZ_hongfaguang.png"}
	return frameTable[awakeIndex]
end

function Res.getPetNameBg( awakeIndex )
	awakeIndex = Res.getFinalAwake(awakeIndex)
	local nameBgTable = {"JLLB_MZK_bai.png", "JLLB_MZK_lv.png", "JLLB_MZK_lan.png", "JLLB_MZK_zi.png", "JLLB_MZK_cheng.png",'JLLB_MZK_jin.png','JLLB_MZK_hong.png'}
	return nameBgTable[awakeIndex]
end

function Res.getPetWithPetId( petId )
	return string.format("role_%03d.png", petId)
end

function Res.getPetChummyText( intimacy )
	local table = require 'MacyTypeConfig'
	for k,v in pairs(table) do
		if v.MacyFloor <= intimacy and v.MacyCeiling > intimacy or (20 == v.MacyCeiling and 20 == intimacy) then
		  return v.Name
		end
	end
end

function Res.getAwakeDesText( awakeIndex )
	return Res.locString(string.format("PetDetail$Awake%d", awakeIndex))
end

function Res.getEquipQuality( color )
	return Res.locString(string.format("Global$Quality%d", color))
end

function Res.getEquipFitText( location )
	return Res.locString(string.format("Equip$EquipType%d", location))
end

function Res.getEquipRankText( rank )
	return Res.locString(string.format("Equip$Rank%d", rank))
end

function Res.getEquipRankTextSimple( rank )
	return Res.locString(string.format("Equip$RankSimple%d", rank))
end

function Res.getEquipIcon( dbEquipId )
	return string.format("ZB%d.png", dbEquipId)
end


function Res.getEquipIconByID( id )
	return string.format("ZB%d.png", id)
end
function Res.getEquipIconWithId( equipmentId )
	return string.format("ZB%d.png", equipmentId)
end

function Res.getEquipEffectText( location )
	return Res.locString(string.format("Equip$EffectText%d", location))
end

function Res.setEquip( node, equipmentId)
	node:removeAllChildrenWithCleanup(true)
	node:setResid("wuzhuangbeidi.png")

	if equipmentId > 0 then
		local nodeEquip = ElfNode:create()
		nodeEquip:setResid(string.format("ZB%d.png", equipmentId))
		nodeEquip:setScale(0.4)
		node:addChild(nodeEquip, 2)
	end

	local nodeFrame = ElfNode:create()
	nodeFrame:setResid("baoshikuang.png")
	node:addChild(nodeFrame, 3)
end

function Res.setIconGeneral( node, picList )
	node:removeAllChildrenWithCleanup(true)
	node:setResid("")
	local zOrder = 1
	if picList then
		for i,v in ipairs(picList) do
			local nodeTemp = ElfNode:create()
			nodeTemp:setResid(v)
			node:addChild(nodeTemp, zOrder)
			zOrder = zOrder + 1
		end
	end
end

function Res.getEquipIconBgWithLocation( location )
	local locationIconBg = {"N_ZB_wuqi.png", "N_ZB_jiezhi.png", "N_ZB_xianglian.png", "N_ZB_toukui.png", "N_ZB_yifu.png", "N_ZB_xiezi.png"}
	return locationIconBg[location]
end

function Res.getTeamIndexText( index )
	return Res.locString(string.format("Team$TeamIndex%d", index))
end

function Res.getTimeText( minute )
	local text
	if minute < 15 then
		text = Res.locString("Friend$Time1")
	elseif minute < 30 then
		text = Res.locString("Friend$Time2")
	elseif minute < 60 then
		text = Res.locString("Friend$Time3")	
	elseif minute < 60 * 24 then
		text = string.format(Res.locString("Friend$Time4"), minute / 60)
	else
		text = string.format(Res.locString("Friend$Time5"), minute / (60 * 24) )
	end
	return text
end

function Res.getDropRateText( rate )
	if rate >= 0.1 then
		return Res.locString("Dungeon$DropRate1")
	elseif rate >= 0.05 then
		return Res.locString("Dungeon$DropRate2")
	elseif rate >= 0.01 then
		return Res.locString("Dungeon$DropRate3")
	else
		return Res.locString("Dungeon$DropRate4")
	end
end

function Res.getStarResid( MotiCnt )
	return 'XX_jin.png'
	-- if MotiCnt < 90 then
	-- 	return 'XX_bai.png'
	-- elseif MotiCnt >= 90 and MotiCnt < 120 then
	-- 	return 'XX_tong.png'
	-- elseif MotiCnt >= 120 and MotiCnt < 150 then
	-- 	return 'XX_yin.png'
	-- elseif MotiCnt >= 150 then
	-- 	return 'XX_jin.png'
	-- end	
end

-- Res.MaterialResIDs = 
-- {
	-- [1]='JLXQ_QL_qianlishi.png',
	-- [4]='QM_tubiao1.png',
	-- [5]='JLXQ_JC_guoshi1_1.png',
	-- [6]='JLXQ_JC_guoshi2_1.png',
	-- [7]='JLXQ_JC_guoshi3_1.png',
	-- [26]='JLXQ_JX_tubiao1.png'
-- }

function Res.getSoulImageName( ... )
	return "get_petsoul.png"
end

function Res.getMaterialIconBg( color )
	return string.format('N_PZ%d_bg.png',color)
	-- return string.format("PZ%d_bg.png", color + 2)
end

function Res.getMaterialIconFrame( color )
	return string.format("N_ZB_biankuang%d.png", color)
end

function Res.getEquipTypeRes( eType )
	if eType == 1 then
		return "N_ZBSJ_wuqi.png"
	elseif eType == 2 then
		return "N_ZBSJ_jiezhi.png"
	elseif eType == 3 then
		return "N_ZBSJ_xianglian.png"
	elseif eType == 4 then
		return "N_ZBSJ_toukui.png"
	elseif eType == 5 then
		return "N_ZBSJ_yifu.png"
	elseif eType == 6 then
		return "N_ZBSJ_xiezi.png"
	end
end

function Res.getMibaoTypeRes( mibaoType )
	if mibaoType == 1 then
		return "N_ZBSJ_yueqi.png"
	elseif mibaoType == 2 then
		return "N_ZBSJ_yaodai.png"
	end
end

function Res.Split(szFullString, szSeparator)
  local nFindStartIndex = 1
  local nSplitIndex = 1
  local nSplitArray = {}
  while true do
	  local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
	  if not nFindLastIndex then
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
		break
	  end
	  nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
	  nFindStartIndex = nFindLastIndex + string.len(szSeparator)
	  nSplitIndex = nSplitIndex + 1
  end
  
  return nSplitArray
end

function Res.goldToString( num )

	local H = num%1000
	local K = math.floor(num/1000)%1000
	local M = math.floor(num/1000000)
	  
	if M > 0 then
		return string.format('%d.%dM',M,math.floor(K/100))
	elseif K > 0 then
		return string.format('%d.%dK',K,math.floor(H/100))
	end

	return tostring(num)
end

function Res.getPetLvWithExp(level, expValue )
	local petLvConfig = require "PetLvConfig"
	local sum = 0
	for i,v in ipairs(petLvConfig) do
		if v.Lv >= level then
			sum = sum + v.Exp
		end
		if sum > expValue then
			return v.Lv
		end
	end
end

function Res.getTrainTypeColor( trainType )
	local t = {Res.color4F.white, ccc4f(0.5529,  0.9686, 0.2588, 1.0), Res.color4F.blue, ccc4f(0.654902,0.08627451,0.6666667,1.0), Res.color4F.orange}
	return t[trainType]
end

function Res.getMaterialColor( color )
	local t = {Res.color4F.green, Res.color4F.blue, Res.color4F.purple, Res.color4F.orange}
	return t[color]
end

function Res.getPlayerTitle( titleId )
	local dbtitle = require 'DBManager'.getTrainTitle(require "AppData".getUserInfo().getTitleID())
	return string.format("XL_%d.png", dbtitle.titlelv)
end

function Res.getAbilityUnlockCount( awakeIndex ,star)
	local dbtmp = dbManager.getAwake(awakeIndex,star)
	unlockcount = 0
	if dbtmp then
		unlockcount = dbtmp.unlockcount
	end
	return unlockcount
end

function Res.getVipIcon( vipLevel )
	if require 'AccountHelper'.isItemOFF('Vip') then
		return nil
	end
	return string.format("vip%d.png", vipLevel)
end


function Res.adjustPosition( config,node,location)

	if node and config and location then
		
		local key = location ~= nil and location..'_' or ''	
		local scalekey = string.format('%sscale',key)
		local xkey = string.format('%sx',key)
		local ykey = string.format('%sy',key)

		node:setScaleX(config[scalekey])
		node:setScaleY(math.abs(config[scalekey]))
		local posx,posy = node:getPosition()
		node:setPosition(posx+tonumber(config[xkey]),posy-tonumber(config[ykey]))
	end

end

--[[
	node : elfNode
	petId : 指定精灵的PetID
	location: troop|list|mainpage|head|academy|chat|limited
]]
function Res.adjustPetIconPosition( node,petId,location)

	if node and petId then
		node:setResid(Res.getPetWithPetId(petId))
		local config = Res.getPetPositionConfig(petId,location)
		Res.adjustPosition(config,node,location)
	end

end

--[[
	node:elfNode
	anchor:position(x,y)
]]

function Res.getNodePosition( node,anchor )
	
	if node then
		local size = node:getContentSize()
		return (size.width*anchor.x-size.width/2),(size.height*anchor.y-size.height/2)
	end

end

function Res.getPetPositionConfig( petId,location )
	local config = dbManager.getBattleCharactor(petId)
	local key = location ~= nil and location..'_' or ''	
	local scalekey = string.format('%sscale',key)
	if config and config[scalekey] ~= 0 then
		return config
	end
	return nil
end

function Res.adjustPetIconPositionInParentLT( parent,node,petId,location,offsetx,offsety )
	
	if node and petId and parent then
		node:setResid(Res.getPetWithPetId(petId))
		local config = Res.getPetPositionConfig(petId,location)
		
		if config then
			local ltx,lty = Res.getNodePosition(parent,{x=0,y=1})
			ltx = ltx + (offsetx or 0)
			lty = lty + (offsety or 0)
			node:setPosition(ltx,lty)
			Res.adjustPosition(config,node,location)
		end
	end

end

function Res.getTaskLoginVipIcon( vip )
	return string.format("N_QD_VIP%d.png", vip)
end

--[[
type:
	1.金币
	2.钻石
	3.精灵之魂
	4.体力
	5.经验
	6.精灵 --table
	7.装备 --table
	8.宝石 --table
	9.道具 --table
itemid: 对应在数据表中的 id
args:额外参数

reutrn: 
	name,
	resid={[1]=pzbg,[2]=icon,[3]=pz}
	pzindex 0~7
]]
function Res.getRewardStrAndResId( Type,itemid,args)
	
	local str,resid,pzindex
	pzindex = 1
	resid = {}
	if Type == 1 then
		resid[2] = 'TY_jinbi_da.png'
		str = Res.locString('Global$Gold')
	elseif Type == 2 then
		resid[2] = 'TY_jinglingshi_da.png'
		str = Res.locString('Global$SpriteStone')
	elseif Type == 3 then
		resid[2] = Res.getSoulImageName()
		str = Res.locString('PetFoster$SOUL')
	elseif Type == 6 then
		local dbpet = dbManager.getCharactor(itemid)
		resid[2] = Res.getPetIcon(itemid)
		str = dbpet.name
		resid[1] = Res.getPetIconBg()
		resid[3] = Res.getPetPZ(0)
		pzindex = 0
	elseif Type == 7 then
		local dbequip = dbManager.getInfoEquipment(itemid)
		resid[2] = Res.getEquipIconByID(itemid)
		str = dbequip.name
		resid[1] = Res.getEquipIconBg(dbequip)
		resid[3] = Res.getEquipIconFrame(dbequip)
		pzindex = dbequip.color+1
	elseif Type == 8 then

		local dbgem = dbManager.getInfoGem(itemid)
		str = dbgem.name
		if args and args[1] then
			resid[1] = Res.getGemPZBG(args[1])
			resid[2] = Res.getGemIcon(itemid)
			resid[3] = Res.getGemPZ(args[1])
			pzindex = args[1]
			str = string.format('%s',str,args[1])
		end

	elseif Type == 9 then
		local dbm = dbManager.getInfoMaterial(itemid)
		pzindex = dbm.color+1
		resid[1] = Res.getMaterialIconBg(dbm.color)
		resid[2] = Res.getMaterialIcon(itemid)
		resid[3] = Res.getMaterialIconFrame(dbm.color)
		resid[4] = true
		str = dbm.name
	elseif Type == 10 then
		local dbpet = dbManager.getCharactor(itemid)
		str = string.format(Res.locString('Pet$Piece'),dbpet.name)
		resid[2] = Res.getPetIcon(itemid)
		resid[1] = Res.getPetIconBg()
		resid[3] = Res.getPetPZ(0)
		pzindex = 1
	end
	
	return str,resid,pzindex

end

function Res.getGemPZBG( lv )
	return 'N_ZB_biankuang_bg.png'
end

function Res.getGemPZ( lv )
	local index = lv-1
	return string.format("N_ZB_biankuang%d.png",index)
end

--[[
用于一些颜色的显示 0阶与1阶共用
]]
function Res.getFinalAwake( awakeIndex )
	assert(awakeIndex)

	awakeIndex = math.floor(awakeIndex/4)
	return awakeIndex+1

end

--[[
精灵实际的觉醒阶数
]]
function Res.getRealAwake( awakeIndex )
	assert(awakeIndex)
	if awakeIndex > 0 then
		awakeIndex = math.floor(awakeIndex/4)
		return awakeIndex + 1
	end
	return awakeIndex
end

function Res.getPetNameWithSuffix( nPet )
	local dbPet = dbManager.getCharactor(nPet.PetId)
	local suffix = nPet.AwakeIndex%4
	local name = dbPet.name
	if suffix ~= 0 then
		name = string.format('%s+%d',name,suffix)
	end
	return name

end


--[[
获取rewards 对应的界面可用元素 如物品名字 图片名 品质
return {
	{name=,resid={[1]=pzbg,[2]=icon,[3]=pz},pzindex,orgdata,typename}	
}
]]
function Res.getRewardsNRList( reward )
	
	local list = {}
	local ktemp = table.clone(reward)
	if reward then
		local tmp 

		tmp = Res.getNRHonor(reward.Honor)
		if tmp then table.insert(list,tmp) end
		ktemp.Honor = nil

		tmp = Res.getNRAp(reward.Ap)
		if tmp then table.insert(list,tmp) end
		ktemp.Ap = nil

		tmp = Res.getNRGold(reward.Gold)
		if tmp then table.insert(list,tmp) end
		ktemp.Gold = nil

		tmp = Res.getNRSoul(reward.Soul)
		if tmp then table.insert(list,tmp) end
		ktemp.Soul = nil

		tmp = Res.getNRExp(reward.Exp)
		if tmp then table.insert(list,tmp) end
		ktemp.Exp = nil

		tmp = Res.getNRCoin(reward.Coin)
		if tmp then table.insert(list,tmp) end
		ktemp.Coin = nil

		if reward.Equipments and type(reward.Equipments) == 'table' then
			for i,v in ipairs(reward.Equipments) do
				tmp = Res.getNREquipment(v)
				if tmp then table.insert(list,tmp) end				
			end
		end
		ktemp.Equipments = nil

		if reward.Gems and type(reward.Gems) == 'table' then
			for i,v in ipairs(reward.Gems) do
				tmp = Res.getNRGem(v)
				if tmp then table.insert(list,tmp) end
			end
		end
		ktemp.Gems = nil

		if reward.Pets and type(reward.Pets) == 'table' then
			for i,v in ipairs(reward.Pets) do
				tmp = Res.getNRPet(v)
				if tmp then table.insert(list,tmp) end
			end
		end
		ktemp.Pets = nil

		if reward.Materials and type(reward.Materials) == 'table' then
			for i,v in ipairs(reward.Materials) do
				tmp = Res.getNRMaterial(v)
				if tmp then table.insert(list,tmp) end
			end
		end
		ktemp.Materials = nil

		if reward.PetPieces and type(reward.PetPieces) == 'table' then
			for i,v in ipairs(reward.PetPieces) do
				tmp = Res.getNRPetPiece(v)
				if tmp then table.insert(list,tmp) end
			end
		end
		ktemp.PetPieces = nil

		if reward.Mibaos and type(reward.Mibaos) == 'table' then
			for i,v in ipairs(reward.Mibaos) do
				tmp = Res.getNRMibao(v)
				if tmp then table.insert(list,tmp) end
			end
		end
		ktemp.Mibaos = nil

		if reward.MibaoPieces and type(reward.MibaoPieces) == 'table' then
			for i,v in ipairs(reward.MibaoPieces) do
				tmp = Res.getNRMibaoPiece(v)
				if tmp then table.insert(list,tmp) end
			end
		end
		ktemp.MibaoPieces = nil

		if reward.Runes and type(reward.Runes) == 'table' then
			for i,v in ipairs(reward.Runes) do
				tmp = Res.getNRRune(v)
				if tmp then table.insert(list,tmp) end
			end
		end
		ktemp.Runes = nil

		-- Packs
		local reslist = Res.getRewardResList(ktemp)
		for i,v in ipairs(reslist) do
			local tmp = {}
			tmp.resid={}

			tmp.name = v.name
			tmp.typename = v.type
			tmp.resid[1] = v.bg
			tmp.resid[2] = v.icon
			tmp.resid[3] = v.frame
			tmp.pzindex = 1
			tmp.orgdata = v.orgdata
			tmp.isPiece = v.isPiece
			tmp.amount = v.count
			if v.eventData then
				tmp.showfunc = function ( ... )
					GleeCore:showLayer(v.eventData.dialog,v.eventData.data)
				end
			end
			table.insert(list,tmp)
		end

	end
	return list

end

function Res.getNRHonor( Honor )

	local tmp 
	if Honor and Honor > 0 then
		tmp = {}
		tmp.name = Res.locString('Global$Honor')
		tmp.resid={}
		tmp.resid[2] = ''
		tmp.pzindex = 1
		tmp.orgdata = Honor
		tmp.typename = 'Honor'
		tmp.amount = Honor
	end
	return tmp

end

function Res.getNRAp( Ap )

	local tmp 
	if Ap and Ap > 0 then
		tmp = {}
		tmp.name = Res.locString('InstanceDungeon$AP')
		tmp.resid = {}
		tmp.resid[2] = ''
		tmp.pzindex = 1
		tmp.orgdata = Ap
		tmp.typename = 'Ap'
		tmp.amount = Ap
	end
	return tmp

end

function Res.getNRGold( Gold )

	local tmp 
	if Gold and Gold > 0 then
		tmp = {}
		tmp.name = Res.locString('Global$Gold')
		tmp.resid = {}
		tmp.resid[2] = 'TY_jinbi_da.png'
		tmp.pzindex = 1
		tmp.orgdata = Gold
		tmp.typename = 'Gold'
		tmp.amount = Gold
	end
	return tmp

end

function Res.getNRSoul( Soul )
	
	local tmp 
	if Soul and Soul > 0 then
		tmp = {}
		tmp.name = Res.locString('PetFoster$SOUL')
		tmp.resid = {}
		tmp.resid[2] = Res.getSoulImageName()
		tmp.pzindex = 1
		tmp.orgdata = Soul
		tmp.typename = 'Soul'
		tmp.amount = Soul
	end
	return tmp

end

function Res.getNRExp( Exp )

	local tmp 
	if Exp and Exp > 0 then
		tmp = {}
		tmp.name = Res.locString('Global$Exp')
		tmp.resid = {}
		tmp.resid[2] = ''
		tmp.pzindex = 1
		tmp.orgdata = Exp
		tmp.typename = 'Exp'
		amp.amount = Exp
	end
	return tmp

end

function Res.getNRCoin( Coin )
	
	local tmp 
	if Coin and Coin > 0 then
		tmp = {}
		tmp.name = Res.locString('Global$SpriteStone')
		tmp.resid = {}
		tmp.resid[2] = 'TY_jinglingshi_da.png'
		tmp.pzindex = 1
		tmp.orgdata = Coin
		tmp.typename = 'Coin'
		tmp.amount = Coin
	end
	return tmp

end

function Res.getNREquipment( Equipment )

	local tmp 
	if Equipment then
		tmp = {}
		local dbequip = dbManager.getInfoEquipment(Equipment.EquipmentId)
		tmp.resid = {}
		tmp.resid[2] = Res.getEquipIconByID(Equipment.EquipmentId)
		tmp.resid[1] = Res.getEquipIconBg(dbequip)
		tmp.resid[3] = Res.getEquipIconFrame(dbequip)
		tmp.name = dbequip.name
		tmp.pzindex = dbequip.color+1
		tmp.orgdata = Equipment
		tmp.typename = 'Equipment'
		tmp.amount = Equipment.Amount
		tmp.showfunc = function ( ... )
			-- GleeCore:showLayer("DEquipInfoWithNoGem", {EquipInfo = Equipment})
			local equip = require 'AppData'.getEquipInfo().getEquipInfoByEquipmentID(Equipment.EquipmentId)
			for k,v in pairs(Equipment) do
				equip[k] = v
			end
			GleeCore:showLayer("DEquipDetail",{nEquip = equip})
		end
	end
	return tmp

end

function Res.getNRGem( Gem )
	
	local tmp 
	if Gem then
		tmp = {}
		local dbgem = dbManager.getInfoGem(Gem.GemId)
		tmp.name = string.format('%s',dbgem.name,Gem.Lv)
		tmp.resid = {}
		tmp.resid[1] = Res.getGemPZBG(Gem.Lv)
		tmp.resid[2] = Res.getGemIcon(Gem.GemId)
		tmp.resid[3] = Res.getGemPZ(Gem.Lv)
		
		tmp.pzindex = Gem.Lv
		tmp.orgdata = Gem
		tmp.typename = 'Gem'
		tmp.amount = Gem.Amount
		tmp.showfunc = function ( ... )
			GleeCore:showLayer("DGemDetail",{GemInfo=Gem,ShowOnly = true})
		end
	end
	return tmp

end

function Res.getNRPet( Pet )
	
	local tmp 
	if Pet then
		tmp = {}
		local dbpet = dbManager.getCharactor(Pet.PetId)
		tmp.name = dbpet.name
		tmp.resid = {}
		tmp.resid[2] = Res.getPetIcon(Pet.PetId)
		tmp.resid[1] = Res.getPetIconBg()
		tmp.resid[3] = Res.getPetPZ(0)
		tmp.pzindex = 1
		tmp.orgdata = Pet
		tmp.typename = 'Pet'
		tmp.amount = Pet.Amount
		tmp.showfunc = function ( ... )
			GleeCore:showLayer("DPetDetailV", {PetInfo=Pet})
		end
	end
	return tmp

end

function Res.getNRMaterial( Material )
	
	local tmp 
	if Material then
		tmp = {}
		local dbm = dbManager.getInfoMaterial(Material.MaterialId)
		tmp.name = dbm.name
		tmp.pzindex = dbm.color+1
		tmp.resid = {}
		tmp.resid[2] = Res.getMaterialIcon(Material.MaterialId)
		tmp.resid[1] = Res.getMaterialIconBg(dbm.color)
		tmp.resid[3] = Res.getMaterialIconFrame(dbm.color)
		tmp.orgdata = Material
		tmp.typename = 'Material'
		tmp.amount = Material.Amount
		tmp.showfunc = function ( ... )
			GleeCore:showLayer('DMaterialDetail',{materialId=Material.MaterialId})
		end
	end
	return tmp

end

function Res.getNRPetPiece( PetPiece )
	
	local tmp 
	if PetPiece then
		tmp = {}
		local dbpet = dbManager.getCharactor(PetPiece.PetId)
		tmp.name = string.format(Res.locString('Pet$Piece'),dbpet.name)
		tmp.resid = {}
		tmp.resid[2] = Res.getPetIcon(PetPiece.PetId)
		tmp.resid[1] = Res.getPetIconBg()
		tmp.resid[3] = Res.getPetPZ(0)
		tmp.pzindex = 1
		tmp.orgdata = PetPiece
		tmp.typename = 'PetPiece'
		tmp.isPiece = true
		tmp.amount = PetPiece.Amount
		tmp.showfunc = function ( ... )
			GleeCore:showLayer('DPetDetailV',{PetInfo=require 'AppData'.getPetInfo().getPetInfoByPetId(PetPiece.PetId)})
		end
	end
	return tmp

end

function Res.getNRMibao( Mibao )
 	local tmp 
 	if Mibao then
 		local dbTreasure = dbManager.getInfoTreasure(Mibao.MibaoId)
 		tmp = {}
 		tmp.typename = 'Mibao'
 		tmp.resid = {}
 		tmp.resid[2] =  string.format("mibao_%d.png", Mibao.MibaoId)
		tmp.resid[3] = string.format("N_ZB_biankuang%d.png", math.max(dbTreasure.Star - 1, 1))
		tmp.pzindex = 1
		tmp.name = dbTreasure.Name
		tmp.amount = Mibao.Amount
		tmp.orgdata = Mibao
		tmp.showfunc = function ( ... )
			GleeCore:showLayer("DMibaoDetail", {Data = require 'AppData'.getMibaoInfo().getMibaoWithDB(Mibao.MibaoId)})
		end
 	end
 	return tmp
end 

function Res.getNRMibaoPiece( MibaoPiece )
 	local tmp 
 	if MibaoPiece then
 		local dbTreasure = dbManager.getInfoTreasure(MibaoPiece.MibaoId)
 		tmp = {}
 		tmp.typename = 'Mibao'
 		tmp.resid = {}
 		tmp.resid[2] =  string.format("mibao_%d.png", MibaoPiece.MibaoId)
		tmp.resid[3] = string.format("N_ZB_biankuang%d.png", math.max(dbTreasure.Star - 1, 1))
		tmp.pzindex = 1
		-- tmp.name = dbTreasure.Name .. Res.locString("Global$Fragment")
		tmp.name = Res.concatStringWithLang(dbTreasure.Name, Res.locString("Global$Fragment"))
		tmp.amount = MibaoPiece.Amount
		tmp.orgdata = MibaoPiece
		tmp.isPiece = true
		tmp.showfunc = function ( ... )
			GleeCore:showLayer("DMibaoDetail", {Data = require 'AppData'.getMibaoInfo().getMibaoWithDB(MibaoPiece.MibaoId)})
		end
 	end
 	return tmp
end 

function Res.getNRRune( Rune )
 	local tmp 
 	if Rune then
 		local RuneBgResMap = {[1] = 1,[2] = 4,[3] = 2,[4] = 5,[5] = 6}
 		local dbRune = dbManager.getInfoRune(Rune.RuneId)
 		tmp = {}
 		tmp.typename = 'Rune'
 		tmp.resid = {}
 		tmp.resid[1] = string.format("N_PZ%d_bg.png",RuneBgResMap[math.floor(Rune.RuneId/10)])
 		tmp.resid[2] = string.format("rune-%d.png",Rune.RuneId)
		tmp.resid[3] = string.format("N_ZB_biankuang%d.png",Rune.Lv/3)
		tmp.name = require 'Toolkit'.getRuneName( Rune.RuneId,Rune.Lv)
		tmp.amount = Rune.Amount
		tmp.orgdata = Rune
		tmp.pzindex = 1
		tmp.showfunc = function ( ... )
			GleeCore:showLayer("DRuneDetail", { RuneData = require 'RuneInfo'.getRuneWithDB(Rune.RuneId,Rune.Star,Rune.Lv)})
		end
 	end
 	return tmp
end

function Res.getActiveItemIconBg( ... )
	return "PZ6_bg.png"
end

function Res.getActiveItemIcon( ... )
	return "material_40.png"
end

function Res.getActiveItemIconFrame( ... )
	return "N_ZB_biankuang4.png"
end

function Res.toastReward( reward )
	if reward then
		local msgList = require "AppData".getRewardStringList(reward)
		if msgList and #msgList > 0 then
			local msg = Res.locString("Bag$ToastReardGet") .. table.concat(msgList, ", ")
			print(msg)
			require 'UIHelper'.toast2(msg)
		end
	end
end

function Res.getGoldFormat( gold,limit )
	limit = limit or 10000000
	if gold >= limit then
		return string.format("%dk", gold / 1000)
	else
		return tostring(gold)
	end
end

function Res.getExpFormat( exp )
	if exp >= 100000 then
		return string.format("%dk", exp / 1000)
	else
		return tostring(exp)
	end
end

function Res.getTransitionFadeDelta(  )
	return 0.4
end

function Res.getTransitionFade( ... )
	local TransitionFactory = require 'framework.transition.TransitionFactory'
	return TransitionFactory:getTransition(Res.getTransitionFadeDelta(), TransitionFactory.Type.tFadeOutIn) 
end

function Res.doEventAddAP(  )
	local breadId = 21
	local gameFunc = require "AppData"
	local showAddAp = false
	if not gameFunc.getBagInfo().getItemWithItemId(breadId) then	
		local limitCount
		local dbMaterial = dbManager.getInfoMaterial(breadId)
		if dbMaterial.islimit > 0 then
			local mlimitsText = dbManager.getVipInfo(gameFunc.getUserInfo().getVipLevel()).MLimits
			local limitList = string.split(mlimitsText, "|")
			for k,v in pairs(limitList) do
				local key, value = string.match(v, "(%d+)-(%d+)")
				if tonumber(key) == dbMaterial.materialid then
					limitCount = tonumber(value)
					break
				end
			end
			if limitCount then
				limitCount = math.max(limitCount - gameFunc.getItemMallInfo().getBuyRecordDm(dbMaterial.materialid), 0)
			end
		end
		if limitCount and limitCount == 0 then
			local param = {}
			param.title = Res.locString("AP$Title")
			param.content = Res.locString("Stage$TodayBuyApLimitTip")
			param.tip = Res.locString("VIP$BetterVip")
			param.RightBtnText = Res.locString("Global$BtnRecharge")
			param.callback = function ( ... )
				GleeCore:showLayer("DRecharge")
			end
			GleeCore:showLayer("DResetNotice", param)	
		else
			showAddAp = true
		end
	else
		showAddAp = true
	end
	if showAddAp then
		local netModel = require "netModel"
		local bagFunc = gameFunc.getBagInfo()
		local itemMallFunc = gameFunc.getItemMallInfo()
		local dbMaterial = dbManager.getInfoMaterial(breadId)
		local iBread = bagFunc.getItemWithItemId(breadId)
		local apCount = dbManager.getReward(dbMaterial.effects[1])[1].amount
		
		local param = {}
		param.title = Res.locString("AP$Title")
		param.RightBtnText = Res.locString("Global$Use")
		if iBread then
			param.content = string.format(Res.locString("AP$Des4"), apCount)
		else
			local apCost = dbMaterial.upprice[ itemMallFunc.getBuyRecordDm(dbMaterial.materialid) + 1 ]
			param.content = string.format(Res.locString("AP$Des1"), apCost, apCount )
			local count = 0
			local userFunc = gameFunc.getUserInfo()
			local mlimitsText = dbManager.getVipInfo(userFunc.getVipLevel()).MLimits
			local limitList = string.split(mlimitsText, "|")
			for k,v in pairs(limitList) do
				local key, value = string.match(v, "(%d+)-(%d+)")
				if tonumber(key) == dbMaterial.materialid then
					count = tonumber(value)
					break
				end
			end
			count = math.max(count - gameFunc.getItemMallInfo().getBuyRecordDm(dbMaterial.materialid), 0)
			param.tip = string.format(Res.locString("ItemMall$CanBuyToday"), count)
		end
		local socketC = require "SocketClient"
		param.callback = function ( ... )
			if iBread then
				socketC.send0(netModel.getModelPackUse(iBread.Id), function ( data )
					if data and data.D then
						if data.D.Resource then
							gameFunc.updateResource(data.D.Resource)
							bagFunc.useItemByID(iBread.Id)
							require 'UIHelper'.toast2( Res.locString("AP$BreadEatSuc") )
						end
					end
				end)
			else
				local userFunc = gameFunc.getUserInfo()
				local isDiscounting = itemMallFunc.isDiscounting()
				local discountPercent = itemMallFunc.getMaterialDiscount(dbMaterial.materialid)
				local price = dbMaterial.upprice[ itemMallFunc.getBuyRecordDm(dbMaterial.materialid) + 1 ]
				if discountPercent then
					price = price * discountPercent
				end

				if userFunc.getCoin() < price then
					require "Toolkit".showDialogOnCoinNotEnough()
				else				
					socketC.send0(netModel.getModelShopBuyMaterial(breadId, 1, true), function ( data )
						if data and data.D then
							gameFunc.updateResource(data.D.Resource)
							itemMallFunc.setBuyRecordDm(breadId, 1)

							require 'EventCenter'.eventInput("UpdateAp")
							Res.toastReward(data.D.Reward)
						end
					end)
				end
			end
		end
		GleeCore:showLayer("DResetNotice", param)	
	end
end

-- 打包reward.lua表格式的Reward数据，用于getDetailByDBReward
function Res.packageReward( rewardType, rewardId, amount, args )
	local dbReward = {}
	dbReward.itemtype = rewardType
	dbReward.itemid = rewardId
	dbReward.amount = amount
	dbReward.args = args
	return dbReward
end

function Res.getRewardResWithDB( dbReward, buyCnt )
	if dbReward.amount >= 0 then
		local item = {}
		item.count = dbReward.amount
		item.costPrestige = dbReward.honor
		item.costCoin = dbReward.coin

		local gameFunc = require "AppData"
		if dbReward.type == 1 then
			item.type = "Gold"
			item.bg = ""
			item.icon = "TY_jinbi_da.png"
			item.frame = ""
			item.name = Res.locString("Global$Gold")
			item.isPiece = false
		end
		if dbReward.type == 2 then
			item.type = "Coin"
			item.bg = ""
			item.icon = "TY_jinglingshi_da.png"
			item.frame = ""
			item.name = Res.locString("Global$SpriteStone")
			item.isPiece = false
		end
		if dbReward.type == 3 then
			local item = {}
			item.type = "Soul"
			item.bg = ""
			item.icon = Res.getSoulImageName()
			item.frame = ""
			item.name = Res.locString("Global$Soul")
			item.isPiece = false
		end
		if dbReward.type == 7 then
			local dbEquip = dbManager.getInfoEquipment(dbReward.itemid)
			if dbEquip then
				item.type = "Equipment"
				item.bg = ""
				item.icon = Res.getEquipIconWithId(dbEquip.equipmentid)
				item.frame = Res.getEquipIconFrame(dbEquip)
				item.name = dbEquip.name
				item.isPiece = false
				local nEquip = gameFunc.getEquipInfo().getEquipInfoByEquipmentID(dbEquip.equipmentid)
				item.eventData = {dialog = "DEquipDetail",data = {nEquip = nEquip}}
			end
		end
		if dbReward.type == 8 then
			local dbGem = dbManager.getInfoGem(dbReward.itemid)
			if dbGem then
				item.type = "Gem"
				item.bg = ""
				item.icon = Res.getGemIcon(dbReward.itemid)
				item.frame = Res.getGemIconFrame(dbReward.quality)
				item.name = dbGem.name
				item.lv = dbReward.quality
				item.isPiece = false
				item.eventData = {dialog = "DGemDetail", data = {GemInfo = gameFunc.getGemInfo().getGemByGemID(dbReward.itemid, dbReward.quality), ShowOnly = true} }
			end
		end
		if dbReward.type == 9 then
			local dbMaterial = dbManager.getInfoMaterial(dbReward.itemid)
			if dbMaterial then
				item.type = "Material"
				item.bg = ""
				item.icon = Res.getMaterialIcon(dbMaterial.materialid)
				item.frame = Res.getMaterialIconFrame(dbMaterial.color)
				item.name = dbMaterial.name
				if dbMaterial.materialid == 41 then  -- 神奇糖果只有一个
					item.count = 1
				else
					item.count = dbReward.amount
				end
				item.isPiece = false
				item.eventData = {dialog = "DMaterialDetail", data = {materialId = dbReward.itemid} }
			end
		end

		if dbReward.type == 6 or dbReward.type == 10 then
			if dbReward.type == 10 and buyCnt then
				local petIndex = dbManager.getInfoDefaultConfig("CsSecondPetId").Value == dbReward.itemid and 2 or 1
				local temp = dbManager.getCsPetBuyConfig(petIndex, buyCnt)
				item.costPrestige = temp.Honor
				item.costCoin = temp.Coin
			end
			
			local dbPet = dbManager.getCharactor(dbReward.itemid)
			if dbPet then
				item.type = dbReward.type == 6 and "Pet" or "PetPiece"
				item.isPiece = dbReward.type == 10
				item.bg = Res.getPetIconBg()
				item.icon = Res.getPetIcon(dbReward.itemid)
				item.frame = "N_ZB_biankuang0.png"
				item.name = dbPet.name
				if dbReward.type == 10 then
					-- item.name = dbPet.name .. Res.locString("Global$Fragment")
					item.name = Res.concatStringWithLang(dbPet.name, Res.locString("Global$Fragment"))
				end
				item.eventData = {dialog = "DPetDetailV", data = {PetInfo = gameFunc.getPetInfo().getPetInfoByPetId(dbReward.itemid)} }
			end
		end

		if dbReward.type == 14 or dbReward.type == 15 then
			item.type = dbReward.type == 14 and "Mibao" or "MibaoPiece"
			item.bg = ""
			item.icon = string.format("mibao_%d.png", dbReward.itemid)
			local dbTreasure = dbManager.getInfoTreasure(dbReward.itemid)
			item.frame = string.format("N_ZB_biankuang%d.png", math.max(dbTreasure.Star - 1, 1))
			item.name = dbTreasure.Name
			if dbReward.type == 15 then
				-- item.name = item.name .. Res.locString("Global$Fragment")
				item.name = Res.concatStringWithLang(item.name, Res.locString("Global$Fragment"))
			end
			item.isPiece = dbReward.type == 15
			item.eventData = {dialog = "DMibaoDetail", data = {Data = gameFunc.getMibaoInfo().getMibaoWithDB(dbReward.itemid)} }
		end

		return item
	end
end

function Res.getDetailByDBReward(dbReward)
	-- dbReward.itemtype 见文档RewardType
	if dbReward.amount >= 0 then
		local item = {}
		item.count = dbReward.amount
		local gameFunc = require "AppData"
		if dbReward.itemtype == 1 then
			item.type = "Gold"
			item.bg = ""
			item.icon = "TY_jinbi_da.png"
			item.frame = ""
			item.name = Res.locString("Global$Gold")
			item.isPiece = false
		elseif dbReward.itemtype == 2 then
			item.type = "Coin"
			item.bg = ""
			item.icon = "TY_jinglingshi_da.png"
			item.frame = ""
			item.name = Res.locString("Global$SpriteStone")
			item.isPiece = false
		elseif dbReward.itemtype == 3 then
			item.type = "Soul"
			item.bg = ""
			item.icon = Res.getSoulImageName()
			item.frame = ""
			item.name = Res.locString("Global$Soul")
			item.isPiece = false
		elseif dbReward.itemtype == 4 then
			item.type = "Ap"
			item.bg = ""
			item.icon = "get_ap.png"
			item.frame = ""
			item.name = Res.locString("Global$AP")
			item.isPiece = false
		elseif dbReward.itemtype == 5 then
			item.type = "Exp"
			item.bg = ""
			item.icon = "get_exp.png"
			item.frame = ""
			item.name = Res.locString("Global$Exp")
			item.isPiece = false
		elseif (dbReward.itemtype == 6 or dbReward.itemtype == 10) then
			local dbPet = dbManager.getCharactor(dbReward.itemid)
			if dbPet then
				item.type = dbReward.itemtype == 6 and "Pet" or "PetPiece"
				item.isPiece = dbReward.itemtype == 10
				item.bg = Res.getPetIconBg()
				item.icon = Res.getPetIcon(dbReward.itemid)
				item.frame = "N_ZB_biankuang0.png"
				item.name = dbPet.name
				if dbReward.itemtype == 10 then
					item.name = dbPet.name .. Res.locString("Global$Fragment")
				end
				item.eventData = {dialog = "DPetDetailV", data = {PetInfo = gameFunc.getPetInfo().getPetInfoByPetId(dbReward.itemid)} }
			end			
		elseif dbReward.itemtype == 7 then
			local dbEquip = dbManager.getInfoEquipment(dbReward.itemid)
			if dbEquip then
				item.type = "Equipment"
				item.bg = ""
				item.icon = Res.getEquipIconWithId(dbEquip.equipmentid)
				item.frame = Res.getEquipIconFrame(dbEquip)
				item.name = dbEquip.name
				item.isPiece = false
				local nEquip = gameFunc.getEquipInfo().getEquipInfoByEquipmentID(dbEquip.equipmentid)
				item.eventData = {dialog = "DEquipDetail",data = {nEquip = nEquip}}
			end
		elseif dbReward.itemtype == 8 then
			local dbGem = dbManager.getInfoGem(dbReward.itemid)
			if dbGem then
				item.type = "Gem"
				item.bg = ""
				item.icon = Res.getGemIcon(dbReward.itemid)
				item.frame = Res.getGemIconFrame(dbReward.args[1])
				item.name = dbGem.name
				item.lv = dbReward.args[1]
				item.isPiece = false
				item.eventData = {dialog = "DGemDetail", data = {GemInfo = gameFunc.getGemInfo().getGemByGemID(dbReward.itemid, dbReward.args[1]), ShowOnly = true} }
			end
		elseif dbReward.itemtype == 9 then
			local dbMaterial = dbManager.getInfoMaterial(dbReward.itemid)
			if dbMaterial then
				item.type = "Material"
				item.bg = ""
				item.icon = Res.getMaterialIcon(dbMaterial.materialid)
				item.frame = Res.getMaterialIconFrame(dbMaterial.color)
				item.name = dbMaterial.name
				if dbMaterial.materialid == 41 then  -- 神奇糖果只有一个
					item.count = 1
				else
					item.count = dbReward.amount
				end
				item.isPiece = false
				item.eventData = {dialog = "DMaterialDetail", data = {materialId = dbReward.itemid} }
			end
		elseif dbReward.itemtype == 11 then -- 运营礼包
			item.type = "Pack"
			item.bg = ""
			item.icon = Res.getActiveItemIcon()
			item.frame = Res.getActiveItemIconFrame()
			item.name = ""
			item.isPiece = false
		elseif dbReward.itemtype == 12 then -- 联赛声望
			item.type = "CpsHonor"
			item.bg = ""
			item.icon = "material_55.png"
			item.frame = Res.getMaterialIconFrame(5)
			item.name = Res.locString("Global$Prestige")
			item.isPiece = false
		elseif dbReward.itemtype == 13 then
			item.type = "GuildPoint"
			item.bg = ""
			item.icon = "N_GHZ_material_57.png"
			item.frame = "N_ZB_biankuang5.png"
			item.name = Res.locString("Global$GuildFightPoint")
			item.isPiece = false
		elseif (dbReward.itemtype == 14 or dbReward.itemtype == 15) then
			item.type = dbReward.itemtype == 14 and "Mibao" or "MibaoPiece"
			item.bg = ""
			item.icon = string.format("mibao_%d.png", dbReward.itemid)
			local dbTreasure = dbManager.getInfoTreasure(dbReward.itemid)
			item.frame = string.format("N_ZB_biankuang%d.png", math.max(dbTreasure.Star - 1, 1))
			item.name = dbTreasure.Name
			if dbReward.itemtype == 15 then
				-- item.name = item.name .. Res.locString("Global$Fragment")
				item.name = Res.concatStringWithLang(item.name, Res.locString("Global$Fragment"))
			end
			item.isPiece = dbReward.itemtype == 15

			item.eventData = {dialog = "DMibaoDetail", data = {Data = gameFunc.getMibaoInfo().getMibaoWithDB(dbReward.itemid)} }
		elseif dbReward.itemtype == 16 then
			item.type = "AdvCoin"
			item.bg = ""
			item.icon = "WJSL_YB_TB.png"
			item.frame = "N_ZB_biankuang5.png"
			item.name = Res.locString("Global$TrialCoin")
			item.isPiece = false
		elseif dbReward.itemtype == 17 then
			item.type = "GuildCopyKey"
			item.bg = "N_PZ0_bg.png"
			local propIdList = {
				[2] = "GrassKey.png",
				[3] = "ElectricKey.png",
				[6] = "WaterKey.png",
				[7] = "StoneKey.png",
				[8] = "FireKey.png"
			}
			item.icon = propIdList[dbReward.itemid]
			item.frame = "N_ZB_biankuang0.png"
			item.name = Res.locString(string.format("Hunt$key%d", dbReward.itemid))
			item.isPiece = false
		elseif dbReward.itemtype == 18 then
			item.type = "Rune"
			local RuneBgResMap = {[1] = 1,[2] = 4,[3] = 2,[4] = 5,[5] = 6}
			item.bg = string.format("N_PZ%d_bg.png", RuneBgResMap[math.floor(dbReward.itemid / 10)])
			item.icon = string.format("rune-%d.png", dbReward.itemid)
			item.frame = "N_ZB_biankuang0.png"
			local dbRune = dbManager.getInfoRune(dbReward.itemid)
			item.name = dbRune.Name
			item.isPiece = false
			item.Star = dbReward.args[1]
			item.eventData = {dialog = "DRuneDetail", data = {RuneData = gameFunc.getRuneInfo().getRuneWithDB(dbReward.itemid, dbReward.args[1], dbReward.args[2])} }			
		elseif (dbReward.itemtype == 19 or dbReward.itemtype == 20) then
			local dbBook = dbManager.getInfoBookConfig(dbReward.itemid)
			local dbSkill = dbManager.getInfoSkill(dbReward.itemid)
			if dbBook and dbSkill then
				item.type = "SkillBooks"
				item.bg = string.format("N_PZ%d_bg.png", dbBook.Color)
				item.icon = string.format("N_skillbook_%d.png", dbBook.ClassId)
				item.frame = string.format("N_ZB_biankuang%d.png", dbBook.Color)
				item.name = dbSkill.name
				item.isPiece = dbReward.itemtype == 20
				item.BookClassId = dbBook.ClassId
				item.eventData = {dialog = "DSkillBookDetail",data = gameFunc.getPerlBookInfo().getBookInfoWithBookId(dbReward.itemid) }
			end
		elseif dbReward.itemtype == 21 then
			local dbPerl = dbManager.getInfoPerlConfig(dbReward.itemid)
			item.type = "Perl"
			item.bg = string.format("N_PZ%d_bg.png", dbPerl.color)
			item.icon = string.format("N_gdyj_zhiye_%d.png", dbPerl.classid)
			item.frame = string.format("N_ZB_biankuang%d.png", dbPerl.color)
			item.name = dbPerl.name
			item.isPiece = false
		end
		return item
	end
end

function Res.setNodeWithRewardData( data,iconNode )
	iconNode:setResid(nil)
	iconNode:removeAllChildrenWithCleanup(true)

	if data.bg and string.len(data.bg)>0 then
		local node = ElfNode:create()
		node:setResid(data.bg)
		iconNode:addChild(node)
	end
	if data.icon and string.len(data.icon)>0 then
		local node = ElfNode:create()
		node:setResid(data.icon)
		if data.type == "Pet" or data.type == "PetPiece" then
			node:setScale(140/95)
		end
		iconNode:addChild(node)
	end
	if data.frame and string.len(data.frame)>0 then
		local node = ElfNode:create()
		node:setResid(data.frame)
		iconNode:addChild(node)

		Res.addRuneStars( node, data )
	end
	if data.isPiece then
		local node = ElfNode:create()
		node:setResid("N_TY_suipian.png")
		node:setPosition(ccp(-42.5,-41.25))
		iconNode:addChild(node)
	end
end

function Res.concatStringWithLang( str1, str2 )
	local LangName = require 'Config'.LangName or ''
	if LangName == 'vn' then
		return str2 .. " " .. str1
	else
		return str1 .. str2
	end 
end

function Res.getRewardResList( reward )
	local list = {}
	if reward then
		local gameFunc = require "AppData"
		if reward.Gold and reward.Gold > 0 then
			local item = {}
			item.type = "Gold"
			item.bg = ""
			item.icon = "TY_jinbi_da.png"
			item.frame = ""
			item.name = Res.locString("Global$Gold")
			item.count = reward.Gold
			item.isPiece = false
			table.insert(list, item)
		end
		if reward.Coin and reward.Coin > 0 then
			local item = {}
			item.type = "Coin"
			item.bg = ""
			item.icon = "TY_jinglingshi_da.png"
			item.frame = ""
			item.name = Res.locString("Global$SpriteStone")
			item.count = reward.Coin
			item.isPiece = false
			table.insert(list, item)
		end
		if reward.Soul and reward.Soul > 0 then
			local item = {}
			item.type = "Soul"
			item.bg = ""
			item.icon = Res.getSoulImageName()
			item.frame = ""
			item.name = Res.locString("Global$Soul")
			item.count = reward.Soul
			item.isPiece = false
			table.insert(list, item)
		end
		if reward.Ap and reward.Ap > 0 then
			local item = {}
			item.type = "Ap"
			item.bg = ""
			item.icon = "get_ap.png"
			item.frame = ""
			item.name = Res.locString("Global$AP")
			item.count = reward.Ap
			item.isPiece = false
			table.insert(list, item)
		end
		if reward.Exp and reward.Exp > 0 then
			local item = {}
			item.type = "Exp"
			item.bg = ""
			item.icon = "get_exp.png"
			item.frame = ""
			item.name = Res.locString("Global$Exp")
			item.count = reward.Exp
			item.isPiece = false
			table.insert(list, item)
		end
		if reward.Honor and reward.Honor > 0 then
			local item = {}
			item.type = "Honor"
			item.bg = ""
			item.icon = "get_honor.png"
			item.frame = ""
			item.name = Res.locString("Global$Honor")
			item.count = reward.Honor
			item.isPiece = false
			table.insert(list, item)
		end

		if reward.Pets then
			for i,v in ipairs(reward.Pets) do
				local dbPet = dbManager.getCharactor(v.PetId)
				if dbPet and v.Amount > 0 then
					local item = {}
					item.type = "Pet"
					item.bg = Res.getPetIconBg()
					item.icon = Res.getPetIcon(v.PetId)
					item.frame = "N_ZB_biankuang0.png"
					item.name = dbPet.name
					item.count = v.Amount
					item.isPiece = false
					item.eventData = {dialog = "DPetDetailV", data = {PetInfo = gameFunc.getPetInfo().getPetInfoByPetId(v.PetId)} }
					table.insert(list, item)
				end
			end
		end
		if reward.Equipments then
			for i,v in ipairs(reward.Equipments) do
				local dbEquip = dbManager.getInfoEquipment(v.EquipmentId)
				if dbEquip and v.Amount > 0 then
					local item = {}
					item.type = "Equipment"
					item.bg = ""
					item.icon = Res.getEquipIconWithId(dbEquip.equipmentid)
					item.frame = Res.getEquipIconFrame(dbEquip)
					item.name = dbEquip.name
					item.count = v.Amount
					item.isPiece = false
					item.orgdata = v
					local nEquip = gameFunc.getEquipInfo().getEquipInfoByEquipmentID(dbEquip.equipmentid)
					nEquip.Value = v.Value or nEquip.Value
					nEquip.Tp = v.Tp or nEquip.Tp
					nEquip.Grow = v.Grow or nEquip.Grow
					item.eventData = {dialog = "DEquipDetail",data = {nEquip = nEquip}}
					table.insert(list, item)	
				end
			end
		end
		if reward.Gems then
			for i,v in ipairs(reward.Gems) do
				local dbGem = dbManager.getInfoGem(v.GemId)
				if dbGem and v.Amount > 0 then
					local item = {}
					item.type = "Gem"
					item.bg = ""
					item.icon = Res.getGemIcon(v.GemId)
					item.frame = Res.getGemIconFrame(v.Lv)
					item.name = dbGem.name
					item.lv = v.Lv
					item.count = v.Amount
					item.isPiece = false
					item.eventData = {dialog = "DGemDetail", data = {GemInfo = gameFunc.getGemInfo().getGemByGemID(v.GemId, v.Lv, v.Seconds), ShowOnly = true} }
					table.insert(list, item)
				end
			end
		end
		if reward.Materials then
			for i,v in ipairs(reward.Materials) do
				local dbMaterial = dbManager.getInfoMaterial(v.MaterialId)
				if dbMaterial and v.Amount > 0 then
					local item = {}
					item.type = "Material"
					item.bg = ""
					item.icon = Res.getMaterialIcon(dbMaterial.materialid)
					item.frame = Res.getMaterialIconFrame(dbMaterial.color)
					item.name = dbMaterial.name
					if dbMaterial.materialid == 41 then  -- 神奇糖果只有一个
						item.count = 1
					else
						item.count = v.Amount
					end
					item.isPiece = false
					item.orgdata = v
					if v.Seconds > 0 then
						item.eventData = {dialog = "DMaterialDetail", data = {materialId = v.MaterialId, Seconds = v.Seconds, speed = 0} }
					else
						item.eventData = {dialog = "DMaterialDetail", data = {materialId = v.MaterialId} }
					end
					table.insert(list, item)
				end
			end
		end
		if reward.PetPieces then
			for i,v in ipairs(reward.PetPieces) do
				local dbPet = dbManager.getCharactor(v.PetId)
				if dbPet and v.Amount > 0 then
					local item = {}
					item.type = "PetPiece"
					item.bg = Res.getPetIconBg()
					item.icon = Res.getPetIcon(v.PetId)
					item.frame = "N_ZB_biankuang0.png"
					-- item.name = dbPet.name .. Res.locString("Global$Fragment")
					item.name = Res.concatStringWithLang(dbPet.name, Res.locString("Global$Fragment"))
					item.count = v.Amount
					item.isPiece = true
					item.eventData = {dialog = "DPetDetailV", data = {PetInfo = gameFunc.getPetInfo().getPetInfoByPetId(v.PetId)} }
					table.insert(list, item)
				end
			end
		end
		if reward.Packs then
			for i,v in ipairs(reward.Packs) do
				if v.Amount > 0 then
					local item = {}
					item.type = "Pack"
					item.bg = ""
					item.icon = Res.getActiveItemIcon()
					item.frame = Res.getActiveItemIconFrame()
					item.name = v.Name
					item.count = v.Amount
					item.isPiece = false
					table.insert(list, item)
				end
			end
		end
		if reward.MyEgg then
			local item = {}
			item.type = "Egg"
			item.bg = ""
			item.icon = "dan_dan2.png"
			item.frame = "N_ZB_biankuang4.png"
			item.name = Res.locString(reward.MyEgg.Cnt == 0 and "Global$EggFiveStar" or "Bag$PetEggJuniorTitle")
			item.count = 1
			item.isPiece = false
			table.insert(list, item)
		end

		if reward.Top and reward.Top > 0 then
			local item = {}
			item.type = "Top"
			item.bg = ""
			item.icon = "N_GJ_icon_huizhang.png"
			item.frame = ""
			item.name = Res.locString("Global$ChampionCoin")
			item.count = reward.Top
			item.isPiece = false
			table.insert(list, item)
		end

		if reward.HongbaoScore and reward.HongbaoScore > 0 then
			local item = {}
			item.type = "HongbaoScore"
			item.bg = ""
			item.icon = "N_HB_hongbao_jifen.png"
			item.frame = ""
			item.name = Res.locString("Global$HongbaoScore")
			item.count = reward.HongbaoScore
			item.isPiece = false
			table.insert(list, item)		
		end

		if reward.CpsHonor and reward.CpsHonor > 0 then
			local item = {}
			item.type = "CpsHonor"
			item.bg = ""
			item.icon = "material_55.png"
			item.frame = Res.getMaterialIconFrame(5)
			item.name = Res.locString("Global$Prestige")
			item.count = reward.CpsHonor
			item.isPiece = false
			table.insert(list, item)	
		end

		-- 无尽试炼获得的星星
		if reward.TrialStar and reward.TrialStar > 0 then
			local item = {}
			item.type = "TrialStar"
			item.bg = ""
			item.icon = "endless_trials_xing.png"
			item.frame = "N_ZB_biankuang5.png"
			item.name = Res.locString("Global$Star")
			item.count = reward.TrialStar
			item.isPiece = false
			table.insert(list, item)
		end

		-- 战场硬币
		if reward.GuildFightPoint and reward.GuildFightPoint > 0 then
			local item = {}
			item.type = "GuildPoint"
			item.bg = ""
			item.icon = "N_GHZ_material_57.png"
			item.frame = "N_ZB_biankuang5.png"
			item.name = Res.locString("Global$GuildFightPoint")
			item.count = reward.GuildFightPoint
			item.isPiece = false
			table.insert(list, item) 
		end

		-- 秘宝
		if reward.Mibaos then
			for i,v in ipairs(reward.Mibaos) do
				if v.Amount > 0 then
					local item = {}
					item.type = "Mibao"
					item.bg = ""
					item.icon = string.format("mibao_%d.png", v.MibaoId)
					local dbTreasure = dbManager.getInfoTreasure(v.MibaoId)
					item.frame = string.format("N_ZB_biankuang%d.png", math.max(dbTreasure.Star - 1, 1))
					item.name = dbTreasure.Name
					item.count = v.Amount
					item.isPiece = false
					item.eventData = {dialog = "DMibaoDetail", data = {Data = gameFunc.getMibaoInfo().getMibaoWithDB(v.MibaoId)} }
					table.insert(list, item) 
				end
			end
		end

		-- 秘宝碎片
		if reward.MibaoPieces then
			for i,v in ipairs(reward.MibaoPieces) do
				local item = {}
				item.type = "MibaoPiece"
				item.bg = ""
				item.icon = string.format("mibao_%d.png", v.MibaoId)
				local dbTreasure = dbManager.getInfoTreasure(v.MibaoId)
				item.frame = string.format("N_ZB_biankuang%d.png", math.max(dbTreasure.Star - 1, 1))
				-- item.name = dbTreasure.Name .. Res.locString("Global$Fragment")
				item.name = Res.concatStringWithLang(dbTreasure.Name, Res.locString("Global$Fragment"))
				item.count = v.Amount
				item.isPiece = true
				item.eventData = {dialog = "DMibaoDetail", data = {Data = gameFunc.getMibaoInfo().getMibaoWithDB(v.MibaoId)} }
				table.insert(list, item)
			end
		end

		-- 试炼硬币
		if reward.AdvCoin and reward.AdvCoin > 0 then
			local item = {}
			item.type = "AdvCoin"
			item.bg = ""
			item.icon = "WJSL_YB_TB.png"
			item.frame = "N_ZB_biankuang5.png"
			item.name = Res.locString("Global$TrialCoin")
			item.count = reward.AdvCoin
			item.isPiece = false
			table.insert(list, item) 
		end

		-- 符文
		if reward.Runes then
			local RuneBgResMap = {[1] = 1,[2] = 4,[3] = 2,[4] = 5,[5] = 6}
			for i,v in ipairs(reward.Runes) do
				local item = {}
				item.type = "Rune"
				item.bg = string.format("N_PZ%d_bg.png", RuneBgResMap[math.floor(v.RuneId / 10)])
				item.icon = string.format("rune-%d.png", v.RuneId)
				item.frame = string.format("N_ZB_biankuang%d.png", v.Lv / 3)
				local dbRune = dbManager.getInfoRune(v.RuneId)
				item.name = dbRune.Name
				item.count = v.Amount
				item.isPiece = false
				item.Star = v.Star
				item.eventData = {dialog = "DRuneDetail", data = { RuneData = gameFunc.getRuneInfo().getRuneWithDB(v.RuneId, v.Star, v.Lv)} }
				table.insert(list, item)
			end
		end

		-- 狩猎场钥匙
		if reward.GuildCopyKeys then
			for i,v in ipairs(reward.GuildCopyKeys) do
				local item = {}
				item.type = "GuildCopyKey"
				item.bg = "N_PZ0_bg.png"
				local propIdList = {
					[2] = "GrassKey.png",
					[3] = "ElectricKey.png",
					[6] = "WaterKey.png",
					[7] = "StoneKey.png",
					[8] = "FireKey.png"
				}
				item.icon = propIdList[v.PropId]
				item.frame = "N_ZB_biankuang0.png"
				item.name = Res.locString(string.format("Hunt$key%d", v.PropId))
				item.count = v.Amount
				item.isPiece = false
				table.insert(list, item)
			end
		end

		-- 奇异石
		if reward.ExploreStone and reward.ExploreStone > 0 then
			local item = {}
			item.type = "ExploreStone"
			item.bg = ""
			item.icon = "material_61.png"
			item.frame = "N_ZB_biankuang3.png"
			item.name = Res.locString("Global$ExploreStone")
			item.count = reward.ExploreStone
			item.isPiece = false
			table.insert(list, item) 
		end

		-- 命运轮盘钥匙
		if reward.DestinyWheelKey and reward.DestinyWheelKey > 0 then
			local item = {}
			item.type = "DestinyWheelKey"
			item.bg = ""
			item.icon = "material_63.png"
			item.frame = "N_ZB_biankuang5.png"
			item.name = Res.locString("Activity$DestinyWheelKeyName")
			item.count = reward.DestinyWheelKey
			item.isPiece = false
			table.insert(list, item) 
		end

		-- 技能书
		if reward.Books then
			for i,v in ipairs(reward.Books) do
				local dbBook = dbManager.getInfoBookConfig(v.Bid)
				local dbSkill = dbManager.getInfoSkill(v.Bid)
				local item = {}
				item.type = "SkillBooks"
				item.bg = string.format("N_PZ%d_bg.png", dbBook.Color)
				item.icon = string.format("N_skillbook_%d.png", dbBook.ClassId)
				item.frame = string.format("N_ZB_biankuang%d.png", dbBook.Color)
				item.name = dbSkill.name
				item.count = v.Amt
				item.isPiece = false
				item.BookClassId = dbBook.ClassId
				item.eventData = {dialog = "DSkillBookDetail",data = gameFunc.getPerlBookInfo().getBookInfoWithBookId(v.Bid) }
				table.insert(list, item)
			end
		end

		-- 技能书碎片
		if reward.BookPieces then
			for i,v in ipairs(reward.BookPieces) do
				local dbBook = dbManager.getInfoBookConfig(v.Bid)
				local dbSkill = dbManager.getInfoSkill(v.Bid)
				local item = {}
				item.type = "SkillBooks"
				item.bg = string.format("N_PZ%d_bg.png", dbBook.Color)
				item.icon = string.format("N_skillbook_%d.png", dbBook.ClassId)
				item.frame = string.format("N_ZB_biankuang%d.png", dbBook.Color)
				item.name = dbSkill.name
				item.count = v.Amt
				item.isPiece = true
				item.BookClassId = dbBook.ClassId
				item.eventData = {dialog = "DSkillBookDetail",data = gameFunc.getPerlBookInfo().getBookInfoWithBookId(v.Bid) }
				table.insert(list, item)
			end
		end

		-- 职业珠子
		if reward.Perls then
			for i,v in ipairs(reward.Perls) do
				local dbPerl = dbManager.getInfoPerlConfig(v.Pid)
				local item = {}
				item.type = "Perl"
				item.bg = string.format("N_PZ%d_bg.png", dbPerl.color)
				item.icon = string.format("N_gdyj_zhiye_%d.png", dbPerl.classid)
				item.frame = string.format("N_ZB_biankuang%d.png", dbPerl.color)
				item.name = dbPerl.name
				item.count = v.Amt
				item.isPiece = false
				table.insert(list, item)
			end
		end

		-- 古代遗迹钥匙
		if reward.RemainKey and reward.RemainKey > 0 then
			local item = {}
			item.type = "RemainKey"
			item.bg = ""
			item.icon = "YJ_tubiao3.png"
			item.frame = ""
			item.name = Res.locString("Remains$KeyName")
			item.count = reward.RemainKey
			item.isPiece = false
			table.insert(list, item) 
		end

		-- 古代遗迹放大镜
		if reward.RemainGlass and reward.RemainGlass > 0 then
			local item = {}
			item.type = "RemainGlass"
			item.bg = "N_PZ0_bg.png"
			item.icon = "N_gdyj_fdj1.png"
			item.frame = "N_ZB_biankuang1.png"
			item.name = Res.locString("Remains$MagnifierTitle")
			item.count = reward.RemainGlass
			item.isPiece = false
			table.insert(list, item) 
		end
	end
	return list
end

function Res.addRuneStars( rootNode, data )
	if data.type == "Rune" then
		local starLayout = LayoutNode:create()
	--	starLayout:setScale(1.5)
		starLayout:setSpace(22)
		starLayout:setMode(0)
		starLayout:setPosition(0,-65)
		for i=1,data.Star do
			local node = ElfNode:create()
			node:setResid("JLXY_xingxing1.png")
			starLayout:addChild(node)
		end
		rootNode:addChild(starLayout)
	end
end

function Res.addIconCount( rootNode, count, pos )
	-- body
	assert(rootNode)

	if count then
		local nodeCount = LabelNode:create()
		nodeCount:enableStroke(ccc4f(0, 0, 0, 0.5), 2, false);

		rootNode:addChild(nodeCount)
		nodeCount:setFontName("FZY4JW--GB1-0")
		nodeCount:setFontSize(35)
		nodeCount:setFontFillColor(ccc4f(1, 1, 1, 1), true)
		-- nodeCount:setHorizontalAlignment(kCCTextAlignmentRight)
		-- nodeCount:setVerticalAlignment(kCCVerticalTextAlignmentCenter)
		nodeCount:setAnchorPoint(ccp(1, 0.5))
		-- nodeCount:setPosition(ccp(57.857147,-52.857147))
		
		nodeCount:setString(tostring(count))
		nodeCount:setPosition(ccp(pos.x, pos.y))
	end
end

-- getPetInfoByPetId
function Res.setNodeWithPetNetData( rootNode, nPet, count )
	local PetInfo = require 'PetInfo'
	local data = PetInfo.getPetInfoByPetId(nPet.PetId)
	return Res.setNodeWithPet( rootNode, data, count )
end

function Res.setNodeNameWithPetNetData( rootNode, nPet, count )
	local PetInfo = require 'PetInfo'
	local data = PetInfo.getPetInfoByPetId(nPet.PetId)
	Res.setNodeWithPet( rootNode, data, count )
	Res.addName(rootNode, data.Name)
end

function Res.setNodeWithPet( rootNode, nPet, count )
	rootNode:setResid("")
	rootNode:removeAllChildrenWithCleanup(true)

	local bg = ElfNode:create()
	bg:setResid(Res.getPetIconBg(nPet))
	rootNode:addChild(bg)

	local icon = ElfNode:create()
	icon:setResid(Res.getPetIcon(nPet.PetId))
	icon:setScale(140 / 95)
	rootNode:addChild(icon)

	local frame = ElfNode:create()
	frame:setResid(Res.getPetIconFrame(nPet))
	rootNode:addChild(frame)

	Res.addIconCount( rootNode, count, {x=58, y=-53} )

	return { bg, icon, frame}
end

function Res.setNodeWithPetGray( rootNode, nPet )
	rootNode:setResid("")
	rootNode:removeAllChildrenWithCleanup(true)

	local bg = ElfGrayNode:create()
	bg:setResid(Res.getPetIconBg(nPet))
	rootNode:addChild(bg)

	local icon = ElfGrayNode:create()
	icon:setResid(Res.getPetIcon(nPet.PetId))
	icon:setScale(140 / 95)
	rootNode:addChild(icon)

	local frame = ElfGrayNode:create()
	frame:setResid(Res.getPetIconFrame(nPet))
	rootNode:addChild(frame)

	return { bg, icon, frame}
end

function Res.setNodeWithPetPieceNetData( rootNode, nPet, count )
	local PetInfo = require 'PetInfo'
	local data = PetInfo.getPetInfoByPetId(nPet.PetId)
	return Res.setNodeWithPetPiece( rootNode, data, count )
end

function Res.setNodeNameWithPetPieceNetData( rootNode, nPet, count )
	local PetInfo = require 'PetInfo'
	local data = PetInfo.getPetInfoByPetId(nPet.PetId)
	Res.setNodeWithPetPiece( rootNode, data, count )
	Res.addName( rootNode, data.Name )
end

function Res.setNodeWithPetPiece( rootNode, nPet, count )
	rootNode:setResid("")
	rootNode:removeAllChildrenWithCleanup(true)

	local bg = ElfNode:create()
	bg:setResid(Res.getPetIconBg(nPet))
	rootNode:addChild(bg)

	local icon = ElfNode:create()
	icon:setResid(Res.getPetIcon(nPet.PetId))
	icon:setScale(140 / 95)
	rootNode:addChild(icon)

	local frame = ElfNode:create()
	frame:setResid(Res.getPetIconFrame(nPet))
	rootNode:addChild(frame)

	local piece = ElfNode:create()
	piece:setResid("N_TY_suipian.png")
	rootNode:addChild(piece)
	piece:setPosition(ccp(-43.57141,-42.142822))

	Res.addIconCount( rootNode, count, {x=58, y=-53} )
end

function Res.setNodeWithPetWithLv( rootNode, nPet )
	rootNode:setResid("")
	rootNode:removeAllChildrenWithCleanup(true)

	local bg = ElfNode:create()
	bg:setResid(Res.getPetIconBg(nPet))
	rootNode:addChild(bg)

	local icon = ElfNode:create()
	icon:setResid(Res.getPetIcon(nPet.PetId))
	icon:setScale(140 / 95)
	rootNode:addChild(icon)

	local frame = ElfNode:create()
	frame:setResid(Res.getPetIconFrameWithLv(nPet))
	rootNode:addChild(frame)
end

function Res.setNodeWithPetNone( rootNode )
	rootNode:setResid("N_JL_touxiang.png")
	rootNode:removeAllChildrenWithCleanup(true)
end

function Res.setNodeWithPetAuto( rootSet, nPet, target )
	if nPet then
		Res.setNodeWithPetWithLv(rootSet["icon"], nPet)
		local dbPet = dbManager.getCharactor(nPet.PetId)
		rootSet["career"]:setResid(Res.getPetCareerIcon(dbPet.atk_method_system))
--		rootSet["property"]:setResid(Res.getPetPropertyIcon(dbPet.prop_1))
		rootSet["lv"]:setString(nPet.Lv)
		-- rootSet["starLayout"]:removeAllChildrenWithCleanup(true)
		-- for i=1,dbPet.star_level do
		-- 	rootSet["starLayout"]:addChild(target:createLuaSet("@star")[1])
		-- end
		require 'PetNodeHelper'.updateStarLayout(rootSet["starLayout"], dbPet)
	else
		Res.setNodeWithPetNone(rootSet["icon"])
	end
	rootSet["career"]:setVisible(nPet ~= nil)
--	rootSet["property"]:setVisible(nPet ~= nil)
	rootSet["lv"]:setVisible(nPet ~= nil)
	rootSet["starLayout"]:setVisible(nPet ~= nil)
end

function Res.setNodeWithEquipNetData( rootNode, nEquip, count )
	assert(rootNode)
	assert(nEquip)
	local dbEquip = dbManager.getInfoEquipment(nEquip.EquipmentId)
	return Res.setNodeWithEquip( rootNode, dbEquip, count )
end

function Res.setNodeNameWithEquipNetData( rootNode, nEquip, count )
	assert(rootNode)
	assert(nEquip)
	local dbEquip = dbManager.getInfoEquipment(nEquip.EquipmentId)
	Res.setNodeWithEquip( rootNode, dbEquip, count )

	Res.addName(rootNode, dbEquip.name)
end

function Res.setNodeWithRuneSetIn( runeRootNode, nRuneList )
	if not require "UnlockManager":isOpen( "Rune" ) then
		runeRootNode:setVisible(false)
		return
	end

	runeRootNode:setResid("")
	runeRootNode:removeAllChildrenWithCleanup(true)

	local runeBg = ElfNode:create()
	runeBg:setResid("N_FW_fuwen1.png")
	runeRootNode:addChild(runeBg)

	if nRuneList then
		local ptList = {ccp(-54.285645,57.142944), ccp(57.500244,57.142944), ccp(-54.285645,-52.856934), ccp(57.500244,-52.856934)}
		for i,nRune in ipairs(nRuneList) do
			local temp = ElfNode:create()
			runeRootNode:addChild(temp)
			temp:setResid(string.format("rune-%d.png", nRune.RuneId))
			temp:setPosition(ptList[dbManager.getInfoRune(nRune.RuneId).Location])
		end
	end

	local runeFrame = ElfNode:create()
	runeFrame:setResid("N_FW_fuwen2.png")
	runeRootNode:addChild(runeFrame)
end

function Res.setNodeWithEquip( rootNode, dbEquip, count, nRuneList, runeVisible )
	rootNode:setResid("")
	rootNode:removeAllChildrenWithCleanup(true)

	local icon = ElfNode:create()
	icon:setResid(Res.getEquipIconWithId(dbEquip.equipmentid))
	rootNode:addChild(icon)

	if require "Toolkit".isRuneMosaicEnable(dbEquip.location) and runeVisible and require "UnlockManager":isUnlock("GuildCopyLv") then
		local runeRootNode = ElfNode:create()
		rootNode:addChild(runeRootNode)
		runeRootNode:setScale(0.25)
		runeRootNode:setPosition(ccp(35.0,-35.0))
		
		Res.setNodeWithRuneSetIn( runeRootNode, nRuneList )
	end

	local frame = ElfNode:create()
	frame:setResid(Res.getEquipIconFrame(dbEquip))
	rootNode:addChild(frame)

	Res.addIconCount( rootNode, count, {x=58, y=-53} )
end

function Res.setNodeWithEquipGray( rootNode, dbEquip, count )
	rootNode:setResid("")
	rootNode:removeAllChildrenWithCleanup(true)

	local icon = ElfGrayNode:create()
	icon:setResid(Res.getEquipIconWithId(dbEquip.equipmentid))
	rootNode:addChild(icon)

	local frame = ElfGrayNode:create()
	frame:setResid(Res.getEquipIconFrame(dbEquip))
	rootNode:addChild(frame)

	Res.addIconCount( rootNode, count, {x=58, y=-53} )
end

function Res.setNodeWithNone( rootNode )
	rootNode:setResid("")
	rootNode:removeAllChildrenWithCleanup(true)

	local bg = ElfNode:create()
	bg:setResid("N_ZB_biankuang_bg.png")
	rootNode:addChild(bg)

	local frame = ElfNode:create()
	frame:setResid("N_ZB_biankuang0.png")
	rootNode:addChild(frame)
end

function Res.setNodeWithEquipLv( rootNode, dbEquip )
	rootNode:setResid("")
	rootNode:removeAllChildrenWithCleanup(true)

	local icon = ElfNode:create()
	icon:setResid(Res.getEquipIconWithId(dbEquip.equipmentid))
	rootNode:addChild(icon)

	local frame = ElfNode:create()
	frame:setResid(Res.getEquipIconFrameWithLv(dbEquip))
	rootNode:addChild(frame)
end

function Res.setNodeWithGem( rootNode, gemId, gemLv, count )
	rootNode:setResid("")
	rootNode:removeAllChildrenWithCleanup(true)

	local icon = ElfNode:create()
	icon:setResid(Res.getGemIcon(gemId))
	rootNode:addChild(icon)

	local frame = ElfNode:create()
	frame:setResid(Res.getGemIconFrame(gemLv))
	rootNode:addChild(frame)

	Res.addIconCount( rootNode, count, {x=58, y=-53} )
end

function Res.setNodeWithBall( rootNode, dbBall )
	rootNode:setResid("")
	rootNode:removeAllChildrenWithCleanup(true)

	local bg = ElfNode:create()
	bg:setResid(string.format("N_PZ%d_bg.png", dbBall.color))
	rootNode:addChild(bg)

	local icon = ElfNode:create()
	icon:setResid(string.format("N_gdyj_zhiye_%d.png", dbBall.classid))
	rootNode:addChild(icon)

	local frame = ElfNode:create()
	frame:setResid(string.format("N_ZB_biankuang%d.png", dbBall.color))
	rootNode:addChild(frame)
end

function Res.setNodeWithBook( rootNode, dbBook )
	rootNode:setResid("")
	rootNode:removeAllChildrenWithCleanup(true)

	local bg = ElfNode:create()
	bg:setResid(string.format("N_PZ%d_bg.png", dbBook.Color))
	rootNode:addChild(bg)

	local icon = ElfNode:create()
	icon:setResid(string.format("N_skillbook_%d.png", dbBook.ClassId))
	rootNode:addChild(icon)
	
	-- local careerNode = ElfNode:create()
	-- icon:addChild(careerNode)
	-- careerNode:setResid(res.getPetCareerIcon(dbBook.ClassId))
	-- careerNode:setPosition(ccp(55,55))

	local frame = ElfNode:create()
	frame:setResid(string.format("N_ZB_biankuang%d.png", dbBook.Color))
	rootNode:addChild(frame)	
end

-- local dbMaterial = dbManager.getInfoMaterial(v.MaterialId)
function Res.setNodeWithMaterialNetData( rootNode, nMaterial, count )
	assert(rootNode)
	assert(nMaterial)
	local dbMaterial = dbManager.getInfoMaterial(nMaterial.MaterialId)
	return Res.setNodeWithMaterial( rootNode, dbMaterial, count )
end

function Res.setNodeAndNameWithMaterialNetData( rootNode, nMaterial, count )
	assert(rootNode)
	assert(nMaterial)
	local dbMaterial = dbManager.getInfoMaterial(nMaterial.MaterialId)
	Res.setNodeWithMaterial( rootNode, dbMaterial, count )
	Res.addName(rootNode, dbMaterial.name)
end

function Res.setNodeWithRuneNetData( rootNode,runeId,star,lv,count )
	Res.setNodeWithRune( rootNode,runeId,star,lv )
	local name = require 'Toolkit'.getRuneName( runeId,lv)
	Res.addName(rootNode,string.format('%sx%d',tostring(name),count))
end

function Res.setGuildCopyKeysNetData( rootNode,PropId,Amount )
	-- body
	Res.setNodeWithKey(rootNode,PropId)
	local name = Res.locString(string.format("Hunt$key%d", PropId))
	Res.addName(rootNode,string.format('%sx%d',tostring(name),Amount))
end

function Res.addName( rootNode, name, pos )
	-- body
	assert(rootNode)

	if name then
		pos = pos or { x=0, y=-103 }

		local nodeCount = LabelNode:create()
		nodeCount:enableStroke(ccc4f(0, 0, 0, 0.5), 2, false);

		rootNode:addChild(nodeCount)
		nodeCount:setFontName("FZY4JW--GB1-0")
		nodeCount:setFontSize(35)
		nodeCount:setFontFillColor(ccc4f(1, 1, 1, 1), true)
		-- nodeCount:setHorizontalAlignment(kCCTextAlignmentRight)
		-- nodeCount:setVerticalAlignment(kCCVerticalTextAlignmentCenter)
		nodeCount:setAnchorPoint(ccp(0.5, 1))
		-- nodeCount:setPosition(ccp(57.857147,-52.857147))
		
		nodeCount:setString(tostring(name))
		nodeCount:setPosition(ccp(pos.x, pos.y+15))

		require 'LangAdapter'.LabelNodeAutoShrink(nodeCount,170)
	end
end

function Res.setNodeWithMaterial( rootNode, dbMaterial, count )
	rootNode:setResid("")
	rootNode:removeAllChildrenWithCleanup(true)

	if dbMaterial.materialid >= 1001 and dbMaterial.materialid < 1100 then
		local bg = ElfNode:create()
		bg:setResid(Res.getMaterialIconBg(dbMaterial.color))
		rootNode:addChild(bg)
	end

	local icon = ElfNode:create()
	icon:setResid(Res.getMaterialIcon(dbMaterial.materialid))
	rootNode:addChild(icon)

	local frame = ElfNode:create()
	frame:setResid(Res.getMaterialIconFrame(dbMaterial.color))
	rootNode:addChild(frame)

	Res.addIconCount( rootNode, count, {x=58, y=-53} )
end

function Res.setNodeWithMaterialGray( rootNode, dbMaterial, count )
	rootNode:setResid("")
	rootNode:removeAllChildrenWithCleanup(true)

	if dbMaterial.materialid >= 1001 and dbMaterial.materialid < 1100 then
		local bg = ElfGrayNode:create()
		bg:setResid(Res.getMaterialIconBg(dbMaterial.color))
		rootNode:addChild(bg)
	end

	local icon = ElfGrayNode:create()
	icon:setResid(Res.getMaterialIcon(dbMaterial.materialid))
	rootNode:addChild(icon)

	local frame = ElfGrayNode:create()
	frame:setResid(Res.getMaterialIconFrame(dbMaterial.color))
	rootNode:addChild(frame)

	Res.addIconCount( rootNode, count, {x=58, y=-53} )
end

function Res.setNodeWithPack( rootNode )
	rootNode:setResid("")
	rootNode:removeAllChildrenWithCleanup(true)

	local icon = ElfNode:create()
	icon:setResid(Res.getActiveItemIcon())
	rootNode:addChild(icon)

	local frame = ElfNode:create()
	frame:setResid(Res.getActiveItemIconFrame())
	rootNode:addChild(frame)
end

function Res.setNodeWithGold( rootNode, count )
	rootNode:setResid("TY_jinbi_da.png")
	rootNode:removeAllChildrenWithCleanup(true)
	Res.addIconCount( rootNode, count, {x=58, y=-53} )
end

function Res.setNodeWithCoin( rootNode, count )
	rootNode:setResid("TY_jinglingshi_da.png")
	rootNode:removeAllChildrenWithCleanup(true)
	Res.addIconCount( rootNode, count, {x=58, y=-53} )
end

function Res.setNodeWithSoul( rootNode, count )
	rootNode:setResid("get_petsoul.png")
	rootNode:removeAllChildrenWithCleanup(true)
	Res.addIconCount( rootNode, count, {x=58, y=-53} )
end

function Res.setNodeWithExploreStone( rootNode, count )
	rootNode:setResid("")
	rootNode:removeAllChildrenWithCleanup(true)

	local icon = ElfNode:create()
	icon:setResid("material_61.png")
	rootNode:addChild(icon)

	local frame = ElfNode:create()
	frame:setResid("N_ZB_biankuang3.png")
	rootNode:addChild(frame)

	Res.addIconCount( rootNode, count, {x=58, y=-53} )
end

function Res.setNodeWithAp( rootNode )
	rootNode:setResid("get_ap.png")
end

function Res.setNodeWithExp( rootNode )
	rootNode:setResid("get_exp.png")
end

function Res.setNodeWithHonor( rootNode )
	rootNode:setResid("get_honor.png")
end

function Res.setNodeWithEgg( rootNode, nEgg )
	rootNode:setResid("")
	rootNode:removeAllChildrenWithCleanup(true)

	local icon = ElfNode:create()
	rootNode:addChild(icon)

	local frame = ElfNode:create()
	rootNode:addChild(frame)

	-- if nEgg.Senior then
	-- 	icon:setResid("dan_dan2.png")
	-- 	frame:setResid("N_ZB_biankuang4.png")
	-- else
	-- 	if nEgg.Left <= 0 and nEgg.PropId > 0 then
	-- 		local nameList = {[2] = "dan_cao.png", [3] = "dan_dian.png", [6] = "dan_shui.png", [7] = "dan_tu.png", [8] = "dan_huo.png"}
	-- 		icon:setResid(nameList[nEgg.PropId])
	-- 	else
	-- 		icon:setResid("dan_dan1.png")
	-- 	end
	-- 	frame:setResid("N_ZB_biankuang3.png")
	-- end	
	icon:setResid("dan_dan2.png")
	frame:setResid("N_ZB_biankuang4.png")
end

function Res.setNodeWithBuff( rootNode, buffType )
	rootNode:setResid("")
	rootNode:removeAllChildrenWithCleanup(true)

	local bg = ElfNode:create()
	bg:setResid("N_PZ0_bg.png")
	rootNode:addChild(bg)

	local bufferPicList = {"N_GH_keji1.png", "N_GH_keji3.png", "N_GH_keji2.png", "N_GH_keji7.png"}
	local icon = ElfNode:create()
	icon:setResid(bufferPicList[buffType])
	rootNode:addChild(icon)

	local frame = ElfNode:create()
	frame:setResid("N_ZB_biankuang0.png")
	rootNode:addChild(frame)
end

local function getMibaoStarColorStr(star)
	if star == 2 then
		return "lv"
	elseif star == 3 then
		return "lan"
	elseif star == 4 then
		return "zi"
	else
		return ""
	end
end

function Res.addTreasureAnim( node,data )
	if data.RefineLv and data.RefineLv > 9 then
		local anim = SimpleAnimateNode:create()
		for i=1,16 do
			local resId = string.format("JL1_%s%d.png",getMibaoStarColorStr(data.Star),i)
			anim:addResidToArray(resId)
			anim:setScale(1.65)
			node:addChild(anim)
			anim:start()
		end
	end

	if data.RefineLv and data.RefineLv > 19 then
		local anim = SimpleAnimateNode:create()
		for i=1,32 do
			local resId = string.format("JL2_%s%d.png",getMibaoStarColorStr(data.Star),i)
			anim:addResidToArray(resId)
			anim:setScale(1.65)
			node:addChild(anim)
			anim:start()
		end
	end
end

function Res.setNodeWithTreasure( rootNode, dbTreasure,isFrag )
	rootNode:setResid(nil)
	rootNode:removeAllChildrenWithCleanup(true)

	if dbTreasure then
		local icon = ElfNode:create()
		local id = dbTreasure.MibaoId or dbTreasure.Id
		icon:setResid(string.format("mibao_%d.png", id))
		rootNode:addChild(icon)

		local frame = ElfNode:create()
		frame:setResid(string.format("N_ZB_biankuang%d.png", math.max(dbTreasure.Star - 1, 1)))
		rootNode:addChild(frame)

		Res.addTreasureAnim(rootNode,dbTreasure)

		if isFrag then
			local frag = ElfNode:create()
			frag:setResid("N_TY_suipian.png")
			frag:setPosition(ccp(-42.5,-41.25))
			rootNode:addChild(frag)
		end
	end
end

local RuneBgResMap = {[1] = 1,[2] = 4,[3] = 2,[4] = 5,[5] = 6}

function Res.setNodeWithRune( rootNode,runeId,star,lv )
	rootNode:setResid(nil)
	rootNode:removeAllChildrenWithCleanup(true)

	local bg = ElfNode:create()
	bg:setResid(string.format("N_PZ%d_bg.png",RuneBgResMap[math.floor(runeId/10)]))
	rootNode:addChild(bg)

	local icon = ElfNode:create()
	icon:setResid(string.format("rune-%d.png",runeId))
	rootNode:addChild(icon)

	local frame = ElfNode:create()
	frame:setResid(string.format("N_ZB_biankuang%d.png",lv/3))
	rootNode:addChild(frame)

	local starLayout = LayoutNode:create()
	starLayout:setSpace(22)
	starLayout:setMode(0)
	starLayout:setPosition(0,-65)
	for i=1,star do
		local node = ElfNode:create()
		node:setResid("JLXY_xingxing1.png")
		starLayout:addChild(node)
	end
	rootNode:addChild(starLayout)
end

function Res.setNodeWithKey( rootNode, propId )
	rootNode:setResid("")
	rootNode:removeAllChildrenWithCleanup(true)

	local bg = ElfNode:create()
	bg:setResid("N_PZ0_bg.png")
	rootNode:addChild(bg)

	local propIdList = {
		[2] = "GrassKey.png",
		[3] = "ElectricKey.png",
		[6] = "WaterKey.png",
		[7] = "StoneKey.png",
		[8] = "FireKey.png"
	}
	local icon = ElfNode:create()
	icon:setResid(propIdList[propId])
	rootNode:addChild(icon)

	local frame = ElfNode:create()
	frame:setResid("N_ZB_biankuang0.png")
	rootNode:addChild(frame)
end

-- function Res.getPetIconBg(  )
-- 	return 'N_ZB_biankuang_bg.png'
-- end

function Res.getPetIconBg( nPet )
	if nPet then
		local awakeIndex = Res.getFinalAwake(nPet.AwakeIndex)
		return string.format("N_PZ%d_bg.png", math.max(awakeIndex -1, 0))
	else
		return "N_PZ0_bg.png"
	end
end

function Res.getPetPZ( awakeIndex )
	awakeIndex = Res.getFinalAwake(awakeIndex)
	return string.format('N_ZB_biankuang%d.png',awakeIndex-1)	
end

function Res.getGradeIcon( grade )
	return string.format('material_100%ds.png',grade-1)	
end

--[[
lv 1  23 45 67 89 10
	白 绿  蓝 紫  橙  金
]]
local GuildTechPZ = 
{
	[0]=0,
	[1]=0,
	[2]=1,
	[3]=1,
	[4]=2,
	[5]=2,
	[6]=3,
	[7]=3,
	[8]=4,
	[9]=4,
	[10]=5,
}

function Res.getGuildTechIcon( Type,lv )
	local icon = string.format('N_GH_keji%d.png',(Type == 0 and 8) or Type)
	lv = lv or 1
	return icon,string.format('N_ZB_biankuang%d.png',0),string.format('N_PZ%d_bg.png',0)
end

function Res.setTouchDispatchEvents( enable )
	CCDirector:sharedDirector():getTouchDispatcher():setDispatchEvents(enable)
end

function Res.updateRewardItem( dbReward, iconNode, nameNode, amountVisible, btnNode )
	local amount = amountVisible and dbReward.amount or nil
	if dbReward.itemtype == 6 then -- 精灵
		Res.setNodeWithPet(iconNode, gameFunc.getPetInfo().getPetInfoByPetId( dbReward.itemid ), amount)
		local dbPet = dbManager.getCharactor(dbReward.itemid)
		nameNode:setString(dbPet.name)
	elseif dbReward.itemtype == 7 then -- 装备
		local dbEquip = dbManager.getInfoEquipment(dbReward.itemid)
		Res.setNodeWithEquip(iconNode, dbEquip, amount)
		nameNode:setString(dbEquip.name)
	elseif dbReward.itemtype == 8 then -- 宝石
		local dbGem = dbManager.getInfoGem(dbReward.itemid)
		Res.setNodeWithGem(iconNode, dbGem.gemid, dbReward.args[1], amount)
		nameNode:setString(dbGem.name .. " Lv." .. dbReward.args[1])
	elseif dbReward.itemtype == 9 then -- 道具
		local dbMaterial = dbManager.getInfoMaterial(dbReward.itemid)
		Res.setNodeWithMaterial(iconNode, dbMaterial, amount)
		nameNode:setString(dbMaterial.name)
	elseif dbReward.itemtype == 1 then -- 金币
		Res.setNodeWithGold(iconNode, amount)
		nameNode:setString(Res.locString("Global$Gold"))
	elseif dbReward.itemtype == 2 then -- 精灵石
		Res.setNodeWithCoin(iconNode, amount)
		nameNode:setString(Res.locString("Global$Coin"))
	elseif dbReward.itemtype == 10 then -- 精灵碎片
		Res.setNodeWithPetPiece(iconNode, gameFunc.getPetInfo().getPetInfoByPetId( dbReward.itemid ), amount)
		local dbPet = dbManager.getCharactor(dbReward.itemid)
		nameNode:setString(dbPet.name)
	elseif dbReward.itemtype == 3 then -- 精灵之魂
		Res.setNodeWithSoul(iconNode, amount)
		nameNode:setString(Res.locString("Global$Soul"))
	end

	if btnNode then
		btnNode:setListener(function ( ... )
			local gameFunc = require "AppData"
			if dbReward.itemtype == 6 then -- 精灵
				GleeCore:showLayer("DPetDetailV", {PetInfo = gameFunc.getPetInfo().getPetInfoByPetId(dbReward.itemid)})
			elseif dbReward.itemtype == 7 then -- 装备
				GleeCore:showLayer("DEquipDetail",{nEquip = gameFunc.getEquipInfo().getEquipInfoByEquipmentID(dbReward.itemid)})
			elseif dbReward.itemtype == 8 then -- 宝石
				GleeCore:showLayer("DGemDetail",{GemInfo = gameFunc.getGemInfo().getGemByGemID(dbReward.itemid, dbReward.args and dbReward.args[1] or 1), ShowOnly = true})
			elseif dbReward.itemtype == 9 then -- 道具
				GleeCore:showLayer("DMaterialDetail", {materialId = dbReward.itemid})
			elseif dbReward.itemtype == 10 then -- 精灵碎片
				GleeCore:showLayer("DPetDetailV", {PetInfo = gameFunc.getPetInfo().getPetInfoByPetId(dbReward.itemid)})
			end
		end)
	end
end

function Res.adjustNodeWidth( node, adjustWidth )
	if node:getWidth() > adjustWidth then
		node:setScale(adjustWidth / node:getWidth())
	end
end

function Res.petSkillFormatScale( node, scale )
	if require 'Config'.LangName == "German" then
		node:setScale( scale or 1.8 )
	end
end

function Res.petSkillFormat( str )
	if require 'Config'.LangName == "German" then
		return string.sub(str, 1, string.firstCharByteLen(str))
	elseif require 'Config'.LangName == "Arabic" then
		local first = string.find(str, " ")
		if first then
			return string.sub(str, 1, first - 1)
		end
	end
	return str
end

function Res.LabelNodeAutoShrinkIfArabic( elfNode, maxLen )
	if require 'Config'.LangName == 'Arabic' and elfNode then
		elfNode:setDimensions(CCSize(0,0))
		require 'LangAdapter'.LabelNodeAutoShrink(elfNode, maxLen)
	end
end

return Res
