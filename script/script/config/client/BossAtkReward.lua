--[[
	Id = nil
BossId = BossId
Rank = 排名
Kill = 击杀奖励
Harm = 伤害奖励
HarmLow = 伤害比例下限
HarmUp = 伤害比例上限
RewardIds = 奖励内容（对应reward.xlsx）

--]]
local _table = {
	[1] = {	Id = 1,	BossId = 1,	Rank = 1,	Kill = 0,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {60011,60012,60013},},
	[2] = {	Id = 2,	BossId = 1,	Rank = 2,	Kill = 0,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {60021,60022,60023},},
	[3] = {	Id = 3,	BossId = 1,	Rank = 3,	Kill = 0,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {60031,60032,60033},},
	[4] = {	Id = 4,	BossId = 1,	Rank = 4,	Kill = 0,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {60041,60042,60043},},
	[5] = {	Id = 5,	BossId = 1,	Rank = 5,	Kill = 0,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {60051,60052,60053},},
	[6] = {	Id = 6,	BossId = 1,	Rank = 6,	Kill = 0,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {60061,60062,60063},},
	[7] = {	Id = 7,	BossId = 1,	Rank = 7,	Kill = 0,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {60071,60072,60073},},
	[8] = {	Id = 8,	BossId = 1,	Rank = 8,	Kill = 0,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {60081,60082,60083},},
	[9] = {	Id = 9,	BossId = 1,	Rank = 9,	Kill = 0,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {60091,60092,60093},},
	[10] = {	Id = 10,	BossId = 1,	Rank = 10,	Kill = 0,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {60101,60102,60103},},
	[11] = {	Id = 11,	BossId = 1,	Rank = 0,	Kill = 0,	Harm = 1,	HarmLow = 0,	HarmUp = 0.0010,	RewardIds = {61011,61012,61013},},
	[12] = {	Id = 12,	BossId = 1,	Rank = 0,	Kill = 0,	Harm = 1,	HarmLow = 0.0010,	HarmUp = 0.0020,	RewardIds = {61021,61022,61023},},
	[13] = {	Id = 13,	BossId = 1,	Rank = 0,	Kill = 0,	Harm = 1,	HarmLow = 0.0020,	HarmUp = 0.0050,	RewardIds = {61031,61032,61033},},
	[14] = {	Id = 14,	BossId = 1,	Rank = 0,	Kill = 0,	Harm = 1,	HarmLow = 0.0050,	HarmUp = 0.0100,	RewardIds = {61041,61042,61043},},
	[15] = {	Id = 15,	BossId = 1,	Rank = 0,	Kill = 0,	Harm = 1,	HarmLow = 0.0100,	HarmUp = 0.0300,	RewardIds = {61051,61052,61053},},
	[16] = {	Id = 16,	BossId = 1,	Rank = 0,	Kill = 0,	Harm = 1,	HarmLow = 0.0300,	HarmUp = 0.0600,	RewardIds = {61061,61062,61063},},
	[17] = {	Id = 17,	BossId = 1,	Rank = 0,	Kill = 0,	Harm = 1,	HarmLow = 0.0600,	HarmUp = 0.0900,	RewardIds = {61071,61072,61073},},
	[18] = {	Id = 18,	BossId = 1,	Rank = 0,	Kill = 0,	Harm = 1,	HarmLow = 0.0900,	HarmUp = 0.1200,	RewardIds = {61081,61082,61083},},
	[19] = {	Id = 19,	BossId = 1,	Rank = 0,	Kill = 0,	Harm = 1,	HarmLow = 0.1200,	HarmUp = 1,	RewardIds = {61091,61092,61093},},
	[20] = {	Id = 20,	BossId = 1,	Rank = 0,	Kill = 1,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {62001},},
	[21] = {	Id = 21,	BossId = 2,	Rank = 1,	Kill = 0,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {70011,70012,70013},},
	[22] = {	Id = 22,	BossId = 2,	Rank = 2,	Kill = 0,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {70021,70022,70023},},
	[23] = {	Id = 23,	BossId = 2,	Rank = 3,	Kill = 0,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {70031,70032,70033},},
	[24] = {	Id = 24,	BossId = 2,	Rank = 4,	Kill = 0,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {70041,70042,70043},},
	[25] = {	Id = 25,	BossId = 2,	Rank = 5,	Kill = 0,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {70051,70052,70053},},
	[26] = {	Id = 26,	BossId = 2,	Rank = 6,	Kill = 0,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {70061,70062,70063},},
	[27] = {	Id = 27,	BossId = 2,	Rank = 7,	Kill = 0,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {70071,70072,70073},},
	[28] = {	Id = 28,	BossId = 2,	Rank = 8,	Kill = 0,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {70081,70082,70083},},
	[29] = {	Id = 29,	BossId = 2,	Rank = 9,	Kill = 0,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {70091,70092,70093},},
	[30] = {	Id = 30,	BossId = 2,	Rank = 10,	Kill = 0,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {70101,70102,70103},},
	[31] = {	Id = 31,	BossId = 2,	Rank = 0,	Kill = 0,	Harm = 1,	HarmLow = 0,	HarmUp = 0.0010,	RewardIds = {71011,71012,71013},},
	[32] = {	Id = 32,	BossId = 2,	Rank = 0,	Kill = 0,	Harm = 1,	HarmLow = 0.0010,	HarmUp = 0.0020,	RewardIds = {71021,71022,71023},},
	[33] = {	Id = 33,	BossId = 2,	Rank = 0,	Kill = 0,	Harm = 1,	HarmLow = 0.0020,	HarmUp = 0.0050,	RewardIds = {71031,71032,71033},},
	[34] = {	Id = 34,	BossId = 2,	Rank = 0,	Kill = 0,	Harm = 1,	HarmLow = 0.0050,	HarmUp = 0.0100,	RewardIds = {71041,71042,71043},},
	[35] = {	Id = 35,	BossId = 2,	Rank = 0,	Kill = 0,	Harm = 1,	HarmLow = 0.0100,	HarmUp = 0.0300,	RewardIds = {71051,71052,71053},},
	[36] = {	Id = 36,	BossId = 2,	Rank = 0,	Kill = 0,	Harm = 1,	HarmLow = 0.0300,	HarmUp = 0.0600,	RewardIds = {71061,71062,71063},},
	[37] = {	Id = 37,	BossId = 2,	Rank = 0,	Kill = 0,	Harm = 1,	HarmLow = 0.0600,	HarmUp = 0.0900,	RewardIds = {71071,71072,71073},},
	[38] = {	Id = 38,	BossId = 2,	Rank = 0,	Kill = 0,	Harm = 1,	HarmLow = 0.0900,	HarmUp = 0.1200,	RewardIds = {71081,71082,71083},},
	[39] = {	Id = 39,	BossId = 2,	Rank = 0,	Kill = 0,	Harm = 1,	HarmLow = 0.1200,	HarmUp = 1,	RewardIds = {71091,71092,71093},},
	[40] = {	Id = 40,	BossId = 2,	Rank = 0,	Kill = 1,	Harm = 0,	HarmLow = 0,	HarmUp = 0,	RewardIds = {72001},},
}

return _table
