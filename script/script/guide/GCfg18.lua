return {
	{
		{Action='DStageList',Des='触发试练引导',Record=true},
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{Event='closeAllLayer',eventOnly=true},
		{adjust='CHome'},
		{Dtype=4,Event='HomeAdjustNodeName',EArg={name='Explore'},Action='AnimtionEnd'},
		{Dtype=3,point='飞艇',Action='CExploreScene'},
		{Dtype=3,point='试练',Des='试练引导结束'},
	},
}