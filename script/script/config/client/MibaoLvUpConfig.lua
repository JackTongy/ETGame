--[[
	Id = Id
Star = 星级
Lv = 当前等级
Exp = 升到下一级所需经验
Effect = 升到下一级增加的属性

--]]
local _table = {
	[1] = {	Id = 1,	Star = 2,	Lv = 1,	Exp = 0,	Effect = 0.0060,},
	[2] = {	Id = 2,	Star = 2,	Lv = 2,	Exp = 65,	Effect = 0.0120,},
	[3] = {	Id = 3,	Star = 2,	Lv = 3,	Exp = 162,	Effect = 0.0180,},
	[4] = {	Id = 4,	Star = 2,	Lv = 4,	Exp = 260,	Effect = 0.0240,},
	[5] = {	Id = 5,	Star = 2,	Lv = 5,	Exp = 390,	Effect = 0.0300,},
	[6] = {	Id = 6,	Star = 2,	Lv = 6,	Exp = 520,	Effect = 0.0360,},
	[7] = {	Id = 7,	Star = 2,	Lv = 7,	Exp = 682,	Effect = 0.0420,},
	[8] = {	Id = 8,	Star = 2,	Lv = 8,	Exp = 877,	Effect = 0.0480,},
	[9] = {	Id = 9,	Star = 2,	Lv = 9,	Exp = 1105,	Effect = 0.0540,},
	[10] = {	Id = 10,	Star = 2,	Lv = 10,	Exp = 1365,	Effect = 0.0600,},
	[11] = {	Id = 11,	Star = 2,	Lv = 11,	Exp = 1722,	Effect = 0.0660,},
	[12] = {	Id = 12,	Star = 2,	Lv = 12,	Exp = 2177,	Effect = 0.0720,},
	[13] = {	Id = 13,	Star = 2,	Lv = 13,	Exp = 2730,	Effect = 0.0780,},
	[14] = {	Id = 14,	Star = 2,	Lv = 14,	Exp = 3380,	Effect = 0.0840,},
	[15] = {	Id = 15,	Star = 2,	Lv = 15,	Exp = 4127,	Effect = 0.0900,},
	[16] = {	Id = 16,	Star = 2,	Lv = 16,	Exp = 5005,	Effect = 0.0960,},
	[17] = {	Id = 17,	Star = 2,	Lv = 17,	Exp = 6012,	Effect = 0.1020,},
	[18] = {	Id = 18,	Star = 2,	Lv = 18,	Exp = 7150,	Effect = 0.1080,},
	[19] = {	Id = 19,	Star = 2,	Lv = 19,	Exp = 8417,	Effect = 0.1140,},
	[20] = {	Id = 20,	Star = 2,	Lv = 20,	Exp = 9815,	Effect = 0.1200,},
	[21] = {	Id = 21,	Star = 2,	Lv = 21,	Exp = 11342,	Effect = 0.1260,},
	[22] = {	Id = 22,	Star = 2,	Lv = 22,	Exp = 13000,	Effect = 0.1320,},
	[23] = {	Id = 23,	Star = 2,	Lv = 23,	Exp = 14787,	Effect = 0.1380,},
	[24] = {	Id = 24,	Star = 2,	Lv = 24,	Exp = 16705,	Effect = 0.1440,},
	[25] = {	Id = 25,	Star = 2,	Lv = 25,	Exp = 18752,	Effect = 0.1500,},
	[26] = {	Id = 26,	Star = 2,	Lv = 26,	Exp = 20962,	Effect = 0.1560,},
	[27] = {	Id = 27,	Star = 2,	Lv = 27,	Exp = 23335,	Effect = 0.1620,},
	[28] = {	Id = 28,	Star = 2,	Lv = 28,	Exp = 25870,	Effect = 0.1680,},
	[29] = {	Id = 29,	Star = 2,	Lv = 29,	Exp = 28567,	Effect = 0.1740,},
	[30] = {	Id = 30,	Star = 2,	Lv = 30,	Exp = 31460,	Effect = 0.1800,},
	[31] = {	Id = 31,	Star = 2,	Lv = 31,	Exp = 34547,	Effect = 0.1860,},
	[32] = {	Id = 32,	Star = 2,	Lv = 32,	Exp = 37830,	Effect = 0.1920,},
	[33] = {	Id = 33,	Star = 2,	Lv = 33,	Exp = 41307,	Effect = 0.1980,},
	[34] = {	Id = 34,	Star = 2,	Lv = 34,	Exp = 44980,	Effect = 0.2040,},
	[35] = {	Id = 35,	Star = 2,	Lv = 35,	Exp = 48847,	Effect = 0.2100,},
	[36] = {	Id = 36,	Star = 2,	Lv = 36,	Exp = 52975,	Effect = 0.2160,},
	[37] = {	Id = 37,	Star = 2,	Lv = 37,	Exp = 57362,	Effect = 0.2220,},
	[38] = {	Id = 38,	Star = 2,	Lv = 38,	Exp = 62010,	Effect = 0.2280,},
	[39] = {	Id = 39,	Star = 2,	Lv = 39,	Exp = 66917,	Effect = 0.2340,},
	[40] = {	Id = 40,	Star = 2,	Lv = 40,	Exp = 72085,	Effect = 0.2400,},
	[41] = {	Id = 41,	Star = 2,	Lv = 41,	Exp = 77577,	Effect = 0.2460,},
	[42] = {	Id = 42,	Star = 2,	Lv = 42,	Exp = 83395,	Effect = 0.2520,},
	[43] = {	Id = 43,	Star = 2,	Lv = 43,	Exp = 89537,	Effect = 0.2580,},
	[44] = {	Id = 44,	Star = 2,	Lv = 44,	Exp = 96005,	Effect = 0.2640,},
	[45] = {	Id = 45,	Star = 2,	Lv = 45,	Exp = 102797,	Effect = 0.2700,},
	[46] = {	Id = 46,	Star = 2,	Lv = 46,	Exp = 110077,	Effect = 0.2760,},
	[47] = {	Id = 47,	Star = 2,	Lv = 47,	Exp = 117845,	Effect = 0.2820,},
	[48] = {	Id = 48,	Star = 2,	Lv = 48,	Exp = 126100,	Effect = 0.2880,},
	[49] = {	Id = 49,	Star = 2,	Lv = 49,	Exp = 134842,	Effect = 0.2940,},
	[50] = {	Id = 50,	Star = 2,	Lv = 50,	Exp = 144072,	Effect = 0.3000,},
	[51] = {	Id = 51,	Star = 3,	Lv = 1,	Exp = 0,	Effect = 0.0100,},
	[52] = {	Id = 52,	Star = 3,	Lv = 2,	Exp = 85,	Effect = 0.0200,},
	[53] = {	Id = 53,	Star = 3,	Lv = 3,	Exp = 212,	Effect = 0.0300,},
	[54] = {	Id = 54,	Star = 3,	Lv = 4,	Exp = 340,	Effect = 0.0400,},
	[55] = {	Id = 55,	Star = 3,	Lv = 5,	Exp = 510,	Effect = 0.0500,},
	[56] = {	Id = 56,	Star = 3,	Lv = 6,	Exp = 680,	Effect = 0.0600,},
	[57] = {	Id = 57,	Star = 3,	Lv = 7,	Exp = 892,	Effect = 0.0700,},
	[58] = {	Id = 58,	Star = 3,	Lv = 8,	Exp = 1147,	Effect = 0.0800,},
	[59] = {	Id = 59,	Star = 3,	Lv = 9,	Exp = 1445,	Effect = 0.0900,},
	[60] = {	Id = 60,	Star = 3,	Lv = 10,	Exp = 1785,	Effect = 0.1000,},
	[61] = {	Id = 61,	Star = 3,	Lv = 11,	Exp = 2252,	Effect = 0.1100,},
	[62] = {	Id = 62,	Star = 3,	Lv = 12,	Exp = 2847,	Effect = 0.1200,},
	[63] = {	Id = 63,	Star = 3,	Lv = 13,	Exp = 3570,	Effect = 0.1300,},
	[64] = {	Id = 64,	Star = 3,	Lv = 14,	Exp = 4420,	Effect = 0.1400,},
	[65] = {	Id = 65,	Star = 3,	Lv = 15,	Exp = 5397,	Effect = 0.1500,},
	[66] = {	Id = 66,	Star = 3,	Lv = 16,	Exp = 6545,	Effect = 0.1600,},
	[67] = {	Id = 67,	Star = 3,	Lv = 17,	Exp = 7862,	Effect = 0.1700,},
	[68] = {	Id = 68,	Star = 3,	Lv = 18,	Exp = 9350,	Effect = 0.1800,},
	[69] = {	Id = 69,	Star = 3,	Lv = 19,	Exp = 11007,	Effect = 0.1900,},
	[70] = {	Id = 70,	Star = 3,	Lv = 20,	Exp = 12835,	Effect = 0.2000,},
	[71] = {	Id = 71,	Star = 3,	Lv = 21,	Exp = 14832,	Effect = 0.2100,},
	[72] = {	Id = 72,	Star = 3,	Lv = 22,	Exp = 17000,	Effect = 0.2200,},
	[73] = {	Id = 73,	Star = 3,	Lv = 23,	Exp = 19337,	Effect = 0.2300,},
	[74] = {	Id = 74,	Star = 3,	Lv = 24,	Exp = 21845,	Effect = 0.2400,},
	[75] = {	Id = 75,	Star = 3,	Lv = 25,	Exp = 24522,	Effect = 0.2500,},
	[76] = {	Id = 76,	Star = 3,	Lv = 26,	Exp = 27412,	Effect = 0.2600,},
	[77] = {	Id = 77,	Star = 3,	Lv = 27,	Exp = 30515,	Effect = 0.2700,},
	[78] = {	Id = 78,	Star = 3,	Lv = 28,	Exp = 33830,	Effect = 0.2800,},
	[79] = {	Id = 79,	Star = 3,	Lv = 29,	Exp = 37357,	Effect = 0.2900,},
	[80] = {	Id = 80,	Star = 3,	Lv = 30,	Exp = 41140,	Effect = 0.3000,},
	[81] = {	Id = 81,	Star = 3,	Lv = 31,	Exp = 45177,	Effect = 0.3100,},
	[82] = {	Id = 82,	Star = 3,	Lv = 32,	Exp = 49470,	Effect = 0.3200,},
	[83] = {	Id = 83,	Star = 3,	Lv = 33,	Exp = 54017,	Effect = 0.3300,},
	[84] = {	Id = 84,	Star = 3,	Lv = 34,	Exp = 58820,	Effect = 0.3400,},
	[85] = {	Id = 85,	Star = 3,	Lv = 35,	Exp = 63877,	Effect = 0.3500,},
	[86] = {	Id = 86,	Star = 3,	Lv = 36,	Exp = 69275,	Effect = 0.3600,},
	[87] = {	Id = 87,	Star = 3,	Lv = 37,	Exp = 75012,	Effect = 0.3700,},
	[88] = {	Id = 88,	Star = 3,	Lv = 38,	Exp = 81090,	Effect = 0.3800,},
	[89] = {	Id = 89,	Star = 3,	Lv = 39,	Exp = 87507,	Effect = 0.3900,},
	[90] = {	Id = 90,	Star = 3,	Lv = 40,	Exp = 94265,	Effect = 0.4000,},
	[91] = {	Id = 91,	Star = 3,	Lv = 41,	Exp = 101447,	Effect = 0.4100,},
	[92] = {	Id = 92,	Star = 3,	Lv = 42,	Exp = 109055,	Effect = 0.4200,},
	[93] = {	Id = 93,	Star = 3,	Lv = 43,	Exp = 117087,	Effect = 0.4300,},
	[94] = {	Id = 94,	Star = 3,	Lv = 44,	Exp = 125545,	Effect = 0.4400,},
	[95] = {	Id = 95,	Star = 3,	Lv = 45,	Exp = 134427,	Effect = 0.4500,},
	[96] = {	Id = 96,	Star = 3,	Lv = 46,	Exp = 143947,	Effect = 0.4600,},
	[97] = {	Id = 97,	Star = 3,	Lv = 47,	Exp = 154105,	Effect = 0.4700,},
	[98] = {	Id = 98,	Star = 3,	Lv = 48,	Exp = 164900,	Effect = 0.4800,},
	[99] = {	Id = 99,	Star = 3,	Lv = 49,	Exp = 176332,	Effect = 0.4900,},
	[100] = {	Id = 100,	Star = 3,	Lv = 50,	Exp = 188402,	Effect = 0.5000,},
	[101] = {	Id = 101,	Star = 4,	Lv = 1,	Exp = 0,	Effect = 0.0150,},
	[102] = {	Id = 102,	Star = 4,	Lv = 2,	Exp = 100,	Effect = 0.0300,},
	[103] = {	Id = 103,	Star = 4,	Lv = 3,	Exp = 250,	Effect = 0.0450,},
	[104] = {	Id = 104,	Star = 4,	Lv = 4,	Exp = 400,	Effect = 0.0600,},
	[105] = {	Id = 105,	Star = 4,	Lv = 5,	Exp = 600,	Effect = 0.0750,},
	[106] = {	Id = 106,	Star = 4,	Lv = 6,	Exp = 800,	Effect = 0.0900,},
	[107] = {	Id = 107,	Star = 4,	Lv = 7,	Exp = 1050,	Effect = 0.1050,},
	[108] = {	Id = 108,	Star = 4,	Lv = 8,	Exp = 1350,	Effect = 0.1200,},
	[109] = {	Id = 109,	Star = 4,	Lv = 9,	Exp = 1700,	Effect = 0.1350,},
	[110] = {	Id = 110,	Star = 4,	Lv = 10,	Exp = 2100,	Effect = 0.1500,},
	[111] = {	Id = 111,	Star = 4,	Lv = 11,	Exp = 2650,	Effect = 0.1650,},
	[112] = {	Id = 112,	Star = 4,	Lv = 12,	Exp = 3350,	Effect = 0.1800,},
	[113] = {	Id = 113,	Star = 4,	Lv = 13,	Exp = 4200,	Effect = 0.1950,},
	[114] = {	Id = 114,	Star = 4,	Lv = 14,	Exp = 5200,	Effect = 0.2100,},
	[115] = {	Id = 115,	Star = 4,	Lv = 15,	Exp = 6350,	Effect = 0.2250,},
	[116] = {	Id = 116,	Star = 4,	Lv = 16,	Exp = 7700,	Effect = 0.2400,},
	[117] = {	Id = 117,	Star = 4,	Lv = 17,	Exp = 9250,	Effect = 0.2550,},
	[118] = {	Id = 118,	Star = 4,	Lv = 18,	Exp = 11000,	Effect = 0.2700,},
	[119] = {	Id = 119,	Star = 4,	Lv = 19,	Exp = 12950,	Effect = 0.2850,},
	[120] = {	Id = 120,	Star = 4,	Lv = 20,	Exp = 15100,	Effect = 0.3000,},
	[121] = {	Id = 121,	Star = 4,	Lv = 21,	Exp = 17450,	Effect = 0.3150,},
	[122] = {	Id = 122,	Star = 4,	Lv = 22,	Exp = 20000,	Effect = 0.3300,},
	[123] = {	Id = 123,	Star = 4,	Lv = 23,	Exp = 22750,	Effect = 0.3450,},
	[124] = {	Id = 124,	Star = 4,	Lv = 24,	Exp = 25700,	Effect = 0.3600,},
	[125] = {	Id = 125,	Star = 4,	Lv = 25,	Exp = 28850,	Effect = 0.3750,},
	[126] = {	Id = 126,	Star = 4,	Lv = 26,	Exp = 32250,	Effect = 0.3900,},
	[127] = {	Id = 127,	Star = 4,	Lv = 27,	Exp = 35900,	Effect = 0.4050,},
	[128] = {	Id = 128,	Star = 4,	Lv = 28,	Exp = 39800,	Effect = 0.4200,},
	[129] = {	Id = 129,	Star = 4,	Lv = 29,	Exp = 43950,	Effect = 0.4350,},
	[130] = {	Id = 130,	Star = 4,	Lv = 30,	Exp = 48400,	Effect = 0.4500,},
	[131] = {	Id = 131,	Star = 4,	Lv = 31,	Exp = 53150,	Effect = 0.4650,},
	[132] = {	Id = 132,	Star = 4,	Lv = 32,	Exp = 58200,	Effect = 0.4800,},
	[133] = {	Id = 133,	Star = 4,	Lv = 33,	Exp = 63550,	Effect = 0.4950,},
	[134] = {	Id = 134,	Star = 4,	Lv = 34,	Exp = 69200,	Effect = 0.5100,},
	[135] = {	Id = 135,	Star = 4,	Lv = 35,	Exp = 75150,	Effect = 0.5250,},
	[136] = {	Id = 136,	Star = 4,	Lv = 36,	Exp = 81500,	Effect = 0.5400,},
	[137] = {	Id = 137,	Star = 4,	Lv = 37,	Exp = 88250,	Effect = 0.5550,},
	[138] = {	Id = 138,	Star = 4,	Lv = 38,	Exp = 95400,	Effect = 0.5700,},
	[139] = {	Id = 139,	Star = 4,	Lv = 39,	Exp = 102950,	Effect = 0.5850,},
	[140] = {	Id = 140,	Star = 4,	Lv = 40,	Exp = 110900,	Effect = 0.6000,},
	[141] = {	Id = 141,	Star = 4,	Lv = 41,	Exp = 119350,	Effect = 0.6150,},
	[142] = {	Id = 142,	Star = 4,	Lv = 42,	Exp = 128300,	Effect = 0.6300,},
	[143] = {	Id = 143,	Star = 4,	Lv = 43,	Exp = 137750,	Effect = 0.6450,},
	[144] = {	Id = 144,	Star = 4,	Lv = 44,	Exp = 147700,	Effect = 0.6600,},
	[145] = {	Id = 145,	Star = 4,	Lv = 45,	Exp = 158150,	Effect = 0.6750,},
	[146] = {	Id = 146,	Star = 4,	Lv = 46,	Exp = 169350,	Effect = 0.6900,},
	[147] = {	Id = 147,	Star = 4,	Lv = 47,	Exp = 181300,	Effect = 0.7050,},
	[148] = {	Id = 148,	Star = 4,	Lv = 48,	Exp = 194000,	Effect = 0.7200,},
	[149] = {	Id = 149,	Star = 4,	Lv = 49,	Exp = 207450,	Effect = 0.7350,},
	[150] = {	Id = 150,	Star = 4,	Lv = 50,	Exp = 221650,	Effect = 0.7500,},
}

return _table