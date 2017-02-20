

local _table = {}

_table.stage = {}
_table.stage.maxF = 170
_table.stage.fps = 20
_table.stage.size = {1136, 640}

--_table.shapeMap = {}
--_table.shapeMap['shape-1'] = {1136, 640}
--_table.shapeMap['shape-2'] = {1136, 640}
--_table.shapeMap['shape-3'] = {1136, 116}
--_table.shapeMap['shape-4'] = {240, 240}
--_table.shapeMap['shape-5'] = {241, 242}
--_table.shapeMap['shape-6'] = {236, 236}
--_table.shapeMap['shape-7'] = {242, 242}
--_table.shapeMap['shape-8'] = {444, 260}

_table.array = {}

----- depth = 1 -----
local alpha_r = 0.7
--遮罩
_table.array[1] = {
	[1] = { f = 5,	p = {0.00, 0.00},	s = {1.00, 1.00},	a = 0*alpha_r,	v = true },
	[2] = { f = 6,	a = 85*alpha_r },
	[3] = { f = 7,	a = 171*alpha_r },
	[4] = { f = 8,	a = 255*alpha_r },
}

----- depth = 3 -----
--战斗胜利
_table.array[2] = {
	[1] = { f = 5,	p = {-2.10, 237.95},	s = {0.10, 0.10},	a = 0,	v = true },
	[2] = { f = 6,	s = {0.63, 0.63},	a = 85 },
	[3] = { f = 7,	s = {1.17, 1.17},	a = 171 },
	[4] = { f = 8,	s = {1.71, 1.71},	a = 255 },
	[5] = { f = 9,	p = {-2.05, 237.90},	s = {1.35, 1.35} },
	[6] = { f = 10,	v = false },
	-- [7] = { f = 11,	p = {-4.05, 81.25},	s = {0.66, 0.66},	a = 64,	v = true },
	-- [8] = { f = 12,	p = {-2.75, 53.90},	s = {0.77, 0.77},	a = 128 },
	-- [9] = { f = 13,	p = {-1.50, 26.60},	s = {0.89, 0.89},	a = 192 },
	-- [10] = { f = 14,	p = {-0.15, -0.75},	a = 255 },
	[7] = { f = 11,	s = {0.66, 0.66},	a = 64,	v = true },
	[8] = { f = 12,	s = {0.77, 0.77},	a = 128 },
	[9] = { f = 13,	s = {0.89, 0.89},	a = 192 },
	[10] = { f = 14,	s = {1, 1}, a = 255 },
}

-- ----- depth = 3 -----
-- --胜利爆炸
_table.array[3] = {
	[1] = { f = 10,	p = {-2.05, 237.90},	i = 'Swf_ZhanDouJieSuan-14.png',	v = true },
	[2] = { f = 11,	i = 'Swf_ZhanDouJieSuan-16.png',},
	[3] = { f = 12,	i = 'Swf_ZhanDouJieSuan-18.png',},
	[4] = { f = 13,	i = 'Swf_ZhanDouJieSuan-20.png',},
	[5] = { f = 14,	i = 'Swf_ZhanDouJieSuan-22.png',},
	[6] = { f = 15,	i = 'Swf_ZhanDouJieSuan-24.png',},
	[7] = { f = 16,	i = 'Swf_ZhanDouJieSuan-26.png',},
	[8] = { f = 17,	i = 'Swf_ZhanDouJieSuan-28.png',},
	[9] = { f = 18,	i = 'Swf_ZhanDouJieSuan-30.png',},
	[10] = { f = 19,	i = 'Swf_ZhanDouJieSuan-32.png',},
	[11] = { f = 20,	i = 'Swf_ZhanDouJieSuan-34.png',},
	[12] = { f = 21,	i = 'Swf_ZhanDouJieSuan-36.png',},
	[13] = { f = 22,	i = 'Swf_ZhanDouJieSuan-38.png',},
	[14] = { f = 23,	i = 'Swf_ZhanDouJieSuan-40.png',},
	[15] = { f = 24,	i = 'Swf_ZhanDouJieSuan-42.png',},
	[16] = { f = 25,	i = 'Swf_ZhanDouJieSuan-44.png',},
	[17] = { f = 26,	i = 'Swf_ZhanDouJieSuan-46.png',},
	[18] = { f = 27,	i = 'Swf_ZhanDouJieSuan-48.png',},
	[19] = { f = 28,	v = false,},
}

