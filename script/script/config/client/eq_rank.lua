--[[
	rank = 品级(1凡2良3优4绝5极)
low = 成长百分比下限
high = 成长百分比上限
up = 改造提升概率
down = 改造下降概率

--]]
local _table = {
	[1] = {	rank = 1,	low = 0,	high = 0.2000,	up = 0.9000,	down = 0.1000,},
	[2] = {	rank = 2,	low = 0.2000,	high = 0.4000,	up = 0.8000,	down = 0.2000,},
	[3] = {	rank = 3,	low = 0.4000,	high = 0.6000,	up = 0.7000,	down = 0.3000,},
	[4] = {	rank = 4,	low = 0.6000,	high = 0.8000,	up = 0.6800,	down = 0.3200,},
	[5] = {	rank = 5,	low = 0.8000,	high = 1,	up = 0.6800,	down = 0.3200,},
}

return _table
