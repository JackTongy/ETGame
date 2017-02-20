-- 第二个城镇第一个战斗关卡胜利后，掉落1个安抚果实，在战斗结算界面开始引导
return {
	{
		{Action='DStageList'},
		{Dtype=1,CID=206,Record=true},-- 引导精灵：主人快看，刚才获得了一个安抚果实呢，精灵吃掉它的话就会获得经验然后升级哦。
		{Dtype=5,point='关闭列表',Action='DStageListClose'},-- 引导玩家点击关闭城镇界面
		{Event='closeAllLayer',eventOnly=true},
		{adjust='CTeam'},
		-- {Dtype=4,Event='MenuBarStateShow',Action='DHomeToolBar'},
		-- {Dtype=3,point='队伍',Action='CTeam'},-- 引导点击队伍。
		-- {Dtype=3,point='详情',Action='CPetDetail'},-- 引导点击详情
		{Dtype=5,point={0,150},Action='CPetFoster'},-- 引导点击队长精灵进入培养界面
		{Dtype=1,CID=207},-- 引导精灵：快点吃掉它吧！
		{Dtype=3,point='升级',Action='upLvDone',Des='升级成功'},-- 引导玩家点击升级
		{Action='AnimtionEnd'},
		{Dtype=3,point='btnRight',Action='selectPetIndex'},
		{Dtype=3,point='升级',Action='upLvDone',Des='升级成功'},-- 引导玩家点击升级
		{Action='AnimtionEnd'},
		{Dtype=1,CID=208},-- 引导精灵：哇~~！升级啦，升级啦！我们去多弄一些来吧！触摸果实，它会引导你哪里可以获得更多果实哦！
		-- {Dtype=3,point='果实',Action='DMaterialDetail'},-- 引导玩家点击果实
		{Dtype=3,point='关闭',Action='DPetFosterClose'},--关闭培养
		{adjust='CWorldMap'},
		{Dtype=3,point='NextTown',Action='DStageList'},--引导玩家点击第下一个城镇
	}
}