return {
	{
		{Action='DStageList',Des='触发冠军之塔解锁引导'},
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{Event='closeAllLayer',eventOnly=true},
		{adjust='CHome'},--{Dtype=3,point='主城',Action='CHome'},
		{Dtype=4,Event='HomeAdjustNodeName',EArg={name='championRoad'},Unlock='RoadOfChampion',Action='AnimtionEnd'},-- 冠军之塔入口自动移到界面中心，播放解锁动画后触发对话。
		{Dtype=1,CID=66},-- 引导精灵：主人，传说有一座冠军之塔，只要战胜塔中的守卫就可以获得丰厚的奖励！
		{Dtype=3,point='冠军之塔',Action='DRoadOfChampion',Des='冠军之塔解锁引导结束'},-- 引导点击冠军之塔，进入后可自由操作，下面两个引导条件触发
		-- {Action='firstBattleOver'},-- 第一场战斗结束时
		{Dtype=1,CID=67},-- 引导精灵：主人，在冠军之塔里，每场战斗后我们是不会恢复体力的，只有重置后才会恢复，所以在战斗中尽量控制血量！精灵死亡时，可以换一只健康的精灵上阵！（精灵必须高于15级）
		-- {Action='firstBuffEx'},-- 第一次弹出BUFF兑换时
		-- {Dtype=1,CID=68},-- 引导精灵：主人，之前获得的冠军徽章可以在这里兑换BUFF来增强实力哦。不过增强的效果只会在冠军之塔中起作用！
	}
}
