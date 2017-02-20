--[[
游戏初始引导

CID : Dialogue表对应对话CID 
Dtype : 界面类型 全由GuideCtrl实现
	0或nil:空
 	1:普通剧情对话;
 	2:输入名字;
 	3:引导点击区域 此处为调用node:trigger(nil) 要保证这个node有效
 	4:空界面但阻截触摸事件
 	5:引导点击区域(圆形); 事件穿透
FadeIn: 当前Dtype淡入
FadeOut: 当前Dtype淡出
Action : 自定义功能的标示/或是一个操作完成的确认消息 
Event : 发送一个事件
EArg : 事件对应的参数
point: string 时从PointManager中获取动态注册的信息/{0,0}指定坐标
offset: 指定的point基础上的偏移量{0,0}
Insert: 引导恢复到指定点的时候，插入一些恢复必要的步骤
adjust: 设计中当前所处点 1:世界地图 2:主城 (作用于触发式引导中)
checkLayer: 当指定Layer不存在时略过该步
]]
local config =
{
	fb =
	{
		{Dtype=3,point='世界地图',Action='CWorldMap'},
		{Dtype=3,point='TownID1',Action='DStageList'},
		{Dtype=3,point='挑战',Action='CDungeon'},
	},
	equip =
	{
		{Dtype=4,Event='MenuBarStateShow',Action='DHomeToolBar'},
		{Dtype=3,point='队伍',Action='CTeam'},
	},
	home = 
	{
		{Dtype=4,Action='CHome'},
	},
	--step
	{
		--joint
		{Dtype=1,CID=19,Des='开场战斗完成'},
		-- {Dtype=1,CID=20},
		{Dtype=1,CID=21},
		{Dtype=1,CID=22},
		{Dtype=2,Action="NameOK",SP=1000,Des='取名完成'},
	},
	
	{
		{Dtype=1,CID=23,CP=1000},
		{Action="selectRole",SP=1100,Des='选角色完成'},
		-- {Dtype=1,CID=24,CP=1100},
	},

	{
		{Dtype=1,CID=25,FadeIn=0.5,CP=1100},
		{Dtype=4,Event='HomeAdjustNodeName',EArg={name='callPet'},Unlock='PetAcademy',Action='AnimtionEnd'},
		{Dtype=3,point='精灵召唤',Action='PetAcademy',Des='进入扭蛋界面'},--引导点击扭蛋建筑，点击扭蛋，播放扭蛋动画，获得一个骑士
		-- {Dtype=1,CID=201},-- 在这里，不同的城市能召唤不同的顶级精灵哦，而且每个城市都有各自的特色！
		-- {Dtype=3,point='帮助',Action='PetAList'},-- 引导点击帮助，弹出帮助界面（精灵列表），当玩家关闭这个弹框界面后触发后续的引导
		-- {Action='PetAListClose',Des='关闭帮助'},
		{Dtype=1,CID=202},-- 好了，让我们先在真新镇召唤第一个伙伴吧！
		{Dtype=3,point='扭蛋',Action='FirstNiudan',SP=1200},
		{Action='AnimtionEnd'},
		-- {Dtype=3,point='确定',Action='closeDialog'},
		{Dtype=1,CID=26},
	},

	{
		{Dtype=5,point='关闭',Action='CloseDialg'},--引导返回主城，点击队伍按钮，自动到第二个位置，引导点击选择上阵
		{Dtype=4,Event='MenuBarStateShow',Action='DHomeToolBar',CP=1200},
		{Dtype=3,point='队伍',Action='CTeam'},-- 引导点击队伍。
		{Dtype=4,Event='autoSelect2',Action='autoSelect2'},
		{Dtype=5,point={0,150},Action='CPetChose'},
		{Dtype=3,point='选中精灵',Action='ChoseDone',SP=1300,Des='精灵上阵'},
		{Dtype=1,CID=27},
	},

	{
		{Dtype=5,point='返回',Action='CHome'},--引导点击返回主城，点击传送门（去世界地图的建筑），点击真新镇，点击第一个关卡，进入副本界面
		{Dtype=3,point='世界地图',Action='CWorldMap',CP=1300},
		{Dtype=3,point='TownID1',Action='DStageList'},
		{Dtype=3,point='挑战',Action='CDungeon',Des='进入副本'},
		{Dtype=1,CID=28},
		{Dtype=5,point='石碑',Action='DDungeonRuleGuide',Des='点击石碑'},--引导点击石碑，石碑弹出信息，玩家点击关闭石碑
		{Action='AnimtionEnd'},
		{Dtype=1,CID=29},
		{Dtype=3,point='block_26',Action='Appear',SP=1400,Des='点击第一个格子，出现一个金币'},
		{Dtype=4,Action='AnimtionEnd'},
	},
	
	{
		-- {Dtype=1,CID=30,CP=1400,Insert='fb'},
		{Dtype=3,point='block_26',Action='DGetReward',SP=1500,CP=1400,Insert='fb', Des='点击金币，播放金币动画'},--引导玩家点击金币，播放金币动画
		-- {Action='AnimtionEnd'},
	},

	{
		{Dtype=3,point='block_18',Action='Appear',SP=1600,CP=1500,Insert='fb',Des='第一次探索到敌人'},--当玩家第一次探索到敌人时：战斗掉落战士(boss配置同个)
		{Dtype=4,dealy=1},
		{Dtype=1,CID=31,CP=1600,Insert='fb'},
		{Dtype=3,point='block_18',Action='DPrepareForStageBattle'},
		{Dtype=3,point='开始战斗',Action='StartBattle'},--引导玩家点击进入战斗，战斗结束后，返回副本
		{Action='BattleEnd',SP=1610,netcheck='BattleGetResult',Des='第一场战斗胜利'},
		-- {Dtype=1,CID=203},
		{Dtype=1,CID=33},
		-- {Event='GEventShowBossPos',EArg=true,eventOnly=true}, --
		-- {Event='GEventShowBossPos',EArg=false,eventOnly=true},
	},

	{
		{Action='BossBattleStart',CP=1610,Insert='fb',Des='进入第二场战斗'},--进入到第一个boss
		-- {Dtype=4,dealy=3.5},
		-- {Event='Guide_Pve_FightPause',EArg=true,eventOnly=true},
		-- {Dtype=1,CID=34},--这些敌人弱爆了！主人看来不需要你动手啦，点击自动我们就能替你把敌人消灭。
		-- {Dtype=3,point='自动',Action='clickAuto'},
		-- {Event='Guide_Pve_FightPause',eventOnly=true},
		{Action='BattleEnd',SP=1700,netcheck='BattleGetResult',Des='第二场战斗引导点击自动战斗，并且战斗胜利'},-- 引导点击自动，战斗胜利，回到副本，播放clear动画
		-- {Dtype=4,Action='AnimtionEnd'},
		-- {Dtype=1,CID=35},-- 主人，我们成功的完成了任务呢！如果主人想要重新探索这里的话，重新进来一次就可以了哦。
		-- {Dtype=1,CID=36},-- 咦？刚才的敌人好像掉了一个东西在那里呢！快拿起来看看吧！
		-- {Dtype=5,point='石碑',offset={230,240},Action='DGetReward',SP=1710},-- 引导点击装备，播放获得动画。
		-- {Action='AnimtionEnd'},
		{Event='TownOpenActionDelay',eventOnly=true},
		{Action='DStageList',Ing=true,Des='点击出副本'},-- 玩家自由探索，点击出口返回地图
		{Dtype=1,CID=37},-- 主人，是一把武器耶！是一把武器耶！快给我！快给我！快给我！（主人还能再探索下看看还有没有好东西哦~）
		{Dtype=5,point='关闭列表',Action='DStageListClose'},
		{Dtype=4,Event='MenuBarStateShow',Action='DHomeToolBar',CP=1700,Unlock='EquipOn'},
		{Dtype=3,point='队伍',Action='CTeam'},
		{Dtype=3,point='一键',Action='EquipOn',SP=1720,Des='一键穿上装备'},--点击武器部位，选择装备装上。
		{Dtype=1,CID=38,Insert='equip',CP=1720},-- 呵呵呵呵，我终于有武器了。这个武器应该还有提升空间，试着给他升级看看吧！
		{Dtype=3,point='手',Action='DEquipChose'},-- 引导点击武器，点击强化，点击升级。
		{Dtype=3,point='强化',Action='DEquipOp'},
		{Dtype=3,point='升级',Action='EquipUpgrade',SP=1730,Des='强化装备1'},
		{Dtype=4,Action='AnimtionEnd'},
		{Dtype=3,point='btnRight',Action='onEquipChange'},
		{Dtype=3,point='升级',Action='EquipUpgrade',Des='强化装备2'},
		{Dtype=4,Action='AnimtionEnd'},

		{Dtype=1,CID=39},-- 我觉得我现在的战斗力已经爆表啦！我们去探索更神秘的区域吧！
		{Dtype=1,CID=204},
		{Event='GuideOver',EArg='GCfg',eventOnly=true,Des='领取新手礼包'},
		-- {Action='CWorldMap'},
		{Event='MainTaskIdUpdate',eventOnly=true},
	},
	maxSP = 1730,
}

return config