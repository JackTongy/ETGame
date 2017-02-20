return{
	{
		{Action='DStageList',Des='触发合成装置解锁引导'},
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{Event='closeAllLayer',eventOnly=true},
		{adjust='CHome'},-- {Dtype=3,point='主城',Action='CHome'},
		{Dtype=4,Event='HomeAdjustNodeName',EArg={name='equip'},Unlock='MagicBox',Action='AnimtionEnd'},-- 神秘盒子入口自动移到界面中心，播放解锁动画后触发对话。
		{Dtype=1,CID=48},-- 引导精灵：主人，刚刚大木博士给我们寄过来了一些装备，包里的~~装备~~~太多了，我~~已经~~背~~背~~~不动了~~~。我们用~~神秘盒子~~~把这些~破烂~变成更好的装备吧！
		{Dtype=3,point='神秘盒子',Action='DMagicBox'},-- 引导点击神秘盒子。
		{Dtype=3,point='合成tab',Action='tabSynthesis'},
		{Dtype=3,point='一键放入',Action='onekeyin'},-- 引导点击一键放入。
		{Dtype=1,CID=49},-- 引导精灵：利用神秘盒子，我们可以把5个相同品质的装备变成品质更高的装备哦。
		{Dtype=3,point='合成',Action='EquipMagicBox',Des='完成合成，合成装置解锁引导结束'},-- 引导点击合成。
	},
}