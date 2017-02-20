-- local _table = {}

-- _table.array = {}
-- ----- depth = 2 -----
-- _table.array[1] = {
-- 	[1] = { f = 1, v = false},
-- 	[2] = { f = 7,	p = {112.50, 8.50},	s = {0.85, 1.20},	r = 0.00,	a = 26,	c = {255, 255, 255},	ar = {0.50, 0.50},	v = true },
-- 	[3] = { f = 8,	p = {144.70, 8.50},	s = {0.84, 0.92},	a = 199 },
-- 	[4] = { f = 9,	p = {155.40, 8.50},	s = {0.83, 0.83},	a = 255 },
-- 	[5] = { f = 10,	s = {0.85, 0.85} },
-- 	[6] = { f = 11,	s = {0.88, 0.88} },
-- 	[7] = { f = 12,	s = {0.90, 0.90} },
-- 	[8] = { f = 13,	s = {0.92, 0.92} },
-- 	[9] = { f = 14,	p = {155.40, 8.65},	a = 242 },
-- 	[10] = { f = 15,	p = {155.40, 9.00},	s = {0.90, 0.90},	a = 199 },
-- 	[11] = { f = 16,	p = {155.40, 9.65},	s = {0.87, 0.87},	a = 127 },
-- 	[12] = { f = 17,	p = {155.40, 10.55},	s = {0.83, 0.83},	a = 26 },
-- 	[13] = { f = 18,	v = false },
-- }

-- ----- depth = 3 -----
-- _table.array[2] = {
-- 	[1] = { f = 1,	p = {153.30, 4.65},	s = {1.00, 1.00},	r = 0.00,	a = 0,	c = {255, 255, 255},	ar = {0.50, 0.50},	v = false },
-- 	[2] = { f = 2,	s = {0.85, 0.77}, },
-- 	[3] = { f = 3,	s = {0.69, 0.54} },
-- 	[4] = { f = 4,	s = {0.54, 0.31} },
-- 	[5] = { f = 5,	s = {0.39, 0.08},	a = 0,	v = true },
-- 	[6] = { f = 6,	s = {0.56, 0.29},	a = 28 },
-- 	[7] = { f = 7,	s = {1.06, 0.91},	a = 114 },
-- 	[8] = { f = 8,	s = {1.90, 1.94},	a = 255 },
-- 	[9] = { f = 9,	s = {1.00, 1.00} },
-- 	[10] = { f = 10,	s = {1.14, 1.14} },
-- 	[11] = { f = 11,	s = {1.20, 1.20} },
-- 	[12] = { f = 12,	p = {153.30, 4.70},	s = {1.26, 1.26} },
-- 	[13] = { f = 13,	p = {153.30, 4.65},	s = {1.33, 1.33} },
-- 	[14] = { f = 14,	p = {153.30, 4.95},	a = 254 },
-- 	[15] = { f = 15,	p = {153.30, 5.85},	s = {1.32, 1.32},	a = 250 },
-- 	[16] = { f = 16,	p = {153.35, 7.40},	a = 242 },
-- 	[17] = { f = 17,	p = {153.30, 9.50},	s = {1.31, 1.31},	a = 230 },
-- 	[18] = { f = 18,	p = {153.30, 12.25},	s = {1.30, 1.30},	a = 216 },
-- 	[19] = { f = 19,	p = {153.35, 15.55},	s = {1.29, 1.29},	a = 199 },
-- 	[20] = { f = 20,	p = {153.35, 19.45},	s = {1.27, 1.27},	a = 178 },
-- 	[21] = { f = 21,	p = {153.35, 24.05},	s = {1.25, 1.25},	a = 154 },
-- 	[22] = { f = 22,	p = {153.30, 29.25},	s = {1.23, 1.23},	a = 127 },
-- 	[23] = { f = 23,	p = {153.30, 35.00},	s = {1.21, 1.21},	a = 96 },
-- 	[24] = { f = 24,	p = {153.35, 41.35},	s = {1.19, 1.19},	a = 63 },
-- 	[25] = { f = 25,	p = {153.30, 48.35},	s = {1.16, 1.16},	a = 26 },
-- 	[26] = { f = 26,	p = {153.30, 4.65},	s = {1.00, 1.00},	a = 0 },
-- }


-- --to fix offset problem
-- local offsetX = -133.30
-- local offsetY = 50

-- for i,array in ipairs(_table.array) do
-- 	for ii, vv in ipairs(array) do
-- 		if vv.p then
-- 			vv.p[1] = vv.p[1] + offsetX
-- 			vv.p[2] = vv.p[2] + offsetY
-- 		end
-- 	end
-- end




-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------


-- local LabelView = class( require 'AbsView' )

-- local Swf = require 'framework.swf.Swf'
-- local SwfActionFactory = require 'framework.swf.SwfActionFactory'
-- local LabelUtils = require 'LabelUtils'

