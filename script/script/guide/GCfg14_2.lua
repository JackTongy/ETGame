local GuideHelper = require 'GuideHelper'
local Res = require 'Res'

GuideHelper:registerActionFuc('GCfg14gotoCteam'
,function ( ... )
	GleeCore:showLayer('DConfirmNT',{content = Res.locString('Battle$guideStrengthenEquip'), 
	RightBtnText=Res.locString('Battle$guideOK'),callback=function ( )
		GuideHelper:check('GCfg14gotoCteam')
	end,LeftBtnText=Res.locString('Battle$guideNO'),cancelCallback=function ( ... )
		GuideHelper:guideDone('GCfg14_2')
	end})
end)

--强化队伍 游戏中第一次出现非三星通关 返回探索副本界面的时候触发
return {
	{
		{Action='GCfg14gotoCteam',Record=true},--弹框文案”有精灵阵亡了，是否去队伍强化精灵和装备？“
		{Dtype=5,point='石碑',offset={-120,0},Action='CDungeonOnLeave'},
		{Action='DStageList'},
		{Dtype=5,point='关闭列表',Action='DStageListClose',checkLayer='DTown'},
		{adjust='CTeam'},
		{Dtype=3,point='已装备',Action='DEquipChose'},-- 引导点击武器，点击强化，点击升级。
		{Dtype=3,point='强化',Action='DEquipOp'},
	}
}