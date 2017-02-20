local manager = {}

local function search(list, key, value)
	assert(list and key and value, "search arg invalid!")
	for k,v in pairs(list) do
		if v[key] == value then
			if v and type(v) == 'table' then
				return table.clone(v)
			end
			return v
		end
	end
	return nil
end

local function searchList(list,  key, value)
	assert(list and key and value, "searchList arg invalid!")
	local temp = {}
	for i,v in ipairs(list) do
		if v[key] == value then
			table.insert(temp, v)
		end
	end
	return temp
end

function manager.getGroupRank(id)
	return search(require "CsGroupRankConfig", "Id", id)
end

function manager.getGuildTitle(lv)
	return search(require "guild_fight_title", "lv", lv)
end

function manager.getInfoGuildIcon( id )
	return search(require "guild_icon", "id", id)
end

function manager.getInfoGem( id )
	return search(require "gem", "gemid", id)
end

function manager.getInfoGemLevelUp( level )
	return search(require "gem_lv", "lv", level)
end

function manager.getMegaConfig(petID)
	return search(require "MegaEvConsumeConfig", "PetId", petID)
end

function manager.getInfoEquipNeedRoleLevel( equipLevel )
	local db = require "role_lv"
	for i,v in ipairs(db) do
		if v.eqlvcap>=equipLevel then
			return v.lv
		end
	end
	return math.huge
end

function manager.getInfoRoleLevelCap( level )
	return search(require "role_lv", "lv", level)
end

function manager.getInfoTitleConfig( titleId )
	return search(require "TitleConfig", "Id", titleId)
end

function manager.getInfoMaterial( materialId )
	return search(require "material", "materialid", materialId)
end

function manager.getInfoEquipment( equipmentid )
	return search(require "equipment", "equipmentid", equipmentid)
end

function manager.getInfoEquipColor( color )
	return search(require "eq_color", "color", color)
end

function manager.getInfoEquipRank( rank )
	return search(require "eq_rank", "rank", rank)
end

function manager.getInfoEquipTp( tp )
	return search(require "eq_tp", "tp", tp)
end

function manager.getInfoEquipSet( set )
	return search(require "eq_set", "setid", set)
end

function manager.getInfoEquipSetList( set )
	assert(set > 0)
	return searchList(require "equipment", "set", set)
end

function manager.getInfoFetterConfig( id )
	return search(require "FetterConfig", "Id", id)
end

-- function manager.getInfoEquipUp( up )
-- 	return search(require "eq_up", "up", up)
-- end

function manager.getInfoStageList( townId, PlayBranch )
	local list = searchList(require "StageConfig", "TownId", townId)
	local temp = {}
	
	local PlayBranchList = require "TownInfo".getPlayBranchList()
	if PlayBranch == PlayBranchList.PlayBranchNormal then
		for i,v in ipairs(list) do
			if v.Senior == 0 and v.Hero == 0 then
				table.insert(temp, v)
			end
		end
	elseif PlayBranch == PlayBranchList.PlayBranchSenior then
		for i,v in ipairs(list) do
			if v.Senior > 0 then
				table.insert(temp, v)
			end
		end
	elseif PlayBranch == PlayBranchList.PlayBranchHero then
		for i,v in ipairs(list) do
			if v.Hero > 0 then
				table.insert(temp, v)
			end
		end
	end

	return temp
end

function manager.getInfoStage( stageId )
	return search(require "StageConfig", "Id", stageId)
end

function manager.getInfoTownConfig( townId )
	return search(require "TownConfig", "Id", townId)
end

function manager.getInfoTownList( areaId )
	return searchList(require "TownConfig", "AreaId", areaId)
end

function manager.getReward( rewardId )
	return searchList(require "reward", "rewardid", rewardId)
end

function manager.getCharactor( id )
	return search(require "charactorConfig", "id", id)
end

function manager.getCharactorListByStar(star)
	return searchList(require "charactorConfig", "star_level", star)
end

function manager.getCharactorCanSyn()
	local results = {}
	local pets = require "charactorConfig"
	for k, v in pairs(pets) do
		if v.need_pet then
			table.insert(results, v)
		end
	end
	return results
end

function manager.getInfoCharactorList( career )
	return searchList(require "charactorConfig", "atk_method_system", career)
end

