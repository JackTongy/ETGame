--[[
	lv = 等级
title = 称号
honor = 荣誉
args = 可活动战场荣誉([A,B] A：基数 B：固定值)

--]]
local _table = {
	[1] = {	lv = 1,	title = [[初生牛犊]],	honor = 100,	args = {0.1,10},},
	[2] = {	lv = 2,	title = [[草丛捉虫]],	honor = 1000,	args = {0.15,20},},
	[3] = {	lv = 3,	title = [[林中探险]],	honor = 5000,	args = {0.2,30},},
	[4] = {	lv = 4,	title = [[勇闯道馆]],	honor = 10000,	args = {0.25,40},},
	[5] = {	lv = 5,	title = [[保卫伙伴]],	honor = 20000,	args = {0.3,50},},
	[6] = {	lv = 6,	title = [[决战火箭]],	honor = 40000,	args = {0.35,60},},
	[7] = {	lv = 7,	title = [[乘风破浪]],	honor = 80000,	args = {0.4,70},},
	[8] = {	lv = 8,	title = [[探索遗迹]],	honor = 160000,	args = {0.45,80},},
	[9] = {	lv = 9,	title = [[磨砺锋刃]],	honor = 300000,	args = {0.5,90},},
	[10] = {	lv = 10,	title = [[冠军之路]],	honor = 600000,	args = {0.55,100},},
	[11] = {	lv = 11,	title = [[挑战联盟]],	honor = 1200000,	args = {0.6,110},},
	[12] = {	lv = 12,	title = [[征战天王]],	honor = 2400000,	args = {0.65,120},},
	[13] = {	lv = 13,	title = [[联盟王者]],	honor = 4800000,	args = {0.7,130},},
}

return _table
