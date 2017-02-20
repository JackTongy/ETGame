--副本地图元素清除完 地图上没有可破坏元素，敌人被全部消灭之后，触发引导
return {
	{
		{Dtype=1,CID=205,Record=true},-- 哈哈，主人真棒，我们已经把这里全部探索过啦！现在我们赶快离开这里吧！
		{Dtype=5,point='石碑',offset={-120,0},Action='CDungeonOnLeave'},-- 然后引导点击副本的门，出副本
	}
}