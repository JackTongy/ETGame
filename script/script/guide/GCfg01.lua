--[[
第一个城镇(2个关卡)通关后触发精灵觉醒
]]

local config =
{
	{
		{Action='DStageList',Des='触发觉醒引导'},
		{Dtype=1,CID=42},-- 引导精灵：主人我发现了这个！
		-- {Dtype=4,Event='showStageReward',Action='DStageReward'}, --掉落详情自动弹出
		{Dtype=3,point='领取通关奖励',Action='DGetReward',Record=true},-- 引导点击领取通关奖励
		{Action='AnimtionEnd'},--（播放获得动画）结束
		{Dtype=1,CID=43},-- 引导精灵：没见过吧！说出来吓你一跳哦！
		{Dtype=1,CID=44},-- 引导精灵：这可是觉醒石！它可以让我变得比现在还厉害哦！我已经准备好了，主人！让我们开始吧！
		{Dtype=5,point='关闭列表',Action='DStageListClose'},
		{Event='closeAllLayer',eventOnly=true},
		{adjust='CTeam'},-- {Dtype=4,Event='MenuBarStateShow',Action='DHomeToolBar'},
						-- {Dtype=3,point='队伍',Action='CTeam'},-- 引导点击队伍。
		{Event='UnlockMoudle',Unlock='PetForster',eventOnly=true},
		{Dtype=5,point={0,150},Action='CPetFoster'},-- {Dtype=3,point='培养',Action='CPetFoster'},-- 引导点击培养。
		{Dtype=3,point='觉醒tab',Action='TabAwake'},
		{Dtype=1,CID=45},-- 引导精灵：主人，不止可以觉醒一次的哦！觉醒到一定次数后还能解锁强大的被动技能，想想就有点小激动呢！
		{Dtype=3,point='觉醒',Action='Awake',Des='觉醒成功'},-- 引导点击觉醒。
		{Action='AnimtionEnd'},-- 播放觉醒动画
	},
	
}

return config