return{
	{
		{Action='DStageList',Des='触发装备重铸解锁引导'},
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{Event='closeAllLayer',eventOnly=true},
		{Dtype=1,CID=75},-- 引导精灵：主人，你知道吗？装备通过重铸水晶重铸之后将会更加的厉害哦！我刚刚收集到了10个水晶，都送给主人吧！
		{adjust={'CHome','CWorldMap'}},
		{Dtype=4,Event='MenuBarStateShow',Action='DHomeToolBar'},
		{Dtype=3,point='背包',Action='DBag'},-- 引导点击背包，引导点击装备
		{Dtype=3,point='装备tab',Action='TabEquip'},
		{Dtype=3,point='强化1',Action='DEquipOp'},-- 引导点击强化
		{Dtype=3,point='重铸tab',Action='DEquipOp2'},-- 引导切换到重铸（系统赠送10个重铸水晶）
		{Dtype=1,CID=215},
		{Dtype=3,point='重铸',Action='RebirthDone',Des='装备重铸解锁引导结束'},--引导点击重铸
	}
}