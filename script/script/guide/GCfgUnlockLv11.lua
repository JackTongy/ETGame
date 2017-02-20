return {
	{
		{Action='DStageList',Des='触发装备突破解锁引导'},
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{Event='closeAllLayer',eventOnly=true},
		{adjust='CHome'},-- {Dtype=3,point='主城',Action='CHome'},
		{Dtype=1,CID=303},
		{Dtype=1,CID=65},-- 引导精灵：主人~给人家的装备突破一下嘛~~。突破一下嘛~~！Yeah！主人最好啦~！
		{Dtype=4,Event='MenuBarStateShow',Action='DHomeToolBar'},
		{Dtype=3,point='背包',Action='DBag'},-- 引导点击背包，引导点击装备
		{Dtype=3,point='装备tab',Action='TabEquip'},
		{Dtype=3,point='强化1',Action='DEquipOp'},-- 引导点击强化
		{Dtype=3,point='突破tab',Action='DEquipOp3',Des='装备突破解锁引导结束'}-- 引导切换到突破
	}
}