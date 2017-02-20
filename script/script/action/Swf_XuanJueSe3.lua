

local _table = {}

_table.stage = {}
_table.stage.maxF = 195
_table.stage.fps = 24
_table.stage.size = {1136, 640}

--_table.shapeMap = {}
--_table.shapeMap['shape-2'] = {1136, 640}
--_table.shapeMap['shape-4'] = {1136, 640}
--_table.shapeMap['shape-6'] = {1136, 640}
--_table.shapeMap['shape-8'] = {1136, 640}
--_table.shapeMap['shape-10'] = {1720, 640}
--_table.shapeMap['shape-12'] = {1136, 640}
--_table.shapeMap['shape-14'] = {1136, 640}
--_table.shapeMap['shape-16'] = {1136, 640}
--_table.shapeMap['shape-18'] = {1136, 640}
--_table.shapeMap['shape-20'] = {1136, 640}
--_table.shapeMap['shape-22'] = {1136, 640}
--_table.shapeMap['shape-24'] = {1214, 684}
--_table.shapeMap['shape-26'] = {1136, 640}
--_table.shapeMap['shape-28'] = {1136, 640}
--_table.shapeMap['shape-30'] = {1136, 640}

_table.array = {}

----- depth = 1 -----
_table.array[1] = {
	[1] = { f = 1},
	[2] = { f = 2},
}

----- depth = 2 -----
_table.array[2] = {
	[1] = { f = 59,	p = {-83.70, 0.00},	s = {1.00, 1.00},	r = 0.00,	a = 0,	c = {255, 255, 255},	i = 'shape-10',	ar = {0.33, 0.50},	v = true },
	[2] = { f = 60,	a = 5 },
	[3] = { f = 61,	a = 21 },
	[4] = { f = 62,	a = 47 },
	[5] = { f = 63,	a = 84 },
	[6] = { f = 64,	a = 131 },
	[7] = { f = 65,	a = 188 },
	[8] = { f = 66,	a = 255 },
	[9] = { f = 95,	p = {-108.85, 0.00} },
	[10] = { f = 96,	p = {-184.30, 0.00} },
	[11] = { f = 97,	p = {-310.00, 0.00} },
	[12] = { f = 98,	p = {-319.30, 0.00} },
	[13] = { f = 99,	p = {-313.10, 0.00} },
	[14] = { f = 124,	p = {-370.30, 0.00} },
	[15] = { f = 125,	p = {-427.50, 0.00} },
	[16] = { f = 126,	p = {-484.70, 0.00} },
	[17] = { f = 127,	p = {-463.25, 0.00} },
	[18] = { f = 128,	p = {-469.10, 0.00} },
	[19] = { f = 152,	p = {-453.15, 0.00} },
	[20] = { f = 153,	p = {-405.25, 0.00} },
	[21] = { f = 154,	p = {-325.40, 0.00} },
	[22] = { f = 155,	p = {-213.65, 0.00} },
	[23] = { f = 156,	p = {-203.90, 0.00} },
	[24] = { f = 157,	p = {-194.15, 0.00} },
	[25] = { f = 182,	c = {251, 251, 251},	c2 = {5, 5, 5, 0} },
	[26] = { f = 183,	c = {235, 235, 235},	c2 = {21, 21, 21, 0} },
	[27] = { f = 184,	c = {209, 209, 209},	c2 = {47, 47, 47, 0} },
	[28] = { f = 185,	c = {172, 172, 172},	c2 = {83, 83, 83, 0} },
	[29] = { f = 186,	c = {125, 125, 125},	c2 = {130, 130, 130, 0} },
	[30] = { f = 187,	c = {68, 68, 68},	c2 = {187, 187, 187, 0} },
	[31] = { f = 188,	c = {0, 0, 0},	c2 = {255, 255, 255, 0} },
	[32] = { f = 189,	v = false },
}

