return {
	{
		{Action='DStageList',Des='触发竞技场解锁引导'},
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{Event='closeAllLayer',eventOnly=true},
		{adjust='CHome'},--{Dtype=3,point='主城',Action='CHome'},
		{Dtype=4,Event='HomeAdjustNodeName',EArg={name='arena'},Unlock='Arean',Action='AnimtionEnd'},-- 竞技场入口自动移到界面中心，播放解锁动画后触发对话。
		{Dtype=1,CID=54},-- 引导精灵：主人，这里就是万众瞩目的竞技场，有没有一点点紧张呢？
		{Dtype=3,point='竞技场',Action='CArena'},-- 引导点击竞技场，进入竞技场后继续引导。
		{Dtype=1,CID=55},-- 引导精灵：在竞技场中，我们可以挑战其他训练师，说不定还能交到朋友呢！
		{Dtype=1,CID=56},-- 引导精灵：不过要注意的是，竞技场的战斗主人是没有办法干涉的哦，只能靠我们自己！不过我们会尽全力战斗的！
		-- {Dtype=3,point="挑战第一个",Action="ArenaBattle"},-- 引导点击挑战。
		-- {Action="ArenaBattleBack"},-- 战斗结束回到竞技场界面。
		{Dtype=1,CID=57},-- 引导精灵：提醒一下主人，竞技场每天9点都会根据排名发放荣誉奖励，荣誉可以兑换各种奖励，到时候别忘咯~！
	},
}

