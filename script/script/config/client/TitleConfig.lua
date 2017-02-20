--[[
	Id = Id
Name1 = 称号名称1
Name = 称号名称
titlelv = 称号等级
atkrate = 攻击加成系数
hprate = 生命加成系数
score = 领取所需历史获得积分

--]]
local _table = {
	[1] = {	Id = 0,	Name1 = [[初
心
者]],	Name = [[初心者]],	titlelv = 0,	atkrate = 0,	hprate = 0,	score = 0,},
	[2] = {	Id = 1,	Name1 = [[初
心
者]],	Name = [[初心者]],	titlelv = 0,	atkrate = 7,	hprate = 3,	score = 3,},
	[3] = {	Id = 2,	Name1 = [[初
心
者]],	Name = [[初心者]],	titlelv = 0,	atkrate = 17,	hprate = 7,	score = 3,},
	[4] = {	Id = 3,	Name1 = [[初
心
者]],	Name = [[初心者]],	titlelv = 0,	atkrate = 23,	hprate = 17,	score = 3,},
	[5] = {	Id = 4,	Name1 = [[初
心
者]],	Name = [[初心者]],	titlelv = 0,	atkrate = 31,	hprate = 31,	score = 3,},
	[6] = {	Id = 5,	Name1 = [[见
习
训
练
师]],	Name = [[见习训练师]],	titlelv = 1,	atkrate = 51,	hprate = 51,	score = 3,},
	[7] = {	Id = 6,	Name1 = [[见
习
训
练
师]],	Name = [[见习训练师]],	titlelv = 1,	atkrate = 67,	hprate = 59,	score = 3,},
	[8] = {	Id = 7,	Name1 = [[见
习
训
练
师]],	Name = [[见习训练师]],	titlelv = 1,	atkrate = 75,	hprate = 75,	score = 3,},
	[9] = {	Id = 8,	Name1 = [[见
习
训
练
师]],	Name = [[见习训练师]],	titlelv = 1,	atkrate = 93,	hprate = 84,	score = 3,},
	[10] = {	Id = 9,	Name1 = [[见
习
训
练
师]],	Name = [[见习训练师]],	titlelv = 1,	atkrate = 102,	hprate = 102,	score = 3,},
	[11] = {	Id = 10,	Name1 = [[见
习
训
练
师]],	Name = [[见习训练师]],	titlelv = 1,	atkrate = 122,	hprate = 112,	score = 3,},
	[12] = {	Id = 11,	Name1 = [[见
习
训
练
师]],	Name = [[见习训练师]],	titlelv = 1,	atkrate = 132,	hprate = 132,	score = 3,},
	[13] = {	Id = 12,	Name1 = [[预
备
训
练
师]],	Name = [[预备训练师]],	titlelv = 2,	atkrate = 172,	hprate = 172,	score = 3,},
	[14] = {	Id = 13,	Name1 = [[预
备
训
练
师]],	Name = [[预备训练师]],	titlelv = 2,	atkrate = 192,	hprate = 182,	score = 3,},
	[15] = {	Id = 14,	Name1 = [[预
备
训
练
师]],	Name = [[预备训练师]],	titlelv = 2,	atkrate = 202,	hprate = 202,	score = 3,},
	[16] = {	Id = 15,	Name1 = [[预
备
训
练
师]],	Name = [[预备训练师]],	titlelv = 2,	atkrate = 224,	hprate = 213,	score = 3,},
	[17] = {	Id = 16,	Name1 = [[预
备
训
练
师]],	Name = [[预备训练师]],	titlelv = 2,	atkrate = 235,	hprate = 235,	score = 3,},
	[18] = {	Id = 17,	Name1 = [[预
备
训
练
师]],	Name = [[预备训练师]],	titlelv = 2,	atkrate = 259,	hprate = 247,	score = 3,},
	[19] = {	Id = 18,	Name1 = [[预
备
训
练
师]],	Name = [[预备训练师]],	titlelv = 2,	atkrate = 271,	hprate = 271,	score = 3,},
	[20] = {	Id = 19,	Name1 = [[认
证
训
练
师]],	Name = [[认证训练师]],	titlelv = 3,	atkrate = 323,	hprate = 323,	score = 3,},
	[21] = {	Id = 20,	Name1 = [[认
证
训
练
师]],	Name = [[认证训练师]],	titlelv = 3,	atkrate = 347,	hprate = 335,	score = 3,},
	[22] = {	Id = 21,	Name1 = [[认
证
训
练
师]],	Name = [[认证训练师]],	titlelv = 3,	atkrate = 359,	hprate = 359,	score = 3,},
	[23] = {	Id = 22,	Name1 = [[认
证
训
练
师]],	Name = [[认证训练师]],	titlelv = 3,	atkrate = 385,	hprate = 372,	score = 3,},
	[24] = {	Id = 23,	Name1 = [[认
证
训
练
师]],	Name = [[认证训练师]],	titlelv = 3,	atkrate = 398,	hprate = 398,	score = 3,},
	[25] = {	Id = 24,	Name1 = [[认
证
训
练
师]],	Name = [[认证训练师]],	titlelv = 3,	atkrate = 426,	hprate = 412,	score = 3,},
	[26] = {	Id = 25,	Name1 = [[认
证
训
练
师]],	Name = [[认证训练师]],	titlelv = 3,	atkrate = 440,	hprate = 440,	score = 3,},
	[27] = {	Id = 26,	Name1 = [[初
级
训
练
师]],	Name = [[初级训练师]],	titlelv = 4,	atkrate = 504,	hprate = 504,	score = 3,},
	[28] = {	Id = 27,	Name1 = [[初
级
训
练
师]],	Name = [[初级训练师]],	titlelv = 4,	atkrate = 532,	hprate = 518,	score = 3,},
	[29] = {	Id = 28,	Name1 = [[初
级
训
练
师]],	Name = [[初级训练师]],	titlelv = 4,	atkrate = 546,	hprate = 546,	score = 3,},
	[30] = {	Id = 29,	Name1 = [[初
级
训
练
师]],	Name = [[初级训练师]],	titlelv = 4,	atkrate = 576,	hprate = 561,	score = 3,},
	[31] = {	Id = 30,	Name1 = [[初
级
训
练
师]],	Name = [[初级训练师]],	titlelv = 4,	atkrate = 591,	hprate = 591,	score = 3,},
	[32] = {	Id = 31,	Name1 = [[初
级
训
练
师]],	Name = [[初级训练师]],	titlelv = 4,	atkrate = 623,	hprate = 607,	score = 3,},
	[33] = {	Id = 32,	Name1 = [[初
级
训
练
师]],	Name = [[初级训练师]],	titlelv = 4,	atkrate = 639,	hprate = 639,	score = 3,},
	[34] = {	Id = 33,	Name1 = [[中
级
训
练
师]],	Name = [[中级训练师]],	titlelv = 5,	atkrate = 699,	hprate = 699,	score = 3,},
	[35] = {	Id = 34,	Name1 = [[中
级
训
练
师]],	Name = [[中级训练师]],	titlelv = 5,	atkrate = 731,	hprate = 715,	score = 3,},
	[36] = {	Id = 35,	Name1 = [[中
级
训
练
师]],	Name = [[中级训练师]],	titlelv = 5,	atkrate = 747,	hprate = 747,	score = 3,},
	[37] = {	Id = 36,	Name1 = [[中
级
训
练
师]],	Name = [[中级训练师]],	titlelv = 5,	atkrate = 779,	hprate = 763,	score = 3,},
	[38] = {	Id = 37,	Name1 = [[中
级
训
练
师]],	Name = [[中级训练师]],	titlelv = 5,	atkrate = 796,	hprate = 796,	score = 3,},
	[39] = {	Id = 38,	Name1 = [[高
级
训
练
师]],	Name = [[高级训练师]],	titlelv = 6,	atkrate = 883,	hprate = 883,	score = 3,},
	[40] = {	Id = 39,	Name1 = [[高
级
训
练
师]],	Name = [[高级训练师]],	titlelv = 6,	atkrate = 919,	hprate = 901,	score = 3,},
	[41] = {	Id = 40,	Name1 = [[高
级
训
练
师]],	Name = [[高级训练师]],	titlelv = 6,	atkrate = 937,	hprate = 937,	score = 3,},
	[42] = {	Id = 41,	Name1 = [[高
级
训
练
师]],	Name = [[高级训练师]],	titlelv = 6,	atkrate = 973,	hprate = 955,	score = 3,},
	[43] = {	Id = 42,	Name1 = [[高
级
训
练
师]],	Name = [[高级训练师]],	titlelv = 6,	atkrate = 991,	hprate = 991,	score = 3,},
	[44] = {	Id = 43,	Name1 = [[青
铜
训
练
师]],	Name = [[青铜训练师]],	titlelv = 7,	atkrate = 1109,	hprate = 1109,	score = 3,},
	[45] = {	Id = 44,	Name1 = [[青
铜
训
练
师]],	Name = [[青铜训练师]],	titlelv = 7,	atkrate = 1149,	hprate = 1129,	score = 3,},
	[46] = {	Id = 45,	Name1 = [[青
铜
训
练
师]],	Name = [[青铜训练师]],	titlelv = 7,	atkrate = 1169,	hprate = 1169,	score = 3,},
	[47] = {	Id = 46,	Name1 = [[青
铜
训
练
师]],	Name = [[青铜训练师]],	titlelv = 7,	atkrate = 1209,	hprate = 1189,	score = 3,},
	[48] = {	Id = 47,	Name1 = [[青
铜
训
练
师]],	Name = [[青铜训练师]],	titlelv = 7,	atkrate = 1229,	hprate = 1229,	score = 3,},
	[49] = {	Id = 48,	Name1 = [[白
银
训
练
师]],	Name = [[白银训练师]],	titlelv = 8,	atkrate = 1369,	hprate = 1369,	score = 3,},
	[50] = {	Id = 49,	Name1 = [[白
银
训
练
师]],	Name = [[白银训练师]],	titlelv = 8,	atkrate = 1413,	hprate = 1391,	score = 3,},
	[51] = {	Id = 50,	Name1 = [[白
银
训
练
师]],	Name = [[白银训练师]],	titlelv = 8,	atkrate = 1435,	hprate = 1435,	score = 3,},
	[52] = {	Id = 51,	Name1 = [[白
银
训
练
师]],	Name = [[白银训练师]],	titlelv = 8,	atkrate = 1479,	hprate = 1457,	score = 3,},
	[53] = {	Id = 52,	Name1 = [[白
银
训
练
师]],	Name = [[白银训练师]],	titlelv = 8,	atkrate = 1501,	hprate = 1501,	score = 3,},
	[54] = {	Id = 53,	Name1 = [[黄
金
训
练
师]],	Name = [[黄金训练师]],	titlelv = 9,	atkrate = 1641,	hprate = 1641,	score = 3,},
	[55] = {	Id = 54,	Name1 = [[黄
金
训
练
师]],	Name = [[黄金训练师]],	titlelv = 9,	atkrate = 1689,	hprate = 1665,	score = 3,},
	[56] = {	Id = 55,	Name1 = [[黄
金
训
练
师]],	Name = [[黄金训练师]],	titlelv = 9,	atkrate = 1713,	hprate = 1713,	score = 3,},
	[57] = {	Id = 56,	Name1 = [[黄
金
训
练
师]],	Name = [[黄金训练师]],	titlelv = 9,	atkrate = 1761,	hprate = 1737,	score = 3,},
	[58] = {	Id = 57,	Name1 = [[黄
金
训
练
师]],	Name = [[黄金训练师]],	titlelv = 9,	atkrate = 1785,	hprate = 1785,	score = 3,},
	[59] = {	Id = 58,	Name1 = [[卓
越
训
练
师]],	Name = [[卓越训练师]],	titlelv = 10,	atkrate = 1945,	hprate = 1945,	score = 3,},
	[60] = {	Id = 59,	Name1 = [[卓
越
训
练
师]],	Name = [[卓越训练师]],	titlelv = 10,	atkrate = 1997,	hprate = 1971,	score = 3,},
	[61] = {	Id = 60,	Name1 = [[卓
越
训
练
师]],	Name = [[卓越训练师]],	titlelv = 10,	atkrate = 2023,	hprate = 2023,	score = 3,},
	[62] = {	Id = 61,	Name1 = [[卓
越
训
练
师]],	Name = [[卓越训练师]],	titlelv = 10,	atkrate = 2075,	hprate = 2049,	score = 3,},
	[63] = {	Id = 62,	Name1 = [[首
席
训
练
师]],	Name = [[首席训练师]],	titlelv = 11,	atkrate = 2275,	hprate = 2275,	score = 3,},
	[64] = {	Id = 63,	Name1 = [[首
席
训
练
师]],	Name = [[首席训练师]],	titlelv = 11,	atkrate = 2331,	hprate = 2303,	score = 3,},
	[65] = {	Id = 64,	Name1 = [[首
席
训
练
师]],	Name = [[首席训练师]],	titlelv = 11,	atkrate = 2359,	hprate = 2359,	score = 3,},
	[66] = {	Id = 65,	Name1 = [[首
席
训
练
师]],	Name = [[首席训练师]],	titlelv = 11,	atkrate = 2415,	hprate = 2387,	score = 3,},
	[67] = {	Id = 66,	Name1 = [[王
牌
训
练
师]],	Name = [[王牌训练师]],	titlelv = 12,	atkrate = 2655,	hprate = 2655,	score = 3,},
	[68] = {	Id = 67,	Name1 = [[王
牌
训
练
师]],	Name = [[王牌训练师]],	titlelv = 12,	atkrate = 2715,	hprate = 2685,	score = 3,},
	[69] = {	Id = 68,	Name1 = [[王
牌
训
练
师]],	Name = [[王牌训练师]],	titlelv = 12,	atkrate = 2745,	hprate = 2745,	score = 3,},
	[70] = {	Id = 69,	Name1 = [[王
牌
训
练
师]],	Name = [[王牌训练师]],	titlelv = 12,	atkrate = 2805,	hprate = 2775,	score = 3,},
	[71] = {	Id = 70,	Name1 = [[梦
幻
训
练
家]],	Name = [[梦幻训练家]],	titlelv = 13,	atkrate = 3105,	hprate = 3105,	score = 3,},
	[72] = {	Id = 71,	Name1 = [[梦
幻
训
练
家]],	Name = [[梦幻训练家]],	titlelv = 13,	atkrate = 3169,	hprate = 3137,	score = 3,},
	[73] = {	Id = 72,	Name1 = [[梦
幻
训
练
家]],	Name = [[梦幻训练家]],	titlelv = 13,	atkrate = 3201,	hprate = 3201,	score = 3,},
	[74] = {	Id = 73,	Name1 = [[梦
幻
训
练
家]],	Name = [[梦幻训练家]],	titlelv = 13,	atkrate = 3265,	hprate = 3233,	score = 3,},
	[75] = {	Id = 74,	Name1 = [[史
诗
训
练
家]],	Name = [[史诗训练家]],	titlelv = 14,	atkrate = 3665,	hprate = 3665,	score = 3,},
	[76] = {	Id = 75,	Name1 = [[史
诗
训
练
家]],	Name = [[史诗训练家]],	titlelv = 14,	atkrate = 3733,	hprate = 3699,	score = 3,},
	[77] = {	Id = 76,	Name1 = [[史
诗
训
练
家]],	Name = [[史诗训练家]],	titlelv = 14,	atkrate = 3767,	hprate = 3767,	score = 3,},
	[78] = {	Id = 77,	Name1 = [[传
奇
训
练
家]],	Name = [[传奇训练家]],	titlelv = 15,	atkrate = 4301,	hprate = 4301,	score = 3,},
	[79] = {	Id = 78,	Name1 = [[传
奇
训
练
家]],	Name = [[传奇训练家]],	titlelv = 15,	atkrate = 4373,	hprate = 4337,	score = 3,},
	[80] = {	Id = 79,	Name1 = [[传
奇
训
练
家]],	Name = [[传奇训练家]],	titlelv = 15,	atkrate = 4409,	hprate = 4409,	score = 3,},
	[81] = {	Id = 80,	Name1 = [[天
选
之
人]],	Name = [[天选之人]],	titlelv = 16,	atkrate = 5045,	hprate = 5045,	score = 3,},
	[82] = {	Id = 81,	Name1 = [[天
选
之
人]],	Name = [[天选之人]],	titlelv = 16,	atkrate = 5095,	hprate = 5095,	score = 3,},
	[83] = {	Id = 82,	Name1 = [[天
选
之
人]],	Name = [[天选之人]],	titlelv = 16,	atkrate = 5145,	hprate = 5145,	score = 3,},
	[84] = {	Id = 83,	Name1 = [[传
说
勇
者]],	Name = [[传说勇者]],	titlelv = 17,	atkrate = 5845,	hprate = 5845,	score = 3,},
	[85] = {	Id = 84,	Name1 = [[传
说
勇
者]],	Name = [[传说勇者]],	titlelv = 17,	atkrate = 5895,	hprate = 5895,	score = 3,},
	[86] = {	Id = 85,	Name1 = [[传
说
勇
者]],	Name = [[传说勇者]],	titlelv = 17,	atkrate = 5945,	hprate = 5945,	score = 3,},
	[87] = {	Id = 86,	Name1 = [[新
界
探
索
者]],	Name = [[新界探索者]],	titlelv = 18,	atkrate = 6645,	hprate = 6645,	score = 3,},
	[88] = {	Id = 87,	Name1 = [[新
界
探
索
者]],	Name = [[新界探索者]],	titlelv = 18,	atkrate = 6695,	hprate = 6695,	score = 3,},
	[89] = {	Id = 88,	Name1 = [[新
界
探
索
者]],	Name = [[新界探索者]],	titlelv = 18,	atkrate = 6745,	hprate = 6745,	score = 3,},
	[90] = {	Id = 89,	Name1 = [[新
界
开
拓
者]],	Name = [[新界开拓者]],	titlelv = 19,	atkrate = 7445,	hprate = 7445,	score = 3,},
	[91] = {	Id = 90,	Name1 = [[新
界
开
拓
者]],	Name = [[新界开拓者]],	titlelv = 19,	atkrate = 7495,	hprate = 7495,	score = 3,},
	[92] = {	Id = 91,	Name1 = [[新
界
开
拓
者]],	Name = [[新界开拓者]],	titlelv = 19,	atkrate = 7545,	hprate = 7545,	score = 3,},
	[93] = {	Id = 92,	Name1 = [[希
望
追
寻
者]],	Name = [[希望追寻者]],	titlelv = 20,	atkrate = 8245,	hprate = 8245,	score = 3,},
	[94] = {	Id = 93,	Name1 = [[希
望
追
寻
者]],	Name = [[希望追寻者]],	titlelv = 20,	atkrate = 8295,	hprate = 8295,	score = 3,},
	[95] = {	Id = 94,	Name1 = [[希
望
追
寻
者]],	Name = [[希望追寻者]],	titlelv = 20,	atkrate = 8345,	hprate = 8345,	score = 3,},
	[96] = {	Id = 95,	Name1 = [[希
望
祈
愿
者]],	Name = [[希望祈愿者]],	titlelv = 21,	atkrate = 9045,	hprate = 9045,	score = 3,},
	[97] = {	Id = 96,	Name1 = [[希
望
祈
愿
者]],	Name = [[希望祈愿者]],	titlelv = 21,	atkrate = 9095,	hprate = 9095,	score = 3,},
	[98] = {	Id = 97,	Name1 = [[希
望
祈
愿
者]],	Name = [[希望祈愿者]],	titlelv = 21,	atkrate = 9145,	hprate = 9145,	score = 3,},
	[99] = {	Id = 98,	Name1 = [[圣
光
使
者]],	Name = [[圣光使者]],	titlelv = 22,	atkrate = 9845,	hprate = 9845,	score = 3,},
	[100] = {	Id = 99,	Name1 = [[圣
光
使
者]],	Name = [[圣光使者]],	titlelv = 22,	atkrate = 9895,	hprate = 9895,	score = 3,},
	[101] = {	Id = 100,	Name1 = [[圣
光
使
者]],	Name = [[圣光使者]],	titlelv = 22,	atkrate = 9945,	hprate = 9945,	score = 3,},
	[102] = {	Id = 101,	Name1 = [[圣
光
缔
造
者]],	Name = [[圣光缔造者]],	titlelv = 23,	atkrate = 10645,	hprate = 10645,	score = 3,},
	[103] = {	Id = 102,	Name1 = [[圣
光
缔
造
者]],	Name = [[圣光缔造者]],	titlelv = 23,	atkrate = 10695,	hprate = 10695,	score = 3,},
	[104] = {	Id = 103,	Name1 = [[圣
光
缔
造
者]],	Name = [[圣光缔造者]],	titlelv = 23,	atkrate = 10745,	hprate = 10745,	score = 3,},
	[105] = {	Id = 104,	Name1 = [[神
灵
庇
护
者]],	Name = [[神灵庇护者]],	titlelv = 24,	atkrate = 11445,	hprate = 11445,	score = 3,},
	[106] = {	Id = 105,	Name1 = [[神
灵
庇
护
者]],	Name = [[神灵庇护者]],	titlelv = 24,	atkrate = 11495,	hprate = 11495,	score = 3,},
	[107] = {	Id = 106,	Name1 = [[神
灵
庇
护
者]],	Name = [[神灵庇护者]],	titlelv = 24,	atkrate = 11545,	hprate = 11545,	score = 3,},
	[108] = {	Id = 107,	titlelv = 25,	atkrate = 12245,	hprate = 12245,	score = 3,},
}

return _table
