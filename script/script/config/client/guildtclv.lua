--[[
	tclv = 科技等级
develops = 研究消耗公会基金
learns = 学习消耗个人贡献
effects = 效果(0~7对应文档科技类型)
numtype = 数值类型（1整数0百分比）

--]]
local _table = {
	[1] = {	tclv = 0,	develops = {0,0,0,0,0,0,0},	learns = {80,80,96,120,144,160,160},	effects = {0,0,0,0,0,0,0},	numtype = {0,0,0,1,1,0,0},},
	[2] = {	tclv = 1,	develops = {1000,1000,1200,1500,1800,2000,2000},	learns = {296,296,360,448,536,600,600},	effects = {0.02,0.02,0.03,30,30,0.02,0.02},	numtype = {0,0,0,1,1,0,0},},
	[3] = {	tclv = 2,	develops = {3000,3000,3600,4500,5400,6000,6000},	learns = {640,640,768,960,1152,1280,1280},	effects = {0.05,0.05,0.08,80,80,0.05,0.05},	numtype = {0,0,0,1,1,0,0},},
	[4] = {	tclv = 3,	develops = {5600,5600,6720,8400,10080,11200,11200},	learns = {1096,1096,1312,1640,1968,2192,2192},	effects = {0.08,0.08,0.12,120,120,0.08,0.08},	numtype = {0,0,0,1,1,0,0},},
	[5] = {	tclv = 4,	develops = {9600,9600,11520,14400,17280,19200,19200},	learns = {1640,1640,1968,2464,2960,3288,3288},	effects = {0.12,0.12,0.18,180,180,0.12,0.12},	numtype = {0,0,0,1,1,0,0},},
	[6] = {	tclv = 5,	develops = {14400,14400,17280,21600,25920,28800,28800},	learns = {2280,2280,2736,3424,4112,4568,4568},	effects = {0.16,0.16,0.24,240,240,0.16,0.16},	numtype = {0,0,0,1,1,0,0},},
	[7] = {	tclv = 6,	develops = {20000,20000,24000,30000,36000,40000,40000},	learns = {3136,3136,3768,4712,5656,6280,6280},	effects = {0.2,0.2,0.3,300,300,0.2,0.2},	numtype = {0,0,0,1,1,0,0},},
	[8] = {	tclv = 7,	develops = {27500,27500,33000,41250,49500,55000,55000},	learns = {4112,4112,4936,6168,7400,8224,8224},	effects = {0.25,0.25,0.38,380,380,0.25,0.25},	numtype = {0,0,0,1,1,0,0},},
	[9] = {	tclv = 8,	develops = {36000,36000,43200,54000,64800,72000,72000},	learns = {5200,5200,6240,7800,9360,10400,10400},	effects = {0.3,0.3,0.45,450,450,0.3,0.3},	numtype = {0,0,0,1,1,0,0},},
	[10] = {	tclv = 9,	develops = {45500,45500,54600,68250,81900,91000,91000},	learns = {6400,6400,7680,9600,11520,12800,12800},	effects = {0.35,0.35,0.53,530,530,0.35,0.35},	numtype = {0,0,0,1,1,0,0},},
	[11] = {	tclv = 10,	develops = {0,0,0,0,0,0,0},	learns = {0,0,0,0,0,0,0},	effects = {0.4,0.4,0.6,600,600,0.4,0.4},	numtype = {0,0,0,1,1,0,0},},
}

return _table
