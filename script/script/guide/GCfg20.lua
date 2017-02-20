return {
	{
		{Action='DStageList',Des='触发英雄副本解锁引导'},-- 升级后，回到关都地图界面时，出现精英副本的按钮（此前不出现这个按钮），引导点击精英副本
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{Event='closeAllLayer',eventOnly=true},
		{adjust='CWorldMap'},
		{Dtype=4,Event='MenuBarStateShow',Action='DHomeToolBar'},
		{Event='EventOpenStageS',eventOnly=true},
		{Dtype=3,point='副本选择',Action='DPlayBranch'},
		{Dtype=3,point='英雄副本',Action='HeroMode',Des='引导结束，跳转到英雄地图'},
		{Event='MainTaskIdUpdate',eventOnly=true},-- 播放精英副本第一个城镇的解锁动画
		{Dtype=4,dealy=2},
		{Dtype=1,CID=91},-- 引导精灵：主人，我推荐您可以去探索精英关卡，在这里可以获得非常厉害的五星精灵哦！
		{Dtype=3,point='TownID1',Action='DStageList'},
	},
}