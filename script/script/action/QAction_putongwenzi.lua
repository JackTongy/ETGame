--[[
	id = 帧数据ID
f = 第几帧
p = 坐标
s = 缩放
a = 透明度
rotation = 旋转
imgae = 图片
ease = 缓动

--]]
-- local _table = {
-- 	[1] = {	id = 1,	f = 1,	p = {0,0},	s = {1,1},	a = 1,	rotation = 0,	ease = 0,},
-- 	[2] = {	id = 2,	f = 2,	p = {0,0},	s = {1,1},	a = 1,	rotation = 0,	ease = 0,},
-- 	[3] = {	id = 3,	f = 3,	p = {0,1},	s = {1,1},	a = 1,	rotation = 0,	ease = 0,},
-- 	[4] = {	id = 4,	f = 4,	p = {0,3},	s = {1,1},	a = 1,	rotation = 0,	ease = 0,},
-- 	[5] = {	id = 5,	f = 5,	p = {0,4},	s = {1,1},	a = 1,	rotation = 0,	ease = 0,},
-- 	[6] = {	id = 6,	f = 6,	p = {0,5},	s = {1,1},	a = 1,	rotation = 0,	ease = 0,},
-- 	[7] = {	id = 7,	f = 7,	p = {0,6},	s = {1,1},	a = 1,	rotation = 0,	ease = 0,},
-- 	[8] = {	id = 8,	f = 8,	p = {0,7},	s = {1,1},	a = 1,	rotation = 0,	ease = 0,},
-- 	[9] = {	id = 9,	f = 9,	p = {0,10},	s = {1,1},	a = 0.8000,	rotation = 0,	ease = 0,},
-- 	[10] = {	id = 10,	f = 10,	p = {0,13},	s = {1,1},	a = 0.6000,	rotation = 0,	ease = 0,},
-- 	[11] = {	id = 11,	f = 11,	p = {0,16},	s = {1,1},	a = 0.4000,	rotation = 0,	ease = 0,},
-- 	[12] = {	id = 12,	f = 12,	p = {0,19},	s = {1,1},	a = 0.2000,	rotation = 0,	ease = 0,},
-- 	[13] = {	id = 13,	f = 13,	p = {0,22},	s = {1,1},	a = 0,	rotation = 0,	ease = 0,},
-- }

local _table = {
	[1] = {		f = 1,	p = {0,0},	a = 1,	},
	[2] = {		f = 2,	},
	[3] = {		f = 3,	p = {0,1},	},
	[4] = {		f = 4,	p = {0,3},	},
	[5] = {		f = 5,	p = {0,4},	},
	[6] = {		f = 6,	p = {0,5},	},
	[7] = {		f = 7,	p = {0,6},	},
	[8] = {		f = 8,	p = {0,7},	},
	[9] = {		f = 9,	p = {0,10},	a = 0.8000,	},
	[10] = {	f = 10,	p = {0,13},	a = 0.6000,	},
	[11] = {	f = 11,	p = {0,16},	a = 0.4000,	},
	[12] = {	f = 12,	p = {0,19},	a = 0.2000,	},
	[13] = {	f = 13,	p = {0,22},	a = 0,	},
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
