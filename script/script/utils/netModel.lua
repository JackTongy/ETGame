-- 网络请求“数据模型”接口文件

local netModel = {}
local netM = 1

function netModel.getModelRoleCreate( rid, serverId )
	return {C = "RoleCreate", M = netM, D = {Rid = rid, ServerId = serverId}}
end

function netModel.getModelRoleLogin( rid, serverId )
	return {C = "RoleLogin", M = netM, D = {Rid = rid, ServerId = serverId}}
end

function netModel.getModelRoleLoginV2( D )
	return {C = "RoleLoginV2", M = netM, D = D}
end

function netModel.getModelRoleLoginV2_1( D )
	return {C = "RoleLoginV2_1", M = netM, D = D}
end

function netModel.getModelRoleSyncAp(  )
	return {C = "RoleSyncAp", M = netM}
end

function netModel.getModelRoleCoin(  )
	return {C = "RoleCoin", M = netM}
end

function netModel.getModelGemUpgrade( id, ids )
	return {C = "GemUpgrade", M = netM, D = {Id = id, Ids = ids}}
end

function netModel.getModelPackUse( id )
	return {C = "PackUse", M = netM, D = {Id = id}}
end

function netModel.getModelUsePack( id )
	return {C = "UsePack", M = netM, D = {Id = id}}
end

function netModel.getModelPackHatch(  )
	return {C = "PackHatch", M = netM}
end

function netModel.getModelShopGet(  )
	return {C = "ShopGet", M = netM}
end

function netModel.getModelShopBuy( gid, amount )
	return {C = "ShopBuy", M = netM, D = {Gid = gid, Amount = amount}}
end

function netModel.getModelShopBuyVipGift( vip )
	return {C = "ShopBuyVipPack", M = netM, D = {Vip = vip}}
end

function netModel.getModelShopBuyMaterial( mid, amount, use )
	return {C = "ShopBuyMaterial", M = netM, D = {Mid = mid, Amount = amount, Use = use}}
end

function netModel.getModelPackBuy( materialId,Amount )
	return {C = "PackBuy", M = netM, D = {MaterialId = materialId,Amount=Amount}}
end

function netModel.getModelFriendGetFriend(  )
	return {C = "FriendGetFriend", M = netM}
end

function netModel.getModelFundGet()
	return {C = "FundGet", M = netM}
end

function netModel.getModelFundBuy()
	return {C = "FundBuy", M = netM}
end

function netModel.getModelFundLvRwdGet(lv)
	return {C = "FundLvRwdGet", M = netM, D = {Lv = lv}}
end

function netModel.getModelFundCntRwdGet(cnt)
	return {C = "FundCntRwdGet", M = netM, D = {Cnt = cnt}}
end

function netModel.getModelFriendGetInviteTasks(  )
	return {C = "FriendGetInviteTasks", M = netM}
end

function netModel.getModelFriendGetAps(  )
	return {C = "FriendGetAps", M = netM}
end

function netModel.getModelFriendGetApplys(  )
	return {C = "FriendGetApplys", M = netM}
end

function netModel.getModelFriendSearch( name )
	return {C = "FriendSearch", M = netM, D = {Name = name}}
end

function netModel.getModelFriendSearchV2( name )
	return {C = "FriendSearchV2", M = netM, D = {Name = name}}
end

function netModel.getModelFriendApply( fid )
	return {C = "FriendApply", M = netM, D = {Fid = fid}}
end

function netModel.getModelFriendAgree( id )
	return {C = "FriendAgree", M = netM, D = {Id = id}}
end

function netModel.getModelFriendRefuse( id )
	return {C = "FriendRefuse", M = netM, D = {Id = id}}
end

function netModel.getModelFriendDelete( fid )
	return {C = "FriendDelete", M = netM, D = {Fid = fid}}
end

function netModel.getModelFriendSendAp( fid )
	return {C = "FriendSendAp", M = netM, D = {Fid = fid}}
end

function netModel.getModelRoleCoin(  )
	return {C = "RoleCoin", M = netM}
end

function netModel.getModelFriendSendApAll( ... )
	return {C = "FriendSendApAll", M = netM}
end

function netModel.getModelFriendReceiveAp( fid )
	return {C = "FriendReceiveAp", M = netM, D = {Fid = fid}}
end

function netModel.getModelFriendReceiveApAll( fidListString )
	return {C = "FriendReceiveApAll", M = netM, D = {Fids = fidListString}}
end

function netModel.getModelFriendActive( code )
	return {C = "FriendActive", M = netM, D = {Code = code}}
end

function netModel.getModelFriendReceiveGift( taskId )
	return {C = "FriendReceiveGift", M = netM, D = {TaskId = taskId}}
end

function netModel.getModelFriendGetListByRandom( ... )
	return {C = "FriendGetListByRandom", M = netM}
end

function netModel.getModelFriendApplyList( fids )
	return {C = "FriendApplyList", M = netM, D = {Fids = fids}}
end

function netModel.getModelEqStrengthen( id )
	return {C = "EqStrengthen", M = netM, D = {Id = id}}
end

function netModel.getModelEqMaxStrengthen( id )
	return {C = "EqMaxStrengthen", M = netM, D = {Id = id}}
end

function netModel.getModelEqReform( id )
	return {C = "EqReform", M = netM, D = {Id = id}}
end

function netModel.getModelEqInputEnergy( id, materialId )
	return {C = "EqInputEnergy", M = netM, D = {Id = id, MaterialId = materialId}}
end

function netModel.getModelEqBreak( id )
	return {C = "EqBreak", M = netM, D = {Id = id}}
end

function netModel.getModelEqMosaic( eId, gid )
	return {C = "EqBreak", M = netM, D = {EId = eId, Gid = gid}}
end

function netModel.getModelEqMagicBox( ids )
	return {C = "EqMagicBox", M = netM, D = {Ids = ids}}
end

function netModel.getModelEqNiudan( useCoin,ten )
	return {C = "EqNiudan", M = netM, D = {UseCoin = useCoin,Ten = ten}}
end

function netModel.getModelEqChange( setIn, oid, nid, teamId )
	return {C = "EqChange", M = netM, D = {SetIn = setIn, Oid = oid, Nid = nid, TeamId = teamId}}
end

function netModel.getModelExShopGet(  )
	return {C = "ExShopGet", M = netM}
end

function netModel.getModelExShopRefresh(  )
	return {C = "ExShopRefresh", M = netM}
end

function netModel.getModelExShopBuy( id )
	return {C = "ExShopBuy", M = netM, D = {Id = id}}
end

function netModel.getModelAreaGet(  )
	return {C = "AreaGet", M = netM} 
end

function netModel.getModelBattleStart( stageId, battleId, fid )
	return {C = "BattleStart", M = netM, D = {StageId = stageId, BattleId = battleId, Fid = fid}}
end

function netModel.getModelBattleCapture( stageId, waveId, petId, hp, mid )
	return {C = "BattleCapture", M = netM, D = {StageId = stageId, WaveId = waveId, PetId = petId, Hp = hp, Mid = mid}}
end

function netModel.getModelBattleGetResult( details )
	return {C = "BattleGetResult", M = netM, D = {Details = details}}
end

function netModel.getModelPetAwake( pid ,ConsumeId)
	return {C = "PetAwake", M = netM, D = {Pid = pid,ConsumeId=ConsumeId}}
end

function netModel.getModelPetGet( pid )
	return {C = "PetGet", M = netM, D = {Pid = pid}}
end

function netModel.getModelPetGetList(  )
	return {C = "PetGetList", M = netM} 
end

function netModel.getModelPetMix( pidList )
	return {C = "PetMix", M = netM, D = {PidList = pidList}}
end

function netModel.getModelPetMotivate( pid, useGold, useCoin )
	return {C = "PetMotivate", M = netM, D = {Pid = pid, UseGold = useGold, UseCoin = useCoin}}
end

