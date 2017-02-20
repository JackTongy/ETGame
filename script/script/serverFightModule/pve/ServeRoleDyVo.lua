local TypeRole=require 'TypeRole'  
	

-- 服务端数据vo
ServeRoleDyVo=class()

function ServeRoleDyVo:ctor(  )
	
	self.dyId=0 --玩家动态id
	self.playerId=0 -- 英雄静态id
	self.basicId=0 -- 英雄静态 id
	-- self.hp=0
	self.hpPercent=100
	self.hpMax=0
	self.hp=0
	self.skill_id=-1 --技能大招的id 		 正值标示可用 负值标示不可用
	self.bigCategory=TypeRole.BigCategory_Role
	self.speed=1.5 --英雄移动速度
	self.name="nameit"

	self.atk=0
	self.def=0
	self.cri=0
	self.speed=0
	self.atktime=0
	self.passitiveArr={} --被动技能数组

end