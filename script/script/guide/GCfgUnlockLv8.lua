return {
	{
		{Action='DStageList',Des='触发队伍2解锁引导'},
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{Event='closeAllLayer',eventOnly=true},
		{adjust='CTeam'},
		{Dtype=3,point='切换',Action='TeamSwith'},-- 引导点击队伍。
		{Dtype=1,CID=58},-- 引导精灵：主人，现在可以配置多个队伍了哦，而且随时切换，非常方便呢。
	},
}