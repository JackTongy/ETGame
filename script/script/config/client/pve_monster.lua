--[[
	heroid =  英雄唯一ID
charactorId = 英雄角色id
awaken = 觉醒次数
intimacy = 亲密度
hp = 血量
atk = 攻击力
def = 防御力
crit = 暴击
spd = 移动速度
atktime = 攻击速度
roleid = 皮肤id
aiType = 怪物ai类型（怪物ai类型）0表示根据职业默认的ai类类型, 1表示速度近战型
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil

--]]
local _table = {
	[1] = {	heroid = 1,	charactorId = 12,	awaken = 0,	intimacy = 0,	hp = 500,	atk = 1000,	def = 150,	crit = 40,	spd = 140,	atktime = 1.5000,	roleid = [[013]],	aiType = 0,},
	[2] = {	heroid = 2,	charactorId = 106,	awaken = 0,	intimacy = 0,	hp = 500,	atk = 1000,	def = 150,	crit = 40,	spd = 140,	atktime = 1.5000,	roleid = [[014]],	aiType = 0,},
	[3] = {	heroid = 3,	charactorId = 461,	awaken = 0,	intimacy = 0,	hp = 500,	atk = 1000,	def = 150,	crit = 40,	spd = 140,	atktime = 1.5000,	roleid = [[019]],	aiType = 0,},
	[4] = {	heroid = 4,	charactorId = 483,	awaken = 0,	intimacy = 0,	hp = 500,	atk = 1000,	def = 150,	crit = 40,	spd = 140,	atktime = 1.5000,	roleid = [[128]],	aiType = 0,},
	[5] = {	heroid = 5,	charactorId = 32,	awaken = 0,	intimacy = 0,	hp = 500,	atk = 750,	def = 450,	crit = 0,	spd = 112,	atktime = 1.7500,	roleid = [[075]],	aiType = 0,},
	[6] = {	heroid = 6,	charactorId = 32,	awaken = 0,	intimacy = 0,	hp = 500,	atk = 750,	def = 450,	crit = 0,	spd = 112,	atktime = 1.7500,	roleid = [[075]],	aiType = 0,},
	[7] = {	heroid = 7,	charactorId = 28,	awaken = 0,	intimacy = 0,	hp = 500,	atk = 750,	def = 450,	crit = 0,	spd = 112,	atktime = 1.7500,	roleid = [[029]],	aiType = 0,},
	[8] = {	heroid = 8,	charactorId = 95,	awaken = 0,	intimacy = 0,	hp = 500,	atk = 750,	def = 450,	crit = 0,	spd = 112,	atktime = 1.7500,	roleid = [[187]],	aiType = 0,},
	[9] = {	heroid = 9,	charactorId = 230,	awaken = 0,	intimacy = 0,	hp = 800,	atk = 1500,	def = 50,	crit = 0,	spd = 140,	atktime = 2,	roleid = [[010]],	aiType = 0,},
	[10] = {	heroid = 10,	charactorId = 384,	awaken = 0,	intimacy = 0,	hp = 800,	atk = 1500,	def = 50,	crit = 0,	spd = 140,	atktime = 2,	roleid = [[016]],	aiType = 0,},
	[11] = {	heroid = 11,	charactorId = 230,	awaken = 0,	intimacy = 0,	hp = 800,	atk = 1500,	def = 50,	crit = 0,	spd = 140,	atktime = 2,	roleid = [[010]],	aiType = 0,},
	[12] = {	heroid = 12,	charactorId = 349,	awaken = 0,	intimacy = 0,	hp = 800,	atk = 1550,	def = 150,	crit = 0,	spd = 140,	atktime = 2,	roleid = [[035]],	aiType = 0,},
	[13] = {	heroid = 13,	charactorId = 16,	awaken = 0,	intimacy = 0,	hp = 2000,	atk = 4000,	def = 200,	crit = 0,	spd = 140,	atktime = 2,	roleid = [[043]],	aiType = 0,},
	[14] = {	heroid = 14,	charactorId = 483,	awaken = 0,	intimacy = 0,	hp = 2000,	atk = 3000,	def = 200,	crit = 40,	spd = 140,	atktime = 1.5000,	roleid = [[128]],	aiType = 0,},
	[15] = {	heroid = 15,	charactorId = 461,	awaken = 0,	intimacy = 0,	hp = 2500,	atk = 1000,	def = 150,	crit = 40,	spd = 140,	atktime = 1.5000,	roleid = [[019]],	aiType = 0,},
	[16] = {	heroid = 16,	charactorId = 62,	awaken = 0,	intimacy = 0,	hp = 100000,	atk = 100,	def = 1000,	crit = 0.4000,	spd = 70,	atktime = 1.5000,	roleid = [[062]],	aiType = 0,},
	[17] = {	heroid = 107,	charactorId = 11,	awaken = 0,	intimacy = 0,	hp = 202,	atk = 161,	def = 0,	crit = 0,	spd = 120,	atktime = 2,	roleid = [[011]],	aiType = 0,},
	[18] = {	heroid = 108,	charactorId = 14,	awaken = 0,	intimacy = 0,	hp = 303,	atk = 242,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[014]],	aiType = 0,},
	[19] = {	heroid = 109,	charactorId = 13,	awaken = 0,	intimacy = 0,	hp = 303,	atk = 242,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[013]],	aiType = 0,},
	[20] = {	heroid = 110,	charactorId = 13,	awaken = 0,	intimacy = 0,	hp = 303,	atk = 242,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[013]],	aiType = 0,},
	[21] = {	heroid = 111,	charactorId = 14,	awaken = 0,	intimacy = 0,	hp = 303,	atk = 242,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[014]],	aiType = 0,},
	[22] = {	heroid = 112,	charactorId = 10,	awaken = 0,	intimacy = 0,	hp = 1212,	atk = 969,	def = 0,	crit = 0,	spd = 40,	atktime = 2,	roleid = [[010]],	aiType = 0,},
	[23] = {	heroid = 113,	charactorId = 14,	awaken = 0,	intimacy = 0,	hp = 102,	atk = 81,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[014]],	aiType = 0,},
	[24] = {	heroid = 114,	charactorId = 13,	awaken = 0,	intimacy = 0,	hp = 102,	atk = 81,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[013]],	aiType = 0,},
	[25] = {	heroid = 115,	charactorId = 13,	awaken = 0,	intimacy = 0,	hp = 102,	atk = 81,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[013]],	aiType = 0,},
	[26] = {	heroid = 116,	charactorId = 11,	awaken = 0,	intimacy = 0,	hp = 204,	atk = 163,	def = 0,	crit = 0,	spd = 120,	atktime = 2,	roleid = [[011]],	aiType = 0,},
	[27] = {	heroid = 117,	charactorId = 14,	awaken = 0,	intimacy = 0,	hp = 204,	atk = 163,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[014]],	aiType = 0,},
	[28] = {	heroid = 118,	charactorId = 13,	awaken = 0,	intimacy = 0,	hp = 204,	atk = 163,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[013]],	aiType = 0,},
	[29] = {	heroid = 119,	charactorId = 11,	awaken = 0,	intimacy = 0,	hp = 204,	atk = 163,	def = 0,	crit = 0,	spd = 120,	atktime = 2,	roleid = [[011]],	aiType = 0,},
	[30] = {	heroid = 120,	charactorId = 11,	awaken = 0,	intimacy = 0,	hp = 306,	atk = 244,	def = 0,	crit = 0,	spd = 120,	atktime = 2,	roleid = [[011]],	aiType = 0,},
	[31] = {	heroid = 121,	charactorId = 11,	awaken = 0,	intimacy = 0,	hp = 306,	atk = 244,	def = 0,	crit = 0,	spd = 120,	atktime = 2,	roleid = [[011]],	aiType = 0,},
	[32] = {	heroid = 122,	charactorId = 11,	awaken = 0,	intimacy = 0,	hp = 306,	atk = 244,	def = 0,	crit = 0,	spd = 120,	atktime = 2,	roleid = [[011]],	aiType = 0,},
	[33] = {	heroid = 123,	charactorId = 14,	awaken = 0,	intimacy = 0,	hp = 306,	atk = 244,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[014]],	aiType = 0,},
	[34] = {	heroid = 124,	charactorId = 19,	awaken = 0,	intimacy = 0,	hp = 1224,	atk = 979,	def = 0,	crit = 0,	spd = 40,	atktime = 1.5000,	roleid = [[019]],	aiType = 0,},
	[35] = {	heroid = 125,	charactorId = 13,	awaken = 0,	intimacy = 0,	hp = 103,	atk = 82,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[013]],	aiType = 0,},
	[36] = {	heroid = 126,	charactorId = 13,	awaken = 0,	intimacy = 0,	hp = 103,	atk = 82,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[013]],	aiType = 0,},
	[37] = {	heroid = 127,	charactorId = 13,	awaken = 0,	intimacy = 0,	hp = 103,	atk = 82,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[013]],	aiType = 0,},
	[38] = {	heroid = 128,	charactorId = 13,	awaken = 0,	intimacy = 0,	hp = 206,	atk = 164,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[013]],	aiType = 0,},
	[39] = {	heroid = 129,	charactorId = 13,	awaken = 0,	intimacy = 0,	hp = 206,	atk = 164,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[013]],	aiType = 0,},
	[40] = {	heroid = 130,	charactorId = 14,	awaken = 0,	intimacy = 0,	hp = 206,	atk = 164,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[014]],	aiType = 0,},
	[41] = {	heroid = 131,	charactorId = 11,	awaken = 0,	intimacy = 0,	hp = 206,	atk = 164,	def = 0,	crit = 0,	spd = 120,	atktime = 2,	roleid = [[011]],	aiType = 0,},
	[42] = {	heroid = 132,	charactorId = 11,	awaken = 0,	intimacy = 0,	hp = 309,	atk = 247,	def = 0,	crit = 0,	spd = 120,	atktime = 2,	roleid = [[011]],	aiType = 0,},
	[43] = {	heroid = 133,	charactorId = 14,	awaken = 0,	intimacy = 0,	hp = 309,	atk = 247,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[014]],	aiType = 0,},
	[44] = {	heroid = 134,	charactorId = 14,	awaken = 0,	intimacy = 0,	hp = 309,	atk = 247,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[014]],	aiType = 0,},
	[45] = {	heroid = 135,	charactorId = 13,	awaken = 0,	intimacy = 0,	hp = 309,	atk = 247,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[013]],	aiType = 0,},
	[46] = {	heroid = 136,	charactorId = 69,	awaken = 0,	intimacy = 0,	hp = 1236,	atk = 988,	def = 0,	crit = 0,	spd = 40,	atktime = 1.5000,	roleid = [[069]],	aiType = 0,},
	[47] = {	heroid = 137,	charactorId = 14,	awaken = 0,	intimacy = 0,	hp = 104,	atk = 83,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[014]],	aiType = 0,},
	[48] = {	heroid = 138,	charactorId = 14,	awaken = 0,	intimacy = 0,	hp = 104,	atk = 83,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[014]],	aiType = 0,},
	[49] = {	heroid = 139,	charactorId = 11,	awaken = 0,	intimacy = 0,	hp = 104,	atk = 83,	def = 0,	crit = 0,	spd = 120,	atktime = 2,	roleid = [[011]],	aiType = 0,},
	[50] = {	heroid = 140,	charactorId = 13,	awaken = 0,	intimacy = 0,	hp = 208,	atk = 166,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[013]],	aiType = 0,},
	[51] = {	heroid = 141,	charactorId = 14,	awaken = 0,	intimacy = 0,	hp = 208,	atk = 166,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[014]],	aiType = 0,},
	[52] = {	heroid = 142,	charactorId = 13,	awaken = 0,	intimacy = 0,	hp = 208,	atk = 166,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[013]],	aiType = 0,},
	[53] = {	heroid = 143,	charactorId = 14,	awaken = 0,	intimacy = 0,	hp = 208,	atk = 166,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[014]],	aiType = 0,},
	[54] = {	heroid = 144,	charactorId = 11,	awaken = 0,	intimacy = 0,	hp = 312,	atk = 249,	def = 0,	crit = 0,	spd = 120,	atktime = 2,	roleid = [[011]],	aiType = 0,},
	[55] = {	heroid = 145,	charactorId = 11,	awaken = 0,	intimacy = 0,	hp = 312,	atk = 249,	def = 0,	crit = 0,	spd = 120,	atktime = 2,	roleid = [[011]],	aiType = 0,},
	[56] = {	heroid = 146,	charactorId = 13,	awaken = 0,	intimacy = 0,	hp = 312,	atk = 249,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[013]],	aiType = 0,},
	[57] = {	heroid = 147,	charactorId = 14,	awaken = 0,	intimacy = 0,	hp = 312,	atk = 249,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[014]],	aiType = 0,},
	[58] = {	heroid = 148,	charactorId = 13,	awaken = 0,	intimacy = 0,	hp = 312,	atk = 249,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[013]],	aiType = 0,},
	[59] = {	heroid = 149,	charactorId = 11,	awaken = 0,	intimacy = 0,	hp = 416,	atk = 332,	def = 0,	crit = 0,	spd = 120,	atktime = 2,	roleid = [[011]],	aiType = 0,},
	[60] = {	heroid = 150,	charactorId = 14,	awaken = 0,	intimacy = 0,	hp = 416,	atk = 332,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[014]],	aiType = 0,},
	[61] = {	heroid = 151,	charactorId = 11,	awaken = 0,	intimacy = 0,	hp = 416,	atk = 332,	def = 0,	crit = 0,	spd = 120,	atktime = 2,	roleid = [[011]],	aiType = 0,},
	[62] = {	heroid = 152,	charactorId = 14,	awaken = 0,	intimacy = 0,	hp = 416,	atk = 332,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[014]],	aiType = 0,},
	[63] = {	heroid = 153,	charactorId = 13,	awaken = 0,	intimacy = 0,	hp = 416,	atk = 332,	def = 0,	crit = 0,	spd = 120,	atktime = 1.5000,	roleid = [[013]],	aiType = 0,},
	[64] = {	heroid = 154,	charactorId = 109,	awaken = 0,	intimacy = 0,	hp = 1664,	atk = 1331,	def = 0,	crit = 0,	spd = 40,	atktime = 2,	roleid = 109,	aiType = 0,},
	[65] = {	heroid = 101,	charactorId = 18,	awaken = 0,	intimacy = 0,	hp = 1000,	atk = 500,	def = 50,	crit = 0.1000,	spd = 110,	atktime = 2,	roleid = [[018]],	aiType = 0,},
	[66] = {	heroid = 102,	charactorId = 20,	awaken = 0,	intimacy = 0,	hp = 1000,	atk = 500,	def = 100,	crit = 0.4000,	spd = 120,	atktime = 1.5000,	roleid = [[020]],	aiType = 0,},
	[67] = {	heroid = 103,	charactorId = 62,	awaken = 0,	intimacy = 0,	hp = 10000,	atk = 800,	def = 100,	crit = 0.4000,	spd = 80,	atktime = 1.5000,	roleid = [[062]],	aiType = 0,},
	[68] = {	heroid = 104,	charactorId = 69,	awaken = 0,	intimacy = 0,	hp = 1000,	atk = 500,	def = 100,	crit = 0.4000,	spd = 120,	atktime = 1.5000,	roleid = [[069]],	aiType = 0,},
	[69] = {	heroid = 105,	charactorId = 148,	awaken = 0,	intimacy = 0,	hp = 1000,	atk = 500,	def = 50,	crit = 0.1000,	spd = 110,	atktime = 2,	roleid = [[148]],	aiType = 0,},
	[70] = {	heroid = 106,	charactorId = 290,	awaken = 0,	intimacy = 0,	hp = 1000,	atk = 500,	def = 200,	crit = 0.1000,	spd = 100,	atktime = 1.7500,	roleid = [[290]],	aiType = 0,},
	[71] = {	heroid = 1001,	charactorId = 20,	awaken = 0,	intimacy = 0,	hp = 1000,	atk = 500,	def = 100,	crit = 0.4000,	spd = 120,	atktime = 1.5000,	roleid = [[020]],	aiType = 1,},
	[72] = {	heroid = 1002,	charactorId = 62,	awaken = 0,	intimacy = 0,	hp = 1000,	atk = 500,	def = 100,	crit = 0.4000,	spd = 120,	atktime = 1.5000,	roleid = [[062]],	aiType = 2,},
	[73] = {	heroid = 1003,	charactorId = 62,	awaken = 0,	intimacy = 0,	hp = 1000,	atk = 500,	def = 100,	crit = 0.4000,	spd = 120,	atktime = 1.5000,	roleid = [[062]],	aiType = 3,},
	[74] = {	heroid = 1004,	charactorId = 160,	awaken = 0,	intimacy = 0,	hp = 1000,	atk = 500,	def = 100,	crit = 0.4000,	spd = 120,	atktime = 1.5000,	roleid = [[160]],	aiType = 4,},
	[75] = {	heroid = 1005,	charactorId = 290,	awaken = 0,	intimacy = 0,	hp = 1000,	atk = 500,	def = 100,	crit = 0.4000,	spd = 120,	atktime = 1.5000,	roleid = [[290]],	aiType = 5,},
	[76] = {	heroid = 1006,	charactorId = 306,	awaken = 0,	intimacy = 0,	hp = 1000,	atk = 500,	def = 100,	crit = 0.4000,	spd = 120,	atktime = 1.5000,	roleid = [[306]],	aiType = 6,},
	[77] = {	heroid = 1007,	charactorId = 359,	awaken = 0,	intimacy = 0,	hp = 1000,	atk = 500,	def = 100,	crit = 0.4000,	spd = 120,	atktime = 1.5000,	roleid = [[359]],	aiType = 7,},
	[78] = {	heroid = 1008,	charactorId = 359,	awaken = 0,	intimacy = 0,	hp = 1000,	atk = 500,	def = 100,	crit = 0.4000,	spd = 120,	atktime = 1.5000,	roleid = [[359]],	aiType = 8,},
	[79] = {	heroid = 1009,	charactorId = 182,	awaken = 0,	intimacy = 0,	hp = 1000,	atk = 500,	def = 50,	crit = 0.1000,	spd = 110,	atktime = 2,	roleid = [[182]],	aiType = 9,},
	[80] = {	heroid = 1010,	charactorId = 242,	awaken = 0,	intimacy = 0,	hp = 1000,	atk = 500,	def = 50,	crit = 0.1000,	spd = 110,	atktime = 2,	roleid = [[242]],	aiType = 9,},
	[81] = {	heroid = 10011,	charactorId = 115,	awaken = 0,	intimacy = 0,	hp = 31770,	atk = 60345,	def = 0,	crit = 0,	spd = 89,	atktime = 2,	roleid = [[115]],	aiType = 0,},
	[82] = {	heroid = 10012,	charactorId = 42,	awaken = 0,	intimacy = 0,	hp = 20000,	atk = 100000,	def = 0,	crit = 0,	spd = 88,	atktime = 1.2500,	roleid = [[042]],	aiType = 0,},
	[83] = {	heroid = 10013,	charactorId = 128,	awaken = 0,	intimacy = 0,	hp = 50000,	atk = 81435,	def = 0,	crit = 0,	spd = 50,	atktime = 1.5000,	roleid = [[128]],	aiType = 0,},
	[84] = {	heroid = 10021,	charactorId = 115,	awaken = 0,	intimacy = 0,	hp = 44935,	atk = 17774,	def = 0,	crit = 0,	spd = 89,	atktime = 1.8000,	roleid = [[115]],	aiType = 0,},
	[85] = {	heroid = 10022,	charactorId = 128,	awaken = 0,	intimacy = 0,	hp = 40731,	atk = 12433,	def = 0,	crit = 0,	spd = 92,	atktime = 1.8000,	roleid = [[128]],	aiType = 0,},
	[86] = {	heroid = 10023,	charactorId = 115,	awaken = 0,	intimacy = 0,	hp = 44935,	atk = 12453,	def = 0,	crit = 0,	spd = 88,	atktime = 1.8000,	roleid = [[115]],	aiType = 0,},
	[87] = {	heroid = 10024,	charactorId = 373,	awaken = 0,	intimacy = 0,	hp = 20000,	atk = 13333,	def = 0,	crit = 0,	spd = 84,	atktime = 1.8000,	roleid = [[373]],	aiType = 0,},
	[88] = {	heroid = 10025,	charactorId = 128,	awaken = 0,	intimacy = 0,	hp = 20000,	atk = 12222,	def = 0,	crit = 0,	spd = 87,	atktime = 1.8000,	roleid = [[128]],	aiType = 0,},
	[89] = {	heroid = 10028,	charactorId = 150,	awaken = 0,	intimacy = 0,	hp = 150000,	atk = 40000,	def = 0,	crit = 0,	spd = 80,	atktime = 2,	roleid = [[150]],	aiType = 101,},
	[90] = {	heroid = 10029,	charactorId = 128,	awaken = 0,	intimacy = 0,	hp = 20000,	atk = 15000,	def = 0,	crit = 0,	spd = 87,	atktime = 1.8000,	roleid = [[128]],	aiType = 0,},
	[91] = {	heroid = 10032,	charactorId = 128,	awaken = 0,	intimacy = 0,	hp = 20000,	atk = 13333,	def = 0,	crit = 0,	spd = 85,	atktime = 1.8000,	roleid = [[128]],	aiType = 0,},
}

return _table
