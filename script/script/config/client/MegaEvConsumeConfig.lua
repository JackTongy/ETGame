--[[
	PetId = 进化目标精灵
MegaStoneId = Mega进化石Id
MegaStoneAmt = Mega进化石数量
StoneId = 潜力石Id
StoneAmt = 潜力石数量
Pets = 消耗精灵
Gold = 金币数量

--]]
local _table = {
	[1] = {	PetId = 1101,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1500,	Pets = [[45:60,149:60]],	Gold = 5000000,},
	[2] = {	PetId = 1103,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1500,	Pets = [[230:60,26:60]],	Gold = 5000000,},
	[3] = {	PetId = 1104,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1500,	Pets = [[467:60,248:60]],	Gold = 5000000,},
	[4] = {	PetId = 1105,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1500,	Pets = [[468:60,282:60]],	Gold = 5000000,},
	[5] = {	PetId = 1106,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 2500,	Pets = [[154:60,248:60]],	Gold = 20000000,},
	[6] = {	PetId = 1108,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 2500,	Pets = [[136:60,257:60]],	Gold = 20000000,},
	[7] = {	PetId = 1109,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 2500,	Pets = [[334:60,350:60]],	Gold = 20000000,},
	[8] = {	PetId = 3100,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[3:60,3:60]],	Gold = 5000000,},
	[9] = {	PetId = 3101,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[6:60,6:60]],	Gold = 5000000,},
	[10] = {	PetId = 3102,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[9:60,9:60]],	Gold = 5000000,},
	[11] = {	PetId = 1100,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 2000,	Pets = [[154:60,131:60]],	Gold = 10000000,},
	[12] = {	PetId = 3103,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[260:60,260:60]],	Gold = 5000000,},
	[13] = {	PetId = 3104,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[282:60,282:60]],	Gold = 5000000,},
	[14] = {	PetId = 3105,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[136:60,136:60]],	Gold = 5000000,},
	[15] = {	PetId = 3106,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[65:60,65:60]],	Gold = 5000000,},
	[16] = {	PetId = 3107,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[248:60,248:60]],	Gold = 5000000,},
	[17] = {	PetId = 3108,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[334:60,334:60]],	Gold = 5000000,},
	[18] = {	PetId = 3113,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[80:60,80:60]],	Gold = 5000000,},
	[19] = {	PetId = 1112,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 2500,	Pets = [[2002:60,2004:60]],	Gold = 20000000,},
	[20] = {	PetId = 1111,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 2500,	Pets = [[154:60,149:60]],	Gold = 20000000,},
	[21] = {	PetId = 3109,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[130:60,130:60]],	Gold = 5000000,},
	[22] = {	PetId = 3111,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[154:60,154:60]],	Gold = 5000000,},
	[23] = {	PetId = 3112,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[306:60,306:60]],	Gold = 5000000,},
	[24] = {	PetId = 1102,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1500,	Pets = [[136:60,76:60]],	Gold = 5000000,},
	[25] = {	PetId = 1107,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 2000,	Pets = [[350:60,470:60]],	Gold = 10000000,},
	[26] = {	PetId = 1113,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 2500,	Pets = [[94:60,157:60]],	Gold = 20000000,},
	[27] = {	PetId = 1115,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 2500,	Pets = [[373:60,2012:60]],	Gold = 20000000,},
	[28] = {	PetId = 3110,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[257:60,257:60]],	Gold = 5000000,},
	[29] = {	PetId = 3114,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[149:60,149:60]],	Gold = 5000000,},
	[30] = {	PetId = 3115,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[135:60,135:60]],	Gold = 5000000,},
	[31] = {	PetId = 3116,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[26:60,26:60]],	Gold = 5000000,},
	[32] = {	PetId = 3121,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[470:60,470:60]],	Gold = 5000000,},
	[33] = {	PetId = 1114,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 2500,	Pets = [[2009:60,2010:60]],	Gold = 20000000,},
	[34] = {	PetId = 1110,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 2000,	Pets = [[212:60,130:60]],	Gold = 10000000,},
	[35] = {	PetId = 3117,	MegaStoneId = 48,	MegaStoneAmt = 4000,	StoneId = 42,	StoneAmt = 6000,	Pets = [[6:80,6:80]],	Gold = 10000000,},
	[36] = {	PetId = 3120,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[160:60,160:60]],	Gold = 5000000,},
	[37] = {	PetId = 3122,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[2007:60,2007:60]],	Gold = 5000000,},
	[38] = {	PetId = 3123,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[350:60,350:60]],	Gold = 5000000,},
	[39] = {	PetId = 1116,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 2500,	Pets = [[2012:60,2014:60]],	Gold = 20000000,},
	[40] = {	PetId = 1117,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 2500,	Pets = [[382:60]],	Gold = 20000000,},
	[41] = {	PetId = 1118,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 2000,	Pets = [[2018:60,257:60]],	Gold = 10000000,},
	[42] = {	PetId = 1119,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 2500,	Pets = [[154:60,248:60]],	Gold = 20000000,},
	[43] = {	PetId = 1120,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 2500,	Pets = [[2016:60,2018:60]],	Gold = 20000000,},
	[44] = {	PetId = 3124,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[131:60,131:60]],	Gold = 5000000,},
	[45] = {	PetId = 1122,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 2500,	Pets = [[87:60,181:60]],	Gold = 20000000,},
	[46] = {	PetId = 1123,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 2500,	Pets = [[491:60]],	Gold = 20000000,},
	[47] = {	PetId = 2166,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 1000,	Pets = [[2165:60,2165:60]],	Gold = 5000000,},
	[48] = {	PetId = 1125,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 2500,	Pets = [[154:60,149:60]],	Gold = 20000000,},
	[49] = {	PetId = 1121,	MegaStoneId = 48,	MegaStoneAmt = 2000,	StoneId = 1,	StoneAmt = 2500,	Pets = [[142:60,87:60]],	Gold = 20000000,},
}

return _table
