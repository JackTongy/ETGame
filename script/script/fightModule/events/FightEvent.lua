
local FightEvent = {}

--进入战斗场景 
FightEvent.OnEnterFightScene 			= "OnEnterFightScene"
--请求战斗
FightEvent.C_Fight 						= "C_Fight"
--人物死亡 删除角色
FightEvent.DeleteRole					= "DeleteRole"
--选中的玩家发生改变
FightEvent.SelectPlayerChange			= "SelectPlayerChange"
FightEvent.GameOver 					= 'GameOver'
FightEvent.GameStart 					= 'GameStart'
--释放大招
FightEvent.ReleaseSkill 				= 'ReleaseSkill'
FightEvent.TimeOver 					= 'TimeOver'
FightEvent.StopTimer 					= 'StopTimer'
--当前玩家对象响应技能
FightEvent.TriggerSkill					= "TriggerSkill"
--触发被动
FightEvent.TriggerAbility 				= "TriggerAbility"
--防守方触发被动
FightEvent.TriggerAbilityDef 			= "TriggerAbilityDef"

--怪物走到地方结束线上 结束这场战斗    参数为false 标示该战斗人物输了   true 标示人赢了
FightEvent.PVEFinish 					= "PVEFinish"
FightEvent.Pve_Pause 					= "Pve_Pause"
FightEvent.Pve_Resume 					= "PVE_Resume"
-- pve 战斗返回 
FightEvent.Pve_Action 					= "Pve_Action" 
-- pve 客户端请求战斗 
FightEvent.Pve_SendAction 				= "Pve_SendAction" 
--pve添加buff
FightEvent.Pve_Buff 					= "Pve_Buff"
--pve 移除buff
FightEvent.Pve_RemoveBuff 				= "Pve_RemoveBuff"
FightEvent.Pve_Slot 					= "Pve_Slot"
FightEvent.Pve_ComeOffBench 			= "Pve_ComeOffBench" -- 替补上场
-- pve 服务端发送怪物出生
FightEvent.Pve_S_MonsterBirth 			= "Pve_S_MonsterBirth"
--当前波完成  当前波的怪物全部死亡 准备下一波
FightEvent.Pve_CurrentWaveFinish 		= "Pve_CurrentWaveFinish"
--下一波即将出现 
FightEvent.Pve_NextWaveComing 			= "Pve_NextWaveComing"
--pve 创建英雄
FightEvent.Pve_CreateHero 				= "Pve_CreateHero"
--角色死亡
FightEvent.Pve_RoleDie 					= "Pve_RoleDie"
--怪物死亡 服务端逻辑处理 
FightEvent.Pve_S_DeleteMonster 			= "Pve_S_DeleteMonster"
FightEvent.Select_Debug 				= 'Select_Debug'
FightEvent.Pve_MakeASkillBall 			= 'Make-A-Kill-Ball'
FightEvent.Pve_MakeInitBalls 			= 'Make-Init-Balls'
FightEvent.Pve_ForceHideSkill 			= 'Pve_ForceHideSkill'
FightEvent.Pve_MonsterWarning 			= 'Pve_MonsterWarning'
FightEvent.Pve_BossWarning 				= 'Pve_BossWarning'
--移除 歌舞buff
FightEvent.Pve_removeGeWuBuff 			= "Pve_removeGeWuBuff"
FightEvent.Pvp_removeGeWuBuff 			= "Pvp_removeGeWuBuff"
FightEvent.Pve_showAbnormalLabel 		= "Pvp_showAbnormalLabel"
---创建子弹
FightEvent.Pve_CreateBullet 			= "Pve_CreateBullet"
FightEvent.RemoveCareer 				= "RemoveCareer"
FightEvent.Pve_DieBall 					= "Pve_DieBall"
FightEvent.Pve_Protect					= 'Pve_Protect'
FightEvent.Pvp_Protect 					= 'Pvp_Protect'
FightEvent.Pve_FightResult 				= 'Pve_FightResult'
FightEvent.Pve_AirLandWarning 			= 'Pve_AirLandWarning'
FightEvent.Pve_Copy_Monster 			= 'Pve_Copy_Monster'
FightEvent.Pve_Monster_Property_Change 	= 'Pve_Monster_Property_Change'
FightEvent.Pve_ChampionResult 			= 'Pve_ChampionResult'
FightEvent.Pve_RewardFubenResult 		= 'Pve_RewardFubenResult'
FightEvent.Pve_CreateSelfAIPlayer 		= 'Pve_CreateSelfAIPlayer'
FightEvent.Pve_CreateOtherAIPlayer 		= 'Pve_CreateOtherAIPlayer'
FightEvent.ReleaseSkillInput 			= 'ReleaseSkillInput'
FightEvent.JJC_Create_HeroItem 			= 'JJC_Create_HeroItem'
FightEvent.LogicBattleStart 			= 'LogicBattleStart'
FightEvent.ArenaReward 					= 'ArenaReward'
FightEvent.ArenaGameOver 				= 'ArenaGameOver'
FightEvent.FubenCatBattleEnd 			= 'FubenCatBattleEnd'
FightEvent.BattleThiefGameOver 			= 'BattleThiefGameOver'
FightEvent.StartTimer 					= 'StartTimer'
FightEvent.StopTimer 					= 'StopTimer'
FightEvent.Pve_StartLadyBallForChampion = 'Pve_StartLadyBallForChampion'
FightEvent.Pve_KillBoss 				= 'Pve_KillBoss'
FightEvent.Pve_SetMana 					= 'Pve_SetMana'
FightEvent.Pve_CreatePlayerMana 		= 'Pve_CreatePlayerMana'
FightEvent.Pve_TriggerBigSkill 			= 'Pve_TriggerBigSkill'
FightEvent.Pve_PreCreateHero 			= 'Pve_PreCreateHero'
FightEvent.Pve_ShowCatchBoss			= 'Pve_ShowCatchBoss'
FightEvent.Pve_IgnoreCatchBoss 			= 'Pve_IgnoreCatchBoss'
FightEvent.Pve_GameOverQuick 			= 'Pve_GameOverQuick'
FightEvent.Pve_SetLastDiePlayerId 		= 'Pve_SetLastDiePlayerId'
FightEvent.Pve_CatchBossFinished 		= 'Pve_CatchBossFinished'
FightEvent.Pve_PreGameOverData 			= 'Pve_PreGameOverData'
FightEvent.Pve_DieAnimateFinished 		= 'Pve_DieAnimateFinished'
FightEvent.Pve_NeedCatchBoss 			= 'Pve_NeedCatchBoss'
FightEvent.Pve_FightGuiderEnable 		= 'Pve_FightGuiderEnable'
FightEvent.StartGuiderTimer 			= 'StartGuiderTimer'
FightEvent.Guider_CMBS 					= 'Guider_CMBS'
FightEvent.Pve_Copy_Monster_CMBS 		= 'Pve_Copy_Monster_CMBS'
FightEvent.Pve_SubMana 					= 'Pve_SubMana'

