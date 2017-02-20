

local _table = {}

_table.stage = {}
_table.stage.maxF = 47
_table.stage.fps = 20
_table.stage.size = {1136, 640}

--_table.shapeMap = {}
--_table.shapeMap['shape-2'] = {1136, 640}
--_table.shapeMap['shape-4'] = {1136, 640}
--_table.shapeMap['shape-6'] = {1136, 640}
--_table.shapeMap['shape-8'] = {1136, 640}

_table.array = {}

----- depth = 1 -----
_table.array[1] = {
	[1] = { f = 1,	p = {-568.00, 320.00},	s = {1.00, 1.00},	r = 0.00,	a = 255,	c = {255, 255, 255},	i = 'shape-2',	ar = {0.00, 1.00},	v = true },
}

----- depth = 2 -----
_table.array[2] = {
	[1] = { f = 7,	p = {-1138.90, -32.45},	s = {1.00, 0.20},	r = 0.00,	a = 255,	c = {255, 255, 255},	i = 'shape-4',	ar = {0.50, 0.50},	v = true },
	[2] = { f = 8,	p = {-1010.30, -32.30},	s = {1.00, 0.29} },
	[3] = { f = 9,	p = {-624.45, -31.75},	s = {1.00, 0.55} },
	[4] = { f = 10,	p = {18.60, -30.90},	s = {1.00, 0.99} },
	[5] = { f = 11,	p = {0.00, -30.90} },
	[6] = { f = 43,	p = {-4.65, -30.90} },
	[7] = { f = 44,	p = {0.00, -30.90} },
	[8] = { f = 45,	p = {126.25, -30.90},	s = {1.00, 0.91} },
	[9] = { f = 46,	p = {504.90, -30.95},	s = {1.00, 0.65} },
	[10] = { f = 47,	p = {1136.00, -31.00},	s = {1.00, 0.20} },
}

----- depth = 3 -----
_table.array[3] = {
	[1] = { f = 11,	p = {0.00, 46.80},	s = {0.13, 0.13},	r = 0.00,	a = 255,	c = {255, 255, 255},	i = 'shape-6',	ar = {0.50, 0.50},	v = true },
	[2] = { f = 12,	p = {0.00, 14.80},	s = {0.48, 0.48},	c = {234, 234, 234},	c2 = {22, 22, 22, 0} },
	[3] = { f = 13,	p = {0.00, -81.15},	s = {1.51, 1.51},	c = {166, 166, 166},	c2 = {89, 89, 89, 0} },
	[4] = { f = 14,	p = {0.00, -32.15},	s = {0.98, 0.98},	c = {218, 218, 218},	c2 = {38, 38, 38, 0} },
	[5] = { f = 15,	p = {0.00, -38.15},	s = {1.04, 1.04},	c = {230, 230, 230},	c2 = {26, 26, 26, 0} },
	[6] = { f = 16,	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[7] = { f = 43,	p = {-3.00, -38.15} },
	[8] = { f = 44,	p = {0.00, -38.15} },
	[9] = { f = 45,	p = {373.90, -37.55},	s = {1.04, 0.76} },
	[10] = { f = 46,	p = {747.85, -36.90},	s = {1.04, 0.49} },
	[11] = { f = 47,	p = {1121.75, -36.20},	s = {1.04, 0.22} },
}

----- depth = 4 -----
_table.array[4] = {
	[1] = { f = 14,	p = {-2.00, -33.00},	s = {1.00, 1.00},	r = 0.00,	a = 0,	c = {255, 255, 255},	i = 'shape-8',	ar = {0.50, 0.50},	v = true },
	[2] = { f = 15,	a = 85 },
	[3] = { f = 16,	a = 171 },
	[4] = { f = 17,	a = 255 },
	[5] = { f = 43,	p = {-5.00, -33.00} },
	[6] = { f = 44,	p = {-2.00, -33.00} },
	[7] = { f = 45,	p = {372.90, -31.45},	s = {1.00, 0.74} },
	[8] = { f = 46,	p = {747.85, -29.85},	s = {1.00, 0.47} },
	[9] = { f = 47,	p = {1122.75, -28.30},	s = {1.00, 0.21} },
}


return _table