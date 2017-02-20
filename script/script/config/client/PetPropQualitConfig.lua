--[[
	Id = Id
Prop = 属性
Quality = 品质名称
Mid = 所需树果
Amt = nil
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
	[1] = {	Id = 1,	Prop = 2,	Quality = 1,	Mid = 201,	Amt = 6,},
	[2] = {	Id = 2,	Prop = 2,	Quality = 1,	Mid = 401,	Amt = 6,},
	[3] = {	Id = 4,	Prop = 2,	Quality = 2,	Mid = 202,	Amt = 10,},
	[4] = {	Id = 5,	Prop = 2,	Quality = 2,	Mid = 401,	Amt = 12,},
	[5] = {	Id = 6,	Prop = 2,	Quality = 2,	Mid = 402,	Amt = 8,},
	[6] = {	Id = 7,	Prop = 2,	Quality = 3,	Mid = 202,	Amt = 6,},
	[7] = {	Id = 8,	Prop = 2,	Quality = 3,	Mid = 203,	Amt = 10,},
	[8] = {	Id = 9,	Prop = 2,	Quality = 3,	Mid = 402,	Amt = 7,},
	[9] = {	Id = 10,	Prop = 2,	Quality = 3,	Mid = 403,	Amt = 13,},
	[10] = {	Id = 11,	Prop = 2,	Quality = 4,	Mid = 203,	Amt = 4,},
	[11] = {	Id = 12,	Prop = 2,	Quality = 4,	Mid = 204,	Amt = 6,},
	[12] = {	Id = 13,	Prop = 2,	Quality = 4,	Mid = 205,	Amt = 12,},
	[13] = {	Id = 14,	Prop = 2,	Quality = 4,	Mid = 402,	Amt = 4,},
	[14] = {	Id = 15,	Prop = 2,	Quality = 4,	Mid = 403,	Amt = 6,},
	[15] = {	Id = 16,	Prop = 2,	Quality = 4,	Mid = 404,	Amt = 12,},
	[16] = {	Id = 17,	Prop = 2,	Quality = 5,	Mid = 204,	Amt = 8,},
	[17] = {	Id = 18,	Prop = 2,	Quality = 5,	Mid = 205,	Amt = 10,},
	[18] = {	Id = 19,	Prop = 2,	Quality = 5,	Mid = 206,	Amt = 12,},
	[19] = {	Id = 20,	Prop = 2,	Quality = 5,	Mid = 403,	Amt = 10,},
	[20] = {	Id = 21,	Prop = 2,	Quality = 5,	Mid = 404,	Amt = 12,},
	[21] = {	Id = 22,	Prop = 2,	Quality = 5,	Mid = 405,	Amt = 18,},
	[22] = {	Id = 23,	Prop = 2,	Quality = 6,	Mid = 206,	Amt = 10,},
	[23] = {	Id = 24,	Prop = 2,	Quality = 6,	Mid = 207,	Amt = 12,},
	[24] = {	Id = 25,	Prop = 2,	Quality = 6,	Mid = 208,	Amt = 20,},
	[25] = {	Id = 26,	Prop = 2,	Quality = 6,	Mid = 404,	Amt = 12,},
	[26] = {	Id = 27,	Prop = 2,	Quality = 6,	Mid = 405,	Amt = 18,},
	[27] = {	Id = 28,	Prop = 2,	Quality = 6,	Mid = 406,	Amt = 20,},
	[28] = {	Id = 29,	Prop = 2,	Quality = 7,	Mid = 207,	Amt = 30,},
	[29] = {	Id = 30,	Prop = 2,	Quality = 7,	Mid = 208,	Amt = 20,},
	[30] = {	Id = 31,	Prop = 2,	Quality = 7,	Mid = 209,	Amt = 16,},
	[31] = {	Id = 32,	Prop = 2,	Quality = 7,	Mid = 405,	Amt = 24,},
	[32] = {	Id = 33,	Prop = 2,	Quality = 7,	Mid = 406,	Amt = 25,},
	[33] = {	Id = 34,	Prop = 2,	Quality = 7,	Mid = 407,	Amt = 24,},
	[34] = {	Id = 35,	Prop = 2,	Quality = 8,	Mid = 210,	Amt = 50,},
	[35] = {	Id = 36,	Prop = 2,	Quality = 8,	Mid = 211,	Amt = 40,},
	[36] = {	Id = 37,	Prop = 2,	Quality = 8,	Mid = 212,	Amt = 40,},
	[37] = {	Id = 38,	Prop = 2,	Quality = 8,	Mid = 213,	Amt = 40,},
	[38] = {	Id = 39,	Prop = 2,	Quality = 8,	Mid = 408,	Amt = 50,},
	[39] = {	Id = 40,	Prop = 2,	Quality = 8,	Mid = 409,	Amt = 50,},
	[40] = {	Id = 41,	Prop = 3,	Quality = 1,	Mid = 201,	Amt = 6,},
	[41] = {	Id = 42,	Prop = 3,	Quality = 1,	Mid = 601,	Amt = 6,},
	[42] = {	Id = 44,	Prop = 3,	Quality = 2,	Mid = 202,	Amt = 10,},
	[43] = {	Id = 45,	Prop = 3,	Quality = 2,	Mid = 601,	Amt = 12,},
	[44] = {	Id = 46,	Prop = 3,	Quality = 2,	Mid = 602,	Amt = 8,},
	[45] = {	Id = 47,	Prop = 3,	Quality = 3,	Mid = 202,	Amt = 6,},
	[46] = {	Id = 48,	Prop = 3,	Quality = 3,	Mid = 203,	Amt = 10,},
	[47] = {	Id = 49,	Prop = 3,	Quality = 3,	Mid = 602,	Amt = 7,},
	[48] = {	Id = 50,	Prop = 3,	Quality = 3,	Mid = 603,	Amt = 13,},
	[49] = {	Id = 51,	Prop = 3,	Quality = 4,	Mid = 203,	Amt = 4,},
	[50] = {	Id = 52,	Prop = 3,	Quality = 4,	Mid = 204,	Amt = 6,},
	[51] = {	Id = 53,	Prop = 3,	Quality = 4,	Mid = 205,	Amt = 12,},
	[52] = {	Id = 54,	Prop = 3,	Quality = 4,	Mid = 602,	Amt = 4,},
	[53] = {	Id = 55,	Prop = 3,	Quality = 4,	Mid = 603,	Amt = 6,},
	[54] = {	Id = 56,	Prop = 3,	Quality = 4,	Mid = 604,	Amt = 12,},
	[55] = {	Id = 57,	Prop = 3,	Quality = 5,	Mid = 204,	Amt = 8,},
	[56] = {	Id = 58,	Prop = 3,	Quality = 5,	Mid = 205,	Amt = 10,},
	[57] = {	Id = 59,	Prop = 3,	Quality = 5,	Mid = 206,	Amt = 12,},
	[58] = {	Id = 60,	Prop = 3,	Quality = 5,	Mid = 603,	Amt = 10,},
	[59] = {	Id = 61,	Prop = 3,	Quality = 5,	Mid = 604,	Amt = 12,},
	[60] = {	Id = 62,	Prop = 3,	Quality = 5,	Mid = 605,	Amt = 18,},
	[61] = {	Id = 63,	Prop = 3,	Quality = 6,	Mid = 206,	Amt = 10,},
	[62] = {	Id = 64,	Prop = 3,	Quality = 6,	Mid = 207,	Amt = 12,},
	[63] = {	Id = 65,	Prop = 3,	Quality = 6,	Mid = 208,	Amt = 20,},
	[64] = {	Id = 66,	Prop = 3,	Quality = 6,	Mid = 604,	Amt = 12,},
	[65] = {	Id = 67,	Prop = 3,	Quality = 6,	Mid = 605,	Amt = 18,},
	[66] = {	Id = 68,	Prop = 3,	Quality = 6,	Mid = 606,	Amt = 20,},
	[67] = {	Id = 69,	Prop = 3,	Quality = 7,	Mid = 207,	Amt = 30,},
	[68] = {	Id = 70,	Prop = 3,	Quality = 7,	Mid = 208,	Amt = 20,},
	[69] = {	Id = 71,	Prop = 3,	Quality = 7,	Mid = 209,	Amt = 16,},
	[70] = {	Id = 72,	Prop = 3,	Quality = 7,	Mid = 605,	Amt = 24,},
	[71] = {	Id = 73,	Prop = 3,	Quality = 7,	Mid = 606,	Amt = 25,},
	[72] = {	Id = 74,	Prop = 3,	Quality = 7,	Mid = 607,	Amt = 24,},
	[73] = {	Id = 75,	Prop = 3,	Quality = 8,	Mid = 210,	Amt = 50,},
	[74] = {	Id = 76,	Prop = 3,	Quality = 8,	Mid = 211,	Amt = 40,},
	[75] = {	Id = 77,	Prop = 3,	Quality = 8,	Mid = 212,	Amt = 40,},
	[76] = {	Id = 78,	Prop = 3,	Quality = 8,	Mid = 213,	Amt = 40,},
	[77] = {	Id = 79,	Prop = 3,	Quality = 8,	Mid = 608,	Amt = 50,},
	[78] = {	Id = 80,	Prop = 3,	Quality = 8,	Mid = 609,	Amt = 50,},
	[79] = {	Id = 81,	Prop = 6,	Quality = 1,	Mid = 201,	Amt = 6,},
	[80] = {	Id = 82,	Prop = 6,	Quality = 1,	Mid = 301,	Amt = 6,},
	[81] = {	Id = 84,	Prop = 6,	Quality = 2,	Mid = 202,	Amt = 10,},
	[82] = {	Id = 85,	Prop = 6,	Quality = 2,	Mid = 301,	Amt = 12,},
	[83] = {	Id = 86,	Prop = 6,	Quality = 2,	Mid = 302,	Amt = 8,},
	[84] = {	Id = 87,	Prop = 6,	Quality = 3,	Mid = 202,	Amt = 6,},
	[85] = {	Id = 88,	Prop = 6,	Quality = 3,	Mid = 203,	Amt = 10,},
	[86] = {	Id = 89,	Prop = 6,	Quality = 3,	Mid = 302,	Amt = 7,},
	[87] = {	Id = 90,	Prop = 6,	Quality = 3,	Mid = 303,	Amt = 13,},
	[88] = {	Id = 91,	Prop = 6,	Quality = 4,	Mid = 203,	Amt = 4,},
	[89] = {	Id = 92,	Prop = 6,	Quality = 4,	Mid = 204,	Amt = 6,},
	[90] = {	Id = 93,	Prop = 6,	Quality = 4,	Mid = 205,	Amt = 12,},
	[91] = {	Id = 94,	Prop = 6,	Quality = 4,	Mid = 302,	Amt = 4,},
	[92] = {	Id = 95,	Prop = 6,	Quality = 4,	Mid = 303,	Amt = 6,},
	[93] = {	Id = 96,	Prop = 6,	Quality = 4,	Mid = 304,	Amt = 12,},
	[94] = {	Id = 97,	Prop = 6,	Quality = 5,	Mid = 204,	Amt = 8,},
	[95] = {	Id = 98,	Prop = 6,	Quality = 5,	Mid = 205,	Amt = 10,},
	[96] = {	Id = 99,	Prop = 6,	Quality = 5,	Mid = 206,	Amt = 12,},
	[97] = {	Id = 100,	Prop = 6,	Quality = 5,	Mid = 303,	Amt = 10,},
	[98] = {	Id = 101,	Prop = 6,	Quality = 5,	Mid = 304,	Amt = 12,},
	[99] = {	Id = 102,	Prop = 6,	Quality = 5,	Mid = 305,	Amt = 18,},
	[100] = {	Id = 103,	Prop = 6,	Quality = 6,	Mid = 206,	Amt = 10,},
	[101] = {	Id = 104,	Prop = 6,	Quality = 6,	Mid = 207,	Amt = 12,},
	[102] = {	Id = 105,	Prop = 6,	Quality = 6,	Mid = 208,	Amt = 20,},
	[103] = {	Id = 106,	Prop = 6,	Quality = 6,	Mid = 304,	Amt = 12,},
	[104] = {	Id = 107,	Prop = 6,	Quality = 6,	Mid = 305,	Amt = 18,},
	[105] = {	Id = 108,	Prop = 6,	Quality = 6,	Mid = 306,	Amt = 20,},
	[106] = {	Id = 109,	Prop = 6,	Quality = 7,	Mid = 207,	Amt = 30,},
	[107] = {	Id = 110,	Prop = 6,	Quality = 7,	Mid = 208,	Amt = 20,},
	[108] = {	Id = 111,	Prop = 6,	Quality = 7,	Mid = 209,	Amt = 16,},
	[109] = {	Id = 112,	Prop = 6,	Quality = 7,	Mid = 305,	Amt = 24,},
	[110] = {	Id = 113,	Prop = 6,	Quality = 7,	Mid = 306,	Amt = 25,},
	[111] = {	Id = 114,	Prop = 6,	Quality = 7,	Mid = 307,	Amt = 24,},
	[112] = {	Id = 115,	Prop = 6,	Quality = 8,	Mid = 210,	Amt = 50,},
	[113] = {	Id = 116,	Prop = 6,	Quality = 8,	Mid = 211,	Amt = 40,},
	[114] = {	Id = 117,	Prop = 6,	Quality = 8,	Mid = 212,	Amt = 40,},
	[115] = {	Id = 118,	Prop = 6,	Quality = 8,	Mid = 213,	Amt = 40,},
	[116] = {	Id = 119,	Prop = 6,	Quality = 8,	Mid = 308,	Amt = 50,},
	[117] = {	Id = 120,	Prop = 6,	Quality = 8,	Mid = 309,	Amt = 50,},
	[118] = {	Id = 121,	Prop = 7,	Quality = 1,	Mid = 201,	Amt = 6,},
	[119] = {	Id = 122,	Prop = 7,	Quality = 1,	Mid = 501,	Amt = 6,},
	[120] = {	Id = 124,	Prop = 7,	Quality = 2,	Mid = 202,	Amt = 10,},
	[121] = {	Id = 125,	Prop = 7,	Quality = 2,	Mid = 501,	Amt = 12,},
	[122] = {	Id = 126,	Prop = 7,	Quality = 2,	Mid = 502,	Amt = 8,},
	[123] = {	Id = 127,	Prop = 7,	Quality = 3,	Mid = 202,	Amt = 6,},
	[124] = {	Id = 128,	Prop = 7,	Quality = 3,	Mid = 203,	Amt = 10,},
	[125] = {	Id = 129,	Prop = 7,	Quality = 3,	Mid = 502,	Amt = 7,},
	[126] = {	Id = 130,	Prop = 7,	Quality = 3,	Mid = 503,	Amt = 13,},
	[127] = {	Id = 131,	Prop = 7,	Quality = 4,	Mid = 203,	Amt = 4,},
	[128] = {	Id = 132,	Prop = 7,	Quality = 4,	Mid = 204,	Amt = 6,},
	[129] = {	Id = 133,	Prop = 7,	Quality = 4,	Mid = 205,	Amt = 12,},
	[130] = {	Id = 134,	Prop = 7,	Quality = 4,	Mid = 502,	Amt = 4,},
	[131] = {	Id = 135,	Prop = 7,	Quality = 4,	Mid = 503,	Amt = 6,},
	[132] = {	Id = 136,	Prop = 7,	Quality = 4,	Mid = 504,	Amt = 12,},
	[133] = {	Id = 137,	Prop = 7,	Quality = 5,	Mid = 204,	Amt = 8,},
	[134] = {	Id = 138,	Prop = 7,	Quality = 5,	Mid = 205,	Amt = 10,},
	[135] = {	Id = 139,	Prop = 7,	Quality = 5,	Mid = 206,	Amt = 12,},
	[136] = {	Id = 140,	Prop = 7,	Quality = 5,	Mid = 503,	Amt = 10,},
	[137] = {	Id = 141,	Prop = 7,	Quality = 5,	Mid = 504,	Amt = 12,},
	[138] = {	Id = 142,	Prop = 7,	Quality = 5,	Mid = 505,	Amt = 18,},
	[139] = {	Id = 143,	Prop = 7,	Quality = 6,	Mid = 206,	Amt = 10,},
	[140] = {	Id = 144,	Prop = 7,	Quality = 6,	Mid = 207,	Amt = 12,},
	[141] = {	Id = 145,	Prop = 7,	Quality = 6,	Mid = 208,	Amt = 20,},
	[142] = {	Id = 146,	Prop = 7,	Quality = 6,	Mid = 504,	Amt = 12,},
	[143] = {	Id = 147,	Prop = 7,	Quality = 6,	Mid = 505,	Amt = 18,},
	[144] = {	Id = 148,	Prop = 7,	Quality = 6,	Mid = 506,	Amt = 20,},
	[145] = {	Id = 149,	Prop = 7,	Quality = 7,	Mid = 207,	Amt = 30,},
	[146] = {	Id = 150,	Prop = 7,	Quality = 7,	Mid = 208,	Amt = 20,},
	[147] = {	Id = 151,	Prop = 7,	Quality = 7,	Mid = 209,	Amt = 16,},
	[148] = {	Id = 152,	Prop = 7,	Quality = 7,	Mid = 505,	Amt = 24,},
	[149] = {	Id = 153,	Prop = 7,	Quality = 7,	Mid = 506,	Amt = 25,},
	[150] = {	Id = 154,	Prop = 7,	Quality = 7,	Mid = 507,	Amt = 24,},
	[151] = {	Id = 155,	Prop = 7,	Quality = 8,	Mid = 210,	Amt = 50,},
	[152] = {	Id = 156,	Prop = 7,	Quality = 8,	Mid = 211,	Amt = 40,},
	[153] = {	Id = 157,	Prop = 7,	Quality = 8,	Mid = 212,	Amt = 40,},
	[154] = {	Id = 158,	Prop = 7,	Quality = 8,	Mid = 213,	Amt = 40,},
	[155] = {	Id = 159,	Prop = 7,	Quality = 8,	Mid = 508,	Amt = 50,},
	[156] = {	Id = 160,	Prop = 7,	Quality = 8,	Mid = 509,	Amt = 50,},
	[157] = {	Id = 161,	Prop = 8,	Quality = 1,	Mid = 201,	Amt = 6,},
	[158] = {	Id = 162,	Prop = 8,	Quality = 1,	Mid = 701,	Amt = 6,},
	[159] = {	Id = 164,	Prop = 8,	Quality = 2,	Mid = 202,	Amt = 10,},
	[160] = {	Id = 165,	Prop = 8,	Quality = 2,	Mid = 701,	Amt = 12,},
	[161] = {	Id = 166,	Prop = 8,	Quality = 2,	Mid = 702,	Amt = 8,},
	[162] = {	Id = 167,	Prop = 8,	Quality = 3,	Mid = 202,	Amt = 6,},
	[163] = {	Id = 168,	Prop = 8,	Quality = 3,	Mid = 203,	Amt = 10,},
	[164] = {	Id = 169,	Prop = 8,	Quality = 3,	Mid = 702,	Amt = 7,},
	[165] = {	Id = 170,	Prop = 8,	Quality = 3,	Mid = 703,	Amt = 13,},
	[166] = {	Id = 171,	Prop = 8,	Quality = 4,	Mid = 203,	Amt = 4,},
	[167] = {	Id = 172,	Prop = 8,	Quality = 4,	Mid = 204,	Amt = 6,},
	[168] = {	Id = 173,	Prop = 8,	Quality = 4,	Mid = 205,	Amt = 12,},
	[169] = {	Id = 174,	Prop = 8,	Quality = 4,	Mid = 702,	Amt = 4,},
	[170] = {	Id = 175,	Prop = 8,	Quality = 4,	Mid = 703,	Amt = 6,},
	[171] = {	Id = 176,	Prop = 8,	Quality = 4,	Mid = 704,	Amt = 12,},
	[172] = {	Id = 177,	Prop = 8,	Quality = 5,	Mid = 204,	Amt = 8,},
	[173] = {	Id = 178,	Prop = 8,	Quality = 5,	Mid = 205,	Amt = 10,},
	[174] = {	Id = 179,	Prop = 8,	Quality = 5,	Mid = 206,	Amt = 12,},
	[175] = {	Id = 180,	Prop = 8,	Quality = 5,	Mid = 703,	Amt = 10,},
	[176] = {	Id = 181,	Prop = 8,	Quality = 5,	Mid = 704,	Amt = 12,},
	[177] = {	Id = 182,	Prop = 8,	Quality = 5,	Mid = 705,	Amt = 18,},
	[178] = {	Id = 183,	Prop = 8,	Quality = 6,	Mid = 206,	Amt = 10,},
	[179] = {	Id = 184,	Prop = 8,	Quality = 6,	Mid = 207,	Amt = 12,},
	[180] = {	Id = 185,	Prop = 8,	Quality = 6,	Mid = 208,	Amt = 20,},
	[181] = {	Id = 186,	Prop = 8,	Quality = 6,	Mid = 704,	Amt = 12,},
	[182] = {	Id = 187,	Prop = 8,	Quality = 6,	Mid = 705,	Amt = 18,},
	[183] = {	Id = 188,	Prop = 8,	Quality = 6,	Mid = 706,	Amt = 20,},
	[184] = {	Id = 189,	Prop = 8,	Quality = 7,	Mid = 207,	Amt = 30,},
	[185] = {	Id = 190,	Prop = 8,	Quality = 7,	Mid = 208,	Amt = 20,},
	[186] = {	Id = 191,	Prop = 8,	Quality = 7,	Mid = 209,	Amt = 16,},
	[187] = {	Id = 192,	Prop = 8,	Quality = 7,	Mid = 705,	Amt = 24,},
	[188] = {	Id = 193,	Prop = 8,	Quality = 7,	Mid = 706,	Amt = 25,},
	[189] = {	Id = 194,	Prop = 8,	Quality = 7,	Mid = 707,	Amt = 24,},
	[190] = {	Id = 195,	Prop = 8,	Quality = 8,	Mid = 210,	Amt = 50,},
	[191] = {	Id = 196,	Prop = 8,	Quality = 8,	Mid = 211,	Amt = 40,},
	[192] = {	Id = 197,	Prop = 8,	Quality = 8,	Mid = 212,	Amt = 40,},
	[193] = {	Id = 198,	Prop = 8,	Quality = 8,	Mid = 213,	Amt = 40,},
	[194] = {	Id = 199,	Prop = 8,	Quality = 8,	Mid = 708,	Amt = 50,},
	[195] = {	Id = 200,	Prop = 8,	Quality = 8,	Mid = 709,	Amt = 50,},
	[196] = {	Id = 201,	Prop = 2,	Quality = 9,	Mid = 214,	Amt = 80,},
	[197] = {	Id = 202,	Prop = 2,	Quality = 9,	Mid = 215,	Amt = 60,},
	[198] = {	Id = 203,	Prop = 2,	Quality = 9,	Mid = 216,	Amt = 60,},
	[199] = {	Id = 204,	Prop = 2,	Quality = 9,	Mid = 410,	Amt = 80,},
	[200] = {	Id = 205,	Prop = 2,	Quality = 9,	Mid = 411,	Amt = 70,},
	[201] = {	Id = 206,	Prop = 2,	Quality = 9,	Mid = 412,	Amt = 60,},
	[202] = {	Id = 207,	Prop = 2,	Quality = 10,	Mid = 216,	Amt = 120,},
	[203] = {	Id = 208,	Prop = 2,	Quality = 10,	Mid = 217,	Amt = 90,},
	[204] = {	Id = 209,	Prop = 2,	Quality = 10,	Mid = 218,	Amt = 90,},
	[205] = {	Id = 210,	Prop = 2,	Quality = 10,	Mid = 412,	Amt = 110,},
	[206] = {	Id = 211,	Prop = 2,	Quality = 10,	Mid = 413,	Amt = 100,},
	[207] = {	Id = 212,	Prop = 2,	Quality = 10,	Mid = 414,	Amt = 100,},
	[208] = {	Id = 213,	Prop = 3,	Quality = 9,	Mid = 214,	Amt = 80,},
	[209] = {	Id = 214,	Prop = 3,	Quality = 9,	Mid = 215,	Amt = 60,},
	[210] = {	Id = 215,	Prop = 3,	Quality = 9,	Mid = 216,	Amt = 60,},
	[211] = {	Id = 216,	Prop = 3,	Quality = 9,	Mid = 610,	Amt = 80,},
	[212] = {	Id = 217,	Prop = 3,	Quality = 9,	Mid = 611,	Amt = 70,},
	[213] = {	Id = 218,	Prop = 3,	Quality = 9,	Mid = 612,	Amt = 60,},
	[214] = {	Id = 219,	Prop = 3,	Quality = 10,	Mid = 216,	Amt = 120,},
	[215] = {	Id = 220,	Prop = 3,	Quality = 10,	Mid = 217,	Amt = 90,},
	[216] = {	Id = 221,	Prop = 3,	Quality = 10,	Mid = 218,	Amt = 90,},
	[217] = {	Id = 222,	Prop = 3,	Quality = 10,	Mid = 612,	Amt = 110,},
	[218] = {	Id = 223,	Prop = 3,	Quality = 10,	Mid = 613,	Amt = 100,},
	[219] = {	Id = 224,	Prop = 3,	Quality = 10,	Mid = 614,	Amt = 100,},
	[220] = {	Id = 225,	Prop = 6,	Quality = 9,	Mid = 214,	Amt = 80,},
	[221] = {	Id = 226,	Prop = 6,	Quality = 9,	Mid = 215,	Amt = 60,},
	[222] = {	Id = 227,	Prop = 6,	Quality = 9,	Mid = 216,	Amt = 60,},
	[223] = {	Id = 228,	Prop = 6,	Quality = 9,	Mid = 310,	Amt = 80,},
	[224] = {	Id = 229,	Prop = 6,	Quality = 9,	Mid = 311,	Amt = 70,},
	[225] = {	Id = 230,	Prop = 6,	Quality = 9,	Mid = 312,	Amt = 60,},
	[226] = {	Id = 231,	Prop = 6,	Quality = 10,	Mid = 216,	Amt = 120,},
	[227] = {	Id = 232,	Prop = 6,	Quality = 10,	Mid = 217,	Amt = 90,},
	[228] = {	Id = 233,	Prop = 6,	Quality = 10,	Mid = 218,	Amt = 90,},
	[229] = {	Id = 234,	Prop = 6,	Quality = 10,	Mid = 312,	Amt = 110,},
	[230] = {	Id = 235,	Prop = 6,	Quality = 10,	Mid = 313,	Amt = 100,},
	[231] = {	Id = 236,	Prop = 6,	Quality = 10,	Mid = 314,	Amt = 100,},
	[232] = {	Id = 237,	Prop = 7,	Quality = 9,	Mid = 214,	Amt = 80,},
	[233] = {	Id = 238,	Prop = 7,	Quality = 9,	Mid = 215,	Amt = 60,},
	[234] = {	Id = 239,	Prop = 7,	Quality = 9,	Mid = 216,	Amt = 60,},
	[235] = {	Id = 240,	Prop = 7,	Quality = 9,	Mid = 510,	Amt = 80,},
	[236] = {	Id = 241,	Prop = 7,	Quality = 9,	Mid = 511,	Amt = 70,},
	[237] = {	Id = 242,	Prop = 7,	Quality = 9,	Mid = 512,	Amt = 60,},
	[238] = {	Id = 243,	Prop = 7,	Quality = 10,	Mid = 216,	Amt = 120,},
	[239] = {	Id = 244,	Prop = 7,	Quality = 10,	Mid = 217,	Amt = 90,},
	[240] = {	Id = 245,	Prop = 7,	Quality = 10,	Mid = 218,	Amt = 90,},
	[241] = {	Id = 246,	Prop = 7,	Quality = 10,	Mid = 512,	Amt = 110,},
	[242] = {	Id = 247,	Prop = 7,	Quality = 10,	Mid = 513,	Amt = 100,},
	[243] = {	Id = 248,	Prop = 7,	Quality = 10,	Mid = 514,	Amt = 100,},
	[244] = {	Id = 249,	Prop = 8,	Quality = 9,	Mid = 214,	Amt = 80,},
	[245] = {	Id = 250,	Prop = 8,	Quality = 9,	Mid = 215,	Amt = 60,},
	[246] = {	Id = 251,	Prop = 8,	Quality = 9,	Mid = 216,	Amt = 60,},
	[247] = {	Id = 252,	Prop = 8,	Quality = 9,	Mid = 710,	Amt = 80,},
	[248] = {	Id = 253,	Prop = 8,	Quality = 9,	Mid = 711,	Amt = 70,},
	[249] = {	Id = 254,	Prop = 8,	Quality = 9,	Mid = 712,	Amt = 60,},
	[250] = {	Id = 255,	Prop = 8,	Quality = 10,	Mid = 216,	Amt = 120,},
	[251] = {	Id = 256,	Prop = 8,	Quality = 10,	Mid = 217,	Amt = 90,},
	[252] = {	Id = 257,	Prop = 8,	Quality = 10,	Mid = 218,	Amt = 90,},
	[253] = {	Id = 258,	Prop = 8,	Quality = 10,	Mid = 712,	Amt = 110,},
	[254] = {	Id = 259,	Prop = 8,	Quality = 10,	Mid = 713,	Amt = 100,},
	[255] = {	Id = 260,	Prop = 8,	Quality = 10,	Mid = 714,	Amt = 100,},
	[256] = {	Id = 261,	Prop = 2,	Quality = 11,	Mid = 219,	Amt = 120,},
	[257] = {	Id = 262,	Prop = 2,	Quality = 11,	Mid = 220,	Amt = 90,},
	[258] = {	Id = 263,	Prop = 2,	Quality = 11,	Mid = 221,	Amt = 90,},
	[259] = {	Id = 264,	Prop = 2,	Quality = 11,	Mid = 415,	Amt = 120,},
	[260] = {	Id = 265,	Prop = 2,	Quality = 11,	Mid = 416,	Amt = 105,},
	[261] = {	Id = 266,	Prop = 2,	Quality = 11,	Mid = 417,	Amt = 90,},
	[262] = {	Id = 267,	Prop = 2,	Quality = 12,	Mid = 221,	Amt = 180,},
	[263] = {	Id = 268,	Prop = 2,	Quality = 12,	Mid = 222,	Amt = 135,},
	[264] = {	Id = 269,	Prop = 2,	Quality = 12,	Mid = 223,	Amt = 135,},
	[265] = {	Id = 270,	Prop = 2,	Quality = 12,	Mid = 417,	Amt = 165,},
	[266] = {	Id = 271,	Prop = 2,	Quality = 12,	Mid = 418,	Amt = 150,},
	[267] = {	Id = 272,	Prop = 2,	Quality = 12,	Mid = 419,	Amt = 150,},
	[268] = {	Id = 273,	Prop = 3,	Quality = 11,	Mid = 219,	Amt = 120,},
	[269] = {	Id = 274,	Prop = 3,	Quality = 11,	Mid = 220,	Amt = 90,},
	[270] = {	Id = 275,	Prop = 3,	Quality = 11,	Mid = 221,	Amt = 90,},
	[271] = {	Id = 276,	Prop = 3,	Quality = 11,	Mid = 615,	Amt = 120,},
	[272] = {	Id = 277,	Prop = 3,	Quality = 11,	Mid = 616,	Amt = 105,},
	[273] = {	Id = 278,	Prop = 3,	Quality = 11,	Mid = 617,	Amt = 90,},
	[274] = {	Id = 279,	Prop = 3,	Quality = 12,	Mid = 221,	Amt = 180,},
	[275] = {	Id = 280,	Prop = 3,	Quality = 12,	Mid = 222,	Amt = 135,},
	[276] = {	Id = 281,	Prop = 3,	Quality = 12,	Mid = 223,	Amt = 135,},
	[277] = {	Id = 282,	Prop = 3,	Quality = 12,	Mid = 617,	Amt = 165,},
	[278] = {	Id = 283,	Prop = 3,	Quality = 12,	Mid = 618,	Amt = 150,},
	[279] = {	Id = 284,	Prop = 3,	Quality = 12,	Mid = 619,	Amt = 150,},
	[280] = {	Id = 285,	Prop = 6,	Quality = 11,	Mid = 219,	Amt = 120,},
	[281] = {	Id = 286,	Prop = 6,	Quality = 11,	Mid = 220,	Amt = 90,},
	[282] = {	Id = 287,	Prop = 6,	Quality = 11,	Mid = 221,	Amt = 90,},
	[283] = {	Id = 288,	Prop = 6,	Quality = 11,	Mid = 315,	Amt = 120,},
	[284] = {	Id = 289,	Prop = 6,	Quality = 11,	Mid = 316,	Amt = 105,},
	[285] = {	Id = 290,	Prop = 6,	Quality = 11,	Mid = 317,	Amt = 90,},
	[286] = {	Id = 291,	Prop = 6,	Quality = 12,	Mid = 221,	Amt = 180,},
	[287] = {	Id = 292,	Prop = 6,	Quality = 12,	Mid = 222,	Amt = 135,},
	[288] = {	Id = 293,	Prop = 6,	Quality = 12,	Mid = 223,	Amt = 135,},
	[289] = {	Id = 294,	Prop = 6,	Quality = 12,	Mid = 317,	Amt = 165,},
	[290] = {	Id = 295,	Prop = 6,	Quality = 12,	Mid = 318,	Amt = 150,},
	[291] = {	Id = 296,	Prop = 6,	Quality = 12,	Mid = 319,	Amt = 150,},
	[292] = {	Id = 297,	Prop = 7,	Quality = 11,	Mid = 219,	Amt = 120,},
	[293] = {	Id = 298,	Prop = 7,	Quality = 11,	Mid = 220,	Amt = 90,},
	[294] = {	Id = 299,	Prop = 7,	Quality = 11,	Mid = 221,	Amt = 90,},
	[295] = {	Id = 300,	Prop = 7,	Quality = 11,	Mid = 515,	Amt = 120,},
	[296] = {	Id = 301,	Prop = 7,	Quality = 11,	Mid = 516,	Amt = 105,},
	[297] = {	Id = 302,	Prop = 7,	Quality = 11,	Mid = 517,	Amt = 90,},
	[298] = {	Id = 303,	Prop = 7,	Quality = 12,	Mid = 221,	Amt = 180,},
	[299] = {	Id = 304,	Prop = 7,	Quality = 12,	Mid = 222,	Amt = 135,},
	[300] = {	Id = 305,	Prop = 7,	Quality = 12,	Mid = 223,	Amt = 135,},
	[301] = {	Id = 306,	Prop = 7,	Quality = 12,	Mid = 517,	Amt = 165,},
	[302] = {	Id = 307,	Prop = 7,	Quality = 12,	Mid = 518,	Amt = 150,},
	[303] = {	Id = 308,	Prop = 7,	Quality = 12,	Mid = 519,	Amt = 150,},
	[304] = {	Id = 309,	Prop = 8,	Quality = 11,	Mid = 219,	Amt = 120,},
	[305] = {	Id = 310,	Prop = 8,	Quality = 11,	Mid = 220,	Amt = 90,},
	[306] = {	Id = 311,	Prop = 8,	Quality = 11,	Mid = 221,	Amt = 90,},
	[307] = {	Id = 312,	Prop = 8,	Quality = 11,	Mid = 715,	Amt = 120,},
	[308] = {	Id = 313,	Prop = 8,	Quality = 11,	Mid = 716,	Amt = 105,},
	[309] = {	Id = 314,	Prop = 8,	Quality = 11,	Mid = 717,	Amt = 90,},
	[310] = {	Id = 315,	Prop = 8,	Quality = 12,	Mid = 221,	Amt = 180,},
	[311] = {	Id = 316,	Prop = 8,	Quality = 12,	Mid = 222,	Amt = 135,},
	[312] = {	Id = 317,	Prop = 8,	Quality = 12,	Mid = 223,	Amt = 135,},
	[313] = {	Id = 318,	Prop = 8,	Quality = 12,	Mid = 717,	Amt = 165,},
	[314] = {	Id = 319,	Prop = 8,	Quality = 12,	Mid = 718,	Amt = 150,},
	[315] = {	Id = 320,	Prop = 8,	Quality = 12,	Mid = 719,	Amt = 150,},
}

return _table
