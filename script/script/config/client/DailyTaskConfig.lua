--[[
	Id = 任务Id
Content = 描述
Count = 数量要求
Score = 完成获得积分
Coin = 立即完成需要消耗钻石数
GoTo = 前往

--]]
local _table = {
	[1] = {	Id = 1,	Content = [[普通副本完成10场战斗]],	Count = 10,	Score = 10,	Coin = 20,	GoTo = 1,},
	[2] = {	Id = 2,	Content = [[普通副本完成20场战斗]],	Count = 20,	Score = 15,	Coin = 30,	GoTo = 1,},
	[3] = {	Id = 3,	Content = [[吃1次香烤大葱鸭]],	Count = 1,	Score = 10,	Coin = 20,	GoTo = 12,},
	[4] = {	Id = 4,	Content = [[活动副本赢取2场战斗]],	Count = 2,	Score = 10,	Coin = 20,	GoTo = 13,},
	[5] = {	Id = 5,	Content = [[进行1次招财喵喵]],	Count = 1,	Score = 10,	Coin = 20,	GoTo = 14,},
	[6] = {	Id = 6,	Content = [[在黑市中进行1次购买]],	Count = 1,	Score = 10,	Coin = 20,	GoTo = 3,},
	[7] = {	Id = 7,	Content = [[使用一次美味面包]],	Count = 1,	Score = 10,	Coin = 20,	GoTo = 4,},
	[8] = {	Id = 8,	Content = [[精英副本完成5场战斗]],	Count = 5,	Score = 15,	Coin = 30,	GoTo = 19,},
	[9] = {	Id = 9,	Content = [[冠军商店进行一次购买]],	Count = 1,	Score = 10,	Coin = 20,	GoTo = 16,},
	[10] = {	Id = 10,	Content = [[进行1次装备重铸]],	Count = 1,	Score = 10,	Coin = 20,	GoTo = 6,},
	[11] = {	Id = 11,	Content = [[参加1次神兽降临战斗]],	Count = 1,	Score = 10,	Coin = 20,	GoTo = 15,},
	[12] = {	Id = 12,	Content = [[开启3个宝箱]],	Count = 3,	Score = 20,	Coin = 40,	GoTo = 4,},
	[13] = {	Id = 13,	Content = [[进行1次冠军之塔]],	Count = 1,	Score = 15,	Coin = 30,	GoTo = 8,},
	[14] = {	Id = 14,	Content = [[进行3场竞技场战斗]],	Count = 3,	Score = 20,	Coin = 40,	GoTo = 9,},
	[15] = {	Id = 15,	Content = [[成功激活1次潜力]],	Count = 1,	Score = 15,	Coin = 30,	GoTo = 10,},
	[16] = {	Id = 16,	Content = [[赠送好友体力5次]],	Count = 5,	Score = 10,	Coin = 20,	GoTo = 18,},
	[17] = {	Id = 17,	Content = [[每天上线即可获得积分(VIP%d)]],	Count = 0,	Score = 0,	Coin = 0,	GoTo = 0,},
}

return _table
