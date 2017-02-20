return {
	{
		{Dtype=1,CID=301},--主人，又有新的小伙伴了，让他们也参与战斗吧
		{Dtype=3,point='TeamPos3',Action='SelectTeamPos3'},
		{Dtype=5,point={0,150},Action='CPetChose'},
		{Dtype=3,point='选中精灵',Action='ChoseDone',Des='上阵三号位精灵'},
		{adjust='CWorldMap'},
		{Event='MainTaskIdUpdate',eventOnly=true},
		{Dtype=4,dealy=2.5},
		{Dtype=3,point='NextTown',Action='DStageList'},--引导玩家点击第下一个城镇
	}
}
