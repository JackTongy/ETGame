--[[
	ID = 唯一ID
atk_method = 攻击方式
method = 职业细分
nil = 攻击方式
time = 伤害触发时间

--]]
local _table = {
	[1] = {	ID = 1,	atk_method = [[战士近战攻击]],	method = 1,	time = 0.4000,},
	[2] = {	ID = 2,	atk_method = [[战士近战攻击暴击]],	method = 1,	time = 1.1000,},
	[3] = {	ID = 3,	atk_method = [[坦克近战攻击]],	method = 2,	time = 0.4000,},
	[4] = {	ID = 4,	atk_method = [[坦克近战攻击暴击]],	method = 2,	time = 1.1000,},
	[5] = {	ID = 5,	atk_method = [[法师法球攻击]],	method = 5,	time = 0.6500,},
	[6] = {	ID = 6,	atk_method = [[法师法球攻击暴击]],	method = 5,	time = 0.6600,},
	[7] = {	ID = 7,	atk_method = [[法师近战攻击]],	method = 5,	time = 0.4000,},
	[8] = {	ID = 8,	atk_method = [[法师近战攻击暴击]],	method = 5,	time = 1.1000,},
	[9] = {	ID = 9,	atk_method = [[射手远程攻击]],	method = 6,	time = 0.5500,},
	[10] = {	ID = 10,	atk_method = [[射手远程攻击暴击]],	method = 6,	time = 0.6500,},
	[11] = {	ID = 11,	atk_method = [[射手近战攻击]],	method = 6,	time = 0.6300,},
	[12] = {	ID = 12,	atk_method = [[射手近战攻击暴击]],	method = 6,	time = 0.6300,},
	[13] = {	ID = 13,	atk_method = [[治疗]],	method = 4,	time = 0.5500,},
	[14] = {	ID = 14,	atk_method = [[治疗近战攻击]],	method = 4,	time = 0.6300,},
	[15] = {	ID = 15,	atk_method = [[治疗近战攻击暴击]],	method = 4,	time = 0.6300,},
}

return _table