----- depth = 12 -----
--战斗框背景
-- _table.array[4] = {
-- 	[1] = { f = 14,	a = 0,	v = true },
-- 	[2] = { f = 15,	a = 51 },
-- 	[3] = { f = 16,	a = 102 },
-- 	[4] = { f = 17,	a = 154 },
-- 	[5] = { f = 18,	a = 205 },
-- 	[6] = { f = 19,	a = 255 },
-- }


-- ----- depth = 20 -----
-- --战斗绿色按钮1
-- _table.array[5] = {
-- 	[1] = { f = 35,	p = {-202.95, -44.00},	s = {4.13, 4.13},	a = 0,	v = true },
-- 	[2] = { f = 36,	p = {-202.95, -43.95},	s = {3.51, 3.51},	a = 51 },
-- 	[3] = { f = 37,	s = {2.88, 2.88},	a = 102 },
-- 	[4] = { f = 38,	s = {2.25, 2.25},	a = 154 },
-- 	[5] = { f = 39,	p = {-202.95, -44.00},	s = {1.63, 1.63},	a = 205 },
-- 	[6] = { f = 40,	p = {-202.95, -44.00},	s = {1.00, 1.00},	a = 255},
-- 	[7] = { f = 41,	p = {-204.40, -44.60},	s = {1.06, 1.06} },
-- 	[8] = { f = 42,	p = {-205.85, -45.20},	s = {1.13, 1.13} },
-- 	[9] = { f = 43,	p = {-204.40, -44.65},	s = {1.06, 1.06} },
-- 	[10] = { f = 44,	p = {-202.95, -44.00} },
-- }

-- -------
-- --文字爆炸
-- _table.array[6] = {
-- 	[1] = { f = 1,	p = {-202.95, -44.00}, i = 'Swf_ZhanDouJieSuan-64.png',	v = true },
-- 	[2] = { f = 2,	i = 'Swf_ZhanDouJieSuan-66.png',},
-- 	[3] = { f = 3,	i = 'Swf_ZhanDouJieSuan-68.png',},
-- 	[4] = { f = 4,	i = 'Swf_ZhanDouJieSuan-70.png',},
-- 	[5] = { f = 5,	i = 'Swf_ZhanDouJieSuan-72.png',},
-- 	[6] = { f = 6,	i = 'Swf_ZhanDouJieSuan-74.png',},
-- 	[7] = { f = 7,	i = 'Swf_ZhanDouJieSuan-76.png',},
-- 	[8] = { f = 8,	i = 'Swf_ZhanDouJieSuan-78.png',},
-- 	[9] = { f = 9,	i = 'Swf_ZhanDouJieSuan-80.png',},
-- 	[10] = { f = 10,	i = 'Swf_ZhanDouJieSuan-82.png',},
-- 	[11] = { f = 11,	i = 'Swf_ZhanDouJieSuan-84.png',},
-- 	[12] = { f = 12,	i = 'Swf_ZhanDouJieSuan-86.png',},
-- 	[13] = { f = 13,	i = 'Swf_ZhanDouJieSuan-88.png',},
-- 	[14] = { f = 14,	i = 'Swf_ZhanDouJieSuan-90.png',},
-- 	[15] = { f = 15,	i = 'Swf_ZhanDouJieSuan-92.png',},
-- 	[16] = { f = 16,	i = 'Swf_ZhanDouJieSuan-94.png',},
-- 	[17] = { f = 17,	i = 'Swf_ZhanDouJieSuan-96.png',},
-- 	[18] = { f = 18,	i = 'Swf_ZhanDouJieSuan-98.png',},
-- 	[18] = { f = 19,	i = 'Swf_ZhanDouJieSuan-100.png',},
-- 	[18] = { f = 20,	i = 'Swf_ZhanDouJieSuan-102.png',},
-- 	[18] = { f = 21,	i = 'Swf_ZhanDouJieSuan-104.png',},
-- 	[19] = { f = 22,	v = false,},
-- }