function netModel.getModelPetNiudan( pubid, useCoin )
	return {C = "PetNiudan", M = netM, D = {PubId = pubid, UseCoin = useCoin}}
end

function netModel.getModelPetNiudanTen( UseCard )
	return {C = "PetNiudanTen", M = netM, D = {UseCard = UseCard}}
end

function netModel.getModelPetPassOn( fromId, toId, mid )
	return {C = "PetPassOn", M = netM, D = {FromId = fromId, ToId = toId, Mid = mid}}
end

function netModel.getModelPetPraise( pid )
	return {C = "PetPraise", M = netM, D = {Pid = pid}}
end

function netModel.getModelPetSell( pidList )
	return {C = "PetSell", M = netM, D = {PidList = pidList}}
end

function netModel.getPetUsePs( pid )
	return {C="PetUsePs",M = netM, D = {Pid=pid}}	
end

function netModel.getPetResetMoti( pid )
	return {C="PetResetMoti",M = netM, D = {Pid=pid}}	
end

function netModel.getModelPetRename( pid,NewName )
	return {C="PetRename",M=netM,D={Pid=pid,NewName=NewName}}
end

function netModel.getModelStageGet( stageId )
	return {C = "StageGet", M = netM, D = {StageId = stageId}}
end

function netModel.getModelStageGetByTown( townId )
	return {C = "StageGetByTown", M = netM, D = {TownId = townId}}
end

function netModel.getModelTownGet( areaId )
	return {C = "TownGet", M = netM, D = {AreaId = areaId}}
end

function netModel.getModelTownGetInfo( townId )
	return {C = "TownGetInfo", M = netM, D = {TownId = townId}}
end

function netModel.getModelTownGetStages( townId, isSenior, isHero )
	return {C = "TownGetStages", M = netM, D = {TownId = townId, Senior = isSenior, Hero = isHero}}
end

function netModel.getModelStageCombatResult( stageId )
	return {C = "StageCombatResult", M = netM, D = {StageId = stageId}}
end

function netModel.getModelStageCombatFast( stageId, UseTicket )
	return {C = "StageCombatFast", M = netM, D = {StageId = stageId, UseTicket = UseTicket}}
end

function netModel.getModelResetStage( stageId )
	return {C = "ResetStage", M = netM, D = {StageId = stageId}}
end

function netModel.getModelStageFast( stageId )
	return {C = "StageFast", M = netM, D = {StageId = stageId}}
end

function netModel.getModelTownClearReward( townId, isSenior, isHero )
	return {C = "TownClearReward", M = netM, D = {TownId = townId, Senior = isSenior, Hero = isHero}}
end

function netModel.getModelTrainGetSlots(  )
	return {C = "TrainGetSlots", M = netM}
end

function netModel.getModelTrainOpenSlot(  )
	return {C = "TrainOpenSlot", M = netM}
end

function netModel.getModelTrainRefresh( max )
	return {C = "TrainRefresh", M = netM, D = {Max = max}}
end

function netModel.getModelTrainStart( pid, slotId )
	return {C = "TrainStart", M = netM, D = {Pid = pid, SlotId = slotId}}
end

function netModel.getModelTrainDismiss( slotId )
	return {C = "TrainDismiss", M = netM, D = {SlotId = slotId}}
end

function netModel.getModelTeamGetList(  )
	return {C = "TeamGetList", M = netM}
end

function netModel.getModelTeamSetActive( teamId )
	return {C = "TeamSetActive", M = netM, D = {TeamId = teamId}}
end

function netModel.getModelTeamUpdate( team, oldPid, newPid )
	return {C = "TeamUpdate", M = netM, D = {Team = team, OldPid = oldPid, NewPid = newPid}}
end

function netModel.getModelChallengeDiscover( challengeId, orderNo )
	return {C = "ChallengeDiscover", M = netM, D = {ChallengeId = challengeId, OrderNo = orderNo}}
end

function netModel.getModelChallengeOperate( challengeId, orderNo, para, fPid )
	return {C = "ChallengeOperate", M = netM, D = {ChallengeId = challengeId, OrderNo = orderNo, Para = para, FPid = fPid}}
end

function netModel.getModelChallengeFast( challengeId, orderNo )
	return {C = "ChallengeFast", M = netM, D = {ChallengeId = challengeId, OrderNo = orderNo}}
end

function netModel.getModelChallengeMysticSpace( spaceId, orderNo, para, fPid )
	return {C = "ChallengeMysticSpace", M = netM, D = {SpaceId = spaceId, OrderNo = orderNo, Para = para, FPid = fPid}}
end

function netModel.getModelPartnerGet(  )
	return {C = "PartnerGet", M = netM}
end

function netModel.getModelPartnerOpen( positionId )
	return {C = "PartnerOpen", M = netM, D = {PositionId = positionId}}
end

function netModel.getModelPartnerUpdate( positionId, petId, teamId )
	return {C = "PartnerUpdate", M = netM, D = {PositionId = positionId, PetId = petId, TeamId = teamId}}
end

function netModel.getModelStageChallenge( stageId )
	return {C = "StageChallenge", M = netM, D = {StageId = stageId}}
end

function netModel.getModelStageCombat( stageId, fPid)
	return {C = "StageCombat", M = netM, D = {StageId = stageId, FPid = fPid}}
end

function netModel.getModelPvpInvite( defRid )
	return {C = "PvpInvite", M = netM, D = {DefRid = defRid}}
end

function netModel.getModelPvpAccept(  )
	return {C = "PvpAccept", M = netM}
end

function netModel.getModelPvpCancel(  )
	return {C = "PvpCancel", M = netM}
end

function netModel.getModelRoleBuyAp(  )
	return {C = "RoleBuyAp", M = netM}
end

function netModel.getmodelEquipStrengthen( equipID )
	return {C = "EqStrengthen",m = netM,D = {Id = equipID}}
end

function netModel.getmodelEquipAutoStrengthen( equipID )
	return {C = "EqMaxStrengthen",m = netM,D = {Id = equipID}}
end

function netModel.getmodelEquipReform( equipID )
	return {C = "EqReform",m = netM,D = {Id = equipID}}
end

function netModel.getmodelEquipReformTen( equipID )
	return {C = "EqReformTen",m = netM,D = {Id = equipID}}
end

function netModel.getModelEquipBreak( id1,id2 )
	return {C = "EqBreak",m = netM,D = {Id = id1,Die = id2}}
end

function netModel.getmodelEquipRebirth( equipID )
	return {C = "EqReuse",m = netM,D = {Id = equipID}}
end

function netModel.getmodelEquipMosaic( equipID,gemID )
	return {C = "EqGemMosaic",m = netM,D = {Eid = equipID,Gid = gemID}}
end

function netModel.getmodeMosaicGem(pid, gid)
	return {C = "MosaicGem",m = netM,D = {Pid = pid, Gid = gid}}
end

function netModel.getmodeDisbandGem(gid)
	return {C = "DisbandGem",m = netM,D = {Gid = gid}}
end

function netModel.getmodelEquipUnMosaic( gemID )
	return {C = "EqGemDown",m = netM,D = {Gid = gemID}}
end

function netModel.getModelCollectionGet(  )
	return {C = "CollectionGet", M = netM}
end

function netModel.getModelPetCollectGet( ... )
	return {C = "PetCollectGet", M = netM}
end

function netModel.getmodelEquipMagicBox( Ids,Piece )
	return {C = "EqMagicBox",m = netM,D = {Ids = Ids,Piece = Piece}}
end

function netModel.getmodelMagicShopGet( )
	return {C = "ExShopGet",m = netM}
end

function netModel.getmodelMagicShopGetOnGuide( )
	return {C = "RoleFirstExShopGet",m = netM}
end

function netModel.getmodelMagicShopRefresh( free,time )
	return {C = "ExShopRefresh",m = netM,D = {Free = free,Hour = time}}
end

function netModel.getmodelMagicShopBuy( Id )
	return {C = "ExShopBuy",m = netM,D = {Id = Id}}
end

