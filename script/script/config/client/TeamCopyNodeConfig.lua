--[[
	Id = Id
TownPicName = 据点图片
Type = 难度区域
Nexts = 相邻的点
Position = 地图坐标
Boss = Boss点
index = 据点编号

--]]
local _table = {
	[1] = {	Id = 1,	TownPicName = [[CD_alufuyiji.png]],	Type = 1,	Nexts = {4},	Position = {205,907},	Boss = 0,	index = 1,},
	[2] = {	Id = 2,	TownPicName = [[CD_bingzhimigong.png]],	Type = 1,	Nexts = {8},	Position = {1463,126},	Boss = 0,	index = 2,},
	[3] = {	Id = 3,	TownPicName = [[CD_fengnugudi.png]],	Type = 1,	Nexts = {11},	Position = {1799,907},	Boss = 0,	index = 3,},
	[4] = {	Id = 4,	TownPicName = [[CD_guanghuihaian.png]],	Type = 1,	Nexts = {1,5,13},	Position = {445,801},	Boss = 0,	index = 4,},
	[5] = {	Id = 5,	TownPicName = [[CD_jinglingshenshe.png]],	Type = 1,	Nexts = {4,6,14},	Position = {255,613},	Boss = 0,	index = 5,},
	[6] = {	Id = 6,	TownPicName = [[CD_juxingjingjichang.png]],	Type = 1,	Nexts = {5,7,15},	Position = {398,289},	Boss = 0,	index = 6,},
	[7] = {	Id = 7,	TownPicName = [[CD_leibengucheng.png]],	Type = 1,	Nexts = {6,8,16},	Position = {715,236},	Boss = 0,	index = 7,},
	[8] = {	Id = 8,	TownPicName = [[CD_linlinta.png]],	Type = 1,	Nexts = {2,7,9,16},	Position = {1213,157},	Boss = 0,	index = 8,},
	[9] = {	Id = 9,	TownPicName = [[CD_longzhigu.png]],	Type = 1,	Nexts = {8,10,16,17},	Position = {1470,303},	Boss = 0,	index = 9,},
	[10] = {	Id = 10,	TownPicName = [[CD_ruoyezhen.png]],	Type = 1,	Nexts = {9,11},	Position = {1834,540},	Boss = 0,	index = 10,},
	[11] = {	Id = 11,	TownPicName = [[CD_shaojiaota.png]],	Type = 1,	Nexts = {3,10,12},	Position = {1564,779},	Boss = 0,	index = 11,},
	[12] = {	Id = 12,	TownPicName = [[CD_xuanwoliedao.png]],	Type = 1,	Nexts = {11,13,18},	Position = {1162,907},	Boss = 0,	index = 12,},
	[13] = {	Id = 13,	TownPicName = [[CD_zhanlanshi.png]],	Type = 1,	Nexts = {4,12},	Position = {715,907},	Boss = 0,	index = 13,},
	[14] = {	Id = 14,	TownPicName = [[HZ_gulingmaigudi.png]],	Type = 1,	Nexts = {5,15,18},	Position = {690,656},	Boss = 0,	index = 14,},
	[15] = {	Id = 15,	TownPicName = [[HZ_luoxuanshan.png]],	Type = 1,	Nexts = {6,14,19},	Position = {659,422},	Boss = 0,	index = 15,},
	[16] = {	Id = 16,	TownPicName = [[HZ_menghuanyiji.png]],	Type = 1,	Nexts = {7,8,9,19},	Position = {1002,294},	Boss = 0,	index = 16,},
	[17] = {	Id = 17,	TownPicName = [[HZ_zhongguojuyuan.png]],	Type = 1,	Nexts = {9,18,19},	Position = {1486,550},	Boss = 0,	index = 17,},
	[18] = {	Id = 18,	TownPicName = [[HZ_tianzhijianqiao.png]],	Type = 1,	Nexts = {12,14,17,19},	Position = {1024,738},	Boss = 0,	index = 18,},
	[19] = {	Id = 19,	TownPicName = [[HZ_shichesenlin.png]],	Type = 1,	Nexts = {15,16,17,18},	Position = {1094,473},	Boss = 1,	index = 19,},
	[20] = {	Id = 20,	TownPicName = [[SA_daofengxueyuan.png]],	Type = 2,	Nexts = {4},	Position = {558,618},	Boss = 0,	index = 1,},
	[21] = {	Id = 21,	TownPicName = [[SA_dashidi.png]],	Type = 2,	Nexts = {7},	Position = {1111,110},	Boss = 0,	index = 2,},
	[22] = {	Id = 22,	TownPicName = [[SA_gangtieshanmai.png]],	Type = 2,	Nexts = {11,12},	Position = {2474,847},	Boss = 0,	index = 3,},
	[23] = {	Id = 23,	TownPicName = [[SA_gangtietankeng.png]],	Type = 2,	Nexts = {1,5,13},	Position = {836,719},	Boss = 0,	index = 4,},
	[24] = {	Id = 24,	TownPicName = [[SA_guanjunzhilu.png]],	Type = 2,	Nexts = {4,6,15},	Position = {905,495},	Boss = 0,	index = 5,},
	[25] = {	Id = 25,	TownPicName = [[SA_huahai.png]],	Type = 2,	Nexts = {5,7,16},	Position = {1107,315},	Boss = 0,	index = 6,},
	[26] = {	Id = 26,	TownPicName = [[SA_huazhileyuan.png]],	Type = 2,	Nexts = {2,6,8},	Position = {1352,226},	Boss = 0,	index = 7,},
	[27] = {	Id = 27,	TownPicName = [[SA_juewangzhiyan.png]],	Type = 2,	Nexts = {7,9,17},	Position = {1701,125},	Boss = 0,	index = 8,},
	[28] = {	Id = 28,	TownPicName = [[SA_manyuedao.png]],	Type = 2,	Nexts = {8,10},	Position = {1986,195},	Boss = 0,	index = 9,},
	[29] = {	Id = 29,	TownPicName = [[SA_mihuandongku.png]],	Type = 2,	Nexts = {9,11,17},	Position = {2292,450},	Boss = 0,	index = 10,},
	[30] = {	Id = 30,	TownPicName = [[SA_mishizhita.png]],	Type = 2,	Nexts = {3,10,12,18},	Position = {2087,604},	Boss = 0,	index = 11,},
	[31] = {	Id = 31,	TownPicName = [[SA_qiangzhu.png]],	Type = 2,	Nexts = {3,11,13},	Position = {1912,826},	Boss = 0,	index = 12,},
	[32] = {	Id = 32,	TownPicName = [[SA_shichesenlin.png]],	Type = 2,	Nexts = {4,12,14},	Position = {1062,880},	Boss = 0,	index = 13,},
	[33] = {	Id = 33,	TownPicName = [[SA_shunagyezhen.png]],	Type = 2,	Nexts = {13,15,18,19},	Position = {1279,731},	Boss = 0,	index = 14,},
	[34] = {	Id = 34,	TownPicName = [[SA_yangguanghaitan.png]],	Type = 2,	Nexts = {5,14,16},	Position = {1217,503},	Boss = 0,	index = 15,},
	[35] = {	Id = 35,	TownPicName = [[SA_yankushan.png]],	Type = 2,	Nexts = {6,17,19},	Position = {1472,351},	Boss = 0,	index = 16,},
	[36] = {	Id = 36,	TownPicName = [[SA_yinquanzhilu.png]],	Type = 2,	Nexts = {8,10,16,18},	Position = {1701,469},	Boss = 0,	index = 17,},
	[37] = {	Id = 37,	TownPicName = [[GD_guanjunzhilu.png]],	Type = 2,	Nexts = {11,14,17,19},	Position = {1632,717},	Boss = 0,	index = 18,},
	[38] = {	Id = 38,	TownPicName = [[GD_hualandongxue.png]],	Type = 2,	Nexts = {14,16,18},	Position = {1491,570},	Boss = 1,	index = 19,},
}

return _table
