--[[
	color = 颜色(1绿2蓝3紫4橙5金6红)
gems = 可宝石镶嵌数量
reformconsume = 重铸重铸水晶消耗
magicconsume = 融合金币消耗
tpneeds = 突破所需装备颜色
reuseconsume = 回炉消耗钻石
mixrate = 套装概率

--]]
local _table = {
	[1] = {	color = 1,	gems = 1,	reformconsume = 1,	magicconsume = 5000,	tpneeds = {1,1,1,1,1,1,1,1},	reuseconsume = 1,	mixrate = 0,},
	[2] = {	color = 2,	gems = 1,	reformconsume = 2,	magicconsume = 200000,	tpneeds = {2,2,2,2,2,2,2,2},	reuseconsume = 2,	mixrate = 0.8000,},
	[3] = {	color = 3,	gems = 2,	reformconsume = 3,	magicconsume = 800000,	tpneeds = {2,3,3,3,3,3,3,3},	reuseconsume = 5,	mixrate = 0.7000,},
	[4] = {	color = 4,	gems = 3,	reformconsume = 4,	magicconsume = 1500000,	tpneeds = {3,4,4,4,4,4,4,4},	reuseconsume = 10,	mixrate = 0.7000,},
	[5] = {	color = 5,	gems = 3,	reformconsume = 5,	magicconsume = 4000000,	tpneeds = {4,5,5,5,5,5,5,5},	reuseconsume = 20,	mixrate = 0.7000,},
	[6] = {	color = 6,	gems = 3,	reformconsume = 6,	magicconsume = 8000000,	tpneeds = {5,6,6,6,6,6,6,6},	reuseconsume = 30,	mixrate = 0.5000,},
	[7] = {	color = 7,	gems = 3,	reformconsume = 8,	magicconsume = 0,	tpneeds = {6,7,7,7,7,7,7,7},	reuseconsume = 50,	mixrate = 0.5000,},
}

return _table
