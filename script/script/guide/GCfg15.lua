--自动战斗的引导
return {
	{
		{Action='BossBattleStart',Record=true},
		{Dtype=4,dealy=3.5,Record=true},
		{Event='Guide_Pve_FightPause',EArg=true,eventOnly=true},
		{Dtype=1,CID=34},--这些敌人弱爆了！主人看来不需要你动手啦，点击自动我们就能替你把敌人消灭。
		{Dtype=3,point='自动',Action='clickAuto'},
		{Event='Guide_Pve_FightPause',eventOnly=true},
	}
}