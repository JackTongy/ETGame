return {
	{
		{Action='DActRaid',Des='触发鉴定引导',Record=true},
		{Dtype=3,point='关闭传送工厂',Action='DActRaidClose'},
		{Dtype=4,Event='HomeAdjustNodeName',EArg={name='equip'},Action='AnimtionEnd'},
		{Dtype=3,point='神秘盒子',Action='DMagicBox'},
		{Dtype=3,point='鉴定',Des='鉴定引导结束'},
	},
}