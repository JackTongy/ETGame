 --装备扭蛋

 return{
	{
		{Action='DStageList',Des='触发装备扭蛋引导'},
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{Event='closeAllLayer',eventOnly=true},
		{adjust='CHome'},-- {Dtype=3,point='主城',Action='CHome'},
		{Dtype=4,Event='HomeAdjustNodeName',EArg={name='equip'},Unlock='MagicBox',Action='AnimtionEnd'},-- 神秘盒子入口自动移到界面中心，播放解锁动画后触发对话。
		{Dtype=1,CID=84},---传说装备中心会出现超厉害的武器呢
		{Dtype=3,point='神秘盒子',Action='DMagicBox'},
		{Dtype=3,point='免费赠送',Action='EquipNiudanSuc',Des='完成装备扭蛋'},-- 引导点击扭。
		{Action="AnimtionEnd"},
		{Dtype=1,CID=85},--哇，人品爆发啦，貌似很好的装备耶
		
	},
}