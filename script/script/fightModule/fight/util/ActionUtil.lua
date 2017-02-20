--方向枚举    1代表右方向 2 代表左方向  

-- TypeDirection={}
-- TypeDirection.Right=1
-- TypeDirection.Left=2


-- ---动作 枚举  暂定 

-- TypeAction={}

-- TypeAction.Stand=1 
-- TypeAction.Walk=2
-- TypeAction.Injure=3
-- TypeAction.Dead=4
-- TypeAction.Fight_1=5	-- 攻击动作1 




-- local all = {'stand','walk','bowAttack'}
-- local head = 'sb_hero_'


--动作方向管理器

local  actionManager = {}

actionManager.XuRuoHp=10 --当值小于等于10%的时候 产生虚弱



actionManager.Action_Stand =  "Action_Stand" -- "待机" or "Action_Stand"  --"待机"
actionManager.Action_Walk =   "Action_Walk"--"移动" or "Action_Walk"   --"移动"

actionManager.Action_NoramlStand="待机"
actionManager.Action_NormalWalk = "移动"

actionManager.Action_XuRuoStand="虚弱待机"

actionManager.Action_XuRuoWalk="虚弱移动"


actionManager.Action_Attack = "近战攻击" 

actionManager.Action_RemoteAttack = "远程攻击" 
actionManager.Action_RemoteCrit = "远程暴击" 

actionManager.Action_GeDang = "格挡" 

actionManager.Action_AttackCrit = "近战暴击" 

actionManager.Action_Injure = "受击"
--击退
actionManager.Action_BeatBack = "击退"
actionManager.Action_Dead = "死亡"


--技能大招
actionManager.Action_BigSkill ="大招"

actionManager.Action_ZhiLiao ="治疗"

actionManager.Action_BigSkill_Dance ="歌舞"


actionManager.Direction_Right = 1

actionManager.Direction_Left = 2

return actionManager











