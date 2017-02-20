--[[
	low = 下限
high = 上限
gold = 金币
dividend  = 被除数
addnumber = 加数

--]]
local _table = {
	[1] = {	low = 0,	high = 0.0500,	gold = 2000,	dividend  = 5,	addnumber = 20,},
	[2] = {	low = 0.0500,	high = 0.0900,	gold = 4000,	dividend  = 4,	addnumber = 25,},
	[3] = {	low = 0.0900,	high = 0.1300,	gold = 6000,	dividend  = 3,	addnumber = 30,},
	[4] = {	low = 0.1300,	high = 0.1700,	gold = 8000,	dividend  = 2,	addnumber = 35,},
	[5] = {	low = 0.1700,	high = 0.2000,	gold = 10000,	dividend  = 2,	addnumber = 40,},
	[6] = {	low = 0.2000,	high = 0.2300,	gold = 11000,	dividend  = 1,	addnumber = 50,},
	[7] = {	low = 0.2300,	high = 1,	gold = 12000,	dividend  = 1,	addnumber = 60,},
}

return _table
