local _table = {
	[1] = { f = 1,	p = {-286.75, 287.55},	s = {7.60, 7.60},	a = 251,	v = true },
	[2] = { f = 2,	p = {-255.60, 265.90},	s = {6.15, 6.15},	a = 252,	},
	[3] = { f = 3,	p = {-63.40, 186.95},	s = {1.81, 1.81},	a = 255,	},
	[4] = { f = 4,	p = {-69.10, 203.05},	s = {2.42, 2.42} },
	[5] = { f = 5,	p = {-64.45, 177.10},	s = {2.22, 2.22} },
	[6] = { f = 6,	p = {-74.50, 183.15} },
	[7] = { f = 9,	p = {-73.00, 194.40},	s = {2.20, 2.20},	a = 219 },
	[8] = { f = 10,	p = {-71.35, 205.55},	s = {2.17, 2.17},	a = 183 },
	[9] = { f = 11,	p = {-69.90, 216.70},	s = {2.14, 2.14},	a = 146 },
	[10] = { f = 12,	p = {-68.40, 228.10},	s = {2.11, 2.11},	a = 110 },
	[11] = { f = 13,	p = {-66.75, 239.25},	s = {2.09, 2.09},	a = 73 },
	[12] = { f = 14,	p = {-65.30, 250.35},	s = {2.06, 2.06},	a = 37 },
	[13] = { f = 15,	p = {-63.75, 261.55},	s = {2.03, 2.03},	a = 0 },
}

local offset = {74.50, -183.15}
local scaleRate = 1.7/2.03

for i,v in ipairs(_table) do
	if v.p then
		-- v.p[1] = v.p[1] + offset[1]
		-- v.p[2] = v.p[2] + offset[2]
		v.p = { 0, 0 }
	end

	if v.s then
		v.s[1] = v.s[1] * scaleRate
		v.s[2] = v.s[2] * scaleRate
	end
end

return _table 