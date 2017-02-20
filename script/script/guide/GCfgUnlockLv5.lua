return {
	{
		{Action='DStageList',Des='触发黑市解锁引导'},
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{Event='closeAllLayer',eventOnly=true},
		{adjust='CHome'},--{Dtype=3,point='主城',Action='CHome'},
		{Dtype=4,Event='HomeAdjustNodeName',EArg={name='darkMall'},Unlock='MagicShop',Action='AnimtionEnd'},-- 神秘商店入口自动移到界面中心，播放解锁动画后触发对话。
		{Dtype=1,CID=50},-- 引导精灵：主人，听说神秘商店开张了呢。店里有什么精灵的碎片啦、什么灵魂石啦，反正很多好东西啦~。我们去逛逛吧！
		{Dtype=3,point='神秘商店',Action='DMagicShop'},
		{Dtype=1,CID=51},-- 引导精灵：呃~这个~这个，我们还是买它吧！“蓝鳄”只要120个精灵之魂哦！好划算哦！呃~~~好吧！我忘了你的精灵之魂不够啊！好吧…跟我来…
		{Dtype=1,CID=52},-- 引导精灵：精灵之魂可以通过献祭获得哦，现在我们开始吧。
		{Dtype=3,point='献祭',Action='TLPetMix'},-- 引导点击献祭
		{Event='alginTo',EArg='19',Action='alginToDone'},
		{Dtype=3,point='PetId19',Action='MixSelected'},-- 引导点击选择
		{Dtype=3,point='确认献祭',Action='MixDone',Des='引导献祭成功'},-- 引导点击献祭
		{Action='AnimtionEnd'},
		{Dtype=1,CID=53},-- 引导精灵：现在我们有足够的精灵之魂就去兑换蓝鳄喽~！
		{Dtype=3,point='关闭',Action='CloseDialog'}, --引导点击返回
		{Action='DMagicShop'},
		{Dtype=3,point='兑换',Action='DConfirmNT'},
		{Dtype=3,point='确定',Action='DGetReward',Des='黑市兑换成功，引导完成'},-- 引导点击兑换
	}
}