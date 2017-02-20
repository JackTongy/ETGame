return{
	{
		{Action='DStageList'},
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{Event='closeAllLayer',eventOnly=true},
		{Dtype=1,CID=76},-- 引导精灵：主人，我们的装备可以进行回炉啦，快去看看吧~
		{adjust={'CHome','CWorldMap'}},
		{Dtype=4,Event='MenuBarStateShow',Action='DHomeToolBar'},
		{Dtype=3,point='背包',Action='DBag'},-- 引导点击背包，引导点击装备
		{Dtype=3,point='装备tab',Action='TabEquip'},
		{Dtype=3,point='强化1',Action='DEquipOp'},-- 引导点击强化
		{Dtype=3,point='回炉tab',Action='DEquipOp5'},-- 引导切换到回炉
		{Dtype=1,CID=304},
	}
}