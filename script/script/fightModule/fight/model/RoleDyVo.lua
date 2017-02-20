--玩家数据对象
local TypeRole=require 'TypeRole'  

local RoleDyVo=class()

function RoleDyVo:ctor(  )

	self.dyId = 0 --玩家动态id

	self.playerId = 0 -- 
	self.basicId = 0 -- 英雄静态 id
	-- self.hp=0
	self.hpPercent = 100
	self.hpPercentReal = 100
	self.skill_id = -1 --技能大招的id 		 正值标示可用 负值标示不可用
	self.bigCategory = TypeRole.BigCategory_Role -- 怪物 or 英雄
	self.speed = 1.5 --英雄移动速度
	self.name = "nameit"
	self.crit = 0
	-- 为怪物的话是否为boss
	self.isBoss = false
	--针对怪物 monster 时 怪物的ai类型 具体的值来源于
	self.aiType = 0
	--是否冻结   大招不能放 
	self.isFreeze = false
	--是否昏迷   大招不能放
	self.isComa = false
	--是否致盲  致盲  普通攻击 远程攻击不能打出来   大招可以放
	self.isBlind=false
	--是否具有 弓箭贯通的这个buff
	self.isGuangChuang=false
	--是否有歌舞类 buff
	self.isGeWu = false
	--完全的自动ai
	self.ai = false

	self.awaken = 0

	-- for boss
	self.SkillCD = nil

	self.slowRate = 1

	-- 
	self.isDropBox = nil

	-- 
	self.bornIJ = nil
end

function RoleDyVo:canMove(  )
	if self.isFreeze or self.isComa then
		return false

	end
	return true
end

return RoleDyVo

