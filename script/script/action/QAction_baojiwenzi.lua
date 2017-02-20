--[[
	id = 帧数据ID
frame = 第几帧
p = 坐标
s = 缩放
a = 透明度
rotation = 旋转
imgae = 图片
ease = 缓动

--]]
local _table = {
	[1] = {		f = 1,	p = {0,0},	s = {1,1},	a = 1},
	[2] = {		f = 2,	s = {1.6,1.6},	},
	[3] = {		f = 3,	p = {-2,-2},},
	[4] = {		f = 4,	p = {1,-5},		},
	[5] = {		f = 5,	p = {-1,-3},		},
	[6] = {		f = 6,	p = {-5,1},		},
	[7] = {		f = 7,	p = {-2,4},	},
	[8] = {		f = 8,	p = {-5,1},	},
	[9] = {		f = 9,	p = {-5,4},		a = 0.6700,},
	[10] = {	f = 10,	p = {-5,7},		a = 0.3300,	},
	[11] = {	f = 11,	p = {-5,10},	a = 0,	},
}

local offset = { 25, 25}

for i,v in ipairs(_table) do
	if v.p then
		v.p[1] = v.p[1] + offset[1]
		v.p[2] = v.p[2] + offset[2]
	end

	if v.a then
		v.a = v.a * 255
	end
end

return _table