function netModel.getmodelChampionShopGet( )
	return {C = "TopStoreGet",m = netM}
end

function netModel.getmodelChampionShopRefresh( free )
	return {C = "TopStoreRefresh",m = netM,D = {Free = free}}
end

function netModel.getmodelChampionShopBuy( Id )
	return {C = "TopStoreBuy",m = netM,D = {Id = Id}}
end

function netModel.getmodelChatGet( Channel,LastId,notify )
	local b
	if notify then
		b = true
	else
		b = false
	end
	return {C = "ChatGet",m = netM,D = {Channel = Channel,LastId = LastId,Broadcast = b}}
end

function netModel.getmodelChatSend( Channel,Content,ToName,ShareType,ObjId,Broadcast )
	local chatFunc = require "ChatInfo"
	local lastchat = chatFunc.getLastChatInfo()
	local lastID = lastchat and lastchat.Id or 0
	local broad
	if Broadcast then
		broad = true
	else
		broad = false
	end
	return {C = "ChatSend",m = netM,D = {Broadcast = broad,LastId = lastID,Channel = Channel,Content = Content,ToName = ToName,ShareType = ShareType,ObjId = ObjId}}
end

function netModel.getModelLetterGetSys(  )
	return {C = "LetterGetSys", M = netM}
end

function netModel.getModelLetterGetFriend(  )
	return {C = "LetterGetFriend", M = netM}
end

function netModel.getModelLetterSend( rid, title, content )
	return {C = "LetterSend", M = netM, D = {Rid = rid, Title = title, Content = content}}
end

function netModel.getModelLetterRead( id )
	return {C = "LetterRead", M = netM, D = {Id = id}}
end

function netModel.getModelLetterReceive( id )
	return {C = "LetterReceive", M = netM, D = {Id = id}}
end

function netModel.getModelLetterDel( id )
	return {C = "LetterDel", M = netM, D = {Id = id}}
end

function netModel.getModelRoleEatDuck(  )
	return {C = "RoleEatDuck", M = netM}
end

function netModel.getModelTimePetGet(  )
	return {C = "TimePetGet", M = netM}
end

function netModel.getModelTimePetExtract( free )
	return {C = "TimePetExtract", M = netM,D = {Free = free}}
end

function netModel.getModelDailyTaskGet(  )
	return {C='DailyTaskGet',M = netM}
end

function netModel.getModelRoleRaiseTitle( ... )
	return {C='RoleRaiseTitle',M = netM}
end

function netModel.getModelDailyTaskFinish( TaskId )
	return {C='DailyTaskFinish',M = netM,D = {TaskId=TaskId}}
end

function netModel.getDailyTaskGetReward( RewardId )
	return {C='DailyTaskGetReward',M=netM,D={RewardId=RewardId}}
end

function netModel.getModelTRGet( ... )
	return {C='TRGet',M=netM}
end

function netModel.getModelTRReceive( TaskId )
	return {C='TRReceive',M=netM,D={TaskId=TaskId}}
end

function netModel.getModelTownReset( ... )
	return {C = "TownReset", M = netM}
end

function netModel.getModelTLSign(  )
	return {C = "TLSign", M = netM}
end

function netModel.getModelTLLogin( Day )
	return {C = 'TLLogin',M=netM,D={Day=Day}}
end

function netModel.getModelTLGet( ... )
	return {C = "TLGet", M = netM}
end

function netModel.getModelRechargeInfo( ... )
	return {C = "RolePayInfo", M = netM}
end

function netModel.getRoleGetFcReward( ... )
	return {C= 'RoleGetFcReward',M = netM}
end

function netModel.getModelUpgradeActInfoGet( ... )
	return {C = "LvGet", M = netM}
end

function netModel.getModelUpgradeRankActInfoGet( ... )
	return {C = "LvRankGet", M = netM}
end

function netModel.getModelUpgradeRewardActInfoGet( ... )
	return {C = "LvArriveGet", M = netM}
end

function netModel.getModelReceiveUpgradeActReward( lv )
	return {C = "LvRec", M = netM,D = {Lv = lv}}
end

function netModel.getModelActRaidInfoGet(  )
	return {C = "GetResCopy", M = netM}
end

function netModel.getModelActRaidRewardGet( type,rank,win,Stars )
	return {C = "ResCopy", M = netM,D = {Type= type,Rank = rank,Win = win,Stars=Stars}}
end

function netModel.getModelBuyResCopy( type)
	return {C = "ResCopyBuy", M = netM,D = {Type= type}}
end

function netModel.getModelPetUseCandy( Pid,Mid )
	return {C = 'PetUseCandy',M=netM,D = {Pid=Pid,Mid=Mid}}	
end

--return Pieces
function netModel.getModelPetGetPieces( )
	return {C='PetGetPieces',M=netM}
end

--return Resource
function netModel.getModelPetCompose( PetId )
	return {C='PetCompose',M=netM,D={PetId=PetId}}
end

function netModel.getModelPetReborn( Pid )
	return {C='PetReborn',M=netM,D={Pid=Pid}}	
end

function netModel.getModelRoadOfChampionGetInfo(  )
	return {C = 'TopGet',M=netM}	
end

function netModel.getModelRoadOfChampionGetRank( )
	return {C='TopRank',M=netM}
end

function netModel.getModelRoadOfChampionBuffChoose( id )
	return {C='TopBuff',M=netM,D={N=id}}
end

function netModel.getModelRoadOfChampionGetBoxReward( id )
	return {C='TopBox',M=netM,D={N=id}}
end

function netModel.getModelRoadOfChampionReset(go2Next)
	return {C='TopRefreshV2',M=netM,D = {Next = go2Next}}
end

function netModel.getModelBossGet( ... )
	return {C='BossGet',M=netM}
end

function netModel.getModelBossBattleStart( bid )
	return {C = "BossBattleStart", M = netM, D = {Bid = bid}}
end

function netModel.getModelBossBattle( Bid,Hp )
	return {C='BossBattle',M=netM,D={Bid=Bid,Hp=Hp}}
end

function netModel.getModelBossInvite( Bid,Fid )
	return {C='BossInvite',M=netM,D={Bid=Bid,Fid=Fid}}
end

function netModel.getModelBossClear( Bid )
	return {C='BossClear',M=netM,D={Bid=Bid}}
end

function netModel.getModelBossRank( Bid )
	return {C='BossRank',M=netM,D={Bid=Bid}}
end

function netModel.getModelMiaoGet(  )
	return {C = "MiaoGet", M = netM}
end

function netModel.getModelRoleMiao(  )
	return {C = "RoleMiao", M = netM}
end

function netModel.getModelArenaInfo( ... )
	return {C = "ArenaV1Info",M = netM}
end

function netModel.getModelArenaAdd( ... )
	return {C = "ArenaV1Add",M = netM}
end

function netModel.getModelArenaSetAtkTeam( id )
	return {C = "TeamSetAtk",M = netM,D = {TeamId = id}}
end

function netModel.getModelArenaSetDefTeam( id )
	return {C = "TeamSetDef",M = netM,D = {TeamId = id}}
end

function netModel.getModelArenaReportsGet( ... )
	return {C = "ArenaV1Bfs",M = netM}
end

function netModel.getModelArenaTopsGet( ... )
	return {C = "ArenaV1Tops",M = netM}
end

function netModel.getModelArenaReportGet( id )
	return {C = "ArenaV1Bf",M = netM,D = {Id= id}}
end

function netModel.getModelArenaHornorExchange( id )
	return {C = "ArenaV1Exchage",M = netM,D = {Id= id}}
end

function netModel.getModelArenaClearCD( ... )
	return {C = "ArenaV1CCD",M = netM}
end

function netModel.getModelArenaBuyCount( ... )
	return {C = "ArenaV1ExCount",M = netM}
end

function netModel.getModelArenaBattle( rid,no,ino )
	return {C = "ArenaV1Go",M = netM,D = {Rid = rid,No = no,iNo = ino}}
end

