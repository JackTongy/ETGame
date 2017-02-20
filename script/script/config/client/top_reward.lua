--[[
	ID = 层数
Box1 = 宝箱1奖励内容
Box2 = 宝箱2奖励内容
Box3 = 宝箱3奖励内容
BattleCard = 每场战斗掉落装备卡数量
coinreward = 硬币奖励

--]]
local _table = {
	[1] = {	ID = 1,	Box1 = {38001,38002},	Box2 = {38003,38004},	Box3 = {38005,38006,39700},	BattleCard = {38007,39000},	coinreward = {50,60,300},},
	[2] = {	ID = 2,	Box1 = {38011,38012},	Box2 = {38013,38014},	Box3 = {38015,38016,39701},	BattleCard = {38017,39000},	coinreward = {50,60,300},},
	[3] = {	ID = 3,	Box1 = {38021,38022},	Box2 = {38023,38024},	Box3 = {38025,38026,39702},	BattleCard = {38027,39000},	coinreward = {50,60,300},},
	[4] = {	ID = 4,	Box1 = {38031,38032},	Box2 = {38033,38034},	Box3 = {38035,38036,39703},	BattleCard = {38037,39000},	coinreward = {50,60,300},},
	[5] = {	ID = 5,	Box1 = {38041,38042,39041},	Box2 = {38043,38044,39043},	Box3 = {38045,38046,39704},	BattleCard = {38047,39000},	coinreward = {50,60,300},},
	[6] = {	ID = 6,	Box1 = {38051,38052,39051},	Box2 = {38053,38054,39053},	Box3 = {38055,38056,39705},	BattleCard = {38057,39000},	coinreward = {50,60,300},},
	[7] = {	ID = 7,	Box1 = {38061,38062,39061},	Box2 = {38063,38064,39063},	Box3 = {38065,38066,39706},	BattleCard = {38067,39000},	coinreward = {50,60,300},},
	[8] = {	ID = 8,	Box1 = {38071,38072,39071},	Box2 = {38073,38074,39073},	Box3 = {38075,38076,39707},	BattleCard = {38077,39000},	coinreward = {50,60,300},},
	[9] = {	ID = 9,	Box1 = {38081,38082,39081},	Box2 = {38083,38084,39083},	Box3 = {38085,38086,39708},	BattleCard = {38087,39000},	coinreward = {50,60,300},},
	[10] = {	ID = 10,	Box1 = {38091,38092,39091,39092},	Box2 = {38093,38094,39093,39094},	Box3 = {38095,38096,39096,39709},	BattleCard = {38097,39000},	coinreward = {50,60,300},},
	[11] = {	ID = 11,	Box1 = {38101,38102,39101,39102},	Box2 = {38103,38104,39103,39104},	Box3 = {38105,38106,39106,39710},	BattleCard = {38107,39000},	coinreward = {50,60,300},},
	[12] = {	ID = 12,	Box1 = {38111,38112,39111,39112},	Box2 = {38113,38114,39113,39114},	Box3 = {38115,38116,39116,39711},	BattleCard = {38117,39000},	coinreward = {50,60,300},},
	[13] = {	ID = 13,	Box1 = {38121,38122,39121,39122},	Box2 = {38123,38124,39123,39124},	Box3 = {38125,38126,39126,39712},	BattleCard = {38127,39000},	coinreward = {50,60,300},},
	[14] = {	ID = 14,	Box1 = {38131,38132,39131,39132},	Box2 = {38133,38134,39133,39134},	Box3 = {38135,38136,39136,39713},	BattleCard = {38137,39000},	coinreward = {50,60,300},},
	[15] = {	ID = 15,	Box1 = {38141,38142,39141,39142},	Box2 = {38143,38144,39143,39144},	Box3 = {38145,38146,39146,39714},	BattleCard = {38147,39000},	coinreward = {50,60,300},},
	[16] = {	ID = 16,	Box1 = {38151,38152,39151,39152},	Box2 = {38153,38154,39153,39154},	Box3 = {38155,38156,39156,39715},	BattleCard = {38157,39000},	coinreward = {50,60,300},},
	[17] = {	ID = 17,	Box1 = {38161,38162,39161,39162},	Box2 = {38163,38164,39163,39164},	Box3 = {38165,38166,39166,39716},	BattleCard = {38167,39000},	coinreward = {50,60,300},},
	[18] = {	ID = 18,	Box1 = {38171,38172,39171,39172},	Box2 = {38173,38174,39173,39174},	Box3 = {38175,38176,39176,39717},	BattleCard = {38177,39000},	coinreward = {50,60,300},},
	[19] = {	ID = 19,	Box1 = {38181,38182,39181,39182},	Box2 = {38183,38184,39183,39184},	Box3 = {38185,38186,39186,39718},	BattleCard = {38187,39000},	coinreward = {50,60,300},},
	[20] = {	ID = 20,	Box1 = {38191,38192,39191,39192},	Box2 = {38193,38194,39193,39194},	Box3 = {38195,38196,39196,39719},	BattleCard = {38197,39000},	coinreward = {50,60,300},},
	[21] = {	ID = 21,	Box1 = {38201,38202,39201,39202},	Box2 = {38203,38204,39203,39204},	Box3 = {38205,38206,39206,39720},	BattleCard = {38207,39000},	coinreward = {50,60,300},},
	[22] = {	ID = 22,	Box1 = {38211,38212,39211,39212},	Box2 = {38213,38214,39213,39214},	Box3 = {38215,38216,39216,39721},	BattleCard = {38217,39000},	coinreward = {50,60,300},},
	[23] = {	ID = 23,	Box1 = {38221,38222,39221,39222},	Box2 = {38223,38224,39223,39224},	Box3 = {38225,38226,39226,39722},	BattleCard = {38227,39000},	coinreward = {50,60,300},},
	[24] = {	ID = 24,	Box1 = {38231,38232,39231,39232},	Box2 = {38233,38234,39233,39234},	Box3 = {38235,38236,39236,39723},	BattleCard = {38237,39000},	coinreward = {50,60,300},},
	[25] = {	ID = 25,	Box1 = {38241,38242,39241,39242},	Box2 = {38243,38244,39243,39244},	Box3 = {38245,38246,39246,39247,39724},	BattleCard = {38247,39000},	coinreward = {50,60,300},},
	[26] = {	ID = 26,	Box1 = {38251,38252,39251,39252},	Box2 = {38253,38254,39253,39254},	Box3 = {38255,38256,39256,39257,39725},	BattleCard = {38257,39000},	coinreward = {50,60,300},},
	[27] = {	ID = 27,	Box1 = {38261,38262,39261,39262},	Box2 = {38263,38264,39263,39264},	Box3 = {38265,38266,39266,39267,39726},	BattleCard = {38267,39000},	coinreward = {50,60,300},},
	[28] = {	ID = 28,	Box1 = {38271,38272,39271,39272},	Box2 = {38273,38274,39273,39274},	Box3 = {38275,38276,39276,39277,39727},	BattleCard = {38277,39000},	coinreward = {50,60,300},},
	[29] = {	ID = 29,	Box1 = {38281,38282,39281,39282},	Box2 = {38283,38284,39283,39284},	Box3 = {38285,38286,39286,39287,39728},	BattleCard = {38287,39000},	coinreward = {50,60,300},},
	[30] = {	ID = 30,	Box1 = {38291,38292,39291,39292},	Box2 = {38293,38294,39293,39294},	Box3 = {38295,38296,39296,39297,39729},	BattleCard = {38297,39000},	coinreward = {50,60,300},},
	[31] = {	ID = 31,	Box1 = {38301,38302,39301,39302},	Box2 = {38303,38304,39303,39304},	Box3 = {38305,38306,39306,39307,39730},	BattleCard = {38307,39000},	coinreward = {50,60,300},},
	[32] = {	ID = 32,	Box1 = {38311,38312,39311,39312},	Box2 = {38313,38314,39313,39314},	Box3 = {38315,38316,39316,39317,39731},	BattleCard = {38317,39000},	coinreward = {50,60,300},},
	[33] = {	ID = 33,	Box1 = {38321,38322,39321,39322},	Box2 = {38323,38324,39323,39324},	Box3 = {38325,38326,39326,39327,39732},	BattleCard = {38327,39000},	coinreward = {50,60,300},},
	[34] = {	ID = 34,	Box1 = {38331,38332,39331,39332},	Box2 = {38333,38334,39333,39334},	Box3 = {38335,38336,39336,39337,39733},	BattleCard = {38337,39000},	coinreward = {50,60,300},},
	[35] = {	ID = 35,	Box1 = {38341,38342,39341,39342},	Box2 = {38343,38344,39343,39344},	Box3 = {38345,38346,39346,39347,39734},	BattleCard = {38347,39000},	coinreward = {50,60,300},},
	[36] = {	ID = 36,	Box1 = {38351,38352,39351,39352},	Box2 = {38353,38354,39353,39354},	Box3 = {38355,38356,39356,39357,39735},	BattleCard = {38357,39000},	coinreward = {50,60,300},},
	[37] = {	ID = 37,	Box1 = {38361,38362,39361,39362},	Box2 = {38363,38364,39363,39364},	Box3 = {38365,38366,39366,39367,39736},	BattleCard = {38367,39000},	coinreward = {50,60,300},},
	[38] = {	ID = 38,	Box1 = {38371,38372,39371,39372},	Box2 = {38373,38374,39373,39374},	Box3 = {38375,38376,39376,39377,39737},	BattleCard = {38377,39000},	coinreward = {50,60,300},},
	[39] = {	ID = 39,	Box1 = {38381,38382,39381,39382},	Box2 = {38383,38384,39383,39384},	Box3 = {38385,38386,39386,39387,39738},	BattleCard = {38387,39000},	coinreward = {50,60,300},},
	[40] = {	ID = 40,	Box1 = {38391,38392,39391,39392},	Box2 = {38393,38394,39393,39394},	Box3 = {38395,38396,39396,39397,39739},	BattleCard = {38397,39000},	coinreward = {50,60,300},},
	[41] = {	ID = 41,	Box1 = {38401,38402,39401,39402},	Box2 = {38403,38404,39403,39404},	Box3 = {38405,38406,39406,39407,39740},	BattleCard = {38407,39000},	coinreward = {50,60,300},},
	[42] = {	ID = 42,	Box1 = {38411,38412,39411,39412},	Box2 = {38413,38414,39413,39414},	Box3 = {38415,38416,39416,39417,39741},	BattleCard = {38417,39000},	coinreward = {50,60,300},},
	[43] = {	ID = 43,	Box1 = {38421,38422,39421,39422},	Box2 = {38423,38424,39423,39424},	Box3 = {38425,38426,39426,39427,39742},	BattleCard = {38427,39000},	coinreward = {50,60,300},},
	[44] = {	ID = 44,	Box1 = {38431,38432,39431,39432},	Box2 = {38433,38434,39433,39434},	Box3 = {38435,38436,39436,39437,39743},	BattleCard = {38437,39000},	coinreward = {50,60,300},},
	[45] = {	ID = 45,	Box1 = {38441,38442,39441,39442},	Box2 = {38443,38444,39443,39444},	Box3 = {38445,38446,39446,39447,39448,39744,39820},	BattleCard = {38447,39000},	coinreward = {50,60,300},},
	[46] = {	ID = 46,	Box1 = {38451,38452,39451,39452},	Box2 = {38453,38454,39453,39454},	Box3 = {38455,38456,39456,39457,39458,39745,39821},	BattleCard = {38457,39000},	coinreward = {50,60,300},},
	[47] = {	ID = 47,	Box1 = {38461,38462,39461,39462},	Box2 = {38463,38464,39463,39464},	Box3 = {38465,38466,39466,39467,39468,39746,39822},	BattleCard = {38467,39000},	coinreward = {50,60,300},},
	[48] = {	ID = 48,	Box1 = {38471,38472,39471,39472},	Box2 = {38473,38474,39473,39474},	Box3 = {38475,38476,39476,39477,39478,39747,39823},	BattleCard = {38477,39000},	coinreward = {50,60,300},},
	[49] = {	ID = 49,	Box1 = {38481,38482,39481,39482},	Box2 = {38483,38484,39483,39484},	Box3 = {38485,38486,39486,39487,39488,39748,39824},	BattleCard = {38487,39000},	coinreward = {50,60,300},},
	[50] = {	ID = 50,	Box1 = {38491,38492,39491,39492},	Box2 = {38493,38494,39493,39494},	Box3 = {38495,38496,39496,39497,39498,39749,39825},	BattleCard = {38497,39000},	coinreward = {50,60,300},},
	[51] = {	ID = 51,	Box1 = {38501,38502,39501,39502},	Box2 = {38503,38504,39503,39504},	Box3 = {38505,38506,39506,39507,39508,39750,39826},	BattleCard = {38507,39000},	coinreward = {50,60,300},},
	[52] = {	ID = 52,	Box1 = {38511,38512,39511,39512},	Box2 = {38513,38514,39513,39514},	Box3 = {38515,38516,39516,39517,39518,39751,39827},	BattleCard = {38517,39000},	coinreward = {50,60,300},},
	[53] = {	ID = 53,	Box1 = {38521,38522,39521,39522},	Box2 = {38523,38524,39523,39524},	Box3 = {38525,38526,39526,39527,39528,39752,39828},	BattleCard = {38527,39000},	coinreward = {50,60,300},},
	[54] = {	ID = 54,	Box1 = {38531,38532,39531,39532},	Box2 = {38533,38534,39533,39534},	Box3 = {38535,38536,39536,39537,39538,39753,39829},	BattleCard = {38537,39000},	coinreward = {50,60,300},},
	[55] = {	ID = 55,	Box1 = {38541,38542,39541,39542},	Box2 = {38543,38544,39543,39544},	Box3 = {38545,38546,39546,39547,39548,39754,39830},	BattleCard = {38547,39000},	coinreward = {50,60,300},},
	[56] = {	ID = 56,	Box1 = {38551,38552,39551,39552},	Box2 = {38553,38554,39553,39554},	Box3 = {38555,38556,39556,39557,39558,39755,39831},	BattleCard = {38557,39000},	coinreward = {50,60,300},},
	[57] = {	ID = 57,	Box1 = {38561,38562,39561,39562},	Box2 = {38563,38564,39563,39564},	Box3 = {38565,38566,39566,39567,39568,39756,39832},	BattleCard = {38567,39000},	coinreward = {50,60,300},},
	[58] = {	ID = 58,	Box1 = {38571,38572,39571,39572},	Box2 = {38573,38574,39573,39574},	Box3 = {38575,38576,39576,39577,39578,39757,39833},	BattleCard = {38577,39000},	coinreward = {50,60,300},},
	[59] = {	ID = 59,	Box1 = {38581,38582,39581,39582},	Box2 = {38583,38584,39583,39584},	Box3 = {38585,38586,39586,39587,39588,39758,39834},	BattleCard = {38587,39000},	coinreward = {50,60,300},},
	[60] = {	ID = 60,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39759,39835},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[61] = {	ID = 61,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39760,39836},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[62] = {	ID = 62,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39761,39837},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[63] = {	ID = 63,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39762,39838},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[64] = {	ID = 64,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39763,39839},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[65] = {	ID = 65,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39764,39840},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[66] = {	ID = 66,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39765,39841},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[67] = {	ID = 67,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39766,39842},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[68] = {	ID = 68,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39767,39843},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[69] = {	ID = 69,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39768,39844},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[70] = {	ID = 70,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39769,39845,39896},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[71] = {	ID = 71,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39770,39846,39897},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[72] = {	ID = 72,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39771,39847,39898},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[73] = {	ID = 73,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39772,39848,39899},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[74] = {	ID = 74,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39773,39849,39900},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[75] = {	ID = 75,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39774,39850,39901},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[76] = {	ID = 76,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39775,39851,39902},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[77] = {	ID = 77,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39776,39852,39903},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[78] = {	ID = 78,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39777,39853,39904},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[79] = {	ID = 79,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39778,39854,39905},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[80] = {	ID = 80,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39779,39855,39906},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[81] = {	ID = 81,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39780,39856,39907},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[82] = {	ID = 82,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39781,39857,39908},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[83] = {	ID = 83,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39782,39858,39909},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[84] = {	ID = 84,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39783,39859,39910},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[85] = {	ID = 85,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39784,39860,39911},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[86] = {	ID = 86,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39785,39861,39912},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[87] = {	ID = 87,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39786,39862,39913},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[88] = {	ID = 88,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39787,39863,39914},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[89] = {	ID = 89,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39788,39864,39915},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[90] = {	ID = 90,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39789,39865,39916},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[91] = {	ID = 91,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39790,39866,39917},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[92] = {	ID = 92,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39791,39867,39918},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[93] = {	ID = 93,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39792,39868,39919},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[94] = {	ID = 94,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39793,39869,39920},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[95] = {	ID = 95,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39794,39870,39921},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[96] = {	ID = 96,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39795,39871,39922},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[97] = {	ID = 97,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39796,39872,39923},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[98] = {	ID = 98,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39797,39873,39924},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[99] = {	ID = 99,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39798,39874,39925},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[100] = {	ID = 100,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39799,39875,39926},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[101] = {	ID = 101,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39800,39876,39927},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[102] = {	ID = 102,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39801,39877,39928},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[103] = {	ID = 103,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39802,39878,39929},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[104] = {	ID = 104,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39803,39879,39930},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[105] = {	ID = 105,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39804,39880,39931},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[106] = {	ID = 106,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39805,39881,39932},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[107] = {	ID = 107,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39806,39882,39933},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[108] = {	ID = 108,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39807,39883,39934},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[109] = {	ID = 109,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39808,39884,39935},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[110] = {	ID = 110,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39809,39885,39936},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[111] = {	ID = 111,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39810,39886,39937},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[112] = {	ID = 112,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39811,39887,39938},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[113] = {	ID = 113,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39812,39888,39939},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[114] = {	ID = 114,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39813,39889,39940},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[115] = {	ID = 115,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39814,39890,39941},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[116] = {	ID = 116,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39815,39891,39942},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[117] = {	ID = 117,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39816,39892,39943},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[118] = {	ID = 118,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39817,39893,39944},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[119] = {	ID = 119,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39818,39894,39945},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
	[120] = {	ID = 120,	Box1 = {38591,38592,39591,39592},	Box2 = {38593,38594,39593,39594},	Box3 = {38595,38596,39596,39597,39598,39819,39895,39946},	BattleCard = {38597,39000},	coinreward = {50,60,300},},
}

return _table
