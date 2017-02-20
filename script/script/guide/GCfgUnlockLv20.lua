return{
	{
		{Action='DStageList',Des='触发金币副本解锁引导'},
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{Event='closeAllLayer',eventOnly=true},
		{Dtype=1,CID=73},-- 引导精灵：主人，你看起来又变强了呢！我知道有个地方，那里藏了很多很多金币哦！快跟我来吧！
		{adjust='CHome'},-- {Dtype=3,point='主城',Action='CHome'},
		{Dtype=4,Event='HomeAdjustNodeName',EArg={name='actTask'},Unlock='GoldFuben',Action='AnimtionEnd'},-- 玩家回到主页时，引导点击活动副本，
		{Dtype=3,point='活动副本',Action='DActRaid'},
		{Dtype=3,point='GoldFuben',Action='showLayer',Des='金币副本引导结束'},--引导点击金币副本
	}
}