----- depth = 3 -----
_table.array[3] = {
	[1] = { f = 1,	p = {0.00, 639.60},	s = {1.00, 1.00},	r = 0.00,	a = 255,	c = {255, 255, 255},	i = 'shape-4',	ar = {0.50, 0.50},	v = true },
	[2] = { f = 2,	c = {192, 192, 192},	c2 = {64, 64, 64, 0} },
	[3] = { f = 3,	c = {128, 128, 128},	c2 = {128, 128, 128, 0} },
	[4] = { f = 4,	c = {64, 64, 64},	c2 = {191, 191, 191, 0} },
	[5] = { f = 5,	c = {0, 0, 0},	c2 = {255, 255, 255, 0} },
	[6] = { f = 6,	p = {0.00, 278.85},	c = {142, 142, 142},	c2 = {113, 113, 113, 0} },
	[7] = { f = 7,	p = {0.00, 62.40},	c = {228, 228, 228},	c2 = {28, 28, 28, 0} },
	[8] = { f = 8,	p = {0.00, -9.75},	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[9] = { f = 9,	p = {0.00, 3.90} },
	[10] = { f = 10,	p = {0.00, -1.95} },
	[11] = { f = 11,	p = {0.00, 0.00} },
	[12] = { f = 20,	c = {141, 141, 141},	c2 = {115, 115, 115, 0} },
	[13] = { f = 21,	c = {157, 157, 157},	c2 = {99, 99, 99, 0} },
	[14] = { f = 22,	c = {174, 174, 174},	c2 = {82, 82, 82, 0} },
	[15] = { f = 23,	c = {190, 190, 190},	c2 = {66, 66, 66, 0} },
	[16] = { f = 24,	c = {207, 207, 207},	c2 = {49, 49, 49, 0} },
	[17] = { f = 25,	c = {223, 223, 223},	c2 = {33, 33, 33, 0} },
	[18] = { f = 26,	c = {240, 240, 240},	c2 = {16, 16, 16, 0} },
	[19] = { f = 27,	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[20] = { f = 57,	p = {-81.90, 0.00},	c = {239, 239, 239} },
	[21] = { f = 58,	p = {-163.80, 0.00},	c = {222, 222, 222} },
	[22] = { f = 59,	p = {-245.70, 0.00},	c = {205, 205, 205} },
	[23] = { f = 60,	p = {-234.00, 0.00},	c = {255, 255, 255} },
	[24] = { f = 61,	p = {-241.80, 0.00} },
	[25] = { f = 114,	p = {-238.70, 0.00},	s = {1.02, 1.02} },
	[26] = { f = 115,	p = {-238.70, -36.05} },
	[27] = { f = 116,	p = {-238.70, -144.15} },
	[28] = { f = 118,	p = {-238.70, 296.75},	c = {114, 114, 114},	c2 = {142, 142, 142, 0} },
	[29] = { f = 119,	p = {-238.70, 561.30},	c = {28, 28, 28},	c2 = {227, 227, 227, 0} },
	[30] = { f = 120,	p = {-238.70, 649.50},	c = {0, 0, 0},	c2 = {255, 255, 255, 0} },
	[31] = { f = 152,	p = {-93.65, 649.50},	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[32] = { f = 153,	p = {9.95, 649.50} },
	[33] = { f = 154,	p = {72.10, 649.50} },
	[34] = { f = 155,	p = {92.80, 649.50} },
	[35] = { f = 182,	p = {92.75, 649.50} },
	[36] = { f = 188,	p = {92.80, 649.50} },
	[37] = { f = 189,	v = false },
}

----- depth = 4 -----
_table.array[4] = {
	[1] = { f = 1,	p = {0.00, -641.55},	s = {1.00, 1.00},	r = 0.00,	a = 255,	c = {255, 255, 255},	i = 'shape-6',	ar = {0.50, 0.50},	v = true },
	[2] = { f = 2,	c = {219, 219, 219},	c2 = {36, 36, 36, 0} },
	[3] = { f = 3,	c = {183, 183, 183},	c2 = {73, 73, 73, 0} },
	[4] = { f = 4,	c = {146, 146, 146},	c2 = {109, 109, 109, 0} },
	[5] = { f = 5,	c = {110, 110, 110},	c2 = {146, 146, 146, 0} },
	[6] = { f = 6,	c = {73, 73, 73},	c2 = {182, 182, 182, 0} },
	[7] = { f = 7,	c = {37, 37, 37},	c2 = {219, 219, 219, 0} },
	[8] = { f = 8,	c = {0, 0, 0},	c2 = {255, 255, 255, 0} },
	[9] = { f = 9,	p = {0.00, -280.80},	c = {142, 142, 142},	c2 = {113, 113, 113, 0} },
	[10] = { f = 10,	p = {0.00, -64.35},	c = {228, 228, 228},	c2 = {28, 28, 28, 0} },
	[11] = { f = 11,	p = {0.00, 7.80},	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[12] = { f = 12,	p = {0.00, -3.90} },
	[13] = { f = 13,	p = {0.00, 3.90} },
	[14] = { f = 14,	p = {0.00, 0.00} },
	[15] = { f = 23,	c = {141, 141, 141},	c2 = {115, 115, 115, 0} },
	[16] = { f = 24,	c = {157, 157, 157},	c2 = {99, 99, 99, 0} },
	[17] = { f = 25,	c = {174, 174, 174},	c2 = {82, 82, 82, 0} },
	[18] = { f = 26,	c = {190, 190, 190},	c2 = {66, 66, 66, 0} },
	[19] = { f = 27,	c = {207, 207, 207},	c2 = {49, 49, 49, 0} },
	[20] = { f = 28,	c = {223, 223, 223},	c2 = {33, 33, 33, 0} },
	[21] = { f = 29,	c = {240, 240, 240},	c2 = {16, 16, 16, 0} },
	[22] = { f = 30,	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[23] = { f = 60,	p = {-90.35, 0.00},	c = {239, 239, 239} },
	[24] = { f = 61,	p = {-180.70, 0.00},	c = {222, 222, 222} },
	[25] = { f = 62,	p = {-271.05, 0.00},	c = {205, 205, 205} },
	[26] = { f = 63,	p = {-261.30, 0.00},	c = {255, 255, 255} },
	[27] = { f = 64,	p = {-267.15, 0.00} },
	[28] = { f = 85,	s = {1.04, 1.04} },
	[29] = { f = 86,	p = {-267.15, -34.15},	s = {1.03, 1.03} },
	[30] = { f = 87,	p = {-267.15, -136.50} },
	[31] = { f = 89,	p = {-267.15, 295.75},	c = {114, 114, 114},	c2 = {142, 142, 142, 0} },
	[32] = { f = 90,	p = {-267.15, 555.10},	c = {28, 28, 28},	c2 = {227, 227, 227, 0} },
	[33] = { f = 91,	p = {-267.15, 641.55},	c = {0, 0, 0},	c2 = {255, 255, 255, 0} },
	[34] = { f = 123,	p = {591.05, 1.65},	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[35] = { f = 124,	p = {425.30, 1.65},	c = {103, 103, 103},	c2 = {128, 128, 128, 0} },
	[36] = { f = 125,	p = {259.55, 1.65},	c = {205, 205, 205},	c2 = {0, 0, 0, 0} },
	[37] = { f = 126,	p = {271.25, 1.65},	c = {255, 255, 255} },
	[38] = { f = 127,	p = {265.40, 1.65} },
	[39] = { f = 152,	p = {445.40, 1.65} },
	[40] = { f = 153,	p = {574.00, 1.65} },
	[41] = { f = 154,	p = {651.15, 1.65} },
	[42] = { f = 155,	p = {676.85, 1.65} },
	[43] = { f = 182,	c = {201, 201, 201},	c2 = {5, 5, 5, 0} },
	[44] = { f = 183,	c = {188, 188, 188},	c2 = {21, 21, 21, 0} },
	[45] = { f = 184,	c = {167, 167, 167},	c2 = {47, 47, 47, 0} },
	[46] = { f = 185,	c = {138, 138, 138},	c2 = {83, 83, 83, 0} },
	[47] = { f = 186,	c = {100, 100, 100},	c2 = {130, 130, 130, 0} },
	[48] = { f = 187,	c = {54, 54, 54},	c2 = {187, 187, 187, 0} },
	[49] = { f = 188,	c = {0, 0, 0},	c2 = {255, 255, 255, 0} },
	[50] = { f = 189,	v = false },
}

----- depth = 5 -----
_table.array[5] = {
	[1] = { f = 1,	p = {0.00, 639.60},	s = {1.00, 1.00},	r = 0.00,	a = 0,	c = {255, 255, 255},	i = 'shape-8',	ar = {0.50, 0.50},	v = true },
	[2] = { f = 2,	a = 26,	c = {230, 230, 230},	c2 = {26, 26, 26, 0} },
	[3] = { f = 3,	a = 51,	c = {205, 205, 205},	c2 = {51, 51, 51, 0} },
	[4] = { f = 4,	a = 77,	c = {179, 179, 179},	c2 = {77, 77, 77, 0} },
	[5] = { f = 5,	a = 102,	c = {154, 154, 154},	c2 = {102, 102, 102, 0} },
	[6] = { f = 6,	a = 128,	c = {128, 128, 128},	c2 = {128, 128, 128, 0} },
	[7] = { f = 7,	a = 154,	c = {102, 102, 102},	c2 = {153, 153, 153, 0} },
	[8] = { f = 8,	a = 179,	c = {77, 77, 77},	c2 = {178, 178, 178, 0} },
	[9] = { f = 9,	a = 205,	c = {51, 51, 51},	c2 = {204, 204, 204, 0} },
	[10] = { f = 10,	a = 230,	c = {26, 26, 26},	c2 = {229, 229, 229, 0} },
	[11] = { f = 11,	a = 255,	c = {0, 0, 0},	c2 = {255, 255, 255, 0} },
	[12] = { f = 12,	p = {0.00, 279.95},	c = {142, 142, 142},	c2 = {113, 113, 113, 0} },
	[13] = { f = 13,	p = {0.00, 64.15},	c = {228, 228, 228},	c2 = {28, 28, 28, 0} },
	[14] = { f = 14,	p = {0.00, -7.80},	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[15] = { f = 15,	p = {0.00, 0.00} },
	[16] = { f = 16,	p = {0.00, -5.85} },
	[17] = { f = 17,	p = {0.00, 0.00} },
	[18] = { f = 25,	c = {141, 141, 141},	c2 = {115, 115, 115, 0} },
	[19] = { f = 26,	c = {155, 155, 155},	c2 = {101, 101, 101, 0} },
	[20] = { f = 27,	c = {170, 170, 170},	c2 = {86, 86, 86, 0} },
	[21] = { f = 28,	c = {184, 184, 184},	c2 = {72, 72, 72, 0} },
	[22] = { f = 29,	c = {199, 199, 199},	c2 = {58, 58, 58, 0} },
	[23] = { f = 30,	c = {213, 213, 213},	c2 = {43, 43, 43, 0} },
	[24] = { f = 31,	c = {227, 227, 227},	c2 = {29, 29, 29, 0} },
	[25] = { f = 32,	c = {242, 242, 242},	c2 = {14, 14, 14, 0} },
	[26] = { f = 33,	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[27] = { f = 50,	p = {-11.70, 0.00},	s = {1.04, 1.04},	c = {246, 246, 246},	c2 = {10, 10, 10, 0} },
	[28] = { f = 51,	p = {-11.70, -12.70},	c = {231, 231, 231},	c2 = {25, 25, 25, 0} },
	[29] = { f = 52,	p = {-11.70, -50.70},	c = {184, 184, 184},	c2 = {71, 71, 71, 0} },
	[30] = { f = 54,	p = {-11.70, 183.95},	c = {123, 123, 123},	c2 = {132, 132, 132, 0} },
	[31] = { f = 55,	p = {-11.70, 418.60},	c = {61, 61, 61},	c2 = {194, 194, 194, 0} },
	[32] = { f = 56,	p = {-11.70, 653.25},	c = {0, 0, 0},	c2 = {255, 255, 255, 0} },
	[33] = { f = 94,	p = {468.15, 1.05},	s = {1.00, 1.00},	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[34] = { f = 95,	p = {354.10, 1.05},	c = {103, 103, 103},	c2 = {128, 128, 128, 0} },
	[35] = { f = 96,	p = {240.00, 1.05},	c = {205, 205, 205},	c2 = {0, 0, 0, 0} },
	[36] = { f = 97,	p = {247.80, 1.05},	c = {255, 255, 255} },
	[37] = { f = 98,	p = {243.90, 1.05} },
	[38] = { f = 152,	p = {423.90, 1.05} },
	[39] = { f = 153,	p = {552.50, 1.05} },
	[40] = { f = 154,	p = {629.65, 1.05} },
	[41] = { f = 155,	p = {655.35, 1.05} },
	[42] = { f = 182,	c = {201, 201, 201},	c2 = {5, 5, 5, 0} },
	[43] = { f = 183,	c = {188, 188, 188},	c2 = {21, 21, 21, 0} },
	[44] = { f = 184,	c = {167, 167, 167},	c2 = {47, 47, 47, 0} },
	[45] = { f = 185,	c = {138, 138, 138},	c2 = {83, 83, 83, 0} },
	[46] = { f = 186,	c = {100, 100, 100},	c2 = {130, 130, 130, 0} },
	[47] = { f = 187,	c = {54, 54, 54},	c2 = {187, 187, 187, 0} },
	[48] = { f = 188,	c = {0, 0, 0},	c2 = {255, 255, 255, 0} },
	[49] = { f = 189,	v = false },
}

----- depth = 6 -----
_table.array[12] = {
	[1] = { f = 64,	p = {-74.40, 640.00},	s = {1.00, 1.00},	r = 0.00,	a = 255,	c = {0, 0, 0},	c2 = {255, 255, 255, 0},	i = 'shape-12',	ar = {0.50, 0.50},	v = true },
	[2] = { f = 65,	p = {-18.60, 151.20},	c = {192, 192, 192},	c2 = {64, 64, 64, 0} },
	[3] = { f = 66,	p = {0.00, -11.70},	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[4] = { f = 67,	p = {0.00, 3.90} },
	[5] = { f = 68,	p = {0.00, -3.90} },
	[6] = { f = 92,	p = {0.00, 472.85},	c = {64, 64, 64},	c2 = {191, 191, 191, 0} },
	[7] = { f = 93,	p = {0.00, 631.80},	c = {0, 0, 0},	c2 = {255, 255, 255, 0} },
	[8] = { f = 152,	p = {145.05, 631.80},	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[9] = { f = 153,	p = {248.65, 631.80} },
	[10] = { f = 154,	p = {310.80, 631.80} },
	[11] = { f = 155,	p = {331.50, 631.80} },
	[12] = { f = 189,	v = false },
}

----- depth = 7 -----
_table.array[13] = {
	[1] = { f = 66,	p = {0.00, -384.15},	s = {1.00, 1.00},	r = 0.00,	a = 255,	c = {0, 0, 0},	c2 = {255, 255, 255, 0},	i = 'shape-14',	ar = {0.50, 0.50},	v = true },
	[2] = { f = 67,	p = {0.00, -91.65},	c = {192, 192, 192},	c2 = {64, 64, 64, 0} },
	[3] = { f = 68,	p = {0.00, 5.85},	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[4] = { f = 69,	p = {0.00, -3.90} },
	[5] = { f = 70,	p = {0.00, 0.00} },
	[6] = { f = 93,	p = {0.00, -292.50},	c = {64, 64, 64},	c2 = {191, 191, 191, 0} },
	[7] = { f = 94,	p = {0.00, -390.00},	c = {0, 0, 0},	c2 = {255, 255, 255, 0} },
	[8] = { f = 152,	p = {145.05, -390.00},	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[9] = { f = 153,	p = {248.65, -390.00} },
	[10] = { f = 154,	p = {310.80, -390.00} },
	[11] = { f = 155,	p = {331.50, -390.00} },
	[12] = { f = 189,	v = false },
}

----- depth = 8 -----
_table.array[14] = {
	[1] = { f = 68,	p = {276.90, 0.00},	s = {1.00, 1.00},	r = 0.00,	a = 255,	c = {255, 255, 255},	i = 'shape-16',	ar = {0.50, 0.50},	v = true },
	[2] = { f = 69,	p = {134.55, 0.00} },
	[3] = { f = 70,	p = {-7.80, 0.00} },
	[4] = { f = 71,	p = {3.90, 0.00} },
	[5] = { f = 72,	p = {0.00, 0.00} },
	[6] = { f = 94,	p = {210.60, 0.00},	c = {64, 64, 64},	c2 = {191, 191, 191, 0} },
	[7] = { f = 95,	p = {280.80, 0.00},	c = {0, 0, 0},	c2 = {255, 255, 255, 0} },
	[8] = { f = 152,	p = {425.85, 0.00},	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[9] = { f = 153,	p = {529.45, 0.00} },
	[10] = { f = 154,	p = {591.60, 0.00} },
	[11] = { f = 155,	p = {612.30, 0.00} },
	[12] = { f = 189,	v = false },
}

----- depth = 9 -----
_table.array[9] = {
	[1] = { f = 98,	p = {-525.10, 960.00},	s = {1.00, 1.00},	r = 0.00,	a = 255,	c = {0, 0, 0},	c2 = {255, 255, 255, 0},	i = 'shape-18',	ar = {0.00, 1.00},	v = true },
	[2] = { f = 99,	p = {-524.10, 632.40},	c = {128, 128, 128},	c2 = {128, 128, 128, 0} },
	[3] = { f = 100,	p = {-523.15, 304.80},	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[4] = { f = 101,	p = {-523.15, 334.05} },
	[5] = { f = 102,	p = {-523.15, 320.40} },
	[6] = { f = 121,	p = {-524.60, 800.10},	c = {64, 64, 64},	c2 = {191, 191, 191, 0} },
	[7] = { f = 122,	p = {-525.10, 960.00},	c = {0, 0, 0},	c2 = {255, 255, 255, 0} },
	[8] = { f = 152,	p = {-380.05, 960.00},	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[9] = { f = 153,	p = {-276.45, 960.00} },
	[10] = { f = 154,	p = {-214.30, 960.00} },
	[11] = { f = 155,	p = {-193.60, 960.00} },
	[12] = { f = 189,	v = false },
}

----- depth = 10 -----
_table.array[10] = {
	[1] = { f = 100,	p = {-188.00, -389.60},	s = {1.00, 1.00},	r = 0.00,	a = 255,	c = {255, 255, 255},	i = 'shape-20',	ar = {0.50, 0.50},	v = true },
	[2] = { f = 101,	p = {-188.00, -190.70} },
	[3] = { f = 102,	p = {-188.00, 8.20} },
	[4] = { f = 103,	p = {-188.00, -5.45} },
	[5] = { f = 104,	p = {-188.00, -1.55} },
	[6] = { f = 122,	p = {-188.00, -292.60},	c = {64, 64, 64},	c2 = {191, 191, 191, 0} },
	[7] = { f = 123,	p = {-188.00, -389.60},	c = {0, 0, 0},	c2 = {255, 255, 255, 0} },
	[8] = { f = 152,	p = {-42.95, -389.60},	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[9] = { f = 153,	p = {60.65, -389.60} },
	[10] = { f = 154,	p = {122.80, -389.60} },
	[11] = { f = 155,	p = {143.50, -389.60} },
	[12] = { f = 189,	v = false },
}

----- depth = 11 -----
_table.array[11] = {
	[1] = { f = 102,	p = {280.80, 0.00},	s = {1.00, 1.00},	r = 0.00,	a = 255,	c = {255, 255, 255},	i = 'shape-22',	ar = {0.50, 0.50},	v = true },
	[2] = { f = 103,	p = {36.10, 0.00} },
	[3] = { f = 104,	p = {-208.65, 0.00} },
	[4] = { f = 105,	p = {-193.05, 0.00} },
	[5] = { f = 106,	p = {-196.95, 0.00} },
	[6] = { f = 123,	p = {161.35, 0.00},	c = {64, 64, 64},	c2 = {191, 191, 191, 0} },
	[7] = { f = 124,	p = {280.80, 0.00},	c = {0, 0, 0},	c2 = {255, 255, 255, 0} },
	[8] = { f = 152,	p = {425.85, 0.00},	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[9] = { f = 153,	p = {529.45, 0.00} },
	[10] = { f = 154,	p = {591.60, 0.00} },
	[11] = { f = 155,	p = {612.30, 0.00} },
	[12] = { f = 189,	v = false },
}

----- depth = 12 -----
_table.array[6] = {
	[1] = { f = 126,	p = {-143.30, 643.65},	s = {1.00, 1.00},	r = 0.00,	a = 255,	c = {0, 0, 0},	c2 = {255, 255, 255, 0},	i = 'shape-24',	ar = {0.50, 0.50},	v = true },
	[2] = { f = 127,	p = {-143.30, 166.85},	c = {192, 192, 192},	c2 = {64, 64, 64, 0} },
	[3] = { f = 128,	p = {-143.30, 7.95},	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[4] = { f = 129,	p = {-143.30, 33.30} },
	[5] = { f = 130,	p = {-143.30, 25.50} },
	[6] = { f = 152,	p = {1.75, 25.50} },
	[7] = { f = 153,	p = {105.35, 25.50} },
	[8] = { f = 154,	p = {167.50, 25.50} },
	[9] = { f = 155,	p = {188.20, 25.50} },
	[10] = { f = 182,	c = {251, 251, 251},	c2 = {5, 5, 5, 0} },
	[11] = { f = 183,	c = {235, 235, 235},	c2 = {21, 21, 21, 0} },
	[12] = { f = 184,	c = {209, 209, 209},	c2 = {47, 47, 47, 0} },
	[13] = { f = 185,	c = {172, 172, 172},	c2 = {83, 83, 83, 0} },
	[14] = { f = 186,	c = {125, 125, 125},	c2 = {130, 130, 130, 0} },
	[15] = { f = 187,	c = {68, 68, 68},	c2 = {187, 187, 187, 0} },
	[16] = { f = 188,	c = {0, 0, 0},	c2 = {255, 255, 255, 0} },
	[17] = { f = 189,	v = false },
}

----- depth = 13 -----
_table.array[7] = {
	[1] = { f = 128,	p = {-396.15, -390.00},	s = {1.00, 1.00},	r = 0.00,	a = 255,	c = {255, 255, 255},	i = 'shape-26',	ar = {0.50, 0.50},	v = true },
	[2] = { f = 129,	p = {-396.15, -87.25} },
	[3] = { f = 130,	p = {-396.15, 13.65} },
	[4] = { f = 131,	p = {-396.15, 1.95} },
	[5] = { f = 152,	p = {-251.10, 1.95} },
	[6] = { f = 153,	p = {-147.50, 1.95} },
	[7] = { f = 154,	p = {-85.35, 1.95} },
	[8] = { f = 155,	p = {-64.65, 1.95} },
	[9] = { f = 182,	c = {251, 251, 251},	c2 = {5, 5, 5, 0} },
	[10] = { f = 183,	c = {235, 235, 235},	c2 = {21, 21, 21, 0} },
	[11] = { f = 184,	c = {209, 209, 209},	c2 = {47, 47, 47, 0} },
	[12] = { f = 185,	c = {172, 172, 172},	c2 = {83, 83, 83, 0} },
	[13] = { f = 186,	c = {125, 125, 125},	c2 = {130, 130, 130, 0} },
	[14] = { f = 187,	c = {68, 68, 68},	c2 = {187, 187, 187, 0} },
	[15] = { f = 188,	c = {0, 0, 0},	c2 = {255, 255, 255, 0} },
	[16] = { f = 189,	v = false },
}

----- depth = 14 -----
_table.array[8] = {
	[1] = { f = 129,	p = {280.80, -0.30},	s = {1.00, 1.00},	r = 0.00,	a = 255,	c = {0, 0, 0},	c2 = {255, 255, 255, 0},	i = 'shape-28',	ar = {0.50, 0.50},	v = true },
	[2] = { f = 130,	p = {-238.40, -0.30},	c = {192, 192, 192},	c2 = {64, 64, 64, 0} },
	[3] = { f = 131,	p = {-411.45, -0.30},	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[4] = { f = 132,	p = {-401.70, -0.30} },
	[5] = { f = 133,	p = {-405.60, -0.30} },
	[6] = { f = 152,	p = {-260.55, -0.30} },
	[7] = { f = 153,	p = {-156.95, -0.30} },
	[8] = { f = 154,	p = {-94.80, -0.30} },
	[9] = { f = 155,	p = {-74.10, -0.30} },
	[10] = { f = 182,	c = {251, 251, 251},	c2 = {5, 5, 5, 0} },
	[11] = { f = 183,	c = {235, 235, 235},	c2 = {21, 21, 21, 0} },
	[12] = { f = 184,	c = {209, 209, 209},	c2 = {47, 47, 47, 0} },
	[13] = { f = 185,	c = {172, 172, 172},	c2 = {83, 83, 83, 0} },
	[14] = { f = 186,	c = {125, 125, 125},	c2 = {130, 130, 130, 0} },
	[15] = { f = 187,	c = {68, 68, 68},	c2 = {187, 187, 187, 0} },
	[16] = { f = 188,	c = {0, 0, 0},	c2 = {255, 255, 255, 0} },
	[17] = { f = 189,	v = false },
}

return _table