function netModel.getModelArenaTeamEquipmentInfo( rid,tid )
	return {C = "ArenaV1EquipmentInfo",M = netM,D = {Rid = rid,Tid = tid}}
end

function netModel.getBossAtkGet( BossId )
	return {C='BossAtkGet',M=netM,D={BossId=BossId}}
end

function netModel.getBossAtkGetHarms( BossId )
	return {C='BossAtkGetHarms',M=netM,D={BossId=BossId}}
end

function netModel.getBossAtkStart( BossId )
	return {C='BossAtkStart',M=netM,D={BossId=BossId}}
end

function netModel.getBossAtkCd( BossId )
	return {C='BossAtkCd',M=netM,D={BossId=BossId}}
end

function netModel.getModelRoleGetEgg(  )
	return {C = "RoleGetEgg", M = netM}
end

function netModel.getModelRoleNewsUpdate( key, value )
	return {C = "RoleNewsUpdate", M = netM, D = {Key = key, V = value}}
end

function netModel.getBossAtkRank( BossId )
	return {C='BossAtkRank',M=netM,D={BossId=BossId}}	
end

function netModel.getBossAtkHarm( BossId,Harm )
	return {C='BossAtkHarm',M=netM,D={BossId=BossId,Harm=Harm}}
end

function netModel.getDChGet( ... )
	return {C='DChGet',M=netM}
end

function netModel.getDChReward( N )
	return {C='DChReward',M=netM,D={N=N}}
end

function netModel.getTChGet( ... )
	return {C='TChGet',M=netM}
end

function netModel.getTChReward( N )
	return {C='TChReward',M=netM,D={N=N}}
end

function netModel.getTCsGet( ... )
	return {C='TCsGet',M=netM}
end

function netModel.getTCsReward( N )
	return {C='TCsReward',M=netM,D={N=N}}
end

function netModel.getExGet( ... )
	return {C='ExGet',M=netM}
end

function netModel.getExReward( N )
	return {C='ExReward',M=netM,D={N=N}}
end

function netModel.getOChGet( ... )
	return {C='OChGet',M=netM}
end

function netModel.getOChReward( ... )
	return {C='OChReward',M=netM}
end

function netModel.getModelGemGetList( ... )
	return {C = "GemGetList", M = netM}
end

function netModel.getModelMaterialGetList( ... )
	return {C = "MaterialGetList", M = netM}
end

function netModel.getModelActivityGetList( ... )
	return {C = "ActivityGetList", M = netM}
end

function netModel.getModelCompeGet( ... )
	return {C = "CompeGet", M = netM}
end

function netModel.getModelEqGetList(  )
	return {C = "EqGetList", M = netM}
end

function netModel.getModelPackGetList( ... )
	return {C = "PackGetList", M = netM}
end

--引导相关接口
function netModel.getRoleNewStepUpdate(Step)
	return {C='RoleNewStepUpdate',M=netM,D={Step=Step}}
end

function netModel.getRolePreStep(Step)
	return {C='RolePreStep',M=netM,D={Step=Step}}
end

function netModel.getRoleChooseHero( PetId )
	return {C='RoleChooseHero',M=netM,D={PetId=PetId}}
end

function netModel.getRoleFirstNiudan( ... )
	return {C='RoleFirstNiudan',M=netM}
end

function netModel.getUnlockExShop( ... )
	return {C='UnlockExShop',M=netM}
end

function netModel.getUnlockMagicBox( ... )
	return {C='UnlockMagicBox',M=netM}
end

function netModel.getRoleRename( Name )
	return {C='RoleRename',M=netM,D={Name=Name}}	
end

function netModel.getPetArchive( Pids )
	return {C='PetArchive',M=netM,D={Pids=Pids}}
end

function netModel.getPetUseFruit( Pid,Fruits )
	return {C='PetUseFruit',M=netM,D={Pid=Pid,Fruits=Fruits}}
end

function netModel.getPetUseBadge( Pid )
	return {C='PetUseBadge',M=netM,D={Pid=Pid}}
end

function netModel.getModelGuildGetApplyAll( id )
	return {C = "GuildGetApplyAll", M = netM, D = {Id = id}}
end

function netModel.getModelGuildApply( id )
	return {C = "GuildApply", M = netM, D = {Id = id}}
end

function netModel.getModelGuildAgree( id )
	return {C = "GuildAgree", M = netM, D = {Id = id}}
end

function netModel.getModelGuildRefuse( id )
	return {C = "GuildRefuse", M = netM, D = {Id = id}}
end

function netModel.getModelGuildMemberGet( gid )
	return {C = "GuildMemberGet", M = netM, D = {Id = gid}}
end

function netModel.getModelGuildMemberDel( gid, fid )
	return {C = "GuildMemberDel", M = netM, D = {Gid = gid, Fid = fid}}
end

function netModel.getModelGuildSetPresident( id, fid )
	return {C = "GuildSetPresident", M = netM, D = {Id = id, Fid = fid}}
end

function netModel.getModelGuildSetVicePresident( id, fid )
	return {C = "GuildSetVicePresident", M = netM, D = {Id = id, Fid = fid}}
end

function netModel.getModelClubGetLast10( ... )
	return {C = "GuildGetLast10", M = netM}
end

function netModel.getModelClubRefresh10( ... )
	return {C = "GuildRefresh10", M = netM}
end

function netModel.getModelClubSearch( name )
	return {C = "GuildSearchV2", M = netM,D = {Title = name}}
end

function netModel.getModelClubCreate( name,pic )
	return {C = "GuildCreate", M = netM,D = {Title = name,Pic = pic}}
end

function netModel.getModelClubJoin( id )
	return {C = "GuildApply", M = netM,D = {Id = id}}
end

function netModel.getModelClubCancelJoin( id )
	return {C = "GuildCancel", M = netM,D = {Id = id}}
end

function netModel.getModelGuildMemberDonate( Type )
	return {C = 'GuildMemberDonate',M=netM,D={Type=Type}}
end

function netModel.getModelGuildDelVicePresident( id, fid )
	return {C = "GuildDelVicePresident", M = netM, D = {Id = id, Fid = fid}}
end

function netModel.getModelGuildSendLetter( id, title, content )
	return {C = "GuildSendLetter", M = netM, D = {Id = id, Title = title, Content = content}}
end

function netModel.getModelGuildGet( Id )
	return {C='GuildGet',M=netM,D={Id=Id}}
end

function netModel.getModelGuildMemberSign( ... )
	return {C='GuildMemberSign',M=netM}
end

function netModel.getModelGuildGetRanks( ... )
	return {C='GuildGetRanks',M=netM}
end

function netModel.getModelGuildSave( Id,Lv,Pic,Des )
	return {C='GuildSave',M=netM,D={Id=Id,Lv=Lv,Pic=Pic,Des=Des}}
end

function netModel.getModelGuildDisband( ... )
	return {C='GuildDisband',M=netM}
end

function netModel.getModelGuildMemberLeave( ... )
	return {C='GuildMemberLeave',M=netM}
end


function netModel.getModelGuildStoreBuy( Id )
	return {C='GuildStoreBuy',M=netM,D={Id=Id}}
end

function netModel.getModelMaterialSell( mid, amount )
	return {C = "MaterialSell", M = netM, D = {Mid = mid, Amt = amount}}
end

function netModel.getModelGuildUpgradeLv( Id )
	return {C='GuildUpgradeLv',M=netM,D={Id=Id}}	
end

function netModel.getModelGuildUpgradeTcLv( Id,Type )
	return {C='GuildUpgradeTcLv',M=netM,D={Id=Id,Type=Type}}
end

function netModel.getModelGuildMemberUpgradeTcLv( Type )
	return {C='GuildMemberUpgradeTcLv',M=netM,D={Type=Type}}
end

function netModel.getModelExCodeDh( Code )
	return {C = "ExCodeDh", M = netM, D = {Code = Code}}
end

function netModel.getModelRoleUseNapkin( Key )
	return {C='RoleUseNapkin',M=netM,D={Key=Key}}