-- for i,v in ipairs(_table.array[6]) do
-- 	v.f = v.f + 34
-- end

-- ----- depth = 27 -----
-- --战斗绿色按钮2
-- _table.array[7] = {
-- 	[1] = { f = 41,	p = {0.90, -44.00},	s = {4.13, 4.13},	a = 0,	v = true },
-- 	[2] = { f = 42,	p = {0.95, -44.05},	s = {3.50, 3.50},	a = 51 },
-- 	[3] = { f = 43,	s = {2.88, 2.88},	a = 102 },
-- 	[4] = { f = 44,	p = {0.95, -44.00},	s = {2.25, 2.25},	a = 154 },
-- 	[5] = { f = 45,	p = {0.95, -44.05},	s = {1.63, 1.63},	a = 205 },
-- 	[6] = { f = 46,	p = {0.90, -44.00},	s = {1.00, 1.00},	a = 255},
-- 	[7] = { f = 47,	p = {0.20, -44.30},	s = {1.06, 1.06} },
-- 	[8] = { f = 48,	p = {-0.50, -44.60},	s = {1.11, 1.11} },
-- 	[9] = { f = 49,	p = {0.15, -44.30},	s = {1.06, 1.06} },
-- 	[10] = { f = 50,	p = {0.90, -44.00} },
-- }

-- -------
-- --文字爆炸
-- _table.array[8] = {
-- 	[1] = { f = 1,	p = {0.90, -44.00}, i = 'Swf_ZhanDouJieSuan-64.png',	v = true },
-- 	[2] = { f = 2,	i = 'Swf_ZhanDouJieSuan-66.png',},
-- 	[3] = { f = 3,	i = 'Swf_ZhanDouJieSuan-68.png',},
-- 	[4] = { f = 4,	i = 'Swf_ZhanDouJieSuan-70.png',},
-- 	[5] = { f = 5,	i = 'Swf_ZhanDouJieSuan-72.png',},
-- 	[6] = { f = 6,	i = 'Swf_ZhanDouJieSuan-74.png',},
-- 	[7] = { f = 7,	i = 'Swf_ZhanDouJieSuan-76.png',},
-- 	[8] = { f = 8,	i = 'Swf_ZhanDouJieSuan-78.png',},
-- 	[9] = { f = 9,	i = 'Swf_ZhanDouJieSuan-80.png',},
-- 	[10] = { f = 10,	i = 'Swf_ZhanDouJieSuan-82.png',},
-- 	[11] = { f = 11,	i = 'Swf_ZhanDouJieSuan-84.png',},
-- 	[12] = { f = 12,	i = 'Swf_ZhanDouJieSuan-86.png',},
-- 	[13] = { f = 13,	i = 'Swf_ZhanDouJieSuan-88.png',},
-- 	[14] = { f = 14,	i = 'Swf_ZhanDouJieSuan-90.png',},
-- 	[15] = { f = 15,	i = 'Swf_ZhanDouJieSuan-92.png',},
-- 	[16] = { f = 16,	i = 'Swf_ZhanDouJieSuan-94.png',},
-- 	[17] = { f = 17,	i = 'Swf_ZhanDouJieSuan-96.png',},
-- 	[18] = { f = 18,	i = 'Swf_ZhanDouJieSuan-98.png',},
-- 	[18] = { f = 19,	i = 'Swf_ZhanDouJieSuan-100.png',},
-- 	[18] = { f = 20,	i = 'Swf_ZhanDouJieSuan-102.png',},
-- 	[18] = { f = 21,	i = 'Swf_ZhanDouJieSuan-104.png',},
-- 	[19] = { f = 22,	v = false,},
-- }

