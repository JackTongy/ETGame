return{
	{
		{Action='DStageList',Des='触发宝石解锁引导'},
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{Event='closeAllLayer',eventOnly=true},
		{Dtype=1,CID=78},-- 引导精灵：报告主人，我在草丛里发现了一颗宝石！
		{adjust='CTeam'},
		{Dtype=3,point='宝石',Action='TLPetGem'},
		{Dtype=4,dealy=1},
		{Dtype=3,point='firstGem',Action='DGemDetail'},
		{Dtype=3,point='升级',Action='DGemLevelUp'},
		{Dtype=1,CID=79},-- 引导精灵：可以消耗其他宝石来提升主宝石的等级。
		{Dtype=3,point='材料宝石1',Action='GemSelected'},-- 引导选择材料宝石
		{Dtype=3,point='材料宝石2',Action='GemSelected'},-- 引导选择材料宝石
		-- {Dtype=3,point='材料宝石3',Action='GemSelected'},-- 引导选择材料宝石
		-- {Dtype=3,point='材料宝石4',Action='GemSelected'},-- 引导选择材料宝石
		{Dtype=1,CID=80},-- 引导精灵：高级的宝石升级有可能会失败，消耗的宝石等级越高，升级成功率越高。
		{Dtype=3,point='宝石升级',Action='GemUpgrade'},-- 引导点击升级
		{Dtype=4,Action='AnimtionEnd'},-- 播放宝石升级动画
		{Dtype=3,point='关闭',Action='CloseDialog'},
		{Dtype=1,CID=81},-- 引导精灵：如果把这颗强力宝石镶嵌到装备上，我们的实力又可以提升啦！
		-- 引导点击宝石
		{Action='DPetFosterClose',Des='宝石解锁引导结束'},--{Action='CHome'},-- 回到主页时，
		-- {Event='unlockLv38',eventOnly=true,toast='活动宝石副本已解锁'},--提示“活动宝石副本已解锁”显示提示动画。
	}
}