--[[
	lv = 宝石等级
sucscore = 成功点数
score = 贡献点数
atkrate = 特效附加概率
hprate = 特效抗性概率
defrate = 特效防御概率
price = 宝石价值
awake = 所需精灵觉醒等级

--]]
local _table = {
	[1] = {	lv = 1,	sucscore = 0,	score = 10,	atkrate = 0.0100,	hprate = 0.0300,	defrate = 0.0250,	price = 10,	awake = 0,},
	[2] = {	lv = 2,	sucscore = 20,	score = 20,	atkrate = 0.0180,	hprate = 0.0600,	defrate = 0.0450,	price = 50,	awake = 4,},
	[3] = {	lv = 3,	sucscore = 60,	score = 60,	atkrate = 0.0280,	hprate = 0.1000,	defrate = 0.0700,	price = 250,	awake = 8,},
	[4] = {	lv = 4,	sucscore = 120,	score = 120,	atkrate = 0.0420,	hprate = 0.1500,	defrate = 0.1050,	price = 1250,	awake = 12,},
	[5] = {	lv = 5,	sucscore = 240,	score = 240,	atkrate = 0.0600,	hprate = 0.2100,	defrate = 0.1500,	price = 6250,	awake = 16,},
	[6] = {	lv = 6,	sucscore = 480,	score = 480,	atkrate = 0.1000,	hprate = 0.3500,	defrate = 0.2500,	price = 25000,	awake = 20,},
	[7] = {	lv = 7,	sucscore = 960,	score = 960,	atkrate = 0.2000,	hprate = 0.7000,	defrate = 0.5000,	price = 75000,	awake = 24,},
}

return _table