end

function netModel.getModelBoxOpen10( id )
	return {C = "BoxOpen10", M = netM, D = {Id = id}}
end

-- function netModel.getModelPetSynth( pidList )
-- 	return {C = "PetSynth", M = netM, D = {Pids = pidList}}
-- end

function netModel.getModelEqSell( idList )
	return {C = "EqSell", M = netM, D = {Ids = idList}}
end

function netModel.getModelEqChangeOk( setIn, list, teamId )
	return {C = "EqChangeOk", M = netM, D = {SetIn = setIn, EqIds = list, TeamId = teamId}}
end

function netModel.getModelLogonInfo( )
	return {C = "LogonInfo", M = netM}
end

function netModel.getModelPetEvolution(petID, toID)
	return {C = "PetEvolution", M = netM, D = {Pid = petID, ToId = toID}}
end

-- PetMegaEvo
-- 百万进化
-- 请求数据
-- 参数 类型 说明
-- Pid Long 精灵唯一 id
-- ToPetId Int 目标精灵配置 id
-- ConsumeIds List<long> 要消耗的精灵唯一 id 列表
-- 返回数据
-- 参数 类型 说明
-- Pet Pet 进化后的精灵数据
-- Resource Resource 包含更新后的玩家数据、道具列表（百万进
-- 化石和潜力石）
function netModel.getModelPetMegaEvolution(petID, toID, ids)
	return {C = "PetMegaEvo", M = netM, D = {Pid = petID, ToPetId = toID, ConsumeIds = ids}}
end

function netModel.getModelPetSynthesis(petIDs, resultID)
	return {C = "PetSynth", M = netM, D = {Pids = petIDs, TargetId = resultID}} 
end

function netModel.getModelPrayGet( )
	return {C = "PrayGet", M = netM}
end

function netModel.getModelPrayPray( )
	return {C = "PrayPray", M = netM}
end

function netModel.getModelPrayFinalReward( )
	return {C = "PrayFinalReward", M = netM}
end

function netModel.getModelTopBattleStart( petIdList )
	return {C = "TopBattleStart", M = netM, D = {Ids = petIdList}}
end

function netModel.getModelGetStages( stageIds )
	return {C = "GetStages", M = netM, D = {StageIds = stageIds}}
end

function netModel.getModelExploreGet()
	return {C = "ExploreGet", M = netM}
end

function netModel.getModelExploreSend(sid, hours, pid)
	return {C = "ExploreSend", M = netM, D = {Sid = sid, Hours = hours, Pid = pid}}
end

function netModel.getModelExploreFinish(sid)
	return {C = "ExploreFinish", M = netM, D = {Sid = sid}}
end

function netModel.getRolePush( Channel,V )
	return {C= "RolePush", M = netM,D={Channel=Channel,V=V}}
end

function netModel.getModelRoleSwitchPush( CanDo, Lt, Ap, Ap2, Ba, Bt, Exr )
	return {C = "RoleSwitchPush", M = netM, D = {CanDo = CanDo, Lt = Lt, Ap = Ap, Ap2 = Ap2, Ba= Ba, Bt = Bt, Exr = Exr}}
end

function netModel.getModelRolePushInfo( ... )
	return {C = "RolePushInfo", M = netM} 
end

function netModel.getTaskMainGet( ... )
	return {C = 'TaskMainGet',M=netM}
end

function netModel.getTaskMainGetReward( TaskId )
	return {C='TaskMainGetReward',M=netM,D={TaskId=TaskId}}
end

function netModel.getModelPetEvToList( Pid )
	return {C= "PetEvToList", M = netM, D={Pid = Pid}}
end

function netModel.getPetZhaohuan( PetId,Ten )
	return {C='PetZhaohuan',M=netM,D={PetId=PetId,Ten=Ten}}
end

function netModel.getRanks()
	return {C='RanksGet', M = netM}--, D={PetId=PetId,Ten=Ten}}
end

function netModel.getTempTeamInfo(userID)
	return {C='RankGetTempTeam', M = netM, D = {Rid = userID}}
end

function netModel.getTeamDetailsInfo(userID)
	return {C='TeamGetDetails', M = netM, D = {Rid = userID}}
end

function netModel.getModelAreaGetBox( AreaId )
	return {C = "AreaGetBox", M = netM, D = {AreaId = AreaId}}
end

function netModel.getModelAreaGetReward( id )
	return {C = "AreaGetReward", M = netM, D = {Id = id}}
end

function netModel.getModelBossReceive( Pid )
	return {C = "BossReceive",M = netM,D = {Pid = Pid}}
end

function netModel.getModelBuyDiscGood( day )
	return {C = "BuyDiscGood", M = netM, D = {Day = day}}
end

function netModel.getModelHongbaoRankGet(  )
	return {C = "HongbaoRankGet", M = netM}
end

function netModel.getModelHongbaoRob( id )
	return {C = "HongbaoRob", M = netM, D = {Id = id}}
end

function netModel.getModelHongbaoSummaryGet( ... )
	return {C = "HongbaoSummaryGet", M = netM}
end

function netModel.getModelHongbaoExInfo( ... )
	return {C = "HongbaoExInfo", M = netM}
end

function netModel.getModelHongbaoExchange( ExId, Amt )
	return {C = "HongbaoExchange", M = netM, D = {ExId = ExId, Amt = Amt or 1}}
end

function netModel.getModelTeamTypeUpdate( teamId, atkType, defType )
	return {C = "TeamTypeUpdate", M = netM, D = {TeamId = teamId, AtkType = atkType, DefType = defType}}
end

function netModel.getModelCharge7Day( )
	return {C = "SdChargeGet", M = netM}
end

function netModel.getModelActivityGet( Type )
	return {C = "ActivityGet",M = netM,D = {Type=Type}}
end

function netModel.getModelCharge7DayDetail( )
	return {C = "SdChargeAll", M = netM}
end

function netModel.getModelMondayGiftGet( ... )
	return {C='MondayGiftGet',M=netM}
end

function netModel.getModelMondayGiftReward( ... )
	return {C='MondayGiftReward',M=netM}
end

function netModel.getModelLoginGiftGet( ... )
	return {C='LoginGiftGet',M=netM}
end

function netModel.getModelLoginGiftReward( ... )
	return {C='LoginGiftReward',M=netM}
end

function netModel.getModelCsInfo(  )
	return {C = "CsInfo", M = netM}
end

function netModel.getModelCsInfoUpdate( ... )
	return {C = "CsInfoUpdate", M = netM}
end

function netModel.getModelCsPlayerRefresh( ... )
	return {C = "CsPlayerRefresh", M = netM}
end

function netModel.getModelCsDefPetList( id )
	return {C = "CsDefPetList", M = netM, D = {Id = id}}
end

function netModel.getModelCsChallenge( id )
	return {C = "CsChallenge", M = netM, D = {Id = id}}
end

function netModel.getModelCsShopGet( ... )
	return {C = "CsShopGet", M = netM}
end

function netModel.getModelCsShopRefresh( ... )
	return {C = "CsShopRefresh", M = netM}
end

function netModel.getModelCsShopBuy( Index )
	return {C = "CsShopBuy", M = netM, D = {Index = Index}}
end

function netModel.getModelCsRankGroup( ... )
	return {C='CsRankGroup',M=netM}
end

function netModel.getModelCsRankTotal( ... )
	return {C='CsRankTotal',M=netM}
end

function netModel.getModelCsRankServer( ... )
	return {C='CsRankServer',M=netM}
end

function netModel.getModelComposeRecordGet( ... )
	return {C='ComposeRecordGet',M=netM}
end

function netModel.getModelTeamSetCsType( teamId, csType, IsAtk )
	return {C = "TeamSetCsType", M = netM, D = {TeamId = teamId, CsType = csType, IsAtk = IsAtk}}
end

function netModel.getModelCsRecover( )
	return {C = "CsRecover", M = netM}
end

