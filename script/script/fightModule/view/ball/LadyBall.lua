local Job_Images = { [0]='hei.png', [1]='zhanshi.png', [2]='tanke.png', [3]='dps.png', [4]='zhiliao.png', }

----- depth = 3 -----
local Ball_Data = {
	[1] = { f = 21,	p = {-440.90, -282.65},	s = {0.82, 0.83},	r = 0.00,	a = 255,	c = {255, 255, 255},	i = 'shape-3',	ar = {0.50, 0.50},	v = true },
	[2] = { f = 22,	p = {-408.70, -236.60},	s = {1.15, 1.15},	r = -51.92,	c = {249, 249, 249},	c2 = {7, 7, 7, 0} },
	[3] = { f = 23,	p = {-378.50, -193.60},	s = {1.46, 1.45},	r = -100.86,	c = {243, 243, 243},	c2 = {13, 13, 13, 0} },
	[4] = { f = 24,	p = {-350.70, -153.90},	s = {1.73, 1.74},	r = -146.11,	c = {238, 238, 238},	c2 = {18, 18, 18, 0} },
	[5] = { f = 25,	p = {-325.20, -117.35},	s = {1.99, 2.00},	r = 173.02,	c = {232, 232, 232},	c2 = {24, 24, 24, 0} },
	[6] = { f = 26,	p = {-301.85, -83.95},	s = {2.23, 2.23},	r = 135.37,	c = {228, 228, 228},	c2 = {28, 28, 28, 0} },
	[7] = { f = 27,	p = {-280.75, -53.90},	s = {2.46, 2.44},	r = 100.88,	c = {223, 223, 223},	c2 = {33, 33, 33, 0} },
	[8] = { f = 28,	p = {-261.75, -26.75},	s = {2.65, 2.63},	r = 70.27,	c = {220, 220, 220},	c2 = {36, 36, 36, 0} },
	[9] = { f = 29,	p = {-245.05, -3.00},	s = {2.81, 2.81},	r = 43.10,	c = {216, 216, 216},	c2 = {40, 40, 40, 0} },
	[10] = { f = 30,	p = {-230.60, 17.75},	s = {2.94, 2.96},	r = 19.65,	c = {213, 213, 213},	c2 = {43, 43, 43, 0} },
	[11] = { f = 31,	p = {-218.25, 35.20},	s = {3.07, 3.10},	r = 0.03,	c = {211, 211, 211},	c2 = {45, 45, 45, 0} },
	[12] = { f = 32,	p = {-208.30, 49.55},	s = {3.17, 3.19},	r = -15.90,	c = {209, 209, 209},	c2 = {47, 47, 47, 0} },
	[13] = { f = 33,	p = {-200.45, 60.65},	s = {3.25, 3.27},	r = -28.38,	c = {207, 207, 207},	c2 = {49, 49, 49, 0} },
	[14] = { f = 34,	p = {-194.85, 68.60},	s = {3.31, 3.32},	r = -37.37,	c = {206, 206, 206},	c2 = {50, 50, 50, 0} },
	[15] = { f = 35,	p = {-191.55, 73.45},	s = {3.35, 3.35},	r = -42.85,	c = {205, 205, 205},	c2 = {51, 51, 51, 0} },
	[16] = { f = 36,	p = {-190.50, 75.00},	s = {3.36, 3.36},	r = -44.62,	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[17] = { f = 37,	p = {-188.40, 75.05},	s = {3.39, 3.38},	r = -48.90,	c = {202, 202, 202},	c2 = {54, 54, 54, 0} },
	[18] = { f = 38,	p = {-182.00, 75.95},	s = {3.48, 3.46},	r = -61.98,	c = {195, 195, 195},	c2 = {61, 61, 61, 0} },
	[19] = { f = 39,	p = {-171.30, 77.30},	s = {3.63, 3.60},	r = -83.90,	c = {182, 182, 182},	c2 = {74, 74, 74, 0} },
	[20] = { f = 40,	p = {-156.60, 79.35},	s = {3.82, 3.80},	r = -114.31,	c = {164, 164, 164},	c2 = {92, 92, 92, 0} },
	[21] = { f = 41,	p = {-148.45, 72.80},	s = {3.77, 3.76},	r = -123.81,	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[22] = { f = 42,	p = {-126.60, 22.05},	s = {3.39, 3.37},	r = -105.94,	c = {177, 177, 177},	c2 = {79, 79, 79, 0} },
	[23] = { f = 43,	p = {-104.80, -28.80},	s = {3.02, 2.99},	r = -88.43,	c = {190, 190, 190},	c2 = {66, 66, 66, 0} },
	[24] = { f = 44,	p = {-83.00, -79.70},	s = {2.63, 2.61},	r = -70.54,	c = {203, 203, 203},	c2 = {53, 53, 53, 0} },
	[25] = { f = 45,	p = {-61.25, -130.50},	s = {2.24, 2.23},	r = -52.68,	c = {217, 217, 217},	c2 = {39, 39, 39, 0} },
	[26] = { f = 46,	p = {-39.55, -181.20},	s = {1.85, 1.86},	r = -35.09,	c = {230, 230, 230},	c2 = {26, 26, 26, 0} },
	[27] = { f = 47,	p = {-17.70, -232.05},	s = {1.47, 1.48},	r = -17.41,	c = {243, 243, 243},	c2 = {13, 13, 13, 0} },
	[28] = { f = 48,	p = {4.10, -282.85},	s = {1.09, 1.10},	r = 0.00,	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
	[29] = { f = 49,	s = {1.63, 1.65},	c = {123, 123, 123},	c2 = {133, 133, 133, 0} },
	[30] = { f = 50,	p = {4.10, -282.80},	s = {1.36, 1.38},	c = {190, 190, 190},	c2 = {67, 67, 67, 0} },
	[31] = { f = 51,	p = {4.10, -282.85},	s = {1.09, 1.10},	c = {255, 255, 255},	c2 = {0, 0, 0, 0} },
}


local LadyOffsetX = 140 - (1136-require 'Global'.getWidth())/2

local Utils = require 'framework.helper.Utils'
local SwfActionFactory = require 'framework.swf.SwfActionFactory'

local LadyBall = class( require 'BasicView')

function LadyBall:ctor(luaset, document, ballBarView)
	-- body
	self._ballBarView = ballBarView

	self._luaset = self:createLuaSet(document, '@LadyBall')

	self._luaset['layer'] 	= luaset['layer']
	self._luaset['uiLayer'] = luaset['uiLayer']
	self._luaset['uiLayer_labels'] = luaset['uiLayer_labels']

	local root = self._luaset[1]
	
	self._ballNode = AddColorNode:create()
	self._luaset['root_Qiu']:addChild(self._ballNode)

	local suc = self:setNewBall()
	if suc then
		self._luaset['uiLayer_labels']:addChild(root, -1)
	end

	self._luaset['button']:setListener(function ()
		-- body
		self:trigger()
	end)
end

function LadyBall:setNewBall()
	-- body
	if not self._triggered then
		local RolePlayerManager = require 'RolePlayerManager'

		local ownPlayerDict = RolePlayerManager.getOwnPlayerMapSorted()

		local map = {}
		local array = {}

		for i,role in ipairs(ownPlayerDict) do
			if not role:isDead() then
				local career = role.roleDyVo.career
				-- if not map[career] then
				-- 	map[career] = 
				-- end
				table.insert(array, career)
			end
		end

		if #array > 0 then
			local index = math.random(1, #array)
			self._career = array[index]
			self._image = Job_Images[self._career]

			-- print('self._career = '..self._career)
			-- print('self._image = '..self._image)

			self._ballNode:setResid( self._image )
			
			self:runWithDelay(function ()
				self:setNewBall()
			end, 0.1)

			return true
		end
	end

	return false
end

function LadyBall:show( func )
	-- body
	if self._luaset and not tolua.isnull( self._luaset[1] ) then
		local root = self._luaset[1]
		local action = CCMoveBy:create(6, ccp(LadyOffsetX,0))
		root:runElfAction( action )
	end
end

function LadyBall:trigger()
	-- body
	if not self._triggered then

		local targetIndex = self._ballBarView:getSize() + 1
		self:hide()

		if targetIndex <= 8 then
			local pos = NodeHelper:getPositionInScreen(self._ballNode)
			self._ballNode:retain()
			self._ballNode:removeFromParent()

			self._luaset['uiLayer_labels']:addChild(self._ballNode)
			self._ballNode:release()

			NodeHelper:setPositionInScreen(self._ballNode, pos)

			local x,y = self._ballNode:getPosition()

			local targetPos = self._ballBarView:getTargetPositionByIndex(targetIndex)

			local action = self:getDropAction(self._image, x, y, targetPos[1], targetPos[2])
			action:setListener(function ()
				-- body
				self._ballNode:removeFromParent()
				self._ballBarView:addBallByCareer(self._career)

			end)
			self._ballNode:runElfAction(action)
		end
	end
end

function LadyBall:hide()
	-- body
	if not self._triggered then
		self._triggered = true

		local root = self._luaset[1]
		if not tolua.isnull(root) then
			local a = CCFadeOut:create(0.5)
			local elfactoin = ElfAction:create( a )
			elfactoin:setListener(function ()
				-- body
				self:setDisposed()
			end)

			root:runElfAction( elfactoin )
		end
	end
end

function LadyBall:getDropAction( image, startX, startY, endX, endY )
	-- body
	local copyData = Utils.copyTable(Ball_Data)

	local p1x = copyData[1].p[1] 
	local p1y = copyData[1].p[2] 

	local p2x = copyData[#copyData].p[1] 
	local p2y = copyData[#copyData].p[2] 

	local scaleX = (endX-startX)/(p2x-p1x)
	-- local scaleY = ((p2y==p1y) and 1) or (endY-startY)/(p2y-p1y)
	-- print('scaleY='..scaleY)

	for i,v in ipairs(copyData) do
		if v.p then
			v.p[1] = startX + (v.p[1]-p1x) * scaleX
			-- v.p[2] = startY + (v.p[2]-p1y) * scaleY
		end

		if v.i then
			v.i = image
		end
	end

	local action = SwfActionFactory.createAction( copyData, nil, nil, nil, Ball_Data[1].f, Ball_Data[#Ball_Data].f )
	return action
end

return LadyBall