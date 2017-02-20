local Swf 				= require 'framework.swf.Swf'
local SwfActionFactory 	= require 'framework.swf.SwfActionFactory'
local Utils 			= require 'framework.helper.Utils'
local StringViewHelper 	= require 'StringViewHelper'
local TimerHelper 		= require 'framework.sync.TimerHelper' 

local Job_Images = { [0]='hei.png', [1]='zhanshi.png', [2]='tanke.png', [3]='dps.png', [4]='zhiliao.png', }

--[[
3种能量球的方式
一种老虎机
一种随机能量球
一种死亡能量球

--能量球消失
	球消失, 向右移动

--]]

--[[
控制的对象有:

1. 整个layer 来自 luaset -> 去除位移震动
2. label 来自 luaset
3. 能量球的底板  来自 luaset
4. 白色的地板 来自 luaset

由action控制
5. 球*9   新生成
6. 爆炸
--]]

----- depth = 1 bg -----
--去除p, 去除震动
local Shape1_Action_Data = {
	[1] = { f = 1,	p = {0.00, 0.00},	s = {1.00, 1.00},	r = 0.00,	a = 255,	c = {255, 255, 255},	ar = {0.50, 0.50},	v = true },
	[2] = { f = 6,	c = {245, 245, 245} },
	[3] = { f = 7,	c = {233, 233, 233} },
	[4] = { f = 8,	c = {222, 222, 222} },
	[5] = { f = 9,	c = {210, 210, 210} },
	[6] = { f = 76,	c = {222, 222, 222} },
	[7] = { f = 77,	c = {233, 233, 233} },
	[8] = { f = 78,	c = {245, 245, 245} },
	[9] = { f = 79,	c = {255, 255, 255} },
}

----- depth = 2 白色底 -----
local Shape2_Action_Data = {
	[1] = { f = 1, v = false},
	[2] = { f = 8,	p = {0.00, 188.30},	s = {1.00, 0.02},	r = 0.00,	a = 0,	c = {255, 255, 255},	ar = {0.50, 0.50},	v = true },
	[3] = { f = 9,	p = {0.40, 117.95},	s = {1.00, 0.38},	a = 85 },
	[4] = { f = 10,	p = {0.85, 47.50},	s = {1.00, 0.74},	a = 171 },
	[5] = { f = 11,	p = {0.00, -17.70},	s = {1.00, 1.09},	a = 255 },
	[6] = { f = 12,	p = {0.00, -0.05},	s = {1.00, 1.00} },
	[7] = { f = 68,	p = {0.00, 36.90},	s = {1.00, 0.80},	a = 205 },
	[8] = { f = 69,	p = {0.00, 73.85},	s = {1.00, 0.61},	a = 154 },
	[9] = { f = 70,	p = {0.00, 110.85},	s = {1.00, 0.41},	a = 102 },
	[10] = { f = 71,	p = {0.00, 147.75},	s = {1.00, 0.21},	a = 51 },
	[11] = { f = 72,	p = {0.00, 184.70},	s = {1.00, 0.01},	a = 0 },
	-- [11] = { f = 73,	p = {-80.15, -146.65},	s = {1.27, 1.27},	a = 255,	i = 'shape-9',	ar = {0.55, 0.58} },
	-- [12] = { f = 75,	p = {-121.10, -184.50},	s = {0.52, 0.52}, },
	-- [13] = { f = 76,	s = {1.00, 1.00},	i = 'shape-10' },
	-- [14] = { f = 77,	i = 'shape-11' },
	-- [15] = { f = 78,	i = 'shape-12' },
	-- [16] = { f = 79,	i = 'shape-13' },
	-- [17] = { f = 80,	i = 'shape-14' },
	-- [18] = { f = 81,	i = 'shape-15' },
	-- [19] = { f = 82,	i = 'shape-16' },
	-- [20] = { f = 83,	i = 'shape-17' },
	-- [21] = { f = 84,	i = 'shape-18' },
	-- [22] = { f = 85,	i = 'shape-19' },
	-- [23] = { f = 86,	i = 'shape-20' },
	-- [24] = { f = 87,	i = 'shape-21' },
	-- [25] = { f = 88,	i = 'shape-22' },
	-- [26] = { f = 89,	i = 'shape-23' },
	-- [27] = { f = 90,	i = 'shape-24' },
	-- [28] = { f = 91,	i = 'shape-25' },
	-- [29] = { f = 92,	i = 'shape-26' },
	[30] = { f = 93,	v = false },
}

----- depth = 3 label -----
local Shape3_Action_Data = {
	[1] = { f = 1,  p = {845.15, 0.00}, a = 0,  v = false },
	[2] = { f = 10,	p = {845.15, 0.00},	s = {1.31, 1.00},	r = 0.00,	a = 255,	c = {61, 61, 61},	ar = {0.50, 0.50},	v = true },
	[3] = { f = 11,	p = {374.25, 0.00},	s = {1.21, 1.00},	c = {169, 169, 169} },
	[4] = { f = 12,	p = {91.75, 0.00},	s = {1.14, 1.00},	c = {234, 234, 234} },
	[5] = { f = 13,	p = {-2.50, 0.00},	s = {1.12, 1.00},	c = {255, 255, 255} },
	[6] = { f = 14,	p = {-1.25, 0.00},	s = {1.00, 1.00} },
	[7] = { f = 68,	p = {-208.70, 0.00},	s = {1.17, 1.00},	c = {205, 205, 205} },
	[8] = { f = 69,	p = {-416.15, 0.00},	s = {1.35, 1.00},	c = {154, 154, 154} },
	[9] = { f = 70,	p = {-623.60, 0.05},	s = {1.52, 1.00},	c = {102, 102, 102} },
	[10] = { f = 71,	p = {-831.10, 0.05},	s = {1.70, 1.00},	c = {51, 51, 51} },
	[11] = { f = 72,	p = {-1038.50, 0.05},	s = {1.87, 1.00},	c = {0, 0, 0} },
	[12] = { f = 73,	v = false },
}