function netModel.getModelAdvReward( isBuy )
	return {C = "AdvReward", M = netM, D = {Buy = isBuy or false}}
end

function netModel.getModelAdvRanks(model)
	return {C = "AdvRanks", M = netM, D = {Type = model}}
end

function netModel.getModelAdvGet(  )
	return {C = "AdvGet", M = netM}
end

function netModel.getModelAdvChooseType( Type )
	return {C = "AdvChooseType", M = netM, D = {Type = Type}}
end

function netModel.getModelAdvChooseStageType( Type )
	return {C = "AdvChooseStageType", M = netM, D = {Type = Type}}
end

function netModel.getModelAdvBuff( Index )
	return {C = "AdvBuff", M = netM, D = {Index = Index}}
end

function netModel.getModelAdvFast( ... )
	return {C = "AdvFast", M = netM}
end

function netModel.getModelAdvReset( ... )
	return {C = "AdvReset", M = netM}
end

function netModel.getModelPetMotivateAll( Pid )
	return {C = "PetMotivateAll",M = netM,D={Pid = Pid}}
end

function netModel.getModelTopPass(  )
	return {C = "TopPass", M = netM}
end

function netModel.getExRewardV2( N, Pids)
	return {C='ExRewardV2',M=netM,D={N=N,Pids=Pids}}
end

function netModel.getModelAdvBoxBuyGet(  )
	return {C = "AdvBoxBuyGet", M = netM}
end

function netModel.getModelAdvBoxBuyReward( Index )
	return {C = "AdvBoxBuyReward", M = netM, D = {Index = Index}}
end

function netModel.getModelLuckyDrawGet( ... )
	return {C = "LuckyDrawGet", M = netM}
end

function netModel.getModelLuckyDrawDraw( isTen )
	return {C = "LuckyDrawDraw", M = netM, D = {Ten = isTen}}
end

function netModel.getModelLuckyDrawRefresh( ... )
	return {C = "LuckyDrawRefresh", M = netM}
end

function netModel.getModelMCardGiftGet( ... )
	return {C = "MCardGiftGet", M = netM}
end

function netModel.getModelMCardGiftReward( ... )
	return {C = "MCardGiftReward", M = netM}
end

function netModel.getModelPetGetArchived( PetId )
	return {C = 'PetGetArchived',M = netM,D={PetId=PetId}}
end

function netModel.getModelGuildFightStoreGet( ... )
	return {C = "GuildFightStoreGet", M = netM}
end

function netModel.getModelGuildFightStoreBuy( id )
	return {C = "GuildFightStoreBuy", M = netM, D = {Id = id}}
end

function netModel.getModelGuildFightStoreRefreshTime( ... )
	return {C = "GuildFightStoreRefreshTime", M = netM}
end

function netModel.getModelGuildFightStoreRefreshFree( ... )
	return {C = "GuildFightStoreRefreshFree", M = netM}
end

function netModel.getModelGuildFightStoreRefreshCost( ... )
	return {C = "GuildFightStoreRefreshCost", M = netM}
end

function netModel.getModelGuildMatchPlayerGet( ... )
	return {C = "GuildMatchPlayerGet", M = netM}
end

function netModel.getModelGuildMatchSetAtkTeam( teamId, type )
	return {C = "GuildMatchSetAtkTeam", M = netM, D = {TeamId = teamId, Type = type}}
end

function netModel.getModelGuildMatchSetDefTeam( teamId, type )
	return {C = "GuildMatchSetDefTeam", M = netM, D = {TeamId = teamId, Type = type}}
end

function netModel.getModelGuildMatchHomeInfo( ServerId, GuildId )
	return {C = "GuildMatchHomeInfo", M = netM, D = {ServerId = ServerId, GuildId = GuildId}}
end

function netModel.getModelGuildMatchCastleDetails( castleId, serverId, guildId )
	return {C = "GuildMatchCastleDetails", M = netM, D = {CastleId = castleId, ServerId = serverId, GuildId = guildId}}
end

function netModel.getModelGuildMatchScheduleGet( ... )
	return {C = "GuildMatchScheduleGet", M = netM}
end

function netModel.getModelGuildMatchGet( ... )
	return {C = "GuildMatchGet", M = netM}
end

function netModel.getModelGuildMatchClearCd( ... )
	return {C = "GuildMatchClearCd", M = netM}
end

function netModel.getModelGuildMatchAttack( castleId, serverId, guildId )
	return {C = "GuildMatchAttack", M = netM, D = {CastleId = castleId, ServerId = serverId, GuildId = guildId}}
end

function netModel.getModelGuildMatchSendDefTeam( castleId, teamId, playerId )
	return {C = "GuildMatchSendDefTeam", M = netM, D = {CastleId = castleId, TeamId = teamId, PlayerId = playerId}}
end

function netModel.getModelGuildMatchCmd( castleId, cmd, target )
	return {C = "GuildMatchCmd", M = netM, D = {CastleId = castleId, Cmd = cmd, Target = target}}
end

function netModel.getModelGuildMatchSignUp( ... )
	return {C = 'GuildMatchSignUp',M = netM}
end

function netModel.getModelGuildMatchBossBuy( ... )
	return {C = "GuildMatchBossBuy", M = netM}
end

function netModel.getModelGuildMatchBossGet( ... )
	return {C = "GuildMatchBossGet", M = netM}
end

function netModel.getModelWellGet( ... )
	return {C = "WellGet", M = netM}
end

function netModel.getModelWellUse( ... )
	return {C = "WellUse", M = netM}
end

function netModel.getModelEqMaxStrengthenAll( teamId, setIn, pid, eqIds )
	return {C = "EqMaxStrengthenAll", M = netM, D = {TeamId = teamId, SetIn = setIn, Pid = pid, EqIds = eqIds}}
end

function netModel.getModelMibaoGetAll( ... )
	return {C = "MibaoGetAll", M = netM}
end

function netModel.getModelMibaoGetPieces( ... )
	return {C = "MibaoGetPieces", M = netM}
end

function netModel.getMibaoPieceCompose( MibaoId )
	return {C = "MibaoPieceCompose", M = netM, D = {MibaoId = MibaoId}}
end

function netModel.getMibaoStrength( id,mids )
	return {C = "MibaoStrength", M = netM, D = {Mid = id,ConsumeIds = mids}}
end

function netModel.getMibaoForge( id,mids )
	return {C = "MibaoForge", M = netM, D = {Mid = id,ConsumeIds = mids}}
end

function netModel.getMibaoRebirth( id )
	return {C = "MibaoReforge", M = netM, D = {Mid = id}}
end

function netModel.getMibaoRefine( id,materialId )
	return {C = "MibaoRefine", M = netM, D = {Mid = id,ConsumeId = materialId}}
end

function netModel.getModelMibaoEquip( Mid, PetNo )
	return {C = "MibaoEquip", M = netM, D = {Mid = Mid, PetNo = PetNo}}
end

function netModel.getModelGuildMatchBuyAp( ... )
	return {C = "GuildMatchBuyAp", M = netM}
end

function netModel.getModelGuildMatchInfoGet( ... )
	return {C = "GuildMatchInfoGet", M = netM}
end

function netModel.getModelDoctorTaskGet( ... )
	return {C = "DoctorTaskGet",M=netM}
end

function netModel.getModelDoctorTaskReward( Index )
	return {C = "DoctorTaskReward",M=netM,D={Index = Index}}
end

function netModel.getModelAdvBoxRwdGet( index )
	return {C = "AdvBoxRwdGet", M = netM, D = {Index = index}}
end

function netModel.getModelAdvExchange( index )
	return {C = "AdvExchange", M = netM, D = {Index = index}}
end

function netModel.getModelAdvFastAll( ... )
	return {C = "AdvFastAll", M = netM}
end

function netModel.getModelLuxurySignGet( ... )
	return {C = "LuxurySignGet", M = netM}
end

function netModel.getModelLuxurySignReceive( ... )
	return {C = "LuxurySignReceive", M = netM}
