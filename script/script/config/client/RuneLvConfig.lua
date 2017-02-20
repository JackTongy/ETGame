--[[
	star = 符文星级
Lv = 符文等级
UpgradeAmount = 升级消耗魔力石数量
SuccessRate = 成功率

--]]
local _table = {
	[1] = {	star = 1,	Lv = 0,	UpgradeAmount = 10,	SuccessRate = 1,},
	[2] = {	star = 1,	Lv = 1,	UpgradeAmount = 50,	SuccessRate = 0.8000,},
	[3] = {	star = 1,	Lv = 2,	UpgradeAmount = 100,	SuccessRate = 0.5000,},
	[4] = {	star = 1,	Lv = 3,	UpgradeAmount = 200,	SuccessRate = 0.6000,},
	[5] = {	star = 1,	Lv = 4,	UpgradeAmount = 400,	SuccessRate = 0.5000,},
	[6] = {	star = 1,	Lv = 5,	UpgradeAmount = 600,	SuccessRate = 0.2000,},
	[7] = {	star = 1,	Lv = 6,	UpgradeAmount = 800,	SuccessRate = 0.5000,},
	[8] = {	star = 1,	Lv = 7,	UpgradeAmount = 1000,	SuccessRate = 0.3500,},
	[9] = {	star = 1,	Lv = 8,	UpgradeAmount = 1200,	SuccessRate = 0.1500,},
	[10] = {	star = 1,	Lv = 9,	UpgradeAmount = 1400,	SuccessRate = 0.5000,},
	[11] = {	star = 1,	Lv = 10,	UpgradeAmount = 1600,	SuccessRate = 0.3500,},
	[12] = {	star = 1,	Lv = 11,	UpgradeAmount = 1800,	SuccessRate = 0.1000,},
	[13] = {	star = 1,	Lv = 12,	UpgradeAmount = 2000,	SuccessRate = 0,},
	[14] = {	star = 2,	Lv = 0,	UpgradeAmount = 10,	SuccessRate = 1,},
	[15] = {	star = 2,	Lv = 1,	UpgradeAmount = 50,	SuccessRate = 0.8000,},
	[16] = {	star = 2,	Lv = 2,	UpgradeAmount = 100,	SuccessRate = 0.5000,},
	[17] = {	star = 2,	Lv = 3,	UpgradeAmount = 200,	SuccessRate = 0.6000,},
	[18] = {	star = 2,	Lv = 4,	UpgradeAmount = 400,	SuccessRate = 0.5000,},
	[19] = {	star = 2,	Lv = 5,	UpgradeAmount = 600,	SuccessRate = 0.2000,},
	[20] = {	star = 2,	Lv = 6,	UpgradeAmount = 800,	SuccessRate = 0.5000,},
	[21] = {	star = 2,	Lv = 7,	UpgradeAmount = 1000,	SuccessRate = 0.3500,},
	[22] = {	star = 2,	Lv = 8,	UpgradeAmount = 1200,	SuccessRate = 0.1500,},
	[23] = {	star = 2,	Lv = 9,	UpgradeAmount = 1400,	SuccessRate = 0.5000,},
	[24] = {	star = 2,	Lv = 10,	UpgradeAmount = 1600,	SuccessRate = 0.3500,},
	[25] = {	star = 2,	Lv = 11,	UpgradeAmount = 1800,	SuccessRate = 0.1000,},
	[26] = {	star = 2,	Lv = 12,	UpgradeAmount = 2000,	SuccessRate = 0,},
	[27] = {	star = 3,	Lv = 0,	UpgradeAmount = 10,	SuccessRate = 1,},
	[28] = {	star = 3,	Lv = 1,	UpgradeAmount = 50,	SuccessRate = 0.8000,},
	[29] = {	star = 3,	Lv = 2,	UpgradeAmount = 100,	SuccessRate = 0.5000,},
	[30] = {	star = 3,	Lv = 3,	UpgradeAmount = 200,	SuccessRate = 0.6000,},
	[31] = {	star = 3,	Lv = 4,	UpgradeAmount = 400,	SuccessRate = 0.5000,},
	[32] = {	star = 3,	Lv = 5,	UpgradeAmount = 600,	SuccessRate = 0.2000,},
	[33] = {	star = 3,	Lv = 6,	UpgradeAmount = 800,	SuccessRate = 0.5000,},
	[34] = {	star = 3,	Lv = 7,	UpgradeAmount = 1000,	SuccessRate = 0.3500,},
	[35] = {	star = 3,	Lv = 8,	UpgradeAmount = 1200,	SuccessRate = 0.1500,},
	[36] = {	star = 3,	Lv = 9,	UpgradeAmount = 1400,	SuccessRate = 0.5000,},
	[37] = {	star = 3,	Lv = 10,	UpgradeAmount = 1600,	SuccessRate = 0.3500,},
	[38] = {	star = 3,	Lv = 11,	UpgradeAmount = 1800,	SuccessRate = 0.1000,},
	[39] = {	star = 3,	Lv = 12,	UpgradeAmount = 2000,	SuccessRate = 0,},
	[40] = {	star = 4,	Lv = 0,	UpgradeAmount = 10,	SuccessRate = 1,},
	[41] = {	star = 4,	Lv = 1,	UpgradeAmount = 50,	SuccessRate = 0.8000,},
	[42] = {	star = 4,	Lv = 2,	UpgradeAmount = 100,	SuccessRate = 0.5000,},
	[43] = {	star = 4,	Lv = 3,	UpgradeAmount = 200,	SuccessRate = 0.6000,},
	[44] = {	star = 4,	Lv = 4,	UpgradeAmount = 400,	SuccessRate = 0.5000,},
	[45] = {	star = 4,	Lv = 5,	UpgradeAmount = 600,	SuccessRate = 0.2000,},
	[46] = {	star = 4,	Lv = 6,	UpgradeAmount = 800,	SuccessRate = 0.5000,},
	[47] = {	star = 4,	Lv = 7,	UpgradeAmount = 1000,	SuccessRate = 0.3500,},
	[48] = {	star = 4,	Lv = 8,	UpgradeAmount = 1200,	SuccessRate = 0.1500,},
	[49] = {	star = 4,	Lv = 9,	UpgradeAmount = 1400,	SuccessRate = 0.5000,},
	[50] = {	star = 4,	Lv = 10,	UpgradeAmount = 1600,	SuccessRate = 0.3500,},
	[51] = {	star = 4,	Lv = 11,	UpgradeAmount = 1800,	SuccessRate = 0.1000,},
	[52] = {	star = 4,	Lv = 12,	UpgradeAmount = 2000,	SuccessRate = 0,},
	[53] = {	star = 5,	Lv = 0,	UpgradeAmount = 15,	SuccessRate = 1,},
	[54] = {	star = 5,	Lv = 1,	UpgradeAmount = 75,	SuccessRate = 0.8000,},
	[55] = {	star = 5,	Lv = 2,	UpgradeAmount = 150,	SuccessRate = 0.5000,},
	[56] = {	star = 5,	Lv = 3,	UpgradeAmount = 300,	SuccessRate = 0.6000,},
	[57] = {	star = 5,	Lv = 4,	UpgradeAmount = 600,	SuccessRate = 0.5000,},
	[58] = {	star = 5,	Lv = 5,	UpgradeAmount = 900,	SuccessRate = 0.2000,},
	[59] = {	star = 5,	Lv = 6,	UpgradeAmount = 1200,	SuccessRate = 0.5000,},
	[60] = {	star = 5,	Lv = 7,	UpgradeAmount = 1500,	SuccessRate = 0.3500,},
	[61] = {	star = 5,	Lv = 8,	UpgradeAmount = 1800,	SuccessRate = 0.1500,},
	[62] = {	star = 5,	Lv = 9,	UpgradeAmount = 2100,	SuccessRate = 0.5000,},
	[63] = {	star = 5,	Lv = 10,	UpgradeAmount = 2400,	SuccessRate = 0.3500,},
	[64] = {	star = 5,	Lv = 11,	UpgradeAmount = 2700,	SuccessRate = 0.1000,},
	[65] = {	star = 5,	Lv = 12,	UpgradeAmount = 3000,	SuccessRate = 0,},
}

return _table