----- depth = 4 能量求底部 -----
local Shape4_Action_Data = {
	[1] = { f = 12,	p = {0.00, 0.00},	s = {1.00, 1.00},	r = 0.00,	a = 0,	c = {255, 255, 255},	ar = {0.50, 0.50},	v = true },
	[2] = { f = 13,	a = 142 },
	[3] = { f = 14,	a = 228 },
	[4] = { f = 15,	a = 255 },
	[5] = { f = 66,	a = 205 },
	[6] = { f = 67,	a = 154 },
	[7] = { f = 68,	a = 102 },
	[8] = { f = 69,	a = 51 },
	[9] = { f = 70,	a = 0 },
	[10] = { f = 71,	v = false },
}


local Ball_Position_X 	= { -118, 4.15, 127.75 }
local Ball_Position_Y = 84.30

local adaptX = (-(1136 - require 'Global'.getWidth())/2)*0 
local offsetX = -105
adaptX = adaptX + offsetX

local Target_Position_X = { adaptX+245, adaptX+177, adaptX+109, adaptX+41, adaptX-25, adaptX-95, adaptX-163, adaptX-231 }
local Target_Position_Y = -283

local Ball_Explode_Offset_X = 0
local Ball_Explode_Offset_Y = -24

--从12帧出现第一组球开始  -> 21
local Ball_In1_Action_Data = {
	[1] = { f = 1 },
	[2] = { f = 12,	p = {-117.75, 83.70},	s = {1.00, 1.00},	r = 0.00,	a = 0,	c = {255, 255, 255},	i = 'shape-5',	ar = {0.50, 0.50},	v = true },
	[3] = { f = 13,	a = 85 },
	[4] = { f = 14,	a = 171 },
	[5] = { f = 15,	a = 255 },
	[6] = { f = 16,	p = {-117.75, 62.25},	a = 144 },
	[7] = { f = 17,	p = {-117.75, 46.95},	a = 64 },
	[8] = { f = 18,	p = {-117.75, 37.75},	a = 16 },
	[9] = { f = 19,	p = {-117.75, 34.70},	a = 0 },
	[10] = { f = 20,	v = false },
}

--从15帧开始   -> 15
local Ball_In2_Action_Data = {
	[1] = { f = 1, v = false},
	[2] = { f = 14},
}

--从18帧开始  -> 18
local Ball_In3_Action_Data = {
	[1] = { f = 1, v = false},
	[2] = { f = 17 },
}

--左边的ball
local Ball_Loop_Action_Data = {
	[1] = { f = 1,	p = {-118.30, 122.30},	s = {1.00, 1.00},  a = 0,	c = {255, 255, 255},	i = 'shape-8',	ar = {0.50, 0.50},	v = true },
	[2] = { f = 2,	p = {-118.30, 105.40},	a = 114 },
	[3] = { f = 3,	p = {-118.30, 92.75},	a = 199 },
	[4] = { f = 4,	p = {-118.30, 84.30},	a = 255 },
	[5] = { f = 5,	p = {-118.30, 62.80},	a = 144 },
	[6] = { f = 6,	p = {-118.30, 47.45},	a = 64 },
	[7] = { f = 7,	p = {-118.30, 38.25},	a = 16 },
	[8] = { f = 8,	p = {-118.30, 35.20},	a = 0 },
	[9] = { f = 9,	v = false },
}


--没有选中的情况


--21+3X

