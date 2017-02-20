return {
	{
		{Action='DStageList',Des='触发队伍2解锁引导'},
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{Event='closeAllLayer',eventOnly=true},
		{Dtype=1,CID=82},--引导精灵：主人，我的力量可不仅仅现在这些哦，通过进化，可以让我变成高阶形态，提升资质和技能等级！
		{adjust='CTeam'},
		{Dtype=5,point={0,150},Action='CPetFoster'},-- 引导点击队伍，引导点击队长精灵
		{Dtype=3,point='进化tab',Action='TLPetEvolve',Des='精灵重生解锁引导结束'},
		{Dtype=1,CID=83},--引导精灵：主人，进化需要精灵等级和进化石。进化石可以在黑市和活动副本里获得哦~主人，快努力让我进化吧！
	},
}