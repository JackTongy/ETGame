return {
	{
		{Action='DStageList',Des='触发精灵重生解锁引导'},
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{Event='closeAllLayer',eventOnly=true},
		{Dtype=1,CID=74},-- 引导精灵：主人，小伙伴们可以进行重生了呢！快去看看吧~。
		{adjust='CTeam'},
		{Dtype=5,point={0,150},Action='CPetFoster'},-- {Dtype=3,point='培养',Action='CPetFoster'},-- 引导点击培养（系统赠送10潜力石）
		{Dtype=3,point='重生tab',Action='TabRebirth',Des='精灵重生解锁引导结束'},
		{Dtype=1,CID=214},
	},
}