function manager.getBattleConfig( id )
	return search(require "BattleConfig", "fubenid", id)
end

function manager.getMapRoadConfig( areaId )
	return searchList(require "MapRoadConfig", "AreaId", areaId)
end

function manager.getInfoGemEffectRate( gemLevel, gemType )
	local temp = manager.getInfoGemLevelUp( gemLevel )
	if gemType == 1 then
		return temp.atkrate
	elseif gemType == 2 then
		return temp.hprate
	elseif gemType == 3 then
		return temp.defrate
	end
	return nil
end

function manager.getInfoSkill( skillId )
	return search(require "skill", "id", skillId)
end

function manager.getInfoPartner( Pid )
	return search(require "PartnerConfig", "Pid", Pid)
end

function manager.getInfoPartnerLvUpConfig( lv )
	return search(require "PartnerLvUpConfig", "Lv", lv)
end

function manager.getPartnerLvMax( ... )
	local list = require "PartnerLvUpConfig"
	return list[#list].Lv
end

function manager.getInfoInviteTask( taskid )
	return search(require "invitetask", "taskid", taskid)
end

function manager.getInfoElementConfig( elementId )
	return search(require "ElementConfig", "Id", elementId)
end

function manager.getInfoElementMonsterConfigWithMonsterId( monsterId )
	return search(require "ElementMonsterConfig", "MonsterId", monsterId)
end

function manager.getInfoElementMonsterConfigWithStageId( stageId )
	return search(require "ElementMonsterConfig", "StageId", stageId)
end

function manager.getInfoElementMonsterConfigList( stageId, indexList )
	local temp = {}
	if indexList then
		local list = require "ElementMonsterConfig"
		for key,value in pairs(indexList) do
			for k,v in pairs(list) do
				if v["StageId"] == stageId and v["IndexM"] == value then
					table.insert(temp, v)
					break
				end
			end
		end
	end
	return temp
end

function manager.getInfoTaskBranchConfig( id )
	return search(require "TaskBranchConfig", "Id", id)
end

function manager.getInfoTaskMainConfig( taskMainId )
	return search(require "TaskMainConfig", "Id", taskMainId)
end

function manager.getInfoRandomRewardConfig( townId )
	return searchList(require "RandomRewardConfig", "TownId", townId)
end

function manager.getInfoDefaultConfig( key )
	return search(require "DefaultConfig", "Key", key)
end

function manager.getMotivate( id )
	return search(require 'MotivateConfig','Id',id)
end

function manager.getAwake( id,star,quality )
	local starlist = searchList(require 'awake','starmin',star)
	if quality then
		starlist = searchList(starlist,'quality',quality)
	end
	return search(starlist,'Grade',id)
end

function manager.getGradeByUnlockCnt( unlockcount )
	local starlist = searchList(require 'awake','starmin',6)
	if starlist then
		table.sort(starlist,function ( v1,v2 )
			if v1 and v2 then
				return v1.Grade < v2.Grade
			end
		end)
		
		for i,v in ipairs(starlist) do
			if v.unlockcount == unlockcount then
				return v.Grade
			end
		end	
	end
	return 0
end

function manager.getNextAwake( id,star ,quality)
	return manager.getAwake(id+1,star,quality)
end

function manager.getNextUnockSkillGrade(  )
	-- body
end

function manager.getArea( id )
	return search(require 'AreaConfig','Id',id)
end

function manager.getInfoCollectionGroupConfig(  )
	return require "CollectionGroupConfig"
end

function manager.getInfoTrainingConfig( typeId )
	return search(require "TrainingConfig", "Type", typeId)
end

function manager.getInfoTrainSlotConfig( id )
	return search(require "TrainSlotConfig", "Id", id)
end

function manager.getInfoPetLvConfig( petLv )
	return search(require "PetLvConfig", "Lv", petLv)
end

function manager.getPetListPubAndStar( pub,star )
	local tmp = {}
	local PubPetConfig = require 'PubPetConfig'	
	for k,v in pairs(PubPetConfig) do
		if v.PubId == pub and v.StarLevel == star then
			local pet = manager.getCharactor(v.PetId)
			table.insert(tmp,pet)
		end
	end

	return tmp
end

--[[
根据精灵学院和星级来划分 table[pub][star]={}
]]
function manager.getPetListsPubAndStar( )
	local tmp = {}
	local niudan_id = 0
	local star_level = 0

	local charactors = require 'charactorConfig'
	for k,v in pairs(charactors) do
		niudan_id = v.niudan_id
		star_level = v.star_level
		if niudan_id and star_level then
			if tmp[niudan_id] == nil then
				tmp[niudan_id] = {}
			end
			if tmp[niudan_id][star_level] == nil then
				tmp[niudan_id][star_level] = {}
			end

			table.insert(tmp[niudan_id][star_level],v)
		end
	end

	return tmp
end

function manager.getDailyTask( Id )
	return search(require 'DailyTaskConfig','Id',Id)
end

function manager.getDailyTaskReward( Id )
	return search(require 'DailTaskRewardConfig','Id',Id)
end

function manager.getTrainTitleByScore( score )
	
	local _table = require 'TitleConfig'
	local tmp
	for i,v in ipairs(_table) do
		if v.score > score then
			return _table[i-1]
		end
		tmp = v
	end
	return tmp

end

function manager.getTrainTitle( Id )
	return search(require 'TitleConfig','Id',Id)	
end

function manager.getTrainTitleList( Name )
	return searchList(require 'TitleConfig','Name',Name)
end

function manager.getRewardTask( taskid )
	return search(require 'task_reward','taskid',taskid)
end

function manager.getBattleCharactor( PetId )
	return search(require 'BattleCharactor','id',PetId)
end

function manager.getDeaultConfig( Key )
	return search(require 'DefaultConfig','Key',Key)
end

function manager.getVipInfo( vip )
	return search(require 'vip','vip',vip)
end

function manager.getSignConfig( month )
	return searchList(require "sign", "month", month)
end

function manager.getSevenday( day )
	return search(require 'sevendays','day',day)	
end

function manager.getUnLockLvConfig( name )
	return search(require "UnlockConfig", "name", name).unlocklv
end

function manager.getRewards( rewardid )
	
	local _table = require 'reward'
	local tmp = {}

	for k,v1 in pairs(rewardid) do
		for i,v in ipairs(_table) do
			if v.rewardid == tonumber(v1) then
				table.insert(tmp,v)
				break
			end
		end
	end

	return tmp

end

function manager.getRewardItem( rewardid )
	return search(require 'reward','rewardid',rewardid)	
end

function manager.getMixConfig( Stars ,quality)
	
	local list = searchList(require 'MixConfig','Stars',Stars)
	local ret  = list and list[1]
	if quality then
		ret = search(list,'quality',quality) or ret
	end

	return ret
end

function manager.getBossAtk( Id )
	return search(require 'BossAtk','Id',Id)
end

function manager.getTipsConfigRandom( ... )
	local list = require "TipsConfig"
	return list[math.random(#list)].Tips
end

function manager.getElementQuestionList(  )
	return require "ElementQuestion"
end

function manager.getDialogue( CID )
	return search(require 'Dialogue','CID',CID)
end

function manager.getGuideRoleCfg( id )
	return search(require 'GuideRoleCfg','id',id)
end

function manager.getAcademyCharactor( id )
	return search(require 'academy_charactor','id',id)
end

function manager.getPetGradeConfig( Id )
	return search(require 'PetQualitConfig','Id',Id)
end

function manager.getPetLvupCosts( Prop,Quality )
	local tmp = searchList(require 'PetPropQualitConfig','Prop',Prop)
	tmp = searchList(tmp,'Quality',Quality)
	return tmp
end

function manager.getAreaRewardConfig( areaId )
	return searchList(require "AreaRewardConfig", "AreaId", areaId)
end

function manager.getAreaRewardWithId( configId )
	return search(require "AreaRewardConfig", "Id", configId)
end

function manager.getPetLvCap( nPet )
	local grade = nPet.Grade
	grade = ((not grade or grade == 0) and 1) or grade
	local cfg = manager.getPetGradeConfig(grade)
	return cfg.PetLvCap
end

function manager.getGuildtclveffect( tclv,Type )
	local tmp = search(require 'guildtclv','tclv',tclv)
	return tmp and tmp.effects[tonumber(Type)],(tmp and tmp.numtype[Type])
end

function manager.getGuildtclveffectDes( tclv,Type )
	local v,t = manager.getGuildtclveffect(tclv,Type)
	if t and t == 1 then
		return tostring(v)
	else
		return string.format('%d%%',v*100)
	end
end

function manager.getGuildtclv( tclv )
	return search(require 'guildtclv','tclv',tclv)
end

function manager.getGuildlv( lv )
	return search(require 'guildlv','lv',lv)
end

function manager.getGuildlvByTclv( tclv )
	return search(require 'guildlv','tclv',tclv)
end

function manager.getResetCost( time )
	return search(require "StageResetCost", "Times", time)
end

function manager.getHelpConfig( type )
	return searchList(require "helpconfig", "type", type)
end

function manager.getWishReward( wishId )
	return search(require "wishreward", "ID", wishId)
end

function manager.getExploreConfig(slotId)
	return search(require "ExploreConfig", "SlotId", slotId)
end

function manager.getSkinPetList( skinId )
	return searchList(require "charactorConfig", "skin_id", skinId)
end

function manager.getSkinPetOrg( skinId )
	local tmps = manager.getSkinPetList(skinId)
	local ret
	for i,v in ipairs(tmps) do
		if not ret or v.evove_level < ret.evove_level then
			ret = v
		end
	end
	return ret
end

function manager.getSkinPetIds( PetId )
	local dbpet	= manager.getCharactor(PetId)
	local rets 	= {}
	if dbpet then
		local tmps = manager.getSkinPetList(dbpet.skin_id)
		for i,v in ipairs(tmps) do
			table.insert(rets,v.id)
		end
	end
	return rets
end

function manager.getZhaoHuanCfg( PetId )
	return search(require 'ZhaohuanConfig','PetId',PetId)
end

function manager.getGuideTrigger( guidecfg )
	return search(require 'guide_trigger','guidecfg',guidecfg)
end

function manager.getBossActive( harmp )
	local _table = require 'boss_active'
	for i,v in ipairs(_table) do
		if harmp > v.low and harmp <= v.high then
			return v
		end
	end
	return nil
end

function manager.getHongbaoTitleWithRank( rank )
	local temp = search(require 'HongbaoTitle','Id', rank)
	return temp ~= nil and temp.Name or ""
end

function manager.getCsStoreConfig( id )
	return search(require "CsStore", "ID", id)
end

function manager.getCsPetBuyConfig( PetNo, Cnt )
	local list = require "CsPetBuyConfig"
	for k,v in pairs(list) do
		if v.PetNo == PetNo and v.Cnt == Cnt then
			return v
		end
	end
end

function manager.getCsScoreWithRate( iScore, oScore )
	if iScore and oScore then
		return math.min(76, math.max(20, math.floor((oScore - iScore) * 0.09 + 25)))
	end
end

function manager.getInfoAdvConfigWithType( type )
	return search(require "AdvConfig", "Type", type)
end

function manager.getTopTowerClearUnLockLv( ... )
	local vipList = require "vip"
	for i,v in ipairs(vipList) do
		if v.TopTowerClear > 0 then
			return v.vip
		end
	end
end

function manager.getGuildFightStoreInfo( type, itemId )
	local list = searchList(require "guild_fight_store", "type", type)
	for i,v in ipairs(list) do
		if v.itemid == itemId then
			return v
		end
	end
end

function manager.getGuildMatchCastleConfig( castleId )
	return search(require "GuildMatchCastleConfig", "Id", castleId)
end

function manager.getGuildFightTime( status )
	local GBHelper = require "GBHelper"
	local klist = {
		[GBHelper.MatchStatus.BattleArraySetting] = "GuildFightPreST",
		[GBHelper.MatchStatus.FightPrepare] = "GuildFightPreET",
		[GBHelper.MatchStatus.Fighting] = "GuildFightBatST",
		[GBHelper.MatchStatus.Dealing] = "GuildFightBatET",
	}
	print("getGuildFightTime_status = " .. status)
	return manager.convertToTimeFormat( manager.getInfoDefaultConfig(klist[status]).Value )
end

function manager.convertToTimeFormat( string )
	local hour, min = string.match(string, "(%d+)|(%d+)")
	return tonumber(hour), tonumber(min)
end

function manager.getGuildFightBossReward( bossId )
	return searchList(require "guildfightbossreward", "BOSSID", bossId)
end

function manager.getInfoTreasure( id )
	return search(require "MibaoConfig", "Id", id)
end

function manager.getInfoMibaoForgeConfig( star,count )
	local t = require "MibaoForgeConfig"
	for _,v in ipairs(t) do
		if v.Star == star and v.Num == count then
			return v
		end
	end
	return nil
end

function manager.getInfoMibaoLvUpConfig( star,curLv )
	local t = require "MibaoLvUpConfig"
	for _,v in ipairs(t) do
		if v.Star == star and v.Lv == curLv then
			return v
		end
	end
	return nil
end

function manager.getInfoMibaoRefineConfig( mibaotype,star,curLv )
	local t = require "MibaoRefineConfig"
	for _,v in ipairs(t) do
		if v.Star == star and v.RefineLv == curLv and v.Type == mibaotype then
			return v
		end
	end
	return nil
end

function manager.getInfoMibaoRefineConfigs( mibaotype,star )
	local ret = {}
	local t = require "MibaoRefineConfig"
	for _,v in ipairs(t) do
		if v.Star == star and v.Type == mibaotype then
			ret[#ret+1] = v
		end
	end
	return ret
end

function manager.getInfoMibaoLvLimit( star )
	local list = searchList(require "MibaoLvUpConfig", "Star", star)
	if list and #list > 0 then
		return list[#list].Lv
	end
	return 0
end

function manager.getInfoAdvBoxRwdConfig( id )
	return search(require "AdvBoxRwdConfig", "ID", id)
end

function manager.getInfoAdvExchangeConfig( id )
	return search(require "AdvExchangeConfig", "ID", id)
end

function manager.getDoctorTaskConfig( ID )
	return search(require 'DoctorTaskConfig','ID',ID)	
end

function manager.getCardConfigWithId( cardId )
	return search(require "Card21StoreConfig", "ID", cardId)
end

function manager.getGuildCopyAreaConfig( id )
	return search(require "GuildCopyAreaConfig", "Id", id)
end

function manager.getGuildCopyBoxConfig( id )
	return search(require "GuildCopyBoxConfig", "Id", id)
end

function manager.getGuildCopyStageConfig( id )
	return search(require "GuildCopyStageConfig", "Id", id)
end

function manager.getGuildCopyStageNpcConfig( id )
	return search(require "GuildCopyStageNpcConfig", "Id", id)
end

function manager.getGuildCopyTownConfig( id )
	return search(require "GuildCopyTownConfig", "Id", id)
end

function manager.getGuildCopyTownsWithAreaId( areaId )
	return searchList(require "GuildCopyTownConfig", "AreaId", areaId)
end

function manager.getGuildCopyStagesWithTownId( townId )
	return searchList(require "GuildCopyStageConfig", "TownId", townId)
end

function manager.getInfoRune( id )
	return search(require "RuneConfig", "Id", id)
end

function manager.getInfoRuneSetConfig( id )
	return search(require "RuneSetConfig","Id",id)
end

function manager.getInfoEggReward( id )
	return search(require "EggReward","ID",id)
end

function manager.getInfoEggRankReward( rank )
	return search(require "EggRankReward","Rank",rank)
end

function manager.getInfoBookConfig( SkillId )
	return search(require "BookConfig", "SkillId", SkillId)
end

function manager.getInfoPerlConfig( ID )
	return search(require "PerlConfig", "ID", ID)
end

function manager.getInfoRemainNpcConfig( MID )
	return searchList(require "RemainNpcConfig", "MID", MID)
end

function manager.getInfoRemainNpcConfigLeader( MID )
	local list = searchList(require "RemainNpcConfig", "MID", MID)
	for i,v in ipairs(list) do
		if v.leader then
			return v
		end
	end
end

function manager.getInfoCharmRankReward( rank )
	return search(require "CharmRankReward","rank",rank)
end

function manager.getInfoRpRankReward( rank )
	return search(require "RPRankReward","rank",rank)
end

function manager.getInfoEqPropConfig( Prop )
	return search(require "EqPropConfig","Prop",Prop)
end

function manager.getInfoRoleCodeConfig( id )
	return search(require "RoleCodeConfig","Id",id)
end

function manager.getInfoSeniorReturn7DRewardConfig( day )
	return search(require "SeniorReturn7DRewardConfig", "Id", day)
end

function manager.getChristmasgameConfig( ... )
	return require "Christmasgame"
end

return manager