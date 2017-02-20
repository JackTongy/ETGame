--[[
	PubId = 酒馆id
StarLevel = 精灵星级
PetId = 精灵id
name = 精灵名字
Rate = 概率

--]]
local _table = {
	[1] = {	PubId = 1,	StarLevel = 3,	PetId = 43,	name = [[走路草]],	Rate = 0.0520,},
	[2] = {	PubId = 1,	StarLevel = 3,	PetId = 69,	name = [[喇叭芽]],	Rate = 0.0520,},
	[3] = {	PubId = 1,	StarLevel = 3,	PetId = 187,	name = [[毽子草]],	Rate = 0.0520,},
	[4] = {	PubId = 1,	StarLevel = 3,	PetId = 72,	name = [[玛瑙水母]],	Rate = 0.0520,},
	[5] = {	PubId = 1,	StarLevel = 3,	PetId = 109,	name = [[瓦斯弹]],	Rate = 0.0520,},
	[6] = {	PubId = 1,	StarLevel = 3,	PetId = 63,	name = [[凯西]],	Rate = 0.0520,},
	[7] = {	PubId = 1,	StarLevel = 3,	PetId = 20,	name = [[拉达]],	Rate = 0.0520,},
	[8] = {	PubId = 1,	StarLevel = 3,	PetId = 255,	name = [[火雉鸡]],	Rate = 0.0520,},
	[9] = {	PubId = 1,	StarLevel = 3,	PetId = 158,	name = [[小锯鳄]],	Rate = 0.0520,},
	[10] = {	PubId = 1,	StarLevel = 3,	PetId = 32,	name = [[尼多朗]],	Rate = 0.0520,},
	[11] = {	PubId = 1,	StarLevel = 3,	PetId = 14,	name = [[铁壳昆]],	Rate = 0.0520,},
	[12] = {	PubId = 1,	StarLevel = 3,	PetId = 21,	name = [[烈雀]],	Rate = 0.0520,},
	[13] = {	PubId = 1,	StarLevel = 3,	PetId = 35,	name = [[皮皮]],	Rate = 0.0520,},
	[14] = {	PubId = 1,	StarLevel = 3,	PetId = 16,	name = [[波波]],	Rate = 0.0520,},
	[15] = {	PubId = 1,	StarLevel = 3,	PetId = 11,	name = [[铁甲蛹]],	Rate = 0.0520,},
	[16] = {	PubId = 1,	StarLevel = 4,	PetId = 159,	name = [[蓝鳄]],	Rate = 0.0115,},
	[17] = {	PubId = 1,	StarLevel = 4,	PetId = 256,	name = [[力壮鸡]],	Rate = 0.0115,},
	[18] = {	PubId = 1,	StarLevel = 4,	PetId = 61,	name = [[蚊香蛙]],	Rate = 0.0115,},
	[19] = {	PubId = 1,	StarLevel = 4,	PetId = 44,	name = [[臭臭花]],	Rate = 0.0115,},
	[20] = {	PubId = 1,	StarLevel = 4,	PetId = 70,	name = [[口呆花]],	Rate = 0.0115,},
	[21] = {	PubId = 1,	StarLevel = 4,	PetId = 188,	name = [[毽子花]],	Rate = 0.0115,},
	[22] = {	PubId = 1,	StarLevel = 4,	PetId = 12,	name = [[巴大蝴]],	Rate = 0.0115,},
	[23] = {	PubId = 1,	StarLevel = 4,	PetId = 36,	name = [[皮克西]],	Rate = 0.0115,},
	[24] = {	PubId = 1,	StarLevel = 4,	PetId = 570,	name = [[索罗亚]],	Rate = 0.0115,},
	[25] = {	PubId = 1,	StarLevel = 4,	PetId = 33,	name = [[尼多力诺]],	Rate = 0.0115,},
	[26] = {	PubId = 1,	StarLevel = 4,	PetId = 15,	name = [[大针蜂]],	Rate = 0.0115,},
	[27] = {	PubId = 1,	StarLevel = 4,	PetId = 153,	name = [[月桂叶]],	Rate = 0.0115,},
	[28] = {	PubId = 1,	StarLevel = 4,	PetId = 113,	name = [[吉利蛋]],	Rate = 0.0115,},
	[29] = {	PubId = 1,	StarLevel = 5,	PetId = 160,	name = [[大力鳄]],	Rate = 0.0070,},
	[30] = {	PubId = 1,	StarLevel = 5,	PetId = 62,	name = [[快泳蛙]],	Rate = 0.0070,},
	[31] = {	PubId = 1,	StarLevel = 5,	PetId = 45,	name = [[霸王花]],	Rate = 0.0070,},
	[32] = {	PubId = 1,	StarLevel = 5,	PetId = 71,	name = [[大食花]],	Rate = 0.0070,},
	[33] = {	PubId = 1,	StarLevel = 5,	PetId = 135,	name = [[雷精灵]],	Rate = 0.0070,},
	[34] = {	PubId = 1,	StarLevel = 5,	PetId = 136,	name = [[火精灵]],	Rate = 0.0070,},
	[35] = {	PubId = 1,	StarLevel = 5,	PetId = 470,	name = [[叶精灵]],	Rate = 0.0070,},
	[36] = {	PubId = 1,	StarLevel = 5,	PetId = 242,	name = [[幸福蛋]],	Rate = 0.0070,},
	[37] = {	PubId = 1,	StarLevel = 5,	PetId = 189,	name = [[毽子绵]],	Rate = 0.0070,},
	[38] = {	PubId = 1,	StarLevel = 5,	PetId = 34,	name = [[尼多王]],	Rate = 0.0070,},
	[39] = {	PubId = 2,	StarLevel = 3,	PetId = 60,	name = [[蚊香蝌蚪]],	Rate = 0.0557,},
	[40] = {	PubId = 2,	StarLevel = 3,	PetId = 90,	name = [[大舌贝]],	Rate = 0.0557,},
	[41] = {	PubId = 2,	StarLevel = 3,	PetId = 37,	name = [[六尾]],	Rate = 0.0557,},
	[42] = {	PubId = 2,	StarLevel = 3,	PetId = 79,	name = [[呆呆兽]],	Rate = 0.0557,},
	[43] = {	PubId = 2,	StarLevel = 3,	PetId = 77,	name = [[小火马]],	Rate = 0.0557,},
	[44] = {	PubId = 2,	StarLevel = 3,	PetId = 58,	name = [[卡蒂狗]],	Rate = 0.0557,},
	[45] = {	PubId = 2,	StarLevel = 3,	PetId = 240,	name = [[小鸭嘴龙]],	Rate = 0.0557,},
	[46] = {	PubId = 2,	StarLevel = 3,	PetId = 41,	name = [[超音蝠]],	Rate = 0.0557,},
	[47] = {	PubId = 2,	StarLevel = 3,	PetId = 4,	name = [[小火龙]],	Rate = 0.0557,},
	[48] = {	PubId = 2,	StarLevel = 3,	PetId = 7,	name = [[杰尼龟]],	Rate = 0.0557,},
	[49] = {	PubId = 2,	StarLevel = 3,	PetId = 1,	name = [[妙蛙种子]],	Rate = 0.0557,},
	[50] = {	PubId = 2,	StarLevel = 3,	PetId = 172,	name = [[皮丘]],	Rate = 0.0557,},
	[51] = {	PubId = 2,	StarLevel = 3,	PetId = 29,	name = [[尼多兰]],	Rate = 0.0557,},
	[52] = {	PubId = 2,	StarLevel = 3,	PetId = 152,	name = [[菊草叶]],	Rate = 0.0557,},
	[53] = {	PubId = 2,	StarLevel = 4,	PetId = 8,	name = [[卡咪龟]],	Rate = 0.0107,},
	[54] = {	PubId = 2,	StarLevel = 4,	PetId = 5,	name = [[火恐龙]],	Rate = 0.0107,},
	[55] = {	PubId = 2,	StarLevel = 4,	PetId = 25,	name = [[皮卡丘]],	Rate = 0.0107,},
	[56] = {	PubId = 2,	StarLevel = 4,	PetId = 2,	name = [[妙蛙草]],	Rate = 0.0107,},
	[57] = {	PubId = 2,	StarLevel = 4,	PetId = 126,	name = [[鸭嘴火龙]],	Rate = 0.0107,},
	[58] = {	PubId = 2,	StarLevel = 4,	PetId = 64,	name = [[勇吉拉]],	Rate = 0.0107,},
	[59] = {	PubId = 2,	StarLevel = 4,	PetId = 42,	name = [[大嘴蝠]],	Rate = 0.0107,},
	[60] = {	PubId = 2,	StarLevel = 4,	PetId = 73,	name = [[毒刺水母]],	Rate = 0.0107,},
	[61] = {	PubId = 2,	StarLevel = 4,	PetId = 110,	name = [[双弹瓦斯]],	Rate = 0.0107,},
	[62] = {	PubId = 2,	StarLevel = 4,	PetId = 80,	name = [[呆河马]],	Rate = 0.0107,},
	[63] = {	PubId = 2,	StarLevel = 4,	PetId = 99,	name = [[巨钳蟹]],	Rate = 0.0107,},
	[64] = {	PubId = 2,	StarLevel = 4,	PetId = 75,	name = [[隆隆石]],	Rate = 0.0107,},
	[65] = {	PubId = 2,	StarLevel = 4,	PetId = 30,	name = [[尼多娜]],	Rate = 0.0107,},
	[66] = {	PubId = 2,	StarLevel = 4,	PetId = 128,	name = [[肯泰罗]],	Rate = 0.0107,},
	[67] = {	PubId = 2,	StarLevel = 5,	PetId = 3,	name = [[妙蛙花]],	Rate = 0.0078,},
	[68] = {	PubId = 2,	StarLevel = 5,	PetId = 467,	name = [[鸭嘴焰龙]],	Rate = 0.0078,},
	[69] = {	PubId = 2,	StarLevel = 5,	PetId = 6,	name = [[喷火龙]],	Rate = 0.0078,},
	[70] = {	PubId = 2,	StarLevel = 5,	PetId = 9,	name = [[水箭龟]],	Rate = 0.0078,},
	[71] = {	PubId = 2,	StarLevel = 5,	PetId = 26,	name = [[雷丘]],	Rate = 0.0078,},
	[72] = {	PubId = 2,	StarLevel = 5,	PetId = 169,	name = [[叉字蝠]],	Rate = 0.0078,},
	[73] = {	PubId = 2,	StarLevel = 5,	PetId = 31,	name = [[尼多后]],	Rate = 0.0078,},
	[74] = {	PubId = 2,	StarLevel = 5,	PetId = 154,	name = [[大菊花]],	Rate = 0.0078,},
	[75] = {	PubId = 2,	StarLevel = 5,	PetId = 115,	name = [[袋龙]],	Rate = 0.0078,},
	[76] = {	PubId = 3,	StarLevel = 3,	PetId = 54,	name = [[可达鸭]],	Rate = 0.0780,},
	[77] = {	PubId = 3,	StarLevel = 3,	PetId = 98,	name = [[大钳蟹]],	Rate = 0.0780,},
	[78] = {	PubId = 3,	StarLevel = 3,	PetId = 116,	name = [[墨海马]],	Rate = 0.0780,},
	[79] = {	PubId = 3,	StarLevel = 3,	PetId = 27,	name = [[穿山鼠]],	Rate = 0.0780,},
	[80] = {	PubId = 3,	StarLevel = 3,	PetId = 147,	name = [[迷你龙]],	Rate = 0.0780,},
	[81] = {	PubId = 3,	StarLevel = 3,	PetId = 246,	name = [[由基拉]],	Rate = 0.0780,},
	[82] = {	PubId = 3,	StarLevel = 3,	PetId = 39,	name = [[胖丁]],	Rate = 0.0780,},
	[83] = {	PubId = 3,	StarLevel = 3,	PetId = 280,	name = [[拉鲁拉丝]],	Rate = 0.0780,},
	[84] = {	PubId = 3,	StarLevel = 3,	PetId = 74,	name = [[小拳石]],	Rate = 0.0780,},
	[85] = {	PubId = 3,	StarLevel = 3,	PetId = 304,	name = [[可可多拉]],	Rate = 0.0780,},
	[86] = {	PubId = 3,	StarLevel = 4,	PetId = 55,	name = [[哥达鸭]],	Rate = 0.0100,},
	[87] = {	PubId = 3,	StarLevel = 4,	PetId = 148,	name = [[哈克龙]],	Rate = 0.0100,},
	[88] = {	PubId = 3,	StarLevel = 4,	PetId = 17,	name = [[比比鸟]],	Rate = 0.0100,},
	[89] = {	PubId = 3,	StarLevel = 4,	PetId = 22,	name = [[大嘴雀]],	Rate = 0.0100,},
	[90] = {	PubId = 3,	StarLevel = 4,	PetId = 28,	name = [[穿山王]],	Rate = 0.0100,},
	[91] = {	PubId = 3,	StarLevel = 4,	PetId = 117,	name = [[海刺龙]],	Rate = 0.0100,},
	[92] = {	PubId = 3,	StarLevel = 4,	PetId = 78,	name = [[烈焰马]],	Rate = 0.0100,},
	[93] = {	PubId = 3,	StarLevel = 4,	PetId = 59,	name = [[风速狗]],	Rate = 0.0100,},
	[94] = {	PubId = 3,	StarLevel = 4,	PetId = 38,	name = [[九尾]],	Rate = 0.0100,},
	[95] = {	PubId = 3,	StarLevel = 4,	PetId = 247,	name = [[沙基拉]],	Rate = 0.0100,},
	[96] = {	PubId = 3,	StarLevel = 4,	PetId = 305,	name = [[可多拉]],	Rate = 0.0100,},
	[97] = {	PubId = 3,	StarLevel = 4,	PetId = 281,	name = [[奇鲁莉安]],	Rate = 0.0100,},
	[98] = {	PubId = 3,	StarLevel = 4,	PetId = 241,	name = [[大奶罐]],	Rate = 0.0100,},
	[99] = {	PubId = 3,	StarLevel = 4,	PetId = 176,	name = [[波克基古]],	Rate = 0.0100,},
	[100] = {	PubId = 3,	StarLevel = 4,	PetId = 40,	name = [[胖可丁]],	Rate = 0.0100,},
	[101] = {	PubId = 3,	StarLevel = 5,	PetId = 18,	name = [[比雕]],	Rate = 0.0078,},
	[102] = {	PubId = 3,	StarLevel = 5,	PetId = 76,	name = [[隆隆岩]],	Rate = 0.0078,},
	[103] = {	PubId = 3,	StarLevel = 5,	PetId = 68,	name = [[怪力]],	Rate = 0.0078,},
	[104] = {	PubId = 3,	StarLevel = 5,	PetId = 466,	name = [[电击魔兽]],	Rate = 0.0078,},
	[105] = {	PubId = 3,	StarLevel = 5,	PetId = 350,	name = [[美纳斯]],	Rate = 0.0078,},
	[106] = {	PubId = 3,	StarLevel = 5,	PetId = 306,	name = [[波士可多拉]],	Rate = 0.0078,},
	[107] = {	PubId = 3,	StarLevel = 5,	PetId = 468,	name = [[波克基斯]],	Rate = 0.0078,},
	[108] = {	PubId = 3,	StarLevel = 5,	PetId = 282,	name = [[沙奈朵]],	Rate = 0.0078,},
	[109] = {	PubId = 3,	StarLevel = 5,	PetId = 106,	name = [[沙瓦郎]],	Rate = 0.0078,},
	[110] = {	PubId = 4,	StarLevel = 3,	PetId = 56,	name = [[猴怪]],	Rate = 0.1300,},
	[111] = {	PubId = 4,	StarLevel = 3,	PetId = 239,	name = [[电击怪]],	Rate = 0.1300,},
	[112] = {	PubId = 4,	StarLevel = 3,	PetId = 66,	name = [[腕力]],	Rate = 0.1300,},
	[113] = {	PubId = 4,	StarLevel = 3,	PetId = 371,	name = [[宝贝龙]],	Rate = 0.1300,},
	[114] = {	PubId = 4,	StarLevel = 3,	PetId = 104,	name = [[可拉可拉]],	Rate = 0.1300,},
	[115] = {	PubId = 4,	StarLevel = 3,	PetId = 270,	name = [[莲叶童子]],	Rate = 0.1300,},
	[116] = {	PubId = 4,	StarLevel = 4,	PetId = 125,	name = [[电击兽]],	Rate = 0.0188,},
	[117] = {	PubId = 4,	StarLevel = 4,	PetId = 57,	name = [[火爆猴]],	Rate = 0.0188,},
	[118] = {	PubId = 4,	StarLevel = 4,	PetId = 67,	name = [[豪力]],	Rate = 0.0188,},
	[119] = {	PubId = 4,	StarLevel = 4,	PetId = 359,	name = [[阿勃梭鲁]],	Rate = 0.0188,},
	[120] = {	PubId = 4,	StarLevel = 4,	PetId = 372,	name = [[甲壳龙]],	Rate = 0.0188,},
	[121] = {	PubId = 4,	StarLevel = 4,	PetId = 105,	name = [[嘎拉嘎拉]],	Rate = 0.0188,},
	[122] = {	PubId = 4,	StarLevel = 4,	PetId = 333,	name = [[青绵鸟]],	Rate = 0.0188,},
	[123] = {	PubId = 4,	StarLevel = 4,	PetId = 271,	name = [[莲帽小童]],	Rate = 0.0188,},
	[124] = {	PubId = 4,	StarLevel = 5,	PetId = 357,	name = [[热带龙]],	Rate = 0.0088,},
	[125] = {	PubId = 4,	StarLevel = 5,	PetId = 91,	name = [[铁甲贝]],	Rate = 0.0088,},
	[126] = {	PubId = 4,	StarLevel = 5,	PetId = 230,	name = [[刺龙王]],	Rate = 0.0088,},
	[127] = {	PubId = 4,	StarLevel = 5,	PetId = 272,	name = [[乐天河童]],	Rate = 0.0088,},
	[128] = {	PubId = 4,	StarLevel = 5,	PetId = 107,	name = [[艾比郎]],	Rate = 0.0088,},
	[129] = {	PubId = 4,	StarLevel = 5,	PetId = 237,	name = [[柯波朗]],	Rate = 0.0088,},
	[130] = {	PubId = 4,	StarLevel = 5,	PetId = 475,	name = [[艾路雷朵]],	Rate = 0.0088,},
	[131] = {	PubId = 4,	StarLevel = 5,	PetId = 373,	name = [[暴蝾螈]],	Rate = 0.0088,},
}

return _table
