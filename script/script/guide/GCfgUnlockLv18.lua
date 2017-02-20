local config = 
{
	{
		{Action='DStageList',Des='触发潜力激发解锁引导'},
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{Event='closeAllLayer',eventOnly=true},
		{Dtype=1,CID=71},-- 引导精灵：主人，我感到体内一股强大的能量正要迸发出来，现在到了让我变得更强的时候了！
		{adjust='CTeam'},
		{Dtype=5,point={0,150},Action='CPetFoster'},
		{Dtype=3,point='潜力tab',Action='TLPotential'},
		{Dtype=1,CID=72},-- 引导精灵：精灵们把这个过程叫做“激发”。激发会消耗掉相应的潜力点。潜力点十分珍贵哦，如果失败就白白浪费啦。主人你可一定要成功啊！
		{Dtype=1,CID=212},--引导精灵：潜力点十分珍贵哦，每升一级才获得一点哦，如果失败就白白浪费啦！
		{Dtype=1,CID=213},-- 引导精灵：啊~~！主人，请稍等一下！我刚才在路边捡到了2颗精灵石，运气真好呢，送给主人吧！而且，用精灵石进行激发一定会成功的哦！
		{Dtype=3,point='激发',Action='ActiveDone',Des='潜力激发解锁引导结束'},-- 引导点击激发
	}
}

return config