end

function netModel.getModelTuangouGet(  )
	return {C = "GroupPurchaseGet", M = netM}
end

function netModel.getModelTuangouBuy( n )
	return {C = "GroupPurchaseBuy", M = netM,D = {N = n}}
end

function netModel.getModelLuckyLotteryGet( ... )
	return {C = 'LuckyLotteryGet',M = netM}
end

function netModel.getModelLuckyLotteryReceive( N )
	return {C = 'LuckyLotteryReceive',M=netM,D={N=N}}
end

function netModel.getModelRoleRenameCost( ... )
	return {C = "RoleRenameCost", M = netM}
end

function netModel.getModelCard21Get( ... )
	return {C = "Card21Get", M = netM}
end

function netModel.getModelCard21Bet( Bet )
	return {C = "Card21Bet", M = netM, D = {Bet = Bet}}
end

function netModel.getModelCard21Hit( ... )
	return {C = "Card21Hit", M = netM}
end

function netModel.getModelCard21Stand( ... )
	return {C = "Card21Stand", M = netM}
end

function netModel.getModelCard21PointEx( Index )
	return {C = "Card21PointEx", M = netM, D = {Index = Index}}
end

function netModel.getModelCard21ShopInfo( ... )
	return {C = "Card21ShopInfo", M = netM}
end

function netModel.getModelCard21ShopEx( ExId, Amt )
	return {C = "Card21ShopEx", M = netM, D = {ExId = ExId, Amt = Amt}}
end

function netModel.getModelGuildCopyPetSend( Pid )
	return {C = "GuildCopyPetSend", M = netM, D = {Pid = Pid}}
end

function netModel.getModelGuildCopyPetsGet( ... )
	return {C = "GuildCopyPetsGet", M = netM}
end

function netModel.getModelGuildCopyBoxOpen( Box )
	return {C = "GuildCopyBoxOpen", M = netM, D = {Box = Box}}
end

function netModel.getModelGuildCopyChallenge( StageId, GcpId )
	return {C = "GuildCopyChallenge", M = netM, D = {StageId = StageId, GcpId = GcpId}}
end

function netModel.getModelGuildCopyTimesBuy( ... )
	return {C = "GuildCopyTimesBuy", M = netM}
end

function netModel.getModelGuildCopyGet( ... )
	return {C = "GuildCopyGet", M = netM}
end

function netModel.getModelGuildCopyStagesGet( AreaId )
	return {C = "GuildCopyStagesGet", M = netM, D = {AreaId = AreaId}}
end

function netModel.getModelGuildCopyTownReward( TownId )
	return {C = "GuildCopyTownReward", M = netM, D = {TownId = TownId}}
end

function netModel.getModelGuildCopyTimesBuy( ... )
	return {C = "GuildCopyTimesBuy", M= netM}
end

function netModel.getModelGuildCopyStageFast( StageId )
	return {C = "GuildCopyStageFast", M = netM, D = {StageId = StageId}}
end

function netModel.getModelRuneUpgrade( id )
	return {C = "RuneUpgrade", M = netM, D = {Id = id}}
end

function netModel.getModelRuneUpgradeAll( ids )
	return {C = "RuneUpgradeAll", M = netM, D = {Ids = ids}}
end

function netModel.getModelRuneResolve( ids )
	return {C = "RuneBreakDown", M = netM, D = {Ids = ids}}
end

function netModel.getModelRuneReborn( id )
	return {C = "RuneResue", M = netM, D = {Id = id}}
end

function netModel.getModelRuneRebornToLv( id,lv )
	return {C = "RuneResueOfLv", M = netM, D = {Id = id,Lv = lv}}
end

function netModel.getModelRuneMosaic( equipmentId,runeId )
	return {C = "RuneUp", M = netM, D = {EquipmentId = equipmentId,Id = runeId}}
end

function netModel.getModelRuneMosaicAll( equipmentId,runeIds )
	return {C = "RuneUpAll", M = netM, D = {EquipmentId = equipmentId,Ids = runeIds}}
end

function netModel.getModelRuneMosaicDown( equipmentId,runeId )
	return {C = "RuneDown", M = netM, D = {EquipmentId = equipmentId,Id = runeId}}
end

function netModel.getModelRuneGetList( ... )
	return {C = "RuneGetList", M = netM}
end

function netModel.getModelSevenDaysRewardGet( ... )
	return {C = 'SevenDaysRewardGet',M = netM}
end

function netModel.getModelSevenDaysRewardReceive( N )
	return {C = 'SevenDaysRewardReceive',M = netM,D = {N=N}}
end

function netModel.getModelGuildMyPointGet( ... )
	return {C = 'GuildMyPointGet',M = netM}
end

function netModel.getModelGuildElectionStart(  )
	return {C = "GuildElectionStart", M = netM}
end

function netModel.getModelGuildVote( presidentId )
	return {C = "GuildVote", M = netM, D = {PresidentId = presidentId}}
end

function netModel.getModelBossInviteAll( Bid )
	return {C = 'BossInviteAll',M = netM, D = {Bid = Bid}}
end

function netModel.getModelPartnerLvUp( PositionId, Rate )
	return {C = "PartnerLvUp", M = netM, D = {PositionId = PositionId, Rate = Rate}}
end

function netModel.getModelTimeCopyGet( ... )
	return {C = "TimeCopyGet", M = netM}
end

function netModel.getModelTimeCopyStagesGet( ... )
	return {C = "TimeCopyStagesGet", M = netM}
end

function netModel.getModelTimeCopyTicketBuy( Cnt )
	return {C = "TimeCopyTicketBuy", M = netM, D = {Cnt = Cnt or 1}}
end

function netModel.getModelTimeCopyZhaohuan( PetId )
	return {C = "TimeCopyZhaohuan", M = netM, D = {PetId = PetId}}
end

function netModel.getModelTimeCopyShopEx( ExId, Amt )
	return {C = "TimeCopyShopEx", M = netM, D = {ExId = ExId, Amt = Amt}}
end

function netModel.getModelTimeCopyShopInfo( ... )
	return {C = "TimeCopyShopInfo", M = netM}
end

function netModel.getModelTimeCopySettle( StageId, Stars, Cnt )
	return {C = "TimeCopySettle", M = netM, D = {StageId = StageId, Stars = Stars, Cnt = Cnt or 1}}
end

function netModel.getModelFateWheelGet( ... )
	return {C = "FateWheelGet", M = netM}
end

function netModel.getModelFateWheelGo( Cnt )
	return {C = "FateWheelGo", M = netM, D = {Cnt = Cnt}}
end

function netModel.getModelFateWheelKeysBuy( Amt )
	return {C = "FateWheelKeysBuy", M = netM, D = {Amt = Amt}}
end

function netModel.getModelFateWheelRwdGet( Coin )
	return {C = "FateWheelRwdGet", M = netM, D = {Coin = Coin}}
end

function netModel.getModelExploreDataGet(  )
	return {C = "ExploreDataGet", M = netM}
end

function netModel.getModelExploreAtkSet( TeamId, AtkType )
	return {C = "ExploreAtkSet", M = netM, D = {TeamId = TeamId, AtkType = AtkType}}
end

function netModel.getModelExploreDefSet( TeamId, DefType )
	return {C = "ExploreDefSet", M = netM, D = {TeamId = TeamId, DefType = DefType}}
end

function netModel.getModelExploreInvite( Pid )
	return {C = "ExploreInvite", M = netM, D = {Pid = Pid}}
end

function netModel.getModelExploreSearch( ... )
	return {C = "ExploreSearch", M = netM}
end

function netModel.getModelExploreRobStart( ... )
	return {C = "ExploreRobStart", M = netM}
end

function netModel.getModelExploreRobSettle( Win )
	return {C = "ExploreRobSettle", M = netM, D = {Win = Win}}
end

function netModel.getModelExploreRevengeStart( SlotId )
	return {C = "ExploreRevengeStart", M = netM, D = {SlotId = SlotId}}
