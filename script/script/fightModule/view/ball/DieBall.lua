local Job_Images = { [0]='hei.png', [1]='zhanshi.png', [2]='tanke.png', [3]='dps.png', [4]='zhiliao.png', }

local Utils = require 'framework.helper.Utils'
local SwfActionFactory = require 'framework.swf.SwfActionFactory'

local DieBall = class(require 'BasicView')

local Ball_Drop_Data = {
	[1] = { f = 1,	p = {-314.00, 116.15},	s = {0.82, 0.83},	r = 0.00,	a = 255,	c = {255, 255, 255},	i = 'shape-2',	ar = {0.50, 0.50},	v = true },
	[2] = { f = 2,	p = {-313.90, 128.15},	s = {1.15, 1.15},	r = -51.92,	c = {249, 249, 249},	c2 = {7, 7, 7, 0} },
	[3] = { f = 3,	p = {-313.95, 139.25},	s = {1.46, 1.45},	r = -100.86,	c = {243, 243, 243},	c2 = {13, 13, 13, 0} },
	[4] = { f = 4,	p = {-313.85, 149.60},	s = {1.73, 1.74},	r = -146.11,	c = {238, 238, 238},	c2 = {18, 18, 18, 0} },
	[5] = { f = 5,	p = {-313.85, 159.05},	s = {1.99, 2.00},	r = 173.02,	c = {232, 232, 232},	c2 = {24, 24, 24, 0} },
	[6] = { f = 6,	p = {-313.85, 167.70},	s = {2.23, 2.23},	r = 135.37,	c = {228, 228, 228},	c2 = {28, 28, 28, 0} },
	[7] = { f = 7,	p = {-313.65, 175.50},	s = {2.46, 2.44},	r = 100.88,	c = {223, 223, 223},	c2 = {33, 33, 33, 0} },
	[8] = { f = 8,	p = {-313.75, 182.50},	s = {2.65, 2.63},	r = 70.27,	c = {220, 220, 220},	c2 = {36, 36, 36, 0} },
	[9] = { f = 9,	p = {-313.65, 188.75},	s = {2.81, 2.81},	r = 43.10,	c = {216, 216, 216},	c2 = {40, 40, 40, 0} },
	[10] = { f = 10,	p = {-313.55, 194.05},	s = {2.94, 2.96},	r = 19.65,	c = {213, 213, 213},	c2 = {43, 43, 43, 0} },
	[11] = { f = 11,	p = {-313.50, 198.75},	s = {3.07, 3.10},	r = 0.03,	c = {211, 211, 211},	c2 = {45, 45, 45, 0} },
	[12] = { f = 12,	p = {-313.55, 202.45},	s = {3.17, 3.19},	r = -15.90,	c = {209, 209, 209},	c2 = {47, 47, 47, 0} },
	[13] = { f = 13,	p = {-313.50, 205.25},	s = {3.25, 3.27},	r = -28.38,	c = {207, 207, 207},	c2 = {49, 49, 49, 0} },
	[14] = { f = 14,	p = {-313.50, 207.40},	s = {3.31, 3.32},	r = -37.37,	c = {206, 206, 206},	c2 = {50, 50, 50, 0} },
	[15] = { f = 15,	p = {-313.45, 208.65},	s = {3.35, 3.35},	r = -42.85,	c = {205, 205, 205},	c2 = {51, 51, 51, 0} },
	[16] = { f = 16,	p = {-313.50, 209.00},	s = {3.36, 3.36},	r = -44.62,	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[17] = { f = 17,	p = {-311.30, 208.70},	s = {3.39, 3.38},	r = -48.90,	c = {202, 202, 202},	c2 = {54, 54, 54, 0} },
	[18] = { f = 18,	p = {-304.95, 208.05},	s = {3.48, 3.46},	r = -61.98,	c = {195, 195, 195},	c2 = {61, 61, 61, 0} },
	[19] = { f = 19,	p = {-294.30, 206.90},	s = {3.63, 3.60},	r = -83.90,	c = {182, 182, 182},	c2 = {74, 74, 74, 0} },
	[20] = { f = 20,	p = {-279.60, 205.30},	s = {3.82, 3.80},	r = -114.31,	c = {164, 164, 164},	c2 = {92, 92, 92, 0} },
	[21] = { f = 21,	p = {-274.05, 204.00},	s = {3.80, 3.81},	r = -137.41,	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[22] = { f = 22,	p = {-257.80, 199.80},	s = {3.79, 3.81},	r = 153.85 },
	[23] = { f = 23,	p = {-230.60, 192.45},	s = {3.78, 3.78},	r = 37.84 },
	[24] = { f = 24,	p = {-192.25, 182.60},	s = {3.77, 3.76},	r = -123.81 },
	[25] = { f = 25,	p = {-164.25, 116.15},	s = {3.39, 3.37},	r = -105.94,	c = {177, 177, 177},	c2 = {79, 79, 79, 0} },
	[26] = { f = 26,	p = {-136.15, 49.45},	s = {3.02, 2.99},	r = -88.43,	c = {190, 190, 190},	c2 = {66, 66, 66, 0} },
	[27] = { f = 27,	p = {-108.10, -17.20},	s = {2.63, 2.61},	r = -70.54,	c = {203, 203, 203},	c2 = {53, 53, 53, 0} },
	[28] = { f = 28,	p = {-80.00, -83.80},	s = {2.24, 2.23},	r = -52.68,	c = {217, 217, 217},	c2 = {39, 39, 39, 0} },
	[29] = { f = 29,	p = {-52.00, -150.50},	s = {1.85, 1.86},	r = -35.09,	c = {230, 230, 230},	c2 = {26, 26, 26, 0} },
	[30] = { f = 30,	p = {-24.00, -217.15},	s = {1.47, 1.48},	r = -17.41,	c = {243, 243, 243},	c2 = {13, 13, 13, 0} },
	[31] = { f = 31,	p = {4.05, -283.80},	s = {1.09, 1.10},	r = 0.00,	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[32] = { f = 32,	s = {1.63, 1.65},	c = {123, 123, 123},	c2 = {133, 133, 133, 0} },
	[33] = { f = 33,	p = {4.00, -283.85},	s = {1.36, 1.38},	c = {190, 190, 190},	c2 = {67, 67, 67, 0} },
	[34] = { f = 34,	p = {4.05, -283.80},	s = {1.09, 1.10},	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
}

local adaptX = (-(1136 - require 'Global'.getWidth())/2 )*0
local offsetX = -105
adaptX = adaptX + offsetX

local Target_Position_X = { adaptX+245, adaptX+177, adaptX+109, adaptX+41, adaptX-25, adaptX-95, adaptX-163, adaptX-231 }
local Target_Position_Y = -283

function DieBall:ctor( luaset, document, ballBarView )
	-- body
	self._luaset = {}
	self._luaset[1] = AddColorNode:create()

	luaset['uiLayer_labels']:addChild(self._luaset[1], -1)

	self._ballBarView = ballBarView
end

function DieBall:show( pos )
	-- body
	-- physical
	local career = self._ballBarView:getRandomCareer()
	if career >= 0 and career <= 4 then
		local image = self._ballBarView:getImageByCareer(career)

		local index = self._ballBarView:getSize() + 1

		if index <= 8 then
			local targetPos = self._ballBarView:getTargetPositionByIndex(index)
			local action = self:getDropAction(image, pos.x, pos.y, targetPos[1], targetPos[2] )
			action:setListener(function ()
				-- body
				self:setDisposed()

				self._ballBarView:addBallByCareer(career)
			end)

			self._luaset[1]:runElfAction( action )
			return
		end
	end

	self:setDisposed()
end

function DieBall:getDropAction( image, x1,y1, x2,y2 )
	-- body
	local copyData = Utils.copyTable(Ball_Drop_Data)

	local p1x = copyData[1].p[1]
	local p1y = copyData[1].p[2]
	local p2x = copyData[#copyData].p[1]
	local p2y = copyData[#copyData].p[2]

	local scaleX = (x2 - x1)/(p2x -p1x)
	local scaleY = (y2 - y1)/(p2y -p1y)

	for i,v in ipairs(copyData) do
		if v.p then
			v.p[1] = x1 + (v.p[1]-p1x)*scaleX
			v.p[2] = y1 + (v.p[2]-p1y)*scaleY
		end

		if v.i then
			v.i = image
		end
	end

	local action = SwfActionFactory.createAction(copyData)
	return action
end

return DieBall