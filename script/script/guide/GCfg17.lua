return {
	{
		{Action='DStageList',Des='触发进化引导',Record=true},
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{Event='closeAllLayer',eventOnly=true},
		{Dtype=1,CID=82},--引导精灵：主人，我的力量可不仅仅现在这些哦，通过进化，可以让我变成高阶形态，提升资质和技能等级！
		{adjust='CTeam'},
		{Dtype=4,Event='autoSelect2',Action='autoSelect2'},
		{Dtype=5,point={0,150},Action='CPetFoster'},
		{Dtype=3,point='进化tab',Action='TLPetEvolve'},
		{Dtype=3,point='进化',Action='EvolveDone',Des='进化引导结束'},
	},
}