end

function netModel.getModelExploreRevengeSettle( Win, SlotId )
	return {C = "ExploreRevengeSettle", M = netM, D = {Win = Win, SlotId = SlotId}}
end

function netModel.getModelExploreReportGet( ... )
	return {C = "ExploreReportGet", M = netM}
end

function netModel.getModelExploreRevengeGet( SlotId )
	return {C = "ExploreRevengeGet", M = netM, D = {SlotId = SlotId}}
end

function netModel.getModelEggHatchGet( ... )
	return {C = "EggHatchGet", M = netM}
end

function netModel.getModelEggHatchRwdGet( Index )
	return {C = "EggHatchRwdGet", M = netM, D = {Index = Index}}
end

function netModel.getModelEggHatchRankGet( ... )
	return {C = "EggHatchRankGet", M = netM}
end

function netModel.getModelGuildMatchBox( ... )
	return {C = "GuildMatchBox", M = netM}
end

function netModel.getModelGuildMatchRecover( ... )
	return {C = "GuildMatchRecover", M = netM}
end

function netModel.getModelRemainGet( ... )
	return {C = "RemainGet", M = netM}
end

function netModel.getModelRemainRp( ... )
	return {C = "RemainRp", M = netM}
end

function netModel.getModelRemainUncover( Id )
	return {C = "RemainUncover", M = netM, D = {Id = Id}}
end

function netModel.getModelRemainOp( Id, Hps )
	return {C = "RemainOp", M = netM, D = {Id = Id, Hps = Hps}}
end

function netModel.getModelRemainReset( ... )
	return {C = "RemainReset", M = netM}
end

function netModel.getModelRemainPerlSyn( Pids )
	return {C = "RemainPerlSyn", M = netM, D = {Pids = Pids}}
end

function netModel.getModelRemainTimesGet( ... )
	return {C = "RemainTimesGet", M = netM}
end

function netModel.getModelBooksGet( ... )
	return {C = "BooksGet", M = netM}
end

function netModel.getModelPerlsGet( ... )
	return {C = "PerlsGet", M = netM}
end

function netModel.getModelBookPiecesGet( ... )
	return {C = "BookPiecesGet", M = netM}
end

function netModel.getModelRemainBookSyn( Pid )
	return {C = "RemainBookSyn", M = netM, D = {Pid = Pid}}
end

function netModel.getModelPetSkillUp( Pid, Bids)
	return {C = "PetSkillUp", M = netM, D = {Pid=Pid,Bids=Bids}}
end

function netModel.getModelPetLearn(Pid,Bid)
	return {C = "PetLearn", M = netM, D = {Pid=Pid,Bid=Bid}}
end

function netModel.getModelPetSkillTp(Pid,Bid)
	return {C = "PetSkillTp", M = netM, D = {Pid=Pid,Bid=Bid}}
end

function netModel.getModelMysteryShopGet( ... )
	return {C = "MysteryShopGet", M = netM}
end

function netModel.getModelMysteryShopBuy( Id )
	return {C = "MysteryShopBuy", M = netM, D = {Id = Id}}
end

function netModel.getModelMysteryShopBuyGift( Id )
	return {C = "MysteryShopBuyGift", M = netM, D = {Id = Id}}
end

function netModel.getModelMysteryShopSell( Id, Amount )
	return {C = "MysteryShopSell", M = netM, D = {Id = Id, Amount = Amount}}
end

function netModel.getModelMysteryShopRefresh( )
	return {C = "MysteryShopRefresh", M = netM}
end

function netModel.getModelMysteryShopSend( Fid, Amount )
	return {C = "MysteryShopSend", M = netM, D = {Fid = Fid, Amount = Amount}}
end

function netModel.getModelMysteryShopGetRanks(  )
	return {C = "MysteryShopGetRanks", M = netM}
end

function netModel.getModelMysteryShopGetFriends(  )
	return {C = "MysteryShopGetFriends", M = netM}
end

function netModel.getModelRemainRanksGet( ... )
	return {C = "RemainRanksGet", M = netM}
end

function netModel.getModelRemainBuyGlass( ... )
	return {C = "RemainBuyGlass", M = netM}
end

function netModel.getModelRemainUseGlass( Id )
	return {C = "RemainUseGlass", M = netM, D = {Id = Id}}
end

function netModel.getModelEqIdentify( Ids )
	return {C = "EqIdentify", M = netM, D = {Ids = Ids}}
end

function netModel.getModelEqPropRefresh( Id, Idx, Cid )
	return {C = "EqPropRefresh", M = netM, D = {Id = Id, Idx = Idx, Cid = Cid}}
end

function netModel.getModelEqPropRestore( Id )
	return {C = "EqPropRestore", M = netM, D = {Id = Id}}
end

function netModel.getModelEqPropTransfer( Id, Cid )
	return {C = "EqPropTransfer", M = netM, D = {Id = Id, Cid = Cid}}
end

function netModel.getModelEqPropUnlock( ... )
	return {C = "EqPropUnlock", M = netM}
end

function netModel.getModelGuildRename( Title, Pic )
	return {C = "GuildRename", M = netM, D = {Title = Title, Pic = Pic}}
end

function netModel.getModelLetterReceiveAll( ... )
	return {C = "LetterReceiveAll", M = netM}
end

function netModel.getModelLetterDelAll( Sys )
	return {C = "LetterDelAll", M = netM, D = {Sys = Sys}}
end

function netModel.getModelSeniorGiftState( ... )
	return {C = "SeniorGiftState", M = netM}
end

function netModel.getModelSeniorGiftGet( ... )
	return {C = "SeniorGiftGet", M = netM}
end

function netModel.getModelRoleCodeGetInfo( ... )
	return {C = "RoleCodeGetInfo", M = netM}
end

function netModel.getModelRoleCodeReward( Cid )
	return {C = "RoleCodeReward", M = netM, D = {Cid = Cid}}
end

function netModel.getModelRoleCodeSetJunior( Code )
	return {C = "RoleCodeSetJunior", M = netM, D = {Code = Code}}
end

function netModel.getModelRoleCodeSetSenior( Code )
	return {C = "RoleCodeSetSenior", M = netM, D = {Code = Code}}
end

function netModel.getModelSenior7DReward( Day )
	return {C = "Senior7DReward", M = netM, D = {Day = Day}}
end

function netModel.getModelRuneMix( Cids, Id )
	return {C = "RuneMix", M = netM, D = {Cids = Cids, Id = Id}}
end

function netModel.getModelTeamGetDetails( Rid )
	return {C = "TeamGetDetails", M = netM, D = {Rid = Rid}}
end

function netModel.getModelBlackListGet( ... )
	return {C = "BlackListGet", M = netM}
end

function netModel.getModelBlackListUpdate( Rid )
	return {C = "BlackListUpdate", M = netM, D = {Rid = Rid}}
end

function netModel.getModelBlackListClear( ... )
	return {C = "BlackListClear", M = netM}
end

function netModel.getModelFriendGet( Id )
	return {C = "FriendGet", M = netM, D = {Id = Id}}
end

function netModel.getModelAdGiftGet( )
	return {C = 'AdGiftGet',M = netM}
end

function netModel.getModelPlaygroundGet( ... )
	return {C = "PlaygroundGet", M = netM}
end

function netModel.getModelPlaygroundStart( ... )
	return {C = "PlaygroundStart", M = netM}
end

function netModel.getModelPlaygroundGo( Seconds )
	return {C = "PlaygroundGo", M = netM, D = {Seconds = Seconds}}
end

function netModel.getModelPlaygroundExchange( Index )
	return {C = "PlaygroundExchange", M = netM, D = {Index = Index}}
end

function netModel.getModelPlaygroundRanks( ... )
	return {C = "PlaygroundRanks", M = netM}
end

function netModel.getModelPlaygroundSend( Index, ToRid )
	return {C = "PlaygroundSend", M = netM, D = {Index = Index, ToRid = ToRid}}
end

return netModel 
