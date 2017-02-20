--[[
	Id = ID
Color = 装备品质
Locate = 装备位置
set = 是否为套装
Mid = 道具ID
Amt = 道具数量
Gold = 金币消耗

--]]
local _table = {
	[1] = {	Id = 1,	Color = 5,	Locate = 1,	set = 1,	Mid = 1200,	Amt = 20,	Gold = 2000000,},
	[2] = {	Id = 2,	Color = 5,	Locate = 1,	set = 1,	Mid = 1206,	Amt = 40,	Gold = 2000000,},
	[3] = {	Id = 3,	Color = 5,	Locate = 1,	set = 1,	Mid = 1207,	Amt = 65,	Gold = 2000000,},
	[4] = {	Id = 4,	Color = 5,	Locate = 1,	set = 1,	Mid = 1208,	Amt = 30,	Gold = 2000000,},
	[5] = {	Id = 5,	Color = 5,	Locate = 1,	set = 1,	Mid = 1209,	Amt = 35,	Gold = 2000000,},
	[6] = {	Id = 6,	Color = 5,	Locate = 1,	set = 0,	Mid = 1200,	Amt = 10,	Gold = 1000000,},
	[7] = {	Id = 7,	Color = 5,	Locate = 1,	set = 0,	Mid = 1206,	Amt = 40,	Gold = 1000000,},
	[8] = {	Id = 8,	Color = 5,	Locate = 1,	set = 0,	Mid = 1207,	Amt = 65,	Gold = 1000000,},
	[9] = {	Id = 9,	Color = 5,	Locate = 1,	set = 0,	Mid = 1208,	Amt = 30,	Gold = 1000000,},
	[10] = {	Id = 10,	Color = 5,	Locate = 1,	set = 0,	Mid = 1209,	Amt = 35,	Gold = 1000000,},
	[11] = {	Id = 11,	Color = 5,	Locate = 2,	set = 1,	Mid = 1202,	Amt = 20,	Gold = 2000000,},
	[12] = {	Id = 12,	Color = 5,	Locate = 2,	set = 1,	Mid = 1206,	Amt = 50,	Gold = 2000000,},
	[13] = {	Id = 13,	Color = 5,	Locate = 2,	set = 1,	Mid = 1207,	Amt = 55,	Gold = 2000000,},
	[14] = {	Id = 14,	Color = 5,	Locate = 2,	set = 1,	Mid = 1208,	Amt = 30,	Gold = 2000000,},
	[15] = {	Id = 15,	Color = 5,	Locate = 2,	set = 1,	Mid = 1209,	Amt = 35,	Gold = 2000000,},
	[16] = {	Id = 16,	Color = 5,	Locate = 2,	set = 0,	Mid = 1202,	Amt = 10,	Gold = 1000000,},
	[17] = {	Id = 17,	Color = 5,	Locate = 2,	set = 0,	Mid = 1206,	Amt = 50,	Gold = 1000000,},
	[18] = {	Id = 18,	Color = 5,	Locate = 2,	set = 0,	Mid = 1207,	Amt = 55,	Gold = 1000000,},
	[19] = {	Id = 19,	Color = 5,	Locate = 2,	set = 0,	Mid = 1208,	Amt = 30,	Gold = 1000000,},
	[20] = {	Id = 20,	Color = 5,	Locate = 2,	set = 0,	Mid = 1209,	Amt = 35,	Gold = 1000000,},
	[21] = {	Id = 21,	Color = 5,	Locate = 3,	set = 1,	Mid = 1204,	Amt = 20,	Gold = 2000000,},
	[22] = {	Id = 22,	Color = 5,	Locate = 3,	set = 1,	Mid = 1206,	Amt = 60,	Gold = 2000000,},
	[23] = {	Id = 23,	Color = 5,	Locate = 3,	set = 1,	Mid = 1207,	Amt = 45,	Gold = 2000000,},
	[24] = {	Id = 24,	Color = 5,	Locate = 3,	set = 1,	Mid = 1208,	Amt = 30,	Gold = 2000000,},
	[25] = {	Id = 25,	Color = 5,	Locate = 3,	set = 1,	Mid = 1209,	Amt = 35,	Gold = 2000000,},
	[26] = {	Id = 26,	Color = 5,	Locate = 3,	set = 0,	Mid = 1204,	Amt = 10,	Gold = 1000000,},
	[27] = {	Id = 27,	Color = 5,	Locate = 3,	set = 0,	Mid = 1206,	Amt = 60,	Gold = 1000000,},
	[28] = {	Id = 28,	Color = 5,	Locate = 3,	set = 0,	Mid = 1207,	Amt = 45,	Gold = 1000000,},
	[29] = {	Id = 29,	Color = 5,	Locate = 3,	set = 0,	Mid = 1208,	Amt = 30,	Gold = 1000000,},
	[30] = {	Id = 30,	Color = 5,	Locate = 3,	set = 0,	Mid = 1209,	Amt = 35,	Gold = 1000000,},
	[31] = {	Id = 31,	Color = 5,	Locate = 4,	set = 1,	Mid = 1201,	Amt = 20,	Gold = 2000000,},
	[32] = {	Id = 32,	Color = 5,	Locate = 4,	set = 1,	Mid = 1206,	Amt = 55,	Gold = 2000000,},
	[33] = {	Id = 33,	Color = 5,	Locate = 4,	set = 1,	Mid = 1207,	Amt = 50,	Gold = 2000000,},
	[34] = {	Id = 34,	Color = 5,	Locate = 4,	set = 1,	Mid = 1208,	Amt = 30,	Gold = 2000000,},
	[35] = {	Id = 35,	Color = 5,	Locate = 4,	set = 1,	Mid = 1209,	Amt = 35,	Gold = 2000000,},
	[36] = {	Id = 36,	Color = 5,	Locate = 4,	set = 0,	Mid = 1201,	Amt = 10,	Gold = 1000000,},
	[37] = {	Id = 37,	Color = 5,	Locate = 4,	set = 0,	Mid = 1206,	Amt = 55,	Gold = 1000000,},
	[38] = {	Id = 38,	Color = 5,	Locate = 4,	set = 0,	Mid = 1207,	Amt = 50,	Gold = 1000000,},
	[39] = {	Id = 39,	Color = 5,	Locate = 4,	set = 0,	Mid = 1208,	Amt = 30,	Gold = 1000000,},
	[40] = {	Id = 40,	Color = 5,	Locate = 4,	set = 0,	Mid = 1209,	Amt = 35,	Gold = 1000000,},
	[41] = {	Id = 41,	Color = 5,	Locate = 5,	set = 1,	Mid = 1203,	Amt = 20,	Gold = 2000000,},
	[42] = {	Id = 42,	Color = 5,	Locate = 5,	set = 1,	Mid = 1206,	Amt = 45,	Gold = 2000000,},
	[43] = {	Id = 43,	Color = 5,	Locate = 5,	set = 1,	Mid = 1207,	Amt = 60,	Gold = 2000000,},
	[44] = {	Id = 44,	Color = 5,	Locate = 5,	set = 1,	Mid = 1208,	Amt = 30,	Gold = 2000000,},
	[45] = {	Id = 45,	Color = 5,	Locate = 5,	set = 1,	Mid = 1209,	Amt = 35,	Gold = 2000000,},
	[46] = {	Id = 46,	Color = 5,	Locate = 5,	set = 0,	Mid = 1203,	Amt = 10,	Gold = 1000000,},
	[47] = {	Id = 47,	Color = 5,	Locate = 5,	set = 0,	Mid = 1206,	Amt = 45,	Gold = 1000000,},
	[48] = {	Id = 48,	Color = 5,	Locate = 5,	set = 0,	Mid = 1207,	Amt = 60,	Gold = 1000000,},
	[49] = {	Id = 49,	Color = 5,	Locate = 5,	set = 0,	Mid = 1208,	Amt = 30,	Gold = 1000000,},
	[50] = {	Id = 50,	Color = 5,	Locate = 5,	set = 0,	Mid = 1209,	Amt = 35,	Gold = 1000000,},
	[51] = {	Id = 51,	Color = 5,	Locate = 6,	set = 1,	Mid = 1205,	Amt = 20,	Gold = 2000000,},
	[52] = {	Id = 52,	Color = 5,	Locate = 6,	set = 1,	Mid = 1206,	Amt = 65,	Gold = 2000000,},
	[53] = {	Id = 53,	Color = 5,	Locate = 6,	set = 1,	Mid = 1207,	Amt = 40,	Gold = 2000000,},
	[54] = {	Id = 54,	Color = 5,	Locate = 6,	set = 1,	Mid = 1208,	Amt = 30,	Gold = 2000000,},
	[55] = {	Id = 55,	Color = 5,	Locate = 6,	set = 1,	Mid = 1209,	Amt = 35,	Gold = 2000000,},
	[56] = {	Id = 56,	Color = 5,	Locate = 6,	set = 0,	Mid = 1205,	Amt = 10,	Gold = 1000000,},
	[57] = {	Id = 57,	Color = 5,	Locate = 6,	set = 0,	Mid = 1206,	Amt = 65,	Gold = 1000000,},
	[58] = {	Id = 58,	Color = 5,	Locate = 6,	set = 0,	Mid = 1207,	Amt = 40,	Gold = 1000000,},
	[59] = {	Id = 59,	Color = 5,	Locate = 6,	set = 0,	Mid = 1208,	Amt = 30,	Gold = 1000000,},
	[60] = {	Id = 60,	Color = 5,	Locate = 6,	set = 0,	Mid = 1209,	Amt = 35,	Gold = 1000000,},
	[61] = {	Id = 61,	Color = 6,	Locate = 1,	set = 1,	Mid = 1200,	Amt = 50,	Gold = 5000000,},
	[62] = {	Id = 62,	Color = 6,	Locate = 1,	set = 1,	Mid = 1206,	Amt = 80,	Gold = 5000000,},
	[63] = {	Id = 63,	Color = 6,	Locate = 1,	set = 1,	Mid = 1207,	Amt = 130,	Gold = 5000000,},
	[64] = {	Id = 64,	Color = 6,	Locate = 1,	set = 1,	Mid = 1208,	Amt = 60,	Gold = 5000000,},
	[65] = {	Id = 65,	Color = 6,	Locate = 1,	set = 1,	Mid = 1209,	Amt = 70,	Gold = 5000000,},
	[66] = {	Id = 66,	Color = 6,	Locate = 1,	set = 0,	Mid = 1200,	Amt = 25,	Gold = 2500000,},
	[67] = {	Id = 67,	Color = 6,	Locate = 1,	set = 0,	Mid = 1206,	Amt = 80,	Gold = 2500000,},
	[68] = {	Id = 68,	Color = 6,	Locate = 1,	set = 0,	Mid = 1207,	Amt = 130,	Gold = 2500000,},
	[69] = {	Id = 69,	Color = 6,	Locate = 1,	set = 0,	Mid = 1208,	Amt = 60,	Gold = 2500000,},
	[70] = {	Id = 70,	Color = 6,	Locate = 1,	set = 0,	Mid = 1209,	Amt = 70,	Gold = 2500000,},
	[71] = {	Id = 71,	Color = 6,	Locate = 2,	set = 1,	Mid = 1202,	Amt = 50,	Gold = 5000000,},
	[72] = {	Id = 72,	Color = 6,	Locate = 2,	set = 1,	Mid = 1206,	Amt = 100,	Gold = 5000000,},
	[73] = {	Id = 73,	Color = 6,	Locate = 2,	set = 1,	Mid = 1207,	Amt = 110,	Gold = 5000000,},
	[74] = {	Id = 74,	Color = 6,	Locate = 2,	set = 1,	Mid = 1208,	Amt = 60,	Gold = 5000000,},
	[75] = {	Id = 75,	Color = 6,	Locate = 2,	set = 1,	Mid = 1209,	Amt = 70,	Gold = 5000000,},
	[76] = {	Id = 76,	Color = 6,	Locate = 2,	set = 0,	Mid = 1202,	Amt = 25,	Gold = 2500000,},
	[77] = {	Id = 77,	Color = 6,	Locate = 2,	set = 0,	Mid = 1206,	Amt = 100,	Gold = 2500000,},
	[78] = {	Id = 78,	Color = 6,	Locate = 2,	set = 0,	Mid = 1207,	Amt = 110,	Gold = 2500000,},
	[79] = {	Id = 79,	Color = 6,	Locate = 2,	set = 0,	Mid = 1208,	Amt = 60,	Gold = 2500000,},
	[80] = {	Id = 80,	Color = 6,	Locate = 2,	set = 0,	Mid = 1209,	Amt = 70,	Gold = 2500000,},
	[81] = {	Id = 81,	Color = 6,	Locate = 3,	set = 1,	Mid = 1204,	Amt = 50,	Gold = 5000000,},
	[82] = {	Id = 82,	Color = 6,	Locate = 3,	set = 1,	Mid = 1206,	Amt = 120,	Gold = 5000000,},
	[83] = {	Id = 83,	Color = 6,	Locate = 3,	set = 1,	Mid = 1207,	Amt = 90,	Gold = 5000000,},
	[84] = {	Id = 84,	Color = 6,	Locate = 3,	set = 1,	Mid = 1208,	Amt = 60,	Gold = 5000000,},
	[85] = {	Id = 85,	Color = 6,	Locate = 3,	set = 1,	Mid = 1209,	Amt = 70,	Gold = 5000000,},
	[86] = {	Id = 86,	Color = 6,	Locate = 3,	set = 0,	Mid = 1204,	Amt = 25,	Gold = 2500000,},
	[87] = {	Id = 87,	Color = 6,	Locate = 3,	set = 0,	Mid = 1206,	Amt = 120,	Gold = 2500000,},
	[88] = {	Id = 88,	Color = 6,	Locate = 3,	set = 0,	Mid = 1207,	Amt = 90,	Gold = 2500000,},
	[89] = {	Id = 89,	Color = 6,	Locate = 3,	set = 0,	Mid = 1208,	Amt = 60,	Gold = 2500000,},
	[90] = {	Id = 90,	Color = 6,	Locate = 3,	set = 0,	Mid = 1209,	Amt = 70,	Gold = 2500000,},
	[91] = {	Id = 91,	Color = 6,	Locate = 4,	set = 1,	Mid = 1201,	Amt = 50,	Gold = 5000000,},
	[92] = {	Id = 92,	Color = 6,	Locate = 4,	set = 1,	Mid = 1206,	Amt = 110,	Gold = 5000000,},
	[93] = {	Id = 93,	Color = 6,	Locate = 4,	set = 1,	Mid = 1207,	Amt = 100,	Gold = 5000000,},
	[94] = {	Id = 94,	Color = 6,	Locate = 4,	set = 1,	Mid = 1208,	Amt = 60,	Gold = 5000000,},
	[95] = {	Id = 95,	Color = 6,	Locate = 4,	set = 1,	Mid = 1209,	Amt = 70,	Gold = 5000000,},
	[96] = {	Id = 96,	Color = 6,	Locate = 4,	set = 0,	Mid = 1201,	Amt = 25,	Gold = 2500000,},
	[97] = {	Id = 97,	Color = 6,	Locate = 4,	set = 0,	Mid = 1206,	Amt = 110,	Gold = 2500000,},
	[98] = {	Id = 98,	Color = 6,	Locate = 4,	set = 0,	Mid = 1207,	Amt = 100,	Gold = 2500000,},
	[99] = {	Id = 99,	Color = 6,	Locate = 4,	set = 0,	Mid = 1208,	Amt = 60,	Gold = 2500000,},
	[100] = {	Id = 100,	Color = 6,	Locate = 4,	set = 0,	Mid = 1209,	Amt = 70,	Gold = 2500000,},
	[101] = {	Id = 101,	Color = 6,	Locate = 5,	set = 1,	Mid = 1203,	Amt = 50,	Gold = 5000000,},
	[102] = {	Id = 102,	Color = 6,	Locate = 5,	set = 1,	Mid = 1206,	Amt = 90,	Gold = 5000000,},
	[103] = {	Id = 103,	Color = 6,	Locate = 5,	set = 1,	Mid = 1207,	Amt = 120,	Gold = 5000000,},
	[104] = {	Id = 104,	Color = 6,	Locate = 5,	set = 1,	Mid = 1208,	Amt = 60,	Gold = 5000000,},
	[105] = {	Id = 105,	Color = 6,	Locate = 5,	set = 1,	Mid = 1209,	Amt = 70,	Gold = 5000000,},
	[106] = {	Id = 106,	Color = 6,	Locate = 5,	set = 0,	Mid = 1203,	Amt = 25,	Gold = 2500000,},
	[107] = {	Id = 107,	Color = 6,	Locate = 5,	set = 0,	Mid = 1206,	Amt = 90,	Gold = 2500000,},
	[108] = {	Id = 108,	Color = 6,	Locate = 5,	set = 0,	Mid = 1207,	Amt = 120,	Gold = 2500000,},
	[109] = {	Id = 109,	Color = 6,	Locate = 5,	set = 0,	Mid = 1208,	Amt = 60,	Gold = 2500000,},
	[110] = {	Id = 110,	Color = 6,	Locate = 5,	set = 0,	Mid = 1209,	Amt = 70,	Gold = 2500000,},
	[111] = {	Id = 111,	Color = 6,	Locate = 6,	set = 1,	Mid = 1205,	Amt = 50,	Gold = 5000000,},
	[112] = {	Id = 112,	Color = 6,	Locate = 6,	set = 1,	Mid = 1206,	Amt = 130,	Gold = 5000000,},
	[113] = {	Id = 113,	Color = 6,	Locate = 6,	set = 1,	Mid = 1207,	Amt = 80,	Gold = 5000000,},
	[114] = {	Id = 114,	Color = 6,	Locate = 6,	set = 1,	Mid = 1208,	Amt = 60,	Gold = 5000000,},
	[115] = {	Id = 115,	Color = 6,	Locate = 6,	set = 1,	Mid = 1209,	Amt = 70,	Gold = 5000000,},
	[116] = {	Id = 116,	Color = 6,	Locate = 6,	set = 0,	Mid = 1205,	Amt = 25,	Gold = 2500000,},
	[117] = {	Id = 117,	Color = 6,	Locate = 6,	set = 0,	Mid = 1206,	Amt = 130,	Gold = 2500000,},
	[118] = {	Id = 118,	Color = 6,	Locate = 6,	set = 0,	Mid = 1207,	Amt = 80,	Gold = 2500000,},
	[119] = {	Id = 119,	Color = 6,	Locate = 6,	set = 0,	Mid = 1208,	Amt = 60,	Gold = 2500000,},
	[120] = {	Id = 120,	Color = 6,	Locate = 6,	set = 0,	Mid = 1209,	Amt = 70,	Gold = 2500000,},
	[121] = {	Id = 121,	Color = 7,	Locate = 1,	set = 1,	Mid = 1200,	Amt = 75,	Gold = 15000000,},
	[122] = {	Id = 122,	Color = 7,	Locate = 1,	set = 1,	Mid = 1206,	Amt = 120,	Gold = 15000000,},
	[123] = {	Id = 123,	Color = 7,	Locate = 1,	set = 1,	Mid = 1207,	Amt = 195,	Gold = 15000000,},
	[124] = {	Id = 124,	Color = 7,	Locate = 1,	set = 1,	Mid = 1208,	Amt = 90,	Gold = 15000000,},
	[125] = {	Id = 125,	Color = 7,	Locate = 1,	set = 1,	Mid = 1209,	Amt = 105,	Gold = 15000000,},
	[126] = {	Id = 126,	Color = 7,	Locate = 1,	set = 0,	Mid = 1200,	Amt = 37,	Gold = 7500000,},
	[127] = {	Id = 127,	Color = 7,	Locate = 1,	set = 0,	Mid = 1206,	Amt = 120,	Gold = 7500000,},
	[128] = {	Id = 128,	Color = 7,	Locate = 1,	set = 0,	Mid = 1207,	Amt = 195,	Gold = 7500000,},
	[129] = {	Id = 129,	Color = 7,	Locate = 1,	set = 0,	Mid = 1208,	Amt = 90,	Gold = 7500000,},
	[130] = {	Id = 130,	Color = 7,	Locate = 1,	set = 0,	Mid = 1209,	Amt = 105,	Gold = 7500000,},
	[131] = {	Id = 131,	Color = 7,	Locate = 2,	set = 1,	Mid = 1202,	Amt = 75,	Gold = 15000000,},
	[132] = {	Id = 132,	Color = 7,	Locate = 2,	set = 1,	Mid = 1206,	Amt = 150,	Gold = 15000000,},
	[133] = {	Id = 133,	Color = 7,	Locate = 2,	set = 1,	Mid = 1207,	Amt = 165,	Gold = 15000000,},
	[134] = {	Id = 134,	Color = 7,	Locate = 2,	set = 1,	Mid = 1208,	Amt = 90,	Gold = 15000000,},
	[135] = {	Id = 135,	Color = 7,	Locate = 2,	set = 1,	Mid = 1209,	Amt = 105,	Gold = 15000000,},
	[136] = {	Id = 136,	Color = 7,	Locate = 2,	set = 0,	Mid = 1202,	Amt = 37,	Gold = 7500000,},
	[137] = {	Id = 137,	Color = 7,	Locate = 2,	set = 0,	Mid = 1206,	Amt = 150,	Gold = 7500000,},
	[138] = {	Id = 138,	Color = 7,	Locate = 2,	set = 0,	Mid = 1207,	Amt = 165,	Gold = 7500000,},
	[139] = {	Id = 139,	Color = 7,	Locate = 2,	set = 0,	Mid = 1208,	Amt = 90,	Gold = 7500000,},
	[140] = {	Id = 140,	Color = 7,	Locate = 2,	set = 0,	Mid = 1209,	Amt = 105,	Gold = 7500000,},
	[141] = {	Id = 141,	Color = 7,	Locate = 3,	set = 1,	Mid = 1204,	Amt = 75,	Gold = 15000000,},
	[142] = {	Id = 142,	Color = 7,	Locate = 3,	set = 1,	Mid = 1206,	Amt = 180,	Gold = 15000000,},
	[143] = {	Id = 143,	Color = 7,	Locate = 3,	set = 1,	Mid = 1207,	Amt = 135,	Gold = 15000000,},
	[144] = {	Id = 144,	Color = 7,	Locate = 3,	set = 1,	Mid = 1208,	Amt = 90,	Gold = 15000000,},
	[145] = {	Id = 145,	Color = 7,	Locate = 3,	set = 1,	Mid = 1209,	Amt = 105,	Gold = 15000000,},
	[146] = {	Id = 146,	Color = 7,	Locate = 3,	set = 0,	Mid = 1204,	Amt = 37,	Gold = 7500000,},
	[147] = {	Id = 147,	Color = 7,	Locate = 3,	set = 0,	Mid = 1206,	Amt = 180,	Gold = 7500000,},
	[148] = {	Id = 148,	Color = 7,	Locate = 3,	set = 0,	Mid = 1207,	Amt = 135,	Gold = 7500000,},
	[149] = {	Id = 149,	Color = 7,	Locate = 3,	set = 0,	Mid = 1208,	Amt = 90,	Gold = 7500000,},
	[150] = {	Id = 150,	Color = 7,	Locate = 3,	set = 0,	Mid = 1209,	Amt = 105,	Gold = 7500000,},
	[151] = {	Id = 151,	Color = 7,	Locate = 4,	set = 1,	Mid = 1201,	Amt = 75,	Gold = 15000000,},
	[152] = {	Id = 152,	Color = 7,	Locate = 4,	set = 1,	Mid = 1206,	Amt = 165,	Gold = 15000000,},
	[153] = {	Id = 153,	Color = 7,	Locate = 4,	set = 1,	Mid = 1207,	Amt = 150,	Gold = 15000000,},
	[154] = {	Id = 154,	Color = 7,	Locate = 4,	set = 1,	Mid = 1208,	Amt = 90,	Gold = 15000000,},
	[155] = {	Id = 155,	Color = 7,	Locate = 4,	set = 1,	Mid = 1209,	Amt = 105,	Gold = 15000000,},
	[156] = {	Id = 156,	Color = 7,	Locate = 4,	set = 0,	Mid = 1201,	Amt = 37,	Gold = 7500000,},
	[157] = {	Id = 157,	Color = 7,	Locate = 4,	set = 0,	Mid = 1206,	Amt = 165,	Gold = 7500000,},
	[158] = {	Id = 158,	Color = 7,	Locate = 4,	set = 0,	Mid = 1207,	Amt = 150,	Gold = 7500000,},
	[159] = {	Id = 159,	Color = 7,	Locate = 4,	set = 0,	Mid = 1208,	Amt = 90,	Gold = 7500000,},
	[160] = {	Id = 160,	Color = 7,	Locate = 4,	set = 0,	Mid = 1209,	Amt = 105,	Gold = 7500000,},
	[161] = {	Id = 161,	Color = 7,	Locate = 5,	set = 1,	Mid = 1203,	Amt = 75,	Gold = 15000000,},
	[162] = {	Id = 162,	Color = 7,	Locate = 5,	set = 1,	Mid = 1206,	Amt = 135,	Gold = 15000000,},
	[163] = {	Id = 163,	Color = 7,	Locate = 5,	set = 1,	Mid = 1207,	Amt = 180,	Gold = 15000000,},
	[164] = {	Id = 164,	Color = 7,	Locate = 5,	set = 1,	Mid = 1208,	Amt = 90,	Gold = 15000000,},
	[165] = {	Id = 165,	Color = 7,	Locate = 5,	set = 1,	Mid = 1209,	Amt = 105,	Gold = 15000000,},
	[166] = {	Id = 166,	Color = 7,	Locate = 5,	set = 0,	Mid = 1203,	Amt = 37,	Gold = 7500000,},
	[167] = {	Id = 167,	Color = 7,	Locate = 5,	set = 0,	Mid = 1206,	Amt = 135,	Gold = 7500000,},
	[168] = {	Id = 168,	Color = 7,	Locate = 5,	set = 0,	Mid = 1207,	Amt = 180,	Gold = 7500000,},
	[169] = {	Id = 169,	Color = 7,	Locate = 5,	set = 0,	Mid = 1208,	Amt = 90,	Gold = 7500000,},
	[170] = {	Id = 170,	Color = 7,	Locate = 5,	set = 0,	Mid = 1209,	Amt = 105,	Gold = 7500000,},
	[171] = {	Id = 171,	Color = 7,	Locate = 6,	set = 1,	Mid = 1205,	Amt = 75,	Gold = 15000000,},
	[172] = {	Id = 172,	Color = 7,	Locate = 6,	set = 1,	Mid = 1206,	Amt = 195,	Gold = 15000000,},
	[173] = {	Id = 173,	Color = 7,	Locate = 6,	set = 1,	Mid = 1207,	Amt = 120,	Gold = 15000000,},
	[174] = {	Id = 174,	Color = 7,	Locate = 6,	set = 1,	Mid = 1208,	Amt = 90,	Gold = 15000000,},
	[175] = {	Id = 175,	Color = 7,	Locate = 6,	set = 1,	Mid = 1209,	Amt = 105,	Gold = 15000000,},
	[176] = {	Id = 176,	Color = 7,	Locate = 6,	set = 0,	Mid = 1205,	Amt = 37,	Gold = 7500000,},
	[177] = {	Id = 177,	Color = 7,	Locate = 6,	set = 0,	Mid = 1206,	Amt = 195,	Gold = 7500000,},
	[178] = {	Id = 178,	Color = 7,	Locate = 6,	set = 0,	Mid = 1207,	Amt = 120,	Gold = 7500000,},
	[179] = {	Id = 179,	Color = 7,	Locate = 6,	set = 0,	Mid = 1208,	Amt = 90,	Gold = 7500000,},
	[180] = {	Id = 180,	Color = 7,	Locate = 6,	set = 0,	Mid = 1209,	Amt = 105,	Gold = 7500000,},
}

return _table