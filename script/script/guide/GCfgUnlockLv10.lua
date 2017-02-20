return {
	{
		{Action='DStageList'},
		{Dtype=5,point='关闭列表',Action='DStageListClose'},
		{adjust='CHome'},-- {Dtype=3,point='主城',Action='CHome'},
		{Dtype=4,Event='HomeAdjustNodeName',EArg={name='train'},Unlock='Train',Action='AnimtionEnd'},-- 训练入口自动移动到界面中心，播放解锁动画后触发对话
		{Dtype=3,point='训练入口',Action='DTrain'},
		{Dtype=1,CID=59},-- 引导精灵：主人，训练中心开张了呢，在那里即使是你不在的时候，我们也可以获得大量经验哦！
		{Dtype=1,CID=60},-- 引导精灵：而且在这里训练的同时，也不会妨碍在战斗的上阵呢！
		{Dtype=3,point='TrainBtn',Action='CPetChose'},-- 引导点击选择。
		{Dtype=3,point='选中精灵',Action='ChoseDone'},-- 引导选择队长精灵
		{Dtype=1,CID=61},-- 引导精灵：这里的训练模式看起来十分丰富，使用精灵石可以有几率进入新的训练模式哦。
		{Dtype=1,CID=62},-- 引导精灵：因为这里正在开业特惠，我们可以免费使用一次最有效的地狱模式，快试试吧！
		{Dtype=3,point='TrainBest',Action='TrainBestOver'},-- 引导点击地狱模式
		{Dtype=3,point='TrainOk',Action='TrainOkOver'},-- 引导点击确定
		{Dtype=1,CID=63},-- 引导精灵：主人，训练一次是8小时，到时可要记得回来把我们带走哦，这样才能领取经验！
		{Dtype=1,CID=64},-- 引导精灵：不过，使用精灵石可以提前结束训练，而且可以获得全部8小时的经验。哇~~开业特惠不要钱~，主人我们快结束训练吧！
		{Dtype=3,point='TrainSpeed',Action='TrainSpeedOver'},-- 引导点击位置1
		{Dtype=3,point='确定',Action='TrainSpeedOkOver'},-- 引导点击确定
	}
}