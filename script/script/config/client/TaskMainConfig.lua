--[[
	Id = 任务编号
type = 任务类型
des = 任务条件描述
data = 数据
num = 数量
rewardid = 奖励
NextId = 下一主线任务id
GoTo = 前往

--]]
local _table = {
	[1] = {	Id = 101,	type = 1,	des = [[通关普通副本-火箭队据点]],	data = 7,	num = 1,	rewardid = 200101,	NextId = {201,202},	GoTo = 1,},
	[2] = {	Id = 201,	type = 2,	des = [[将一只精灵提升到4级]],	data = 4,	num = 1,	rewardid = 200102,	NextId = {301},	GoTo = 21,},
	[3] = {	Id = 301,	type = 4,	des = [[提升玩家等级到5级]],	data = 5,	num = 1,	rewardid = 200104,	NextId = {401},	GoTo = 1,},
	[4] = {	Id = 401,	type = 1,	des = [[通关普通副本-华蓝洞穴]],	data = 4,	num = 1,	rewardid = 200103,	NextId = {501},	GoTo = 1,},
	[5] = {	Id = 501,	type = 1,	des = [[通关普通副本-怨灵谷地]],	data = 8,	num = 1,	rewardid = 200105,	NextId = {601},	GoTo = 1,},
	[6] = {	Id = 601,	type = 1,	des = [[通关普通副本-枯叶港]],	data = 6,	num = 1,	rewardid = 200106,	NextId = {701},	GoTo = 1,},
	[7] = {	Id = 701,	type = 4,	des = [[提升玩家等级到8级]],	data = 8,	num = 1,	rewardid = 200107,	NextId = {801},	GoTo = 1,},
	[8] = {	Id = 801,	type = 1,	des = [[通关普通副本-红莲岛]],	data = 10,	num = 1,	rewardid = 200108,	NextId = {901},	GoTo = 1,},
	[9] = {	Id = 901,	type = 1,	des = [[通关普通副本-冠军之路]],	data = 12,	num = 1,	rewardid = 200109,	NextId = {1001},	GoTo = 1,},
	[10] = {	Id = 1001,	type = 1,	des = [[通关普通副本-钢铁炭坑]],	data = 2002,	num = 1,	rewardid = 200110,	NextId = {1101},	GoTo = 1,},
	[11] = {	Id = 1101,	type = 1,	des = [[通关普通副本-钢铁山脉]],	data = 2101,	num = 1,	rewardid = 200111,	NextId = {1201},	GoTo = 1,},
	[12] = {	Id = 1201,	type = 1,	des = [[通关普通副本-隐泉之路]],	data = 2005,	num = 1,	rewardid = 200112,	GoTo = 1,},
	[13] = {	Id = 202,	type = 3,	des = [[将一只精灵觉醒到1阶+2]],	data = 2,	num = 1,	rewardid = 200201,	NextId = {302},	GoTo = 20,},
	[14] = {	Id = 302,	type = 5,	des = [[挑战两次装备副本]],	data = 0,	num = 2,	rewardid = 200202,	NextId = {402},	GoTo = 13,},
	[15] = {	Id = 402,	type = 6,	des = [[将一件装备强化至6级]],	data = 6,	num = 1,	rewardid = 200203,	NextId = {502},	GoTo = 6,},
	[16] = {	Id = 502,	type = 9,	des = [[使用扭蛋卡进行一次精灵召唤]],	data = 0,	num = 1,	rewardid = 200206,	NextId = {602,603},	GoTo = 2,},
	[17] = {	Id = 602,	type = 11,	des = [[进行一次精灵献祭]],	data = 0,	num = 1,	rewardid = 200204,	GoTo = 22,},
	[18] = {	Id = 702,	type = 8,	des = [[使用合成装置合成一次装备]],	data = 0,	num = 1,	rewardid = 200205,	GoTo = 7,},
	[19] = {	Id = 802,	type = 7,	des = [[黑市兑换一次觉醒之石]],	data = 0,	num = 1,	rewardid = 200207,	GoTo = 3,},
	[20] = {	Id = 603,	type = 2,	des = [[将一只精灵提升到8级]],	data = 8,	num = 1,	rewardid = 200301,	NextId = {703},	GoTo = 21,},
	[21] = {	Id = 703,	type = 13,	des = [[在普通副本中掉落3个果实]],	data = 0,	num = 3,	rewardid = 200302,	NextId = {803},	GoTo = 1,},
	[22] = {	Id = 803,	type = 2,	des = [[将一只精灵提升到10级]],	data = 10,	num = 1,	rewardid = 200303,	NextId = {903},	GoTo = 21,},
	[23] = {	Id = 903,	type = 10,	des = [[在精英副本中掉落1个精英徽章]],	data = 1001,	num = 1,	rewardid = 200304,	NextId = {1003},	GoTo = 19,},
	[24] = {	Id = 1003,	type = 12,	des = [[在普通副本掉落中掉落1件蓝色装备]],	data = 2,	num = 1,	rewardid = 200305,	NextId = {1103},	GoTo = 1,},
	[25] = {	Id = 1103,	type = 2,	des = [[将一只精灵提升到20级]],	data = 20,	num = 1,	rewardid = 200306,	NextId = {1203},	GoTo = 21,},
	[26] = {	Id = 1203,	type = 10,	des = [[在精英副本中掉落3个精锐徽章]],	data = 1002,	num = 3,	rewardid = 200307,	GoTo = 19,},
}

return _table
