--[[
	Id = nil
Name = 名称
Lv = 初始等级
Hp = 初始Hp
Atk = 初始Atk
Def = 防御
MoveSpd = 移动速度
AtkSpd = 攻击速度
PetId = 对应精灵配置ID
OpenTime = 开启时间
CdCost = 消除CD消耗精灵石数量
AiType = nil
SkillCD = BOSS释放技能时间

--]]
local _table = {
	[1] = {	Id = 1,	Name = [[闪电鸟]],	Lv = 100,	Hp = 20000000,	Atk = 60000,	Def = 0,	MoveSpd = 150,	AtkSpd = 1.5000,	PetId = 145,	OpenTime = [[2014/1/1 12:00:00]],	CdCost = 10,	AiType = 0,	SkillCD = {30,5},},
	[2] = {	Id = 2,	Name = [[超梦]],	Lv = 100,	Hp = 20000000,	Atk = 60000,	Def = 0,	MoveSpd = 150,	AtkSpd = 1.5000,	PetId = 150,	OpenTime = [[2014/1/1 21:00:00]],	CdCost = 10,	AiType = 0,	SkillCD = {30,5},},
}

return _table
