--[[
	神兽降临引导
]]
return {
	{
		{Dtype=4,Action='BossPetAnimationEnd',Des='副本触发神兽降临引导'},-- 点击出现神兽时，播放完神兽出现动画，引导点击神兽，播放完神兽逃跑动画后触发对话。
		{Dtype=3,point='神兽',Action='DConfirmNT'},
		{Dtype=1,CID=70},-- 引导精灵：主人！是神兽！我们刚才看到了神兽！！神兽身上携带着非常珍贵的物品，而且如果能让神兽加入我们的话~哦~天哪！我知道他往哪里跑了，快跟我来！
		{Dtype=3,point='确定',Action='CHome'},-- 引导点击弹框按钮追击，跳转到主城，
		{Dtype=4,Event='HomeAdjustNodeName',EArg={name='bestBoss'},Unlock='PetKill',Action='AnimtionEnd'},-- 神兽降临入口自动移到主界面中间，播放解锁动画后
		{Dtype=3,point='神兽降临',Action='DPetKill',Record=true,Des='神兽降临引导结束'},-- 引导点击神兽降临入口
	}
}