--25帧开始播放
--32帧开始爆炸 -1帧??
--33帧率开始地震
local Ball_Out_Action_Data = {
	-- [1] = { f = 1,	p = {-118.30, 122.30},	s = {1.00, 1.00},	r = 0.00,	a = 0,	c = {255, 255, 255},	i = 'shape-6',	ar = {0.50, 0.50},	v = true },
	-- [2] = { f = 2,	p = {-117.95, 103.45},	a = 128 },
	-- [3] = { f = 3,	p = {-117.65, 84.60},	a = 255 },
	-- [4] = { f = 4,	p = {-117.85, 84.25},	s = {1.42, 1.42},	r = -4.03,	c = {232, 232, 232} },
	-- [5] = { f = 5,	p = {-118.00, 83.95},	s = {1.77, 1.77},	r = -7.51,	c = {213, 213, 213} },
	-- [6] = { f = 6,	p = {-118.05, 83.75},	s = {2.03, 2.03},	r = -10.04,	c = {198, 198, 198} },
	-- [7] = { f = 7,	p = {-118.20, 83.65},	s = {2.22, 2.22},	r = -12.01,	c = {188, 188, 188} },
	-- [8] = { f = 8,	p = {-118.25, 83.50},	s = {2.34, 2.34},	r = -13.05,	c = {181, 181, 181} },
	-- [9] = { f = 9,	p = {-118.25, 83.45},	s = {2.38, 2.38},	r = -13.52,	c = {179, 179, 179} },
	-- [10] = { f = 10,	p = {-118.25, 82.20},	s = {0.84, 0.84},	r = -40.60,	c = {255, 255, 255} },
	-- [11] = { f = 11,	p = {-117.65, 84.60},	s = {1.30, 1.30},	r = 0.00 },
	-- [12] = { f = 12,	s = {1.00, 1.00},	c = {194, 194, 194} },
	-- [13] = { f = 13,	c = {210, 210, 210} },
	-- [14] = { f = 14,	c = {225, 225, 225} },
	-- [15] = { f = 15,	c = {241, 241, 241} },
	-- [16] = { f = 16,	c = {255, 255, 255} },
	[1] = { f = 1,	p = {-118.30, 122.30},	s = {1.00, 1.00},	r = 0.00,	a = 0,	c = {255, 255, 255},	i = 'shape-16',	ar = {0.50, 0.50},	v = true },
	[2] = { f = 2,	p = {-117.95, 103.45},	a = 128 },
	[3] = { f = 3,	p = {-117.65, 84.60},	a = 255 },
	-- [4] = { f = 4,	p = {-117.95, 83.90},	s = {1.39, 1.39},	r = -8.30,	c = {208, 208, 208},	c2 = {48, 48, 48, 0} },
	-- [5] = { f = 5,	p = {-118.25, 83.45},	s = {1.63, 1.63},	r = -13.53,	c = {179, 179, 179},	c2 = {77, 77, 77, 0} },
	-- [6] = { f = 6,	p = {-118.25, 83.20},	s = {0.84, 0.84},	r = -40.60,	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	-- [7] = { f = 7,	p = {-117.65, 84.60},	s = {1.00, 1.00},	r = 0.00,	c = {194, 194, 194},	c2 = {62, 62, 62, 0} },
	-- [8] = { f = 8,	c = {210, 210, 210},	c2 = {47, 47, 47, 0} },
	-- [9] = { f = 9,	c = {225, 225, 225},	c2 = {31, 31, 31, 0} },
	-- [10] = { f = 10,	c = {241, 241, 241},	c2 = {16, 16, 16, 0} },
	-- [11] = { f = 11,	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	-- [12] = { f = 12,	p = {-117.65, 80.85} },
	-- [13] = { f = 13,	p = {-117.65, 87.10} },
	-- [14] = { f = 14,	p = {-117.65, 84.60} },

	[4] = { f = 4,	p = {4.75, 122.30},	s = {1.00, 1.00},	r = 0.00,	a = 0,	c = {255, 255, 255}, ar = {0.50, 0.50},	v = true },
	[5] = { f = 5,	p = {5.00, 103.45},	s = {1.04, 1.04},	a = 128 },
	[6] = { f = 6,	p = {5.25, 84.60},	s = {1.07, 1.07},	a = 255 },
	[7] = { f = 7,	p = {4.50, 84.60},	s = {1.37, 1.37},	r = 10.81,	c = {208, 208, 208},	c2 = {48, 48, 48, 0} },
	[8] = { f = 8,	p = {4.05, 84.60},	s = {1.55, 1.55},	r = 17.54,	c = {179, 179, 179},	c2 = {77, 77, 77, 0} },
	[9] = { f = 9,	p = {4.05, 84.60},	s = {0.85, 0.85},	r = 27.34,	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[10] = { f = 10,	p = {3.45, 84.60},	s = {1.04, 1.04},	r = 0.00,	c = {194, 194, 194},	c2 = {62, 62, 62, 0} },
	[11] = { f = 11,	s = {1.00, 1.00},	c = {210, 210, 210},	c2 = {47, 47, 47, 0} },
	[12] = { f = 12,	c = {225, 225, 225},	c2 = {31, 31, 31, 0} },
	[13] = { f = 13,	c = {241, 241, 241},	c2 = {16, 16, 16, 0} },
	[14] = { f = 14,	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[15] = { f = 15,	p = {3.45, 84.60},	s = {1.04, 1.04} },
	[16] = { f = 16,	p = {3.45, 84.60},	s = {1.03, 1.03} },
	[17] = { f = 17,	p = {3.45, 84.60} },
	[18] = { f = 18,},
	[19] = { f = 19,},
	[20] = { f = 20,	s = {1.02, 1.02} },
	[21] = { f = 21,	},
	[22] = { f = 22,	},
	[23] = { f = 23,	},
	[24] = { f = 24,	s = {1.01, 1.01} },
	[25] = { f = 25,	},
	[26] = { f = 26,	},
	[27] = { f = 27,	},
	[28] = { f = 28,	s = {1.00, 1.00} },
	[29] = { f = 29,	},
	[30] = { f = 30,	},

	-- [17] = { f = 66,	a = 202 },
	-- [18] = { f = 67,	a = 147 },
	-- [19] = { f = 68,	a = 93 },
	-- [20] = { f = 69,	a = 38 },
	-- [21] = { f = 70,	v = false },
}

--
local Ball_FadeOut_Action_Data = {
	[1] = { f = 60 },
	[2] = { f = 66,	a = 202 },
	[3] = { f = 67,	a = 147 },
	[4] = { f = 68,	a = 93 },
	[5] = { f = 69,	a = 38 },
	[6] = { f = 70,	v = false },
}

local Ball_Quick_FadeOut_Action_Data = {
	[1] = { f = 1 },
	[2] = { f = 4,	a = 202 },
	[3] = { f = 5,	a = 147 },
	[4] = { f = 6,	a = 93 },
	[5] = { f = 7,	a = 38 },
	[6] = { f = 8,	v = false },
}

--某一个信号,开始播放第60帧

--21 + 3X 
-- +05帧 爆炸1
-- +39帧 爆炸2

--从31帧开始出现
--从36帧开始爆炸
--从65帧开始回合消失等
--从75帧开始爆炸
--从77帧率开始地震
local Ball_Drop_Action_Data = {
	[1] = { f = 31,	p = {127.05, 122.30},	s = {1.00, 1.00},	r = 0.00,	a = 13,	c = {255, 255, 255},	i = 'shape-5',	ar = {0.50, 0.50},	v = true },
	[2] = { f = 32,	p = {127.40, 103.45},	a = 135 },
	[3] = { f = 33,	p = {127.70, 84.60},	a = 255 },
	[4] = { f = 34,	p = {127.80, 84.50},	s = {1.28, 1.28},	c = {241, 241, 241},	c2 = {15, 15, 15, 0} },
	[5] = { f = 35,	p = {127.95, 84.35},	s = {1.56, 1.56},	c = {225, 225, 225},	c2 = {31, 31, 31, 0} },
	[6] = { f = 36,	p = {128.05, 84.25},	s = {1.84, 1.84},	c = {210, 210, 210},	c2 = {46, 46, 46, 0} },
	[7] = { f = 37,	p = {128.20, 84.10},	s = {2.13, 2.12},	c = {194, 194, 194},	c2 = {62, 62, 62, 0} },
	[8] = { f = 38,	p = {128.30, 84.00},	s = {2.41, 2.41},	c = {179, 179, 179},	c2 = {77, 77, 77, 0} },
	[9] = { f = 39,	p = {127.75, 82.80},	s = {0.87, 0.87},	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[10] = { f = 40,	p = {127.95, 83.15},	s = {1.85, 1.85} },
	[11] = { f = 41,	s = {1.00, 1.00},	c = {188, 188, 188},	c2 = {68, 68, 68, 0} },
	[12] = { f = 42,	c = {197, 197, 197},	c2 = {60, 60, 60, 0} },
	[13] = { f = 43,	c = {205, 205, 205},	c2 = {51, 51, 51, 0} },
	[14] = { f = 44,	c = {214, 214, 214},	c2 = {43, 43, 43, 0} },
	[15] = { f = 45,	c = {222, 222, 222},	c2 = {34, 34, 34, 0} },
	[16] = { f = 46,	c = {231, 231, 231},	c2 = {26, 26, 26, 0} },
	[17] = { f = 47,	c = {239, 239, 239},	c2 = {17, 17, 17, 0} },
	[18] = { f = 48,	c = {248, 248, 248},	c2 = {9, 9, 9, 0} },
	[19] = { f = 49,	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[20] = { f = 50,	p = {115.80, 88.70},	s = {1.26, 1.26},	r = 52.16,	c = {249, 249, 249},	c2 = {7, 7, 7, 0} },
	[21] = { f = 51,	p = {104.55, 93.95},	s = {1.50, 1.50},	r = 100.76,	c = {243, 243, 243},	c2 = {13, 13, 13, 0} },
	[22] = { f = 52,	p = {94.10, 98.80},	s = {1.72, 1.72},	r = 145.88,	c = {238, 238, 238},	c2 = {18, 18, 18, 0} },
	[23] = { f = 53,	p = {84.50, 103.30},	s = {1.93, 1.93},	r = -172.96,	c = {232, 232, 232},	c2 = {24, 24, 24, 0} },
	[24] = { f = 54,	p = {75.80, 107.35},	s = {2.11, 2.11},	r = -135.11,	c = {228, 228, 228},	c2 = {28, 28, 28, 0} },
	[25] = { f = 55,	p = {67.90, 111.00},	s = {2.29, 2.29},	r = -100.79,	c = {223, 223, 223},	c2 = {33, 33, 33, 0} },
	[26] = { f = 56,	p = {60.85, 114.30},	s = {2.44, 2.44},	r = -70.43,	c = {220, 220, 220},	c2 = {36, 36, 36, 0} },
	[27] = { f = 57,	p = {54.65, 117.15},	s = {2.57, 2.57},	r = -43.35,	c = {216, 216, 216},	c2 = {40, 40, 40, 0} },
	[28] = { f = 58,	p = {49.25, 119.65},	s = {2.69, 2.69},	r = -19.81,	c = {213, 213, 213},	c2 = {43, 43, 43, 0} },
	[29] = { f = 59,	p = {44.60, 121.70},	s = {2.79, 2.79},	r = -0.03,	c = {211, 211, 211},	c2 = {45, 45, 45, 0} },
	[30] = { f = 60,	p = {40.80, 123.45},	s = {2.87, 2.87},	r = 16.04,	c = {209, 209, 209},	c2 = {47, 47, 47, 0} },
	[31] = { f = 61,	p = {37.90, 124.75},	s = {2.93, 2.93},	r = 28.59,	c = {207, 207, 207},	c2 = {49, 49, 49, 0} },
	[32] = { f = 62,	p = {35.75, 125.75},	s = {2.97, 2.97},	r = 37.61,	c = {206, 206, 206},	c2 = {50, 50, 50, 0} },
	[33] = { f = 63,	p = {34.55, 126.30},	s = {3.00, 3.00},	r = 43.11,	c = {205, 205, 205},	c2 = {51, 51, 51, 0} },
	[34] = { f = 64,	p = {34.10, 126.60},	s = {3.01, 3.01},	r = 44.87,	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[35] = { f = 65,	p = {32.50, 125.85},	s = {3.03, 3.03},	r = 49.16 },
	[36] = { f = 66,	p = {27.30, 123.70},	s = {3.11, 3.11},	r = 62.19,	c = {206, 206, 206},	c2 = {50, 50, 50, 0} },
	[37] = { f = 67,	p = {18.70, 120.15},	s = {3.24, 3.24},	r = 83.95,	c = {208, 208, 208},	c2 = {48, 48, 48, 0} },
	[38] = { f = 68,	p = {6.80, 115.30},	s = {3.41, 3.41},	r = 114.12,	c = {210, 210, 210},	c2 = {46, 46, 46, 0} },
	[39] = { f = 69,	p = {4.30, 110.25},	s = {3.37, 3.37},	r = 123.58,	c = {211, 211, 211},	c2 = {45, 45, 45, 0} },
	[40] = { f = 70,	p = {-7.95, 97.20},	s = {3.26, 3.26},	r = 151.96,	c = {213, 213, 213},	c2 = {43, 43, 43, 0} },
	[41] = { f = 71,	p = {-18.95, 71.65},	s = {3.07, 3.07},	r = -160.71,	c = {199, 199, 199},	c2 = {56, 56, 56, 0} },
	[42] = { f = 72,	p = {-34.70, 35.95},	s = {2.80, 2.80},	r = -94.29,	c = {189, 189, 189},	c2 = {66, 66, 66, 0} },
	[43] = { f = 73,	p = {-55.45, -10.05},	s = {2.46, 2.46},	r = -9.05,	c = {178, 178, 178},	c2 = {77, 77, 77, 0} },
	[44] = { f = 74,	p = {-81.05, -65.85},	s = {2.05, 2.05},	r = 94.80,	c = {166, 166, 166},	c2 = {88, 88, 88, 0} },
	[45] = { f = 75,	p = {-111.25, -131.80},	s = {1.55, 1.55},	r = -142.12,	c = {155, 155, 155},	c2 = {99, 99, 99, 0} },
	[46] = { f = 76,	p = {-146.30, -207.95},	s = {0.98, 0.98},	r = 0.00,	c = {144, 144, 144},	c2 = {111, 111, 111, 0} },
	[47] = { f = 77,	p = {-145.45, -208.25},	s = {1.47, 1.47},	c = {60, 60, 60},	c2 = {194, 194, 194, 0} },
	[48] = { f = 78,	s = {1.23, 1.23},	c = {92, 92, 92},	c2 = {162, 162, 162, 0} },
	[49] = { f = 79,	s = {0.98, 0.98},	c = {125, 125, 125},	c2 = {130, 130, 130, 0} },
	[50] = { f = 86,	s = {1.00, 1.00},	c = {158, 158, 158},	c2 = {98, 98, 98, 0} },
	[51] = { f = 87,	c = {191, 191, 191},	c2 = {65, 65, 65, 0} },
	[52] = { f = 88,	c = {223, 223, 223},	c2 = {33, 33, 33, 0} },
	[53] = { f = 89,	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
}

-- [20] = { f = 73,	p = {-80.15, -146.65},	s = {1.27, 1.27},	r = 0.00,	a = 0,	c = {255, 255, 255},	i = 'shape-9',	ar = {0.55, 0.58},	v = true },
-- 	[21] = { f = 75,	p = {-121.10, -184.50},	s = {0.52, 0.52},	a = 255 },
-- 	[22] = { f = 76,	s = {1.00, 1.00},	i = 'shape-10' },
-- 	[23] = { f = 77,	i = 'shape-11' },
-- 	[24] = { f = 78,	i = 'shape-12' },
-- 	[25] = { f = 79,	i = 'shape-13' },
-- 	[26] = { f = 80,	i = 'shape-14' },
-- 	[27] = { f = 81,	i = 'shape-15' },
-- 	[28] = { f = 82,	i = 'shape-16' },
-- 	[29] = { f = 83,	i = 'shape-17' },
-- 	[30] = { f = 84,	i = 'shape-18' },
-- 	[31] = { f = 85,	i = 'shape-19' },
-- 	[32] = { f = 86,	i = 'shape-20' },
-- 	[33] = { f = 87,	i = 'shape-21' },
-- 	[34] = { f = 88,	i = 'shape-22' },
-- 	[35] = { f = 89,	i = 'shape-23' },
-- 	[36] = { f = 90,	i = 'shape-24' },
-- 	[37] = { f = 91,	i = 'shape-25' },
-- 	[38] = { f = 92,	i = 'shape-26' },
-- 	[39] = { f = 93,	v = false },

--爆炸
local Explode_Action_Data = {
	[1] = { f = 1,	p = {0, 0}, i = 'energy_explode_1.png',	v = true,},
	[2] = { f = 2,	i = 'energy_explode_2.png', },
	[3] = { f = 3,	i = 'energy_explode_3.png' },
	[4] = { f = 4,	i = 'energy_explode_4.png' },
	[5] = { f = 5,	i = 'energy_explode_5.png' },
	[6] = { f = 6,	i = 'energy_explode_6.png' },
	[7] = { f = 7,	i = 'energy_explode_7.png' },
	[8] = { f = 8,	i = 'energy_explode_8.png' },
	[9] = { f = 9,	i = 'energy_explode_9.png' },
	[10] = { f = 10,	i = 'energy_explode_10.png' },
	[11] = { f = 11,	i = 'energy_explode_11.png' },
	[12] = { f = 12,	i = 'energy_explode_12.png' },
	[13] = { f = 13,	i = 'energy_explode_13.png' },
	[14] = { f = 14,	i = 'energy_explode_14.png' },
	[15] = { f = 15,	i = 'energy_explode_15.png',},
	[16] = { f = 16,	i = 'energy_explode_16.png',},
	[17] = { f = 17,	i = 'energy_explode_17.png',},
	[18] = { f = 18,	i = 'energy_explode_18.png',},
	[18] = { f = 19,	i = 'energy_explode_19.png',},
	[18] = { f = 20,	i = 'energy_explode_20.png',},
	[19] = { f = 21,	v = false },
}

--作用于全屏
local Earth_Shake_Action_Data = {
	{ f = 1, }, --delay explode 2 frame
	{ f = 3,	p = {0.00, -1.00}, },
	{ f = 4,	p = {0.00, -5.75}, },
	{ f = 5,	p = {0.00, -2.65},	},
	{ f = 6,	p = {0.00, 0.00},	},
}

local EnergyView = class(require 'BasicView')

function EnergyView:ctor(luaset, document)
	-- body
	self._luaset = self:createLuaSet(document, '@EnergyView')

	self._luaset['layer'] 	= luaset['layer']
	self._luaset['uiLayer'] = luaset['uiLayer']
	self._luaset['uiLayer_labels'] = luaset['uiLayer_labels']

	local root = self._luaset[1]
	self._luaset['uiLayer_labels']:addChild(root)

	self._loopCount = { [0] = 0, [1] = 0, [2] = 0, [3] = 0 }
	self._isTriggered = false

	self._triggerMap = { false, false, false }

	--[[
	--]]
	self._info = nil

	self._luaset['box_stopButton']:setListener(function ()
		-- body
		self._luaset['box_stopButton']:setEnabled(false)
		self:trigger()
	end)

	self:delayFrames(function ()
		-- body
		self:trigger()

	end, 50)

end

--[[
mode 	= [1, 3] 
index 	= [1, 3]
--]]

function EnergyView:newBallStart( node, mode, index )
	-- body

	local actionData 
	if mode == 1 then
		actionData = Ball_In1_Action_Data
		-- if actionData[1].i then
		local image = self:getRandomBallImage()
		for i,v in ipairs(actionData) do
			if v.i then
				v.i = image
			end
		end

	elseif mode == 2 then
		actionData = Ball_In2_Action_Data
		-- actionData[1].i = self:getRandomBallImage()

	elseif mode == 3 then
		actionData = Ball_In3_Action_Data
		-- actionData[1].i = self:getRandomBallImage()
	else
		error('newBallStart error Mode!')
	end

	local action = SwfActionFactory.createAction(actionData)
	action:setListener(function ()
		-- body
		self:newBallLoop(node, index)

		if index == 1 and mode == 1 then
			self:delayFrames(function ()
				-- body
				self:startRollSound()
			end, 20)
		end
	end)
	node:runElfAction(action)

end

function EnergyView:onFinished()
	-- body
	if self._info.func then
		self._info.func()
		self._info.func = nil
	end
end

------
function EnergyView:startRollSound()
	-- body
	if not self._rollSoundId then
		self._rollSoundId = require 'framework.helper.MusicHelper'.playEffect(require 'Res'.Sound.bt_slots_roll, true)
	end
end

function EnergyView:stopRollSound()
	-- body
	if self._rollSoundId then
		require 'framework.helper.MusicHelper'.stopEffect(self._rollSoundId)
		self._rollSoundId = nil
	end
end

--24
--60
function EnergyView:newBallLoop( node, index)
	-- body
	self._loopCount[index] = self._loopCount[index] + 1

	if self._isTriggered and self._loopCount[index] > self._loopCount[index-1] then
		if not self._triggerMap[index] then
			self._triggerMap[index] = true

			if index == 3 then
				self:stopRollSound()
			end

			if self._info.result[index] > 0 and self._info.targetIndex <= 8 then
				local targetIndex = self._info.targetIndex
				self._info.targetIndex = self._info.targetIndex + 1

				local targetPos = {Target_Position_X[targetIndex], Target_Position_Y}

				self:newBallDrop(node, index, targetPos)
				--delay 6 frames
				local pos = { Ball_Position_X[index], Ball_Position_Y }

				self:playExplode(pos, 6)

				--45帧后再爆炸一次
				self:playExplode(targetPos, 45)

				self:playFadeOut(node, 70)

			else
				self:newBallResult(node, index)
				--delay 6 frames
				-- local pos = { Ball_Position_X[index], Ball_Position_Y }
				-- self:playExplode(pos, 6)

				-- self:playFadeOut(node, (1-index)*3 + 36 )
			end

			if index == 1 then
				--运行40帧 后 setDisposed
				self:playEnd( 36 + 4 )

				self:delayFrames(function ()
					-- body
					self:onFinished()
				end, 70)
			end
		end
	else

		--position
		local positionX = Ball_Position_X[index]
		local image = self:getRandomBallImage()

		for i,v in ipairs(Ball_Loop_Action_Data) do
			if v.p then
				v.p[1] = positionX
			end
			if v.i then
				v.i = image
			end
		end

		local action = SwfActionFactory.createAction( Ball_Loop_Action_Data )

		action:setListener(function ()
			self:newBallLoop(node, index)
		end)
		node:runElfAction(action)
	end
end

--
function EnergyView:newBallResult( node, index )
	-- body
	local image = Job_Images[ self._info.result[index] or 0 ]
	Ball_Out_Action_Data[1].i = image

	for i,v in ipairs(Ball_Out_Action_Data) do
		if v.p then
			v.p[1] = Ball_Position_X[index]
		end
	end

	local action = SwfActionFactory.createAction( Ball_Out_Action_Data )
	action:setListener(function ()
		-- body
		node:retain()
		node:removeFromParent()
		self._luaset['box']:addChild(node)
		node:release()
	end)

	node:runElfAction(action)
end

function EnergyView:newBallDrop( node, index, targetPos)
	-- body
	local image = Job_Images[ self._info.result[index] ]

	local action = self:getDropAction(image, Ball_Position_X[index], Ball_Position_Y, targetPos[1], targetPos[2], index )

	node:runElfAction(action)

	require 'framework.helper.MusicHelper'.playEffect(require 'Res'.Sound.bt_slots_selected)
end

function EnergyView:trigger()
	-- body
	self._isTriggered = true
end

--[[
info:
career  	-> {1,2,4}
label  		-> 回合 xxx
result 		-> {1,1,4}
targetIndex	-> 1

func   	-> callback when animate finished
--]]
function EnergyView:show( info )
	-- body
	-- info = {}
	-- info.career = {1,2,3,4}
	-- info.result = {0, 2,4}
	-- info.label = '2/3'
	-- info.targetIndex = 1
	-- info.func = function ()
	-- 	-- body
	-- end

	assert(info)

	--[[
	01-20 show
	15, 18, 21 循环一次9帧

	不中
	21+3X 最后一次  -> delay index*3
				   -> 

				   比如24 开始
				      + 7 开始爆炸
				      + 9 开始地震
				      + 开始隐藏

	中
	24帧 第一个    6帧后开始爆炸     
	27帧 第二个
	30帧 第三个    6帧开始爆炸,    44帧率再爆炸一次

	第60帧后开始播放消失画面, 90帧播完

	60-80 hide
	--]]

	self._info = info

	self:setLabel(info.label)

	self:playStart()

end

function EnergyView:playStart()
	-- body
	local layer = self._luaset['layer']
	-- local uiLayer = self._luaset['uiLayer']

	local white = self._luaset['white']
	local label = self._luaset['label']
	local box = self._luaset['box']

	---- ActionFactory.createAction = function ( _table, shapeMap, offset, fps, startFrame, endFrame )
	local action1 = SwfActionFactory.createAction(Shape1_Action_Data, nil, nil, 20, 1, 20)
	layer:runAction(action1)

	local action2 = SwfActionFactory.createAction(Shape2_Action_Data, nil, nil, 20, 1, 20)
	white:runAction(action2)

	local action3 = SwfActionFactory.createAction(Shape3_Action_Data, nil, nil, 20, 1, 20)
	label:runAction(action3)

	local action4 = SwfActionFactory.createAction(Shape4_Action_Data, nil, nil, 20, 1, 20)
	box:runAction(action4)

	for i=1,9 do
		local node = AddColorNode:create()
		self._luaset[1]:addChild(node)
		self._luaset['ball'..i] = node
	end

	--[[
	--]]
	for i=1,3 do
		for mode=1,3 do
			local tag = 10 - ((i-1)*3 + mode)

			--987 < 654 < 321
			local node = self._luaset['ball'..tag]
			--j = mode
			if node then
				self:newBallStart(node, mode, i)
			end
		end
	end
end

function EnergyView:delayFrames( func, frames )
	-- body
	local timeOut = TimeOut.new(frames/20, function ( ... )
		-- body
		if tolua.isnull(self._luaset['layer']) then
			return
		end

		if func then
			func()
		end
	end)

	timeOut:start()
end

function EnergyView:playEnd(delayFrames)
	-- body
	Utils.delay(function ()
		-- body
		if tolua.isnull(self._luaset['layer']) then
			return
		end

		local layer = self._luaset['layer']
		-- local uiLayer = self._luaset['uiLayer']

		local white = self._luaset['white']
		local label = self._luaset['label']
		local box = self._luaset['box']

		---- ActionFactory.createAction = function ( _table, shapeMap, offset, fps, startFrame, endFrame )
		local action1 = SwfActionFactory.createAction(Shape1_Action_Data, nil, nil, 20, 60, 100)
		layer:runAction( action1 )

		local action2 = SwfActionFactory.createAction(Shape2_Action_Data, nil, nil, 20, 60, 100)
		white:runAction(action2)

		local action3 = SwfActionFactory.createAction(Shape3_Action_Data, nil, nil, 20, 60, 100)
		label:runAction(action3)

		local action4 = SwfActionFactory.createAction(Shape4_Action_Data, nil, nil, 20, 60, 100)
		box:runAction(action4)

		action1:setListener(function ()
			-- body
			self:setDisposed()
		end)

	end, delayFrames/20, self._luaset[1])
end

function EnergyView:playExplode( pos, delayFrames )
	-- body
	Utils.delay(function ()
		-- body
		if self._luaset == nil or self._luaset['uiLayer'] == nil or tolua.isnull(self._luaset['uiLayer']) then
			return
		end

		local node = ElfNode:create()
		node:setVisible(false)

		node:setBlendMode(770, 1)

		-- local x, y = ballnode:getPosition()
		-- node:setPosition(ccp(pos[1], pos[2]))

		Explode_Action_Data[1].p = { pos[1]+Ball_Explode_Offset_X, pos[2]+Ball_Explode_Offset_Y }

		-- local 

		local action = SwfActionFactory.createAction(Explode_Action_Data, nil, nil, 20, 1, 19, false )
		action:setListener(function ()
			-- node:removeFromParent()
		end)
		node:runAction(action)
		
		-- ballnode:addChild(node)
		self._luaset[1]:addChild(node)

		local action2 = SwfActionFactory.createAction(Earth_Shake_Action_Data)
		local uiLayer = self._luaset['uiLayer']
		uiLayer:runAction(action2:clone())

		local layer = self._luaset['layer']
		layer:runAction(action2)

		require 'framework.helper.MusicHelper'.playEffect(require 'Res'.Sound.bt_slots_grid)

	end, delayFrames/20, ballnode)
end

function EnergyView:playFadeOut( ballnode, delayFrames)
	-- body
	Utils.delay(function ()
		-- body
		if tolua.isnull(self._luaset['layer']) then
			return
		end

		local action = SwfActionFactory.createAction(Ball_Quick_FadeOut_Action_Data)

		ballnode:runElfAction(action)

	end, delayFrames/20, ballnode)
end


function EnergyView:setLabel( label )
	-- body
	if label then
		self._luaset['label']:setVisible(false)

		local nodeArray = {
			self._luaset['label_round_n1'],
			self._luaset['label_round_n2'],
			self._luaset['label_round_n3'],
			self._luaset['label_round_n4'],
			self._luaset['label_round_n5'],
		}

		StringViewHelper.setRoundBigString(nodeArray, label)

		-- self._luaset['label_round']:setVisible(false)
	else
		self._luaset['label']:setVisible(false)

		self._luaset['label_huihe']:setVisible(false)
		self._luaset['label_round']:setVisible(false)
	end
end

function EnergyView:getCareerBallImage( career )
	-- body

end

function EnergyView:getRandomBallImage()
	-- body
	-- self._info.
	local array = {}

	for i,v in ipairs( self._info.career ) do
		table.insert(array, v)
	end

	--一半的概率是黑球
	local size = #array
	for i=1, size do
		table.insert(array, 0)
	end
	
	local index = math.random(1, #array)
	-- local index = 1

	local career = array[index]

	return Job_Images[career]
end

function EnergyView:getDropAction( image, startX, startY, endX, endY, index )
	-- body
	for i,v in ipairs(Ball_Drop_Action_Data) do
		v.c = nil
	end

	local copyData = Utils.copyTable(Ball_Drop_Action_Data)
	local startPos = Utils.copyTable( copyData[1].p )

	local endPos 

	local size = #copyData
	for i=size,1,-1 do
		local fVo = copyData[i]
		if fVo.p then
			endPos = Utils.copyTable( copyData[i].p )
			break
		end
	end

	-- startY = startPos[2]

	assert(endPos and startPos)

	local scaleX = (endX-startX)/(endPos[1] - startPos[1])
	local scaleY = (endY-startY)/(endPos[2] - startY)

	for i,v in ipairs(copyData) do
		if v.p then
			v.p[1] = startX + scaleX*(v.p[1]-startPos[1])

			if i > 9 then
				v.p[2] = startY + scaleY*(v.p[2]-startY)
			end
		end

		if v.i then
			v.i = image
		end
	end

	--[[
	_table: 输入的关键帧数据
	offset: 相对偏移量
	-- auto:	是否自动补帧率, not used
	fps:	帧率
	shapeMap:  image redirect
	--]]
	-- ActionFactory.createAction = function ( _table, shapeMap, offset, fps, startFrame, endFrame )

	return SwfActionFactory.createAction(copyData, nil, nil, 20, copyData[1].f, copyData[#copyData].f)
end





--[[

--]]

-- local RandomEnergyView = class( require 'BasicView' )

-- function RandomEnergyView:ctor()
-- 	-- body

-- end



return EnergyView