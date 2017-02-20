

local _table = {}

_table.stage = {}
_table.stage.maxF = 42
_table.stage.fps = 20
_table.stage.size = {960, 640}

--_table.shapeMap = {}
--_table.shapeMap['shape-2'] = {960, 640}
--_table.shapeMap['shape-4'] = {125, 123}

_table.array = {}

----- depth = 1 -----
_table.array[1] = {
	[1] = { f = 1,	p = {-480.00, 320.00},	s = {1.00, 1.00},	r = 0.00,	a = 255,	c = {255, 255, 255},	i = 'shape-2',	ar = {0.00, 1.00},	v = true },
	[2] = { f = 25,	p = {-480.00, 315.45} },
	[3] = { f = 27,	p = {-480.00, 321.95} },
}

----- depth = 2 -----
_table.array[2] = {
	[1] = { f = 1,	p = {-337.40, 185.05},	s = {0.78, 0.78},	r = 0.00,	a = 164,	c = {255, 255, 255},	i = 'shape-4',	ar = {0.57, 0.55},	v = true },
	[2] = { f = 2,	p = {-331.70, 172.15},	r = 9.52,	a = 210 },
	[3] = { f = 3,	p = {-326.05, 159.30},	r = 19.08,	a = 255 },
	[4] = { f = 4,	p = {-330.10, 159.90},	r = 12.04 },
	[5] = { f = 5,	p = {-334.15, 160.50},	r = 5.04 },
	[6] = { f = 6,	p = {-338.15, 161.00},	r = -1.77 },
	[7] = { f = 7,	p = {-342.25, 161.65},	r = -8.80 },
	[8] = { f = 8,	p = {-340.50, 160.85},	r = -5.26 },
	[9] = { f = 9,	p = {-338.75, 160.10},	r = -1.76 },
	[10] = { f = 10,	p = {-337.00, 159.30},	r = 1.74 },
	[11] = { f = 11,	p = {-336.90, 159.30},	r = 1.54 },
	[12] = { f = 12,	p = {-336.85, 159.35},	r = 1.52 },
	[13] = { f = 13,	p = {-336.80, 159.30} },
	[14] = { f = 14,	p = {-335.20, 178.10},	s = {0.87, 0.87},	r = 0.52 },
	[15] = { f = 15,	p = {-333.90, 193.40},	s = {0.94, 0.94},	r = -0.04 },
	[16] = { f = 16,	p = {-332.85, 205.35},	s = {1.00, 1.00},	r = -0.75 },
	[17] = { f = 17,	p = {-332.15, 213.95},	s = {1.04, 1.04},	r = -1.04 },
	[18] = { f = 18,	p = {-331.70, 219.00},	s = {1.06, 1.06},	r = -1.30 },
	[19] = { f = 19,	p = {-331.55, 220.75},	s = {1.07, 1.07},	r = -1.52 },
	[20] = { f = 20,	p = {-331.60, 221.55},	s = {1.09, 1.09},	r = -1.51 },
	[21] = { f = 21,	p = {-331.55, 222.30},	s = {1.11, 1.11},	r = -1.52 },
	[22] = { f = 22,	p = {-323.65, 233.50},	s = {0.99, 0.99},	r = 0.00 },
	[23] = { f = 23,	p = {-315.65, 244.75},	s = {0.88, 0.88},	r = 1.31 },
	[24] = { f = 24,	p = {-307.65, 255.90},	s = {0.76, 0.76},	r = 2.81 },
	[25] = { f = 25,	p = {-299.70, 267.20},	s = {0.64, 0.64},	r = 4.31 },
	[26] = { f = 26,	p = {-291.75, 278.35},	s = {0.53, 0.53},	r = 5.99 },
	[27] = { f = 27,	p = {-291.35, 278.40},	s = {0.54, 0.54},	r = 2.51 },
	[28] = { f = 28,	p = {-291.00, 278.35},	s = {0.55, 0.55},	r = -0.88 },
	[29] = { f = 29,	p = {-291.00, 278.60},	s = {0.56, 0.56} },
}


return _table
