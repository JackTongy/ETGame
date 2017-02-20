--[[
	Id = Id
Name = 名称
Type = 类型
Property = 属性/职业
Star = 星级
Effect = 效果
Addition = 附加效果
Exp = 非经验秘宝作为升级材料时可提供的基础经验值
PieceNum = 合成所需碎片数量
ReforgeCost = 回炉价格

--]]
local _table = {
	[1] = {	Id = 1001,	Name = [[白色小号]],	Type = 1,	Property = {},	Star = 2,	Effect = 0.0060,	Addition = 0,	Exp = 20,	PieceNum = 0,	ReforgeCost = 0,},
	[2] = {	Id = 1002,	Name = [[黑色小号]],	Type = 1,	Property = {},	Star = 2,	Effect = 0.0060,	Addition = 0,	Exp = 20,	PieceNum = 0,	ReforgeCost = 0,},
	[3] = {	Id = 1003,	Name = [[电光手鼓]],	Type = 1,	Property = {3},	Star = 3,	Effect = 0.0100,	Addition = 0.0700,	Exp = 60,	PieceNum = 5,	ReforgeCost = 50,},
	[4] = {	Id = 1004,	Name = [[林溪竖笛]],	Type = 1,	Property = {6,2},	Star = 3,	Effect = 0.0100,	Addition = 0.0700,	Exp = 60,	PieceNum = 5,	ReforgeCost = 50,},
	[5] = {	Id = 1005,	Name = [[熔岩口琴]],	Type = 1,	Property = {7,8},	Star = 3,	Effect = 0.0100,	Addition = 0.0700,	Exp = 60,	PieceNum = 5,	ReforgeCost = 50,},
	[6] = {	Id = 1006,	Name = [[雷神号角]],	Type = 1,	Property = {3},	Star = 4,	Effect = 0.0150,	Addition = 0.1500,	Exp = 200,	PieceNum = 10,	ReforgeCost = 100,},
	[7] = {	Id = 1007,	Name = [[蔓草喇叭]],	Type = 1,	Property = {2},	Star = 4,	Effect = 0.0150,	Addition = 0.1500,	Exp = 200,	PieceNum = 10,	ReforgeCost = 100,},
	[8] = {	Id = 1008,	Name = [[冷冰笛子]],	Type = 1,	Property = {6},	Star = 4,	Effect = 0.0150,	Addition = 0.1500,	Exp = 200,	PieceNum = 10,	ReforgeCost = 100,},
	[9] = {	Id = 1009,	Name = [[烈焰皮鼓]],	Type = 1,	Property = {8},	Star = 4,	Effect = 0.0150,	Addition = 0.1500,	Exp = 200,	PieceNum = 10,	ReforgeCost = 100,},
	[10] = {	Id = 1010,	Name = [[大地铙钹]],	Type = 1,	Property = {7},	Star = 4,	Effect = 0.0150,	Addition = 0.1500,	Exp = 200,	PieceNum = 10,	ReforgeCost = 100,},
	[11] = {	Id = 2001,	Name = [[黑色缎带]],	Type = 2,	Property = {},	Star = 2,	Effect = 0.0060,	Addition = 0,	Exp = 20,	PieceNum = 0,	ReforgeCost = 0,},
	[12] = {	Id = 2002,	Name = [[白色缎带]],	Type = 2,	Property = {},	Star = 2,	Effect = 0.0060,	Addition = 0,	Exp = 20,	PieceNum = 0,	ReforgeCost = 0,},
	[13] = {	Id = 2003,	Name = [[能量缎带]],	Type = 2,	Property = {3,4},	Star = 3,	Effect = 0.0100,	Addition = 0.0700,	Exp = 60,	PieceNum = 5,	ReforgeCost = 50,},
	[14] = {	Id = 2004,	Name = [[勇士缎带]],	Type = 2,	Property = {1,2},	Star = 3,	Effect = 0.0100,	Addition = 0.0700,	Exp = 60,	PieceNum = 5,	ReforgeCost = 50,},
	[15] = {	Id = 2005,	Name = [[援助缎带]],	Type = 2,	Property = {4},	Star = 4,	Effect = 0.0150,	Addition = 0.1500,	Exp = 200,	PieceNum = 10,	ReforgeCost = 100,},
	[16] = {	Id = 2006,	Name = [[爆发缎带]],	Type = 2,	Property = {3},	Star = 4,	Effect = 0.0150,	Addition = 0.1500,	Exp = 200,	PieceNum = 10,	ReforgeCost = 100,},
	[17] = {	Id = 2007,	Name = [[搏击缎带]],	Type = 2,	Property = {1},	Star = 4,	Effect = 0.0150,	Addition = 0.1500,	Exp = 200,	PieceNum = 10,	ReforgeCost = 100,},
	[18] = {	Id = 2008,	Name = [[守护缎带]],	Type = 2,	Property = {2},	Star = 4,	Effect = 0.0150,	Addition = 0.1500,	Exp = 200,	PieceNum = 10,	ReforgeCost = 100,},
	[19] = {	Id = 3001,	Name = [[绿色口哨]],	Type = 3,	Property = {1},	Star = 2,	Effect = 50,	Addition = 0,	Exp = 0,	PieceNum = 0,	ReforgeCost = 0,},
	[20] = {	Id = 3002,	Name = [[蓝色口哨]],	Type = 3,	Property = {1},	Star = 3,	Effect = 150,	Addition = 0,	Exp = 0,	PieceNum = 5,	ReforgeCost = 0,},
	[21] = {	Id = 3003,	Name = [[紫色口哨]],	Type = 3,	Property = {1},	Star = 4,	Effect = 500,	Addition = 0,	Exp = 0,	PieceNum = 10,	ReforgeCost = 0,},
	[22] = {	Id = 3004,	Name = [[绿色绸布]],	Type = 3,	Property = {2},	Star = 2,	Effect = 50,	Addition = 0,	Exp = 0,	PieceNum = 0,	ReforgeCost = 0,},
	[23] = {	Id = 3005,	Name = [[蓝色绸布]],	Type = 3,	Property = {2},	Star = 3,	Effect = 150,	Addition = 0,	Exp = 0,	PieceNum = 5,	ReforgeCost = 0,},
	[24] = {	Id = 3006,	Name = [[紫色绸布]],	Type = 3,	Property = {2},	Star = 4,	Effect = 500,	Addition = 0,	Exp = 0,	PieceNum = 10,	ReforgeCost = 0,},
	[25] = {	Id = 3007,	Name = [[橙色口哨]],	Type = 3,	Property = {1},	Star = 5,	Effect = 5000,	Addition = 0,	Exp = 0,	PieceNum = 30,	ReforgeCost = 0,},
	[26] = {	Id = 3008,	Name = [[橙色绸布]],	Type = 3,	Property = {2},	Star = 5,	Effect = 5000,	Addition = 0,	Exp = 0,	PieceNum = 30,	ReforgeCost = 0,},
}

return _table
