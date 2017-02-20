--[[
	zs_t = 战士引导时间
yc_t = 远程引导时间
qs_t = 骑士引导时间
zl_skill_t = 治疗大招时间
zs1_skill_t = 战士1大招时间
zs2_skill_t = 战士2大招时间
yc1_skill_t = 远程1大招时间
yc2_skill_t = 远程2大招时间
cmbs_t = 超梦变身时间
cm_skill_t = 超梦大招时间
finish_t = 黑屏开始时间
auto_ai1 = AI-1时间
auto_ai2 = AI-2时间
auto_ai3 = AI-3时间
zs_mana = 战士回魔
qs_mana = 骑士回魔
yc_mana = 远程回魔
zl_mana = 治疗回魔
first_fight_times = 第一场战斗引导

--]]
local _table = {
	[1] = {	zs_t = 0,	yc_t = 0,	qs_t = 0,	zl_skill_t = 14,	zs1_skill_t = 0,	zs2_skill_t = 9.8000,	yc1_skill_t = 19,	yc2_skill_t = 0,	cmbs_t = 25,	cm_skill_t = 27,	finish_t = 28,	auto_ai1 = {3,11},	auto_ai2 = {22,60},	auto_ai3 = {200,300},	zs_mana = {0,200,0},	qs_mana = {0,0,0},	yc_mana = {44,0,60},	zl_mana = {400,0,0},	first_fight_times = {5,9,999,999,8,14,16},},
}

return _table
