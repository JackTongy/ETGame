local config = 
{
	{
		{Action='DStageList',Des='触发活动副本'},
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{Event='closeAllLayer',eventOnly=true},
		{adjust='CHome'},-- {Dtype=3,point='主城',Action='CHome'},-- 升级后，回到关都地图界面时，引导玩家回到主页。（如玩家当前在主页，则跳过引导玩家回到主页的步骤。）
		{Dtype=4,Event='HomeAdjustNodeName',EArg={name='actTask'},Unlock='EquipFuben',Action='AnimtionEnd'},-- 活动副本入口自动移到界面中心，播放解锁动画后触发对话。
		{Dtype=1,CID=46},-- 引导精灵：主人，有个新区域开放了哦。据说那里藏着很多装备，我们一起去寻宝吧！
		{Dtype=3,point='活动副本',Action='DActRaid'},-- 引导点击活动副本入口。
		{Dtype=3,point='EquipFuben',Action='showLayer'},-- 引导点击装备副本。
		{Dtype=1,CID=47,Des='活动副本引导完成'},-- 引导精灵：不过可不要轻易的去挑战高难度哦，虽然可以拿到更好的东西，但是也会死的很惨~~~！！
	}
}

return config