-- for i,v in ipairs(_table.array[8]) do
-- 	v.f = v.f + 40
-- end

-- ----- depth = 34 -----
-- --战斗绿色按钮3
-- _table.array[9] = {
-- 	[1] = { f = 47,	p = {204.95, -44.05},	s = {4.10, 4.10},	a = 0,	v = true },
-- 	[2] = { f = 48,	p = {204.95, -44.00},	s = {3.48, 3.48},	a = 51 },
-- 	[3] = { f = 49,	p = {205.00, -44.00},	s = {2.86, 2.86},	a = 102 },
-- 	[4] = { f = 50,	p = {204.95, -44.05},	s = {2.24, 2.24},	a = 154 },
-- 	[5] = { f = 51,	s = {1.62, 1.62},	a = 205 },
-- 	[6] = { f = 52,	p = {204.95, -44.05},	s = {1.00, 1.00},	a = 255},
-- 	[7] = { f = 53,	p = {203.95, -44.50},	s = {1.06, 1.06} },
-- 	[8] = { f = 54,	p = {202.90, -44.90},	s = {1.11, 1.11} },
-- 	[9] = { f = 55,	p = {203.95, -44.55},	s = {1.06, 1.06} },
-- 	[10] = { f = 56,	p = {204.95, -44.05} },
-- }

-- -------
-- --文字爆炸
-- _table.array[10] = {
-- 	[1] = { f = 1,	p = {204.95, -44.05}, i = 'Swf_ZhanDouJieSuan-64.png',	v = true },
-- 	[2] = { f = 2,	i = 'Swf_ZhanDouJieSuan-66.png',},
-- 	[3] = { f = 3,	i = 'Swf_ZhanDouJieSuan-68.png',},
-- 	[4] = { f = 4,	i = 'Swf_ZhanDouJieSuan-70.png',},
-- 	[5] = { f = 5,	i = 'Swf_ZhanDouJieSuan-72.png',},
-- 	[6] = { f = 6,	i = 'Swf_ZhanDouJieSuan-74.png',},
-- 	[7] = { f = 7,	i = 'Swf_ZhanDouJieSuan-76.png',},
-- 	[8] = { f = 8,	i = 'Swf_ZhanDouJieSuan-78.png',},
-- 	[9] = { f = 9,	i = 'Swf_ZhanDouJieSuan-80.png',},
-- 	[10] = { f = 10,	i = 'Swf_ZhanDouJieSuan-82.png',},
-- 	[11] = { f = 11,	i = 'Swf_ZhanDouJieSuan-84.png',},
-- 	[12] = { f = 12,	i = 'Swf_ZhanDouJieSuan-86.png',},
-- 	[13] = { f = 13,	i = 'Swf_ZhanDouJieSuan-88.png',},
-- 	[14] = { f = 14,	i = 'Swf_ZhanDouJieSuan-90.png',},
-- 	[15] = { f = 15,	i = 'Swf_ZhanDouJieSuan-92.png',},
-- 	[16] = { f = 16,	i = 'Swf_ZhanDouJieSuan-94.png',},
-- 	[17] = { f = 17,	i = 'Swf_ZhanDouJieSuan-96.png',},
-- 	[18] = { f = 18,	i = 'Swf_ZhanDouJieSuan-98.png',},
-- 	[18] = { f = 19,	i = 'Swf_ZhanDouJieSuan-100.png',},
-- 	[18] = { f = 20,	i = 'Swf_ZhanDouJieSuan-102.png',},
-- 	[18] = { f = 21,	i = 'Swf_ZhanDouJieSuan-104.png',},
-- 	[19] = { f = 22,	v = false,},
-- }

-- for i,v in ipairs(_table.array[10]) do
-- 	v.f = v.f + 46
-- end

--[[
project ->



--]]

return _table
