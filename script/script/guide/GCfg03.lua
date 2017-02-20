--次日登录引导
return {
	{
		{Action='CHome'},
		{Dtype=1,CID=69,Des='次日登陆，触发每日任务引导'},--引导精灵：主人！你终于回来了！想死你啦！大木博士给你指定了详细的长期成长计划！每天都不一样呢，别忘了看看呀。
		{Dtype=4,Event='MenuBarStateShow',Action='DHomeToolBar'},
		{Dtype=3,point='任务',Action='CTask',Record=true},--引导点击每日任务
	},
}