-- local ViewCache = require 'ViewCache'.new()

-- --[[
-- 异常文字
-- LabelUtils.Label_BaoJi 		= '@BaoJiWenZi'
-- LabelUtils.Label_DongJie 	= '@DongJieWenZi'
-- LabelUtils.Label_HuanShu 	= '@HuanSuWenZi'
-- LabelUtils.Label_HunMi 		= '@HunMiWenZi'
-- LabelUtils.Label_MianYi 	= '@MianYiWenZi'
-- LabelUtils.Label_ZhiMang 	= '@ZhiMangWenZi'
-- LabelUtils.Label_ZhongDu 	= '@ZhongDuWenZi'
-- --]]

-- local ActionCache = {}
-- ActionCache[1] = SwfActionFactory.createAction(_table.array[1])
-- ActionCache[2] = SwfActionFactory.createAction(_table.array[2])

-- ActionCache[1]:retain()
-- ActionCache[2]:retain()

-- local ResMap = {
-- 	[LabelUtils.Label_MianYi] 	= { 'ZD_skill1.png', 'ZD_skill1s.png' } ,
-- 	[LabelUtils.Label_ZhiMang] 	= { 'ZD_skill2.png', 'ZD_skill2s.png' } ,
-- 	[LabelUtils.Label_DongJie] 	= { 'ZD_skill3.png', 'ZD_skill3s.png' } ,
-- 	[LabelUtils.Label_BaoJi] 	= { 'ZD_skill4.png', 'ZD_skill4s.png' } ,
-- 	[LabelUtils.Label_HuanShu] 	= { 'ZD_skill5.png', 'ZD_skill5s.png' } ,
-- 	[LabelUtils.Label_HunMi] 	= { 'ZD_skill6.png', 'ZD_skill6s.png' } ,
-- 	[LabelUtils.Label_ZhongDu] 	= { 'ZD_skill7.png', 'ZD_skill7s.png' } ,
-- }


-- function LabelView:ctor( label )
-- 	-- body
-- 	self:setXmlName('LabelSet')
-- 	self:setXmlGroup('Fight')

-- 	-- print(label)
-- 	self._key = label

-- 	local pic2 = ResMap[label]

-- 	assert(pic2, 'No '..tostring(label))

-- 	local root = ElfNode:create()

-- 	local bg = ElfNode:create()
-- 	bg:setResid( pic2[2] )
-- 	-- bg:setResid( 'LabelBg.png' )
-- 	bg:setVisible(false)
-- 	-- bg:setScale(1)
-- 	root:addChild(bg)

-- 	local labelNode = ElfNode:create()
-- 	labelNode:setResid( pic2[1] )
-- 	-- labelNode:setResid( 'BaoJiWenZi.png' )

-- 	labelNode:setVisible(false)
-- 	-- labelNode:setScale(1)
-- 	root:addChild(labelNode)

-- 	self._luaset = { [1] = root, bg = bg,  labelNode = labelNode }

-- 	local action1 = ActionCache[1]:clone()
-- 	local action2 = ActionCache[2]:clone()

-- 	action2:setListener(function ()
-- 		-- body
-- 		ViewCache:recycle(self)

-- 		root:removeFromParent()
-- 	end)

-- 	self._luaset['bg']:runAction(action1)
-- 	self._luaset['labelNode']:runAction(action2)

-- end

-- function LabelView:getKey()
-- 	-- body
-- 	return self._key
-- end

-- function LabelView:reset(label)
-- 	-- body

-- 	self._luaset['bg']:setVisible(false)
-- 	self._luaset['labelNode']:setVisible(false)

-- 	local action1 = ActionCache[1]:clone()
-- 	local action2 = ActionCache[2]:clone()

-- 	action2:setListener(function ()
-- 		-- body
-- 		ViewCache:recycle(self)

-- 		self._luaset[1]:removeFromParent()
-- 	end)

-- 	self._luaset['bg']:runAction(action1)
-- 	self._luaset['labelNode']:runAction(action2)
-- end

-- local function createLabelView( label )
-- 	-- body
-- 	local view = ViewCache:getCache( label )
-- 	if view then
-- 		view:reset(label)
-- 		return view
-- 	else
-- 		assert(false)
-- 		return LabelView.new( label ) 
-- 	end
-- end

-- local function clean()
-- 	-- body
-- 	ViewCache:clean()
-- end  

-- local function initViewCache()
-- 	-- body
-- 	ViewCache:setCreator(function ( label )
-- 		-- body
-- 		return LabelView.new( label ) 
-- 	end)

-- 	for i=1, 16 do
-- 		ViewCache:createCache(LabelUtils.Label_BaoJi)
-- 	end
-- end

-- initViewCache()

-- return { createLabelView = createLabelView, clean = clean }