--[[
	waveid = 波ID
heroid =  英雄唯一ID
entertime = 入场时间
enterposition = 入场位置
isboss = 是不是BOSS(0表示不是boss，1表示是boss)
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
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil
nil = nil

--]]
local _table = {
	[1] = {	waveid = 1,	heroid = 1,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[2] = {	waveid = 1,	heroid = 1,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[3] = {	waveid = 1,	heroid = 1,	entertime = 0,	enterposition = 3,	isboss = 0,},
	[4] = {	waveid = 1,	heroid = 1,	entertime = 8,	enterposition = 1,	isboss = 0,},
	[5] = {	waveid = 1,	heroid = 1,	entertime = 8,	enterposition = 2,	isboss = 0,},
	[6] = {	waveid = 1,	heroid = 1,	entertime = 8,	enterposition = 3,	isboss = 0,},
	[7] = {	waveid = 2,	heroid = 5,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[8] = {	waveid = 2,	heroid = 5,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[9] = {	waveid = 2,	heroid = 5,	entertime = 0,	enterposition = 3,	isboss = 0,},
	[10] = {	waveid = 2,	heroid = 1,	entertime = 8,	enterposition = 1,	isboss = 0,},
	[11] = {	waveid = 2,	heroid = 1,	entertime = 8,	enterposition = 2,	isboss = 0,},
	[12] = {	waveid = 2,	heroid = 1,	entertime = 8,	enterposition = 3,	isboss = 0,},
	[13] = {	waveid = 3,	heroid = 5,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[14] = {	waveid = 3,	heroid = 5,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[15] = {	waveid = 3,	heroid = 5,	entertime = 0,	enterposition = 3,	isboss = 0,},
	[16] = {	waveid = 3,	heroid = 9,	entertime = 8,	enterposition = 1,	isboss = 0,},
	[17] = {	waveid = 3,	heroid = 9,	entertime = 8,	enterposition = 2,	isboss = 0,},
	[18] = {	waveid = 3,	heroid = 9,	entertime = 8,	enterposition = 3,	isboss = 0,},
	[19] = {	waveid = 3,	heroid = 10,	entertime = 16,	enterposition = 1,	isboss = 0,},
	[20] = {	waveid = 3,	heroid = 13,	entertime = 18,	enterposition = 2,	isboss = 1,},
	[21] = {	waveid = 3,	heroid = 10,	entertime = 16,	enterposition = 3,	isboss = 0,},
	[22] = {	waveid = 4,	heroid = 1,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[23] = {	waveid = 4,	heroid = 1,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[24] = {	waveid = 4,	heroid = 1,	entertime = 0,	enterposition = 3,	isboss = 0,},
	[25] = {	waveid = 4,	heroid = 10,	entertime = 8,	enterposition = 1,	isboss = 0,},
	[26] = {	waveid = 4,	heroid = 10,	entertime = 8,	enterposition = 2,	isboss = 0,},
	[27] = {	waveid = 4,	heroid = 9,	entertime = 8,	enterposition = 3,	isboss = 0,},
	[28] = {	waveid = 5,	heroid = 5,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[29] = {	waveid = 5,	heroid = 5,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[30] = {	waveid = 5,	heroid = 5,	entertime = 0,	enterposition = 3,	isboss = 0,},
	[31] = {	waveid = 5,	heroid = 10,	entertime = 8,	enterposition = 1,	isboss = 0,},
	[32] = {	waveid = 5,	heroid = 12,	entertime = 8,	enterposition = 2,	isboss = 0,},
	[33] = {	waveid = 5,	heroid = 10,	entertime = 8,	enterposition = 3,	isboss = 0,},
	[34] = {	waveid = 6,	heroid = 6,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[35] = {	waveid = 6,	heroid = 6,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[36] = {	waveid = 6,	heroid = 6,	entertime = 0,	enterposition = 3,	isboss = 0,},
	[37] = {	waveid = 6,	heroid = 2,	entertime = 8,	enterposition = 1,	isboss = 0,},
	[38] = {	waveid = 6,	heroid = 2,	entertime = 8,	enterposition = 2,	isboss = 0,},
	[39] = {	waveid = 6,	heroid = 2,	entertime = 8,	enterposition = 3,	isboss = 0,},
	[40] = {	waveid = 6,	heroid = 11,	entertime = 18,	enterposition = 1,	isboss = 0,},
	[41] = {	waveid = 6,	heroid = 14,	entertime = 16,	enterposition = 2,	isboss = 1,},
	[42] = {	waveid = 6,	heroid = 10,	entertime = 18,	enterposition = 3,	isboss = 0,},
	[43] = {	waveid = 7,	heroid = 15,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[44] = {	waveid = 8,	heroid = 15,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[45] = {	waveid = 8,	heroid = 15,	entertime = 0,	enterposition = 3,	isboss = 0,},
	[46] = {	waveid = 9,	heroid = 15,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[47] = {	waveid = 9,	heroid = 15,	entertime = 8,	enterposition = 1,	isboss = 0,},
	[48] = {	waveid = 9,	heroid = 15,	entertime = 10,	enterposition = 2,	isboss = 1,},
	[49] = {	waveid = 10,	heroid = 16,	entertime = 2,	enterposition = 2,	isboss = 1,},
	[50] = {	waveid = 11,	heroid = 2,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[51] = {	waveid = 11,	heroid = 2,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[52] = {	waveid = 11,	heroid = 2,	entertime = 0,	enterposition = 3,	isboss = 0,},
	[53] = {	waveid = 11,	heroid = 2,	entertime = 8,	enterposition = 1,	isboss = 0,},
	[54] = {	waveid = 11,	heroid = 2,	entertime = 8,	enterposition = 2,	isboss = 0,},
	[55] = {	waveid = 11,	heroid = 2,	entertime = 10,	enterposition = 3,	isboss = 0,},
	[56] = {	waveid = 11,	heroid = 2,	entertime = 18,	enterposition = 1,	isboss = 0,},
	[57] = {	waveid = 11,	heroid = 2,	entertime = 16,	enterposition = 2,	isboss = 0,},
	[58] = {	waveid = 11,	heroid = 2,	entertime = 18,	enterposition = 3,	isboss = 0,},
	[59] = {	waveid = 12,	heroid = 6,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[60] = {	waveid = 12,	heroid = 6,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[61] = {	waveid = 12,	heroid = 6,	entertime = 0,	enterposition = 3,	isboss = 0,},
	[62] = {	waveid = 12,	heroid = 6,	entertime = 8,	enterposition = 1,	isboss = 0,},
	[63] = {	waveid = 12,	heroid = 6,	entertime = 8,	enterposition = 2,	isboss = 0,},
	[64] = {	waveid = 12,	heroid = 6,	entertime = 8,	enterposition = 3,	isboss = 0,},
	[65] = {	waveid = 12,	heroid = 6,	entertime = 16,	enterposition = 1,	isboss = 0,},
	[66] = {	waveid = 12,	heroid = 6,	entertime = 12,	enterposition = 2,	isboss = 0,},
	[67] = {	waveid = 13,	heroid = 16,	entertime = 0,	enterposition = 2,	isboss = 1,},
	[68] = {	waveid = 21,	heroid = 101,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[69] = {	waveid = 21,	heroid = 102,	entertime = 1,	enterposition = 2,	isboss = 0,},
	[70] = {	waveid = 21,	heroid = 103,	entertime = 0,	enterposition = 3,	isboss = 0,},
	[71] = {	waveid = 22,	heroid = 104,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[72] = {	waveid = 22,	heroid = 105,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[73] = {	waveid = 22,	heroid = 106,	entertime = 1,	enterposition = 3,	isboss = 0,},
	[74] = {	waveid = 22,	heroid = 107,	entertime = 1,	enterposition = 1,	isboss = 0,},
	[75] = {	waveid = 23,	heroid = 108,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[76] = {	waveid = 23,	heroid = 109,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[77] = {	waveid = 23,	heroid = 110,	entertime = 1,	enterposition = 3,	isboss = 0,},
	[78] = {	waveid = 23,	heroid = 111,	entertime = 2,	enterposition = 3,	isboss = 0,},
	[79] = {	waveid = 23,	heroid = 112,	entertime = 3,	enterposition = 2,	isboss = 1,},
	[80] = {	waveid = 24,	heroid = 113,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[81] = {	waveid = 24,	heroid = 114,	entertime = 1,	enterposition = 2,	isboss = 0,},
	[82] = {	waveid = 24,	heroid = 115,	entertime = 0,	enterposition = 3,	isboss = 0,},
	[83] = {	waveid = 25,	heroid = 116,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[84] = {	waveid = 25,	heroid = 117,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[85] = {	waveid = 25,	heroid = 118,	entertime = 1,	enterposition = 3,	isboss = 0,},
	[86] = {	waveid = 25,	heroid = 119,	entertime = 1,	enterposition = 1,	isboss = 0,},
	[87] = {	waveid = 26,	heroid = 120,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[88] = {	waveid = 26,	heroid = 121,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[89] = {	waveid = 26,	heroid = 122,	entertime = 1,	enterposition = 3,	isboss = 0,},
	[90] = {	waveid = 26,	heroid = 123,	entertime = 2,	enterposition = 3,	isboss = 0,},
	[91] = {	waveid = 26,	heroid = 124,	entertime = 3,	enterposition = 2,	isboss = 1,},
	[92] = {	waveid = 27,	heroid = 125,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[93] = {	waveid = 27,	heroid = 126,	entertime = 1,	enterposition = 2,	isboss = 0,},
	[94] = {	waveid = 27,	heroid = 127,	entertime = 0,	enterposition = 3,	isboss = 0,},
	[95] = {	waveid = 28,	heroid = 128,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[96] = {	waveid = 28,	heroid = 129,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[97] = {	waveid = 28,	heroid = 130,	entertime = 1,	enterposition = 3,	isboss = 0,},
	[98] = {	waveid = 28,	heroid = 131,	entertime = 1,	enterposition = 1,	isboss = 0,},
	[99] = {	waveid = 29,	heroid = 132,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[100] = {	waveid = 29,	heroid = 133,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[101] = {	waveid = 29,	heroid = 134,	entertime = 1,	enterposition = 3,	isboss = 0,},
	[102] = {	waveid = 29,	heroid = 135,	entertime = 2,	enterposition = 3,	isboss = 0,},
	[103] = {	waveid = 29,	heroid = 136,	entertime = 3,	enterposition = 2,	isboss = 1,},
	[104] = {	waveid = 30,	heroid = 137,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[105] = {	waveid = 30,	heroid = 138,	entertime = 1,	enterposition = 2,	isboss = 0,},
	[106] = {	waveid = 30,	heroid = 139,	entertime = 0,	enterposition = 3,	isboss = 0,},
	[107] = {	waveid = 31,	heroid = 140,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[108] = {	waveid = 31,	heroid = 141,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[109] = {	waveid = 31,	heroid = 142,	entertime = 1,	enterposition = 3,	isboss = 0,},
	[110] = {	waveid = 31,	heroid = 143,	entertime = 1,	enterposition = 1,	isboss = 0,},
	[111] = {	waveid = 32,	heroid = 144,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[112] = {	waveid = 32,	heroid = 145,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[113] = {	waveid = 32,	heroid = 146,	entertime = 1,	enterposition = 3,	isboss = 0,},
	[114] = {	waveid = 32,	heroid = 147,	entertime = 2,	enterposition = 3,	isboss = 0,},
	[115] = {	waveid = 32,	heroid = 148,	entertime = 2,	enterposition = 2,	isboss = 0,},
	[116] = {	waveid = 33,	heroid = 149,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[117] = {	waveid = 33,	heroid = 150,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[118] = {	waveid = 33,	heroid = 151,	entertime = 0,	enterposition = 3,	isboss = 0,},
	[119] = {	waveid = 33,	heroid = 152,	entertime = 1,	enterposition = 1,	isboss = 0,},
	[120] = {	waveid = 33,	heroid = 153,	entertime = 2,	enterposition = 3,	isboss = 0,},
	[121] = {	waveid = 33,	heroid = 154,	entertime = 3,	enterposition = 2,	isboss = 1,},
	[122] = {	waveid = 101,	heroid = 102,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[123] = {	waveid = 101,	heroid = 102,	entertime = 3,	enterposition = 2,	isboss = 0,},
	[124] = {	waveid = 101,	heroid = 102,	entertime = 6,	enterposition = 3,	isboss = 0,},
	[125] = {	waveid = 101,	heroid = 102,	entertime = 6,	enterposition = 1,	isboss = 0,},
	[126] = {	waveid = 101,	heroid = 102,	entertime = 9,	enterposition = 2,	isboss = 0,},
	[127] = {	waveid = 101,	heroid = 102,	entertime = 12,	enterposition = 3,	isboss = 0,},
	[128] = {	waveid = 102,	heroid = 106,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[129] = {	waveid = 102,	heroid = 106,	entertime = 4,	enterposition = 1,	isboss = 0,},
	[130] = {	waveid = 102,	heroid = 104,	entertime = 4,	enterposition = 2,	isboss = 0,},
	[131] = {	waveid = 102,	heroid = 106,	entertime = 4,	enterposition = 3,	isboss = 0,},
	[132] = {	waveid = 102,	heroid = 104,	entertime = 7,	enterposition = 1,	isboss = 0,},
	[133] = {	waveid = 102,	heroid = 104,	entertime = 7,	enterposition = 2,	isboss = 0,},
	[134] = {	waveid = 102,	heroid = 104,	entertime = 7,	enterposition = 3,	isboss = 0,},
	[135] = {	waveid = 103,	heroid = 101,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[136] = {	waveid = 103,	heroid = 101,	entertime = 2,	enterposition = 1,	isboss = 0,},
	[137] = {	waveid = 103,	heroid = 102,	entertime = 2,	enterposition = 2,	isboss = 0,},
	[138] = {	waveid = 103,	heroid = 105,	entertime = 6,	enterposition = 1,	isboss = 0,},
	[139] = {	waveid = 103,	heroid = 105,	entertime = 6,	enterposition = 2,	isboss = 0,},
	[140] = {	waveid = 103,	heroid = 105,	entertime = 6,	enterposition = 3,	isboss = 0,},
	[141] = {	waveid = 103,	heroid = 102,	entertime = 9,	enterposition = 3,	isboss = 0,},
	[142] = {	waveid = 104,	heroid = 103,	entertime = 0,	enterposition = 2,	isboss = 1,},
	[143] = {	waveid = 104,	heroid = 102,	entertime = 1,	enterposition = 1,	isboss = 0,},
	[144] = {	waveid = 104,	heroid = 102,	entertime = 1,	enterposition = 2,	isboss = 0,},
	[145] = {	waveid = 104,	heroid = 106,	entertime = 4,	enterposition = 1,	isboss = 0,},
	[146] = {	waveid = 104,	heroid = 106,	entertime = 4,	enterposition = 2,	isboss = 0,},
	[147] = {	waveid = 104,	heroid = 106,	entertime = 4,	enterposition = 3,	isboss = 0,},
	[148] = {	waveid = 111,	heroid = 1001,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[149] = {	waveid = 111,	heroid = 1001,	entertime = 2,	enterposition = 1,	isboss = 0,},
	[150] = {	waveid = 111,	heroid = 1001,	entertime = 4,	enterposition = 3,	isboss = 0,},
	[151] = {	waveid = 111,	heroid = 1001,	entertime = 6,	enterposition = 2,	isboss = 0,},
	[152] = {	waveid = 111,	heroid = 1002,	entertime = 5,	enterposition = 2,	isboss = 0,},
	[153] = {	waveid = 111,	heroid = 1002,	entertime = 6,	enterposition = 1,	isboss = 0,},
	[154] = {	waveid = 111,	heroid = 1002,	entertime = 6,	enterposition = 3,	isboss = 0,},
	[155] = {	waveid = 112,	heroid = 1004,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[156] = {	waveid = 112,	heroid = 1004,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[157] = {	waveid = 112,	heroid = 1004,	entertime = 3,	enterposition = 3,	isboss = 0,},
	[158] = {	waveid = 112,	heroid = 1005,	entertime = 3,	enterposition = 1,	isboss = 0,},
	[159] = {	waveid = 112,	heroid = 1005,	entertime = 5,	enterposition = 2,	isboss = 0,},
	[160] = {	waveid = 112,	heroid = 1004,	entertime = 6,	enterposition = 3,	isboss = 0,},
	[161] = {	waveid = 113,	heroid = 1006,	entertime = 0,	enterposition = 2,	isboss = 0,},
	[162] = {	waveid = 113,	heroid = 1006,	entertime = 4,	enterposition = 1,	isboss = 0,},
	[163] = {	waveid = 113,	heroid = 1007,	entertime = 6,	enterposition = 2,	isboss = 0,},
	[164] = {	waveid = 113,	heroid = 1007,	entertime = 6,	enterposition = 3,	isboss = 0,},
	[165] = {	waveid = 114,	heroid = 1008,	entertime = 0,	enterposition = 1,	isboss = 0,},
	[166] = {	waveid = 114,	heroid = 1008,	entertime = 0,	enterposition = 3,	isboss = 0,},
	[167] = {	waveid = 114,	heroid = 1009,	entertime = 2,	enterposition = 2,	isboss = 0,},
	[168] = {	waveid = 114,	heroid = 1008,	entertime = 6,	enterposition = 1,	isboss = 0,},
	[169] = {	waveid = 114,	heroid = 1008,	entertime = 6,	enterposition = 2,	isboss = 0,},
	[170] = {	waveid = 114,	heroid = 1008,	entertime = 6,	enterposition = 3,	isboss = 0,},
	[171] = {	waveid = 114,	heroid = 1010,	entertime = 8,	enterposition = 3,	isboss = 0,},
	[172] = {	waveid = 1001,	heroid = 10011,	entertime = 0.3000,	enterposition = 3,	isboss = 0,},
	[173] = {	waveid = 1001,	heroid = 10012,	entertime = 13,	enterposition = 2,	isboss = 0,},
	[174] = {	waveid = 1001,	heroid = 10013,	entertime = 11,	enterposition = 3,	isboss = 0,},
	[175] = {	waveid = 1001,	heroid = 10013,	entertime = 14.5000,	enterposition = 1,	isboss = 0,},
	[176] = {	waveid = 1002,	heroid = 10021,	entertime = 1,	enterposition = 2,	isboss = 0,},
	[177] = {	waveid = 1002,	heroid = 10022,	entertime = 0.3000,	enterposition = 2,	isboss = 0,},
	[178] = {	waveid = 1002,	heroid = 10023,	entertime = 2,	enterposition = 2,	isboss = 0,},
	[179] = {	waveid = 1002,	heroid = 10024,	entertime = 18,	enterposition = 2,	isboss = 0,},
	[180] = {	waveid = 1002,	heroid = 10025,	entertime = 18.5000,	enterposition = 1,	isboss = 0,},
	[181] = {	waveid = 1002,	heroid = 10028,	entertime = 23,	enterposition = 2,	isboss = 0,},
	[182] = {	waveid = 1002,	heroid = 10029,	entertime = 18.5000,	enterposition = 3,	isboss = 0,},
	[183] = {	waveid = 1002,	heroid = 10024,	entertime = 21,	enterposition = 1,	isboss = 0,},
	[184] = {	waveid = 1002,	heroid = 10032,	entertime = 21,	enterposition = 3,	isboss = 0,},
}

return _table
