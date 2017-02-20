--扫荡引导
return {
	{
		{Action='DStageList',Des='触发扫荡引导'},
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{Event='closeAllLayer',eventOnly=true},
		{Dtype=1,CID=86},--引导精灵：主人，我看你好像有点疲劳的样子呢。那我告诉主人一个小秘密吧！那就是“扫荡”！
		{adjust='CTeam'},		
		{Dtype=5,point={0,150},Action='CPetFoster'},--点击主角，
		{Dtype=3,point='进化tab',Action='TLPetEvolve'},--点击进化，
		{Dtype=3,point='进化石',Action='DMaterialDetail'},--引导点击进化石材料
		{Dtype=1,CID=87},--引导精灵：在主人发布扫荡命令后，我们会帮主人快速的在关卡中搜索各种道具和进化石哦，这样一举两得的事情是不是很棒呀~！
	}
}

