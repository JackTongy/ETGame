return{
	{
		{Action='DStageList',Des='触发boss战解锁引导'},
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{Event='closeAllLayer',eventOnly=true},
		{adjust='CHome'},--{Dtype=3,point='主城',Action='CHome'},
		{Dtype=4,Event='HomeAdjustNodeName',EArg={name='bossBattle'},Unlock='BossBattle',Action='AnimtionEnd'},
		{Dtype=3,point='boss战',Action='DBossBattle'},
	}
}