FightEvent.Guider_CM_ReleaseSkill 		= 'Guider_CM_ReleaseSkill'
FightEvent.Guider_Click_AutoFight 		= 'Guider_Click_AutoFight'
FightEvent.Guider_TouchAnyWay 			= 'Guider_TouchAnyWay'
FightEvent.Pve_AddMana 					= 'Pve_AddMana'
FightEvent.Guider_Pve_FightPause 		= 'Guider_Pve_FightPause'
FightEvent.Pve_TriggerBigSkill_Btn 		= 'Pve_TriggerBigSkill_Btn'
FightEvent.Pve_FirstFight 				= 'Pve_FirstFight'
FightEvent.Pve_SecondFight     			= 'Pve_SecondFight' 

FightEvent.FirstFightGuider_ShowArrow 	= 'FirstFightGuider_ShowArrow'

FightEvent.FingerView_goToPosition 		= 'FingerView_goToPosition'
FightEvent.FingerView_goToTarget 		= 'FingerView_goToTarget'

FightEvent.Pve_setSlowRate 				= 'Pve_setSlowRate' 	
FightEvent.Pve_setAtkSlowRate 			= 'Pve_setAtkSlowRate'
FightEvent.Pve_ShowWuDi 				= 'Pve_ShowWuDi'

FightEvent.Pve_Drop_Box					= 'Pve_Drop_Box'
FightEvent.Pve_Drop_Ball				= 'Pve_Drop_Ball'
FightEvent.Pve_NeedDropBox 				= 'Pve_NeedDropBox'
FightEvent.Pve_DropBoxAnimateFinished   = 'Pve_DropBoxAnimateFinished'
FightEvent.Pve_ManaLock 				= 'Pve_ManaLock'
FightEvent.Pve_QuickDie 				= 'Pve_QuickDie'

FightEvent.Pve_BigSkill_Warning_Init 	= 'Pve_BigSkill_Warning_Init'
FightEvent.Pve_BigSkill_Warning_Show 	= 'Pve_BigSkill_Warning_Show'
FightEvent.Pve_BigSkill_Warning_Hide 	= 'Pve_BigSkill_Warning_Hide'
FightEvent.Pve_BigSkill_Warning_Pos     = 'Pve_BigSkill_Warning_Pos'
FightEvent.Pve_BigSkill_Warning_Dir 	= 'Pve_BigSkill_Warning_Dir'

FightEvent.Pve_FirstStage 				= 'Pve_FirstStage'

FightEvent.LeagueGameOver 				= 'LeagueGameOver'


return FightEvent